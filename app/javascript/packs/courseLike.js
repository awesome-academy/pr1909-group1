$(window).on("turbolinks:load", function () {
  $(".course-like").on("click", function () {
    var course_id = $(this).data("id");

    $.ajax ({
      url: "/course/like/"+course_id,
      method: "GET"
    }).done(function (response) {
        // console.log(response);
      })
  })
});
