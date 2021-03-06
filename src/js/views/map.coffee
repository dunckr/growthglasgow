style = [{"featureType":"all","elementType":"labels.text","stylers":[{"color":"#000000"},{"visibility":"simplified"}]},{"featureType":"all","elementType":"labels.text.fill","stylers":[{"hue":"#ff0000"}]},{"featureType":"all","elementType":"labels.text.stroke","stylers":[{"color":"#ff0000"},{"visibility":"simplified"}]},{"featureType":"administrative","elementType":"labels.text.fill","stylers":[{"color":"#000000"},{"visibility":"off"}]},{"featureType":"administrative.country","elementType":"geometry.fill","stylers":[{"visibility":"off"},{"color":"#ff0000"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"visibility":"on"}]},{"featureType":"administrative.country","elementType":"labels","stylers":[{"visibility":"simplified"},{"color":"#9b30f2"}]},{"featureType":"administrative.province","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"all","stylers":[{"visibility":"simplified"},{"color":"#7620bd"}]},{"featureType":"landscape.man_made","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"geometry.fill","stylers":[{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"visibility":"off"}]},{"featureType":"landscape.man_made","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"landscape.natural","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"visibility":"off"}]},{"featureType":"landscape.natural","elementType":"geometry.fill","stylers":[{"visibility":"off"}]},{"featureType":"landscape.natural.landcover","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"landscape.natural.terrain","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":-100},{"lightness":45},{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"},{"color":"#c4c6f4"}]},{"featureType":"road.highway","elementType":"labels","stylers":[{"visibility":"off"},{"color":"#d3d4f3"}]},{"featureType":"road.highway","elementType":"labels.text","stylers":[{"visibility":"simplified"},{"color":"#000000"},{"weight":"0.01"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"visibility":"simplified"},{"weight":"0.01"}]},{"featureType":"transit.station.bus","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"water","elementType":"all","stylers":[{"color":"#eeeeff"},{"visibility":"on"}]}]
options = (google) ->
  center: new (google.maps.LatLng)(55.863946, -4.328305)
  zoom: 14
  zoomControl: false
  disableDoubleClickZoom: true
  mapTypeControl: false
  scaleControl: false
  scrollwheel: false
  panControl: false
  streetViewControl: false
  draggable: true
  overviewMapControl: false
  overviewMapControlOptions: opened: false
  mapTypeId: google.maps.MapTypeId.ROADMAP
  styles: style

class MapView
  el: "#map"

  constructor: ->
    google.maps.event.addDomListener window, "load", @mapLoaded

  mapLoaded: ->
    options  = options(google)
    mapElement = document.getElementById("map")
    map = new (google.maps.Map)(mapElement, options)
    new google.maps.Marker(
      icon: "images/marker.png"
      position: new (google.maps.LatLng)(55.8639458, -4.318304699999999)
      map: map
      title: "Rookie Oven"
    )

module.exports = MapView
