export function renderTable(tableContainer, responseHtml) {
  var range = document.createRange();
  var fragment = range.createContextualFragment(responseHtml);
  tableContainer.replaceChildren(fragment);

  // console.log(searchFields);
}

export function saveQuickTableParamsInForm(
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
}

export function buildRequestBodyFromQTable() {
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
