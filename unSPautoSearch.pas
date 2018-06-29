{$D-,L-,O+,Q-,R-,Y-,S-}
unit unSPautoSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs,Vcl.Buttons,System.StrUtils,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ImgList,Vcl.Grids,
  System.Math, SuperSubLabel, DSlider, EditNumerical, unGlobUnit,
  PanelPaintCanvas;


type TMeanAndSD = Record
      Mean : Double;
      SD   : Double;
end;

type TMeanAndSDArray = Array of TMeanAndSD;

type
  TfrmSPautoSearch = class(TForm)
    trbThresh: TTrackBar;
    trbPerc: TTrackBar;
    lblThresh: TLabel;
    lblPerc: TLabel;
    trbScanBoxSize: TTrackBar;
    lblScanBoxSize: TLabel;
    ToolBarSPautoSearch: TToolBar;
    StartSearch: TToolButton;
    StopSearchButton: TToolButton;
    ImageListSPautoSearch: TImageList;
    TitleScanBox: TLabel;
    trbMaxSparkSize: TTrackBar;
    lblImageCnt: TLabel;
    Bevel1: TBevel;
    TitleSearchFromTo: TLabel;
    Bevel2: TBevel;
    TitleThresh: TLabel;
    tlTolerance: TLabel;
    btnCreateAverageImage: TButton;
    cbUseRunAver: TCheckBox;
    Bevel4: TBevel;
    ProgrBarAutoSearch: TProgressBar;
    SmallEvTest: TCheckBox;
    Bevel5: TBevel;
    lblMessage: TLabel;
    cbIgnoreBigEv: TCheckBox;
    lbSmall: TLabel;
    lblMaxSparkSiteSize: TSuperSubLabel;
    GenHelp: TSpeedButton;
    EdnSearchFromTo: TEditNumerical;
    dsSerchFromTo: TDSlider;
    enNrImGetMinLeft: TEditNumerical;
    lbNrImGetMinVal: TLabel;
    enNrImRunAver: TEditNumerical;
    enNrImToLeftOfEv: TEditNumerical;
    Bevel6: TBevel;
    Label4: TLabel;
    SearchLms: TEditNumerical;
    SearchRms: TEditNumerical;
    Label1: TLabel;
    Label6: TLabel;
    Bevel8: TBevel;
    cbGetSmEvDur: TCheckBox;
    cbGetBigEvDur: TCheckBox;
    enPLval: TEditNumerical;
    Label7: TLabel;
    enNrImToRightOfEv: TEditNumerical;
    enPRval: TEditNumerical;
    cbCreateAutoAverImage: TCheckBox;
    enAutoAverNrImInc: TEditNumerical;
    cbStartAutoAverFirstIm: TCheckBox;
    cbSaveAutoAver: TCheckBox;
    enAutoAverImRange: TEditNumerical;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    cbUpdateRatio: TCheckBox;
    enNrImGetMinRight: TEditNumerical;
    Label11: TLabel;
    Label12: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cbUseCustomROIforSmEvTest: TCheckBox;
    enROISizeForSmEvTest: TEditNumerical;
    enPointsToAver: TEditNumerical;
    Label15: TLabel;
    Label16: TLabel;
    cbSDuse: TCheckBox;
    enSDfold: TEditNumerical;
    lbBig: TLabel;
    lbSlash: TLabel;
    Label17: TLabel;
    ShapeEvMaxSize: TShape;
    cbFinalCutoff: TCheckBox;
    Bevel3: TBevel;
    procedure cbGetBigEvDurClick(Sender: TObject);
    procedure cbGetSmEvDurClick(Sender: TObject);
    procedure SearchRmsReturnPressed(Sender: TObject);
    procedure SearchLmsReturnPressed(Sender: TObject);
    procedure enNrImToLeftOfEvReturnPressed(Sender: TObject);
    procedure enNrImRunAverReturnPressed(Sender: TObject);
    procedure enNrImGetMinLeftReturnPressed(Sender: TObject);
    procedure lbNrImGetMinValMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EdnSearchFromToReturnPressed(Sender: TObject);
    procedure dsSerchFromToChange(Sender: TObject);
    procedure GenHelpClick(Sender: TObject);
    procedure cbIgnoreBigEvMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbPutFirstMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbPutMaxOfEvMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RunMinAverMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbUseRunAverMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbSmallMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TitleScanBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tlToleranceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TitleThreshMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trbThreshChange(Sender: TObject);
    procedure trbPercChange(Sender: TObject);
    procedure trbScanBoxSizeChange(Sender: TObject);
    procedure StartSearchClick(Sender: TObject);
    procedure trbMaxSparkSizeChange(Sender: TObject);
    procedure StopSearchButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCreateAverageImageClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure enNrImRunAverKeyPress(Sender: TObject; var Key: Char);
    procedure cbUseRunAverClick(Sender: TObject);
    procedure SmallEvTestClick(Sender: TObject);
    procedure cbIgnoreBigEvClick(Sender: TObject);
    procedure SmallEvTestMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TitleCreateAvImageMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure enNrImToRightOfEvReturnPressed(Sender: TObject);
    procedure enPLvalReturnPressed(Sender: TObject);
    procedure enPRvalReturnPressed(Sender: TObject);
    procedure enAutoAverNrImIncReturnPressed(Sender: TObject);
    procedure cbCreateAutoAverImageClick(Sender: TObject);
    procedure cbStartAutoAverFirstImClick(Sender: TObject);
    procedure cbSaveAutoAverClick(Sender: TObject);
    procedure enAutoAverImRangeReturnPressed(Sender: TObject);
    procedure cbUpdateRatioClick(Sender: TObject);
    procedure enNrImGetMinRightReturnPressed(Sender: TObject);
    procedure cbUseCustomROIforSmEvTestClick(Sender: TObject);
    procedure enROISizeForSmEvTestReturnPressed(Sender: TObject);
    procedure enPointsToAverReturnPressed(Sender: TObject);
    procedure cbSDuseClick(Sender: TObject);
    procedure enSDfoldReturnPressed(Sender: TObject);
    procedure ShapeEvMaxSizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShapeEvMaxSizeMouseEnter(Sender: TObject);
    procedure ShapeEvMaxSizeMouseLeave(Sender: TObject);
    procedure cbFinalCutoffClick(Sender: TObject);


  private
    { Private declarations }
    Bt : TMouseButton; //passes which button was pressed on ShapeEvMaxSize to StartSearchClick
    procedure CreateAverageImageUsingMinimum(Sender : TObject; Beg,ToEnd : Integer; const MessageMode : Integer);
    Procedure GetStdDev(Const Data: TDynWordArray; var StdDev : Double);
    Function  GetSimpleMean(Const Data: TDynSingleArray) : Double;
    Procedure BoxCarSmooth1D(Const SourceArr : TDynSingleArray; var OutArr : TDynSingleArray;
                         Const Points : Integer);  //Points is the Filter Kernel in Pixels

    procedure GetMapOfActivity; // in Testing  Not In Use
    //used on Tom's flashes Creates a map of active spots on Average image Window

    procedure InsertSortMeanAndSDbyMean(var ToSortMeanAndSD : TMeanAndSDArray);

    procedure SetProgressBar(const MinLim,MaxLim,Pos : Integer);


  public
    { Public declarations }
    function  EventsAutoSearchSettingsOK(Const CheckIfAverImSaved : Boolean) : Boolean;
    procedure SetSPautoSearch(const AutoSPar : TAutoSearchPar);

  end;

var
  frmSPautoSearch : TfrmSPautoSearch;
  


IMPLEMENTATION

Uses Main, unTimeSerAnal, unMainWindow,unAverIm,unSparkTable, unWaveTable,
    unImageControl, unPlayBack,DigiFilters,unProgress,unEventSites,unFunctions,
    un2ndWin,ImageFilesOpeningRoutines,unQueueFiles;

{$R *.dfm}

{*****************************************************************************}
procedure TfrmSPautoSearch.InsertSortMeanAndSDbyMean(var ToSortMeanAndSD : TMeanAndSDArray);
//tested separately
var i,j,k : Integer;
    Hold,SD  : Double;

begin
  for i := 1 to High(ToSortMeanAndSD) do
  begin
    Hold := ToSortMeanAndSD[i].Mean;
    SD   := ToSortMeanAndSD[i].SD;
    j := i;
    k := j - 1;
    while ((j > 0) and (ToSortMeanAndSD[k].Mean > Hold)) do
    begin
     ToSortMeanAndSD[j] := ToSortMeanAndSD[k]; // no need to copy mean and SD separately
      Dec(j);
      Dec(k);
    end;
    ToSortMeanAndSD[j].Mean := Hold;
    ToSortMeanAndSD[j].SD   := SD;
  end;
  {Better than the bubble sort because we move one
  value at a time to its correct position in the array.
  There are no value exchanges and only one value
  assignment per iteration of the inner loop

  As a general rule the best of the O(n^2) sorts}
end;



{******************************************************************************}


procedure TfrmSPautoSearch.trbThreshChange(Sender: TObject);
begin
      lblThresh.Caption := FloatToStrF(trbThresh.Position/100,ffFixed,3,2);
      AutoSearchPar.Thresh := trbThresh.Position;
end;

procedure TfrmSPautoSearch.trbPercChange(Sender: TObject);
begin
   lblPerc.Caption := IntToStr(100 - trbPerc.Position) + '%';
   AutoSearchPar.Tolerance := trbPerc.Position;
end;

procedure TfrmSPautoSearch.trbScanBoxSizeChange(Sender: TObject);
begin
      lblScanBoxSize.Caption :=
      IntToStr(trbScanBoxSize.Position)+ 'x' +IntToStr(trbScanBoxSize.Position) + ' p';
      AutoSearchPar.ScanBoxSize := trbScanBoxSize.Position;
end;

procedure TfrmSPautoSearch.trbMaxSparkSizeChange(Sender: TObject);
begin
    lblMaxSparkSiteSize.Caption := IntToStr(trbMaxSparkSize.Position*50) + ' p^2';
     AutoSearchPar.MaxArea := trbMaxSparkSize.Position*50;
     with ShapeEvMaxSize do begin
      Width := round(2*(Sqrt(trbMaxSparkSize.Position*50/pi)));
      {S = pi*r2; Diam = 2*r}
      Height := Width;
      Left := 45  - round(Width/2);
      Top  := 230 - round(Height/2);
     end;

end;

{******************************************************************************}
procedure TfrmSPautoSearch.SetProgressBar(const MinLim,MaxLim,Pos : Integer);

begin
  with ProgrBarAutoSearch do begin
    Min := 0;
    Max := High(Integer);
    Position := Pos;
    Min := MinLim;
    Max := MaxLim;
  end;
end;

{******************************************************************************}
function TfrmSPautoSearch.EventsAutoSearchSettingsOK(Const CheckIfAverImSaved : Boolean) : Boolean;
var SettingsOK : Boolean;
Begin



  SettingsOK := True;

  if (MovFType = ANDOR_MOV) and Not(DimTime > -1) then begin
    SettingsOK := False;
    MessageDlg('Andor TIFF File does not contain Time Dimension',mtInformation,[mbOK],0);
  end;

  if (SettingsOK) then begin
  if (AutoSearchPar.NrImForCreateAvIm > NrIm) and (AutoSearchPar.AutoAverImage) then begin
    SettingsOK := False;
    MessageDlg('When Using "Create Average Image" the Number of Images for Minimum Average "Min Of" should be Less or Equal to the Number of Images in File',mtInformation,[mbOK],0);
   end;
  end;

  if (SettingsOK) then begin
  if (AutoSearchPar.AutoAverImRange > NrIm) and (AutoSearchPar.AutoAverImage) then begin
    SettingsOK := False;
    MessageDlg('When Using "Create Average Image" the Range of Images "From the Range Of" should be Less or Equal to the Number of Images in File',mtInformation,[mbOK],0);
   end;
  end;

  if (SettingsOK) then begin
  if not((SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX]) or (SmoothMode in [SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]))
  then begin
    SettingsOK := False;
    MessageDlg('Boxcar or Gauss + Median Filters should be On!',mtInformation,[mbOK],0);
  end;
  end;

  if (SettingsOK) then begin
  if not(RatioOn) and not((AutoSearchPar.AutoAverImage) and (AutoSearchPar.StartAutoAverFirstIm))
  then begin
    SettingsOK := False;
    MessageDlg('F/Fo should be On for this Option!',mtInformation,[mbOK],0);
  end;
  //StartAutoAverFirstIm can be Off if for the begining Existing Average Image is Used. Later it will be Updated !!!
  // In this Case Rato should be On.
  end;

  if (SettingsOK) and (CheckIfAverImSaved) then begin //called by frmQueueFiles
  if (RatioOn) and (AvImExists = AVER_FROM_JUST_GEN) and not(AutoSearchPar.AutoAverImage)
  then begin
    SettingsOK := False;
    MessageDlg('Save Constructed Average Image to a File!',mtInformation,[mbOK],0);
  end;
  end;

  //Check if everything is OK with the Small Events Test//
  If (AutoSearchPar.TestSmallEv) and (SettingsOK) Then Begin
    if (AutoSearchPar.NrImGetMinLeft > Round(AutoSearchPar.SearchLms/(MeanImTime*1000))) then begin
      SettingsOK := False;
      MessageDlg('Increse Time for Search left to the Peak or decrease number of Images!',mtInformation,[mbOK],0);
    end;

    if (AutoSearchPar.NrImGetMinRight > Round(AutoSearchPar.SearchRms/(MeanImTime*1000))) and (SettingsOK) then begin
      SettingsOK := False;
      MessageDlg('Increse Time for Search right to the Peak or decrease number of Images!',mtInformation,[mbOK],0);
    end;

    if (AutoSearchPar.NrImToLeftOfEv > Round(AutoSearchPar.SearchLms/(MeanImTime*1000))) and (SettingsOK) then begin
      SettingsOK := False;
      MessageDlg('Increse Time for Search left to the Peak or decrease number of Points!',mtInformation,[mbOK],0);
    end;

    if (AutoSearchPar.NrImToRightOfEv > Round(AutoSearchPar.SearchRms/(MeanImTime*1000))) and (SettingsOK) then begin
      SettingsOK := False;
      MessageDlg('Increse Time for Search right to the Peak or decrease number of Points!',mtInformation,[mbOK],0);
    end;
  End;

  Result := SettingsOK;

End;

{******************************************************************************}

procedure TfrmSPautoSearch.ShapeEvMaxSizeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : Integer;
begin

  If ((button = mbLeft) or (button = mbMiddle)) and (StartSearch.Enabled) then Begin
    Bt := Button;
    StartSearchClick(Sender);
  End
    else
  If (Button = mbRight) then Begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 48;
    GetHelp(HelpCode);
  End;

End;

procedure TfrmSPautoSearch.ShapeEvMaxSizeMouseEnter(Sender: TObject);
begin
   ShapeEvMaxSize.Brush.Color := $008080FF;
end;

procedure TfrmSPautoSearch.ShapeEvMaxSizeMouseLeave(Sender: TObject);
begin
   ShapeEvMaxSize.Brush.Color := clRed;
end;


{******************************************************************************}

Procedure TfrmSPautoSearch.StartSearchClick(Sender: TObject);


Type
     
     TSiteTable        = array of array of array[0..2] of integer;
    {SiteTable[Site Number, Site Row , 0 = Row Value (Y) 1 = Xbeg 2 = Xend of Site] }
    {translates Site Number to Column addres in SPcoor}

VAR

RatIm, RatImForSmooth  : TDynSingleArray; //2 D Ratioed Image

Smap        : TDyn2DIntArray; {"Binary" Map of the Current Image}
SmapPr      : TDyn2DIntArray; {"Binary" Map of the Previous Image}

Beg, ToEnd  : integer;
BegSearch   : integer;
EndSearch   : Integer;
Cnt         : integer;
CntY, CntX  : integer;
CntIm       : integer;
Ytop, Ybot, Xbeg, Xend : integer;  {limits of Area to be analyzed; in Check Small Events - the ROI}

ScBoxMean   : Double; {mean Value of  ScanBox}
ScanBS      : integer;  {X and Y ScanBoxSize, X = Y}
ScanBL      : integer; {X and Y Length-1; saves Time}
ScanBel     : integer; {number of elements (pixels in Scan Box}
ScanXBorder : integer; //maximum and minimum X where the Left and the Right end of the ScanBox should not exceed

Thresh             : Double; {Threshold}
PLval              : Double; {Percent of Peak Value for points Left of Peak to be kept }
PRval              : Double; {Percent of Peak Value for points Right of right of Peak to be kept }

PixAbTr            : integer;           {number of Pixels above Threshold}
PercPixAboveThresh : Single; {Percent (rather part of 1) above Trhesh}
TempPixAbTr        : Integer; {calculates number of Pixels above Threshold in each scan}
CntXbox, CntYbox   : integer;

SPcnt    : integer;  {Sparks in Current Image}
SPcntPr  : integer;  {Sparks in Previous Image}

WAVcnt   : integer;  {Waves in Current Image}
WAVcntPr : integer;  {Waves in Previous Image}

SiteCnt   : integer;   {counts spark & waves sites per image}
SiteCntPr : integer; {Spark & Waves sites in Previous Image} 

CntRow       : integer;
SiteVal      : Integer; {is Zero in Not Found}
SourceSiteNr : integer;
TargetSiteNr : integer;
CountX,CountY : integer;  {Local Counters }
LocX, LocY : integer;   {Local Counters}

PrevEventFound : Integer;  {for Both Sparks & Waves (big events)}
{if = 0 Nothing Found; -1 = Sparks; +1 = Waves}
FirstRow, LastRow : integer;  {First Top Y and Bottom Y Above Thresh}
FirstX, LastX     : integer;
SPsiteMaxSize : integer;

SiteTable     : TSiteTable; {SiteTable[Site Number, Site Row (Y),  Xbeg .. Xend of Site] }
SiteRowCnt    : TDynIntArray; {counts Row in each Spark Site}
SitePixCnt    : TDynIntArray; {Counts Pixel in a Site; Used to distinguish between Sparks and Waves}

Peak          : TDynSingleArray; {Spark Peaks im One Image}
PeakXY        : TDynTPointArray; {Coordinates (X,Y) of SpPeak in One Image}
Ytrack        : integer;

EVcoorX       : TDyn2DWordArray;  {Has X Spark Coordinates for All Images;}
EVcoorY       : TDyn2DWordArray;  {Has Y Spark Coordinates for All Images}
EVpeaks       : TDyn2DSingleArr;  {Has Spark Peaks for All Images;}
NrOfCol       : Integer;

LastEVCol     : integer; {LastCol from SPcoor is in Fact the First Free One}

IndTab        : TDynIntArray; {Index Table: Stores Column Number for each Event X,Y; for the Current Image}
IndTabPr      : TDynIntArray; {Index Table: Stores Column Number for each Event X,Y; for Previous Image}

{-- Each Triade Has the same Length = Number of Sparks or Waves Found In All Images Analyzed}
SPpeakImNr    : TDynIntArray; {Stores the Image Number where Max Spark Peak was Found}
FINSPcoor     : TDynTPointArray;
FINSPpeaks    : TDynSingleArray;

WavPeakImNr   : TDynIntArray; {Stores the Image Number where Max Wav Peak was Found}
FINWavCoor    : TDynTPointArray;
FINWavPeaks   : TDynSingleArray;
HalfNrImAv    : integer; {HalfNrImAv = NrImToAver div 2}
RunAvRaw      : TDynDoubleArray; {Raw running Average use also for Min Running Average}
RunAv         : TDynDoubleArray; {Smoothed Runnig Average}
RunAvRat      : TDynDoubleArray; {Ratio of Running Average}
ImList        : TDynIntArray; {list of images to Aver for Running Average}

 SmapRAV     : TDyn2DIntArray; {Map of the Current Running Average Image}
 SiteCntRAV  : integer; {Counts Site in Running Average}
 FirstRowRAV : integer;
 LastRowRAV  : integer;
 FirstRavX   : integer;
 LastRavX    : integer;
 SiteCntMem  : integer;
 DuplFound   : Boolean;
 BegFill     : Boolean;
 MeanAvIm    : Double;
 NewEvFound  : Boolean;
 BiggestIndex: Integer;
 BiggestAmpl : Single;
 CopyBorder  : Boolean;
 pRatIm      : Pointer; {pointer to RatIm}
 LSD,RSD     : Double;
 BackUpFile  : THandle; {WIN32&64API handle}
 BackUpFileName : AnsiString;
 AutoAverFileName : AnsiString;
 FPos        : Int64;
 {64 bites Min int64 value = -9223372036854775808
   Max int64 value = 9,223,372,036,854,775,807}

 /////////  VARs used in Testing Small Events //////////////////
 SpPeakXY    : TPoint;  {used in Final Rejection}
 SpPeak      : Double;  {used in Final Rejection}
 MinVal      : Double;
 MaxVal      : Double;
 BaseVal     : Double;
 MaxPos      : Integer;
 MinPos      : Integer;
 MeanVal     : Double;   {Holds the Average BOX (ROI) value for one Image or more images dedermined by NrImGetMin}
 OneImVal    : Double;   {Holds the Average BOX (ROI) value for one Image}
 KillSpark   : Boolean;
 ReadFBeg    : LongInt;   //used in Testing Small Events
 ReadFend    : LongInt;   //Testing Small Events

 //SD test = if Peak > Baseline + SD*fold
 BuffImValues    : TDynDoubleArray; //used to store ROI value and pass them to Math function StdDev
 MeanAndSD       : TMeanAndSDArray; //stores Mean and SD of Each window of NrImToGetMinLeft
 MeanSelTrAndSD  : TMeanAndSDArray; //stores Selected Mean, i.e. Peak - Mean > Thresh, and SD of Each window of NrImToGetMinLeft

 procedure PrintPixSize;  //prints the Pixel Size in the Middle of the Events Found
 var EvNr,PrevEvNr,EvY,EvX : Integer;
     EvYt,EvYb,EvXl,EvXr,CntSite : Integer;
     EvTexWidht,EvTextHeight,EvTextXpos : Integer;
 begin

  PrevEvNr := 0;

  For CntSite := 1 to SiteCnt Do Begin

  For EvY := Ytop to Ybot Do Begin
    For EvX := Xbeg to Xend  Do Begin
      if (Smap[EvX,EvY] <> 0) and (Abs(Smap[EvX,EvY]) = CntSite) and (Abs(PrevEvNr) <> CntSite) then begin
        EvNr := Smap[EvX,EvY];
        PrevEvNr := EvNr;
        EvYt := EvY; // this is the absolute Yt = Ytop
        EvYb := EvYt;
        EvXl := EvX;
        EvXr := EvXl;
        Break;
      end;
    End;
  End;


  For EvY := Ytop to Ybot Do Begin
    For EvX := Xbeg to Xend  Do Begin
      if (Smap[EvX,EvY] = EvNr) then begin
        if (EvYb < EvY) then EvYb := EvY;
        if (EvXl > EvX) then EvXl := EvX;
        if (EvXr < EvX) then EvXr := EvX;
      end;
    End;
  End;

  with frm2ndWin.win2ndImage do begin

  Canvas.Font.Name := 'Tahoma';
  Canvas.Font.Size := 10;
  Canvas.Font.Color := clWhite;
  EvTexWidht := Canvas.TextWidth(IntToStr(SitePixCnt[CntSite-1]));
  EvTextHeight := Canvas.TextHeight(IntToStr(SitePixCnt[CntSite-1]));

  EvTextXpos := EvXl + round((EvXr-EvXl)/2) - round(EvTexWidht/2);
  if (EvTextXpos < 5) then EvTextXpos := 5;
  if (EvTextXpos + round(EvTexWidht/2) > imXsize - 1 - 5) then
      EvTextXpos := (imXsize - 1 - 5) - round(EvTexWidht/2);

  Canvas.TextOut(EvTextXpos,
                 EvYt + round((EvYb-EvYt)/2) - round(EvTextHeight/2),
                 IntToStr(SitePixCnt[CntSite-1]));

  end; //with
  End;  //For CntSite := 1 to SiteCnt Do Begin

 end; //procedure PrintPixSize;

BEGIN


If (EventsAutoSearchSettingsOK(False)) Then Begin

        {prevents Windows of Goin to Hibernating and Turning Off}
        MainForm.PwrSaveSparkAn.AllowSuspend    := False;
        MainForm.PwrSaveSparkAn.AllowStandby    := False;
        MainForm.PwrSaveSparkAn.AllowEndSession := False;

        BegFill := False;
        if (frmQueueFiles <> nil) then begin
          if (sender = frmQueueFiles.Run) then BegFill := True;
          {here BegFil is used as a GENERIC Boolean to avoid using too many variables
           it can be used safely because it is used at the end of the procedure and it
           is initialized there.
           It is used because if frmQueueFiles is not Open a Call to Sender = frmQueueFiles.Run
           causes Crash.}
        end;

        If (sender = StartSearch) or (BegFill) then Begin
          Beg          := dsSerchFromTo.PosFrom; {Beg of Reading File}
          BegSearch    := dsSerchFromTo.PosFrom; {Beg of Actual Searching File}
          EndSearch    := dsSerchFromTo.PosTo;   {Beg of Actual Searching File}
          ToEnd        := dsSerchFromTo.PosTo;

          {Beg = BegSearch if Spark Test is Not Enabled}
          If (AutoSearchPar.TestSmallEv) Then with AutoSearchPar do begin {do Spark Test = Find Bkg in Trace}
            Beg   := BegSearch - Round(SearchLms/(MeanImTime*1000)) - 1; // -1 to Start one image before Peak
            if (Beg < 0)  then Beg := 0;
            ToEnd := EndSearch + Round(SearchRms/(MeanImTime*1000)) + 1; // +1 to Start one image after Peak
            if (ToEnd > NrIm -1) then ToEnd := NrIm - 1;
          End;  {(AutoSearchPar.TestSmallEv)}

        End

          else

        If (sender = ShapeEvMaxSize)  then Begin
          //this analyzes One Image and Prints sMap on the 2nd window//
          Beg          := CurIm; {Beg of Reading File}
          BegSearch    := CurIm; {Beg of Actual Searching File}
          EndSearch    := CurIm;   {Beg of Actual Searching File}
          ToEnd        := CurIm;
        End;


        {------------------------------------------------}
        NrOfCol   := (round(NrIm/1000))*1000;
        if (NrOfCol < 1000) then NrOfCol := 1000;
        {Length is Always the Same independant of SparkTest On or Off}
        SetLength(EVcoorX, ToEnd-Beg+1 + 1,NrOfCol); { For NrOfCol Events (all)per File}
        SetLength(EVcoorY, ToEnd-Beg+1 + 1,NrOfCol); { For NrOfCol Events (all)per File}
        {this additional row is used to mark Columns that should not be used:
        e.g. sparks before a Wave, etc.}
        SetLength(EVpeaks,ToEnd-Beg+1,NrOfCol);     { For NrOfCol Events (all) per File}

          {Zeroes Buffers}
          {This is Not needed Since SetLenth Should Zeroe all the values but I do it Anyway}
        for CntX := 0 to High(EVcoorX) do begin
          for CntY := 0 to High(EVcoorX[0]) do begin
             EVcoorX[CntX,CntY] := 0;
             EVcoorY[CntX,CntY] := 0;
          end;
        end;

        for CntX := 0 to High(EVpeaks) do begin
          for CntY := 0 to High(EVpeaks[0]) do begin
             EVpeaks[CntX,CntY] := 0;
             EVpeaks[CntX,CntY] := 0;
          end;
        end;
        {-----------------------------------------------}

        {--------------------------------------------------------------}
        If (AutoSearchPar.UseRunAver) then SetLength(RunAvRaw,ImagePix);  {Raw running Average}

          {----------Sets Parameters for the Running Average ----------------}
        If AutoSearchPar.UseRunAver = True Then Begin
          HalfNrImAv := AutoSearchPar.NrImRunAver div 2;
          SetLength(RunAv   ,ImagePix); {Smoothed Runnig Average}
          SetLength(RunAvRat,ImagePix); {ratioed Running Average}
          SetLength(ImList,AutoSearchPar.NrImRunAver); {list of images to Aver for Running Average}
          SetLength(SmapRAV,  imXsize,imYsize);
        End;

        SetProgressBar(Beg,ToEnd,Beg);
        ProgrBarAutoSearch.Visible := True;
        lblMessage.Caption := 'Searching';
        frmSPautoSearch.StartSearch.Enabled := False;
        frmSPautoSearch.BorderIcons := frmSPautoSearch.BorderIcons - [biSystemMenu];
        Application.ProcessMessages; {Updates Form}
        AnalInAction := True;   {Disables  Function DoMeanROI to Multply By Disply Factor}

        CopyBorder   := True;

        LastEVCol := 0;   {First Wave or Spark in Image 1 goes to Col # 0}

        SPcnt     := 0;  {Sparks in Current Image}
        SPcntPr   := 0;  {Sparks in Previous Image}

        WAVcnt    := 0;  {Waves in Current Image}
        WAVcntPr  := 0;  {Waves in Previous Image}

        SetLength(RatIm, ImagePix);
        if Not(AutoSearchPar.SmoothBeforeDoRatio) then SetLength(RatImForSmooth, ImagePix);

        SetLength(Smap,  imXsize,imYsize);
        SetLength(SmapPr,imXsize,imYsize);

        ScanBS  := AutoSearchPar.ScanBoxSize;
        ScanBL  := ScanBS - 1;
        ScanBel := ScanBS*ScanBS;

        Thresh := AutoSearchPar.Thresh/100;
        PercPixAboveThresh := AutoSearchPar.Tolerance/100;  {gives Part of a whole}
        {sets the limits}
        PixAbTr := round((ScanBS*ScanBS)*PercPixAboveThresh);
        SPsiteMaxSize := AutoSearchPar.MaxArea;


        if (BoxSmSize >= MedSmSize)     then ScanXBorder := BoxSmSize div 2 else
        if (BoxSmSize <  MedSmSize)     then ScanXBorder := MedSmSize div 2;
        if (ScanXBorder < ScanBS div 2) then ScanXBorder := ScanBS div 2;

        Xbeg := ScanXBorder;
        Ytop := ScanXBorder;
        Xend := imXsize - ScanBS - ScanXBorder;
        Ybot := imYsize - ScanBS - ScanXBorder; {limits of Area to be analyzed}

       If (frmImageControl.ubApplyFrame.Selected) Then Begin

         if (Xbeg < SelFrame.Left)   then Xbeg := SelFrame.Left;
         if (Xend > SelFrame.Right)  then Xend := SelFrame.Right;
         if (Ytop < SelFrame.Top)    then Ytop := SelFrame.Top;
         if (Ybot > SelFrame.Bottom) then Ybot := SelFrame.Bottom;
       End;

        StopSearch := False;
        LSD := 1;
        RSD := 1;

      If (AutoSearchPar.TestSmallEv) Then Begin
        BackUpFileName := ExtractFilePath(ImFname) + 'TempBackUpFile';
        BackUpFile     := FileCreate(BackUpFileName);
      End;


FOR    CntIm := Beg to ToEnd Do Begin  {Goes through File Images}
        {----------------------------}


        Application.ProcessMessages;
        If (StopSearch = True) Then Begin
          ToEnd := CntIm - 1;
          MainForm.PwrSaveSparkAn.AllowSuspend    := True;
          MainForm.PwrSaveSparkAn.AllowStandby    := True;
          MainForm.PwrSaveSparkAn.AllowEndSession := True;
          Break;
        End;
{---------------- Increases the Buffers if Needed ---------------------------------}
if LastEVCol > NrOfCol - 100 then Begin
  LocY := NrOfCol;  {memorizes Old Nr of Columns}
  NrOfCol   := NrOfCol + 1000; {Number of Columns}
  SetLength(EVcoorX, ToEnd-Beg+1 + 1,NrOfCol); { NrOfCol = Events (all) per File}
  SetLength(EVcoorY, ToEnd-Beg+1 + 1,NrOfCol); { NrOfCol = Events (all) per File}
  SetLength(EVpeaks,ToEnd-Beg+1,NrOfCol); { NrOfCol = Events  per File}

        
     {Zeroes Buffers}
  {This is Not needed Since SetLenth Should Zeroes All the Values but I do it Anyway}
        for CntX := 0 to High(EVcoorX) do begin
          for CntY := LocY to High(EVcoorX[0]) do begin
             EVcoorX[CntX,CntY] := 0;
             EVcoorY[CntX,CntY] := 0;
          end;
        end;

        for CntX := 0 to High(EVpeaks) do begin
          for CntY := LocY to High(EVpeaks[0]) do begin
             EVpeaks[CntX,CntY] := 0;
             EVpeaks[CntX,CntY] := 0;
          end;
        end;


End;  {if LastEVCol > NrOfCol - 100 then Begin}

{------- Creates Auto Average Image if Set so ------}

  If (AutoSearchPar.AutoAverImage) then Begin
    if ((CntIm+AutoSearchPar.AutoAverImRange <= NrIm-1) and ((CntIm - Beg + 1) mod AutoSearchPar.AutoAverNrImInc = 0))
       or ((AutoSearchPar.StartAutoAverFirstIm) and (CntIm = Beg))
    then Begin

       CreateAverageImageUsingMinimum(Sender,CntIm,CntIm+AutoSearchPar.AutoAverImRange-1,0);

       //save Average Im file
      if (AutoSearchPar.SaveAutoAver) then begin
       AutoAverFileName := Copy(ImFname,1, Length(ImFname) - Length(ExtractFileExt(ImFname)));
       AutoAverFileName := AutoAverFileName + '_' + IntToStr(CntIm+1) + '_' + IntToStr(CntIm+AutoSearchPar.AutoAverImRange) + '.ave';
       SaveAverImageAsSpnOwnFile(AutoAverFileName);
      end;

       SetProgressBar(Beg,ToEnd,CntIm);
       ProgrBarAutoSearch.Visible := True;
       lblMessage.Caption := 'Searching';
    End;

    If not(RatioOn) and (AutoSearchPar.AutoAverImage) and (AutoSearchPar.StartAutoAverFirstIm)
    Then with frmImageControl do Begin
      ubRatioOn.Selected  := True;
      ubRatioOn.OnClick(Sender);
    End;
  End; //If (AutoSearchPar.AutoAverImage) then Begin


{--------- STARTS SCAN OF ONE IMAGE ------------}
        {1st: Reads File & Smoothing & Ratio F/Fo}

  ReadImage(CntIm,0,pImData);
  If (AutoSearchPar.SmoothBeforeDoRatio) then Begin
    ApplySmoothing; {used to apply any Smoothing on Main Image}
        //------- 2nd: does  Ratio ------------//
    For Cnt := 0 to High(Im16bitDataSM_Last) do Begin
      If AvIm[Cnt] > 0 then Begin
        RatIm[Cnt] :=  (Im16bitDataSM_Last[Cnt]-Bkg)/AvIm[Cnt];
        if RatIm[Cnt] < 0 then RatIm[Cnt] := 0; {if Bkg too Big}
      End Else
        RatIm[Cnt] := 0;
    End
  End
      Else
  If Not(AutoSearchPar.SmoothBeforeDoRatio) then Begin
    If (BitCount = 16) then  Begin
      For Cnt := 0 to High(Im16bitData) do Begin
        If AvIm[Cnt] > 0 then Begin
          RatIm[Cnt] :=  (Im16bitData[Cnt]-Bkg)/AvIm[Cnt];
          if (RatIm[Cnt] < 0) then RatIm[Cnt] := 0; {if Bkg too Big}
        End Else
          RatIm[Cnt] := 0;
      End;
    End
      Else
    If (BitCount = 8) then  Begin
      For Cnt := 0 to High(Im8bitData) do Begin
        If AvIm[Cnt] > 0 then Begin
          RatIm[Cnt] :=  (Im8bitData[Cnt]-Bkg)/AvIm[Cnt];
          if (RatIm[Cnt] < 0) then RatIm[Cnt] := 0; {if Bkg too Big}
        End Else
          RatIm[Cnt] := 0;
       End;
    End;

    {because of double filtering  RatImForSmooth (InRatio) is used as intermediate buffer
     So RatIm should contain the Raw data: RatIm -> RatImForSmooth -> RatIm}
    SmoothRatioImage(RatImForSmooth,RatIm);

  End;


{------------------ End of Ratio ---------------------------------------}

If (AutoSearchPar.TestSmallEv) Then Begin

  if not(AutoSearchPar.UpdateRatio) then begin
    FPos := (CntIm-Beg)*ImagePix*4;  //records Singles (4 bytes)
    FileSeek(BackUpFile,FPos,0);  {0 = Origin = Begining of File}
    pRatIm := @RatIm[0]; //Records Ratio to File
    FileWrite(BackUpFile,pRatIm^,ImagePix*4);  //One Singles = 4 bytes
  end else
  if  (AutoSearchPar.UpdateRatio) then begin //records Words (2 bytes)
    if (AutoSearchPar.SmoothBeforeDoRatio = False) then ApplySmoothing; //does it because smoothing comes after F/Fo was created
    {So, Update Ratio is Always Done with Smoothed Before Ratio Image}
    FPos := (CntIm-Beg)*ImagePix*2;
    FileSeek(BackUpFile,FPos,0);  {0 = Origin = Begining of File}
    pRatIm := @im16bitDataSM_Last[0]; //Records Smoothed Non ratio
    FileWrite(BackUpFile,pRatIm^,ImagePix*2);
  end;

End;
{-----------------------------------------------------------------------------}
IF (CntIm >= BegSearch) and (CntIm <= EndSearch) THEN BEGIN

     {Part B: running average}
      If (AutoSearchPar.UseRunAver = True) Then Begin
    {---- Sets ImList (local Variable)  ----}
        If (CntIm > HalfNrImAv) and (CntIm <= NrIm - HalfNrImAv - 1) Then Begin
          for Cnt := 0 to AutoSearchPar.NrImRunAver - 1 do ImList[Cnt] := Cnt + CntIm - HalfNrImAv;
        End Else
        If (CntIm > NrIm - HalfNrImAv - 1) Then Begin  {end of File}
          for Cnt := 0 to AutoSearchPar.NrImRunAver - 1 do ImList[Cnt] := Cnt + NrIm - AutoSearchPar.NrImRunAver;
        End Else
          If (CntIm < HalfNrImAv) Then Begin  {Beg of File}
          for Cnt := 0 to AutoSearchPar.NrImRunAver - 1 do  ImList[Cnt] := Cnt;
        End;

        MakeRunAv(RunAvRaw,ImList, AutoSearchPar.NrImRunAver);
        SmoothAverIm(RunAvRaw,RunAv);
          {Does Ratio For Running Average}
        For Cnt := 0 to ImagePix - 1 do Begin
            If AvIm[Cnt] > 0 Then Begin
              RunAvRat[Cnt] :=  (RunAv[Cnt]-Bkg)/AvIm[Cnt];
              If RunAvRat[Cnt] < 0 then RunAvRat[Cnt] := 0;
            End
            Else RunAvRat[Cnt] := 0;
        End;


      End; { If UseRunAver = True Then Begin}
       {-------- End 2nd -----------------------}

        {--- 3rd: zeroes out Smap buffer}
        {Part A: regular image}
        For CntY := 0 to imYsize - 1 Do Begin
          For CntX := 0 to imXsize - 1 Do Begin
            Smap[CntX,CntY] := 0;
          End;
        End;
        {Part B: running average}
        If AutoSearchPar.UseRunAver = True Then Begin
          For CntY := 0 to imYsize - 1 Do Begin
            For CntX := 0 to imXsize - 1 Do Begin
              SmapRAV[CntX,CntY] := 0;
            End;
          End;
        End; {If AutoSearchPar.UseRunAver = True}

     {------ end 3rd--------------------}


     {--- 4rd: Starts Image line scan }

     {PartA: Regular Image}

        FirstX      := imXsize - 1;
        LastX       := 0;
        FirstRow    := imYsize - 1; {Which row the First "HOT" pixels is}
        SiteCnt     := 0;
  
For CntY := Ytop to Ybot Do Begin
  For CntX := Xbeg to Xend Do Begin

       {Calculates Mean of ScanBox}
        ScBoxMean := 0;
     For CntYbox := 0 to ScanBL Do Begin
      For CntXbox := 0 to ScanBL Do Begin
        ScBoxMean := ScBoxMean + RatIm[CntX+CntXbox + (CntY+CntYbox)*imXsize];
      End;
     End;
        ScBoxMean := ScBoxMean/ScanBel;

     {-------if above Thresh finds % of Pix above thresh -------------------}
     If ScBoxMean > Thresh Then Begin
          TempPixAbTr := 0;
        For CntYbox := 0 to ScanBL Do Begin
          For CntXbox := 0 to ScanBL Do Begin
            if (RatIm[CntX+CntXbox + (CntY+CntYbox)*imXsize] > Thresh) then Inc(TempPixAbTr);
          End;
        End;
             {------- Fills in -------------------}
        If TempPixAbTr >= PixAbTr Then Begin
              if FirstRow > CntY then FirstRow := CntY; {The 1st "HOT" pixel Y in image}
              if FirstX   > CntX then FirstX   := CntX;
              if LastX    < CntX then LastX    := CntX;
              SiteVal := 0;
            For CntXbox := -1 to ScanBS Do Begin
              If Smap[CntX+CntXbox,CntY-1] > 0 then Begin
              SiteVal := Smap[CntX+CntXbox,CntY-1];
              Break;
              End;
            End; {For CntXbox := -1 to ScanBS}

            If SiteVal = 0 then Begin
              For CntYbox := -1 to ScanBS Do Begin
                If Smap[CntX-1,CntY+CntYbox] > 0 then Begin
                  SiteVal := Smap[CntX-1,CntY+CntYbox];
                  Break;
                End;
              End; {For CntYbox := -1 to ScanBS}
            End; {f SiteVal = 0 then Begin}

            If SiteVal = 0 then Begin
              For CntYbox := -1 to ScanBS Do Begin
                If Smap[CntX+ScanBS,CntY+CntYbox] > 0 then Begin
                  SiteVal := Smap[CntX+ScanBS,CntY+CntYbox];
                  Break;
                End;
              End; {For CntYbox := -1 to ScanBS Do Begin}
            End; {If SiteVal = 0 then Begin}

            if SiteVal = 0 Then Begin
              Inc(SiteCnt);
              SiteVal := SiteCnt;
            End;

            For CntYbox := 0 to ScanBL Do Begin
              For CntXbox := 0 to ScanBL Do Begin
                 Smap[CntX+CntXbox,CntY+CntYbox] := SiteVal;
              End; {For CntXbox := 0 to ScanBL}
            End; {For CntYbox := 0 to ScanBL Do Begin}

        End; {If TempPixAbTr >= PixAbTr}
             {------------}
     End;  {If ScBoxMean >= Thresh}
    {-------------------------------------}
  End; {For CntX := Xbeg to Xend Do Begin}
End; {For CntY := Ytop to Ybot Do Begin}
{------- End of PartA ----------------}



{Beg of PartB: Running Average--}
If (AutoSearchPar.UseRunAver) Then Begin

        FirstRavX   := imXsize - 1;
        LastRavX    := 0;
        FirstRowRAV := imYsize - 1;
        SiteCntRAV  := SiteCnt; {Starts Counting From the last of SiteCnt+1}

For CntY := Ytop to Ybot Do Begin
  For CntX := Xbeg to Xend Do Begin

     {Calculates Mean of ScanBox}
        ScBoxMean := 0;
     For CntYbox := 0 to ScanBL Do Begin
      For CntXbox := 0 to ScanBL Do Begin
        ScBoxMean := ScBoxMean + RunAvRat[CntX+CntXbox + (CntY+CntYbox)*imXsize];
      End;
     End;
        ScBoxMean := ScBoxMean/ScanBel;
     {-------if above Thresh finds % of Pix above thresh -------------------}
     If ScBoxMean > Thresh Then Begin
          TempPixAbTr := 0;
        For CntYbox := 0 to ScanBL Do Begin
          For CntXbox := 0 to ScanBL Do Begin
            if RunAvRat[CntX+CntXbox + (CntY+CntYbox)*imXsize] > Thresh then Inc(TempPixAbTr);
          End;
        End;
             {------- Fills in -------------------}
        If TempPixAbTr >= PixAbTr Then Begin
              if FirstRowRAV > CntY then FirstRowRAV := CntY; {The 1st "HOT" pixel Y in image}
              if FirstRavX   > CntX then FirstRavX   := CntX;
              if LastRavX    < CntX then LastRavX    := CntX;
              SiteVal := 0;
            For CntXbox := -1 to ScanBS Do Begin
              If SmapRAV[CntX+CntXbox,CntY-1] > 0 then Begin
              SiteVal := SmapRAV[CntX+CntXbox,CntY-1];
              Break;
              End;
            End; {For CntXbox := -1 to ScanBS}

            If SiteVal = 0 then Begin
              For CntYbox := -1 to ScanBS Do Begin
                If SmapRAV[CntX-1,CntY+CntYbox] > 0 then Begin
                  SiteVal := SmapRAV[CntX-1,CntY+CntYbox];
                  Break;
                End;
              End; {For CntYbox := -1 to ScanBS}
            End; {f SiteVal = 0 then Begin}

            If SiteVal = 0 then Begin
              For CntYbox := -1 to ScanBS Do Begin
                If SmapRAV[CntX+ScanBS,CntY+CntYbox] > 0 then Begin
                  SiteVal := SmapRAV[CntX+ScanBS,CntY+CntYbox];
                  Break;
                End;
              End; {For CntYbox := -1 to ScanBS Do Begin}
            End; {If SiteVal = 0 then Begin}

            if SiteVal = 0 Then Begin
              Inc(SiteCntRAV);
              SiteVal := SiteCntRAV;
            End;

            For CntYbox := 0 to ScanBL Do Begin
              For CntXbox := 0 to ScanBL Do Begin
                 SmapRAV[CntX+CntXbox,CntY+CntYbox] := SiteVal;
              End; {For CntXbox := 0 to ScanBL}
            End; {For CntYbox := 0 to ScanBL Do Begin}

        End; {If TempPixAbTr >= PixAbTr}
             {------------}
     End;  {If ScBoxMean >= Thresh}
    {-------------------------------------}
  End; {For CntX := Xbeg to Xend Do Begin}
End; {For CntY := Ytop to Ybot Do Begin}

{-------END of - 4th: (Image line scan) -------------}
{----- Beg of 4.1 th: Mixes Regular and Running Average Smap's ----------}
    //Xbeg TEST Starts from here
  If (SiteCntRAV > SiteCnt) Then Begin
     {First Renumbers Waves Sites if they Overlap with Spark Sites}
        CountY := FirstRowRAV;
        CountX := Xbeg;
    While CountY < Ybot + ScanBL Do Begin
      While CountX < Xend + ScanBL Do begin
        If (SmapRAV[CountX,CountY] > 0) and (Smap[CountX,CountY] > 0) Then Begin
          If (SmapRAV[CountX,CountY] <> Smap[CountX,CountY]) Then Begin
              SourceSiteNr := Smap   [CountX,CountY];
              TargetSiteNr := SmapRAV[CountX,CountY];
            For LocY := Ybot + ScanBS downto FirstRow Do Begin
              For LocX := FirstX to LastX  Do begin
                if SmapRAV[LocX,LocY] =  TargetSiteNr then
                   SmapRAV[LocX,LocY] := SourceSiteNr;
              End; {For}
            End;   {For}
          End; {If (SmapRAV[CountX,CountY] <> Smap[CountX,CountY])}
        End; {If (SmapRAV[CountX,CountY] > 0) and (Smap[CountX,CountY] > 0)}
       Inc(CountX);
      End; {While CountX}
       Inc(CountY);
    End;  {While CountY}
          {End of  Renumbers Waves Sites if they Overlap with Spark Sites}
          
          {Now Adds the Sites found on Running Average Sites to the  One Image Sites
           This helps to
           1. Better capture propagating events such as Ca Waves
           2. Unify (Reconsile) faster events such as Ca sparks and Pulsars if there is
             dropoff below Threshold in some of the images.  In this way it prevents
             the Same Event to be registered Twice.
           3 Always Select appropriate numbe of images if it is
             too high the resultant Running average image might be below threshold and thereby unuseful}

    For LocY := FirstRowRAV to Ybot + ScanBL Do Begin
      For LocX := Xbeg to Xend + ScanBL Do begin
        if (SmapRAV[LocX,LocY] > 0) and (Smap[LocX,LocY] = 0) then
            Smap[LocX,LocY] := SmapRAV[LocX,LocY];
      End;
    End;
    SiteCnt := SiteCntRAV;

    if FirstX   > FirstRavX   then FirstX   := FirstRavX;
    if LastX    < LastRavX    then LastX    := LastRavX;
    if FirstRow > FirstRowRAV then FirstRow := FirstRowRAV;

End; {If (SiteCntRAV > SiteCnt) Then Begin}
End; { If UseRunAver = True Then Begin}
  {------ End of 4.1: mixing -------}

{******************** From Here Requirement is To HAVE  SiteCnt > 0 !!!! *********}
 {---5th:  Re- Establishing Spark Sites Looks for Contiguous Pixels and Joins Sparks Sites--}
                        {Scans From Bottom To Top}

If (SiteCnt > 0) THEN BEGIN
                                
      LastX := LastX + ScanBL;   
      If (LastX > imXsize - ScanXBorder - 1) then LastX := imXsize - ScanXBorder - 1;

      LastRow := 0; {Y pos of The Bottom Right "HOT" pixel}
  For CountY := Ybot + ScanBS downto FirstRow Do Begin
           CountX := FirstX;
    While (CountX < LastX) Do Begin
       {------ If pixel above 0 was found }
      If (Smap[CountX,CountY] > 0)then Begin
            if LastRow < CountY then LastRow := CountY;
         If (Smap[CountX+1,CountY] > 0) Then Begin
          {-----------------}
            If (Smap[CountX,CountY] <> Smap[CountX+1,CountY]) Then Begin
              SourceSiteNr := Smap[CountX,CountY];
              TargetSiteNr := Smap[CountX+1,CountY];
              For LocY := Ybot + ScanBS downto FirstRow Do Begin
                For LocX := FirstX to LastX  Do begin
                  if Smap[LocX,LocY] =  TargetSiteNr then
                     Smap[LocX,LocY] := SourceSiteNr;
                End; {Fpr}
              End;  {For}
            End; {If (Smap[CountX,CountY] <> Smap[CountX+1,CountY])}
          {-----------------}
         End; {(Smap[CountX+1,CountY] > 0)}
      End; {(Smap[CountX,CountY] > 0)}
          Inc(CountX);
    End;  {While (CountX < LastX)}
  End; {For CountY := Ybot downto Ytop}

 {----- End of 5th -----------}

{--  6th: a)Counts Spark Sites (and eventually Re-numbers them
       (in case Some of Them were joined in previous paragraph in this case
        SiteCnt will be Reduced -- b) conts Rows (Ys) and c) Pixels for Each Site}
 
      SetLength(SiteRowCnt,SiteCnt);
      SetLength(SitePixCnt,SiteCnt);
      for Cnt := 0 to SiteCnt - 1 do begin
        SiteRowCnt[Cnt] := 0; {Zeroes}
        SitePixCnt[Cnt] := 0; {Zeroes}
      end;

      {Goes through Whole Smap for Each SPsite}
       
        SiteCntMem := SiteCnt;
        DuplFound  := False;
        SiteCnt := 0;  
        
  For CountY :=  FirstRow to LastRow Do Begin
    For CountX := FirstX to LastX Do Begin
          {---------------------}
      If (Smap[CountX,CountY] > 0) then Begin
       
        If (Smap[CountX,CountY]  > SiteCnt) {or (SiteCnt = 0)} then Begin
                Inc(SiteCnt);
                Ytrack                := 0;
                SitePixCnt[SiteCnt-1] := 0;
                TargetSiteNr          := Smap[CountX,CountY];
                DuplFound             := False;
                {For one Site}
              For LocY := FirstRow to LastRow Do Begin
                For LocX := FirstX to LastX  Do begin
                  if (Smap[LocX,LocY] = SiteCnt) and (SiteCnt <> TargetSiteNr) then Begin
                     if DuplFound = False then Inc(SiteCntMem);
                     DuplFound := True;
                     Smap[LocX,LocY] := SiteCntMem + 1;
                  end else
                  if Smap[LocX,LocY] =  TargetSiteNr then begin
                     {--- Updates Ytrack and Increments SiteRowCnt}
                     if Ytrack = 0 then begin
                        Ytrack := LocY;
                        SiteRowCnt[SiteCnt-1] := 1;
                     end else
                     if Ytrack > 0 then begin
                        if Ytrack < LocY then begin
                           Ytrack := LocY;
                           Inc(SiteRowCnt[SiteCnt-1]);  {later used to set Length of Each Site}
                        end;
                     end;
                      {----------------------------}
                     Smap[LocX,LocY] := SiteCnt;
                     Inc(SitePixCnt[SiteCnt-1]);
                  end; {if SmapT[LocX,LocY] =  TargetSiteNr}

                End; {For LocX := Xbeg to Xend  }
              End; {For LocY := FirstRow to LastRow }
              {------ One Site ----------}
        End; {If (SmapT[CountX,CountY] > SiteCnt)}
      End; {(SmapT[CountX,CountY] > 0)}
       {-----------------}
    End;  {CountX := Xbeg to Xend}
  End; {CountY := FirstRow to LastRow}
       { Frees Memory in case SiteCnt has decreased (some Sites were Joined)}
       SetLength(SiteRowCnt,SiteCnt);
       SetLength(SitePixCnt,SiteCnt);
{----- End of 6th -----------------------}


{--------- 7th: Creates a Table with Row and Xbeg & Xend for Each row --------------}

    {SiteTable[Site Number; Number of Y,X1,X2 arrays;  [0] = Y, [1..2] = Xbeg .. Xend of Site] }

    SetLength(SiteTable,SiteCnt); {sets the number of sites only}
    {Sets Length for Each Site}
    for Cnt := 0 to SiteCnt - 1 do SetLength(SiteTable[Cnt],SiteRowCnt[Cnt]);
    {here  SiteRowCnt is used to Track Rows of each Site}
    for Cnt := 0 to SiteCnt - 1 do SiteRowCnt[Cnt] := -1;

For CountY := FirstRow to LastRow Do Begin
  For CountX := FirstX to LastX Do Begin
          {--------------------}
    If (Smap[CountX,CountY] > 0) then Begin
          {in this case SmapT[CountX,CountY] Gives Site Number}

      if SiteRowCnt[Smap[CountX,CountY]-1] = -1 then begin
        SiteTable[Smap[CountX,CountY]-1,0,0] := CountY;
        SiteTable[Smap[CountX,CountY]-1,0,1] := CountX;
        SiteRowCnt [Smap[CountX,CountY]-1]   := 0;
      end else
      if SiteRowCnt[Smap[CountX,CountY]-1] >= 0 Then Begin

        if SiteTable[Smap[CountX,CountY]-1,SiteRowCnt[Smap[CountX,CountY]-1],0] < CountY
        then begin
          Inc(SiteRowCnt[Smap[CountX,CountY]-1]);
          SiteTable[Smap[CountX,CountY]-1,SiteRowCnt[Smap[CountX,CountY]-1],0] := CountY;
          SiteTable[Smap[CountX,CountY]-1,SiteRowCnt[Smap[CountX,CountY]-1],1] := CountX;
        end else
          SiteTable[Smap[CountX,CountY]-1,SiteRowCnt[Smap[CountX,CountY]-1],2] := CountX;
           {if Xbeg not put in table, else update Xend for the row}

      end; {if SiteRowCnt[SmapT[CountX,CountY]-1] >= 0}
    End; {If (SmapT[CountX,CountY] > 0)}
         {--------------------}
  End; {For CountX := Xbeg to Xend}
End; {For CountY := FirstRow to LastRow}
    {------ End of 7th -----------------}

{------- 8th:  Finds Maximum For Each Site Using the SiteTable -----}

      SetLength(PeakXY,SiteCnt);
      SetLength(Peak,  SiteCnt);


For Cnt := 0 to SiteCnt - 1 Do Begin
         Peak[Cnt] := 0;

  If SitePixCnt[Cnt] >= ScanBel then Begin
  {sometimes some pixels are not Joined: this produces errors = Peak = 0, X,Y = 0}
       {-- Actual Finding the Peak -- }

  For CntRow := 0 to High(SiteTable[Cnt]) - ScanBL Do Begin
    For CountX := SiteTable[Cnt,CntRow,1] to (SiteTable[Cnt,CntRow,2] - ScanBL) Do Begin

      {----- Calculates Mean---------}
        ScBoxMean := 0;
     For CntYbox := 0 to ScanBL Do Begin
      For CntXbox := 0 to ScanBL Do Begin
        ScBoxMean := ScBoxMean + RatIm[CountX+CntXbox+(SiteTable[Cnt,CntRow,0]+CntYbox)*imXsize];
      End;
     End;
          ScBoxMean := ScBoxMean;
     if Peak[Cnt] < ScBoxMean then begin
        Peak[Cnt]     := ScBoxMean;
        PeakXY[Cnt].X := CountX + (ScanBL div 2);
        PeakXY[Cnt].Y := SiteTable[Cnt,CntRow,0] + (ScanBL div 2);
     end;

    End; { For CountX := SiteTable[Cnt-1,RowCnt,1] to SiteTable[Cnt-1,RowCnt,2]}
  End; {For RowCnt := 0 to High(SiteTable[Cnt-1])}
        Peak[Cnt] := Peak[Cnt]/ScanBel;
 End; { If SitePixCnt[Cnt] >= ScanBel}
End; {For Cnt := 1 to SiteCnt}
{---------End of 8th  -----------------------------------}
{-----------9th: Makes Spark Sites  Negative to be Distinguished from Waves Sites ----}
            SPcnt  := 0;
            WAVcnt := 0;

For Cnt := 0 to SiteCnt - 1 Do Begin
  If SitePixCnt[Cnt] <= SPsiteMaxSize Then Begin  {Makes Pix in Smap for Spark Negative}
         Inc(SPcnt);
    For CntY := 0 to High(SiteTable[Cnt]) Do Begin
       For CountX := SiteTable[Cnt,CntY,1] to (SiteTable[Cnt,CntY,2]) Do Begin
        if SitePixCnt[Cnt] >= ScanBel then
         Smap[CountX, SiteTable[Cnt,CntY,0]] := -Smap[CountX, SiteTable[Cnt, CntY,0]] else
        if SitePixCnt[Cnt] < ScanBel then
         Smap[CountX, SiteTable[Cnt,CntY,0]] := 0; {sometimes some pixels are not Joined}
       End; {For CountX := SiteTable[Cnt-1,CntY,1] ...........}
    End; {For CntRow := 0 to High(SiteTable[Cnt-1])}
  End Else; {If SitePixCnt[Cnt-1] <= SPsiteMaxSize}
  If SitePixCnt[Cnt] > SPsiteMaxSize Then Begin
         Inc(WAVcnt);
  End;
End; {For Cnt := 1 to SiteCnt}

{Beg of Print Pixel Size in One Image if you Click on PixSize Icon, August 21, 2013}

 If (sender = ShapeEvMaxSize) Then Begin

  if  (frm2ndWin = nil) then begin
    Application.CreateForm(Tfrm2ndWin, frm2ndWin);
    Application.ProcessMessages;
  end
    else
  with frm2ndWin.win2ndImage do begin
    Canvas.Brush.Color := clBlack;
    Canvas.FillRect(Canvas.ClipRect);
    Canvas.Brush.Style := bsClear;
  end;

 For CntY := 0 to imYsize - 1 Do Begin
  For CntX := 0 to imXsize - 1 Do Begin
    if Smap[CntX,CntY] > 0 then
    frm2ndWin.win2ndImage.Canvas.Pixels[CntX,CntY] := clBlue
      else
    if Smap[CntX,CntY] < 0 then
    frm2ndWin.win2ndImage.Canvas.Pixels[CntX,CntY] := clRed;
  End;
 End;

 if (Bt = mbLeft) then PrintPixSize;

 Break;  // Stops the Program of Doing Anything Animore

End; //If (sender = ShapeEvMaxSize)  then Begin

{End of Print Pixel Size in One Image if you Click on PixSize Icon, August 21, 2013}
 
{--------10th: Puts Sparks togheter with others if they overlap in SPcoor and SPpeaks}

        SetLength(IndTab,SiteCnt); {IndTab (Index Table) contains both Sparks and waves}
        for Cnt := 0 to SiteCnt - 1 do IndTab[Cnt] := 0;

        Cnt := 1;

 IF not(cbIgnoreBigEv.Checked) THEN BEGIN
   {option that separates Sparks from Waves}
  While Cnt <= SiteCnt Do Begin
  {------------- --------------------------------------------------}
 If (SitePixCnt[Cnt-1] <= SPsiteMaxSize) and (SitePixCnt[Cnt-1] >= ScanBel) Then Begin {For Sparks}
         PrevEventFound := 0;
             {Case #1; Spark on a Previous Spark Site}
      If (SPcntPr > 0) or (WAVcntPr > 0) Then Begin {There Were Sparks or waves & on the Same Spot}
       PrevEventFound := SmapPr[PeakXY[Cnt-1].X, PeakXY[Cnt-1].Y];
      End; { Do not Use Else Here}

      If (PrevEventFound <> 0) Then Begin
          {Case #1; Spark on a Previous Spark Site}
        If (PrevEventFound < 0) Then Begin
          EVcoorX [CntIm-Beg,IndTabPr[abs(PrevEventFound)-1]] := PeakXY[Cnt-1].X;
          EVcoorY [CntIm-Beg,IndTabPr[abs(PrevEventFound)-1]] := PeakXY[Cnt-1].Y;
          EVpeaks [CntIm-Beg,IndTabPr[abs(PrevEventFound)-1]] := Peak  [Cnt-1];
          IndTab[Cnt-1] := IndTabPr[abs(PrevEventFound)-1];
        End Else
        If (PrevEventFound > 0) Then Begin
            {Case #2; Spark on a Previous WAVE Site}
          {Makes the Spark Positive on Smap-i.e. it is Assumed to be wave or Trail of Wave}
          For CntY := 0 to High(SiteTable[Cnt-1]) Do Begin
            For CountX := SiteTable[Cnt-1,CntY,1] to (SiteTable[Cnt-1,CntY,2]) Do Begin
             Smap[CountX, SiteTable[Cnt-1,CntY,0]] := abs(Smap[CountX, SiteTable[Cnt-1, CntY,0]]);
            End; {For CountX := SiteTable[Cnt-1,CntY,1] ...........}
          End; {For CntRow := 0 to High(SiteTable[Cnt-1])}
               {Now Assigns Ampl and Coordinates}
              EVcoorX [CntIm-Beg,IndTabPr[PrevEventFound-1]] := PeakXY[Cnt-1].X;
              EVcoorY [CntIm-Beg,IndTabPr[PrevEventFound-1]] := PeakXY[Cnt-1].Y;
              EVpeaks[CntIm-Beg,IndTabPr[PrevEventFound-1]] := Peak  [Cnt-1];
              IndTab[Cnt-1] := IndTabPr[abs(PrevEventFound)-1];
              {Finally Corrects Numbers of Sparks & Waves}
               Dec(SPcnt);  Inc(WAVcnt);
            {No NEED!!!!!!!   EVcoor[High(EVcoor),IndTabPr[abs(PrevEventFound)-1]].X :=  1;}
        End;  {(PrevEventFound > 0) }
      End else {If (PrevEventFound <> 0)}
         {Case #3; Spark on a Empty Spot}
      If (PrevEventFound = 0) Then Begin {Empty Spot}
        EVcoorX [CntIm-Beg, LastEVCol] := PeakXY[Cnt-1].X;
        EVcoorY [CntIm-Beg, LastEVCol] := PeakXY[Cnt-1].Y;
        EVpeaks[CntIm-Beg, LastEVCol] := Peak  [Cnt-1];
        EVcoorX[High(EVcoorX),LastEVCol] := 1; {1 Means this is a Spark; 2 = Big Event}
        IndTab [Cnt-1] := LastEVCol;   {under each Site Number (Cnt-1) the Value = Column}
        Inc(LastEVCol);
      End; {PrevEventFound = 0}
      {------------------ End with Sparks ---------------}
 End Else { End of: If SitePixCnt[Cnt-1] <= SPsiteMaxSize }

      {Now For Waves}
 If SitePixCnt[Cnt-1] > SPsiteMaxSize Then Begin
        PrevEventFound := 0;

      If (SPcntPr > 0) or (WAVcntPr > 0) Then Begin {There Were Sparks or waves & on the Same Spot}
        NewEvFound     := False;
        BiggestAmpl    := 0;
        BiggestIndex   := 0;
          {Scans for all pixels}
  For CntY := 0 to High(SiteTable[Cnt-1]) Do Begin
    For CountX := SiteTable[Cnt-1,CntY,1] to (SiteTable[Cnt-1,CntY,2]) Do Begin
          {Compares Events in previous image if there are more then 1 wave or spark,
          kills the rest and leave the biggest wave or spark and converts spark to wave}
      If SmapPr[CountX, SiteTable[Cnt-1,CntY,0]] <> 0 then begin
        If (PrevEventFound = 0) or
           (PrevEventFound <> SmapPr[CountX, SiteTable[Cnt-1,CntY,0]]) then Begin
          PrevEventFound := SmapPr[CountX, SiteTable[Cnt-1,CntY,0]];
          NewEvFound     := True;
        end; { if (PrevEventFound = 0) or (PrevEventFound <> SmapPr[CountX, SiteTable[Cnt-1,CntY,0]])}
              {if something was found decides what to do}
        If (NewEvFound = True)  then begin
            NewEvFound     := False;     {resets}
          If      (PrevEventFound < 0) then begin {makes index positive}
            PrevEventFound := abs(PrevEventFound);
            EVcoorX[High(EVcoorX),IndTabPr[PrevEventFound-1]] :=  2 {converts sparks to waves}
          End;
          If (BiggestAmpl = 0) then begin  {First Time Positive Event  Found}
              BiggestAmpl  := EVpeaks[CntIm-Beg-1,IndTabPr[PrevEventFound-1]];
              BiggestIndex := PrevEventFound - 1; {Holds Address of the Biggest Amplitude Wave in previous image}
          End Else
          If (BiggestAmpl > 0) then Begin  {somthing already was found before}

            if BiggestAmpl < EVpeaks[CntIm-Beg-1,IndTabPr[PrevEventFound-1]] then begin
              BiggestAmpl := EVpeaks[CntIm-Beg-1,IndTabPr[PrevEventFound-1]];
                {checks if they point to the same address e.g. if spark was converted to wave}
              if (IndTabPr[BiggestIndex] <> IndTabPr[PrevEventFound-1]) then
              EVcoorX[High(EVcoorX),IndTabPr[BiggestIndex]] :=  0; {kills event in previous image}
              BiggestIndex := PrevEventFound - 1; {Updates Address of the Biggest Amplitude Wave}
            end else
            if BiggestAmpl >= EVpeaks[CntIm-Beg-1,IndTabPr[PrevEventFound-1]] then begin
              if (IndTabPr[BiggestIndex] <> IndTabPr[PrevEventFound-1]) then
              EVcoorX[High(EVcoorX),IndTabPr[PrevEventFound-1]] :=  0; {kills event}
               {Note that Does Not update  BiggestIndex}
            end;
          End;  {if (BiggestAmpl > 0) then begin}
        End; {If (NewEvFound = True) }
                {-------------------------------------------------------}
      End; {If SmapPr[CountX, SiteTable[Cnt-1,CntY,0]] <> 0}
    End; {For CountX := SiteTable[Cnt-1,CntY,1] ...........}
  End; {For CntY := 0 to High(SiteTable[Cnt-1])}
            {---------------------}
  End;{If (WAVcntPr > 0) or (SPcntPr > 0))}

      If (PrevEventFound > 0) then Begin
        EVcoorX [CntIm-Beg,   IndTabPr[BiggestIndex]] := PeakXY[Cnt-1].X;
        EVcoorY [CntIm-Beg,   IndTabPr[BiggestIndex]] := PeakXY[Cnt-1].Y;
        EVpeaks[CntIm-Beg,   IndTabPr[BiggestIndex]] := Peak  [Cnt-1];
        IndTab[Cnt-1] := IndTabPr[BiggestIndex];
      End Else
      If (PrevEventFound = 0) Then Begin {Empty Spot}
        EVcoorX [CntIm-Beg, LastEVcol] := PeakXY[Cnt-1].X;
        EVcoorY [CntIm-Beg, LastEVcol] := PeakXY[Cnt-1].Y;
        EVpeaks[CntIm-Beg, LastEVcol] := Peak  [Cnt-1];
        EVcoorX[High(EVcoorX),LastEVcol] := 2; { +2 = Big Event}
        IndTab [Cnt-1] := LastEVCol;   {under each Site Number (Cnt-1) the Value = Column}
        Inc(LastEVcol);
      End; {PrevEventFound = 0}
      {------------------ End with Sparks ---------------}
 End; { End of: If SitePixCnt[Cnt-1] <= SPsiteMaxSize }
        Inc(Cnt);

 End; {While Cnt <= SiteCnt Do Begin}
END {cbIgnoreBigEv.Checked = False} ELSE

IF (cbIgnoreBigEv.Checked = True) THEN BEGIN
   {Otion that considers everything Sparks}
 While Cnt <= SiteCnt Do Begin
  {------------- --------------------------------------------------}
 If (SitePixCnt[Cnt-1] <= SPsiteMaxSize) and (SitePixCnt[Cnt-1] >= ScanBel) Then Begin {For Sparks}
         PrevEventFound := 0;
             {Case #1; Spark on a Previous Spark Site}
      If (SPcntPr > 0) Then Begin {There Were Sparks or waves & on the Same Spot}
       PrevEventFound := SmapPr[PeakXY[Cnt-1].X, PeakXY[Cnt-1].Y];
      End; { Do not Use Else Here}

      If (PrevEventFound < 0) Then Begin
          {Case #1; Spark on a Previous Spark Site}
          EVcoorX [CntIm-Beg,IndTabPr[abs(PrevEventFound)-1]] := PeakXY[Cnt-1].X;
          EVcoorY [CntIm-Beg,IndTabPr[abs(PrevEventFound)-1]] := PeakXY[Cnt-1].Y;
          EVpeaks [CntIm-Beg,IndTabPr[abs(PrevEventFound)-1]] := Peak  [Cnt-1];
          IndTab[Cnt-1] := IndTabPr[abs(PrevEventFound)-1];

      End else {If (PrevEventFound <> 0)}
         {Case #3; Spark on a Empty Spot}
      If (PrevEventFound = 0) Then Begin {Empty Spot}
        EVcoorX [CntIm-Beg, LastEVCol] := PeakXY[Cnt-1].X;
        EVcoorY [CntIm-Beg, LastEVCol] := PeakXY[Cnt-1].Y;
        EVpeaks[CntIm-Beg, LastEVCol] := Peak  [Cnt-1];
        EVcoorX[High(EVcoorX),LastEVCol] := 1; {1 Means this is a Spark; 2 = Big Event}
        IndTab [Cnt-1] := LastEVCol;   {under each Site Number (Cnt-1) the Value = Column}
        Inc(LastEVCol);
      End; {PrevEventFound = 0}
                {-------------------------------------------------------}
 End; { If (SitePixCnt[Cnt-1] >= ScanBel)}
        Inc(Cnt);

 End; {While Cnt <= SiteCnt Do Begin}

END; {cbIgnoreBigEv.Checked = True}
   {-----------------------------------------------------------------------------}
    {Finally, after the Job is done - Copies Smap to SmapPr (Smap Previous)
                                and IndTab to IndTabPr}

      SPcntPr  := SPcnt;
      WAVcntPr := WAVcnt;
    {-------------------------}
    For LocY := 0 to imYsize - 1 Do Begin
      For LocX := 0 to imXsize - 1 Do Begin
        if (Smap[LocX,LocY] <> 0) then  SmapPr[LocX,LocY] := Smap[LocX,LocY] else
                                        SmapPr[LocX,LocY] := 0;
      End;
    End;
     {------------------------}
     {copies IndTab to IndTabPr}
    SetLength(IndTabPr,High(IndTab)+1);
    for LocX := 0 to High(IndTab) do IndTabPr[LocX] := IndTab[LocX];


{--------------------- End of 10th ----------------------------------------}

{***** Till This Point Operations for Sparks and Waves Requires SiteCnt > 0 *********}
END Else Begin;   {******* If (SiteCnt = 0) *****************}
  
      SPcntPr  := 0;
      WAVcntPr := 0;
   
END;  {End of  (SiteCnt = 0)}
{************************************************************************************}


END; {IF ImNr >= BegSearch THEN BEGIN}

  lblImageCnt.Caption := IntToStr(CntIm+1) + ' im';
  ProgrBarAutoSearch.Position := CntIm;

END; {FOR    ImNr := Beg to ToEnd Do Begin }


{----------- Finds Maximum Peak in a column -------} 

ProgrBarAutoSearch.Visible  := False;
ProgrBarAutoSearch.Position := 0;
lblImageCnt.Caption         := '';

if (AutoSearchPar.TestSmallEv) then FileClose(BackUpFile);
Screen.Cursor := crHourGlass;

{cleans buffers}
Smap       := nil;
SmapPr     := nil;
SiteTable  := nil;
SiteRowCnt := nil;
SitePixCnt := nil;
Peak       := nil;
PeakXY     := nil;
IndTab     := nil;
IndTabPr   := nil;
RunAvRaw   := nil;
RunAv      := nil;
RunAvRat   := nil;
ImList     := nil;

    If frmSparkTable <> nil then frmSparkTable.DelAllMarksClick(Sender) else
    For CntIm := 0 to NrIm - 1 Do Begin   {DelAllMarks Zeroes Mark Arrays}
      SetLength(MarkSmEvCoor[CntIm],0);
      SetLength(MarkSmAmpl[CntIm],0);
      SetLength(MarkSmBase[CntIm],0);
      SetLength(MarkSmEvDur[CntIm],0);
      SetLength(MarkSmEvRise[CntIm],0);
    End;
    If frmWaveTable  <> nil then frmWaveTable. DelAllMarksClick(Sender) else
    For CntIm := 0 to NrIm - 1 Do Begin   {DelAllMarks Zeroes Mark Arrays}
      SetLength(MarkBigEvCoor[CntIm],0);
      SetLength(MarkBigAmpl[CntIm],0);
      SetLength(MarkBigBase[CntIm],0);
      SetLength(MarkBigEvDur[CntIm],0);
      SetLength(MarkBigEvRise[CntIm],0);
    End;


////////////////////////////////////////////////////////
If (LastEVcol > 0) Then Begin {something was found}


            {For Sparks}
{-------- Beg of Time Ser Analysis --------------}
/////////////////////////////////////////////////////
            {this is done for For Sparks Only}

//BEGINS Small Events TEST

//Measuring the F/Fo is done with the Scanning Box

If (AutoSearchPar.TestSmallEv) Then Begin

    lblMessage.Caption := 'Testing Small Events';
    Application.ProcessMessages;
    BackUpFile := FileOpen(BackUpFileName,fmOpenRead or fmShareDenyNone);

    SetProgressBar(0,(LastEVcol - 1),0);
    ProgrBarAutoSearch.Visible  := True;

    PLval := (AutoSearchPar.PLval/100); // from % to Fraction of One
    PRval := (AutoSearchPar.PRval/100); // from % to Fraction of One

    LastX := 0; // here the LasX is stores the Last Image where Spark Was Found

    // Sets the Number of Pixels to the ROI chosen. ScanBel is not going to be used for Search anymore so it can be modified
    if (AutoSearchPar.UseCustomROIforSmEvTest) then with AutoSearchPar do
        ScanBel := ROISizeForSmEvTest*ROISizeForSmEvTest;

 For Cnt := 0 to LastEVcol - 1 Do Begin  //Searches All Columns//

    ProgrBarAutoSearch.Position := Cnt;

  If (EVcoorX[High(EVcoorX), Cnt] = 1) Then Begin  //1 stands for Sparks, 2 Waves , 0 Should be disregarded

         {Finds Max and X, Y of Max For a Column}

  //---- Beginning of Main Loops ---------------------//

    //1st: looks where 1st image occured = value > 0 and Finds at which Image is the Max }
       SpPeak  := 0;
       FirstRow := -1;
       LastRow  := -1;
    For CntIm := Beg to ToEnd Do Begin
      If (SpPeak < EVpeaks[CntIm-Beg, Cnt]) then begin
        SpPeak     := EVpeaks[CntIm-Beg, Cnt];  //Finds the Highest Value in Column
        SpPeakXY.X := EVcoorX[CntIm-Beg, Cnt];  //and Coordinates
        SpPeakXY.Y := EVcoorY[CntIm-Beg, Cnt];  //and Coordinates
        LocX       := CntIm; //here LocX is used to memorize ImNr where Max occured
      End; // If (SpPeak < EVpeaks[CntIm-Beg, Cnt]) then begin
       if (EVpeaks[CntIm-Beg, Cnt] > 0) and (FirstRow = -1) then FirstRow  := CntIm; //First Image Where Spark was detected
       if (EVpeaks[CntIm-Beg, Cnt] > 0)                     then LastRow   := CntIm; //Last Image Where Spark was detected
       if (SpPeak > 0) and (EVpeaks[CntIm-Beg, Cnt] = 0) then Break; //stops search if no more Values above Zero
    End; //For CntIm := BegSearch to ToEnd Do Begin

      // 2nd: if Column was empty (e.g. an Wave deleted a Spark) then sets coord to 0, else proceeds //
    If not(SpPeak > 0) Then Begin
      EVcoorX[High(EVcoorX), Cnt] := 0;
    End Else

    If (SpPeak > 0) Then Begin

        //Zeroes  All Values not at Peak Image//
      for CntIm := LocX-1 downto FirstRow do EVpeaks[CntIm-Beg, Cnt] := 0;
      for CntIm := LocX+1 to     LastRow  do EVpeaks[CntIm-Beg, Cnt] := 0;

      with AutoSearchPar do begin

        ReadFBeg := LocX - Round(SearchLms/(MeanImTime*1000)) + (NrImGetMinLeft-1)  - 1; // -1 to Start one image before Peak
        ReadFend := LocX + Round(SearchRms/(MeanImTime*1000)) - (NrImGetMinRight-1) + 1; // +1 to Start one image after Peak

      KillSpark   := False;

       {at leat to run window one time left -> LocX - AutoSearchPar.NrImGetMinRight-1}

      if (ReadFBeg < Beg + (NrImGetMinLeft-1)) then begin
        if (LocX - NrImGetMinLeft >= Beg)
        then begin
          ReadFBeg   := Beg + (NrImGetMinLeft-1);
        end
        else
        begin
          EVcoorX[High(EVcoorX), Cnt] := 0;
          KillSpark   := True;
        end;
      end;

       {at leat to run window one time right-> LocX + AutoSearchPar.NrImGetMinRight-1}
      if (ReadFend > ToEnd - (NrImGetMinRight-1)) and  not(KillSpark) then begin
        if (LocX + NrImGetMinRight <= ToEnd)
        then
          ReadFend := ToEnd - (NrImGetMinRight-1)
        else
        begin
          EVcoorX[High(EVcoorX), Cnt] := 0;
          KillSpark   := True;
        end;
      end;
      end; //with
      {remainder
        BegSearch = Beg   + Round(AutoSearchPar.SearchLms/(MeanImTime*1000)) + 1;
        EndSearch = ToEnd - Round(AutoSearchPar.SearchRms/(MeanImTime*1000)) - 1;

        Beg   = BegSearch - Round(AutoSearchPar.SearchLms/(MeanImTime*1000)) - 1;
        ToEnd = EndSearch + Round(AutoSearchPar.SearchRms/(MeanImTime*1000)) + 1;
      }
    End; // If (SpPeak > 0) Then Begin

 If Not(KillSpark) Then Begin

      lblImageCnt.Caption := IntToStr(LocX+1) + ' im';
      Application.ProcessMessages;

      if (AutoSearchPar.SDuse) then with AutoSearchPar do begin
        SetLength(BuffImValues,NrImGetMinLeft);
        if (Length(MeanAndSD) <> (LocX - (ReadFBeg-(NrImGetMinLeft-1))) - NrImGetMinLeft + 1) then
          SetLength(MeanAndSD,   (LocX - (ReadFBeg-(NrImGetMinLeft-1))) - NrImGetMinLeft + 1);
        for CntRow := 0 to High(MeanAndSD) do MeanAndSD[CntRow].Mean := 0;//Zero Means
      end;

      //Constructs ROI with Center the X,Y of Spark Coordinates//
      if not(AutoSearchPar.UseCustomROIforSmEvTest) then begin
        Xbeg  :=  SpPeakXY.X - (ScanBS div 2);
        Xend  :=  Xbeg +  ScanBL;
        Ytop  :=  SpPeakXY.Y - (ScanBS div 2);
        Ybot  :=  Ytop + ScanBL;
      end else
      begin  //use the specific ROI
        Xbeg  :=  SpPeakXY.X - (AutoSearchPar.ROISizeForSmEvTest div 2);
        Xend  :=  Xbeg +  (AutoSearchPar.ROISizeForSmEvTest - 1);
        Ytop  :=  SpPeakXY.Y - (AutoSearchPar.ROISizeForSmEvTest div 2);
        Ybot  :=  Ytop + (AutoSearchPar.ROISizeForSmEvTest - 1);
      end;

      //beginning  of Evaluation Left in Time to the Spark//
       //Reads Rat File Image by Image//
       //it gets MaxVal from One image, but MinVal from 1 or more images defined by NrImGetMin//
      MinVal      := 1000000; //just to be sure make it much bigger then SpPeak
      MaxVal      := 0;
      MinPos      := LocX;
      MaxPos      := LocX;
      KillSpark   := True;

  If not(AutoSearchPar.UpdateRatio) Then Begin

    For CntIm := LocX-1 downto  ReadFBeg Do Begin
        MeanVal := 0;
        //Here it Gets the Min from NrImGetMinLeft consecutive points
      For LocY := 0 to AutoSearchPar.NrImGetMinLeft - 1 do begin   //LocY here is used as Counter

        FPos := (CntIm-Beg-LocY)*ImagePix*4;  //one Single = 4 bytes
        FileSeek(BackUpFile,FPos,0);  //0 = Origin = Begining of File//
        pRatIm := @RatIm[0]; //Reads Ratio from File
        FileRead(BackUpFile,pRatIm^,ImagePix*4);

      //Gets ROI mean of current image//
        if (AutoSearchPar.SDuse) then begin
            BuffImValues[LocY] := 0;
          for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
            BuffImValues[LocY] := BuffImValues[LocY] + RatIm[CntX + imXsize*CntY];
            MeanVal := MeanVal + BuffImValues[LocY];
          end else
          begin
          for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
            MeanVal := MeanVal + RatIm[CntX + imXsize*CntY];
        end;

        If (LocY = 0)  then begin  //the first not Cumulative Mean
          OneImVal := MeanVal/ScanBel;
          if (CntIm >= LocX-AutoSearchPar.NrImToLeftOfEv) then begin
          //updates values
            EVpeaks[CntIm-Beg, Cnt] := OneImVal;
            EVcoorX[CntIm-Beg, Cnt] := SpPeakXY.X;
            EVcoorY[CntIm-Beg, Cnt] := SpPeakXY.Y;
          end else
            //Zeroes to remove unneeded Values from Before
            //that may not have same coordinates
            EVpeaks[CntIm-Beg, Cnt] := 0;
           //refreshes MaxVal //
          if (MaxVal < OneImVal) then begin
            MaxVal := OneImVal;
            MaxPos := CntIm;
          end;
        End; //if (LocY = 0)

      End; //For LocY := 0 to AutoSearchPar.NrImGetMinLeft - 1 do begin

        //LocY counter out of loop is Always EQ to Last value + 1}
        OneImVal := MeanVal/AutoSearchPar.NrImGetMinLeft; //store the non div by ScanBel for MeanAndSD
        MeanVal  := OneImVal/ScanBel; //gets final scaled MeanVal

         //Always Stores MeanVal When Subtracred from Peak/baseline is > Thresh
      If (AutoSearchPar.SDuse) and (SpPeak - MeanVal > Thresh - 1) then Begin
        //gets not divided by Nr Pixels Mean and SD
        MeanAndSD[(LocX-1)- CntIm].Mean := OneImVal; //copy the non div by ScanBel MeanVal
        MeanAndSD[(LocX-1)- CntIm].SD   := GetStdDevUsingKnownMean(BuffImValues,MeanAndSD[(LocX-1)- CntIm].Mean);
      End;

      //refreshes MinVal //
      if (MinVal > MeanVal) then begin
         MinVal := MeanVal;
         MinPos := CntIm;
      end;
        //end of refreshing//

      If (KillSpark) then Begin
        If (SpPeak - MinVal > Thresh - 1) then Begin
          KillSpark := False;
          BaseVal := MinVal; //memorize for later
        End;
      End;

      If not(KillSpark) then Begin
        If (MinVal < BaseVal) then Begin
          If (MaxVal - BaseVal > Thresh - 1) and (MaxPos < MinPos)
          {it found another Event before the Current one and therefore
          the Min (the valey) between them is the BaseVal for the Current Event
          The Search for Baseline is to be stopped   }
          then Begin
            {The Search for Baseline is stopped Only if
            the Values for NrImToLeftOfEv are Updated for same coordinates of ROI}
            if (CntIm < LocX-AutoSearchPar.NrImToLeftOfEv)
            then
            Break;
          End Else
          {The Search for Baseline continue. There is no other event before}
          BaseVal := MinVal; //memorize for later
        End;
      End;
    End; //For ImNr := LocX-1 downto  ReadFBeg

       //Check if the Peak > Baseline + fold*SD
    If (AutoSearchPar.SDuse) and Not(KillSpark) then with AutoSearchPar do Begin
      //1st test for baseline at MinPos = Lowest Baseline
      if not(SpPeak > BaseVal + (MeanAndSD[(LocX-1)-MinPos].SD/ScanBel)*SDfold)
      then KillSpark := True;

      //tries other baselines which comply with Peak-baseline > Thresh
      If (KillSpark) then begin
        //we have only Couple of Mean & SD; We have checked already one then check the other one
        If (Length(MeanAndSD) = 2) then begin
          if (MinPos = LocX-1)   then Dec(MinPos)
            else
          if (MinPos = ReadFBeg) then Inc(MinPos);

          MinPos := (LocX-1)-MinPos;

          if (MeanAndSD[MinPos].Mean > 0) then
            if (SpPeak > (MeanAndSD[MinPos].Mean/ScanBel) + (MeanAndSD[MinPos].SD/ScanBel)*SDfold)
              then begin
                KillSpark := False;
                BaseVal := MeanAndSD[MinPos].Mean/ScanBel;
              end;
        End Else
        //if we have more then two
        If (Length(MeanAndSD) > 2) then begin
          MinPos := (LocX-1)-MinPos;
          LocY := 0;
          //find out how many Means > 0 are
          for CntRow := 0 to High(MeanAndSD) do begin
            if (CntRow <> MinPos) and (MeanAndSD[CntRow].Mean > 0) then Inc(LocY);
          end;
          //if we have some Means > 0
          If (LocY > 0) then Begin
            SetLength(MeanSelTrAndSD,LocY);
            LocY := 0;
            for CntRow := 0 to High(MeanAndSD) do begin
              if (CntRow <> MinPos) and (MeanAndSD[CntRow].Mean > 0)
              then begin
                MeanSelTrAndSD[LocY] := MeanAndSD[CntRow];
                Inc(LocY);
              end;
            end;
            //case with just one mean > 0
            if (Length(MeanSelTrAndSD) = 1) then begin
              if (SpPeak > (MeanSelTrAndSD[0].Mean/ScanBel) + (MeanSelTrAndSD[0].SD/ScanBel)*SDfold)
                then begin
                  KillSpark := False;
                  BaseVal := MeanSelTrAndSD[0].Mean/ScanBel;
                end;
            end else
            begin
              //case we have more than one - then sort Mean+SD pairs by Mean value
              InsertSortMeanAndSDbyMean(MeanSelTrAndSD);
              //check if test wiil past starting from lowest Mean
              for CntRow := 0 to High(MeanSelTrAndSD) do begin
                if (SpPeak > (MeanSelTrAndSD[CntRow].Mean/ScanBel) + (MeanSelTrAndSD[CntRow].SD/ScanBel)*SDfold)
                then begin
                  KillSpark := False;
                  BaseVal := MeanSelTrAndSD[CntRow].Mean/ScanBel;
                  Break;
                end;
              end; //for CntRow := 0 to High(MeanSelTrAndSD)
            end;
          End;  //if (LocY > 0) then begin
        End; // If (Length(MeanAndSD) > 2) then begin
      End; //If (KillSpark) then begin
    End; //If (SDuse) and Not(KillSpark) then Begin


    //Check if Value before Peak is > PeakValue*percentage of peak
    If Not(KillSpark) and (AutoSearchPar.NrImToLeftOfEv > 0) then Begin
      for CntRow := 1 to AutoSearchPar.NrImToLeftOfEv do begin //here CntRow is used as a counter
        if (EVpeaks[LocX-CntRow-Beg, Cnt] - BaseVal < (SpPeak - BaseVal)*PLval)
        then  begin
          EVpeaks[LocX-CntRow-Beg, Cnt] := 0;
          KillSpark := True;
        end;
      end; //for CntRow := 0 to AutoSearchPar.NrImToLeftOfEv - 1 do begin
    End;

    If (KillSpark) then Begin
       EVcoorX[High(EVcoorX), Cnt] := 0; //kills Spark//
    End Else

    If Not(KillSpark) then Begin

      KillSpark := True;
      MinVal    := 1000000;

      //beginning  of Evaluation Rigth in Time to the Spark//

      For CntIm := LocX+1 to ReadFend Do Begin
      //------------------------------------------
          MeanVal := 0;
        For LocY := 0 to AutoSearchPar.NrImGetMinRight -1 do begin   //LocY here is used as Counter
          FPos := (CntIm-Beg+LocY)*ImagePix*4; //single
          FileSeek(BackUpFile,FPos,0);  //0 = Origin = Begining of File//
          pRatIm := @RatIm[0]; //Reads Ratio from File
          FileRead(BackUpFile,pRatIm^,ImagePix*4);

          //Gets ROI mean of current image//
          for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
            MeanVal := MeanVal + RatIm[CntX + imXsize*CntY];

          If (LocY = 0)  then begin  //the first not cumulative Mean
            if (CntIm <= LocX+AutoSearchPar.NrImToRightOfEv) then begin
              OneImVal := MeanVal/ScanBel;
              EVpeaks[CntIm-Beg, Cnt] := OneImVal;
              EVcoorX[CntIm-Beg, Cnt] := SpPeakXY.X;
              EVcoorY[CntIm-Beg, Cnt] := SpPeakXY.Y;
            end;
          End;
        End; // For LocY := 0 to AutoSearchPar.NrImGetMin -1 do begin

        MeanVal := MeanVal/(AutoSearchPar.NrImGetMinRight*ScanBel);
         //refreshes MinVal //
        if (MinVal > MeanVal) then begin
          MinVal := MeanVal;
        end;

        If (SpPeak - MinVal > Thresh - 1) then KillSpark := False;
        {KillSpark is set to False if there is a Valey on the Right site of the Peak}

        if not(KillSpark) then if (CntIm > LocX+AutoSearchPar.NrImToRightOfEv)
        then
          Break;
          {evaluation stops as soon as KillSpark is set to False
          And the values for NrImToRightOfEv are Updated }

      End; // For ImNr := LocX+1 to ReadFend

      If (KillSpark) then Begin
          EVcoorX[High(EVcoorX), Cnt] := 0; //kills Spark//
      End Else

      Begin
      //Check if Value after Peak is > PeakValue*percentage of peak
       if (AutoSearchPar.NrImToRightOfEv > 0) then begin
        for CntRow := 1 to AutoSearchPar.NrImToRightOfEv do begin //here CntRow is used as a counter
          if (EVpeaks[LocX+CntRow-Beg, Cnt] - BaseVal < (SpPeak - BaseVal)*PRval)
          then
            EVcoorX[High(EVcoorX), Cnt] := 0; //kills Spark//
        end; //for CntRow := 1 to AutoSearchPar.NrImToLeftOfEv do begin
       end;
      End;  //begin if KilSpark = False

    End; // If Not(KillSpark)

  End   //If not(cbUpdateRatio.Checked) Then Begin

    Else

  //-------------- If Has to Recriate F/Fo -------------------------//

  If (AutoSearchPar.UpdateRatio) Then Begin

       //Reloads SpPeak as non ratio
       FPos := (LocX-Beg)*ImagePix*2; //Words
       FileSeek(BackUpFile,FPos,0);  //0 = Origin = Begining of File//
       pRatIm := @im16bitDataSM_Last[0]; //Reads Smoothed Non ratio
       FileRead(BackUpFile,pRatIm^,ImagePix*2);

       MeanVal := 0;
       for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
              MeanVal := MeanVal + im16bitDataSM_Last[CntX + imXsize*CntY];

       OneImVal := MeanVal/ScanBel;
       SpPeak := OneImVal;
       EVpeaks[LocX-Beg, Cnt] := OneImVal;

    For CntIm := LocX-1 downto ReadFBeg Do Begin
      MeanVal := 0;
        //Here it Gets the Min from NrImGetMin consecutive points
      For LocY := 0 to AutoSearchPar.NrImGetMinLeft - 1 do begin   //LocY here is used as Counter

        FPos := (CntIm-Beg-LocY)*ImagePix*2; //words
        FileSeek(BackUpFile,FPos,0);  //0 = Origin = Begining of File//
        pRatIm := @im16bitDataSM_Last[0]; //Reads Smoothed Non ratio
        FileRead(BackUpFile,pRatIm^,ImagePix*2);

      //Gets ROI mean of current image//
        if (AutoSearchPar.SDuse) then begin
            BuffImValues[LocY] := 0;
          for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
            BuffImValues[LocY] := BuffImValues[LocY] + im16bitDataSM_Last[CntX + imXsize*CntY];
            MeanVal := MeanVal + BuffImValues[LocY];
         end else
        begin
          for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
            MeanVal := MeanVal + im16bitDataSM_Last[CntX + imXsize*CntY];
        end;

        If (LocY = 0)  then begin  //the first not cumulative Mean
          OneImVal := MeanVal/ScanBel;
         if (CntIm >= LocX-AutoSearchPar.NrImToLeftOfEv) then begin
            //updates values
            EVpeaks[CntIm-Beg, Cnt] := OneImVal;
            EVcoorX[CntIm-Beg, Cnt] := SpPeakXY.X;
            EVcoorY[CntIm-Beg, Cnt] := SpPeakXY.Y;
          end;
           //refreshes MaxVal //
          if (MaxVal < OneImVal) then begin
            MaxVal := OneImVal;
            MaxPos := CntIm;
          end;
        End; //if (LocY = 0)

      End; //For LocY := 0 to NrImGetMin -1

        //LocY counter out of loop is Always EQ to Last value + 1}

      OneImVal := MeanVal/AutoSearchPar.NrImGetMinLeft; //store the non div by ScanBel for MeanAndSD
      MeanVal  := OneImVal/ScanBel; //gets final scaled MeanVal

      //Always Stores MeanVal When Subtracred from Peak/baseline is > Thresh
      If (AutoSearchPar.SDuse) and ((SpPeak-Bkg)/(MeanVal-Bkg) > Thresh) then Begin
        //gets not divided by Nr Pixels Mean and SD
        MeanAndSD[(LocX-1)- CntIm].Mean := OneImVal;
        MeanAndSD[(LocX-1)- CntIm].SD := GetStdDevUsingKnownMean(BuffImValues,MeanAndSD[(LocX-1)- CntIm].Mean);
      End;


      //refreshes MinVal //
      If (MinVal > MeanVal) then begin
         MinVal := MeanVal;
         MinPos := CntIm;
      End;
        //end of refreshing//

      If (KillSpark) then Begin
        If ((SpPeak-Bkg)/(MinVal-Bkg) > Thresh) then Begin  //(SpPeak-Bkg)/(MinVal-Bkg) is F/Fo
          KillSpark := False;
          BaseVal := MinVal; //memorize for later
        End;
      End;

      If not(KillSpark) then Begin
        If (MinVal < BaseVal) then Begin
          If ((MaxVal-Bkg)/(BaseVal-Bkg) > Thresh) and (MaxPos < MinPos)
          {it found another Event before the Current one and therefore
          the Min (the valey) between them is the BaseVal for the Current Event
          The Search for Baseline is to be stopped.}
          then Begin
            {The Search for Baseline is stopped Only if
            the Values for NrImToLeftOfEv are Updated}
            if (CntIm < LocX-AutoSearchPar.NrImToLeftOfEv)
            then
            Break;
            {if the Values for NrImToLeftOfEv are Not yet updated
            the Loop continues but it does not Update BaseVal}
          End Else
          Begin
          {The Search for Baseline continue. There is no other event before}
            BaseVal := MinVal; //memorize for later
          End;
        End;
      End;

    End; //For CntIm := LocX-1 downto ReadFBeg Do Begin

      //Check if the Peak > Baseline + fold*SD
    If (AutoSearchPar.SDuse) and Not(KillSpark) then with AutoSearchPar do Begin
      //1st test for baseline at MinPos = Lowest Baseline
      if not(SpPeak-Bkg > (BaseVal-Bkg) + (MeanAndSD[(LocX-1)-MinPos].SD/ScanBel)*SDfold)
      then KillSpark := True;

      //tries other baselines which comply with Peak-baseline > Thresh
      If (KillSpark) then begin
        //we have only Couple of Mean & SD; We have checked already one then check the other one
        If (Length(MeanAndSD) = 2) then begin
          if (MinPos = LocX-1)   then Dec(MinPos)
            else
          if (MinPos = ReadFBeg) then Inc(MinPos);

          MinPos := (LocX-1)-MinPos;

          if (MeanAndSD[MinPos].Mean > 0) then
            if (SpPeak-Bkg > (MeanAndSD[MinPos].Mean/ScanBel-Bkg) + (MeanAndSD[MinPos].SD/ScanBel)*SDfold)
              then begin
                KillSpark := False;
                BaseVal := MeanAndSD[MinPos].Mean/ScanBel;
              end;

        End Else
        //if we have more then two
        If (Length(MeanAndSD) > 2) then begin
          MinPos := (LocX-1)-MinPos;
          LocY := 0;
          //find out how many Means > 0 are
          for CntRow := 0 to High(MeanAndSD) do begin
            if (CntRow <> MinPos) and (MeanAndSD[CntRow].Mean > 0) then Inc(LocY);
          end;
          //if we have some Means > 0
          If (LocY > 0) then Begin
            SetLength(MeanSelTrAndSD,LocY);
            LocY := 0;
            for CntRow := 0 to High(MeanAndSD) do begin
              if (CntRow <> MinPos) and (MeanAndSD[CntRow].Mean > 0)
              then begin
                MeanSelTrAndSD[LocY] := MeanAndSD[CntRow];
                Inc(LocY);
              end;
            end;
            //case with just one mean > 0
            if (Length(MeanSelTrAndSD) = 1) then begin
              if (SpPeak-Bkg > (MeanSelTrAndSD[0].Mean/ScanBel-Bkg) + (MeanSelTrAndSD[0].SD/ScanBel)*SDfold)
                then begin
                  KillSpark := False;
                  BaseVal := MeanSelTrAndSD[0].Mean/ScanBel;
                end;
            end else
            begin
              //case we have more than one - then sort Mean+SD pairs by Mean value
              InsertSortMeanAndSDbyMean(MeanSelTrAndSD);
              //check if test wiil past starting from lowest Mean
              for CntRow := 0 to High(MeanSelTrAndSD) do begin
                if (SpPeak-Bkg > (MeanSelTrAndSD[CntRow].Mean/ScanBel-Bkg) + (MeanSelTrAndSD[CntRow].SD/ScanBel)*SDfold)
                then begin
                  KillSpark := False;
                  BaseVal := MeanSelTrAndSD[CntRow].Mean/ScanBel;
                  Break;
                end;
              end; //for CntRow := 0 to High(MeanSelTrAndSD)
            end;
          End;  //if (LocY > 0) then begin
        End; // If (Length(MeanAndSD) > 2) then begin

      End; //If (KillSpark) then begin

    End; //If (SDuse) and Not(KillSpark) then Begin

    //Check if Value before Peak is > PeakValue*percentage of peak
    If Not(KillSpark)  then Begin
      SpPeak := (SpPeak-Bkg)/(BaseVal-Bkg); //Converts to F/Fo
      EVpeaks[LocX-Beg, Cnt] := SpPeak;
      If (AutoSearchPar.NrImToLeftOfEv > 0) then begin
        for CntRow := 1 to AutoSearchPar.NrImToLeftOfEv do begin //here CntRow is used as a counter
          //Converts to F/Fo starting from LocX - 1, i.e on image before Peak
          EVpeaks[LocX-CntRow-Beg, Cnt] := (EVpeaks[LocX-CntRow-Beg, Cnt]-Bkg)/(BaseVal-Bkg);
          if (EVpeaks[LocX-CntRow-Beg, Cnt] - 1 < (SpPeak - 1)*PLval)
          //All values are normalized by Baseline, That's why we subtract "1" not BaseVal
          then  begin
            KillSpark := True;
            Break;
          end;
        end;
      End; //If (AutoSearchPar.NrImToLeftOfEv > 0) then begin
    End;

    //-----End of Evaluation of Left in Time to the Spark-----//

    If (KillSpark) then Begin
       EVcoorX[High(EVcoorX), Cnt] := 0; //kills Spark//
    End Else

    //-----beginning  of Evaluation Right in Time to the Spark-----//

    If Not(KillSpark) then Begin
      KillSpark := True;
      MinVal    := 1000000;
      //beginning  of Evaluation Right in Time to the Spark//
      For CntIm := LocX+1 to ReadFend Do Begin
         MeanVal := 0;
        For LocY := 0 to AutoSearchPar. NrImGetMinRight -1 do begin   //LocY here is used as Counter
          FPos := (CntIm-Beg+LocY)*ImagePix*2; //words
          FileSeek(BackUpFile,FPos,0);  //0 = Origin = Begining of File//
          pRatIm := @im16bitDataSM_Last[0]; //Reads Smoothed Non ratio
          FileRead(BackUpFile,pRatIm^,ImagePix*2);

          //Gets ROI mean of current image//
          for CntY := Ytop to Ybot do For CntX := Xbeg to Xend do
            MeanVal := MeanVal + Im16bitDataSM_Last[CntX + imXsize*CntY];

          If (LocY = 0)  then begin  //the first not cumulative Mean
            if (CntIm <= LocX+AutoSearchPar.NrImToRightOfEv) then begin
              OneImVal := MeanVal/ScanBel;
              OneImVal := (OneImVal-Bkg)/(BaseVal-Bkg);
              EVpeaks[CntIm-Beg, Cnt] := OneImVal;
              EVcoorX[CntIm-Beg, Cnt] := SpPeakXY.X;
              EVcoorY[CntIm-Beg, Cnt] := SpPeakXY.Y;
            end;
          End;

        End; // For LocY := 0 to AutoSearchPar. NrImGetMinRight -1

        MeanVal := MeanVal/(AutoSearchPar. NrImGetMinRight*ScanBel);
        MeanVal := (MeanVal-Bkg)/(BaseVal-Bkg);

          //refreshes MinVal //
        if (MinVal > MeanVal) then begin
          MinVal := MeanVal;
        end;

        If (SpPeak - MinVal > Thresh - 1) then KillSpark := False;
        {KillSpark is set to False if there is a Valey on the Right site of the Peak}

        if not(KillSpark) then if (CntIm > LocX+AutoSearchPar.NrImToRightOfEv)
        then
          Break;
          {evaluation stops as soon as KillSpark is set to False
          and the values for NrImToRightOfEv are Updated }
      End; // For CntIm := LocX+1 to ReadFend

      If (KillSpark) then Begin
          EVcoorX[High(EVcoorX), Cnt] := 0; //kills Spark//
      End Else

      Begin
      //Check if Value after Peak is > PeakValue*percentage of peak
       if (AutoSearchPar.NrImToRightOfEv > 0) then begin
        for CntRow := 1 to AutoSearchPar.NrImToRightOfEv do begin //here CntRow is used as a counter
          if (EVpeaks[LocX+CntRow-Beg, Cnt] - 1 < (SpPeak - 1)*PRval)
          then
           EVcoorX[High(EVcoorX), Cnt] := 0; //kills Spark//
        end;
       end;
      End;  //begin if KilSpark = False

    End; // If Not(KillSpark)

  End; // If (AutoSearchPar.UpdateRatio) Then Begin

 End; //If Not(KillSpark, the Main One) Then Begin



  //---------- end of Main Loops -----------------------//

  End; { If EVcoor[High(EVcoor), Cnt].X = 1}
 End; {For Cnt := 0 to LastEVcol - 1}

   FileClose(BackUpFile);
   System.SysUtils.DeleteFile(BackUpFileName);
   RatIm := nil;
   ProgrBarAutoSearch.Visible  := False;
   ProgrBarAutoSearch.Position := 0;

End; {If (AutoSearchPar.TestSmallEv) Then Begin}

// END of Small Event TEST


{------- End of Time Series Analysis ------------}
    lblImageCnt.Caption := '';
    lblMessage.Caption := 'Preparing Tables';
    Application.ProcessMessages;
    SetLength(SPpeakImNr,LastEVcol);
    SetLength(FINSPcoor, LastEVcol);
    SetLength(FINSPpeaks,LastEVcol);

    {analyses columns for Sparks and Finds the Image:
     with the Highest Peak or Where Fiurst Detected}
    for Cnt := 0 to LastEVcol - 1 do FINSPpeaks[Cnt] := 0; {Zeroes}

      SPcnt := 0; {Here Counts Sparks}

    For Cnt := 0 to LastEVcol - 1 Do Begin
      If EVcoorX[High(EVcoorX), Cnt] = 1 Then Begin
         {Finds Max For a Column}
        For CntIm := BegSearch to ToEnd Do Begin
         if FINSPpeaks[SPcnt] <  EVpeaks[CntIm-Beg, Cnt] then begin
            FINSPpeaks[SPcnt]   := EVpeaks[CntIm-Beg, Cnt];
            FINSPcoor [SPcnt].X := EVcoorX[CntIm-Beg, Cnt];
            FINSPcoor [SPcnt].Y := EVcoorY[CntIm-Beg, Cnt];
            SPpeakImNr[SPcnt]   := CntIm;
         end;
        End; {For ImNr := Beg to ToEnd}
         {End of Finding Max}
        Inc(SPcnt);
      End; {If EVcoor[High(EVcoor), Cnt].X = -1 Then Begin;}
    End; {For Cnt := 0 to LastEVcol}


{---------------------------------}
    {removes Excess Columns}
    SetLength(SPpeakImNr,SPcnt);
    SetLength(FINSPcoor, SPcnt);
    SetLength(FINSPpeaks,SPcnt);

       {fills Mark arrays and Spark Table (Grid) }
  If (SPcnt > 0) Then Begin
    For Cnt := 0 to High(SPpeakImNr) Do Begin
      SetLength(MarkSmEvCoor[SPpeakImNr[Cnt]],High(MarkSmEvCoor[SPpeakImNr[Cnt]])+ 2);
      SetLength(MarkSmAmpl  [SPpeakImNr[Cnt]],High(MarkSmAmpl  [SPpeakImNr[Cnt]])+ 2);
      SetLength(MarkSmEvDur [SPpeakImNr[Cnt]],High(MarkSmEvDur [SPpeakImNr[Cnt]])+ 2);
      SetLength(MarkSmBase  [SPpeakImNr[Cnt]],High(MarkSmBase  [SPpeakImNr[Cnt]])+ 2);
      SetLength(MarkSmEvRise[SPpeakImNr[Cnt]],High(MarkSmEvRise[SPpeakImNr[Cnt]])+ 2);
      
      MarkSmEvCoor[SPpeakImNr[Cnt],High(MarkSmEvCoor[SPpeakImNr[Cnt]])] := FINSPcoor [Cnt];
      MarkSmAmpl  [SPpeakImNr[Cnt],High(MarkSmAmpl  [SPpeakImNr[Cnt]])] := FINSPpeaks[Cnt];
      MarkSmBase  [SPpeakImNr[Cnt],High(MarkSmBase  [SPpeakImNr[Cnt]])] := 1.0;   //initial default
      MarkSmEvDur [SPpeakImNr[Cnt],High(MarkSmEvDur [SPpeakImNr[Cnt]])].L := NOT_ANALYZED;
      MarkSmEvDur [SPpeakImNr[Cnt],High(MarkSmEvDur [SPpeakImNr[Cnt]])].R := NOT_ANALYZED;
      MarkSmEvRise[SPpeakImNr[Cnt],High(MarkSmEvRise[SPpeakImNr[Cnt]])] := NOT_ANALYZED;  
    End; {For}


    // Main Principle is that the Table finally uses Box ROI sizes (in Image Controls) to measure Amplitude and other Params despite
    // that ScanBox or other ROI can be chosen to reject or accept events.

    // if Avarage image was updated in increments through the search then create an average image from the whole search range
    //then it must be created Average Image for entire search Range
    //if one uses CreateAverageImageUsingMinimum for specific range that will not be updated then it must be created before hand and saved to a file
      if (AutoSearchPar.AutoAverImage) then begin//create Average Image for entire search Range
        if (cbFinalCutoff.Checked) then frmImageControl.trbCutOff.Position := 0;  //sets it to zer to avoid division  by zero in some cases when cutoff is too high 9-15-2017
        CreateAverageImageUsingMinimum(Sender,dsSerchFromTo.PosFrom,dsSerchFromTo.PosTo,1);
      end;

    if ((AutoSearchPar.AutoAverImage) Or
       (not(AutoSearchPar.UseCustomROIforSmEvTest) and ((ScanBS <> ROIvar.BoxXsize) or (ScanBS <> ROIvar.BoxYsize))) Or
       ((AutoSearchPar.UseCustomROIforSmEvTest) and ((AutoSearchPar.ROISizeForSmEvTest <> ROIvar.BoxXsize) or
       (AutoSearchPar.ROISizeForSmEvTest <> ROIvar.BoxYsize))))
       AND Not(MarkTablesPar.GetSmEvBase) then
      RecalculateMeanforMark(MarkSmEvCoor,MarkSmAmpl);

      //Explanation: GetMarksBaselines not only Calculates Baseline but also Updates Mark Amplitudes using Box ROI sizes (in Image Controls)!!!
      // Since GetDurForMark uses Box ROI sizes, then if Not (MarkTablesPar.GetSmEvBase) then better recalculate Amplitude using Box ROI sizes
      //before do GetDurForMark. If MarkTablesPar.GetSmEvBase is chosen GetMarksBaselines will recalculate Amplitude using Box ROI sizes.

    if ((AutoSearchPar.AutoAverImage) and (MarkTablesPar.GetSmEvBase)) or ((AutoSearchPar.GetSmEvDur) and (MarkTablesPar.GetSmEvBase)) then
        GetMarksBaselines(MarkSmEvCoor, MarkSmAmpl,MarkSmBase,MarkTablesPar.NrPointsSmEvBase,MarkTablesPar.SmEvBaseSearchRange);

    if (AutoSearchPar.GetSmEvDur) then
        GetDurForMark(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,MarkTablesPar.NrPointsSmEvBase,MarkTablesPar.SmEvBaseSearchRange);

    if frmSparkTable <> nil then begin
      BegFill    := True;
      frmSparkTable.LoadSparkTable(BegFill);
    end;
  End; {If SPcnt > 0}
  
///////////////////////////////////////////////////////////////////
End; {If LastEVcol > 0 Then Begin {something was found}

    SPpeakImNr := nil;
    FINSPcoor  := nil;
    FINSPpeaks := nil;
       
   {end for sparks}
{---------------------------------------}
   { analyses columns for Waves and Finds the Image with the Highest Peak}
If LastEvCol > 0 Then Begin {something was found}
    SetLength(WavPeakImNr,LastEvCol);
    SetLength(FINWavCoor, LastEvCol);
    SetLength(FINWavPeaks,LastEvCol);

  for Cnt := 0 to LastEvCol - 1 do FINWavPeaks[Cnt] := 0;
  WavCnt := 0;

  For Cnt := 0 to LastEvCol - 1 Do Begin
    If EVcoorX[High(EVcoorX), Cnt] = 2 Then Begin
      For CntIm := Beg to ToEnd Do Begin
        if FINWavPeaks[WavCnt] <  EVPeaks[CntIm-Beg, Cnt] then begin
          FINWavPeaks[WavCnt]   := EVPeaks[CntIm-Beg, Cnt];
          FINWavCoor [WavCnt].X := EVCoorX[CntIm-Beg, Cnt];
          FINWavCoor [WavCnt].Y := EVCoorY[CntIm-Beg, Cnt];
          WavPeakImNr[WavCnt]   := CntIm;
        end;
      End; {For ImNr := Beg to ToEnd}
      Inc(WavCnt);
    End; {If EVcoor[High(EVcoor), Cnt].X = 1}
  End; {For Cnt := 0 to LastEVcol}


  {Removes Ecessive Columns}
  SetLength(WavPeakImNr,WavCnt);
  SetLength(FINWavCoor, WavCnt);
  SetLength(FINWavPeaks,WavCnt);

 {fills Waves Table (Grid) }
  If WavCnt > 0 Then Begin
    For Cnt := 0 to High(WavPeakImNr) Do Begin
      SetLength(MarkBigEvCoor[WavPeakImNr[Cnt]],High(MarkBigEvCoor[WavPeakImNr[Cnt]])+ 2);
      SetLength(MarkBigAmpl  [WavPeakImNr[Cnt]],High(MarkBigAmpl  [WavPeakImNr[Cnt]])+ 2);
      SetLength(MarkBigBase  [WavPeakImNr[Cnt]],High(MarkBigBase  [WavPeakImNr[Cnt]])+ 2);
      SetLength(MarkBigEvDur [WavPeakImNr[Cnt]],High(MarkBigEvDur [WavPeakImNr[Cnt]])+ 2);
      SetLength(MarkBigEvRise [WavPeakImNr[Cnt]],High(MarkBigEvRise [WavPeakImNr[Cnt]])+ 2);

      MarkBigEvCoor[WavPeakImNr[Cnt],High(MarkBigAmpl [WavPeakImNr[Cnt]])] := FINWavCoor [Cnt];
      MarkBigAmpl  [WavPeakImNr[Cnt],High(MarkBigAmpl [WavPeakImNr[Cnt]])] := FINWavPeaks[Cnt];
      MarkBigBase  [WavPeakImNr[Cnt],High(MarkBigBase [WavPeakImNr[Cnt]])] := 1.00;
      MarkBigEvDur [WavPeakImNr[Cnt],High(MarkBigEvDur[WavPeakImNr[Cnt]])].L := NOT_ANALYZED;
      MarkBigEvDur [WavPeakImNr[Cnt],High(MarkBigEvDur[WavPeakImNr[Cnt]])].R := NOT_ANALYZED;
      MarkBigEvRise[WavPeakImNr[Cnt],High(MarkBigEvRise [WavPeakImNr[Cnt]])] := NOT_ANALYZED;
    End;
     
    if ((AutoSearchPar.AutoAverImage) Or ((ScanBS <> ROIvar.BoxXsize) or (ScanBS <> ROIvar.BoxYsize)))
       AND Not(MarkTablesPar.GetBigEvBase) then
       RecalculateMeanforMark(MarkBigEvCoor,MarkBigAmpl);

      //Explanation: GetMarksBaselines not only Calculates Baseline but also Updates Mark Amplitudes using Box ROI sizes (in Image Controls)!!!
      // Since GetDurForMark uses Box ROI sizes, then if Not (MarkTablesPar.GetSmEvBase) then better recalculate Amplitude using Box ROI sizes
      //before do GetDurForMark. If MarkTablesPar.GetBigEvBase is chosen GetMarksBaselines will recalculate Amplitude using Box ROI sizes.

    if ((AutoSearchPar.AutoAverImage) and (MarkTablesPar.GetBigEvBase)) or ((AutoSearchPar.GetBigEvDur) and (MarkTablesPar.GetBigEvBase)) then
        GetMarksBaselines(MarkBigEvCoor, MarkBigAmpl,MarkBigBase,MarkTablesPar.NrPointsBigEvBase,MarkTablesPar.BigEvBaseSearchRange);

    if (AutoSearchPar.GetBigEvDur) then
        GetDurForMark(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,MarkTablesPar.NrPointsBigEvBase,MarkTablesPar.BigEvBaseSearchRange);

    if frmWaveTable <> nil then begin
      BegFill    := True;
      frmWaveTable.LoadWaveTable(BegFill);
    end;
  End;
End; {If LastWavCol > 0 Then Begin {something was found}

{------------------------------------}
    {refreshes All the Buffers with Current Image}
     ReadImage(CurIm,0,pImData);
    If (RatioOn) Then Begin
      if (SmoothMode > 0) then ApplySmoothing;
    End; { (RatioOn = True)}
 {---------- end Refreshing}
    AnalInAction := False;
    frmSPautoSearch.StartSearch.Enabled := True;
    frmSPautoSearch.BorderIcons := frmSPautoSearch.BorderIcons + [biSystemMenu];
    lblMessage.Caption := '';
    Screen.Cursor := crDefault;
    if MarkPar.DisplaySmEvents then if High(MarkSmEvCoor[CurIm]) >= 0 then
            DrawSmalEvMarks(frmMainWin.winMainImage.Canvas);
    if MarkPar.DisplayBigEvents then if High(MarkBigEvCoor[CurIm]) >= 0 then
            DrawBigEvMarks(frmMainWin.winMainImage.Canvas);

    if  frmAverIm <> nil then UpdateAverImage(True);

    { Allowes Windows to use Suspend mode and so on}
    MainForm.PwrSaveSparkAn.AllowSuspend    := True;
    MainForm.PwrSaveSparkAn.AllowStandby    := True;
    MainForm.PwrSaveSparkAn.AllowEndSession := True;

End; {If (EventsAutoSearchSettingsOK(False))}
END; {Procedure TfrmSPautoSearch.StartSearchClick(Sender: TObject);}


{****************************************************************}



procedure TfrmSPautoSearch.StopSearchButtonClick(Sender: TObject);
begin
     StopSearch := True;
end;

{********************Help Commands *************************}

procedure TfrmSPautoSearch.TitleThreshMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 8;
    GetHelp(HelpCode);
  end;

end;

procedure TfrmSPautoSearch.tlToleranceMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 9;
    GetHelp(HelpCode);
  end;

end;

procedure TfrmSPautoSearch.TitleScanBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 10;
    GetHelp(HelpCode);
  end;

end;


procedure TfrmSPautoSearch.lbSmallMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 11;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.cbUseRunAverMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 13;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.cbUseCustomROIforSmEvTestClick(Sender: TObject);
begin
  AutoSearchPar.UseCustomROIforSmEvTest := cbUseCustomROIforSmEvTest.Checked;
end;

procedure TfrmSPautoSearch.dsSerchFromToChange(Sender: TObject);
begin
    EdnSearchFromTo.SetNumbersOneTwo(dsSerchFromTo.PosFrom+1,dsSerchFromTo.PosTo+1);
end;

procedure TfrmSPautoSearch.EdnSearchFromToReturnPressed(Sender: TObject);
begin
   dsSerchFromTo.SetSliderPos(EdnSearchFromTo.NumberOne-1,EdnSearchFromTo.NumberTwo-1);
end;

procedure TfrmSPautoSearch.SmallEvTestMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 15;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.RunMinAverMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 16;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.cbIgnoreBigEvMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;

begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 17;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.cbSaveAutoAverClick(Sender: TObject);
begin
  AutoSearchPar.SaveAutoAver := cbSaveAutoAver.Checked;
end;

procedure TfrmSPautoSearch.cbSDuseClick(Sender: TObject);
begin
  AutoSearchPar.SDuse := cbSDuse.Checked;
end;

procedure TfrmSPautoSearch.enSDfoldReturnPressed(Sender: TObject);
begin
  AutoSearchPar.SDfold := enSDfold.NumberOne;
end;

procedure TfrmSPautoSearch.cbStartAutoAverFirstImClick(Sender: TObject);
begin
  AutoSearchPar.StartAutoAverFirstIm := cbStartAutoAverFirstIm.Checked;
end;

procedure TfrmSPautoSearch.cbUpdateRatioClick(Sender: TObject);
begin
  AutoSearchPar.UpdateRatio :=  cbUpdateRatio.Checked;
end;

procedure TfrmSPautoSearch.rbPutMaxOfEvMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;

begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 18;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.rbPutFirstMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;

begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 19;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.TitleCreateAvImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;

begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 20;
    GetHelp(HelpCode);
  end;
end;
{*************End with Help Commands *************************}

procedure TfrmSPautoSearch.FormCreate(Sender: TObject);
begin

    // Set Bar color
    ProgrBarAutoSearch.BarColor := clBlue;

      frmSPautoSearch.Position := poScreenCenter;

      If (MainImLoaded = True) and (NrIm > 1) then Begin
         StartSearch.Enabled   := True;
         dsSerchFromTo.Enabled := True;
         dsSerchFromTo.SetSlider(0,NrIm-1,0,NrIm-1);
         EdnSearchFromTo.Enabled := True;
         EdnSearchFromTo.HideText := False;
         EdnSearchFromTo.MaxLength := Length(IntToStr(NrIm))*2 + 1;
         EdnSearchFromTo.Min := 1;
         EdnSearchFromTo.Max := NrIm;
         EdnSearchFromTo.SetNumbersOneTwo(1,NrIm);
      End Else Begin
         dsSerchFromTo.Enabled    := False;
         EdnSearchFromTo.HideText := True;
         EdnSearchFromTo.Enabled  := False;
      End;

     cbFinalCutoff.Checked := FinalCutOff;
     SetSPautoSearch(AutoSearchPar);

   //  trbMaxSparkSizeChange(sender); does not work

End;

{***************************************************************************}
procedure TfrmSPautoSearch.SetSPautoSearch(const AutoSPar : TAutoSearchPar);
//used by procedure TfrmSPautoSearch.FormCreate(Sender: TObject);
//and Queue File
begin

{General Settings}

      trbThresh.Position           := AutoSPar.Thresh;
      trbPerc.Position             := AutoSPar.Tolerance;
      trbScanBoxSize.Position      := AutoSPar.ScanBoxSize;
      trbMaxSparkSize.Position     := AutoSPar.MaxArea div 50;
      cbUseRunAver.Checked         := AutoSPar.UseRunAver;
      enNrImRunAver.NumberOne      := AutoSPar.NrImRunAver;
      cbIgnoreBigEv.Checked        := AutoSPar.IgnoreBigEv;
      {Small Events Test}
      SmallEvTest.Checked          := AutoSPar.TestSmallEv;
      cbUseCustomROIforSmEvTest.Checked := AutoSPar.UseCustomROIforSmEvTest;
      cbSDuse.Checked              := AutoSPar.SDuse;
      enSDfold.NumberOne           := AutoSPar.SDfold;
      enROISizeForSmEvTest.NumberOne := AutoSPar.ROISizeForSmEvTest;
      cbUpdateRatio.Checked        := AutoSPar.UpdateRatio;
      enNrImGetMinLeft.NumberOne   := AutoSPar.NrImGetMinLeft;
      enNrImGetMinRight.NumberOne  := AutoSPar.NrImGetMinRight;
      enNrImToLeftOfEv.NumberOne   := AutoSPar.NrImToLeftOfEv;
      enNrImToRightOfEv.NumberOne  := AutoSPar.NrImToRightOfEv;
      enPLval.NumberOne            := AutoSPar.PLval;
      enPRval.NumberOne            := AutoSPar.PRval;
      SearchLms.NumberOne          := AutoSPar.SearchLms;
      SearchRms.NumberOne          := AutoSPar.SearchRms;
      cbGetSmEvDur.Checked         := AutoSPar.GetSmEvDur;
      cbGetBigEvDur.Checked        := AutoSPar.GetBigEvDur;
      {AutoAverage Image Generation}
      enAutoAverNrImInc.NumberOne    := AutoSPar.AutoAverNrImInc;
      enAutoAverImRange.NumberOne    := AutoSPar.AutoAverImRange;
      cbCreateAutoAverImage.Checked  := AutoSPar.AutoAverImage;
      cbStartAutoAverFirstIm.Checked := AutoSPar.StartAutoAverFirstIm;
      cbSaveAutoAver.Checked         := AutoSPar.SaveAutoAver;

      {Create Average Image}
      enPointsToAver.NumberOne       := AutoSPar.NrImForCreateAvIm;


      if Not(AutoSPar.TestSmallEv) then Begin
        cbUseCustomROIforSmEvTest.Enabled := False;
        enROISizeForSmEvTest.Enabled := False;
        enNrImGetMinLeft.Enabled  := False;
        enNrImGetMinRight.Enabled := False;
        enNrImToLeftOfEv.Enabled  := False;
        enNrImToRightOfEv.Enabled := False;
        enPLval.Enabled   := False;
        enPRval.Enabled   := False;
        SearchLms.Enabled      := False;
        SearchRms.Enabled      := False;
      end;
      enNrImRunAver.Enabled     := AutoSPar.UseRunAver;


End;

{********************************************************************}
procedure TfrmSPautoSearch.GenHelpClick(Sender: TObject);
var  HelpCode : integer;

begin

    HELP_Point := Mouse.CursorPos;
    HelpCode    := 22;
    GetHelp(HelpCode);

end;

procedure TfrmSPautoSearch.lbNrImGetMinValMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 45;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmSPautoSearch.enNrImToLeftOfEvReturnPressed(Sender: TObject);
begin
  AutoSearchPar.NrImToLeftOfEv := enNrImToLeftOfEv.NumberOne;
end;

procedure TfrmSPautoSearch.enNrImToRightOfEvReturnPressed(Sender: TObject);
begin
   AutoSearchPar.NrImToRightOfEv := enNrImToRightOfEv.NumberOne;
end;

procedure TfrmSPautoSearch.enPLvalReturnPressed(Sender: TObject);
begin
   AutoSearchPar.PLval := enPLval.NumberOne;
end;

procedure TfrmSPautoSearch.enPRvalReturnPressed(Sender: TObject);
begin
   AutoSearchPar.PRval := enPRval.NumberOne;
end;

procedure TfrmSPautoSearch.enROISizeForSmEvTestReturnPressed(Sender: TObject);
begin
  AutoSearchPar.ROISizeForSmEvTest := enROISizeForSmEvTest.NumberOne;
end;

procedure TfrmSPautoSearch.enNrImGetMinLeftReturnPressed(Sender: TObject);
begin
   AutoSearchPar.NrImGetMinLeft := enNrImGetMinLeft.NumberOne;
end;

procedure TfrmSPautoSearch.enNrImGetMinRightReturnPressed(Sender: TObject);
begin
   AutoSearchPar.NrImGetMinRight := enNrImGetMinRight.NumberOne;
end;

{***************************************************************************}
Procedure TfrmSPautoSearch.btnCreateAverageImageClick(Sender: TObject);
  var AvailiableMemory : DWORD;
Begin

  CreateAverageImageUsingMinimum(Sender,dsSerchFromTo.PosFrom,dsSerchFromTo.PosTo,0);

End; {Procedure Costruct Average}

{******************************************************************************}

procedure TfrmSPautoSearch.CreateAverageImageUsingMinimum(Sender : TObject; Beg,ToEnd : Integer; const MessageMode : Integer);

Var   ImNr,Cnt    : integer;
      Pnt,CntPt   : integer;
      ImBufMin    : TDynSingleArray;  {contain Image made from Minimum}
      ImBufMean   : TDynSingleArray;  {Contains Image Made from Averaging}
      ImBufMeanNoZeros : TDynSingleArray;
      TotNrIm     : integer;
      MeanTotNrIm : Double;
      MeanFromAv  : Double;
      Fact        : Double;
      LastIm      : integer;
      LSD,RSD     : Double;
      CntDone     : integer;
      DivFact     : Double;
Begin

        {Forbids Windows of Suspend mode}
        MainForm.PwrSaveSparkAn.AllowSuspend    := False;
        MainForm.PwrSaveSparkAn.AllowStandby    := False;
        MainForm.PwrSaveSparkAn.AllowEndSession := False;
        Pnt        := enPointsToAver.NumberOne;
        SetLength(ImBufMin, ImagePix);
        SetLength(ImBufMean,ImagePix);

        {Adjusts Beg and ToEnd if Diference not Enough}
        {Sets Minimal Number of Images}

        if (ToEnd - Beg + 1 < Pnt) then Begin
          if (ToEnd - Pnt >= 0) then begin
            Beg := ToEnd - Pnt;
          end
            else
          begin
            ToEnd := Beg + Pnt;
            if (ToEnd > NrIm - 1) then ToEnd := NrIm - 1;
          end;
        end;

        for Cnt := 0 to High(ImBufMin)  do  ImBufMin [Cnt] := High(Word);
        for Cnt := 0 to High(ImBufMean) do  ImBufMean[Cnt] := 0;  {not necessary}

        SetProgressBar(Beg,ToEnd,Beg);
        ProgrBarAutoSearch.Visible := True;
        frmSPautoSearch.StartSearch.Enabled := False;
        frmSPautoSearch.BorderIcons := frmSPautoSearch.BorderIcons - [biSystemMenu];
        Application.ProcessMessages;
        AnalInAction := True;   {Disables  Function DoMeanROI to Multply By Disply Factor}
        StopSearch := False;

        if (MessageMode = 0) then lblMessage.Caption := 'Generating Average' else
        if (MessageMode = 1) then lblMessage.Caption := 'Final Average';

        {Start}
         CntDone := Beg - 1;

    For ImNr := Beg to (ToEnd - Pnt) + 1 Do Begin
        {-------------------------------}
        Application.ProcessMessages;
        If (StopSearch = True) Then Begin
          LastIm := ImNr;
          Break;
        End;
        {--------------------------------}

        for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt]:= 0; {Zeroes}

        For CntPt := 0 to Pnt - 1 Do Begin

          ReadImage(ImNr + CntPt,0,pImData);
             {Summes for  Average and Mean from Whole File}
          if (BitCount = 16) then
            for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt]:= AvImRaw[Cnt] + Im16bitData[Cnt]
          else
            for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt]:= AvImRaw[Cnt] + Im8bitData [Cnt];
             {end summing}

            {Collects Mean}
          if (CntDone < ImNr + CntPt) then begin
            CntDone := ImNr + CntPt;
            if (BitCount = 16) then
            for Cnt := 0 to High(ImBufMean) do ImBufMean[Cnt] := ImBufMean[Cnt] + Im16bitData[Cnt]
              else
            for Cnt := 0 to High(ImBufMean) do ImBufMean[Cnt] := ImBufMean[Cnt] + Im8bitData[Cnt];
          end;

          if (ImNr = ToEnd - Pnt + 1) then begin
            lblImageCnt.Caption := IntToStr(ImNr + CntPt + 1) + ' im';
            ProgrBarAutoSearch.Position := ImNr;
          end;
      End; { For CntPt := 0 to Pnt - 1}
             {------------------------}
              {Makes Average}
        for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt] := AvImRaw[Cnt]/Pnt;
             {Collects Minimums}
        For Cnt := 0 to High(ImBufMin) do Begin
          if ImBufMin[Cnt] >  AvImRaw[Cnt] then
             ImBufMin[Cnt] := AvImRaw[Cnt];
        End;
             {---------------------}
        If (ImNr < ToEnd - Pnt + 1) then begin
           lblImageCnt.Caption := IntToStr(ImNr + 1) + ' im';
           ProgrBarAutoSearch.Position := ImNr;
        End; { If (ImNr < ToEnd - Pnt + 1)}

    End; {ImNr := 0 to NrIm -1 - Pnt}
        { End of Search}
   {-----------------------------------------------------}
    AnalInAction := False;   {Disables  Function DoMeanROI to Multply By Disply Factor}
    frmSPautoSearch.StartSearch.Enabled := True;
    lblImageCnt.Caption := '';
    ProgrBarAutoSearch.Visible := False;
    ProgrBarAutoSearch.Position := 0;
    lblMessage.Caption := '';
    Application.ProcessMessages;
   {------------------------------------------------------}
       {Copies to  AvImRaw}
    for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt] := ImBufMin[Cnt];
    {gets Means}

    if StopSearch = False then TotNrIm := ToEnd - Beg + 1 else
    if StopSearch = True  then TotNrIm := LastIm;

    for Cnt := 0 to High(ImBufMean) do ImBufMean[Cnt] := ImBufMean[Cnt]/TotNrIm;
    LSD := 1;
    RSD := 1;

   If (Cutoff = 0) then Begin

    GetMeanStdDevLimits(ImBufMean,MeanTotNrIm,LSD,RSD,2);
    GetMeanStdDevLimits(AvImRaw,  MeanFromAv, LSD,RSD,2);
      {Does Correction on AvImRaw}

    If (MeanFromAv < MeanTotNrIm) Then Begin  {this is What Happens}
     {in Brackets Was Old Way}
     { Fact := MeanTotNrIm/MeanFromAv;
      for Cnt := 0 to bmpPixNr - 1 do AvImRaw[Cnt] := AvImRaw[Cnt]*Fact;  }
      Fact := MeanTotNrIm - MeanFromAv;
      for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt] := AvImRaw[Cnt] + Fact;
    End Else
    If (MeanFromAv > MeanTotNrIm) Then Begin   {Not going to happen}
        {in Brackets Was Old Way}
     { Fact := MeanFromAv/MeanTotNrIm;
      for Cnt := 0 to bmpPixNr - 1 do AvImRaw[Cnt] := AvImRaw[Cnt]/Fact; }
      Fact := MeanFromAv - MeanTotNrIm;
      for Cnt := 0 to High(AvImRaw) do AvImRaw[Cnt] := AvImRaw[Cnt] - Fact;
    End;
   End Else

   If (Cutoff > 0) then Begin // should be redone every time for specific Cutoff
    //fill ImBufMin with No Zeroes, i.e. > Cutoff; it has been already copied to AvImRaw
    CntPt := 0;
    for Cnt := 0 to High(ImBufMean) do begin
      if (ImBufMean[Cnt] > Cutoff) then Inc(CntPt);
    end;
    SetLength(ImBufMin,CntPt); //now ImBufMin will be filled with No Zeroes
    SetLength(ImBufMeanNoZeros,CntPt);
    CntPt := 0;
    for Cnt := 0 to High(ImBufMean) do begin
      if (ImBufMean[Cnt] > Cutoff) then begin
        ImBufMin[CntPt]         := AvImRaw[Cnt];
        ImBufMeanNoZeros[CntPt] := ImBufMean[Cnt];
        Inc(CntPt);
      end;
    end;

    GetMeanStdDevLimits(ImBufMeanNoZeros,MeanTotNrIm,LSD,RSD,2);
    GetMeanStdDevLimits(ImBufMin,  MeanFromAv, LSD,RSD,2);
      {Does Correction on AvImRaw}

    If (MeanFromAv < MeanTotNrIm) Then Begin  {this is What Happens}
     {in Brackets Was Old Way}
     { Fact := MeanTotNrIm/MeanFromAv;
      for Cnt := 0 to bmpPixNr - 1 do AvImRaw[Cnt] := AvImRaw[Cnt]*Fact;  }
      Fact := MeanTotNrIm - MeanFromAv;
      for Cnt := 0 to High(ImBufMean) do begin
        if (ImBufMean[Cnt] > Cutoff) then
          AvImRaw[Cnt] := AvImRaw[Cnt] + Fact
        else
          AvImRaw[Cnt] := 0;
      end;
    End Else
    If (MeanFromAv > MeanTotNrIm) Then Begin   {Not going to happen}
        {in Brackets Was Old Way}
     { Fact := MeanFromAv/MeanTotNrIm;
      for Cnt := 0 to bmpPixNr - 1 do AvImRaw[Cnt] := AvImRaw[Cnt]/Fact; }
      Fact := MeanFromAv - MeanTotNrIm;
      for Cnt := 0 to High(ImBufMean) do begin
        if (ImBufMean[Cnt] > Cutoff) then
          AvImRaw[Cnt] := AvImRaw[Cnt] - Fact
        else
          AvImRaw[Cnt] := 0;
      end;
    End;
   End; //If (Cutoff > 0) then Begin

 ///////////---------------- End of AvIm - procedures ------/////////////////////////////////


      if  (frmAverIm = nil) then Application.CreateForm(TfrmAverIm, frmAverIm);
      Application.ProcessMessages;
      CopyAvImToDisplBuffer;
      UpdateAverImage(True);
      frmAverIm.Caption :=  'Generated Average Image';
      AvImInfoStr := ' Minimum from ' + IntToStr(Pnt) +
      ' Consecutive Images in Range from ' + IntToStr(Beg + 1) + ' to ' + IntToStr(ToEnd+1);

      for Cnt := 0 to NrIm - 1 do AvImList[Cnt] := 0;
      ImSel := 0;
      AvImExists := AVER_FROM_JUST_GEN;
      frmPlayback.SelectOne.Enabled   := False;
      frmPlayback.DeselectOne.Enabled := False;
      frmPlayback.Select10.Enabled    := False;
      frmPlayback.Deselect10.Enabled  := False;
      frmPlayback.lblSelIm.Caption    := 'M';

   If not(Sender = btnCreateAverageImage) then begin //use for AutoSearch
    if (SmoothMode > NO_SMOOTH) and (AutoSearchPar.SmoothBeforeDoRatio) then begin
      SmoothAverIm(AvImRaw,AvIm);
    end;
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
   End

    Else

   If (Sender = btnCreateAverageImage) then begin  //finalyse everything
      ReadImage(CurIm,0,pImData); // to refresh the buffer to the current frame
      If (RatioOn) then Begin
        Application.ProcessMessages; {to refresh}
        Screen.Cursor := crHourGlass;
        if (SmoothMode > NO_SMOOTH) and (AutoSearchPar.SmoothBeforeDoRatio) then begin
          ApplySmoothing;
          SmoothAverIm(AvImRaw,AvIm);
        end;
        DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
        DoRatio(DO_COPY);
      End; {(RatioOn = True)}
      UpdateMainImage(True);
      Screen.Cursor := crDefault;
   End;

    if (Sender = btnCreateAverageImage) then
    frmSPautoSearch.BorderIcons := frmSPautoSearch.BorderIcons + [biSystemMenu];

      {Restoes Windows Mode}
    MainForm.PwrSaveSparkAn.AllowSuspend    := True;
    MainForm.PwrSaveSparkAn.AllowStandby    := True;
    MainForm.PwrSaveSparkAn.AllowEndSession := True;


End; // procedure TfrmSPautoSearch.CreateAverageImageUsingMinimum;   //old procedure

{*****************************************************************************}

Procedure TfrmSPautoSearch.BoxCarSmooth1D(Const SourceArr : TDynSingleArray; var OutArr : TDynSingleArray;
                                          Const Points : Integer);  //Points is the Filter Kernel in Pixels

//One Dimentional BoxCar smoothing
//used by GetMapOfActivity

 var Cnt, CntP, HalfP,PLessOne : integer;
      TempAv : Double;   //Temp Average
 Begin


  PLessOne := Points - 1;
  HalfP    := Points div 2;


    For Cnt := 0 to High(SourceArr) - PLessOne Do Begin
      TempAv := 0;
      for CntP := 0 to PLessOne do TempAv := TempAv + SourceArr[Cnt + CntP];
      OutArr[Cnt + HalfP] := TempAv/Points;
    End;


 {if Points > 3 then at the Ends of the trace from 0 to Points/2 will not be smoothed,
  to compensate for this partially the paragraf below smooths with minimal number of Points (30 }
  If Points > 3 then Begin
    {Smooths Left End with Points = 3}

      For Cnt := 0 to HalfP - 2 Do Begin
        TempAv := 0;
        for CntP := 0 to 2 do TempAv := TempAv + SourceArr[Cnt + CntP];
        OutArr[Cnt + 1] := TempAv/3;
      End;

    {Smooths Right End with Points = 3}

      For Cnt := High(SourceArr)-HalfP to High(SourceArr)-2 Do Begin
        TempAv := 0;
        for CntP := 0 to 2 do TempAv := TempAv + SourceArr[Cnt + CntP];
        OutArr[Cnt + 1] := TempAv/3;
      End;

  End; {If Points > 3 then Begin}
      /////////////////////////////////////////

 End;  //Procedure BoxCarSmooth1D;


{*****************************************************************************}

procedure TfrmSPautoSearch.GetMapOfActivity;

Var ImNr,Cnt    : integer;
      Pnt,CntPt   : integer;
      ImBufMin    : TDynSingleArray;  {contain Image made from Minimum}
      ImBufMean   : TDynSingleArray;  {Contains Image Made from Averaging}
      ImBufMaxStdDev    : TDynSingleArray;
      PntBuf      : TDynSingleArray;
      PixBuf      : TDyn2DWordArray;    { collects data for All the Images for All Pixel Positions}
      OnePixBuf   : TDynWordArray;
      Beg, ToEnd  : integer;
      TotNrIm     : integer;
      MeanTotNrIm : Double;
      MeanFromAv  : Double;
      Fact        : Double;
      LastIm      : integer;
      LSD,RSD     : Double;
      CntDone     : integer;
      DivFact     : Double;
      Mean        : Double;
      MaxStdDev   : Double;
      StdDev      : Double;
      MaxPixInAver : single;
      MaxPixInStd   : single;
      MultFact    : Double;
      MinVal,MaxVal,MaxDelta, IntValue : Double;
      PntMinBuf   : TDynSingleArray;
      j : integer; //temp delete after
   /////////// used in Peak Cnt way ////////
      NonSmArr : TDynSingleArray;
      SmArr : TDynSingleArray;
      PeakCntArr : TDynByteArray;
      PeakCnt : integer;
      MinBef,MinAft,PeakVal,MinValS,T : Single;
      PeakFound,Lock  : Boolean;
      PeakIm,MinImBef,MinImAft  : integer;
      CntX,CntY : integer;
      Value : Single;
      BoxXY : Integer;

Begin

        {Forbids Windows of Suspend mode}
        MainForm.PwrSaveSparkAn.AllowSuspend    := False;
        MainForm.PwrSaveSparkAn.AllowStandby    := False;
        MainForm.PwrSaveSparkAn.AllowEndSession := False;
        Pnt        := enPointsToAver.NumberOne;
        SetLength(ImBufMin, ImagePix);
        SetLength(ImBufMean,ImagePix);
        Beg   := dsSerchFromTo.PosFrom;
        ToEnd := dsSerchFromTo.PosTo;


        {Adjusts Beg and ToEnd if Diference not Enough}
        {Sets Minimal Number of Images}
        if ToEnd - Beg < Pnt then Begin
          if ToEnd - Pnt >= 0 then Beg := ToEnd - Pnt else
                                   ToEnd := Beg   + Pnt;
        end;

        for Cnt := 0 to High(ImBufMin) do  ImBufMin [Cnt] := High(Word);
        for Cnt := 0 to High( ImBufMean) do  ImBufMean[Cnt] := 0;  {not necessary}
        ProgrBarAutoSearch.Min := 0;
        ProgrBarAutoSearch.Max := ToEnd - Beg  + 1;
        ProgrBarAutoSearch.Position := 0;
        ProgrBarAutoSearch.Visible := True;
        frmSPautoSearch.StartSearch.Enabled := False;
        frmSPautoSearch.BorderIcons := frmSPautoSearch.BorderIcons - [biSystemMenu];
        Application.ProcessMessages;
     //   AnalInAction := True;   {Disables  Function DoMeanROI to Multply By Disply Factor}
        StopSearch := False;
        {Start}
         CntDone := Beg - 1;
        LSD := 1;
        RSD := 1;
        lblMessage.Caption := 'Preparing Memory';
        SetLength(PixBuf,ToEnd - Beg + 1,ImagePix);
        ProgrBarAutoSearch.Max := ToEnd - Beg  + 1;
        ProgrBarAutoSearch.Position := 0;
        lblMessage.Caption := 'Reading File';

  //1st: goes through the File and fills the PixBuf
  For ImNr := Beg to ToEnd Do Begin
        //-------------------------------//
    Application.ProcessMessages;
    If StopSearch = True Then Begin
      LastIm := ImNr;
      Break;
    End;
       //--------------------------------//

    ReadImage(ImNr,0,pImData);

    if (SmoothMode = SMOOTH_BOX) then
    BoxCarFilt(Im16bitData,Im16bitDataSM_Last,imXsize,ImYsize,BoxSmSize,True) else
    if (SmoothMode = SMOOTH_MED) then
    MedianFilt(Im16bitData,Im16bitDataSM_Last,imXsize,ImYsize,MedSmSize,True) else
    if (SmoothMode = SMOOTH_BOX_MED) then begin
      BoxCarFilt(Im16bitData,Im16bitDataSM_First,imXsize,ImYsize,BoxSmSize,True);
      MedianFilt(Im16bitDataSM_First, Im16bitDataSM_Last,imXsize,ImYsize,MedSmSize,True)
    end else
    if (SmoothMode = SMOOTH_MED_BOX) then begin
      MedianFilt(Im16bitData,Im16bitDataSM_First,imXsize,ImYsize,MedSmSize,True);
      BoxCarFilt(Im16bitDataSM_First, Im16bitDataSM_Last,imXsize,ImYsize,BoxSmSize,True);
    end;

    if SmoothMode > NO_SMOOTH  then For Cnt := 0 to High(PixBuf[0]) do
      PixBuf[ImNr - Beg,Cnt] := Im16bitDataSM_Last[Cnt] else
    if SmoothMode = NO_SMOOTH  then For Cnt := 0 to High(PixBuf[0]) do
      PixBuf[ImNr - Beg,Cnt] := Im16bitData[Cnt];

    ProgrBarAutoSearch.Position := ImNr;
    application.ProcessMessages;
  End; // For ImNr := Beg to ToEnd Do Begin

 SetLength(NonSmArr,ToEnd - Beg + 1);
 SetLength(SmArr,   ToEnd - Beg + 1);

 SetLength(PeakCntArr,imXsize*imYsize);

 ProgrBarAutoSearch.Position := 0;
 ProgrBarAutoSearch.Max := ImagePix;
 lblMessage.Caption := 'Detecting activity';

 BoxXY := trbScanBoxSize.Position - 1;

 For Cnt := 0 to High(PeakCntArr) - imXsize*BoxXY - BoxXY do Begin


  For ImNr := 0 to High(NonSmArr)Do Begin
    Value := 0;
    For CntY := 0 to BoxXY Do Begin
      For CntX := 0 to BoxXY do begin
        Value := Value + PixBuf[ImNr,Cnt + CntX + imXsize*CntY];
      End;
    End;
    NonSmArr[ImNr] := Value;
  End;

  //smooths if scrPointsToAver.Position > 2

  if ( enPointsToAver.NumberOne > 2) then
  BoxCarSmooth1D(NonSmArr,SmArr,enPointsToAver.NumberOne) else
  for CntX := 0  to High(NonSmArr) do SmArr[CntX] := NonSmArr[CntX];

  //Gets Peaks

  MinImBef := High(SmArr);
  MinImAft := 0;
  PeakIm := 0;
  Lock    := False;
  T := trbThresh.Position/100; //threshold
  PeakCnt := 0;
  MinValS := High(Word);
  PeakVal := 0;



  For ImNr := 0 to High(SmArr) Do Begin
  
    If Not(Lock) then Begin
      if (MinValS > SmArr[ImNr]) then begin
        MinValS := SmArr[ImNr];
        MinImBef   := ImNr;
      end;
      if (PeakVal < SmArr[ImNr]) then begin
        PeakVal := SmArr[ImNr];
        PeakIm  := ImNr;
      end;
      if (PeakVal/MinValS > T) and (PeakIm > MinImBef) then Begin
        Lock := True;
        MinValS := PeakVal;
        MinImAft := PeakIm;
      end;
    End Else

    If (Lock) then Begin
      if (MinValS > SmArr[ImNr]) then begin
        MinValS := SmArr[ImNr];
        MinImAft := ImNr;
      end;
      if (PeakVal < SmArr[ImNr]) then begin
        PeakVal := SmArr[ImNr];
        PeakIm  := ImNr;
      end;
      if (PeakVal/MinValS > T) and (PeakIm < MinImAft) then Begin
        Lock := False;
        PeakVal := 0;
        MinValS := High(Word);
        MinImBef := PeakIm;
        Inc(PeakCnt);
      end;
    End;

  End; //For ImNr := 0 to High(SmArr) Do Begin

    PeakCntArr[Cnt + (BoxXY div 2) + imXsize*(BoxXY div 2)] := PeakCnt;

    ProgrBarAutoSearch.Position := Cnt;
    Application.ProcessMessages;

 End; //For Cnt := 0 to High(ImBufMaxStdDev) do Begin

   MaxPixInStd := 0;
  for Cnt := 0 to High(PeakCntArr) do
    if (MaxPixInStd < PeakCntArr[Cnt]) then MaxPixInStd := PeakCntArr[Cnt];
  MultFact := frmImageControl.enPixRange.NumberTwo/MaxPixInStd;

  for Cnt := 0 to High(AvImRaw) do
    AvImRaw[Cnt] := PeakCntArr[Cnt]*MultFact;
   ShowMessage('Mult Fact = ' + FloatToStr(MultFact));

   //-----------------------------------------------------//
    AnalInAction := False;   //Disables  Function DoMeanROI to Multply By Disply Factor//
    frmSPautoSearch.StartSearch.Enabled := True;
    lblImageCnt.Caption := '';
    ProgrBarAutoSearch.Visible := False;
    ProgrBarAutoSearch.Position := 0;
    lblMessage.Caption := '';
    Application.ProcessMessages;
 ///////////---------------- End of AvIm - procedures ------/////////////////////////////////
      //Restores Current image etc.
      
      ReadImage(CurIm,0,pImData);
      if  (frmAverIm = nil) then Application.CreateForm(TfrmAverIm, frmAverIm);
      Application.ProcessMessages;
      CopyAvImToDisplBuffer;
      UpdateAverImage(True);
      frmAverIm.Caption :=  'Generated Average Image';
      AvImInfoStr := ' Minimum from ' + IntToStr(Pnt) +
      ' Consecutive Images in Range from ' + IntToStr(Beg + 1) + ' to ' + IntToStr(ToEnd+1);

      for Cnt := 0 to NrIm - 1 do AvImList[Cnt] := 0;
      ImSel := 0;
      AvImExists := AVER_FROM_JUST_GEN;
      frmPlayback.SelectOne.Enabled   := False;
      frmPlayback.DeselectOne.Enabled := False;
      frmPlayback.Select10.Enabled    := False;
      frmPlayback.Deselect10.Enabled  := False;
      frmPlayback.lblSelIm.Caption    := 'M';

    If (RatioOn) then Begin
      Application.ProcessMessages; {to refresh}
      Screen.Cursor := crHourGlass;
      if (SmoothMode > NO_SMOOTH) and (AutoSearchPar.SmoothBeforeDoRatio) then SmoothAverIm(AvImRaw,AvIm);
      DoBkgonAvIm; //Subtracts Bkg from AvIm Only
      if (SmoothMode > 0) then ApplySmoothing;
      DoRatio(DO_COPY);
      UpdateMainImage(True);
      Screen.Cursor := crDefault;
    End; //(RatioOn = True)//
      frmSPautoSearch.BorderIcons := frmSPautoSearch.BorderIcons + [biSystemMenu];

      //Restoes Windows Mode//
    MainForm.PwrSaveSparkAn.AllowSuspend    := True;
    MainForm.PwrSaveSparkAn.AllowStandby    := True;
    MainForm.PwrSaveSparkAn.AllowEndSession := True;

End; // procedure TfrmSPautoSearch.CreateAverageImageNew;

{*****************************************************************************}
Function TfrmSPautoSearch.GetSimpleMean(Const Data: TDynSingleArray) : Double;

//used by GetMapOfActivity
var I    : Integer;
begin

  Result := 0;
  for I := 0 to High(Data) do Result := Result + (Data[I]);
  Result := Result/Length(Data);

End;
{*******************************************************************************}
Procedure TfrmSPautoSearch.GetStdDev(Const Data: TDynWordArray; var StdDev : Double);
var  S,Mean : Double;
     N, I   : Integer;
Begin

  {First Time}
      Mean := 0;
      N    := 0;
  for I := 0 to High(Data) do begin
      Mean := Mean + (Data[I]);
      Inc(N);
  End;

  Mean := Mean / N;

  S := 0;               { sum differences from the mean, for greater accuracy}

  for I := 0 to High(Data) do  S := S + Sqr(Mean - Data[I]);

  StdDev := Sqrt(S / (N - 1));
//  StdDev := StdDev/Sqrt(N);   //= standard error

End;  //Procedure GetStdDev;

{******************************************************************************}

procedure TfrmSPautoSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := caFree;
      frmSPautoSearch := nil;
end;

procedure TfrmSPautoSearch.enAutoAverNrImIncReturnPressed(Sender: TObject);
begin
   AutoSearchPar.AutoAverNrImInc := enAutoAverNrImInc.NumberOne;
end;

procedure TfrmSPautoSearch.enPointsToAverReturnPressed(Sender: TObject);
begin
   AutoSearchPar.NrImForCreateAvIm := enPointsToAver.NumberOne;
   if (enPointsToAver.NumberOne > enAutoAverImRange.NumberOne) then begin
     enAutoAverImRangeReturnPressed(Sender);
   end;
end;

procedure TfrmSPautoSearch.enAutoAverImRangeReturnPressed(Sender: TObject);
begin
   if (enAutoAverImRange.NumberOne < AutoSearchPar.NrImForCreateAvIm) then
       enAutoAverImRange.NumberOne := AutoSearchPar.NrImForCreateAvIm;
   AutoSearchPar.AutoAverImRange := enAutoAverImRange.NumberOne;
end;

procedure TfrmSPautoSearch.enNrImRunAverKeyPress(Sender: TObject; var Key: Char);
begin

     If Ord(Key) <> 8 Then Begin  {BackWards - deletes}
        if (not (Key in Dig13579)) then Key := #0;
     end;
end;


procedure TfrmSPautoSearch.enNrImRunAverReturnPressed(Sender: TObject);
begin
   AutoSearchPar.NrImRunAver := enNrImRunAver.NumberOne;
end;


procedure TfrmSPautoSearch.cbUseRunAverClick(Sender: TObject);
begin
     enNrImRunAver.Enabled     := cbUseRunAver.Checked;
     AutoSearchPar.UseRunAver := cbUseRunAver.Checked;;
end;


procedure TfrmSPautoSearch.SearchLmsReturnPressed(Sender: TObject);
begin
     AutoSearchPar.SearchLms := SearchLms.NumberOne;
end;

procedure TfrmSPautoSearch.SearchRmsReturnPressed(Sender: TObject);
begin
     AutoSearchPar.SearchRms := SearchRms.NumberOne;
end;

procedure TfrmSPautoSearch.SmallEvTestClick(Sender: TObject);
begin
       AutoSearchPar.TestSmallEv := SmallEvTest.Checked;
       cbUseCustomROIforSmEvTest.Enabled := SmallEvTest.Checked;
       enROISizeForSmEvTest.Enabled := SmallEvTest.Checked;
       enNrImGetMinLeft.Enabled  := SmallEvTest.Checked;
       enNrImGetMinRight.Enabled := SmallEvTest.Checked;
       enNrImToLeftOfEv.Enabled  := SmallEvTest.Checked;
       enNrImToRightOfEv.Enabled := SmallEvTest.Checked;
       enPLval.Enabled           := SmallEvTest.Checked;
       enPRval.Enabled           := SmallEvTest.Checked;
       SearchLms.Enabled         := SmallEvTest.Checked;
       SearchRms.Enabled         := SmallEvTest.Checked;

end;

procedure TfrmSPautoSearch.cbCreateAutoAverImageClick(Sender: TObject);
begin
  AutoSearchPar.AutoAverImage := cbCreateAutoAverImage.Checked;
end;

procedure TfrmSPautoSearch.cbFinalCutoffClick(Sender: TObject);
begin
  FinalCutOff := cbFinalCutoff.Checked;
end;

procedure TfrmSPautoSearch.cbGetBigEvDurClick(Sender: TObject);
begin
      AutoSearchPar.GetBigEvDur := cbGetBigEvDur.Checked;
end;

procedure TfrmSPautoSearch.cbGetSmEvDurClick(Sender: TObject);
begin
       AutoSearchPar.GetSmEvDur := cbGetSmEvDur.Checked;
end;

procedure TfrmSPautoSearch.cbIgnoreBigEvClick(Sender: TObject);
begin
         AutoSearchPar.IgnoreBigEv := cbIgnoreBigEv.Checked;
end;
END.
