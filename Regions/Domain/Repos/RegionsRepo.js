function GetAll() {
  var conn = Server.CreateObject("ADODB.Connection");
  conn.Open(DefaultDatabase);
  var sql = "SELECT * FROM Region";

  var cmd = Server.CreateObject("ADODB.Command");
  cmd.CommandText = sql;
  cmd.CommandType = adCmdText;
  cmd.ActiveConnection = conn;

  var list = [];
  var rs = Server.CreateObject("ADODB.Recordset");
  rs = cmd.Execute();

  while (!rs.EOF) {
    list.push(new Region(rs.Fields(0).Value, rs.Fields(1).Value));

    rs.MoveNext();
  }
  rs.Close();
  conn.Close();

  return list;
}
