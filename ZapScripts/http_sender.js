var HtmlParameter = Java.type("org.parosproxy.paros.network.HtmlParameter");
var htmlParamTypeForm = org.parosproxy.paros.network.HtmlParameter.Type.form;
var ScriptVars = org.zaproxy.zap.extension.script.ScriptVars;

var csfrTokenName = "c16e";
var regex = /name\s*=\s*"c16e"\s*value\s*=\s*"([^"]*)"/;
var csfrTokenValue = "4d90d9e6adfc8f86b06d634fca481d5b";

function sendingRequest(msg, initiator, helper) {
  print("sending request with the ");
  print("HEADER: ");
  print("---------------------------------------");
  print(msg.getRequestHeader().toString());

  var requestBody = msg.getRequestBody().toString();

  var httpMethod = msg.getRequestHeader().getMethod();
  var contentType = msg.getRequestHeader().getHeader("content-type");
  var isFormPOST = contentType === "application/x-www-form-urlencoded";

  var formParam;
  var formParams = msg.getFormParams().toArray();
  var containsCSFRparam = false;

  print("---------------------------------------");
  print("form params: ");
  print(formParams);

  for (var i = 0; i < formParams.length; i++) {
    formParam = formParams[i];

    if (formParam.name === csfrTokenName) {
      containsCSFRparam = true;
      break;
    }
    //print("name  : " + formParam?.name);
    //print("value : " + formParam?.value);
  }

  if (isFormPOST && !containsCSFRparam) {
    csfrTokenValue = ScriptVars.getGlobalVar("csrf_token.value");

    print("---------------------------------------");
    print("ADDING CSRF TOKEN");
    print("csfrTokenValue from global ScriptVars: " + csfrTokenValue);
    print("---------------------------------------");

    var formParams = msg.getFormParams();

    if (requestBody.length !== 0) requestBody += "&";
    requestBody += csfrTokenName + "=" + encodeURIComponent(csfrTokenValue);
    msg.setRequestBody(requestBody);
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
