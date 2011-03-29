// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  var map;
  var mainarea = $('#main-area');
  var prevDataChecksum;
  var friendLocations = [];
  var markers = [];
  var iterator = 0;

  function initializeMap() {
    var vaasa = new google.maps.LatLng(63.09525, 21.61627);
    var options = {
      zoom: 11,
      center: vaasa,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(
      document.getElementById('main-area'), options);

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

      clearLocationData();

      for (var i in data) {
        addFriendLocation(data[i].location);
      }

      drop();
    });
  }

  function clearOverlays() {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }

    markers = [];
  }

  function clearLocationData() {
    clearOverlays();
    friendLocations = [];
    iterator = 0;
  }

  function addFriendLocation(location) {
    var latitude = parseFloat(location.latitude);
    var longtitude = parseFloat(location.longtitude);
    var title = location.first_name + ' ' + location.last_name

    var location = new google.maps.LatLng(latitude, longtitude);
    friendLocations.push([title, location]);
  }

  function drop() {
    for (var i = 0, len = friendLocations.length; i < len; i++) {
      addMarker();
    }
  }

  function addMarker() {
    var marker = new google.maps.Marker({
      position: friendLocations[iterator][1],
      map: map,
      draggable: false,
      title: friendLocations[iterator][0]
    });

    markers.push(marker);
    iterator++;
  }

  initializeMap();

  setInterval(updateFriendLocations, 2000);
});
