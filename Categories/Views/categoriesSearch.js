// document.querySelector(".section--main").textContent = "...loading";

function showSearch() {
  let template = document.getElementById("search-template");
  let clone = template.content.cloneNode(true);

  document.querySelector(".search").replaceChildren(clone);
}
function hideSearch() {
  document.querySelector(".search").replaceChildren();
}
