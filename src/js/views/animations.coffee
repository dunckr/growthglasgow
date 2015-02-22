$ = require "jquery"

class AnimationsView
  speed: 2000
  ui:
    title: ".title h1"

  constructor: ->
    @titleAnimate()

  titleAnimate: ->
    $(@ui.title).fadeIn(@speed)

module.exports = AnimationsView
