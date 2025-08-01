<title>ASP Sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<!-- <link rel="stylesheet" href="owasp.css" /> -->
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->

<!-- end of asp includes -->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>Test pages</div>
    </section>
    <section>
      <ul>
        <li>
          <a href="http://localhost:9090/Pages/formPage.asp">Form Page</a>
        </li>
        <li>
          <a href="http://localhost:9090/Pages/queryStringPage.asp?queryParam=test">QS Page</a>
        </li>
        <li>
          <a href="http://localhost:9090/Pages/qTablePage.asp">QTable Page</a>
        </li>
        <li>
          <a href="http://localhost:9090/Pages/sqlFormPage.asp">SQL Form Page</a>
        </li>
        <li>
          <a href="http://localhost:9090/Pages/sqlPage_id.asp?id=11">SQL Id Page</a>
        </li>
        <li>
          <a href="http://localhost:9090/Pages/sqlPage_string.asp?ahName=MIRECS">SQL String Page</a>
        </li>
        <li>
          <a href="http://localhost:9090/index.asp">Back</a>
        </li>
      </ul>
    </section>
  </main>
</div>
