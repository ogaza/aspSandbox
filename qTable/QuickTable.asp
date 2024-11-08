
<!--#include virtual="/qTable/DAO/DAO.asp"-->
<%
Sub InsertQuickTable()
  Dim searchParams 
  searchParams = GetSearchParamDefinitions()

  Dim oCom
  Set oCom = BuildDBCommandFromMainQueryAndSearchParams(GetMainQuery(), searchParams)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  ' oRs.CursorLocation = adUseClient
  oRs.CursorType = adOpenStatic
  On Error Resume Next
  oRs.Open oCom ', ,adOpenStatic, adLockReadOnly

  Dim oQTable : Set oQTable = Server.CreateObject("Crossoft.QuickTable")
  oQTable.sort = False
  Set oQTable.adors = oRs

  With oQTable
    .recordsperpage = 2
    .display.nav = true
    .build
  End With

  Set oRs = Nothing
	Set oQTable = Nothing
End Sub
%>