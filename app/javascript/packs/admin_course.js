alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
var question_box, lesson_box;
$(window).on("turbolinks:load", function(){
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();
  $(".remove-answer").hide();
  $(".remove-question").hide();
  $(".remove-lesson").hide();
  lesson_box = $("#sortable").first().html();
  question_box = $(".quiz-form").find(".list").first().html();
  answer = $(".btn-add-option").closest($(".quiz-element")).find(".list-answer").last().html();
});

$(document).on("click", ".btn-add-question", function () {
  number_lesson = $("#sortable .lesson-box").length;
  number_question = $(this).closest(".quiz-form").find(".quiz-element").length;
  console.log(question_box)
  question_element = $(question_box);
  var parent = "<div class='quiz-element list-question'></div>";
  change_name(question_element, number_lesson - 1, number_question, 0);
  $(this).closest($(".quiz-form")).find($(".list")).last().append(parent);
  $(this).closest($(".quiz-form")).find($(".quiz-element")).last().append(question_element.html());
  $(".remove-question").show();
});

$(document).on("click", ".btn-add-lesson", function () {
  var number_lesson = $("#sortable .lesson-box").length;
  var parent = "<div class='lesson-box lesson-field ui-sortable-handle'></div>"
  new_box = $(lesson_box);
  new_box.find(".radio-lesson-type").attr("name", "course[lessons_attributes][" + number_lesson + "][lesson_type]")
  new_box.find(".input-lesson-name").attr("name", "course[lessons_attributes][" + number_lesson + "][lesson_name]")
  new_box.find(".input-video-url").attr("name", "course[lessons_attributes][" + number_lesson + "][video_url]");
  new_box.find(".lesson_seq").attr("name", "course[lessons_attributes][" + number_lesson + "][lesson_sequence]")
  change_name(new_box, number_lesson, 0, 0);
  var input_video = new_box.find(".input-video-url");
  var quiz_form = new_box.find(".quiz-form");
  lesson_type = new_box.find(".radio-lesson-type").val();
  if (lesson_type == "2") {
    input_video.prop("disabled", true);
    quiz_form.show()
  }else if(lesson_type == "1"){
    input_video.prop("disabled", false);
    quiz_form.hide()
  }
  new_box.find(".lesson_seq").val(number_lesson +1);
  $("#sortable").append(parent);
  $("#sortable .lesson-box").last().append(new_box.html())
  $(".remove-lesson").show();
});

$(document).on("click", ".remove-answer", function () {
  var parent =  $(this).closest($(".list-answer"));
  $(this).closest($(".input-choice")).remove();
  parent.find((".input-choice")).last().find(".row").last().append('<div class="btn btn-danger remove-answer">×</div>');
  if (parent.find(".input-choice").length == 1) {
    parent.find(".remove-answer").hide();
  }
});

$(document).on("click", ".remove-question", function () {
  parent = $(this).closest(".list");
  $(this).closest(".quiz-element").remove();
  if (parent.find(".quiz-element").length == 1) {
    parent.find(".remove-question").hide();
  }
});

$(document).on("click", ".remove-lesson", function () {
  parent = $(this).closest("#sortable");
  $(this).closest(".lesson-box").remove();
  if (parent.find(".lesson-box").length == 1) {
    parent.find(".remove-lesson").hide();
  }
});

$(document).on("click", ".btn-add-option", function () {
  var parent = "<div class='input-choice'></div>";
  quiz = $(this).closest($(".quiz-element"));
  label_answer = $(this).closest($(".quiz-element")).find(".label-option").last().text();
  ans = $(answer);
  number_answer = quiz.find(".input-choice").length
  number_lesson = $("#sortable .lesson-box").length;
  number_question = $(this).closest(".quiz-form").find(".quiz-element").length;
  change_name(ans, number_lesson - 1, number_question - 1, number_answer);
  quiz.find(".remove-answer").remove();
  quiz.find(".list-answer").append(parent);
  quiz.find(".input-choice").last().append(ans.html());
  next_label = alphabet[alphabet.indexOf(label_answer) + 1]
  quiz.find(".label-option").last().text(next_label);
  quiz.find(".label_choice").last().val(next_label);
  quiz.find(".input-choice .remove-answer").show();
});

function change_name(select, number_lesson, number_question, number_answer) {
  select.find(".input-answer").attr("name", "course[lessons_attributes][" + number_lesson
    + "][quiz_questions_attributes][" + number_question + "][quiz_choice][" + number_answer + "][text]");
  select.find(".correct-answer").attr("name", "course[lessons_attributes][" + number_lesson
    + "][quiz_questions_attributes][" + number_question + "][quiz_choice][" + number_answer + "][is_answer]");
  select.find(".label_choice").attr("name", "course[lessons_attributes][" + number_lesson
    + "][quiz_questions_attributes][" + number_question + "][quiz_choice][" + number_answer + "][label]");
  select.find(".input-question").attr("name", "course[lessons_attributes][" + number_lesson
    + "][quiz_questions_attributes][" + number_question + "][quiz_question]");
}

$(document).on("click", ".btn-submit-course", function () {
  $("#sortable").find(".lesson-box").each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
    console.log($(this));
    console.log(index);
  })
  $(".form-new-course").submit()
})
