export function getQTableApi(url) {
  return function fetchQTable(body) {
    return fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body
    });
  };
}
