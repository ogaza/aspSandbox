export function fetchCategoriesTable(body) {
  return fetch(
    "http://localhost:9090/categories/views/qTable/categoriesTable.asp",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body
    }
  );
}
