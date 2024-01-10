<title>Create Category</title>

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%
RedirectIfNotLoggedIn

CheckCSRF
%>

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <form method="POST" class="form form--create-category">
        <% FormCsrfHiddenInput %>
        <input type="text" name="categoryName" class="form-input" />
        <input
          type="submit"
          name="submitAction"
          class="button--submit"
          value="Save"
        />
      </form>
    </section>
  </main>
</div>

<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  Response.Redirect("/Categories/Views/")
End If
 %>