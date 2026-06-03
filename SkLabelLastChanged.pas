// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited - Developed for RAD Studio 13
//
// Last changed: 13.01.2026 15:31
// -----------------------------------------------------------------------------

unit SkLabelLastChanged;

interface

uses
  System.Classes, System.SysUtils, System.Skia, FMX.Skia, System.UITypes, FMX.Types, FMX.Controls;

type
  TSkLabelLastchanged = class(TSkLabel)
  private
    procedure SetLastChangedText(const Value: string);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LastchangedText: string write SetLastChangedText;
  end;

procedure Register;

implementation

constructor TSkLabelLastchanged.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Words.BeginUpdate;
  try
    Words.Clear;
    // Word 0: static label
    with Words.Add do
    begin
      Text := 'Last changed ';
      Font.Size := 14;
      FontColor := TAlphaColors.Paleturquoise;
    end;
    // Word 1: date/time
    with Words.Add do
    begin
      Text := '--';
      Font.Size := 16;
      FontColor := TAlphaColors.White;
    end;
  finally
    Words.EndUpdate;
  end;
end;

procedure TSkLabelLastchanged.Loaded;
begin
  inherited;
  // If designer hasn't defined Words, enforce defaults
  if Words.Count = 0 then
  begin
    Words.BeginUpdate;
    try
      Words.Clear;
      with Words.Add do
      begin
        Text := 'Last changed ';
        Font.Size := 14;
        FontColor := TAlphaColors.Paleturquoise;
      end;
      with Words.Add do
      begin
        Text := '--';
        Font.Size := 16;
        FontColor := TAlphaColors.White;
      end;
    finally
      Words.EndUpdate;
    end;
  end;
end;

procedure TSkLabelLastchanged.SetLastChangedText(const Value: string);
begin
  if Words.Count < 2 then
    Exit;
  Words[1].Text := FormatDateTime('dd/mm/yyyy hh:nn', StrToDateTimeDef(Value, 0));
end;

procedure Register;
begin
  RegisterComponents('ZAAZControls', [TSkLabelLastchanged]);
end;

end.

