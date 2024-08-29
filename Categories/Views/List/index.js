const searchBtn = document.querySelector(".search__button");
const closeBtn = document.querySelector(".popup__button--close");
const popupOverlay = document.querySelector(".popup-overlay");
const popup = document.querySelector(".popup");

searchBtn.addEventListener("click", showSearch);
closeBtn.addEventListener("click", hideSearch);

function showSearch() {
  popup.classList.remove("hidden");
  popupOverlay.classList.remove("hidden");
}

function hideSearch() {
  popup.classList.add("hidden");
  popupOverlay.classList.add("hidden");
}
