
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>OWASP JS Injections</title>
<!-- links to js and css shoul be at the top in order for them to be placed in the head by the browser-->
<link rel="stylesheet" href="../../views/styles/normalize.css" />
<link rel="stylesheet" href="../owasp.css" />
<link rel="stylesheet" href="onClickInject.css" />

<!-- end of links -->

<!-- includes for asp with code here -->

<!--#include virtual="/Auth/Services/ApxSecurity.inc.asp"-->
<!--#include virtual="/Auth/Services/Authservice.asp"-->
<!--#include virtual="Auth/Filters/AuthFilter.asp"-->

<!-- end of asp includes -->

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
      <div>
        <div>
          Form with a hidden FormCsrfHiddenInput
        </div>
        <div class="divider-64">
        </div>
        <form method="post" id=form1 name=form1 onSubmit="" accept-charset="UTF-8">
          <% FormCsrfHiddenInput %>
          
          <%
            Dim valueOne, valueTwo, is_selected, index, injectScript

            injectScript = "'); alert('injected script"
            
            valueOne = "one"
            valueTwo = "two"
            index = 1
          %>

          <div>
            <input 
              type="checkbox" 
              name="<%=valueOne%>" 
              id="<%=valueOne & "_" & valueTwo%>" 
              value="<%=valueOne & ":" & valueTwo%>" 
              <%If is_selected Then%> checked <%End If %>
              onClick="javascript:onClickPrivelege('<%=valueOne%>','<%=injectScript%>')"
            />
          </div>
          <div>
            <label for="<%=valueOne & "_" & valueTwo%>">
              checkbox with script injected into onClick method
            </label>
          </div>

          <%
          Dim safeInput 
          safeInput = Reform.JsString(injectScript)
          %>
          <div>
            <input 
              type="checkbox" 
              name="<%=valueTwo%>" 
              id="<%=valueTwo%>" 
              value="<%=valueTwo%>" 
              <%If is_selected Then%> checked <%End If %>
              onClick="javascript:onClickPrivelege('<%=valueOne%>','<%=safeInput%>')"
            />
          </div>
          <div>
            <label for="<%=valueTwo%>">
              secured checkbox
            </label>
          </div>

          <div>
            <%
            Dim ptype, cname, lid
            ptype = "(function(){console.log('injected')})()"
            cname = "name"
            lid = 1
            %>
            <input 
              type=checkbox 
              value=<%=ptype%> 
              checked 
              id=<%=cname%> 
              name=checkbox<%=cname%>
              onclick=getprivilege(<%=lid%>,<%=Reform.JsString(ptype)%>) readonly>
          </div>
        </form>
      </div>
    </section>
  </main>
</div>

<script language='javascript'>
function onClickPrivelege (...args) {
  console.log(args);
}
function getprivilege(...args) {
  console.log(args);
}
</script>

<%
' ResponseWriteUnsafe "DOES NOTHING"
' ResponseWriteUnsafe "<BR />Not Define t"

' Dim m_sAction : m_sAction = "test"
' ResponseWriteUnsafe ("<BR>m_sAction = " & Reform.HtmlEncode(m_sAction))
%>
