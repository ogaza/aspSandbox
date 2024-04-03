<%
Sub RenderForm 
%>
<div class="form-container">
  <h3>Example Form</h3>
  <form name="example-form" method="POST">
    <% FormCsrfHiddenInput %>
    <fieldset>
      <label for="companyZip"><%=COMPANY_ZIP_LABEL%></label>
      <input type="text" name="companyZip" value="<%=m_sCompanyZip%>" />
    </fieldset>
    <fieldset>
      <button type="submit">submit</button>
    </fieldset>
  </form>
</div>
<%
End Sub
%>