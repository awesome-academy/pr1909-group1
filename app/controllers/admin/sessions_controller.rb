class Admin::SessionsController < Devise::SessionsController
  layout "layouts/admin/admin_login"

  # def new
  # end

  def create
    @user = User.where("is_admin", true).find_by(email: params[:user][:email])
    if @user && @user.is_admin?
      super
    else
      flash[:alert] = t("noti.email_incorrect")
      redirect_to admin_login_path
    end
  end

  def after_sign_in_path_for(resource)
    admin_url
  end

  def after_sign_out_path_for(resource)
    admin_login_path
  end
end
