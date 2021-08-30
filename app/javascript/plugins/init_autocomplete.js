import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelectorAll('.address');
  console.log(addressInput);
  if (addressInput) {
    addressInput.forEach((el) => {
      places({
        container: el
      });
    });
  }
}

export {
  initAutocomplete
};
