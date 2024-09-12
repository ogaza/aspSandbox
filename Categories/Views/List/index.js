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
import { hidePopup } from "./js/popup.js";

await getAndRenderQuickTable();
// after the first call for the table
// render the search form
buildSearchForm();
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
  hidePopup();
  getAndRenderQuickTable();
}

//-----------------------------------------
function buildSearchForm() {
  // searchFields will come from the server
  // with the quick table
  if (!searchFields) return;

  const searchElements = [];
  // get main container
  const container = document.querySelector(".popup__content");
  // get templates - form and its field
  const searchFormTemplate = document.querySelector("#search-form-template");
  const searchFieldTemplate = document.querySelector("#search-field-template");

  // create search form fragment
  const searchForm = searchFormTemplate.content.cloneNode(true);

  // create field html elements
  searchFields.forEach(createSearchField);
  // put search elements into searc form
  const searchFormFields = searchForm.querySelector(".search__fields");
  searchFormFields.replaceChildren(...searchElements);

  // render the search form under its container
  container.replaceChildren(searchForm.firstElementChild);

  function createSearchField(searchFieldDefinition) {
    const searchElement = searchFieldTemplate.content.cloneNode(true);
    const labelElem = searchElement.querySelector(".search__label");

    labelElem.textContent = searchFieldDefinition.name;

    searchElements.push(searchElement.firstElementChild);
  }
}
