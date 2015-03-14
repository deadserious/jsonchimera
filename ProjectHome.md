Chimera is an Open Source (MIT License) library for Delphi XE2 which provides a fast and cross platform JSON generator/parser (serializer/deserializer) under a license that doesn't suck.

For more information on json, please visit http://json.org

Here is a very simple example of how to use Chimera to parse, change and generate JSON.

```
uses
  chimera.json;

var
  i : integer;
  obj : IJSONObject;
begin
  obj := JSON('{"firstname":"leonard","lastname":"nimoy",'+
              ' "email":["spock@enterprise.com","lazydude@mars.com"]}');
  Writeln(obj['firstname']);
  for i := 0 to obj.Arrays['email'].count-1 do
  begin
    Writeln(obj.Arrays['email'][i]);
  end;

  obj['lastname'] := 'shatner';
  writeln(obj.AsJSON);
  ReadLn;
end.
```

The core Chimera library is intended to be very lightweight, fast and simple.  No revisions that slow parsing or generation will be accepted unless it is required to fix conformance to json standard.

Please visit the product page at:

http://arcana.sivv.com/chimera

Please visit our pub/sub sister project at:

https://code.google.com/p/pubsubchimera