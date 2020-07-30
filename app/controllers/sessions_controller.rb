class SessionsController < Devise::SessionsController
  def new
    @course_id = params[:course_id]
    super
  end
end
