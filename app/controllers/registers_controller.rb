class RegistersController < ApplicationController
  before_action :login_before_register

  def create
    @register = Register.create(course_id: params[:course_id], user_id: current_user.id)
    @course = Course.find params[:course_id]
    @registers = @course.registers.order('created_at DESC')
    respond_to do |format|
      format.js
    end
  end

  def login_before_register
    unless signed_in?
      redirect_to :new_user_session
      flash[:alert] = t("alert.need_login")
    end
  end
end
