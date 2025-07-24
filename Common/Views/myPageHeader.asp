<link
  rel="stylesheet"
  href="http://localhost:9090/common/styles/layout.css"
/>
<link
  rel="stylesheet"
  href="http://localhost:9090/common/views/myPageHeader.css"
/>

<div class="wrapper">
  <div class="common-header">
    common header
    <%
    If IsLoogedIn Then
    %>
      <a href="http://localhost:9090/auth/actions/logOffApi.asp">log off</a>
    <%
    Else
    %>
      <a href="http://localhost:9090/Auth/Views/LoginForm.asp">log in</a>
    <%
    End If
    %>
  </div>
</div>


