class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_breadcrumbs
  layout "admin/admin_index"

  def index
    @count_user = User.count
    @count_user_created_at_today = User.created(Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).count
    @count_courses = Course.count
    @count_registers = Register.count
    @count_user_registed = Register.group(:user_id).pluck(:user_id).count

    # check
    # @sum_lesson = Register.group(:user_id).sum(:lesson_step)
    @sum_lesson = Register.select("user_id, sum(lesson_step)").group(:user_id).order("sum(lesson_step) DESC").limit(3)
  end

  def range
    @count_range = User.group(:provider).
      group_by_day(:created_at, range: params[:first_day].to_date..params[:last_day].to_date).count
    respond_to do |format|
      format.js
    end
  end

  protected

  def add_breadcrumbs(label, path = {})
    @breadcrumbs << {
      label: label,
      path: path,
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  private

  def check_admin
    unless current_user.is_admin?
      redirect_to root_path
      flash[:alert] = "You cannot access this page"
    end
  end
end
