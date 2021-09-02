function textCopier() {
  /* Get the text field */
  const copyText = document.getElementById("myInput");

  /* Select the text field */
  copyText.select();
  copyText.setSelectionRange(0, 99999); /* For mobile devices */

  /* Copy the text inside the text field */
  navigator.clipboard.writeText(copyText.value);

  /* Alert the copied text */
  alert("You've copied the link.");
}


function buttonCopy() {
  const copyBtn = document.querySelector(".fa-copy");
  copyBtn.addEventListener("click", () => {
    textCopier()
  })
}


export { buttonCopy };
