class Admin::ChartsController < ApplicationController
  before_action :users_provider

  def all_users_provider
    render json: @user_provider.count.chart_json
  end

  def users_registered_by_day
    render json: @user_provider.created_at_today.count.chart_json
  end

  def users_by_week
    render json: @user_provider.group_by_day_of_week(:created_at, week_start: :monday, format: "%a").count.chart_json
  end

  def users_by_month
    render json: @user_provider.group_by_day_of_month(:created_at, format: "%d").count.chart_json
  end

  def users_by_year
    render json: @user_provider.group_by_month_of_year(:created_at, format: "%B").count.chart_json
  end

  def users_registered_course
    render json: Register.group(:course_id).count
  end

  def users_registered_course_type
    render json: Course.joins(:registers, :course_type).group("course_types.course_type").
      distinct.count("registers.user_id").chart_json
  end

  private

  def users_provider
    @user_provider = User.group(:provider)
  end
end
