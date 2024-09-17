import { fetchCategoriesTable } from "./js/api.js";
import {
  buildSearchFormPopup,
  buildRequestBodyFromSearchParams
} from "./js/search.js";
import {
  buildRequestBodyFromQTable,
  renderTable,
  saveQuickTableParamsInForm
} from "./js/table.js";
import { showSpinner, hideSpinner } from "./js/spinner.js";
import { hidePopup } from "./js/popup.js";

await getAndRenderQuickTable();
// after the first call for the table
// render the search form
buildSearchFormPopup(handleSearchSubmit);

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
  hidePopup();
  getAndRenderQuickTable();
}
