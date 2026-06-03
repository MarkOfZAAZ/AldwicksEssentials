// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited
//
// Last changed: 03.06.2026 16:27
// -----------------------------------------------------------------------------

unit SpeedLaunchEditor;

interface

uses
  System.SysUtils, System.Classes, System.Skia, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo, FMX.Skia,
  uSpeedCommonTypes;

const
  ICON_PENCIL: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="circlecolor"/>
      <g transform="matrix(0.2164905,0,0,0.2164905,5.5167133,4.7781934)">
        <path
          fill="#87CEFA"
          fill-rule="evenodd"
          d="m 400.018,116 -27.932,28.06 a 4.029,4.029 0 0 1 -1.793,1.04 l -7.235,1.974 -10.13,-10.132 1.974,-7.235 a 4.088,4.088 0 0 1 0.4,-0.965 4,4 0 0 1 0.638,-0.828 l 28.07,-27.926 z"
          transform="translate(-350,-90)"
        />
        <path
          fill="#5FA4E0"
          fill-rule="evenodd"
          d="M 408.819,107.324 404.02,112 388.012,95.986 l 4.663,-4.807 a 4.036,4.036 0 0 1 5.708,0 l 10.436,10.437 a 4.029,4.029 0 0 1 0,5.708 z m -56.282,42.62 a 2.016,2.016 0 0 1 -2.477,-2.479 l 1.582,-5.806 6.7,6.7 z"
          transform="translate(-350,-90)"
        />
      </g>
    </svg>
  ''';

type
  TSpeedLaunchEditor = class(TSpeedButton)
  private
    FAssociatedMemo: TMemo;
    FComments: string;
    FSvg: TSkSvg;
    FCircleColor: TCircleColor;
    procedure SetCircleColor(const Value: TCircleColor);
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Comments: string read FComments write FComments;
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
  RegisterComponents('Aldwicks', [TSpeedLaunchEditor]);
end;

{ TSpeedLaunchEditor }

constructor TSpeedLaunchEditor.Create(AOwner: TComponent);
begin
  inherited;
  Height := 44;
  Width := 44;
  StyleLookup := 'transparentcirclebuttonstyle';
  Hint := 'Edit in text editor...';
  ShowHint := True;
  Text := '';
  FComments := 'This text appears in the Editor';
  FCircleColor := TCircleColor.ccDark;

  FSvg := TSkSvg.Create(Self);
  FSvg.Parent := Self;
  FSvg.Align := TAlignLayout.Client;
  FSvg.HitTest := False; // important so clicks go to the button
  FSvg.Stored := False;  // prevents FMX from duplicating it in .fmx
  FSvg.Svg.Source := ReplaceStr(ICON_PENCIL, 'circlecolor', CC_DARK);
end;

procedure TSpeedLaunchEditor.SetCircleColor(const Value: TCircleColor);
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
  FSvg.Svg.Source := ReplaceStr(ICON_PENCIL, 'circlecolor', CColor);
  if (FCircleColor = TCircleColor.ccGreyscale) or (FCircleColor = TCircleColor.ccGreyLight) then
    FSvg.Svg.GrayScale := true;
  FSvg.Repaint;
end;

end.
