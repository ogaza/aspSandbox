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
  "WHERE CategoryID = " & id
  ' Response.Write(sSql & "</br>")

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorType = adOpenStatic
  oRs.CursorLocation = adUseClient
  Call oRs.Open(sSql, DefaultDatabase)

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
