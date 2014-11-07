program jsonTest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  FastMM4,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  chimera.json;

var
  sl : TStringList;
  jso : IJSONObject;
  src : string;
  i : integer;
  dt : TDateTime;
  aryTimes : array[0..9] of integer;
begin
  try
    sl := TStringList.Create;
    try
      sl.LoadFromFile('..'+PathDelim+'..'+PathDelim+'test.json');
      src := sl.Text;
      for i := 0 to 0 do
      begin
        jso := nil;
        dt := Now;
        jso := JSON(src);
        //WriteLn(jso.AsJSON);
        aryTimes[i] := MillisecondsBetween(Now,dt);
        WriteLn(IntToStr(aryTimes[i]));
      end;
      WriteLn('Avg: '+FloatToStr(
        (aryTimes[0] +
        aryTimes[1] +
        aryTimes[2] +
        aryTimes[3] +
        aryTimes[4] +
        aryTimes[5] +
        aryTimes[6] +
        aryTimes[7] +
        aryTimes[8] +
        aryTimes[9]) / 10));
      sl.Text := jso.AsJSON;
      sl.SaveToFile('..\..\test.out.json');
      //ReadLn;
    finally
      sl.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
