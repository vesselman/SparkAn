{$D-,L-,O+,Q-,R-,Y-,S-}
unit unAverIm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, Vcl.Graphics,Vcl.Controls, Vcl.ExtCtrls;

type
  TfrmAverIm = class(TForm)
    winAverImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure winAverImageMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure winAverImageMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure winAverImageMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    CntFh        : integer;
    RedrawMainIm : Boolean;
    RedrawRestOfWindows : Byte; // 0 = Do not redrow, 1 = Redraw Merge Window, 2 Redraw Merge and Secondary windows
  public
    { Public declarations }
  end;

var
  frmAverIm: TfrmAverIm;

Implementation

Uses  unGlobUnit, unMainWindow, unImageControl, unTimeSerAnal,
      unSparkTable, unWaveTable, unPlayBack, unFrameTimSerPlot, un3DImageWin,
      unMergeWindow, unXYprofile, un2ndWin;
      
{$R *.dfm}

procedure TfrmAverIm.FormCreate(Sender: TObject);

  begin

   frmAverIm.DoubleBuffered := True;
   frmAverIm.Position := poScreenCenter;


  If (MainImLoaded = True) and (NrIm > 1) then begin

    SetFormSize(frmAverIm,winAverImage);

    if (frmImageControl.Select.Down)               then Cursor := crArrow else
    if (frmImageControl.PlaceMark.Down)            then Cursor := crCross else
    if (frmImageControl.PutBox.Down)               then Cursor := crCross else
    if (frmImageControl.Freehand.Down)             then Cursor := crArrow else
    if (frmImageControl.SelectionFrameChange.Down) then Cursor := crArrow;
    winAverImage.Canvas.Pen.Mode    := pmCopy;
    winAverImage.Canvas.Pen.Width   := ROIvar.TckNess;
  End {If (MainImLoaded = True) and (NrIm > 1)}
  Else Begin    {Nothing was loaded yet}
   frmAverIm.ClientWidth := 256;
   frmAverIm.ClientHeight := 256;
   winAverImage.Picture.Bitmap.Width := 256;  {keep this}
   winAverImage.Picture.Bitmap.Height := 256; {keep this}
  End;

 frmImageControl.bnTransp.Enabled := True;
End;
{********************************************************}
procedure TfrmAverIm.FormShow(Sender: TObject);
begin

      with frmAverIm.winAverImage do begin

        if  (AvImExists = NO_AVERAGE) then Begin
          Canvas.Brush.Color := clBlack;
          Canvas.FillRect(Canvas.ClipRect);
          Canvas.Brush.Style := bsClear;
          frmAverIm.Caption := 'No Average';
        end else
        if  (AvImExists > 0) then begin
          UpdateAverImage(True);
          
          if AvImExists = AVER_ON_LINE then Caption := 'Average Image on Line' else
          if AvImExists = AVER_FROM_FILE then Caption := 'Average from File:  ' + ExtractFileName(AvImFPath) else
          if AvImExists = AVER_FROM_JUST_GEN then Caption := 'Generated Average Image';
        end; {if  AvImExists > 0}
      end;
end; {procedure TfrmAverIm.FormShow}
{********************************************************}

procedure TfrmAverIm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action    := caFree;
      frmAverIm := nil;
      frmImageControl.bnTransp.Down := False;
      frmImageControl.bnTranspClick(Sender);
      frmImageControl.bnTransp.Enabled := False;   
     
End;
{********************************************************}

Procedure   TfrmAverIm.winAverImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

Var
    i,R,bXs,bYs,SearchFor,CntX,CntY : integer;
    CursorClipArea: TRect;
    KindROI       : Integer; {1 = Box; 2 = Future Circle; 3 = Free Hand; 4 is used By Marks}
    MeanFh        : Double;
    MeanAver      : Double;
    NrElem        : Integer;
    Lab           : String;
    Xm,Ym         : integer;
    XLL,Xrr,Yupp,Ydd : Integer;
    PutBox        : Byte;
    {Marks Var}
    InSmMark      : Boolean;
    InBigMark     : Boolean;
    Mpos          : Integer; {Mark Pos}
    DelRow        : Integer; {Row to be Deleted }
    TpTem         : array of TPoint;
    Pt            : TPoint;
    MouseMov      : TMouseMoveEvent;
    {BoxCoor[1] = Xleft; [2] = Yup; [3] = Xr  [4] = Ydown }
   {The Way it Calculates them Makes Lines to be Drown by One Pixel MORE}
    {SearchFor : 1=Box,2= Circle,3 = Free Hand, 4 = All of them}
Begin

IF (AvImExists > 0) and (AnalInAction = False) THEN BEGIN {For All}
{---------------------------------------------------------------------------}
        RedrawMainIm := False;
{-----------------------------------------------------------------------------}

 If  not(XYprofileRectVisible) Then Begin

   {----------------- Measure Distance ------------------------}
  If  (frmImageControl.MeasureDistance.Down = true) and (button = mbLeft) and
      (DiamMesRect.OpCode <> IN_TRACKING) Then Begin
       //Restrict Cursor
    CursorClipArea := Bounds(winAverImage.ClientOrigin.X,
                             winAverImage.ClientOrigin.Y,
                             winAverImage.Width,winAverImage.Height);
      ClipCursor(@CursorClipArea);
     With MesLine Do Begin

      If (OpCode = NOT_EXIST) Then Begin
        Application.ProcessMessages;
        MesLine.OpCode := IN_DRAWING;
        LineBeg.X := X;
        LineBeg.Y := Y;
        memBMP.Assign(winAverImage.Picture.Bitmap);

        if Zoom = 1 then
        frmPlayback.lblROIval.Caption :=
        FloatToStrF(GetDistance(LineBeg.X,LineBeg.Y,X,Y),ffFixed,5,2)+ ' µ (' +
        IntToStr(GetDistancePix(LineBeg.X,LineBeg.Y,X,Y)) + ' pix)'
        else
        if Zoom = 2 then
        frmPlayback.lblROIval.Caption :=
        FloatToStrF(GetDistance(LineBeg.X shr Zm,LineBeg.Y shr Zm,X shr Zm,Y shr Zm),ffFixed,5,2)+ ' µ (' +
        IntToStr(GetDistancePix(LineBeg.X shr Zm,LineBeg.Y shr Zm,X shr Zm,Y shr Zm))+ ' pix )'
        else
        if Zoom = -2 then
        frmPlayback.lblROIval.Caption :=
        FloatToStrF(GetDistance(LineBeg.X shl Zm,LineBeg.Y shl Zm,X shl Zm,Y shl Zm),ffFixed,5,2)+ ' µ (' +
        IntToStr(GetDistancePix(LineBeg.X shl Zm,LineBeg.Y shl Zm,X shl Zm,Y shl Zm))+ ' pix )';

      End Else
      If (OpCode in [MIDDLE_SEL ,BEG_SEL,END_SEL]) Then Begin
        //Converts Real Coordinas to Current Image Coordinates
        if (Zoom = 2) then begin
          LineBeg.X := LineBeg.X shl Zm;
          LineBeg.Y := LineBeg.Y shl Zm;
          LineEnd.X := LineEnd.X shl Zm;
          LineEnd.Y := LineEnd.Y shl Zm;
        end else
        if (Zoom = -2) then begin
          LineBeg.X := LineBeg.X shr Zm;
          LineBeg.Y := LineBeg.Y shr Zm;
          LineEnd.X := LineEnd.X shr Zm;
          LineEnd.Y := LineEnd.Y shr Zm;
        end;
        UpdateAverImage(True);
        memBMP.Assign(winAverImage.Picture.Bitmap); {Saves to Bitmap }

      If (OpCode =  MIDDLE_SEL) Then Begin
        OpCode := IN_MOVING;
        Pr.X := X;
        Pr.Y := Y;
        DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,winAverImage.Canvas);
      End Else
      If (MesLine.OpCode in [BEG_SEL,END_SEL]) Then Begin
        if (MesLine.OpCode = BEG_SEL) then begin
          //Swaps Beg with End
          i := LineBeg.X;
          LineBeg.X := LineEnd.X;
          LineEnd.X := i;
          i := LineBeg.Y;
          LineBeg.Y := LineEnd.Y;
          LineEnd.Y := i;
         end;
          //sets Mouse Cursor to Mes Line End Point
          Pt := ClientToScreen(Point(winAverImage.Left+LineEnd.X, winAverImage.Top+LineEnd.Y));
          MouseMov := winAverImage.OnMouseMove;
          winAverImage.OnMouseMove := nil;

          SetCursorPos(Pt.X,Pt.Y);
          Application.ProcessMessages;
          winAverImage.OnMouseMove := MouseMov;
          MesLine.OpCode := IN_DRAWING;
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,winAverImage.Canvas);
      End; //If (MesLine.OpCode in [LINE_SEL_BEG,LINE_SEL_END]) Then Begin

      if Zoom = 1 then
      frmPlayback.lblROIval.Caption :=
      FloatToStrF(GetDistance(LineBeg.X,LineBeg.Y,X,Y),ffFixed,5,2)+ ' µ (' +
      IntToStr(GetDistancePix(LineBeg.X,LineBeg.Y,X,Y)) + ' pix)'
      else
      if Zoom = 2 then
      frmPlayback.lblROIval.Caption :=
      FloatToStrF(GetDistance(LineBeg.X shr Zm,LineBeg.Y shr Zm,X shr Zm,Y shr Zm),ffFixed,5,2)+ ' µ (' +
      IntToStr(GetDistancePix(LineBeg.X shr Zm,LineBeg.Y shr Zm,X shr Zm,Y shr Zm))+ ' pix )'
      else
      if Zoom = -2 then
      frmPlayback.lblROIval.Caption :=
      FloatToStrF(GetDistance(LineBeg.X shl Zm,LineBeg.Y shl Zm,X shl Zm,Y shl Zm),ffFixed,5,2)+ ' µ (' +
      IntToStr(GetDistancePix(LineBeg.X shl Zm,LineBeg.Y shl Zm,X shl Zm,Y shl Zm))+ ' pix )';
      End; //If (MesLine.OpCode in [LINE_SEL_MIDDLE,LINE_SEL_BEG,LINE_SEL_END]) Then Begin

     End; // With
  End

    Else

  {----------------------- Selection Frame ----------------------------}
  If  (frmImageControl.SelectionFrameChange.Down = True) and (button = mbLeft) and
      (SelFrameMove <> NO_MOVE) Then Begin

    // Xm,Ym are used for Marks but here are used to store scaled X and Y
    if (Zoom = 1) then begin
      Xm := X;
      Ym := Y;
    end else
    if (Zoom = 2) then begin
      Xm := X shr Zm;
      Ym := Y shr Zm;;
    end else
    if (Zoom = -2) then begin
      Xm := X shl Zm;
      Ym := Y shl Zm;
    end;


    SelRectMem.Left   := SelFrame.Left   - Xm;
    SelRectMem.Right  := SelFrame.Right  - Xm;
    SelRectMem.Top    := SelFrame.Top    - Ym;
    SelRectMem.Bottom := SelFrame.Bottom - Ym;

    SelFrameVisible := False;
    UpdateAverImage(True);
    memBMP.Assign(winAverImage.Picture.Bitmap);
    SelFrameVisible := True;
    DrawSelFrame(winAverImage.Canvas);

    CursorClipArea := Bounds(winAverImage.ClientOrigin.X,
                             winAverImage.ClientOrigin.Y,
                             winAverImage.Width,winAverImage.Height);
    ClipCursor(@CursorClipArea);

  End;


  {---------------------Select Button -----------------------------------------}
  If (frmImageControl.Select.Down) Then Begin {Select Button}
    If (ROIvar.ROIonAverWin) Then Begin

     if (ROIvar.NrROI > 0) Then
      SearchFor := 4; {Search for all kinds of ROI}
      if Zoom = 1 then CheckIfInROI(X, Y,SearchFor) else
      if Zoom = 2 then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
      if Zoom =-2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);

    If (InROI = True) Then Begin {thats Requirement Fol Select Button Functions}

    If (button = mbLeft) then Begin

      If (ROIvar.ROIAdr[CurROIadr] in [1,3]) then Begin
        if ROIvar.TickLine > 0 then begin
         ROIvar.TickLine := -1;
         frmTimeSerPlot.RePlot(Sender);
        end; {if ROIvar.TickLine > 0 then begin}
        if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;
        if Zoom = 1 then begin
        Pr.X := X;
        Pr.Y := Y;
        end else
        if Zoom = 2 then begin
        Pr.X := X shr Zm;
        Pr.Y := Y shr Zm;
        end else
        if Zoom = -2 then begin
        Pr.X := X shl Zm;
        Pr.Y := Y shl Zm;
        end;

        KindROI := ROIvar.ROIAdr[CurROIadr]; {new} {Saves Type of ROI selected}
        ROIvar.ROIAdr[CurROIadr] := -ROIvar.ROIAdr[CurROIadr]; {negates to mem but not to be drawn}
        UpdateAverImage(True);

        memBMP.Assign(winAverImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}

        if ROIvar.UseMonoCol = false then
        winAverImage.Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
        else
        winAverImage.Canvas.Pen.Color := ROIvar.MonoCol;
        if KindROI = 1 then Begin
          XL  := ROIvar.ROICoor[1,CurROIadr];
          Yup := ROIvar.ROICoor[2,CurROIadr];
          Xr  := ROIvar.ROICoor[3,CurROIadr];
          Yd  := ROIvar.ROICoor[4,CurROIadr];
          winAverImage.Canvas.Pen.Width   := ROIvar.TckNess;

          if Zoom = 1 then
          winAverImage.
          Canvas.Rectangle(XL - ROIrct.LT,Yup - ROIrct.LT,
                           Xr + ROIrct.RB,Yd  + ROIrct.RB) else
          if Zoom = 2 then
          winAverImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
          if Zoom = -2 then
          winAverImage.
          Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                           XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                          Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

        end else
        if KindROI = 3 then Begin
           Yup := FhTbl[CurROIadr,0,0].Y;
           Yd  := FhTbl[CurROIadr,High(FhTbl[CurROIadr]),0].Y;
           Xl  := imXsize - 1;
           Xr  := 0;
           For CntY := 0 to High(FhTbl[CurROIadr]) do begin
            if Xl > FhTbl[CurROIadr,CntY,0].X then
               Xl := FhTbl[CurROIadr,CntY,0].X;
            if Xr < FhTbl[CurROIadr,CntY,High(FhTbl[CurROIadr,CntY])].X then
               Xr := FhTbl[CurROIadr,CntY,High(FhTbl[CurROIadr,CntY])].X;
           End; {For CntY := 0 to High(FhTbl[CurROIadr])}
           winAverImage.Canvas.Pen.Width   := ROIvar.FhTickness;

           if Zoom = 1 then
            winAverImage.Canvas.Polygon(FhPol[CurROIadr]) else
           if Zoom = 2 then begin
            SetLength(TpTem,Length(FhPol[CurROIadr]));
            i := 0;
            while i < Length(TpTem) do begin
              TpTem[i].X := FhPol[CurROIadr,i].X shl Zm;
              TpTem[i].Y := FhPol[CurROIadr,i].Y shl Zm;
              Inc(i);
            end;
              winAverImage.Canvas.Polygon(TpTem);
            end else {else if Zoom = 2 then begin}
            if Zoom = -2 then begin
            SetLength(TpTem,Length(FhPol[CurROIadr]));
            i := 0;
            while i < Length(TpTem) do begin
              TpTem[i].X := FhPol[CurROIadr,i].X shr Zm;
              TpTem[i].Y := FhPol[CurROIadr,i].Y shr Zm;
              Inc(i);
            end;
             winAverImage.Canvas.Polygon(TpTem);
            end {else if Zoom = -2 then begin}

        end; {if KindROI = 3 }

{----labels}
if ROIvar.UseROINr = True then
 with winAverImage.Canvas do begin
  Font.Name := 'Arial';
  Font.Size := 8;
  if ROIvar.UseMonoFontCol = False then
    Font.Color := ROIvar.ROICol[CurROIadr] else Font.Color := ROIvar.MonoFontCol;
    Lab := IntToStr(CurROIadr);
   if Zoom = 1 then begin
    if Yup - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yup - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yd  + 2, Lab);
   end else
   if Zoom = 2 then begin
    if Yup shl Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yup shl Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yd  shl Zm + 2, Lab);
   end else
   if Zoom = -2 then begin
    if Yup shr Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yup shr Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yd  shr Zm + 2, Lab);
   end;
end;
{--------}
      if KindROI = 1 then Begin
        MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
        frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,5,1);
      end else {If KindROI = 1) then Begin}
      if KindROI = 3 then
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnAverIm),ffFixed,5,1);
     End;
    End Else
    {---------------------------}
    If (button = mbMiddle) Then Begin
        i := CurROIadr;
        DeleteROI;
        UpdateAverImage(True);
        if (ROIvar.TickLine > 0) and (ROIvar.TickLine = i) then begin
          ROIvar.TickLine := 0;
          frmTimeSerPlot.RePlot(Sender);
        end;
        if (ROIvar.NrROI = 0) and  (PLOTvar.AllowFreezeMin) then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;

    End Else
    If (button = mbRight) Then Begin {makes Thick Line On Trace & ROI}
        if (ROIvar.TickLine <> CurROIadr) and (ROIvar.TickLine >= 0) then Begin
            ROIvar.TickLine := CurROIadr;
            UpdateAverImage(True);
            frmTimeSerPlot.RePlot(Sender);
        end else
        if (ROIvar.TickLine = CurROIadr) and (ROIvar.TickLine >= 0) then Begin

            ROIvar.TickLine := 0;
            UpdateAverImage(True);
            frmTimeSerPlot.RePlot(Sender);
        end;
   {always calculates Mean}
        If (ROIvar.ROIAdr[CurROIadr] = 1) Then Begin
          KindROI := 1;
          XL  := ROIvar.ROICoor[1,CurROIadr];
          Yup := ROIvar.ROICoor[2,CurROIadr];
          Xr  := ROIvar.ROICoor[3,CurROIadr];
          Yd  := ROIvar.ROICoor[4,CurROIadr];
         MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
         frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,7,3);

        End Else
        If (ROIvar.ROIAdr[CurROIadr] = 3) Then Begin
           frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnAverIm),ffFixed,7,3);
              {-- End of Calc Mean --- }
        End; {ROIvar.ROIAdr[CurROIadr] = 3)}
    End; {(button = mbRight)}
    End  // If (InROI = True)  Then Begin
  End //If (ROIvar.ROIonAverWin) Then Begin
   Else
  InROI := False;

     If (SizeBarVisible) and (InROI = False) and (button = mbLeft) Then Begin
      if (Zoom = 1) then CheckIfInScaleBar(X,Y,SizeBar,frmImageControl.ubSizeBar.Selected) else
      if (Zoom = 2) then CheckIfInScaleBar(X shr Zm,Y shr Zm,SizeBar,frmImageControl.ubSizeBar.Selected) else
      if (Zoom =-2) then CheckIfInScaleBar(X shl Zm,Y shl Zm,SizeBar,frmImageControl.ubSizeBar.Selected);

      If (InScaleBar) then Begin
        SizeBarVisible := False;//to prevent drawing SizeBar by UpdateMainImage
        UpdateAverImage(True);
        SizeBarVisible := True; //restores value
        memBMP.Assign(winAverImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}
        DrawScaleBar(Zoom,SizeBar,winAverImage.Canvas);
        if (Zoom = 1) then begin
          Pr.X := X;
          Pr.Y := Y;
        end
          else
        if (Zoom = 2) then begin
          Pr.X := X shr Zm;
          Pr.Y := Y shr Zm;
        end
          else
        if (Zoom = -2) then begin
          Pr.X := X shl Zm;
          Pr.Y := Y shl Zm;
        end;
      End;
     End;

    if (InROI) or (InScaleBar)        then RedrawMainIm := True else
    if not(InROI) and not(InScaleBar) then RedrawMainIm := False;

  End
     Else
  {---------------------------- Select All and Move ---------------------}
  If (frmImageControl.SelectLocked.Down = True) and (ROIvar.ROIonAverWin) Then Begin
    If (button = mbLeft) and (ROIvar.NrROI > 0) Then Begin
      SearchFor := 4; {Search for all kinds of ROI}
      if Zoom = 1  then CheckIfInROI(X ,Y,SearchFor) else
      if Zoom = 2  then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
      if Zoom = -2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);
      
      If (InROI = True)  Then Begin {thats Requirement Fol SelectLocked Button Functions}
        {Deletes Thick Line}
        if ROIvar.TickLine > 0 then begin
          ROIvar.TickLine := -1; {If something was thick deletes the address and sets it to -1 = Plot Not Done}
          frmTimeSerPlot.RePlot(Sender);
        end; {if ROIvar.TickLine > 0 then begin}
        if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;
      {1 st: Copies Mouse Coordinates}
        if Zoom = 1 then begin
        Pr.X := X;
        Pr.Y := Y;
        end else
        if Zoom = 2 then begin
        Pr.X := X shr Zm;
        Pr.Y := Y shr Zm;
        end else
        if Zoom = -2 then begin
        Pr.X := X shl Zm;
        Pr.Y := Y shl Zm;
        end;
      {2nd: Copies Bitmap with Image Only}
        UpdateAverImage(False);
        with winAverImage do begin
        Canvas.Pen.Mode    := pmCopy;
        Canvas.Brush.Style := bsClear;
        if (MesLine.OpCode = DO_EXIST) then with MesLine do
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,Canvas);
        if MarkPar.ShowSmEvOnAverWin then DrawAllSmallEvMarks(Canvas);
        if MarkPar.ShowBigEvOnAverWin then DrawAllBigEvMarks(Canvas);

        if (SizeBarVisible) then DrawScaleBar(Zoom,SizeBar,winAverImage.Canvas);

        end;//with
        memBMP.Assign(winAverImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}
       {end 2nd}
       {3rd: Finds Xl,XrYup,Yd for the All ROIs}
       XL  := imXsize;
       Xr  := 0;
       Yup := imYsize;
       Yd  := 0;
       For i := 1 to 20 Do Begin
        If (ROIvar.ROIAdr[i] = 1) Then Begin
          if XL  > ROIvar.ROICoor[1,i] then XL  := ROIvar.ROICoor[1,i];
          if Yup > ROIvar.ROICoor[2,i] then Yup := ROIvar.ROICoor[2,i];
          if Xr  < ROIvar.ROICoor[3,i] then Xr  := ROIvar.ROICoor[3,i];
          if Yd  < ROIvar.ROICoor[4,i] then Yd  := ROIvar.ROICoor[4,i];
        End else
        If (ROIvar.ROIAdr[i] = 3) Then Begin
          if Yup > FhTbl[i,0,0].Y then Yup := FhTbl[i,0,0].Y;
          if Yd  < FhTbl[i,High(FhTbl[i]),0].Y then Yd := FhTbl[i,High(FhTbl[i]),0].Y;
          For CntY := 0 to High(FhTbl[i]) do begin
            if Xl > FhTbl[i,CntY,0].X then
               Xl := FhTbl[i,CntY,0].X;
            if Xr < FhTbl[i,CntY,High(FhTbl[i,CntY])].X then
               Xr := FhTbl[i,CntY,High(FhTbl[i,CntY])].X;
           End; {For CntY := 0 to High(FhTbl[CurROIadr])}
        End;
       End;

       DrawROI(winAverImage.Canvas);

      End; {(InROI = True)}
      if (InROI = True) then RedrawMainIm := True else RedrawMainIm := False;
    End; {(button = mbLeft) and (ROIvar.NrROI > 0)}
  End {with Select Locked} Else

  {------------------------- Put Box  -------------------------------------}
  If  (frmImageControl.PutBox.Down = True) and (ROIvar.ROIonAverWin) and
      (frmImageControl.MeasureBox.Down = False) then Begin
      
    If (button = mbLeft) and (ROIvar.NrROI < 20) Then begin
      CurROIadr  := GetFirstFreeAddress;
      CurROIkind := 1;
      KindROI    := 1;
      Inc(ROIvar.NrROI);
      if Zoom = 1 then begin
        XL   :=  X - ROIrct.Xsize shr 1;
        Xr   :=  X + ROIrct.Xsize shr 1 - ROIrct.Rc;
        Yup  :=  Y - ROIrct.Ysize shr 1;
        Yd   :=  Y + ROIrct.Ysize shr 1 - ROIrct.Bc;
        end else
        if Zoom = 2 then begin
        XL   :=  X shr Zm - ROIrct.Xsize shr 1;
        Xr   :=  X shr Zm + ROIrct.Xsize shr 1 - ROIrct.Rc;
        Yup  :=  Y shr Zm - ROIrct.Ysize shr 1;
        Yd   :=  Y shr Zm + ROIrct.Ysize shr 1 - ROIrct.Bc;
        end else
        if Zoom = -2 then begin
        XL   :=  X shl Zm - ROIrct.Xsize shr 1;
        Xr   :=  X shl Zm + ROIrct.Xsize shr 1 - ROIrct.Rc;
        Yup  :=  Y shl Zm - ROIrct.Ysize shr 1;
        Yd   :=  Y shl Zm + ROIrct.Ysize shr 1 - ROIrct.Bc;
        end;
      KeepROIinWindow;
      with winAverImage do begin
      Canvas.Pen.Mode    := pmCopy;
      Canvas.Pen.Width   := ROIvar.TckNess;
      Canvas.Brush.Style := bsClear;
      memBMP.Assign(winAverImage.Picture.Bitmap);
      if ROIvar.UseMonoCol = false then
      Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
      else
      Canvas.Pen.Color := ROIvar.MonoCol;

      if Zoom = 1 then
        winAverImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then begin
         if Zm = 1 then
          winAverImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
         if Zm = 2 then
          winAverImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 3,Yd  shl Zm+ROIrct.RB + 3);
        end
           else
        if Zoom = -2 then
        winAverImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                        Yup shr Zm +(Yd-Yup+1) shr Zm-1+ROIrct.RB);

      end; {with}
 {----labels}
if ROIvar.UseROINr = True then
 with winAverImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[CurROIadr] else Font.Color := ROIvar.MonoFontCol;
          Lab := IntToStr(CurROIadr);
      if Zoom = 1 then begin
          if Yup - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yup - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yd + 2, Lab);
      end else
      if Zoom = 2 then begin
          if Yup shl Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yup shl Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yd  shl Zm + 2, Lab);
      end else
      if Zoom = -2 then begin
          if Yup shr Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yup shr Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yd  shr Zm + 2, Lab);
      end;
end;

        MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
        frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,5,1);
      if ROIvar.TickLine > 0 then begin
        ROIvar.TickLine := -1;
        frmTimeSerPlot.RePlot(Sender);
      end;
      if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
      end;
    End Else

    If (button = mbMiddle) and (ROIvar.NrROI > 0) Then Begin
        SearchFor := 1; {Search for all kinds of ROI}
        if Zoom = 1 then CheckIfInROI(X,Y,SearchFor) else
        if Zoom = 2 then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
        if Zoom =-2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);

      If (InROI = True)  Then Begin {thats Requirement Fol all}
        i := CurROIadr;
        DeleteROI;
        UpdateAverImage(True);
        if (ROIvar.TickLine > 0) and (ROIvar.TickLine = i) then begin
          ROIvar.TickLine := 0;
          frmTimeSerPlot.RePlot(Sender);
        end;
        if (ROIvar.NrROI = 0) and  (PLOTvar.AllowFreezeMin) then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;
      End; {(InROI = True)}

    End Else

    If (button = mbRight) and (ROIvar.NrROI > 0) Then Begin
       SearchFor := 1; {Search for all kinds of ROI}
       if Zoom = 1 then CheckIfInROI(X ,Y,SearchFor) else
       if Zoom = 2 then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
       if Zoom =-2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);

       If (InROI = True) Then Begin
        KindROI := 1;
        ROIvar.ROIAdr[CurROIadr] := 0; {so not to be drawn}
        UpdateAverImage(True);
        ROIvar.ROIAdr[CurROIadr] := 1;
        memBMP.Assign(winAverImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}

        if ROIvar.UseMonoCol = false then
        winAverImage.Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
        else
        winAverImage.Canvas.Pen.Color := ROIvar.MonoCol;
        winAverImage.Canvas.Pen.Width := ROIvar.TckNess;
        bXs  := ROIvar.ROICoor[3,CurROIadr] - ROIvar.ROICoor[1,CurROIadr] + 1;
        bYs  := ROIvar.ROICoor[4,CurROIadr] - ROIvar.ROICoor[2,CurROIadr] + 1;

        XL  := ROIvar.ROICoor[1,CurROIadr];
        Yup := ROIvar.ROICoor[2,CurROIadr];
        Xr  := ROIvar.ROICoor[3,CurROIadr];
        Yd  := ROIvar.ROICoor[4,CurROIadr];

        if Zoom = 1 then begin

        Xm := XL  + bXs shr 1;
        Ym := Yup + bYs shr 1;
        Pt := ClientToScreen(Point(winAverImage.Left+Xm, winAverImage.Top+Ym));
        MouseMov := winAverImage.OnMouseMove;
        winAverImage.OnMouseMove := nil;
        SetCursorPos(Pt.X,Pt.Y);
        winAverImage.OnMouseMove := MouseMov;

        winAverImage.
        Canvas.Rectangle(XL - ROIrct.LT,Yup - ROIrct.LT,
                         Xr + ROIrct.RB,Yd  + ROIrct.RB);
        end else
        if Zoom = 2 then begin
        Xm := XL  + bXs shr 1;
        Xm := Xm shl Zm;
        Ym := Yup + bYs shr 1;
        Ym := Ym shl Zm;
        Pt := ClientToScreen(Point(winAverImage.Left+Xm, winAverImage.Top+Ym));
        MouseMov := winAverImage.OnMouseMove;
        winAverImage.OnMouseMove := nil;
        SetCursorPos(Pt.X,Pt.Y);
        winAverImage.OnMouseMove := MouseMov;

        winAverImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1);
        end else
        if Zoom = -2 then begin
        Xm := XL  + bXs shr 1;
        Xm := Xm shr Zm;
        Ym := Yup + bYs shr 1;
        Ym := Ym shr Zm;
        //Sets the Coursor to ROI center
        Pt := ClientToScreen(Point(winAverImage.Left+Xm, winAverImage.Top+Ym));
        MouseMov := winAverImage.OnMouseMove;
        winAverImage.OnMouseMove := nil;
        SetCursorPos(Pt.X,Pt.Y);
        winAverImage.OnMouseMove := MouseMov;

        winAverImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                         Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

        end;

        {----labels}
if ROIvar.UseROINr = True then
 with winAverImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[CurROIadr] else Font.Color := ROIvar.MonoFontCol;
          Lab := IntToStr(CurROIadr);
        if Zoom = 1 then begin
          if Yup - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yup - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yd  + 2, Lab);
        end else
        if Zoom = 2 then begin
          if Yup shl Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yup shl Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yd  shl Zm + 2, Lab);
        end else
        if Zoom = -2 then begin
          if Yup shr Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yup shr Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yd  shr Zm + 2, Lab);
        end;
end; {with}      
{--------}

        MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
        frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,5,1);
        if ROIvar.TickLine > 0 then begin
          ROIvar.TickLine := -1;
          if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
          DrawTimeSerPlotTraces(Sender,TSPlotData_BaseSubtr) else
          DrawTimeSerPlotTraces(Sender,TSPlotData_BaseNotSubtr);
          DrawTimeSerPlotXaxes;
          DrawTimeSerPlotXticks;
          if frmTimeSerPlot.CheckBoxSymbolOn.Checked then begin
            DrawTimeSerPlotYaxes;
            DrawTimeSerPlotYticks;
          end;
          if (PLOTvar.AnalType = RATIO_TIME) and (frmTimeSerPlot.CheckBoxCursor.Checked = True) then DrawTimeSerPlotCursor;
          if frmTimeSerPlot.MeasTrace.Down then begin
           if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
            frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
            frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);
          end;
        end;
        if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;
      End; {If (InROI = True) Then Begin}
    End; {If (ssRight in Shift) and (ROIvar.NrROI > 0)}
    if (button = mbLeft) or (InROI = True) then RedrawMainIm := True else RedrawMainIm := False;
  End

    Else

  {---------------------- Free Hand -------------------------------------------}
  If  (frmImageControl.Freehand.Down = True) and (ROIvar.ROIonAverWin) Then Begin
    If (button = mbLeft) and (ROIvar.NrROI < 20) Then begin
       if ROIvar.TickLine > 0 then begin
        ROIvar.TickLine := -1;
        frmTimeSerPlot.RePlot(Sender);
       end;
       if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
       end;
      {---------------------------------}
       {Uses Windows API to restrict Cursor}
      CursorClipArea := Bounds(winAverImage.ClientOrigin.X,
                               winAverImage.ClientOrigin.Y,
                               winAverImage.Width,winAverImage.Height);
      ClipCursor(@CursorClipArea);
      {---------------------------------}


      CurROIadr  := GetFirstFreeAddress;
      CurROIkind := 3;     {3 is for Free Hand}
      Inc(ROIvar.NrROI);
      Pr.X := X;
      Pr.Y := Y;
      CntFh := 0;
      SetLength(Fh,1000);
      Fh[0] := Pr;     {Beginning (Start Point}

      winAverImage.Canvas.Brush.Style := bsClear;
      winAverImage.Canvas.Pen.Mode  := pmCopy;
      winAverImage.Canvas.Pen.Width := ROIvar.FhTickness;
      if ROIvar.UseMonoCol = false then
      winAverImage.Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
      else
      winAverImage.Canvas.Pen.Color := ROIvar.MonoCol;

    End Else

    If (button = mbMiddle) Then Begin
      SearchFor := 3; {Search for Free Hand}
      if Zoom = 1  then CheckIfInROI(X,Y,SearchFor) else
      if Zoom = 2  then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
      if Zoom =-2  then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);

      If (InROI = True)  Then Begin
      i := CurROIadr;
      DeleteROI;
      UpdateAverImage(True);
      winAverImage.Canvas.Brush.Style := bsClear;
      winAverImage.Canvas.Pen.Mode    := pmCopy;
      winAverImage.Canvas.Pen.Width   := ROIvar.FhTickness;
      if (ROIvar.TickLine > 0) and (ROIvar.TickLine = i) then begin
        ROIvar.TickLine := 0;
        frmTimeSerPlot.RePlot(Sender);
      end;
      if (ROIvar.NrROI = 0) and  (PLOTvar.AllowFreezeMin) then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
      end;
      End; //If (InROI = True)
      if (button = mbLeft) or (InROI = True) then RedrawMainIm := True else RedrawMainIm := False;
    End Else

    If (button = mbRight) and (ROIvar.NrROI > 0) Then Begin
        SearchFor := 3; {Search for all kinds of ROI}
        if Zoom = 1 then CheckIfInROI(X, Y, SearchFor) else
        if Zoom = 2 then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
        if Zoom =-2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);
        
     If (InROI = True)  Then Begin {thats Requirement Fol all}

      If (ROIvar.FillFh <> CurROIadr) then Begin
           if (ROIvar.FillFh > 0) and (ROIvar.NrROI > 1) then begin
            UpdateAverImage(True);
           end; {if (ROIvar.FillFh > 0) and (ROIvar.NrROI > 1)}

                 {------ Fills in ------}
              if Zoom = 1 then  Xm := 2 else
              if Zoom = 2 then  Xm := 1 else
              if Zoom =-2 then  Xm := 3;
          For CntY := 0 to High(FhTbl[CurROIadr]) Do Begin
           If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin
              CntX := 0;
            While CntX < High(FhTbl[CurROIadr,CntY]) Do Begin
              for i := 0 to (FhTbl[CurROIadr,CntY,CntX + 1].X - FhTbl[CurROIadr,CntY,CntX].X) do
                  if (i mod Xm = 0) and (CntY mod Xm = 0) then
               if Zoom = 1 then
               winAverImage.Canvas.
               Pixels[(FhTbl[CurROIadr,CntY,CntX].X + i),
                       FhTbl[CurROIadr,CntY,CntX].Y] := ROIvar.ROICol[CurROIadr] else
               if Zoom = 2 then
               winAverImage.Canvas.
               Pixels[(FhTbl[CurROIadr,CntY,CntX].X + i) shl Zm,
                       FhTbl[CurROIadr,CntY,CntX].Y shl Zm] := ROIvar.ROICol[CurROIadr] else
               if Zoom = -2 then
               winAverImage.Canvas.
               Pixels[(FhTbl[CurROIadr,CntY,CntX].X + i) shr Zm,
                       FhTbl[CurROIadr,CntY,CntX].Y shr Zm] := ROIvar.ROICol[CurROIadr];
                  Inc(CntX,2);
            End; {while}
           End Else {If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin}
           If (High(FhTbl[CurROIadr,CntY]) = 0) Then  {For a single Pixel}
              if Zoom = 1 then
              winAverImage.Canvas.
              Pixels[FhTbl[CurROIadr,CntY,0].X,
                     FhTbl[CurROIadr,CntY,0].Y]  := ROIvar.ROICol[CurROIadr] else
              if Zoom = 2 then
              winAverImage.Canvas.
              Pixels[FhTbl[CurROIadr,CntY,0].X shl Zm,
                     FhTbl[CurROIadr,CntY,0].Y shl Zm]  := ROIvar.ROICol[CurROIadr] else
              if Zoom = -2 then
              winAverImage.Canvas.
              Pixels[FhTbl[CurROIadr,CntY,0].X shr Zm,
                     FhTbl[CurROIadr,CntY,0].Y shr Zm]  := ROIvar.ROICol[CurROIadr];
          End; {For CntY := 0 to High(TabFh) do begin}
                  {--- End of Fill In ---}
          ROIvar.FillFh := CurROIadr;
        
        end else begin{if (ROIvar.FillFh <> CurROIadr)}
          ROIvar.FillFh := 0;
          UpdateAverImage(True);
        end; {if (ROIvar.FillFh > 0) and (ROIvar.NrROI > 1)}
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnAverIm),ffFixed,5,1);
        CurROIadr := 0;
        InROI := False;
      End; {(InROI = True)}
    End;  {(button = mbRight) and (ROIvar.NrROI > 0)}
  End; {If  (frmImageControl.Freehand.Down = True) Then Begin}
  {------------------------------------------}
End // If  not(XYprofileRectVisible)

 Else
 {-------------------------------------------------------------------------------}
If  (XYprofileRectVisible) and (button = mbLeft) Then Begin

    // Xm,Ym are used for Marks but here are used to store scaled X and Y
    if (Zoom = 1) then begin
      Xm := X;
      Ym := Y;
    end else
    if (Zoom = 2) then begin
      Xm := X shr Zm;
      Ym := Y shr Zm;;
    end else
    if (Zoom = -2) then begin
      Xm := X shl Zm;;
      Ym := Y shl Zm;;
    end;

    XYprofileRectMem.Left   := XYprofileRect.Left   - Xm;
    XYprofileRectMem.Right  := XYprofileRect.Right  - Xm;
    XYprofileRectMem.Top    := XYprofileRect.Top    - Ym;
    XYprofileRectMem.Bottom := XYprofileRect.Bottom - Ym;

    XYprofileRectVisible := False; //so UpdateMainImage Not to Draw SelFrame
    UpdateAverImage(True);
    memBMP.Assign(winAverImage.Picture.Bitmap); //Saves to Bitmap without Sel Box
    XYprofileRectVisible := True;
    DrawSelFrame(winAverImage.Canvas);

    RedrawMainIm := True;

  End;   //XY Profile

{--------------------------- End of All Modes of Analysisi--- }

     
End; {(AvImExists > 0)}
End; {Procedure TfrmAverIm.winAverImage.MouseDown}
{***************************************************************************}

Procedure TfrmAverIm.winAverImageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);

 Const Tol = 5;

 var
  KindROI,i : Integer;
  bXs,bYs,CntX,CntY   : Integer;
  MeanAver : Double;
  dY   : Boolean;
  dXpr, dYpr : integer;
  Lab : String;
  XLL,Xrr,Yupp,Ydd : integer;
  CanMoveX,CanMoveY : Boolean;
  TpTem : array of TPoint;


Begin

IF (AvImExists > 0) and(AnalInAction = False) THEN BEGIN {For All}
  if Zoom = 1 then begin
  frmPlayback.lblXYcoor. Caption := IntToStr(X) + ', ' + IntToStr(Y) + ' pix';
  frmPlayback.lblXYuSize.Caption := FloatToStrF(PixSize*(X),ffFixed,3,1) + ', ' +
                             FloatToStrF(PixSize*(Y),ffFixed,3,1) + ' µ';
  end else
  if Zoom = 2 then begin
  frmPlayback.lblXYcoor. Caption := IntToStr(X shr Zm) + ', ' + IntToStr(Y shr Zm) + ' pix';
  frmPlayback.lblXYuSize.Caption := FloatToStrF(PixSize*(X shr Zm),ffFixed,3,1) + ', ' +
                             FloatToStrF(PixSize*(Y shr Zm),ffFixed,3,1) + ' µ';
  end else
  if Zoom = -2 then begin
  frmPlayback.lblXYcoor. Caption := IntToStr(X shl Zm) + ', ' + IntToStr(Y shl Zm) + ' pix';
  frmPlayback.lblXYuSize.Caption := FloatToStrF(PixSize*(X shl Zm),ffFixed,3,1) + ', ' +
                             FloatToStrF(PixSize*(Y shl Zm),ffFixed,3,1) + ' µ';
  end;
 //----------------------------------------------------------------------------------//

 If  not(XYprofileRectVisible) Then Begin

  {------------------ Measure Distance ----------------------------------------}

 If  (frmImageControl.MeasureDistance.Down = true) Then Begin

  With MesLine Do Begin

  If (ssLeft in Shift) Then Begin

    If (OpCode = IN_DRAWING) Then Begin
      with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X,LineBeg.Y,X,Y,winAverImage.Canvas);
      if Zoom = 1 then
      frmPlayback.lblROIval.Caption :=
      FloatToStrF(GetDistance(LineBeg.X,LineBeg.Y,X,Y),ffFixed,5,2)+ ' µ (' +
      IntToStr(GetDistancePix(LineBeg.X,LineBeg.Y,X,Y)) + ' pix)'
      else
      if Zoom = 2 then
      frmPlayback.lblROIval.Caption :=
      FloatToStrF(GetDistance(LineBeg.X shr Zm,LineBeg.Y shr Zm,X shr Zm,Y shr Zm),ffFixed,5,2)+ ' µ (' +
      IntToStr(GetDistancePix(LineBeg.X shr Zm,LineBeg.Y shr Zm,X shr Zm,Y shr Zm))+ ' pix )'
      else
      if Zoom = -2 then
      frmPlayback.lblROIval.Caption :=
      FloatToStrF(GetDistance(LineBeg.X shl Zm,LineBeg.Y shl Zm,X shl Zm,Y shl Zm),ffFixed,5,2)+ ' µ (' +
      IntToStr(GetDistancePix(LineBeg.X shl Zm,LineBeg.Y shl Zm,X shl Zm,Y shl Zm))+ ' pix )';
    End Else
    If (OpCode = IN_MOVING) Then Begin
      dXpr := (X - Pr.X);
      dYpr := (Y - Pr.Y);
      with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X + dXpr,LineBeg.Y + dYpr,LineEnd.X + dXpr,LineEnd.Y + dYpr,winAverImage.Canvas);
    End;
  End Else
  If (Shift = []) Then Begin //Nothing was pressed

    If (MesLine.OpCode in [DO_EXIST,MIDDLE_SEL,BEG_SEL,END_SEL]) then Begin
      CheckIfMesLineSelected(X,Y);
      if (MesLine.OpCode = MIDDLE_SEL)         then winAverImage.Cursor := crBlackArrow else
      if (MesLine.OpCode in [BEG_SEL,END_SEL]) then winAverImage.Cursor := crCircle else
                                                    winAverImage.Cursor := crDefault;
    End;
  End;

 End; // with
End;


  {---------------------Select Button -----------------------------------------}
  If (frmImageControl.Select.Down = True) Then Begin {Select Button}
       
  If (ssLeft in Shift) Then Begin {Left Mouse Button}
      If (InROI = True) and (ROIvar.ROIonAverWin) Then Begin
       KindROI := abs(ROIvar.ROIAdr[CurROIadr]);
       with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);

       if Zoom = 1 then begin
       dXpr := (X - Pr.X);
       dYpr := (Y - Pr.Y);
       end else
       if Zoom = 2 then begin
       dXpr := (X shr Zm - Pr.X);
       dYpr := (Y shr Zm - Pr.Y);
       end else
       if Zoom = -2 then begin
       dXpr := (X shl Zm - Pr.X);
       dYpr := (Y shl Zm - Pr.Y);
       end;

       XL  := Xl  + dXpr;
       Yup := Yup + dYpr;
       Xr  := Xr  + dXpr;
       Yd  := Yd  + dYpr;
       KeepAllROIinWindow(KindROI,XL,Xr,dXpr,Yup,Yd,dYpr,CanMoveX,CanMoveY);
       
      if KindROI = 1 then begin {rectangle}
        if Zoom = 1 then
        winAverImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then
        winAverImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
        if Zoom = -2 then
        winAverImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                        Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);


      end else
      if KindROI = 3 then begin {Free hand}
        for bXs := 0 to High(FhPol[CurROIadr]) do begin
           if CanMoveX then
          FhPol[CurROIadr,bXs].X := FhPol[CurROIadr,bXs].X + dXpr;
          if CanMoveY then
          FhPol[CurROIadr,bXs].Y := FhPol[CurROIadr,bXs].Y + dYpr;
        end; {for bXs := 0 to High(FhPol[CurROIadr])}
         {updates table}
        for CntY := 0 to High(FhTbl[CurROIadr]) do begin
          For CntX := 0 to High(FhTbl[CurROIadr,CntY]) do Begin
            if CanMoveX then
            FhTbl[CurROIadr,CntY,CntX].X := FhTbl[CurROIadr,CntY,CntX].X + dXpr;
          if CanMoveY then
            FhTbl[CurROIadr,CntY,CntX].Y := FhTbl[CurROIadr,CntY,CntX].Y + dYpr;
          end;
        End;
        if Zoom = 1 then
        winAverImage.Canvas.Polygon(FhPol[CurROIadr]) else
        if Zoom = 2 then begin
          SetLength(TpTem,Length(FhPol[CurROIadr]));
          i := 0;
          while i < Length(TpTem) do begin
            TpTem[i].X := FhPol[CurROIadr,i].X shl Zm;
            TpTem[i].Y := FhPol[CurROIadr,i].Y shl Zm;
            Inc(i);
          end;
          winAverImage.Canvas.Polygon(TpTem);
        end else //zoom = 2
        if Zoom = -2 then begin
          SetLength(TpTem,Length(FhPol[CurROIadr]));
          i := 0;
          while i < Length(TpTem) do begin
            TpTem[i].X := FhPol[CurROIadr,i].X shr Zm;
            TpTem[i].Y := FhPol[CurROIadr,i].Y shr Zm;
            Inc(i);
          end;
          winAverImage.Canvas.Polygon(TpTem);
        end; //Zoom = -2
   
      end; {if KindROI = 3 then begin  = Free hand}

       if Zoom = 1 then begin
       Pr.X := X;
       Pr.Y := Y;
       end else
       if Zoom = 2 then begin
       Pr.X := X shr Zm;
       Pr.Y := Y shr Zm;
       end else
       if Zoom = -2 then begin
       Pr.X := X shl Zm;
       Pr.Y := Y shl Zm;
       end;
  {----labels}
if ROIvar.UseROINr = True then
 with winAverImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[CurROIadr] else Font.Color := ROIvar.MonoFontCol;
          Lab := IntToStr(CurROIadr);
      if Zoom = 1 then begin
         if Yup - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) - TextWidth(Lab) shr 1,Yup - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) - TextWidth(Lab) shr 1,Yd  + 2, Lab);
      end else
      if Zoom = 2 then begin
         if Yup shl Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - TextWidth(Lab) shr 1,Yup shl Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - TextWidth(Lab) shr 1,Yd  shl Zm + 2, Lab);
      end else
      if Zoom = -2 then begin
         if Yup shr Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - TextWidth(Lab) shr 1,Yup shr Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - TextWidth(Lab) shr 1,Yd  shr Zm + 2, Lab);
      end;

end;
{---------Prints mean Value of ROI on Playback Panel ------------}
      If (KindROI = 1) Then Begin
        MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
        frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,5,1);
      End
        Else
      If (KindROI = 3) Then
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnAverIm),ffFixed,5,1);


      End {If (InROI = True)  Then Begin}

        Else

If (InScaleBar) Then Begin
  if (Zoom = 1) then begin
    dXpr := (X - Pr.X);
    dYpr := (Y - Pr.Y);
  end
    else
  if (Zoom = 2) then begin
    dXpr := (X shr Zm - Pr.X);
    dYpr := (Y shr Zm - Pr.Y);
  end
    else
  if (Zoom = -2) then begin
    dXpr := (X shl Zm - Pr.X);
    dYpr := (Y shl Zm - Pr.Y);
  end;

  SizeBar.XL := SizeBar.XL + dXpr;
  SizeBar.XR := SizeBar.XR + dXpr;
  SizeBar.YT := SizeBar.YT + dYpr;
  SizeBar.YB := SizeBar.YB + dYpr;
  with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
  DrawScaleBar(Zoom,SizeBar,winAverImage.Canvas);
  if (Zoom = 1) then begin
    Pr.X := X;
    Pr.Y := Y;
  end
    else
  if (Zoom = 2) then begin
    Pr.X := X shr Zm;
    Pr.Y := Y shr Zm;
  end
    else
  if (Zoom = -2) then begin
    Pr.X := X shl Zm;
    Pr.Y := Y shl Zm;
  end;

End; //If (InScaleBar) Then Begin

    End; //If (ssLeft in Shift) Then Begin {Left Mouse Button}

  End   //If (frmImageControl.Select.Down = True) Then Begin {Select Button}

    Else

  {---------------------Sel & Locked Moves all ROI -----------------}
  If (frmImageControl.SelectLocked.Down = True) and (ROIvar.ROIonAverWin) Then Begin
     If (ssLeft in Shift) and (InROI = True) Then Begin

       with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
       {1st: Gets Delta of Mouse Coordinates}
       if Zoom = 1 then begin
       dXpr := (X - Pr.X);
       dYpr := (Y - Pr.Y);
       end else
       if Zoom = 2 then begin
       dXpr := (X shr Zm - Pr.X);
       dYpr := (Y shr Zm - Pr.Y);
       end else
       if Zoom = -2 then begin
       dXpr := (X shl Zm - Pr.X);
       dYpr := (Y shl Zm - Pr.Y);
       end;
       {2nd: Updates Rectangle [boundares] where ROs reside}
       XL  := Xl  + dXpr;
       Yup := Yup + dYpr;
       Xr  := Xr  + dXpr;
       Yd  := Yd  + dYpr;
       KeepAllROIinWindow(3,XL,Xr,dXpr,Yup,Yd,dYpr,CanMoveX,CanMoveY);
       {3rd: updates ROIs coordinates}

      For i := 1 to 20 Do Begin
        If (ROIvar.ROIAdr[i] = 1) Then Begin {box}
          if CanMoveX then begin
            ROIvar.ROICoor[1,i] := ROIvar.ROICoor[1,i] + dXpr;
            ROIvar.ROICoor[3,i] := ROIvar.ROICoor[3,i] + dXpr;
          end;
          if CanMoveY then begin
            ROIvar.ROICoor[2,i] := ROIvar.ROICoor[2,i] + dYpr;
            ROIvar.ROICoor[4,i] := ROIvar.ROICoor[4,i] + dYpr;
          end;
        End Else
        If (ROIvar.ROIAdr[i] = 3) Then Begin {Free hand}
          {updates Polygon Array}
          For bXs := 0 to High(FhPol[i]) do begin
           if CanMoveX then
            FhPol[i,bXs].X := FhPol[i,bXs].X + dXpr;
           if CanMoveY then
            FhPol[i,bXs].Y := FhPol[i,bXs].Y + dYpr;
          End; {for bXs := 0 to High(FhPol[CurROIadr])}
           {Updates Free Hand Table}
          For CntY := 0 to High(FhTbl[i]) do begin
            For CntX := 0 to High(FhTbl[i,CntY]) do Begin
              if CanMoveX then
              FhTbl[i,CntY,CntX].X := FhTbl[i,CntY,CntX].X + dXpr;
              if CanMoveY then
              FhTbl[i,CntY,CntX].Y := FhTbl[i,CntY,CntX].Y + dYpr;
            End;
          End; {For CntY := 0 to High(FhTbl[CurROIadr])}
          {end update table}
        End; {Free hand}
      End; {For i := 1 to 20 Do Begin }
       {End of 3rd}

      DrawROI(winAverImage.Canvas);

       if Zoom = 1 then begin
       Pr.X := X;
       Pr.Y := Y;
       end else
       if Zoom = 2 then begin
       Pr.X := X shr Zm;
       Pr.Y := Y shr Zm;
       end else
       if Zoom = -2 then begin
       Pr.X := X shl Zm;
       Pr.Y := Y shl Zm;
       end;

    End; {If (ssLeft in Shift) and (InROI = True)}
  End {Sel Locked} Else
  {------------------------- Put Box  -------------------------------------}
  If  (frmImageControl.PutBox.Down = True) and (ROIvar.ROIonAverWin) Then Begin
    If (ssLeft in Shift)  and (CurROIadr > 0) Then begin
        KindROI := 1;
         if Zoom = 1 then begin
        XL   :=  X - ROIrct.Xsize shr 1;
        Xr   :=  X + ROIrct.Xsize shr 1 - ROIrct.Rc;
        Yup  :=  Y - ROIrct.Ysize shr 1;
        Yd   :=  Y + ROIrct.Ysize shr 1 - ROIrct.Bc;
        end else
        if Zoom = 2 then begin
        XL   :=  X shr Zm - ROIrct.Xsize shr 1;
        Xr   :=  X shr Zm + ROIrct.Xsize shr 1 - ROIrct.Rc;
        Yup  :=  Y shr Zm - ROIrct.Ysize shr 1;
        Yd   :=  Y shr Zm + ROIrct.Ysize shr 1 - ROIrct.Bc;
        end else
        if Zoom = -2 then begin
        XL   :=  X shl Zm - ROIrct.Xsize shr 1;
        Xr   :=  X shl Zm + ROIrct.Xsize shr 1 - ROIrct.Rc;
        Yup  :=  Y shl Zm - ROIrct.Ysize shr 1;
        Yd   :=  Y shl Zm + ROIrct.Ysize shr 1 - ROIrct.Bc;
        end;
        KeepROIinWindow; {does not allow box to go uotside of the window}
        with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
        if Zoom = 1 then
        winAverImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then begin
         if Zm = 1 then
          winAverImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
         if Zm = 2 then
          winAverImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 3,Yd  shl Zm+ROIrct.RB + 3);
        end
          else
        if Zoom = -2 then
        winAverImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                        Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);


       {----labels}
if ROIvar.UseROINr = True then
 with winAverImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[CurROIadr] else Font.Color := ROIvar.MonoFontCol;
          Lab := IntToStr(CurROIadr);
      if Zoom = 1 then begin
          if Yup - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yup - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yd + 2, Lab);
      end else
      if Zoom = 2 then begin
          if Yup shl Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yup shl Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yd  shl Zm + 2, Lab);
      end else
      if Zoom = -2 then begin
          if Yup shr Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yup shr Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yd  shr Zm + 2, Lab);
      end;
end;
{--------}
        MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
        frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,5,1);
    End Else

    If (ssRight in Shift) and (InROI = True) Then Begin
        KindROI := 1;
        bXs  := ROIvar.ROICoor[3,CurROIadr] - ROIvar.ROICoor[1,CurROIadr] + 1;
        bYs  := ROIvar.ROICoor[4,CurROIadr] - ROIvar.ROICoor[2,CurROIadr] + 1;
        if Zoom = 1 then begin
        XL   :=  X - bXs shr 1;
        Xr   :=  X + bXs shr 1 - (1 - bXs mod 2);
        Yup  :=  Y - bYs shr 1;
        Yd   :=  Y + bYs shr 1 - (1 - bYs mod 2);
        end else
        if Zoom = 2 then begin
        XL   :=  X shr Zm - bXs shr 1;
        Xr   :=  X shr Zm + bXs shr 1 - (1 - bXs mod 2);
        Yup  :=  Y shr Zm - bYs shr 1;
        Yd   :=  Y shr Zm + bYs shr 1 - (1 - bYs mod 2);
        end else
        if Zoom = -2 then begin
        XL   :=  X shl Zm - bXs shr 1;
        Xr   :=  X shl Zm + bXs shr 1 - (1 - bXs mod 2);
        Yup  :=  Y shl Zm - bYs shr 1;
        Yd   :=  Y shl Zm + bYs shr 1 - (1 - bYs mod 2);
        end;
        KeepROIinWindow; {does not allow box to go uotside of the window}
        with winAverImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
        if Zoom = 1 then
        winAverImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then
        winAverImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
        if Zoom = -2 then
        winAverImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                        Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
;
        
       {----labels}
if ROIvar.UseROINr = True then
 with winAverImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[CurROIadr] else Font.Color := ROIvar.MonoFontCol;
          Lab := IntToStr(CurROIadr);
       if Zoom = 1 then begin
          if Yup - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yup - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) - (Length(Lab)*6) shr 1,Yd + 2, Lab);
      end else
      if Zoom = 2 then begin
          if Yup shl Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yup shl Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,Yd  shl Zm + 2, Lab);
      end else
      if Zoom = -2 then begin
          if Yup shr Zm - 14 > 0 then
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yup shr Zm - 16,Lab) else
TextOut((XL+(Xr-XL+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,Yd  shr Zm + 2, Lab);
      end;
end;
{--------}

        MeanAver := GetMeanROIAverIm(AvImRaw,XL,Xr,Yup,Yd,KindROI);
        frmPlayback.lblROIval.Caption := FloatToStrF(MeanAver,ffFixed,5,1);
    End;  {If (ssRight in Shift) and (InROI = True) }
  End Else

  {----------------------- Selection Frame ----------------------------------}
If  (frmImageControl.SelectionFrameChange.Down = True) Then Begin
   {to simplify the code store the scaled Mose X,Y to dXpr and dYpr
  this is different from drawing ROIs}

  if (Zoom = 1) then begin
    dXpr := X;
    dYpr := Y;
  end else
  if (Zoom = 2) then begin
    dXpr := X shr Zm;
    dYpr := Y shr Zm;;
  end else
  if (Zoom = -2) then begin
    dXpr := X shl Zm;;
    dYpr := Y shl Zm;;
  end;

 With SelFrame do Begin

  If (Shift = []) then Begin  //Nothing was pressed

    if (dXpr > Left+Tol) and (dXpr < Right-Tol) and (dYpr > Top+Tol) and (dYpr < Bottom-Tol) then
    begin
      //Canvas.c := crHandPoint;
      winAverImage.Cursor := crHandPoint;;
      SelFrameMove := MOVE_ALL;
    end else
    if (dXpr > Left) and (dXpr < Right) and (dYpr < Top+Tol) and (dYpr > Top-Tol) then
    begin
      winAverImage.Cursor := crSizeNS;
      SelFrameMove := MOVE_UP;
    end else
    if (dXpr > Left) and (dXpr < Right) and (dYpr < Bottom+Tol) and (dYpr > Bottom-Tol) then
    begin
      winAverImage.Cursor := crSizeNS;
      SelFrameMove := MOVE_DOWN;
    end else
    if (dXpr < Left+Tol) and (dXpr > Left-Tol) and (dYpr > Top) and (dYpr < Bottom) then
    begin
      winAverImage.Cursor := crSizeWE;
      SelFrameMove := MOVE_LEFT;
    end else
    if (dXpr < Right+Tol) and (dXpr > Right-Tol) and (dYpr > Top) and (dYpr < Bottom) then
    begin
      winAverImage.Cursor := crSizeWE;
      SelFrameMove := MOVE_RIGHT;
    end else
    begin
      winAverImage.Cursor := crDefault;
      SelFrameMove := NO_MOVE;
    end;
 End  Else

 If (ssLeft in Shift) and (MainImLoaded)  then with winAverImage do
 Begin

  If (SelFrameMove <> NO_MOVE) then begin
      Canvas.Draw(0,0,memBMP);

   if (SelFrameMove = MOVE_ALL) then begin
     if (SelRectMem.Left+dXpr > 2) and  (SelRectMem.Right+dXpr  < imXsize-3) and
        (SelRectMem.Top+ dYpr > 2)  and (SelRectMem.Bottom+dYpr < imYsize-3)
     then begin
      SelFrame.Left   := SelRectMem.Left   + dXpr;
      SelFrame.Right  := SelRectMem.Right  + dXpr;
      SelFrame.Top    := SelRectMem.Top    + dYpr;
      SelFrame.Bottom := SelRectMem.Bottom + dYpr;
     end;
    end else
    if (SelFrameMove = MOVE_UP) then begin
      i := SelRectMem.Top + dYpr;    //the local var i (integer)
      if (i < SelFrame.Bottom - 20) and (dYpr > 2) then
      SelFrame.Top := i;
    end else
    if (SelFrameMove = MOVE_DOWN) then begin
      i := SelRectMem.Bottom + dYpr;
      if (i > SelFrame.Top + 20) and (dYpr < imYsize-3) then
      SelFrame.Bottom := i;
    end else
    if (SelFrameMove = MOVE_LEFT) then begin
      i := SelRectMem.Left + dXpr;
      if (i < SelFrame.Right - 20) and (dXpr > 2) then
      SelFrame.Left := i;
    end else
    if (SelFrameMove = MOVE_RIGHT) then begin
      i := SelRectMem.Right + dXpr;
      if (i > SelFrame.Left + 20) and (dXpr < imXsize-3) then
      SelFrame.Right    := i;
    end;

     DrawSelFrame(winAverImage.Canvas);

     with frmImageControl do begin
      TitleXofROI.Caption :=  'Width  = '  + IntToStr(SelFrame.Width+1) +
                           ';  L = '    + IntToStr(SelFrame.Left) +
                           ';  R = '   + IntToStr(SelFrame.Right);

      TitleYofROI.Caption := 'Height = ' + IntToStr(SelFrame.Height+1) +
                           '; T = '    + IntToStr(SelFrame.Top) +
                           '; B = '    + IntToStr(SelFrame.Bottom);
     end;
    //----------------   3D Image  ------------------------//
    If (Win3DOn) and (SourceFor3D in[MAIN_IMAGE_FOR_3D,AVER_IMAGE_FOR_3D,MERGE_IMAGE_FOR_3D]) and
        (frmImageControl.ubApplyFrame.Selected)then
    begin
        frm3DImageWin.Update3DImage(True);
    End;

  End; //If (SelFrameMove <> NO_MOVE) then begin
 End; //If (ssLeft in Shift)
 End; //With SelFrame do Begin
End Else

  {---------------------- Free Hand -------------------------------------------}
  If  (frmImageControl.Freehand.Down = True) and (ROIvar.ROIonAverWin) Then Begin
    If (ssLeft in Shift) and (CurROIadr > 0) Then Begin
      if (Pr.Y = Y) and (Pr.X <> X) then dY := True else dY := False;
        If Pr.Y <> Y then begin
          if dY = True then begin
            Inc(CntFh);
            Fh[CntFh].X := X;
            Fh[CntFh].Y := Fh[CntFh-1].Y;
          end; {dY = True}
            Inc(CntFh);
            Fh[CntFh].X := X;
            Fh[CntFh].Y := Y;
        End;{if Pr.Y <> Y}

          winAverImage.Canvas.MoveTo(Pr.X,Pr.Y);
          winAverImage.Canvas.LineTo(X,Y);
          Pr.X := X;
          Pr.Y := Y;
   End;
  End; {Free Hand}
  {--------------------------------------------------------------------}

 End //If  not(XYprofileRectVisible) Then Begin

  Else
   {--------------------- XY Profile ------------------------------------------}

If  (XYprofileRectVisible) Then Begin

  //to simplify the code store the scaled Mose X,Y to dXpr and dYpr
  //this is different from drawing ROIs

  if (Zoom = 1) then begin
    dXpr := X;
    dYpr := Y;
  end else
  if (Zoom = 2) then begin
    dXpr := X shr Zm;
    dYpr := Y shr Zm;;
  end else
  if (Zoom = -2) then begin
    dXpr := X shl Zm;;
    dYpr := Y shl Zm;;
  end;

 With XYprofileRect do Begin

  If (Shift = []) then Begin  //Nothing was pressed
    if (dXpr > (Width shr 1)+Left-1 - Tol) and (dXpr < (Width shr 1)+Left+1 + Tol) and
       (dYpr < Top+Tol) and (dYpr > Top-Tol) then
    begin
      winAverImage.Cursor := crSizeNS;
      XYprofileRectMove := MOVE_UP;
    end else
    if (dXpr > (Width shr 1)+Left-1 - Tol) and (dXpr < (Width shr 1)+Left+1 + Tol) and
       (dYpr < Bottom+Tol) and (dYpr > Bottom-Tol) then
    begin
      winAverImage.Cursor := crSizeNS;
      XYprofileRectMove := MOVE_DOWN;
    end else
    if (dXpr < Left+Tol) and (dXpr > Left-Tol) and
       (dYpr > (Height shr 1)+Top-1 - Tol) and (dYpr < (Height shr 1)+Top+1 + Tol) then
    begin
      winAverImage.Cursor := crSizeWE;
      XYprofileRectMove := MOVE_LEFT;
    end else
    if (dXpr < Right+Tol) and (dXpr > Right-Tol) and
       (dYpr > (Height shr 1)+Top-1 - Tol) and (dYpr < (Height shr 1)+Top+1 + Tol) then
    begin
      winAverImage.Cursor := crSizeWE;
      XYprofileRectMove := MOVE_RIGHT;
    end else
    if (dXpr >= Left-Tol) and (dXpr <= Right+Tol) and (dYpr >= Top-Tol) and (dYpr <= Bottom+Tol) then
    begin
      winAverImage.Cursor := crHandPoint;;
      XYprofileRectMove := MOVE_ALL;
    end else
    begin
      winAverImage.Cursor := crDefault;
      XYprofileRectMove := NO_MOVE;
    end;

  End;  //If (Shift = []) then Begin

 If (ssLeft in Shift) and (MainImLoaded)  then with winAverImage do
 Begin

  If (XYprofileRectMove <> NO_MOVE) then begin
      Canvas.Draw(0,0,memBMP);

   if (XYprofileRectMove = MOVE_ALL) then begin
     if (XYprofileRectMem.Left+dXpr > 0) and  (XYprofileRectMem.Right+dXpr  < imXsize) and
        (XYprofileRectMem.Top+ dYpr > 0)  and (XYprofileRectMem.Bottom+dYpr < imYsize)
     then begin
      XYprofileRect.Left   := XYprofileRectMem.Left   + dXpr;
      XYprofileRect.Right  := XYprofileRectMem.Right  + dXpr;
      XYprofileRect.Top    := XYprofileRectMem.Top    + dYpr;
      XYprofileRect.Bottom := XYprofileRectMem.Bottom + dYpr;
     end;
    end else
    if (XYprofileRectMove = MOVE_UP) then begin
      i := XYprofileRectMem.Top + dYpr;    //the local var i (integer)
      if (i <= XYprofileRect.Bottom) and (dYpr > -1) then
      XYprofileRect.Top := i;
    end else
    if (XYprofileRectMove = MOVE_DOWN) then begin
      i := XYprofileRectMem.Bottom + dYpr;
      if (i >= XYprofileRect.Top) and (dYpr < imYsize) then
      XYprofileRect.Bottom := i;
    end else
    if (XYprofileRectMove = MOVE_LEFT) then begin
      i := XYprofileRectMem.Left + dXpr;
      if (i <= XYprofileRect.Right) and (dXpr > 0) then
      XYprofileRect.Left := i;
    end else
    if (XYprofileRectMove = MOVE_RIGHT) then begin
      i := XYprofileRectMem.Right + dXpr;
      if (i >= XYprofileRect.Left) and (dXpr < imXsize) then
      XYprofileRect.Right    := i;
    end;

    DrawSelFrame(winAverImage.Canvas);

    with frmImageControl do begin

      TitleXofROI.Caption :=  'Width  = '  + IntToStr(XYprofileRect.Width+1) +
                           ';  L = '    + IntToStr(XYprofileRect.Left) +
                           ';  R = '   + IntToStr(XYprofileRect.Right);

      TitleYofROI.Caption := 'Height = ' + IntToStr(XYprofileRect.Height+1) +
                           '; T = '    + IntToStr(XYprofileRect.Top) +
                           '; B = '    + IntToStr(XYprofileRect.Bottom);
    end;

  End; //If (XYprofileRectMove <> NO_MOVE) then begin
 End; //If (ssLeft in Shift)
 End; //With XYprofileRect do Begin

End;  //If (XYprofileRectVisible) Then Begin
End; {AverImageExists > 0}
End; {Procedure TfrmAverIm.winAverImageMouseMove}

{***************************************************************************}

procedure TfrmAverIm.winAverImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);


Begin


IF (AvImExists > 0) and (AnalInAction = False) THEN BEGIN {For All}

  RedrawRestOfWindows := 0; // 0 = Do not redrow, 1 = Redraw Merge Window, 2 Redraw Merge and Secondary windows

 {----------- Size Bar --------------------------------------------}
  If (InScaleBar) and (Button = mbLeft) then Begin
    InScaleBar := False;
    RedrawMainIm := True;
    RedrawRestOfWindows := 2;
  End
    Else
  {------------------- Selection Frame ----------------------------}
  If (frmImageControl.SelectionFrameChange.Down) and (Button = mbLeft)
   Then Begin
    ClipCursor(NIL);  {Removes Cursor Restrictions}
    If (SelFrameMove <> NO_MOVE) then Begin
      RedrawMainIm := True;
      RedrawRestOfWindows := 2;
    End;
   {The Middle and Right button Mouse Up are not Used so far}
   {The Middle and Right button Mouse Up are not Used so far}
  End
    Else
  {-------------------- Measure Line ---------------------------------}
  If (frmImageControl.MeasureDistance.Down) and (Button = mbLeft) then begin
    ClipCursor(NIL);
    if (MesLine.OpCode > DO_EXIST) then begin
    //this should be before CalculateMesLineParams since they set MesLine.OpCode := DO_EXIST
      RedrawMainIm := True;
      RedrawRestOfWindows := 1;
    end;
    if (MesLine.OpCode = IN_DRAWING)then CalculateMesLineParams(X,Y) else
    if (MesLine.OpCode = IN_MOVING) then CalculateMesLineParams(X - Pr.X,Y - Pr.Y);
  End;

{--------------- below is for ROIs only   -------------------------------------}

If (ROIvar.ROIonAverWin) Then Begin

 {-----------------------------------------------------------------------------}
 If (frmImageControl.Select.Down = True) Then Begin
  If (Button = mbLeft) and ((InROI)) Then Begin
    UpdateROI;
    CurROIadr := 0;
    InROI     := False;
  End;
 End
  Else
 {-----------------------------------------------------------------------------}
 If (frmImageControl.SelectLocked.Down = True) Then Begin
  If (Button = mbLeft) and (InROI = True) Then Begin
        {nothing else is needed so far}
    InROI := False;
  End;
 End
  Else
 {-----------------------------------------------------------------------------}
 If (frmImageControl.PutBox.Down) then begin
    ROIselected := CurROIadr; //Save CurROIadr to ROIselected
    //to be used for Manual Positioning of ROI with Typing on the Playback Window
    If ((Button = mbLeft) and (CurROIadr > 0)) Or
       ((Button = mbRight) and (InROI)) Then Begin
      UpdateROI;
      CurROIadr := 0;
    End;

    if (ROIselected > 0) then
      frmPlayback.lbSetROI_XY.Caption := 'Set X,Y ROI # ' + IntToStr(ROIselected)
    else
      frmPlayback.lbSetROI_XY.Caption := 'Set X,Y ROI # ';
  End

    Else
{----------------------- Free Hand  ----------------------------------------}

 If  (frmImageControl.Freehand.Down = True) and (Button = mbLeft) Then Begin

     ClipCursor(NIL);  {Removes Cursor Restrictions}

 If (CntFh <= 5) and (CurROIadr > 0) Then Begin  {Deletes ROI since it is too Small}
  CurROIkind := 0;     {3 is for Free Hand}
  Dec(ROIvar.NrROI); {Was incremented in Mouse Down}
  UpdateAverImage(True);

 End Else
 If (CntFh > 5) and (CurROIadr > 0) Then Begin

  FinishFhROI(X,Y,CntFh);
  UpdateROI;
  UpdateAverImage(True);

      {------ Calculates Mean of Free Hand Area ------}
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnAverIm),ffFixed,5,1);
              {-- End of Calc Mean --- }
  CurROIadr := 0;
  RedrawMainIm := True;
 End; {If (CntFh > 5) Then Begin}

 End Else;   {If  (frmImageControl.Freehand.Down = True)}



  InROI := False;

End; {and (ROIvar.ROIonAverWin) }

{-------------------------------------------------------------------------}
  If (RedrawMainIm) then Begin
    if (frmImageControl.btZeroOutsideROI_All_Images.Down) then begin
    //Sets Pixels to Black in Main Image if needed
    //this is the only place in This Unit where it does this//
      if (ROIvar.NrROI = 0) then begin
        frmImageControl.btZeroOutsideROI_All_Images.Down := False;
        frmImageControl.btZeroOutsideROI_All_Images.Click;
      end
      else frmPlayback.PlaybackScrollBarChange(Sender);
    end //if (frmImageControl.btZeroOutsideROI_All_Images.Down)
      else
    begin
      UpdateMainImage(True);
    end;
      RedrawMainIm := False;
  End; //if (RedrawMainIm) then begin

    {----------------------------------------------------}
                   end;


  if (RedrawRestOfWindows > 0) and (NrChannels > 1)then Begin
    if (RedrawRestOfWindows >= 1) and (frmMergeWin <> nil) then DisplayMergeImage;
    if (RedrawRestOfWindows =  2) and (frm2ndWin <> nil)   then Display2ndChannel;
    RedrawRestOfWindows := 0;
  End;
 
 End; {(AvImExists > 0) and (AnalInAction = False)}

END.
