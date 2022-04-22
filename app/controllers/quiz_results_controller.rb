class QuizResultsController < ApplicationController
  def create
    @current_test = Lesson.find(params[:lesson_id])
    @quizzes = @current_test.quiz_questions
    @max_point = @quizzes.length
    @register = Register.find_by user_id: current_user.id, course_id: @current_test.course.id
    @result = QuizResult.new(lesson_id: params[:lesson_id], user_id: current_user.id)
    @point = 0
    @lesson = Lesson.find_by(course_id: @current_test.course.id, lesson_sequence: @register.lesson_step + 1)
    unless params[:user_answer].nil?
      params[:user_answer].each do |answer|
        quiz = @quizzes.find_by(id: answer.first.to_i).quiz_choice.values
        correct_answer = quiz.select { |ans| ans["is_answer"] == "1" }.pluck("label")
        @point += 1 if correct_answer == answer.last
      end
    end
    @result.mark = @point
    respond_to do |format|
      if @point >= @current_test.min_point
        @result.save && (@register.update(lesson_step: @register.lesson_step + 1) if @lesson)
        @lesson ||= @current_test
        format.html
        format.js
      else
        format.html
        format.js { render "_fail" }
      end
    end
  end
end
