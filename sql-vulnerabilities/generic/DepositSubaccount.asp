<%
Function DepositSubaccount_GetCertificateInfo(TransferBatchId)
  
  Session("ahid") = 6942

  Const LABEL_NO_EXECUTION_DATE = "Immediate"
  Const DOC_GROUP_PROJECT_DOCUMENT_INT = 101

  TransferBatchId = 87630

  Dim sSql 
  sSql = _
  "DECLARE @LABEL_NO_EXECUTION_DATE VARCHAR(50) = ? " & vbCrLf &_
  "DECLARE @DOC_GROUP_PROJECT_DOCUMENT INT = ?; " & vbCrLf &_
  "DECLARE @Session_ahid INT = ?; " & vbCrLf &_
  "DECLARE @TransferBatchId INT = ?; " & vbCrLf &_
  " " & vbCrLf &_
  "SELECT " & vbCrLf &_
  "  [From],  " & vbCrLf &_
  "  Quantity,  " & vbCrLf &_
  "  --MinExDate, " & vbCrLf &_
  "  CASE MinExDate	 " & vbCrLf &_
  "    WHEN '1900-01-01' Then @LABEL_NO_EXECUTION_DATE " & vbCrLf &_
  "    ELSE Convert(VarChar, MinExDate, @DOC_GROUP_PROJECT_DOCUMENT) " & vbCrLf &_
  "  End As MinExDate, " & vbCrLf &_
  "  --MaxExDate, " & vbCrLf &_
  "  IsNull(Convert(VarChar, MaxExDate, @DOC_GROUP_PROJECT_DOCUMENT), @LABEL_NO_EXECUTION_DATE) As MaxExDate,  " & vbCrLf &_
  "  hasROCs " & vbCrLf &_
  "From ( " & vbCrLf &_
  "  SELECT  " & vbCrLf &_
  "    'From' = acc.ahName,   " & vbCrLf &_
  "    Quantity = SUM(hol.rhQuantity), " & vbCrLf &_
  "    Min(IsNull(xxDate, '1900-01-01')) As MinExDate, " & vbCrLf &_
  "    Max(xxDate) As MaxExDate,  " & vbCrLf &_
  "    MAX(CASE WHEN it.code = 'ROC' THEN 1 ELSE 0 END) AS hasROCs " & vbCrLf &_
  "  FROM  " & vbCrLf &_
  "    recHolding hol  " & vbCrLf &_
  "    INNER JOIN recInfo ri  " & vbCrLf &_
  "      ON ri.riID = hol.riID  " & vbCrLf &_
  "    INNER JOIN dbo.recInstrumentType it  " & vbCrLf &_
  "      ON it.InstrumentTypeID = ri.instrumentTypeID " & vbCrLf &_
  "    inner join recAccountHolder acc  " & vbCrLf &_
  "      on acc.ahId = hol.ahIdOwner " & vbCrLf &_
  "  WHERE  " & vbCrLf &_
  "    hol.ahIdPending = @Session_ahid  " & vbCrLf &_
  "    and TransferBatchId in (@TransferBatchId) " & vbCrLf &_
  "  GROUP BY " & vbCrLf &_
  "    acc.ahName " & vbCrLf &_
  ") a ; " 

  Dim cmd 
  Set cmd = Server.CreateObject("ADODB.Command")
  cmd.CommandType = adCmdText
  cmd.CommandText = sSql
  ' cmd.ActiveConnection = TagDB

  cmd.Parameters.Append cmd.CreateParameter( , adVarChar, adParamInput, 50, LABEL_NO_EXECUTION_DATE)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , DOC_GROUP_PROJECT_DOCUMENT_INT)
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , Session("ahid"))
  cmd.Parameters.Append cmd.CreateParameter( , adInteger, adParamInput, , TransferBatchId)

  Dim oRs
  Set oRs = Server.CreateObject("ADODB.Recordset")
  On Error Resume Next
  oRs.Open cmd
  On Error GoTo 0

End Function

%>