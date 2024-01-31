document.querySelector(".section--main").textContent = "...loading";

getData();

async function getData() {
  const response = await fetch(
    "http://localhost:9090/categories/views/categoriesTable.asp"
  );
  const responseHtml = await response.text();

  document.querySelector(".section--main").innerHTML = responseHtml;
}
