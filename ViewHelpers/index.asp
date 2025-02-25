
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>View Holepers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../views/styles/normalize.css" />
<link rel="stylesheet" href="style.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->

<!--#include virtual="/ViewHelpers/htmlHelpers.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
' RedirectIfNotLoggedIn
%>
<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>Main page</div>

      <div class="divider-64">
      </div>
      <!-- 
      <div class="divider">
      </div>
      -->
      <!--
      -->
      <div class="row">
        <%
        Dim options
        options = GetSelectOptions()
        Call SelectOption("test", options)
        %>
      </div>

      <div class="divider">
      </div>
      <!--
      -->
    </section>
  </main>
</div>

<%
Function GetSelectOptions()
  ReDim options(1, 2)

  options(0, 0) = 1
  options(0, 1) = "first"
  ' options(0, 2) = True
  
  options(1, 0) = 2
  options(1, 1) = "second"
  options(1, 2) = True

  GetSelectOptions = options
End Function
%>
