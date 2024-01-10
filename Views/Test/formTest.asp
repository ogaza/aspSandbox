<script src="formTest.js" defer type="module"></script>

<!--#include virtual="/ViewHelpers/regComm.html"-->
<!--#include virtual="/Views/Common/myPageHeader.asp"-->

<form name=frmCertification>
  <table class="" align="center">
    <tbody class="">
      <tr>
        <td colspan="2" align="center">
          <input type="text" name="name" class="">
          <input type="text" name="description" class="">
        </td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <input type="submit" name="submitAction" class="button--submit" value="Save">
          <input type="button" name="cancel" value="Cancel" class="" onClick="javascript: window.location='/';">
        </td>
      </tr>
    </tbody>
  </table>
</form>

<div id="action-result"></div>