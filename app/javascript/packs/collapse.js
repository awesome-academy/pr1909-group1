$(document).on("input", ".input-lesson-name", function () {
  $(this).closest(".card").find(".lesson-name-collapse").text($(this).val());
  // body...
})

$(document).on("click", ".lesson-name-collapse", function () {
  quiz = $(this).closest(".card").find(".quiz-form");
  video = $(this).closest(".card").find(".card-body").first();
  if ($(quiz).is(":visible") || $(video).is(":visible")) {
    quiz.slideUp();
    video.slideUp();
  } else {
    video.slideDown();
    quiz.slideDown();
  }
})
