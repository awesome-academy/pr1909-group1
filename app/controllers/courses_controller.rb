class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: Settings.per_page)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find_by(id: params[:id])
  end
end
