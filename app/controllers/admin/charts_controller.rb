class Admin::ChartsController < ApplicationController
  before_action :users_provider

  def all_users_provider
    render json: @user_provider.count.chart_json
  end

  def users_registered_by
    created(params[:period], params[:start_time], params[:end_time], params[:format])
  end

  def users_registered_course
    render json: Register.group(:course_id).count
  end

  def users_registered_course_type
    render json: Course.joins(:registers, :course_type).group("course_types.course_type").
      distinct.count("registers.user_id").chart_json
  end

  private

  def created(period, start_time, end_time, format)
    render json: @user_provider.send(
      "group_by_#{period}", :created_at, range: start_time.to_date..end_time.to_date, format: format
    ).count.chart_json
  end

  def users_provider
    @user_provider = User.group(:provider)
  end
end
