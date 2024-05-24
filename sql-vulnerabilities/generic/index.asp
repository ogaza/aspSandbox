
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Generic examples</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../../views/styles/normalize.css" />
<link rel="stylesheet" href="style.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn
%>
<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>Main page</div>

      <div class="divider-64">
      </div>

      <%
      GetAndDisplayProjectDescription
      %>

      <div class="divider">
      </div>

    </section>
  </main>
</div>

<%
Sub GetAndDisplayProjectDescription
  Dim sql : sql = CreateSql()

  Dim params(0)
  params(0) = "5"

  Dim result 
  result = ExecuteSql(sql, params, GetRef("ProcessRecordSet"))

  DisplayInRow sql, result
End Sub

Function CreateSql()
  Dim sql
  sql = "SELECT r.ProjectTypeDescription " &_ 
         "FROM recProjectTypesXref x " &_
         "INNER JOIN recProjectType r ON r.ProjectType = x.ProjectType " &_
         "WHERE x.fiID = ? " & vbCrLf

  CreateSql = sql
End Function
%>

<%
Function ExecuteSql(sql, params, handleRecordSet)

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.ActiveConnection = oConn
  cmd.CommandText = sql
  cmd.CommandType = adCmdText

  Dim i : i = 0
  For Each param in params
    cmd.Parameters(i) = param
    i = i + 1
  Next

  Dim Rs
  Set Rs = cmd.Execute

  Dim result
  result = handleRecordSet(Rs)

  Rs.Close
  oConn.Close

  Set oRs = Nothing
  Set oConn = Nothing

  ExecuteSql = result
End Function
%>

<%
Function ProcessRecordSet(Rs)
  Dim result : result = "Description: "
  Do While Not Rs.EOF
    result = result & Rs.Fields(0).Value
    Rs.MoveNext 
  Loop
  ProcessRecordSet = result
End Function
%>

<%
Sub DisplayInRow(cellOne, cellTwo)
%>
  <div class="row">
    <div>
      <code>
        <%=cellOne%>
      </code>
    </div>
    <div>
      <%=cellTwo%>
    </div>
  </div>
<%
End Sub
%>