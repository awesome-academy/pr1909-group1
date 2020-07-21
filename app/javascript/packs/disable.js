$(document).on("change", ".radio-lesson-type", function () {
  var input_video = $(this).closest(".card").find(".input-video-url");
  var quiz_form = $(this).closest(".card").find(".quiz-form");
  if ($(this).val() == "quiz") {
    input_video.prop("disabled", true);
    input_video.val("");
    if ($(this).closest(".card").find(".input-lesson-name").is(":visible")) {
      quiz_form.show();
    }
  }else if($(this).val() == "video"){
    input_video.prop("disabled", false);
    quiz_form.find("input").each(function () {
      $(this).val("");
    })
    quiz_form.hide()
  }
});

$(window).on("turbolinks:load", function () {
  $(document).find(".quiz-form").hide();
  var items_locked = $(".lesson-locked .lesson-item")
  items_locked.prop("disabled", true);
  $(".radio-lesson-type").each(function () {
    if ($(this).closest(".card-header").find(".quiz").is(":checked")) {
      $(this).closest(".card").find(".input-video-url").prop("disabled", true);
    }
  })
})
