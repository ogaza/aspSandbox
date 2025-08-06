
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Page With QTable</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../common/styles/normalize.css" />
<link rel="stylesheet" href="../common/styles/index.css" />
<link rel="stylesheet" href="./qTablePage.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/AuthService.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
%>

<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>
        Main page
      </div>
      <div class="table-container">
        <%
        Call GetAndDisplayData()
        %>
      </div>
    </section>
    <a href="http://localhost:9090/qTablePages/index.asp">Index page</a>
  </main>
</div>

<%

Function GetAndDisplayData()

  Dim oQTable, oRs, sSql

  Dim VerraDevDatabase
  VerraDevDatabase = "File Name=C:\Components\_aspSandbox\verra.local.UDL;"

  Dim oConn
  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraDevDatabase)

  sSql = "SELECT * FROM Customers"
  ' sSql = "SELECT TOP 10 * FROM Customers"

  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient ' So QTable can set the adors.Sort property
  oRs.CursorType = adOpenStatic ' So QTable can use the adors.RecordCount property

  On Error Resume Next
  Call oRs.Open(sSql, oConn)
  On Error Goto 0

  Set oQTable = Server.CreateObject("Crossoft.QuickTable")
  Set oQTable.adors = oRs

  with oQTable
    .recordsperpage = "5"
    .button.imagedir = "/qTablePages/ImgTable"
    ' .sort = False
    .display.nav = true
    .html = CsrHiddenInputElement
    .build
  end with
  set oQTable = Nothing

  oConn.Close
End Function
%>