class ApplyActivitiesController < ApplicationController
  before_action :login_before_apply, only: :create
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

  def login_before_apply
    unless signed_in?
      redirect_to :new_user_session
    end
  end
end
