import { getAndRenderQuickTable } from "./js/qTable.js";
import { getSearchRequestBody } from "./js/search.js";
import { initQtable } from "./js/qTable.js";
import { initSearch } from "./js/search.js";

export function startTheApp(qTableApiUrl, searchParamsObject) {
  initQtable(qTableApiUrl);
  initSearch(searchParamsObject);
  window.addEventListener("searchFormSubmitted", handleSearchFormSubmitted);
  // publish a custom event
  const event = new Event("searchFormSubmitted");
  window.dispatchEvent(event);
}

async function handleSearchFormSubmitted(e) {
  await getAndRenderQuickTable(getSearchRequestBody());
}
