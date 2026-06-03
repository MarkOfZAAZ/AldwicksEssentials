// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited
//
// Last changed: 03.06.2026 16:52
// -----------------------------------------------------------------------------

unit SpeedPDF;

interface

uses
  System.SysUtils, System.Classes, System.Skia, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo, FMX.Skia,
  uSpeedCommonTypes;

const
  ICON_PDF_BASE: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="%s"/>
      <g transform="matrix(0.27855707,0,0,0.27497991,4.275287,4.3048593)">
        <path d="M36.985 0H7.963C7.155 0 6.5.655 6.5 1.926V55c0 .345.655 1 1.463 1h40.074c.808 0 1.463-.655 1.463-1V12.978c0-.696-.093-.92-.257-1.085L37.607.257C37.442.093 37.218 0 36.985 0z"
         fill="#e9e9e0"/>
        <path d="M37.5.151V12h11.849z"
          fill="#d9d7ca"/>
        <path d="M19.514 33.324c-.348 0-.682-.113-.967-.326-1.041-.781-1.181-1.65-1.115-2.242.182-1.628 2.195-3.332 5.985-5.068a67.13 67.13 0 0 0 3.788-10.75c-.998-2.172-1.968-4.99-1.261-6.643.248-.579.557-1.023 1.134-1.215a4.91 4.91 0 0 1 1.016-.172c.504 0 .947.649 1.261 1.049.295.376.964 1.173-.373 6.802 1.348 2.784 3.258 5.62 5.088 7.562 1.311-.237 2.439-.358 3.358-.358 1.566 0 2.515.365 2.902 1.117.32.622.189 1.349-.39 2.16-.557.779-1.325 1.191-2.22 1.191-1.216 0-2.632-.768-4.211-2.285-2.837.593-6.15
         1.651-8.828 2.822-.836 1.774-1.637 3.203-2.383 4.251-1.025 1.435-1.909 2.105-2.784 2.105zm2.662-5.126c-2.137 1.201-3.008 2.188-3.071 2.744-.01.092-.037.334.431.692.149-.047 1.019-.444 2.64-3.436zm13.637-4.442c.815.627 1.014.944 1.547.944.234 0 .901-.01 1.21-.441.149-.209.207-.343.23-.415-.123-.065-.286-.197-1.175-.197a14.62 14.62 0 0 0-1.812.109zm-7.47-6.582a71.29 71.29
         0 0 1-2.674 7.564c2.09-.811 4.362-1.519 6.496-2.02-1.35-1.568-2.699-3.526-3.822-5.544zm-.607-8.462c-.098.033-1.33 1.757.096 3.216.949-2.115-.053-3.23-.096-3.216zM48.037 56H7.963c-.808 0-1.463-.655-1.463-1.463V39h43v15.537c0 .808-.655 1.463-1.463 1.463z"
          fill="%s"/>
        <path d="M17.385 53h-1.641V42.924h2.898c.428 0 .852.068 1.271.205s.795.342 1.128.615a3.21 3.21 0 0 1 .807.991c.205.387.308.822.308 1.306 0 .511-.087.973-.26 1.388a2.9 2.9 0 0 1-.725 1.046c-.31.282-.684.501-1.121.656s-.921.232-1.449.232h-1.217V53zm0-8.832v3.992h1.504c.2 0 .398-.034.595-.103a1.5 1.5 0 0 0 .54-.335c.164-.155.296-.371.396-.649s.15-.622.15-1.032a2.79 2.79 0 0 0-.068-.567c-.046-.214-.139-.419-.28-.615s-.34-.36-.595-.492-.593-.198-1.012-.198h-1.23zm14.834 3.514c0
         .829-.089 1.538-.267 2.126s-.403 1.08-.677 1.477-.581.709-.923.937a4.63 4.63 0 0 1-.991.513c-.319.114-.611.187-.875.219l-.588.046h-3.814V42.924h3.035c.848 0 1.593.135 2.235.403s1.176.627 1.6 1.073.74.955.95 1.524.315 1.156.315 1.758zm-4.867 4.115c1.112 0 1.914-.355 2.406-1.066s.738-1.741.738-3.09c0-.419-.05-.834-.15-1.244a2.66 2.66 0 0 0-.581-1.114c-.287-.333-.677-.602-1.169-.807s-1.13-.308-1.914-.308h-.957v7.629h1.627zm8.914-7.629v3.172h4.211v1.121h-4.211V53h-1.668V42.924H40.9v1.244h-4.634z"
         fill="#fff"/>
      </g>
    </svg>
  ''';

const
  PDF_BLUE: string ='#4682b4';
  PDF_GREEN: string = '#748040';
  PDF_RED: string = '#cc3333';

type
  TPDFColor = (pcBlue, pcGreen, pcRed);

type
  TSpeedPDF = class(TSpeedButton)
  private
    FSvg: TSkSvg;
    FColor: TPDFColor;
    FCircleColor: TCircleColor;
    procedure SetColor(const Value: TPDFColor);
    procedure SetCircleColor(const Value: TCircleColor);
    procedure SetSvgSource;
  protected
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property StyleLookup;
    property Hint;
    property ShowHint;
    property PDFColor: TPDFColor read FColor write SetColor default pcBlue;
    property CircleColour: TCircleColor read FCircleColor write SetCircleColor default ccDark;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Aldwicks', [TSpeedPDF]);
end;

{ TSpeedPDF }

constructor TSpeedPDF.Create(AOwner: TComponent);
begin
  inherited;
  Height := 44;
  Width := 44;
  StyleLookup := 'transparentcirclebuttonstyle';
  Hint := 'Show PDF document...';
  ShowHint := True;

  FCircleColor := TCircleColor.ccDark;
  FColor := TPDFColor.pcBlue;

  FSvg := TSkSvg.Create(Self);
  FSvg.Parent := Self;
  FSvg.Align := TAlignLayout.Client;
  FSvg.HitTest := False; // important so clicks go to the button
  FSvg.Stored := False;  // prevents FMX from duplicating it in .fmx
  SetSvgSource;
end;

procedure TSpeedPDF.SetCircleColor(const Value: TCircleColor);
begin
  if FCircleColor = Value then
    exit;
  FCircleColor := Value;
  SetSvgSource;
end;

procedure TSpeedPDF.SetColor(const Value: TPDFColor);
begin
  if FColor = Value then
    Exit;
  FColor := Value;
  SetSvgSource;
end;

procedure TSpeedPDF.SetSvgSource;
var
  CircleColour, PDFColour: string;
begin
  // first, we set the background circle colour...
  case FCircleColor of
    ccDark: CircleColour := CC_DARK;
    ccDarker: CircleColour := CC_DARKER;
    ccDarkest: CircleColour := CC_DARKEST;
    ccCharcoal: CircleColour := CC_CHARCOAL;
    ccLight: CircleColour := CC_LIGHT;
    ccGreyscale: CircleColour := CC_GREYSCALE;
    ccGreyLight: CircleColour := CC_GREYSCALE_LIGHT;
  else
    CircleColour := CC_DARK;
  end;
  case FColor of
    pcBlue:  PDFColour := PDF_BLUE;
    pcGreen: PDFColour:= PDF_GREEN;
    pcRed:   PDFColour := PDF_RED;
  else
    PDFColour := PDF_BLUE;
  end;
  FSvg.Svg.Source := Format(ICON_PDF_BASE, [CircleColour, PDFColour]);
  if (FCircleColor = TCircleColor.ccGreyscale) or (FCircleColor = TCircleColor.ccGreyLight) then
    FSvg.Svg.GrayScale := true
  else
    FSvg.Svg.GrayScale := false;
  FSvg.Repaint;
end;

end.

