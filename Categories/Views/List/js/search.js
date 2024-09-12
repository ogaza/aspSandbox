import { showPopup } from "./popup.js";

export const searchParams = {};

const searchBtn = document.querySelector(".search__button");
const searchForm = document.querySelector(".search__form");
const submitSearchBtn = document.querySelector(".search__submit");

searchBtn.addEventListener("click", handleSearcBtnClick);
submitSearchBtn.addEventListener("click", handleSearchSubmit);

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

export function onSubmitSearch(callback) {
  submitSearchBtn.addEventListener("click", callback);
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

  // const formInputs = Array.from(searchForm.elements);
  // formInputs.forEach((input) => {
  //   if (input.type != "text") {
  //     return;
  //   }
  //   searchParams[input.name] = input.value;
  // });
}
