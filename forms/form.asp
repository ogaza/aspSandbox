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
      <label for="name">Name</label>
      <input type="text" name="name" value="<%=name%>" />
    </fieldset>
    <fieldset>
      <label for="email">Email</label>
      <input type="text" name="email" value="<%=m_sCompanyEmail%>" />
    </fieldset>
    <fieldset>
      <% RenderChkBox "soberity", "Is sober", isSober %>
    </fieldset>
    <fieldset>
      <button type="submit">submit</button>
    </fieldset>
  </form>
</div>
<%
End Sub
%>


