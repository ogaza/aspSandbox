<%
' the same as CategoriesApi.asp but this api uses CategoriesRepo.js
' instead of CategoriesRepo.asp
 %>

<%
response.ContentType="application/json"
%>

<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
AuthenticateApiRequest
%>

<!--#include virtual="/DB/iDBPointer.asp"-->
<script src="/Categories/Domain/Repos/CategoriesRepo.js" runat="server" language="javascript"></script>

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
  
  success = obj.UpdateString("id", element.id)
  success = obj.UpdateString("name", element.name)
  success = obj.UpdateString("description", element.description)

  i = i + 1
Next

arr.EmitCompact = 0
Dim result
result = arr.Emit()

response.Write(result)
%>