<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
	html, body { height: 100%; margin: 0; padding: 0; }
	#map { height: 100%; }
	</style>
	<title>zapustis' uje</title>
</head>
<body>
<div id="map" style="width:800px; height:600px"></div>
<script type="text/javascript">


	function initMap() {
		var map = new google.maps.Map(document.getElementById('map'), {
			center: {lat: -34.397, lng: 150.644},
			zoom: 16,
			mapTypeId: google.maps.MapTypeId.HYBRID
		});
		var infoWindow = new google.maps.InfoWindow({map: map});

		// Try HTML5 geolocation.
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				var pos = {
					lat: position.coords.latitude,
					lng: position.coords.longitude
				};
				infoWindow.setPosition(pos);
                var theUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng="+String(pos.lat)+","+String(pos.lng)+"";
                var response = httpGet(theUrl);
                var json = response,
                       obj = JSON.parse(json);
                infoWindow.setContent(String(obj.results[0].formatted_address));
				map.setCenter(pos);

            }, function() {
				handleLocationError(true, infoWindow, map.getCenter());
			});
		} else {
			// Browser doesn't support Geolocation
			handleLocationError(false, infoWindow, map.getCenter());
		}
	}

    function httpGet(theUrl)
    {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
        xmlHttp.send( null );
        return xmlHttp.responseText;
    }

	function handleLocationError(browserHasGeolocation, infoWindow, pos) {
		infoWindow.setPosition(pos);
		infoWindow.setContent(browserHasGeolocation ?
				'Error: The Geolocation service failed.' :
				'Error: Your browser doesn\'t support geolocation.');
	}


</script>
<script async defer
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCHtuCYx70e7l7cZwX3uelvywgHu4I8Y1Q&callback=initMap">
</script>
</body>
</html>