<%
If (Session("APXLOGIN") <> True) Then
  Response.Redirect("/?msg=Your session has expired because of inactivity. Please log in again.")
End If
%>