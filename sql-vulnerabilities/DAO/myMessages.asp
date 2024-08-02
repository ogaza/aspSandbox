<%
Function myMessages__select(messageId) 
  Set myMessages__select = Nothing

  If messageId = "" Then 
    Exit Function
  End If

  Dim sql
  sql = _
  "DECLARE @messageId INT = ?; " & vbCrLf &_
  "SELECT  " & vbCrLf &_
  "  messageText as Message, " & vbCrLf &_
  "  FORMAT(CAST(CreateDate AS DATETIME), N'dd/MM/yyyy hh:mm:ss tt') as [ReceiveDate] " & vbCrLf &_
  "FROM " & vbCrLf &_
  "  myMessages m, " & vbCrLf &_
  "  myMessageText mt " & vbCrLf &_
  "WHERE  " & vbCrLf &_
  "  m.MessageTextID = mt.MessageTextID  " & vbCrLf &_
  "  AND mID = @messageId " & vbCrLf &_
  "ORDER BY " & vbCrLf &_
  "  createdate desc " & vbCrLf
 
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , messageId)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  On Error Resume Next
  oRs.Open cmd ', ,adOpenStatic, adLockReadOnly
  ' Set oRs = cmd.Execute
  On Error Goto 0
  If (TagDB.Errors.Count) Then
    Set oRs = Nothing
    call DisplaySqlError(sql) 
    Exit Function
  End If
  Dim item
  If Not oRs.EOF Then 
    ' Response.Write("Debug </br>")
    Set item = New MyMessageData
    item.Message = oRs.Fields.Item("Message")
    item.ReceiveDate = oRs.Fields.Item("ReceiveDate")

    Set myMessages__select = item
  End If

  oRs.Close
  Set oRs = Nothing

End Function

Function myMessages__insert(mType, from_Loginid, toid, messageTextID)
	myMessages__insert = False

  Dim sql 
  sql = _
  "DECLARE @mType CHAR(2) = ?; " & vbCrLf &_
  "DECLARE @from_Loginid INT = ?; " & vbCrLf &_
  "DECLARE @toid INT = ?; " & vbCrLf &_
  "DECLARE @messageTextID INT = ?; " & vbCrLf &_
  "INSERT INTO  " & vbCrLf &_
  "  myMessages " & vbCrLf &_
  "  ( " & vbCrLf &_
  "    mType, " & vbCrLf &_
  "    from_Loginid, " & vbCrLf &_
  "    toid, " & vbCrLf &_
  "    messageTextID " & vbCrLf &_
  "  ) " & vbCrLf &_
  "VALUES " & vbCrLf &_
  "( " & vbCrLf &_
  "  @mType,  " & vbCrLf &_
  "  @from_Loginid, " & vbCrLf &_
  "  @toid, " & vbCrLf &_
  "  @messageTextID" & vbCrLf &_
  "); " & vbCrLf
  On Error Resume Next
  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.ActiveConnection = TagDB
  cmd.CommandText = sql

  cmd.Parameters.Append cmd.CreateParameter( , adChar, adParamInput, 2, mType)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , from_Loginid)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , toid)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , messageTextID)

  Dim recordsAffected : recordsAffected = 0
  ' On Error Resume Next
  cmd.Execute recordsAffected
  On Error Goto 0
  If (TagDB.Errors.Count) Then
    Call DisplaySqlError(sSql)
    Exit Function
  End If

  Response.Write("recordsAffected: " & recordsAffected)
  Response.Write("</br>")

  myMessages__insert = recordsAffected > 0
End Function

class MyMessageData
  Private m_Message
  Private m_ReceiveDate

  Public Property Get Message()
    Message = m_Message
  End Property
  Public Property Let Message(param)
    m_Message = param
  End Property

  Public Property Get ReceiveDate()
    ReceiveDate = m_ReceiveDate
  End Property
  Public Property Let ReceiveDate(param)
    m_ReceiveDate = param
  End Property
End Class
%>