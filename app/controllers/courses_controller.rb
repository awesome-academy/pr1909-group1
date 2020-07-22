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
    @review_courses = @course.review_courses.order('created_at DESC').
      paginate(page: params[:comment_page], per_page: Settings.comment.per_page)
    @registers = @course.registers.order('created_at DESC').
      paginate(page: params[:register_page], per_page: Settings.register.per_page)
    @register = @registers.find_by(course_id: @course.id, user_id: current_user.id) if current_user
    @lessons = @course.lessons.order('lesson_sequence ASC')
    lesson_step = @register.lesson_step if @register
    @lessons_locked = @lessons.where("lesson_sequence > ?", lesson_step)
    @lessons_unlock = @lessons.where("lesson_sequence <= ?", lesson_step)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def get_course
    @course = Course.find_by(id: params[:id])
  end

  def get_course_type
    @course_types = CourseType.all
    @course_types_view = @course_types.pluck(:course_type, :id).to_h
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
