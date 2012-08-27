#encodeing: utf-8
class SessionsController < Devise::SessionsController

  #点击登录，弹出登录窗口使用js
  def new
    resource = build_resource(:unsafe => true)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource)) do |format|
      format.js
    end
  end
  
  #
  def create
    resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
  
 protected

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  def auth_options
    { :scope => resource_name, :recall => "#{controller_path}#new" }
  end
    
end
