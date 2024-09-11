import { fetchCategoriesTable } from "./js/api.js";
import {
  buildRequestBodyFromSearchParams,
  onSubmitSearch
} from "./js/search.js";
import {
  buildRequestBodyFromQTable,
  renderTable,
  saveQuickTableParamsInForm
} from "./js/table.js";
import { showSpinner, hideSpinner } from "./js/spinner.js";
import { hideSearchPopup } from "./js/popup.js";

getAndRenderQuickTable();
onSubmitSearch(handleSearchSubmit);

async function getAndRenderQuickTable() {
  showSpinner();

  let body =
    buildRequestBodyFromQTable() + "&" + buildRequestBodyFromSearchParams();
  const response = await fetchCategoriesTable(body);

  hideSpinner();

  if (response.status >= 400) {
    renderTable(getErrorMessage());
    return;
  }

  renderTable(await response.text());
  // override submitform2 function triggered by
  // the quickTable navigation
  submitform2 = submitform2__override;
}

function getErrorMessage() {
  return "An error occured when loading the data.";
}

function submitform2__override(...args) {
  saveQuickTableParamsInForm(...args);
  getAndRenderQuickTable();
}

function handleSearchSubmit() {
  hideSearchPopup();
  getAndRenderQuickTable();
}
