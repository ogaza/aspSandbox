
<%
response.ContentType="application/json"
' Response.Write("LOGON_USER: " & Request.ServerVariables("LOGON_USER"))

Dim json
set json = Server.CreateObject("Chilkat_9_5_0.JsonObject")

' The only reason for failure in the following lines of code would be an out-of-memory condition..
' An index value of -1 is used to append at the end.
success = json.AddStringAt(-1, "name", "Olaf")
success = json.AddIntAt(-1, "birth_year", 1984)

Dim subJsonString 
subJsonString = "{""city"": ""Krakow"", ""zipCode"": ""30-085"", ""street"":{""name"": ""Glowackiego"",""home"": 30,""apartment"": 30}}"

' First add an empty object at the desired location:
success = json.AddObjectAt(-1,"address")
' Get the JSON object at that location, and load the JSON
' jsonInfo is a Chilkat_9_5_0.JsonObject
Set jsonInfo = json.ObjectOf("address")
succes = jsonInfo.Load(subJsonString)


json.EmitCompact = 0
Dim result
result = json.Emit()

response.Write(result)
%>