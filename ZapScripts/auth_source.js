/*
 * This script is: ZAP script to authenticate using oauth2 of Provider: okta
 * Organization_URL = https://your-org.okta.com/
 * client_id        = yourclientid
 * callback_URL     = http://localhost:8000/accounts/oauth2/callback/
 */
var AuthenticationHelper = Java.type(
  "org.zaproxy.zap.authentication.AuthenticationHelper"
);
var HttpRequestHeader = Java.type(
  "org.parosproxy.paros.network.HttpRequestHeader"
);
var HttpHeader = Java.type("org.parosproxy.paros.network.HttpHeader");
var URI = Java.type("org.apache.commons.httpclient.URI");
var ScriptVars = Java.type("org.zaproxy.zap.extension.script.ScriptVars");
var HtmlParameter = Java.type("org.parosproxy.paros.network.HtmlParameter");
var COOKIE_TYPE = org.parosproxy.paros.network.HtmlParameter.Type.cookie;
// The authenticate function will be called for authentications made via ZAP.

// The authenticate function is called whenever ZAP requires to authenticate, for a Context for which this script
// was selected as the Authentication Method. The function should send any messages that are required to do the authentication
// and should return a message with an authenticated response so the calling method.
//
// NOTE: Any message sent in the function should be obtained using the 'helper.prepareMessage()' method.
//
// Parameters:
//		helper - a helper class providing useful methods: prepareMessage(), sendAndReceive(msg), getHttpSender()
//		paramsValues - the values of the parameters configured in the Session Properties -> Authentication panel.
//					The paramsValues is a map, having as keys the parameters names (as returned by the getRequiredParamsNames()
//					and getOptionalParamsNames() functions below)
//		credentials - an object containing the credentials values, as configured in the Session Properties -> Users panel.
//					The credential values can be obtained via calls to the getParam(paramName) method. The param names are the ones
//					returned by the getCredentialsParamsNames() below
function authenticate(helper, paramsValues, credentials) {
  print("Authenticating via JavaScript script...");
  var Organization_URL = decodeURI(paramsValues.get("Organization_URL"));
  var client_id = paramsValues.get("client_id");
  var callback_URL = decodeURI(paramsValues.get("callback_URL"));
  // Primary Authentication (POST)
  var primaryAuthEndpoint =
    Organization_URL.replace(/\/$/, "") + "/api/v1/authn";
  var username = credentials.getParam("username");
  var password = credentials.getParam("password");
  // Build POST Parameters
  var postObj = {
    username: username,
    password: password,
    options: {
      multiOptionalFactorEnroll: false,
      warnBeforePasswordExpired: false,
    },
  };
  var primaryAuthEndpointURI = new URI(primaryAuthEndpoint, false);
  // Build first message
  var firstMsg = helper.prepareMessage();
  firstMsg.setRequestBody(JSON.stringify(postObj));
  firstMsg.setRequestHeader(
    new HttpRequestHeader(
      HttpRequestHeader.POST,
      primaryAuthEndpointURI,
      HttpHeader.HTTP11
    )
  );
  // Set the content type as JSON which is required as per okta
  firstMsg
    .getRequestHeader()
    .setHeader(HttpHeader.CONTENT_TYPE, "application/json");
  firstMsg
    .getRequestHeader()
    .setContentLength(firstMsg.getRequestBody().length());
  // Make the request and receive the response
  helper.sendAndReceive(firstMsg, false);
  // Parse the JSON response and save the new sessionToken in a global var
  var json = JSON.parse(firstMsg.getResponseBody().toString());
  var status = json["status"];
  print(status);
  var sessionToken = json["sessionToken"];
  // If Primary authentication is successful, sessionToken is returned
  if (sessionToken) {
    // Add message to ZAP history.
    AuthenticationHelper.addAuthMessageToHistory(firstMsg);
    // Save the new sessionToken in a global var
    ScriptVars.setGlobalVar("sessionToken", sessionToken);
    // Build body for Second Request
    var secondMsg = helper.prepareMessage();
    var authEndpoint =
      Organization_URL.replace(/\/$/, "") +
      "/oauth2/default/v1/authorize?client_id=" +
      encodeURIComponent(client_id);
    authEndpoint += "&nonce=" + encodeURIComponent("abc");
    authEndpoint += "&redirect_uri=" + encodeURIComponent(callback_URL);
    authEndpoint +=
      "&response_type=code&sessionToken=" + encodeURIComponent(sessionToken);
    authEndpoint += "&state=" + encodeURIComponent("abc");
    authEndpoint +=
      "&scope=" + encodeURIComponent("openid profile email offline_access");
    var authEndpointURI = new URI(decodeURIComponent(authEndpoint), false);
    secondMsg.setRequestHeader(
      new HttpRequestHeader(
        HttpRequestHeader.GET,
        authEndpointURI,
        HttpHeader.HTTP11
      )
    );
    helper.sendAndReceive(secondMsg);
    // Get the status code of the response.
    var secondResponseStatusCode = secondMsg
      .getResponseHeader()
      .getStatusCode();
    // If status code is 302, authorization is successful
    if (secondResponseStatusCode == "302") {
      // Add secondMsg to ZAP history
      AuthenticationHelper.addAuthMessageToHistory(secondMsg);
      // Build the URL to redirect to.
      var redirectURL = secondMsg.getResponseHeader().getHeader("Location");
      print(redirectURL);
      // Build third message.
      var callbackEndpointURI = new URI(redirectURL, false);
      var thirdMsg = helper.prepareMessage();
      thirdMsg.setRequestHeader(
        new HttpRequestHeader(
          HttpRequestHeader.GET,
          callbackEndpointURI,
          HttpHeader.HTTP11
        )
      );
      // get the cookie Parameters from the Request
      var cookies = thirdMsg.getRequestHeader().getCookieParams();
      // build cookie Parameters and add to Request
      var okta_oauth_state = new HtmlParameter(
        COOKIE_TYPE,
        "okta-oauth-state",
        "abc"
      );
      var okta_oauth_nonce = new HtmlParameter(
        COOKIE_TYPE,
        "okta-oauth-nonce",
        "abc"
      );
      cookies.add(okta_oauth_state);
      cookies.add(okta_oauth_nonce);
      thirdMsg.getRequestHeader().setCookieParams(cookies);
      // Send message.
      helper.sendAndReceive(thirdMsg, false);
      // Build the URL to redirect to.
      var sessionCookie = thirdMsg.getResponseHeader().getHeader("Set-Cookie");
      if (sessionCookie !== null) {
        var cookie = sessionCookie.toString();
        var sessionInfo = cookie.split(";")[0].split("=");
        print(
          "Captured set cookie of " + sessionInfo[0] + " " + sessionInfo[1]
        );
        ScriptVars.setGlobalVar("session.key", sessionInfo[0]);
        ScriptVars.setGlobalVar("session.secret", sessionInfo[1]);
      }
      // Authentication flow completed
      return thirdMsg;
    } else {
      print("Error! Authorization was not successful!");
      return secondMsg;
    }
  } else {
    print("Error getting session Token!");
    return firstMsg;
  }

  return firstMsg;
}

// This function is called during the script loading to obtain a list of the names of the required configuration parameters,
// that will be shown in the Session Properties -> Authentication panel for configuration. They can be used
// to input dynamic data into the script, from the user interface (e.g. a login URL, name of POST parameters etc.)
function getRequiredParamsNames() {
  return ["Organization_URL", "client_id", "callback_URL"];
}

// This function is called during the script loading to obtain a list of the names of the optional configuration parameters,
// that will be shown in the Session Properties -> Authentication panel for configuration. They can be used
// to input dynamic data into the script, from the user interface (e.g. a login URL, name of POST parameters etc.)
function getOptionalParamsNames() {
  return ["state", "nonce"];
}

// This function is called during the script loading to obtain a list of the names of the parameters that are required,
// as credentials, for each User configured corresponding to an Authentication using this script
function getCredentialsParamsNames() {
  return ["username", "password"];
}

// This optional function is called during the script loading to obtain the logged in indicator.
// NOTE: although optional this function must be implemented along with the function getLoggedOutIndicator().
//function getLoggedInIndicator() {
//	return "LoggedInIndicator";
//}

// This optional function is called during the script loading to obtain the logged out indicator.
// NOTE: although optional this function must be implemented along with the function getLoggedInIndicator().
//function getLoggedOutIndicator() {
//	return "LoggedOutIndicator";
//}
