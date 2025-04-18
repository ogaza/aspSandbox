<%@ Language=VBScript %>
<%
Option Explicit
Response.Expires = -1
%>

<%
Dim TagDB
Set TagDB = Server.CreateObject("ADODB.Connection")

' TagDB.Open("Provider=SQLOLEDB.1;Password=n0write;Persist Security Info=True;User ID=verra-publicuser;Initial Catalog=VERRA-APP-PRE01;Data Source=emregqa-usw-db4")

TagDB.Open("Provider=SQLOLEDB.1;Password=Parowa.01;Persist Security Info=True;User ID=sa;Initial Catalog=VERRA;Data Source=.")

On Error Goto 0

If (TagDB.Errors.Count) Then
Response.Write("Error </br>")
Else
Response.Write("Ok </br>")
End If

Call test__select()

Response.Write("test end")
%>

<%
Function test__select()
  Dim sql
  sql = _
  "SELECT " &_
  "  riid " &_
  "FROM " &_
  "  recInfo "

  Dim cmd
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  oRs.Open cmd

  While Not oRs.EOF

    Response.Write("id: " & oRs.Fields.Item(0) & "<br>")

    oRs.MoveNext
  Wend

  oRs.Close
  Set oRs = Nothing
End Function

%>


