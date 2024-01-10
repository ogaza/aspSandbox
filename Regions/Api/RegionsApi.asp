<%@ language="javascript"%>

<script src="/DB/iDBPointer.js" runat="server" language="javascript"></script>
<script src="/Regions/Domain/Entities/Region.js" runat="server" language="javascript"></script>
<script src="/Regions/Domain/Repos/RegionsRepo.js" runat="server" language="javascript"></script>

<script language="javascript" runat="server">

  // ------------------------------------------------------
  // !!! IMPORTANT !!!
  // do not use this file as it has no authentication yet
  // this api is just a pure proof of concept
  // ------------------------------------------------------

  Response.ContentType="application/json"

  var entities = GetAll();
  var entitiesAsJsonArray = Server.CreateObject("Chilkat_9_5_0.JsonArray")

  var i = 0
  for (var index = 0; index < entities.length; index++) {
    var entity = entities[index];
    //  Add an empty object at the 1st JSON array position.
    var success = entitiesAsJsonArray.AddObjectAt(i);
    //  Get the object we just created.
    //  obj is a Chilkat_9_5_0.JsonObject
    var obj = entitiesAsJsonArray.ObjectAt(i);

    success = obj.UpdateString("id", entity.id);
    success = obj.UpdateString("description", entity.description);

    i++;
  }

  entitiesAsJsonArray.EmitCompact = 0;
  var result = entitiesAsJsonArray.Emit();

  Response.Write(result);
</script>