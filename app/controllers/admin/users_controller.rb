class Admin::UsersController < Admin::BaseController
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).not_admin.paginate(page: params[:page], per_page: Settings.per_page)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: t("noti.created") }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: t("noti.updated") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: t("noti.destroyed") }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def get_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:full_name, :email, :password, :confirmed_at, :avatar)
  end
end
