const showSearchPopup = document.querySelector(".search__button");
const closeBtn = document.querySelector(".popup__button--close");
const popupOverlay = document.querySelector(".popup-overlay");
const popup = document.querySelector(".popup");

showSearchPopup.addEventListener("click", show);
closeBtn.addEventListener("click", hide);

function show() {
  popup.classList.remove("hidden");
  popupOverlay.classList.remove("hidden");
}

function hide() {
  popup.classList.add("hidden");
  popupOverlay.classList.add("hidden");
}
