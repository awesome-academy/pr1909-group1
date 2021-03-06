class Admin::CoursesController < Admin::BaseController
  before_action :get_course, only: [:show, :edit, :update, :destroy]
  before_action :get_course_type, only: [:new, :edit]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.search(params[:query], operator: "or", fields: [:course_title, :course_type],
                                             match: :word_start, highlight: { tag: "<mark>" },
                                             page: params[:page], per_page: Settings.search.per_page)
    if @courses.results.blank?
      @courses = Course.all.paginate(page: params[:page], per_page: Settings.search.per_page).order(created_at: :desc)
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @lessons = @course.lessons
    @course_type = @course.course_type.course_type
    @review_courses = @course.review_courses.order('created_at DESC').
      paginate(page: params[:comment_page], per_page: Settings.comment.per_page)
    @registers = @course.registers.order('created_at DESC').
      paginate(page: params[:register_page], per_page: Settings.register.per_page)
  end

  # GET /courses/new
  def new
    @course = Course.new
    @lesson = @course.lessons.build
    @questions = @course.lessons.first.quiz_questions.build
  end

  # GET /courses/1/edit
  def edit
    @registers = @course.registers
    @lessons = @course.lessons.sort_by(&:lesson_sequence)
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_courses_path, notice: t("noti.created") }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to admin_courses_path, notice: t("noti.updated") }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_path, notice: t("noti.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def get_course
    @course = Course.find(params[:id])
  end

  def get_course_type
    @course_types = CourseType.all
    @course_types_view = @course_types.pluck(:course_type, :id).to_h
  end

  # Only allow a list of trusted parameters through.
  def course_params
    params.require(:course).permit!
  end

  def only_for_admin
    redirect_to root_url unless current_user.is_admin?
  end
end
