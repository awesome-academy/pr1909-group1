class LikesController < ApplicationController
  def create
    @like = Like.new(course_id: params[:course_id], user_id: current_user.id)
    @course_id = params[:course_id]
    @existing_like = Like.where(course_id: params[:course_id], user_id: current_user.id)

    respond_to do |format|
      format.js {
        if @existing_like.any?
          @existing_like.first.destroy
          @success = false
        elsif @like.save
          @success = true
        else
          @success = false
        end
        @course_likes = Course.find(@course_id).total_likes_count
        render "courses/like"
      }
    end
  end
end
