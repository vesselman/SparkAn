unit unMergeWindow;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, Vcl.Graphics,Vcl.Controls, Vcl.StdCtrls, Vcl.ExtCtrls,Vcl.Dialogs;

type
  TfrmMergeWin = class(TForm)
    MergeImage: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MergeImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MergeImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MergeImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    RedrawWindows : Byte; //0 = false; 1 = All Windows bu not Secondary; 2 = All Windows includiong Secondary
  public
    { Public declarations }
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
  frmMergeWin: TfrmMergeWin;

implementation

Uses  unGlobUnit, unMainWindow, unImageControl, unTimeSerAnal,
      unSparkTable, unWaveTable, unPlayBack, unFrameTimSerPlot, un3DImageWin,
  unAverIm, MovieLabels, un2ndWin;

{$R *.dfm}

procedure TfrmMergeWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      //2nd set CheckBox in frm Movie Labels
  If (TargetForLabels = WINDOW_MERGE) then Begin
    if (frmMovieLabels = nil) then TargetForLabels := WINDOW_MAIN
      else
    if (frmMovieLabels <> nil) then frmMovieLabels.rbMainWindow.Checked  := True;
  End;

  if (frmMovieLabels <> nil) then frmMovieLabels.rbMergeWindow.Enabled := False;

  Action    := caFree;
  frmMergeWin := nil;
end;

procedure TfrmMergeWin.FormCreate(Sender: TObject);
begin
  With frmMergeWin Do Begin
    DoubleBuffered := True;
    Position := poScreenCenter;

    If (MainImLoaded = True) then Begin
      SetFormSize(frmMergeWin,MergeImage);
    End Else
    Begin    {Nothing was loaded yet}
      ClientWidth := 256;
      ClientHeight := 256;
      MergeImage.Picture.Bitmap.Width := 256;  {keep this}
      MergeImage.Picture.Bitmap.Height := 256; {keep this}
    End;
   End;
End;

procedure TfrmMergeWin.FormShow(Sender: TObject);
begin
  with frmMergeWin.MergeImage do begin

  If not(MainImLoaded) or (NrChannels = 1) then Begin
    Canvas.Brush.Color := clBlack;
    Canvas.FillRect(Canvas.ClipRect);
    Canvas.Brush.Style := bsClear;
    //frmMergeWin.Caption := '';
  End Else
  If (MainImLoaded) and (NrChannels > 1) then begin
    DisplayMergeImage;
    if (frmMovieLabels <> nil) then frmMovieLabels.rbMergeWindow.Enabled := True;
  end;
  end;//with frmMergeWin.MergeImage do begin
End;

{-------------------- To handle Labels For Movies -----------------------------}
procedure TfrmMergeWin.CommentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (button = mbLeft) then begin
    if (Sender is TEdit)  then with (Sender as TEdit)  do SetCapture(Handle) else
    if (Sender is TLabel) then with (Sender as TLabel) do SetCapture(Canvas.Handle);
    Capturing := true;
    MouseDownSpot.X := x;
    MouseDownSpot.Y := Y;
    if (frmMovieLabels <> nil) then frmMovieLabels.SetEdCommentsColor(Sender,Button,Shift,X,Y);
  end;

end;

procedure TfrmMergeWin.CommentMouseMove(Sender: TObject; Shift: TShiftState;
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

procedure TfrmMergeWin.CommentMouseUp(Sender: TObject; Button: TMouseButton;
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

{****************************************************************************}
Procedure TfrmMergeWin.MergeImageMouseDown(Sender: TObject; Button: TMouseButton;
                                           Shift: TShiftState; X, Y: Integer);
Var
    Xm,Ym,i        : integer;
    Pt             : TPoint;
    CursorClipArea : TRect;
    MouseMov       : TMouseMoveEvent;
Begin

If (MainImLoaded = True) and (AnalInAction = False) and (NrChannels > 1) Then Begin

     RedrawWindows := 0; // set to Zero for all actions

   {----------------------- Scale Bar ----------------------------}

  If (SizeBarVisible) and (frmImageControl.Select.Down) and (button = mbLeft) Then Begin //Select Button//
  //this is for the Scale Bar Only

      if (Zoom = 1) then CheckIfInScaleBar(X,Y,SizeBar,frmImageControl.ubSizeBar.Selected) else
      if (Zoom = 2) then CheckIfInScaleBar(X shr Zm,Y shr Zm,SizeBar,frmImageControl.ubSizeBar.Selected) else
      if (Zoom =-2) then CheckIfInScaleBar(X shl Zm,Y shl Zm,SizeBar,frmImageControl.ubSizeBar.Selected);

      If (InScaleBar) then Begin
        SizeBarVisible := False;//to prevent drawing SizeBar by UpdateMainImage
        DisplayMergeImage;
        SizeBarVisible := True; //restores value
        memBMP.Assign(MergeImage.Picture.Bitmap); //aves to Bitmap without Sel Box//
        DrawScaleBar(Zoom,SizeBar,MergeImage.Canvas);
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

    if    (InScaleBar) then RedrawWindows := 2 else
    if not(InScaleBar) then RedrawWindows := 0;

  End //frmImageControl.Select.Down = True

    Else

    {----------------------- Selection Frame ----------------------------}
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

    SelFrameVisible := False; //so DisplayMergeImage Not to Draw SelFrame
    DisplayMergeImage;
    memBMP.Assign(MergeImage.Picture.Bitmap); //Saves to Bitmap without Sel Box
    SelFrameVisible := True;
    DrawSelFrame(MergeImage.Canvas);

    CursorClipArea := Bounds(MergeImage.ClientOrigin.X,
                             MergeImage.ClientOrigin.Y,
                             MergeImage.Width,MergeImage.Height);
    ClipCursor(@CursorClipArea);

  End //If  (frmImageControl.SelectionFrameChange.Down) and (button = mbLeft) and (SelFrameMove <> NO_MOVE)

   Else
   {----------------- Measure Distance ------------------------}

  If  (frmImageControl.MeasureDistance.Down) and (DiamMesRect.OpCode <> IN_TRACKING) and
      (DiamMesRect.OpCode <> IN_TRACKING) Then Begin

      //Restrict Cursor
    CursorClipArea := Bounds(frmMergeWin.ClientOrigin.X,
                             frmMergeWin.ClientOrigin.Y,
                             frmMergeWin.Width,frmMergeWin.Height);
    ClipCursor(@CursorClipArea);

     With MesLine do begin

      If (OpCode = NOT_EXIST) Then Begin
        Application.ProcessMessages;  // prevents Line Drawing before Moving
        OpCode := IN_DRAWING;
        LineBeg.X := X;
        LineBeg.Y := Y;
        memBMP.Assign(MergeImage.Picture.Bitmap); {Saves to Bitmap }
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

      End
        Else
      If (OpCode in [MIDDLE_SEL,BEG_SEL,END_SEL]) Then Begin
        //Converts Real Coordinates to Current Image Coordinates
        if (Zoom = 2) then begin
          LineBeg.X := LineBeg.X shl 1;
          LineBeg.Y := LineBeg.Y shl 1;
          LineEnd.X := LineEnd.X shl 1;
          LineEnd.Y := LineEnd.Y shl 1;
        end else
        if (Zoom = -2) then begin
          LineBeg.X := LineBeg.X shr 1;
          LineBeg.Y := LineBeg.Y shr 1;
          LineEnd.X := LineEnd.X shr 1;
          LineEnd.Y := LineEnd.Y shr 1;
        end;
        DisplayMergeImage;
        memBMP.Assign(MergeImage.Picture.Bitmap); {Saves to Bitmap }

        If (OpCode =  MIDDLE_SEL) Then Begin
          OpCode := IN_MOVING;
          Pr.X := X;
          Pr.Y := Y;
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,MergeImage.Canvas);
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
          Pt := ClientToScreen(Point(MergeImage.Left+LineEnd.X, MergeImage.Top+LineEnd.Y));
          MouseMov := MergeImage.OnMouseMove;
          MergeImage.OnMouseMove := nil;  //if not diasbled SetCursorPos triggers MouseMove Event

          SetCursorPos(Pt.X,Pt.Y); //Win32 API  - uses Global (screen) coordinates
          Application.ProcessMessages; //must be here, otherwise Move event will be generated after OnMouseMove := MouseMov;
          MergeImage.OnMouseMove := MouseMov;
          MesLine.OpCode := IN_DRAWING;
          DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,MergeImage.Canvas);
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
        DisplayMergeImage;
        MesLine.OpCode := DO_EXIST;
        memBMP.Assign(MergeImage.Picture.Bitmap); {Saves to Bitmap }
        ScaleOffsXorYbegToCurrent;
        DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,MergeImage.Canvas);
        Pr.X := X;
        Pr.Y := Y;
      End;

     End; // with
  End; //(frmImageControl.MeasureDistance.Down)

End; //If (MainImLoaded = True) and (AnalInAction = False) and (NrChannels > 1) Then Begin
End; ////procedure TfrmMergeWin.MergeImageMouseDown


Procedure TfrmMergeWin.MergeImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);

Const Tol = 5;
Var dXpr, dYpr,i : integer;

Begin
 If (MainImLoaded = True) and (AnalInAction = False) and (NrChannels > 1) Then Begin

  If  not(frmImageControl.SelectionFrameChange.Down) and
      not(frmImageControl.Select.Down) and
      not(frmImageControl.MeasureDistance.Down)then Cursor := crCross
  else Cursor := crArrow;


  if (Zoom = 1) then begin
  frmPlayback.lblXYcoor. Caption := IntToStr(X) + ', ' + IntToStr(Y) + ' pix';
  frmPlayback.lblXYuSize.Caption := FloatToStrF(PixSize*(X),ffFixed,3,1) + ', ' +
                             FloatToStrF(PixSize*(Y),ffFixed,3,1) + ' µ';
  end else
  if (Zoom = 2) then begin
  frmPlayback.lblXYcoor. Caption := IntToStr(X shr Zm) + ', ' + IntToStr(Y shr Zm) + ' pix';
  frmPlayback.lblXYuSize.Caption := FloatToStrF(PixSize*(X shr Zm),ffFixed,3,1) + ', ' +
                             FloatToStrF(PixSize*(Y shr Zm),ffFixed,3,1) + ' µ';
  end else
  if (Zoom = -2) then begin
  frmPlayback.lblXYcoor. Caption := IntToStr(X shl Zm) + ', ' + IntToStr(Y shl Zm) + ' pix';
  frmPlayback.lblXYuSize.Caption := FloatToStrF(PixSize*(X shl Zm),ffFixed,3,1) + ', ' +
                             FloatToStrF(PixSize*(Y shl Zm),ffFixed,3,1) + ' µ';
  end;


If (InScaleBar) and (frmImageControl.Select.Down) and (ssLeft in Shift) Then Begin //Select Button//
  //this is for the Scale Bar Only

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
  with MergeImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
  DrawScaleBar(Zoom,SizeBar,MergeImage.Canvas);
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

End   //If (InScaleBar) and (frmImageControl.Select.Down) and (ssLeft in Shift) Then Begin

  Else
   {----------------------- Selection Frame ----------------------------------}
If  (frmImageControl.SelectionFrameChange.Down) Then Begin

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

  If (Shift = []) then Begin

    if (dXpr > Left+Tol) and (dXpr < Right-Tol) and (dYpr > Top+Tol) and (dYpr < Bottom-Tol) then
    begin
      //Canvas.c := crHandPoint;
      MergeImage.Cursor := crHandPoint;;
      SelFrameMove := MOVE_ALL;
    end else
    if (dXpr > Left) and (dXpr < Right) and (dYpr < Top+Tol) and (dYpr > Top-Tol) then
    begin
      MergeImage.Cursor := crSizeNS;
      SelFrameMove := MOVE_UP;
    end else
    if (dXpr > Left) and (dXpr < Right) and (dYpr < Bottom+Tol) and (dYpr > Bottom-Tol) then
    begin
      MergeImage.Cursor := crSizeNS;
      SelFrameMove := MOVE_DOWN;
    end else
    if (dXpr < Left+Tol) and (dXpr > Left-Tol) and (dYpr > Top) and (dYpr < Bottom) then
    begin
      MergeImage.Cursor := crSizeWE;
      SelFrameMove := MOVE_LEFT;
    end else
    if (dXpr < Right+Tol) and (dXpr > Right-Tol) and (dYpr > Top) and (dYpr < Bottom) then
    begin
      MergeImage.Cursor := crSizeWE;
      SelFrameMove := MOVE_RIGHT;
    end else
    begin
      MergeImage.Cursor := crDefault;
      SelFrameMove := NO_MOVE;
    end;
 End  Else

 If (ssLeft in Shift) and (MainImLoaded)  then with MergeImage do Begin

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

     DrawSelFrame(MergeImage.Canvas);

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
        (frmImageControl.ubApplyFrame.Selected)then begin
        frm3DImageWin.Update3DImage(True);
    End;

  End; //If (SelFrameMove <> NO_MOVE) then begin
 End; //If (ssLeft in Shift)
 End; //With SelFrame do Begin
End //If  (frmImageControl.SelectionFrameChange.Down = True) Then Begin

  Else
 {------------------ Measure Distance ----------------------------------------}
If (frmImageControl.MeasureDistance.Down) Then Begin
  If (DiamMesRect.OpCode <> IN_TRACKING) Then Begin

 With MesLine Do Begin

  If (ssLeft in Shift) Then Begin

    If (MesLine.OpCode = IN_DRAWING) Then Begin
      with MergeImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X,LineBeg.Y,X,Y,MergeImage.Canvas);
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
      with MergeImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X + dXpr,LineBeg.Y + dYpr,LineEnd.X + dXpr,LineEnd.Y + dYpr,MergeImage.Canvas);
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

      with MergeImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
      DrawMesLine(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y,MergeImage.Canvas);
    End; //If (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then Begin

  End Else
  If (Shift = []) Then Begin //Nothing was pressed

    If (OpCode in [DO_EXIST,MIDDLE_SEL,BEG_SEL,END_SEL]) then Begin
      CheckIfMesLineSelected(X,Y);
      if (OpCode = MIDDLE_SEL)         then MergeImage.Cursor := crBlackArrow else
      if (OpCode in [BEG_SEL,END_SEL]) then MergeImage.Cursor := crCircle else
                                            MergeImage.Cursor := crDefault;
    End;

    If (DiamMesRect.OpCode in [DO_EXIST,BEG_SEL,END_SEL]) then Begin
      CheckIfMesDiamSelected(X,Y);
      if (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then MergeImage.Cursor := crCircle;
    End;

  End; //If (Shift = []) Then Begin
 End; //with
 End; //If (DiamMesRect.OpCode <> IN_TRACKING) Then Begin
End; //If (frmImageControl.MeasureDistance.Down)


 End;//If (MainImLoaded = True) and (AnalInAction = False) and (NrChannels > 1)

End; //Procedure TfrmMergeWin.MergeImageMouseMove
 {****************************************************************************}

procedure TfrmMergeWin.MergeImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

If (MainImLoaded = True) and (AnalInAction = False) and (NrChannels > 1) Then Begin

  if (frmImageControl.SelectionFrameChange.Down) then ClipCursor(NIL);  {Removes Cursor Restrictions}

  If (frmImageControl.SelectionFrameChange.Down) and (Button = mbLeft)
   Then Begin
    ClipCursor(NIL);  {Removes Cursor Restrictions}
    If (SelFrameMove <> NO_MOVE) then Begin
      RedrawWindows := 2;
    End;

  End
    Else
  If (frmImageControl.MeasureDistance.Down) and (Button = mbLeft) and (DiamMesRect.OpCode <> IN_TRACKING)
  Then Begin
    ClipCursor(NIL);
    if (MesLine.OpCode > DO_EXIST) then begin
    //this should be before CalculateMesLineParams since they set MesLine.OpCode := DO_EXIST
      RedrawWindows := 1;
  End;

    if (MesLine.OpCode = IN_DRAWING)then CalculateMesLineParams(X,Y) else
    if (MesLine.OpCode = IN_MOVING) then CalculateMesLineParams(X - Pr.X,Y - Pr.Y);

    if (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then begin
    if (MesLine.Orientation = MORE_HORIZONTAL) then
       CalculateOffsXorYbeg(MesLine.LineBeg.X,MesLine.LineEnd.X) else
    if (MesLine.Orientation = MORE_VERTICAL) then
      CalculateOffsXorYbeg(MesLine.LineBeg.Y,MesLine.LineEnd.Y);
      ScaleOffsXorYbegToReal;
      DiamMesRect.OpCode := DO_EXIST;
    end; //if (DiamMesRect.OpCode in [BEG_SEL,END_SEL]) then begin
  End; //If (frmImageControl.MeasureDistance.Down) and (Button = mbLeft) and

 if (RedrawWindows > 0) then begin
    UpdateMainImage(True);
    if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);
    if (RedrawWindows = 2) and (frm2ndWin <> nil) then Display2ndChannel;
 end;

End; //If (MainImLoaded = True) and (AnalInAction = False) and (NrChannels > 1) Then Begin

End; //Procedure TfrmMergeWin.MergeImageMouseUp

{****************************************************************************}

END.
