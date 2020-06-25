class LikesController < ApplicationController
  def save_like
    @like = Like.find_or_create_by(course_id: params[:course_id], user_id: current_user.id)
    @like.discarded? ? @like.undiscard : @like.discard
    respond_to do |format|
      format.js do
        @success = @like.discarded?
        @course_id = params[:course_id]
        @course_likes = Course.find(@course_id).total_likes_count
      end
    end
  end
end
