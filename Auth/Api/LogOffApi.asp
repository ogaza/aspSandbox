<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%
Call LogOff()

Response.Redirect("/auth/views/loginForm/loginForm.asp")
%>
