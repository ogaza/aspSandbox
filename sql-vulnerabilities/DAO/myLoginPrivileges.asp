<%
Function myLoginPrivileges__select(loginId)
  Dim sql
  sql = _
  "DECLARE @loginId INT = ?; " & vbCrLf &_
  "SELECT " & vbCrLf &_
  "  CanCreateNewFacility, " & vbCrLf &_
  "  OtherFlag, " & vbCrLf &_
  "  BBTransfer  " & vbCrLf &_
  "FROM " & vbCrLf &_
  "  myLoginPrivileges " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  loginId = @loginId " & vbCrLf

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  oRs.Open cmd ', ,adOpenStatic, adLockReadOnly
  ' Set oRs = cmd.Execute

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)

  ReDim arr(oRs.RecordCount - 1)
  Dim row(2)
  Dim idx : idx = 0
  While Not oRs.EOF

    row(0) = oRs.Fields.Item(0)
    row(1) = oRs.Fields.Item(1)
    row(2) = oRs.Fields.Item(2)

    arr(idx) = row

    oRs.MoveNext
    idx = idx + 1
  Wend

  oRs.Close
  Set oRs = Nothing

  myLoginPrivileges__select = arr
End Function

Function myLoginPrivileges__insert(loginid, canCreateNewFacility, otherFlag, bbTransfer)
	myLoginPrivileges__insert = False

  Dim sql 
  sql = _
  "DECLARE @loginid int = ?; " & vbCrLf &_
  "DECLARE @CanCreateNewFacility bit = ?; " & vbCrLf &_
  "DECLARE @OtherFlag bit = ?; " & vbCrLf &_
  "DECLARE @BBTransfer bit = ?; " & vbCrLf &_
  "INSERT INTO  " & vbCrLf &_
  "  myLoginPrivileges " & vbCrLf &_
  "  ( " & vbCrLf &_
  "    loginid, " & vbCrLf &_
  "    CanCreateNewFacility, " & vbCrLf &_
  "    OtherFlag, " & vbCrLf &_
  "    BBTransfer " & vbCrLf &_
  "  ) " & vbCrLf &_
  "VALUES " & vbCrLf &_
  "( " & vbCrLf &_
  "  @loginid,  " & vbCrLf &_
  "  @CanCreateNewFacility, " & vbCrLf &_
  "  @OtherFlag, " & vbCrLf &_
  "  @BBTransfer " & vbCrLf &_
  "); " & vbCrLf
  
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginid)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , canCreateNewFacility)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , otherFlag)
  cmd.Parameters.Append cmd.CreateParameter( , adBoolean, adParamInput, , bbTransfer)

  On Error Resume Next
  cmd.Execute
  On Error Goto 0
  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    Exit Function
  End If
  myLoginPrivileges__insert = True
End Function
%>