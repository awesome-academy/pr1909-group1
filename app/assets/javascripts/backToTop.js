$(window).on("turbolinks:load", function(){
  $(this).scroll(function () {
    if ($(this).scrollTop() > 50) {
        $('.back-to-top').fadeIn();
    } else {
        $('.back-to-top').fadeOut();
    }
  });
  // scroll body to 0px on click
  $('.back-to-top').click(function () {
    $(this).tooltip('hide');
    $('body,html').animate({
      scrollTop: 0 
    }, 700);
      return false;
  });
  
  $('.back-to-top').tooltip('show');

});
