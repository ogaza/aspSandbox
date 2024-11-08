export const spinner = document.querySelector(".spinner__container");

export function showSpinner() {
  spinner.classList.remove("hidden");
}
export function hideSpinner() {
  spinner.classList.add("hidden");
}
