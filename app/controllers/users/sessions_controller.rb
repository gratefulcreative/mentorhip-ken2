class Users::SessionsController < Devise::SessionsController
  
  def create
    respond_to do |format|
      format.html{ super }
      format.json do
       resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
       return sign_in_and_redirect(resource_name, resource)
      end
    end
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    if(resource.promo_code.nil?)
      resource.create_unique_token
    end    
    respond_to do |format|
      format.json {render :json => {:success => true, :user => resource }}
      format.html {redirect_to root_url}
    end
  end

  def failure
    respond_to do |format|
      format.json { render:json => {:success => false, :errors => ["Login failed."]} }
    end
  end
end

