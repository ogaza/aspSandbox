const closeBtn = document.querySelector(".popup__button--close");
const popupOverlay = document.querySelector(".popup-overlay");
const popup = document.querySelector(".popup");

closeBtn.addEventListener("click", hidePopup);

export function showPopup() {
  popup.classList.remove("hidden");
  popupOverlay.classList.remove("hidden");
}

export function hidePopup() {
  popup.classList.add("hidden");
  popupOverlay.classList.add("hidden");
}
