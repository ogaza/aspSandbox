using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace AspSandbox.Web
{
  public partial class Login : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Login_Click(object sender, EventArgs e) 
    {
      if (NameIpt.Value == "Olaf")
      {
        SetAspCookie();
        FormsAuthentication.RedirectFromLoginPage("Olaf", true);

        return;
      }
      
      AbandonSessionAndRedirectToLoginPage();
    }

    private void SetAspCookie()
    {
      var c = new HttpCookie("asp.cookie");

      c.Value = "test";
      c.HttpOnly = true;
      c.Secure = true;

      Response.Cookies.Add(c);
    }

    private void AbandonSessionAndRedirectToLoginPage() 
    {
      Session.Abandon();
      Response.Cookies.Remove("asp.cookie");
      FormsAuthentication.SignOut();
      //FormsAuthentication.RedirectToLoginPage();
      Response.Redirect("login.aspx");
    }
  }
}