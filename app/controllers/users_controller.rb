class UsersController < ApplicationController
  before_action :get_user, only: [:show, :destroy]
  before_action :authenticate_user!
  before_action :check_authorization, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @courses = Course.joins(:registers).
      where(registers: { user_id: @user.id }).
      paginate(page: params[:page], per_page: Settings.per_page)
    @registers = @user.registers
    respond_to do |format|
      format.html
      format.js
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_user
    @user = User.find_by(id: params[:id])
  end

  def check_authorization
    unless authorization
      flash[:notice] = t('devise.permission')
      redirect_to root_url
    end
  end

  def authorization
    (current_user.id == @user.id) || current_user.is_admin?
  end
end
