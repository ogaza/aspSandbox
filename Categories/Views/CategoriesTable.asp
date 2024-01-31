<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
AuthenticateApiRequest
%>

<!--#include virtual="/DB/iDBPointer.asp"-->

<!-- main page content -->
<%
Call Delay()
Call RejectSometimesWithUnauthorizedStatus()
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