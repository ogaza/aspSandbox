const result = document.querySelector("#action-result");

const form = document.querySelector("form");
form.addEventListener("submit", hendleSubmit);

function hendleSubmit(e) {
  e.preventDefault();

  let requestBody = createRequestBodyFromFormData(new FormData(form));
  requestBody = appendRedirectUrlToTheRequestFormBody(requestBody);

  sendRequest(requestBody, onCreated);
}

async function sendRequest(requestBody, callback) {
  const response = await fetch("http://localhost:9090/auth/api/logInApi.asp", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: requestBody
  });

  callback(response);
}

function createRequestBodyFromFormData(formData) {
  return Array.from(formData, createBodyPartFromFormEntry).join("&");
}

function appendRedirectUrlToTheRequestFormBody(requestBody) {
  const urlSearchParams = new URLSearchParams(window.location.search);
  const redirectUrl = urlSearchParams.get("url");

  if (redirectUrl) {
    return (requestBody += `&redirectUrl=${redirectUrl}`);
  }

  return requestBody;
}

function createBodyPartFromFormEntry(entry) {
  const partOne = encodeURIComponent(entry[0]);
  const partTwo = encodeURIComponent(entry[1]);

  return `${partOne}=${partTwo}`;
}

async function onCreated(response) {
  const responseJson = await response.json();
  console.log(responseJson);
  result.innerHTML = `server responded with: ${JSON.stringify(responseJson)} `;

  setTimeout(() => {
    window.location.href = responseJson.redirectUrl
      ? responseJson.redirectUrl
      : "/";
  }, 1000);
}

// function onCreated(response) {
//   result.innerHTML = `server responded with status: ${response.status}`;
// }
