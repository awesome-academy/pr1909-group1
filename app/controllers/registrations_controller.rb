class RegistrationsController < Devise::RegistrationsController
  def create
    super
    update_resource_new
  end

  def update_resource_new
    user = User.find_by email: params[:user][:email]
    return unless user
    object = user.user_type.classify.constantize.new user_id: user.id
    object.save
  end
end
