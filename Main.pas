{$POINTERMATH ON}
//enables pW := pW + 1; Inc and Dec dont need this directive
//enables also pW[i], like pointer to Word to act like pointer to Array like C language
{$D-,L-,O+,Q-,R-,Y-,S-}
unit Main;

interface

uses

  Winapi.Windows, Winapi.Messages, System.Classes,System.Variants, System.SysUtils,
  System.StrUtils,System.AnsiStrings,Vcl.Forms, Vcl.Graphics,Vcl.Controls, Vcl.StdCtrls,
  Vcl.ComCtrls,Winapi.CommCtrl,Vcl.ExtCtrls, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.Menus,
  Vcl.Buttons,Vcl.Printers,Vcl.Clipbrd, Winapi.ShlObj,Vcl.ToolWin,Vcl.Direct2D,System.Math,
  Winapi.ShellApi,unGlobUnit, Convert, OpenPictureDialogA, PwrSave, SuperSubLabel,unInputDialog,UniButton;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    ExportDataAsTXT: TMenuItem;
    ExportBIM: TMenuItem;
    FilePrintItem: TMenuItem;
    FilePrintSetupItem: TMenuItem;
    FileExitItem: TMenuItem;
    HelpContentsItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenFileDialog: TOpenDialog;
    PrintDialog: TPrintDialog;
    PrintSetupDialog: TPrinterSetupDialog;
    View: TMenuItem;
    Options: TMenuItem;
    ExportPlot: TMenuItem;
    ExportPeakMeans: TMenuItem;
    AverageFile: TMenuItem;
    OpenAverageFile: TMenuItem;
    SaveAverageFileAsSPN: TMenuItem;
    QueueFile: TMenuItem;
    OpenQueueFile: TMenuItem;
    SaveMainWindow: TMenuItem;
    SaveAverageImageAsBMP: TMenuItem;
    SaveConsecutiveImages: TMenuItem;
    SaveCalibrationBar: TMenuItem;
    SaveQueueFile: TMenuItem;
    PrintMainImage: TMenuItem;
    PrintAverImage: TMenuItem;
    PrintTimeSerPlot: TMenuItem;
    CloseImageFile: TMenuItem;
    viewMainWindow: TMenuItem;
    viewAverageWindow: TMenuItem;
    viewImageControl: TMenuItem;
    viewTimeSeriesAnalysis: TMenuItem;
    viewEventAutoDetection: TMenuItem;
    viewSparkTable: TMenuItem;
    CaWavesTable: TMenuItem;
    GetHardDriveNr: TMenuItem;
    Sep: TMenuItem;
    QueueFileTable: TMenuItem;
    N2: TMenuItem;
    ileHorizontal1: TMenuItem;
    ileVertical1: TMenuItem;
    Cascade1: TMenuItem;
    ArrangeAll1: TMenuItem;
    ExportPeaks: TMenuItem;
    PeaksTable: TMenuItem;
    SavePlotPanelAsBMP: TMenuItem;
    PrintAnyWindowInFocus: TMenuItem;
    ROIFile: TMenuItem;
    OpenROIfile: TMenuItem;
    SaveROIfile: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    CopyToClipbord: TMenuItem;
    CopyMainImage: TMenuItem;
    CopyAverageImage: TMenuItem;
    CopyCalibrationBar: TMenuItem;
    CopyTimeSeriesPlotImage: TMenuItem;
    OptionsMenu: TMenuItem;
    OpenParFile: TMenuItem;
    SaveParFile: TMenuItem;
    N7: TMenuItem;
    mnPreviousFile: TMenuItem;
    FileList: TMenuItem;
    Separator3: TMenuItem;
    ListofFiles1: TMenuItem;
    OpenPlaylist: TMenuItem;
    SavePlaylist: TMenuItem;
    CopyPlotToMetaFile: TMenuItem;
    N8: TMenuItem;
    SaveMetafIle: TMenuItem;
    N9: TMenuItem;
    PwrSaveSparkAn: TPwrSave;
    viewPlaybackWindow: TMenuItem;
    N10: TMenuItem;
    mnMakeMovie: TMenuItem;
    MovieCommentsTimersDialog: TMenuItem;
    OpenMovieOrImage: TMenuItem;
    OpenImageDialog: TOpenPictureDialogA;
    N11: TMenuItem;
    SaveCollectionOfMultiImageTiffs: TMenuItem;
    SaveFileDialog: TSaveDialog;
    OpenWinBMPfile: TMenuItem;
    N13: TMenuItem;
    viewTimeSeriesAnalysisSlave: TMenuItem;
    viewSpatialSpreadTable: TMenuItem;
    Save3Dwindow: TMenuItem;
    Save3DWindowConsecutiveImages: TMenuItem;
    mnMakeMoviefrom3D: TMenuItem;
    N3DWindowControls: TMenuItem;
    SaveFreehandROISurface: TMenuItem;
    SaveLineScanImageAsBMP: TMenuItem;
    SaveLineScanPanel: TMenuItem;
    LineScanWindow: TMenuItem;
    CopyLineScanImage: TMenuItem;
    CopyLineScanPanel: TMenuItem;
    Copy3DWindow: TMenuItem;
    TimeHistograms: TMenuItem;
    CopyWindow: TMenuItem;
    ExportPlotAsPClampATF: TMenuItem;
    viewBleachingCorrection: TMenuItem;
    viewEventSites: TMenuItem;
    viewIntegrateWin: TMenuItem;
    ExportArea: TMenuItem;
    AreasOnly: TMenuItem;
    AreasROIXYandNrIntegrations: TMenuItem;
    viewKalmanStackFilter: TMenuItem;
    MenuPanel: TPanel;
    MenuToolBar: TToolBar;
    TimerToGetMemoryUsage: TTimer;
    lbMemUsage: TLabel;
    cbLoadFilesInRAM: TCheckBox;
    N12: TMenuItem;
    SaveProcessedMovieFiles: TMenuItem;
    lbFileLoadedInRAMsign: TLabel;
    SecondaryWindow: TMenuItem;
    MergeWindow: TMenuItem;
    mnMakeMoviefromMergeWindow: TMenuItem;
    SaveConsecutiveImagesfromMergeWindow: TMenuItem;
    SaveMergeWindow: TMenuItem;
    CopyMergeImage: TMenuItem;
    viewOrtogonalSections: TMenuItem;
    viewXorYProfile: TMenuItem;
    ubGetFileInfo: TUniButton;
    SaveSecondaryWindow: TMenuItem;
    CopySecondaryImage: TMenuItem;
    SpatialSpreadFile: TMenuItem;
    OpenSpatialSpreadFile: TMenuItem;
    SaveSpatialSpreadFile: TMenuItem;
    MeasuringLineFile: TMenuItem;
    OpenMeasuringLineFile: TMenuItem;
    SaveMeasuringLineFile: TMenuItem;
    MarkFile1: TMenuItem;
    OpenMarkFile: TMenuItem;
    SaveSmallEventsMarkFile: TMenuItem;
    SaveBigEventsMarkFile: TMenuItem;
    CopyAnyWindowInFocus: TMenuItem;
    RealLineScanWindow: TMenuItem;
    PrintMergeImage: TMenuItem;
    SaveConsecutiveImagesfrom2ndWindow: TMenuItem;
    procedure viewSpatialSpreadTableClick(Sender: TObject);
    procedure viewTimeSeriesAnalysisSlaveClick(Sender: TObject);
    procedure OpenWinBMPfileClick(Sender: TObject);
    procedure FilePrintItemClick(Sender: TObject);
    procedure OpenImageDialogGetInfo(Sender: TObject; ColIndex: Integer);
    procedure OpenImageDialogSelectTableFile(Sender: TObject;
      ColIndex: Integer);
    procedure OpenImageDialogShow(Sender: TObject);
    procedure OpenImageDialogSelectionChange(Sender: TObject);
    procedure OpenImageDialogFileAddToTable(Sender: TObject);
    procedure OpenImageDialogTypeChange(Sender: TObject);
    procedure OpenMovieOrImageClick(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FilePrintSetup(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FileMenuClick(Sender: TObject);
    procedure CloseImageFileClick(Sender: TObject);
    procedure viewEventAutoDetectionClick(Sender: TObject);
    procedure viewMainWindowClick(Sender: TObject);
    procedure viewAverageWindowClick(Sender: TObject);
    procedure viewImageControlClick(Sender: TObject);
    procedure viewTimeSeriesAnalysisClick(Sender: TObject);
    procedure viewSparkTableClick(Sender: TObject);
    procedure CaWavesTableClick(Sender: TObject);
    procedure OptionsClick(Sender: TObject);
    procedure GetHardDriveNrClick(Sender: TObject);
    procedure QueueFileTableClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ileHorizontal1Click(Sender: TObject);
    procedure ileVertical1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure ArrangeAll1Click(Sender: TObject);
    procedure PeaksTableClick(Sender: TObject);
    procedure CopyToClipBoard(Sender: TObject);
    procedure CopyToClipbordClick(Sender: TObject);
    procedure mnPreviousFileClick(Sender: TObject);
    procedure FileListClick(Sender: TObject);
    procedure ViewClick(Sender: TObject);
    procedure viewPlaybackWindowClick(Sender: TObject);
    procedure MovieCommentsTimersDialogClick(Sender: TObject);

    Procedure DisplayPreview(Const ImageWidth,ImageHeight : Integer;Const Pt : Pointer);
    Procedure SetDisplBufferForPreview(Const ImageWidth,ImageHeight : Word;
                                       Const DynBarr : TDynByteArray; Const DynWarr : TDynWordArray;
                                       Const NeedSwap : Boolean; Const BitsPerPixel : Word);
    Procedure DoPrintTimeSerPlot(Const PlotData : TDyn2DDoubleArr);

    procedure frmBMPdisplay_Close(Sender: TObject;  var Action: TCloseAction);
    procedure N3DWindowControlsClick(Sender: TObject);
    procedure LineScanWindowClick(Sender: TObject);
    procedure OpenMeasLineFile(Const MeasuringLineFileName : AnsiString);
    procedure OpenAnyMarkFile(MarkFileName : AnsiString);
    Procedure WriteMarkFile(Const MarkFileName : AnsiString; Const EvType : AnsiString;
                             Const MarkArrXY :TMarkArrXY; Const MarkAmpl : TDyn2DSingleArr;
                             Const MarkBase : TDyn2DSingleArr; Const MarkArrDur : TMarkArrDur;
                             Const MarkRiseTime : TDyn2DSingleArr;
                             Const Comment : AnsiString; Const WriteEvents : Boolean);

    function GetSystemDriveLetter : Char;
    procedure TimeHistogramsClick(Sender: TObject);
    procedure CopyWindowClick(Sender: TObject);
    Procedure SavePlotAsPClampATF(const SaveFName : AnsiString);
    procedure viewBleachingCorrectionClick(Sender: TObject);
    procedure viewEventSitesClick(Sender: TObject);
    procedure viewIntegrateWinClick(Sender: TObject);
    procedure viewKalmanStackFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerToGetMemoryUsageTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cbLoadFilesInRAMClick(Sender: TObject);
    procedure SaveProcessedMovieFilesClick(Sender: TObject);
    procedure SaveCollectionOfMultiImageTiffsClick(Sender: TObject);
    procedure SecondaryWindowClick(Sender: TObject);
    procedure MergeWindowClick(Sender: TObject);
    procedure viewOrtogonalSectionsClick(Sender: TObject);
    procedure viewXorYProfileClick(Sender: TObject);
    procedure ubGetFileInfoClick(Sender: TObject);
    procedure RealLineScanWindowClick(Sender: TObject);
    procedure OpenImageDialogCheckBoxClick(Sender: TObject);
     private
    { Private declarations }

    public
    { Public declarations }

      Function GetFilterSize : AnsiString;
      Procedure ExportAreaFileAsTxT(const SaveFName : AnsiString; Sender: TObject);
      Procedure OpenSparkAnParameters(Sender : TObject);

  end;


var
  MainForm            : TMainForm;

  TempMultiImageTIFF  : Boolean;
  MultiImageTIFF      : Boolean;
  frmBMPdisplay       : TForm;
  ImageWidthTable     : LongInt;  { X & Y of First Andor Tiff  selected in table}
  ImageHeightTable    : LongInt;
  NrPagesPrev         : LongWord;
  NrChannels1stFile   : Integer;
  BitsPerPixelTable   : Word;     { BitsPerPixel of First Andor Tiff  selected in table}
  NrDimensionsTable   : LongInt;  { NrDimensions of First Andor Tiff  selected in table}
  CollFileLoaded      : Boolean;  {True if Files from Collection were Loaded in FileTable of OpenImageDialog}
  {added manually}
  function LoadCollFileList(Const CollFileName : AnsiString) : Boolean;



IMPLEMENTATION
{$r *.dfm}


  Uses unTimeSerAnal, unMainWindow, unImageControl,
  unAverIm, unSPautoSearch, unSparkTable, unWaveTable, unOKDlgNrImToExp,
  unOptionsPageDlg, unQueueFiles, unFileComment, About, unPeaks, unHelp,
  unFileList, unPlayBack, MovieLabels, unProgress,Consts,
  unAndorImageDescr, unSlaveTSPlot, unSpatialSpread, un3DImageWin,
  un3DImageContr, unSurfaceROI, unLineScan,unHistogram,unCopyWindow,
  unEventSites,unCorrectForBleaching,unIntegrate,unKalmanStackFilter,unFunctions,
  un2ndWin, unMergeWindow,ImageFilesOpeningRoutines, OrthogonalSectioning,
  unXYprofile, unRealLineScan;

procedure TMainForm.OpenWinBMPfileClick(Sender: TObject);

 var i      : integer;

begin

With OpenImageDialog Do Begin

  OpenImageDialog.Tag := 1; // 0 is for all movie files; if to Open BMP then Tag = 1
  FileName := '';

  if (UseMoviFilePath = False) and (FilePaths.WindowsBMPPath <> '') then
    OpenImageDialog.InitialDir := FilePaths.WindowsBMPPath
  else
  if (UseMoviFilePath = True) or (FilePaths.WindowsBMPPath = '') then begin
    if  ImFname    <> '' then InitialDir := ExtractFileDir(ImFname) else
    if (ImFname  = '') and (PrevImFileName <> '') then
    OpenImageDialog.InitialDir := ExtractFileDir(PrevImFileName);
  end;


  Filter := 'Windows Bitmap (*.bmp)|*.bmp';

  Title := 'Open Windows Bitmap File';
  {--- End of Title and Filter assign -----------}



  If  (OpenImageDialog.Execute) then begin
    {------------------------------------------------------------------------------}
    If OpenImageDialog.ValidFile Then Begin
    {------------------------------------------------------------------------------}
      FilePaths.WindowsBMPPath := ExtractFileDir(FileName);


      If frmBMPdisplay = nil then Begin
        frmBMPdisplay := TForm.Create(Application);
        {
        nil - specifies that no object owns the form - and therefore a developer (you)
        is responsible for freeing the created form (by calling myForm.Free when you no longer need the form)
        Self - specifies the object in which the method is called. If, for example, you are creating
        a new instance of a TMyForm form from inside a Button's OnClick handler
        (where this button is placed on a MainForm) - self refers to "MainForm".
        Thus, when the MainForm is freed - it will also free "MyForm".
        Application - specifies a global TApplication type variable created when you run your application.
         "Application" encapsulates your application as well as providing many functions that occur in
         the background of the program.//the Global TApplication will be resposible to be destroyed;
        }
        with frmBMPdisplay do begin
          BorderStyle := bsSizeable;
          BorderIcons := [biSystemMenu,biMinimize];
          Position := poScreenCenter;
          FormStyle := fsMDIChild;
          OnClose := frmBMPdisplay_Close;
          DoubleBuffered := True;
          with TImage.Create(frmBMPdisplay) do begin
            Name := 'Image';
            Align := alClient;
            Stretch := True;
            Proportional := True;
            Center := True;
            Picture.LoadFromFile(OpenImageDialog.FileName);
            Parent := frmBMPdisplay;
            frmBMPdisplay.ClientWidth := Picture.Width;
            frmBMPdisplay.ClientHeight := Picture.Height;
          end; //with TImage.Create(frmBMPdisplay)
        end; //with frmBMPdisplay do begin
      End Else //if frmBMPdisplay = nil

      with frmBMPdisplay do begin
        for i := 0 to ComponentCount-1 do begin
          if (Components[i] is TImage) then with Components[i] as TImage do begin
            Picture.LoadFromFile(OpenImageDialog.FileName);
            frmBMPdisplay.ClientWidth := Picture.Width;
            frmBMPdisplay.ClientHeight := Picture.Height;
            Break;
          end; //if (Components[i] is TImage) then with Components[i] as TImage
        end; //for i := 0 to ComponentCount-1
      end; //with frmBMPdisplay do begin

      frmBMPdisplay.Caption := ExtractFileName(OpenImageDialog.FileName);


    {------------------------------------------------------------------------------}
   End; //If OpenImageDialog.ValidFile
    {------------------------------------------------------------------------------}

  End;  //If  (OpenImageDialog.Execute) then begin
  
  OpenImageDialog.Tag := 0; //resets to Zero  0 is for all movie files; if to Open BMP then Tag = 1

End; //With OpenImageDialog

End;  //procedure TMainForm.OpenWinBMPfileClick
{------------------------------------------------------------------------------------}

procedure TMainForm.frmBMPdisplay_Close(Sender: TObject;  var Action: TCloseAction);
begin     
    Action          := caFree;
    frmBMPdisplay    := nil;
end;
{------------------------------------------------------------------------------------}


Procedure TMainForm.OpenMovieOrImageClick(Sender: TObject);
Var
 TempPrevImFile       : AnsiString;
 TempPrevImFindex     : Byte;
 ValidFile            : Boolean;
 Cnt                  : integer;
 OpenAsFileCollection : Boolean;

{-- First Assigns the Title and Filters of  OpenFileDialog}

Begin
  frmPlayback.Stop.Down := True;
  frmPlayback.StopClick(Sender);
  if (frm3DImageContr <> nil) then begin
    if (frm3DImageContr.bt3DOn.Down) then begin
      frm3DImageContr.bt3DOn.Down := False;
      frm3DImageContr.bt3DOnClick(Sender);
    end;
  end;

  Application.ProcessMessages;

With OpenImageDialog Do Begin

  OpenImageDialog.Tag := 0; // 0 is for all movie files; if to Open BMP then Tag = 1
  OpenImageDialog.ValidFile := False; //ValidFile is Tested by OpenImageDialogSelectionChange

  if  (ImFname <> '') then Begin //Tries to go Directory where a File has been Open
    InitialDir  := ExtractFileDir(ImFname);
    FilterIndex := ImTypeIndex;   //ImTypeIndex stores OpenImageDialog.FilterIndex
  end else
  if (ImFname  = '') and (PrevImFileName <> '') then begin //otherwise to Previous File Open
    InitialDir  := ExtractFileDir(PrevImFileName);
    FilterIndex := PrevFilePar.FilterIndex;
  end;

  Filter :=

 'Grayscale Tiff (*.tif)|*.tif' +
 '|Stack of Grayscale Tiffs (*.tif)|*.tif' +
 '|BioRad (*.pic)|*.pic' +
 '|Noran (Prairie Technologies) (*.xml,*Main.pcf)|*.xml;*Main.pcf' +
 '|StreamPix (*.seq)|*.seq' +
 '|Collection of Andor Multiimage Tiffs (*.col)|*.col' +
 '|QED (*ImgMgr*)|*ImgMgr*' +
 '|Noran (SGI) (*.*)|*.*' +
 '|Zeiss (*.czi,*.lsm)|*.czi;*.lsm' +
 '|Nikon (*.nd2)|*.nd2';


  FileName := '';

  if FilterIndex = SINGLE_TIFF_INDEX then
    Title := 'Open Single Grayscale Tiff File' else
  if FilterIndex = STACK_TIFF_INDEX then
    Title := 'Open Stack of Grayscale Tiff Files - Select First File to Open All' else
  if FilterIndex = BIORAD_PIC_INDEX then
    Title := 'Open BioRad (pic) Movie'else
  if FilterIndex = NORAN_PRARIE_INDEX then
    Title := 'Open Noran (Prairie) Movie ("*.xml or "_Main.pcf" User Log file)' else
  if FilterIndex = StreamPix_INDEX then
    Title := 'Open StreamPix Movie' else
  if FilterIndex = COLLECTION_INDEX then
    Title := 'Open Collection of Andor Multiimage Tiffs' else
  if FilterIndex = QED_INDEX then
    Title := 'Open Solamere (QED) Movie (Image Manager)' else
  if FilterIndex = NORAN_SGI_INDEX then
    Title := 'Open Noran (SGI) Movie'else
  if FilterIndex = ZEISS_CZI_LSM_INDEX then
    Title := 'Open Zeiss (*.czi or *.lsm) Movie' else
  if FilterIndex = NIKON_ND2_INDEX then
    Title := 'Open Nikon NIS Elements (*.nd2) Movie';

End; //With OpenImageDialog

{--- End of Title and Filter assign -----------}
   OpenImageDialog.LoadChAsIndivFiles := cbLoadChAsIndivFilesState;

If  (OpenImageDialog.Execute) Then Begin
    {Sender could be different, OpenImageDialog.Execute Executes when Press OK button

  {OpenImageDialog has Already Checked if FileName is Valid = Exists and <> ''}

     MainForm.Repaint;
     Application.ProcessMessages;
    {Enforces Erase of OpenFile Dialog if File is too Long}

  If (OpenImageDialog.ValidFile) then Begin

   If (Sender = OpenMovieOrImage) then Begin

    If (OpenImageDialog.TableFileList.Count > 0) then begin
      SetLength(CollFileNames,OpenImageDialog.TableFileList.Count);
      for Cnt := 0 to OpenImageDialog.TableFileList.Count - 1 do begin
        CollFileNames[Cnt] := OpenImageDialog.TableFileList.Strings[Cnt];
      end;
      if (OpenImageDialog.FilterIndex = SINGLE_TIFF_INDEX) then begin
        OpenAsFileCollection := True;
        LoadChAsIndivFiles := OpenImageDialog.LoadChAsIndivFiles;
        if (LoadChAsIndivFiles) and (Length(CollFileNames) mod 2 <> 0) then
        LoadChAsIndivFiles := False;
      end
        else
      begin
        OpenAsFileCollection := False;
        LoadChAsIndivFiles := False;
      end;
    End
        Else
    Begin
      OpenAsFileCollection := False;
      LoadChAsIndivFiles := False;
    End;

    If (ImFname <> '') then Begin
      if Not(OpenAsFileCollection) then PrevImFileName   := ImFname else
      if    (OpenAsFileCollection) then PrevImFileName   := CollFileNames[0];
      PrevFilePar.FilterIndex    := ImTypeIndex;
      PrevFilePar.MultiImageTIFF := MultiImageTIFF;
    End;

    MultiImageTIFF := TempMultiImageTIFF;  {memorizes}
    ImTypeIndex := OpenImageDialog.FilterIndex; {memorizes Index}

    cbLoadChAsIndivFilesState := OpenImageDialog.LoadChAsIndivFiles;

    OpenImageFile(OpenImageDialog.FileName,ImTypeIndex,OpenAsFileCollection,False);
    //ImFname is Set by OpenImageFile

   End;

  End;//If (OpenImageDialog.ValidFile) then Begin

End;  // If  (OpenFileDialog.Execute = True) and (sender = FileOpenMovie)

End;

{****************************************************************************}

procedure TMainForm.OpenImageDialogShow(Sender: TObject);
begin
    If (OpenImageDialog.Tag = 0) Then CollFileLoaded := False;
End;

{****************************************************************************}

procedure TMainForm.OpenImageDialogCheckBoxClick(Sender: TObject);
{gives event Only when Check box for "Open Channels as Individual Files" is Checked }
var Cnt : Integer;
NrPages,PrevNrPages : LongWord;
NrDimensions,CreatTimeInSec : Longint;
DescrStr : AnsiString;
IncompatibleArr : TDynIntArray;
Incompatible : Boolean;


Begin

  With OpenImageDialog do Begin
    If (TableFileList.Count > 1) and (TableFileList.Count mod 2 <> 0) then begin
      OpenImageDialog.CheckBox.Checked := False;
      MessageDlg('Number of Files Must be Even',mtError,[mbOK],0);

    End

      Else

    If (TableFileList.Count > 1) and (TableFileList.Count mod 2 = 0) then begin
      SetLength(IncompatibleArr,TableFileList.Count);
      for Cnt := 0 to High(IncompatibleArr) do IncompatibleArr[Cnt] := 0;

      For Cnt := 0 to TableFileList.Count - 1 Do Begin


        GetAndorTIFFNrPagesOrImageDescr(OpenImageDialog.TableFileList[Cnt],DescrStr,CreatTimeInSec,
                                        NrPages,NrDimensions,GET_ANDOR_NR_PAGES);

        If (Cnt = 0) then PrevNrPages := NrPages

          Else

        Begin

          if (Cnt mod 2 <> 0) then begin
            if (PrevNrPages <> NrPages) then IncompatibleArr[Cnt] := 1;
          end
            else
          if (Cnt mod 2 = 0) then begin
            PrevNrPages := NrPages;
          end;
        End;

      End;  // For Cnt := 0 to TableFileList.Count - 1 Do Begin

      Incompatible := False;
      for Cnt := 1 to High(IncompatibleArr) do begin
        if IncompatibleArr[Cnt] = 1 then begin
          Incompatible := True;
        end;
      end;

      if (Incompatible) then begin
        DescrStr := 'Number of Images in File Pairs Must be the Same.  The following File Pairs have Different Number of Images: ';
        for Cnt := 1 to High(IncompatibleArr) do begin
          if IncompatibleArr[Cnt] = 1 then
            DescrStr := DescrStr + IntToStr(Cnt) + ' && ' + IntToStr(Cnt+1);
        end;
        OpenImageDialog.CheckBox.Checked := False;
         MessageDlg(DescrStr,mtError,[mbOK],0);
      end;

    End; //If (TableFileList.Count > 1) and (TableFileList.Count mod 2 = 0) then begin


  End; //With

End;

{****************************************************************************}

procedure TMainForm.OpenImageDialogFileAddToTable(Sender: TObject);

var

  ImageWidth    : Word;
  ImageHeight   : Word;
  BitsPerPixel  : Word;
  TIFF_Type     : Byte;
  NrPages       : LongWord;
  ValidFile     : boolean;
  NrDimensions  : LongInt;
  NrChannelsInFile : Integer;
  LoadChAsIndivFilesCompatible : Boolean;

Begin

    GetAndorTIFFBasicInfo(OpenImageDialog.FileName,ImageWidth,ImageHeight,
                          NrDimensions,NrPages,BitsPerPixel,TIFF_Type, NrChannelsInFile, ValidFile);


 With OpenImageDialog.TableFileList Do Begin

  If (Count = 0) or (not(OpenImageDialog.LoadChAsIndivFiles)) then LoadChAsIndivFilesCompatible := True
    Else

  If (OpenImageDialog.LoadChAsIndivFiles) and (Count > 0) then begin
    if (Count mod 2 <> 0) then begin
      if (NrPagesPrev = NrPages) then
        LoadChAsIndivFilesCompatible := True
          else
        LoadChAsIndivFilesCompatible := False;
    end
      else
    if (Count mod 2 = 0) then begin
      NrPagesPrev := NrPages;
      LoadChAsIndivFilesCompatible := True;
    end;
  End;

  If (TIFF_Type = TIFF_ANDOR_iQ) and (NrPages > 1) And
     ((OpenImageDialog.TableFileList.Count = 0) or
      ((OpenImageDialog.TableFileList.Count > 0) and
      ((ImageWidthTable = ImageWidth) and (ImageHeightTable = ImageHeight) and
       (BitsPerPixelTable = BitsPerPixel) and (NrDimensionsTable = NrDimensions) and
       (NrChannels1stFile = NrChannelsInFile) and
       (LoadChAsIndivFilesCompatible))))
  then Begin
    if (OpenImageDialog.TableFileList.Count = 0) then begin
       ImageWidthTable   := ImageWidth;
       ImageHeightTable  := ImageHeight;
       BitsPerPixelTable := BitsPerPixel;
       NrDimensionsTable := NrDimensions;
       NrChannels1stFile := NrChannelsInFile;
       if (OpenImageDialog.LoadChAsIndivFiles) then NrPagesPrev := NrPages;
    end;
    OpenImageDialog.ValidFile := True;
  End

    Else

  Begin
    OpenImageDialog.ValidFile := False;

    if (TIFF_Type <> TIFF_ANDOR_iQ) then begin
      MessageDlg('This is not Andor tiff file',mtError,[mbOK],0);
    end else

    if (TIFF_Type = TIFF_ANDOR_iQ) and (NrChannels1stFile <> NrChannelsInFile) then begin
      if (NrChannels1stFile = 1) then
        MessageDlg('This Andor tiff file is incompatible because it has Two channels while the previous have One channel',mtError,[mbOK],0) else
      if (NrChannels1stFile = 2) then
        MessageDlg('This Andor tiff file is incompatible because it has One channel while the previous have Two channels',mtError,[mbOK],0)
    end else

    if (TIFF_Type = TIFF_ANDOR_iQ) and (NrPages = 1) then begin
      MessageDlg('This Andor tiff file has one image only. This option is for multi-image tiffs only.',mtError,[mbOK],0);
    end else

    if (TIFF_Type = TIFF_ANDOR_iQ) and (NrPages > 1) then begin

      if not(LoadChAsIndivFilesCompatible) then begin
      MessageDlg('This Andor tiff file has diferent number of images compared to the previous one.  ' +
      'Same number of images for a pairs of files for each channel is required for "Open channels as individual files"  ' +
      'The required order is: Ch1 - File #1, Ch2 - File #2, Ch1 -File #3, Ch2 - File #4,... Ch1 - File #n, Ch2 - File #n+1' ,mtError,[mbOK],0);
      end else

      if (NrDimensionsTable <> NrDimensions) then begin
      MessageDlg('This Andor tiff file has diferent number dimensions compared to the previous one' ,mtError,[mbOK],0);
      end else

      if (BitsPerPixelTable <> BitsPerPixel) then begin
      MessageDlg('This Andor tiff file is ' + IntToStr(BitsPerPixel) +
      ' bit, while the previous is ' + IntToStr(BitsPerPixelTable) + ' bit',mtError,[mbOK],0);
      end else

      if (BitsPerPixelTable = BitsPerPixel) and (NrDimensionsTable = NrDimensions) then begin
        if (OpenImageDialog.TableFileList.Count > 0) and
       ((ImageWidthTable <> ImageWidth) or (ImageHeightTable <> ImageHeight))
        then Begin
        if (ImageWidthTable <> ImageWidth) and (ImageHeightTable <> ImageHeight) then
          MessageDlg('This Andor tiff file has different X and Y image sizes',mtError,[mbOK],0) else
        if (ImageWidthTable <> ImageWidth) and (ImageHeightTable = ImageHeight) then
          MessageDlg('This Andor tiff file has different X image size',mtError,[mbOK],0) else
        if (ImageWidthTable = ImageWidth) and (ImageHeightTable <> ImageHeight) then
          MessageDlg('This Andor tiff file has different Y image size',mtError,[mbOK],0);
        end; //Different X or Y image size
       end; //if (BitsPerPixelTable = BitsPerPixel)

    end; //if (TIFF_Type = TIFF_ANDOR) and (NrPages > 1)
    
  End; {not valid file}
 End; //With OpenImageDialog.TableFileList Do Begin

End; //procedure TMainForm.OpenImageDialogFileAddToTable


procedure TMainForm.OpenImageDialogGetInfo(Sender: TObject; ColIndex: Integer);
 var
  AndorTIFFDescr : AnsiString;
  CreatTimeInSec : LongInt;
  NrPages        : LongWord;
  NrDimensions   : LongInt; 
begin

 If (OpenImageDialog.Tag = 0) Then Begin

  If FileExists(OpenImageDialog.TableFileList[ColIndex-1]) Then Begin
    if (frmAndorImageDescr = nil) then Application.CreateForm(TfrmAndorImageDescr,frmAndorImageDescr)
    else begin
      frmAndorImageDescr.WindowState := wsNormal;
      frmAndorImageDescr.MemoDescr.Clear;
    end;

    GetAndorTIFFNrPagesOrImageDescr(OpenImageDialog.TableFileList[ColIndex-1], AndorTIFFDescr,
                                    CreatTimeInSec, NrPages, NrDimensions,GET_ANDOR_IMAGE_DESCR);  
    with frmAndorImageDescr.MemoDescr do begin
      Lines.Add(AndorTIFFDescr);
      SelStart := 0; //Carret goes to First Letter
      Perform(WM_VSCROLL, SB_TOP,0);  //goes to First Line  //Have to Use Win32 API
    end;
  End Else
  MessageDlg('File Does Not Exist',mtError,[mbOK],0);

 End; //If (OpenImageDialog.Tag := 0)
 
End; //procedure TMainForm.OpenImageDialogGetInfo


procedure TMainForm.OpenImageDialogTypeChange(Sender: TObject);
  var DialogCaption : AnsiString;
Begin

With OpenImageDialog Do Begin


 {clears FileTable Only if Collection files were loaded}
 if (CollFileLoaded) then begin
  FileTableTitle := 'Click to Add File';
  ResetFileTable;
  TableFileList.Clear;
  CollFileLoaded := False;
 end;


  if FilterIndex = SINGLE_TIFF_INDEX then
    DialogCaption := 'Open Single Grayscale Tiff File' else
  if FilterIndex = STACK_TIFF_INDEX then
    DialogCaption := 'Open Stack of Grayscale Tiff Files - Select First File to Open All' else
  if FilterIndex = BIORAD_PIC_INDEX then
    DialogCaption := 'Open BioRad (pic) Movie'else
  if FilterIndex = NORAN_PRARIE_INDEX then
    DialogCaption := 'Open Noran (Prairie) Movie ("*.xml or "_Main.pcf" User Log file)' else
  if FilterIndex = StreamPix_INDEX then
    DialogCaption := 'Open StreamPix Movie' else
  if FilterIndex = COLLECTION_INDEX then
    DialogCaption := 'Open Collection of Andor Multiimage Tiffs' else
  if FilterIndex = QED_INDEX then
    DialogCaption := 'Open Solamere (QED) Movie (Image Manager)' else
  if FilterIndex = NORAN_SGI_INDEX then
    DialogCaption := 'Open Noran (SGI) Movie'else
  if FilterIndex = ZEISS_CZI_LSM_INDEX then
    DialogCaption := 'Open Zeiss (*czi or *.lsm) Movie'else
  if FilterIndex = NIKON_ND2_INDEX then
    DialogCaption := 'Open Nikon NIS Elements (*.nd2) Movie';

End;// With OpenImageDialog

   SetWindowText(GetParent(OpenImageDialog.Handle), PAnsiChar(DialogCaption)); //changes Dialog Caption
  {OpenImageDialog.Title := 'Text';  does not work when Dialog is open}

End; {procedure TMainForm.OpenImageDialogTypeChange}



procedure TMainForm.OpenImageDialogSelectTableFile(Sender: TObject; ColIndex: Integer);

 Var
  ImageWidth    : Word;
  ImageHeight   : Word;
  BitsPerPixel  : Word;
  DynBarr       : TDynByteArray;
  DynWarr       : TDynWordArray;
  ValidFile     : Boolean;
  NeedSwap      : Boolean;

Begin
 If (OpenImageDialog.AllowPreview) then
  If FileExists(OpenImageDialog.TableFileList[ColIndex-1]) Then Begin

      GetTIFFfile_Preview(OpenImageDialog.TableFileList[ColIndex-1],ImageWidth,ImageHeight,
                          BitsPerPixel,DynBarr,DynWarr,NeedSwap,ValidFile,TempMultiImageTIFF);

   {------------------------------------------------------------------------------}
    OpenImageDialog.ValidFile := ValidFile; {needed to tell OpenDialog to print Image size}
   {------------------------------------------------------------------------------}

    If (ValidFile) Then Begin
       SetDisplBufferForPreview(ImageWidth,ImageHeight,DynBarr,DynWarr, NeedSwap ,BitsPerPixel);
    End; //if ValidFile  
  End Else //If FileExists
  MessageDlg('File Does Not Exist',mtError,[mbOK],0);
End;

function LoadCollFileList(Const CollFileName : AnsiString) : Boolean;
Var
    ReadStr             : AnsiString;
    FilePath            : AnsiString;
    CollFileHandle      : THandle;
    FPos,FPosMem        : UInt64;
    pRead               : Pointer;
    NrOfColFiles        : Word;
    OffsetToSect        : LongInt;
    OffsetToVar         : LongInt;
    StrLen              : LongInt;
    Cnt                 : Integer;
    VersOffset          : Integer;


Begin


  CollFileHandle := FileOpen(CollFileName,fmOpenRead or fmShareDenyNone);

  SetLength(ReadStr,28);
  pRead := @ReadStr[1];
  FPos := 0;
  FileSeek(CollFileHandle,FPos,0);
  FileRead(CollFileHandle,pRead^,Length(ReadStr));

  If (ReadStr = 'SparkAn Collection File v.1 ') or
     (ReadStr = 'SparkAn Collection File v.2 ') or
     (ReadStr = 'SparkAn Collection File v.3 ') or
     (ReadStr = 'SparkAn Collection File v.4 ') Then Begin

    Result := True;

    if (ReadStr = 'SparkAn Collection File v.1 ') then VersOffset := 0 else
                                                       VersOffset := 100; //v.4 from Oct 2016

    FilePath := ExtractFilePath(CollFileName);

    {1st. Get Number of Files}
    FPos      := 28; //Length(FileHeader) = 28 but I leave 2 more bytes
    FileSeek(CollFileHandle,FPos,0);  {0 = Origin = Begining of File}
    FileRead(CollFileHandle,NrOfColFiles,SizeOf(Word));

    {2nd. Get File Names (with full path)}
    //Gets Offset to FileNames Section and checks if they exist//
    With MainForm.OpenImageDialog do begin

    //otherwise if before it sets to True after With MainForm.OpenImageDialog finishes
    FPos := 60 + VersOffset;
    FileSeek(CollFileHandle,FPos,0);  {0 = Origin = Begining of File}
    FileRead(CollFileHandle,OffsetToSect,SizeOf(LongInt));

    FPos := OffsetToSect;
    For Cnt := 0 to NrOfColFiles-1 do Begin
      FileSeek(CollFileHandle,FPos,0);
      FileRead(CollFileHandle,OffsetToVar,SizeOf(LongInt));

      FPos := FPos + SizeOf(OffsetToVar);
      FileSeek(CollFileHandle,FPos,0);
      FileRead(CollFileHandle,StrLen,SizeOf(StrLen));
      FPos := FPos + SizeOf(StrLen);

      FPosMem := FPos;
      SetLength(ReadStr,StrLen);
      pRead := @ReadStr[1];
      FPos  := OffsetToVar;
      FileSeek(CollFileHandle,FPos,0);
      FileRead(CollFileHandle,pRead^,StrLen);
      if not(FileExists(FilePath + ReadStr)) then begin
        MessageDlg('File ' +  ReadStr + ' is Missing.',mtError,[mbOK],0);
        Result := False;
        Break;
      end;
      TableFileList.Add(FilePath + ReadStr);
      FPos := FPosMem;
    End;

   End; //with MainForm.OpenImageDialog
   
  End  //If ReadStr = 'SparkAn Collection File

  Else
  Begin
    Result := False;
    MessageDlg('This is Not Collection File.',mtError,[mbOK],0);
  End;

End;


Procedure TMainForm.OpenImageDialogSelectionChange(Sender: TObject);

{Activated by selection of a file - Does the Preview when a File is Selected}
{Returnts Valid file !!!; This is the Checkpoint of the Program}

 Var

  ImageWidth   : Word;
  ImageHeight  : Word;
  BitsPerPixel : Word; //8 or 16
  DynBarr      : TDynByteArray;
  DynWarr      : TDynWordArray;
  ValidFile    : Boolean;
  NeedSwap     : Boolean;
  SearchRec    : TSearchRec;
  FExt         : AnsiString;

Begin

 If (OpenImageDialog.Tag = 0) Then Begin

  {Loads Collection File in the OpenImageDialog.TableFileList No Matter if AllowPreview}
  If (OpenImageDialog.FilterIndex = COLLECTION_INDEX) Then Begin
     MainForm.OpenImageDialog.TableFileList.Clear;
     //LoadCollFileList has to be Function to Properly check ValidFile
     ValidFile := LoadCollFileList(OpenImageDialog.FileName);
     if (ValidFile) then begin
      OpenImageDialog.FileTableTitle := 'Click On File Name to Preview';
      OpenImageDialog.LoadFileTable;
      CollFileLoaded := True;
     end;
  End;

 End; //If (OpenImageDialog.Tag = 0) Then Begin

 If (OpenImageDialog.Tag = 0) Then Begin

    If (OpenImageDialog.FilterIndex in [QED_INDEX,NORAN_PRARIE_INDEX]) Then Begin
      ValidFile := True;
      if (OpenImageDialog.FilterIndex = QED_INDEX) then Begin
        ValidFile := IsImgMgrFile(OpenImageDialog.FileName);
        if not(ValidFile) then MessageDlg('This is Not a ImgMgr file', mtError, [mbOK], 0);
      End;
      //So far I do not check Noran XML ot PCF files - chance to be false one is very small//

      if (ValidFile) then begin
        //Assumes that all the Tiff files in the Folder belong to Same Movie (Noran XML or PCF flie)
        if (FindFirst(ExtractFilePath(OpenImageDialog.FileName)+'*.tif',faAnyFile, SearchRec) = 0)
        then
        GetTIFFfile_Preview(ExtractFilePath(OpenImageDialog.FileName)+SearchRec.Name,ImageWidth,ImageHeight,
                          BitsPerPixel,DynBarr,DynWarr,NeedSwap,ValidFile,TempMultiImageTIFF)
        else begin
          ValidFile := False;
          MessageDlg('No Tiff Files Have Been Found',mtError,[mbOK],0);
        end;
        FindClose(SearchRec); //free resourses
      end;
    End

      Else

     {Gets File Info and Fills Arrays}
    If (OpenImageDialog.FilterIndex in [SINGLE_TIFF_INDEX,STACK_TIFF_INDEX]) Then Begin
      {Zeiss LSM files are actually TIFF.  To look at the 1st image GetTIFFfile_Preview works fine}
      GetTIFFfile_Preview(OpenImageDialog.FileName,ImageWidth,ImageHeight,
                          BitsPerPixel,DynBarr,DynWarr,NeedSwap,ValidFile,TempMultiImageTIFF);

      if (OpenImageDialog.FilterIndex = STACK_TIFF_INDEX) and (TempMultiImageTIFF) then begin
         ValidFile := not(TempMultiImageTIFF);
         MessageDlg('This Option Works with stack of single image TIFFs Only', mtInformation,[mbOK], 0);
      end;

    End Else

    If (OpenImageDialog.FilterIndex = ZEISS_CZI_LSM_INDEX) Then Begin
      FExt := (ExtractFileExt(OpenImageDialog.FileName));

      if (FExt = '.lsm') then

      {Zeiss LSM files are actually TIFF.  To look at the 1st image GetTIFFfile_Preview works fine}
        GetLSMfile_Preview(OpenImageDialog.FileName,ImageWidth,ImageHeight,
                           BitsPerPixel,DynBarr,DynWarr,ValidFile)
        else

      if (FExt = '.czi') then
        GetCZIfile_Preview(OpenImageDialog.FileName,ImageWidth,ImageHeight,
                           BitsPerPixel,DynBarr,DynWarr,ValidFile);

       NeedSwap := False;

    End Else

    If (OpenImageDialog.FilterIndex = COLLECTION_INDEX) and (ValidFile) then Begin
      
      GetTIFFfile_Preview(OpenImageDialog.TableFileList[0],ImageWidth,ImageHeight,
                          BitsPerPixel,DynBarr,DynWarr,NeedSwap,ValidFile,TempMultiImageTIFF);

    End Else
    If (OpenImageDialog.FilterIndex = BIORAD_PIC_INDEX) Then Begin
      GetBioRadPicFile_Preview(OpenImageDialog.FileName,ImageWidth, ImageHeight,
                              BitsPerPixel,DynBarr,DynWarr,ValidFile);
      if (ValidFile) then NeedSwap := False
      else
      MessageDlg('This is Not BioRad "PIC" File', mtError, [mbOK], 0);
    End Else
    If (OpenImageDialog.FilterIndex = StreamPix_INDEX) Then Begin
      GetStreamPixFile_Preview(OpenImageDialog.FileName,ImageWidth, ImageHeight,
                               BitsPerPixel,DynBarr,DynWarr,ValidFile);

      NeedSwap := False;
    End Else
    If (OpenImageDialog.FilterIndex = NORAN_SGI_INDEX) Then Begin
      GetSGIfile_Preview(OpenImageDialog.FileName,DynBarr,ImageWidth,ImageHeight,ValidFile);
      BitsPerPixel := 8;
    End Else
    If (OpenImageDialog.FilterIndex = NIKON_ND2_INDEX) Then Begin
      GetND2fileInfo_Preview(OpenImageDialog.FileName,ImageWidth,ImageHeight,
                             BitsPerPixel,DynBarr,DynWarr,ValidFile);
      NeedSwap := False;
    End;

    {------------------------------------------------------------------------------}
    OpenImageDialog.ValidFile := ValidFile; {needed to tell OpenDialog to print Image size}
   {------------------------------------------------------------------------------}

   {----------------------- Dispalys Image  --------------------------------------}

    If (ValidFile) and (OpenImageDialog.AllowPreview) then Begin
       SetDisplBufferForPreview(ImageWidth,ImageHeight,DynBarr,DynWarr, NeedSwap ,BitsPerPixel);
    End; //if ValidFile
  End // If (OpenImageDialog.Tag = 0) Then Begin

    Else

  If (OpenImageDialog.Tag = 1) and (OpenImageDialog.AllowPreview) Then Begin //Only BMP files
    OpenImageDialog.ValidFile := True; {needed to tell OpenDialog to print Image size}
   {------------------------------------------------------------------------------}
    OpenImageDialog.ImagePreview.Picture.LoadFromFile(OpenImageDialog.FileName);
    OpenImageDialog.ImagePreview.Repaint;
  End;
End;


procedure TMainForm.SetDisplBufferForPreview(Const ImageWidth,ImageHeight : Word;
                                             Const DynBarr : TDynByteArray; Const DynWarr : TDynWordArray;
                                             Const NeedSwap : Boolean; Const BitsPerPixel     : Word);
 Var
  Cnt           : Integer;
  J             : Integer;
  imLen         : Integer;
  DisplayArray  : TDynByteArray;
  LenDispArr    : LongWord;
  Pt            : Pointer;
  PixMin,PixVal : Integer;
  ScaleFactor   : Double;
  ImPadding     : Byte;
 Begin
  {preparing Image for Display}

      {Sets Padding}
      If ImageWidth Mod 4 = 0 then ImPadding := 0 else
                                   ImPadding := 4 - (ImageWidth Mod 4);
      If ImPadding = 0 then Begin
        LenDispArr := ImageWidth*ImageHeight;
      End else
      If ImPadding <> 0 then Begin
        LenDispArr := (ImageWidth + ImPadding)*ImageHeight;
        ImPadding  := ImPadding + 1;
      End;

      if (BitsPerPixel = 16) or (ImPadding <> 0) then SetLength(DisplayArray,LenDispArr);

      {prepares DisplayArray}
      If (BitsPerPixel = 16) Then begin
        if (NeedSwap) then for Cnt := 0 to High(DynWarr) do DynWarr[Cnt] := swap(DynWarr[Cnt]);
        {Scales Image to 8 bit}
        PixMin := 65536; {max of Word}
        PixVal := 0;   {PixVal here is used as Pixel Maximum}
        {finds Min and Max Values}
        for Cnt := 0 to High(DynWarr) do begin
          if PixMin > DynWarr[Cnt] then PixMin := DynWarr[Cnt];
          if PixVal < DynWarr[Cnt] then PixVal := DynWarr[Cnt];
        end;
        ScaleFactor := (PixVal - PixMin)/255;
        If (ImPadding = 0) Then Begin
          for Cnt := 0 to High(DynWarr) do begin
            if DynWarr[Cnt] > PixMin then {PixVal here is used as to just get value}
              PixVal := round((DynWarr[Cnt] - PixMin)/ScaleFactor)
            else PixVal := 0;
            if PixVal > 255 then PixVal := 255;
            DisplayArray[Cnt] := PixVal;
          end; //for i := 0 to High(DynWarr)
        End Else
        If (ImPadding <> 0) Then Begin
          Cnt := 0;
          J   := 0;
          imLen := ImageWidth - 1;
          While Cnt < High(DynWarr) do begin
            if DynWarr[Cnt] > PixMin then
                 PixVal := round((DynWarr[Cnt] - PixMin)/ScaleFactor)
            else PixVal := 0;
            if PixVal > 255 then PixVal := 255;
            DisplayArray[J]:= PixVal;
            if Cnt Mod ImageWidth <> imLen then Inc(J,1)else Inc(J,ImPadding);
            Inc(Cnt);
          End; //While
        End; {If (ImPadding <> 0)}
        Pt := @DisplayArray[0];
      End Else

      If (BitsPerPixel = 8)  Then Begin
        {no scaling is needed usually}
        If (ImPadding = 0) Then Begin
            Pt := @DynBarr[0];
        End Else
        If (ImPadding <> 0) Then Begin
          Cnt := 0;
          J   := 0;
          imLen := ImageWidth - 1;
          While Cnt < High(DynBarr) do begin
            DisplayArray[J] := DynBarr[Cnt];
            if Cnt Mod ImageWidth <> imLen then Inc(J,1) else Inc(J,ImPadding);
            Inc(Cnt);
          End; //while
          Pt := @DisplayArray[0];
        End; //(BMPPadding <> 0)
      End; {If (BitsPerPixel = 8)}

    DisplayPreview(ImageWidth,ImageHeight,Pt);

End;  

Procedure TMainForm.DisplayPreview(Const ImageWidth,ImageHeight : Integer;Const Pt : Pointer);
Var

     DestXL           : Integer;
     DestYtop         : Integer;
     DestWidth        : Integer;
     DestHeight       : Integer;

Begin
  {It is important to Set ImagePreview.Picture.Bitmap to the Original Image X & Y sizes,
   so if has to be stretched will not be pixelized}
  //StretchDIBits Targets Bitmap Canvas}    //OpenImageDialog.ImagePreview.Picture.Bitmap.Canvas.Handle

  {Memorizes Some Variables}

  OpenImageDialog.ImagePreview.Picture.Bitmap.SetSize(ImageWidth,ImageHeight);
  {better performance than setting the height and width separately}
  DestXL     := 0;
  DestYtop   := 0;
  DestWidth  := ImageWidth;
  DestHeight := ImageHeight;

  InitBitmapHeaderXY(ImageWidth,ImageHeight);
  SetStretchBltMode(OpenImageDialog.ImagePreview.Canvas.Handle,STRETCH_HALFTONE);

  StretchDIBits(OpenImageDialog.ImagePreview.Canvas.Handle,
                DestXL,DestYtop,DestWidth,DestHeight,
                0,0, ImageWidth,ImageHeight,
                Pt, lpBitmapInfo[0]^,DIB_RGB_COLORS,SRCCOPY);
  {no need of repaint}
 OpenImageDialog.ImagePreview.Repaint;

 InitBitmapHeaderXY(imXsize,imYsize); {restores }

End;

 {****************************************************************************}
procedure TMainForm.FileOpen(Sender: TObject);

Var

  
   NrOfFiles    : integer;    {Nr of Files in Queue File to be analyzed}
   TxTFile      : TextFile;
   ValidFile    : Boolean;
   Cnt,i        : Integer;  {counter}
   IndMem,DigDone : Integer;  {counter}
   ReadInt      : integer;
   ReadDbl      : Double;
   AChar        : AnsiChar;
   ReadStr      : AnsiString;
   TemStr       : AnsiString;
   MarkType     : AnsiString;
   BegFill      : Boolean;
   SilentMode   : Boolean;
   {ROI file Variables}
   BinFile      : File;
   FPos         : LongInt;
   pReadStr     : Pointer; {Have To Use it for Reading}
   TempLongInt  : LongInt;       {Used in Open ROI}
   TempWord     : Word;          {Used in Open ROI}
   TempByte     : Byte;          {Used in Open ROI}
   WordArr      : TDynWordArray; {Used in Open ROI}
   CntX,CntY    : Integer;       {Used in Open ROI}
   DataOffset   : array[1..20] of LongInt; {Used in Open ROI}
   TempPrevImFile   : AnsiString;
   TempPrevImFindex : Byte;
   NewROItype   : Boolean;
   OnClickChange : TNotifyEvent;

BEGIN

  frmPlayback.Stop.Down := True;
  frmPlayback.StopClick(Sender);
  Application.ProcessMessages;
 
 {first assigns filters to Open Dialog}

if (sender = OpenAverageFile) then Begin
  OpenFileDialog.Title := 'Open Average File';
  OpenFileDialog.Filter := 'Open Average File (*.ave)|*.ave';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.AverImFilePath <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.AverImFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.AverImFilePath = '') then
  if ImFname <> '' then OpenFileDialog.InitialDir := ExtractFileDir(ImFname);
  

end else
if (sender = OpenMarkFile) then Begin
  OpenFileDialog.Title := 'Open Mark File';
  OpenFileDialog.Filter := 'Open Mark File (*.txt)|*.txt';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.MarkFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then
  if ImFname <> '' then OpenFileDialog.InitialDir := ExtractFileDir(ImFname);
end else
if (sender = OpenSpatialSpreadFile) then Begin
  OpenFileDialog.Title := 'Open Spatial Spread File';
  OpenFileDialog.Filter := 'Open Spatial Spread File (*.txt)|*.txt';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.MarkFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then
  if ImFname <> '' then OpenFileDialog.InitialDir := ExtractFileDir(ImFname);
  //for now Spatial Spread Files will use FilePaths.MarkFilePath//
end else
if (sender = OpenMeasuringLineFile) then Begin
  OpenFileDialog.Title := 'Open Measuring Line Coordinates File';
  OpenFileDialog.Filter := 'Open Measuring Line File (*.txt)|*.txt';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.MarkFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then
  if ImFname <> '' then OpenFileDialog.InitialDir := ExtractFileDir(ImFname);
  //for now Spatial Spread Files will use FilePaths.MarkFilePath//
end else

if (sender = OpenQueueFile) then Begin

  OpenFileDialog.Title := 'Open Queue File';
  OpenFileDialog.Filter := 'Open Queue File (*.txt)|*.txt';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.QFilePath <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.QFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.QFilePath = '') then
  if (ImFname <> '') then OpenFileDialog.InitialDir := ExtractFileDir(ImFname)
    else
  if (ImFname  = '') and (PrevImFileName <> '') then OpenFileDialog.InitialDir  := ExtractFileDir(PrevImFileName);

end else
if (sender = OpenPlaylist) then Begin   MainForm.
  OpenFileDialog.Title := 'Open Playlist';
  OpenFileDialog.Filter := 'Open Playlist (*.txt)|*.txt';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.ListOfFiles <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.ListOfFiles;
  end else
  if (UseMoviFilePath = True) or (FilePaths.ListOfFiles = '') then
  if ImFname <> '' then OpenFileDialog.InitialDir := ExtractFileDir(ImFname);
end else
if (sender = OpenROIfile) then Begin
  OpenFileDialog.Title := 'Open ROI File';
  OpenFileDialog.Filter := 'Open ROI File (*.roi)|*.roi';
  OpenFileDialog.FileName := '';
  if (UseMoviFilePath = False) and (FilePaths.ROIFilePath <> '') then begin
  OpenFileDialog.InitialDir := FilePaths.ROIFilePath;
  end else
  if (UseMoviFilePath = True) or (FilePaths.ROIFilePath = '') then
  if ImFname <> '' then OpenFileDialog.InitialDir := ExtractFileDir(ImFname);
end else
if (sender = OpenParFile) then Begin
  TemStr := OpenFileDialog.FileName;
  OpenFileDialog.FileName := '';
  OpenFileDialog.InitialDir := SparkAnDir;
  OpenFileDialog.Title := 'Open Program Settings File';
  OpenFileDialog.Filter := 'Open Program Settings (*.par)|*.par';
end;

{--- End of Title and Filter assign -----------}

If  (OpenFileDialog.Execute = True)  Then Begin

{-- for all Types of  Files --}

If (sender = OpenAverageFile) then begin
  if OpenFileDialog.FileName <> '' Then Begin
    SilentMode := False;
    AvImFPath  := OpenFileDialog.FileName; {save it for QFile}
    OpenAvImFile(OpenFileDialog.FileName,SilentMode);
    FilePaths.AverImFilePath  := ExtractFilePath(OpenFileDialog.FileName);
  end;
End
{---------------------------------------------------------------------------}
Else If (Sender = OpenParFile) then begin
  if OpenFileDialog.FileName <> '' then OpenSparkAnParameters(Sender);
End
{---------------------------------------------------------------------------}
Else if (sender = OpenROIfile) then Begin
 If OpenFileDialog.FileName <> '' Then Begin

  if (frmImageControl.sbSetROItracking.Down) then begin
  //release Track button if depressed
    frmImageControl.sbSetROItracking.Down := False;
    frmImageControl.DoSetROItracking(False); //False = Do not update image
  end;

  if (frmImageControl.ubSetDiamMes.Selected) then begin
    frmImageControl.ubSetDiamMes.Selected := False;
    frmImageControl.ubSetDiamMesClick(Sender);
  end;

  FilePaths.ROIFilePath  := ExtractFilePath(OpenFileDialog.FileName);
  {sets Files}
  AssignFile(BinFile,OpenFileDialog.FileName);
  FileMode := fmOpenRead;
  Reset(BinFile,1);
  {check file type}
  SetLength(ReadStr,10);
  pReadStr := @ReadStr[1]; {Sets Pointer at Fist character in String}
  {WriteStr := 'SparkAnROI';}
  FPos :=  0;
  Seek(BinFile,FPos);
  BlockRead(BinFile,pReadStr^,10);
  If (ReadStr <> 'SparkAnROI') and (ReadStr <> 'SparkanROI') then Begin
    {SparkAnROI is Old Type, SparkanROI is the NEW Type}
    MessageDlg('This is Not SparkAn ROI File',mtError,[mbOK],0);
  End Else
  If (ReadStr = 'SparkAnROI') or (ReadStr = 'SparkanROI') then Begin
    if ReadStr = 'SparkAnROI' then NewROItype := False else
    if ReadStr = 'SparkanROI' then NewROItype := True;
    BegFill := True;
    {Reads Image X dim}
    FPos :=  10;
    Seek(BinFile,FPos);
    BlockRead(BinFile,TempWord,SizeOf(TempWord));
    if TempWord <> imXsize then BegFill := False;
    {Reads Image Y dim}
    FPos :=  FPos + SizeOf(TempWord);
    Seek(BinFile,FPos);
    BlockRead(BinFile,TempWord,SizeOf(TempWord));
    if TempWord <> imYsize then BegFill := False;
    If BegFill = False Then Begin
      MessageDlg('Cannot Open File: Image Dimensions from ROI file and Current File are Different',mtError,[mbOK],0);
    End Else
    {Here it Really Starts}
    If BegFill = True Then Begin
      {Deletes All ROIs}
        ROIvar.NrROI := 0;
      For i := 1 to 20 Do Begin
        ROIvar.ROIAdr[i] := 0;  {Zeroes Out the Array=No Selections}
        FhPol[i] := nil;
        FhTbl[i] := nil;
      End;

      {1st: Gets Nr of ROI}
      FPos :=  FPos + SizeOf(TempWord);
      Seek(BinFile,FPos);
      BlockRead(BinFile,TempByte,SizeOf(TempByte));
      ROIvar.NrROI := TempByte;
      {2nd: Gets each ROI Addr}
      FPos := 14;
      For i := 1 to 20 do Begin
        FPos :=  FPos + SizeOf(TempByte);
        Seek(BinFile,FPos);
        BlockRead(BinFile,TempByte,SizeOf(TempByte));
        ROIvar.ROIAdr[i] := TempByte;
      End; {For}
      {3rd: Gets Data Offset for each ROI}
      FPos := 35;
      Seek(BinFile,FPos);
      BlockRead(BinFile,DataOffset,SizeOf(DataOffset));
   {First Element of DataOffset starts at FPos = 35}
   {so Data Starts from FPos = 35 + 80 = 115 [fixed=always]}
      {4th : Fills ROI }
      For Cnt := 1 to 20 do Begin
        If ROIvar.ROIAdr[Cnt] = 1 then Begin
          SetLength(WordArr,4);
          FPos := DataOffset[Cnt];
          Seek(BinFile,FPos);
          BlockRead(BinFile,WordArr[0],Length(WordArr)*2);
          For i := 0 to 3 do ROIvar.ROICoor[i+1,Cnt] := WordArr[i];
        End Else {If ROIvar.ROIAdr[Cnt] = 1}
        If ROIvar.ROIAdr[Cnt] = 3 {Free Hand} then Begin
          {Reads Nr of Points and Nr of Raws and Sets Arrays Lengths}
          SetLength(WordArr,2);
          FPos := DataOffset[Cnt];
          Seek(BinFile,FPos);
          BlockRead(BinFile,WordArr[0],Length(WordArr)*2);
          SetLength(FhPol[Cnt],WordArr[0]);
          SetLength(FhTbl[Cnt],WordArr[1]);
          {Reads Polygon array- 1st X, then Y}
          {X}
          FPos := FPos + Length(WordArr)*2; {increments FPos}
          SetLength(WordArr,Length(FhPol[Cnt]));
          Seek(BinFile,FPos);
          BlockRead(BinFile,WordArr[0],Length(WordArr)*2);
          for CntX := 0 to High(FhPol[Cnt]) do FhPol[Cnt,CntX].X := WordArr[CntX];
          { Y}
          FPos := FPos + Length(WordArr)*2; {increments FPos}
          Seek(BinFile,FPos);
          BlockRead(BinFile,WordArr[0],Length(WordArr)*2);
          for CntY := 0 to High(FhPol[Cnt]) do FhPol[Cnt,CntY].Y := WordArr[CntY];
          {Reads FhTable array}
          For CntY := 0 to High(FhTbl[Cnt]) do Begin
          {Reads Nr of Xses}
           { TempWord := Length(FhTbl[CntROI,CntY]);}
            FPos := FPos + Length(WordArr)*2; {increments FPos}
            Seek(BinFile,FPos);
            BlockRead(BinFile,TempWord,SizeOf(TempWord));
            SetLength(FhTbl[Cnt,CntY],TempWord);
            SetLength(WordArr,TempWord);
            {Xs }
            FPos := FPos + 2;
            Seek(BinFile,FPos);
            BlockRead(BinFile,WordArr[0],Length(WordArr)*2);
            for CntX := 0 to High(FhTbl[Cnt,CntY]) do
                                    FhTbl[Cnt,CntY,CntX].X := WordArr[CntX];
            {Ys}
            FPos := FPos + Length(WordArr)*2;
            Seek(BinFile,FPos);
            BlockRead(BinFile,WordArr[0],Length(WordArr)*2);       {HERE is THE ERROR READS BEYOND THE FILE}
            for CntX := 0 to High(FhTbl[Cnt,CntY]) do
                                    FhTbl[Cnt,CntY,CntX].Y := WordArr[CntX];
          End; {For CntY := 0 to High(FhTbl[CntROI]) do Begin}
        End;  {Free Hand}
      End; {For Cnt := 1 to 20 do Begin}
      {------------------------------------------------------------}
      If NewROItype = False Then For Cnt := 1 to 20 do Begin
         If ROIvar.ROIAdr[Cnt] = 1 then Begin
         {These Four Statements Decrease Selection by 1 pixel[L,Top] and 2 [RB]}
         ROIvar.ROICoor[1,Cnt] := ROIvar.ROICoor[1,Cnt] + 1;
         ROIvar.ROICoor[2,Cnt] := ROIvar.ROICoor[2,Cnt] + 1;
         ROIvar.ROICoor[3,Cnt] := ROIvar.ROICoor[3,Cnt] - 2;
         ROIvar.ROICoor[4,Cnt] := ROIvar.ROICoor[4,Cnt] - 2;
         End;
      End; {If NewROItype = False}
      
        {--------- Refreshes Images-----------------}

      UpdateMainImage(True);

    If (frmAverIm <> nil) and (AvImExists > 0) and (ROIvar.ROIonAverWin = true) Then Begin
        UpdateAverImage(True);
    End;
        {-------------------------------------------}
   End; { If BegFill = True}
   {--------- End of Really Starts -----------}
  End; {ReadStr = 'SparkAnAver'}
  CloseFile(BinFile);
 End; {if OpenFileDialog.FileName <> ''}
End   //(sender = OpenROIfile)
{---------------------------------------------------------------------------}
Else If (sender = OpenPlaylist) then Begin
    FilePaths.ListOfFiles  := ExtractFilePath(OpenFileDialog.FileName);
    AssignFile(TxTFile,OpenFileDialog.FileName);
    FileMode := fmOpenRead;
    Reset(TxTFile);

    ReadLn(TxTFile,ReadStr);
 If ReadStr = 'SparkAn List of Files' Then Begin
    NrFiles := 0;
    strFileList  := nil;
    FileTypeList := nil;

 While Not(Eof(TxTFile)) do begin
    SetLength(strFileList,High(strFileList) + 2);
    SetLength(FileTypeList,High(FileTypeList) + 2);
    Read(TxTFile,FileTypeList[High(FileTypeList)]);
    Read(TxTFile,AChar);
    ReadLn(TxTFile,strFileList[High(strFileList)]);
    Inc(NrFiles);
 end; 
    Application.ProcessMessages;
    if frmFileList <> nil then frmFileList.LoadFileList(0)
    else FileListClick(sender);
 End Else Begin
   MessageDlg('This is Not a List of Files',mtError,[mbOK],0);
 End;
  CloseFile(TxTFile);
End
{---------------------------------------------------------------------------}
Else If (sender = OpenMarkFile) then  begin
  If OpenFileDialog.FileName <> '' Then Begin
      FilePaths.MarkFilePath  := ExtractFilePath(OpenFileDialog.FileName);

      OpenAnyMarkFile(OpenFileDialog.FileName);


  End; {OpenFileDialog.FileName <> ''}
End   {(sender = OpenMarkFile)}
{------------------------------------------------------------------------------}
Else If (sender = OpenSpatialSpreadFile) Then Begin
  If OpenFileDialog.FileName <> '' Then Begin

      FilePaths.MarkFilePath := ExtractFilePath(OpenFileDialog.FileName);
      AssignFile(TxTFile,OpenFileDialog.FileName);
      FileMode := fmOpenRead;
      Reset(TxTFile);
      {-------- Reads Heather-------}
      ReadLn(TxTFile,ReadStr);
      if ReadStr <> 'SparkAn Spatial Spread File' then
        MessageDlg('This is Not Spatial Spread File Type',mtError,[mbOK],0)
      else

      If (ReadStr = 'SparkAn Spatial Spread File') then Begin
        ReadLn(TxTFile,ReadStr);
        TemStr := Copy(ReadStr,18,Length(ReadStr)-17);
        If TemStr <> ImFtitle Then Begin
          TemStr := 'This Spatial Spread File Does Not Originate from Current File but from'
                + ' "' + TemStr + '"';
          MessageDlg(TemStr,mtWarning,[mbOK],0);
        End
          Else
        Begin
          //Zeroes Buffers EQ = nil
          SetLength(SpreadImNr,0);
          SetLength(SpreadCoor,0);
          SetLength(SpreadAmpl,0);
          SetLength(SpreadSurface,0);
          //Reads through the rest of the Header
          ReadLn(TxTFile);
          ReadLn(TxTFile);

          //Find Number of Rows and sore them in CntY
          ReadLn(TxTFile,ReadStr);
          CntY := 1;
          While Not(Eof(TxTFile)) Do Begin
           ReadLn(TxTFile);
           Inc(CntY);
          End;
          CloseFile(TxTFile);

          //find number of Spreads. It is from one or more images
          CntX := 0;
          for Cnt := 1 to Length(ReadStr) do begin
            if (ReadStr[Cnt] = Chr(9)) then Inc(CntX);
          end;
          CntX := CntX - 4;   //CntX repsents number of Spreads

          SetLength(SpreadImNr,CntY);
          SetLength(SpreadCoor,CntY);
          SetLength(SpreadAmpl,CntY);
          SetLength(SpreadSurface,CntY,CntX);

          CntY := 0;
           //reopens file
          AssignFile(TxTFile,OpenFileDialog.FileName);
          FileMode := fmOpenRead;
          Reset(TxTFile);

          ReadLn(TxTFile);
          ReadLn(TxTFile);
          ReadLn(TxTFile);
          ReadLn(TxTFile);

          While Not(Eof(TxTFile)) Do Begin //here Cnt is used to Read Text File

             Read(TxTFile, ReadInt); //Reads Column Nr

             Read(TxTFile, ReadInt); //Reads Image #
             SpreadImNr[CntY] := ReadInt;

             Read(TxTFile, ReadInt); { X }
             SpreadCoor[CntY].X := ReadInt;

             Read(TxTFile, ReadInt); { Y }
             SpreadCoor[CntY].Y := ReadInt;

             Read(TxTFile, ReadDbl); {Amplitude}
             SpreadAmpl[CntY] := ReadDbl;

             if (CntX = 1) then
             ReadLn(TxTFile, ReadDbl) else {Spatial spread of the 1st Image (always present)}
             Read  (TxTFile, ReadDbl);
             SpreadSurface[CntY,0] := ReadDbl;

             If (CntX > 1) then Begin
              ReadLn(TxTFile, ReadStr);
              TemStr := '';

              IndMem  := 1;
              DigDone := 1;
              BegFill := False;
              Cnt := 0;

              for i := 1 to Length(ReadStr) do begin

                AChar := ReadStr[i];

                if (AChar in DigitsFlt) and (BegFill) then begin
                    TemStr := TemStr + AChar;
                end;

                if ((AChar = Char(9)) or (i = Length(ReadStr))) and
                   (TemStr <> '') and (BegFill) then begin
                  SpreadSurface[CntY,DigDone] := StrToFloat(TemStr);
                  Inc(DigDone);
                  BegFill := False;
                  TemStr := '';
                end;

                if (AChar = Char(9)) and not(BegFill) then BegFill := True;

                if (AChar = '-') and (BegFill) then begin
                  for Cnt := DigDone to CntX-1 do begin
                    SpreadSurface[CntY,Cnt] := -1;
                  end;
                  Break;
                end;

              end;  //for i := 1 to Length(ReadStr) do begin

             End; //If (CntX > 1) then Begin

             Inc(CntY); //increment row count
          End; // While Not(Eof(TxTFile))

          if (frmSpatialSpread  = nil) then Application.CreateForm(TfrmSpatialSpread, frmSpatialSpread) //it fills by itself
            else
          if (frmSpatialSpread <> nil) then frmSpatialSpread.FillSpreadTable;

        End; //Else begin
      End; //If (ReadStr = 'SparkAn Spatial Spread File')



     CloseFile(TxTFile);

  End;  //If OpenFileDialog.FileName <> '' Then Begin

End
{----------------------End of OpenSpatialSpreadFile ----------------------------}

{------------------------------------------------------------------------------}
Else If (sender = OpenMeasuringLineFile) Then Begin
  if OpenFileDialog.FileName <> '' then
    OpenMeasLineFile(OpenFileDialog.FileName);
End
{-----------------------------------------------}

Else If (sender = OpenQueueFile) then Begin

  If OpenFileDialog.FileName <> '' Then Begin
      FilePaths.QFilePath  := ExtractFilePath(OpenFileDialog.FileName);
      AssignFile(TxTFile,OpenFileDialog.FileName);
      FileMode := fmOpenRead;
      Reset(TxTFile);
      {-------- Reads Heather-------}
      ReadLn(TxTFile,ReadStr);
      if ReadStr <> 'SparkAn Queue File' then
      MessageDlg('This is Not Queue File Type',mtError,[mbOK],0) else

    If (ReadStr = 'SparkAn Queue File') then Begin
       {ReadInt      : integer;
       ReadDbl      : Double;}
       Read(TxTFile,NrOfFiles); {Nr of Files to Be analyzed}  Readln(TxTFile);

       {Zeroes}
       SetLength(QFileList,0);
       {---------------------------}
       SetLength(QFileList,NrOfFiles);

       Cnt := 0;
      While (Cnt < NrOfFiles) Do Begin
       Read(TxTFile,QFileList[Cnt].ColNr);      Readln(TxTFile);  {'Column Number'}
       Readln(TxTFile,QFileList[Cnt].QFName); {File Name}
       Read(TxTFile,QFileList[Cnt].FIndex);     Readln(TxTFile); {File Type }
       Read(TxTFile,QFileList[Cnt].ImToBeg);    Readln(TxTFile);
       Dec(QFileList[Cnt].ImToBeg);  //1st image has index = 0
       Read(TxTFile,QFileList[Cnt].ImToEnd);    Readln(TxTFile);
       Dec(QFileList[Cnt].ImToEnd);  //1st image has index = 0
  //-------- Average Image -------------------------------------------//
       Read(TxTFile,QFileList[Cnt].AverImKind); Readln(TxTFile);
       If (QFileList[Cnt].AverImKind = 1) then Begin
         Read(TxTFile,QFileList[Cnt].NrImInList); Readln(TxTFile);
         SetLength(QFileList[Cnt].ListOfIm,QFileList[Cnt].NrImInList);
         for i := 0 to High(QFileList[Cnt].ListOfIm) do begin
          Read(TxTFile,QFileList[Cnt].ListOfIm[i]);
          Dec(QFileList[Cnt].ListOfIm[i]); //1st image has index = 0
         end;
         Readln(TxTFile); //finishes line
         Readln(TxTFile); //skips line about the Filename//
       End Else Begin
        Readln(TxTFile); //skips line "Nr of Images for Average Image"//
        Readln(TxTFile); //skips line for slelected image numbers//
        if (QFileList[Cnt].AverImKind = 2) then //from File = 2//
          Readln(TxTFile,QFileList[Cnt].AvFName)
            else
          Readln(TxTFile); {skip this line}
       End;
  //----------- End with the Average Image --------------------------//
  //----------  Image Settings Window  ------------------------------//
       Read(TxTFile,QFileList[Cnt].BackGr);     Readln(TxTFile);
       Read(TxTFile,QFileList[Cnt].ImCutoff);   Readln(TxTFile);

       Read(TxTFile,QFileList[Cnt].ImageContrVar.BackGrMax);   Readln(TxTFile);
       Read(TxTFile,QFileList[Cnt].ImageContrVar.CutOffMax);   Readln(TxTFile);
       Read(TxTFile,QFileList[Cnt].ImageContrVar.MaxGamma);    Readln(TxTFile);

       Read(TxTFile,QFileList[Cnt].SmoothMode);  Readln(TxTFile);
       Read(TxTFile,QFileList[Cnt].SmoothOrder); Readln(TxTFile);

       if (QFileList[Cnt].SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX]) then
          Read(TxTFile,QFileList[Cnt].BoxCarF)
        else
      if (QFileList[Cnt].SmoothMode in [SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then
       Read(TxTFile,QFileList[Cnt].GaussF);
       Readln(TxTFile);
       Read(TxTFile,QFileList[Cnt].MedianF);    Readln(TxTFile);

       Readln(TxTFile,ReadStr);
       if (ReadStr = 'Smooth Before Doing Ratio') then
        QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio := True
          else
       if (ReadStr = 'Smooth After Doing Ratio') then
        QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio := False;

       Readln(TxTFile,ReadStr);
       if (ReadStr = 'Yes') then QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio := True else
       if (ReadStr = 'No')  then QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio := False;

       Readln(TxTFile,ReadStr);
       if ReadStr = 'No Frame Selection' then      QFileList[Cnt].ApplyFrame := False
        else
       if ReadStr = 'Follows Frame Selection' then QFileList[Cnt].ApplyFrame := True;
       if QFileList[Cnt].ApplyFrame = True then begin
        Read(TxTFile,QFileList[Cnt].SelFrame.Left);
        Read(TxTFile,QFileList[Cnt].SelFrame.Right);
        Read(TxTFile,QFileList[Cnt].SelFrame.Top);
        Read(TxTFile,QFileList[Cnt].SelFrame.Bottom);
       end;
       Readln(TxTFile); //finishes or skips line
       //----------  End with Image Settings Window  --------------------------//
       //----------- AutoSerach Settings --------------------------------------//
       with QFileList[Cnt].AutoSrchPar do begin
       Read(TxTFile,Thresh);       Readln(TxTFile);
       Read(TxTFile,Tolerance);    Readln(TxTFile);
       Read(TxTFile,ScanBoxSize);  Readln(TxTFile);
       Read(TxTFile,MaxArea);      Readln(TxTFile);
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Running Average' then    UseRunAver := True
        else
       if ReadStr = 'No Running Average' then UseRunAver := False;
       Read(TxTFile,NrImRunAver);  Readln(TxTFile);
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Ignore Big Events' then IgnoreBigEv := True
        else
       if ReadStr = 'Get Big Events' then    IgnoreBigEv := False;
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Test Small Events' then       TestSmallEv := True
        else
       if ReadStr = 'No Small Events Test' then    TestSmallEv := False;

       Readln(TxTFile,ReadStr);
       if ReadStr = 'Get Small Events Duration' then        GetSmEvDur := True
        else
       if ReadStr = 'Do Not Get Small Events Duration' then GetSmEvDur := False;
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Get Big Events Duration' then        GetBigEvDur := True
        else
       if ReadStr = 'Do Not Get Big Events Duration' then GetBigEvDur := False;
        //-------- Auto Average Generation -----------//
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Auto Average Image' then    AutoAverImage := True
        else
       if ReadStr = 'No Auto Average Image' then AutoAverImage := False;

       Read(TxTFile,NrImForCreateAvIm);    Readln(TxTFile);
       Read(TxTFile,AutoAverNrImInc);      Readln(TxTFile);
       Read(TxTFile,AutoAverImRange);      Readln(TxTFile);

       Readln(TxTFile,ReadStr);
       if ReadStr = 'Start Auto Average from 1st Image' then        StartAutoAverFirstIm := True
        else
       if ReadStr = 'Do Not Start Auto Average from 1st Image' then StartAutoAverFirstIm := False;
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Save Auto Average' then         SaveAutoAver := True
        else
       if ReadStr = 'Do Not Save Auto Average' then  SaveAutoAver := False;
        //-  End of Auto Average Generation ----------//
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Update F/Fo' then         UpdateRatio := True
        else
       if ReadStr = 'Do Not Update F/Fo' then  UpdateRatio := False;
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Use Custom ROI for Small Events Test' then UseCustomROIforSmEvTest := True
        else
       if ReadStr = 'Use Scan Box for Small Events Test' then  UseCustomROIforSmEvTest := False;

       Read(TxTFile,ROISizeForSmEvTest);       Readln(TxTFile);
       Read(TxTFile,NrImGetMinLeft);           Readln(TxTFile);
       Readln(TxTFile,ReadStr);
       if ReadStr = 'Use SD of Baseline for Small Events Test'        then  Sduse := True
        else
       if ReadStr = 'Do Not Use SD of Baseline for Small Events Test' then  SDuse := False;
       Read(TxTFile,SDfold);           Readln(TxTFile);
       Read(TxTFile,NrImGetMinRight);          Readln(TxTFile);
       Read(TxTFile,SearchLms);                Readln(TxTFile);
       Read(TxTFile,SearchRms);                Readln(TxTFile);
       Read(TxTFile,NrImToLeftOfEv);           Readln(TxTFile);
       Read(TxTFile,NrImToRightOfEv);          Readln(TxTFile);
       Read(TxTFile,PLval);                    Readln(TxTFile);
       Read(TxTFile,PRval);                    Readln(TxTFile);
       end; //with QFileList[Cnt].AutoSrchPar do begin
       {end of loading all variuables}
       Readln(TxTFile,ReadStr);
       {if ReadStr <> 'End' then Inc(Cnt);}

       Inc(Cnt);

     End; {While Cnt < NrOfFiles}
      {------------------------}
    End; {If ReadStr = 'SparkAn Queue File'}
      CloseFile(TxTFile);
      OpenFileDialog.InitialDir := ExtractFileDir(OpenFileDialog.FileName);
      if frmQueueFiles = nil then Application.CreateForm(TfrmQueueFiles, frmQueueFiles)
      else begin
      frmQueueFiles.ClearAllClick(sender);
      frmQueueFiles.LoadQFileTable;
      frmQueueFiles.WindowState := wsNormal;
      frmQueueFiles.Show;
      end;
  End; {If OpenFileDialog.FileName <> ''}
End; {If (sender = OpenQueueFile)}

  
{------------------------------------------------------------------------------}
 End; {f  OpenFileDialog.Execute = True}
END; {procedure TMainForm.FileOpen(Sender: TObject);}
 {*************************************************************************}

Procedure TMainForm.SaveProcessedMovieFilesClick(Sender: TObject);
Var Cnt           : Integer;
    RequestedSpace : Int64;
    Fh            : THandle;
    pB            : pByte;
    mrValue       : Byte;
    Proceed       : Boolean;
    DuplFnames    : Boolean;
    TempColName   : AnsiString;  {includes the whole path}
    SelFolder     : AnsiString; //Selected Folder
    StartingDir   : AnsiString;
    OrigFileExt   : AnsiString;
    SaveFname     : AnsiString;  {includes the whole path}
    NewCollFileNames : TDynAnsiStrArray;
    XMlorPCF_FileName  : AnsiString;

Begin

  //Stop any Playback
  frmPlayback.Stop.Down := True;
  frmPlayback.StopClick(Sender);

  if (RAM_Usage.KindOfModMovie = KALMAN_FILT) then Suffix := '_KF'
      else
  if (RAM_Usage.KindOfModMovie = NORM_COR)    then Suffix := '_NM'
      else
  if (RAM_Usage.KindOfModMovie = BLEACH_COR)  then Suffix := '_BC';

  OrigFileExt := ExtractFileExt(ImFname);

  //Set Title and Filter
  If (ImageFileType = MULTI_IMAGE) then begin

    if (OrigFileExt = '.tif') then  begin
    SaveFileDialog.Title := 'Save Processed Tiff File';
    SaveFileDialog.Filter := 'Save Tiff File (*.tif)|*.tif';
    end
      else
    if (OrigFileExt = '.lsm') then  begin
    SaveFileDialog.Title := 'Save Processed Zeiss "lsm" File';
    SaveFileDialog.Filter := 'Save "lsm" File (*.lsm)|*.lsm';
    end
      else
    if (OrigFileExt = '.czi') then  begin
    SaveFileDialog.Title := 'Save Processed Zeiss "czi" File';
    SaveFileDialog.Filter := 'Save "czi" File (*.czi)|*.czi';
    end
      else
    if (OrigFileExt = '.nd2') then  begin
    SaveFileDialog.Title := 'Save Processed Nikon NIS-Elements "nd2" File';
    SaveFileDialog.Filter := 'Save "nd2" File (*.nd2)|*.nd2';
    end
    //SaveFileDialog.InitialDir always truncates "\" at the end
    //So it works with both (result is the same) File Directory or File Path
  End

    Else

  If (ImageFileType = FILE_COLLECTION) then begin
    SaveFileDialog.Title := 'Save Collection File of Multi-Image Tiffs and Write New Tiff Files';
    SaveFileDialog.Filter := 'Save Collection (*.col)|*.col';
  End
    Else
  If (ImageFileType = SINGLE_IMAGE) then begin
    SaveFileDialog.Title := 'Save Processed Tiff Files';
    SaveFileDialog.Filter := 'Save Tiff File (*.tif)|*.tif';
  End;

   if (UseMoviFilePath = False) and (FilePaths.ModifiedMoviesPath <> '') then begin
      SaveFileDialog.InitialDir := FilePaths.ModifiedMoviesPath;
      SaveFileDialog.FileName := imFtitle + Suffix;
   end;

   if (UseMoviFilePath = True) or (FilePaths.ModifiedMoviesPath = '') then begin
      SaveFileDialog.InitialDir := ExtractFileDir(ImFname);
      SaveFileDialog.FileName := imFtitle + Suffix;
   end;

//--- End of Title and Filter Assignment ----------//

 If (ImageFileType in[MULTI_IMAGE,FILE_COLLECTION]) Then Begin

  If (SaveFileDialog.Execute) Then BEGIN

    FilePaths.ModifiedMoviesPath := ExtractFilePath(SaveFileDialog.FileName);
    SaveFname                    := SaveFileDialog.FileName;

   if (ImageFileType = MULTI_IMAGE) then begin
    if ExtractFileExt(SaveFname) <> OrigFileExt then SaveFname := SaveFname + OrigFileExt;
   end else
   if (ImageFileType = FILE_COLLECTION) then begin
    if ExtractFileExt(SaveFname) <> '.col' then SaveFname := SaveFname + '.col';
   end;

   Proceed := True;

   //--------------------------------------------------------------------------//
   If (ImageFileType = MULTI_IMAGE) then begin

      if (FileExists(SaveFname)) then begin
        mrValue := MessageDlg('File with this name exists and will be overwritten!', mtConfirmation, [mbCancel,mbOK], 0, mbCancel);
        if (mrValue = mrCancel) then Proceed := False else Proceed := True;
      end;

      //Check if Space is Enough
      If (Proceed) then Begin
        RequestedSpace := GetRequestedSpace;
        Proceed := DriveSpaceEnough(RequestedSpace,SaveFname,True);
      End;

      If (Proceed) then Begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.lbAction.Caption := 'Writing File.';
          frmProgress.lbReading.Caption := 'Progress:';
          frmProgress.Show;
          Application.ProcessMessages;
        end;
        WriteImageFromFileLoadedInRAM(0,SaveFname);
      End;

   End  Else
 //-------------------------------------------------------------------------//
   If (ImageFileType = FILE_COLLECTION) then Begin

    //Checks for Existing Collection FileName
    if (FileExists(SaveFname)) then begin
        mrValue := MessageDlg('Collection File with this name exists and will be overwritten!', mtConfirmation, [mbCancel,mbOK], 0, mbCancel);
        if (mrValue = mrCancel) then Proceed := False else Proceed := True;
    end;

    If (Proceed) then Begin
      SetLength(NewCollFileNames,Length(CollFileNames));
      DuplFnames := False;
      for Cnt := 0 to  High(CollFileNames) do begin
        TempColName := ExtractFilePath(SaveFname) + ExtractFileName(CollFileNames[Cnt]);
        NewCollFileNames[Cnt] := AnsiLeftStr(TempColName,PosEx('.tif', TempColName, 1) - 1) + Suffix + '.tif';
        DuplFnames := (FileExists(NewCollFileNames[Cnt]));
      end;
    End;

    Proceed := not(DuplFnames);
    btPressed := bEnter;

    If (DuplFnames) Then While (btPressed = bEnter) and not(Proceed) do Begin
      if (frmInputDialog = nil)  then Application.CreateForm(TfrmInputDialog, frmInputDialog);
      Application.ProcessMessages;

      If (btPressed = bEnter) then Begin
        for Cnt := 0 to  High(CollFileNames) do begin
          TempColName := ExtractFilePath(SaveFname) + ExtractFileName(CollFileNames[Cnt]);
          NewCollFileNames[Cnt] := AnsiLeftStr(TempColName,PosEx('.tif', TempColName, 1) - 1) + Suffix + '.tif';
          DuplFnames := (FileExists(NewCollFileNames[Cnt]));
        end; //for Cnt := 0 to  High(CollFileNames)
        Proceed := not(DuplFnames);
      End Else
      If (btPressed = bOverWrite) then
        Proceed := True
        else
      If (btPressed = bCancel) then
        Proceed := False;
    End; //If not(Proceed) Then While not(Proceed) do Begin

    if (Proceed) and (DuplFnames) then begin
      mrValue := MessageDlg('Tiff Files with this name exist and will be overwritten!', mtConfirmation, [mbCancel,mbOK], 0, mbCancel);
      if (mrValue = mrCancel) then Proceed := False else Proceed := True;
    end;

     //Check if Space is Enough
      If (Proceed) then Begin
        RequestedSpace := GetRequestedSpace;
        Proceed := DriveSpaceEnough(RequestedSpace,SaveFname,True);
      End;

    If (Proceed) then Begin
      SaveCollectionFile(SaveFname, NewCollFileNames);
      //Writes Modified Tiff Files
      for Cnt := 0 to High(NewCollFileNames) do begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.lbAction.Caption := 'Writing File ' + IntToStr(Cnt+1) +
                                      '(' + IntToStr(Length(NewCollFileNames)) + ')';
          frmProgress.lbReading.Caption := 'Progress:';
          frmProgress.Show;
          Application.ProcessMessages;
        end;

        WriteImageFromFileLoadedInRAM(Cnt,NewCollFileNames[Cnt]);
      end;

    End; // Final Proceed

    End; //If (ImageFileType = FILE_COLLECTION) then Begin

   End; //If (SaveFileDialog.Execute)
   //----------------------------------------------------------------------//
  End

    Else

  If (ImageFileType = SINGLE_IMAGE) then Begin

    //Create (or Select) Folder

    mrValue := MessageDlg('Create New Folder in a Folder One Level Above?',
                mtConfirmation, [mbIgnore,mbOK], 0, mbOK);
    if (mrValue = mrIgnore) then
      StartingDir := ''
    else
      StartingDir := GetDirectoryOneLevelAbove(ExtractFileDir(TiffFileList[0]));


    SelFolder := BrowseDialog('Create or Select Folder',StartingDir, BIF_NEWDIALOGSTYLE);
    //BIF_NEWDIALOGSTYLE is declared in Winapi.CommCtrl unit
    if (SelFolder <> '') then Proceed := True else Proceed := False;

    //Checks Drive Space occupied by Current (non modified Files)

     //Check if Space is Enough
      If (Proceed) then Begin
        RequestedSpace := GetRequestedSpace;
        Proceed := DriveSpaceEnough(RequestedSpace,SaveFname,True);
      End;

    //Finally Starts Saving
    If (Proceed) then Begin

      if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.lbAction.Caption := 'Writing File.';
        frmProgress.lbReading.Caption := 'Progress:';
        frmProgress.ImageProgressBar.Max := NrIm;
        frmProgress.Show;
        Application.ProcessMessages;
      end;
        SelFolder := SelFolder + '\';
      For Cnt := 0 to NrIm-1 do Begin
        Fh := FileCreate(SelFolder + ExtractFileName(TiffFileList[Cnt]));
        FileSeek(Fh,0, 0);
        pB := @RawDataInRAM[0,SizeOfFile*Cnt];
        FileWrite(Fh, pB^, SizeOfFile);
        FileClose(Fh);
        frmProgress.ImageProgressBar.Position := Cnt+1;
        frmProgress.lbProgress.Caption := IntToStr(Cnt + 1) + ' (' + IntToStr(NrIm) + ')';
        Application.ProcessMessages;
      End;

      //write xml or pcf file
      if (MovFType = NORAN_PRARIE_MOV) then begin
        XMlorPCF_FileName := FileSearch('*.xml', ExtractFilePath(TiffFileList[0]));
        if (XMlorPCF_FileName = '') then
        XMlorPCF_FileName := FileSearch('*Main.pcf', ExtractFilePath(TiffFileList[0]));
        if (XMlorPCF_FileName <> '') then begin
         CopyFile(PChar(string(ExtractFilePath(TiffFileList[0]) + XMlorPCF_FileName)),
                PChar(string(SelFolder + XMlorPCF_FileName)), False);
         {CopyFile(PChar(fileSource), PChar(fileDest), bFileifExists );
         // bFailIfExists:
  Specifies how this operation is to proceed if a file of the same name as
  that specified by lpNewFileName already exists.
  If this parameter is TRUE and the new file already exists, the function fails.
  If this parameter is FALSE and the new file already exists,
  the function overwrites the existing file and succeeds.   }
        end; //if (XMlorPCF_FileName <> '')
      end; // if (MovFType = NORAN_PRARIE_MOV) then begin

      frmProgress.Close;
    End;

   End; //If (ImageFileType = SINGLE_IMAGE) then Begin

End; //Procedure TMainForm.SaveProcessedTiffFilesClick

{*********************************************************}

procedure TMainForm.SaveCollectionOfMultiImageTiffsClick(Sender: TObject);
var
  SaveFname : AnsiString;
  DoCancel  : Boolean;
Begin

  frmPlayback.Stop.Down := True;
  frmPlayback.StopClick(Sender);

  SaveFileDialog.Title := 'Save Collection File of Multi-Image Tiffs';
  SaveFileDialog.Filter := 'Save Collection (*.col)|*.col';
  if (UseMoviFilePath = False) and (FilePaths.ListOfFiles <> '') then begin
    SaveFileDialog.InitialDir := FilePaths.ListOfFiles;
    SaveFileDialog.FileName := ImFtitle;
  end else
    if (UseMoviFilePath = True) or (FilePaths.ListOfFiles = '') then begin
    SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
    SaveFileDialog.FileName := ImFtitle;
  end;


  If (SaveFileDialog.Execute) Then Begin
    // saves Program Options//
   SaveFname := SaveFileDialog.FileName;
   if (ExtractFileExt(SaveFname) <> '.col') then begin
    SaveFname := SaveFname + '.col';
    SaveFileDialog.FileName := SaveFname; //update it because is used in Queue File
   end;
   SaveCollectionFile(SaveFname,CollFileNames);
   SaveFileDialog.InitialDir := ExtractFilePath(ImFname); //reverts to Image File Path//
  End;

End;

{*********************************************************}

procedure TMainForm.FileSaveAs(Sender: TObject);
 Var
    SaveFname,ZeroStr,NrStr  : AnsiString;  {includes the whole path}
    WriteStr, TimeStr,FrHz   : AnsiString;
    pWriteStr                : Pointer; {Have To Use it for Writing}
    TempLongInt              : LongInt;       {Used in Write ROI}
    TempWord                 : Word;          {Used in Write ROI}
    TempByte                 : Byte;          {Used in Write ROI}
    WordArr                  : TDynWordArray; {Used in Write ROI}
    DataOffset               : array[1..20] of LongInt; {Used in Write ROI}
    Cnt, Beg, ToEnd,NrToRepl : Integer;
    CntROI,ImNr,i,StartPos   : Integer;
    CntX,CntY                : Integer;
    RequestedSpace           : Int64;
    FirstTime                : Boolean;
    TxtFile                  : TextFile;
    BinFile                  : File;
    TemBmp                   : TBitmap;
    SourceRect               : TRect;
    Pt                       : TPoint;
    Fpos                     : LongInt;
    WriteEvents              : Boolean;
    DoCancel                 : Boolean;
    {Peaks Variables}
    RiseT,Dur, Decay         : Double; {RiseT = 10%-90% Rise Time, Peak Duration at 1/2 ampl and t1/2}
    TrUsed                   : Integer; {Trace Nr Used =  Traces Displayed}
    SaveAsFile               : Boolean;
   {Copies of
    PeakPosArr : TDyn2DWordArray;  Peak Position as Image Number
    PeakValArr : TDyn2DSingleArr;  F/Fo amplitude
    PeakTimArr : TDyn2DCoupleDoubleArray; in order to store Peaks only
    for the Displayed Part of Trace}

    procedure SetBMPsize (aImage : TImage);
    begin
        TemBmp.SetSize(aImage.Width,aImage.Height);
        SourceRect := aImage.Canvas.ClipRect;
    end;

    procedure CopyToBMP (aForm : TForm; aImage : TImage);
    begin
      aForm.Show;
      Application.ProcessMessages; //Keep!
      TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,aForm.Canvas,SourceRect);
      if (SourceRect.Width  <= Screen.Width) and
         (SourceRect.Height <= Screen.Height) then
        TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,aForm.Canvas,SourceRect)
      else
        TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,aImage.Canvas,SourceRect);
    end;

BEGIN


  frmPlayback.Stop.Down := True;
  frmPlayback.StopClick(Sender);
  DoCancel := False;
{-- First Assigns the Title and Filters of  OpenFileDialog}
if (sender = SaveAverageFileAsSPN) then Begin
  SaveFileDialog.Title := 'Save Average File';
  SaveFileDialog.Filter := 'Save Average File (*.ave)|*.ave';
  if (UseMoviFilePath = False) and (FilePaths.AverImFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.AverImFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.AverImFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle;
  end;
end else
if (sender = SaveSmallEventsMarkFile) then Begin
  SaveFileDialog.Title := 'Save Small Events in Mark File';
  SaveFileDialog.Filter := 'Save Mark File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MarkFilePath;
  SaveFileDialog.FileName := imFtitle + '_MarkSmEvCoor';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_MarkSmEvCoor';
  end;
end else
if (sender = SaveBigEventsMarkFile) then Begin
  SaveFileDialog.Title := 'Save Big Events in Mark File';
  SaveFileDialog.Filter := 'Save Mark File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MarkFilePath;
  SaveFileDialog.FileName := FilePaths.MarkFilePath + imFtitle + '_MarkBigEvCoor';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_MarkBigEvCoor';
  end;
end else
if (sender = SaveSpatialSpreadFile) then Begin
  SaveFileDialog.Title := 'Save Spatial Spread File';
  SaveFileDialog.Filter := 'Save Spatial Spread File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MarkFilePath;
  SaveFileDialog.FileName := FilePaths.MarkFilePath + imFtitle + '_SpatialSpread';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_SpatialSpread';
  end;
  //So far it will use FilePaths.MarkFilePath
end else
if (sender = SaveFreehandROISurface) then begin
  SaveFileDialog.Title := 'Save Surface File';
  SaveFileDialog.Filter := 'Save Surface File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MarkFilePath;
  SaveFileDialog.FileName := FilePaths.MarkFilePath + imFtitle + '_Surface';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Surface';
  end;
  //So far it will use FilePaths.MarkFilePath
end else
if (sender = SaveMeasuringLineFile) then begin
  SaveFileDialog.Title := 'Save Measuring Line Coordinates to File';
  SaveFileDialog.Filter := 'Save Measuring Line File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MarkFilePath;
  SaveFileDialog.FileName := FilePaths.MarkFilePath + imFtitle + '_MesLine';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_MesLine';
  end;
  //So far it will use FilePaths.MarkFilePath
end else

if (sender = SaveQueueFile) then Begin
  SaveFileDialog.Title := 'Save Queue File';
  SaveFileDialog.Filter := 'Save Queue File (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.QFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.QFilePath;
  SaveFileDialog.FileName := imFtitle + '_QF';
  end else
  if (UseMoviFilePath = True) or (FilePaths.QFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_QF';
  end;
end else
if (sender = SaveROIfile) then Begin
  SaveFileDialog.Title := 'Save ROI File';
  SaveFileDialog.Filter := 'Save ROI File (*.roi)|*.roi';
  if (UseMoviFilePath = False) and (FilePaths.ROIFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.ROIFilePath;
  SaveFileDialog.FileName := imFtitle + '_ROI';
  end else
  if (UseMoviFilePath = True) or (FilePaths.ROIFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_ROI';
  end;
end else
if (sender = SaveMetafIle) then Begin
  SaveFileDialog.Title := 'Time Series Plot Panel as Metafile';
  SaveFileDialog.Filter := 'Time Series Plot Panel (*.emf)|*.emf';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle + '_Plot';
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Plot';
  end;
End Else
if (sender = ExportPlot) then Begin
  SaveFileDialog.Title := 'Save Events Versus Time Plot';
  SaveFileDialog.Filter := 'Save Events Versus Time Plot (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.PLOTFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.PLOTFilePath;
  SaveFileDialog.FileName := imFtitle + '_Plot';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PLOTFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Plot';
  end;
end else
if (sender = ExportPlotAsPClampATF) then Begin
  SaveFileDialog.Title := 'Save Events Versus Time Plot as PClamp "ATF"';
  SaveFileDialog.Filter := 'Save Events Versus Time Plot (*.atf)|*.atf';
  if (UseMoviFilePath = False) and (FilePaths.PLOTFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.PLOTFilePath;
  SaveFileDialog.FileName := imFtitle + '_Plot';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PLOTFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Plot';
  end;
end else

if (sender = AreasOnly) then Begin
  SaveFileDialog.Title := 'Save Areas Only';
  SaveFileDialog.Filter := 'Save Areas (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.PeaksFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.PeaksFilePath;
  SaveFileDialog.FileName := imFtitle + '_AreasOnly';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PeaksFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_AreasOnly';
  end;
end else

if (sender = AreasROIXYandNrIntegrations) then Begin
  SaveFileDialog.Title := 'Save Areas & ROI X,Y and Number of Integrations';
  SaveFileDialog.Filter := 'Save Areas & ROI X, Y & Nr. Integr. (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.PeaksFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.PeaksFilePath;
  SaveFileDialog.FileName := imFtitle + '_Areas';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PeaksFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Areas';
  end;
end else

if (sender = ExportPeaks) then Begin
  SaveFileDialog.Title := 'Save Peaks from Total Trace';
  SaveFileDialog.Filter := 'Save Peaks (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.PeaksFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.PeaksFilePath;
  SaveFileDialog.FileName := imFtitle + '_Peaks';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PeaksFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Peaks';
  end;
end else

if (sender = ExportPeakMeans) then Begin
  SaveFileDialog.Title := 'Save Peak Means from Displayed Part of Trace';
  SaveFileDialog.Filter := 'Save Peak Means (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.PeakMeansFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.PeakMeansFilePath;
  SaveFileDialog.FileName := imFtitle + '_Peak_Means';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PeakMeansFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Peak_Means';
  end;
end else
          {----- BMPs---}
if (sender = SaveMainWindow) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Main Window' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selection from Main Window';
  SaveFileDialog.Filter := 'Save Main Window (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle;
  end;
end else

if (sender = SaveMergeWindow) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Merge Window' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selection from Merge Window';
  SaveFileDialog.Filter := 'Save Merge Window (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle;
  end;
end else

if (sender = SaveAverageImageAsBMP) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Average Image' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selection from Average Image';
  SaveFileDialog.Filter := 'Save Average Image (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle + '_Ave';
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Ave';
  end;
end else

if (sender = SaveSecondaryWindow) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Secondary Window' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selection from Secondary Window';
  SaveFileDialog.Filter := 'Save Secondary Window (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle;
  end;
end else

if (sender = SaveConsecutiveImages) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selected Consecutive Images from Main Window' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selected Consecutive Images from Main Window Cropped to Selection Frame';
  SaveFileDialog.Filter := 'Save Consecutive Images (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 1;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
end else
if (sender = SaveConsecutiveImagesfromMergeWindow) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selected Consecutive Images from Merge Window' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selected Consecutive Images from Merge Window Cropped to Selection Frame';
  SaveFileDialog.Filter := 'Save Consecutive Images (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 1;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
end else
if (sender = SaveConsecutiveImagesfrom2ndWindow) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selected Consecutive Images from Secondary Window' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Save Selected Consecutive Images from Secondary Window Cropped to Selection Frame';
  SaveFileDialog.Filter := 'Save Consecutive Images (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 1;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
end else
If (sender = Save3DWindowConsecutiveImages) then Begin
  SaveFileDialog.Title := 'Save 3D Consecutive Images';
  SaveFileDialog.Filter := 'Save 3D Consecutive Images (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 1;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
End else
//--------------------------------------------------------------------------//
if (sender = mnMakeMovie) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Create Movie from Main Window Selected Images' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Create Movie from Selected Images Cropped to Selection Frame';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 2;
  MovieFromWin := WINDOW_MAIN;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
end else
if (sender = mnMakeMoviefromMergeWindow) then Begin
  if not(frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Create Movie from Merge Window Selected Images' else
  if (frmImageControl.ubApplyFrame.Selected) then
  SaveFileDialog.Title := 'Create Movie from Merge Window Selected Images Cropped to Selection Frame';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 2;
  MovieFromWin := WINDOW_MERGE;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
end else
if (sender = mnMakeMoviefrom3D) then Begin
  SaveFileDialog.Title := 'Create MPEG Movie from 3D Window Selected Images';
  if (UseMoviFilePath = False) and (FilePaths.MultipleImagesFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.MultipleImagesFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.MultipleImagesFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle;
  end;
  ExportDial.DialogKind := 2;
  MovieFromWin := WINDOW_3D;
  Application.CreateForm(TfrmOKDlgNrImtoExp, frmOKDlgNrImtoExp);
  DoCancel := ExportDial.DoCancel;
end else
if (sender = SaveCalibrationBar) then Begin
  SaveFileDialog.Title := 'Save Calibration Bar';
  SaveFileDialog.Filter := 'Save Calibration Bar (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle + '_Bar';
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Bar';
  end;
End else

if (sender = SaveLineScanImageAsBMP) then Begin
  SaveFileDialog.Title := 'Save Line Scan Image';
  SaveFileDialog.Filter := 'Save Line Scan Image (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle + '_LS';
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_LS';
  end;
End else

if (sender = SaveLineScanPanel) then Begin
  SaveFileDialog.Title := 'Save Line Scan Panel';
  SaveFileDialog.Filter := 'Save Line Scan Panel (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle + '_LSpanel';
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_LSpanel';
  end;
End else

if (sender = SavePlotPanelAsBMP) then Begin
  SaveFileDialog.Title := 'Time Series Plot Panel';
  SaveFileDialog.Filter := 'Time Series Plot Panel (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle + '_Plot_Panel';
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle + '_Plot_Panel';
  end;
End Else
If (sender = Save3Dwindow) then Begin
  SaveFileDialog.Title := 'Save 3D Window';
  SaveFileDialog.Filter := 'Save 3D Window (*.bmp)|*.bmp';
  if (UseMoviFilePath = False) and (FilePaths.SingleImageFilePath <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.SingleImageFilePath;
  SaveFileDialog.FileName := imFtitle;
  end else
  if (UseMoviFilePath = True) or (FilePaths.SingleImageFilePath = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := imFtitle;
  end;
End Else

// ----------- End of BMPs ------------------------------------------------}

If (sender = SaveParFile) then Begin
  SaveFileDialog.FileName := SparkAnDir + 'SparkAn';
  SaveFileDialog.Title := 'Save Program Settings';
  SaveFileDialog.Filter := 'Save Program Settings (*.par)|*.par';
End else
if (sender = SavePlaylist) then Begin
  SaveFileDialog.Title := 'Save Playlist';
  SaveFileDialog.Filter := 'Save Playlist (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.ListOfFiles <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.ListOfFiles;
  SaveFileDialog.FileName := 'Playlist';
  end else
  if (UseMoviFilePath = True) or (FilePaths.ListOfFiles = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName := 'Playlist';
  end;
end else
if (sender = frmAndorImageDescr.btSave) then Begin
  SaveFileDialog.Title := 'Save Andor Tiff File Description';
  SaveFileDialog.Filter := 'Save Andor Tiff Description (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.AndorDescription <> '') then begin
  SaveFileDialog.InitialDir := FilePaths.AndorDescription;
  SaveFileDialog.FileName := imFtitle + '_Description';
  end else
  if (UseMoviFilePath = True) or (FilePaths.AndorDescription = '') then begin
  SaveFileDialog.InitialDir := ExtractFilePath(ImFname);
  SaveFileDialog.FileName :=  imFtitle + '_Description';
  end;
end;

 {--- End of Title and Filter Assignment -----------}
 {---------------------------------------------------------------------}

 If Not(DoCancel) and (SaveFileDialog.Execute = True) Then
 BEGIN

{---------------------------------------------------------------------}
If (sender = SaveParFile) then Begin  {saves Program Options}
   SaveFname                := SaveFileDialog.FileName;
   if ExtractFileExt(SaveFname) <> '.par' then SaveFname := SaveFname + '.par';
   WriteSparkAnPar(SaveFname);
   SaveFileDialog.InitialDir := ExtractFilePath(ImFname); {reverts to Image File Path}
End Else
{----------------------------------------------------------------------}
If (sender = SaveAverageFileAsSPN) then Begin
   FilePaths.AverImFilePath := ExtractFilePath(SaveFileDialog.FileName);
   SaveFname                := SaveFileDialog.FileName;
   if ExtractFileExt(SaveFname) <> '.ave' then SaveFname := SaveFname + '.ave';
   SaveAverImageAsSpnOwnFile(SaveFname);
End Else
{-----------------------------------------------------------------}

if (sender = SavePlaylist) then Begin

  FilePaths.ListOfFiles := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname             := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
  AssignFile(TxtFile, SaveFname);
  ReWrite(TxtFile);
  WriteLn(TxTFile,'SparkAn List of Files');
  For Cnt := 0 to High(strFileList) do Begin
    Write(TxTFile, FileTypeList[Cnt]);
    Write(TxTFile,' ');  {Reads Fine with Read Byte}
    WriteLn(TxTFile,strFileList[Cnt]);
  End;
  CloseFile(TxtFile);
  End Else If IsFileInUse(SaveFname) = True then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);
End Else

{-----------------------------------------------------------------}

If (sender = SaveQueueFile) Then Begin
  FilePaths.QFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname             := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
  AssignFile(TxtFile, SaveFname);
  ReWrite(TxtFile);
  {------- Writes Heather ---------}
  WriteStr := 'SparkAn Queue File';
  Writeln(TxTFile, WriteStr);
  WriteStr := IntToStr(Length(QFileList)) + Char(9);
  WriteStr := WriteStr + 'Number of Files';
  Writeln(TxTFile, WriteStr);
  {-------------------------}
  For Cnt := 0 to High(QFileList) Do Begin

  WriteStr := IntToStr(QFileList[Cnt].ColNr) + Char(9) + 'Column Number';
  Writeln(TxTFile, WriteStr);

  WriteStr := QFileList[Cnt].QFName;   {Full Path of File to be Analyzed}
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].FIndex) + Char(9) +
  'File Index: Single TIFF = 1, Stack of TIFFs = 2, BioRad = 3, Noran Prarie = 4,' +
   'StreamPix = 5, Collection of Andor Multiimage Tiffs  = 6, QED = 7, Noram SGI = 8, Zeiss = 9';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].ImToBeg + 1) + Char(9) + 'First Image';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].ImToEnd + 1) + Char(9) + 'Last Image';
  Writeln(TxTFile, WriteStr);

  // --- About Average Image ---//
  WriteStr := IntToStr(QFileList[Cnt].AverImKind) + Char(9) + 'Average Image Kind: No Average = 0, From Selected Images = 1, ' +
      'from File = 2, Will be Generated Excluding 1st Image = 4, Will be Generated Starting from 1st Image = 5';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].NrImInList) + Char(9) + 'Nr of Images for Average Image';
  Writeln(TxTFile, WriteStr);

  if QFileList[Cnt].NrImInList > 0 then Begin
     WriteStr := '';
     for i := 0 to High(QFileList[Cnt].ListOfIm) do begin
      if i < High(QFileList[Cnt].ListOfIm) then
     WriteStr := WriteStr + IntToStr(QFileList[Cnt].ListOfIm[i]+1) + Char(9) else
     WriteStr := WriteStr + IntToStr(QFileList[Cnt].ListOfIm[i]+1) + Char(9) + 'List of Images'
     end; {for}
  End Else
  WriteStr := 'Empty List of Images';
  Writeln(TxTFile, WriteStr);

  if (QFileList[Cnt].AvFName <> '') then
    WriteStr := QFileList[Cnt].AvFName
  else
    WriteStr := '/No Average File/';
  Writeln(TxTFile, WriteStr);
  // --- End of Average Image paragraph ---/

  //--- Form Image Control settings ---//
  WriteStr := IntToStr(QFileList[Cnt].BackGr) + Char(9) + 'Background';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].ImCutoff) + Char(9) + 'Image Cutoff';
  Writeln(TxTFile, WriteStr);

  //writes all tree ImageContrVar ( Record ) members
  WriteStr := IntToStr(QFileList[Cnt].ImageContrVar.BackGrMax) + Char(9) + 'Background Max';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].ImageContrVar.CutOffMax) + Char(9) + 'CutOff Max';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].ImageContrVar.MaxGamma) + Char(9) + 'Gamma Max'; //not really neaded for analysis
  Writeln(TxTFile, WriteStr);

  //Smoothing
  WriteStr := IntToStr(QFileList[Cnt]. SmoothMode) + Char(9) + 'Smooth Mode: 1st Box then Median = 2, 1st Medium then Box = 4, 1st Gaussian then Median = 6, 1st Median then Gaussian = 7';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].SmoothOrder) + Char(9) + 'Smooth Order:  1st Box or Gaussian = 0, 1st Median = 1';
  Writeln(TxTFile, WriteStr);

  if (QFileList[Cnt].SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX]) then
    WriteStr := IntToStr(QFileList[Cnt].BoxCarF) + Char(9) + 'Boxcar Filter Size: 3x3 = 3, 5x5 = 5, 7x7 = 7'
    else
  if (QFileList[Cnt].SmoothMode in [SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then
    WriteStr := IntToStr(QFileList[Cnt].GaussF) + Char(9) + 'Gaussian Filter Size: 3x3 Lite = 1, 3x3 Medium = 2, 3x3 Heavy = 3, 5x5 = 5, 7x7 = 7';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(QFileList[Cnt].MedianF) + Char(9) + 'Median Filter Size: 3x3 = 3, 5x5 = 5, 7x7 = 7';
  Writeln(TxTFile, WriteStr);

  if (QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio) then
  WriteStr := 'Smooth Before Doing Ratio' else WriteStr := 'Smooth After Doing Ratio';
  Writeln(TxTFile, WriteStr);

  //End of Smoothing

  if (QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio) then  WriteStr := 'Yes' else
  if (QFileList[Cnt].AutoSrchPar.SmoothBeforeDoRatio) then  WriteStr := 'No';
  Writeln(TxTFile, WriteStr);

  if (QFileList[Cnt].ApplyFrame = False) then  WriteStr := 'No Frame Selection'
  else                                         WriteStr := 'Follows Frame Selection';
  Writeln(TxTFile, WriteStr);

  if (QFileList[Cnt].ApplyFrame = False) then
  WriteStr := '0' + Char(9) + '0' + Char(9) + '0' + Char(9) + '0'
  else
  WriteStr := IntToStr(QFileList[Cnt].SelFrame.Left) + Char(9) +
              IntToStr(QFileList[Cnt].SelFrame.Right) + Char(9) +
              IntToStr(QFileList[Cnt].SelFrame.Top) + Char(9) +
              IntToStr(QFileList[Cnt].SelFrame.Bottom) + Char(9) + 'Xl-Xr,Ytop-Ybottom';
  Writeln(TxTFile, WriteStr);
 //--- End of Form Image Control Settings -----//

 With QFileList[Cnt].AutoSrchPar Do Begin
  //Scanning
  WriteStr := IntToStr(Thresh) + Char(9) + 'Threshold';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(Tolerance) + Char(9) + '% pixels > Threshold (Tolerance)';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(ScanBoxSize) + Char(9) + 'Scan Box Size';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(MaxArea) + Char(9) + 'Max Event Area';
  Writeln(TxTFile, WriteStr);

  //big events search variables
  if (UseRunAver)  then WriteStr := 'Running Average' else  WriteStr := 'No Running Average';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(NrImRunAver) + Char(9) + 'Number of Images for Running Average';
  Writeln(TxTFile, WriteStr);

  if (IgnoreBigEv)  then WriteStr := 'Ignore Big Events' else  WriteStr := 'Get Big Events';
  Writeln(TxTFile, WriteStr);

  //small events test
  if (TestSmallEv) then WriteStr := 'Test Small Events' else WriteStr := 'No Small Events Test';
  Writeln(TxTFile, WriteStr);

  if (GetSmEvDur) then WriteStr := 'Get Small Events Duration' else WriteStr := 'Do Not Get Small Events Duration';
  Writeln(TxTFile, WriteStr);

  if (GetBigEvDur) then WriteStr := 'Get Big Events Duration' else WriteStr := 'Do Not Get Big Events Duration';
  Writeln(TxTFile, WriteStr);

  //-------- Auto Average Generation -----------//
  if (AutoAverImage) then WriteStr := 'Auto Average Image' else WriteStr := 'No Auto Average Image';
  Writeln(TxTFile, WriteStr);  //Check Box

  WriteStr := IntToStr(NrImForCreateAvIm) + Char(9) + 'Number of Images to Generate Auto Average';
  Writeln(TxTFile, WriteStr);  //Slider

  WriteStr := IntToStr(AutoAverNrImInc) + Char(9) + 'Generate Average Every ' + IntToStr(AutoAverNrImInc) + ' images';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(AutoAverImRange) + Char(9) + 'Range of Images Used to Generate Average';
  Writeln(TxTFile, WriteStr);

  if (StartAutoAverFirstIm) then WriteStr := 'Start Auto Average from 1st Image' else WriteStr := 'Do Not Start Auto Average from 1st Image';
  Writeln(TxTFile, WriteStr);

  if (SaveAutoAver) then WriteStr := 'Save Auto Average' else WriteStr := 'Do Not Save Auto Average';
  Writeln(TxTFile, WriteStr);

  //-  End of Auto Average Generation ----------//

  if (UpdateRatio) then WriteStr := 'Update F/Fo' else WriteStr := 'Do Not Update F/Fo';
  Writeln(TxTFile, WriteStr);

  if not(UseCustomROIforSmEvTest) then WriteStr := 'Use Scan Box for Small Events Test' else WriteStr := 'Use Custom ROI for Small Events Test';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(ROISizeForSmEvTest) + Char(9) + 'Custom ROI Size for Small Events Test';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(NrImGetMinLeft) + Char(9) + 'Nr of Images to find Baseline (Min) to the Left of Event';
  Writeln(TxTFile, WriteStr);

  if (SDuse) then WriteStr := 'Use SD of Baseline for Small Events Test' else WriteStr := 'Do Not Use SD of Baseline for Small Events Test';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(SDfold) + Char(9) + 'Fold SD of Baseline to the Left of Event';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(NrImGetMinRight) + Char(9) + 'Nr of Images to find Baseline (Min) to the Right of Event';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(SearchLms) + Char(9) + 'ms to Search Left of Peak';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(SearchRms) + Char(9) + 'ms to Search Right of Peak';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(NrImToLeftOfEv) + Char(9) + 'Nr of Images to the Left of Event';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(NrImToRightOfEv) + Char(9) + 'Nr of Images to the Right of Event';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(PLval) + Char(9) + '% value of points to the Left of Event';
  Writeln(TxTFile, WriteStr);

  WriteStr := IntToStr(PRval) + Char(9) + '% value of points to the Right of Event';
  Writeln(TxTFile, WriteStr);

 End; //With QFileList[Cnt].AutoSrchPar Do Begin


  {-------------------------}
  if Cnt = High(QFileList) then WriteStr := 'End'
                           else WriteStr := 'Next File';
  Writeln(TxTFile, WriteStr);

  End; {for Cnt := to High(QFileList); }
  CloseFile(TxtFile);
  End Else If IsFileInUse(SaveFname) = True then
  MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);
End Else

{------------------------------------------------------------------}

If (sender = SaveROIfile) then Begin
    {1st: Takes Care of Extension Duplication}
   FilePaths.ROIFilePath := ExtractFilePath(SaveFileDialog.FileName);
   SaveFname             := SaveFileDialog.FileName;
   if ExtractFileExt(SaveFname) <> '.roi' then SaveFname := SaveFname + '.roi';

    {end of extension care}
   {2nd: Opens a Binary File}
   AssignFile(BinFile, SaveFname);
   ReWrite(BinFile,1); {1 byte blocks}

   {3rd: write the Type of the File}
   WriteStr := 'SparkanROI'; {The Older Type was SparkAnROI';}
   FPos :=  0;
   Seek(BinFile,FPos);
   pWriteStr  := @WriteStr[1];  {Sets Pointer at Fist character in String}
   BlockWrite(BinFile,pWriteStr^,Length(WriteStr));  {Don't miss " ^ " }
   {Starts Writing DATA}
   {4rth : Image X and Y; Writes Integers as Word to save space}
     {X}
   FPos :=  FPos + Length(WriteStr);
   Seek(BinFile,FPos);
   TempWord := imXSize;
   BlockWrite(BinFile,TempWord,SizeOf(TempWord));
     {Y}
   FPos :=  FPos + SizeOf(TempWord);
   Seek(BinFile,FPos);
   TempWord := imYSize;
   BlockWrite(BinFile,TempWord,SizeOf(TempWord));
   {5th: Writes Nr of ROI}
   FPos :=  FPos + SizeOf(TempWord);
   Seek(BinFile,FPos);
   TempByte := ROIvar.NrROI;
   BlockWrite(BinFile,TempByte,SizeOf(TempByte));
   {6th: Writes Each ROI Address}
   For i := 1 to 20 do Begin
    FPos :=  FPos + SizeOf(TempByte);
    Seek(BinFile,FPos);
    TempByte := ROIvar.ROIAdr[i];
    BlockWrite(BinFile,TempByte,SizeOf(TempByte));
   End; {For}
    {7th: Zeroes Data Offset Array}
   For i := 1 to 20 do Begin
    DataOffset[i] := 0;
   End;
   {--------------------------------------}
    {8th: Writes Data Size to DataOffset array}
   For CntROI := 1 to 19 do Begin  {to 19 because -> CntROI + 1}
    if ROIvar.ROIAdr[CntROI] = 1 then
    DataOffset[CntROI + 1] := 4*2 {converts to bytes 4 words} else
    If ROIvar.ROIAdr[CntROI] = 3 {Free Hand} then Begin
      TempWord := Length(FhPol[CntROI]);  {To Call Length is OK if Array is not Empty}
      for CntY := 0 to High(FhTbl[CntROI]) do
        TempWord := TempWord + Length(FhTbl[CntROI,CntY]);
      TempWord := TempWord*2; {FhPol & FhTbl are TPoint arrays}
      {2 is for NrPoints and Nr of Points [in FhPol] and Nr of Rows [Ys in FhTbl]}
      TempWord := TempWord + 2;
      {adds Number of Rows which will be used to Write Nr of Xs in each Row}
      TempWord := TempWord + Length(FhTbl[CntROI]);
      DataOffset[CntROI + 1] := TempWord*2; {converts to Bytes}
    End;  {Free Hand}
   End;  {End of 8th: Writes Data Size}
    {--------------------------------------}
     {9th: Summes Cumulatively Data Sizes}
   For i := 2 to 20 do Begin
    DataOffset[i] := DataOffset[i] + DataOffset[i-1];
   End;

     {10th: Calculates Offset: Subtracts First Data Size from all}
                                              {and adds the FPos }
      FPos :=  FPos + SizeOf(TempByte);
     {FPos = 35; Always= Fixed}
   For i := 1 to 20 do Begin
    DataOffset[i] := DataOffset[i] + Fpos + SizeOf(DataOffset);
   End;

     {11th: Writes Offset to File}
   Seek(BinFile,FPos);
   BlockWrite(BinFile,DataOffset,SizeOf(DataOffset));
   {SizeOf(DataOffset)   = 80 }
   {This Always Ends in FPos = 114}
   {First Element of DataOffset starts at FPos = 35}
   {so Data Starts from FPos = 35 + 80 = 115 [fixed=always]}

   {12 : writes Data}
   For CntROI := 1 to 20 do Begin
    If ROIvar.ROIAdr[CntROI] = 1 then Begin
      SetLength(WordArr,4);
      For i := 0 to 3 do WordArr[i] := ROIvar.ROICoor[i+1,CntROI];
      FPos := DataOffset[CntROI];
      Seek(BinFile,FPos);
      BlockWrite(BinFile,WordArr[0],Length(WordArr)*2);
    End Else
    If ROIvar.ROIAdr[CntROI] = 3 {Free Hand} then Begin
      {writes Nr of Points and Nr of Raws}
      SetLength(WordArr,2);
      WordArr[0] := Length(FhPol[CntROI]); {Nr of Points}
      WordArr[1] := Length(FhTbl[CntROI]); {Nr of Rows}
      FPos := DataOffset[CntROI];
      Seek(BinFile,FPos);
      BlockWrite(BinFile,WordArr[0],Length(WordArr)*2);
      {writes Polygon array- 1st X, then Y}
          {X}
      FPos := FPos + Length(WordArr)*2; {increments FPos}
      SetLength(WordArr,Length(FhPol[CntROI]));
      for Cnt := 0 to High(FhPol[CntROI]) do WordArr[Cnt] := FhPol[CntROI,Cnt].X;
      Seek(BinFile,FPos);
      BlockWrite(BinFile,WordArr[0],Length(WordArr)*2);
      { Y}
      FPos := FPos + Length(WordArr)*2; {increments FPos}
      {Array length is the Same for Xs and Ys}
      for Cnt := 0 to High(FhPol[CntROI]) do WordArr[Cnt] := FhPol[CntROI,Cnt].Y;
      Seek(BinFile,FPos);
      BlockWrite(BinFile,WordArr[0],Length(WordArr)*2);
      {Writes FhTable array}

      For CntY := 0 to High(FhTbl[CntROI]) do Begin
        {writes Nr of Xses}
        TempWord := Length(FhTbl[CntROI,CntY]);
        FPos := FPos + Length(WordArr)*2; {increments FPos}
        Seek(BinFile,FPos);
        BlockWrite(BinFile,TempWord,SizeOf(TempWord));
        {writes Data for each Row, First X then Y}
        SetLength(WordArr,TempWord);
         {Xs }
        for CntX := 0 to High(FhTbl[CntROI,CntY]) do
          WordArr[CntX] := FhTbl[CntROI,CntY,CntX].X;
          FPos := FPos + 2;
          Seek(BinFile,FPos);
          BlockWrite(BinFile,WordArr[0],Length(WordArr)*2);
         {Ys}
        for CntX := 0 to High(FhTbl[CntROI,CntY]) do
          WordArr[CntX] := FhTbl[CntROI,CntY,CntX].Y;
          FPos := FPos + Length(WordArr)*2;
          Seek(BinFile,FPos);
          BlockWrite(BinFile,WordArr[0],Length(WordArr)*2);
      End; {For CntY := 0 to High(FhTbl[CntROI]) do Begin}
    End;  {Free Hand}
   End;
   {End of 12: writing Data}
   CloseFile(BinFile);
End Else
{------------------------------------------------------------------}
If (sender = SaveSmallEventsMarkFile) or (sender = SaveBigEventsMarkFile) then Begin
  FilePaths.MarkFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname              := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  WriteEvents := True;

  {------------------ Comment Section -----------------------------}
  if (MarkPar.GenAutoSearchComm) or (MarkPar.GenGenSetComm) then
    File_Comment := CreateMarkComment(MarkPar.GenGenSetComm,MarkPar.GenAutoSearchComm) else File_Comment := '';
  if MarkPar.PromptForComment then
    Application.CreateForm(TfrmMarkComment, frmMarkComment);
  {----------------end of Comment Secxtion ------------------------}
  If (sender = SaveSmallEventsMarkFile) then Begin
    WriteStr := 'SparkAn Mark File Small Events v.3'; //was v.2 changed to v.3 to accomodate Tag column only in Small events Table
    WriteMarkFile(SaveFname, WriteStr, MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,File_Comment,WriteEvents);
  End Else
  If (sender = SaveBigEventsMarkFile)   then Begin
    WriteStr := 'SparkAn Mark File Big Events v.2';
    WriteMarkFile(SaveFname, WriteStr, MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,File_Comment,WriteEvents);
  End;
  
End Else
{------------------------------------------------------------------}
If (Sender = SaveSpatialSpreadFile) then begin
  FilePaths.MarkFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname              := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn Spatial Spread File';
    Writeln(TxTFile, WriteStr);
    {2nd: wrires NrIm in File, and what was written}
    WriteStr := 'Originates From: ' + ImFtitle;
    Writeln(TxTFile, WriteStr);
    {3d: Smoothing and Amplitude measuring rectangle X & Y}
    WriteStr := 'Measuring rectangle X x Y = ' + IntToStr(SpreadMesRect.X) + ' x ' +
                 IntToStr(SpreadMesRect.Y) +
                 ', Bfilt=' + IntToStr(BoxSmSize) + ', Mfilt=' + IntToStr(MedSmSize) +
                ', Bkg=' + IntToStr(Bkg) + ', Cutoff=' + IntToStr(CutOff) +
                '. File has ' + IntToStr(NrIm) + ' images.';
    Writeln(TxTFile, WriteStr);
    {4th: what was written}
    WriteStr := 'Follow Data for: Row#, Im#, X, Y, Ampl, Spread (' + Chr(181) + 'm ' + Chr(178) + ') for Im# and following Images if requested';
    Writeln(TxTFile, WriteStr);
    if (frmSpatialSpread <> nil) then with frmSpatialSpread.StrGdrSpatialSpread do begin
      for Cnt := 1 to RowCount - 1 do begin
        WriteStr := IntToStr(Cnt) + Char(9) + Cells[1,Cnt] + Char(9) + Cells[2,Cnt] +
                    Char(9) + Cells[3,Cnt] + Char(9) + Cells[4,Cnt] + Char(9) + Cells[5,Cnt];
        if (ColCount > 6) then for CntX := 6 to ColCount - 1 do begin
          if (Cells[CntX,Cnt] <> '') then WriteStr := WriteStr + Char(9) + Cells[CntX,Cnt] else
                                          WriteStr := WriteStr + Char(9) + '-';
        end;

        Writeln(TxTFile, WriteStr);
      end; //for Cnt := 1 to RowCount - 1
    end
      else
    if (frmSpatialSpread = nil) then begin
      for Cnt := 0 to High(SpreadImNr) do begin
        WriteStr := IntToStr(Cnt+1) + Char(9) + IntToStr(SpreadImNr[Cnt]) + Char(9) +
                    IntToStr(SpreadCoor[Cnt].X) + Char(9) + IntToStr(SpreadCoor[Cnt].Y) + Char(9) +
                    FloatToStrF(SpreadAmpl[Cnt],ffFixed,5,3);
        for CntX := 0 to High(SpreadSurface[0]) do begin
          if (SpreadSurface[Cnt,CntX] <> -1) then
            WriteStr := WriteStr + Char(9) +  FloatToStrF(SpreadSurface[Cnt,CntX],ffFixed,6,3) else
            WriteStr := WriteStr + Char(9) + '-';
        end;

        Writeln(TxTFile, WriteStr);
      end;
    end; //if (frmSpatialSpread = nil)
    CloseFile(TxtFile);
  End; // If IsFileInUse(SaveFname) = False
End else
 {---------------------------------------------------------------------}
If (sender = SaveFreehandROISurface) then Begin
  FilePaths.MarkFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname              := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn Surface (of Freehand ROIs) File';
    Writeln(TxTFile, WriteStr);
    {2nd: wrires NrIm in File, and what was written}
    WriteStr := 'Originates From: ' + ImFtitle;
    Writeln(TxTFile, WriteStr);
    {3rd: wtites explanation of order of data}
    WriteStr := 'Follow Data for: Freehand ROI# and Surface (' + Chr(181) + 'm ' + Chr(178) + ')';
    Writeln(TxTFile, WriteStr);
    {4th: writes data}
    with frmSurfaceROI.SurfaceStringGrid do begin
      for Cnt := 1 to RowCount - 1 do begin
        WriteStr := Cells[0,Cnt] + Char(9) + Cells[1,Cnt];
        Writeln(TxTFile, WriteStr);
      end; //for Cnt := 1 to RowCount - 1
    end;
    CloseFile(TxtFile);

  End;
End Else
{---------------------------------------------------------------------}
If (sender = SaveMeasuringLineFile) then Begin
  FilePaths.MarkFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname              := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn Measuring Line Coordinates File';
    Writeln(TxTFile, WriteStr);
    {2nd: wrires NrIm in File, and what was written}
    WriteStr := 'Originates From: ' + ImFtitle;
    Writeln(TxTFile, WriteStr);
    {3rd: wtites explanation of order of data}
    WriteStr := 'Follow Data for: X1, Y1, X2, Y2';
    Writeln(TxTFile, WriteStr);
    {4th: writes data}

    
    with MesLine do
      WriteStr := IntToStr(LineBeg.X) + Char(9) + IntToStr(LineBeg.Y) + Char(9) +
                  IntToStr(LineEnd.X) + Char(9) + IntToStr(LineEnd.Y);


    Writeln(TxTFile, WriteStr);

    CloseFile(TxtFile);

  End;
End Else


{---------------------------------------------------------------------}


If (sender = ExportPeaks) then Begin
  FilePaths.PeaksFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname               := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
  AssignFile(TxtFile, SaveFname);
  ReWrite(TxtFile);
  {1st Line: Writes F Name}
  if (NrChannels = 1) then
      WriteStr := PLOT_FTitle;
  if (NrChannels = 2) then begin
        if (ChannelOrder = ASCENDING)  then
        WriteStr := PLOT_FTitle + ', Channel One' else
        if (ChannelOrder = DESCENDING)  then
        WriteStr := PLOT_FTitle + ', Channel Two';
   end;

  Writeln(TxTFile,'SparkAn "Peaks" Data extracted from: ' + WriteStr +
  ', Images: ' + IntToStr(PLOTvar.ImBeg + 1) + ' to ' + IntToStr(PLOTvar.ImEnd + 1) +
  ', Time = ' +
  FloatToStr(CopyOfTimeSt[High(CopyOfTimeSt)]-CopyOfTimeSt[0]) + ' s' +
  ', Threshold (F/Fo) = ' + FloatToStrF(ROIvar.PeakThreshUsed/100,ffFixed,3,2));

  {2nd line: Writes Type of Ratio Done}
   WriteStr := 'Analysis Type: ' + PLOTvar.Title;

  if (PLOTvar.BaseLineStatus in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      WriteStr := WriteStr + ' (' + IntToStr(PLOTvar.BaseLinePoints)+ '*'+ IntToStr(PLOTvar.NrScanes) + ' points' +
      ', LSD = ' + FloatToStrF(PLOTvar.LSD,ffFixed,1,1) +
      ', RSD = ' + FloatToStrF(PLOTvar.RSD,ffFixed,1,1) + ')'
  else WriteStr := WriteStr + ', Continuous Baseline Not used';

  if (PLOTvar.GetEachPeakBase) then
      WriteStr := WriteStr + ', Individual Baseline for Each Peak Subtracted ( found in ' + IntToStr(PLOTvar.EachPeakBaseRg) +
      ' ms before Peak as Mean of ' + IntToStr(PLOTvar.EachPeakBasePt) + ' points'
        else
      WriteStr := WriteStr + ', Individual Baseline for Each Peak Not used';

  WriteStr := WriteStr + '; ' + GetFilterSize;

  Writeln(TxTFile, WriteStr);

  {3nd Line: Writes What was done}
  TrUsed := 0;
  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Inc(TrUsed);
  End;
  Writeln(TxTFile,
  'Data from a Trace make 7 Columns: Trace #, Mean Frequency (Hz), Peak Image Nr, Ampl (F/Fo), Rise Time (10%-90%) (s), Duration at 1/2 ampl (s), t1/2 (s) '
   + ' from ' + IntToStr(TrUsed) + ' ROI');

  {4nd Line: writes ROI kind}
       FirstTime := True; {means if First ROI [that appears First]}
  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If FirstTime = True Then Begin
        if PLOTvar.ROIkind[Cnt] = 1 then WriteStr := 'ROI kind:  Rectangular' else
        if PLOTvar.ROIkind[Cnt] = 2 then WriteStr := 'ROI kind:  Ellipse' else
        if PLOTvar.ROIkind[Cnt] = 3 then WriteStr := 'ROI kind:  Free Hand' else
        if PLOTvar.ROIkind[Cnt] = 4 then WriteStr := 'ROI kind:  Line Scan';
        FirstTime := False;
      End Else
      If FirstTime = False Then Begin
        if PLOTvar.ROIkind[Cnt] = 1 then WriteStr := WriteStr + ', Rectangular' else
        if PLOTvar.ROIkind[Cnt] = 2 then WriteStr := WriteStr + ', Ellipse' else
        if PLOTvar.ROIkind[Cnt] = 3 then WriteStr := WriteStr + ', Free Hand' else
        if PLOTvar.ROIkind[Cnt] = 4 then WriteStr := WriteStr + ', Line Scan';
      End; { FirstTime = False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0}
  End; {For Cnt := 0 to PLOTvar.NrROI -1}
   Writeln(TxTFile,WriteStr);
   {5rth Line: writes X size(s)}
      FirstTime := True;
  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
     If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If FirstTime = True Then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := 'X & Y size (pix): ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                                'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
   WriteStr := 'X & Y size (pix): Free Hand';
         FirstTime := False;
      End else
      If FirstTime = False Then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
    WriteStr := WriteStr + '; ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                            'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
    WriteStr := WriteStr +  '; Free Hand';
      End; {False}
     End; {PLOTvar.AdrUsed[CntROI] > 0}
  End;
  Writeln(TxTFile,WriteStr);
  {6th Line: writes X & Y centers (pix)}

       FirstTime := True;

  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If (FirstTime = True) then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := 'Color # & (X,Y) center (pix): Color # '
               + IntToStr(PLOTvar.AdrUsed[Cnt]) + ' ('
               + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
               ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := 'Color # & (X,Y) center (pix): Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
        FirstTime := False;
      End Else
      If (FirstTime = False) then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := WriteStr + ';  Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]) + ' ('
                     + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
                    ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := WriteStr + '; Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
      End; {False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0 }
  End;
  Writeln(TxTFile,WriteStr);

 {---End of Heather--(6 Lines}

 {Check for the Longest Nr of Peaks}
           ToEnd := 0;
  For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
    If (PLOTvar.AdrUsed[CntROI] > 0) then Begin
     If High(PeakPosArr[CntROI]) > -1 then Begin
        if ToEnd < High(PeakPosArr[CntROI]) then ToEnd := High(PeakPosArr[CntROI]);
     End;
    End;
  End;
 {---------------------------------------------------}

  For ImNr := 0 to ToEnd Do Begin
         FirstTime := True;

    For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
      If (PLOTvar.AdrUsed[CntROI] > 0) then Begin
          {Writes Frequency (Hz); Only First Row}
           If ImNr = 0 then Begin
            if (High(PeakPosArr[CntROI]) > -1) then
             FrHz := FloatToStrF(Length(PeakPosArr[CntROI])/(CopyOfTimeSt[High(CopyOfTimeSt)]-CopyOfTimeSt[0]),ffFixed,10,6) else
            FrHz := '0';
           End Else FrHz := '-';
           {Writes ROI number}
         if FirstTime = True  then begin
            WriteStr  := IntToStr(PLOTvar.AdrUsed[CntROI]) + Chr(9) + FrHz;
            FirstTime := False;
         end else
         if FirstTime = False then
          WriteStr  := WriteStr + Chr(9) + IntToStr(PLOTvar.AdrUsed[CntROI]) +
                       Chr(9) + FrHz;

       if (High(PeakPosArr[CntROI]) > -1) and (ImNr <= High(PeakPosArr[CntROI])) then begin

          if (RiseTimeArr[CntROI,ImNr] > CANNOT_BE_DONE) then
          RiseT := RiseTimeArr[CntROI,ImNr] else
          RiseT := 0;

          if (PeakTimArr[CntROI,ImNr].L > CANNOT_BE_DONE) and
             (PeakTimArr[CntROI,ImNr].R > CANNOT_BE_DONE) then
          Dur := PeakTimArr[CntROI,ImNr].R - PeakTimArr[CntROI,ImNr].L else
          Dur := 0;

          if (PeakTimArr[CntROI,ImNr].R > CANNOT_BE_DONE) then
          Decay := PeakTimArr[CntROI,ImNr].R -
                   CopyOfTimeSt[PeakPosArr[CntROI,ImNr]]  else
          Decay := 0;

           {1 = image Nr of the Peak}
          WriteStr := WriteStr + Chr(9) + IntToStr(PeakPosArr[CntROI,ImNr] + 1 + PLOTvar.ImBeg) + Chr(9) +
          { 2 = amplitude}   {ScaleRat is Const = 10}
          FloatToStrF((PeakValArr[CntROI,ImNr]-(PeakBasArr[CntROI,ImNr]-10))/ScaleRat,ffFixed,5,6);

          if RiseT > 0 then
          WriteStr := WriteStr + Chr(9) + FloatToStrF(RiseT,ffFixed,10,6) else
          WriteStr := WriteStr + Chr(9) + '-';

          if Dur > 0 then
          WriteStr := WriteStr + Chr(9) + FloatToStrF(Dur,ffFixed,10,6) else
          WriteStr := WriteStr + Chr(9) + '-';

          if Decay > 0 then
          WriteStr := WriteStr + Chr(9) + FloatToStrF(Decay,ffFixed,10,6) else
          WriteStr := WriteStr + Chr(9) + '-';

        end
        else  if (High(PeakPosArr[CntROI]) = -1) or
          ((High(PeakPosArr[CntROI]) > -1) and (ImNr > High(PeakPosArr[CntROI]))) then
            WriteStr := WriteStr + Chr(9) + '-' + Chr(9) + '-' + Chr(9) + '-' + Chr(9) + '-' + Chr(9) + '-';

      End; {If (PLOTvar.AdrUsed[CntROI] > 0}


    End; {For CntROI := 0 to (PLOTvar.NrROI - 1)}
       WriteLn(TxTFile, WriteStr);
   End;  {For ImNr := 0 to ToEnd}

      CloseFile(TxTFile);
   End Else If IsFileInUse(SaveFname) = True then
   MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

End Else
{------------------------------------------------------------------}
If (sender = ExportPeakMeans) Then Begin
  FilePaths.PeakMeansFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname                   := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
  AssignFile(TxtFile, SaveFname);
  ReWrite(TxtFile);
  Beg   := frmTimeSerPlot.dsXaxes.PosFrom; //beg of Displayed Portion of File
  ToEnd := frmTimeSerPlot.dsXaxes.PosTo;  //end of displayed Portion of File
  // Analysed Portion is Given by:   PLOTvar.ImBeg + 1 and  PLOTvar.ImEnd + 1
  {1st Line: Writes F Name}

 if (NrChannels = 1) then
      WriteStr := PLOT_FTitle;
 if (NrChannels = 2) then begin
        if (ChannelOrder = ASCENDING)  then
        WriteStr := PLOT_FTitle + ', Channel One' else
        if (ChannelOrder = DESCENDING)  then
        WriteStr := PLOT_FTitle + ', Channel Two';
  end;

  Writeln(TxTFile,'SparkAn "Peak Means" Data extracted from: ' + WriteStr +
  ', Images: ' + IntToStr(Beg + 1) + ' to ' + IntToStr(ToEnd + 1) +
  ', Time = ' +
  FloatToStr(CopyOfTimeSt[ToEnd-PLOTvar.ImBeg]-CopyOfTimeSt[Beg-PLOTvar.ImBeg]) + ' s' +
  ', Threshold (F/Fo) = ' + FloatToStrF(ROIvar.PeakThreshUsed/100,ffFixed,3,2));
  {2nd line: Writes Type of Ratio Done}
  WriteStr := 'Analysis Type: ' + PLOTvar.Title;

  if (PLOTvar.BaseLineStatus in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      WriteStr := WriteStr + ' (' + IntToStr(PLOTvar.BaseLinePoints)+ '*'+ IntToStr(PLOTvar.NrScanes) + ' points' +
      ', LSD = ' + FloatToStrF(PLOTvar.LSD,ffFixed,1,1) +
      ', RSD = ' + FloatToStrF(PLOTvar.RSD,ffFixed,1,1) + ')'
  else WriteStr := WriteStr + ', Continuous Baseline Not used';

  if (PLOTvar.GetEachPeakBase) then
      WriteStr := WriteStr + ', Individual Baseline for Each Peak Subtracted ( found in ' + IntToStr(PLOTvar.EachPeakBaseRg) +
      ' ms before Peak as Mean of ' + IntToStr(PLOTvar.EachPeakBasePt) + ' points'
        else
      WriteStr := WriteStr + ', Individual Baseline for Each Peak Not used';

  WriteStr := WriteStr + '; ' + GetFilterSize;

  Writeln(TxTFile, WriteStr);

  {3rd Line: Writes What was done}
  TrUsed := 0;
  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Inc(TrUsed);
  End;
  Writeln(TxTFile,
  'All Data from a Trace makes 7 Columns: Trace #, Means of: Frequency (Hz), Nr of Peaks, Ampl (F/Fo), Rise Time (10%-90%) (s), Dur at 1/2 ampl(s), t1/2 (s) '
  + ' from ' + IntToStr(TrUsed) + ' ROI');

  {4th Line: writes ROI kind}
       FirstTime := True; {means if First ROI [that appears First]}
  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If (PLOTvar.AdrUsed[Cnt] > 0) then Begin
      If (FirstTime) Then Begin
        if PLOTvar.ROIkind[Cnt] = 1 then WriteStr := 'ROI kind:  Rectangular' else
        if PLOTvar.ROIkind[Cnt] = 2 then WriteStr := 'ROI kind:  Ellipse' else
        if PLOTvar.ROIkind[Cnt] = 3 then WriteStr := 'ROI kind:  Free Hand' else
        if PLOTvar.ROIkind[Cnt] = 4 then WriteStr := 'ROI kind:  Line Scan';
        FirstTime := False;
      End Else
      If not(FirstTime) Then Begin
        if PLOTvar.ROIkind[Cnt] = 1 then WriteStr := WriteStr + ', Rectangular' else
        if PLOTvar.ROIkind[Cnt] = 2 then WriteStr := WriteStr + ', Ellipse' else
        if PLOTvar.ROIkind[Cnt] = 3 then WriteStr := WriteStr + ', Free Hand' else
        if PLOTvar.ROIkind[Cnt] = 4 then WriteStr := WriteStr + ', Line Scan';
      End; { FirstTime = False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0}
  End; {For Cnt := 0 to PLOTvar.NrROI -1}
   Writeln(TxTFile,WriteStr);
   {5th Line: writes X size(s)}
      FirstTime := True;
  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
     If (PLOTvar.AdrUsed[Cnt]) > 0 then Begin
      If (FirstTime) Then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := 'X & Y size (pix): ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                                'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
   WriteStr := 'X & Y size (pix): Free Hand';
         FirstTime := False;
      End else
      If not(FirstTime) Then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
    WriteStr := WriteStr + '; ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                            'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
    WriteStr := WriteStr +  '; Free Hand';
      End; {False}
     End; {PLOTvar.AdrUsed[CntROI] > 0}
  End;
  Writeln(TxTFile,WriteStr);
  {6th Line: writes X & Y centers (pix)}

       FirstTime := True;

  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If (FirstTime) then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := 'Color # & (X,Y) center (pix): Color # '
               + IntToStr(PLOTvar.AdrUsed[Cnt]) + ' ('
               + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
               ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := 'Color # & (X,Y) center (pix): Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
        FirstTime := False;
      End Else
      If (FirstTime = False) then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := WriteStr + ';  Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]) + ' ('
                     + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
                    ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := WriteStr + '; Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
      End; {False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0 }
  End;
  Writeln(TxTFile,WriteStr);

 {---End of Heather--(6 Lines -----------------------------------}


 {---------------- Starts Writing Data -------------------------------}

    For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
      If (PLOTvar.AdrUsed[CntROI] > 0) then Begin
         {Writes ROI number}
         WriteStr  := IntToStr(PLOTvar.AdrUsed[CntROI]);

         {Writes Frequency (Hz); Only First Row}
         //Peak Position Stores Peaks as Image Number
         if (High(PeakPosArr[CntROI]) > -1) then
          FrHz := FloatToStrF(Length(PeakPosArr[CntROI])/(CopyOfTimeSt[ToEnd-PLOTvar.ImBeg]-CopyOfTimeSt[Beg-PLOTvar.ImBeg]),ffFixed,10,6) else
          FrHz := '0';
          WriteStr := WriteStr + Chr(9) + FrHz;

         {Writes Number of Peaks}
         if (High(PeakPosArr[CntROI]) > -1) then
          WriteStr := WriteStr + Chr(9) + IntToStr(Length(PeakPosArr[CntROI])) else
          WriteStr := WriteStr + Chr(9) + '0';

         {writes Mean Amplitude}
         if (High(PeakValArr[CntROI]) > -1) then Begin
              Dur := 0; {here the Double Dur is used to Collect Mean Amplitude}
          for ImNr := 0 to High(PeakValArr[CntROI]) do
            Dur := Dur + (PeakValArr[CntROI,ImNr] - (PeakBasArr[CntROI,ImNr]-10));
              Dur := (Dur/Length(PeakValArr[CntROI]))/10;
         end else Dur := 0; {here the Double Dur is used to Collect Mean Amplitude}
         if Dur > 0 then    {here the Double Dur is used to Collect Mean Amplitude}
         WriteStr := WriteStr + Chr(9) + FloatToStrF(Dur,ffFixed,10,6) else
         WriteStr := WriteStr + Chr(9) + '-';

         {writes Mean Rise Time}
         If (High(PeakPosArr[CntROI]) > -1) Then Begin
          RiseT := 0; Cnt := 0;
          For ImNr := 0 to High(PeakPosArr[CntROI]) Do Begin
            if (RiseTimeArr[CntROI,ImNr] > CANNOT_BE_DONE) then Begin
              Inc(Cnt);
              RiseT := RiseT + RiseTimeArr[CntROI,ImNr];
            end;
          End; {for}
            if (Cnt > 0) then RiseT := RiseT/Cnt else
            if (Cnt = 0) then RiseT := 0;
         End Else RiseT := 0;
         if (RiseT > 0) then    {here the Double Dur is used to Collect Mean Amplitude}
         WriteStr := WriteStr + Chr(9) + FloatToStrF(RiseT,ffFixed,10,6) else
         WriteStr := WriteStr + Chr(9) + '-';

         {writes Mean Duration}
         If (High(PeakPosArr[CntROI]) > -1) Then Begin
          Dur := 0; Cnt := 0;
          For ImNr := 0 to High(PeakPosArr[CntROI]) Do Begin
            if (PeakTimArr[CntROI,ImNr].L > CANNOT_BE_DONE) and
               (PeakTimArr[CntROI,ImNr].R > CANNOT_BE_DONE) then Begin
              Inc(Cnt);
              Dur := Dur + PeakTimArr[CntROI,ImNr].R - PeakTimArr[CntROI,ImNr].L;
            end;
          End; {for}
            if Cnt > 0 then Dur := Dur/Cnt else
            if Cnt = 0 then Dur := 0;
         End Else Dur := 0;
         if Dur > 0 then    {here the Double Dur is used to Collect Mean Amplitude}
         WriteStr := WriteStr + Chr(9) + FloatToStrF(Dur,ffFixed,10,6) else
         WriteStr := WriteStr + Chr(9) + '-';

         {Writes Mean Decay}
         If (High(PeakPosArr[CntROI]) > -1) Then Begin
          Decay := 0; Cnt := 0;
          For ImNr := 0 to High(PeakPosArr[CntROI]) Do Begin
            if (PeakTimArr[CntROI,ImNr].R > CANNOT_BE_DONE) then Begin
              Inc(Cnt);
              Decay := Decay + PeakTimArr[CntROI,ImNr].R - CopyOfTimeSt[PeakPosArr[CntROI,ImNr]];
            end;
          End; {for}
            if Cnt > 0 then Decay := Decay/Cnt else
            if Cnt = 0 then Decay := 0;
         End Else Decay := 0;
         if Decay > 0 then    {here the Double Dur is used to Collect Mean Amplitude}
         WriteStr := WriteStr + Chr(9) + FloatToStrF(Decay,ffFixed,10,6) else
         WriteStr := WriteStr + Chr(9) + '-';

         {writes Data to File}
       WriteLn(TxTFile, WriteStr);

   End; {If (PLOTvar.AdrUsed[CntROI] > 0)}
  End; {For CntROI := 0 to (PLOTvar.NrROI - 1)}

      CloseFile(TxTFile);
  End Else If IsFileInUse(SaveFname) = True then
  MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

End Else
 {------------------------------------------------------------------}
If (sender = SaveMetafIle) then Begin
  FilePaths.SingleImageFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname             := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.emf' then SaveFname := SaveFname + '.emf';

  SaveAsFile := True;
  if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
  MakeMetaFile(SaveAsFile,TSPlotData_BaseSubtr,SaveFname) else
  MakeMetaFile(SaveAsFile,TSPlotData_BaseNotSubtr,SaveFname);

End Else
{------------------------------------------------------------------}
 If (sender = ExportPlot) {= as TXT}  then Begin

  FilePaths.PLOTFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname             := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If IsFileInUse(SaveFname) = False then Begin
  AssignFile(TxtFile, SaveFname);
  ReWrite(TxtFile);
        {tab := Chr(9);}

  {--- Writes Header -------------------------------------------------------}
  {1st: Writes File Name & Kind of Analysis}

  if (NrChannels = 1) then
      WriteStr := 'SparkAn "Trace File";  Extracted from: ' + PLOT_FTitle + ';  Analysis Type: ' + PLOTvar.Title else
      if (NrChannels = 2) then begin
        if (ChannelOrder = ASCENDING)  then
        WriteStr := 'SparkAn "Trace File";  Extracted from: ' + PLOT_FTitle + ', Channel One;  Analysis Type: ' + PLOTvar.Title else
        if (ChannelOrder = DESCENDING)  then
        WriteStr := 'SparkAn "Trace File";  Extracted from: ' + PLOT_FTitle + ', Channel Two;  Analysis Type: ' + PLOTvar.Title;
  end;

  if (PLOTvar.BaseLineStatus in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      WriteStr := WriteStr + ' (' + IntToStr(PLOTvar.BaseLinePoints)+ '*'+ IntToStr(PLOTvar.NrScanes) + ' points' +
      ', LSD = ' + FloatToStrF(PLOTvar.LSD,ffFixed,1,1) +
      ', RSD = ' + FloatToStrF(PLOTvar.RSD,ffFixed,1,1) + ')'
  else WriteStr := WriteStr + ', Continuous Baseline Not used';

  WriteStr := WriteStr + '; ' + GetFilterSize;

  Writeln(TxTFile,WriteStr);

{2nd Writel What was done}
   TrUsed := 0;   {gives Displayd Traces from all Analyzed = PLOTvar.NrROI}
  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Inc(TrUsed);
  End;

  with PLOTvar do begin
  if not(MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then
    Writeln(TxTFile,'Image Nr, Time (s), & Data from ' + IntToStr(TrUsed) + ' ROI')
    else
  if (MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then begin
    if (MovFType in[ANDOR_MOV,BIORAD_PIC]) then begin
      if (MovieSeriesType = TimeSeries) then
        Writeln(TxTFile,'Image Nr, Time (s), & Data from ' + IntToStr(TrUsed) + ' ROI')
        else
      if (MovieSeriesType = Z_Stack) then
        Writeln(TxTFile,'Image Nr, Time (s), Z distance (µm) & Data from ' + IntToStr(TrUsed) + ' ROI');
    end
      else
    if (MovFType = ZEISS_CZI_LSM_MOV) then begin
      if (MovieSeriesType = TimeSeries) then
        Writeln(TxTFile,'Image Nr, Time (s), & Data from ' + IntToStr(TrUsed) + ' ROI')
        else
      if (MovieSeriesType = Z_Stack) then
        Writeln(TxTFile,'Image Nr, Z distance (µm), & Data from ' + IntToStr(TrUsed) + ' ROI');
    end;
  end; //if (MovFType in[ANDOR_MOV,ZEISS_CZI_LSM_MOV])
  end; //with

  {3nd: writes ROI kind}
       FirstTime := True;

  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If FirstTime = True Then Begin
        if PLOTvar.ROIkind[Cnt] = 1 then WriteStr := 'ROI kind:  Rectangular' else
        if PLOTvar.ROIkind[Cnt] = 2 then WriteStr := 'ROI kind:  Ellipse' else
        if PLOTvar.ROIkind[Cnt] = 3 then WriteStr := 'ROI kind:  Free Hand' else
        if PLOTvar.ROIkind[Cnt] = 4 then WriteStr := 'ROI kind:  Line Scan';
        FirstTime := False;
      End Else
      If FirstTime = False Then Begin
        if PLOTvar.ROIkind[Cnt] = 1 then WriteStr := WriteStr + ', Rectangular' else
        if PLOTvar.ROIkind[Cnt] = 2 then WriteStr := WriteStr + ', Ellipse' else
        if PLOTvar.ROIkind[Cnt] = 3 then WriteStr := WriteStr + ', Free Hand' else
        if PLOTvar.ROIkind[Cnt] = 4 then WriteStr := WriteStr + ', Line Scan';
      End; { FirstTime = False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0}
  End; {For Cnt := 0 to PLOTvar.NrROI -1}
   Writeln(TxTFile,WriteStr);

   {4rd: writes X size(s)}
      FirstTime := True;
  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
     If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If FirstTime = True Then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := 'X & Y size (pix): ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                                'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
   WriteStr := 'X & Y size (pix): Free Hand';
         FirstTime := False;
      End else
      If FirstTime = False Then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
    WriteStr := WriteStr + '; ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                            'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
    WriteStr := WriteStr +  '; Free Hand';
      End; {False}
     End; {PLOTvar.AdrUsed[CntROI] > 0}
  End;
  Writeln(TxTFile,WriteStr);


   {5th writes X & Y centers (pix)}

       FirstTime := True;

  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
    If PLOTvar.AdrUsed[Cnt] > 0 then Begin
      If (FirstTime = True) then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := 'Color # & (X,Y) center (pix): Color # '
               + IntToStr(PLOTvar.AdrUsed[Cnt]) + ' ('
               + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
               ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := 'Color # & (X,Y) center (pix): Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
        FirstTime := False;
      End Else
      If (FirstTime = False) then Begin
         if PLOTvar.ROIkind[Cnt] in[1,2,4] then
   WriteStr := WriteStr + ';  Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]) + ' ('
                     + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
                    ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := WriteStr + '; Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
      End; {False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0 }
  End;
  Writeln(TxTFile,WriteStr);

 {------------------------- End of Heather ------------------------------------}

       FirstTime := True;
       Beg     := frmTimeSerPlot.dsXaxes.PosFrom;
       ToEnd   := frmTimeSerPlot.dsXaxes.PosTo;

 For ImNr := Beg to ToEnd Do Begin
       FirstTime := True;

    with PLOTvar do begin
    if not(MovFType in[ANDOR_MOV,BIORAD_PIC]) then
      TimeStr := FloatToStr(CopyOfTimeSt[ImNr-PLOTvar.ImBeg])
      else
    if (MovFType in[ANDOR_MOV,BIORAD_PIC]) then begin
      if (MovieSeriesType = TimeSeries) then
        TimeStr := FloatToStr(CopyOfTimeSt[ImNr-PLOTvar.ImBeg])
        else
      if (MovieSeriesType = Z_Stack) then
        TimeStr := FloatToStr(CopyOfTimeSt[ImNr-PLOTvar.ImBeg]) + Chr(9) + FloatToStr(ZstackArr[ImNr])
    end; //if (MovFType = ANDOR_MOV)
    end; //with PLOTvar do begin

    For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
      If PLOTvar.AdrUsed[CntROI] > 0 then Begin
        if (FirstTime = True) then begin
          if (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME]) Then Begin
             if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
              WriteStr := IntToStr(ImNr+1) + Chr(9) + TimeStr + Chr(9) +
                FloatToStrF(TSPlotData_BaseSubtr[CntROI,(ImNr-PLOTvar.ImBeg)]/ScaleRat,ffFixed,8,3) else
              WriteStr := IntToStr(ImNr+1) + Chr(9) + TimeStr + Chr(9) +
                FloatToStrF(TSPlotData_BaseNotSubtr[CntROI,(ImNr-PLOTvar.ImBeg)]/ScaleRat,ffFixed,8,3)
          end
            else
          begin
           if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
             WriteStr := IntToStr(ImNr+1) + Chr(9) + TimeStr + Chr(9) +
             FloatToStrF(TSPlotData_BaseSubtr[CntROI,(ImNr-PLOTvar.ImBeg)],ffFixed,8,3) else
             WriteStr := IntToStr(ImNr+1) + Chr(9) + TimeStr + Chr(9) +
             FloatToStrF(TSPlotData_BaseNotSubtr[CntROI,(ImNr-PLOTvar.ImBeg)],ffFixed,8,3);
          end;

          FirstTime := False;
        end //if (FirstTime = True)
            else
        if (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME]) Then Begin
           if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
              WriteStr := WriteStr + Chr(9) +
                FloatToStrF(TSPlotData_BaseSubtr[CntROI,(ImNr-PLOTvar.ImBeg)]/ScaleRat,ffFixed,8,3) else
              WriteStr := WriteStr + Chr(9) +
                FloatToStrF(TSPlotData_BaseNotSubtr[CntROI,(ImNr-PLOTvar.ImBeg)]/ScaleRat,ffFixed,8,3);
        end
          else
        begin
            if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
              WriteStr := WriteStr + Chr(9) +
                FloatToStrF(TSPlotData_BaseSubtr[CntROI,(ImNr-PLOTvar.ImBeg)],ffFixed,8,3) else
              WriteStr := WriteStr + Chr(9) +
                FloatToStrF(TSPlotData_BaseNotSubtr[CntROI,(ImNr-PLOTvar.ImBeg)],ffFixed,8,3)
        end;

      End; {If PLOTvar.AdrUsed[CntROI] > 0}
    End; {CntROI := 0 to (PLOTvar.NrROI - 1)}

      WriteLn(TxTFile, WriteStr);


 End; {ImNr := BegIm to EndIm -1}
      CloseFile(TxTFile);
   End Else If IsFileInUse(SaveFname) = True then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

 End // If (sender = ExportPlot)

  Else

 If (sender = ExportPlotAsPClampATF) {PClamp Gap Free Text File}  then Begin

  FilePaths.PLOTFilePath := ExtractFilePath(SaveFileDialog.FileName);
  SaveFname             := SaveFileDialog.FileName;
  if ExtractFileExt(SaveFname) <> '.atf' then SaveFname := SaveFname + '.atf';

  if not(IsFileInUse(SaveFname)) then SavePlotAsPClampATF(SaveFname)
    else
  if (IsFileInUse(SaveFname)) then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

 End Else
 {----------------------------------------------------------------------------------------}
 if (sender = AreasOnly) or (sender = AreasROIXYandNrIntegrations) then Begin
    FilePaths.PLOTFilePath := ExtractFilePath(SaveFileDialog.FileName);
    SaveFname             := SaveFileDialog.FileName;
    if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

    if not(IsFileInUse(SaveFname)) then ExportAreaFileAsTxT(SaveFname,sender)
     else
    if (IsFileInUse(SaveFname)) then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

 End Else
  {----------------The following is for BMP Files ----------------------------------------------}

  if (sender = SaveCalibrationBar) or (sender = SavePlotPanelAsBMP) then Begin
   FilePaths.SingleImageFilePath := ExtractFilePath(SaveFileDialog.FileName);
   SaveFname             := SaveFileDialog.FileName;
   if ExtractFileExt(SaveFname) <> '.bmp' then SaveFname := SaveFname + '.bmp';

   If IsFileInUse(SaveFname) = False then Begin

   if (sender = SaveCalibrationBar) then begin
    frmImageControl.ColorBar.Picture.SaveToFile(SaveFname);
    WriteLogFile(Sender,SaveFname);
   end else
   if (sender = SavePlotPanelAsBMP) then Begin
    TemBmp := TBitmap.Create;
    {Shows Plot if hidden and puts it On Top of Other Windows in order to copy Canvas}
    ViewTimeSeriesAnalysisClick(Sender);
    Application.ProcessMessages;

    TemBmp := frmTimeSerPlot.GetFormImage;  //Replaces Older Way usin Win32API; See Copy to ClipBoard

    TemBmp.SaveToFile(SaveFname);
    FreeAndNil(TemBmp);

   End;
   End Else
   If IsFileInUse(SaveFname) = True then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);
  End Else
  {------------------------------------------------------------}
   if (sender = SaveLineScanImageAsBMP) or (sender = SaveLineScanPanel) then Begin
   FilePaths.SingleImageFilePath := ExtractFilePath(SaveFileDialog.FileName);
   SaveFname             := SaveFileDialog.FileName;
   if ExtractFileExt(SaveFname) <> '.bmp' then SaveFname := SaveFname + '.bmp';

   If IsFileInUse(SaveFname) = False then Begin

   if (sender = SaveLineScanImageAsBMP) then begin
    if Not((SmoothMode > NO_SMOOTH) and ((RatioOn) or (SmoothNonRatio > NO_SMOOTH_NON_RATIO))) then begin
      frmLineScan.imLineScan.Picture.SaveToFile(SaveFname);
    end else
    if (SmoothMode > NO_SMOOTH) and ((RatioOn) or (SmoothNonRatio > NO_SMOOTH_NON_RATIO)) then begin

     if (SmoothMode = SMOOTH_BOX) then Cnt := BoxSmSize else
     if (SmoothMode = SMOOTH_MED) then Cnt := MedSmSize else
     if (SmoothMode in[SMOOTH_BOX_MED,SMOOTH_MED_BOX]) then begin //chooses the bigger one
      if (BoxSmSize >= MedSmSize) then Cnt := BoxSmSize else
                                       Cnt := MedSmSize;
     end; 
     Cnt := Cnt shr 1;
     TemBmp := TBitmap.Create;
     TemBmp.Width  := frmLineScan.imLineScan.Width  - (Cnt shl 1);
     TemBmp.Height := frmLineScan.imLineScan.Height - (Cnt shl 1);;
     with frmLineScan.imLineScan.Canvas do begin
      SourceRect.Left   := ClipRect.Left   + Cnt;
      SourceRect.Right  := ClipRect.Right  - Cnt;
      SourceRect.Top    := ClipRect.Top    + Cnt;
      SourceRect.Bottom := ClipRect.Bottom - Cnt;
     end;
     TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,frmLineScan.imLineScan.Canvas,SourceRect);
     TemBmp.SaveToFile(SaveFname);
     FreeAndNil(TemBmp);
    end; //if (RatioOn) and (SmoothMode > NO_SMOOTH)
   end else
   if (sender = SaveLineScanPanel) then Begin
    TemBmp := TBitmap.Create;
    TemBmp := frmLineScan.GetFormImage; 
    TemBmp.SaveToFile(SaveFname);
    FreeAndNil(TemBmp);
   End;

   WriteLogFile(Sender,SaveFname);

   End Else
   If IsFileInUse(SaveFname) = True then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);
  End Else

  {---------------------------------------------------------------}
 If ((sender = SaveMainWindow) or (sender = SaveMergeWindow) or (sender = Save3Dwindow) or
     (sender = SaveSecondaryWindow) or (sender = SaveAverageImageAsBMP)) and (MainImLoaded) then Begin
   FilePaths.SingleImageFilePath := ExtractFilePath(SaveFileDialog.FileName);
   SaveFname             := SaveFileDialog.FileName;
   if ExtractFileExt(SaveFname) <> '.bmp' then SaveFname := SaveFname + '.bmp';
   If (IsFileInUse(SaveFname) = False) then Begin

   //-------------- Starts Saving ---------------------------------------//

    TemBmp := TBitmap.Create;

    if (frmImageControl.ubApplyFrame.Selected) and Not(sender = Save3Dwindow) then
      GetSelFrameParams(TemBmp,SourceRect.Left,SourceRect.Top,SourceRect.Right,SourceRect.Bottom) else
    begin
      if (sender = SaveMainWindow)      then SetBMPsize(frmMainWin.winMainImage) else
      if (sender = SaveMergeWindow)     then SetBMPsize(frmMergeWin.MergeImage) else
      if (sender = SaveSecondaryWindow) then SetBMPsize(frm2ndWin.win2ndImage) else
      if (sender = Save3Dwindow)        then SetBMPsize(frm3DImageWin.Image3DWin) else
      if (sender = SaveAverageImageAsBMP) then SetBMPsize(frmAverIm.winAverImage);
     end;

     TemBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings

     if (sender = SaveMainWindow)      then CopyToBMP(frmMainWin,frmMainWin.winMainImage) else
     if (sender = SaveMergeWindow)     then CopyToBMP(frmMergeWin,frmMergeWin.MergeImage) else
     if (sender = SaveSecondaryWindow) then CopyToBMP(frm2ndWin,frm2ndWin.win2ndImage) else
     if (sender = Save3Dwindow)        then CopyToBMP(frm3DImageWin,frm3DImageWin.Image3DWin) else
     if (sender = SaveAverageImageAsBMP) then CopyToBMP(frmAverIm,frmAverIm.winAverImage);

     TemBmp.SaveToFile(SaveFname);
     FreeAndNil(TemBmp);
     WriteLogFile(Sender,SaveFname);

   // ----------------  End of saving ---------------------------------//
   End Else
   If IsFileInUse(SaveFname) = True then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);
 End {(sender = SaveMainWindow)} else

  {-----------------------------------------------------------------------}

 If ((sender = mnMakeMovie) or (sender = mnMakeMoviefrom3D) or (sender = mnMakeMoviefromMergeWindow))
      and (MainImLoaded = True) then Begin

   FilePaths.SingleImageFilePath := ExtractFilePath(SaveFileDialog.FileName);
   SaveFname                     := SaveFileDialog.FileName;

   PrepareForMakingMovie(SaveFname, Sender);

 End else
  {-----------------------------------------------------------------------}
 If ((sender = SaveConsecutiveImages) or (sender = SaveConsecutiveImagesfromMergeWindow) or
      (sender = Save3DWindowConsecutiveImages) or (sender = SaveConsecutiveImagesfrom2ndWindow))
      and (MainImLoaded = True) then Begin
{ The StuffString function inserts a SubString into another string,
  replacing Length characters at position Start.
  source := '123456789';
  target := StuffString(source, 2, 4, '-inserted-'); }
{  Strings are indexed from 1 (arrays from 0).}

  if (NrIm <  10)                           Then ZeroStr :=      '0' else
  if (NrIm >= 10)     and  (NrIm <     100) Then ZeroStr :=     '00' else
  if (NrIm >= 100)    and  (NrIm <    1000) Then ZeroStr :=    '000' else
  if (NrIm >= 1000)   and  (NrIm <   10000) Then ZeroStr :=   '0000' else
  if (NrIm >= 10000)  and  (NrIm <  100000) Then ZeroStr :=  '00000' else
  if (NrIm >= 100000) and  (NrIm < 1000000) Then ZeroStr := '000000';

  Beg   := ExportDial.FromIm;
  ToEnd := ExportDial.ToIm;
  ImNr  := CurIm;
  frmPlayback.ForWards.Down := True;
  PlayBackMode := CONT_FORWARD;

  FilePaths.MultipleImagesFilePath := ExtractFilePath(SaveFileDialog.FileName);
   //extracts File Name without extension
  SaveFname := Copy(SaveFileDialog.FileName,Length(SaveFileDialog.FileName)-3,
                     Length(SaveFileDialog.FileName));
  if SaveFname = '.bmp' then
    SaveFileDialog.FileName := Copy(SaveFileDialog.FileName,1,Length(SaveFileDialog.FileName)-4);

 // ------------------- Saving Begins -----------------------------------------------}

 ////New Code   June 26, 2017
   TemBmp := TBitmap.Create;

   if (frmImageControl.ubApplyFrame.Selected) and Not(sender = Save3DWindowConsecutiveImages) then
      GetSelFrameParams(TemBmp,SourceRect.Left,SourceRect.Top,SourceRect.Right,SourceRect.Bottom) else
   begin
      if (sender = SaveConsecutiveImages)                then SetBMPsize(frmMainWin.winMainImage);// else
      if (sender = SaveConsecutiveImagesfromMergeWindow) then SetBMPsize(frmMergeWin.MergeImage) else
      if (sender = SaveConsecutiveImagesfrom2ndWindow)   then SetBMPsize(frm2ndWin.win2ndImage) else
      if (sender = Save3DWindowConsecutiveImages)        then SetBMPsize(frm3DImageWin.Image3DWin);
   end;

   For Cnt := Beg to ToEnd Do Begin
      if (PlayBackMode = STOPPED) then Break;
      NrToRepl := Length(IntToStr(Cnt + 1));
      StartPos := Length(ZeroStr) - Length(IntToStr(Cnt + 1)) + 1;
      NrStr    := StuffString(ZeroStr,StartPos,NrToRepl,IntToStr(Cnt + 1));
      frmPlayback.PlaybackScrollBar.Position := Cnt;
      SaveFname := SaveFileDialog.FileName + NrStr + '.bmp' ;

      if (sender = SaveConsecutiveImages)                then CopyToBMP(frmMainWin,frmMainWin.winMainImage) else
      if (sender = SaveConsecutiveImagesfromMergeWindow) then CopyToBMP(frmMergeWin,frmMergeWin.MergeImage) else
      if (sender = SaveConsecutiveImagesfrom2ndWindow)   then CopyToBMP(frm2ndWin,frm2ndWin.win2ndImage)else
      if (sender = Save3DWindowConsecutiveImages)        then CopyToBMP(frm3DImageWin,frm3DImageWin.Image3DWin);

      TemBmp.SaveToFile(SaveFname);

   //end new code

   End; {For Cnt := Beg to ToEnd }

    if (ExportDial.DoWriteLogFile) then WriteLogFile(Sender,SaveFname);

    if frmPlayback.PlaybackScrollBar.Position <> ImNr then
    frmPlayback.PlaybackScrollBar.Position := ImNr;
    frmPlayback.Stop.Down := True;
    frmPlayback.StopClick(sender);
    FreeAndNil(TemBmp);
  end else //(sender = SaveConsecutiveImages)

  {-----------------------------------------------------------------------}
  {this shoud be always the Last Option because if the frmAndorImageDescr is not open then
   checking Non-existing Sender (Object) will Crash the Program}
   
  if (sender = frmAndorImageDescr.btSave) then Begin
    SaveFname                := SaveFileDialog.FileName;
    if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

    if IsFileInUse(SaveFname) = False then
        frmAndorImageDescr.MemoDescr.Lines.SaveToFile(SaveFname) else

    if IsFileInUse(SaveFname) = True then
    MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

    SaveFileDialog.InitialDir := ExtractFilePath(ImFname); //reverts to Image File Path
  end;
  {-----------------------------------------------------------------------}


    { Add code to save current file under SaveDialog.FileName }
  END; {if SaveFileDialog.Execute}

END;  {procedure TMainForm.FileSaveAs(Sender: TObject);}
{*************************************************************************}
{*********** File Saving Procedures *************************************}


{***********End of  File Saving Procedures *************************************}


Procedure TMainForm.DoPrintTimeSerPlot(Const PlotData : TDyn2DDoubleArr);
 Var
      R        : TRect;
      Frame    : TRect;
      PrBMP    : TBitmap;
      ScreenDC : hDC;
      XpageOff, YpageOff : integer;
      Portrait : Boolean;
      PagePartToUse : integer;
      ScalePic : Double;
      ScaleLab : Double;

  PlXbegPr        : integer;
  PlYbegPr        : integer;    {beg and End of Plot Traces(in Pix)}
  PlYendPr        : integer;

  PlXaxBegPr      : integer;
  PlYaxBegPr      : integer;     {beg and End of Plot Axes(in Pix)}
  PlYaxEndPr      : integer;

  YplotPr         : integer;     {Plot window for Traces in Pix }
  YscalePr        : double;     {local var analog to global Yscale}
  XscalePr        : double;      {local var analog to global Xscale}
  WinXSizePr      : integer;     {Plot Total X with}
  PlotWinYsizePr  : integer;     {Total Window (Timage) Y size }

  BigYTick, i, j : Integer;  {size in pix}
  NrBigYTick,NrSmYTick : Integer;
  Lab : AnsiString;
  SmYTick : Single;

  LogRec: TLogFont;  {Win GDI Structure:  LOGFONT structure }
  OldFontHandle, NewFontHandle: hFont;
  { X ticks}
  BigXTick,NrBigXTick,NrSmXTick : integer;
  BigTickTime  : Extended;
  DigAftZero    : integer;
  Xplot : Integer;          {Size of Plot in Pix}
  BigXTickBeg : integer;
  LabOff, Xoff, XoffUse: integer;
  XSleft, XSright, XLmin : integer; {position of Left & Right Slider}
  SmXTick         : Single;
  {---}
  YplPosM,YplPosL : integer; {final calculated Ypos to MoveTo and LineTo}
  CntROI          : integer;
  ImNr            : integer;
  BegIm, EndIm    : integer;
  PrintColor      : Cardinal; {used  to replace White[20] to Black and Yellow[4] to darker 230}
  Pt              : TPoint;
  PrTraceArr      : array of TPoint;
  CntPeak, Ypeak  : integer;

Begin
{--------- Begins to Print Plot --------------------------------------}
 {--------- Initializing variables ------------------------------------}

        PagePartToUse := Printer.PageWidth - round((Printer.PageWidth/10)*1.2); {~88%}
        ScalePic := PagePartToUse/600;
        if Printer.PageWidth < Printer.PageHeight then ScaleLab := ScalePic else
        if Printer.PageWidth > Printer.PageHeight then
           ScaleLab := (Printer.PageHeight - round((Printer.PageHeight/10)*1.2))/600;


  PlXbegPr        := round(PlXbeg*ScalePic)  + round((Printer.PageWidth/10)*0.7);
  PlYbegPr        := round(PlYbeg*ScalePic)  + round((Printer.PageWidth/10)*1.5);    {beg and End of Plot Traces(in Pix)}
  PlYendPr        := round(PlYend*ScalePic)  + round((Printer.PageWidth/10)*1.5);

  PlXaxBegPr      := round(PlXaxBeg*ScalePic)+ round((Printer.PageWidth/10)*0.7);
  PlYaxBegPr      := round(PlYaxBeg*ScalePic)+ round((Printer.PageWidth/10)*1.5);
  PlYaxEndPr      := round(PlYaxEnd*ScalePic)+ round((Printer.PageWidth/10)*1.5);

  YplotPr         := round(Yplot*ScalePic);     {Plot window for Traces in Pix }
  PlotWinYsizePr  := round(PlotWinYsize*ScalePic);
  WinXSizePr      := round(600*ScalePic);

  Xplot    := WinXSizePr - PlXbegPr;
  XscalePr := Xplot/Xrange;  {Pix per Unit of measurement}

  YscalePr := YplotPr/Yrange;  {Pix per Unit of measurement}

  {FrameTimSerPlot.imgTimeSerPlot.Width  := 600; This is the Basic With on Screen} 
  {Starts!!!}
  With Printer Do Begin
       BeginDoc;

{------ New Traces ----------------}
{------------ Starts Plotting ------------------------}
    Canvas.Brush.Style := bsSolid;
    BegIm   := frmTimeSerPlot.dsXaxes.PosFrom;
    EndIm   := frmTimeSerPlot.dsXaxes.PosTo;
 {-----------------------------------------------------}
 SetLength(PrTraceArr,EndIm - BegIm + 1);

For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
 If PLOTvar.AdrUsed[CntROI] > 0 then Begin
     Canvas.Pen.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
     if Canvas.Pen.Color = clWhite then Canvas.Pen.Color := clBlack;

 if (TimPltSlid.SymbOn = True) or (PLOTvar.HasPeaks = True) then
     Canvas.Brush.Color :=  ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
     if Canvas.Brush.Color = clWhite then Canvas.Brush.Color := clBlack;

 if ROIvar.TickLine <> PLOTvar.AdrUsed[CntROI] then
    Canvas.Pen.Width := 1 else
    Canvas.Pen.Width := 3;


  For ImNr := BegIm to EndIm Do Begin

    PrTraceArr[ImNr-BegIm].X := PlXBegPr+round((ImNr-BegIm)*XscalePr);
    PrTraceArr[ImNr-BegIm].Y := PlYbegPr-round(YscalePr*PlotData[CntROI,(ImNr-PLOTvar.ImBeg)]
                              - frmTimeSerPlot.dsYaxes.PosFrom*YscalePr);
  End; { For ImNr := Beg to  ToEnd - 1 Do Begin}
    Canvas.Polyline(PrTraceArr);

  {if symbol was chosen or Im Nr from Tables Clicked}
  If TimPltSlid.SymbOn = True then Begin
    If PLOTvar.ImNrFromTable = -1 then Begin
        {Draws "Regular" Symbols for Each Image}
      For ImNr := BegIm to EndIm Do Begin
        Canvas.Ellipse(PrTraceArr[ImNr-BegIm].X-round(TimPltSlid.SymbSize*ScalePic),
                       PrTraceArr[ImNr-BegIm].Y-round(TimPltSlid.SymbSize*ScalePic),
                       PrTraceArr[ImNr-BegIm].X+round(TimPltSlid.SymbSize*ScalePic),
                       PrTraceArr[ImNr-BegIm].Y+round(TimPltSlid.SymbSize*ScalePic));
      End; { For ImNr := Beg to  ToEnd - 1 Do Begin}
    End Else
    If PLOTvar.ImNrFromTable > -1 then Begin
          {Draws the Symbol For The Image Number as Clicked on table}
      For ImNr := BegIm to EndIm Do Begin
        If PLOTvar.AdrUsed[CntROI] = 20 Then Begin{Last Trace # 20, White Color}
          if ImNr = PLOTvar.ImNrFromTable then Begin
            Canvas.Brush.Color := TimPltSlid.SymbFromTableCol;
            Canvas.Pen.Color   := TimPltSlid.SymbFromTableCol;
          end else begin
            Canvas.Pen.Color   := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
            Canvas.Brush.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
          end;
          if Canvas.Pen.Color = clWhite then Canvas.Pen.Color := clBlack;
          if Canvas.Brush.Color = clWhite then Canvas.Brush.Color := clBlack;
        End; {If CntROI = 19 Then Begin = Last Trace # 20, White Color}
        Canvas.Ellipse(PrTraceArr[ImNr-BegIm].X-round(TimPltSlid.SymbSize*ScalePic),
                       PrTraceArr[ImNr-BegIm].Y-round(TimPltSlid.SymbSize*ScalePic),
                       PrTraceArr[ImNr-BegIm].X+round(TimPltSlid.SymbSize*ScalePic),
                       PrTraceArr[ImNr-BegIm].Y+round(TimPltSlid.SymbSize*ScalePic));
      End; { For ImNr := Beg to  ToEnd - 1 Do Begin}
    End; {If PLOTvar.ImNrFromTable > -1 then Begin}
  End; {If frmTimeSerPlot.CheckBoxSymbolOn.Checked = True}
  If (TimPltSlid.AlwaysUseSymb = True) Then Begin
    If PLOTvar.ImNrFromTable > -1 then Begin
      If PLOTvar.AdrUsed[CntROI] = 20 Then Begin
       ImNr := PLOTvar.ImNrFromTable;
       Canvas.Brush.Color := TimPltSlid.SymbFromTableCol;
       Canvas.Pen.Color   := TimPltSlid.SymbFromTableCol;
       if Canvas.Pen.Color = clWhite then Canvas.Pen.Color := clBlack;
       if Canvas.Brush.Color = clWhite then Canvas.Brush.Color := clBlack;
       Canvas.Ellipse(PrTraceArr[ImNr-BegIm].X-round(TimPltSlid.SymbSize*ScalePic),
                      PrTraceArr[ImNr-BegIm].Y-round(TimPltSlid.SymbSize*ScalePic),
                      PrTraceArr[ImNr-BegIm].X+round(TimPltSlid.SymbSize*ScalePic),
                      PrTraceArr[ImNr-BegIm].Y+round(TimPltSlid.SymbSize*ScalePic));
       End; {PLOTvar.AdrUsed[CntROI] = 20}
    End; {If PLOTvar.ImNrFromTable > -1}
  End;  {If (PLOTvar.AlwaysUseSymb = True)}
          { Ellipse(X1, Y1, X2, Y2)}

    { --------------  Peaks Part ----------------------------------------}
   {Now Puts Symbols; so far circles for peaks found}

  If (PLOTvar.HasPeaks = True) and (PLOTvar.AnalType = RATIO_TIME) Then Begin
        {-------------------------------------------------------}
    If PeakFakeImNrArr <> nil Then   //PeakPosArr is not used here on purpose, see below
      if High(PeakFakeImNrArr[CntROI]) > -1 then
        For CntPeak := 0 to High(PeakFakeImNrArr[CntROI]) Do Begin
         if TimPltSlid.GetPeaks then ImNr := PeakPosArr[CntROI,CntPeak] + PLOTvar.ImBeg  {done here for clarity}
         else ImNr := PLOTvar.ImNrFromTable;

            if (ImNr >= BegIm) and (ImNr <= EndIm) Then Begin
             {Puts Symbol on Peak}
            Canvas.Ellipse(PrTraceArr[ImNr-BegIm].X-round(TimPltSlid.SymbSize*ScalePic),
                           PrTraceArr[ImNr-BegIm].Y-round(TimPltSlid.SymbSize*ScalePic),
                           PrTraceArr[ImNr-BegIm].X+round(TimPltSlid.SymbSize*ScalePic),
                           PrTraceArr[ImNr-BegIm].Y+round(TimPltSlid.SymbSize*ScalePic));

               if (PeakFakeImNrArr[CntROI,CntPeak].Lim > CANNOT_BE_DONE ) and
                  (PeakFakeImNrArr[CntROI,CntPeak].Rim > CANNOT_BE_DONE ) Then Begin

 {Calculates Y at 1/2 amplitude}
 Ypeak := PlYbegPr - round(YscalePr*((PlotData[CntROI,(ImNr-PLOTvar.ImBeg)]-10)/2+10)
                              - frmTimeSerPlot.dsYaxes.PosFrom*YscalePr);
              {Draws 1/2 amplitude Line using Fake ImNr }
 Canvas.MoveTo(PlXBegPr + round((PeakFakeImNrArr[CntROI,CntPeak].Lim-BegIm)*XscalePr), Ypeak);
 Canvas.LineTo(PlXBegPr + round((PeakFakeImNrArr[CntROI,CntPeak].Rim-BegIm)*XscalePr), Ypeak);

              {Draws Verical Line to 1/2 Amplitude}
 Canvas.MoveTo(PrTraceArr[ImNr-BegIm].X,PrTraceArr[ImNr-BegIm].Y);
 Canvas.LineTo(PrTraceArr[ImNr-BegIm].X, Ypeak);
              end else {if Both PeakFakeImNrArr[CntROI,CntPeak].Rim and Lim > -1}
           {if only right side found}
              if (PeakFakeImNrArr[CntROI,CntPeak].Lim < TIME_DONE) and
                 (PeakFakeImNrArr[CntROI,CntPeak].Rim > CANNOT_BE_DONE ) Then Begin
 {Calculates Y at 1/2 amplitude}
 Ypeak := PlYbegPr - round(YscalePr*((PlotData[CntROI,(ImNr-PLOTvar.ImBeg)]-10)/2+10)
                              - frmTimeSerPlot.dsYaxes.PosFrom*YscalePr);
              {Draws Only t1/2 Decay Line usin Fake ImNr }
 Canvas.MoveTo(PrTraceArr[ImNr-BegIm].X,Ypeak);
 Canvas.LineTo(PlXBegPr + round((PeakFakeImNrArr[CntROI,CntPeak].Rim-BegIm)*XscalePr), Ypeak);
              {Draws Verical Line to 1/2 Amplitude}

 Canvas.MoveTo(PrTraceArr[ImNr-BegIm].X,PrTraceArr[ImNr-BegIm].Y);
 Canvas.LineTo(PrTraceArr[ImNr-BegIm].X,Ypeak);
              end; {if Right Side only PeakFakeImNrArr[CntROI,CntPeak]Rim > -1  }
            end; { if (ImNr >= BegIm) and (ImNr <= EndIm)}
        End;{For ImNr := 0 to High(TimSerPlotData[CntROI])}
        {-------------------------------------------------------}
  End; {frmTimeSerPlot.cbGetPeaks.Checked = True}
  {------------- End with Peaks -----------------------------------}

  Canvas.Pen.Width := 1;
{---------------------------------------------------------------------------}
End; {If PLOTvar.AdrUsed[CntROI] > 0}
End; {For CntROI := 0 to (BoxPar.NrB - 1)}

{ end NEW traces}

    Canvas.Brush.Color := clWhite;
    {Cleans Excesasive Traces}
    {Above}
    Canvas.FillRect(Rect(Canvas.ClipRect.Left,Canvas.ClipRect.Top,
                    Canvas.ClipRect.Right,PlYaxEndPr));
    {bellow}
    Canvas.FillRect(Rect(Canvas.ClipRect.Left,PlYaxBegPr,
                    Canvas.ClipRect.Right,Canvas.ClipRect.Bottom));
    {left}
    Canvas.FillRect(Rect(Canvas.ClipRect.Left,Canvas.ClipRect.Top,
                    PlXaxBegPr,Canvas.ClipRect.Bottom));
    {Right}
    Canvas.FillRect(Rect(WinXsizePr,Canvas.ClipRect.Top,
                    Canvas.ClipRect.Right,Canvas.ClipRect.Bottom));
    {Changes Brush.Style to have transparent Text}
    Canvas.Brush.Style := bsClear;
 {---------2nd: TimeSerPlot Title ---------------}
    Canvas.Font.Name   := 'Arial';
    Canvas.Font.Size   := 12;
    Canvas.Font.Color  := clBlack;
    Canvas.TextOut(PlXbegPr+round(200*ScalePic),round(2*ScalePic)+round((Printer.PageWidth/10)*1),PLOTvar.Title);
{----------3rd: Draws X axes--------------------}
    Canvas.Pen.Color := clBlack;
    Canvas.MoveTo(PlXaxBegPr,PlYaxBegPr);
    Canvas.LineTo(WinXSizePr,PlYaxBegPr);
    Canvas.MoveTo(PlXaxBegPr,PlYaxEndPr);
    Canvas.LineTo(WinXSizePr,PlYaxEndPr);
{----------3rdA: Frame ------------------}
          {top X}
  Canvas.MoveTo(round((Printer.PageWidth/10)*0.35)          ,round((Printer.PageWidth/10)*0.8));
  Canvas.LineTo(WinXSizePr+round((Printer.PageWidth/10)*0.5),round((Printer.PageWidth/10)*0.8));
         { bottom X}
  Canvas.MoveTo(round((Printer.PageWidth/10)*0.35)          ,PlYbegPr+round(60*ScalePic));
  Canvas.LineTo(WinXSizePr+round((Printer.PageWidth/10)*0.5),PlYbegPr+round(60*ScalePic));
          {Left Y}
  Canvas.MoveTo(round((Printer.PageWidth/10)*0.35)          ,round((Printer.PageWidth/10)*0.8));
  Canvas.LineTo(round((Printer.PageWidth/10)*0.35)          ,PlYbegPr+round(60*ScalePic));
          {Right Y}
  Canvas.MoveTo(WinXSizePr+round((Printer.PageWidth/10)*0.5),round((Printer.PageWidth/10)*0.8));
  Canvas.LineTo(WinXSizePr+round((Printer.PageWidth/10)*0.5),PlYbegPr+round(60*ScalePic));
  {Prints File Name}
  Canvas.Font.Size := 11;
  Canvas.TextOut(WinXSizePr div 2-round((Printer.PageWidth/10)*0.8),
                 PlYbegPr+round(40*ScalePic),'File: ' + PLOT_FTitle);
  Lab := FormatDateTime('m/d/yy  h:nn', Now);  {Gets Current Date & Time}
  Canvas.Font.Size   := 7;
  Canvas.TextOut(WinXSizePr-WinXSizePr div 5,round((Printer.PageWidth/10)*0.9),Lab);
{----------4th: Draws Y axes --------------------}
    Canvas.MoveTo(PlXaxBegPr,PlYaxBegPr);
    Canvas.LineTo(PlXaxBegPr,PlYaxEndPr);
    Canvas.MoveTo(WinXSizePr,PlYaxBegPr);
    Canvas.LineTo(WinXSizePr,PlYaxEndPr);
    Canvas.Font.Size   := 10;
    Canvas.TextOut(PlXbegPr,round(2*ScalePic)+round((Printer.PageWidth/10)*1.5),'Seconds');
    Canvas.TextOut(PlXbegPr,PlYbegPr+round(30*ScalePic),'Number of Images');
       {-----Makes a Rotated Font --}
  GetObject(Canvas.Font.Handle, SizeOf(LogRec), Addr(LogRec));
  LogRec.lfEscapement  := 90*10;  {angle*10} {Specifies the angle, in tenths of degrees, between the escapement vector and the x-axis }
  LogRec.lfOrientation := 90*10;  {Specifies the angle, in tenths of degrees, between each character's base line and the x-axis of the device}
  NewFontHandle := CreateFontIndirect(LogRec);
  OldFontHandle := SelectObject(Canvas.Handle, NewFontHandle);
  If (PLOTvar.AnalType = INTENSITY_TIME) then Canvas.TextOut(round(1*ScalePic)+round((Printer.PageWidth/10)*0.5), round(180*ScalePic)+round((Printer.PageWidth/10)*1), 'Intensity') else
  If (PLOTvar.AnalType = RATIO_TIME)  then Canvas.TextOut(round(1*ScalePic)+round((Printer.PageWidth/10)*0.5), round(160*ScalePic)+round((Printer.PageWidth/10)*1), 'F/Fo') else
  If (PLOTvar.AnalType = DISTANCE_TIME) then Canvas.TextOut(round(1*ScalePic)+round((Printer.PageWidth/10)*0.5), round(180*ScalePic)+round((Printer.PageWidth/10)*1), 'Distance ( +  Char(181) + m)');
  NewFontHandle := SelectObject(Canvas.Handle, OldFontHandle);
  DeleteObject(NewFontHandle);

{---------5th ----Y ticks  -------}
    Canvas.Font.Name := 'Arial';
    Canvas.Font.Size := 8;
    Canvas.Font.Color := clBlack;

    BigYTick := (Yrange div 5);
  If (BigYTick = 0) Then  BigYTick := 1 else
  If (BigYTick > 5) and (BigYTick <10) Then  BigYTick := (BigYTick div 5)*5 else
  If (BigYTick >= 10)  Then  BigYTick := (BigYTick div 10)*10;

  If (PLOTvar.AnalType = RATIO_TIME) Then Begin
    NrBigYTick := 200 div BigYTick;
  End Else
  Begin
    if (BitCount = 16) then NrBigYTick := 1023 div BigYTick else
    if (BitCount = 8)  then NrBigYTick :=  255 div BigYTick;
  End;


    if (PLOTvar.AnalType = RATIO_TIME)  then begin
       if NrBigYTick <= 5 then  NrSmYTick := 10 else NrSmYTick := 5;
    end else
    begin
       if (BigYTick >= 10) and (NrBigYTick <= 5) then NrSmYTick := 10 else
       if (BigYTick >= 10) and (NrBigYTick >  5) then NrSmYTick :=  5 else
       if (BigYTick  < 10) then NrSmYTick := BigYTick;
    end;
       SmYTick := BigYTick/NrSmYTick;
       
 For i := 0 to NrBigYTick  Do Begin   {Draws Ticks}
   if (i*BigYTick >= frmTimeSerPlot.dsYaxes.PosFrom) and
      (i*BigYTick <= frmTimeSerPlot.dsYaxes.PosTo) then begin

      With  Canvas Do Begin
        MoveTo(PlXaxBegPr-round(5*ScalePic),PlYbegPr - round((BigYTick*i -
                        frmTimeSerPlot.dsYaxes.PosFrom)*YscalePr));
        LineTo(PlXaxBegPr,  PlYbegPr - round((BigYTick*i -
                        frmTimeSerPlot.dsYaxes.PosFrom)*YscalePr));

   if (PLOTvar.AnalType = RATIO_TIME)  then Lab := FloatToStrF((BigYTick*i)/10,ffFixed,2,1) else
                                            Lab := IntToStr   (BigYTick*i);
        TextOut(PlXbegPr-round(Length(Lab)*5*ScaleLab + 9*ScalePic),PlYbegPr - round((BigYTick*i -
                              frmTimeSerPlot.dsYaxes.PosFrom)*YscalePr)-round(6*ScaleLab),Lab);
        for j := 1 to NrSmYTick - 1 do begin

           if PlYbegPr - round((BigYTick*i+SmYTick*j -
                        frmTimeSerPlot.dsYaxes.PosFrom)*YscalePr) >= PlYendPr then begin
           MoveTo(PlXaxBegPr-round(3*ScalePic),PlYbegPr - round((BigYTick*i+SmYTick*j -
                        frmTimeSerPlot.dsYaxes.PosFrom)*YscalePr));
           LineTo(PlXaxBegPr,  PlYbegPr - round((BigYTick*i+SmYTick*j -
                        frmTimeSerPlot.dsYaxes.PosFrom)*YscalePr));

           end;
        end;

      End; {With Canvas }
   end;
 End; {For i := BigYTickBeg to NrBigYTick}

 {-------------6th: X Ticks --------------------}

     XSleft  := frmTimeSerPlot.dsXaxes.PosFrom;
     XLmin   := frmTimeSerPlot.dsXaxes.Min;
     XSright := frmTimeSerPlot.dsXaxes.PosTo;

     if (Xrange >= 50) then BigXTick := (Xrange div 5)else BigXTick := (Xrange div 2);

     if  BigXTick >=10 then BigXTick := (BigXTick div 10)*10 else
     if  BigXTick <= 2 then BigXTick := (BigXTick div 2)*2 else
         BigXTick := (BigXTick div 5)*5;  {BigTick = Size in Units}

     If (BigXTick = 0) Then  BigXTick := 1;

     if BigXTick >= 10 then NrSmXTick := 10 else
        NrSmXTick := BigXTick;
        SmXTick := BigXTick/NrSmXTick;

        Xoff := 0;
        {calculates Precision for Time Tick Labels}
     BigTickTime := BigXTick*MeanImTime; {temporarily holds this value}
     if trunc(BigTickTime) >= 1 then DigAftZero := 1 else
     DigAftZero := 7 - Length(IntToStr(trunc(frac(BigTickTime)*100000)));


     While Xoff < XSleft Do Begin
        if Xoff < XSLeft then Inc(Xoff,BigXTick);
     End;
        Dec(Xoff); {shifts Xoff to the left by one; Because Images are numbered From 1}
        NrBigXTick :=  Xrange div BigXTick;
        j := 1;

     For i := 0 to NrBigXTick Do Begin   {Draws Ticks}

  With Canvas Do Begin
    if (XSleft = 0) and (i = 0) then XoffUse := Xoff + 1 Else XoffUse := Xoff;
      If BigXTick*i+(XoffUse-XSleft) >= 0 Then Begin
        if PlXBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr) <= WinXSizePr then begin
            {Bottom Images }
        MoveTo(PlXBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr),PlYaxBegPr);
        LineTo(PlXBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr),PlYaxBegPr+round(5*ScalePic));
            {Top - Seconds}
        MoveTo(PlXBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr),PlYaxEndPr);
        LineTo(PlXBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr),PlYaxEndPr-round(5*ScalePic));

        {PlXbeg is used in order to get 0 alligned with Traces}
          {Bottom Tick Labels}
        Lab := IntToStr((BigXTick*i+ XoffUse) + 1 );   {1st image = 1}
        LabOff := round(((Length(Lab)*5) div 2)*ScaleLab);
        TextOut(PlXaxBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr)-LabOff,PlYaxBegPr+round(6*ScaleLab),Lab);
           {Top Tick Labels}
        if (BigXTick*i+ XoffUse - XLmin <= High(CopyOfTimeSt)) then
        BigTickTime := CopyOfTimeSt[BigXTick*i + Xoff - XLmin];
        if BigTickTime > 0.000001 then
        Lab := FloatToStrF(BigTickTime,ffFixed,8,DigAftZero) else Lab := '0';
        LabOff := round(((Length(Lab)*4) div 2)*ScaleLab);
        TextOut(PlXaxBegPr + round((BigXTick*i+(XoffUse-XSleft))*XscalePr)-LabOff,PlYaxEndPr-round(18*ScaleLab),Lab);
        end;
        if i = 0 then
        while (Xoff-XSleft)-(SmXTick*j) >= 0 do begin
           {Bottom - Images}
          MoveTo(PlXBegPr + round(((Xoff-XSleft)-(SmXTick*j))*XscalePr),PlYaxBegPr);
          LineTo(PlXBegPr + round(((Xoff-XSleft)-(SmXTick*j))*XscalePr),PlYaxBegPr+round(3*ScalePic));
           {Top - Seconds}
          MoveTo(PlXBegPr + round(((Xoff-XSleft)-(SmXTick*j))*XscalePr),PlYaxEndPr);
          LineTo(PlXBegPr + round(((Xoff-XSleft)-(SmXTick*j))*XscalePr),PlYaxEndPr-round(3*ScalePic));
          Inc(j);
        end;
        for j := 1 to NrSmXTick-1 do begin
          if PlXBegPr + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft) )*XscalePr) <= WinXSizePr Then Begin
            {Bottom - Images}
          MoveTo(PlXBegPr + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft) )*XscalePr),PlYaxBegPr);
          LineTo(PlXBegPr + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft))*XscalePr),PlYaxBegPr+round(3*ScalePic));
            {Top - Seconds}
          MoveTo(PlXBegPr + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft) )*XscalePr),PlYaxEndPr);
          LineTo(PlXBegPr + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft))*XscalePr),PlYaxEndPr-round(3*ScalePic));
          end;
        end;
      end;
    End; {With ... }

 End; {For i := BigXTickBeg to NrBigYTick}
   Canvas.Brush.Style := bsClear;
 
{-------------------------- End Plotting ---------------------------------}
   EndDoc;
  End;   {With Printer Do Begin}




End;


{*************************************************************************}
procedure TMainForm.FilePrint(Sender: TObject);

Var   R        : TRect;
      PrBMP    : TBitmap;
      ScreenDC : hDC;
      Portrait : Boolean;
      PagePartToUse : integer;
      ScalePic : Double;
      Pt       : TPoint;

{------------------------------------------------------------------------------}
Begin

If PrintDialog.Execute then  Begin


 {--------------------------------------------------------------------}
 If (sender = PrintTimeSerPlot) Then Begin
     if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      DoPrintTimeSerPlot(TSPlotData_BaseSubtr) else
      DoPrintTimeSerPlot(TSPlotData_BaseNotSubtr);

 {-------------- End of Printing PLOT -----------------------------------}
 End Else
 If (Sender = PrintMainImage) or (Sender = PrintAverImage) or (sender = PrintMergeImage) or
    (Sender = PrintAnyWindowInFocus) Then Begin
    With Printer Do Begin
     BeginDoc;
     {------------1st Copies to Temp BITMAP ---------------------------------}
     PrBMP := TBitmap.Create;
     PrBMP.HandleType := bmDIB; {not needed but I do it anyway}{could be bmDDB}
     If (Sender = PrintMainImage) then begin
      frmMainWin.Show;
      Application.ProcessMessages;
      {1st it tries to copy from TForm.Canvas in order to print all labels.
       TForm.Canvas must be unobscured. If the image is bigger than the Screeen
       then it prints from the TImage.Picture.Bitmap which might be obscured}
      if (frmMainWin.winMainImage.Picture.Bitmap.Width <= Screen.Width) and
         (frmMainWin.winMainImage.Picture.Bitmap.Height <= Screen.Height) then begin
      PrBMP.SetSize(frmMainWin.Canvas.ClipRect.Width,frmMainWin.Canvas.ClipRect.Height);
      PrBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings
      PrBMP.Canvas.CopyRect(PrBMP.Canvas.ClipRect,frmMainWin.Canvas,frmMainWin.Canvas.ClipRect);
      end
      else begin
      PrBMP.Assign(frmMainWin.winMainImage.Picture.Bitmap);
      PrBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings
      end;
     end;
     If (sender = PrintMergeImage) then Begin
      frmMergeWin.Show;
      Application.ProcessMessages;
      if (frmMergeWin.MergeImage.Picture.Bitmap.Width <= Screen.Width) and
         (frmMergeWin.MergeImage.Picture.Bitmap.Height <= Screen.Height) then begin
      PrBMP.SetSize(frmMergeWin.Canvas.ClipRect.Width,frmMergeWin.Canvas.ClipRect.Height);
      PrBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings
      PrBMP.Canvas.CopyRect(PrBMP.Canvas.ClipRect,frmMergeWin.Canvas,frmMergeWin.Canvas.ClipRect);
      end
      else begin
      PrBMP.Assign(frmMergeWin.MergeImage.Picture.Bitmap);
      PrBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings
      end;
     End Else
     If (sender = PrintAverImage) then Begin
      frmAverIm.Show;
      Application.ProcessMessages;
      if (frmAverIm.winAverImage.Picture.Bitmap.Width <= Screen.Width) and
         (frmAverIm.winAverImage.Picture.Bitmap.Height <= Screen.Height) then begin
      PrBMP.SetSize(frmAverIm.Canvas.ClipRect.Width,frmAverIm.Canvas.ClipRect.Height);
      PrBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings
      PrBMP.Canvas.CopyRect(PrBMP.Canvas.ClipRect,frmAverIm.Canvas,frmAverIm.Canvas.ClipRect);
      end
      else begin
      PrBMP.Assign(frmAverIm.winAverImage.Picture.Bitmap);
      PrBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings
      end;
     End Else
     If (Sender = PrintAnyWindowInFocus) Then Begin
    //The Paragraph below works but it Prints also the Printer menu//
   {  //Shows Plot if hidden and puts it On Top of Other Windows in order to copy Canvas
      frmTimeSerPlot.TimeSerPlotHidden := False;
      ShowWindow(frmTimeSerPlot.Handle,Sw_Show);
      with frmTimeSerPlot do begin
        WindowState := wsNormal;
        SetBounds(Screen.Width  div 2 - Width div 2,
             Screen.Height div 2 - Height div 2,Width,Height);
        Show;
      end; //with//
      Application.ProcessMessages; //needed//

      PrBMP.Width  := frmTimeSerPlot.Width;
      PrBMP.Height := frmTimeSerPlot.Height;

      ScreenDC := GetDC(0);
      Pt := ClientToScreen(Point(frmTimeSerPlot.Left, frmTimeSerPlot.Top));
      //BitBlt works; CopyRect does not work well if you want to copy Plot with System Bar;
      //if you want to copy plot without System Bar USE:
     // TemBmp.Canvas.CopyRect(frmTimeSerPlot.Canvas.ClipRect,
      //frmTimeSerPlot.Canvas,frmTimeSerPlot.Canvas.ClipRect);
      BitBlt(PrBMP.Canvas.Handle,0 ,0 ,PrBMP.Width,PrBMP.Height,ScreenDC, Pt.X + 2,Pt.Y + 2, SRCCOPY);
      //I dont know why + 2 pixels shold be added [found experimentally]
      //PrBMP = frmTimeSerPlot.GetFormImage did not work here - did not get title bar
      ReleaseDC(0,ScreenDC); }

      PrBMP.Assign(MainForm.ActiveMDIChild.GetFormImage); //much simpler and works well
     End;
      {------- end of Creating TemBitmap---}

     if Printer.PageWidth < Printer.PageHeight then Portrait := True else
     if Printer.PageWidth > Printer.PageHeight then Portrait := False;

     If Portrait = True then begin
        PagePartToUse := Printer.PageWidth - round((Printer.PageWidth/10)*2.5); {~75%}
        if PrBMP.Width >= PrBMP.Height then
           ScalePic := PagePartToUse/PrBMP.Width else
        if PrBMP.Width < PrBMP.Height then
           ScalePic := PagePartToUse/PrBMP.Height;
     End Else
     If Portrait = False then begin
        PagePartToUse := Printer.PageHeight - round((Printer.PageHeight/10)*2.5); {~75%}
        if PrBMP.Width >= PrBMP.Height then
           ScalePic := PagePartToUse/PrBMP.Width else
        if PrBMP.Width < PrBMP.Height then
           ScalePic := PagePartToUse/PrBMP.Height;
     End;

     If Portrait = True  then R.Left :=(Printer.PageWidth - PagePartToUse) div 2 else
     If Portrait = False then
        R.Left := ((Printer.PageWidth - Printer.PageHeight) div 2) +
                  ((Printer.PageHeight    - PagePartToUse)  div 2);

     If Portrait = True  then R.Top := R.Left else
     If Portrait = False then R.Top := (Printer.PageHeight - PagePartToUse)  div 2;
     R.Right      := R.Left + round(PrBMP.Width*ScalePic);
     R.Bottom     := R.Top  + round(PrBMP.Height*ScalePic);

     if Not(Sender = PrintAnyWindowInFocus) then
     Canvas.TextOut(R.Left,R.Top - Canvas.TextHeight(ImFtitle)*2,ImFtitle);
     PrBMP.PixelFormat := pf24bit; {Convert to 24 bit} {important Keep - would not print on laser printers}
                                   //after size settings
     Canvas.StretchDraw(R,PrBMP);
     FreeAndNil(PrBMP);


     {----------------------------------------------------------------}
     { Printer.PageWidth and Printer.PageHeight give With (usable) and Height
      in pixels (Multple of Resolution dpi x inches}

     EndDoc;
    End; {With Printer}
End; { Printing Images}
End; {if PrintDialog.Execute}
End; procedure TMainForm.FilePrintItemClick(Sender: TObject);
begin

end;

{procedure TMainForm.FilePrint(Sender: TObject);}
{******************************************************************************}
procedure TMainForm.FilePrintSetup(Sender: TObject);
begin
  PrintSetupDialog.Execute;
end;
{******************************************************************************}
procedure TMainForm.FileExit(Sender: TObject);
begin
  frmPlayback.Stop.Down := True;
  frmPlayback.StopClick(sender);
  Close;
end;
{******************************************************************************}
procedure TMainForm.HelpContents(Sender: TObject);
 var HelpCode : integer;
     HelpFName : string;
begin

  HelpFName := SparkAnDir + 'SparkAn Description.pdf';

  if FileExists(HelpFName) then
  //  ShellExecute(Handle, nil, PChar(HelpFName), nil,  nil, SW_SHOWNORMAL)
    ShellExecute(Handle, 'open', PChar(HelpFName), nil,  nil, SW_SHOWNORMAL)
  else
  begin
    MessageDlg('Help file not found.',mtInformation,[mbOK],0);
    Application.HelpCommand(HELP_CONTENTS, 0);
    HelpCode := 1;
    HELP_Point := Mouse.CursorPos;
    GetHelp(HelpCode);
  end;
End;
{******************************************************************************}
function TMainForm.GetSystemDriveLetter : Char;
var
  SysDir: array [0..MAX_PATH-1] of Char;
begin

  GetSystemDirectory(SysDir, MAX_PATH);
  //Returns: "Drive Letter:\Windows\System32"

  Result := SysDir[0];

end;
{******************************************************************************}
procedure TMainForm.HelpAbout(Sender: TObject);
begin
  if AboutBox = nil then Application.CreateForm(TAboutBox, AboutBox);
  
end;
{******************************************************************************}
procedure TMainForm.FormCreate(Sender: TObject);

 Var  pDragWin      : Pointer; //should be general pointer

Begin

  ImageWidthTable    := 0; { X & Y of First Andor Tiff  selected in table}
  ImageHeightTable   := 0;


  {BOOL SystemParametersInfo( UINT uiAction,
                              UINT uiParam,
                              PVOID pvParam,
                              UINT fWinIni
  Determines whether dragging of full windows is enabled.
  The pvParam parameter must point to a BOOL variable that receives TRUE if enabled,
  or FALSE otherwise }

  pDragWin := @CanSeeDragWin;
  SystemParametersInfo(SPI_GETDRAGFULLWINDOWS,1,pDragWin,0);
  if CanSeeDragWin = False then //To Show window contents while dragging:
  SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, 1, nil, 0) ;
  Direct2D_Supported := TDirect2DCanvas.Supported;
   {To disable this option call the function:  SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, 0, nil, 0);}

  SparkAnDir := GetCurrentDir + '\';
  InitVarOnStart;

  if (PrevImFileName <> '') then begin
     FilePaths.AverImFilePath          := ExtractFilePath(PrevImFileName);
     FilePaths.MarkFilePath            := ExtractFilePath(PrevImFileName);
     FilePaths.QFilePath               := ExtractFilePath(PrevImFileName);
     FilePaths.ROIFilePath             := ExtractFilePath(PrevImFileName);
     FilePaths.PLOTFilePath            := ExtractFilePath(PrevImFileName);
     FilePaths.PeaksFilePath           := ExtractFilePath(PrevImFileName);
     FilePaths.PeakMeansFilePath       := ExtractFilePath(PrevImFileName);
     FilePaths.SingleImageFilePath     := ExtractFilePath(PrevImFileName);
     FilePaths.MultipleImagesFilePath  := ExtractFilePath(PrevImFileName);

   end;

   HELP_SrtList := TStringList.Create;

   // memory (RAM) Usage

   cbLoadFilesInRAM.Checked := RAM_Usage.LoadFilesInRAM;
   TimerToGetMemoryUsageTimer(Sender);

End;   //procedure TMainForm.FormCreate(Sender: TObject);
 {******************************************************************************}

procedure TMainForm.TimerToGetMemoryUsageTimer(Sender: TObject);
//Timer interval set to 5000 = 5000 ms = 5 sec
var MemUsed       : Cardinal;
    UsedBySparkAn : string;
    AvailableRAM  : string;
    TotalRAM      : string;
    MemStatus     : TMemoryStatusEx;
begin

  MemUsed := MemoryUsedByProgram;
  if (MemUsed < 10485) then
    UsedBySparkAn :=  FloatToStrF(MemoryUsedByProgram/1024,ffFixed,5,2) + ' kB,' else
  if (MemUsed > 10485) and (MemUsed < 1.07374E7) then
    UsedBySparkAn :=  FloatToStrF(MemoryUsedByProgram/1048576,ffFixed,5,2) + ' MB,' else
  if (MemUsed > 1.07374E7) then
    UsedBySparkAn :=  FloatToStrF(MemoryUsedByProgram/1073741824,ffFixed,5,2) + ' GB,';

  MemStatus  := GetGlobalMemoryRecord;
  AvailableRAM := FloatToStrF(MemStatus.ullAvailPhys/1073741824,ffFixed,5,2) + ' GB,';
  TotalRAM := FloatToStrF(MemStatus.ullTotalPhys/1073741824,ffFixed,5,2) + ' GB   ';

  lbMemUsage.Caption := '  RAM: used by SparkAn = ' + UsedBySparkAn +
                         ' Available = ' + AvailableRAM +
                         ' Total = ' + TotalRAM;
end;

procedure TMainForm.ubGetFileInfoClick(Sender: TObject);
var HelpCode : integer;
begin
 if (MainImLoaded)  then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 2;
  GetHelp(HelpCode);
 end;

end;

{*******************************************************************************}
procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
 var fh : integer;

begin   

        frmPlayback.StopClick(Sender);
        StopSearch := True;
        StopAnal   := True;
        Application.ProcessMessages;

        If (ImFileOpen = True) then Begin
          if (ImageFileType = MULTI_IMAGE) then begin
            FileClose(ImFile);
          end else
          if (ImageFileType = FILE_COLLECTION) then begin
            for fh := 0 to High(CollFileHandlesList) do FileClose(CollFileHandlesList[fh]); 
          end;
        End; //If (ImFileOpen = True)

        //1st memorize Win3DXYsize - sets X = Y
        {this is done also in frm3DImageWin.Close in case the Program is
         still running but only 3D window is being closed}
        if (frm3DImageWin <> nil) then Begin
          if (frm3DImageWin.ClientWidth < frm3DImageWin.ClientHeight) then
            Win3DXYsize := frm3DImageWin.ClientWidth else
          if (frm3DImageWin.ClientWidth >= frm3DImageWin.ClientHeight) then
            Win3DXYsize := frm3DImageWin.ClientHeight;
        end;

        FreeMemBMPused; //frees memory

        FreeAndNil(memBMP);
        FreeAndNil(IntBMP);

        if frmTimeSerPlot.PlotMemBMP <> nil then FreeAndNil(frmTimeSerPlot.PlotMemBMP);

        Clipboard.Clear;

        HELP_SrtList.Free;
        
        WriteSparkAnPar(SparkAnDir + 'SparkAn.par');

        if (CanSeeDragWin) = False then SystemParametersInfo(SPI_SETDRAGFULLWINDOWS, 0, nil, 0) ;
        //To Restore Disabled option of Show window contents while dragging:
 
end;
{******************************************************************************}

Procedure TMainForm.FileMenuClick(Sender: TObject); {Enables & Disables}
   {Function ProcessPath is declared in FileCtrl unit}
 

Begin

      {------- Showing File Name}
  If (PrevImFileName <> '') Then Begin
    If not(AllowFullPath) Then Begin
        mnPreviousFile.Visible := True;
        if (Length(ExportBIM.Caption) < Length(PrevImFileName)) and
           (Length(ExtractFileDir(PrevImFileName)) > 3) then begin
          mnPreviousFile.Caption := ExtractFileDrive(PrevImFileName) + '\..\' +
                                    ExtractFileName(PrevImFileName);
       end else mnPreviousFile.Caption := PrevImFileName;
    End Else
    If AllowFullPath = True Then Begin
       mnPreviousFile.Caption := PrevImFileName;
    End;                                  
  End Else mnPreviousFile.Visible := False;
      {--------------------}


      if (NrFiles > 0) then SavePlaylist.Enabled := True else
                            SavePlaylist.Enabled := False;
      if High(QFileList) >= 0 then
        SaveQueueFile.Enabled := True else
        SaveQueueFile.Enabled := False;
        
      if (TimeSerAnalDone = True) then Begin  {Once is True is Always True }
        ExportPlot.Enabled         := True;
        PrintTimeSerPlot.Enabled   := True;
        SavePlotPanelAsBMP.Enabled := True;
        SaveMetafIle.Enabled       := True;
      end else
      if (TimeSerAnalDone = False) then Begin
        ExportPlot.Enabled         := False;
        PrintTimeSerPlot.Enabled   := False;
        SavePlotPanelAsBMP.Enabled := False;
        SaveMetafIle.Enabled       := False;
      end;
      ExportDataAsTXT.Enabled := ExportPlot.Enabled;

      if (frmSurfaceROI = nil) then SaveFreehandROISurface.Enabled := False else
                                    SaveFreehandROISurface.Enabled := True;


      If (IntegrTableEmpty) then
        ExportArea.Enabled := False
      Else
        ExportArea.Enabled := True;

      
      if (PeakPosArr =  nil) then begin
        ExportPeaks.Enabled     := False;
        ExportPeakMeans.Enabled := False;
      end else
      if PeakPosArr <> nil then begin
        ExportPeaks.Enabled     := True;
        ExportPeakMeans.Enabled := True;
      end;

      If (MainImLoaded) then Begin
        SaveMainWindow.Enabled := True;

        if (NrChannels > 1) and (frmMergeWin <> nil) then begin
          SaveMergeWindow.Enabled := True;
          PrintmergeImage.Enabled := True;
          SaveConsecutiveImagesfromMergeWindow.Enabled := True;
          mnMakeMoviefromMergeWindow.Enabled := True;
        end else
        begin
          SaveMergeWindow.Enabled := False;
          PrintmergeImage.Enabled := False;
          SaveConsecutiveImagesfromMergeWindow.Enabled := False;
          mnMakeMoviefromMergeWindow.Enabled := False;
        end;

        if (NrChannels > 1) and (frm2ndWin <> nil) then begin
          SaveSecondaryWindow.Enabled := True;
          SaveConsecutiveImagesfrom2ndWindow.Enabled := True;
        end else
        begin
          SaveSecondaryWindow.Enabled := False;
          SaveConsecutiveImagesfrom2ndWindow.Enabled := False;
        end;

        if (RAM_Usage.KindOfModMovie > NOT_MODIFIED) then
        SaveProcessedMovieFiles.Enabled := True
          else
        SaveProcessedMovieFiles.Enabled := False;
        PrintMainImage.Enabled        := True;
        CloseImageFile.Enabled        := True;
        OpenMarkFile.Enabled          := True;
        OpenSpatialSpreadFile.Enabled := True;
        OpenMeasuringLineFile.Enabled := True;
        if (frmSpatialSpread <> nil) then begin
          SaveSpatialSpreadFile.Enabled := Not(frmSpatialSpread.TableEmpty);
        end else
        if (frmSpatialSpread = nil) then begin
          if (SpreadImNr <> nil) then SaveSpatialSpreadFile.Enabled := True else
                                      SaveSpatialSpreadFile.Enabled := False;
        end;
        ROIFile.Enabled               := True;
        OpenROIfile.Enabled           := True;
        if ((ImageFileType = MULTI_IMAGE) and (TIFFfileType = TIFF_ANDOR_iQ)) or
            (ImageFileType = FILE_COLLECTION) then
        SaveCollectionOfMultiImageTiffs.Enabled := True else
        SaveCollectionOfMultiImageTiffs.Enabled := False;
        if ROIvar.NrROI > 0 then SaveROIfile.Enabled        := True Else
        if ROIvar.NrROI = 0 then SaveROIfile.Enabled        := False;
        SaveSmallEventsMarkFile.Enabled := Not(SpTabEmpty);
        SaveBigEventsMarkFile.Enabled   := Not(BigTabEmpty);
        if (NrIm > 1) then Begin
          SaveConsecutiveImages.Enabled := True;
          mnMakeMovie.Enabled  := True;
          AverageFile.Enabled    := True;
        end else
        if (NrIm = 1) then begin
        SaveConsecutiveImages.Enabled := False;
        SaveConsecutiveImagesfromMergeWindow.Enabled := False;
        SaveConsecutiveImagesfrom2ndWindow.Enabled := False;
        Save3DWindowConsecutiveImages.Enabled := False;
        mnMakeMovie.Enabled  := False;
        AverageFile.Enabled    := False;
        end;
      end else
      if not(MainImLoaded) then Begin
        SaveProcessedMovieFiles.Enabled := False;
        SaveMainWindow.Enabled        := False;
        SaveMergeWindow.Enabled       := False;
        SaveSecondaryWindow.Enabled   := False;
        SaveConsecutiveImages.Enabled := False;
        SaveConsecutiveImagesfromMergeWindow.Enabled := False;
        SaveConsecutiveImagesfrom2ndWindow.Enabled := False;
        Save3DWindowConsecutiveImages.Enabled := False;
        mnMakeMoviefromMergeWindow.Enabled := False;
        PrintMainImage.Enabled        := False;
        CloseImageFile.Enabled        := False;
        AverageFile.Enabled           := False;
        OpenMarkFile.Enabled          := False;
        SaveSmallEventsMarkFile.Enabled := False;
        SaveBigEventsMarkFile.Enabled   := False;
        OpenSpatialSpreadFile.Enabled := False;
        SaveSpatialSpreadFile.Enabled := False;
        OpenROIfile.Enabled           := False;
        SaveROIfile.Enabled           := False;
        ROIFile.Enabled               := False;
        mnMakeMovie.Enabled  := False;
        SaveCollectionOfMultiImageTiffs.Enabled := False;
        OpenMeasuringLineFile.Enabled := False;
      end;

      {AvImExists: Byte; 0 = No Av Image, 1 = Selected, 2 = From File, 3 = From Minimum}
      if (AvImExists > 0) and (frmAverIm <> nil) then begin
          PrintAverImage.Enabled        := True;
          SaveAverageImageAsBMP.Enabled := True;
          SaveAverageFileAsSPN.Enabled  := True;
      end else
      if (AvImExists = 0) or (frmAverIm = nil) then begin
          PrintAverImage.Enabled        := False;
          SaveAverageImageAsBMP.Enabled := False;
          SaveAverageFileAsSPN.Enabled  := False;
      end;

      if (PrintMainImage.Enabled = True) or (PrintAverImage.Enabled = True) or
         (PrintTimeSerPlot.Enabled = True) then
          FilePrintItem.Enabled := True else
      if (PrintMainImage.Enabled = False) and (PrintAverImage.Enabled = False) and
         (PrintTimeSerPlot.Enabled = False) then
          FilePrintItem.Enabled := False;

      if (LineScanExist) then begin
        SaveLineScanImageAsBMP.Enabled := True;
        SaveLineScanPanel.Enabled := True;
      end  else
      begin
        SaveLineScanImageAsBMP.Enabled := False;
        SaveLineScanPanel.Enabled := False;
      end;

      if (Win3DOn) then begin
        Save3Dwindow.Enabled := True;
        if (SourceFor3D = MAIN_IMAGE_FOR_3D) or (SourceFor3D = MERGE_IMAGE_FOR_3D) then begin
          mnMakeMoviefrom3D.Enabled := True;
          Save3DWindowConsecutiveImages.Enabled := True;
        end else
        begin
          mnMakeMoviefrom3D.Enabled := False;
          Save3DWindowConsecutiveImages.Enabled := False;
        end;
      end else
      begin
        Save3Dwindow.Enabled := False;
        mnMakeMoviefrom3D.Enabled := False;
        Save3DWindowConsecutiveImages.Enabled := False;
      end;

      if (MesLine.OpCode = DO_EXIST) then SaveMeasuringLineFile.Enabled := True else
                                          SaveMeasuringLineFile.Enabled := False;


End;

procedure TMainForm.CloseImageFileClick(Sender: TObject);
var fh : Integer;
begin

        //shut off frmRealLineScan if it was on
      if (RealLineScanOn) then begin
        frmRealLineScan.ubOn.Selected := False;
        frmRealLineScan.ubOn.Click;
      end;

      if (frmImageControl.sbSetROItracking.Down) then begin
        //release Track button if depressed
        frmImageControl.sbSetROItracking.Down := False;
        frmImageControl.DoSetROItracking(False); //False = Do not update image
      end;

      if (frmImageControl.ubSetDiamMes.Selected) then begin
        frmImageControl.ubSetDiamMes.Selected := False;
        frmImageControl.ubSetDiamMesClick(Sender);
      end;

      If (FileInRAM) Then Begin
        FileInRAM := False;
        RawDataInRAM := nil;
      End Else
      Begin
        If (ImageFileType = MULTI_IMAGE) Then Begin
          FileClose(ImFile);
          ImFileOpen := False;
          ImFname := '';
        End Else
        If (ImageFileType = FILE_COLLECTION) Then Begin
          for fh := 0 to High(CollFileHandlesList) do begin
            FileClose(CollFileHandlesList[fh]);
          end;
          ImFileOpen := False;
        End;
      End;

      with frmPlayback do begin
      PlaybackToolBar.Enabled         := False;
      PlaybackScrollBar.Enabled       := False;
      cmbPlayMode.Enabled   := False;
      LoopFrom.HideText  := True;
      LoopTo.HideText    := True;
      GoToInput.HideText := True;
      LockImagesToLoop.Enabled := False;
      end;

      with frmImageControl do begin

      if (RatioOn) then begin
        ubRatioOn.Selected := False;
        ubRatioOn.Click;
      end;
      ubRatioOn.Enabled    := False;

      if (ChannelsRatioOn) then begin
        unChDivCh.Selected := False;
        unChDivCh.Click;
      end;
      unChDivCh.Enabled    := False;

      if (ubSizeBar.Selected) then begin
        ubSizeBar.Selected := False;
        ubSizeBar.Click;
      end;
      ubSizeBar.Enabled := False;

      if (ubGrid.Selected) then begin;
        ubGrid.Selected := False;
        ubGrid.Click;
      end;
      ubGrid.Enabled := False;

      if not(ubApplyFrame.Selected) then begin
        ubApplyFrame.Selected := False;
        ubApplyFrame.Click;
         // it is also clicked when TfrmImageControl.SelectClick is called by OpenImageFile procedure
      end;
      ubApplyFrame.Enabled := False;

      // it is also clicked when TfrmImageControl.SelectClick is called at the end of this procedure

      ToolsToolBar.Enabled := False;
      DSPixRange.SetSliderPos(DSPixRange.Min,DSPixRange.Max);
      PaintHistWindow;
      DSPixRange.Enabled  := False;
      enPixRange.HideText := True;
      enPixRange.Enabled  := False;
      SetRange.Enabled    := False;
      end;


      with frmTimeSerPlot do begin
      dsAnalRange.Enabled := False;
      enAnalFromTo.HideText := True;
      enAnalFromTo.Enabled := False;
      StartAnal.Enabled := False;
      end;
      if frmSPautoSearch <> nil then with frmSPautoSearch Do Begin
      StartSearch.Enabled   := False;
      EdnSearchFromTo.HideText := True;
      dsSerchFromTo.Enabled    := False;
      EdnSearchFromTo.Enabled  := False;
      end;

      with  frmMainWin.winMainImage do begin
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Canvas.ClipRect);
        frmMainWin.Caption := 'Main Window';
      end;

      AvImExists := 0;
      if (frmAverIm <> nil) then
      with frmAverIm.winAverImage do begin
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Canvas.ClipRect);
        Caption := 'No Average';
      end;

      if (frm2ndWin <> nil) then
      with frm2ndWin.win2ndImage do begin
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Canvas.ClipRect);
      end;

      if (frmMergeWin <> nil) then
      with frmMergeWin.MergeImage do begin
        Canvas.Brush.Color := clBlack;
        Canvas.FillRect(Canvas.ClipRect);
      end;

      if (frmOrthogonalSectioning <> nil) then begin
        frmOrthogonalSectioning.ubOnOff.Selected := False;
        frmOrthogonalSectioning.ubOnOffClick(Sender);
      end;

      if (frmXYprofile <> nil) then begin
        MainImLoaded := True; //Temp to enable the Form to change labels
        frmXYprofile.ubOnOff.Selected := False;
        frmXYprofile.ubOnOffClick(Sender);
        MainImLoaded := False;
      end;

      if (LineScanExist) then frmLineScan.UpdateLSwindows(ERASE_SCREEN);
      lbFileLoadedInRAMsign.Caption := '';

       MainImLoaded := False;
       ImFileOpen := False;
End;
{---------------- These are Window Open Functions}

procedure TMainForm.viewMainWindowClick(Sender: TObject);
begin
  frmMainWin.frmMainWinHidden := False;
  with frmMainWin do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      ShowWindow(frmMainWin.Handle,Sw_Show);
  end; {with}
end;

procedure TMainForm.viewOrtogonalSectionsClick(Sender: TObject);
begin
  if (frmOrthogonalSectioning = nil)
  then Application.CreateForm(TfrmOrthogonalSectioning, frmOrthogonalSectioning)
  else with frmOrthogonalSectioning do begin
    WindowState := wsNormal;
    SetBounds(Screen.Width  div 2 - Width div 2,
              Screen.Height div 2 - Height div 2,
              Width,Height);
    Show;
  end;
end;

procedure TMainForm.viewAverageWindowClick(Sender: TObject);
begin
    if frmAverIm = nil then Application.CreateForm(TfrmAverIm, frmAverIm)
    else with frmAverIm do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
    end;
end;

procedure TMainForm.SecondaryWindowClick(Sender: TObject);
begin
  if (frm2ndWin = nil) then Application.CreateForm(Tfrm2ndWin, frm2ndWin)
  else with frm2ndWin do begin
    WindowState := wsNormal;
    SetBounds(Screen.Width  div 2 - Width div 2,
              Screen.Height div 2 - Height div 2,
              Width,Height);
    Show;
  end;
End;

procedure TMainForm.MergeWindowClick(Sender: TObject);
begin
  if (frmMergeWin  = nil) then Application.CreateForm(TfrmMergeWin ,frmMergeWin)
  else with frmMergeWin do begin
    WindowState := wsNormal;
    SetBounds(Screen.Width  div 2 - Width div 2,
              Screen.Height div 2 - Height div 2,
              Width,Height);
    Show;
  end;
end;

procedure TMainForm.viewBleachingCorrectionClick(Sender: TObject);
begin
    if (frmCorrectForBleaching = nil) then Application.CreateForm(TfrmCorrectForBleaching, frmCorrectForBleaching)
    else with frmCorrectForBleaching do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
    end;
end;

procedure TMainForm.viewPlaybackWindowClick(Sender: TObject);
begin

  with frmPlayback do begin
       SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
       if (frmPlayBack.Docked = True) then begin
        frmMainWin.SetBounds(frmPlayBack.Left + frmPlayBack.Xoffset,
                frmPlayback.Top - frmMainWin.Height,
                Width,Height);
       end;
  end; {with}
end;

procedure TMainForm.viewImageControlClick(Sender: TObject);
begin
  frmImageControl.frmImContrHidden := False;
  with frmImageControl do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      ShowWindow(frmImageControl.Handle,Sw_Show);
  end; {with}
end;

procedure TMainForm.viewTimeSeriesAnalysisClick(Sender: TObject);
begin
    frmTimeSerPlot.TimeSerPlotHidden := False;
    with frmTimeSerPlot do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      ShowWindow(frmTimeSerPlot.Handle,Sw_Show);
    end; {with}
End;

procedure TMainForm.viewTimeSeriesAnalysisSlaveClick(Sender: TObject);
begin
  if frmSlaveTSPlot = nil then Application.CreateForm(TfrmSlaveTSPlot, frmSlaveTSPlot)
  else with frmSlaveTSPlot do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.viewXorYProfileClick(Sender: TObject);
begin
  if (frmXYprofile = nil) then Application.CreateForm(TfrmXYprofile, frmXYprofile)
  else with frmXYprofile do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.viewEventAutoDetectionClick(Sender: TObject);
begin
  if (frmSPautoSearch = nil) then Application.CreateForm(TfrmSPautoSearch, frmSPautoSearch)
  else with frmSPautoSearch do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
End;

procedure TMainForm.viewEventSitesClick(Sender: TObject);
begin
  if frmEventSites = nil then Application.CreateForm(TfrmEventSites, frmEventSites)
  else with frmEventSites do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.viewSpatialSpreadTableClick(Sender: TObject);
begin
  {if ActiveMDIChild <> nil then}
  if frmSpatialSpread = nil then Application.CreateForm(TfrmSpatialSpread, frmSpatialSpread)
  else with frmSpatialSpread do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.viewIntegrateWinClick(Sender: TObject);
begin
{if ActiveMDIChild <> nil then}
  if frmIntegrate = nil then Application.CreateForm(TfrmIntegrate, frmIntegrate)
  else with frmIntegrate do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.viewKalmanStackFilterClick(Sender: TObject);
begin
{if ActiveMDIChild <> nil then}
  if frmKalmanStackFilter = nil then Application.CreateForm(TfrmKalmanStackFilter, frmKalmanStackFilter)
  else with frmKalmanStackFilter do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.viewSparkTableClick(Sender: TObject);
begin
 {if ActiveMDIChild <> nil then}
  if frmSparkTable = nil then Application.CreateForm(TfrmSparkTable, frmSparkTable)
  else with frmSparkTable do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;

procedure TMainForm.CaWavesTableClick(Sender: TObject);
begin

   if frmWaveTable = nil then Application.CreateForm(TfrmWaveTable, frmWaveTable)
   else with frmWaveTable do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
   end;
end;

procedure TMainForm.cbLoadFilesInRAMClick(Sender: TObject);
begin
   RAM_Usage.LoadFilesInRAM := cbLoadFilesInRAM.Checked;
end;

procedure TMainForm.QueueFileTableClick(Sender: TObject);
begin
   if frmQueueFiles = nil then Application.CreateForm(TfrmQueueFiles, frmQueueFiles)
   else with frmQueueFiles do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
   end;

end;


procedure TMainForm.PeaksTableClick(Sender: TObject);
begin
     if frmPeaks = nil then  Application.CreateForm(TfrmPeaks, frmPeaks)
     else with frmPeaks do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
     end;
end;

procedure TMainForm.TimeHistogramsClick(Sender: TObject);
begin
     if frmTimeHistograms = nil then  Application.CreateForm(TfrmTimeHistograms, frmTimeHistograms)
     else with frmTimeHistograms do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
     end;

end;


procedure TMainForm.RealLineScanWindowClick(Sender: TObject);
begin
  if frmRealLineScan = nil then  Application.CreateForm(TfrmRealLineScan, frmRealLineScan)
    else with frmRealLineScan do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
   end;

end;

procedure TMainForm.LineScanWindowClick(Sender: TObject);
begin
    if frmLineScan = nil then  Application.CreateForm(TfrmLineScan, frmLineScan)
    else with frmLineScan do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
    end;
end;


procedure TMainForm.N3DWindowControlsClick(Sender: TObject);
begin
   if frm3DImageWin = nil then begin
    Application.CreateForm(Tfrm3DImageWin, frm3DImageWin);
    Application.CreateForm(Tfrm3DImageContr, frm3DImageContr);
   end
   else begin
    with frm3DImageWin do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
    end;
    with frm3DImageContr do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2 + frm3DImageWin.Width,
                Screen.Height div 2 - Height div 2,
                Width + frm3DImageWin.Width,Height);
      Show;
    end;
   end;

end;

procedure TMainForm.FileListClick(Sender: TObject);
begin
  if frmFileList = nil then Application.CreateForm(TfrmFileList,frmFileList)
  else with frmFileList do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;
end;



procedure TMainForm.MovieCommentsTimersDialogClick(Sender: TObject);
begin
    if frmMovieLabels = nil then Application.CreateForm(TfrmMovieLabels, frmMovieLabels)
    else with frmMovieLabels do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
   end;

end;

procedure TMainForm.CopyWindowClick(Sender: TObject);
begin
if frmCopyWindow = nil then Application.CreateForm(TfrmCopyWindow,frmCopyWindow)
  else with frmCopyWindow do begin
      WindowState := wsNormal;
      SetBounds(Screen.Width  div 2 - Width div 2,
                Screen.Height div 2 - Height div 2,
                Width,Height);
      Show;
  end;

end;



{-------------------- End of Windows Showing Functions --------------------}
procedure TMainForm.OptionsClick(Sender: TObject);
begin
        Application.CreateForm(TOptionsPagesDlg, OptionsPagesDlg);
     
end;

procedure TMainForm.GetHardDriveNrClick(Sender: TObject);
 var
    
     VolumeSerialNumber :DWORD;
     MaximumComponentLength : DWORD;
     FileSystemFlags  : DWORD;
     HelpCode : Word;
begin


   GetVolumeInformation(PChar(GetSystemDriveLetter + ':\'),nil,0,@VolumeSerialNumber,
                        MaximumComponentLength,FileSystemFlags,nil,0);

   with HELP_SrtList do begin
   Clear;
   Add('System Hard Drive Serial Number is: ');
   Add(IntToStr(VolumeSerialNumber));

   HELP_Point.X := (Screen.Width) div 2 -
   (MainForm.Canvas.TextWidth(Strings[0]) + 16) div 2;

   HELP_Point.Y := (Screen.Height) div 2 - (
   MainForm.Canvas.TextHeight(Strings[0])*Count + 45) div 2;
   HelpCode  := 5;
   GetHelp(HelpCode);
   end;
End;



procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

      If (Button = mbRight) then
      Application.CreateForm(TOptionsPagesDlg, OptionsPagesDlg);

end;



procedure TMainForm.FormResize(Sender: TObject);
begin
  MenuPanel.SetBounds(MenuToolBar.Width,0,MainForm.ClientWidth-MenuToolBar.Width,MenuPanel.Height);

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
//MenuPanel.SetBounds(MenuToolBar.Width,0,MainForm.ClientWidth-MenuToolBar.Width,MenuPanel.Height);
end;

procedure TMainForm.ileHorizontal1Click(Sender: TObject);
begin
        TileMode := tbHorizontal;
        Tile;
end;

procedure TMainForm.ileVertical1Click(Sender: TObject);
begin
       TileMode := tbVertical;
        Tile;
end;


procedure TMainForm.Cascade1Click(Sender: TObject);
begin
      Cascade;
end;



procedure TMainForm.ArrangeAll1Click(Sender: TObject);
begin
    ArrangeIcons;
end; 
{----------------------------------------------------------------}

Procedure TMainForm.CopyToClipBoard(Sender: TObject);{(aCanvas : TCanvas); }{clipboard.assign(bitmap);}

Var TemBmp : TBitmap;
    SourceRect : TRect;
    SaveAsFile : Boolean;
    CropXY, Cnt : Integer;

    procedure SetBMPsize (aImage : TImage);
    begin
        TemBmp.SetSize(aImage.Width,aImage.Height);
        SourceRect := aImage.Canvas.ClipRect;
    end;

    procedure CopyToBMP (aForm : TForm; aImage : TImage);
    begin
      clipboard.Clear;
      aForm.Show;
      Application.ProcessMessages; //Keep!
      if (SourceRect.Width  <= Screen.Width) and
         (SourceRect.Height <= Screen.Height) then
        TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,aForm.Canvas,SourceRect)
      else
        TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,aImage.Canvas,SourceRect);
      Clipboard.Assign(TemBmp);
      FreeAndNil(TemBmp);
    end;
Begin

 If (sender = CopyMainImage) or (sender = CopyMergeImage) or (sender = CopyAverageImage) or
    (sender = CopySecondaryImage) or (sender = Copy3DWindow) then Begin

     TemBmp := TBitmap.Create;

     if (frmImageControl.ubApplyFrame.Selected) and Not(sender = Copy3DWindow) then
      GetSelFrameParams(TemBmp,SourceRect.Left,SourceRect.Top,SourceRect.Right,SourceRect.Bottom) else
     begin
      if (sender = CopyMainImage)      then SetBMPsize(frmMainWin.winMainImage) else
      if (sender = CopyMergeImage)     then SetBMPsize(frmMergeWin.MergeImage) else
      if (sender = CopyAverageImage)   then SetBMPsize(frmAverIm.winAverImage) else
      if (sender = CopySecondaryImage) then SetBMPsize(frm2ndWin.win2ndImage) else
      if (sender = Copy3DWindow)       then SetBMPsize(frm3DImageWin.Image3DWin);
     end;

     TemBMP.PixelFormat := pf24bit; //Convert to 24 bit Important!!! after size settings

 End;
 {------------------------------------}
 If (sender = CopyMainImage) then Begin
      CopyToBMP(frmMainWin,frmMainWin.winMainImage);
     {Till 6-23-2017 it used to copy from TImage.Canvas, for example frmMainWin.winMainImage.Canvas
      but then it won't copy the labels placed by Movie Comments Panel.  They exists on
      the TForm.Canvas but not on the TImage.Canvas.  Everything that we see (iamges, Buttons, etc.)
      resides on the TForm.Canvas.  It should not be obscured though.  That's why 1st we use
      Show command and then (mandatory) Application.ProcessMessages;}
 End Else
 If (sender = CopyMergeImage) then Begin
   CopyToBMP(frmMergeWin,frmMergeWin.MergeImage);
 End Else
 If (sender = CopySecondaryImage) then Begin  //2nd channel window = secondary window
   CopyToBMP(frm2ndWin,frm2ndWin.win2ndImage);
 End Else
 if (sender = CopyAverageImage) then Begin
   CopyToBMP(frmAverIm,frmAverIm.winAverImage);
 End Else
 If (sender = Copy3Dwindow) then Begin
    CopyToBMP(frm3DImageWin,frm3DImageWin.Image3DWin);
 End Else

 If (sender = CopyAnyWindowInFocus) then Begin
    Clipboard.Clear;
    //only ActiveMDIChild works to identify the Form in Focus; Application.Components does not work
    Clipboard.Assign(MainForm.ActiveMDIChild.GetFormImage);
 End Else

 If (sender = CopyCalibrationBar) then Begin
   clipboard.Clear;
   clipboard.assign(frmImageControl.ColorBar.Picture.Bitmap);
 End Else

 If (sender = CopyTimeSeriesPlotImage) then Begin
   clipboard.Clear;
   clipboard.assign(frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap);
 End Else

 if (sender = CopyLineScanImage) then begin
    clipboard.Clear;
    if Not((SmoothMode > NO_SMOOTH) and ((RatioOn) or (SmoothNonRatio > NO_SMOOTH_NON_RATIO))) then begin
      clipboard.assign(frmLineScan.imLineScan.Picture.Bitmap);
    end else
    if (SmoothMode > NO_SMOOTH) and ((RatioOn) or (SmoothNonRatio > NO_SMOOTH_NON_RATIO)) then begin

     if (SmoothMode = SMOOTH_BOX) then CropXY := BoxSmSize else
     if (SmoothMode = SMOOTH_MED) then CropXY := MedSmSize else
     if (SmoothMode = SMOOTH_GAUSS) then CropXY := GaussSmSize else
     if (SmoothMode in[SMOOTH_BOX_MED,SMOOTH_MED_BOX]) then begin //chooses the bigger one
      if (BoxSmSize >= MedSmSize) then CropXY := BoxSmSize else
                                       CropXY := MedSmSize;
     end else
     if (SmoothMode in[SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin //chooses the bigger one
      if (MedSmSize >= GaussSmSize) then CropXY := MedSmSize else
                                         CropXY := GaussSmSize;
     end;
     CropXY := CropXY shr 1;
     TemBmp := TBitmap.Create;
     TemBmp.SetSize(frmLineScan.imLineScan.Width   - CropXY shl 1,frmLineScan.imLineScan.Height - CropXY shl 1);
     with frmLineScan.imLineScan.Canvas do begin
      SourceRect.Left   := ClipRect.Left   + CropXY;
      SourceRect.Right  := ClipRect.Right  - CropXY;
      SourceRect.Top    := ClipRect.Top    + CropXY;
      SourceRect.Bottom := ClipRect.Bottom - CropXY;
     end;
     TemBmp.Canvas.CopyRect(TemBmp.Canvas.ClipRect,frmLineScan.imLineScan.Canvas,SourceRect);
     clipboard.assign(TemBmp);
     FreeAndNil(TemBmp);
    end; //if (RatioOn) and (SmoothMode > NO_SMOOTH)
   end else
 If (sender = CopyLineScanPanel) then Begin
    clipboard.Clear;
    clipboard.assign(frmLineScan.GetFormImage);
 End Else

 //-----------------------------------------------------------------------//
 If (sender = CopyPlotToMetaFile) then Begin
  SaveAsFile := False;
  if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
  MakeMetaFile(SaveAsFile,TSPlotData_BaseSubtr,'') else
  MakeMetaFile(SaveAsFile,TSPlotData_BaseNotSubtr,''); {'' is just an empty string [file name}
  DrawTimeSerPlotYticks;  // Have to do it because somewhow Y tick dissapear after MakeMetaFile
 End;


End; {
{****************************************************************}
procedure TMainForm.CopyToClipbordClick(Sender: TObject);

begin

     if (MainImLoaded) then CopyMainImage.Enabled := True else
                            CopyMainImage.Enabled := False;

     if (MainImLoaded) and (NrChannels > 1) then begin
        if (frmMergeWin <> nil) then CopyMergeImage.Enabled := True
                                else CopyMergeImage.Enabled := False;
        if (frm2ndWin <> nil)   then CopySecondaryImage.Enabled := True
                                else CopySecondaryImage.Enabled := False;
     end
      else
     begin
       CopyMergeImage.Enabled := False;
       CopySecondaryImage.Enabled := False;
     end;

     if (TimeSerAnalDone = True) then Begin  {Once is True is Aways True }
        CopyTimeSeriesPlotImage.Enabled  := True;
        CopyPlotToMetaFile.Enabled       := True;
      end else
      if (TimeSerAnalDone = False) then Begin
        CopyTimeSeriesPlotImage.Enabled  := False;
        CopyPlotToMetaFile.Enabled       := False;
      end;

      if (AvImExists > 0) and (frmAverIm <> nil) then CopyAverageImage.Enabled := True else
                                                      CopyAverageImage.Enabled := False;

      if (Win3DOn) then Copy3Dwindow.Enabled := True else
                        Copy3Dwindow.Enabled := False;

      if (LineScanExist) then begin
         CopyLineScanPanel.Enabled := True;
         CopyLineScanImage.Enabled := True;
      end else begin
        CopyLineScanPanel.Enabled := False;
        CopyLineScanImage.Enabled := False;
      end;

end;

procedure TMainForm.mnPreviousFileClick(Sender: TObject);
 var SilentMode         : Boolean;
     ValidFile          : Boolean;
     TempPrevImFindex   : Byte;
     TempMultiImageTIFF : Boolean;
     TemBigTiff         : Boolean;
     TempPrevImFile     : AnsiString;
     TemStr             : AnsiString;
     SearchRec          : TSearchRec;

Begin


  if (mnPreviousFile.Caption <> '') then Begin
    Application.ProcessMessages;
    If FileExists(PrevImFileName) then begin
        ValidFile := True;
      //--------------1st has to check some File Types --------------------//
      If (PrevFilePar.FilterIndex = COLLECTION_INDEX) Then Begin
        ValidFile := LoadCollFileList(PrevImFileName);
      End Else
      If (PrevFilePar.FilterIndex in [QED_INDEX,NORAN_PRARIE_INDEX]) Then Begin
        if (FindFirst(ExtractFilePath(PrevImFileName)+'*.tif',faAnyFile, SearchRec) <> 0)
        then
        begin
          ValidFile := False;
          MessageDlg('Tiff Files are Missing.',mtError,[mbOK],0);
        end;
        FindClose(SearchRec); //free resourses
      End;
      //---------------------End with Check -------------------------------//
      If (ValidFile) then Begin
        if (ImFname <> '') then Begin
          TempPrevImFile     := ImFname;
          TempPrevImFindex   := ImTypeIndex;
          TempMultiImageTIFF := MultiImageTIFF;
        end;
        SilentMode     := False;
        ImTypeIndex    := PrevFilePar.FilterIndex;
        MultiImageTIFF := PrevFilePar.MultiImageTIFF;
        TemBigTiff     := PrevFilePar.BigTiff;
        BigTiff        := PrevFilePar.BigTiff;
        if (frm3DImageContr <> nil) then begin
          if (frm3DImageContr.bt3DOn.Down) then begin
            frm3DImageContr.bt3DOn.Down := False;
            frm3DImageContr.bt3DOnClick(Sender);
          end;
        end;

        OpenImageFile(PrevImFileName,ImTypeIndex,False,SilentMode);

        if (TempPrevImFile <> '') then Begin
          PrevImFileName             := TempPrevImFile;
          PrevFilePar.FilterIndex    := TempPrevImFindex;
          PrevFilePar.MultiImageTIFF := TempMultiImageTIFF;
          PrevFilePar.BigTiff        := TemBigTiff;
        end;
        OpenFileDialog.InitialDir  := ExtractFileDir(PrevImFileName);
        OpenFileDialog.FilterIndex := ImTypeIndex;
        OpenFileDialog.FileName    := PrevImFileName;
      End; //If (ValidFile)
    End else
    MessageDlg('File Does Not Exist',mtError,[mbOK],0);
  End; {PreviousFile.Caption <> ''}

End;

 {-------------------------------------------------------------------------}

procedure TMainForm.ViewClick(Sender: TObject);
begin

   {For Forms that are never Destroyed}
    if NrIm = 1 then viewAverageWindow.Enabled := False else
                     viewAverageWindow.Enabled := True;
                         
    if IsWindowVisible(frmMainWin.Handle) = True then
        viewMainWindow.Checked := True else
        viewMainWindow.Checked := False;

    if IsWindowVisible(frmPlayback.Handle) = True then
        viewPlaybackWindow.Checked := True else
        viewPlaybackWindow.Checked := False;

    if IsWindowVisible(frmImageControl.Handle) = True then
        viewImageControl.Checked := True else
        viewImageControl.Checked := False;

    if IsWindowVisible(frmTimeSerPlot.Handle) = True then
        viewTimeSeriesAnalysis.Checked := True else
        viewTimeSeriesAnalysis.Checked := False;

     {Forms that are destroyed}

    if frmSlaveTSPlot <> nil then viewTimeSeriesAnalysisSlave.Checked := True else
                                  viewTimeSeriesAnalysisSlave.Checked := False;

    if frmAverIm <> nil then viewAverageWindow.Checked := True else
                             viewAverageWindow.Checked := False;

    if frmMergeWin <> nil then MergeWindow.Checked := True else
                               MergeWindow.Checked := False;

    if frm2ndWin <> nil then SecondaryWindow.Checked := True else
                             SecondaryWindow.Checked := False;

    if frmSPautoSearch <> nil then viewEventAutoDetection.Checked := True else
                                   viewEventAutoDetection.Checked := False;

    if frmSpatialSpread <> nil then viewSpatialSpreadTable.Checked := True else
                                    viewSpatialSpreadTable.Checked := False;

    if frmIntegrate <> nil then viewIntegrateWin.Checked := True else
                                viewIntegrateWin.Checked := False;

    if frmSparkTable <> nil then viewSparkTable.Checked := True else
                                 viewSparkTable.Checked := False;

    if frmWaveTable <> nil then  CaWavesTable.Checked := True else
                                 CaWavesTable.Checked := False;

    if frmOrthogonalSectioning <> nil then  viewOrtogonalSections.Checked := True else
                                            viewOrtogonalSections.Checked := False;

    if frmQueueFiles <> nil then QueueFileTable.Checked := True else
                                 QueueFileTable.Checked := False;

    if frmPeaks <> nil then PeaksTable.Checked := True else
                            PeaksTable.Checked := False;

    if frmTimeHistograms <> nil then TimeHistograms.Checked := True else
                                     TimeHistograms.Checked := False;

    if frm3DImageWin <> nil then N3DWindowControls.Checked := True else
                                 N3DWindowControls.Checked := False;

    if frmRealLineScan <> nil then RealLineScanWindow.Checked := True else
                                   RealLineScanWindow.Checked := False;

    if frmLineScan <> nil then   LineScanWindow.Checked := True else
                                 LineScanWindow.Checked := False;

    if frmXYprofile <> nil then viewXorYProfile.Checked := True else
                                viewXorYProfile.Checked := False;

    if frmFileList <> nil then FileList.Checked := True else
                               FileList.Checked := False;

    if frmMovieLabels <> nil then MovieCommentsTimersDialog.Checked := True else
                                  MovieCommentsTimersDialog.Checked := False;

    if frmCorrectForBleaching <> nil then viewBleachingCorrection.Checked := True else
                                          viewBleachingCorrection.Checked := False;

    if frmKalmanStackFilter <> nil then viewKalmanStackFilter.Checked := True else
                                        viewKalmanStackFilter.Checked := False;

    if frmEventSites <> nil then viewEventSites.Checked := True else
                                 viewEventSites.Checked := False;

    if frmCopyWindow <> nil then CopyWindow.Checked := True else
                                 CopyWindow.Checked := False;

End;

procedure TMainForm.OpenMeasLineFile(Const MeasuringLineFileName : AnsiString);

var TxTFile : TextFile;
    ReadStr : AnsiString;
    Xbeg,Ybeg,Xend,Yend : Integer;

begin

      AssignFile(TxTFile,MeasuringLineFileName);
      FileMode := fmOpenRead;
      Reset(TxTFile);
      {-------- Reads Heather-------}
      ReadLn(TxTFile,ReadStr);
      if ReadStr <> 'SparkAn Measuring Line Coordinates File' then
        MessageDlg('This is Not SparkAn Mesuring Line Coordinates File Type',mtError,[mbOK],0)
      else
      If (ReadStr = 'SparkAn Measuring Line Coordinates File') then Begin
        ReadLn(TxTFile);
        ReadLn(TxTFile);
        Read(TxTFile,Xbeg);      
        Read(TxTFile,Ybeg);
        Read(TxTFile,Xend);
        Read(TxTFile,Yend);

        if (Xbeg < imXsize) and (Xend < imXsize) and
           (Ybeg < imXsize) and (Yend < imYsize) then with MesLine
        do begin
          LineBeg.X := Xbeg;
          LineBeg.Y := Ybeg;
          LineEnd.X := Xend;
          LineEnd.Y := Yend;

          MesLine.OpCode := DO_EXIST;
          CalculateMesLineParams(0,0); //needed
          
          UpdateMainImage(True);
          if (frmAverIm <> nil) and (AvImExists > 0) and (ROIvar.ROIonAverWin = true) then
          UpdateAverImage(True);
          FilePaths.MarkFilePath  := ExtractFilePath(MeasuringLineFileName);
        end else begin
          MesLine.OpCode := NOT_EXIST;
          MessageDlg('Measuring Line Coordinates Exceed then Size of the Current Image',mtError,[mbOK],0);
        end;
      End;

      CloseFile(TxTFile);

End;

procedure TMainForm.OpenAnyMarkFile(MarkFileName : AnsiString);
Var
   MarkFile : TextFile;
   Cnt, i   : Integer;
   ReadInt  : Integer;
   BegFill  : Boolean;
   SmallEvVers3 : Boolean;
   ReadStr  : AnsiString;
   MarkType : AnsiString;
   TemStr   : AnsiString;
   Comment  : AnsiString;
   Sender   : TObject;
   ReadDbl  : Double;
   Ch       : Char;


Begin
      SmallEvVers3 := False;
      AssignFile(MarkFile,MarkFileName);
      FileMode := fmOpenRead;
      Reset(MarkFile);
      ReadLn(MarkFile,ReadStr);

    {1st: check if this is a mark File}
    If (ReadStr <> 'SparkAn Mark File Small Events v.3') and
       (ReadStr <> 'SparkAn Mark File Small Events v.2') and
       (ReadStr <> 'SparkAn Mark File Big Events v.2') and
       (ReadStr <> 'SparkAn Mark File Small Events') and
       (ReadStr <> 'SparkAn Mark File Big Events') and
       (Copy(ReadStr,1,13) <> 'SpANMarkFile:') Then Begin
        MessageDlg('This is Not a Mark File',mtError,[mbOK],0);
        CloseFile(MarkFile);
    End Else

    Begin
    {Check if Mark file originates from the Current Image File}
    If (ReadStr = 'SparkAn Mark File Small Events v.3') or // v.3 introduced Aug 29, 2017 to accomodate Tag column
       (ReadStr = 'SparkAn Mark File Small Events v.2') or
       (ReadStr = 'SparkAn Mark File Big Events v.2') or
       (ReadStr = 'SparkAn Mark File Small Events') or
       (ReadStr = 'SparkAn Mark File Big Events') Then Begin
      MarkType := ReadStr;
      ReadLn(MarkFile,ReadStr);
      TemStr := Copy(ReadStr,18,Length(ReadStr)-17);
    End Else
    If (Copy(ReadStr,1,13) = 'SpANMarkFile:')  Then Begin {IDL Mark Files}
      MarkType := 'SpANMarkFile:';
      TemStr := Copy(ReadStr,15,Length(ReadStr)-13);
    End;

    {Check if originates from Current Image File}
    If TemStr <> ImFtitle Then Begin
      TemStr := 'This Mark File Does Not Originate from Current File but from'
                + ' "' + TemStr + '"';
      MessageDlg(TemStr,mtWarning,[mbOK],0);
      CloseFile(MarkFile);
    End else

      {--- Starts Loading ------}
    If (TemStr = ImFtitle) Then Begin

      ReadLn(MarkFile); {Skips these 2 Lines}
      if (MarkType <> 'SpANMarkFile:') then ReadLn(MarkFile,Comment);

    Comment := Copy(Comment,1,5); 
    If Comment = 'EMPTY' then Begin
      MessageDlg('File is Empty',mtInformation,[mbOK],0);
      CloseFile(MarkFile);
    End Else Begin {Not Empty File}


    {Sets 1st dimention in Mark buffers}
    If (MarkType = 'SparkAn Mark File Small Events v.3') or
       (MarkType = 'SparkAn Mark File Small Events v.2') or
       (MarkType = 'SparkAn Mark File Small Events') or
       (MarkType = 'SpANMarkFile:') then Begin
      For Cnt := 0 to NrIm - 1 Do Begin {Zeroes Arrays}
        SetLength(MarkSmEvCoor[Cnt],0);
        SetLength(MarkSmAmpl[Cnt],0);
        SetLength(MarkSmBase[Cnt],0);
        SetLength(MarkSmEvDur[Cnt],0);
        SetLength(MarkSmEvRise[Cnt],0);
      End;
      if frmSparkTable <> nil then frmSparkTable.DelAllMarksClick(Sender);
    End Else
    If (MarkType = 'SparkAn Mark File Big Events v.2') or
       (MarkType = 'SparkAn Mark File Big Events') then Begin
      For Cnt := 0 to NrIm - 1 Do Begin {Zeroes Arrays}
        SetLength(MarkBigEvCoor[Cnt],0);
        SetLength(MarkBigAmpl  [Cnt],0);
        SetLength(MarkBigBase  [Cnt],0);
        SetLength(MarkBigEvDur [Cnt],0);
        SetLength(MarkBigEvRise [Cnt],0);
      End;
      if frmWaveTable <> nil then frmWaveTable.DelAllMarksClick(Sender);
    End;

       {*** Small Events ****}

    If (MarkType = 'SparkAn Mark File Small Events v.2') or (MarkType = 'SparkAn Mark File Small Events v.3') then Begin
      if (MarkType = 'SparkAn Mark File Small Events v.3') then SmallEvVers3 := True;
       SetLength(TagArray,0);

      While Not(Eof(MarkFile)) Do Begin //here Cnt is used to Read Text File
        {Tag was introduced in Aug 29, 2017.  To accomodate the previous way of writing and reading Mark Files
         tag HAVE to be written in the beginnig since tests if there is Char(9) to find if there is or not
         rise, duration and Decay analyzed.  Tags are displyed last in mark table to keep with the previous order}

        SetLength(TagArray,High(TagArray)+ 2);
        if (SmallEvVers3) then begin
          Read(MarkFile, Ch);
          if (Ch <> '-') then
            TagArray[High(TagArray)] := Ch else
            TagArray[High(TagArray)] := '';
        end
          else
        TagArray[High(TagArray)] := '';

        Read(MarkFile, ReadInt); //Reads Column Nr
        Read(MarkFile, Cnt); {Reads Image #}
        Dec(Cnt); {Image Number Start from 0 }
        SetLength(MarkSmEvCoor[Cnt],High(MarkSmEvCoor[Cnt])+ 2);
        SetLength(MarkSmAmpl  [Cnt],High(MarkSmAmpl  [Cnt])+ 2);
        SetLength(MarkSmEvRise [Cnt],High(MarkSmEvRise [Cnt])+ 2);
        SetLength(MarkSmEvDur [Cnt],High(MarkSmEvDur [Cnt])+ 2);
        SetLength(MarkSmBase  [Cnt],High(MarkSmBase  [Cnt])+ 2);
        Read(MarkFile, ReadInt); { X }
        MarkSmEvCoor[Cnt,High(MarkSmEvCoor[Cnt])].X := ReadInt;
        Read(MarkFile, ReadInt); { Y }
        MarkSmEvCoor[Cnt,High(MarkSmEvCoor[Cnt])].Y := ReadInt;
        Read(MarkFile, ReadDbl); {Amplitude}
        MarkSmAmpl[Cnt,High(MarkSmAmpl[Cnt])] := ReadDbl;
        Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
        //If this is the end of line Ord(Ch) = 13  //ShowMessage(IntToStr(Ord(Ch)));
        if Ord(Ch) = 9 then begin   //ShowMessage('Ord(Ch) = 9');
          Read(MarkFile, ReadDbl); {Rise time}
          if ReadDbl > CANNOT_BE_DONE then
          MarkSmEvRise[Cnt,High(MarkSmEvRise[Cnt])] := ReadDbl/1000 else
          MarkSmEvRise[Cnt,High(MarkSmEvRise[Cnt])] := CANNOT_BE_DONE;

          Read(MarkFile, ReadDbl); {Duration}
          if ReadDbl > CANNOT_BE_DONE then //if Rtime was measured then Dur will be there too
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L := ReadDbl  else
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L := CANNOT_BE_DONE;

          Read(MarkFile, ReadDbl); {Decay}
          if ReadDbl > CANNOT_BE_DONE then begin
            MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R := ReadDbl/1000;
            if (MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L > CANNOT_BE_DONE) then
            MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L :=
            (MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L - ReadDbl)/1000;
          end else
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R := CANNOT_BE_DONE;

          Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
          if Ord(Ch) = 9 then begin
          Read(MarkFile, ReadDbl); //base//
          MarkSmBase[Cnt,High(MarkSmBase[Cnt])] := ReadDbl;
          end else
          MarkSmBase[Cnt,High(MarkSmBase[Cnt])] := 1; //assumes it was 1 //in older files base was not there
        end
          else
        begin
            //CANNOT_BE_DONE  = -1; NOT_ANALYZED   = -2; //
          MarkSmEvRise[Cnt,High(MarkSmEvRise[Cnt])] := NOT_ANALYZED;
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L := NOT_ANALYZED;
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R := NOT_ANALYZED;
          MarkSmBase[Cnt,High(MarkSmBase[Cnt])] := 1; //assumes it was 1 //in older files base was not there

        end;

          ReadLn(MarkFile); //finishes line
      End; //While Not(Eof(TxTFile))
    End

      Else

    If (MarkType = 'SparkAn Mark File Small Events') then Begin
      While Not(Eof(MarkFile)) Do Begin //here Cnt is used to Read Text File

        Read(MarkFile, ReadInt); //Reads Column Nr
        Read(MarkFile, Cnt); {Reads Image #}
        Dec(Cnt); {Image Number Start from 0 }
        SetLength(MarkSmEvCoor[Cnt],High(MarkSmEvCoor[Cnt])+ 2);
        SetLength(MarkSmAmpl  [Cnt],High(MarkSmAmpl  [Cnt])+ 2);
        SetLength(MarkSmEvRise [Cnt],High(MarkSmEvRise [Cnt])+ 2);
        MarkSmEvRise[Cnt,High(MarkSmEvRise[Cnt])] := NOT_ANALYZED; //it Was not Rise Time in this format - So = NOT_ANALYZED
        SetLength(MarkSmEvDur [Cnt],High(MarkSmEvDur [Cnt])+ 2);
        SetLength(MarkSmBase  [Cnt],High(MarkSmBase  [Cnt])+ 2);
        Read(MarkFile, ReadInt); { X }
        MarkSmEvCoor[Cnt,High(MarkSmEvCoor[Cnt])].X := ReadInt;
        Read(MarkFile, ReadInt); { Y }
        MarkSmEvCoor[Cnt,High(MarkSmEvCoor[Cnt])].Y := ReadInt;
        Read(MarkFile, ReadDbl); {Amplitude}
        MarkSmAmpl[Cnt,High(MarkSmAmpl[Cnt])] := ReadDbl;
        Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
        if Ord(Ch) = 9 then begin   //ShowMessage('Ord(Ch) = 9');
          Read(MarkFile, ReadDbl); {Decay}
          if ReadDbl > CANNOT_BE_DONE then
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R := ReadDbl/1000 else
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R := CANNOT_BE_DONE;
          Read(MarkFile, ReadDbl); {Duration}
          if ReadDbl > CANNOT_BE_DONE then //if Rtime was measured then Dur will be there too
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L :=
          ReadDbl/1000 - MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R
          else
          MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L := CANNOT_BE_DONE;
          Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
          if Ord(Ch) = 9 then begin
          Read(MarkFile, ReadDbl); //base//
          MarkSmBase[Cnt,High(MarkSmBase[Cnt])] := ReadDbl;
          end else
          MarkSmBase[Cnt,High(MarkSmBase[Cnt])] := 1; //assumes it was 1 //in older files base was not there
        end else
        begin
            //CANNOT_BE_DONE  = -1; NOT_ANALYZED   = -2; //
            MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].L := NOT_ANALYZED;
            MarkSmEvDur[Cnt,High(MarkSmEvDur[Cnt])].R := NOT_ANALYZED;
            MarkSmBase[Cnt,High(MarkSmBase[Cnt])] := 1; //assumes it was 1 //in older files base was not there
        end;
        ReadLn(MarkFile); //finishes line
      End; //While Not(Eof(TxTFile))
      End

        Else

      If (MarkType = 'SparkAn Mark File Big Events v.2') then Begin
      While Not(Eof(MarkFile)) Do Begin //here Cnt is used to Read Text File

        Read(MarkFile, ReadInt); //Reads Column Nr
        Read(MarkFile, Cnt); {Reads Image #}
        Dec(Cnt); {Image Number Start from 0 }
        SetLength(MarkBigEvCoor[Cnt],High(MarkBigEvCoor[Cnt])+ 2);
        SetLength(MarkBigAmpl  [Cnt],High(MarkBigAmpl  [Cnt])+ 2);
        SetLength(MarkBigEvRise [Cnt],High(MarkBigEvRise [Cnt])+ 2);
        SetLength(MarkBigEvDur [Cnt],High(MarkBigEvDur [Cnt])+ 2);
        SetLength(MarkBigBase  [Cnt],High(MarkBigBase  [Cnt])+ 2);
        Read(MarkFile, ReadInt); { X }
        MarkBigEvCoor[Cnt,High(MarkBigEvCoor[Cnt])].X := ReadInt;
        Read(MarkFile, ReadInt); { Y }
        MarkBigEvCoor[Cnt,High(MarkBigEvCoor[Cnt])].Y := ReadInt;
        Read(MarkFile, ReadDbl); {Amplitude}
        MarkBigAmpl[Cnt,High(MarkBigAmpl[Cnt])] := ReadDbl;
        Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
        if Ord(Ch) = 9 then begin   //ShowMessage('Ord(Ch) = 9');

          Read(MarkFile, ReadDbl); {Rise time}
          if ReadDbl > CANNOT_BE_DONE then
          MarkBigEvRise[Cnt,High(MarkBigEvRise[Cnt])] := ReadDbl/1000 else
          MarkBigEvRise[Cnt,High(MarkBigEvRise[Cnt])] := CANNOT_BE_DONE;

          Read(MarkFile, ReadDbl); {Duration}
          if ReadDbl > CANNOT_BE_DONE then //if Rtime was measured then Dur will be there too
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L := ReadDbl  else
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L := CANNOT_BE_DONE;

          Read(MarkFile, ReadDbl); {Decay}
          if ReadDbl > CANNOT_BE_DONE then begin
            MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R := ReadDbl/1000;
            if (MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L > CANNOT_BE_DONE) then
            MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L :=
            (MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L - ReadDbl)/1000;
          end else
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R := CANNOT_BE_DONE;

          Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
          if Ord(Ch) = 9 then begin
          Read(MarkFile, ReadDbl); //base//
          MarkBigBase[Cnt,High(MarkBigBase[Cnt])] := ReadDbl;
          end else
          MarkBigBase[Cnt,High(MarkBigBase[Cnt])] := 1; //assumes it was 1 //in older files base was not there
        end else
        begin
            //CANNOT_BE_DONE  = -1; NOT_ANALYZED   = -2; //
          MarkBigEvRise[Cnt,High(MarkBigEvRise[Cnt])] := NOT_ANALYZED;
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L := NOT_ANALYZED;
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R := NOT_ANALYZED;
          MarkBigBase[Cnt,High(MarkBigBase[Cnt])] := 1; //assumes it was 1 //in older files base was not there
        end;
          ReadLn(MarkFile); //finishes line
      End; //While Not(Eof(TxTFile))
    End Else

    If (MarkType = 'SparkAn Mark File Big Events') then Begin
      While Not(Eof(MarkFile)) Do Begin //here Cnt is used to Read Text File
        Read(MarkFile, ReadInt); //readsColumn Nr
        Read(MarkFile, Cnt); {Reads Image #}
        Dec(Cnt); {Images Start from 0 }
        SetLength(MarkBigEvCoor  [Cnt],High(MarkBigEvCoor  [Cnt])+ 2);
        SetLength(MarkBigAmpl[Cnt],High(MarkBigAmpl[Cnt])+ 2);
        SetLength(MarkBigEvRise[Cnt],High(MarkBigEvRise[Cnt])+ 2);
        MarkBigEvRise[Cnt,High(MarkBigEvRise[Cnt])] := NOT_ANALYZED; //it Was not Rise Time in this format - So = NOT_ANALYZED
        SetLength(MarkBigEvDur[Cnt],High(MarkBigEvDur[Cnt])+ 2);
        SetLength(MarkBigBase[Cnt],High(MarkBigBase[Cnt])+ 2);
        Read(MarkFile, ReadInt); { X }
        MarkBigEvCoor[Cnt,High(MarkBigEvCoor[Cnt])].X := ReadInt;
        Read(MarkFile, ReadInt); { Y }
        MarkBigEvCoor[Cnt,High(MarkBigEvCoor[Cnt])].Y := ReadInt;
        Read(MarkFile, ReadDbl); {Amplitude}
        MarkBigAmpl[Cnt,High(MarkBigAmpl[Cnt])] := ReadDbl;
        Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
        if Ord(Ch) = 9 then begin
        Read(MarkFile, ReadDbl); {Decay}
        if ReadDbl > CANNOT_BE_DONE then
        MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R := ReadDbl/1000 else
        MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R := CANNOT_BE_DONE;
        Read(MarkFile, ReadDbl); {Duration}
        if ReadDbl > CANNOT_BE_DONE then
        MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L :=
          ReadDbl/1000 - MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R
        else
        MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L := CANNOT_BE_DONE;
        Read(MarkFile, Ch); //check if this is the end of the Line (Eoln(TextFile) does not work)
        if Ord(Ch) = 9 then begin
        Read(MarkFile, ReadDbl); //base//
        MarkBigBase[Cnt,High(MarkBigBase[Cnt])] := ReadDbl;
        end else
        MarkBigBase[Cnt,High(MarkBigBase[Cnt])] := 1;  //assumes it was 1 //in older files base was not there
        end else
        begin
          {CANNOT_BE_DONE  = -1; NOT_ANALYZED   = -2; }
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].L := NOT_ANALYZED;
          MarkBigEvDur[Cnt,High(MarkBigEvDur[Cnt])].R := NOT_ANALYZED;
          MarkBigBase[Cnt,High(MarkBigBase[Cnt])] := 1;  //assumes it was 1 //in older files base was not there
        end;
        ReadLn(MarkFile); //finishes line
      End; //While Not(Eof(TxTFile))
      End

        Else

      If (MarkType = 'SpANMarkFile:') then Begin  {IDL SparkAn program type Files}
      While Not(Eof(MarkFile)) Do Begin
        For i := 0 to 4 Do Begin
          if i = 1 then Read(MarkFile, ReadInt);
          if i = 0 then Begin
             Read(MarkFile, Cnt); {Reads Image #}
             Dec(Cnt); {Images Start from 0 }
             SetLength(MarkSmEvCoor[Cnt],High(MarkSmEvCoor[Cnt])+ 2);
             SetLength(MarkSmAmpl  [Cnt],High(MarkSmAmpl  [Cnt])+ 2);
             SetLength(MarkSmEvRise [Cnt],High(MarkSmEvRise [Cnt])+ 2);
             SetLength(MarkSmEvDur [Cnt],High(MarkSmEvDur [Cnt])+ 2);
             SetLength(MarkSmBase  [Cnt],High(MarkSmBase  [Cnt])+ 2);
             MarkSmEvRise[Cnt,High(MarkSmEvRise[Cnt])]  := NOT_ANALYZED;
             MarkSmEvDur[Cnt,High(MarkSmEvCoor[Cnt])].L := NOT_ANALYZED;
             MarkSmEvDur[Cnt,High(MarkSmEvCoor[Cnt])].R := NOT_ANALYZED;
             MarkSmBase[Cnt,High(MarkSmBase[Cnt])]      := 1;
          end;
          if i = 2 then Begin
             Read(MarkFile, ReadInt); { X }
             MarkSmEvCoor[Cnt,High(MarkSmEvCoor[Cnt])].X := ReadInt;
          end;
          if i = 3 then Begin
             Read(MarkFile, ReadInt); { Y }
             MarkSmEvCoor[Cnt,High(MarkSmEvCoor[Cnt])].Y := ReadInt;
          end;
          if i = 4 then Begin
             ReadLn(MarkFile, ReadDbl);  {Amplitude}
             MarkSmAmpl[Cnt,High(MarkSmAmpl[Cnt])] := ReadDbl;
          end;
      End; {For i := 0 to 4}
      End; {While}
      End; { If (MarkType = 'SpANMarkFile:') then Begin}
      CloseFile(MarkFile);

      {*** End of Loading Marks of all kind of Mark Files ***}

     {*********** Draws Marks on Windows **************}
        BegFill    := True;
      If (MarkType = 'SparkAn Mark File Small Events v.3') or
         (MarkType = 'SparkAn Mark File Small Events v.2') or
         (MarkType = 'SparkAn Mark File Small Events') or
         (MarkType = 'SpANMarkFile:') then Begin
         if MarkPar.DisplaySmEvents then if (High(MarkSmEvCoor [CurIm]) >= 0) then
            DrawSmalEvMarks(frmMainWin.winMainImage.Canvas);
         if (frmAverIm <> nil) and (AvImExists > 0) and (MarkPar.ShowSmEvOnAverWin) then
            DrawAllSmallEvMarks(frmAverIm.winAverImage.Canvas);
         if frmSparkTable <> nil then begin
          frmSparkTable.LoadSparkTable(BegFill);
          frmSparkTable.WindowState := wsNormal;
          frmSparkTable.Show;
         end else
         if frmSparkTable = nil then  Application.CreateForm(TfrmSparkTable, frmSparkTable);
      End else
      If (MarkType = 'SparkAn Mark File Big Events v.2') or
         (MarkType = 'SparkAn Mark File Big Events') then Begin
        if MarkPar.DisplayBigEvents then if High(MarkBigEvCoor[CurIm]) >= 0 then
            DrawBigEvMarks(frmMainWin.winMainImage.Canvas);
        if (frmAverIm <> nil) and (AvImExists > 0) and (MarkPar.ShowBigEvOnAverWin) then
            DrawAllBigEvMarks(frmAverIm.winAverImage.Canvas);
        if frmWaveTable <> nil then begin
          frmWaveTable.LoadWaveTable(BegFill);
          frmWaveTable.WindowState := wsNormal;
          frmWaveTable.Show;
        end else
        if frmWaveTable = nil then  Application.CreateForm(TfrmWaveTable, frmWaveTable);
      End;
         OpenFileDialog.InitialDir := ExtractFileDir(OpenFileDialog.FileName);
        {-------------------------}
      End; {File is Not Empty}
     End; { TemStr = ImFtitle}
    End; {if ReadStr = 'SparkAn Mark File Small Events' Then Begin}

End;
 //---------------------------------------------------------------------------//

Procedure TMainForm.WriteMarkFile(Const MarkFileName : AnsiString; Const EvType : AnsiString;
                             Const MarkArrXY :TMarkArrXY; Const MarkAmpl : TDyn2DSingleArr;
                             Const MarkBase : TDyn2DSingleArr; Const MarkArrDur : TMarkArrDur;
                             Const MarkRiseTime : TDyn2DSingleArr;
                             Const Comment : AnsiString; Const WriteEvents : Boolean);


Var       TxtFile     : TextFile;
          WriteStr    : AnsiString;
          ImNr,Cnt,i  : Integer;
          SmallEvents : Boolean;

Begin

  AssignFile(TxtFile, MarkFileName);
  ReWrite(TxtFile);
  Writeln(TxTFile, EvType);
  WriteStr := 'Originates From: ' + ImFtitle;
  Writeln(TxTFile, WriteStr);
  if (EvType = 'SparkAn Mark File Small Events v.3') then SmallEvents := True else SmallEvents := False;
  if (SmallEvents) then
  WriteStr := 'Follow: Tag, Row#, Im#, X, Y, Ampl, Rise Time (10% - 90%, ms), Duration (ms), Decay (ms)' else
  WriteStr := 'Follow: Row#, Im#, X, Y, Ampl, Rise Time (10% - 90%, ms), Duration (ms), Decay (ms)';
  Writeln(TxTFile, WriteStr);

  Writeln(TxTFile,Comment);  {writes Comment}

 If (WriteEvents) Then Begin

     if (SmallEvents) and (frmSparkTable <> nil) then with frmSparkTable.StringGridSparks do begin
       SetLength(TagArray,RowCount-1);
       for i := 0 to High(TagArray) do begin
          TagArray[i] := Cells[9,i+1];
       end;
     end;

     Cnt := 0;
  For ImNr := 0 to NrIm - 1 Do Begin
   If High(MarkArrXY[ImNr]) >= 0 Then
    For i := 0 to High(MarkArrXY[ImNr]) Do Begin
      Inc(Cnt);
      // Adds to WriteStr Number, Image Number, Coordinates and Amplitude //
      WriteStr := IntToStr(Cnt) + Char(9) + IntToStr(ImNr+1) + Char(9) +
        IntToStr(MarkArrXY[ImNr,i].X) + Char(9) + IntToStr(MarkArrXY[ImNr,i].Y) +
        Char(9) + FloatToStrF(MarkAmpl[ImNr,i],ffFixed,8,3);


      If (MarkArrDur[ImNr,i].R > NOT_ANALYZED) then begin
      
        //Adds to WriteStr Rise Time
        if (MarkRiseTime[ImNr,i] > CANNOT_BE_DONE) then
        WriteStr := WriteStr + Char(9) + FloatToStrF(MarkRiseTime[ImNr,i]*1000,ffFixed,8,3) else
        if (MarkRiseTime[ImNr,i] = CANNOT_BE_DONE) then
        WriteStr := WriteStr + Char(9) + '-1';

        //Adds to WriteStr Duration and Decay
        //Duration & Decay both Have Values
        if (MarkArrDur[ImNr,i].L > CANNOT_BE_DONE) and (MarkArrDur[ImNr,i].R > CANNOT_BE_DONE) then
        WriteStr := WriteStr + Char(9) + FloatToStrF((MarkArrDur[ImNr,i].L+MarkArrDur[ImNr,i].R)*1000,ffFixed,8,3) +
                               Char(9) + FloatToStrF(MarkArrDur[ImNr,i].R*1000,ffFixed,8,3)
                               else
        //Only Decay has value
        if (MarkArrDur[ImNr,i].L = CANNOT_BE_DONE) and (MarkArrDur[ImNr,i].R > CANNOT_BE_DONE) then
        WriteStr := WriteStr + Char(9) + Char(9) + '-1' + FloatToStrF(MarkArrDur[ImNr,i].R*1000,ffFixed,8,3) else
        //Neither Have Values since R doeas not have value
        if (MarkArrDur[ImNr,i].R = CANNOT_BE_DONE) then
        WriteStr := WriteStr + Char(9) + '-1' + Char(9) + '-1';
        
        //Adds to WriteStr Baseline
        WriteStr := WriteStr + Char(9) + FloatToStrF(MarkBase[ImNr,i],ffFixed,8,3);

      End; //If (MarkArrDur[ImNr,i].R > NOT_ANALYZED)

       //Adds to WriteStr Tag Value
      If (SmallEvents) then begin
        if (TagArray[Cnt-1] = '') then
        WriteStr := '-' + Char(9) + WriteStr else
        WriteStr := TagArray[Cnt-1] + Char(9) + WriteStr;
       End;

      Writeln(TxTFile, WriteStr);

   End; {High(MarkSmEvCoor[Cnt]) >= 0}
  End; { For Cnt := 0 to NrIm -1}
 End; {WriteEvents = True}

  CloseFile(TxtFile);

 End;  {Procedure WriteMarkFile}

 {*****************************************************************************}
 Procedure TMainForm.SavePlotAsPClampATF(const SaveFName : AnsiString);
 var Cnt,Beg,ToEnd,ImNr,NrROI  : Integer;
     WriteStr  : AnsiString;
     FirstTime : Boolean;
     TxtFile   : TextFile;
     ImTime    : Double;

 Begin

  Beg     := frmTimeSerPlot.dsXaxes.PosFrom;
  ToEnd   := frmTimeSerPlot.dsXaxes.PosTo;

  AssignFile(TxtFile, SaveFName);
  ReWrite(TxtFile);
        {tab := Chr(9);}
 
 NrROI := 0;
 For Cnt := 0 to PLOTvar.NrROI-1 Do Begin
    if (PLOTvar.AdrUsed[Cnt] > 0) then Inc(NrROI);
 End;

 WriteStr := 'ATF' + Chr(9) + '1.0';                Writeln(TxTFile,WriteStr);
 WriteStr := '7' + Chr(9) + IntToAnsiStr(NrROI+1);  Writeln(TxTFile,WriteStr);
 //7 = Number of Lines (-Comment) and 2nd number = columns = Time + NrROI

 //if 1 trace make ti like gap-free else like Episodic Stimulation
 //to simulate sweeps - easy to analyse and display.
 //if separate gap free PCamp allows not more then 16 traces because Digidata has 16 channels
 if (NrROI = 1) then
 WriteStr := '"AcquisitionMode=Gap Free"' else WriteStr := '"AcquisitionMode=Episodic Stimulation"';
 Writeln(TxTFile,WriteStr);

  {writes Comment}
  FirstTime := True;
  For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
    if (PLOTvar.AdrUsed[Cnt] > 0) then begin
      if (FirstTime) then begin
        WriteStr := IntToAnsiStr(PLOTvar.AdrUsed[Cnt]);
        FirstTime := False;
      end else
        WriteStr := WriteStr + ',' + IntToAnsiStr(PLOTvar.AdrUsed[Cnt]);
    end;
  End;
  WriteStr := '"Comment=from: ' + PLOT_FTitle + ', images: ' + IntToAnsiStr(Beg+1) + '-' + IntToAnsiStr(ToEnd+1) +
              ', ROIs: ' + WriteStr + '"';
  Writeln(TxTFile,WriteStr);

  //writes Ytop for all traces
 WriteStr := '"YTop=';
 For Cnt := 1 to NrROI do Begin
  if Not(PLOTvar.AnalType = RATIO_TIME) then
    WriteStr := WriteStr + IntToAnsiStr(frmTimeSerPlot.enYtop.NumberOne)
      else
  if (PLOTvar.AnalType = RATIO_TIME)  then
    WriteStr := WriteStr + FloatToAnsiStr(frmTimeSerPlot.enYtop.NumberFloat,9,3);
  if (Cnt < NrROI) then WriteStr := WriteStr + ',' else WriteStr := WriteStr + '"';
 End;
 Writeln(TxTFile,WriteStr);

 //writes Ybottom for all traces
 WriteStr := '"YBottom=';
 For Cnt := 1 to NrROI do Begin
  if Not(PLOTvar.AnalType = RATIO_TIME) then
    WriteStr := WriteStr + IntToAnsiStr(frmTimeSerPlot.enYbottom.NumberOne)
    else
  if (PLOTvar.AnalType = RATIO_TIME)  then
    WriteStr := WriteStr +  FloatToAnsiStr(frmTimeSerPlot.enYbottom.NumberFloat,9,3);
  if (Cnt < NrROI) then WriteStr := WriteStr + ',' else WriteStr := WriteStr + '"';
 End;
 Writeln(TxTFile,WriteStr);

 WriteStr := '0.000';
 if (NrROI > 1) then
 for Cnt := 2 to NrROI do begin
  WriteStr := WriteStr + ',0.000';
 end;
 WriteStr := '"SweepStartTimesMS=' + WriteStr + '"';
 Writeln(TxTFile,WriteStr);

 WriteStr := '"SignalsExported=' + PLOTvar.Title + '"';
 Writeln(TxTFile,WriteStr);

 WriteStr := '"Signals=';
 For Cnt := 0 to PLOTvar.NrROI-1 Do Begin
  if (PLOTvar.AdrUsed[Cnt] > 0) then begin
      WriteStr := WriteStr  + Char(9) + '"ROI #' + IntToAnsiStr(PLOTvar.AdrUsed[Cnt]) + '"';
  end;
 End;
 Writeln(TxTFile,WriteStr);

 if Not(PLOTvar.AnalType = RATIO_TIME) then
 WriteStr := '"Time (s)"' + ' "Trace #1 (Intens.)"'
  else
 WriteStr := '"Time (s)"' + ' "Trace #1 (F/Fo)"';
 if (NrROI > 1) then For Cnt := 2 to NrROI Do Begin
  if Not(PLOTvar.AnalType = RATIO_TIME) then
    WriteStr := WriteStr  + Char(9) + '"Trace #' + IntToAnsiStr(Cnt) + '(Intens.)"'
  else
    WriteStr := WriteStr  + Char(9) + '"Trace #' + IntToAnsiStr(Cnt) + '(F/Fo)"';
 End;
 Writeln(TxTFile,WriteStr);


 {---End of Heather--}

       ImTime    := 0;
   For ImNr := Beg to ToEnd Do Begin
       FirstTime := True;
//Time Should be given at Hiest precision otherwise PClamp Complains that the Time Intervals
//are uneven.  Therefore I use Sci-format for the Time Column

    For Cnt := 0 to (PLOTvar.NrROI - 1) Do Begin
      If PLOTvar.AdrUsed[Cnt] > 0 then Begin
        if (FirstTime = True) then begin
          if (PLOTvar.AnalType = RATIO_TIME) Then Begin
             if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
              WriteStr := FloatToAnsiStr(ImTime) + Chr(9) +
                FloatToAnsiStr(TSPlotData_BaseSubtr[Cnt,(ImNr-PLOTvar.ImBeg)]/ScaleRat,9,3) else
              WriteStr := FloatToAnsiStr(ImTime) + Chr(9) +
                FloatToAnsiStr(TSPlotData_BaseNotSubtr[Cnt,(ImNr-PLOTvar.ImBeg)]/ScaleRat,9,3)
          end else
          begin
           if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
             WriteStr := FloatToAnsiStr(ImTime) + Chr(9) +
             FloatToAnsiStr(TSPlotData_BaseSubtr[Cnt,(ImNr-PLOTvar.ImBeg)],9,3) else
             WriteStr := FloatToAnsiStr(ImTime) + Chr(9) +
             FloatToAnsiStr(TSPlotData_BaseNotSubtr[Cnt,(ImNr-PLOTvar.ImBeg)],9,3);
          end;

          FirstTime := False;
        end else
          if  (PLOTvar.AnalType = RATIO_TIME) Then begin
           if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
              WriteStr := WriteStr + Chr(9) +
                FloatToAnsiStr(TSPlotData_BaseSubtr[Cnt,(ImNr-PLOTvar.ImBeg)]/ScaleRat,9,3) else
              WriteStr := WriteStr + Chr(9) +
                FloatToAnsiStr(TSPlotData_BaseNotSubtr[Cnt,(ImNr-PLOTvar.ImBeg)]/ScaleRat,9,3);
          end else
          begin
            if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
              WriteStr := WriteStr + Chr(9) +
                FloatToAnsiStr(TSPlotData_BaseSubtr[Cnt,(ImNr-PLOTvar.ImBeg)],9,3) else
              WriteStr := WriteStr + Chr(9) +
                FloatToAnsiStr(TSPlotData_BaseNotSubtr[Cnt,(ImNr-PLOTvar.ImBeg)],9,3)
          end;

      End; {If PLOTvar.AdrUsed[CntROI] > 0}
    End; {CntROI := 0 to (PLOTvar.NrROI - 1)}

      WriteLn(TxTFile, WriteStr);

      ImTime := ImTime + MeanImTime;
      //MeanTime = Time for One Image = TimeSt[High(TimeSt)]/(NrIm-1); because 1st Image starts from Zero

   End; {ImNr := BegIm to EndIm -1}
      CloseFile(TxTFile);

 End; //SavePlotAsPClampATF

{****************************************************************************}

Procedure TMainForm.ExportAreaFileAsTxT(const SaveFName : AnsiString; Sender: TObject);
//exports integrated area
var  Cnt,TrUsed  : Integer;
     WriteStr  : AnsiString;
     FirstTime : Boolean;
     TxtFile   : TextFile;
     ImTime    : Double;

Begin

  AssignFile(TxtFile, SaveFName);
  ReWrite(TxtFile);

  {--- Writes Header -------------------------------------------------------}
  {1st: Writes F Name & Kind of Analysis}

  if (sender = AreasOnly) then begin
    if    (ConvertAreaToNPo) then WriteStr := 'SparkAn "Integrated Area and NPo File"'
      else
    if Not(ConvertAreaToNPo) then WriteStr := 'SparkAn "Integrated Area File"'
  end
    else
  if (sender = AreasROIXYandNrIntegrations) then begin
    if (ConvertAreaToNPo) then
    WriteStr := 'SparkAn "Integrated Area & NPo & ROI X,Y & Nr of Integrations File"'
      else
    if Not(ConvertAreaToNPo) then
    WriteStr := 'SparkAn "Integrated Area & ROI X,Y & Nr of Integrations File"'
  end;

  if (NrChannels = 1) then
      WriteStr := 'SparkAn "Trace File";  Extracted from: ' + PLOT_FTitle + ';  Analysis Type: ' + PLOTvar.Title else
      if (NrChannels = 2) then begin
        if (ChannelOrder = ASCENDING)  then
        WriteStr := 'SparkAn "Trace File";  Extracted from: ' + PLOT_FTitle + ', Channel One;  Analysis Type: ' + PLOTvar.Title else
        if (ChannelOrder = DESCENDING)  then
        WriteStr := 'SparkAn "Trace File";  Extracted from: ' + PLOT_FTitle + ', Channel Two;  Analysis Type: ' + PLOTvar.Title;
  end;

  if (PLOTvar.BaseLineStatus in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      WriteStr := WriteStr + ' (' + IntToStr(PLOTvar.BaseLinePoints)+ '*'+ IntToStr(PLOTvar.NrScanes) + ' points' +
      ', LSD = ' + FloatToStrF(PLOTvar.LSD,ffFixed,1,1) +
      ', RSD = ' + FloatToStrF(PLOTvar.RSD,ffFixed,1,1) + ')'
  else WriteStr := WriteStr + ', Continuous Baseline Not used';

  WriteStr := WriteStr + '; ' + GetFilterSize;

  Writeln(TxTFile,WriteStr);

{2nd Writel What was done}
   TrUsed := 0;   {gives Displyed Traces from all Analyzed = PLOTvar.NrROI}
  For Cnt := 0 to High(Area_Integr) Do Begin
    If (Area_Integr[Cnt] > 0) then Inc(TrUsed);
  End;
  if (sender = AreasOnly) then begin
    if (ConvertAreaToNPo) then
    Writeln(TxTFile,'ROI Nr, Area and NPo from ' + IntToStr(TrUsed) + ' ROI')
    else
    if Not(ConvertAreaToNPo) then
    Writeln(TxTFile,'ROI Nr, Area from ' + IntToStr(TrUsed) + ' ROI')
  end
    else
  if (sender = AreasROIXYandNrIntegrations) then begin
    if (ConvertAreaToNPo) then
    Writeln(TxTFile,'ROI Nr, Area, NPo, ROI X & Y, Nr Integrations from ' + IntToStr(TrUsed) + ' ROI')
    else
    if Not(ConvertAreaToNPo) then
    Writeln(TxTFile,'ROI Nr, Area, ROI X & Y, Nr Integrations from ' + IntToStr(TrUsed) + ' ROI')
  end;

  {3nd: writes ROI kind}
       FirstTime := True;

  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If (Area_Integr[Abs(PLOTvar.AdrUsed[Cnt])-1] > 0) then Begin
      If FirstTime = True Then Begin
        if Abs(PLOTvar.ROIkind[Cnt]) = 1 then WriteStr := 'ROI kind:  Rectangular' else
        if Abs(PLOTvar.ROIkind[Cnt]) = 2 then WriteStr := 'ROI kind:  Ellipse' else
        if Abs(PLOTvar.ROIkind[Cnt]) = 3 then WriteStr := 'ROI kind:  Free Hand' else
        if Abs(PLOTvar.ROIkind[Cnt]) = 4 then WriteStr := 'ROI kind:  Line Scan';
        FirstTime := False;
      End Else
      If FirstTime = False Then Begin
        if Abs(PLOTvar.ROIkind[Cnt]) = 1 then WriteStr := WriteStr + ', Rectangular' else
        if Abs(PLOTvar.ROIkind[Cnt]) = 2 then WriteStr := WriteStr + ', Ellipse' else
        if Abs(PLOTvar.ROIkind[Cnt]) = 3 then WriteStr := WriteStr + ', Free Hand' else
        if Abs(PLOTvar.ROIkind[Cnt]) = 4 then WriteStr := WriteStr + ', Line Scan';
      End; { FirstTime = False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0}
  End; {For Cnt := 0 to PLOTvar.NrROI -1}
   Writeln(TxTFile,WriteStr);

   {4rd: writes X size(s)}
      FirstTime := True;
   For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
     If (Area_Integr[Abs(PLOTvar.AdrUsed[Cnt])-1] > 0) then Begin
      If FirstTime = True Then Begin
         if Abs(PLOTvar.ROIkind[Cnt]) in[1,2,4] then
   WriteStr := 'X & Y size (pix): ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                                'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
   WriteStr := 'X & Y size (pix): Free Hand';
         FirstTime := False;
      End else
      If FirstTime = False Then Begin
         if Abs(PLOTvar.ROIkind[Cnt]) in[1,2,4] then
    WriteStr := WriteStr + '; ' + IntToStr(PLOTvar.ROIsizeXY[0,Cnt]) +
                            'x' + IntToStr(PLOTvar.ROIsizeXY[1,Cnt]) else
    WriteStr := WriteStr +  '; Free Hand';
      End; {False}
     End; {PLOTvar.AdrUsed[CntROI] > 0}
  End;
  Writeln(TxTFile,WriteStr);


   {5th writes X & Y centers (pix)}

       FirstTime := True;

  For Cnt := 0 to PLOTvar.NrROI - 1 Do Begin
    If (Area_Integr[Abs(PLOTvar.AdrUsed[Cnt])-1] > 0) then Begin
      If (FirstTime = True) then Begin
         if Abs(PLOTvar.ROIkind[Cnt]) in[1,2,4] then
   WriteStr := 'Color # & (X,Y) center (pix): Color # '
               + IntToStr(Abs(PLOTvar.AdrUsed[Cnt])) + ' ('
               + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
               ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := 'Color # & (X,Y) center (pix): Color # ' + IntToStr(PLOTvar.AdrUsed[Cnt]);
        FirstTime := False;
      End Else
      If (FirstTime = False) then Begin
         if Abs(PLOTvar.ROIkind[Cnt]) in[1,2,4] then
   WriteStr := WriteStr + ';  Color # ' + IntToStr(Abs(PLOTvar.AdrUsed[Cnt])) + ' ('
                     + IntToStr(PLOTvar.ROIcentXY[0,Cnt]) +
                    ',' + IntToStr(PLOTvar.ROIcentXY[1,Cnt]) + ')' else
   WriteStr := WriteStr + '; Color # ' + IntToStr(Abs(PLOTvar.AdrUsed[Cnt]));
      End; {False}
    End; {If PLOTvar.AdrUsed[CntROI] > 0 }
  End;
  Writeln(TxTFile,WriteStr);

 {---------------------- End of Heather ---------------------------------}


If (Sender = AreasOnly) then Begin
  If (ConvertAreaToNPo) then Begin
    For Cnt := 0 to High(Area_Integr) Do Begin
      if (Area_Integr[Cnt] <> 0) then begin
        WriteStr := IntToAnsiStr(Cnt+1) + Chr(9) + FloatToAnsiStr(Area_Integr[Cnt],12,3) + Chr(9) + FloatToAnsiStr(NPo_Trace[Cnt],12,3);
        WriteLn(TxTFile, WriteStr);
      end;
    End;
  End //If (ConvertAreaToNPo) then Begin
    Else
  If Not(ConvertAreaToNPo) then Begin
  For Cnt := 0 to High(Area_Integr) Do Begin
    if (Area_Integr[Cnt] <> 0) then begin
      WriteStr := IntToAnsiStr(Cnt+1) + Chr(9) + FloatToAnsiStr(Area_Integr[Cnt],12,3);
      WriteLn(TxTFile, WriteStr);
    end;
  End;
  End; //If Not(ConvertAreaToNPo) then Begin
End

  Else

If (sender = AreasROIXYandNrIntegrations) then Begin
  If (ConvertAreaToNPo) then Begin
  For Cnt := 0 to High(Area_Integr) Do Begin
    if (Area_Integr[Cnt] <> 0) then begin
      WriteStr := IntToAnsiStr(Cnt+1) + Chr(9) + FloatToAnsiStr(Area_Integr[Cnt],12,3) + Chr(9) + FloatToAnsiStr(NPo_Trace[Cnt],12,3) + Chr(9) +
      IntToAnsiStr(ROI_XY[Cnt].X) + Chr(9) + IntToAnsiStr(ROI_XY[Cnt].Y) + Chr(9) +
      IntToAnsiStr(NrIntegrTrace[Cnt]);
      WriteLn(TxTFile, WriteStr);
    end;
  End;
  End
    Else
  If Not(ConvertAreaToNPo) then Begin
  For Cnt := 0 to High(Area_Integr) Do Begin
    if (Area_Integr[Cnt] <> 0) then begin
      WriteStr := IntToAnsiStr(Cnt+1) + Chr(9) + FloatToAnsiStr(Area_Integr[Cnt],12,3) + Chr(9) +
      IntToAnsiStr(ROI_XY[Cnt].X) + Chr(9) + IntToAnsiStr(ROI_XY[Cnt].Y) + Chr(9) +
      IntToAnsiStr(NrIntegrTrace[Cnt]);
      WriteLn(TxTFile, WriteStr);
    end;
  End;
  End;
End; //If (sender = AreasROIXYandNrIntegrations) then Begin

  CloseFile(TxTFile);

End; //Procedure TMainForm.ExportAreaFileAsTxT(const SaveFName : AnsiString; Sender: TObject);

{************************************************************************************************}

function TMainForm.GetFilterSize : AnsiString;  //Gets the Filter Used on Trace
begin
  if (PLOTvar.SmTraceKind = BOXCART1D) then begin
    if (PLOTvar.SmTrBoxcarIndex = 0) then
      Result := 'No Trace Smoothing'
    else begin
      if (PLOTvar.SmTrBoxcarIndex = 1) then
        Result := 'Boxcar Smoothing = 3 points' else
      if (PLOTvar.SmTrBoxcarIndex = 2) then
        Result := 'Boxcar Smoothing = 5 points' else
      if (PLOTvar.SmTrBoxcarIndex = 3) then
        Result := 'Boxcar Smoothing = 7 points' else
      if (PLOTvar.SmTrBoxcarIndex = 4) then
        Result := 'Boxcar Smoothing = 9 points' else
      if (PLOTvar.SmTrBoxcarIndex = 5) then
        Result := 'Boxcar Smoothing = 11 points';
    end;
  end else
  if (PLOTvar.SmTraceKind = GAUSS1D) then begin
    if (PLOTvar.SmTrGaussIndex = 0) then
      Result := 'No Trace Smoothing'
    else begin
      if (PLOTvar.SmTrGaussIndex = 1) then
        Result := 'Gaussian Smoothing = 3 L points' else
      if (PLOTvar.SmTrGaussIndex = 2) then
        Result := 'Gaussian Smoothing = 3 M points' else
      if (PLOTvar.SmTrGaussIndex = 3) then
        Result := 'Gaussian Smoothing = 3 H points' else
      if (PLOTvar.SmTrGaussIndex = 4) then
        Result := 'Gaussian Smoothing = 5 points' else
      if (PLOTvar.SmTrGaussIndex = 5) then
        Result := 'Gaussian Smoothing = 7 points' else
      if (PLOTvar.SmTrGaussIndex = 6) then
        Result := 'Gaussian Smoothing = 9 points' else
      if (PLOTvar.SmTrGaussIndex = 7) then
        Result := 'Gaussian Smoothing = 11 points';
    end;
  end else
  if (PLOTvar.SmTraceKind = GAUSS1D_Fc) then begin
    if (PLOTvar.SmTrGaussFcIndex = 0) then
      Result := 'No Trace Smoothing'
    else begin
      if (PLOTvar.SmTrGaussFcIndex = 1) then
      Result := 'Gaussian Filter ' + FloatToStrF(PLOTvar.FcGaussFlt,ffFixed,5,2) + ' Hz';
    end;
  end else
  if (PLOTvar.SmTraceKind = KALMAN1D) then begin
    if (PLOTvar.SmTrKalmanIndex = 0) then
      Result :=  'No Trace Smoothing'
    else begin
      if (PLOTvar.SmTrKalmanIndex = 1) then
         Result := 'Kalman Filter Gain = 0.1, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 2) then
         Result := 'Kalman Filter Gain = 0.2, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 3) then
         Result := 'Kalman Filter Gain = 0.3, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 4) then
         Result := 'Kalman Filter Gain = 0.4, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 5) then
         Result := 'Kalman Filter Gain = 0.5, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 6) then
         Result := 'Kalman Filter Gain = 0.6, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 7) then
         Result := 'Kalman Filter Gain = 0.7, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 8) then
         Result := 'Kalman Filter Gain = 0.8, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 9) then
         Result := 'Kalman Filter Gain = 0.9, Noise Variance Estimate = 0.05' else
      if (PLOTvar.SmTrKalmanIndex = 10) then
         Result := 'Kalman Filter Gain = 1.0, Noise Variance Estimate = 0.05';
    end;
  end;
end;


Procedure TMainForm.OpenSparkAnParameters(Sender : TObject);
var GiveMess   : Boolean;
    i,L,T,W,H  : Integer;
    TempROIvar : TROIvar;
Begin

    TempROIvar.NrROI := ROIvar.NrROI; //Save before ReadSparkAnPar
    if (ROIvar.NrROI > 0) then begin
      TempROIvar.ROICoor := ROIvar.ROICoor;
      TempROIvar.ROIAdr  := ROIvar.ROIAdr;
    end;

     {DidGetSparkAnPar [global] is set by ReadSparkAnPar}
     GiveMess         := True; {if par file is wrong}
     ReadSparkAnPar(OpenFileDialog.FileName,DidGetSparkAnPar,GiveMess);

  MessageDlg('Sets the "Image Setting and Tool", "Time Series Plot", and "Event Auto Detection" windows only.  To update other windows close and reopen them.',mtInformation,[mbOK],0);

    With frmTimeSerPlot Do Begin

      enTraceMinPoints.NumberOne := TimPltSlid.AreaMinPoints;
      scrbPeakThresh.Position   := TimPltSlid.PeakThresh;
      cbSmTraceKind.ItemIndex   := TimPltSlid.SmTraceKind;
      cbSmTraceKindChange(Sender); //this initializes SmTrBoxcarIndex  or  SmTrGaussIndex
      enBaseLinePoints.NumberOne  := TimPltSlid.BaseLinePoints;
      if (enBaseLinePoints.NumberOne > enBaseLinePoints.Max) then enBaseLinePoints.NumberOne := round(enBaseLinePoints.Max);
      NrPasses.ItemIndex          := TimPltSlid.NrPassesIndex;
      enLSD.NumberFloat           := TimPltSlid.LSD;
      enRSD.NumberFloat           := TimPltSlid.RSD;
      {Baseline Found Separately for each peak}
      cbGetEachPeakBase.Checked   := TimPltSlid.GetEachPeakBase;
      edEachPeakBasePt.NumberOne  := TimPltSlid.EachPeakBasePt; //Nr of Points to Find Minimum (baseline)
      edEachPeakBaseRg.NumberOne  := TimPltSlid.EachPeakBaseRg;

      lbFinalPoints.Caption := '= ' + IntToStr(GetFinalEventWidth(StrToInt(NrPasses.Items[NrPasses.ItemIndex])));
      //Sets to ubWithoutBaseline to be on the Safe Side
      if not(ubWithoutBaseline.Selected) then begin
        ubGetBaseline.Selected := False;
        unSubtractBaseline.Selected := False;
        unDivideByBaseline.Selected := False;
        ubWithoutBaseline.Selected := True;
        ubWithoutBaselineClick(Sender);
      end;
     // if (MainImLoaded) then BaseLineControlsClick(Sender);
    End;


  // Recriates frmImageControl, it is easier this way than to set every widget individually

    with frmImageControl do begin  //get window position on screan
      L := frmImageControl.Left;
      T := frmImageControl.Top;
      W := frmImageControl.Width;
      H := frmImageControl.Height;
    end;

    with Application.MainForm do begin
      for i:= 0 to MdiChildCount - 1 do begin
        if MDIChildren[i].Name = frmImageControl.Name then begin
          MDIChildren[i].Close;
          Break;
        end;
      end;
    end;

    Application.CreateForm(TfrmImageControl, frmImageControl);
    frmImageControl.SetBounds(L,T,W,H);

    ROIvar.NrROI := TempROIvar.NrROI; //restore ROI settings
    if (ROIvar.NrROI > 0) then begin
      ROIvar.ROICoor := TempROIvar.ROICoor;
      ROIvar.ROIAdr  := TempROIvar.ROIAdr;
    end;

    If (MainImLoaded) then With frmImageControl Do Begin
      ubRatioOn.Enabled    := True;
      ubApplyFrame.Enabled := True;
      ubSizeBar.Enabled    := True;
      ubGrid.Enabled       := True;

      ToolsToolBar.Enabled := True;
      MeasureBox.Down := False;
      scrBoxXsize.Enabled := True; { in order to change maximum }
      scrBoxYsize.Enabled := True; { and to be able to disable }
      scrBoxXsize.Max := imXsize - 2;
      scrBoxYsize.Max := imYsize - 2;
      scrBoxXsize.Enabled := False;
      scrBoxYsize.Enabled := False;
      Select.Down := True;
      SelectClick(Sender);
      lblBoxXsize.Caption := '';
      lblXmicrons.Caption := '';
      lblBoxYsize.Caption := '';
      lblYmicrons.Caption := '';

      enPixRange.HideText := False;
      if (BitCount = 16) then begin
        SetRange.Enabled := True;
        DSPixRange.Enabled := True;
        enPixRange.Enabled := True;
        if (AutoSetRange.Down) or (DSPixRange.Max <> round(exp((shrFact + 8) * ln(2))) - 1) then
        begin
          DSPixRange.SetSlider(0,round(exp((shrFact + 8) * ln(2))) - 1, // = 2^bit-dept
                               0, round(exp((shrFact + 8) * ln(2))) - 1);
          DSPixRange.Delta := 255;
          enPixRange.Min := 0;
          enPixRange.Max := round(exp((shrFact + 8) * ln(2))) - 1;
          SetRangeClick(Sender); //refresh graph
          end;
        end
          else
      if (BitCount = 8) then begin
          { DoSetRange remains False }
        SetRange.Enabled := False;
        DSPixRange.Enabled := False;
        enPixRange.Enabled := False;
        DSPixRange.Delta := 1;
        DSPixRange.SetSlider(0, 255, 0, 255);
      end;

      if (RatioOn) then begin //refresh
        frmImageControl.ubRatioOn.Selected := True;
        frmImageControl.ubRatioOn.Click; ///keep it otherwise does work after that when is clicked 1st time
      end;
    End; //If (ImFileOpen) then With frmImageControl Do Begin

    //Updates frmSPautoSearch without recriation
    if (frmSPautoSearch <> nil) then frmSPautoSearch.SetSPautoSearch(AutoSearchPar);

  End;


End.



