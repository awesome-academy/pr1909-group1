class RegistersController < ApplicationController
  before_action :login_before_register

  def create
    @course = Course.find params[:course_id]
    @register = Register.create(course_id: params[:course_id], user_id: current_user.id)
    respond_to do |format|
      format.js
      @course = Course.find params[:course_id]
      @course_registers = @course.total_registers_count
      @registers = @course.registers.order('created_at DESC')
    end
  end

  def login_before_register
    unless signed_in?
      redirect_to :new_user_session
      flash[:alert] = t("alert.need_login")
    end
  end
end
