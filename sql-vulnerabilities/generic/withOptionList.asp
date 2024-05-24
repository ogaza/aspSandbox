
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>With Option List</title>
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

      <div class="table-container">
      <%
        GetAndDisplayProjectDescription
      %>
      </div>

      <div class="divider">
      </div>

    </section>
  </main>
</div>

<%

Sub GetAndDisplayProjectDescription
  Dim sql : sql = CreateSql()

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandText = sql

  ' cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , Session("ahid"))
  ' cmd.Parameters.Append cmd.CreateParameter( , adChar, adParamInput, 3, STATUS_ACTIVE)
  ' cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , Session("IsApplicationAdmin"))

  cmd.ActiveConnection = oConn
  cmd.CommandType = adCmdText

  Dim Rs
  Set Rs = cmd.Execute

  ' Dim result 
  ' result = ExecuteSql(sql, params, GetRef("DisplayFormWithSimpleRecordSet"))

  DisplayFormWithSimpleRecordSet(Rs)
  
  Rs.Close
  Set Rs = Nothing

  oConn.Close
  Set oConn = Nothing

End Sub
%>

<%
Sub DisplayFormWithSimpleRecordSet(Rs)
%>
  <table BORDER="1" CELLSPACING="1" CELLPADDING="1">
  <%DisplayTableHeader%>
<%
  Dim counter : counter = 0

  Do Until Rs.EOF
    DisplayTableRow _
        Rs.Fields.Item(0), _
        Rs.Fields.Item(1)
        ' Rs.Fields("Project ID")
        ' transactionId
    
    counter = counter + 1
    Rs.MoveNext
  Loop
%>
  </table>
<%
End Sub
%>

<%
'======================================================================================
'	function:	iUtils_OptionList
'	get data from database and create a list of options for <SELECT>
'	note: 1. this function should go between <SELECT class="SELECT_CLASS" id=select1 name=select1> and </SELECT>
'		  2. the sql statement should select two field, the first field is what is shown on the option list.
'		  2. the second field is the option value.
'======================================================================================
Function iUtils_OptionList( _
    ByVal oConn, ByVal sSql, _
    ByVal csvSelectedItems, ByVal bMultipleSelection)
  
  Dim oRs, bItemSelected, selectedItemArray

  On Error Resume Next
  Set oRs = oConn.Execute(sSql)
  On Error Goto 0
  If (oConn.Errors.Count) Then
    Call DisplaySqlError(sSql)  
    Set oRs = Nothing
    Exit Function
  End If

  csvSelectedItems = Trim(csvSelectedItems)
  If (Not oRs.EOF) Then
    While Not oRs.EOF
      bItemSelected = False
      If (bMultipleSelection And csvSelectedItems <> "") Then
        selectedItemArray = Split(csvSelectedItems, ",")
      dim i
        For i = 0 To UBound(selectedItemArray)
          If (CStr(Trim(selectedItemArray(i))) = CStr(Trim(oRs.Fields.Item(1)))) Then
            bItemSelected = True
            Exit For
          End If
        Next
      Else
        If (csvSelectedItems <> "") Then
          If ((CStr(csvSelectedItems) = CStr(Trim(oRs.Fields.Item(1))))) Then
            bItemSelected = True
          End If
        End If
      End If

      If (bItemSelected) Then
      %>
        <OPTION id="<%=oRs.Fields.Item(0)%>" selected value="<%=oRs.Fields.Item(1)%>">
          <%=oRs.Fields.Item(0)%>
        </OPTION>
      <%Else%>
        <OPTION id="<%=oRs.Fields.Item(0)%>" value="<%=oRs.Fields.Item(1)%>">
          <%=oRs.Fields.Item(0)%>
        </OPTION>
      <%End If
      oRs.MoveNext
    Wend
  Else
    Response.Write(NOT_APPLICABLE)
  End If

  oRs.Close
  Set oRs = Nothing
End Function
%>

<%
Function CreateSql()
  Dim sSql

  ' Dim sqlParamsString
  ' sqlParamsString = sqlParamsString &_
  '   "DECLARE @ahId INT = ? ;" & vbcrlf
  
  sSql = sSql &_ 
        "SELECT TOP 10 " & vbcrlf &_ 
        " rh.rhID, rh.esStatus " & vbcrlf &_
        "FROM " & vbcrlf &_
        " recHolding rh " & vbcrlf

  CreateSql = sSQL
End Function
%>

<%
Sub DisplayTableHeader
%>
  <tr>
    <TD><B>Id</B></TD>
    <TD><B>Status</B></TD>
  </tr>
<%
End Sub
%>

<%
Sub DisplayTableRow(id, status)
%>
  <tr>
    <TD><%=Reform.HtmlEncode(id)%></TD>
    <TD><%=Reform.HtmlEncode(status)%></TD>
    <%
    ' DisplayMyTransactionID transactionId
    %>
  </tr>
<%
End Sub
%>

<%
Function ExecuteSql(sql, params, handleRecordSet)

  ' If Not IsNull(params) Then
  '   Dim i : i = 0
  '   For Each param in params
  '     cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , param)
  '     i = i + 1
  '   Next
  ' End If

  ' Dim Rs
  ' Set Rs = cmd.Execute

  ' Dim result
  ' result = handleRecordSet(Rs)

  ' Rs.Close


  ' Set oRs = Nothing
 

  ' ExecuteSql = result
End Function
%>

<%
Sub DisplayMyTransactionID(transactionId)
%>
  <TD class="MyTransactionIDClass">
    <input type='text' name='MyTransactionID' id='MyTransactionID' value='<%=transactionId%>' type="text" maxlength=50 size=12 />
  </TD>
<%
End Sub
%>

<%
' Function ProcessMultiSelectRecordSet(Rs)
'   Dim result : result = "Description: "
'   Do Until Rs Is Nothing  
'     Do Until Rs.EOF  
'       result = result & Rs.Fields(0).Value & ", "
'       Rs.MoveNext  
'     Loop  

'     Set Rs = Rs.NextRecordset  
'   Loop  

'   ProcessMultiSelectRecordSet = result
' End Function
%>