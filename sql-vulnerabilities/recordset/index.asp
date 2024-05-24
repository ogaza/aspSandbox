
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Recordset/Command examples</title>
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
      RecordSetTest
      %>

      <div class="divider">
      </div>

      <%
      CommandTest
      %>

      <div class="divider">
      </div>

      <%
      ExecuteSqlTest
      %>

      <div class="divider">
      </div>

      <%
      SubaccountEditExist()
      %>

      <div class="divider">
      </div>

    </section>
  </main>
</div>

<%
Function SubaccountEditExist()
  On Error Resume Next
  Dim oConn, oCom, oRs, sSql

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.ActiveConnection = oConn

  sSql = "Select * From recSubaccount " & _
        " where rsaname = ? " & _
        " and ahid = ? " & _
        " and rsaid <> ? "
  oCom.CommandText = sSql
  oCom.Parameters(0) = "Default" 'vSubaccName
  oCom.Parameters(1) = 256 'Session("ahid")
  ' oCom.Parameters(1) = "256"
  oCom.Parameters(2) = "416" ' Session("subAccId")
  ' oCom.Parameters(2) = "416; Select * From recSubaccount;"

  Dim result : result = "rsaid: "

  Set oRs = oCom.Execute()
  If (oConn.Errors.Count = 0) Then
    Do While Not oRs.EOF
      result = result & oRs.Fields(0).Value
      oRs.MoveNext 
    Loop
  Else
    result = " there are some sql errors"
  End If

  result = result & " closing connections"
  oRs.Close
  oConn.Close
  Set oRs = Nothing
  Set oConn = Nothing
  Set oCom.ActiveConnection = Nothing

  %>
  <div class="row">
    <div>
      <code>
        <%=sSql%>
      </code>
    </div>
    <div>
      <%=result%>
    </div>
  </div>
  <%
End Function

%>

<%
' shows how to replace 
' statement like connection.Execute ...
' with command.Execute
Sub ExecuteSqlTest

  Dim sql, Rs, nFileID
  'Set TagDB = Server.CreateObject("ADODB.Connection")

  nFileID = "5"
  ' verra-like string concatenation:
  ' sql = "SELECT r.ProjectTypeDescription " &_ 
  '        "FROM recProjectTypesXref x " &_
  '        "INNER JOIN recProjectType r ON r.ProjectType = x.ProjectType " &_
  '        "WHERE x.fiID = " & nFileID
  ' concatenation replacement with parametrized query:
  sql = "SELECT r.ProjectTypeDescription " &_ 
         "FROM recProjectTypesXref x " &_
         "INNER JOIN recProjectType r ON r.ProjectType = x.ProjectType " &_
         "WHERE x.fiID = ? " & vbCrLf

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)

  ' using a command 
  ' we want to replace oConn.Execute(sql) statement
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.ActiveConnection = oConn
  cmd.CommandText = sql
  cmd.CommandType = adCmdText
  ' end command definition
  ' command params
  cmd.Parameters(0) = nFileID

  ' originally in verra:
  ' Set Rs = oConn.Execute(sql)
  ' and here is the replacement using a command:
  Set Rs = cmd.Execute

  Dim result : result = "Description: "
  Do While Not Rs.EOF
    result = result & Rs.Fields(0).Value
    Rs.MoveNext 
  Loop

  Rs.Close
  oConn.Close

  Set oRs = Nothing
  Set oConn = Nothing

%>
  <div class="row">
    <div>
      <code>
        <%=sql%>
      </code>
    </div>
    <div>
      <%=result%>
    </div>
  </div>
<%
End Sub
%>

<%
' this method use recordset with sql query created with 
' unsafe string concatenation 
Sub RecordSetTest

  Dim oConn
  Dim oRs
  Dim sSQL
  Dim nFileID

  nFileID = "5"
  ' nFileID = Request.QueryString("FileID")

  Dim bReturn

  If nFileID <> "" Then
    bReturn = CheckForSafeNumericParameter(nFileID)
  End If

  sSQL = "SELECT r.ProjectTypeDescription " &_ 
         "FROM recProjectTypesXref x " &_
         "INNER JOIN recProjectType r ON r.ProjectType = x.ProjectType " &_
         "WHERE x.fiID = " & nFileID

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)

  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.Open sSQL, oConn, 3, 3

  Dim result : result = "Description: "
  Do While Not oRs.EOF
    result = result & oRs.Fields(0).Value
    oRs.MoveNext 
  Loop

  oRs.Close
  oConn.Close
  Set oRs = Nothing
  Set oConn = Nothing

%>
  <div class="row">
    <div>
      <code>
        <%=sSQL%>
      </code>
    </div>
    <div>
      <%=result%>
    </div>
  </div>
<%
End Sub
%>

<%
' A possible unsafe-string-concatenatioin replacement
' - usinag a command with parameters
Sub CommandTest

  Dim oConn
  Dim oRs
  Dim sSQL
  Dim nFileID

  nFileID = "5"
  ' nFileID = Request.QueryString("FileID")

  Dim bReturn

  If nFileID <> "" Then
    bReturn = CheckForSafeNumericParameter(nFileID)
  End If

  sSQL = "SELECT r.ProjectTypeDescription " &_ 
         "FROM recProjectTypesXref x " &_
         "INNER JOIN recProjectType r ON r.ProjectType = x.ProjectType " &_
         "WHERE x.fiID = ? "

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)
  
  ' using command
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.ActiveConnection = oConn
  cmd.CommandText = sSQL
  cmd.CommandType = adCmdText
  ' end command definition

  ' command params
  cmd.Parameters(0) = nFileID

  Set oRs = cmd.Execute

  Dim result : result = "Description: "
  Do While Not oRs.EOF
    result = result & oRs.Fields(0).Value
    oRs.MoveNext 
  Loop

  oRs.Close
  oConn.Close

  Set oRs = Nothing
  Set oConn = Nothing

%>
  <div class="row">
    <div>
      <code>
        <%=sSQL%>
      </code>
    </div>
    <div>
      <%=result%>
    </div>
  </div>
<%
End Sub
%>

<%
Function CheckForSafeNumericParameter(ByRef sParameter)
' Function CheckForSafeNumericParameter(ByVal bHandle, ByRef sParameter)
  Dim bReturn
  bReturn = (Not IsEmpty(sParameter) And IsNumeric(sParameter))

  If (bReturn) Then
    sParameter = cDbl(sParameter)
  Else
    ' If (bHandle) Then
    '   Call HandleUnsafeNumericParameter(sParameter)
    ' Else
    sParameter = -1
    ' End If
  End If

  CheckForSafeNumericParameter = bReturn
End Function
%>
