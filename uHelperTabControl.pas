// -----------------------------------------------------------------------------
// Copyright © 1994 - 2026 Aldwicks Limited
//
// 🛠 Last changed: 29.06.2026 16:06
// -----------------------------------------------------------------------------

unit uTabControlHelper;

interface

uses
  System.Classes, FMX.TabControl;

{ The idea here is to simplfy tabmovement, saves lots of typing! }
type
  TTabControlHelper = class helper for TTabControl
  public
    // Changed so can choose to show the slide (default) or not
    procedure TabLeft(TargetTab: TTabItem; Slide: boolean = true);
    // Replaces something as complex as TAbControl1.SetActiveTabWithTransitionAsync(TTabItem, TTabTransition.Slide, TTabTransitionDirection.Reversed, nil);
    procedure TabRight(TargetTab: TTabItem; Slide: boolean = true);
    // Replaces something as complex as TAbControl1.SetActiveTabWithTransitionAsync(TTabItem, TTabTransition.Slide, TTabTransitionDirection.Normal, nil);
  end;

implementation

{ TTabControl Helper procedures }

procedure TTabControlHelper.TabLeft(TargetTab: TTabItem; Slide: boolean);
begin
  if not Assigned(TargetTab) then
    exit;
  if Slide then
    Self.SetActiveTabWithTransitionAsync(TargetTab, TTabTransition.Slide, TTabTransitionDirection.Reversed, nil)
  else
    Self.ActiveTab := TargetTab;
end;

procedure TTabControlHelper.TabRight(TargetTab: TTabItem; Slide: boolean);
begin
  if not Assigned(TargetTab) then
    exit;
  if Slide then
    Self.SetActiveTabWithTransitionAsync(TargetTab, TTabTransition.Slide, TTabTransitionDirection.Normal, nil)
  else
    Self.ActiveTab := TargetTab;
end;

end.
