$(document).on("input", ".input-lesson-name", function () {
  $(this).closest(".card").find(".lesson-name-collapse").text($(this).val());
})

$(window).on("turbolinks:load", function () {
  $(".edit-collapse").each(function () {
    $(this).closest(".card").find(".card-body").first().slideUp();
  })
  $(".prev-lesson").each(function () {
    $(this).text($(this).closest(".card").find(".input-lesson-name").val());
  })
})

$(document).on("click", ".edit-collapse, .btn-collapse, .lesson-name-collapse", function () {
  quiz = $(this).closest(".card").find(".quiz-form");
  video = $(this).closest(".card").find(".card-body").first();
  lesson_type = $(this).closest(".card").find(".video").is(":checked");
  $(this).closest(".header-lesson").find(".btn-collapse").toggleClass("fa-angle-double-down fa-angle-double-up");
  if (!lesson_type && $(quiz).is(":visible")) {
    quiz.slideUp();
    video.slideUp();
  } else if(!lesson_type && $(quiz).is(":hidden")){
    quiz.slideDown();
    video.slideDown();
  } else if(lesson_type && $(video).is(":visible")){
    video.slideUp();
    quiz.hide();
  } else if(lesson_type && $(video).is(":hidden")){
    video.slideDown();
    quiz.hide();
  }
})
