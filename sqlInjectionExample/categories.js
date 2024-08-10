// document.querySelector(".section--main").textContent = "...loading";

const urlToSafeSource =
  "http://localhost:9090/sqlInjectionExample/categoriesTable_safe.asp?id=1";
// this link has sql inside the id query string param - OR 1 = 1
const urlToVulnerableSource =
  "http://localhost:9090/sqlInjectionExample/categoriesTable_vulnerable.asp?id=1 OR 1 = 1";

getData();

async function getData() {
  const response = await fetch(urlToVulnerableSource);

  console.log(response.status);

  if (response.status >= 400) {
    document.querySelector(".section--main").textContent =
      "error when loading the categories table";

    return;
  }

  const responseHtml = await response.text();
  document.querySelector(".section--main").innerHTML = responseHtml;
}
