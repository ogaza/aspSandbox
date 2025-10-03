var HttpRequestHeader = Java.type("org.parosproxy.paros.network.HttpRequestHeader");
var HttpHeader = Java.type("org.parosproxy.paros.network.HttpHeader");
var URI = Java.type("org.apache.commons.httpclient.URI");
var ScriptVars = Java.type("org.zaproxy.zap.extension.script.ScriptVars");

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
  msg.getRequestHeader().setHeader(HttpHeader.CONTENT_TYPE, "application/x-www-form-urlencoded");
  msg.setRequestBody(requestBody);
  msg.getRequestHeader().setContentLength(msg.getRequestBody().length());

  print("Request header: ");
  print(msg.getRequestHeader().toString());

  // Send the authentication message and return it
  // seconf params tells whether to follow redirects
  helper.sendAndReceive(msg, true);
  print("Received status code: " + msg.getResponseHeader().getStatusCode());
  print("Response header: " + msg.getResponseHeader().toString());

  var responseBody = msg.getResponseBody().toString();
  // print("Received response: " + responseBody);
  var loggedInRegexp = /Logged-in as: <b>.*<\/b>/gi;
  var matchesForLoogedIn = responseBody.match(loggedInRegexp);
  // print("matches length: " + (matchesForLoogedIn?.length || 0));
  // print("logged in matches: " + JSON.stringify(matchesForLoogedIn));
  print(JSON.stringify(matchesForLoogedIn));
  var isLoggedIn = !!matchesForLoogedIn;
  print("is loggedin: " + isLoggedIn);

  // var test = ScriptVars.getGlobalVar("test");
  // if(!!test){ test = parseInt(test) + 1; } else { test = 1; }
  // print("Setting global var 'test': " + test);
  // ScriptVars.setGlobalVar("test", test.toString());

  return msg;
}

// This function is called during the script loading to obtain a list of the names of the required configuration parameters,
// that will be shown in the Session Properties -> Authentication panel for configuration. They can be used
// to input dynamic data into the script, from the user interface (e.g. a login URL, name of POST parameters etc.)
function getRequiredParamsNames(){
	return ["Authentication URL"];
}

// This function is called during the script loading to obtain a list of the names of the optional configuration parameters,
// that will be shown in the Session Properties -> Authentication panel for configuration. They can be used
// to input dynamic data into the script, from the user interface (e.g. a login URL, name of POST parameters etc.)
function getOptionalParamsNames(){
	return [];
}

// This function is called during the script loading to obtain a list of the names of the parameters that are required,
// as credentials, for each User configured corresponding to an Authentication using this script
function getCredentialsParamsNames(){
	return ["myuserid", "mypassword"];
}
