<%

Function recAccountHolder__select(ahid)

  Dim TagDB
  Set TagDB = Server.CreateObject("ADODB.Connection")
  TagDB.Open(VerraDevDatabase)

  Dim sSql, oCom, oRs

  sSql = _
  "SELECT distinct TOP 10 " &_
  "  AH.ahName, " &_
  "  AH.ahID " &_
  "FROM " &_
  "  recAccountHolder AH " &_
  "WHERE " &_
  "  AH.ahID <> ? " &_
  "ORDER BY " &_
  "  AH.ahName "

	Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = TagDB
  oCom.CommandText = sSql
	
  oCom.Parameters.Append oCom.CreateParameter( , adInteger, adParamInput, , ahid)

  On Error Resume Next
  Set oRs = Server.CreateObject("ADODB.Recordset")
  oRs.CursorLocation = adUseClient
  oRs.Open oCom
  ' Set oRs = oCom.Execute
  On Error GoTo 0

  Response.Write("oRs.RecordCount: " & oRs.RecordCount)
  Response.Write("</br>")
  
  If (TagDB.Errors.Count) Then
    Set oRs = Nothing

    TagDB.Close
    Set TagDB = Nothing

    call DisplaySqlError(sSql, TagDB)

    Exit Function
  End If

  ReDim arr(oRs.RecordCount - 1, 2)
  ' ReDim arr(1, 2)
  ' Dim row(2)
  Dim idx : idx = 0

  While Not oRs.EOF

    ' Response.Write("oRs.Fields.Item(0): " & oRs.Fields.Item(0))
    ' Response.Write("</br>")

    arr(idx, 0) = oRs.Fields.Item(0)
    arr(idx, 1) = oRs.Fields.Item(1)
    ' arr(idx, 2) = oRs.Fields.Item(2)

    ' arr(idx) = row
    idx = idx + 1
    oRs.MoveNext
  Wend

  oRs.Close
  Set oRs = Nothing

  TagDB.Close
  Set TagDB = Nothing

  recAccountHolder__select = arr

End Function
%>