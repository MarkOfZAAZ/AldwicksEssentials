// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited
//
// Last changed: 03.06.2026 16:54
// -----------------------------------------------------------------------------

unit SpeedWeirdChars;

interface

uses
  System.SysUtils, System.Classes, System.Skia, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo, FMX.Skia,
  uSpeedCommonTypes;

const
  ICON_WEIRD: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="circlecolor"/>
      <g transform="translate(4.758,4.843) scale(0.45184)">
        <path d="M10,11c0.4-0.6,0.8-1.2,0.9-2H9.1c0.1,0.7,0.5,1.4,0.9,2z" fill="#87CEFA"/>
        <path d="M19,18V2c0-0.6-0.4-1-1-1H2C1.4,1,1,1.4,1,2v16c0,0.6,0.4,1,1,1h16c0.6,0,1-0.4,1-1z M14,13c0.6,0,1,0.4,1,1s-0.4,1-1,1c-1.5,0-2.9-0.5-4-1.3C8.9,14.5,7.5,15,6,15c-0.6,0-1-0.4-1-1 s0.4-1,1-1c0.9,0,1.8-0.3,2.5-0.7C7.8,11.4,7.3,10.2,7.1,9H6C5.4,9,5,8.6,5,8s0.4-1,1-1h3V5 c0-0.6,0.4-1,1-1s1,0.4,1,1v2h3c0.6,0,1,0.4,1,1s-0.4,1-1,1h-1.1c-0.2,1.2-0.7,2.4-1.4,3.3 C12.2,12.7,13.1,13,14,13z" fill="#87CEFA"/>
        <polygon points="22,20.2 20.6,23 23.4,23" fill="#87CEFA"/>
        <path d="M30,13h-9v4.8l0.1-0.2c0.3-0.7,1.4-0.7,1.8,0l4,8c0.2,0.5,0,1.1-0.4,1.3 C26.3,27,26.2,27,26,27c-0.4,0-0.7-0.2-0.9-0.6l-0.8-1.5C24.2,25,24.1,25,24,25h-4 c-0.1,0-0.2,0-0.3-0.1l-0.8,1.5c-0.2,0.5-0.8,0.7-1.3,0.4c-0.5-0.2-0.7-0.8-0.4-1.3l2.5-5 c-0.5,0.3-1,0.5-1.6,0.5h-5v9c0,0.6,0.4,1,1,1h16c0.6,0,1-0.4,1-1V14C31,13.4,30.6,13,30,13z" fill="#87CEFA"/>
      </g>
    </svg>
  ''';

type
  TSpeedWeirdChars = class(TSpeedButton)
  private
    FAssociatedMemo: TMemo;
    FSvg: TSkSvg;
    FCircleColor: TCircleColor;
    procedure SetCircleColor(const Value: TCircleColor);
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AssociatedMemo: TMemo read FAssociatedMemo write FAssociatedMemo;
    property Align;
    property StyleLookup;
    property Hint;
    property ShowHint;
    property CircleColour: TCircleColor read FCircleColor write SetCircleColor default ccDark;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Aldwicks', [TSpeedWeirdChars]);
end;

{ TSpeedLaunchEditor }

constructor TSpeedWeirdChars.Create(AOwner: TComponent);
begin
  inherited;
  Height := 44;
  Width := 44;
  StyleLookup := 'transparentcirclebuttonstyle';
  Hint := 'Remove UTF8 Weird charactersr...';
  ShowHint := True;
  FCircleColor := TCircleColor.ccDark;

  FSvg := TSkSvg.Create(Self);
  FSvg.Parent := Self;
  FSvg.Align := TAlignLayout.Client;
  FSvg.HitTest := False; // important so clicks go to the button
  FSvg.Stored := False;  // prevents FMX from duplicating it in .fmx
  FSvg.Svg.Source := ReplaceStr(ICON_WEIRD, 'circlecolor', CC_DARK);
end;

procedure TSpeedWeirdChars.SetCircleColor(const Value: TCircleColor);
var
  CColor: string;
begin
  FCircleColor := Value;
  FSvg.Svg.GrayScale := false;
  case FCircleColor of
    ccDark: CColor := CC_DARK;
    ccDarker: CColor := CC_DARKER;
    ccDarkest: CColor := CC_DARKEST;
    ccCharcoal: CColor := CC_CHARCOAL;
    ccLight: CColor := CC_LIGHT;
    ccGreyscale: CColor := CC_GREYSCALE;
    ccGreyLight: CColor := CC_GREYSCALE_LIGHT;
  end;
  FSvg.Svg.Source := ReplaceStr(ICON_WEIRD, 'circlecolor', CColor);
  if (FCircleColor = TCircleColor.ccGreyscale) or (FCircleColor = TCircleColor.ccGreyLight) then
    FSvg.Svg.GrayScale := true;
  FSvg.Repaint;
end;

end.
