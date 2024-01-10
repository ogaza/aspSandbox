<!--#include virtual="/Auth/User.asp"-->

<%
Function CheckLogin(loginname, currpwd)
  Dim crypto
  set crypto = Server.CreateObject("ApxCryptography.ApxCrypto.1")

  Dim hash
  hash = crypto.HashPassword(currpwd)
  set crypto = Nothing

  Dim loggedInUser
  Set loggedInUser = (New User).Init(loginname, hash, currpwd) 

  Session("APXLOGIN") = True
  Session("APXLOGIN.Id") = loggedInUser.Id
  Session("APXLOGIN.PasswordHash") = loggedInUser.PasswordHash
  Session("APXLOGIN.Password") = loggedInUser.Password
End Function

Function LogOff()
  Session.Contents.RemoveAll
  Session.Abandon
End Function

Sub RedirectIfNotLoggedIn 
  If Not IsLoogedIn() Then
    Response.Redirect("/")
    Response.End
  End If
End Sub

Sub AuthenticateApiRequest 
  Dim userIsLoogedIn
  userIsLoogedIn = Session("APXLOGIN")

  If Not userIsLoogedIn Then
    Response.Status = "401 Unauthorized"
    Response.Write("null")
    Response.End
  End If
End Sub

Function IsLoogedIn()
  IsLoogedIn = Session("APXLOGIN")
End Function

Sub CheckCSRF 
  If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    ' And (InStr(1,Request.ServerVariables("URL"),"CheckLogin.asp",1) = 0 
    ' Or IsNull(Request.ServerVariables("URL"))) 
    Dim multipartFormType
    multipartFormType = Instr(Request.ServerVariables("CONTENT_TYPE"), "multipart/form-data")
    
    If (IsNull(multipartFormType) Or multipartFormType = 0) Then
        Dim forceLogout : forceLogout = false

        If (Request.Form("c16e").Count = 0) Then
            forceLogout = true
        Elseif (Request.Form("c16e")(1) <> Session("CSRF_SECURITY_TOKEN")) Then
            forceLogout = true
        End If

        If forceLogout Then
            ' If we do not have a matching security token on a Form post, cancel the session and redirect to the home page
            ' Do not disclose to the user that this was due to a CSRF issue
            Session.Contents.RemoveAll
            Session.Abandon
            Response.Redirect("/Auth/Views/ForcedLogout/ForcedLogoutView.asp")
            Response.End
        End If
    End If
  End If
End Sub

%>