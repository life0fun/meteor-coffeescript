Template.map.rendered = ->
  console.log "map rendered is called :"
  
  mapOptions =
    zoom: 11,
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map( document.getElementById("map-canvas"), mapOptions )

  loc = Session.get('location');
  loc = new google.maps.LatLng(37.834, -122.285)
  console.log "loc is: ", loc.lat(), loc.lng(), map
  Session.set 'location', loc

  map.setCenter loc
  marker = new google.maps.Marker({
    position: loc,
    title: 'center',
    icon: 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
    map: map
  })
  
  marker.setDraggable true
  Session.set 'map', true