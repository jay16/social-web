class RegistrationsController < Devise::RegistrationsController

  def new
    resource = build_resource({})
    respond_with resource do |format|
      format.js
    end
  end
  
  # GET /resource/edit
  def edit
    render :edit
  end


end
