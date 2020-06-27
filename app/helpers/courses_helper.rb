module CoursesHelper
  def is_admin?
    return unless current_user
    current_user.is_admin?
  end

  def course_liked_by_user?(course_id)
    return unless user_signed_in?
    Like.where(course_id: course_id, user_id: current_user.id).discarded.exists?
  end

  def course_registered_by_user?(course_id)
    return unless user_signed_in?
    Register.where(course_id: course_id, user_id: current_user.id).exists?
  end
end
