import { startTheApp } from "../../../qTable/client/app.js";

const searchParams = {
  CategoryID: "",
  CategoryName: "",
  Description: ""
};

window.addEventListener("DOMContentLoaded", bootstrap);

function bootstrap() {
  startTheApp(
    "http://localhost:9090/categories/views/list/categories.asp",
    searchParams
  );
}
