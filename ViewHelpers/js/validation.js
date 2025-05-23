

function test() {
  const myCheckbox_error = document.forms["myForm"].elements["myCheckbox_error"];


  console.log("myCheckbox_error: ", myCheckbox_error?.value);
  console.log("myCheckbox_error target: ", myCheckbox_error?.dataset?.target);

  const errors = document.forms["myForm"].elements["errors"];

  errors.forEach(printError)
}

function printError(error) {
  console.log("error: ", error?.value);
  console.log("targer elem: ", error?.dataset?.target);
}

test();