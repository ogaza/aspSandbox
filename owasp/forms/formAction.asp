<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OWASP - Form with action</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../../views/styles/normalize.css" />
<link rel="stylesheet" href="../owasp.css" />
<!-- <link rel="stylesheet" href="styles.css" /> -->

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->

<!-- end of asp includes -->

<!-- page header  -->
<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!-- asp code here -->
<%
RedirectIfNotLoggedIn

CheckCSRF
%>
<!-- end of asp code-->

<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content -->
      <%
      ' variable id takes its value from the query string
      ' so to populate it type sth like 
      ' http://localhost:9090/owasp/forms/formAction.asp?id=1
      ' or 
      ' http://localhost:9090/owasp/forms/formAction.asp?id="><script%20language="javascript">alert(1)</script>"
      ' http://localhost:9090/owasp/forms/formAction.asp?id="'><script language="javascript">alert()</script>
      ' or 
      ' http://localhost:9090/owasp/forms/formAction.asp?id=";alert(0)' + click on the "Go back" btn 
      ' if yiu want to see injected script
      ' in the browsers address 
      Dim id
      id = Request.QueryString("id")
      Dim encodedId : encodedId = Reform.HtmlAttributeEncode(id)
      %>
      <form 
        name="testForm" method="POST" class="form form--create-category"
        action="/owasp/forms/formAction.asp?id=<%=encodedId%>"
      >
        <% FormCsrfHiddenInput %>

        <%
        Dim m_sPhase : m_sPhase = "test"
        Dim hiddenIptId : hiddenIptId = "SomeId"
        %>

        <input type="hidden" name="m_sPhase" value="<%=Reform.HtmlAttributeEncode((m_sPhase))%>" />
        <input type="hidden" id="idOf<%=Reform.HtmlAttributeEncode(hiddenIptId)%>" />

        <input type="text" name="inpt" class="form-input" />
        <input type="text" name="inpt" class="form-input" />
        <input
          type="submit"
          name="submitAction"
          class="button--submit"
          value="Save"
        />
      </form>

      <INPUT 
        type="button" 
        class="btn btn-primary btn-sm" 
        name="Back" 
        value="Go back" 
        onClick='javascript:window.location="/owasp/forms/formAction.asp?id=<%=encodedId%>'>
    </section>
  </main>
</div>

<script language="javascript">
  console.log("id as a JsString: ", "<%=Reform.JsString(id)%>");
  console.log("HtmlAttributeEncode(id): ", "<%=Reform.HtmlAttributeEncode(id)%>");
</script>
<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
%>
<%
End If
 %>