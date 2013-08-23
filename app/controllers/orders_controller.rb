class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
 
    course = Course.find(params[:course_id])
    @order = course.orders.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @user=current_user
    @order = Order.new(params[:order])
    
    if @order.save
      send_info(@order)
      invitation_email(@order)
      redirect_to search_url, :notice => "Thank you for purchasing!"
    else
      render :new
    end
  end
  

  
  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
  
  private
  
    def send_info order
      UserMailer.send_info('info@mentorhip.com', order.email, order.course.user.email, order.course.user, order.course).deliver      
      
      if user_signed_in?    
        UserMailer.send_info('info@mentorhip.com', current_user.email, nil, order.course.user, order.course).deliver
      end
    end
    
    def invitation_email order
      if user_signed_in?      
        if User.find_by_email(order.email).nil?
          UserMailer.invitation_email('info@mentorhip.com' , order.email, current_user).deliver
        end
      end
    end

end
