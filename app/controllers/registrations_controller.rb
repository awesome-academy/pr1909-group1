class RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    update_resource_new
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        message = find_message(:"signed_up_but_#{resource.inactive_message}")
        expire_data_after_sign_in!
        respond_to do |format|
          format.html{ redirect_to after_inactive_sign_up_path_for(resource), notice: message }
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to :html,:js
    end
  end

  def update_resource_new
    user = User.find_by email: params[:user][:email]
    return unless user
    object = user.user_type.classify.constantize.new user_id: user.id
    object.save
  end
end
