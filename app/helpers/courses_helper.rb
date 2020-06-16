module CoursesHelper
  def is_admin?
    return unless current_user
    current_user.is_admin?
  end
end
