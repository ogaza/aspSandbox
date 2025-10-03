var HtmlParameter = Java.type("org.parosproxy.paros.network.HtmlParameter");
var htmlParamTypeForm = org.parosproxy.paros.network.HtmlParameter.Type.form;
var ScriptVars = org.zaproxy.zap.extension.script.ScriptVars;

var csfrTokenName = "c16e";
var regex = /name\s*=\s*"c16e"\s*value\s*=\s*"([^"]*)"/;
var csfrTokenValue; // = "4d90d9e6adfc8f86b06d634fca481d5b";

function sendingRequest(msg, initiator, helper) {
  var requestHeader = msg.getRequestHeader();

  print("sending request");
  print("---------------------------------------");
  print("HEADER: ");
  print("---------------------------------------");
  print(requestHeader.toString());

  var httpMethod = requestHeader.getMethod();
  var isFormPOST = httpMethod === "POST";

  if (isFormPOST) {
    modifyMsgSoTheFormParamsContainCSFR(msg);
  }

  print("---------------------------------------");
  print("BODY: ");
  print("---------------------------------------");
  print(msg.getRequestBody().toString().replace("&", "\n"));
  print("=======================================");
}

function responseReceived(msg, initiator, helper) {
  print("Response received");
  // print("Status code: " + msg.getResponseHeader().getStatusCode());
  print("---------------------------------------");
  print("HEADER: ");
  print("---------------------------------------");
  print(msg.getResponseHeader());
  // print("BODY:")
  // print(msg.getResponseBody());

  const responseBody = msg.getResponseBody().toString();
  const match = responseBody.match(regex);

  if (match && match.length > 0) {
    const csfrToken = match[1];
    print("---------------------------------------");
    print("csfr token from the response:");
    print("---------------------------------------");
    print(csfrToken);

    ScriptVars.setGlobalVar("csrf_token.value", csfrToken);
  }
  print("=======================================");
}

function modifyMsgSoTheFormParamsContainCSFR(msg) {
  var formParams = msg.getFormParams();

  csfrTokenValue = ScriptVars.getGlobalVar("csrf_token.value");

  var containsCSFRparam = false;
  formParams?.forEach(function (e) {
    if (e.getName() == csfrTokenName) {
      e.setValue(csfrTokenValue);
      containsCSFRparam = true;
    }
  });

  if (!containsCSFRparam) {
    var c16e = new HtmlParameter(
      htmlParamTypeForm,
      csfrTokenName,
      csfrTokenValue
    );

    formParams.add(c16e);
  }

  msg.getRequestBody().setFormParams(formParams);
  msg.getRequestHeader().setContentLength(msg.getRequestBody().length());
}
