
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>View Holepers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../common/styles/normalize.css" />
<link rel="stylesheet" href="../common/styles/index.css" />


<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/AuthService.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
' RedirectIfNotLoggedIn
%>

<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<%
Dim id
id = Request.QueryString("id")
%>

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <%
      DisplayData(id)
      %>
    </section>
  </main>
</div>


<%
Function DisplayData(id)

  Dim TagDB
  Set TagDB = Server.CreateObject("ADODB.Connection")

  TagDB.ConnectionString = "Provider=SQLNCLI11;Password=!apx52;Persist Security Info=True;User ID=mirecs-webappuser;Initial Catalog=MIRECS-APP-PRE01;Data Source=emregqa-usw-db4"

  ' TagDB.ConnectionString = "Provider=SQLNCLI11;Password=n0write;Persist Security Info=True;User ID=mirecs-publicuser;Initial Catalog=MIRECS-APP-PRE01;Data Source=emregqa-usw-db4"
  TagDB.Open

  Dim sql
  sql = _
  "SELECT TOP 10 " &_
  "  rhid " &_
  "FROM " &_
  "  recHolding " &_
  "WHERE " &_
  "  rhid = " & CLng(id)

  Dim cmd
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  oRs.Open cmd

  While Not oRs.EOF
    Response.Write("id: " & oRs.Fields.Item(0) & "<br>")

    oRs.MoveNext
  Wend

  oRs.Close
  Set oRs = Nothing

  TagDB.Close
End Function
%>