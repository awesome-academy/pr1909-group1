$(window).on("turbolinks:load", function () {
  $('.pagination a, .paginate-register a, .paginate-comment a').attr('data-remote', 'true');
});
