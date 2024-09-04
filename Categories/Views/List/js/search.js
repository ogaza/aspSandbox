import { hide } from "./popup.js";
import { hideSpinner, showSpinner } from "./spinner.js";

const submitSearchBtn = document.querySelector(".search__submit");
const searchForm = document.querySelector(".search__form");
const categoriesTableContainer = document.querySelector(".categories__table");

submitSearchBtn.addEventListener("click", handleSearchSubmit);

const searchParams = {};

function handleSearchSubmit(e) {
  e.preventDefault();

  hide();
  saveSearchParams();
  getCategoriesTable();
}

function saveSearchParams() {
  searchParams["CategoryID"] = searchForm.elements["CategoryID"].value;
  searchParams["CategoryName"] = searchForm.elements["CategoryName"].value;

  // const formInputs = Array.from(searchForm.elements);
  // formInputs.forEach((input) => {
  //   if (input.type != "text") {
  //     return;
  //   }

  //   searchParams[input.name] = input.value;
  // });
}

async function getCategoriesTable() {
  let body = buildQuickTableRequestBody() + "&" + buildSearchRequestBody();
  showSpinner();

  const response = await fetchCategoriesTable(body);

  renderCategoriesTable(response);

  hideSpinner();
}

function fetchCategoriesTable(body) {
  return fetch("http://localhost:9090/categories/views/categoriesTable.asp", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body
  });
}

async function renderCategoriesTable(response) {
  if (response.status >= 400) {
    handleResponseError();
    return;
  }

  const responseHtml = await response.text();

  var range = document.createRange();
  var fragment = range.createContextualFragment(responseHtml);
  categoriesTableContainer.replaceChildren(fragment);

  submitform2 = submitform2__override;
}

function handleResponseError() {
  categoriesTableContainer.textContent =
    "error when loading the categories table";
}

function submitform2__override(
  X999sort,
  X999field,
  X999paging,
  X999whichpage,
  X999csv,
  X999action,
  X999actionfield
) {
  document.xxxx2.X999csv.value = X999csv;
  document.xxxx2.X999action.value = X999action;
  document.xxxx2.X999actionfield.value = X999actionfield;
  document.xxxx2.X999sort.value = X999sort;
  document.xxxx2.X999field.value = X999field;
  document.xxxx2.X999paging.value = X999paging;
  document.xxxx2.X999whichpage.value = X999whichpage;

  getCategoriesTable();
}

function buildQuickTableRequestBody() {
  const quickTableForm = document.xxxx2;

  if (!quickTableForm) {
    return "";
  }

  const {
    X999tablenumber,
    X999csv,
    X999sort,
    X999action,
    X999actionfield,
    X999field,
    X999paging,
    X999whichpage
  } = quickTableForm;

  let body = "";

  body =
    `X999myquery=&` +
    `X999tablenumber=${X999tablenumber.value}&` +
    `X999csv=${X999csv.value}&` +
    `X999sort=${X999sort.value}&` +
    `X999action=${X999action.value}&` +
    `X999actionfield=${X999actionfield.value}&` +
    `X999field=${X999field.value}&` +
    `X999paging=${X999paging.value}&` +
    `X999whichpage=${X999whichpage.value}`;

  return body;
}

function buildSearchRequestBody() {
  const { CategoryID, CategoryName } = searchParams;

  return `CategoryID=${CategoryID}&CategoryName=${CategoryName}`;

  // const searchKeys = Object.keys(searchParams);

  // let body = "";
  // searchKeys.forEach((key) => {
  //   body += `${key}=${searchParams[key]}&`;
  // });

  // return body;
}
