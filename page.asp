<title>ASP Sandbox</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="http://localhost:9090/common/normalize.css" />
<link rel="stylesheet" href="http://localhost:9090/common/layout.css" />
<link rel="stylesheet" href="http://localhost:9090/common/myPageHeader.css" />
<link rel="stylesheet" href="http://localhost:9090/common/form.css" />
<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/SecurityCheck.asp"-->
<!--#include virtual="/include/ApxSecurity.inc.asp"-->

<!-- end of asp includes -->

<!-- page header  -->
<%
MyPageHeader
%>

<!-- content wrapper -->
<div class="wrapper">
  <nav class="nav">
    <a href="../">Home Page</a>
  </nav>
  <main class="main">
    <section class="login-section">
      <div>
        Logged-in as: <b><%=Session("APXLOGIN.id")%></b>
      </div>
    </section>
    <section>
      <form class="form" method="POST">
        <label>Second Page Form</label>
        <%
        FormCsrfHiddenInput
        %>
        <input name="inpt1" type="text" />
        <input name="inpt2" type="text" />
        <input type="submit" value="submit" />
      </form>
      <%
      If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
      Dim inpt1
      Set inpt1 = Request.Form("inpt1")
      Dim inpt2
      Set inpt2 = Request.Form("inpt2")
      %>
      <div class="form-values">
        Form Value: <%=inpt1%>
      </div>
      <div class="form-values">
        Form Value: <%=inpt2%>
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
    <div>
      <a href="http://localhost:9090/?logoff=1">log off</a>
    </div>
  </div>
</div>
<%
End Function
%>
