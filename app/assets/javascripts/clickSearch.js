$(window).on("turbolinks:load", function(){
  $('#link-job-type div').click( function() {
    var valueType = $(this).index() + 1;
    $(".select-type").val(valueType);
    $(".select-location").val("");
    $('.submit-search').submit();
  });

  $('#link-job-location div').click( function() {
    var valueLocation = $(this).index() + 1;
    $(".select-location").val(valueLocation);
    $(".select-type").val("");
    $('.submit-search').submit();
  });

  $('.list-filter li').click(function () {
    $('body,html').animate({
      scrollTop: 400
      }, 400 );
  });
});
