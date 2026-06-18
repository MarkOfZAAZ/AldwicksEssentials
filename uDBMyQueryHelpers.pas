// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited
//
// Last changed: 18.06.2026 17:48
// -----------------------------------------------------------------------------

(*
  Example uses:

  // by guid...
  Result := MyQuery.IsFieldValueUnique('medkit_equipment', 'equipname', 'valuetocheckhere', 'equipguid', 'GUIDSTRINGHERE');

  // by integer
  Result := MyQuery.IsFieldValueUnique('medkit_equipment', 'equipname', 'valuetocheckhere', 'equipguid', 123456);

  // string guid in a class?...
  function TPocketClass.IsNameUnique(const AName, AExcludeGuid: string): Boolean;
  var
    ExVal: Variant;
  begin
    if AExcludeGuid.Trim.IsEmpty then
      ExVal := Null
    else
      ExVal := AExcludeGuid;
    Result := MyQuery.IsFieldValueUnique('medkit_pockets', 'pocketname', AName.Trim, 'pocketguid', ExVal);
  end;

  // integer guid in a class...
  function TPocketClass.IsNameUnique(const AName: string; AExcludeId: Integer): Boolean;
  begin
    Result := MyQuery.IsFieldValueUnique('medkit_pockets', 'pocketname', AName.Trim, 'pocketid', AExcludeId);
  end;
*)

unit uDBMyQueryHelpers;

interface

uses
  System.SysUtils, System.Classes, System.Variants, MyAccess;

type
  TMyQueryHelper = class helper for TMyQuery
  public
    function IsFieldValueUnique(const ATable, AField, AValue: string; const AExcludeField: string; const AExcludeValue: Variant): Boolean;
  end;

implementation

{ TMyQueryHelper }

function TMyQueryHelper.IsFieldValueUnique(const ATable, AField, AValue, AExcludeField: string; const AExcludeValue: Variant): Boolean;
begin
  Close;
  SQL.Clear;
  if VarIsNull(AExcludeValue) then
  begin
    SQL.Text := 'SELECT NOT EXISTS (SELECT 1 FROM ' + ATable + '  WHERE ' + AField + ' = :val' + ') AS is_unique';
  end
  else
  begin
    SQL.Text := 'SELECT NOT EXISTS (SELECT 1 FROM ' + ATable + '  WHERE ' + AField + ' = :val AND ' + AExcludeField + ' <> :exclude) AS is_unique';
    ParamByName('exclude').Value := AExcludeValue;
  end;
  ParamByName('val').AsString := AValue;
  Open;
  Result := (FieldByName('is_unique').AsInteger = 1);
end;

end.
