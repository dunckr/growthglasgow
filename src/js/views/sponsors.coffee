$ = require "jquery"

class SponsorsView
  el: "#add-sponsor"
  email: "growth@growthglasgow.com"

  constructor: ->
    $(@el).click => @onClick()

  onClick: ->
    window.location.href = "mailto:#{@email}"

module.exports = SponsorsView
