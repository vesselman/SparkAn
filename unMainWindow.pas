{$D-,L-,O+,Q-,R-,Y-,S-}
unit unMainWindow;
 {controls frmMainWin}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, Vcl.Graphics,Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,Vcl.Dialogs;

type
  TfrmMainWin = class(TForm)
    winMainImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure winMainImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure winMainImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure winMainImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure winMainImageMouseLeave(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);



  private
    { Private declarations }
    CntFh        : integer;
    RedrawAvIm   : Boolean;
    RedrawRestOfWindows : Byte; // 0 = Do not redrow, 1 = Redraw Merge Window, 2 Redraw Merge and Secondary windows

     procedure PlaceBoxOrMarkAtMax(Const PutBox : Byte); {if 1 = PutBox; 2 Put Small Event Mark; 3 = Put Big Event Mark}
     procedure WMSize(var M : TWMSIZE); Message WM_Size; {added by me; helps hiding window}
     procedure WMWINDOWPOSCHANGED (Var Msg: TWMWINDOWPOSCHANGED); message WM_WINDOWPOSCHANGED;
   { procedure CMMouseEnter(var AMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMsg: TMessage); message CM_MOUSELEAVE;     }
    {These are now in FrameIm  }


  public
    { Public declarations }
     frmMainWinHidden : Boolean;

     //to Handle Movie Labels
    MouseDownSpot : TPoint;
    Capturing     : Boolean;
    procedure CommentMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CommentMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CommentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);


  end;

var
  frmMainWin   : TfrmMainWin;
{------------------------------}
  MouseInside  : Boolean;
  XLMem,XrMem,YupMem,YdMem : integer;


implementation

uses unAverIm, unImageControl, unGlobUnit, unTimeSerAnal,
     unSparkTable, unWaveTable,unFileList, unFrameTimSerPlot,unPlayBack,
     unSpatialSpread, Main, un3DImageWin, unMergeWindow, unXYprofile, un2ndWin,
  MovieLabels;

 {$R *.dfm}

procedure TfrmMainWin.FormCreate(Sender: TObject); {Makes Image Black}
Begin

  With frmMainWin Do Begin
    DoubleBuffered := True;
    frmMainWin.ClientWidth := 256;
    frmMainWin.ClientHeight := 256;

    Constraints.MinHeight := Height;
    Constraints.MaxHeight := Height;
    Constraints.MaxWidth  := Width;
    Constraints.MinWidth  := Width;

    {paints the window in black (looks better}
    with  frmMainWin.winMainImage do begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Canvas.ClipRect);
    end;

 End; {with}
   frmPlayback.Xoffset := (frmPlayback.ClientWidth - frmMainWin.ClientWidth) div 2;
   frmPlayback.CenterOffs := frmPlayback.Xoffset;
   frmPlayback.Docked := True;
   frmPlayback.pnFakeBar.Color := $00B9B9FF; //light red
End;



 {***********************************************************************}

Procedure TfrmMainWin.winMainImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  Label DelMark;
  Var
    i,bXs,bYs,SearchFor,CntX,CntY : integer;
    CursorClipArea: TRect;
    KindROI       : Integer; {1 = Box; 2 = Future Circle; 3 = Free Hand; 4 is used By Marks}
    Lab           : AnsiString;
    Xm,Ym         : integer;
    PutBox        : Byte;
    {Marks Var}
    InSmMark      : Boolean;
    InBigMark     : Boolean;
    Mpos          : Integer; {Mark Pos}
    DelRow        : Integer; {Row to be Deleted }
    SetPar        : Boolean; {Needed for PlaceMark}
    TpTem         : array of TPoint;
    Pt            : TPoint;
    MouseMov      : TMouseMoveEvent;          mrValue       : Byte;

Begin

IF (MainImLoaded = True) and (AnalInAction = False) THEN BEGIN {For All}
{---------------------------------------------------------------------------}
        SetPar := True;
 {-----------------------------------------------------------------------------}
 If  not(XYprofileRectVisible) Then Begin

  {---------------------Select Button -----------------------------------------}
  If (frmImageControl.Select.Down = True) Then Begin {Select Button}

     if (ROIvar.NrROI > 0) then SearchFor := 4; {Search for all kinds of ROI}
      if Zoom = 1 then CheckIfInROI(X, Y,SearchFor) else
      if Zoom = 2 then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
      if Zoom =-2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);

    If (InROI = True)  Then Begin {thats Requirement Fol Select Button Functions}
    //---------------------- InROI = True --------------------------//
    If (button = mbLeft) then Begin

      If (ROIvar.ROIAdr[CurROIadr] in [1,3]) then Begin
        if ROIvar.TickLine > 0 then begin
          ROIvar.TickLine := -1; {If something was thick deletes the address and sets it to -1 = Plot Not Done}
          frmTimeSerPlot.RePlot(Sender);
        end; {if ROIvar.TickLine > 0 then begin}
        if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;
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

        KindROI := ROIvar.ROIAdr[CurROIadr]; {new} {Saves Type of ROI selected}
        ROIvar.ROIAdr[CurROIadr] := -ROIvar.ROIAdr[CurROIadr]; {negates to mem but not to be drawn}

        UpdateMainImage(True);

        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}

        if ROIvar.UseMonoCol = false then
        winMainImage.Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
        else
        winMainImage.Canvas.Pen.Color := ROIvar.MonoCol;
       
        if KindROI = 1 then Begin
          XL  := ROIvar.ROICoor[1,CurROIadr];
          Yup := ROIvar.ROICoor[2,CurROIadr];
          Xr  := ROIvar.ROICoor[3,CurROIadr];
          Yd  := ROIvar.ROICoor[4,CurROIadr];
          winMainImage.Canvas.Pen.Width:=ROIvar.TckNess;
          if Zoom = 1 then
          winMainImage.
          Canvas.Rectangle(XL - ROIrct.LT,Yup - ROIrct.LT,
                           Xr + ROIrct.RB,Yd  + ROIrct.RB) else
          if Zoom = 2 then
          winMainImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
          if Zoom = -2 then
          winMainImage.
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
           winMainImage.Canvas.Pen.Width:=ROIvar.FhTickness;

           if Zoom = 1 then
           winMainImage.Canvas.Polygon(FhPol[CurROIadr]) else
           if Zoom = 2 then begin
            SetLength(TpTem,Length(FhPol[CurROIadr]));
            i := 0;
            while i < Length(TpTem) do begin
              TpTem[i].X := FhPol[CurROIadr,i].X shl Zm;
              TpTem[i].Y := FhPol[CurROIadr,i].Y shl Zm;
              Inc(i);
            end;
             winMainImage.Canvas.Polygon(TpTem);
            end else {else if Zoom = 2 then begin}
            if Zoom = -2 then begin
            SetLength(TpTem,Length(FhPol[CurROIadr]));
            i := 0;
            while i < Length(TpTem) do begin
              TpTem[i].X := FhPol[CurROIadr,i].X shr Zm;
              TpTem[i].Y := FhPol[CurROIadr,i].Y shr Zm;
              Inc(i);
            end;
              winMainImage.Canvas.Polygon(TpTem);
            end {else if Zoom = -2 then begin}
        end; {if KindROI = 3 }

{----labels}
if ROIvar.UseROINr = True then
 with frmMainWin.winMainImage.Canvas do begin
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
     If KindROI = 1 then begin
        if (RatioOn) or (ChannelsRatioOn) then
frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
     end else
     if KindROI = 3 then Begin
      if (RatioOn) or (ChannelsRatioOn) then
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,5,3)
      else
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,7,1);
     end;
     End; {If (ROIvar.ROIAdr[CurROIadr] = 1) then Begin}
     {------------}

    End Else
    If (button = mbMiddle) Then Begin
        i := CurROIadr;
        DeleteROI;
        UpdateMainImage(True);

        if (ROIvar.TickLine > 0) and (ROIvar.TickLine = i) then begin
          ROIvar.TickLine := 0;
          frmTimeSerPlot.RePlot(Sender);
        end;
    End Else
    If (button = mbRight) Then Begin {makes ROI & Trace Thicker}
        if (ROIvar.TickLine <> CurROIadr) and (ROIvar.TickLine >= 0) then Begin

            ROIvar.TickLine := CurROIadr;
            UpdateMainImage(True);
            frmTimeSerPlot.RePlot(Sender);

        end else
        if (ROIvar.TickLine = CurROIadr) and (ROIvar.TickLine >= 0) then Begin
            ROIvar.TickLine := 0;
            UpdateMainImage(True);
            frmTimeSerPlot.RePlot(Sender);
        end;
   {always calculates Mean}
        If (ROIvar.ROIAdr[CurROIadr] = 1) Then Begin
          KindROI := 1;
          XL  := ROIvar.ROICoor[1,CurROIadr];
          Yup := ROIvar.ROICoor[2,CurROIadr];
          Xr  := ROIvar.ROICoor[3,CurROIadr];
          Yd  := ROIvar.ROICoor[4,CurROIadr];
          if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
        End Else
        If (ROIvar.ROIAdr[CurROIadr] = 3) Then Begin
          if (RatioOn) or (ChannelsRatioOn) then
            frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,5,3)
          else
            frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,7,1);
         
        End; {ROIvar.ROIAdr[CurROIadr] = 3)}
    End; {(button = mbRight)}
  //--------------End of  InROI = True --------------------------------------//
    End  { If (InROI = True)  Then Begin }

      Else

    If (SizeBarVisible) and (InROI = False) and (button = mbLeft) Then Begin
      if (Zoom = 1) then CheckIfInScaleBar(X,Y,SizeBar,frmImageControl.ubSizeBar.Selected) else
      if (Zoom = 2) then CheckIfInScaleBar(X shr Zm,Y shr Zm,SizeBar,frmImageControl.ubSizeBar.Selected) else
      if (Zoom =-2) then CheckIfInScaleBar(X shl Zm,Y shl Zm,SizeBar,frmImageControl.ubSizeBar.Selected);

      If (InScaleBar) then Begin
        SizeBarVisible := False;//to prevent drawing SizeBar by UpdateMainImage
        UpdateMainImage(True);
        SizeBarVisible := True; //restores value
        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}
        DrawScaleBar(Zoom,SizeBar,winMainImage.Canvas);
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
    End
      Else
    If (InROI = False) and (button = mbMiddle) Then GoTo DelMark;

    if (InROI) or (InScaleBar) then RedrawAvIm := True else RedrawAvIm := False;

  End {with Select Button}

    Else
 {---------------------------- Select All and Move ---------------------}

  If (frmImageControl.SelectLocked.Down = True) Then Begin
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
        UpdateMainImage(False);
        with frmMainWin.winMainImage do begin
        Canvas.Pen.Mode    := pmCopy;
        Canvas.Brush.Style := bsClear;

        If (MesLine.OpCode = DO_EXIST) then with MesLine do
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,Canvas);

        if (NrIm > 1) then begin
          if MarkPar.DisplaySmEvents then  if (High(MarkSmEvCoor [CurIm]) >= 0) then
            DrawSmalEvMarks(Canvas);
          if MarkPar.DisplayBigEvents then if (High(MarkBigEvCoor[CurIm]) >= 0) then
            DrawBigEvMarks(Canvas);
        end;

        if (SizeBarVisible) then DrawScaleBar(Zoom,SizeBar,winMainImage.Canvas);

        end; //with
        
        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}

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

       DrawROI(frmMainWin.winMainImage.Canvas);
       if (InROI = True) then RedrawAvIm := True else RedrawAvIm := False;
      End; {(InROI = True)}
    End; {(button = mbLeft) and (ROIvar.NrROI > 0)}
  End {with Select Locked}

    Else

  {------------------------- Measure Box -------------------------------------}
  If  (frmImageControl.MeasureBox.Down = True) Then Begin

    If (button = mbLeft) Then Begin
         {Option # 1 Puts a Box at Maximum}
      If (frmImageControl.PutBox.Down = True) Then Begin
        if ROIvar.NrROI < 20 Then Begin
          PutBox := 1;
          if Zoom = 1 then
          winMainImage.Canvas.
          Rectangle(XL - ROIrct.LT,Yup - ROIrct.LT,
                    Xr + ROIrct.RB,Yd  + ROIrct.RB) else
          if Zoom = 2 then
          winMainImage.Canvas.
          Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                    Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
          if Zoom = -2 then
          winMainImage.Canvas.
          Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                    XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                    Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
          PlaceBoxOrMarkAtMax(PutBox);
          DrawMesBox;
        end else
        MessageDlg('Number of Boxes reached Maximum of 20',mtInformation,[mbOK],0);
      End Else
         {Option # 2: Places a Mark at Maximum}
      If (frmImageControl.PlaceMark.Down = True) and (NrIm > 1)
          and (MarkPar.DisplaySmEvents = true) then Begin
          PutBox := 2;
          if Zoom = 1 then
          winMainImage.Canvas.
          Rectangle(XL - ROIrct.LT,Yup - ROIrct.LT,
                    Xr + ROIrct.RB,Yd  + ROIrct.RB) else
          if Zoom = 2 then
          winMainImage.Canvas.
          Rectangle(XL shl Zm-ROIrct.LT,     Yup shl Zm-ROIrct.LT,
                    Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
          if Zoom = -2 then
          winMainImage.Canvas.
          Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                    XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                    Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
          PlaceBoxOrMarkAtMax(PutBox);
          DrawMesBox;
          if frmSparkTable <> nil then begin
            if (frmSparkTable.EnableMultSel.Down = True ) then Begin
                frmSparkTable.EnableMultSel.Down := False;
                frmSparkTable.EnableMultSelClick(sender);
            end;
          PutRowInStringGrid(frmSparkTable.StringGridSparks,frmSparkTable.RowSm,MarkSmEvCoor,
                             MarkSmAmpl,MarkSmBase,SpTabEmpty);
          end;
      End;
    End

      Else

    If (button = mbMiddle) Then Begin //Finds Spatial Spread//
     if (frmSpatialSpread = nil) then Application.CreateForm(TfrmSpatialSpread, frmSpatialSpread);
     frmSpatialSpread.GetSpatialSpread;
    End Else


    If (button = mbRight) Then Begin
      If (frmImageControl.PlaceMark.Down = True) and (NrIm > 1)
          and (MarkPar.DisplayBigEvents = true)then Begin
          PutBox := 3;
          If Zoom = 1 then
          winMainImage.Canvas.
          Rectangle(XL - ROIrct.LT,Yup -ROIrct.LT,
                    Xr + ROIrct.RB,Yd + ROIrct.RB) else
          If Zoom = 2 then
          winMainImage.Canvas.
          Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                    Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
          If Zoom = -2 then
          winMainImage.Canvas.
          Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                    XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                    Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

          PlaceBoxOrMarkAtMax(PutBox);
          DrawMesBox;
          if frmWaveTable <> nil then begin
            if (frmWaveTable.EnableMultSel.Down = True ) then Begin
                frmWaveTable.EnableMultSel.Down := False;
                frmWaveTable.EnableMultSelClick(sender);
            end;
          PutRowInStringGrid(frmWaveTable.StringGridBig,frmWaveTable.RowBig,MarkBigEvCoor,
                             MarkBigAmpl,MarkBigBase,BigTabEmpty);
          end;
      End;
    End; {If (ssRight in Shift)}
      RedrawAvIm := True;
  End Else
  {------------------------- Place Mark -------------------------------------}
  If  (frmImageControl.PlaceMark.Down = True) and
      (frmImageControl.MeasureBox.Down = False) and (NrIm > 1) Then Begin

    If (button = mbLeft) and (MarkPar.DisplaySmEvents = true)then Begin
      If Zoom = 1 then Begin
       AddMarkToMarkArray(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,X,Y,True);
       winMainImage.Canvas.
       Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                 Xr+ROIrct.RB,Yd+ROIrct.RB);

       PlaceMark(X ,Y,MarkPar.SmallEventColor,winMainImage.Canvas,SetPar);
      End Else
      If Zoom = 2 then Begin
       AddMarkToMarkArray(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,X shr Zm,Y shr Zm,True);
       winMainImage.Canvas.
       Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                 Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1);

       PlaceMark(X shr Zm,Y shr Zm,MarkPar.SmallEventColor,winMainImage.Canvas,SetPar);
      End Else
      If Zoom = -2 then Begin
       AddMarkToMarkArray(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,X shl Zm,Y shl Zm,True);
       winMainImage.Canvas.
       Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                 XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

       PlaceMark(X shl Zm,Y shl Zm,MarkPar.SmallEventColor,winMainImage.Canvas,SetPar);
      End;



       DrawMesBox;
       if frmSparkTable <> nil then begin
        if (frmSparkTable.EnableMultSel.Down = True ) then Begin
                frmSparkTable.EnableMultSel.Down := False;
                frmSparkTable.EnableMultSelClick(sender);
        end;
       PutRowInStringGrid(frmSparkTable.StringGridSparks,frmSparkTable.RowSm,MarkSmEvCoor,
                          MarkSmAmpl,MarkSmBase,SpTabEmpty);
       end;
    End

      Else

    If (button = mbMiddle) Then Begin  {Deletes Any Mark {Big or Small}
        DelMark:
       {First Check Small Events Array}
      If (High(MarkSmEvCoor[CurIm]) >= 0) and (MarkPar.DisplaySmEvents) Then Begin
         if Zoom = 1 then
         CheckIfInMark(MarkSmEvCoor,Xm,Ym, InSmMark,Mpos,X,Y) else
         if Zoom = 2 then
         CheckIfInMark(MarkSmEvCoor,Xm,Ym, InSmMark,Mpos,X shr Zm,Y shr Zm) else
         if Zoom = -2 then
         CheckIfInMark(MarkSmEvCoor,Xm,Ym, InSmMark,Mpos,X shl Zm,Y shl Zm);
         If (InSmMark = True) then Begin
            DelAnyMarkFromMarkArr(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,Mpos,CurIm);
            if (frmSparkTable <> nil) then Begin
              if (frmSparkTable.EnableMultSel.Down = True ) then Begin
                frmSparkTable.EnableMultSel.Down := False;
                frmSparkTable.EnableMultSelClick(sender);
              end;
              DelRowInStringGrid(frmSparkTable.StringGridSparks,SpTabEmpty, Xm, Ym);
            End;
          End; {(InSmMark = True) }
      End; {If High(MarkBigEvCoor[CurIm]) >= 0 Then Begin}

         {2nd: for Big Events}
     If (High(MarkBigEvCoor[CurIm]) >= 0) and (MarkPar.DisplayBigEvents) Then Begin
         if Zoom = 1 then
         CheckIfInMark(MarkBigEvCoor,Xm,Ym, InBigMark,Mpos,X ,Y ) else
         if Zoom = 2 then
         CheckIfInMark(MarkBigEvCoor,Xm,Ym, InBigMark,Mpos,X shr Zm,Y shr Zm) else
         if Zoom = -2 then
         CheckIfInMark(MarkBigEvCoor,Xm,Ym, InBigMark,Mpos,X shl Zm,Y shl Zm);
         If (InBigMark = True) then Begin
            DelAnyMarkFromMarkArr(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,Mpos,CurIm);
            if (frmWaveTable <> nil) then begin
              if (frmWaveTable.EnableMultSel.Down = True ) then Begin
                frmWaveTable.EnableMultSel.Down := False;
                frmWaveTable.EnableMultSelClick(sender);
              end;
              DelRowInStringGrid(frmWaveTable.StringGridBig,BigTabEmpty, Xm, Ym);
            end;
         End; {(InSmMark = True) }
     End; {If High(MarkBigEvCoor[CurIm]) >= 0 Then Begin}
         {refreshes the image}
      If (InSmMark = True) or (InBigMark = True) then Begin  {Redraws Image}
       UpdateMainImage(True);
       if (frmImageControl.PlaceMark.Down = True) then DrawMesBox;
      End;

    End Else

    If (button = mbRight) and (MarkPar.DisplayBigEvents = true) then Begin   {Puts a Marrk In Big Event Table}
       if Zoom = 1 then begin
       AddMarkToMarkArray(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,X,Y,True);
       winMainImage.Canvas.
       Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                 Xr+ROIrct.RB,Yd+ROIrct.RB);
       PlaceMark(X,Y,MarkPar.BigEventColor,frmMainWin.winMainImage.Canvas,SetPar);
       end else
       if Zoom = 2 then begin
       AddMarkToMarkArray(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkSmEvDur,MarkBigEvRise,X shr Zm,Y shr Zm,True);
       winMainImage.Canvas.
       Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                 Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1);
       PlaceMark(X shr Zm,Y shr Zm,MarkPar.BigEventColor,frmMainWin.winMainImage.Canvas,SetPar);
       end else
       if Zoom = -2 then begin
       AddMarkToMarkArray(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,X shl Zm,Y shl Zm,True);
       winMainImage.Canvas.
       Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                 XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
       PlaceMark(X shl Zm,Y shl Zm,MarkPar.BigEventColor,winMainImage.Canvas,SetPar);
       end;

       DrawMesBox;
       if frmWaveTable <> nil then begin
        if (frmWaveTable.EnableMultSel.Down = True ) then Begin
          frmWaveTable.EnableMultSel.Down := False;
          frmWaveTable.EnableMultSelClick(sender);
        end;
        PutRowInStringGrid(frmWaveTable.StringGridBig,frmWaveTable.RowBig,MarkBigEvCoor,
                            MarkBigAmpl,MarkBigBase,BigTabEmpty);
       end;
    End; {ssRight in Shift}
       RedrawAvIm := True;
  End Else
  {------------------------- Put Box  -------------------------------------}
  If  (frmImageControl.PutBox.Down = True) Then Begin

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
      with winMainImage do begin
      Canvas.Pen.Mode    := pmCopy;
      Canvas.Pen.Width   := ROIvar.TckNess;
      Canvas.Brush.Style := bsClear;
      memBMP.Assign(winMainImage.Picture.Bitmap);
      if ROIvar.UseMonoCol = false then
      Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
      else
      Canvas.Pen.Color := ROIvar.MonoCol;
      if Zoom = 1 then
      Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                       Xr+ROIrct.RB,Yd+ROIrct.RB) else
      if Zoom = 2 then begin
        if Zm = 1 then
          winMainImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
        if Zm = 2 then
          winMainImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 3,Yd  shl Zm+ROIrct.RB + 3);
      end
        else
      if Zoom = -2 then
      Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                       XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                       Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

      end; {with}
 {----labels}
if ROIvar.UseROINr = True then
 with frmMainWin.winMainImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[CurROIadr] else
          Font.Color := ROIvar.MonoFontCol;
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
      if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
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
        UpdateMainImage(True);
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
        UpdateMainImage(True);
        ROIvar.ROIAdr[CurROIadr] := 1;
        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap without Sel Box}

        if ROIvar.UseMonoCol = false then
        winMainImage.Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
        else
        winMainImage.Canvas.Pen.Color := ROIvar.MonoCol;
        winMainImage.Canvas.Pen.Width := ROIvar.TckNess;
        bXs  := ROIvar.ROICoor[3,CurROIadr] - ROIvar.ROICoor[1,CurROIadr] + 1;
        bYs  := ROIvar.ROICoor[4,CurROIadr] - ROIvar.ROICoor[2,CurROIadr] + 1;

        XL  := ROIvar.ROICoor[1,CurROIadr];
        Yup := ROIvar.ROICoor[2,CurROIadr];
        Xr  := ROIvar.ROICoor[3,CurROIadr];
        Yd  := ROIvar.ROICoor[4,CurROIadr];

        if (Zoom = 1) then begin
        //here Xm and Ym are used to calculate Center of ROI Rectangle (they are also used Mark Centers)
        Xm := XL  + bXs shr 1;
        Ym := Yup + bYs shr 1;
        Pt := ClientToScreen(Point(winMainImage.Left+Xm, winMainImage.Top+Ym));
        MouseMov := winMainImage.OnMouseMove;
        winMainImage.OnMouseMove := nil;  //if not disabled SetCursorPos triggers MouseMove Event
        SetCursorPos(Pt.X,Pt.Y); //Win32 API  - uses Global (screen) coordinates
        Application.ProcessMessages; //must be here, otherwise Move event will be generated after OnMouseMove := MouseMov;
        winMainImage.OnMouseMove := MouseMov;

        winMainImage.
        Canvas.Rectangle(XL - ROIrct.LT,Yup - ROIrct.LT,
                         Xr + ROIrct.RB,Yd  + ROIrct.RB);
        end else
        if (Zoom = 2) then begin
        Xm := XL  + bXs shr 1;
        Xm := Xm shl Zm;
        Ym := Yup + bYs shr 1;
        Ym := Ym shl Zm;
        Pt := ClientToScreen(Point(winMainImage.Left+Xm, winMainImage.Top+Ym));
        MouseMov := winMainImage.OnMouseMove;
        winMainImage.OnMouseMove := nil;  //if not diasbled SetCursorPos triggers MouseMove Event
        SetCursorPos(Pt.X,Pt.Y); //Win32 API  - uses Global (screen) coordinates
        Application.ProcessMessages; //must be here, otherwise Move event will be generated after OnMouseMove := MouseMov;
        winMainImage.OnMouseMove := MouseMov;

        winMainImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1);
        end else
        if (Zoom = -2) then begin
        Xm := XL  + bXs shr 1;
        Xm := Xm shr Zm;
        Ym := Yup + bYs shr 1;
        Ym := Ym shr Zm;
        //Sets the Coursor to ROI center
        Pt := ClientToScreen(Point(winMainImage.Left+Xm, winMainImage.Top+Ym));
        MouseMov := winMainImage.OnMouseMove;
        winMainImage.OnMouseMove := nil;  //if not diasbled SetCursorPos triggers MouseMove Event
        SetCursorPos(Pt.X,Pt.Y); //Win32 API  - uses Global (screen) coordinates
        Application.ProcessMessages; //must be here, otherwise Move event will be generated after OnMouseMove := MouseMov;
        winMainImage.OnMouseMove := MouseMov;

        winMainImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                         Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

        end;

        {----labels}
if ROIvar.UseROINr = True then with frmMainWin.winMainImage.Canvas do begin
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
        if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
        if ROIvar.TickLine > 0 then begin
          ROIvar.TickLine := -1;
          frmTimeSerPlot.RePlot(Sender);
        end;
        if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
        end;
      End; {If (InROI = True) Then Begin}


    End; {If (ssRight in Shift) and (ROIvar.NrROI > 0)}
      if (button = mbLeft) or (InROI = True) then RedrawAvIm := True else RedrawAvIm := False;
  End

    Else
 {------------------------- XY Profile  -------------------------------------}


  {----------------------- Selection Frame----------------------------}

  If  (frmImageControl.SelectionFrameChange.Down) and (button = mbLeft)
      and (SelFrameMove <> NO_MOVE) Then Begin

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

    SelRectMem.Left   := SelFrame.Left   - Xm;
    SelRectMem.Right  := SelFrame.Right  - Xm;
    SelRectMem.Top    := SelFrame.Top    - Ym;
    SelRectMem.Bottom := SelFrame.Bottom - Ym;

    SelFrameVisible := False; //so UpdateMainImage Not to Draw SelFrame
    UpdateMainImage(True);
    memBMP.Assign(winMainImage.Picture.Bitmap); //Saves to Bitmap without Sel Box
    SelFrameVisible := True;
    DrawSelFrame(winMainImage.Canvas);

    CursorClipArea := Bounds(winMainImage.ClientOrigin.X,
                             winMainImage.ClientOrigin.Y,
                             winMainImage.Width,winMainImage.Height);
    ClipCursor(@CursorClipArea);

  End
    Else
  {----------------------- Selection Frame----------------------------}

  {----------------- Measure Distance ------------------------}

  If  (frmImageControl.MeasureDistance.Down = true) and (button = mbLeft) and
      (DiamMesRect.OpCode <> IN_TRACKING) Then Begin

      //Restrict Cursor
    CursorClipArea := Bounds(winMainImage.ClientOrigin.X,
                             winMainImage.ClientOrigin.Y,
                             winMainImage.Width,winMainImage.Height);
    ClipCursor(@CursorClipArea);
      {Alternative:  ( p : TPoint)
       with CursorClipArea do begin
        p := ClientToScreen(Point(winAverImage.Left,
                                  winAverImage.Top));
        Left := p.x ;
        Top  := p.y ;
        p :=  ClientToScreen(Point(winAverImage.Left +
                                   winAverImage.Width,
                                   winAverImage.Top +
                                   winAverImage.Height)) ;
        Right  := p.x ;
        Bottom := p.y ;
       end ;       }

     With MesLine do begin

      If (OpCode = NOT_EXIST) Then Begin
        Application.ProcessMessages;  // prevents Line Drawing before Moving
        OpCode := IN_DRAWING;
        LineBeg.X := X;
        LineBeg.Y := Y;
        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap }
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
      If (OpCode in [MIDDLE_SEL,BEG_SEL,END_SEL]) Then Begin
        //Converts Real Coordinates to Current Image Coordinates
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
        UpdateMainImage(True);
        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap }

        If (OpCode =  MIDDLE_SEL) Then Begin
          OpCode := IN_MOVING;
          Pr.X := X;
          Pr.Y := Y;
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,winMainImage.Canvas);
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
          Pt := ClientToScreen(Point(winMainImage.Left+LineEnd.X, winMainImage.Top+LineEnd.Y));
          MouseMov := winMainImage.OnMouseMove;
          winMainImage.OnMouseMove := nil;  //if not diasbled SetCursorPos triggers MouseMove Event

          SetCursorPos(Pt.X,Pt.Y); //Win32 API  - uses Global (screen) coordinates
          Application.ProcessMessages; //must be here, otherwise Move event will be generated after OnMouseMove := MouseMov;
          winMainImage.OnMouseMove := MouseMov;
          MesLine.OpCode := IN_DRAWING;
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,winMainImage.Canvas);
        End; //If (MesLine.OpCode in [BEG_SEL,END_SEL]) Then Begin

        if Zoom = 1 then
        frmPlayback.lblROIval.Caption :=
        FloatToStrF(GetDistance(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y),ffFixed,5,2)+ ' µ (' +
        IntToStr(GetDistancePix(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y)) + ' pix)'
        else
        if Zoom = 2 then
        frmPlayback.lblROIval.Caption :=
        FloatToStrF(GetDistance(LineBeg.X shr Zm,LineBeg.Y shr Zm,LineEnd.X shr Zm,LineEnd.Y shr Zm),ffFixed,5,2)+ ' µ (' +
        IntToStr(GetDistancePix(LineBeg.X shr Zm,LineBeg.Y shr Zm,LineEnd.X shr Zm,LineEnd.Y shr Zm))+ ' pix )'
        else
        if Zoom = -2 then
        frmPlayback.lblROIval.Caption :=
        FloatToStrF(GetDistance(LineBeg.X shl Zm,LineBeg.Y shl Zm,LineEnd.X shl Zm,LineEnd.Y shl Zm),ffFixed,5,2)+ ' µ (' +
        IntToStr(GetDistancePix(LineBeg.X shl Zm,LineBeg.Y shl Zm,LineEnd.X shl Zm,LineEnd.Y shl Zm))+ ' pix )';

      End Else //If (MesLine.OpCode in [MIDDLE_SEL,BEG_SEL,END_SEL]) Then Begin
      If (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then Begin
        MesLine.OpCode := NOT_EXIST;
        UpdateMainImage(True);
        MesLine.OpCode := DO_EXIST;
        memBMP.Assign(winMainImage.Picture.Bitmap); {Saves to Bitmap }
        ScaleOffsXorYbegToCurrent;
        DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,winMainImage.Canvas);
        Pr.X := X;
        Pr.Y := Y;
      End;

     End; // with

  End

    Else

  {---------------------- Free Hand -------------------------------------------}
  If (frmImageControl.Freehand.Down = True) Then Begin
    If (button = mbLeft) and (ROIvar.NrROI < 20) Then begin
       if ROIvar.TickLine > 0 then begin
        ROIvar.TickLine := 0;
        frmTimeSerPlot.RePlot(Sender);
       end;
       if PLOTvar.AllowFreezeMin then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
       end;
      {---------------------------------}
       {Uses Windows API to restrict Cursor}
      CursorClipArea := Bounds(winMainImage.ClientOrigin.X,
                               winMainImage.ClientOrigin.Y,
                               winMainImage.Width,winMainImage.Height);
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

      winMainImage.Canvas.Brush.Style := bsClear;
      winMainImage.Canvas.Pen.Mode  := pmCopy;
      winMainImage.Canvas.Pen.Width := ROIvar.FhTickness;
      if ROIvar.UseMonoCol = false then
      winMainImage.Canvas.Pen.Color := ROIvar.ROICol[CurROIadr]
      else
      winMainImage.Canvas.Pen.Color := ROIvar.MonoCol;

    End Else

    If (button = mbMiddle) Then Begin
      SearchFor := 3; {Search for Free Hand}
      if Zoom = 1  then CheckIfInROI(X,Y,SearchFor) else
      if Zoom = 2  then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
      if Zoom =-2  then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);

      If (InROI = True)  Then Begin
      i := CurROIadr;
      DeleteROI;
      UpdateMainImage(True);
      winMainImage.Canvas.Brush.Style := bsClear;
      winMainImage.Canvas.Pen.Mode    := pmCopy;
      winMainImage.Canvas.Pen.Width   := ROIvar.FhTickness;
      if (ROIvar.TickLine > 0) and (ROIvar.TickLine = i) then begin
        ROIvar.TickLine := 0;
        frmTimeSerPlot.RePlot(Sender);
      end;

      if (ROIvar.NrROI = 0) and  (PLOTvar.AllowFreezeMin) then begin
          PLOTvar.AllowFreezeMin := False;
          frmTimeSerPlot.FreezeMean.Down := False;
          frmTimeSerPlot.FreezeMeanClick(sender);
      end;

      end;
    End Else

    If (button = mbRight) and (ROIvar.NrROI > 0) Then Begin
        SearchFor := 3; {Search for all kinds of ROI}
        if Zoom = 1 then CheckIfInROI(X, Y, SearchFor) else
        if Zoom = 2 then CheckIfInROI(X shr Zm,Y shr Zm,SearchFor) else
        if Zoom =-2 then CheckIfInROI(X shl Zm,Y shl Zm,SearchFor);


      If (InROI = True)  Then Begin {thats Requirement Fol all}
                   
        If (ROIvar.FillFh <> CurROIadr) then Begin
           if (ROIvar.FillFh > 0) and (ROIvar.NrROI > 1) then begin
            UpdateMainImage(True);
           end;
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
               winMainImage.Canvas.
               Pixels[(FhTbl[CurROIadr,CntY,CntX].X + i),
                       FhTbl[CurROIadr,CntY,CntX].Y] := ROIvar.ROICol[CurROIadr] else
               if Zoom = 2 then
               winMainImage.Canvas.
               Pixels[(FhTbl[CurROIadr,CntY,CntX].X + i) shl Zm,
                       FhTbl[CurROIadr,CntY,CntX].Y shl Zm] := ROIvar.ROICol[CurROIadr] else
               if Zoom = -2 then
               winMainImage.Canvas.
               Pixels[(FhTbl[CurROIadr,CntY,CntX].X + i) shr Zm,
                       FhTbl[CurROIadr,CntY,CntX].Y shr Zm] := ROIvar.ROICol[CurROIadr];
               Inc(CntX,2);
            End; {while}
           End Else {If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin}
           If (High(FhTbl[CurROIadr,CntY]) = 0) Then  {For a single Pixel}
              if Zoom = 1 then
              winMainImage.Canvas.
              Pixels[FhTbl[CurROIadr,CntY,0].X,
                     FhTbl[CurROIadr,CntY,0].Y]  := ROIvar.ROICol[CurROIadr] else
              if Zoom = 2 then
              winMainImage.Canvas.
              Pixels[FhTbl[CurROIadr,CntY,0].X shl Zm,
                     FhTbl[CurROIadr,CntY,0].Y shl Zm]  := ROIvar.ROICol[CurROIadr] else
              if Zoom = -2 then
              winMainImage.Canvas.
              Pixels[FhTbl[CurROIadr,CntY,0].X shr Zm,
                     FhTbl[CurROIadr,CntY,0].Y shr Zm]  := ROIvar.ROICol[CurROIadr];
          End; {For CntY := 0 to High(TabFh) do begin}
                  {--- End of Fill In ---}
          ROIvar.FillFh := CurROIadr;
        
        end else begin{if (ROIvar.FillFh <> CurROIadr)}
          ROIvar.FillFh := 0;
          UpdateMainImage(True);
        end;
      if (RatioOn) or (ChannelsRatioOn) then
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,5,3)
      else
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,7,1);

              {-- End of Calc Mean --- }
          CurROIadr := 0;
          InROI := False;
      End; {(InROI = True)}

    End;  {If (ssRight in Shift) and (ROIvar.NrROI > 0)}
    if (button = mbLeft) or (InROI = True) then RedrawAvIm := True else RedrawAvIm := False;

  End; {If  (frmImageControl.Freehand.Down = True) Then Begin}
End
  Else
 {-------------------------------------------------------------------------------}
If  (XYprofileRectVisible) and (button = mbLeft)
      and (XYprofileRectMove <> NO_MOVE) Then Begin

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
    UpdateMainImage(True);
    memBMP.Assign(winMainImage.Picture.Bitmap); //Saves to Bitmap without Sel Box
    XYprofileRectVisible := True;
    DrawSelFrame(winMainImage.Canvas);

    RedrawAvIm := True;
  End;   //XY Profile

{--------------------------- End of All Modes of Analysisi--- }

     
End; {MainImLoaded = True}
End; {procedure TfrmMainWin.winMainImageMouseDown}

{******************************************************************************}

 Procedure TfrmMainWin.PlaceBoxOrMarkAtMax(Const PutBox : Byte);

 Var CntX, CntY, XLL,Xrr,Yupp,Ydd, XLmax,XrMax,YupMax,YdMax : Integer;
     MaxVal  : Double;
     JunkMax : Double;
     FreeAdr : Integer;
     Lab     : AnsiString;
     SetPar  : Boolean;

     procedure SetMarkArray(var MarkArrXY :TMarkArrXY; var MarkAmpl : TDyn2DSingleArr;
                             var MarkBase : TDyn2DSingleArr;var MarkEvDur : TMarkArrDur;
                             var MarkRiseTime : TDyn2DSingleArr;
                             Const Xmouse, Ymouse : Integer);

     begin

     End;


     
Begin


     SetPar := True;


  If ((Xr - Xl + 1) > ROIvar.BoxXsize) and ((Yd - Yup + 1) > ROIvar.BoxYsize) then Begin

      MaxVal  := -1;

     {1st: Finds Maximum}

    For CntY := Yup to (Yd - ROIvar.BoxYsize + 1) Do Begin
      For CntX := XL to (Xr - ROIvar.BoxXsize + 1) Do Begin
          XLL   :=  CntX;
          Xrr   :=  CntX + ROIvar.BoxXsize - 1; {Gives The Included Pixel Size}
          Yupp  :=  CntY;
          Ydd   :=  CntY + ROIvar.BoxYsize - 1; {Gives The Included Pixel Size}
          JunkMax := GetMeanROI(XLL,Xrr,Yupp,Ydd,1);
          if (MaxVal < JunkMax) then Begin
              MaxVal := JunkMax;
              XlMax  := XLL;
              XrMax  := Xrr;
              YupMax := Yupp;
              YdMax  := Ydd;
          end;
      End; {CntX}
    End; {CntY}

    ////////////////////////////////////////////////////////////
         {Option 1 = Puts a Box}
      If PutBox = 1 Then Begin
        FreeAdr  := GetFirstFreeAddress;
        Inc(ROIvar.NrROI);
        ROIvar.ROICoor[1,FreeAdr] := XLMax;
        ROIvar.ROICoor[2,FreeAdr] := YupMax ;
        ROIvar.ROICoor[3,FreeAdr] := XrMax;
        ROIvar.ROICoor[4,FreeAdr] := YdMax;
        ROIvar.ROIAdr   [FreeAdr] := 1;
        With  winMainImage.Canvas Do Begin
        if ROIvar.UseMonoCol = false then
        Pen.Color := ROIvar.ROICol[FreeAdr] else Pen.Color := ROIvar.MonoCol;
        Pen.Style := psSolid;
        Pen.Mode  := pmCopy;
        Pen.Width := ROIvar.TckNess;
        if Zoom = 1 then
        Rectangle(ROIvar.ROICoor[1,FreeAdr]-ROIrct.LT,
                  ROIvar.ROICoor[2,FreeAdr]-ROIrct.LT,
                  ROIvar.ROICoor[3,FreeAdr]+ROIrct.RB,
                  ROIvar.ROICoor[4,FreeAdr]+ROIrct.RB) else
        if Zoom = 2 then
        Rectangle(ROIvar.ROICoor[1,FreeAdr] shl Zm-ROIrct.LT,
                  ROIvar.ROICoor[2,FreeAdr] shl Zm-ROIrct.LT,
                  ROIvar.ROICoor[3,FreeAdr] shl Zm+ROIrct.RB + 1,
                  ROIvar.ROICoor[4,FreeAdr] shl Zm+ROIrct.RB + 1) else
        if Zoom = -2 then
        Rectangle(ROIvar.ROICoor[1,FreeAdr] shr Zm-ROIrct.LT,
                  ROIvar.ROICoor[2,FreeAdr] shr Zm-ROIrct.LT,
                  ROIvar.ROICoor[1,FreeAdr] shr Zm +
                 (ROIvar.ROICoor[3,FreeAdr]-ROIvar.ROICoor[1,FreeAdr]+1) shr Zm-1+ROIrct.RB,
                  ROIvar.ROICoor[2,FreeAdr] shr Zm +
                 (ROIvar.ROICoor[4,FreeAdr]-ROIvar.ROICoor[2,FreeAdr]+1) shr Zm-1+ROIrct.RB);
        End;
 {----labels}
if ROIvar.UseROINr = True then
 with frmMainWin.winMainImage.Canvas do begin
          Font.Name := 'Arial';
          Font.Size := 8;
          if ROIvar.UseMonoFontCol = False then
          Font.Color := ROIvar.ROICol[FreeAdr] else Font.Color := ROIvar.MonoFontCol;
          Lab := IntToStr(FreeAdr);
      if Zoom = 1 then begin
         if YupMax - 14 > 0 then
TextOut((XLMax+(XrMax-XLMax+1)shr 1) - (Length(Lab)*6) shr 1,YupMax - 16,Lab) else
TextOut((XLMax+(XrMax-XLMax+1)shr 1) - (Length(Lab)*6) shr 1,YdMax  + 2, Lab);
      end else
      if Zoom = 2 then begin
         if YupMax shl Zm - 14 > 0 then
TextOut((XLMax+(XrMax-XLMax+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,YupMax shl Zm - 16,Lab) else
TextOut((XLMax+(XrMax-XLMax+1)shr 1) shl Zm - (Length(Lab)*6) shr 1,YdMax  shl Zm + 2, Lab);
      end else
      if Zoom = -2 then begin
         if YupMax shr Zm - 14 > 0 then
TextOut((XLMax+(XrMax-XLMax+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,YupMax shr Zm - 16,Lab) else
TextOut((XLMax+(XrMax-XLMax+1)shr 1) shr Zm - (Length(Lab)*6) shr 1,YdMax  shr Zm + 2, Lab);
      end;
end;
       if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XLMax,XrMax,YupMax,YdMax,1),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XLMax,XrMax,YupMax,YdMax,1),ffFixed,7,1);

End {PutBox = 1} Else
  ///////////////////////////////////////////////////////////////////////
  {PutBox = 2 & 3 is for Placing Marks at Maximum as Measured with a Box = BoxSize (current)}
If PutBox = 2 Then Begin {Puts Small Event Mark}

    AddMarkToMarkArray(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,
                       XLMax + (XrMax - XLMax)  shr 1 + (1 - ROIvar.BoxXsize mod 2),
                       YupMax +(YdMax - YupMax) shr 1 + (1 - ROIvar.BoxYsize mod 2),False);

    PlaceMark(MarkSmEvCoor[CurIm,High(MarkSmEvCoor[CurIm])].X,MarkSmEvCoor[CurIm,High(MarkSmEvCoor[CurIm])].Y,
              MarkPar.SmallEventColor,winMainImage.Canvas,SetPar);
End Else
If PutBox = 3 Then Begin {Puts Big Event Mark}
   AddMarkToMarkArray(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,
                       XLMax + (XrMax - XLMax)  shr 1 + (1 - ROIvar.BoxXsize mod 2),
                       YupMax +(YdMax - YupMax) shr 1 + (1 - ROIvar.BoxYsize mod 2),False);

   PlaceMark(MarkBigEvCoor[CurIm,High(MarkBigEvCoor[CurIm])].X,MarkBigEvCoor[CurIm,High(MarkBigEvCoor[CurIm])].Y,
             MarkPar.BigEventColor,winMainImage.Canvas,SetPar);  

End;


End  {If ((Xr - Xl + 1) > ROIvar.BoxXsize) and ((Yd - Yup + 1) > ROIvar.BoxYsize)}

Else  MessageDlg('Increase the Size of Frame',mtWarning,[mbOK],0);

End; {Procedure TfrmMainWin.PlaceBoxOrMarkAtMax(Const PutBox : Byte);

{***********************************************************************}


procedure TfrmMainWin.winMainImageMouseMove(Sender: TObject;
          Shift: TShiftState; X, Y: Integer);

  Const Tol = 2;

  var
      CanMoveX,CanMoveY,dY           : Boolean;
      KindROI,bXs,bYs,i,CntX,CntY,dXpr,dYpr : Integer;
      Lab : AnsiString;
      TpTem : array of TPoint;

   {type TMouseButton = (mbLeft, mbRight, mbMiddle);
    ssLeft	The left mouse button is held down.
    ssRight	The right mouse button is held down.
    ssMiddle	The middle mouse button is held down.
    ssDouble	The mouse was double-clicked. }


Begin

IF (MainImLoaded = True) and (AnalInAction = False) THEN BEGIN {For All}
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

If  not(XYprofileRectVisible) Then Begin
  {---------------------Select Button -----------------------------------------}
If (frmImageControl.Select.Down = True) Then Begin {Select Button}
  
  If (ssLeft in Shift) Then Begin {Left Mouse Button}


    If (InROI = True)  Then Begin
       KindROI := abs(ROIvar.ROIAdr[CurROIadr]);

       with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);

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

       XL  := XL  + dXpr;
       Yup := Yup + dYpr;
       Xr  := Xr  + dXpr;
       Yd  := Yd  + dYpr;

       KeepAllROIinWindow(KindROI,XL,Xr,dXpr,Yup,Yd,dYpr,CanMoveX,CanMoveY);

      if KindROI = 1 then begin {rectangle}
        if Zoom = 1 then
        winMainImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then
        winMainImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
        if Zoom = -2 then
        winMainImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                         Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
      end else
      if KindROI = 3 then begin {Free hand}
        {updates Plygon array}
        for bXs := 0 to High(FhPol[CurROIadr]) do begin
          if CanMoveX then
            FhPol[CurROIadr,bXs].X := FhPol[CurROIadr,bXs].X + dXpr;
          if CanMoveY then
            FhPol[CurROIadr,bXs].Y := FhPol[CurROIadr,bXs].Y + dYpr;
        end; {for bXs := 0 to High(FhPol[CurROIadr])}
        {updates Y-X table}
        For CntY := 0 to High(FhTbl[CurROIadr]) do begin
          For CntX := 0 to High(FhTbl[CurROIadr,CntY]) do Begin
          if CanMoveX then
          FhTbl[CurROIadr,CntY,CntX].X := FhTbl[CurROIadr,CntY,CntX].X + dXpr;
          if CanMoveY then
          FhTbl[CurROIadr,CntY,CntX].Y := FhTbl[CurROIadr,CntY,CntX].Y + dYpr;
          End;
        End; {For CntY := 0 to High(FhTbl[CurROIadr])}
        if Zoom = 1 then
        winMainImage.Canvas.Polygon(FhPol[CurROIadr]) else
        if Zoom = 2 then begin
          SetLength(TpTem,Length(FhPol[CurROIadr]));
          i := 0;
          while i < Length(TpTem) do begin
            TpTem[i].X := FhPol[CurROIadr,i].X shl Zm;
            TpTem[i].Y := FhPol[CurROIadr,i].Y shl Zm;
            Inc(i);
          end;
          winMainImage.Canvas.Polygon(TpTem);
        end else //zoom = 2
        if Zoom = -2 then begin
          SetLength(TpTem,Length(FhPol[CurROIadr]));
          i := 0;
          while i < Length(TpTem) do begin
            TpTem[i].X := FhPol[CurROIadr,i].X shr Zm;
            TpTem[i].Y := FhPol[CurROIadr,i].Y shr Zm;
            Inc(i);
          end;
          winMainImage.Canvas.Polygon(TpTem);
        end; //Zoom = -2
      end; {if KindROI = 3 then begin  = Free hand}
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

  {---------------Prints ROI Number Labels ----------------}
if ROIvar.UseROINr = True then
 with frmMainWin.winMainImage.Canvas do begin
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
{------- Prints mean Value of ROI on Playback Panel ---------}
if (KindROI = 1) then Begin
       if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3)
       else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
end else
if (KindROI = 3) then Begin
       if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,5,3)
       else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,7,1);
end; {KindROI = 3}
{-----------------------------------------------------------------------------}
End  {If (InROI = True)  Then Begin}

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
  with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
  DrawScaleBar(Zoom,SizeBar,winMainImage.Canvas);
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
End  //If (frmImageControl.Select.Down = True) Then Begin {Select Button}

  Else
  {-------------------------- Select Locked ------------------------------------}
If (frmImageControl.SelectLocked.Down = True) Then Begin
     If (ssLeft in Shift) and (InROI = True) Then Begin

       with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
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

      DrawROI(winMainImage.Canvas);

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
  {------------------------- Measure Box -------------------------------------}
  If  (frmImageControl.MeasureBox.Down = True) or (frmImageControl.PlaceMark.Down = True) Then Begin
      KindROI := 1;
      winMainImage.Canvas.Pen.Color := RGB(160,160,160);
      winMainImage.Canvas.Pen.Width := ROIvar.TckNess;
      if(frmImageControl.MeasureBox.Down = True)then
      winMainImage.Canvas.Pen.Style := psDot
      else winMainImage.Canvas.Pen.Style := psSolid;
      winMainImage.Canvas.Pen.Mode  := pmXOR;

      if MouseInside = True then begin
        if Zoom = 1 then
      winMainImage.
      Canvas.Rectangle(XLMem-ROIrct.LT,YupMem-ROIrct.LT,
                       XrMem+ROIrct.RB,YdMem+ROIrct.RB) else
        if Zoom = 2 then
      winMainImage.
      Canvas.Rectangle(XLMem shl Zm-ROIrct.LT,YupMem shl Zm-ROIrct.LT,
                       XrMem shl Zm+ROIrct.RB+1,YdMem  shl Zm+ROIrct.RB+1) else
        if Zoom = -2 then
      winMainImage.
      Canvas.Rectangle(XLMem shr Zm-ROIrct.LT,YupMem shr Zm-ROIrct.LT,
                       XLMem shr Zm + (XrMem-XLMem+1) shr Zm-1+ROIrct.RB,
                      YupMem shr Zm +(YdMem-YupMem+1)shr Zm-1+ROIrct.RB);
      end;     
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
      KeepROIinWindow; //does not allow box to go uotside of the window//
      if Zoom = 1 then
      winMainImage.
      Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                       Xr+ROIrct.RB,Yd+ROIrct.RB) else
      if Zoom = 2 then
      winMainImage.
      Canvas.Rectangle(XL shl Zm-ROIrct.LT,     Yup shl Zm-ROIrct.LT,
                       Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
      if Zoom = -2 then
      winMainImage.
      Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                       XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                      Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);

      if MouseInside = False then MouseInside := True;
         XLMem  := XL;
         XrMem  := Xr;
         YupMem := Yup;
         YdMem  := Yd;
      if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
     If Zoom = 1 then Begin
      if (X < XL + ROIrct.Xsize shr 1) or
         (Y < Yup + ROIrct.Ysize shr 1) or
         (X > imXsize  - ROIrct.Xsize shr 1) or
         (Y > imYsize  - ROIrct.Ysize shr 1)
      then begin
        winMainImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB);
        MouseInside := False;
        winMainImage.Canvas.Pen.Mode  := pmCopy;
      end;    
      End Else
      If Zoom = 2 then Begin
      if (X shr Zm < XL  + ROIrct.Xsize shr 1) or
         (Y shr Zm < Yup + ROIrct.Ysize shr 1)       or
         (X shr Zm > imXsize  - ROIrct.Xsize shr 1) or
         (Y shr Zm > imYsize  - ROIrct.Ysize shr 1)
      then begin
        winMainImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + Zm,Yd  shl Zm+ROIrct.RB + Zm);
        MouseInside := False;
        winMainImage.Canvas.Pen.Mode  := pmCopy;
      end;
      End Else
      If Zoom = -2 then Begin
      if (X shl Zm < XL + ROIrct.Xsize shr 1) or
         (Y shl Zm < Yup + ROIrct.Ysize shr 1)or
         (X shl Zm > imXsize  - ROIrct.Xsize shr 1) or
         (Y shl Zm > imYsize  - ROIrct.Ysize shr 1)
      then begin
        winMainImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         Xr shr Zm+ROIrct.RB - Zm,Yd  shr Zm+ROIrct.RB - Zm);
        MouseInside := False;
        winMainImage.Canvas.Pen.Mode  := pmCopy;
      end;
      End;
  End Else
  {------------------------- Put Box  -------------------------------------}
  If  (frmImageControl.PutBox.Down = True) Then Begin
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
        with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
        if Zoom = 1 then
        winMainImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then begin
         if Zm = 1 then
          winMainImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
         if Zm = 2 then
          winMainImage.
          Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                           Xr shl Zm+ROIrct.RB + 3,Yd  shl Zm+ROIrct.RB + 3);

        end
          else
        if Zoom = -2 then
        winMainImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                         Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
       {----labels}
if ROIvar.UseROINr = True then
 with frmMainWin.winMainImage.Canvas do begin
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
       if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
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
        KeepROIinWindow; 
        with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
        if Zoom = 1 then
        winMainImage.
        Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                         Xr+ROIrct.RB,Yd+ROIrct.RB) else
        if Zoom = 2 then
        winMainImage.
        Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                         Xr shl Zm+ROIrct.RB + 1,Yd  shl Zm+ROIrct.RB + 1) else
        if Zoom = -2 then
        winMainImage.
        Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                         XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                        Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
       {----labels}
if ROIvar.UseROINr = True then
 with frmMainWin.winMainImage.Canvas do begin
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
{----------------}
         if (RatioOn) or (ChannelsRatioOn) then
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,5,3) else
  frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanROI(XL,Xr,Yup,Yd,KindROI),ffFixed,7,1);
    End;  {If (ssRight in Shift) and (InROI = True) }
End

  Else

  {----------------------- Selection Frame ----------------------------------}
  {------- it was changed in March 2012 to be able to resize it with theMouse}
If  (frmImageControl.SelectionFrameChange.Down) Then Begin

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

 With SelFrame do Begin

  If (Shift = []) then Begin  //Nothing was pressed

    if (dXpr > Left+Tol) and (dXpr < Right-Tol) and (dYpr > Top+Tol) and (dYpr < Bottom-Tol) then
    begin
      //Canvas.c := crHandPoint;
      winMainImage.Cursor := crHandPoint;;
      SelFrameMove := MOVE_ALL;
    end else
    if (dXpr > Left) and (dXpr < Right) and (dYpr < Top+Tol) and (dYpr > Top-Tol) then
    begin
      winMainImage.Cursor := crSizeNS;
      SelFrameMove := MOVE_UP;
    end else
    if (dXpr > Left) and (dXpr < Right) and (dYpr < Bottom+Tol) and (dYpr > Bottom-Tol) then
    begin
      winMainImage.Cursor := crSizeNS;
      SelFrameMove := MOVE_DOWN;
    end else
    if (dXpr < Left+Tol) and (dXpr > Left-Tol) and (dYpr > Top) and (dYpr < Bottom) then
    begin
      winMainImage.Cursor := crSizeWE;
      SelFrameMove := MOVE_LEFT;
    end else
    if (dXpr < Right+Tol) and (dXpr > Right-Tol) and (dYpr > Top) and (dYpr < Bottom) then
    begin
      winMainImage.Cursor := crSizeWE;
      SelFrameMove := MOVE_RIGHT;
    end else
    begin
      winMainImage.Cursor := crDefault;
      SelFrameMove := NO_MOVE;
    end;
 End

  Else

 If (ssLeft in Shift) and (MainImLoaded)  then with winMainImage do
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

     DrawSelFrame(winMainImage.Canvas);

    with frmImageControl do begin
      TitleXofROI.Caption :=  'Width  = '  + IntToStr(SelFrame.Width+1) +
                           ';  L = '    + IntToStr(SelFrame.Left) +
                           ';  R = '   + IntToStr(SelFrame.Right);

      TitleYofROI.Caption := 'Height = ' + IntToStr(SelFrame.Height+1) +
                           '; T = '    + IntToStr(SelFrame.Top) +
                           '; B = '    + IntToStr(SelFrame.Bottom);
    end;
    //----------------   3D Image  ------------------------//
    if (Win3DOn) and (SourceFor3D in[MAIN_IMAGE_FOR_3D,AVER_IMAGE_FOR_3D,MERGE_IMAGE_FOR_3D]) and
        (frmImageControl.ubApplyFrame.Selected) then
    begin
        frm3DImageWin.Update3DImage(True);
    end;

  End; //If (SelFrameMove <> NO_MOVE) then begin
 End; //If (ssLeft in Shift)
 End; //With SelFrame do Begin
End

  Else

 {------------------ Measure Distance ----------------------------------------}
If  (frmImageControl.MeasureDistance.Down = true) Then Begin
  If (DiamMesRect.OpCode <> IN_TRACKING) Then Begin

 With MesLine Do Begin

  If (ssLeft in Shift) Then Begin

    If (MesLine.OpCode = IN_DRAWING) Then Begin
      with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X,LineBeg.Y,X,Y,winMainImage.Canvas);
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
      with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X + dXpr,LineBeg.Y + dYpr,LineEnd.X + dXpr,LineEnd.Y + dYpr,winMainImage.Canvas);
    End Else

    If (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then Begin
      if (MesLine.Orientation = MORE_HORIZONTAL) then begin
        dXpr := (X - Pr.X);
        if (DiamMesRect.OpCode = BEG_SEL) then
        SetDiamMesRectBegAndEnd(LineBeg.X,DiamMesRect.RectBeg.X,DiamMesRect.OffsXorYbeg,dXpr) else
        if (DiamMesRect.OpCode = END_SEL) then
        SetDiamMesRectBegAndEnd(LineEnd.X,DiamMesRect.RectEnd.X,DiamMesRect.OffsXorYend,dXpr);
      end else
      if (MesLine.Orientation = MORE_VERTICAL) then begin
        dYpr := (Y - Pr.Y);
        if (DiamMesRect.OpCode = BEG_SEL) then
        SetDiamMesRectBegAndEnd(LineBeg.Y,DiamMesRect.RectBeg.Y,DiamMesRect.OffsXorYbeg,dYpr) else
        if (DiamMesRect.OpCode = END_SEL) then
        SetDiamMesRectBegAndEnd(LineEnd.Y,DiamMesRect.RectEnd.Y,DiamMesRect.OffsXorYend,dYpr);
      end;

      with winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,winMainImage.Canvas);
    End; //If (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then Begin

  End Else
  If (Shift = []) Then Begin //Nothing was pressed

    If (OpCode in [DO_EXIST,MIDDLE_SEL,BEG_SEL,END_SEL]) then Begin
      CheckIfMesLineSelected(X,Y);
      if (OpCode = MIDDLE_SEL)         then winMainImage.Cursor := crBlackArrow else
      if (OpCode in [BEG_SEL,END_SEL]) then winMainImage.Cursor := crCircle else
                                            winMainImage.Cursor := crDefault;
    End;

    If (DiamMesRect.OpCode in [DO_EXIST,BEG_SEL,END_SEL]) then Begin
      CheckIfMesDiamSelected(X,Y);
      if (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then winMainImage.Cursor := crCircle;
    End;

  End; //If (Shift = []) Then Begin
 End; //with
 End; //If (DiamMesRect.OpCode <> IN_TRACKING) Then Begin
End Else
  {---------------------- Free Hand -------------------------------------------}
  If  (frmImageControl.Freehand.Down = True) Then Begin
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

          winMainImage.Canvas.MoveTo(Pr.X,Pr.Y);
          winMainImage.Canvas.LineTo(X,Y);
          Pr.X := X;
          Pr.Y := Y;
    End; { If (ssLeft in Shift) and (ROIvar.NrROI <= 20) Then Begin}

  End; {If  (frmImageControl.Freehand.Down = True)}
End //If  (frmImageControl.sbXYprofile.Down) Then Begin

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
      winMainImage.Cursor := crSizeNS;
      XYprofileRectMove := MOVE_UP;
    end else
    if (dXpr > (Width shr 1)+Left-1 - Tol) and (dXpr < (Width shr 1)+Left+1 + Tol) and
       (dYpr < Bottom+Tol) and (dYpr > Bottom-Tol) then
    begin
      winMainImage.Cursor := crSizeNS;
      XYprofileRectMove := MOVE_DOWN;
    end else
    if (dXpr < Left+Tol) and (dXpr > Left-Tol) and
       (dYpr > (Height shr 1)+Top-1 - Tol) and (dYpr < (Height shr 1)+Top+1 + Tol) then
    begin
      winMainImage.Cursor := crSizeWE;
      XYprofileRectMove := MOVE_LEFT;
    end else
    if (dXpr < Right+Tol) and (dXpr > Right-Tol) and
       (dYpr > (Height shr 1)+Top-1 - Tol) and (dYpr < (Height shr 1)+Top+1 + Tol) then
    begin
      winMainImage.Cursor := crSizeWE;
      XYprofileRectMove := MOVE_RIGHT;
    end else
    if (dXpr >= Left-Tol) and (dXpr <= Right+Tol) and (dYpr >= Top-Tol) and (dYpr <= Bottom+Tol) then
    begin
      winMainImage.Cursor := crHandPoint;;
      XYprofileRectMove := MOVE_ALL;
    end else
    begin
      winMainImage.Cursor := crDefault;
      XYprofileRectMove := NO_MOVE;
    end;

  End;  //If (Shift = []) then Begin

 If (ssLeft in Shift) and (MainImLoaded)  then with winMainImage do
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

    DrawSelFrame(winMainImage.Canvas);

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

End;  //If  (XYprofileRectVisible) Then Begin
  {----------------------------------------------------------------------------}
End; {MainImLoaded = True}

End; { procedure TfrmMainWin.winMainImageMouseMove}
 {**************************************************************************}
procedure TfrmMainWin.winMainImageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
       {Deals With ROI (Boxes, Circles, ect) }


Begin


IF (MainImLoaded = True) and (AnalInAction = False) THEN BEGIN {For All}
  RedrawRestOfWindows := 0; // 0 = Do not redrow, 1 = Redraw Merge Window, 2 Redraw Merge and Secondary windows

 {-----------------------------------------------------------------------------}
 If (frmImageControl.Select.Down = True) and (Button = mbLeft) Then Begin
    If (InROI = True) Then Begin
        UpdateROI;
        CurROIadr := 0;
        InROI     := False;
    End
      Else
    If (InScaleBar) then Begin
      RedrawRestOfWindows := 2;
      InScaleBar          := False;
    End;
   {The Middle and Right button Mouse Up are not Used so far}
 End Else
 {-------------------------- Select Locked  ---------------------------------------------------}
 If (frmImageControl.SelectLocked.Down = True) Then Begin
  If (Button = mbLeft) and (InROI = True) Then Begin
        {nothing else is needed so far}
    InROI := False;
  End;
 End Else
 {-------------------------- Put Box ---------------------------------------------------}
 If (frmImageControl.PutBox.Down) then begin
   ROIselected := CurROIadr; //Save CurROIadr to ROIselected
    //to be used for Manual Positioning of ROI with Typing on the Playback Window
  If (Button = mbLeft) and (CurROIadr > 0) Then Begin
          UpdateROI;        
          CurROIadr := 0;
  End else
  If (Button = mbRight) and (InROI) Then Begin
        UpdateROI;
        CurROIadr := 0;
        InROI     := False;
  End;

  if (ROIselected > 0) then
    frmPlayback.lbSetROI_XY.Caption := 'Set X,Y ROI # ' + IntToStr(ROIselected)
    else
      frmPlayback.lbSetROI_XY.Caption := 'Set X,Y ROI # ';

End

  Else

{------------------- Selection Frame --------------------------------------}
 If (frmImageControl.SelectionFrameChange.Down) and (Button = mbLeft) Then Begin
    ClipCursor(NIL);  {Removes Cursor Restrictions}
    If (SelFrameMove <> NO_MOVE) then Begin
      RedrawAvIm := True;
      RedrawRestOfWindows := 2;
    End;
   {The Middle and Right button Mouse Up are not Used so far}
  End Else
{-------------------------------------------------------------------------}

 If  (frmImageControl.Freehand.Down) and (Button = mbLeft) Then Begin

     ClipCursor(NIL);  {Removes Cursor Restrictions}

 If (CntFh <= 5) and (CurROIadr > 0) Then Begin  {Deletes ROI since it is too Small}
  CurROIkind := 0;     {3 is for Free Hand}
  Dec(ROIvar.NrROI); {Was incremented in Mouse Down}
  UpdateMainImage(True);
 End Else
 If (CntFh > 5) and (CurROIadr > 0) Then Begin
    FinishFhROI(X,Y,CntFh);
    UpdateROI;
    UpdateMainImage(True);

   if (RatioOn) or (ChannelsRatioOn) then
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,5,3)
    else
        frmPlayback.lblROIval.Caption := FloatToStrF(GetMeanFhROI(OnMainIm),ffFixed,7,1);

    CurROIadr := 0;
 End; {If (CntFh > 5) Then Begin}
 End Else {(frmImageControl.Freehand.Down = True) and (Button = mbLeft)}
 {-------------------------------------------------------------------------}
 If (frmImageControl.MeasureDistance.Down) and (Button = mbLeft) and
    (DiamMesRect.OpCode <> IN_TRACKING) Then Begin
    
  ClipCursor(NIL);
  if (MesLine.OpCode > DO_EXIST) then begin
    //this should be before CalculateMesLineParams since they set MesLine.OpCode := DO_EXIST
      RedrawAvIm := True;
      RedrawRestOfWindows := 1;
  end;

  if (MesLine.OpCode = IN_DRAWING)then CalculateMesLineParams(X,Y) else
  if (MesLine.OpCode = IN_MOVING) then CalculateMesLineParams(X - Pr.X,Y - Pr.Y);

  if (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then begin
    { Follows MouseUp after Resizing the Diameter Measuring Rectangle. Specific for Mian Image Only }
    if (MesLine.Orientation = MORE_HORIZONTAL) then 
       CalculateOffsXorYbeg(MesLine.LineBeg.X,MesLine.LineEnd.X) else
    if (MesLine.Orientation = MORE_VERTICAL) then
      CalculateOffsXorYbeg(MesLine.LineBeg.Y,MesLine.LineEnd.Y);
    ScaleOffsXorYbegToReal;
    DiamMesRect.OpCode := DO_EXIST;
  end;

 End;
{-------------------------------------------------------------------------}
          //      InROI := False;   ???????????????????????
     {Sets Pixels to Black in Main Image if needed}
     {this is the only place in This Unit where it does this}
 If (frmImageControl.btZeroOutsideROI_All_Images.Down) and (RedrawAvIm = True) then begin
    if (ROIvar.NrROI = 0) then begin
      frmImageControl.btZeroOutsideROI_All_Images.Down := False;
      frmImageControl.btZeroOutsideROI_All_Images.Click;
    end
    else frmPlayback.PlaybackScrollBarChange(Sender);
  End; //if (frmImageControl.btZeroOutsideROI_All_Images.Down)

        {Refreshes Average Image}
  If (RedrawAvIm) and (frmAverIm <> nil) and (AvImExists > 0) Then Begin
      UpdateAverImage(True);
      RedrawAvIm := False;
  End; {If (RedrawAvIm = True) and (frmAverIm <> nil) and (AvImExists > 0)}

  If (RedrawRestOfWindows > 0) and (NrChannels > 1)then Begin
    if (RedrawRestOfWindows >= 1) and (frmMergeWin <> nil) then DisplayMergeImage;
    if (RedrawRestOfWindows =  2) and (frm2ndWin <> nil)   then Display2ndChannel;
  End;

 End; {(MainImLoaded = True)}

End; {procedure TfrmMainWin.winMainImageMouseUp}
{******************************************************************************}
procedure TfrmMainWin.winMainImageMouseLeave(Sender: TObject);
begin
    if (MouseInside = True) then begin
      if Zoom = 1 then
       winMainImage.
       Canvas.Rectangle(XL-ROIrct.LT,Yup-ROIrct.LT,
                        Xr+ROIrct.RB,Yd+ROIrct.RB) else
       if Zoom = 2 then
       winMainImage.
       Canvas.Rectangle(XL shl Zm-ROIrct.LT,Yup shl Zm-ROIrct.LT,
                        Xr shl Zm+ROIrct.RB+1,Yd  shl Zm+ROIrct.RB+1) else
       if Zoom = -2 then
       winMainImage.
       Canvas.Rectangle(XL shr Zm-ROIrct.LT,Yup shr Zm-ROIrct.LT,
                        XL shr Zm + (Xr-XL+1) shr Zm-1+ROIrct.RB,
                       Yup shr Zm +(Yd-Yup+1)shr Zm-1+ROIrct.RB);
       MouseInside := False;
       winMainImage.Canvas.Pen.Mode  := pmCopy;
    end;
end;
{******************************************************************************}
       {Closing = Hiding window}
procedure TfrmMainWin.WMSize(var M:TWMSIZE);
  //moves Playback Control window
begin

if (M.SizeType=Size_Minimized) or (frmMainWinHidden = True) then begin
    frmPlayBack.Docked := False;
    frmPlayBack.CanDock := False;
    frmPlayBack.pnFakeBar.Color := $00FED8DF; //$00FEE9D3; //light blue
end else
if (M.SizeType<>Size_Minimized) and (frmMainWinHidden = False) then begin
    frmPlayBack.CanDock := True;
end;
if (M.SizeType=Size_Minimized) and (frmMainWinHidden = True) then begin
    ShowWindow(frmMainWin.Handle,Sw_Hide);
end
    else inherited;  {use inherited to invoke OnResize}
End;



procedure TfrmMainWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin

    frmPlayBack.Docked := False;
    frmPlayBack.CanDock := False;
    frmPlayBack.pnFakeBar.Color := $00FED8DF;//$00FEE9D3; //light blue
    frmMainWinHidden := True;
    if (frmMainWin.WindowState = wsMinimized) then
    ShowWindow(frmMainWin.Handle,Sw_Hide);

End;
 {------------------------------------------------------------------------------}
procedure TfrmMainWin.WMWINDOWPOSCHANGED (Var Msg: TWMWINDOWPOSCHANGED);
begin
  inherited; //needed!!

    if (frmPlayBack.Docked = True) then Begin
      //keeps frmPlayBack on top if obscured
      SetWindowPos(frmPlayBack.Handle,HWND_TOP,frmPlayBack.Left,frmPlayBack.Top,
                  frmPlayBack.Width,frmPlayBack.Height,SWP_NOACTIVATE or SWP_NOSIZE);
      // HWND_TOPMOST did not work!!!    
      frmPlayBack.Top  := frmMainWin.Top  + frmMainWin.Height;
      frmPlayback.Xoffset := (frmPlayback.ClientWidth - frmMainWin.ClientWidth) div 2;
      frmPlayback.CenterOffs := frmPlayback.Xoffset;
      frmPlayBack.Left := frmMainWin.Left - frmPlayBack.Xoffset;

    end;

End;
{------------------------------------------------------------------------------}

{-------------------- To handle Labels For Movies -----------------------------}
procedure TfrmMainWin.CommentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (button = mbLeft) then begin
    if (Sender is TEdit)  then with (Sender as TEdit)  do SetCapture(Handle) else
    if (Sender is TLabel) then with (Sender as TLabel) do SetCapture(Canvas.Handle);
    Capturing := True;
    MouseDownSpot.X := X;
    MouseDownSpot.Y := Y;
    if (frmMovieLabels <> nil) then frmMovieLabels.SetEdCommentsColor(Sender,Button,Shift,X,Y);
  end;
end;

procedure TfrmMainWin.CommentMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Capturing then begin
   if (Sender is TEdit) then with (Sender as TEdit) do begin
    if Left - (MouseDownSpot.x - x) > -1 then Left := Left - (MouseDownSpot.x - x);
    if Top  - (MouseDownSpot.y - y) > -1 then Top  := Top  - (MouseDownSpot.y - y);
   end else
   if (Sender is TLabel) then with (Sender as TLabel) do begin
    if Left - (MouseDownSpot.x - x) > -1 then Left := Left - (MouseDownSpot.x - x);
    if Top  - (MouseDownSpot.y - y) > -1 then Top  := Top  - (MouseDownSpot.y - y);
   end; 
  end;

end;

procedure TfrmMainWin.CommentMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Capturing then begin
    ReleaseCapture;
    Capturing := false;
    if (Sender is TEdit) then with (Sender as TEdit) do begin
    if Left - (MouseDownSpot.x - x) > -1 then Left := Left - (MouseDownSpot.x - x);
    if Top  - (MouseDownSpot.y - y) > -1 then Top  := Top  - (MouseDownSpot.y - y);
   end else
   if (Sender is TLabel) then with (Sender as TLabel) do begin
    if Left - (MouseDownSpot.x - x) > -1 then Left := Left - (MouseDownSpot.x - x);
    if Top  - (MouseDownSpot.y - y) > -1 then Top  := Top  - (MouseDownSpot.y - y);
   end;
  end;

end;


{-------------------- End of To handle Labels For Movies ----------------------}


END. {end Form}
