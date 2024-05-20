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
  ' type 
  ' '/> <script language='javascript'>alert()</script>
  ' to any input
  ' to inject a script through the following asp code:
  For i = 1 To Request.Form("inpt").Count
    ' Response.Write("<div>" & Request.Form("inpt")(i) & "</div>")
    
  Next
  ' checking if some experssions used in verra are unsafe
  ' for example FormatNumber seems to be safe 
  ' and there is no need to wrap it with one on the Reform functions
  ' on the other hand Replace(Replace( ... is not safe
  Dim someNumber : someNumber = Reform.HtmlEncode(Replace(Replace(Replace(Replace(Replace(Replace(Request.Form("inpt")(1),"_x0020_"," "), "_x002C_", ","), "_x002F_", "/"), "_x0023_", ""), "_x0028_", "("), "_x0029_", ")"))
  ' Dim someNumber : someNumber = FormatNumber(Request.Form("inpt")(1))
  Response.Write("<div>" & someNumber & "</div>")

  ' TODO:
  ' maybe we should use Server.URLEncode(...)
  ' for attributes like href?
%>
<%
  ' Response.Redirect("/Categories/Views/")
End If
 %>