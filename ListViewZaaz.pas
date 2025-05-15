// -----------------------------------------------------------------------------
// Copyright © 1994 - 2025 Aldwicks Limited
//
// Last changed: 15.05.2025 14:34
// -----------------------------------------------------------------------------

unit ListViewZaaz;

interface

uses
  System.SysUtils, System.Classes, System.UITypes, FMX.Types, FMX.Controls, FMX.ListView, FMX.SearchBox;

type
  TSearchStyle = (SearchAll, SearchHeight, SearchFontcolor, SearchFontsize, SearchCharcase);

type
  TListViewZaaz = class(TListView)
  private
    { Private declarations }
    FHeight: single;
    FFontcolor: TAlphaColor;
    FFontsize: single;
    FCharcase: TEditCharCase;
    FSearchClear: boolean;
//    FSearchBox: TSearchBox;
  protected
    { Protected declarations }
    procedure SetSBHeight(AHeight: single);
    procedure SetSBFontsize(AFontsize: single);
    procedure SetSBFontcolor(AFontcolor: TAlphaColor);
    procedure SetSBCharcase(ACharcase: TEditCharCase);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    procedure RedoStyle(const ASearchStyle: TSearchStyle = SearchAll);
    procedure ClearSearchText();
    procedure SetSearchText(const AText: string);  // New method declaration
    function IsSearchClear(): boolean;
  published
    { Published declarations }
    property SBHeight: single read FHeight write SetSBHeight;
    property SBFontsize: single read FFontsize write SetSBFontsize;
    property SBFontcolor: TAlphaColor read FFontcolor write SetSBFontcolor;
    property SBCharcase: TEditCharCase read FCharcase write SetSBCharcase;
  end;

procedure Register;

implementation

destructor TListViewZaaz.Destroy();
begin
  inherited;
end;

function TListViewZaaz.IsSearchClear(): boolean;
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

procedure TListViewZaaz.ClearSearchText();
var
  ASearchbox: TSearchBox;
  I: integer;
begin
  for I := 0 to self.ChildrenCount-1 do
  begin
    if self.Children[I] is TSearchBox then
    begin
      ASearchbox := TSearchBox(self.Children[I]);
      if Assigned(ASearchbox) then
      begin
        ASearchbox.Text := '';
        FSearchClear := true;
      end;
      Break;
    end;
  end;
end;

constructor TListViewZaaz.Create(AOwner: TComponent);
begin
  inherited;
  SearchVisible := true;
  AlternatingColors := true;
  AutoTapScroll := true;
  FHeight := 34.0;
  FFontsize := 18.0;
  FFontcolor := TAlphaColors.Darkorange;
  FCharcase := TEditCharCase.ecUpperCase;
  RedoStyle();
end;

procedure TListViewZaaz.SetSBHeight(AHeight: single);
begin
  FHeight := AHeight;
  RedoStyle(TSearchStyle.SearchHeight);
end;

procedure TListViewZaaz.SetSearchText(const AText: string);
var
  ASearchBox: TSearchBox;
  I: integer;
begin
  // Iterate through the children to locate the TSearchBox
  for I := 0 to Self.ChildrenCount - 1 do
  begin
    if Self.Children[I] is TSearchBox then
    begin
      ASearchBox := TSearchBox(Self.Children[I]);
      if Assigned(ASearchBox) then
      begin
        ASearchBox.Text := AText;
        FSearchClear := false;
        // If your list view filtering depends on the search text change,
        // ensure that setting the Text property triggers the filtering.
        // For example, if you have an OnChange event for the SearchBox, it will fire here.
      end;
      Break;
    end;
  end;
end;

procedure TListViewZaaz.SetSBFontsize(AFontsize: single);
begin
  FFontsize := AFontsize;
  RedoStyle(TSearchStyle.SearchFontsize);
end;

procedure TListViewZaaz.SetSBFontcolor(AFontcolor: TAlphaColor);
begin
  FFontcolor := AFontcolor;
  RedoStyle(TSearchStyle.SearchFontcolor);
end;

procedure TListViewZaaz.SetSBCharcase(ACharcase: TEditCharCase);
begin
  FCharcase := ACharcase;
  RedoStyle(TSearchStyle.SearchCharcase);
end;

procedure TListViewZaaz.RedoStyle(const ASearchStyle: TSearchStyle);
var
  I: integer;
  ASearchbox: TSearchBox;
begin
    for I := 0 to self.ChildrenCount-1 do
    begin
      if self.Children[I] is TSearchBox then
      begin
        ASearchbox := TSearchBox(self.Children[I]);
        if Assigned(ASearchbox) then
        begin
          ASearchbox.StyledSettings := [];
          case ASearchStyle of
            SearchAll:
            begin
              ASearchbox.Height := SBHeight;
              ASearchbox.Font.Size := SBFontsize;
              ASearchbox.FontColor := SBFontcolor;
              ASearchbox.CharCase := SBCharcase;
            end;
            SearchHeight: ASearchbox.Height := SBHeight;
            SearchFontcolor: ASearchbox.FontColor := SBFontcolor;
            SearchFontsize: ASearchbox.Font.Size := SBFontsize;
            SearchCharcase: ASearchbox.CharCase := SBCharcase;
          end;
          ASearchbox.StyledSettings := ASearchbox.StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor];
          ASearchbox.Visible := true;
        end;
        Break;
      end;
    end;
end;

procedure Register;
begin
  RegisterComponents('ZAAZControls', [TListViewZaaz]);
end;

end.


