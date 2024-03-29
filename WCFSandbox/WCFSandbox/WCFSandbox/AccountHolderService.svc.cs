using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace WCFSandbox
{
  public class AccountHolderService : IAccountHolderService
  {
    public IEnumerable<AccountHolderResp> GetActiveAccountHolder()
    {
      IEnumerable<AccountHolderResp> result = null;

      var repo = new Repo();

      try
      {
        result = repo.GetAllAccountHolders();
      }
      catch (Exception e)
      {
        return null;
      }

      return result;
    }

    public AccountHolderResp GetAccountData(GetAccountDataMsg msg)
    {
      AccountHolderResp result = null;

      if (msg == null)
      {
        throw new ArgumentNullException("wrong ahId");
      }

      var repo = new Repo();

      try
      {
        result = repo.GetAccountHolder(msg.Id);
      }
      catch (Exception e)
      {
        result.Name = e.Message;

        return result;
      }

      return result;
    }
  }


  public class Repo 
  {
    public IEnumerable<AccountHolderResp> GetAllAccountHolders()
    {
      const string sql =
          @"SELECT TOP 10 
            ahID, ahName 
          FROM 
            recAccountHolder";

      var result = new List<AccountHolderResp>();

      using (SqlConnection connection = new SqlConnection(connectionString))
      {
        SqlCommand command = new SqlCommand(sql, connection);
        connection.Open();

        SqlDataReader reader = command.ExecuteReader();

        if (reader.HasRows)
        {
          while (reader.Read())
          {
            result.Add(
              new AccountHolderResp
              {
                Id = reader.GetInt32(0),
                Name = reader.GetString(1)
              }
            );
          }
        }

        reader.Close();
      }

      return result;

    }

    public AccountHolderResp GetAccountHolder(int id)
    {
      var sql =
        @"SELECT TOP 1 
            ahID, ahName 
          FROM 
            recAccountHolder
          WHERE
            ahID=" + id;

      var result = new AccountHolderResp();

      using (SqlConnection connection = new SqlConnection(connectionString))
      {
        SqlCommand command = new SqlCommand(sql,connection);
        connection.Open();

        SqlDataReader reader = command.ExecuteReader();

        if (reader.HasRows)
        {
            while (reader.Read())
            {
                result.Id = reader.GetInt32(0);
                result.Name = reader.GetString(1);
            }
        }

        reader.Close();
      }

      return result;

    }

    string connectionString = @"
      Persist Security Info=True;
      User ID=mirecs-webappuser;
      Password=!apx52;
      Initial Catalog=MIRECS-APP-DEV01;
      Data Source=emregqa-usw-db4;";
  }
}
