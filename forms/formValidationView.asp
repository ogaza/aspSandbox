<%
Sub RenderFieldValidationResult(fieldName, fieldLabel, validationErrorMessages)
%>
<div class="form-validation-result">
  <div>
    <a href="javascript:fnFieldFocus(document.forms[0].<%=fieldName%>)">
      <%=fieldLabel%>
    </a>
  </div>
  <% 
  Dim i : i = 0
  For i = 0 To UBound(validationErrorMessages)
    RenderFieldValidationInfo validationErrorMessages(i)
  Next
  %>
</div>
<%
End Sub
%>

<%
Sub RenderFieldValidationInfo(info)
If Trim(info) = "" Then Exit Sub
%>
<div>
  <%=info%>
</div>
<%
End Sub
%>

<%
' prints the script tag
' which defines global variable validationResult
' with the structure of
' {
'    "fieldName": { errors: [errorMsg_0]}
' }
'
Sub RenderScriptWithFieldValidationResult(validationResults)
%>
<script language="JavaScript">
  var validationResult =  
  {
    <% 
    Dim validationResult
    Dim i : i = 0
    For i = 0 To UBound(validationResults)
      validationResult = validationResults(i)
      Dim fieldName : fieldName = validationResult(0)
      Dim errors : errors = validationResult(2)
    %>
    <% Response.Write("""" & fieldName & """") %> : {
      errors: [
      <%
      Dim j : j = 0
      For j = 0 To UBound(errors)
        If Trim(errors(j)) <> "" Then
        Response.Write("""" & errors(j) & """,")
        End If
      Next
      %>
      ]
    },
    <%
    Next
    %>
  };

  console.log("form validation result: ", validationResult);

  Object.keys(validationResult)
    .forEach(markInvalidFieldset);
  
  function markInvalidFieldset(fieldName) {
    const isValid = validationResult[fieldName].errors.length == 0;

    if(isValid) return;

    document.forms[0].querySelector(`[name='${fieldName}']`)
      .parentNode.className = "invalid";
  }
</script>
<%
End Sub
%>

<%
' prints the script tag
' which defines global variable validationResult
' with the structure of
' {
'    "fieldName": [ errorMsg_0, ... ]
' }
'
Sub RenderScriptWithSingleFieldValidationResult(fieldName, validationErrorMessages)
%>
<script language="JavaScript">
  var validationResult =  
  {
    ...validationResult,
    <% Response.Write("""" & fieldName & """") %> : [
    <% 
    Dim i : i = 0
    For i = 0 To UBound(validationErrorMessages)
      If Trim(validationErrorMessages(i)) <> "" Then
        Response.Write("""" & validationErrorMessages(i) & """,")
      End If
    Next
    %>
    ]
  };
</script>
<%
End Sub
%>

