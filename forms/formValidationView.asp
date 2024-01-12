<%
Sub RenderFieldValidationResult(fieldName, validationErrorMessages)
%>
<div class="form-validation-result">
  <div>
    <a href="#">
      <%=fieldName%>
    </a>
  </div>
  <% Dim i %>
  <% 
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