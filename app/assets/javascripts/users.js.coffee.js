monitor = ->
  $.ajax
    url: "status_monitor"
    success: (users) ->
      console.log(users)
      $(".user-list").clear()
      append user for user in users

append = (user) ->
  msg = "<li><div class='content'><h6></h6><small>Offline</small></div></li>"
  $(".user-list").append(msg)

$ -> monitor()
