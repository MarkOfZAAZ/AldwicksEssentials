// -----------------------------------------------------------------------------
// Copyright � 1994 - 2025 Aldwicks Limited
//
// Last changed: 15.05.2025 14:34
// -----------------------------------------------------------------------------

unit ComboEditZaaz;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit;

type
  TComboEditZaaz = class(TComboEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property CharCase; // Publish hidden property!
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('ZAAZControls', [TComboEditZaaz]);
end;

end.
