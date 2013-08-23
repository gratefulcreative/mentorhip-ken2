class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :search_bar

  
  def authorize_loggedin 
    render :template => "sessions/restricted" if current_user.nil?
  end
  
  
  protected

  def search_bar
    @q = User.search(params[:q])
  end
end
