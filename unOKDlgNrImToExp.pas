{$D-,L-,O+,Q-,R-,Y-,S-}
unit unOKDlgNrImToExp;

interface

uses  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
      Vcl.Controls, Vcl.StdCtrls,Vcl.Buttons, Vcl.ExtCtrls,
      {added by me->} Vcl.Dialogs, Vcl.ComCtrls, DSlider, EditNumerical,
  UniButton;


Const MAX_FRAMERATE = 120;
      MIN_FRAMERATE = 0.1;
Type
  TfrmOKDlgNrImtoExp = class(TForm)
    Bevel1: TBevel;
    TitImToExp: TLabel;
    lbOriginalFramesSec: TLabel;
    lbMovieDuration: TLabel;
    dsSelFromTo: TDSlider;
    enSelFromTo: TEditNumerical;
    btOK: TButton;
    btCancel: TButton;
    pnMovieKind: TPanel;
    rbAVI: TRadioButton;
    enAverBitRate: TEditNumerical;
    lbTitleRecomendedBitRate: TLabel;
    lbValueRecBitrate: TLabel;
    lbEffectiveFramesSec: TLabel;
    enFrameRate: TEditNumerical;
    enSpeedFactor: TEditNumerical;
    BevlSourceMovProperties: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbFileSize: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel3: TBevel;
    Label6: TLabel;
    cbWriteLogFile: TCheckBox;
    rbMP4: TRadioButton;
    rbFLV: TRadioButton;
    rbMOV: TRadioButton;
    trbAverBitRate: TTrackBar;
    trbCRF: TTrackBar;
    lbArrow: TLabel;
    lbCRF: TLabel;
    rbCRF: TRadioButton;
    rbBitRate: TRadioButton;
    Label10: TLabel;
    unKalmanFltInfo: TUniButton;
    Label7: TLabel;
    procedure btCancelClick(Sender: TObject);
    procedure SetbtOKActive(Sender: TObject);
    procedure btOKClick(Sender: TObject);
    procedure enSelFromToReturnPressed(Sender: TObject);
    procedure dsSelFromToChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MPEGLimitBitRateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure KeepDurationMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tlDecrSpeedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tlPlaybackSpeedMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure rbAVIClick(Sender: TObject);
    procedure enAverBitRateReturnPressed(Sender: TObject);
    procedure enFrameRateReturnPressed(Sender: TObject);
    procedure enSpeedFactorReturnPressed(Sender: TObject);
    procedure cbWriteLogFileClick(Sender: TObject);
    procedure rbMP4Click(Sender: TObject);
    procedure rbFLVClick(Sender: TObject);
    procedure rbMOVClick(Sender: TObject);
    procedure trbAverBitRateChange(Sender: TObject);
    procedure trbCRFChange(Sender: TObject);
    procedure rbBitRateClick(Sender: TObject);
    procedure rbCRFClick(Sender: TObject);
    procedure unKalmanFltInfoClick(Sender: TObject);
  private
    { Private declarations }
   
    CreateForm : Boolean;
    NumberOfPixels : LongInt;
    function  GetNumberOfPixels : LongInt;
    procedure SetFramesPerSec;
    procedure RefreshPlaybackSpeedLabel;
    procedure SetMovieKind(const MovieKind : Integer);
    procedure SetlbOriginalFramesSecTitle;
    procedure SetlbValueRecBitrate;
    procedure SetFileSizeLabel;
  public
    { Public declarations }

  end;

var
  frmOKDlgNrImtoExp: TfrmOKDlgNrImtoExp;


implementation
uses  unGlobUnit, unPlayBack, Main,unImageControl,unMainWindow,un3DImageWin;
{$R *.dfm}

procedure TfrmOKDlgNrImtoExp.dsSelFromToChange(Sender: TObject);
begin
  ExportDial.FromIm := dsSelFromTo.PosFrom;
  ExportDial.ToIm   := dsSelFromTo.PosTo;
  enSelFromTo.SetNumbersOneTwo(dsSelFromTo.PosFrom+1,dsSelFromTo.PosTo+1);
  if ExportDial.DialogKind = 2 then begin //only for movies
    SetlbOriginalFramesSecTitle;
    RefreshPlaybackSpeedLabel;
    SetFileSizeLabel;
  end;
end;

procedure TfrmOKDlgNrImtoExp.enSelFromToReturnPressed(Sender: TObject);
begin
  dsSelFromTo.SetSliderPos(enSelFromTo.NumberOne-1,enSelFromTo.NumberTwo-1);
  dsSelFromToChange(Sender);
end;

procedure TfrmOKDlgNrImtoExp.enAverBitRateReturnPressed(Sender: TObject);
begin
  trbAverBitRate.Position := enAverBitRate.NumberOne;
end;

procedure TfrmOKDlgNrImtoExp.trbAverBitRateChange(Sender: TObject);
begin
  enAverBitRate.NumberOne := trbAverBitRate.Position;
  ExportDial.MovieBitRate := enAverBitRate.NumberOne;
  SetFileSizeLabel;
end;

procedure TfrmOKDlgNrImtoExp.trbCRFChange(Sender: TObject);
begin
  ExportDial.CRF := 35 - trbCRF.Position;
  lbCRF.Caption  := IntToStr(ExportDial.CRF);
end;

procedure TfrmOKDlgNrImtoExp.unKalmanFltInfoClick(Sender: TObject);
var HelpCode : integer;
begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 54;
  GetHelp(HelpCode);
end;

procedure TfrmOKDlgNrImtoExp.SetFileSizeLabel;
var  NrOfIm   : Integer;
     Duration : Double;

begin

  //-- Now Estimates the File Size (Mb) ----//
  //8000 comes from 8*1000; 8 to convert Kbits to Kbytes and 1000 to convert Kbytes to Mbytes
  NrOfIm := (ExportDial.ToIm-ExportDial.FromIm+1);

    if (ExportDial.MovieKind in [MPEG_1,WMV_VC1,MP4_x264,FLV_x264,MOV_x264]) then begin
      Duration := NrOfIm/ExportDial.MovieFrameRate;
      if (ExportDial.UseCRF) then lbFileSize.Caption := 'Unknown'
      else
      lbFileSize.Caption := FloatToStrF((Duration*ExportDial.MovieBitRate)/8000,ffFixed,8,3);
    end else
    if (ExportDial.MovieKind = AVI_UNC) then begin
      lbFileSize.Caption := FloatToStrF((3*NumberOfPixels*NrOfIm)/1000000,ffFixed,8,3);
    end;
end;


procedure TfrmOKDlgNrImtoExp.SetbtOKActive(Sender: TObject);
begin
   frmOKDlgNrImtoExp.ActiveControl := btOK;
end;

procedure TfrmOKDlgNrImtoExp.FormCreate(Sender: TObject);
var ImStr : string;
    NotEv : TNotifyEvent;
begin

      lbArrow.Caption := Chr(174);
      rbBitRate.Checked := not(ExportDial.UseCRF);
      trbAverBitRate.Enabled := not(ExportDial.UseCRF);
      enAverBitRate.Enabled := not(ExportDial.UseCRF);
      enAverBitRate.HideText := ExportDial.UseCRF;

      rbCRF.Checked := ExportDial.UseCRF;
      trbCRF.Position := 35 - ExportDial.CRF;
      trbCRF.Enabled := ExportDial.UseCRF;
      lbCRF.Caption := IntToStr(ExportDial.CRF);

      //release Lock of Images to Loop settings
      if frmPlayback.LockImagesToLoop.Down then begin
          frmPlayback.LockImagesToLoop.Down := False;
          frmPlayback.LockImagesToLoopClick(Sender);
      end;

      ExportDial.FromIm    := 0;
      ExportDial.ToIm      := frmPlayback.PlaybackScrollBar.Max;

      dsSelFromTo.SetSlider(ExportDial.FromIm,ExportDial.ToIm,ExportDial.FromIm,ExportDial.ToIm);
      enSelFromTo.Min := ExportDial.FromIm+1;
      enSelFromTo.Max := ExportDial.ToIm+1;
      enSelFromTo.MaxLength := 2*(Length(IntToStr(NrIm))) + 1;
      enSelFromTo.SetNumbersOneTwo(ExportDial.FromIm+1,ExportDial.ToIm+1);

      ExportDial.DoWriteLogFile := True;

     //Exports Consecutive Win BMP Images
      if ExportDial.DialogKind = 1 then begin
        frmOKDlgNrImtoExp.Caption := 'Select Images to Export';
        cbWriteLogFile.Top := btOK.Top;
        frmOKDlgNrImtoExp.ClientHeight:= BevlSourceMovProperties.Top-1;
      end else

     //Exports Movie: MPRG or WMV or uncompressed AVI
      if ExportDial.DialogKind = 2 then begin
        CreateForm :=  True;
        frmOKDlgNrImtoExp.Caption := 'Select Images to Make Movie';

        //Selects Bitrate
        if (JumpAv = 1) then
          ExportDial.OrigEffectiveFrameRate := ExportDial.OrigFrameRate else
          ExportDial.OrigEffectiveFrameRate := ExportDial.OrigFrameRate/JumpAv;

        NumberOfPixels := GetNumberOfPixels;

        SetFramesPerSec;
        ExportDial.MovieFrameRate := ExportDial.OrigFrameRate;
        CreateForm :=  False;
        RefreshPlaybackSpeedLabel;

        with ExportDial do begin
          if not(FileExists(SparkAnDir+'ffmpeg.exe')) then begin
            rbMP4.Enabled := False;
            rbFLV.Enabled := False;
            rbMOV.Enabled := False;
            if (MovieKind in[MP4_x264,FLV_x264,MOV_x264]) then
            MovieKind := WMV_VC1;
          end;

         // if (MovieKind = WMV_VC1)  then rbWMV. Windows Media Videp 9 is no longer mainteained
          if (MovieKind = AVI_UNC)  then rbAVI. Checked := True else
          if (MovieKind = MP4_x264) then rbMP4. Checked := True else
          if (MovieKind = FLV_x264) then rbFLV. Checked := True else
          if (MovieKind = MOV_x264) then rbMOV. Checked := True;
        end; //with

        //--- Settings for Custom Framerate for AVI ---//
        enSpeedFactor.Min := MIN_FRAMERATE/ExportDial.OrigEffectiveFrameRate;
        if (ExportDial.OrigEffectiveFrameRate < 0.1) then
        enSpeedFactor.NumberFloat := MIN_FRAMERATE/ExportDial.OrigEffectiveFrameRate
          else
        enSpeedFactor.NumberFloat := 1.0;

        enSpeedFactor.Max := MAX_FRAMERATE/ExportDial.OrigEffectiveFrameRate;
        if (ExportDial.OrigEffectiveFrameRate < 0.01) then
        enFrameRate.NumberFloat  := 0.01 else
        enFrameRate.NumberFloat  := ExportDial.OrigEffectiveFrameRate;
        //-----------------------------------------------------//

      end;

      if (JumpAv = 1) then ImStr := frmPlayback.cmbPlayMode.Items[0] else
      ImStr := frmPlayback.cmbPlayMode.Items[JumpAv div 2];
      ImStr := ImStr + ' playback';
      lbEffectiveFramesSec.Caption := 'Effective (' + ImStr + ') = ' +
      FloatToStrF(ExportDial.OrigEffectiveFrameRate,ffFixed,5,3) + ' frm/s';

      frmOKDlgNrImtoExp.ShowModal;

end;


Procedure TfrmOKDlgNrImtoExp.SetFramesPerSec;
Begin
      SetlbOriginalFramesSecTitle;
End;

procedure TfrmOKDlgNrImtoExp.SetlbOriginalFramesSecTitle;
begin
  lbOriginalFramesSec.Caption := 'Original = ' +
  FloatToStrF(ExportDial.OrigFrameRate,ffFixed,5,3) + ' frm/s, Duration = ' +
  FloatToStrF((ExportDial.ToIm-ExportDial.FromIm+1)/ExportDial.OrigEffectiveFrameRate,ffFixed,10,2) + ' s';
end;

procedure TfrmOKDlgNrImtoExp.RefreshPlaybackSpeedLabel;
var OrigDuration  : Double;
    ConvFactor    : Double;
begin

    lbMovieDuration.Visible := True;

    OrigDuration := (ExportDial.ToIm-ExportDial.FromIm+1)/ExportDial.OrigEffectiveFrameRate;

    ConvFactor    := ExportDial.MovieFrameRate/ExportDial.OrigEffectiveFrameRate;
    MovieDuration := OrigDuration/ConvFactor;

    lbMovieDuration.Font.Color := clBlue;
    lbMovieDuration.Caption := 'Movie Duration = (' + FloatToStrF(OrigDuration,ffFixed,10,2) + ' s / ' +
                                        FloatToStrF(ConvFactor,ffFixed,10,4) + ')' + ' = ' +
                                        FloatToStrF(MovieDuration,ffFixed,8,2) + ' s';
end;

procedure TfrmOKDlgNrImtoExp.enSpeedFactorReturnPressed(Sender: TObject);
begin
    enFrameRate.NumberFloat :=
    ExportDial.OrigEffectiveFrameRate*enSpeedFactor.NumberFloat;
    ExportDial.MotionFactor := enSpeedFactor.NumberFloat;
    enFrameRateReturnPressed(Sender);
end;

 
procedure TfrmOKDlgNrImtoExp.enFrameRateReturnPressed(Sender: TObject);
begin

    ExportDial.MovieFrameRate := enFrameRate.NumberFloat;
    enSpeedFactor.NumberFloat := enFrameRate.NumberFloat/ExportDial.OrigEffectiveFrameRate;
    ExportDial.MotionFactor := enSpeedFactor.NumberFloat;

    RefreshPlaybackSpeedLabel;
    if not(ExportDial.UseCRF) then SetlbValueRecBitrate;

end;

procedure TfrmOKDlgNrImtoExp.cbWriteLogFileClick(Sender: TObject);
begin
  ExportDial.DoWriteLogFile := cbWriteLogFile.Checked;
end;

procedure TfrmOKDlgNrImtoExp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmOKDlgNrImtoExp := nil;
end;
{************* Movie File Settings Start From HERE ***************************}

procedure TfrmOKDlgNrImtoExp.rbAVIClick(Sender: TObject);
begin
   SetMovieKind(AVI_UNC);
end;

procedure TfrmOKDlgNrImtoExp.rbBitRateClick(Sender: TObject);
begin
  ExportDial.UseCRF := not(rbBitRate.Checked);
  trbAverBitRate.Enabled := rbBitRate.Checked;
  enAverBitRate.Enabled := rbBitRate.Checked;
  enAverBitRate.HideText := not(rbBitRate.Checked);
  trbCRF.Enabled := not(rbBitRate.Checked);
  SetFileSizeLabel;
  SetlbValueRecBitrate;
end;

procedure TfrmOKDlgNrImtoExp.rbCRFClick(Sender: TObject);
begin
    ExportDial.UseCRF := rbCRF.Checked;
    trbAverBitRate.Enabled := not(rbCRF.Checked);
    enAverBitRate.Enabled := not(rbCRF.Checked);
    enAverBitRate.HideText := rbCRF.Checked;
    trbCRF.Enabled := rbCRF.Checked;
    lbFileSize.Caption := 'Unknown';
end;

procedure TfrmOKDlgNrImtoExp.rbMP4Click(Sender: TObject);
begin
   SetMovieKind(MP4_x264);
end;

procedure TfrmOKDlgNrImtoExp.rbFLVClick(Sender: TObject);
begin
   SetMovieKind(FLV_x264);
end;

procedure TfrmOKDlgNrImtoExp.rbMOVClick(Sender: TObject);
begin
   SetMovieKind(MOV_x264);
end;

procedure TfrmOKDlgNrImtoExp.SetMovieKind(const MovieKind : Integer);
begin      

  with MainForm do begin
  if (MovieKind = AVI_UNC) then begin
    SaveFileDialog.Filter := 'Movie File Name (*.avi)|*.avi';
    rbBitRate.Enabled := False;
    rbCRF.Enabled := False;
  end else
  if (MovieKind = MP4_x264) then begin
    SaveFileDialog.Filter := 'Movie File Name (*.mp4, x264 encoded)|*.mp4';
    rbBitRate.Enabled := True;
    rbCRF.Enabled := True;
  end else
  if (MovieKind = FLV_x264) then begin
    SaveFileDialog.Filter := 'Movie File Name (*.flv, x264 encoded)|*.flv';
    rbBitRate.Enabled := True;
    rbCRF.Enabled := True;
  end else
  if (MovieKind = MOV_x264) then begin
    SaveFileDialog.Filter := 'Movie File Name (*.mov, x264 encoded)|*.mov';
    rbBitRate.Enabled := True;
    rbCRF.Enabled := True;
  end
  end;

  ExportDial.MovieKind := MovieKind;
  if not(ExportDial.UseCRF) then SetlbValueRecBitrate;

end;

procedure TfrmOKDlgNrImtoExp.SetlbValueRecBitrate;
var MinimalBitrate   : Integer;
    BitPixFrm : Double; // Bits/(Pixel*Frame)
    Sender : TObject;
begin     


with ExportDial do begin

 If (MovieKind in [MPEG_1,WMV_VC1,MP4_x264,FLV_x264,MOV_x264]) Then Begin

  trbAverBitRate.Enabled := True; // in case it was disabled by uncompressed AVI
  enAverBitRate.HideText := False;
  enAverBitRate.Enabled := True;

  if (MovieKind in[MP4_x264,FLV_x264,MOV_x264]) then BitPixFrm := 0.3815;

  if (MovieFromWin in [WINDOW_MAIN,WINDOW_MERGE]) then begin
    if Not(frmImageControl.ubApplyFrame.Selected) then
      MinimalBitrate := Round((BitPixFrm*NumberOfPixels*ExportDial.MovieFrameRate)/1000) else
    if    (frmImageControl.ubApplyFrame.Selected) then
      MinimalBitrate := Round((BitPixFrm*NumberOfPixels*ExportDial.MovieFrameRate)/1000);
  end else
  if (MovieFromWin = WINDOW_3D) then begin
      MinimalBitrate := Round((BitPixFrm*NumberOfPixels*ExportDial.MovieFrameRate)/1000);
  end;

  lbValueRecBitrate.Caption := IntToStr(MinimalBitrate);
  if (trbAverBitRate.Position <> MinimalBitrate) then begin
    trbAverBitRate.Position := MinimalBitrate;
    if (trbAverBitRate.Position <> MinimalBitrate) then
    trbAverBitRateChange(Sender); //force change in order to set enAverBitRate & Label
    //because if it was already e.g. minimum it will not trigger "Change"
  end else
    trbAverBitRateChange(Sender); //force change in order to set enAverBitRate & Label
 End Else
 Begin
  trbAverBitRate.Enabled := False;
  enAverBitRate.HideText := True;
  enAverBitRate.Enabled := False;
  lbValueRecBitrate.Caption := 'N/A';
  SetFileSizeLabel;
 End;

 end; //with


End;

function TfrmOKDlgNrImtoExp.GetNumberOfPixels : LongInt;
begin

  if (MovieFromWin in[WINDOW_MAIN,WINDOW_MERGE]) then with frmMainWin do begin
    if Not(frmImageControl.ubApplyFrame.Selected) then
      Result := winMainImage.Width*winMainImage.Height else
    if    (frmImageControl.ubApplyFrame.Selected) then
      Result := (SelFrame.Width+1)*(SelFrame.Height+1);
  end else
  if (MovieFromWin = WINDOW_3D) then with frm3DImageWin do begin
    Result := Image3DWin.Width*Image3DWin.Height;
  end;

end;

{---------------- HELP procedures From Here ------------------------------------}

procedure TfrmOKDlgNrImtoExp.MPEGLimitBitRateMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 4;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmOKDlgNrImtoExp.KeepDurationMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 3;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmOKDlgNrImtoExp.btCancelClick(Sender: TObject);
begin
   ExportDial.DoCancel := True;
   frmOKDlgNrImtoExp.Close;
end;

procedure TfrmOKDlgNrImtoExp.btOKClick(Sender: TObject);
begin
 If (FileExists(SparkAnDir + 'ffmpeg.exe')) then Begin
  ExportDial.DoCancel := False;
  frmOKDlgNrImtoExp.Close;
 End
  else
 Begin
  MessageDlg('SparkAn executes FFmpeg.exe to create mp4,  flv, mov and avi movies. ' +
              'FFmpeg is free software and is licensed under the LGPL or GPL. ' +
              'Please, download ffmpeg.exe as Windows 64-bit Build from: '      +
              'https://ffmpeg.zeranoe.com/builds.  Uncompress it and copy ffmpeg.exe ' +
              'from the "bin" folder to the SparkAn folder. ' +
              'Complete FFmpeg documentation is available from FFmpeg.org.',mtInformation,[mbOK],0);
 End;
End;

procedure TfrmOKDlgNrImtoExp.tlDecrSpeedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 6;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmOKDlgNrImtoExp.tlPlaybackSpeedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 7;
    GetHelp(HelpCode);
  end;
end;

END.
