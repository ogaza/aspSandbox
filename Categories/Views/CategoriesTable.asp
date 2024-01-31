<title>Categories Table</title>

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->

<%
RedirectIfNotLoggedIn
%>

<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!--#include virtual="/DB/iDBPointer.asp"-->

<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <%
      Call InsertCategoriesTable()
      %>
    </section>
  </main>
</div>

<%
Sub InsertCategoriesTable()
	Dim oQTable : Set oQTable = Server.CreateObject("Crossoft.QuickTable")
  oQTable.sort = False

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorType = adOpenStatic

  Dim sSql : sSql = "SELECT CategoryID, CategoryName, Description FROM dbo.Categories"
  Call oRs.Open(sSql, DefaultDatabase)

  Set oQTable.adors = oRs
  Set oRs = Nothing

  With oQTable
    .build
  End With

	Set oQTable = Nothing
End Sub
%>

<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  Response.Redirect("/Categories/Views/")
End If
 %>