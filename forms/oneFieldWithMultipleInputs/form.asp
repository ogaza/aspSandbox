<%
Sub RenderForm 
%>
<div class="form-container">
  <h3>Example Form</h3>
  <form name="example-form" method="POST">
    <% FormCsrfHiddenInput %>
    <%
      RenderFieldWithMultipleSameInputs 
    %>
    <fieldset>
      <button type="submit">submit</button>
    </fieldset>
  </form>
</div>
<%
End Sub
%>

<%
Sub RenderFieldWithMultipleSameInputs 
%>
  <fieldset>
    <label for="testCount"><%=TEST_LABEL%> count</label>
    <input 
      type="number" 
      name="testCount" 
      value="<%=m_iTestCount%>" 
      min="0" disabled />
  </fieldset>
  <%
  %>
  <% Dim i %>
  <% For i = LBound(m_sTestArray) To UBound(m_sTestArray) %>
  <fieldset>
    <label for="test"><%=i + 1%></label>
    <input type="text" name="test" value="<%=m_sTestArray(i)%>" />
  </fieldset>
  <% Next %>
<%
End Sub
%>


