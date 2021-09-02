const myAddress = document.querySelector(".address");


function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    myAddress.value = "Geolocation is not supported by this browser.";
  }
}

function showPosition(position) {
  const coordinates = position.coords.latitude + "," + position.coords.longitude;

  fetch(`https://places-dsn.algolia.net/1/places/reverse?aroundLatLng=${coordinates}&hitsPerPage=5&language=en`)
    .then(response => response.json())
    .then((data) => {
      myAddress.value = data.hits[0].locale_names[0];
    })
}


function buttonClick(){
  const searchButton =  document.querySelector(".location-btn");
  if (searchButton) {
    searchButton.addEventListener("click", () =>  {
      getLocation()
    })
  }
}




export { buttonClick };
