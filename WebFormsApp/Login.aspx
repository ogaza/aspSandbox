<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AspSandbox.Web.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
</head>
<body>
  <form runat="server">
    <input type="text" id="NameIpt" name="NameIpt" runat="server"/>
    <input type="text" id="Val" name="Val" runat="server"/>
    <input type="submit" runat="server" onserverclick="Login_Click"/>
  </form>
</body>
</html>
