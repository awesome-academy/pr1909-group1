$(window).on("turbolinks:load", function () {
  $('#datetimepicker').datetimepicker({
    locale: 'en',
    format: "DD/MM/YYYY"
  });
});
