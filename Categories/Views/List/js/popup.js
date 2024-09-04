const showSearchPopupBtn = document.querySelector(".search__button");
const closeBtn = document.querySelector(".popup__button--close");
const popupOverlay = document.querySelector(".popup-overlay");
const popup = document.querySelector(".popup");

showSearchPopupBtn.addEventListener("click", show);
closeBtn.addEventListener("click", hide);

export function show() {
  popup.classList.remove("hidden");
  popupOverlay.classList.remove("hidden");
}

export function hide() {
  popup.classList.add("hidden");
  popupOverlay.classList.add("hidden");
}
