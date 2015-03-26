#= require ../js/jquery-1.8.2.min.js
#= require ../js/bootstrap.min.js

g = exports ? this
g.proceed = false

$(->
  $('[data-toggle=popover]').popover()
  $('#title').focus()

  user = $('#username').val()
  $.getJSON("/#{user}.json", (data) ->
    $('#username').val(data.username)
    $('#email').val(data.email)
    $('#profile').fadeIn()
  )

  $('#confirm').blur(->
    $('#confirm_error').remove() 
    if $('#password').val() != $('#confirm').val()
      $('#password, #confirm').parent().addClass('has-error')
      $('#confirm').parent().after('<div id="confirm_error" class="alert alert-danger">Passwords don\'t match</div>')
    else
      $('#password, #confirm').parent().removeClass('has-error')
  )

  $('#profile').submit(->
    $('#profile .form-control').blur()
    if $('#profile .has-error').length > 0
      $('#profile .has-error').effect('shake', 500)
      return false
  )
)
