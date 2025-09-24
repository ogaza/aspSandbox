<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then

  Dim myuserid
  Set myuserid = Request.Form("myuserid")

  Dim mypassword
  Set mypassword = Request.Form("mypassword")

  ' Dim c16e
  ' Set c16e = Request.Form("c16e")

  If myuserid = "test" And mypassword = "1" Then
    Session("APXLOGIN") = True
    Session("APXLOGIN.id") = myuserid
    Response.Redirect("/")
  Else
  %>
  <div>wrong username or password</div>
  <a href="../">back</a>
  <%
  End If
End If

If Request.ServerVariables("REQUEST_METHOD") = "GET" Then
  Dim isLogOff : isLogOff = Request.QueryString("logoff")

  If isLogOff = "1" Then
    Session.Contents.RemoveAll
    Session.Abandon
    Response.Redirect("/")

    %>
    <div>logged-off</div>
    <a href="../">back</a>
    <%
  End If

End If
%>