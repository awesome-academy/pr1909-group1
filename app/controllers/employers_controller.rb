class EmployersController < ApplicationController
  before_action :check_not_deleted, only: [:show, :edit]
  before_action :get_employer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_authorization, only: [:edit, :update]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all.paginate(page: params[:page], per_page: Settings.per_page)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
    if current_user.present? && (current_user.id == @employer.user_id || current_user.admin?)
      @job_posts = @employer.job_posts.
        paginate(page: params[:page], per_page: Settings.per_page).order(job_status: :asc)
    else
      @job_posts = @employer.job_posts.accepted.
        paginate(page: params[:page], per_page: Settings.per_page).order(job_status: :asc)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  # POST /employers.json
  def create
    @employer = Employer.new(employer_params)
    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, notice: t('employer.created.flash') }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employers/1
  # PATCH/PUT /employers/1.json
  def update
    respond_to do |format|
      if @employer.update(employer_params)
        format.html { redirect_to @employer, notice: t('employer.updated.flash') }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employers/1
  # DELETE /employers/1.json
  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to employers_url, notice: t('employer.destroyed.flash') }
      format.json { head :no_content }
    end
  end

  private

  def get_employer
    @employer = Employer.find_by(id: params[:id])
  end

  def employer_params
    params.require(:employer).permit(:user_id, :company_logo, :company_name, :company_size, :company_description,
                                     user_attributes: [:id, :first_name, :last_name])
  end

  def check_authorization
    unless current_user.id == @employer.user_id
      flash[:notice] = t('devise.user.permission_edit')
      redirect_to root_url
    end
  end
end
