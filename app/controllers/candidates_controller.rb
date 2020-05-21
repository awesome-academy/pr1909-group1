class CandidatesController < ApplicationController
  before_action :check_not_deleted, only: [:show, :edit]
  before_action :authenticate_user!
  before_action :get_candidate, except: [:new, :index, :created]
  before_action :check_authorization, only: [:edit, :update]
  before_action :show_permission, only: [:show]

  # GET /candidates
  # GET /candidates.json
  def index
    return @candidates = Candidate.all.paginate(page: params[:page], per_page: Settings.per_page) if current_user.admin?
    redirect_to root_path
    flash[:notice] = t('devise.user.permission_show')
  end

  # GET /candidates/1
  # GET /candidates/1.json
  def show
    @job_posts = JobPost.joins("INNER JOIN apply_activities ON job_posts.id = apply_activities.job_post_id").
      where(apply_activities: { candidate_id: @candidate.id }).
      paginate(page: params[:page], per_page: Settings.per_page)
    @apply_activities = @candidate.apply_activities
    respond_to do |format|
      format.html
      format.js
    end
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
        format.html { redirect_to @candidate, notice: t('candidate.created.flash') }
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
        format.html { redirect_to @candidate, notice: t('candidate.updated.flash') }
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
      format.html { redirect_to candidates_url, notice: t('candidate.destroyed.flash') }
      format.json { head :no_content }
    end
  end

  private

  def get_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:user_id, :date_of_birth, :phone, :avatar, :cv, :profession,
                                      :website, user_attributes: [:id, :first_name, :last_name])
  end

  def check_authorization
    unless authorization
      flash[:notice] = t('devise.user.permission_edit')
      redirect_to root_url
    end
  end

  def show_permission
    if !(employer_permission || authorization || current_user.admin?)
      redirect_to root_url
      flash[:notice] = t('devise.user.permission_show')
    end
  end

  def employer_permission
    if is_employer?
      ApplyActivity.exists?(candidate_id: @candidate.id, employer_id: current_user.employer.id)
    end
  end

  def authorization
    current_user.id == @candidate.user_id
  end
end
