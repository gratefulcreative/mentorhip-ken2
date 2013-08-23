class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    #user = User.find(:all, :conditions => "details_type = 'Company' OR 'Individual'")

    @city = request.location.city
    if params[:city].present?
      @city = params[:city]
    end

    if params[:within].present? && (params[:within].to_i > 0)
      @q = User.where('details_type in (?,?) and approved in (\'1\',\'t\')', 'Company','Individual').near(@city, params[:within]).search(params[:q]) 
      @query = params[:q][:topics_cont]
    elsif params[:city].present?
      @q = User.where('details_type in (?,?) and approved in (\'1\',\'t\')', 'Company','Individual').near(@city, 100).search(params[:q]) 
      @query = params[:q][:topics_cont]
    elsif params[:sort_by].present?
      @q = User.order("#{params[:sort_by]} DESC").where('details_type in (?,?) and approved in (\'1\',\'t\')', 'Company','Individual').search(params[:q])
    else
      @q = User.where('details_type in (?,?) and approved in (\'1\',\'t\') ', 'Company','Individual').search(params[:q])	  
    end
   
    #@q = @q.all(:conditions => "details_type = 'Company' OR 'Individual'")
    @users = @q.result(:distinct => true).page(params[:page]).per(20)

    @json = @users.to_gmaps4rails
    @featured = User.featured

  end

  # def compindex
  #  if params[:q].present?
  #    @companies = Company.near(params[:q], 50, :order => :distance)
  #  else
  #    @companies = Company.all
  #  end
  # end


  def search
    index
    render :index
  end
  
  # GET /users/1
  # GET /users/1.json
  def show

    @user = User.find(params[:id])
    @json = @user.to_gmaps4rails
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
	  format.json { render json: @user.courses }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @details = @user.details
    
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        #UserMailer.registration_confirmation(@user).deliver
        cookies[:user_token] = {:value => @user.token}
        format.html { redirect_to users_chooseType_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def chooseType
  end
  def verifyemail
    @user = User.find_by_token(params[:user_token])
    @user.emailverified = true
    @user.save
    format.html { redirect_to edit_user_path(@user), notice: 'Email was successfully verified' }
    format.json { head :no_content }
  end
  
  def choseType
    @type = params[:commit]
    @user = current_user
    if (@type == "Service Provider")
      @user.details = Company.new
      @user.save
    elsif (@type == "Individual")
      @user.details = Individual.new
      @user.save
    elsif (@type == "Parent/Student")
      @user.details = Purchaser.new
      @user.save
    end
    redirect_to edit_user_path(@user)
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_without_password(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def rate
	@user = User.find(params[:id])
    @user.rate(params[:stars], current_user, params[:dimension])
    render :update do |page|
      page.replace_html @user.wrapper_dom_id(params), ratings_for(@user, params.merge(:wrap => false))
      page.visual_effect :highlight, @user.wrapper_dom_id(params)
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  
   
   
end
