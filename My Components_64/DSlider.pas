unit DSlider;
//by Adrian D. Bonev
 //uses TBitmap to first draw on it and then copy to DSlider Canvas to avoid flickering
 
interface

uses

     Windows, Classes, Controls, Graphics,  ThDTimer, Dialogs, SysUtils;


type TKind = (Horizontal, Vertical);


type

   TDSlider = class(TCustomControl) //Can have children & Canvas

  private
    { Private declarations }

    ThrTimer     : TThreadedTimer;
    TimeElapsed  : Cardinal;

    //Slider Variables
    Frame1st     : TRect; //Draws Frame around whole widget like bevel; 2 frames are needed
    Frame2nd     : TRect; //Draws Frame around whole widget like bevel

    Slider       : TRect; //used by DrawEdge since it does not accept other params
    LSlider      : TRect; // used to make depressible arm of slider
    HSlider      : TRect; // used to make depressible arm of slider
    Thumb        : TRect; //used by DrawEdge since it does not accept other params
    Track        : TRect; // this is actually full size slider or the bed of the slider

    Locked       : Boolean; //Showes if Mouse is in Slider; Helps for Simple Code
    LowLock      : Boolean; //Left/bottom Side Locked  //Old = LBLock
    HighLock     : Boolean; //Right/Top Side Locked //Old = RTLock
    ThumbLock    : Boolean; //Thumb Locked //Old = MidThumbLock
    DoDepress    : Boolean;

    SliderLow    : Integer; //Left or Bottom Position of Slider
    SliderHigh   : Integer; //Right or Top position of slider
    ThumbLow     : Integer; //Left or Bottom Side of Thumb
    ThumbHigh    : Integer; //Right or Top Side of Thumb

    DeadPix      : Integer; //Dead Range = Min Distance between Low and High = 3*thumb Size
    UnitsPerPix  : Extended;//Units per Pixel

    LowPosMem    : Integer; // memorizes Low  X or Y pos [pixels] OnMouseDown
    HighPosMem   : Integer; // memorizes High X or Y pos [pixels] OnMouseDown
    DifMem       : Integer; // memorizes Difference between X or Y pos [pixels] OnMouseDown
    MousePosMem  : Integer; // memorises Mouse X or Y coordinates OnMouseDown

    SliderBMP    : TBitmap; //To avoid flicker first draw on BMP and then to Canvas

    //------------------- Buttons ----------------------------------------------//
    ButLowDecDown  : Boolean;
    ButLowIncDown  : Boolean;
    ButHighDecDown : Boolean;
    ButHighIncDown : Boolean;

    ButLowDec    : TRect;
    ButLowInc    : TRect;
    ButHighDec   : TRect;
    ButHighInc   : TRect;

    LowDecArrow  : array[0..2] of TPoint;
    LowIncArrow  : array[0..2] of TPoint;
    HighDecArrow : array[0..2] of TPoint;
    HighIncArrow : array[0..2] of TPoint;

    //--------------------------------------------------------------------------

    //properties to be published
    FMin         : Integer; //in Units not in Pixels
    FMax         : Integer; //in Units not in Pixels
    FDelta       : Integer; //Minimum between PosFrom and PosTo  in Units (not Pix)
    FPosFrom     : Integer; //Position of Low  Hand of Slider in UNITs
    FPosTo       : Integer; //Position of High Hand of Slider in UNITs

    FColorTrack   : TColor; //color of the track, = base if slider is wide as the base
    FColorSlider  : TColor; //color of sider
    FColorThumb   : TColor; //color of thumb
    FColorContour : TColor; //color of Outline of the Slider if No Frame is Valid

    FFlat         : Boolean; // Not True = 3D look
    FFrame        : Boolean; //Draws Frame Around (2 pix width) like Bevel
    FContour      : Boolean;
    FDepressible  : Boolean; //I true then Slider Arms could be deppressed by Mouse
    FKind         : TKind;
    FAllowTimer   : Boolean; {introduced 7-19-2016 because if the action trigerred by the side buttonds (the one with arrows) was too long
    then the timer could not be stopped by MouseUp.  The Timer did not get the MouseUp event.
    Timer is used maintain continuous change if one of the buttons is presse more than 400 ms.
    I tried different things but noting worked. Finally i decidid to indroduce FAllowTimer to be able prevent the Timer
    from starting if progarm has problems.  Only one in realScan form the one that selects the part of the image for trace.
    If timer cannpot be enabled then clicking on the buttons causes a change of +- 1 but continuous change.  To change by another + or - 1 one should click again}
    FThumbSize    : Integer;
    FOnChange     : TNotifyEvent;

    procedure SetSliderBMP;
    procedure DrawThumbEdgeOnSliderBMP;
    procedure SetHalfSlidersRect;
    procedure SetThumb;
    procedure DrawSlider;
    procedure Timer(Sender : TObject); //name doesn't matter here  //
    procedure Resize; override; // helps redrawing Slider in Design Time to Keep with Size Changes


    //Property Setlers (for published properties)
    procedure SetColorSlider(Value: TColor);
    procedure SetColorThumb(Value: TColor);
    procedure SetColorTrack(Value: TColor);
    procedure SetColorContour(Value : TColor);
    procedure SetFlat(Value: Boolean);
    procedure SetFrame(Value: Boolean);
    procedure SetContour(Value: Boolean);
    procedure SetAllowTimer(Value: Boolean);

    procedure SetThumbSize(Value: Integer);
    procedure SetKind(Value: TKind);

    procedure SetMin(Value : Integer);
    procedure SetMax(Value : Integer);
    procedure SetPosFrom(Value : Integer);
    procedure SetPosTo  (Value : Integer);
    procedure SetDelta  (Value : Integer);

    procedure SetSliderParams;
    procedure UpdateSliderLowHighPos;
    procedure RepaintSlider;
    procedure SetEnabled(Value: Boolean); override;



  protected
    { Protected declarations }

    procedure Paint; override;
    procedure Change; dynamic;


  public
    { Public declarations }     //in ExtCtrls

          // CM_ENABLEDCHANGED
          //inherited
    constructor Create(AOwner: TComponent); override; //remember override directive ;  constructors are always public
    destructor Destroy; override;   

    procedure MouseDown(Button : TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift  : TShiftState; X, Y: Integer); override;
    procedure MouseUp  (Button : TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DblClick ; override;

    procedure SetSlider(Minimum, Maximum, PositionFrom, PositionTo : Integer); // set Slider at Once
    procedure SetSliderPos(PositionFrom, PositionTo : Integer); 

  published
    { Published declarations }
   {*** inherited ***}
   //these are already in the TCustomControl but must be published if we use them
    {
    property OnClick;
    OnEnter
    OnKeyUp
    OnKeyDown
    OnExit
    OnKeyPress
    property DragCursor; // drag-and-drop properties
    property DragMode;
    property OnDragDrop; // drag-and-drop events
    property OnStartDock;
    property OnEndDock;
    property OnStartDrag;
    property OnEndDrag;
    property OnDragOver; }
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property Enabled;
    property Constraints;
    property ShowHint;
    property OnDblClick;
    property OnExit;
    property OnEnter;
    property OnContextPopup;
    property Color; 
    property Tag;
    property Height;
    property Width;

    {*** new ***}

    property ColorSlider  : TColor  read FColorSlider  write SetColorSlider;
    property ColorThumb   : TColor  read FColorThumb   write SetColorThumb;
    property ColorTrack   : TColor  read FColorTrack   write SetColorTrack;
    property ColorContour : TColor  read FColorContour write SetColorContour;

    property Flat        : Boolean read FFlat        write SetFlat;
    property Frame       : Boolean read FFrame       write SetFrame;
    property Contour     : Boolean read FContour     write SetContour;

    property ThumbSize   : Integer read FThumbSize   write SetThumbSize;
    property Kind        : TKind   read FKind        write SetKind;

    property Min         : Integer read FMin         write SetMin;
    property Max         : Integer read FMax         write SetMax;
    property PosFrom     : Integer read FPosFrom     write SetPosFrom;
    property PosTo       : Integer read FPosTo       write SetPosTo;
    property Delta       : Integer read FDelta       write SetDelta;
    property Depressible : Boolean read FDepressible write FDepressible;
    property AllowTimer  : Boolean read FAllowTimer  write FAllowTimer;

    property OnChange    : TNotifyEvent read FOnChange write FOnChange;


  end;

 
 procedure Register;

implementation
{
The simplest way to make property data available is direct access. That is, the read and
write parts of the property declaration specify that assigning or reading the property
value goes directly to the internal-storage field without calling an access method.
Direct access is useful when you want to make a property available in the Object
Inspector but changes to its value trigger no immediate processing.
}
///////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Standard',[TDSlider]);
end;

///////////////////////////////////////////////////////////////////////////////

constructor TDSlider.Create(AOwner: TComponent);
  //to initialize the new properties
begin

    inherited Create(AOwner); { always call the inherited constructor }

    {initializes  properties}
    //inherited Must be Set to values
    Width := 100;
    Height := 15;
    Color := clBtnFace;
    //newly created Must be set too

    FColorSlider := $00FFC184; // = RGB(132,193,255); bluish
    FColorThumb  := clBtnFace;
    FColorTrack  := $00FFE4CA; // = RGB(202,228,255); bluish
    FColorContour:= clBlue;
    FContour     := True;
    FFlat        := False;  //means will have 3D look
    FFrame       := True;
    FThumbSize   := 10;

    FDelta       := 0;
    FMin         := 0;   //units not pixels
    FMax         := 100; //units not pixels
    FPosFrom     := FMin;
    FPosTo       := FMax;

    FDepressible := True;
    
    //initializes some slider variables - the rest in Resize Procedure
    LowLock         := False; //Left/bottom Side Locked
    HighLock        := False; //Right/Top Side Locked
    ThumbLock       := False;
    Locked          := False;

    ButLowDecDown   := False;
    ButLowIncDown   := False;
    ButHighDecDown  := False;
    ButHighIncDown  := False;

    if Not(csDesigning in ComponentState) then begin
      ThrTimer := TThreadedTimer.Create(Self);
      ThrTimer.Enabled := False;
      ThrTimer.OnTimer := Timer;  // Assign our own Timer event handler to the Timer OnTimer event
      ThrTimer.Interval := 100;
      TimeElapsed := 0;
    end;
    FAllowTimer := True;
    SliderBMP := TBitmap.Create;
    SliderBMP.Canvas.Pen.Color := FColorContour;
    {
    FColorTrack   := $00ECFBD5; // =  RGB(213, 251, 236); //greenish
    FColorSlider := $00A2EA35; // =  RGB(53, 234,162);   //greenish     }
    
End;

destructor TDSlider.Destroy;
begin

  FreeAndNil(SliderBMP);
  FreeAndNil(ThrTimer);

  inherited Destroy; { always call the inherited destructor, too }

end;
///////////////////////////////////////////////////////////////////////////////
procedure TDSlider.SetSliderParams;

var //help to make clear code
    //arrows vars
    ArrLenght     : Integer; //from base to arrow point (nose0
    ArrHalfWidth  : Integer;
    HalfButWidth  : Integer; //half width (horizontal) of button
    HalfButHeight : Integer; //half height (horizontal) of button
    //button vars
    Border        : Integer; //if Frame then Border = 1, else = 0
    Gap           : Integer; // gap between buttons
    ButtonWidth   : Integer;
    ButtonHeight  : Integer;


begin


  {initalizes Frame}
  if (FFRame) then begin //Frame is always the same in Horizontal and Vertical
    Frame1st.Left   := 1;
    Frame1st.Top    := 1;
    Frame1st.Right  := Width;
    Frame1st.Bottom := Height;
    Frame2nd.Left   := 0;
    Frame2nd.Top    := 0;
    Frame2nd.Right  := Width  - 1;
    Frame2nd.Bottom := Height - 1;
  end;

  {makes button rectangulars}


  Gap    := 1; //always same
  if (FFRame) then Border := 1 else if Not(FFRame) then Border := 0;


  If FKind = Horizontal then Begin
    //ButtonWidth is EQ to ButtonHeight but I leave the door open for Rectangular (not square) buttons
    if (FFRame) then begin
      ButtonWidth  := Height - 2*Border;
      ButtonHeight := Height - 2*Border;
    end else
    if Not(FFRame) then Begin
      ButtonWidth  := Height;
      ButtonHeight := Height;
    end;

              //  Rect(Left,                             Top,        Right,                            bottom)
    ButLowDec  := Rect(Border,                          Border, Border+ButtonWidth,              Border+ButtonHeight);
    ButLowInc  := Rect(ButLowDec.Right+Gap,             Border, ButLowDec.Right+Gap+ButtonWidth, Border+ButtonHeight);
    ButHighInc := Rect(Width-Border-ButtonWidth,        Border, Width-Border,                    Border+ButtonHeight);
    ButHighDec := Rect(ButHighInc.Left-Gap-ButtonWidth, Border, ButHighInc.Left-Gap,             Border+ButtonHeight);
    Track      := Rect(ButLowInc.Right+Gap,             Border, ButHighDec.Left-Gap,             Border+ButtonHeight);

  End Else

  If FKind = Vertical then begin
    if (FFRame) then begin
      ButtonWidth  := Width - 2*Border;
      ButtonHeight := Width - 2*Border;
    end else
    if Not(FFRame) then Begin
      ButtonWidth  := Width;
      ButtonHeight := Width;
    end;
              //  Rect(Left,   Top,                            Right,                bottom)
    ButHighInc := Rect(Border, Border,                         Border + ButtonWidth, Border+ButtonHeight);
    ButHighDec := Rect(Border, ButHighInc.Bottom+Gap,          Border + ButtonWidth, ButHighInc.Bottom+Gap+ButtonHeight);
    ButLowDec  := Rect(Border, Height-Border-ButtonHeight,     Border + ButtonWidth, Height-Border);
    ButLowInc  := Rect(Border, ButLowDec.Top-Gap-ButtonHeight, Border + ButtonWidth, ButLowDec.Top-Gap);
    Track      := Rect(Border, ButHighDec.Bottom+Gap,          Border + ButtonWidth, ButLowInc.Top-Gap);  

 End; //If FKind = Vertical


 If (Track.Right - Track.Left > 0) and (Track.Bottom - Track.Top > 0) then begin

  SliderBMP.Width   := Track.Right  - Track.Left;
  SliderBMP.Height  := Track.Bottom - Track.Top;

  If FKind = Horizontal then Begin
    Slider.Top     := 0;
    Slider.Bottom  := SliderBMP.Height;
    LSlider.Top    := 0;
    LSlider.Bottom := SliderBMP.Height;
    HSlider.Top    := 0;
    HSlider.Bottom := SliderBMP.Height;
    Thumb.Top      := 0;
    Thumb.Bottom   := SliderBMP.Height;
  End Else
  If FKind = Vertical then Begin
    Slider.Left   := 0;
    Slider.Right  := SliderBMP.Width;
    LSlider.Left  := 0;
    LSlider.Right := SliderBMP.Width;
    HSlider.Left  := 0;
    HSlider.Right := SliderBMP.Width;
    Thumb.Left    := 0;
    Thumb.Right   := SliderBMP.Width;
  End;

 

  //Sets Arrows
  If FKind = Horizontal then Begin
   //general arrow var
  ArrHalfWidth  := (ButLowDec.Bottom - ButLowDec.Top - 4) div 3; // = How Wide it is //- 4 is because of the Edge = 4 pix
  ArrLenght     :=  ArrHalfWidth; //from the base to the nose
  HalfButWidth  := (ButLowDec.Right  - ButLowDec.Left) shr 1;  //any button works
  HalfButHeight := (ButLowDec.Bottom - ButLowDec.Top) shr 1;
  {I keep Options for rectangular buttons open here by using separate vars for But W and H here}

  //1st: ButLowDec
  //upper point
  LowDecArrow[0].X := HalfButWidth + ArrLenght shr 1;
  LowDecArrow[0].Y := HalfButHeight - ArrHalfWidth;
  //arrow point
  LowDecArrow[1].X := LowDecArrow[0].X - ArrLenght;
  LowDecArrow[1].Y := HalfButHeight;
  //bottom point
  LowDecArrow[2].X := HalfButWidth + ArrLenght shr 1;
  LowDecArrow[2].Y := HalfButHeight + ArrHalfWidth;

  //2nd: ButLowInc
 //upper point
  LowIncArrow[0].X := HalfButWidth - ArrLenght shr 1 + ButLowDec.Right + 1;
  LowIncArrow[0].Y := HalfButHeight - ArrHalfWidth;
  //arrow point
  LowIncArrow[1].X := LowIncArrow[0].X + ArrLenght;
  LowIncArrow[1].Y := HalfButHeight;
  //bottom point
  LowIncArrow[2].X := HalfButWidth - ArrLenght shr 1 + ButLowDec.Right + 1;
  LowIncArrow[2].Y := HalfButHeight + ArrHalfWidth;

  //3rd: ButHighDec
  //upper point
  HighDecArrow[0].X := HalfButWidth + ArrLenght shr 1 + Track.Right + 1;
  HighDecArrow[0].Y := HalfButHeight - ArrHalfWidth;
  //arrow point
  HighDecArrow[1].X := HighDecArrow[0].X - ArrLenght;
  HighDecArrow[1].Y := HalfButHeight;
  //bottom point
  HighDecArrow[2].X := HalfButWidth + ArrLenght shr 1 + Track.Right + 1;
  HighDecArrow[2].Y := HalfButHeight + ArrHalfWidth;

  //4th: ButHighInc
 //upper point
  HighIncArrow[0].X := HalfButWidth - ArrLenght shr 1 + ButHighDec.Right + 1;
  HighIncArrow[0].Y := HalfButHeight - ArrHalfWidth;
  //arrow point
  HighIncArrow[1].X := HighIncArrow[0].X + ArrLenght;
  HighIncArrow[1].Y := HalfButHeight;
  //bottom point
  HighIncArrow[2].X := HalfButWidth - ArrLenght shr 1 + ButHighDec.Right + 1;
  HighIncArrow[2].Y := HalfButHeight + ArrHalfWidth;
  End Else

  If FKind = Vertical then Begin
   //general arrow var
  ArrHalfWidth  := (ButLowDec.Right - ButLowDec.Left - 4) div 3; //- 4 is because of the Edge = 4 pix
  ArrLenght     :=  ArrHalfWidth;   //from the base to the nose
  HalfButWidth  := (ButLowDec.Bottom - ButLowDec.Top)  shr 1; //any button works
  HalfButHeight := (ButLowDec.Right  - ButLowDec.Left) shr 1;


  //1st: ButHighInc
  HighIncArrow[0].X := HalfButHeight - ArrHalfWidth;
  HighIncArrow[0].Y := HalfButWidth  + ArrLenght shr 1;
  //arrow point
  HighIncArrow[1].X := HalfButHeight;
  HighIncArrow[1].Y := HighIncArrow[0].Y - ArrLenght;
  //bottom point
  HighIncArrow[2].X := HalfButHeight + ArrHalfWidth;
  HighIncArrow[2].Y := HalfButWidth  + ArrLenght shr 1;

  //2nd: ButHighDec
  //upper point
  HighDecArrow[0].X := HalfButHeight - ArrHalfWidth;
  HighDecArrow[0].Y := HalfButWidth - ArrLenght shr 1 + ButHighInc.Bottom + 1;
  //arrow point
  HighDecArrow[1].X := HalfButHeight;
  HighDecArrow[1].Y := HighDecArrow[0].Y + ArrLenght;
  //bottom point
  HighDecArrow[2].X := HalfButHeight + ArrHalfWidth;
  HighDecArrow[2].Y := HalfButWidth - ArrLenght shr 1 + ButHighInc.Bottom + 1;

  //3rd: ButLowInc
  //upper point
  LowIncArrow[0].X := HalfButHeight - ArrHalfWidth;
  LowIncArrow[0].Y := HalfButWidth  + ArrLenght shr 1 + Track.Bottom + 1;
  //arrow point
  LowIncArrow[1].X := HalfButHeight;
  LowIncArrow[1].Y := LowIncArrow[0].Y - ArrLenght;
  //bottom point
  LowIncArrow[2].X := HalfButHeight + ArrHalfWidth;
  LowIncArrow[2].Y := HalfButWidth  + ArrLenght shr 1+ Track.Bottom + 1;

  //4th: ButLowDec
  //upper point
  LowDecArrow[0].X := HalfButHeight - ArrHalfWidth;
  LowDecArrow[0].Y := HalfButWidth  - ArrLenght shr 1 + ButLowInc.Bottom + 1;
  //arrow point
  LowDecArrow[1].X := HalfButHeight;
  LowDecArrow[1].Y := LowDecArrow[0].Y + ArrLenght;
  //bottom point
  LowDecArrow[2].X := HalfButHeight + ArrHalfWidth;
  LowDecArrow[2].Y := HalfButWidth  - ArrLenght shr 1+ ButLowInc.Bottom + 1; 

  End;
  
  // Follow exactly this Order

  if Kind = Horizontal then begin
      Constraints.MinWidth  := 4*FThumbSize + 4*ButtonWidth + 2*Border;
      Constraints.MinHeight := 5;
  end else
  if Kind = Vertical then begin
     Constraints.MinWidth  := 5;
     Constraints.MinHeight := 4*FThumbSize + 4*ButtonHeight + 2*Border;;
  end;
  
   //1st
  DeadPix := 3*FThumbSize;
  //2nd
  if Kind = Horizontal then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Right - Track.Left) - DeadPix);
  if Kind = Vertical then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Bottom - Track.Top) - DeadPix);
  //3rd
  UpdateSliderLowHighPos;
  //4th
  SetThumb;
  //5th
  SetSliderBMP;



End;  //If (Track.Right - Track.Left > 0) and (Track.Bottom - Track.Top > 0)


End;

///////////////////////////////////////////////////////////////////////////////
procedure TDSlider.Resize; //used in Design time and after Creation in Run Time
begin


 inherited Resize;
 SetSliderParams;  
 //Paint is called automatically
  {Other children  VCL will paint themselves when changed}

end;


///////////////////////////////////////////////////////////////////////////////
        /// This Group of Procedures Sets Properties Published /////



procedure TDSlider.SetColorSlider(Value: TColor);
begin
  FColorSlider := Value;
  RepaintSlider;
end;

procedure TDSlider.SetColorThumb(Value: TColor);
begin
  FColorThumb := Value;
  RepaintSlider;
end;

procedure TDSlider.SetColorTrack(Value: TColor);
begin
  FColorTrack := Value;
  RepaintSlider;
end;

procedure TDSlider.SetColorContour(Value : TColor);
begin
  FColorContour := Value;
  SliderBMP.Canvas.Pen.Color := FColorContour;
  RepaintSlider;
end;

procedure TDSlider.SetContour(Value: Boolean);
begin
  FContour := Value;
  RepaintSlider;
end;

procedure TDSlider.SetFlat(Value: Boolean);
begin

    FFlat := Value;
    SetSliderParams;
    Paint;

end;

procedure TDSlider.SetEnabled(Value: Boolean);
begin
  inherited;
  SetSliderBMP;
  Paint;
end;

procedure TDSlider.SetFrame(Value: Boolean);
begin

    FFrame := Value;    
    Canvas.Brush.Color := Color;
    Canvas.Rectangle(Canvas.ClipRect);   
    SetSliderParams;
    Paint;

end;

procedure TDSlider.SetThumbSize(Value : Integer);
const MinThumbSize = 5;
begin
  if (Value <> FThumbSize) then begin
   if Value >= MinThumbSize then FThumbSize := Value else
   if Value <  MinThumbSize then FThumbSize := MinThumbSize;
   SetSliderParams;
   DrawSlider;
  end;

end;

procedure TDSlider.SetDelta(Value : Integer);

begin
  if (Value <> FDelta) then begin
   FDelta := Value;
   if Kind = Horizontal then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Right - Track.Left) - DeadPix);
   if Kind = Vertical then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Bottom - Track.Top) - DeadPix);
  end;

end;


procedure TDSlider.SetKind(Value: TKind);  
begin
  if FKind <> Value then begin

    FKind := Value;

    if not (csLoading in ComponentState) then begin
      Constraints.MinWidth  := 0;
      Constraints.MinHeight := 0;
      SetBounds(Left, Top, Height, Width);
    end;
    RecreateWnd;
  end;
   //the above commands were taken from TScrollBar.SetKind;

   if (csLoading in ComponentState) then SetSliderParams;
   //to show in Vertical when project is reopen

end;
////////////////////////////////////////////////////
procedure TDSlider.SetMin(Value : Integer);

begin
   if FMin <> value then begin

    if Not(csDesigning in ComponentState) then begin
      FMin := Value;
    end else
    if (csDesigning in ComponentState) then begin
      if Value <  FMax - FDelta then begin
        FMin    := Value;
        FPosFrom := FMin;
      end else
      if Value >= FMax - FDelta then
        MessageDlg('Min should be lower or equal to Max - Delta - 1',mtError,[mbOK],0);
    end;

    if Kind = Horizontal then
      UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Right - Track.Left) - DeadPix);
    if Kind = Vertical then
      UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Bottom - Track.Top) - DeadPix); 

    UpdateSliderLowHighPos;  
    RepaintSlider;
    
   end;
end;

procedure TDSlider.SetMax(Value : Integer);
begin
  if FMax <> value then begin

   if Not(csDesigning in ComponentState) then begin
      FMax := Value;
    end else
    if (csDesigning in ComponentState) then begin
      if Value > FMin + FDelta then begin
        FMax  := Value;
        FPosTo := FMax;
      end else
      if Value <= FMin + FDelta then
        MessageDlg('Max should be higher or equal to then Min + Delta + 1',mtError,[mbOK],0);
   end;

   if Kind = Horizontal then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Right - Track.Left) - DeadPix);
   if Kind = Vertical then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Bottom - Track.Top) - DeadPix); 

   UpdateSliderLowHighPos;
   RepaintSlider;

  end;
end;



procedure TDSlider.SetPosFrom(Value : Integer);
begin
  if (FPosFrom <> Value) then begin

    if (Value >= FMin) and (Value <= FPosTo - FDelta) then FPosFrom := Value
    else begin
      if Value < FMin then FPosFrom := FMin;
      if Value > FPosTo - FDelta then FPosFrom := FPosTo - FDelta;
    end;

    if Kind = Horizontal then
      SliderLow  := Round((FPosFrom - FMin)/UnitsPerPix) + Track.Left else
    if Kind = Vertical then
      SliderLow  := Track.Bottom - Round((FPosFrom - FMin)/UnitsPerPix);

    RepaintSlider;
    
  end;
end;

procedure TDSlider.SetPosTo(Value : Integer);
begin
   if FPosTo <> Value then begin

    if (Value <= FMax) and (Value >= FPosFrom + FDelta) then FPosTo := Value
    else begin
      if Value > FMax then FPosTo := FMax;
      if Value < FPosFrom + FDelta then FPosTo := FPosFrom + FDelta;
    end;

    if Kind = Horizontal then
      SliderHigh := Round((FPosTo  - FDelta - FMin)/UnitsPerPix) + Track.Left + DeadPix else
    If Kind = Vertical then
      SliderHigh := Track.Bottom - DeadPix - Round((FPosTo - FDelta - FMin)/UnitsPerPix);

    RepaintSlider;
   end;
end;

procedure TDSlider.SetSlider(Minimum, Maximum, PositionFrom, PositionTo : Integer); // set Slider at Once
begin
   if Minimum      <> FMin     then FMin     := Minimum;
   if Maximum      <> FMax     then FMax     := Maximum;
   if PositionFrom <> FPosFrom then FPosFrom := PositionFrom;
   if PositionTo   <> FPosTo   then FPosTo   := PositionTo;

   if Kind = Horizontal then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Right - Track.Left) - DeadPix);
   if Kind = Vertical then
    UnitsPerPix    := (FMax - FMin - FDelta)/((Track.Bottom - Track.Top) - DeadPix);

    UpdateSliderLowHighPos;
    RepaintSlider;
end;
//------------------------------------------------------------------------------------------

procedure TDSlider.SetSliderPos(PositionFrom, PositionTo : Integer); // set Slider at Once
begin
   
   if PositionFrom <> FPosFrom then FPosFrom := PositionFrom;
   if PositionTo   <> FPosTo   then FPosTo   := PositionTo;

   UpdateSliderLowHighPos;
   RepaintSlider;
end;

//////////////////////////////////////////////////////////////////////////////
        /// This Group of Procedures Reacts to Mouse /////


procedure TDSlider.Change;
begin

 inherited Changed;
 if Enabled then if Assigned(FOnChange) then FOnChange(Self);
end;
///////////////////////////////////////////////////////////////////////////////

procedure TDSlider.SetAllowTimer(Value: Boolean);
begin
    FAllowTimer := Value;
end;

procedure TDSlider.Timer(Sender : TObject);
begin

  Inc(TimeElapsed,ThrTimer.Interval);

  If TimeElapsed > 400 then Begin
    if ButLowDecDown  then begin
     if FPosFrom >  FMin then FPosFrom := FPosFrom - 1;
    end else
    if ButLowIncDown  then begin
      if FPosFrom < FPosTo - FDelta then FPosFrom := FPosFrom + 1;
    end else
    if ButHighDecDown then begin
      if FPosTo >   FPosFrom + FDelta then FPosTo   := FPosTo - 1;
    end else
    if ButHighIncDown then begin
      if FPosTo <   FMax then FPosTo   := FPosTo + 1;
    end;

    UpdateSliderLowHighPos;
    RepaintSlider;
    Change;
  end;

end;

///////////////////////////////////////////////////////////////////////////////

procedure TDSlider.UpdateSliderLowHighPos;
begin
    If Kind = Horizontal Then Begin
      SliderLow  := Round((FPosFrom - FMin)/UnitsPerPix) + Track.Left;
      SliderHigh := Round((FPosTo  - FDelta - FMin)/UnitsPerPix) + Track.Left + DeadPix;
    End Else
    If Kind = Vertical Then Begin
      SliderLow  := Track.Bottom - Round((FPosFrom - FMin)/UnitsPerPix);
      SliderHigh := Track.Bottom - DeadPix - Round((FPosTo - FDelta - FMin)/UnitsPerPix);
    End;

end;

///////////////////////////////////////////////////////////////////////////////

procedure TDSlider.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

begin


 SetFocus; //just to move focus from other VCL to this
 If Button = mbLeft Then Begin

  If Kind = Horizontal then Begin
    MousePosMem := X;

    If (X > SliderLow) and (X < SliderHigh) then begin
      Locked := True;

      if (X > SliderLow) and (X < ThumbLow)   then begin
        LowLock   := True;
        LowPosMem := SliderLow;
      end else
      if (X > ThumbHigh) and (X < SliderHigh) then begin
        HighLock   := True;
        HighPosMem := SliderHigh;
      end else
      if (X > ThumbLow)  and (X < ThumbHigh)  then begin
        ThumbLock  := True;
        LowPosMem  := SliderLow;
        HighPosMem := SliderHigh;
        DifMem     := HighPosMem - LowPosMem;
      end;
      
    End Else
       {-------------- Buttons -------------------}
    If (X < SliderLow) or (X > SliderHigh) then begin  //Buttons

      if (X > ButLowDec.Left) and (X < ButLowDec.Right) then begin
        ButLowDecDown := True;
        DrawEdge(Canvas.Handle,ButLowDec,  EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end else
      if (X > ButLowInc.Left) and (X < ButLowInc.Right) then begin
        ButLowIncDown := True;
        DrawEdge(Canvas.Handle,ButLowInc,  EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end else
      if (X > ButHighDec.Left) and (X < ButHighDec.Right) then begin
        ButHighDecDown := True;
        DrawEdge(Canvas.Handle,ButHighDec, EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end else
      if (X > ButHighInc.Left) and (X < ButHighInc.Right) then begin
        ButHighIncDown := True;
        DrawEdge(Canvas.Handle,ButHighInc, EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end;

      if ButLowDecDown  then begin
        if FPosFrom >  FMin then FPosFrom := FPosFrom - 1;
      end else
      if ButLowIncDown  then begin
        if FPosFrom < FPosTo - FDelta then FPosFrom := FPosFrom + 1;
      end else
      if ButHighDecDown then begin
        if FPosTo >   FPosFrom + FDelta then FPosTo   := FPosTo - 1;
      end else
      if ButHighIncDown then begin
       if FPosTo <   FMax then FPosTo   := FPosTo + 1;
      end;

      UpdateSliderLowHighPos;
      RepaintSlider;
      Change;
      if (FAllowTimer) then ThrTimer.Enabled := True;
    End; //If (X < SliderHigh) or (X > SliderHigh) then begin

  //------------------- Vertical ------------------------------------------//

  End Else
  If Kind = Vertical then Begin
    MousePosMem := Y;

    If (Y > SliderHigh) and (Y < SliderLow) then Begin
      Locked := True;
      if (Y > SliderHigh) and (Y < ThumbHigh)   then begin
        HighLock   := True;
        HighPosMem := SliderHigh;
      end else
      if (Y > ThumbLow) and (Y < SliderLow) then begin
        LowLock   := True;
        LowPosMem := SliderLow;
      end else
      if (Y > ThumbHigh)  and (Y < ThumbLow)  then begin
        ThumbLock    := True;
        HighPosMem   := SliderHigh;
        LowPosMem    := SliderLow;
        DifMem       := LowPosMem - HighPosMem;
      end;

    End Else
        {------------ Buttons -----------------}
    If (Y < SliderHigh) or (Y > SliderLow) then begin

      if (Y > ButLowDec.Top) and (Y < ButLowDec.Bottom) then begin
        ButLowDecDown := True;
        DrawEdge(Canvas.Handle,ButLowDec,  EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end else
      if (Y > ButLowInc.Top) and (Y < ButLowInc.Bottom) then begin
        ButLowIncDown := True;
        DrawEdge(Canvas.Handle,ButLowInc,  EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end else
      if (Y > ButHighDec.Top) and (Y < ButHighDec.Bottom) then begin
        ButHighDecDown := True;
        DrawEdge(Canvas.Handle,ButHighDec, EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end else
      if (Y > ButHighInc.Top) and (Y < ButHighInc.Bottom) then begin
        ButHighIncDown := True;
        DrawEdge(Canvas.Handle,ButHighInc, EDGE_SUNKEN, BF_RECT or BF_SOFT);
      end;

      if ButLowDecDown  then begin
        if FPosFrom >  FMin then FPosFrom := FPosFrom - 1;
      end else
      if ButLowIncDown  then begin
        if FPosFrom < FPosTo - FDelta then FPosFrom := FPosFrom + 1;
      end else
      if ButHighDecDown then begin
        if FPosTo >   FPosFrom + FDelta then FPosTo := FPosTo - 1;
      end else
      if ButHighIncDown then begin
       if FPosTo <   FMax then FPosTo   := FPosTo + 1;
      end;

      UpdateSliderLowHighPos;
      RepaintSlider;
      Change;
      if (FAllowTimer) then ThrTimer.Enabled := True;
    End; //If (X < SliderHigh) or (X > SliderHigh) then begin
  End; //If Kind = Vertical

      //-------- //
 
  if ThumbLock then begin
    DrawThumbEdgeOnSliderBMP; //draws just Thumb on SliderBMP
    DrawSlider;
  end;

 End; // If Button = mbLeft

if (Locked) and Not(ThumbLock) and   (FDepressible) and Not(FFlat) then DoDepress := True;
if Not(Locked) or  (ThumbLock) or Not(FDepressible) or     (FFlat) then DoDepress := False;

  if DoDepress then begin
    SetHalfSlidersRect;
    if LowLock then
      DrawEdge(SliderBMP.Canvas.Handle,LSlider, EDGE_SUNKEN, BF_RECT or BF_SOFT) else
    if HighLock then
      DrawEdge(SliderBMP.Canvas.Handle,HSlider, EDGE_SUNKEN, BF_RECT or BF_SOFT);

    DrawSlider;
  end;

  inherited MouseDown(Button, Shift, X, Y); 

End;

////////////////////////////////////////////////////////////////////

procedure TDSlider.MouseMove(Shift: TShiftState; X,  Y: Integer);

begin


 If (Locked) Then Begin //Left Mouse Button

  If Kind = Horizontal then Begin
    if (LowLock) then begin
      SliderLow := LowPosMem + (X-MousePosMem);
      if SliderLow < Track.Left then SliderLow := Track.Left;
      if SliderLow > SliderHigh - DeadPix then SliderLow := SliderHigh - DeadPix;
      FPosFrom := Round(UnitsPerPix*(SliderLow - Track.Left)) + FMin;
    end else
    if (HighLock) then begin
      SliderHigh := HighPosMem + (X-MousePosMem);
      if SliderHigh > Track.Right then SliderHigh := Track.Right;
      if SliderHigh <  SliderLow + DeadPix then SliderHigh := SliderLow + DeadPix;
      FPosTo := Round(UnitsPerPix*(SliderHigh - Track.Left - DeadPix)) + FDelta + FMin;
    end else
    if (ThumbLock) then begin
      SliderLow  := LowPosMem  + (X-MousePosMem);
      SliderHigh := HighPosMem + (X-MousePosMem);
      if SliderLow < Track.Left then begin
        SliderLow  := Track.Left;
        SliderHigh := SliderLow + DifMem;
      end;
      if SliderHigh > Track.Right then begin
        SliderHigh := Track.Right;
        SliderLow  := SliderHigh - DifMem;
      end;
      FPosFrom := Round(UnitsPerPix*(SliderLow  - Track.Left)) + FMin;
      FPosTo   := Round(UnitsPerPix*(SliderHigh - Track.Left - DeadPix)) + FDelta + FMin;
    end;
  End Else     // If Kind = Horizontal
  If Kind = Vertical then Begin
    if (LowLock) then begin
      SliderLow := LowPosMem + (Y-MousePosMem);
      if SliderLow >  Track.Bottom then SliderLow := Track.Bottom;
      if SliderLow <  SliderHigh + DeadPix then
         SliderLow := SliderHigh + DeadPix;
      FPosFrom := Round(UnitsPerPix*((Track.Bottom - SliderLow))) + FMin;
    end else
    if (HighLock) then begin
      SliderHigh := HighPosMem + (Y-MousePosMem);
      if SliderHigh < Track.Top then SliderHigh := Track.Top;
      if SliderHigh > SliderLow - DeadPix then
         SliderHigh := SliderLow - DeadPix;
      FPosTo   := Round(UnitsPerPix*(Track.Bottom - SliderHigh - DeadPix)) + FDelta + FMin;
    end else
    if (ThumbLock) then begin
      SliderHigh    := HighPosMem + (Y-MousePosMem);
      SliderLow := LowPosMem  + (Y-MousePosMem);
      if SliderLow >  Track.Bottom then begin
        SliderLow := Track.Bottom;
        SliderHigh    := SliderLow - DifMem;
      end;
      if SliderHigh < Track.Top then begin
        SliderHigh    := Track.Top;
        SliderLow := SliderHigh + DifMem;
      end;
      FPosFrom := Round(UnitsPerPix*((Track.Bottom - SliderLow))) + FMin;
      FPosTo   := Round(UnitsPerPix* (Track.Bottom - SliderHigh - DeadPix)) + FDelta + FMin;
    end;

  End;     // If Kind = Vertical

  RepaintSlider;
  Change;

 End; //If (Locked)

 inherited MouseMove(Shift, X, Y);

end;
///////////////////////////////////////////////////////////////////////////////

procedure TDSlider.MouseUp(Button : TMouseButton; Shift: TShiftState; X, Y: Integer);
 begin


  If (Locked) then Begin
    Locked    := False;
    LowLock   := False;
    HighLock  := False;
    if DoDepress then  begin
       DoDepress := False;
       SetSliderBMP;
       DrawSlider;
    end else
    if ThumbLock then begin
      ThumbLock := False;
      DrawThumbEdgeOnSliderBMP;
      DrawSlider;
    end;
  End Else

  If Not(Locked) Then Begin

    if (ThrTimer.Enabled) then begin
      ThrTimer.Enabled := False;
      TimeElapsed := 0;
    end;

    if (ButLowDecDown) then begin
      ButLowDecDown := False;
      DrawEdge(Canvas.Handle,ButLowDec,  EDGE_RAISED, BF_RECT or BF_SOFT);
    end else
    if (ButLowIncDown) then begin
      ButLowIncDown := False;
      DrawEdge(Canvas.Handle,ButLowInc,  EDGE_RAISED, BF_RECT or BF_SOFT);
    end else
    if (ButHighDecDown) then begin
      ButHighDecDown := False;
      DrawEdge(Canvas.Handle,ButHighDec, EDGE_RAISED, BF_RECT or BF_SOFT);
    end else
    if (ButHighIncDown) then begin
      ButHighIncDown := False;
      DrawEdge(Canvas.Handle,ButHighInc, EDGE_RAISED, BF_RECT or BF_SOFT);
    end;
  End; //If Not(Locked)

   inherited MouseUp(Button, Shift, X, Y);

End;


///////////////////////////////////////////////////////////////////////////////
procedure TDSlider.DblClick;
 var Reset : Boolean;
begin


 Reset := False;
 If Kind = Horizontal then Begin
  if (MousePosMem > ThumbLow)  and (MousePosMem < ThumbHigh)  then begin
    SliderLow  := Track.Left;
    SliderHigh := Track.Right;
    FPosFrom := Round(UnitsPerPix*(SliderLow  - Track.Left)) + FMin;
    FPosTo   := Round(UnitsPerPix*(SliderHigh - Track.Left - DeadPix)) + FDelta + FMin;
    Reset := True;
  end;
 End else
 If Kind = Vertical then Begin
  if (MousePosMem > ThumbHigh)  and (MousePosMem < ThumbLow)  then begin
    SliderHigh := Track.Top;
    SliderLow  := Track.Bottom;
    FPosFrom := Round(UnitsPerPix*((Track.Bottom - SliderLow))) + FMin;
    FPosTo   := Round(UnitsPerPix* (Track.Bottom - SliderHigh - DeadPix)) + FDelta + FMin;
    Reset := True;
  end;
 End;
 
 if  (Reset) then begin
  RepaintSlider;
  Change;
 end;

  inherited DblClick;

End;
///////////////////////////////////////////////////////////////////////////////
procedure  TDSlider.RepaintSlider;
begin
  SetThumb;
  SetSliderBMP;
  DrawSlider;
End;
///////////////////////////////////////////////////////////////////////////////
procedure TDSlider.SetThumb;
  var ThumbCenter : integer;
begin
If Kind = Horizontal then Begin
  ThumbCenter := SliderLow +(SliderHigh - SliderLow)shr 1;
  ThumbLow    := ThumbCenter - FThumbSize shr 1;
  ThumbHigh   := ThumbCenter + FThumbSize shr 1;
End Else
If Kind = Vertical then Begin
  ThumbCenter := SliderHigh + (SliderLow - SliderHigh) shr 1;
  ThumbHigh   := ThumbCenter - FThumbSize shr 1;
  ThumbLow    := ThumbCenter + FThumbSize shr 1;
end;
End;


///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
procedure TDSlider.Paint;

  //Canvas Methods: Copy an entire graphic. Draw
///Copy and resize a graphic. StretchDraw
//Copy part of a canvas. CopyRect


begin               

  with Canvas do begin
    {Draws Frame directly on DSlider Canvas; note that the rest is 1st drawn on Bitmap and then to canvas}

    If FFrame Then Begin
     Brush.Style := bsClear;
     Pen.Color   := clBtnHighlight;
     Rectangle(Frame1st);
     Pen.Color   := clBtnShadow;
     Rectangle(Frame2nd);
    End;
    {2nd: draws Arrows & Buttons}

    if Enabled then begin
    Brush.Color := clBlack;
    Pen.Color   := clBlack;
    end else
    begin
    Brush.Color := clInactiveBorder;
    Pen.Color   := clInactiveBorder;
    end;

    Polygon(LowDecArrow);
    Polygon(LowIncArrow);
    Polygon(HighDecArrow);
    Polygon(HighIncArrow);
    //buttons take the Color of the Whole Widget;
    DrawEdge(Canvas.Handle,ButLowDec,  EDGE_RAISED, BF_RECT or BF_SOFT);
    DrawEdge(Canvas.Handle,ButLowInc,  EDGE_RAISED, BF_RECT or BF_SOFT);
    DrawEdge(Canvas.Handle,ButHighDec, EDGE_RAISED, BF_RECT or BF_SOFT);
    DrawEdge(Canvas.Handle,ButHighInc, EDGE_RAISED, BF_RECT or BF_SOFT);

    DrawSlider;

  end;
end;

procedure TDSlider.SetSliderBMP;

begin

with SliderBMP.Canvas do begin

 if Kind = Horizontal then begin
    Slider.Left  := SliderLow-Track.Left;
    Slider.Right := SliderHigh-Track.Left;
    Thumb.Left   := ThumbLow -Track.Left;
    Thumb.Right  := ThumbHigh -Track.Left;
  end else
  if Kind = Vertical then begin
    Slider.Top    := SliderHigh-Track.Top;
    Slider.Bottom := SliderLow-Track.Top;
    Thumb.Top     := ThumbHigh- Track.Top;
    Thumb.Bottom  := ThumbLow- Track.Top;
  end;

  if  (DoDepress)  then SetHalfSlidersRect;


  Brush.Style := bsSolid;

  Brush.Color := FColorTrack;
  FillRect(ClipRect);  //ClipRect of  SliderBMP.Canvas

  if Enabled      then Brush.Color := FColorSlider else
                       Brush.Color := clInactiveBorder;

  if Not(Contour) or Not(FFlat) then begin

    FillRect(Slider);

    if Not(FFlat) then begin
      if (DoDepress) then begin
        if LowLock then begin
          DrawEdge(SliderBMP.Canvas.Handle,LSlider, EDGE_SUNKEN, BF_RECT or BF_SOFT);
          DrawEdge(SliderBMP.Canvas.Handle,HSlider, EDGE_RAISED, BF_RECT or BF_SOFT);
        end else
        if HighLock then begin
          DrawEdge(SliderBMP.Canvas.Handle,HSlider, EDGE_SUNKEN, BF_RECT or BF_SOFT);
          DrawEdge(SliderBMP.Canvas.Handle,LSlider, EDGE_RAISED, BF_RECT or BF_SOFT);
        end;
      end else
      if Not(DoDepress) then
      DrawEdge(SliderBMP.Canvas.Handle,Slider, EDGE_RAISED, BF_RECT or BF_SOFT);
    end;

  end else
  if   (Contour) and (FFlat) then begin
    Rectangle(Slider);
  end;

  Brush.Color := FColorThumb;
  FillRect(Thumb);
  if Not(ThumbLock) then
    DrawEdge(SliderBMP.Canvas.Handle,Thumb, EDGE_RAISED, BF_RECT or BF_SOFT) else
    DrawEdge(SliderBMP.Canvas.Handle,Thumb, EDGE_SUNKEN, BF_RECT or BF_SOFT);

end; //with SliderBMP.Canvas

end;

procedure TDSlider.DrawThumbEdgeOnSliderBMP;
begin
 //this procedure is used Only MouseUp and Mouse Down
 //to avoid redrawing the whole slider

    if Not(ThumbLock) then
      DrawEdge(SliderBMP.Canvas.Handle,Thumb, EDGE_RAISED, BF_RECT or BF_SOFT) else
      DrawEdge(SliderBMP.Canvas.Handle,Thumb, EDGE_SUNKEN, BF_RECT or BF_SOFT);


end;
///////////////////////////////////////////////////////////////////////////////

procedure TDSlider.SetHalfSlidersRect;
begin

  if Kind = Horizontal then begin
    if LowLock then begin
      LSlider.Left  := Slider.Left;
      LSlider.Right := Thumb.Left;
      HSlider.Left  := Thumb.Right - 2;
      HSlider.Right := Slider.Right;
    end else
    if HighLock then begin
      LSlider.Left  := Slider.Left;
      LSlider.Right := Thumb.Left + 2;
      HSlider.Left  := Thumb.Right;
      HSlider.Right := Slider.Right;
    end;
  end else

  if Kind = Vertical then begin
    if LowLock then begin
      LSlider.Top    := Thumb.Bottom;
      LSlider.Bottom := Slider.Bottom;
      HSlider.Top    := Slider.Top;
      HSlider.Bottom := Thumb.Top + 2;
    end else
    if HighLock then begin
      LSlider.Top    := Thumb.Bottom - 2;
      LSlider.Bottom := Slider.Bottom;
      HSlider.Top    := Slider.Top;
      HSlider.Bottom := Thumb.Top;
    end;
  end;


end;
///////////////////////////////////////////////////////////////////////////////
procedure TDSlider.DrawSlider;
begin
  with Canvas do Draw(Track.Left,Track.Top,SliderBMP);

end;

END.









