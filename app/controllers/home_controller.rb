class HomeController < ApplicationController
  def index
    @courses = Course.all.paginate(page: params[:page], per_page: Settings.search.per_page)
    @number_students = User.not_admin.count
    @number_video = Lesson.where(lesson_type: :video).count
    @number_quiz = Lesson.where(lesson_type: :quiz).count
  end

  def about
  end
end
