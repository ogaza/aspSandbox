
<!--#include virtual="/Categories/Views/List/qTable/override.asp"-->
<!--#include virtual="/qTable/SearchPopup/SearchPopup.asp"-->
<!--#include virtual="/qTable/Spinner/spinner.asp"-->

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>List of categories</title>

    <!-- 
      defer means that the js file will be downloaded ater the whole DOM is ready
      module enables using the import/export syntax
     -->
    <script src="index.js" defer type="module"></script>
    <link rel="stylesheet" href="../../../styles/index.css" />
    <link rel="stylesheet" href="../../../qTable/Spinner/spinner.css" />
    <link rel="stylesheet" href="../../../qTable/client/index.css" />
    <link rel="stylesheet" href="./styles/categories.css" />
  </head>
  <body>
    <div class="page">
      <div class="page__header"></div>
      <div class="page__navbar"></div>
      <div class="page__content">
        <div class="categories">
          <div class="categories__header">
            <a class="search__button"></a>
          </div>
          <div class="categories__table"></div>
          <%
          Call RenderSpinner()
          %>
        </div>
      </div>
      <div class="page__footer"></div>

      <%
      Dim searchParams 
      searchParams = GetSearchParamDefinitions()
      RenderSearchPopup(searchParams)
      %>
    </div>
  </body>
</html>
