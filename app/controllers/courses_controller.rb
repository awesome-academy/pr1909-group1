class CoursesController < ApplicationController
  before_action :get_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :only_for_admin, except: [:show, :index]
  before_action :get_course_type, only: [:new, :edit]

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

  def get_course_type
    @course_types = CourseType.all
    @course_types_view = Hash[@course_types.pluck(:course_type).zip(@course_types.pluck(:id))]
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit(:course_title, :course_overview, :course_description, :course_type_id,
                                   :course_image, :overview_video_url)
  end

  def only_for_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
