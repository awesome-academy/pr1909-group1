alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
var question_box, lesson_box;
$(window).on("turbolinks:load", function(){
  $( "#sortable" ).sortable();
  $( "#sortable" ).disableSelection();
  $(".remove-answer").hide();
  $(".remove-question").hide();
  if ($("#sortable .lesson-box").length == 1) {
    $(".remove-lesson").hide();
  }
  lesson_box = $("#sortable").first().html();
  question_box = $(".quiz-form").find(".list .quiz-element").first().html();
  answer = $(question_box).find(".input-choice").last().html();
  add_remove_answer_btn($(".list-answer"));
});

function add_remove_answer_btn(selector) {
  selector.each(function () {
    $(this).find(".edit-answer").last().find(".row").last()
      .append('<div class="btn btn-danger btn-remove-answer" data-toggle="modal" data-taget="#confirm-delete-answer">×</div>');
  })
  $(".btn-remove-answer").show();
}

$(document).on("click", ".btn-add-question", function () {
  parent = "<div class='quiz-element list-question'></div>";
  quiz = $(this).closest(".quiz-form").find(".quiz-element");
  number_question = quiz.length;
  question_element = $(question_box);
  name = $(this).closest(".quiz-form").find(".input-question").first().attr("name");
  change_name_question(question_element, number_question);
  $(this).closest(".quiz-form").find(".list").append(parent);
  $(this).closest(".quiz-form").find(".quiz-element").last().append(question_element);
  $(this).closest(".quiz-form").find(".quiz-element").last().find(".edit-answer").last().find(".row").last()
    .append('<div class="btn btn-danger btn-remove-answer" data-toggle="modal" data-taget="#confirm-delete-answer">×</div>');
  $(this).closest(".quiz-form").find(".remove-question").show();
});

function change_name_question(question, number_question) {
  question.find("input").each(function () {
    $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0, $(this).attr("name").indexOf("]", 56)),
      name.substring(0, name.indexOf("[", 54)) + "[" + number_question));
    if ($(this).attr("type") == "text") {
      $(this).val("");
    } else if ($(this).attr("type") == "checkbox") {
      $(this).removeAttr("checked");
    }
  });
  question = question.html();
}
$(document).on("click", ".btn-add-lesson", function () {
  new_box = $(lesson_box);
  addLesson(new_box);
});

$(document).on("click", ".btn-new-lesson", function () {
  new_box = $("#sortable .lesson-box").first().html();
  quiz_length = $(new_box).find(".quiz-element").length;
  question = $(".quiz-form").find(".list .quiz-element").first();
  new_box = $(new_box);
  if(quiz_length == 0) {
    new_box.find(".list").append("<div class='quiz-element list-question'></div>");
    new_box.find(".quiz-element").append(question.html());
    new_box.find(".btn-remove-answer").show();
  } else{
    for (var i = 2*quiz_length - 1; i > 0 ; i--) {
      $(new_box.find(".list").children()[i]).remove();
    }
  }
  new_box.find(".prev-lesson").text("");
  addLesson(new_box);
})

$(document).on("click", ".remove-answer", function () {
  remove_btn = '<div class="btn btn-danger remove-answer">×</div>';
  remove_answer($(this), remove_btn);
});

$(document).on("click", ".btn-remove-answer", function () {
  var remove_btn = '<div class="btn btn-danger btn-remove-answer">×</div>';
  remove_answer($(this), remove_btn);
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

$(document).on("click", ".btn-add-option, .edit-btn-add-answer", function () {
  ans = $(answer)
  var parent = "<div class='input-choice'></div>";
  quiz = $(this).closest($(".quiz-element"));
  name = quiz.find(".label_choice").attr("name");
  label_answer = $(this).closest($(".quiz-element")).find(".label-option").last().text();
  number_answer = quiz.find(".input-choice").length
  number_question = $(this).closest(".quiz-form").find(".quiz-element").length;
  ans.find("input").each(function () {
    $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 72)),
      name.substring(0,name.indexOf('[', 70)) + "[" + number_answer));
    if ($(this).attr("type") == "text") {
      $(this).val("");
    } else if ($(this).attr("type") == "checkbox") {
      $(this).removeAttr("checked");
    }
  }).html();
  quiz.find(".remove-answer").remove();
  quiz.find(".list-answer").append(parent);
  quiz.find(".input-choice").last().append(ans);
  next_label = alphabet[alphabet.indexOf(label_answer) + 1]
  quiz.find(".label-option").last().text(next_label);
  quiz.find(".label_choice").last().val(next_label);
  quiz.find(".input-choice .remove-answer").show();
});

$(document).on("click", ".edit-btn-add-answer", function () {
  $(this).closest($(".quiz-element")).find(".btn-remove-answer").remove();
  $(this).closest($(".quiz-element")).find(".input-choice").last().find(".row").last()
    .append('<div class="btn btn-danger btn-remove-answer">×</div>');
})

$(document).on("click", ".btn-submit-course", function () {
  $("#sortable").find(".lesson-box").each(function (index) {
    $(this).find(".lesson_seq").val(index + 1);
  })
  $(".form-course").submit()
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

function change_name_lesson(lesson, number_lesson, number_question, number_answer) {
  lesson.find("input").each(function () {
    if ($(this).attr("name").includes("course[lessons_attributes]")) {
      $(this).attr("name", $(this).attr("name").replace($(this).attr("name").substring(0,$(this).attr("name").indexOf(']', 26)),
      "course[lessons_attributes][" + number_lesson));
    }
    if ($(this).attr("type") == "text") {
      $(this).val("");
    } else if ($(this).attr("type") == "checkbox") {
      $(this).removeAttr("checked");
    }
  })
  lesson = lesson.html();
}

function remove_answer(selector, remove_btn) {
  var parent =  selector.closest($(".list-answer"));
  selector.closest($(".input-choice")).remove();
  parent.find((".input-choice")).last().find(".row").last().append(remove_btn);
  if (parent.find(".input-choice").length == 1) {
    parent.find(".remove-answer").hide();
  }
}

function addLesson(new_box) {
  var number_lesson = $("#sortable .lesson-box").length;
  var parent = "<div class='lesson-box lesson-field ui-sortable-handle'></div>"
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
  change_name_lesson(new_box, number_lesson, 0, 0);
  $("#sortable").append(parent);
  $("#sortable .lesson-box").last().append(new_box);
  $(".remove-lesson").show();
}
