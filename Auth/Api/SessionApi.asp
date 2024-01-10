<%
response.ContentType="application/json"

Dim json
set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")

Dim userIsLoogedIn
userIsLoogedIn = Session("APXLOGIN")

If userIsLoogedIn Then
  success = json.AddStringAt(-1, "loginStatus", "user logged in")
  success = json.AddStringAt(-1, "userId", Session("APXLOGIN.Id"))
  success = json.AddStringAt(-1, "passwordHash", Session("APXLOGIN.PasswordHash"))
  success = json.AddStringAt(-1, "password", Session("APXLOGIN.Password"))
Else
  success = json.AddStringAt(-1, "loginStatus", "no looged in user")
End If

success = json.AddStringAt(-1, "CSRF_SECURITY_TOKEN", Session("CSRF_SECURITY_TOKEN"))

json.EmitCompact = 0
Dim result
result = json.Emit()

response.Write(result)
%>