unit EditNumerical;
//by Adrian D. Bonev

interface

uses
    Windows,Forms, SysUtils, Classes, StdCtrls, Controls, Graphics, Messages, ThDTimer;
    //Windows should be listed First



const AllDigits  = ['0'..'9'];
      EvenDigits = ['0','2','4','6','8'];
      OddDigits  = ['1','3','5','7','9'];

type TNumberKind     = (Integers, Floats);  //What kind to be : Floating numbers , Integers
type TNumbers        = (One, Two); // if it will be 1 (integer or float) or 2 numbers (Only integers) separated by Separator
type TNumbersAllowed = (All, EvenNr, OddNr);
type TExitKind       = (MakeInactive, MakeTab); //whn exut to make Inactive, or to move to tab to the next Widget
type TSeparatorKind  = (Dash,Multiplication); // Separates 2 numbers
type TDigits         =  set of AnsiChar;

type

  TEditNumerical = class(TCustomEdit)

  private
    { Private declarations }
    Sender           : TObject;     //needed for TThreaded
    ThrTimer         : TThreadedTimer;
    TimeElapsed      : Cardinal;

    Digits           : TDigits;
    CustomDigits     : TDigits;
    UseCustomDigits  : Boolean;
    TextMem          : String;
    Returned         : Boolean;
    FNumberOne       : Integer;
    FNumberTwo       : Integer;
    FNumberFloat     : Extended;
    FMin             : Extended;
    FMax             : Extended;
    FDelta           : Integer; //Minimum between PosFrom and PosTo  in Units (not Pix)
    FNumberKind      : TNumberKind;
    FNumbers         : TNumbers;
    FNumbersAllowed  : TNumbersAllowed;
    FExitKind        : TExitKind;
    FSeparatorKind   : TSeparatorKind;
    FSeparator       : Char;

    FAlignment       : TAlignment;
    FColorOnFocus    : TColor;
    FColorOnNoFocus  : TColor;
    FFontOnFocus     : TFont;
    FFontOnNoFocus   : TFont;
    FExitOnReturn    : Boolean;
    FFocused         : Boolean;
    FHideText        : Boolean;
    FWaitTime        : Cardinal; // in milliseconds
    FPrecision       : Integer;

    FOnReturnPressed : TNotifyEvent;

    procedure ReturnPressed; dynamic;
    procedure SetDigits;
    procedure SetMin(Value : Extended);
    procedure SetMax(Value : Extended);
    procedure SetNumberOne(Value : Integer);
    procedure SetNumberTwo(Value : Integer);
    procedure SetNumberFloat(Value : extended);

    procedure SetHideText(Value : Boolean);
    procedure SetDelta(Value : Integer);
    procedure SetNumberKind(Value: TNumberKind);
    procedure SetNumbers(Value: TNumbers);
    procedure SetNumbersAllowed(Value : TNumbersAllowed);
    procedure SetSeparatorKind(Value : TSeparatorKind);
    procedure SetExitKind(Value : TExitKind);
    procedure SetWaitTime(Value : Cardinal);
    procedure SetPrecision(Value : Integer);
    procedure SetValues;
    procedure Timer(Sender : TObject); //name doesn't matter here  //


  protected
    { Protected declarations }
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CreateParams(var Params:TCreateParams); override;
    procedure DoEnter;override;
    procedure DoExit;override;
    procedure FontChanged(Sender: TObject);
    procedure KeyDown(var Key: Word; Shift: TShiftState);override; // ExitOnReturn
    procedure KeyPress(var Key: Char);override; // ExitOnReturn
    procedure KeyUp(var Key: Word; Shift: TShiftState);override;
    procedure DblClick;override;
    procedure SetAlignment(Value: TAlignment);
    procedure SetColorOnFocus(Value: TColor);
    procedure SetColorOnNoFocus(Value: TColor);
    procedure SetExitOnReturn(Value: Boolean);
    procedure SetFontOnFocus(Value: TFont);
    procedure SetFontOnNoFocus(Value: TFont);
    procedure SetFocused(Value: Boolean);

  public
    { Public declarations }

                 
  //  property NumberOne : Integer read GetNumberOne; // this is the First Number if Numbers = Two; Or the Number if  Numbers = One;
 //   property NumberTwo : Integer read GetNumberTwo; // this is the Second Number if Numbers = Two; or Nothing if Numbers = One;

    property NumberOne   : Integer  read FNumberOne write SetNumberOne;
    property NumberTwo   : Integer  read FNumberTwo write SetNumberTwo;
    procedure SetNumbersOneTwo(NumbOne,NumbTwo : Integer);
    property NumberFloat : Extended read FNumberFloat write SetNumberFloat;
    {the above 4 proc SetNumberOne, SetNumberTwo, SetNumbersOneTwo, SetNumberFloat
     were updated on Sept 9, 2016 to limit Numbers to Min and Max xrange }
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure DoReturn;
    procedure SetCustomDigits(const UseCustomSetOfDigits : Boolean;
                              const CustomSetOfDigits : TDigits);

  published
    { Published declarations }
    // TEdit original

    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
//    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
//    property Font;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;

    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

// Fin TEdit
    property HideText       : boolean       read FHideText      write SetHideText default True;
    property Alignment      : TAlignment    read FAlignment     write SetAlignment default taLeftJustify;
    property ColorOnFocus   : TColor        read FColorOnFocus  write SetColorOnFocus;
    property ColorOnNoFocus : TColor        read FColorOnNoFocus write SetColorOnNoFocus;
    property ExitOnReturn   : boolean       read FExitOnReturn  write SetExitOnReturn default True;
    property FontOnFocus    : TFont         read FFontOnFocus   write SetFontOnFocus;
    property FontOnNoFocus  : TFont         read FFontOnNoFocus write SetFontOnNoFocus;

    property Min            : Extended         read FMin           write SetMin;
    property Max            : Extended         read FMax           write SetMax;
    property Delta          : Integer          read FDelta         write SetDelta;
    property NumberKind     : TNumberKind      read FNumberKind    write SetNumberKind default Integers;
    property Numbers        : TNumbers         read FNumbers       write SetNumbers default One;
    property NumbersAllowed : TNumbersAllowed  read FNumbersAllowed write SetNumbersAllowed default All;
    property SeparatorKind  : TSeparatorKind   read FSeparatorKind write SetSeparatorKind default Dash;
    property ExitKind       : TExitKind        read FExitKind      write SetExitKind default MakeInactive;
    property WaitTime       : Cardinal         read FWaitTime      write SetWaitTime;
    property Precision      : Integer          read FPrecision     write SetPrecision;
    property OnReturnPressed : TNotifyEvent    read FOnReturnPressed write FOnReturnPressed;

  end;

procedure Register;

implementation
////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Standard', [TEditNumerical]);
end;
////////////////////////////////////////////////////////////////////////////
constructor TEditNumerical.Create(AOwner: TComponent);
begin

     inherited Create(AOwner);

     FColorOnFocus   := $00C4FFFF;
     FColorOnNoFocus := $00FFE4CA;
     Color           := FColorOnNoFocus;
     FFontOnFocus    := TFont.Create;
     FFontOnNoFocus  := TFont.Create;
     FFontOnNoFocus.OnChange := FontChanged;
     FAlignment      := taLeftJustify;
     FExitOnReturn   := True;
     FHideText       := True;
     FNumbers        := One;
     FNumberKind     := Integers;
     FSeparatorKind  := Dash;
     FSeparator      := '-';
     
     FMin         := 0;
     FMax         := 100;
     FNumberOne   := 0;
     FNumberTwo   := 100;
     FNumberFloat := 0;
     Returned     := False;
     FNumbersAllowed := All;
     UseCustomDigits := False;
     CustomDigits := []; //empty set
     Digits       := [FSeparator] + AllDigits;
   
     if Not(csDesigning in ComponentState) then begin //try
      ThrTimer := TThreadedTimer.Create(Self);
      ThrTimer.Enabled := False;
      ThrTimer.OnTimer := Timer;  // Assign our own Timer event handler to the Timer OnTimer event
      ThrTimer.Interval := 100;
      TimeElapsed := 0;
    end;

     FWaitTime := 5000; //miliseconds    

     //alternative
     {
     if not (csDesigning in ComponentState) then
	   try
      ThrTimer := TThreadedTimer.Create(Self);
      ThrTimer.Enabled := False;
      ThrTimer.OnTimer := Timer;  // Assign our own Timer event handler to the Timer OnTimer event
      ThrTimer.Interval := 100;
      TimeElapsed := 0;
     except
		 FreeAndNil(FTimer);
     end;
     }


end;
 ////////////////////////////////////////////////////////////////////////////
destructor TEditNumerical.Destroy;
begin
     FreeAndNil(FFontOnFocus);
     FreeAndNil(FFontOnNoFocus);
     FreeAndNil(ThrTimer);
     inherited Destroy;
end;
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TEditNumerical.CreateParams(var Params: TCreateParams);

const Alignments: array[TAlignment] of DWORD = (ES_LEFT,ES_RIGHT,ES_CENTER);

begin
     inherited CreateParams(Params);
     Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TEditNumerical.SetAlignment(Value: TAlignment);
begin
     if FAlignment <> Value then
     begin
          FAlignment := Value;
          Invalidate;
     end;
end;

procedure TEditNumerical.SetColorOnFocus(Value: TColor);
begin
     if not (csDesigning in ComponentState) and FFocused then
        Color := value;
        FColorOnFocus := value;
end;

procedure TEditNumerical.SetColorOnNoFocus(Value: TColor);
begin
     Color := value;
     FColorOnNoFocus := value;
end;

procedure TEditNumerical.SetFontOnFocus(Value: TFont);
begin
     if not (csDesigning in ComponentState) and FFocused then
        Font.Assign(value);
        FFontOnFocus.Assign(Value);
end;

procedure TEditNumerical.SetFontOnNoFocus(Value: TFont);
begin
     Font.Assign(Value);
     FFontOnNoFocus.Assign(Value);
end;

procedure TEditNumerical.FontChanged(Sender: TObject);
begin
     Font.Assign(FFontOnNoFocus);
end;


//////////////////////////////////////////////////////////////////////////
procedure TEditNumerical.SetNumberKind(Value: TNumberKind);
begin
  if (FNumberKind <> Value) and Not((Value = Floats) and (FNumbers = Two)) then begin
     FNumberKind := Value;
     SetDigits;
  end;
End;

procedure TEditNumerical.SetNumbersAllowed(Value: TNumbersAllowed);
begin
  if (FNumbersAllowed <> Value) then begin
     FNumbersAllowed := Value;
     SetDigits;
  end;
End;

procedure TEditNumerical.SetCustomDigits(const UseCustomSetOfDigits : Boolean;
                                         const CustomSetOfDigits : TDigits);

begin

  UseCustomDigits := UseCustomSetOfDigits;
  CustomDigits    := CustomSetOfDigits;

  SetDigits;

end;


procedure TEditNumerical.SetDigits;
begin

 if not(UseCustomDigits) then begin
   if (FNumbersAllowed = All)  then Digits  := AllDigits else
   if (FNumbersAllowed = EvenNr) then Digits  := EvenDigits else
   if (FNumbersAllowed = OddNr)  then Digits  := OddDigits;
 end else
   Digits := CustomDigits;

   if (FNumberKind = Floats)   then Digits  := ['.'] + Digits;
   Digits := ['-'] + Digits;

   if (SeparatorKind = Multiplication) and (Numbers = Two) then Digits := Digits + [FSeparator];
   //if SepatatorKind = Dash we already have always - used as minus

end;

procedure TEditNumerical.SetNumbers(Value : TNumbers);
begin
    if FNumbers <> Value then begin
      FNumbers := Value;
      if (Value = One) and (FSeparatorKind = Multiplication) then
        SetSeparatorKind(Dash);
      if (Value = Two) and (FNumberKind = Floats) then SetNumberKind(Integers);
    end;
end;

procedure TEditNumerical.SetSeparatorKind(Value : TSeparatorKind);
begin
    if FSeparatorKind <> Value then begin
      FSeparatorKind := Value;
      if FSeparatorKind = Dash           then FSeparator := '-' else
      if FSeparatorKind = Multiplication then FSeparator := 'x';
      SetDigits; // must be updated here as well
    end;
end;


procedure TEditNumerical.SetExitKind(Value : TExitKind);
begin
    if FExitKind <> Value then FExitKind := Value;

end;


procedure TEditNumerical.SetMin(Value : Extended);
begin
    if FMin <> value then FMin := Value;
end;

procedure TEditNumerical.SetMax(Value : Extended);
begin
    if FMax <> value then FMax := Value;
end;

procedure TEditNumerical.SetNumberOne(Value : Integer);
begin
    if (FNumberOne <> Value) then begin
      if (Value < FMin) then FNumberOne := Trunc(FMin)
        else
      if (Value > FMax) then FNumberOne := Trunc(FMax)
        else
      FNumberOne := Value;
    end;

    if Not(FHideText) then Text := IntToStr(FNumberOne);
end;

procedure TEditNumerical.SetNumberTwo(Value : Integer);
begin

    if (FNumberTwo <> Value) then begin
      if (Value < FMin) then FNumberTwo := Trunc(FMin)
        else
      if (Value > FMax) then FNumberTwo := Trunc(FMax)
        else
      FNumberTwo := Value;
    end;
    if Not(FHideText) then Text := IntToStr(FNumberOne) + FSeparator + IntToStr(FNumberTwo);
end;

procedure TEditNumerical.SetNumbersOneTwo(NumbOne,NumbTwo : Integer);
begin

   if (FNumberOne <> NumbOne) then begin
      if (NumbOne < FMin) then FNumberOne := Trunc(FMin)
        else
      if (NumbOne > FMax) then FNumberOne := Trunc(FMax)
        else
      FNumberOne := NumbOne;
    end;

    if (FNumberTwo <> NumbTwo) then begin
      if (NumbTwo < FMin) then FNumberTwo := Trunc(FMin)
        else
      if (NumbTwo > FMax) then FNumberTwo := Trunc(FMax)
        else
      FNumberTwo := NumbTwo;
    end;

   if Not(FHideText) then Text := IntToStr(FNumberOne) + FSeparator + IntToStr(FNumberTwo);
end;

procedure TEditNumerical.SetNumberFloat(Value : extended);
begin

  if (FNumberFloat <> Value) then begin
      if (Value < FMin) then FNumberFloat := FMin
        else
      if (Value > FMax) then FNumberFloat := FMax
        else
      FNumberFloat := Value;
  end;

  if Not(FHideText) then
  Text := FloatToStrF(FNumberFloat,ffFixed,MaxLength,Precision);
end;

procedure TEditNumerical.SetHideText(Value : Boolean);
begin
  if FHideText <> Value then FHideText := Value;
  if (FHideText) then Text := '';
end;


procedure TEditNumerical.SetDelta(Value : Integer);

begin
  if (Value <> FDelta) then FDelta := Value;
end;

procedure TEditNumerical.SetPrecision(Value : Integer);
begin
  if Value <> FPrecision then FPrecision := Value;
end;


procedure TEditNumerical.DoEnter;
begin
     SetColorOnFocus(FColorOnFocus);
     SetFontOnFocus(FFontOnFocus);
     TextMem := Text;
     if (FExitOnReturn) then begin
      TimeElapsed := 0;
      ThrTimer.Enabled := True;
     end;
     inherited;

end;

procedure TEditNumerical.DoExit;
begin
     SetColorOnNoFocus(FColorOnNoFocus);
     SetFontOnNoFocus(FFontOnNoFocus);
     if Not(Returned) then Text := TextMem;
     Returned := False;
     if (FExitOnReturn) then ThrTimer.Enabled := False;
     inherited;
end;

procedure TEditNumerical.Timer(Sender : TObject);
begin

  Inc(TimeElapsed,ThrTimer.Interval);
  If TimeElapsed > FWaitTime then Begin
    if (FExitOnReturn) then begin
      if ExitKind = MakeInactive then with Owner as TForm do ActiveControl:= nil else
      if ExitKind = MakeTab      then PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
          //Should be another VCL to accept Focus when TAB is emulated
    end; 
  End;

End;

procedure TEditNumerical.SetWaitTime(Value : Cardinal);
begin
  if Value <> FWaitTime then FWaitTime := Value;

end;



procedure TEditNumerical.ReturnPressed;

begin

  if Enabled then if Assigned(FOnReturnPressed) then FOnReturnPressed(Self);

end;


/////////////////////////////////////////////////////////////////////
procedure TEditNumerical.DoReturn;
begin
      Returned := True;
      SetValues;
      ReturnPressed;
      if (FExitOnReturn) then begin
          if ExitKind = MakeInactive then with Owner as TForm do ActiveControl:= nil else
          if ExitKind = MakeTab      then PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
          //Should be another VCL to accept Focus when TAB is emulated
      end;
end;                                     

procedure TEditNumerical.DblClick;
begin

  DoReturn;
  inherited;
  
end;

procedure TEditNumerical.KeyDown(var Key: Word; Shift: TShiftState);
begin

     if (Key = VK_RETURN) then begin
      DoReturn;
     end else
     if (key = VK_ESCAPE) then begin    
      if Not(FExitOnReturn) then Text := TextMem;
        if (FExitOnReturn) then begin
          if ExitKind = MakeInactive then with Owner as TForm do ActiveControl:= nil else
          if ExitKind = MakeTab      then PostMessage(Handle, WM_KEYDOWN, VK_TAB, 0);
          //Should be another VCL to accept Focus when TAB is emulated
        end;
     end;

     inherited KeyDown(key,Shift);

end;


procedure TEditNumerical.SetValues;
var  Pos,i  : Integer;

begin

   If (Length(Text) >= 1) and Not((Text = '.') or (Text = FSeparator)) Then Begin

      If FNumbers = One then Begin
      
        if FNumberKind = Integers then begin
          FNumberOne      := StrToInt(Text);
          if FNumberOne < FMin then FNumberOne := Round(FMin);
          if FNumberOne > FMax then FNumberOne := Round(FMax);
          Text := IntToStr(FNumberOne); //removes leading zeroes
        end else
        if FNumberKind = Floats then begin
          FNumberFloat := StrToFloat(Text);
          if FNumberFloat < FMin then begin
            Text := FloatToStrF(FMin,ffFixed,MaxLength,Precision);
            FNumberFloat := FMin;
          end;
          if FNumberFloat > FMax then begin
            Text := FloatToStrF(FMax,ffFixed,MaxLength,Precision);
            FNumberFloat := FMax;
          end;

          if FNumberFloat = 0 then Text := '0';
          if Text[1] = '.' then Text := '0' + Text;
          //removes leading zeroes
          if Length(Text) > 1 then begin

            if (Text[1] = FSeparator) and (Text[2] = '.') then
              Text := '0' + Copy(Text,2,Length(Text) - 1);

            if (Text[1] = '0') and (Text[2] = '0') then begin
              Pos := 1;
              while Text[Pos] = '0' do begin
                if Text[Pos] <> '0' then Break else
                if Text[Pos] =  '0' then Inc(Pos);
              end; //while
              Dec(Pos);
              Text := Copy(Text,Pos,Length(Text)- Pos + 1);
            end; // if Text[1] = '0'
           end; //if Length(Text) > 1
           if (FPrecision > 0) then begin //puts Dec Point and Zeroes
              if AnsiPos('.',Text) = 0 then Text := Text + '.';
              if (Text[Length(Text)] =  '.') then begin
                  Pos := FPrecision; //must be simple local variable
                  for i  := 1 to Pos do Text := Text + '0';
              end;
           end; // if (FPrecision > 0)

        end; //if FNumberKind = Floats

        TextMem := Text;
      End Else
      
      If FNumbers = Two then Begin

        Pos := AnsiPos(FSeparator,Text);

        If (Pos > 1) and (Length(Text) > Pos) Then Begin  //  FSeparator found in Text
          FNumberOne := StrToInt(Copy(Text,1,Pos - 1));
          FNumberTwo := StrToInt(Copy(Text,Pos + 1,Length(Text)));

          if (FNumberOne < FMin) or (FNumberOne > FNumberTwo - Delta) then begin
            if FNumberOne > FNumberTwo - Delta then FNumberOne := FNumberTwo - Delta;
             if FNumberOne < FMin then FNumberOne := Round(FMin);
          end;
          if (FNumberTwo > FMax) or (FNumberTwo < FNumberOne + Delta) then begin
            if FNumberTwo < FNumberOne + Delta then FNumberTwo := FNumberOne + Delta;
            if FNumberTwo > FMax then FNumberTwo := Round(FMax);
          end;
          Text := IntToStr(FNumberOne) + FSeparator + IntToStr(FNumberTwo);
          TextMem := Text;  //removes leading zeroes
        End Else // If Pos > 0
        If (Pos <= 1) or (Length(Text) = Pos) then Text := TextMem;
      End; //If Numbers = Two
      
   End Else Begin
     {-------------------------------------------------------------}
   If TextMem <> '' then Text := TextMem  //if Text was filled budeleted and Enter Pressed
   else begin //This is to Avoid Error  If When Created Text Was  Left Empty
     if FNumbers = One then begin
        if FNumberKind = Integers then Begin
          Text := IntToStr(Round(FMin));
          FNumberOne := Round(FMin);
        end else
        if FNumberKind = Floats then begin
          Text := FloatToStrF(FMin,ffFixed,MaxLength,Precision);
          FNumberFloat := FMin;
        end
      end else
      if FNumbers = Two then begin
        Text := IntToStr(Round(FMin)) + FSeparator + IntToStr(Round(FMax));
        FNumberOne := Round(FMin);
        FNumberTwo := Round(FMax);
      end;   
    end;
   End;
End;


procedure TEditNumerical.KeyPress(var Key: Char);
 var pos,mem : integer;
begin

     TimeElapsed := 0;

     if Not(CharInSet(Key,Digits)) and (Key <> Char(VK_BACK)) then Key := #0  //Allows Digits Only
     else begin

      if (Key = FSeparator) then begin  //Positive & Negative
        if FNumbers = One then begin
          if (Length(Text) >= 1) then begin
           if (Text[1] = FSeparator) then Key := #0 else SelStart := 0;
          end;
        end else
        if FNumbers = Two then begin   //Positive Integer Only
          mem := 0;
          for pos := 1 to Length(Text) do begin
            if (mem = 0) and (Text[pos] = FSeparator) then mem := 1;
            if (mem = 1) and (Text[pos] = FSeparator) then begin
              Key := #0;
              Break;
            end;
          end;  //for
        end;

      end;  //if (Key = Char(FSeparator))
      
      if FNumberKind = Floats then begin

        if Key = Char('.') then begin
          mem := 0;
          for pos := 1 to Length(Text) do begin
            if (mem = 0) and (Text[pos] = '.') then mem := 1;
            if (mem = 1) and (Text[pos] = '.') then begin
              Key := #0;
              Break;
            end;
          end;  //for
        end;  //if Key = Char('.')

        if (FPrecision > 0) and (Key <> Char('.')) and (Key <> Char(VK_BACK)) then begin
          Pos := AnsiPos('.',Text);
          if (Pos > 0) then if
            (Length(Text) - Pos = FPrecision) and (SelLength = 0) then Key := #0;

        end;

      end; // if FKind = Floats then

      
     end; //else

     inherited KeyPress(key);

     
end;

procedure TEditNumerical.KeyUp(var Key: Word; Shift: TShiftState);

begin
    if (Key = Ord(FSeparator) {this is '-' or 'x'}) and (FNumbers = Two)  then begin
      if Text[1] = FSeparator then Text := Copy(Text,2,Length(Text)-1);
    end;
    inherited  KeyUp(key,Shift);
end;

procedure TEditNumerical.SetFocused(Value: Boolean);
begin
     if FFocused <> Value then
     begin
          FFocused := Value;
          if (FAlignment <> taLeftJustify) then
             Invalidate;
   end;

end;

procedure TEditNumerical.CMEnter(var Message: TCMEnter);
begin
     SetFocused(True);
     if AutoSelect and not (csLButtonDown in ControlState) then
        SetFocus;    //SelectAll;   // Disabled by me because is Ugly; I use SetFocus instead
     inherited;   
end;

procedure TEditNumerical.CMExit(var Message: TCMExit);
begin
     SetFocused(false);
     DoExit;
end;


procedure TEditNumerical.SetExitOnReturn(Value: Boolean);
begin

     if FExitOnReturn <> Value then
     begin
      RecreateWnd;
      FExitOnReturn := Value;
     end;

end;



END.
