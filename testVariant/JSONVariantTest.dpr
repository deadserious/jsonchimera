program JSONVariantTest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uTest in 'uTest.pas';

begin
  try
    TestIt;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
