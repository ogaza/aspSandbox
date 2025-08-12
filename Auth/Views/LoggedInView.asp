<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>logged out</title>

<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->

<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <div>You are logged in as <%=Session("APXLOGIN.Id")%></div>
    </section>
    <a href="http://localhost:9090/index.asp">Index Page</a>
  </main>
</div>
