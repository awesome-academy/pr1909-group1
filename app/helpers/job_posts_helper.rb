module JobPostsHelper
  def authenticate_employer(job_post)
    return unless is_employer?
    current_user.employer.id == job_post.employer.id
  end

  def is_employer?
    return unless current_user
    current_user.employer?
  end

  def current_user_type
    return unless signed_in?
    current_user.user_type
  end

  def apply_job
    case current_user_type
    when nil
      render "apply_not_login"
    when "employer"

    when "candidate"
      render "apply_form"
    end
  end
end
