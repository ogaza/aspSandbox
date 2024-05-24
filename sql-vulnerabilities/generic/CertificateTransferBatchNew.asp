
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>NEW Certificate Transfer Batch</title>
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

Const STATUS_ACTIVE =        "ACT"
Const STATUS_BULLETINBOARD = "BBO"
Const STATUS_SUBACCOUNT =    "SUB"
Const CREDIT_TYPE_LABEL =    "Unit Type"

Session("ahid") = 176
Session("IsApplicationAdmin") = True

Dim m_RhIDList : m_RhIDList = "32003,117731"
Dim m_QuantityList : m_QuantityList = "10,11"

Dim MyTransactionID : MyTransactionID = "1,2"
Dim MyTransactionIDArray

Dim hasManyTransactionIds : hasManyTransactionIds = False

If Instr(1, MyTransactionID, ",") Then
  hasManyTransactionIds = True
  MyTransactionIDArray = Split(MyTransactionID, ",")
End If

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

  Dim lrhid
  Dim lQuantity

  lrhid = split(m_RhIDList,",")
  lQuantity = split(m_QuantityList,",")

  Set oConn = Server.CreateObject("ADODB.Connection")
  oConn.Open(VerraPreDatabase)

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandText = sql

  Dim I
  For I = 0 To UBound(lrhid)
    cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , lQuantity(I))
    cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , lrhid(I))
  Next
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , Session("ahid"))

  cmd.Parameters.Append cmd.CreateParameter( , adChar, adParamInput, 3, STATUS_ACTIVE)
  cmd.Parameters.Append cmd.CreateParameter( , adChar, adParamInput, 3, STATUS_BULLETINBOARD)
  cmd.Parameters.Append cmd.CreateParameter( , adChar, adParamInput, 3, STATUS_SUBACCOUNT)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , Session("IsApplicationAdmin"))

  cmd.ActiveConnection = oConn
  cmd.CommandType = adCmdText

  ' ReDim params((UBound(lrhid) + 1) * 2)
  ' Dim I
  ' Dim J : J = 0
  ' For I = 0 To UBound(lrhid)
  '   params(J) = lQuantity(I)
  '   params(J + 1) = lrhid(I)
  '   J = J + 2
  ' Next
  ' params(UBound(params)) = Session("ahid")

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
Sub DisplayFormWithSimpleRecordSet(Rs)
%>
  <div class="table-container">
    <table BORDER="1" CELLSPACING="1" CELLPADDING="3" align="left" class="txtBlack8">
    <%DisplayTableHeader%>
<%
    Dim counter : counter = 0

    Do Until Rs.EOF

      Dim transactionId
      If hasManyTransactionIds Then
        transactionId = trim(MyTransactionIDArray(counter))
      Else
        transactionId = MyTransactionID
      End If

      DisplayTableRow _
          Rs.Fields("Project ID"), _
          Rs.Fields("FacilityName"), _
          Rs.Fields("Project Type"), _
          Rs.Fields("Vintage"), _
          Rs.Fields("Serial Number"), _
          Rs.Fields("Quantity"), _
          Rs.Fields("Unit Type"), _
          Rs.Fields("Trade Quantity"), _
          transactionId
      
      counter = counter + 1
      Rs.MoveNext
    Loop

    ' Rs.Close
%>
    </table>
  </div>
<%
End Sub
%>

<%
Function CreateSql()
  Dim sSql, oRs, sSql2, oRs2, SqlKey
  Dim I
  Dim lrhid
  Dim lQuantity

  lrhid = split(m_RhIDList,",")
  lQuantity = split(m_QuantityList,",")
  '-----------------------------------------
  Dim sqlParamsString
  For I = 0 To UBound(lrhid)
    sqlParamsString = sqlParamsString &_
      "DECLARE @tq_"&I&" INT = ? ;" & vbcrlf &_
      "DECLARE @rhId_"&I&" INT = ? ;" & vbcrlf
  Next
  sqlParamsString = sqlParamsString &_
    "DECLARE @ahId INT = ? ;" & vbcrlf

  sqlParamsString = sqlParamsString &_
    "DECLARE @esStatus_ACTIVE        CHAR(3) = ? ;" & vbcrlf
  sqlParamsString = sqlParamsString &_
    "DECLARE @esStatus_BULLETINBOARD CHAR(3) = ? ;" & vbcrlf
  sqlParamsString = sqlParamsString &_
    "DECLARE @esStatus_SUBACCOUNT    CHAR(3) = ? ;" & vbcrlf
  sqlParamsString = sqlParamsString &_
    "DECLARE @IsAdmin BIT = ? ;" & vbcrlf
  
  ' sqlParamsString = sqlParamsString &_
  '   "DECLARE @InstrumentTypeDescription_LABEL    NVARCHAR(50) = ? ;" & vbcrlf
  
  sSql = "Select " & vbcrlf
  ' -------------------------------------------------------
  sSql = sSql & "  rh.riID as 'Batch ID',  " & vbcrlf
	sSql = sSql & "       " & "f.fiID AS [Project ID]" & vbcrlf
	sSql = sSql & "       , " & "fiGenUnitName  AS FacilityName" & "                               " & vbCrLf
	sSql = sSql & "       , pt.ProjectTypeDescription as [Project Type]                                              " & vbCrLf
	sSql = sSql & "       , dbo.udf_AdditionalIssuanceCertificationsOnlyForDisplay(rh.riid,';<BR>') as [Additional Certification(s)]" & vbCrLf
	sSql = sSql & "		  , CONVERT(NVARCHAR(10), pvp.vintagePeriodBegin, 103) + '-' + CONVERT(NVARCHAR(10), pvp.vintagePeriodEnd, 103) AS 'Vintage'	" & vbCrLf
	sSql = sSql & "       , rh.rhSerialNumber AS 'Serial Number'" & vbCrLf
	sSql = sSql & "       , rhQuantity AS 'Quantity'                                                           " & vbCrLf
	sSql = sSql & "       , InstrumentTypeDescription AS [Unit Type]                                         " & vbCrLf
	' sSql = sSql & "       , InstrumentTypeDescription AS [" & CREDIT_TYPE_LABEL & "]                                         " & vbCrLf
  ssql = sSql & "," & vbCrLf
  ' -------------------------------------------------------
  ssql = sSql & "1 as 'Other Attributes here'" & vbCrLf & "," & vbcrlf
  sSql = sSql & " '' + #TRADEQUANTITY# + '' as 'Trade Quantity'," & vbCrLf
  ' sSql = sSql & " '#TRADEQUANTITY#' as 'Trade Quantity'," & vbCrLf
  sSql = sSql & "  CASE WHEN rh.esStatus = @esStatus_ACTIVE THEN 'Transferable' WHEN rh.esStatus = @esStatus_BULLETINBOARD THEN 'Bulletin Board' WHEN rh.esStatus = @esStatus_SUBACCOUNT THEN 'Subaccount' END AS Status," 
  ' sSql = sSql & "  CASE WHEN rh.esStatus = '" & STATUS_ACTIVE  & "' THEN 'Transferable' WHEN rh.esStatus = '" & STATUS_BULLETINBOARD  & "' THEN 'Bulletin Board' WHEN rh.esStatus = '" & STATUS_SUBACCOUNT  & "' THEN 'Subaccount' END AS Status," 
  sSql = sSql & "  rh.rhid," & vbcrlf
  sSql = sSql & "  rh.esStatus AS esStatus," & vbcrlf
  sSql = sSql & "  rh.rsaID AS SubAccount," & vbcrlf 
  sSql = sSql & "  ISNULL(rsa.satType, '') AS SubAccountType," & vbcrlf 
  sSql = sSql & "  it.code AS InstrumentTypeCode" & vbcrlf 
  sSql = sSql & "FROM recHolding rh " & vbcrlf 
  sSql = sSql & "INNER JOIN recInfo ri ON ri.riID = rh.riID" & vbCrLf
  sSql = sSql & "INNER JOIN issuanceRequest ir ON ir.issuanceRequestId = ri.issuanceRequestId" & vbCrLf
  sSql = sSql & "INNER JOIN projectVintagePeriod pvp ON pvp.projectVintagePeriodId = ir.projectVintagePeriodId" & vbCrLf
  sSql = sSql & "INNER JOIN projectEmission pe ON pe.projectEmissionId = pvp.projectEmissionId " & vbCrLf
  sSql = sSql & "INNER JOIN recFacility f ON f.fiID = rh.fiID" & vbCrLf
  sSql = sSql & "INNER JOIN dbo.recInstrumentType it ON it.InstrumentTypeID = ri.instrumentTypeID" & vbCrLf
  sSql = sSql & "INNER JOIN recDimTime dt1 ON dt1.TimeID = ri.TimeID" & vbCrLf
  sSql = sSql & "INNER JOIN recFacilityProgram rfp ON rfp.fiid = rh.fiid" & vbCrLf
  sSql = sSql & "             AND rfp.programId = ri.issuingProgramId" & vbCrLf
  sSql = sSql & "INNER JOIN recProjectType pt ON pt.ProjectType = rfp.ProjectType" & vbCrLf
  sSql = sSql & "LEFT OUTER JOIN recSubAccount rsa ON rsa.rsaid = rh.rsaid" & vbCrLf
  sSql = sSql & "WHERE rh.ahIDOwner = @ahID " & vbcrlf 
  ' sSql = sSql & "WHERE rh.ahIDOwner = " & Session("ahid") & vbcrlf 
  sSql = sSql & "  AND rh.rhRetiredTimeID IS NULL" & vbcrlf 
  sSql = sSql & "  AND rh.rhid in (#RHID#)" & vbcrlf
	sSql = sSql & " AND ISNULL(rh.esStatus, 'ACT') in ('SUB','ACT','BBO') " & vbcrlf
  sSql = sSql & " AND (@IsAdmin = 1 OR (ISNULL(rsa.satType,'ACT') <> 'RET'))"
	' If Not(session("IsApplicationAdmin")) Then
	'   sSql = sSql & "  and (ISNULL(rsa.satType,'ACT')) <> 'RET'" & vbcrlf
	' End If

  Dim mySelect
  Dim ThisSelect

  For I = 0 To UBound(lrhid)
    ThisSelect = sSQL
    ThisSelect = Replace (ThisSelect, "#TRADEQUANTITY#" , "@tq_"&I )
    ThisSelect = Replace (ThisSelect, "#RHID#" , "@rhId_"&I )
    If (mySelect <> "") Then
      mySelect = mySelect & vbcrlf & " UNION " & ThisSelect & vbCrLf
      ' mySelect = mySelect & vbcrlf & " ; " & ThisSelect & vbCrLf
    Else
      mySelect = mySelect & ThisSelect & vbCrLf
    End If
  Next

  sSql = sqlParamsString & mySelect

  CreateSql = sSQL
End Function
%>

<%
Sub DisplayFormUsingMultiSelectRecordSet(Rs)
%>
  <table BORDER="1" CELLSPACING="1" CELLPADDING="3" align="left" class="txtBlack8">
  <%DisplayTableHeader%>
<%
  Dim counter : counter = 0

  Do Until Rs Is Nothing  
    Do Until Rs.EOF

      Dim transactionId
      If hasManyTransactionIds Then
        transactionId = trim(MyTransactionIDArray(counter))
      Else
        transactionId = MyTransactionID
      End If

      DisplayTableRow _
          Rs.Fields("Project ID"), _
          Rs.Fields("FacilityName"), _
          Rs.Fields("Project Type"), _
          Rs.Fields("Vintage"), _
          Rs.Fields("Serial Number"), _
          Rs.Fields("Quantity"), _
          Rs.Fields("Unit Type"), _
          Rs.Fields("Trade Quantity"), _
          transactionId
      
      counter = counter + 1
      Rs.MoveNext
    Loop

    Set Rs = Rs.NextRecordset
  Loop  
%>
  </table>
<%
End Sub
%>

<%
Sub DisplayTableRow(projtId, facName, projType, vintage, serialNo, qty, unitType, tradeQty, transactionId)
%>
  <tr>
    <TD><%=Reform.HtmlEncode(projtId)%></TD>
    <TD><%=Reform.HtmlEncode(facName)%></TD>
    <TD><%=Reform.HtmlEncode(projType)%></TD>
    <TD><%=Reform.HtmlEncode(vintage)%></TD>
    <TD><%=Reform.HtmlEncode(serialNo)%></TD>
    <TD><%=Reform.HtmlEncode(qty)%></TD>
    <TD><%=Reform.HtmlEncode(unitType)%></TD>
    <TD><%=Reform.HtmlEncode(tradeQty)%></TD>
    <%
    DisplayMyTransactionID transactionId
    %>
  </tr>
<%
End Sub
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
Sub DisplayTableHeader
%>
  <tr>
    <TD><B>Project ID</B></TD>
    <TD><B>Project Name</B></TD>
    <TD><B>Project Type</B></TD>
    <TD><B>Vintage</B></TD>
    <TD><B>Serial Number</B></TD>
    <TD><B>Quantity of Units</B></TD>
    <TD><B><%=CREDIT_TYPE_LABEL%></B></TD>
    <TD><B>Transfer Quantity</B></TD>
    <TD class="MyTransactionIDClass"><B>My Transaction ID</B></TD>
  </tr>
<%
End Sub
%>

<%
Function ProcessMultiSelectRecordSet(Rs)
  Dim result : result = "Description: "
  Do Until Rs Is Nothing  
    Do Until Rs.EOF  
      result = result & Rs.Fields(0).Value & ", "
      Rs.MoveNext  
    Loop  

    Set Rs = Rs.NextRecordset  
  Loop  

  ProcessMultiSelectRecordSet = result
End Function
%>