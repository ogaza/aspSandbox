<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  ' Response.Write "Is POST"

  Dim myuserid
  Set myuserid = Request.Form("myuserid")

  Dim mypassword
  Set mypassword = Request.Form("mypassword")

  Dim c16e
  Set c16e = Request.Form("c16e")

  ' Response.Write "myuserid: " & myuserid & "</br>"
  ' Response.Write "mypassword: " & mypassword & "</br>"

  Call CheckLogin(myuserid, mypassword)

  Dim userIsLoogedIn
  userIsLoogedIn = Session("APXLOGIN")

  If userIsLoogedIn Then
    Response.Redirect("/qTablePages/qTablePage.asp")
    ' Response.Write "Successfully logged in"
    ' Response.Redirect("/")
    ' Response.End
  Else
    Session.Contents.RemoveAll
    Session.Abandon

    ' Response.Status = "401 Unauthorized"

    ' Response.Write "wrong user name or password"
    ' Response.End
    Response.Redirect("/Auth/Views/ForcedLogoutView.asp")
  End If

Else
  Session.Contents.RemoveAll
  Session.Abandon

  Response.Redirect("/Auth/Views/ForcedLogoutView.asp")

  ' Response.Status = "401 Unauthorized"
  ' Response.Write "Unauthorized"
  ' Response.End
End If
%>
