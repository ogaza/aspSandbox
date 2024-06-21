<%
Function recLogin__insert(loginId, ahId)
	recLogin__insert = False
	If (loginId <= 0 or ahId <= 0) Then 
    Exit Function
  End If
	
	Dim sql
  sql = _
  "DECLARE @loginId INT = ?; " & vbCrLf &_
  "DECLARE @ahId INT = ?; " & vbCrLf &_
  "INSERT INTO " & vbCrLf &_
  "  recLogin(loginId, ahId) " & vbCrLf &_
  "VALUES " & vbCrLf &_
  "  (@loginId, @ahId) " & vbCrLf

  Dim cmd
	Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql
	
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , loginId)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , ahId)

  On Error Resume Next
  cmd.Execute
  On Error GoTo 0

  If (TagDB.Errors.Count > 0) Then
    Call DisplaySqlError(sql)
    Exit Function
	End If
  recLogin__insert = True
End Function

Function recLogin__update(LModules, RModules, LoginId)
	recLogin__update = False

  Dim sql
  sql = _
  "DECLARE @LModules nvarchar(255) = ?; " & vbcrlf &_
  "DECLARE @RModules nvarchar(255) = ?; " & vbcrlf &_
  "DECLARE @LoginId int = ?; " & vbcrlf &_
  "UPDATE " & vbCrLf &_
  "  myLoginModule " & vbCrLf &_
  "SET " & vbCrLf &_
  "  LModules =  @LModules, " & vbCrLf &_
  "  RModules = @RModules " & vbCrLf &_
  "WHERE " & vbCrLf &_
  "  LoginId = @LoginId " & vbCrLf

  Dim cmd
	Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql
	
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, LModules)
  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 255, RModules)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , LoginId)

  On Error Resume Next
  cmd.Execute
  On Error GoTo 0

  If (TagDB.Errors.Count > 0) Then
    Call DisplaySqlError(sql)
    Exit Function
	End If
  recLogin__update = True
End Function
%>