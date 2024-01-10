
<%
Sub RedirectAuthorizedToRootPage
  If IsLoogedIn Then
    Response.Redirect("/")
    Response.End
  End If
End Sub
%>