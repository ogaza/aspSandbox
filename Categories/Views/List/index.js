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

  const { status, statusText } = response;

  if (status >= 400) {
    renderTable(getErrorMessage({ status, statusText }));

    redirectToLoginPageAfterFiveSeconds();

    return;
  }

  renderTable(await response.text());
  // override submitform2 function triggered by
  // the quickTable navigation
  submitform2 = submitform2__override;
}

function getErrorMessage({ status, statusText }) {
  return `An error occured when loading the data. Response status: ${status} - ${statusText}`;
}

function submitform2__override(...args) {
  saveQuickTableParamsInForm(...args);
  getAndRenderQuickTable();
}

function handleSearchSubmit() {
  hidePopup();
  getAndRenderQuickTable();
}

function redirectToLoginPageAfterFiveSeconds() {
  setTimeout(redirectToLoginPage, 5000);
}

function redirectToLoginPage() {
  window.location = "/Auth/Views/LoginForm/LoginForm.asp";
}
