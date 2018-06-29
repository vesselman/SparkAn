unit LabelExt;
//by Adrian D. Bonev

interface

uses

  Windows, Classes, Messages, Controls, Graphics, StdCtrls;


type

  TLabelExt = class(TCustomLabel)
  private
    { Private declarations }


    FColorSelected    : TColor;
    FColorNotSelected : TColor;
    FColorHot         : TColor;
    FFrameColor       : TColor;
    FFrame            : Boolean;
    FSelected         : Boolean;
    FAllowDeSelect    : Boolean; //allows Labelext to be desected by click on it
    FOnMouseEnter     : TNotifyEvent;
    FOnMouseLeave     : TNotifyEvent;
    FOnSelect         : TNotifyEvent;
    FOnChangeState    : TNotifyEvent;
    FOnPaint          : TNotifyEvent; //this Exposes OnPiant not exposed in TLabel;


    procedure SetAllowDeSelect(Value : Boolean);
    procedure SetColorSelected(Value: TColor);
    procedure SetColorNotSelected(Value: TColor);
    procedure SetColorHot(Value: TColor);
    procedure SetFrameColor(Value: TColor);
    procedure SetFrame(Value : Boolean);
    procedure SetSelected(value : Boolean);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    {MouseEnter and leave were redifined because They were not exposed in the TLabel }

  protected
    { Protected declarations }
    procedure MouseEnter;
    procedure MouseLeave;
    procedure Select;
    procedure ChangeState;
    procedure Paint;override;
  public
    { Public declarations }
    procedure Click;override;
   // procedure MouseEnter;override;
   // procedure MouseLeave;override;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    { Published declarations }
    //published in TLabel = class(TCustomLabel)
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EllipsisPosition;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    // Reintroduced or overriden by Adrian
    property AllowDeSelect    : Boolean      read FAllowDeSelect    write SetAllowDeSelect default True;
    property ColorHot         : TColor       read FColorHot         write SetColorHot default $00FFFFC6;
    property ColorSelected    : TColor       read FColorSelected    write SetColorSelected default $00C4FFFF;
    property ColorNotSelected : TColor       read FColorNotSelected write SetColorNotSelected default $00FFE4CA;
    property FrameColor       : TColor       read FFrameColor       write SetFrameColor default clBlack;
    property Frame            : Boolean      read FFrame            write SetFrame default True;
    property Selected         : Boolean      read FSelected         write SetSelected default False;
    property OnMouseEnter     : TNotifyEvent read FOnMouseEnter     write FOnMouseEnter;
    property OnMouseLeave     : TNotifyEvent read FOnMouseLeave     write FOnMouseLeave;
    property OnSelect         : TNotifyEvent read FOnSelect         write FOnSelect;
    property OnChangeState    : TNotifyEvent read FOnChangeState    write FOnChangeState;
    property OnPaint          : TNotifyEvent read FOnPaint          write FOnPaint; //exposes Onpaint not exposed in TLabel
    property Transparent default False; //no need to redeclare it - just to have Transparent appear as default


  end;

 
 procedure Register;

implementation

///////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Standard',[TLabelExt]);
end;

constructor TLabelExt.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     FColorNotSelected := $00FFE4CA;
     FColorSelected    := $00C4FFFF;
     FColorHot         := $00FFFFC6;
     Color             := FColorNotSelected;
     FFrame            := True;
     AllowDeSelect     := True;
     AutoSize          := False;
     Alignment         := taCenter;
     Layout            := tlCenter;
     Transparent       := False; // to able to see the colors
end;

destructor TLabelExt.Destroy;
begin 
     inherited Destroy;
end;
///////////////////////////////////////////////////////////////////////////////

procedure TLabelExt.SetAllowDeSelect(Value : Boolean);
begin

  if (FAllowDeSelect <> Value) then FAllowDeSelect := Value;

End;

procedure TLabelExt.SetFrame(Value : Boolean);
begin

  if (FFrame <> Value) then begin
    FFrame := Value;
    Paint;
  end;

End;
//---------------  Color Set Group ------------------------//

procedure TLabelExt.SetFrameColor(Value: TColor);
begin
      if (FFrameColor <> Value) then begin
        FFrameColor := Value;
        Canvas.Pen.Color := FFrameColor;
        Paint;
      end;
end;

procedure TLabelExt.SetColorSelected(Value: TColor);
begin
      if(FColorSelected <> Value) then FColorSelected := Value;
end;
                                                
procedure TLabelExt.SetColorHot(Value: TColor);
begin

    if (FColorHot <> Value) then FColorHot := Value;

end;

procedure TLabelExt.SetColorNotSelected(Value: TColor);
begin

  if (FColorNotSelected <> value) then begin
        FColorNotSelected := value;
        if (csDesigning in ComponentState) then Color := FColorNotSelected;
  end;
end;
////////////////////////  Event Handling Procedures ///////////////////////////////////

procedure TLabelExt.CMMouseEnter(var Message: TMessage);
begin

  if Not(FSelected) then
  if (Color <> FColorHot) and (enabled) then Color := FColorHot;
  if Assigned(FOnMouseEnter) then MouseEnter;
  
end;

procedure TLabelExt.MouseEnter;
begin
     FOnMouseEnter(Self);
end;


procedure TLabelExt.CMMouseLeave(var Message: TMessage);
begin
   if Not(FSelected) then
   if (Color <> FColorNotSelected) and (enabled) then Color := FColorNotSelected;
   if Assigned(FOnMouseLeave) then MouseLeave;
end;

procedure TLabelExt.MouseLeave;
begin
   FOnMouseLeave(Self);
end;


procedure TLabelExt.Click;
begin

  if Not(FSelected) then begin
    SetSelected(True);
    if Assigned(FOnSelect) then Select;
  end
  else if (FSelected) then if (FAllowDeSelect) then SetSelected(False);

  inherited Click;

end;

procedure TLabelExt.Select;
begin
   FOnSelect(self);
end;

procedure TLabelExt.ChangeState;
begin
   FOnChangeState(self);
end;
 //////////////////////////////////////////////////////////////////////////////
procedure TLabelExt.SetSelected(value : Boolean);
begin

   if (FSelected <> Value) then begin
      FSelected := Value;
      if (FSelected) then Color := FColorSelected else
                          Color := FColorNotSelected;
      if Assigned(FOnChangeState) then ChangeState;

   end;

end;
///////////////////////////////////////////////////////////////////////////////

procedure TLabelExt.Paint;

begin
  inherited Paint;
  if (FFrame) then with Canvas do Rectangle(ClientRect);
  if assigned(FOnPaint) then FOnPaint(Self); {call Paint Event}
end;

///////////////////////////////////////////////////////////////////////////////


end.
