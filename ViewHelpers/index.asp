
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>View Holepers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../views/styles/normalize.css" />
<link rel="stylesheet" href="style.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/DB/iDB.asp"-->
<!--#include virtual="/DB/iDBPointer.asp"-->
<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->
<!--#include virtual="/sql-vulnerabilities/DAO/recAccountHolder.asp"-->

<!--#include virtual="/sql-vulnerabilities/Request/validation.asp"-->
<!--#include virtual="/ViewHelpers/htmlHelpers.asp"-->

<!-- end of asp includes -->

<!-- asp code here -->
<%
' RedirectIfNotLoggedIn
%>


<%

Dim myCheckbox, m_bActive
' myCheckbox = Request.QueryString("myCheckbox")
' Response.Write("myCheckbox: " & myCheckbox & "</br>")

m_bActive = CStr(True) = Request.QueryString("rdoOpen")
Response.Write("m_bActive: " & m_bActive & "</br>")
Response.Write("LCase(CStr(True)): " & LCase(CStr(True))  & "</br>")
Response.Write("IsBoolean(m_bActive): " & IsBoolean(m_bActive) & "</br>")

Dim m_dtStatusEffectiveDate
m_dtStatusEffectiveDate = Request.QueryString("StatusEffectiveDate")
If m_dtStatusEffectiveDate = "" Then
  m_dtStatusEffectiveDate = "2017-04-05 15:36:35.000"
End If
Response.Write("m_dtStatusEffectiveDate: " & m_dtStatusEffectiveDate & "</br>")
Response.Write("CheckForSafeStringParameter(True, m_dtStatusEffectiveDate): " & CheckForSafeStringParameter(True, m_dtStatusEffectiveDate) & "</br>")

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
        options = recAccountHolder__select(1)
        ' options = GetSelectOptions()
        Call SelectOption("test", options)
        %>
      </div>

      <div class="divider">
      </div>
      <div>
        <form id="myForm" name="myForm">
          <%
          Call iUtils_YesNoOption("rdoOpen", m_bActive, False)
          %>
          <INPUT
            name="StatusEffectiveDate"
            value="<%=m_dtStatusEffectiveDate%>" size="50" style="color:Gray"
          >
          <!--
          <input type="checkbox" id="myCheckbox" name="myCheckbox" >
          <label for="myCheckbox">This is a checkbox</label>
          -->
          <button type="submit">Submit</button>
        </form>
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
