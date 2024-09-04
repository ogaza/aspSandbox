const submitBtn = document.querySelector(".search__submit");
const form = document.querySelector("form");

submitBtn.addEventListener("click", handleSubmit);

function handleSubmit(e) {
  e.preventDefault();

  console.log(form);

  sendSearchRequest();
}

function sendSearchRequest() {}
