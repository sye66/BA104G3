function initMapCustom(){
    window.navigator.geolocation.getCurrentPosition(function(pos){
        current_pos = {lat: pos.coords.latitude, lng: pos.coords.longitude};
        console.log(current_pos);
        map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: current_pos
        });
        var marker = new google.maps.Marker({
            position: current_pos,
            map: map
        });
    });

}

//https://developers.google.com/places/supported_types

function performSearch(){
    var searchText = document.getElementById("search-food").value;
    // 要確認這次搜尋到底要搜尋什麼東西
    var types = document.getElementsByName("search-type");
    var searchTypes = []
    for(var i = 0; i < types.length; i++) {
        if(types[i].checked == true) {
            searchTypes.push(types[i].value);
        }
    }
    console.log(searchTypes);
    // 當searchTypes裡面什麼都沒有 -> 什麼都找
    if(searchTypes.length == 0) {
          // 每次search前就把地圖上marker清空(把marker的map資料設成null)
          for(var i = 0; i < search_markers.length; i++) {
              search_markers[i].setMap(null);
          }
          // 都清完了, 就設定成空陣列
          search_markers = []; 
          return;
    }
    
    var request = {
            location: current_pos,
            radius: 1500,
            types: searchTypes,
            name:searchText,
    };
    service = new google.maps.places.PlacesService(map);
    service.nearbySearch(request, searchCallback);
}

var search_markers = [];

// 將marker設定到地圖上
function searchCallback(results, status) {

  // 每次search前就把地圖上marker清空(把marker的map資料設成null)
  for(var i = 0; i < search_markers.length; i++) {
      search_markers[i].setMap(null);
  }
  // 都清完了, 就設定成空陣列
  search_markers = []; 
  if (status == google.maps.places.PlacesServiceStatus.OK) {
      for (var i = 0; i < results.length; i++) {
           var place = results[i];
           // 把google原本就放在result的icon拿出來
           var image = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
            };
            search_markers.push(new google.maps.Marker({
                                map: map,
                                icon:image,
                                position: place.geometry.location,
                                title: place.name,
                            }));
            //console.log(place);
    }
    var searchTypes = document.getElementsByName("search-type");
        for(var i = 0; i < searchTypes.length; i++) {
            searchTypes[i].setAttribute("checked", true);
    }
  }
}