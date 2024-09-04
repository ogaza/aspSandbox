// document.querySelector(".section--main").textContent = "...loading";

getCategoriesTable();

async function getCategoriesTable() {
  const response = await fetch(
    "http://localhost:9090/categories/views/categoriesTable.asp"
  );

  console.log(response.status);

  if (response.status >= 400) {
    document.querySelector(".table").textContent =
      "error when loading the categories table";

    return;
  }

  const responseHtml = await response.text();
  document.querySelector(".table").innerHTML = responseHtml;
}

async function submitform2(
  X999sort,
  X999field,
  X999paging,
  X999whichpage,
  X999csv,
  X999action,
  X999actionfield
) {
  const X999tablenumber = document.xxxx2.children.X999tablenumber.value;

  const spinner =
    '<div class="spinner">' +
    '  <div class="spinner__overlay"></div>' +
    "</div>";
  const mainSection = document.querySelector(".section--main");
  mainSection.innerHTML = spinner;

  const response = await fetch(
    "http://localhost:9090/categories/views/categoriesTable.asp",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body:
        `X999myquery=&` +
        `X999tablenumber=${X999tablenumber}&` +
        `X999csv=${X999csv}&` +
        `X999sort=${X999sort}&` +
        `X999action=${X999action}&` +
        `X999actionfield=${X999actionfield}&` +
        `X999field=${X999field}&` +
        `X999paging=${X999paging}&` +
        `X999whichpage=${X999whichpage}`
    }
  );

  if (response.status >= 400) {
    document.querySelector(".section--main").textContent =
      "error when loading the categories table";

    return;
  }

  const responseHtml = await response.text();

  mainSection.innerHTML = "";
  mainSection.innerHTML = responseHtml;
}
