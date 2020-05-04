class CandidatesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_candidate, except: [:new, :index, :created]
  before_action :check_authorization, only: [:edit, :update]

  # GET /candidates
  # GET /candidates.json
  def index
    return @candidates = Candidate.all.paginate(page: params[:page], per_page: Settings.per_page) if current_user.admin?
    redirect_to root_path
    flash[:notice] = "You don't have permission to show this page"
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
    # is it ok to create candidate like this? Actually, we create user first.
  end

  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates
  # POST /candidates.json
  def create
    respond_to do |format|
      if @candidate.save
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1
  # PATCH/PUT /candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1
  # DELETE /candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:user_id, :date_of_birth, :phone, :avatar, :cv,
                                      user_attributes: [:id, :first_name, :last_name])
  end

  def check_authorization
    unless current_user.id == @candidate.user_id
      flash[:notice] = "You don't have permission to edit this page"
      redirect_to root_url
    end
  end
end
