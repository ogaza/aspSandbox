<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
AuthenticateApiRequest
%>

<!--#include virtual="/DB/iDBPointer.asp"-->
<!--#include virtual="/Categories/Views/qTable/qTableTools.asp"-->
<!--#include virtual="/Categories/Views/qTable/getSerachParams/fromForm.asp"-->

<!-- main page content -->
<%
Call Delay()
' Call RejectSometimesWithUnauthorizedStatus()
Call InsertQuickTable()
%>

<%
Function BuildSearchWhereClause(searchParams)
  BuildSearchWhereClause = ""

  Dim s_SearchClause : s_SearchClause = ""

  Dim param
  For Each param in searchParams
    If param.Value <> "" Then

      If s_SearchClause <> "" Then s_SearchClause = s_SearchClause & " AND "

      s_SearchClause = s_SearchClause & _
                param.Name & " = " & "?"
                ' param.Name & " = " & "@" & param.Name
    End If
  Next

  If s_SearchClause <> "" Then
    BuildSearchWhereClause = "WHERE " & s_SearchClause
  End If

End Function

Function AppendParamsToCommand(searchParams, oCom)
  Dim param
  For Each param in searchParams
    If param.Value <> "" Then
      oCom.Parameters.Append _ 
        oCom.CreateParameter( , param.ColumnType, adParamInput, param.Size, param.Value)
    End If
  Next
End Function

%>

<%
Function GetMainQuery()
  GetMainQuery = "SELECT CategoryID, CategoryName, Description FROM dbo.Categories "
End Function

Sub InsertQuickTable()

  Dim searchParams 
  searchParams = GetSearchParamDefinitions()
  GetSearchParamValuesFromForm(searchParams)

  Dim s_SearchClause 
  s_SearchClause = BuildSearchWhereClause(searchParams)

  'DEBUG
  ' Response.Write("s_SearchClause: " & s_SearchClause & "</br>")

  ' Dim param
  ' For Each param in searchParams
  '   If param.Value <> "" Then
  '     Response.Write("name: " & param.Name & "</br>")
  '   End If
  ' Next

	Dim oQTable : Set oQTable = Server.CreateObject("Crossoft.QuickTable")
  oQTable.sort = False

  Dim oRs, oCom

  Dim sSql

  If s_SearchClause = "" Then
    sSql = _
         GetMainQuery()
  Else
    sSql = _
         "SELECT * " &_
         "FROM ( " &_
            GetMainQuery() &_
         ") M " &_
         s_SearchClause
  End If

  'DEBUG
  ' Response.Write("sSql: " & sSql & "</br></br>")

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = DefaultDatabase
  oCom.CommandText = sSql

  Call AppendParamsToCommand(searchParams, oCom)

  Set oRs = Server.CreateObject("ADODB.Recordset")
  ' oRs.CursorLocation = adUseClient
  oRs.CursorType = adOpenStatic
  On Error Resume Next
  oRs.Open oCom ', ,adOpenStatic, adLockReadOnly

  Set oQTable.adors = oRs

  With oQTable
    .recordsperpage = 2
    .display.nav = true
    .build
  End With

  ' use searchParams instead of building them 
  ' again but using the RecordSet
  RenderSearchColumnsInJS(searchParams)
  ' searchParams = GetSearchParamsFromRS(oRs)
  ' RenderSearchColumnsInJS(searchParams)

  Set oRs = Nothing
	Set oQTable = Nothing
End Sub
%>

<%
Sub Delay 
  Dim counter : counter = 0
  Dim i : i = 1

  For i = 0 To 1000
    While counter < 25000
      counter = counter + 1
    Wend
    counter = 0
  Next
End Sub
%>

<%
Sub RejectSometimesWithUnauthorizedStatus
  Dim min, max
  min = 1
  max = 3
  Dim n : n = GetRnd(min, max)
  If (n mod max = 0) Then
    Response.Status = "401 Unauthorized"
    Response.Write("null")
    Response.End
  End If
End Sub
%>

<%
Function GetRnd(min, max)
  Randomize
  GetRnd = Int((max - min + 1 ) * Rnd + min)
End Function
%>