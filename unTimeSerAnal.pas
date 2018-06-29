{$D-,L-,O+,Q-,R-,Y-,S-}
unit unTimeSerAnal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, System.StrUtils,System.Math,
  Vcl.ExtCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.ImgList, Vcl.Buttons,Vcl.ComCtrls,
  Vcl.Menus, unFrameTimSerPlot, DSlider, EditNumerical,unGlobUnit, UniButton,
  LabelExt;


Const
    {Constants taken by TimeSerAnalOpCode public property of this unit}
      CONVENTIONAL  = 0;
      DIAM_TRACKING = 1;
    {Constants taken by cbSmTraceKind.ItemIndex or TimPltSlid.SmTraceKind}
      BOXCART1D     = 0;
      GAUSS1D       = 1; //uses the predifined filters in  the dropdown menu
      GAUSS1D_Fc    = 2; //uses the Fc (corner frequency) in the enFcGaussFlt.Text
      KALMAN1D      = 3;

type

  TfrmTimeSerPlot = class(TForm)
    ProgBarTimSerPlot: TProgressBar;
    ImageListColOnButt: TImageList;
    ColBut: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolBarButContr: TToolBar;
    InclusiveExclusive: TToolButton;
    ShowAllTraces: TToolButton;
    UnduRedu: TToolBar;
    ReDo: TToolButton;
    UnDo: TToolButton;
    StartStop: TToolBar;
    StartAnal: TToolButton;
    StopAnalButton: TToolButton;
    UpDownNrWin: TUpDown;
    ImageListButOff: TImageList;
    ImageListDisabledButt: TImageList;
    TitleWindow: TLabel;
    cbTraceDivMin: TCheckBox;
    CheckBoxCursor: TCheckBox;
    CheckBoxSymbolOn: TCheckBox;
    lbImNum: TLabel;
    cbSmTraceFltSize: TComboBox;
    lbNrPoints: TLabel;
    titXaxis: TLabel;
    titFromTo: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    panButtons: TPanel;
    pnAxes: TPanel;
    cbGetPeaks: TCheckBox;
    scrbPeakThresh: TScrollBar;
    lbPeakThresh: TLabel;
    Bevel5: TBevel;
    RatTitle: TLabel;
    btGetPeeks: TSpeedButton;
    ImListToolBut: TImageList;
    ImListToolButDisabled: TImageList;
    TraceSel: TComboBox;
    MeasTrace: TSpeedButton;
    Bevel6: TBevel;
    sbSetRange: TSpeedButton;
    FreezeMean: TSpeedButton;
    ShowMins: TPanel;
    dsAnalRange: TDSlider;
    dsXaxes: TDSlider;
    dsYaxes: TDSlider;
    enYtop: TEditNumerical;
    enYbottom: TEditNumerical;
    enAnalFromTo: TEditNumerical;
    enXaxes: TEditNumerical;
    FrameTimSerPlot: TFrameTimSerPlot;
    enBaseLinePoints: TEditNumerical;
    enLSD : TEditNumerical;
    enRSD: TEditNumerical;
    lbLSD: TLabel;
    lbRSD: TLabel;
    Label1: TLabel;
    lbBaseline: TLabel;
    SlavePlot: TToolBar;
    sbSlavePlot: TSpeedButton;
    sbTraceToDisplay: TSpeedButton;
    enRangeFromTo: TEditNumerical;
    enTraceMinPoints: TEditNumerical;
    NrPasses: TComboBox;
    edEachPeakBasePt: TEditNumerical;
    Label3: TLabel;
    Label4: TLabel;
    edEachPeakBaseRg: TEditNumerical;
    Label5: TLabel;
    cbGetEachPeakBase: TCheckBox;
    lbFinalPoints: TLabel;
    Label2: TLabel;
    cbSmTraceKind: TComboBox;
    ubWithoutBaseline: TUniButton;
    ubGetBaseline: TUniButton;
    unSubtractBaseline: TUniButton;
    sbDelPeak: TSpeedButton;
    sbUnDoDelPeak: TSpeedButton;
    PopupMenuDeletePeak: TPopupMenu;
    DeleteRow: TMenuItem;
    Cancel: TMenuItem;
    unDivideByBaseline: TUniButton;
    GoToImage: TMenuItem;
    enFcGaussFlt: TEditNumerical;
    lbFc: TLabel;
    edlNrWin: TEdit;
    ubCopyRangeFromXaxis: TUniButton;
    enThreshForArea: TEditNumerical;
    lbThreshold: TLabel;
    lbTimeSerAnalMode: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edEachPeakBaseRgReturnPressed(Sender: TObject);
    procedure edEachPeakBasePtReturnPressed(Sender: TObject);
    procedure cbGetEachPeakBaseClick(Sender: TObject);
    procedure NrPassesChange(Sender: TObject);
    procedure enTraceMinPointsReturnPressed(Sender: TObject);
    procedure dsYaxesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbTraceToDisplayClick(Sender: TObject);
    procedure dsXaxesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure sbSlavePlotClick(Sender: TObject);
    procedure enRSDReturnPressed(Sender: TObject);
    procedure enLSDReturnPressed(Sender: TObject);
    procedure enBaseLinePointsReturnPressed(Sender: TObject);
    procedure QuestionInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FrameTimSerPlotimgTimeSerPlotMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure StartAnalClick(Sender: TObject);
    procedure StopAnalButtonClick(Sender: TObject);
    procedure FrameTimSerPlotimgTimeSerPlotMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FrameTimSerPlotimgTimeSerPlotMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure UpDownNrWinClick(Sender: TObject; Button: TUDBtnType);
    procedure ToolButtonClick(Sender: TObject);
    procedure ShowAllTracesClick(Sender: TObject);
    procedure InclusiveExclusiveClick(Sender: TObject);
    procedure UnDoClick(Sender: TObject);
    procedure ReDoClick(Sender: TObject);
    procedure cbTraceDivMinClick(Sender: TObject);
    procedure CheckBoxCursorClick(Sender: TObject);
    procedure CheckBoxSymbolOnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbSmTraceFltSizeChange(Sender: TObject);
    procedure pnlPlotXrangeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure scrbPeakThreshChange(Sender: TObject);
    procedure btGetPeeksClick(Sender: TObject);
    procedure cbGetPeaksClick(Sender: TObject);
    procedure MeasTraceClick(Sender: TObject);
    procedure TraceSelChange(Sender: TObject);
    procedure ToolButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); 
    procedure FrameTimSerPlotimgTimeSerPlotMouseLeave(Sender: TObject);
    procedure edBaseFromKeyPress(Sender: TObject; var Key: Char);
    procedure sbSetRangeClick(Sender: TObject);
    procedure ShowMinsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FreezeMeanClick(Sender: TObject);
    procedure dsAnalRangeChange(Sender: TObject);
    procedure dsXaxesChange(Sender: TObject);
    procedure dsYaxesChange(Sender: TObject);
    procedure enYbottomReturnPressed(Sender: TObject);
    procedure enYtopReturnPressed(Sender: TObject);
    procedure enAnalFromToReturnPressed(Sender: TObject);
    procedure enXaxesReturnPressed(Sender: TObject);
    procedure cbSmTraceKindChange(Sender: TObject);
    procedure ubWithoutBaselineClick(Sender: TObject);
    procedure ubGetBaselineClick(Sender: TObject);
    procedure unSubtractBaselineClick(Sender: TObject);
    procedure sbDelPeakClick(Sender: TObject);
    procedure sbUnDoDelPeakClick(Sender: TObject);
    procedure unDivideByBaselineClick(Sender: TObject);
    procedure GoToImageClick(Sender: TObject);
    procedure enFcGaussFltReturnPressed(Sender: TObject);
    procedure lbFcMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbFcMouseEnter(Sender: TObject);
    procedure lbFcMouseLeave(Sender: TObject);
    procedure ubCopyRangeFromXaxisClick(Sender: TObject);

  private
    { Private declarations }
   VertCursor      : array[0..5] of TPoint;
   LockOnCur       : Boolean; {Horiz Cursor}
   SelStart        : Boolean; {Trace Part selection}
   LockOnMesCur    : Boolean;
   {Used by FreezeMin to memorize Range - updated by Time Ser Analysis Procedure
   and Points Used; [1]= beg, [2] = end, [3] = points used last}
   InitialWidth      : Integer; //Holds the initial frmTimeSerPlot.Width when ClientWidth is set to 705

   procedure WMSize(var M : TWMSIZE); Message WM_Size; {added by me; helps hiding window}
   procedure DoConvTimeSeriesAnal(var Beg, ToEnd : integer; Sender: TObject);
   procedure TrackDiameterInTime (var Beg, ToEnd : integer; Sender: TObject);
   Procedure SetArraysForTimeSerAnal(Const LengthOfData : Integer);
   Procedure FinalizeTimeSerAnal(Sender : TObject);
  public
    { Public declarations }
   TimeSerAnalOpCode : Integer; //Operational Code For Analysis
   TimeSerPlotHidden : Boolean;
   PlotMemBMP        : TBitmap;
   procedure BaseLineControlsClick(Sender: TObject);
   procedure CheckAreaMinPoints(Sender : TObject);
   procedure DeletePeak (Sender : TObject);
   procedure DisableAndReleaseTraceButtons;
   Procedure DrawMesCursor(Sender : TObject; Const PlotData : TDyn2DDoubleArr);
   Procedure GetAreaDivMinOrArea(Sender : TObject);
   function  GetFinalEventWidth(Const NrScanes : Integer) : Integer;
   procedure GetBaseLine(const TSPlotData_Source : TDyn2DDoubleArr; var BaselineOut : TDyn2DDoubleArr);
   function  GetPeakIndex : Integer;
   procedure ResetGaussCoeff;
   procedure ReDoBaseLineAndPeaks(Sender: TObject);
   Procedure RePlot(Sender : TObject);
   Procedure SetButtons(FirstTime : Boolean);
   procedure SetPlotTitle;
   Procedure SetTrace(const TrNr : integer; const sender : Tobject);
   procedure SetYAxes(Const TraceDivByMin : Boolean; Const Ymin,Ymax,Ybot,Ytop : Integer);
   procedure SmoothTrace(const RawTrace : TDyn2DDoubleArr; var SmoothedTrace : TDyn2DDoubleArr); {smooths Time Series Plot Traces}
   procedure SubtractBaseLine;
   procedure DivideByBaseLine;
   procedure UpdateYaxis(Sender : TObject);
   procedure UpdateXaxis(Sender : TObject);


End;
 {----------------------------------------------------------------------}
Const
  PlXbeg        : integer =  50;
  PlYbeg        : integer = 250;     {beg and End of Plot Traces(in Pix)}
  PlYend        : integer =  50;

  PlXaxBeg      : integer =  49;
  PlYaxBeg      : integer = 251;     {beg and End of Plot Axes(in Pix)}
  PlYaxEnd      : integer =  49;

  Yplot         : integer = 200;     {Plot window for Traces in Pix }
  PlotWinYsize  : integer = 300;     {Total Window (Timage) Y size }

  ScaleRat      : integer = 10;     {multiplies Ratio by 10 to get it to 200 max}

  VCurHlfWidth  : integer = 5;      {half witdh of vertical Cursor}
  VCurLineHlfWidth : integer = 10;


Type
  TTimeSerPlotSliders = Packed Record
  {memorizes Time Series Plot Settings in "par" File}
  YtopRatOff        : LongInt;
  YtopRatOn         : LongInt;
  YbotRatOff        : LongInt;
  YbotRatOn         : LongInt;
  YmaxRatOn         : LongInt;
  WinXSize          : LongInt;
  PeakThresh        : LongInt; {TimPltSlid.PeakThresh = frmTimeSerPlot.scrbPeakThresh.Position}
  SymbFromTableCol  : LongWord; {Color Used To Draw Symbol from Table}
  SymbSize          : Word;    {Size of Symbol for All Traces = +- Center Point}
  AreaMinPoints     : Word;    {memorizes Area/min -> points to get the min}
  BaseLinePoints    : Word;    {Points of Window That Creates Baseline = Points of the Longest Event}
  EachPeakBasePt    : Word;    {Points to Find Separate Baseline For each peak}
  EachPeakBaseRg    : Word;    {range (before peak) in ms to Find Min = Baseline for each peak}
  CurVal            : Double;   {Horiz Cursor Real Value Pixel}
  LSD               : Double;
  RSD               : Double;  {Memorizes LSD and RSD Edit Numerical in Par File}
  FcGaussFlt        : Double; //memorizes the Fc for the Gaussian Filter
  TimeSerAnalMode   : Byte;    {Memorizes Index of CmboBox cbTimeSerAnalMode- Area, Ratio , etc.}
  SmTrBoxcarIndex   : Byte;    {Index of cbSmTrFltSize for Trace (time) Boxcar Smoothing Filter size}
  SmTrGaussIndex    : Byte;    {Index of cbSmTrFltSize for Trace (time) Gauss Smoothing Filter size}
  SmTrGaussFcIndex  : Byte;    {Index of None of Rc for Trace (time) Gauss Smoothing Filter size with Fc inputed}
  SmTrKalmanIndex   : Byte;    {Index of cbSmTrFltSize for Trace (time) Gauss Smoothing Filter size}
  SmTraceKind       : Byte;    {Index of cbSmTraceKind for Trace (time) Kind of Smoothing (Boxcar, Gauss or Kalman}
  BaseLineOption    : Byte;    {memorizes the Index of CategoryButtons (starting from 0}
  NrPassesIndex     : Byte;    {memorizes the Index of Number of Passes to get continuos baseline}
  shrFact           : Byte;    {memorizes shrFact used}
  SymbOn            : Boolean; {if Symbol should be plotted on traces}
  TraceDivMin       : Boolean; {if Area/Min is checked}
  CursorOn          : Boolean; {if Cursor is On = Horizontal Ruler is enabled}
  GetPeaks          : Boolean; {if Get Peaks is checked}
  MeasTraceDown     : Boolean; {if Measuring Vertical Cursor is enabled}
  SpaceHolder       : Boolean;    {Use to be Use2DFilter: to Use 2D filter for PIX/PIX to be used for traces. Removed March 7, 2016}
  AlwaysUseSymb     : Boolean; {Applies to Traces Triggered by Table}
  GetEachPeakBase   : Boolean; {Gets baseline for each pek by searching for Min
                                in Defined range before Peak by Averaging Deg=fined Nr Points}



 End;

Var
  frmTimeSerPlot  : TfrmTimeSerPlot;
  Yrange          : integer;
  Xrange          : integer;
  Yscale          : double;
  Xscale          : double;
  TimeSerAnalDone : Boolean;  {if time series analysis has been done}
  TimPltSlid      : TTimeSerPlotSliders; {Some Plot variable: mainly sliders}
  SelBeg          : integer; {slections done by the mouse for analysis}
  SelEnd          : integer;
  PrevPt          : integer; {Used for Mouse Operations}


implementation
  Uses unMainWindow, unImageControl, Main, unSPautoSearch,
  unPeaks, unSlaveTSPlot, unPlayBack, unHistogram, DigiFilters,unFunctions,
  unAverIm;


{$R *.dfm}

{*****************************************************************************}


/////////  Beg of Y axes //////////////////////////////////////
procedure TfrmTimeSerPlot.dsYaxesChange(Sender: TObject);
begin

      If Not(PLOTvar.AnalType in [RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then Begin
        TimPltSlid.YbotRatOff := dsYaxes.PosFrom;
        TimPltSlid.YtopRatOff := dsYaxes.PosTo;
        Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
        enYbottom.Max := dsYaxes.PosTo - dsYaxes.Delta;
        enYtop.Min := dsYaxes.PosFrom + dsYaxes.Delta;
        enYbottom.NumberOne := dsYaxes.PosFrom;
        enYTop.NumberOne := dsYaxes.PosTo;
      End
        else
      If(PLOTvar.AnalType in [RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME])  then begin
        TimPltSlid.YbotRatOn  := dsYaxes.PosFrom;
        TimPltSlid.YtopRatOn  := dsYaxes.PosTo;
        Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
        enYbottom.Max := (dsYaxes.PosTo - dsYaxes.Delta) / 10;
        enYtop.Min    := (dsYaxes.PosFrom + dsYaxes.Delta) / 10;
        enYbottom.NumberFloat := dsYaxes.PosFrom/10;
        enYtop.NumberFloat := dsYaxes.PosTo/10;
      End;

      UpdateYaxis(Sender);

end;

procedure TfrmTimeSerPlot.dsYaxesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if (sbSlavePlot.Down) and (TimeSerAnalDone) then
       frmSlaveTSPlot.DrawPlot(Sender);
end;

procedure TfrmTimeSerPlot.enYbottomReturnPressed(Sender: TObject);
begin
  //Changing PosFrom or PosTo does not Generate dsYaxesChange
  If Not(PLOTvar.AnalType in [RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then Begin
   dsYaxes.PosFrom := enYbottom.NumberOne;
   TimPltSlid.YbotRatOff := dsYaxes.PosFrom;
   Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
  End
    Else
  If (PLOTvar.AnalType in [RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME])  then begin
   dsYaxes.PosFrom := Round(enYbottom.NumberFloat*10);
   TimPltSlid.YbotRatOn  := dsYaxes.PosFrom;
   Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
  End;

  UpdateYaxis(Sender);

end;

procedure TfrmTimeSerPlot.enYtopReturnPressed(Sender: TObject);
begin
 //Changing PosFrom or PosTo does not Generate dsYaxesChange
 If Not(PLOTvar.AnalType in [RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then Begin
   dsYaxes.PosTo := enYtop.NumberOne;
   TimPltSlid.YtopRatOff := dsYaxes.PosTo;
   Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
  End
    Else
  If (PLOTvar.AnalType in [RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME])  then begin
   dsYaxes.PosTo := Round(enYtop.NumberFloat*10);
   TimPltSlid.YtopRatOn  := dsYaxes.PosTo;
   Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
  End;

  UpdateYaxis(Sender);

End;

procedure TfrmTimeSerPlot.UpdateYaxis(Sender : TObject);
begin
  Yscale := Yplot/Yrange;  {Pix per Unit of measurement}
  frmTimeSerPlot.RePlot(Sender);

end;


///////////////// End of Y Axes //////////////////////////////////////////

///////////////// Beg of X Axes //////////////////////////////////////////


procedure TfrmTimeSerPlot.dsXaxesChange(Sender: TObject);
begin

  enXaxes.SetNumbersOneTwo((dsXaxes.PosFrom + 1),(dsXaxes.PosTo + 1));

  Xrange :=  dsXaxes.PosTo - dsXaxes.PosFrom;
  Xscale := (TimPltSlid.WinXSize - PlXbeg)/Xrange;   {Pix per Unit of measurement}

  UpdateXaxis(Sender);

end;

procedure TfrmTimeSerPlot.dsXaxesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (sbSlavePlot.Down) and (TimeSerAnalDone) then
       frmSlaveTSPlot.DrawPlot(Sender);
end;

procedure TfrmTimeSerPlot.enXaxesReturnPressed(Sender: TObject);
begin

  dsXaxes.SetSliderPos(enXaxes.NumberOne-1,enXaxes.NumberTwo-1);

  Xrange :=  dsXaxes.PosTo - dsXaxes.PosFrom;
  Xscale := (TimPltSlid.WinXSize - PlXbeg)/Xrange;   {Pix per Unit of measurement}

  UpdateXaxis(Sender);

end;

procedure TfrmTimeSerPlot.UpdateXaxis(Sender : TObject);
begin

  RePlot(Sender);

end;

///////////////// End of X Axes //////////////////////////////////////////

procedure TfrmTimeSerPlot.dsAnalRangeChange(Sender: TObject);
begin        

     enAnalFromTo.SetNumbersOneTwo(dsAnalRange.PosFrom + 1,dsAnalRange.PosTo + 1);

  if FreezeMean.Down = False Then Begin
     enRangeFromTo.Min       := dsAnalRange.PosFrom + 1;
     enRangeFromTo.Max       := dsAnalRange.PosTo   + 1;
     enRangeFromTo.SetNumbersOneTwo(dsAnalRange.PosFrom + 1,dsAnalRange.PosTo + 1);
  end;
end;

procedure TfrmTimeSerPlot.enAnalFromToReturnPressed(Sender: TObject);
begin
 dsAnalRange.SetSliderPos(enAnalFromTo.NumberOne-1,enAnalFromTo.NumberTwo-1);
 if (FreezeMean.Down = False) Then Begin
  enRangeFromTo.Min       := enAnalFromTo.NumberOne;
  enRangeFromTo.Max       := enAnalFromTo.NumberTwo;
  enRangeFromTo.SetNumbersOneTwo(enAnalFromTo.NumberOne,enAnalFromTo.NumberTwo);
 end;
 //first image starts from Zero - always do -1
end;

procedure TfrmTimeSerPlot.ubCopyRangeFromXaxisClick(Sender: TObject);
begin
  if (enXaxes.NumberOne > 0) and (enXaxes.NumberTwo > 0) and
     (enXaxes.NumberOne < enAnalFromTo.Max - 1) and (enXaxes.NumberTwo <= enAnalFromTo.Max)
  then begin
    enAnalFromTo.SetNumbersOneTwo(enXaxes.NumberOne,enXaxes.NumberTwo);
    enAnalFromToReturnPressed(Sender);
  end;
end;

procedure TfrmTimeSerPlot.enTraceMinPointsReturnPressed(Sender: TObject);
begin
     TimPltSlid.AreaMinPoints := enTraceMinPoints.NumberOne;
end;

procedure TfrmTimeSerPlot.enBaseLinePointsReturnPressed(Sender: TObject);
begin

   if (enBaseLinePoints.NumberOne mod 2 = 0) then
   enBaseLinePoints.NumberOne := enBaseLinePoints.NumberOne - 1;
   TimPltSlid.BaseLinePoints := enBaseLinePoints.NumberOne;  //BaseLine Points
   if PLOTvar.BaseLinePoints <> TimPltSlid.BaseLinePoints then
      PLOTvar.BaseLineStatus := NO_BASELINE;
   lbFinalPoints.Caption := '= ' + IntToStr(GetFinalEventWidth(StrToInt(NrPasses.Items[NrPasses.ItemIndex])));
end;
procedure TfrmTimeSerPlot.enLSDReturnPressed(Sender: TObject);
begin
    TimPltSlid.LSD := enLSD.NumberFloat;
    if PLOTvar.LSD <> enLSD.NumberFloat then
      PLOTvar.BaseLineStatus := NO_BASELINE;
end;


procedure TfrmTimeSerPlot.enRSDReturnPressed(Sender: TObject);
begin
   TimPltSlid.RSD := enRSD.NumberFloat;
   if PLOTvar.RSD <> enRSD.NumberFloat then
     PLOTvar.BaseLineStatus := NO_BASELINE;
end;

{---------------- End of Common for Double ScrollBars Procedure -----------------}


Procedure TfrmTimeSerPlot.SetButtons(FirstTime : Boolean); {creates BMPs for Trace Buttons}
  var
      Xt,Yt,i  : integer; {used to position Numbers on Button BMP}
      ButNr  : AnsiString;
      ButBMP : TBitmap;
  Begin
    ButBMP := TBitmap.Create;
    ButBMP.Width  := 16;
    ButBMP.Height := 16;
    ButBMP.PixelFormat := pf24bit;
    ButBMP.Canvas.Font.Name   := 'Arial Narrow';
    ButBMP.Canvas.Font.Color  := clBlack;
    ButBMP.Canvas.Font.Pitch  := fpVariable;
    ButBMP.Canvas.Font.Size   := 9;
     {First makes Off Bitmaps}
    For i := 1 to 20 Do Begin
      ButBMP.Canvas.Brush.Color := clBtnFace;
      ButBMP.Canvas.Pen.Color := ButBMP.Canvas.Brush.Color;
      ButBMP.Canvas.FillRect(ButBMP.Canvas.ClipRect);
      ButBMP.Canvas.Brush.Style := bsClear; {to make transparent text}
      ButNr := IntToStr(i);
      Xt := ButBMP.Width div 2  - ButBMP.Canvas.TextWidth(ButNr) div 2;
      Yt := ButBMP.Height div 2 - ButBMP.Canvas.TextHeight(ButNr) div 2;
      ButBMP.Canvas.TextOut(Xt,Yt,ButNr);
      if FirstTime = True then
      frmTimeSerPlot.ImageListDisabledButt.Add(ButBMP,nil) else {no mask BMP = nil}
      if FirstTime = False then
      frmTimeSerPlot.ImageListDisabledButt.Replace(i-1,ButBMP,nil);
    End;
     {2nd: makes Enabled-Off Buttons}
    For i := 1 to 20 Do Begin
      ButBMP.Canvas.Brush.Color := clBtnFace;
      ButBMP.Canvas.Pen.Color := ButBMP.Canvas.Brush.Color;
      ButBMP.Canvas.FillRect(ButBMP.Canvas.ClipRect);
      ButBMP.Canvas.Brush.Color := ROIvar.ROICol[i];
      ButBMP.Canvas.Pen.Color := ButBMP.Canvas.Brush.Color;
      ButBMP.Canvas.Ellipse(0,0,16,16); {works with neg values too}
      ButBMP.Canvas.Brush.Style := bsClear; {to make transparent text}
      ButNr := IntToStr(i);
      Xt := ButBMP.Width div 2  - ButBMP.Canvas.TextWidth(ButNr) div 2;
      Yt := ButBMP.Height div 2 - ButBMP.Canvas.TextHeight(ButNr) div 2;
      ButBMP.Canvas.Font.Color  := ROIvar.FontCol[i];
      ButBMP.Canvas.TextOut(Xt,Yt,ButNr);
      if FirstTime = True then
      frmTimeSerPlot.ImageListButOff.Add(ButBMP,nil) else
      if FirstTime = False then
      frmTimeSerPlot.ImageListButOff.Replace(i-1,ButBMP,nil)
    End;
    {3rd: makes Enabled-On Buttons}
    For i := 1 to 20 Do Begin
      ButBMP.Canvas.Brush.Color := ROIvar.ROICol[i];
      ButBMP.Canvas.Pen.Color := ButBMP.Canvas.Brush.Color;
      ButBMP.Canvas.FillRect(ButBMP.Canvas.ClipRect);
      ButBMP.Canvas.Brush.Style := bsClear; {to make transparent text}
      ButNr := IntToStr(i);
      Xt := ButBMP.Width div 2  - ButBMP.Canvas.TextWidth(ButNr) div 2;
      Yt := ButBMP.Height div 2 - ButBMP.Canvas.TextHeight(ButNr) div 2;
      ButBMP.Canvas.Font.Color  := ROIvar.FontCol[i];
      ButBMP.Canvas.TextOut(Xt,Yt,ButNr);
      if FirstTime = True then
      frmTimeSerPlot.ImageListColOnButt.Add(ButBMP,nil) else
      if FirstTime = False then
      frmTimeSerPlot.ImageListColOnButt.Replace(i-1,ButBMP,nil);
    End;
    FreeAndNil(ButBMP);


End;
{*****************************************************************************}
procedure TfrmTimeSerPlot.FormCreate(Sender: TObject);
 var  DummyBMP : TBitmap;
      FirstTime : Boolean;
Begin

 { frmTimeSerPlot.DoubleBuffered  := True; nice but slows the plot}
  FrameTimSerPlot.DoubleBuffered := True; {this does not seem to decrease speed}
  pnAxes.DoubleBuffered := True;

  {since Frame Border can be different [4 in WinXP, 9 in Vista] 1st it sets the
   ClientWidth and ClientHeight and then stores the resulted Widht as
   InitialWidth and sets the Heigth constrains to resulted Height.  Another
   way would be to use SustemMetrics to set the Width and Height to Client sizes
   plus border width and system bar + border height.}

  enThreshForArea.NumberOne := 0; //default setting. Since frmTimeSerPlot never close we don't need to initialize it in Proc. InitVarOnStart
  frmTimeSerPlot.ClientWidth  := 705;
  frmTimeSerPlot.ClientHeight := 497;
  frmTimeSerPlot.Constraints.MaxHeight := frmTimeSerPlot.Height;
  frmTimeSerPlot.Constraints.MinHeight := frmTimeSerPlot.Height;

  DummyBMP := TBitmap.Create;
  DummyBMP.Width := 600;   {Intial Size of UpDownNrWin.Position & TimPltSlid.WinSize}
  DummyBMP.Height := PlotWinYsize;

  {Don't go above 6000 x 300 pixels}
 // FrameTimSerPlot.imgTimeSerPlot.Width  := 600; {Always 600}
  FrameTimSerPlot.imgTimeSerPlot.Height := PlotWinYsize;
  FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(DummyBMP);
  FreeAndNil(DummyBMP);
  FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Color := clBlack;
  FrameTimSerPlot.imgTimeSerPlot.Canvas.FloodFill(0,0,clblack,fsBorder);
  FrameTimSerPlot.imgTimeSerPlot.Canvas.Font.Name := 'Arial';
  FrameTimSerPlot.imgTimeSerPlot.Canvas.Font.Size := 8;

  {--------- Makes BMP for Buttons}
  FirstTime := True;
  SetButtons(FirstTime);
  {end of Making Buttons}

  {--- Starts Initialising from SparkAn.par -----}

      enTraceMinPoints.NumberOne := TimPltSlid.AreaMinPoints;
      scrbPeakThresh.Position   := TimPltSlid.PeakThresh;
      cbSmTraceKind.ItemIndex   := TimPltSlid.SmTraceKind;
      cbSmTraceKindChange(Sender); //this initializes SmTrBoxcarIndex  or  SmTrGaussIndex
      CheckBoxSymbolOn.Checked  := TimPltSlid.SymbOn;
      cbTraceDivMin.Checked     := TimPltSlid.TraceDivMin;
      CheckBoxCursor.Checked    := TimPltSlid.CursorOn;
      cbGetPeaks.Checked        := TimPltSlid.GetPeaks;
      MeasTrace.Down            := TimPltSlid.MeasTraceDown;
      TraceSel.Enabled          := False; {always False}
      enFcGaussFlt.NumberFloat  := TimPltSlid.FcGaussFlt;

      with TimPltSlid do begin
        if (BaseLineOption = NO_BASELINE)         then ubWithoutBaseline.Selected  := True else
        if (BaseLineOption = GET_BASELINE)        then ubGetBaseline.Selected      := True else
        if (BaseLineOption = SUBTRACT_BASELINE)   then unSubtractBaseline.Selected := True else
        if (BaseLineOption = DIVIDE_BY_BASELINE)  then unDivideByBaseline.Selected := True;
        unDivideByBaseline.Enabled := TimPltSlid.TraceDivMin;
      end;

      enBaseLinePoints.NumberOne  := TimPltSlid.BaseLinePoints;
      NrPasses.ItemIndex          := TimPltSlid.NrPassesIndex;
      enLSD.NumberFloat           := TimPltSlid.LSD;
      enRSD.NumberFloat           := TimPltSlid.RSD;
      {Baseline Found Separately for each peak}
      cbGetEachPeakBase.Checked   := TimPltSlid.GetEachPeakBase;
      edEachPeakBasePt.NumberOne  := TimPltSlid.EachPeakBasePt; //Nr of Points to Find Minimum (baseline)
      edEachPeakBaseRg.NumberOne  := TimPltSlid.EachPeakBaseRg;


  {--------- End for SparkAn.par initilising ---------}

  {------------- Sets All the Buttons to Disanbled----}

  DisableAndReleaseTraceButtons;
 
  {------------ ScrollBars ----------------------------------------}
 

  PLOTvar.AnalType      := INTENSITY_TIME;
  SelStart              := False;
  TimPltSlid.WinXSize   := 600;
  LockOnCur             := False;
  SelBeg                := PlXaxBeg;
  TimPltSlid.TimeSerAnalMode := F_div_Fo;
  AnalInAction          := False;
  PLOTvar.Title         := ' ';
  TimeSerPlotHidden     := False;

  dsXaxes.Enabled     := False;
  dsYaxes.Enabled     := False;
  dsAnalrange.Enabled := False;

  dsXaxes.Delta     := 1;
  dsAnalrange.Delta := 2;
  
  dsYaxes.Delta  := 5;
  dsYaxes.Min    := 0;
  dsYaxes.Max    := 255;

  dsXaxes.    DoubleBuffered := True;
  dsAnalrange.DoubleBuffered := True;

  {0 is the top, goes clockwise}
  With FrameTimSerPlot.imgTimeSerPlot do begin
          { Top Left[0] and Rigth[1]}
  VertCursor[0].X := PlXbeg;
  VertCursor[0].Y := 20;

  VertCursor[1].X := PlXbeg + 2*VCurHlfWidth;
  VertCursor[1].Y := VertCursor[0].Y;
          {Tip Triangle L[5] and R[2]}
  VertCursor[2].X := PlXbeg + VCurHlfWidth;
  VertCursor[2].Y := VertCursor[0].Y + 10; {10 = Height of Triangle}

  VertCursor[3].X := PlXbeg + VCurHlfWidth;
  VertCursor[3].Y := PlYbeg;
          {End [bottom) of Cursor L[4] and R[3]}
  VertCursor[4].X := PlXbeg + VCurHlfWidth;
  VertCursor[4].Y := PlYbeg;

  VertCursor[5].X := PlXbeg + VCurHlfWidth;
  VertCursor[5].Y := VertCursor[0].Y + 10;

  {paires: 0 & 1 [top], 2 &5 [top triangle], 3 & 4 [bottom triangle}
  end; {with}

  {limits Lengths of Edit Widgets until a File is Open}
  enTraceMinPoints.MaxLength := length(IntToStr(enTraceMinPoints.NumberOne));
  sbSetRange.Enabled := cbTraceDivMin.Checked;

  TimeSerAnalOpCode := CONVENTIONAL;

End; {procedure TfrmTimeSerPlot.FormCreate}
{****************************************************************************}
procedure TfrmTimeSerPlot.FrameTimSerPlotimgTimeSerPlotMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
  Var
     CursorClipArea : TRect;
     p              : TPoint;
     Xst            : integer;
     BegClip        : Integer;
begin

If (TimeSerAnalDone = True) then begin

  //---------------------------------------//

  LockOnMesCur := False;

If (Button = mbLeft) Then Begin

     if UpDownNrWin.Position = 1 then Xst := PlXAxbeg
     else begin
       Xst := PlXAxbeg - FrameTimSerPlot.HorzScrollBar.ScrollPos;
       if Xst < 0 then Xst := 0;
     end;
End;

  If (Y < PlYend) and
     (Y > VertCursor[1].Y) and (Y < VertCursor[2].Y) and
     (X > VertCursor[0].X) and (X < VertCursor[1].X) then begin


        If (Button = mbLeft) then begin
          LockOnMesCur := True;

          Pr.X := X;

          with CursorClipArea do begin
          p := ClientToScreen(Point(FrameTimSerPlot.Left,
                                    FrameTimSerPlot.Top));
          Left := p.x ;
          Top  := p.y ;
          p :=  ClientToScreen(Point(FrameTimSerPlot.Left +
                                     FrameTimSerPlot.Width,
                                     FrameTimSerPlot.Top + 49)) ;
          Right  := p.x ;
          Bottom := p.y ;
          end ; { with}
        Winapi.Windows.ClipCursor(@CursorClipArea);

        End Else
        
        If (Button = mbRight) then begin
          PopupMenuDeletePeak.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
        end;


  End Else

    {Select region to zoom}
  If (X - FrameTimSerPlot.HorzScrollBar.ScrollPos > Xst) and
     (X - FrameTimSerPlot.HorzScrollBar.ScrollPos < FrameTimSerPlot.Width) and
     (Y > PlYend) and (Y < PlYbeg) and (Button = mbLeft) then begin
       {Uses Windows API to restrict Cursor}

     if LockOnCur = False then BegClip := X - FrameTimSerPlot.HorzScrollBar.ScrollPos + 1 else
     if LockOnCur = True  then BegClip := Xst;

     CursorClipArea :=
     Bounds(FrameTimSerPlot.ClientOrigin.X + BegClip + 1,
            FrameTimSerPlot.ClientOrigin.Y + PlYend+1,
            FrameTimSerPlot.ClientOrigin.X +
            (FrameTimSerPlot.Width - BegClip-1 -
             FrameTimSerPlot.ClientOrigin.X),
             FrameTimSerPlot.ClientOrigin.Y +
            (200 - FrameTimSerPlot.ClientOrigin.Y-1));

     Winapi.Windows.ClipCursor(@CursorClipArea);
     {-----------------------------------------}
       FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Mode  := pmXOR;

     If (LockOnCur = True) Then Begin
        FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Color := RGB(150,150,150);
      if (MeasTrace.Down) then Begin
        with FrameTimSerPlot.imgTimeSerPlot.Canvas do begin
        FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(PlotMemBMP);
        MoveTo(PlXbeg,PLOTvar.CurPix);
        LineTo(TimPltSlid.WinXSize,PLOTvar.CurPix); {deletes the Line}
        PlotMemBMP.Assign(FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap);
        MoveTo(PlXbeg,PLOTvar.CurPix);
        LineTo(TimPltSlid.WinXSize,PLOTvar.CurPix); {drowes the Line}
        end;

        if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);

      end;

        FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Color := RGB(150,150,150);
        with FrameTimSerPlot do begin
        lblCursorVal.Caption := FloatToStrF(((PlYbeg - Y)/Yscale + dsYaxes.PosFrom)/10,ffFixed,3,2);
        if X + lblCursorVal.Width + 10 - HorzScrollBar.ScrollPos < Width then
        lblCursorVal.Left := X + 10 - HorzScrollBar.ScrollPos else
        lblCursorVal.Left := X - 10 - lblCursorVal.Width - HorzScrollBar.ScrollPos;
        lblCursorVal.Top  := Y - 8;
        FrameTimSerPlot.lblCursorVal.Visible := True;
        end; {with}
     End
      Else
     Begin {Deals with the Select Part of Trace-------}
      PlotMemBMP.Assign(FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap);
      SelBeg := X;
      PrevPt := SelBeg;
      SelStart := True;
      FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Color := RGB(0,255,255); //Cyan
      FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(PrevPt,51);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(X+1,51);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(PrevPt,249);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(X+1,249);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(PrevPt,51);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(PrevPt,249);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(X+1,51);
      FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(X+1,249);
     End;  {Else}
  End; { If (X > PlXbeg) and (X < FrameTimSerPlot.Width) and (Y > PlYend) and (Y < PlYbeg)}

 End; { If (TimeSerAnalDone = True) and (Button = mbLeft)}
End; { Procedure FrameTimSerPlotimgTimeSerPlotMouseDown }
{****************************************************************************}
procedure TfrmTimeSerPlot.FrameTimSerPlotimgTimeSerPlotMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);  {selects something}
   var  
        dXpr, i : integer;
        ImNr         : integer;
        Xst          : integer;
begin

If (TimeSerAnalDone = True) then Begin
//Measuring Cursor//
  If (LockOnMesCur = True) then Begin
    dXpr := (X - Pr.X);
    if (VertCursor[2].X + dXpr > PlXaxBeg) then Begin
      for i := 0 to 5 do VertCursor[i].X := VertCursor[i].X + dXpr;
      with FrameTimSerPlot.imgTimeSerPlot.Canvas do CopyRect(ClipRect,PlotMemBMP.Canvas,ClipRect);

      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);

    End; //If DoDraw = True//
    Pr.X := X;
  End; //(LockOnMesCur = True)//

       //--------- This is the Horizontal Cursor Part ------//
     if UpDownNrWin.Position = 1 then Xst := PlXAxbeg
     else begin
       Xst := PlXAxbeg - FrameTimSerPlot.HorzScrollBar.ScrollPos;
       if Xst < 0 then Xst := 0;
     end;

 If (SelStart = False) and
     (X - FrameTimSerPlot.HorzScrollBar.ScrollPos > Xst) and
     (X - FrameTimSerPlot.HorzScrollBar.ScrollPos < FrameTimSerPlot.Width)
     and (Y > PlYend) and (Y < PlYbeg)
  Then Begin
      FrameTimSerPlot.lblCursorVal.Visible := True;

  If  Not(ssLeft in Shift)  then Begin
   If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then Begin
      If (Y <= PLOTvar.CurPix + 10) and (Y >= PLOTvar.CurPix - 10) and
       (CheckBoxCursor.Checked = True)then begin
        FrameTimSerPlot.imgTimeSerPlot.Cursor := crSizeNS;
        LockOnCur := True;
      End else begin
        FrameTimSerPlot.imgTimeSerPlot.Cursor := crArrow;
        LockOnCur := False;
      End;
    End; //(PLOTvar.RatOn = True)//
      with FrameTimSerPlot do begin
      ImNr := round((X - PlXBeg)/Xscale) + frmTimeSerPlot.dsXaxes.PosFrom;
      if ImNr > NrIm - 1 then ImNr := NrIm - 1;
      lblCursorVal.Caption := IntToStr(ImNr + 1) + ' im';
      if X + lblCursorVal.Width + 10 - HorzScrollBar.ScrollPos < Width then
      lblCursorVal.Left := X + 10 - HorzScrollBar.ScrollPos else
      lblCursorVal.Left := X - 10 - lblCursorVal.Width - HorzScrollBar.ScrollPos;
      lblCursorVal.Top  := Y - 8;
      end;
  End else

  If (ssLeft in Shift) and (LockOnCur = True ) and (CheckBoxCursor.Checked = True)
            Then Begin

       With FrameTimSerPlot.imgTimeSerPlot.Canvas do begin
          FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Mode  := pmXOR;
          MoveTo(PlXbeg,PLOTvar.CurPix);
          LineTo(TimPltSlid.WinXSize,PLOTvar.CurPix); //deletes the Line//
          MoveTo(PlXbeg,Y);
          LineTo(TimPltSlid.WinXSize,Y);
          PLOTvar.CurPix := Y;
          with FrameTimSerPlot do begin
          lblCursorVal.Caption := FloatToStrF(((PlYbeg - Y)/Yscale + frmTimeSerPlot.dsYaxes.PosFrom)/10,ffFixed,3,2);
          if X + lblCursorVal.Width + 10 - HorzScrollBar.ScrollPos < Width then
          lblCursorVal.Left := X + 10 - HorzScrollBar.ScrollPos else
          lblCursorVal.Left := X - 10 - lblCursorVal.Width - HorzScrollBar.ScrollPos;
          lblCursorVal.Top  := Y - 8;
          end;
       End;  //with
    End;  //ssLeft in Shift
  End
    Else  //Detection of Cursor
  If (X - FrameTimSerPlot.HorzScrollBar.ScrollPos < Xst) or
     (X - FrameTimSerPlot.HorzScrollBar.ScrollPos > FrameTimSerPlot.Width) or
     (Y < PlYend) or (Y > PlYbeg) then Begin
      LockOnCur := False;
      FrameTimSerPlot.imgTimeSerPlot.Cursor := crArrow;      
      FrameTimSerPlot.lblCursorVal.Visible := False;
  End;
   //--------------- This is the Select Portion of Screen Paragraph//
  If (SelStart = True) and (X > SelBeg) and (LockOnCur = False)  Then Begin
    FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(PrevPt,51);
    FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(X,51);
    FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(PrevPt,249);
    FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(X,249);
    FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(PrevPt,51);
    FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(PrevPt,249);
    FrameTimSerPlot.imgTimeSerPlot.Canvas.MoveTo(X,51);              
    FrameTimSerPlot.imgTimeSerPlot.Canvas.LineTo(X,249);
    PrevPt := X;
    ImNr := round((X - PlXBeg)/Xscale) + frmTimeSerPlot.dsXaxes.PosFrom;
    with FrameTimSerPlot do begin
    if ImNr > NrIm - 1 then ImNr := NrIm - 1;
    lblCursorVal.Caption := IntToStr(ImNr + 1) + ' im';
    if X + lblCursorVal.Width + 10 - HorzScrollBar.ScrollPos < Width then
    lblCursorVal.Left := X + 10 - HorzScrollBar.ScrollPos else
    lblCursorVal.Left := X - 10 - lblCursorVal.Width - HorzScrollBar.ScrollPos;
    lblCursorVal.Top  := Y - 8;
    end;
  End;

End; {If (TimeSerAnalDone = True)}

End; {procedure TfrmTimeSerPlot.FrameTimSerPlotimgTimeSerPlotMouseMove}
{***************************************************************************}

procedure TfrmTimeSerPlot.FrameTimSerPlotimgTimeSerPlotMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
  Var  Temp,PosFrom, PosTo : Integer;
       MeasTrace_Down : Boolean;
begin


  if (TimeSerAnalDone = True) then begin
          Winapi.Windows.ClipCursor(NIL);  {Removes Cursor Restrictions}
          FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Mode  := pmCopy;
    If LockOnMesCur = True then Begin
      LockOnMesCur := False;
    End else

    {Horizontal Cursor}
    If (LockOnCur = True ) Then Begin
        TimPltSlid.CurVal := (PlYbeg - PLOTvar.CurPix)/Yscale + frmTimeSerPlot.dsYaxes.PosFrom;
        Temp := round(TimPltSlid.CurVal*10); {rounds to 1 digit after Dec Point}
        TimPltSlid.CurVal := Temp/10;;
        if (MeasTrace.Down) then Begin
          FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(PlotMemBMP);
          DrawTimeSerPlotCursor;
          PlotMemBMP.Assign(FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap);
         if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
            DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
            DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);
        end;
    End Else

    {Trace Frame [time] Selection}
    If (SelStart = True) Then Begin
      SelEnd := X;
      SelStart := False;

   If SelEnd - SelBeg > 5 then Begin {5 pixels diference minimum}
    {Stores Previous Slider position}
     PLOTvar.UndoRedu[0] := dsXaxes.PosFrom;
     PLOTvar.UndoRedu[1] := dsXaxes.PosTo;
     Redo.Enabled := False;
     UnDo.Enabled := True;

     PosTo   := round((SelEnd-PlXBeg)/Xscale)+ dsXaxes.PosFrom;
     PosFrom := round((SelBeg-PlXBeg)/Xscale)+ dsXaxes.PosFrom;

     if PosTo < PosFrom + dsXaxes.Delta then begin
       PosTo := PosFrom + dsXaxes.Delta;
       if PosTo > dsXaxes.Max then begin
          PosTo := dsXaxes.Max;
          PosFrom := PosTo - dsXaxes.Delta;
       end;
     end;

     if PosFrom >  PosTo - dsXaxes.Delta then begin
        PosFrom := PosTo - dsXaxes.Delta;
     end;
             
     dsXaxes.SetSliderPos(PosFrom,PosTo);
     MeasTrace_Down := MeasTrace.Down;
     if (MeasTrace.Down) then MeasTrace.Down := False;
     dsXaxesChange(Sender);
     PlotMemBMP.Assign(FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap);
     if (MeasTrace_Down) then begin
      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
      frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);
      MeasTrace.Down := MeasTrace_Down;
    end;

     End
      Else
     FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(PlotMemBMP);
     {SelEnd - X > 5} 
   End;{SelStart = True}
  End; {if TimeSerAnalDone = True}
End;  {procedure TfrmTimeSerPlot.FrameTimSerPlotimgTimeSerPlotMouseUp}
{***************************************************************************}
{***** common Procedures Serving in different Analysis modes ***************}
{***** so far Conventional and Diameter measuremens (tracking ***************}
procedure TfrmTimeSerPlot.StartAnalClick(Sender: TObject);

var Beg, ToEnd : Integer;
Begin

If  ROIvar.NrROI > 0 Then Begin
//-----------------------------------------------------------------//
//1st: defines Range of Analysis
  if (dsAnalRange.Enabled) then begin
    Beg   := dsAnalRange.PosFrom;
    ToEnd := dsAnalRange.PosTo;
  end else
  if Not(dsAnalRange.Enabled) then begin
    Beg   := 0;
    ToEnd := NrIm - 1;
    sbSetRange.Down := False;
  end;

  PLOTvar.ImBeg     := Beg;
  PLOTvar.ImEnd     := ToEnd;

// 2nd: Sets All the Buttons Up and Disanbled
  frmTimeSerPlot.StartAnal.Enabled       := False;
  frmTimeSerPlot.InclusiveExclusive.Down := False;
  UnDo.Enabled := False;
  ReDo.Enabled := False;
  DisableAndReleaseTraceButtons;
  if FrameTimSerPlot.lblCursorVal.Visible = True then begin
    FrameTimSerPlot.lblCursorVal.Visible := False;
    Application.ProcessMessages;
  end;

  If Not(TimPltSlid.TraceDivMin) Then Begin
    PLOTvar.AllowFreezeMin := False;
    if FreezeMean.Down = True then FreezeMean.Down := False;
      FreezeMeanClick(sender);
  End;

  StopAnal          := False;
  ProgBarTimSerPlot.Max := (ToEnd - Beg + 1);
  ProgBarTimSerPlot.Visible := True;      

//3rd: Starts the Analysis

  if (TimeSerAnalOpCode = CONVENTIONAL)  then DoConvTimeSeriesAnal(Beg,ToEnd,Sender) else
  if (TimeSerAnalOpCode = DIAM_TRACKING) then TrackDiameterInTime (Beg,ToEnd,Sender);

End; //If  ROIvar.NrROI > 0 Then Begin

End;
{***************************************************************************}
Procedure TfrmTimeSerPlot.SetArraysForTimeSerAnal(Const LengthOfData : Integer);

Begin

 //PLOTvar.NrROI stores ONLY ROIs, ROIvar.NrROI stores Selection Frame if Active
 SetLength(TSPlotData_BaseNotSubtr,PLOTvar.NrROI,LengthOfData);
 SetLength(TSPlotData_BaseSubtr,   PLOTvar.NrROI,LengthOfData);
 SetLength(TSPlotData_BackUp,      PLOTvar.NrROI,LengthOfData);
 if (ChannelsRatioOn) then
  SetLength(TSPlotData_BackUp_ChdivCh, PLOTvar.NrROI,LengthOfData);
 SetLength(TSPlotData_BaseLine,    PLOTvar.NrROI,LengthOfData);
 SetLength(CopyOfTimeSt,LengthOfData);
 if (PLOTvar.TraceDivMinUsed) then SetLength(TSPlotData_Area,PLOTvar.NrROI,LengthOfData)
 else TSPlotData_Area := nil;


End;
{***************************************************************************}

Procedure TfrmTimeSerPlot.FinalizeTimeSerAnal(Sender : TObject);
  Var Cnt,ImNr : Integer;
      SD : Double;
Begin

   lbImNum.Caption := '';
   ProgBarTimSerPlot.Visible  := False;
   ProgBarTimSerPlot.Position := 0;

   dsXaxes.Enabled   := dsAnalRange.Enabled;
   enXaxes.HideText  := False;
   enXaxes.Enabled   := dsXaxes.Enabled;
   enXaxes.MaxLength := Length(IntToStr(NrIm))*2 + 1;

   dsXaxes.SetSlider(PLOTvar.ImBeg,PLOTvar.ImEnd,PLOTvar.ImBeg,PLOTvar.ImEnd);

   if (dsAnalRange.Enabled) then begin
     enXaxes.Min  := dsXaxes.Min + 1;
     enXaxes.Max  := dsXaxes.Max + 1;
   end else
   if Not(dsAnalRange.Enabled) then begin
      enXaxes.Enabled  := False;
   end;

   Xrange :=  dsXaxes.PosTo - dsXaxes.PosFrom;
   enXaxes.SetNumbersOneTwo(PLOTvar.ImBeg + 1,PLOTvar.ImEnd + 1);

   Xscale := (TimPltSlid.WinXSize - PlXbeg)/Xrange;   {Pix per Unit of measurement}

   btGetPeeks.Enabled := True;

   with PLOTvar do
   for ImNr := ImBeg to ImEnd do CopyOfTimeSt[ImNr-ImBeg] := TimeSt[ImNr]; {copies Time Stamps}

   // For Intensity vs. Time or Intensity/min versus Time}
   If (PLOTvar.TraceDivMinUsed) then Begin   //RatioOn = False//
    if Not(FreezeMean.Down) and (TimPltSlid.TraceDivMin) then CheckAreaMinPoints(Sender);
    GetAreaDivMinOrArea(Sender);
    //GetAreaDivMinOrArea copies Data to TSPlotData_BackUp at the End//
   End

    Else

   If Not(PLOTvar.TraceDivMinUsed) then Begin   //RatioOn = True
    {Copies to BackUp Array}
    for Cnt := 0 to PLOTvar.NrROI -1 do begin
      for ImNr := 0 to High(TSPlotData_BackUp[0]) do
      TSPlotData_BackUp[Cnt,ImNr] := TSPlotData_BaseNotSubtr[Cnt,ImNr];
    end;
    //backs up Ch_div_Ch ratio data
    if (PLOTvar.AnalType in[Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then begin
      for Cnt := 0 to PLOTvar.NrROI -1 do begin
        for ImNr := 0 to High(TSPlotData_BackUp[0]) do
        TSPlotData_BackUp_ChdivCh[Cnt,ImNr] := TSPlotData_BaseNotSubtr[Cnt,ImNr];
      end;
      if (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then begin
        for Cnt := 0 to PLOTvar.NrROI -1 do begin
          for ImNr := 0 to High(TSPlotData_BackUp[0]) do begin
            TSPlotData_BackUp[Cnt,ImNr] := TSPlotData_BackUp[Cnt,ImNr]*ScaleRat;
            TSPlotData_BaseNotSubtr[Cnt,ImNr] := TSPlotData_BackUp[Cnt,ImNr];
          end;
        end;
      end
        else
      if (PLOTvar.AnalType = Ca_CONC_TIME) then begin
        for Cnt := 0 to PLOTvar.NrROI -1 do begin
          for ImNr := 0 to High(TSPlotData_BackUp[0]) do begin
            with HillEquationParams do begin //converts to Ca µM
            //Calcium (µM) = (   (IC50^HillSlope)/((MaxR-MinR)/(ChRatio-MinR)-1)     )^(1/HillSlope);
            //ImDataRat[PixPos] := Power((Power(IC50,HillSlope))/((MaxRatio-MinRatio)/(ImDataRat[PixPos]-MinRatio)-1),(1/HillSlope));
              TSPlotData_BackUp[Cnt,ImNr] := TSPlotData_BackUp_ChdivCh[Cnt,ImNr] - MinRatio;
              if (TSPlotData_BackUp[Cnt,ImNr] > 0) and (TSPlotData_BackUp[Cnt,ImNr] < Span) then
              TSPlotData_BackUp[Cnt,ImNr] := (Power((Power(IC50,HillSlope))/(Span/TSPlotData_BackUp[Cnt,ImNr]-1),(1/HillSlope)))
                else
              if (TSPlotData_BackUp[Cnt,ImNr] <= 0) then TSPlotData_BackUp[Cnt,ImNr] := MinCa
                else
              if (TSPlotData_BackUp[Cnt,ImNr] >= Span) then TSPlotData_BackUp[Cnt,ImNr] := SaturCa;
              TSPlotData_BackUp[Cnt,ImNr] := TSPlotData_BackUp[Cnt,ImNr]*ScaleRat;
              //function Power(const Base, Exponent: Double): Double; overload;
            end; //with HillEquationParams do begin
            TSPlotData_BaseNotSubtr[Cnt,ImNr] := TSPlotData_BackUp[Cnt,ImNr];
          end; //for
        end; //for
      end; //if (PLOTvar.AnalType = Ca_CONC_TIME) then begin
    end;
   End;

   {Does the Smoothing in Time if selected}
   if (cbSmTraceFltSize.ItemIndex > 0) then begin
    if (cbSmTraceKind.ItemIndex = GAUSS1D_Fc) then  ResetGaussCoeff;
    SmoothTrace(TSPlotData_BackUp,TSPlotData_BaseNotSubtr);
   end;
      //memorize in PLOTvar//
   PLOTvar.SmTraceKind := cbSmTraceKind.ItemIndex;
   if (PLOTvar.SmTraceKind = BOXCART1D) then
    PLOTvar.SmTrBoxcarIndex := cbSmTraceFltSize.ItemIndex else
   if (PLOTvar.SmTraceKind = GAUSS1D) then
    PLOTvar.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex else
   if (PLOTvar.SmTraceKind = GAUSS1D_Fc) then begin
    PLOTvar.FcGaussFlt := TimPltSlid.FcGaussFlt;
    PLOTvar.SmTrGaussFcIndex := cbSmTraceFltSize.ItemIndex;
   end else
   if (PLOTvar.SmTraceKind = KALMAN1D) then
    PLOTvar.SmTrKalmanIndex := cbSmTraceFltSize.ItemIndex;

   //Create a Baseline if Selected//
   If (TimPltSlid.BaseLineOption in [GET_BASELINE,SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) Then Begin
      GetBaseLine(TSPlotData_BaseNotSubtr,TSPlotData_BaseLine); //always get it - needed for Secondary Plot
      if (TimPltSlid.BaseLineOption = SUBTRACT_BASELINE) then  SubtractBaseLine
        else
      if (TimPltSlid.BaseLineOption = DIVIDE_BY_BASELINE) then DivideByBaseline;
   End;
   //memorizes what has been done in PLOTvar.BaseLineStatus

   PLOTvar.BaseLineStatus := TimPltSlid.BaseLineOption;
   PLOTvar.BaseLinePoints := TimPltSlid.BaseLinePoints;
   PLOTvar.LSD := enLSD.NumberFloat;
   PLOTvar.RSD := enRSD.NumberFloat;
   PLOTvar.MovFType := MovFType;
   if (PLOTvar.MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then
        PLOTvar.MovieSeriesType := MovieSeriesType;
   if (PLOTvar.MovFType = ANDOR_MOV) then PLOTvar.DimNotTime := DimNotTime;

   if (PLOTvar.AnalType = RATIO_TIME) or (PLOTvar.AnalType = INTENSITY) then
    RatTitle.Caption := '(F-Fo)/Fo'
    else
   if (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then begin
      if (ChannelOrder = ASCENDING)   then RatTitle.Caption := 'Ch1/Ch2' else
      if (ChannelOrder = DESCENDING)  then RatTitle.Caption := 'Ch2/Ch1';
   end
    else
   if (PLOTvar.AnalType = Ca_CONC_TIME) then RatTitle.Caption := 'µM Ca';

    //Gest Peeks if Checked//
   if (cbGetPeaks.Checked) and (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then begin
       if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
       GetPeaks(TSPlotData_BaseSubtr) else
       GetPeaks(TSPlotData_BaseNotSubtr);
   end
    else
   begin
      PeakPosArr      := nil;
      PeakValArr      := nil;
      PeakTimArr      := nil;
      PLOTvar.HasPeaks := False;
      if (Sender = StartAnal) then begin
       //Sender could  be SparkTables and then PeakFakeImNrArr used to Plot Should Not be Nilled !!! //
        PeakFakeImNrArr := nil;
       if (frmPeaks <> nil) then frmPeaks.ClearPeakTable;
      end; //if (Sender = StartAnal)
   end; // End of Get Peeks//
     

   SetPlotTitle;
   frmTimeSerPlot.Caption := 'Time Series Plot' + ' from file: ' + PLOT_FTitle;
   TimeSerAnalDone := True;
   ShowAllTracesClick(Sender);
   if (sbSlavePlot.Down) then frmSlaveTSPlot.DrawPlot(Sender); 
    {it activates also DrawTimeSerPlotTraces; and Draw Cursor}

   AnalInAction    := False;
   ROIvar.TickLine := 0; {means plot done}
   frmTimeSerPlot.StartAnal.Enabled := True;
   UpDownNrWin.Enabled := True;

   //Sends message to frmHistogram
   if (frmTimeHistograms <> nil) then begin
    if (frmTimeHistograms.rbPlot.Checked) then frmTimeHistograms.GetMessageFromSeriesPlot;

   end;

End;

{***************************************************************************}
procedure TfrmTimeSerPlot.TrackDiameterInTime(var Beg, ToEnd : integer; Sender: TObject);
var ImNr : Integer;

    procedure GetDiamMaxForYaxes;
      var DiamMax : Double;
          CntIm   : Integer;
    begin
      DiamMax := 0;
      for CntIm := 0 to High(TSPlotData_BaseNotSubtr) do begin
        if (DiamMax < TSPlotData_BaseNotSubtr[0,CntIm]) then DiamMax := TSPlotData_BaseNotSubtr[0,CntIm];
      end;
      SetYAxes(False,0,Round(2*DiamMax),0,Round(2*DiamMax));
    end;


Begin

  PLOTvar.TraceDivMinUsed := False;
  PLOTvar.NrROI := 1;  // Here PLOTvar.NrROI <> ROIvar.NrROI
  PLOTvar.AdrUsed[0] := 1;// stores Color to be Used;
  SetArraysForTimeSerAnal(ToEnd - Beg + 1);

  AnalInAction := True;

with frmPlayback.PlaybackScrollBar do begin

   For ImNr := Beg to ToEnd Do Begin  {Counts Images}
    Position := ImNr;
    Application.ProcessMessages;  // needed to Update Im Number and Diameter Size
    
    If (StopAnal = True) and (ImNr-Beg >= dsAnalRange.Delta) Then Begin
      ToEnd         := ImNr - 1;
      PLOTvar.ImEnd := ToEnd;   //stores last analyzed image and Clips SerPlot Dta arrays
      SetArraysForTimeSerAnal(ToEnd - Beg + 1);
      Break;
    End;

    TrackDiameter;

    with MesLine do
    TSPlotData_BaseNotSubtr[0,ImNr-Beg] := GetDistance(LineBeg.X,LineBeg.Y,LineEnd.X,LineEnd.Y);
    frmPlayback.lblROIval.Caption := FloatToStrF(TSPlotData_BaseNotSubtr[0,ImNr-Beg],ffFixed,5,2)+ ' µ';

    ProgBarTimSerPlot.Position := ImNr - Beg + 1;
    lbImNum.Caption            := IntToStr(ImNr + 1);
   End; //For ImNr := Beg to ToEnd Do Begin
End; //With frmPlayback.PlaybackScrollBar

   GetDiamMaxForYaxes;
   FinalizeTimeSerAnal(Sender);


End; // procedure MeasureDiameter

{***************************************************************************}
procedure TfrmTimeSerPlot.DoConvTimeSeriesAnal(var Beg, ToEnd : integer; Sender: TObject);

Const DO_NOT_SMOOTH       = 0;
      SMOOTH_BEFORE_RATIO = 1;
      SMOOTH_AFTER_RATIO  = 2;
      SMOOTH_NON_RATIO    = 3;
Var
      ImNr, CntROI, i   : Integer;
      MinTraceVal       : Double;
      SumPt             : Double;
      Cnt               : Integer;
      KindROI           : Integer;
      CntX,CntY, NrElem : Integer;
      MeanFh            : Double;
      MeanAvIm          : Double;
      bXs,bYs           : integer;
      Filtering         : Integer;
      SmoothBorder      : Boolean;
      UseReadImForAnal  : Boolean;
      RawByteArr        : TDynByteArray;
      RawWordArr        : TDynWordArray;
      WordArrA          : TDynWordArray;
      WordArrB          : TDynWordArray;

      RawDoubleArr, DoubleArrA, DoubleArrB: TDynDoubleArray;

      Offsets           : TDynLongIntArray;
      SortArr           : Array of Byte;
      NrPix             : TDynLongIntArray;

      XLL,Xrr,Yupp,Ydd  : Integer;
      XLLrat,Xrrrat,YuppRat,YddRat  : Integer;
      Xdim,Ydim         : Integer;
      SmBoxOffset       : integer;
      SmMedOffset       : integer;
      SmGaussOffset     : Integer;

      {KindROI: if 1 then Box, If 2 then Circle, If 3 Then Free hand}

BEGIN


    if Sender = frmTimeSerPlot.StartAnal then PLOTvar.ImNrFromTable := -1; {resets}

        AnalInAction := True;


  {----------------- Sets Sliders in frmTimeSerPlot ------------------------------}
  {1st: Y axes sliders }
  PLOTvar.shrFact := shrFact;
  SetYAxes(TimPltSlid.TraceDivMin,0,0,0,0);
  PLOTvar.ChannelOrderUsed := ChannelOrder; //Used Only if (ChannelsRatioOn = True)

  {- 2nd : Sets X positions -------------------------------------------------------}

  TimeSerAnalDone   := False;

{determine how to deal with smoothing}

If (SmoothMode > NO_SMOOTH) Then Begin
  if (RatioOn) and (AutoSearchPar.SmoothBeforeDoRatio) then
    Filtering := SMOOTH_BEFORE_RATIO
      else
  if ((RatioOn) and not(AutoSearchPar.SmoothBeforeDoRatio)) or (ChannelsRatioOn) then
    Filtering := SMOOTH_AFTER_RATIO
      else
  if not(RatioOn)and not(ChannelsRatioOn) and (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) then
    Filtering := SMOOTH_NON_RATIO
      else
    Filtering := DO_NOT_SMOOTH;
End
  else
If (SmoothMode = NO_SMOOTH) Then
    Filtering := DO_NOT_SMOOTH;

 {Sets Offset for Smoothing (smooths only the ROIs and 1/2 Smooth Box or Med around them}
If (Filtering > DO_NOT_SMOOTH) Then Begin
  SmoothBorder := False;
  GetOffsetFor2DSmoothing(SmBoxOffset,SmMedOffset,SmGaussOffset);
End; {End of Setting Offset for Smoothing}


{------- Fills in Some PLOTvar-----------------}

       PLOT_FTitle := ImFtitle;
       CntROI     := 0;
 For i := 1 to 20 Do Begin         {Counts ROI's to update PLOTvar.ROIkind}
      if CntROI > ROIvar.NrROI then Break;
      If (ROIvar.ROIAdr[i] > 0) Then Begin
          PLOTvar.ROIkind[CntROI] := ROIvar.ROIAdr[i]; {1=box, 2= circle, 3= Free Hand}
        If ROIvar.ROIAdr[i] <= 2 then begin {Boxes and Circles}
          bXs  := ROIvar.ROICoor[3,i] - ROIvar.ROICoor[1,i] + 1;
          bYs  := ROIvar.ROICoor[4,i] - ROIvar.ROICoor[2,i] + 1;
          PLOTvar.ROIsizeXY[0,CntROI] := bXs;  {X & Y sizes}
          PLOTvar.ROIsizeXY[1,CntROI] := bYs;
          PLOTvar.ROIcentXY[0,CntROI] := bXs div 2 + ROIvar.ROICoor[1,i];  {X & Y centers}
          PLOTvar.ROIcentXY[1,CntROI] := bYs div 2 + ROIvar.ROICoor[2,i];
        End;          
          Inc(CntROI);
      End;  {(ROIvar.ROIAdr[i] > 0)}
 End;

  PLOTvar.NrROI := CntROI;  // PLOTvar.NrROI <> ROIvar.NrROI
  //PLOTvar.NrROI stores ONLY ROIs, ROIvar.NrROI stores Selection Frame if Active

  PLOTvar.TraceDivMinUsed := Not(RatioOn) and Not(ChannelsratioOn);

  SetArraysForTimeSerAnal(ToEnd - Beg + 1);

 { ******* This Part Deals with preparation of Selective Reading From DISC *****
              to ensure faster reading of Only Image Data where ROIs are
                  Does not Apply for Movies Loaded in RAM     }

 { from file of pixels from ROIs only if they are not too many, otherwise is
   better to read the whole image. To Do This then:
   Construct Offsets = all the offsets and Length = Nr of Bytes to be read from file
   Reads the Whole horizontal line in the Image that is covered by ROI}

If ((FileInRAM) and Not(ChannelsRatioOn)) Or Not(FileInRAM) Then Begin

 If (FileInRAM) Then Begin
  UseReadImForAnal := True;
 End

  Else

 If Not(FileInRAM) Then Begin //Reading From Disc

  If  (MovFType in[BIORAD_PIC,StreamPix_MOV,NORAN_SGI_MOV,NIKON_ND2_MOV,ZEISS_CZI_LSM_MOV]) Or
     ((MovFType in[ANDOR_MOV,SINGLE_BW_TIFF,STACK_BW_TIFF,NORAN_PRARIE_MOV,NIKON_TIFF_MOV,QED_MOV]) and (High(StripOffs) = 0))
  Then Begin

 //1st: Fills Arrays with Data
  {Here Yupp and Ydd are used to Memorize First and Last Line}

  CntROI := 0; {Counts Boxes or Other ROIs}
  Cnt    := 0;

  //SortArr is used as a map to Deal with Ovelapping of ROIs
  //Should be = imYsize + 1 in order to deal with last line
  //see: If (SortArr[Cnt] = 0) and (CntX = 1) then Begin ..
  //this would initialize NrPix

  SetLength(SortArr,imYsize + 1);

  for Cnt := 0 to High(SortArr) do SortArr[Cnt] := 0; 

  For i := 1 to 20 Do Begin

      if CntROI > ROIvar.NrROI then Break;

    If (ROIvar.ROIAdr[i] > 0) Then Begin
        Inc(CntROI);
          //- Does the Job --//
       //for Boxes//
      If (ROIvar.ROIAdr[i] = 1) then Begin
        XLL  := ROIvar.ROICoor[1,i];
        Yupp := ROIvar.ROICoor[2,i];
        Xrr  := ROIvar.ROICoor[3,i];
        Ydd  := ROIvar.ROICoor[4,i];
      End Else //If ROIvar.ROIAdr[i] = 1
      If ROIvar.ROIAdr[i] = 3 then Begin //free hand
          XLL  := imXsize - 1; //used to find if SmoothBorder is needed
          Xrr  := 0;           //used to find if SmoothBorder is needed
          Yupp := imYsize - 1; //used to find Top and Bottom Ys of free hand ROI & if SmoothBorder is needed
          Ydd  := 0;           // used to find Top and Bottom Ys of free hand ROI & if SmoothBorder is needed
        For CntY := 0 to High(FhTbl[i]) Do Begin
            //more then one Pixel -> High(FhTbl[i,CntY]) > 0//
          If (High(FhTbl[i,CntY]) > 0) Then Begin
              CntX       := 0;
            While CntX < High(FhTbl[i,CntY]) Do Begin
              if XLL  > FhTbl[i,CntY,CntX].X   then XLL  := FhTbl[i,CntY,CntX].X;
              if Xrr  < FhTbl[i,CntY,CntX+1].X then Xrr  := FhTbl[i,CntY,CntX+1].X;
              if Yupp > FhTbl[i,CntY,CntX].Y   then Yupp := FhTbl[i,CntY,CntX].Y;
              if Ydd  < FhTbl[i,CntY,CntX].Y   then Ydd  := FhTbl[i,CntY,CntX].Y;
              Inc(CntX,2);
            End; //while
          End Else //If (High(FhTbl[i,CntY]) > 0) Then Begin//
           //For One Pixel -> High(FhTbl[i,CntY]) = 0//
          If (High(FhTbl[i,CntY]) = 0) Then Begin
              if XLL  > FhTbl[i,CntY,0].X then XLL  := FhTbl[i,CntY,0].X;
              if Xrr  < FhTbl[i,CntY,0].X then Xrr  := FhTbl[i,CntY,0].X;
              if Yupp > FhTbl[i,CntY,0].Y then Yupp := FhTbl[i,CntY,0].Y;
              if Ydd  < FhTbl[i,CntY,0].Y then Ydd  := FhTbl[i,CntY,0].Y;
          End; // If (High(FhTbl[i,CntY]) = 0)
        End;// For CntY := 0 to High(FhTbl[i])
      End; //If ROIvar.ROIAdr[i] = 3 = Free Hand ROI


       //increases the Range if Filtering is true
       //and Checks if ROI position requires Somoothing of the Border
       // depending on the FiltSize it may not be needed to be done with all
       // the filters but it does it anyway - the array gets overwritten by
       //smoothing procedures if Smoothing Borders was to wide - so no harm//
       
      If (Filtering > DO_NOT_SMOOTH) Then Begin
        if SmoothMode in [SMOOTH_BOX,SMOOTH_BOX_MED] then begin
          if not(SmoothBorder) then begin
            if (Xll < SmBoxOffset) or (Yupp < SmBoxOffset) or
               (Xrr + SmBoxOffset  > imXsize-1) or
               (Yupp + SmBoxOffset > imYsize-1) then
            SmoothBorder := True;
          end;
          Yupp := Yupp - SmBoxOffset;
          Ydd  := Ydd  + SmBoxOffset;
        end else
        if SmoothMode in [SMOOTH_MED,SMOOTH_MED_BOX,SMOOTH_MED_GAUSS] then begin
          if not(SmoothBorder) then begin
            if (Xll < SmMedOffset) or (Yupp < SmMedOffset) or
               (Xrr + SmMedOffset  > imXsize-1) or
               (Yupp + SmMedOffset > imYsize-1) then
            SmoothBorder := True;
          end;
          Yupp := Yupp - SmMedOffset;
          Ydd  := Ydd  + SmMedOffset;
        end else
        if SmoothMode in [SMOOTH_GAUSS,SMOOTH_GAUSS_MED] then begin
          if not(SmoothBorder) then begin
            if (Xll < SmGaussOffset) or (Yupp < SmGaussOffset) or
               (Xrr + SmGaussOffset  > imXsize-1) or
               (Yupp + SmGaussOffset > imYsize-1) then
            SmoothBorder := True;
          end;
          Yupp := Yupp - SmGaussOffset;
          Ydd  := Ydd  + SmGaussOffset;
        end;

          if Yupp < 0 then Yupp := 0;
          if Ydd  > (imYsize-1) then Ydd := imYsize-1;
      End; //(Filtering > DO_NOT_SMOOTH)
       //Does the Job//
      FOR CntY := Yupp to Ydd DO SortArr[CntY] := 1; //Marks the Range

     //------------------ End with the Job -------------------------//

    End; //If (ROIvar.ROIAdr[i] > 0)
  End; // For i := 1 to 20 Do Begin


  {2nd: Fills Odffsets and Nr Pix Arrays & Deals with overlapping of ROIs which
        could be a problem if swapping is needed or to be unneccessary work}
  
      SetLength(Offsets,PLOTvar.NrROI); //Initially set to all Used ROIs
      SetLength(NrPix  ,PLOTvar.NrROI); //Initially set to all Used ROIs

      { CntX here is used as CONTROL Variable!!!}
      CntX := 0;   // becomes 1 with the First 1 and 0 with the first 0;
      CntY := -1; // Counts Number of Elements in Offsets and CnPix arrays
      XLL  := 0;  //memorises beg of 1 train of Contiguis 1

      For Cnt := 0 to High(SortArr) do Begin
        If (SortArr[Cnt] = 1) and (CntX = 0) then Begin
            Inc(CntY);
            Offsets[CntY] := Cnt*imXsize;
            CntX := 1;
            XLL := Cnt;       //  (imYsize-1- Ybot)*imXsize;
        End Else
        If (SortArr[Cnt] = 0) and (CntX = 1) then Begin
            NrPix[CntY] := (Cnt - XLL)*imXsize;  // = lines*imXsize; No Need to Add 1 because Cnt is 1 ahead
            CntX := 0;
        End;
      End; // For Cnt := 0 to High(SortArr)

      SortArr := nil;

      If CntY < High(Offsets) Then Begin
        SetLength(Offsets,CntY + 1);
        SetLength(NrPix  ,CntY + 1);
      End;

  //--- end 2nd ----//

    UseReadImForAnal := True; //means that if it reads from the Disc it will try to read ONLY the data needed
                              // for ROI but NOT the whole image.  If it reads from RAM it always reads the whole image

  End

    Else

   If (MovFType in[ANDOR_MOV,SINGLE_BW_TIFF,STACK_BW_TIFF,NORAN_PRARIE_MOV,NIKON_TIFF_MOV,QED_MOV]) and (High(StripOffs) > 0)
   Then Begin
      SmoothBorder := True; // here it does not check if needed but this option was never used anyway
      UseReadImForAnal := False;
    //in this case Tiff File has more then One Non Contiguous StripOffs - has NOT happend so far !!!
   End;

  End //If Not(FileInRAM) Then Begin

 End   //If ((FileInRAM) and Not(ChannelsRatioOn)) Or Not(FileInRAM) Then Begin

  Else

 If (ChannelsRatioOn) Then UseReadImForAnal := False;

  { ******* End of the  preparation for Selective Reading from DISC  ***** }

  //-   beg for ROI Tracking----//
 If (ROItracking) then begin
    UseReadImForAnal := False;
 End;
  //-   end for ROI Tracking----//

 {*******************************************************************}
     {-- Starts Extracting Traces = Going through the File}

For ImNr := Beg to ToEnd Do Begin  {Counts Images}

      Application.ProcessMessages;
      
      If (StopAnal = True) and (ImNr-Beg >= dsAnalRange.Delta) Then Begin
        ToEnd         := ImNr - 1;
        PLOTvar.ImEnd := ToEnd;   //stores last analyzed image and Clips SerPlot Dta arrays
        SetArraysForTimeSerAnal(ToEnd - Beg + 1);
        Break;
      End;

      if    (UseReadImForAnal) then ReadImageForAnal(ImNr,Offsets,NrPix) else
      if Not(UseReadImForAnal) then ReadImage(ImNr,0,pImData);

      //-   beg for ROI Tracking----//
      If (ROItracking) Then Begin
        TrackROI;
        if (BitCount = 16) then Scale16bitImageToImDispl(0,ImDispl)
          else
        if (BitCount  = 8) then Transfer8bitImageToImDispl(ImDispl);

        UpdateMainImage(True);
      End;
      //-   end for ROI Tracking----//

         {Smooths Border}
    If (Filtering  in[SMOOTH_BEFORE_RATIO,SMOOTH_NON_RATIO]) and (SmoothBorder) then SmoothBorders; {Smooths Just the Border of Image}

         {End of Smoothing Border}

      {Gets the Mean from Each Box}
       CntROI     := 0; {Counts Boxes or Other ROIs}

  For i := 1 to 20 Do Begin         {Counts ROI}
      if CntROI > ROIvar.NrROI then Break;

    If (ROIvar.ROIAdr[i] > 0) Then Begin
         Inc(CntROI);
       {  KindROI := ROIvar.ROIAdr[i]; for box mean}

    {-------------------------------------------------------------------}
    {Now Smooths each ROI separately If Needed}
   If (Filtering  in[SMOOTH_BEFORE_RATIO,SMOOTH_NON_RATIO,SMOOTH_AFTER_RATIO]) Or (ChannelsRatioOn)
   Then Begin

       {Determines the Area to be Smoothed}
       {For Boxes}
     If (ROIvar.ROIAdr[i] = 1) then Begin
        XLL  := ROIvar.ROICoor[1,i];
        Yupp := ROIvar.ROICoor[2,i];
        Xrr  := ROIvar.ROICoor[3,i];
        Ydd  := ROIvar.ROICoor[4,i];
     End Else
      {For Free Hand}
     If (ROIvar.ROIAdr[i] = 3) then Begin
        XLL  := imXsize - 1;
        Xrr  := 0;
        Yupp := imYsize - 1;
        Ydd  := 0;
      For CntY := 0 to High(FhTbl[i]) Do Begin
        If (High(FhTbl[i,CntY]) > 0) Then Begin  {more then one Pixel}
              CntX       := 0;
          While CntX < High(FhTbl[i,CntY]) Do Begin
            if  XLL  > FhTbl[i,CntY,CntX].X   then XLL  := FhTbl[i,CntY,CntX].X;
            if  Xrr  < FhTbl[i,CntY,CntX+1].X then Xrr  := FhTbl[i,CntY,CntX+1].X;
            if  Yupp > FhTbl[i,CntY,CntX].Y   then Yupp := FhTbl[i,CntY,CntX].Y;
            if  Ydd  < FhTbl[i,CntY,CntX].Y   then Ydd  := FhTbl[i,CntY,CntX].Y;
              Inc(CntX,2);
          End; {while}
        End Else {If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin}
        If (High(FhTbl[i,CntY]) = 0) Then Begin {Just One Pixel}
            if XLL  > FhTbl[i,CntY,0].X then XLL  := FhTbl[i,CntY,0].X;
            if Xrr  < FhTbl[i,CntY,0].X then Xrr  := FhTbl[i,CntY,0].X;
            if Yupp > FhTbl[i,CntY,0].Y then Yupp := FhTbl[i,CntY,0].Y;
            if Ydd  < FhTbl[i,CntY,0].Y then  Ydd := FhTbl[i,CntY,0].Y;
        End; {(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel}
      End; {For CntY := 0 to High(TabFh) do begin}
     End; {ROIvar.ROIAdr[i] = 3}


       {--- end of Determinig the Smoothing area --}
     If (Filtering  in[SMOOTH_BEFORE_RATIO,SMOOTH_NON_RATIO]) Then Begin
      DoSmoothForROI(RawByteArr,RawWordArr,WordArrA,WordArrB,XLL,Xrr,Yupp,Ydd,SmBoxOffset,SmMedOffset,SmGaussOffset);
     End

      Else

     If (Filtering  = SMOOTH_AFTER_RATIO) Then Begin
      {increase the areas by the 1st filter offsets because they are = or > then 2nd filters}
      If (SmoothMode in [SMOOTH_BOX, SMOOTH_BOX_MED]) Then Begin
        XLLRat  := XLL  - SmBoxOffset;
        XrrRat  := Xrr  + SmBoxOffset;
        YuppRat := Yupp - SmBoxOffset;
        YddRat  := Ydd  + SmBoxOffset;
        if XLLRat < 0 then XLLRat := 0;
        if XrrRat > imXsize - 1 then XrrRat := imXsize - 1;
        if YuppRat < 0 then YuppRat := 0;
        if YddRat > imYsize - 1 then YddRat := imYsize - 1;
      End
        Else
      If (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED]) Then Begin
        XLLRat  := XLL  - SmGaussOffset;
        XrrRat  := Xrr  + SmGaussOffset;
        YuppRat := Yupp - SmGaussOffset;
        YddRat  := Ydd  + SmGaussOffset;
        if XLLRat < 0 then XLLRat := 0;
        if XrrRat > imXsize - 1 then XrrRat := imXsize - 1;
        if YuppRat < 0 then YuppRat := 0;
        if YddRat > imYsize - 1 then YddRat := imYsize - 1;
      End
        Else
      If (SmoothMode in [SMOOTH_MED, SMOOTH_MED_BOX, SMOOTH_MED_GAUSS]) Then Begin
        XLLRat  := XLL  - SmMedOffset;
        XrrRat  := Xrr  + SmMedOffset;
        YuppRat := Yupp - SmMedOffset;
        YddRat  := Ydd  + SmMedOffset;
        if XLLRat < 0 then XLLRat := 0;
        if XrrRat > imXsize - 1 then XrrRat := imXsize - 1;
        if YuppRat < 0 then YuppRat := 0;
        if YddRat > imYsize - 1 then YddRat := imYsize - 1;
      End;
      //do the ratio F/Fo or Cn1/Ch2 HERE  to ImDataRat with Dimensions increased be Smoothing Offsets
       //then do the smoothnig of ImDataRat
      If (RatioOn) Then Begin
        if (BitCount = 16) then DoRatioForROI(XLLRat, XrrRat, YuppRat, YddRat,Im16bitData)
          else
        if (BitCount = 8)  then DoRatioForROI(XLLRat, XrrRat, YuppRat, YddRat,Im8bitData);
      End
        Else
      If (ChannelsRatioOn) Then Begin
        if (BitCount = 16) then DoChannelsRatioForROI(XLLRat, XrrRat, YuppRat, YddRat,Im16bitData,Im2nd16bit)
          else
        if (BitCount = 8)  then DoChannelsRatioForROI(XLLRat, XrrRat, YuppRat, YddRat,Im8bitData,Im2nd8bit);
      End;
      // procedure for smoothing ImDataRat
      DoSmoothRatioForROI(RawDoubleArr, DoubleArrA, DoubleArrB,XLL,Xrr,Yupp,Ydd,SmBoxOffset,SmMedOffset,SmGaussOffset);
     End

      Else

     If (ChannelsRatioOn) and (Filtering = DO_NOT_SMOOTH) Then Begin
      if (BitCount = 16) then DoChannelsRatioForROI(XLL, Xrr, Yupp, Ydd,Im16bitData,Im2nd16bit)
        else
      if (BitCount = 8) then DoChannelsRatioForROI(XLL, Xrr, Yupp, Ydd,Im8bitData,Im2nd8bit);
     End;

 End; //If (Filtering  in[SMOOTH_BEFORE_RATIO,SMOOTH_NON_RATIO,SMOOTH_AFTER_RATIO])

{------------------- End of Smoothing SMOOTH_BEFORE_RATIO and SMOOTH_NON_RATIO--------------------------}

If ROIvar.ROIAdr[i] = 1 then Begin // ROI = BOX

    XLL  := ROIvar.ROICoor[1,i];
    Yupp := ROIvar.ROICoor[2,i];
    Xrr  := ROIvar.ROICoor[3,i];
    Ydd  := ROIvar.ROICoor[4,i];

  If (Filtering = SMOOTH_BEFORE_RATIO) then Begin  {implies Ratio = F/Fo}
    TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] :=
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im16bitDataSM_Last))*ScaleRat;
  End

    Else

  If (Filtering  = SMOOTH_AFTER_RATIO) and (RatioOn) Then Begin
      TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] :=
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRatForSmooth)*ScaleRat;
  End

    Else

  If (Filtering  = SMOOTH_AFTER_RATIO) and (ChannelsRatioOn) Then Begin
    // no *ScaleRat here.  Will be multipled later
      TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] :=
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRatForSmooth);
  End

    Else

  If (Filtering = SMOOTH_NON_RATIO) then Begin //implies Intensity
    TSPlotData_Area[(CntROI-1),(ImNr-Beg)] :=
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im16bitDataSM_Last);
  End

    Else

  If (Filtering = DO_NOT_SMOOTH) Then Begin

   If (RatioOn) Then Begin
      {uses NotFiltAvIm since AvIm is smoothed}
    if (BitCount = 16) then begin
      TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] :=
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im16bitData))*ScaleRat;
    end
      Else
    begin
      TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] :=
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im8bitData))*ScaleRat;
    end;
   End

    Else

   If (ChannelsRatioOn) Then Begin
      TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] :=
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRat);
   End

    Else

   If Not(RatioOn) and Not(ChannelsRatioOn) Then Begin
    if (BitCount = 16) then
      TSPlotData_Area[(CntROI-1),(ImNr-Beg)] :=
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im16bitData)
    else
      TSPlotData_Area[(CntROI-1),(ImNr-Beg)] :=
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im8bitData);
   End; {(RatioOn = false)}

  End; //If (Filtering = DO_NOT_SMOOTH) and Not(ChannelsRatioOn)

End //End of If ROIvar.ROIAdr[i] = 1 then Begin // ROI = BOX


  Else


   {********* Free Hand ROI ****************}
   
If ROIvar.ROIAdr[i] = 3 then begin  {Free Hand}
              MeanFh     := 0;
              MeanAvIm   := 0;  {Mean of Average Image Used in Area/Area}
              NrElem     := 0;
        {------ Calculates Mean of Free Hand Area ------}
        For CntY := 0 to High(FhTbl[i]) Do Begin
            {more then one Pixel -> High(FhTbl[i,CntY]) > 0}
          If (High(FhTbl[i,CntY]) > 0) Then Begin
              CntX       := 0;
            While CntX < High(FhTbl[i,CntY]) Do Begin
              XLL  := FhTbl[i,CntY,CntX].X;
              Xrr  := FhTbl[i,CntY,CntX + 1].X;
              Yupp := FhTbl[i,CntY,CntX].Y;
              Ydd  := Yupp;
              if (RatioOn = False) and (enThreshForArea.NumberOne > 0)
              then begin
                if (BitCount = 16) then
                  Inc(NrElem,GetNrElemAboveThres(XLL,Xrr,Yupp,Ydd,Im16bitData))
                else
                  Inc(NrElem,GetNrElemAboveThres(XLL,Xrr,Yupp,Ydd,Im8bitData))
              end
              else
                  Inc(NrElem,(Xrr-XLL+1));

              {------------ Gets Mean -----------------}

  If (Filtering = SMOOTH_BEFORE_RATIO) then Begin  {implies Ratio = F/Fo}
     MeanFh := MeanFh +
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im16bitDataSM_Last));
  End

    Else

  If (Filtering  = SMOOTH_AFTER_RATIO) and ((RatioOn) or (ChannelsRatioOn)) Then Begin
      MeanFh := MeanFh +
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRatForSmooth);
  End

    Else

  If (Filtering = SMOOTH_NON_RATIO) then Begin //implies Intensity
    MeanFh := MeanFh +
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im16bitDataSM_Last);
  End

    Else

  If (Filtering = DO_NOT_SMOOTH) Then Begin

   If (RatioOn) Then Begin
      {uses NotFiltAvIm since AvIm is smoothed}
    if (BitCount = 16) then begin
      MeanFh := MeanFh +
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im16bitData));
    end
      Else
    begin
      MeanFh := MeanFh +
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im8bitData));
    end;
   End

    Else

   If (ChannelsRatioOn) Then Begin
      MeanFh := MeanFh +
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRat);
   End

    Else

   If Not(RatioOn) and Not(ChannelsRatioOn) Then Begin
    if (BitCount = 16) then
      MeanFh := MeanFh +
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im16bitData)
    else
      MeanFh := MeanFh +
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im8bitData);
   End; {(RatioOn = false)}

  End; //If (Filtering = DO_NOT_SMOOTH) and Not(ChannelsRatioOn)

              {----------- End of Getting Mean ---------}
              Inc(CntX,2);
            End; {while}
           End Else {If (High(FhTbl[i,CntY]) > 0) Then Begin}
           {For One Pixel -> High(FhTbl[i,CntY]) = 0}
           If (High(FhTbl[i,CntY]) = 0) Then Begin
              XLL  := FhTbl[i,CntY,0].X;
              Xrr  := XLL;
              Yupp := FhTbl[i,CntY,0].Y;
              Ydd  := Yupp;
              if (RatioOn = False) and (enThreshForArea.NumberOne > 0) then begin
                if (BitCount = 16) then
                  Inc(NrElem,GetNrElemAboveThres(XLL,Xrr,Yupp,Ydd,Im16bitData))
                else
                  Inc(NrElem,GetNrElemAboveThres(XLL,Xrr,Yupp,Ydd,Im8bitData))
              end
              else
                  Inc(NrElem);

           {------------ Gets Mean -----------------}


  If (Filtering = SMOOTH_BEFORE_RATIO) then Begin  {implies Ratio = F/Fo}
     MeanFh := MeanFh +
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im16bitDataSM_Last));
  End

    Else

  If (Filtering  = SMOOTH_AFTER_RATIO) and ((RatioOn) or (ChannelsRatioOn)) Then Begin
      MeanFh := MeanFh +
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRatForSmooth);
  End

    Else

  If (Filtering = SMOOTH_NON_RATIO) then Begin //implies Intensity
    MeanFh := MeanFh +
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im16bitDataSM_Last);
  End

    Else

  If (Filtering = DO_NOT_SMOOTH) Then Begin

   If (RatioOn) Then Begin
      {uses NotFiltAvIm since AvIm is smoothed}
    if (BitCount = 16) then begin
      MeanFh := MeanFh +
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im16bitData));
    end
      Else
    begin
      MeanFh := MeanFh +
      (GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],AvIm,Im8bitData));
    end;
   End

    Else

   If (ChannelsRatioOn) Then Begin
      MeanFh := MeanFh +
        GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],ImDataRat);
   End

    Else

   If Not(RatioOn) and Not(ChannelsRatioOn) Then Begin
    if (BitCount = 16) then
      MeanFh := MeanFh +
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im16bitData)
    else
      MeanFh := MeanFh +
       GetMeanROIforTimeSerAnal(XLL,Xrr,Yupp,Ydd,ROIvar.ROIAdr[i],nil,Im8bitData);
   End; {(RatioOn = false)}

  End; //If (Filtering = DO_NOT_SMOOTH) and Not(ChannelsRatioOn)

  {----------------------------- End of Getting Mean ----------------------------}

           End; {(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel}
        End; {For CntY := 0 to High(TabFh) do begin}

          if (RatioOn) or (ChannelsRatioOn) then begin
            if (RatioOn) then MeanFh := (MeanFh/NrElem)*ScaleRat else
            if (ChannelsRatioOn) then MeanFh := (MeanFh/NrElem); //will be multiplied later
          end
            else
          MeanFh := MeanFh/NrElem;

          if not(RatioOn) and not(ChannelsRatioOn) then
            TSPlotData_Area[(CntROI-1),(ImNr-Beg)] := MeanFh
            else
          if (RatioOn) or (ChannelsRatioOn)  then
            TSPlotData_BaseNotSubtr[(CntROI-1),(ImNr-Beg)] := MeanFh;
              {-- End of Calc Mean --- }

  End; {End Free Hand}       

       PLOTvar.AdrUsed[CntROI-1] := i; {stores Color to be Used};
    End; {(BoxPar.BoxAdr[i] > 1)}
  End; {i := 1 to 20}
   ProgBarTimSerPlot.Position := ImNr - Beg + 1;
   lbImNum.Caption            := IntToStr(ImNr + 1);
 End; {CntIm := Beg to ToEnd}

  {-----------------------------------------------------------------------------}
  {----------------------  End of Going Through Images  ------------------------}
  
   FinalizeTimeSerAnal(Sender);

   {refreshes All the Buffers with Current Image}
   frmPlayback.PlaybackScrollBarChange(Sender);


End;   // DoConvTimeSeriesAnal

{********************************************************************************}

procedure TfrmTimeSerPlot.CheckAreaMinPoints(Sender : TObject);
Var DoResetPoints     : Boolean;

Begin

 DoResetPoints := False;

If Not(sbSetRange.Down) then Begin
  If (Sender = StartAnal) Then Begin
    if enTraceMinPoints.NumberOne > (dsAnalRange.PosTo - dsAnalRange.PosFrom) - 1 then begin
      DoResetPoints := True;
      PLOTvar.LastTraceMinPrts := (dsAnalRange.PosTo - dsAnalRange.PosFrom) - 1;
    end;
  End Else Begin
    if enTraceMinPoints.NumberOne > (PLOTvar.ImEnd - PLOTvar.ImBeg) - 1 then begin
      DoResetPoints := True;
      PLOTvar.LastTraceMinPrts := (PLOTvar.ImEnd - PLOTvar.ImBeg) - 1;
    end;
  End;
End Else

If (sbSetRange.Down) then Begin
  if enTraceMinPoints.NumberOne > (enRangeFromTo.NumberTwo - enRangeFromTo.NumberOne) - 1 then begin
    DoResetPoints := True;
    PLOTvar.LastTraceMinPrts := (enRangeFromTo.NumberTwo - enRangeFromTo.NumberOne) - 1;
  end;
End;


If (DoResetPoints) Then Begin
  enTraceMinPoints.NumberOne := PLOTvar.LastTraceMinPrts;
   MessageDlg('Number of Points for Area/Min has been Set to Range of Images Minus 2',
                        mtInformation,[mbOK],0);
End;


End;
{********************************************************************************}
Procedure TfrmTimeSerPlot.RePlot(Sender : TObject);
Begin;

    if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
    DrawTimeSerPlotTraces(Sender,TSPlotData_BaseSubtr) else
    DrawTimeSerPlotTraces(Sender,TSPlotData_BaseNotSubtr);
    DrawTimeSerPlotXaxes;
    DrawTimeSerPlotXticks;
    if (Sender = enYbottom) or (Sender = enYtop) or (Sender = dsYaxes) or
       (CheckBoxSymbolOn.Checked) or (PLOTvar.HasPeaks = True) then begin
        DrawTimeSerPlotYaxes;
        DrawTimeSerPlotYticks;
    end;
    if (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) and (CheckBoxCursor.Checked = True) then DrawTimeSerPlotCursor;
    if (MeasTrace.Down) then begin
      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
      frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);
    end;
End;


procedure TfrmTimeSerPlot.ReDoBaseLineAndPeaks(Sender: TObject);
{Redo Analysis if Number Of Points Changed }
begin

  If (TimeSerAnalDone) Then Begin

    If (TimPltSlid.BaseLineOption in [GET_BASELINE,SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) Then Begin
      if (PLOTvar.BaseLineStatus <> TimPltSlid.BaseLineOption) then begin
        if (TimPltSlid.BaseLineOption in [GET_BASELINE,SUBTRACT_BASELINE]) then begin
          GetBaseLine(TSPlotData_BaseNotSubtr,TSPlotData_BaseLine);
          if (TimPltSlid.BaseLineOption = SUBTRACT_BASELINE) then SubtractBaseLine;
        end else
        if (TimPltSlid.BaseLineOption = DIVIDE_BY_BASELINE) then  DivideByBaseLine;
      end;
    End;
       PLOTvar.BaseLinePoints := TimPltSlid.BaseLinePoints;
       PLOTvar.LSD := enLSD.NumberFloat;
       PLOTvar.RSD := enRSD.NumberFloat;
       PLOTvar.BaseLineStatus := TimPltSlid.BaseLineOption;

   //Gest Peeks if Checked//
    if (cbGetPeaks.Checked) and (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then begin
       if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
       GetPeaks(TSPlotData_BaseSubtr) else
       GetPeaks(TSPlotData_BaseNotSubtr);
    end;

  End; //If (TimeSerAnalDone) Then Begin


End; //procedure TfrmTimeSerPlot.ReDoAnalClick

{**************************************************************}
procedure TfrmTimeSerPlot.SetPlotTitle;
   var TemStr,ChOrder  : AnsiString;
       GaussSm : AnsiString;

 Begin

  //Sets Plot Titles//

   TemStr := '';

   If (SmoothMode > NO_SMOOTH) And
      (((PLOTvar.AnalType = RATIO_TIME) and not(PLOTvar.TraceDivMinUsed)) Or
        (PLOTvar.AnalType in[Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) Or
      ((PLOTvar.AnalType = INTENSITY_TIME) and (SmoothNonRatio in [SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH])))
   Then Begin

      if (SmoothMode = SMOOTH_BOX) Then TemStr := '2D Boxcar Filt = ' + IntToStr(BoxSmSize) else
      if (SmoothMode = SMOOTH_MED) Then TemStr := '2D Median Filt = ' + IntToStr(MedSmSize) else
      if (SmoothMode = SMOOTH_BOX_MED) Then TemStr := '2D Boxcar Filt = ' + IntToStr(BoxSmSize) +
                                        ' -> 2D Median Filt = ' + IntToStr(MedSmSize) else
      if (SmoothMode = SMOOTH_MED_BOX) Then TemStr := '2D Median Filt = ' + IntToStr(MedSmSize) +
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
        if (SmoothMode = SMOOTH_GAUSS) then TemStr := '2D Gaussian Filt = ' + GaussSm else
        if (SmoothMode = SMOOTH_GAUSS_MED) Then TemStr := '2D Gaussian Filt = ' + GaussSm +
                                        ' -> 2D Median Filt = ' + IntToStr(MedSmSize) else
        if (SmoothMode = SMOOTH_MED_GAUSS) Then TemStr := '2D Median Filt = ' + IntToStr(MedSmSize) +
                                        ' -> 2D Gaussian Filt = ' + GaussSm;
      end;  //if (SmoothMode in [SMOOTH_GAUSS,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
   End
    Else
   If (SmoothMode = NO_SMOOTH) And
      (((PLOTvar.AnalType = RATIO_TIME) and not(PLOTvar.TraceDivMinUsed)) Or
      (PLOTvar.AnalType in[Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) Or
      ((PLOTvar.AnalType = INTENSITY_TIME) and (SmoothNonRatio in [SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH])))
   Then Begin
      TemStr := 'No 2D Filters used';
   End;

   if (PLOTvar.AnalType = INTENSITY_TIME) then begin
    if (TemStr = 'No 2D Filters used') then
      PLOTvar.Title := 'Intensity' + ', ' + TemStr
    else begin
      if (TemStr = '') then
        PLOTvar.Title := 'Intensity'
      else
      PLOTvar.Title := TemStr + ' -> ' + 'Intensity';
    end;
   end

    else

   if (PLOTvar.AnalType = RATIO_TIME) and (PLOTvar.TraceDivMinUsed) then begin
    if not(PLOTvar.BaseLineStatus = DIVIDE_BY_BASELINE) then
      PLOTvar.Title := 'Intensity/min (' + IntToStr(TimPltSlid.AreaMinPoints)+ ' pt [' +
                       IntToStr(PLOTvar.TraceMinFrom + 1) + ' - ' +
                       IntToStr(PLOTvar.TraceMinTo + 1) + '])'
    else
    PLOTvar.Title := 'Intensity/Continuous Baseline';
   end

    else

   if (PLOTvar.AnalType = RATIO_TIME) and not(PLOTvar.TraceDivMinUsed) Then begin
      if (TemStr = 'No 2D Filters used') then PLOTvar.Title := 'F/Fo' + ', ' + TemStr
        else
      begin
        if (AutoSearchPar.SmoothBeforeDoRatio) then
          PLOTvar.Title := TemStr + ' -> ' + 'F/Fo'
            else
          PLOTvar.Title := 'F/Fo' + ' -> ' + TemStr;
      end;
   end

      else

   if (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then begin
      if (ChannelOrder = ASCENDING)  then ChOrder := 'Ch1/Ch2'
        else
      if (ChannelOrder = DESCENDING) then ChOrder := 'Ch2/Ch1';

       if (TemStr = 'No 2D Filters used') then
          PLOTvar.Title := ChOrder + ', ' + TemStr
       else
          PLOTvar.Title := ChOrder + ' -> ' +  TemStr;
   end;  //if (TimeSerAnalMode.ItemIndex > 0)

   if (PLOTvar.BaseLineStatus = SUBTRACT_BASELINE) then
   PLOTvar.Title := PLOTvar.Title + ', Continuous Baseline Subtracted';

End;  //procedure TfrmTimeSerPlot.SetPlotTitle;


procedure TfrmTimeSerPlot.SetYAxes(Const TraceDivByMin : Boolean; Const Ymin,Ymax,Ybot,Ytop : Integer);
Begin

  dsYaxes.Enabled := True;

  If (TimeSerAnalOpCode = CONVENTIONAL) Then Begin

    If (RatioOn) or (TraceDivByMin) then begin
      PLOTvar.AnalType := RATIO_TIME;
      dsYaxes.Delta := 3;
      dsYaxes.SetSlider(0,TimPltSlid.YmaxRatOn, TimPltSlid.YbotRatOn, TimPltSlid.YtopRatOn);
    End

      Else

    If (ChannelsRatioOn) and not(PLOTvar.ROIkind[0] = ROI_LINESCAN) then begin
      PLOTvar.AnalType := Ch_div_Ch_RATIO_TIME;
      dsYaxes.Delta := 1;
      dsYaxes.SetSlider(0,TimPltSlid.YmaxRatOn, TimPltSlid.YbotRatOn, TimPltSlid.YtopRatOn);
    End
      {LineScan sets PLOTvar.AnalType in TransferLSTraceToTimeSerAnalPlot procedure}
      Else

    If Not(RatioOn) and Not(ChannelsRatioOn) and Not(TraceDivByMin) then begin
      PLOTvar.AnalType := INTENSITY_TIME;
      if TimPltSlid.shrFact <> PLOTvar.shrFact then begin
        TimPltSlid.YtopRatOff := 256 shl PLOTvar.shrFact - 1;
        TimPltSlid.YbotRatOff :=   0;
        TimPltSlid.shrFact    := PLOTvar.shrFact;
      end;
      if (dsYaxes.Max <> 256 shl PLOTvar.shrFact - 1) then begin
        dsYaxes.Delta := (256 shl PLOTvar.shrFact) div (256 div 4);
        dsYaxes.SetSlider(0,256 shl PLOTvar.shrFact - 1, TimPltSlid.YbotRatOff, TimPltSlid.YtopRatOff);
      end else
        dsYaxes.SetSliderPos(TimPltSlid.YbotRatOff,TimPltSlid.YtopRatOff);
    End; //Not(RatioOn) and Not(AreaMin)
  End

    Else

  If (TimeSerAnalOpCode = DIAM_TRACKING ) Then Begin
    dsYaxes.Delta := 1;
    dsYaxes.SetSlider(Ymin,Ymax,Ybot,Ytop);
    PLOTvar.AnalType := DISTANCE_TIME;
  End;


  enYbottom.Enabled := True;
  enYbottom.HideText   := False;
  enYtop.Enabled    := True;
  enYtop.HideText   := False;

  If Not(PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then Begin
    enYbottom.NumberKind := Integers;
    enYbottom.MaxLength := Length(IntToStr(dsYaxes.Max));
    enYbottom.Min := 0; //always = 0; I just put it for completeness
    enYbottom.Max := dsYaxes.PosTo - dsYaxes.Delta;

    enYtop.NumberKind := Integers;
    enYtop.MaxLength := Length(IntToStr(dsYaxes.Max));
    enYtop.Max := dsYaxes.Max;
    enYtop.Min := dsYaxes.PosFrom + dsYaxes.Delta;

    enYbottom.NumberOne := dsYaxes.PosFrom;
    enYtop.NumberOne := dsYaxes.PosTo;
    Yrange := dsYaxes.PosTo - dsYaxes.PosFrom ;

  End else

  If(PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME])  then begin
    enYbottom.NumberKind := Floats;
    enYbottom.MaxLength := Length(IntToStr(dsYaxes.Max div 10)) + 1 + enYbottom.Precision;
    enYbottom.Min := 0; //always = 0; I just put it for completeness
    enYbottom.Max := (dsYaxes.PosTo - dsYaxes.Delta) / 10;

    enYtop.NumberKind := Floats;
    enYtop.MaxLength := Length(IntToStr(dsYaxes.Max div 10)) + 1 + enYtop.Precision;
    enYtop.Max := dsYaxes.Max / 10;
    enYtop.Min := (dsYaxes.PosFrom + dsYaxes.Delta) / 10;

    enYbottom.NumberFloat := dsYaxes.PosFrom/10;
    enYtop.NumberFloat    := dsYaxes.PosTo/10;
    Yrange := dsYaxes.PosTo - dsYaxes.PosFrom;
  End;

  Yscale := Yplot/Yrange;  //Pix per Unit of measurement//      PROBLEM !!!

  DrawTimeSerPlotYaxes;
  DrawTimeSerPlotYticks;

  //deletes Traces//
  FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Color := clblack;
  FrameTimSerPlot.imgTimeSerPlot.Canvas.FillRect(Rect(PlXbeg,PlYend,TimPltSlid.WinXSize,PlYbeg+1));


End; // procedure TfrmTimeSerPlot.SetYAxes

{***************************************************************************}
procedure TfrmTimeSerPlot.GetAreaDivMinOrArea(Sender : TObject);
 Var
  Cnt,CntROI,ImNr,Xbeg,Xend : Integer;
  MinTraceVal,SumPt         : Double;

 Begin


 If (TimPltSlid.TraceDivMin = False) then Begin
  //copies to TimSerPlotData//
  For Cnt := 0 to PLOTvar.NrROI-1 Do Begin
    for ImNr := 0 to High(TSPlotData_Area[0])do
      TSPlotData_BaseNotSubtr[Cnt,ImNr] := TSPlotData_Area[Cnt,ImNr];
  End;   //for
 End

  Else

   //Now for  Area/min//
If (TimPltSlid.TraceDivMin = True) then Begin
              //Does Area/min From Non Smoothed Main and AvImRaw//

      //Sets Range to Find Min to whole range or manually determined//
  If FreezeMean.Down = False Then Begin
      If (sbSetRange.Down)  Then Begin
         Xbeg := enRangeFromTo.NumberOne - 1;
         Xend := enRangeFromTo.NumberTwo - 1;
      End Else
      If not(sbSetRange.Down) Then Begin
         Xbeg := PLOTvar.ImBeg;
         Xend := PLOTvar.ImEnd;
      End;


        //stores actual range and points used in analysis//
        PLOTvar.TraceMinFrom := Xbeg;
        PLOTvar.TraceMinTo   := Xend;
        PLOTvar.LastTraceMinPrts := enTraceMinPoints.NumberOne;
        PLOTvar.Background := Bkg;

        PLOTvar.GetEachPeakBase := TimPltSlid.GetEachPeakBase;
        PLOTvar.EachPeakBasePt  := TimPltSlid.EachPeakBasePt;
        PLOTvar.EachPeakBaseRg  := TimPltSlid.EachPeakBaseRg;

      //end of setting range//

      SetLength(Divider,PLOTvar.NrROI);

      For CntROI := 0 to PLOTvar.NrROI -1 Do Begin
        //2nd: Gets Minimum stored in PLOTvar.Divider//
        If FreezeMean.Down = False Then Begin
            MinTraceVal := High(LongInt);   //sets to the max possible//
          For ImNr := Xbeg to (Xend - PLOTvar.LastTraceMinPrts - 1) Do Begin
            SumPt       := 0;
            For Cnt := ImNr to ImNr + PLOTvar.LastTraceMinPrts - 1 Do
            SumPt := SumPt + TSPlotData_Area[CntROI,Cnt - PLOTvar.ImBeg];

            if MinTraceVal > SumPt then MinTraceVal := SumPt;
          End; //For ImNr := Xbeg to (Xend - TimPltSlid.AreaMinPoints - 1)

         Divider[CntROI] := (MinTraceVal/PLOTvar.LastTraceMinPrts) - Bkg;

        End; // If FreezeMean.Down = False Then Begin //
      End; //For CntROI := 0 to PLOTvar.NrROI -1
      //End of Getting Minimum//
  End; //If FreezeMean.Down = False//

  //Divides Every Trace by Divider//
  For CntROI := 0 to PLOTvar.NrROI -1 Do Begin
      //3rd: divides Traces by minmum = PLOTvar.Divider//
      For ImNr := PLOTvar.ImBeg to PLOTvar.ImEnd Do Begin
       if Divider[CntROI] > 0 then
       TSPlotData_BaseNotSubtr[CntROI,(ImNr-PLOTvar.ImBeg)] :=
       ((TSPlotData_Area[CntROI,(ImNr-PLOTvar.ImBeg)]-Bkg)/Divider[CntROI])*ScaleRat else
         TSPlotData_BaseNotSubtr[CntROI,(ImNr-PLOTvar.ImBeg)] := 0;
      End; //For ImNr := Beg to ToEnd//
      //End of Divides the Traces//
      if FreezeMean.Enabled = False then FreezeMean.Enabled := True;
      PLOTvar.AllowFreezeMin := True;
      FreezeMeanClick(Sender);
  End;  //For CntROI := 0 to PLOTvar.NrROI -1 //


 End; //If (CheckBoxAreaMin.Checked = True)

  {Copies to BackUp Array}
 For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
  for ImNr := 0 to High(TSPlotData_BackUp[0]) do
  TSPlotData_BackUp[Cnt,ImNr] := TSPlotData_BaseNotSubtr[Cnt,ImNr];
 End;

End;   //procedure TfrmTimeSerPlot.GetAreaDivMinOrArea(Sender : TObject);
{********************************************************************************}
function TfrmTimeSerPlot.GetFinalEventWidth(Const NrScanes : Integer) : Integer;
  Var CntScan : Integer;
      ToInc   : Boolean;
 Begin
    //since I could not find a formula to calculate FinalEventWidth I do it in iterative way

    {It is "to NrScanes - 1" because in GetBaseline NrScanes is incremented after
    All Has been Done; there we have "to NrScanes"}

     Result   := TimPltSlid.BaseLinePoints;
     ToInc    := True;

    For CntScan := 0 to NrScanes - 1 do Begin
      Result := Result + Result shr 1;
      if (Result mod 2 = 0) then begin  //makes it Odd Number
        if (ToInc) then begin
          Inc(Result);
          ToInc := False;
        end else
        begin
          Dec(Result);
          ToInc := True;
        end;
      end; //if (EventWidth mod 2 = 0)

    End;

    {Points increase in roughly geometric progression: each member = 1.5*previous member
     but the number is always kept Odd

     this is the formula: any member An is equal to first member multiplied by the
     common ratio (constant mutiplier) to the power of the number of the member - 1
              An = Ao*R^(n-1)
    this gives approximate result
   Result := Floor(TimPltSlid.BaseLinePoints*exp(NrScanes*ln(1.48)));
    }

end; //End of  function TfrmTimeSerPlot.GetFinalEventWidth


procedure TfrmTimeSerPlot.GetBaseLine(const TSPlotData_Source : TDyn2DDoubleArr; var BaselineOut : TDyn2DDoubleArr); // Continuous  Baseline
 {uses TSPlotData_BaseNotSubtr as source except if
  Devide By Baseline is chosen - then TSPlotData_Area is Used   }
Var
  ToInc           : Boolean;
  Cnt             : Integer;
  CntScan         : Integer;
  CntPt           : Integer;
  CntROI          : Integer;
  j               : Integer;
  EndCount        : Integer;
  HalfEventWidth  : Integer;
  EventWidth      : Integer;
  NrScanes        : Integer; 
  EventWindow     : TDynDoubleArray;
  MultiBase       : TDyn2DDoubleArr;
  Mean            : Double; 
  LSD, RSD        : Double;

Begin
    {Starts from EventWidth = Number of Points of the widest event
     and increments it 10 times by 1/2 EventWidth.
     So, Final With is about 5 times EventWidth (e.g. if EventWidth = 31 then Final is 157 = 5.0645 times)
     EventWidth is adjusted always Odd (automatically,
     and  IncrBy = increment, always even. So, Window is always Odd

     Although var BaselineOut is used, to be sure that counters work fine all the counters and High()
     are using the global variable TSPlotData_BaseLine }
   
    LSD := enLSD.NumberFloat; //Left Standard Deviation
    RSD := enRSD.NumberFloat; //Right SD

    //THIS PARAGRAPH PREVENTS  Crashing if the Final Points are more then the Trace Points
    // The Final Points Should be 1/2 of the trace Points

    EndCount := StrToInt((AnsiRightStr(lbFinalPoints.Caption,Length(lbFinalPoints.Caption)-2))); //here EndCount is used to hold Final Points

  If  (EndCount >= (Length(TSPlotData_BaseLine[0])) DIV 2 ) then begin

        MessageDlg('Final number of points should be less than 1/2 of the trace points.' +
        ' It will not create continuous baseline.' ,mtInformation,[mbOK],0);

       //Makes Fake Baseline: Sets Baseline To 0 if No Ratio or to 10 for ratio//

    For CntROI := 0 to PLOTvar.NrROI - 1 Do Begin
      for Cnt := 0 to High(TSPlotData_BaseLine[0]) do begin
        if Not(PLOTvar.AnalType = RATIO_TIME) then
          BaselineOut[CntROI,Cnt] := 0 else
        if    (PLOTvar.AnalType = RATIO_TIME) then
          BaselineOut[CntROI,Cnt] := 10; // = 1.0 F/Fo
      end;
    End;


  End
  //-------------- Does Baseline ----------------------------------------------//
  Else Begin

    NrScanes := StrToInt(NrPasses.Items[NrPasses.ItemIndex]);  //if Trace Length was OK

    PLOTvar.NrScanes := NrScanes; //memorizes value for Saving Files

    SetLength(MultiBase,NrScanes + 1,Length(TSPlotData_BaseLine[0]));

    //Sets Baseline To MaxInt//
  For CntROI := 0 to PLOTvar.NrROI - 1 Do Begin
      for Cnt := 0 to High(TSPlotData_BaseLine[0]) do BaselineOut[CntROI,Cnt] := MaxInt; //just big number
  End;


  ProgBarTimSerPlot.Max := PLOTvar.NrROI;
  ProgBarTimSerPlot.Visible := True;


  For CntROI := 0 to PLOTvar.NrROI - 1 Do Begin
    {starts going through ROIs}

     ToInc := True;
    //Sets the EventWidth to the initial Value
     EventWidth := TimPltSlid.BaseLinePoints;

    For CntScan := 0 to NrScanes do Begin

      SetLength(EventWindow,EventWidth);
      EndCount := Length(TSPlotData_BaseLine[0]) - EventWidth;
      HalfEventWidth := EventWidth shr 1;

      For Cnt := 0 to EndCount Do Begin   // [0] is always full so there is no need to use CntROI
        for CntPt := 0 to High(EventWindow) do EventWindow[CntPt] := TSPlotData_Source[CntROI, Cnt+CntPt];
        GetMeanStdDevLimits(EventWindow,Mean,LSD,RSD,2);

        if (Cnt > 0) and (Cnt < EndCount) then
        MultiBase[CntScan,Cnt + HalfEventWidth] := Mean else

        if (Cnt = 0) then
        for j := 0 to HalfEventWidth do begin
          MultiBase[CntScan,j] := Mean;
        end else
        if (Cnt = EndCount) then
        for j := EndCount to High(TSPlotData_BaseLine[0]) do begin
          MultiBase[CntScan,j] := Mean;
        end;
      End; //For Cnt := 0 to High(OrigData)

      If (CntScan < NrScanes) then  Begin
        EventWidth := EventWidth + EventWidth shr 1;
        If (EventWidth mod 2 = 0) then Begin
          //makes it Odd Number
          if (ToInc) then begin
            Inc(EventWidth);
            ToInc := False;
          end else
          begin
            Dec(EventWidth);
            ToInc := True;
          end;
        End; //if (EventWidth mod 2 = 0)
      End; //If (CntScan < NrScanes) then  Begin


    End; //For CntScan := 0 to NrPasses /

    {Gets the Minimum from all MultiBase passes and assigns it to Baseline}
    For Cnt := 0 to High(TSPlotData_BaseLine[0]) do Begin
      For CntScan := 0 to NrScanes do Begin
        if  BaselineOut[CntROI, Cnt] >  MultiBase[CntScan,Cnt] then
            BaselineOut[CntROI, Cnt] := MultiBase[CntScan,Cnt];
      End; // For CntPass := 0 to (NrPasses - 1)
    End; //For Cnt := 0 to High(BaseLine)


 End; //For CntROI := 0 to PLOTvar.NrROI - 1

End; //Else Begin (If  (EndCount < (Length(TSPlotData_BaseNotSubtr[0])) DIV 2 )


 ProgBarTimSerPlot.Visible  := False;
 ProgBarTimSerPlot.Position := 0;



End; //procedure TfrmTimeSerPlot.GetBaseline;

{******************************************************************************}

procedure TfrmTimeSerPlot.SubtractBaseLine;
Var
  Cnt             : Integer;
  CntROI          : Integer;

Begin

 For CntROI := 0 to PLOTvar.NrROI - 1 Do Begin
   If (PLOTvar.AnalType = RATIO_TIME) then begin
    for Cnt := 0 to High(TSPlotData_BaseLine[0]) do
    TSPlotData_BaseSubtr[CntROI,Cnt] := (TSPlotData_BaseNotSubtr[CntROI,Cnt] - TSPlotData_BaseLine[CntROI, Cnt]) + 10;
   End Else
    If Not(PLOTvar.AnalType = RATIO_TIME) then begin
      for Cnt := 0 to High(TSPlotData_BaseLine[0]) do
      TSPlotData_BaseSubtr[CntROI,Cnt] := TSPlotData_BaseNotSubtr[CntROI,Cnt] - TSPlotData_BaseLine[CntROI, Cnt];
   End;
 End; //For CntROI := 0 to PLOTvar.NrROI - 1


End; //procedure TfrmTimeSerPlot.SubtractBaseLine;

{***************************************************************************}

{******************************************************************************}
procedure TfrmTimeSerPlot.DivideByBaseLine;
Var
  Cnt             : Integer;
  CntROI          : Integer;
  Baseline        : TDyn2DDoubleArr;
  SmoothedTrace   : TDyn2DDoubleArr;
  SourceTrace     : TDyn2DDoubleArr;
  BasDiv          : Double;

Begin



 SetLength(Baseline,PLOTvar.NrROI,Length(TSPlotData_BaseLine[0]));


 if (cbSmTraceFltSize.ItemIndex > 0) then begin
  SetLength(SmoothedTrace,PLOTvar.NrROI,Length(TSPlotData_BaseLine[0]));
  SmoothTrace(TSPlotData_Area,SmoothedTrace);
  SourceTrace := SmoothedTrace;
 end else
  SourceTrace := TSPlotData_Area;

 GetBaseLine(SourceTrace,BaseLine);

 For CntROI := 0 to PLOTvar.NrROI - 1 Do Begin

    for Cnt := 0 to High(TSPlotData_BaseLine[0]) do begin
      BasDiv := BaseLine[CntROI, Cnt] - Bkg;
      if (BasDiv > 0) then
        TSPlotData_BaseSubtr[CntROI,Cnt] := ((SourceTrace[CntROI,Cnt] - Bkg) / BasDiv)*10
      else
        TSPlotData_BaseSubtr[CntROI,Cnt] := 0;
    end;
  
 End; //For CntROI := 0 to PLOTvar.NrROI - 1




End; //procedure TfrmTimeSerPlot.SubtractBaseLine;

{***************************************************************************}


procedure TfrmTimeSerPlot.ubWithoutBaselineClick(Sender: TObject);
begin
  TimPltSlid.BaseLineOption := NO_BASELINE;
  BaseLineControlsClick(Sender);
end;

procedure TfrmTimeSerPlot.ubGetBaselineClick(Sender: TObject);
begin
  TimPltSlid.BaseLineOption := GET_BASELINE;
  BaseLineControlsClick(Sender);
end;

procedure TfrmTimeSerPlot.unSubtractBaselineClick(Sender: TObject);
begin
  TimPltSlid.BaseLineOption := SUBTRACT_BASELINE;
  BaseLineControlsClick(Sender);
end;

procedure TfrmTimeSerPlot.unDivideByBaselineClick(Sender: TObject);
begin
  TimPltSlid.BaseLineOption := DIVIDE_BY_BASELINE;
  BaseLineControlsClick(Sender);
end;

procedure TfrmTimeSerPlot.BaseLineControlsClick(Sender: TObject);

Var CanProceed : Boolean;

Begin

    If (TimeSerAnalDone) then begin

      CanProceed := True;

       //Checks if the points Range for Minimumm for Area/min is OK //
      if (TimPltSlid.TraceDivMin) and (sbSetRange.Down) and
        ((PLOTvar.TraceMinFrom <> enRangeFromTo.NumberOne-1) or (PLOTvar.TraceMinTo   <> enRangeFromTo.NumberTwo-1))
      then begin //it is down Only if Are/min is checked

        if ((enRangeFromTo.NumberOne-1 < PLOTvar.ImBeg) or (enRangeFromTo.NumberTwo-1 > PLOTvar.ImEnd))
        then Begin
          CanProceed := False;
          MessageDlg('Correct Range Settings ',mtWarning,[mbOK],0);
        end;

        if (enTraceMinPoints.NumberOne >= enRangeFromTo.NumberTwo - enRangeFromTo.NumberOne)
        then Begin
          CanProceed := False;
          MessageDlg('Correct Range Settings ',mtWarning,[mbOK],0);
        end;

      end; //if (CheckBoxAreaMin.Checked) and (sbSetRange.Down))


      if (PLOTvar.AnalType = RATIO_TIME) and not(PLOTvar.TraceDivMinUsed) and (cbTraceDivMin.Checked)
      Then begin
        //when Pix/Pix or Are/Area (both Pix/Pix) was used then this has to be 1st Analyzed
        //because the trace originates fro Pix/Pix and there is no Raw Area Data!!!
        CanProceed := False;
        MessageDlg('Area Array is Empty. Run Analysis First ',mtWarning,[mbOK],0);
      end;

      If (CanProceed) Then Begin

        If (TimPltSlid.TraceDivMin) Then Begin
           //Check If there is a Change in: Nr of Points for Minimum, or
           //  Range (in case (sbSetRange.Down). If Yes, ReDo Area/min and Smoothing again
          if (PLOTvar.LastTraceMinPrts <> enTraceMinPoints.NumberOne) or
             (PLOTvar.TraceMinFrom     <> enRangeFromTo.NumberOne-1) or
             (PLOTvar.TraceMinTo       <> enRangeFromTo.NumberTwo-1) or
             (PLOTvar.Background      <> Bkg)
          then begin

           //Check Number of Points is legitimate //
          if (Not(FreezeMean.Down)) then CheckAreaMinPoints(Sender);

          GetAreaDivMinOrArea(Sender);

        {Does the Smoothing in Time if selected because GetAreaDivMinOrArea recriates
        TSPlotData_BaseNotSubtr from Non smoothed TSPlotData_Area}

          if (cbSmTraceFltSize.ItemIndex > 0) then SmoothTrace(TSPlotData_BackUp,TSPlotData_BaseNotSubtr);

          PLOTvar.SmTraceKind := cbSmTraceKind.ItemIndex;
          if (PLOTvar.SmTraceKind = BOXCART1D) then
            PLOTvar.SmTrBoxcarIndex := cbSmTraceFltSize.ItemIndex else
          if (PLOTvar.SmTraceKind = GAUSS1D) then
            PLOTvar.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex;
          if (PLOTvar.SmTraceKind = GAUSS1D_Fc) then
            PLOTvar.FcGaussFlt := TimPltSlid.FcGaussFlt else
          if (PLOTvar.SmTraceKind = KALMAN1D) then
            PLOTvar.SmTrKalmanIndex := cbSmTraceFltSize.ItemIndex;
          PLOTvar.BaseLineStatus := NO_BASELINE;
        end;
       End; //If TimPltSlid.AreaMin = (CheckBoxAreaMin.Checked)

        ReDoBaseLineAndPeaks(Sender);

        SetPlotTitle;
        RePlot(Sender);
        if (sbSlavePlot.Down) then frmSlaveTSPlot.DrawPlot(Sender);
        if (frmTimeHistograms <> nil) then begin
          if (frmTimeHistograms.rbPlot.Checked) then frmTimeHistograms.GetMessageFromSeriesPlot;
        end;

      End; //If (CanProceed)

    End; //If (TimeSerAnalDone)


End; //procedure TfrmTimeSerPlot.BaseLineControlsClick(Sender: TObject);


{******************************************************************************}

procedure TfrmTimeSerPlot.cbTraceDivMinClick(Sender: TObject);
Var  CanProceed : Boolean;
begin

  If ((RatioOn) or (ChannelsRatioOn)) and (cbTraceDivMin.Checked) then Begin
    {disables cbAreaMin if Pix/Pix or Area/Are = RatioOn is used}
    cbTraceDivMin.Checked  := False;
    TimPltSlid.TraceDivMin := cbTraceDivMin.Checked;
    if(unDivideByBaseline.Enabled) then begin
      if(unDivideByBaseline.Selected) then begin
        ubWithoutBaseline.Selected := True;
        ubWithoutBaselineClick(Sender);
      end;
      unDivideByBaseline.Selected := False;
      unDivideByBaseline.Enabled := False;
    end;
  End;


 If Not(RatioOn) and Not(ChannelsRatioOn) Then Begin

  TimPltSlid.TraceDivMin := cbTraceDivMin.Checked;

  If (cbTraceDivMin.Checked) then begin
    sbSetRange.Enabled := cbTraceDivMin.Checked;
    if PLOTvar.AllowFreezeMin then begin
      FreezeMean.Enabled := True;
      FreezeMeanClick(sender);
    end;
    unDivideByBaseline.Enabled := True;
  End;

  If not(cbTraceDivMin.Checked) then begin
    if (FreezeMean.Down) then begin
      FreezeMean.Down := False;
      FreezeMeanClick(sender);
    end;
    FreezeMean.Enabled := False;
    if (sbSetRange.Down) then begin
      sbSetRange.Down := False;
      sbSetRangeClick(Sender);
    end;
    sbSetRange.Enabled := False;

    if (unDivideByBaseline.Selected) then begin
      unDivideByBaseline.Selected := False;
      ubGetBaseline.Selected := True;
      ubGetBaselineClick(Sender);
    end;
    unDivideByBaseline.Enabled := False;
  End;

  If (TimeSerAnalDone) and (PLOTvar.TraceDivMinUsed)   then Begin

    CanProceed := True;

    //Check Range if sbSetRange.Down)//
    if (cbTraceDivMin.Checked) and (sbSetRange.Down) and (Not(FreezeMean.Down)) then begin
      if (enRangeFromTo.NumberOne-1 < PLOTvar.ImBeg) or (enRangeFromTo.NumberTwo-1 > PLOTvar.ImEnd)
      then Begin
        CanProceed := False;
        MessageDlg('Correct Range Settings ',mtWarning,[mbOK],0);
      end;
    end;

    If (CanProceed) Then Begin

      SetYAxes(cbTraceDivMin.Checked,0,0,0,0);  //this Sets PLOTvar.RatOn = True if CheckBoxAreaMin.Checked = True

       //Check Number of Points//
      if (Not(FreezeMean.Down)) and (cbTraceDivMin.Checked) then CheckAreaMinPoints(Sender);
      {Redo Area or Area/min}
      GetAreaDivMinOrArea(Sender);
        {Does the Smoothing in Time if selected}
      if cbSmTraceFltSize.ItemIndex > 0 then SmoothTrace(TSPlotData_BackUp,TSPlotData_BaseNotSubtr);
       PLOTvar.SmTraceKind := cbSmTraceKind.ItemIndex;
      if (PLOTvar.SmTraceKind = BOXCART1D) then
        PLOTvar.SmTrBoxcarIndex := cbSmTraceFltSize.ItemIndex else
      if (PLOTvar.SmTraceKind = GAUSS1D) then
        PLOTvar.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex else
      if (PLOTvar.SmTraceKind = GAUSS1D_Fc) then begin
        PLOTvar.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex;
        PLOTvar.FcGaussFlt := TimPltSlid.FcGaussFlt;
      end else
      if (PLOTvar.SmTraceKind = KALMAN1D) then
        PLOTvar.SmTrKalmanIndex := cbSmTraceFltSize.ItemIndex;

      PLOTvar.BaseLineStatus := NO_BASELINE;
      ReDoBaseLineAndPeaks(Sender);
      SetPlotTitle;
      RePlot(Sender);
      if (sbSlavePlot.Down) and (TimeSerAnalDone) then frmSlaveTSPlot.DrawPlot(Sender);
      End; //CanProceed
  End; //If (TimeSerAnalDone) and (PLOTvar.AreaUsed)

 End; // If Not(RatioOn) Then Begin
     
End;  //procedure TfrmTimeSerPlot.CheckBoxAreaMinClick(Sender: TObject);

{******************************************************************************}

procedure TfrmTimeSerPlot.StopAnalButtonClick(Sender: TObject);
begin
  StopAnal := True;
end;

{***************************************************************************}

procedure TfrmTimeSerPlot.UpDownNrWinClick(Sender: TObject; Button: TUDBtnType);

    var DummyBMP : TBitmap;
        i        : integer;
        Fact     : double;
begin

     frmTimeSerPlot.Constraints.MinWidth := frmTimeSerPlot.Width;
     frmTimeSerPlot.Constraints.MaxWidth := frmTimeSerPlot.Width; 

     //edlNrWin.Caption   := IntToStr(UpDownNrWin.Position);
      {prevenrs flickering when scrolling}
      if UpDownNrWin.Position = 1 then Begin
        FrameTimSerPlot.Color := clBtnFace;
        FrameTimSerPlot.HorzScrollBar.Visible := False;
      End else Begin
        FrameTimSerPlot.Color := clBlack;
        FrameTimSerPlot.HorzScrollBar.Visible := True;
      End;
     Fact := UpDownNrWin.Position*FrameTimSerPlot.Width/TimPltSlid.WinXSize;
     TimPltSlid.WinXSize := UpDownNrWin.Position*FrameTimSerPlot.Width;
     DummyBMP        := TBitmap.Create;
     DummyBMP.Width  := TimPltSlid.WinXSize;
     DummyBMP.Height := PlotWinYsize;
     DummyBMP.Canvas.Brush.Color := clBlack;
     DummyBMP.Canvas.FillRect(DummyBMP.Canvas.ClipRect);
     {Don't go above 6000 x 300 pixels}
     FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(DummyBMP);
     FrameTimSerPlot.imgTimeSerPlot.Width := TimPltSlid.WinXSize;

     FreeAndNil(DummyBMP);

     Xscale := (TimPltSlid.WinXSize - PlXbeg)/Xrange;   {Pix per Unit of measurement}
    
      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      DrawTimeSerPlotTraces(Sender,TSPlotData_BaseSubtr) else
      DrawTimeSerPlotTraces(Sender,TSPlotData_BaseNotSubtr);
      DrawTimeSerPlotXaxes;
      DrawTimeSerPlotXticks;
      DrawTimeSerPlotYaxes;
      DrawTimeSerPlotYticks;
      if (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) and (CheckBoxCursor.Checked = True) then DrawTimeSerPlotCursor;
      for i := 2 to High(VertCursor) do VertCursor[i].X := round(VertCursor[i].X*Fact);
      VertCursor[0].X := VertCursor[2].X - VCurHlfWidth;
      VertCursor[1].X := VertCursor[2].X + VCurHlfWidth;
      if MeasTrace.Down then begin
        if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);
      end;
      frmTimeSerPlot.Constraints.MinWidth := 480;
      frmTimeSerPlot.Constraints.MaxWidth := 1200;
End;
 {--------------- Color Button Group ---------------}


procedure TfrmTimeSerPlot.ToolButtonClick(Sender: TObject);
var i : integer;
begin
  for i := 0 to PLOTvar.NrROI - 1 do
   if abs(PLOTvar.AdrUsed[i]) = TToolButton(Sender).Tag then begin
    if TToolButton(Sender).Down = True  then PLOTvar.AdrUsed[i] := abs(PLOTvar.AdrUsed[i]) else
    if TToolButton(Sender).Down = False then PLOTvar.AdrUsed[i] := -(abs(PLOTvar.AdrUsed[i]));
    Break;
   end;
   if TToolButton(Sender).Grouped = True then begin
     for i := 0 to PLOTvar.NrROI - 1 do
      if abs(PLOTvar.AdrUsed[i]) <> TToolButton(Sender).Tag then PLOTvar.AdrUsed[i] := -abs(PLOTvar.AdrUsed[i]);
   end;
   RePlot(Sender);
   if (sbSlavePlot.Down) and (TimeSerAnalDone) then frmSlaveTSPlot.DrawPlot(Sender);

End;



procedure TfrmTimeSerPlot.ShowAllTracesClick(Sender: TObject);
var i : integer;

begin


  frmTimeSerPlot.InclusiveExclusive.Down := False;

 If (TimeSerAnalDone) then Begin

  For i := 0 to PLOTvar.NrROI - 1 do Begin

      PLOTvar.AdrUsed[i] := abs(PLOTvar.AdrUsed[i]);
      ColBut.Buttons[PLOTvar.AdrUsed[i]-1].Grouped := False;
      ColBut.Buttons[PLOTvar.AdrUsed[i]-1].Enabled := True;
      ColBut.Buttons[PLOTvar.AdrUsed[i]-1].Down    := True;

  End; { For i := 0 to PLOTvar.NrROI - 1}

  {do not use Replot(sender) procedure here - causes crash when SparkAn is launged 1st time}

    if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
    DrawTimeSerPlotTraces(Sender,TSPlotData_BaseSubtr)
      else
    DrawTimeSerPlotTraces(Sender,TSPlotData_BaseNotSubtr);
    DrawTimeSerPlotXaxes;
    DrawTimeSerPlotXticks;
     if (CheckBoxSymbolOn.Checked) or (PLOTvar.HasPeaks = True) then begin
        DrawTimeSerPlotYaxes;
        DrawTimeSerPlotYticks;
    end;
    If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) and (CheckBoxCursor.Checked = True) then DrawTimeSerPlotCursor;
    if (MeasTrace.Down) then MeasTraceClick(Sender);

    if (sbSlavePlot.Down) then frmSlaveTSPlot.DrawPlot(Sender);
 End;

End; {procedure TfrmTimeSerPlot.ShowAllTracesClick}
 {*************************************************************}
procedure TfrmTimeSerPlot.InclusiveExclusiveClick(Sender: TObject);
  Var i : integer;
begin

If (TimeSerAnalDone) then Begin

If frmTimeSerPlot.InclusiveExclusive.Down = True then begin
  for i := 0 to ColBut.ButtonCount-1 do Begin
    PLOTvar.AdrUsed[i] := -abs(PLOTvar.AdrUsed[i]);
    ColBut.Buttons[i].Grouped := True;
    ColBut.Buttons[i].Down    := False;
  End; {For}
  For i := 0 to ColBut.ButtonCount-1 do Begin
    if (ColBut.Buttons[i].Enabled) then begin
      ColBut.Buttons[i].Down := True; //shows the first enabled 
      ToolButtonClick(ColBut.Buttons[i]);
      Break;
    end;
  End;
 End Else 
 If (frmTimeSerPlot.InclusiveExclusive.Down = False) then begin
  for i := 0 to ColBut.ButtonCount-1 do ColBut.Buttons[i].Grouped := False;
 End; {frmTimeSerPlot.InclusiveExclusive.Down = False}

     frmTimeSerPlot.RePlot(Sender);

     if (sbSlavePlot.Down) then frmSlaveTSPlot.DrawPlot(Sender);
 End;
End;

procedure TfrmTimeSerPlot.lbFcMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;
begin
  //Get Info about Gauss Frequency
  if (Button = mbLeft) and (TimPltSlid.SmTraceKind = GAUSS1D) and
     (TimPltSlid.SmTrGaussIndex > 0) and (MainImLoaded)
  then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 49;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmTimeSerPlot.lbFcMouseEnter(Sender: TObject);
begin
  if (TimPltSlid.SmTraceKind = GAUSS1D) and
     (TimPltSlid.SmTrGaussIndex > 0) and (MainImLoaded)
  then
  lbFc.Color := clAqua;
end;

procedure TfrmTimeSerPlot.lbFcMouseLeave(Sender: TObject);
begin
  lbFc.Color := clBtnFace
end;

 {*****************************************************************}

procedure TfrmTimeSerPlot.UnDoClick(Sender: TObject);

   var  XLpos, XRpos : integer;
begin


    XLpos              := dsXaxes.PosFrom;
    XRpos              := dsXaxes.PosTo;
    dsXaxes.SetSliderPos(PLOTvar.UndoRedu[0],PLOTvar.UndoRedu[1]);
    dsXaxesChange(Sender);

    PLOTvar.UndoRedu[0] := XLpos;
    PLOTvar.UndoRedu[1] := XRpos;
    UnDo.Enabled := False;
    ReDo.Enabled := True;

end;    


procedure TfrmTimeSerPlot.ReDoClick(Sender: TObject);
{Goes back to previous selection}

   var  XLpos, XRpos : integer;
begin

    XLpos              := dsXaxes.PosFrom;
    XRpos              := dsXaxes.PosTo;
    dsXaxes.SetSliderPos(PLOTvar.UndoRedu[0],PLOTvar.UndoRedu[1]);
    dsXaxesChange(Sender);
    PLOTvar.UndoRedu[0] := XLpos;
    PLOTvar.UndoRedu[1] := XRpos;
    UnDo.Enabled := True;
    ReDo.Enabled := False;

end;


{******************************************************************************}

procedure TfrmTimeSerPlot.CheckBoxCursorClick(Sender: TObject);
begin
    TimPltSlid.CursorOn := CheckBoxCursor.Checked;
    if (TimeSerAnalDone = True) then begin
      frmTimeSerPlot.RePlot(Sender);
    end;
end;

procedure TfrmTimeSerPlot.CheckBoxSymbolOnClick(Sender: TObject);
begin
    TimPltSlid.SymbOn := CheckBoxSymbolOn.Checked;

    if (TimeSerAnalDone = True) then begin
      frmTimeSerPlot.RePlot(Sender);
    end;
end;


{----------------------- 2 procedures close window}
procedure TfrmTimeSerPlot.WMSize(var M:TWMSIZE);

begin
if (M.SizeType=Size_Minimized) and (TimeSerPlotHidden = True) then
      ShowWindow(frmTimeSerPlot.Handle,Sw_Hide)
    else inherited;  {use inherited to invoke OnResize}
End;


procedure TfrmTimeSerPlot.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     { This Was Used togheter with procedure TfrmTimeSerPlot.WMSize(var M:TWMSIZE);
     to HIDE this Form}
     TimeSerPlotHidden := True;
     if (frmTimeSerPlot.WindowState = wsMinimized) then
     ShowWindow(frmTimeSerPlot.Handle,Sw_Hide);
end;


{***************************************************************************}
procedure TfrmTimeSerPlot.ResetGaussCoeff;
var  SD : Double;
Begin

 //If (MainImageLoaded) then Begin

 with TimPltSlid do begin

 If (SmTraceKind = GAUSS1D) Then Begin
    if (SmTrGaussIndex = 1) then begin
      FiltSize1D := 3;
      SD       := 0.5;
        //SD is set to 0.5 gives 0.135335283236613   1   0.135335283236613
    end else
    if (SmTrGaussIndex = 2) then begin
      FiltSize1D := 3;
      SD      :=0.600561205;
         // gives 0.250000000700319   1   0.250000000700319
      end else
    if (SmTrGaussIndex = 3) then begin
        FiltSize1D := 3;
        SD       := 0.84932181;
        //gives 0.500000007926127   1   0.500000007926127
        //equivalent to binary Gaussian Filter 0.5   1.0   0.5
      end else
      {for all of the following:
        Nc (Number of Coeficients) := FiltSize div 2;
        SD := Nc/2;
        therefore Nc = ceil(2*SD) i.e 2 times SD
        although it is generaly used Nc = 3*SD;
      }
      if (SmTrGaussIndex = 4) then begin
        FiltSize1D := 5;
        SD       := 1.0;
      end else
      if (SmTrGaussIndex = 5) then begin
        FiltSize1D := 7;
        SD       := 1.5;
      end else
      if (SmTrGaussIndex = 6) then begin
        FiltSize1D := 9;
        SD       := 2.0;
      end else
      if (SmTrGaussIndex = 7) then begin
        FiltSize1D := 11;
        SD       := 2.5;
      end else
      if (SmTrGaussIndex = 8) then begin
        FiltSize1D := 13;
        SD       := 3.0;
      end;

      Set1DGaussCoeff(FiltSize1D,SD);
  End
    Else
  If (SmTraceKind = GAUSS1D_Fc) and (MainImLoaded) Then Begin
    Get1DGaussFltSizeAndSD(FiltSize1D,SD,TimPltSlid.FcGaussFlt,ExportDial.OrigFrameRate);
    Set1DGaussCoeff(FiltSize1D,SD);
  End;

  end;  //with TimPltSlid do begin

End;

{***************************************************************************}

procedure TfrmTimeSerPlot.cbSmTraceKindChange(Sender: TObject);
var MemOnChange : TNotifyEvent;

begin

   TimPltSlid.SmTraceKind := cbSmTraceKind.ItemIndex;
   MemOnChange := cbSmTraceFltSize.OnChange;
   cbSmTraceFltSize.OnChange := nil;

   If (TimPltSlid.SmTraceKind = BOXCART1D) then Begin
    enFcGaussFlt.Enabled := False;
    cbSmTraceFltSize.Clear;
    cbSmTraceFltSize.Items.Add('None');
    cbSmTraceFltSize.Items.Add('3');
    cbSmTraceFltSize.Items.Add('5');
    cbSmTraceFltSize.Items.Add('7');
    cbSmTraceFltSize.Items.Add('9');
    cbSmTraceFltSize.Items.Add('11');
    cbSmTraceFltSize.Items.Add('13');
    cbSmTraceFltSize.ItemIndex := TimPltSlid.SmTrBoxcarIndex;
   End Else
   If (TimPltSlid.SmTraceKind = GAUSS1D) then Begin
    enFcGaussFlt.Enabled := False;
    cbSmTraceFltSize.Clear;
    cbSmTraceFltSize.Items.Add('None');
    cbSmTraceFltSize.Items.Add('3 L');
    cbSmTraceFltSize.Items.Add('3 M');
    cbSmTraceFltSize.Items.Add('3 H');
    cbSmTraceFltSize.Items.Add('5');
    cbSmTraceFltSize.Items.Add('7');
    cbSmTraceFltSize.Items.Add('9');
    cbSmTraceFltSize.Items.Add('11');
    cbSmTraceFltSize.Items.Add('13');
    cbSmTraceFltSize.ItemIndex := TimPltSlid.SmTrGaussIndex;
    if (TimPltSlid.SmTrGaussIndex > 0) then ResetGaussCoeff;
   End Else
   If (TimPltSlid.SmTraceKind = GAUSS1D_Fc) then Begin
    enFcGaussFlt.Enabled := True;
    cbSmTraceFltSize.Clear;
    cbSmTraceFltSize.Items.Add('None');
    cbSmTraceFltSize.Items.Add('Fc');
    cbSmTraceFltSize.ItemIndex := TimPltSlid.SmTrGaussFcIndex;
    if (TimPltSlid.SmTrGaussFcIndex > 0) then ResetGaussCoeff;
   End Else
   If (TimPltSlid.SmTraceKind = KALMAN1D) then Begin
     enFcGaussFlt.Enabled := False;
     cbSmTraceFltSize.Clear;
     cbSmTraceFltSize.Items.Add('None');
     cbSmTraceFltSize.Items.Add('G=0.1');
     cbSmTraceFltSize.Items.Add('G=0.2');
     cbSmTraceFltSize.Items.Add('G=0.3');
     cbSmTraceFltSize.Items.Add('G=0.4');
     cbSmTraceFltSize.Items.Add('G=0.5');
     cbSmTraceFltSize.Items.Add('G=0.6');
     cbSmTraceFltSize.Items.Add('G=0.7');
     cbSmTraceFltSize.Items.Add('G=0.8');
     cbSmTraceFltSize.Items.Add('G=0.9');
     cbSmTraceFltSize.Items.Add('G=1.0');
     cbSmTraceFltSize.ItemIndex := TimPltSlid.SmTrKalmanIndex;
   End;

   cbSmTraceFltSize.OnChange := MemOnChange;
   cbSmTraceFltSizeChange(Sender);
end;
{***************************************************************************}

procedure TfrmTimeSerPlot.enFcGaussFltReturnPressed(Sender: TObject);
begin
  TimPltSlid.FcGaussFlt := enFcGaussFlt.NumberFloat;
  cbSmTraceFltSizeChange(Sender);
end;

procedure TfrmTimeSerPlot.cbSmTraceFltSizeChange(Sender: TObject);
  var ImNr, Cnt : integer;
      DoUpdate  : Boolean;
begin

  if (Sender = cbSmTraceFltSize) or (Sender = enFcGaussFlt) then begin
    if (TimPltSlid.SmTraceKind = BOXCART1D) then
      TimPltSlid.SmTrBoxcarIndex := cbSmTraceFltSize.ItemIndex
    else
    if (TimPltSlid.SmTraceKind = GAUSS1D) then begin
      TimPltSlid.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex;
      if (TimPltSlid.SmTrGaussIndex > 0) then ResetGaussCoeff;
    end else
    if (TimPltSlid.SmTraceKind = GAUSS1D_Fc) then begin
      TimPltSlid.SmTrGaussFcIndex := cbSmTraceFltSize.ItemIndex;
      if (TimPltSlid.SmTrGaussFcIndex > 0) then ResetGaussCoeff;
    end else
    if (TimPltSlid.SmTraceKind = KALMAN1D) then begin
      TimPltSlid.SmTrKalmanIndex := cbSmTraceFltSize.ItemIndex;
    end;
  end;

  If  (TimeSerAnalDone = True) then begin
    DoUpdate := True;

    if (Sender = cbSmTraceFltSize) then begin
      if (PLOTvar.SmTraceKind = BOXCART1D) then if
        (PLOTvar.SmTrBoxcarIndex = cbSmTraceFltSize.ItemIndex)
      then DoUpdate := False;

      if (PLOTvar.SmTraceKind = GAUSS1D) then if
        (PLOTvar.SmTrGaussIndex = cbSmTraceFltSize.ItemIndex)
      then DoUpdate := False;

      if (PLOTvar.SmTraceKind = GAUSS1D_Fc) then if
        (PLOTvar.SmTrGaussFcIndex = cbSmTraceFltSize.ItemIndex) and
        (PLOTvar.FcGaussFlt  = TimPltSlid.FcGaussFlt)
      then DoUpdate := False;

      if (PLOTvar.SmTraceKind = KALMAN1D) then if
        (PLOTvar.SmTrKalmanIndex = cbSmTraceFltSize.ItemIndex)
      then DoUpdate := False;

    end;
    //if (Sender = cbSmTraceKind) then Trace Must be updated

  End else
  DoUpdate := False;

  If  (DoUpdate) then Begin

      PLOTvar.SmTraceKind := cbSmTraceKind.ItemIndex;
      if (PLOTvar.SmTraceKind = BOXCART1D) then
        PLOTvar.SmTrBoxcarIndex := cbSmTraceFltSize.ItemIndex else
      if (PLOTvar.SmTraceKind = GAUSS1D) then
        PLOTvar.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex else
      if (PLOTvar.SmTraceKind = GAUSS1D_Fc) then begin
        PLOTvar.SmTrGaussFcIndex := cbSmTraceFltSize.ItemIndex;
        PLOTvar.FcGaussFlt  := TimPltSlid.FcGaussFlt;
      end else
      if (PLOTvar.SmTraceKind = KALMAN1D) then
        PLOTvar.SmTrKalmanIndex := cbSmTraceFltSize.ItemIndex;

      if (cbSmTraceFltSize.ItemIndex > 0) {smoothing} then Begin

        SmoothTrace(TSPlotData_BackUp,TSPlotData_BaseNotSubtr);

      End Else

      If (cbSmTraceFltSize.ItemIndex = 0) {no smoothing} then Begin
        For Cnt := 0 to PLOTvar.NrROI -1 Do Begin
          For ImNr := 0 to High(TSPlotData_BackUp[0]) Do Begin
            TSPlotData_BaseNotSubtr[Cnt,ImNr] := TSPlotData_BackUp[Cnt,ImNr];
          End; {for}
        End;   {for}
      End; //If SmoothTrace.ItemIndex = 0 = no smoothing

      PLOTvar.BaseLineStatus := NO_BASELINE;
      ReDoBaseLineAndPeaks(Sender);
      RePlot(Sender);
      if (sbSlavePlot.Down) and (TimeSerAnalDone) then frmSlaveTSPlot.DrawPlot(Sender);

  End; {TimeSerAnalDone = True}

End;

{*******************************************************************************}

Procedure TfrmTimeSerPlot.SmoothTrace(const RawTrace : TDyn2DDoubleArr; var SmoothedTrace : TDyn2DDoubleArr);
 {smooths Time Series Plot Traces} {smooths Time Series Plot Traces}
 var  CntROI : Integer;
      pSourceArr,pOutArr : pDoubleArr;
      EndOfArray : LongInt;
      Gain       : Double;
 Begin

  //Find FiltSize//
  If (TimPltSlid.SmTraceKind = BOXCART1D) then Begin
    with cbSmTraceFltSize do FiltSize1D := StrToInt(Items.Strings[ItemIndex]);
    For CntROI := 0 to PLOTvar.NrROI -1 Do Begin
      pSourceArr := @RawTrace[CntROI,0];
      pOutArr    := @SmoothedTrace[CntROI,0];
      EndOfArray := High(RawTrace[0]);
      BoxCar1DFilt(pSourceArr,pOutArr,FiltSize1D, EndOfArray);
    End;
  End Else
  If (TimPltSlid.SmTraceKind = GAUSS1D) then with TimPltSlid do begin
    if (SmTrGaussIndex = 1) then FiltSize1D := 3 else
    if (SmTrGaussIndex = 2) then FiltSize1D := 3 else
    if (SmTrGaussIndex = 3) then FiltSize1D := 3 else
    if (SmTrGaussIndex = 4) then FiltSize1D := 5 else
    if (SmTrGaussIndex = 5) then FiltSize1D := 7 else
    if (SmTrGaussIndex = 6) then FiltSize1D := 9 else
    if (SmTrGaussIndex = 7) then FiltSize1D := 11 else
    if (SmTrGaussIndex = 8) then FiltSize1D := 13;
    For CntROI := 0 to PLOTvar.NrROI -1 Do Begin
      pSourceArr := @RawTrace[CntROI,0];
      pOutArr    := @SmoothedTrace[CntROI,0];
      EndOfArray := High(RawTrace[0]);
      Gauss1DFilt(pSourceArr,pOutArr,FiltSize1D, EndOfArray);
    End;
  End Else
  If (TimPltSlid.SmTraceKind = GAUSS1D_Fc) then begin
     For CntROI := 0 to PLOTvar.NrROI -1 Do Begin
      pSourceArr := @RawTrace[CntROI,0];
      pOutArr    := @SmoothedTrace[CntROI,0];
      EndOfArray := High(RawTrace[0]);
      Gauss1DFilt(pSourceArr,pOutArr,FiltSize1D, EndOfArray);
    End;
  end else
  If (TimPltSlid.SmTraceKind = KALMAN1D) then Begin
      Gain := (cbSmTraceFltSize.ItemIndex)/10;

    For CntROI := 0 to PLOTvar.NrROI -1 Do Begin
      pSourceArr := @RawTrace[CntROI,0];
      pOutArr    := @SmoothedTrace[CntROI,0];
      EndOfArray := High(RawTrace[0]);
      Kalman1DFilt(pSourceArr,pOutArr,Gain, EndOfArray);
    End;
  End Else

 End;  //Procedure DoSmoothTrace; {smooths Time Series Plot Traces}
 {*****************************************************************************}

function GetKalmanGain : Double;
begin


end;

procedure TfrmTimeSerPlot.pnlPlotXrangeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{ReleaseCapture;
  TWinControl(Sender).perform(WM_SYSCOMMAND, $F012, 0);}
  {This Works with control which is inherited from TWinControl (windowed control)}
{Enables Moving the Panel whitin the Form}
end;

procedure TfrmTimeSerPlot.QuestionInfoClick(Sender: TObject);
var HelpCode : integer;

begin

  HELP_Point := Mouse.CursorPos;
  HelpCode    := 44;
  GetHelp(HelpCode);

end;

{---------------- Type In Values Widgets --------------------------------------}
procedure TfrmTimeSerPlot.edBaseFromKeyPress(Sender: TObject;
  var Key: Char);
begin
     If Ord(Key) <> 8 Then Begin    {Ord(Key) = 8 = BackWards - deletes}
       if (not (Key in Digits)) then Key := #0;
     End;
end;
              

procedure TfrmTimeSerPlot.sbSetRangeClick(Sender: TObject);

begin
  If (MainImLoaded) and (NrIm > 1) then Begin
      enRangeFromTo.Enabled := sbSetRange.Down;
      if    (sbSetRange.Down) then sbSetRange.Font.Color := clRed
        else
      if not(sbSetRange.Down) then begin
        sbSetRange.Font.Color := clBlack;
        enRangeFromTo.SetNumbersOneTwo((dsXaxes.PosFrom + 1),(dsXaxes.PosTo + 1));
      end;
  end else
  If (MainImLoaded = False) or (NrIm = 1) Then sbSetRange.Down := False;


End;


procedure TfrmTimeSerPlot.ShowMinsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var  HelpCode : integer;
begin
    if (Button = mbLeft) and (PLOTvar.AllowFreezeMin) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 0;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmTimeSerPlot.FreezeMeanClick(Sender: TObject);
begin

   if FreezeMean.Down = True  then Begin
    FreezeMean.Font.Color := clRed;
    if sbSetRange.Down then  sbSetRange.Down := False;
    sbSetRangeClick(sender);
   end else
   if FreezeMean.Down = False then begin
    FreezeMean.Font.Color := clBlack;
   end;
   if (cbTraceDivMin.Checked) then sbSetRange.Enabled := Not(FreezeMean.Down);
   enTraceMinPoints.Enabled := Not(FreezeMean.Down);
   FreezeMean.Enabled := PLOTvar.AllowFreezeMin;
   if PLOTvar.AllowFreezeMin = True then
    ShowMins.Font.Color := clBlack else
   if PLOTvar.AllowFreezeMin = False then
    ShowMins.Font.Color := clGray;
   
end;
{--------End of Type In Values Widgets --------------------------------------}

procedure TfrmTimeSerPlot.FormResize(Sender: TObject);
Var DeltaChange : Integer;
    DummyBMP    : TBitmap;
    Button: TUDBtnType;
begin
   InitialWidth := 705 + 2*GetSystemMetrics(SM_CXFRAME); //has to be here
   DeltaChange := (InitialWidth - frmTimeSerPlot.Width);
   {--- Changes Size of Plot ---------}
 
   FrameTimSerPlot.Width := 600 - DeltaChange;
   TimPltSlid.WinXSize   := UpDownNrWin.Position*(600 - DeltaChange);

   if Not(UpDownNrWin.Enabled) then begin
     //just fills in with black
    FrameTimSerPlot.imgTimeSerPlot.Width := FrameTimSerPlot.Width;
    DummyBMP        := TBitmap.Create;
    DummyBMP.Width  := TimPltSlid.WinXSize;
    DummyBMP.Height := PlotWinYsize;
    DummyBMP.Canvas.Brush.Color := clBlack;
    DummyBMP.Canvas.FillRect(DummyBMP.Canvas.ClipRect);
    FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(DummyBMP);
    if Not(frmSlaveTSPlot = nil) then begin 
      frmSlaveTSPlot.imTSPlot.Width := TimPltSlid.WinXSize;
      frmSlaveTSPlot.imTSPlot.Picture.Bitmap.Assign(DummyBMP);
    end;
    FreeAndNil(DummyBMP);    
   end;

   {Changes Double Scrollbars ---------}

   enXaxes.Left        := 560 - DeltaChange;
   dsXaxes.Width       := 503 - DeltaChange;

   If (dsXaxes.Enabled) then Begin
    Xrange :=  dsXaxes.PosTo - dsXaxes.PosFrom;
    Xscale := (TimPltSlid.WinXSize - PlXbeg)/Xrange;   {Pix per Unit of measurement}
   End;        

   dsAnalRange.Width   := 503 - DeltaChange;
   enAnalFromTo.Left   := 560 - DeltaChange;

   {---------- Progress Bar & Label }
   ProgBarTimSerPlot.Width := 534 - DeltaChange;
   lbImNum.Left :=            589 - DeltaChange;

   ubCopyRangeFromXaxis.Left := 644 - DeltaChange;

   {------- Pannel with the Buttons }
    panButtons.Left := 653 - (InitialWidth - frmTimeSerPlot.Width);
    // ---  all imgTimeSerPlot update and drawing should be done by this procedure
   If UpDownNrWin.Enabled then Begin
    UpDownNrWinClick(Sender,Button);
    if Not(frmSlaveTSPlot = nil) then begin
     DummyBMP        := TBitmap.Create;
     DummyBMP.Width  := TimPltSlid.WinXSize div UpDownNrWin.Position ;
     DummyBMP.Height := PlotWinYsize;
     DummyBMP.Canvas.Brush.Color := clBlack;
     DummyBMP.Canvas.FillRect(DummyBMP.Canvas.ClipRect);      
     frmSlaveTSPlot.imTSPlot.Width := DummyBMP.Width;
     frmSlaveTSPlot.imTSPlot.Picture.Bitmap.Assign(DummyBMP);
     if (sbSlavePlot.Down) and (TimeSerAnalDone) then frmSlaveTSPlot.DrawPlot(Sender);
     FreeAndNil(DummyBMP);
    end;
   End;
   
End;



procedure TfrmTimeSerPlot.FormShow(Sender: TObject);
begin
    lbFinalPoints.Caption := '= ' + IntToStr(GetFinalEventWidth(StrToInt(NrPasses.Items[NrPasses.ItemIndex])));
end;

procedure TfrmTimeSerPlot.sbSlavePlotClick(Sender: TObject);
begin
    if (sbSlavePlot.Down) then begin
      if (frmSlaveTSPlot = nil) then Application.CreateForm(TfrmSlaveTSPlot,frmSlaveTSPlot);
      if (TimeSerAnalDone) then frmSlaveTSPlot.DrawPlot(Sender);
    end else
    if not(sbSlavePlot.Down) then begin
      if not(frmSlaveTSPlot = nil) then frmSlaveTSPlot.Close;
    end;
end;

procedure TfrmTimeSerPlot.sbTraceToDisplayClick(Sender: TObject);
begin
    if (sbSlavePlot.Down) and (TimeSerAnalDone) then
    if frmSlaveTSPlot <> nil then frmSlaveTSPlot.DrawPlot(Sender);
end;


procedure TfrmTimeSerPlot.scrbPeakThreshChange(Sender: TObject);
begin
   lbPeakThresh.Caption := FloatToStrF(scrbPeakThresh.Position/100,ffFixed,3,2);
   TimPltSlid.PeakThresh := scrbPeakThresh.Position;
end;   

procedure TfrmTimeSerPlot.btGetPeeksClick(Sender: TObject);
begin

  If (TimeSerAnalDone) and (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) and (cbGetPeaks.Checked) Then Begin
      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      GetPeaks(TSPlotData_BaseSubtr) else
      GetPeaks(TSPlotData_BaseNotSubtr);

      Replot(Sender);
      //Sends message to frmHistogram
   if (frmTimeHistograms <> nil) then begin
    if (frmTimeHistograms.rbPlot.Checked) then frmTimeHistograms.GetMessageFromSeriesPlot;
   end;
  End;
End;

function TfrmTimeSerPlot.GetPeakIndex : Integer;
var CntPeak,TraceNr,ImNr : Integer;
begin

   Result := -1;  //gives the Image Number where is the peak

   TraceNr   := TraceSel.ItemIndex; //All Avaliable Traces = Starts from Zero = ROI Number
   ImNr := round((VertCursor[2].X - PlXBeg)/Xscale) + frmTimeSerPlot.dsXaxes.PosFrom;

 //finds if Cursor is positioned on peak
    for CntPeak := 0 to High(PeakPosArr[TraceNr]) do begin
       if (ImNr = PeakPosArr[TraceNr,CntPeak] + PLOTvar.ImBeg) then begin
        Result := CntPeak;
        Break;
       end;
    end;
end;

procedure TfrmTimeSerPlot.GoToImageClick(Sender: TObject);
var ImNr : Integer; //Image Number Pointed by the Cursor
begin

  ImNr := round((VertCursor[2].X - PlXBeg)/Xscale) + frmTimeSerPlot.dsXaxes.PosFrom;
  ImNr := ImNr div JumpAv;

  if (ImNr <> CurIm) then begin
    with frmPlayback do begin
    Stop.Down := True;
    StopClick(Sender);

    if (LockImagesToLoop.Down) then begin //relese lock if needed
      if (CurIm < PlaybackScrollBar.Min) or (CurIm > PlaybackScrollBar.Max) then begin
      LockImagesToLoop.Down := False;
      LockImagesToLoop.Click;
      end;
    end;

    PlaybackScrollBar.Position := ImNr;  //PlaybackScrollBar.OnChange sets CurIm
    end; //with
  end;

End;

procedure TfrmTimeSerPlot.DeletePeak (Sender : TObject);
var TraceNr,PeakIndex,CntPeak,CntTraces,NrPeaks : Integer;
begin

  TraceNr   := TraceSel.ItemIndex; //All Avaliable Traces = Starts from Zero = ROI Number

  If (PLOTvar.HasPeaks) and (TraceSel.Enabled) and
      (PLOTvar.AdrUsed[TraceNr] > 0) and (High(PeakPosArr[TraceNr]) > -1) then Begin

      PeakIndex := GetPeakIndex;
      
    // Length(PeakPosArr) = PLOTvar.NrROI if there is at least One Peak in at least One Trace
    If (PeakIndex >= 0) then begin

      sbUnDoDelPeak.Enabled := True;
      sbUnDoDelPeak.Tag     := PeakIndex;
      sbDelPeak.Tag         := TraceNr;

      // -------------- Backs Up Arrays ------------------------------------//
      UnDoPeakPos      := PeakPosArr[TraceNr,PeakIndex];
      UnDoPeakVal      := PeakValArr[TraceNr,PeakIndex];
      UnDoPeakBas      := PeakBasArr[TraceNr,PeakIndex];
      UnDoPeakTim      := PeakTimArr[TraceNr,PeakIndex];
      UnDoRiseTime     := RiseTimeArr[TraceNr,PeakIndex];
      UnDoPeakFakeImNr := PeakFakeImNrArr[TraceNr,PeakIndex];
      if (PLOTvar.GetEachPeakBase) then
      UnDoBaseImNrArr  := BaseImNrArr[TraceNr,PeakIndex];

       //------------ End with Backing Up data ----------------------------//

       //-----------  Deletings Peaks -------------------------------------//

       //1st: Check if this is the Only Peak in All Traces//
       NrPeaks := 0;
       for CntTraces := 0 to High(PeakPosArr) do Inc(NrPeaks,Length(PeakPosArr[CntTraces]));

       if (NrPeaks = 1) then PLOTvar.HasPeaks := False;

       If (Length(PeakPosArr[TraceNr]) > 1) then Begin

          Inc(PeakIndex); // to start from PeakIndex + 1

          for CntPeak := PeakIndex to High(PeakPosArr[TraceNr]) do
            PeakPosArr[TraceNr,CntPeak-1] := PeakPosArr[TraceNr,CntPeak];

          for CntPeak := PeakIndex to High(PeakValArr[TraceNr]) do
            PeakValArr[TraceNr,CntPeak-1] := PeakValArr[TraceNr,CntPeak];

          for CntPeak := PeakIndex to High(PeakBasArr[TraceNr]) do
            PeakBasArr[TraceNr,CntPeak-1] := PeakBasArr[TraceNr,CntPeak];

          for CntPeak := PeakIndex to High(PeakTimArr[TraceNr]) do
            PeakTimArr[TraceNr,CntPeak-1] := PeakTimArr[TraceNr,CntPeak];

          for CntPeak := PeakIndex to High(RiseTimeArr[TraceNr]) do
            RiseTimeArr[TraceNr,CntPeak-1] := RiseTimeArr[TraceNr,CntPeak];

          for CntPeak := PeakIndex to High(PeakFakeImNrArr[TraceNr]) do
            PeakFakeImNrArr[TraceNr,CntPeak-1] := PeakFakeImNrArr[TraceNr,CntPeak];

          if (PLOTvar.GetEachPeakBase) then
          for CntPeak := PeakIndex to High(BaseImNrArr[TraceNr]) do
            BaseImNrArr[TraceNr,CntPeak-1] := BaseImNrArr[TraceNr,CntPeak];


       End; //   (Length(PeakPosArr[TraceNr]) > 1) then Begin

        SetLength(PeakPosArr[TraceNr],Length(PeakPosArr[TraceNr]) - 1);
        SetLength(PeakValArr[TraceNr],Length(PeakValArr[TraceNr]) - 1);
        SetLength(PeakBasArr[TraceNr],Length(PeakBasArr[TraceNr]) - 1);
        SetLength(PeakTimArr[TraceNr],Length(PeakTimArr[TraceNr]) - 1);
        SetLength(RiseTimeArr[TraceNr],Length(RiseTimeArr[TraceNr]) - 1);
        SetLength(PeakFakeImNrArr[TraceNr],Length(PeakFakeImNrArr[TraceNr]) - 1);
        if (PLOTvar.GetEachPeakBase) then
        SetLength(BaseImNrArr[TraceNr],Length(BaseImNrArr[TraceNr]) - 1);
     
      //ReDrawing the Plot and Peak Table//
      Replot(Sender);
      if (frmPeaks <> nil) then begin
        if PLOTvar.HasPeaks then frmPeaks.FillPeakTable else
                                 frmPeaks.ClearPeakTable;
      end;
      //Sends message to frmHistogram
      if (frmTimeHistograms <> nil) then begin
        if (frmTimeHistograms.rbPlot.Checked) then frmTimeHistograms.GetMessageFromSeriesPlot;
      end;
      //End ReDrawing the Plot and Peak Table//

    End Else //If (PeakIndex >= 0) then begin
      MessageDlg('Cursor Not Position on Peak',mtError,[mbOK],0);

  End; //If (PLOTvar.HasPeaks) and (TraceSel.Enabled) and .......

End;  //procedure TfrmTimeSerPlot.DeletePeak;

                                
procedure TfrmTimeSerPlot.sbDelPeakClick(Sender: TObject);
begin

  DeletePeak(sender);

End; // procedure sbDelPeakClick(Sender: TObject);

procedure TfrmTimeSerPlot.sbUnDoDelPeakClick(Sender: TObject);
var TraceNr,CntPeak,PeakIndex : Integer;
begin

      PeakIndex := sbUnDoDelPeak.Tag;
      TraceNr   := sbDelPeak.Tag;

      SetLength(PeakPosArr[TraceNr],Length(PeakPosArr[TraceNr]) + 1);
      SetLength(PeakValArr[TraceNr],Length(PeakValArr[TraceNr]) + 1);
      SetLength(PeakBasArr[TraceNr],Length(PeakBasArr[TraceNr]) + 1);
      SetLength(PeakTimArr[TraceNr],Length(PeakTimArr[TraceNr]) + 1);
      SetLength(RiseTimeArr[TraceNr],Length(RiseTimeArr[TraceNr]) + 1);
      SetLength(PeakFakeImNrArr[TraceNr],Length(PeakFakeImNrArr[TraceNr]) + 1);
      if (PLOTvar.GetEachPeakBase) then
      SetLength(BaseImNrArr[TraceNr],Length(BaseImNrArr[TraceNr]) + 1);



      If (Length(PeakPosArr[TraceNr]) > 1) Then begin

        Inc(PeakIndex);

        for CntPeak := High(PeakPosArr[TraceNr]) downto PeakIndex do
          PeakPosArr[TraceNr,CntPeak] := PeakPosArr[TraceNr,CntPeak-1];

        for CntPeak := High(PeakValArr[TraceNr])  downto PeakIndex do
          PeakValArr[TraceNr,CntPeak] := PeakValArr[TraceNr,CntPeak-1];

        for CntPeak := High(PeakBasArr[TraceNr]) downto PeakIndex do
          PeakBasArr[TraceNr,CntPeak] := PeakBasArr[TraceNr,CntPeak-1];

        for CntPeak := High(PeakTimArr[TraceNr]) downto PeakIndex do
          PeakTimArr[TraceNr,CntPeak] := PeakTimArr[TraceNr,CntPeak-1];

        for CntPeak := High(RiseTimeArr[TraceNr]) downto PeakIndex do
          RiseTimeArr[TraceNr,CntPeak] := RiseTimeArr[TraceNr,CntPeak-1];

        for CntPeak := High(PeakFakeImNrArr[TraceNr]) downto PeakIndex do
          PeakFakeImNrArr[TraceNr,CntPeak] := PeakFakeImNrArr[TraceNr,CntPeak-1];

        if (PLOTvar.GetEachPeakBase) then
        for CntPeak := High(BaseImNrArr[TraceNr]) downto PeakIndex do
          BaseImNrArr[TraceNr,CntPeak] := BaseImNrArr[TraceNr,CntPeak-1];


        Dec(PeakIndex);

      End; //If (Length(PeakPosArr[TraceNr]) > 1) Then begin
      
      PeakPosArr[TraceNr,PeakIndex]      := UnDoPeakPos;
      PeakValArr[TraceNr,PeakIndex]      := UnDoPeakVal;
      PeakBasArr[TraceNr,PeakIndex]      := UnDoPeakBas;
      PeakTimArr[TraceNr,PeakIndex]      := UnDoPeakTim;
      RiseTimeArr[TraceNr,PeakIndex]     := UnDoRiseTime;
      PeakFakeImNrArr[TraceNr,PeakIndex] := UnDoPeakFakeImNr;
      if (PLOTvar.GetEachPeakBase) then
      BaseImNrArr[TraceNr,PeakIndex] := UnDoBaseImNrArr;

      sbUnDoDelPeak.Enabled := False;

      PLOTvar.HasPeaks := True;
      
      //ReDrawing the Plot and Peak Table//
      Replot(Sender);
      if (frmPeaks <> nil) then  frmPeaks.FillPeakTable;
      //Sends message to frmHistogram
      if (frmTimeHistograms <> nil) then begin
        if (frmTimeHistograms.rbPlot.Checked) then frmTimeHistograms.GetMessageFromSeriesPlot;
      end;
      //End ReDrawing the Plot and Peak Table//

end;


{************ Begin VCL for Separate Bases for each peak *************}
procedure TfrmTimeSerPlot.cbGetEachPeakBaseClick(Sender: TObject);
begin
      TimPltSlid.GetEachPeakBase := cbGetEachPeakBase.Checked;
end;


procedure TfrmTimeSerPlot.edEachPeakBasePtReturnPressed(Sender: TObject);
begin
      TimPltSlid.EachPeakBasePt := edEachPeakBasePt.NumberOne;
end;



procedure TfrmTimeSerPlot.edEachPeakBaseRgReturnPressed(Sender: TObject);
begin
     TimPltSlid.EachPeakBaseRg := edEachPeakBaseRg.NumberOne;
end;

{************ End VCL for Separate Bases for each peak *************}

procedure TfrmTimeSerPlot.cbGetPeaksClick(Sender: TObject);
begin
     TimPltSlid.GetPeaks := cbGetPeaks.Checked;
end;

procedure TfrmTimeSerPlot.MeasTraceClick(Sender: TObject);
  var i        : integer;
      ROIfound : Boolean;
      CurIndex : integer;
begin                {  MeasTrace.Down frmTimeSerPlot.MeasTraceClick(Sender}
    TraceSel.Enabled := MeasTrace.Down;
    TimPltSlid.MeasTraceDown := MeasTrace.Down;
    TraceSel.Clear;
    ROIfound := False;
    CurIndex := 0;

    If (MeasTrace.Down) and (PLOTvar.NrROI > 0) then Begin
      For i := 0 to PLOTvar.NrROI - 1 do Begin
        If PLOTvar.AdrUsed[i] <> 0 then Begin
           {abs to convert neg values of Hidden traces}
          TraceSel.AddItem(IntToStr(abs(PLOTvar.AdrUsed[i])),nil);
          if PLOTvar.LastROIMesCur = PLOTvar.AdrUsed[i] then begin
            ROIfound := True;
            CurIndex := i;
          end;
        End;
      End;
      TraceSel.ItemIndex := CurIndex;
      if PlotMemBMP = nil then PlotMemBMP := TBitmap.Create;
      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
      DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);

    End else; {if (TraceSel.Enabled) and (PLOTvar.NrROI > 0)}
    If (MeasTrace.Down = False) and (PLOTvar.NrROI > 0) then Begin
      FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(PlotMemBMP);
      FreeAndNil(PlotMemBMP);
      PLOTvar.LastROIMesCur := 0;
    End;
 
End;

procedure TfrmTimeSerPlot.NrPassesChange(Sender: TObject);
begin
   PLOTvar.BaseLineStatus := NO_BASELINE;
   lbFinalPoints.Caption := '= ' + IntToStr(GetFinalEventWidth(StrToInt(NrPasses.Items[NrPasses.ItemIndex])));
   TimPltSlid.NrPassesIndex := NrPasses.ItemIndex;
end;     


Procedure TfrmTimeSerPlot.DrawMesCursor(Sender : TObject; Const PlotData : TDyn2DDoubleArr);
var ImNr         : integer;
    TraceNr      : integer; {from 1 to 20}
    ROINr        : integer; {as they exist in PlotData from 0 to .., }
    LineYpos     : integer;
    DigAftZero   : integer;
    ValStr       : AnsiString;
    TextXPos     : integer;
Begin
  if (Sender <> FrameTimSerPlot.imgTimeSerPlot) then
    PlotMemBMP.Assign(FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap);

  with FrameTimSerPlot.imgTimeSerPlot do begin
    TraceNr := StrToInt(TraceSel.Items[TraceSel.ItemIndex]);
    ROINr   := TraceSel.ItemIndex;
    Canvas.Brush.Color := ROIvar.ROICol[TraceNr];
    Canvas.Pen.Color   := Canvas.Brush.Color;
    Canvas.Pen.Mode    := pmCopy;
    Canvas.Polygon(VertCursor);
     {BegIm   := frmTimeSerPlot.XaxLbut.Position}
    ImNr := round((VertCursor[2].X - PlXBeg)/Xscale) + dsXaxes.PosFrom;
    if (ImNr > NrIm - 1) then ImNr := NrIm - 1;
    LineYpos  := PlYbeg-round(Yscale*PlotData[ROINr,ImNr-PLOTvar.ImBeg]
                                  - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);

    if (PlotData[ROINr,ImNr-PLOTvar.ImBeg] > frmTimeSerPlot.dsYaxes.PosFrom) and
       (PlotData[ROINr,ImNr-PLOTvar.ImBeg] < frmTimeSerPlot.dsYaxes.PosTo) then begin
      Canvas.MoveTo(VertCursor[2].X-VCurLineHlfWidth,LineYpos);
      Canvas.LineTo(VertCursor[2].X+VCurLineHlfWidth,LineYpos);
    end;

    if (PLOTvar.AnalType = RATIO_TIME) then
    ValStr := FloatToStrF(PlotData[ROINr,ImNr-PLOTvar.ImBeg]/10,ffFixed,5,2) + ' F/Fo' else
    if (PLOTvar.AnalType =  Ch_div_Ch_RATIO_TIME) then begin
      if (PLOTvar.ChannelOrderUsed = ASCENDING)  then
      ValStr := FloatToStrF(PlotData[ROINr,ImNr-PLOTvar.ImBeg]/10,ffFixed,5,2) + ' Ch1/Ch2' else
      if (PLOTvar.ChannelOrderUsed = DESCENDING)  then
      ValStr := FloatToStrF(PlotData[ROINr,ImNr-PLOTvar.ImBeg]/10,ffFixed,5,2) + ' Ch2/Ch1';
    end else
    if (PLOTvar.AnalType = Ca_CONC_TIME) then
    ValStr := FloatToStrF(PlotData[ROINr,ImNr-PLOTvar.ImBeg]/10,ffFixed,5,2) + ' Ca (µM)' else
    if (PLOTvar.AnalType = INTENSITY_TIME) then
    ValStr := FloatToStrF(PlotData[ROINr,ImNr-PLOTvar.ImBeg],ffFixed,5,1) + ' int' else
    if (PLOTvar.AnalType = DISTANCE_TIME) then
    ValStr := FloatToStrF(PlotData[ROINr,ImNr-PLOTvar.ImBeg],ffFixed,5,2) + ' ' + Char(181) + 'm'; //micro

    DigAftZero := 6 - Length(IntToStr(trunc(MeanImTime*1000)));  {ms}

    With PLOTvar do begin
    if not(MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then
      ValStr := IntToStr(ImNr + 1) + ' im, ' +
        FloatToStrF(CopyOfTimeSt[ImNr-PLOTvar.ImBeg],ffFixed,9,DigAftZero) + ' s, ' + ValStr
      else
    if (MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then begin
      if (MovFType in[ANDOR_MOV,BIORAD_PIC]) then begin
        if (MovieSeriesType = TimeSeries) then
          ValStr := IntToStr(ImNr + 1) + ' im, ' +
          FloatToStrF(CopyOfTimeSt[ImNr-PLOTvar.ImBeg],ffFixed,9,DigAftZero) + ' s, ' + ValStr
          else
        if (MovieSeriesType = Z_Stack) then
          ValStr := IntToStr(ImNr + 1) + ' im, ' +
          FloatToStrF(ZstackArr[ImNr],ffFixed,9,2) + ' µm, ' +
          FloatToStrF(CopyOfTimeSt[ImNr-PLOTvar.ImBeg],ffFixed,9,DigAftZero) + ' s, ' + ValStr
      end
        else
      if (MovFType = ZEISS_CZI_LSM_MOV) then begin
        if (MovieSeriesType = TimeSeries) then
          ValStr := IntToStr(ImNr + 1) + ' im, ' +
            FloatToStrF(CopyOfTimeSt[ImNr-PLOTvar.ImBeg],ffFixed,9,DigAftZero) + ' s, ' + ValStr
          else
        if (MovieSeriesType = Z_Stack) then
          ValStr := IntToStr(ImNr + 1) + ' im, ' +
            FloatToStrF(CopyOfTimeSt[ImNr-PLOTvar.ImBeg],ffFixed,9,DigAftZero) + ' µm, ' + ValStr
      end;
    end;//if (MovFType in[ANDOR_MOV,ZEISS_CZI_LSM_MOV]) then begin
    End; //with

    if (VertCursor[1].X + 5) + Canvas.TextWidth(ValStr) < FrameTimSerPlot.Width then
         TextXPos := VertCursor[1].X + 5 else
         TextXPos := VertCursor[0].X - 5 - Canvas.TextWidth(ValStr);
    { Text Settings}
    Canvas.Brush.Color := clSkyBlue;
    Canvas.Font.Color := clBlack;
    Canvas.TextOut(TextXPos,15,ValStr);
 end; {with}
End;

procedure TfrmTimeSerPlot.TraceSelChange(Sender : TObject);
begin
      FrameTimSerPlot.imgTimeSerPlot.Picture.Bitmap.Assign(PlotMemBMP);
      PLOTvar.LastROIMesCur := StrToInt(TraceSel.Items[TraceSel.ItemIndex]);
      if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseSubtr) else
        frmTimeSerPlot.DrawMesCursor(Sender,TSPlotData_BaseNotSubtr);
end;

Procedure TfrmTimeSerPlot.SetTrace(const TrNr : integer; const sender : Tobject);
  var i : integer;
  Begin

      for i := 0 to TraceSel.Items.Count - 1 do Begin
        if StrToInt(TraceSel.Items[i]) = TrNr then begin
         TraceSel.ItemIndex := i;
         TraceSelChange(Sender);
         Break;
        end;
      end;
End;


procedure TfrmTimeSerPlot.ToolButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

     If (Button = mbRight) and (MeasTrace.Down) then Begin
        SetTrace(TToolButton(Sender).Tag,Sender);
     End
      Else
     If (Button = mbMiddle) then Begin
        CurROIadr := TToolButton(Sender).Tag;
        DeleteROI;
        UpdateMainImage(True);
        if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);

        if (ROIvar.TickLine > 0) and (ROIvar.TickLine = CurROIadr) then begin
          ROIvar.TickLine := 0;
          frmTimeSerPlot.RePlot(Sender);
        end;
     End;

End;

procedure TfrmTimeSerPlot.FrameTimSerPlotimgTimeSerPlotMouseLeave(
  Sender: TObject);
begin
   FrameTimSerPlot.lblCursorVal.Visible := False;
end;

procedure TfrmTimeSerPlot.DisableAndReleaseTraceButtons;
var Cnt : Integer;
begin
  for Cnt := 0 to ColBut.ButtonCount-1 do begin
    ColBut.Buttons[Cnt].Down    := False;
    ColBut.Buttons[Cnt].Enabled := False;
  end;
End;
END. {Form}
