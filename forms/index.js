async function getData() {
  const response = await fetch(
    "http://localhost:9090/regions/api/regionsApi.asp"
  );
  const responseJSON = await response.json();

  console.log(responseJSON);
}

getData();
