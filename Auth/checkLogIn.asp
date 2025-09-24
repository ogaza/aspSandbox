<%
'If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
'End If
%>

<%

Call CheckLogin()

%>

<%
Function CheckLogin

  Dim myuserid
  Set myuserid = Request.Form("myuserid")

  Dim mypassword
  Set mypassword = Request.Form("mypassword")

  If (myuserid = "1" Or myuserid = "test") And mypassword = "1" Then

    Session("APXLOGIN") = True
    Session("APXLOGIN.id") = myuserid
    Response.Redirect("/")

  Else

    Session.Contents.RemoveAll
    Session.Abandon
    Response.Redirect("/?msg=Invalid login name or password.  Please try again.")

    ' Session("APXLOGIN") = True
    ' Session("APXLOGIN.id") = myuserid

  End If

End Function
%>