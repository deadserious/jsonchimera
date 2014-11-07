unit uTest;

interface

uses chimera.json.variants;

procedure TestIt;

implementation

procedure TestIt;
var
  o : TJSON;
begin
  o := JSON;
  o.FirstName := 'Jason';
  o.LastName := 'Southwell';
  o.Phone[0] := '702-555-1212';
  o.Phone[1] := '702-555-1213';
  writeln(o.AsJSON);
  readln;
end;

end.
