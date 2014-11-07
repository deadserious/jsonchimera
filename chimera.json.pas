// *****************************************************************************
//
// chimera.json;
//
// JSON Chimera project for Delphi
//
// Copyright (c) 2012 by Sivv LLC, All Rights Reserved
//
// Information about this product can be found at
// http://arcana.sivv.com/chimera
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// *****************************************************************************

unit chimera.json;

interface

uses System.SysUtils, System.Classes;

type
{$SCOPEDENUMS ON}

  TJSONValueType = (&string, number, &array, &object, boolean, null, code);

  IJSONObject = interface;
  IJSONArray = interface;

  PMultiValue = ^TMultiValue;
  TMultiValue = record
    ValueType : TJSONValueType;
    StringValue : string;
    NumberValue : Double;
    IntegerValue : Int64;
    ObjectValue : IJSONObject;
    ArrayValue : IJSONArray;
    constructor Initialize(const Value : String; encode : boolean = false); overload;
    constructor Initialize(const Value : Double; encode : boolean = false); overload;
    constructor Initialize(const Value : Int64; encode : boolean = false); overload;
    constructor Initialize(const Value : Boolean; encode : boolean = false); overload;
    constructor Initialize(const Value : IJSONObject; encode : boolean = false); overload;
    constructor Initialize(const Value : IJSONArray; encode : boolean = false); overload;
    constructor Initialize(const Value : Variant; encode : boolean = false); overload;
    constructor Initialize(const Value : PMultiValue); overload;
    function InitializeNull : TMultiValue;
    constructor InitializeCode(const Value : String);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
    procedure AsJSON(Result : TStringBuilder); overload;
    function ToVariant : Variant;
  end;

  IJSONArray = interface(IInterface)
    ['{2D496737-5D01-4332-B2C2-7328772E3587}']
    function GetRaw(const idx: integer): PMultiValue;
    procedure SetRaw(const idx: integer; const Value: PMultiValue);
    function GetBoolean(const idx: integer): Boolean;
    function GetCount: integer;
    function GetNumber(const idx: integer): Double;
    function GetInteger(const idx: integer): Int64;
    function GetItem(const idx: integer): Variant;
    function GetString(const idx: integer): string;
    function GetObject(const idx: integer): IJSONObject;
    function GetArray(const idx: integer): IJSONArray;
    function GetType(const idx: integer): TJSONValueType;
    procedure SetBoolean(const idx: integer; const Value: Boolean);
    procedure SetCount(const Value: integer);
    procedure SetNumber(const idx: integer; const Value: Double);
    procedure SetInteger(const idx: integer; const Value: Int64);
    procedure SetItem(const idx: integer; const Value: Variant);
    procedure SetString(const idx: integer; const Value: string);
    procedure SetArray(const idx: integer; const Value: IJSONArray);
    procedure SetObject(const idx: integer; const Value: IJSONObject);
    procedure SetType(const idx: integer; const Value: TJSONValueType);
    //procedure ParentOverride(parent : IJSONArray); overload;
    //procedure ParentOverride(parent : IJSONObject); overload;

    procedure Add(const value : PMultiValue); overload;
    procedure Remove(const value : PMultiValue); overload;
    property Raw[const idx : integer] : PMultiValue read GetRaw write SetRaw;

    procedure Add(const value : string); overload;
    procedure Add(const value : double); overload;
    procedure Add(const value : int64); overload;
    procedure Add(const value : boolean); overload;
    procedure Add(const value : IJSONArray); overload;
    procedure Add(const value : IJSONObject); overload;
    procedure Add(const value : Variant); overload;
    procedure AddNull;
    procedure AddCode(const value : string);
    procedure Delete(const idx : integer);
    procedure Clear;

    procedure Remove(const value : string); overload;
    procedure Remove(const value : double); overload;
    procedure Remove(const value : int64); overload;
    procedure Remove(const value : boolean); overload;
    procedure Remove(const value : IJSONArray); overload;
    procedure Remove(const value : IJSONObject); overload;
    procedure Remove(const value : Variant); overload;

    function IndexOf(const value : string) : integer; overload;
    function IndexOf(const value : double) : integer; overload;
    function IndexOf(const value : int64) : integer; overload;
    function IndexOf(const value : boolean) : integer; overload;
    function IndexOf(const value : IJSONArray) : integer; overload;
    function IndexOf(const value : IJSONObject) : integer; overload;

    function Equals(const obj : IJSONArray) : boolean;

    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
    procedure AsJSON(Result : TStringBuilder); overload;

    procedure Each(proc : TProc<string>); overload;
    procedure Each(proc : TProc<double>); overload;
    procedure Each(proc : TProc<int64>); overload;
    procedure Each(proc : TProc<boolean>); overload;
    procedure Each(proc : TProc<IJSONObject>); overload;
    procedure Each(proc : TProc<IJSONArray>); overload;
    procedure Each(proc : TProc<Variant>); overload;

    //function ParentArray : IJSONArray;
    //function ParentObject : IJSONObject;

    property Strings[const idx : integer] : string read GetString write SetString;
    property Numbers[const idx : integer] : Double read GetNumber write SetNumber;
    property Integers[const idx : integer] : Int64 read GetInteger write SetInteger;
    property Booleans[const idx : integer] : Boolean read GetBoolean write SetBoolean;
    property Objects[const idx : integer] : IJSONObject read GetObject write SetObject;
    property Arrays[const idx : integer] : IJSONArray read GetArray write SetArray;
    property Items[const idx : integer] : Variant read GetItem write SetItem; default;
    property Types[const idx : integer] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount write SetCount;
  end;

  IJSONObject = interface(IInterface)
    ['{D99D532B-A21C-4135-9DF5-0FFC8538CED4}']
    function GetRaw(const name: string): PMultiValue;
    procedure SetRaw(const name: string; const Value: PMultiValue);
    function GetHas(const name : string): Boolean;
    function GetBoolean(const name : string): Boolean;
    function GetCount: integer;
    function GetNumber(const name : string): Double;
    function GetInteger(const name : string): Int64;
    function GetItem(const name : string): Variant;
    function GetString(const name : string): string;
    function GetObject(const name : string): IJSONObject;
    function GetArray(const name : string): IJSONArray;
    function GetType(const name : string): TJSONValueType;
    function GetName(const idx : integer): string;
    procedure SetBoolean(const name : string; const Value: Boolean);
    procedure SetNumber(const name : string; const Value: Double);
    procedure SetInteger(const name : string; const Value: Int64);
    procedure SetItem(const name : string; const Value: Variant);
    procedure SetString(const name : string; const Value: string);
    procedure SetArray(const name : string; const Value: IJSONArray);
    procedure SetObject(const name : string; const Value: IJSONObject);
    procedure SetType(const name : string; const Value: TJSONValueType);
    //procedure ParentOverride(parent : IJSONArray); overload;
    //procedure ParentOverride(parent : IJSONObject); overload;

    procedure Each(proc : TProc<string, PMultiValue>); overload;
    procedure Add(const name : string; const value : PMultiValue); overload;
    property Raw[const name : string] : PMultiValue read GetRaw write SetRaw;

    procedure Each(proc : TProc<string, string>); overload;
    procedure Each(proc : TProc<string, double>); overload;
    procedure Each(proc : TProc<string, int64>); overload;
    procedure Each(proc : TProc<string, boolean>); overload;
    procedure Each(proc : TProc<string, IJSONObject>); overload;
    procedure Each(proc : TProc<string, IJSONArray>); overload;
    procedure Each(proc : TProc<string, Variant>); overload;

    procedure Add(const name : string; const value : string); overload;
    procedure Add(const name : string; const value : double); overload;
    procedure Add(const name : string; const value : Int64); overload;
    procedure Add(const name : string; const value : boolean); overload;
    procedure Add(const name : string; const value : IJSONArray); overload;
    procedure Add(const name : string; const value : IJSONObject); overload;
    procedure Add(const name : string; const value : Variant); overload;
    procedure Remove(const name : string);
    procedure AddNull(const name : string);
    procedure AddCode(const name : string; const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
    procedure AsJSON(Result : TStringBuilder); overload;

    function Equals(const obj : IJSONObject) : boolean;
    function LoadFromStream(Stream : TStream) : IJSONObject;
    function LoadFromFile(Filename : string) : IJSONObject;
    procedure SaveToStream(Stream : TStream);
    procedure SaveToFile(Filename : string);
    //function ParentArray : IJSONArray;
    //function ParentObject : IJSONObject;

    property Strings[const name : string] : string read GetString write SetString;
    property Numbers[const name : string] : Double read GetNumber write SetNumber;
    property Integers[const name : string] : Int64 read GetInteger write SetInteger;
    property Booleans[const name : string] : Boolean read GetBoolean write SetBoolean;
    property Objects[const name : string] : IJSONObject read GetObject write SetObject;
    property Arrays[const name : string] : IJSONArray read GetArray write SetArray;
    property Items[const name : string] : Variant read GetItem write SetItem; default;
    property Types[const name : string] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount;
    property Names[const idx : integer] : string read GetName;
    property Has[const name : string] : boolean read GetHas;
  end;

function JSON(const src : string = '') : IJSONObject;
function JSONArray(const src : string = '') : IJSONArray;
function FormatJSON(const src : string; Indent : byte = 3) : string;
function JSONEncode(const str : string) : string;
function JSONDecode(const str : string) : string;
function StringIsJSON(const str : string) : boolean;

implementation

uses System.Variants, System.Generics.Collections, chimera.json.parser,
  System.StrUtils;

type
  TJSONArray = class(TInterfacedObject, IJSONArray)
  private // IJSONArray
    //FParentObject: IJSONObject;
    //FParentArray: IJSONArray;

    function GetRaw(const idx: integer): PMultiValue;
    procedure SetRaw(const idx: integer; const Value: PMultiValue);

    function GetBoolean(const idx: integer): Boolean;
    function GetCount: integer;
    function GetNumber(const idx: integer): Double;
    function GetInteger(const idx: integer): Int64;
    function GetItem(const idx: integer): Variant;
    function GetString(const idx: integer): string;
    function GetObject(const idx: integer): IJSONObject;
    function GetArray(const idx: integer): IJSONArray;
    function GetType(const idx: integer): TJSONValueType;
    procedure SetBoolean(const idx: integer; const Value: Boolean);
    procedure SetCount(const Value: integer);
    procedure SetNumber(const idx: integer; const Value: Double);
    procedure SetInteger(const idx: integer; const Value: Int64);
    procedure SetItem(const idx: integer; const Value: Variant);
    procedure SetString(const idx: integer; const Value: string);
    procedure SetArray(const idx: integer; const Value: IJSONArray);
    procedure SetObject(const idx: integer; const Value: IJSONObject);
    procedure SetType(const idx: integer; const Value: TJSONValueType);
    //function ParentArray : IJSONArray;
    //function ParentObject : IJSONObject;
    //procedure ParentOverride(parent : IJSONArray); overload;
    //procedure ParentOverride(parent : IJSONObject); overload;
  private
    FValues : TList<PMultiValue>;
    procedure EnsureSize(const idx : integer);
  public // IJSONArray

    procedure Add(const value : PMultiValue); overload;
    procedure Remove(const value : PMultiValue); overload;
    property Raw[const idx: integer] : PMultiValue read GetRaw write SetRaw;

    procedure Each(proc : TProc<string>); overload;
    procedure Each(proc : TProc<double>); overload;
    procedure Each(proc : TProc<int64>); overload;
    procedure Each(proc : TProc<boolean>); overload;
    procedure Each(proc : TProc<IJSONObject>); overload;
    procedure Each(proc : TProc<IJSONArray>); overload;
    procedure Each(proc : TProc<Variant>); overload;

    procedure Add(const value : string); overload;
    procedure Add(const value : double); overload;
    procedure Add(const value : boolean); overload;
    procedure Add(const value : Int64); overload;
    procedure Add(const value : IJSONArray); overload;
    procedure Add(const value : IJSONObject); overload;
    procedure Add(const value : Variant); overload;
    procedure AddNull;
    procedure AddCode(const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
    procedure AsJSON(Result : TStringBuilder); overload;
    procedure Delete(const idx: Integer);
    procedure Clear;

    procedure Remove(const value : string); overload;
    procedure Remove(const value : double); overload;
    procedure Remove(const value : int64); overload;
    procedure Remove(const value : boolean); overload;
    procedure Remove(const value : IJSONArray); overload;
    procedure Remove(const value : IJSONObject); overload;
    procedure Remove(const value : Variant); overload;

    function IndexOf(const value : string) : integer; overload;
    function IndexOf(const value : double) : integer; overload;
    function IndexOf(const value : int64) : integer; overload;
    function IndexOf(const value : boolean) : integer; overload;
    function IndexOf(const value : IJSONArray) : integer; overload;
    function IndexOf(const value : IJSONObject) : integer; overload;

    function Equals(const obj : IJSONArray) : boolean;

    property Strings[const idx : integer] : string read GetString write SetString;
    property Numbers[const idx : integer] : Double read GetNumber write SetNumber;
    property Integers[const idx : integer] : Int64 read GetInteger write SetInteger;
    property Booleans[const idx : integer] : Boolean read GetBoolean write SetBoolean;
    property Objects[const idx : integer] : IJSONObject read GetObject write SetObject;
    property Arrays[const idx : integer] : IJSONArray read GetArray write SetArray;
    property Items[const idx : integer] : Variant read GetItem write SetItem; default;
    property Types[const idx : integer] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount write SetCount;
  public
    //constructor Create(Parent : IJSONObject); overload; virtual;
    //constructor Create(Parent : IJSONArray); overload; virtual;
    constructor Create; overload; virtual;
    destructor Destroy; override;
  end;

  TJSONObject = class(TInterfacedObject, IJSONObject)
  private // IJSONObject

    function GetRaw(const name: string): PMultiValue;
    procedure SetRaw(const name: string; const Value: PMultiValue);

    //FParentObject: IJSONObject;
    //FParentArray: IJSONArray;
    function GetBoolean(const name : string): Boolean;
    function GetCount: integer;
    function GetNumber(const name : string): Double;
    function GetInteger(const name : string): Int64;
    function GetItem(const name : string): Variant;
    function GetString(const name : string): string;
    function GetObject(const name : string): IJSONObject;
    function GetArray(const name : string): IJSONArray;
    function GetType(const name : string): TJSONValueType;
    function GetName(const idx : integer): string;
    procedure SetBoolean(const name : string; const Value: Boolean);
    procedure SetNumber(const name : string; const Value: Double);
    procedure SetInteger(const name : string; const Value: Int64);
    procedure SetItem(const name : string; const Value: Variant);
    procedure SetString(const name : string; const Value: string);
    procedure SetArray(const name : string; const Value: IJSONArray);
    procedure SetObject(const name : string; const Value: IJSONObject);
    procedure SetType(const name : string; const Value: TJSONValueType);
    function GetHas(const name: string): boolean;
    //procedure ParentOverride(parent : IJSONArray); overload;
    //procedure ParentOverride(parent : IJSONObject); overload;
  private
    FValues : TDictionary<string, PMultiValue>;
    procedure DisposeOfValue(Sender: TObject; const Item: PMultiValue; Action: TCollectionNotification);
    function GetValueOf(const name: string): PMultiValue;
    property ValueOf[const name : string] : PMultiValue read GetValueOf;
  public  // IJSONObject
    procedure Each(proc : TProc<string, PMultiValue>); overload;
    procedure Add(const name : string; const value : PMultiValue); overload;
    property Raw[const name : string] : PMultiValue read GetRaw write SetRaw;

    procedure Each(proc : TProc<string, string>); overload;
    procedure Each(proc : TProc<string, double>); overload;
    procedure Each(proc : TProc<string, int64>); overload;
    procedure Each(proc : TProc<string, boolean>); overload;
    procedure Each(proc : TProc<string, IJSONObject>); overload;
    procedure Each(proc : TProc<string, IJSONArray>); overload;
    procedure Each(proc : TProc<string, Variant>); overload;

    procedure Add(const name : string; const value : string); overload;
    procedure Add(const name : string; const value : double); overload;
    procedure Add(const name : string; const value : Int64); overload;
    procedure Add(const name : string; const value : boolean); overload;
    procedure Add(const name : string; const value : IJSONArray); overload;
    procedure Add(const name : string; const value : IJSONObject); overload;
    procedure Add(const name : string; const value : Variant); overload;
    procedure AddNull(const name : string);
    procedure AddCode(const name : string; const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
    procedure AsJSON(Result : TStringBuilder); overload;
    procedure Remove(const name: string);
    function LoadFromStream(Stream : TStream) : IJSONObject;
    function LoadFromFile(Filename : string) : IJSONObject;
    procedure SaveToStream(Stream : TStream);
    procedure SaveToFile(Filename : string);

    //function ParentArray : IJSONArray;
    //function ParentObject : IJSONObject;

    function Equals(const obj : IJSONObject) : boolean;

    property Strings[const name : string] : string read GetString write SetString;
    property Numbers[const name : string] : Double read GetNumber write SetNumber;
    property Integers[const name : string] : Int64 read GetInteger write SetInteger;
    property Booleans[const name : string] : Boolean read GetBoolean write SetBoolean;
    property Objects[const name : string] : IJSONObject read GetObject write SetObject;
    property Arrays[const name : string] : IJSONArray read GetArray write SetArray;
    property Items[const name : string] : Variant read GetItem write SetItem; default;
    property Types[const name : string] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount;
    property Names[const idx : integer] : string read GetName;
    property Has[const name : string] : boolean read GetHas;
  public
    //constructor Create(Parent : IJSONObject); overload; virtual;
    //constructor Create(Parent : IJSONArray); overload; virtual;
    constructor Create; overload; virtual;
    destructor Destroy; override;
  end;

function StringIsJSON(const str : string) : boolean;
begin
  result := (str <> '') and (str[1] = '{') and (str[length(str)] = '}')
end;

function FormatJSON(const src : string; Indent : Byte = 3) : string;
  function Spaces(var Size : integer; iLevel : integer; indent : byte) : string;
  var
    i: Integer;
  begin
    Size := (iLevel*Indent);
    setlength(result,Size);
    for i := 1 to Size do
      Result[i] := ' ';
  end;
var
  i, iSize,  iLevel : integer;
  sb : TStringBuilder;
  bInString : boolean;
begin
  iLevel := 0;
  sb := TStringBuilder.Create(src);
  try
    i := 0;
    bInString := False;
    while i < sb.length do
    begin
      case sb.Chars[i] of
        '{', '[':
        begin
          if not bInString then
          begin
            inc(iLevel);
            while (i < sb.Length - 1) and (sb.Chars[i+1] = ' ') do
              sb.Remove(i+1,1);
            if not CharInSet(sb.Chars[i],['}',']'])  then
            begin
              sb.Insert(i+1,#13#10+Spaces(iSize, iLevel,Indent));
              inc(i,iSize+2);
            end;
          end;
        end;
        ',':
        begin
          if not bInString then
          begin
            while (i < sb.Length - 1) and (sb.Chars[i+1] = ' ') do
              sb.Remove(i+1,1);
            sb.Insert(i+1,#13#10+Spaces(iSize, iLevel,Indent));
            inc(i,iSize+2);
          end;
        end;
        '"':
        begin
          if (sb.Chars[i-1] <> '/') then
            bInString := not bInString;
        end;
        '}',']':
        begin
          if not bInString then
          begin
            while (i < sb.Length - 1) and (sb.Chars[i+1] = ' ') do
              sb.Remove(i+1,1);
            if not CharInSet(sb.Chars[i-1],['{','['])  then
            begin
              dec(iLevel);
              sb.Insert(i,#13#10+Spaces(iSize, iLevel,Indent));
              inc(i,iSize+2);
            end;
          end;
        end;
      end;
      inc(i);
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

function JSONEncode(const str : string) : string;
var
  i : integer;
  sb : TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    for i := 0 to str.Length-1 do
    begin
      case str.Chars[i] of
        '"',
        '\',
        '/': begin
          sb.append('\');
          sb.append(str.Chars[i]);
        end;
        #8: begin
          sb.append('\b');
        end;
        #9: begin
          sb.append('\t');
        end;
        #10: begin
          sb.append('\n');
        end;
        #12: begin
          sb.append('\f');
        end;
        #13: begin
          sb.append('\r');
        end;
        else if Ord(str.Chars[i]) > 255 then
        begin
          sb.append('\u'+IntToHex(Ord(str.Chars[i]),4));
        end else
          sb.append(str.Chars[i]);
      end;
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

function JSONDecode(const str : string) : string;
var
  i : integer;
  ichar : integer;
  sb : TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    i := 0;
    while i < str.length-1 do
    begin
      if str.Chars[i] = '\' then
      begin
        case str.Chars[i+1] of
          '"',
          '\',
          '/':
            sb.Append(str.Chars[i+1]);
          'b': begin
            sb.append(#8);
          end;
          't': begin
            sb.append(#9);
          end;
          'n': begin
            sb.append(#10);
          end;
          'f': begin
            sb.append(#12);
          end;
          'r': begin
            sb.append(#13);
          end;
          'u': begin
            if TryStrToInt('$'+str.Substring(i+2,4),iChar) then
            begin
              sb.append(iChar);
              inc(i,4);
            end else
              sb.insert(0, str[i+1]);
          end;
        end;
        inc(i);
      end else
        sb.Append(str.Chars[i]);
      inc(i);
    end;
    if i < str.length then
      sb.Append(str.Chars[i]);
    result := sb.ToString;
  finally
    sb.Free;
  end;
end;

procedure VerifyType(t1, t2 : TJSONValueType);
begin
  if t1 <> t2 then
    raise Exception.Create('Value is not of required type');
end;

function JSON(const src : string) : IJSONObject;
begin
  if src <> '' then
    Result := TParser.Parse(src)
  else
    Result := TJSONObject.Create;
end;

function JSONArray(const src : string) : IJSONArray;
begin
  if src <> '' then
    Result := TParser.ParseArray(src)
  else
    Result := TJSONArray.Create;
end;

{ TJSONArray }

procedure TJSONArray.Add(const value: double);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: Variant);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: boolean);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: IJSONObject);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
  //value.ParentOverride(Self);
end;

procedure TJSONArray.Add(const value: Int64);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: IJSONArray);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
  //value.ParentOverride(self);
end;

procedure TJSONArray.AddNull;
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeNull;
  FValues.Add(pmv);
end;

procedure TJSONArray.AddCode(const value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeCode(value);
  FValues.Add(pmv);
end;

function TJSONArray.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TJSONArray.AsJSON(var Result : string);
var
  i: Integer;
begin
  Result := Result+'[';
  for i := 0 to FValues.Count-1 do
  begin
    if i > 0 then
      Result := Result+',';
    FValues[i].AsJSON(Result);
  end;
  Result := Result+']';
end;

procedure TJSONArray.AsJSON(Result : TStringBuilder);
var
  i: Integer;
begin
  Result.Append('[');
  for i := 0 to FValues.Count-1 do
  begin
    if i > 0 then
      Result.Append(',');
    FValues[i].AsJSON(Result);
  end;
  Result.Append(']');
end;

procedure TJSONArray.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

{constructor TJSONArray.Create(Parent : IJSONObject);
begin
  Create;
  FParentObject := Parent;
  FParentArray := nil;
end;

constructor TJSONArray.Create(Parent : IJSONArray);
begin
  Create;
  FParentObject := nil;
  FParentArray := Parent;
end;}

constructor TJSONArray.Create;
begin
  inherited Create;
  FValues := TList<PMultiValue>.Create;
end;

destructor TJSONArray.Destroy;
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    Dispose(FValues[i]);
  FValues.Free;
  inherited;
end;

procedure TJSONArray.Each(proc: TProc<int64>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].IntegerValue);
end;

procedure TJSONArray.Each(proc: TProc<double>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].NumberValue);
end;

procedure TJSONArray.Each(proc: TProc<string>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(strings[i]);
end;

procedure TJSONArray.Each(proc: TProc<boolean>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].IntegerValue <> 0);
end;

procedure TJSONArray.Each(proc: TProc<Variant>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].ToVariant);
end;

procedure TJSONArray.Each(proc: TProc<IJSONArray>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].ArrayValue);
end;

procedure TJSONArray.Each(proc: TProc<IJSONObject>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].ObjectValue);
end;

procedure TJSONArray.EnsureSize(const idx: integer);
var
  pmv : PMultiValue;
begin
  while FValues.Count <= idx do
  begin
    New(pmv);
    pmv.InitializeNull;
    FValues.Add(pmv);
  end;
end;

function TJSONArray.Equals(const obj: IJSONArray): boolean;
var
  i : integer;
  j: Integer;
begin
  Result := obj.Count = Count;

  for i := 0 to FValues.Count-1 do
  begin
    if not Result then
      exit;
    case FValues[i].ValueType of
      TJSONValueType.string:
        Result := obj.IndexOf(Strings[i]) >= 0;
      TJSONValueType.number:
        Result := obj.IndexOf(Numbers[i]) >= 0;
      TJSONValueType.boolean:
        Result := obj.IndexOf(Booleans[i]) >= 0;
      TJSONValueType.array:
        Result := obj.IndexOf(Arrays[i]) >= 0;
      TJSONValueType.object:
        Result := obj.IndexOf(Objects[i]) >= 0;
      TJSONValueType.null:
        for j := 0 to obj.Count-1 do
        begin
          if obj.Raw[j].ObjectValue = nil then
          begin
            Result := True;
            continue;
          end;
        end;
      TJSONValueType.code:
        for j := 0 to obj.Count-1 do
        begin
          if obj.Raw[j].StringValue = FValues[i].StringValue then
          begin
            Result := True;
            continue;
          end;
        end;
    end;
  end;
end;

function TJSONArray.GetArray(const idx: integer): IJSONArray;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.&array);
  Result := FValues.Items[idx].ArrayValue;
end;

function TJSONArray.GetBoolean(const idx: integer): Boolean;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.boolean);
  Result := FValues.Items[idx].IntegerValue <> 0;
end;

function TJSONArray.GetCount: integer;
begin
  Result := FValues.Count;
end;

function TJSONArray.GetNumber(const idx: integer): Double;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.number);
  Result := FValues.Items[idx].NumberValue;
end;

function TJSONArray.GetInteger(const idx: integer): Int64;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.number);
  Result := FValues.Items[idx].IntegerValue;
end;

function TJSONArray.GetItem(const idx: integer): Variant;
begin
  EnsureSize(idx);
  Result := FValues.Items[idx].ToVariant;
end;

function TJSONArray.GetObject(const idx: integer): IJSONObject;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.&object);
  Result := FValues.Items[idx].ObjectValue;
end;

function TJSONArray.GetRaw(const idx: integer): PMultiValue;
begin
  Result := FValues.Items[idx];
end;

function TJSONArray.GetString(const idx: integer): string;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.string);
  Result := JSONDecode(FValues.Items[idx].StringValue);
end;

function TJSONArray.GetType(const idx: integer): TJSONValueType;
begin
  Result := FValues.Items[idx].ValueType;
end;

function TJSONArray.IndexOf(const value: int64): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FValues.Count-1 do
  begin
    if (Types[i] = TJSONValueType.Number) and (FValues[i].IntegerValue = value) then
    begin
      result := i;
      break;
    end;
  end;
end;

function TJSONArray.IndexOf(const value: boolean): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FValues.Count-1 do
  begin
    if (Types[i] = TJSONValueType.Boolean) and (
        (Value and (FValues[i].IntegerValue = 1)) or
       ((not Value) and (FValues[i].IntegerValue = 0))) then
    begin
      result := i;
      break;
    end;
  end;
end;

function TJSONArray.IndexOf(const value: string): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FValues.Count-1 do
  begin
    if (Types[i] = TJSONValueType.String) and (FValues[i].StringValue = value) then
    begin
      result := i;
      break;
    end;
  end;
end;

function TJSONArray.IndexOf(const value: double): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FValues.Count-1 do
  begin
    if (Types[i] = TJSONValueType.Number) and (FValues[i].NumberValue = value) then
    begin
      result := i;
      break;
    end;
  end;
end;

function TJSONArray.IndexOf(const value: IJSONArray): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FValues.Count-1 do
  begin
    if (Types[i] = TJSONValueType.Array) and (Arrays[i].Equals(value)) then
    begin
      result := i;
      break;
    end;
  end;
end;

function TJSONArray.IndexOf(const value: IJSONObject): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FValues.Count-1 do
  begin
    if (Types[i] = TJSONValueType.Object) and (Objects[i].Equals(value)) then
    begin
      result := i;
      break;
    end;
  end;
end;

{function TJSONArray.ParentArray: IJSONArray;
begin
  Result := FParentArray;
end;

function TJSONArray.ParentObject: IJSONObject;
begin
  Result := FParentObject;
end;

procedure TJSONArray.ParentOverride(parent: IJSONArray);
begin
  FParentObject := nil;
  FParentArray := parent;
end;

procedure TJSONArray.ParentOverride(parent: IJSONObject);
begin
  FParentObject := parent;
  FParentArray := nil;
end;}

procedure TJSONArray.Remove(const value: int64);
var
  i : integer;
begin
  for i := FValues.Count-1 downto 0 do
  begin
    if (FValues[i].ValueType = TJSONValueType.number) and (FValues[i].IntegerValue = value) then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: boolean);
var
  i : integer;
  iBool : Int64;
begin
  if value then
    iBool := 0
  else
    iBool := 1;

  for i := FValues.Count-1 downto 0 do
  begin
    if (FValues[i].ValueType = TJSONValueType.boolean) and (FValues[i].IntegerValue = iBool) then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: string);
var
  i : integer;
  sEncoded : string;
begin
  sEncoded := JSONEncode(value);
  for i := FValues.Count-1 downto 0 do
  begin
    if (FValues[i].ValueType = TJSONValueType.string) and (FValues[i].StringValue = sEncoded) then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: double);
var
  i : integer;
begin
  for i := FValues.Count-1 downto 0 do
  begin
    if (FValues[i].ValueType = TJSONValueType.number) and (FValues[i].NumberValue = value) then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: Variant);
var
  i, j : integer;
  bRemove : boolean;
  jso : IJSONObject;
  jsa : IJSONArray;
begin
  for i := FValues.Count-1 downto 0 do
  begin
    bRemove := False;
    if VarIsType(Value,varUnknown) then
    begin
      if Supports(Value, IJSONObject, jso) then
      begin
        bRemove := FValues[i].ObjectValue.AsJSON = jso.AsJSON;
      end else if Supports(Value, IJSONArray, jsa) then
      begin
        bRemove := FValues[i].ArrayValue.AsJSON = jsa.AsJSON;
      end else
        raise Exception.Create('Unknown variant type.');
    end else
      case VarType(Value) of
        varSmallInt,
        varInteger,
        varSingle,
        varDouble,
        varCurrency,
        varShortInt,
        varByte,
        varWord,
        varLongWord,
        varInt64,
        varUInt64:
        begin
          bRemove := FValues[i].IntegerValue = VarAsType(Value,varDouble);
        end;

        varDate:
        begin
          bRemove := FValues[i].StringValue = DateToStr(Value,TFormatSettings.Create('en-us'))
        end;

        varBoolean:
        begin
          if VarAsType(Value,varBoolean) then
            bRemove := FValues[i].IntegerValue = 1
          else
            bRemove := FValues[i].IntegerValue = 0;
        end;

        varOleStr,
        varString,
        varUString:
        begin
          bRemove := FValues[i].StringValue = JSONEncode(VarAsType(Value,varString));
        end;

        varArray:
        begin
          jsa := TJSONArray.Create;
          for j := VarArrayLowBound(Value,1) to VarArrayHighBound(Value,1) do
            jsa[j] := Value[j];
          bRemove := FValues[i].ArrayValue.AsJSON = jsa.AsJSON;
        end;

        else
          raise Exception.Create('Unknown variant type.');
      end;
      if bRemove then
        FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: PMultiValue);
var
  i : integer;
  bRemove : boolean;
begin
  for i := FValues.Count-1 downto 0 do
  begin
    bRemove := false;
    if (FValues[i].ValueType = value.ValueType) then
    begin
      case FValues[i].ValueType of
        TJSONValueType.string   : bRemove := FValues[i].StringValue = value.StringValue;
        TJSONValueType.number   : bRemove := (FValues[i].NumberValue = value.NumberValue) and (FValues[i].IntegerValue = value.IntegerValue);
        TJSONValueType.&array   : bRemove := FValues[i].ArrayValue.AsJSON = value.ArrayValue.AsJSON;
        TJSONValueType.&object  : bRemove := FValues[i].ObjectValue.AsJSON = value.ObjectValue.AsJSON;
        TJSONValueType.boolean  : bRemove := FValues[i].IntegerValue = value.IntegerValue;
        TJSONValueType.null     : bRemove := true;
        TJSONValueType.code     : bRemove := FValues[i].StringValue = value.StringValue;
      end;
    end;
    if bRemove then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: IJSONArray);
var
  i : integer;
begin
  for i := FValues.Count-1 downto 0 do
  begin
    if FValues[i].ArrayValue.AsJSON = value.AsJSON then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Remove(const value: IJSONObject);
var
  i : integer;
begin
  for i := FValues.Count-1 downto 0 do
  begin
    if FValues[i].ObjectValue.AsJSON = value.AsJSON then
      FValues.Delete(i);
  end;
end;

procedure TJSONArray.Delete(const idx: Integer);
begin
  FValues.Delete(idx);
end;

procedure TJSONArray.SetArray(const idx: integer; const Value: IJSONArray);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
  //Value.ParentOverride(Self);
end;

procedure TJSONArray.SetBoolean(const idx: integer; const Value: Boolean);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetCount(const Value: integer);
begin
  EnsureSize(Value);
  while FValues.Count > Value do
    FValues.Delete(FValues.Count-1);
end;

procedure TJSONArray.SetNumber(const idx: integer; const Value: Double);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetInteger(const idx: integer; const Value: Int64);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetItem(const idx: integer; const Value: Variant);
begin
  EnsureSize(idx);
  FValues.Items[idx].Initialize(Value);
end;

procedure TJSONArray.SetObject(const idx: integer; const Value: IJSONObject);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
  //value.ParentOverride(Self);
end;

procedure TJSONArray.SetRaw(const idx: integer; const Value: PMultiValue);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetString(const idx: integer; const Value: string);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(JSONEncode(value));
  FValues.Add(pmv);
end;

procedure TJSONArray.SetType(const idx: integer; const Value: TJSONValueType);
begin
  EnsureSize(idx);
  if Value <> FValues.Items[idx].ValueType then
    case Value of
      TJSONValueType.string:
        FValues.Items[idx].Initialize('');
      TJSONValueType.number:
        FValues.Items[idx].Initialize(0);
      TJSONValueType.array:
        FValues.Items[idx].Initialize(TJSONArray.Create{(Self)});
      TJSONValueType.object:
        FValues.Items[idx].Initialize(TJSONObject.Create{(Self)});
      TJSONValueType.boolean:
        FValues.Items[idx].Initialize(False);
      TJSONValueType.null:
        FValues.Items[idx].InitializeNull;
    end;
end;

procedure TJSONArray.Add(const value: PMultiValue);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

{ TJSONObject }

procedure TJSONObject.Add(const name: string; const value: double);
begin
  Numbers[name] := value;
end;

procedure TJSONObject.Add(const name, value: string);
begin
  Strings[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: boolean);
begin
  Booleans[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: IJSONObject);
begin
  Objects[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: Int64);
begin
  Integers[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: IJSONArray);
begin
  Arrays[name] := value;
end;

procedure TJSONObject.AddNull(const name: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeNull;
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.AddCode(const name, value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeCode(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

function TJSONObject.AsJSON: string;
var
  sb : TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    AsJSON(sb);
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

procedure TJSONObject.AsJSON(var Result : string);
var
  item : TPair<string, PMultiValue>;
  bFirst : boolean;
begin
  Result := Result+'{';
  bFirst := True;
  for item in FValues do
  begin
    if not bFirst then
      Result := Result +', "'+item.Key+'" : '
    else
      Result := Result+'"'+item.Key+'" : ';
    item.Value.AsJSON(Result);
    bFirst := False;
  end;
  Result := Result+'}';
end;

procedure TJSONObject.AsJSON(Result: TStringBuilder);
var
  item : TPair<string, PMultiValue>;
  bFirst : boolean;
begin
  Result.Append('{');
  bFirst := True;
  for item in FValues do
  begin
    if not bFirst then
      Result.Append(', "'+item.Key+'" : ')
    else
      Result.Append('"'+item.Key+'" : ');
    item.Value.AsJSON(Result);
    bFirst := False;
  end;
  Result.Append('}');
end;


{constructor TJSONObject.Create(Parent : IJSONObject);
begin
  Create;
  FParentObject := Parent;
  FParentArray := nil;
end;

constructor TJSONObject.Create(Parent : IJSONArray);
begin
  Create;
  FParentObject := nil;
  FParentArray := Parent;
end;}

constructor TJSONObject.Create;
begin
  inherited Create;
  FValues := TDictionary<string, PMultiValue>.Create;
  FValues.OnValueNotify := DisposeOfValue;
end;

destructor TJSONObject.Destroy;
var
  item : TPair<string,PMultiValue>;
begin
  {for item in FValues do
  begin
    Dispose(item.value);
  end;}

  FValues.Free;
  inherited;
end;

procedure TJSONObject.DisposeOfValue(Sender: TObject; const Item: PMultiValue;
  Action: TCollectionNotification);
begin
  if Action = TCollectionNotification.cnRemoved then
    Dispose(Item);
end;

procedure TJSONObject.Each(proc: TProc<string, int64>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.IntegerValue);
end;

procedure TJSONObject.Each(proc: TProc<string, boolean>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.IntegerValue <> 0);
end;

procedure TJSONObject.Each(proc: TProc<string, string>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, JSONDecode(item.Value.StringValue));
end;

procedure TJSONObject.Each(proc: TProc<string, double>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.NumberValue);
end;

procedure TJSONObject.Each(proc: TProc<string, Variant>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.ToVariant);
end;

procedure TJSONObject.Each(proc: TProc<string, PMultiValue>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value);
end;

function TJSONObject.Equals(const obj: IJSONObject): boolean;
var
  item : TPair<string, PMultiValue>;
begin
  Result := True;
  for item in FValues do
  begin
    if (not obj.Has[item.Key]) or (obj.Types[item.key] <> item.Value.ValueType) then
    begin
      Result := False;
      exit;
    end;
    case item.Value.ValueType of
      TJSONValueType.string,
      TJSONValueType.number,
      TJSONValueType.boolean:
        Result := item.Value.ToVariant = obj[item.Key];
      TJSONValueType.array:
        Result := item.Value.ArrayValue.Equals(obj.Arrays[item.Key]);
      TJSONValueType.object:
        Result := item.Value.ObjectValue.Equals(obj.Objects[item.Key]);
      TJSONValueType.null:
        Result := True; // only one value option for this type so if equal above will match here.
      TJSONValueType.code:
        Result := item.Value.StringValue = obj.Raw[item.Key].StringValue;
    end;
    if not Result then
      exit;
  end;
end;

procedure TJSONObject.Each(proc: TProc<string, IJSONObject>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.ObjectValue);
end;

procedure TJSONObject.Each(proc: TProc<string, IJSONArray>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.ArrayValue);
end;

function TJSONObject.GetArray(const name: string): IJSONArray;
begin
  VerifyType(ValueOf[Name].ValueType, TJSONValueType.&array);
  Result := ValueOf[Name].ArrayValue;
end;

function TJSONObject.GetBoolean(const name: string): Boolean;
begin
  VerifyType(ValueOf[Name].ValueType, TJSONValueType.boolean);
  Result := ValueOf[Name].IntegerValue <> 0;
end;

function TJSONObject.GetCount: integer;
begin
  Result := FValues.Count;
end;

function TJSONObject.GetHas(const name: string): boolean;
begin
  Result := FValues.ContainsKey(name);
end;

function TJSONObject.GetNumber(const name: string): Double;
begin
  VerifyType(ValueOf[Name].ValueType, TJSONValueType.number);
  Result := ValueOf[Name].NumberValue;
end;

function TJSONObject.GetInteger(const name: string): Int64;
begin
  VerifyType(ValueOf[Name].ValueType, TJSONValueType.number);
  Result := ValueOf[Name].IntegerValue;
end;

function TJSONObject.GetItem(const name: string): Variant;
begin
  Result := ValueOf[Name].ToVariant;
end;

function TJSONObject.GetName(const idx: integer): string;
begin
  Result := FValues.Keys.ToArray[idx];
end;

function TJSONObject.GetObject(const name: string): IJSONObject;
begin
  if ValueOf[Name].ValueType <> TJSONValueType.null then
    VerifyType(ValueOf[Name].ValueType, TJSONValueType.&object);
  Result := ValueOf[Name].ObjectValue;
end;

function TJSONObject.GetRaw(const name: string): PMultiValue;
begin
  Result := FValues.Items[name];
end;

function TJSONObject.GetString(const name: string): string;
begin
  VerifyType(ValueOf[Name].ValueType, TJSONValueType.string);
  Result := JSONDecode(ValueOf[Name].StringValue);
end;

function TJSONObject.GetType(const name: string): TJSONValueType;
begin
  Result := ValueOf[Name].ValueType;
end;


function TJSONObject.GetValueOf(const name: string): PMultiValue;
begin
  if FValues.ContainsKey(name) then
    result := FValues[name]
  else
    raise Exception.Create('Object is missing the "'+name+'" property.');

end;

function TJSONObject.LoadFromFile(Filename: string): IJSONObject;
var
  fs : TFileStream;
begin
  fs := TFileStream.Create(Filename, fmOpenRead);
  try
    Result := LoadFromStream(fs);
  finally
    fs.Free;
  end;
end;

function TJSONObject.LoadFromStream(Stream: TStream): IJSONObject;
var
  ss : TStringStream;
begin
  ss := TStringStream.Create;
  try
    ss.CopyFrom(Stream, Stream.Size-Stream.Position);
    Result := JSON(ss.DataString);
  finally
    ss.Free;
  end;
end;

{function TJSONObject.ParentArray: IJSONArray;
begin
  Result := FParentArray;
end;

function TJSONObject.ParentObject: IJSONObject;
begin
  Result := FParentObject;
end;

procedure TJSONObject.ParentOverride(parent: IJSONArray);
begin
  FParentObject := nil;
  FParentArray := parent;
end;

procedure TJSONObject.ParentOverride(parent: IJSONObject);
begin
  FParentObject := parent;
  FParentArray := nil;
end;}

procedure TJSONObject.Remove(const name: string);
begin
  FValues.Remove(name);
end;

{class function TJSONObject.NewValue: PMultiValue;
begin
  //TMonitor.Enter(FCache);
  //try
    if FCache.Count = 0 then
    begin
      New(Result);
    end else
      Result := FCache.Pop;
  //finally
    //TMonitor.Exit(FCache);
  //end;
end;}

procedure TJSONObject.SaveToFile(Filename: string);
var
  fs : TFileStream;
begin
  fs := TFileStream.Create(Filename, fmOpenReadWrite or fmCreate);
  try
    SaveToStream(fs);
  finally
    fs.Free;
  end;
end;

procedure TJSONObject.SaveToStream(Stream: TStream);
var
  LBytes: TBytes;
  sb : TStringBuilder;
begin
  sb := TStringBuilder.Create;
  try
    AsJSON(sb);
    Stream.Write(Pointer(sb.ToString)^,sb.Length*SizeOf(Char));
  finally
    sb.Free;
  end;
end;

procedure TJSONObject.SetArray(const name: string; const Value: IJSONArray);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
  //value.ParentOverride(Self);
end;

procedure TJSONObject.SetBoolean(const name: string; const Value: Boolean);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetNumber(const name: string; const Value: Double);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetInteger(const name: string; const Value: Int64);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetItem(const name: string; const Value: Variant);
var
  pmv : PMultiValue;
begin
  if not FValues.ContainsKey(name) then
  begin
    New(pmv);
    pmv.Initialize(Value,true);
    FValues.AddOrSetValue(Name, pmv);
  end else
    ValueOf[Name].Initialize(Value, true);
end;

procedure TJSONObject.SetObject(const name: string; const Value: IJSONObject);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
  //value.ParentOverride(Self);
end;

procedure TJSONObject.SetRaw(const name: string; const Value: PMultiValue);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetString(const name, Value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(JSONEncode(Value));
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetType(const name: string; const Value: TJSONValueType);
var
  mv : PMultiValue;
begin
  mv := ValueOf[Name];

  if mv.ValueType <> Value then
  begin
    case Value of
      TJSONValueType.string:
        SetString(Name, '');
      TJSONValueType.number:
        SetNumber(Name, 0);
      TJSONValueType.array:
        SetArray(Name, TJSONArray.Create);
      TJSONValueType.object:
        SetObject(Name, TJSONObject.Create);
      TJSONValueType.boolean:
        SetBoolean(Name, False);
      TJSONValueType.null:
        AddNull(Name);
    end;
  end;
end;

procedure TJSONObject.Add(const name: string; const value: PMultiValue);
begin
  Raw[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: Variant);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

{ TMultiValue }

constructor TMultiValue.Initialize(const Value: Double; encode : boolean = false);
begin
  Self.ValueType := TJSONValueType.number;
  Self.NumberValue := Value;
  Self.IntegerValue := Round(Value);
end;

constructor TMultiValue.Initialize(const Value: String; encode : boolean = false);
begin
  Self.ValueType := TJSONValueType.string;
  if encode then
    Self.StringValue := JSONEncode(Value)
  else
    Self.StringValue := Value;
end;

function TMultiValue.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TMultiValue.AsJSON(var result : string);
var
  s : string;
begin
  case Self.ValueType of
    TJSONValueType.code:
      Result := Result+Self.StringValue;
    TJSONValueType.string:
    begin
      Result := Result+'"'+Self.StringValue+'"';
    end;
    TJSONValueType.number:
      if (Self.NumberValue = Round(Self.NumberValue)) and
         (Self.NumberValue <> Self.IntegerValue) then
        Result := Result+IntToStr(Self.IntegerValue)
      else
        Result := Result+FloatToStr(Self.NumberValue);
    TJSONValueType.array:
    begin
      Self.ArrayValue.AsJSON(Result);
    end;
    TJSONValueType.object:
      Self.ObjectValue.AsJSON(Result);
    TJSONValueType.boolean:
      if Self.IntegerValue = 1 then
        Result := Result+'true'
      else
        Result := Result+'false';
    TJSONValueType.null:
      Result := Result+'null';
  end;
end;

constructor TMultiValue.Initialize(const Value: IJSONArray; encode : boolean = false);
begin
  Self.ValueType := TJSONValueType.&array;
  Self.ArrayValue := Value;
end;

constructor TMultiValue.Initialize(const Value: Int64; encode : boolean = false);
begin
  Self.ValueType := TJSONValueType.number;
  Self.NumberValue := Value;
  Self.IntegerValue := Value;
end;

constructor TMultiValue.Initialize(const Value: IJSONObject; encode : boolean = false);
begin
  Self.ValueType := TJSONValueType.&object;
  Self.ObjectValue := Value;
end;

function TMultiValue.InitializeNull : TMultiValue;
begin
  Self.ValueType := TJSONValueType.&null;
  Self.ObjectValue := nil;
  Result := Self;
end;

constructor TMultiValue.InitializeCode(const Value: String);
begin
  Self.ValueType := TJSONValueType.code;
  Self.StringValue := Value;
end;

function TMultiValue.ToVariant: Variant;
var
  jsNull : IJSONObject;
begin
  case ValueType of
    TJSONValueType.string:
      result := JSONDecode(StringValue);
    TJSONValueType.number:
      result := NumberValue;
    TJSONValueType.&array:
      result := ArrayValue;
    TJSONValueType.&object:
      result := ObjectValue;
    TJSONValueType.boolean:
      result := IntegerValue <> 0;
    TJSONValueType.null:
    begin
      jsNull := nil;
      result := jsNull;
    end;
  end;
end;

constructor TMultiValue.Initialize(const Value: Boolean; encode : boolean = false);
begin
  Self.ValueType := TJSONValueType.boolean;
  if Value then
    Self.IntegerValue := 1
  else
    Self.IntegerValue := 0;
end;

constructor TMultiValue.Initialize(const Value: Variant; encode : boolean = false);
var
  jso : IJSONObject;
  jsa : IJSONArray;
  d : Double;
  s : string;
  b : Boolean;
  i : integer;
begin
  if VarIsType(Value,varUnknown) then
  begin
    if Supports(Value, IJSONObject, jso) then
    begin
      Initialize(jso)
    end else if Supports(Value, IJSONArray, jsa) then
    begin
      Initialize(jsa);
    end else
      raise Exception.Create('Unknown variant type.');
  end else
    case VarType(Value) of
      varSmallInt,
      varInteger,
      varSingle,
      varDouble,
      varCurrency,
      varShortInt,
      varByte,
      varWord,
      varLongWord,
      varInt64,
      varUInt64:
      begin
        d := VarAsType(Value,varDouble);
        Initialize(d);
      end;

      varDate:
      begin
        Initialize(DateToStr(Value,TFormatSettings.Create('en-us')));
      end;

      varBoolean:
      begin
        b := VarAsType(Value,varBoolean);
        Initialize(b);
      end;

      varOleStr,
      varString,
      varUString:
      begin
        s := VarAsType(Value,varString);
        if encode then
          s := JSONencode(s);
        Initialize(s);
      end;

      varArray:
      begin
        jsa := TJSONArray.Create;
        for i := VarArrayLowBound(Value,1) to VarArrayHighBound(Value,1) do
          jsa[i] := Value[i];

        Initialize(jsa);
      end;

      else
        raise Exception.Create('Unknown variant type.');
    end;
end;

procedure TMultiValue.AsJSON(Result: TStringBuilder);
begin
  case Self.ValueType of
    TJSONValueType.code:
      Result.Append(Self.StringValue);
    TJSONValueType.string:
    begin
      Result.Append('"'+Self.StringValue+'"');
    end;
    TJSONValueType.number:
      if (Self.NumberValue = Round(Self.NumberValue)) and
         (Self.NumberValue <> Self.IntegerValue) then
        Result.Append(IntToStr(Self.IntegerValue))
      else
        Result.Append(FloatToStr(Self.NumberValue));
    TJSONValueType.array:
    begin
      Self.ArrayValue.AsJSON(Result);
    end;
    TJSONValueType.object:
      Self.ObjectValue.AsJSON(Result);
    TJSONValueType.boolean:
      if Self.IntegerValue = 1 then
        Result.Append('true')
      else
        Result.Append('false');
    TJSONValueType.null:
      Result.Append('null');
  end;
end;

constructor TMultiValue.Initialize(const Value: PMultiValue);
begin
  Self.ValueType := Value.ValueType;
  Self.StringValue := Value.StringValue;
  Self.NumberValue := Value.NumberValue;
  Self.IntegerValue := Value.IntegerValue;
  if Self.ValueTYpe = TJSONValueType.Object then
    Self.ObjectValue := Value.ObjectValue;
  if Self.ValueTYpe = TJSONValueType.Array then
    Self.ArrayValue := Value.ArrayValue;
end;

end.
