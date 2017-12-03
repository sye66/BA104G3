<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Title Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <style type="text/css">
    #map {
        height: 800px;
        width: 100%;
    }
    </style>
</head>

<body>
    <div></div>
    <div id="jsontest" style="border: 1px black solid"></div>
    <div id="jsonarr"></div>
    <button id="jsontrigger">JsonButton</button>
    <div id="map"></div>
    <script>
    function initMap() {
        var pos;
        var lat;
        var lng;
        
        
        var map = new google.maps.Map(document.getElementById('map'), {
            center: { lat: -34.397, lng: 150.644 },
            zoom: 2
        });

        // Try HTML5 geolocation.

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                map.setCenter(pos);

                $.ajax({
                    url: '<%=request.getContextPath()%>/getmission/getmission.do',
                    type: 'post',
                    data: {
                        action: "get_Location_Json",
                    },
                    dataType: "json",

                    success: function(data) {
                        for (var i = 0; i < data.length; i++) {
                            var obj = data[i];
                            var contentString = '<form action="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission_takecasemission.jsp" method="post"><input type="hidden" name="takecase_Mem_No"	value="' + obj.mem_No + '"><input type="submit" value="直接發案" class="btn btn-info"></form>';
                            var GPS_Position = { lat: obj.mem_GPS_LAT, lng: obj.mem_GPS_LNG }
                            // InfoWindow
                            var infoWindow2 = new google.maps.InfoWindow({ contents: contentString });
                            infoWindow2.setPosition(GPS_Position);
                            // Marker
                            var marker2 = new google.maps.Marker({
                                position: GPS_Position,
                                map: map,
                                title: "某工具人"
                            });
                            google.maps.event.addListener(marker2, 'click', (function(marker2, contentString, infoWindow2) {
                                return function() {
                                    infoWindow2.setContent(contentString);
                                    infoWindow2.open(map, marker2);
                                };
                            })(marker2, contentString, infoWindow2));
                        }
                    }
                })
            }, function() {
                handleLocationError(true, infoWindow, map.getCenter());
            });
        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, infoWindow, map.getCenter());
        }
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ?
            'Error: The Geolocation service failed.' :
            'Error: Your browser doesn\'t support geolocation.');
    }
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsHkChmufu1IrpSdVxTk0VC3_6cvjQeIo&callback=initMap"></script>
</body>
<script type="text/javascript">
$("#jsontrigger").click(function() {
    $.ajax({
        url: '<%=request.getContextPath()%>/getmission/getmission.do',
        type: 'post',
        data: {
            action: "get_Location_Json",
        },
        dataType: "json",

        success: function(data) {
            for (var i = 0; i < data.length; i++) {
                var obj = data[i];
                $("#jsonarr").append('<div>' + obj.mem_No + '</div>');
            }
        }
    })

})
</script>

</html>