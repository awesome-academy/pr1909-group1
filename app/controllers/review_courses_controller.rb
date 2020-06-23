class ReviewCoursesController < ApplicationController
  before_action :get_review_course, only: [:edit, :update, :destroy]
  def create
    @review_course = ReviewCourse.new review_params
    if @review_course.save
      respond_to do |format|
        format.html { redirect_to @review_course }
        format.js { render layout: false }
      end
    else
      redirect_to root_path
    end
  end

  def edit
    @review_course = ReviewCourse.find_by(id: params[:id])
    respond_to do |format|
      format.html { redirect_to @review_course }
      format.js { render layout: false }
    end
  end

  def update
    @course = @review_course.course
    respond_to do |format|
      if @review_course.update(review_params)
        format.html
        format.js { render layout: false }
      end
    end
  end

  def destroy
    @review_course.destroy
    respond_to do |format|
      format.html { redirect_to review_courses_url, notice: 'Product was successfully destroyed.' }
      format.js { render layout: false }
    end
  end

  private

  def review_params
    params.require(:review_course).permit(:user_id, :course_id, :comment)
  end

  def get_review_course
    @review_course = ReviewCourse.find_by(id: params[:id])
  end
end
