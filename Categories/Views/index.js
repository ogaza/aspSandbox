async function getData() {
  const response = await fetch(
    "http://localhost:9090/categories/api/categoriesApi.asp"
    // "http://localhost:9090/categories/api/categoriesApi2.asp"
  );
  const responseJSON = await response.json();

  console.log(responseJSON);
}

getData();
