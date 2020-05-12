$(window).on("turbolinks:load", function () {
  $(document).on("input","#user_email", function () {
    email_regex = /^([a-zA-Z0-9_\.])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    $('.user_email').append('<div id="errors-message"></div>')
    color_message = email_regex.test(this.value) ? "green" : "red";
    message = email_regex.test(this.value) ? "email is valid" : "invalid format email"
    $("#errors-message").css("color",color_message)
    $("#errors-message").html(message)
  } )
})
