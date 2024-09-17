import { showPopup } from "./popup.js";

export const searchParams = {};

const searchBtn = document.querySelector(".search__button");
var searchForm;
var submitSearchBtn;

searchBtn.addEventListener("click", handleSearcBtnClick);

export function buildRequestBodyFromSearchParams() {
  const { CategoryID = "", CategoryName = "", Description = "" } = searchParams;

  return `CategoryID=${CategoryID}&CategoryName=${CategoryName}&Description=${Description}`;
  // const searchKeys = Object.keys(searchParams);
  // let body = "";
  // searchKeys.forEach((key) => {
  //   body += `${key}=${searchParams[key]}&`;
  // });
  // return body;
}

function handleSearcBtnClick() {
  showPopup();
}

function handleSearchSubmit(e) {
  e.preventDefault();
  saveSearchParams();
}

function saveSearchParams() {
  searchParams["CategoryID"] = searchForm.elements["CategoryID"].value;
  searchParams["CategoryName"] = searchForm.elements["CategoryName"].value;
  searchParams["Description"] = searchForm.elements["Description"].value;
}

export function buildSearchForm(onSubmit) {
  // searchFields will come from the server
  // with the quick table
  if (!searchFields) return;

  const searchElements = [];
  // get main container
  const container = document.querySelector(".popup__content");
  // get templates - form and its field
  const searchFormTemplate = document.querySelector("#search-form-template");
  const searchFieldTemplate = document.querySelector("#search-field-template");
  const searchFooterTemplate = document.querySelector(
    "#search-footer-template"
  );

  // create search form fragment
  const searchFormNode = searchFormTemplate.content.cloneNode(true);

  // create field html elements
  searchFields.forEach(createSearchField);
  // put search elements into searc form
  const searchFormFields = searchFormNode.querySelector(".search__fields");
  searchFormFields.replaceChildren(...searchElements);

  // search form footer with its buttons
  const searchFooter = searchFooterTemplate.content.cloneNode(true);
  submitSearchBtn = searchFooter.querySelector(".search__submit");
  submitSearchBtn.addEventListener("click", handleSearchSubmit);
  submitSearchBtn.addEventListener("click", onSubmit);

  searchForm = searchFormNode.querySelector(".search__form");
  searchForm.appendChild(searchFooter);

  // render the search form under its container
  container.replaceChildren(searchFormNode.firstElementChild);

  function createSearchField(searchFieldDefinition) {
    const searchElement = searchFieldTemplate.content.cloneNode(true);
    const inputElem = searchElement.querySelector(".search__input");
    inputElem.setAttribute("name", searchFieldDefinition.name);

    const labelElem = searchElement.querySelector(".search__label");
    labelElem.textContent = searchFieldDefinition.name;

    searchElements.push(searchElement.firstElementChild);
  }
}
