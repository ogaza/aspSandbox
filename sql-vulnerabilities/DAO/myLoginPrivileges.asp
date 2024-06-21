<%
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