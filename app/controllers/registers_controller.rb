class RegistersController < ApplicationController
  before_action :login_before_register

  def create
    @register = Register.create(course_id: params[:course_id], user_id: current_user.id)
    @course = Course.find params[:course_id]
    @registers = @course.registers.order('created_at DESC')
    redirect_to @course
  end

  def login_before_register
    unless signed_in?
      redirect_to :new_user_session
      flash[:alert] = t("alert.need_login")
    end
  end

  def update
    @register = Register.find_by id: params[:id]
    @lesson = Lesson.find_by(course_id: @register.course_id, lesson_sequence: params[:register][:lesson_step])
    @quizzes = @lesson.quiz_questions
    @register.update registers_params
    respond_to do |format|
      if @register.save
        format.js { @lesson = Lesson.find_by course_id: @register.course_id, lesson_sequence: @register.lesson_step }
      end
    end
  end

  private

  def registers_params
    params.require(:register).permit(:lesson_step)
  end
end
