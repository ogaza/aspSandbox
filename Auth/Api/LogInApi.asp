<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%
response.ContentType="application/json"

Dim myuserid
Set myuserid = Request.Form("myuserid")

Dim mypassword
Set mypassword = Request.Form("mypassword")

Dim c16e
Set c16e = Request.Form("c16e")

Dim redirectUrl
Set redirectUrl = Request.Form("redirectUrl")

Dim json
set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")

Call CheckLogin(myuserid, mypassword)

Dim userIsLoogedIn
userIsLoogedIn = Session("APXLOGIN")

If userIsLoogedIn Then
  success = json.AddStringAt(-1, "loginStatus", "logged in")
  success = json.AddStringAt(-1, "userId", Session("APXLOGIN.Id"))
  success = json.AddStringAt(-1, "passwordHash", Session("APXLOGIN.PasswordHash"))
  success = json.AddStringAt(-1, "password", Session("APXLOGIN.Password"))
Else 
  success = json.AddStringAt(-1, "loginStatus", "wrong user name or password")
End If

success = json.AddStringAt(-1, "CSRF_SECURITY_TOKEN", Session("CSRF_SECURITY_TOKEN"))
If Not (redirectUrl Is Nothing) Then
  success = json.AddStringAt(-1, "redirectUrl", redirectUrl)
End If

json.EmitCompact = 0
Dim result
result = json.Emit()

response.Write(result)
%>