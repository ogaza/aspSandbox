using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WCFSandbox
{
  [ServiceContract]
  public interface IAccountHolderService
  {
    [OperationContract]
    IEnumerable<AccountHolderResp> GetActiveAccountHolder();

    [OperationContract]
    AccountHolderResp GetAccountData(GetAccountDataMsg msg);
  }


  [DataContract]
  public class GetAccountDataMsg
  {
    int id;

    [DataMember]
    public int Id
    {
      get { return id; }
      set { id = value; }
    }
  }

  [DataContract]
  public class AccountHolderResp
  {
    int id;
    string name;

    [DataMember]
    public int Id
    {
      get { return id; }
      set { id = value; }
    }

    [DataMember]
    public string Name
    {
      get { return name; }
      set { name = value; }
    }
  }
}
