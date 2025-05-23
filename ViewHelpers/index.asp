
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>View Holepers</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../views/styles/normalize.css" />
<link rel="stylesheet" href="styles/index.css" />
<script src="js/validation.js" defer type="module"></script>

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

Dim m_dtStatusEffectiveDate
m_dtStatusEffectiveDate = Request.QueryString("StatusEffectiveDate")
If m_dtStatusEffectiveDate = "" Then
  m_dtStatusEffectiveDate = "2017-04-05 15:36:35.000"
End If

Function DisplayRequestData()
%>
<div class="request-data-summary">
  <div class="summary-item">
    <div>
      m_bActive:
    </div>
    <div>
      <%=m_bActive%>
    </div>
  </div>

  <div class="summary-item">
    <div>
      LCase(CStr(True))
    </div>
    <div>
      <%=LCase(CStr(True))%>
    </div>
  </div>

  <div class="summary-item">
    <div>
      IsBoolean(m_bActive)
    </div>
    <div>
      <%=IsBoolean(m_bActive)%>
    </div>
  </div>

  <div class="summary-item">
    <div>
      m_dtStatusEffectiveDate
    </div>
    <div>
      <%=m_dtStatusEffectiveDate%>
    </div>
  </div>

  <div class="summary-item">
    <div>
      CheckForSafeStringParameter(True, m_dtStatusEffectiveDate)
    </div>
    <div>
      <%=CheckForSafeStringParameter(True, m_dtStatusEffectiveDate)%>
    </div>
  </div>
</div>
<%
End Function
%>
<!-- end of asp code-->

<!-- page header  -->
<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<!-- content wrapper -->
<div class="wrapper">
  <main class="main">
    <section class="section--main">
      <!-- main page content here -->
      <div>
        Main page
      </div>
      <div>
        <form id="myForm" name="myForm">

          <input
            type="hidden"
            id="errors"
            name="errors"
            value="error 1"
            data-target="myCheckbox"
          >
          <input
            type="hidden"
            id="errors"
            name="errors"
            value="error 1"
            data-target="myCheckbox"
          >

          <div class="form-item">
            <div class="form-item__label">
              Select item
            </div>
            <div class="form-item__input">
              <%
              Dim options
              options = recAccountHolder__select(1)
              ' options = GetSelectOptions()
              Call SelectOption("test", options)
              %>
            </div>
          </div>

          <div class="form-item">
            <div class="form-item__label">
              Select Yes or No
            </div>
            <div class="form-item__input">
              <%
              Call iUtils_YesNoOption("rdoOpen", m_bActive, False)
              %>
            </div>
          </div>

          <div class="form-item">
            <div class="form-item__label">
              Select date
            </div>
            <div class="form-item__input">
              <INPUT
                type="date"
                name="StatusEffectiveDate"
                value="<%=m_dtStatusEffectiveDate%>"
                style="color:Gray"
                >
            </div>
          </div>

          <div class="form-item">
            <div class="form-item__label">
              <label for="myCheckbox">This is a checkbox</label>
            </div>
            <div class="form-item__input">
              <input type="checkbox" id="myCheckbox" name="myCheckbox">
              <input
                type="hidden"
                id="myCheckbox_error"
                name="myCheckbox_error"
                value="field must be checked"
                data-target="myCheckbox"
              >
            </div>
          </div>

          <!--
          -->
          <button type="submit">Submit</button>
        </form>
      </div>
    </section>
  </main>
  <%
  DisplayRequestData
  %>
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
