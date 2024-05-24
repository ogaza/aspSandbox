
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Certificate Transfer Batch</title>
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

Dim m_RhIDList : m_RhIDList = "32003,117731"
Dim m_QuantityList : m_QuantityList = "10,11"

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
  Dim sql : sql = CreateSql2()

  ' DisplayInRow sql, ""

  Dim params(1)
  ' params = Null
  params(0) = "32003"
  params(1) = "117731"

  Dim result 
  result = ExecuteSql(sql, params, GetRef("ProcessRecordSet"))

  ' DisplayInRow "", result
  DisplayInRow sql, result

End Sub

Function CreateSql2()
  Dim sSql, oRs, sSql2, oRs2, SqlKey
    
  ' -------------------------------------------------------
  ' SqlKey = SqlKey & iGisUtils_CertificateKey()
  SqlKey = "  rh.riID as 'Batch ID',  " & vbcrlf
	SqlKey = SqlKey & "       " & "f.fiID AS [Project ID]" & vbcrlf
	SqlKey = SqlKey & "       , " & "fiGenUnitName  AS FacilityName" & "                               " & vbCrLf
	' SqlKey = SqlKey & "       , " & GetFacilityNameColumnSql("", "FacilityName") & "                               " & vbCrLf
	SqlKey = SqlKey & "       , pt.ProjectTypeDescription as [Project Type]                                              " & vbCrLf
	SqlKey = SqlKey & "       , dbo.udf_AdditionalIssuanceCertificationsOnlyForDisplay(rh.riid,';<BR>') as [Additional Certification(s)]" & vbCrLf
	SqlKey = SqlKey & "		  , CONVERT(NVARCHAR(10), pvp.vintagePeriodBegin, 103) + '-' + CONVERT(NVARCHAR(10), pvp.vintagePeriodEnd, 103) AS 'Vintage'	" & vbCrLf
	SqlKey = SqlKey & "       , rh.rhSerialNumber AS 'Serial Number'" & vbCrLf
	SqlKey = SqlKey & "       , rhQuantity AS 'Quantity'                                                           " & vbCrLf
	SqlKey = SqlKey & "       , InstrumentTypeDescription AS [" & CREDIT_TYPE_LABEL & "]                                         " & vbCrLf

  ' -------------------------------------------------------

  sSql = "Select " & vbcrlf
  ssql = sSql & SqlKey & "," & vbCrLf
  ssql = sSql & "1 as 'Other Attributes here'" & vbCrLf & "," & vbcrlf
  sSql = sSql & " '#TRADEQUANTITY#' as 'Trade Quantity'," & vbCrLf
  sSql = sSql & "  CASE WHEN rh.esStatus = '" & STATUS_ACTIVE  & "' THEN 'Transferable' WHEN rh.esStatus = '" & STATUS_BULLETINBOARD  & "' THEN 'Bulletin Board' WHEN rh.esStatus = '" & STATUS_SUBACCOUNT  & "' THEN 'Subaccount' END AS Status," 
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
  sSql = sSql & "WHERE rh.ahIDOwner = " & Session("ahid") & vbcrlf 
  sSql = sSql & "  AND rh.rhRetiredTimeID IS NULL" & vbcrlf 
  sSql = sSql & "  AND rh.rhid in (?)" & vbcrlf
  ' sSql = sSql & "  AND rh.rhid in (#RHID#)" & vbcrlf
	sSql = sSql & " AND ISNULL(rh.esStatus, 'ACT') in ('SUB','ACT','BBO') " & vbcrlf
	If Not(session("IsApplicationAdmin")) Then
	  sSql = sSql & "  and (ISNULL(rsa.satType,'ACT')) <> 'RET'" & vbcrlf
	End If

  Dim I
  Dim lrhid
  Dim lQuantity
  Dim mySelect
  Dim ThisSelect

  lrhid = split(m_RhIDList,",")
  lQuantity = split(m_QuantityList,",")
  For I = 0 To UBound(lrhid)
      ThisSelect = sSQL
      ThisSelect = Replace (ThisSelect, "#TRADEQUANTITY#" , lQuantity(I) )
      ' ThisSelect = Replace (ThisSelect, "#RHID#" , lrhid(I) )
      If (mySelect <> "") Then
          mySelect = mySelect & vbcrlf & " ; " & ThisSelect & vbCrLf
          ' mySelect = mySelect & vbcrlf & " UNION " & ThisSelect & vbCrLf
      Else
          mySelect = mySelect & ThisSelect & vbCrLf
      End If
  Next

  sSql = mySelect
  'sSql = mySelect & "ORDER BY f.fiGenUnitName" & vbCrLf

  CreateSql2 = sSQL
End Function

Function iGisUtils_CertificateKey()
    Dim sSql
	sSql = sSql & "       " & "f.fiID AS [Project ID]" & vbcrlf
	sSql = sSql & "       , " & "fiGenUnitName  AS FacilityName" & "                               " & vbCrLf
	sSql = sSql & "       , pt.ProjectTypeDescription as [Project Type]                                              " & vbCrLf
	sSql = sSql & "       , dbo.udf_AdditionalIssuanceCertificationsOnlyForDisplay(rh.riid,';<BR>') as [Additional Certification(s)]" & vbCrLf
	sSql = sSql & "		  , CONVERT(NVARCHAR(10), pvp.vintagePeriodBegin, 103) + '-' + CONVERT(NVARCHAR(10), pvp.vintagePeriodEnd, 103) AS 'Vintage'	" & vbCrLf
	sSql = sSql & "       , rh.rhSerialNumber AS 'Serial Number'" & vbCrLf
	sSql = sSql & "       , rhQuantity AS 'Quantity'                                                           " & vbCrLf
	sSql = sSql & "       , InstrumentTypeDescription AS [" & CREDIT_TYPE_LABEL & "]                                         " & vbCrLf
	iGisUtils_CertificateKey = sSql
End Function

Function GetFacilityNameColumnSql(ByVal sTableName, ByVal sColumnAliasName)
	Dim sSql, sPlantName, sUnitName

	If "" <> sTableName Then
		sTableName = sTableName & "."
	End If

	sSql = "fiGenUnitName "

    If "" <> sColumnAliasName Then
		sSql = sSql & " AS " & sColumnAliasName
	End If

	GetFacilityNameColumnSql = sSql
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

  If Not IsNull(params) Then
    Dim i : i = 0
    For Each param in params
      cmd.Parameters(i) = param
      i = i + 1
    Next
  End If

  Dim Rs
  Set Rs = cmd.Execute

  Dim result
  result = handleRecordSet(Rs)

  ' Rs.Close
  oConn.Close

  Set oRs = Nothing
  Set oConn = Nothing

  ExecuteSql = result
End Function
%>

<%
' example of handling multi-select statement
' https://learn.microsoft.com/en-us/sql/ado/reference/ado-api/nextrecordset-method-example-vb?view=sql-server-ver16
Function ProcessRecordSet(Rs)
  Dim result : result = "Description: "
  Do Until Rs Is Nothing  
    Do Until Rs.EOF  
      result = result & Rs.Fields(0).Value & ", "
      Rs.MoveNext  
    Loop  
    Set Rs = Rs.NextRecordset  
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

<%
Function CreateSimpliestSql()
  Dim sSql, oRs, sSql2, oRs2

  Dim sqlParamsString
  Dim idx
  For idx = 0 To UBound(split(m_RhIDList,","))
    sqlParamsString = sqlParamsString & "DECLARE @tq_"&idx&" INT = ? ; " & vbcrlf
  Next

  sSql = "Select " & vbcrlf
  sSql = sSql & "#TRADEQUANTITY# as 'Trade Quantity'" & vbCrLf
  sSql = sSql & "FROM recHolding rh " & vbcrlf 
  sSql = sSql & "WHERE rh.rhid in (?) " & vbcrlf

  Dim I
  Dim lrhid
  Dim lQuantity
  Dim mySelect
  Dim ThisSelect

  lrhid = split(m_RhIDList,",")
  lQuantity = split(m_QuantityList,",")
  For I = 0 To UBound(lrhid)
      ThisSelect = sSQL
      ThisSelect = Replace (ThisSelect, "#TRADEQUANTITY#" , "@tq_"&I )
      If (mySelect <> "") Then
          mySelect = mySelect & vbcrlf & " ; " & ThisSelect & vbCrLf
      Else
          mySelect = mySelect & ThisSelect & vbCrLf
      End If
  Next
  sSql = sqlParamsString & mySelect

  CreateSimpliestSql = sSQL
End Function
%>