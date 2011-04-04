// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  var map;
  var mainarea = $('#googlemap');
  var friendLocations = [];
  var iterator = 0;
  var mapInitialized = false;
  var interval = 2000;

  function initializeMap() {
    var vaasa = new google.maps.LatLng(63.09525, 21.61627);
    var options = {
      zoom: 11,
      center: vaasa,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(
      document.getElementById('googlemap'), options);

    updateFriendLocations();
  }

  /**
   * @todo Create a friend_locations controller
   */
  function updateFriendLocations() {
    var apikey = mainarea.attr('data-apikey');
    $.getJSON('/api/v1/locations/friends', {apikey: apikey}, function(data){
      if (!map) {
        logger.warn("Map is null!");
        return;
      }

      for (var i in data) {
        addFriendLocation(data[i].location);
      }

      drop();
    });
  }

  function clearOverlays(location) {
    for (var i = 0; i < location.markers.length; i++) {
      location.markers[i].setMap(null);
    }

    location.markers = [];
  }

  function clearLocationData(location) {
    clearOverlays(location);
    location.position = null;
  }

  function addFriendLocation(location) {
    var id = parseInt(location.user_id);
    var latitude = parseFloat(location.latitude);
    var longtitude = parseFloat(location.longtitude);
    var title = location.first_name + ' ' + location.last_name

    var position = new google.maps.LatLng(latitude, longtitude);
    var friendLocation = findOrInitializeFriendLocation(id);

    if (!positionChanged(friendLocation.position, position)) {
      friendLocation.positionChanged = false;
      return;
    }

    clearLocationData(friendLocation);
    friendLocation.title = title;
    friendLocation.position = position;
    friendLocation.positionChanged = true;
  }

  function positionChanged(oldPosition, newPosition) {
    if (!oldPosition && newPosition) {
      return true;
    }

    return newPosition && !newPosition.equals(oldPosition);
  }

  function findOrInitializeFriendLocation(id) {
    var friendLocation = findFriendLocation(id);

    if (friendLocation) {
      return friendLocation;
    }

    friendLocation = {};
    friendLocation['location'] = {
      user_id: id,
      positionChanged: true,
      title: '',
      position: null,
      markers: []
    }

    friendLocations.push(friendLocation);

    return friendLocation['location'];
  }

  function findFriendLocation(id) {
    for (var i = 0; i < friendLocations.length; i++) {
      if (friendLocations[i]['location'].user_id == id) {
        return friendLocations[i]['location'];
      }
    }

    return null;
  }

  function drop() {
    for (var i = 0, len = friendLocations.length; i < len; i++) {
      var location = friendLocations[i]['location'];

      if (!mapInitialized) {
        console.log("Map not initialized!");
        setTimeout(addMarker(location), i * 200);
      } else {
        console.log("map initialized");
        addMarker(location);
      }
    }
  }

  function getLocationObject(index) {
    return friendsLocations[index]['location']
  }

  function addMarker(location) {
    if (!location.positionChanged) {
      return;
    }

    var marker = new google.maps.Marker({
      position: location.position,
      draggable: false,
      title: location.title
    });

    // Use drop effect when page is loaded
    if (!mapInitialized) {
      marker.setAnimation(google.maps.Animation.DROP);
    }

    marker.setMap(map);
    location.markers.push(marker);

    if (!mapInitialized) iterator++;

    if (!mapInitialized && iterator == friendLocations.length - 1) {
      mapInitialized = true;
      iterator = 0;
    }
  }

  initializeMap();

  setInterval(updateFriendLocations, interval);
});
