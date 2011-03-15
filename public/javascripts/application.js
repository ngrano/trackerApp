// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function initalizeMap() {
  var vaasa = new google.maps.LatLng(63.09525, 21.61627);
  var options = {
   zoom: 4,
   center: vaasa,
   mapTypeId: google.maps.MapTypeId.ROADMAP 
  }

  var map = new google.maps.Map(
      document.getElementById('map_canvas'), options);
}