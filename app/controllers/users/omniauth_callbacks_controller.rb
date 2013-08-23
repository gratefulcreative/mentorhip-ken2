class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    puts "===in here ominouth"
    #puts "=== Request ===> #{request.env["omniauth.auth"].inspect} "
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    
    if @user.persisted?      
      respond_to do |format|
        format.json {render :json => {:success => true, :user => @user}}
        format.html do
          sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        end  
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      respond_to do |format|
          format.json {render :json => {:success => true, :user => @user}}
          format.html {redirect_to new_user_registration_url}
      end     
    end
  end
end
