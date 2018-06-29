{$D-,L-,O+,Q-,R-,Y-,S-}
unit unPlayBack;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.ImgList, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Buttons, Vcl.ExtCtrls,Vcl.Clipbrd, Main,EditNumerical,
  UniButton;

type
  TfrmPlayback = class(TForm)
    Bevel1XYpos: TBevel;
    lblSelImBevel: TBevel;
    lblSelIm: TLabel;
    lbImageNrShape: TShape;
    lbImageNr: TLabel;
    lblXYcoor: TLabel;
    lblROIval: TLabel;
    lblXYuSize: TLabel;
    TitlePlayModes: TLabel;
    lblDelay: TLabel;
    titXYpos: TLabel;
    titValueType: TLabel;
    PlaybackScrollBar: TScrollBar;
    PlaybackToolBar: TToolBar;
    GoToBeg: TToolButton;
    BackWards: TToolButton;
    Stop: TToolButton;
    ForWards: TToolButton;
    GoToEnd: TToolButton;
    DoLoop: TToolButton;
    SelectOne: TToolButton;
    DeselectOne: TToolButton;
    Select10: TToolButton;
    Deselect10: TToolButton;
    DeselectAll: TToolButton;
    Separator2: TToolButton;
    InOutOfProgram: TToolButton;
    cmbPlayMode: TComboBox;
    TrackBarDelay: TTrackBar;
    PlaybackImageList: TImageList;
    DisPlaybackImageList: TImageList;
    HotPlaybackImageList: TImageList;
    pnFakeBar: TPanel;
    GoToImage: TToolButton;
    lblROIvalBevel: TBevel;
    BevelROIXYvalue: TBevel;
    BevelPlaybackBlock: TBevel;
    ZoomTollBar: TToolBar;
    Magnify: TToolButton;
    Decrease: TToolButton;
    FullScr: TToolButton;
    Separator: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    LockImagesToLoop: TSpeedButton;
    LoopFrom: TEditNumerical;
    LoopTo: TEditNumerical;
    GoToInput: TEditNumerical;
    sbCopyValue: TSpeedButton;
    edROI_Xpos: TEdit;
    edROI_Ypos: TEdit;
    lbSetROI_XY: TLabel;
    sbSetROI_XYpos: TSpeedButton;
    ubIncreaseHeigth: TUniButton;
    Label2: TLabel;
    sbSwapChannel: TSpeedButton;
    ubRatioOn_PlayBack: TUniButton;
    Magnify4x: TToolButton;
    sbSaveMergeImage: TSpeedButton;
    sbSaveAverImageAsBMP: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure pnFakeBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PlaybackScrollBarChange(Sender: TObject);
    procedure GoToBegClick(Sender: TObject);
    procedure BackWardsClick(Sender: TObject);
    procedure StopClick(Sender: TObject);
    procedure ForWardsClick(Sender: TObject);
    procedure GoToEndClick(Sender: TObject);
    procedure DoLoopClick(Sender: TObject);
    procedure cmbPlayModeChange(Sender: TObject);
    procedure TrackBarDelayChange(Sender: TObject);
    procedure GoToImageClick(Sender: TObject);
    procedure SelectOneClick(Sender: TObject);
    procedure DeselectOneClick(Sender: TObject);
    procedure Select10Click(Sender: TObject);
    procedure Deselect10Click(Sender: TObject);
    procedure DeselectAllClick(Sender: TObject);
    procedure FullScrClick(Sender: TObject);
    procedure InOutOfProgramClick(Sender: TObject);
    procedure MagnifyClick(Sender: TObject);
    procedure DecreaseClick(Sender: TObject);
    procedure LoopFromReturnPressed(Sender: TObject);
    procedure LoopToReturnPressed(Sender: TObject);
    procedure LockImagesToLoopClick(Sender: TObject);
    procedure GoToInputReturnPressed(Sender: TObject);
    procedure sbCopyValueClick(Sender: TObject);
    procedure sbChangeHeightClick(Sender: TObject);
    procedure sbSetROI_XYposClick(Sender: TObject);
    procedure ubIncreaseHeigthClick(Sender: TObject);
    procedure sbSwapChannelClick(Sender: TObject);
    procedure ubRatioOn_PlayBackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ubRatioOn_PlayBackClick(Sender: TObject);
    procedure sbSaveMergeImageClick(Sender: TObject);
    procedure sbSaveAverImageAsBMPClick(Sender: TObject);
    procedure Magnify4xClick(Sender: TObject);

  private
    

    procedure CreateParams(var Params: TCreateParams); override; //Removes Form Bar in Child Form
    procedure WMWINDOWPOSCHANGING (Var Msg: TWMWINDOWPOSCHANGING); message WM_WINDOWPOSCHANGING;
  public
    Docked      : Boolean;
    CanDock     : Boolean;
    Xoffset     : integer;
    CenterOffs  : integer;
  end;

var
  frmPlayback : TfrmPlayback;


implementation

uses unAverIm, unImageControl, unGlobUnit, ImageFilesOpeningRoutines,
     unTimeSerAnal,unSparkTable, unWaveTable,unFileList, unFrameTimSerPlot,
     unMainWindow, MovieLabels,un3DImageWin, un3DImageContr,
     unLineScan, unCopyWindow, DigiFilters, un2ndWin, unMergeWindow,OrthogonalSectioning;
     
{$R *.dfm}

procedure TfrmPlayback.FormCreate(Sender: TObject);
  var  Xt,Yt  : integer; {used to position Numbers on Button BMP}
       ButLab : AnsiString;
       ButBMP : TBitmap;
begin

    frmPlayBack.Docked := False;
    frmPlayBack.CanDock := True;
    frmPlayBack.Tag     := 1; // to assure positioning of forms when program is 1st activated
    PlayBackScrollBar.Min := 0;
    PlayBackScrollBar.Max := 0;
    PlayBackScrollBar.Position := 0;
    PlayBackScrollBar.Enabled := false;
    cmbPlayMode.Enabled := False;
    GoToInput.Enabled   := False;
    LoopFrom.Enabled    := False;
    LoopTo.Enabled      := False;
    DelayMS     := 0;
    {Sets Bitmap for Last Button}
    {I did not make Image for it}
    ButBMP := TBitmap.Create;
    ButBMP.Width  := 16;
    ButBMP.Height := 16;
    ButBMP.PixelFormat := pf24bit;
    ButBMP.Canvas.Font.Name   := 'Arial Narrow';
    ButBMP.Canvas.Font.Color  := clBlack;
    ButBMP.Canvas.Font.Pitch  := fpVariable;
    ButBMP.Canvas.Font.Size   := 8;
    ButBMP.Canvas.Brush.Color := clBtnFace;
    ButBMP.Canvas.FillRect(ButBMP.Canvas.ClipRect);
    ButBMP.Canvas.Brush.Style := bsClear; {to make transparent text}
    ButLab := 'out';
    Xt := ButBMP.Width div 2  - ButBMP.Canvas.TextWidth(ButLab) div 2;
    Yt := ButBMP.Height div 2 - ButBMP.Canvas.TextHeight(ButLab) div 2;
    ButBMP.Canvas.Font.Color := clRed;
    ButBMP.Canvas.TextOut(Xt,Yt,ButLab); 
    frmPlayback.PlaybackImageList.Add(ButBMP,nil);
    frmPlayback.DisPlaybackImageList.Add(ButBMP,nil);
    ButBMP.Canvas.Brush.Color := clBtnFace;
    ButBMP.Canvas.FillRect(ButBMP.Canvas.ClipRect);
    ButBMP.Canvas.Brush.Style := bsClear;
    ButLab := 'IN';
    Xt := ButBMP.Width div 2  - ButBMP.Canvas.TextWidth(ButLab) div 2;
    Yt := ButBMP.Height div 2 - ButBMP.Canvas.TextHeight(ButLab) div 2;
    ButBMP.Canvas.Font.Color := clBlue;
    ButBMP.Canvas.TextOut(Xt,Yt,ButLab);
    frmPlayback.HotPlaybackImageList.Add(ButBMP,nil);
    FreeAndNil(ButBMP);
end;



{------------------------------------------------------------------------------}
procedure TfrmPlayback.CreateParams(var Params: TCreateParams);  //Removes Form Bar in Child Form
Begin
  inherited CreateParams(Params);
  Params.Style := Params.Style and not WS_OVERLAPPEDWINDOW or WS_BORDER;
End;   
{------------------------------------------------------------------------------}

procedure TfrmPlayback.WMWINDOWPOSCHANGING (var Msg: TWMWINDOWPOSCHANGING);
begin
 If (CanDock = True) and (frmPlayback.Tag = 0) Then Begin
 If (frmPlayBack.Active) Then with Msg.WindowPos^ do begin
    If (y < frmMainWin.Top + frmMainWin.Height + 10) and (y >= frmMainWin.Top + frmMainWin.Height -10) and
      (x + frmPlayBack.Width > frmMainWin.Left ) and (x < frmMainWin.Left + frmMainWin.Width)
      then begin
        Docked := True;
        y := frmMainWin.Top + frmMainWin.Height;
       if AlignfrmPlayback then x := frmMainWin.Left - frmPlayback.CenterOffs;
        Xoffset := frmMainWin.Left - x;
       pnFakeBar.Color := $00B9B9FF; //light red
      end else begin
       Docked := False;
       pnFakeBar.Color := $00FED8DF;//$00FEE9D3; //light blue
      end;
  end; //with  Msg.WindowPos^
  End;
  inherited;
End;
 {------------------------------------------------------------------------------}
procedure TfrmPlayback.pnFakeBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const SC_DRAGMOVE = $F012; {= 61458}
Begin
  frmPlayback.Tag := 0; //resets Tag
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
End;

procedure TfrmPlayback.sbCopyValueClick(Sender: TObject);
begin
 if (MainImLoaded) then Begin

  Clipboard.Clear;
  if (frmCopyWindow = nil) then MainForm.CopyWindowClick(Sender);

  if (frmImageControl.MeasureDistance.Down) then begin
    Clipboard.AsText := Copy(lblROIval.Caption,1,Length(lblROIval.Caption)-2);
    frmCopyWindow.Memo1.Lines.Add(IntToStr(CurIm+1) + Char(9) + FloatToStr(TimeSt[CurIm]) +
      Char(9) + Copy(lblROIval.Caption,1,Length(lblROIval.Caption)-2));
  end else begin
    Clipboard.AsText := lblROIval.Caption;
    frmCopyWindow.Memo1.Lines.Add(IntToStr(CurIm+1) + Char(9) + FloatToStr(TimeSt[CurIm]) +
      Char(9) + lblROIval.Caption);
  end;
 End;
End;

{------------------------------------------------------------------------------}
procedure TfrmPlayback.PlaybackScrollBarChange(Sender: TObject); //new
  {this dispaly Images on Main Window}
      Var Cnt,j,CntIm,F,L,Ims  : Integer;
          D : Double;
Begin

{1st: Do all 16 bit buffer manipulations}

If (JumpAv = 1) and (RunAv = 1) then Begin
  CurIm := PlaybackScrollBar.Position;
  ReadImage(CurIm,0,pImData);
  if (NrChannels = 2) and Not(MovFType = NIKON_ND2_MOV) then begin
    if not(MovFType = BIORAD_PIC) then ReadImage(CurIm,1,p2ndImData)
      else
    if (MovFType = BIORAD_PIC) then begin
      ImFile := CollFileHandles[1];
      ReadImage(CurIm,0,p2ndImData);
      ImFile := CollFileHandles[0];
    end;
  end; //if (NrChannels > 1)

End

  Else

If (JumpAv > 1) then Begin
      Ims := JumpAv - 1;
      //Channel One - the channel on the Main window
      CurIm := PlaybackScrollBar.Position*JumpAv; {here it jumtps}
       {first Image}
      ReadImage(CurIm,0,pImData);

      if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := Im16bitData[Cnt] else
      if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := Im8bitData[Cnt];
        {next but not the last}
      J := 1;
      While (j < Ims) Do Begin
        Inc(j);
        Inc(CurIm);
        ReadImage(CurIm,0,pImData);
        if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im16bitData[Cnt] else
        if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im8bitData[Cnt];
      End; {While}
        {Adds Last Image and divides by number of images}
      Inc(CurIm);
      ReadImage(CurIm,0,pImData);
      if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im16bitData[Cnt] := (JumpOrRunAvArr[Cnt] + Im16bitData[Cnt]) div JumpAv else
      if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im8bitData[Cnt]  := (JumpOrRunAvArr[Cnt] + Im8bitData[Cnt])  div JumpAv;
      //-------------- End of Channel One --------------
       //Channel Two - the channel on the secodary window
    If (NrChannels = 2) and Not(MovFType = NIKON_ND2_MOV) then Begin
      CurIm := PlaybackScrollBar.Position*JumpAv; {here it jumtps}
       {first Image}
      if not(MovFType = BIORAD_PIC)  then ReadImage(CurIm,1,p2ndImData)
        else
      if (MovFType = BIORAD_PIC) then begin
        ImFile := CollFileHandles[1];
        ReadImage(CurIm,0,p2ndImData);
        ImFile := CollFileHandles[0];
      end;

      if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := Im2nd16bit[Cnt] else
      if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] :=  Im2nd8bit[Cnt];
        {next but not the last}
      J := 1;
      While (j < Ims) Do Begin
        Inc(j);
        Inc(CurIm);
        if not(MovFType = BIORAD_PIC) then ReadImage(CurIm,1,p2ndImData)
          else
        if (MovFType = BIORAD_PIC) then begin
          ImFile := CollFileHandles[1];
          ReadImage(CurIm,0,p2ndImData);
          ImFile := CollFileHandles[0];
        end;
        if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im2nd16bit[Cnt] else
        if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im2nd8bit[Cnt];
      End; {While}
        {Adds Last Image and divides by number of images}
      Inc(CurIm);
      if not(MovFType = BIORAD_PIC) then ReadImage(CurIm,1,p2ndImData)
          else
      if (MovFType = BIORAD_PIC) then begin
        ImFile := CollFileHandles[1];
        ReadImage(CurIm,0,p2ndImData);
        ImFile := CollFileHandles[0];
      end;

      if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im2nd16bit[Cnt] := (JumpOrRunAvArr[Cnt] + Im2nd16bit[Cnt]) div JumpAv  else
      if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im2nd8bit[Cnt]  := (JumpOrRunAvArr[Cnt] + Im2nd8bit[Cnt])  div JumpAv;
      //End of Channel Two
    End; //If (NrChannels > 1) then Begin

 End{ If (JumpAv > 1);    ----- End of Creating Jump Average ------------- }

  Else

 If (RunAv > 1) then Begin
  //Channel One - the channel on the Main window
    CurIm := PlaybackScrollBar.Position;

    F := CurIm - (RunAv div 2);
    if (Odd(RunAv)) then L := CurIm + (RunAv div 2)
    else L := CurIm + (RunAv div 2) - 1;
    if (F < 0)  then F := 0;
    if (L > NrIm-1) then L := NrIm-1;
    Ims := L - F + 1;

    For CntIm := F to L do Begin
      ReadImage(CntIm,0,pImData);
      if (CntIm = F) then begin
        if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
            JumpOrRunAvArr[Cnt] := Im16bitData[Cnt] else
        if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
            JumpOrRunAvArr[Cnt] := Im8bitData[Cnt];
      end
        else
      begin
        if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im16bitData[Cnt] else
        if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im8bitData[Cnt];
      end;
    End;

    if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im16bitData[Cnt] := round(JumpOrRunAvArr[Cnt]/Ims)  else
    if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im8bitData[Cnt]  := round(JumpOrRunAvArr[Cnt]/Ims);
    //-------------- End of Channel One --------------
  If (NrChannels = 2) and Not(MovFType = NIKON_ND2_MOV) then Begin
    For CntIm := F to L do Begin
      if not(MovFType = BIORAD_PIC) then ReadImage(CntIm,1,p2ndImData)
        else
      if (MovFType = BIORAD_PIC) then begin
        ImFile := CollFileHandles[1];
        ReadImage(CntIm,0,p2ndImData);
        ImFile := CollFileHandles[0];
      end;
      if (CntIm = F) then begin
        if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
            JumpOrRunAvArr[Cnt] := Im2nd16bit[Cnt] else
        if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
            JumpOrRunAvArr[Cnt] := Im2nd8bit[Cnt];
      end
        else
      begin
        if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im2nd16bit[Cnt] else
        if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
          JumpOrRunAvArr[Cnt] := JumpOrRunAvArr[Cnt] + Im2nd8bit[Cnt];
      end;
    End;

    if (BitCount = 16) then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im2nd16bit[Cnt] := round(JumpOrRunAvArr[Cnt]/Ims)  else
    if (BitCount = 8)  then for Cnt := 0 to High(JumpOrRunAvArr) do
         Im2nd8bit[Cnt]  := round(JumpOrRunAvArr[Cnt]/Ims);

      //End of Channel Two
  End; //If (NrChannels > 1) then Begin


 End; //If (RunAv > 1) then Begin


 {------------- Write Image number and Time or microns ----------------------}

   If (NrIm > 1) then Begin

      If (MovieSeriesType = TimeSeries) then
       lbImageNr.Caption := 'im ' + IntToStr(PlaybackScrollBar.Position + 1) +
                      ' / ' + (FloatToStrF(TimeSt[CurIm],ffFixed,8,3) + ' s')
        else

      If (MovieSeriesType = Z_Stack) then Begin
       if (MovFType in[ANDOR_MOV,BIORAD_PIC,NIKON_ND2_MOV,NIKON_TIFF_MOV]) then begin

       {Andor Tiff, Nikon Tiff and Biorad Zstack Files Have always Time Stamps.
        That's why Z data is saved to ZstackArr.  Zeiss Zstack files have Only (µm).
        To avoid Compications with the Plot Routines That always expect Time Stamps
        the Z data are saved in the TimeSt array}

        lbImageNr.Caption := 'im ' + IntToStr(PlaybackScrollBar.Position + 1) +
                      ' / ' + (FloatToStrF(ZstackArr[CurIm],ffFixed,8,2) + ZstackUnits) +
                      ' / ' + (FloatToStrF(TimeSt[CurIm],ffFixed,8,3) + ' s');
       end //Iif (MovFType in[ANDOR_MOV,BIORAD_PIC])
        else
       if (MovFType = ZEISS_CZI_LSM_MOV) then begin
        lbImageNr.Caption := 'im ' + IntToStr(PlaybackScrollBar.Position + 1) +
                      ' / ' + (FloatToStrF(TimeSt[CurIm],ffFixed,8,2) + ' µm');
       end;
       Application.ProcessMessages; // helps updating numbers
      End; //If (MovieSeriesType = Z_Stack)
    End Else // If NrIm > 1 then Begin
    lbImageNr.Caption := '';

 {----------------- Deals with Non Ratio Images -----------------------------}
 If not(RatioOn) and not(ChannelsRatioOn) Then Begin

  If (BitCount = 16) then begin
    Scale16bitImageToImDispl(0,ImDispl);
    if (NrChannels = 2) then
    Scale16bitImageToImDispl(1,Im2ndDispl);
  End

    Else
  
  If (BitCount  = 8) Then Begin
    Transfer8bitImageToImDispl(ImDispl);
    if (NrChannels = 2) then
    Transfer8bitImageToImDispl(Im2ndDispl);
  End;// If (BitCount  = 8)


 End

  Else //If not(RatioOn)

{----------------- Deals with Ratio Images -----------------------------}
 If (RatioOn) Then Begin
   if (SmoothMode > NO_SMOOTH) and (frmImageControl.cbSmoothBeforeDoRatio.Checked) then ApplySmoothing;
   DoRatio(DO_COPY);
 End { (RatioOn = True)}

  Else
  //------------------------------------------------//

 If (ChannelsRatioOn) Then Begin
   DoChannelRatio(DO_COPY);
 End; { (RatioOn = True)}
{-----------------End of  with Ratio Images -----------------------------}  

UpdateMainImage(True);
if (NrChannels > 1) then begin
  if  (ChannelOrder = ASCENDING)  then
  MergeImagesTo32bit(ImDispl, Im2ndDispl ,MergeImDispl,imXsize,imYsize)
    else
  if (ChannelOrder = DESCENDING)  then
  MergeImagesTo32bit(Im2ndDispl,ImDispl,MergeImDispl,imXsize,imYsize);
  if (frm2ndWin   <> nil) then Display2ndChannel;
  if (frmMergeWin <> nil) then DisplayMergeImage;
end;

if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
  ZposChanged;
  UpdateSectionsAndDrawMainWin(False,False);
end;

If (ImSel > 0) Then Begin
   if (AvImList[CurIm] > 0) then lblSelIm.Caption := 'S' else lblSelIm.Caption := '';
End;

{ ----------------   3D Image  ------------------------}

if (Win3DOn) and ((SourceFor3D = MAIN_IMAGE_FOR_3D) or (SourceFor3D = MERGE_IMAGE_FOR_3D))
  then frm3DImageWin.Update3DImage(True);

{---------------- end 3D Image -----------------------}



End; //Procedure PlaybackScrollBarChange


{------------------------------------------------------------------------------}

procedure TfrmPlayback.GoToBegClick(Sender: TObject);
begin
    Stop.Down := True;
    StopClick(Sender);
    frmPlayback.PlaybackScrollBar.Position := 0;

end;


procedure TfrmPlayback.BackWardsClick(Sender: TObject);
  var  CtIm : Integer;

 Begin

   DoLoop.Down  := False;

  If (frmPlayback.cmbPlayMode.ItemIndex = 0) or (JumpAv > 1) or (RunAv > 1) then begin
      {normal mode}
       PlayBackMode := CONT_BACKWARD;
    While PlaybackScrollBar.Position > 0 Do Begin
       PlaybackScrollBar.Position := PlaybackScrollBar.Position - 1;
       Application.ProcessMessages;
       if DelayMS > 0 then Sleep(DelayMS); {not in use Delay(DelayMS);}
       If (PlayBackMode <> CONT_BACKWARD) Then Break;
    End; {For}
    frmPlayback.Stop.Down := True;
  End Else
    If (frmPlayback.cmbPlayMode.ItemIndex = 9) then begin  {go to selected images}
     If (ImSel > 0) Then Begin
      If CurIm > 0 Then Dec(CurIm);
        If (AvImList[CurIm] = 1) Then Begin
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
        End else
      While (CurIm > 0) Do Begin
          Dec(CurIm);
        If (AvImList[CurIm] = 1) Then begin
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
          Break;
        End; { (AvImList[Cnt] > 0)}
      End; {(AvImList[CurIm] = 0) and (CurIm < EndPlay-1)}
     End;
     if frmPlayback.Stop.Down = False then frmPlayback.Stop.Down := True;
     frmPlayback.Stop.Click;
    End {cmbPlayMode.ItemIndex = 6}
      Else
    If (frmPlayback.cmbPlayMode.ItemIndex = 10) Then Begin //GoTo Marked Images
             CtIm := CurIm;
      If (MarkPar.DisplaySmEvents) and (MarkPar.DisplayBigEvents) Then Begin
        If CtIm > 0 Then Dec(CtIm);
        If (High(MarkSmEvCoor[CtIm]) >= 0) or (High(MarkBigEvCoor[CtIm]) >= 0) Then Begin
          CurIm := CtIm;
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
        End else
        While (High(MarkSmEvCoor[CtIm]) < 0) and (High(MarkBigEvCoor[CtIm]) < 0) and
            (CtIm > 0) Do Begin
            Dec(CtIm);
          If  (High(MarkSmEvCoor[CtIm]) >= 0) or (High(MarkBigEvCoor[CtIm]) >= 0) Then begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End { (AvImList[Cnt] > 0)}
        End; {While}
      End Else
      If (MarkPar.DisplaySmEvents) and (MarkPar.DisplayBigEvents = False) Then Begin
        If CtIm > 0 Then Dec(CtIm);
        If (High(MarkSmEvCoor[CtIm]) >= 0) Then Begin
          CurIm := CtIm;
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
        End else
        While (High(MarkSmEvCoor[CtIm]) < 0) and (CtIm > 0) Do Begin
            Dec(CtIm);
          If  (High(MarkSmEvCoor[CtIm]) >= 0) Then begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End; { (AvImList[Cnt] > 0)}
        End; {While}
       End Else
       If (MarkPar.DisplaySmEvents = False) and (MarkPar.DisplayBigEvents) Then Begin
        If CtIm > 0 Then Dec(CtIm);
        If (High(MarkBigEvCoor[CtIm]) >= 0) Then Begin
          CurIm := CtIm;
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
        End else
        While (High(MarkBigEvCoor[CtIm]) < 0) and(CtIm > 0) Do Begin
            Dec(CtIm);
          If (High(MarkBigEvCoor[CtIm]) >= 0) Then begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End; { (AvImList[Cnt] > 0)}
        End; {While}
       End;
        If frmPlayback.Stop.Down = False then frmPlayback.Stop.Down := True;
        frmPlayback.Stop.Click;
    End; {If (frmPlayback.cmbPlayMode.ItemIndex = 7)}
End; {procedure TfrmPlayback.BackWardsClick(Sender: TObject);}
{------------------------------------------------------------------------}

procedure TfrmPlayback.StopClick(Sender: TObject);
begin
   PlayBackMode := STOPPED;
   DoLoop.Down  := False;  //should be done because it is not in same group
   Application.ProcessMessages;
end;

{------------------------------------------------------------------------}

procedure TfrmPlayback.ForWardsClick(Sender: TObject);
var
      CtIm : Integer;
  Begin


    DoLoop.Down := False;

    If (cmbPlayMode.ItemIndex = 0) or (JumpAv > 1) or (RunAv > 1) then begin
         //normal mode & Jump Aver Mode
        PlayBackMode := CONT_FORWARD;
      While PlaybackScrollBar.Position < PlaybackScrollBar.Max Do Begin
        PlaybackScrollBar.Position := PlaybackScrollBar.Position + 1;
        Application.ProcessMessages;
        if DelayMS > 0 then Sleep(DelayMS); //not in use Delay(DelayMS);
        If (PlayBackMode <> CONT_FORWARD) Then Break;
      End; //For
       frmPlayback.Stop.Down := True;
    End else
    If (cmbPlayMode.ItemIndex = 9) then begin  //go to selected images
     If (ImSel > 0) then Begin
      If CurIm < PlaybackScrollBar.Max Then Inc(CurIm);
        If (AvImList[CurIm] = 1) Then Begin
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
        End else
      While (CurIm < PlaybackScrollBar.Max) Do Begin
          Inc(CurIm);
        If (AvImList[CurIm] = 1) Then begin
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
          Break;
        End; // (AvImList[Cnt] > 0)
      End; //(CurIm < EndPlay-1)
     End;
      If frmPlayback.Stop.Down = False then frmPlayback.Stop.Down := True;
      frmPlayback.Stop.Click;
    End  //cmbPlayMode.ItemIndex = 6
      Else
    If (cmbPlayMode.ItemIndex = 10) Then Begin   //go to images with marks
            CtIm := CurIm;
      If (MarkPar.DisplaySmEvents) and (MarkPar.DisplayBigEvents)   Then Begin

       If CtIm < PlaybackScrollBar.Max Then Inc(CtIm);
        If (High(MarkSmEvCoor[CtIm]) >= 0) or (High(MarkBigEvCoor[CtIm]) >= 0) Then Begin
          CurIm := CtIm;
          PlaybackScrollBar.Position := CurIm;
          frmPlayback.Stop.Down := True;
        End else
        While (High(MarkSmEvCoor[CtIm]) < 0) and (High(MarkBigEvCoor[CtIm]) < 0) and
            (CtIm < PlaybackScrollBar.Max) Do Begin
          Inc(CtIm);
          If  (High(MarkSmEvCoor[CtIm]) >= 0) or (High(MarkBigEvCoor[CtIm]) >= 0) Then begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End // (AvImList[Cnt] > 0)
        End; //(AvImList[CurIm] = 0) and (CurIm < EndPlay-1)
      End Else
      If (MarkPar.DisplaySmEvents) and (MarkPar.DisplayBigEvents = False)   Then Begin
        If CtIm < PlaybackScrollBar.Max Then Inc(CtIm);
          If (High(MarkSmEvCoor[CtIm]) >= 0) Then Begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End else
        While (High(MarkSmEvCoor[CtIm]) < 0) and (CtIm < PlaybackScrollBar.Max) Do Begin
            Inc(CtIm);
          If  (High(MarkSmEvCoor[CtIm]) >= 0) Then begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End; // (AvImList[Cnt] > 0)
        End; //While
      End Else //(AvImList[CurIm] = 0) and (CurIm < EndPlay-1)
      If (MarkPar.DisplaySmEvents = False) and (MarkPar.DisplayBigEvents)   Then Begin
         If CtIm < PlaybackScrollBar.Max Then Inc(CtIm);
          If (High(MarkBigEvCoor[CtIm]) >= 0) Then Begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End else
        While (High(MarkBigEvCoor[CtIm]) < 0) and (CtIm < PlaybackScrollBar.Max) Do Begin
          Inc(CtIm);
          If  (High(MarkBigEvCoor[CtIm]) >= 0) Then begin
            CurIm := CtIm;
            PlaybackScrollBar.Position := CurIm;
            frmPlayback.Stop.Down := True;
          End; // (AvImList[Cnt] > 0)
        End //While
      End;
        frmPlayback.Stop.Down := True;
        frmPlayback.Stop.Click;
    End; //If (cmbPlayMode.ItemIndex = 7)


End; {procedure TfrmMainWin.ForWardsClick(Sender: TObject);}
{------------------------------------------------------------------------}
procedure TfrmPlayback.GoToEndClick(Sender: TObject);
begin
  Stop.Down := True;
  StopClick(Sender);
  PlaybackScrollBar.Position := PlaybackScrollBar.Max;
end;
{------------------------------------------------------------------------}
procedure TfrmPlayback.LockImagesToLoopClick(Sender: TObject);
begin
  if (LockImagesToLoop.Down) then begin 
    if LoopFrom.Focused then LoopFrom.DoReturn;
    if LoopTo.Focused then LoopTo.DoReturn;
    PlaybackScrollBar.Position := LoopFrom.NumberOne - 1;
    PlaybackScrollBar.Min      := LoopFrom.NumberOne - 1;
    PlaybackScrollBar.Max      := LoopTo.  NumberOne - 1;
  end else

  if Not(LockImagesToLoop.Down) then begin
    PlaybackScrollBar.Min := 0;
    PlaybackScrollBar.Max := (NrIm div JumpAv) - 1;
  end;
end;

procedure TfrmPlayback.LoopFromReturnPressed(Sender: TObject);
  var PlayBackModeMem : Byte;
begin

 if PlayBackMode = LOOPING then begin
  PlayBackModeMem := PlayBackMode;
  PlayBackMode := STOPPED;
 end;

 LoopFrom.Tag := LoopFrom.NumberOne * JumpAv;
 LoopTo.Min   := LoopFrom.NumberOne + 4;

 if (LockImagesToLoop.Down) then PlaybackScrollBar.Min := LoopFrom.NumberOne - 1;
 if PlayBackModeMem = LOOPING then DoLoopClick(Sender);
end;

procedure TfrmPlayback.LoopToReturnPressed(Sender: TObject);
  var PlayBackModeMem : Byte;
begin
 if PlayBackMode = LOOPING then begin
  PlayBackModeMem := PlayBackMode;
  PlayBackMode := STOPPED;
 end;

 LoopTo.Tag   := LoopTo.NumberOne * JumpAv;
 LoopFrom.Max := LoopTo.NumberOne - 4;

 if (LockImagesToLoop.Down) then PlaybackScrollBar.Max := LoopTo.NumberOne - 1;
 if PlayBackModeMem = LOOPING then DoLoopClick(Sender);
end;

procedure TfrmPlayback.DoLoopClick(Sender: TObject);
  
  Begin    

    If DoLoop.Down Then Begin
      if LoopFrom.Focused then LoopFrom.DoReturn;
      if LoopTo.Focused   then LoopTo.DoReturn;

      PlayBackMode   := LOOPING;
      Stop.Down      := False; //should be done because it is not in same group
      BackWards.Down := False;
      ForWards.Down  := False;

      CurIm := LoopFrom.NumberOne - 1;
      PlaybackScrollBar.Position := CurIm;
      if (LockImagesToLoop.Down) then begin
        PlaybackScrollBar.Min      := LoopFrom.NumberOne - 1;
        PlaybackScrollBar.Max      := LoopTo.NumberOne   - 1;
      end;
      
    While (PlayBackMode = LOOPING) Do Begin
       if PlaybackScrollBar.Position + 1 > LoopTo.  NumberOne - 1 then
          PlaybackScrollBar.Position    := LoopFrom.NumberOne - 1
       else
        PlaybackScrollBar.Position := PlaybackScrollBar.Position + 1;
        Application.ProcessMessages;
       if (DelayMS > 0) then Sleep(DelayMS); {not in use Delay(DelayMS);}
    End; {While}
   End Else
   If Not(DoLoop.Down)  Then  Begin
    PlayBackMode := STOPPED;
    Stop.Down    := True;
   End;

End; {procedure TfrmMainWin.DoLoopClick(Sender: TObject);}
{------------------------------------------------------------------------}

procedure TfrmPlayback.cmbPlayModeChange(Sender: TObject);

var MinSlPos, MaxSlPos : Integer;
    OnChangeMem : TNotifyEvent;

begin

If (cmbPlayMode.ItemIndex in [6..8]) then Begin

  if (cmbPlayMode.ItemIndex = 6) then RunAv := 3
    else
  if (cmbPlayMode.ItemIndex = 7) then RunAv := 4
    else
  if (cmbPlayMode.ItemIndex = 8) then RunAv := 5;

  if (Length(JumpOrRunAvArr) <> ImagePix) then SetLength(JumpOrRunAvArr,ImagePix);
  PlaybackScrollBarChange(sender);
End
  Else
If Not(cmbPlayMode.ItemIndex in [6..8]) and (RunAv > 1)then Begin
  RunAv := 1;
  if Not(cmbPlayMode.ItemIndex in [1..5]) then begin
    JumpOrRunAvArr := nil;
    PlaybackScrollBarChange(sender);
  end;
End;

//-------------------------- JumpAv changes ---------------------------------//

If (cmbPlayMode.ItemIndex in [1..5]) or (JumpAv > 1) Then Begin

  OnChangeMem := PlaybackScrollBar.OnChange;
  PlaybackScrollBar.OnChange := nil;

 If (cmbPlayMode.ItemIndex in [1..5]) then Begin
   //[3,4] does Jump Average
  if (cmbPlayMode.ItemIndex = 1) then JumpAv := 2 else
  if (cmbPlayMode.ItemIndex = 2) then JumpAv := 4 else
  if (cmbPlayMode.ItemIndex = 3) then JumpAv := 6 else
  if (cmbPlayMode.ItemIndex = 4) then JumpAv := 8 else
  if (cmbPlayMode.ItemIndex = 5) then JumpAv := 10;

  if (Length(JumpOrRunAvArr) <> ImagePix) then SetLength(JumpOrRunAvArr,ImagePix);

  if (GoToInput.Tag div JumpAv > 0) then
      GoToInput.NumberOne := GoToInput.Tag div JumpAv;
  //GoToInput.Min set to 1 does not prevent getting 0 values

  LoopFrom.Max  := (LoopTo.Tag   div JumpAv) - 4;
  LoopTo.Min    := (LoopFrom.Tag div JumpAv) + 4;
  //LoopFrom.Min is always QE 1.

  LoopFrom.NumberOne :=  LoopFrom.Tag div JumpAv;
  //prevents of going to Zero
  if (LoopFrom.NumberOne < 1) then LoopFrom.NumberOne := 1;
  LoopTo.NumberOne   :=  LoopTo.Tag   div JumpAv;
  LoopTo.Max         :=  LoopTo.Tag   div JumpAv;

  if Not(LockImagesToLoop.Down) then begin
    PlaybackScrollBar.Min := 0;
    PlaybackScrollBar.Max := (NrIm div JumpAv) - 1;
  end else
  if (LockImagesToLoop.Down) then begin
    MinSlPos := LoopFrom.NumberOne - 1;
    MaxSlPos := LoopTo.  NumberOne - 1;
    if MinSlPos >= PlaybackScrollBar.Max then begin
     PlaybackScrollBar.Max := MaxSlPos;
     PlaybackScrollBar.Min := MinSlPos;
    end else
    if MinSlPos < PlaybackScrollBar.Max then begin
     PlaybackScrollBar.Min := MinSlPos;
     PlaybackScrollBar.Max := MaxSlPos;
    end;
  end;

  PlaybackScrollBar.Position := CurIm div JumpAv;

 End

  Else

 If Not(cmbPlayMode.ItemIndex in [1..5]) and (JumpAv > 1) then Begin

  if Not(cmbPlayMode.ItemIndex in [6..8]) then JumpOrRunAvArr := nil; { TDynWordArray}

  JumpAv    := 1;

  GoToInput.NumberOne := GoToInput.Tag; //Tag stores the ImNr for Normal PlayBack

  LoopFrom.Max  := LoopTo.Tag   - 4;
  LoopTo.Min    := LoopFrom.Tag + 4;

  LoopFrom.NumberOne := LoopFrom.Tag;
  LoopTo.NumberOne   := LoopTo.Tag;
  LoopTo.Max         := NrIm;

  PlaybackScrollBar.Max := NrIm - 1;
  PlaybackScrollBar.Position := CurIm;

 End;

 {resets Movie Labels From - To for MPEG}

 if frmMovieLabels <> nil then begin

    frmMovieLabels.edFrom1.OnChange := nil;
    frmMovieLabels.edFrom2.OnChange := nil;
    frmMovieLabels.edFrom3.OnChange := nil;
    frmMovieLabels.edFrom4.OnChange := nil;
    frmMovieLabels.edFrom5.OnChange := nil;
    frmMovieLabels.edFrom6.OnChange := nil;
    frmMovieLabels.edFrom7.OnChange := nil;

    frmMovieLabels.edTo1.OnChange := nil;
    frmMovieLabels.edTo2.OnChange := nil;
    frmMovieLabels.edTo3.OnChange := nil;
    frmMovieLabels.edTo4.OnChange := nil;
    frmMovieLabels.edTo5.OnChange := nil;
    frmMovieLabels.edTo6.OnChange := nil;
    frmMovieLabels.edTo7.OnChange := nil;

    frmMovieLabels.edFrom1.Text := IntToStr(CommentsFrom[0] div JumpAv + 1);
    frmMovieLabels.edFrom2.Text := IntToStr(CommentsFrom[1] div JumpAv + 1);
    frmMovieLabels.edFrom3.Text := IntToStr(CommentsFrom[2] div JumpAv + 1);
    frmMovieLabels.edFrom4.Text := IntToStr(CommentsFrom[3] div JumpAv + 1);
    frmMovieLabels.edFrom5.Text := IntToStr(CommentsFrom[4] div JumpAv + 1);
    frmMovieLabels.edFrom6.Text := IntToStr(CommentsFrom[5] div JumpAv + 1);
    frmMovieLabels.edFrom7.Text := IntToStr(CommentsFrom[6] div JumpAv + 1);

    frmMovieLabels.edTo1.Text := IntToStr(CommentsTo[0] div JumpAv + 1);
    frmMovieLabels.edTo2.Text := IntToStr(CommentsTo[1] div JumpAv + 1);
    frmMovieLabels.edTo3.Text := IntToStr(CommentsTo[2] div JumpAv + 1);
    frmMovieLabels.edTo4.Text := IntToStr(CommentsTo[3] div JumpAv + 1);
    frmMovieLabels.edTo5.Text := IntToStr(CommentsTo[4] div JumpAv + 1);
    frmMovieLabels.edTo6.Text := IntToStr(CommentsTo[5] div JumpAv + 1);
    frmMovieLabels.edTo7.Text := IntToStr(CommentsTo[6] div JumpAv + 1);

    frmMovieLabels.edFrom1.OnChange := frmMovieLabels.edCommentsFromChange;
    frmMovieLabels.edFrom2.OnChange := frmMovieLabels.edCommentsFromChange;
    frmMovieLabels.edFrom3.OnChange := frmMovieLabels.edCommentsFromChange;
    frmMovieLabels.edFrom4.OnChange := frmMovieLabels.edCommentsFromChange;
    frmMovieLabels.edFrom5.OnChange := frmMovieLabels.edCommentsFromChange;
    frmMovieLabels.edFrom6.OnChange := frmMovieLabels.edCommentsFromChange;
    frmMovieLabels.edFrom7.OnChange := frmMovieLabels.edCommentsFromChange;

    frmMovieLabels.edTo1.OnChange := frmMovieLabels.edCommentsToChange;
    frmMovieLabels.edTo2.OnChange := frmMovieLabels.edCommentsToChange;
    frmMovieLabels.edTo3.OnChange := frmMovieLabels.edCommentsToChange;
    frmMovieLabels.edTo4.OnChange := frmMovieLabels.edCommentsToChange;
    frmMovieLabels.edTo5.OnChange := frmMovieLabels.edCommentsToChange;
    frmMovieLabels.edTo6.OnChange := frmMovieLabels.edCommentsToChange;
    frmMovieLabels.edTo7.OnChange := frmMovieLabels.edCommentsToChange;

 end; //end of updating Labels For MPEG

 PlaybackScrollBar.OnChange := OnChangeMem;
 PlaybackScrollBarChange(sender);

End; //If (cmbPlayMode.ItemIndex in [1,2]) or (JumpAv > 1) Then Begin

//--------------- End with JumpAv changes ---------------------------------//

End;

{------------------------------------------------------------------------}
procedure TfrmPlayback.TrackBarDelayChange(Sender: TObject);
begin
    DelayMS := frmPlayback.TrackBarDelay.Position;
    if DelayMS = 0 then lblDelay.Font.Color := clBlue else
    if DelayMS > 0 then lblDelay.Font.Color := clRed;
    lblDelay.Caption := 'Delay = ' + IntToStr(DelayMS) + ' ms';
end;
{------------------------------------------------------------------------}

procedure TfrmPlayback.GoToInputReturnPressed(Sender: TObject);
begin
  frmPlayback.GoToImageClick(Sender);
end;
{------------------------------------------------------------------------}

procedure TfrmPlayback.GoToImageClick(Sender: TObject);
var CurImLocal : Integer;
begin
    Stop.Down := True;
    StopClick(Sender);
    if (Sender = GoToImage) and (GoToInput.Focused) then GoToInput.DoReturn;
    CurImLocal := GoToInput.NumberOne - 1;
    GoToInput.Tag := GoToInput.NumberOne*JumpAv;

    if (LockImagesToLoop.Down) then begin //relese lock if needed
      if (CurIm < PlaybackScrollBar.Min) or (CurIm > PlaybackScrollBar.Max) then begin
      LockImagesToLoop.Down := False;
      LockImagesToLoop.Click;
      end;
    end;

    PlaybackScrollBar.Position := CurImLocal;  //PlaybackScrollBar.OnChange sets CurIm

End;
{--------------------- For Selection of Images for Average Image ------------}
{------------------------------------------------------------------------}
procedure TfrmPlayback.SelectOneClick(Sender: TObject);
var i : integer;
  begin

    AvImList[CurIm] := 1;
    ImSel := 0;
    for i := 0 to NrIm -1 do if AvImList[i] > 0 then Inc(ImSel);
    lblSelIm.Caption := 'S';
    
  If ImSel > 0 then begin
    MakeAverIm;
    if frmAverIm <> nil then begin
      UpdateAverImage(True);
      frmAverIm.Caption := 'Average Image on Line';
    end;

    AvImExists := 1; {Means Done On Line}

    If (RatioOn = True) then begin
      if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then  SmoothAverIm(AvImRaw,AvIm);
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
      DoRatio(DO_COPY);
      UpdateMainImage(True);
      {------  Line Scan  -----------}
      if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
      {---------------- end Line Scan -----------------------}
      { ----------------   3D Image  ------------------------}
      if (Win3DOn) and (SourceFor3D <> AVER_IMAGE_FOR_3D) then
        frm3DImageWin.Update3DImage(False);
{---------------- end 3D Image -----------------------}
    End; //If (RatioOn = True)
  End; {If ImSel > 0 then begin}

{ ----------------   3D Image  ------------------------}
  if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then
    frm3DImageWin.Update3DImage(True);
{---------------- end 3D Image -----------------------}

End;

procedure TfrmPlayback.sbSaveAverImageAsBMPClick(Sender: TObject);
begin
  if (frmAverIm <> nil) and (AvImExists <> NO_AVERAGE)then begin
    Sender := MainForm.SaveAverageImageAsBMP;
    MainForm.FileSaveAs(Sender);
  end;
end;

procedure TfrmPlayback.sbSaveMergeImageClick(Sender: TObject);
begin
   if (frmMergeWin <> nil) then begin
    Sender := MainForm.SaveMergeWindow;
    MainForm.FileSaveAs(Sender);
   end;
end;

{******************************************************************************}

procedure TfrmPlayback.sbSwapChannelClick(Sender: TObject);
var ChNr, i : integer;

Begin

  If (NrChannels > 1) and (MainImLoaded) Then Begin
    if (MovFType <> NIKON_ND2_MOV) then SwapImageOffsets;

    if (ChannelOrder = ASCENDING)  then ChannelOrder := DESCENDING
      else
    if (ChannelOrder = DESCENDING) then ChannelOrder := ASCENDING;

    if (MovFType in [ANDOR_MOV,NIKON_TIFF_MOV]) then RefillTimStArray;

    if (ChannelOrder = ASCENDING) then begin
      pnFakeBar.Caption := 'Playback Control (Ch. Order = Ascending, Ch1 on Main Window)';
      with frmImageControl Do Begin
        unChDivCh.Caption    := 'Ch1/Ch2';
        unChDivCh.CaptionHot := 'Ch1/Ch2';
        unChDivCh.CaptionSel := 'Ch1/Ch2';
      end;
    end
      else
    if (ChannelOrder = DESCENDING) then begin
      pnFakeBar.Caption := 'Playback Control (Ch. Order = Descending, Ch2 on Main Window)';
      with frmImageControl Do Begin
        unChDivCh.Caption    := 'Ch2/Ch1';
        unChDivCh.CaptionHot := 'Ch2/Ch1';
        unChDivCh.CaptionSel := 'Ch2/Ch1';
      end;
    end;

    if (frmImageControl.unChDivCh.Selected) then begin
        if (ChannelOrder = ASCENDING) then begin
          frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'Ch1/Ch2';
          if not(frmImageControl.MeasureDistance.Down) then titValueType.Caption := 'Ch1/Ch2';
        end
          else
        if (ChannelOrder = DESCENDING) then begin
          frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'Ch2/Ch1';
          if not(frmImageControl.MeasureDistance.Down) then titValueType.Caption := 'Ch2/Ch1';
        end;
    end;

    if (frm2ndWin <> nil) then begin
      if (ChannelOrder = ASCENDING) then frm2ndWin.Caption := 'Secondary Window: Channel Two'
        else
      if (ChannelOrder = DESCENDING) then frm2ndWin.Caption := 'Secondary Window: Channel One';
    end;

   frmImageControl.SwapBKGs(Sender);

   with frmImageControl do begin    //to recreate the Histogram for the respective channel
    if (ub1stChannel.Selected) then ChNr := 0 else
    if (ub2ndChannel.Selected) then ChNr := 1;
    PlaybackScrollBarChange(Sender);
   end;

  End; //if (NrChannels > 1) and (MainImLoaded) then begin

End;//procedure TfrmPlayback.sbSwapChannelClick


{------------------------ Set X,Y of  rect ROI by Typing ---------------------}

procedure TfrmPlayback.sbChangeHeightClick(Sender: TObject);
begin

  //Height = 145; client height = 117
  if (frmPlayback.ClientHeight > 117) then frmPlayback.Height := 117
  else frmPlayback.Height := 117 + 30;
end;

procedure TfrmPlayback.ubIncreaseHeigthClick(Sender: TObject);
begin
  if (frmPlayback.ClientHeight > 117) then frmPlayback.Height := 117
  else frmPlayback.Height := 117 + 30;
end;

procedure TfrmPlayback.ubRatioOn_PlayBackClick(Sender: TObject);
begin
  with frmImageControl do begin
    ubRatioOn.Selected := ubRatioOn_PlayBack.Selected;
    ubRatioOnClick(Sender);
  end;
end;

procedure TfrmPlayback.ubRatioOn_PlayBackMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;
begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 28;
  GetHelp(HelpCode);
 end;

end;

procedure TfrmPlayback.sbSetROI_XYposClick(Sender: TObject);
var X,Y : Integer;
Begin
 If (frmImageControl.PutBox.Down) and (ROIselected > 0) Then Begin
  If (edROI_Xpos.Text <> '') and (edROI_Ypos.Text <> '') Then Begin

     X := StrToInt(edROI_Xpos.Text);
     Y := StrToInt(edROI_Ypos.Text);

     XL   :=  X - ROIrct.Xsize shr 1;
     Xr   :=  X + ROIrct.Xsize shr 1 - ROIrct.Rc;
     Yup  :=  Y - ROIrct.Ysize shr 1;
     Yd   :=  Y + ROIrct.Ysize shr 1 - ROIrct.Bc;

     If (XL < 0) or (Xr > imXsize-1) or (Yup < 0) or (Yd > imYsize-1) then Begin
      if (XL < 0) then
        MessageDlg('Increase X coordinate',mtError,[mbOK],0);
      if (Xr > imXsize-1) then
        MessageDlg('Decrease X coordinate',mtError,[mbOK],0);
      if (Yup < 0) then
        MessageDlg('Increase Y coordinate',mtError,[mbOK],0);
      if (Yd > imYsize-1) then
        MessageDlg('Decrease Y coordinate',mtError,[mbOK],0);
     End Else
     Begin
      ROIvar.ROICoor[1, ROIselected] := XL;
      ROIvar.ROICoor[2, ROIselected] := Yup;
      ROIvar.ROICoor[3, ROIselected] := XR;
      ROIvar.ROICoor[4, ROIselected] := Yd;
      UpdateMainImage(True);
      if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);
     End;
  End  //If (edROI_Xpos.Text <> '') and (edROI_Ypos.Text <> '') Then Begin

  Else Begin
    if (edROI_Xpos.Text = '') and (edROI_Ypos.Text = '') then
      MessageDlg('Input X and Y coordinates',mtError,[mbOK],0) else
    if (edROI_Xpos.Text = '') then
      MessageDlg('Input X coordinate',mtError,[mbOK],0) else
    if (edROI_Ypos.Text = '') then
      MessageDlg('Input Y coordinate',mtError,[mbOK],0);
  End;
    frmPlayback.lbSetROI_XY.Caption := 'Set X,Y ROI # ';
    ROIselected := 0;
 End; //If (frmImageControl.PutBox.Down) and (ROIselected > 0) Then Begin
End; //procedure TfrmPlayback.sbSetROI_XYposClick(Sender: TObject);

{--------------------- End of Set X,Y of  rect ROI by Typing -----------------}

{------------ Beg of Selection (Unselection) of Images for AverIm --------------}

procedure TfrmPlayback.DeselectOneClick(Sender: TObject);
var i : integer;
  begin

    AvImList[CurIm] := 0;
    ImSel := 0;
    lblSelIm.Caption := '';
    for i := 0 to NrIm -1 do if AvImList[i] > 0 then Inc(ImSel);

  If (ImSel > 0) then begin
    MakeAverIm;
    if (frmAverIm <> nil) then begin
      UpdateAverImage(True);
      frmAverIm.Caption := 'Average Image on Line';
    end;
    AvImExists := AVER_ON_LINE; {Means Done On Line}

    If (RatioOn = True) then begin
      if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then  SmoothAverIm(AvImRaw,AvIm);
        DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
        DoRatio(DO_COPY);
        UpdateMainImage(True);
        {------  Line Scan  -----------}
      if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
      {---------------- end Line Scan -----------------------}
      { ----------------   3D Image  ------------------------}
      if (Win3DOn) and (SourceFor3D <> AVER_IMAGE_FOR_3D) then
        frm3DImageWin.Update3DImage(False); 
    End; {(RatioOn = True)}

      { ---------   3D Image  ------------}
    if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then
      frm3DImageWin.Update3DImage(True);
{---------------- end 3D Image -----------------------}
  End  //If ImSel > 0

    Else

  Begin {RatioOn should be Shut Off}

    If (frmImageControl.ubRatioOn.Selected) then with frmImageControl Do
    Begin
      ubRatioOn.Selected := False;
      ubRatioOn.OnClick(Sender);
    End;

    if (frmAverIm <> nil) then with frmAverIm.winAverImage do begin
      Canvas.Brush.Color := clBlack;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(Canvas.ClipRect);
      Canvas.Brush.Style := bsClear;
      frmAverIm.Caption := 'No Average';
    end;
    AvImExists := NO_AVERAGE;
    TurnOffXYprofileAverImCheckBox;
    { ----------------   3D Image  ------------------------}
    if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then begin
      SourceFor3D := MAIN_IMAGE_FOR_3D;
      frm3DImageContr.Update3DSource;
    end;
    {---------------- end 3D Image -----------------------}

  End; //Else begin
   
End;  //End of procedure TfrmPlayback.DeselectOneClick(Sender: TObject);
{------------------------------------------------------------------------}
procedure TfrmPlayback.Select10Click(Sender: TObject);
var i, EndTo : integer;
  Begin

  if CurIm + 9 <= NrIm - 1 Then EndTo := CurIm + 9 else
  if CurIm + 9 >  NrIm - 1 Then EndTo := NrIm - 1;

  for i := CurIm to EndTo do AvImList[i] := 1;
  ImSel := 0;
  for i := 0 to NrIm -1 do if AvImList[i] > 0 then Inc(ImSel);

  If (ImSel > 0) then begin
    MakeAverIm;
    if (frmAverIm <> nil) then begin
      UpdateAverImage(True);
      frmAverIm.Caption := 'Average Image on Line';
    end;
    AvImExists := AVER_ON_LINE; {Means Done On Line}
    lblSelIm.Caption := 'S';

    If (RatioOn) then begin
      if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then  SmoothAverIm(AvImRaw,AvIm);
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
      DoRatio(DO_COPY);
      UpdateMainImage(True);
      {------  Line Scan  -----------}
      if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
      {---------------- end Line Scan -----------------------}
      { ----------------   3D Image  ------------------------}
      if (Win3DOn) and (SourceFor3D <> AVER_IMAGE_FOR_3D) then
        frm3DImageWin.Update3DImage(False);
    End; //If (RatioOn = True)

  End; {If ImSel > 0 then begin}

    { ---------   3D Image  ------------------------}
    if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then
      frm3DImageWin.Update3DImage(True);
    {---------------- end 3D Image ------------}


End; // End of procedure TfrmPlayback.Select10Click
{------------------------------------------------------------------------}
procedure TfrmPlayback.Deselect10Click(Sender: TObject);
var i, EndTo : integer;
  begin

  lblSelIm.Caption := '';

  if CurIm + 9 <= NrIm - 1 Then EndTo := CurIm + 9 else
  if CurIm + 9 >  NrIm - 1 Then EndTo := NrIm - 1;

  for i := CurIm to EndTo do AvImList[i] := 0;
  ImSel := 0;
  for i := 0 to NrIm -1 do if AvImList[i] > 0 then Inc(ImSel);

  If (ImSel > 0) then begin
    MakeAverIm;
    if frmAverIm <> nil then begin
      UpdateAverImage(True);
      frmAverIm.Caption := 'Average Image on Line';
    end;
    AvImExists := AVER_ON_LINE; {Means Done On Line}

    If (RatioOn = True) then begin
      if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then SmoothAverIm(AvImRaw,AvIm);
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
      DoRatio(DO_COPY);
      UpdateMainImage(True);
      {------  Line Scan  -----------}
      if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
      {---------------- end Line Scan -----------------------}
      { ----------------   3D Image  ------------------------}
      if (Win3DOn) and (SourceFor3D <> AVER_IMAGE_FOR_3D) then
        frm3DImageWin.Update3DImage(False);
    End; {(RatioOn = True)}

      { --------   3D Image  ------------------}
    if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then
      frm3DImageWin.Update3DImage(True);
    {-------------- end 3D Image -----------------------}
  End {If ImSel > 0 then begin}

    Else

  Begin  {RatioOn should be Shut Off}

    If (frmImageControl.ubRatioOn.Selected) then with frmImageControl Do
    Begin
      ubRatioOn.Selected := False;
      ubRatioOn.OnClick(Sender);
    End;

    if (frmAverIm <> nil) then with frmAverIm.winAverImage do begin
      Canvas.Brush.Color := clBlack;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(Canvas.ClipRect);
      Canvas.Brush.Style := bsClear;
      frmAverIm.Caption := 'No Average';
    end;
    AvImExists := NO_AVERAGE;
    TurnOffXYprofileAverImCheckBox;
     { ----------------   3D Image  ------------------------}
    if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then begin
      SourceFor3D := MAIN_IMAGE_FOR_3D;
      frm3DImageContr.Update3DSource;
    end;
    {---------------- end 3D Image -----------------------}

  End; //Else Begin


End;  // End of procedure TfrmPlayback.Deselect10Click
{------------------------------------------------------------------------}
procedure TfrmPlayback.DeselectAllClick(Sender: TObject);
var i : integer;
begin

     If (frmImageControl.ubRatioOn.Selected) then with frmImageControl Do
     Begin
      ubRatioOn.Selected := False;
      ubRatioOn.OnClick(Sender);
     End;

     for i := 0 to NrIm - 1 do AvImList[i] := 0;
     ImSel := 0;
     AvImExists := NO_AVERAGE;

    if (frmAverIm <> nil) then with frmAverIm.winAverImage do begin
      Canvas.Brush.Color := clBlack;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(Canvas.ClipRect);
      Canvas.Brush.Style := bsClear;
      frmAverIm.Caption := 'No Average';
    end;

    frmPlayback.SelectOne.Enabled   := True;
    frmPlayback.DeselectOne.Enabled := True;
    frmPlayback.Select10.Enabled    := True;
    frmPlayback.Deselect10.Enabled  := True;
    frmPlayback.lblSelIm.Caption    := '';

  { ----------------   3D Image  ------------------------}
    if (Win3DOn) and (SourceFor3D = AVER_IMAGE_FOR_3D) then begin
      SourceFor3D := MAIN_IMAGE_FOR_3D;
      frm3DImageContr.Update3DSource;
    end;
 {---------------- end 3D Image -----------------------}
 TurnOffXYprofileAverImCheckBox;

End;

{------------ End of Selection (Unselection) of Images for AverIm --------------}

procedure TfrmPlayback.InOutOfProgramClick(Sender: TObject);

var frmLeft,frmTop : Integer;

begin
  if (frmMainWin.FormStyle = fsMDIChild) and
       (InOutOfProgram.Down = True) then begin
         frmMainWin.FormStyle := fsStayOnTop;
         with frmMainWin do begin
         SetBounds(Screen.Width  div 2 - Width div 2,
                   Screen.Height div 2 - Height div 2,
                   Width,Height);
         InOutOfProgram.Hint := 'Brings Window & List of Files into Main Program';
         end;
         if (frmFileList <> nil) then with frmFileList do begin
         frmFileList.FormStyle := fsStayOnTop;
         SetBounds(Screen.Width  div 2 - Width div 2,
                   Screen.Height div 2 - Height div 2,
                   Width,Height);
         end;
    end else
    if (frmMainWin.FormStyle = fsStayOnTop) and
       (InOutOfProgram.Down = False) then begin
       frmLeft := frmMainWin.Left;
       frmTop  := frmMainWin.Top;
       frmMainWin.FormStyle := fsMDIChild;
       frmMainWin.Left := frmLeft;
       frmMainWin.Top  := frmTop;
       SetFormSize(frmMainWin,frmMainWin.winMainImage);  // keeps Form Size 
       frmPlayback.InOutOfProgram.Hint := 'Brings Window & List of Files out of Main Program';
       if (frmFileList <> nil) then frmFileList.FormStyle := fsMDIChild;
    end;
End;

{------------------------------------------------------------------------}

procedure TfrmPlayback.FullScrClick(Sender: TObject);
  begin
   if frmPlayback.Magnify.Down = True then frmPlayback.MagnifyClick(Sender);
End;
{------------------------------------------------------------------------}

procedure TfrmPlayback.Magnify4xClick(Sender: TObject);
begin
  if (Magnify4x.Down = False) then begin
    Zoom := 1;
  end
    else
  if (Magnify4x.Down = True)  then begin
    frmPlayback.Magnify.Down  := False;
    frmPlayback.Decrease.Down := False;
    Zoom := 2;
    Zm   := 2;
  end;

   SetFormSize(frmMainWin,frmMainWin.winMainImage);
   If (frmAverIm <> nil) then SetFormSize(frmAverIm,frmAverIm.winAverImage);
   If (frm2ndWin <> nil) then SetFormSize(frm2ndWin,frm2ndWin.win2ndImage);
   If (frmMergeWin <> nil) then SetFormSize(frmMergeWin,frmMergeWin.MergeImage);
end;

procedure TfrmPlayback.MagnifyClick(Sender: TObject);
Begin

  if (Magnify.Down = False) then begin
    Zoom := 1;
  end
    else
  if frmPlayback.Magnify.Down = True  then begin
    Magnify4x.Down := False;
    Decrease.Down := False;
    Zoom := 2;
    Zm   := 1;
  end;

   SetFormSize(frmMainWin,frmMainWin.winMainImage);
   If (frmAverIm <> nil) then SetFormSize(frmAverIm,frmAverIm.winAverImage);
   If (frm2ndWin <> nil) then SetFormSize(frm2ndWin,frm2ndWin.win2ndImage);
   If (frmMergeWin <> nil) then SetFormSize(frmMergeWin,frmMergeWin.MergeImage);

End;   {Zoom}

procedure TfrmPlayback.DecreaseClick(Sender: TObject);
begin
  if frmPlayback.Decrease.Down = False then begin
    Zoom := 1;
  end
    else
  if (Decrease.Down = True)  then begin
    Magnify.Down := False;
    Magnify4x.Down := False;
    Zoom := -2;
    Zm := 1;
  end;

  SetFormSize(frmMainWin,frmMainWin.winMainImage);
  if frmAverIm <> nil   then SetFormSize(frmAverIm,frmAverIm.winAverImage);
  If (frm2ndWin <> nil) then SetFormSize(frm2ndWin,frm2ndWin.win2ndImage);
  If (frmMergeWin <> nil) then SetFormSize(frmMergeWin,frmMergeWin.MergeImage);

End;   {Decrease - Oposite of Zoom}
{******************************************************************************}
END.
