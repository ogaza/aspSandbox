using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace AspSandbox.Web.Controllers
{
  public class SessionController : ApiController
  {
    // GET api/values
    public IEnumerable<string> Get()
    {
      var session = HttpContext.Current.Session;

      //return Request.Cookies.AllKeys;

      return new string[] { "value1", "value2" };
    }

    // GET api/values/5
    public string Get(int id)
    {
      var session = HttpContext.Current.Session;

      return "value";
    }

    // POST api/values
    public void Post([FromBody] string value)
    {
    }

    // PUT api/values/5
    public void Put(int id, [FromBody] string value)
    {
    }

    // DELETE api/values/5
    public void Delete(int id)
    {
    }
  }
}
