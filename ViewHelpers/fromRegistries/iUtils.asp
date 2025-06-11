<%
Function iUtils_OptionList(ByVal oConn, ByVal sSql, _
							ByVal csvSelectedItems, ByVal bMultipleSelection)
	Dim oRs, bItemSelected, selectedItemArray

	On Error Resume Next
	Set oRs = oConn.Execute(sSql)
	On Error Goto 0
	If (oConn.Errors.Count) Then
		Call DisplaySqlError(sSql)
		Set oRs = Nothing
		Exit Function
	End If

	csvSelectedItems = Trim(csvSelectedItems)
	PrintOptionsFrom oRs, csvSelectedItems, bMultipleSelection

	oRs.Close
	Set oRs = Nothing
End Function

Function iUtils_OptionListCom(ByVal oCom, ByVal csvSelectedItems, ByVal bMultipleSelection)
  Dim oRs

  On Error Resume Next
  Set oRs = oCom.Execute()
  On Error Goto 0
  If (oCom.ActiveConnection.Errors.Count) Then
    Call DisplaySqlError(oCom.CommandText)
    Set oRs = Nothing
    Exit Function
  End If

  PrintOptionsFrom oRs, csvSelectedItems, bMultipleSelection

  oRs.Close
  Set oRs = Nothing
End Function

Function PrintOptionsFrom(ByRef oRs, ByVal csvSelectedItems, ByVal bMultipleSelection)

  Dim bItemSelected, selectedItemArray

  csvSelectedItems = Trim(csvSelectedItems)
  If (Not oRs.EOF) Then
    While Not oRs.EOF
      bItemSelected = False
      If (bMultipleSelection And csvSelectedItems <> "") Then
        selectedItemArray = Split(csvSelectedItems, ",")
        For i = 0 To UBound(selectedItemArray)
          If (CStr(Trim(selectedItemArray(i))) = CStr(Trim(oRs.Fields.Item(1)))) Then
            bItemSelected = True
            Exit For
          End If
        Next
      Else
        If (csvSelectedItems <> "") Then
          If ((CStr(csvSelectedItems) = CStr(Trim(oRs.Fields.Item(1))))) Then
            bItemSelected = True
          End If
        End If
      End If
      %>
      <OPTION
        id="<%=Reform.HtmlAttributeEncode(oRs.Fields.Item(0))%>"
        value="<%=Reform.HtmlAttributeEncode(oRs.Fields.Item(1))%>"
        <% If (bItemSelected) Then %>
        selected
        <% End If %>
      >
        <%=Reform.HtmlEncode(oRs.Fields.Item(0))%>
      </OPTION>
    <%
    oRs.MoveNext
    Wend
  Else
    Response.Write(NOT_APPLICABLE)
  End If

End Function


Function iUtils_InputList( _
  ByVal oConn, ByVal sSql, ByVal sName, _
  ByVal csvSelectedItems, ByVal sInputType, _
  ByVal iTableColumns, ByVal iTextFontSize _
)
  Dim oRs

  If (sInputType = "") Then
    Exit Function
  End If

  On Error Resume Next
  Set oRs = oConn.Execute(sSql)
  On Error Goto 0
  If (oConn.Errors.Count) Then
    Call DisplaySqlError(sSql)
    Set oRs = Nothing
    Exit Function
  End If

  PrintInputList oRs, sName, csvSelectedItems, sInputType, iTableColumns, iTextFontSize

  oRs.Close
  Set oRs = Nothing
End Function

Function iUtils_InputListCom( _
  ByVal oCom, ByVal sName, _
  ByVal csvSelectedItems, ByVal sInputType, _
  ByVal iTableColumns, ByVal iTextFontSize _
)
  Dim oRs

  If (sInputType = "") Then
    Exit Function
  End If

  On Error Resume Next
  Set oRs = oCom.Execute()
  On Error Goto 0
  If (oCom.ActiveConnection.Errors.Count) Then
    Call DisplaySqlError(oCom.CommandText)
    Set oRs = Nothing
    Exit Function
  End If

  PrintInputList oRs, sName, csvSelectedItems, sInputType, iTableColumns, iTextFontSize

  oRs.Close
  Set oRs = Nothing
End Function

Function PrintInputList(ByRef oRs, sName, csvSelectedItems, sInputType, iTableColumns, iTextFontSize)

  Dim bItemSelected, selectedItemArray

  If (Not oRs.EOF) Then
  %>
  <TR>
    <%
    Dim iTableColumnIndex, sNewRowHtml, sFontSizeHtml, iSelectedItemIndex
    iTableColumnIndex = 0

    If (isnumeric(iTextFontSize)) Then
      sFontSizeHtml = "size=" & CStr(iTextFontSize)
    End If

    csvSelectedItems = Trim(csvSelectedItems)

    While Not oRs.EOF
      bItemSelected = False
      sNewRowHtml = ""
      iTableColumnIndex = iTableColumnIndex + 1
      If (csvSelectedItems <> "") Then
        selectedItemArray = Split(csvSelectedItems, ",")
        For iSelectedItemIndex = 0 To UBound(selectedItemArray)
          If (CStr(Trim(selectedItemArray(iSelectedItemIndex))) = CStr(Trim(oRs.Fields.Item(1)))) Then
            bItemSelected = True
            Exit For
          End If
        Next
      End If

      If (CInt(iTableColumnIndex) = CInt(iTableColumns)) Then
        sNewRowHtml = "</TR><TR>"
        iTableColumnIndex = 0
      End If

      %>
      <TD>
        <table cellspacing="0" align="left">
          <TR>
            <TD valign=top>
              <INPUT type="<%=Reform.HtmlAttributeEncode(sInputType)%>" name="<%=Reform.HtmlAttributeEncode(sName)%>"
                  value="<%=Reform.HtmlAttributeEncode(oRs.Fields.Item(1))%>" id="<%=Reform.HtmlAttributeEncode(oRs.Fields.Item(0))%>"
                  <%If (bItemSelected) Then%> checked<%End If%>>
            </TD>
            <TD valign=top>
              <FONT <%=sFontSizeHtml%>><%=Reform.HtmlEncode(oRs.Fields.Item(0))%></FONT>
            </TD>
          </TR>
        </TABLE>
      </TD>
      <%
      Response.Write(sNewRowHtml)

      oRs.MoveNext
    Wend
    %>
  </TR>
  <%
  Else
    Response.Write(NOT_APPLICABLE)
  End If
End Function
%>