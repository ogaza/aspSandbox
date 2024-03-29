<%
Sub RenderChkBox(name, label, isChecked)
%>
  <label for="<%=name%>"><%=label%></label>
  <% If(isChecked) Then %>
  <input type="checkbox" id="<%=name%>" name="<%=name%>" checked />
  <% Else %>
  <input type="checkbox" id="<%=name%>" name="<%=name%>" />
  <% 
  End If
End Sub
%>

<%
Sub RenderForm 
%>
<div class="form-container">
  <h3>Example Form</h3>
  <form name="example-form" method="POST">
    <% FormCsrfHiddenInput %>
    <fieldset>
      <label for="companyName"><%=COMPANY_NAME_LABEL%></label>
      <input type="text" name="companyName" value="<%=m_sCompanyName%>" />
    </fieldset>
    <fieldset>
      <label for="companyEmail"><%=COMPANY_EMAIL_LABEL%></label>
      <input type="text" name="companyEmail" value="<%=m_sCompanyEmail%>" />
    </fieldset>
    <fieldset>
      <label for="companyZip"><%=COMPANY_ZIP_LABEL%></label>
      <input type="text" name="companyZip" value="<%=m_sCompanyZip%>" />
    </fieldset>
    <fieldset>
      <% RenderChkBox "companyNiceness", COMPANY_IS_NICE_LABEL, m_sCompanyIsNice %>
    </fieldset>
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


