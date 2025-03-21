// -----------------------------------------------------------------------------
// Copyright © 1994 - 2025 Aldwicks Limited
//
// Last changed: 21.03.2025 13:38
// -----------------------------------------------------------------------------

unit ListViewZaazFilter;

interface

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Controls,
  FMX.ListView, FMX.SearchBox, FMX.StdCtrls, FMX.Layouts, Skia, FMX.Skia;

const Filter_SVG =
  '''
    <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
    <svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
    <g id="SVGRepo_bgCarrier" stroke-width="0"/>
    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"/>
    <g id="SVGRepo_iconCarrier">
    <path d="M3.22998 1H11.36C12.04 1 12.59 1.56 12.59 2.25V3.62C12.59 4.12 12.28 4.73999 11.97 5.04999L9.32001 7.42001C8.95001 7.73001 8.70001 8.36001 8.70001 8.85001V11.53C8.70001 11.9 8.45002 12.4 8.15002 12.59L7.28998 13.15C6.48998 13.65 5.38 13.09 5.38 12.09V8.78C5.38 8.34 5.13001 7.78 4.89001 7.47L2.54999 4.97C2.23999 4.66 2 4.1 2 3.72V2.29001C2 1.56001 2.54998 1 3.22998 1Z" fill="#2074d9"/>
    <path opacity="0.4" d="M17 2H14.6C14.32 2 14.1 2.22 14.1 2.5C14.1 2.98 14.1 3.62 14.1 3.62C14.1 4.61 13.57 5.57999 13.05 6.10999L10.33 8.54001C10.3 8.61001 10.25 8.71001 10.22 8.79001V11.54C10.22 12.45 9.68 13.44 8.94 13.89L8.12 14.42C7.66 14.71 7.15001 14.85 6.64001 14.85C6.18001 14.85 5.71999 14.73 5.29999 14.5C4.64999 14.14 4.2 13.55 4 12.87V10.21C4 10.08 3.94998 9.94999 3.84998 9.85999L2.84998 8.85999C2.52998 8.54999 2 8.76999 2 9.20999V17C2 19.76 4.24 22 7 22H17C19.76 22 22 19.76 22 17V7C22 4.24 19.76 2 17 2Z" fill="#2074d9"/>
    <path d="M18 13.75H13C12.59 13.75 12.25 13.41 12.25 13C12.25 12.59 12.59 12.25 13 12.25H18C18.41 12.25 18.75 12.59 18.75 13C18.75 13.41 18.41 13.75 18 13.75Z" fill="#2074d9"/>
    <path d="M18 17.75H11C10.59 17.75 10.25 17.41 10.25 17C10.25 16.59 10.59 16.25 11 16.25H18C18.41 16.25 18.75 16.59 18.75 17C18.75 17.41 18.41 17.75 18 17.75Z" fill="#2074d9"/></g></svg>
  ''';

type
  TSearchStyle = (SearchAll, SearchHeight, SearchFontcolor, SearchFontsize, SearchCharcase);

  TListViewZaazFilter = class(TListView)
  private
    FHeight: single;
    FFontcolor: TAlphaColor;
    FFontsize: single;
    FCharcase: TEditCharCase;
    FSearchClear: boolean;
    FSkSvg: TSkSvg;   // Skia SVG component
    FButton: TSpeedButton;   // SpeedButton for 'Filter...'
    FOnFilterButtonClick: TNotifyEvent;  // Event for external usage
    FFilterButtonVisible: Boolean;       // Show/Hide button
    FFilterButtonStyleLookup: string;    // Custom StyleLookup for the button
    FFilterButtonSize: Single;              // Button size (default 40x40)

    // Internal methods
    procedure CreateFilterButton(ASearchBox: TSearchBox);
    procedure DoFilterButtonClick(Sender: TObject);
    procedure SetFilterButtonVisible(const Value: Boolean);
    procedure SetFilterButtonStyleLookup(const Value: string);
    procedure SetFilterButtonSize(const Value: Single);

  protected
    // Internal procedures
    procedure SetSBHeight(AHeight: single);
    procedure SetSBFontsize(AFontsize: single);
    procedure SetSBFontcolor(AFontcolor: TAlphaColor);
    procedure SetSBCharcase(ACharcase: TEditCharCase);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RedoStyle(const ASearchStyle: TSearchStyle = SearchAll);
    procedure ClearSearchText();
    procedure SetSearchText(const AText: string);
    function IsSearchClear(): boolean;

  published
    property SBHeight: single read FHeight write SetSBHeight;
    property SBFontsize: single read FFontsize write SetSBFontsize;
    property SBFontcolor: TAlphaColor read FFontcolor write SetSBFontcolor;
    property SBCharcase: TEditCharCase read FCharcase write SetSBCharcase;
    property FilterButtonVisible: Boolean read FFilterButtonVisible write SetFilterButtonVisible default True;
    property FilterButtonStyleLookup: string read FFilterButtonStyleLookup write SetFilterButtonStyleLookup;
    property FilterButtonSize: Single read FFilterButtonSize write SetFilterButtonSize;
    property OnFilterButtonClick: TNotifyEvent read FOnFilterButtonClick write FOnFilterButtonClick;  // Expose event
  end;

procedure Register;

implementation

destructor TListViewZaazFilter.Destroy;
begin
  if Assigned(FButton) then
    FreeAndNil(FButton);  // Clean up button
  inherited;
end;

constructor TListViewZaazFilter.Create(AOwner: TComponent);
begin
  inherited;
  SearchVisible := true;
  AlternatingColors := true;
  AutoTapScroll := true;
  FSearchClear := true;
  FHeight := 34.0;
  FFontsize := 18.0;
  FFontcolor := TAlphaColors.Darkorange;
  FCharcase := TEditCharCase.ecUpperCase;
  FFilterButtonVisible := True;
  FFilterButtonStyleLookup := 'transparentcirclebuttonstyle';
  FFilterButtonSize := 40; // Default button size 40x40
  RedoStyle();
end;

procedure TListViewZaazFilter.ClearSearchText();
var
  ASearchBox: TSearchBox;
  I: integer;
begin
  for I := 0 to Self.ChildrenCount - 1 do
  begin
    if Self.Children[I] is TSearchBox then
    begin
      ASearchBox := TSearchBox(Self.Children[I]);
      if Assigned(ASearchbox) then
      begin
        ASearchbox.Text := '';
        FSearchClear := true;
      end;
      Break;
    end;
  end;
end;

procedure TListViewZaazFilter.SetSearchText(const AText: string);
var
  ASearchBox: TSearchBox;
  I: integer;
begin
  for I := 0 to Self.ChildrenCount - 1 do
  begin
    if Self.Children[I] is TSearchBox then
    begin
      ASearchBox := TSearchBox(Self.Children[I]);
      if Assigned(ASearchBox) then
      begin
        ASearchBox.Text := AText;
        FSearchClear := false;
      end;
      Break;
    end;
  end;
end;

procedure TListViewZaazFilter.CreateFilterButton(ASearchBox: TSearchBox);
begin
  if not Assigned(FButton) then
  begin
    FButton := TSpeedButton.Create(Self);
    FButton.Parent := ASearchBox;
    FButton.Align := TAlignLayout.Right;
    FButton.Width := FFilterButtonSize;
    FButton.Height := FFilterButtonSize;
    FButton.Margins.Right := 28; // Avoid overlap with X button in SearchBox
    FButton.Position.Y := (ASearchBox.Height - FButton.Height) / 2;
    FButton.OnClick := DoFilterButtonClick;

    // Apply button style if set
    if FFilterButtonStyleLookup <> '' then
      FButton.StyleLookup := FFilterButtonStyleLookup;

    // Create the SVG component
    FSkSvg := TSkSvg.Create(FButton);
    FSkSvg.Parent := FButton;
    FSkSvg.Align := TAlignLayout.Center;
    FSkSvg.Width := FButton.Width * 0.8;  // Slightly smaller than button
    FSkSvg.Height := FButton.Height * 0.8;
    FSkSvg.HitTest := False;
    FSkSvg.Svg.Source := Filter_SVG;
  end;

  // Show/hide button based on property
  FButton.Visible := FFilterButtonVisible;
end;

procedure TListViewZaazFilter.DoFilterButtonClick(Sender: TObject);
begin
  // Trigger the user-defined OnFilterClick event if assigned
  if Assigned(FOnFilterButtonClick) then
    FOnFilterButtonClick(Self);
end;

function TListViewZaazFilter.IsSearchClear(): boolean;
var
  ASearchbox: TSearchBox;
begin
  for var I := 0 to self.ChildrenCount-1 do
  begin
    if self.Children[I] is TSearchBox then
    begin
      ASearchbox := TSearchBox(self.Children[I]);
      if Assigned(ASearchbox) then
      begin
        if ASearchbox.Text = '' then
          FSearchClear := true
        else
          FSearchClear := false;
      end;
      Break;
    end;
  end;
  Result := FSearchClear;
end;

procedure TListViewZaazFilter.SetSBHeight(AHeight: single);
begin
  FHeight := AHeight;
  RedoStyle(TSearchStyle.SearchHeight);
end;

procedure TListViewZaazFilter.SetSBFontsize(AFontsize: single);
begin
  FFontsize := AFontsize;
  RedoStyle(TSearchStyle.SearchFontsize);
end;

procedure TListViewZaazFilter.SetSBFontcolor(AFontcolor: TAlphaColor);
begin
  FFontcolor := AFontcolor;
  RedoStyle(TSearchStyle.SearchFontcolor);
end;

procedure TListViewZaazFilter.SetFilterButtonSize(const Value: Single);
begin
  if FFilterButtonSize <> Value then
  begin
    FFilterButtonSize := Value;
    if Assigned(FButton) then
    begin
      FButton.Width := FFilterButtonSize;
      FButton.Height := FFilterButtonSize;
    end;
  end;
end;

procedure TListViewZaazFilter.SetFilterButtonStyleLookup(const Value: string);
begin
  if FFilterButtonStyleLookup <> Value then
  begin
    FFilterButtonStyleLookup := Value;
    if Assigned(FButton) and (Value <> '') then
      FButton.StyleLookup := Value;
  end;
end;

procedure TListViewZaazFilter.SetFilterButtonVisible(const Value: Boolean);
begin
  if FFilterButtonVisible <> Value then
  begin
    FFilterButtonVisible := Value;
    if Assigned(FButton) then
      FButton.Visible := FFilterButtonVisible;
  end;
end;

procedure TListViewZaazFilter.SetSBCharcase(ACharcase: TEditCharCase);
begin
  FCharcase := ACharcase;
  RedoStyle(TSearchStyle.SearchCharcase);
end;

procedure TListViewZaazFilter.RedoStyle(const ASearchStyle: TSearchStyle);
var
  I: integer;
  ASearchBox: TSearchBox;
begin
  for I := 0 to Self.ChildrenCount - 1 do
  begin
    if Self.Children[I] is TSearchBox then
    begin
      ASearchBox := TSearchBox(Self.Children[I]);
      if Assigned(ASearchBox) then
      begin
        ASearchBox.StyledSettings := [];
        case ASearchStyle of
          SearchAll:
            begin
              ASearchBox.Height := SBHeight;
              ASearchBox.Font.Size := SBFontsize;
              ASearchBox.FontColor := SBFontcolor;
              ASearchBox.CharCase := SBCharcase;
            end;
          SearchHeight:    ASearchBox.Height := SBHeight;
          SearchFontcolor: ASearchBox.FontColor := SBFontcolor;
          SearchFontsize:  ASearchBox.Font.Size := SBFontsize;
          SearchCharcase:  ASearchBox.CharCase := SBCharcase;
        end;

        // Apply styles to SearchBox
        ASearchBox.StyledSettings := ASearchBox.StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor];
        ASearchBox.Visible := true;
        // Create the Filter Button if it doesn't exist
        CreateFilterButton(ASearchBox);
      end;
      Break;
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('ZAAZControls', [TListViewZaazFilter]);
end;

end.

