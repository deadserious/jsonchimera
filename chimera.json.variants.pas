unit chimera.json.variants;

interface

uses SysUtils, Classes, Variants, chimera.json;

type
  TJSON = Variant;
  TJSONArray = Variant;

  TJSONvarData = packed record
    VType : TVarType;
    VObject : IJSONObject;
    Reserved0 : NativeInt;
    Reserved1: LongInt;
    Reserved2 : WordBool;
  end;

  TJSONVariantType = class(TInvokeableVariantType)
  protected
    procedure DispInvoke(Dest: PVarData; const Source: TVarData;
      CallDesc: PCallDesc; Params: Pointer); override;
  public
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean); override;
    function GetProperty(var Dest: TVarData; const V: TVarData;
      const Name: string): Boolean; override;
    function SetProperty(const V: TVarData; const Name: string;
      const Value: TVarData): Boolean; override;
  end;

type
  TJSONArrayvarData = packed record
    VType : TVarType;
    VArray : IJSONArray;
    Reserved : NativeUInt;
    Reserved1: LongInt;
    Reserved2 : WordBool;
  end;

  TJSONArrayVariantType = class(TInvokeableVariantType)
  protected
    procedure DispInvoke(Dest: PVarData; const Source: TVarData;
      CallDesc: PCallDesc; Params: Pointer); override;
  public
    function IsClear(const V: TVarData): Boolean; override;
    function DoFunction(var Dest: TVarData; const V: TVarData;
      const Name: string; const Arguments: TVarDataArray): Boolean; override;
    function DoProcedure(const V: TVarData; const Name: string;
      const Arguments: TVarDataArray): Boolean; override;
    procedure Clear(var V: TVarData); override;
    procedure Copy(var Dest: TVarData; const Source: TVarData;
      const Indirect: Boolean); override;
    function GetProperty(var Dest: TVarData; const V: TVarData;
      const Name: string): Boolean; override;
    function SetProperty(const V: TVarData; const Name: string;
      const Value: TVarData): Boolean; override;
    function GetPropertyByIndex(var Dest: TVarData; const V: TVarData;
      const Name: string; const Index : integer): Boolean;
    function SetPropertyByIndex(const V: TVarData; const Name: string; const Index : integer;
      const Value: TVarData): Boolean;
  end;

  TPropertyIterativeProc = reference to procedure(Prop : string; Value : Variant);

function JSONVarType : TVarType;
function VarIsJSON(const AValue : Variant) : Boolean;
function VarAsJSON(const AValue : Variant) : TJSON;
function JSON(JSONObject : IJSONObject) : TJSON; overload;
function JSON(JSONString : string) : TJSON; overload;
function JSON : TJSON; overload;
function VariantToJSONObject(const AValue : Variant) : IJSONObject;

function JSONArrayVarType : TVarType;
function VarIsJSONArray(const AValue : Variant) : Boolean;
function VarAsJSONArray(const AValue : Variant) : Variant;
function JSONArray(JSONArray : IJSONArray) : TJSONArray; overload;
function JSONArray : TJSONArray; overload;

implementation

var
  JSONVariant : TJSONVariantType;
  JSONArrayVariant : TJSONArrayVariantType;

function JSON : TJSON;
var
  p : pointer;
begin
  System.VarClear(Result);
  p := @Result;
  TJSONVarData(p^).VType := JSONVariant.VarType;
  TJSONVarData(p^).VObject := chimera.json.JSON;
end;

function JSON(JSONString : string) : TJSON;
var
  p : pointer;
begin
  System.VarClear(Result);
  p := @Result;
  TJSONVarData(p^).VType := JSONVariant.VarType;
  TJSONVarData(p^).VObject := chimera.json.JSON(JSONString);
end;

function JSON(JSONObject : IJSONObject) : TJSON;
var
  p : pointer;
begin
  System.VarClear(Result);
  p := @Result;
  TJSONVarData(p^).VType := JSONVariant.VarType;
  TJSONVarData(p^).VObject := JSONObject;
end;

function JSONVarType : TVarType;
begin
  Result := JSONVariant.VarType;
end;

function VarIsJSON(const AValue : Variant) : Boolean;
begin
  Result := (TVarData(AValue).VType and varTypeMask) = JSONVarType;
end;

function VarAsJSON(const AValue : Variant) : Variant;
begin
  if not VarIsJSON(AValue) then
    VarCast(Result,AValue,JSONVarType)
  else
    Result := AValue;
end;

function JSONArray(JSONArray : IJSONArray) : TJSONArray;
var
  p : pointer;
begin
  System.VarClear(Result);
  p := @Result;
  TJSONArrayvarData(p^).VType := JSONArrayVariant.VarType;
  TJSONArrayvarData(p^).VArray := JSONArray;
end;

function JSONArray : TJSONArray;
var
  p : pointer;
begin
  System.VarClear(Result);
  p := @Result;
  TJSONArrayvarData(p^).VType := JSONArrayVariant.VarType;
  TJSONArrayvarData(p^).VArray := chimera.json.JSONArray;
end;

function JSONArrayVarType : TVarType;
begin
  Result := JSONArrayVariant.VarType;
end;

function VarIsJSONArray(const AValue : Variant) : Boolean;
begin
  Result := (TVarData(AValue).VType and varTypeMask) = JSONArrayVarType;
end;

function VarAsJSONArray(const AValue : Variant) : Variant;
begin
  if not VarIsJSONArray(AValue) then
    VarCast(Result,AValue,JSONArrayVarType)
  else
    Result := AValue;
end;

function VariantToJSONObject(const AValue : Variant) : IJSONObject;
begin
  result := TJSONvarData(AValue).VObject;
end;

{ TJSONVariantType }

procedure TJSONVariantType.Clear(var V: TVarData);
begin
  TJSONVarData(V).VObject := nil;
end;

procedure TJSONVariantType.Copy(var Dest: TVarData; const Source: TVarData;
  const Indirect: Boolean);
var
  s: String;
  o: IJSONObject;
begin
  if not (Indirect and VarDataIsByRef(Source)) then
  begin
    TJSONVarData(Dest).VType := VarType;
    TJSONVarData(Dest).VObject := chimera.json.JSON(TJSONVarData(Source).VObject.AsJSON);
  end else
    VarDataCopyNoInd(Dest,Source);
end;

procedure TJSONVariantType.DispInvoke(Dest: PVarData; const Source: TVarData;
  CallDesc: PCallDesc; Params: Pointer);
type
  PParamRec = ^TParamRec;
  TParamRec = array[0..3] of LongInt;
  TStringDesc = record
    BStr: WideString;
    PStr: PAnsiString;
  end;
const
  CDoMethod    = $01;
  CPropertyGet = $02;
  CPropertySet = $04;
var
  I, LArgCount: Integer;
  LIdent: string;
  LCasedIdent : string;
  LTemp: TVarData;
  VarParams : TVarDataArray;
  Strings: TStringRefList;
  LDest: PVarData;
  v : variant;
begin
  // Grab the identifier
  LArgCount := CallDesc^.ArgCount;
  LCasedIdent := AnsiString(PAnsiChar(@CallDesc^.ArgTypes[LArgCount]));
  LIdent := FixupIdent(LCasedIdent);

  FillChar(Strings, SizeOf(Strings), 0);
  VarParams := GetDispatchInvokeArgs(CallDesc, Params, Strings, true);

  // What type of invoke is this?
  case CallDesc^.CallType of
    CPropertyGet: begin
      if ((Dest <> nil) and                         // there must be a dest
              (LArgCount = 0)) then                       // only no args
      begin
        if TJSONVarData(Source).VObject.Types[LCasedIdent] = TJSONValueType.&array then
        begin
          v := JSONArray(TJSONVarData(Source).VObject.Arrays[LCasedIdent]);
          if VarIsNull(v) then
            RaiseDispError;
          Variant(Dest^) := v;
        end else
        begin
          if not GetProperty(Dest^, Source, LCasedIdent) then
            RaiseDispError;
        end;
      end else
      begin
        if not ((Dest <> nil) and                         // there must be a dest
              (LArgCount = 1)) then
          RaiseDispError;
        if TJSONVarData(Source).VObject.Types[LCasedIdent] = TJSONValueType.&array then
        begin
          v := TJSONVarData(Source).VObject.Arrays[LCasedIdent].Items[VarParams[0].VInteger];
          if VarIsNull(v) then
            RaiseDispError;
        end else if TJSONVarData(Source).VObject.Types[LCasedIdent] = TJSONValueType.&object then
        begin
          if VarIsNumeric(Variant(VarParams[0])) then
            v := TJSONVarData(Source).VObject.Objects[LCasedIdent].Items[TJSONVarData(Source).VObject.Objects[LCasedIdent].Names[Variant(VarParams[0])]]
          else
            v := TJSONVarData(Source).VObject.Objects[LCasedIdent].Items[Variant(VarParams[0])];
          if VarIsNull(v) then
            RaiseDispError;
        end;
        Variant(Dest^) := v;
      end;
    end;
    CPropertySet:
      if ((Dest = nil) and                         // there must be a dest
          (LArgCount = 1)) then
      begin
        TJSONVarData(Source).VObject.Items[LCasedIdent] := Variant(VarParams[0]);
      end else
      begin
        if not ((Dest = nil) and                         // there must be a dest
              (LArgCount = 2)) then
          RaiseDispError;
        if not TJSONVarData(Source).VObject.Has[LCasedIdent] then
          TJSONVarData(Source).VObject.Add(LCasedIdent, chimera.json.JSONArray);
        TJSONVarData(Source).VObject.Arrays[LCasedIdent].Items[VarParams[0].VInteger] := Variant(VarParams[1]);
      end;
  else
    if ((Dest <> nil) and                         // there must be a dest
        (LArgCount = 0) and
        (LIdent <> 'COUNT') and
        (LIdent <> 'ASJSONOBJECT') and
        (LIdent <> 'ASJSON')) then                       // only no args
    begin
      if TJSONVarData(Source).VObject.Types[LCasedIdent] = TJSONValueType.&array then
      begin
        v := JSONArray(TJSONVarData(Source).VObject.Arrays[LCasedIdent]);
        if VarIsNull(v) then
          RaiseDispError;
        Variant(Dest^) := v;
      end else
      begin
        if not GetProperty(Dest^, Source, LCasedIdent) then
          RaiseDispError;
      end;
    end else
    begin
      inherited;
      exit;
    end;
  end;

  {if Dest <> nil then
  begin
    if VarIsJSON(Variant(Source)) and VarIsJSON(Variant(Dest^)) then
    begin
      TJSONvarData(Dest^).VSourceObject := TJSONVarData(Source).VObject;
      TJSONvarData(Dest^).VSourceObject.AddRef;
      TJSONvarData(Dest^).VObject.LastPropertyName := LCasedIdent;
    end;
  end;}
  for I := 0 to Length(Strings) - 1 do
  begin
    if Pointer(Strings[I].Wide) = nil then
      Break;
    if Strings[I].Ansi <> nil then
      Strings[I].Ansi^ := AnsiString(Strings[I].Wide)
    else if Strings[I].Unicode <> nil then
      Strings[I].Unicode^ := UnicodeString(Strings[I].Wide)
  end;
end;

function TJSONVariantType.GetProperty(var Dest: TVarData; const V: TVarData;
  const Name: string): Boolean;
begin
  Result := False;
  if Name = 'ASJSON' then
  begin
    Variant(Dest) := TJSONvarData(V).VObject.AsJSON;
    Result := True;
  end else if Name = 'ASJSONOBJECT' then
  begin
    Variant(Dest) := TJSONvarData(V).VObject;
    Result := True;
  end else
  begin
    Variant(Dest) := TJSONvarData(V).VObject.Items[Name];
    Result := True;
  end;
end;

function TJSONVariantType.SetProperty(const V: TVarData; const Name: string;
  const Value: TVarData): Boolean;
var
  o : IJSONObject;
begin
  Result := False;
  if Name = 'ASJSON' then
  begin
    o := chimera.json.JSON(Variant(Value));
    o.Each(procedure(n : string; v : variant)
    begin
      TJSONvarData(V).VObject.Items[n] := v;
    end);
    Result := True;
  end else if Name = 'ASJSONOBJECT' then
  begin
    o := IInterface(Variant(Value)) as IJSONObject;
    o.Each(procedure(n : string; v : variant)
    begin
      TJSONvarData(V).VObject.Items[n] := v;
    end);
    Result := True;
  end else
  begin
    TJSONvarData(V).VObject.Items[Name] := Variant(Value);
    Result := True;
  end;
end;


{ TJSONArrayVariantType }

procedure TJSONArrayVariantType.Clear(var V: TVarData);
begin
  TjsonArrayVarData(v).VArray := nil;
end;

procedure TJSONArrayVariantType.Copy(var Dest: TVarData; const Source: TVarData;
  const Indirect: Boolean);
var
  s: String;
  ary, o: IJSONArray;
begin
  if not (Indirect and VarDataIsByRef(Source)) then
  begin
    TJSONArrayVarData(Dest).VType := VarType;
    o := TJSONArrayVarData(Source).VArray;
    ary := chimera.json.JSONArray;
    TJSONArrayVarData(Dest).VArray := ary;
    o.Each(procedure(v : variant)
    begin
      ary.Add(v);
    end);
  end else
    VarDataCopyNoInd(Dest,Source);
end;

procedure TJSONArrayVariantType.DispInvoke(Dest: PVarData;
  const Source: TVarData; CallDesc: PCallDesc; Params: Pointer);
type
  PParamRec = ^TParamRec;
  TParamRec = array[0..3] of LongInt;
  TStringDesc = record
    BStr: WideString;
    PStr: PAnsiString;
  end;
const
  CDoMethod    = $01;
  CPropertyGet = $02;
  CPropertySet = $04;
var
  I, LArgCount: Integer;
  LIdent: string;
  LCasedIdent : string;
  LTemp: TVarData;
  VarParams : TVarDataArray;
  Strings: TStringRefList;
begin
  // Grab the identifier
  LArgCount := CallDesc^.ArgCount;
  LCasedIdent := AnsiString(PAnsiChar(@CallDesc^.ArgTypes[LArgCount]));
  LIdent := FixupIdent(LCasedIdent);

  FillChar(Strings, SizeOf(Strings), 0);
  VarParams := GetDispatchInvokeArgs(CallDesc, Params, Strings, true);

  // What type of invoke is this?
  case CallDesc^.CallType of
    CDoMethod:
      if ((Dest <> nil) and
          (LArgCount = 0)) then
      begin
        if VarIsJSON(Variant(Source)) then
        begin
          Variant(Dest^) := TJSONVarData(Source).VObject.Items[LCasedIdent];
        end else if not GetProperty(Dest^, Source, LIdent) then  // get op be valid
        begin
          inherited;
          exit;
        end;
      end else
      begin
        inherited;
        exit;
      end;
    CPropertyGet:
      if not ((Dest <> nil) and                         // there must be a dest
              (LArgCount = 0) and                       // only no args
              GetProperty(Dest^, Source, LIdent)) then  // get op be valid
      else if not ((Dest <> nil) and                         // there must be a dest
              (LArgCount = 1) and                       // only no args
              GetPropertyByIndex(Dest^, Source, LIdent, VarParams[0].VInteger)) then  // get op be valid
        RaiseDispError;

    CPropertySet:
      if not ((Dest = nil) and                          // there can't be a dest
              (LArgCount = 1) and                       // can only be one arg
              SetProperty(Source, LIdent, VarParams[0])) then // set op be valid
      else if not ((Dest = nil) and                          // there can't be a dest
              (LArgCount = 2) and                       // can only be one arg
              SetPropertyByIndex(Source, LIdent, VarParams[0].VInteger, VarParams[1])) then // set op be valid
        RaiseDispError;
  else
    inherited;
    exit;
  end;

  for I := 0 to Length(Strings) - 1 do
  begin
    if Pointer(Strings[I].Wide) = nil then
      Break;
    if Strings[I].Ansi <> nil then
      Strings[I].Ansi^ := AnsiString(Strings[I].Wide)
    else if Strings[I].Unicode <> nil then
      Strings[I].Unicode^ := UnicodeString(Strings[I].Wide)
  end;
end;

function TJSONArrayVariantType.DoFunction(var Dest: TVarData; const V: TVarData;
  const Name: string; const Arguments: TVarDataArray): Boolean;
begin
  Result := False;
  if Name = 'ASJSON' then
  begin
    Variant(Dest) := TJSONArrayvarData(V).VArray.AsJSON;
    Result := True;
  end else if (Name = 'INDEX') or (Name = 'ITEM')  then
  begin
    case TJSONArrayvarData(V).VArray.Types[Variant(Arguments[0])] of
      TJSONValueType.&object:
        Variant(Dest) := JSON(TJSONArrayvarData(V).VArray.Objects[Variant(Arguments[0])]);
      TJSONValueType.&array:
        Variant(Dest) := JSONArray(TJSONArrayvarData(V).VArray.Arrays[Variant(Arguments[0])]);
      else
        Variant(Dest) := TJSONArrayvarData(V).VArray.Items[Variant(Arguments[0])];
    end;
    Result := True;
  end else if Name = 'COUNT'  then
  begin
    Variant(Dest) := TJSONArrayvarData(V).VArray.Count;
    Result := True;
  end;
end;

function TJSONArrayVariantType.DoProcedure(const V: TVarData;
  const Name: string; const Arguments: TVarDataArray): Boolean;
begin
  Result := False;
  if (Name = 'INDEX') or (Name = 'ITEM') then
  begin
    TJSONArrayvarData(V).VArray.Items[Variant(Arguments[0])] := Variant(Arguments[1]);
    Result := True;
  end;
end;

function TJSONArrayVariantType.GetProperty(var Dest: TVarData; const V: TVarData;
  const Name: string): Boolean;
begin
  if Name = 'COUNT'  then
  begin
    Variant(Dest) := TJSONArrayvarData(V).VArray.Count;
    Result := True;
  end;
end;

function TJSONArrayVariantType.GetPropertyByIndex(var Dest: TVarData;
  const V: TVarData; const Name: string; const Index: integer): Boolean;
begin
  Variant(Dest) := TJSONArrayvarData(V).VArray.Items[Index];
  Result := True;
end;

function TJSONArrayVariantType.IsClear(const V: TVarData): Boolean;
begin
  Result := TjsonArrayVarData(v).VArray = nil;
end;

function TJSONArrayVariantType.SetProperty(const V: TVarData; const Name: string;
  const Value: TVarData): Boolean;
begin
  Result := False;
end;

function TJSONArrayVariantType.SetPropertyByIndex(const V: TVarData;
  const Name: string; const Index: integer; const Value: TVarData): Boolean;
begin
  Result := False;
end;

initialization
  JSONVariant := TJSONVariantType.Create;
  JSONArrayVariant := TJSONArrayVariantType.Create;

finalization
  FreeAndNil(JSONVariant);
  FreeAndNil(JSONArrayVariant);


end.
