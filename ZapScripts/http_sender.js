var HtmlParameter = Java.type("org.parosproxy.paros.network.HtmlParameter");
var htmlParamTypeForm = org.parosproxy.paros.network.HtmlParameter.Type.form;
var ScriptVars = org.zaproxy.zap.extension.script.ScriptVars;

var csfrTokenName = "c16e";
var regex = /name\s*=\s*"c16e"\s*value\s*=\s*"([^"]*)"/;
var csfrTokenValue = "4d90d9e6adfc8f86b06d634fca481d5b";

function sendingRequest(msg, initiator, helper) {
  print("sending request");
  print("HEADER: ");
  print("---------------------------------------");
  print(msg.getRequestHeader().toString());

  var requestBody = msg.getRequestBody().toString();

  var httpMethod = msg.getRequestHeader().getMethod();
  var isFormPOST = (httpMethod === "POST");
  // var contentType = msg.getRequestHeader().getHeader("content-type");
  // var isFormPOST = (contentType === "application/x-www-form-urlencoded");

  var formParam;
  var formParams = msg.getFormParams().toArray();
  // var containsCSFRparam = false;

  // print("---------------------------------------");
  // print("form params: ");
  // print(formParams);

  /*
  for (var i = 0; i < formParams.length; i++) {
    formParam = formParams[i];
    if (formParam.name === csfrTokenName) {
      containsCSFRparam = true;
      break;
    }
  }
  */
  if (isFormPOST) {
    var containsCSFRparam = false;

    csfrTokenValue = ScriptVars.getGlobalVar("csrf_token.value");

    var i = 0;
    var params = msg.getFormParams();
    var iterator = params.iterator();

    while (iterator.hasNext() && i < formParams.length) {
      var param = iterator.next();

      if (param.getName().equals(csfrTokenName)) {
        containsCSFRparam = true;
        param.setValue(csfrTokenValue);
      }

      print("param: ");
      print(param);

      i = i + 1;
    }
    msg.setFormParams(params);

    if(!containsCSFRparam) {
      print("---------------------------------------");
      print("ADDING CSRF TOKEN");
      print("csfrTokenValue from global ScriptVars: " + csfrTokenValue);
      print("---------------------------------------");

      var formParams = msg.getFormParams();

      if (requestBody.length !== 0) requestBody += "&";
      requestBody += csfrTokenName + "=" + encodeURIComponent(csfrTokenValue);
      msg.setRequestBody(requestBody);
    }

    msg.getRequestHeader().setContentLength(msg.getRequestBody().length());
    /*
    var c16e = new HtmlParameter(
      htmlParamTypeForm,
      csfrTokenName,
      csfrTokenValue
    );
    msg.getFormParams().add(c16e);
    */
  }
  print("BODY: ");
  print("---------------------------------------");
  print(msg.getRequestBody().toString());

  print("=======================================");
}

function responseReceived(msg, initiator, helper) {
  const responseBody = msg.getResponseBody().toString();
  const match = responseBody.match(regex);

  if (match && match.length > 0) {
    // match[0] is the full match, match[1] is the first captured group
    const csfrToken = match[1];
    print("got csfr token from the response:" + csfrToken);

    ScriptVars.setGlobalVar("csrf_token.value", csfrToken);
  }
}

function modifyParams(params) {
  var iterator = params.iterator();
  while (iterator.hasNext()) {
    var param = iterator.next();
    // Check if the url parameters has the antiCsrfTokenName in it.
    if (param.getName().equals(antiCsrfTokenName)) {
      var secureTokenValue = param.getValue();
      var antiCsrfTokenValue =
        org.zaproxy.zap.extension.script.ScriptVars.getGlobalVar(
          "anti.csrf.token.value"
        );
      // Check for the value of AntiCsrfTokenName in the existing request with the latest value captured from previous requests.
      if (
        antiCsrfTokenValue != null &&
        !secureTokenValue.equals(antiCsrfTokenValue)
      ) {
        param.setValue(antiCsrfTokenValue);
        break;
      }
    }
  }
  return params;
}
