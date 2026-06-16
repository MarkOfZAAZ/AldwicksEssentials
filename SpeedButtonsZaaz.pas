unit SpeedButtonsZaaz;

interface

uses
  System.SysUtils, System.Classes, System.Skia, System.StrUtils,
  FMX.Types, FMX.Controls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo, FMX.Skia;


type
  TCircleColor = (
    ccDark,      // your standard steel blue - the main brand colour
    ccDefault,
    ccNavy,         // darker blue, still in the blue family
    ccSlate,        // blue-grey, subtle alternative to default
    ccCharcoal,     // dark neutral for contrast-heavy contexts
    ccGraphite,     // mid-grey, less harsh than charcoal
    ccSilver,       // light grey, for light-background toolbars
    ccAmber,        // warm warning/attention colour
    ccCrimson,      // red, delete/danger actions
    ccForest,       // muted green, success/complete actions
    ccTeal,         // teal, secondary/info actions
    ccPurple,       // purple, for distinguish special functions
    ccRose          // soft red/pink, alternative caution colour
  );

const
  CC_DEFAULT:  string = '#324A5E'; // steel blue - your brand default
  CC_DARK:     string = '#324A5E'; // steel blue - your brand default
  CC_NAVY:     string = '#1B2A3B'; // deep navy
  CC_SLATE:    string = '#4A6274'; // lighter blue-grey
  CC_CHARCOAL: string = '#2D3A3A'; // very dark teal-grey
  CC_GRAPHITE: string = '#5A6472'; // mid blue-grey
  CC_SILVER:   string = '#8A9BAD'; // light blue-grey
  CC_AMBER:    string = '#B85C00'; // burnt amber, warning
  CC_CRIMSON:  string = '#A01830'; // deep crimson, danger/delete
  CC_FOREST:   string = '#2E6B4F'; // forest green, success/done
  CC_TEAL:     string = '#1A6B7C'; // deep teal, info/secondary
  CC_PURPLE:   string = '#4A3570'; // deep purple, special functions
  CC_ROSE:     string = '#8B3A52'; // muted rose, soft warning

  const
    COLOR_TOKEN = '{{CIRCLE_COLOR}}';

  type
    TSpeedCircleButtonBase = class(TSpeedButton)
    private
      FSvg: TSkSvg;
      FCircleColor: TCircleColor;
      FIconSvg: string;
      procedure SetCircleColor(const Value: TCircleColor);
    protected
      procedure InitButton(const ASvg: string; const AHint: string; AAlign: TAlignLayout);
    public
      constructor Create(AOwner: TComponent); override;
    published
      property Text stored False;
      property CircleColour: TCircleColor read FCircleColor write SetCircleColor default ccDefault;
    end;

  type
    TSpeedConfig = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedDelete = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedAdd = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedFilter = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedAssign = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedPrint = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedApply = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedAddAlt = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedBack = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedHome = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedMenu = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedRefresh = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedSelect = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedCancel = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedCopy = class(TSpeedCircleButtonBase)
    public
      constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedSort = class(TSpeedCircleButtonBase)
      public
        constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedCamera = class(TSpeedCircleButtonBase)
      public
        constructor Create(AOwner: TComponent); override;
    end;

  type
    TSpeedPicture = class(TSpeedCircleButtonBase)
      public
        constructor Create(AOwner: TComponent); override;
    end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('AldwicksSpeedButtons', [TSpeedAdd]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedAddAlt]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedApply]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedAssign]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedBack]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedCamera]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedCancel]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedConfig]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedCopy]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedDelete]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedFilter]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedHome]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedMenu]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedPicture]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedPrint]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedRefresh]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedSelect]);
  RegisterComponents('AldwicksSpeedButtons', [TSpeedSort]);
end;

function CircleColorToHex(const AColor: TCircleColor): string;
begin
  case AColor of
    ccDefault:  Result := CC_DEFAULT;
    ccDark:     Result := CC_DEFAULT;
    ccNavy:     Result := CC_NAVY;
    ccSlate:    Result := CC_SLATE;
    ccCharcoal: Result := CC_CHARCOAL;
    ccGraphite: Result := CC_GRAPHITE;
    ccSilver:   Result := CC_SILVER;
    ccAmber:    Result := CC_AMBER;
    ccCrimson:  Result := CC_CRIMSON;
    ccForest:   Result := CC_FOREST;
    ccTeal:     Result := CC_TEAL;
    ccPurple:   Result := CC_PURPLE;
    ccRose:     Result := CC_ROSE;
  else
    raise EArgumentOutOfRangeException.CreateFmt(
      'CircleColorToHex: unhandled TCircleColor value %d', [Ord(AColor)]);
  end;
end;

function IsGreyscale(const AColor: TCircleColor): Boolean;
begin
  Result := AColor in [ccGraphite, ccSilver];
end;

{ TSpeedCircleButtonBase }

constructor TSpeedCircleButtonBase.Create(AOwner: TComponent);
begin
  inherited;
  Height := 44;
  Width := 44;
  StyleLookup := 'transparentcirclebuttonstyle';
  ShowHint := True;
  Text := '';

  FSvg := TSkSvg.Create(Self);
  FSvg.Parent := Self;
  FSvg.Align := TAlignLayout.Client;
  FSvg.HitTest := False;
  FSvg.Stored := False;

  FCircleColor := ccDefault;
end;

procedure TSpeedCircleButtonBase.InitButton(const ASvg, AHint: string; AAlign: TAlignLayout);
begin
  FIconSvg := ASvg;
  Hint     := AHint;
  Align    := AAlign;
  FSvg.Svg.GrayScale := IsGreyscale(FCircleColor);
  FSvg.Svg.Source    := ReplaceStr(FIconSvg, COLOR_TOKEN, CircleColorToHex(FCircleColor));
end;

procedure TSpeedCircleButtonBase.SetCircleColor(const Value: TCircleColor);
begin
  if FCircleColor = Value
    then Exit; // guard against no-op
  FCircleColor := Value;
  FSvg.Svg.GrayScale := IsGreyscale(Value);
  FSvg.Svg.Source    := ReplaceStr(FIconSvg, COLOR_TOKEN, CircleColorToHex(Value));
end;

{ TSpeedAddNew }

constructor TSpeedAdd.Create(AOwner: TComponent);
const
  ICON_ADD: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(2.6,2.2) scale(0.38)">
        <path d="M14.5 19.5a2 2 0 1 0 0 4 2 2 0 1 0 0-4zm-2 14a2 2 0 1 1 4 0 2 2 0 1 1-4 0z fill="#87CEFA"/>
        <path d="M11.25 6A5.25 5.25 0 0 0 6 11.25v25.5A5.25 5.25 0 0 0 11.25 42h12.794A12.94 12.94 0 0 1 22 35c0-7.18 5.82-13 13-13a12.94 12.94 0 0 1 7 2.044V11.25A5.25 5.25 0 0 0 36.75 6h-25.5zM10 21.5a4.5 4.5 0 1 1 9 0 4.5 4.5 0 1 1-9 0zm4.5 7.5a4.5 4.5 0 1 1 0 9 4.5 4.5 0 1 1 0-9zm6.5-9.25a1.25 1.25 0 0 1 1.25-1.25h14.499a1.25 1.25 0 1 1 0 2.5H22.25A1.25 1.25 0 0 1 21 19.75zm-9.737-8.655H36.73a1.25 1.25 0 1 1 0 2.5H11.263a1.25 1.25 0 1 1 0-2.5z"
          fill="#5FA4E0" fill-opacity=".81"/>
        <path d="M46 35c0 6.075-4.925 11-11 11s-11-4.925-11-11 4.925-11 11-11 11 4.925 11 11zm-10-7a1 1 0 1 0-2 0v6h-6a1 1 0 1 0 0 2h6v6a1 1 0 1 0 2 0v-6h6a1 1 0 1 0 0-2h-6v-6z"
          fill="#87CEFA"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_ADD, 'Add a new record...', TAlignLayout.Right);
end;

{ TSpeedApplyNew }

constructor TSpeedApply.Create(AOwner: TComponent);
const
  ICON_APPLY: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(3.2,3.2) scale(0.72)">
        <path fill="#5FA4E0"
          d="M4.91988 12.257C4.2856 12.257 3.65131 12.5199 3.19988 13.0342C2.79417 13.4913 2.59417 14.0799 2.63417 14.6913C2.67417 15.3027 2.94846 15.857 3.4056 16.2627L7.51417 19.8684C7.93131 20.2342 8.46846 20.4399 9.02274 20.4399C9.0856 20.4399 9.14846 20.4399 9.21131 20.4342C9.82846 20.3827 10.4056 20.0799 10.7942 19.5999L20.857 7.27986C21.657 6.30272 21.5085 4.85701 20.5313 4.05701C20.057 3.67415 19.4627 3.49129 18.857 3.55415C18.2513 3.61701 17.7027 3.90844 17.3142 4.38272L8.74846 14.8627L6.42274 12.8227C5.99417 12.4456 5.45131 12.257 4.91988 12.257Z"
        />
        <path fill="#87CEFA"
          d="M9.02279 20.0284C8.56565 20.0284 8.12565 19.8627 7.78279 19.5598L3.67422 15.9541C2.89708 15.2684 2.81708 14.0798 3.50279 13.3027C4.18851 12.5255 5.37708 12.4455 6.15422 13.1313L8.79994 15.4513L17.6285 4.63983C18.2856 3.83412 19.4685 3.71983 20.2742 4.37126C21.0799 5.0284 21.1942 6.21126 20.5428 7.01697L10.4742 19.337C10.1542 19.7313 9.67993 19.977 9.17708 20.0227C9.12565 20.0227 9.07422 20.0284 9.02279 20.0284Z"
        />
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_APPLY, 'Accept the changes / selection...', TAlignLayout.Right);
end;

{ TSpeedAddAltNew }

constructor TSpeedAddAlt.Create(AOwner: TComponent);
const
  ICON_ADD_ALTERNATE: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(2.6,2.2) scale(0.38)">
        <path d="M14.5 19.5a2 2 0 1 0 0 4 2 2 0 1 0 0-4zm-2 14a2 2 0 1 1 4 0 2 2 0 1 1-4 0z"
          fill="#bcc4a4"/>
        <path d="M11.25 6A5.25 5.25 0 0 0 6 11.25v25.5A5.25 5.25 0 0 0 11.25 42h12.794A12.94 12.94 0 0 1 22 35c0-7.18 5.82-13 13-13a12.94 12.94 0 0 1 7 2.044V11.25A5.25 5.25 0 0 0 36.75 6h-25.5zM10 21.5a4.5 4.5 0 1 1 9 0 4.5 4.5 0 1 1-9 0zm4.5 7.5a4.5 4.5 0 1 1 0 9 4.5 4.5 0 1 1 0-9zm6.5-9.25a1.25 1.25 0 0 1 1.25-1.25h14.499a1.25 1.25 0 1 1 0 2.5H22.25A1.25 1.25 0 0 1 21 19.75zm-9.737-8.655H36.73a1.25 1.25 0 1 1 0 2.5H11.263a1.25 1.25 0 1 1 0-2.5z"
          fill="#9c9858" fill-opacity=".81"/>
        <path d="M46 35c0 6.075-4.925 11-11 11s-11-4.925-11-11 4.925-11 11-11 11 4.925 11 11zm-10-7a1 1 0 1 0-2 0v6h-6a1 1 0 1 0 0 2h6v6a1 1 0 1 0 2 0v-6h6a1 1 0 1 0 0-2h-6v-6z"
          fill="#bcc4a4"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_ADD_ALTERNATE, 'Add a new record...', TAlignLayout.Right);
end;

{ TSpeedBackNew }

constructor TSpeedBack.Create(AOwner: TComponent);
const
  ICON_BACK: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(3.2,3.2) scale(0.38)">
        <path d="M8.532,18.531l8.955-8.999c-0.244-0.736-0.798-1.348-1.54-1.653 c-1.01-0.418-2.177-0.185-2.95,0.591L1.047,20.479c-1.396,1.402-1.396,3.67,0,5.073 l11.949,12.01c0.771,0.775,1.941,1.01,2.951,0.592c0.742-0.307,1.295-0.918,1.54-1.652 l-8.956-9C6.07,25.027,6.071,21.003,8.532,18.531z" fill="#87CEFA"/>
        <path d="M45.973,31.64c-1.396-5.957-5.771-14.256-18.906-16.01v-5.252 c0-1.095-0.664-2.082-1.676-2.5c-0.334-0.138-0.686-0.205-1.033-0.205 c-0.705,0-1.398,0.276-1.917,0.796L10.49,20.479c-1.396,1.402-1.396,3.669-0.001,5.073 l11.95,12.009c0.517,0.521,1.212,0.797,1.92,0.797c0.347,0,0.697-0.066,1.031-0.205 c1.012-0.418,1.676-1.404,1.676-2.5V30.57c4.494,0.004,10.963,0.596,15.564,3.463 c0.361,0.225,0.77,0.336,1.176,0.336c0.457,0,0.91-0.139,1.297-0.416 C45.836,33.429,46.18,32.515,45.973,31.64z" fill="#5FA4E0"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_BACK, 'Back to previous page...', TAlignLayout.MostLeft);
end;

{ TSpeedHomeNew }

constructor TSpeedHome.Create(AOwner: TComponent);
const
  ICON_HOME: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(2.2,1.6) scale(0.82)" fill="#324A5E">
        <path d="M2 9.5L11.04 2.72C11.3843 2.46181 11.5564 2.33271 11.7454 2.28294C11.9123 2.23902 12.0877 2.23902 12.2546 2.28295C12.4436 2.33271 12.6157 2.46181 12.96 2.72L22 9.5M4 8V17.8C4 18.9201 4 19.4802 4.21799 19.908C4.40974 20.2843 4.7157 20.5903 5.09202 20.782C5.51985 21 6.0799 21 7.2 21H16.8C17.9201 21 18.4802 21 18.908 20.782C19.2843 20.5903 19.5903 20.2843 19.782 19.908C20 19.4802 20 18.9201 20 17.8V8L13.92 3.44C13.2315 2.92361 12.8872 2.66542 12.5091 2.56589C12.1754 2.47804 11.8246 2.47804 11.4909 2.56589C11.1128 2.66542 10.7685 2.92361 10.08 3.44L4 8Z" stroke="#5FA4E0" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M9 19.6V13.6C9 13.0399 9 12.7599 9.109 12.546C9.20487 12.3578 9.35785 12.2049 9.54601 12.109C9.75993 12 10.04 12 10.6 12H13.4C13.9601 12 14.2401 12 14.454 12.109C14.6422 12.2049 14.7951 12.3578 14.891 12.546C15 12.7599 15 13.0399 15 13.6V19.6" stroke="#87CEFA" stroke-width="2" stroke-linecap="butt" stroke-linejoin="round"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_HOME, 'Back to Home page...', TAlignLayout.MostLeft);
end;

{ TSpeedMenuNew }

constructor TSpeedMenu.Create(AOwner: TComponent);
const
  ICON_MENU: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <path d="M16 9H8a1 1 0 0 1 0-2h8a1 1 0 0 1 0 2z" fill="#87CEFA"/>
      <path d="M16 13H8a1 1 0 0 1 0-2h8a1 1 0 0 1 0 2z" fill="#5FA4E0"/>
      <path d="M16 17H8a1 1 0 0 1 0-2h8a1 1 0 0 1 0 2z" fill="#87CEFA"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_MENU, 'Show other options...', TAlignLayout.MostRight);
end;

{ TSpeedRefreshNew }

constructor TSpeedRefresh.Create(AOwner: TComponent);
const
  ICON_REFRESH: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <path d="M7.2 10.8c0-2.5 2.4-4.6 4.8-4.6 1.6 0 3.1.6 4.2 1.7l-1.2 1.2c-.4.4-.1 1 .4 1h3.1c.4 0 .7-.3.7-.7V6.3c0-.5-.6-.8-1-.4l-1.2 1.2C15.4 5.4 13.8 4.8 12 4.8c-3.7 0-6.8 2.6-6.8 6h2z" fill="#87CEFA"/>
      <path d="M16.8 13.2c0 2.5-2.4 4.6-4.8 4.6-1.6 0-3.1-.6-4.2-1.7l1.2-1.2c.4-.4.1-1-.4-1H5.5c-.4 0-.7.3-.7.7v3.1c0 .5.6.8 1 .4l1.2-1.2C8.6 18.6 10.2 19.2 12 19.2c3.7 0 6.8-2.6 6.8-6h-2z" fill="#5FA4E0"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_REFRESH, 'Refresh the current view...', TAlignLayout.None);
end;

{ TSpeedSelectNew }

constructor TSpeedSelect.Create(AOwner: TComponent);
const
  ICON_SELECT: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <path fill="#87CEFA"
        d="M9.869 16.163a1.079 1.079 0 1 1-2.158 0 1.079 1.079 0 0 1 2.158 0zm-1.079-9.709a1.079 1.079 0 1 0 0 2.158 1.079 1.079 0 0 0 0-2.158zm1.079 5.394a1.079 1.079 0 1 1-2.158 0 1.079 1.079 0 0 1 2.158 0zm-.539 0a.539.539 0 1 0-1.079 0 .539.539 0 0 0 1.079 0zM18.499 5.915v11.867c0 .894-.724 1.618-1.618 1.618H7.172c-.894 0-1.618-.724-1.618-1.618V5.915c0-.894.724-1.618 1.618-1.618h9.709c.894 0 1.618.724 1.618 1.618zM10.408 16.163c0-.894-.724-1.618-1.618-1.618-.894 0-1.618.724-1.618 1.618 0 .894.724 1.618 1.618 1.618.894 0 1.618-.724 1.618-1.618zm0-4.315c0-.894-.724-1.618-1.618-1.618-.894 0-1.618.724-1.618 1.618 0 .894.724 1.618 1.618 1.618.894 0 1.618-.724 1.618-1.618zm0-4.315c0-.894-.724-1.618-1.618-1.618-.894 0-1.618.724-1.618 1.618 0 .894.724 1.618 1.618 1.618.894 0 1.618-.724 1.618-1.618zm5.394 8.9a.27.27 0 0 0-.27-.27h-3.776a.27.27 0 0 0 0 .54h3.776a.27.27 0 0 0
         .27-.27zm0-1.079a.27.27 0 0 0-.27-.27h-3.776a.27.27 0 0 0 0 .54h3.776a.27.27 0 0 0 .27-.27zm0-3.236a.27.27 0 0 0-.27-.27h-3.776a.27.27 0 0 0 0 .54h3.776a.27.27 0 0 0 .27-.27zm0-1.079a.27.27 0 0 0-.27-.27h-3.776a.27.27 0 0 0 0 .54h3.776a.27.27 0 0 0 .27-.27zm0-3.236a.27.27 0 0 0-.27-.27h-3.776a.27.27 0 0 0 0 .54h3.776a.27.27 0 0 0 .27-.27zm0-1.079a.27.27 0 0 0-.27-.27h-3.776a.27.27 0 0 0 0 .54h3.776a.27.27 0 0 0 .27-.27z"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_SELECT, 'Select from list...', TAlignLayout.None);
end;

{ TSpeedCancel }

constructor TSpeedCancel.Create(AOwner: TComponent);
const
  ICON_CANCEL: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="matrix(0.02811203,0,0,0.02811203,4.9052884,5.0486465)">
        <polygon fill="#f4b2b0"
          points="114.833,494.563 255.603,353.793 256.001,353.395 256.001,158.605 114.833,17.437 17.437,114.83 158.605,256 17.437,397.17"/>
        <path
          fill="#b3404a"
          d="m 378.055,256 128.84,-128.839 c 6.809,-6.809 6.809,-17.85 0,-24.659
             L 409.498,5.105 c -6.807,-6.807 -17.85,-6.807 -24.659,0 L 256.001,133.944
             127.162,5.105 c -0.425,-0.425 -0.868,-0.825 -1.325,-1.196
             C 122.643,1.303 118.737,0 114.833,0 c -2.232,0 -4.462,0.425 -6.561,1.276
             -2.099,0.851 -4.066,2.127 -5.768,3.829 L 5.108,102.503
             c -6.809,6.809 -6.809,17.85 0,24.659 L 133.948,256 5.108,384.839
             c -6.809,6.809 -6.809,17.85 0,24.659 l 97.395,97.395
             c 3.405,3.404 7.867,5.107 12.329,5.107 4.462,0 8.926,-1.704 12.329,-5.107
             l 140.771,-140.772 0.398,-0.398 c 0.413,-0.413 0.802,-0.844 1.168,-1.292
             0.277,-0.34 0.527,-0.694 0.776,-1.048 0.289,-0.432 0.549,-0.877 0.795,-1.329
             0.244,-0.459 0.462,-0.926 0.663,-1.4 0.185,-0.45 0.344,-0.907 0.49,-1.367
             0.127,-0.422 0.227,-0.849 0.321,-1.278 0.08,-0.405 0.131,-0.814 0.183,-1.222
             0.051,-0.525 0.075,-1.053 0.078,-1.58 V 165.829 L 379.733,42.095
             452.47,114.832 323.63,243.671 c -6.809,6.809 -6.809,17.85 0,24.661
             l 128.84,128.839 -72.737,72.737 -60.407,-60.407
             c -6.809,-6.809 -17.85,-6.809 -24.661,0 -6.809,6.809 -6.809,17.85 0,24.661
             l 72.737,72.737 c 3.405,3.404 7.867,5.107 12.329,5.107
             4.462,0 8.926,-1.704 12.329,-5.107 l 97.395,-97.395
             c 6.809,-6.809 6.809,-17.85 0,-24.659 z
             m -207.118,12.329 c 6.809,-6.809 6.809,-17.85 0,-24.661
             L 42.096,114.83 114.833,42.093 238.565,165.826 V 346.171
             L 114.833,469.905 42.096,397.168 Z"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_CANCEL, 'Cancel and return to previous page...', TAlignLayout.MostRight);
end;

{ TSpeedPrint }

constructor TSpeedPrint.Create(AOwner: TComponent);
const
  ICON_PRINT: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(1.7,1.0) scale(0.427)">
        <path d="M10 20h28c2 0 3 1 3 3v14c0 2-1 3-3 3H10c-2 0-3-1-3-3V23c0-2 1-3 3-3z" fill="#5FA4E0"/>
        <rect x="14" y="30" width="20" height="12" rx="1.5" fill="#87CEFA"/>
        <rect x="14" y="10" width="20" height="10" rx="1.5" fill="#87CEFA"/>
        <rect x="18" y="26" width="12" height="2.5" rx="1" fill="#324A5E"/>
        <circle cx="9" cy="38" r="0.85" fill="#E25563"/>
      </g>
    </svg>

  ''';
begin
  inherited;
  InitButton(ICON_PRINT, 'Print (preview) the current HTML..', TAlignLayout.MostRight);
end;

{ TSpeedAssign }

constructor TSpeedAssign.Create(AOwner: TComponent);
const
  ICON_ASSIGN: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="matrix(0.40632534,0,0,0.46387567,2.2522897,2.3439308)">
        <rect x="22" y="8" width="20" height="26" rx="2" ry="2" fill="#87CEFA"/>
        <rect x="25" y="13" width="10" height="2.5" rx="1" fill="#5FA4E0"/>
        <rect x="25" y="19" width="10" height="2.5" rx="1" fill="#5FA4E0"/>
        <rect x="25" y="25" width="6"  height="2.5" rx="1" fill="#5FA4E0"/>
        <path d="M4,21 H18" stroke="#5FA4E0" stroke-width="3.5" stroke-linecap="round" fill="none"/>
        <polygon points="16,15 26,21 16,27" fill="#5FA4E0"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_ASSIGN, 'Assign to...', TAlignLayout.MostRight);
end;

{ TSpeedCopy }

constructor TSpeedCopy.Create(AOwner: TComponent);
const
  ICON_COPY: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
    <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
    <g transform="translate(4.5,5.0) scale(0.35)">
      <rect x="12" y="1" width="24" height="30" rx="2" ry="2" fill="#5FA4E0"/>
      <rect x="5" y="9" width="24" height="30" rx="2" ry="2" fill="#87CEFA"/>
      <rect x="10" y="15" width="14" height="2.5" rx="1" fill="#5FA4E0"/>
      <rect x="10" y="21" width="14" height="2.5" rx="1" fill="#5FA4E0"/>
      <rect x="10" y="27" width="9"  height="2.5" rx="1" fill="#5FA4E0"/>
    </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_COPY, 'Copy item...', TAlignLayout.MostRight);
end;

{ TSpeedFilter }

constructor TSpeedFilter.Create(AOwner: TComponent);
const
  ICON_FILTER: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <line x1="6" y1="9" x2="18" y2="9" stroke="#5FA4E0" stroke-width="1.5" stroke-linecap="round"/>
      <circle cx="14" cy="9" r="1.8" fill="#87CEFA"/>
      <line x1="6" y1="12" x2="18" y2="12" stroke="#5FA4E0" stroke-width="1.5" stroke-linecap="round"/>
      <circle cx="10" cy="12" r="1.8" fill="#87CEFA"/>
      <line x1="6" y1="15" x2="18" y2="15" stroke="#5FA4E0" stroke-width="1.5" stroke-linecap="round"/>
      <circle cx="13" cy="15" r="1.8" fill="#87CEFA"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_FILTER, 'Filter options...', TAlignLayout.MostRight);
end;

{ TSpeedConfig }

constructor TSpeedConfig.Create(AOwner: TComponent);
const
  ICON_CONFIG: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="translate(12,12)">
        <!-- Gear teeth -->
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(45)"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(90)"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(135)"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(180)"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(225)"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(270)"/>
        <rect x="-1.1" y="-7.6" width="2.2" height="2.8" rx="0.6" fill="#5FA4E0" transform="rotate(315)"/>
        <!-- Gear body -->
        <circle cx="0" cy="0" r="5" fill="#5FA4E0"/>
        <!-- Centre hole -->
        <circle cx="0" cy="0" r="2.2" fill="#324A5E"/>
        <!-- Accent ring -->
        <circle cx="0" cy="0" r="2.2" fill="none" stroke="#87CEFA" stroke-width="0.9"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_CONFIG, 'Configuration...', TAlignLayout.MostRight);
end;

{ TSpeedSort }

constructor TSpeedSort.Create(AOwner: TComponent);
const
  ICON_SORT: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <g transform="matrix(0.04154925,0,0,0.04141006,1.3547575,1.5788576)">
        <polygon fill="#5FA4E0" points="302.4,348.4 300.8,323.6 398.8,323.6 397.2,348.4"/>
        <polygon fill="#5FA4E0" points="297.6,272.4 402,272.4 400,299.2 299.6,299.2"/>
        <polygon fill="#5FA4E0" points="296.4,248 292,180.4 249.6,180.4 350,80 450,180.4 407.6,180.4 403.2,248"/>
        <polygon fill="#87CEFA" points="205.6,159.6 207.2,184.4 109.2,184.4 110.8,159.6"/>
        <polygon fill="#87CEFA" points="210.4,235.6 106,235.6 108,208.8 208.4,208.8"/>
        <polygon fill="#87CEFA" points="211.6,260 216,327.6 258.4,327.6 158,428 58,327.6 100.4,327.6 104.8,260"/>
      </g>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_SORT, 'Sorting options...', TAlignLayout.MostRight);
end;

{ TSpeedDelete }

constructor TSpeedDelete.Create(AOwner: TComponent);
const
    ICON_DELETE: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <rect x="9.5" y="4.5" width="5" height="2" rx="0.7" fill="#87CEFA"/>
      <rect x="6.5" y="6.2" width="11" height="1.8" rx="0.6" fill="#87CEFA"/>
      <rect x="7" y="8.8" width="10" height="11" rx="0.8" fill="#5FA4E0"/>
      <rect x="9.2"  y="10.2" width="1.2" height="8" rx="0.6" fill="#87CEFA"/>
      <rect x="11.4" y="10.2" width="1.2" height="8" rx="0.6" fill="#87CEFA"/>
      <rect x="13.6" y="10.2" width="1.2" height="8" rx="0.6" fill="#87CEFA"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_DELETE, 'Delete select item...', TAlignLayout.Right);
end;

{ TSpeedCamera }

constructor TSpeedCamera.Create(AOwner: TComponent);
const
  ICON_CAMERA: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <rect x="4" y="8" width="16" height="9" rx="1.5" fill="#5FA4E0"/>
      <rect x="8.5" y="5" width="5" height="4" rx="1" fill="#5FA4E0"/>
      <rect x="9" y="5.5" width="3" height="2.5" rx="0.8" fill="#87CEFA"/>
      <circle cx="12" cy="12.5" r="3.5" fill="#324A5E"/>
      <circle cx="12" cy="12.5" r="2.7" fill="#5FA4E0"/>
      <circle cx="12" cy="12.5" r="1.6" fill="#324A5E"/>
      <circle cx="11.1" cy="11.6" r="0.6" fill="#87CEFA" opacity="0.8"/>
      <circle cx="17.5" cy="9.8" r="0.9" fill="#87CEFA"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_CAMERA, 'Take a photograph...', TAlignLayout.MostLeft);
end;

{ TSpeedPicture }

constructor TSpeedPicture.Create(AOwner: TComponent);
const
  ICON_PICTURE: string =
  '''
    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
      <circle cx="12" cy="12" r="10" fill="{{CIRCLE_COLOR}}"/>
      <rect x="5"   y="5.5" width="15" height="12" rx="1.5" fill="#3d6080"/>
      <rect x="5.4" y="6.2" width="15" height="12" rx="1.5" fill="#4a7299"/>
      <rect x="4" y="7" width="16" height="11" rx="1.5" fill="#5FA4E0"/>
      <rect x="4" y="7"  width="16" height="6" rx="1.5" fill="#87CEFA"/>
      <rect x="4" y="11" width="16" height="2"           fill="#87CEFA"/>
      <polygon points="5.5,18  9,12  12.5,18"  fill="#5FA4E0"/>
      <polygon points="10,18  14,8.5  18,18"   fill="#4a7299"/>
      <circle cx="17" cy="9.5" r="1.5" fill="#4a7299"/>
      <rect x="4" y="14.5" width="16" height="3.5" rx="1.5" fill="#5FA4E0"/>
    </svg>
  ''';
begin
  inherited;
  InitButton(ICON_PICTURE, 'Load a picture from device library...', TAlignLayout.Left);
end;

end.
