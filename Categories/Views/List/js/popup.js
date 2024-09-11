const closeBtn = document.querySelector(".popup__button--close");
const popupOverlay = document.querySelector(".popup-overlay");
const popup = document.querySelector(".popup");

closeBtn.addEventListener("click", hideSearchPopup);

export function showSearchPopup() {
  popup.classList.remove("hidden");
  popupOverlay.classList.remove("hidden");
}

export function hideSearchPopup() {
  popup.classList.add("hidden");
  popupOverlay.classList.add("hidden");
}
