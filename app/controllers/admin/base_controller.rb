class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  layout "admin/admin_index"

  def index
    @count_user = User.count
    @count_user_created_at_today = User.created_at_today.count
    @count_courses = Course.count
    @count_registers = Register.count
    @count_user_registed = Register.group(:user_id).pluck(:user_id).count
  end

  private

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
      flash[:alert] = "You cannot access this page"
    end
  end
end
