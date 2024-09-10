const showSearchPopupBtn = document.querySelector(".search__button");
const closeBtn = document.querySelector(".popup__button--close");
const popupOverlay = document.querySelector(".popup-overlay");
const popup = document.querySelector(".popup");
export const submitSearchBtn = document.querySelector(".search__submit");
export const searchForm = document.querySelector(".search__form");

showSearchPopupBtn.addEventListener("click", showSearchPopup);
closeBtn.addEventListener("click", hideSearchPopup);

export function showSearchPopup() {
  popup.classList.remove("hidden");
  popupOverlay.classList.remove("hidden");
}

export function hideSearchPopup() {
  popup.classList.add("hidden");
  popupOverlay.classList.add("hidden");
}
