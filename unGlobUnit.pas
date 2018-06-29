{$POINTERMATH ON}
//enables pW := pW + 1; Inc and Dec dont need this directive
//enables also pW[i], like pointer to Word to act like pointer to Array like C language
{$D-,L-,O+,Q-,R-,Y-,S-}
{ these decrease the Size and Optimize Code
  D- will prevent placing Debug info to your code.
  L- will prevent placing local symbols to your code.
  O+ will optimize your code, remove unnecessary variables etc.
  Q- removes code for Integer overflow-checking.
  R- removes code for range checking of strings, arrays etc.
  S- removes code for stack-checking. USE ONLY AFTER HEAVY TESTING !
  Y- will prevent placing symbol information to your code. }
/// //////////////////////////////////////////////////////////////////////

unit unGlobUnit;

interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.AnsiStrings,System.StrUtils, System.Math,Vcl.Forms, Vcl.Graphics, Vcl.Controls,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Menus,
  Vcl.Grids,Vcl.Direct2D, Winapi.D2D1,Winapi.DxgiFormat, VCLTee.TeEngine,
  Vcl.Clipbrd, Winapi.OpenGL, EditNumerical, SuperSubLabel; // these 3 are for MPE & AVI they must be here  not down

CONST

  Digits       = ['0' .. '9']; { set of AnsiChar }
  DigitsFlt    = ['0' .. '9', '.']; { set of AnsiChar }
  Dig13579     = ['1', '3', '5', '7', '9']; { set of AnsiChar }
 // Zm = 1;

  { ------------------------- Custom Cursors Constants ------------------------- }
  crAim        = 1; //introduced Oct 3, 2013 for the Orthogonal Sections Viewer
  crBlackArrow = 2;
  crCircle     = 3;
  crHSplitter  = 4; //introduced Oct 3, 2013 for the Orthogonal Sections Viewer
  crResizeAll  = 5; //introduced Oct 3, 2013 for the Orthogonal Sections Viewer
  crVSplitter  = 6; //introduced Oct 3, 2013 for the Orthogonal Sections Viewer
  {I used the Borland Image Editor to make them, and XN Resource Editor to Set
    the Hot Spot.  Making then with XN Resource Editor resulted in correupted res File
  { --------------------------------------------------------------------------- }

  //taken by InputDialogResponse
  bCancel    = 0;
  bEnter     = 1;
  bOverWrite = 3;

  { -------  Below are My Movie File Types Indexes as OpenFile Dialog.Index --- }

  SINGLE_TIFF_INDEX   = 1;
  STACK_TIFF_INDEX    = 2;
  BIORAD_PIC_INDEX    = 3;
  NORAN_PRARIE_INDEX  = 4;
  StreamPix_INDEX     = 5;
  COLLECTION_INDEX    = 6;
  QED_INDEX           = 7;
  NORAN_SGI_INDEX     = 8;
  ZEISS_CZI_LSM_INDEX = 9;
  NIKON_ND2_INDEX     = 10;

  { -------  Below are My Movie File Types Constants  ------------------------ }
  { their value is taken by MovFType       : Byte; }

  ANDOR_MOV         = 0; // Andor Single MultiImage TIFF and TIFF Stack Movies
  SINGLE_BW_TIFF    = 1; // Single One or Multi Image Generic Black & White TIFF
  STACK_BW_TIFF     = 2; // Stack of Generic Black & White TIFFs
  BIORAD_PIC        = 3;
  NORAN_PRARIE_MOV  = 4;
  StreamPix_MOV     = 5;
  NIKON_ND2_MOV     = 6; //Single MultiImage Tiff File created by Nikon NIS Elements (introduced in Aug 2015) takes the place of QED MOV
  ZEISS_CZI_LSM_MOV = 7;
  NORAN_SGI_MOV     = 8;
  NIKON_TIFF_MOV    = 9;
  QED_MOV           = 10; //use to be = 6 before NIKON_MOV was introduced and lost Endtry in PixSettings after v. 4.27.0.0.May 4, 2015

  { ---------------- Below Are Constants Taken by ImageFileType (byte) ---------- }
  SINGLE_IMAGE    = 0;
  MULTI_IMAGE     = 1;
  FILE_COLLECTION = 2;

  { ---------------- Below Are Constants Taken by MovieSeriesType (byte) ---------- }

  TimeSeries = 0; //X - Y time series
  Z_Stack    = 1; // X - Y Z series
  LineScan   = 2;

  { -------  Below are My Zeiss LSM File Global Constants  ------------------------ }
  // Taken by ScanType
  X_Y_Z_Scan      = 0;
  Z_Scan          = 1;
  Line_Scan       = 2;
  Time_Series_X_Y = 3;
  Time_Series_X_Z = 4; // Release 2.0
  Time_Series_MeanOfROIs = 5; // Release 2.0

  { from "Lsmfile.doc"
    0 “normal x-y-z-scan”
    1 “Z-Scan”
    2 “Line scan”
    3 “Time series x-y”
    4 “Time series x-z” ( Release 2.0 )
    5 “Time series - Mean of ROIs”
    }

  { -------  Below are My TIFF File Types Constants  ------------------------- }
  { their value is taken by  TIFFfileType : Byte; }
  TIFF_GENERIC      = 1;
  TIFF_QED          = 2;
  TIFF_ANDOR_iQ     = 3;
  TIFF_ANDOR_SOLIS  = 4;
  TIFF_NORAN_PRARIE = 5;
  TIFF_NIKON        = 6; //Tiff File created by Nikon NIS Elements
  TIFF_ImageJ       = 7; // tiff created by Imagej

  { -------  Below are My How to Open Movie & Image File Constants  ------------------------- }
  { their value is taken by LOCAL ActionMode : Byte; }
  READ_AS_SINGLE = 1;
  READ_AS_STACK  = 2;
  READ_AS_COLLECTION = 3;
  GET_ANDOR_NR_PAGES = 4;
  GET_ANDOR_FILE_CREATION = 5;
  GET_ANDOR_IMAGE_DESCR = 6;
  { ----------Below are PlayBackMode (Byte) Constants----------------------- }
  { their value is taken by PlayBackMode    : Byte; }
  STOPPED = 0;
  CONT_BACKWARD = 1;
  CONT_FORWARD = 2;
  LOOPING = 3;
  { ------------------------------------------------------------------------ }
  { ---------------- Below Are the Time Ser Anal Mode Const --------------- }
  { their value is taken by TimPltSlid.TimeSerAnalMode }

  INTENSITY  = 0;
  F_div_Fo   = 1; //always {Pix/Pix} (AREA/AREA was removed on Apr 18, 2016)
  Ch_div_Ch  = 2; //introduced on Apr 18, 2016

  { ---------------- Below PLOTvar.AnalType Constants --------------- }

  INTENSITY_TIME        = 0;  // Just simple Pixel Intensity
  RATIO_TIME            = 1;  // any F/Fo Ratiometric: Trace from PIX/PIX  or Trace/min or Trace/Continuous baseline
  Ch_div_Ch_RATIO_TIME  = 2;  //Channel One (Main Window) / Channel Two (secondary window
  Ca_CONC_TIME          = 3; // in µM as result from Cannel/Channel Ration using standard curve
  DISTANCE_TIME         = 4;  // e.g. Diameter Tracking (measurement)

  { ---------------- Below Are the Time Ser Anal Mode Const --------------- }
  { their value is taken by MarkSmEvDur and MarkBigEvDur }
  TIME_DONE      = 0;
  CANNOT_BE_DONE = -1;
  NOT_ANALYZED   = -2;

    { -----------------Below Are Constants Taken by AvImExists (Byte) and TQFileDat.AverImKind ------------- }
  NO_AVERAGE          = 0; // No Av Image
  AVER_ON_LINE        = 1; // Selected (On line)
  AVER_FROM_FILE      = 2; // From File Saved
  AVER_FROM_JUST_GEN  = 3; // Generated Automatically by CreateAverageImageUsingMinimum but not Saved to files

  AVER_WIIL_BE_GEN_NO_1stIMAGE   = 4; // will be generated - taken only by TQFileDat.AverImKind
  AVER_WIIL_BE_GEN_FROM_1stIMAGE = 5; // will be generated - taken only by TQFileDat.AverImKind
  { ------------------------------------------------------------------------------ }
  { ---------------- Below Are Constants Taken by
    PLOTvar.BaseLineStatus (byte) and TimPltSlid.BaseLineOption (byte) --------------- }
  NO_BASELINE = 0;
  GET_BASELINE = 1;
  SUBTRACT_BASELINE = 2;
  DIVIDE_BY_BASELINE = 3;
  { ----------------------------------------------------------------------- }

  { ------ Below Are Constants Taken by MovieFromWin and TargetForLabels --- }
  WINDOW_MAIN  = 1;
  WINDOW_MERGE = 2;
  WINDOW_3D    = 3;
  { ------Below Are Constants Taken by MergeModel (byte)  ----------------- }
  //correspond to the ItemIndex//
  MERGE       = 0;
  OVERLAY_Ch1 = 1;
  OVERLAY_Ch2 = 2;
  { ----------------------------------------------------------------------- }
  { ---- Below Are Constants Taken by CopyToDisplay used in DoRatio procedure-------------- }
  NO_COPY = 0; // to copy or Not the Ratio Image to Display Buffer
  DO_COPY = 1;
  { ----------------------------------------------------------------------- }
  { ---- Below Are Constants Taken by ActionCode used in UpdateLineScan procedure-------------- }
  ERASE_SCREEN = 0; // make the Screen Black
  REFRESH_ONLY = 1; // to copy or Not the Ratio Image to Display Buffer
  RELOAD_DISPL = 2;
  REDO_RATIO   = 3;
  REDO_ChdivCh_RATIO = 4;
  { ----------------------------------------------------------------------- }
  { ----Below Are Constants Taken by Location used in GetMeanFhROI procedure-------- }
  OnMainIm = 0;
  OnAverIm = 1;
  { ----------------------------------------------------------------------- }
  { ----Below Are Constants Taken by PLOTvar.ROIkind[0..19] & ROIvar.ROIAdr[1..20] ------ }
  ROI_BOX = 1;
  ROI_ELLIPSE = 2;
  ROI_FREEHAND = 3;
  ROI_LINESCAN = 4;
  { ----------------------------------------------------------------------- }
  // Taken by SmoothMode & Smooth3Mode
  NO_SMOOTH = 0;
  SMOOTH_BOX = 1; // Box only
  SMOOTH_BOX_MED = 2; // 1st Box then Median
  SMOOTH_MED = 3; // Only Median
  SMOOTH_MED_BOX = 4; // 1st Median then Box
  SMOOTH_GAUSS = 5; // GAUSS only
  SMOOTH_GAUSS_MED = 6; // 1st GAUSS then Median
  SMOOTH_MED_GAUSS = 7; // 1st Median then GAUSS
  { ----------------------------------------------------------------------- }
  // Taken by SmoothOrder
  FIRST_BOX_OR_GAUSS = 0;
  FIRST_MEDIAN = 1;
  { ----------------------------------------------------------------------- }
  // Taken by GaussSmSize:  it really points to the tag value of the buttons
  GAUSS_3x3_LITE = 1;
  GAUSS_3x3_MEDIUM = 2;
  GAUSS_3x3_HEAVY = 3;
  GAUSS_5x5 = 5;
  GAUSS_7x7 = 7;
  { -------------- taken by SmoothNonRatio ------------------------------ }
  NO_SMOOTH_NON_RATIO = 0; // do not smooth non ratio images on any channel
  SMOOTH_Ch_ONE       = 1; //smooth non ratio on Channel One
  SMOOTH_Ch_TWO       = 2; //smooth non ratio on Channel Two
  SMOOTH_Ch_BOTH      = 3; //smooth non ratio on Both Channels
  { ----------------------------------------------------------------------- }
  //Taken by ChannelOrder  whci works with more than One Channel

  ASCENDING  = 0;
  DESCENDING = 1;
  { ----------------------------------------------------------------------- }
  // Taken by MesLine.Orientation (Integer;
  MORE_HORIZONTAL = 1;
  MORE_VERTICAL = 2;
  { ----------------------------------------------------------------------- }
  // Taken by MesLine.OpCode and TDiamMesRect (Integer);
  NOT_EXIST   = 0;
  DO_EXIST    = 1;
  IN_DRAWING  = 2;
  MIDDLE_SEL  = 3;
  BEG_SEL     = 4;
  END_SEL     = 5;
  IN_MOVING   = 6;
  TO_RESET    = 7;
  SET_WIDTH   = 8;
  IN_TRACKING = 9;
  { ----------------------------------------------------------------------- }
  /// / Taken by LinkTimeSerPlotAndImage = Word;

  NO_LINK = 0; // no link
  LINK_IMAGE_TO_PLOT = 1; // change in the image number drives Time Series Plot Cursor
  LINK_PLOT_TO_IMAGE = 2; // change in the Time Series Plot Cursor changes image number
  LINK_BOTH = 3; // both cause change each other

  { ---------------------------------------------------------------------- }

  //Taken by RAM_Usage.KindOfModMovie

  NOT_MODIFIED = 0;
  KALMAN_FILT  = 1; //attaches _KF to File Name
  NORM_COR     = 2; //ataches _NM to File Name
  BLEACH_COR   = 3; //attaches _BC to File Name

  {taken by SelFrameMove and XYprofileRect}
  NO_MOVE     = 0;
  MOVE_ALL    = 1;
  MOVE_LEFT   = 3;
  MOVE_RIGHT  = 4;
  MOVE_UP     = 5;
  MOVE_DOWN   = 6;

  //taken by XYprofileKind
  X_PROFILE = 0;
  Y_PROFILE = 1;
  //taken by XYprofileSource
  MAIN_WINDOW = 0;
  AVER_WINDOW = 1;

  //taken by ExportDial.MovieKind
  MPEG_1   = 1;  //MPEG-1
  WMV_VC1  = 2; //Windows Media Video 9 Advanced Profile
  AVI_UNC  = 3; //AVI uncompressed
  MP4_x264 = 4;  //mp4 x264 encoded
  FLV_x264 = 5; //Adobe Flash Video  x264 encoded
  MOV_x264 = 6; //Apple Quick Time x264 encoded

TYPE

  THillEquationParams = Packed Record
  {Span = Top - Bottom
  from Dan: Y=Bottom + (Top-Bottom)/(1+10^((LogIC50-X)*HillSlope))

    Y = Bottom + (Top-Bottom)/(1+10^((Log10(IC50)-Log10(X))*HillSlope))
    Y = Bottom + (Top-Bottom)/(1+10^((Log10_IC50)-Log10(X))*HillSlope))
    or Y as channel ratio:
    ChannelRatio  = MinChannelRatio + (MaxChannelRatio-MinChannelRatio)/(1+10^((Log10_IC50)-Log10(Ca))*HillSlope))
    ChRatio  = MinR + (MaxR-MinR)/(1+10^((Log10_IC50)-Log10(Ca))*HillSlope))
    non log forms:
    Y = Max/(1 + (Kd/Ca_Conc) ^n)

    Y = Bottom + (Top-Bottom)/(1+(IC50/X)^HillSlope) = Bottom + (Top-Bottom)/(1+(IC50^HillSlope/X^HillSlope))

    To Calculate calcium from Ratio I Rearranged the above equation to (Apr 2016):
    Calcium (nM) = ((IC50^HillSlope)/((MaxR-MinR)/(ChRatio-MinR)-1))^(1/HillSlope);
    Ca (nM) = ((363^3.17)/((0.9-0.16)/(col(RatFromFit)-0.16)-1))^(1/3.17)
    (here ^1/HillSlope makes Root of Hillslope)
    if IC50 is in nM then Ca is in nM,  if IC50 is in µM then Ca is in µM

    Y = Max/(1 + (Kd/Conc) ^n)
    Y = Bottom + (Top-Bottom)/(1+(IC50/X)^HillSlope)

    Fit parameters to Experimental Results from GCamp5-mCherry Endothelium done by Daniel Collier, spring 2016:
    Top	0.9
    Bottom	 0.16
    LogIC50	2.56
    HillSlope	3.17
    IC50	363 nM
    Span	0.74  }
    MinRatio   : Double; //Minimum = "Bottom" = Ch1/Ch2 ratio at "Zero Ca", Ratio Units
    MaxRatio   : Double; //Maximum = "Top"    = Ch1/Ch2 ratio at "Saturating Ca" , Ratio Units
    MinCa      : Double; // Limit for Minimium µM Ca concentration
    SaturCa    : Double; //// µM Ca (Limit for Maximum Ca) at which the Fluorescence/Ca curve saturates
    Span       : Double; //= MaxRatio -  MinRatio
    IC50       : Double; //IC50, µM Calcium
    HillSlope  : Double; //Hill Slope
  End;


  { Used to Delete and Insert Row im Any StringGrid }
  TStringGridHack = class(TStringGrid)
    procedure DeleteRow(ARow: Longint); reintroduce;
    procedure InsertRow(ARow: Longint);
    procedure DeleteColumn(ACol: Longint); { does not work properly }
  End;

  { ---------------------------------------------------------------------------}
  TScopeSystemParams = Record
    AOD_Power        : Integer; { NORAN Files Only = Laser Power % }
    PMT_Gain         : Integer; { NORAN Files Only = "Contrast" [PMT amplification }
    PMT_Offset       : Integer; { NORAN Files Only = Offset [Brightness) }
    PixDwell         : Integer; { time in nanosec (Noran) or µs (Zeiss CZI) between 2 pixels}
    PixDwell_Units   : Array[0..1] of AnsiChar; {ns or µs}
    Ch1_Name         : AnsiString; {Name of the Cannel.  For now implemented in Andor TIFFs Only}
    Ch2_Name         : AnsiString; {Name of the Cannel.  For now implemented in Andor TIFFs Only}
    Optical_Zoom     : Double;  {NORAN Prarie & Biorad, Zeiss CZI (Zeiss LSM is not implemented yet) }
    ObjectiveName    : AnsiString; {Name of the Objective Zeiss CZI only}
    Objective_Mag    : Integer; { Andor, Biorad, Zeiss CZI, (Zeiss LSM is not implemented yet) }
    DigitalOffsetCh1 : Double;
    DigitalOffsetCh2 : Double;
  end;

  TPrevFilePar = Packed Record { used to store prev image par }
    Xsize          : Word;
    Ysize          : Word;
    Fname_Length   : Word;  //if Zero - No name yet
    FilterIndex    : Byte; // OpenDialog Index = Kind of File
    BigTiff        : Boolean;
    MultiImageTIFF : Boolean;  //True if a Tiff has more that One Image
  end;

  TMesLine = Record { stores Measure Line Parameters (Xbeg,Ybeg,Xend,Yend) }
    LineBeg     : TPoint; // TImage Coordinates  non scalled
    LineEnd     : TPoint; // TImage Coordinates  non scalled
    Slope       : Double;
    Intercept   : Double;
    Orientation : Integer; // takes Costants
    OpCode      : Integer; // takes Costants  (means Operation Code)
    SelTol      : Integer; // Selection Tolerance
  end;

  TDiamMesRect = Record { stores Measure Line Parameters (Xbeg,Ybeg,Xend,Yend) }
    RectBeg     : TPoint; // Beg of Rect in TImage Coordinates
    RectEnd     : TPoint; // Beg of Rect in TImage Coordinates
    OffsXorYbeg : Integer; // Distance from MesLine.Xend (HORIZONTAL) or Ybeg (VERTICAL)
    OffsXorYend : Integer; // Distance from MesLine.Xend (HORIZONTAL) or Yend (VERTICAL)
    DiagOffset  : Integer; // the Half of Dispalacement of X or Y if Not Pure Horizontal or Vertical
    HalfWitdh   : Integer; // Half of the Width
    Intercept   : Double; // this intercept is always scaled to current Zoom
    ZoomCurrent : Integer; // Current Zoom of Window
    ZmCurrent   : Integer; // Current Zm in Use
    PolygonArr  : Array [0 .. 3] of TPoint; // Drawing Array scaled to current Zoom
    ROI_1st     : Integer; // Stores the Number of ROI at the Beg of Line/DiamMesRect
    ROI_2nd     : Integer; // Stores the Number of ROI at the End of Line/DiamMesRect
    LineBegOrig : TPoint; // Original Non Scaled Beginning of Measuring Line
    LineEndOrig : TPoint; // Original Non Scaled End of Measuring Line
    OpCode      : Integer; // takes Costants  (means Operation Code)

  end;

  TMesLineVar = Packed Record { Measure Line Variables }
    Color     : LongWord;
    LSROI     : Longint; // Region Selected to Generate Line Scan Trace
    Thickness : Longint;
    CapsWitdh : Longint; // EQ of Half of the Cap; if = 0 then No Caps are Drawn
  end;

  TImageContrVar = Packed Record { used to store them after reading SparAn.par }
    BackGrMax : Word;
    CutOffMax : Word;
    MaxGamma  : Word;
  end;

  { To Load or Not Files in RAM. NrOfChucks - How Many chunks (Parts) relevant to the Multiimage Files
    Affects Progress Barr.  At Once - faster. 2 GB File Test At Once - 18 s, in 8 times - 25 s}
  TRAM_Usage = Packed Record
    LoadFilesInRAM : Boolean;
    KindOfModMovie : Byte; // so far Kalman Filter and Bleaching Correction
  end;

  { -------------------------------------------------------------------------- }
  TPixRange = Record  //used to memorize Histogram range
    DSPixRange_PosFrom : Integer;
    DSPixRange_PosTo   : Integer;
  end;

  { -------------------------------------------------------------------------- }

  TColTableSetings = Packed Record { Color Table Variables }
    Contrast    : array [0 .. 2] of Longint;
    Brightness  : array [0 .. 2] of Longint;
    Gamma       : array [0 .. 2] of Longint;
    ColTblIndex : array [0 .. 2] of Longint;
    {ColTblIndex = 0 for non ratio Main Image & Aver Image
                   1 for Ratio Main Image
                   2 for 2nd Window if NrChannels > 1 ( = 2)
     }
  end;
  //BottomColTableSettings is Not saved in SparkAn.par
  TBottomColTableSettings = Record  //variables that memorizes the Wite or Black Color Table Settings
    BottomState : array [0 .. 2] of Byte; // 0 = Nothing, 1 = Black, 2 = White
    BottomValue : array [0 .. 2] of Byte;  //value of the slider
  end;

 //--------------------------------------------------------------------------//

  TROIColArr  = packed array [1 .. 20] of TColor;
  TFontColArr = packed array [1 .. 20] of TColor;

  TROIvar = Packed Record { Box Selections Variables }
    ROICoor        : array [1 .. 4, 1 .. 20] of Integer;
    { BoxCoor[1] = Xleft; [2] = Yup; [3] = Xr  [4] = Ydown }
    ROIAdr         : array [1 .. 20] of Integer;
    { if Not Used = 0, Else: Box=1, Circle=2, Polygon=3 ; May Become - while drawing }
    ROICol         : TROIColArr; { Colors Used, Cardinal should be used }
    FontCol        : TFontColArr; { Colors for Label of Trace Buttons }
    NrROI          : Longint; { Number of Printed (Used) Boxes INCLUDING SELECTION FRAME }
    { # 21 Stores Selection Frame Properties !!!! }
    { refers to Sliders X & Y }
    MesBoxXsize    : Longint; { Stores Measuring Box X size }
    MesBoxYsize    : Longint; { Stores Measuring Box Y size }
    MarkXsize      : Longint; { Frame X for the Simple Place Mark }
    MarkYsize      : Longint; { Frame Y for the Simple Place Mark }
    BoxXsize       : Longint; { Stores  Box X, Y size }
    BoxYsize       : Longint; { see above }
    CirXsize       : Longint; { Stores Circle (Elipse) X, Y size }
    CirYsize       : Longint; { see above }
    { end of sliders }
    TickLine       : Integer; { stores the Address of ROI which Should be Drown with Tick Line
      also if = -1 means Plot is not Done; if ROI are moved is set to -1 }
    Ticker         : Integer;
    { if ROI is Drown Thicker this is the Thickness to get this }
    FillFh         : Integer; { Stores the Address of Free Hand ROI which was Filled }
    TckNess        : Integer; { Thickness of Line used for ROI }
    FhTickness     : Integer; { Thickness for Free Hand }
    PeakThreshUsed : Integer;
    { Thres used for Peaks - used in Save Peaks in File }
    MonoCol        : LongWord;
    { Stores the Color Value from ColorDialog, In case Single Color is Used }
    MonoFontCol    : LongWord; { Font Color if Same for all ROI numbers }
    UseMonoFontCol : Boolean; { if True then Use Same Color for ROI numbers }
    UseROINr       : Boolean; { To Show ROI numbers on Windows }
    ROIonAverWin   : Boolean;
    { To Enable Aver Window to Display and Work with ROI }
    KeepOldROI     : Boolean;
    { when opens new file to keep existing ROI if image X and Y sizes are the same }
    UseMonoCol     : Boolean; { If True then Use MonoColor }
  end;

  TROIrct = Packed Record
    { Some more ROI variables - Just to have them in separate record }
    Xsize : Longint; { current Xsize for Box and Circles }
    Ysize : Longint; { current Ysize for Box and Circles }
    LT    : Longint; { Left & Top offset to be added when Rectangle is drawn }
    RB    : Longint; { Right & Bottom offset to be added when Rectangle is drawn }
    Rc    : Longint; { for ROI boxes X direction }
    Bc    : Longint; { for ROI boxes Y direction }
    // Rc,Bc = Coefficient Right and Bottom - if X,Ysize = Odd then = 0, if Even = 1
    // used when place boxes to calculate center, Not For Drawing!!!!
    tLT   : Longint; { Left & Top offset of Thickened ROI }
    tRB   : Longint; { Left & Top offset of Thickened ROI }
    frLT  : Longint; { Left & Top offset of sel frame }
    frRB  : Longint; { Right & Bottom offset of sel frame }
    { the formula to draw a rectangle with different thickness
      and keeping interior the same is:
      L := Xl - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
      R := Xr + canvas.Pen.Width div 2 + 1 + 1;
      T := Yup - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
      B := Yd + canvas.Pen.Width div 2 + 1 + 1; }
  end;

  TPLOTvar = Record
    { memorizes Current Settings of Time Series PLOT in RunTime }
    NrROI           : Integer;
    { Number of ROI {boxexs, Circles etc. Analysed WITHOUT the Selection Frame }
    ImNrFromTable   : Integer;
    { Stores Image Number if Single Trace is Triggered From Table }
    { Used to Draw (If Symbol Selected) Symbol in Different Color }
    { If Negative then Same Color is Used }
    TraceMinFrom    : Integer;
    { Beg to Find Min minimum for Area/min in Certain range }
    TraceMinTo      : Integer; { End to Find Min - same - }
    Background      : Integer; { Equal to Bkg variable
      {to Use the same Divider [min] or Denominator when Area/min is used }
    CurPix          : Integer; { Horiz Cursor Pixel Pos }
    ImBeg           : Word; { Beg and End Images Analyzed }
    ImEnd           : Word;
    LastTraceMinPrts : Word;
    { Last Used Points to Get Minimum in the Trace for Area/min analysis }
    AdrUsed         : array [0 .. 19] of ShortInt;
    { Address of ROI in ROIvar.ROIadr {-128-+127 }
    { if - Then Button Off }
    { those are used to write to TXT trace files }
    ROIsizeXY       : array [0 .. 1, 0 .. 19] of Word; { X and Y dimentions }
    ROIcentXY       : array [0 .. 1, 0 .. 19] of Word;
    { X and Y Position if Ideal Geom. ROI }
    ROIkind         : array [0 .. 19] of Byte;
    { What kind: Box = 1, Circle = 2, Free Hand = 3 }
    UndoRedu        : array [0 .. 1] of Integer;
    { stores Left and Right (Im Number) Sliders }
    HasPeaks        : Boolean;
    AnalType        : Integer;
    { takes the Following Const: AREA_TIME, RATIO_TIME ,DISTANCE_TIME }
    { Ratio is of Any Type: Area/min, Pix/Pix/ Channel/Channel}
    ChannelOrderUsed : Byte; //ASCENDING or DESCENDING
    TraceDivMinUsed : Boolean; //if Trace was normalised by Min
    { if Analysis used AreaDivMin or Just Area; but not any of Division by Average Image }
    AllowFreezeMin  : Boolean;
    { Nr of the Last ROI Used with Meas Cursor-used if MesCur is On If this ROI is still
      present to Keep to it }
    LastROIMesCur   : Byte;
    shrFact         : Byte;
    { [= BitDepth - 8] shrFact used in the existing Plot, in case each new file was open with diferent shrFact }
    { Continuous Baseline }
    BaseLineStatus  : Byte;
    { Takes the Values for Continuous Baseline:  NO_BASELINE = 0; GET_BASELINE = 1; SUBTRACT_BASELINE = 2; DIVIDE_BY_BASELINE = 3 }
    BaseLinePoints  : Word;
    { Points of Window That Creates Continuous Baseline = Points of the Longest Event }
    LSD             : Double;
    RSD             : Double;
    NrScanes        : Byte; { Number of Scanes (Pases) for baseLine search;
      Each Time Window increases by ~ 1.5 times }
    { Baseline for Each Peak }
    GetEachPeakBase : Boolean; // To Get and Use Baseline for Each Peak - for Now only Subtraction
    EachPeakBasePt  : Integer; // Points 9Images) to get Baseline for Each Peak
    EachPeakBaseRg  : Integer; // ms back from the Peak to Search for Baseline

    SmTrBoxcarIndex : Byte;
    { Stores Index of cbSmTrFltSize for Trace (time) Boxcar Smoothing Filter size }
    SmTrGaussIndex  : Byte; //if "Gauss" chosen
    { Stores Index of cbSmTrFltSize for Trace (time) Gauss Smoothing Filter size }
    SmTrGaussFcIndex : Byte; ////if "Gauss Fc" chosen
     { Stores Index of cbSmTrFltSize for Trace (time) Gauss Fc = None of Fc}
    FcGaussFlt      : Double; //if "Gauss Fc" chosen
    { Stores Fc (corner frequency) in Herz of Gauss Filter}
    SmTrKalmanIndex : Byte;
    { Stores Index of cbSmTrFltSize for Trace (time) Kalman Smoothing Filter Gain }
    SmTraceKind     : Byte;
    { Stores the Index of cbSmTraceKind for Trace (time) Kind of Smoothing (Boxcar, Gauss or Kalman}
    Title           : AnsiString;
    MovFType        : Byte; //copy of MovFType
    MovieSeriesType : Byte; //copy of MovieSeriesType
    DimNotTime      : LongInt; //copy of Andor DimNotTime (Dimension that is not the Time
    { Numerator/Denominator }
  end;

  TMarkPar = Packed Record
    Size               : Longint; { Length Pixels }
    Thick              : Longint; { Thickness Pixels }
    SmallEventColor    : LongWord; { Color } { For Sparks , Go to Table 1 }
    BigEventColor      : LongWord; { For Waves, go to Table 2 }
    DisplaySmEvents    : Boolean; { Works while Playing or Moving Trough File }
    DisplayBigEvents   : Boolean; { Does Not Affect Initial Placing of a mark }
    ShowSmEvOnAverWin  : Boolean; { to Show Small Marks on Aver Window }
    ShowBigEvOnAverWin : Boolean; { to Show Small Marks on Aver Window }
    PromptForComment   : Boolean;
    GenAutoSearchComm  : Boolean;
    GenGenSetComm      : Boolean;
  end;

  TAutoSearchPar = Packed Record
    Thresh              : Word; { Threshold for Scanning }
    Tolerance           : Word; { Percent of Pixels Above Thresh }
    MaxArea             : Word; { Max Area to be consider as a Small Event (e.g.Spark) }
    NrImRunAver         : Word; { Number of Images for Running Average }
    NrImForCreateAvIm   : Word;
    { Nr of consecutive images used to create Average Image Manual or Automatic }
    SearchLms           : Word;
    { Time (ms) to check to the Left from Spark peak in "Test Small Events"
      starts from one image Before Spark peak}
    SearchRms           : Word;
    { Time (ms) to check to the Right from Spark peak in "Test Small Events"
      starts from one image After Spark peak}
    AutoAverNrImInc     : Word; // Number of Images Increment to Start Making Automatically New Average Image
    AutoAverImRange     : Word; // Number of Image Range (From-To) to Make Automatically New Average Image
    PlaceWordHolder1    : Word;
    PlaceWordHolder2    : Word;
    PlaceWordHolder3    : Word;

    UseRunAver          : Boolean; { Use Running Average }
    IgnoreBigEv         : Boolean; { uses the Spark part of Anal Only }
    TestSmallEv         : Boolean; { Test Small Events = Check Trace for Each Spark }
    SpaceHolder         : Boolean; //SpaceHolder
    { to use or not Current 2D Filt to generate Ampl and Duration and t1/2 }
    GetSmEvDur          : Boolean; { to Get Duration and t1/2 of Small Events }
    GetBigEvDur         : Boolean; { to Get Duration and t1/2 of Big Events }
    AutoAverImage       : Boolean; // Creates Automatically Average Images Every so Images defined by AutoAverNrImInc
    StartAutoAverFirstIm  : Boolean; // Starts Auto Average Image th 1st Image Read
    SaveAutoAver        : Boolean; // Save Auto Average Images to Files
    UpdateRatio         : Boolean; // Reads again Non ration Backed up files
    SmoothBeforeDoRatio : Boolean; // To use Smoothed Main Imege and Average Image for F/Fo
    UseCustomROIforSmEvTest : Boolean; // To Use the Custom Box ROI (Not the Search Scan Box) for Small Events Test
    ROISizeForSmEvTest  : Byte; //To use this ROI for Small Evens test if ScanBox is not chosen

    ScanBoxSize         : Byte; { Size of Scanning Box for searching events}
    NrImGetMinLeft      : Byte;
    { Nr of Images to Find MinValue = Baseline Left of Peak when does Test Small Events }
    NrImGetMinRight     : Byte;
    { Nr of Images to Find MinValue Right of Peak when does Test Small Events }
    NrImToLeftOfEv      : Byte;
    { Nr of Images for Peak (above Treshold) to Qualify as Event (Spark) }
    NrImToRightOfEv     : Byte;
    { Nr of Images for Peak (above Treshold) to Qualify as Event (Spark) }
    PLval               : Byte; { percent of Peak Value for NrImToLeftOfEv to Qualify }
    PRval               : Byte; { percent of Peak Value for NrImToRightOfEv to Qualify }
    SDuse               : Boolean; //if true then checks if the Peak of event is so many times > baselione + SD (standard deviation of baseline used)
    { Threshold for the Small Events Test. Can be diffetrent fo Thresh for Scanning }
    SDfold              : Byte;  //fold SD;  Event (spark,pulsar) qualifies as such if Peak > baseline + SDfold

    PlaceByteHolder1    : Byte;
    PlaceByteHolder2    : Byte;
  end ;


  TQFileDat = Record
    ColNr         : Word; { Corresponding Column Number In Table, Hidden }
    QFName        : AnsiString; { Full Path of File To Be Analyzed }
    AvFName       : AnsiString; { Full Path; if AvImSource = 'From File' }
    ListOfIm      : array of Longint;
    { List of Images to Mage AvImRaw if AvImSource = 'mage List' }
    FIndex        : Word; { EQ FileDialog.Index; }
    ImToBeg       : Longint; { First Image to Search }
    ImToEnd       : Longint; { Last  Image to Search }
    NrImInList    : Word; { Number of Images to Average; = 0 if Not Used }
    BackGr        : Word; { = Bkg }
    ImCutoff      : Word; { = CutOff }
    ImageContrVar : TImageContrVar;
    SelFrame      : TRect; { Coordinates of Sel Frame }
    ApplyFrame    : Boolean; { to Applly a Clipping Frame }
    AverImKind    : Byte; { How to Produce Average }
    SmoothMode    : Byte; { copy of SmoothMode }
    SmoothOrder   : Byte; { copy of SmoothOrder }
    BoxCarF       : Byte; { if = 0 then Boxcar Smoothing is Off }
    GaussF        : Byte; { if = 0 then GaussF Smoothing is Off }
    MedianF       : Byte; { if = 0 then Median Smoothing is Off }

    AutoSrchPar   : TAutoSearchPar; { SPautoserch Variable }
  End;

  TMarkTablesPar = Packed Record
    GetSmEvBase          : Boolean;
    { to Get Baseline For Each Small Event - Controlled by CheckBox on Small table Form }
    GetBigEvBase         : Boolean;
    { to Get Baseline For Each Big Event   - Controlled by CheckBox on Big Event table Form }
    SmEvTimeIndex        : Byte; { time range index when click on Smal Events Table }
    BigEvTimeIndex       : Byte; { time range index when click on Big Events Table }
    NrPointsSmEvBase     : Word; { Points (images) to get Small Events Baseline }
    SmEvBaseSearchRange  : Word;
    { Search Range before Peak (ms) to get Small Events Baseline }
    NrPointsBigEvBase    : Word; { Points (images) to get Big Events Baseline }
    BigEvBaseSearchRange : Word;
    { Search Range before Peak (ms) to get Big Events Baseline }
  end;

  TDurParams = Record // Used Only as Locals !!!
    { Used to Find Decay and Duration for Mark Tables }
    AmplAboveHalf : Double; { Amplitude at Image Just Above 1/2 Peak Amplidude }
    AmplBelowHalf : Double; { Amplitude at Image Just Below 1/2 Peak Amplidude }
    ImNrAboveHalf : Word;
    { Image Number at which Amplitude is Just Above 1/2 Peak Amplidude }
    ImNrBelowHalf : Word;
    { Image Number at which Amplitude is Just Below 1/2 Peak Amplidude }
  end;

  TRiseTimeParams = Record // Used Only as Locals !!!
    { Used to Find Rise Time for Mark Tables }
    AmplAbove90     : Double;
    { Amplitude at Image Just Above 90% of  Peak Amplidude }
    AmplBelow90     : Double;
    { Amplitude at Image Just Below 90% of  Peak Amplidude }
    ImageNrAbove90  : Word;
    { Image Number at which Amplitude is Just Above 90% of Peak Amplidude }
    ImageNrBelow90  : Word;
    { Image Number at which Amplitude is Just Below 90% of Peak Amplidude }
    AmplAbove10    : Double;
    { Amplitude at Image Just Above 10% of  Peak Amplidude }
    AmplBelow10    : Double;
    { Amplitude at Image Just Below 10% of  Peak Amplidude }
    ImageNrAbove10 : Word;
    { Image Number at which Amplitude is Just Above 10% of Peak Amplidude }
    ImageNrBelow10 : Word;
    { Image Number at which Amplitude is Just Below 10% of Peak Amplidude }
  end;

  TDurTimes = Record // Used Globally
    { Defines Time to the Left to Peak and Time to the Right of Peak
      Used in Spark & Wave Marks & tables }
    L: Double;
    R: Double;
  End;

  TDurImNr = Record // Used Globally
    { Stores Image Numbers as Float where L time and R time is.
      Ltime and Rtime is where the Time for 1/2 amplitude L and R of Peak is
      Used for Plotting Only since the Time between Images could be irregular,
      so MeanImage Time Cannot be used }
    Lim : Double;
    Rim : Double;
  End;

  TBaseImNr = Record
  { Stores Image Numbers for L image number and R image number
    position if TimPltSlid.GetEachPeakBase. Used for Plotting}
    LimNr : Word;
    RimNr : Word;
  End;

  type TMergeColors = Record
     RedOn   : Boolean;
     GreenOn : Boolean;
     BlueOn  : Boolean;
  end;

  TDynByteArray     = array of Byte;
  TDyn2DByteArray   = array of array of Byte;
  TDynWordArray     = array of Word;
  TDyn2DWordArray   = array of array of Word;
  TDynLongWordArray = array of LongWord;
  TDynIntArray      = array of Integer;
  TDyn2DIntArray    = array of array of Integer;
  TDynLongIntArray  = array of Longint;
  TDynUInt64Array   = array of UInt64;
  TDyn2DUInt64Array = array of array of UInt64;
  TDynSingleArray   = array of Single;
  TDynDoubleArray   = array of Double;
  TDynAnsiStrArray  = array of AnsiString;
  TDyn2DDoubleArr   = array of array of Double;
  TDyn2DSingleArr   = array of array of Single;
  TDynTPointArray   = array of TPoint;
  TDyn2DTPointArray = array of array of TPoint;
  TDyn3DTPointArray = array of array of array of TPoint;
  TFhPol = array [1 .. 20] of array of TPoint;
  { used to Draw Free hand Polygon }
  TFhTbl = array [1 .. 20] of array of array of TPoint;
  { Free Hand Polygon Table }
  TMarkArrXY = array of array of TPoint;
  { Columnns = Nr of Image, rows = Nr of Marks }
  TMarkArrDur = array of array of TDurTimes;
  { Columnns = Nr of Image, rows = Nr of Marks }
  TCoupleDouble = array [0 .. 1] of Double;

  TByteArr = array [0 .. 0] of Byte; // Used in different procedures - mainly filters
  pByteArr = ^TByteArr; // pointer to TByteArr
  { don't mix it with TByteArray = array[0..32767] of Byte declared in SysUtils }

  TWordArr = array[0 .. 0] of Word;
  pWordArr = ^TWordArr; // pointer to TWordArr

  TDoubleArr = array [0 .. 0] of Double; // Used in different procedures - mainly filters
  pDoubleArr = ^TDoubleArr; // pointer to TDoubleArr

  TPixSettings = Packed Record // provides and stores info usen in Options to to ovveride pix size
    {
      ANDOR_MOV         = 0; // Andor Single MultiImage TIFF and TIFF Stack Movies
      SINGLE_BW_TIFF    = 1; // Single One or Multi Image Generic Black & White TIFF
      STACK_BW_TIFF     = 2; // Stack of Generic Black & White TIFF
      BIORAD_PIC        = 3;
      NORAN_PRARIE_MOV  = 4;
      StreamPix_MOV     = 5;
      NIKON_MOV         = 6; //Single MultiImage Tiff File created by Nikon NIS Elements (introduced in Aug 2015) takes the place of QED MOV
      ZEISS_CZI_LSM_MOV = 7;
      NORAN_SGI_MOV     = 8;
      QED_MOV           = 9; //use to be = 6 before NIKON_MOV was introduced and lost Entry in PixSettings after v. 4.27.0.0.May 4, 2015
      }
    { Noran SGI and QED do not have Entry in PixSettings and on Options/Options Menu/Image Controls}
    PixPer100Micr: array [0 .. 7] of Word;
    { used to override File PixSize settings }
    UseOptionPixSize: array [0 .. 7] of Boolean;
    { true if to Override PixSize stored in Image File }
    // 0 is used by Andor-Mov and so for.  See the Indexes for diferent types of movies above
    IntPlaceHolder : Integer; //used to be  ImageWidth: Integer; which stored imYsize for different cameras used by QED Software
    FramesPerSec: array [0 .. 1] of Double;
    { stores Frames Per Sec for Generic Stack [0] or Single Tiffs[1] }
    FilePixSize : Double; { Stores size of one pixel in microns info from File;
      = Zero if There is no Info -> iXon Files for Example or Generic Tiff Files }
    FileHasOwnPixSize: Boolean; // True if Pixes Sizes are recorded in file
    ImageBinning : Byte; // Binning valid for Andor or Nikon NIS Elements TIFFs only where is recorded in File
  end;

  TFilePaths = Record
    AverImFilePath: AnsiString;
    MarkFilePath: AnsiString;
    QFilePath: AnsiString;
    ROIFilePath: AnsiString;
    PLOTFilePath: AnsiString;
    PeaksFilePath: AnsiString;
    PeakMeansFilePath: AnsiString;
    SingleImageFilePath: AnsiString;
    MultipleImagesFilePath: AnsiString;
    ListOfFiles: AnsiString;
    Collection: AnsiString;
    AndorDescription: AnsiString;
    WindowsBMPPath: AnsiString; // Used by Open BMP file
    HistogramsFilePath: AnsiString;
    ModifiedMoviesPath : AnsiString;
  end;

  TExportDial = Record
    FromIm              : Longint; { gives Nr of Image (Image #1 starts from "0" }
    ToIm                : Longint;
    MovieBitRate        : Longint; // pased to MCL to set the Movie Bitrate
    MovieKeepDuration   : Boolean; // used to set the Movie Framerate always False: it is not used any longer - it was needed for MPEG-1 movies
    UseCustomFrameRate  : Boolean; // //now it is always true; only for MPEG-1 was False
    MovieFrameRate      : Double;
    MotionFactor        : Double; // used if Keep Duration = True
    OrigFrameRate       : Double; // Frame Rate of Original Confocal Movie
    OrigEffectiveFrameRate: Double; // Frame Rate of Original Confocal Movie
    // after division by Play as 2 or 4
    DialogKind          : Integer; // 1 = Consecutive images; 2 = Movie
    MovieKind           : Integer; // 1 = MPEG; 2 = WMV; 3 = AVI (non-compressed)
    SizeBarLenghtINµm   : Byte;    // It used to be Use Internal Player then a Placeholder
    DoCancel            : Boolean;
    DoWriteLogFile      : Boolean;
    UseCRF              : Boolean; //use Constant rate Factor only for mp4, flv, mov
    CRF                 : Integer;
    TempBMPDir          : AnsiString; //Directory to store Temp BMPs for movie
  end;

  TLSTimeBarPar = Packed Record // holds the parameters
    Xright    : Longint;  // Anchored to the Right  = Pixels
    Ybottom   : Longint; // Anchored to the Bottom = Pixels
    Thickness : Longint; // = Pixels
    Color     : LongWord;
    Duration  : Single; // in seconds
    Visible   : Boolean;
  end;

  TTimeOrSizeBar = Record
    XL  : Integer; // X left
    YT  : Integer; // Y top
    XR  : Integer; // X right
    YB  : Integer; // Y bottom
  end;

  TWindowGrid = Record //withd is always = 1
    Color    : TColor;
    PenStyle : TPenStyle;
    PenMode  : TPenMode;
    NrNodes  : Integer;
    Visible  : Boolean;
  end;


  { ------------ Andor Tiff Private Tags ----------------------------------- }
   {--------- Also Olympus FLUOVIEW Exported Files have the same tags
              and do not have Tag 34362  -----}

  TMM_DIM_INFO = Packed Record // Original Andor Proprietory Structure (100 bytes total)
    Name: Array [0 .. 15] of AnsiChar; // Dimension name i.e. Width
    Size: LongWord; // Image width etc.
    Origin: Double; // Origin
    Resolution: Double; // Image resolution
    Units: Array [0 .. 63] of AnsiChar; // Image calibration units
  end;

  TMM_HEAD = Packed Record // Original Andor Proprietory Structure (1454 bytes total)
    HeaderFlag: SmallInt; // 2 bytes
    Status: Byte;
    Name: Array [0 .. 255] of AnsiChar; // Name of the image NULL terminated
    Data: LongWord;
    NumberOfColours: LongWord;
    MM_256_Colours: LongWord;
    MM_All_Colours: LongWord;
    CommentSize: LongWord;
    Comment: LongWord;
    ImageType: Byte;
    DimInfo: Array [0 .. 9] of TMM_DIM_INFO; // Dimension Info
    SpatialPosition: LongWord;
    MapType: SmallInt; // 2 bytes;
    MapMin: Double; // Display mapping minimum
    MapMax: Double; // Display mapping maximum
    MinValue: Double; // Image histogram minimum
    MaxValue: Double; // Image histogram maximum
    Map: LongWord;
    Gamma: Double;
    Offset: Double;
    Grey: TMM_DIM_INFO; // grey level info
    ThumbNail: LongWord; // MM_HANDLE
    VoiceSize: LongWord;
    VoiceHandle: LongWord;
  end;

  // Biorad pic file Header //
  TBioradPicHeader = Packed Record // 76 bytes
    nx: SmallInt; // 2 bytes; /* image width in pixels
    ny: SmallInt; // image height in pixels
    npic: SmallInt; // number of images in file
    ramp1_min: SmallInt; // LUT1 ramp minimum
    ramp1_max: SmallInt; // LUT1 ramp maximum
    notes: LongBool; // 4 bytes - FALSE if no notes, TRUE if there are notes */
    byte_format: SmallInt; // 1 if 8 bits per pixel, 0 if 16 bits per pixel*/
    image_number: SmallInt; // "Current" image in file */
    name: array [0 .. 31] of AnsiChar; // file name */  (equivalent to AnsiChar on Win32)
    merged: SmallInt; // one of the enumMerged values */
    color1: Word; // LUT1 colour status */
    file_id: Word; // 12345 for BioRad pic files */
    ramp2_min: SmallInt; // LUT2 ramp minimum */
    ramp2_max: SmallInt; // LUT2 ramp maximum */
    color2: Word; // LUT2 colour status */
    edited: SmallInt; // non-zero if the file has been edited */
    lens: SmallInt; // integer part of lens magnification */
    mag_factor: Single; // current lens magnification */
    dummy: array [0 .. 2] of SmallInt; // unused values
    {
      short nx; /* image width in pixels */
      short ny; /* image height in pixels */
      short npic; /* number of images in file */
      short ramp1_min; /* LUT1 ramp minimum */
      short ramp1_max; /* LUT1 ramp maximum */
      BOOL notes; /* FALSE if no notes, TRUE if there are notes */
      short byte_format; /* 1 if 8 bits per pixel, 0 if 16 bits per pixel*/
      short image_number; /* "Current" image in file */
      char name[32]; /* file name */
      short merged; /* one of the enumMerged values */
      unsigned short color1; /* LUT1 colour status */
      unsigned short file_id; /* 12345 for BioRad pic files */
      short ramp2_min; /* LUT2 ramp minimum */
      short ramp2_max; /* LUT2 ramp maximum */
      unsigned short color2; /* LUT2 colour status */
      short edited; /* non-zero if the file has been edited */
      short lens; /* integer part of lens magnification */
      float mag_factor; /* current lens magnification */
      unsigned short dummy[3]; /* unused values */
    }
  end;

  TBioradPicNote = Packed Record // 96 bytes
    level: SmallInt; // no longer used */
    next: LongBool; // 4 bytes; non-zero if another note follows this one */
    num: SmallInt; // image number for the display of this note */
    Status: Word; // status flag for this note */
    TypeCode: Word; // type code for this note */
    x: SmallInt; // x-coordinate for this note */
    y: SmallInt; // y-coordinate for this note */
    Info: array [0 .. 79] of AnsiChar; // 80 characters of information */
    {
      typedef struct _note

      short level; /* no longer used */
      BOOL next; /* non-zero if another note follows this one */
      short num; /* image number for the display of this note */
      unsigned short status; /* status flag for this note */
      unsigned short type; /* type code for this note */
      short x; /* x-coordinate for this note */
      short y; /* y-coordinate for this note */
      char text[80]; /* 80 characters of information */
      NOTE; }

  end;

  TSimpleRect = Record
    Left    : Integer;
    Right   : Integer;
    Top     : Integer;
    Bottom  : Integer;
  end;

  TTrackAreaMeans = Record
    First    : Double;
    Second   : Double;
  end;

  TXcoorCouple = Record
    Xb : Integer; //X beg
    Xe : Integer; //X end
  end;


  { ------------ End of Type Declaration ---------------------------- }

VAR { These are "Global Variables" used by all units!!! }

  Zm : Integer;
  AllowWindowsUpdate : Boolean;

  { -------------- Common Variables ------------------------ }
  btPressed : Byte;  //To Get which Button was pressed before frmInputDialog Closes
  FileOwnColorTableWasDown : Boolean;
  Suffix    : AnsiString; //To Get Suffix outputted by before frmInputDialog Closes

  CheckAllFilesExist: Boolean; // QED & Stack of TIFF files:  If True check All files for Existance When Loading;
  // False - Check every 10nth file
  UseMoviFilePath: Boolean; // to use the Movie Pathg for all other files
  LoadStreamPixAndND2TimeSt: Boolean; // StreamPix Only; If True Loads all Time Stamps in GetStreamPixInfo;
  AlignfrmPlayback: Boolean; // to Align Playback and Main Image X Axes when stacked
  FilePaths: TFilePaths; // Stores File Paths for Non Movie Files
  CanSeeDragWin: Boolean; // True if System is set to see Windows while Dragging
  SparkAnDir: AnsiString; { Contains Where SparkAn program is }
  MeanImTime: Extended; { Average time to generate one image in SEC }
  DidGetSparkAnPar: Boolean;
  { if Prameters were succsessfuly Read from ".par" file }
  ImageContrVar: TImageContrVar;
  Pr: TPoint; { used to memorize   Mouse Position }
  NrFiles: Word; { Number of Files in File List }
  strFileList: TDynAnsiStrArray; { hold File List if frmFileList is closed }
  FileTypeList: TDynByteArray;
  ShowFullPath: Boolean; { refers to FileList Table }
  DecSep: AnsiChar; { Decimal Separator = comma (EU) or dot (US) & Britain }
  { holds Type of File as File Dialog.Index[starts from 1]: 1 = Solamere, 2 = Noran }
  ExportDial  : TExportDial; // used to Store Settings to export consecutive images or MPEG or AVI
  ROIselected : Integer; // selected ROI rect only to be passed to Playback set ROI X & Y pos
  {-------------- Conversion fro Channels Ratio to calcium ------------------}
  HillEquationParams : THillEquationParams;
  {---------------- Selection Frame ------------------------------------------}
 SelFrame           : TRect;
 SelFrameVisible    : Boolean;
 SelRectMem         : TRect; //used for moving selection frame and Scalebar
 SelFrameMove       : Integer; //how to move the selection frame
 SelFrameColor      : TColor;
  {---------------- X,Y Profile Rectangle ------------------------------------------}
 XYprofileRect         : TRect;
 XYprofileRectVisible  : Boolean;
 XYprofileRectMem      : TRect; //used for moving XYprofileRect
 XYprofileRectMove     : Integer; //how to move the XYprofileRecte
 XYprofileRectColor    : TColor;
 XYarray               : TDynDoubleArray;
 XYprofileKind         : Byte; // Const: X_PROFILE = 0;  Y_PROFILE = 1; = Horizontal or Vertical
 XYprofileSource       : Byte; //Const:  MAIN_WINDOW = 0;  AVER_WINDOW = 1;
 XYprofileFilter2DUsed : Boolean; // if 2D filters were used
  { -------------- Comments & Timers for MPEG movies ------------------------ }
  MovieFromWin    : Byte = WINDOW_MAIN; // Tells which Window (main or 3D) to be used for MPEG movies
  TargetForLabels : Byte = WINDOW_MAIN; // Tells to Which window the Comments will be printed
  { Both of thenm Take the following Constants: WINDOW_MAIN        = 1;
    WINDOW_3D          = 2;
    }
  // for all Comments & times
  MovieDuration : Double;
  CommentsFrom: TDynWordArray; // Length = 7
  CommentsTo: TDynWordArray; // Length = 7
  HasComments: Boolean;
  // for Timers
  CounterType: TDynByteArray; // Length = 2
  TimeDuration: TDynByteArray; // Length = 2
  TimePrecision: TDynByteArray; // Length = 2
  TimeUnits: TDynAnsiStrArray; // Length = 2
  { -------------- Image Histogram Variables ---------------- }
  ScaleImHistFact: Double;
  OneBinImHist: array of LongWord;

  { ---------------- Color Table ---------------------------- }
  ClrTblArray  : TDynByteArray; //holds the entire color table file
  OrigTBLBlue  : array [0..2,0 .. 255] of Byte; { stores unchanged Bluue }
  OrigTBLGreen : array [0..2,0 .. 255] of Byte; { stores unchanged Green }
  OrigTBLRed   : array [0..2,0 .. 255] of Byte; { stores unchanged Red }
  FileColorTBL_Ch1 : TDynByteArray; { stores Color Table from Paleted TIFF Files }
  FileColorTBL_Ch2 : TDynByteArray; { stores Color Table from Paleted TIFF Files }
  ColTableSetings        : TColTableSetings;
  BottomColTableSettings : TBottomColTableSettings;
  { in File Blue 0-255; Green 256-511, Red 512-767 values }
  PixRange : array[0..1] of TPixRange; // memorizes Histogram range

  { -------------- General Image File Variables ---------------- }
  { used with  BlockRead(Files) ---------- }
  imXsize    : LongWord; { X dimention of Image }
  imYsize    : LongWord; { Y dimention of Image }
  ImagePix   : LongWord; { Number of Pixels in Image (frame) }
  ImageBytes : LongWord; { Number of Bytes  in Image (frame) }
  SizeOfFile : UInt64;    {File Size of Single Image File - Used to Load & Read in (from)  RAM }
  FileInRAM  : Boolean;  {True if Movie is Loaded in RAM - Used so Far for Single MultiImage Files}
  BMPPadding : Integer;

  PixSettings: TPixSettings;
  { TIFF Files Only [Grayscale Only so far }

  StripOffs   : array of UInt64; { FPos offset Where the Image Data Start }
  StripSizes  : array of LongWord; { = StripByteCounts TIFF terminology }
  TIFFfileType: Byte;
  { 1 = Generic GrayScale TIFF, 2 = QED, 3 = Prarie Technology }
  TiffFileList: TDynAnsiStrArray; { list of File Names }

  { Generic TIffs, Andor TIFF, StreamPix, Zeiss LSM, Noran SGI, Noran Prarie, QED Solamere Files }
  ImFile : THandle; // WIN32API handle;  {Global; Used for Any Image Files} {Used to be File - Pascal Handle till August 8, 2005}
  ImFname { Full Path + FName } , ImFtitle
  { File Name Only, without Extension} , ImFpath: AnsiString; { File name = Full Path }
  PrevImFileName : AnsiString; { stores Name of Last File Open }
  AllowFullPath : Boolean; { allowes Full path name for Last File Used }
  ImFileOpen: Boolean; { if true an image file is (stiil) open }
  ImTypeIndex : Byte; { memorizes OpenFileDialogIndex; See Constants for values }
  MainImLoaded : Boolean; { True Im MainIm Window has any Image; i.e. a File has been open (maybe closed) and loaded }
  ImageFileType: Byte;
  { SINGLE_IMAGE = 0; MULTI_IMAGE = 1; FILE_COLLECTION = 2 }
  MovFType: Byte;  { Stores Current File Type:
  ANDOR_MOV         = 0; // Andor Single MultiImage TIFF and TIFF Stack Movies
  SINGLE_BW_TIFF    = 1; // Single One or Multi Image Generic Black & White TIFF
  STACK_BW_TIFF     = 2; // Stack of Generic Black & White TIFFs
  BIORAD_PIC        = 3;
  NORAN_PRARIE_MOV  = 4;
  StreamPix_MOV     = 5;
  NIKON_ND2_MOV     = 6; //Single MultiImage Tiff File created by Nikon NIS Elements (introduced in Aug 2015) takes the place of QED MOV
  ZEISS_CZI_LSM_MOV = 7;
  NORAN_SGI_MOV     = 8;
  NIKON_TIFF_MOV    = 9;
  QED_MOV           = 10;}

  // in Prarie TIFF files actual bit-dept is 11 = 2048 [0..2047] , Not 12 as they claim
  // but Prarie Fakes bit-dept by multiplying by 2
  // Used in Mamy places to indicate that files are non Raw Noran Images, but Any Single Image File

  BigTiff      : Boolean;

  PrevFilePar: TPrevFilePar; { stores prev Movie File parameters }
  DelayMS      : LongInt; {delay in ms for playback}

  MovieCycleList: TDynLongIntArray; // used by Prarie Noran and QED in Multicyle movies; else = nil
  MovieFrRateList: TDynDoubleArray; // so far used by QED in Multicyle movies; else = nil

  MovieSeriesType : Byte; //TimeSeries = 0; //X - Y time series; Z_Stack    = 1; // X Y Z series

  ScopeSystemParams : TScopeSystemParams; //introduced sept 18, 2013 holds the Microscope System Parameters

  {----------------- RAM Managament---------------------------------------------}
  RAM_Usage : TRAM_Usage;
  { ------------------- Image Movie Control Variables -------------------------- }
  { in this program Image File is always Reset to 1 byte, so 1 Block = 1 byte }
  CurIm     : Longint; { current image }
  NrIm      : Longint; { Number of images in file }
  ImOff     : TDyn2DUInt64Array; { stores the offset [bytes] for every image }
  TimeSt    : TDynDoubleArray; { stores the timestamps (in sec)for every image }
  PixSize   : Double; { the Final Working Size of one pixel (microns per Pixel) used Through the Program }
  NrChannels : Integer;
  { Biorad, Andor, Zeiss LSM. So far this is used for Information Only }
  ScanType   : Integer; { Zeiss LSM, (Biorad not implemented yet }
  { These are For StreamPix (NorPix, Inc) specific for Time Stamps }
  SecMS     : Array of Longint; // [0] is seconds, [1] is MS
  MemSecMS  : Array of Longint; // [0] is seconds, [1] is MS
  FirstTimeStND2 : Double; {memorizes 1st time Stamp of Nikon nd2 files
                            used if opted not for reading all time stamps when open file AND Not in RAM
                            Used whn reading from Drive (Not RAM) and LoadStreamPixAndND2TimeSt = False}

  PlayBackMode: Byte; // works with Constants defined in this Unit

  { These are Andor TIFF Specific Variables for Time Stamps used in Stack of Single Image Files Except for AndorNotTimeArr }
  FirstAndorTime: Double; // memorizes Time Stamp of the First Image of Stack of Single Page TIFFs}
  AndorDimValOffs: Longint; // Ofsset to Get Dimension Values (Time etc) in Stack of Single Page TIFFs
  Andor_DIM_INFO: array of TMM_DIM_INFO; // other parameters to get Time or Other Dimension in Stack of Single Page TIFFs

  { Used in Andor Single or Multipage TIFFs }
  AndorNrDIM: Longint; // Number of Dimensions; Used by GetHelp
  DArray: Array of Double; // Dimension Array - Reads and Stores the offset to Dimensions For Single Image Andor TIFFs
  DimTime : Longint; // Time Used for Reading Single Image TIFF and Setting Plots and Playback
  DimNotTime : LongInt; // Z slices or Different Wave Lengths with Dim 3 and Time Dim 4; Used for Reading Single Image TIFF and Setting Plots and Playback
  ZstackArr : TDynDoubleArray; // Stores Z microns for Every Image;  Replaces AndorNotTimeArr; Used by Andor, Biorad and Zeiss Zstack Files; Introduced Oct 1, 2013
  //AndorNotTimeArr : TDynDoubleArray; //Disabled on Oct 1, 2013; Used to Store Any Not Time Dimension for Every Image (Wavelenght, or Z microns for Silces
  ZstackUnits : String; // Name of Zstack Units (µm); Replaces ZstackUnits; Used by Andor, Biorad and Zeiss Z stack Files;Introduced Oct 1, 2013

    { Used in Coolection Files = Collection of Multi Image (Multipage) Andor TIFFs }

  CollFileNames: TDynAnsiStrArray;
  CollFileHandles     : Array of THandle; // Used When Reading from H Disc; File Handle (Win32 & Win64) for Each File and Each Image;
  CollFileHandlesList : Array of THandle; // File Handle (Win32,Win 64) for Each File Only;
  //THandle is not mapped to integer any more, but to NativeUInt (that is, a cardinal only under Win32).
  // Length of Array = Nr of All Images; for Easy Reading; All Files are open
  CollFileNrInRAM  : TDynIntArray; // Used when Reading from RAM
  // Length = Number of Files; For easy Closing of Files
  CollFileImNr : Array of LongWord; // Number of Images for Each File; for Easy Loading the Files from the Table
  LoadChAsIndivFiles : Boolean; //Introduced sept 2016.  To load channels as individual files: 1st File = Ch1, 2nd File = Ch2, 3rd File = Ch1, 4thj File = Ch2, etc.
  {because the Upgraded andor setup produces 2 files from each camera and they have to be combined which takes a lot of time
   So, in this way they are combined by SparkAn}
  cbLoadChAsIndivFilesState : Boolean; // memorizes cbLoadChAsIndivFiles on Open Image Dialog

  { Number of Files is EQ to the Length of CollFileNames }
  { also uses:
    ImOff           : TDynUInt64Array; //stores the offset [bytes] for every image
    TimeSt          : TDynDoubleArray; //stores the timestamps (in sec)for every image
    ZstackArr   : TDynDoubleArray; //Stores Any Not Time Dimension for Every Image (Wavelenght, or Z microns for Silces
    }

  { ---------------------- Specific Image Variables ------------- }

  RawDataInRAM  : TDyn2DByteArray;  //used to load any Multiimage File in RAM}

  ImageZeroMap  : TDynByteArray;
  { used to Make Zero all Pixels Outside ROIs; To MAP all pix; }
  ImDataRat          : TDynDoubleArray;
  ImDataRatForSmooth : TDynDoubleArray;
  { Used For Ratio Images; Double is 1.25 times slower then single but in 64 bit Windows is Faster}
  Im16bitData         : TDynWordArray; { Non Smoothed Image (16 bit all 16 bit TIFFs }
  Im16bitDataSM_First : TDynWordArray;
  { Intermediate Smoothed Boxcar or Image: Holds 8 & 16 bit smoothed images }
  Im16bitDataSM_Last  : TDynWordArray;
  { Final Smoothed Median Image: Holds 8 & 16 bit smoothed images }
  pImData             : Pointer;
  { Used to Read Files: points to any of Im8bitData or Im16bitData }
  Im8bitData          : TDynByteArray;
  { Non Smoothed Image (8 bit) & Always used for Display }
  ImDispl  : TDynByteArray; { Used Only for Display }
  pImDispl : Pointer; { : Pointer works too!!! Used with CreateDIB & BitBLT Win32 API, points to:
    1) Im8bitDispl in case: 16 bit files and Ratioed Images;
    8 bit Non-Rat Images  when with Mod 4 <> 0;
    2) Im8bitData in case: 8 bit Non-Ratioed images when with Mod 4 = 0 }

  TwoChByteArr    : TDynByteArray; //Used in Two Channel Nikon ND2 files
  TwoChWordArr    : TDynWordArray; //Used in Two Channel Nikon ND2 files

  //Secondary Image Variables - introduced April 2013 to Display more than One Channel
  Im2nd8bit        : TDynByteArray;
  Im2nd16bit       : TDynWordArray;
  Im2nd16bitSM_Last : TDynWordArray;
  Im2ndDispl       : TDynByteArray;
  MergeImData      : TDynByteArray;
  MergeImDispl     : TDynByteArray;
  MergeModel       : Byte; //stores the position of frmImageControl.cbMergeModel: see constants
  OverlayThreshold : Word; //stores position of frmImageControl.trbOverlayThreshold
  p2ndImData       : Pointer;
  p2ndImDispl      : Pointer;
  TimeStStore      : TDynDoubleArray;
  ChannelOrder : Byte; //takes the ASCENDING  = 0; and DESCENDING = 1;
  {stores the Complete Array of Timestamps (in sec)for Every image and All the Channels
   if NrChannels are > 1 then if file is Andor then TimeSt copies Time Stamps for the
   channel displayed in the Main window from the TimeStStore since the Channels are recorded sequentially in time.
   If file is Zeiss LSM or Biorad then the Time stamps are the same for all the channels since
   they are recorded in the same time. Therefore, for Zeiss LSM we don't need to use TimeStStore.}

  { ---------Normalization in Time Variables ----------------- }
  ImDataMin   : TDynWordArray; { stores Min for the whole file }
  ImDataDelta : TDynWordArray; { stores Max - Min for the whole file }

  { For Jump average }
  JumpOrRunAvArr: TDynLongWordArray; // changed from TDynWordArray to able to accumolate large numbers
  JumpAv : Byte; { No Jump = 1, Jump by 2 = 2, Jump by 4 = 4 }
  RunAv  : Byte; {Running Average; 1 = No Running Average, 3 or 5 = Running Ave of 3 or 5 images}
  shrFact: Longint; { Which Does shr for Display }
  { Zero if imXsize Mod 4 = 0; Displayng Image needs Array in Word Boundary }
  ToSwap : Boolean; { If true then SwapBytes (for Motorola ,Mac Files) }
  memBMP : TBitmap; { BackUp - used by Main & Aver Image }
  IntBMP : TBitmap; {Intermediate BMP, used by Direct2D to create a Direct2D Bitmap}
  Direct2D_Supported : Boolean; // if the Windows version supports Direct2D (from Windows 7)
  Zoom: Longint; { 1 if no Zoom; 2 if Zoom = 2; -2 if Decrease by 2 }
  { --------------------Win 32 BitMapHeader Image Bitmap Info Variables ------------- }
  lpBitmapInfo : array [0..2] of pBitmapInfo;
  { pointer to bitmap info header, decl in Widows.pas
    [0] for Main & Aver Image, [1] for Ratio Image, [2] for 2nd channel Image}
  pMergeBMPInfo  : pBitmapInfo; //used for the merge window
  CurrClrTablInd : Integer; //Current Color Table Index
  BitCount: Word; { 1 if 8 bit, 2 if 16 bit } { Word is needed fotr TIFF files }

  { -------- end of declaring variables for API ----- }

  { --------- Smoothing Variables Except from Image Arrays --------------- }

  FiltSize1D   : Integer; //1D BoxCart or Gaussian Filter Size
  BoxcarOn: Boolean; { True if Boxcar Image smoothing is On }
  MedianOn: Boolean; { True if Median Image smoothing is On }
  GaussOn: Boolean; { True if Gaussian Image smoothing is On }
  SmoothMode: Byte; { see constants }
  SmoothOrder: Byte; { see constants }
  BoxSmSize: Integer; { Size X x Y (X=Y)of the Kernel for Boxcar smoothing }
  MedSmSize: Integer; { Size X x Y (X=Y)of the Kernel for Median Smoothing }
  GaussSmSize: Integer; { Stores the Mode of Gaussian Smoothing - see Const }

  SmoothNonRatio : Byte; // One  = smooth Non Ratio Cahhel One (Regular) Image
                         // Two  = smooth Non Ratio Cahhel Two (Regular) Image
  { ----------- Average Image & Ratio Variables ------------------------------- }
  AvImList  : TDynByteArray; { EQ to NrIm; if AvImList[x] > 0 then Selected }
  AvIm      : TDynDoubleArray; { stores Smoothed or Non-Smoothed Average Image Data with Background subtracted}
  AvImRaw   : TDynDoubleArray; { stores Raw Average Image Data }
  AvIm8bit  : TDynByteArray; { Used to Display Average Image }
  ImSel     : Integer; { Selected Images for Averaging }
  AvImExists: Byte;
  { 0 = No Av Image, 1 = Selected (On line), 2 = From File, 3 = From Minimum }
  AvImChOrig : Byte;  //directs the Use of Proper Color table. Origin of the Average Image: 1 = Ch1, 2 = Ch2; added March 2017
  RatioOn: Boolean; { if True then Ratio is On }
  ChannelsRatioOn : Boolean;
  MaxRatio : Double; { Maximal Ratio }
  DispFact : Double; { DispFact := 255/MaxRatio; used normalize }
  {Background (Offset) is equal to Zero in all the files except for Andor cameras}
  Bkg     : Word;  //Backround (offset) for the 1st channel
  Bkg2nd  : Word;  //Backround (offset) for the 2nd channel
  BkgValues    : Packed Array [0 .. 10] of Word; //Backround for the 1st channel for nine File Types
  Bkg2ndValues : Packed Array [0 .. 10] of Word; //Backround for the 2nd channel for nine File Types
  MaxPixVal    : Word;
  CutOff: Word;
  AvImInfoStr: AnsiString;
  { Holds Info fo AvImfrom File and Minimum; Not On Line }
  AvImFPath: AnsiString;
  { ------------------------ Box Variables ------------------------------------------- }
  ROIvar: TROIvar; { Type Record }   { ROI = rectangles & Circles Variables }
  ROIrct: TROIrct;

  InROI        : Boolean;
  CurROIadr    : Integer;  {the Address of the Current ROI (Any Kind}
  CurROIkind   : Integer;  {stores Kind of ROI when Mouse Move, to be updated in MouseUp;}
  XL,Xr,Yup,Yd : Integer;

  { --------------  Measure Line Variables ------------------------------- }
  MesLineVar: TMesLineVar;
  MesLine: TMesLine; // used also to construct Fake Line Scan

  { --------------  Measure (Tracking) Diameter Variables ------------------------------- }
  DiamMesRect: TDiamMesRect;
  TrackData: TDyn2DIntArray; // [0] is for First ROI, [1] is for the Second ROI
  TrackPath: TDyn3DTPointArray;
  // First Dimension is always 2 - set to Begining and the End Track areas
  // Second Dimension is set to the Width of Track Area - i.e. Number of Lines
  // Third Dimension is set to the Lenght of each Track Area - the beginong and the End

  Im16bitDataTR : TDynWordArray; //EQ to Image Array but only Tracking Rect Area loaded and updated for every image,  the rest is Zeroes
  //used to avoid mistakes if only Tracking area is used.  Tracking Area is defined by the most Left, Right Top Bottom where ROI is allowed to move
  TrackAreaOne : TDynWordArray; //Array used to Find Mean using GetMeanStdDevLimits
  TrackAreaTwo : TDynWordArray; //Array used to Find Mean using GetMeanStdDevLimits
  TrackAreaMeans :  TTrackAreaMeans;  //Used by both Diam Measur and ROI track
  TrackRect : TSimpleRect; //This Rectangle includes all pixels covered by ROI tracking/Diam trecking;  Used to avoid copying all the pixels
  BinaryImage : TDynByteArray;// Same size as Image. Only the pixels covered by ROI trac king/Diam Meas are set to 1, rest = 0
  TrackAreaTableOne : array of TXcoorCouple; //table of X beg & X end if there is One Pixel in the row Xb = Xe
  TrackAreaTableTwo : array of TXcoorCouple;
  YtopOff : array[0..1] of Integer; // Y top for the 1st pixel in TrackAreaTableOne & Two
  { --------------  ROI Tracking Variables Experimental ------------------------------- }
  XtolBeg,XtolEnd,YtolBeg,YtolEnd : Integer;
  FhPolTr       : TDynTPointArray;
  FhTblTr       : TDyn2DTPointArray;
  TrackROIdata  : TDynIntArray; //stores the initial pixel values from Free hand ROI
  ROICoorMem    : array [1 .. 4] of Integer;
  { BoxCoor[1] = Xleft; [2] = Yup; [3] = Xr  [4] = Ydown }
  ROItracking   : Boolean;
  { --------------  Size Bar on all 2D windows ------------------------------- }
  SizeBarVisible : Boolean;
  SizeBar        : TTimeOrSizeBar;
  {-------------- 2D Window Grid ------------------------------------------------}
  WindowGrid : TWindowGrid;
  { ----------------- (fake) Line Scan Variable -------------------- }
  InScaleBar    : Boolean = False;  //used by Size and Time Bar
  LineScanExist : Boolean = False; // Image Line Scan was created
  LSTimeBar     : TTimeOrSizeBar;
  LSTimeBarPar  : TLSTimeBarPar;
  { ------------------ End of fake Line Scan Variables ------------------ }

  { ---------------  3D Image Variables ----------------------------------- }

  // --- Win3DOn and OpenGLReady are used in many parts in the program
  Win3DOn     : Boolean = False;
  OpenGLReady : Boolean = False;

  HideBackFace : Boolean;
  Win3DXYsize  : Integer;
  MergeColors  : TMergeColors;
  // ---- below are used only in frm3DImageWin and frm3DImageContr and are stored in SparkAn.par
  Mode3D: Byte; // takes Const values - > glModePerspective = 1;     glModeOrthogonal  = 2;
  // smoothing of 3d image for Non-ratioo Images Only
  Crop3DImage: Boolean; // if True - Crops Non-smoothed part of the Image
  // rotation and viewing (Perspective Mode Only)
  xRotAngle: Integer; // should be glFloat but it works with integer too
  yRotAngle: Integer;
  zRotAngle: Integer;
  ViewAngle: Integer; // should be glDouble but it works with integer too
  // Scaling
  ScaleZ: glFloat;
  ScaleXYZ: glFloat;
  Min3DRat: glFloat;
  // ------- Axes ------------
  // XY axes position & On or Off
  XY_Axes_LT: Boolean; // XY axes at Left,Top position
  XY_Axes_RT: Boolean; // XY axes at Right,Top position
  XY_Axes_RB: Boolean; // XY axes at Right,Bottom position
  XY_Axes_LB: Boolean; // XY axes at Left,Bottom position
  // Z axes
  Z_Axes_LT: Boolean; // XY axes at Left,Top position
  Z_Axes_RT: Boolean; // XY axes at Right,Top position
  Z_Axes_RB: Boolean; // XY axes at Right,Bottom position
  Z_Axes_LB: Boolean; // XY axes at Left,Bottom position
  // X,Y axes color
  glXYRed   : Single;
  glXYGreen : Single;
  glXYBlue  : Single;
  // Axes Thickness
  XYthickness : Integer;
  Zthickness  : Integer;
  // Background Color
  glBgRed    : Single;
  glBgGreen  : Single;
  glBgBlue   : Single;

  { ------------- E N D   of 3D Image Variables  ------------------- }

  { -------------------------- Time Series Analysis--------------------- }
  { Basic }
  { 2 dimention array }
  // the First 2 are used for Plotting, Peak analysis, prointing , ets}
  TSPlotData_BaseNotSubtr: TDyn2DDoubleArr;
  { stores Final Not Baseline Subtracted Traces }
  TSPlotData_BaseSubtr: TDyn2DDoubleArr;
  { stores Final Baseline Subtracted Traces }

  TSPlotData_BackUp: TDyn2DDoubleArr;
  { stores Raw data = Not Smoothed and Not BaseLine Subtracted }

  TSPlotData_BackUp_ChdivCh : TDyn2DDoubleArr;
  { stores Raw data from Ch div Ch data }

  TSPlotData_Area: TDyn2DDoubleArr;
  { stores Area vs. Time Non - Ratioed Raw Data; used Only for Area and Area/min options }
  TSPlotData_BaseLine: TDyn2DDoubleArr;
  { stores Baseline determined by Gausians -like method - 2 consecutive means }

  Divider: array of Double; { this is the minimum used for Area/min }
  CopyOfTimeSt: TDynDoubleArray; { stores Copy of Timestamps for the Analyzed portion of File
    (in sec)for every image to be able to save results
    if a New File has been open; }
  TraceArr: array of TPoint; { Plots Data on Time Series Plot }

  StopAnal: Boolean;
  LinkTimeSerPlotAndImage: Word; // so far not implemented - takes several constants
  PLOTvar: TPLOTvar;
  AnalInAction: Boolean;
  Fh: TDynTPointArray; { used While Drtwwin Free Hand then transfer to FhPol }
  FhTbl: TFhTbl; { TFhTbl = array[1..20] of array of array of TPoint; }
  FhPol: TFhPol; { TFhPol = array[1..20] of array of TPoint; }

  { ------------ Peak Analysis -------- }
  PeakPosArr: TDyn2DWordArray; { contains Image Nr (position of each peak) for Peaks for each Trace }
  PeakValArr: TDyn2DDoubleArr; { contains Value for Peaks for each Trace }
  PeakBasArr: TDyn2DDoubleArr;
  {contains Value for Baseline for each peak for each Trace; Baseline found by serching min (Defined Points, Defined Range) }
  PeakTimArr: array of array of TDurTimes; { contains Left(L) and Right(R) Times (L and R of Peak)
    of Duration at 1/2 amplitude for Peaks for each Trace }
  RiseTimeArr: TDyn2DDoubleArr; { contains RiseTime (10%-90%) for each peak }

  PeakFakeImNrArr : array of array of TDurImNr; { Plot Image Nr used for To Plot Peaks Times }
  BaseImNrArr     : array of array of TBaseImNr;  {Plot Image Nr used for To Plot Base individual Times }

  // for UndO when Delete a Peak//
  UnDoPeakPos: Word;
  UnDoPeakVal: Double;
  UnDoPeakBas: Double;
  UnDoPeakTim: TDurTimes;
  UnDoRiseTime: Double;
  UnDoPeakFakeImNr : TDurImNr;
  UnDoBaseImNrArr  : TBaseImNr;

  { ------------------------- Integrate Trace variables ------------------------------------------ }
  IntegrTableEmpty  : Boolean;          // If Integration Table is Empty
  UseThres          : Boolean;          // To Use or Not Threshold
  ConvertAreaToNPo  : Boolean;          // To calculate NPo  = true
  IntThres          : Double;           // Threshold for Integration
  TransferToPlot    : Boolean;          // Sets to Zero PlotArray if Threshold was used & there is Zeros
  LastROI           : Integer;          // Last ROI used - used by Undo
  AreaMem           : Double;           // used by Undo
  NPoMem            : Double;           // used by Undo
  NrIntegMem        : Integer;          // used by Undo
  ROI_XY_Mem        : TPoint;           // used by Undo
  SingleChannelAmplitude : Double;      // Single Channel Amplitude measured in F/Fo
  Area_Integr       : TDynDoubleArray;  // Integral of the Area of a Trace
  NPo_Trace         : TDynDoubleArray;  // NPo of a Trace
  NrIntegrTrace     : TDynIntArray;     // Number of Integrations per Traces
  ROI_XY: Array of TPoint;              // ROI X and Y coordinates

  { ------------------------- Half Amplitude Spatial Spread variables ------------------------------ }
  { Unlike Other Arrays Spread Arrays Exist Only if Spread Table is Closed
    and Are filled On Closing the Table.  Thats why All the Selections are done with table Open
    this simplifies the operations }
  SpreadMesRect: TPoint; // X and Y of Amplitude Measuring Rectangle (set on the Spatial Spread table;
  SpreadImNr   : TDynLongIntArray; // holds Image Number
  SpreadCoor   : array of TPoint; { Coordinates of the Amplitude }
  SpreadAmpl   : TDynDoubleArray; { Amplitude }
  SpreadSurface: TDyn2DDoubleArr; { Spread uM square }
  SpatialSpread_NrImagesToCalculate : Integer;
  //Number of Images to calculate Spatial Spread Using the same Amplitude determined in the 1 st Image
  //Introduced in Sept 2016, requested by Jonathan Ledoux in 2015
  SpatialSpread_Baseline : Integer;  //Baseline of Non Ratioed Images determined by User
  { ----------------------------------------------------------------------------------------------]

    TMarkArrXY        = array of array of TPoint;    {Columnns = Nr of Image, rows = Nr of Marks }

  { -------------------------- Mark Variables and Spark & Big Table variables ----------- }
  MarkSmEvCoor: TMarkArrXY;
  { array of array of TPoint: Columnns = Nr of Images, rows = Nr of Marks }
  MarkBigEvCoor: TMarkArrXY; { Same as Above fo Big Events }
  MarkSmAmpl: TDyn2DSingleArr; { Amplitudes of Small Events = [ImNr, Value] }
  MarkBigAmpl: TDyn2DSingleArr; { Amplitudes of Big Events =   [ImNr, Value] }
  MarkSmBase: TDyn2DSingleArr;
  { Small Events Baselines =   [ImNr, Value]  Initially set to 1.00 (F/Fo units }
  MarkBigBase: TDyn2DSingleArr;
  { Big   Events Baselines =   [ImNr, Value]  Initially set to 1.00 (F/Fo units }
  MarkSmEvDur: TMarkArrDur; { holds Time to the Left and Right of Peak }
  MarkBigEvDur: TMarkArrDur; { holds Time to the Left and Right of Peak }
  MarkSmEvRise: TDyn2DSingleArr;
  { Rise Time (sec) of Small Events = [ImNr, Value] }
  MarkBigEvRise: TDyn2DSingleArr;
  { Rise Time (sec) of Big   Events = [ImNr, Value] }
  MarkPar: TMarkPar;
  SpTabEmpty: Boolean; { if true then Small Events (Sparks) Table is Empty }
  BigTabEmpty: Boolean; { if true then Big Events Table is Empty }
  MarkTablesPar: TMarkTablesPar; // parameters of Mark tables used to save them
  { ------------------------- Auto Search ------------------------------ }
  AutoSearchPar: TAutoSearchPar; { parameters of Form SPautoSearch }
  StopSearch: Boolean;
  FinalCutOff : Boolean = True; //set to True here
  { ---------------------Q File Variable -------------------------------------- }

  QFileList:   array of TQFileDat;

  { ---- Variables Removed from Records Because They Cannot be Written to SparkAn.par because of Different Length --- }
  PLOT_FTitle: AnsiString; // Title of the Time Series Plot Window
  Full_imFileTitle: AnsiString; // Complete File Description used in Saving
  File_Comment: AnsiString;

  { ------------------------ HELP variable ----------------------------------- }
  HELP_SrtList: TStringList; // Contains Help sentenses
  HELP_Point: TPoint; // memorizes the Mouse Pos to Display Help there
  { ----------------------- OrthogonalSectioning ----------------------------- }

  OrthogonalSectioningOn : Boolean; //True if the frmOrthogonalSectioning is On

  { -----------------------------frmRealLineScan---------------------------- }
  RealLineScanOn : Boolean;  //True if the frmRealLineScan is On
  { *************************************************************************** }
Procedure AddMarkToMarkArray(var MarkArrXY: TMarkArrXY;
  var MarkAmpl: TDyn2DSingleArr; var MarkBase: TDyn2DSingleArr;
  var MarkEvDur: TMarkArrDur; var MarkRiseTime: TDyn2DSingleArr;
  Const Xmouse, Ymouse: Integer; Const UseMarkSize: Boolean);
Procedure ApplySmoothing; { used to apply any Smmothing on Main Window}
Procedure ApplySmoothingOn2ndChannel; { used to apply any Smmothing on 2nd Window}

Procedure CalculateMesLineParams(Const MouseX, MouseY: Integer);
// Calculates Final Parameters of Measuring Line at MouseUp
Procedure CalculateOffsXorYbeg(MesLineXorYbeg, MesLineXorYend: Integer);
procedure CalculateXYprofile;
Procedure CheckIfMesLineSelected(MouseX, MouseY: Integer);
// Do Not Declare as Const
Procedure CheckIfMesDiamSelected(MouseX, MouseY: Integer);
Procedure DrawMesLine(Xbeg, Ybeg, Xend, Yend: Integer; Const aCanvas: TCanvas);
{ Xbeg,Ybeg,Xend,Yend here are used as local variables; do not use them as Const or Var }
Procedure CheckIfInScaleBar(const X,Y: Integer; const ScaleBar : TTimeOrSizeBar; Visible : Boolean);
Procedure CheckIfInROI(Const X, Y, SearchFor: Integer); { Check if Cursor in ROI }
Procedure CheckIfInMark(var MarkArrXY: TMarkArrXY; var Xm, Ym: Integer;
  var InMark: Boolean; var Mpos: Integer; Xmouse, Ymouse: Integer);
procedure CheckIfSelFrameFits;

Procedure CopyAvImToDisplBuffer; { copies AvIm to AvIm Displ Array }

Procedure CreateImageInputOutputCurve; inline; //Creates Input/Output Curve on Image Control&Tools window - reflects how the Image is processes by Contrast, Shift,Gamma

Function  CreateMarkComment(const GenGenSetComm,GenAutoSearchComm : Boolean) : AnsiString;
Procedure DeleteROI;
Procedure Delay(var msec: Longint);
Procedure DelAnyMarkFromMarkArr(var MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr;
                                var MarkBase: TDyn2DSingleArr; var MarkEvDur: TMarkArrDur;
                                var MarkRiseTime: TDyn2DSingleArr; Const Mpos, ImNum: Integer);

Procedure DelRowInStringGrid(var StrGrid: TStringGrid; var TabEmpty: Boolean;Xmark, Ymark: Integer);
Procedure Display2ndChannel;
Procedure DisplayMergeImage;
Procedure DoRatio(Const CopyToDisplay: Byte); { Does the Ratio for Imaging }
Procedure DoChannelRatio(Const CopyToDisplay: Byte); {does Ratio for Imaging}

Procedure DoRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer; Const AnyIntData: TDynByteArray); overload

Procedure DoRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer; Const AnyIntData: TDynWordArray); overload

Procedure DoChannelsRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer;
                                 Const WinOneIntData,WinTwoIntData : TDynWordArray);overload

Procedure DoChannelsRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer;
                                 Const WinOneIntData,WinTwoIntData : TDynByteArray);overload

Procedure DoBkgonAvIm; { Does Bkg subtraction on Average working AvIm }
Procedure DrawComment(Const x, y: Integer; Const CommentTransparent: Boolean;
  Const Alignment: TAlignment; Const CommentFont: TFont;
  Const BkgColor: TColor; Const Text: AnsiString; Const Canvas: TCanvas);

Procedure DoOneRowAnal(var StrGrid: TStringGrid; Const MarkArrXY: TMarkArrXY;
  Const MarkEvDur: TMarkArrDur; Const MarkBase: TDyn2DSingleArr;
  var TabEmpty: Boolean; Const ARow: Integer; Const TimeCode: Word);

Procedure DoSmoothForROI(Var RawByteArr: TDynByteArray; Var RawWordArr, WordArrA, WordArrB: TDynWordArray;
                        Const XLL, Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset,
                        SmGaussOffset: Integer); // used by GetDurForMark & RecalculateMeanforMark

Procedure DoSmoothRatioForROI( Var RawDoubleArr, DoubleArrA, DoubleArrB: TDynDoubleArray;
                               Const XLL, Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset,SmGaussOffset: Integer);

Procedure DrawAllSmallEvMarks(Const aCanvas: TCanvas);
Procedure DrawAllBigEvMarks(Const aCanvas: TCanvas);
Procedure DrawMesBox;
Procedure DrawSmalEvMarks(Const aCanvas: TCanvas);
Procedure DrawBigEvMarks(Const aCanvas: TCanvas);
Procedure DrawSelFrame(Const aCanvas: TCanvas);
Procedure DrawTimeSerPlotTraces(Sender: TObject;  Const PlotData: TDyn2DDoubleArr);
Procedure DrawTimeSerPlotXaxes;
Procedure DrawTimeSerPlotYaxes;
Procedure DrawTimeSerPlotXticks;
Procedure DrawTimeSerPlotYticks;
Procedure DrawTimeSerPlotCursor; { Requested by Tom }
Procedure DrawGrid(Const aCanvas: TCanvas);
Procedure FillMovieFrRateListAndCalcMeanImTime;
Procedure FinishFhROI(Const x, y: Integer; Var CntFh: Integer);
Procedure FreeMemBMPused;
procedure FillTrackArea; inline;

Procedure GetCurValue(Const XLL, Xrr, Yupp, Ydd: Integer; Var CurVal: Double);
// used by GetDurForMark & RecalculateMeanforMark

Function GetDistance(Const X1, Y1, X2, Y2: Integer): Double;
// gives Length of Mes Line in  Microns
Function GetDistancePix(Const X1, Y1, X2, Y2: Integer): Integer;
// gives Length of Mes Line in  Pixels

procedure GetDosOutput(CommandLine, WorkDir: String; var aProgressBar : TProgressBar; aLabel : Tlabel); //used to make mp4,flv,mov movies

Procedure GetDurForMark(Const MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr; Const MarkBase: TDyn2DSingleArr;
                        var MarkEvDur: TMarkArrDur; var MarkRiseTime: TDyn2DSingleArr;
                        Const NrPtForBase: Word; Const BaseSearchRange: Word);

function Get1DGaussFc : Double; //Used in GetHelp
Function GetFirstFreeAddress: Integer; { --- Used to Handle ROI --- }
Function GetFreeHandROInumber: Integer;
Procedure GetSelFrameParams(var BMPwh: TBitmap; var Left, Top, Right,Bottom: Integer);

Procedure GetHelp(Const HelpCode: Integer);
Procedure CreateOneBinImHist; //Creates One Bin Image Hist whch is later used by CreateImageHistogram to create the Final Image Histogram

Procedure GetMarksBaselines(Const MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr; var MarkBase: TDyn2DSingleArr;
                            Const NrPtForBase: Word; Const BaseSearchRange: Word);

Procedure GetMarkSelection(Const MarkArrXY: TMarkArrXY; Const ImNr, M: Integer;
  var XLL, Xrr, Yupp, Ydd: Integer); // used by GetDurForMark & RecalculateMeanforMark

Function GetMeanROI(Const XLL, Xrr, Yupp, Ydd: Integer;const KindROI: Integer): Double;
{ KindROI: if 1 then Box, If 2 then Circle, If 3 Then Free hand }
Function GetMeanROIAverIm(Const AnyAvIm: TDynDoubleArray; Const XLL, Xrr, Yupp, Ydd, KindROI: Integer): Double;
Function GetMeanFhROI(Const Location: Byte): Double; { gets Mean Free hand }

Function GetMeanROIforTimeSerAnal(Const XLL, Xrr, Yupp, Ydd: Integer;
                                  Const KindROI: Integer; Const AnyAvIm: TDynDoubleArray;
                                  Const AnyIntData: TDynByteArray): Double; overload;

Function GetMeanROIforTimeSerAnal(Const XLL, Xrr, Yupp, Ydd: Integer;
                                  Const KindROI: Integer; Const AnyAvIm: TDynDoubleArray;
                                  Const AnyIntData: TDynWordArray): Double; overload;

Function GetMeanROI_From_Ratio_ForTimeSerAnal(Const XLL, Xrr, Yupp, Ydd: Integer; Const KindROI: Integer;
                                              Const RatioData : TDynDoubleArray): Double;
                                              {used to get  mean for F/Fo when smoothing is doen after division and Ch1/Ch2}

Function GetNrElemAboveThres(Const XLL, Xrr, Yupp, Ydd: Integer;
                             Const AnyData: TDynByteArray): Integer; overload;
{Returns the Number of Pixels >= Threshold in the Time Series Plot
 Used for Free Hand ROI Only }

Function GetNrElemAboveThres(Const XLL, Xrr, Yupp, Ydd: Integer;
                             Const AnyData: TDynWordArray): Integer; overload;

Function GetNumberOfPixels : Int64;

Procedure GetOffsetFor2DSmoothing(var SmBoxOffset, SmMedOffset, SmGaussOffset: Integer);
// GetOffsetFor2DSmoothing is used by Timeseries Analysis, GetDurForMark & RecalculateMeanforMark

Procedure GetPeaks(Const PlotData: TDyn2DDoubleArr);

Function GetTimerString(Const LabelTag: Integer;
  TimePrec: ShortInt): AnsiString;

Procedure InitVarOnStart;
Procedure InitBitmapHeaderXY(Const ImageWidth, ImageHeight: Integer); { updates X and Y parameters only }

Procedure KeepROIinWindow; { Keeps ROI [Boxes Only) in Window }
Procedure KeepAllROIinWindow(Const KindROI: Integer;
                             Var XLL, Xrr, dXpr, Yupp, Ydd, dYpr: Integer;
                             Var CanMoveX, CanMoveY: Boolean);
procedure LoadClrTableFileInRAM;
Procedure LoadColTable(Const CtSetNr: Integer);  {Load s & initializes color table }
procedure LoadOwnFileTables; {loads Load s & initializes color table imbedded in image file if available}
Procedure MakeAverIm; { Makes Average Image by Summing and Dividing }
Procedure MakeMetaFile(const SaveAsFile: Boolean; const PlotData: TDyn2DDoubleArr; const MFName : AnsiString);
Procedure MakeMovieWithFFMPEG(Const MovieFileName : AnsiString);
Procedure MakeMinRunAv(var RunAvMinArr: TDynSingleArray; Const Pnt: Integer;
                        Const First, Last: Integer);
Procedure MakeRunAv(var AverArr: TDynDoubleArray; const ImList: array of Integer; const NrImToAver: Integer);
Procedure ModifyColTable(Const CtSetNr: Integer);
Procedure CreateAverImHelpStr; // works with GetHelp
Procedure PrepareForTrackDiameter;
Procedure PrepareForMakingMovie(MovieFileName : AnsiString; Sender : TObject);
Procedure PrintCommentsForMPEGmov(Const Target: TComponent;Const SourceRect: TRect; Var TemBMP: TBitmap);
Procedure DrawScaleBar(const Zoomed : Integer; Const ScaleBar : TTimeOrSizeBar; Const aCanvas: TCanvas); inline;
Procedure DrawROI(Const aCanvas: TCanvas);inline;
Procedure PutBoxesOnMarks(Const StrGrid: TStringGrid; Var MarkSelArr: Array of Word; Const NrOfSelMarks: Word);
{ NrOfSelMarks = Nr of Rows }
Procedure PlaceMark(Const Xm, Ym: Integer; Const Clr: LongWord;
  Const aCanvas: TCanvas; Const SetPar: Boolean);
Procedure PutRowInStringGrid(var StrGrid: TStringGrid; Var RowFoc: Integer;
  Const MarkArrXY: TMarkArrXY; Const MarkAmpl: TDyn2DSingleArr;
  Const MarkBase: TDyn2DSingleArr; var TabEmpty: Boolean);
Procedure ReadImage(const ImNr: Integer; const ChNr : Integer; var ptData : Pointer);
Procedure ReadImageForAnal(const ImNr: Integer;
  const Offsets, NrPix: TDynLongIntArray);
Procedure ReadSparkAnPar(const ParFileName: AnsiString;
  var DidGetSparkAnPar: Boolean; const GiveMess: Boolean);

Procedure RecalculateMeanforMark(var MarkArrXY: TMarkArrXY;var MarkAmpl: TDyn2DSingleArr);

Procedure RefillStringGridEvents(var StrGrid: TStringGrid;
  var MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr;
  var MarkEvDur: TMarkArrDur; var MarkRiseTime: TDyn2DSingleArr;
  var MarkBase: TDyn2DSingleArr);
Procedure DisableFileColorTable;
Procedure ReplaceCh1InND2File(Const ByteArr  : TDynByteArray; Const WordAarr : TDynWordArray);
Procedure ResetFromToTEdits(Const CommentsVal: Word; Var edFromTo: TEdit);
Procedure SmoothAverIm(Const InputArr: TDynDoubleArray; var OutputArr: TDynDoubleArray);

Procedure SmoothBorders;
{ used to apply any Smoothing on Borders for TimeSeriesAnalysis }

Procedure SetBuildInROIcolors(var ROIclr: TROIColArr; var FntClr: TFontColArr);
Procedure SetBkgAndCutOffSliders;
Procedure Scale16bitImageToImDispl(const ChNr : Integer;var DisplayArray : TDynByteArray);
procedure SetFormSize(Const AnyForm: TForm; Const AnyImage: TImage);

Procedure SetDiamMesRect(Xbeg, Ybeg, Xend, Yend: Integer);
Procedure SetDiamMesRectBegAndEnd(MesLineXorY_BegOrEnd: Integer;
        var DiamMesRectXorY_BegOrEnd, OffsXorY_BegOrEnd: Integer; Const dXorYpr: Integer);
Procedure SetTIFfilesStack(Const NameOfFile: AnsiString; Const SilentMode: Boolean);

Procedure ScaleOffsXorYbegToReal;
Procedure ScaleOffsXorYbegToCurrent;
Procedure SmoothRatioImage(var InRatio, OutRatio : TDynSingleArray); overload;  { used to apply any Smoothing on Ratio After it is Done in AutoSearch }
Procedure SmoothRatioImage(var InRatio, OutRatio : TDynDoubleArray); overload; { used to apply any Smoothing on Ratio After it is Done }
procedure NegateColorTables;
Procedure TrackDiameter;
procedure TrackROI;
Procedure Transfer8bitImageToImDispl(var DisplayArray : TDynByteArray);
Procedure TurnOffXYprofileAverImCheckBox;
Procedure UpdateAverImage(const DrawEverything : Boolean); // if True draws ROIs & marks & Line before Repaint
Procedure UpdateMainImage(const DrawEverything : Boolean); // if True draws ROIs & marks & Line before Repaint
Procedure UpdateROI;
Procedure UpdatePixelSizeSettings;

{
  Unfinished - Uses Aver/min  to update All Mark Parameters

  Procedure UpdateMarksUsingAreaDivMin(var MarkArrXY :TMarkArrXY; var MarkAmpl : TDyn2DSingleArr;
  var MarkBase : TDyn2DSingleArr; var MarkEvDur : TMarkArrDur);
  }

procedure WriteLogFile(Sender: TObject; const FileNameCreated: AnsiString);

Procedure WriteSparkAnPar(const ParFileName: AnsiString);
Procedure WriteImage(FhCor: THandle { WIN32API handle } ; const ImNr: Integer;
  const im8bitBuffer: TDynByteArray; const im16bitBuffer: TDynWordArray);
// used to Overwrite Image Portion of Movies when scaled (e.g. to compensate for bleaching//
Procedure WriteBMPsForFFMPEG(Const MovieFileName : AnsiString);

Procedure ZeroOutsideROI(var RawImData: TDynByteArray); overload;
Procedure ZeroOutsideROI(var RawImData: TDynWordArray); overload;
Procedure ZeroOutsideROI(var RawImData: TDynDoubleArray); overload;

{ ************************************************ }
implementation

uses unMainWindow, unImageControl, unAverIm, un2ndWin, unTimeSerAnal, unOKDlgNrImToExp,
  unSparkTable, unWaveTable, unSPautoSearch, unPeaks, unHelp, unPlayBack, Main,
  MovieLabels, unProgress, unSpatialSpread, un3DImageWin, unLineScan,unMergeWindow,
  DigiFilters, un3DImageContr, Convert, unEventSites, unCorrectForBleaching,
  unKalmanStackFilter,unFunctions,ImageFilesOpeningRoutines,OrthogonalSectioning,unXYprofile;

{$R MyCursors.res} // links program to Resource File

{ ***************************************************************************************** }

Procedure ReadSparkAnPar(const ParFileName: AnsiString;
  var DidGetSparkAnPar: Boolean; const GiveMess: Boolean);

Type

  TSparkAnSingleVar = Packed Record
    BoxSmSize: Integer;
    { Size X x Y (X=Y)of Boxcar Kernel for Boxcar smoothing }
    MedSmSize: Integer;
    { Size X x Y (X=Y)of Median Kernel for Median Smoothing }
    GaussSmSize: Integer;
    { Size X x Y (X=Y)of Gaussian Kernel for Gaussian Smoothing }
    MaxRatio: Integer;
    Bkg    : Word;
    Bkg2nd : Word;
    CutOff: Word;
    LinkTimeSerPlotAndImage: Word;
    LoadStreamPixTimeSt: Boolean;
    CheckAllFilesExist: Boolean;
    ShowFullPath: Boolean;
    AllowFullPath: Boolean;
    AlignfrmPlayback: Boolean;
    BoxcarOnZerPixAvIm: Boolean;
    UseMoviFilePath: Boolean;
    SetBkgToZero: Boolean;
    SmoothMode: Byte; { see constants }
    SmoothOrder: Byte;
    SpreadMesRectX: Byte; // X size of Rectangle for Ampl for Spatial Spread
    SpreadMesRectY: Byte; // Y size -- // ---
    SelFrame : TRect;
    SelFrameColor : TColor;
    MergeModel : Byte;
    OverlayThreshold : Word;
  end;

  TPartOfExportDial = Packed Record  //used to Read Some of the ExportDial Parameters Worth saving
    MovieKind         : Integer;
    UseCustomFrameRate: Boolean;  //now it is always true (only for MPEG-1 was False
    MovieKeepDuration : Boolean;  //it is not used any longer - it was needed for MPEG-1 movies
    SizeBarLenghtINµm : Byte;
  end;

  TImage3DVars = Packed Record
    Mode3D: Byte;
    Smooth3Dmode: Byte;
    BoxSm3DSize: Byte;
    MedSm3DSize: Byte;
    GaussSm3DSize: Byte;
    MedSm3DFirst: Boolean;
    Crop3DImage: Boolean;
    HideBackFace: Boolean;
    ViewAngle: Byte; // should be glDouble but it works with integer too
    XY_Axes_LT: Boolean; // XY axes at Left,Top position
    XY_Axes_RT: Boolean; // XY axes at Right,Top position
    XY_Axes_RB: Boolean; // XY axes at Right,Bottom position
    XY_Axes_LB: Boolean; // XY axes at Left,Bottom position
    Z_Axes_LT: Boolean; // XY axes at Left,Top position
    Z_Axes_RT: Boolean; // XY axes at Right,Top position
    Z_Axes_RB: Boolean; // XY axes at Right,Bottom position
    Z_Axes_LB: Boolean; // XY axes at Left,Bottom position
    XYthickness: Byte;
    Zthickness: Byte;
    ScaleZ: glFloat;
    ScaleXYZ: glFloat;
    Min3DRat: glFloat;
    glXYRed: Single;
    glXYGreen: Single;
    glXYBlue: Single;
    glBgRed: Single;
    glBgGreen: Single;
    glBgBlue: Single;
    xRotAngle: SmallInt; // SmallInt  -32768..32767 signed 16-bit
    yRotAngle: SmallInt;
    zRotAngle: SmallInt;
    Win3DXYsize: SmallInt;
  end;

Var
  SparkAnSingleVar: TSparkAnSingleVar;
  Image3DVars: TImage3DVars;
  PartOfExportDial: TPartOfExportDial;
  SearchRec : TSearchRec;
  ParFile   : File;
  ReadStr   : AnsiString;
  pReadStr  : Pointer;
  FPos      : UInt64;

Begin

  { --SparkAn.par File Was Found !!! -- }

  If (FindFirst(ParFileName, faAnyFile, SearchRec) = 0) then Begin
    AssignFile(ParFile, ParFileName);
    FileMode := fmOpenRead;
    Reset(ParFile, 1);
    FPos := 0;
    Seek(ParFile, FPos);
    SetLength(ReadStr, 10);
    pReadStr := @ReadStr[1]; { Sets Pointer at Fist character in String }
    BlockRead(ParFile, pReadStr^, 10);
    { Verifies Type of File }
    If (ReadStr <> 'SparkAnPar') then Begin
      DidGetSparkAnPar := False;
      CloseFile(ParFile);
      if (GiveMess = True) then
        MessageDlg('This is Not SparkAn Settings File', mtError, [mbOK], 0);
    End
      Else
    If (ReadStr = 'SparkAnPar') then Begin
      DidGetSparkAnPar := True;
      { Starts Reading }

      FPos := 10;

      Seek(ParFile, FPos);
      BlockRead(ParFile, BkgValues, SizeOf(BkgValues));

      FPos := FPos + SizeOf(BkgValues);
      Seek(ParFile, FPos);
      BlockRead(ParFile, Bkg2ndValues, SizeOf(Bkg2ndValues));

      FPos := FPos + SizeOf(Bkg2ndValues);
      Seek(ParFile, FPos);
      BlockRead(ParFile, HillEquationParams, SizeOf(HillEquationParams));

      FPos := FPos + SizeOf(HillEquationParams);
      Seek(ParFile, FPos);
      BlockRead(ParFile, MesLineVar, SizeOf(MesLineVar));

      FPos := FPos + SizeOf(MesLineVar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, ROIvar, SizeOf(ROIvar));

      FPos := FPos + SizeOf(ROIvar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, SparkAnSingleVar, SizeOf(SparkAnSingleVar));

      FPos := FPos + SizeOf(SparkAnSingleVar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, ColTableSetings, SizeOf(ColTableSetings));

      FPos := FPos + SizeOf(ColTableSetings);
      Seek(ParFile, FPos);
      BlockRead(ParFile, MarkPar, SizeOf(MarkPar));

      FPos := FPos + SizeOf(MarkPar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, AutoSearchPar, SizeOf(AutoSearchPar));

      FPos := FPos + SizeOf(AutoSearchPar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, TimPltSlid, SizeOf(TimPltSlid));

      FPos := FPos + SizeOf(TimPltSlid);
      Seek(ParFile, FPos);
      BlockRead(ParFile, PrevFilePar, SizeOf(PrevFilePar));

      FPos := FPos + SizeOf(PrevFilePar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, PixSettings, SizeOf(PixSettings));

      FPos := FPos + SizeOf(PixSettings);
      Seek(ParFile, FPos);
      BlockRead(ParFile, PartOfExportDial, SizeOf(PartOfExportDial));

      FPos := FPos + SizeOf(PartOfExportDial);
      Seek(ParFile, FPos);
      BlockRead(ParFile, ImageContrVar, SizeOf(ImageContrVar));
      // Values are Read in frmImConr.Create

      FPos := FPos + SizeOf(ImageContrVar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, MarkTablesPar, SizeOf(MarkTablesPar));

      FPos := FPos + SizeOf(MarkTablesPar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, Image3DVars, SizeOf(Image3DVars));

      FPos := FPos + SizeOf(Image3DVars);
      Seek(ParFile, FPos);
      BlockRead(ParFile, LSTimeBarPar, SizeOf(LSTimeBarPar));

      FPos := FPos + SizeOf(LSTimeBarPar);
      Seek(ParFile, FPos);
      BlockRead(ParFile, RAM_Usage, SizeOf(RAM_Usage));


      if (PrevFilePar.Fname_Length > 0) then
      Begin
        FPos := FPos + SizeOf(RAM_Usage);
        Seek(ParFile, FPos);
        SetLength(ReadStr, PrevFilePar.Fname_Length);
        pReadStr := @ReadStr[1]; // Sets Pointer at Fist character in String
        BlockRead(ParFile, pReadStr^, Length(ReadStr));
        PrevImFileName := ReadStr; // Full Path + FName
      end;


      // single (miscalenous) variable
      BoxSmSize := SparkAnSingleVar.BoxSmSize;
      MedSmSize := SparkAnSingleVar.MedSmSize;
      GaussSmSize := SparkAnSingleVar.GaussSmSize;
      MaxRatio := SparkAnSingleVar.MaxRatio / 100;
      Bkg := SparkAnSingleVar.Bkg;
      Bkg2nd := SparkAnSingleVar.Bkg2nd;
      CutOff := SparkAnSingleVar.CutOff;
      LinkTimeSerPlotAndImage := SparkAnSingleVar.LinkTimeSerPlotAndImage;
      LoadStreamPixAndND2TimeSt := SparkAnSingleVar.LoadStreamPixTimeSt;
      CheckAllFilesExist := SparkAnSingleVar.CheckAllFilesExist;
      ShowFullPath := SparkAnSingleVar.ShowFullPath;
      AllowFullPath := SparkAnSingleVar.AllowFullPath;
      AlignfrmPlayback := SparkAnSingleVar.AlignfrmPlayback;
      SmoothMode := SparkAnSingleVar.SmoothMode;
      SmoothOrder := SparkAnSingleVar.SmoothOrder;
      UseMoviFilePath := SparkAnSingleVar.UseMoviFilePath;
      SpreadMesRect.X := SparkAnSingleVar.SpreadMesRectX;
      SpreadMesRect.Y := SparkAnSingleVar.SpreadMesRectY;
      SelFrame     := SparkAnSingleVar.SelFrame;
      SelFrameColor := SparkAnSingleVar.SelFrameColor;
      MergeModel := SparkAnSingleVar.MergeModel;
      OverlayThreshold := SparkAnSingleVar.OverlayThreshold;
      // -- Image3DVars
      Mode3D := Image3DVars.Mode3D;
      Crop3DImage := Image3DVars.Crop3DImage;
      HideBackFace := Image3DVars.HideBackFace;
      ViewAngle := Image3DVars.ViewAngle;
      XY_Axes_LT := Image3DVars.XY_Axes_LT;
      XY_Axes_RT := Image3DVars.XY_Axes_RT;
      XY_Axes_RB := Image3DVars.XY_Axes_RB;
      XY_Axes_LB := Image3DVars.XY_Axes_LB;
      Z_Axes_LT := Image3DVars.Z_Axes_LT;
      Z_Axes_RT := Image3DVars.Z_Axes_RT;
      Z_Axes_RB := Image3DVars.Z_Axes_RB;
      Z_Axes_LB := Image3DVars.Z_Axes_LB;
      XYthickness := Image3DVars.XYthickness;
      Zthickness := Image3DVars.Zthickness;
      ScaleZ := Image3DVars.ScaleZ;
      ScaleXYZ := Image3DVars.ScaleXYZ;
      Min3DRat := Image3DVars.Min3DRat;
      glXYRed := Image3DVars.glXYRed;
      glXYGreen := Image3DVars.glXYGreen;
      glXYBlue := Image3DVars.glXYBlue;
      glBgRed := Image3DVars.glBgRed;
      glBgGreen := Image3DVars.glBgGreen;
      glBgBlue := Image3DVars.glBgBlue;
      xRotAngle := Image3DVars.xRotAngle;
      xRotAngle := Image3DVars.xRotAngle;
      yRotAngle := Image3DVars.yRotAngle;
      zRotAngle := Image3DVars.zRotAngle;
      Win3DXYsize := Image3DVars.Win3DXYsize;
      // --- ExportDialog ----//
      ExportDial.MovieKind := PartOfExportDial.MovieKind;
      ExportDial.UseCustomFrameRate := PartOfExportDial.UseCustomFrameRate;
      ExportDial.MovieKeepDuration := PartOfExportDial.MovieKeepDuration;
      ExportDial.SizeBarLenghtINµm := PartOfExportDial.SizeBarLenghtINµm;
      {because it has been used as a Boolean Spaceholder since the internal player was deleted
       and it was set to Zero by default the command below takes  care of it.  In this way the introduction
       of additional parameters to be written to SparkAn.par was avoided}
      if (ExportDial.SizeBarLenghtINµm = 0) then ExportDial.SizeBarLenghtINµm := 10;

      HillEquationParams.Span := HillEquationParams.MaxRatio - HillEquationParams.MinRatio;
      { ---------------------------------------------------------- }

    End; { If (ReadStr = 'SparkAnPar') }
    CloseFile(ParFile);
  End
  Else { If FindFirst(ParFileName, faAnyFile, SearchRec) = 0 }

  Begin
    DidGetSparkAnPar := False; { SparkAn.par File Not Found }
  End;

  FindClose(SearchRec);

End; { Procedure GetSparkAnPar }
{ ***************************************************************************** }

Procedure WriteSparkAnPar(const ParFileName: AnsiString);

Type

  TSparkAnSingleVar = Packed Record
    BoxSmSize : Integer;
    { Size X x Y (X=Y)of Boxcar Kernel for Boxcar smoothing }
    MedSmSize : Integer;
    { Size X x Y (X=Y)of Median Kernel for Median Smoothing }
    GaussSmSize: Integer;
    { Size X x Y (X=Y)of Gaussian Kernel for Gaussian Smoothing }
    MaxRatio : Integer;
    Bkg    : Word;
    Bkg2nd : Word;
    CutOff: Word;
    LinkTimeSerPlotAndImage: Word;
    LoadStreamPixAndND2TimeSt : Boolean;
    CheckAllFilesExist: Boolean;
    ShowFullPath: Boolean;
    AllowFullPath: Boolean;
    AlignfrmPlayback: Boolean;
    BoxcarOnZerPixAvIm: Boolean;
    UseMoviFilePath: Boolean;
    SetBkgToZero: Boolean;
    SmoothMode: Byte; { see constants }
    SmoothOrder: Byte; // for now: FIRST_BOXCAR = 0; FIRST_MEDIAN = 1;
    SpreadMesRectX: Byte; // X size of Rectangle for Ampl for Spatial Spread
    SpreadMesRectY: Byte; // Y size -- // ---
    SelFrame : TRect;
    SelFrameColor : TColor;
    MergeModel : Byte;
    OverlayThreshold : Word;

  end;

  // these are the Separate 3D Image Window and Controls variables
  TImage3DVars = Packed Record
    Mode3D: Byte;
    Smooth3Dmode: Byte;
    BoxSm3DSize: Byte;
    MedSm3DSize: Byte;
    GaussSm3DSize: Byte;
    MedSm3DFirst: Boolean;
    Crop3DImage: Boolean;
    HideBackFace: Boolean;
    ViewAngle: Byte; // should be glDouble but it works with integer too
    XY_Axes_LT: Boolean; // XY axes at Left,Top position
    XY_Axes_RT: Boolean; // XY axes at Right,Top position
    XY_Axes_RB: Boolean; // XY axes at Right,Bottom position
    XY_Axes_LB: Boolean; // XY axes at Left,Bottom position
    Z_Axes_LT: Boolean; // XY axes at Left,Top position
    Z_Axes_RT: Boolean; // XY axes at Right,Top position
    Z_Axes_RB: Boolean; // XY axes at Right,Bottom position
    Z_Axes_LB: Boolean; // XY axes at Left,Bottom position
    XYthickness: Byte;
    Zthickness: Byte;
    ScaleZ: glFloat;
    ScaleXYZ: glFloat;
    Min3DRat: glFloat;
    glXYRed: Single;
    glXYGreen: Single;
    glXYBlue: Single;
    glBgRed: Single;
    glBgGreen: Single;
    glBgBlue: Single;
    xRotAngle: SmallInt; // SmallInt  -32768..32767 signed 16-bit
    yRotAngle: SmallInt;
    zRotAngle: SmallInt;
    Win3DXYsize: SmallInt;
  end;

  TPartOfExportDial = Packed Record  //used to Write Some of the ExportDial Parameters Worth saving
    MovieKind           : Integer;
    UseCustomFrameRate  : Boolean;   //now it is always true (only for MPEG-1 was False
    MovieKeepDuration   : Boolean;  //it is not used any longer - it was needed for MPEG-1 movies
    SizeBarLenghtINµm   : Byte;
  end;

Var
  SparkAnSingleVar: TSparkAnSingleVar;
  Image3DVars: TImage3DVars;
  PartOfExportDial: TPartOfExportDial;
  SearchRec: TSearchRec;
  { Attributes: LongWord; Win 32 API way }
  ParFile: File;
  FPos: Longint;
  WriteStr: AnsiString;
  pWriteStr: Pointer;
  CanWrite: Boolean;

Begin
  CanWrite := False;
  If FileExists(ParFileName) = True then
  Begin
    If (FindFirst(ParFileName, faAnyFile, SearchRec) = 0) then
    begin { file exist }
      if SearchRec.Attr and faReadOnly > 0 then
      begin { this is a test if we have ReadOnly }
        WinApi.Windows.SetFileAttributes(PChar(ParFileName),
          SearchRec.Attr and not faReadOnly);
        { --- Another way is below:
          {Attributes := GetFileAttributes(PChar(ParFileName)); }
        { SetFileAttributes(PChar(ParFileName),Attributes and not FILE_ATTRIBUTE_READONLY); }
      end;
      CanWrite := True;
    End; { FindFirst .... }
    FindClose(SearchRec);
  End
  Else If (FileExists(ParFileName) = False) then
    CanWrite := True;

  If CanWrite = False Then
  Begin
    MessageDlg(
      'Cannot Save Program Settings, SparkAn.par is Read Only, Change File Attributes'
        , mtError, [mbOK], 0);
  End
    Else
  If CanWrite = True Then Begin
    { initialize SparkAnSingleVar and ImageContrVar and Image3DVars }
    // SparkAnSingleVar
    SparkAnSingleVar.BoxSmSize := BoxSmSize;
    SparkAnSingleVar.MedSmSize := MedSmSize;
    if (GaussSmSize = 3) then
    begin
      with frmImageControl do
      begin
        if (unGaussSmooth3x3L.Selected) then
          SparkAnSingleVar.GaussSmSize := 1;
        if (unGaussSmooth3x3M.Selected) then
          SparkAnSingleVar.GaussSmSize := 2;
        if (unGaussSmooth3x3H.Selected) then
          SparkAnSingleVar.GaussSmSize := 3;
      end;
    end
    else
      SparkAnSingleVar.GaussSmSize := GaussSmSize;

    SparkAnSingleVar.MaxRatio := frmImageControl.trbMaxRatio.Position;
    { MaxRatio := trbMaxRatio.Position/10 }

    SparkAnSingleVar.Bkg := Bkg;
    SparkAnSingleVar.Bkg2nd  := Bkg2nd;
    SparkAnSingleVar.CutOff := CutOff;
    SparkAnSingleVar.LinkTimeSerPlotAndImage := LinkTimeSerPlotAndImage;
    SparkAnSingleVar.LoadStreamPixAndND2TimeSt := LoadStreamPixAndND2TimeSt;
    SparkAnSingleVar.CheckAllFilesExist := CheckAllFilesExist;
    SparkAnSingleVar.ShowFullPath := ShowFullPath;
    SparkAnSingleVar.AllowFullPath := AllowFullPath;
    SparkAnSingleVar.AlignfrmPlayback := AlignfrmPlayback;
    SparkAnSingleVar.SmoothMode := SmoothMode;
    SparkAnSingleVar.SmoothOrder := SmoothOrder;
    SparkAnSingleVar.UseMoviFilePath := UseMoviFilePath;
    SparkAnSingleVar.SpreadMesRectX := SpreadMesRect.X;
    SparkAnSingleVar.SpreadMesRectY := SpreadMesRect.Y;
    SparkAnSingleVar.SelFrame := SelFrame;
    SparkAnSingleVar.SelFrameColor := SelFrameColor;
    SparkAnSingleVar.MergeModel := MergeModel;
    SparkAnSingleVar.OverlayThreshold := OverlayThreshold;
    { ---------------------------------------------------------------- }
    // ImageContrVar
    ImageContrVar.BackGrMax := frmImageControl.trbBackSubtr.Max;
    ImageContrVar.CutOffMax := frmImageControl.trbCutOff.Max;
    ImageContrVar.MaxGamma := ImageContrVar.MaxGamma; { Max Gamma }
    { ---------------------------------------------------------- }
    // Image3DVars
    Image3DVars.Mode3D := Mode3D;
    Image3DVars.Crop3DImage := Crop3DImage;
    Image3DVars.HideBackFace := HideBackFace;
    Image3DVars.ViewAngle := ViewAngle;
    Image3DVars.XY_Axes_LT := XY_Axes_LT;
    Image3DVars.XY_Axes_RT := XY_Axes_RT;
    Image3DVars.XY_Axes_RB := XY_Axes_RB;
    Image3DVars.XY_Axes_LB := XY_Axes_LB;
    Image3DVars.Z_Axes_LT := Z_Axes_LT;
    Image3DVars.Z_Axes_RT := Z_Axes_RT;
    Image3DVars.Z_Axes_RB := Z_Axes_RB;
    Image3DVars.Z_Axes_LB := Z_Axes_LB;
    Image3DVars.XYthickness := XYthickness;
    Image3DVars.Zthickness := Zthickness;
    Image3DVars.ScaleZ := ScaleZ;
    Image3DVars.ScaleXYZ := ScaleXYZ;
    Image3DVars.Min3DRat := Min3DRat;
    Image3DVars.glXYRed := glXYRed;
    Image3DVars.glXYGreen := glXYGreen;
    Image3DVars.glXYBlue := glXYBlue;
    Image3DVars.glBgRed := glBgRed;
    Image3DVars.glBgGreen := glBgGreen;
    Image3DVars.glBgBlue := glBgBlue;
    Image3DVars.xRotAngle := xRotAngle;
    Image3DVars.xRotAngle := xRotAngle;
    Image3DVars.yRotAngle := yRotAngle;
    Image3DVars.zRotAngle := zRotAngle;
    Image3DVars.Win3DXYsize := Win3DXYsize;
    // --- ExportDialog ----//
    PartOfExportDial.MovieKind := ExportDial.MovieKind;
    PartOfExportDial.UseCustomFrameRate := ExportDial.UseCustomFrameRate;
    PartOfExportDial.MovieKeepDuration := ExportDial.MovieKeepDuration;
    PartOfExportDial.SizeBarLenghtINµm := ExportDial.SizeBarLenghtINµm;
    { ---------------------------------------------------------- }

    AssignFile(ParFile, ParFileName);
    ReWrite(ParFile, 1);
    FPos := 0;
    Seek(ParFile, FPos);
    { 1st: write the Type of the File }
    WriteStr := 'SparkAnPar';
    pWriteStr := @WriteStr[1]; { Sets Pointer at Fist character in String }
    BlockWrite(ParFile, pWriteStr^, Length(WriteStr)); { Don't miss " ^ " }

    { some more initializing }
    If (Length(ImFname) > 0) then
    Begin { if = 0 String is Empty }
      PrevFilePar.Fname_Length   := Length(ImFname);
      PrevFilePar.FilterIndex    := ImTypeIndex;
      PrevFilePar.BigTiff := BigTiff;
      PrevFilePar.MultiImageTIFF := MultiImageTIFF;
      WriteStr := ImFname;
    End
    Else If (Length(ImFname) = 0) and (Length(PrevImFileName) > 0) then
    Begin
      PrevFilePar.Fname_Length := Length(PrevImFileName);
      WriteStr := PrevImFileName;
    End
    Else If (Length(ImFname) = 0) and (Length(PrevImFileName) = 0) then
    Begin
      PrevFilePar.Fname_Length := 0;
      PrevFilePar.FilterIndex := 1; {Tiff File; First Choise }
    End;

    { 2nd writes Parameters }
    FPos := 10;

    Seek(ParFile, FPos);
    BlockWrite(ParFile, BkgValues, SizeOf(BkgValues));

    FPos := FPos + SizeOf(BkgValues);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, Bkg2ndValues, SizeOf(Bkg2ndValues));

    FPos := FPos + SizeOf(Bkg2ndValues);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, HillEquationParams, SizeOf(HillEquationParams));

    FPos := FPos + SizeOf(HillEquationParams);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, MesLineVar, SizeOf(MesLineVar));

    FPos := FPos + SizeOf(MesLineVar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, ROIvar, SizeOf(ROIvar));

    FPos := FPos + SizeOf(ROIvar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, SparkAnSingleVar, SizeOf(SparkAnSingleVar));

    FPos := FPos + SizeOf(SparkAnSingleVar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, ColTableSetings, SizeOf(ColTableSetings));

    FPos := FPos + SizeOf(ColTableSetings);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, MarkPar, SizeOf(MarkPar));

    FPos := FPos + SizeOf(MarkPar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, AutoSearchPar, SizeOf(AutoSearchPar));

    FPos := FPos + SizeOf(AutoSearchPar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, TimPltSlid, SizeOf(TimPltSlid));

    FPos := FPos + SizeOf(TimPltSlid);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, PrevFilePar, SizeOf(PrevFilePar));

    FPos := FPos + SizeOf(PrevFilePar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, PixSettings, SizeOf(PixSettings));

    FPos := FPos + SizeOf(PixSettings);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, PartOfExportDial, SizeOf(PartOfExportDial));

    FPos := FPos + SizeOf(PartOfExportDial);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, ImageContrVar, SizeOf(ImageContrVar));

    FPos := FPos + SizeOf(ImageContrVar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, MarkTablesPar, SizeOf(MarkTablesPar));

    FPos := FPos + SizeOf(MarkTablesPar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, Image3DVars, SizeOf(Image3DVars));

    FPos := FPos + SizeOf(Image3DVars);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, LSTimeBarPar, SizeOf(LSTimeBarPar));

    FPos := FPos + SizeOf(LSTimeBarPar);
    Seek(ParFile, FPos);
    BlockWrite(ParFile, RAM_Usage, SizeOf(RAM_Usage));

    { Lastly:  records Last File Name and Full Path }
    if (PrevFilePar.Fname_Length > 0) then
    Begin { string is Full }
      FPos := FPos + SizeOf(RAM_Usage);
      Seek(ParFile, FPos);
      pWriteStr := @WriteStr[1]; { Sets Pointer at Fist character in String }
      BlockWrite(ParFile, pWriteStr^, Length(WriteStr)); { Don't miss " ^ " }
    end;
    { End with Variables That are PAR initialized }

    CloseFile(ParFile);
  End; { If CanWrite = True }

End;
{ Procedure WriteSparkAnPar }
{ ***************************************************************************** }
Procedure InitVarOnStart; { used ONLY in Program, when Program Stars }
var
  i: Integer;
  ParFileName: AnsiString;
  GiveMess: Boolean;
  TestStr: AnsiString;

Begin

  { 1st: Tries to Get Info from PAR file }

  ParFileName := SparkAnDir + 'SparkAn.par';
  GiveMess := False;
  ReadSparkAnPar(ParFileName, DidGetSparkAnPar, GiveMess);
  { -------------------------------------------------- }

  { 2nd:  Variables that are Always Internaly Initialized }

  Zm := 1;
  MainImLoaded := False;
  AllowWindowsUpdate := True; //introduced Apr 12, 2017 to prevent Updating main window when Real Line Scan Window is ON
  ImFileOpen := False;
  FileInRAM := False;
  JumpAv := 1;
  RunAv  := 1;
  NrFiles := 0; { Files in File List }
  strFileList := nil;
  FileTypeList := nil;
  TestStr := FloatToAnsiStr(2.2, 0, 1);
  DecSep := TestStr[2];
  PLOTvar.AllowFreezeMin := False; { Allows Freeze Min Button }
  { this BMP is Used all the time in the program and is freed when the program closes }
  memBMP := TBitmap.Create;
  IntBMP := TBitmap.Create;
  ImageFileType := SINGLE_IMAGE;
  RatioOn := False;
  imXsize := 256;
  imYsize := 192;
  BitCount := 8;
  AvImList := nil;
  ImSel := 0;
  AvImExists := 0;
  AvImChOrig := 1; //added march 3, 2017
  Zoom := 1; { No Zoom }
  SpTabEmpty := True;
  BigTabEmpty := True;
  PLOTvar.ImNrFromTable := -1;
  PLOTvar.BaseLineStatus := 0;
  PLOTvar.LastTraceMinPrts := 0;
  for i := 1 to 20 do
    ROIvar.ROIAdr[i] := 0; { Zeroes Out the Array=No Selections }
  ROIvar.NrROI := 0; { Number of Used (Printed) Boxes }
  ROIvar.TickLine := -1; { means no File is analysed yet }
  MesLine.OpCode := NOT_EXIST;

  { the formula to draw a rectangle with different thickness
    and keeping interior the same is:
    L := Xl -  canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
    R := Xr +  canvas.Pen.Width div 2 + 1 + 1;
    T := Yup - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
    B := Yd +  canvas.Pen.Width div 2 + 1 + 1; }

  { here the Pen.Width for the Selection Frame is Constantly = 3 }
  ROIrct.frLT := (3 div 2) + (3 mod 2);
  ROIrct.frRB := (3 div 2) + 1 + 1; { you need 1 pix left and 2 Right/Bottom }

  TimeSerAnalDone := False;
  PLOTvar.LastROIMesCur := 0;

  { 2D Gauusian Filters: sets the Gaussians coeficiens & Sum of them }
  Set2DGaussCoeff(GAUSS_5x5, SumOf2D5x5GaussCoeff, Gauss2D5x5Coeff);
  Set2DGaussCoeff(GAUSS_7x7, SumOf2D7x7GaussCoeff, Gauss2D7x7Coeff);

  with ExportDial do begin
   if Not(MovieKind in [WMV_VC1,AVI_UNC]) then
    UseCRF := True else
    UseCRF := False;
    ExportDial.CRF := 20;
    MotionFactor := 1.0;
  end;

  // --------- Integration Variables ------------//
  IntegrTableEmpty       := True;
  UseThres               := False;
  ConvertAreaToNPo       := True;
  IntThres               := 0.005;
  LastROI                := 0;
  ROIselected            := 0;
  SingleChannelAmplitude := 1.000;
  //----------------------------------------------//

  SmoothNonRatio := NO_SMOOTH_NON_RATIO; // = 0

  OrthogonalSectioningOn := False; //= frmOrthogonalSectioning is not On

  { initializes XYprofile Rectangle }
    XYprofileRect.Left   := 5;
    XYprofileRect.Top    := 19;

    XYprofileRect.Width  := 50;
    XYprofileRect.Height := 4;
    XYprofileRectColor   := RGB(255, 255, 255);
  { end of XYprofile Rectangle }

    with BottomColTableSettings do begin
      BottomState[0] := 0; // 0 = Nothing, 1 = Black, 2 = White
      BottomState[1] := 0;
      BottomState[2] := 0;
      BottomValue[0] := 0;
      BottomValue[1] := 0;
      BottomValue[2] := 0;
    end;

    WindowGrid.Color    := clWhite;
    WindowGrid.PenStyle := psSolid; //solid line
    WindowGrid.PenMode  := pmXor; // usually  pmCopy is used
    WindowGrid.NrNodes  := 4;
    WindowGrid.Visible  := False;

    MergeColors.BlueOn  := True;
    MergeColors.GreenOn := True;
    MergeColors.RedOn   := True;

    SpatialSpread_NrImagesToCalculate := 1;
    SpatialSpread_Baseline := 100;

    PeakThreshold := 0.200;  // in Small Events table introduced 9-5-2017

  { ------ END with Variables that are Always Internaly Initialized --- }

  { ************ if SparkAn.par does not exist then - internally initialyze *********** }

  If Not(DidGetSparkAnPar) Then Begin

    { Variables that are otherwise SparkAn.par initialized }

    AllowFullPath := False;
    UseMoviFilePath := True;
    ImTypeIndex := 1; { solamere Type }
    BoxSmSize   := 3; { Size X x Y of Boxcar Kernel }
    MedSmSize   := 3; { Size X x Y of Median Kernel }
    GaussSmSize := GAUSS_3x3_LITE; { Size X x Y of Gaussian Kernel }
    BoxcarOn := False; { True if Boxcar smoothing is On }
    MedianOn := False; { True if Median smoothing is On }
    GaussOn := False;
    SmoothMode := SMOOTH_GAUSS_MED;
    SmoothOrder := FIRST_BOX_OR_GAUSS;
    ShowFullPath := True;
    { trbMaxRatio.Position = MaxRatio*100 = 200 }
    MaxRatio := 2.0;
    { DispFact    := 255/2; done in frmImageControl.Create }
    { initial MaxRatio = 2.0 }
    Bkg    := 0;
    Bkg2nd := 0;
    CutOff := 0;

    MergeModel := MERGE;
    OverlayThreshold := 10;

    for i := 0 to 8 do BkgValues[i]    := 0;
    for i := 0 to 8 do Bkg2ndValues[i] := 0;

    { Color Table Setings }
    ColTableSetings.Contrast[0] := 255;
    ColTableSetings.Contrast[1] := 255;
    ColTableSetings.Contrast[2] := 255;
    ColTableSetings.Brightness[0] := 0;
    ColTableSetings.Brightness[1] := 0;
    ColTableSetings.Brightness[2] := 0;
    ColTableSetings.Gamma[0] := 10;
    ColTableSetings.Gamma[1] := 30;
    ColTableSetings.Gamma[2] := 10;
    ColTableSetings.ColTblIndex[0] := 0; //Gray Scale
    ColTableSetings.ColTblIndex[1] := 1; //topographic
    ColTableSetings.ColTblIndex[2] := 0; //Gray Scale
    ImageContrVar.MaxGamma := 50;

    { Time Series Plot Sliders and widgets }
    TimPltSlid.AreaMinPoints := 10;
    TimPltSlid.BaseLinePoints := 11;
    TimPltSlid.NrPassesIndex  := 4;
    TimPltSlid.SymbSize := 3;
    TimPltSlid.SymbFromTableCol := clRed;
    TimPltSlid.AlwaysUseSymb := True;
    TimPltSlid.LSD := 1.5;
    TimPltSlid.RSD := 1.5;
    TimPltSlid.GetEachPeakBase := False;
    TimPltSlid.EachPeakBasePt := 3;
    TimPltSlid.EachPeakBaseRg := 100; // ms   milliseconds
    TimPltSlid.SmTraceKind := BOXCART1D;
    TimPltSlid.SmTrBoxcarIndex := 0;
    TimPltSlid.SmTrGaussIndex := 0;
    TimPltSlid.SmTrGaussFcIndex := 0;
    TimPltSlid.FcGaussFlt := 5.00; //in Hz
    TimPltSlid.SmTrKalmanIndex := 0;
    TimPltSlid.MeasTraceDown := True;
    TimPltSlid.CursorOn := True;
    TimPltSlid.CurVal := 1.0 * ScaleRat; { Cursor Initial position }
    TimPltSlid.YbotRatOff := 0;
    TimPltSlid.YtopRatOff := 255;
    TimPltSlid.YtopRatOn := 20; { Starting Pos: Max F/F0 = 2.0 }
    TimPltSlid.YbotRatOn := 6; { Starting Pos: Min F/F0 = 0.6 }
    TimPltSlid.YmaxRatOn := 50; { Starting Max = 5.0 F/Fo }
    TimPltSlid.PeakThresh := 4; { 4/20 = 0.2 F/Fo Threshold }
    TimPltSlid.BaseLineOption := 0;

    ROIvar.MesBoxXsize := 30;
    ROIvar.MesBoxYsize := 30;
    ROIvar.MarkXsize := 10;
    ROIvar.MarkYsize := 10;
    ROIvar.BoxXsize := 10;
    ROIvar.BoxYsize := 10;
    ROIvar.CirXsize := 10;
    ROIvar.CirYsize := 10;

    { initializes Selection Frame }
    SelFrame.Left   := 5;
    SelFrame.Top    := 5;
    SelFrame.Right  := 128;
    SelFrame.Bottom := 128;
    SelFrameColor   := RGB(125, 255, 128); { Selection Frame }
    { end of Selection Frame }

    { MesLineVar }
    MesLineVar.Color := RGB(125, 255, 128); { measure Line }
    MesLineVar.LSROI := 5; // pixels
    MesLineVar.Thickness := 1; // pixels
    MesLineVar.CapsWitdh := 9; // pixels ± from the Line Center

    { ROIvar }
    With ROIvar Do Begin
      MonoCol := RGB(255, 0, 0);
      UseMonoCol := False;
      MonoFontCol := RGB(255, 255, 255);
      UseMonoFontCol := False;
      UseROINr := True;
      ROIonAverWin := True; { to Show Small Marks on Aver Window }
      TckNess := 1;
      Ticker := 3;
      FhTickness := 1;
      KeepOldROI := False;
    End; { with ROIvar }

    { MarkPar }
    with MarkPar do begin
      Size := 5;
      Thick := 2;
      SmallEventColor := RGB(255, 0, 0);
      BigEventColor := RGB(0, 255, 255);
      DisplaySmEvents := True;
      DisplayBigEvents := True;
      ShowSmEvOnAverWin := True;
      ShowBigEvOnAverWin := True;
      PromptForComment := True;
      GenAutoSearchComm := True;
      GenGenSetComm := True;
    end;

    with MarkTablesPar do begin
      GetSmEvBase := True;
      { to Get Baseline For Each Small Event - Controlled by CheckBox on Small table Form }
      GetBigEvBase := True;
      { to Get Baseline For Each Small Event - Controlled by CheckBox on Big table Form }
      SmEvTimeIndex := 0;
      BigEvTimeIndex := 0;
      NrPointsSmEvBase := 3;
      SmEvBaseSearchRange := 100;
      NrPointsBigEvBase := 10;
      BigEvBaseSearchRange := 1000;
    end;

    { AutoSearchPar }
    with AutoSearchPar do begin
      Thresh := 130;
      Thresh := 130;
      Tolerance := 80; { Percent of Pixels Above Thresh }
      MaxArea := 800; { Max Area to be consider as a Small Event (e.g.Spark) }
      NrImRunAver := 5; { Number of Images for Running Average }
      NrImForCreateAvIm := 50;
      { Nr of consecutive images used to create Average Image Manual or Automatic }
      SearchLms := 100;
      { Time (ms) to check to the Left from Spark peak in "Test Small Events" }
      SearchRms := 150;
      { Time (ms) to check to the Right from Spark peak in "Test Small Events" }
      UseRunAver := True; { Use Running Average }
      IgnoreBigEv := False; { uses the Spark part of Anal Only }
      TestSmallEv := True; { Test Small Events = Check Trace for Each Spark }
      { to use or not Current 2D Filt to generate Ampl and Duration and t1/2 }
      GetSmEvDur := True; { to Get Duration and t1/2 of Small Events }
      GetBigEvDur := True; { to Get Duration and t1/2 of Big Events }
      ScanBoxSize := 7; { Size of Scanning Box }
      ROISizeForSmEvTest := 7;
      UseCustomROIforSmEvTest := True;
      NrImGetMinLeft := 3;
      { Nr of Images to Find Minimum Value (baseline) Left of Peak when does Test Small Events }
      NrImGetMinRight := 3;
      { Nr of Images to Find Minimum Value Right of Peak when does Test Small Events }
      NrImToLeftOfEv := 1;
      { Nr of Images for Peak (above Treshold) to Qualify as Event (Spark) }
      NrImToRightOfEv := 1;
      { Nr of Images for Peak (above Treshold) to Qualify as Event (Spark) }
      AutoAverImage := False; // Creates Automatically Average Images Every so Images defined by AutoAverNrImInc
      AutoAverNrImInc := 10; // Number of Images Increment to Start Making Automatically New Average Image
      AutoAverImRange := 100; // Number of Image Range (From-To) to Maka Automatically New Average Image
      SmoothBeforeDoRatio := True; // To smooth Average Image for F/Fo
      StartAutoAverFirstIm := False; // Starts Auto Average Image th 1st Image Read
      SaveAutoAver := False;
      UpdateRatio := False; // To save non ratio File and Redo F/Fo when doing Small Events Test
      PLval := 50; { percent of Peak Value for NrImToLeftOfEv to Qualify }
      PRval := 50; { percent of Peak Value for NrImToRightOfEv to Qualify }
      SDuse := True;
      SDfold := 3;
    end; { with AutoSearchPar }

    SetBuildInROIcolors(ROIvar.ROICol, ROIvar.FontCol);
    { Sets Build In ROI Colors }


    // Pixel Settings
    { before March 6, 2007 the settings were:
      Stanford Camera 830 pix for 100 microns
      Hamamatsu 458 pix for 100 microns (replaced after by Hitachi)
      after march 6, 2007 the settings are:
      Stanford Ca-imaging camera 860 pixels /100 microns
      Hitachi Camera : 608 pixels / 100 microns

      Reasons: 1. the lens coonecting Nipkow Disc was changed
      2. Hitachi Camera replaced Hamamatsu

      }

    // (Andor)
    PixSettings.PixPer100Micr[ANDOR_MOV] := 375;
    // 512x512 binning 1x1 Objective 60x
    PixSettings.UseOptionPixSize[ANDOR_MOV] := False;

    // Single Generic Tiff Files
    PixSettings.PixPer100Micr[SINGLE_BW_TIFF] := 415;
    PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] := True;

    // Stack of Tiff Files
    PixSettings.PixPer100Micr[STACK_BW_TIFF] := 415;
    PixSettings.UseOptionPixSize[STACK_BW_TIFF] := True;

    // BioRad PIC files
    PixSettings.PixPer100Micr[BIORAD_PIC] := 494;
    PixSettings.UseOptionPixSize[BIORAD_PIC] := False;

    // Noran Prairie
    PixSettings.PixPer100Micr[NORAN_PRARIE_MOV] := 203; // for 256x256 pix
    PixSettings.UseOptionPixSize[NORAN_PRARIE_MOV] := True;

    // StreamPix
    PixSettings.PixPer100Micr[StreamPix_MOV] := 608;
    // Hitachi Camera (prevoously Hamamatsu)
    PixSettings.UseOptionPixSize[StreamPix_MOV] := True;

    // Nikon Multiimage Tiff
    // 512x512 binning 1x1 Objective 60x
    PixSettings.PixPer100Micr[NIKON_ND2_MOV] := 375;
    PixSettings.UseOptionPixSize[NIKON_ND2_MOV] := False;

    // Zeiss LSM files
    PixSettings.PixPer100Micr[ZEISS_CZI_LSM_MOV] := 375;
    PixSettings.UseOptionPixSize[ZEISS_CZI_LSM_MOV] := False;

    { Noran SGI does not need Setting: Everything is recoded in File
    {QED Tiffs were removed from Options dialog in Auf 2015.  Last existance in v. 4.27.0.0 from May 4, 2015

    { Frames per second for Stack and Single Tiff files }
    PixSettings.FramesPerSec[0] := 30; // Stack   = 30.0000 frames /sec
    PixSettings.FramesPerSec[1] := 30; // Single  = 30.0000 frames /sec

    // Sets Values (X & Y) for rectangle to Measure Amplitude for Spatial Spread
    SpreadMesRect.x := 3;
    SpreadMesRect.y := 3;

    // -------------- 3D Image ------------

    // smoothing of 3d image for Non-ratioo Images Only
    Mode3D := glModeOrthogonal;
    Crop3DImage := True;
    HideBackFace := False;
    // rotation and viewing (Perspective Mode Only)
    xRotAngle := -35; // should be glFloat but it works with integer too
    yRotAngle := 0;
    zRotAngle := 10;
    ViewAngle := 90; // should be glDouble but it works with integer too
    // Scaling
    ScaleZ := 0.8; // 80%
    ScaleXYZ := 0.65; // 65%
    Min3DRat := 0.0;
    // ------- Axes ------------
    // XY axes position & On or Off
    XY_Axes_LT := True; // XY axes at Left,Top position
    XY_Axes_RT := True; // XY axes at Right,Top position
    XY_Axes_RB := True; // XY axes at Right,Bottom position
    XY_Axes_LB := True; // XY axes at Left,Bottom position
    // Z axes
    Z_Axes_LT := True; // XY axes at Left,Top position
    Z_Axes_RT := True; // XY axes at Right,Top position
    Z_Axes_RB := True; // XY axes at Right,Bottom position
    Z_Axes_LB := True; // XY axes at Left,Bottom position
    // X,Y axes color
    glXYRed := 1;
    glXYGreen := 1;
    glXYBlue := 1;
    // Axes Thickness
    XYthickness := 1;
    Zthickness := 5;
    // Background Color
    glBgRed := 0;
    glBgGreen := 0;
    glBgBlue := 0;
    Win3DXYsize := 256;

    // ---  end of 3D image variables

    { -   Time Bar of the Line Scan Image ----}
    LSTimeBarPar.Xright    := 10;
    LSTimeBarPar.Ybottom   := 10;
    LSTimeBarPar.Color     := clWhite;
    LSTimeBarPar.Thickness := 5;
    LSTimeBarPar.Color     := clWhite;
    LSTimeBarPar.Duration  := 1; // second
    LSTimeBarPar.Visible   := True;
    // end of Time bar

    { Export Dialog - some of the Parameterrs }
    with ExportDial do begin
      MovieKind          := MP4_x264;
      UseCustomFrameRate := True;
      MovieKeepDuration  := False;
      SizeBarLenghtINµm  := 10; //microns
      MotionFactor       := 1.0;
      UseCRF             := True;
    end;

    LinkTimeSerPlotAndImage := NO_LINK;

    //RAM Management
    RAM_Usage.LoadFilesInRAM   := True;

  End;
  { *************** End If DidGetSparkAnPar = False ********************** }

  { *** Again some Variables That are Always Internally Initialized But **** }
  { --------------------- Must Come LAST ---- }
  { the formula to draw a rectangle with different thickness
    and keeping interior the same is:
    L := Xl - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
    R := Xr + canvas.Pen.Width div 2 + 1 + 1;
    T := Yup - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
    B := Yd + canvas.Pen.Width div 2 + 1 + 1; }
  { for regularly drawn ROI boxes }
  ROIrct.LT := (ROIvar.TckNess div 2) + (ROIvar.TckNess mod 2);
  ROIrct.RB := (ROIvar.TckNess div 2) + 1 + 1;
  { for Underlined ROI boxes [thicker] }
  ROIrct.tLT := (ROIvar.Ticker div 2) + (ROIvar.Ticker mod 2);
  ROIrct.tRB := (ROIvar.Ticker div 2) + 1 + 1;
  ROIrct.Rc := 1 - ROIrct.Xsize mod 2;
  ROIrct.Bc := 1 - ROIrct.Ysize mod 2;

  if (MesLineVar.Thickness = 1) then
    MesLine.SelTol := 3
  else
    MesLine.SelTol := MesLineVar.Thickness + 1;


  {----------- Size Bar on 2D windows ------------------}
  SizeBar.YB := 500; // 12 pixels above the bottom of 512 pix image image
  SizeBar.YT := SizeBar.YB - LSTimeBarPar.Thickness;
  SizeBar.XR := 500; //12 pixel left from right side of 512 pix image
  SizeBar.XL := SizeBar.XR - round(ExportDial.SizeBarLenghtINµm/0.25); //0.26 = rounded value of the most prevalent Pixel Size in µm

  // Finally Loads Custom Cursors
  Screen.Cursors[crAim]        := LoadCursor(hInstance, 'AIM');
  Screen.Cursors[crBlackArrow] := LoadCursor(hInstance, 'BLACKARROW');
  Screen.Cursors[crCircle]     := LoadCursor(hInstance, 'CIRCLE');
  Screen.Cursors[crHSplitter]  := LoadCursor(hInstance, 'HSPLITTER');
  Screen.Cursors[crResizeAll]  := LoadCursor(hInstance, 'RESIZEALL');
  Screen.Cursors[crVSplitter]  := LoadCursor(hInstance, 'VSPLITTER');

  LoadChAsIndivFiles := False;
  cbLoadChAsIndivFilesState := False;

End; { Procedure InitVarOnStart; }

{ **************************************************************************** }
Procedure SetBuildInROIcolors(var ROIclr: TROIColArr; var FntClr: TFontColArr);
Var
  i: Integer;
Begin
  ROIclr[1] := RGB(255, 0, 0); { Red }
  ROIclr[2] := RGB(0, 0, 255); { Blue }
  ROIclr[3] := RGB(0, 255, 0); { Green }
  ROIclr[4] := RGB(255, 255, 0); { Yellow }
  ROIclr[5] := RGB(255, 0, 255); { Magenta }
  ROIclr[6] := RGB(0, 255, 255); { Cyan }
  ROIclr[7] := RGB(255, 128, 0); { Orange }
  ROIclr[8] := RGB(128, 0, 0); { Dark Red }
  ROIclr[9] := RGB(64, 128, 128); { Dark Cyan }
  ROIclr[10] := RGB(128, 128, 0); { Olive }
  ROIclr[11] := RGB(255, 128, 128); { Peach }
  ROIclr[12] := RGB(255, 128, 255); { Lavender }
  ROIclr[13] := RGB(200, 200, 0); { Dark Yellow }
  ROIclr[14] := RGB(0, 0, 160); { Dark Blue }
  ROIclr[15] := RGB(128, 0, 128); { Dark Magenta }
  ROIclr[16] := RGB(0, 128, 0); { Dark Green }
  ROIclr[17] := RGB(128, 64, 64); { Brown }
  ROIclr[18] := RGB(0, 128, 192); { Ocean Blue }
  ROIclr[19] := RGB(255, 217, 183); { Tan }
  ROIclr[20] := RGB(255, 255, 255); { White }

  For i := 1 to 20 do
  begin
    if i in [3, 4, 6, 13, 19, 20] then
      FntClr[i] := clBlack
    else
      FntClr[i] := clWhite;
  End; { For i := 1 to 20 }

End;

{ **************************************************************************** }
Procedure FreeMemBMPused; { Frees memory if BitmapHeader was Initialized }
var i : integer;
begin
  for i := 0 to 2 do FreeMem(lpBitmapInfo[i], SizeOf(BITMAPINFO) + 256*(sizeof(TRGBQUAD)));
  FreeMem(pMergeBMPInfo, SizeOf(BITMAPINFO));
End;

{ **************************************************************************** }
Procedure InitBitmapHeaderXY(Const ImageWidth, ImageHeight: Integer);
Begin
  with lpBitmapInfo[CurrClrTablInd]^.bmiHeader do begin
    biWidth  := ImageWidth; { Bitmap.Width in pixels }
    biHeight := -ImageHeight;
  End; { with header.bmiHeader }
End; { Procedure InitBitmapHeader; }
{ **************************************************************************** }
procedure LoadClrTableFileInRAM;
var
  i,n,BitmapInfoSize: Integer;
  tblFname: AnsiString;
  tblFile : File;
  FSize   : LongInt;
  FHandle : THandle;
begin

  tblFname := SparkAnDir + 'ClrTbl.bin';
  If FileExists(tblFname) then Begin
    FHandle := FileOpen(tblFname, fmOpenRead);
    FSize := GetFileSize(FHandle, nil);
    SetLength(ClrTblArray,FSize);
    FileSeek(FHandle, 0, 0);
    FileRead(FHandle,ClrTblArray[0],FSize);
    FileClose(FHandle);

  End Else
  Begin
    MessageDlg('Color Table File "ClrTbl.bin" Not Found' +
        ' It will Use GrayScale Only', mtWarning, [mbOK], 0);
    for n := 0 to 2 do begin
      for i := 0 to 255 do begin
        OrigTBLBlue[n,i]  := i;
        OrigTBLGreen[n,i] := i;
        OrigTBLRed[n,i]   := i;
      end;
    end; { For  i := 0 to 255 }
  End;

  //Prepare memory for the BitmapInfoHeader
  for n := 0 to 2 do begin
    lpBitmapInfo[n] := AllocMem(SizeOf(BITMAPINFO) + 256*(sizeof(TRGBQUAD)));
  end;

  // initiate Bitmap Info Header
  for n := 0 to 2 do begin
    with lpBitmapInfo[n]^.bmiHeader do begin
      biSize          := SizeOf(TBitmapInfoHeader); // lenfgt of string; PStr //
      biWidth         := 0; // Bitmap.Width in pixels //
      biHeight        := 0; // integer; Bitmap.Height; //
      biPlanes        := 1; // do not change //
      biBitCount      := 8; // word; 8 for 8 bit, 16 for 16, etc. //
      biCompression   := BI_RGB;
      biSizeimage     := 0;
      biXPelsPerMeter := 0;
      biYPelsPerMeter := 0;
      biClrUsed       := 0;
      biClrImportant  := 0;
    End; // with header.bmiHeader
  {biWidth and biHeight will be set later by InitBitmapHeaderXY}
  end;

  // initiate Bitmap Info Header for the MergeImage
  pMergeBMPInfo := AllocMem(SizeOf(BITMAPINFO));
  with pMergeBMPInfo.bmiHeader do begin
      biSize          := SizeOf(TBitmapInfoHeader); // lenfgt of string; PStr //
      biWidth         := 0; // Bitmap.Width in pixels //
      biHeight        := 0; // integer; Bitmap.Height; //
      biPlanes        := 1; // do not change //
      biBitCount      := 32; // word; 8 for 8 bit, 16 for 16, etc. //
      biCompression   := BI_RGB;
      biSizeimage     := 0;
      biXPelsPerMeter := 0;
      biYPelsPerMeter := 0;
      biClrUsed       := 0;
      biClrImportant  := 0;
  End; // with header.bmiHeader

End;  //procedure LoadClrTableFileInRAM;

{ **************************************************************************** }
Procedure LoadColTable(const CtSetNr: Integer);
{ Load s & initializes color table }
Var
  ClrTblFPos: Longint;
Begin

  If (FileExists(SparkAnDir + 'ClrTbl.bin')) then Begin
    ClrTblFPos := ColTableSetings.ColTblIndex[CtSetNr] * 768;
    Move(ClrTblArray[ClrTblFPos],OrigTBLBlue[CtSetNr,0], 256);
    Inc(ClrTblFPos, 256);
    Move(ClrTblArray[ClrTblFPos],OrigTBLGreen[CtSetNr,0], 256);
    Inc(ClrTblFPos, 256);
    Move(ClrTblArray[ClrTblFPos],OrigTBLRed[CtSetNr,0], 256);
  End;
End; { Procedure InitColTable; }

{ **************************************************************************** }

procedure LoadOwnFileTables;
//implemented sept 2016
Var
  ClrTblFPos,TblIndex: Longint;
Begin

    //if (ChannelOrder = ASCENDING) then TblIndex := 0 else TblIndex := 2;

    TblIndex := 0;

    ClrTblFPos := 0;
    Move(FileColorTBL_Ch1[ClrTblFPos],OrigTBLRed[TblIndex,0], 256);
    Inc(ClrTblFPos, 256);
    Move(FileColorTBL_Ch1[ClrTblFPos],OrigTBLGreen[TblIndex,0], 256);
    Inc(ClrTblFPos, 256);
    Move(FileColorTBL_Ch1[ClrTblFPos],OrigTBLBlue[TblIndex,0], 256);

   if (NrChannels = 2) and (FileColorTBL_Ch2 <> nil) then begin
    TblIndex := 2;
    ClrTblFPos := 0;
    Move(FileColorTBL_Ch2[ClrTblFPos],OrigTBLRed[TblIndex,0], 256);
    Inc(ClrTblFPos, 256);
    Move(FileColorTBL_Ch2[ClrTblFPos],OrigTBLGreen[TblIndex,0], 256);
    Inc(ClrTblFPos, 256);
    Move(FileColorTBL_Ch2[ClrTblFPos],OrigTBLBlue[TblIndex,0], 256);
   end;

End;

{******************************************************************************}

procedure NegateColorTables;
var i : Integer;
begin
  For i := 255 downto 0 Do Begin
    OrigTBLBlue [0,i] := 255 - OrigTBLBlue [0,i];
    OrigTBLGreen[0,i] := 255 - OrigTBLGreen[0,i];
    OrigTBLRed  [0,i] := 255 - OrigTBLRed  [0,i];
  End;

  For i := 255 downto 0 Do Begin
    OrigTBLBlue [1,i] := 255 - OrigTBLBlue [1,i];
    OrigTBLGreen[1,i] := 255 - OrigTBLGreen[1,i];
    OrigTBLRed  [1,i] := 255 - OrigTBLRed  [1,i];
  End;

  if (NrChannels = 2) then  begin
    For i := 255 downto 0 Do Begin
    OrigTBLBlue [2,i] := 255 - OrigTBLBlue [2,i];
    OrigTBLGreen[2,i] := 255 - OrigTBLGreen[2,i];
    OrigTBLRed  [2,i] := 255 - OrigTBLRed  [2,i];
  End;
  end;


End;

Procedure ModifyColTable(const CtSetNr: Integer);
Var
  i, Cnt, ValInt: Integer;
  Slope, Inter, SlDiv256, IntDiv256, Bot, Top, ValFlt, Gamma: Double;

Begin

  Bot := ColTableSetings.Brightness[CtSetNr];
  Top := ColTableSetings.Contrast[CtSetNr];
  { Slope     := 255/255 = 1 with slider = 255 } ;
  Slope := 255 / Top; { Calculates Actual Slope always assumes Intecept = 0 }
  Inter := Slope * Bot; { Calculates Intercept }
  Cnt := 0;
  { Prepares Position Array }
  If (ColTableSetings.Gamma[CtSetNr] = 10 { Gamma = 1.0 } ) then
  Begin
    For i := 0 to 255 Do Begin
      ValInt := round(i * Slope - Inter);
      if (ValInt >= 255) then ValInt := 255
        else
      if (ValInt <= 0)   then ValInt := 0;
      { Changes (Shifts Values in Col Table }
      lpBitmapInfo[CtSetNr]^.bmiColors[i].rgbBlue  := OrigTBLBlue[CtSetNr,ValInt];
      lpBitmapInfo[CtSetNr]^.bmiColors[i].rgbGreen := OrigTBLGreen[CtSetNr,ValInt];
      lpBitmapInfo[CtSetNr]^.bmiColors[i].rgbRed   := OrigTBLRed[CtSetNr,ValInt];
      if (Odd(i) = True) then begin
        PixValDat[Cnt].y := 63 - (ValInt div 4);
        Inc(Cnt);
      end;
    End; // For i := 0 to 255 Do Begin
  End
  { (Gamma = 1.0) }
  Else If (ColTableSetings.Gamma[CtSetNr] <> 10) then  { Gamma <> 1.0 }
  Begin
    Gamma := ColTableSetings.Gamma[CtSetNr] / 10;
    SlDiv256 := Slope / 256;
    IntDiv256 := Inter / 256;
    For i := 0 to 255 Do Begin
      ValFlt := i * SlDiv256 - IntDiv256;
      if ValFlt > 0 then
        ValFlt := (exp(Gamma * ln(ValFlt))) * 256
      else
        ValInt := 0;
      { Base^Power := exp(Power * ln(Base)); } { e.g. 8^3 = 512 }
      { Gamma Func is: Y = X^Gamma; X range is [0..1]; to conver to real units do
        {e.g. Y = ((255/255)^Gamma)*255 }
      if (ValFlt < 255) and (ValFlt > -0.5) then ValInt := round(ValFlt)
      else if (ValFlt > 255)  then ValInt := 255
      else if (ValFlt < -0.5) then ValInt := 0;
      lpBitmapInfo[CtSetNr]^.bmiColors[i].rgbBlue  := OrigTBLBlue[CtSetNr,ValInt];
      lpBitmapInfo[CtSetNr]^.bmiColors[i].rgbGreen := OrigTBLGreen[CtSetNr,ValInt];
      lpBitmapInfo[CtSetNr]^.bmiColors[i].rgbRed   := OrigTBLRed[CtSetNr,ValInt];
      if i mod 2 <> 0 Then
      Begin
        PixValDat[Cnt].y := 63 - (ValInt div 4);
        Inc(Cnt);
      end;
      { end; }{ ValFlt > 0 }
    End; { For i := 0 to 255 Do begin }
  End; { (Gamma <> 1.0) }

  if (frmImageControl.WhiteBottom.Down = True) then begin
    i := frmImageControl.trbBottomRegionOfColorTable.Position;
    for Cnt := 0 to i do
    begin
      lpBitmapInfo[CtSetNr]^.bmiColors[Cnt].rgbBlue  := 255;
      lpBitmapInfo[CtSetNr]^.bmiColors[Cnt].rgbGreen := 255;
      lpBitmapInfo[CtSetNr]^.bmiColors[Cnt].rgbRed   := 255;
    end;
  end
    else
  if (frmImageControl.BlackBottom.Down = True) then begin
    i := frmImageControl.trbBottomRegionOfColorTable.Position;
    for Cnt := 0 to i do
    begin
      lpBitmapInfo[CtSetNr]^.bmiColors[Cnt].rgbBlue  := 0;
      lpBitmapInfo[CtSetNr]^.bmiColors[Cnt].rgbGreen := 0;
      lpBitmapInfo[CtSetNr]^.bmiColors[Cnt].rgbRed   := 0;
    end;
  end;
End; { Procedure ModifyColTable; }

{*****************************************************************************}

Procedure DisableFileColorTable;
var
  Sender: TObject;
begin
   with frmImageControl do begin
    FileOwnColorTableWasDown := frmImageControl.ubFileColTable.Selected; // memorize
    ubFileColTable.Tag := 0;
    ubFileColTable.Selected := False;
    ubFileColTable.Enabled  := False;
   end;

End; // RemoveFileColorTable

{ *************************************************************************** }


Procedure CreateImageInputOutputCurve; inline;
//Creates Input/Output Curve on Image Control&Tools window - reflects how the Image is processes by Contrast, Shift,Gamma
//this is extract of lines in Procedure ModifyColTable
var
    ChNr, i, ValInt, Cnt : integer;
    Slope, Bot, Top, Inter : Double;
Begin

  Bot := ColTableSetings.Brightness[CurrClrTablInd];
  Top := ColTableSetings.Contrast[CurrClrTablInd];
  { Slope     := 255/255 = 1 with slider = 255 } ;
  Slope := 255 / Top; { Calculates Actual Slope always assumes Intecept = 0 }
  Inter := Slope * Bot; { Calculates Intercept }
  Cnt := 0;
  For i := 0 to 255 Do Begin
    ValInt := round(i * Slope - Inter);
    if (ValInt >= 255) then ValInt := 255
      else
    if (ValInt <= 0)   then ValInt := 0;
    if (Odd(i) = True) then begin
      PixValDat[Cnt].y := 63 - (ValInt div 4); //array that contains the curve
      Inc(Cnt);
    end;
  End; // For i := 0 to 255 Do Begin

End; //Procedure ConstructImageInputOutputCurve;

{ **************************************************************************** }

Procedure DoChannelRatio(Const CopyToDisplay: Byte);
var
  Cnt, j, imLen: Integer;

  procedure RatioDo(Const Ch1Data,Ch2Data : TDynByteArray; var RatioArr : TDynDoubleArray); overload; inline;
  var Cnt: Integer;
  Begin

    For Cnt := 0 to High(ImDataRat) do Begin
      if (Ch2Data[Cnt] > Bkg2nd) then begin
        RatioArr[Cnt] := ((Ch1Data[Cnt] - Bkg) / (Ch2Data[Cnt] - Bkg2nd)) * DispFact; //26 sec  vs 34 sec if * DispFact is done separately
        if RatioArr[Cnt] < 0 then RatioArr[Cnt] := 0;
      end
      else
        RatioArr[Cnt] := 0;

  End;

  End; //procedure RatioDo, Byte Arrays

  procedure RatioDo(Const Ch1Data,Ch2Data : TDynWordArray; var RatioArr : TDynDoubleArray);  overload; inline;
  var Cnt: Integer;
  Begin


    For Cnt := 0 to High(ImDataRat) do Begin
      if (Ch2Data[Cnt] > Bkg2nd) then begin
        RatioArr[Cnt] := ((Ch1Data[Cnt] - Bkg) / (Ch2Data[Cnt] - Bkg2nd )) * DispFact; //26 sec  vs 34 sec if done separately
        if RatioArr[Cnt] < 0 then RatioArr[Cnt] := 0;
      end
      else
        RatioArr[Cnt] := 0;
    End;

 End; //procedure RatioDo, Word Arrays

  {---------------------------------------------------------------------}
BEGIN
  { DispFact := 255/MaxRatio; Global; Defined in unImageControl Unit }

   If (SmoothMode > NO_SMOOTH) then Begin
    if (SmoothMode in[SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
      if (BitCount = 16) then
      RatioDo(Im16bitData,Im2nd16bit,ImDataRat)
    else
      RatioDo(Im8bitData,Im2nd8bit,ImDataRat);
    end
      else
    if (SmoothMode in[SMOOTH_BOX,SMOOTH_MED,SMOOTH_GAUSS]) then begin
      if (BitCount = 16) then
      RatioDo(Im16bitData,Im2nd16bit,ImDataRatForSmooth)
    else
      RatioDo(Im8bitData,Im2nd8bit,ImDataRatForSmooth);
    end;
   End

    Else

  If (SmoothMode = NO_SMOOTH) then Begin
    if (BitCount = 16) then
      RatioDo(Im16bitData,Im2nd16bit,ImDataRat)
    else
      RatioDo(Im8bitData,Im2nd8bit,ImDataRat);
  End;

  { ------------------------------------------------------------------ }
   { apply any Smoothing on Ratio Only After it is Done }
  if (SmoothMode > NO_SMOOTH) then SmoothRatioImage(ImDataRatForSmooth,ImDataRat);

  { Finally Copy to Image Display Buffer }
  If (CopyToDisplay = DO_COPY) then
  Begin
    If (BMPPadding = 0) then
      For Cnt := 0 to High(ImDataRat) do Begin
        if ImDataRat[Cnt] < 255 then
          ImDispl[Cnt] := round(ImDataRat[Cnt])
        else
          ImDispl[Cnt] := 255;
      End
        Else
    If (BMPPadding <> 0) then Begin
        Cnt := 0;
        j := 0;
        imLen := imXsize - 1;
        While Cnt < High(ImDataRat) do
        begin
          if ImDataRat[Cnt] < 255 then
            ImDispl[j] := round(ImDataRat[Cnt])
          else
            ImDispl[j] := 255;
          if Cnt Mod imXsize <> imLen then
            Inc(j, 1)
          else
            Inc(j, BMPPadding);
          Inc(Cnt);
        End; { while }
      End; { If BMPPadding <> 0 }
  End; // If (CopyToDisplay = DO_COPY)
  { Note:  the Time is the Same if 1st DispFact multiplies or after division }

End;   // Procedure DoChannelRatio;

{ ****************** ******************************************************** }

Procedure DoRatio(Const CopyToDisplay: Byte);
var
  Cnt, j, imLen: Integer;

  procedure RatioDo(Const DataArr: TDynByteArray; var RatioArr : TDynDoubleArray); overload; inline;
  var Cnt: Integer;
  Begin
    For Cnt := 0 to High(ImDataRat) do Begin
      If (AvIm[Cnt] > 0) Then Begin
        RatioArr[Cnt] := ((DataArr[Cnt] - Bkg) / AvIm[Cnt]) * DispFact;
        if RatioArr[Cnt] < 0 then RatioArr[Cnt] := 0;
      End
      else
        RatioArr[Cnt] := 0;
    End;
  End;

  procedure RatioDo(Const DataArr: TDynWordArray; var RatioArr : TDynDoubleArray);  overload; inline;
  var Cnt: Integer;
  Begin
    For Cnt := 0 to High(ImDataRat) do Begin
      If (AvIm[Cnt] > 0) Then Begin
        RatioArr[Cnt] := ((DataArr[Cnt] - Bkg) / AvIm[Cnt]) * DispFact;
        if RatioArr[Cnt] < 0 then RatioArr[Cnt] := 0;
      End
      else
        RatioArr[Cnt] := 0;
    End;
  End;

  {---------------------------------------------------------------------}
BEGIN
  { DispFact := 255/MaxRatio; Global; Defined in unImageControl Unit }

  If (frmImageControl.cbSmoothBeforeDoRatio.Checked) and (SmoothMode > NO_SMOOTH) then Begin
      RatioDo(Im16bitDataSM_Last,ImDataRat);
  End

    Else

  If (SmoothMode = NO_SMOOTH) then Begin
    if (BitCount = 16) then
      RatioDo(Im16bitData,ImDataRat)
    else
      RatioDo(Im8bitData,ImDataRat);
  End;
      // ImDataRat[Cnt] := 0;
  { ------------------------------------------------------------------ }
   If Not(frmImageControl.cbSmoothBeforeDoRatio.Checked) And (SmoothMode > NO_SMOOTH) then Begin

     { apply any Smoothing on Ratio Only After it is Done }
      If (SmoothMode in[SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) Then Begin
        if (BitCount = 16) then
        RatioDo(Im16bitData,ImDataRat)
          else
        RatioDo(Im8bitData,ImDataRat);

        SmoothRatioImage(ImDataRatForSmooth,ImDataRat);
      End
        Else
      If (SmoothMode in[SMOOTH_BOX,SMOOTH_MED,SMOOTH_GAUSS]) then Begin
        if (BitCount = 16) then
        RatioDo(Im16bitData,ImDataRatForSmooth)
          else
        RatioDo(Im8bitData,ImDataRatForSmooth);

        SmoothRatioImage(ImDataRatForSmooth,ImDataRat);
      End;
   End;

  { -------------------------------------------------------------------}

  { Finally Copy to Image Display Buffer }
  If (CopyToDisplay = DO_COPY) then
  Begin
    If (BMPPadding = 0) then
      For Cnt := 0 to High(ImDataRat) do Begin
        if ImDataRat[Cnt] < 255 then
          ImDispl[Cnt] := round(ImDataRat[Cnt])
        else
          ImDispl[Cnt] := 255;
      End
        Else
    If (BMPPadding <> 0) then Begin
        Cnt := 0;
        j := 0;
        imLen := imXsize - 1;
        While Cnt < High(ImDataRat) do Begin
          if ImDataRat[Cnt] < 255 then
            ImDispl[j] := round(ImDataRat[Cnt])
          else
            ImDispl[j] := 255;
          if Cnt Mod imXsize <> imLen then
            Inc(j, 1)
          else
            Inc(j, BMPPadding);
          Inc(Cnt);
        End; { while }
      End; { If BMPPadding <> 0 }
  End; // If (CopyToDisplay = DO_COPY)
  { Note:  the Time is the Same if 1st DispFact multiplies or after division }
End;
{ Procedure DoRatio; }

{ ********************************************************************** }

Procedure ReplaceCh1InND2File(Const ByteArr  : TDynByteArray; Const WordAarr : TDynWordArray);
var CntPix : NativeInt;
Begin
 If (BitCount = 16) then begin
  if (ChannelOrder = ASCENDING) then begin
    for CntPix := 0 to High(WordAarr) do begin
      TwoChWordArr[CntPix shl 1] := WordAarr[CntPix];
    end
  end
    else
  if (ChannelOrder = DESCENDING) then begin
    for CntPix := 0 to High(WordAarr) do begin
       TwoChWordArr[(CntPix shl 1) + 1] := WordAarr [CntPix];
    end;
  end;
 End  //If (BitCount = 16)
  Else
 If (BitCount = 8) then begin
  if (ChannelOrder = ASCENDING) then begin
    for CntPix := 0 to High(ByteArr) do begin
      TwoChByteArr[CntPix shl 1] := ByteArr[CntPix];
    end;
  end
    else
  if (ChannelOrder = DESCENDING) then begin
    for CntPix := 0 to High(ByteArr) do begin
      TwoChByteArr[(CntPix shl 1) + 1] := ByteArr[CntPix];
    end;
  end;
 End; //If (BitCount = 8)


End;  //Procedure ReplaceCh1InND2File
{ ********************************************************************** }

Procedure ReadImageForAnal(const ImNr: Integer; const Offsets, NrPix: TDynLongIntArray);

Var
  Cnt, CntX: Integer;
  pRead: Pointer;
  GetAndorDimVal: Boolean;

Begin

  If (ImageFileType = SINGLE_IMAGE) Then Begin

    If (FileInRAM) then Begin  //Reading from RAM

     Move(RawDataInRAM[0,ImNr*SizeOfFile+StripOffs[0]],pImData^,ImageBytes);

    End

      Else

    Begin  //Reading from Dics

    ImFile := FileOpen(TiffFileList[ImNr], fmOpenRead or fmShareDenyNone);

    { All Single Image Tifffs, not RAW Noran files }
      { This procedure wors Only with High(StripOffs) = 0
        if Not then Time Series Analysis uses the Conventional ReadImage }

      If BitCount = 16 Then Begin
        for Cnt := 0 to High(Offsets) do begin
          pImData := @Im16bitData[Offsets[Cnt]];
          FileSeek(ImFile, StripOffs[0] + (Offsets[Cnt] shl 1), 0);
          FileRead(ImFile, pImData^, NrPix[Cnt] shl 1);
        end;
        pImData := @Im16bitData[0]; // restores pointer position
      End
      Else If BitCount = 8 Then Begin
        for Cnt := 0 to High(Offsets) do begin
          pImData := @Im8bitData[Offsets[Cnt]];
          FileSeek(ImFile, StripOffs[0] + Offsets[Cnt], 0);
          FileRead(ImFile, pImData^, NrPix[Cnt]);
        end;
        pImData := @Im8bitData[0]; // restores pointer position
      End;
      { this paragraph is for Andor only }
      If (TIFFfileType = TIFF_ANDOR_iQ) Then Begin // Gets TimeSt Value or Other
        GetAndorDimVal := False;
        if (DimTime > -1) then
        begin
          if (TimeSt[ImNr] = -1) then
            GetAndorDimVal := True;
        end
        else if (DimNotTime > -1) then
        begin
          if (ZstackArr[ImNr] > -1) then
            GetAndorDimVal := True;
        end;

        If (GetAndorDimVal) then Begin
          FileSeek(ImFile, AndorDimValOffs, 0);
          pRead := @DArray[0];
          FileRead(ImFile, pRead^, Length(DArray) shl 3);
          { First Do the Time }
          If (DimTime > -1) Then
          Begin
            TimeSt[ImNr] := DArray[DimTime];
            if (Andor_DIM_INFO[DimTime].Resolution <> 1) then
              TimeSt[ImNr] := TimeSt[ImNr] * Andor_DIM_INFO[DimTime].Resolution;
            if (Andor_DIM_INFO[DimTime].Origin <> 0) then
              TimeSt[ImNr] := TimeSt[ImNr] + Andor_DIM_INFO[DimTime].Origin;
            // always subtract the 1st image time
            TimeSt[ImNr] := TimeSt[ImNr] - FirstAndorTime;

            if Andor_DIM_INFO[DimTime].Units = 'ms' then
              TimeSt[ImNr] := TimeSt[ImNr] / 1000
            else if Andor_DIM_INFO[DimTime].Units = 'µs' then
              TimeSt[ImNr] := TimeSt[ImNr] / 1000000;
          End; // If (DimTime > 0

          { Next Do the Other Dimension, if Any }
          If (DimNotTime > -1) Then
          Begin
            ZstackArr[ImNr] := DArray[DimNotTime];
            if (Andor_DIM_INFO[DimNotTime].Resolution <> 1) then
              ZstackArr[ImNr] := ZstackArr[ImNr] * Andor_DIM_INFO[DimNotTime].Resolution;
            if (Andor_DIM_INFO[DimNotTime].Origin <> 0) then
              ZstackArr[ImNr] := ZstackArr[ImNr] + Andor_DIM_INFO[DimNotTime].Origin;
          End; // If (DimNotTime > 0
        End; // If (GetAndorDimVal)
      End; // If (TIFFfileType = TIFF_ANDOR)
      { end with Andor }


      FileClose(ImFile);
    // restores Pointer position

    End; //Reading from Disc
  End

    Else { If  MultyImageFile = False }
  { ------------------------- Deals with Single File Multi Image Movies -------- }
  If (ImageFileType > SINGLE_IMAGE) Then Begin { Single File with Many Images }

    If (ImageFileType = MULTI_IMAGE) then Begin

      //Reading from RAM
      If (FileInRAM) then Begin
          Move(RawDataInRAM[0,ImOff[0,ImNr]],pImData^,ImageBytes);
      End

        Else

      Begin
      //----------------  Reading from Disc --------------------------------//
      If Not((MovFType = NIKON_ND2_MOV) and (NrChannels = 2)) then Begin
        If (BitCount = 8) then Begin
          for Cnt := 0 to High(Offsets) do begin
            pImData := @Im8bitData[Offsets[Cnt]];
            FileSeek(ImFile, ImOff[0,ImNr] + Offsets[Cnt], 0);
            FileRead(ImFile, pImData^, NrPix[Cnt]);
          end;
          pImData := @Im8bitData[0];
        End
          Else
        If (BitCount = 16) Then Begin
          for Cnt := 0 to High(Offsets) do begin
            pImData := @Im16bitData[Offsets[Cnt]];
            FileSeek(ImFile, ImOff[0,ImNr] + (Offsets[Cnt] shl 1), 0); ;
            FileRead(ImFile, pImData^, NrPix[Cnt] shl 1);
          end;
          pImData := @Im16bitData[0];
        End;
      End  //If Not((MovFType = NIKON_ND2_MOV) and (NrChannels = 2))
        Else
      If (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then Begin
        {so far it reads the WHOLE Image since the two channels are interlaced
         I don't want to do complicated indexing the arrays using Offsets[Cnt]
          Unlike ReadImage, here it loads ONLY the 1st channel}
        FileSeek(ImFile, ImOff[0,ImNr], 0);
        FileRead(ImFile, pImData^, ImageBytes);
      End; //if (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then begin

      End; //Else Begin = Reading from Disc

      If (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then Begin
       //Extract 1st channel
       if (BitCount = 16) then begin
          if (ChannelOrder = ASCENDING) then begin
            for Cnt := 0 to High(Im16bitData) do begin
              Im16bitData[Cnt] := TwoChWordArr[Cnt shl 1];
            end
          end
            else
          if (ChannelOrder = DESCENDING) then begin
            for Cnt := 0 to High(Im16bitData) do begin
              Im16bitData [Cnt] := TwoChWordArr[(Cnt shl 1) + 1];
            end;
          end;
          end
            else
          if (BitCount = 8) then begin
            if (ChannelOrder = ASCENDING) then begin
              for Cnt := 0 to High(Im8bitData) do begin
                Im8bitData[Cnt] := TwoChByteArr[Cnt shl 1];
              end;
            end
              else
            if (ChannelOrder = DESCENDING) then begin
              for Cnt := 0 to High(Im8bitData) do begin
                Im8bitData[Cnt] := TwoChByteArr[(Cnt shl 1) + 1];
              end;
            end;
          end
        End; //if (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then begin

    End     //If (ImageFileType = MULTI_IMAGE) then Begin

      Else

    If (ImageFileType = FILE_COLLECTION) then Begin

      If (FileInRAM) then begin
        if not(LoadChAsIndivFiles) then
          Move(RawDataInRAM[CollFileNrInRAM[ImNr],ImOff[0,ImNr]],pImData^,ImageBytes)
          else
        if (LoadChAsIndivFiles) then
          Move(RawDataInRAM[CollFileNrInRAM[ImNr*2+ChannelOrder],ImOff[0,ImNr]],pImData^,ImageBytes);
      End

        Else

      Begin
      If (BitCount = 8) then Begin
        For Cnt := 0 to High(Offsets) do Begin
          pImData := @Im8bitData[Offsets[Cnt]];
          if Not(LoadChAsIndivFiles) then begin
            FileSeek(CollFileHandles[ImNr], ImOff[0,ImNr] + Offsets[Cnt], 0);
            FileRead(CollFileHandles[ImNr], pImData^, NrPix[Cnt])
          end
            else
          if (LoadChAsIndivFiles) then begin
            FileSeek(CollFileHandles[ImNr*2+ChannelOrder], ImOff[0,ImNr] + Offsets[Cnt], 0);
            FileRead(CollFileHandles[ImNr*2+ChannelOrder], pImData^, NrPix[Cnt]);
          end;
        End;
        pImData := @Im8bitData[0]; // restores pointer position
      End
        Else
      If (BitCount = 16) Then Begin
        For Cnt := 0 to High(Offsets) do Begin
          pImData := @Im16bitData[Offsets[Cnt]];
          if Not(LoadChAsIndivFiles) then begin
            FileSeek(CollFileHandles[ImNr], ImOff[0,ImNr] + (Offsets[Cnt] shl 1), 0);
            FileRead(CollFileHandles[ImNr], pImData^, NrPix[Cnt] shl 1);
          end
            else
          if (LoadChAsIndivFiles) then begin
            FileSeek(CollFileHandles[ImNr*2+ChannelOrder], ImOff[0,ImNr] + (Offsets[Cnt] shl 1), 0);
            FileRead(CollFileHandles[ImNr*2+ChannelOrder], pImData^, NrPix[Cnt] shl 1);
          end;
        End;
        pImData := @Im16bitData[0]; // restores pointer position
        End;
      End; //Else Begin
    End; // If (ImageFileType = FILE_COLLECTION)

    { ---------------------------------------------------------- }
    // Nikon ND2 read from Drive specific//
    If Not(FileInRAM) then if (MovFType = NIKON_ND2_MOV) then if Not(LoadStreamPixAndND2TimeSt) then
        if (TimeSt[ImNr] < 0) then begin
          pRead := @TimeSt[ImNr];
          FileSeek(ImFile, ImOff[0,ImNr] - 8, 0);
          FileRead(ImFile, pRead^, 8);
          TimeSt[ImNr] := (TimeSt[ImNr] - FirstTimeStND2)/1000;   //convert ms into sec
    End; // Nikon ND2 read from Drive specific

    If (MovFType = StreamPix_MOV) then if Not(LoadStreamPixAndND2TimeSt) then if (TimeSt[ImNr] < 0) then Begin
      FileSeek(ImFile, ImOff[0,ImNr] + ImageBytes, 0); // not needed - the file pointer automatically is there
      pRead := @SecMS[0];
      FileRead(ImFile, pRead^, 8);
      TimeSt[ImNr] := (SecMS[0] - MemSecMS[0]) + (SecMS[1] - MemSecMS[1])/ 1000;
    End; // if MovFType = StreamPix_M

  End; { If MultyImageFile = True }

  { swaps if needed }
  If (BitCount = 16) then if (ToSwap = True) then Begin
      for Cnt := 0 to High(Offsets) do begin
        for CntX := 0 to NrPix[Cnt] - 1 do // Nr of Pixels - 1
          Im16bitData[Offsets[Cnt] + CntX] := Swap
            (Im16bitData[Offsets[Cnt] + CntX]);
      end;
  End; // swap

End; { Procedure ForAnal; }

{ ********************************************************************** }

Procedure ReadImage(const ImNr: Integer; const ChNr : Integer; var ptData : Pointer);
Var
  Cnt, CntX       : Integer;
  ReadArrPos      : LongWord;
  pRead           : Pointer;
  GetAndorDimVal  : Boolean;
  //ptData is Pointer to the Image Data
Begin

  If (ImageFileType = SINGLE_IMAGE) Then Begin
   {Meaning One File Contains One Image per File: All Generic, Noran Prarie and QED tiff, even separately Open}

   If (FileInRAM) then Begin
      Move(RawDataInRAM[0,ImNr*SizeOfFile+StripOffs[0]],ptData^,ImageBytes);
   End

    Else

   Begin  //Reading from Dics

      ImFile := FileOpen(TiffFileList[ImNr], fmOpenRead or fmShareDenyNone);
    { All single Image TIFF Files }

      { all One Image Tiffs; }
      If High(StripOffs) = 0 Then Begin
        FileSeek(ImFile, StripOffs[0], 0);
        FileRead(ImFile, ptData^, StripSizes[0]);
        { pImData points to 8 or 16 bit arrays; assigned in GetInfo Proc }
      End
      Else If High(StripOffs) > 0 Then Begin
        ReadArrPos := 0;
        If (BitCount = 16) Then
          For Cnt := 0 to High(StripOffs) Do Begin
            FileSeek(ImFile, StripOffs[Cnt], 0);
            ptData := @Im16bitData[ReadArrPos];
            { Sets Pointer at Appropriate Position in Array }
            Inc(ReadArrPos, StripSizes[Cnt] shr 1);
            FileRead(ImFile, ptData^, StripSizes[Cnt]);
          End
          Else If BitCount = 8 Then
            For Cnt := 0 to High(StripOffs) Do Begin
              FileSeek(ImFile, StripOffs[Cnt], 0);
              ptData := @Im8bitData[ReadArrPos];
              { Sets Pointer at Appropriate Position in Array }
              Inc(ReadArrPos, StripSizes[Cnt]);
              FileRead(ImFile, ptData^, StripSizes[Cnt]);
            End;
      End; // High(StripOffs) > 0

      If (TIFFfileType = TIFF_ANDOR_iQ) and (NrIm > 1) Then Begin
        GetAndorDimVal := False;

        if (DimTime > -1) then begin
          if (TimeSt[ImNr] = -1) then GetAndorDimVal := True;
        end
          else
        if (DimNotTime > -1) then begin
            if (ZstackArr[ImNr] > -1) then GetAndorDimVal := True;
        end; //if (DimTime > -1) then begin

        If (GetAndorDimVal) then Begin
          FileSeek(ImFile, AndorDimValOffs, 0);
          pRead := @DArray[0];
          FileRead(ImFile, pRead^, Length(DArray) shl 3);
          { First Do the Time }
          If (DimTime > -1) Then
          Begin
            TimeSt[ImNr] := DArray[DimTime];
            if (Andor_DIM_INFO[DimTime].Resolution <> 1) then
              TimeSt[ImNr] := TimeSt[ImNr] * Andor_DIM_INFO[DimTime].Resolution;
            if (Andor_DIM_INFO[DimTime].Origin <> 0) then
              TimeSt[ImNr] := TimeSt[ImNr] + Andor_DIM_INFO[DimTime].Origin;
            // always subtract the 1st image time
            TimeSt[ImNr] := TimeSt[ImNr] - FirstAndorTime;

            if Andor_DIM_INFO[DimTime].Units = 'ms' then
              TimeSt[ImNr] := TimeSt[ImNr] / 1000
            else if Andor_DIM_INFO[DimTime].Units = 'µs' then
              TimeSt[ImNr] := TimeSt[ImNr] / 1000000;
          End; // If (DimTime > 0

          { Next Do the Other Dimension, if Any }
          If (DimNotTime > -1) Then Begin
            ZstackArr[ImNr] := DArray[DimNotTime];
            if (Andor_DIM_INFO[DimNotTime].Resolution <> 1) then
              ZstackArr[ImNr] := ZstackArr[ImNr] * Andor_DIM_INFO
                [DimNotTime].Resolution;
            if (Andor_DIM_INFO[DimNotTime].Origin <> 0) then
              ZstackArr[ImNr] := ZstackArr[ImNr] + Andor_DIM_INFO
                [DimNotTime].Origin;
          End; // If (DimNotTime > 0
        End; // If (GetAndorDimVal)
      End; // If (TIFFfileType = TIFF_ANDOR)

       FileClose(ImFile);

    End; //Reading from Disc
        { End with All Single Image TIFF Files }

  End  { If  ImageFileType = SINGLE_IMAGE }

   Else
  { ------End with with Single File Movies -------- }

  { Begining with Single Files with More then One Images ------ }
  If (ImageFileType > SINGLE_IMAGE) Then Begin

    If (ImageFileType = MULTI_IMAGE) then Begin
      If (FileInRAM) then Begin
          Move(RawDataInRAM[0,ImOff[ChNr,ImNr]],ptData^,ImageBytes);
      End
        Else
      Begin
        FileSeek(ImFile, ImOff[ChNr,ImNr], 0);
        FileRead(ImFile, ptData^, ImageBytes);
      End;
    End
      Else
    If (ImageFileType = FILE_COLLECTION) then Begin
      if (FileInRAM) then begin
        if not(LoadChAsIndivFiles) then
          Move(RawDataInRAM[CollFileNrInRAM[ImNr],ImOff[ChNr,ImNr]],ptData^,ImageBytes)
          else
        if (LoadChAsIndivFiles) then
          Move(RawDataInRAM[CollFileNrInRAM[ImNr*2+Abs(ChNr-ChannelOrder)],ImOff[ChNr,ImNr]],ptData^,ImageBytes)
      end
        else
      begin
        if not(LoadChAsIndivFiles) then begin
          FileSeek(CollFileHandles[ImNr], ImOff[ChNr,ImNr], 0);
          FileRead(CollFileHandles[ImNr], ptData^, ImageBytes);
        end
          else
        if (LoadChAsIndivFiles) then begin
          FileSeek(CollFileHandles[ImNr*2+Abs(ChNr-ChannelOrder)], ImOff[ChNr,ImNr], 0);
          FileRead(CollFileHandles[ImNr*2+Abs(ChNr-ChannelOrder)], ptData^, ImageBytes);
        end;
      end;
    End;

    // Nikon ND2 read from Drive specific//
    If Not(FileInRAM) then if (MovFType = NIKON_ND2_MOV) then if Not(LoadStreamPixAndND2TimeSt) then
        if (TimeSt[ImNr] < 0) then begin
          pRead := @TimeSt[ImNr];
          FileSeek(ImFile, ImOff[ChNr,ImNr] - 8, 0);
          FileRead(ImFile, pRead^, 8);
          TimeSt[ImNr] := (TimeSt[ImNr] - FirstTimeStND2)/1000;  //convert ms into sec
    End; // Nikon ND2 read from Drive specific


    // StreamPix Specific Command//
    If (MovFType = StreamPix_MOV) then if Not(LoadStreamPixAndND2TimeSt) then
        if (TimeSt[ImNr] < 0) then begin
          FileSeek(ImFile,ImOff[0,ImNr]+ ImageBytes, 0);  // not needed - the file pointer automatically is there
                                                          //since TimeStamp followes the Image Data }
          pRead := @SecMS[0];
          FileRead(ImFile, pRead^, 8);
          TimeSt[ImNr] := (SecMS[0] - MemSecMS[0]) + (SecMS[1] - MemSecMS[1])/ 1000;
    End; // if MovFType = StreamPix_Mov

    If (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then Begin
     //this is the fastes way to split  Two Channekl Array into two
      If (BitCount = 16) then begin
        if (ChannelOrder = ASCENDING) then begin
          for Cnt := 0 to High(Im16bitData) do begin
            Im16bitData[Cnt] := TwoChWordArr[Cnt shl 1];
            Im2nd16bit [Cnt] := TwoChWordArr[(Cnt shl 1) + 1];
          end
        end
          else
        if (ChannelOrder = DESCENDING) then begin
          for Cnt := 0 to High(Im16bitData) do begin
            Im2nd16bit[  Cnt] := TwoChWordArr[Cnt shl 1];
            Im16bitData [Cnt] := TwoChWordArr[(Cnt shl 1) + 1];
          end;
        end;
      End  //If (BitCount = 16)
        Else
      If (BitCount = 8) then begin
        if (ChannelOrder = ASCENDING) then begin
          for Cnt := 0 to High(Im8bitData) do begin
            Im8bitData[Cnt] := TwoChByteArr[Cnt shl 1];
            Im2nd8bit[Cnt] := TwoChByteArr[(Cnt shl 1) + 1];
          end;
        end
          else
        if (ChannelOrder = DESCENDING) then begin
          for Cnt := 0 to High(Im8bitData) do begin
            Im2nd8bit[Cnt] := TwoChByteArr[Cnt shl 1];
            Im8bitData[Cnt] := TwoChByteArr[(Cnt shl 1) + 1];
          end;
        end;
      End; //If (BitCount = 8)
    End; //if (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then begin


  End; { If MultyImageFile = True }
  { -------------End with Reading Files -------------------------------------- }

  // this is for MM TIFFs which are made by some programs
  If (ToSwap) then begin // ToSwap is set to True for 16 bit files only
    if (ChNr = 0) then begin
      for Cnt := 0 to High(Im16bitData) do Im16bitData[Cnt] := Swap(Im16bitData[Cnt]);
    end
      else
    if (ChNr = 1) then begin
      for Cnt := 0 to High(Im2nd16bit) do Im2nd16bit[Cnt] := Swap(Im2nd16bit[Cnt]);
    end;
  End;

  { Make Pix = Zero Outside ROIs if needed }
  If (frmImageControl.btZeroOutsideROI_All_Images.Down) then
  Begin
    If (BitCount = 16) then
      ZeroOutsideROI(Im16bitData)
    else If (BitCount = 8) then
      ZeroOutsideROI(Im8bitData);
  End;

End; { Procedure ReadImage; }

{ ********************************************************************** }

Procedure WriteImage(FhCor: THandle; const ImNr: Integer;
                      const im8bitBuffer: TDynByteArray;
                      const im16bitBuffer: TDynWordArray);
  {Writes Image Portion to Existing File}
Var
  Cnt: Integer;
  ReadArrPos: LongWord;
  pWrite: Pointer;

Begin

  if (BitCount = 8) then pWrite := @im8bitBuffer[0]
      else
  if (BitCount = 16) then pWrite := @im16bitBuffer[0];

  // this is for MM TIFFs which are made by some programs
  if (ToSwap = True) then for Cnt := 0 to High(Im16bitData) do begin
    im16bitBuffer[Cnt] := Swap(im16bitBuffer[Cnt]);
  end;

  If (ImageFileType = SINGLE_IMAGE) Then Begin { All QED tiff, even separately Open }
    FhCor := FileOpen(TiffFileList[ImNr], fmOpenWrite or fmShareDenyNone);
    { All single Image TIFF Files }

      If High(StripOffs) = 0 Then
      Begin
        FileSeek(FhCor, StripOffs[0], 0);
        FileWrite(FhCor, pWrite^, StripSizes[0]);
        { pImData points to 8 or 16 bit arrays; assigned in GetInfo Proc }
      End
      Else If High(StripOffs) > 0 Then
      Begin
        ReadArrPos := 0;
        If (BitCount = 16) Then
          For Cnt := 0 to High(StripOffs) Do
          Begin
            FileSeek(FhCor, StripOffs[Cnt], 0);
            pWrite := @im16bitBuffer[ReadArrPos];
            { Sets Pointer at Appropriate Position in Array }
            Inc(ReadArrPos, StripSizes[Cnt] shr 1);
            FileWrite(FhCor, pWrite^, StripSizes[Cnt]);
          End
          Else If (BitCount = 8) Then
            For Cnt := 0 to High(StripOffs) Do
            Begin
              FileSeek(FhCor, StripOffs[Cnt], 0);
              pWrite := @im8bitBuffer[ReadArrPos];
              { Sets Pointer at Appropriate Position in Array }
              Inc(ReadArrPos, StripSizes[Cnt]);
              FileWrite(FhCor, pWrite^, StripSizes[Cnt]);
            End;
      End; // High(StripOffs) > 0
   
  End { If  ImageFileType = SINGLE_IMAGE }

    Else
  { ------End with with Single File Movies -------- }

  { Beg with Single Files with More then One Images ------ }
  If (ImageFileType > SINGLE_IMAGE) Then Begin
     If (ImageFileType = MULTI_IMAGE) then Begin
      FileSeek(FhCor, ImOff[0,ImNr], 0);
      FileWrite(FhCor, pWrite^, ImageBytes);
    End
      Else
    If (ImageFileType = FILE_COLLECTION) then Begin
      if Not(LoadChAsIndivFiles) then begin
        FileSeek (CollFileHandles[ImNr], ImOff[0,ImNr], 0);
        FileWrite(CollFileHandles[ImNr], pWrite^, ImageBytes);
      end
        else
      if (LoadChAsIndivFiles) then begin
        FileSeek (CollFileHandles[ImNr*2+ChannelOrder], ImOff[0,ImNr], 0);
        FileWrite(CollFileHandles[ImNr*2+ChannelOrder], pWrite^, ImageBytes);
      end;
    End;
  End; { If MultyImageFile = True }
  { -------------End with Witing Files -------------------------------------- }

End; { Procedure WriteImage; }


{ ********************************************************************** }
Procedure ZeroOutsideROI(var RawImData: TDynByteArray); overload;
var
  i, CntX, CntY, CntROI: Integer;
Begin

  { 1st: Zero (Reset)  ImageZeroMap }
  for i := 0 to High(ImageZeroMap) do
    ImageZeroMap[i] := 0;

  { 2nd: Go through All ROI }
  For CntROI := 1 to 20 do
  Begin

    If ROIvar.ROIAdr[CntROI] = 1 then
    Begin
      { Sets ROI Pixels to 1 in ImageZeroMap }
      for CntY := ROIvar.ROICoor[2, CntROI] to ROIvar.ROICoor[4, CntROI] do
        for CntX := ROIvar.ROICoor[1, CntROI] to ROIvar.ROICoor[3, CntROI] do
          ImageZeroMap[CntX + imXsize * CntY] := 1;
    End
    Else

      If ROIvar.ROIAdr[CntROI] = 3 then
    Begin

      { Sets ROI Pixels to 1 in ImageZeroMap }
      For CntY := 0 to High(FhTbl[CntROI]) Do
      Begin
        If ( High(FhTbl[CntROI, CntY]) > 0) Then
        Begin
          CntX := 0;
          While CntX < High(FhTbl[CntROI, CntY]) Do
          Begin
            for i := 0 to (FhTbl[CntROI, CntY, CntX + 1].x - FhTbl[CntROI,
              CntY, CntX].x) do
              ImageZeroMap[FhTbl[CntROI, CntY,
                CntX].x + i + imXsize * FhTbl[CntROI, CntY, CntX].y] := 1;
            Inc(CntX, 2);
          End; { while }
        End
        Else { If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin }
        If ( High(FhTbl[CntROI, CntY]) = 0) Then { For a single Pixel }
          ImageZeroMap[FhTbl[CntROI, CntY, 0].x + imXsize * FhTbl[CntROI, CntY,
            0].y] := 1;
      End; { For CntY := 0 to High(TabFh) do begin }
      { --- End of Sets ROI Pixels to 1 in ImageZeroMap --- }
      { ----------------------------------------------------------------------------- }
    End; // If ROIvar.ROIAdr[A] = 3 then Begin
  End; // For CntROI := 1 to 20 do Begin

  { Sets ROI Pixels to 1 in Raw ImData Buffer }
  for i := 0 to High(ImageZeroMap) do
  begin
    if ImageZeroMap[i] = 0 then
      RawImData[i] := 0;
  end;

End; // End of Procedure ZeroOutsideROI(RawImData : TDynByteArray); overload;
{ ********************************************************************** }

Procedure ZeroOutsideROI(var RawImData: TDynWordArray); overload;
var
  i, CntX, CntY, CntROI: Integer;
Begin

  { 1st: Zero (Reset)  ImageZeroMap }
  for i := 0 to High(ImageZeroMap) do
    ImageZeroMap[i] := 0;

  { 2nd: Go through All ROI }
  For CntROI := 1 to 20 do
  Begin

    If ROIvar.ROIAdr[CntROI] = 1 then
    Begin
      { Sets ROI Pixels to 1 in ImageZeroMap }
      for CntY := ROIvar.ROICoor[2, CntROI] to ROIvar.ROICoor[4, CntROI] do
        for CntX := ROIvar.ROICoor[1, CntROI] to ROIvar.ROICoor[3, CntROI] do
          ImageZeroMap[CntX + imXsize * CntY] := 1;
    End
    Else

      If ROIvar.ROIAdr[CntROI] = 3 then
    Begin

      { Sets ROI Pixels to 1 in ImageZeroMap }
      For CntY := 0 to High(FhTbl[CntROI]) Do
      Begin
        If ( High(FhTbl[CntROI, CntY]) > 0) Then
        Begin
          CntX := 0;
          While CntX < High(FhTbl[CntROI, CntY]) Do
          Begin
            for i := 0 to (FhTbl[CntROI, CntY, CntX + 1].x - FhTbl[CntROI,
              CntY, CntX].x) do
              ImageZeroMap[FhTbl[CntROI, CntY,
                CntX].x + i + imXsize * FhTbl[CntROI, CntY, CntX].y] := 1;
            Inc(CntX, 2);
          End; { while }
        End
        Else { If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin }
        If ( High(FhTbl[CntROI, CntY]) = 0) Then { For a single Pixel }
          ImageZeroMap[FhTbl[CntROI, CntY, 0].x + imXsize * FhTbl[CntROI, CntY,
            0].y] := 1;
      End; { For CntY := 0 to High(TabFh) do begin }
      { --- End of Sets ROI Pixels to 1 in ImageZeroMap --- }
      { ----------------------------------------------------------------------------- }
    End; // If ROIvar.ROIAdr[A] = 3 then Begin
  End; // For CntROI := 1 to 20 do Begin

  { Sets ROI Pixels to 1 in Raw ImData Buffer }
  for i := 0 to High(ImageZeroMap) do
  begin
    if ImageZeroMap[i] = 0 then
      RawImData[i] := 0;
  end;

End; // End of Procedure ZeroOutsideROI(RawImData : TDynWordArray); overload;

{ ********************************************************************** }
Procedure ZeroOutsideROI(var RawImData: TDynDoubleArray); overload;
var
  i, CntX, CntY, CntROI: Integer;
Begin

  { 1st: Zero (Reset)  ImageZeroMap }
  for i := 0 to High(ImageZeroMap) do
    ImageZeroMap[i] := 0;

  { 2nd: Go through All ROI }
  For CntROI := 1 to 20 do
  Begin

    If ROIvar.ROIAdr[CntROI] = 1 then
    Begin
      { Sets ROI Pixels to 1 in ImageZeroMap }
      for CntY := ROIvar.ROICoor[2, CntROI] to ROIvar.ROICoor[4, CntROI] do
        for CntX := ROIvar.ROICoor[1, CntROI] to ROIvar.ROICoor[3, CntROI] do
          ImageZeroMap[CntX + imXsize * CntY] := 1;
    End
    Else

      If ROIvar.ROIAdr[CntROI] = 3 then
    Begin

      { Sets ROI Pixels to 1 in ImageZeroMap }
      For CntY := 0 to High(FhTbl[CntROI]) Do
      Begin
        If ( High(FhTbl[CntROI, CntY]) > 0) Then
        Begin
          CntX := 0;
          While CntX < High(FhTbl[CntROI, CntY]) Do
          Begin
            for i := 0 to (FhTbl[CntROI, CntY, CntX + 1].x - FhTbl[CntROI,
              CntY, CntX].x) do
              ImageZeroMap[FhTbl[CntROI, CntY,
                CntX].x + i + imXsize * FhTbl[CntROI, CntY, CntX].y] := 1;
            Inc(CntX, 2);
          End; { while }
        End
        Else { If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin }
        If ( High(FhTbl[CntROI, CntY]) = 0) Then { For a single Pixel }
          ImageZeroMap[FhTbl[CntROI, CntY, 0].x + imXsize * FhTbl[CntROI, CntY,
            0].y] := 1;
      End; { For CntY := 0 to High(TabFh) do begin }
      { --- End of Sets ROI Pixels to 1 in ImageZeroMap --- }
      { ----------------------------------------------------------------------------- }
    End; // If ROIvar.ROIAdr[A] = 3 then Begin
  End; // For CntROI := 1 to 20 do Begin

  { Sets ROI Pixels to 1 in Raw ImData Buffer }
  for i := 0 to High(ImageZeroMap) do
  begin
    if ImageZeroMap[i] = 0 then
      RawImData[i] := 0;
  end;

End; // End of Procedure ZeroOutsideROI(RawImData : TDynDoubleArray); overload;
{ ********************************************************************** }

Procedure MakeAverIm;
Var
  ImNr, Cnt: Integer;

Begin

  if (ChannelOrder = ASCENDING)  then AvImChOrig := 1   //added March 2017
    else
  if (ChannelOrder = DESCENDING) then AvImChOrig := 2;

  For Cnt := 0 to ImagePix - 1 do
    AvImRaw[Cnt] := 0; { Zeroes out array }

  For ImNr := 0 to NrIm - 1 do
  Begin
    If AvImList[ImNr] > 0 Then
    Begin
      ReadImage(ImNr,0,pImData);
      if (BitCount = 16) then
        for Cnt := 0 to ImagePix - 1 do
          AvImRaw[Cnt] := AvImRaw[Cnt] + Im16bitData[Cnt]
        else
          for Cnt := 0 to ImagePix - 1 do
            AvImRaw[Cnt] := AvImRaw[Cnt] + Im8bitData[Cnt];

    End; { For i := 0 to NrIm -1 }
  End; { If AvImList[ImNr] > 0 }
  { ---- Now Divides by the Number of Images Selected --- }
  for Cnt := 0 to ImagePix - 1 do
    AvImRaw[Cnt] := AvImRaw[Cnt] / ImSel;
  { Copies to Display Buffer }
  CopyAvImToDisplBuffer;
  ReadImage(CurIm,0,pImData); { Restores the Current Image in the buffer }

End;
{ Procedure MakeAverIm; }
{ ************************************************************************* }
Procedure CopyAvImToDisplBuffer;

{ALWAYS DISPLAYS AvImRaw = Raw (Not Filtered, No Bkg subtracted, No Cutoff Subtracted) Raw Average Image}

var
  Cnt, j, imLen, PixMin, PixVal: Integer;
  DivFact: Double;
  FullRange : boolean;
Begin

  { Finds the Scale (Division factor }

  If (BitCount = 16) then Begin
    If (AvImChOrig = 1) then Begin
      if (PixRange[0].DSPixRange_PosFrom <> 0) or (PixRange[0].DSPixRange_PosTo <> MaxPixVal) then
        FullRange := False
          else
        FullRange := True;
      End
        else
      If (AvImChOrig = 2) then Begin
      if (PixRange[1].DSPixRange_PosFrom <> 0) or (PixRange[1].DSPixRange_PosTo <> MaxPixVal) then
        FullRange := False
          else
        FullRange := True;
      End
  End;

  If Not(FullRange) and (BitCount = 16) then Begin
    if (AvImChOrig = 1) then begin
      PixMin  := PixRange[0].DSPixRange_PosFrom;
      DivFact := (PixRange[0].DSPixRange_PosTo - PixMin) / 255;
    end
      else
    if (AvImChOrig = 2) then begin
      PixMin  := PixRange[1].DSPixRange_PosFrom;
      DivFact := (PixRange[1].DSPixRange_PosTo - PixMin) / 255;
    end;
  End
    Else
  If (FullRange) or (BitCount = 8) then Begin
    DivFact := exp((shrFact) * ln(2));
    if DivFact = 0 then DivFact := 1;
  End;

  { Does the Scaling }
  If BMPPadding = 0 then Begin
    For Cnt := 0 to ImagePix - 1 do Begin
      if (BitCount = 16) then begin
        PixVal := round((AvImRaw[Cnt] - PixMin) / DivFact);
        if PixVal < 0 then
          PixVal := 0;
        if PixVal > 255 then
          PixVal := 255;
        AvIm8bit[Cnt] := PixVal;
      end
        else
      begin
        if round(AvImRaw[Cnt]) <= 255 then
          AvIm8bit[Cnt] := round(AvImRaw[Cnt])
        else
          AvIm8bit[Cnt] := 255;
      end;
    End; { Cnt := 0 to ImagePix -1 }
  End

    Else

  If BMPPadding <> 0 then Begin
    Cnt := 0;
    j := 0;
    imLen := imXsize - 1;
    While Cnt < High(AvImRaw) do Begin
      if (BitCount = 16) then begin
        PixVal := round((AvImRaw[Cnt] - PixMin) / DivFact);
        if PixVal < 0 then
          PixVal := 0;
        if PixVal > 255 then
          PixVal := 255;
        AvIm8bit[j] := PixVal;
      end
        else
      begin
        if round(AvImRaw[Cnt]) <= 255 then
          AvIm8bit[j] := round(AvImRaw[Cnt])
        else
          AvIm8bit[j] := 255;
      end;
      if Cnt Mod imXsize <> imLen then
        Inc(j, 1)
      else
        Inc(j, BMPPadding);
      Inc(Cnt);
    End;
  End; { If BMPPadding <> 0 }
End;
{ ************************************************************************* }

Procedure DoBkgonAvIm;
{ Does Bkg on "Working" AvIm array ; AND CutOff, which Applies to AvIm Only }
var
  Cnt: Integer;
  { Bkg : Integer - Global }
Begin

  If (SmoothMode = NO_SMOOTH) or Not(frmImageControl.cbSmoothBeforeDoRatio.Checked) then Begin
    For Cnt := 0 to ImagePix - 1 do Begin
      AvIm[Cnt] := AvImRaw[Cnt] - Bkg;
      if AvIm[Cnt] < 1 then AvIm[Cnt] := 0;
      if AvIm[Cnt] <= CutOff then AvIm[Cnt] := 0;
      { it is not Worth do use Values below 1
        any noise would produce F/F0 = 1 or more }
    End; { For Cnt := 0 to ImagePix -1 }
  End
    Else
  If (SmoothMode > NO_SMOOTH) And (frmImageControl.cbSmoothBeforeDoRatio.Checked)then Begin
    //AvIm has been smoothed already by SmoothAverIm(AvImRaw,AvIm) in frmImageControl
    For Cnt := 0 to ImagePix - 1 do Begin
      AvIm[Cnt] := AvIm[Cnt] - Bkg;
      if AvIm[Cnt] < 1 then       AvIm[Cnt] := 0;
      if AvIm[Cnt] <= CutOff then AvIm[Cnt] := 0;
      // it is not Worth do use Values below 1
      // any noise would produce F/F0 = 1 or more
    End; // For Cnt := 0 to ImagePix -1
  End; // (SmoothMode > 0)

End; { Procedure DoBkgonAvIm; }

{ ************************************************************************* }

Procedure SmoothAverIm(Const InputArr: TDynDoubleArray; var OutputArr: TDynDoubleArray);

Var
  TempArr: TDynDoubleArray; { Used for Box & Median Smoothing }
  ptToArr: TDynDoubleArray; { used a sa Pointer to InputArr or TempArr }

BEGIN

  If (SmoothMode in [SMOOTH_BOX, SMOOTH_BOX_MED]) Then
  Begin
    if (SmoothMode = SMOOTH_BOX_MED) then
    begin
      SetLength(TempArr, ImagePix);
      ptToArr := TempArr;
    end
    else
      ptToArr := OutputArr;
    BoxCarFilt(InputArr, ptToArr, imXsize, imYsize, BoxSmSize, True);
    if (SmoothMode = SMOOTH_BOX_MED) then
      MedianFilt(ptToArr, OutputArr, imXsize, imYsize, MedSmSize, True);
  End
  Else

    If (SmoothMode in [SMOOTH_MED, SMOOTH_MED_BOX, SMOOTH_MED_GAUSS]) Then
  Begin
    if (SmoothMode in [SMOOTH_MED_BOX, SMOOTH_MED_GAUSS]) then
    begin
      SetLength(TempArr, ImagePix);
      ptToArr := TempArr;
    end
    else
      ptToArr := OutputArr;
    MedianFilt(InputArr, ptToArr, imXsize, imYsize, MedSmSize, True);
    if (SmoothMode = SMOOTH_MED_BOX) then
      BoxCarFilt(ptToArr, OutputArr, imXsize, imYsize, BoxSmSize, True)
    else if (SmoothMode = SMOOTH_MED_GAUSS) then
      Gauss2DFilt(ptToArr, OutputArr, imXsize, imYsize, GaussSmSize, True);
  End;

  If (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED]) Then
  Begin
    if (SmoothMode = SMOOTH_GAUSS_MED) then
    begin
      SetLength(TempArr, ImagePix);
      ptToArr := TempArr;
    end
    else
      ptToArr := OutputArr;
    Gauss2DFilt(InputArr, ptToArr, imXsize, imYsize, GaussSmSize, True);
    if (SmoothMode = SMOOTH_GAUSS_MED) then
      MedianFilt(ptToArr, OutputArr, imXsize, imYsize, MedSmSize, True);
  End
  Else

  End; { Procedure SmoothAverIm; }

{ ********************************************************************** }
Procedure Transfer8bitImageToImDispl(var DisplayArray : TDynByteArray);
Var Cnt,j,imLen : Integer;
    pDataByte  : TDynByteArray;
    pDataWord  : TDynWordArray;
Begin

   //---------- No Smoothing for Any Channel -------------------//
  If ((SmoothNonRatio = NO_SMOOTH_NON_RATIO) or (SmoothMode = NO_SMOOTH))
        Or
     ((DisplayArray = ImDispl)    and (SmoothNonRatio = SMOOTH_Ch_TWO))
        Or
     ((DisplayArray = Im2ndDispl) and (SmoothNonRatio = SMOOTH_Ch_ONE))

  Then Begin

    if (DisplayArray = ImDispl)    then pDataByte := Im8bitData
      else
    if (DisplayArray = Im2ndDispl) then pDataByte := Im2nd8bit;

    If (CutOff > 0) then Begin
      for Cnt := 0 to High(pDataByte) do
        if (pDataByte[Cnt] <= CutOff) then pDataByte[Cnt] := 0;
    End;

    If (BMPPadding = 0) Then Begin
      Move(pDataByte[0],DisplayArray[0],Length(pDataByte));
    End Else
    If (BMPPadding <> 0) Then Begin
      Cnt := 0;
      J   := 0;
      imLen := imXsize - 1;
      while Cnt < High(pDataByte) do begin
        DisplayArray[J] := pDataByte[Cnt];
        if Cnt Mod imXsize <> imLen then Inc(J,1) else Inc(J,BMPPadding);
        Inc(Cnt);
      end; //while
    End;
  End

    Else
  // ----------- Smoothing for -------------------------------------//
  If (SmoothNonRatio = SMOOTH_Ch_BOTH) and (SmoothMode > NO_SMOOTH) or
     ((DisplayArray = ImDispl)    and (SmoothNonRatio = SMOOTH_Ch_ONE)) or
     ((DisplayArray = Im2ndDispl) and (SmoothNonRatio = SMOOTH_Ch_TWO))
  Then Begin
    if (DisplayArray = ImDispl) then begin
      ApplySmoothing;
      pDataWord := Im16bitDataSM_Last;
    end
     else
    if (DisplayArray = Im2ndDispl) then begin
      ApplySmoothingOn2ndChannel;
      pDataWord := Im2nd16bitSM_Last;
    end;

    If (CutOff > 0) then Begin
      for Cnt := 0 to High(pDataWord) do
        if (pDataWord[Cnt] <= CutOff) then pDataWord[Cnt] := 0;
    End;

    If (BMPPadding = 0) then for Cnt := 0 to High(DisplayArray) do Begin
        DisplayArray[Cnt] := pDataWord[Cnt];
    End
      Else
    If (BMPPadding <> 0) Then Begin
      Cnt := 0;
      J   := 0;
      imLen := imXsize - 1;
      while Cnt < High(pDataWord) do begin
        DisplayArray[J] := pDataWord[Cnt];
        if Cnt Mod imXsize <> imLen then Inc(J,1) else Inc(J,BMPPadding);
        Inc(Cnt);
      end; //while
    End;
  End; //If (SmoothNonRatio > NO_SMOOTH_NON_RATIO) and (SmoothMode > NO_SMOOTH)

End; //Procedure Transfer8bitImageToImDispl(var DisplayArray : TDynByteArray);

{ ************************************************************************** }

Procedure Scale16bitImageToImDispl(const ChNr : Integer;var DisplayArray : TDynByteArray);
  var
    ScaleFactor: Double;
    Cnt, PixVal : Integer;
    PixMin, imLen, j: Integer;
    pData : TDynWordArray;
    FullRange : Boolean;

  Begin

 If (ChannelOrder = ASCENDING) then Begin

  If (ChNr = 0) then Begin
    If not(SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH) then begin
      pData := Im16bitData;
    End
      else
    If (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH) then Begin
      ApplySmoothing;
      pData := Im16bitDataSM_Last;
    End
  End

     Else

  If (ChNr = 1) then Begin
    If not(SmoothNonRatio in[SMOOTH_Ch_TWO,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH) then Begin
      pData := Im2nd16bit;
    End
      else
    If (SmoothNonRatio in[SMOOTH_Ch_TWO,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH) then Begin
      ApplySmoothingOn2ndChannel;
      pData := Im2nd16bitSM_Last;
    End;
  End;
 End //If (ChannelOrder = ASCENDING) then Begin

  Else

 If (ChannelOrder = DESCENDING) then Begin

  If (ChNr = 0) then Begin
    If not(SmoothNonRatio in[SMOOTH_Ch_TWO,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH) then begin
      pData := Im16bitData;
    End
      else
    If (SmoothNonRatio in[SMOOTH_Ch_TWO,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH) then Begin
      ApplySmoothing;
      pData := Im16bitDataSM_Last;
    End
  End

     Else

  If (ChNr = 1) then Begin
    If not(SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH) then Begin
      pData := Im2nd16bit;
    End
      else
    If (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH) then Begin
      ApplySmoothingOn2ndChannel;
      pData := Im2nd16bitSM_Last;
    End;
  End;

 End; //If (ChannelOrder = DESCENDING) then Begin


  If (CutOff > 0) then Begin
    for Cnt := 0 to High(pData) do
        if (pData[Cnt] <= CutOff) then pData[Cnt] := 0;
  End;

  if (ChannelOrder = ASCENDING) then begin
    if (ChNr = 0) then Cnt := 0 else     //Cnt here used Just to Swap; later used as Counter
    if (ChNr = 1) then Cnt := 1;
  end
    else
  if (ChannelOrder = DESCENDING) then begin
    if (ChNr = 0) then Cnt := 1 else
    if (ChNr = 1) then Cnt := 0;
  end;

  if (PixRange[Cnt].DSPixRange_PosFrom <> 0) or (PixRange[Cnt].DSPixRange_PosTo <> MaxPixVal) then
  begin
    FullRange := False;
    PixMin := PixRange[Cnt].DSPixRange_PosFrom;
    ScaleFactor := (PixRange[Cnt].DSPixRange_PosTo - PixMin) / 255;
  end
    else
  begin
    FullRange := True;
  end;

  If (BMPPadding = 0) then Begin

      If Not(FullRange) then Begin
        { Another way published is
          ScaledPixData[Cnt] := ((PixData[Cnt] - PixMin)/(PixMax-PixMin)) * 253 + 1;
          this gives for 0 always 1; and for max always 244
          }
       for Cnt := 0 to High(pData) do begin
          if (pData[Cnt] > PixMin) then
            PixVal := round((pData[Cnt] - PixMin) / ScaleFactor)
          else
            PixVal := 0;
          if PixVal > 255 then
            PixVal := 255;
          DisplayArray[Cnt] := PixVal;
        end; // for Cnt := 0 to High(pData)
        // test with shr - 15 sec; with scaling - 17 sec (QED Ca image file)
      End
        else
      Begin
        for Cnt := 0 to High(pData) do
          DisplayArray[Cnt] := pData[Cnt] shr shrFact;
      End;

  End
    Else
    // -------------- if Padding is required -----------------
  If (BMPPadding <> 0) then
    Begin
      Cnt := 0;
      j := 0;
      imLen := imXsize - 1;

      If Not(FullRange) then begin
        While Cnt < High(pData) do Begin
          if pData[Cnt] > PixMin then
            PixVal := round((pData[Cnt] - PixMin) / ScaleFactor)
          else
            PixVal := 0;
          if PixVal > 255 then
            PixVal := 255;
          DisplayArray[j] := PixVal;
          if Cnt Mod imXsize <> imLen then
            Inc(j, 1)
          else
            Inc(j, BMPPadding);
          Inc(Cnt);
        End; // While
      End  //If (NotFullRange) then begin
        else
      Begin
        While Cnt < High(pData) do Begin
          DisplayArray[j] := pData[Cnt] shr shrFact;
          if Cnt Mod imXsize <> imLen then
            Inc(j, 1)
          else
            Inc(j, BMPPadding);
          Inc(Cnt);
        End; // While
      End;
  End; // If (BMPPadding <> 0)

  End; // Procedure Scale16bitImageToImDispl;

{ ************************************************************************** }
Procedure DrawGrid(Const aCanvas: TCanvas);
var W,H,NrRct,Step,Cnt : Integer;
p : Tpen;
Begin


with aCanvas do begin

aCanvas.Pen.Width := 1;
aCanvas.Pen.Color := WindowGrid.Color;
aCanvas.Pen.Style := WindowGrid.PenStyle;
aCanvas.Pen.Mode  := WindowGrid.PenMode;

W := aCanvas.ClipRect.Width;
H := aCanvas.ClipRect.Height;

NrRct := WindowGrid.NrNodes;
Step := W div NrRct;

for Cnt := 1 to NrRct do begin
  MoveTo(Step*Cnt,0);
  LineTo(Step*Cnt,H);
end;

for Cnt := 1 to NrRct do begin
  MoveTo(0,Step*Cnt);
  LineTo(H,Step*Cnt);
end;


end;

End;

{ ************************************************************************** }

Procedure UpdateMainImage(const DrawEverything : Boolean);
var ClrTblNr    : Integer;
    //Direct2D Vriables
    Dir2DCanvas : TDirect2DCanvas;
    ID2D1BMP    : ID2D1Bitmap; //declared in Winapi.D2D1
    D2DDestRect : TD2DRectF;
Begin

    // Drawing on TImage.Canvas or TImage.Canvas.Picture.Bitmap.Canvas Takes the Same Time //

  if not(RatioOn) and not(ChannelsRatioOn) then begin
    if (ChannelOrder = ASCENDING)   or (NrChannels = 1) then ClrTblNr := 0
      else
    if (ChannelOrder = DESCENDING) and (NrChannels = 2) then ClrTblNr := 2;
  end
    else
  if (RatioOn) or (ChannelsRatioOn) then ClrTblNr := 1;

  {ASCENDING  = 0;
  DESCENDING = 1;    }


  With frmMainWin.winMainImage do Begin

    If (Zoom = 1) then
      StretchDIBits(Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, pImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY)

        Else

    If (Zoom <> 1) and (Direct2D_Supported) and (imXsize <= 16384) and (imYsize <= 16384) Then Begin
      D2DDestRect.Left   := ClientRect.Left; //of winMainImage
      D2DDestRect.Right  := ClientRect.Right;
      D2DDestRect.Top    := ClientRect.Top;
      D2DDestRect.Bottom := ClientRect.Bottom;

      StretchDIBits(IntBMP.Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, pImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY);

      Dir2DCanvas := TDirect2DCanvas.Create(Canvas, ClientRect); //of winMainImage
      Dir2DCanvas.BeginDraw;

      try
        ID2D1BMP := Dir2DCanvas.CreateBitmap(IntBMP);
        Dir2DCanvas.RenderTarget.DrawBitmap(ID2D1BMP,@D2DDestRect); //Draw Direct2D Bitmap

      finally
        Dir2DCanvas.EndDraw;
        Dir2DCanvas.Free;
      end;
    End

      Else

    If (Zoom <> 1) and (not(Direct2D_Supported) or (imXsize > 16384) or (imYsize > 16384)) Then Begin

      if (Zoom = 2) then  begin
        SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
        // Gives Higher Quality - reduices speed by 2-3 times
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shl Zm, imYsize shl Zm, 0,
          0, imXsize, imYsize, pImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY)
      end
        else
      if (Zoom = -2) then begin
        if (imXsize <= 16384) and (imYsize <= 16384) then
          SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE) // Gives Higher Quality - reduices speed by 2-3 times
        else
          SetStretchBltMode(Canvas.Handle, STRETCH_DELETESCANS);

        StretchDIBits(Canvas.Handle, 0, 0, imXsize shr Zm, imYsize shr Zm, 0,
          0, imXsize, imYsize, pImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS,SRCCOPY)
      end;
    End;

    //--------------------------------------------------------------------//
    If (DrawEverything) Then Begin

      if (DiamMesRect.OpCode = IN_TRACKING) then if Not(AnalInAction) then begin
          TrackDiameter;
          with MesLine do
            frmPlayback.lblROIval.Caption := FloatToStrF(GetDistance(LineBeg.x,
                LineBeg.y, LineEnd.x, LineEnd.y), ffFixed, 5, 2) + ' µ';
      end;

      if (ROItracking) then if Not(AnalInAction) then TrackROI;

      If (ROIvar.NrROI > 0) Then DrawROI(Canvas);

      If (SelFrameVisible) or (XYprofileRectVisible) then DrawSelFrame(Canvas);

      if (SizeBarVisible) then DrawScaleBar(Zoom,SizeBar,Canvas);

      If (MesLine.OpCode = DO_EXIST) then
        with MesLine do DrawMesLine(LineBeg.x, LineBeg.y, LineEnd.x, LineEnd.y, Canvas);

      If (NrIm > 1) then Begin
        if (MarkPar.DisplaySmEvents) then
          if (High(MarkSmEvCoor[CurIm]) >= 0)  then DrawSmalEvMarks(Canvas);
        if (MarkPar.DisplayBigEvents) then
          if (High(MarkBigEvCoor[CurIm]) >= 0) then DrawBigEvMarks(Canvas);
      End; // If NrIm > 1

      if WindowGrid.Visible then DrawGrid(Canvas);

    End; //If (DrawEverything)

    if not(DrawEverything) Or ((DrawEverything) and not(SizeBarVisible) and
     not(SelFrameVisible) and (MesLine.OpCode = NOT_EXIST) and (ROIvar.NrROI = 0) and
     not(WindowGrid.Visible))
     then  Repaint;

  End; // with

End; { Procedure UpdateMainImage; }

{ ************************************************************************** }

Procedure UpdateAverImage(const DrawEverything : Boolean);
var ClrTblNr    : Integer; //Color Table Number
    pAvImDispl  : Pointer;
    //Direct2D Vriables
    Dir2DCanvas : TDirect2DCanvas;
    ID2D1BMP    : ID2D1Bitmap; //declared in Winapi.D2D1
    D2DDestRect : TD2DRectF;
Begin

  pAvImDispl := @AvIm8bit[0];

  if (AvImChOrig = 1) then ClrTblNr := 0   //added March 2017
    else
  if (AvImChOrig = 2) then ClrTblNr := 2;

  With frmAverIm.winAverImage do Begin

    if (Zoom = 1) then
        StretchDIBits(Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, pAvImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY)
      Else

   If (Zoom <> 1) and (Direct2D_Supported) and (imXsize <= 16384) and (imYsize <= 16384) Then Begin
      D2DDestRect.Left   := ClientRect.Left; //of winMainImage
      D2DDestRect.Right  := ClientRect.Right;
      D2DDestRect.Top    := ClientRect.Top;
      D2DDestRect.Bottom := ClientRect.Bottom;

      StretchDIBits(IntBMP.Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, pAvImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY);

      Dir2DCanvas := TDirect2DCanvas.Create(Canvas, ClientRect); //of winMainImage
      Dir2DCanvas.BeginDraw;

      try
        ID2D1BMP := Dir2DCanvas.CreateBitmap(IntBMP);
        Dir2DCanvas.RenderTarget.DrawBitmap(ID2D1BMP,@D2DDestRect); //Draw Direct2D Bitmap

      finally
        Dir2DCanvas.EndDraw;
        Dir2DCanvas.Free;
      end;
    End

      Else

     If (Zoom <> 1) and (not(Direct2D_Supported) or (imXsize > 16384) or (imYsize > 16384)) Then Begin
      if (Zoom = 2) then begin
        SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
        // Gives Higher Quality - reduices speed by 2-3 times
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shl Zm, imYsize shl Zm, 0,
          0, imXsize, imYsize, pAvImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS,SRCCOPY)
      end
        else
      if (Zoom = -2) then begin
        if (imXsize <= 16384) and (imYsize <= 16384) then
          SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE) // Gives Higher Quality - reduices speed by 2-3 times
        else
          SetStretchBltMode(Canvas.Handle, STRETCH_DELETESCANS);
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shr Zm, imYsize shr Zm, 0,
        0, imXsize, imYsize, pAvImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS,SRCCOPY)
      end;
    End;
 //--------------------------------------------------------------------//
  If (DrawEverything) Then Begin

    if (ROIvar.NrROI > 0) and (ROIvar.ROIonAverWin) then DrawROI(Canvas);

    if (SizeBarVisible) then DrawScaleBar(Zoom,SizeBar,Canvas);

    if (SelFrameVisible) or (XYprofileRectVisible) then DrawSelFrame(Canvas);

    if (MesLine.OpCode = DO_EXIST) then with MesLine do
      DrawMesLine(LineBeg.x, LineBeg.y, LineEnd.x, LineEnd.y, Canvas);

    If (NrIm > 1) then Begin
      if MarkPar.DisplaySmEvents  then DrawAllSmallEvMarks(Canvas);
      if MarkPar.DisplayBigEvents then DrawAllBigEvMarks(Canvas);
    End; // If NrIm > 1

    if WindowGrid.Visible then DrawGrid(Canvas);

  End; // If (DrawEverything)

  if not(DrawEverything) Or ((DrawEverything) and not(SizeBarVisible) and
     not(SelFrameVisible) and (MesLine.OpCode = NOT_EXIST) and not(WindowGrid.Visible))
  then  Repaint;

  End; // with


End; // Procedure UpdateAverImage;

{******************************************************************************}

Procedure Display2ndChannel;
var   //Direct2D Vriables
    Dir2DCanvas : TDirect2DCanvas;
    ID2D1BMP    : ID2D1Bitmap; //declared in Winapi.D2D1
    D2DDestRect : TD2DRectF;
    ClrTblNr    : Integer;

Begin


    if (ChannelOrder = ASCENDING)  then ClrTblNr := 2
      else
    if (ChannelOrder = DESCENDING) then ClrTblNr := 0;

  With frm2ndWin.win2ndImage do Begin

    if (Zoom = 1) then
        StretchDIBits(Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, p2ndImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY)
      Else

    If (Zoom <> 1) and (Direct2D_Supported) and (imXsize <= 16384) and (imYsize <= 16384) Then Begin
      D2DDestRect.Left   := ClientRect.Left; //of winMainImage
      D2DDestRect.Right  := ClientRect.Right;
      D2DDestRect.Top    := ClientRect.Top;
      D2DDestRect.Bottom := ClientRect.Bottom;

      StretchDIBits(IntBMP.Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, p2ndImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY);

      Dir2DCanvas := TDirect2DCanvas.Create(Canvas, ClientRect); //of winMainImage
      Dir2DCanvas.BeginDraw;

      try
        ID2D1BMP := Dir2DCanvas.CreateBitmap(IntBMP);
        Dir2DCanvas.RenderTarget.DrawBitmap(ID2D1BMP,@D2DDestRect); //Draw Direct2D Bitmap

      finally
        Dir2DCanvas.EndDraw;
        Dir2DCanvas.Free;
      end;
    End

      Else

    If (Zoom <> 1) and (not(Direct2D_Supported) or (imXsize > 16384) or (imYsize > 16384)) Then Begin
      if (Zoom = 2) then begin
        SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
        // Gives Higher Quality - reduices speed by 2-3 times
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shl Zm, imYsize shl Zm, 0,
          0, imXsize, imYsize, p2ndImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS,
          SRCCOPY)
      end
        else
      if (Zoom = -2) then begin
        if (imXsize <= 16384) and (imYsize <= 16384) then
          SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE) // Gives Higher Quality - reduices speed by 2-3 times
        else
          SetStretchBltMode(Canvas.Handle, STRETCH_DELETESCANS);
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shr Zm, imYsize shr Zm, 0,
          0, imXsize, imYsize, p2ndImDispl, lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS,
          SRCCOPY)
      end;
    End;

    if (SelFrameVisible) then DrawSelFrame(Canvas);
    if (SizeBarVisible) then DrawScaleBar(Zoom,SizeBar,Canvas);
    if WindowGrid.Visible then DrawGrid(Canvas);

    if not(SelFrameVisible) and not (SizeBarVisible) and not(WindowGrid.Visible) then Repaint;

  End; // with
End; { Procedure Display2ndChannel; }

{******************************************************************************}

Procedure DisplayMergeImage;
var pDispl : Pointer;
    Pad32bit : Integer;
    //Direct2D Vriables
    Dir2DCanvas : TDirect2DCanvas;
    ID2D1BMP    : ID2D1Bitmap; //declared in Winapi.D2D1
    D2DDestRect : TD2DRectF;
    BitmapProperties : TD2D1BitmapProperties;
Begin

  pDispl := @MergeImDispl[0];

  With frmMergeWin.MergeImage do Begin

    if (Zoom = 1) then
      StretchDIBits(Canvas.Handle, 0, 0, imXsize, imYsize, 0, 0, imXsize,
          imYsize, pDispl, pMergeBMPInfo^, DIB_RGB_COLORS, SRCCOPY)
        Else

    If (Zoom <> 1) and (Direct2D_Supported) and (imXsize <= 16384) and (imYsize <= 16384) Then Begin

      if (imXsize mod 4 = 0) then Pad32bit := 0
      else
      Pad32bit := 4 - (imXsize*4 mod 4);

      D2DDestRect.Left   := ClientRect.Left; //of winMainImage
      D2DDestRect.Right  := ClientRect.Right;
      D2DDestRect.Top    := ClientRect.Top;
      D2DDestRect.Bottom := ClientRect.Bottom;

      BitmapProperties.dpiX := 0;
      BitmapProperties.dpiY := 0;
      BitmapProperties.pixelFormat.format := DXGI_FORMAT_B8G8R8A8_UNORM;
      BitmapProperties.pixelFormat.alphaMode := D2D1_ALPHA_MODE_IGNORE;

      Dir2DCanvas := TDirect2DCanvas.Create(Canvas, ClientRect);//should be before RenderTarget.CreateBitmap

      Dir2DCanvas.RenderTarget.CreateBitmap
     (D2D1SizeU(imXsize,imYsize),pDispl,4*imXsize+Pad32bit,BitmapProperties,ID2D1BMP);

      Dir2DCanvas.BeginDraw;

      try
        Dir2DCanvas.RenderTarget.DrawBitmap(ID2D1BMP,@D2DDestRect); //Draw Direct2D Bitmap
      finally
        Dir2DCanvas.EndDraw;
        Dir2DCanvas.Free;
      end;

    End

      Else

    If (Zoom <> 1) and (not(Direct2D_Supported) or (imXsize > 16384) or (imYsize > 16384)) Then Begin
      if (Zoom = 2) then
      begin
        SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
        // Gives Higher Quality - reduices speed by 2-3 times
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shl Zm, imYsize shl Zm, 0,
          0, imXsize, imYsize, pDispl, pMergeBMPInfo^, DIB_RGB_COLORS,
          SRCCOPY)
      end
      else
        if (Zoom = -2) then
      begin
        if (imXsize <= 16384) and (imYsize <= 16384) then
          SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE) // Gives Higher Quality - reduices speed by 2-3 times
        else
          SetStretchBltMode(Canvas.Handle, STRETCH_DELETESCANS);
        StretchDIBits(Canvas.Handle, 0, 0, imXsize shr Zm, imYsize shr Zm, 0,
          0, imXsize, imYsize, pDispl, pMergeBMPInfo^, DIB_RGB_COLORS,
          SRCCOPY)
      end;
    End;

    if (SelFrameVisible) then DrawSelFrame(Canvas);

    If (MesLine.OpCode = DO_EXIST) then with MesLine do
      DrawMesLine(LineBeg.x, LineBeg.y, LineEnd.x, LineEnd.y, Canvas);

    if (SizeBarVisible) then DrawScaleBar(Zoom,SizeBar,Canvas);

    if WindowGrid.Visible then DrawGrid(Canvas);

    if not(SelFrameVisible) and (MesLine.OpCode = NOT_EXIST) and not(SizeBarVisible) and
    not(WindowGrid.Visible)
    then Repaint;

  End; // with


End; { Procedure DisplayMergeImage; }

  { ************************************************************************** }
  { ******** Begining of Measuring Line and Diameters Measure Procedures ***** }
  { ************************************************************************** }

  // ---------- Measuring Line Only ------------------------------------------]

  Function GetDistance(Const X1, Y1, X2, Y2: Integer): Double;
  Begin

    if (X1 <> X2) and (Y1 <> Y2) then
      Result := sqrt(Sqr(X1 - X2) + Sqr(Y1 - Y2))
    else if (X1 = X2) and (Y1 <> Y2) then
      Result := abs(Y1 - Y2)
    else if (Y1 = Y2) and (X1 <> X2) then
      Result := abs(X1 - X2)
    else if (X1 = X2) and (Y1 = Y2) then
      Result := 0;
    Result := Result * PixSize;
  End; { Function GetDistance(Const X1,Y1,X2,Y2 : integer) : Double; }

  Function GetDistancePix(Const X1, Y1, X2, Y2: Integer): Integer;
  Begin

    if (X1 <> X2) and (Y1 <> Y2) then
      Result := round(sqrt(Sqr(X1 - X2) + Sqr(Y1 - Y2)))
    else if (X1 = X2) and (Y1 <> Y2) then
      Result := abs(Y1 - Y2)
    else if (Y1 = Y2) and (X1 <> X2) then
      Result := abs(X1 - X2)
    else if (X1 = X2) and (Y1 = Y2) then
      Result := 0;
  End; { Function GetDistancePix(Const X1,Y1,X2,Y2 : integer) : Double; }

  { ***************************************************************************** }

  Procedure CalculateMesLineParams(Const MouseX, MouseY: Integer);

  { Follows MouseUp: Calculates Parameters of Measuring Line }

  { Y := Slope*X + B;  -> Y = Round(Y) - Round(Y) = Floor(0.5+Y);
    Simplified: Y(i+1) = slope*X(i+1) + B = Slope(Xi + DeltaX) + B = Yi + Slope*DeltaX;
    if DeltaX = 1 (as it is)
    then Y(i+1) = Yi + Slope;  where Yi is the first Y (Ybeg)
    Slope must be between 0 and 1; if not we must reverse the roles of X and Y
    by assigning a unit step to Y and inctementing X by DeltaX =  DeltaY/Slope = 1/Slope }

  Var
    i: Integer;

    procedure SwapIntegers(var Int1, Int2: Integer);
    begin
      i := Int1;
      Int1 := Int2;
      Int2 := i;
    end;

  Begin

    With MesLine Do
    Begin

      // 1st: Calculates "Real" coordinates and deletes if length < 5 pixels;
      If (OpCode in [IN_DRAWING, IN_MOVING]) Then
      Begin

        if (OpCode = IN_DRAWING) then
        begin
          LineEnd.x := MouseX;
          LineEnd.y := MouseY;
        end
        else if (OpCode = IN_MOVING) then
        begin
          LineBeg.x := LineBeg.x + MouseX;
          LineEnd.x := LineEnd.x + MouseX;
          LineBeg.y := LineBeg.y + MouseY;
          LineEnd.y := LineEnd.y + MouseY;
        end;

        if (Zoom = 2) then
        begin
          LineBeg.x := LineBeg.x shr Zm;
          LineBeg.y := LineBeg.y shr Zm;
          LineEnd.x := LineEnd.x shr Zm;
          LineEnd.y := LineEnd.y shr Zm;
        end
        else if (Zoom = -2) then
        begin
          LineBeg.x := LineBeg.x shl Zm;
          LineBeg.y := LineBeg.y shl Zm;
          LineEnd.x := LineEnd.x shl Zm;
          LineEnd.y := LineEnd.y shl Zm;
        end;

        // kills the Measuring Line if shorter then 5 pixels
        if (abs(LineEnd.x - LineBeg.x) > 5) or (abs(LineEnd.y - LineBeg.y) > 5)
          then
          OpCode := DO_EXIST
        else
          OpCode := NOT_EXIST;
        if (MesLine.OpCode = NOT_EXIST) then
          DiamMesRect.OpCode := NOT_EXIST;

      End; // If (MesLine.OpCode in [IN_DRAWING,IN_MOVING]) Then Begin

      // 2nd: calculates Slope & Intercept
      If (OpCode = DO_EXIST) Then
      Begin

        If abs(LineEnd.x - LineBeg.x) >= abs(LineEnd.y - LineBeg.y) then
        Begin
          if (LineBeg.x > LineEnd.x) then
          begin
            SwapIntegers(LineBeg.x, LineEnd.x);
            if (LineBeg.y <> LineEnd.y) then
              SwapIntegers(LineEnd.y, LineBeg.y);
          end;
          Slope := (LineEnd.y - LineBeg.y) / (LineEnd.x - LineBeg.x);
          // conventional;
          Intercept := LineBeg.y - LineBeg.x * Slope;
          Orientation := MORE_HORIZONTAL;
        End
        Else If abs(LineEnd.x - LineBeg.x) < abs(LineEnd.y - LineBeg.y) then
        Begin
          if (LineBeg.y > LineEnd.y) then
          begin
            SwapIntegers(LineBeg.y, LineEnd.y);
            if (LineBeg.x <> LineEnd.x) then
              SwapIntegers(LineBeg.x, LineEnd.x);
          end;
          Slope := (LineEnd.x - LineBeg.x) / (LineEnd.y - LineBeg.y);
          // reciprocal;
          Intercept := LineBeg.x - LineBeg.y * MesLine.Slope;
          Orientation := MORE_VERTICAL;
        End;

      End; // If (MesLine.OpCode := LINE_DO_EXIST) Then Begin

    End; // With
  End; // Procedure CalculateMesLineParams;

  { *************************************************************************** }
  // --------------- Beginning of Diameter Tracking Procedures ----------------//
  { ************************************************************************** }

  Procedure PrepareForTrackDiameter;

  Type
    TFh = Record
      B: Integer;
      E: Integer;
    End;

  Const
    NO_FIT = 0;
    AT_BEG = 1;
    AT_END = 2;

  var
    i, Addr, MidPoint, BegXorY, EndXorY, End_ROI, LorT_ROI, RorB_ROI, ROIpos,
      ROIposMem: Integer;
    ROI_Width: Array [1 .. 2] of Integer;
    ROI_Beg: Array [1 .. 2] of Integer;
    Fh: TFh;
    Intercept: Double; // this is Not Scaled Intercept
    CntTr, CntLn: Integer;

    Procedure CopyROIs;
    Var
      Addr, CntX, CntY: Integer;

    Begin

      For Addr := 1 to 2 Do
      Begin
        If (ROIvar.ROIAdr[Addr] = 1) then
        Begin
          ROIvar.ROICoor[1, Addr + 2] := ROIvar.ROICoor[1, Addr];
          ROIvar.ROICoor[2, Addr + 2] := ROIvar.ROICoor[2, Addr];
          ROIvar.ROICoor[3, Addr + 2] := ROIvar.ROICoor[3, Addr];
          ROIvar.ROICoor[4, Addr + 2] := ROIvar.ROICoor[4, Addr];
        End
        Else If (ROIvar.ROIAdr[Addr] = 3) then
        Begin
          { updates Y-X table }
          SetLength(FhTbl[Addr + 2], Length(FhTbl[Addr]));
          For CntY := 0 to High(FhTbl[Addr]) do
          begin
            SetLength(FhTbl[Addr + 2, CntY], Length(FhTbl[Addr, CntY]));
            For CntX := 0 to High(FhTbl[Addr, CntY]) do
            Begin
              FhTbl[Addr + 2, CntY, CntX].x := FhTbl[Addr, CntY, CntX].x;
              FhTbl[Addr + 2, CntY, CntX].y := FhTbl[Addr, CntY, CntX].y;
            End;
          End; // For CntY := 0 to High(FhTbl[CurROIadr])
          FhPol[Addr + 2] := nil;
          SetLength(FhPol[Addr + 2], Length(FhPol[Addr]));
          For CntX := 0 to High(FhPol[Addr]) do
          Begin
            FhPol[Addr + 2, CntX].x := FhPol[Addr, CntX].x;
            FhPol[Addr + 2, CntX].y := FhPol[Addr, CntX].y;
          End;
        End; // If (ROIvar.ROIAdr[Addr] = 3) then Begin
      End; // For Addr := 1 to 2 Do Begin
    End; // Procedure CopyROIs;

    Procedure CopyROIdata(Const XLL, Xrr, Yupp, Ydd: Integer); overload;
    // for Rect ROI
    var
      CntTr, Xend, Yend, TrackWidth, CntX, CntY: Integer;

    Begin

      if (Addr = 1) then
        CntTr := DiamMesRect.ROI_1st - 1
      else if (Addr = 2) then
        CntTr := DiamMesRect.ROI_2nd - 1;

      Xend := Xrr - XLL;
      Yend := Ydd - Yupp;
      TrackWidth := Xrr - XLL + 1;
      SetLength(TrackData[CntTr], (Xrr - XLL + 1) * (Ydd - Yupp + 1));

      if BitCount = 8 then
      begin
        for CntY := 0 to Yend Do
          For CntX := 0 to Xend Do // copy data
            TrackData[CntTr, CntX + TrackWidth * CntY] :=
            Im16bitDataTR[(CntX + XLL) + imXsize * (CntY + Yupp)];
      end;
    End; // Procedure CopyROIdata;

    Procedure CopyROIdata(Const Addr: Integer); overload;
    // for Free hand ROI
    var
      Xbeg, CntX, CntY, LenTrackData, CntTr, CntPix: Integer;

    Begin
      // 1st Finds LenTrackData
      LenTrackData := 0;
      For CntY := 0 to High(FhTbl[Addr]) Do
      Begin
        If ( High(FhTbl[Addr, CntY]) > 0) Then
        Begin { more then one Pixel }
          CntX := 0;
          While CntX < High(FhTbl[Addr, CntY]) Do
          Begin
            Inc(LenTrackData, (FhTbl[Addr, CntY, CntX + 1].x - FhTbl[Addr,
                CntY, CntX].x) + 1);
            Inc(CntX, 2);
          End; { while }
        End
        Else { If (High(FhTbl[i,CntY]) > 0) Then Begin }
        If ( High(FhTbl[Addr, CntY]) = 0) Then
        Begin
          Inc(LenTrackData);
        End; { (High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel }
      End; { For CntY := 0 to High(TabFh) do begin }

      if (Addr = 1) then
        CntTr := DiamMesRect.ROI_1st - 1
      else if (Addr = 2) then
        CntTr := DiamMesRect.ROI_2nd - 1;
      SetLength(TrackData[CntTr], LenTrackData);

      // 2nd copies pixels values
      Xbeg := 0;
      For CntY := 0 to High(FhTbl[Addr]) Do Begin
        If ( High(FhTbl[Addr, CntY]) > 0) Then Begin // more then one Pixel
          CntX := 0;
          while CntX < High(FhTbl[Addr, CntY]) do begin
            for CntPix := FhTbl[Addr, CntY, CntX].x to FhTbl[Addr, CntY,CntX + 1].x do
              TrackData[CntTr, Xbeg + (CntPix - FhTbl[Addr, CntY, CntX].x)]
                  := Im16bitDataTR[CntPix + imXsize * FhTbl[Addr, CntY, CntX].y];
              Inc(Xbeg, (FhTbl[Addr, CntY, CntX + 1].x - FhTbl[Addr, CntY,CntX].x) + 1);
              Inc(CntX, 2);
            end; // while
        End
          Else // If (High(FhTbl[i,CntY]) > 0) Then Begin
        If ( High(FhTbl[Addr, CntY]) = 0) Then Begin
            TrackData[CntTr, Xbeg] := Im16bitDataTR[FhTbl[Addr, CntY,0].X + imXsize * FhTbl[Addr, CntY, 0].y];
          Inc(Xbeg);
        End; // (High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel
      End; // For CntY := 0 to High(TabFh) do begin
      // End of Copying Pixels
    End; // Procedure CopyROIdata;

Procedure GetROIpos; //used in Diameter Measure
var Beg_Cross, End_Cross, Ycnt: Integer;
Begin
      // Beg & End & LorT & RorB are the most extreme coordinates of ROI
      // 1st: check if Beg (X [horiz] or Y [horiz] are within limits
      if (ROI_Beg[Addr] > BegXorY) and (End_ROI < MidPoint) then
        ROIpos := AT_BEG
      else if (ROI_Beg[Addr] > MidPoint) and (End_ROI < EndXorY) then
        ROIpos := AT_END
      else
        ROIpos := NO_FIT;
      // 2nd: check if Top & Bot [horiz] or Left & Right [vertical] are within limits
      if (ROIpos in [AT_BEG, AT_END]) then
      begin
        // finds Y of Line that crosses the ROY at Xl and Xr
        Beg_Cross := round(MesLine.Slope * ROI_Beg[Addr] + Intercept);
        End_Cross := round(MesLine.Slope * End_ROI + Intercept);

        if Not((Beg_Cross > LorT_ROI) and (Beg_Cross < RorB_ROI) or
            (End_Cross > LorT_ROI) and (End_Cross < RorB_ROI)) then
        begin
          ROIpos := NO_FIT;
        end
        else
        Begin
          // For Free hand it Finds precisely where Center Line Crosses ROI
          // Rectangular are Not Corrected;
          If (ROIvar.ROIAdr[Addr] = 3) Then
          Begin

            If (MesLine.Orientation = MORE_HORIZONTAL) then
            Begin
              // 1st: Find exactly the Intersect bewtween line and Left side of free hand ROI
              for Ycnt := 0 to High(FhTbl[Addr]) do
              begin
                if abs(FhTbl[Addr, Ycnt,
                  0].y - round(MesLine.Slope * FhTbl[Addr, Ycnt,
                    0].x + Intercept)) <= 1 then
                begin
                  ROI_Beg[Addr] := FhTbl[Addr, Ycnt, 0].x;
                  Break;
                end;
              end;
              // 2nd: Find exactly the Intersect bewtween line and Right side of free hand ROI
              for Ycnt := 0 to High(FhTbl[Addr]) do
              begin
                if abs(FhTbl[Addr, Ycnt,
                  0].y - round(MesLine.Slope * FhTbl[Addr, Ycnt,
                    High(FhTbl[Addr, Ycnt])].x + Intercept)) <= 1 then
                begin
                  End_ROI := FhTbl[Addr, Ycnt, High(FhTbl[Addr, Ycnt])].x;
                  Break;
                end;
              end;
            End
            Else // If (MesLine.Orientation =  MORE_HORIZONTAL)

              If (MesLine.Orientation = MORE_VERTICAL) then
            Begin
              // 1st: Find exactly the Intersect bewtween line and Top side of free hand ROI
              for Ycnt := 0 to High(FhTbl[Addr]) - 1 do
              begin
                if (FhTbl[Addr, Ycnt, 0].x <= round(MesLine.Slope * FhTbl[Addr,
                    Ycnt, 0].y + Intercept)) and
                  (FhTbl[Addr, Ycnt, High(FhTbl[Addr, Ycnt])].x > round
                    (MesLine.Slope * FhTbl[Addr, Ycnt, 0].y + Intercept)
                  ) then
                begin
                  ROI_Beg[Addr] := FhTbl[Addr, Ycnt, 0].y;
                  Break;
                end;
              end;
              // 2nd: Find exactly the Intersect bewtween line and Bottom side of free hand ROI
              for Ycnt := High(FhTbl[Addr]) downto 1 do
              begin
                if (FhTbl[Addr, Ycnt, 0].x <= round(MesLine.Slope * FhTbl[Addr,
                    Ycnt, 0].y + Intercept)) and
                  (FhTbl[Addr, Ycnt, High(FhTbl[Addr, Ycnt])].x > round
                    (MesLine.Slope * FhTbl[Addr, Ycnt, 0].y + Intercept)
                  ) then
                begin
                  End_ROI := FhTbl[Addr, Ycnt, 0].y;
                  Break;
                end;
              end;
            End; // If (MesLine.Orientation =  MORE_VERTICAL)

            ROI_Width[Addr] := End_ROI - ROI_Beg[Addr] + 1;
          End; // If (ROIvar.ROIAdr[Addr] = 3)

        End; // else
      end; // if (ROIpos in [AT_BEG,AT_END]) then begin
    End; // Procedure GetROIpos;

    procedure ConstructBinaryImage;
    var CntX,CntY,CntPix,CntPos,LinesNr,CntLn,Xbeg,Xend,Ybeg,Yend,CntTrLoc : Integer;
    Begin
       //Constructs Binary Image
    SetLength(BinaryImage,imXsize*imYsize);
    for CntPix := 0 to High(BinaryImage) do BinaryImage[CntPix] := 0;
    LinesNr := High(TrackPath[0]); // since the Number is the same we use here Beg ROI Track [0]

    FOR CntLn := 0 to LinesNr DO
    BEGIN // Counts Lines in Each Track

      FOR CntTrLoc := 0 TO 1 DO
      BEGIN // Counts ROI Each Track is for One ROI

        // Sets the Addr to the Hidden (Addr + 2) Copies of ROIs
        if (CntTrLoc = 0) then
          Addr := DiamMesRect.ROI_1st + 2
        else if (CntTrLoc = 1) then
          Addr := DiamMesRect.ROI_2nd + 2;
   
        // ------------ Free Hand ROI -----------------------//
        If (ROIvar.ROIAdr[Addr-2] = 3) Then Begin
          For CntPos := 0 to High(TrackPath[CntTrLoc, CntLn]) Do Begin
            Xbeg := 0;
            For CntY := 0 to High(FhTbl[Addr]) Do Begin
              If ( High(FhTbl[Addr, CntY]) > 0) Then Begin // more then one Pixel//
                CntX := 0;
                  While CntX < High(FhTbl[Addr, CntY]) Do Begin
                    for CntPix := FhTbl[Addr, CntY, CntX].X to FhTbl[Addr,CntY, CntX + 1].X do begin
                      BinaryImage[(CntPix + TrackPath[CntTrLoc,CntLn, CntPos].X) + imXsize * (FhTbl[Addr, CntY,
                          CntX].y + TrackPath[CntTrLoc, CntLn, CntPos].Y)] := Addr-2;
                    end; // for CntPix := FhTbl[Addr, CntY, CntX].x to FhTbl[Addr,CntY, CntX + 1].x do begin

                    Inc(Xbeg, (FhTbl[Addr, CntY, CntX + 1].x - FhTbl[Addr,CntY, CntX].X) + 1);
                    Inc(CntX, 2);
                  End; // While
                End
                  Else // If (High(FhTbl[i,CntY]) > 0) Then Begin
                If ( High(FhTbl[Addr, CntY]) = 0) Then Begin
                  BinaryImage[(FhTbl[Addr, CntY,0].X + TrackPath[CntTrLoc, CntLn, CntPos].X) + imXsize *
                      (FhTbl[Addr, CntY, 0].Y + TrackPath[CntTrLoc,CntLn,CntPos].Y)] := Addr-2;
                  Inc(Xbeg);
                End; // If (High(FhTbl[Addr,CntY]) = 0)  Single Pixel
            End; // For CntY := 0 to High(TabFh) do begin
          End; // For CntPos  := 0 to High(TrackPath[CntTr,CntLn]) Do Begin
        End
           Else // If (ROIvar.ROIAdr[Addr-2] = 3) Then Begin

        // If Rectangle ROI
        If (ROIvar.ROIAdr[Addr] = 1) Then Begin
          Xbeg := ROIvar.ROICoor[1, Addr];
          Ybeg := ROIvar.ROICoor[2, Addr];
          Xend := ROIvar.ROICoor[3, Addr] - ROIvar.ROICoor[1, Addr];
          Yend := ROIvar.ROICoor[4, Addr] - ROIvar.ROICoor[2, Addr];
          For CntPos := 0 to High(TrackPath[CntTr, CntLn]) Do Begin
            For CntY := 0 to Yend Do begin
              For CntX := 0 to Xend do begin// goes through all pixels
                BinaryImage[(Xbeg + CntX + TrackPath[CntTr, CntLn,
                      CntPos].x) + imXsize * (Ybeg + CntY + TrackPath[CntTr,
                      CntLn, CntPos].y)] := Addr-2;
              End;
            End;
          End; // For CntPos  := 0 to High(TrackPath[CntTr,CntLn])
        End; // (Rectangle ROI) If (ROIvar.ROIAdr[Addr-2] = 1) Then Begin
        // --------- End of Rectangle ROI ----------//
      END; // For CntTr := 0 to 1 do Begin

    END; // FOR CntLn := 0 to LinesNr DO BEGIN

    End;  // procedure ConstructBinaryImage;

    Procedure CreateTrackAreaTableOneAndTwo;
    var CntX,CntY,Xbeg,Xend,GenCnt,PixCount,CntPix : Integer; //GenCnt = General Counter
    Begin

    //1st: Sets TrackRect
      TrackRect.Left   := imXsize;
      TrackRect.Right  := 0;
      TrackRect.Top    := imYsize;
      TrackRect.Bottom := 0;
      for CntY := 0 to imYsize-1 do begin
        for CntX := 0 to imXsize-1 do begin
          if (BinaryImage[CntX + imXsize*CntY] > 0) then begin
            if (TrackRect.Left   > CntX) then TrackRect.Left   := CntX;
            if (TrackRect.Right  < CntX) then TrackRect.Right  := CntX;
            if (TrackRect.Top    > CntY) then TrackRect.Top    := CntY;
            if (TrackRect.Bottom < CntY) then TrackRect.Bottom := CntY;
          end;
        end;
      end;

    //2nd: Finds the the number Raws (here PixCount) for TrackAreaTableOne array
      YtopOff[0] := -1;
      GenCnt := 0;
      for CntY := 0 to imYsize-1 do begin
        Xbeg := 0;
        for CntX := 0 to imXsize-1 do begin
          if (BinaryImage[CntX + imXsize*CntY] = 1) then begin
            if (YtopOff[0] = -1) then YtopOff[0] := CntY;
            if (Xbeg = 0) then Inc(GenCnt);
            Xbeg := 1; //used here as a Boolean
          end;
        end;
      end;
      SetLength(TrackAreaTableOne,GenCnt);

      YtopOff[1] := -1;
      GenCnt := 0;
      for CntY := 0 to imYsize-1 do begin
        Xbeg := 0;
        for CntX := 0 to imXsize-1 do begin
          if (BinaryImage[CntX + imXsize*CntY] = 2) then begin
            if (YtopOff[1] = -1) then YtopOff[1] := CntY;
            if (Xbeg = 0) then Inc(GenCnt);
            Xbeg := 1; //used here as a Boolean
          end;
        end;
      end;
      SetLength(TrackAreaTableTwo,GenCnt);

      //3rd: Fills TrackAreaTableOne and Two
      Xbeg := imXsize;
      Xend := 0;
      GenCnt := 0;
      for CntY := 0 to imYsize-1 do begin
        for CntX := 0 to imXsize-1 do begin
          if (BinaryImage[CntX + imXsize*CntY] = 1) then begin
            if (Xbeg > CntX) then Xbeg := CntX;
            if (Xend < CntX) then Xend := CntX;
          end;
        end;
        if (Xend > 0) then begin //if line contained pixel = 1
          TrackAreaTableOne[GenCnt].Xb := Xbeg;
          TrackAreaTableOne[GenCnt].Xe := Xend;
          Inc(GenCnt);
          Xbeg := imXsize;
          Xend := 0;
        end;
      end;

      Xbeg := imXsize;
      Xend := 0;
      GenCnt := 0;
      for CntY := 0 to imYsize-1 do begin
        for CntX := 0 to imXsize-1 do begin
          if (BinaryImage[CntX + imXsize*CntY] = 2) then begin
            if (Xbeg > CntX) then Xbeg := CntX;
            if (Xend < CntX) then Xend := CntX;
          end;
        end;
        if (Xend > 0) then begin //if line contained pixel = 1
          TrackAreaTableTwo[GenCnt].Xb := Xbeg;
          TrackAreaTableTwo[GenCnt].Xe := Xend;
          Inc(GenCnt);
          Xbeg := imXsize;
          Xend := 0;
        end;
      end;

      //4th: Finds the the number pixels for TrackAreaOne array
      GenCnt := 0;
      for CntX := 0 to High(TrackAreaTableOne) do begin
        Inc(GenCnt,TrackAreaTableOne[CntX].Xe - TrackAreaTableOne[CntX].Xb + 1);
      end;
      SetLength(TrackAreaOne,GenCnt);

      GenCnt := 0;
      for CntX := 0 to High(TrackAreaTableTwo) do begin
        Inc(GenCnt,TrackAreaTableTwo[CntX].Xe - TrackAreaTableTwo[CntX].Xb + 1);
      end;
      SetLength(TrackAreaTwo,GenCnt);

      //5th Fill TrackAreaOne
      PixCount := 0;
      for CntY := 0 to High(TrackAreaTableOne) do begin
        for CntX := TrackAreaTableOne[CntY].Xb to TrackAreaTableOne[CntY].Xe do begin
         TrackAreaOne[PixCount] := Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])];
         Inc(PixCount);   //with frmMainWin.winMainImage.Canvas do Pixels[CntX,CntY] := clRed;
        end;
      end;

      PixCount := 0;
      for CntY := 0 to High(TrackAreaTableTwo) do begin
        for CntX := TrackAreaTableTwo[CntY].Xb to TrackAreaTableTwo[CntY].Xe do begin
          TrackAreaTwo[PixCount] := Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[1])];
          Inc(PixCount);  // with frmMainWin.winMainImage.Canvas do Pixels[CntX,CntY] := clBlue;
        end;
      end;

     GetMeanStdDevLimits(TrackAreaOne,TrackAreaMeans.First,1,3,2);
     GetMeanStdDevLimits(TrackAreaTwo,TrackAreaMeans.Second,1,3,2);

    End; //Procedure CreateTrackAreaTableOneAndTwo
  //-----end of Vars and Procedures ------------//

  Begin // Begin of Main Procedure

    // 1st: Check for ROI number: must be two and ROI 1 and 2 are allowed
    If (ROIvar.NrROI = 2) and (ROIvar.ROIAdr[1] > 0) and (ROIvar.ROIAdr[2] > 0)
      Then
    Begin

      // 2nd: Calculate some parameters
      If (MesLine.Orientation = MORE_HORIZONTAL) then
      Begin
        // Y := Round(MesLine.Slope*X + Intercept);
        MidPoint := (MesLine.LineEnd.x - MesLine.LineBeg.x)
          div 2 + MesLine.LineBeg.x;
        BegXorY := MesLine.LineBeg.x - DiamMesRect.OffsXorYbeg;
        EndXorY := MesLine.LineEnd.x + DiamMesRect.OffsXorYend;
        Intercept := MesLine.LineBeg.y - MesLine.LineBeg.x * MesLine.Slope;
      End
      Else If (MesLine.Orientation = MORE_VERTICAL) then
      Begin
        // X := Round(MesLine.Slope*Y + Intercept);
        MidPoint := (MesLine.LineEnd.y - MesLine.LineBeg.y)
          div 2 + MesLine.LineBeg.y;
        BegXorY := MesLine.LineBeg.y - DiamMesRect.OffsXorYbeg;
        EndXorY := MesLine.LineEnd.y + DiamMesRect.OffsXorYend;
        Intercept := MesLine.LineBeg.x - MesLine.LineBeg.y * MesLine.Slope;
      End;

      // 3rd; Check if ROIs are whithin Track Line
      For Addr := 1 to 2 do
      Begin

        If (MesLine.Orientation = MORE_HORIZONTAL) then
        Begin
          If (ROIvar.ROIAdr[Addr] = 1) then
          Begin
            ROI_Beg[Addr] := ROIvar.ROICoor[1, Addr];
            End_ROI := ROIvar.ROICoor[3, Addr];
            LorT_ROI := ROIvar.ROICoor[2, Addr];
            RorB_ROI := ROIvar.ROICoor[4, Addr];
          End
          Else If (ROIvar.ROIAdr[Addr] = 3) Then
          Begin
            LorT_ROI := FhTbl[Addr, 0, 0].y;
             RorB_ROI := FhTbl[Addr, High(FhTbl[Addr]), 0].y;
            ROI_Beg[Addr] := imXsize; // just a max value
            End_ROI := 0; // just a min value
            For i := 0 to High(FhTbl[Addr]) do
            begin
              if ROI_Beg[Addr] > FhTbl[Addr, i, 0].x then
              begin
                ROI_Beg[Addr] := FhTbl[Addr, i, 0].x;
                Fh.B := FhTbl[Addr, i, 0].y;
              end;
              if End_ROI < FhTbl[Addr, i, High(FhTbl[Addr, i])].x then
              begin
                End_ROI := FhTbl[Addr, i, High(FhTbl[Addr, i])].x;
                Fh.E := FhTbl[Addr, i, High(FhTbl[Addr, i])].y;
              end;
            End;
          End;

        End
        Else If (MesLine.Orientation = MORE_VERTICAL) then
        Begin
          If (ROIvar.ROIAdr[Addr] = 1) then
          Begin
            ROI_Beg[Addr] := ROIvar.ROICoor[2, Addr];
            End_ROI := ROIvar.ROICoor[4, Addr];
            LorT_ROI := ROIvar.ROICoor[1, Addr];
            RorB_ROI := ROIvar.ROICoor[3, Addr];
          End
          Else If (ROIvar.ROIAdr[Addr] = 3) Then
          Begin
            ROI_Beg[Addr] := FhTbl[Addr, 0, 0].y;
            Fh.B := FhTbl[Addr, 0, 0].x;
            End_ROI := FhTbl[Addr, High(FhTbl[Addr]), 0].y;
            Fh.E := FhTbl[Addr, High(FhTbl[Addr]), 0].x;
            LorT_ROI := imYsize; // just a max value
            RorB_ROI := 0; // just a min value
            For i := 0 to High(FhTbl[Addr]) do
            begin
              if LorT_ROI > FhTbl[Addr, i, 0].x then
              begin
                LorT_ROI := FhTbl[Addr, i, 0].x;
              end;
              if RorB_ROI < FhTbl[Addr, i, High(FhTbl[Addr, i])].x then
              begin
                RorB_ROI := FhTbl[Addr, i, High(FhTbl[Addr, i])].x;
              end;
            End; // For CntY := 0 to High(FhTbl[CurROIadr])
          End;
        End; // If (MesLine.Orientation =  MORE_VERTICAL)

        If (ROIvar.ROIAdr[Addr] = 3) Then
        Begin
          // Correct Beg & End by getting the intersection point between Beg % End with the Mes Line
          ROI_Beg[Addr] := round
            ((MesLine.Slope * Fh.B + ROI_Beg[Addr]
                - Intercept * MesLine.Slope) /
              (MesLine.Slope * MesLine.Slope + 1));
          End_ROI := round
            ((MesLine.Slope * Fh.E + End_ROI - Intercept *
                MesLine.Slope) / (MesLine.Slope * MesLine.Slope + 1));
        End;

        if (Addr = 1) or ((Addr = 2) and (ROIpos > NO_FIT)) then
          GetROIpos;
        if (Addr = 1) then
        begin
          if (ROIpos > NO_FIT) then
            ROIposMem := ROIpos
          else if (ROIpos = NO_FIT) then
            Break;
        end;

      End; // For Addr := 1 to 2 do Begin
      // --- End of 3rd ---

      if Not((ROIpos > NO_FIT) and (ROIpos <> ROIposMem)) then
        MessageDlg('Position properly ROIs', mtError, [mbOK], 0)
      else

      // --- End of CheckUps - Starts to Prepare For Tracking Diameter ---//

        If (ROIpos > NO_FIT) and (ROIpos <> ROIposMem) then
      Begin

        // 4th: Set which one is the Located at beg and which at the end
        if (ROIposMem = AT_BEG) then
        begin
          DiamMesRect.ROI_1st := 1;
          DiamMesRect.ROI_2nd := 2;
        end
        else
        begin
          DiamMesRect.ROI_1st := 2;
          DiamMesRect.ROI_2nd := 1;
        end;

        // 5th: create X,Y array for moving ROIs

        with DiamMesRect do
          SetLength(TrackPath, 2, 2 * HalfWitdh + 1); // [0] is the Track X,Y for Beg ROI, [1] is for the End ROI
        // Number of Lines = 2 x HalfWitdh + 1 (the Middle One)

        // Set First array and Later the Rest
        SetLength(TrackPath[0, 0],
          MidPoint - BegXorY + 1 - ROI_Width[DiamMesRect.ROI_1st]);
        // for Beg ROI
        SetLength(TrackPath[1, 0],
          EndXorY - MidPoint + 1 - ROI_Width[DiamMesRect.ROI_2nd]);
        // for End ROI

        for i := 0 to High(TrackPath[0]) do
          SetLength(TrackPath[0, i], Length(TrackPath[0, 0]));
        for i := 0 to High(TrackPath[1]) do
          SetLength(TrackPath[1, i], Length(TrackPath[1, 0]));

        with DiamMesRect do begin
          If (MesLine.Orientation = MORE_HORIZONTAL) then
          Begin
            // 1st: set the Middle Scan Line (could be only one)
            for i := BegXorY to MidPoint - ROI_Width[ROI_1st] do
            begin
              TrackPath[0, HalfWitdh, i - BegXorY].x := i - ROI_Beg[ROI_1st];
              TrackPath[0, HalfWitdh, i - BegXorY].y := round
                (MesLine.Slope * TrackPath[0, HalfWitdh, i - BegXorY].x);
            end;
            for i := MidPoint to EndXorY - ROI_Width[ROI_2nd] do
            begin
              TrackPath[1, HalfWitdh, i - MidPoint].x := i - ROI_Beg[ROI_2nd];
              TrackPath[1, HalfWitdh, i - MidPoint].y := round
                (MesLine.Slope * TrackPath[1, HalfWitdh, i - MidPoint].x);
            end;
            // 2nd: set the rest of the lines for Y coordinate
            if (HalfWitdh > 0) then
            begin

              for CntTr := 0 to 1 do
              begin
                for CntLn := 0 to HalfWitdh - 1 do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].y := TrackPath[CntTr, HalfWitdh,
                      i].y - (HalfWitdh - CntLn);
                  end;
                end;
                for CntLn := HalfWitdh + 1 to High(TrackPath[CntTr]) do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].y := TrackPath[CntTr, HalfWitdh,
                      i].y + (CntLn - HalfWitdh);
                  end;
                end;
              end;
              // 3rd: set the rest of the lines for X coordinate
              for CntTr := 0 to 1 do
              begin
                for CntLn := 0 to HalfWitdh - 1 do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].x := TrackPath[CntTr, HalfWitdh,
                      i].x - round(MesLine.Slope * (TrackPath[CntTr, CntLn,
                        i].y - TrackPath[CntTr, HalfWitdh, i].y)
                        - MesLine.Slope);
                  end;
                end;
                for CntLn := HalfWitdh + 1 to High(TrackPath[CntTr]) do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].x := TrackPath[CntTr, HalfWitdh,
                      i].x - round(MesLine.Slope * (TrackPath[CntTr, CntLn,
                        i].y - TrackPath[CntTr, HalfWitdh, i].y)
                        - MesLine.Slope);
                  end;
                end;
              end;
            end; // if (HalfWitdh > 0) then begin

          End
          Else If (MesLine.Orientation = MORE_VERTICAL) then
          Begin
            // 1st: set the Middle Scan Line (could be only one)
            for i := BegXorY to MidPoint - ROI_Width[ROI_1st] do
            begin
              TrackPath[0, HalfWitdh, i - BegXorY].y := i - ROI_Beg[ROI_1st];
              TrackPath[0, HalfWitdh, i - BegXorY].x := round
                (MesLine.Slope * TrackPath[0, HalfWitdh, i - BegXorY].y);
            end;
            for i := MidPoint to EndXorY - ROI_Width[ROI_2nd] do
            begin
              TrackPath[1, HalfWitdh, i - MidPoint].y := i - ROI_Beg[ROI_2nd];
              TrackPath[1, HalfWitdh, i - MidPoint].x := round
                (MesLine.Slope * TrackPath[1, HalfWitdh, i - MidPoint].y);
            end;
            // 2nd: set the rest of the lines for X coordinate
            if (HalfWitdh > 0) then
            begin

              for CntTr := 0 to 1 do
              begin
                for CntLn := 0 to HalfWitdh - 1 do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].x := TrackPath[CntTr, HalfWitdh,
                      i].x - (HalfWitdh - CntLn);
                  end;
                end;
                for CntLn := HalfWitdh + 1 to High(TrackPath[CntTr]) do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].x := TrackPath[CntTr, HalfWitdh,
                      i].x + (CntLn - HalfWitdh);
                  end;
                end;
              end;
              // 3rd: set the rest of the lines for Y coordinate
              for CntTr := 0 to 1 do
              begin
                for CntLn := 0 to HalfWitdh - 1 do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].y := TrackPath[CntTr, HalfWitdh,
                      i].y - round(MesLine.Slope * (TrackPath[CntTr, CntLn,
                        i].x - TrackPath[CntTr, HalfWitdh, i].x)
                        - MesLine.Slope);
                  end;
                end;
                for CntLn := HalfWitdh + 1 to High(TrackPath[CntTr]) do
                begin
                  for i := 0 to High(TrackPath[CntTr, CntLn]) do
                  begin
                    TrackPath[CntTr, CntLn, i].y := TrackPath[CntTr, HalfWitdh,
                      i].y - round(MesLine.Slope * (TrackPath[CntTr, CntLn,
                        i].x - TrackPath[CntTr, HalfWitdh, i].x)
                        - MesLine.Slope);
                  end;
                end;
              end;
            end;
          End;
        end; // with DiamMesRect
        // End of 5th

        // 6th: Copy ROIs to ROIs with Address = Address + 2; They will hold the Original ROI Position
        CopyROIs;

        // 7th: Copy Pixels values to Double Array (one dimensional)
        //copy 8bit or 16 bit to one array for simplicity (introduced April, 2015
        If (SmoothMode <> NO_SMOOTH) And (SmoothNonRatio = SMOOTH_Ch_ONE) then begin
          SetLength(Im16bitDataTR,Length(Im16bitDataSM_Last));
          for i := 0 to High(Im16bitDataSM_Last) do Im16bitDataTR[i] := Im16bitDataSM_Last[i];
        End
        Else
        If (SmoothMode = NO_SMOOTH) Or (SmoothNonRatio = NO_SMOOTH_NON_RATIO) then Begin
        if (BitCount = 8) then begin
          SetLength(Im16bitDataTR,Length(Im8bitData));
          for i := 0 to High(Im8bitData) do Im16bitDataTR[i] := Im8bitData[i];
        end
          else
        if (BitCount = 16) then begin
          SetLength(Im16bitDataTR,Length(Im16bitData));
          for i := 0 to High(Im16bitData) do Im16bitDataTR[i] := Im16bitData[i];
        end;
        End; //If (SmoothMode = NO_SMOOTH) Or (SmoothNonRatio = NO_SMOOTH_NON_RATIO) then Begin

        SetLength(TrackData, 2);
        For Addr := 1 to 2 Do
        Begin
          if (ROIvar.ROIAdr[Addr] = 1) then
            with ROIvar do
              CopyROIdata(ROICoor[1, Addr], ROICoor[3, Addr], ROICoor[2, Addr],
                ROICoor[4, Addr])
            else if (ROIvar.ROIAdr[Addr] = 3) then
              CopyROIdata(Addr);
        End;

        // 8th: Copies the Original Measuring Line begining and End
        DiamMesRect.LineBegOrig := MesLine.LineBeg;
        DiamMesRect.LineEndOrig := MesLine.LineEnd;

        // 9th: Sets Operation Code to Tracking
        DiamMesRect.OpCode := IN_TRACKING;

        ConstructBinaryImage;
        CreateTrackAreaTableOneAndTwo;


      End; // Passed all Checks - If (ROIpos > NO_FIT) and (ROIpos <> ROIposMem) then Begin
    End
    Else // If (ROIvar.NrROI = 2) and (ROIvar.ROIAdr[1] > 0) and (ROIvar.ROIAdr[2] > 0) Then Begin

      MessageDlg('Two ROIs should be used only, number one and number two',
        mtError, [mbOK], 0);

  End; // Procedure PrepareForTrackDiameter;

  { ************************************************************************** }
  Procedure TrackDiameter;
  // Track Diameter for One Image; it Should be Called for Every Image//

  var
    CntPos, CntX, CntY, Xbeg, Ybeg, CntPix, Addr, CntTr, CntLn,LinesNr: Integer;
    Xend, Yend: Integer;

    TrackWidth: Integer; // Rect ROI widht= delta X = Xr - Xl + 1

    TempChi, ChiLoc: Double; // Temp and Local Chi
    Chi: array of Double; // Stores the Abs(ChiROIbeg - ChiROIend) for each Line
    XYnewPos: array of array of TPoint;
    TrackAreaMeansLC : TTrackAreaMeans;
    ScaleFactOne,ScaleFactTwo : Double;

  Begin

    FillTrackArea;

    //finds Mean Val for this image and compares it for the Selected
    GetMeanStdDevLimits(TrackAreaOne,TrackAreaMeansLC.First,1,3,2);
    GetMeanStdDevLimits(TrackAreaTwo,TrackAreaMeansLC.Second,1,3,2);

    If (TrackAreaMeansLC.First <> TrackAreaMeans.First) then Begin
      ScaleFactOne := TrackAreaMeans.First/TrackAreaMeansLC.First;
      for CntY := 0 to High(TrackAreaTableOne) do begin
        for CntX := TrackAreaTableOne[CntY].Xb to TrackAreaTableOne[CntY].Xe do begin
          Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])] := Round(Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])]*ScaleFactOne);
        end;
      end;
    End;

    If (TrackAreaMeansLC.Second <> TrackAreaMeans.Second) then Begin
      ScaleFactTwo := TrackAreaMeans.Second/TrackAreaMeansLC.Second;
      for CntY := 0 to High(TrackAreaTableTwo) do begin
        for CntX := TrackAreaTableTwo[CntY].Xb to TrackAreaTableTwo[CntY].Xe do begin
          Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[1])] := Round(Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[1])]*ScaleFactTwo);
        end;
      end;
    End;

    LinesNr := High(TrackPath[0]); // since the Number is the same we use here Beg ROI Track [0]

    SetLength(Chi, LinesNr + 1);
    SetLength(XYnewPos, 2, LinesNr + 1);

    FOR CntLn := 0 to LinesNr DO
    BEGIN // Counts Lines in Each Track

      FOR CntTr := 0 TO 1 DO
      BEGIN // Counts ROI Each Track is for One ROI

        // --------- Begining of Tracking for One ROI ----------//

        // Sets the Addr to the Hidden (Addr + 2) Copies of ROIs
        if (CntTr = 0) then
          Addr := DiamMesRect.ROI_1st + 2
        else if (CntTr = 1) then
          Addr := DiamMesRect.ROI_2nd + 2;

        ChiLoc := High(Integer);

        // ------------ Free Hand ROI -----------------------//

        If (ROIvar.ROIAdr[Addr - 2] = 3) Then
        Begin

          For CntPos := 0 to High(TrackPath[CntTr, CntLn]) Do Begin

            // ---------- Compares pixels ----------//

            TempChi := 0;
            Xbeg := 0;

            For CntY := 0 to High(FhTbl[Addr]) Do Begin
              If ( High(FhTbl[Addr, CntY]) > 0) Then Begin // more then one Pixel//
                CntX := 0;
                  While CntX < High(FhTbl[Addr, CntY]) Do Begin
                    for CntPix := FhTbl[Addr, CntY, CntX].x to FhTbl[Addr,CntY, CntX + 1].x do begin

                      TempChi := TempChi + abs(TrackData[CntTr, Xbeg + (CntPix - FhTbl[Addr, CntY,CntX].X)] -
                      Im16bitDataTR[(CntPix + TrackPath[CntTr,CntLn, CntPos].X) + imXsize * (FhTbl[Addr, CntY,
                          CntX].y + TrackPath[CntTr, CntLn, CntPos].Y)]);

                    end; // for CntPix := FhTbl[Addr, CntY, CntX].x to FhTbl[Addr,CntY, CntX + 1].x do begin

                    Inc(Xbeg, (FhTbl[Addr, CntY, CntX + 1].x - FhTbl[Addr,
                        CntY, CntX].x) + 1);
                    Inc(CntX, 2);
                  End; // While
                End
                  Else // If (High(FhTbl[i,CntY]) > 0) Then Begin
                If ( High(FhTbl[Addr, CntY]) = 0) Then Begin
                  TempChi := TempChi + abs(TrackData[CntTr,
                    Xbeg] - Im16bitDataTR[(FhTbl[Addr, CntY,0].X + TrackPath[CntTr, CntLn, CntPos].X) + imXsize *
                      (FhTbl[Addr, CntY, 0].Y + TrackPath[CntTr,CntLn,CntPos].Y)]);

                  Inc(Xbeg);
                End; // If (High(FhTbl[Addr,CntY]) = 0)  Single Pixel
            End; // For CntY := 0 to High(TabFh) do begin

            // end of comparing pixels

            // tracks the lowest Chi//
            if ChiLoc > TempChi then
            begin
              ChiLoc := TempChi;
              XYnewPos[CntTr, CntLn] := TrackPath[CntTr, CntLn, CntPos];
            end;

          End; // For CntPos  := 0 to High(TrackPath[CntTr,CntLn]) Do Begin

        End
           Else // If (ROIvar.ROIAdr[Addr-2] = 3) Then Begin

        // Rectangle ROI
        If (ROIvar.ROIAdr[Addr - 2] = 1) Then Begin

          Xbeg := ROIvar.ROICoor[1, Addr];
          Ybeg := ROIvar.ROICoor[2, Addr];
          Xend := ROIvar.ROICoor[3, Addr] - ROIvar.ROICoor[1, Addr];
          Yend := ROIvar.ROICoor[4, Addr] - ROIvar.ROICoor[2, Addr];
          TrackWidth := Xend + 1;

          For CntPos := 0 to High(TrackPath[CntTr, CntLn]) Do Begin

            // ---------- Compares pixels ----------//

            TempChi := 0;

            For CntY := 0 to Yend Do begin
              For CntX := 0 to Xend do begin// goes through all pixels
                TempChi := TempChi + abs(TrackData[CntTr,CntX + TrackWidth * CntY] -
                  Im16bitDataTR[(Xbeg + CntX + TrackPath[CntTr, CntLn,
                      CntPos].x) + imXsize * (Ybeg + CntY + TrackPath[CntTr,
                      CntLn, CntPos].y)]);
              End;
            End;
            // tracks the lowest Chi//
            if ChiLoc > TempChi then begin
              ChiLoc := TempChi;
              XYnewPos[CntTr, CntLn] := TrackPath[CntTr, CntLn, CntPos];
            end;

          End; // For CntPos  := 0 to High(TrackPath[CntTr,CntLn])

        End; // (Rectangle ROI) If (ROIvar.ROIAdr[Addr-2] = 1) Then Begin

        // --------- End of Rectangle ROI ----------//


        // --------- End of Tracking for One ROI ----------//

        if (CntTr = 0) then
          Chi[CntLn] := ChiLoc
        else
          Chi[CntLn] := (ChiLoc + Chi[CntLn]);

        // ---- End of Process the Tracking Data for One ROI -----//

      END; // For CntTr := 0 to 1 do Begin

    END; // FOR CntLn := 0 to LinesNr DO BEGIN

    // Finds the minimum Chi from all the lines
    ChiLoc := Chi[0];
    CntLn := 0;
    if (LinesNr > 0) then
      for CntPos := 1 to LinesNr do
      begin
        if ChiLoc > Chi[CntPos] then
        begin
          ChiLoc := Chi[CntPos];
          CntLn := CntPos;
        end;
      end;
    // the Above Statement Returns CntLn wich Gives the Minimum Chi//

    If (XYnewPos[0, CntLn].x <> 0) or (XYnewPos[0, CntLn].y <> 0) or
      (XYnewPos[1, CntLn].x <> 0) or (XYnewPos[1, CntLn].y <> 0) Then
    Begin

      // Updates MesLine - All Coordinates Must be updated
      with MesLine do
      Begin
        with DiamMesRect do Begin
          LineBeg.x := LineBegOrig.x + XYnewPos[0, CntLn].x;
          LineBeg.y := LineBegOrig.y + XYnewPos[0, CntLn].y;
          LineEnd.x := LineEndOrig.x + XYnewPos[1, CntLn].x;
          LineEnd.y := LineEndOrig.y + XYnewPos[1, CntLn].y;
        end;
      end;

      // Updates the Two ROIs
      For CntTr := 0 to 1 Do
      Begin
        if (CntTr = 0) then
          Addr := DiamMesRect.ROI_1st + 2
        else if (CntTr = 1) then
          Addr := DiamMesRect.ROI_2nd + 2;

        if (ROIvar.ROIAdr[Addr - 2] = 3) then
        begin // updates free hand ROI
          // updates free hand ROI Polygon
          for CntX := 0 to High(FhPol[Addr]) do
          begin
            FhPol[Addr - 2, CntX].x := FhPol[Addr, CntX].x + XYnewPos[CntTr,
              CntLn].x;
            FhPol[Addr - 2, CntX].y := FhPol[Addr, CntX].y + XYnewPos[CntTr,
              CntLn].y;
          end;
         
        end
        else // for bXs := 0 to High(FhPol[CurROIadr])
          if (ROIvar.ROIAdr[Addr - 2] = 1) then
        begin // updates Rectangle ROI
          ROIvar.ROICoor[1, Addr - 2] := ROIvar.ROICoor[1,
            Addr] + XYnewPos[CntTr, CntLn].x;
          ROIvar.ROICoor[2, Addr - 2] := ROIvar.ROICoor[2,
            Addr] + XYnewPos[CntTr, CntLn].y;
          ROIvar.ROICoor[3, Addr - 2] := ROIvar.ROICoor[3,
            Addr] + XYnewPos[CntTr, CntLn].x;
          ROIvar.ROICoor[4, Addr - 2] := ROIvar.ROICoor[4,
            Addr] + XYnewPos[CntTr, CntLn].y;
        end;
      End;

    End; // If Any Pos is Different;

  End; // Procedure TrackDiameter;

  // ------------- End of Diameter Tracking Procedures -----------------------//
{*******************************************************************************}
procedure FillTrackArea; inline;
var CntX,CntY,PixCount : Integer;
Begin
//Fills in the Track Area Only in the TrackRect
    If (SmoothMode <> NO_SMOOTH) And (SmoothNonRatio = SMOOTH_Ch_ONE) then begin
       For CntY := TrackRect.Top to TrackRect.Bottom Do Begin
        For CntX := TrackRect.Left to TrackRect.Right Do Begin
          Im16bitDataTR[CntX + imXsize*CntY] := Im16bitDataSM_Last[CntX + imXsize*CntY];
        End;
       End;
    End
      Else
    If (SmoothMode = NO_SMOOTH) Or (SmoothNonRatio = NO_SMOOTH_NON_RATIO) then Begin
     If (BitCount = 8) Then Begin
       For CntY := TrackRect.Top to TrackRect.Bottom Do Begin
        For CntX := TrackRect.Left to TrackRect.Right Do Begin
          Im16bitDataTR[CntX + imXsize*CntY] := Im8bitData[CntX + imXsize*CntY];
        End;
      End;
     End
       Else
     If (BitCount = 16) Then Begin
       For CntY := TrackRect.Top to TrackRect.Bottom Do Begin
        For CntX := TrackRect.Left to TrackRect.Right Do Begin
          Im16bitDataTR[CntX + imXsize*CntY] := Im16bitData[CntX + imXsize*CntY];
        End;
       End;
     End;
    End; //If (SmoothMode = NO_SMOOTH) Or (SmoothNonRatio = NO_SMOOTH_NON_RATIO)

    //Fill TrackAreaOne
    If (ROItracking) or (DiamMesRect.OpCode = IN_TRACKING) then Begin
      PixCount := 0;
      for CntY := 0 to High(TrackAreaTableOne) do begin
        for CntX := TrackAreaTableOne[CntY].Xb to TrackAreaTableOne[CntY].Xe do begin
         TrackAreaOne[PixCount] := Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])];
         Inc(PixCount);
        end;
      end;
    End;

   If (DiamMesRect.OpCode = IN_TRACKING) then Begin
      PixCount := 0;
      for CntY := 0 to High(TrackAreaTableTwo) do begin
        for CntX := TrackAreaTableTwo[CntY].Xb to TrackAreaTableTwo[CntY].Xe do begin
          TrackAreaTwo[PixCount] := Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[1])];
          Inc(PixCount);
        end;
      end;
    End;

End; //procedure FillTrackArea; inline;

{****************************************************************************}

procedure TrackROI;
  var
    CntX, CntY, Xbeg, CntPix,  Xpos, Ypos : Integer;
    TempChi, ChiGlob : Double; // Temp and Global Chi
    XYnewPos: TPoint;
    TrackAreaMean : Double;
    ScaleFact : Double;

  Begin

    FillTrackArea;

    //finds Mean Val for this image and compares it for the Selected
    GetMeanStdDevLimits(TrackAreaOne,TrackAreaMean,1,3,2);

    If (TrackAreaMean <> TrackAreaMeans.First) then Begin
      ScaleFact := TrackAreaMeans.First/TrackAreaMean;
      for CntY := 0 to High(TrackAreaTableOne) do begin
        for CntX := TrackAreaTableOne[CntY].Xb to TrackAreaTableOne[CntY].Xe do begin
          Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])] := Round(Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])]*ScaleFact);
        end;
      end;
    End;

    //-----------  Starts Tracking -----------------------//
    ChiGlob := High(Integer);

    For Xpos := -XtolBeg to XtolEnd Do Begin
      For Ypos := -YtolBeg to YtolEnd Do Begin
        TempChi := 0;
        Xbeg    := 0;
        // ----------------- One Position Begin -------------------------------//
        For CntY := 0 to High(FhTblTr) Do Begin
          If ( High(FhTblTr[CntY]) > 0) Then Begin // more then one Pixel
            CntX := 0;
            While CntX < High(FhTblTr[CntY]) Do Begin
              for CntPix := FhTblTr[CntY, CntX].x to FhTblTr[CntY, CntX + 1].x Do
                TempChi := TempChi +
                Abs(TrackROIdata[Xbeg + (CntPix - FhTblTr[CntY, CntX].x)]
                    - Im16bitDataTR[(CntPix + Xpos) + imXsize * (FhTblTr[CntY,CntX].y + Ypos)]);

              Inc(Xbeg, (FhTblTr[CntY, CntX + 1].x - FhTblTr[CntY, CntX].x) + 1);
              Inc(CntX, 2);
            End; // while
          End //If ( High(FhTblTr[CntY]) > 0) Then Begin // more then one Pixel
            Else
          If ( High(FhTblTr[CntY]) = 0) Then Begin
             TempChi := TempChi + Abs(TrackROIdata[Xbeg] -
             Im16bitDataTR[(FhTblTr[CntY,0].X+Xpos)+imXsize*(FhTblTr[CntY,0].Y+Ypos)]);
            Inc(Xbeg);
          End; // If(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel
        End; // For CntY := 0 to High(TabFh) do begin

        // ----------------- One Position Done -------------------------------//

        If (ChiGlob > TempChi) then Begin
          ChiGlob := TempChi;
          XYnewPos.x := Xpos;
          XYnewPos.y := Ypos;
        End;

        // ------------------------------------------------//
      End;
    End;
    // ------------------------------------------------//

    // Updates Polygon of Free hand ROI addr 1 (red)
    For CntX := 0 to High(FhPol[1]) do
    Begin
      FhPol[1, CntX].x := FhPolTr[CntX].x + XYnewPos.x;
      FhPol[1, CntX].y := FhPolTr[CntX].y + XYnewPos.y
    End;

    { Updates  Y-X table of Free hand ROI addr 1 (red) }
    For CntY := 0 to High(FhTbl[1]) do
    begin
      For CntX := 0 to High(FhTbl[1, CntY]) do
      Begin
        FhTbl[1, CntY, CntX].x := FhTblTr[CntY, CntX].x + XYnewPos.x;
        FhTbl[1, CntY, CntX].y := FhTblTr[CntY, CntX].y + XYnewPos.y;
      End;
    End; // For CntY := 0 to High(FhTbl[CurROIadr])

    // updates Rectangle ROI with address 2 = Blue
    ROIvar.ROICoor[1, 2] := ROICoorMem[1] + XYnewPos.x;
    ROIvar.ROICoor[2, 2] := ROICoorMem[2] + XYnewPos.y;
    ROIvar.ROICoor[3, 2] := ROICoorMem[3] + XYnewPos.x;
    ROIvar.ROICoor[4, 2] := ROICoorMem[4] + XYnewPos.y;

  End;
  { ************************************************************************** }

  Procedure ScaleOffsXorYbegToReal; // to Real (non Zoomed) coordinates
  Begin

    with DiamMesRect do
    begin
      if (Zoom = 2) then
      begin
        OffsXorYbeg := OffsXorYbeg shr Zm;
        OffsXorYend := OffsXorYend shr Zm;
      end
      else if (Zoom = -2) then
      begin
        OffsXorYbeg := OffsXorYbeg shl Zm;
        OffsXorYend := OffsXorYend shl Zm;
      end;
    end; // with
  End;

  { *************************************************************************** }
  Procedure ScaleOffsXorYbegToCurrent; // to current Zoom coordinates
  Begin

    with DiamMesRect do
    begin
      if (Zoom = 2) then
      begin
        OffsXorYbeg := OffsXorYbeg shl Zm;
        OffsXorYend := OffsXorYend shl Zm;
      end
      else if (Zoom = -2) then
      begin
        OffsXorYbeg := OffsXorYbeg shr Zm;
        OffsXorYend := OffsXorYend shr Zm;
      end;
    end; // with
  End;
  { ************************************************************************** }

  Procedure CalculateOffsXorYbeg(MesLineXorYbeg, MesLineXorYend: Integer);
  { Follows MouseUp after Resizing the Diameter Measuring Rectangle }
  Begin

    if (Zoom = 2) then begin
      MesLineXorYbeg := MesLineXorYbeg shl Zm;
      MesLineXorYend := MesLineXorYend shl Zm;
    end
    else if (Zoom = -2) then begin
      MesLineXorYbeg := MesLineXorYbeg shr Zm;
      MesLineXorYend := MesLineXorYend shr Zm;
    end;

    with DiamMesRect do begin
      if (MesLine.Orientation = MORE_HORIZONTAL) then
      begin
        OffsXorYbeg := MesLineXorYbeg - RectBeg.x;
        OffsXorYend := RectEnd.x - MesLineXorYend;
      end
      else if (MesLine.Orientation = MORE_VERTICAL) then begin
        OffsXorYbeg := MesLineXorYbeg - RectBeg.y;
        OffsXorYend := RectEnd.y - MesLineXorYend;
      end;
    end; // with

  End;

  { ************************************************************************** }
  // Works!! Not Used So far
  function Negate32(Para: Integer): Integer;
  assembler;
asm
  neg eax
end;
  { ************************************************************************** }

    Procedure SetDiamMesRectBegAndEnd(MesLineXorY_BegOrEnd: Integer;
      var DiamMesRectXorY_BegOrEnd, OffsXorY_BegOrEnd: Integer;
      Const dXorYpr: Integer);
    Begin

      if (Zoom = 2) then
        MesLineXorY_BegOrEnd := MesLineXorY_BegOrEnd shl Zm
      else if (Zoom = -2) then
        MesLineXorY_BegOrEnd := MesLineXorY_BegOrEnd shr Zm;

      if (DiamMesRect.OpCode = BEG_SEL) then
        DiamMesRectXorY_BegOrEnd := MesLineXorY_BegOrEnd - OffsXorY_BegOrEnd + dXorYpr
      else if (DiamMesRect.OpCode = END_SEL) then
        DiamMesRectXorY_BegOrEnd := MesLineXorY_BegOrEnd + OffsXorY_BegOrEnd + dXorYpr;

    End;
  { ************************************************************************** }

    Procedure SetDiamMesRect(Xbeg, Ybeg, Xend, Yend: Integer);

    Var
      i: Integer;
      LocOffsXorYbeg, LocOffsXorYend, HalfW: Integer; // local offsets

      procedure SwapIntegers(var Int1, Int2: Integer);
      begin
        i := Int1;
        Int1 := Int2;
        Int2 := i;
      end;

    Begin

      With DiamMesRect Do Begin

        if (OpCode in [TO_RESET, SET_WIDTH]) then
          HalfWitdh := frmImageControl.enDiamMesRectWidth.NumberOne shr 1;
        // initial setting ; Non Scalled Half Width

        // HalfW is the Scaled HalfWidth
        if (Zoom = 1) then
          HalfW := HalfWitdh
        else if (Zoom = 2) then
          HalfW := HalfWitdh shl Zm
        else if (Zoom = -2) then
          HalfW := HalfWitdh shr Zm;

        if (OpCode = DO_EXIST) or (ZoomCurrent <> Zoom) or (ZmCurrent <> Zm) then
        begin
          // if ZoomCurrent <> Zoom to Scale it When is in Tracking Mode
          if (Zoom = 1) then
          begin
            LocOffsXorYbeg := OffsXorYbeg;
            LocOffsXorYend := OffsXorYend;
          end
          else if (Zoom = 2) then
          begin
            LocOffsXorYbeg := OffsXorYbeg shl Zm;
            LocOffsXorYend := OffsXorYend shl Zm;
          end
          else if (Zoom = -2) then
          begin
            LocOffsXorYbeg := OffsXorYbeg shr Zm;
            LocOffsXorYend := OffsXorYend shr Zm;
          end;
        end;

        If (MesLine.Orientation = MORE_HORIZONTAL) Then Begin
          DiagOffset := round(MesLine.Slope * HalfW - MesLine.Slope);

          if (Xbeg > Xend) then
          begin
            SwapIntegers(Xbeg, Xend);
            if (Ybeg <> Yend) then
              SwapIntegers(Ybeg, Yend);
          end;

          if (OpCode = TO_RESET) then
          begin
            // initially sets them equally
            OffsXorYbeg := Xend - Xbeg;
            OffsXorYend := OffsXorYbeg;
            LocOffsXorYbeg := OffsXorYbeg;
            LocOffsXorYend := OffsXorYend;
            ScaleOffsXorYbegToReal;
          end;

          if (MesLine.OpCode in [IN_MOVING, IN_DRAWING]) or (DiamMesRect.OpCode = TO_RESET) or
             (ZoomCurrent <> Zoom) or (ZmCurrent <> Zm) then
          begin
            Intercept := Ybeg - Xbeg * MesLine.Slope;
            RectBeg.x := Xbeg - LocOffsXorYbeg;
            RectEnd.x := Xend + LocOffsXorYend;
            ZoomCurrent := Zoom;
            ZmCurrent   := Zm;
          end
          else
          begin
            if (RectBeg.x > Xbeg - 1) then
              RectBeg.x := Xbeg - 1;
            if (RectEnd.x < Xend + 1) then
              RectEnd.x := Xend + 1;
          end;

          RectBeg.y := round(MesLine.Slope * RectBeg.x + Intercept);
          RectEnd.y := round(MesLine.Slope * RectEnd.x + Intercept);

          PolygonArr[0].x := RectBeg.x + DiagOffset;
          PolygonArr[0].y := RectBeg.y - HalfW;

          PolygonArr[1].x := RectEnd.x + DiagOffset;
          PolygonArr[1].y := RectEnd.y - HalfW;

          PolygonArr[2].x := RectEnd.x - DiagOffset;
          PolygonArr[2].y := RectEnd.y + HalfW;

          PolygonArr[3].x := RectBeg.x - DiagOffset;
          PolygonArr[3].y := RectBeg.y + HalfW;

        End
        Else

          If (MesLine.Orientation = MORE_VERTICAL) then
        Begin

          DiagOffset := round(MesLine.Slope * HalfW - MesLine.Slope);

          if (Ybeg > Yend) then
          begin
            SwapIntegers(Ybeg, Yend);
            if (Xbeg <> Xend) then
              SwapIntegers(Xbeg, Xend);
          end;

          if (DiamMesRect.OpCode = TO_RESET) then
          begin
            // initially sets then equally
            OffsXorYbeg := Yend - Ybeg;
            OffsXorYend := OffsXorYbeg;
            LocOffsXorYbeg := OffsXorYbeg;
            LocOffsXorYend := OffsXorYend;
            ScaleOffsXorYbegToReal;
          end;

          if (MesLine.OpCode in [IN_MOVING, IN_DRAWING]) or (DiamMesRect.OpCode = TO_RESET) or
             (ZoomCurrent <> Zoom) or ( ZmCurrent <> Zm) then
          begin
            Intercept := Xbeg - Ybeg * MesLine.Slope;
            RectBeg.y := Ybeg - LocOffsXorYbeg;
            RectEnd.y := Yend + LocOffsXorYend;
            ZoomCurrent := Zoom;
            ZmCurrent   := Zm;
          end
          else
          begin
            if (RectBeg.y > Ybeg - 1) then
              RectBeg.y := Ybeg - 1;
            if (RectEnd.y < Yend + 1) then
              RectEnd.y := Yend + 1;
          end;

          RectBeg.x := round(MesLine.Slope * RectBeg.y + Intercept);
          RectEnd.x := round(MesLine.Slope * RectEnd.y + Intercept);

          PolygonArr[0].x := RectBeg.x - HalfW;
          PolygonArr[0].y := RectBeg.y + DiagOffset;

          PolygonArr[1].x := RectEnd.x - HalfW;
          PolygonArr[1].y := RectEnd.y + DiagOffset;

          PolygonArr[2].x := RectEnd.x + HalfW;
          PolygonArr[2].y := RectEnd.y - DiagOffset;

          PolygonArr[3].x := RectBeg.x + HalfW;
          PolygonArr[3].y := RectBeg.y - DiagOffset;

        End;

        if Not(OpCode in [BEG_SEL, END_SEL, IN_TRACKING]) then
          OpCode := DO_EXIST;

      End; // With

    End; // End of Procedure SetDiamMesRect(Xbeg,Ybeg,Xend,Yend : Integer);

  { ************************************************************************** }

Procedure DrawMesLine(Xbeg, Ybeg, Xend, Yend: Integer; Const aCanvas: TCanvas);
    { Draws Measuring Line on Image Window }
    { Xbeg,Ybeg,Xend,Yend here are used as local variables; do not use them as Const or Var }
Var i, CapsWitdh : Integer;
Begin

      // First Draws the Measuring Line

      // rescalles Real Coordinates to Current window
      // other modes are already rescalled
      if (MesLine.OpCode = DO_EXIST) then begin
        if (Zoom = 2) then begin
          Xbeg := Xbeg shl Zm;
          Ybeg := Ybeg shl Zm;
          Xend := Xend shl Zm;
          Yend := Yend shl Zm;
        end
        else if (Zoom = -2) then begin
          Xbeg := Xbeg shr Zm;
          Ybeg := Ybeg shr Zm;
          Xend := Xend shr Zm;
          Yend := Yend shr Zm;
        end;
      end;

  If ((Xbeg <> Xend) or (Ybeg <> Yend)) Then Begin //introduced Feb 8, 2018 because in Windows 10 Mouse Down frequently triggered Mouse Move
  //without moving which leads to division by Zero in paragraph below

      // 2nd: Calculates Slope for Caps or Diam Mes Rect if needed

      If (MesLineVar.CapsWitdh > 0) or ((MesLine.OpCode in [IN_MOVING,IN_DRAWING])
          and (DiamMesRect.OpCode = DO_EXIST)) Then
      Begin

        if (Zoom = 1) then
          CapsWitdh := MesLineVar.CapsWitdh
        else if (Zoom = 2) then
          CapsWitdh := MesLineVar.CapsWitdh shl Zm
        else if (Zoom = -2) then
          CapsWitdh := MesLineVar.CapsWitdh shr Zm;

        // Calculates Current Slope and Orientation

        If (MesLine.OpCode = IN_DRAWING) Then Begin
          If abs(Xend - Xbeg) >= abs(Yend - Ybeg) then Begin
            MesLine.Slope := (Yend - Ybeg) / (Xend - Xbeg); // conventional;
            MesLine.Orientation := MORE_HORIZONTAL;
          End
            Else
          If abs(Xend - Xbeg) < abs(Yend - Ybeg) then Begin
            MesLine.Slope := (Xend - Xbeg) / (Yend - Ybeg); // reciprocal;
            MesLine.Orientation := MORE_VERTICAL;
          End;
        End
          Else // If (MesLine.OpCode <> LINE_MOVING)
        If (MesLine.OpCode = IN_MOVING) Then Begin
          if (MesLine.Orientation = MORE_HORIZONTAL) then
            DiamMesRect.Intercept := Ybeg - Xbeg * MesLine.Slope
          else if (MesLine.Orientation = MORE_VERTICAL) then
            DiamMesRect.Intercept := Xbeg - Ybeg * MesLine.Slope;
        End;

      End; // If (MesLineVar.CapsWitdh > 0) or ((MesLine.OpCode in [IN_MOVING,IN_DRAWING]) and (DiamMesRect.OpCode = DO_EXIST))

      If (DiamMesRect.OpCode <> NOT_EXIST) Then Begin

        if ((MesLine.OpCode in [IN_MOVING, IN_DRAWING]) and (DiamMesRect.OpCode = DO_EXIST)) Or
          (DiamMesRect.ZoomCurrent <> Zoom) Or (DiamMesRect.ZmCurrent <> Zm) Or
          (DiamMesRect.OpCode in [TO_RESET, BEG_SEL, END_SEL, SET_WIDTH]) then
          SetDiamMesRect(Xbeg, Ybeg, Xend, Yend);

        // draws Diam Measuring Rectangle
        aCanvas.Pen.Color := RGB(160, 160, 160);
        aCanvas.Pen.Width := 1;
        aCanvas.Pen.Mode := pmXOR;
        aCanvas.Polygon(DiamMesRect.PolygonArr);
        aCanvas.Pen.Mode := pmCopy;
        // Draws Center Line - Temp
        aCanvas.MoveTo(DiamMesRect.RectBeg.x, DiamMesRect.RectBeg.y);
        aCanvas.LineTo(DiamMesRect.RectEnd.x, DiamMesRect.RectEnd.y);

      End; // If (DiamMesRect.OpCode <> NOT_EXIST) Then Begin

      aCanvas.Pen.Color := MesLineVar.Color;
      aCanvas.Pen.Width := MesLineVar.Thickness;
      // Drowes Line
      aCanvas.MoveTo(Xbeg, Ybeg);
      aCanvas.LineTo(Xend, Yend);

      // Draws Line Caps
      If (MesLineVar.CapsWitdh > 0) then
      begin
        if (MesLine.Orientation = MORE_HORIZONTAL) then
        begin
          i := round(MesLine.Slope * CapsWitdh - MesLine.Slope);
          aCanvas.MoveTo(Xend + i, Yend - CapsWitdh);
          aCanvas.LineTo(Xend - i, Yend + CapsWitdh);
          aCanvas.MoveTo(Xbeg + i, Ybeg - CapsWitdh);
          aCanvas.LineTo(Xbeg - i, Ybeg + CapsWitdh);
        end
        else if (MesLine.Orientation = MORE_VERTICAL) then
        begin
          i := round(MesLine.Slope * CapsWitdh - MesLine.Slope);
          aCanvas.MoveTo(Xend + CapsWitdh, Yend - i);
          aCanvas.LineTo(Xend - CapsWitdh, Yend + i);
          aCanvas.MoveTo(Xbeg + CapsWitdh, Ybeg - i);
          aCanvas.LineTo(Xbeg - CapsWitdh, Ybeg + i);
        end;
      End;

  End; //If ((Xbeg <> Xend) or (Ybeg <> Yend)) Then Begin

End; // Procedure DrawMesLine   {Draws ROIs on Image Window}
  { ************************************************************************** }

Procedure CheckIfMesDiamSelected(MouseX, MouseY: Integer);
    Var
      XorYcalc: Integer;
      XorYbeg: Integer;
      XorYend: Integer;
      HalfW: Integer; // Scaled halfWidth
    Begin

      DiamMesRect.OpCode := DO_EXIST;

      With DiamMesRect Do
      begin

        // HalfW is the Scaled HalfWidth
        if (Zoom = 1) then
          HalfW := HalfWitdh
        else if (Zoom = 2) then
          HalfW := HalfWitdh shl Zm
        else if (Zoom = -2) then
          HalfW := HalfWitdh shr Zm;

        If (MesLine.Orientation = MORE_HORIZONTAL) then
        Begin
          // Check the Loose X Limits
          If (MouseX >= (RectBeg.x - abs(DiagOffset)) - MesLine.SelTol) and
            (MouseX <= (RectEnd.x + abs(DiagOffset)) + MesLine.SelTol) then
          Begin
            // Calculates Y
            XorYcalc := round(MesLine.Slope * MouseX + Intercept);
            If (abs(XorYcalc - MouseY) < MesLine.SelTol + HalfW) Then
            Begin
              // calculates X that precisely corresponds to MouseY //
              XorYbeg := RectBeg.x - round
                (MesLine.Slope * (MouseY - RectBeg.y) - MesLine.Slope);
              XorYend := RectEnd.x - round
                (MesLine.Slope * (MouseY - RectEnd.y) - MesLine.Slope);
              if (abs(XorYbeg - MouseX) < MesLine.SelTol) then
                OpCode := BEG_SEL
              else if (abs(XorYend - MouseX) < MesLine.SelTol) then
                OpCode := END_SEL;
            End;
          End;
        End
        Else
        Begin // if ((MesLine.Orientation = MORE_VERTICAL)
          // Check the Loose Y Limits
          If (MouseY >= (RectBeg.y - abs(DiagOffset)) - MesLine.SelTol) and
            (MouseY <= (RectEnd.y + abs(DiagOffset)) + MesLine.SelTol) then
          Begin
            // Calculates X
            XorYcalc := round(MesLine.Slope * MouseY + Intercept);
            If (abs(XorYcalc - MouseX) < MesLine.SelTol + HalfW) Then
            Begin
              // calculates Y that precisely corresponds to MouseX //
              XorYbeg := RectBeg.y - round
                (MesLine.Slope * (MouseX - RectBeg.x) - MesLine.Slope);
              XorYend := RectEnd.y - round
                (MesLine.Slope * (MouseX - RectEnd.x) - MesLine.Slope);
              if (abs(XorYbeg - MouseY) < MesLine.SelTol) then
                OpCode := BEG_SEL
              else if (abs(XorYend - MouseY) < MesLine.SelTol) then
                OpCode := END_SEL;
            End;
          End;
        End;

      End; // With DiamMesRect Do begin
    End;
  { ************************************************************************** }

    Procedure CheckIfMesLineSelected(MouseX, MouseY: Integer);

    Var
      XorYcalc: Integer;

    Begin

      MesLine.OpCode := DO_EXIST;

      if (Zoom = 2) then
      begin
        MouseX := MouseX shr Zm;
        MouseY := MouseY shr Zm;
      end
      else if (Zoom = -2) then
      begin
        MouseX := MouseX shl Zm;
        MouseY := MouseY shl Zm;
      end;

      With MesLine Do Begin

        If (Orientation = MORE_HORIZONTAL) then
        Begin
          // Check the Loose X Limits
          If (MouseX >= LineBeg.x - SelTol) and (MouseX <= LineEnd.x + SelTol)
            then
          Begin
            // Calculates Y
            XorYcalc := round(Slope * MouseX + Intercept);
            If (abs(XorYcalc - MouseY) < SelTol) Then
            Begin
              if (MouseX >= LineBeg.x + SelTol) and
                (MouseX <= LineEnd.x - SelTol) then
                OpCode := MIDDLE_SEL
              else
              begin
                if (MouseX < LineBeg.x + SelTol) then
                  OpCode := BEG_SEL
                else if (MouseX > LineEnd.x - SelTol) then
                  OpCode := END_SEL;
              end;
            End;
          End;
        End
        Else
        Begin // if ((MesLine.Orientation = MORE_VERTICAL)
          If (MouseY >= LineBeg.y - SelTol) and (MouseY <= LineEnd.y + SelTol)
            then
          Begin
            XorYcalc := round(MesLine.Slope * MouseY + Intercept);
            // in fact Calculates X
            If (abs(XorYcalc - MouseX) < SelTol) Then
            Begin
              if (MouseY >= LineBeg.y + SelTol) and
                (MouseY <= LineEnd.y - SelTol) then
                OpCode := MIDDLE_SEL
              else
              begin
                if (MouseY < LineBeg.y + SelTol) then
                  OpCode := BEG_SEL
                else if (MouseY > LineEnd.y - SelTol) then
                  OpCode := END_SEL;
              end;
            End;
          End;
        End;

      End; // With
    End; // End of Procedure CheckIfMesLineSelected

  { ************************************************************************** }
  { ************   End of Measuring Line and Diameters Measure Procedures ***** }
  { ************************************************************************** }

Function GetMeanROIAverIm(Const AnyAvIm: TDynDoubleArray;
                          Const XLL, Xrr, Yupp, Ydd, KindROI: Integer): Double;

    var
      CntX, CntY, NrElem: Integer;

    Begin

      NrElem := (Xrr - XLL + 1) * (Ydd - Yupp + 1);
      Result := 0;

      for CntY := Yupp to Ydd do
        For CntX := XLL to Xrr do
          Result := Result + AnyAvIm[CntX + imXsize * CntY];
      { Bkg already Subtr }

      if (KindROI = 1) then Result := Result / NrElem;

End; { Function GetMeanROIAverIm : Double; }
  { ************************************************************************** }

Function GetNrElemAboveThres(Const XLL, Xrr, Yupp, Ydd: Integer;
                             Const AnyData: TDynByteArray): Integer;
{Returns the Number of Pixels >= Threshold in the Time Series Plot
 Used for Free Hand ROI Only }

var
CntX, CntY, enThreshForArea,NrElemAboveThres : Integer;
Begin

  Result := 0;
  enThreshForArea := frmTimeSerPlot.enThreshForArea.NumberOne;

  for CntY := Yupp to Ydd do begin
    for CntX := XLL to Xrr do begin
      if (AnyData[CntX + imXsize * CntY] >= enThreshForArea) then
      Inc(Result);
    end;
  end;
End;
  { ************************************************************************** }
Function GetNrElemAboveThres(Const XLL, Xrr, Yupp, Ydd: Integer;
                             Const AnyData: TDynWordArray): Integer;
{Returns the Number of Pixels >= Threshold in the Time Series Plot
 Used for Free Hand ROI Only }

var
CntX, CntY, enThreshForArea,NrElemAboveThres : Integer;
Begin

  Result := 0;
  enThreshForArea := frmTimeSerPlot.enThreshForArea.NumberOne;

  for CntY := Yupp to Ydd do begin
    for CntX := XLL to Xrr do begin
      if (AnyData[CntX + imXsize * CntY] >= enThreshForArea) then
      Inc(Result);
    end;
  end;

End;
 { ************************************************************************** }

Function GetMeanROIforTimeSerAnal(Const XLL, Xrr, Yupp, Ydd: Integer;
                                  Const KindROI: Integer; Const AnyAvIm: TDynDoubleArray;
                                  Const AnyIntData: TDynByteArray): Double;
    { Does Independently All Kinds of Analysis; Controlled By Time Series Plot }
    { Make Ratio on ROI only to Increase Speed; If ROI are Big the speed will slower }

    var
      CntX, CntY, NrElem,enThreshForArea,NrElemAboveThres,PixPos : Integer;
      TemResult : Double;

    Begin

      NrElem := (Xrr - XLL + 1) * (Ydd - Yupp + 1);
      Result := 0;

      { For Non-Ratioed Images  }
      If Not(RatioOn) Then Begin
        If (frmTimeSerPlot.enThreshForArea.NumberOne = 0) Then Begin
          for CntY := Yupp to Ydd do
            for CntX := XLL to Xrr do
              Result := Result + AnyIntData[CntX + imXsize * CntY];
          if KindROI = 1 then Result := Result / NrElem;
        End
          Else
        Begin
          NrElemAboveThres := 0;
          enThreshForArea := frmTimeSerPlot.enThreshForArea.NumberOne;
          for CntY := Yupp to Ydd do begin
            for CntX := XLL to Xrr do begin
            PixPos := CntX + imXsize * CntY;
              if (AnyIntData[PixPos] >= enThreshForArea) then begin
                Result := Result + AnyIntData[PixPos];
                if (KindROI = 1) then Inc(NrElemAboveThres);
              end;
            end;
          end;
          if (KindROI = 1) and (NrElemAboveThres > 0) then Result := Result / NrElemAboveThres;
        End;  //Else Begin
      End
      { (RatioOn = False) }

        Else

      { --------------- For Ratioed Images ----------------------- }
      If (RatioOn) Then Begin
          For CntY := Yupp to Ydd do
            For CntX := XLL to Xrr do Begin
              PixPos := CntX + imXsize * CntY;
              If AnyAvIm[PixPos] > 0 then Begin
                TemResult := (AnyIntData[PixPos] - Bkg)/AnyAvIm[PixPos];
                if TemResult > 0 then
                  Result := Result + TemResult;
              End; { AnyAvIm > 0 }
            End; { For CntY := Yupp to Ydd do For CntX := XLL to Xrr }

          if (KindROI = 1) then Result := Result / NrElem;

      End; { (RatioOn = True) }

End; { Function GetMeanROIforTimeSerAnal; }

{ ************************************************************************** }

Function GetMeanROIforTimeSerAnal(Const XLL, Xrr, Yupp, Ydd: Integer;
                                  Const KindROI: Integer; Const AnyAvIm: TDynDoubleArray;
                                  Const AnyIntData: TDynWordArray) : Double;
    { Does Independently All Kinds of Analysis; Controlled By Time Series Plot }
    { Make Ratio on ROI only to Increase Speed; If ROI are Big the speed will slower }

    var
      CntX, CntY, NrElem,enThreshForArea,NrElemAboveThres,PixPos : Integer;
      TemResult: Double;

    Begin

      NrElem := (Xrr - XLL + 1) * (Ydd - Yupp + 1);
      Result := 0;

      { For Non-Ratioed Images  }
      If Not(RatioOn) Then Begin
        If (frmTimeSerPlot.enThreshForArea.NumberOne = 0) Then Begin
          for CntY := Yupp to Ydd do
            for CntX := XLL to Xrr do
              Result := Result + AnyIntData[CntX + imXsize * CntY];
          if KindROI = 1 then Result := Result / NrElem;
        End
          Else
        Begin //if threshold > 0
          NrElemAboveThres := 0;
          enThreshForArea := frmTimeSerPlot.enThreshForArea.NumberOne;
          for CntY := Yupp to Ydd do begin
            for CntX := XLL to Xrr do begin
            PixPos := CntX + imXsize * CntY;
              if (AnyIntData[PixPos] >= enThreshForArea) then begin
                Result := Result + AnyIntData[PixPos];
                if (KindROI = 1) then Inc(NrElemAboveThres);
              end;
            end;
          end;
          if (KindROI = 1) and (NrElemAboveThres > 0) then Result := Result / NrElemAboveThres;
        End;  //Else Begin
      End
      { (RatioOn = False) }

        Else

      { --------------- For Ratioed Images ----------------------- }
      If (RatioOn) Then Begin
          For CntY := Yupp to Ydd do
            For CntX := XLL to Xrr do Begin
            PixPos := CntX + imXsize * CntY;
              If AnyAvIm[PixPos] > 0 then Begin
                TemResult := (AnyIntData[PixPos] - Bkg)/AnyAvIm[PixPos];
                if (TemResult > 0) then
                  Result := Result + TemResult;
              End; { AnyAvIm > 0 }
            End; { For CntY := Yupp to Ydd do For CntX := XLL to Xrr }

          if (KindROI = 1) then Result := Result / NrElem;

      End; { (RatioOn = True) }

End; { Function GetMeanROIforTimeSerAnal; }

{*******************************************************************************}
Function GetMeanROI_From_Ratio_ForTimeSerAnal(Const XLL, Xrr, Yupp, Ydd: Integer;Const KindROI: Integer;
                                              Const RatioData : TDynDoubleArray): Double;
// used Only For Ratioed Images with smoothing after F/Fo or Ch1/Ch2
var CntX, CntY, NrElem : Integer;

Begin

      NrElem := (Xrr - XLL + 1) * (Ydd - Yupp + 1);
      Result := 0;

      for CntY := Yupp to Ydd do begin
        for CntX := XLL to Xrr do begin
          Result := Result + RatioData[CntX + imXsize * CntY];
        end;
      end;

      if (KindROI = 1) then Result := Result / NrElem;

 End;  //GetMeanROI_From_Ratio_ForTimeSerAnal

 {***************************************************************************}

Procedure DoRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer;
                         Const AnyIntData: TDynWordArray);
// used Only For Ratioed Images with smoothing after F/Fo or Ch1/Ch2

var CntX, CntY, PixPos : Integer;
Begin


  for CntY := Yupp to Ydd do begin
    for CntX := XLL to Xrr do begin
      PixPos := CntX + imXsize * CntY;
    //-----------------------------------//
      If (AvIm[PixPos] > 0) Then Begin
        ImDataRat[PixPos] := ((AnyIntData[PixPos] - Bkg) / AvIm[PixPos]);
        if ImDataRat[PixPos] < 0 then
          ImDataRat[PixPos] := 0;
      End
          else
        ImDataRat[PixPos] := 0;
    //------------------------------------//
    end;
  end;

End;  //GetRatioForROI

{***************************************************************************}

Procedure DoRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer;
                         Const AnyIntData: TDynByteArray);
// used Only For Ratioed Images with smoothing after F/Fo or Ch1/Ch2

var CntX, CntY, PixPos : Integer;
Begin


  for CntY := Yupp to Ydd do begin
    for CntX := XLL to Xrr do begin
      PixPos := CntX + imXsize * CntY;
    //-----------------------------------//
      If (AvIm[PixPos] > 0) Then Begin
        ImDataRat[PixPos] := ((AnyIntData[PixPos] - Bkg) / AvIm[PixPos]);
        if ImDataRat[PixPos] < 0 then ImDataRat[PixPos] := 0;
      End
          else
        ImDataRat[PixPos] := 0;
    //------------------------------------//
    end;
  end;

End;  //GetRatioForROI

{ ************************************************************************** }

Procedure DoChannelsRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer;
                                 Const WinOneIntData,WinTwoIntData : TDynWordArray);
// used Only For Ratioed Images with smoothing after F/Fo or Ch1/Ch2

var CntX, CntY, PixPos : Integer;

Begin

  for CntY := Yupp to Ydd do begin
    for CntX := XLL to Xrr do begin
      PixPos := CntX + imXsize * CntY;
    //-----------------------------------//
      If (WinTwoIntData[PixPos] > Bkg2nd) Then Begin
        ImDataRat[PixPos] := ((WinOneIntData[PixPos] - Bkg)/ (WinTwoIntData[PixPos] - Bkg2nd));
        if ImDataRat[PixPos] < 0 then ImDataRat[PixPos] := 0;
      End
          else
        ImDataRat[PixPos] := 0;
    end;
  end;

End;  //GetRatioForROI

{ ************************************************************************** }

Procedure DoChannelsRatioForROI(Const XLL, Xrr, Yupp, Ydd: Integer;
                                 Const WinOneIntData,WinTwoIntData : TDynByteArray);
// used Only For Ratioed Images with smoothing after F/Fo or Ch1/Ch2

var CntX, CntY, PixPos : Integer;
Begin

  for CntY := Yupp to Ydd do begin
    for CntX := XLL to Xrr do begin
      PixPos := CntX + imXsize * CntY;
    //-----------------------------------//
      If (WinTwoIntData[PixPos] > Bkg2nd) Then Begin
        ImDataRat[PixPos] := ((WinOneIntData[PixPos] - Bkg) / (WinTwoIntData[PixPos] - Bkg2nd));
        if ImDataRat[PixPos] < 0 then ImDataRat[PixPos] := 0;
      End
          else
        ImDataRat[PixPos] := 0;
    end;
  end;

End;  //GetRatioForROI

{ ************************************************************************** }

Procedure RecalculateMeanforMark(var MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr);
Const DO_NOT_SMOOTH       = 0;
      SMOOTH_BEFORE_RATIO = 1;
      SMOOTH_AFTER_RATIO  = 2;
      SMOOTH_NON_RATIO    = 3;
Var
      ImNr: Integer;
      Bim, Eim, M: Integer;
      Cnt: Integer;
      RawByteArr  : TDynByteArray;
      RawWordArr  : TDynWordArray;
      WordArrA    : TDynWordArray;
      WordArrB    : TDynWordArray;
      XLL, Xrr, Yupp, Ydd: Integer;
      SmBoxOffset : Integer;
      SmMedOffset : Integer;
      SmGaussOffset: Integer;
      Filtering    : Integer;
      Do2DFiltAfter,Do2DFiltBefore    : Boolean; // to use 2D filtering

BEGIN

  {determine how to deal with smoothing}

  If (SmoothMode > NO_SMOOTH) Then Begin
    if (RatioOn) and (frmImageControl.cbSmoothBeforeDoRatio.Checked) then
      Filtering := SMOOTH_BEFORE_RATIO
        else
    if ((RatioOn) and not(frmImageControl.cbSmoothBeforeDoRatio.Checked)) or (ChannelsRatioOn) then
      Filtering := SMOOTH_AFTER_RATIO
        else
    if not(RatioOn)and not(ChannelsRatioOn) and (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) then
      Filtering := SMOOTH_NON_RATIO
        else
      Filtering := DO_NOT_SMOOTH;
  End
    Else
  If (SmoothMode = NO_SMOOTH) Then
      Filtering := DO_NOT_SMOOTH;

      { 1st: Sets Offset for Smoothing }

  if (Filtering > DO_NOT_SMOOTH) then GetOffsetFor2DSmoothing(SmBoxOffset, SmMedOffset, SmGaussOffset);


      { Starts Going Thrugh Marks }

      Bim := 0;
      Eim := NrIm - 1;

      For ImNr := Bim to Eim Do Begin

        If (High(MarkArrXY[ImNr]) >= 0) Then Begin { if there are marks }

          ReadImage(ImNr,0,pImData);

          { 1st: Copies Border }
          if (Filtering in [SMOOTH_BEFORE_RATIO,SMOOTH_NON_RATIO]) then SmoothBorders; { Smooths Just the Border of Image }

          if (Filtering = SMOOTH_AFTER_RATIO) and (RatioOn) then  DoRatio(NO_COPY);
          if (ChannelsRatioOn) then DoChannelRatio(NO_COPY);

          { Goes Through Every Mark }
          { First Looks If to Do All the Marks or Just Selected One }

          { Starts Analysis }

          For M := 0 to High(MarkArrXY[ImNr]) do Begin

            { Gets X & Y from each Mark }
            GetMarkSelection(MarkArrXY, ImNr, M, XLL, Xrr, Yupp, Ydd);


            { ------------------------------------------------------------------- }
            { Now Smooths each ROI separately If Needed }
            If (Filtering in [SMOOTH_BEFORE_RATIO,SMOOTH_NON_RATIO]) then
                DoSmoothForROI(RawByteArr, RawWordArr, WordArrA, WordArrB, XLL,
                                               Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset, SmGaussOffset);

            { ------------------- End of Smoothing ------------------------------------- }

            { ---- Actually Getting Means --------------------------- }
            If (RatioOn) then Begin
              If (Filtering = SMOOTH_BEFORE_RATIO) then Begin
                MarkAmpl[ImNr, M] := (GetMeanROIforTimeSerAnal(XLL, Xrr, Yupp,Ydd, 1, AvIm, Im16bitDataSM_Last));
              End
                Else
              If (Filtering = SMOOTH_AFTER_RATIO) then Begin
                MarkAmpl[ImNr, M] := GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,1,ImDataRat)/DispFact;
              End
                Else
              If (Filtering = DO_NOT_SMOOTH) then Begin
                if (BitCount = 16) then
                  MarkAmpl[ImNr, M] := (GetMeanROIforTimeSerAnal(XLL, Xrr,Yupp, Ydd, 1, AvIm, Im16bitData))
                else
                  MarkAmpl[ImNr, M] := (GetMeanROIforTimeSerAnal(XLL, Xrr,Yupp, Ydd, 1, AvIm, Im8bitData))
              End;
            End

              Else

            If (ChannelsRatioOn) then Begin
              MarkAmpl[ImNr, M] := GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,1,ImDataRat)/DispFact;
            End

              Else

            If Not(RatioOn) and Not(ChannelsRatioOn) Then Begin
              If (Filtering = DO_NOT_SMOOTH) then Begin
                if (BitCount = 16) then
                  MarkAmpl[ImNr, M] := (GetMeanROIforTimeSerAnal(XLL, Xrr,Yupp, Ydd, 1, nil, Im16bitData))
                else
                  MarkAmpl[ImNr, M] := (GetMeanROIforTimeSerAnal(XLL, Xrr,Yupp, Ydd, 1, nil, Im8bitData))
                  { if Ratio is Off or Smoothing is Off then Im16bitDataSB of Im16bitDataSM or NotFiltAvIm
                    are not being used but function must be Called with thiese parameters }
              End
                Else
               If (Filtering = SMOOTH_NON_RATIO) then Begin
                MarkAmpl[ImNr, M] := (GetMeanROIforTimeSerAnal(XLL, Xrr, Yupp,Ydd, 1, nil, Im16bitDataSM_Last));
               End;

            End; { If Not(RatioOn) Then Begin }

            { ------------------------------------------------ }
          End; { For M := FirstM to LastM do Begin }

        End; { If  High(MarkBigEvCoor[ImNr]) >= 0 }

      End; { For ImNr := Bim to Eim }

End; { Procedure RecalculateMeanforMark }

{ ************************************************************************** }

Procedure GetOffsetFor2DSmoothing(var SmBoxOffset, SmMedOffset, SmGaussOffset: Integer);
    // used by DoConvTimeSeriesAnal, GetDurForMark & RecalculateMeanforMark
    { Sets Offsets for Smoothing }
var   GaussSize: Integer;
Begin

      if (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED, SMOOTH_MED_GAUSS]) then
      begin
        if (GaussSmSize <= GAUSS_3x3_HEAVY) then
          GaussSize := 3
        else
          GaussSize := GaussSmSize;
      end;

      if (SmoothMode = SMOOTH_BOX) Then
        SmBoxOffset := BoxSmSize div 2
      else if (SmoothMode = SMOOTH_MED) Then
        SmMedOffset := MedSmSize div 2
      else if (SmoothMode = SMOOTH_GAUSS) Then
        SmGaussOffset := GaussSize div 2
      else

        if (SmoothMode = SMOOTH_BOX_MED) Then
      Begin
        SmBoxOffset := BoxSmSize div 2 + MedSmSize div 2;
        SmMedOffset := MedSmSize div 2;
      end
      else if (SmoothMode = SMOOTH_MED_BOX) Then
      Begin
        SmMedOffset := BoxSmSize div 2 + MedSmSize div 2;
        SmBoxOffset := BoxSmSize div 2;
      end
      else if (SmoothMode = SMOOTH_GAUSS_MED) Then
      Begin
        SmGaussOffset := GaussSize div 2 + MedSmSize div 2;
        SmMedOffset := MedSmSize div 2;
      end
      else if (SmoothMode = SMOOTH_MED_GAUSS) Then
      Begin
        SmMedOffset := GaussSize div 2 + MedSmSize div 2;
        SmGaussOffset := GaussSize div 2;
      end;

    End;

  { ************************************************************************** }

  Procedure GetMarkSelection(Const MarkArrXY: TMarkArrXY;Const ImNr, M: Integer;
                                var XLL, Xrr, Yupp, Ydd: Integer);
    // used by GetDurForMark & RecalculateMeanforMark
    Begin
      { Gets X & Y from each Mark }
      XLL := MarkArrXY[ImNr, M].x - (ROIvar.BoxXsize div 2);
      Xrr := XLL + (ROIvar.BoxXsize - 1);
      Yupp := MarkArrXY[ImNr, M].y - (ROIvar.BoxYsize div 2);
      Ydd := Yupp + (ROIvar.BoxYsize - 1);

      if XLL < 0 then
        XLL := 0;
      if Xrr > imXsize - 1 then
        Xrr := imXsize - 1;
      if Yupp < 0 then
        Yupp := 0;
      if Ydd > imYsize - 1 then
        Ydd := imYsize - 1;
    End; // Procedure GetMarkSelection;


 { ************************************************************************** }

 Procedure DoSmoothRatioForROI(Var RawDoubleArr, DoubleArrA, DoubleArrB: TDynDoubleArray;
                               Const XLL, Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset,SmGaussOffset: Integer);
    { used by DoConvTimeSeriesAnal, GetDurForMark & RecalculateMeanforMark
      To be fast instead of the whole image it smooths only ROI and transfer it to Im16bitDataSM_Last.}
    { Smooths each ROI separately }

    Var
      Cnt, CntX, CntY, Len: Integer;
      Xbeg, Xend, Ytop, Ybot: Integer; { used for Smoothing Only }
      Xdim, Ydim: Integer;

    Begin

      // ---------- First Pass Smoothing ------------------------//

      If (SmoothMode in [SMOOTH_BOX, SMOOTH_BOX_MED]) Then Begin
        Xbeg := XLL - SmBoxOffset;
        Xend := Xrr + SmBoxOffset;
        Ytop := Yupp - SmBoxOffset;
        Ybot := Ydd + SmBoxOffset;
        if Xbeg < 0 then
          Xbeg := 0;
        if Xend > imXsize - 1 then
          Xend := imXsize - 1;
        if Ytop < 0 then
          Ytop := 0;
        if Ybot > imYsize - 1 then
          Ybot := imYsize - 1;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(DoubleArrA) <> Len then SetLength(DoubleArrA, Len);

        Cnt := 0;

        if Length(RawDoubleArr) <> Len then SetLength(RawDoubleArr, Len);
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            RawDoubleArr[Cnt] := ImDataRat[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
          BoxCarFilt(RawDoubleArr, DoubleArrA, Xdim, Ydim, BoxSmSize, False);

        { Transfers Data back the Whole Image }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            ImDataRatForSmooth[CntX + imXsize * CntY] := DoubleArrA[Cnt];
            Inc(Cnt);
          end;
        end;
      End  //If (SmoothMode in [SMOOTH_BOX, SMOOTH_BOX_MED])

        Else

      If (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED]) Then Begin
        Xbeg := XLL - SmGaussOffset;
        Xend := Xrr + SmGaussOffset;
        Ytop := Yupp - SmGaussOffset;
        Ybot := Ydd + SmGaussOffset;
        if Xbeg < 0 then
          Xbeg := 0;
        if Xend > imXsize - 1 then
          Xend := imXsize - 1;
        if Ytop < 0 then
          Ytop := 0;
        if Ybot > imYsize - 1 then
          Ybot := imYsize - 1;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(DoubleArrA) <> Len then SetLength(DoubleArrA, Len);

        Cnt := 0;

        if Length(RawDoubleArr) <> Len then SetLength(RawDoubleArr, Len);
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            RawDoubleArr[Cnt] := ImDataRat[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
          Gauss2DFilt(RawDoubleArr, DoubleArrA, Xdim, Ydim, GaussSmSize, False);

        { Transfers Data back the Whole Image }
        Cnt := 0;
        for CntY := Ytop to Ybot do
        begin
          for CntX := Xbeg to Xend do begin
            ImDataRatForSmooth[CntX + imXsize * CntY] := DoubleArrA[Cnt];
            Inc(Cnt);
          end;
        end;
      End // If (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED])

        Else

      If (SmoothMode in [SMOOTH_MED, SMOOTH_MED_BOX, SMOOTH_MED_GAUSS]) Then Begin
        Xbeg := XLL - SmMedOffset;
        Xend := Xrr + SmMedOffset;
        Ytop := Yupp - SmMedOffset;
        Ybot := Ydd + SmMedOffset;
        if Xbeg < 0 then
          Xbeg := 0;
        if Xend > imXsize - 1 then
          Xend := imXsize - 1;
        if Ytop < 0 then
          Ytop := 0;
        if Ybot > imYsize - 1 then
          Ybot := imYsize - 1;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;
        Len := Xdim * Ydim;
        if Length(DoubleArrA) <> Len then SetLength(DoubleArrA, Len);

        Cnt := 0;

        if Length(RawDoubleArr) <> Len then SetLength(RawDoubleArr, Len);

        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            RawDoubleArr[Cnt] := ImDataRat[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
          MedianFilt(RawDoubleArr, DoubleArrA, Xdim, Ydim, MedSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            ImDataRatForSmooth[CntX + imXsize * CntY] := DoubleArrA[Cnt];
            Inc(Cnt);
          end;
        end;
      End; //If (SmoothMode in [SMOOTH_MED, SMOOTH_MED_BOX, SMOOTH_MED_GAUSS])

      // --------- Here Goes for The Second Pass Smoothing  ---------//
      // the Offsets are always = or smaller then the Offsets for the First Filter
      // so - no need to chack if exceeds the Image Array

      If (SmoothMode in [SMOOTH_BOX_MED, SMOOTH_GAUSS_MED]) Then Begin
        Xbeg := XLL - SmMedOffset;
        Xend := Xrr + SmMedOffset;
        Ytop := Yupp - SmMedOffset;
        Ybot := Ydd + SmMedOffset;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;
        Len := Xdim * Ydim;
        if Length(DoubleArrA) <> Len then SetLength(DoubleArrA, Len);
        if Length(DoubleArrB) <> Len then SetLength(DoubleArrB, Len);

        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            DoubleArrA[Cnt] := ImDataRatForSmooth[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
        MedianFilt(DoubleArrA, DoubleArrB, Xdim, Ydim, MedSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            ImDataRatForSmooth[CntX + imXsize * CntY] := DoubleArrB[Cnt];
            Inc(Cnt);
          end;
        end;
      End

        Else

      If (SmoothMode = SMOOTH_MED_BOX) Then Begin
        Xbeg := XLL - SmBoxOffset;
        Xend := Xrr + SmBoxOffset;
        Ytop := Yupp - SmBoxOffset;
        Ybot := Ydd + SmBoxOffset;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(DoubleArrA) <> Len then SetLength(DoubleArrA, Len);
        if Length(DoubleArrB) <> Len then SetLength(DoubleArrB, Len);

        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            DoubleArrA[Cnt] := ImDataRatForSmooth[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
        BoxCarFilt(DoubleArrA, DoubleArrB, Xdim, Ydim, BoxSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            ImDataRatForSmooth[CntX + imXsize * CntY] := DoubleArrB[Cnt];
            Inc(Cnt);
          end;
        end;
      End;

      If (SmoothMode = SMOOTH_MED_GAUSS) Then Begin
        Xbeg := XLL - SmGaussOffset;
        Xend := Xrr + SmGaussOffset;
        Ytop := Yupp - SmGaussOffset;
        Ybot := Ydd + SmGaussOffset;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(DoubleArrA) <> Len then SetLength(DoubleArrA, Len);
        if Length(DoubleArrB) <> Len then SetLength(DoubleArrB, Len);

        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            DoubleArrA[Cnt] := ImDataRatForSmooth[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
        Gauss2DFilt(DoubleArrA, DoubleArrB, Xdim, Ydim, GaussSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            ImDataRatForSmooth[CntX + imXsize * CntY] := DoubleArrB[Cnt];
            Inc(Cnt);
          end;
        end;
      End;

End; // Procedure DoSmoothRatioForROI;

{ ************************************************************************** }

Procedure DoSmoothForROI(Var RawByteArr: TDynByteArray;Var RawWordArr, WordArrA, WordArrB: TDynWordArray;
                             Const XLL, Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset,SmGaussOffset: Integer);
    { used by DoConvTimeSeriesAnal, GetDurForMark & RecalculateMeanforMark
      To be fast instead of the whole image it smooths only ROI and transfer it to Im16bitDataSM_Last.}
    { Smooths each ROI separately }

    Var
      Cnt, CntX, CntY, Len: Integer;
      Xbeg, Xend, Ytop, Ybot: Integer; { used for Smoothing Only }
      Xdim, Ydim: Integer;

    Begin

      // ---------- First Pass Smoothing ------------------------//

      If (SmoothMode in [SMOOTH_BOX, SMOOTH_BOX_MED]) Then Begin
        Xbeg := XLL - SmBoxOffset;
        Xend := Xrr + SmBoxOffset;
        Ytop := Yupp - SmBoxOffset;
        Ybot := Ydd + SmBoxOffset;
        if Xbeg < 0 then Xbeg := 0;
        if Xend > imXsize - 1 then Xend := imXsize - 1;
        if Ytop < 0 then Ytop := 0;
        if Ybot > imYsize - 1 then Ybot := imYsize - 1;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(WordArrA) <> Len then SetLength(WordArrA, Len);

        Cnt := 0;
        If (BitCount = 16) then Begin
          if Length(RawWordArr) <> Len then
            SetLength(RawWordArr, Len);
          for CntY := Ytop to Ybot do begin
            for CntX := Xbeg to Xend do begin
              RawWordArr[Cnt] := Im16bitData[CntX + imXsize * CntY];
              Inc(Cnt);
            end;
          end;
          BoxCarFilt(RawWordArr, WordArrA, Xdim, Ydim, BoxSmSize, False);
        End
          Else
        Begin
          if Length(RawByteArr) <> Len then
            SetLength(RawByteArr, Len);
          for CntY := Ytop to Ybot do begin
            for CntX := Xbeg to Xend do begin
              RawByteArr[Cnt] := Im8bitData[CntX + imXsize * CntY];
              Inc(Cnt);
            end;
          end;
          BoxCarFilt(RawByteArr, WordArrA, Xdim, Ydim, BoxSmSize, False);
        End;
        { Transfers Data back the Whole Image }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            Im16bitDataSM_Last[CntX + imXsize * CntY] := WordArrA[Cnt];
            Inc(Cnt);
          end;
        end;
      End

        Else

      If (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED]) Then Begin
        Xbeg := XLL - SmGaussOffset;
        Xend := Xrr + SmGaussOffset;
        Ytop := Yupp - SmGaussOffset;
        Ybot := Ydd + SmGaussOffset;
        if Xbeg < 0 then Xbeg := 0;
        if Xend > imXsize - 1 then Xend := imXsize - 1;
        if Ytop < 0 then Ytop := 0;
        if Ybot > imYsize - 1 then Ybot := imYsize - 1;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(WordArrA) <> Len then SetLength(WordArrA, Len);

        Cnt := 0;
        If (BitCount = 16) then Begin
          if Length(RawWordArr) <> Len then
            SetLength(RawWordArr, Len);
          for CntY := Ytop to Ybot do begin
            for CntX := Xbeg to Xend do begin
              RawWordArr[Cnt] := Im16bitData[CntX + imXsize * CntY];
              Inc(Cnt);
            end;
          end;
          Gauss2DFilt(RawWordArr, WordArrA, Xdim, Ydim, GaussSmSize, False);
        End
          Else
        Begin
          if Length(RawByteArr) <> Len then
            SetLength(RawByteArr, Len);
          for CntY := Ytop to Ybot do begin
            for CntX := Xbeg to Xend do begin
              RawByteArr[Cnt] := Im8bitData[CntX + imXsize * CntY];
              Inc(Cnt);
            end;
          end;
          Gauss2DFilt(RawByteArr, WordArrA, Xdim, Ydim, GaussSmSize, False);
        End;

        { Transfers Data back the Whole Image }
        Cnt := 0;
        for CntY := Ytop to Ybot do
        begin
          for CntX := Xbeg to Xend do begin
            Im16bitDataSM_Last[CntX + imXsize * CntY] := WordArrA[Cnt];
            Inc(Cnt);
          end;
        end;
      End

        Else

      If (SmoothMode in [SMOOTH_MED, SMOOTH_MED_BOX, SMOOTH_MED_GAUSS]) Then Begin
        Xbeg := XLL - SmMedOffset;
        Xend := Xrr + SmMedOffset;
        Ytop := Yupp - SmMedOffset;
        Ybot := Ydd + SmMedOffset;
        if Xbeg < 0 then Xbeg := 0;
        if Xend > imXsize - 1 then Xend := imXsize - 1;
        if Ytop < 0 then Ytop := 0;
        if Ybot > imYsize - 1 then Ybot := imYsize - 1;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;
        Len := Xdim * Ydim;
        if Length(WordArrA) <> Len then SetLength(WordArrA, Len);

        Cnt := 0;
        If (BitCount = 16) then Begin
          if Length(RawWordArr) <> Len then
            SetLength(RawWordArr, Len);
          for CntY := Ytop to Ybot do begin
            for CntX := Xbeg to Xend do begin
              RawWordArr[Cnt] := Im16bitData[CntX + imXsize * CntY];
              Inc(Cnt);
            end;
          end;
          MedianFilt(RawWordArr, WordArrA, Xdim, Ydim, MedSmSize, False);
        End
          Else
        Begin
          if Length(RawByteArr) <> Len then
            SetLength(RawByteArr, Len);
          for CntY := Ytop to Ybot do begin
            for CntX := Xbeg to Xend do
            begin
              RawByteArr[Cnt] := Im8bitData[CntX + imXsize * CntY];
              Inc(Cnt);
            end;
          end;
          MedianFilt(RawByteArr, WordArrA, Xdim, Ydim, MedSmSize, False);
        End;
        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            Im16bitDataSM_Last[CntX + imXsize * CntY] := WordArrA[Cnt];
            Inc(Cnt);
          end;
        end;
      End;

      // --------- Here Goes for The Second Pass Smoothing  ---------//
      // the Offsets are always = or smaller then the Offsets for the First Filter
      // so - no need to chack if exceeds the Image Array

      If (SmoothMode in [SMOOTH_BOX_MED, SMOOTH_GAUSS_MED]) Then Begin
        Xbeg := XLL - SmMedOffset;
        Xend := Xrr + SmMedOffset;
        Ytop := Yupp - SmMedOffset;
        Ybot := Ydd + SmMedOffset;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;
        Len := Xdim * Ydim;
        if Length(WordArrA) <> Len then SetLength(WordArrA, Len);
        if Length(WordArrB) <> Len then SetLength(WordArrB, Len);

        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            WordArrA[Cnt] := Im16bitDataSM_Last[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
        MedianFilt(WordArrA, WordArrB, Xdim, Ydim, MedSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            Im16bitDataSM_Last[CntX + imXsize * CntY] := WordArrB[Cnt];
            Inc(Cnt);
          end;
        end;
      End

        Else

      If (SmoothMode = SMOOTH_MED_BOX) Then Begin
        Xbeg := XLL - SmBoxOffset;
        Xend := Xrr + SmBoxOffset;
        Ytop := Yupp - SmBoxOffset;
        Ybot := Ydd + SmBoxOffset;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(WordArrA) <> Len then SetLength(WordArrA, Len);
        if Length(WordArrB) <> Len then SetLength(WordArrB, Len);

        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            WordArrA[Cnt] := Im16bitDataSM_Last[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
        BoxCarFilt(WordArrA, WordArrB, Xdim, Ydim, BoxSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            Im16bitDataSM_Last[CntX + imXsize * CntY] := WordArrB[Cnt];
            Inc(Cnt);
          end;
        end;
      End;

      If (SmoothMode = SMOOTH_MED_GAUSS) Then Begin
        Xbeg := XLL - SmGaussOffset;
        Xend := Xrr + SmGaussOffset;
        Ytop := Yupp - SmGaussOffset;
        Ybot := Ydd + SmGaussOffset;

        Xdim := Xend - Xbeg + 1;
        Ydim := Ybot - Ytop + 1;

        Len := Xdim * Ydim;
        if Length(WordArrA) <> Len then SetLength(WordArrA, Len);
        if Length(WordArrB) <> Len then SetLength(WordArrB, Len);

        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            WordArrA[Cnt] := Im16bitDataSM_Last[CntX + imXsize * CntY];
            Inc(Cnt);
          end;
        end;
        Gauss2DFilt(WordArrA, WordArrB, Xdim, Ydim, GaussSmSize, False);

        { Transfers Data back the Whole Image Array }
        Cnt := 0;
        for CntY := Ytop to Ybot do begin
          for CntX := Xbeg to Xend do begin
            Im16bitDataSM_Last[CntX + imXsize * CntY] := WordArrB[Cnt];
            Inc(Cnt);
          end;
        end;
      End;

End; // Procedure DoSmoothForROI;

  { ************************************************************************** }

Procedure GetCurValue(Const XLL, Xrr, Yupp, Ydd: Integer; Var CurVal: Double); // used by GetDurForMark & RecalculateMeanforMark
//Used in RatioOn or ChannelRatioOn Modes.  Gets the Value of ROI (rectangle)
Begin

  If (RatioOn) and ((frmImageControl.cbSmoothBeforeDoRatio.Checked) or (SmoothMode = NO_SMOOTH)) Then Begin
    If (SmoothMode > NO_SMOOTH)  Then begin
      CurVal := (GetMeanROIforTimeSerAnal(XLL, Xrr, Yupp, Ydd, 1,AvIm, Im16bitDataSM_Last));
    End
      Else
    Begin
        if (BitCount = 16) then begin
            CurVal := (GetMeanROIforTimeSerAnal(XLL, Xrr, Yupp, Ydd, 1, AvIm, Im16bitData));
        end
          else
        begin
            CurVal := (GetMeanROIforTimeSerAnal(XLL, Xrr, Yupp, Ydd, 1,AvIm, Im8bitData));
        end;
      End;
  End
    Else
  If ((RatioOn) and (SmoothMode > NO_SMOOTH) and Not(frmImageControl.cbSmoothBeforeDoRatio.Checked)) Then Begin
    CurVal := GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,1,ImDataRat)/DispFact;
  End
    Else
  If (ChannelsRatioOn) Then Begin
    CurVal := GetMeanROI_From_Ratio_ForTimeSerAnal(XLL,Xrr,Yupp,Ydd,1,ImDataRat)/DispFact;
  End;


End; // Procedure GetCurValue

  { ************************************************************************** }

Procedure GetPeaks(Const PlotData: TDyn2DDoubleArr);
 {if no individual Baseline is chosen then:
  if F/Fo baseline = 1.0 F/Fo
  if Ch/Ch baseline = ratio at µM Ca (100 nM)
  if Convert to Ca con then baseline = 0.1 µM Ca}
Var
      CntROI, ImNr, Cnt: Integer; { counters }
      PeakIm, MinIm: Integer;
      { im where MaxValue, and Min Left from Peak occured, also used as beg and Enbd to Search for Individual baseline }
      Lim, Rim: Integer; { Left and Rigth from Peak where Ampl < 50% }
      Ltim, Rtim: Double; { exact Time and Ampl for Left and Right borders }
      PeakVal, MinVal, FstMin: Double;
      Delt, Sl, AbsThresh: Double;
      ChRatAt100nMCa : Double;  //Channel Ratio at 100 nM (0.1 µM Ca)
      Lock: Boolean; // used in finding peaks - if Max - Left Min > Delta [delt;  also used as to indicate if Peaks were found//
      SearchRange: Integer;
      NrImGetMin: Integer;
      MinBase: Double;
      CntPoints: Integer;
      FirtsMinArr: Array of Double;
      TempPeakPosArr: TDyn2DWordArray;
      TempPeakValArr: TDyn2DDoubleArr;
      TempPeakBasArr: TDyn2DDoubleArr;
      TempBaseImNrArr : array of array of TBaseImNr;

Begin

      if (TimPltSlid.GetEachPeakBase) then
      begin
        SetLength(FirtsMinArr, PLOTvar.NrROI); // stores First Min (Min for First Peak Found)
        SetLength(TempPeakBasArr, PLOTvar.NrROI);
        SetLength(TempBaseImNrArr, PLOTvar.NrROI);
        PLOTvar.EachPeakBasePt := TimPltSlid.EachPeakBasePt;
        PLOTvar.EachPeakBaseRg := TimPltSlid.EachPeakBaseRg;
        { Gets individual baselines for each peak }
      end;

      PLOTvar.GetEachPeakBase := TimPltSlid.GetEachPeakBase;

      { store thresh to save it to a file }
      ROIvar.PeakThreshUsed := frmTimeSerPlot.scrbPeakThresh.Position;

      Delt := frmTimeSerPlot.scrbPeakThresh.Position / 10;

      if (PLOTvar.AnalType = RATIO_TIME) then AbsThresh := Delt + 10.00 //1.0  F/Fo * 10 scale factor
        else
      if (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then begin
        {Y = Bottom + (Top-Bottom)/(1+(IC50/X)^HillSlope
        Ca(µM) = MinRat + Span/(1 + (IC50/0.1µMCa)^HillSlope) }
        with HillEquationParams do  //HillEquationParams.
        ChRatAt100nMCa := (MinRatio + Span/(1 + Power((IC50/0.1),HillSlope)))*10;//10 is a scale factor
        AbsThresh := Delt + ChRatAt100nMCa;
      end
        else
      if (PLOTvar.AnalType = Ca_CONC_TIME) then AbsThresh := Delt + 0.1*10; //0.1 µM Ca * 10 scale factor
  
      { already multiplied by 20 it becomes multiplied by 10 as data in -> }
      { -> TimSerPlotData are  multiplied by 10 for Plot purposes }

      PeakPosArr := nil;
      SetLength(PeakPosArr, PLOTvar.NrROI); { reserves slots for all ROI's }
      PeakValArr := nil;
      SetLength(PeakValArr, PLOTvar.NrROI);
      PeakBasArr := nil; // stores baseline for each peak - will be filled later
      SetLength(PeakBasArr, PLOTvar.NrROI);
      PeakTimArr := nil;
      SetLength(PeakTimArr, PLOTvar.NrROI);
      PeakFakeImNrArr := nil;
      SetLength(PeakFakeImNrArr, PLOTvar.NrROI);
      BaseImNrArr := nil;
      RiseTimeArr := nil;
      SetLength(RiseTimeArr, PLOTvar.NrROI);
      SetLength(TempPeakPosArr, PLOTvar.NrROI);
      SetLength(TempPeakValArr, PLOTvar.NrROI);

      { ----------- end of initializing variables --------------- }

      { Part 1: finding Peaks }

      For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
        { resets Values }
        PeakVal := 0;
        MinVal := 65535; { max of 16 bit image }
        MinIm := 0;
        PeakIm := 0;
        Lock := False;

        For ImNr := 0 to High(PlotData[CntROI]) Do Begin

          { updates Min }
          If Lock = False then if (MinVal > PlotData[CntROI,ImNr]) then Begin
            MinVal := PlotData[CntROI, ImNr];
            MinIm := ImNr;
          End; { Lock = False }

          { looks if Min on the Left from Max > Delta [Threshold] and Locks Values }

          if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then begin
            // in addition to below asks that PeakVal to be > Delta + 1.00
            // i.e. above absolute threshold
            if (PeakVal - MinVal > Delt) and (PeakIm > MinIm) and (PeakVal > AbsThresh) then
              Lock := True;
          end
            else
          begin
            if (PeakVal - MinVal > Delt) and (PeakIm > MinIm) then
              Lock := True;
          end;

          { GETS Max and Saves it to Peak Arrays }
          If (Lock = True) and (PeakVal - PlotData[CntROI, ImNr] > Delt) and
            (ImNr > PeakIm) then
          Begin

            { increases array and stores ImNr for the Peak }
            SetLength(TempPeakPosArr[CntROI], High(TempPeakPosArr[CntROI]) + 2);
            TempPeakPosArr[CntROI, High(TempPeakPosArr[CntROI])] := PeakIm;
            { that's Not Real Nr,Real is: MaxIm+PLOTvar.ImBeg }
            SetLength(TempPeakValArr[CntROI], High(TempPeakValArr[CntROI]) + 2);
            TempPeakValArr[CntROI, High(TempPeakValArr[CntROI])] := PeakVal;
            { *10 !!!! }
            if ( High(TempPeakValArr[CntROI]) = 0) then begin
              if (TimPltSlid.GetEachPeakBase) then
                FirtsMinArr[CntROI] := MinVal;
            end;

            { resets }
            MinIm := ImNr;
            MinVal := PlotData[CntROI, ImNr]; { stores current min }
            PeakIm := 0;
            PeakVal := 0;
            Lock := False;
          End;

          { Deletes and resets if Max if MaxIm is passed without peak detected }
          If Lock = False then
            if PeakIm < MinIm Then Begin
              PeakIm := MinIm;
              PeakVal := MinVal;
            End;

          { updates Max }
          If PeakVal < PlotData[CntROI, ImNr] then Begin
            PeakVal := PlotData[CntROI, ImNr];
            PeakIm := ImNr;
          End; { If MaxVal < TimSerPlotData[CntROI,ImNr] }

        End; { For ImNr := 0 to High(TimSerPlotData[CntROI]) Do Begin }
      End; { For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin }
      { End of Part 1: finding Peaks }

      { ----------------------------------------------------------------- }

      { Makes All Arrays nil if No Peak was Found }
      Lock := False;

      For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
        if High(TempPeakPosArr[CntROI]) > -1 then begin
          Lock := True;
          Break;
        end;
      End;

      If (Lock = False) then Begin
        // No Peak found - Zeroes Arrays

        PeakPosArr := nil;
        PeakValArr := nil;
        PeakBasArr := nil;
        PeakTimArr := nil;
        PeakFakeImNrArr := nil;
        BaseImNrArr := nil;
        RiseTimeArr := nil;
      End

        Else

      If (Lock) Then Begin // peaks were found

        SetLength(TempPeakBasArr, PLOTvar.NrROI);
        For CntROI := 0 to High(TempPeakPosArr) Do Begin // for each ROI trace//
          SetLength(TempPeakBasArr[CntROI], Length(TempPeakPosArr[CntROI]));
        End; { For CntROI := 0 to High(TempPeakPosArr) }

        If (TimPltSlid.GetEachPeakBase) Then Begin
      { Beg of Part 2: Getting Baselines for Each event if chosen from Time Series Plot }

          SetLength(BaseImNrArr, PLOTvar.NrROI);

          for CntROI := 0 to High(TempPeakPosArr) do begin { for each ROI trace }
            SetLength(TempBaseImNrArr[CntROI], Length(TempPeakPosArr[CntROI]));
          end;

         // 1st Gets the individual Baselines for each peak//

          // Get Bases - Gets Minimum in the Defined range By Finding the Smallest Value in Defined Nr of Consecutive Images//

          SearchRange := round(TimPltSlid.EachPeakBaseRg / (MeanImTime * 1000)) + 1;
          NrImGetMin := TimPltSlid.EachPeakBasePt;

          For CntROI := 0 to (PLOTvar.NrROI - 1) Do  Begin { for each ROI trace }
            If ( High(TempPeakPosArr[CntROI]) > -1) Then
              For Cnt := 0 to High(TempPeakPosArr[CntROI]) Do Begin { for each Peak Found }

                MinBase := 10000; // just a Big Number
                Lim := TempPeakPosArr[CntROI, Cnt] - SearchRange;
                Rim := TempPeakPosArr[CntROI, Cnt] - (NrImGetMin - 1);

                If (Rim > 0) Then Begin
                  if (Lim < 0) then
                    Lim := 0;

                  For ImNr := Lim to Rim Do Begin
                    MinVal := 0;
                    for CntPoints := 0 to NrImGetMin - 1 do begin
                      MinVal := MinVal + PlotData[CntROI, ImNr + CntPoints];
                    end;
                    MinVal := MinVal / NrImGetMin;
                    if (MinBase > MinVal) then begin
                      MinBase := MinVal;
                      TempBaseImNrArr[CntROI,Cnt].LimNr := ImNr + PLOTvar.ImBeg;
                      TempBaseImNrArr[CntROI,Cnt].RimNr := ImNr + (NrImGetMin-1) + PLOTvar.ImBeg;
                    end;
                  End;

                  TempPeakBasArr[CntROI, Cnt] := MinBase;
                End
                else
                  TempPeakBasArr[CntROI, Cnt] := FirtsMinArr[CntROI];

              End; // For Cnt := 0 to High(TempPeakPosArr[CntROI])
          End; // For CntROI := 0 to (PLOTvar.NrROI - 1)

          // 2nd Deletes Peaks if Peak - Ind Base < Delta (Delt)
          // A) finds the Nr of Peaks (NrIm used here) that do NOT qualify
          For CntROI := 0 to High(TempPeakBasArr) Do Begin // for each ROI trace
            If ( High(TempPeakBasArr[CntROI]) > -1) Then Begin
              ImNr := 0;
              For Cnt := 0 to High(TempPeakBasArr[CntROI]) Do Begin { for each Peak Found }
                if Not((TempPeakValArr[CntROI, Cnt] - TempPeakBasArr[CntROI,Cnt]) > Delt) then
                begin
                  Inc(ImNr);
                  TempPeakPosArr[CntROI, Cnt] := 0;
                end;
              End; { For Cnt := 0 to High(TempPeakBasArr[CntROI]) }
              SetLength(PeakValArr[CntROI], Length(TempPeakPosArr[CntROI]) - ImNr);
              SetLength(PeakPosArr[CntROI], Length(TempPeakPosArr[CntROI]) - ImNr);
              SetLength(PeakBasArr[CntROI], Length(TempPeakPosArr[CntROI]) - ImNr);
              SetLength(BaseImNrArr[CntROI],Length(TempPeakPosArr[CntROI]) - ImNr);
            End; // If High(TempPeakPosArr[CntROI] > -1)
          End; { For CntROI := 0 to High(TempPeakBasArr) }

          // B copies Peak Pos, Values & bases to the "Permanent" Arrays
          For CntROI := 0 to High(TempPeakPosArr) Do Begin // for each ROI trace
            If ( High(TempPeakPosArr[CntROI]) > -1) Then Begin
              ImNr := 0;
              For Cnt := 0 to High(TempPeakPosArr[CntROI]) Do Begin { for each Peak Found }
                if (TempPeakPosArr[CntROI, Cnt] > 0) then begin
                  PeakPosArr[CntROI, ImNr] := TempPeakPosArr[CntROI,  Cnt];
                  PeakValArr[CntROI, ImNr] := TempPeakValArr[CntROI,  Cnt];
                  PeakBasArr[CntROI, ImNr] := TempPeakBasArr[CntROI,  Cnt];
                  BaseImNrArr[CntROI,ImNr] := TempBaseImNrArr[CntROI, Cnt];
                  Inc(ImNr);
                end;
              End; { For Cnt := 0 to High(PeakPosArr[CntROI]) }
            End; // If High(TempPeakBasArr[CntROI] > -1) Then begin
          End; { For CntROI := 0 to High(PeakPosArr) }

        End  //Getting Baselines for Each event if chosen from Time Series Plot

          Else

        { ------------------------------------------------------------ }
        If Not(TimPltSlid.GetEachPeakBase) Then Begin
          { Using Same Baselines for All Events }

          For CntROI := 0 to High(TempPeakPosArr) Do Begin
            SetLength(PeakPosArr[CntROI], Length(TempPeakPosArr[CntROI]));
            for Cnt := 0 to High(PeakPosArr[CntROI]) do
              PeakPosArr[CntROI, Cnt] := TempPeakPosArr[CntROI, Cnt];
          End;

          For CntROI := 0 to High(TempPeakValArr) Do Begin
            SetLength(PeakValArr[CntROI], Length(TempPeakValArr[CntROI]));
            for Cnt := 0 to High(PeakValArr[CntROI]) do
              PeakValArr[CntROI, Cnt] := TempPeakValArr[CntROI, Cnt];
          End;

          For CntROI := 0 to High(TempPeakPosArr) Do Begin
            SetLength(PeakBasArr[CntROI], Length(TempPeakPosArr[CntROI]));
            // sets All bases to 10.0 (i.e. 1.0 F/Fo) or MinRato or Min Ca;
            For Cnt := 0 to High(PeakBasArr[CntROI]) do Begin
              if (PLOTvar.AnalType = RATIO_TIME) then
                PeakBasArr[CntROI,Cnt] := 10 else
              if (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then
                PeakBasArr[CntROI,Cnt] := ChRatAt100nMCa else
              if (PLOTvar.AnalType = Ca_CONC_TIME) then
                PeakBasArr[CntROI,Cnt] := 1; // 0.1*10 = 1;  0.1 µM Ca  (100 nM)
            End;
          End;

        End; // If Not(TimPltSlid.GetEachPeakBase)

        { End of Part 2: Getting Baselines for Each event }

        /// /////////////////////////////////////////////////////////////////////////

        { Beg of Part 3: Getiing Duration at 1/2 amplitude;

          Base Line is Always assumed to be 1.00;
          Values in TimSerPlotData are multiplied by 10, i.e. F/Fo = 1.00 = 10.0 }
        // sets the Time Arrays//

        For CntROI := 0 to High(PeakPosArr) Do Begin { for each ROI trace }
          SetLength(PeakTimArr[CntROI], Length(PeakPosArr[CntROI]));
          SetLength(PeakFakeImNrArr[CntROI], Length(PeakPosArr[CntROI]));
        End;

        // here PeakVal = 1/2 of Peak

        For CntROI := 0 to High(PeakPosArr) Do Begin { for each ROI trace }
          If ( High(PeakPosArr[CntROI]) > -1) Then
            For Cnt := 0 to High(PeakPosArr[CntROI]) Do Begin { for each Peak Found }
              { ----------------------------------------------------------------- }
              { 1st: Find Lim and Rim = images where Ampl < 1/2 Peak }
              { Goes Back to Find Left Image Where Ampl < 1/2 }
              Lim := CANNOT_BE_DONE; { resets }
              ImNr := PeakPosArr[CntROI, Cnt];
              { sets Counter at Max Im Nr Found }
              { here PeakVal is used as 1/2 PeakVal }
              PeakVal := (PlotData[CntROI, ImNr] - PeakBasArr[CntROI, Cnt])/ 2; { this is 1/2 Amplitude*10 }
              { =1/2 Max = (F/Fo - 1.0)/2 [=10.0] }
              While (PlotData[CntROI, ImNr] - PeakBasArr[CntROI,
                Cnt] > PeakVal) and (ImNr > 0) Do
              Begin
                Dec(ImNr);
                if (PlotData[CntROI, ImNr] - PeakBasArr[CntROI, Cnt] < PeakVal)
                  then
                begin
                  Lim := ImNr;
                  Break;
                end;
              End; { While {Left border }

              { Goes Forward to Find Right Image Where Ampl < 1/2 }
              Rim := CANNOT_BE_DONE; { resets }
              ImNr := PeakPosArr[CntROI, Cnt];
              { sets Counter at Max Im Nr Found }
              While (PlotData[CntROI, ImNr] - PeakBasArr[CntROI,
                Cnt] > PeakVal) and (ImNr < High(PlotData[CntROI])) Do
              Begin
                Inc(ImNr);
                if (PlotData[CntROI, ImNr] - PeakBasArr[CntROI, Cnt] < PeakVal)
                  then
                begin
                  Rim := ImNr;
                  Break;
                end;
              End; { While {Left border }
              { End 1st }
              { 2nd: Finds Exactly the Time using Linear Interpolation }
              { Y = A + slope*(X + X offset);  Y = amplitude, X = time, A = Y - slope*X;
                A = First left Image below 1/2, and 1 image Before Image Right after 1/2
                Y = PeakVal [here this is 1/2 Peak, Not Peak]
                X offsets are the Time sfor these iamge above }
              If (Lim > CANNOT_BE_DONE) Then Begin
                { Finds Slope = Sl for Left Side }
                Sl := (PlotData[CntROI, Lim + 1] - PlotData[CntROI, Lim]) /
                  (CopyOfTimeSt[Lim + 1] - CopyOfTimeSt[Lim]);
                { Finds Time in sec for the left }
                Ltim := (PeakVal - (PlotData[CntROI, Lim] - PeakBasArr[CntROI,
                    Cnt])) / Sl + (CopyOfTimeSt[Lim]);
                { (Ltim + TimeSt[Lim + PLOTvar.ImBeg]) = Xoffset }

              End
              Else
                Ltim := CANNOT_BE_DONE;
              { indicates that 1/2 Duration Cannot be Neasured }

              If (Rim > CANNOT_BE_DONE) Then Begin
                { Finds Slope = Sl for right side }
                Sl := (PlotData[CntROI, Rim] - PlotData[CntROI, Rim - 1]) /
                  (CopyOfTimeSt[Rim] - CopyOfTimeSt[Rim - 1]);

                Rtim := (PeakVal - (PlotData[CntROI,
                    Rim - 1] - PeakBasArr[CntROI, Cnt])) / Sl +
                  (CopyOfTimeSt[Rim - 1]);
                { (Rtim + TimeSt[Rim-1 + PLOTvar.ImBeg]); = Xoffset }
              End
              Else
                Rtim := CANNOT_BE_DONE;
              { saves Left Time and Right Time to Array }
              PeakTimArr[CntROI, Cnt].L := Ltim;
              PeakTimArr[CntROI, Cnt].R := Rtim;

              If (Rim > CANNOT_BE_DONE) then
              Begin
                PeakFakeImNrArr[CntROI, Cnt].Rim := (Rim - 1 + PLOTvar.ImBeg) +
                  (Rtim - CopyOfTimeSt[Rim - 1]) /
                  (CopyOfTimeSt[Rim] - CopyOfTimeSt[Rim - 1]);

                if (Lim > CANNOT_BE_DONE) then
                  PeakFakeImNrArr[CntROI, Cnt].Lim := (Lim + PLOTvar.ImBeg) +
                    (Ltim - CopyOfTimeSt[Lim]) /
                    (CopyOfTimeSt[Lim + 1] - CopyOfTimeSt[Lim])
                else
                  PeakFakeImNrArr[CntROI, Cnt].Lim := Lim;
                // if Decay cannot be done nothing is plotted//
              End
              Else
                PeakFakeImNrArr[CntROI, Cnt].Rim := Rim;

              { ----------------------------------------------------------------- }
            End; { For Cnt := 0 to High(PeakPosArr[CntROI]) Do Begin }
        End; { For CntROI := 0 to High(PeakPosArr) Do Begin }

        { ---------------------- -------------------------- }

        { Kills some of Durations or t1/2 if they Overlap with Peak of other event }
        For CntROI := 0 to High(PeakPosArr) Do Begin { for each ROI trace }
          If ( High(PeakPosArr[CntROI]) > -1) Then
            For Cnt := 0 to High(PeakPosArr[CntROI]) Do
            Begin { for each Peak Found }
              { 1st: Check Left Side }

              if Cnt > 0 then
                if PeakTimArr[CntROI, Cnt].L > -1 then
                  if PeakTimArr[CntROI, Cnt].L < CopyOfTimeSt
                    [PeakPosArr[CntROI, Cnt - 1]] then
                  begin
                    PeakTimArr[CntROI, Cnt].L := CANNOT_BE_DONE;
                    { kills Left Side }
                    PeakFakeImNrArr[CntROI, Cnt].Lim := CANNOT_BE_DONE;
                  end;
              { 2nd: Checks Right Side }
              if Cnt < High(PeakPosArr[CntROI]) then
                if PeakTimArr[CntROI, Cnt].R > -1 then
                  if PeakTimArr[CntROI, Cnt].R > CopyOfTimeSt
                    [PeakPosArr[CntROI, Cnt + 1]] then
                  begin
                    PeakTimArr[CntROI, Cnt].R := CANNOT_BE_DONE;
                    { kills Right Side }
                    PeakFakeImNrArr[CntROI, Cnt].Rim := CANNOT_BE_DONE;
                    { kills Right Side }
                  end;
            End; { For Cnt := 0 to High(PeakPosArr[CntROI]) }
        End; { For CntROI := 0 to High(PeakPosArr) }

        { -------------------------- End of Finding Duration & Decay ---------------- }

        { 4th:  Finds Rise Time for 10% - 90% Peak }

        { here Lim = for Point <= 10% of Peak
          Rim = for Point <= 90% of Peak
          PeakVal = 90% of Peak
          MinVal = 10% of Peak
          }

        For CntROI := 0 to High(PeakPosArr) Do Begin { for each ROI trace }
          SetLength(RiseTimeArr[CntROI], Length(PeakPosArr[CntROI]));
        End;

        For CntROI := 0 to High(PeakPosArr) Do Begin { for each ROI trace }
          If ( High(PeakPosArr[CntROI]) > -1) Then
            For Cnt := 0 to High(PeakPosArr[CntROI]) Do Begin { for each Peak Found }
              { ----------------------------------------------------------------- }
              If (PeakTimArr[CntROI, Cnt].L > CANNOT_BE_DONE) Then
              Begin

                { 1st: Goes Back to Find Left Image Where Ampl <= 90% (Rim) and <= 10% (Lim) }

                // No need to set Rim to CANNOT_BE_DONE since 1/2 time was possible to be found
                ImNr := PeakPosArr[CntROI, Cnt];
                { sets Counter at Max Im Nr Found }
                PeakVal := (PlotData[CntROI, ImNr] - PeakBasArr[CntROI, Cnt])
                  * 0.9; { this is 90% Amplitude*10 }
                MinVal := (PlotData[CntROI, ImNr] - PeakBasArr[CntROI, Cnt])
                  * 0.1; { this is 10% Amplitude*10 }

                // 90%)
                While (PlotData[CntROI, ImNr] - PeakBasArr[CntROI,
                  Cnt] > PeakVal) and (ImNr > 0) Do
                Begin
                  Dec(ImNr);
                  if (PlotData[CntROI, ImNr] - PeakBasArr[CntROI,
                    Cnt] < PeakVal) then
                  begin
                    Rim := ImNr;
                    Break;
                  end;
                End; // While

                { Proceeds to the Left to find image where Ampl <= 10% }
                Lim := CANNOT_BE_DONE;
                ImNr := Rim + 1;
                { sets Counter at 1 image above Rim to be work securely if points are few }

                While (PlotData[CntROI, ImNr] - PeakBasArr[CntROI,
                  Cnt] > MinVal) and (ImNr > 0) Do
                Begin
                  Dec(ImNr);
                  if (PlotData[CntROI, ImNr] - PeakBasArr[CntROI,
                    Cnt] < MinVal) then
                  begin
                    Lim := ImNr;
                    Break;
                  end;
                End; // While
                { End 1st }

                { 2nd: Finds Exactly the Time using Linear Interpolation }
                { Y = A + slope*(X + X offset);  Y = amplitude, X = time, A = Y - slope*X;
                  A = First left Image below 1/2, and 1 image Before Image Right after 1/2
                  Y = PeakVal [here this is 1/2 Peak, Not Peak]
                  X offsets are the Time sfor these iamge above }
                If (Lim > CANNOT_BE_DONE) Then
                Begin
                  { Finds Slope = Sl for 10% }
                  Sl := (PlotData[CntROI, Lim + 1] - PlotData[CntROI, Lim]) /
                    (CopyOfTimeSt[Lim + 1] - CopyOfTimeSt[Lim]);
                  { Finds Time in sec for the left }
                  Ltim := (MinVal - (PlotData[CntROI, Lim] - PeakBasArr[CntROI,
                      Cnt])) / Sl + (CopyOfTimeSt[Lim]);
                  { (Ltim + TimeSt[Lim + PLOTvar.ImBeg]) = Xoffset }

                  { Finds Slope = Sl for 90% }
                  Sl := (PlotData[CntROI, Rim + 1] - PlotData[CntROI, Rim]) /
                    (CopyOfTimeSt[Rim + 1] - CopyOfTimeSt[Rim]);
                  { Finds Time in sec for the left }
                  Rtim := (PeakVal - (PlotData[CntROI,
                      Rim] - PeakBasArr[CntROI, Cnt])) / Sl +
                    (CopyOfTimeSt[Rim]);
                  { (Ltim + TimeSt[Lim + PLOTvar.ImBeg]) = Xoffset }

                  RiseTimeArr[CntROI, Cnt] := Rtim - Ltim;

                End
                Else
                  RiseTimeArr[CntROI, Cnt] := CANNOT_BE_DONE;
                { indicates RiseTime Cannot be Neasured }

              End
              Else
                RiseTimeArr[CntROI, Cnt] := CANNOT_BE_DONE; // if If NOT PeakTimArr[CntROI,Cnt].L > CANNOT_BE_DONE)
              { ----------------------------------------------------------------- }
            End; { For Cnt := 0 to High(PeakPosArr[CntROI]) Do Begin }

        End; { For CntROI := 0 to High(PeakPosArr) Do Begin }

        { -------------------- End of Finding Rise Time  ------------------------- }

      End; // If (Lock) = Peaks were found

      { and Finally Displays Peak Table or Clears it }

      if (Lock) then
      Begin
        if frmPeaks = nil then
          Application.CreateForm(TfrmPeaks, frmPeaks);
        PLOTvar.HasPeaks := True;
        frmPeaks.FillPeakTable;
      end
      else if Not(Lock) then
      begin { no peaks found }
        PLOTvar.HasPeaks := False;
        if frmPeaks <> nil then
          frmPeaks.ClearPeakTable;
      end;

      frmTimeSerPlot.sbUnDoDelPeak.Enabled := False;

    End; { Procedure GetPeaks; }

{ ************************************************************************** }

Procedure GetMarksBaselines(Const MarkArrXY: TMarkArrXY;
                            var MarkAmpl: TDyn2DSingleArr; var MarkBase: TDyn2DSingleArr;
                            Const NrPtForBase: Word; Const BaseSearchRange: Word);

Const DO_NOT_SMOOTH       = 0;
      SMOOTH_BEFORE_RATIO = 1;
      SMOOTH_AFTER_RATIO  = 2;
var
      ImNr: Integer;
      Bim, Eim, M: Integer;
      Cnt: Integer;
      RawByteArr: TDynByteArray;
      RawWordArr: TDynWordArray;
      WordArrA: TDynWordArray;
      WordArrB: TDynWordArray;
      XLL, Xrr, Yupp, Ydd: Integer;
      SmBoxOffset: Integer;
      SmMedOffset: Integer;
      SmGaussOffset: Integer;
      CntIm: Integer;
      CurVal: Double; // current Value = Current Mark (X,Y) selection

      DataForBase : TDyn2DSingleArr; // Unlike MarkAmpl, DataForBase does not have Emty Slots, i.e. it is not Sparse array
      LenBaseArr : Integer; // Range to Search  for Baseline
      ReadFBeg : Integer;
      NrImGetMin: Integer;
      MinBase: Double;
      CntMarks,Filtering: Integer;

Begin


      { Sets Variables }
        {determine how to deal with smoothing}

  If (SmoothMode > NO_SMOOTH) Then Begin
    if (RatioOn) and (frmImageControl.cbSmoothBeforeDoRatio.Checked) then
      Filtering := SMOOTH_BEFORE_RATIO
        else
    if ((RatioOn) and not(frmImageControl.cbSmoothBeforeDoRatio.Checked)) or (ChannelsRatioOn) then
      Filtering := SMOOTH_AFTER_RATIO
        else
      Filtering := DO_NOT_SMOOTH;
  End
    Else
  If (SmoothMode = NO_SMOOTH) Then
      Filtering := DO_NOT_SMOOTH;


  { 1st: Sets Offset for Smoothing }
  if (Filtering > DO_NOT_SMOOTH) then GetOffsetFor2DSmoothing(SmBoxOffset, SmMedOffset, SmGaussOffset);

  Bim := 1; { starts from 2n Image }
  Eim := NrIm - 1; { finishes from 1 Image before end }

  // DataForBase    LenBaseArr
  // Sets  DataForBase
  LenBaseArr := round(BaseSearchRange / (MeanImTime * 1000)) + 1;
  // +1 to Include Peak Image Number
  NrImGetMin := NrPtForBase;

  M := 0;
  For ImNr := Bim to Eim Do Begin // M used as Counter
    If High(MarkAmpl[ImNr]) >= 0 Then
    Inc(M, Length(MarkAmpl[ImNr])); // Counts Marks
  End;
  SetLength(DataForBase, M, LenBaseArr + 1);

  CntMarks := 0;

      { Starts Going Thrugh Marks }
  For ImNr := Bim to Eim Do Begin

    If High(MarkArrXY[ImNr]) >= 0 Then Begin { if there are marks }
  { ------------------------------------------------------------------------ }
    { Goes Left To The Spark Peak }

      ReadFBeg := ImNr - LenBaseArr;

      If (ReadFBeg < 0) then Begin
        For CntIm := 0 to LenBaseArr Do Begin
          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            if (RatioOn) then
              DataForBase[CntMarks + M, CntIm] := 1.0 else
            if (ChannelsRatioOn) then
              DataForBase[CntMarks + M, CntIm] := HillEquationParams.MinRatio;
          End;
        End;
        CntIm := ImNr;
        For M := 0 to High(MarkArrXY[ImNr]) do Begin
          ReadImage(CntIm,0,pImData);
          if (Filtering = SMOOTH_BEFORE_RATIO) then SmoothBorders; { Smooths Just the Border of Image }
          GetMarkSelection(MarkArrXY, ImNr, M, XLL, Xrr, Yupp, Ydd);
          if (Filtering = SMOOTH_BEFORE_RATIO) then
            DoSmoothForROI(RawByteArr, RawWordArr, WordArrA, WordArrB, XLL,Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset, SmGaussOffset);
          if (Filtering = SMOOTH_AFTER_RATIO) and (RatioOn) then  DoRatio(NO_COPY);
          if (ChannelsRatioOn) then DoChannelRatio(NO_COPY);
          GetCurValue(XLL, Xrr, Yupp, Ydd, CurVal);
          DataForBase[CntMarks + M, High(DataForBase[CntMarks + M])] := CurVal;
        End; { For M := 0 to High(MarkArrXY[ImNr]) do Begin }
      End; // If (ReadFBeg < 0) then Begin

      If (ReadFBeg >= 0) Then Begin
        For CntIm := ReadFBeg to ImNr Do Begin { always Starts from 1st Image }
          ReadImage(CntIm,0,pImData);
          if (Filtering = SMOOTH_BEFORE_RATIO) then SmoothBorders; { Smooths Just the Border of Image }
          For M := 0 to High(MarkArrXY[ImNr]) do Begin // Goes through All Marks On this ImNr
            GetMarkSelection(MarkArrXY, ImNr, M, XLL, Xrr, Yupp, Ydd);
            if (Filtering = SMOOTH_BEFORE_RATIO) then
              DoSmoothForROI(RawByteArr, RawWordArr, WordArrA, WordArrB, XLL, Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset, SmGaussOffset);
            if (Filtering = SMOOTH_AFTER_RATIO) and (RatioOn) then  DoRatio(NO_COPY);
            if (ChannelsRatioOn) then DoChannelRatio(NO_COPY);
            GetCurValue(XLL, Xrr, Yupp, Ydd, CurVal);
            DataForBase[CntMarks + M, CntIm - ReadFBeg] := CurVal;
          End; { For M := 0 to High(MarkArrXY[ImNr]) do Begin }
        End; { For CntIm := ReadFBeg to ImNr Do Begin }
       End; // If (ReadFBeg >= 0) Then Begin

     Inc(CntMarks, High(MarkArrXY[ImNr]) + 1);

    End; // If  High(MarkBigEvCoor[ImNr]) >= 0

  End; { For ImNr := Bim to Eim }

      { -------------- End of Going Through Marks ------------------------------------------------- }

      { Get Bases - Gets Minimum in the Defined range By Finding the Smallest Value in Defined Nr of Consecutive Images }

  For M := 0 to High(DataForBase) do Begin
    MinBase := 100000; // just a Big Number
    For ImNr := 0 to High(DataForBase[M]) - (NrImGetMin - 1) Do Begin
      CurVal := 0;
      for Cnt := 0 to NrImGetMin - 1 do begin
        CurVal := CurVal + DataForBase[M, ImNr + Cnt];
      end;
      CurVal := CurVal / NrImGetMin;
      if MinBase > CurVal then MinBase := CurVal;
    End;
    DataForBase[M, 0] := MinBase;
  End; // For M := 0 to High(DataForBase)

      // Transfers results to Baseline Array

  CntMarks := 0;
  For ImNr := Bim to Eim Do Begin
    If High(MarkArrXY[ImNr]) >= 0 Then Begin { if there are marks }
      For M := 0 to High(MarkArrXY[ImNr]) do Begin
        MarkBase[ImNr, M] := DataForBase[CntMarks + M, 0];
        MarkAmpl[ImNr, M] := DataForBase[CntMarks + M,
        High(DataForBase[CntMarks + M])];
      End; // For M := 0 to High(MarkArrXY[ImNr])
      Inc(CntMarks, High(MarkArrXY[ImNr]) + 1);
    End; // If  High(MarkArrXY[ImNr]) >= 0
  End; // For ImNr := Bim to Eim
      { --------------------------------------------------------------- }

End; // GetMarksBaselines
  { ************************************************************************** }

Procedure GetDurForMark(Const MarkArrXY: TMarkArrXY;
                        var MarkAmpl: TDyn2DSingleArr; Const MarkBase: TDyn2DSingleArr;
                        var MarkEvDur: TMarkArrDur; var MarkRiseTime: TDyn2DSingleArr;
                        Const NrPtForBase: Word; Const BaseSearchRange: Word);

    // Used ONLY if RatioOn = True  or Ch1/Ch2//

Const DO_NOT_SMOOTH       = 0;
      SMOOTH_BEFORE_RATIO = 1;
      SMOOTH_AFTER_RATIO  = 2;

var
      ImNr, CntROI: Integer;
      Bim, Eim, M: Integer;
      Cnt, Filtering: Integer;
      NotFiltAvIm: TDynDoubleArray;
      XLL, Xrr, Yupp, Ydd: Integer;
      SmBoxOffset: Integer;
      SmMedOffset: Integer;
      SmGaussOffset: Integer;
      CntMarksDone: Integer;
      CntIm: Integer;
      CurVal: Double; // current Value = Current Mark (X,Y) selection
      Slope: Double;
      Ltime: array of Double; // exact Time from Left 1/2 peak to Peak
      Rtime: array of Double; // exact Time from Right 1/2 peak to Peak

      LDurPar: array of TDurParams;
      RDurPar: array of TDurParams;
      RiseTime: array of TRiseTimeParams;

      RawByteArr: TDynByteArray;
      RawWordArr: TDynWordArray;
      WordArrA: TDynWordArray;
      WordArrB: TDynWordArray;

    BEGIN

      { Sets Variables }

   If (SmoothMode > NO_SMOOTH) Then Begin
    if (RatioOn) and (frmImageControl.cbSmoothBeforeDoRatio.Checked) then
      Filtering := SMOOTH_BEFORE_RATIO
        else
    if ((RatioOn) and not(frmImageControl.cbSmoothBeforeDoRatio.Checked)) or (ChannelsRatioOn) then
      Filtering := SMOOTH_AFTER_RATIO
   End
    Else
    If (SmoothMode = NO_SMOOTH) Then
      Filtering := DO_NOT_SMOOTH;

  { 1st: Sets Offset for Smoothing }
  if (Filtering > DO_NOT_SMOOTH) then GetOffsetFor2DSmoothing(SmBoxOffset, SmMedOffset, SmGaussOffset);
      { Set if All Marks or One Row selected should be updated }

      Bim := 1; { starts from 2n Image }
      Eim := NrIm - 2; { finishes from 1 Image before end }

      { Starts Going Through Marks }
      For ImNr := Bim to Eim Do Begin

        If ( High(MarkArrXY[ImNr]) >= 0) Then Begin { if there are marks }

          { Looks If to Do All the Marks or Just Selected One }

          SetLength(Ltime, Length(MarkArrXY[ImNr]));
          // exact Time from Left 1/2 peak to Peak
          SetLength(Rtime, Length(MarkArrXY[ImNr]));
          // exact Time from Right 1/2 peak to Peak
          SetLength(LDurPar, Length(MarkArrXY[ImNr]));
          SetLength(RDurPar, Length(MarkArrXY[ImNr]));
          SetLength(RiseTime, Length(MarkArrXY[ImNr]));

          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            // for the left
            LDurPar[M].AmplAboveHalf := MarkAmpl[ImNr, M];
            LDurPar[M].ImNrAboveHalf := ImNr;
            LDurPar[M].AmplBelowHalf := CANNOT_BE_DONE;

            // for the rigth
            RDurPar[M].AmplAboveHalf := MarkAmpl[ImNr, M];
            RDurPar[M].ImNrAboveHalf := ImNr;
            RDurPar[M].AmplBelowHalf := CANNOT_BE_DONE;

            // for Rise Time Parameters
            // 90 %
            RiseTime[M].AmplAbove90 := MarkAmpl[ImNr, M];
            RiseTime[M].ImageNrAbove90 := ImNr;
            RiseTime[M].AmplBelow90 := CANNOT_BE_DONE;
            // 10%
            RiseTime[M].AmplAbove10 := MarkAmpl[ImNr, M];
            RiseTime[M].ImageNrAbove10 := ImNr;
            RiseTime[M].AmplBelow10 := CANNOT_BE_DONE;

          End;

          { ------------------------------------------------------------------------ }
          { Goes Left To The Spark Peak }
          CntMarksDone := -1;

          For CntIm := ImNr - 1 downto 0 Do Begin { always Starts from 1st Image }

            ReadImage(CntIm,0,pImData);
            if (Filtering = SMOOTH_BEFORE_RATIO) then SmoothBorders; { Smooths Just the Border of Image }

            For M := 0 to High(MarkArrXY[ImNr]) do Begin // Goes through All Marks On this ImNr
              GetMarkSelection(MarkArrXY, ImNr, M, XLL, Xrr, Yupp, Ydd);
              if (Filtering = SMOOTH_BEFORE_RATIO) then
                DoSmoothForROI(RawByteArr, RawWordArr, WordArrA, WordArrB, XLL,Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset, SmGaussOffset);
              if (Filtering = SMOOTH_AFTER_RATIO) and (RatioOn) then  DoRatio(NO_COPY);
              if (ChannelsRatioOn) then DoChannelRatio(NO_COPY);
              GetCurValue(XLL, Xrr, Yupp, Ydd, CurVal);

              { Beg of Evaluation to the Left }

              // for 90% of the Peak//
              If (RiseTime[M].AmplBelow90 < 0) then
              Begin // Image Nr Below 90% of Peak was not Yet Found
                if (CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) * 0.9) then
                begin
                  RiseTime[M].AmplBelow90 := CurVal;
                  RiseTime[M].ImageNrBelow90 := CntIm;
                end
                else if Not(CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) * 0.9) then
                begin
                  RiseTime[M].AmplAbove90 := CurVal;
                  RiseTime[M].ImageNrAbove90 := CntIm;
                end;
              End; // If (RiseTime[M].AmplBelow90 < 0) //

              // for Half of the Peak
              If (LDurPar[M].AmplBelowHalf < 0) then
              Begin // Image Nr Below 1/2 Peak was not Yet Found
                if (CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) / 2) then
                begin
                  LDurPar[M].AmplBelowHalf := CurVal;
                  LDurPar[M].ImNrBelowHalf := CntIm;
                end
                else if Not(CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) / 2) then
                begin
                  LDurPar[M].AmplAboveHalf := CurVal;
                  LDurPar[M].ImNrAboveHalf := CntIm;
                end;
              End; // If LDurPar[M].AmplBelowHalf < 0 //

              // for 10% of the Peak//
              If (RiseTime[M].AmplBelow10 < 0) then
              Begin // Image Nr Below 10% of Peak was not Yet Found
                if (CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) * 0.1) then
                begin
                  RiseTime[M].AmplBelow10 := CurVal;
                  RiseTime[M].ImageNrBelow10 := CntIm;
                  Inc(CntMarksDone); // equivalent to Break = Done with this M number - muve to the next one
                end
                else if Not(CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) * 0.1) then
                begin
                  RiseTime[M].AmplAbove10 := CurVal;
                  RiseTime[M].ImageNrAbove10 := CntIm;
                end;
              End; // If LDurPar[M].AmplBelowHalf < 0 //

              { End  of Evaluation }

            End; { For M := FirstM to LastM do Begin }
            If CntMarksDone = High(MarkArrXY[ImNr]) then
              Break;
          End; { For CntIm := ImNr-1 downto Bim Do Begin }

          { Get Left Time for 1/2 of Peak }
          For M := 0 to High(MarkArrXY[ImNr]) do
          Begin
            If (LDurPar[M].AmplBelowHalf > CANNOT_BE_DONE) then Begin
              // Slope = DeltaAmpl/DeltaTime//
              Slope := (LDurPar[M].AmplAboveHalf - LDurPar[M].AmplBelowHalf) /
                (TimeSt[LDurPar[M].ImNrAboveHalf] - TimeSt
                  [LDurPar[M].ImNrBelowHalf]);
              // this the absolute Time at which 1/2 Peak appears
              Ltime[M] := ((MarkAmpl[ImNr, M] - MarkBase[ImNr, M]) / 2 -
                  (LDurPar[M].AmplBelowHalf - MarkBase[ImNr, M]))
                / Slope + TimeSt[LDurPar[M].ImNrBelowHalf];
              // this is the diference between Peak Time and 1/2 Peak time to the Left of Peak
              Ltime[M] := TimeSt[ImNr] - Ltime[M];
              // Note: GetPeak uses Absolute Time
            End
            Else
              Ltime[M] := CANNOT_BE_DONE; ; // indicates that 1/2 Duration Cannot be Neasured//
          End; // Get Left Time : For M := FirstM to  LastM

          { ************************ End of the Left Time for 1/2 of Peak ************************** }

          { ************************ Beg of the Right Time ************************** }
          { Goes Right To The Spark Peak }
          CntMarksDone := -1;

          For CntIm := ImNr + 1 to NrIm - 1 Do Begin { always looks to the Last Image }

            ReadImage(CntIm,0,pImData);
           if (SmoothMode > NO_SMOOTH) then SmoothBorders; { Smooths Just the Border of Image }

            For M := 0 to High(MarkArrXY[ImNr]) do
            Begin // Goes through All Marks On this ImNr
              GetMarkSelection(MarkArrXY, ImNr, M, XLL, Xrr, Yupp, Ydd);
              if (Filtering = SMOOTH_BEFORE_RATIO) then
                DoSmoothForROI(RawByteArr, RawWordArr, WordArrA, WordArrB, XLL,Xrr, Yupp, Ydd, SmBoxOffset, SmMedOffset, SmGaussOffset);
               if (Filtering = SMOOTH_AFTER_RATIO) and (RatioOn) then  DoRatio(NO_COPY);
              if (ChannelsRatioOn) then DoChannelRatio(NO_COPY);
              GetCurValue(XLL, Xrr, Yupp, Ydd, CurVal);

              { Beg of Evaluation to the Right }
              If RDurPar[M].AmplBelowHalf < 0 then
              Begin // Image Nr Below 1/2 Peak was not Yet Found
                if (CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) / 2) then
                begin
                  RDurPar[M].AmplBelowHalf := CurVal;
                  RDurPar[M].ImNrBelowHalf := CntIm;
                  Inc(CntMarksDone); // equivalent to Break = Done with this M number - muve to the next one
                end
                else if Not(CurVal - MarkBase[ImNr, M] < (MarkAmpl[ImNr,
                    M] - MarkBase[ImNr, M]) / 2) then
                begin
                  RDurPar[M].AmplAboveHalf := CurVal;
                  RDurPar[M].ImNrAboveHalf := CntIm;
                end;
              End;
              { End  of Evaluation }

            End; { For M := FirstM to LastM do Begin }
            If CntMarksDone = High(MarkArrXY[ImNr]) then
              Break;
          End; { For CntIm := ImNr+1 to Eim Do Begin }

          { Get Right Time }
          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            If (RDurPar[M].AmplBelowHalf > CANNOT_BE_DONE) then Begin
              // Slope = DeltaAmpl/DeltaTime//
              Slope := (RDurPar[M].AmplAboveHalf - RDurPar[M].AmplBelowHalf) /
                (TimeSt[RDurPar[M].ImNrAboveHalf] - TimeSt
                  [RDurPar[M].ImNrBelowHalf]);
              // this the absolute Time at which 1/2 Peak appears
              Rtime[M] := ((MarkAmpl[ImNr, M] - MarkBase[ImNr, M]) / 2 -
                  (RDurPar[M].AmplBelowHalf - MarkBase[ImNr, M]))
                / Slope + TimeSt[RDurPar[M].ImNrBelowHalf];
              Rtime[M] := Rtime[M] - TimeSt[ImNr]; // this is the diference between Peak Time and 1/2 Peak time to the Left of Peak
            End
            Else
              Rtime[M] := CANNOT_BE_DONE; ; // indicates that 1/2 Duration Cannot be Neasured//
          End; // Get Left Time : For M := FirstM to  LastM

          { ******************** End of the Right Time for 1/2 Decay *************************** }

          // fill Buffers (now Ltime and Rtime can be reused below for Rise Time)

          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            if (Ltime[M] > CANNOT_BE_DONE) and (Rtime[M] > CANNOT_BE_DONE) then begin
              MarkEvDur[ImNr, M].L := Ltime[M];
              MarkEvDur[ImNr, M].R := Rtime[M];
            end;
          End;
          { **************** Calculates the 10% and 90% times and Finally Rise Time ********* }

          { Reuses the Ltime and Rtime for 10% and 90 of peak (Ltime = 10% time, Rtime = 90% time }

          { Get Time for 90% of Peak }
          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            If (RiseTime[M].AmplBelow90 > CANNOT_BE_DONE) then Begin
              // Slope = DeltaAmpl/DeltaTime//
              Slope := (RiseTime[M].AmplAbove90 - RiseTime[M].AmplBelow90) /
                (TimeSt[RiseTime[M].ImageNrAbove90] - TimeSt[RiseTime[M].ImageNrBelow90]);
              // this the absolute Time at which 1/2 Peak appears
              Rtime[M] := ((MarkAmpl[ImNr, M] - MarkBase[ImNr, M]) * 0.9 -
                  (RiseTime[M].AmplBelow90 - MarkBase[ImNr, M]))/ Slope + TimeSt[RiseTime[M].ImageNrBelow90];
            End
            Else
              Ltime[M] := CANNOT_BE_DONE; ; // indicates that 1/2 Duration Cannot be Neasured//
          End; // Get Left Time : For M := FirstM to  LastM

          { Get Time for 10% of Peak }
          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            If (RiseTime[M].AmplBelow10 > CANNOT_BE_DONE) then Begin
              // Slope = DeltaAmpl/DeltaTime//
              Slope := (RiseTime[M].AmplAbove10 - RiseTime[M].AmplBelow10) / (TimeSt[RiseTime[M].ImageNrAbove10] - TimeSt
                  [RiseTime[M].ImageNrBelow10]);
              // this the absolute Time at which 1/2 Peak appears
              Ltime[M] := ((MarkAmpl[ImNr, M] - MarkBase[ImNr, M]) * 0.1 -
                  (RiseTime[M].AmplBelow10 - MarkBase[ImNr, M])) / Slope + TimeSt[RiseTime[M].ImageNrBelow10];
            End
            Else
              Ltime[M] := CANNOT_BE_DONE; // indicates that 1/2 Duration Cannot be Neasured//
          End; // Get Left Time : For M := FirstM to  LastM

          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            if (Ltime[M] > CANNOT_BE_DONE) and (Rtime[M] > CANNOT_BE_DONE) then
              MarkRiseTime[ImNr, M] := Rtime[M] - Ltime[M]
            else
              MarkRiseTime[ImNr, M] := CANNOT_BE_DONE;
          End;

          { ****************** End of Finding Times ********************************* }

          { ******************** Corrects Peak Amplitude *************************** }
          For M := 0 to High(MarkArrXY[ImNr]) do Begin
            MarkAmpl[ImNr, M] := MarkAmpl[ImNr, M] + (1 - MarkBase[ImNr, M]);
          End;
          { ******************** End of Corrects Peak Amplitude *************************** }

          /// /////////////////////////////////////////////////

        End; // If  (High(MarkArrXY[ImNr]) >= 0)

      End; { For ImNr := Bim to Eim }
      { --------------------------------------------------------------- }

End; { Procedure GetDurForMark }

  { ************************************************************************** }

  Procedure RefillStringGridEvents(var StrGrid: TStringGrid;
      var MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr;
      var MarkEvDur: TMarkArrDur; var MarkRiseTime: TDyn2DSingleArr;
      var MarkBase: TDyn2DSingleArr);

    Var
      Rcnt, ImN, i: Integer;

    Begin

      With StrGrid Do
      Begin
        Rcnt := 1;
        For ImN := 0 to NrIm - 1 Do
        Begin
          If High(MarkArrXY[ImN]) >= 0 Then
            For i := 0 to High(MarkArrXY[ImN]) Do
            Begin
              { Cells[0,Rcnt-1] := IntToStr(Rcnt-1); }
              Cells[1, Rcnt] := IntToStr(ImN + 1); { Image # }
              Cells[2, Rcnt] := IntToStr(MarkArrXY[ImN, i].x);
              Cells[3, Rcnt] := IntToStr(MarkArrXY[ImN, i].y);

              Cells[4, Rcnt] := FloatToStrF(MarkAmpl[ImN, i], ffFixed, 5, 3);

              // Rise Time

              if MarkRiseTime[ImN, i] > CANNOT_BE_DONE then
                Cells[5, Rcnt] := FloatToStrF(MarkRiseTime[ImN, i] * 1000,
                  ffFixed, 5, 3)
              else if MarkRiseTime[ImN, i] = CANNOT_BE_DONE then
                Cells[5, Rcnt] := '-'
              else if (MarkRiseTime[ImN, i] = NOT_ANALYZED) then
                Cells[5, Rcnt] := '';

              // Duration
              if (MarkEvDur[ImN, i].L > CANNOT_BE_DONE) and
                (MarkEvDur[ImN, i].R > CANNOT_BE_DONE) then
              // Duration needs Left Time
                Cells[6, Rcnt] := FloatToStrF
                  ((MarkEvDur[ImN, i].L + MarkEvDur[ImN, i].R) * 1000,
                  ffFixed, 5, 3)
              else if (MarkEvDur[ImN, i].L = CANNOT_BE_DONE) or
                (MarkEvDur[ImN, i].R = CANNOT_BE_DONE) then
                Cells[6, Rcnt] := '-'
              else if (MarkEvDur[ImN, i].L = NOT_ANALYZED) or
                (MarkEvDur[ImN, i].R = NOT_ANALYZED) then
                Cells[6, Rcnt] := '';

              // Decay
              if MarkEvDur[ImN, i].R > CANNOT_BE_DONE then // Decay
                Cells[7, Rcnt] := FloatToStrF(MarkEvDur[ImN, i].R * 1000,
                  ffFixed, 5, 3)
              else if MarkEvDur[ImN, i].R = CANNOT_BE_DONE then
                Cells[7, Rcnt] := '-'
              else if (MarkEvDur[ImN, i].L = NOT_ANALYZED) or
                (MarkEvDur[ImN, i].R = NOT_ANALYZED) then
                Cells[7, Rcnt] := '';

              // Baseline
              Cells[8, Rcnt] := FloatToStrF(MarkBase[ImN, i], ffFixed, 5, 3);

              Inc(Rcnt);
            End; { For Every Image }
        End; { For ImN := 1 to NrIm }
      End; { With }

    End;


 { ************************************************************************** }

Function GetMeanROI(Const XLL, Xrr, Yupp, Ydd: Integer; Const KindROI: Integer) : Double; { Gives Mean in ROI (Boxes or Circles }

var CntX, CntY, NrElem : Integer;

Begin

  NrElem := (Xrr - XLL + 1) * (Ydd - Yupp + 1);
  Result := 0;

  { For Non-Ratioed Images }

  If not(RatioOn) and Not(ChannelsRatioOn) Then Begin

    If (SmoothMode > NO_SMOOTH) and (SmoothNonRatio in [SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH])
    Then Begin
       for CntY := Yupp to Ydd do
        for CntX := XLL to Xrr do
          Result := Result + (Im16bitDataSM_Last[CntX + imXsize * CntY]);
    End
      Else
    Begin
      If (BitCount = 16) Then begin
        for CntY := Yupp to Ydd do
        for CntX := XLL to Xrr do
          Result := Result + (Im16bitData[CntX + imXsize * CntY]);
      End
        Else
      If (BitCount = 8) Then begin
        for CntY := Yupp to Ydd do
        for CntX := XLL to Xrr do
          Result := Result + (Im8bitData[CntX + imXsize * CntY]);
      End
    End;

    if (KindROI = 1) then Result := Result / NrElem;

  End // If not(RatioOn) and Not(ChannelsRatioOn)

    Else

      { For Ratioed Images }
  If (RatioOn) or (ChannelsRatioOn) Then Begin
    for CntY := Yupp to Ydd do
      for CntX := XLL to Xrr do
        Result := Result + (ImDataRat[CntX + imXsize * CntY]);

      if (KindROI = 1) then  Result := Result / (NrElem * DispFact);
  End; { (RatioOn = True) }
End; { Function GetMeanROI; }
  { ************************************************************************** }
Procedure MakeMetaFile(const SaveAsFile: Boolean;
      const PlotData: TDyn2DDoubleArr; const MFName: AnsiString);
    Var

      LogRec: TLogFont; { Win GDI Structure:  LOGFONT structure }
      OldFontHandle, NewFontHandle: hFont;
      { Trace vars }
      CntROI: Integer;
      ImNr, CntPeak: Integer;
      BegIm, EndIm: Integer;
      MFTraceArr: array of TPoint;
      Ypeak: Integer; { calculates Once for speed and clarity, Peaks Only }
      { metafile variables }
      mf: TMetaFile;
      MfCanvas: TMetaFileCanvas;
      ClipBrdFormat : Word;
      aData         : NativeUInt;
      aPalette      : hPalette;
      { X ticks vars }
      BigXTick, NrBigXTick, NrSmXTick, i, j: Integer;
      BigXTickBeg: Integer;
      Lab: AnsiString;
      LabOff, Xoff, XoffUse: Integer;
      XSleft, XLmin: Integer; { position of Left & Right Slider }
      SmXTick: Single;
      BigTickTime: Extended;
      DigAftZero: Integer;
      { BigXTick = Number of Images whitin Tick }
      { Y ticks vars }
      BigYTick: Integer; { size in pix }
      NrBigYTick, NrSmYTick: Integer;
      SmYTick: Single;

    Begin

      Clipboard.Clear;

      mf := TMetaFile.Create;
      mf.Enhanced := True;
      mf.Width := frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Width;
      mf.Height := frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Height;
      MfCanvas := TMetaFileCanvas.Create(mf, 0);
      { ----------------------------------------------------- }
      With MfCanvas Do
      Begin
        { ----------------------------------------------------- }
        { 1st:  Draws just X axes }
        Pen.Color := clBlack;
        MoveTo(PlXaxBeg, PlYaxBeg);
        LineTo(TimPltSlid.WinXSize, PlYaxBeg);
        MoveTo(PlXaxBeg, PlYaxEnd);
        LineTo(TimPltSlid.WinXSize, PlYaxEnd);

        { 2nd: Draws Y axes & Labels for Both X & Y axes }
        { Draws X and Y Axes }
        Font.Name := 'Arial';
        Font.Size := 8;
        Font.Color := clBlack;
        Pen.Color := clBlack;
        Brush.Style := bsClear;
        MoveTo(PlXaxBeg, PlYaxBeg);
        LineTo(PlXaxBeg, PlYaxEnd);
        MoveTo(TimPltSlid.WinXSize - 1, PlYaxBeg);
        LineTo(TimPltSlid.WinXSize - 1, PlYaxEnd);
        { vertical title }
        GetObject(Font.Handle, SizeOf(LogRec), Addr(LogRec));
        LogRec.lfEscapement := 90 * 10; { angle*10 }
        { Specifies the angle, in tenths of degrees, between the escapement vector and the x-axis }
        LogRec.lfOrientation := 90 * 10;
        { Specifies the angle, in tenths of degrees, between each character's base line and the x-axis of the device }
        NewFontHandle := CreateFontIndirect(LogRec);
        OldFontHandle := SelectObject(Handle, NewFontHandle);
        If (PLOTvar.AnalType = INTENSITY_TIME) then
          TextOut(1, 180, 'Intensity')
        else If (PLOTvar.AnalType = RATIO_TIME) then
          TextOut(1, 160, 'F/Fo')
        else If (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then begin
          if (PLOTvar.ChannelOrderUsed = ASCENDING) then
          TextOut(1, 160, 'Ch1/Ch2') else
          if (PLOTvar.ChannelOrderUsed = ASCENDING) then
          TextOut(1, 160, 'Ch2/Ch1');
        end
        else If (PLOTvar.AnalType = Ca_CONC_TIME) then
          TextOut(1, 160, 'Ca (µM)')
        else If (PLOTvar.AnalType = DISTANCE_TIME) then
          TextOut(1, 180, 'Distance (' + Char(181) + 'm)');
        NewFontHandle := SelectObject(Handle, OldFontHandle);
        DeleteObject(NewFontHandle);

        { 3rd: DrawTimeSerPlotXticks }

        XLmin := frmTimeSerPlot.dsXaxes.Min;
        XSleft := frmTimeSerPlot.dsXaxes.PosFrom;

        if (Xrange >= 50) then
          BigXTick := (Xrange div 5)
        else
          BigXTick := (Xrange div 2);

        if BigXTick >= 10 then
          BigXTick := (BigXTick div 10) * 10
        else if BigXTick <= 2 then
          BigXTick := (BigXTick div 2) * 2
        else
          BigXTick := (BigXTick div 5) * 5; { BigTick = Size in Units }

        If (BigXTick = 0) Then
          BigXTick := 1;

        if BigXTick >= 10 then
          NrSmXTick := 10
        else
          NrSmXTick := BigXTick;
        SmXTick := BigXTick / NrSmXTick;

        BigTickTime := BigXTick * MeanImTime; { temporarily holds this value }
        if trunc(BigTickTime) >= 1 then
          DigAftZero := 1
        else
          DigAftZero := 7 - Length(IntToStr(trunc(frac(BigTickTime) * 100000)));

        TextOut(PlXbeg + 200, 2, PLOTvar.Title);
        TextOut(PlXbeg, 2, 'Seconds');
        TextOut(PlXbeg, PlYbeg + 30, 'Number of Images');

        Xoff := 0;
        While Xoff < XSleft Do
        Begin
          if Xoff < XSleft then
            Inc(Xoff, BigXTick);
        End;
        Dec(Xoff);
        { shifts Xoff to the left by one; Because Images are numbered From 1 }
        NrBigXTick := Xrange div BigXTick;
        j := 1;

        For i := 0 to NrBigXTick Do
        Begin { Draws Ticks }

          if (XSleft = 0) and (i = 0) then
            XoffUse := Xoff + 1
          Else
            XoffUse := Xoff;
          If BigXTick * i + (XoffUse - XSleft) >= 0 Then
          Begin
            { Bottom Images }
            MoveTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxBeg);
            LineTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxBeg + 5);
            { Top - Seconds }
            MoveTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxEnd);
            LineTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxEnd - 5);

            { PlXbeg is used in order to get 0 alligned with Traces }
            { Bottom Tick Labels }
            Lab := IntToStr((BigXTick * i + XoffUse) + 1); { 1st image = 1 }
            LabOff := (Length(Lab) * 6) div 2;
            TextOut(PlXaxBeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale) - LabOff, PlYaxBeg + 6, Lab);
            { Top Tick Labels }
            if (BigXTick * i + XoffUse - XLmin <= High(CopyOfTimeSt)) then
              BigTickTime := CopyOfTimeSt[BigXTick * i + Xoff - XLmin];
            if BigTickTime > 0.000001 then
              Lab := FloatToStrF(BigTickTime, ffFixed, 5, DigAftZero)
            else
              Lab := '0';
            LabOff := (Length(Lab) * 5) div 2;
            TextOut(PlXaxBeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale) - LabOff, PlYaxEnd - 20, Lab);
            if i = 0 then
              while (Xoff - XSleft) - (SmXTick * j) >= 0 do
              begin
                { Bottom - Images }
                MoveTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxBeg);
                LineTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxBeg + 3);
                { Top - Seconds }
                MoveTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxEnd);
                LineTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxEnd - 3);
                Inc(j);
              end;
            for j := 1 to NrSmXTick - 1 do
            begin
              if PlXbeg + round
                ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft)) * Xscale)
                <= TimPltSlid.WinXSize Then
              Begin
                { Bottom - Images }
                MoveTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxBeg);
                LineTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxBeg + 3);
                { Top - Seconds }
                MoveTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxEnd);
                LineTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxEnd - 3);
              end;
            end;
          end;
        End; { For i := BigXTickBeg to NrBigYTick }

        { 4th:  DrawTimeSerPlotYticks }
        BigYTick := (Yrange div 5);

        If (BigYTick = 0) Then
          BigYTick := 1
        else If (BigYTick > 5) and (BigYTick < 10) Then
          BigYTick := (BigYTick div 5) * 5
        else If (BigYTick >= 10) Then
          BigYTick := (BigYTick div 10) * 10;

        If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then
        Begin
          NrBigYTick := 200 div BigYTick;
        End
          Else
        Begin
          if (BitCount = 16) then
            NrBigYTick := 1023 div BigYTick
          else if (BitCount = 8) then
            NrBigYTick := 255 div BigYTick;
        End;

        If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then
        begin
          if NrBigYTick <= 5 then
            NrSmYTick := 10
          else
            NrSmYTick := 5;
        End
          Else
        Begin
          if (BigYTick >= 10) and (NrBigYTick <= 5) then
            NrSmYTick := 10
          else if (BigYTick >= 10) and (NrBigYTick > 5) then
            NrSmYTick := 5
          else if (BigYTick < 10) then
            NrSmYTick := BigYTick;
        End;
        SmYTick := BigYTick / NrSmYTick;

        frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Color :=
          clBlack;
        frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.FillRect
          (Rect(14, 45, PlXaxBeg, 260));

        For i := 0 to NrBigYTick Do
        Begin { Draws Ticks }
          if (i * BigYTick >= frmTimeSerPlot.dsYaxes.PosFrom) and
            (i * BigYTick <= frmTimeSerPlot.dsYaxes.PosTo) then
          begin

            MoveTo(PlXaxBeg - 5,
              PlYbeg - round((BigYTick * i - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale));
            LineTo(PlXaxBeg,
              PlYbeg - round((BigYTick * i - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale));

            If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then
              Lab := FloatToStrF((BigYTick * i) / 10, ffFixed, 2, 1)
            else
              Lab := IntToStr(BigYTick * i);
            TextOut(PlXbeg - (Length(Lab) * 7 + 8),
              PlYbeg - round((BigYTick * i - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale) - 8, Lab);
            for j := 1 to NrSmYTick - 1 do
            begin
              if PlYbeg - round
                ((BigYTick * i + SmYTick * j - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale) >= PlYend then
              begin
                MoveTo(PlXaxBeg - 3,
                  PlYbeg - round
                    ((BigYTick * i + SmYTick * j -
                        frmTimeSerPlot.dsYaxes.PosFrom) * Yscale));
                LineTo(PlXaxBeg,
                  PlYbeg - round
                    ((BigYTick * i + SmYTick * j -
                        frmTimeSerPlot.dsYaxes.PosFrom) * Yscale));
              end;
            end;
          end;
        End; { For i := BigYTickBeg to NrBigYTick }

        { ------------5th:  Starts Plotting Traces ------------------------ }
        BegIm := frmTimeSerPlot.dsXaxes.PosFrom;
        EndIm := frmTimeSerPlot.dsXaxes.PosTo;
        { ----------------------------------------------------- }
        SetLength(MFTraceArr, EndIm - BegIm + 1);
        For CntROI := 0 to (PLOTvar.NrROI - 1) Do
        Begin

          If PLOTvar.AdrUsed[CntROI] > 0 then
          Begin
            if ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]] <> clWhite then
              Pen.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]]
            else
              Pen.Color := clBlack;

            if (frmTimeSerPlot.CheckBoxSymbolOn.Checked = True) or
              (PLOTvar.HasPeaks = True) then
            begin
              if ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]] <> clWhite then
                Brush.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]]
              else
                Brush.Color := clBlack;
            end;

            if ROIvar.TickLine <> PLOTvar.AdrUsed[CntROI] then
              Pen.Width := 1
            else
              Pen.Width := 3;

            For ImNr := BegIm to EndIm Do
            Begin

              MFTraceArr[ImNr - BegIm].x := PlXbeg + round
                ((ImNr - BegIm) * Xscale);
              MFTraceArr[ImNr - BegIm].y := PlYbeg - round
                (Yscale * PlotData[CntROI, (ImNr - PLOTvar.ImBeg)]
                  - frmTimeSerPlot.dsYaxes.PosFrom * Yscale);

            End; { For ImNr := Beg to  ToEnd - 1 Do Begin }
            Polyline(MFTraceArr);

            { if symbol was chosen or Im Nr from Tables Clicked }
            If frmTimeSerPlot.CheckBoxSymbolOn.Checked = True then
            Begin
              If PLOTvar.ImNrFromTable = -1 then
              Begin
                { Draws "Regular" Symbols for Each Image }
                For ImNr := BegIm to EndIm Do
                Begin
                  Ellipse(MFTraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);
                End; { For ImNr := Beg to  ToEnd - 1 Do Begin }
              End
              Else If PLOTvar.ImNrFromTable > -1 then
              Begin
                { Draws the Symbol For The Image Number as Clicked on table }
                For ImNr := BegIm to EndIm Do
                Begin
                  If PLOTvar.AdrUsed[CntROI] = 20 Then
                  Begin { Last Trace # 20, White Color }
                    if ImNr = PLOTvar.ImNrFromTable then
                    Begin
                      Brush.Color := TimPltSlid.SymbFromTableCol;
                      Pen.Color := TimPltSlid.SymbFromTableCol;
                    end
                    else
                    begin
                      Pen.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
                      Brush.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
                    end;
                    if Pen.Color = clWhite then
                      Pen.Color := clBlack;
                    if Brush.Color = clWhite then
                      Brush.Color := clBlack;
                  End;
                  { If CntROI = 19 Then Begin = Last Trace # 20, White Color }
                  Ellipse(MFTraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);
                End; { For ImNr := Beg to  ToEnd - 1 Do Begin }
              End; { If PLOTvar.ImNrFromTable > -1 then Begin }
            End; { If frmTimeSerPlot.CheckBoxSymbolOn.Checked = True }
            If (TimPltSlid.AlwaysUseSymb = True) Then
            Begin
              If PLOTvar.ImNrFromTable > -1 then
              Begin
                If PLOTvar.AdrUsed[CntROI] = 20 Then
                Begin
                  ImNr := PLOTvar.ImNrFromTable;
                  if TimPltSlid.SymbFromTableCol <> clWhite then
                  begin
                    Brush.Color := TimPltSlid.SymbFromTableCol;
                    Pen.Color := TimPltSlid.SymbFromTableCol;
                  end
                  else
                  begin
                    Pen.Color := clBlack;
                    Brush.Color := clBlack;
                  end;
                  Ellipse(MFTraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                    MFTraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);
                End; { PLOTvar.AdrUsed[CntROI] = 20 }
              End; { If PLOTvar.ImNrFromTable > -1 }
            End; { If (PLOTvar.AlwaysUseSymb = True) }
            { Ellipse(X1, Y1, X2, Y2) }

            { --------------  Peaks Part ---------------------------------------- }
            { Now Puts Symbols; so far circles for peaks found }

            If (PLOTvar.HasPeaks = True) and (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then
            Begin
              { ------------------------------------------------------- }
              If PeakFakeImNrArr <> nil Then // PeakPosArr is not used here on purpose, see below
                if High(PeakFakeImNrArr[CntROI]) > CANNOT_BE_DONE then
                  For CntPeak := 0 to High(PeakFakeImNrArr[CntROI]) Do
                  Begin
                    if TimPltSlid.GetPeaks then
                      ImNr := PeakPosArr[CntROI, CntPeak] + PLOTvar.ImBeg
                      { done here for clarity }
                    else
                      ImNr := PLOTvar.ImNrFromTable;

                    if (ImNr >= BegIm) and (ImNr <= EndIm) Then
                    Begin
                      { Puts Symbol on Peak }
                      Ellipse(MFTraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                        MFTraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                        MFTraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                        MFTraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);

                      if (PeakFakeImNrArr[CntROI,
                        CntPeak].Lim > CANNOT_BE_DONE) and
                        (PeakFakeImNrArr[CntROI,
                        CntPeak].Rim > CANNOT_BE_DONE) Then
                      Begin

                        { Calculates Y at 1/2 amplitude }
                        Ypeak := PlYbeg - round
                          (Yscale * ((PlotData[CntROI,
                              (ImNr - PLOTvar.ImBeg)] - 10) / 2 + 10)
                            - frmTimeSerPlot.dsYaxes.PosFrom * Yscale);

                        { Draws 1/2 amplitude Line usin Fake ImNr = Time/Time for One Image }

                        MoveTo(PlXbeg + round((PeakFakeImNrArr[CntROI,
                              CntPeak].Lim - BegIm) * Xscale), Ypeak);
                        LineTo(PlXbeg + round((PeakFakeImNrArr[CntROI,
                              CntPeak].Rim - BegIm) * Xscale), Ypeak);

                        { Draws Verical Line to 1/2 Amplitude }

                        MoveTo(MFTraceArr[ImNr - BegIm].x,
                          MFTraceArr[ImNr - BegIm].y);
                        LineTo(MFTraceArr[ImNr - BegIm].x, Ypeak);
                      end
                      else { if Both PeakTimArr[CntROI,CntPeak,0] and [1]> 0 }
                      { if only right side found }
                      if (PeakFakeImNrArr[CntROI, CntPeak].Lim < TIME_DONE) and
                        (PeakFakeImNrArr[CntROI, CntPeak].Rim > CANNOT_BE_DONE)
                        Then
                      Begin
                        { Calculates Y at 1/2 amplitude }
                        Ypeak := PlYbeg - round
                          (Yscale * ((PlotData[CntROI,
                              (ImNr - PLOTvar.ImBeg)] - 10) / 2 + 10)
                            - frmTimeSerPlot.dsYaxes.PosFrom * Yscale);
                        { Draws Only t1/2 Deacay Line usin Fake ImNr = Time/Time for One Image }
                        MoveTo(MFTraceArr[ImNr - BegIm].x, Ypeak);
                        LineTo(PlXbeg + round((PeakFakeImNrArr[CntROI,
                              CntPeak].Rim - BegIm) * Xscale), Ypeak);
                        { Draws Verical Line to 1/2 Amplitude }

                        MoveTo(MFTraceArr[ImNr - BegIm].x,
                          MFTraceArr[ImNr - BegIm].y);
                        LineTo(MFTraceArr[ImNr - BegIm].x, Ypeak);
                      end;
                      { if Right Side only PeakTimArr[CntROI,CntPeak,0]=0  and [1]> 0 }
                    end; { if (ImNr >= BegIm) and (ImNr <= EndIm) }
                  End; { For ImNr := 0 to High(TimSerPlotData[CntROI]) }
              { ------------------------------------------------------- }
            End; { frmTimeSerPlot.cbGetPeaks.Checked = True }
            { ------------- End with Peaks ----------------------------------- }

          End; { With  FmCanvas Do Begin }
          { --------------------------------------------------------------------------- }
        End; { If PLOTvar.AdrUsed[CntROI] > 0 }
      End; { For CntROI := 0 to (BoxPar.NrB - 1) }
      MfCanvas.Free;
      If SaveAsFile = False then
      Begin
        mf.SaveToClipboardFormat(ClipBrdFormat, aData, aPalette);
        Clipboard.SetAsHandle(ClipBrdFormat, aData);
      End
      Else If SaveAsFile = True then
      Begin
        mf.SaveToFile(MFName);
      End;
      mf.Free;
    End; { Procedure MakeMetaFile }

{ ************************************************************************** }
    Procedure DrawTimeSerPlotTraces(Sender: TObject; Const PlotData: TDyn2DDoubleArr);
    Var

      CntROI: Integer;
      ImNr, CntPeak: Integer;
      BegIm, EndIm: Integer;
      Ypeak: Integer; { calculates Once for speed and clarity, Peaks Only }

      MemPos, CntPix: Integer;
      MinVal, MaxVal: Double;
      Compress: Boolean;

    Begin

      with frmTimeSerPlot.FrameTimSerPlot do
      begin
        imgTimeSerPlot.Canvas.Brush.Color := clBlack;
        imgTimeSerPlot.Canvas.FillRect(Rect(PlXbeg, PlYend,
            TimPltSlid.WinXSize, PlYbeg + 1));
      end;

      { ------------ Starts Plotting ------------------------ }

      BegIm := frmTimeSerPlot.dsXaxes.PosFrom;
      EndIm := frmTimeSerPlot.dsXaxes.PosTo;

      { ----------------------------------------------------- }

      { ------------ 1st: Draws Traces ------------------------ }

      // Checks if To Compress or Not //
      If ((EndIm - BegIm + 1) > 2 * (TimPltSlid.WinXSize - PlXbeg)) and Not
        (frmTimeSerPlot.CheckBoxSymbolOn.Checked) then
      Begin
        if (Sender <> frmTimeSerPlot.dsYaxes) or
          ( High(TraceArr) + 1 <> 2 * (TimPltSlid.WinXSize - PlXbeg)) then
          SetLength(TraceArr, 2 * (TimPltSlid.WinXSize - PlXbeg));
        Compress := True;
      End
      Else
      Begin
        if (Sender <> frmTimeSerPlot.dsYaxes) then
          SetLength(TraceArr, EndIm - BegIm + 1);
        Compress := False;
      End;

      If (Compress) Then
      Begin // Writes X plot values for all ROIs
        MemPos := 0;
        CntPix := 0;
        for ImNr := BegIm to EndIm do
        begin
          if (MemPos <> round((ImNr - BegIm) * Xscale)) then
          begin
            TraceArr[CntPix].x := PlXbeg + MemPos;
            TraceArr[CntPix + 1].x := TraceArr[CntPix].x;
            Inc(CntPix, 2);
            Inc(MemPos);
          end;
        end; // for ImNr := BegIm to EndIm
      End; // If Compress

      With frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot Do
      Begin
        { ----- starts going through ROIs --------- }

        For CntROI := 0 to (PLOTvar.NrROI - 1) Do
        Begin
          // ---------------------------------------------------//

          If PLOTvar.AdrUsed[CntROI] > 0 then
          Begin
            Canvas.Pen.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];

            // ---------------------------------------------------//

            if (ROIvar.TickLine <> PLOTvar.AdrUsed[CntROI]) then
              Canvas.Pen.Width := 1
            else
              Canvas.Pen.Width := 3;

            // --- Writes Y pixes values for Baseline ---//
            If (TimPltSlid.BaseLineOption = GET_BASELINE) Then
            Begin

              If (Compress) Then
              Begin
                MemPos := 0;
                CntPix := 0;
                MinVal := High(Word);
                MaxVal := 0;
                For ImNr := BegIm to EndIm do
                Begin
                  if MemPos = round((ImNr - BegIm) * Xscale) then
                  begin
                    if MinVal > TSPlotData_BaseLine[CntROI,
                      (ImNr - PLOTvar.ImBeg)] then
                      MinVal := TSPlotData_BaseLine[CntROI,
                        (ImNr - PLOTvar.ImBeg)];

                    if MaxVal < TSPlotData_BaseLine[CntROI,
                      (ImNr - PLOTvar.ImBeg)] then
                      MaxVal := TSPlotData_BaseLine[CntROI,
                        (ImNr - PLOTvar.ImBeg)];
                  end
                  else if MemPos <> round((ImNr - BegIm) * Xscale) then
                  begin
                    TraceArr[CntPix].y := PlYbeg - round
                      (Yscale * MinVal - frmTimeSerPlot.dsYaxes.PosFrom *
                        Yscale);
                    TraceArr[CntPix + 1].y := PlYbeg - round
                      (Yscale * MaxVal - frmTimeSerPlot.dsYaxes.PosFrom *
                        Yscale);
                    Inc(CntPix, 2);
                    Inc(MemPos);
                    MinVal := High(Word);
                    MaxVal := 0;
                  end;
                End; // for ImNr := BegIm to EndIm
              End
              Else // If Compress

              /// Writes Y pix values in Conventional  way
              If Not(Compress) then For ImNr := BegIm to EndIm Do
              Begin

                  TraceArr[ImNr - BegIm].x := PlXbeg + round((ImNr - BegIm) * Xscale);
                  TraceArr[ImNr - BegIm].y := PlYbeg - round(Yscale * TSPlotData_BaseLine[CntROI,
                    (ImNr - PLOTvar.ImBeg)] - frmTimeSerPlot.dsYaxes.PosFrom * Yscale);

              End; // for ImNr := Beg to  ToEnd - 1 Do Begin//

              Canvas.Pen.Style := psDot;
              Canvas.Brush.Color := clNone; // Has to be set to None in Order to Get Dotted  Line; or set it to : Canvas.Brush.Style := bsClear;
              Canvas.Polyline(TraceArr); // Plots the Trace
              Canvas.Pen.Style := psSolid;

            End; // If (TimPltSlid.BaseLineOption = GET_BASELINE)
            // ----- End with the baseline //

            // Writes Y pixes values for Data Trace
            If (Compress) Then
            Begin
              MemPos := 0;
              CntPix := 0;
              MinVal := High(Word);
              MaxVal := 0;
              For ImNr := BegIm to EndIm do
              Begin
                if MemPos = round((ImNr - BegIm) * Xscale) then
                begin
                  if (MinVal > PlotData[CntROI, (ImNr - PLOTvar.ImBeg)]) then
                    MinVal := PlotData[CntROI, (ImNr - PLOTvar.ImBeg)];

                  if (MaxVal < PlotData[CntROI, (ImNr - PLOTvar.ImBeg)]) then
                    MaxVal := PlotData[CntROI, (ImNr - PLOTvar.ImBeg)];
                end
                  else
                if (MemPos <> round((ImNr - BegIm) * Xscale)) then
                begin
                  TraceArr[CntPix].y := PlYbeg - round
                    (Yscale * MinVal - frmTimeSerPlot.dsYaxes.PosFrom *
                      Yscale);
                  TraceArr[CntPix + 1].y := PlYbeg - round
                    (Yscale * MaxVal - frmTimeSerPlot.dsYaxes.PosFrom *
                      Yscale);
                  Inc(CntPix, 2);
                  Inc(MemPos);
                  MinVal := High(Word);
                  MaxVal := 0;
                end;
              End; // for ImNr := BegIm to EndIm
            End
            Else // If Compress

            /// Writes Y pix values in Conventional  way
            If Not(Compress) then For ImNr := BegIm to EndIm Do
            Begin

                TraceArr[ImNr - BegIm].x := PlXbeg + round
                  ((ImNr - BegIm) * Xscale);
                TraceArr[ImNr - BegIm].y := PlYbeg - round
                  (Yscale * PlotData[CntROI,
                  (ImNr - PLOTvar.ImBeg)] - frmTimeSerPlot.dsYaxes.PosFrom *
                    Yscale);

              End; { For ImNr := Beg to  ToEnd - 1 Do Begin }

            Canvas.Polyline(TraceArr); // Plots the Trace

            { -------------- 2nd: Draws Symbols ----------------------------- }
            if (TimPltSlid.SymbOn) or (PLOTvar.HasPeaks) then
              Canvas.Brush.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];

            { if symbol was chosen or Im Nr from Tables Clicked }

            If (TimPltSlid.SymbOn) then
            Begin

              If PLOTvar.ImNrFromTable = -1 then
              Begin
                // Draws "Regular" Symbols for Each Image//
                For ImNr := BegIm to EndIm Do
                Begin
                  Canvas.Ellipse
                    (TraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                    TraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                    TraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                    TraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);
                End; // For ImNr := Beg to  ToEnd - 1 Do Begin//
              End
              Else If PLOTvar.ImNrFromTable > -1 then
              Begin
                // Draws the Symbol For The Image Number as Clicked on table//
                For ImNr := BegIm to EndIm Do
                Begin
                  If PLOTvar.AdrUsed[CntROI] = 20 Then
                  Begin // Last Trace # 20, White Color//
                    if ImNr = PLOTvar.ImNrFromTable then
                    Begin
                      Canvas.Brush.Color := TimPltSlid.SymbFromTableCol;
                      Canvas.Pen.Color := TimPltSlid.SymbFromTableCol;
                    end
                    else
                    begin
                      Canvas.Pen.Color := ROIvar.ROICol
                        [PLOTvar.AdrUsed[CntROI]];
                      Canvas.Brush.Color := ROIvar.ROICol
                        [PLOTvar.AdrUsed[CntROI]];
                    end;
                  End; // If CntROI = 19 Then Begin = Last Trace # 20, White Color//

                  // In this Option [CheckBoxSymbolOn.Checked = True) Cmpress is Always = false

                  Canvas.Ellipse
                   (TraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                    TraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                    TraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                    TraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);

                End; // For ImNr := Beg to  ToEnd - 1 Do Begin //
              End; // If PLOTvar.ImNrFromTable > -1 then Begin//
            End; // If frmTimeSerPlot.CheckBoxSymbolOn.Checked = True//

            If (TimPltSlid.AlwaysUseSymb) Then
            Begin
              If PLOTvar.ImNrFromTable > -1 then
              Begin
                If PLOTvar.AdrUsed[CntROI] = 20 Then
                Begin
                  Canvas.Brush.Color := TimPltSlid.SymbFromTableCol;
                  Canvas.Pen.Color := TimPltSlid.SymbFromTableCol;
                  if Compress then
                    Canvas.Ellipse
                      (TraceArr[2 * (round((PLOTvar.ImNrFromTable - BegIm)
                            * Xscale))].x - TimPltSlid.SymbSize,
                      TraceArr[2 * (round((PLOTvar.ImNrFromTable - BegIm)
                            * Xscale))].y - TimPltSlid.SymbSize,
                      TraceArr[2 * (round((PLOTvar.ImNrFromTable - BegIm)
                            * Xscale))].x + TimPltSlid.SymbSize,
                      TraceArr[2 * (round((PLOTvar.ImNrFromTable - BegIm)
                            * Xscale))].y + TimPltSlid.SymbSize)
                  else

                    if Not(Compress) then
                    Canvas.Ellipse
                      (TraceArr[PLOTvar.ImNrFromTable - BegIm]
                        .x - TimPltSlid.SymbSize,
                      TraceArr[PLOTvar.ImNrFromTable - BegIm]
                        .y - TimPltSlid.SymbSize,
                      TraceArr[PLOTvar.ImNrFromTable - BegIm]
                        .x + TimPltSlid.SymbSize,
                      TraceArr[PLOTvar.ImNrFromTable - BegIm]
                        .y + TimPltSlid.SymbSize);
                End; // PLOTvar.AdrUsed[CntROI] = 20//
              End; // If PLOTvar.ImNrFromTable > -1//
            End; // If (PLOTvar.AlwaysUseSymb = True)//
            // Ellipse(X1, Y1, X2, Y2)//

            { -------------- 3rd -  Peaks Part ----------------------------------- }
            { Puts Symbols for Peaks: so far circles for peaks found }

            If (PLOTvar.HasPeaks) and (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then
            Begin
              // -------------------------------------------------------//

              If (PeakFakeImNrArr <> nil) Then // PeakPosArr is not used here on purpose, see below
                if High(PeakFakeImNrArr[CntROI]) > -1 then
                  For CntPeak := 0 to High(PeakFakeImNrArr[CntROI]) Do
                  Begin
                    if (TimPltSlid.GetPeaks) then
                      ImNr := PeakPosArr[CntROI, CntPeak] + PLOTvar.ImBeg
                      // done here for clarity//
                    else
                      ImNr := PLOTvar.ImNrFromTable;

                    if (ImNr >= BegIm) and (ImNr <= EndIm) Then
                    Begin
                      // Puts Symbol on Peak//

                      if Compress then
                        Canvas.Ellipse
                          (TraceArr[2 * (round((ImNr - BegIm) * Xscale))]
                            .x - TimPltSlid.SymbSize,
                          TraceArr[2 * (round((ImNr - BegIm) * Xscale))]
                            .y - TimPltSlid.SymbSize,
                          TraceArr[2 * (round((ImNr - BegIm) * Xscale))]
                            .x + TimPltSlid.SymbSize,
                          TraceArr[2 * (round((ImNr - BegIm) * Xscale))]
                            .y + TimPltSlid.SymbSize)
                      else

                        if Not(Compress) then
                        Canvas.Ellipse
                         (TraceArr[ImNr - BegIm].x - TimPltSlid.SymbSize,
                          TraceArr[ImNr - BegIm].y - TimPltSlid.SymbSize,
                          TraceArr[ImNr - BegIm].x + TimPltSlid.SymbSize,
                          TraceArr[ImNr - BegIm].y + TimPltSlid.SymbSize);

                      if (PeakFakeImNrArr[CntROI,
                        CntPeak].Lim > CANNOT_BE_DONE) and
                        (PeakFakeImNrArr[CntROI,
                        CntPeak].Rim > CANNOT_BE_DONE) Then
                      Begin

                        Ypeak := PlYbeg - round
                          (Yscale * ((PlotData[CntROI,
                              (ImNr - PLOTvar.ImBeg)] - PeakBasArr[CntROI,
                              CntPeak]) / 2 + PeakBasArr[CntROI, CntPeak])
                            - frmTimeSerPlot.dsYaxes.PosFrom * Yscale);

                        // Draws 1/2 amplitude Horizontal Line using Fake ImNr = Time/Time for One Image//
                        Canvas.MoveTo(PlXbeg + round((PeakFakeImNrArr[CntROI,CntPeak].Lim - BegIm) * Xscale), Ypeak);
                        Canvas.LineTo(PlXbeg + round((PeakFakeImNrArr[CntROI,CntPeak].Rim - BegIm) * Xscale), Ypeak);

                        // Draws Baseline for each peak; Since Aug 19, 2013 it draws the Real Lenght & Position of the Baselines //
                      If (TimPltSlid.GetEachPeakBase) Then Begin
     Canvas.Pen.Width := 3;  //draws thicker baseline
     Canvas.MoveTo(PlXbeg + round((BaseImNrArr[CntROI,CntPeak].LimNr - BegIm)*Xscale)
                          ,PlYbeg - round(Yscale * PeakBasArr[CntROI,CntPeak] - frmTimeSerPlot.dsYaxes.PosFrom * Yscale));
     Canvas.LineTo(PlXbeg + round((BaseImNrArr[CntROI,CntPeak].RimNr - BegIm)*Xscale)
                          ,PlYbeg - round(Yscale * PeakBasArr[CntROI,CntPeak] - frmTimeSerPlot.dsYaxes.PosFrom * Yscale));
     Canvas.Pen.Width := 1;
                       End; //If (TimPltSlid.GetEachPeakBase)

                        // Draws Verical Line to 1/2 Amplitude//
                        if Compress then
                        begin
                          Canvas.MoveTo
                            (TraceArr[2 * (round((ImNr - BegIm) * Xscale))].x,
                            TraceArr[2 * (round((ImNr - BegIm) * Xscale))].y);
                          Canvas.LineTo
                            (TraceArr[2 * (round((ImNr - BegIm) * Xscale))].x,
                            Ypeak);
                        end
                        else if Not(Compress) then
                        begin
                          Canvas.MoveTo(TraceArr[ImNr - BegIm].x,
                            TraceArr[ImNr - BegIm].y);
                          Canvas.LineTo(TraceArr[ImNr - BegIm].x, Ypeak);
                        end;

                      end
                      else // if Both PeakTimArr[CntROI,CntPeak,0] and [1]> 0//
                      // if only right side found//
                        if (PeakFakeImNrArr[CntROI, CntPeak].Lim < TIME_DONE)
                        and (PeakFakeImNrArr[CntROI,
                        CntPeak].Rim > CANNOT_BE_DONE) Then
                      Begin
                        // Calculates Y at 1/2 amplitude//
                        Ypeak := PlYbeg - round
                          (Yscale * ((PlotData[CntROI,
                              (ImNr - PLOTvar.ImBeg)] - PeakBasArr[CntROI,
                              CntPeak]) / 2 + PeakBasArr[CntROI, CntPeak])
                            - frmTimeSerPlot.dsYaxes.PosFrom * Yscale);
                        // Draws Only t1/2 Decay Horizontal Line using Fake ImNr = Time/Time for One Image//
                        if Compress then
                        begin
                          Canvas.MoveTo
                            (TraceArr[2 * (round((ImNr - BegIm) * Xscale))].x,
                            Ypeak);
                          Canvas.LineTo
                            (PlXbeg + round((PeakFakeImNrArr[CntROI,
                                CntPeak].Rim - BegIm) * Xscale), Ypeak);
                        end
                        else if Not(Compress) then
                        begin
                          Canvas.MoveTo(TraceArr[ImNr - BegIm].x, Ypeak);
                          Canvas.LineTo
                            (PlXbeg + round((PeakFakeImNrArr[CntROI,
                                CntPeak].Rim - BegIm) * Xscale), Ypeak);
                        end;
                        // Draws Verical Line to 1/2 Amplitude//
                        if Compress then
                        begin
                          Canvas.MoveTo
                            (TraceArr[2 * (round((ImNr - BegIm) * Xscale))].x,
                            TraceArr[2 * (round((ImNr - BegIm) * Xscale))].y);
                          Canvas.LineTo
                            (TraceArr[2 * (round((ImNr - BegIm) * Xscale))].x,
                            Ypeak);
                        end
                        else if Not(Compress) then
                        begin
                          Canvas.MoveTo(TraceArr[ImNr - BegIm].x,
                            TraceArr[ImNr - BegIm].y);
                          Canvas.LineTo(TraceArr[ImNr - BegIm].x, Ypeak);
                        end;
                      end; // if Right Side only PeakTimArr[CntROI,CntPeak,0]=0  and [1]> 0//
                    end; // if (ImNr >= BegIm) and (ImNr <= EndIm)//
                  End; // For ImNr := 0 to High(PlotData[CntROI])//
              // -------------------------------------------------------//
            End; // If (TimPltSlid.HasPeaks = True) and (PLOTvar.RatOn)//
            // ------------- End with Peaks -----------------------------------//

            { --------------------------------------------------------------------------- }
          End; { If PLOTvar.AdrUsed[CntROI] > 0 }
        End; { For CntROI := 0 to (BoxPar.NrB - 1) }

      End; // With  frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot Do Begin//
      frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.Pen.Width := 1;
      { do not remove - resets }
    End; { Procedure DrawTimeSerPlotTraces; }

  { ************************************************************************** }

    Procedure DrawTimeSerPlotXaxes; { Draws just X axes }

    Begin

      With frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas Do
      Begin
        { Draws X and Y Axes }
        Pen.Color := clWhite;
        MoveTo(PlXaxBeg, PlYaxBeg);
        LineTo(TimPltSlid.WinXSize, PlYaxBeg);
        MoveTo(PlXaxBeg, PlYaxEnd);
        LineTo(TimPltSlid.WinXSize, PlYaxEnd);
      End;

    End; { Procedure DrawTimeSerPlotXaxes; }
  { ************************************************************************** }
  { ************************************************************************** }
    Procedure DrawTimeSerPlotYaxes;
    { Draws Y axes & Labels for Bothe X & Y axes }
    Var
      LogRec: TLogFont; { Win GDI Structure:  LOGFONT structure }
      OldFontHandle, NewFontHandle: hFont;
    Begin

      With frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas Do
      Begin
        { Draws X and Y Axes }
        { Done in Form.Create }
        { Font.Name := 'Arial'; }
        { Font.Size := 8; }
        Font.Color := clWhite;
        Pen.Color := clWhite;
        MoveTo(PlXaxBeg, PlYaxBeg);
        LineTo(PlXaxBeg, PlYaxEnd);
        MoveTo(TimPltSlid.WinXSize - 1, PlYaxBeg);
        LineTo(TimPltSlid.WinXSize - 1, PlYaxEnd);
      End;

      with frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas do
      begin
        frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Style :=
          bsSolid;
        frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Color :=
          clBlack;
        frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.FillRect
          (Rect(0, 0, 20, 300));

        GetObject(Font.Handle, SizeOf(LogRec), Addr(LogRec));
        LogRec.lfEscapement := 90 * 10; { angle*10 }
        { Specifies the angle, in tenths of degrees, between the escapement vector and the x-axis }
        LogRec.lfOrientation := 90 * 10;
        { Specifies the angle, in tenths of degrees, between each character's base line and the x-axis of the device }
        NewFontHandle := CreateFontIndirect(LogRec);
        OldFontHandle := SelectObject(Handle, NewFontHandle);
        If (PLOTvar.AnalType = INTENSITY_TIME) then
          TextOut(1, 180, 'Intensity')
          else
        if (PLOTvar.AnalType = RATIO_TIME) then
            TextOut(1, 160, 'F/Fo')
          else
        If (PLOTvar.AnalType = Ch_div_Ch_RATIO_TIME) then begin
            if (ChannelOrder = ASCENDING)  then TextOut(1, 160, 'Ch1/Ch2')
              else
            if (ChannelOrder = DESCENDING) then TextOut(1, 160, 'Ch2/Ch1');
        End
          else
        If (PLOTvar.AnalType = Ca_CONC_TIME) then
            TextOut(1, 160, 'Ca (µM)')
          else
        If (PLOTvar.AnalType = DISTANCE_TIME) then
           TextOut(1, 180, 'Distance (' + Char(181) + 'm)');
        NewFontHandle := SelectObject(Handle, OldFontHandle);
        DeleteObject(NewFontHandle);
      end;
    End; { Procedure DrawTimeSerPlotYaxes; }

  { ************************************************************************** }
    Procedure DrawTimeSerPlotXticks;
    Var
      BigXTick, NrBigXTick, NrSmXTick, i, j: Integer;
      BigXTickBeg: Integer;
      Lab: AnsiString;
      LabOff, Xoff, XoffUse: Integer;
      XSleft, XLmin: Integer; { position of Left & Right Slider }
      SmXTick: Single;
      BigTickTime: Extended;
      DigAftZero: Integer;
      { BigXTick = Number of Images whitin Tick }
    Begin

      with frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas do
      begin
        { sets Color & Font }
        Pen.Color := clWhite;
        { Done in Form.Create }
        { Font.Name := 'Arial'; }
        { Font.Size := 8; }
        Font.Color := clWhite;
      end;

      XLmin  := frmTimeSerPlot.dsXaxes.Min;
      XSleft := frmTimeSerPlot.dsXaxes.PosFrom;

      if (Xrange >= 50) then
        BigXTick := (Xrange div 5)
      else
        BigXTick := (Xrange div 2);

      if BigXTick >= 10 then
        BigXTick := (BigXTick div 10) * 10
      else if BigXTick <= 2 then
        BigXTick := (BigXTick div 2) * 2
      else
        BigXTick := (BigXTick div 5) * 5; { BigTick = Size in Units }

      If (BigXTick = 0) Then
        BigXTick := 1;

      if BigXTick >= 10 then
        NrSmXTick := 10
      else
        NrSmXTick := BigXTick;
      SmXTick := BigXTick / NrSmXTick;

      BigTickTime := BigXTick * MeanImTime; { temporarily holds this value }
      if trunc(BigTickTime) >= 1 then
        DigAftZero := 1
      else
        DigAftZero := 7 - Length(IntToStr(trunc(frac(BigTickTime) * 100000)));

      { -------------------------------------------------------------------------------------------- }
      with frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas do
      begin
        Brush.Color := clBlack;
        { First deletes Ticks, then deletes Labes without Deleting Yax labels }
        { Deletes Bottom Ticks }
        FillRect(Rect(PlXaxBeg, PlYaxBeg + 1, TimPltSlid.WinXSize,
            frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Height));
        FillRect(Rect(PlXaxBeg - 20, PlYaxBeg + 5, TimPltSlid.WinXSize,
            frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Height));
        { Deletes Top Ticks }
        FillRect(Rect(PlXaxBeg, 0, TimPltSlid.WinXSize, PlYaxEnd));
        FillRect(Rect(PlXaxBeg - 20, 0, TimPltSlid.WinXSize, PlYaxEnd - 5));
        TextOut(PlXbeg + 200, 2, PLOTvar.Title);

        with PLOTvar do begin
        if not(MovFType in[ZEISS_CZI_LSM_MOV]) then
          TextOut(PlXbeg, 2, 'Seconds')
          else
        if (MovFType = ZEISS_CZI_LSM_MOV) then begin
          if (MovFType = ZEISS_CZI_LSM_MOV) then begin
            if (MovieSeriesType = TimeSeries) then TextOut(PlXbeg, 2, 'Seconds')
              else
            if (MovieSeriesType = Z_Stack) then TextOut(PlXbeg, 2, 'µm');
          end;
        end;//if (MovFType = ZEISS_CZI_LSM_MOV)
        end;

        TextOut(PlXbeg, PlYbeg + 30, 'Number of Images');
      end;
      { -------------------------------------------------------------------------------------------- }

      Xoff := 0;
      While Xoff < XSleft Do
      Begin
        if Xoff < XSleft then
          Inc(Xoff, BigXTick);
      End;
      Dec(Xoff);
      { shifts Xoff to the left by one; Because Images are numbered From 1 }
      NrBigXTick := Xrange div BigXTick;
      j := 1;

      For i := 0 to NrBigXTick Do
      Begin { Draws Ticks }

        With frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas Do
        Begin
          if (XSleft = 0) and (i = 0) then
            XoffUse := Xoff + 1
          Else
            XoffUse := Xoff;
          If BigXTick * i + (XoffUse - XSleft) >= 0 Then
          Begin
            { Bottom Images }
            MoveTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxBeg);
            LineTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxBeg + 5);
            { Top - Seconds }
            MoveTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxEnd);
            LineTo(PlXbeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale), PlYaxEnd - 5);

            { PlXbeg is used in order to get 0 alligned with Traces }
            { Bottom Tick Labels }
            Lab := IntToStr((BigXTick * i + XoffUse) + 1); { 1st image = 1 }
            LabOff := (Length(Lab) * 6) div 2;
            TextOut(PlXaxBeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale) - LabOff, PlYaxBeg + 6, Lab);
            { Top Tick Labels }
            if (BigXTick * i + XoffUse - XLmin <= High(CopyOfTimeSt)) then
              BigTickTime := CopyOfTimeSt[BigXTick * i + Xoff - XLmin];
            if BigTickTime > 0.000001 then
              Lab := FloatToStrF(BigTickTime, ffFixed, 5, DigAftZero)
            else
              Lab := '0';
            LabOff := (Length(Lab) * 5) div 2;
            TextOut(PlXaxBeg + round((BigXTick * i + (XoffUse - XSleft))
                  * Xscale) - LabOff, PlYaxEnd - 20, Lab);
            if i = 0 then
              while (Xoff - XSleft) - (SmXTick * j) >= 0 do
              begin
                { Bottom - Images }
                MoveTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxBeg);
                LineTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxBeg + 3);
                { Top - Seconds }
                MoveTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxEnd);
                LineTo(PlXbeg + round(((Xoff - XSleft) - (SmXTick * j))
                      * Xscale), PlYaxEnd - 3);
                Inc(j);
              end;
            for j := 1 to NrSmXTick - 1 do
            begin
              if PlXbeg + round
                ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft)) * Xscale)
                <= TimPltSlid.WinXSize Then
              Begin
                { Bottom - Images }
                MoveTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxBeg);
                LineTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxBeg + 3);
                { Top - Seconds }
                MoveTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxEnd);
                LineTo
                  (PlXbeg + round
                    ((BigXTick * i + (SmXTick * j) + (Xoff - XSleft))
                      * Xscale), PlYaxEnd - 3);
              end;
            end;
          end;
        End; { With ... }

      End; { For i := BigXTickBeg to NrBigYTick }

    End; { Procedure DrawTimeSerPlotXticks; }
  { ************************************************************************** }

  { ************************************************************************** }
Procedure DrawTimeSerPlotYticks;
    Var
      BigYTick, i, j: Integer; { size in pix }
      NrBigYTick, NrSmYTick: Integer;
      Lab : AnsiString;
      SmYTick : Double;

Begin

      with frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas do begin
        { sets Color & Font }

        { Done in Form.Create }
        { Font.Name := 'Arial'; }
        { Font.Size := 8; }

        Font.Color := clWhite;
        Pen.Color := clWhite;
      end;

      BigYTick := (Yrange div 5);

      If (BigYTick = 0) Then
        BigYTick := 1
      else If (BigYTick >= 5) and (BigYTick < 10) Then
        BigYTick := (BigYTick div 5) * 5
      else If (BigYTick >= 10) Then
        BigYTick := (BigYTick div 10) * 10;

      If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME]) Then
        NrBigYTick := 200 div BigYTick
      else
        NrBigYTick := frmTimeSerPlot.dsYaxes.Max div BigYTick;

      If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) then
      begin
        if NrBigYTick <= 5 then
          NrSmYTick := 10
        else
          NrSmYTick := 5;
      End
        Else
      Begin
        if (BigYTick >= 10) and (NrBigYTick <= 5) then
          NrSmYTick := 10
        else if (BigYTick >= 10) and (NrBigYTick > 5) then
          NrSmYTick := 5
        else if (BigYTick < 10) then
          NrSmYTick := BigYTick;
      End;
      SmYTick := BigYTick / NrSmYTick;

      frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Color :=
        clBlack;
      frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.FillRect
        (Rect(14, 45, PlXaxBeg, 260));
      frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas.Brush.Style :=
        bsClear;

      For i := 0 to NrBigYTick Do
      Begin { Draws Ticks }
        if (i * BigYTick >= frmTimeSerPlot.dsYaxes.PosFrom) and
          (i * BigYTick <= frmTimeSerPlot.dsYaxes.PosTo) then
        begin

          With frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas Do
          Begin
            MoveTo(PlXaxBeg - 5,
              PlYbeg - round((BigYTick * i - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale));
            LineTo(PlXaxBeg,
              PlYbeg - round((BigYTick * i - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale));

            If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME]) then
              Lab := FloatToStrF((BigYTick * i) / 10, ffFixed, 2, 1)
            else
              Lab := IntToStr(BigYTick * i);
            TextOut(PlXbeg - (Length(Lab) * 7 + 8),
              PlYbeg - round((BigYTick * i - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale) - 8, Lab);
            for j := 1 to NrSmYTick - 1 do
            begin
              if PlYbeg - round
                ((BigYTick * i + SmYTick * j - frmTimeSerPlot.dsYaxes.PosFrom)
                  * Yscale) >= PlYend then
              begin
                MoveTo(PlXaxBeg - 3,
                  PlYbeg - round
                    ((BigYTick * i + SmYTick * j -
                        frmTimeSerPlot.dsYaxes.PosFrom) * Yscale));
                LineTo(PlXaxBeg,
                  PlYbeg - round
                    ((BigYTick * i + SmYTick * j -
                        frmTimeSerPlot.dsYaxes.PosFrom) * Yscale));
              end;
            end;

          End; { With ... }
        end;
      End; { For i := BigYTickBeg to NrBigYTick }

    End; { DrawTimeSerPlotYticks }
  { ************************************************************************** }
    Procedure DrawTimeSerPlotCursor; { Requested by Tom }
    Var
      YcurPos: Integer;
    Begin

      With frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Canvas Do
      Begin

        YcurPos := PlYbeg - round
          (Yscale * TimPltSlid.CurVal - frmTimeSerPlot.dsYaxes.PosFrom *
            Yscale);

        if (YcurPos > PlYend) and (YcurPos < PlYbeg) then
        begin
          Pen.Color := RGB(150, 150, 150);
          Pen.Mode := pmXOR;
          Pen.Width := 1;
          MoveTo(PlXbeg, YcurPos);
          LineTo(TimPltSlid.WinXSize, YcurPos);
          Pen.Mode := pmCopy;
        end;

      End;
      PLOTvar.CurPix := YcurPos;

    End;
  { ************************************************************************** }
  { *********** This Group of Procedures are Used by ROI Handling ------------- }

    Procedure UpdateROI;
    Begin

      If (CurROIkind = 1) then
      Begin
        ROIvar.ROICoor[1, CurROIadr] := XL;
        ROIvar.ROICoor[2, CurROIadr] := Yup;
        ROIvar.ROICoor[3, CurROIadr] := XR;
        ROIvar.ROICoor[4, CurROIadr] := Yd;
        ROIvar.ROIAdr[CurROIadr] := 1;
      End
      Else If (CurROIkind = 3) then
      Begin
        ROIvar.ROIAdr[CurROIadr] := 3;
      End;

    End; { Procedure UpdateROI; }

  { ****************************************************************************** }

    Procedure KeepROIinWindow; { Keeps ROI in Window }
    { does not allow Box or Circle to go outside of the window }
    { Currently Works for BOXES ONLY }
    Begin

      if XL < 0 then
      Begin
        XL := 0;
        if (InROI = True) then
          XR := ROIvar.ROICoor[3, CurROIadr] - ROIvar.ROICoor[1, CurROIadr]
        else
          XR := ROIrct.Xsize - ROIrct.Rc;
      end;
      if XR > imXsize - 1 then
      begin
        XR := imXsize - 1;
        if (InROI = True) then
          XL := XR - (ROIvar.ROICoor[3, CurROIadr] - ROIvar.ROICoor[1,
            CurROIadr])
        else
          XL := XR - ROIrct.Xsize + ROIrct.Rc;
      end;
      if Yup < 0 then
      begin
        Yup := 0;
        if (InROI = True) then
          Yd := ROIvar.ROICoor[4, CurROIadr] - ROIvar.ROICoor[2, CurROIadr]
        else
          Yd := ROIrct.Ysize - ROIrct.Bc;
      end;
      if Yd > imYsize - 1 then
      begin
        Yd := imYsize - 1;
        if (InROI = True) then
          Yup := Yd - (ROIvar.ROICoor[4, CurROIadr] - ROIvar.ROICoor[2,
            CurROIadr])
        else
          Yup := Yd - ROIrct.Ysize + ROIrct.Bc;
      end;

    End; { Procedure KeepROIinWindow; }
  { ************************************************************************** }
    Procedure KeepAllROIinWindow(Const KindROI: Integer;
      Var XLL, Xrr, dXpr, Yupp, Ydd, dYpr: Integer;
      Var CanMoveX, CanMoveY: Boolean);
    Begin
      If KindROI = 1 Then
      Begin
        if Not((XLL > -1) and (Xrr <= imXsize - 1)) then
        Begin
          XLL := XLL - dXpr;
          Xrr := Xrr - dXpr;
        end;
        if Not((Yupp > -1) and (Ydd <= imYsize - 1)) then
        Begin
          Yupp := Yupp - dYpr;
          Ydd := Ydd - dYpr;
        end;
      End
      Else If KindROI = 3 Then
      Begin
        if Not((XLL > -1) and (Xrr <= imXsize - 1)) then
        Begin
          XLL := XLL - dXpr;
          Xrr := Xrr - dXpr;
          CanMoveX := False;
        end
        else
          CanMoveX := True;
        if Not((Yupp > -1) and (Ydd <= imYsize - 1)) then
        Begin
          Yupp := Yupp - dYpr;
          Ydd := Ydd - dYpr;
          CanMoveY := False;
        end
        else
          CanMoveY := True;
      End;
    End;
  { ************************************************************************** }
    Procedure DeleteROI;
    Begin

      if (ROIvar.ROIAdr[CurROIadr] = 3) then
      begin { free hand }
        FhPol[CurROIadr] := nil;
        FhTbl[CurROIadr] := nil;
      end;
      ROIvar.ROIAdr[CurROIadr] := 0;
      Dec(ROIvar.NrROI);
      CurROIadr := 0;

    End; { Procedure DeleteROI; }
  { ************************************************************************** }
    Function GetFirstFreeAddress: Integer; { Returns= FirstFreeAdr:Integer }
    var
      i, FirstFreeAdr: Integer;
    Begin { Get First Unused ROI Address for All ROIs }
      { X and Y are Mouse Coordinates }
      FirstFreeAdr := 0; { Gives the First Free (= 0) address in ROIvar.ROIAdr }
      for i := 1 to 20 do
        If (ROIvar.ROIAdr[i] = 0) and (FirstFreeAdr = 0) then
        Begin
          FirstFreeAdr := i;
          Break;
        End;
      Result := FirstFreeAdr;
    End;
  { ************************************************************************** }
    Function GetFreeHandROInumber: Integer;
    var
      CntROI: Integer;
    Begin

      Result := 0;

      For CntROI := 1 to 20 Do
      Begin
        if (ROIvar.ROIAdr[CntROI] = 3) then
          Inc(Result);
      End;

      if (Result = 0) then
        MessageDlg('Draw Freehand ROIs First', mtError, [mbOK], 0);

    End; // Function GetFreeHandROInumber
{ ************************************************************************** }
Procedure CheckIfInScaleBar(const X,Y: Integer; const ScaleBar : TTimeOrSizeBar; Visible : Boolean);
Begin
  If (Visible) then Begin
    if (X > ScaleBar.XL) and (X < ScaleBar.XR) and
       (Y > ScaleBar.YT) and (Y < ScaleBar.YB)
    then
       InScaleBar := True
    else
       InScaleBar := False;
    End
      Else
    InScaleBar := False;
End;

Procedure CheckIfInROI(Const X, Y, SearchFor: Integer);
var  i, CntX, CntY: Integer;
Begin
      { If ROIkind = 4 then Check for All }
      InROI := False;

      For i := 1 to 20 Do
      Begin { #21 is the Selection Frame }

        { ------------------------------------------------------------------------------- }
        If (SearchFor = 1) or (SearchFor = 4) Then
        Begin { Checks For Boxes & Circles }
          If (ROIvar.ROIAdr[i] = 1) then
          begin { Boxes: (ROIvar.ROIAdr[i] = 1) }
            if (x >= ROIvar.ROICoor[1, i]) and (x <= ROIvar.ROICoor[3, i]) and
              (y >= ROIvar.ROICoor[2, i]) and (y <= ROIvar.ROICoor[4, i]) then
            begin
              InROI := True;
              CurROIadr := i;
              CurROIkind := ROIvar.ROIAdr[i];
            end; { if Inside Box }
          End; { If (ROIvar.ROIAdr[i] = 1) }
        End; { If (ROIkind = 1) or (ROIkind = 4)= For Boxes or All ROIs }

        If (SearchFor = 3) or (SearchFor = 4) Then
        Begin

          If (ROIvar.ROIAdr[i] = 3) then
          Begin

            If (y >= FhTbl[i, 0, 0].y) and (y <= FhTbl[i, High(FhTbl[i]), 0].y)
              Then
            Begin
              For CntY := 0 to High(FhTbl[i]) Do
              Begin
                If ( High(FhTbl[i, CntY]) > 0) Then
                Begin
                  CntX := 0;
                  While (CntX < High(FhTbl[i, CntY])) and (InROI = False) Do
                  Begin
                    if (x >= FhTbl[i, CntY, CntX].x) and
                      (x <= FhTbl[i, CntY, CntX + 1].x) then
                    Begin
                      InROI := True;
                      CurROIadr := i;
                      CurROIkind := ROIvar.ROIAdr[i];
                      Break;
                    end;
                    Inc(CntX, 2);

                  End; { While }
                End; { If (High(FhTbl[i,CntY]) > 0) Then Begin }
                if (InROI = True) Then
                  Break;
              End; { For CntY := 0 to High(FhTbl[i]) Do Begin }
            End;
            { If (Y >= FhTbl[i,0,0].Y) and (Y <= FhTbl[i,High(FhTbl[i]),0].Y) Then Begin }
          End; { If (ROIvar.ROIAdr[i] = 3) then begin }
        End; { If (SearchFor = 3) or (SearchFor = 4) Then Begin }
        { ------------------------------------------------------------------------------- }
        if InROI = True then
          Break;
        { --------------------------------------------------------------------------------- }
      End; { For i := 1 to 20 do begin:  Searches if Cursor is in Box }

    End; { Procedure CheckIfInROI(X,Y,ROIkind:integer); }

{ ************************************************************************** }
procedure TurnOffXYprofileAverImCheckBox;
begin
  if (AvImExists = 0) and (XYprofileRectVisible) and (XYprofileSource = AVER_WINDOW) then begin
    frmXYprofile.rdMainWindow.Checked := True;
  end;
end;


procedure CalculateXYprofile;
var W,H,CntY,CntX : Integer;
    XYarray     : TDynDoubleArray; //contains the Values
    PixArray    : TDynDoubleArray; //contains the Pixel Numbers for Top Axexs
    MicronArray : TDynDoubleArray; //contains the Micron Numbers for Bottom Axexs
    pWarr       : TDynWordArray;
begin

  With XYprofileRect do Begin

  H := Height + 1;
  W := Width  + 1;


 if (Width >= Height) then begin
  XYprofileKind  := X_PROFILE;
  SetLength(XYarray,Right-Left+1);
 end
  else
 if (Width < Height)  then begin
  XYprofileKind  := Y_PROFILE;
  SetLength(XYarray,Bottom-Top+1);
 end;

 if ((RatioOn) and (SmoothMode > NO_SMOOTH)) Or
    (not(RatioOn) and (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]))
 then XYprofileFilter2DUsed := True else XYprofileFilter2DUsed := False;


If (XYprofileSource = MAIN_WINDOW) Then Begin

 If not(RatioOn) Then Begin
  frmXYprofile.Chart_XYprofile.Axes.Left.Title.Caption := 'Intensity';
  If (BitCount = 16) or
       ((BitCount = 8) and (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH))
  Then Begin
    if not(SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH)
    then pWarr := Im16bitData
      else
    if (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH)
    then pWarr := Im16bitDataSM_Last;

    if (XYprofileKind = X_PROFILE) then begin
      for CntX := Left to Right do XYarray[CntX-Left] := pWarr[CntX + imXsize*Top];
      for CntY := Top+1 to Bottom do begin
        for CntX := Left to Right do begin
          XYarray[CntX-Left] := XYarray[CntX-Left] + pWarr[CntX + imXsize*CntY];
        end;
      end;
    end
      else
    if (XYprofileKind = Y_PROFILE) then begin
      for CntY := Top to Bottom do XYarray[CntY-Top] := pWarr[Left + imXsize*CntY];
      for CntY := Top to Bottom do begin
        for CntX := Left+1 to Right do begin
          XYarray[CntY-Top] := XYarray[CntY-top] + pWarr[CntX + imXsize*CntY];
        end;
      end;
    end;
  End { End 16 bit }
      Else
  If (BitCount = 8) and (not(SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH))
  Then Begin
    if (XYprofileKind = X_PROFILE) then begin
      for CntX := Left to Right do XYarray[CntX-Left] := Im8bitData[CntX + imXsize*Top];
      for CntY := Top+1 to Bottom do begin
        for CntX := Left to Right do begin
          XYarray[CntX-Left] := XYarray[CntX-Left] + Im8bitData[CntX + imXsize*CntY];
        end;
      end
    end
      else
    if (XYprofileKind = Y_PROFILE) then begin
      for CntY := Top to Bottom do XYarray[CntY-Top] := Im8bitData[Left + imXsize*CntY];
      for CntY := Top to Bottom do begin
        for CntX := Left+1 to Right do begin
          XYarray[CntY-Top] := XYarray[CntY-top] + Im8bitData[CntX + imXsize*CntY];
        end;
      end;
    end;
  End; // 8 bit
 End  //not(RatioOn)
    Else
 If (RatioOn) Then Begin  { For Ratioed Images }
  frmXYprofile.Chart_XYprofile.Axes.Left.Title.Caption := 'F/Fo';
  if (XYprofileKind = X_PROFILE) then begin
    for CntX := Left to Right do XYarray[CntX-Left] := ImDataRat[CntX + imXsize*Top];
    for CntY := Top+1 to Bottom do begin
      for CntX := Left to Right do begin
        XYarray[CntX-Left] := XYarray[CntX-Left] + ImDataRat[CntX + imXsize*CntY];
      end;
    end;
  end
    else
  if (XYprofileKind = Y_PROFILE) then begin
    for CntY := Top to Bottom do XYarray[CntY-Top] := ImDataRat[Left + imXsize*CntY];
    for CntY := Top to Bottom do begin
      for CntX := Left+1 to Right do begin
        XYarray[CntY-Top] := XYarray[CntY-top] + ImDataRat[CntX + imXsize*CntY];
      end;
    end;
  end;
  for CntX := 0 to High(XYarray) do XYarray[CntX] := XYarray[CntX]/DispFact;
 End; { (RatioOn = True) }
End //If (frmXYprofile.rdMainWindow.Checked) Then Begin
  Else
If (XYprofileSource = AVER_WINDOW) Then Begin
  frmXYprofile.Chart_XYprofile.Axes.Left.Title.Caption := 'Intensity';
  if (XYprofileKind = X_PROFILE) then begin
    for CntX := Left to Right do XYarray[CntX-Left] := AvImRaw[CntX + imXsize*Top];
    for CntY := Top+1 to Bottom do begin
      for CntX := Left to Right do begin
        XYarray[CntX-Left] := XYarray[CntX-Left] + AvImRaw[CntX + imXsize*CntY];
      end;
    end;
  end
    else
  if (XYprofileKind = Y_PROFILE) then begin
    for CntY := Top to Bottom do XYarray[CntY-Top] := AvImRaw[Left + imXsize*CntY];
    for CntY := Top to Bottom do begin
      for CntX := Left+1 to Right do begin
        XYarray[CntY-Top] := XYarray[CntY-top] + AvImRaw[CntX + imXsize*CntY];
      end;
    end;
  end;
End;
End; //  with XYprofileRect do begin

 if (XYprofileKind = X_PROFILE) then
  for CntX := 0 to High(XYarray) do XYarray[CntX] := XYarray[CntX]/H
  else
 if (XYprofileKind = Y_PROFILE) then
  for CntX := 0 to High(XYarray) do XYarray[CntX] := XYarray[CntX]/W;


  with frmXYprofile do begin
   with Chart_XYprofile.Axes do begin

    if not(RatioOn) or (XYprofileSource = AVER_WINDOW) then begin
      if (BitCount = 8) then begin
        Left.SetMinMax(0,ColTableSetings.Contrast[0]); //not be affected by F/Fo (Contrast[1]
      end
        else
      if (BitCount = 16) then begin
        Left.SetMinMax(frmImageControl.dsPixRange.PosFrom,frmImageControl.dsPixRange.PosTo);
      end;
    end
      else
    if (RatioOn) then begin
      Left.SetMinMax(0,frmImageControl.trbMaxRatio.Position/100);
    end;

    Bottom.SetMinMax(0,Length(XYarray)*PixSize);
    Top.SetMinMax(0,Length(XYarray));
   end; //with Chart_XYprofile.Axes do begin

    if (Chart_XYprofile.Title.Caption = 'X profile') and (XYprofileKind = Y_PROFILE) then begin
      Chart_XYprofile.Title.Caption := 'Y profile';
    end
      else
    if (Chart_XYprofile.Title.Caption = 'Y profile') and (XYprofileKind = X_PROFILE) then begin
      Chart_XYprofile.Title.Caption := 'X profile';
    end;

    Chart_XYprofile.Series[0].Clear;
    Chart_XYprofile.Series[1].Clear;

    //instead of using Series1.AddXY I use the Faster Routine which adds the arrays
    //to Chart Series and ads them at once (see below)
   // slower: for CntX := 0 to High(XYarray) do frmXYprofile.Series1.AddXY(CntX,XYarray[CntX]);

    SetLength(PixArray,Length(XYarray));
    for CntX  := 0 to High(PixArray) do PixArray[CntX] := CntX;

    SetLength(MicronArray,Length(XYarray));
    for CntX  := 0 to High(MicronArray) do MicronArray[CntX] := CntX*PixSize;

    with Chart_XYprofile.Series[0].XValues do begin
      Value:=VCLTee.TeEngine.TChartValues(MicronArray);
      Count:= Length(MicronArray); // <-- number of points
    //Modified:=True; // <-- recalculate min and max; not needed: I do this Manually
    end;

   { Chart_XYprofile.Series[1].XValues do not need to be filled since one line is plotted}

    with Chart_XYprofile.Series[0].YValues do begin
      Value:=VCLTee.TeEngine.TChartValues(XYarray);
      Count:= Length(XYarray); // <-- number of points
    //Modified:=True; // <-- recalculate min and max;  not needed: I do this Manually
    end;
  end; //with frmXYprofile do begin
End;

{ ************************************************************************** }

Procedure DrawSelFrame(Const aCanvas: TCanvas);
var PenWidthMem,LT,RB : integer;
    Rect        : TRect;
begin

With aCanvas Do Begin

Brush.Style := bsClear;
Pen.Style   := psSolid;
Pen.Mode    := pmCopy;
PenWidthMem := Pen.Width;

if (SelFrameVisible) then begin
  Pen.Width := 1;
  Pen.Color := SelFrameColor;
  Rect := SelFrame;
  {
  LT := (Pen.Width div 2) + (1 mod 2);
  RB := (Pen.Width div 2) + 1 + 1;
  with Pen.Width = 1 LT = 1, RB = 2
  }
  LT := 1;
  RB := 2;
end
  else
if (XYprofileRectVisible) then begin
  Pen.Width := 1;
  Pen.Color := XYprofileRectColor;
  Rect := XYprofileRect;
  {
  LT := (Pen.Width div 2) + (1 mod 2);
  RB := (Pen.Width div 2) + 1 + 1;
  with Pen.Width = 1 LT = 1, RB = 2
  }
  LT := 1;
  RB := 2;

end;

 if (Zoom = 1) then begin
    Rectangle(
    Rect.Left   - LT,
    Rect.Top    - LT,
    Rect.Right  + RB,
    Rect.Bottom + RB);

   if (XYprofileRectVisible) then begin
    //X side black and yellow pixels
    //Top side
    Pixels[(Rect.Width shr 1) + Rect.Left-1,Rect.Top-LT] := clBlack;
    Pixels[(Rect.Width shr 1) + Rect.Left  ,Rect.Top-LT] := clYellow;
    Pixels[(Rect.Width shr 1) + Rect.Left+1,Rect.Top-LT] := clBlack;
    //Bottom side
    Pixels[(Rect.Width shr 1) + Rect.Left-1,Rect.Bottom+1] := clBlack;
    Pixels[(Rect.Width shr 1) + Rect.Left  ,Rect.Bottom+1] := clYellow;
    Pixels[(Rect.Width shr 1) + Rect.Left+1,Rect.Bottom+1] := clBlack;

    //Y side black and yellow pixels
    //left side
    Pixels[Rect.Left-1,(Rect.Height shr 1) + Rect.Top-1] := clBlack;
    Pixels[Rect.Left-1,(Rect.Height shr 1) + Rect.Top  ] := clYellow;
    Pixels[Rect.Left-1,(Rect.Height shr 1) + Rect.Top+1] := clBlack;
    //right side
    Pixels[Rect.Right+1,(Rect.Height shr 1) + Rect.Top-1] := clBlack;
    Pixels[Rect.Right+1,(Rect.Height shr 1) + Rect.Top  ] := clYellow;
    Pixels[Rect.Right+1,(Rect.Height shr 1) + Rect.Top+1] := clBlack;
   end; //if (XYprofileRectVisible) then begin
end

  else

if (Zoom = 2) then begin
  aCanvas.Rectangle(Rect.Left   shl Zm - LT,
                    Rect.Top    shl Zm - LT,
                    Rect.Right  shl Zm + RB + 1,
                    Rect.Bottom shl Zm + RB + 1);

  if (XYprofileRectVisible) then begin
    //X side black and yellow pixels
    //Top side
    Pixels[((Rect.Width shr 1) + Rect.Left) shl Zm-1,Rect.Top shl Zm-LT] := clBlack;
    Pixels[((Rect.Width shr 1) + Rect.Left) shl Zm  ,Rect.Top shl Zm-LT] := clYellow;
    Pixels[((Rect.Width shr 1) + Rect.Left) shl Zm+1,Rect.Top shl Zm-LT] := clBlack;
    //Bottom side
    Pixels[((Rect.Width shr 1) + Rect.Left) shl Zm-1,(Rect.Bottom+1) shl Zm] := clBlack;
    Pixels[((Rect.Width shr 1) + Rect.Left) shl Zm  ,(Rect.Bottom+1) shl Zm] := clYellow;
    Pixels[((Rect.Width shr 1) + Rect.Left) shl Zm+1,(Rect.Bottom+1) shl Zm] := clBlack;

   //Y side black and yellow pixels
    //left side
    Pixels[Rect.Left shl Zm-1,((Rect.Height shr 1) + Rect.Top) shl Zm-1] := clBlack;
    Pixels[Rect.Left shl Zm-1,((Rect.Height shr 1) + Rect.Top) shl Zm  ] := clYellow;
    Pixels[Rect.Left shl Zm-1,((Rect.Height shr 1) + Rect.Top) shl Zm+1] := clBlack;
    //right side
    Pixels[(Rect.Right+1)shl Zm,((Rect.Height shr 1) + Rect.Top)shl Zm-1] := clBlack;
    Pixels[(Rect.Right+1)shl Zm,((Rect.Height shr 1) + Rect.Top)shl Zm  ] := clYellow;
    Pixels[(Rect.Right+1)shl Zm,((Rect.Height shr 1) + Rect.Top)shl Zm+1] := clBlack;
   end; //if (XYprofileRectVisible) then begin
end

  else

if (Zoom = -2) then begin
  aCanvas.Rectangle(Rect.Left shr Zm - LT,
                    Rect.Top  shr Zm - LT,
                    Rect.Left shr Zm + (Rect.Right  - Rect.Left + 1) shr Zm - 1 + RB,
                    Rect.Top  shr Zm + (Rect.Bottom - Rect.Top  + 1) shr Zm - 1 + RB);

  if (XYprofileRectVisible) then begin
    //X side black and yellow pixels
    //Top side
    Pixels[((Rect.Width shr 1) + Rect.Left)shr Zm-1,Rect.Top shr Zm-LT] := clBlack;
    Pixels[((Rect.Width shr 1) + Rect.Left)shr Zm  ,Rect.Top shr Zm-LT] := clYellow;
    Pixels[((Rect.Width shr 1) + Rect.Left)shr Zm+1,Rect.Top shr Zm-LT] := clBlack;
    //Bottom side
    Pixels[((Rect.Width shr 1) + Rect.Left) shr Zm-1,Rect.Bottom shr Zm] := clBlack;
    Pixels[((Rect.Width shr 1) + Rect.Left) shr Zm  ,Rect.Bottom shr Zm] := clYellow;
    Pixels[((Rect.Width shr 1) + Rect.Left) shr Zm+1,Rect.Bottom shr Zm] := clBlack;

    //Y side black and yellow pixels
    //left side
    Pixels[Rect.Left shr Zm-1,((Rect.Height shr 1) + Rect.Top) shr Zm-1] := clBlack;
    Pixels[Rect.Left shr Zm-1,((Rect.Height shr 1) + Rect.Top) shr Zm  ] := clYellow;
    Pixels[Rect.Left shr Zm-1,((Rect.Height shr 1) + Rect.Top) shr Zm+1] := clBlack;
    //right side
    Pixels[Rect.Right shr Zm,((Rect.Height shr 1) + Rect.Top) shr Zm-1] := clBlack;
    Pixels[Rect.Right shr Zm,((Rect.Height shr 1) + Rect.Top) shr Zm  ] := clYellow;
    Pixels[Rect.Right shr Zm,((Rect.Height shr 1) + Rect.Top) shr Zm+1] := clBlack;
   end; //if (XYprofileRectVisible) then begin

end;
         
 Pen.Width := PenWidthMem; //restore PenWidth

 if (XYprofileRectVisible) then CalculateXYprofile;

End; //With With aCanvas Do Begin
End;  //Procedure DrawSelFrame

{**********************************************************************}
Procedure DrawScaleBar(const Zoomed : Integer; Const ScaleBar : TTimeOrSizeBar; Const aCanvas: TCanvas);
//Zoomed is the Zoom. It is passed as parameter because Line Scan window is Always Zoom = 1 independantly of the Other Windows
begin
  with aCanvas do begin
    Brush.Color := LSTimeBarPar.Color;
    Brush.Style := bsSolid;
    Pen.Color   := LSTimeBarPar.Color;
    if (Zoomed = 1) then Rectangle(ScaleBar.XL,ScaleBar.YT,ScaleBar.XR,ScaleBar.YB) else
    if (Zoomed = 2) then Rectangle(ScaleBar.XL shl Zm,ScaleBar.YT shl Zm,ScaleBar.XR shl Zm,ScaleBar.YB shl Zm) else
    if (Zoomed =-2) then Rectangle(ScaleBar.XL shr Zm,ScaleBar.YT shr Zm,ScaleBar.XR shr Zm,ScaleBar.YB shr Zm);
    Brush.Style := bsClear;
  end;
End;
{**********************************************************************}
Procedure DrawROI(Const aCanvas: TCanvas);
    { Draws ROIs on Image Window }
Var
  i, XLL, Xrr, CntY: Integer;
  DrawNr: Boolean;
  Lab: AnsiString;
  TpTem: array of TPoint;
  Pcnt: Integer;
Begin

      With aCanvas Do Begin
        Brush.Style := bsClear;
        Pen.Style := psSolid;
        Pen.Mode := pmCopy;
        if ROIvar.UseROINr = True then
        begin
          DrawNr := True;
          Font.Name := 'Arial';
          Font.Size := 8;
        end
        else
          DrawNr := False;

        For i := 1 to 21 do
        begin
          { 1st: chooses Color }
          If (ROIvar.ROIAdr[i] > 0) then
          Begin
            if (ROIvar.UseMonoCol = False) or (i = 21) then
              aCanvas.Pen.Color := ROIvar.ROICol[i]
            else
              aCanvas.Pen.Color := ROIvar.MonoCol;
          End;

          { 2nd: Draws ROIs }
          If (ROIvar.ROIAdr[i] = 1) then
          Begin
            if (ROIvar.TickLine <> i) and (i < 21) then
            begin
              aCanvas.Pen.Width := ROIvar.TckNess;

              if Zoom = 1 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] - ROIrct.LT,
                  ROIvar.ROICoor[2, i] - ROIrct.LT,
                  ROIvar.ROICoor[3, i] + ROIrct.RB,
                  ROIvar.ROICoor[4, i] + ROIrct.RB)
              else if Zoom = 2 then begin
                if Zm = 1 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shl Zm - ROIrct.LT,
                  ROIvar.ROICoor[2, i] shl Zm - ROIrct.LT,
                  ROIvar.ROICoor[3, i] shl Zm + ROIrct.RB + 1,
                  ROIvar.ROICoor[4, i] shl Zm + ROIrct.RB + 1)
                  else
                if Zm = 2 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shl Zm - ROIrct.LT,
                  ROIvar.ROICoor[2, i] shl Zm - ROIrct.LT,
                  ROIvar.ROICoor[3, i] shl Zm + ROIrct.RB + 3,
                  ROIvar.ROICoor[4, i] shl Zm + ROIrct.RB + 3);
              end
              else if Zoom = -2 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shr Zm - ROIrct.LT,
                  ROIvar.ROICoor[2, i] shr Zm - ROIrct.LT,
                  ROIvar.ROICoor[1, i] shr Zm + (ROIvar.ROICoor[3,i] -
                  ROIvar.ROICoor[1, i] + 1) shr Zm - 1 + ROIrct.RB,
                  ROIvar.ROICoor[2, i] shr Zm + (ROIvar.ROICoor[4,i] -
                  ROIvar.ROICoor[2, i] + 1) shr Zm - 1 + ROIrct.RB);
            end
            else if (ROIvar.TickLine = i) then
            begin
              aCanvas.Pen.Width := ROIvar.Ticker;
              if Zoom = 1 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] - ROIrct.tLT,
                  ROIvar.ROICoor[2, i] - ROIrct.tLT,
                  ROIvar.ROICoor[3, i] + ROIrct.tRB,
                  ROIvar.ROICoor[4, i] + ROIrct.tRB)
              else if Zoom = 2 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shl Zm - ROIrct.tLT,
                  ROIvar.ROICoor[2, i] shl Zm - ROIrct.tLT,
                  ROIvar.ROICoor[3, i] shl Zm + ROIrct.tRB + Zm,
                  ROIvar.ROICoor[4, i] shl Zm + ROIrct.tRB + Zm)
              else if Zoom = -2 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shr Zm - ROIrct.tLT,
                  ROIvar.ROICoor[2, i] shr Zm - ROIrct.tLT,
                  ROIvar.ROICoor[1, i] shr Zm + (ROIvar.ROICoor[3,
                    i] - ROIvar.ROICoor[1, i] + 1) shr Zm - 1 + ROIrct.tRB,
                  ROIvar.ROICoor[2, i] shr Zm + (ROIvar.ROICoor[4,
                    i] - ROIvar.ROICoor[2, i] + 1) shr Zm - 1 + ROIrct.tRB);
            end
            else if (i = 21) then
            begin

              aCanvas.Pen.Width := 3;
              if Zoom = 1 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] - ROIrct.frLT,
                  ROIvar.ROICoor[2, i] - ROIrct.frLT,
                  ROIvar.ROICoor[3, i] + ROIrct.frRB,
                  ROIvar.ROICoor[4, i] + ROIrct.frRB)
              else if Zoom = 2 then
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shl Zm - ROIrct.frLT,
                  ROIvar.ROICoor[2, i] shl Zm - ROIrct.frLT,
                  ROIvar.ROICoor[3, i] shl Zm + ROIrct.frRB + Zm,
                  ROIvar.ROICoor[4, i] shl Zm + ROIrct.frRB + Zm)
              else

                if Zoom = -2 then // this works
                aCanvas.Rectangle(ROIvar.ROICoor[1, i] shr Zm - ROIrct.frLT,
                  ROIvar.ROICoor[2, i] shr Zm - ROIrct.frLT,
                  ROIvar.ROICoor[1, i] shr Zm + (ROIvar.ROICoor[3,i] -
                  ROIvar.ROICoor[1, i] + 1) shr Zm - 1 + ROIrct.frRB,
                  ROIvar.ROICoor[2, i] shr Zm + (ROIvar.ROICoor[4,i] -
                  ROIvar.ROICoor[2, i] + 1) shr Zm - 1 + ROIrct.frRB);
            end;

            if (DrawNr = True) and (i < 21) then
            begin
              if ROIvar.UseMonoFontCol = False then
                Font.Color := ROIvar.ROICol[i]
              else
                Font.Color := ROIvar.MonoFontCol;

              Lab := IntToStr(i);
              if Zoom = 1 then
              begin
                if ROIvar.ROICoor[2, i] - 14 > 0 then
                  TextOut((ROIvar.ROICoor[1, i] + (ROIvar.ROICoor[3,
                        i] - ROIvar.ROICoor[1, i] + 1) shr 1) -
                      (Length(Lab) * 6) shr 1, ROIvar.ROICoor[2, i] - 16, Lab)
                else
                  TextOut((ROIvar.ROICoor[1, i] + (ROIvar.ROICoor[3,
                        i] - ROIvar.ROICoor[1, i] + 1) shr 1) -
                      (Length(Lab) * 6) shr 1, ROIvar.ROICoor[4, i] + 2, Lab);
              end
              else if Zoom = 2 then
              begin
                if ROIvar.ROICoor[2, i] shl Zm - 14 > 0 then
                  TextOut((ROIvar.ROICoor[1, i] + (ROIvar.ROICoor[3,
                        i] - ROIvar.ROICoor[1, i] + 1) shr 1) shl Zm -
                      (Length(Lab) * 6) shr 1,
                    ROIvar.ROICoor[2, i] shl Zm - 16, Lab)
                else
                  TextOut((ROIvar.ROICoor[1, i] + (ROIvar.ROICoor[3,
                        i] - ROIvar.ROICoor[1, i] + 1) shr 1) shl Zm -
                      (Length(Lab) * 6) shr 1,
                    ROIvar.ROICoor[4, i] shl Zm + 2, Lab);
              end
              else if Zoom = -2 then
              begin
                if ROIvar.ROICoor[2, i] shr Zm - 14 > 0 then
                  TextOut((ROIvar.ROICoor[1, i] + (ROIvar.ROICoor[3,
                        i] - ROIvar.ROICoor[1, i] + 1) shr 1) shr Zm -
                      (Length(Lab) * 6) shr 1,
                    ROIvar.ROICoor[2, i] shr Zm - 16, Lab)
                else
                  TextOut((ROIvar.ROICoor[1, i] + (ROIvar.ROICoor[3,
                        i] - ROIvar.ROICoor[1, i] + 1) shr 1) shr Zm -
                      (Length(Lab) * 6) shr 1,
                    ROIvar.ROICoor[4, i] shr Zm + 2, Lab);
              end
              else
              end;
            End; { if (BoxPar.BoxAdr[i] = 1) }

            { Free Hand }
            If (ROIvar.ROIAdr[i] = 3) then
            Begin
              if ROIvar.TickLine <> i then
                aCanvas.Pen.Width := ROIvar.FhTickness
              else
                aCanvas.Pen.Width := ROIvar.Ticker;
              if Zm = 0 then
                aCanvas.Polygon(FhPol[i])
              else
              begin
                SetLength(TpTem, Length(FhPol[i]));
                Pcnt := 0;
                if Zoom = 1 then
                  while Pcnt < Length(TpTem) do
                  begin
                    TpTem[Pcnt].x := FhPol[i, Pcnt].x;
                    TpTem[Pcnt].y := FhPol[i, Pcnt].y;
                    Inc(Pcnt);
                  end
                  else if Zoom = 2 then
                    while Pcnt < Length(TpTem) do
                    begin
                      TpTem[Pcnt].x := FhPol[i, Pcnt].x shl Zm;
                      TpTem[Pcnt].y := FhPol[i, Pcnt].y shl Zm;
                      Inc(Pcnt);
                    end
                    else if Zoom = -2 then
                      while Pcnt < Length(TpTem) do
                      begin
                        TpTem[Pcnt].x := FhPol[i, Pcnt].x shr Zm;
                        TpTem[Pcnt].y := FhPol[i, Pcnt].y shr Zm;
                        Inc(Pcnt);
                      end;
                aCanvas.Polygon(TpTem);
              end;
              if DrawNr = True then
              begin
                if ROIvar.UseMonoFontCol = False then
                  Font.Color := ROIvar.ROICol[i]
                else
                  Font.Color := ROIvar.MonoFontCol;
                Lab := IntToStr(i);
                XLL := imXsize - 1;
                Xrr := 0;
                For CntY := 0 to High(FhTbl[i]) do
                begin
                  if XLL > FhTbl[i, CntY, 0].x then
                    XLL := FhTbl[i, CntY, 0].x;
                  if Xrr < FhTbl[i, CntY, High(FhTbl[i, CntY])].x then
                    Xrr := FhTbl[i, CntY, High(FhTbl[i, CntY])].x;
                End; { For CntY := 0 to High(FhTbl[CurROIadr]) }
                if Zoom = 1 Then
                Begin
                  if FhTbl[i, 0, 0].y - 14 >= 0 then
                    TextOut
                      (((XLL + (Xrr - XLL) shr 1 - (Length(Lab) * 6) shr 1)),
                      (FhTbl[i, 0, 0].y - 16), Lab)
                  else
                    TextOut
                      (((XLL + (Xrr - XLL) shr Zm - (Length(Lab) * 6) shr 1)),
                      (FhTbl[i, High(FhTbl[i]), 0].y + 2), Lab);
                end
                else if Zoom = 2 Then
                Begin
                  if FhTbl[i, 0, 0].y - 14 >= 0 then
                    TextOut
                      (((XLL + (Xrr - XLL) shr 1 - (Length(Lab) * 6) shr 1))
                        shl Zm, (FhTbl[i, 0, 0].y shl Zm - 16), Lab)
                  else
                    TextOut
                      (((XLL + (Xrr - XLL) shr Zm - (Length(Lab) * 6) shr 1))
                        shl Zm, (FhTbl[i, High(FhTbl[i]), 0].y shl Zm + 2),
                      Lab);
                end
                else if Zoom = -2 Then
                Begin
                  if FhTbl[i, 0, 0].y - 14 >= 0 then
                    TextOut
                      (((XLL + (Xrr - XLL) shr 1 - (Length(Lab) * 6) shr 1))
                        shr Zm, (FhTbl[i, 0, 0].y shr Zm - 16), Lab)
                  else
                    TextOut
                      (((XLL + (Xrr - XLL) shr Zm - (Length(Lab) * 6) shr 1))
                        shr Zm, (FhTbl[i, High(FhTbl[i]), 0].y shr Zm + 2),
                      Lab);
                end
                else
                end;
              End;
            End; { For i := 1 to 20 do begin }
          End; { With .... }
End; { Procedure ProcDrawROI; }
{ ****************************************************************************** }
Function GetMeanFhROI(Const Location: Byte): Double;
        { ------ Calculates Mean of Free Hand Area ------ }
var
  XLL, Xrr, Yupp, Ydd, NrElem, KndROI, CntY, CntX: Integer;
  MeanFh: Double;

Begin

          KndROI := 3;
          NrElem := 0;
          MeanFh := 0;

          For CntY := 0 to High(FhTbl[CurROIadr]) Do Begin
            If ( High(FhTbl[CurROIadr, CntY]) > 0) Then Begin { more then one Pixel }
              CntX := 0;
              While CntX < High(FhTbl[CurROIadr, CntY]) Do Begin
                XLL := FhTbl[CurROIadr, CntY, CntX].x;
                Xrr := FhTbl[CurROIadr, CntY, CntX + 1].x;
                Yupp := FhTbl[CurROIadr, CntY, CntX].y;
                Ydd := Yupp;
                Inc(NrElem, (Xrr - XLL + 1));
                if (Location = OnMainIm) then
                  MeanFh := MeanFh + GetMeanROI(XLL, Xrr, Yupp, Ydd, KndROI)
                else if (Location = OnAverIm) then
                  MeanFh := MeanFh + GetMeanROIAverIm(AvImRaw, XLL, Xrr, Yupp,
                    Ydd, KndROI);
                Inc(CntX, 2);
              End; { while }
            End
              Else { If (High(FhTbl[CurROIadr,CntY]) > 0) Then Begin }
            If ( High(FhTbl[CurROIadr, CntY]) = 0) Then Begin
              XLL := FhTbl[CurROIadr, CntY, 0].x;
              Xrr := XLL;
              Yupp := FhTbl[CurROIadr, CntY, 0].y;
              Ydd := Yupp;
              Inc(NrElem);
              if (Location = OnMainIm) then
                MeanFh := MeanFh + GetMeanROI(XLL, Xrr, Yupp, Ydd, KndROI)
              else if (Location = OnAverIm) then
                MeanFh := MeanFh + GetMeanROIAverIm(AvImRaw, XLL, Xrr, Yupp,
                  Ydd, KndROI);
            End; { (High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel }
          End; { For CntY := 0 to High(TabFh) do begin }

          if ((RatioOn) or (ChannelsRatioOn)) and (Location = OnMainIm) then
            Result := MeanFh / (NrElem * DispFact)
          else
            Result := MeanFh / NrElem;

End; { Function GetMeanFhROI : Double; }

        { ****************************************************************************** }
Procedure Delay(var msec: Longint);
var
          start, stop: Longint;
Begin
          start := GetTickCount;
          repeat
            stop := GetTickCount;
            Application.ProcessMessages;
          until (stop - start) >= msec;
        End; { Procedure delay(msec:longint); }

        { ****************************************************************************** }
        { ------------------------------------------------- }
        Procedure TStringGridHack.DeleteRow(ARow: Longint);
        var
          GemRow: Integer;
        begin
          GemRow := Row;
          if RowCount > FixedRows + 1 then
            inherited DeleteRow(ARow)
          else
            Rows[ARow].Clear;
          if GemRow < RowCount then
            Row := GemRow;
        end;

        { ****************************************************************************** }
        Procedure TStringGridHack.InsertRow(ARow: Longint);
        var
          GemRow: Integer;
        begin
          GemRow := Row;
          RowCount := RowCount + 1;
          MoveRow(RowCount - 1, ARow);
          Row := GemRow;
          Rows[Row].Clear;
        End;

        { ---------------------------------------------------------- }
        { ****************************************************************************** }
        procedure TStringGridHack.DeleteColumn(ACol: Longint);
        begin

          if ACol = FixedCols then
            if ACol = (ColCount - 1) then
            begin
              Cols[ACol].Clear;
              if ColCount > (FixedCols + 1) then
                ColCount := (ColCount - 1);
            end
            else
            begin
              Cols[ACol] := Cols[ACol + 1];
              DeleteColumn(ACol + 1);
            end;
        end;

        { ****************************************************************************** }
        Procedure DelAnyMarkFromMarkArr(var MarkArrXY: TMarkArrXY;
          var MarkAmpl: TDyn2DSingleArr; var MarkBase: TDyn2DSingleArr;
          var MarkEvDur: TMarkArrDur; var MarkRiseTime: TDyn2DSingleArr;
          Const Mpos, ImNum: Integer);

        var
          CntX: Integer;

        Begin

          for CntX := Mpos to High(MarkArrXY[ImNum]) do
            MarkArrXY[ImNum, CntX] := MarkArrXY[ImNum, CntX + 1];

          for CntX := Mpos to High(MarkAmpl[ImNum]) do
            MarkAmpl[ImNum, CntX] := MarkAmpl[ImNum, CntX + 1];

          for CntX := Mpos to High(MarkBase[ImNum]) do
            MarkBase[ImNum, CntX] := MarkBase[ImNum, CntX + 1];

          for CntX := Mpos to High(MarkEvDur[ImNum]) do
            MarkEvDur[ImNum, CntX] := MarkEvDur[ImNum, CntX + 1];

          for CntX := Mpos to High(MarkRiseTime[ImNum]) do
            MarkRiseTime[ImNum, CntX] := MarkRiseTime[ImNum, CntX + 1];

          SetLength(MarkArrXY[ImNum], High(MarkArrXY[ImNum]));
          SetLength(MarkAmpl[ImNum], High(MarkAmpl[ImNum]));
          SetLength(MarkBase[ImNum], High(MarkBase[ImNum]));
          SetLength(MarkEvDur[ImNum], High(MarkEvDur[ImNum]));
          SetLength(MarkRiseTime[ImNum], High(MarkRiseTime[ImNum]));

        End;
        { ****************************************************************************** }

        Procedure DrawSmalEvMarks(Const aCanvas: TCanvas);
        Var
          i: Integer;
          SetPar: Boolean;
        Begin
          SetPar := True;
          For i := 0 to High(MarkSmEvCoor[CurIm]) do
          Begin
            PlaceMark(MarkSmEvCoor[CurIm, i].x, MarkSmEvCoor[CurIm, i].y,
              MarkPar.SmallEventColor, aCanvas, SetPar);
            if SetPar = True then
              SetPar := False;
          End;

        End;
        { ************************************************************************** }

        Procedure DrawBigEvMarks(Const aCanvas: TCanvas);
        Var
          i: Integer;
          SetPar: Boolean;
        Begin
          SetPar := True;
          For i := 0 to High(MarkBigEvCoor[CurIm]) do
          Begin
            PlaceMark(MarkBigEvCoor[CurIm, i].x, MarkBigEvCoor[CurIm, i].y,
              MarkPar.BigEventColor, aCanvas, SetPar);
            if SetPar = True then
              SetPar := False;
          End;

        End;

        { ************************************************************************** }
        Procedure DrawAllSmallEvMarks(Const aCanvas: TCanvas);
        Var
          i, N: Integer;
          SetPar: Boolean;

        Begin
          SetPar := True;
          For N := 0 to NrIm - 1 Do
          Begin
            For i := 0 to High(MarkSmEvCoor[N]) do
            Begin
              PlaceMark(MarkSmEvCoor[N, i].x, MarkSmEvCoor[N, i].y,
                MarkPar.SmallEventColor, aCanvas, SetPar);

            End;
            if SetPar = True then
              SetPar := False;
          End;

        End;

        { ************************************************************************** }
        Procedure DrawAllBigEvMarks(Const aCanvas: TCanvas);
        Var
          i, N: Integer;
          SetPar: Boolean;

        Begin
          SetPar := True;
          For N := 0 to NrIm - 1 Do
          Begin
            For i := 0 to High(MarkBigEvCoor[N]) do
            Begin
              PlaceMark(MarkBigEvCoor[N, i].x, MarkBigEvCoor[N, i].y,
                MarkPar.BigEventColor, aCanvas, SetPar);
            End;
            if SetPar = True then
              SetPar := False;
          End;

        End;

        { ************************************************************************** }
        Procedure PlaceMark(Const Xm, Ym: Integer; Const Clr: LongWord;
          Const aCanvas: TCanvas; Const SetPar: Boolean);

        var
          Xb, Xe, YB, Ye: Integer;
        Begin
          With aCanvas Do
          Begin
            Pen.Color := Clr; { Color should be updated every time }
            Pen.Width := MarkPar.Thick;
            if SetPar then
            begin
              Pen.Mode := pmCopy;
              Pen.Style := psSolid;
            end;
            Xb := Xm - MarkPar.Size;
            Xe := Xm + MarkPar.Size + 1; { Win32 API draws 1 pixel less }
            YB := Ym - MarkPar.Size;
            Ye := Ym + MarkPar.Size + 1; { Win32 API draws 1 pixel less }

            If Zoom = 1 then
            Begin
              { Horiz }
              MoveTo(Xb, Ym);
              LineTo(Xe, Ym);
              { Vert }
              MoveTo(Xm, YB);
              LineTo(Xm, Ye);
            End
            Else If Zoom = 2 then
            Begin
              { Horiz }
              MoveTo(Xb shl Zm, Ym shl Zm);
              LineTo(Xe shl Zm, Ym shl Zm);
              { Vert }
              MoveTo(Xm shl Zm, YB shl Zm);
              LineTo(Xm shl Zm, Ye shl Zm);
            End
            Else If Zoom = -2 then
            Begin
              { Horiz }
              MoveTo(Xb shr Zm, Ym shr Zm);
              LineTo(Xe shr Zm, Ym shr Zm);
              { Vert }
              MoveTo(Xm shr Zm, YB shr Zm);
              LineTo(Xm shr Zm, Ye shr Zm);
            End;
          End;
        End;
        { ************************************************************************** }

        Procedure CheckIfInMark(var MarkArrXY: TMarkArrXY; var Xm, Ym: Integer;
          var InMark: Boolean; var Mpos: Integer; Xmouse, Ymouse: Integer);

        var
          i: Integer;

        Begin
          InMark := False;
          For i := 0 to High(MarkArrXY[CurIm]) Do
          Begin
            if (Xmouse > MarkArrXY[CurIm, i].x - 3) then
              if (Xmouse < MarkArrXY[CurIm, i].x + 3) then
                if (Ymouse > MarkArrXY[CurIm, i].y - 3) then
                  if (Ymouse < MarkArrXY[CurIm, i].y + 3) then
                  Begin
                    InMark := True;
                    Mpos := i;
                    Xm := MarkArrXY[CurIm, i].x;
                    Ym := MarkArrXY[CurIm, i].y;
                    Break;
                  End; { Gets the Conditions }
          End; { For i := 0 to High(MarkBigEvCoor[CurIm]) Do Begin }

        End;
        { Procedure CheckIfInMark }
        { ************************************************************************** }
        Procedure DelRowInStringGrid(var StrGrid: TStringGrid;
          var TabEmpty: Boolean; Xmark, Ymark: Integer);
        var
          i, DelRow, R: Integer;

        Begin

          With StrGrid Do
          Begin
            For i := 1 to RowCount - 1 Do
            Begin
              if CurIm = StrToInt(Cells[1, i]) - 1 then
                if Xmark = StrToInt(Cells[2, i]) then
                  if Ymark = StrToInt(Cells[3, i]) then
                  begin
                    DelRow := i;
                    TStringGridHack(StrGrid).DeleteRow(DelRow);
                    if DelRow <= RowCount - 1 then
                      Row := DelRow
                    else if DelRow > RowCount - 1 then
                      Row := RowCount - 1;
                    SetFocus;
                    if Cells[0, 1] = '' then
                    begin
                      TabEmpty := True;
                    end;
                    If TabEmpty = False then
                    Begin
                      for R := Row to RowCount - 1 do
                        Cells[0, R] := IntToStr(R);
                    End;
                    Break;
                  end; { If im# and X & Y coinside }
            End; { For i := 1 to RowCount - 1 }
          End; { With }

        End;
        { Procedure DelRowInStringGrid }
        { ************************************************************************** }
Procedure PutRowInStringGrid(var StrGrid: TStringGrid;
          Var RowFoc: Integer; Const MarkArrXY: TMarkArrXY;
          Const MarkAmpl: TDyn2DSingleArr; Const MarkBase: TDyn2DSingleArr;
          var TabEmpty: Boolean);

Var  i, R: Integer;
Begin
          { [Column, Row] }

          If (TabEmpty = False) then Begin
            If CurIm >= StrToInt(StrGrid.Cells[1, StrGrid.RowCount - 1])- 1 Then
            Begin
              StrGrid.RowCount := StrGrid.RowCount + 1;
              RowFoc := StrGrid.RowCount - 1;
              StrGrid.Row := RowFoc;
              StrGrid.Invalidate;
            End
              Else
            Begin
              i := 1;
              While i < StrGrid.RowCount Do Begin
                if CurIm < StrToInt(StrGrid.Cells[1, i]) - 1 Then Begin
                  RowFoc := i;
                  StrGrid.Row := RowFoc;
                  StrGrid.Invalidate;
                  TStringGridHack(StrGrid).InsertRow(RowFoc);
                  for R := RowFoc + 1 to StrGrid.RowCount - 1 do
                    StrGrid.Cells[0, R] := IntToStr(R);
                  Break;
                End;
                Inc(i);
              End; { While }
            End; { Else Begin }

          End
            Else
          If (TabEmpty = True) then Begin
            RowFoc := 1;
            TabEmpty := False;
          End;
          { Fills SparkTable = Small Events }
          with StrGrid do begin
            Cells[0, RowFoc] := IntToStr(RowFoc);
            Cells[1, RowFoc] := IntToStr(CurIm + 1); { Image # }
            Cells[2, RowFoc] := IntToStr(MarkArrXY[CurIm,
              High(MarkArrXY[CurIm])].x);
            Cells[3, RowFoc] := IntToStr(MarkArrXY[CurIm,
              High(MarkArrXY[CurIm])].y);
            Cells[4, RowFoc] := FloatToStrF
              (MarkAmpl[CurIm, High(MarkAmpl[CurIm])], ffFixed, 5, 3);
          end;

End; { Procedure PutRowInStringGrid }
        { ****************************************************************************** }
Procedure AddMarkToMarkArray(var MarkArrXY: TMarkArrXY; var MarkAmpl: TDyn2DSingleArr;
                             var MarkBase: TDyn2DSingleArr;var MarkEvDur: TMarkArrDur;
                             var MarkRiseTime: TDyn2DSingleArr; Const Xmouse, Ymouse: Integer;
                             Const UseMarkSize: Boolean);
var  XLL, Xrr, Yupp, Ydd: Integer;

Begin
          SetLength(MarkArrXY[CurIm], High(MarkArrXY[CurIm]) + 2);
          { imcrements Array }
          MarkArrXY[CurIm, High(MarkArrXY[CurIm])].x := Xmouse;
          MarkArrXY[CurIm, High(MarkArrXY[CurIm])].y := Ymouse;
          if (UseMarkSize) then begin
            XLL := MarkArrXY[CurIm, High(MarkArrXY[CurIm])].x - (ROIvar.MarkXsize div 2);
            Xrr := XLL + (ROIvar.MarkXsize - 1);
            Yupp := MarkArrXY[CurIm, High(MarkArrXY[CurIm])].y - (ROIvar.MarkYsize div 2);
            Ydd := Yupp + (ROIvar.MarkYsize - 1);
          end
            else
          begin
            XLL := MarkArrXY[CurIm, High(MarkArrXY[CurIm])].x - (ROIvar.BoxXsize div 2);
            Xrr := XLL + (ROIvar.BoxXsize - 1);
            Yupp := MarkArrXY[CurIm, High(MarkArrXY[CurIm])].y - (ROIvar.BoxYsize div 2);
            Ydd := Yupp + (ROIvar.BoxYsize - 1);
          end;
          SetLength(MarkAmpl[CurIm], High(MarkAmpl[CurIm]) + 2);
          { imcrements Array }
          MarkAmpl[CurIm, High(MarkAmpl[CurIm])] := GetMeanROI(XLL, Xrr,Yupp, Ydd,1);
          SetLength(MarkEvDur[CurIm], High(MarkEvDur[CurIm]) + 2);
          { imcrements Array }
          MarkEvDur[CurIm, High(MarkEvDur[CurIm])].L := NOT_ANALYZED;
          MarkEvDur[CurIm, High(MarkEvDur[CurIm])].R := NOT_ANALYZED;
          SetLength(MarkRiseTime[CurIm], High(MarkRiseTime[CurIm]) + 2);
          { imcrements Array }
          MarkRiseTime[CurIm, High(MarkRiseTime[CurIm])] := NOT_ANALYZED;
          SetLength(MarkBase[CurIm], High(MarkBase[CurIm]) + 2);
          { imcrements Array }
          if (RatioOn) then
          MarkBase[CurIm, High(MarkBase[CurIm])] := 1.0 else
          if (ChannelsRatioOn) then
          MarkBase[CurIm, High(MarkBase[CurIm])] := HillEquationParams.MinRatio;

          // Sets baselione to 1 initially

End; // Procedure UpdateMarkArray
{ ****************************************************************************** }
Procedure DrawMesBox;
Begin
          With frmMainWin.winMainImage.Canvas Do
          Begin
            Pen.Mode := pmXOR;
            Pen.Color := RGB(160, 160, 160);
            Pen.Width := ROIvar.TckNess;
            if frmImageControl.MeasureBox.Down = True then
              Pen.Style := psDot
            else
              Pen.Style := psSolid;
            if Zoom = 1 then
              Rectangle(XL - ROIrct.LT, Yup - ROIrct.LT, XR + ROIrct.RB,
                Yd + ROIrct.RB)
            else if Zoom = 2 then
              Rectangle(XL shl Zm - ROIrct.LT, Yup shl Zm - ROIrct.LT,
                XR shl Zm + ROIrct.RB + Zm, Yd shl Zm + ROIrct.RB + Zm)
            else if Zoom = -2 then
              Rectangle(XL shr Zm - ROIrct.LT, Yup shr Zm - ROIrct.LT,
                XR shr Zm + ROIrct.RB - Zm, Yd shr Zm + ROIrct.RB - Zm);
            { Rectangle(XL,Yup,Xr,Yd); }
          End;
        End;

        { ************************************************************************* }
        Procedure MakeMinRunAv(var RunAvMinArr: TDynSingleArray;
          Const Pnt: Integer; Const First, Last: Integer);
        { Pnt = Nr of consecutive Images for Min }
        Var
          ImBufMean: TDynSingleArray; { Contains Image Made from Averaging }
          ImBufTemp: TDynSingleArray; { Temporary Mimimum Array }
          TotNrIm: Integer;
          CntPt, ImNr: Integer;
          MeanTotNrIm: Double;
          MeanFromAv: Double;
          Fact: Double;
          Cnt: Integer;
          CntDone: Integer;

        Begin

          SetLength(ImBufMean, ImagePix);
          SetLength(ImBufTemp, ImagePix);

          for Cnt := 0 to ImagePix - 1 do
            RunAvMinArr[Cnt] := 1024; { sets it at Max value }
          for Cnt := 0 to ImagePix - 1 do
            ImBufMean[Cnt] := 0; { not needed, shold be done on creation }

          { Start }
          CntDone := First - 1;
          For ImNr := First to (Last - Pnt + 1) Do
          Begin

            for Cnt := 0 to ImagePix - 1 do
              ImBufTemp[Cnt] := 0; { Zeroes }

            For CntPt := 0 to Pnt - 1 Do
            Begin
              ReadImage(ImNr + CntPt,0,pImData);
              { Summes for  Average and Mean from Whole File }
              if (BitCount = 16) then
                for Cnt := 0 to ImagePix - 1 do
                  ImBufTemp[Cnt] := ImBufTemp[Cnt] + Im16bitData[Cnt]
                else
                  for Cnt := 0 to ImagePix - 1 do
                    ImBufTemp[Cnt] := ImBufTemp[Cnt] + Im8bitData[Cnt];
              { end summing }

              { Collects Mean }
              if CntDone < ImNr + CntPt then
              Begin
                CntDone := ImNr + CntPt;
                if (BitCount = 16) then
                  for Cnt := 0 to ImagePix - 1 do
                    ImBufMean[Cnt] := ImBufMean[Cnt] + Im16bitData[Cnt]
                  else
                    for Cnt := 0 to ImagePix - 1 do
                      ImBufMean[Cnt] := ImBufMean[Cnt] + Im8bitData[Cnt];
              end;
            End; { For CntPt := 0 to Pnt - 1 }
            { ------------------------ }
            { Makes Average }
            for Cnt := 0 to ImagePix - 1 do
              ImBufTemp[Cnt] := ImBufTemp[Cnt] / Pnt;
            { Collects Minimums }
            For Cnt := 0 to ImagePix - 1 do
            Begin
              if RunAvMinArr[Cnt] > ImBufTemp[Cnt] then
                RunAvMinArr[Cnt] := ImBufTemp[Cnt];
            End;
            { --------------------- }
          End; { ImNr := 0 to NrIm -1 - Pnt }
          { End of Search }

          TotNrIm := Last - First + 1;
          for Cnt := 0 to ImagePix - 1 do
            ImBufMean[Cnt] := ImBufMean[Cnt] / TotNrIm;
          { LSD := 1;
            RSD := 1; }
          GetMeanStdDevLimits(ImBufMean, MeanTotNrIm, 1, 1, 2);
          GetMeanStdDevLimits(RunAvMinArr, MeanFromAv, 1, 1, 2);
          { Does Correction on AvImRaw }

          If MeanFromAv < MeanTotNrIm Then
          Begin { this is What Happens }
            Fact := MeanTotNrIm - MeanFromAv;
            for Cnt := 0 to ImagePix - 1 do
              RunAvMinArr[Cnt] := RunAvMinArr[Cnt] + Fact;
          End
          Else If MeanFromAv > MeanTotNrIm Then
          Begin { Not going to happen }
            Fact := MeanFromAv - MeanTotNrIm;
            for Cnt := 0 to ImagePix - 1 do
              RunAvMinArr[Cnt] := RunAvMinArr[Cnt] - Fact;
          End;

        End;
        { Procedure MakeMinRunAv }
        { ************************************************************************* }
        Procedure MakeRunAv(var AverArr: TDynDoubleArray;
          const ImList: array of Integer; const NrImToAver: Integer);

        Var
          Cnt, CntIm, ImNr: Integer;

        Begin

          for Cnt := 0 to High(AverArr) do
            AverArr[Cnt] := 0; { Zeroes out array }

          For CntIm := 0 to NrImToAver - 1 do
          Begin
            ImNr := ImList[CntIm];
            ReadImage(ImNr,0,pImData);
            { ---------- Gets Mean      --------------- }
            if (BitCount = 16) then
              for Cnt := 0 to High(AverArr) do
                AverArr[Cnt] := AverArr[Cnt] + Im16bitData[Cnt]
              else
                for Cnt := 0 to High(AverArr) do
                  AverArr[Cnt] := AverArr[Cnt] + Im8bitData[Cnt];
          End; { For Cnt := 0 to NrImToAver -1 }

          { ---- Now Divides by the Number of Images Selected --- }
          For Cnt := 0 to High(AverArr) do
            AverArr[Cnt] := AverArr[Cnt] / NrImToAver;

        End; { Procedure MakeRunAv; }

{ ************************************************************************* }
Procedure SmoothRatioImage(var InRatio, OutRatio : TDynSingleArray); { used to apply any Smoothing on Any Ratio After it is Done }
var Cnt : Integer;
Begin

  if (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin

    if (SmoothMode = SMOOTH_BOX_MED) then begin
    BoxCarFilt(OutRatio, InRatio,imXsize, imYsize,BoxSmSize,True);
    MedianFilt(InRatio,  OutRatio,imXsize, imYsize,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_BOX) then begin
    MedianFilt(OutRatio, InRatio,imXsize, imYsize,MedSmSize,True);
    BoxCarFilt(InRatio,  OutRatio,imXsize, imYsize,BoxSmSize,True);
    end else
     if (SmoothMode = SMOOTH_GAUSS_MED) then begin
    Gauss2DFilt(OutRatio, InRatio,imXsize, imYsize,GaussSmSize,True);
    MedianFilt( InRatio,  OutRatio,imXsize, imYsize,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_GAUSS) then begin
    MedianFilt(OutRatio, InRatio,imXsize, imYsize,MedSmSize,True);
    Gauss2DFilt(InRatio, OutRatio,imXsize, imYsize,GaussSmSize,True);
    end;
  end

    else

   begin
  if (SmoothMode = SMOOTH_BOX) then begin
    BoxCarFilt(InRatio,  OutRatio,imXsize, imYsize,BoxSmSize,True)
  end else
  if (SmoothMode = SMOOTH_MED) then begin
    MedianFilt(InRatio,  OutRatio,imXsize, imYsize,MedSmSize,True);
  end else
  if (SmoothMode = SMOOTH_GAUSS) then begin
    Gauss2DFilt(InRatio,  OutRatio,imXsize, imYsize,GaussSmSize,True);
  end;
  end;


End; { Procedure SmoothRatioImage; }     //TDynSingleArray

{******************************************************************************}

Procedure SmoothRatioImage(var InRatio, OutRatio : TDynDoubleArray); { used to apply any Smoothing on Any Ratio After it is Done }
var Cnt : Integer;
Begin

  if (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin

    if (SmoothMode = SMOOTH_BOX_MED) then begin
    BoxCarFilt(OutRatio, InRatio,imXsize, imYsize,BoxSmSize,True);
    MedianFilt(InRatio,  OutRatio,imXsize, imYsize,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_BOX) then begin
    MedianFilt(OutRatio, InRatio,imXsize, imYsize,MedSmSize,True);
    BoxCarFilt(InRatio,  OutRatio,imXsize, imYsize,BoxSmSize,True);
    end else
     if (SmoothMode = SMOOTH_GAUSS_MED) then begin
    Gauss2DFilt(OutRatio, InRatio,imXsize, imYsize,GaussSmSize,True);
    MedianFilt( InRatio,  OutRatio,imXsize, imYsize,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_GAUSS) then begin
    MedianFilt(OutRatio, InRatio,imXsize, imYsize,MedSmSize,True);
    Gauss2DFilt(InRatio, OutRatio,imXsize, imYsize,GaussSmSize,True);
    end;
  end
    else

  begin
  if (SmoothMode = SMOOTH_BOX) then begin
    BoxCarFilt(InRatio,  OutRatio,imXsize, imYsize,BoxSmSize,True)
  end else
  if (SmoothMode = SMOOTH_MED) then begin
    MedianFilt(InRatio,  OutRatio,imXsize, imYsize,MedSmSize,True);
  end else
  if (SmoothMode = SMOOTH_GAUSS) then begin
    Gauss2DFilt(InRatio,  OutRatio,imXsize, imYsize,GaussSmSize,True);
  end;
  end;


End; { Procedure SmoothRatioImage; }    // TDynDoubleArray

{******************************************************************************}


Procedure ApplySmoothing; { used to apply any Smoothing on Main Image }
Begin

  If (SmoothMode = SMOOTH_BOX_MED) then Begin
    if (BitCount = 16) then
      BoxCarFilt(Im16bitData, Im16bitDataSM_First, imXsize, imYsize, BoxSmSize, True)
        else
      BoxCarFilt(Im8bitData, Im16bitDataSM_First, imXsize, imYsize,BoxSmSize, True);
      MedianFilt(Im16bitDataSM_First, Im16bitDataSM_Last, imXsize,imYsize, MedSmSize, True);
  End

    Else

  If (SmoothMode = SMOOTH_GAUSS_MED) then Begin
    if (BitCount = 16) then
      Gauss2DFilt(Im16bitData, Im16bitDataSM_First, imXsize, imYsize,GaussSmSize, True)
        else
      Gauss2DFilt(Im8bitData, Im16bitDataSM_First, imXsize, imYsize,GaussSmSize, True);
      MedianFilt(Im16bitDataSM_First, Im16bitDataSM_Last, imXsize,imYsize, MedSmSize, True);
  End

    Else

  If (SmoothMode = SMOOTH_MED_BOX) then Begin
    if (BitCount = 16) then
      MedianFilt(Im16bitData, Im16bitDataSM_First, imXsize, imYsize,MedSmSize, True)
        else
      MedianFilt(Im8bitData, Im16bitDataSM_First, imXsize, imYsize, MedSmSize, True);
      BoxCarFilt(Im16bitDataSM_First, Im16bitDataSM_Last, imXsize,imYsize, BoxSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_MED_GAUSS) then Begin
    if (BitCount = 16) then
      MedianFilt(Im16bitData, Im16bitDataSM_First, imXsize, imYsize,MedSmSize, True)
        else
      MedianFilt(Im8bitData, Im16bitDataSM_First, imXsize, imYsize,MedSmSize, True);
      Gauss2DFilt(Im16bitDataSM_First, Im16bitDataSM_Last, imXsize,imYsize, GaussSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_BOX) then Begin
    if (BitCount = 16) then
      BoxCarFilt(Im16bitData, Im16bitDataSM_Last, imXsize, imYsize,BoxSmSize, True)
        else
      BoxCarFilt(Im8bitData, Im16bitDataSM_Last, imXsize, imYsize,BoxSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_GAUSS) then Begin
    if (BitCount = 16) then
      Gauss2DFilt(Im16bitData, Im16bitDataSM_Last, imXsize, imYsize,GaussSmSize, True)
        else
      Gauss2DFilt(Im8bitData, Im16bitDataSM_Last, imXsize, imYsize,GaussSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_MED) then Begin
    if (BitCount = 16) then
      MedianFilt(Im16bitData, Im16bitDataSM_Last, imXsize, imYsize,MedSmSize, True)
        else
      MedianFilt(Im8bitData, Im16bitDataSM_Last, imXsize, imYsize,MedSmSize, True);
  End;

End; { Procedure ApplySmoothing; }


{ ************************************************************************* }


Procedure ApplySmoothingOn2ndChannel; { used to apply any Smoothing on 2nd Window}
Begin

  If (SmoothMode = SMOOTH_BOX_MED) then Begin
    if (BitCount = 16) then
      BoxCarFilt(Im2nd16bit, Im16bitDataSM_First, imXsize, imYsize, BoxSmSize, True)
        else
      BoxCarFilt(Im2nd8bit, Im16bitDataSM_First, imXsize, imYsize,BoxSmSize, True);
      MedianFilt(Im16bitDataSM_First, Im2nd16bitSM_Last, imXsize,imYsize, MedSmSize, True);
  End

    Else

  If (SmoothMode = SMOOTH_GAUSS_MED) then Begin
    if (BitCount = 16) then
      Gauss2DFilt(Im2nd16bit, Im16bitDataSM_First, imXsize, imYsize,GaussSmSize, True)
        else
      Gauss2DFilt(Im2nd8bit, Im16bitDataSM_First, imXsize, imYsize,GaussSmSize, True);
      MedianFilt(Im16bitDataSM_First, Im2nd16bitSM_Last, imXsize,imYsize, MedSmSize, True);
  End

    Else

  If (SmoothMode = SMOOTH_MED_BOX) then Begin
    if (BitCount = 16) then
      MedianFilt(Im2nd16bit, Im16bitDataSM_First, imXsize, imYsize,MedSmSize, True)
        else
      MedianFilt(Im2nd8bit, Im16bitDataSM_First, imXsize, imYsize, MedSmSize, True);
      BoxCarFilt(Im16bitDataSM_First, Im2nd16bitSM_Last, imXsize,imYsize, BoxSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_MED_GAUSS) then Begin
    if (BitCount = 16) then
      MedianFilt(Im2nd16bit, Im16bitDataSM_First, imXsize, imYsize,MedSmSize, True)
        else
      MedianFilt(Im2nd8bit, Im16bitDataSM_First, imXsize, imYsize,MedSmSize, True);
      Gauss2DFilt(Im16bitDataSM_First, Im2nd16bitSM_Last, imXsize,imYsize, GaussSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_BOX) then Begin
    if (BitCount = 16) then
      BoxCarFilt(Im2nd16bit, Im2nd16bitSM_Last, imXsize, imYsize,BoxSmSize, True)
        else
      BoxCarFilt(Im2nd8bit, Im2nd16bitSM_Last, imXsize, imYsize,BoxSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_GAUSS) then Begin
    if (BitCount = 16) then
      Gauss2DFilt(Im2nd16bit, Im2nd16bitSM_Last, imXsize, imYsize,GaussSmSize, True)
        else
      Gauss2DFilt(Im2nd8bit, Im2nd16bitSM_Last, imXsize, imYsize,GaussSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_MED) then Begin
    if (BitCount = 16) then
      MedianFilt(Im2nd16bit, Im2nd16bitSM_Last, imXsize, imYsize,MedSmSize, True)
        else
      MedianFilt(Im2nd8bit, Im2nd16bitSM_Last, imXsize, imYsize,MedSmSize, True);
  End;

End; { Procedure ApplySmoothingOn2ndChannel; }


{ **************************************************************************** }

Procedure SmoothBorders;
        { used to apply any Smoothing on Borders for TimeSeriesAnalysis }

        Begin
          If (SmoothMode = SMOOTH_BOX_MED) then
          begin
            if (BitCount = 16) then
              SmoothBorderBoxCarFilt(Im16bitData, Im16bitDataSM_First, imXsize,
                imYsize, BoxSmSize)
            else
              SmoothBorderBoxCarFilt(Im8bitData, Im16bitDataSM_First, imXsize,
                imYsize, BoxSmSize);
            SmoothBorderMedianFilt(Im16bitDataSM_First, Im16bitDataSM_Last,
              imXsize, imYsize, MedSmSize);
          End
          Else

            If (SmoothMode = SMOOTH_GAUSS_MED) then
          begin
            if (BitCount = 16) then
              SmoothBorderGauss2DFilt(Im16bitData, Im16bitDataSM_First,
                imXsize, imYsize, GaussSmSize)
            else
              SmoothBorderGauss2DFilt(Im8bitData, Im16bitDataSM_First, imXsize,
                imYsize, GaussSmSize);
            SmoothBorderMedianFilt(Im16bitDataSM_First, Im16bitDataSM_Last,
              imXsize, imYsize, MedSmSize);
          End
          Else

            If (SmoothMode = SMOOTH_MED_BOX) then
          begin
            if (BitCount = 16) then
              SmoothBorderMedianFilt(Im16bitData, Im16bitDataSM_First, imXsize,
                imYsize, MedSmSize)
            else
              SmoothBorderMedianFilt(Im8bitData, Im16bitDataSM_First, imXsize,
                imYsize, MedSmSize);
            SmoothBorderBoxCarFilt(Im16bitDataSM_First, Im16bitDataSM_Last,
              imXsize, imYsize, BoxSmSize);
          End
          Else

            If (SmoothMode = SMOOTH_MED_GAUSS) then
          begin
            if (BitCount = 16) then
              SmoothBorderMedianFilt(Im16bitData, Im16bitDataSM_First, imXsize,
                imYsize, MedSmSize)
            else
              SmoothBorderMedianFilt(Im8bitData, Im16bitDataSM_First, imXsize,
                imYsize, MedSmSize);
            SmoothBorderGauss2DFilt(Im16bitDataSM_First, Im16bitDataSM_Last,
              imXsize, imYsize, GaussSmSize);
          End
          Else

            If (SmoothMode = SMOOTH_BOX) then
          begin
            if (BitCount = 16) then
              SmoothBorderBoxCarFilt(Im16bitData, Im16bitDataSM_Last, imXsize,
                imYsize, BoxSmSize)
            else
              SmoothBorderBoxCarFilt(Im8bitData, Im16bitDataSM_Last, imXsize,
                imYsize, BoxSmSize);
          End
          Else

            If (SmoothMode = SMOOTH_GAUSS) then
          begin
            if (BitCount = 16) then
              SmoothBorderGauss2DFilt(Im16bitData, Im16bitDataSM_Last, imXsize,
                imYsize, GaussSmSize)
            else
              SmoothBorderGauss2DFilt(Im8bitData, Im16bitDataSM_Last, imXsize,
                imYsize, GaussSmSize);
          End
          Else

            If (SmoothMode = SMOOTH_MED) then
          begin
            if (BitCount = 16) then
              SmoothBorderMedianFilt(Im16bitData, Im16bitDataSM_Last, imXsize,
                imYsize, MedSmSize)
            else
              SmoothBorderMedianFilt(Im8bitData, Im16bitDataSM_Last, imXsize,
                imYsize, MedSmSize);
          End;

End; { Procedure SmoothBorders }

        { **************************************************************** }

Procedure DoOneRowAnal(var StrGrid: TStringGrid;
          Const MarkArrXY: TMarkArrXY; Const MarkEvDur: TMarkArrDur;
          Const MarkBase: TDyn2DSingleArr; var TabEmpty: Boolean;
          Const ARow: Integer; Const TimeCode: Word);

        Var
          ImageSel, BegOfAnal, EndOfAnal: Integer;
          // OneImageTime : Double;
          NrImagesToDo: Integer;
          M, Cnt: Integer;
          Xcent, Ycent: Integer; { X,Y center of peak }
          Sender: TObject;
          ImBelowPeak: Integer;
          ImAbovePeak: Integer;

        Begin

          If (TabEmpty = False) Then
          Begin

            ImageSel := StrToInt(StrGrid.Cells[1, ARow]) - 1;
            { CurIm starts from 0 }
            PLOTvar.ImNrFromTable := ImageSel;
            { Creates And Positions a Box on Address 20 }
            Xcent := StrToInt(StrGrid.Cells[2, ARow]);
            Ycent := StrToInt(StrGrid.Cells[3, ARow]);

            XL := Xcent - ROIvar.BoxXsize shr 1;
            XR := Xcent + ROIvar.BoxXsize shr 1 - (1 - ROIvar.BoxXsize mod 2);
            Yup := Ycent - ROIvar.BoxYsize shr 1;
            Yd := Ycent + ROIvar.BoxYsize shr 1 - (1 - ROIvar.BoxYsize mod 2);

            CurROIkind := 1;
            CurROIadr := 20;
            KeepROIinWindow;
            if ROIvar.ROIAdr[20] = 0 then
              Inc(ROIvar.NrROI);
            if ROIvar.ROIAdr[20] = 3 then
            begin { free hand exists }
              FhPol[CurROIadr] := nil; { Deletes FreeHand on Address 20 }
              FhTbl[CurROIadr] := nil;
            end;
            UpdateROI;
            CurROIadr := 0; { Has to be Done }
            if CurIm <> ImageSel then
            begin
              CurIm := ImageSel;
              if frmPlayback.LockImagesToLoop.Down then
              begin
                frmPlayback.LockImagesToLoop.Down := False; // release Lock
                frmPlayback.LockImagesToLoopClick(Sender);
              end;
              frmPlayback.PlaybackScrollBar.Position := CurIm;
            end
              else
            begin
              UpdateMainImage(True);
            end;
            { --------- Now with Average Image-- }
            if (frmAverIm <> nil) and (AvImExists > 0) and (ROIvar.ROIonAverWin = True)
            then UpdateAverImage(True);

            { ---- end with average Image---- }
            { --- End with Making the Box - }
            { TimeCode = ItemIndex from ComboBox)
              0 - 0.5 s
              1 - 1 s
              2 - 2 s
              3 - 5 s
              4 - 10 s
              5 - 30 s
              6 - 60 s
              7 - Total }

            If TimeCode < 7 Then
            Begin

              { NrImagesToDo := Left and Rigth from Sel Image }
              if TimeCode = 0 then
                NrImagesToDo := round(0.25 / MeanImTime)
              else if TimeCode = 1 then
                NrImagesToDo := round(0.5 / MeanImTime)
              else if TimeCode = 2 then
                NrImagesToDo := round(1.0 / MeanImTime)
              else if TimeCode = 3 then
                NrImagesToDo := round(2.5 / MeanImTime)
              else if TimeCode = 4 then
                NrImagesToDo := round(5.0 / MeanImTime)
              else if TimeCode = 5 then
                NrImagesToDo := round(15.0 / MeanImTime)
              else if TimeCode = 6 then
                NrImagesToDo := round(30.0 / MeanImTime);

              if NrImagesToDo < frmTimeSerPlot.dsXaxes.Delta div 2 + 1 then
                NrImagesToDo := frmTimeSerPlot.dsXaxes.Delta div 2 + 1;

              BegOfAnal := ImageSel - NrImagesToDo;
              EndOfAnal := ImageSel + NrImagesToDo;

              If BegOfAnal < 0 Then
              Begin
                BegOfAnal := 0;
                EndOfAnal := BegOfAnal + 2 * NrImagesToDo;
              End;
              if EndOfAnal > NrIm - 1 Then
              Begin
                EndOfAnal := NrIm - 1;
                BegOfAnal := EndOfAnal - (2 * NrImagesToDo);
                if BegOfAnal < 0 then
                  BegOfAnal := 0;
              end
            End
            Else If TimeCode = 7 Then
            Begin // = total
              BegOfAnal := 0;
              EndOfAnal := NrIm - 1;
            End; { TimeCode = 6 }

            { Plotting Peaks }
            PLOTvar.HasPeaks := False; // here used as boolean
            If (RatioOn) and Not(TimPltSlid.GetPeaks) and
              ( High(MarkArrXY[ImageSel]) > -1) then
            begin
              For M := 0 to High(MarkArrXY[ImageSel]) do
              Begin
                If (Xcent = MarkArrXY[ImageSel, M].x) and
                  (Ycent = MarkArrXY[ImageSel, M].y) then
                begin
                  If (MarkEvDur[ImageSel, M].R > CANNOT_BE_DONE) Then
                  Begin
                    PLOTvar.HasPeaks := True;
                    // tells Plotting Proc to draw Peaks
                    // PeakValArr, PeakTimArr & PeakPosArr are nilled in TimeSerAnal we don't neeed the for plotting //
                    // Plotting Proc uses PLOTvar.ImNrFromTable

                    SetLength(PeakBasArr, 1, 1);
                    PeakBasArr[0, 0] := MarkBase[ImageSel, M] * 10;

                    SetLength(PeakFakeImNrArr, 1);
                    SetLength(PeakFakeImNrArr[0], 1);

                    // Gets the Right Fake Image Number
                    for Cnt := ImageSel to NrIm - 1 do
                    begin
                      if TimeSt[Cnt] >= TimeSt[ImageSel] + MarkEvDur[ImageSel,
                        M].R then
                      begin
                        ImBelowPeak := Cnt;
                        ImAbovePeak := ImBelowPeak - 1;
                        // Go Backward by One Image
                        Break;
                      end;
                    end;

                    PeakFakeImNrArr[0, 0].Rim := ImAbovePeak +
                      ((MarkEvDur[ImageSel, M].R + TimeSt[ImageSel])
                        - TimeSt[ImAbovePeak]) /
                      (TimeSt[ImBelowPeak] - TimeSt[ImAbovePeak]);

                    // Gets the Left Fake Image Number
                    If (MarkEvDur[ImageSel, M].L > CANNOT_BE_DONE) then
                    begin

                      for Cnt := ImageSel downto 0 do
                      begin
                        if TimeSt[Cnt] <= TimeSt[ImageSel] - MarkEvDur
                          [ImageSel, M].L then
                        begin
                          ImBelowPeak := Cnt;
                          ImAbovePeak := ImBelowPeak + 1;
                          // Go Forward by One Image
                          Break;
                        end;
                      end;

                      PeakFakeImNrArr[0, 0].Lim := ImBelowPeak +
                        ((TimeSt[ImageSel] - MarkEvDur[ImageSel, M].L)
                          - TimeSt[ImBelowPeak]) /
                        (TimeSt[ImAbovePeak] - TimeSt[ImBelowPeak]);

                    End
                    Else
                      PeakFakeImNrArr[0, 0].Lim := CANNOT_BE_DONE;

                  End;
                End; // if (Xcent = MarkArrXY[ImageSel,M].X) and (Ycent = MarkArrXY[ImageSel,M].Y
              End; // If (Xcent = MarkArrXY[ImageSel,M].X) and (Ycent = MarkArrXY[ImageSel,M].Y)
            End; // If (RatioOn) and (High(MarkArrXY[ImageSel]) > -1)

            if Not(PLOTvar.HasPeaks) then
              PeakFakeImNrArr := nil; // has to be cleared

            Sender := StrGrid;
            /// / to tell StarAnal Proc not to kill Peak Arrays
            frmTimeSerPlot.dsAnalRange.SetSliderPos(BegOfAnal, EndOfAnal);
            frmTimeSerPlot.dsAnalRangeChange(Sender);
            frmTimeSerPlot.StartAnalClick(Sender);

          End; { If (SpTabEmpty = False) and (DoAnalSm = True) }

        End; // Procedure DoOneRowAnal - From Table
        { ***************************************************************************** }

        Procedure FillPraireNoranFileList(const FirstFile,
          LastFile: AnsiString; var ValidFile: Boolean);
        // Not in USE: Gets First and Last Tiff File
        var
          FPath: AnsiString;
          RootFileName, TemStr: AnsiString; // without extension
          FirstFileName, LastFileName: AnsiString;
          TempInt, Cnt, RootLen: Integer;
          FirstFileNumber, LastFileNumber: LongWord;
          FirstFileNrStr, LastFileNrStr: AnsiString;
          LogFile: TextFile;
          ReadDbl: Double;
          DummyArr: Array [0 .. 15] of AnsiChar; // Dynamic String Does Not Work-Reads the whole Row
          OpenLogFile: TOpenDialog;

        Begin
          FirstFileName := ExtractFileName(FirstFile);
          LastFileName := ExtractFileName(LastFile);

          If FirstFileName <> LastFileName Then
          Begin

            FPath := ExtractFilePath(FirstFile);

            if Length(FirstFileName) > Length(LastFileName) then
            begin // swap names
              TemStr := FirstFileName;
              FirstFileName := LastFileName;
              LastFileName := TemStr;
            end;

            For Cnt := Length(FirstFileName) - 4 downto 1 do
            begin
              if Not(FirstFileName[Cnt] in Digits) then
              begin
                RootLen := Cnt;
                Break;
              end;
            End;

            RootFileName := AnsiLeftStr(FirstFileName, RootLen);
            FirstFileNrStr := Copy(FirstFileName, RootLen + 1,
              Length(FirstFileName) - 4 - Length(RootFileName));
            LastFileNrStr := Copy(LastFileName, RootLen + 1,
              Length(LastFileName) - 4 - Length(RootFileName));

            FirstFileNumber := StrToInt(FirstFileNrStr);
            LastFileNumber := StrToInt(LastFileNrStr);

            if FirstFileNumber > LastFileNumber then
            begin // swap names
              TempInt := FirstFileNumber;
              FirstFileNumber := LastFileNumber;
              LastFileNumber := TempInt;
            end;

            If LastFileNumber - FirstFileNumber >= 9 Then
            Begin
              ValidFile := True;
              NrIm := LastFileNumber - FirstFileNumber + 1;

              SetLength(TiffFileList, NrIm);
              SetLength(TimeSt, NrIm);

              For Cnt := FirstFileNumber to LastFileNumber Do
              Begin
                TiffFileList[Cnt - FirstFileNumber] := FPath + RootFileName +
                  IntToStr(Cnt) + '.tif';

              End;

              OpenLogFile := TOpenDialog.Create(MainForm);
              OpenLogFile.InitialDir := MainForm.OpenFileDialog.InitialDir;
              OpenLogFile.Filter :=
                'Open User Log File (*Cycle1.pcf)|*Cycle1.pcf';
              OpenLogFile.Title := 'Open User Log File';
              OpenLogFile.FileName := '';

              If OpenLogFile.Execute then
              begin

                AssignFile(LogFile, OpenLogFile.FileName);
                FileMode := fmOpenRead;
                Reset(LogFile);
                for Cnt := 1 to 13 do
                  Readln(LogFile);

                // 14th line
                Read(LogFile, DummyArr); // Reads: "Frame time(ms)="
                Read(LogFile, ReadDbl); // reads Frame Rate in ms
                CloseFile(LogFile);

                TimeSt[0] := 0;
                for Cnt := 1 to High(TimeSt) do
                  TimeSt[Cnt] := (Cnt * ReadDbl) / 1000; // converts to seconds

              End;
              If OpenLogFile.FileName = '' then
              begin // Dialog was Cancelled
                ValidFile := False;
                MessageDlg('Action Failed: User Log File File was not Open',
                  mtError, [mbOK], 0);
              End;

              OpenLogFile.Free;
              OpenLogFile := nil;
            End
            Else If LastFileNumber - FirstFileNumber < 9 Then
            Begin
              ValidFile := False;
              MessageDlg('Action Failed: Open at Least 10 Files', mtError,
                [mbOK], 0);
            End;
          End
          Else
          Begin
            ValidFile := False;
            MessageDlg('Action Failed: Open More then One File', mtError,
              [mbOK], 0);
          End; // If FirstFileName <> LastFileName

        End;

        { ***************************************************************************** }
Procedure SetTIFfilesStack(Const NameOfFile: AnsiString; Const SilentMode: Boolean);
Const
          CorQED = 1; // corrects for QED Bug if Nr > 9999 then Adds the Number
          // and Always Leaves a dash, e.g. Name---1, Name-9999 and Name-10000

var
          RootFName: AnsiString;
          FilePath: AnsiString;
          TempStr: AnsiString;
          TifFNrStr: AnsiString;
          NrStr: AnsiString;
          SearchResult: TSearchRec;
          PosCnt, RootLen: Integer;
          CntIm: Integer;
          Cnt: Integer;
          FrameTime: Double;
          LeadingZeros: Boolean;
          TemDouble: Double;
          ImageTime: Double;
          LocalCheckAllFiles: Boolean; // used to control FileExists Fuction
          LastCheckFileNr: LongWord; // used to control FileExists Fuction
          NrPages: LongWord;
          pRead: Pointer;
          AndorFile: THandle;
          ValidFile: Boolean ;

        Begin

          GetTIFFfileInfo(NrPages, NameOfFile, 0, READ_AS_STACK,0, SilentMode);

            FilePath := ExtractFilePath(NameOfFile);
            RootFName := ExtractFileName(NameOfFile);

            ValidFile := True;
            // find the real Root File Name - without numbers

            For PosCnt := Length(RootFName) - 4 downto 1 do
            begin
              if Not(RootFName[PosCnt] in Digits) then
              begin
                RootLen := PosCnt;
                Break;
              end;
            End;

            // gets Image Number of First File Found
            TifFNrStr := Copy(RootFName, RootLen + 1,
              Length(RootFName) - RootLen - 4);

            If TifFNrStr = '' Then
            Begin // if No Digits at the End then we have Empty String
              ValidFile := False;
              MessageDlg(
                'The File you Selected is not a Part of Stack of Tiff Images',
                mtError, [mbOK], 0);
            End

              Else

            If (TifFNrStr <> '') Then Begin // Has Numbers at the end
              LastCheckFileNr := StrToInt(TifFNrStr);

              // finds if there are leading Zeroes in Tif File Number
              if (Length(TifFNrStr) > Length(IntToStr(LastCheckFileNr))) or
                (TIFFfileType = TIFF_QED) then
              begin
                LeadingZeros := True; // has leading zeroes or dashes in QED
                RootFName := Copy(NameOfFile, 1, Length(NameOfFile) - 4);
              end
              else if (Length(TifFNrStr) = Length(IntToStr(LastCheckFileNr)))
                and (TIFFfileType <> TIFF_QED) then
              begin
                LeadingZeros := False;
                // Gets Root of Image File Name
                RootFName := AnsiLeftStr(RootFName, RootLen);
                // adds the full path
                RootFName := FilePath + RootFName;
              end;

              ValidFile := True;

              SetLength(TiffFileList, 1);

              CntIm := LastCheckFileNr - 1; // Gets the Image Numge as in File
              Cnt := -1; // Counter
              LocalCheckAllFiles := CheckAllFilesExist;
              LastCheckFileNr := CntIm + 1;
              While ValidFile Do Begin
                Inc(CntIm); // now it starts from FirstImageNr
                NrStr := IntToStr(CntIm); // creates Number String
                // Constructs File Name
                if LeadingZeros then
                begin
                  if (TIFFfileType = TIFF_QED) and (CntIm > 9999) then
                    TempStr := StuffString(RootFName,
                      Length(RootFName) - (Length(NrStr) - 1) + CorQED,
                      Length(NrStr), NrStr) + '.tif'
                  else
                    TempStr := StuffString(RootFName,
                      Length(RootFName) - (Length(NrStr) - 1), Length(NrStr),
                      NrStr) + '.tif';
                end
                else if Not(LeadingZeros) then
                  TempStr := RootFName + NrStr + '.tif';

                // Increments but Does not Verify - Speeds Loading ~3.4 fold !!!
                If (Not(LocalCheckAllFiles)) and (CntIm mod 10 <> 0) then
                Begin
                  Inc(Cnt);
                  TiffFileList[Cnt] := TempStr;
                  SetLength(TiffFileList, Length(TiffFileList) + 1);
                End
                Else
                // Verifies if File Exists  and Increments
                  If (LocalCheckAllFiles) or (CntIm mod 10 = 0) then
                Begin
                  if FileExists(TempStr) then
                  begin
                    Inc(Cnt);
                    if Not(LocalCheckAllFiles) then
                      LastCheckFileNr := CntIm;
                    TiffFileList[Cnt] := TempStr;
                    SetLength(TiffFileList, Length(TiffFileList) + 1);
                  end
                  else
                  begin
                    if LocalCheckAllFiles then
                    begin
                      NrIm := Cnt + 1;
                      SetLength(TiffFileList, NrIm);
                      if Not((TIFFfileType = TIFF_ANDOR_iQ) and (DimTime = -1))
                        then
                        SetLength(TimeSt, NrIm);
                      if (TIFFfileType = TIFF_ANDOR_iQ) and (DimNotTime > -1) then
                        SetLength(ZstackArr, NrIm);
                      Break;
                    end
                    else if Not(LocalCheckAllFiles) then
                    begin
                      Dec(Cnt, (CntIm - LastCheckFileNr) - 1);
                      CntIm := LastCheckFileNr;
                      LocalCheckAllFiles := True;
                    end;
                  end; // else begin
                End; // If (LocalCheckAllFiles) or (CntIm mod 10 = 0)

              End; // While ValidFile

              If (TIFFfileType = TIFF_ANDOR_iQ) Then Begin
                if (DimTime > -1) then
                  for Cnt := 0 to High(TimeSt) do
                    TimeSt[Cnt] := -1;
                if (DimNotTime > -1) then
                  for Cnt := 0 to High(ZstackArr) do ZstackArr[Cnt] := -1;

                // Gets TimeSt Value or Other of Last Image

                CntIm := High(TiffFileList);
                AndorFile := FileOpen(TiffFileList[CntIm],
                  fmOpenRead or fmShareDenyNone);
                FileSeek(AndorFile, AndorDimValOffs, 0);
                pRead := @DArray[0];
                FileRead(AndorFile, pRead^, Length(DArray) shl 3);

                { First Do the Time }
                If (DimTime > -1) Then
                Begin
                  TimeSt[CntIm] := DArray[DimTime];
                  if (Andor_DIM_INFO[DimTime].Resolution <> 1) then
                    TimeSt[CntIm] := TimeSt[CntIm] * Andor_DIM_INFO[DimTime]
                      .Resolution;
                  if (Andor_DIM_INFO[DimTime].Origin <> 0) then
                    TimeSt[CntIm] := TimeSt[CntIm] + Andor_DIM_INFO[DimTime]
                      .Origin;
                  // always subtract the 1st image time
                  TimeSt[CntIm] := TimeSt[CntIm] - FirstAndorTime;

                  if Andor_DIM_INFO[DimTime].Units = 'ms' then
                    TimeSt[CntIm] := TimeSt[CntIm] / 1000
                  else if Andor_DIM_INFO[DimTime].Units = 'µs' then
                    TimeSt[CntIm] := TimeSt[CntIm] / 1000000;
                End; // If (DimTime > 0

                { Next Do the Other Dimension, if Any }
                If (DimNotTime > -1) Then Begin
                  ZstackArr[CntIm] := DArray[DimNotTime];
                  if (Andor_DIM_INFO[DimNotTime].Resolution <> 1) then
                    ZstackArr[CntIm] := ZstackArr[CntIm]
                      * Andor_DIM_INFO[DimNotTime].Resolution;
                  if (Andor_DIM_INFO[DimNotTime].Origin <> 0) then
                    ZstackArr[CntIm] := ZstackArr[CntIm]
                      + Andor_DIM_INFO[DimNotTime].Origin;
                End; // If (DimNotTime > 0
                FileClose(AndorFile);
              End

                Else

              If (TIFFfileType <> TIFF_ANDOR_iQ) Then Begin
                TemDouble := 0;
                ImageTime := 1 / PixSettings.FramesPerSec[0]; // [0] for Stack
                for Cnt := 0 to High(TimeSt) do begin
                  TimeSt[Cnt] := TemDouble;
                  TemDouble := TemDouble + ImageTime;
                end;
              End;


          End;  //  If (GrayScaleTIFF)

        End; // Procedure SetTIFfilesStack

{ ***************************************************************************** }

Procedure FillMovieFrRateListAndCalcMeanImTime;
var
  Cnt: Integer;
Begin

          If ( High(MovieCycleList) > -1) then
          begin

            SetLength(MovieFrRateList, Length(MovieCycleList));

            MeanImTime := 0;
            for Cnt := 0 to High(MovieCycleList) do
            begin
              if Cnt = 0 then
              begin
                MeanImTime := MeanImTime + TimeSt[MovieCycleList[Cnt] - 1] /
                  (MovieCycleList[Cnt] - 1); // used for Drawing Traces etc
                MovieFrRateList[Cnt] := (MovieCycleList[Cnt] - 1)
                  / TimeSt[MovieCycleList[Cnt] - 1];
              end
              else if Cnt > 0 then
              begin
                MeanImTime := MeanImTime +
                  (TimeSt[MovieCycleList[Cnt] - 1] - TimeSt
                    [MovieCycleList[Cnt - 1]]) /
                  ((MovieCycleList[Cnt] - 1) - (MovieCycleList[Cnt - 1]));
                MovieFrRateList[Cnt] := ((MovieCycleList[Cnt] - 1) -
                    (MovieCycleList[Cnt - 1])) /
                  (TimeSt[MovieCycleList[Cnt] - 1] - TimeSt
                    [MovieCycleList[Cnt - 1]]);
              end;
            end;
            MeanImTime := MeanImTime / Length(MovieCycleList);
            // thats the Average Frame Rate (pauses extracted)
            ExportDial.OrigFrameRate := 1 / MeanImTime;
          End
          Else
          begin
            MovieFrRateList := nil;
            MeanImTime := TimeSt[ High(TimeSt)] / (NrIm - 1);
            // used for Drawing Traces etc
            ExportDial.OrigFrameRate := (NrIm - 1) / TimeSt[ High(TimeSt)];
          End;

 End; // Procedure FillMovieFrRateListAndCalcMeanImTime;

{ ***************************************************************************** }
Procedure CreateOneBinImHist;
var Cnt, MaxHistVal: Integer;
    pW : TDynWordArray;
    pB : TDynByteArray;

Begin

  { Length(OneBinImHist) = Bit-Dept}
 If (ChannelOrder = ASCENDING) then Begin
  if (BitCount = 16) then begin
    if (CurrClrTablInd = 2)
     then
    pW := Im2nd16bit
     else
    pW := Im16bitData;
  end
    else
  if (BitCount = 8) then begin
    if (CurrClrTablInd = 2)
    then
    pB := Im2nd8bit
      else
    pB := Im8bitData;
  end;
 End
  Else
 If (ChannelOrder = DESCENDING) then Begin
  if (BitCount = 16) then begin
    if (CurrClrTablInd = 2)
     then
    pW := Im16bitData
     else
    pW := Im2nd16bit;
  end
    else
  if (BitCount = 8) then begin
    if (CurrClrTablInd = 2)
    then
    pB := Im8bitData
      else
    pB := Im2nd8bit;
  end;
 End;

  { Zero Array }
  for Cnt := 0 to High(OneBinImHist) do OneBinImHist[Cnt] := 0;
  { Construct One bin pel level Histogram }

  if (BitCount = 16) then
    for Cnt := 0 to High(pW) do Inc(OneBinImHist[pW[Cnt]])
    else
  if BitCount = 8 then
    for Cnt := 0 to High(pB) do Inc(OneBinImHist[pB[Cnt]]);

  { gets  maximum }
  MaxHistVal := 0;
  for Cnt := 0 to High(OneBinImHist) do begin
    if MaxHistVal < OneBinImHist[Cnt] then MaxHistVal := OneBinImHist[Cnt]; // max = 1705
  end;

    { normalizes Values to Maximum = 60; Plot Window Y = 64 pixels }
  ScaleImHistFact := MaxHistVal / 60;

End;  //Procedure GetImageHist;

        { ***************************************************************************** }
Procedure SetBkgAndCutOffSliders;
var
          BitDepthOfImage         : Byte;
          OnChangeMemBackSubtr    : TNotifyEvent;
          OnChangeMemBack2ndSubtr : TNotifyEvent;
          OnChangeMemCutOff       : TNotifyEvent;
                        BkgMax    : Integer;
          Sender : TObject;

Begin

          if BitCount = 8 then
            BitDepthOfImage := 8
              else
            BitDepthOfImage := shrFact + 8;

          With frmImageControl Do Begin

            OnChangeMemBackSubtr := trbBackSubtr.OnChange;
            trbBackSubtr.OnChange := nil;
            trbBackSubtr.Position := 0;

            OnChangeMemBack2ndSubtr := trbBack2ndWinSubtr.OnChange;
            trbBack2ndWinSubtr.OnChange := nil;
            trbBack2ndWinSubtr.Position := 0;

            OnChangeMemCutOff := trbCutOff.OnChange;
            trbCutOff.OnChange := nil;
            trbCutOff.Position := 0;
            CutOff := 0;

            if (BitDepthOfImage = 8)  then BkgMax :=   254 else
            if (BitDepthOfImage = 9)  then BkgMax :=   510 else
            if (BitDepthOfImage = 10) then BkgMax :=  1022 else
            if (BitDepthOfImage = 11) then BkgMax :=  2046 else
            if (BitDepthOfImage = 12) then BkgMax :=  4094 else
            if (BitDepthOfImage = 13) then BkgMax :=  8190 else
            if (BitDepthOfImage = 14) then BkgMax := 16382 else
            if (BitDepthOfImage = 15) then BkgMax := 32766 else
            if (BitDepthOfImage = 16) then BkgMax := 65534;

            MaxPixVal := BkgMax + 1;

            if enBackSubtrMainWindow.Max <> BkgMax then begin
              enBackSubtrMainWindow.NumberOne := 0;
              enBackSubtrMainWindow.Max := BkgMax;
            end;

            if (enBackSubtr2ndWindow.Max <> BkgMax) then begin
              enBackSubtr2ndWindow.NumberOne := 0;
              enBackSubtr2ndWindow.Max := BkgMax;
            end;


            enBackSubtrMainWindow.NumberOne := BkgValues[MovFType];
            enBackSubtr2ndWindow .NumberOne := Bkg2ndValues[MovFType];
            Bkg    := BkgValues   [MovFType];
            Bkg2nd := Bkg2ndValues[MovFType];

            enBackSubtrMainWindowReturnPressed(Sender);
            enBackSubtr2ndWindowReturnPressed(Sender);



            enCutOff.NumberOne   := 0;
            enCutOff.Max         := BkgMax - 1;
             trbCutOff.Max       := 50; //initial value

            trbBackSubtr.OnChange := OnChangeMemBackSubtr;
            trbBack2ndWinSubtr.OnChange := OnChangeMemBack2ndSubtr;

            trbCutOff.OnChange    := OnChangeMemCutOff;

          End; // With

End;     //Procedure SetBkgCutOffSliders;

{ ***************************************************************************** }
procedure SetFormSize(Const AnyForm: TForm; Const AnyImage: TImage);
var
  ActImXsize, ActImYsize, ClWidth, ClHeight, LessPix_X,LessPix_Y : Integer;
  ClWidthDecreased,ClHeighDecreased : Boolean;
Begin

          // 1st determines Image Size
          If (Zoom > 0) Then Begin
           if not(frmPlayback.Magnify4x.Down) then begin
            ActImXsize := imXsize*Zoom;
            ActImYsize := imYsize*Zoom;
           end
            else
            if frmPlayback.Magnify4x.Down = True  then begin
              ActImXsize := imXsize*4;
              ActImYsize := imYsize*4;
            end;
          End
            else
          If (Zoom = -2) then Begin
            ActImXsize := imXsize div 2;
            ActImYsize := imYsize div 2;
          End;

          // 2nd determines Forms Window Size
          If (Zoom in [2,4]) and (frmPlayback.FullScr.Down = False) then
          Begin
            ClWidth  := imXsize * Zoom;
            ClHeight := imYsize * Zoom;
          End
            Else
          If ((Zoom in [2,4]) and (frmPlayback.FullScr.Down = True)) or
            (Zoom = 1) Then
          Begin
            ClWidth  := imXsize;
            ClHeight := imYsize;
          End
            Else
          If (Zoom = -2) then Begin
            ClWidth  := imXsize div 2;
            ClHeight := imYsize div 2;
          End;

          // Check if the Form Fits within Screen

          ClWidthDecreased := False;
          ClHeighDecreased := False;

          LessPix_X := Screen.Width  div 4; //used to be 3
          LessPix_Y := Screen.Height div 4; //used to be 3

          if (ClWidth  > Screen.Width  - LessPix_X) then begin
            ClWidth  := Screen.Width  - LessPix_X;
            ClWidthDecreased := True;
          end;
          if (ClHeight > Screen.Height - LessPix_Y) then begin
            ClHeight := Screen.Height - LessPix_Y;
            ClHeighDecreased := True;
          end;

          if not(ClWidthDecreased) and (ClHeighDecreased) and (ActImXsize <> ActImYsize) then
            ClWidth := ClWidth + GetSystemMetrics(SM_CYHSCROLL) div 2;

          if not(ClHeighDecreased) and (ClWidthDecreased) and (ActImXsize <> ActImYsize) then
            ClHeight := ClHeight + GetSystemMetrics(SM_CYHSCROLL) div 2;

          if (ActImXsize = ActImYsize) then ClWidth := ClHeight;

          If (AnyForm = frmMainWin) Then
          Begin
            frmPlayback.Xoffset := (frmPlayback.ClientWidth - ClWidth) div 2;
            frmPlayback.CenterOffs := frmPlayback.Xoffset;
          End;

          with AnyForm do begin
            Constraints.MinHeight := 0;
            Constraints.MaxHeight := 0;
            Constraints.MaxWidth := 0;
            Constraints.MinWidth := 0;
            if (ClWidth = ActImXsize) and (ClHeight = ActImYsize) then begin
              HorzScrollBar.Visible := False;  //needed
              VertScrollBar.Visible := False;  //needed
              // ClientWidth & ClientHeight should be set after ScrollBars
              ClientWidth  := ClWidth; // ClientWidth is Always smaller then Width, same is with Heigth
              ClientHeight := ClHeight;
              Constraints.MaxWidth := Width;
              Constraints.MinWidth := Width;
              Constraints.MinHeight := Height;
              Constraints.MaxHeight := Height;
            end
              else
            begin
              HorzScrollBar.Visible := True;
              VertScrollBar.Visible := True;
              // ClientWidth & ClientHeight should be set after ScrollBars
              ClientWidth  := ClWidth; // ClientWidth is Always smaller then Width, same is with Heigth
              ClientHeight := ClHeight;

              Constraints.MinWidth := 256;
              Constraints.MaxWidth := ActImXsize + round(1.5*GetSystemMetrics(SM_CYHSCROLL)) +
              2 * GetSystemMetrics(SM_CYFIXEDFRAME) + 2 * GetSystemMetrics(SM_CYBORDER);

              Constraints.MinHeight := 256;
              Constraints.MaxHeight := ActImYsize + round(1.5*GetSystemMetrics(SM_CYVSCROLL)) +
              2 * GetSystemMetrics(SM_CYFIXEDFRAME) + 2 * GetSystemMetrics(SM_CYBORDER);

            end;

          end;

          // 2nd sets Image Size
          AnyImage.SetBounds(0,0,ActImXsize,ActImYsize);
          AnyImage.Picture.Bitmap.SetSize(ActImXsize,ActImYsize);
          AnyImage.Canvas.Brush.Style := bsClear;
          Application.ProcessMessages; { do not remove }

          // Displays Images and Puts ROI & Marks
          If (AnyForm = frmMainWin) and (MainImLoaded) then Begin
            UpdateMainImage(True);
          End;

          If (NrChannels > 1) and (MainImLoaded) then begin
            if (AnyForm = frm2ndWin) then Display2ndChannel;
            if (AnyForm = frmMergeWin) then DisplayMergeImage;
          End;

          If (AnyForm = frmAverIm) then Begin
            if (AvImExists > 0) then begin
              UpdateAverImage(True);
            end
              else { if  AvImExists > 0 }
            if (AvImExists = 0) then Begin
              with frmAverIm.winAverImage do begin
                Canvas.Brush.Color := clBlack;
                Canvas.FillRect(Canvas.ClipRect);
                frmAverIm.Caption := 'No Average';
              end;
            end;

          End; { If AnyForm = frmAverIm then Begin }

End; // Procedure SetFormSize
{ ****************************************************************************** }

Procedure UpdatePixelSizeSettings;
Begin

  { 1st: pixel Size }
  If (PixSettings.FileHasOwnPixSize = True) then begin
    if not(PixSettings.UseOptionPixSize[MovFType]) then
      PixSize := PixSettings.FilePixSize
      else
    if (PixSettings.UseOptionPixSize[MovFType]) then begin
      if (MovFType = ANDOR_MOV) then
        PixSize := (100 * PixSettings.ImageBinning)/ PixSettings.PixPer100Micr[ANDOR_MOV]
          else
      if (MovFType in[NIKON_ND2_MOV,NIKON_TIFF_MOV]) then
        PixSize := (100 * PixSettings.ImageBinning)/ PixSettings.PixPer100Micr[NIKON_ND2_MOV]
      else
        PixSize := 100 / (PixSettings.PixPer100Micr[MovFType]);
    end;
  End
    Else
  If (PixSettings.FileHasOwnPixSize = False) then Begin // forces to use Option Settings
    PixSettings.UseOptionPixSize[MovFType] := True;
    PixSize := 100 / (PixSettings.PixPer100Micr[MovFType]);
  End;

End; //Procedure UpdatePixelSizeSettings;

{ ***************************************************************************** }

Procedure PutBoxesOnMarks(Const StrGrid: TStringGrid;
          Var MarkSelArr: Array of Word; Const NrOfSelMarks: Word);
        { NrOfSelMarks = Nr of Rows }

Var  i, R, Xcent, Ycent: Integer;

Begin

          i := 0;
          For R := 1 to StrGrid.RowCount Do Begin
            { Creates And Positions a Box on Address 20 }
           If MarkSelArr[R - 1] > 0 Then Begin
              MarkSelArr[R - 1] := i + 1;
              Inc(i);
              Xcent := StrToInt(StrGrid.Cells[2, R]);
              Ycent := StrToInt(StrGrid.Cells[3, R]);

              XL  := Xcent - ROIvar.BoxXsize shr 1;
              XR  := Xcent + ROIvar.BoxXsize shr 1 - (1 - ROIvar.BoxXsize mod 2);
              Yup := Ycent - ROIvar.BoxYsize shr 1;
              Yd  := Ycent + ROIvar.BoxYsize shr 1 - (1 - ROIvar.BoxYsize mod 2);

              KeepROIinWindow;

              ROIvar.ROICoor[1, i] := XL;
              ROIvar.ROICoor[2, i] := Yup;
              ROIvar.ROICoor[3, i] := XR;
              ROIvar.ROICoor[4, i] := Yd;
              ROIvar.ROIAdr[i] := 1; { 1 is the code for box }
           End; { If MarkSelArr[i-1] = 1 }
            If i = NrOfSelMarks then
              Break;
          End;
          ROIvar.NrROI := NrOfSelMarks;

 End;

        { ***************************************************************************** }
Function CreateMarkComment(const GenGenSetComm,GenAutoSearchComm : Boolean) : AnsiString;

        Var
          First              : Boolean;
          GeneralSettings    : AnsiString;
          AutoSearchSettings : AnsiString;
          TemStr             : AnsiString;
          fIm, Lim, n        : Integer; { first and last image searched }
          { Defines Custom Comment }

  Begin

    { 1st General Settings }
    If (GenGenSetComm) Then Begin
      GeneralSettings := 'Measured with: RectXY=' + IntToStr(ROIvar.BoxXsize)
                          + 'x' + IntToStr(ROIvar.BoxYsize);

      if (TimPltSlid.TimeSerAnalMode = INTENSITY) then
        GeneralSettings := GeneralSettings + ', Area'
         else
      if (TimPltSlid.TimeSerAnalMode = F_div_Fo) then
        GeneralSettings := GeneralSettings + ', F/Fo'
        else
      if (TimPltSlid.TimeSerAnalMode = Ch_div_Ch) then begin
        if (ChannelOrder = ASCENDING)  then
        GeneralSettings := GeneralSettings + 'Ch1/Ch2'
          else
        if (ChannelOrder = DESCENDING) then
        GeneralSettings := GeneralSettings + 'Ch2/Ch1';
      end;
    
      if (RatioOn) then begin
        if (AvImExists = 1) then GeneralSettings := GeneralSettings + ', On Line Average'
          else
        if (AvImExists = 3) then GeneralSettings := GeneralSettings + ', Generated Average'
          else
        if (AvImExists = 2) then GeneralSettings := GeneralSettings +
                                ', Average from File="' + ExtractFileName(AvImFPath) + '"'; ;
      end;

      Result := GeneralSettings;
    End; { If MarkPar.GenGenSetComm Then Begin }


    { 2nd AutoSerach Settings }
    If (GenAutoSearchComm) Then Begin
      if (frmSPautoSearch = nil) then begin
        fIm := 1;
        Lim := NrIm;
      end
      else if (frmSPautoSearch <> nil) then begin
        fIm := frmSPautoSearch.dsSerchFromTo.PosFrom + 1;
        Lim := frmSPautoSearch.dsSerchFromTo.PosTo + 1;
      end;
      AutoSearchSettings := ' | Auto Search Settings: ' +
 'Images Searched ' + IntToStr(fIm) + '-' +  IntToStr(Lim) +
', Thresh = ' + FloatToStrF(AutoSearchPar.Thresh/100,ffFixed,3,2) + ', Tolerance = ' +
IntToStr(100-AutoSearchPar.Tolerance) + '%' + ', ScanBox = ' +
IntToStr(AutoSearchPar.ScanBoxSize) + ', Max Area (pix) = ' + IntToStr(AutoSearchPar.MaxArea) +
', Background = ' + IntToStr(Bkg) + ', Cutoff = ' + IntToStr(Cutoff);

if (SmoothMode = SMOOTH_BOX_MED) then
  TemStr := ', 2D Boxcar Filt = ' + IntToStr(BoxSmSize) + ' -> 2D Median Filt = ' + IntToStr(MedSmSize)
  else
if (SmoothMode = SMOOTH_MED_BOX) then
  TemStr := ', 2D Median Filt = ' + IntToStr(MedSmSize) + ' -> 2D Boxcar Filt = ' + IntToStr(BoxSmSize)
  else
If (SmoothMode in [SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
  if (GaussSmSize = GAUSS_3x3_LITE)   then TemStr := '2D Gaussian Filt = 3L' else
  if (GaussSmSize = GAUSS_3x3_MEDIUM) then TemStr := '2D Gaussian Filt = 3M' else
  if (GaussSmSize = GAUSS_3x3_HEAVY)  then TemStr := '2D Gaussian Filt = 3H' else
  if (GaussSmSize = GAUSS_5x5)        then TemStr := '2D Gaussian Filt = 5' else
  if (GaussSmSize = GAUSS_7x7)        then TemStr := '2D Gaussian Filt = 5';

  if (SmoothMode = SMOOTH_GAUSS_MED) then TemStr := ', ' + TemStr + ' -> 2D Median Filt = ' + IntToStr(MedSmSize) else
  if (SmoothMode = SMOOTH_MED_GAUSS) then TemStr := ', 2D Median Filt = ' + IntToStr(MedSmSize) + ' -> ' + TemStr;
end;
  AutoSearchSettings := AutoSearchSettings + TemStr;

  if    (AutoSearchPar.SmoothBeforeDoRatio) then TemStr := ', Smooth Before F/Fo' else
  if not(AutoSearchPar.SmoothBeforeDoRatio) then TemStr := ', Smooth After F/Fo';
  AutoSearchSettings := AutoSearchSettings + TemStr;

if (frmImageControl.ubApplyFrame.Selected) then begin
  TemStr := ', Sel Frame (L,R,T,B) = ' +
    IntToStr(SelFrame.Left) + ',' +
    IntToStr(SelFrame.Right)  + ',' +
    IntToStr(SelFrame.Top)   + ',' +
    IntToStr(SelFrame.Bottom);
end else
TemStr := ', No Sel Frame';
AutoSearchSettings := AutoSearchSettings + TemStr;


if (AutoSearchPar.UseRunAver) then TemStr := ', Run Aver=' + IntToStr(AutoSearchPar.NrImRunAver) else
if not(AutoSearchPar.UseRunAver)then TemStr := ', No Run Aver';
AutoSearchSettings := AutoSearchSettings + TemStr;

if (AutoSearchPar.IgnoreBigEv) then TemStr := ', Ignore Big Events' else TemStr := ', Do Not Ignore Big Events';
AutoSearchSettings := AutoSearchSettings + TemStr;

if (AutoSearchPar.TestSmallEv) then with AutoSearchPar do begin
  TemStr := ', Small Ev Test';
  if (GetSmEvDur) then
    TemStr := TemStr + ' (Get Time Params) settings: ' else TemStr := TemStr + ' (No Time Params) settings: ';

    TemStr := TemStr + ' Search Left '  + IntToStr(NrImGetMinLeft)  + ' im within ' +  IntToStr(SearchLms) + ' ms';
    TemStr := TemStr + ' Search Right ' + IntToStr(NrImGetMinRight) + ' im within ' +  IntToStr(SearchRms) + ' ms';

    TemStr := TemStr + ', Nr Points Left'  + IntToStr(NrImToLeftOfEv)  + ' im > ' + IntToStr(PLval) + ' %';
    TemStr := TemStr + ', Nr Points Right' + IntToStr(NrImToRightOfEv) + ' im > ' + IntToStr(PRval) + ' %';

  if (SDuse) then TemStr := TemStr + ', Peak > ' + IntToStr(SDfold) + ' x SD of Baseline' else TemStr := TemStr + ', Do Not Use SD of Baseline';



  if (UseCustomROIforSmEvTest) then
      TemStr := TemStr + ', Used ROI = ' + IntToStr(ROISizeForSmEvTest) + 'x'+ IntToStr(ROISizeForSmEvTest) else
      TemStr := TemStr + ', Used ROI = Scan Box';

  if (UpdateRatio) then TemStr := TemStr + ', Update F/Fo' else TemStr := TemStr + ', F/Fo was Not Updated';

end else
TemStr := ', No Small Ev Test';
AutoSearchSettings := AutoSearchSettings + TemStr;

if (AvImExists = AVER_ON_LINE) then begin
  TemStr := ', On Line Average from images: ';
  First := True;
  for n := 0 to NrIm - 1 do begin
    if AvImList[n] > 0 Then begin
      if (First) then begin
        TemStr := TemStr + IntToStr(n);
        First := False;
      end else
        TemStr := TemStr + ',' + IntToStr(n);
    end;
  end;
end else
if (AvImExists = AVER_FROM_FILE) then begin
  TemStr := ', Average from File "' + ExtractFileName(AvImFPath)+ '"';
end else
if (AutoSearchPar.AutoAverImage) Then Begin
  TemStr := ', Auto Gen Average: Range/Min Of = ' +
    IntToStr(AutoSearchPar.AutoAverImRange)+ '/' +
    IntToStr(AutoSearchPar.NrImForCreateAvIm) + ' im ' +
    ' every ' + IntToStr(AutoSearchPar.AutoAverNrImInc) + ' im';
  if (AutoSearchPar.StartAutoAverFirstIm) then
    TemStr := TemStr + ', Start 1st im' else TemStr := TemStr + ', No Start 1st im';
  if (AutoSearchPar.SaveAutoAver) then
    TemStr := TemStr + ', Save to Files' else TemStr := TemStr + ', No Save to Files';
end;
AutoSearchSettings := AutoSearchSettings + TemStr;

Result := Result + AutoSearchSettings;

 End; { If MarkPar.GenAutoSearchComm Then Begin }



End; { Function CreateMarkComment : AnsiString; }
{ ***************************************************************************** }

        Procedure FinishFhROI(Const x, y: Integer; Var CntFh: Integer);

        var
          Cnt, IncY, i, NrmisY, CntX, CntY: Integer;
          MinY, MaxY, MinX, MaxX: Integer;
          Xmem, Ymem: Integer;
          Ynew: Boolean;
          TpTem: array of TPoint;
          AdrArr: array of array of Integer;

        Begin

          // -----------------Part 1: Connects the Ends with Interpolation ----------------//
          If Fh[0].y <> y then
          begin
            If abs(y - Fh[0].y) > 1 then
            begin
              if Fh[0].y > y then
                IncY := 1
              else
                IncY := -1;
              For i := 1 to (abs(y - Fh[0].y) - 1) do
              begin
                Inc(Pr.y, IncY);
                Inc(CntFh);
                Fh[CntFh].x := Pr.x + round
                  (i * ((Fh[0].x - x) / (abs(y - Fh[0].y))));
                Fh[CntFh].y := Pr.y;
              End; // For i := 1 to (abs(Y - Fh[0].Y)- 1 )
            End; // If abs(Y - Fh[0].Y) > 1
            Inc(CntFh);
            Fh[CntFh].x := x;
            Fh[CntFh].y := y;
          End;
          SetLength(Fh, (CntFh + 1)); // Truncates Unused Part//

          // if Zoom shrinks array//
          If Zoom = 2 Then
          Begin
            CntFh := 1;
            SetLength(TpTem, Length(Fh));
            For Cnt := 0 to High(Fh) Do
            Begin
              Fh[Cnt].x := Fh[Cnt].x shr Zm;
              Fh[Cnt].y := Fh[Cnt].y shr Zm;
              if (Cnt > 0) then
              begin
                if Fh[Cnt - 1].y <> Fh[Cnt].y then
                begin
                  // do not compare .X does not work well-this is enough//
                  TpTem[CntFh] := Fh[Cnt];
                  Inc(CntFh);
                end;
              end
              else if (Cnt = 0) then
                TpTem[0] := Fh[0];
            End; // for
            SetLength(TpTem, CntFh);
            SetLength(Fh, CntFh);
            for Cnt := 0 to High(Fh) do
              Fh[Cnt] := TpTem[Cnt];
          End
          Else // If Zoom = 2//
            If Zoom = -2 Then
          Begin
            CntFh := 1;
            SetLength(TpTem, Length(Fh));
            For Cnt := 0 to High(Fh) Do
            Begin
              Fh[Cnt].x := Fh[Cnt].x shl Zm;
              Fh[Cnt].y := Fh[Cnt].y shl Zm;
              if (Cnt > 0) then
              begin
                if Fh[Cnt - 1].y <> Fh[Cnt].y then
                begin
                  // do not compare .X does not work well-this is enough//
                  TpTem[CntFh] := Fh[Cnt];
                  Inc(CntFh);
                end;
              end
              else if (Cnt = 0) then
                TpTem[0] := Fh[0];
            End; // for
            SetLength(TpTem, CntFh);
            SetLength(Fh, CntFh);
            for Cnt := 0 to High(Fh) do
              Fh[Cnt] := TpTem[Cnt];
          End; // If Zm = -2

          // -----------------End part 1 ------------------------------------------//
          // -------------Part 2: Check for the Number of Missing Y's -------//
          NrmisY := 0;
          For Cnt := 1 to High(Fh) Do
          Begin // 1st checks for missing Y's//
            if abs(Fh[Cnt].y - Fh[Cnt - 1].y) > 1 then
              Inc(NrmisY, abs(Fh[Cnt].y - Fh[Cnt - 1].y) - 1);

          End; // For CntFh := to High(Fh)
          // ------------ End of Part 2:  Check for the Number of Missing Y's  ----------------------//
          // ------------Part 3: Fills missng Y's into FhFin array ------------------//

          SetLength(FhPol[CurROIadr], High(Fh) + 1 + NrmisY);
          FhPol[CurROIadr, 0] := Fh[0];
          CntFh := 0;

          For CntX := 1 to High(Fh) Do
          Begin // 1st checks for missing Y's//

            if abs(Fh[CntX].y - FhPol[CurROIadr, CntX - 1 + CntFh].y) <= 1 then
              FhPol[CurROIadr, CntX + CntFh] := Fh[CntX]
            else

              If abs(Fh[CntX].y - FhPol[CurROIadr, CntX - 1 + CntFh].y) > 1 then
            Begin

              if FhPol[CurROIadr, CntX - 1 + CntFh].y < Fh[CntX].y then
                IncY := 1
              else
                IncY := -1;
              CntY := CntFh;
              For i := 1 to abs(Fh[CntX].y - FhPol[CurROIadr,
                CntX - 1 + CntY].y) - 1 do
              Begin
                FhPol[CurROIadr, CntX + CntFh].x := FhPol[CurROIadr,
                  CntX - 1 + CntY].x + round
                  (i * ((Fh[CntX].x - FhPol[CurROIadr,
                      CntX - 1 + CntY].x) / (abs(Fh[CntX].y - FhPol[CurROIadr,
                        CntX - 1 + CntY].y))));
                FhPol[CurROIadr, CntX + CntFh].y := i * IncY + FhPol[CurROIadr,
                  CntX - 1 + CntY].y;
                Inc(CntFh);
              End; // For i := 1 to (abs(Fh[CntFh].Y - FhFin[CntX-1+CntFh].Y) - 1 )
              FhPol[CurROIadr, CntX + CntFh] := Fh[CntX];
              // Puts the Last, real one; //

            End; // If abs(Fh[CntX].Y - FhFin[CntX-1+CntFh].Y)  > 1
          End; // For CntFh := to High(Fh)

          // ------------End of Part3: Fills missng Y's into FhFin array--------------//

          // ---------Part 4: Sorting Begins ----------------  (CntFh = Lenght(Fh));

          SetLength(AdrArr, imXsize, imYsize);
          For CntY := 0 to imYsize - 1 Do
            For CntX := 0 to imXsize - 1 Do
              AdrArr[CntX, CntY] := -1;
          MinX := imXsize;
          MaxX := 0;
          MinY := imYsize;
          MaxY := 0;

          For i := 0 to High(FhPol[CurROIadr]) Do
          begin
            AdrArr[FhPol[CurROIadr, i].x, FhPol[CurROIadr, i].y] := i;
            if MinX > FhPol[CurROIadr, i].x then
              MinX := FhPol[CurROIadr, i].x;
            if MaxX < FhPol[CurROIadr, i].x then
              MaxX := FhPol[CurROIadr, i].x;
            if MinY > FhPol[CurROIadr, i].y then
              MinY := FhPol[CurROIadr, i].y;
            if MaxY < FhPol[CurROIadr, i].y then
              MaxY := FhPol[CurROIadr, i].y;
          End;

          SetLength(FhTbl[CurROIadr], High(FhPol[CurROIadr]), 100);
          // CntFh is the possible Max with no Pairs, and Xrows 100 each is plenty enough//
          Ymem := 0;
          For CntY := MinY to MaxY Do
          Begin
            Xmem := 0;
            Ynew := True;
            For CntX := MinX to MaxX Do
            Begin
              If (AdrArr[CntX, CntY] > -1) then
              Begin
                if Ynew = False then
                  FhTbl[CurROIadr, Ymem - 1, Xmem] := FhPol[CurROIadr,
                    AdrArr[CntX, CntY]]
                else
                  FhTbl[CurROIadr, Ymem, Xmem] := FhPol[CurROIadr,
                    AdrArr[CntX, CntY]];
                Inc(Xmem);
                if (Ynew = True) then
                begin
                  Inc(Ymem);
                  Ynew := False;
                end; // (Ynew = True)
              End; // (AdrArr[CntX,CntY] > -1)
            End; // CntX := MinX to MaxX
            SetLength(FhTbl[CurROIadr, (Ymem - 1)], Xmem);
          End; // CntY:= MinY to MaxY

          SetLength(FhTbl[CurROIadr], Ymem);
          // ------------------End Part 4: Sorting --------------------------------//
          // -------------Part 5: removing Odd X's Removes and Fills Odd Numbers for X -- //

          For CntY := 1 to High(FhTbl[CurROIadr]) - 1 do
          begin
            If ( High(FhTbl[CurROIadr, CntY]) > 0) then
            Begin // if this Row in not empty; Empty gives High = -1//
              // --------------------------------------------//
              If Odd( High(FhTbl[CurROIadr, CntY])) = False then
              Begin
                // ----------//
                If ( High(FhTbl[CurROIadr, CntY - 1]) = High(FhTbl[CurROIadr,
                    CntY + 1])) and (Odd( High(FhTbl[CurROIadr, CntY + 1]))
                    = True) then
                Begin
                  SetLength(FhTbl[CurROIadr, CntY],
                    High(FhTbl[CurROIadr, CntY - 1]) + 1);
                  for CntX := 0 to High(FhTbl[CurROIadr, CntY - 1]) do
                    FhTbl[CurROIadr, CntY, CntX].x := round
                      ((FhTbl[CurROIadr, CntY - 1, CntX].x + FhTbl[CurROIadr,
                        CntY + 1, CntX].x) / 2);
                End
                else

                  If ( High(FhTbl[CurROIadr, CntY]) - 1 = High(FhTbl[CurROIadr,
                    CntY - 1])) and (Odd( High(FhTbl[CurROIadr, CntY - 1]))
                    = True) then
                Begin
                  SetLength(FhTbl[CurROIadr, CntY],
                    High(FhTbl[CurROIadr, CntY - 1]) + 1);
                  for CntX := 0 to High(FhTbl[CurROIadr, CntY - 1]) do
                    FhTbl[CurROIadr, CntY, CntX].x := FhTbl[CurROIadr,
                      CntY - 1, CntX].x;
                End
                else If ( High(FhTbl[CurROIadr, CntY]) - 1 = High
                    (FhTbl[CurROIadr, CntY - 1])) and
                  (Odd( High(FhTbl[CurROIadr, CntY - 1])) = False) and
                  (Odd( High(FhTbl[CurROIadr, CntY + 1])) = True) then
                Begin
                  SetLength(FhTbl[CurROIadr, CntY],
                    High(FhTbl[CurROIadr, CntY + 1]) + 1);
                  for CntX := 0 to High(FhTbl[CurROIadr, CntY + 1]) do
                    FhTbl[CurROIadr, CntY, CntX].x := FhTbl[CurROIadr,
                      CntY + 1, CntX].x;
                End
                else If ( High(FhTbl[CurROIadr, CntY]) - 1 = High
                    (FhTbl[CurROIadr, CntY + 1])) and
                  (Odd( High(FhTbl[CurROIadr, CntY + 1])) = True) then
                Begin
                  SetLength(FhTbl[CurROIadr, CntY],
                    High(FhTbl[CurROIadr, CntY + 1]) + 1);
                  for CntX := 0 to High(FhTbl[CurROIadr, CntY + 1]) do
                    FhTbl[CurROIadr, CntY, CntX].x := FhTbl[CurROIadr,
                      CntY + 1, CntX].x;
                End
                else If ( High(FhTbl[CurROIadr, CntY]) - 1 = High
                    (FhTbl[CurROIadr, CntY + 1])) and
                  (Odd( High(FhTbl[CurROIadr, CntY + 1])) = False) and
                  (Odd( High(FhTbl[CurROIadr, CntY - 1])) = True) then
                Begin
                  SetLength(FhTbl[CurROIadr, CntY],
                    High(FhTbl[CurROIadr, CntY - 1]) + 1);
                  for CntX := 0 to High(FhTbl[CurROIadr, CntY - 1]) do
                    FhTbl[CurROIadr, CntY, CntX].x := FhTbl[CurROIadr,
                      CntY - 1, CntX].x;
                End;

              End; // Odd(High(TabFh[CntY]))= False//
            End; // If (High(TabFh[CntY]) > 0)
          End; // For CntY := 0 to High(TabFh)

        End; // Procedure FinishFhROI


 {***************************************************************************}


Procedure DrawComment(Const x, y: Integer;
          Const CommentTransparent: Boolean; Const Alignment: TAlignment;
          Const CommentFont: TFont; Const BkgColor: TColor;
          Const Text: AnsiString; Const Canvas: TCanvas);
        { this Procedure is similar to thin in SuperSubLabel; }
        // type TAlignment = (taLeftJustify, taRightJustify, taCenter);
        var
          i, xx: Integer;
          SubScript, SuperScript, Symbol: Boolean;
          DefFont: TFont;
          aRect: TRect;
          Outstring: AnsiString;
          Xoffset: Integer;
          DefTextHeight: Integer;

        Begin

          DefFont := TFont.Create;
          Canvas.Font := CommentFont;
          Canvas.Pen.Mode := pmCopy;

          If Alignment in [taCenter, taRightJustify] then
          begin
            Outstring := '';
            for i := 1 to Length(Text) do
            begin
              if (Text[i] <> '_') and (Text[i] <> '^') and (Text[i] <> '|') then
                Outstring := Outstring + Text[i];
            end;

            if Alignment in [taCenter] then
              Xoffset := trunc((Canvas.TextWidth(Text) - Canvas.TextWidth(Outstring)) / 2)
            else if Alignment in [taRightJustify] then
              Xoffset := trunc((Canvas.TextWidth(Text) - Canvas.TextWidth(Outstring)))
          End
          Else
            Xoffset := 0;

          aRect := Rect(x, y, x + Canvas.TextWidth(Text),y + Canvas.TextHeight(Text));

          with Canvas do
          begin
            if not(CommentTransparent) then
            begin
              Brush.Color := BkgColor;
              Brush.Style := bsSolid;
              FillRect(aRect);
            end;
            Brush.Style := bsClear; // Because the Text will Fill Again Rect
          end;

          DefFont.Assign(Canvas.Font);

          with Canvas do
          begin
            xx := x + Xoffset;

            for i := 1 to Length(Text) do
            begin
              if Text[i - 1] = '_' then
                SubScript := True
              else
                SubScript := False;
              if Text[i - 1] = '^' then
                SuperScript := True
              else
                SuperScript := False;
              if Text[i - 1] = '|' then
                Symbol := True
              else
                Symbol := False;

              if (Text[i] <> '_') and (Text[i] <> '^') and (Text[i] <> '|') then
              begin

                if (SubScript) then
                begin
                  Canvas.Font.Style := Canvas.Font.Style - [fsUnderline];
                  Canvas.Font.Height := Canvas.Font.Height * 8 div 10;
                  TextRect(Rect(xx, aRect.Top, xx + TextWidth(Text[i]),
                      aRect.Bottom), xx,
                    y + abs(8 * Canvas.Font.Height - 10 * DefFont.Height)
                      div 10, Text[i]);
                  Inc(xx, TextWidth(Text[i]));
                end;

                if (not SubScript) and (not SuperScript) then
                begin
                  Canvas.Font := DefFont;
                  if (Symbol) then
                  begin
                    DefTextHeight := TextHeight(Text[i]);
                    Canvas.Font.Name := 'Symbol';
                    TextRect(Rect(xx, aRect.Top, xx + TextWidth(Text[i]),
                        aRect.Bottom), xx,
                      y - (TextHeight(Text[i]) - DefTextHeight), Text[i]);
                  end;
                  if Not(Symbol) then
                    TextRect(Rect(xx, aRect.Top, xx + TextWidth(Text[i]),
                        aRect.Bottom), xx, y, Text[i]);
                  Inc(xx, TextWidth(Text[i]));
                end;

                if (SuperScript) then
                begin
                  Canvas.Font.Style := Canvas.Font.Style - [fsUnderline];
                  Canvas.Font.Height := Canvas.Font.Height * 9 div 10;
                  TextRect(Rect(xx, aRect.Top, xx + TextWidth(Text[i]),
                      aRect.Bottom), xx,
                    y - abs(8 * Canvas.Font.Height - 10 * DefFont.Height)
                      div 20, Text[i]);
                  Inc(xx, TextWidth(Text[i]));
                end;

                Canvas.Font := DefFont;

              end;

            end; // for loop
          end; // with

          DefFont.Free;

        End;
        // Procedure DrawComment
        { ************************************************************************** }
Function GetTimerString(Const LabelTag: Integer;
          TimePrec: ShortInt): AnsiString;
        var
          hStr, minStr, secStr, msStr: AnsiString;
          FinFrom, Sec: LongWord;
          TimeFormat: Byte;

        Begin

          // 1st: Caculate Total time in sec and Set Time Format
          FinFrom := CommentsFrom[LabelTag];

          TimeFormat := TimeDuration[LabelTag - 5];
          if TimePrec > TimeFormat then
            TimePrec := TimeFormat;

          Sec := trunc(TimeSt[CurIm] - TimeSt[FinFrom]); // rounded time

          If TimeFormat = 3 then
          Begin // hour length
            hStr := IntToStr(Sec div 3600);
            Result := hStr;
            if TimePrec < 3 then
            begin
              minStr := IntToStr((Sec - (Sec div 3600) * 3600) div 60);
              if Length(minStr) < 2 then
                Result := Result + ':0' + minStr
              else
                Result := Result + ':' + minStr;
            end;
            if TimePrec < 2 then
            begin
              secStr := IntToStr(Sec - (Sec div 60) * 60);
              if Length(secStr) < 2 then
                Result := Result + ':0' + secStr
              else
                Result := Result + ':' + secStr;
            end;
            if TimePrec = 0 then
            begin
              msStr := IntToStr
                (floor(frac(TimeSt[CurIm] - TimeSt[FinFrom]) * 1000));
              if Length(msStr) < 3 then
              begin
                if Length(msStr) = 1 then
                  msStr := '00' + msStr
                else if Length(msStr) = 2 then
                  msStr := '0' + msStr;
              end;
              Result := Result + '.' + msStr;
            end;

          End
          Else If TimeFormat = 2 then
          Begin // minutes length
            minStr := IntToStr(Sec div 60);
            Result := minStr;
            if TimePrec < 2 then
            begin
              secStr := IntToStr((Sec - (Sec div 60) * 60));
              if Length(secStr) < 2 then
                Result := Result + ':0' + secStr
              else
                Result := Result + ':' + secStr;
            end;
            if TimePrec = 0 then
            begin
              msStr := IntToStr
                (floor(frac(TimeSt[CurIm] - TimeSt[FinFrom]) * 1000));
              if Length(msStr) < 3 then
              begin
                if Length(msStr) = 1 then
                  msStr := '00' + msStr
                else if Length(msStr) = 2 then
                  msStr := '0' + msStr;
              end;
              Result := Result + '.' + msStr;
            end;

          End
          Else If TimeFormat = 1 then
          Begin // sec length
            Result := IntToStr(Sec);
            if TimePrec = 0 then
            begin
              msStr := IntToStr
                (floor(frac(TimeSt[CurIm] - TimeSt[FinFrom]) * 1000));
              if Length(msStr) < 3 then
              begin
                if Length(msStr) = 1 then
                  msStr := '00' + msStr
                else if Length(msStr) = 2 then
                  msStr := '0' + msStr;
              end;
              Result := Result + '.' + msStr;
            end;
          End
          Else

            If TimeFormat = 0 then
          Begin // ms length
            msStr := IntToStr
              (round(frac(TimeSt[CurIm] - TimeSt[FinFrom]) * 1000));
            Result := msStr;
          End;

End;

Procedure PrintCommentsForMPEGmov(Const Target: TComponent;
          Const SourceRect: TRect; Var TemBMP: TBitmap);
        { I succeeded to Pass TFrame or TForm as TComponent since they
          inherit Properties "Components" & "ComponentCount'from Tcomponent
          }

        var
          i: Integer;
          TemStr: AnsiString;
        Begin
          with Target do
          begin
            for i := 0 to ComponentCount - 1 do
            begin
              if (Components[i] is TSuperSubLabel) then
                with Components[i] as TSuperSubLabel do
                  if (CurIm >= CommentsFrom[Tag]) and
                    (CurIm <= CommentsTo[Tag]) then
                  begin
                    Visible := True;
                    if (Tag < 5) then
                    begin
                      if Not(frmImageControl.ubApplyFrame.Selected) or
                        (MovieFromWin = WINDOW_3D) then
                        DrawComment(Left, Top, Transparent, Alignment, Font,
                          Color, Caption, TemBMP.Canvas)
                        else
                      if (frmImageControl.ubApplyFrame.Selected) and
                        ((MovieFromWin = WINDOW_MAIN) or (MovieFromWin = WINDOW_MERGE))
                        then
                        DrawComment(Left - SourceRect.Left,
                          Top - SourceRect.Top, Transparent, Alignment,
                          Font, Color, Caption, TemBMP.Canvas);
                    end
                    else if (Tag > 4) then
                    begin

                      if CounterType[Tag - 5] = 0 then //Time
                        TemStr := GetTimerString(Tag, TimePrecision[Tag - 5])
                          + ' ' + TimeUnits[Tag - 5]
                        else
                      if CounterType[Tag - 5] = 1 then begin //Z steps in µm
                        if (MovFType = ZEISS_CZI_LSM_MOV) then
                        TemStr := FloatToStrF(TimeSt[frmPlayback.PlaybackScrollBar.Position],ffFixed,5,TimePrecision[Tag - 5]) +
                         ' ' + TimeUnits[Tag - 5]
                          else
                        if (MovFType = ANDOR_MOV) then
                        TemStr := FloatToStrF(ZstackArr[frmPlayback.PlaybackScrollBar.Position],ffFixed,5,TimePrecision[Tag - 5]) +
                         ' ' + TimeUnits[Tag - 5];
                      end
                        else
                      if CounterType[Tag - 5] = 2 then //Frame Number
                        TemStr := IntToStr
                          (frmPlayback.PlaybackScrollBar.Position + 1 -
                            CommentsFrom[Tag] div JumpAv)
                          + ' ' + TimeUnits[Tag - 5];

                      if Not(frmImageControl.ubApplyFrame.Selected) or
                        (MovieFromWin = WINDOW_3D) then
                        DrawComment(Left, Top, Transparent, Alignment, Font,
                          Color, TemStr, TemBMP.Canvas)
                        else
                      if (frmImageControl.ubApplyFrame.Selected) and
                        ((MovieFromWin = WINDOW_MAIN) or (MovieFromWin = WINDOW_MERGE))
                      then
                        DrawComment(Left - SourceRect.Left,
                          Top - SourceRect.Top, Transparent, Alignment,
                          Font, Color, TemStr, TemBMP.Canvas);
                      Caption := TemStr; // for the Label
                    end; // if (Tag > 4)
                  end
                  else // if (CurIm >= CommentsFrom[Tag]) and (CurIm <= CommentsTo[Tag]) then begin
                    Visible := False;
            end; // for
          end; // with

End;

{ ************************************************************************** }

Procedure WriteBMPsForFFMPEG(Const MovieFileName : AnsiString);

Var TemBMP: TBitmap;
    SourceRect, DestRect: TRect;
    Cnt,Beg,ToEnd,ImNr, NrToRepl, StartPos : Integer;
    ZeroStr, NrStr, SaveFname,SavePath : AnsiString;
    Sender : TObject;
    RequestedSpace : Int64;
    SpaceEnough : Boolean;
Begin

  ZeroStr := '000000';
  Beg   := ExportDial.FromIm;
  ToEnd := ExportDial.ToIm;
  ImNr  := CurIm;
  frmPlayback.ForWards.Down := True;
  PlayBackMode := CONT_FORWARD;

    SavePath := ExportDial.TempBMPDir + '\';

    TemBMP := TBitmap.Create;
  //------ Prepare BMP properties -------//
   // -- From Main Window-----//
      If (MovieFromWin = WINDOW_MAIN) Then Begin
        If Not(frmImageControl.ubApplyFrame.Selected) then Begin
          with frmMainWin.winMainImage.Picture.Bitmap do
          TemBMP.SetSize(Width,Height);
          TemBMP.PixelFormat := pf24bit; // Convert to 24 bit Important!!! it becomes also bmDIB
        End
          Else
        If (frmImageControl.ubApplyFrame.Selected) then Begin
          GetSelFrameParams(TemBMP, SourceRect.Left, SourceRect.Top,SourceRect.Right, SourceRect.Bottom);
          //AVI movie requires Width to be divisible by 4
          if (ExportDial.MovieKind = AVI_UNC) and (TemBMP.Width mod 4 <> 0) then begin
            TemBMP.Width := (TemBMP.Width shr 2)shl 2;
          end;
          TemBMP.PixelFormat := pf24bit; // Convert to 24 bit Important!!! after size settings
          DestRect.Left := 0;
          DestRect.Top := 0;
          DestRect.Right := TemBMP.Width;
          DestRect.Bottom := TemBMP.Height;
        End;
      End
        Else
      If (MovieFromWin = WINDOW_MERGE) Then Begin
        If Not(frmImageControl.ubApplyFrame.Selected) then Begin
          with frmMergeWin.MergeImage.Picture.Bitmap do
          TemBMP.SetSize(Width,Height);
          TemBMP.PixelFormat := pf24bit; // Convert to 24 bit Important!!! it becomes also bmDIB
        End
          Else
        If (frmImageControl.ubApplyFrame.Selected) then Begin
          GetSelFrameParams(TemBMP, SourceRect.Left, SourceRect.Top, SourceRect.Right, SourceRect.Bottom);
          //AVI movie requires Width to be divisible by 4
          if (ExportDial.MovieKind = AVI_UNC) and (TemBMP.Width mod 4 <> 0) then begin
            TemBMP.Width := (TemBMP.Width shr 2)shl 2;
          end;
          TemBMP.PixelFormat := pf24bit; // Convert to 24 bit Important!!! after size settings
          DestRect.Left := 0;
          DestRect.Top := 0;
          DestRect.Right := TemBMP.Width;
          DestRect.Bottom := TemBMP.Height;
        End;
      End
        Else
        // -----  from 3D window ------------//
      If (MovieFromWin = WINDOW_3D) Then Begin
        with frm3DImageWin do TemBMP.SetSize(ClientWidth,ClientHeight);
        TemBMP.PixelFormat := pf24bit; // always after width and Height setting
      End;

  For Cnt := Beg to ToEnd Do Begin
      if (PlayBackMode = STOPPED) then Break;
      NrToRepl := Length(IntToStr(Cnt-Beg));
      StartPos := Length(ZeroStr) - Length(IntToStr(Cnt-Beg)) + 1;
      NrStr    := StuffString(ZeroStr,StartPos,NrToRepl,IntToStr(Cnt - Beg));
      frmPlayback.PlaybackScrollBar.Position := Cnt;
      SaveFname := SavePath + NrStr + '.bmp' ;
      //makes 000000.bmp

       // -- From Main Window-----//
      If (MovieFromWin = WINDOW_MAIN) Then Begin
        If Not(frmImageControl.ubApplyFrame.Selected) then Begin
          TemBMP.Canvas.Draw(0, 0,frmMainWin.winMainImage.Picture.Bitmap);
        End
          Else
        If (frmImageControl.ubApplyFrame.Selected) then Begin
          TemBMP.Canvas.CopyRect(DestRect,frmMainWin.winMainImage.Canvas, SourceRect);
        End;
      End
        Else
      If (MovieFromWin = WINDOW_MERGE) Then Begin
        If Not(frmImageControl.ubApplyFrame.Selected) then Begin
          TemBMP.Canvas.Draw(0, 0,frmMergeWin.MergeImage.Picture.Bitmap);
        End
          Else
        If (frmImageControl.ubApplyFrame.Selected) then Begin
          TemBMP.Canvas.CopyRect(DestRect,frmMergeWin.MergeImage.Canvas, SourceRect);
        End;
      End
        Else
        // -----  from 3D window ------------//
      If (MovieFromWin = WINDOW_3D) Then Begin
        TemBMP.Canvas.Draw(0, 0, frm3DImageWin.Image3DWin.Picture.Bitmap);
      End;

      { --------- here we Place Comments and Counters -------------- }
      If (HasComments) then Begin
        if (MovieFromWin = WINDOW_MAIN) then
          PrintCommentsForMPEGmov(frmMainWin, SourceRect, TemBMP)
                else
        if (MovieFromWin = WINDOW_MERGE) then
          PrintCommentsForMPEGmov(frmMergeWin, SourceRect, TemBMP)
                else
        if (MovieFromWin = WINDOW_3D) then
          PrintCommentsForMPEGmov(frm3DImageWin, SourceRect, TemBMP);
      End; //If (HasComments) then Begin
            { ------End of Place Comments and Counters -------------- }

      TemBMP.SaveToFile(SaveFname);
      Application.ProcessMessages;

   End; {For Cnt := Beg to ToEnd }

   if frmPlayback.PlaybackScrollBar.Position <> ImNr then
   frmPlayback.PlaybackScrollBar.Position := ImNr;
   frmPlayback.Stop.Down := True;
   frmPlayback.StopClick(sender);

   FreeAndNil(TemBMP);

End; //Procedure WriteBMPsForFFMPEG(var CurrentFrame : Integer);

{ ************************************************************************** }
Procedure PrepareForMakingMovie(MovieFileName : AnsiString; Sender : TObject);
Var RequestedSpaceForMovie,RequestedSpaceForBMPs,NeededTotalSpace : Int64;
    C_Drive : Boolean; //True if Movie and BMPs will be recorded on C: drive
    ProceedDriveSpaceEnough,DriveSpaceEnoughForMovie,DriveSpaceEnoughForBMPs : Boolean;
Begin

   if (ExportDial.MovieKind = AVI_UNC) then begin
    if ExtractFileExt(MovieFileName) <> '.avi' then MovieFileName := MovieFileName + '.avi';
   end else
   if (ExportDial.MovieKind = MP4_x264) then begin
    if ExtractFileExt(MovieFileName) <> '.mp4' then MovieFileName := MovieFileName + '.mp4';
   end else
   if (ExportDial.MovieKind = FLV_x264) then begin
    if ExtractFileExt(MovieFileName) <> '.flv' then MovieFileName := MovieFileName + '.flv';
   end else
   if (ExportDial.MovieKind = MOV_x264) then begin
    if ExtractFileExt(MovieFileName) <> '.mov' then MovieFileName := MovieFileName + '.mov';
   end;

      //set some variables
    ProceedDriveSpaceEnough := False;
    C_Drive := False;
    if 'C:' = ExtractFileDrive(MovieFileName) then C_Drive := True;
    RequestedSpaceForBMPs := 3*GetNumberOfPixels*(ExportDial.ToIm-ExportDial.FromIm+1); //Get Space needed for the Temp BMPs
      //set space for movie
    If (ExportDial.MovieKind in [MP4_x264,FLV_x264,MOV_x264]) then Begin
      if not(ExportDial.UseCRF) then
        RequestedSpaceForMovie := round((MovieDuration*ExportDial.MovieBitRate/8)*1000)
        else
      if (ExportDial.UseCRF) then
          RequestedSpaceForMovie := round((5/8)*GetNumberOfPixels*MovieDuration*ExportDial.MovieFrameRate);
          {with CRF in use we cannot determine the BitRate.
          I assume that this give bitrate/(pixels*frame) = 5.  Typically is less than 5 even with QF = 1
          Then Bitrate (bits/sec) = (5*Pix*Framerate)8
          Then FileSize (ib bytes) = (8*Pix*Framerate*MovieDuration)/8  = (5/8)*Pixels*Framerate*MovieDuration
          Divided by 8 to convert Bits to Bytes
          }
    End
      Else
    If (ExportDial.MovieKind = AVI_UNC) then begin
      RequestedSpaceForMovie := 3*GetNumberOfPixels*(ExportDial.ToIm-ExportDial.FromIm+1);
      {this give  bits/(pixels*frame) = 24 (3 * 8 for each color)
      there is some few thousand 4000-5000 bytes more for the heather but I don't add them}
    End;


    If(C_Drive) then Begin
      ProceedDriveSpaceEnough := DriveSpaceEnough(RequestedSpaceForMovie,MovieFileName,True);
      if (ProceedDriveSpaceEnough) then begin
        if not(DirectoryExists('C:\Users\Public')) then
          ExportDial.TempBMPDir := 'C:\SparkAnTempBMPs'
            else
          ExportDial.TempBMPDir := 'C:\Users\Public\SparkAnTempBMPs';
        CreateDir(ExportDial.TempBMPDir);
      end;
    End //If(C_Drive)
      Else
    If not(C_Drive) then Begin
          //check for the movie
      DriveSpaceEnoughForMovie := DriveSpaceEnough(RequestedSpaceForMovie,SparkAnDir,False);
      if not(DriveSpaceEnoughForMovie) then begin
        MessageDlg('There is not enough space on this device ' + ExtractFileDrive(MovieFileName) + ' for Movie',mtError,[mbOK],0);
      end
        else
      if (DriveSpaceEnoughForMovie) then begin
          //check for the movie
        DriveSpaceEnoughForBMPs := DriveSpaceEnough(RequestedSpaceForBMPs,'C:',False);
        if (DriveSpaceEnoughForBMPs) then begin
          if not(DirectoryExists('C:\Users\Public')) then
            ExportDial.TempBMPDir := 'C:\SparkAnTempBMPs'
          else
            ExportDial.TempBMPDir := 'C:\Users\Public\SparkAnTempBMPs';
            CreateDir(ExportDial.TempBMPDir);
        end //if (DriveSpaceEnoughForBMPs)
          else
        if not(DriveSpaceEnoughForBMPs) then begin //create directory on the Movie Drive
          DriveSpaceEnoughForBMPs := DriveSpaceEnough(RequestedSpaceForBMPs,MovieFileName,False);
          if (DriveSpaceEnoughForBMPs) then begin
            ExportDial.TempBMPDir := ExtractFileDrive(MovieFileName) + '\SparkAnTempBMPs';
            CreateDir(ExportDial.TempBMPDir);
          end
            else
          if not(DriveSpaceEnoughForBMPs) then begin
            MessageDlg('There is not enough space on "C:" Drive or This device ' +
                        ExtractFileDrive(MovieFileName) + ' for Temp Bitmaps',mtError,[mbOK],0);
          end; //if not(DriveSpaceEnoughForBMPs) then begin
        end; //if not(DriveSpaceEnoughForBMPs)
      end; //if (DriveSpaceEnoughForMovie) then begin
         ProceedDriveSpaceEnough := (DriveSpaceEnoughForMovie) and (DriveSpaceEnoughForBMPs);
   End; //If not(C_Drive) then Begin

   If (ProceedDriveSpaceEnough) then Begin
        If (IsFileInUse(MovieFileName) = False) then begin
          FilePaths.MultipleImagesFilePath := ExtractFilePath(MovieFileName);
          MakeMovieWithFFMPEG(MovieFileName);
          if (ExportDial.DoWriteLogFile) then WriteLogFile(Sender,MovieFileName);
        End
          Else
        If IsFileInUse(MovieFileName) = True then Begin
          MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);
        End; //If (IsFileInUse(SaveFname) = True)
    End; // If (ProceedDriveSpaceEnough) then Begin

End;   //Procedure PrepareForMakingMovie;

{*****************************************************************************}
Procedure ResetFromToTEdits(Const CommentsVal: Word; Var edFromTo: TEdit);
var OnChange: TNotifyEvent;
begin
  OnChange := edFromTo.OnChange;
  edFromTo.OnChange := nil;
  edFromTo.Text := IntToStr(CommentsVal div JumpAv + 1);
  edFromTo.OnChange := OnChange;
End;

{*****************************************************************************}

Procedure MakeMovieWithFFMPEG(Const MovieFileName : AnsiString);

Var

CurImMem        : Integer;
Counter1Caption : AnsiString;
Counter2Caption : AnsiString;
//Variables used in making MOV,FLV, mp4 movies//
BMPsFilePath : AnsiString; //has to be AnsiString
cmd              : String; //can be string
BitRateOrCRF     : String; //can be string
InpFrameRate     : String;
OutFrameRate     : String;


          Procedure CheckMPEGLabels(Const Target: TComponent);
          // this nested procedure is used to pass Main or 3D Window as TComponent for the Labels
          var
            i: Integer;
          Begin

            with Target do
            begin
              for i := 0 to ComponentCount - 1 do
              begin
                if (Components[i] is TSuperSubLabel) then
                begin
                  HasComments := True;
                  if Components[i].Tag in [5, 6] then
                    with Components[i] as TSuperSubLabel do
                    begin
                      if (Tag = 5) then
                        Counter1Caption := Caption
                      else if (Tag = 6) then
                        Counter2Caption := Caption; // stores Caption
                    end;
                  // corrects for errors
                  With Components[i] do
                  begin // corrects for errors
                    if CommentsFrom[Tag] < ExportDial.FromIm * JumpAv +
                      JumpAv - 1 then
                    begin
                      CommentsFrom[Tag] :=
                        ExportDial.FromIm * JumpAv + JumpAv - 1;
                      if frmMovieLabels <> nil then
                      begin
                        ResetFromToTEdits(CommentsFrom[Tag],
                          frmMovieLabels.edFrom1);
                        if Tag = 0 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom1)
                        else if Tag = 1 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom2)
                        else if Tag = 2 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom3)
                        else if Tag = 3 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom4)
                        else if Tag = 4 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom5)
                        else if Tag = 5 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom6)
                        else if Tag = 6 then
                          ResetFromToTEdits(CommentsFrom[Tag],
                            frmMovieLabels.edFrom7);
                      end; // if frmMovieLabels <> nil
                    end; // if CommentsFrom[Tag] <  ExportDial.FromIm
                    if CommentsTo[Tag] > ExportDial.ToIm * JumpAv + JumpAv -
                      1 then
                    begin
                      CommentsTo[Tag] := ExportDial.ToIm * JumpAv + JumpAv - 1;
                      if frmMovieLabels <> nil then
                      begin
                        if Tag = 0 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo1)
                        else if Tag = 1 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo2)
                        else if Tag = 2 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo3)
                        else if Tag = 3 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo4)
                        else if Tag = 4 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo5)
                        else if Tag = 5 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo6)
                        else if Tag = 6 then
                          ResetFromToTEdits(CommentsTo[Tag],
                            frmMovieLabels.edTo7);
                      end; // if frmMovieLabels <> nil
                    end; // if CommentsTo[Tag] >  ExportDial.ToIm then begin
                    // end of corrects for errors
                  End; // with Components[i] do begin
                end; // if (Components[i] is TSuperSubLabel) then begin
              end; // for i := 0 to ComponentCount - 1 do begin
            end; // Target do begin
          End; // Procedure CheckMPEGLabels(Const Target : TComponent);

          procedure RestoreMPEGLabels(Const Target: TComponent);
          var
            i: Integer;
          Begin
            with Target do
            begin
              for i := 0 to ComponentCount - 1 do
              begin
                if (Components[i] is TSuperSubLabel) then
                begin
                  with Components[i] as TSuperSubLabel do
                  begin
                    if Tag = 5 then
                      Caption := Counter1Caption
                    else if Tag = 6 then
                      Caption := Counter2Caption; // Restores Caption
                    Visible := True;
                  end; // with Components[i] as TSuperSubLabel
                end; // if (Components[i] is TSuperSubLabel) then begin
              end; // for
            end; // with Target do begin
          End; // procedure RestoreMPEGLabels(Const Target : TComponent);

BEGIN

          If (MovieFromWin = WINDOW_MAIN) Then Begin
            // 1st Opens Main Window if Hidden
            If frmMainWin.frmMainWinHidden = True then with frmMainWin do Begin
                frmMainWin.frmMainWinHidden := False;
                WindowState := wsNormal;
                SetBounds(Screen.Width div 2 - Width div 2,Screen.Height div 2 - Height div 2, Width, Height);
                ShowWindow(frmMainWin.Handle, Sw_Show);
            End;
            if frmMainWin.WindowState = wsMinimized then
              frmMainWin.WindowState := wsNormal;
            frmMainWin.BorderIcons := [];
          End
            Else
          If (MovieFromWin = WINDOW_MERGE) Then
          Begin
            if (frmMergeWin.WindowState = wsMinimized) then
              frmMergeWin.WindowState := wsNormal;
            frmMergeWin.BorderIcons := [];
          End
            Else
          If (MovieFromWin = WINDOW_3D) Then Begin
            if frm3DImageWin.WindowState = wsMinimized then
              frm3DImageWin.WindowState := wsNormal;
            frm3DImageWin.BorderIcons := [];
          End;

          CurImMem := CurIm;
          frmPlayback.ForWards.Down := True;
          PlayBackMode := CONT_FORWARD;
          Application.ProcessMessages;

          { finds if there are comments and counters }
          HasComments := False; // the procedure below will return true if they are there
          if (MovieFromWin = WINDOW_MAIN) and (TargetForLabels = WINDOW_MAIN)
          then
            CheckMPEGLabels(frmMainWin)
            else
          if (MovieFromWin = WINDOW_MERGE) and (TargetForLabels = WINDOW_MERGE)
          then
            CheckMPEGLabels(frmMergeWin)
            else
          if (MovieFromWin = WINDOW_3D) and (TargetForLabels = WINDOW_3D)
          then
            CheckMPEGLabels(frm3DImageWin);

          //here has to be writing BITmaps
          WriteBMPsForFFMPEG(MovieFileName);

          { ---Comments Section - Makes them Visible-- }
          If (HasComments) then begin
            if (MovieFromWin = WINDOW_MAIN) then RestoreMPEGLabels(frmMainWin)
              else
            if (MovieFromWin = WINDOW_MERGE) then RestoreMPEGLabels(frmMergeWin)
              else
            if (MovieFromWin = WINDOW_3D) then RestoreMPEGLabels(frm3DImageWin);
          End;
          { ------------------------------------------------- }
          if (MovieFromWin = WINDOW_MAIN)
          then
            frmMainWin.BorderIcons := [biSystemMenu, biMinimize]
            else
          if (MovieFromWin = WINDOW_MERGE)
          then
            frmMergeWin.BorderIcons := [biSystemMenu, biMinimize]
            else
          if (MovieFromWin = WINDOW_3D)
          then
            frm3DImageWin.BorderIcons := [biSystemMenu, biMinimize];

  //------------- Now Make Movie -------------------------------------------//

//Use of -qp is recommended over -crf for lossless because 8-bit and 10-bit x264 use different -crf values for lossless.

    BMPsFilePath := ExportDial.TempBMPDir + '\%06d.bmp';  //SparkAnDir := GetCurrentDir + '\';
    InpFrameRate := '" -framerate ' + FloatToStr(ExportDial.MovieFrameRate) + '"';
    OutFrameRate := ' -r ' + FloatToStr(ExportDial.MovieFrameRate);

    If (ExportDial.MovieKind in [MP4_x264,FLV_x264,MOV_x264]) then Begin
      if    (ExportDial.UseCRF) then BitRateOrCRF := ' -crf ' + IntToStr(ExportDial.CRF)
        else
      if not(ExportDial.UseCRF) then BitRateOrCRF := ' -b:v ' + IntToStr(ExportDial.MovieBitRate)+ 'k'; //it is in kilobits/second

      cmd := '"ffmpeg.exe"' + InpFrameRate + '" -i "' + string(BMPsFilePath) + '" -c:v libx264 -pix_fmt yuv420p -debug_ts -y -profile:v high -level 4.1 -preset slow' +
             OutFrameRate + BitRateOrCRF + ' -acodec copy "' + string(MovieFileName) + '"';
    End
      Else
    If (ExportDial.MovieKind = AVI_UNC) then begin
      cmd := '"ffmpeg.exe"' + InpFrameRate + '" -i "' + string(BMPsFilePath) + '" -c:v rawvideo -pix_fmt bgr24 -debug_ts -y ' +
             OutFrameRate + ' -acodec copy "' + string(MovieFileName) + '"';
    End;

 {
 You can specify two frame rates: The rate according to which the images are read, by setting -framerate before -i.
 The default for reading input is -framerate 25 which will be set if no -framerate is specified.
 The output frame rate for the video stream by setting -r after -i or by using the fps filter.
 If you want the input and output frame rates to be the same, then just declare an input -framerate and
 the output will inherit the same value. By using a separate frame rate for the input and output
 you can control the duration at which each input is displayed and tell ffmpeg the frame rate you want for the output file.
 If the input -framerate is lower than the output -r then ffmpeg will duplicate frames to reach your desired output frame rate.
 If the input -framerate is higher than the output -r then ffmpeg will drop frames to reach your desired output frame rate.
 }

    if (frmProgress = nil) then Application.CreateForm(TfrmProgress,frmProgress);

    if (frmProgress <> nil) then with frmProgress do begin
      if (ExportDial.MovieKind = AVI_UNC)  then lbAction.Caption := 'Creating "avi" movie' else
      if (ExportDial.MovieKind = MP4_x264) then lbAction.Caption := 'Creating "mp4" movie' else
      if (ExportDial.MovieKind = FLV_x264) then lbAction.Caption := 'Creating "flv" movie' else
      if (ExportDial.MovieKind = MOV_x264) then lbAction.Caption := 'Creating "mov" movie';
      lbProgress.Caption := '0%';
      lbReading.Caption  := 'Done:';
      ImageProgressBar.Min := 0;
      ImageProgressBar.Max := 100;
      Application.ProcessMessages;
    end;

    GetDosOutput(cmd,string(SparkAnDir),frmProgress.ImageProgressBar,frmProgress.lbProgress);
    if (frmProgress <> nil) then frmProgress.ImageProgressBar.Position := 0;
    if (frmProgress <> nil) then frmProgress.Close;

    DeleteDirectory(string(ExportDial.TempBMPDir));

End;  //procedure MakeMovieWithFFMPEG


 { ************************************************************************** }

procedure GetDosOutput(CommandLine, WorkDir: String; var aProgressBar : TProgressBar; aLabel : Tlabel);
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  Handle: Boolean;
  //introduced by Adfrian
  Pos1,Pos2 : Integer;
  TimeStr : AnsiString;
begin

  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then  begin

            Buffer[BytesRead] := #0;

            if AnsiStartsStr('muxer',Buffer) then begin
              Pos1 := AnsiPos('pkt_pts_time',Buffer);
              Pos2 := AnsiPos(' pkt_dts',Buffer);
              TimeStr := Copy(Buffer,Pos1+13,Pos2-(Pos1+13));
              aLabel.Caption := IntToStr(round((100*StrToFloat(TimeStr))/MovieDuration)) + '%';
              aProgressBar.Position := round((100*StrToFloat(TimeStr))/MovieDuration);
              Application.ProcessMessages;
            end;

          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;   //procedure GetDosOutput(CommandLine, WorkDir: string; var aProgressBar : TProgressBar);

{******************************************************************************}

function GetNumberOfPixels : Int64;
begin

  if (MovieFromWin = WINDOW_MAIN) then with frmMainWin do begin
    if Not(frmImageControl.ubApplyFrame.Selected) then
      Result := winMainImage.Width*winMainImage.Height else
    if    (frmImageControl.ubApplyFrame.Selected) then
      Result := (SelFrame.Width+1)*(SelFrame.Height+1);
  end
    else
  if (MovieFromWin = WINDOW_MERGE) then with frmMergeWin do begin
    if Not(frmImageControl.ubApplyFrame.Selected) then
      Result := MergeImage.Width*MergeImage.Height else
    if    (frmImageControl.ubApplyFrame.Selected) then
      Result := (SelFrame.Width+1)*(SelFrame.Height+1);
  end
    else
  if (MovieFromWin = WINDOW_3D) then with frm3DImageWin do begin
      Result := Image3DWin.Width*Image3DWin.Height;
  end;

end;

{******************************************************************************}

procedure CheckIfSelFrameFits;
begin

  If (SelFrame.Width+1 > imXsize-6)  or (SelFrame.Height+1 > imYsize-6) or
     (SelFrame.Left < 2) or (SelFrame.Right  > imXsize-3) or
     (SelFrame.Top  < 2) or (SelFrame.Bottom > imYsize-3) or
     (SelFrame.Width < 20) or (SelFrame.Height < 20)
  Then Begin
      SelFrame.Width  := imXsize shr 1;
      SelFrame.Height := imYsize shr 1;
      SelFrame.Left   := (imXsize - SelFrame.Width)  shr 1;
      SelFrame.Top    := (imYsize - SelFrame.Height) shr 1;

  End;
End;
 { ************************************************************************** }
Procedure GetSelFrameParams(var BMPwh: TBitmap; var Left, Top, Right, Bottom: Integer);
var FinalWidth,FinalHeight : Integer;
Begin

          if (Zoom = 1) then
          begin
           if (ExportDial.MovieKind in[MP4_x264,FLV_x264,MOV_x264]) then begin  //make Width and Height even
            if ((SelFrame.Width  + 1) mod 2 <> 0) then begin
              SelFrame.Width  := SelFrame.Width  - 1; // SelFrame.Right is automatically corrected (decremented by 1)
              if (frmImageControl.SelectionFrameChange.Down) then
              frmImageControl.TitleXofROI.Caption :=  'Width  = '  + IntToStr(SelFrame.Width+1) +
                                                      ';  L = '    + IntToStr(SelFrame.Left) +
                                                      ';  R = '   + IntToStr(SelFrame.Right);
            end;
            if ((SelFrame.Height + 1) mod 2 <> 0) then begin
              SelFrame.Height := SelFrame.Height - 1;
              if (frmImageControl.SelectionFrameChange.Down) then
              frmImageControl.TitleYofROI.Caption := 'Height = ' + IntToStr(SelFrame.Height+1) +
                                                      '; T = '    + IntToStr(SelFrame.Top) +
                                                      '; B = '    + IntToStr(SelFrame.Bottom);
            end;
           end; //if (ExportDial.MovieKind in[MP4_x264,FLV_x264,MOV_x264]) then begin
           //for MWV and AVI the MCL DLLs automatically make the movie Width and height divisible by 4

            BMPwh.SetSize(SelFrame.Width + 1,SelFrame.Height + 1); //SelFrame.Width & Height is  actually by 1 pixel less
            Left   := SelFrame.Left;
            Top    := SelFrame.Top;
            Right  := SelFrame.Right;
            Bottom := SelFrame.Bottom;
          end
          else

          if (Zoom = 2) then
          begin
           if (ExportDial.MovieKind in[MP4_x264,FLV_x264,MOV_x264]) then begin
            if (((SelFrame.Width  + 1) shl Zm) mod 2 <> 0) then begin
              SelFrame.Width  := SelFrame.Width  - 1; // SelFrame.Right is automatically corrected (decremented by 1)
              if (frmImageControl.SelectionFrameChange.Down) then
              frmImageControl.TitleXofROI.Caption :=  'Width  = '  + IntToStr(SelFrame.Width+1) +
                                                      ';  L = '    + IntToStr(SelFrame.Left) +
                                                      ';  R = '   + IntToStr(SelFrame.Right);
            end;
            if (((SelFrame.Height + 1) shl Zm) mod 2 <> 0) then begin
              SelFrame.Height := SelFrame.Height - 1;
              if (frmImageControl.SelectionFrameChange.Down) then
              frmImageControl.TitleYofROI.Caption := 'Height = ' + IntToStr(SelFrame.Height+1) +
                                                      '; T = '    + IntToStr(SelFrame.Top) +
                                                      '; B = '    + IntToStr(SelFrame.Bottom);
            end;
           end;

            BMPwh.SetSize((SelFrame.Width  + 1)  shl Zm,(SelFrame.Height + 1) shl Zm);
            Left   := SelFrame.Left shl Zm;
            Top    := SelFrame.Top shl Zm;
            Right  := SelFrame.Right shl Zm  + 1;
            Bottom := SelFrame.Bottom shl Zm + 1;
          end
          else

          if (Zoom = -2) then
          begin
           if (ExportDial.MovieKind in[MP4_x264,FLV_x264,MOV_x264]) then begin
            if (((SelFrame.Width  + 1) shr Zm) mod 2 <> 0) then begin
              SelFrame.Width  := SelFrame.Width  - 1; // SelFrame.Right is automatically corrected (decremented by 1)
              if (frmImageControl.SelectionFrameChange.Down) then
              frmImageControl.TitleXofROI.Caption :=  'Width  = '  + IntToStr(SelFrame.Width+1) +
                                                      ';  L = '    + IntToStr(SelFrame.Left) +
                                                      ';  R = '   + IntToStr(SelFrame.Right);
            end;
            if (((SelFrame.Height + 1) shr Zm) mod 2 <> 0) then begin
              SelFrame.Height := SelFrame.Height - 1;
              if (frmImageControl.SelectionFrameChange.Down) then
              frmImageControl.TitleYofROI.Caption := 'Height = ' + IntToStr(SelFrame.Height+1) +
                                                      '; T = '    + IntToStr(SelFrame.Top) +
                                                      '; B = '    + IntToStr(SelFrame.Bottom);
            end;
           end;

            BMPwh.SetSize((SelFrame.Width  + 1) shr Zm,(SelFrame.Height + 1) shr Zm);
            Left   := SelFrame.Left shr Zm;
            Top    := SelFrame.Top shr Zm;
            Right  := SelFrame.Left shr Zm + (SelFrame.Right - SelFrame.Left + 1) shr Zm - 1;
            Bottom := SelFrame.Top shr Zm + (SelFrame.Bottom - SelFrame.Top + 1) shr Zm - 1;
          end;

End;

{ ************************************************************************** }

procedure WriteLogFile(Sender: TObject; const FileNameCreated: AnsiString);
var
  LogFile     : TextFile;
  LogFilename : String;
  WriteStr    : String;
  i           : Integer;
  ColTabSetNr : Integer;
  RangeSet    : Integer;
  frmEventSites_btSaveAsBMP : Boolean;
  frmEventSites_btSaveCompositeImage : Boolean;
  frmOrthogonalSectioning_btSaveOrthSection : Boolean;
  frmOrthogonalSectioning_ChannelNumber : Integer;
  frmXYprofile_btSaveChart : Boolean;

begin

          LogFilename := FileNameCreated + '_LogFile.txt';
          AssignFile(LogFile, LogFilename);
          ReWrite(LogFile);

          Writeln(LogFile, 'Location and Name of Source Movie = ' + ImFname);
          Writeln(LogFile);
          Writeln(LogFile,'Name of Image or Movie created = ' + ExtractFileName(FileNameCreated));

          if (frmOrthogonalSectioning <> nil) then begin
            if (Sender = frmOrthogonalSectioning.btSaveOrthSection) then
              frmOrthogonalSectioning_btSaveOrthSection := True
                else
              frmOrthogonalSectioning_btSaveOrthSection := False;
            frmOrthogonalSectioning_ChannelNumber := frmOrthogonalSectioning.ChannelNumber;
          end
          else frmOrthogonalSectioning_btSaveOrthSection := False;


          if (frmXYprofile <> nil) then begin
            if (Sender = frmXYprofile.SaveAsBMP) or (Sender = frmXYprofile.SaveAsMetafile) then
              frmXYprofile_btSaveChart := True
                else
              frmXYprofile_btSaveChart := False;
          end
          else frmXYprofile_btSaveChart := False;

          if (frmEventSites <> nil) then begin
               if (Sender = frmEventSites.btSaveAsBMP) then
                frmEventSites_btSaveAsBMP := True
               else
                frmEventSites_btSaveAsBMP := False;

               if (Sender = frmEventSites.btSaveCompositeImage) then
                frmEventSites_btSaveCompositeImage := True
               else
                frmEventSites_btSaveCompositeImage := False;
          end else
          begin
              frmEventSites_btSaveAsBMP := False;
              frmEventSites_btSaveCompositeImage := False;
          end;


          with MainForm do begin

            // Write Source //

            if (Sender = SaveMainWindow) Or (Sender = SaveConsecutiveImages) Or (Sender = mnMakeMovie) Or
              (sender = SaveLineScanImageAsBMP) Or (sender = SaveLineScanPanel) Or
              (sender = Save3DWindowConsecutiveImages) or (sender = mnMakeMoviefrom3D) or (sender = Save3Dwindow)
            then begin

             if (Sender = SaveMainWindow) Or (Sender = SaveConsecutiveImages) Or (Sender = mnMakeMovie) then
              WriteStr := 'Created from Main Window' else
             if (sender = SaveLineScanImageAsBMP)   then
              WriteStr := 'Created from Pseudo Line Scan Window' else
             if (sender = SaveLineScanPanel)   then
              WriteStr := 'Created from Pseudo Line Scan Panel';

             if (((sender = SaveLineScanImageAsBMP) or (sender = SaveLineScanPanel)) and (frmImageControl.cbDoLineScanOfMergeImage.Checked))
                and (NrChannels = 2) then WriteStr := WriteStr + ', Merged Image';

              if ((RatioOn) or (ChannelsRatioOn)) and (NrChannels = 2) then begin
                if (RatioOn) then begin
                  if (ChannelOrder = ASCENDING)  then WriteStr := WriteStr + ', Channel One'
                    else
                  if (ChannelOrder = DESCENDING) then WriteStr := WriteStr + ', Channel Two';
                end
                  else
                if (ChannelsRatioOn) then begin
                  if (ChannelOrder = ASCENDING)  then WriteStr := WriteStr + ', Ch1/Ch2'
                    else
                  if (ChannelOrder = DESCENDING) then WriteStr := WriteStr + ', Ch2/Ch1';
                end;
              end;

              if (NrChannels = 1) then begin
                ColTabSetNr := 0;
                RangeSet    := 0;
              end
                else
              if (NrChannels = 2) And
                 Not(RatioOn) and Not(ChannelsRatioOn) And
                 Not(((sender = SaveLineScanImageAsBMP) or (sender = SaveLineScanPanel)) and (frmImageControl.cbDoLineScanOfMergeImage.Checked))
              then begin
                  if (ChannelOrder = ASCENDING)  then begin
                    WriteStr := WriteStr + ', Channel One';
                    ColTabSetNr := 0;
                    RangeSet    := 0;
                  end
                    else
                  if (ChannelOrder = DESCENDING) then begin
                    WriteStr := WriteStr + ', Channel Two';
                    ColTabSetNr := 2;
                    RangeSet    := 1;
                  end;
              end
                else
              ColTabSetNr := 1;  //RatioOn or ChannelsRatioOn

              if (Sender = Save3Dwindow) or  (Sender = Save3DWindowConsecutiveImages) or
              (Sender = mnMakeMoviefrom3D) then  with frm3DImageWin do
              begin
                WriteStr := 'Created from 3D Window (Width = ' + IntToStr(ClientWidth) +
                            ', Height = ' + IntToStr(ClientHeight) +')';
                if (SourceFor3D = MERGE_IMAGE_FOR_3D) then WriteStr := WriteStr + ', Source Merge Image' else
                if (SourceFor3D = MAIN_IMAGE_FOR_3D) and (NrChannels = 2) then begin
                  if (ChannelOrder = ASCENDING)  then WriteStr := WriteStr + ', Channel One' else
                  if (ChannelOrder = DESCENDING) then WriteStr := WriteStr + ', Channel Two';
                end
                  else
                if (SourceFor3D = AVER_IMAGE_FOR_3D)  then WriteStr := WriteStr  + ', Source Average Image' else
                if (SourceFor3D = LSCAN_IMAGE_FOR_3D) then WriteStr := WriteStr + ', Pseudo Line Scan Image';
              end;
              end

              else
    //--------------------------------------------------------------------------//
            if (Sender = SaveCalibrationBar) then with frmImageControl do
            begin

              if (ub1stChannel.Selected) then begin
                if Not(RatioOn) and Not(ChannelsRatioOn) then begin
                WriteStr := 'Created from Color Bar, Source Channel One';
                ColTabSetNr := 0;
                RangeSet    := 0;
                end
                 else
                if (RatioOn) or (ChannelsRatioOn) then begin
                WriteStr := 'Created from Color Bar, Source Channel One, Pseudoratio Settings';
                ColTabSetNr := 1;
                RangeSet    := 0;
                end;
              end;
              if (ub2ndChannel.Selected) then begin
                WriteStr := 'Created from Color Bar, Source Channel Two';
                ColTabSetNr := 2;
                RangeSet    := 1;
              end;

            end

              else
   //--------------------------------------------------------------------------//
            if (Sender = SaveAverageImageAsBMP)
            then begin

              if (AvImChOrig = 1) then begin
                WriteStr := 'Created from Average Image, Source Channel One';
                ColTabSetNr := 0;
                RangeSet    := 0;
              end
                else
              if (AvImChOrig = 2) then begin
                WriteStr := 'Created from Average Image, Source Channel Two';
                ColTabSetNr := 2;
                RangeSet    := 1;
              end;
            end
              else
    //--------------------------------------------------------------------------//
            if (frmOrthogonalSectioning_btSaveOrthSection) then begin

              if (frmOrthogonalSectioning_ChannelNumber = Ch_1) then begin
                WriteStr := 'Created from Orthogonal Sectioning Window, Source Channel One';
                ColTabSetNr := 0;
                RangeSet    := 0;
              end
                else
              if (frmOrthogonalSectioning_ChannelNumber = Ch_2) then begin
                WriteStr := 'Created from Orthogonal Sectioning Window, Source Channel Two';
                ColTabSetNr := 2;
                RangeSet    := 1;
              end
                else
              if (frmOrthogonalSectioning_ChannelNumber = Ch_Both) then begin
                WriteStr := 'Created from Orthogonal Sectioning Window, Source Channels One and Two';
              end;
            end
              else
    //--------------------------------------------------------------------------//
            if (Sender = SaveSecondaryWindow) or (Sender = SaveConsecutiveImagesfrom2ndWindow)
            then begin
              WriteStr := 'Created from Secondary Window';
                if (ChannelOrder = ASCENDING)  then begin
                  WriteStr := WriteStr + ', Channel Two';
                  ColTabSetNr := 2;
                  RangeSet    := 1;
                end
                   else
                if (ChannelOrder = DESCENDING) then begin
                  WriteStr := WriteStr + ', Channel One';
                  ColTabSetNr := 0;
                  RangeSet    := 0;
                end;
            end

              else
    //--------------------------------------------------------------------------//
            if (NrChannels = 2) AND
              ((Sender = SaveMergeWindow) or (Sender = SaveConsecutiveImagesfromMergeWindow) Or
              (Sender = mnMakeMoviefromMergeWindow) or
             (((sender = SaveLineScanImageAsBMP) or (sender = SaveLineScanPanel)) and (frmImageControl.cbDoLineScanOfMergeImage.Checked)))
              then begin
              WriteStr := 'Created from Merge Window';
                if (ChannelOrder = ASCENDING)  then WriteStr := WriteStr + ', Channel Order Ascending' else
                if (ChannelOrder = DESCENDING) then WriteStr := WriteStr + ', Channel Order Descending';
            end

              else
    //--------------------------------------------------------------------------//
            if (frmXYprofile_btSaveChart) then begin
              WriteStr := 'Created from X or Y profile Plot Window';
              if not(frmXYprofile.rdAverageImage.Checked) then begin
                if (ChannelOrder = ASCENDING)  then WriteStr := WriteStr + ', Channel One'
                   else
                if (ChannelOrder = DESCENDING) then WriteStr := WriteStr + ', Channel Two';
              end
                else
              if (frmXYprofile.rdAverageImage.Checked) then WriteStr := WriteStr + ', Average Image';
            end

              else
     //--------------------------------------------------------------------------//

            if (frmEventSites_btSaveAsBMP) then
              WriteStr := 'Created from Event Sites Panel'
            else

            if (frmEventSites_btSaveCompositeImage) then
              WriteStr := 'Saved from Event Sites Panel';

            Writeln(LogFile, WriteStr);

            if not(Sender = SaveCalibrationBar) and
               not(Sender = SaveLineScanImageAsBMP) and
               not(Sender = SaveLineScanPanel) and
               not(frmEventSites_btSaveAsBMP) and
               not(frmEventSites_btSaveCompositeImage)
            then
            begin
              if (Zoom = 1) then
                WriteStr := 'Playback Zoom = 1x'
              else if (Zoom = 2) then begin
                if (Zm = 1) then WriteStr := 'Playback Zoom = 2x' else
                if (Zm = 2) then WriteStr := 'Playback Zoom = 4x';
              end
              else if (Zoom = -2) then
                WriteStr := 'Playback Zoom = 0.5x';
              Writeln(LogFile, WriteStr);
              // Selection Frame//
              if not(Sender = SaveCalibrationBar) and
                 not(frmOrthogonalSectioning_btSaveOrthSection) and
                 not(frmXYprofile_btSaveChart)
              then begin
                if (frmImageControl.ubApplyFrame.Selected) then begin
                  Writeln(LogFile, 'Selection Frame Used:');
                  WriteStr :=
                      'Width = ' + IntToStr(SelFrame.Width+1)
                  + ', Height = ' + IntToStr(SelFrame.Height+1)
                  + ', Frame Left = ' + IntToStr(SelFrame.Left)
                  + ', Top = ' + IntToStr(SelFrame.Top)
                  + ', Right = ' + IntToStr(SelFrame.Right)
                  + ', Bottom = ' + IntToStr(SelFrame.Bottom);
                  Writeln(LogFile, WriteStr);
                end
                  else
                Writeln(LogFile, 'Selection Frame Not Used.');
              end;

              if (frmXYprofile_btSaveChart) then begin
                Writeln(LogFile, 'Rectangle Used:');
                WriteStr :=
                      'Width = ' + IntToStr(XYprofileRect.Width+1)
                  + ', Height = ' + IntToStr(XYprofileRect.Height+1)
                  + ', Frame Left = ' + IntToStr(XYprofileRect.Left)
                  + ', Top = ' + IntToStr(XYprofileRect.Top)
                  + ', Right = ' + IntToStr(XYprofileRect.Right)
                  + ', Bottom = ' + IntToStr(XYprofileRect.Bottom);
                Writeln(LogFile, WriteStr);
              end;
            end;

            // Write Image Number
            if (Sender = SaveMainWindow) or (Sender = SaveSecondaryWindow) or (Sender = SaveMergeWindow) or
               (frmXYprofile_btSaveChart) or
              ((Sender = Save3Dwindow) and
               ((SourceFor3D = MAIN_IMAGE_FOR_3D) or (SourceFor3D = MERGE_IMAGE_FOR_3D)))
            then
            begin
              WriteStr := 'Image Number = ' + IntToStr(CurIm + 1);
              Writeln(LogFile, WriteStr);
            end
            else

              if (Sender = SaveAverageImageAsBMP) or
              ((Sender = Save3Dwindow) and (SourceFor3D = AVER_IMAGE_FOR_3D))
              then
            begin
              with HELP_SrtList do
              begin
                Clear;
                if (AvImExists = 1) then
                begin // online Average
                  CreateAverImHelpStr;
                end
                else if (AvImExists = 2) then
                Begin // from File
                  Add('Average File (.ave) that ' + AvImInfoStr);
                end
                else if (AvImExists = 3) then
                Begin // generated average
                  Add('Generated Average: ' + AvImInfoStr);
                end;

                for i := 0 to Count - 1 do
                  Writeln(LogFile, Strings[i]);

                Clear;

              end; // with
            end

            else

            if (Sender = SaveLineScanImageAsBMP) or
              (Sender = SaveLineScanPanel) or
              ((Sender = Save3Dwindow) and (SourceFor3D = LSCAN_IMAGE_FOR_3D))
              then
            begin
              with frmLineScan do
              begin
                WriteStr := 'Line Coordinates: X1,Y1 = ' + IntToStr
                  (MesLineUsed.LineBeg.x) + ',' + IntToStr
                  (MesLineUsed.LineBeg.y) + ', X2,Y2 = ' + IntToStr
                  (MesLineUsed.LineBeg.y) + ',' + IntToStr
                  (MesLineUsed.LineBeg.y);
                Writeln(LogFile, WriteStr);
                WriteStr := 'Scanned from Image ' + IntToStr
                  (frmLineScan.LSImBeg + 1) + ' to Image ' + IntToStr
                  (frmLineScan.LSImEnd + 1);
                Writeln(LogFile, WriteStr);
              end;

              WriteStr :=
                'Line Scan ROI Width (number of pixels to generate a trace) = '
                + IntToStr(MesLineVar.LSROI);
              Writeln(LogFile, WriteStr);
            end

              else

            // if Movie or Consecutive Images Write Images Used//
            if (Sender = SaveConsecutiveImages) or
               (Sender = SaveConsecutiveImagesfrom2ndWindow) or
               (Sender = SaveConsecutiveImagesfromMergeWindow) or
               (Sender = Save3DWindowConsecutiveImages) or
               (Sender = mnMakeMovie) or (Sender = mnMakeMoviefromMergeWindow) or (Sender = mnMakeMoviefrom3D)
            then begin
              WriteStr := 'from Image ' + IntToStr(ExportDial.FromIm + 1)
                + ' to Image ' + IntToStr(ExportDial.ToIm + 1);
              Writeln(LogFile, WriteStr);
            end;

            Writeln(LogFile);

            // Image Settings//
            if not(frmXYprofile_btSaveChart) then Writeln(LogFile, 'Image Settings:');


            with frmImageControl do begin

              if Not((((sender = SaveLineScanImageAsBMP) or (sender = SaveLineScanPanel)) and (frmImageControl.cbDoLineScanOfMergeImage.Checked))
                and (NrChannels = 2)) then begin
              if not((sender = Save3Dwindow) and (SourceFor3D = MERGE_IMAGE_FOR_3D) and (NrChannels = 2)) and not(frmImageControl.cbDoLineScanOfMergeImage.Checked)
              then begin

                if not((Sender = SaveMergeWindow) or (Sender = SaveConsecutiveImagesfromMergeWindow) or
                 (Sender = mnMakeMoviefromMergeWindow) or (frmXYprofile_btSaveChart) or
                 ((frmOrthogonalSectioning_btSaveOrthSection) and (frmOrthogonalSectioning_ChannelNumber in[Ch_Both])) or
                 (((sender = Save3DWindowConsecutiveImages) or (sender = mnMakeMoviefrom3D))))
                then begin

                  WriteStr := 'Lookup Table Used = ' + ColorTables.Items[ColTableSetings.ColTblIndex[ColTabSetNr]];
                  Writeln(LogFile, WriteStr);

                  WriteStr := 'Channel settings: ';
                  Writeln(LogFile, WriteStr);

                  if (BitCount = 16) then
                    WriteStr := 'Range from ' + IntToStr(PixRange[RangeSet].DSPixRange_PosFrom)
                      + ' to ' + IntToStr(PixRange[RangeSet].DSPixRange_PosTo)
                  else
                    WriteStr := 'Range N/A';
                  Writeln(LogFile, WriteStr);

                  WriteStr := 'Slope = ' + IntToStr(ColTableSetings.Contrast[ColTabSetNr]);
                  Writeln(LogFile, WriteStr);

                  WriteStr := 'Shift = ' + IntToStr(ColTableSetings.Brightness[ColTabSetNr]);
                  Writeln(LogFile, WriteStr);

                  WriteStr := 'Gamma = ' + FloatToStr(ColTableSetings.Gamma[ColTabSetNr]/ 10);
                  Writeln(LogFile, WriteStr);

                  with BottomColTableSettings do begin
                  if (BottomState[ColTabSetNr] = 0) then
                    Writeln(LogFile, 'Lookup Table Not Modified')
                    else
                  begin
                    if (BottomState[ColTabSetNr] = 2) then
                      Writeln(LogFile, 'Lookup Table Made Black from 0 to ' +
                        IntToStr(BottomColTableSettings.BottomValue[ColTabSetNr]))
                      else
                    if (BottomState[ColTabSetNr] = 1) then
                      Writeln(LogFile, 'Lookup Table Made White from 0 to ' +
                        IntToStr(BottomColTableSettings.BottomValue[ColTabSetNr]));
                  end;
                end;
                end;

               end; //with

              end;

              if (Sender = SaveMergeWindow) or (Sender = SaveConsecutiveImagesfromMergeWindow) or
                 (Sender = mnMakeMoviefromMergeWindow) Or
                 (((sender = Save3DWindowConsecutiveImages) or (sender = mnMakeMoviefrom3D) or
                   (sender = Save3Dwindow)) and (SourceFor3D = MERGE_IMAGE_FOR_3D))
                   Or
                 ((frmOrthogonalSectioning_btSaveOrthSection) and (frmOrthogonalSectioning_ChannelNumber = Ch_Both)) Or
                 (((sender = SaveLineScanImageAsBMP) or (sender = SaveLineScanPanel)) and (frmImageControl.cbDoLineScanOfMergeImage.Checked))
                   Or
                 ((sender = Save3Dwindow) and (SourceFor3D = LSCAN_IMAGE_FOR_3D) and (frmImageControl.cbDoLineScanOfMergeImage.Checked) and (NrChannels = 2))
              then begin

                WriteStr := 'Lookup Tables Used for Channel 1 and 2 are ' +
                ColorTables.Items[ColTableSetings.ColTblIndex[0]] + ' and ' +
                ColorTables.Items[ColTableSetings.ColTblIndex[2]];
                Writeln(LogFile, WriteStr);

                WriteStr := 'Channel One settings: ';
                Writeln(LogFile, WriteStr);

                if (BitCount = 16) then
                  WriteStr := 'Range from ' + IntToStr(PixRange[0].DSPixRange_PosFrom)
                    + ' to ' + IntToStr(PixRange[1].DSPixRange_PosTo)
                else
                  WriteStr := 'Range N/A';
                Writeln(LogFile, WriteStr);

                WriteStr := 'Slope = ' + IntToStr(ColTableSetings.Contrast[0]);
                Writeln(LogFile, WriteStr);

                WriteStr := 'Shift = ' + IntToStr(ColTableSetings.Brightness[0]);
                Writeln(LogFile, WriteStr);

                WriteStr := 'Gamma = ' + FloatToStr(ColTableSetings.Gamma[0]/ 10);
                Writeln(LogFile, WriteStr);
                Writeln(LogFile, '');


                WriteStr := 'Channel Two settings: ';
                Writeln(LogFile, WriteStr);

                if (BitCount = 16) then
                  WriteStr := 'Range from ' + IntToStr(PixRange[1].DSPixRange_PosFrom)
                    + ' to ' + IntToStr(PixRange[1].DSPixRange_PosTo)
                else
                  WriteStr := 'Range N/A';
                Writeln(LogFile, WriteStr);

                WriteStr := 'Slope = ' + IntToStr(ColTableSetings.Contrast[2]);
                Writeln(LogFile, WriteStr);

                WriteStr := 'Shift = ' + IntToStr(ColTableSetings.Brightness[2]);
                Writeln(LogFile, WriteStr);

                WriteStr := 'Gamma = ' + FloatToStr(ColTableSetings.Gamma[2]/ 10);
                Writeln(LogFile, WriteStr);

                with BottomColTableSettings do begin
                  if (BottomState[0] = 0) then
                    Writeln(LogFile, 'Lookup Table Channel One Not Modified')
                    else
                  begin
                    if (BottomState[0] = 2) then
                      Writeln(LogFile, 'Lookup Table Channel One Made Black from 0 to ' +
                        IntToStr(BottomColTableSettings.BottomValue[0]))
                      else
                    if (BottomState[0] = 1) then
                      Writeln(LogFile, 'Lookup Table Channel One Made White from 0 to ' +
                        IntToStr(BottomColTableSettings.BottomValue[0]));
                  end;

                  if (BottomState[2] = 0) then
                    Writeln(LogFile, 'Lookup Table Channel Two Not Modified')
                    else
                  begin
                    if (BottomState[2] = 2) then
                      Writeln(LogFile, 'Lookup Table Channel Two Made Black from 0 to ' +
                        IntToStr(BottomColTableSettings.BottomValue[2]))
                      else
                    if (BottomState[2] = 1) then
                      Writeln(LogFile, 'Lookup Table Channel Two Made White from 0 to ' +
                        IntToStr(BottomColTableSettings.BottomValue[2]));
                  end;
                end; //with BottomColTableSettings do begin

              end;
            end;

            with frmImageControl do begin

              if not(frmImageControl.NegColTabl.Down) then
                Writeln(LogFile, 'Image Positive')
              else
                Writeln(LogFile, 'Image Negative');
              End;

            If NOT ((Sender = SaveMergeWindow) or (Sender = SaveConsecutiveImagesfromMergeWindow) or
                 (Sender = mnMakeMoviefromMergeWindow) Or
                 (((sender = Save3DWindowConsecutiveImages) or (sender = mnMakeMoviefrom3D) or
                   (sender = Save3Dwindow)) and (SourceFor3D = MERGE_IMAGE_FOR_3D))
                   Or
                 ((frmOrthogonalSectioning_btSaveOrthSection) and (frmOrthogonalSectioning_ChannelNumber = Ch_Both)))
            then begin

              if not(RatioOn) and not(ChannelsRatioOn) then
                Writeln(LogFile, 'Non Ratio Image')
                else
              begin
                if (RatioOn) then begin
                  Writeln(LogFile, 'F/Fo Image Settings:');
                  WriteStr := 'F/Fo = ' + FloatToStrF(MaxRatio, ffFixed, 3, 1); ;
                  Writeln(LogFile, WriteStr);
                end
                  else
                begin
                  if (ChannelOrder = ASCENDING) then
                    Writeln(LogFile, 'Ch1/Ch2 Image Settings:') else
                  if (ChannelOrder = DESCENDING) then
                    Writeln(LogFile, 'Ch2/Ch1 Image Settings:')
                end;

                WriteStr := 'Bkg = ' + IntToStr(frmImageControl.trbBackSubtr.Position);
                Writeln(LogFile, WriteStr);

                WriteStr := 'Cutoff = ' + IntToStr(frmImageControl.trbCutOff.Position);
                Writeln(LogFile, WriteStr);
            end;
            End;


              // Smoothing//
              Writeln(LogFile);

              if not(Sender = MainForm.SaveCalibrationBar) then begin
                Writeln(LogFile, 'Smoothing Settings:');

                if (SmoothMode = NO_SMOOTH) or
                  ((SmoothMode <> NO_SMOOTH) and not(RatioOn) and
                   (SmoothNonRatio = NO_SMOOTH_NON_RATIO)) Or

                   ((SmoothNonRatio > NO_SMOOTH_NON_RATIO) and
                    (ChannelOrder = ASCENDING) and
                    (SmoothNonRatio = SMOOTH_Ch_TWO) and
                    not((Sender = SaveSecondaryWindow) or (Sender = SaveConsecutiveImagesfrom2ndWindow))) Or

                    ((SmoothNonRatio > NO_SMOOTH_NON_RATIO) and
                    (ChannelOrder = DESCENDING) and
                    (SmoothNonRatio = SMOOTH_Ch_ONE) and
                    not((Sender = SaveSecondaryWindow) or (Sender = SaveConsecutiveImagesfrom2ndWindow))) Or

                    ((SmoothNonRatio > NO_SMOOTH_NON_RATIO) and
                    (ChannelOrder = ASCENDING) and
                    (SmoothNonRatio = SMOOTH_Ch_ONE) and
                    ((Sender = SaveSecondaryWindow) or (Sender = SaveConsecutiveImagesfrom2ndWindow))) Or

                    ((SmoothNonRatio > NO_SMOOTH_NON_RATIO) and
                    (ChannelOrder = DESCENDING) and
                    (SmoothNonRatio = SMOOTH_Ch_TWO) and
                    ((Sender = SaveSecondaryWindow) or (Sender = SaveConsecutiveImagesfrom2ndWindow)))
                   then
                begin
                  Writeln(LogFile, 'No Smoothing was Applied');
                end

                  else

                if (SmoothMode <> NO_SMOOTH) and
                  ((RatioOn) or (SmoothNonRatio > NO_SMOOTH_NON_RATIO)) then
                begin
                  //-------------------------------------------//
                  if (SmoothNonRatio > NO_SMOOTH_NON_RATIO) and
                      not(RatioOn) and not(ChannelsRatioOn)
                  then begin
                    if (SmoothNonRatio = SMOOTH_Ch_ONE) then
                      WriteStr := 'Channel One '
                      else
                    if (SmoothNonRatio = SMOOTH_Ch_TWO) then
                      WriteStr := 'Channel Two '
                        else
                    if (SmoothNonRatio = SMOOTH_Ch_BOTH) then
                      WriteStr := 'Channel One and Two ';
                    Write(LogFile, WriteStr);
                  end;
                  //-------------------------------------------//

                  if (SmoothMode in [SMOOTH_BOX,SMOOTH_BOX_MED,SMOOTH_MED_BOX]) then
                    WriteStr := 'Smoothing with ' + IntToStr(BoxSmSize)
                      + ' Boxcar Filter'
                  else if (SmoothMode = SMOOTH_MED) then
                    WriteStr := 'Smoothing with ' + IntToStr(MedSmSize)
                      + ' Median Filter';

                  if (SmoothMode in [SMOOTH_GAUSS, SMOOTH_GAUSS_MED,
                    SMOOTH_GAUSS_MED, SMOOTH_MED_GAUSS]) then
                  begin
                    if (GaussSmSize in [1 .. 3]) then
                    begin
                      if (GaussSmSize = 1) then
                        WriteStr := '3L Gaussian Filter'
                      else if (GaussSmSize = 2) then
                        WriteStr := '3M Gaussian Filter'
                      else if (GaussSmSize = 3) then
                        WriteStr := '3H Gaussian Filter';
                    end
                    else
                      WriteStr := IntToStr(GaussSmSize) + ' Gaussian Filter';
                    if (SmoothMode = SMOOTH_GAUSS) then
                      WriteStr := 'Smoothing with ' + WriteStr;
                  end;

                  if (SmoothMode = SMOOTH_BOX_MED) then
                    WriteStr := 'Smoothing with ' + IntToStr(BoxSmSize)
                      + ' Boxcar Filter followed by ' + IntToStr(MedSmSize)
                      + ' Median Filter'
                  else if (SmoothMode = SMOOTH_MED_BOX) then
                    WriteStr := 'Smoothing with ' + IntToStr(MedSmSize)
                      + ' Median Filter followed by ' + IntToStr(BoxSmSize)
                      + ' Boxcar Filter'
                  else if (SmoothMode = SMOOTH_GAUSS_MED) then
                    WriteStr := 'Smoothing with ' + WriteStr +
                      ' followed by ' + IntToStr(MedSmSize) + ' Median Filter'
                  else if (SmoothMode = SMOOTH_MED_GAUSS) then
                    WriteStr := 'Smoothing with ' + IntToStr(MedSmSize)
                      + ' Median Filter followed by ' + WriteStr;

                  if (RatioOn) then begin
                    if (frmImageControl.cbSmoothBeforeDoRatio.Checked) then
                      WriteStr := WriteStr + ', Applied Before F/Fo' else
                    if not(frmImageControl.cbSmoothBeforeDoRatio.Checked) then
                      WriteStr := WriteStr + ', Applied After F/Fo';
                  end;
                  Writeln(LogFile, WriteStr);
                end;
              end; //if not(Sender = MainForm.SaveCalibrationBar) then begin

              // 3D Surface Plot Settings;
              If (Sender = MainForm.Save3Dwindow) or
                (Sender = Save3DWindowConsecutiveImages) or
                (Sender = mnMakeMoviefrom3D) then
              begin
                Writeln(LogFile);
                Writeln(LogFile, '3D Surface Plot Settings:');
                with frm3DImageContr do
                begin

                  if (sbHideBackFace.Down) then
                    Writeln(LogFile, 'Display Back Face of Plot')
                  else
                    Writeln(LogFile, 'Do Not Display Back Face of Plot');

                  if (rbOrtho.Checked) then
                  begin
                    Writeln(LogFile, 'Orthogonal Plot');
                  end
                  else if (rbPerspective.Checked) then
                  begin
                    Writeln(LogFile, 'Perspective Plot');
                    WriteStr := 'View Angle =' + IntToStr
                      (scrViewAngle.Position);
                    Writeln(LogFile, WriteStr);
                  end;

                  WriteStr := 'X Axis Rotation Angle = ' + IntToStr
                    (scrXRotAngle.Position);
                  Writeln(LogFile, WriteStr);
                  WriteStr := 'Y Axis Rotation Angle = ' + IntToStr
                    (scrYRotAngle.Position);
                  Writeln(LogFile, WriteStr);
                  WriteStr := 'Z Axis Rotation Angle = ' + IntToStr
                    (scrZRotAngle.Position);
                  Writeln(LogFile, WriteStr);
                  WriteStr := 'zoom = ' + IntToStr(scrScale.Position);
                  Writeln(LogFile, WriteStr);
                  WriteStr := 'Z Scale = ' + IntToStr(scrScaleZ.Position);
                  Writeln(LogFile, WriteStr);
                  if (RatioOn) then
                  begin
                    WriteStr := 'min F/Fo = ' + IntToStr(scrMinRat.Position);
                    Writeln(LogFile, WriteStr);
                  end;

                  WriteStr := 'Background Color (R,G,B) = ' + IntToStr
                    (round(glBgRed * 255)) + ', ' + IntToStr
                    (round(glBgGreen * 255)) + ', ' + IntToStr
                    (round(glBgBlue * 255));
                  Writeln(LogFile, WriteStr);

                  WriteStr := 'Axes Color (R,G,B) = ' + IntToStr
                    (round(glXYRed * 255)) + ', ' + IntToStr
                    (round(glXYGreen * 255)) + ', ' + IntToStr
                    (round(glXYBlue * 255));
                  Writeln(LogFile, WriteStr);

                  Writeln(LogFile, lbMicrons.Caption);

                    if (sbCrop.Down) then
                      Writeln(LogFile, 'Cropping On')
                    else
                      Writeln(LogFile, 'Cropping Off');


                end; // with
              end; // Sender 3D

              // Movie Settings
              if (Sender = mnMakeMovie) or (Sender = mnMakeMoviefromMergeWindow) or
                 (Sender = mnMakeMoviefrom3D) then
              begin
                Writeln(LogFile);
                Writeln(LogFile, 'Output and Source Movie Properties:');
                WriteStr := 'Source Original Frame Rate = ' + FloatToStrF
                            (ExportDial.OrigFrameRate, ffFixed, 5, 3) + ' frm/s ';
                Writeln(LogFile, WriteStr);
                if Not(JumpAv in [2, 4]) then
                  WriteStr := frmPlayback.cmbPlayMode.Items[0]
                else if JumpAv = 2 then
                  WriteStr := frmPlayback.cmbPlayMode.Items[3]
                else if JumpAv = 4 then
                  WriteStr := frmPlayback.cmbPlayMode.Items[4];
                WriteStr := WriteStr + ' playback';
                WriteStr := 'Source Effective Frame Rate (' + WriteStr + ') = ' +
                  FloatToStrF(ExportDial.OrigEffectiveFrameRate, ffFixed, 5, 3) + ' frm/s';
                Writeln(LogFile, WriteStr);

                // MovieKind          : Integer;     // 1 = MPEG; 2 = WMV; 3 = AVI (non-compressed)
                if (ExportDial.MovieKind = MPEG_1) then
                  WriteStr := 'Output Movie Kind = MPEG-1 (Moving Picture Experts Group Phase 1), CBR (Constant Bit Rate)'
                  else
                if (ExportDial.MovieKind = WMV_VC1) then
                  WriteStr := 'Output Movie Kind = WMV (Windows Media Video), CBR (Constant Bit Rate)'
                  else
                if (ExportDial.MovieKind = AVI_UNC) then
                  WriteStr := 'Output Movie Kind = Uncompressed AVI (Audio Video Interleave)'
                  else
                if (ExportDial.MovieKind = MP4_x264) then
                  WriteStr := 'Output Movie Kind = MPEG-4, x264 encoded, Profile = High, Level = 4.1'
                  else
                if (ExportDial.MovieKind = FLV_x264) then
                  WriteStr := 'Output Movie Kind = Adobe Flash Video, FLV, x264 encoded, Profile = High, Level = 4.1'
                  else
                if (ExportDial.MovieKind = MOV_x264) then
                  WriteStr := 'Output Movie Kind = Apple QuickTime MOV, x264 encoded, Profile = High, Level = 4.1';
                Writeln(LogFile, WriteStr);

                // bit rate
                if (ExportDial.UseCRF) then WriteStr := '"Constant Rate Factor" used = ' + IntToStr(ExportDial.CRF)
                  else
                WriteStr := '"Output Movie Bit Rate" Used = ' + IntToStr (ExportDial.MovieBitRate) + ' kbits/s ';
                Writeln(LogFile, WriteStr);

                // Standard or Custom framerate
                WriteStr := 'Custom Framerate Used of ' + FloatToStrF(ExportDial.MovieFrameRate, ffFixed, 5,3) + ' frm/s ';
                Writeln(LogFile, WriteStr);

                WriteStr := 'Speed Factor =  ' + FloatToStrF(ExportDial.MotionFactor, ffFixed, 10, 4);
                Writeln(LogFile, WriteStr);

                WriteStr := 'Duration = ' + FloatToStrF(MovieDuration,ffFixed,8,2) + ' s';
                Writeln(LogFile, WriteStr);
              end;
          end; // with MainForm do begin


          CloseFile(LogFile);

End;

 { ************************************************************************** }

Procedure GetHelp(Const HelpCode: Integer);
        var
          i, Cnt, MemBeg : Integer;
          TemStr         : AnsiString;
          AndorTIFFDescr : AnsiString;
          CreatTimeInSec : LongInt;
          NrPages        : LongWord;
          NrDimensions   : LongInt;


Begin

          With HELP_SrtList Do
          begin
            if (HelpCode <> 5) then
              Clear;

            Case HelpCode of
              0:
                begin
                  { Trace F/F0 (Area/min) Minimum for each ROI }

                  Cnt := 0;
                  for i := 1 to 20 do
                  begin
                    if ROIvar.ROIAdr[i] > 0 then
                    begin
                      Inc(Cnt);
                      if i < 10 then
                        TemStr := ' Trace   '
                      else
                        TemStr := ' Trace ';

                      Add(TemStr + IntToStr(i) + ' minimum = ' + FloatToStrF
                          (Divider[Cnt - 1], ffFixed, 5, 2));
                      if (Cnt > ROIvar.NrROI - 1) then
                        Break;
                    end;
                  end;
                end;
            end;

  Case HelpCode of 1:
    begin
      Add('Click right mouse button on widgets to get Help');
    end;
  end;
{ ----------------------------------------------------------------------------------------- }
{ Info on Movies properties }
  Case HelpCode of 2:
  begin

    if (MovFType = QED_MOV) then begin
      Add('QED Movie File');
      Add(' ');
      Add('Name: ' + ExtractFileName(ImFname));
      Add(' ');
    end
      else
    if (MovFType = NORAN_PRARIE_MOV) then begin
      Add('Noran (Prarie) Movie File');
      Add(' ');
      Add('Name: ' + ExtractFileName(ImFname));
      Add(' ');
    end
      else
    if (MovFType = StreamPix_MOV) then begin
      Add('StreamPix (NorPix, Inc) Movie File');
      Add(' ');
      Add('Name: ' + ExtractFileName(ImFname));
      Add(' ');
    end
      else
    if (MovFType = NIKON_ND2_MOV) then begin
      Add('Nikon NIS-Elements ND2 File');
      Add(' ');
      Add('Name: ' + ExtractFileName(ImFname));
      Add(' ');
      if (MovieSeriesType = TimeSeries ) then TemStr := 'Time Series'
        else
      if (MovieSeriesType = Z_Stack) then TemStr := 'Z Stack';
      Add('Channels = ' + IntToStr(NrChannels) + ', Scan Mode = ' + TemStr);
      if (NrChannels = 1) then Add('Channel Name: ' + ScopeSystemParams.Ch1_Name)
          else
      if (NrChannels = 2) then begin
          Add('1st Channel Name: ' + ScopeSystemParams.Ch1_Name);
          Add('2nd Channel Name: ' + ScopeSystemParams.Ch2_Name);
      end;
      Add(' ');
    end
      else
    if (MovFType = NIKON_TIFF_MOV) then begin
      Add('Nikon NIS-Elements Multi-Image TIFF File');
      Add(' ');
      Add('Name: ' + ExtractFileName(ImFname));
      Add(' ');
      if (MovieSeriesType = TimeSeries ) then TemStr := 'Time Series'
        else
      if (MovieSeriesType = Z_Stack) then TemStr := 'Z Stack';
      Add('Channels = ' + IntToStr(NrChannels) + ', Scan Mode = ' + TemStr);
      if (NrChannels = 1) then Add('Channel Name: ' + ScopeSystemParams.Ch1_Name)
          else
      if (NrChannels = 2) then begin
          Add('1st Channel Name: ' + ScopeSystemParams.Ch1_Name);
          Add('2nd Channel Name: ' + ScopeSystemParams.Ch2_Name);
      end;
      Add(' ');
    end
      else
    if (MovFType = ANDOR_MOV) then begin
      if (ImageFileType = MULTI_IMAGE) then begin
        GetAndorTIFFNrPagesOrImageDescr(imFName, TemStr,CreatTimeInSec, NrPages,
                                        NrDimensions,GET_ANDOR_IMAGE_DESCR);
        {it used to be if (AnsiContainsStr(TemStr,'Andor')) then
          but newer Andor software do not write this. Changed on Nov 18, 2015}
        if not(AnsiContainsStr(TemStr,'FLUOVIEW')) then
          Add('Andor Technology Multi-Image TIFF File')
            else
        if (AnsiContainsStr(TemStr,'FLUOVIEW')) then
          Add('Olympus Fluoview Multi-Image TIFF File');
      end //if (ImageFileType = MULTI_IMAGE)
        else
      if (ImageFileType = FILE_COLLECTION) then
        Add('Collection of Andor Technology TIFF Files:');
      if (NrIm > 1) and (ImageFileType = SINGLE_IMAGE) then
        Add('Stack of Andor Technology TIFF Files');
      if (NrIm = 1) then
        Add('Andor Technology Single Image TIFF File');
       Add(' ');

      if not(ImageFileType = FILE_COLLECTION) then begin
        Add('Name: ' + ExtractFileName(ImFname));
      end
        else
      if (ImageFileType = FILE_COLLECTION) then begin
        for Cnt := 0 to High(CollFileNames) do begin
          if Not(LoadChAsIndivFiles) then Add(ExtractFileName(CollFileNames[Cnt])) else
          if    (LoadChAsIndivFiles) then begin
            if Not(Odd(Cnt)) then Add('Ch1: ' + ExtractFileName(CollFileNames[Cnt]));
            if     Odd(Cnt) then  Add('Ch2: ' + ExtractFileName(CollFileNames[Cnt]));
          end;
        end;
      end;
      Add(' ');

      if (MovieSeriesType = TimeSeries ) then TemStr := 'Time Series'
        else
      if (MovieSeriesType = Z_Stack) then TemStr := 'Z Stack';
      Add('Channels = ' + IntToStr(NrChannels) + ', Scan Mode = ' + TemStr);
        if (NrChannels = 1) then Add('Channel Name: ' + ScopeSystemParams.Ch1_Name)
          else
        if (NrChannels = 2) then begin
          if not(LoadChAsIndivFiles) then Add('Both channels are contained in same File(s).') else
          if (LoadChAsIndivFiles) then Add('Each channel is contained in individual File(s).' );
          Add('1st Channel Name: ' + ScopeSystemParams.Ch1_Name);
          Add('2nd Channel Name: ' + ScopeSystemParams.Ch2_Name);
        end;
      Add(' ');
    end //if (MovFType = ANDOR_MOV)
        else
    if (MovFType = STACK_BW_TIFF) then begin
        if (TIFFfileType = TIFF_GENERIC) then begin
          Add('Stack of generic TIFF Files');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
        end
          else
        if (TIFFfileType = TIFF_QED) then begin
          Add('Stack of QED TIFF Files');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
        end
          else
        if (TIFFfileType = TIFF_NORAN_PRARIE) then begin
          Add('Stack of Noran (Prarie) TIFF Files');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
        end;
      end
        else
      if (MovFType = SINGLE_BW_TIFF) then begin
        if (TIFFfileType = TIFF_GENERIC) then begin
          Add('Generic TIFF File');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
        end
          else
        if (TIFFfileType = TIFF_ImageJ) then begin
          Add('ImageJ TIFF File');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add('Channels = ' + IntToStr(NrChannels));
          if (NrChannels = 1) then Add('Channel Name: ' + ScopeSystemParams.Ch1_Name)
            else
          if (NrChannels = 2) then begin
            Add('1st Channel Name: ' + ScopeSystemParams.Ch1_Name);
            Add('2nd Channel Name: ' + ScopeSystemParams.Ch2_Name);
          end;

          Add(' ');
        end
          else
        if (TIFFfileType = TIFF_QED) then begin
          Add('QED TIFF File');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
        end
          else
        if (TIFFfileType = TIFF_NORAN_PRARIE) then begin
          Add('Noran (Prarie) TIFF File');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
        end;
      end
        else
    if (MovFType = BIORAD_PIC) then begin
        Add('BioRad (pic) Movie File');
        Add(' ');
        Add('Name: ' + ExtractFileName(ImFname));
        Add(' ');
        if (MovieSeriesType = TimeSeries ) then TemStr := 'Time Series'
          else
        if (MovieSeriesType = Z_Stack) then TemStr := 'Z Stack';
        Add('Channels = ' + IntToStr(NrChannels) + ', Scan Mode = ' + TemStr);
        Add(' ');
        with ScopeSystemParams do begin
          Add('Optical Zoom = ' + FloatToStrF(Optical_Zoom,ffFixed,5,3) + ' x');
          Add('Objective Magnification = ' + IntToStr(Objective_Mag) + ' x');
          Add('Pixel Dwell Time = ' + IntToStr(PixDwell ) + ' ' + PixDwell_Units);
        end;
        Add(' ');
    end
        else
    if (MovFType = NORAN_SGI_MOV) then begin
      Add('Noran  (SGI) Movie File');
      Add(' ');
      Add('Name: ' + ExtractFileName(ImFname));
      Add(' ');
    end
        else
    if (MovFType = ZEISS_CZI_LSM_MOV) then Begin
        if (ExtractFileExt(ImFname) = '.lsm') then begin
          Add('Zeiss (LSM) Movie File');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');

          if (ScanType = X_Y_Z_Scan) then TemStr := 'X,Y,Z_Scan'
            else
          if (ScanType = Time_Series_X_Y) then TemStr := 'Time Series X-Y'
            else
          if (ScanType = Time_Series_X_Z) then TemStr := 'Time Series X-Z' //so far it doesn't open them
            else
          if (ScanType = Line_Scan) then
            TemStr := 'Line Scan, Duration = ' + FloatToStrF(TimeSt[High(TimeSt)],ffFixed,10,3) + ' s';

          Add('Channels = ' + IntToStr(NrChannels) + ', Scan Mode = ' + TemStr);
          if (NrChannels = 1) then Add('Channel Name: ' + ScopeSystemParams.Ch1_Name)
            else
          if (NrChannels = 2) then begin
            Add('1st Channel Name: ' + ScopeSystemParams.Ch1_Name);
            Add('2nd Channel Name: ' + ScopeSystemParams.Ch2_Name);
          end;
          Add(' ');
        end //if (ExtractFileExt(ImFname) = '.lsm')
          else
        if (ExtractFileExt(ImFname) = '.czi')  then begin
          Add('Zeiss (CZI) Movie File');
          Add(' ');
          Add('Name: ' + ExtractFileName(ImFname));
          Add(' ');
          if (MovieSeriesType = TimeSeries ) then TemStr := 'Time Series'
            else
          if (MovieSeriesType = Z_Stack) then TemStr := 'Z Stack'
            else
          if (MovieSeriesType = LineScan) then
           TemStr := 'Line Scan, Duration = ' + FloatToStrF(TimeSt[High(TimeSt)],ffFixed,10,3) + ' s';
          Add('Channels = ' + IntToStr(NrChannels) + ', Scan Mode = ' + TemStr);
          if (NrChannels = 1) then Add('Channel Name: ' + ScopeSystemParams.Ch1_Name)
            else
          if (NrChannels = 2) then begin
            Add('1st Channel Name: ' + ScopeSystemParams.Ch1_Name);
            Add('2nd Channel Name: ' + ScopeSystemParams.Ch2_Name);
          end;
          Add(' ');
          with ScopeSystemParams do begin
            Add('Optical Zoom = ' + FloatToStrF(Optical_Zoom,ffFixed,5,3) + ' x');
            Add('Objective Magnification = ' + IntToStr(Objective_Mag) + ' x');
            Add('Objective Name: ' + ObjectiveName);
            Add('Pixel Dwell Time = ' + IntToStr(PixDwell ) + ' ' + PixDwell_Units);
            Add('Digital Offset Ch 1 = ' + FloatToStrF(DigitalOffsetCh1,ffFixed,5,2));
            if (NrChannels = 2) then
            Add('Digital Offset Ch 2 = ' + FloatToStrF(DigitalOffsetCh2,ffFixed,5,2));
          end;
          Add(' ');
        end; //if (ExtractFileExt(ImFname) = '.czi')
    End; //if (MovFType = ZEISS_CZI_LSM_MOV)

   // Add(''); // leave it emply for space below the title
    Add('Image Dimensions (X & Y) = ' + IntToStr(imXsize) + ' x ' + IntToStr(imYsize) + ' pixels');

    if (PixSettings.FileHasOwnPixSize = True) then
    Add('1 pixel = ' + FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm') else
    Add('Pixel Size is unknown');

    Add('File Bit-depth / Actual Bit-depth = ' + IntToStr(BitCount) + '-bit / ' + IntToStr(8 + shrFact) + '-bit');

    if Not(MovFType in [NORAN_SGI_MOV, StreamPix_MOV]) then begin
      if frmImageControl.ubFileColTable.Tag = 0 then  Add('File Does Not Have Own Color Table')
        else
      if frmImageControl.ubFileColTable.Tag in[1,2] then Add('File Has Own Color Table');
    end;

    if (MovFType in [ANDOR_MOV,NIKON_ND2_MOV,NIKON_TIFF_MOV]) then begin
        if PixSettings.ImageBinning <> 0 then
          Add('Binning = ' + IntToStr(PixSettings.ImageBinning)
                                                   + 'x' + IntToStr(PixSettings.ImageBinning))
            else
          Add('Binning is not recorded in file');
        if (MovFType = ANDOR_MOV) then begin
          if (DimNotTime > -1) then Add('Dimension ' + IntToStr(DimNotTime + 3) + ' - ' + ZstackUnits);
          if (DimTime > -1) then Add('Dimension ' + IntToStr(DimTime + 3) + ' - Time');
        end;
    end; //if (MovFType = ANDOR_MOV)
                  // frmImageControl.FileColTable.Tag = 1

    if (NrIm > 1) then begin
        Add('Total Number of Images/Channel = ' + IntToStr(NrIm));
        if (MovFType = ZEISS_CZI_LSM_MOV) then begin
          if (MovieSeriesType = TimeSeries) then TemStr := ' frm/s'
            else
          if (MovieSeriesType = Z_Stack) then TemStr := ' frm/µm';
        end
          else
        TemStr := ' frm/s';
        Add('Average Frame Rate = ' + FloatToStrF(ExportDial.OrigFrameRate, ffFixed, 5, 3) + TemStr);
    end; //if (NrIm > 1)

    if (MovFType in [NORAN_PRARIE_MOV, NORAN_SGI_MOV]) then begin
        // Some Old Noran SGI did nor record some of these values
        with ScopeSystemParams do begin
          if (PMT_Gain <> -1) then
            Add('PMT Gain = ' + IntToStr(PMT_Gain))
          else
            Add('Not Available');
          if (PMT_Offset <> -1) then
            Add('PMT Offset = ' + IntToStr(PMT_Offset))
          else
            Add('Not Available');
          if (AOD_Power <> -1) then
            Add('AOD (Laser) Power = ' + IntToStr(AOD_Power) + '%')
          else
            Add('Not Available');
          Add('Pixel Dwell Time = ' + IntToStr(PixDwell) + ' ns');
        end; //with
    end; //if (MovFType in [NORAN_PRARIE_MOV, NORAN_SGI_MOV])

    if (MovFType in [NORAN_PRARIE_MOV, QED_MOV, StreamPix_MOV]) then begin
      if (MovFType = NORAN_PRARIE_MOV)          then Cnt := 1
        else
      if (MovFType in [QED_MOV, StreamPix_MOV]) then Cnt := -3;

      if (High(MovieCycleList) > 0) then begin
        TemStr := ' (same frame rate)';
        for i := 1 to High(MovieCycleList) do begin
          if (trunc(MovieFrRateList[i] * 100) <> trunc (MovieFrRateList[i - 1] * 100)) then
          begin // Second digit precision
            TemStr := ' (variable frame rate)';
            Break;
          end;
        end; // for i := 1 to High(MovieCycleList)
          Add('Number of Cycles = ' + IntToStr( High(MovieCycleList) + 1) + TemStr);
       end //if (High(MovieCycleList) > 0)
          else
       if (High(MovieCycleList) = -1) { = nil } then Add('Number of Cycles = ' + IntToStr(1));

       if (High(MovieCycleList) > 0) then begin
          Add(''); // emplty line

          For i := 0 to High(MovieCycleList) do begin
            if (i = 0) then begin
              if TemStr = ' (variable frame rate)' then
                Add('Cycle ' + IntToStr(i + 1) + ' from image 1 ' + ' to image ' + IntToStr
                                (MovieCycleList[i]) + ' (' + FloatToStrF
                                (MovieFrRateList[i], ffFixed, 4,3) + ' frm/s)')
              else

                Add('Cycle ' + IntToStr(i + 1) + ' from image 1 ' + ' to image ' + IntToStr
                                (MovieCycleList[i]));
            end //if (i = 0) then begin
              else
            begin
              if TemStr = ' (variable frame rate)' then
                Add('Cycle ' + IntToStr(i + 1) + ' from image ' + IntToStr(MovieCycleList[i - 1] + 1)
                                + ' to image ' + IntToStr(MovieCycleList[i])
                                + ' (' + FloatToStrF(MovieFrRateList[i],ffFixed, 5, 3) + ' frm/s)')
              else

                Add('Cycle ' + IntToStr(i + 1) + ' from image ' + IntToStr
                                (MovieCycleList[i - 1] + 1) + ' to image ' + IntToStr(MovieCycleList[i]));
            end; //begin

            Inc(Cnt);
            if i < High(MovieCycleList) then Add('Pause = ' +
                                                  IntToStr(round(TimeSt[MovieCycleList[i]] -
                                                  TimeSt[MovieCycleList[i] - 1])) + ' seconds');

        end; //For i := 0 to High(MovieCycleList)
      end; //if (High(MovieCycleList) > 0)
    end; // if (MovFType in [NORAN_PRARIE_MOV, QED_MOV, StreamPix_MOV])

      { now for the Average Image }

    if (AvImExists = 0) then Add('No Average Image Open or Created')
      else
    if (AvImExists = 1) then CreateAverImHelpStr // online Average
      else
    if (AvImExists = 2) then begin // from File
      // 1st checks if this is Generated Average//
      if (AnsiContainsStr(AvImInfoStr, 'Minimum')) then Add('Generated Average: ' + AvImInfoStr)
        else
      begin
      // Fill In AvImList, Pass it to PackHelpStr and finally Clean it
        for Cnt := 1 to Length(AvImInfoStr) do begin
          if (MemBeg = 0) and (AvImInfoStr[Cnt] = '=') then MemBeg := Cnt + 1;
          if (AvImInfoStr[Cnt] = ',') then begin
            AvImList[StrToInt(Copy(AvImInfoStr, MemBeg,Cnt - MemBeg)) - 1] := 1;
            MemBeg := Cnt + 2;
            Inc(ImSel);
          end; //if (AvImInfoStr[Cnt] = ',')
          if (Cnt = Length(AvImInfoStr)) then begin
            AvImList[StrToInt(Copy(AvImInfoStr, MemBeg,Length(AvImInfoStr) - MemBeg + 1)) - 1] := 1;
            Inc(ImSel);
          end;//if (Cnt = Length(AvImInfoStr))
        end; // for Cnt := 1 to Length(AvImInfoStr)

        CreateAverImHelpStr;
        // Clean AvImList
        i := 0;
        for Cnt := 0 to High(AvImList) do begin
          if (AvImList[Cnt] > 0) then begin
            AvImList[Cnt] := 0;
            Inc(i);
          end;
          if (i = ImSel) then
            Break;
        end; //for Cnt := 0 to High(AvImList)
        ImSel := 0;
      end; //else begin
    end //if (AvImExists = 2) then begin
      else
    if (AvImExists = 3) then Add('Generated Average: ' + AvImInfoStr);// generated average

  End; //Case HelpCode of 2:
  End; //Case HelpCode of 2:
  { -- End of Info on Movies properties --- }
  { ------------------------------------------------------------------------------------------- }
  Case HelpCode of 3:
  begin

      Add('Keeps duration of the clip equal on input and output,');
      Add('even if the frame rate is different. Enables "Decrease Speed".');
      Add('This is achieved by duplicating (if input rate < output rate)');
      Add('or dropping (if input rate > output rate) frames.');
      Add('One way to avoid dropping of frames is to set');
      Add('playback mode to "2 im as 1" or "4 im as 1".');
  End; //Case HelpCode of 3
  End; //Case HelpCode of 3

            Case HelpCode of
              4:
                begin
                  // MPEG-1 Standard Size = 352x240 = 84480 pixels

                  Add('Limiting bitrate affects images > 84480 pixels (X x Y)');
                  Add('or with frame rate > 30 im/s (frm/s), resulting in');
                  Add('smaller file size but poorer quality.');
                  Add('Image size can be reduced by using Zoom(-).');
                end;
            end;

            Case HelpCode of
              5:
              end; { Dummy Number, Used to Get Help on C drive Serial Number }

              Case HelpCode of
                6:
                  begin
                    Add(
                      'Decreases speed by increasing the duration of the clip.'
                      );
                    Add('This is achieved by repeating frames.');
                    Add('This option works if "Keep Duration" is enabled.');
                  end;
              end;

              Case HelpCode of
                7:
                  begin
                    Add
                      ('The playback speed is equal to the effective duration ');
                    Add('of the movie divided by the duration of MPEG movie. ');
                  end;
              end;
              { -------------- From Here SPAutoserach Help --------------------------------- }
              Case HelpCode of
                8:
                  begin
                    Add('Sets the Threshold to recognize an event ');
                    Add('Recommended value ~1.3 F/Fo.');
                  end;
              end;
              Case HelpCode of
                9:
                  begin
                    Add('Sets Tolerance for the threshold');
                    Add('Recommended value 0% - 30%.');
                  end;
              end;

              Case HelpCode of
                10:
                  begin
                    Add('Sets Size of the Scanning Box');
                    Add('Recommended value 7x7 - 9x9 pixels.');
                  end;
              end;

              Case HelpCode of
                11:
                  begin
                    Add('Sets a size Cutoff (in square pixels)');
                    Add('to separate "Small" from "Big" Events');
                    Add('such as Ca sparks from Ca waves.');
                  end;
              end;

              Case HelpCode of
                12:
                  begin
                    Add('Supresses Flicker.');
                    Add('Should be disabled in absence of flicker.');
                  end;
              end;

              Case HelpCode of
                13:
                  begin
                    Add('Used to track "Big" events, such as Ca waves.');
                    Add('Number of images should be set to the minimal');
                    Add('duration of the events.');
                    Add('It can be also useful to reconsile "Small"');
                    Add('events such as Ca sparks and Pulsars if the');
                    Add('intensity drops temporarily below the Threshold.');
                    Add('In this way it would help preventing regestering');
                    Add('same event twice.');
                  end;
              end;

              Case HelpCode of
                14:
                  begin
                    Add('Used to reject "hot" pixels which');
                    Add('may appear in images aquired with');
                    Add('intensified CCD cameras.');
                    Add('Value should be set to the ');
                    Add('average intensity of "hot" pixels');
                    Add('Should be disabled in absence of "hot" pixels.');
                  end;
              end;

              Case HelpCode of
                15:
                  begin
                    Add(
                      'Used to reject falsely picked "small" events by analysing time segments before (L) and ');
                    Add(
                      'after the peak (R).  Set the time for Search in ms in the respective windows');
                    Add(
                      'Program searches for a minimum which is a mean of 1 or more consecutive points (images)');
                    Add(
                      'defined in "Min" window.  Event qualifies as such if its peak value minus the left and');
                    Add(
                      'right minimums is higher then the threshold - 1.  In addition, an Event is required to have');
                    Add(
                      'consecutive points that exceed the threshold defined in "Event" window.');

                  end;
              end;

              Case HelpCode of
                16:
                  begin
                    Add('Alternative way of detecting "small" events');
                    Add('Use only in case of low activity and');
                    Add(
                      '"small" size and short duration (one - two images) of events.');
                  end;
              end;

              Case HelpCode of
                17:
                  begin
                    Add('If enabled, all events');
                    Add('will be cosidered "small" events');
                    Add('independent of the size Cutoff.');
                  end;
              end;

              Case HelpCode of
                18:
                  begin
                    Add('If enabled, the image number');
                    Add('corresponding to a peak');
                    Add('will appear in "Small" and "Big" tables.');
                  end;
              end;

              Case HelpCode of
                19:
                  begin
                    Add('If enabled, the image number');
                    Add('corresponding to the beginning of a peak');
                    Add('will appear in "Small" and "Big" tables.');
                  end;
              end;

              Case HelpCode of
                20:
                  begin
                    Add('This option should be used only when is');
                    Add('impossible to create an Average image');
                    Add('by manual selection of images without activity,');
                    Add('i.e. if activity is present in all the frames.');
                    Add(
                      'It constructs an Average image from the minumum found in'
                      );
                    Add(
                      'consecutive images which number is set by the scrollbar.'
                      );
                  end;
              end;

              Case HelpCode of
                21:
                  begin
                    Add(
                      'Queue File Table is used to place several files for "batch"');
                    Add(
                      'Event Auto Detection. Detection parameters can be set individually.');
                    Add('Table can be saved as text file and reopen later.');
                    Add('This alows files to be analyzed (sequentially)');
                    Add('when computer is not in use, i.e. overnight.');
                    Add('All the output files will be written automatically.');
                    Add(
                      'These include: "Mark files used by "Small" and "Big" events Tables,');
                    Add('and Frequency of events.');
                    Add('Columns can be moved to left and right.');
                  end;
              end;

              Case HelpCode of
                22:
                  begin

                    Add('Event Auto Detection panel and "Small" and "Big" events tables description');
                    Add('Event Auto Detection was created for primerily for detection of small, stationary, spatially limited events which');
                    Add('time coarce resembles poeaks such as Ca sparks and Ca pulsars but not Ca sparklets which have squarish');
                    Add('time coarse.  They are sent to the "Small Events" table.  Bigger in size events such as Ca waves and');
                    Add('oscillations can also be detected and they are sent to the "Big Events table.');
                    Add('' );
                    Add('Event Auto Detection works only with pseudo-ratio images. Pseudo-ratio images are generated by division of');
                    Add('each image by an "Average" image created by careful selection of  several images without activity. Use buttons');
                    Add('located on Playback panel to select one, the current image (S1), or 10 consecutive images (S) starting from');
                    Add('the current, or deselect one, the current image (D1) or 10 (D) images.  If current image is selected, "S" appears');
                    Add('on the right of the image number/time display located on Playbeck panel.  Additional information on all images');
                    Add('selected could be obtained by pressing "Get File Info" button on Main Menu.  Average image can be saved');
                    Add('to a file along with info on origin and frame numbers, and can be used later. In this case, "F" appears instead of "S"');
                    Add('If activity is present in all frames, Average images can be created automatically.  It is created by averaging of');
                    Add('of consecutive images that have a minimum value, number set on the "Min Of" window, in a range of images defined');
                    Add('on the "From the Range Of" window.  This is done repeatedly after defined number of images defined as "Every".');
                    Add('Athough not neeeded for analysis, averaged images can be saved to files.  Average image can be generated manually');
                    Add('by  clicking on "Create Manually" at the bottom of the panel can be used. In this case, the images to be used');
                    Add('are chosen from the Slider on the Top of the panel.  In all cases Average image is generated by searching for the minimum');
                    Add('of consecutive number of images selected by "Min Of" window. At end of the search a final average image is created for');
                    Add('the whole search range.  If "Final Cutoff = 0" is checked then this final Average image is done with Cutoff set to zero');
                    Add('Images must be filtered by Adjacent (boxcar) & Median filters.  It is very important to set the Background');
                    Add('(offset) located on "Image Settings & Tools" panel to the intensity value recorded in absence of signal or');
                    Add('to the intensity measured away from the object or in the absence of signal.  "1" and "2" refer to 1st and 2nd channel,');
                    Add('respectively.  Type the value in the respective windows.  The sliders are for fine adjustment only.');
                    Add('If the object does not cover the whole field the Cutoff the slider located below "Bkg" slider must be set');
                    Add('higher then zero until the halo around the object disappear. The most used smoothing is 1st Box 5x5 followed by Medium 5x5.');
                    Add('More help can be obtained by clicking the right mouse button on widget titles.');
                    Add('Files can be placed in "Queue File Table" for "batch" analysis.');
                    Add('Please, ensure enough free drive space because during search images are saved to 32 bit float format in');
                    Add('a temporary file, "TempRatFile", in the same folder which is automatically deleted after.  Computer Power');
                    Add('settings are disabled during analysis');
                    Add('');
                    Add('There are three major steps in "Small" and "Big" events detection.');
                    Add('Initially the Events are detected by using the appropriate settings for "Thresh", "Tolerance", "Scan box" size,');
                    Add('The effect of the settings can be tested on current image by pressing the Red circle depicting the size of');
                    Add('the Small events with F/Fo below Threshold');
                    Add('');
                    Add('Next step is performing "Small events Test" which is a peak analysis of traces originating from ROI positioned at');
                    Add('the centers of the "Small events" detected by the previous step. If ROI size is determined by "Use ROI = " or');
                    Add('if not checked by the size of "Scan Bx". Baseline determined finding the minimum value of averaged consecutive');
                    Add('number of images "Left" to the peak "Within (ms)".  The baseline is subtracted from the peak. If corrected peak');
                    Add('value is higher than Theshold and eventually times "Use SD=") the peak passes the test. Next the minimum value of');
                    Add('averaged consecutive number of images "Right" to the peak "Within (ms)" is determined.  Again, to pass the test');
                    Add('the peak minus minimum should exceed the Treshold.  Here the "Use SD = " does not paly role.  Additionally, number');
                    Add('of points left and right to the peak should and their % of peak should be specified.  If Average file was created');
                    Add('automatically "Update F/Fo" should be checked.   The "Big" events are not tested with trace analysis.  It is helpful');
                    Add('to check "Running Average" of 5 or more images. This helps to isolate the "Big" events which are typically slower');
                    Add('than the "Small" events. It can be also useful to reconsile "Small" events such as Ca sparks and Pulsars');
                    Add('if the intensity drops temporarily below the Threshold. In this way it would help preventing regestering same event twice.');
                    Add('');
                    Add('The last step determines the Amplitude, Rise Time (10% -90% of the peak), Duration and Decay at half peak amplitude');
                    Add('Note, that the ROI size is set by the "Box" (which could be rectangular) in the "Image Settings & Tools" panel.');
                    Add('These final values are placed in "Small" and "Big" events tables.');
                    Add('');
                    Add('Clicking with the left mouse button on "Small" and "Big" events tables places a rectangular ROI on image and generates');
                    Add('a ROI trace with duration specified in the dropdown menu and analysis mode specified in Time Series Plot dropdown menu.');
                    Add('To delete a row, first select it by clicking on the row selection.  Selected rows can used to place rectangular');
                    Add('ROI on marks contained in these rows (up to 20).  Additionally, these rows can be updated (amplitude) selectively.');
                    Add('Update is used when analysis mode has been changed or dimensions of rectangular ROI in "Image Settings & Tools"');
                    Add('panel have changed. "Update" button updates all rows.  "Small" and "Big" events tables can be saved to text files');
                    Add('and can be reopened later.');
                  end;
              End;

              Case HelpCode of
                23:
                  begin
                    Add('F/Fo or Channel Ratio value to be displayed with maximal brightness');
                    Add('for Pseudo-ratio images.');
                  end;
              end;

              Case HelpCode of
                24:
                  begin
                    Add('Used for creation of pseudo-ratio images and');
                    Add('generation of "Area/min" traces from ROI');
                    Add('Set Background (offset) for Channels 1 and 2 (indicated as 1 and 2)');
                    Add('to the intensity value recorded in absence of signal or');
                    Add('to the intensity measured away from the object.');
                  end;
              end;

              Case HelpCode of
                25:
                  begin
                    Add('Used for creation of F/Fo (pseudo-ratio) images when smoothing is on');
                    Add('and the object does not cover the whole image field.');
                    Add('Sets the pixels in the Average Image lower than the Cutoff value to "0"');
                    Add('Set Cutoff (offset) higher then zero until the halo around the object');
                    Add('object disappear.');
                  end;
              end;

              Case HelpCode of
                26:
                  begin
                    Add('Enables Adjacent (boxcar) filter');
                    Add('The higher the number - the heavier the smoothing.');
                  end;
              end;

              Case HelpCode of
                27:
                  begin
                    Add('Enables Median filter for');
                    Add('The higher the number - the heavier the smoothing.');
                  end;
              end;

              Case HelpCode of
                28:
                  begin
                    Add('Enables creation of pseudo-ratio images.');
                    Add(
                      'Pseudo-ratio images are generated by division of each image');
                    Add(
                      'by an "Average" image created by careful selection of  several');
                    Add(
                      'images without activity. Average image can be saved to a file for');
                    Add(
                      'later use or be used with a different movie if the size is the same.');
                    Add(
                      'F/Fo mode works together with "F/Fo", "Bkg" (background or offset),');
                    Add(
                      '"Cutoff" scrollbars and smoothing filters (recommended)'
                      );
                    Add(
                      'It is very important to set the Background to the intensity value');
                    Add(
                      'recorded in absence of signal or to the intensity measured');
                    Add('away from the object.');
                  end;
              end;

              Case HelpCode of
                29:
                  begin
                    Add('Enables Selection frame to export part');
                    Add('of the images as Windows Bitmap or movies.');
                    Add('To change frame depress "Selection Frame Adjustment" button');
                  end;
              end;

              Case HelpCode of
                30:
                  begin
                    Add('Sets the min and max of the range double scrollbar');
                    Add('to the min and max pixel values in current image.');
                  end;
              end;

              Case HelpCode of
                31:
                  begin
                    Add('Sets the Contrast (slope) of the color table');
                    Add('The number on the right shows the number of colors.');
                    Add
                      ('It is preferable to first use Range adjustment unless');
                    Add('special effects are needed.');
                    Add('The relationship between input (source) values and');
                    Add('output (display) is shown on the window above.');
                  end;
              end;

              Case HelpCode of
                32:
                  begin
                    Add(
                      'Shifts the color table by the value shown on the right.'
                      );
                    Add('The number of colors avaliable always decreases');
                    Add('if value is different from zero.');
                    Add('The relationship between input (source) values and');
                    Add('output (display) is shown on the window above.');
                  end;
              end;

              Case HelpCode of
                33:
                  begin
                    Add('Changes the color table by applying nonlinear');
                    Add('transfer fuction according to the equation:');
                    Add('Output = Input ^Gamma.');
                    Add('It does not have an effect if value is equal to one.');
                    Add('The relationship between input (source) values and');
                    Add('output (display) is shown on the window above.');
                  end;
              end;

              Case HelpCode of
                34:
                  begin
                    Add(
                      'Range controls group is used to select subrange of data'
                      );
                    Add('in 16-bit grayscale images for display.');
                    Add(
                      'This is needed because the current technology is incapable');
                    Add(
                      'of displaying more than 256 shades of grays on the monitor.');
                    Add(
                      'The minimal difference between max and min range values is 256.');
                    Add(
                      'In case narrower range is needed, set Contrast scrollbar to less then 255,');
                    Add('otherwise is preferable to keep it to 255.');
                    Add(
                      'The histogram displays the image data as pixels counts with same value.');
                    Add(
                      '"Get" button sets the lower and upper range bounds to the minimal and');
                    Add('maximal pixel values of current image.');
                    Add(
                      '"Auto" button causes the program to refresh range to the first image');
                    Add('every time a new file is loaded.');
                    Add
                      ('"Z" button sets min and max (zooms) of range scrollbar');
                    Add(
                      'to the minimal and maximal pixel values of current image.');
                  end;
              end;

              Case HelpCode of
                35:
                  begin
                    Add('Moves and deletes any single ROI. Moves Scale Bar');
                    Add(
                      'Left mouse button - move ROI and Scale Bar, and refreshes mean ROI value in Playback window.');
                    Add(
                      'Right mouse button refreshes mean ROI value in Playback window and');
                    Add(
                      'redraws with thicker line ROI and corresponding trace in Plot window.');
                    Add('Middle mouse button - deletes any ROI');
                  end;
              end;

              Case HelpCode of
                36:
                  begin
                    Add('Moves all ROIs together as a group');
                    Add('Left mouse button - Moves all ROIs.');
                    Add('Right mouse button - no function.');
                    Add('Middle mouse button - no function.');
                  end;
              end;

              Case HelpCode of
                37:
                  begin
                    Add('Places Marks on image.');
                    Add('The size of gray rectange is set by sliders below.');
                    Add(
                      'No mouse button pressed - displays mean value of pixels.'
                      );
                    Add('whitin gray rectangle.');
                    Add('Left mouse button - places a "small" event mark.');
                    Add('Right mouse button - places a "big" event mark.');
                    Add('Middle mouse button - deletes a mark.');
                    Add('If "Dotted" box button is depressed then marks are');
                    Add
                      ('placed at a position within dotted rectangle where the');
                    Add(
                      'rectangle defined by "Rectangle" tool has maximum mean value.');
                    Add(
                      'If F/Fo is depressed and Smoothing is used then if the "2d filter');
                    Add('located on the Time series plot is not checked then');
                    Add(
                      'Non-Smoothed image is used for the maximum mean value search.');
                    Add(
                      'Image number, coordinates of marks and mean values are displayed in');
                    Add('Small" and "Big" events tables.');
                    Add(
                      'Again, the amplitude is mean value of rectangle defined by');
                    Add(
                      '"Rectangle" tool, not the rectangle of the "Mark" tool.'
                      );
                  end;
              end;

              Case HelpCode of
                38:
                  begin
                    Add('Places rectangle ROIs on image.');
                    Add('The size of ROIs is set by sliders below.');
                    Add
                      ('Left mouse button - places ROI at center of cursor and');
                    Add(
                      'ROI could be dragged untill the mouse button is released.');
                    Add(
                      'Right mouse button - centers existing ROI at cursor position');
                    Add('and allows dragging.');
                    Add('Middle mouse button - deletes a rectangle ROI.');
                    Add
                      ('If "Dotted" box button is depressed then ROI is placed');
                    Add('at a position within dotted rectangle where ROI has');
                    Add('maximum mean value.');
                    Add(
                      'If F/Fo is depressed and Smoothing is used then if the "2d filter');
                    Add('located on the Time series plot is not checked then');
                    Add(
                      'Non-Smoothed image is used for the maximum mean value search.');

                  end;
              end;

              Case HelpCode of
                39:
                  begin
                    Add('Allows drawing of a freehand ROI on image.');
                    Add(
                      'To begin - press left mouse button on image, draw ROI and');
                    Add(
                      'release when current cursor position comes close to the beginnig.');
                    Add('The ROI will close automatically.');
                    Add(
                      'Right mouse button refreshes mean ROI value in Playback window and');
                    Add('and cross-hatches ROI.');
                    Add('Middle mouse button - deletes a freehand ROI.');
                  end;
              end;

              Case HelpCode of
                40:
                  begin
                    Add('Selection Frame Adjustment.');
                    Add('Depress left mouse button to change frame on image.');
                    Add('To apply frame use Apply frame button.');
                  end;
              end;

              Case HelpCode of
                41:
                  begin
                    Add('Enables placing marks or rectangular ROI at');
                    Add('a position within dotted rectangle where');
                    Add('the rectangle defined by "Rectangle" tool has');
                    Add('maximum mean value.');
                    Add('"Mark" or "Rectangle ROI" must be depressed first.');
                  end;
              end;

              Case HelpCode of
                42:
                  begin
                    Add('Sets irreversibly the pixels outside ROIs in Average');
                    Add('image to zero.  The corresponding pixels in');
                    Add('pseudo-ratio image are also set to zero.');
                    Add('Used to hide unwanded image regions');
                  end;
              end;

              Case HelpCode of
                43:
                  begin
                    Add('Sets reversibly the pixels outside ROIs in Main');
                    Add('image to zero.  The corresponding pixels in');
                    Add('pseudo-ratio image are also set to zero.');
                    Add('Used to hide unwanded image regions');
                  end;
              end;

              Case HelpCode of
                44: { General Help for Time Series Plot }
                  begin
                    Add('Time series plot panel description');
                    Add(
                      '"Process" scrollbar sets the range for analysis.  "X axes"  scrollbar sets the trace range to be displayed.');
                    Add(
                      '"Analysis mode" dropdown menu offers the fololowing modes.');
                    Add(
                      '"Area" calculates mean intensity for each ROIs over time.  This option works with non-ratioed images while');
                    Add('the rest require pseudo-ratio images.');
                    Add(
                      '"Area/Area" calculates mean F/Fo of ROI by first obtaining the means of ROIs in every image and Average image');
                    Add('and then divides them.');
                    Add(
                      '"Pix/Pix" - mean F/Fo of ROI by first dividing pixel by pixel for each ROI and them calculates means for each ROI');
                    Add(
                      '2D filter option enables use of filtered image data.  Additionally, traces coud be smoothed by Adjacent averaging');
                    Add('with variable number of points (3 - 11).');
                    Add(
                      'An alternative way to generate F/Fo traces is to use "Area/min" option which works with non-ratioed images.');
                    Add(
                      'It first obtaines mean intensity for each ROI.  Next, finds the minimum for each trace for number of consecutive');
                    Add(
                      'points specified in "Points" window and calculates the mean of these points.  Finally, each trace is divided by');
                    Add(
                      'the corresponding minimums.  The range to find minimum can be selected and locked by "Hold" button.');
                    Add(
                      '"Get peaks" enables peak detection after trace generation has been done.  If trace smoothing has been changed');
                    Add(
                      'or "Get peaks"  was not enabled before trace generation, use "Do" button to refresh or get peaks.  Peak qualifies');
                    Add(
                      'as such if its value minus the left and right minimums is higher then the threshold .  However, amplitudes are always');
                    Add(
                      'calculated from F/Fo = 1.00. This is valid also for half time of decay, and duration at half amplitude.  Peak analysis');
                    Add(
                      'results are displayed on the non-editable "Peak table" and can be saved to text file. Option "Export Peaks" saves');
                    Add(
                      'the peaks from total length of visible traces while "Export Peak Means" saves the peaks means from the visible portion');
                    Add('of the visible traces');
                    Add(
                      'Vertical measuring cursor can be assigned a trace number by the dropdowm nenu or by clicking with the right mouse');
                    Add('button on the corresponding trace on/off button.');
                    Add(
                      'In addition to X zoom buttons, X axis can be zoomed by selection of portion of the plot by depressing left mouse');
                    Add('button on the plot and dragging to the right.');
                  end;
              end;

              Case HelpCode of
                45:
                  begin
                    {

                      Add('Sets reversibly the pixels outside ROIs in Main');
                      Add('image to zero.  The corresponding pixels in');
                      Add('pseudo-ratio image are also set to zero.');
                      Add('Used to hide unwanded image regions');

                      Add('Used to reject falsely picked "small" events');
                      Add('by analysing time segments before and after the peak.');
                      }
                  end;
              end;

              Case HelpCode of
                46:
                  begin
                    Add('Enables Gausian filter');
                    Add('The higher the number - the heavier the smoothing.');
                    Add('3L: 3x3 Light, SD = 0.49');
                    Add('3M: 3x3 Medium, SD = 0.60');
                    Add('3H: 3x3 Heavy, SD = 0.85');
                    Add('5x5, SD = 1.0');
                    Add('7x7, SD = 1.5');
                  end;
              end;

              Case HelpCode of
                47:
                  begin
                    Add('Adopted from "Kalman Stack Filter" plugin for ImageJ');
                    Add('by Christopher Philip Mauer (2003)');
                  end;
              end;

              Case HelpCode of
                48:
                  begin
                    Add('Displays Event Sites in Current image');
                    Add('as identified by the Filter with');
                    Add('Parameters: Threshold, Tolerance, and Scanbox');
                    Add('Left button: displays Event Sites and their Pixel size');
                    Add('Midddle button: displays just the Event Sites');
                  end;
              end;

              Case HelpCode of
                49:
                  begin
                   // Fc =(0.1325*Fs)/SD
                    Add('Fc = ' + FloatToStrF(Get1DGaussFc,ffFixed, 5, 2) + ' Hz');
                  end;
              end;

              Case HelpCode of
                50:
                  begin
                   // Fc =(0.1325*Fs)/SD
                    Add('If channels are Two, Enables Pseudo-Linescan of the Merge Window Images.');
                    Add('Othewise Linescan is Performed on Images Displayed on the main Wimdow');
                  end;
              end;

              Case HelpCode of
                51:
                  begin
                    Add('Sets X tolerance of Track ROI.' );
                    Add('It is distance to the left and right in pixels ROI is allowed to move');
                  end;
              end;

              Case HelpCode of
                52:
                  begin
                    Add('Sets Y tolerance of Track ROI.' );
                    Add('It is distance to the top and bottom in pixels ROI is allowed to move');
                  end;
              end;

              Case HelpCode of
                53:
                  begin
                    Add('Local equalization in time.' );
                    Add('Normalizes each pixel individually in time' );
                    Add('to the maximal pixel value found in time or' );
                    Add('to the maximal range allowed.' );
                  end;
              end;

              Case HelpCode of
                54:
                  begin
                    Add(' ');
                    Add('''MP4'', ''FLV'' and ''MOV'' are x264 encoded, ''profile High, level 4.1'', encoding speed ''very slow''');
                    Add(' ');
                    Add('Constant Bitrate: A higher value gives a higher quality.');
                    Add(' ');
                    Add('"Constant Rate Factor (CRF) can be used for ''mp4'', ''flv'' and ''mov'' movies');
                    Add('A lower value is a higher quality and a subjectively sane range is 18-28.');
                    Add('This method allows the encoder to attempt to achieve a certain output quality' );
                    Add('for the whole file when output file size is of less importance.' );
                    Add('This provides maximum compression efficiency with a single pass.' );
                    Add('Each frame gets the bitrate it needs to keep the requested quality level.' );
                    Add('The downside is that you can''t tell it to get a specific filesize' );
                    Add('or not go over a specific size or bitrate.');
                    Add('The range is exponential, so increasing the CRF value +6 is roughly');
                    Add('half the bitrate while -6 is roughly twice the bitrate.');
                    Add('General usage is to choose the highest CRF value that still provides an acceptable quality.');
                    Add('If the output looks good, then try a higher value and if it looks bad then choose a lower value."');
                    Add('-from ffmpeg.org');
                  end;
              end;

              Case HelpCode of
                55:
                  begin
                    Add(' ');
                    Add('This panel finds the number of erythrocytes represented by dark Stripes in line scan of a vessel.');
                    Add('It generates a yellow trace from the selected part of the width of the line scan using the top left blue');
                    Add('double slider.  The right double slider is used to select the minimum and maximum of the trace to');
                    Add('generate an idealized cyan trace by using 50% amplitude threshold-crossing algorithm.  Enable "50%" check box');
                    Add('to visualyze 50% amplitude as dash line.  First the strips have to be straighten if needed by ');
                    Add('adjusting approximately the angle visualized by a line.  Next, smoothing must be applied such as');
                    Add('Kalman or “As Set” by the Image Control panel.  Recommended “As Set” is: 5 M followed by 5 B.');
                    Add('Filters can be applied one after another several times as needed.  The results can be binned in the' );
                    Add('Bin Table. When the Bin table is filled, clicking on the Rows of the "Range" column sets the Time range');
                    Add('of screen to the Time Range of this Bin');
                    Add('Bad parts of the image can be rejected by selecting them by the left mouse button' );
                    Add('in the field outlined by two blue lines located most right of the black window.  They can be moved' );
                    Add('and resized.  By clicking outside or on selection all or one selection can be deleted.  Another way' );
                    Add('to correct for some image irregularities is to disregard stripes less or equal to predefined number of pixels.' );
                    Add('Trace baseline outside the dark stripes can be straighten by pressing "Correct Baseline" button.  This option');
                    Add('is useful if blood brightness fluctuates because of focus changes.  The brightest part of the trace is set at the');
                    Add('maximum of the right double slider.  The vertical slider is used to navigate vertically through the image.');
                    Add('The Up and Down arrow keys move by 1 pixel and PageUp and PageDown by 10 pixels.  The arrows buttons on');
                    Add('the top right part of the panel move by one window.  Reload button or “Channel to Analyze” reloads “Raw” image.');
                    Add('View channel does not.  X and Y sliders shrink the image in X and Y direction, respectively.  Enable');
                    Add('"Keep Y center" check box, located below the Y slider, to keep image center stationary while zooming.');
                    Add('Otherwize, the top of the image will be stationary.  The width of the images must be divisible by 4.');
                    Add('Independent of the width of an image it always be displayed as 512 pixels wide.');
                    Add('When Line Scan is ON, the Main, Secondary and merge windows are not updated when image settings in Image');
                    Add('Control panel are changing.  This allows for faster update of the Line Scan Image');
                  end;
              end;

              Case HelpCode of
                56:
                  begin
                    Add(' ');
                    Add('This panel finds the Two-dimensional Spatial Spread at Half Maximum Amplitude, i.e., the Two-dimensional ');
                    Add('Full Width at Half Maximum (FWHM).  First the Maximum amplitude is determined by scanning the dotted rectangle');
                    Add('with adjustable "Measure Amplitude with Rectangle (X  Y):".  It is typically 3x3 pixels.  This usually is about');
                    Add('0.8 µm which typically is the resolution of most Nipkow disc confocal microscopes combined with water dipping.');
                    Add('objectives.  Using 1x1 or 2x2 pixels would be unrealistically small.  Using larger rectangle could underestimate');
                    Add('maximal amplitude and overestimate the spatial spread.  Reasonable 2D smoothing must be applied on F/Fo images.');
                    Add('Non-ratioed images can be analyzed without smoothing.  It is assumed that the baseline of F/Fo images is 1.0 F/Fo.');
                    Add('For non-ratioed images the user have to measure the intensity of baseline value and type it in the Baseline box.');
                    Add('Place "Mark" or "Rectangle" on the the "Image Settings && Tools" panel should be selected and then the dotted box');
                    Add('(measure box).  The dotted box size should be large enough to encompass the entire event plus some of the baseline.');
                    Add('The dotted box should not include more than one event because the function cannon distinguish between one or more');
                    Add('events.  The measurement starts with pressing the middle mouse button. Once the maximal amplitude is determined' );
                    Add('the number of pixels > half maximal amplitude are counted.  For visualization of the spread, the pixels <= ' );
                    Add('half maximal amplitude in the dotted box are set to black color.  The spatial spread in several (up to 99) consecuteve' );
                    Add('images can be calculated using the Same maximal amplitude found in the First selected image.  If the "Do For:" images' );
                    Add('is set to more than one a dialog appears "Proceed One by One, Cancel or Process All?".  If "Yes" is selected the images' );
                    Add('are processed and reviewed one by one, and it can be cancelled at any time.  If ":All" is selected, images are processed');
                    Add('in non-stop fashion.  Right clicking on any table row evokes "Delete Row, Cancel or Clear Table" menu.  The table can');
                    Add('be saved as text file by going to the Main menu -> File-> Spatial Spread File-> Save Spatial Spread File.  The numbers');
                    Add('are separated by tabs which makes easier to be imported in Excel or other spreadsheet programs.  The work can be');
                    Add('continued provided that Spatial Spread results have been saved.  First the image file should be opened and then the');
                    Add('Spatial Spread file by goiing to the Main menu -> File-> Spatial Spread File-> Open Spatial Spread File.  The panel');
                    Add('can be expanded by dragging with the mouse to 1500 x 800 pixels.  The Table gives the consecutive number of the Row,');
                    Add('the first image number where the maximal amplitude is determined, the X and Y position of the maximal amplitude,');
                    Add('the maximal amplitude value followed by the Spatial spread for the first image and the consecutive images if opted for.');
                  end;
              end;

              Case HelpCode of
                57:
                  begin
                    Add('Range to set to White or Black any Color table starting from "O".');
                    Add('To activate press the White or Black Buttons on the upper right of the panel');
               end;
              end;



              { -------------- End with SPAutoserach Help --------------------------------- }
              { ------------------------------------------------------------- }
              if (frmHelp = nil) then Application.CreateForm(TfrmHelp, frmHelp);

            end; // With HELP_SrtList Do begin

End; //Procedure GetHelp(Const HelpCode: Integer);
 {**********************************************************************}
function Get1DGaussFc : Double;
var SD : Double;
begin
{ SD := 0.1325/(Fc/Fs);
  Fc = (0.1325*Fs)/SD;
  Fc is Corner Frquency
  Fs is Sampling Frequency
  Fs = ExportDial.OrigFrameRate
  Fc = FcGaussFlt
}

 with TimPltSlid do begin
  if (SmTrGaussIndex = 1) then SD := 0.5
    else
  if (SmTrGaussIndex = 2) then SD := 0.600561205
    else
  if (SmTrGaussIndex = 3) then SD := 0.84932181
    else
  if (SmTrGaussIndex = 4) then SD := 1.0
    else
  if (SmTrGaussIndex = 5) then SD := 1.5
    else
  if (SmTrGaussIndex = 6) then SD := 2.0
    else
  if (SmTrGaussIndex = 7) then SD := 2.5
    else
  if (SmTrGaussIndex = 8) then SD := 3.0;
 end;

 Result := (0.1325*ExportDial.OrigFrameRate)/SD;

end; //function Get1DGaussFc : Double;

{ ***************************************************************************** }
Procedure CreateAverImHelpStr;

var i, Cnt, Prev, MemBeg: Integer;
    TemStr: AnsiString;

Begin

            with HELP_SrtList do
            begin

              if (AvImExists = 1) then
              begin
                Add('On Line Average');
              end
              else if (AvImExists = 2) then
              begin
                MemBeg := LastDelimiter(';', AvImInfoStr);
                Add('Average from File, ' + AnsiLeftStr(AvImInfoStr, MemBeg - 1));
                MemBeg := LastDelimiter('=', AvImInfoStr);
              end;

              // Common for Both:
              if ImSel = 1 then
                TemStr := IntToStr(ImSel) + ' Image Selected = '
              else if ImSel > 1 then
                TemStr := IntToStr(ImSel) + ' Images Selected = ';

              i := 0;
              Prev := 0;
              MemBeg := 0;

              For Cnt := 1 to NrIm Do
              Begin

                If (AvImList[Cnt - 1] = 1) then
                begin
                  Prev := Cnt;
                  if MemBeg = 0 then
                    MemBeg := Cnt;
                  Inc(i);
                End
                Else // If AvImList[Cnt] = 1

                  If (AvImList[Cnt - 1] = 0) and (MemBeg > 0) then
                begin

                  if Prev > MemBeg then
                  begin
                    if (i = ImSel) then
                      TemStr := TemStr + IntToStr(MemBeg) + '-' + IntToStr(Prev)
                    else
                      TemStr := TemStr + IntToStr(MemBeg) + '-' + IntToStr
                        (Prev) + ', ';
                  end
                  else if Prev = MemBeg then
                  begin
                    if (i = ImSel) then
                      TemStr := TemStr + IntToStr(MemBeg)
                    else
                      TemStr := TemStr + IntToStr(MemBeg) + ', ';
                  end;
                  MemBeg := 0;
                  Prev := 0;

                  if Length(TemStr) > 50 then
                  begin
                    Add(TemStr);
                    TemStr := '';
                  end;

                  if i = ImSel then
                    Break;

                End; // If AvImList[Cnt] = 0

                If (Cnt = NrIm) and (MemBeg > 0) then
                Begin
                  if Prev > MemBeg then
                    TemStr := TemStr + IntToStr(MemBeg) + '-' + IntToStr(Prev)
                  else if Prev = MemBeg then
                    TemStr := TemStr + IntToStr(MemBeg);
                End; // If Cnt = NrIm
              End; // For Cnt := 1 to NrIm

              // write the last
              Add(TemStr);

            end; // with

          End;


END. { END UNIT }


