export const searchParams = {};

export function buildRequestBodyFrom(searchParams) {
  const { CategoryID = "", CategoryName = "", Description = "" } = searchParams;

  return `CategoryID=${CategoryID}&CategoryName=${CategoryName}&Description=${Description}`;

  // const searchKeys = Object.keys(searchParams);

  // let body = "";
  // searchKeys.forEach((key) => {
  //   body += `${key}=${searchParams[key]}&`;
  // });

  // return body;
}

export function saveSearchParams(searchForm) {
  searchParams["CategoryID"] = searchForm.elements["CategoryID"].value;
  searchParams["CategoryName"] = searchForm.elements["CategoryName"].value;
  searchParams["Description"] = searchForm.elements["Description"].value;

  // const formInputs = Array.from(searchForm.elements);
  // formInputs.forEach((input) => {
  //   if (input.type != "text") {
  //     return;
  //   }

  //   searchParams[input.name] = input.value;
  // });
}

// const submitSearchBtn = document.querySelector(".search__submit");
// submitSearchBtn.addEventListener("click", handleSearchSubmit);
