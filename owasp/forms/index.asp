<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OWASP - Forms</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../../views/styles/normalize.css" />
<link rel="stylesheet" href="../owasp.css" />
<link rel="stylesheet" href="styles.css" />

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
      <form method="POST" class="form form--create-category">
        <% FormCsrfHiddenInput %>
        <input type="text" name="inpt" class="form-input" />
        <input type="text" name="inpt" class="form-input" />
        <input
          type="submit"
          name="submitAction"
          class="button--submit"
          value="Save"
        />
      </form>
    </section>
  </main>
</div>

<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
%>
<script language="javascript">
  
  var arrInpts = new Array(<%=Request.Form("inpt").Count%>);

  <%
  Dim i, j, currInpt
  For i = 1 To Request.Form("inpt").Count
  
    If Request.Form("inpt")(i) <> "" Then
      currInpt = Reform.JsString(Request.Form("inpt")(i))
    Else
      currInpt = 0
    End If

  
    ' To break the whole form 
    ' type:  
    '       1; alert('injected'); 
    ' or:
    '       ";alert('injected');"
    ' in the second iput field
    '
    %>  
    arrInpts[<%=(i - 1)%>] = new Array(<%=Request.Form("inpt").Count%>);
    <%
    For j = 1 To Request.Form("inpt").Count
    %>
      <%
      ' safely buliding array from many inputs with the same name
      ' - when we have such inputs 
      ' they are represented in the request by array
      ' of strings

      ' to see how the input can be used to inject a script
      ' change the 
      ' Reform.JsString(Req...
      ' into 
      ' Request.Form("i...
      %>
      arrInpts[<%=(i - 1)%>][<%=(j - 1)%>] = "<%=Reform.JsString(Request.Form("inpt")(i))%>";
    <%
    Next
  Next
  %>

  console.log(arrInpts);

</script>
<%
  For i = 1 To Request.Form("inpt").Count
    Response.Write("<div>" & Request.Form("inpt")(i) & "</div>")
  Next
%>
<%
  ' Response.Redirect("/Categories/Views/")
End If
 %>