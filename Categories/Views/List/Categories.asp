<!--#include virtual="/Auth/Services/Authservice.asp"-->
<%
' AuthenticateApiRequest
%>
<!--#include virtual="/Categories/Views/List/qTable/override.asp"-->
<!--#include virtual="/qTable/QuickTable.asp"-->

<!-- main page content -->
<%
Call Delay()
' Call RejectSometimesWithUnauthorizedStatus()
Call InsertQuickTable()
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