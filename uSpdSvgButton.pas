// -----------------------------------------------------------------------------
// Copyright � 1994 - 2025 Aldwicks Limited
//
// Last changed: 29.03.2025 13:57
// -----------------------------------------------------------------------------

unit uSpdSvgButton;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.StdCtrls, FMX.Skia, FMX.Graphics;

  const SVG: string =
  '''
    <?xml version="1.0" encoding="utf-8"?>
    <svg width="128px" height="128px" viewBox="0 0 1024 1024" class="icon" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <path d="M835.884621 440.335194C822.640664 265.233398 675.784792 128.081911 501.543059 128.081911c-91.602924 0-178.771402 35.109028-239.224663 96.296415-1.052554 0.892828-3.670629 2.519782-5.90577 2.519781-0.349145 0-0.699314-0.029693-1.01979-0.062457v-0.863135l-6.670613-3.317388-62.527653-62.527653V456.901659h296.774185l-62.050522-61.984994-2.072344-0.863135c-0.032764-0.127986-0.287712-1.277809-0.287712-4.948438 0-4.373014 0.860064-5.200314 3.572336-7.723167 40.312413-38.939383 99.617899-61.282608 162.720976-61.282608 97.636681 0 175.421249 49.633865 198.114643 126.428336l3.509879 11.903691 50.686419-0.830371-1.277809-17.265779z" fill="#F4CE73" />
    <path d="M541.411106 567.338954l62.141648 61.981922 2.075416 0.863135c0.032764 0.127986 0.287712 1.277809 0.287711 4.948438 0 4.435471-0.863135 5.233078-3.575407 7.723167-40.312413 38.939383-99.585134 61.282608-162.652375 61.282609-97.636681 0-175.421249-49.630793-198.117715-126.428337l-3.509879-11.90369-50.686419 0.830371 1.277809 17.266802c13.247028 175.101797 160.099829 312.253284 334.341562 312.253283 91.602924 0 178.804166-35.141792 238.935927-96.103924 0.797607-0.702385 3.575408-2.712272 6.127954-2.712272 2.970291 0 4.69349 1.274737 5.840241 2.39282l64.380886 64.476107V567.338954H541.411106z" fill="#79CCBF" />
    <path d="M469.787256 473.244917H169.852337V173.309997H235.220247v234.565985h234.567009v65.368935zM854.366775 850.640856H788.998864V616.076919H554.431856v-65.36791h299.934919v299.931847z" fill="#FFFFFF" />
    <path d="M501.543059 95.397443c-91.602924 0-179.059113 32.556482-244.300062 89.498841l-61.919465-61.858032c-6.958325-7.020782-17.492057-9.128962-26.683476-5.36004-9.128962 3.827283-15.12893 12.765802-15.128929 22.659606v324.73547c0 13.531668 10.978098 24.512839 24.512838 24.512838h324.732398c9.959333 0 18.897851-5.938535 22.662678-15.128929a24.474955 24.474955 0 0 0-5.297583-26.749004l-57.003791-56.942359c33.000848-23.937415 75.709153-37.98205 121.734846-37.98205 91.668453 0 162.907322 48.260835 173.186107 117.460125 1.850161 12.128946 12.318364 21.064393 24.575295 20.937431l64.282593-0.8959c13.406754-0.189419 24.130929-11.106084
     24.130929-24.512839-0.001024-204.274337-165.718911-370.375158-369.484378-370.375158z m297.094662 346.503272c-24.130929-81.647687-106.732878-138.142608-213.786232-138.142608-67.2836 0-130.735822 24.002944-174.082007 65.877806-2.552546 2.490089-8.553538 6.895868-8.553538 19.470203 0 12.576383 2.360056 12.576383 7.147743 17.365095 0 0 17.299566 17.234038 34.151695 34.089238H202.53578V199.577775a352099.429504 352099.429504 0 0 0 36.514822 36.514823h0.062457c0.065529 0.065529 0.065529 0.126962 0.065529 0.126961 1.340266 1.277809 7.147743 7.020782 17.234038 7.020782s17.427552-7.213272 17.427552-7.275729c57.389796-58.154639 140.440207-91.541491
     227.702881-91.541491 168.463948 0 305.520214 131.439231 318.032093 297.156094-10.148751 0.193514-12.893788 0.193514-20.937431 0.3215zM846.451117 534.654487H521.781177c-9.959333 0-18.89478 5.935463-22.662678 15.128929a24.467788 24.467788 0 0 0 5.297582 26.744909l57.007888 56.942358c-33.00392 23.937415-75.774681 37.98205-121.734846 37.98205-91.668453 0-162.910394-48.260835-173.189179-117.457053-1.850161-12.128946-12.318364-21.068488-24.575296-20.940502l-64.282592 0.895899c-13.406754 0.189419-24.130929 11.106084-24.130929 24.512839 0 204.275361 165.717888 370.375158 369.483354 370.375158 91.602924 0 179.059113-32.490953
     244.300062-89.49884l61.858032 61.858032a24.598845 24.598845 0 0 0 26.744908 5.363111c9.128962-3.830355 15.12893-12.769898 15.12893-22.662678V559.167325c0-13.53474-10.979122-24.512839-24.575296-24.512838z m-24.512838 290.005279c-18.129937-18.192394-36.514822-36.514822-36.514822-36.514822h-0.065529c0-0.062457 0-0.062457-0.062457-0.127986-1.340266-1.274737-7.150815-7.020782-17.23711-7.020782s-17.362023 7.213272-17.427552 7.27573c-57.386725 58.154639-140.374678 91.541491-227.637352 91.541491-168.463948 0-305.520214-131.439231-318.032093-297.157119 10.151823-0.189419 12.893788-0.189419 20.937431-0.320476 24.130929 81.647687
     106.73595 138.142608 213.789304 138.142608 67.2836 0 130.670293-24.002944 174.016478-65.877805 2.618075-2.490089 8.553538-6.895868 8.553538-19.470204 0-12.576383-2.363127-12.576383-7.150815-17.365095 0 0-17.234038-17.234038-34.151695-34.086166h240.982674v240.980626z" fill="#27323A" /></svg>
  ''';

type
  TSpdSvgButton = class(TSpeedButton)
  private
    FSvg: TSkSvg;
    FLabel: TLabel;
    FTagString: string;
    procedure SetSvgSource(const Value: string);
    function GetSvgSource: string;
    procedure SetLabelText(const Value: string);
    function GetLabelText: string;
    procedure SetTagString(const Value: string);
  protected
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SvgSource: string read GetSvgSource write SetSvgSource;
    property LabelText: string read GetLabelText write SetLabelText;
    property TagString: string read FTagString write SetTagString;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ZAAZControls', [TSpdSvgButton]);
end;

{ TSpdSvgButton }

constructor TSpdSvgButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Create the SVG control
  FSvg := TSkSvg.Create(Self);
  FSvg.Align := TAlignLayout.Left;
  FSvg.Width := 36;
  FSvg.Height := 36;
  FSvg.Position.X := 4;
  FSvg.Position.Y := 6;
  FSvg.Parent := Self;
  FSvg.Svg.Source := SVG;

  // Create the Label
  FLabel := TLabel.Create(Self);
  FLabel.Align := TAlignLayout.Client;
  FLabel.Margins.Left := 4;
  FLabel.Margins.Right := 4;
  FLabel.Text := 'ButtonLabel';
  FLabel.TextSettings.WordWrap := False;
  FLabel.Parent := Self;

  // Default settings
  Padding.Left := 4;
  Padding.Top := 6;
  Padding.Right := 4;
  Padding.Bottom := 6;
  Width := 196;
  Height := 48;
  Text := '';
  StyleLookup := 'buttonstyle';
end;

destructor TSpdSvgButton.Destroy;
begin
  FSvg.Free;
  FLabel.Free;
  inherited Destroy;
end;

procedure TSpdSvgButton.Resize;
begin
  inherited;
  // Auto-adjust SVG and label position if necessary
  FSvg.Height := Height - Padding.Top - Padding.Bottom;
  FLabel.Height := Height - Padding.Top - Padding.Bottom;
end;

procedure TSpdSvgButton.SetSvgSource(const Value: string);
begin
  FSvg.Svg.Source := Value;
end;

procedure TSpdSvgButton.SetTagString(const Value: string);
begin
  if FTagString <> Value then
  begin
    FTagString := Value;
    FLabel.Text := Value;
  end;
end;

function TSpdSvgButton.GetSvgSource: string;
begin
  Result := FSvg.Svg.Source;
end;

procedure TSpdSvgButton.SetLabelText(const Value: string);
begin
  FLabel.Text := Value;
  // Sync TagString when LabelText is changed (default behavior)
  if FTagString = '' then
    FTagString := Value;
end;

function TSpdSvgButton.GetLabelText: string;
begin
  Result := FLabel.Text;
end;

end.

