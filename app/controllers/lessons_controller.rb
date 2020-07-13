class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find params[:id]
    @register = Register.find_by(course_id: @lesson.course_id, user_id: current_user.id)
    @result = QuizResult.find_by(user_id: current_user.id, lesson_id: @lesson.id)
    @quizzes = @lesson.quiz_questions
    @max_point = @quizzes.length
    respond_to do |format|
      format.js
    end
  end
end
