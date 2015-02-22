window.$ = $ = require "jquery"
MapView = require "./views/map"
GuestListView = require "./views/guestList"
SponsorsView = require "./views/sponsors"
AnimationsView = require "./views/animations"

$ ->
  new GuestListView()
  new MapView()
  new SponsorsView()
  new AnimationsView()

