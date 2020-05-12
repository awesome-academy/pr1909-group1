$(window).on("turbolinks:load", function () {
  $(document).on("input","#user_email", function () {
    email_regex = /^([a-zA-Z0-9_\.])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    $('.user_email').append('<div id="errors-message"></div>')
    color_message = "red"
    message = "invalid email"
    if (email_regex.test(this.value)) {
      color_message = "green"
      message = "email is valid"
    }
    $("#errors-message").css("color",color_message)
    $("#errors-message").html(message)
  } )
})
