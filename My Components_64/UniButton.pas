 {by Adrian D. Bonev
   Messages Appear in Order:
  1 Mouse Enter
  2 MouseDown
  3 Select
  4 ChangeState
  5 MouseUp
  6 Click
  7 Mouse leave
}

{UniButton can be button or flat (like TLabel) with different colors.
 UniButton uses 3 TBitmaps to store each face of the button:
 Not Selected, Selected and Hot which are drawn by Paint procedure.
 I can place 3 different Images or/and captions for each state.
 Each Image can be separately scaled up (5 fold and down (10 fold).
 The Image  and Caption positions are controlled similarly to TSpeedButton.
 Bevels can be drawn in System colors (like for all buttons) or in internal colors
 where they are calculated from each face color using HSF color space.
 }
unit UniButton; //Univbersal Button

{$S-,W-,R-,H+,X+}

interface

uses

  Windows, Messages, Classes, Controls, Forms, Graphics, ActnList,Math,StdCtrls,
  Dialogs; //the last one is not needed

type

  {define the Types used in this VCL}
  TLabelKind  = (ButtonSingleBevel,CheckSingleBevel,ButtonDoubleBevel,CheckDoubleBevel,FlatFrame,FlatNoFrame);

  TBevelColors = (InternalColors,SystemColors);

  TButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);

  //----------------------------------------------------------------------//


  TUniButton = class(TGraphicControl)

  private
    { Private declarations }

    FacesDone         : Boolean;

    FAllowDeSelect    : Boolean; //allows UniButton to be desected by click on it
    FAllowUp          : Boolean; //allows Button Check to go Up
    FBevelColors      : TBevelColors;
    FColorSel         : TColor;
    FColorNotSel      : TColor;
    FColorHot         : TColor;
    FFrameColor       : TColor;
    FGroupIndex       : Integer;
    FColorHotEnabled  : Boolean;

    {Faces of the Buttom. Depressed (Dn) and Not (Up) }
    FFcNotSelUp       : TBitmap; //Not Selected Up
    FFcNotSelDn       : TBitmap; //Not Selected Down
    FFcSelUp          : TBitmap; //Selected Up
    FFcSelDn          : TBitmap; //Selected Down
    FFcHot            : TBitmap; //Hot. There is no Hot Down combination
    FFcDisabled       : TBitmap; //Disabled = Not Selected Up with Gray Text

    FHot              : Boolean;
    FDown             : Boolean;
    WasDown           : Boolean;
    LBdown            : Boolean;

    //Images Displayed on the button
    FImageNotSel      : TBitmap;
    FImageHot         : TBitmap;
    FImageSel         : TBitmap;

    FImNotSelScale    : Double; //Scale Factor; Default 0 = no Change, If negative Shrink, Positive Enlarge.
    FImHotScale       : Double; //Scale Factor; Default 0 = no Change, If negative Shrink, Positive Enlarge.
    FImSelScale       : Double; //Scale Factor; Default 0 = no Change, If negative Shrink, Positive Enlarge.

    FImNotSelTransparent : Boolean;
    FImHotTransparent    : Boolean;
    FImSelTransparent    : Boolean;

    //Captions for Hot and Selected//
    //For Not Selected is the Inherited : Caption & Text
    FCaptionHot        : TCaption;
    FCaptionSel        : TCaption;
    //Caption for Disabled = Caption//
    //---------------------------//
    FKind             : TLabelKind;

    FLayout           : TButtonLayout;
    FMargin           : Integer; //Fmargin (space) between the image (dominant) or text to border, if =-1 it is Always Centered
    FSpacing          : Integer; //FSpacing = Spacing between Image and Caption

    FSelected         : Boolean;
    FOnSelect         : TNotifyEvent;
    FOnChangeState    : TNotifyEvent;
    FOnPaint          : TNotifyEvent; //this Exposes OnPaint not exposed in TGraphicControl;

    { B E V E L   C O L O R S }
    //if TUniButton is a Button these are the Colors to Make the Bevel in Non Selected and Hot State
    //NonSelected Color
    //Names Originate from Delphi TColor System Names + "F" added to Front
    FclBtnHighlight   : TColor; //External 3D Button HighLight
    Fcl3DDkShadow     : TColor; //External 3D Button Shadow
    Fcl3DLight        : TColor; //Internal 3D Light
    FclBtnShadow      : TColor; //Internal 3D Button Shadow
    //if TUniButton is a Button these are the Colors to Make the Bevel in Selected (Down) State
    //Hot Color
    //Names Originate from Delphi TColor System Names + "FHot" added to Front
    FHotclBtnHighlight   : TColor; //External 3D Button HighLight
    FHotcl3DDkShadow     : TColor; //External 3D Button Shadow
    FHotcl3DLight        : TColor; //Internal 3D Light
    FHotclBtnShadow      : TColor; //Internal 3D Button Shadow
    //if TUniButton is a Button these are the Colors to Make the Bevel in Selected (Down) State
    //Selected (Down) Color
    //Names Originate from Delphi TColor System Names + "FSel" added to Front
    FSelclBtnHighlight   : TColor; //External 3D Button HighLight
    FSelcl3DDkShadow     : TColor; //External 3D Button Shadow
    FSelcl3DLight        : TColor; //Internal 3D Light
    FSelclBtnShadow      : TColor; //Internal 3D Button Shadow

    procedure DrawBevel(Const Color1,Color2,Color3,Color4 : TColor; const FaceCanvas : TCanvas);
    procedure GetBevelColors(Value : TBevelColors);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure HSLtoRGB(Const H,S,L : Double; Var R,G,B : Byte);
    procedure RGBtoHSL(Const R,G,B : Byte; var H,S,L : Double);
    procedure PrintCaption(const CaptionText : TCaption;const FcCanvas : TCanvas;
                                      const ImageBMP : TBitmap; const ImageScale : Double;
                                      const ImageTransparent : Boolean);
    procedure SetAllowDeSelect(Value : Boolean);
    procedure SetAllowUp(Value : Boolean);
    procedure SetBevelColors;
    procedure SetCaptionHot(Value : TCaption);
    procedure SetCaptionSel(Value : TCaption);
    procedure SetColorSel(Value: TColor);
    procedure SetColorNotSel(Value: TColor);
    procedure SetColorHot(Value: TColor);
    procedure SetColorHotEnabled(Value: Boolean);
    procedure SetFrameColor(Value: TColor);
    procedure SetGroupIndex(Value: Integer);
    procedure SetImNotSelScale(Value : Double);
    procedure SetImSelScale(Value : Double);
    procedure SetImHotScale(Value : Double);
    procedure SetImNotSelTransparent(Value: Boolean);
    procedure SetImSelTransparent(Value: Boolean);
    procedure SetImHotTransparent(Value: Boolean);
    procedure SetKind(Value : TLabelKind);
    procedure SetLayout(Value : TButtonLayout);
    procedure SetMargin(Value : Integer);
    procedure SetSpacing(Value : Integer);
    procedure SetSelected(Value : Boolean);
    procedure SetFaces;
    procedure UpdateExclusive;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    {MouseEnter and leave were redifined because They were not exposed in the TGraphicControl }
    
  protected
    { Protected declarations }
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Select;
    procedure ChangeState;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
  public
    { Public declarations }
    procedure SetImageNotSel(Value: TBitmap); //made public 10/31/2016  to be able to load BMP programatically
    procedure SetImageSel(Value: TBitmap);   //made public 10/31/2016 to be able to load BMP programatically
    procedure SetImageHot(Value: TBitmap);   //made public 10/31/2016 to be able to load BMP programatically
    procedure Click; override;
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);override;
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    //property OnResize;
  published
    { Published declarations }
    //published in TLabel = class(TCustomLabel)
    property Align;

    property Anchors;
    property BiDiMode;
    property Caption;
    //property Color nodefault;  I don't publish Color
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
   // property OnDblClick; I don't publish - It does not work if published
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
    property OnMouseEnter;
    property OnMouseLeave;
    // Reintroduced or overriden by Adrian
    property AllowDeSelect    : Boolean       read FAllowDeSelect    write SetAllowDeSelect default True;
    property AllowUp          : Boolean       read FAllowUp          write SetAllowUp default True;
    property BevelColors      : TBevelColors  read FBevelColors      write GetBevelColors default InternalColors;
    property ImageNotSel      : TBitmap       read FImageNotSel      write SetImageNotSel;
    property ImageSel         : TBitmap       read FImageSel         write SetImageSel;
    property ImageHot         : TBitmap       read FImageHot         write SetImageHot;
    property ImNotSelScale    : Double        read FImNotSelScale    write SetImNotSelScale;
    property ImSelScale       : Double        read FImSelScale       write SetImSelScale;
    property ImHotScale       : Double        read FImHotScale       write SetImHotScale;
    property ImNotSelTransparent : Boolean    read FImNotSelTransparent write SetImNotSelTransparent default True;
    property ImSelTransparent    : Boolean    read FImSelTransparent    write SetImSelTransparent    default True;
    property ImHotTransparent    : Boolean    read FImHotTransparent    write SetImHotTransparent    default True;
    property CaptionHot       : TCaption      read FCaptionHot       write SetCaptionHot;
    property CaptionSel       : TCaption      read FCaptionSel       write SetCaptionSel;
    property ColorHot         : TColor        read FColorHot         write SetColorHot default $00FFFFC6;
    property ColorSel         : TColor        read FColorSel         write SetColorSel default $00C4FFFF;
    property ColorNotSel      : TColor        read FColorNotSel      write SetColorNotSel default $00FFE4CA;
    property FrameColor       : TColor        read FFrameColor       write SetFrameColor default clBlack;
    property ColorHotEnabled  : Boolean       read FColorHotEnabled  write SetColorHotEnabled default True;
    property GroupIndex       : Integer       read FGroupIndex       write SetGroupIndex default 0;
    property Kind             : TLabelKind    read FKind             write SetKind default ButtonSingleBevel;
    property Layout           : TButtonLayout read FLayout           write SetLayout default blGlyphLeft;
    property Margin           : Integer       read FMargin           write SetMargin default -1;
    property Spacing          : Integer       read FSpacing          write SetSpacing default 4;
    property Selected         : Boolean       read FSelected         write SetSelected default False;
    property OnSelect         : TNotifyEvent  read FOnSelect         write FOnSelect;
    property OnChangeState    : TNotifyEvent  read FOnChangeState    write FOnChangeState;
    property OnPaint          : TNotifyEvent  read FOnPaint          write FOnPaint; //exposes OnPaint not exposed in TGraphicControl

  end;


 procedure Register;

implementation

///////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Standard',[TUNIBUTTON]);
end;

constructor TUniButton.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);

  ControlStyle := [csCaptureMouse, csDoubleClicks]; //as defined in TSpeedButton

  FacesDone          := False;
  WasDown            := False;
  LBdown             := False;
  Canvas.Brush.Style := bsClear;
  FColorHotEnabled   := True;

  FFcNotSelUp       := TBitmap.Create;
  FFcNotSelDn       := TBitmap.Create;
  FFcSelUp          := TBitmap.Create;
  FFcSelDn          := TBitmap.Create;
  FFcHot            := TBitmap.Create;
  FFcDisabled       := TBitmap.Create;

  FImageNotSel      := TBitmap.Create;
  FImageHot         := TBitmap.Create;
  FImageSel         := TBitmap.Create;

  FImNotSelScale    := 1; //Scale Factor; Default 1 = no Change
  FImHotScale       := 1; //Scale Factor; Default 1 = no Change
  FImSelScale       := 1; //Scale Factor; Default 1 = no Change

  FImNotSelTransparent := True;
  FImHotTransparent    := True;
  FImSelTransparent    := True;

  FBevelColors      := InternalColors;
  FColorNotSel      := $00FFE4CA;
  FColorSel         := $00C4FFFF;
  FColorHot         := $00FFFFC6;
  FDown             := False;
  FHot              := False;

  AllowDeSelect     := True;
  AllowUp           := True;
  AutoSize          := False;

  Canvas.Font       := Self.Font;

  FLayout           := blGlyphLeft;
  FMargin           := -1;
  FSpacing          :=  4;     

end;

destructor TUniButton.Destroy;
begin

 FFcNotSelUp.Free;
 FFcNotSelDn.Free;
 FFcSelUp.Free;
 FFcSelDn.Free;
 FFcHot.Free;
 FFcDisabled.Free;

 FImageNotSel.Free;
 FImageHot.Free;
 FImageSel.Free;


 inherited Destroy;
end;

//////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
procedure TUniButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;


procedure TUniButton.SetAllowUp(Value : Boolean);
begin
  if (FAllowUp <> Value) then begin
    FAllowUp := Value;
    if not(FAllowUp) then FAllowDeSelect := False;
    UpdateExclusive;
  end;
End;

procedure TUniButton.SetAllowDeSelect(Value : Boolean);
begin
  if (FAllowDeSelect <> Value) then FAllowDeSelect := Value;
End;

procedure TUniButton.UpdateExclusive;
{Copied exactly from TSpeedButton
sends Message to other buttons
Side effects - acts on TSpeedButton}
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;

end;

procedure TUniButton.CMButtonPressed(var Message: TMessage);
{sligthly modified from TSpeedButton}
var
  Sender: TUniButton;
begin
  if (Message.WParam = FGroupIndex) then
  begin
    {gets message from other button from MouseUp
    which gives UpdateExclusive if GroupIndex <> 0
    }
    Sender := TUniButton(Message.LParam);
    if (Sender <> Self) and (Sender is TUniButton) then begin
      if (Sender.Selected) and (FSelected) then
      begin
        FSelected := False;
        if (FDown) then FDown := False;
        Paint;
      end;
    end;
  end;
end;

{--------------------------------------------------------------}
procedure TUniButton.CMFontChanged(var Message: TMessage);
begin
  Canvas.Font := Self.Font;
  SetFaces;
  Paint;
end;

procedure TUniButton.SetKind(Value : TLabelKind);
begin
    
  if (FKind <> Value) then begin
    FKind := Value;
    SetFaces;
    Paint;
  end;

End;

//----------------- Setting Images (if Any ) on Button Label ------------------//
procedure TUniButton.SetImageNotSel(Value: TBitmap);
begin
  ImageNotSel.Assign(Value);
  SetFaces;
  Paint;
end;

procedure TUniButton.SetImageSel(Value: TBitmap);
begin
  FImageSel.Assign(Value);
  SetFaces;
  if (Selected) then Paint;
end;

procedure TUniButton.SetImageHot(Value: TBitmap);
begin
  FImageHot.Assign(Value);
  SetFaces;
end;

procedure TUniButton.SetImNotSelScale(Value : Double);
begin
  if (FImNotSelScale <> Value) and (Value >= 0.1) and (Value <= 5.0) then begin
    FImNotSelScale := Value;
    SetFaces;
    Paint;
  end;    
end;

procedure TUniButton.SetImSelScale(Value : Double);
begin
  if (FImSelScale <> Value) and (Value >= 0.1) and (Value <= 5.0) then begin
    FImSelScale := Value;
    SetFaces;
    if (Selected) then Paint;
  end;
end;

procedure TUniButton.SetImHotScale(Value : Double);
begin
  if (FImHotScale <> Value) and (Value >= 0.1) and (Value <= 5.0) then begin
    FImHotScale := Value;
    SetFaces;
  end;
end;  

procedure TUniButton.SetImNotSelTransparent(Value: Boolean);
begin
  if (FImNotSelTransparent <> Value) then begin
    FImNotSelTransparent := Value;
    SetFaces;
    Paint;
  end;
end;

procedure TUniButton.SetImSelTransparent(Value: Boolean);
begin
  if (FImSelTransparent <> Value) then begin
    FImSelTransparent := Value;
    SetFaces;
    if (Selected) then Paint;
  end;
end;

procedure TUniButton.SetImHotTransparent(Value: Boolean);
begin
  if (FImHotTransparent <> Value) then begin
    FImHotTransparent := Value;
    SetFaces;
  end;
end;


//------------- End of Setting Images (if Any ) on Button Label ---------//
//---------------  Color Setting Group ------------------------//

procedure TUniButton.SetFrameColor(Value: TColor);
begin
 if (FFrameColor <> Value)then begin
  FFrameColor := Value;
  if (FKind in [FlatFrame]) then begin
    SetFaces;
    Paint;
  end;
 end;
end;

procedure TUniButton.SetColorNotSel(Value: TColor);
begin  
  if (FColorNotSel <> Value) then begin
    FColorNotSel := Value;
    if not(FKind in[FlatFrame,FlatNoFrame]) then SetBevelColors;
    SetFaces;
    Paint;
  end;
end;

procedure TUniButton.SetColorSel(Value: TColor);
begin
  if(FColorSel <> Value) and (FColorSel <> FColorNotSel) then begin
    FColorSel := Value;
    if not(FKind in[FlatFrame,FlatNoFrame]) then SetBevelColors;
    SetFaces;
    if (Selected) then Paint;
  end;
end;

procedure TUniButton.SetColorHot(Value: TColor);
begin
   if (FColorHot <> Value) then begin
    FColorHot := Value;
    if not(FKind in[FlatFrame,FlatNoFrame]) then SetBevelColors;
    SetFaces;
  end;
end;

procedure TUniButton.SetColorHotEnabled(Value: Boolean);
begin
   if (FColorHotEnabled <> Value) then FColorHotEnabled := Value;
end;

procedure TUniButton.CMTextChanged(var Message: TMessage);
{this deals with Caption of the Not Selected State of the UniButton
 "Caption" and "Text" are defined in TControl} 
begin
  SetFaces;
  Paint;
end;

procedure TUniButton.SetCaptionSel(Value : TCaption);
begin
  if (FCaptionSel <> Value) then begin
    FCaptionSel := Value;
    SetFaces;
    if (Selected) then Paint;
  end;
end;

procedure TUniButton.SetCaptionHot(Value : TCaption);
begin  
  if (FCaptionHot <> Value) then begin
    FCaptionHot := Value;
    SetFaces;
  end;
end;

procedure TUniButton.SetLayout(Value : TButtonLayout);
begin
  if (FLayout <> Value) then begin
    FLayout := Value;
    SetFaces;
    Paint;
  end;
end;

procedure TUniButton.SetMargin(Value : Integer);
begin
  if (FMargin <> Value) and (Value >= -1) then begin
    FMargin := Value;
    SetFaces;
    Paint;
  end;
end;

procedure TUniButton.SetSpacing(Value : Integer);
begin
  if (FSpacing <> Value) then begin
    FSpacing := Value;
    SetFaces;
    Paint;
  end;
end;

procedure TUniButton.SetFaces;
var Rect : TRect;
begin

  Canvas.Font.Assign(Self.Font);

  Rect := ClientRect;
  //set sizes
  FFcNotSelUp.SetSize(Rect.Right,Rect.Bottom);
  FFcNotSelDn.SetSize(Rect.Right,Rect.Bottom);
  FFcSelUp.SetSize(Rect.Right,Rect.Bottom);
  FFcSelDn.SetSize(Rect.Right,Rect.Bottom);
  FFcHot.SetSize(Rect.Right,Rect.Bottom);
  FFcDisabled.SetSize(Rect.Right,Rect.Bottom);

   //fill with color 
  FFcNotSelUp.Canvas.Brush.Color := FColorNotSel;
  FFcNotSelUp.Canvas.FillRect(ClientRect);
  FFcNotSelDn.Canvas.Brush.Color := FColorNotSel;
  FFcNotSelDn.Canvas.FillRect(ClientRect);

  FFcSelUp.Canvas.Brush.Color := FColorSel;
  FFcSelUp.Canvas.FillRect(ClientRect);
  FFcSelDn.Canvas.Brush.Color := FColorSel;
  FFcSelDn.Canvas.FillRect(ClientRect);

  FFcHot.Canvas.Brush.Color := FColorHot;
  FFcHot.Canvas.FillRect(ClientRect);
  
  FFcDisabled.Canvas.Brush.Color := FColorNotSel;
  FFcDisabled.Canvas.FillRect(ClientRect);

  FFcNotSelUp.Canvas.Font.Assign(Canvas.Font);
  FFcNotSelDn.Canvas.Font.Assign(Canvas.Font);
  FFcSelUp.Canvas.Font.Assign(Canvas.Font);
  FFcSelDn.Canvas.Font.Assign(Canvas.Font);
  FFcHot.Canvas.Font.Assign(Canvas.Font);
  FFcDisabled.Canvas.Font.Assign(Canvas.Font);
  FFcDisabled.Canvas.Font.Color := clMedGray;


  if (FKind in [FlatFrame]) then begin
    // if Label Kind only Up faces are used
    with FFcNotSelUp.Canvas do begin
      Pen.Color := FFrameColor;
      Rectangle(ClientRect);
    end;
    with FFcSelUp.Canvas do begin
      Pen.Color := FFrameColor;
      Rectangle(ClientRect);
    end;
    with FFcHot.Canvas do begin
      Pen.Color := FFrameColor;
      Rectangle(ClientRect);
    end;
    with FFcDisabled.Canvas do begin
      Pen.Color := FFrameColor;
      Rectangle(ClientRect);
    end;
  end else

  if (FKind in [ButtonSingleBevel,CheckSingleBevel,ButtonDoubleBevel,CheckDoubleBevel]) then begin

  //Buttons Up
  DrawBevel(FclBtnHighlight,Fcl3DDkShadow,Fcl3DLight,FclBtnShadow,FFcNotSelUp.Canvas);
  DrawBevel(FSelclBtnHighlight,FSelcl3DDkShadow,FSelcl3DLight,FSelclBtnShadow,FFcSelUp.Canvas);
  DrawBevel(FHotclBtnHighlight,FHotcl3DDkShadow,FHotcl3DLight,FHotclBtnShadow,FFcHot.Canvas);
  DrawBevel(FclBtnHighlight,Fcl3DDkShadow,Fcl3DLight,FclBtnShadow,FFcDisabled.Canvas);

  //Buttons Down
  DrawBevel(Fcl3DDkShadow,FclBtnHighlight,FclBtnShadow,Fcl3DLight,FFcNotSelDn.Canvas);
  DrawBevel(FSelcl3DDkShadow,FSelclBtnHighlight,FSelclBtnShadow,FSelcl3DLight,FFcSelDn.Canvas);

  end;     

  {Captions and Images on Each face}
  PrintCaption(Caption,FFcNotSelUp.Canvas,FImageNotSel,FImNotSelScale,FImNotSelTransparent);
  PrintCaption(CaptionSel,FFcSelUp.Canvas,FImageSel,FImSelScale,FImSelTransparent);
  PrintCaption(CaptionHot,FFcHot.Canvas,FImageHot,FImHotScale,FImHotTransparent);
  PrintCaption(Caption,FFcDisabled.Canvas,FImageNotSel,FImNotSelScale,FImNotSelTransparent);

  if (FKind in [ButtonSingleBevel,CheckSingleBevel,ButtonDoubleBevel,CheckDoubleBevel]) then begin
  PrintCaption(Text,FFcNotSelDn.Canvas,FImageNotSel,FImNotSelScale,FImNotSelTransparent);
  PrintCaption(CaptionSel,FFcSelDn.Canvas,FImageSel,FImSelScale,FImSelTransparent);
  end;    

  {to be able to update the size when resizing allows setting
  FacesDone := True only in RunTime}

  if not(csDesigning in ComponentState) and
     not(csLoading   in ComponentState) then FacesDone := True;

end;


procedure TUniButton.PrintCaption(const CaptionText : TCaption;const FcCanvas : TCanvas;
                                  const ImageBMP : TBitmap; const ImageScale : Double;
                                  const ImageTransparent : Boolean);
var R        : TRect;
    TextFlags: Cardinal;
    M,X,Y,dw : Integer;
    FcCanHDC : HDC;
    TempBMP  : TBitmap;{Transfer to TempBMP - easiest way to do Changing Size (Scale)}
    Xsc,Ysc  : Integer;
    //property Text is introduced in TControl.
    //Text takes the value of Caption
begin

  R := ClientRect; //ClientRect is Property of TUniButton
  M := FMargin;
  FcCanvas.Brush.Style := bsClear; //do this before getting HDC
  FcCanHDC := FcCanvas.Handle; //Canvas of the Face of the Button

  //set Offset when pressed down so to look realistically)
  if not(FKind in [FlatFrame,FlatNoFrame]) and
    ((FcCanvas = FFcNotSelDn.Canvas) or (FcCanvas = FFcSelDn.Canvas))
    then Dw := 1 else Dw := 0;

  {Calculate Margin and Print Image on Faces}
  If not(ImageBMP.Empty) then Begin
   {Transfer to TempBMP - easiest way to do Changing Size (Scale)}
    TempBMP := TBitmap.Create;
    If (ImageScale = 1) then TempBMP.Assign(ImageBMP) Else
    Begin
      Xsc := Round(ImageBMP.Width*ImageScale);
      Ysc := Round(ImageBMP.Height*ImageScale);
      TempBMP.SetSize(Xsc,Ysc);
      TempBMP.Canvas.StretchDraw(TempBMP.Canvas.ClipRect,ImageBMP);
    End;

    If (FMargin <> -1) then Begin
      if (FLayout in [blGlyphLeft,blGlyphRight]) then begin
        if (FLayout = blGlyphLeft) then X := M else
        if (FLayout = blGlyphRight) then X := Self.Width - TempBMP.Width - M;
        Y := (Self.Height div 2) - (TempBMP.Height div 2);
        M := M + TempBMP.Width + Spacing;
      end else
      if (FLayout in [blGlyphTop,blGlyphBottom]) then begin
        if (FLayout = blGlyphTop) then Y := M else
        if (FLayout = blGlyphBottom) then Y := Self.Height - TempBMP.Height - M;
        X := (Self.Width div 2) - (TempBMP.Width div 2);
        M := M + TempBMP.Height + Spacing;
      end;
    End
      Else
    Begin
      {Image and Text will be centered}
      if (CaptionText <> '') then
      X := (Self.Width div 2) - ((TempBMP.Width + FSpacing + FcCanvas.TextWidth(CaptionText)) div 2)
      else
      X :=  (Self.Width div 2)  - (TempBMP.Width div 2);
      Y :=  (Self.Height div 2) - (TempBMP.Height div 2);
      M := ((Self.Width div 2)  - (FcCanvas.TextWidth(CaptionText) div 2)) - X;
    End;

    TempBMP.TransparentMode := tmAuto;
    TempBMP.Transparent := ImageTransparent;
     {tmAuto returns the color of 1st pixel in the bitmap - see the end of Code)
      to select a particular pixel do:
      FBitmap.TransparentMode := tmFixed;
      FBitmap.TransparentColor := FBitmap.Canvas.Pixels[X,Y];
     }

     FcCanvas.Draw(X+dw,Y+dw,TempBMP);

     //Bitmap should be at least 16 bit to get Transparent with (Stretch)Draw
     TempBMP.Free;
  End; //End If not(ImageBMP.Empty) then Begin

  {Set Text Rectangle and Text Flags}
 If (CaptionText <> '') then Begin
  If (FMargin <> -1) then Begin
    if (FLayout = blGlyphLeft) then begin
      Windows.OffsetRect(R,M+dw,dw);
      TextFlags := DT_LEFT  or      DT_VCENTER or DT_SINGLELINE; //Left
    end else
    if (FLayout = blGlyphRight) then begin
      Windows.OffsetRect(R,-(M+dw),-dw);
      TextFlags := DT_RIGHT or      DT_VCENTER or DT_SINGLELINE; //Right
    end else
    if (FLayout = blGlyphTop) then begin
      Windows.OffsetRect(R,dw,M+dw);
      TextFlags := DT_TOP or        DT_CENTER or  DT_SINGLELINE; //Top
    end else
    if (FLayout = blGlyphBottom) then begin
      Windows.OffsetRect(R,-dw,-(M+dw));
      TextFlags := DT_BOTTOM or     DT_CENTER or  DT_SINGLELINE; //Bottom
    end;
  End

    Else

  Begin
    {this is for centered Caption and Image 9if  any)}
    if not(ImageBMP.Empty) then Windows.OffsetRect(R,M+dw,dw) else
                                Windows.OffsetRect(R,dw,dw);
      TextFlags := DT_SINGLELINE or DT_VCENTER or DT_CENTER;
  End;
 End;

  {
        Win32 API commands
  TextFlags := DT_LEFT  or      DT_VCENTER or DT_SINGLELINE; //Left
  TextFlags := DT_RIGHT or      DT_VCENTER or DT_SINGLELINE; //Right
  TextFlags := DT_TOP or        DT_CENTER or  DT_SINGLELINE; //Top
  TextFlags := DT_BOTTOM or     DT_CENTER or  DT_SINGLELINE; //Bottom
  TextFlags := DT_SINGLELINE or DT_VCENTER or DT_CENTER;     //Center
  }

  Windows.DrawText(FcCanHDC, PChar(CaptionText), Length(CaptionText), R, TextFlags);

end;

procedure TUniButton.DrawBevel(Const Color1,Color2,Color3,Color4 : TColor; const FaceCanvas : TCanvas);
begin

  with FaceCanvas do begin
   with ClientRect do begin //ClientRect is Property of TUniButton
    //External Left & Upper
    Pen.Color := Color1;
    PolyLine([Point(0, Bottom-2), Point(0, 0),Point(Right-1, 0)]);
    //External Right & Bottom
    Pen.Color := Color2;
    PolyLine([Point(Right-1, 0), Point(Right-1, Bottom-1),Point(-1, Bottom-1)]);
    if (FKind > CheckSingleBevel) then begin
    //Internal Left & Upper
    Pen.Color := Color3;
    PolyLine([Point(1, Bottom-3), Point(1, 1),Point(Right-2, 1)]);
    //Internal Right & Bottom
    Pen.Color := Color4;
    PolyLine([Point(Right-2, 1), Point(Right-2, Bottom-2),Point(0, Bottom-2)]);
    end;
  end;
 end;
end;

procedure TUniButton.GetBevelColors(Value : TBevelColors);
{Interna or System Colors}
begin
  if (FBevelColors <> Value) then begin
    FBevelColors := Value;
    if not(FKind in[FlatFrame,FlatNoFrame]) then begin
      SetBevelColors;
      SetFaces;
      Paint;
    end;
  end;
end;   

procedure TUniButton.SetBevelColors;
 {Const are Luminescence value for clBtnHighlight,cl3DDkShadow,cl3DLight,
  clBtnShadow in Default Colors in Windows XP  using HSL color space
 }
Const LclBtnFace      = 0.886274509803922;
      LclBtnHighlight = 1.0;
      Lcl3DDkShadow   = 0.417647058823529;
      Lcl3DLight      = 0.915686274509804;
      LclBtnShadow    = 0.637254901960784;

var R,G,B : Byte;
    H,S,L,Lcurrent : Double;
    CntColors,ColKind : Integer;
    MyColor : LongInt;
    procedure SetTargetColor;
    begin
      if (ColKind = 1) then begin
        if (CntColors = 1) then FclBtnHighlight := MyColor else
        if (CntColors = 2) then Fcl3DDkShadow   := MyColor else
        if (CntColors = 3) then Fcl3DLight      := MyColor else
        if (CntColors = 4) then FclBtnShadow    := MyColor;
      end else
      if (ColKind = 2) then begin
        if (CntColors = 1) then FHotclBtnHighlight := MyColor else
        if (CntColors = 2) then FHotcl3DDkShadow   := MyColor else
        if (CntColors = 3) then FHotcl3DLight      := MyColor else
        if (CntColors = 4) then FHotclBtnShadow    := MyColor;
      end else
      if (ColKind = 3) then begin
        if (CntColors = 1) then FSelclBtnHighlight := MyColor else
        if (CntColors = 2) then FSelcl3DDkShadow   := MyColor else
        if (CntColors = 3) then FSelcl3DLight      := MyColor else
        if (CntColors = 4) then FSelclBtnShadow    := MyColor;
      end; 
    end;

    procedure SetLuminescence;
    begin
        if (CntColors = 1) then Lcurrent := L + (LclBtnHighlight - LclBtnFace) else
        if (CntColors = 2) then Lcurrent := L - (LclBtnFace - Lcl3DDkShadow) else
        if (CntColors = 3) then Lcurrent := L + (Lcl3DLight - LclBtnFace) else
        if (CntColors = 4) then Lcurrent := L - (LclBtnFace - LclBtnShadow);
        if (Lcurrent < 0) then Lcurrent := 0 else
        if (Lcurrent > 1) then Lcurrent := 1;
    end;

begin                   
   //Non Selected Color
   if (FColorNotSel = clBtnface) or (FBevelColors = SystemColors) then begin
    //Takes the Current Windows System Colors
    FclBtnHighlight    := clBtnHighlight; //External 3D Button HighLight
    Fcl3DDkShadow      := cl3DDkShadow; //External 3D Button Shadow
    Fcl3DLight         := cl3DLight; //Internal 3D Light
    FclBtnShadow       := clBtnShadow; //Internal 3D Button Shadow
   end else
   begin
    MyColor := ColorToRGB(FColorNotSel); //System Colors are negative!!!
    R := GetRValue(MyColor);
    G := GetGValue(MyColor);
    B := GetBValue(MyColor);
    RGBtoHSL(R,G,B,H,S,L); //Uses Positive values Only
    ColKind := 1;
    for CntColors := 1 to 4 do begin
      SetLuminescence;
      HSLtoRGB(H,S,Lcurrent,R,G,B);
      MyColor := RGB(R,G,B);
      SetTargetColor;
    end;
   end;


   if (FColorHot = clBtnface) or (FBevelColors = SystemColors) then begin
    //Takes the Current Windows System Colors
    FHotclBtnHighlight    := clBtnHighlight; //External 3D Button HighLight
    FHotcl3DDkShadow      := cl3DDkShadow; //External 3D Button Shadow
    FHotcl3DLight         := cl3DLight; //Internal 3D Light
    FHotclBtnShadow       := clBtnShadow; //Internal 3D Button Shadow
   end else
   begin
    MyColor := ColorToRGB(FColorHot); //System Colors are negative!!!
    R := GetRValue(MyColor);
    G := GetGValue(MyColor);
    B := GetBValue(MyColor);
    RGBtoHSL(R,G,B,H,S,L); //Uses Positive values Only
    ColKind := 2;
    for CntColors := 1 to 4 do begin
      SetLuminescence;
      HSLtoRGB(H,S,Lcurrent,R,G,B);
      MyColor := RGB(R,G,B);
      SetTargetColor;
    end;
   end;



   if (FColorSel = clBtnface) or (FBevelColors = SystemColors) then begin
    //Takes the Current Windows System Colors
    FSelclBtnHighlight    := clBtnHighlight; //External 3D Button HighLight
    FSelcl3DDkShadow      := cl3DDkShadow; //External 3D Button Shadow
    FSelcl3DLight         := cl3DLight; //Internal 3D Light
    FSelclBtnShadow       := clBtnShadow; //Internal 3D Button Shadow
   end else
   begin
    MyColor := ColorToRGB(FColorSel); //System Colors are negative!!!
    R := GetRValue(MyColor);
    G := GetGValue(MyColor);
    B := GetBValue(MyColor);
    RGBtoHSL(R,G,B,H,S,L); //Uses Positive values Only
    ColKind := 3;
    for CntColors := 1 to 4 do begin
      SetLuminescence;
      HSLtoRGB(H,S,Lcurrent,R,G,B);
      MyColor := RGB(R,G,B); 
      SetTargetColor;
    end;
   end;
  

end;

procedure TUniButton.RGBtoHSL(Const R,G,B : Byte; var H,S,L : Double);
 //HSL values  = 0 ÷ 1
 //RGB values  = 0 ÷ 255

var var_R,var_G,var_B : Double;
    var_Min,var_Max,del_Max : Double;
    del_R,del_G,del_B : Double;



    function GetMin(Const A,B,C : Double) : Double;
    begin
      Result := MaxDouble;
      if Result > A then Result := A;
      if Result > B then Result := B;
      if Result > C then Result := C;
    end;

    function GetMax(Const A,B,C : Double) : Double;
    begin
      Result := 0;
      if Result < A then Result := A;
      if Result < B then Result := B;
      if Result < C then Result := C;
    end;

Begin

  var_R := R / 255;                     //Where RGB values = 0 ÷ 255
  var_G := G / 255;
  var_B := B / 255;

  var_Min := GetMin( var_R, var_G, var_B );    //Min. value of RGB
  var_Max := GetMax( var_R, var_G, var_B );    //Max. value of RGB
  del_Max := var_Max - var_Min;             //Delta RGB value

  L := ( var_Max + var_Min ) / 2;

  if ( del_Max = 0 ) then begin                    //This is a gray, no chroma...
    H := 0;                                //HSL results = 0 ÷ 1
    S := 0;
  end else                                    //Chromatic data...
  begin
    if ( L < 0.5 ) then S := del_Max / ( var_Max + var_Min )
    else                S := del_Max / ( 2 - var_Max - var_Min );

    del_R := ( ( ( var_Max - var_R ) / 6 ) + ( del_Max / 2 ) ) / del_Max;
    del_G := ( ( ( var_Max - var_G ) / 6 ) + ( del_Max / 2 ) ) / del_Max;
    del_B := ( ( ( var_Max - var_B ) / 6 ) + ( del_Max / 2 ) ) / del_Max;

   if      ( var_R = var_Max ) then H := del_B - del_G
   else if ( var_G = var_Max ) then H := ( 1 / 3 ) + del_R - del_B
   else if ( var_B = var_Max ) then H := ( 2 / 3 ) + del_G - del_R;

   if ( H < 0 ) then H := H + 1;  // in C: H += 1
   if ( H > 1 ) then H := H - 1;  // in C: H -= 1
  end;

end; //Procedure RGBtoHSL;

Procedure TUniButton.HSLtoRGB(Const H,S,L : Double; Var R,G,B : Byte);
 var
     var_1,var_2 : Double;

     function HuetoRGB(v1, v2, vH : Double) : Double;
     begin
      if ( vH < 0 ) then vH := vH + 1;
      if ( vH > 1 ) then vH := vH - 1;

      if ( ( 6 * vH ) < 1 ) then Result := ( v1 + ( v2 - v1 ) * 6 * vH ) else
      if ( ( 2 * vH ) < 1 ) then Result := v2 else
      if ( ( 3 * vH ) < 2 ) then Result := ( v1 + ( v2 - v1 ) * ( ( 2 / 3 ) - vH ) * 6 )
      else Result := v1;
     end;

Begin


  if ( S = 0 ) then begin                       //HSL values = 0 ÷ 1
   R := round(L * 255);                      //RGB results = 0 ÷ 255
   G := round(L * 255);
   B := round(L * 255);
  end
  else begin
   if ( L < 0.5 ) then var_2 := L * ( 1 + S )
   else                var_2 := ( L + S ) - ( S * L );

   var_1 := 2 * L - var_2;

   R := round(255 * HuetoRGB( var_1, var_2, H + ( 1 / 3 ) ));
   G := round(255 * HuetoRGB( var_1, var_2, H ));
   B := round(255 * HuetoRGB( var_1, var_2, H - ( 1 / 3 ) ));

  end;

End; //Procedure HSLtoRGB


////////////////////////  Event Handling Procedures ///////////////////////////////////


procedure TUniButton.CMMouseEnter(var Message: TMessage);
begin
  if Not(FSelected) and (ColorHotEnabled) then begin
    FHot := True;
    Paint;
  end;
  inherited; //generates OnMouseEnter event
end;

procedure TUniButton.CMMouseLeave(var Message: TMessage);
begin
   if (FHot) then begin
    FHot := False;
    Paint;
   end;
   inherited; //generates OnMouseLeave event
end;   

procedure TUniButton.MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin

 If (button = mbLeft) Then Begin
  LBdown := True;
  if not(FDown) then begin
    FHot := False;
    if not(FKind in [FlatFrame,FlatNoFrame]) then begin
      FDown := True;
     Paint;
    end;
  end;
 End;

 inherited; //generates MouseDown event

End;

procedure TUniButton.MouseMove(Shift: TShiftState; X, Y: Integer);

begin
  inherited MouseMove(Shift, X, Y);
  {this releases the Button if Mouse goes Outside the Button When Button is depressed}
  if (csLButtonDown in Self.ControlState) then begin
    if (X < 0) or (X > ClientWidth) or (Y < 0) or (Y > ClientHeight)
    then Perform(WM_LBUTTONUP, 0, 0);
  end;
end;

procedure TUniButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin

    {this Code Paints the Face of the Button}
If (LBdown) Then begin

  if (FDown) then begin
    if (FKind in [ButtonSingleBevel,ButtonDoubleBevel]) { they are always be Allowed Up} then begin
      FDown := False;
    end else
    if (FKind in [CheckSingleBevel,CheckDoubleBevel]) and (FAllowUp) then begin
      if (WasDown)then begin
        FDown   := False;
        WasDown := False;
      end
      else
        WasDown := True;
    end;
  end;

  if Not(FSelected) then Selected := True
  else begin
    if (FAllowDeSelect) then
      Selected := False
    else
    begin
      if (FKind in [ButtonSingleBevel,ButtonDoubleBevel]) Or
         (not(FKind in [FlatFrame,FlatNoFrame]) and not(FSelected) and (FAllowUp))
      then Paint;
      //Paint here was called because SetSelected which usually Paint was not called
      //Paint is needed to Draw the Button in Up position
    end;
  end;  

  //sends message to other buttons from same GroupIndex (>0) to be released.//
  if (FGroupIndex <> 0) then UpdateExclusive;

  inherited MouseUp(Button, Shift, X, Y);

  {Triggers the Click}
  DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
  if DoClick then Click;

  LBdown := False;
End;

end;

procedure TUniButton.Click;
begin
  inherited Click;
end;


procedure TUniButton.Select;
begin
   FOnSelect(self);
end;

procedure TUniButton.ChangeState;
begin
   FOnChangeState(self);
end;


 //////////////////////////////////////////////////////////////////////////////
procedure TUniButton.SetSelected(value : Boolean);
begin

   if (FSelected <> Value) then begin
      FSelected := Value;
      if (FKind in [CheckSingleBevel,CheckDoubleBevel]) then FDown := FSelected;
      Paint;
      if (FSelected) then if Assigned(FOnSelect) then Select;
      if Assigned(FOnChangeState) then ChangeState;
   end;

end;
///////////////////////////////////////////////////////////////////////////////

procedure TUniButton.Paint;
begin

  {the only way to do Faces in Run Time if Only Default settings are used}
  if not(FacesDone) then begin
    if not(FKind in[FlatFrame,FlatNoFrame]) then SetBevelColors;
      SetFaces;
  end;

  if (Enabled) then begin
    if not(FDown) then begin
      if not(FSelected) and not(FHot) then Canvas.Draw(0, 0, FFcNotSelUp) else
      if not(FSelected) and    (FHot) then Canvas.Draw(0, 0, FFcHot) else
      if    (FSelected) then               Canvas.Draw(0, 0, FFcSelUp);
    end
      else
    begin
      if not(FSelected) then Canvas.Draw(0, 0, FFcNotSelDn) else
      if    (FSelected) then Canvas.Draw(0, 0, FFcSelDn);
    end;
  end //if (Enabled) then begin

    else

  begin  //Not Enabled)
    Canvas.Draw(0, 0, FFcDisabled)
  end; //Not Enabled) then begin

  if Assigned(FOnPaint) then FOnPaint(Self);


End;

end.
