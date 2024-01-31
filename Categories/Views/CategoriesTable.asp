<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
AuthenticateApiRequest
%>

<!--#include virtual="/DB/iDBPointer.asp"-->

<!-- main page content -->
<%
Call Delay()
Call InsertCategoriesTable()
%>

<%
Sub InsertCategoriesTable()
	Dim oQTable : Set oQTable = Server.CreateObject("Crossoft.QuickTable")
  oQTable.sort = False

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorType = adOpenStatic

  Dim sSql : sSql = "SELECT CategoryID, CategoryName, Description FROM dbo.Categories"
  Call oRs.Open(sSql, DefaultDatabase)

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
    While counter < 100000
      counter = counter + 1
    Wend
    counter = 0
  Next
End Sub
%>