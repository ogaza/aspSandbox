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
