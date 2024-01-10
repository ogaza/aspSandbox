<%
response.ContentType="application/json"

Dim json
set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")

' Dim contentType 
' set contentType = Request.ServerVariables("CONTENT_TYPE")
' Dim multipartFormType : multipartFormType = Instr(contentType, "multipart/form-data")
' success = json.AddStringAt(-1, "multipartFormType", multipartFormType)
' success = json.AddStringAt(-1, "contentType", contentType)

Dim nameValue
Set nameValue = Request.Form("name")
success = json.AddStringAt(-1, "name", nameValue)

Dim descriptionValue
Set descriptionValue = Request.Form("description")
success = json.AddStringAt(-1, "description", descriptionValue)

json.EmitCompact = 0
Dim result
result = json.Emit()

response.Write(result)
%>