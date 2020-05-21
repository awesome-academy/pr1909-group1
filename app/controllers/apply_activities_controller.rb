class ApplyActivitiesController < ApplicationController
  before_action :login_before_apply, only: :create
  before_action :get_job_post, only: [:review, :mark, :process_interview, :reject]

  def index
    @apply_activities = ApplyActivity.includes(:candidate).where(apply_activities: { job_post_id: params[:post_id] }).
      paginate(page: params[:page], per_page: Settings.per_page)
  end

  def create
    @job_post = JobPost.find params[:job_post_id]
    current_user.candidate.apply @job_post
    respond_to do |format|
      format.html { redirect_to @job_post }
      format.js
    end
  end

  def destroy
    application = ApplyActivity.find params[:id]
    application.destroy
    @job_post = JobPost.find application.job_post_id
    respond_to do |format|
      format.html { redirect_to @job_post }
      format.js
    end
  end

  def review
    @apply_activity.review!
    respond_to do |format|
      format.html { redirect_to @job_post }
    end
  end

  def mark
    test_mark = params[:apply_activity][:test_marks].to_i
    @apply_activity.mark test_mark
    @apply_activity.update test_marks: test_mark
    respond_to do |format|
      format.html { redirect_to @job_post }
    end
  end

  def process_interview
    @apply_activity.process_interview!
    respond_to do |format|
      format.html { redirect_to @job_post }
    end
  end

  def reject
    @apply_activity.reject!
    respond_to do |format|
      format.html { redirect_to @job_post }
    end
  end

  def login_before_apply
    unless signed_in?
      redirect_to :new_user_session
    end
  end

  private

  def get_job_post
    @apply_activity = ApplyActivity.find params[:id]
    job_post_id = ApplyActivity.find_by(id: params[:id]).job_post_id
    @job_post = JobPost.find_by id: job_post_id
  end
end
