<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>login</title>

<link rel="stylesheet" href="loginForm.css" />
<!-- <script src="loginForm.js" defer type="module"></script> -->


<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->

<%
RedirectAuthorizedToRootPage
%>

<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<%
Dim url, formUrl

formUrl = "http://localhost:9090/Auth/Actions/LogIn.asp"
url = Request.QueryString("url")


If url <> "" Then
  formUrl = formUrl & "?url=" & Server.URLEncode(url)
End If
%>

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <div class="form-container">
        <form
          class="form form--login"
          action="<%=formUrl%>"
          method="POST"
        >
          <%
          ' FormCsrfHiddenInput
          %>

          <input type="text" name="myuserid" class="form-input" />
          <input type="password" name="mypassword" class="form-input" />
          <input
            type="submit"
            name="submitAction"
            class="button--submit"
            value="Save"
          />
        </form>
      </div>
    </section>
  </main>
</div>

<div id="action-result"></div>
