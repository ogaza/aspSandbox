import { fetchCategoriesTable } from "./js/api.js";
import {
  buildRequestBodyFrom,
  saveSearchParams,
  searchParams
} from "./js/search.js";
import {
  buildRequestBodyFromQTable,
  renderTable,
  saveQuickTableParamsInForm
} from "./js/table.js";
import { showSpinner, hideSpinner } from "./js/spinner.js";
import { hideSearchPopup, searchForm, submitSearchBtn } from "./js/popup.js";

const quickTableContainer = document.querySelector(".categories__table");
const submitform2__override = function (...args) {
  saveQuickTableParamsInForm(...args);
  getAndRenderQuickTable();
};

getAndRenderQuickTable();

submitSearchBtn.addEventListener("click", handleSearchSubmit);

async function getAndRenderQuickTable() {
  showSpinner();
  let body =
    buildRequestBodyFromQTable() + "&" + buildRequestBodyFrom(searchParams);

  const response = await fetchCategoriesTable(body);

  if (response.status >= 400) {
    renderErrorMessage();
    return;
  }

  const responseHtml = await response.text();

  renderTable(quickTableContainer, responseHtml);

  // override submitform2 function triggered by
  // the quickTable navigation
  submitform2 = submitform2__override;

  hideSpinner();
}

function renderErrorMessage() {
  quickTableContainer.textContent = "error when loading the categories table";
}

function handleSearchSubmit(e) {
  e.preventDefault();

  saveSearchParams(searchForm);

  hideSearchPopup();
  getAndRenderQuickTable();
}
