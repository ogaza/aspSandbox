<%@ Page Language="C#" %>
<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm.aspx.cs" Inherits="AspSandbox.Web.WebForm" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

  <%
    string firstName = (string)(Session["APXLOGIN.Password"]);
    string token = (string)(Session["CSRF_SECURITY_TOKEN"]);
    string isLoggedIn = (string)(Session["APXLOGIN"]);

    if (firstName == null)
    {
      firstName = "null";
    }

    if (token == null)
    {
      token = "no token";
    }

    if (isLoggedIn == null)
    {
      isLoggedIn = "no login";
    }
  %>

  <div>

    <table>
      <tr>
        <td>
          first name
        </td>
        <td>
          <%=  firstName %>
        </td>
      </tr>
      <tr>
        <td>
          token
        </td>
        <td>
          <%=  token %>
        </td>
      </tr>
      <tr>
        <td>
          is logged in
        </td>
        <td>
          <%=  isLoggedIn %>
        </td>
      </tr>

    <%
    foreach (var key in Request.Cookies.AllKeys) 
    {
      %>
      <tr>
        <td>
          <%= key %>
        </td>
        <td>
          <%= Request.Cookies.Get(key).Value %>
        </td>
      </tr>
      <%
    }
    %>

    </table>
    
  </div>

</body>
  
</html>
