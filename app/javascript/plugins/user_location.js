const x = document.querySelector(".address");


function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    x.value = "Geolocation is not supported by this browser.";
  }
}

function showPosition(position) {
  x.value = position.coords.latitude + ","
  + position.coords.longitude;
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
