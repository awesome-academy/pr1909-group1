$(window).on("turbolinks:load", function(){
  $('.btn-search').click(function () {
    if ($(window).height() <= 768) {
      $('body,html').animate({
        scrollTop: 400 }, 400);
    } else {
      $('body,html').animate({
        scrollTop: 600 }, 500);
    };
    return false;
  });
});
