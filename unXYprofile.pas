unit unXYprofile;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCLTee.TeEngine, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.Series, Vcl.StdCtrls,Vcl.Clipbrd,
  UniButton, VclTee.TeeGDIPlus, Vcl.Menus;

type
  TfrmXYprofile = class(TForm)
    Chart_XYprofile: TChart;
    MicronSeries: TLineSeries;
    btCopyToClipBoard: TButton;
    btSaveChart: TButton;
    btExportChartAsText: TButton;
    Panel1: TPanel;
    SaveDialog_XYprofile: TSaveDialog;
    ubOnOff: TUniButton;
    rdMainWindow: TRadioButton;
    rdAverageImage: TRadioButton;
    btSaveRectangleToFile: TButton;
    btOpenRectangleFile: TButton;
    PixelSeries: TLineSeries;
    pMenuCopy: TPopupMenu;
    CopyAsMetafile: TMenuItem;
    CopyAsBMP: TMenuItem;
    CancelCopy: TMenuItem;
    pmMenuSave: TPopupMenu;
    SaveAsMetafile: TMenuItem;
    SaveAsBMP: TMenuItem;
    CancelSave: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btCopyToClipBoardClick(Sender: TObject);
    procedure btSaveChartClick(Sender: TObject);
    procedure ubOnOffClick(Sender: TObject);
    procedure rdMainWindowClick(Sender: TObject);
    procedure rdAverageImageClick(Sender: TObject);
    procedure btSaveRectangleToFileClick(Sender: TObject);
    procedure btOpenRectangleFileClick(Sender: TObject);
    procedure btExportChartAsTextClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CopyAsMetafileClick(Sender: TObject);
    procedure CopyAsBMPClick(Sender: TObject);
    procedure SaveAsMetafileClick(Sender: TObject);
    procedure SaveAsBMPClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    procedure SaveChartAsMetafileOrBMP(Sender: TObject);
  end;

var
  frmXYprofile: TfrmXYprofile;

implementation

{$R *.dfm}

uses unImageControl, unGlobUnit, unAverIm,unFunctions;


procedure TfrmXYprofile.btSaveRectangleToFileClick(Sender: TObject);
var SaveFname : String;
    TxtFile   : TextFile;
    WriteStr  : AnsiString;
begin

  SaveDialog_XYprofile.Title := 'Save X or Y Profile Rectangle Coordinates to File';
  SaveDialog_XYprofile.Filter := 'Save X or Y Profile Rectangle Coordinates to File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveDialog_XYprofile.InitialDir := FilePaths.MarkFilePath;
  SaveDialog_XYprofile.FileName := FilePaths.MarkFilePath + imFtitle + '_XY_Rectangle';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveDialog_XYprofile.InitialDir := ExtractFilePath(ImFname);
  SaveDialog_XYprofile.FileName := imFtitle + '_XY_Rectangle';
  end;
  //So far it will use FilePaths.MarkFilePath

 If (SaveDialog_XYprofile.Execute) then Begin

  FilePaths.MarkFilePath := ExtractFilePath(SaveDialog_XYprofile.FileName);
  SaveFname              := SaveDialog_XYprofile.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn X or Y Profile Rectangle Coordinates File';
    Writeln(TxTFile, WriteStr);
    {2nd: wtites explanation of order of data}
    WriteStr := 'Follow Data for: Left, Top, Right, Bottom';
    Writeln(TxTFile, WriteStr);
    {4th: writes data}
    WriteStr := IntToStr(XYprofileRect.Left) + Char(9) + IntToStr(XYprofileRect.Top) + Char(9) +
                IntToStr(XYprofileRect.Right) + Char(9) + IntToStr(XYprofileRect.Bottom);

    Writeln(TxTFile, WriteStr);

    CloseFile(TxtFile);

  End;
 End; //If (SaveDialog_XYprofile.Execute) then Begin
End;

procedure TfrmXYprofile.btOpenRectangleFileClick(Sender: TObject);
var TxTFile : TextFile;
    ReadStr : AnsiString;
begin

  SaveDialog_XYprofile.Title := 'Open  X or Y Profile Rectangle Coordinates File';
  SaveDialog_XYprofile.Filter := 'Open  X or Y Profile Rectangle Coordinates File (*.txt)|*.txt';
  SaveDialog_XYprofile.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveDialog_XYprofile.InitialDir := FilePaths.MarkFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then
  if ImFname <> '' then SaveDialog_XYprofile.InitialDir := ExtractFileDir(ImFname);
  //for now Spatial Spread Files will use FilePaths.MarkFilePath//

 If (SaveDialog_XYprofile.Execute) then Begin
  AssignFile(TxTFile,SaveDialog_XYprofile.FileName);
  FileMode := fmOpenRead;
  Reset(TxTFile);
  {-------- Reads Heather-------}
  ReadLn(TxTFile,ReadStr);
  if ReadStr <> 'SparkAn X or Y Profile Rectangle Coordinates File' then
    MessageDlg('This is Not SparkAn X or Y Profile Rectangle Coordinates File Type',mtError,[mbOK],0)
      else
  If (ReadStr = 'SparkAn X or Y Profile Rectangle Coordinates File') then Begin
    ReadLn(TxTFile);
    Read(TxTFile,XYprofileRect.Left);
    Read(TxTFile,XYprofileRect.Top);
    Read(TxTFile,XYprofileRect.Right);
    Read(TxTFile,XYprofileRect.Bottom);
    if (XYprofileSource = MAIN_WINDOW) then UpdateMainImage(True);
    if (XYprofileSource = AVER_WINDOW) and (frmAverIm <> nil)
    then UpdateAverImage(True);
  End;
   CloseFile(TxTFile);
 End; //If (SaveDialog_XYprofile.Execute) then Begin

End;

procedure TfrmXYprofile.btExportChartAsTextClick(Sender: TObject);
var SaveFname : String;
    TxtFile   : TextFile;
    WriteStr  : AnsiString;
    GaussSm   : AnsiString;
    i : Integer;
begin
  SaveDialog_XYprofile.Title := 'Save X or Y Profile Plot as Text File';
  SaveDialog_XYprofile.Filter := 'Save X or Y Profile Plot as Text (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveDialog_XYprofile.InitialDir := FilePaths.MarkFilePath;
  SaveDialog_XYprofile.FileName := FilePaths.MarkFilePath + imFtitle + '_XY_Profile';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveDialog_XYprofile.InitialDir := ExtractFilePath(ImFname);
  SaveDialog_XYprofile.FileName := imFtitle + '_XY_Profile';
  end;
  //So far it will use FilePaths.MarkFilePath

 If (SaveDialog_XYprofile.Execute) then Begin

  FilePaths.MarkFilePath := ExtractFilePath(SaveDialog_XYprofile.FileName);
  SaveFname              := SaveDialog_XYprofile.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn X or Y Profile Text File';
    Writeln(TxTFile, WriteStr);
    {2nd: writes type and source of data}
    if (XYprofileKind = X_PROFILE) then WriteStr := 'X profile'
      else
    if (XYprofileKind = Y_PROFILE) then WriteStr := 'Y profile';

    if (XYprofileSource = MAIN_WINDOW) then WriteStr := WriteStr + ' of Main Window'
      else
    if (XYprofileSource = AVER_WINDOW) then WriteStr := WriteStr + ' of Average Image';

    //3rd: writes if image was smoothed
    WriteStr := WriteStr + '; Extracted from: ' + ImFtitle;
    Writeln(TxTFile, WriteStr);

    if not(XYprofileFilter2DUsed) or (XYprofileSource = AVER_WINDOW) then WriteStr := 'Image Was Not Smoothed'
      else
    if    (XYprofileFilter2DUsed) then begin
      if (SmoothMode = SMOOTH_BOX) Then WriteStr := ' & 2D Boxcar Filt = ' + IntToStr(BoxSmSize) else
      if (SmoothMode = SMOOTH_MED) Then WriteStr := ' & 2D Median Filt = ' + IntToStr(MedSmSize) else
      if (SmoothMode = SMOOTH_BOX_MED) Then WriteStr := ' & 2D Boxcar Filt = ' + IntToStr(BoxSmSize) +
                                        ' -> 2D Median Filt = ' + IntToStr(MedSmSize) else
      if (SmoothMode = SMOOTH_MED_BOX) Then WriteStr := ' & 2D Median Filt = ' + IntToStr(MedSmSize) +
                                        ' -> 2D Boxcar Filt = ' + IntToStr(BoxSmSize) else
      if (SmoothMode in [SMOOTH_GAUSS,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
        if (GaussSmSize > 3) then GaussSm := IntToStr(GaussSmSize) else
        begin
          if (GaussSmSize = GAUSS_3x3_LITE)   then GaussSm := '3L' else
          if (GaussSmSize = GAUSS_3x3_MEDIUM) then GaussSm := '3M' else
          if (GaussSmSize = GAUSS_3x3_HEAVY)  then GaussSm := '3H' else
          if (GaussSmSize = GAUSS_5x5)        then GaussSm := '5' else
          if (GaussSmSize = GAUSS_7x7)        then GaussSm := '7';
        end;
        if (SmoothMode = SMOOTH_GAUSS) then WriteStr := ' & 2D Gaussian Filt = ' + GaussSm else
        if (SmoothMode = SMOOTH_GAUSS_MED) Then WriteStr := ' & 2D Gaussian Filt = ' + GaussSm +
                                        ' -> 2D Median Filt = ' + IntToStr(MedSmSize) else
        if (SmoothMode = SMOOTH_MED_GAUSS) Then WriteStr := ' & 2D Median Filt = ' + IntToStr(MedSmSize) +
                                        ' -> 2D Gaussian Filt = ' + GaussSm;
      end;
       WriteStr := 'Image Smoothed With: ' +  WriteStr;
    end;

    Writeln(TxTFile, WriteStr);

    {4th: wtites explanation of order of data}
    if ((XYprofileSource = MAIN_WINDOW) and not(ratioOn)) or (XYprofileSource = AVER_WINDOW) then
      WriteStr := 'Follow Data for: Coordinates in Microns, Coordinates in Pixels, Value (Pixel Intensity)'
      else
    if (XYprofileSource = MAIN_WINDOW) and (RatioOn) then
      WriteStr := 'Follow Data for: Coordinates in Microns, Coordinates in Pixels, Value (F/Fo)';
    Writeln(TxTFile, WriteStr);

    {5th: writes data}
    for i := 0 to Chart_XYprofile.Series[0].Count-1 do begin
      WriteStr := FloatToStr(Chart_XYprofile.Series[0].XValues[i]) + Char(9) +
                  IntToStr(i) + Char(9) +
                  FloatToStr(Chart_XYprofile.Series[0].YValues[i]);
      Writeln(TxTFile, WriteStr);
    end;

    CloseFile(TxtFile);

  End;
 End; //If (SaveDialog_XYprofile.Execute) then Begin
End;

procedure TfrmXYprofile.btCopyToClipBoardClick(Sender: TObject);
begin
  pMenuCopy.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmXYprofile.CopyAsBMPClick(Sender: TObject);
begin
  Chart_XYprofile.CopyToClipboardBitmap;
end;

procedure TfrmXYprofile.CopyAsMetafileClick(Sender: TObject);
begin
  Chart_XYprofile.CopyToClipboardMetafile(True);
end;

procedure TfrmXYprofile.btSaveChartClick(Sender: TObject);
begin
   pmMenuSave.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmXYprofile.SaveAsBMPClick(Sender: TObject);
begin
  SaveChartAsMetafileOrBMP(Sender);
end;

procedure TfrmXYprofile.SaveAsMetafileClick(Sender: TObject);
begin
  SaveChartAsMetafileOrBMP(Sender);
end;

procedure TfrmXYprofile.SaveChartAsMetafileOrBMP(Sender: TObject);
var  SaveFname : String;
begin

  with SaveDialog_XYprofile do begin
    If (Sender = SaveAsBMP) then Begin
      if (XYprofileKind = X_PROFILE) then begin
        Title := 'Save X profile Plot as Windows BMP';
        Filter := 'Save X profile (*.bmp)|*.bmp';
      end
        else
      if (XYprofileKind = Y_PROFILE) then begin
        Title := 'Save Y profile Plot as Windows BMP';
        Filter := 'Save Y profile (*.bmp)|*.bmp';
      end;
    End
      Else
    If (Sender = SaveAsMetafile) then Begin
      if (XYprofileKind = X_PROFILE) then begin
        Title := 'Save X profile Plot as Windows Enhanced Metafile';
        Filter := 'Save X profile (*.emf)|*.emf';
      end
        else
      if (XYprofileKind = Y_PROFILE) then begin
        Title := 'Save X profile Plot as Windows Enhanced Metafile';
        Filter := 'Save Y profile (*.emf)|*.emf';
      end;
    End;

      if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
        InitialDir := FilePaths.SingleImageFilePath;
        FileName := imFtitle;
      end
        else
      if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
        InitialDir := ExtractFilePath(ImFname);
        FileName := imFtitle;
      end;
      if (XYprofileKind = X_PROFILE) then FileName := imFtitle + '_Xprofile'
        else
      if (XYprofileKind = Y_PROFILE) then FileName := imFtitle + '_Yprofile';
  end; //with SaveDialog_OrthogonalSections

  If (SaveDialog_XYprofile.Execute) then Begin
      FilePaths.SingleImageFilePath := ExtractFilePath(SaveDialog_XYprofile.FileName);
      SaveFname := SaveDialog_XYprofile.FileName;
      if (Sender = SaveAsBMP)      then if ExtractFileExt(SaveFname) <> '.bmp' then SaveFname := SaveFname + '.bmp';
      if (Sender = SaveAsMetafile) then if ExtractFileExt(SaveFname) <> '.emf' then SaveFname := SaveFname + '.emf';
      if (IsFileInUse(SaveFname) = False) then begin
        if (Sender = SaveAsBMP) then Chart_XYprofile.SaveToBitmapFile(SaveFname)
          else
        if (Sender = SaveAsMetafile) then Chart_XYprofile.SaveToMetafileEnh(SaveFname);
      end
      else
        MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

        SaveDialog_XYprofile.InitialDir := ExtractFilePath(ImFname); //reverts to Image File Path

        WriteLogFile(Sender,SaveFname);
  End; //If (SaveDialog_OrthogonalSections.Execute)
End;

procedure TfrmXYprofile.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  ubOnOff.Selected := False;
  ubOnOffClick(sender);

  Action := caFree;
  frmXYprofile := nil;
end;

procedure TfrmXYprofile.FormCreate(Sender: TObject);
begin
  with Chart_XYprofile.Axes do begin
    Left.Minimum := 0;
    Left.Maximum := frmImageControl.trbContrast.Position;
    PixelSeries.Clear;
    MicronSeries.Clear;
    if (MainImLoaded) then Bottom.SetMinMax(0,(XYprofileRect.Width+1)*PixSize)
    else                   Bottom.SetMinMax(0, XYprofileRect.Width+1);
    Top.SetMinMax(0, XYprofileRect.Width+1);
  end;
end;

procedure TfrmXYprofile.rdAverageImageClick(Sender: TObject);
begin
  if (AvImExists > NO_AVERAGE)  then begin
    XYprofileSource := AVER_WINDOW;
    CalculateXYprofile;
    if (frmAverIm <> nil) then UpdateAverImage(True);
  end
    else
  rdMainWindow.Checked := True;
end;

procedure TfrmXYprofile.rdMainWindowClick(Sender: TObject);
begin
  XYprofileSource := MAIN_WINDOW;
  CalculateXYprofile;
end;

procedure TfrmXYprofile.ubOnOffClick(Sender: TObject);
begin

If (MainImLoaded) then Begin

  XYprofileRectVisible  := ubOnOff.Selected;
  SelFrameVisible := False;
  UpdateMainImage(True);

  btCopyToClipBoard.Enabled := True;
  btSaveChart.Enabled := True;
  btExportChartAsText.Enabled := True;
  rdMainWindow.Enabled := True;
  rdAverageImage.Enabled := True;
  btSaveRectangleToFile.Enabled := True;
  btOpenRectangleFile.Enabled := True;

 with frmImageControl do begin
  if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);

  lblBoxXsize.Visible := not(ubOnOff.Selected);
  lblBoxYsize.Visible := not(ubOnOff.Selected);

  lblXmicrons.Visible := not(ubOnOff.Selected);
  lblYmicrons.Visible := not(ubOnOff.Selected);

  scrBoxXsize.Visible := not(ubOnOff.Selected);
  scrBoxYsize.Visible := not(ubOnOff.Selected);


  if (ubOnOff.Selected) then begin
    TitleXofROI.Caption :=  'Width  = '  + IntToStr(XYprofileRect.Width+1) +
                           ';  L = '    + IntToStr(XYprofileRect.Left) +
                           ';  R = '   + IntToStr(XYprofileRect.Right);

      TitleYofROI.Caption := 'Height = ' + IntToStr(XYprofileRect.Height+1) +
                           '; T = '    + IntToStr(XYprofileRect.Top) +
                           '; B = '    + IntToStr(XYprofileRect.Bottom);
  end
    else
  begin
    TitleXofROI.Caption := 'X';
    TitleYofROI.Caption := 'Y';
    if (SelectionFrameChange.Down)
    then SelectionFrameChange.Click;
    if (ubApplyFrame.Selected) and not(SelectionFrameChange.Down)
    then SelectionFrameChange.Click;

   { SelFrameVisible := SelFrameVisibleMem;
    if (SelFrameVisible) then UpdateMainImage(True);  }

    btCopyToClipBoard.Enabled := False;
    btSaveChart.Enabled := False;
    btExportChartAsText.Enabled := False;
    rdMainWindow.Enabled := False;
    rdAverageImage.Enabled := False;
    btSaveRectangleToFile.Enabled := False;
    btOpenRectangleFile.Enabled := False;
  end;
 end; //with frmImageControl do begin
End; //If (ubOnOff.Selected) and (MainImLoaded) then Begin

If not(MainImLoaded) then Begin
  ubOnOff.Selected := False;
End;

End; //procedure TfrmXYprofile.ubOnOffClick(Sender: TObject);

END.
