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
          <a href="http://localhost:9090/qTablePages/qTablePage.asp">QTable Page</a>
        </li>
      </ul>
      <a href="http://localhost:9090/index.asp">Index Page</a>
    </section>
  </main>
</div>
