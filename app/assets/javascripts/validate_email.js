$(window).on("turbolinks:load", function () {
  $(document).on("input","#user_email", function () {
    email_regex = /^([a-zA-Z0-9_\.])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/
    $('.user_email').append('<div id="errors-message"></div>')
    error_element = document.getElementById("errors-message")
    if (!email_regex.test(this.value)) {
      error_element.style.color = "red"
      error_element.innerHTML = "invalid email";
    }else{
      error_element.style.color = "green"
      error_element.innerHTML = "email is valid";
    }
  } )
})
