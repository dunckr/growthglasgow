window.$ = $ = require "jquery"
MapView = require "./views/map"
GuestListView = require "./views/guestList"
SponsorsView = require "./views/sponsors"

$ ->
  new GuestListView()
  new MapView()
  new SponsorsView()

