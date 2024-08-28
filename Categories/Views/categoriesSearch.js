// document.querySelector(".section--main").textContent = "...loading";

function showSearch() {
  let temp = document.getElementsByTagName("template")[0];
  let clon = temp.content.cloneNode(true);
  // document.body.appendChild(clon);

  document.querySelector(".search").replaceChildren(clon);
}
function hideSearch() {
  document.querySelector(".search").replaceChildren();
}
