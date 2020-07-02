$(document).on("change", ".radio-lesson-type", function () {
  var input_video = $(this).closest(".card").find(".input-video-url");
  var quiz_form = $(this).closest(".card").find(".quiz-form");
  if ($(this).val() == "2") {
    input_video.prop("disabled", true);
    input_video.val("");
    quiz_form.show()
  }else if($(this).val() == "1"){
    input_video.prop("disabled", false);
    quiz_form.find("input").each(function () {
      $(this).val("");
    })
    quiz_form.hide()
  }
});

$(window).on("turbolinks:load", function () {
  var input_video = $(document).find(".input-video-url");
  var quiz_form = $(document).find(".quiz-form");
  if ($(".radio-lesson-type").val() == "2") {
    input_video.prop("disabled", true);
    quiz_form.show()
  }else if($(".radio-lesson-type").val() == "1"){
    input_video.prop("disabled", false);
    quiz_form.hide()
  }
  // body...
})
