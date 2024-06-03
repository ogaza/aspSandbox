
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

Const STATUS_ACTIVE                 = "ACT"
Const ACCOUNT_TYPE_CODE_ACCT_HOLDER = "TBR"
Const ACCOUNT_TYPE_CODE_RETAIL_AGGREAGTOR = "RAA"
Const ACCOUNT_TYPE_CODE_END_USER = "RPA"

Session("ahid") = 176
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
        GetRecordsAndGenerateSelect
      %>
      </div>

      <div class="divider">
      </div>

    </section>
  </main>
</div>

<%

Sub GetRecordsAndGenerateSelect()
  Dim recordsArray 
  recordsArray = GetRecords()

  ' Dim selectedItems

  ' Response.Write("is null : " & IsNull(selectedItems) )
  ' Response.Write("is empty : " & IsEmpty(selectedItems) )
  Dim selectedItems(1)
  selectedItems(0) = "1424"
  selectedItems(1) = "1519"
  GenerateSelect recordsArray, selectedItems
End Sub

Function GetRecords()

  Dim oConn
  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)


  Dim sql : sql = GetAccountHolderSqlQuery()
  Dim cmd : Set cmd = PrepareGetAccountHoldersCommand(sql)
  cmd.ActiveConnection = oConn

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  oRs.Open cmd ', ,adOpenStatic, adLockReadOnly
  ' Set oRs = cmd.Execute
  
  ReDim arr(oRs.RecordCount - 1)
  Dim row(1)
  Dim idx : idx = 0
  While Not oRs.EOF

    row(0) = oRs.Fields.Item(0)
    row(1) = oRs.Fields.Item(1)

    arr(idx) = row

    oRs.MoveNext
    idx = idx + 1
  Wend

  oRs.Close
  Set oRs = Nothing

  oConn.Close
  Set oConn = Nothing

  GetRecords = arr
End Function
%>

<%
Sub GenerateSelect(rowsArray, slectedItems)
  %>
  <SELECT name="PendingAccount" multiple>
  <%
  Dim isSelected 
  For each row in rowsArray
    isSelected = in_array(row(0), slectedItems)
    GenerateOption row(0), row(1), isSelected
  Next
  %>
  </SELECT>
  <%
End Sub
%>

<%
Sub GenerateOption(id, val, isSelected)
%>
  <OPTION 
    id="<%=Reform.HtmlAttributeEncode(id)%>"
    <% If isSelected Then %> 
    selected
    <% End If %> 
    value="<%=Reform.HtmlAttributeEncode(val)%>"
  >
    <%=Reform.HtmlEncode(id)%>
  </OPTION>
<%
End Sub
%>

<%
Function PrepareGetAccountHoldersCommand(sql)
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  
  cmd.CommandType = adCmdText
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , Session("ahid"))
  cmd.Parameters.Append cmd.CreateParameter( , adChar, adParamInput, 3, STATUS_ACTIVE)
  Dim atTypes
  atTypes = ACCOUNT_TYPE_CODE_ACCT_HOLDER & "," & ACCOUNT_TYPE_CODE_RETAIL_AGGREAGTOR & "," & ACCOUNT_TYPE_CODE_END_USER
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 500, atTypes)

  Set PrepareGetAccountHoldersCommand = cmd
End Function
%>

<%  
Function GetAccountHolderSqlQuery()
  Dim sSql 

  sSql = _
        "DECLARE @ahIDOwner         INT = ? ; " & vbCrLf &_
        "DECLARE @code_ACTIVE   CHAR(3) = ? ; " & vbCrLf &_
        "DECLARE @atTypes NVARCHAR(200) = ? ; " & vbCrLf &_
        " " & vbCrLf &_
        "SELECT TOP 10 " & vbCrLf &_
        "  ah.ahName,  " & vbCrLf &_
        "  ah.ahID  " & vbCrLf &_
        "FROM  " & vbCrLf &_
        "  recAccountHolder ah  " & vbCrLf &_
        "  INNER JOIN AccountStatus actS ON actS.accountStatusId = AH.accountStatusId  " & vbCrLf &_
        "  INNER JOIN recAccountTypeXref atx ON atx.ahid = ah.ahID  " & vbCrLf &_
        "  INNER JOIN recAccountType at ON at.atType = atx.atType  " & vbCrLf &_
        "WHERE  " & vbCrLf &_
        "  ah.ahID <> @ahIDOwner  " & vbCrLf &_
        "  AND @code_ACTIVE = actS.Code  " & vbCrLf &_
        "  AND atx.atType IN (  " & vbCrLf &_
        "    SELECT TRIM(value) " & vbCrLf &_
        "    FROM STRING_SPLIT (@atTypes, ',') " & vbCrLf &_
        "  ) " & vbCrLf &_
        "ORDER BY  " & vbCrLf &_
        "  ahName ; "

  GetAccountHolderSqlQuery = sSql
End Function
%>

<%
Function in_array(elem, array)
  If IsEmpty(array) Or IsNull(array) Then
    in_array = False
    Exit Function
  End If

  in_array = False
  elem = trim(elem)
  Dim idx : idx = 0
  For idx = 0 To UBound(array)
    If trim(array(idx)) = elem Then
      in_array = True
      Exit For
    End If
  Next
End Function
%>

<%
Function iUtils_OptionList_NEW(options, selectedOptions)

  Dim i
  For i = 0 To UBound(options)

  Next
End Function
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
    ByVal oConn, _
    ByVal sSql, _
    ByVal csvSelectedItems, _
    ByVal bMultipleSelection)
  
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