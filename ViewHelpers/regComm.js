function iUtils_onCancel() {
  window.location = "/myModule/mypage.asp";
}

function iUtils_checkDblQuotes(element) {
  var allItem, i;
  var a = '"';
  allItem = element;
  if (allItem != null) {
    if (allItem.length != null) {
      for (i = 0; i < allItem.length; i++) {
        var s = allItem[i].value;
        if (s.indexOf(a) != -1) {
          alert("The input data can not contain the " + '"' + " character.");
          return false;
        }
      }
    }
  }
  return true;
}
