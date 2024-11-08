<!--#include virtual="/DB/iDBPointer.asp"-->

<%
Function BuildSearchWhereClause(searchParams)
  BuildSearchWhereClause = ""

  Dim s_SearchClause : s_SearchClause = ""

  Dim param
  For Each param in searchParams
    If param.Value <> "" Then

      If s_SearchClause <> "" Then s_SearchClause = s_SearchClause & " AND "

      s_SearchClause = s_SearchClause & _
                param.Name & " = " & "?"
                ' param.Name & " = " & "@" & param.Name
    End If
  Next

  If s_SearchClause <> "" Then
    BuildSearchWhereClause = "WHERE " & s_SearchClause
  End If

End Function
%>

<%
Function BuildDBCommandFromMainQueryAndSearchParams(mainSql, searchParams)
  Dim sSql, oCom

  GetSearchParamValuesFromForm(searchParams)
  sSql = BuildSqlQueryFromMainQueryAndSearchClause(mainSql, searchParams)

  Set oCom = Server.CreateObject("ADODB.Command")
  oCom.CommandType = adCmdText
  oCom.ActiveConnection = DefaultDatabase
  oCom.CommandText = sSql

  Call AppendParamsToCommand(searchParams, oCom)

  Set BuildDBCommandFromMainQueryAndSearchParams = oCom
End Function
%>

<%
Function GetSearchParamValuesFromForm(ByRef arr)

  Dim item, i : i = 0

  For Each item in arr
    Dim value : value = Request.Form(item.Name)

    If value <> "" Then
      item.Value = value
    End If
  Next

End Function
%>

<%
Function BuildSqlQueryFromMainQueryAndSearchClause(mainSql, searchParams)
  Dim sSql, oCom

  Dim searchClause 
  searchClause = BuildSearchWhereClause(searchParams)
  
  If searchClause = "" Then
    sSql = _
      mainSql
  Else
    sSql = _
      "SELECT * " &_
      "FROM ( " &_
        mainSql &_
      ") M " &_
      searchClause
  End If

  BuildSqlQueryFromMainQueryAndSearchClause = sSql
End Function
%>

<%
Function AppendParamsToCommand(searchParams, oCom)
  Dim param
  For Each param in searchParams
    If param.Value <> "" Then
      oCom.Parameters.Append _ 
        oCom.CreateParameter( , param.ColumnType, adParamInput, param.Size, param.Value)
    End If
  Next
End Function
%>

<%
Function GetSearchParamsFromRS(oRs)
  Dim idx : idx = 0
  ReDim arr(oRs.Fields.Count - 1)
  Dim item, Field
  For Each Field in oRs.Fields
    Set item = New SearchParam

    item.Name = Field.Name
    item.ColumnType = Field.Type

    Set arr(idx) = item
    idx = idx + 1
  Next

  GetSearchParamsFromRS = arr
End Function
%>