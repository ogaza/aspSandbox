const searchPopupOverlay = document.querySelector(".popup-overlay");
const searchPopup = document.querySelector(".popup");
const searchForm = document.querySelector(".search__form");
const submitSearchBtn = document.querySelector(".search__submit");

const searchBtn = document.querySelector(".search__button");
const closeSearchBtn = document.querySelector(".popup__button--close");

searchBtn.addEventListener("click", handleSearcBtnClick);
closeSearchBtn.addEventListener("click", hideSearchPopup);
submitSearchBtn.addEventListener("click", handleSearchSubmit);

export let searchParams;

export function initSearch(initialSearchParams) {
  searchParams = initialSearchParams;
}

async function handleSearchSubmit(e) {
  e.preventDefault();

  saveSearchParams();
  hideSearchPopup();
  // publish a custom event
  const event = new Event("searchFormSubmitted");
  window.dispatchEvent(event);
}
/**
 * Return the form body based on the searchParams object
 * @returns a string of the form
 * for example CategoryID=1&Description=sth&
 */
export function getSearchRequestBody() {
  return Object.keys(searchParams).reduce(searchParamsReducer, "");
}

function searchParamsReducer(body, paramName) {
  return `${body}${paramName}=${searchParams[paramName]}&`;
}

/**
 * takes the inputs from the searchForm
 * that have the names corresponding to the
 * properties of the searchParams object
 * and stores the values of this inputs
 * in the searchParams object
 */
export function saveSearchParams() {
  Object.keys(searchParams).forEach((paramName) => {
    searchParams[paramName] = searchForm.elements[paramName].value;
  });
}

function handleSearcBtnClick() {
  showSearchPopup();
}

export function showSearchPopup() {
  searchPopup.classList.remove("hidden");
  searchPopupOverlay.classList.remove("hidden");
}

export function hideSearchPopup() {
  searchPopup.classList.add("hidden");
  searchPopupOverlay.classList.add("hidden");
}
