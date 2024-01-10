const form = document.querySelector("form");
form.addEventListener("submit", hendleSubmit);

const result = document.querySelector("#action-result");

function hendleSubmit(e) {
  e.preventDefault();

  const requestBody = createRequestBodyFromFormData(new FormData(form));
  sendRequest(requestBody, onCreated);
}

async function sendRequest(requestBody, callback) {
  const response = await fetch("http://localhost:9090/views/test/post.asp", {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: requestBody,
  });

  callback(response);
}

function createRequestBodyFromFormData(formData) {
  return Array.from(formData, createBodyPartFromFormEntry).join("&");
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
}
