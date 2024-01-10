<title>login</title>

<link rel="stylesheet" href="loginForm.css" />
<script src="loginForm.js" defer type="module"></script>


<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->

<%
RedirectAuthorizedToRootPage
%>

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <div class="form-container">
        <form class="form form--login">
          <% FormCsrfHiddenInput %>

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
