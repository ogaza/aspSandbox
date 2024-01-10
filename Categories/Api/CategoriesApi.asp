<%
response.ContentType="application/json"
%>

<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
AuthenticateApiRequest
%>

<!--#include virtual="/Categories/Domain/Repos/CategoriesRepo.asp"-->
<%

Dim categories
Set categories = GetCategories()

set arr = Server.CreateObject("Chilkat_9_5_0.JsonArray")

Dim i
i = 0

For Each element In categories
  ' Add an empty object at the 1st JSON array position.
  success = arr.AddObjectAt(i)
  ' Get the object we just created.
  ' obj is a Chilkat_9_5_0.JsonObject
  Dim obj
  Set obj = arr.ObjectAt(i)
  
  success = obj.UpdateString("id", element.Id)
  success = obj.UpdateString("name", element.Name)
  success = obj.UpdateString("description", element.Description)

  i = i + 1
Next

arr.EmitCompact = 0
Dim result
result = arr.Emit()

response.Write(result)
%>