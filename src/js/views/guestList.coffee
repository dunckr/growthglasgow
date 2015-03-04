$ = require "jquery"

Template = (user) ->
  "<div class='col-xs-6 col-sm-4 col-md-2'><img class='img-circle' src='#{user.profile}' /> </div>"

class GuestListView
  el: "#guest-list"
  endpoint: "/users"

  constructor: ->
    @render()

  fetch: ->
    $.get(@endpoint)

  render: ->
    @fetch().done (data) => @displayUsers(JSON.parse(data))

  displayUsers: (users) ->
    for user in users
      @useHighRes(user)
      $el = $(Template(user))
      $(@el).append($el)

  useHighRes: (user) ->
    user.profile = user.profile.replace("_normal", "")

module.exports = GuestListView
