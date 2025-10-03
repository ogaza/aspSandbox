<%
If (Request.QueryString("logoff") = "1") then
  Session.Contents.RemoveAll
  Session.Abandon
  ' Redirect to the application home page - this will initialize the new session
  Response.Redirect "/?msg=logged off"
end if
%>

<title>ASP Sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="http://localhost:9090/common/normalize.css" />
<link rel="stylesheet" href="http://localhost:9090/common/layout.css" />
<link rel="stylesheet" href="http://localhost:9090/common/myPageHeader.css" />
<link rel="stylesheet" href="http://localhost:9090/common/form.css" />
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/include/ApxSecurity.inc.asp"-->

<!-- end of asp includes -->

<!-- page header  -->
<%
MyPageHeader
%>

<%
Dim formUrl
formUrl = "./auth/checkLogIn.asp"
%>

<!-- content wrapper -->
<div class="wrapper">
  <%
  If IsLoogedIn() Then
  %>
  <nav class="nav">
    <a href="./page.asp">Second Page</a>
  </nav>
  <%
  End If
  %>
  <main class="main">
    <section class="login-section">
      <%
      If IsLoogedIn() Then
      %>
      <div>
        Logged-in as: <b><%=Session("APXLOGIN.id")%></b>
      </div>
      <div>
        APXLOGIN: <b><%=Session("APXLOGIN")%></b>
      </div>
      <%
      Else
      %>
      <form
        class="form form--login"
        action="./auth/checkLogIn.asp"
        method="POST"
      >
        <%
        FormCsrfHiddenInput
        %>
        <label>
          Log in form
        </label>
        <input type="text" name="myuserid" class="form-input" />
        <input type="password" name="mypassword" class="form-input" />
        <input
          type="submit"
          name="submitAction"
          class="button--submit"
          value="Login"
        />
      </form>
      <%
      End If
      %>
    </section>

    <section>
      <%
      If IsLoogedIn() Then
      %>
      <form class="form" method="POST">
        <label>Home Page Form</label>
        <%
        FormCsrfHiddenInput
        %>
        <input name="inpt1" type="text" />
        <input type="submit" value="submit" />
      </form>
      <%
      If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
      Dim inpt1
      Set inpt1 = Request.Form("inpt1")
      %>
      <div class="form-values">
        Form Value: <%=inpt1%>
      </div>
      <%
      End If
      %>
      <%
      Else
      %>
      <div>
        You are not logged-in
      </div>
      <%
      End If
      %>
    </section>
  </main>
</div>

<%
Function MyPageHeader()
%>
<div class="wrapper">
  <div class="common-header">
    ASP Sandbox App
    <%
    If IsLoogedIn() Then
    %>
    <div>
      <a href="http://localhost:9090/?logoff=1">log off</a>
    </div>
    <%
    End If
    %>
  </div>
</div>
<%
End Function
%>

<%
Function IsLoogedIn()
  IsLoogedIn = Session("APXLOGIN")
End Function
%>
