// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  var map;
  var mainarea = $('#main-area');

  function initializeMap() {
    var vaasa = new google.maps.LatLng(63.09525, 21.61627);
    var options = {
      zoom: 11,
      center: vaasa,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    map = new google.maps.Map(
      document.getElementById('main-area'), options);
  }

  /**
   * @todo Create a friend_locations controller
   */
  function updateFriendLocations() {
    var apikey = mainarea.attr('data-apikey');
    $.getJSON('/api/v1/friend_location', {apikey: apikey}, function(data){
      
    });
  }

  initializeMap();
});
