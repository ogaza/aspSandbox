document.querySelector(".section--main").textContent = "...loading";

getData();

async function getData() {
  const response = await fetch(
    "http://localhost:9090/categories/views/categoriesTable.asp"
  );

  console.log(response.status);

  if (response.status >= 400) {
    document.querySelector(".section--main").textContent =
      "error when loading the categories table";

    return;
  }

  const responseHtml = await response.text();
  document.querySelector(".section--main").innerHTML = responseHtml;
}
