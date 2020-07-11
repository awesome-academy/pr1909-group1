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
  answer = $(question_box).find(".list-answer").last().html();
});

$(document).on("click", ".btn-add-question", function () {
  number_lesson = $("#sortable .lesson-box").length;
  number_question = $(this).closest(".quiz-form").find(".quiz-element").length;
  question_element = $(question_box);
  name = $(this).closest(".quiz-form").find(".input-question").first().attr("name");
  question_element.find("input").each(function () {
    $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0, $(this).attr("name").indexOf("]", 56)),
      name.substring(0, name.indexOf("[", 54)) + "[" + number_question))
  })
  var parent = "<div class='quiz-element list-question'></div>";
  $(this).closest(".quiz-form").find(".list").last().append(parent);
  $(this).closest(".quiz-form").find(".quiz-element").last().append(question_element.html());
  $(this).closest(".quiz-form").find(".remove-question").show();
});

$(document).on("click", ".btn-add-lesson", function () {
  var number_lesson = $("#sortable .lesson-box").length;
  var parent = "<div class='lesson-box lesson-field ui-sortable-handle'></div>"
  new_box = $(lesson_box);
  addLesson(new_box, number_lesson, 0, 0);
  var input_video = new_box.find(".input-video-url");
  var quiz_form = new_box.find(".quiz-form");
  lesson_type = new_box.find(".radio-lesson-type").val();
  if (lesson_type == "quiz") {
    input_video.prop("disabled", true);
    quiz_form.show()
  }else if(lesson_type == "video"){
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
  number_question = parent.find(".quiz-element").length;
  replaceQuestion(parent.find("input[name*='[quiz_questions_attributes][" + (number_question - 1) + "']"),
    $(this).closest(".quiz-element").find(".input-question"), number_question)
  $(this).closest(".quiz-element").remove();
  if (parent.find(".quiz-element").length == 1) {
    parent.find(".remove-question").hide();
  }
});

$(document).on("click", ".remove-lesson", function () {
  parent = $(this).closest("#sortable");
  number_lesson = $("#sortable .lesson-box").length;
  replaceLesson($("input[name^='course[lessons_attributes][" + (number_lesson - 1) + "']"),
    $(this).closest(".lesson-box").find(".input-video-url") )
  $(this).closest(".lesson-box").remove();
  if (parent.find(".lesson-box").length == 1) {
    parent.find(".remove-lesson").hide();
  }
});

$(document).on("click", ".btn-add-option", function () {
  ans = $(answer)
  var parent = "<div class='input-choice'></div>";
  quiz = $(this).closest($(".quiz-element"));
  name = quiz.find(".label_choice").attr("name");
  label_answer = $(this).closest($(".quiz-element")).find(".label-option").last().text();
  number_answer = quiz.find(".input-choice").length
  number_lesson = $("#sortable .lesson-box").length;
  number_question = $(this).closest(".quiz-form").find(".quiz-element").length;
  ans.find("input").each(function () {
    $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 72)),
      name.substring(0,name.indexOf('[', 70)) + "[" + number_answer));
  })
  quiz.find(".remove-answer").remove();
  quiz.find(".list-answer").append(parent);
  quiz.find(".input-choice").last().append(ans.html());
  next_label = alphabet[alphabet.indexOf(label_answer) + 1]
  quiz.find(".label-option").last().text(next_label);
  quiz.find(".label_choice").last().val(next_label);
  quiz.find(".input-choice .remove-answer").show();
});

$(document).on("click", ".btn-submit-course", function () {
  $("#sortable").find(".lesson-box").each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(".form-new-course").submit()
})

function replaceLesson(selector, current_lesson) {
  number_lesson = $("#sortable .lesson-box").length - 1;
  name = current_lesson.attr("name")
  selector.each(function () {
    $(this).attr("name", $(this).attr("name")
      .replace("course[lessons_attributes][" + number_lesson, name.substring(0,name.indexOf(']', 26))));
  })
}

function replaceQuestion(renamed_question, current_question, number_question) {
  name = current_question.attr("name");
  renamed_question.each(function () {
    $(this).attr("name", $(this).attr("name").replace("[quiz_questions_attributes][" + (number_question - 1),
      name.substring(29, name.indexOf("]", 56))))
  })
}

function addLesson(lesson, number_lesson, number_question, number_answer) {
  lesson.find("input").each(function () {
    if ($(this).attr("name").includes("course[lessons_attributes]")) {
      $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 26)),
      "course[lessons_attributes][" + number_lesson));
    }
  })
}
