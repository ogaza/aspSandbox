var HttpRequestHeader = Java.type(
  "org.parosproxy.paros.network.HttpRequestHeader"
);
var HttpHeader = Java.type("org.parosproxy.paros.network.HttpHeader");
var URI = Java.type("org.apache.commons.httpclient.URI");

var ScriptVars = Java.type("org.zaproxy.zap.extension.script.ScriptVars");
var HtmlParameter = Java.type("org.parosproxy.paros.network.HtmlParameter");
var COOKIE_TYPE = org.parosproxy.paros.network.HtmlParameter.Type.cookie;

var HttpRequestHeader = Java.type(
  "org.parosproxy.paros.network.HttpRequestHeader"
);
var HttpHeader = Java.type("org.parosproxy.paros.network.HttpHeader");
var URI = Java.type("org.apache.commons.httpclient.URI");
var ScriptVars = Java.type("org.zaproxy.zap.extension.script.ScriptVars");

// The authenticate function is called whenever ZAP requires to authenticate,
// for a Context for which this script was selected as the Authentication Method.
// The function should send any messages that are required to do the authentication
// and should return a message with an authenticated response

// NOTE:
// Any message sent in the function should be obtained
// using the 'helper.prepareMessage()' method.

function authenticate(helper, paramsValues, credentials) {
  print("----------------------------------------");
  print(new Date().toTimeString());
  print("Authenticating with JS auth script.");

  // Prepare the login request details
  var requestUri = new URI(paramsValues.get("Authentication URL"), false);
  var requestMethod = HttpRequestHeader.POST;

  // Build the request body using the credentials values
  var requestBody =
    "myuserid=" + encodeURIComponent(credentials.getParam("myuserid"));
  requestBody +=
    "&mypassword=" + encodeURIComponent(credentials.getParam("mypassword"));

  // Build the actual message to be sent
  print("Sending ");
  print(requestMethod);
  print(requestUri);
  print("Request body: ");
  print(requestBody);

  var msg = helper.prepareMessage();
  msg.setRequestHeader(
    new HttpRequestHeader(requestMethod, requestUri, HttpHeader.HTTP10)
  );
  msg.setRequestBody(requestBody);
  msg.getRequestHeader().setContentLength(msg.getRequestBody().length());

  // Send the authentication message and return it
  // seconf params tells whether to follow redirects
  helper.sendAndReceive(msg, true);
  print("Received status code: " + msg.getResponseHeader().getStatusCode());

  var responseBody = msg.getResponseBody().toString();
  // print("Received response: " + responseBody);
  var loggedInRegexp = /Logged-in as: <b>.*<\/b>/gi;
  var matchesForLoogedIn = responseBody.match(loggedInRegexp);
  print("logged in matches: " + JSON.stringify(matchesForLoogedIn));

  var isLoggedIn = !!matchesForLoogedIn;
  print("is loggedin: " + isLoggedIn);
  print("matches length: " + (matchesForLoogedIn?.length || 0));

  // var test = ScriptVars.getGlobalVar("test");
  // if(!!test){ test = parseInt(test) + 1; } else { test = 1; }
  // print("Setting global var 'test': " + test);
  // ScriptVars.setGlobalVar("test", test.toString());

  return msg;
}

// This function is called during the script loading
// to obtain a list of the names of the required configuration parameters,
// that will be shown in the Session Properties -> Authentication panel
// for configuration. They can be used to input dynamic data into the script,
// from the user interface (e.g. a login URL, name of POST parameters etc.)
function getRequiredParamsNames() {
  return ["Authentication URL"];
}

// This function is called during the script loading to obtain a list of the
// names of the optional configuration parameters, that will be shown
// in the Session Properties -> Authentication panel for configuration.
// They can be used to input dynamic data into the script, from the user
// interface (e.g. a login URL, name of POST parameters etc.)
function getOptionalParamsNames() {
  return [];
}

// This function is called during the script loading to obtain
// a list of the names of the parameters that are required,
// as credentials, for each User configured corresponding to
// an Authentication using this script
function getCredentialsParamsNames() {
  return ["myuserid", "mypassword"];
}

// This optional function is called during the script loading
// to obtain the logged in indicator.
// NOTE:
// although optional this function must be implemented along
// with the function getLoggedOutIndicator().

//function getLoggedInIndicator() {
//  return "LoggedInIndicator";
//}

// This optional function is called during the script loading
// to obtain the logged out indicator.
// NOTE:
// although optional this function must be implemented along
// with the function getLoggedInIndicator().
//function getLoggedOutIndicator() {
//  return "LoggedOutIndicator";
//}
