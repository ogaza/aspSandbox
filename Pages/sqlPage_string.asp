
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>View Holepers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../common/styles/normalize.css" />
<link rel="stylesheet" href="../common/styles/index.css" />


<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/include/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/AuthService.asp"-->
<!--#include virtual="/include/iUtils.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
' RedirectIfNotLoggedIn
%>

<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Common/Views/myPageHeader.asp"-->

<%
Dim ahName
ahName = Request.QueryString("ahName")
Call CheckForSafeStringParameter(True, ahName)
%>

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <%
      DisplayData(ahName)
      %>
    </section>
  </main>
</div>


<%
Function DisplayData(ahName)

  Dim TagDB
  Set TagDB = Server.CreateObject("ADODB.Connection")

  TagDB.ConnectionString = "Provider=SQLNCLI11;Password=!apx52;Persist Security Info=True;User ID=mirecs-webappuser;Initial Catalog=MIRECS-APP-DEV01;Data Source=emregqa-usw-db4"

  ' TagDB.ConnectionString = "Provider=SQLNCLI11;Password=n0write;Persist Security Info=True;User ID=mirecs-publicuser;Initial Catalog=MIRECS-APP-PRE01;Data Source=emregqa-usw-db4"
  TagDB.Open

  Dim sql
  sql = _
  "SELECT TOP 10 " & vbCrLf &_
  "  ahID, ahName " & vbCrLf &_
  "FROM " & vbCrLf &_
  "  recAccountHolder " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  ahName LIKE '%' + CONVERT(nvarchar(100), ?) + '%' "
  ' "  ahName LIKE '%' + CONVERT(nvarchar(50), '" & ahName & "') + '%' "
  ' "  ahName LIKE '% CONVERT(nvarchar(50)," & CStr(ahName) & ")%'"
  Response.Write "sql: " & sql & "</br>"

  Dim cmd
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 100, ahName)

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