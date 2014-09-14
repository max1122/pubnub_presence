monitor = ->
  $.ajax
    url: "status_monitor"
    success: (users) ->
      $(".user-list").html("")
      append user for user in users

    complete: ->
      setTimeout monitor, 5000

append = (user) ->
  msg = "<li><img width='58' height='58' src='/assets/presence-user-blue.png'><div class='content'><h6>" + user.email + "</h6><small>" + user.status + "</small></div></li>"
  $(".user-list").append(msg)


$ -> monitor()