// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited
//
// Last changed: 18.06.2026 18:05
// -----------------------------------------------------------------------------

(*
  Example uses:

  // by guid...
  Result := FDQuery.IsFieldValueUnique('medkit_equipment', 'equipname', 'valuetocheckhere', 'equipguid', 'GUIDSTRINGHERE');

  // by integer
  Result := FDQuery.IsFieldValueUnique('medkit_equipment', 'equipname', 'valuetocheckhere', 'equipguid', 123456);

  // string guid in a class?...
  function TPocketClass.IsNameUnique(const AName, AExcludeGuid: string): Boolean;
  var
    ExVal: Variant;
  begin
    if AExcludeGuid.Trim.IsEmpty then
      ExVal := Null
    else
      ExVal := AExcludeGuid;
    Result := FDQuery.IsFieldValueUnique('medkit_pockets', 'pocketname', AName.Trim, 'pocketguid', ExVal);
  end;

  // integer guid in a class...
  function TPocketClass.IsNameUnique(const AName: string; AExcludeId: Integer): Boolean;
  begin
    Result := FDQuery.IsFieldValueUnique('medkit_pockets', 'pocketname', AName.Trim, 'pocketid', AExcludeId);
  end;
*)

unit uDBFDQueryHelpers;

interface

uses
  System.SysUtils, System.Variants, FireDAC.Comp.Client, FireDAC.Stan.Param;   // for FireDac TFDQuery

type
  TFDQueryHelper = class helper for TFDQuery
  public
    function IsFieldValueUnique(const ATable, AField, AValue: string; const AExcludeField: string; const AExcludeValue: Variant): Boolean;
  end;

implementation

function TFDQueryHelper.IsFieldValueUnique(const ATable, AField, AValue: string; const AExcludeField: string; const AExcludeValue: Variant): Boolean;
begin
  Close;
  SQL.Clear;
  if VarIsNull(AExcludeValue) then
  begin
    SQL.Text := 'SELECT NOT EXISTS(SELECT 1 FROM ' + ATable + '  WHERE ' + AField + ' = :val) AS is_unique';
  end
  else
  begin
    SQL.Text := 'SELECT NOT EXISTS(SELECT 1 FROM ' + ATable + '  WHERE ' + AField + ' = :val AND ' + AExcludeField + ' <> :exclude) AS is_unique';
    ParamByName('exclude').Value := AExcludeValue;
  end;
  ParamByName('val').AsString := AValue;
  Open;
  Result := (FieldByName('is_unique').AsInteger = 1);
end;

end.

