class CoursesController < ApplicationController
  before_filter :authorize_loggedin, :except => ["show"]
  before_filter :load_course, except: [:index, :new, :create, :show]

  def index
    @courses = current_user.courses
  end

  def show
    @course = Course.find(params[:id])
    @coursetimes = @course.coursetimes
    @json = @course.user.to_gmaps4rails
    
    #send_info
    #invitation_email
  end

  def new
    @course = Course.new
  end

  def edit
  
  end

  def create
    @course = current_user.courses.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private

  def load_course
    @course = current_user.courses.find(params[:id]) 
  end
  
  def send_info
    if user_signed_in?    
      content= "#{current_user.firstname} has just visited your #{@course}"
      UserMailer.sent('info@mentorhip.com', current_user.email, "Project update" ,content ).deliver
    end
  end
  
  def invitation_email
    if user_signed_in?
      content= "#{current_user.firstname} Please register this #{@course}"
      UserMailer.sent(@course.user.email, current_user.email, "Project update" ,content ).deliver
    end
  end
end
