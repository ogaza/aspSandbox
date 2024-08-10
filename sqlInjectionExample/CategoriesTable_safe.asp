<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
AuthenticateApiRequest
%>

<!--#include virtual="/DB/iDBPointer.asp"-->

<!-- main page content -->
<%
Dim id : id = Request.QueryString("id")
' Call Delay()
Call InsertCategoriesTable()
%>

<%
Sub InsertCategoriesTable()
  Dim sSql 
  sSql = _
  "SELECT CategoryID, CategoryName, Description FROM dbo.Categories " &_
  "WHERE CategoryID = ? "

  Dim oCmd : Set oCmd = Server.CreateObject("ADODB.Command")
  oCmd.CommandType = adCmdText
  oCmd.ActiveConnection = DefaultDatabase
  oCmd.CommandText = sSql

  oCmd.Parameters.Append oCmd.CreateParameter( , adInteger, adParamInput, , id)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorType = adOpenStatic
  oRs.CursorLocation = adUseClient
  oRs.Open oCmd

  Dim oQTable : Set oQTable = Server.CreateObject("Crossoft.QuickTable")
  oQTable.sort = False
  Set oQTable.adors = oRs
  Set oRs = Nothing

  With oQTable
    .build
  End With

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
