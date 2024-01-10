<link
  rel="stylesheet"
  href="http://localhost:9090/views/templates/layout.css"
/>
<link 
  rel="stylesheet" 
  href="http://localhost:9090/views/common/myPageHeader.css" 
/>

<div class="wrapper">
  <div class="common-header">
    common header
    <%
    If IsLoogedIn Then
    %>
      <a href="http://localhost:9090/auth/api/logOffApi.asp">log off</a>
    <%
    Else
    %>
      <a href="http://localhost:9090/Auth/Views/LoginForm/LoginForm.asp">log in</a>
    <%
    End If
    %>
  </div>
</div>


