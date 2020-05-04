class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_authorization, only: [:edit, :update]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all.paginate(page: params[:page], per_page: Settings.perpage)
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
    @job_posts = @employer.job_posts.paginate(page: params[:page], per_page: Settings.per_page)
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
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
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
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
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
      format.html { redirect_to employers_url, notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_employer
    @employer = Employer.find(params[:id])
  end

  def employer_params
    params.require(:employer).permit(:user_id, :company_logo, :company_name, :company_size, :company_description,
                                     user_attributes: [:id, :first_name, :last_name])
  end

  def check_authorization
    unless current_user.id == @employer.user_id
      flash[:notice] = "You don't have permission to edit this page"
      redirect_to root_url
    end
  end
end
