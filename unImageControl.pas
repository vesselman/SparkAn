{$D-,L-,O+,Q-,R-,Y-,S-}

unit unImageControl;

interface

uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ToolWin,Vcl.ImgList,
  EditNumerical, DSlider, UniButton;

type
  TfrmImageControl = class(TForm)
    ColorBar: TImage;
    PixValPlot: TImage;
    ColorTables: TComboBox;
    trbContrast: TTrackBar;
    trbGamma: TTrackBar;
    trbBrightness: TTrackBar;
    pnImContr: TPanel;
    lblGamma: TLabel;
    chbMedian: TCheckBox;
    chbBox: TCheckBox;
    trbMaxRatio: TTrackBar;
    trbBackSubtr: TTrackBar;
    trbCutOff: TTrackBar;
    ToolsToolBar: TToolBar;
    Select: TToolButton;
    MeasureBox: TToolButton;
    PlaceMark: TToolButton;
    PutBox: TToolButton;
    Freehand: TToolButton;
    TollsImageList: TImageList;
    ToolBarWhiteBottom: TToolBar;
    WhiteBottom: TToolButton;
    lblMaxRatOrCa: TLabel;
    lblBkg: TLabel;
    lblCutOff: TLabel;
    ResetColTbl: TToolButton;
    LabContrast: TLabel;
    LabBrigthness: TLabel;
    scrBoxXsize: TScrollBar;
    scrBoxYSize: TScrollBar;
    lblBoxXsize: TLabel;
    lblBoxYsize: TLabel;
    TitleXofROI: TLabel;
    TitleYofROI: TLabel;
    BevelXYsliders: TBevel;
    BlackBottom: TToolButton;
    ImageListResWBl: TImageList;
    lblXmicrons: TLabel;
    lblYmicrons: TLabel;
    SelectionFrameChange: TToolButton;
    SelectLocked: TToolButton;
    MeasureDistance: TToolButton;
    ImageListInfoRat: TImageList;
    ImageListInfoRatDisAbled: TImageList;
    trbTransp: TTrackBar;
    bnTransp: TSpeedButton;
    NegColTabl: TSpeedButton;
    DSPixRange: TDSlider;
    enPixRange: TEditNumerical;
    tlPixRange: TLabel;
    SetRange: TSpeedButton;
    AutoSetRange: TSpeedButton;
    ZoomRange: TSpeedButton;
    ActionsToolBar: TToolBar;
    btZeroOutsideROI_AvIm: TToolButton;
    btZeroOutsideROI_All_Images: TToolButton;
    DeleteAll: TToolButton;
    GetROISurface: TToolButton;
    DoLineScan: TToolButton;
    DeleteMesLine: TToolButton;
    LineScanPlotRange: TToolButton;
    TransferLStoPlot: TToolButton;
    rbBoxOrGaussSm2DFirst: TRadioButton;
    rbMedSm2DFirst: TRadioButton;
    DiamMes: TToolButton;
    enDiamMesRectWidth: TEditNumerical;
    lbDiamMesRectWidth: TLabel;
    trbBottomRegionOfColorTable: TTrackBar;
    sbSmoothNonRatioChOne: TSpeedButton;
    ubBoxSmooth3x3: TUniButton;
    ubBoxSmooth5x5: TUniButton;
    ubBoxSmooth7x7: TUniButton;
    ubMedSmooth3x3: TUniButton;
    ubMedSmooth5x5: TUniButton;
    ubMedSmooth7x7: TUniButton;
    unGaussSmooth3x3L: TUniButton;
    unGaussSmooth5x5: TUniButton;
    unGaussSmooth7x7: TUniButton;
    unGaussSmooth3x3M: TUniButton;
    unGaussSmooth3x3H: TUniButton;
    chbGauss: TCheckBox;
    lblBottom: TLabel;
    cbSmoothBeforeDoRatio: TCheckBox;
    ubSetDiamMes: TUniButton;
    enROItrackXtol: TEditNumerical;
    enROItrackYtol: TEditNumerical;
    sbSmoothNonRatioChTwo: TSpeedButton;
    cbDoLineScanOfMergeImage: TCheckBox;
    cbMergeModel: TComboBox;
    trbOverlayThreshold: TTrackBar;
    enContrast: TEditNumerical;
    enBrightness: TEditNumerical;
    enGamma: TEditNumerical;
    enBottomRegionOfColorTable: TEditNumerical;
    enMaxRatio: TEditNumerical;
    enCutOff: TEditNumerical;
    enBackSubtrMainWindow: TEditNumerical;
    enTransp: TEditNumerical;
    enOverlayThreshold: TEditNumerical;
    ubSizeBar: TUniButton;
    ub1stChannel: TUniButton;
    ub2ndChannel: TUniButton;
    ubRatioOn: TUniButton;
    ubApplyFrame: TUniButton;
    ubGrid: TUniButton;
    sbSetROItracking: TSpeedButton;
    lbXtol: TLabel;
    lbYtol: TLabel;
    unChDivCh: TUniButton;
    trbBack2ndWinSubtr: TTrackBar;
    enBackSubtr2ndWindow: TEditNumerical;
    Label2: TLabel;
    ubFileColTable: TUniButton;
    procedure FormShow(Sender: TObject);
    procedure chbMedianMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chbBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblCutOffMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblBkgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblMaxRatOrCaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomRangeClick(Sender: TObject);
    procedure SetRangeClick(Sender: TObject);
    procedure enPixRangeReturnPressed(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ColorTablesChange(Sender: TObject);
    procedure trbContrastChange(Sender: TObject);
    procedure trbGammaChange(Sender: TObject);
    procedure trbBrightnessChange(Sender: TObject);
    procedure chbBoxClick(Sender: TObject);
    procedure chbMedianClick(Sender: TObject);
    procedure trbMaxRatioChange(Sender: TObject);
    procedure WhiteBottomClick(Sender: TObject);
    procedure ResetColTblClick(Sender: TObject);
    procedure trbBackSubtrChange(Sender: TObject);
    procedure trbCutOffChange(Sender: TObject);
    procedure MeasureBoxClick(Sender: TObject);
    procedure scrBoxXsizeChange(Sender: TObject);
    procedure scrBoxYSizeChange(Sender: TObject);
    procedure DeleteAllClick(Sender: TObject);
    procedure SelectClick(Sender: TObject);
    procedure PutBoxClick(Sender: TObject);
    procedure MakeOutZero(Sender: TObject);
    procedure FreehandClick(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure PlaceMarkClick(Sender: TObject);
    procedure BlackBottomClick(Sender: TObject);
    procedure SelectionFrameChangeClick(Sender: TObject);
    procedure MeasureDistanceClick(Sender: TObject);
    procedure SelectLockedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure trbTranspChange(Sender: TObject);
    procedure bnTranspClick(Sender: TObject);
    procedure NegColTablClick(Sender: TObject);
    procedure btZeroOutsideROI_All_ImagesClick(Sender: TObject);
    procedure DSPixRangeChange(Sender: TObject);
    procedure ApplyFrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZoomRangeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabContrastMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabBrigthnessMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblGammaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tlPixRangeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelectMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelectLockedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PlaceMarkMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PutBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FreehandMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SelectionFrameChangeMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MeasureBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btZeroOutsideROI_AvImMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btZeroOutsideROI_All_ImagesMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GetROISurfaceClick(Sender: TObject);
    procedure DoLineScanClick(Sender: TObject);
    procedure DeleteMesLineClick(Sender: TObject);
    procedure LineScanPlotRangeClick(Sender: TObject);
    procedure TransferLStoPlotClick(Sender: TObject); 
    procedure rbBoxOrGaussSm2DFirstClick(Sender: TObject);
    procedure rbMedSm2DFirstClick(Sender: TObject);
    procedure DiamMesClick(Sender: TObject);
    procedure enDiamMesRectWidthReturnPressed(Sender: TObject);
    procedure sbSetROItrackingClick(Sender: TObject);
    procedure scrBoxXsizeMouseEnter(Sender: TObject);
    procedure scrBoxXsizeMouseLeave(Sender: TObject);
    procedure scrBoxYSizeMouseEnter(Sender: TObject);
    procedure scrBoxYSizeMouseLeave(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure trbBottomRegionOfColorTableChange(Sender: TObject);
    procedure sbSmoothNonRatioChOneClick(Sender: TObject);
    procedure ubBoxSmooth3x3Select(Sender: TObject);
    procedure ubBoxSmooth5x5Select(Sender: TObject);
    procedure ubBoxSmooth7x7Select(Sender: TObject);
    procedure ubMedSmooth3x3Select(Sender: TObject);
    procedure ubMedSmooth5x5Select(Sender: TObject);
    procedure ubMedSmooth7x7Select(Sender: TObject);
    procedure chbGaussClick(Sender: TObject);
    procedure chbGaussMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure unGaussSmooth3x3LSelect(Sender: TObject);
    procedure unGaussSmooth3x3MSelect(Sender: TObject);
    procedure unGaussSmooth3x3HSelect(Sender: TObject);
    procedure unGaussSmooth5x5Select(Sender: TObject);
    procedure unGaussSmooth7x7Select(Sender: TObject);
    procedure cbSmoothBeforeDoRatioClick(Sender: TObject);
    procedure ubSetDiamMesSelect(Sender: TObject);
    procedure ubSetDiamMesClick(Sender: TObject);
    procedure sbSmoothNonRatioChTwoClick(Sender: TObject);
    procedure trbOverlayThresholdChange(Sender: TObject);
    procedure cbMergeModelChange(Sender: TObject);
    procedure enContrastReturnPressed(Sender: TObject);
    procedure enBrightnessReturnPressed(Sender: TObject);
    procedure enGammaReturnPressed(Sender: TObject);
    procedure enBottomRegionOfColorTableReturnPressed(Sender: TObject);
    procedure enMaxRatioReturnPressed(Sender: TObject);
    procedure enBackSubtrMainWindowReturnPressed(Sender: TObject);
    procedure enCutOffReturnPressed(Sender: TObject);
    procedure enTranspReturnPressed(Sender: TObject);
    procedure enOverlayThresholdReturnPressed(Sender: TObject);
    procedure ubSizeBarClick(Sender: TObject);
    procedure ub1stChannelSelect(Sender: TObject);
    procedure ub2ndChannelSelect(Sender: TObject);
    procedure ubRatioOnClick(Sender: TObject);
    procedure ubApplyFrameClick(Sender: TObject);
    procedure ubApplyFrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ubRatioOnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ubGridClick(Sender: TObject);
    procedure cbDoLineScanOfMergeImageMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbXtolMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbYtolMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure enROItrackXtolReturnPressed(Sender: TObject);
    procedure enROItrackYtolReturnPressed(Sender: TObject);
    procedure unChDivChClick(Sender: TObject);
    procedure enBackSubtr2ndWindowReturnPressed(Sender: TObject);
    procedure trbBack2ndWinSubtrChange(Sender: TObject);
    procedure cbDoLineScanOfMergeImageClick(Sender: TObject);
    procedure ubFileColTableClick(Sender: TObject);
    procedure lblBkgMouseEnter(Sender: TObject);
    procedure lblBkgMouseLeave(Sender: TObject);
    procedure lblCutOffMouseEnter(Sender: TObject);
    procedure lblCutOffMouseLeave(Sender: TObject);
    procedure lblMaxRatOrCaMouseEnter(Sender: TObject);
    procedure lblMaxRatOrCaMouseLeave(Sender: TObject);
    procedure tlPixRangeMouseEnter(Sender: TObject);
    procedure tlPixRangeMouseLeave(Sender: TObject);
    procedure LabContrastMouseEnter(Sender: TObject);
    procedure LabContrastMouseLeave(Sender: TObject);
    procedure LabBrigthnessMouseEnter(Sender: TObject);
    procedure LabBrigthnessMouseLeave(Sender: TObject);
    procedure lblGammaMouseEnter(Sender: TObject);
    procedure lblGammaMouseLeave(Sender: TObject);
    procedure lblBottomMouseEnter(Sender: TObject);
    procedure lblBottomMouseLeave(Sender: TObject);
    procedure lblBottomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }

    ScrBarMouseIn : TScrollBar; //used as pointer to TScrollBar

    ImHistLine      : array of TPoint;  //do not use regular array here
    ImHistPolygon   : array of TPoint;

    BarDat          : array of Byte;
    pBarDat         : Pointer;
    DontActOnFrame  : Boolean;
    RePaintAvIm     : Boolean;

    procedure DoDSPixRangeChange(Sender: TObject);
    procedure ReDoRatioImage;
    procedure ReDoChannelsRatio;
    procedure SetXYsizeLabels;
    procedure SetFrmPlaybackValueTitle;
    procedure WMSize(var M : TWMSIZE); Message WM_Size; {added by me; helps hiding window}

  public
    { Public declarations }
     frmImContrHidden : Boolean;
     Procedure DoSmoothNonRatio(Sender: TObject);
     procedure DoSetROItracking(const Update : Boolean);
     Procedure PutTicksOnColorBar; {used by Global when file is loaded}
     Procedure CreateImageHistogram;
     Procedure PaintHistWindow;
     Procedure BoxSmoothChange(Const NewBoxSize : Integer);
     Procedure MedianSmoothChange(Const NewMedSize : Integer);
     Procedure GaussSmoothChange(Const NewGaussSize : Integer);
     Procedure SetSmoothMode(Sender: TObject);
     Procedure SetBackSubAndOtherSliders;
     Procedure UpdateColorBar;
     Procedure UpdateAllWindows(Sender: TObject);
     procedure SetChannel1or2Settings(Sender: TObject; const ChNr : integer);
     procedure SetBottomColTableSettings;
     procedure SwapBKGs(Sender: TObject); //introduced Nov 22 2016
  end;

var
  frmImageControl : TfrmImageControl;
  PixValDat       : array of TPoint;  {0..127; used to plot "General Relationship"}
  DontModColTable : Boolean; {needed to Disable actions of Sliders}

  

  implementation

  Uses  unGlobUnit, unMainWindow, unAverIm, unTimeSerAnal,unOKDlgNrImToExp,
        unPlayBack, un3DImageWin, unSurfaceROI, unLineScan, DigiFilters,unFunctions,
        Main, un2ndWin, unMergeWindow,OrthogonalSectioning, unRealLineScan;
  
{$R *.dfm}

procedure TfrmImageControl.FormCreate(Sender: TObject);
    var
      X,Y,Cnt        : Integer;
      CtSetNr        : Integer;
      NotEvent       : TNotifyEvent;

    Begin

      SetLength(BarDat,16*256);  //16 x 256 = 4096//
      SetLength(PixValDat,128);
      SetLength(ImHistLine, 128);
      SetLength(ImHistPolygon,130);

      for Cnt :=  0 to High(PixValDat    )     do PixValDat [Cnt].X := Cnt;
      for Cnt :=  0 to High(ImHistLine   )     do ImHistLine[Cnt].X := Cnt;
      for Cnt :=  1 to High(ImHistPolygon) - 1 do ImHistPolygon[Cnt].X := Cnt - 1; //initializes X values

      ImHistPolygon[  0].X := 0;
      ImHistPolygon[129].X := 127;
      ImHistPolygon[  0].Y := 63;
      ImHistPolygon[129].Y := 63;

      trbTransp.Tag := 255; //stores value

      frmImageControl.Width := pnImContr.Width;

      for Y := 0 to 255 do begin    //initializes color bar array
        for X := 0 to 15 do begin
          BarDat[X + Y*16] := Y;
        end;
      end;

     //-- Deals with Color Tables --//
     LoadClrTableFileInRAM;{Loads the entire Col Table File in RAM; It is Called Only Once - HERE}

     CtSetNr := 0;
     LoadColTable(CtSetNr);
     ModifyColTable(CtSetNr);
     CtSetNr := 1;
     LoadColTable(CtSetNr);
     ModifyColTable(CtSetNr);
     CtSetNr := 2;
     LoadColTable(CtSetNr);
     ModifyColTable(CtSetNr);

     CurrClrTablInd := 0;  //Current Color Table Index

     scrBoxXsize.Enabled := False;
     scrBoxYsize.Enabled := False;
     Select.Down         := True;
     DontModColTable     := True;


   {----------- {initialize from SparkAn.par; Keep it here ------------------------------}

      if (ImageContrVar.MaxGamma >= 50) and (ImageContrVar.MaxGamma <= 150)
        then trbGamma.Max := ImageContrVar.MaxGamma else
      if (ImageContrVar.MaxGamma < 50) and (ImageContrVar.MaxGamma > 150)
        then trbGamma.Max := 50;
      enGamma.Max := trbGamma.Max;
        {------------------------------}
      BoxcarOn := False;
      MedianOn := False;
      GaussOn  := False;

      trbContrast.Position := ColTableSetings.Contrast[0];
      enContrast.NumberOne := trbContrast.Position;
      trbBrightness.Position := ColTableSetings.Brightness[0];
      enBrightness.NumberOne := trbBrightness.Position;
      trbGamma.Position := ColTableSetings.Gamma[0];
      enGamma.NumberFloat := trbGamma.Position/10;
      ColorTables.ItemIndex := ColTableSetings.ColTblIndex[0];
      DontModColTable     := False;
      DispFact := 255/MaxRatio;

      enDiamMesRectWidth.NumberOne := enDiamMesRectWidth.Tag;
      enROItrackXtol.NumberOne := 10;
      enROItrackYtol.NumberOne := 10;

      //Sets Boxcar Filter Size smoothing - none of them is selected when is created
      if (BoxSmSize = 3) then ubBoxSmooth3x3.Selected := True else
      if (BoxSmSize = 5) then ubBoxSmooth5x5.Selected := True else
      if (BoxSmSize = 7) then ubBoxSmooth7x7.Selected := True;
      //Sets Gaussian Filter Size smoothing - none of them is selected when is created
      if (GaussSmSize = GAUSS_3x3_LITE)   then unGaussSmooth3x3L.Selected := True else
      if (GaussSmSize = GAUSS_3x3_MEDIUM) then unGaussSmooth3x3M.Selected := True else
      if (GaussSmSize = GAUSS_3x3_HEAVY)  then unGaussSmooth3x3H.Selected := True else
      if (GaussSmSize = GAUSS_5x5 )       then unGaussSmooth5x5.Selected  := True else
      if (GaussSmSize = GAUSS_7x7 )       then unGaussSmooth7x7.Selected  := True;
      //Sets Median Filter Size smoothing - none of them is selected when is created
      if (MedSmSize = 3) then ubMedSmooth3x3.Selected := True else
      if (MedSmSize = 5) then ubMedSmooth5x5.Selected := True else
      if (MedSmSize = 7) then ubMedSmooth7x7.Selected := True;

      If (SmoothMode > NO_SMOOTH) then Begin
        if SmoothMode in [SMOOTH_BOX ,SMOOTH_BOX_MED,SMOOTH_MED_BOX] then begin
          NotEvent := chbBox.OnClick;
          chbBox.OnClick := nil;
          chbBox.Checked := True;
          chbBox.OnClick := NotEvent;
          BoxcarOn := True;
        end;
        if SmoothMode in [SMOOTH_GAUSS ,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS] then begin
          NotEvent := chbGauss.OnClick;
          chbGauss.OnClick := nil;
          chbGauss.Checked := True;
          chbGauss.OnClick := NotEvent;
          GaussOn := True;
        end;
        if SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED,SMOOTH_MED_BOX,
                          SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS] then begin
          NotEvent := chbMedian.OnClick;
          chbMedian.OnClick := nil;
          chbMedian.Checked := True;
          chbMedian.OnClick := NotEvent;
          MedianOn := True;
        end;
      End;

      if (SmoothOrder = FIRST_BOX_OR_GAUSS) then rbBoxOrGaussSm2DFirst.Checked := True else
      if (SmoothOrder = FIRST_MEDIAN)       then rbMedSm2DFirst.Checked := True;


      CutOff := 0; //Here CutOff has been decided to be set to Zero although it has been memorized in WriteSparkAnPar - 7/24/2014
      SetBackSubAndOtherSliders;

      {updates ; do not remove}
      RePaintAvIm := True;
      ModifyColTable(0);
      PaintHistWindow;
      UpdateAllWindows(sender);
     //for merging images --//
      NotEvent := cbMergeModel.OnChange;
      cbMergeModel.OnChange := nil;
      cbMergeModel.ItemIndex := MergeModel;
      cbMergeModel.OnChange := NotEvent;

      NotEvent := trbOverlayThreshold.OnChange;
      trbOverlayThreshold.OnChange := nil;
      trbOverlayThreshold.Position := OverlayThreshold;
      enOverlayThreshold.NumberOne := OverlayThreshold;
      trbOverlayThreshold.OnChange := NotEvent;
      if (MergeModel = MERGE) then begin
        trbOverlayThreshold.Enabled := False;
        enOverlayThreshold.Enabled  := False;
      end else
      begin
        trbOverlayThreshold.Enabled := True;
        enOverlayThreshold.Enabled  := True;
      end;

End;  {procedure TfrmImageControl.FormCreate(Sender: TObject);}

{******************************************************************************}
procedure TfrmImageControl.SetBackSubAndOtherSliders;  //used by ImageControl.FormCreate and frmQueueFiles
var Sender : TObject;

Begin

      enBackSubtrMainWindow.Max := Bkg + 100;
      enBackSubtrMainWindow.NumberOne := Bkg;
      enBackSubtrMainWindowReturnPressed(Sender);
      enBackSubtr2ndWindow.Max := Bkg2nd + 100;
      enBackSubtr2ndWindow.NumberOne := Bkg2nd;
      enBackSubtr2ndWindowReturnPressed(Sender);
      trbCutOff.Max := ImageContrVar.CutOffMax;
      trbCutOff.Position := CutOff;
      enCutOff.NumberOne := trbCutOff.Position;
      enMaxRatio.Max := TimPltSlid.YmaxRatOn/10;
      enMaxRatio.NumberFloat  := MaxRatio;
      trbMaxRatio.Max := TimPltSlid.YmaxRatOn*10;
      trbMaxRatio.Position := round(MaxRatio*100);
      cbSmoothBeforeDoRatio.Checked := AutoSearchPar.SmoothBeforeDoRatio;

End;
{******************************************************************************}

procedure TfrmImageControl.FormShow(Sender: TObject);
begin
   ToolsToolBar.Enabled := False;
end;

procedure TfrmImageControl.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
   if (ScrBarMouseIn <> nil) then begin
     Handled := True; //if not then it scrolls twice
     ScrBarMouseIn.Position := ScrBarMouseIn.Position - 1;
   end;
end;

procedure TfrmImageControl.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
   if (ScrBarMouseIn <> nil) then begin
     Handled := True; //if not then it scrolls twice
     ScrBarMouseIn.Position := ScrBarMouseIn.Position + 1;
   end;
end;

{******************************************************************************}

procedure TfrmImageControl.NegColTablClick(Sender: TObject);
Begin
 NegateColorTables;
 ModifyColTable(0);
 ModifyColTable(1);
 if (NrChannels = 2) then
 ModifyColTable(2);
 UpdateAllWindows(sender);

End;

{-------------------------------------------------------------}
Procedure TfrmImageControl.CreateImageHistogram; //makes histogram on Image Control&Tolls windows; for 16-bit images Only
  var Cnt,CntBin,MaxV : Integer;
      BStep,BLimit : Double;
begin

  for CntBin := 0 to High(ImHistLine) do ImHistLine[CntBin].Y := 63; //63 is the Bottom of Window i.e. = Zero Value

    BStep  := (DSPixRange.PosTo - DSPixRange.PosFrom + 1) / Length(ImHistLine);
    BLimit :=  DSPixRange.PosFrom + BStep;
    CntBin := 0;
    MaxV   := 0;

    Cnt := 0;    

  for Cnt := DSPixRange.PosFrom to DSPixRange.PosTo do begin
    if MaxV < OneBinImHist[Cnt] then MaxV := OneBinImHist[Cnt];

    if Cnt > BLimit then begin
      while (Cnt > BLimit) do begin
        ImHistLine[CntBin].Y := ImHistLine[CntBin].Y - round(MaxV/ScaleImHistFact);
        Inc(CntBin);
        BLimit := BLimit + BStep;
      end;
       MaxV := 0;
    end; // if Cnt > BFLimit

  end; //for;

  MaxV := CntBin - 1;
  ImHistLine[CntBin].Y := ImHistLine[MaxV].Y; //Just Duplicates the last Number

  if CntBin < 127 then for Cnt := CntBin to 127 do begin
    ImHistLine[Cnt].Y := ImHistLine[MaxV].Y; ////Just Duplicates the last Number
  end;
                                                                 
  for Cnt := 0 to High(ImHistLine) do ImHistPolygon[Cnt+1].Y := ImHistLine[Cnt].Y;

End;


procedure TfrmImageControl.SetRangeClick(Sender: TObject);
  var Cnt,LowPix,TopPix : Integer;
begin

    CreateOneBinImHist;

    for Cnt := 0 to High(OneBinImHist) do begin
      if OneBinImHist[Cnt] > 0 then begin
        LowPix := Cnt;
        Break;
      end;
    end;

    for Cnt := High(OneBinImHist) downto 0 do begin
      if (OneBinImHist[Cnt] > 0) then begin
        TopPix := Cnt;
        Break;
      end;
    end;

    if TopPix < LowPix + DSPixRange.Delta then
       TopPix := LowPix + (DSPixRange.Delta + 1);  
    if TopPix >  (round(exp((shrFact + 8) * ln(2))) - 1) then begin
       TopPix := (round(exp((shrFact + 8) * ln(2))) - 1);
       LowPix := TopPix - (DSPixRange.Delta + 1);
    end;

    if (ZoomRange.Down) then DSPixRange.SetSlider(LowPix,TopPix,LowPix,TopPix)
      else
    if Not(ZoomRange.Down) then DSPixRange.SetSliderPos(LowPix,TopPix);

    DoDSPixRangeChange(Sender);

End;

procedure TfrmImageControl.ZoomRangeClick(Sender: TObject);
var MinOfRange,MaxOfRange : Integer;
begin
   if (DSPixRange.Enabled) then begin
     if (ZoomRange.Down) then begin
        MinOfRange := DSPixRange.PosFrom;
        MaxOfRange := DSPixRange.PosTo;
      if MaxOfRange - MinOfRange <= DSPixRange.Delta then begin
         MinOfRange := MinOfRange - 1;
         MaxOfRange := MaxOfRange + 1;
         if MinOfRange < 0 then begin
            MinOfRange := 0;
            MaxOfRange := DSPixRange.Delta + 2;
         end;
         if MaxOfRange > DSPixRange.Max then begin
            MaxOfRange := DSPixRange.Max;
            MinOfRange := MaxOfRange - (DSPixRange.Delta + 2);
         end;
      end;
                                 
        DSPixRange.SetSlider(MinOfRange,MaxOfRange,DSPixRange.PosFrom,DSPixRange.PosTo)
     end else
     if Not(ZoomRange.Down) then
        DSPixRange.SetSlider(0,round(exp((shrFact + 8) * ln(2))) - 1,
                             DSPixRange.PosFrom,DSPixRange.PosTo);
   end;
end;

procedure TfrmImageControl.PaintHistWindow;
begin
   {clears background}
  PixValPlot.Canvas.Brush.Color := clWhite;
  PixValPlot.Canvas.Pen.Color := clWhite;
  PixValPlot.Canvas.FillRect(PixValPlot.Canvas.ClipRect);

  
  if (MainImLoaded) then begin
  {Draws Histogram}
  {Area}
  PixValPlot.Canvas.Brush.Color := $00C4FFFF;//$00FFE4CA;//$00C4FFFF;
  PixValPlot.Canvas.Pen.Color   := $00C4FFFF;
  PixValPlot.Canvas.Polygon(ImHistPolygon);
  {outline}
  PixValPlot.Canvas.Pen.Color := clBlack; // after restoring to clear must reasign the color
  PixValPlot.Canvas.Polyline(ImHistLine);
  end;
  
  {Draws Color table characteristics}
  PixValPlot.Canvas.Pen.Color := clBlue;
  PixValPlot.Canvas.Polyline(PixValDat);

end;

procedure TfrmImageControl.DSPixRangeChange(Sender: TObject);
begin
  DoDSPixRangeChange(Sender);
End; //procedure TfrmImageControl.DSPixRangeChange

Procedure TfrmImageControl.DoDSPixRangeChange(Sender: TObject);
var ChNr : Integer;
begin

   enPixRange.SetNumbersOneTwo(dsPixRange.PosFrom,dsPixRange.PosTo);
   CreateImageHistogram;
   PaintHistWindow;

   If not(Sender = ub1stChannel) and not(Sender = ub2ndChannel) then Begin
    if (CurrClrTablInd in[0,1]) then ChNr := 0
      else
    if (CurrClrTablInd = 2)     then ChNr := 1;

    PixRange[ChNr].DSPixRange_PosFrom := dsPixRange.PosFrom;
    PixRange[ChNr].DSPixRange_PosTo   := dsPixRange.PosTo;
   End;

   if not(Sender = ub1stChannel) and not(Sender = ub2ndChannel) and not(Sender = SetRange) and
      not(Sender = dsPixRange)   and not(Sender = enPixRange) and not(Sender = frmPlayback.sbSwapChannel) then
   begin   //this will be OpenImageFile Needed to just set some reasonable value
    if (NrChannels = 2) then begin
      PixRange[1].DSPixRange_PosFrom := dsPixRange.PosFrom;
      PixRange[1].DSPixRange_PosTo   := dsPixRange.PosTo;
    end;
   end;

 If (BitCount = 16) and not(Sender = frmPlayback.sbSwapChannel) and
     not(Sender = ub1stChannel) and not(Sender = ub2ndChannel) Then Begin

   If Not(RatioOn) and Not(ChannelsRatioOn) then Begin
     If (ub1stChannel.Selected) then begin
        if  (ChannelOrder = ASCENDING)  then begin
          Scale16bitImageToImDispl(0,ImDispl);
          if (AllowWindowsUpdate) then UpdateMainImage(True); //updates 1st channel displayed on the MainWindow
        end;
        if (ChannelOrder = DESCENDING)  then begin
          Scale16bitImageToImDispl(1,Im2ndDispl);
          if (frm2ndWin   <> nil) then Display2ndChannel;
        end;
     End;
     If (NrChannels = 2) then begin
      If (ub2ndChannel.Selected)  or (Sender = nil) then begin  //Sender = nil is send by OpenImageFile procedure
        if (ChannelOrder = ASCENDING)  then begin
          Scale16bitImageToImDispl(1,Im2ndDispl);
          if (frm2ndWin   <> nil) then Display2ndChannel;
        end;
        if (ChannelOrder = DESCENDING) then begin
          Scale16bitImageToImDispl(0,ImDispl);
          if (AllowWindowsUpdate) then UpdateMainImage(True); //updates 2nd channel displayed on the MainWindow
        end;
      End;

      If (AllowWindowsUpdate) then Begin
        if  (ChannelOrder = ASCENDING)  then
          MergeImagesTo32bit(ImDispl, Im2ndDispl ,MergeImDispl,imXsize,imYsize)
          else
        if (ChannelOrder = DESCENDING)  then
          MergeImagesTo32bit(Im2ndDispl,ImDispl,MergeImDispl,imXsize,imYsize);
        if (frmMergeWin <> nil) then DisplayMergeImage;
      End;
     End; //If (NrChannels = 2) then begin

    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(RELOAD_DISPL);
   {---------------- end 3D Image -----------------------}

   {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(True);
   {---------------- end 3D Image -----------------------}
   End; //If Not(RatioOn)

   If (AvImExists > 0) {And
      (((ub1stChannel.Selected) and (AvImChOrig = 1)) or
       ((ub2ndChannel.Selected) and (AvImChOrig = 2)))   }
   Then Begin
    CopyAvImToDisplBuffer;
    if (frmAverIm <> nil) then UpdateAverImage(True);
   End;  //(AvImExists > 0)

   if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(True,False);
   end;
 End;

 {-------------------- Real Line Scan Window --------------------}
 if (RealLineScanOn) then frmRealLineScan.sbReloadImageClick(Sender);
 {---------------------------------------------------------------}

End; //Procedure TfrmImageControl.DoDSPixRangeChange(Sender: TObject);


procedure TfrmImageControl.enPixRangeReturnPressed(Sender: TObject);
begin
  DSPixRange.SetSliderPos(enPixRange.NumberOne,enPixRange.NumberTwo);
  DoDSPixRangeChange(Sender);
end;

{-------------------------------------------------------------}

procedure TfrmImageControl.ColorTablesChange(Sender: TObject);
Begin
    ColTableSetings.ColTblIndex[CurrClrTablInd] :=  ColorTables.ItemIndex;
    LoadColTable(CurrClrTablInd);
    ModifyColTable(CurrClrTablInd);
    UpdateAllWindows(sender);
End; {procedure TfrmImageControl.ColorTablesChange(Sender: TObject);}
 {******************************************************************************}
procedure TfrmImageControl.enContrastReturnPressed(Sender: TObject);
begin
  trbContrast.Position := enContrast.NumberOne;
end;

procedure TfrmImageControl.trbContrastChange(Sender: TObject);
Begin

 If not(DontModColTable) then Begin
  If (ColTableSetings.Contrast[CurrClrTablInd]  <> trbContrast.Position)  then Begin
      ColTableSetings.Contrast[CurrClrTablInd]   := trbContrast.Position;
      enContrast.NumberOne := trbContrast.Position;
      PaintHistWindow;
      ModifyColTable(CurrClrTablInd);
      UpdateAllWindows(sender);
  End;
 End;

End; //trbContrastChange

procedure TfrmImageControl.enGammaReturnPressed(Sender: TObject);
begin
  trbGamma.Position := round(10*enGamma.NumberFloat);
end;

procedure TfrmImageControl.trbGammaChange(Sender: TObject);
begin

 If not(DontModColTable) then Begin
  If ColTableSetings.Gamma[CurrClrTablInd] <> trbGamma.Position then begin
    ColTableSetings.Gamma[CurrClrTablInd] := trbGamma.Position;
    enGamma.NumberFloat := trbGamma.Position/10;
    PaintHistWindow;
    ModifyColTable(CurrClrTablInd);
    UpdateAllWindows(sender);
  End;
 End; {sender}
  {Equation is:  Y = X^Gamma, where X = 0 .. 1  (from 0 min to 1 Max)
   i.e. DisplayPix = (FilePix[0..255]/255)^Gamma }
  {Base^Power := exp(Power * ln(Base));} {e.g. 8^3 = 512}

End;
{***********************************************************************}

procedure TfrmImageControl.enBrightnessReturnPressed(Sender: TObject);
begin
  trbBrightness.Position := enBrightness.NumberOne;
end;

procedure TfrmImageControl.trbBrightnessChange(Sender: TObject);
Begin

If not(DontModColTable) then Begin
  If ColTableSetings.Brightness[CurrClrTablInd] <> trbBrightness.Position then Begin
    ColTableSetings.Brightness[CurrClrTablInd] := trbBrightness.Position;
    enBrightness.NumberOne := trbBrightness.Position;
    PaintHistWindow;
    ModifyColTable(CurrClrTablInd);
    UpdateAllWindows(sender);
  End;
End;
End;
 {*********************************************************}
 {********************* Smoothing Controls ******************}
 {the Group of TStaticText works together. The Color is Controlled by Common Procedures}

{*********************************************************}

procedure TfrmImageControl.ReDoRatioImage;
begin

  Screen.Cursor := crHourGlass;
  if (SmoothMode > NO_SMOOTH) and (cbSmoothBeforeDoRatio.Checked) then begin
    SmoothAverIm(AvImRaw,AvIm);
    ApplySmoothing;
  end;
  DoBkgonAvIm; {Subtracts Bkg from AvIm Only.  From Smoothed or from AvImRaw}
  DoRatio(DO_COPY);
  UpdateMainImage(True);
  Screen.Cursor := crDefault;
  {----------------  Line Scan  ------------------------}
  if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
  {---------------- end Line Scan -----------------------}
  {----------------   3D Image  ------------------------}
  if (Win3DOn) then frm3DImageWin.Update3DImage(False);
   {---------------- end 3D Image -----------------------}

end; //procedure TfrmImageControl.ReSmoothRatioImage;

procedure TfrmImageControl.ReDoChannelsRatio;
begin

  Screen.Cursor := crHourGlass;
  DoChannelRatio(DO_COPY);
  UpdateMainImage(True);
  Screen.Cursor := crDefault;
  {----------------  Line Scan  ------------------------}
  if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO);
  {---------------- end Line Scan -----------------------}
  {----------------   3D Image  ------------------------}
  if (Win3DOn) then frm3DImageWin.Update3DImage(False);
   {---------------- end 3D Image -----------------------}

end; //procedure TfrmImageControl.ReSmoothRatioImage;



procedure TfrmImageControl.ubBoxSmooth3x3Select(Sender: TObject);
begin
  BoxSmoothChange(ubBoxSmooth3x3.Tag);
end;

procedure TfrmImageControl.ubBoxSmooth5x5Select(Sender: TObject);
begin
  BoxSmoothChange(ubBoxSmooth5x5.Tag);
end;

procedure TfrmImageControl.ubBoxSmooth7x7Select(Sender: TObject);
begin
  BoxSmoothChange(ubBoxSmooth7x7.Tag);
end;

procedure TfrmImageControl.ubGridClick(Sender: TObject);
begin
  WindowGrid.Visible := ubGrid.Selected;
  UpdateMainImage(True);
  if (AvImExists > 0) and (frmAverIm <> nil) then UpdateAverImage(True);
    if (NrChannels > 1) then begin
      if (frm2ndWin <> nil) then Display2ndChannel;
      if (frmMergeWin <> nil) then DisplayMergeImage;
    end;
end;

procedure TfrmImageControl.BoxSmoothChange(Const NewBoxSize : Integer);
var Sender : TObject;
begin

  BoxSmSize := NewBoxSize;
  if (BoxcarOn = True) then begin
    if    (RatioOn) then ReDoRatioImage
      else
    if (ChannelsRatioOn) then RedoChannelsRatio
      else
    if not(RatioOn) and not(ChannelsRatioOn) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO) then begin
      DoSmoothNonRatio(Sender);
      if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
        UpdateSectionsAndDrawMainWin(True,False);
      end;
    end;
  end;
End;  {procedure TfrmImageControl.trbBoxChange(Sender: TObject);}
{*********************************************************}

procedure TfrmImageControl.unGaussSmooth3x3LSelect(Sender: TObject);
begin
 GaussSmoothChange(unGaussSmooth3x3L.Tag);
end;

procedure TfrmImageControl.unGaussSmooth3x3MSelect(Sender: TObject);
begin
  GaussSmoothChange(unGaussSmooth3x3M.Tag);
end;


procedure TfrmImageControl.unGaussSmooth3x3HSelect(Sender: TObject);
begin
  GaussSmoothChange(unGaussSmooth3x3H.Tag);
end;

procedure TfrmImageControl.unGaussSmooth5x5Select(Sender: TObject);
begin
  GaussSmoothChange(unGaussSmooth5x5.Tag);
end;

procedure TfrmImageControl.unGaussSmooth7x7Select(Sender: TObject);
begin
  GaussSmoothChange(unGaussSmooth7x7.Tag);
end;

procedure TfrmImageControl.GaussSmoothChange(Const NewGaussSize : Integer);
var Sender : TObject;
begin

  GaussSmSize := NewGaussSize;

  if (GaussOn = True) then begin
    if    (RatioOn) then ReDoRatioImage
      else
    if (ChannelsRatioOn) then RedoChannelsRatio
	    else
    if not(RatioOn) and not(ChannelsRatioOn) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO) then begin
      DoSmoothNonRatio(Sender);
      if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
        UpdateSectionsAndDrawMainWin(True,False);
      end;
    end;
  end;

End;  {TfrmImageControl.GaussSmoothChange}

{*********************************************************}

procedure TfrmImageControl.ubMedSmooth3x3Select(Sender: TObject);
begin
  MedianSmoothChange(ubMedSmooth3x3.Tag);
end;

procedure TfrmImageControl.ubMedSmooth5x5Select(Sender: TObject);
begin
  MedianSmoothChange(ubMedSmooth5x5.Tag);
end;

procedure TfrmImageControl.ubMedSmooth7x7Select(Sender: TObject);
begin
  MedianSmoothChange(ubMedSmooth7x7.Tag);
end;

procedure TfrmImageControl.MedianSmoothChange(Const NewMedSize : Integer);
var Sender : TObject;
begin

  MedSmSize := NewMedSize;
  if (MedianOn = True) then begin
    if    (RatioOn) then ReDoRatioImage
      else
    if (ChannelsRatioOn) then RedoChannelsRatio
	    else
    if not(RatioOn) and not(ChannelsRatioOn) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO) then begin
      DoSmoothNonRatio(Sender);
      if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
        UpdateSectionsAndDrawMainWin(True,False);
      end;
    end;
  end;

End;  {TfrmImageControl.trbMedianChange(Sender: TObject);}

{*********************************************************}
procedure TfrmImageControl.rbBoxOrGaussSm2DFirstClick(Sender: TObject);
begin

  SmoothOrder :=  FIRST_BOX_OR_GAUSS;
  if (BoxcarOn = True ) and (MedianOn = True ) then SmoothMode := SMOOTH_BOX_MED else
  if (GaussOn  = True ) and (MedianOn = True ) then SmoothMode := SMOOTH_GAUSS_MED;

  if (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_GAUSS_MED]) then begin
    if    (RatioOn) then ReDoRatioImage
      else
    if (ChannelsRatioOn) then RedoChannelsRatio
      else
    if not(RatioOn) and not(ChannelsRatioOn) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO) then begin
      DoSmoothNonRatio(Sender);
      if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
        UpdateSectionsAndDrawMainWin(True,False);
      end;
    end;
  end;
end;

procedure TfrmImageControl.rbMedSm2DFirstClick(Sender: TObject);
begin
  SmoothOrder :=  FIRST_MEDIAN;
  if (BoxcarOn = True ) and (MedianOn = True ) then SmoothMode := SMOOTH_MED_BOX else
  if (GaussOn  = True ) and (MedianOn = True ) then SmoothMode := SMOOTH_MED_GAUSS;

  if (SmoothMode in [SMOOTH_MED_BOX,SMOOTH_MED_GAUSS]) then begin
    if    (RatioOn) then ReDoRatioImage
      else
    if (ChannelsRatioOn) then RedoChannelsRatio
      else
    if not(RatioOn) and not(ChannelsRatioOn) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO) then begin
      DoSmoothNonRatio(Sender);
      if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
        UpdateSectionsAndDrawMainWin(True,False);
      end;
    end;
  end;
end;

{*********************************************************}
procedure TfrmImageControl.SetSmoothMode(Sender : TObject);
begin

   if not(BoxcarOn) and not(GaussOn) and not(MedianOn) then SmoothMode := NO_SMOOTH else
   if (BoxcarOn) and not(GaussOn) and not(MedianOn)    then SmoothMode := SMOOTH_BOX else
   if not(BoxcarOn) and not(GaussOn) and (MedianOn)    then SmoothMode := SMOOTH_MED else
   if not(BoxcarOn) and (GaussOn) and not(MedianOn)    then SmoothMode := SMOOTH_GAUSS else
   if (BoxcarOn)and not(GaussOn) and (MedianOn)  then begin
      if (SmoothOrder = FIRST_BOX_OR_GAUSS) then  SmoothMode := SMOOTH_BOX_MED else
      if (SmoothOrder = FIRST_MEDIAN)       then  SmoothMode := SMOOTH_MED_BOX;
   end else
   if not(BoxcarOn) and (GaussOn) and (MedianOn) then begin
      if (SmoothOrder = FIRST_BOX_OR_GAUSS) then  SmoothMode := SMOOTH_GAUSS_MED else
      if (SmoothOrder = FIRST_MEDIAN)       then  SmoothMode := SMOOTH_MED_GAUSS;
   end;

   if  (RatioOn) then ReDoRatioImage

      else

   if (ChannelsRatioOn) then RedoChannelsRatio

      else

   if not(RatioOn) and not(ChannelsRatioOn) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO) then begin
    DoSmoothNonRatio(Sender);
    if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(True,False);
    end;
   end;

End;

procedure TfrmImageControl.cbSmoothBeforeDoRatioClick(Sender: TObject);
begin
  AutoSearchPar.SmoothBeforeDoRatio := cbSmoothBeforeDoRatio.Checked;
  If (RatioOn) then begin
      if (SmoothMode > NO_SMOOTH) and (cbSmoothBeforeDoRatio.Checked) then begin
        ApplySmoothing;
        SmoothAverIm(AvImRaw,AvIm);
      end;
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
End;

procedure TfrmImageControl.chbBoxClick(Sender: TObject);
var OnClickMem : TNotifyEvent;
begin

     BoxcarOn := chbBox.Checked; {Copies the Boolean State}
     if (GaussOn) then Begin
      OnClickMem := chbGauss.OnClick;
      chbGauss.OnClick := nil;
      GaussOn := False;
      chbGauss.Checked := GaussOn;
      chbGauss.OnClick := OnClickMem;
    end;

     SetSmoothMode(Sender);
End;

procedure TfrmImageControl.chbBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 26;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.chbGaussClick(Sender: TObject);
var OnClickMem : TNotifyEvent;
begin
    GaussOn  := chbGauss.Checked; {Copies the Boolean State}
    if (BoxcarOn) then Begin
      OnClickMem := chbBox.OnClick;
      chbBox.OnClick := nil;
      BoxcarOn := False;
      chbBox.Checked := BoxcarOn;
      chbBox.OnClick := OnClickMem;
    end;
    SetSmoothMode(Sender);
End;

procedure TfrmImageControl.chbGaussMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 46;
  GetHelp(HelpCode);
 end;
end;

{*****************************************************************************}
procedure TfrmImageControl.chbMedianClick(Sender: TObject);

  begin

     MedianOn := chbMedian.Checked; {Gets the True or False}
     SetSmoothMode(Sender);

end;

{*****************************************************************************}

 procedure TfrmImageControl.chbMedianMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 27;
  GetHelp(HelpCode);
 end;
end;

{*****************************************************************************}

procedure TfrmImageControl.ubRatioOnClick(Sender: TObject);
var   CtSetNr, Cnt,j,imLen : integer;
  Begin
    {Smoothing & Bkg & Cutoff is Applied to AvIm Only if Ratio is On
    every time it is swithed On it Refreshes AvIm (does Smooth or Gets
    Raw data from AvImRaw}

 If (AvImExists > NO_AVERAGE) Then Begin

    if (ChannelsRatioOn) then unChDivCh.Selected := False;

    RatioOn := ubRatioOn.Selected;
    frmPlayback.ubRatioOn_PlayBack.Selected := ubRatioOn.Selected;

    {Reloads Display Buffers}
    If Not(RatioOn) then Begin
       if (NrChannels = 2) then begin
        ub2ndChannel.Enabled := True;
       end;
      if (BitCount = 16) then Scale16bitImageToImDispl(0,ImDispl)
       else
      If (BitCount = 8) then  Transfer8bitImageToImDispl(ImDispl);
      CtSetNr := 0;
      CurrClrTablInd := 0;
      TimPltSlid.TimeSerAnalMode := INTENSITY;
      frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'Intensity';
      if (MeasureDistance.Down = False) then frmPlayback.titValueType.Caption := 'Intensity';
    End

      Else

    If (RatioOn) then begin

      if (NrChannels > 1) then begin
        if (ub2ndChannel.Selected) then begin
          ub2ndChannel.Selected := False;
          ub1stChannel.Selected := True;
        end;
         ub2ndChannel.Enabled  := False;
      end;

      TimPltSlid.TimeSerAnalMode := F_div_Fo;
      frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'F/Fo';

      frmTimeSerPlot.cbTraceDivMinClick(Sender);
      frmTimeSerPlot.sbSetRange.Down := False;
      frmTimeSerPlot.sbSetRange.Enabled := False;
      CtSetNr := 1;
      CurrClrTablInd := 1;
      if (SmoothMode > NO_SMOOTH) and (cbSmoothBeforeDoRatio.Checked) then Begin
         ApplySmoothing;
         SmoothAverIm(AvImRaw,AvIm);
      end; {SmoothMode > 0}
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
      DoRatio(DO_COPY);
      if Not(MeasureDistance.Down) then frmPlayback.titValueType.Caption := 'F/Fo';
    End; {(RatioOn = True)}

      {-----  Here Updates Windows  ----------}
    DontModColTable := True;
    If ((ColTableSetings.ColTblIndex[0] <> ColTableSetings.ColTblIndex[1]) or
         (ColTableSetings.Gamma[0]      <> ColTableSetings.Gamma[1]) or
         (ColTableSetings.Brightness[0] <> ColTableSetings.Brightness[1]) or
         (ColTableSetings.Contrast[0]   <> ColTableSetings.Contrast[1]))
    then Begin
      ColorTables.ItemIndex :=  ColTableSetings.ColTblIndex[CtSetNr];
      LoadColTable(CtSetNr);
      trbContrast.Position   := ColTableSetings.Contrast[CtSetNr];
      trbGamma.Position      := ColTableSetings.Gamma[CtSetNr];
      trbBrightness.Position := ColTableSetings.Brightness[CtSetNr];
      enContrast.NumberOne   := trbContrast.Position;
      enBrightness.NumberOne := trbBrightness.Position;
      enGamma.NumberFloat    := trbGamma.Position/10;
      SetBottomColTableSettings;
      ModifyColTable(CtSetNr);
      PaintHistWindow;
      RePaintAvIm := False;   {Not to Refresh Av Image}
      UpdateAllWindows(sender);
      RePaintAvIm := True;
    End
      Else
    Begin  //If All Col Table Settings are the same
      UpdateMainImage(True);
      {----------------  Line Scan  ------------------------}
       if (LineScanExist) then begin
        if (RatioOn) then frmLineScan.UpdateLSwindows(REDO_RATIO) else
                          frmLineScan.UpdateLSwindows(RELOAD_DISPL);
       end;
      {---------------- end Line Scan -----------------------}
      {----------------   3D Image  ------------------------ }
      if (Win3DOn) then frm3DImageWin.Update3DImage(True);
        {---------------- end 3D Image -----------------------}
    End; //Else Begin = If All Col Table Settings are the same

      DontModColTable := False;

 End
  Else
 If (AvImExists = NO_AVERAGE) Then Begin
  ubRatioOn.Selected := False;
  frmPlayback.ubRatioOn_PlayBack.Selected := False;
  MessageDlg('Select Images or Open Average Image File First',mtInformation,[mbOK],0);
 End;

 with frmTimeSerPlot do begin
  if (TimPltSlid.TimeSerAnalMode = INTENSITY) then begin
    lbThreshold.Enabled := True;
    enThreshForArea.Enabled := True;
  end
    else
  begin
    lbThreshold.Enabled := False;
    enThreshForArea.Enabled := False;
  end;
 end;

End; //procedure TfrmImageControl.ubRatioOnClick(Sender: TObject);

{****************************************************************************}

procedure TfrmImageControl.unChDivChClick(Sender: TObject);

var   CtSetNr, Cnt,j,imLen : integer;
Begin
    {Smoothing & Bkg & Cutoff is Applied to AvIm Only if Ratio is On
    every time it is swithed On it Refreshes AvIm (does Smooth or Gets
    Raw data from AvImRaw}

    if (unChDivCh.Selected) then begin
      RatioOn := False;
      ubRatioOn.Selected := False;
      frmPlayback.ubRatioOn_PlayBack.Selected := False;
    end;

    ChannelsRatioOn := unChDivCh.Selected;

    {Reloads Display Buffers}
    If Not(ChannelsRatioOn) then Begin
       if (NrChannels > 1) then begin
        ub2ndChannel.Enabled := True;
       end;
      if (BitCount = 16) then Scale16bitImageToImDispl(0,ImDispl)
       else
      If (BitCount = 8) then  Transfer8bitImageToImDispl(ImDispl);
      CtSetNr := 0;
      CurrClrTablInd := 0;
      TimPltSlid.TimeSerAnalMode := INTENSITY;
      frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'Intensity';
      if not(MeasureDistance.Down) then frmPlayback.titValueType.Caption := 'Intensity';
    End

      Else

    If (ChannelsRatioOn) then begin

      if (NrChannels > 1) then begin
        if (ub2ndChannel.Selected) then begin
          ub2ndChannel.Selected := False;
          ub1stChannel.Selected := True;
        end;
         ub2ndChannel.Enabled  := False;
      end;

      TimPltSlid.TimeSerAnalMode := Ch_div_Ch;

      if (ChannelOrder = ASCENDING)  then begin
          frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'Ch1/Ch2';
          if not(MeasureDistance.Down) then frmPlayback.titValueType.Caption := 'Ch1/Ch2';
          lblMaxRatOrCa.Caption := 'Max R.';
      end
          else
      if (ChannelOrder = DESCENDING) then begin
          frmTimeSerPlot.lbTimeSerAnalMode.Caption := 'Ch2/Ch1';
          if not(MeasureDistance.Down) then frmPlayback.titValueType.Caption := 'Ch2/Ch1';
          lblMaxRatOrCa.Caption := 'Max R.';
      end;

      frmTimeSerPlot.cbTraceDivMinClick(Sender);
      frmTimeSerPlot.sbSetRange.Down := False;
      frmTimeSerPlot.sbSetRange.Enabled := False;
      CtSetNr := 1;
      CurrClrTablInd := 1;
      DoChannelRatio(DO_COPY);

    End; {(ChannelsRatioOn = True)}

      {-----  Here Updates Windows  ----------}
    DontModColTable := True;
    If ((ColTableSetings.ColTblIndex[0] <> ColTableSetings.ColTblIndex[1]) or
         (ColTableSetings.Gamma[0]      <> ColTableSetings.Gamma[1]) or
         (ColTableSetings.Brightness[0] <> ColTableSetings.Brightness[1]) or
         (ColTableSetings.Contrast[0]   <> ColTableSetings.Contrast[1]))
        And (Not(ubFileColTable.Selected)) then Begin
      ColorTables.ItemIndex :=  ColTableSetings.ColTblIndex[CtSetNr];
      LoadColTable(CtSetNr);
      trbContrast.Position   := ColTableSetings.Contrast[CtSetNr];
      trbGamma.Position      := ColTableSetings.Gamma[CtSetNr];
      trbBrightness.Position := ColTableSetings.Brightness[CtSetNr];
      enContrast.NumberOne   := trbContrast.Position;
      enBrightness.NumberOne := trbBrightness.Position;
      enGamma.NumberFloat    := trbGamma.Position/10;
      SetBottomColTableSettings;
      ModifyColTable(CtSetNr);
      PaintHistWindow;
      RePaintAvIm := False;   //Not to Refresh Av Image//
      UpdateAllWindows(sender);
      RePaintAvIm := True;
    End
      Else
    Begin  //If All Col Table Settings are the same
      UpdateMainImage(True);
      {--- Line Scan------}
      If (LineScanExist) then begin
        if (ChannelsRatioOn) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO) else
                                  frmLineScan.UpdateLSwindows(RELOAD_DISPL);
      End;
      {----------------   3D Image  ------------------------ }
      if (Win3DOn) then frm3DImageWin.Update3DImage(True);
        {---------------- end 3D Image -----------------------}
    End; //Else Begin = If All Col Table Settings are the same

      DontModColTable := False;

 with frmTimeSerPlot do begin
  if (TimPltSlid.TimeSerAnalMode = INTENSITY) then begin
    lbThreshold.Enabled := True;
    enThreshForArea.Enabled := True;
  end
    else
  begin
    lbThreshold.Enabled := False;
    enThreshForArea.Enabled := False;
  end;
 end;

End;   //procedure TfrmImageControl.unCh1DivCh2Click(Sender: TObject);
{****************************************************************************}

procedure TfrmImageControl.SetBottomColTableSettings;
begin
  with BottomColTableSettings do begin;
  if (BottomState[CurrClrTablInd] = 0) then begin
    BlackBottom.Down := False;
    WhiteBottom.Down := False;
  end
    else
  if (BottomState[CurrClrTablInd] = 1) then begin
    BlackBottom.Down := True;
    WhiteBottom.Down := False;
    trbBottomRegionOfColorTable.Enabled := True;
    enBottomRegionOfColorTable.Enabled  := True;
  end
    else
  if (BottomState[CurrClrTablInd] = 2) then begin
    WhiteBottom.Down := True;
    BlackBottom.Down := False;
  end;
  if (BottomState[CurrClrTablInd] = 0) then begin
    trbBottomRegionOfColorTable.Enabled := False;
    enBottomRegionOfColorTable.Enabled  := False;
  end
    else
  begin
    trbBottomRegionOfColorTable.Enabled := True;
    enBottomRegionOfColorTable.Enabled  := True;
  end;

   trbBottomRegionOfColorTable.Position := BottomValue[CurrClrTablInd];
  end;

end;

procedure TfrmImageControl.ubRatioOnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;
begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 28;
  GetHelp(HelpCode);
 end;
end;

{*****************************************************************************}

procedure TfrmImageControl.enMaxRatioReturnPressed(Sender: TObject);
begin
  trbMaxRatio.Position := round(enMaxRatio.NumberFloat*100);
end;

procedure TfrmImageControl.trbMaxRatioChange(Sender: TObject);
Begin

If (MaxRatio*100 <> trbMaxRatio.Position) Then Begin
  MaxRatio := trbMaxRatio.Position/100;
  DispFact := 255/MaxRatio;
  enMaxRatio.NumberFloat := MaxRatio;
  If (RatioOn)or (ChannelsRatioOn) then begin
    PutTicksOnColorBar;
     {All Buffers are ready ; Only DoRatio is needed}
    if (RatioOn) then DoRatio(DO_COPY)
      else
    if (ChannelsRatioOn) then DoChannelRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(RELOAD_DISPL);
   {---------------- end Line Scan -----------------------}

    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End;
 End; {If MaxRatio*10 <> trbMaxRatio.Position Then Begin}
End;

// ---------- merge images  ----------------------//
procedure TfrmImageControl.cbDoLineScanOfMergeImageClick(Sender: TObject);
begin
  If not(RatioOn) and not(ChannelsRatioOn)  then Begin
    if (LineScanExist) then frmLineScan.UpdateLSwindows(RELOAD_DISPL);
     {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(True);
   {---------------- end 3D Image -----------------------}
  End;
end;

procedure TfrmImageControl.cbDoLineScanOfMergeImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;
begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 50;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.cbMergeModelChange(Sender: TObject);
begin
  MergeModel := cbMergeModel.ItemIndex;
  if (MergeModel = MERGE) then begin
    trbOverlayThreshold.Enabled := False;
    enOverlayThreshold.Enabled  := False;
  end else
  begin
    trbOverlayThreshold.Enabled := True;
    enOverlayThreshold.Enabled  := True;
  end;

  if (MainImLoaded) and (NrChannels > 1) then
  begin
    if  (ChannelOrder = ASCENDING)  then
      MergeImagesTo32bit(ImDispl, Im2ndDispl ,MergeImDispl,imXsize,imYsize)
    else
    if (ChannelOrder = DESCENDING)  then
      MergeImagesTo32bit(Im2ndDispl,ImDispl,MergeImDispl,imXsize,imYsize);
    if (frmMergeWin <> nil) then DisplayMergeImage;
    if (LineScanExist) and (cbDoLineScanOfMergeImage.Checked) then
      frmLineScan.UpdateLSwindows(RELOAD_DISPL);
  end;

  if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(False,True);
  end;

end;

procedure TfrmImageControl.enOverlayThresholdReturnPressed(Sender: TObject);
begin
  trbOverlayThreshold.Position := enOverlayThreshold.NumberOne;
end;

procedure TfrmImageControl.trbOverlayThresholdChange(Sender: TObject);
begin
  OverlayThreshold := trbOverlayThreshold.Position;
  enOverlayThreshold.NumberOne := OverlayThreshold;
  if (MainImLoaded) and (NrChannels > 1) then
  begin
   if  (ChannelOrder = ASCENDING)  then
      MergeImagesTo32bit(ImDispl, Im2ndDispl ,MergeImDispl,imXsize,imYsize)
   else
   if (ChannelOrder = DESCENDING)  then
      MergeImagesTo32bit(Im2ndDispl,ImDispl,MergeImDispl,imXsize,imYsize);
    if (frmMergeWin <> nil) then DisplayMergeImage;
    if (LineScanExist) and (cbDoLineScanOfMergeImage.Checked) then
      frmLineScan.UpdateLSwindows(RELOAD_DISPL);
  end;

  if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(False,True);
  end;

End;
// ----------End of  merge iameges  ----------------------//

{ procedure TfrmImageControl.trbMaxRatioChange(Sender: TObject);}
 {*****************************************************************************}

procedure TfrmImageControl.enBottomRegionOfColorTableReturnPressed(Sender: TObject);
begin
  trbBottomRegionOfColorTable.Position := enBottomRegionOfColorTable.NumberOne;
end;

procedure TfrmImageControl.trbBottomRegionOfColorTableChange(Sender: TObject);
begin
  enBottomRegionOfColorTable.NumberOne := trbBottomRegionOfColorTable.Position;
  BottomColTableSettings.BottomValue[CurrClrTablInd] := trbBottomRegionOfColorTable.Position;
  if (BlackBottom.Down) or (WhiteBottom.Down) then begin
    ModifyColTable(CurrClrTablInd);
    UpdateAllWindows(sender);
  end;
End;

procedure TfrmImageControl.WhiteBottomClick(Sender: TObject);
begin
  if (BlackBottom.Down) then BlackBottom.Down := False;
  trbBottomRegionOfColorTable.Enabled := WhiteBottom.Down;
  enBottomRegionOfColorTable.Enabled  := WhiteBottom.Down;
  with BottomColTableSettings do begin // 0 = Nothing, 1 = Black, 2 = White
  if (WhiteBottom.Down) then
    BottomState[CurrClrTablInd] := 2
  else
    BottomState[CurrClrTablInd] := 0;
  end;
  ModifyColTable(CurrClrTablInd);
  UpdateAllWindows(sender);
End;

procedure TfrmImageControl.BlackBottomClick(Sender: TObject);
begin

  if (WhiteBottom.Down) then WhiteBottom.Down := False;
  trbBottomRegionOfColorTable.Enabled := BlackBottom.Down;
  enBottomRegionOfColorTable.Enabled  := BlackBottom.Down;
  with BottomColTableSettings do begin // 0 = Nothing, 1 = Black, 2 = White
  if (BlackBottom.Down) then
    BottomState[CurrClrTablInd] := 1
  else
    BottomState[CurrClrTablInd] := 0;
  end;
  ModifyColTable(CurrClrTablInd);
  UpdateAllWindows(sender);
End;
{*****************************************************************************}
procedure TfrmImageControl.ResetColTblClick(Sender: TObject);
Begin

      DontModColTable := True;   //to prevent updating image by each slider
      trbContrast.Position        := 255;
      enContrast.NumberOne        := 255;
      trbBrightness.Position      := 0;
      enBrightness.NumberOne      := 0;
      trbBrightness.Position      := 0;
      trbGamma.Position           := 10;
      enGamma.NumberFloat         := 1.0;
      ColTableSetings.Contrast  [CurrClrTablInd] := trbContrast.Position;
      ColTableSetings.Brightness[CurrClrTablInd] := trbBrightness.Position;
      ColTableSetings.Gamma     [CurrClrTablInd] := trbGamma.Position;
      ModifyColTable(CurrClrTablInd);
      DontModColTable := False;
      PaintHistWindow;
      UpdateAllWindows(sender);

End; {procedure TfrmImageControl.ResetColTblClick(Sender: TObject); }
 {******************************************************************************}

Procedure TfrmImageControl.UpdateAllWindows(sender : TObject); //Updates all the Windows
Begin

  //--------- Main Window, 2nd Window and Merge Window ---------------------}
  If (MainImLoaded) and (AllowWindowsUpdate) then Begin
      if ((ub1stChannel.Selected) and (ChannelOrder = ASCENDING)) Or
         ((ub2ndChannel.Selected) and (ChannelOrder = DESCENDING)) Or
         (Sender = ubFileColTable) or (Sender = ubRatioOn) Or
         (Sender = unChDivCh) Or (Sender = frmPlayback.ubRatioOn_PlayBack) Or
         (RatioOn) Or (ChannelsRatioOn)
      then

      UpdateMainImage(True);
      If (NrChannels = 2) then Begin
        if (frm2ndWin <> nil) then begin
        if ((ub2ndChannel.Selected) and (ChannelOrder = ASCENDING)) Or
           ((ub1stChannel.Selected) and (ChannelOrder = DESCENDING)) Or
           (Sender = ubFileColTable) then
          Display2ndChannel;
        end;
        if  (ChannelOrder = ASCENDING)  then
          MergeImagesTo32bit(ImDispl, Im2ndDispl ,MergeImDispl,imXsize,imYsize)
        else
        if (ChannelOrder = DESCENDING)  then
          MergeImagesTo32bit(Im2ndDispl,ImDispl,MergeImDispl,imXsize,imYsize);
        if (frmMergeWin <> nil) then DisplayMergeImage;
      End; //If (NrChannels = 2) then Begin
  End;

  //-------------- Average Window------------------//
  If (AvImExists > 0) and (RatioOn = False) and (frmAverIm <> nil) then Begin
     If (frmAverIm <> nil) and (RePaintAvIm = True) and
     (((ub1stChannel.Selected) and (AvImChOrig = 1)) Or
      ((ub2ndChannel.Selected) and (AvImChOrig = 2))) Or
       (Sender = ubFileColTable)
      Then UpdateAverImage(True);
  End; {many conditions}

  {----------------  Line Scan Window  ------------------------}
  If (LineScanExist) then Begin
    With frmPlayback do begin
    If (sender = ubRatioOn) or (sender = unChDivCh) then Begin
      if (RatioOn) and not(ChannelsRatioOn) then frmLineScan.UpdateLSwindows(REDO_RATIO) else
      if (ChannelsRatioOn) and not(RatioOn) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO) else
                                                 frmLineScan.UpdateLSwindows(RELOAD_DISPL);
      if (Win3DOn) and (SourceFor3D = LSCAN_IMAGE_FOR_3D) then
        frm3DImageWin.Update3DImage(True);
    End
      Else
    If (sender = DeselectOne) or (sender = Deselect10) or (sender = DeselectAll) then begin
        frmLineScan.UpdateLSwindows(RELOAD_DISPL);
        if (Win3DOn) and (SourceFor3D = LSCAN_IMAGE_FOR_3D) then
          frm3DImageWin.Update3DImage(True);
    End
      Else
    Begin
      if (NrChannels = 1) or not((NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked)) then
      begin
        frmLineScan.UpdateLSwindows(REFRESH_ONLY);
        if (Win3DOn) and (SourceFor3D = LSCAN_IMAGE_FOR_3D) then frm3DImageWin.Update3DImage(False);
      end else
      if (NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked) then
        frmLineScan.UpdateLSwindows(RELOAD_DISPL);
    End; //else begin
    End;//with frmPlayback
  End;//If (LineScanExist)
  {---------------- end Line Scan -----------------------}

 {----------------   3D Image  ------------------------}
 if (Win3DOn) and (SourceFor3D <> LSCAN_IMAGE_FOR_3D) then frm3DImageWin.Update3DImage(False);
 {---------------- end 3D Image -----------------------}

 if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(False,True);
 end;

 {-------------------- Real Line Scan Window --------------------}

 if (RealLineScanOn) then frmRealLineScan.DoUpdateRealLineScan;;

 {---------------------------------------------------------------}

  //---  Redraws Color Bar ---//
  UpdateColorBar;
  PutTicksOnColorBar; //--- prints Ticks & Letters on Color Bar --------//ge//
     //--End of redrawing Color bar --//

End; //Procedure TfrmImageControl.UpdateAllWindows;

{******************************************************************************}

procedure TfrmImageControl.UpdateColorBar;
var pBarDat      : Pointer;
begin

  with lpBitmapInfo[CurrClrTablInd]^.bmiHeader do begin
          biWidth        := 16;  {Bitmap.Width in pixels}
          biHeight       := 256;
  End;   {with header.bmiHeader}

  pBarDat := @BarDat[0];
  with ColorBar do begin

  StretchDIBits(Canvas.Handle,0,8,16,256,0,0,16,256,
                  pBarDat,lpBitmapInfo[CurrClrTablInd]^,DIB_RGB_COLORS,SRCCOPY);
  Repaint;
  end;

  with lpBitmapInfo[CurrClrTablInd]^.bmiHeader do begin
          biWidth        := imXsize;  {Bitmap.Width in pixels}
          biHeight       := -imYsize;
  End;   {with header.bmiHeader}

end;
 {******************************************************************************}
 Procedure TfrmImageControl.PutTicksOnColorBar;
    var
       TickSize, NrTicks, TickPos, X,MaxRatInt : Integer;
       Tval, TickInc : Single;
  Begin

  with ColorBar.Canvas do begin
     Font.Name := 'Ariel';
     Font.Size := 10;
     Font.Color := clBlack;
     Brush.Color := clWhite;
      FillRect(Rect(16,0,52,272));
     Brush.Style := bsClear;
     {----- Puts Ticks ----------------}
     Pen.Color := clBlack;

     If Not(RatioOn) and Not(ChannelsRatioOn) then Begin
      {divides 256 or 1024 by 4}
      MoveTo(18,8);
      LineTo(23,8);   {Y - 4 for the text}
      MoveTo(18,71);    {8 + 64 }
      LineTo(23,71);
      MoveTo(18,135);
      LineTo(23,135);
      MoveTo(18,199);    {Y = 8 is where the Colr Bar Starts}
      LineTo(23,199);
      MoveTo(18,263);    {Y = 8 is where the Colr Bar Starts}
      LineTo(23,263);

      TextOut(25,0,'255');
      TextOut(25,63,'191');
      TextOut(25,127,'127');
      TextOut(25,191,'63');
      TextOut(25,255,'0');

    End

      Else

    If (RatioOn) or (ChannelsRatioOn) then Begin
             MaxRatInt := frmImageControl.trbMaxRatio.Position;

          if (MaxRatInt <= 20) then begin
             TickSize := round(25600/(MaxRatInt*50));
             TickInc  := 0.02;
          end else
          if (MaxRatInt > 20) and (MaxRatInt <= 40) then begin
             TickSize := round(25600/(MaxRatInt*20));
             TickInc  := 0.05;
          end else
          if (MaxRatInt > 40) and (MaxRatInt <= 80) then begin
             TickSize := round(25600/(MaxRatInt*10));
             TickInc  := 0.10;
          end else
          if (MaxRatInt > 80) and (MaxRatInt <= 160) then begin
             TickSize := round(25600/(MaxRatInt*5));
             TickInc  := 0.20;
          end else
          if (MaxRatInt > 160) and (MaxRatInt <= 400) then begin
             TickSize := round(25600/(MaxRatInt*2));
             TickInc  := 0.5;
          end else
          if (MaxRatInt > 400) and (MaxRatInt <= 800) then begin
             TickSize := round(25600/MaxRatInt);
             TickInc  := 1;
          end else
          if (MaxRatInt > 800) then begin
             TickSize := round(51200/MaxRatInt);
             TickInc  := 2;
          end;
            NrTicks   := 256 div TickSize;      {Number of Ticks}
            TickPos   := 263 - TickSize;
            Tval      := TickInc; {F/Fo}
        For X := 1 to NrTicks Do Begin   {Starts from 0.5 F/Fo}
            {Zero is AT Y = 263}
          MoveTo(18,TickPos);    {Y = 8 is where the Colr Bar Starts}
          LineTo(23,TickPos);
          if (Tval >= 0.1) then
          TextOut(25,TickPos-8,FloatToStrF(Tval,ffFixed,3,1))
          else
          TextOut(25,TickPos-8,FloatToStrF(Tval,ffFixed,3,2));
          Dec(TickPos,TickSize);
          Tval := Tval + TickInc;

        end;

    End; {RatioOn = False}
 end;//with

End;    {Procedure PutTicksOnColorBar;}

{**************************************************************************}

procedure TfrmImageControl.enBackSubtrMainWindowReturnPressed(Sender: TObject);
var OnChangeMem : TNotifyEvent;
    BkgRange    : Integer;
    BitDepthOfImage : Byte;

begin
  OnChangeMem := trbBackSubtr.OnChange;
  trbBackSubtr.OnChange := nil;

  {this does not work when Form is created-it always sets it to Zero
   later when file is open it works properly}
  trbBackSubtr.Min := enBackSubtrMainWindow.NumberOne - 100;
  if (trbBackSubtr.Min  < 0) then
  trbBackSubtr.Min      := 0;
  trbBackSubtr.Max      := enBackSubtrMainWindow.NumberOne + 100; //this works always
  if (trbBackSubtr.Max > enBackSubtrMainWindow.Max) then
  trbBackSubtr.Max := Trunc(enBackSubtrMainWindow.Max);

  trbBackSubtr.Position := enBackSubtrMainWindow.NumberOne; //this works always
  Bkg := enBackSubtrMainWindow.NumberOne;
  BkgValues[MovFType] := Bkg;
  trbBackSubtr.OnChange := OnChangeMem;

  if (ChannelOrder = DESCENDING) then begin
    Bkg2nd := Bkg;
    Bkg := enBackSubtr2ndWindow.NumberOne;
  end;

  If (RatioOn = True) then begin
    if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then begin
      SmoothAverIm(AvImRaw,AvIm); {refreshes AvIm}
    end;
    DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
    DoRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
   {---------------- end Line Scan -----------------------}
    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End //If (RatioOn = True) then begin
    Else
  If (ChannelsRatioOn) then begin
    DoChannelRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO );
   {---------------- end Line Scan -----------------------}
    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End; //IIf (ChannelsRatioOn)

End; //enBackSubtrMainWindow

procedure TfrmImageControl.SwapBKGs(Sender: TObject);
var TempBKG : Word;
begin
   TempBKG := Bkg;
   Bkg     := Bkg2nd;
   Bkg2nd :=  TempBKG;
end;

procedure TfrmImageControl.enBackSubtr2ndWindowReturnPressed(Sender: TObject);
var OnChangeMem : TNotifyEvent;
    BkgRange    : Integer;
    BitDepthOfImage : Byte;

begin
  OnChangeMem := trbBack2ndWinSubtr.OnChange;
  trbBack2ndWinSubtr.OnChange := nil;

  {this does not work when Form is created-it always sets it to Zero
   later when file is open it works properly}
  trbBack2ndWinSubtr.Min := enBackSubtr2ndWindow.NumberOne - 100;
  if (trbBack2ndWinSubtr.Min < 0) then
  trbBack2ndWinSubtr.Min      := 0;
  trbBack2ndWinSubtr.Max      := enBackSubtr2ndWindow.NumberOne + 100; //this works always
  if (trbBack2ndWinSubtr.Max > enBackSubtr2ndWindow.Max) then
  trbBack2ndWinSubtr.Max := Trunc(enBackSubtr2ndWindow.Max);

  trbBack2ndWinSubtr.Position := enBackSubtr2ndWindow.NumberOne; //this works always
  Bkg2nd := enBackSubtr2ndWindow.NumberOne;
  Bkg2ndValues[MovFType] := Bkg2nd;
  trbBack2ndWinSubtr.OnChange := OnChangeMem;

  if (ChannelOrder = DESCENDING) then begin
    Bkg := Bkg2nd;
    Bkg2nd := enBackSubtrMainWindow.NumberOne;
   end;;

  If (ChannelsRatioOn) then begin
    DoChannelRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO );
   {---------------- end Line Scan -----------------------}
    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End; //If (RatioOn = True) then begin

end; //enBack2ndWindow

procedure TfrmImageControl.trbBackSubtrChange(Sender: TObject);
Begin

 If (Bkg <> trbBackSubtr.Position) Then Begin
   Bkg := trbBackSubtr.Position;
   BkgValues[MovFType] := Bkg;
   enBackSubtrMainWindow.NumberOne := trbBackSubtr.Position;

   if (ChannelOrder = DESCENDING) then begin
    Bkg2nd := Bkg;
    Bkg := enBackSubtr2ndWindow.NumberOne;
   end;

   If (RatioOn = True) then begin
    if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then begin
      SmoothAverIm(AvImRaw,AvIm); {refreshes AvIm}
    end;
    DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
    DoRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
   {---------------- end Line Scan -----------------------}
    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End //If (RatioOn = True) then begin
    Else
  If (ChannelsRatioOn) then begin
    DoChannelRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO);
   {---------------- end Line Scan -----------------------}
    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End; //IIf (ChannelsRatioOn)
 End; {If Bkg <> trbBackSubtr.Position}
End; //procedure TfrmImageControl.trbBackSubtrChange(Sender: TObject)

procedure TfrmImageControl.trbBack2ndWinSubtrChange(Sender: TObject);
begin

 If (Bkg2nd <> trbBack2ndWinSubtr.Position) Then Begin
   Bkg2nd := trbBack2ndWinSubtr.Position;
   Bkg2ndValues[MovFType] := Bkg2nd;
   enBackSubtr2ndWindow.NumberOne := trbBack2ndWinSubtr.Position;

  if (ChannelOrder = DESCENDING) then begin
    Bkg := Bkg2nd;
    Bkg2nd := enBackSubtrMainWindow.NumberOne;
  end;

  If (ChannelsRatioOn) then begin
    DoChannelRatio(DO_COPY);
    UpdateMainImage(True);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO);
   {---------------- end Line Scan -----------------------}
    {----------------   3D Image  ------------------------}
    if (Win3DOn) then frm3DImageWin.Update3DImage(False);
    {---------------- end 3D Image -----------------------}
  End; //If (ChannelsRatioOn) then begin
 End; {If Bkg <> trbBackSubtr.Position}

end;
{************************************************************************}
procedure TfrmImageControl.enCutOffReturnPressed(Sender: TObject);
var OnChangeMem : TNotifyEvent;
begin
 // trbCutOff.Position := enCutOff.NumberOne;

  OnChangeMem := trbCutOff.OnChange;
  trbCutOff.OnChange := nil;

  {this does not work when Form is created-it always sets it to Zero
   later when file is open it works properly}
  trbCutOff.Min := enCutOff.NumberOne - 50;
  if (trbCutOff.Min  < 0) then
  trbCutOff.Min      := 0;
  trbCutOff.Max      := enCutOff.NumberOne + 50; //this works always
  if (trbCutOff.Max > enCutOff.Max) then
  trbCutOff.Max := Trunc(enCutOff.Max);

  trbCutOff.Position := enCutOff.NumberOne; //this works always
  CutOff := enCutOff.NumberOne;
  trbCutOff.OnChange := OnChangeMem;
  trbCutOffChange(Sender);
end;

procedure TfrmImageControl.trbCutOffChange(Sender: TObject);
{!!! CutOff is Applied to Average Image ONLY (Not The Raw, the working One}
Begin
  //If (CutOff <> trbCutOff.Position) Then Begin
    CutOff := trbCutOff.Position;
    enCutOff.NumberOne := trbCutOff.Position;
    if not(RatioOn) and (MainImLoaded) then Begin
      frmPlayback.PlaybackScrollBarChange(Sender);
    End
      Else
    If (RatioOn) then begin
      if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then SmoothAverIm(AvImRaw,AvIm); {refreshes AvIm}
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
      DoRatio(DO_COPY);
      UpdateMainImage(True);
      {----------------  Line Scan  ------------------------}
      if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_RATIO);
      {---------------- end Line Scan -----------------------}
      {----------------   3D Image  ------------------------}
      if (Win3DOn) then frm3DImageWin.Update3DImage(False);
      {---------------- end 3D Image -----------------------}

     End //If (RatioOn = True) then begin
      Else
     If (ChannelsRatioOn) then begin
      DoChannelRatio(DO_COPY);
      UpdateMainImage(True);
      {----------------  Line Scan  ------------------------}
      if (LineScanExist) then frmLineScan.UpdateLSwindows(REDO_ChdivCh_RATIO );
      {---------------- end Line Scan -----------------------}
      {----------------   3D Image  ------------------------}
      if (Win3DOn) then frm3DImageWin.Update3DImage(False);
      {---------------- end 3D Image -----------------------}
     End; //If (RatioOn = True) then begin

 // End; {If CutOff <> trbCutOff.Position Then Begin}
End; {procedure TfrmImageControl.trbCutOffChange(Sender: TObject);}
 {************************************************************************}

procedure TfrmImageControl.scrBoxXsizeChange(Sender: TObject);
 var Xmicr : Double;
Begin
 //TScrollBar does not give many OnChange Events-just one -
 //TTrackBar Does!!!
     lblBoxXsize.Caption := IntToStr(scrBoxXsize.Position)+ ' p';
     Xmicr := PixSize*scrBoxXsize.Position;
     if Int(Xmicr) < 10 then
     lblXmicrons.Caption := FloatToStrF(Xmicr,ffFixed,3,2) + ' µ' else
     lblXmicrons.Caption := FloatToStrF(Xmicr,ffFixed,3,1) + ' µ';
     ROIrct.Xsize := scrBoxXsize.Position;
     ROIrct.Rc := 1 - ROIrct.Xsize mod 2;
 if (MeasureBox.Down) then ROIvar.MesBoxXsize :=  ROIrct.Xsize else
 If not(MeasureBox.Down) then Begin
    if PlaceMark.Down = True then   ROIvar.MarkXsize   :=  ROIrct.Xsize else
    if PutBox.Down    = True then   ROIvar.BoxXsize    :=  ROIrct.Xsize;
  End; //If MeasureBox.Down    = False
End;

procedure TfrmImageControl.scrBoxXsizeMouseEnter(Sender: TObject);
begin
  if (scrBoxXsize.Focused) then begin
    TitleXofROI.Font.Color := clAqua;
    ScrBarMouseIn := scrBoxXsize;
  end;
end;

procedure TfrmImageControl.scrBoxXsizeMouseLeave(Sender: TObject);
begin
    ScrBarMouseIn := nil;
    TitleXofROI.Font.Color := clNavy;
end;

{************************************************************************}
procedure TfrmImageControl.scrBoxYSizeChange(Sender: TObject);
   var Ymicr : Double;
begin

    lblBoxYsize.Caption := IntToStr(scrBoxYsize.Position)+ ' p';
    Ymicr := PixSize*scrBoxYsize.Position;
    if int(Ymicr) < 10 then
    lblYmicrons.Caption := FloatToStrF(Ymicr,ffFixed,3,2)+ ' µ' else
    lblYmicrons.Caption := FloatToStrF(Ymicr,ffFixed,3,1)+ ' µ';
    
If Not(LineScanPlotRange.Down) Then Begin
    scrBoxYSize.Max := imYSize - 2; //resets it if changed by (LineScanPlotRange.Down)
    ROIrct.Ysize  := scrBoxYsize.Position;
    ROIrct.Bc     := 1 - ROIrct.Ysize mod 2;
  if MeasureBox.Down    = True then ROIvar.MesBoxYsize :=  ROIrct.Ysize else
  If MeasureBox.Down    = False then Begin
    if PlaceMark.Down = True then ROIvar.MarkYsize     :=  ROIrct.Ysize else
    if PutBox.Down    = True then ROIvar.BoxYsize      :=  ROIrct.Ysize;
   End; //If MeasureBox.Down    = False
End Else //If Not(LineScanPlotRange.Down) Then Begin
If (LineScanPlotRange.Down) Then Begin
  if (LineScanExist) then scrBoxYSize.Max := frmLineScan.ScanHeight-2;
  MesLineVar.LSROI := scrBoxYsize.Position;
End;

End;

procedure TfrmImageControl.scrBoxYSizeMouseEnter(Sender: TObject);
begin
   if (scrBoxYsize.Focused) then begin
    ScrBarMouseIn := scrBoxYsize;
    TitleYofROI.Font.Color := clAqua;
   end;
end;

procedure TfrmImageControl.scrBoxYSizeMouseLeave(Sender: TObject);
begin
    ScrBarMouseIn := nil;
    TitleYofROI.Font.Color := clNavy;
end;

//procedure TfrmImageControl.scrBoxYSizeChange
{********************** Here Starts Tools Group ***********************}

procedure TfrmImageControl.SetXYsizeLabels;
var XYmicr : Double;
    Precis : Integer;
begin
if (scrBoxXsize.Enabled) then Begin
  lblBoxXsize.Caption := IntToStr(scrBoxXsize.Position) + ' p';
  XYmicr := PixSize*scrBoxXsize.Position;
  if Int(XYmicr) < 10 then Precis := 2 else Precis := 1;
  lblXmicrons.Caption := FloatToStrF(XYmicr,ffFixed,3,Precis)+ ' µ';
end;
if (scrBoxYsize.Enabled) then Begin
  lblBoxYsize.Caption := IntToStr(scrBoxYsize.Position) + ' p';
  XYmicr := PixSize*scrBoxYsize.Position;
  if Int(XYmicr) < 10 then Precis := 2 else Precis := 1;
  lblYmicrons.Caption := FloatToStrF(XYmicr,ffFixed,3,Precis)+ ' µ';
end;
end;

procedure TfrmImageControl.DeleteAllClick(Sender: TObject);
 var i : integer;
begin
   For i := 1 to 20 Do Begin
    ROIvar.ROIAdr[i] := 0;  {Zeroes Out the Array=No Selections}
    FhPol[i] := nil;
    FhTbl[i] := nil;
   End;
    ROIvar.NrROI := 0;
    UpdateMainImage(True);
    if (frmAverIm <> nil) and (AvImExists > 0) then
    UpdateAverImage(True);

    if btZeroOutsideROI_All_Images.Down then begin
      btZeroOutsideROI_All_Images.Down := False;
      btZeroOutsideROI_All_Images.Click;
    end;
 
End;

procedure TfrmImageControl.DoLineScanClick(Sender: TObject);
begin
   if (MesLine.OpCode = DO_EXIST) and (MovieSeriesType <> LineScan) then begin
    if (JumpAv = 1) then  begin
    if (frmLineScan = nil) then Application.CreateForm(TfrmLineScan,frmLineScan);
    frmLineScan.DoLineScan;
    {----------------   3D Image  ------------------------}
    if (Win3DOn) and (SourceFor3D = LSCAN_IMAGE_FOR_3D) then frm3DImageWin.Update3DImage(True);
    {---------------- end 3D Image -----------------------}
    end else
    MessageDlg('Line Scan Works in "Normal Mode" Image Display',mtInformation,[mbOK],0)
   end
    else
   begin
   if (MainImLoaded) then begin
    if (MovieSeriesType <> LineScan) then
      MessageDlg('Draw a Line First',mtInformation,[mbOK],0)
      else
    if (MovieSeriesType = LineScan) then
      MessageDlg('This is a "Real" Line Scan File.  Does Not generate Pseudo-line scan from a Line Scan',mtInformation,[mbOK],0)
   end
      else
    if not(MainImLoaded) then MessageDlg('Open a File and Draw a Line First',mtInformation,[mbOK],0)
   end;
end;

procedure TfrmImageControl.GetROISurfaceClick(Sender: TObject);
var NrFreeHandROIs : Integer;
begin

If  (ROIvar.NrROI > 0) then Begin

  NrFreeHandROIs := GetFreeHandROInumber;

  If (NrFreeHandROIs > 0) then Begin
    if (frmSurfaceROI <> nil) then begin
      if (frmSurfaceROI.SurfaceStringGrid.RowCount <> NrFreeHandROIs + 1) then begin
      frmSurfaceROI.SurfaceStringGrid.RowCount := NrFreeHandROIs + 1;
      frmSurfaceROI.UpdateSize;
      end;
      frmSurfaceROI.FillSurfaceTable;
    end else
    if (frmSurfaceROI = nil) then Application.CreateForm(TfrmSurfaceROI,frmSurfaceROI);
  //it refils by itself
  End;
End Else
MessageDlg('There is No ROIs',mtError,[mbOK],0);

End; //GetROISurfaceClick

procedure TfrmImageControl.SetFrmPlaybackValueTitle;
begin

    if not(RatioOn) and not(ChannelsratioOn) then frmPlayback.titValueType.Caption := 'Intensity' else
    if (RatioOn)  then frmPlayback.titValueType.Caption := 'F/Fo' else
    if (ChannelsratioOn) then begin
      if (ChannelOrder = ASCENDING) then
        if not(MeasureDistance.Down) then frmPlayback.titValueType.Caption := 'Ch1/Ch2'
          else
      if (ChannelOrder = DESCENDING) then
        if not(MeasureDistance.Down) then frmPlayback.titValueType.Caption := 'Ch2/Ch1';
    end;
end;


procedure TfrmImageControl.SelectClick(Sender: TObject);
begin

    if (SelFrameVisible) then SelectionFrameChange.Click;
    frmPlayback.lblROIval.Caption := '';
    SetFrmPlaybackValueTitle;

    MeasureBox.Down     := False;
    MeasureBox.Enabled  := False;
    scrBoxXsize.Min     := 1;
    scrBoxYsize.Min     := 1;
    scrBoxXsize.Enabled := False;
    scrBoxYsize.Enabled := False;
    frmMainWin.winMainImage.Cursor := crArrow;
    if (frmAverIm <> nil) then
    frmAverIm.winAverImage.Cursor := crArrow;
    lblBoxXsize.Caption := '';
    lblXmicrons.Caption := '';
    lblBoxYsize.Caption := '';
    lblYmicrons.Caption := '';
End;

procedure TfrmImageControl.MeasureBoxClick(Sender: TObject);
Begin
     If (MeasureBox.Down) Then Begin
      scrBoxXsize.Enabled  := True;
      scrBoxYsize.Enabled  := True;
      scrBoxXsize.Min     := 1;
      scrBoxYsize.Min     := 1;
      scrBoxXsize.Position := ROIvar.MesBoxXsize;
      scrBoxYsize.Position := ROIvar.MesBoxYsize;
      ROIrct.Xsize  :=  ROIvar.MesBoxXsize;
      ROIrct.Rc     := 1 - ROIrct.Xsize mod 2;
      ROIrct.Ysize  := ROIvar.MesBoxYsize;
      ROIrct.Bc     := 1 - ROIrct.Ysize mod 2;
      frmMainWin.winMainImage.Cursor := crCross;
     End
      Else
     If not(MeasureBox.Down) Then Begin
        frmMainWin.winMainImage.Canvas.Pen.Style := psSolid;
       If (PlaceMark.Down) Then Begin
        scrBoxXsize.Enabled  := True;
        scrBoxYsize.Enabled  := True;
        scrBoxXsize.Min     := 1;
        scrBoxYsize.Min     := 1;
        scrBoxXsize.Position := ROIvar.MarkXsize;
        scrBoxYsize.Position := ROIvar.MarkYsize;
        ROIrct.Xsize :=  ROIvar.MarkXsize;
        ROIrct.Rc    := 1 - ROIrct.Xsize mod 2;
        ROIrct.Ysize := ROIvar.MarkYsize;
        ROIrct.Bc    := 1 - ROIrct.Ysize mod 2;
        frmMainWin.winMainImage.Cursor := crCross;
      End
        Else
      If (PutBox.Down) Then Begin
        scrBoxXsize.Enabled  := True;
        scrBoxYsize.Enabled  := True;
        scrBoxXsize.Min     := 1;
        scrBoxYsize.Min     := 1;
        scrBoxXsize.Position := ROIvar.BoxXsize;
        scrBoxYsize.Position := ROIvar.BoxYsize;
        ROIrct.Xsize :=  ROIvar.BoxXsize;
        ROIrct.Rc    := 1 - ROIrct.Xsize mod 2;
        ROIrct.Ysize := ROIvar.BoxYsize;
        ROIrct.Bc    := 1 - ROIrct.Ysize mod 2;
        frmMainWin.winMainImage.Cursor := crCross;
      End;
     End; //If not(MeasureBox.Down)
  SetXYsizeLabels;
End; {procedure TfrmImageControl.MeasureBoxClick}

procedure TfrmImageControl.PlaceMarkClick(Sender: TObject);
begin
      if (SelFrameVisible) then SelectionFrameChange.Click;
      frmPlayback.lblROIval.Caption := '';
      SetFrmPlaybackValueTitle;
      MeasureBox.Enabled  := True;
      If not(MeasureBox.Down) Then begin    //if Put Box was not pressed before
        scrBoxXsize.Enabled  := True;
        scrBoxYsize.Enabled  := True;
        scrBoxXsize.Min     := 1;
        scrBoxYsize.Min     := 1;
        scrBoxXsize.Position := ROIvar.MarkXsize;
        scrBoxYsize.Position := ROIvar.MarkYsize;
        ROIrct.Xsize :=  ROIvar.MarkXsize;
        ROIrct.Rc    := 1 - ROIrct.Xsize mod 2;
        ROIrct.Ysize := ROIvar.MarkYsize;
        ROIrct.Bc    := 1 - ROIrct.Ysize mod 2;
        frmMainWin.winMainImage.Cursor := crCross;
        if frmAverIm <> nil then
        frmAverIm.winAverImage.Cursor := crCross;
      End;
       SetXYsizeLabels;
End;

procedure TfrmImageControl.PutBoxClick(Sender: TObject);
begin
    if (SelFrameVisible) then SelectionFrameChange.Click;
    frmPlayback.lblROIval.Caption := '';
    SetFrmPlaybackValueTitle;
    MeasureBox.Enabled  := True;
    frmMainWin.winMainImage.Canvas.Pen.Style := psSolid;
    If not(MeasureBox.Down) Then begin //if Put Mark was not pressed before
      scrBoxXsize.Enabled  := True;
      scrBoxYsize.Enabled  := True;
      scrBoxXsize.Min     := 1;
      scrBoxYsize.Min     := 1;
      scrBoxXsize.Position := ROIvar.BoxXsize;
      scrBoxYsize.Position := ROIvar.BoxYsize;
      ROIrct.Xsize :=  ROIvar.BoxXsize;
      ROIrct.Rc := 1 - ROIrct.Xsize mod 2;
      ROIrct.Ysize  := ROIvar.BoxYsize;
      ROIrct.Bc     := 1 - ROIrct.Ysize mod 2;
      frmMainWin.winMainImage.Cursor := crCross;
      if (frmAverIm <> nil) then
      frmAverIm.winAverImage.Cursor := crCross;
    End;
  SetXYsizeLabels;
End;

procedure TfrmImageControl.MeasureDistanceClick(Sender: TObject);
begin

    if (SelFrameVisible) then SelectionFrameChange.Click;
    frmPlayback.lblROIval.Caption := '';
    frmPlayback.titValueType.Caption := 'Distance';
    frmMainWin.winMainImage.Cursor := crArrow;
    MeasureBox.Down     := False;
    MeasureBox.Enabled  := False;
    scrBoxXsize.Enabled := False;
    scrBoxYsize.Enabled := False;
    lblBoxXsize.Caption := '';
    lblXmicrons.Caption := '';
    lblBoxYsize.Caption := '';
    lblYmicrons.Caption := '';
    if frmAverIm <> nil then frmAverIm.winAverImage.Cursor := crArrow;

end;


procedure TfrmImageControl.LineScanPlotRangeClick(Sender: TObject);
begin
     {Change Event after Change of Down to true or false !!!}

    if (SelFrameVisible) then SelectionFrameChange.Click;
    frmPlayback.lblROIval.Caption := '';
    frmPlayback.titValueType.Caption := '';
    MeasureBox.Down     := False;
    MeasureBox.Enabled  := False;
    If (LineScanPlotRange.Down) Then begin
      scrBoxXsize.Enabled  := False;
      lblBoxXsize.Caption := '';
      lblXmicrons.Caption := '';
      scrBoxYsize.Enabled  := True;
      scrBoxYsize.Min     := 1;
      //Max i do not set, it is = imYsize; no need for more
      scrBoxYsize.Position := MesLineVar.LSROI;
      frmMainWin.winMainImage.Cursor := crCross;
      if frmAverIm <> nil then
      frmAverIm.winAverImage.Cursor := crCross;
    End;
  SetXYsizeLabels;
end;

procedure TfrmImageControl.MakeOutZero(Sender: TObject);

 var DoCrop : Boolean;

 Begin

    DoCrop := True;
 {------- Conditions -------------}
    If (AvImExists = 0) then Begin
      DoCrop := False;
      MessageDlg('Create Average Image',mtInformation,[mbOK],0);
    End Else
    if ROIvar.NrROI = 0 then begin
      DoCrop := False;
      MessageDlg('Create at Least One ROI',mtInformation,[mbOK],0);
    end;

    {-----------------------------------------------------------------------}
    If (DoCrop = True) And (AnalInAction = False) Then Begin
    
      SetLength(ImageZeroMap,ImagePix);
      ZeroOutsideROI(AvImRaw);
      ImageZeroMap := nil;
      CopyAvImToDisplBuffer;

      if (frmAverIm <> nil) then UpdateAverImage(True);

          {Updates Main Window if Ratio is On}
      If (RatioOn = True) then begin
        if (SmoothMode > 0) and (AutoSearchPar.SmoothBeforeDoRatio) then SmoothAverIm(AvImRaw,AvIm);
          DoBkgonAvIm; //Subtracts Bkg from AvIm Only
          DoRatio(DO_COPY);
          UpdateMainImage(True);
      End;
    End; {Many Conditions}
End;
 {*********************************************************************}

procedure TfrmImageControl.btZeroOutsideROI_All_ImagesClick(Sender: TObject);
 var UpdateImage : Boolean;
begin
    if (ROIvar.NrROI = 0) or Not(MainImLoaded) then begin
      btZeroOutsideROI_All_Images.Down := False;
      UpdateImage := False;
    end;

    if Not(btZeroOutsideROI_All_Images.Down) then begin
      if ImageZeroMap <> nil then begin
        ImageZeroMap := nil;
        UpdateImage := True;
      end;
    end;

    if (btZeroOutsideROI_All_Images.Down) then begin
        SetLength(ImageZeroMap,ImagePix);
        UpdateImage := True;
    end;

    If (UpdateImage) and (MainImLoaded) then frmPlayback.PlaybackScrollBarChange(Sender);

end;
 {*********************************************************************}

procedure TfrmImageControl.FreehandClick(Sender: TObject);
begin
  if (SelFrameVisible) then SelectionFrameChange.Click;
  frmPlayback.lblROIval.Caption := '';
  SetFrmPlaybackValueTitle;
  MeasureBox.Down     := False;
  MeasureBox.Enabled  := False;
  scrBoxXsize.Enabled := False;
  scrBoxYsize.Enabled := False;
  frmMainWin.winMainImage.Cursor := crArrow;
  if frmAverIm <> nil then frmAverIm.winAverImage.Cursor := crArrow;
  lblBoxXsize.Caption := '';
  lblXmicrons.Caption := '';
  lblBoxYsize.Caption := '';
  lblYmicrons.Caption := '';
End;

procedure TfrmImageControl.SelectionFrameChangeClick(Sender: TObject);
              {Resising of Selection Frame - changed March 2012}
begin

 If not(XYprofileRectVisible) then Begin

  SelFrameVisible := (SelectionFrameChange.Down) or (ubApplyFrame.Selected);

  if (MainImLoaded) and not(ubApplyFrame.Selected) then UpdateMainImage(True);

  //CheckIfSelFrameFits; - no need it has been done when a File is Open

  if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);
  if (NrChannels > 1) and (frmMergeWin <> nil) then DisplaymergeImage;
  if (NrChannels > 1) and (frm2ndWin <> nil)   then Display2ndChannel;

  lblBoxXsize.Visible := not(SelectionFrameChange.Down);
  lblBoxYsize.Visible := not(SelectionFrameChange.Down);

  lblXmicrons.Visible := not(SelectionFrameChange.Down);
  lblYmicrons.Visible := not(SelectionFrameChange.Down);

  scrBoxXsize.Visible := not(SelectionFrameChange.Down);
  scrBoxYsize.Visible := not(SelectionFrameChange.Down);


  if (SelectionFrameChange.Down) then begin
    TitleXofROI.Caption :=  'Width  = '  + IntToStr(SelFrame.Width+1) +
                           ';  L = '    + IntToStr(SelFrame.Left) +
                           ';  R = '   + IntToStr(SelFrame.Right);

    TitleYofROI.Caption := 'Height = ' + IntToStr(SelFrame.Height+1) +
                           '; T = '    + IntToStr(SelFrame.Top) +
                           '; B = '    + IntToStr(SelFrame.Bottom);

    if (MeasureBox.Down) = True then begin
      MeasureBox.Down     := False;
      MeasureBox.Enabled  := False;
    end;
  End
    else
  Begin
    TitleXofROI.Caption := 'X';
    TitleYofROI.Caption := 'Y';
  End;

 End; //If not(XYprofileRectVisible) then Begin

End;
{******************** End of Tools Botton Group **********************}


procedure TfrmImageControl.lblBkgMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 24;
    GetHelp(HelpCode);
  end;

end;

procedure TfrmImageControl.lblBkgMouseEnter(Sender: TObject);
begin
  lblBkg.Color := clAqua;
end;

procedure TfrmImageControl.lblBkgMouseLeave(Sender: TObject);
begin
  lblBkg.Color := clMedGray;
end;

procedure TfrmImageControl.lblBottomMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var  HelpCode : integer;
begin
   if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 57;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmImageControl.lblBottomMouseEnter(Sender: TObject);
begin
   lblBottom.Color := clAqua;
end;

procedure TfrmImageControl.lblBottomMouseLeave(Sender: TObject);
begin
  lblBottom.Color := clMedGray;
end;

procedure TfrmImageControl.lblCutOffMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 25;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.lblCutOffMouseEnter(Sender: TObject);
begin
   lblCutOff.Color := clAqua;
end;

procedure TfrmImageControl.lblCutOffMouseLeave(Sender: TObject);
begin
   lblCutOff.Color := clMedGray;
end;

procedure TfrmImageControl.lblMaxRatOrCaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 23;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.lblMaxRatOrCaMouseEnter(Sender: TObject);
begin
  lblMaxRatOrCa.Color := clAqua;
end;

procedure TfrmImageControl.lblMaxRatOrCaMouseLeave(Sender: TObject);
begin
  lblMaxRatOrCa.Color := clMedGray;
end;

procedure TfrmImageControl.InfoClick(Sender: TObject);
 var HelpCode : integer;

begin  {complete this: ExportDial.OrigFrameRate}
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 2;
  GetHelp(HelpCode);


End; {procedure TfrmImageControl.InfoClick(Sender: TObject);}

{*****************************************************************************}

procedure TfrmImageControl.ubApplyFrameClick(Sender: TObject);
begin

  If not(SelectionFrameChange.Down) and not(XYprofileRectVisible) then Begin
    SelFrameVisible := ubApplyFrame.Selected;
    //CheckIfSelFrameFits; - no need it has been done when a File is Open
    If (MainImLoaded) then Begin //prevents executing these procedures when new file is open
      UpdateMainImage(True);
      if (NrChannels > 1) and (frmMergeWin <> nil) then DisplaymergeImage;
      if (NrChannels > 1) and (frm2ndWin <> nil)   then Display2ndChannel;
      if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);

    End;
  End;
  {----------------   3D Image  Has to be Here------------------------}
  if (Win3DOn) and (SourceFor3D in[MAIN_IMAGE_FOR_3D,AVER_IMAGE_FOR_3D,MERGE_IMAGE_FOR_3D]) then frm3DImageWin.Update3DImage(True);
  {---------------- end 3D Image -----------------------}

End;

procedure TfrmImageControl.ubApplyFrameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;
begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 29;
  GetHelp(HelpCode);
 end;
end;

{*****************************************************************************}


procedure TfrmImageControl.SelectLockedClick(Sender: TObject);
begin

    if (SelFrameVisible) then SelectionFrameChange.Click;

    frmPlayback.lblROIval.Caption := '';
    frmPlayback.titValueType.Caption := ''; 
    MeasureBox.Down     := False;
    MeasureBox.Enabled  := False;
    scrBoxXsize.Min     := 1;
    scrBoxYsize.Min     := 1;
    scrBoxXsize.Enabled := False;
    scrBoxYsize.Enabled := False;
    frmMainWin.winMainImage.Cursor := crArrow;
    if frmAverIm <> nil then
    frmAverIm.winAverImage.Cursor := crArrow;
    lblBoxXsize.Caption := '';
    lblXmicrons.Caption := '';
    lblBoxYsize.Caption := '';
    lblYmicrons.Caption := '';
end;




{window hide}
procedure TfrmImageControl.WMSize(var M:TWMSIZE);

begin
if (M.SizeType=Size_Minimized) and (frmImContrHidden = True) then
      ShowWindow(frmImageControl.Handle,Sw_Hide)
    else inherited;  {use inherited to invoke OnResize}
End;

procedure TfrmImageControl.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    frmImContrHidden := True;
    if (frmImageControl.WindowState = wsMinimized) then
    ShowWindow(frmImageControl.Handle,Sw_Hide);
end;

procedure TfrmImageControl.enTranspReturnPressed(Sender: TObject);
begin
  trbTransp.Position := round(enTransp.NumberOne*2.55);
end;


procedure TfrmImageControl.trbTranspChange(Sender: TObject);
begin
 If trbTransp.Tag <> trbTransp.Position Then Begin
  trbTransp.Tag := trbTransp.Position;
  enTransp.NumberOne := round(trbTransp.Position/2.55);
  if (frmAverIm <> nil) and (bnTransp.Down = True) then Begin
     frmAverIm.AlphaBlendValue := trbTransp.Position;
  end;
 End;  //If trbTransp.Tag <> trbTransp.Position
End;


//procedure TfrmImageControl.trbTranspChange(Sender: TObject);
{***************************************************************************}

procedure TfrmImageControl.bnTranspClick(Sender: TObject);
var frmLeft,frmTop : Integer;
begin

  if bnTransp.Down then bnTransp.Font.Color := clRed else
                        bnTransp.Font.Color := clBlack;
  If (frmAverIm <> nil) then Begin
    if (bnTransp.Down = True) then begin
     frmLeft := frmAverIm.Left;
     frmTop  := frmAverIm.Top;
     frmAverIm.FormStyle := fsStayOnTop; //Transparent works only if fsStayOnTop
     frmAverIm.Left := frmLeft;
     frmAverIm.Top  :=  frmTop;
     frmAverIm.AlphaBlend := True;
     frmAverIm.AlphaBlendValue := trbTransp.Position;
    end else
    if (bnTransp.Down = False) then begin
     frmAverIm.AlphaBlendValue := 255;
     frmAverIm.AlphaBlend := False;
     frmLeft := frmAverIm.Left;
     frmTop  := frmAverIm.Top;
     frmAverIm.FormStyle := fsMDIChild;
     frmAverIm.Left := frmLeft;
     frmAverIm.Top  := frmTop;
     SetFormSize(frmAverIm,frmAverIm.winAverImage);
    end;
  End;  {If (frmAverIm <> nil)}
End;




procedure TfrmImageControl.ApplyFrameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 29;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.ZoomRangeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 30;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.LabContrastMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 31;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.LabContrastMouseEnter(Sender: TObject);
begin
  LabContrast.Color := clAqua;
end;

procedure TfrmImageControl.LabContrastMouseLeave(Sender: TObject);
begin
  LabContrast.Color := clMedGray;
end;

procedure TfrmImageControl.LabBrigthnessMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 32;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.LabBrigthnessMouseEnter(Sender: TObject);
begin
  LabBrigthness.Color := clAqua;
end;

procedure TfrmImageControl.LabBrigthnessMouseLeave(Sender: TObject);
begin
  LabBrigthness.Color := clMedGray;
end;

procedure TfrmImageControl.lblGammaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 33;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.lblGammaMouseEnter(Sender: TObject);
begin
   lblGamma.Color := clAqua;
end;

procedure TfrmImageControl.lblGammaMouseLeave(Sender: TObject);
begin
  lblGamma.Color := clMedGray;
end;

procedure TfrmImageControl.lbXtolMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var  HelpCode : integer;
begin
  if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 51;
    GetHelp(HelpCode);
  end;
end;

procedure TfrmImageControl.lbYtolMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var  HelpCode : integer;
begin
if (Button = mbRight) then begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 52;
    GetHelp(HelpCode);
  end;
end;

{----------------------------------------------------------------------------}

procedure TfrmImageControl.ubFileColTableClick(Sender: TObject);
var LocalTableIndex       : Integer;
    AllowWindowsUpdateMem : Boolean;
begin

  ColTableSetings.ColTblIndex[CurrClrTablInd] := ColorTables.ItemIndex;

  AllowWindowsUpdateMem := AllowWindowsUpdate;

  if not(AllowWindowsUpdate) then AllowWindowsUpdate := True; //temporarily allows to enable Real Line Scan to display Merge Image

  if (ubFileColTable.Selected) and (ubFileColTable.Tag in[1,2]) then begin
    //CurrClrTablInd = 0 if Ch1 selected; //ClrTableIndex = 2 if Ch2 selected;
    ColorTables.Enabled := False;

    LocalTableIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];
    if (CurrClrTablInd = 0) then ColorTables.Items[LocalTableIndex]   := 'from File Ch1'
      else
    if (CurrClrTablInd = 2) then ColorTables.Items[LocalTableIndex]   := 'from File Ch2';

    ColorTables.ItemIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];  //keep

    LoadOwnFileTables;
    ModifyColTable(0);
    if (NrChannels = 2) then ModifyColTable(2);

    UpdateAllWindows(sender);
  end

    else

  if Not(ubFileColTable.Selected) or (ubFileColTable.Tag = 0) then begin

    ColorTables.Items[0] := 'Grayscale';
    ColorTables.Items[1] := 'Topographic';
    ColorTables.Items[2] := 'Topographic Bright';
    ColorTables.Items[3] := 'Topo Bright &  Yelow';
    ColorTables.Items[4] := 'Rainbow';
    ColorTables.Items[5] := 'Rainbow Bright';
    ColorTables.Items[6] := 'Fluo-4 (516 nM)';
    ColorTables.Items[7] := 'B - G - Y - R';
    ColorTables.Items[8] := 'Fire';
    ColorTables.Items[9] := 'Red';
    ColorTables.Items[10] := 'Green';
    ColorTables.Items[11] := 'Blue';
    ColorTables.ItemIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];  //keep
    ColorTables.Enabled := True;
    LoadColTable(0);
    if (NrChannels = 2) then LoadColTable(2);
    ModifyColTable(0);
    if (NrChannels = 2) then ModifyColTable(2);
    UpdateAllWindows(sender);
  end;

  AllowWindowsUpdate := AllowWindowsUpdateMem;
End;

procedure TfrmImageControl.ub1stChannelSelect(Sender: TObject);
var ChNr,LocalTableIndex : Integer;
begin
  if not(RatioOn) then CurrClrTablInd := 0 else if (RatioOn) or (ChannelsRatioOn) then CurrClrTablInd := 1;
   ChNr := 0;
   SetChannel1or2Settings(Sender,ChNr);

   if (ubFileColTable.Selected) and (ubFileColTable.Tag in[1,2]) then begin
    LocalTableIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];
    if (CurrClrTablInd = 0) then ColorTables.Items[LocalTableIndex]   := 'from File Ch1';
    ColorTables.ItemIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];  //keep
   end;

end;

procedure TfrmImageControl.ub2ndChannelSelect(Sender: TObject);
var ChNr,LocalTableIndex : Integer;
begin
  CurrClrTablInd := 2;
  ChNr := 1;
  SetChannel1or2Settings(Sender,ChNr);

  if (ubFileColTable.Selected) and (ubFileColTable.Tag in[1,2]) then begin
    LocalTableIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];
    if (CurrClrTablInd = 2) then ColorTables.Items[LocalTableIndex]   := 'from File Ch2';
    ColorTables.ItemIndex := ColTableSetings.ColTblIndex[CurrClrTablInd];  //keep
  end;
end;

procedure TfrmImageControl.SetChannel1or2Settings(Sender: TObject; const ChNr : integer);
begin

  ColorTables.ItemIndex :=  ColTableSetings.ColTblIndex[CurrClrTablInd];
  trbContrast.Position   := ColTableSetings.Contrast[CurrClrTablInd];
  trbGamma.Position      := ColTableSetings.Gamma[CurrClrTablInd];
  trbBrightness.Position := ColTableSetings.Brightness[CurrClrTablInd];
  enContrast.NumberOne   := trbContrast.Position;
  enBrightness.NumberOne := trbBrightness.Position;
  enGamma.NumberFloat    := trbGamma.Position/10;
 ///---  Redraws Color Bar ---//
  UpdateColorBar;
  PutTicksOnColorBar; //prints Ticks & Letters on Color Bar

  SetBottomColTableSettings;
  CreateImageInputOutputCurve;
  CreateOneBinImHist;

  if (BitCount = 16) then begin
    dsPixRange.SetSliderPos(PixRange[ChNr].dsPixRange_PosFrom,PixRange[ChNr].dsPixRange_PosTo);
    enPixRange.SetNumbersOneTwo(dsPixRange.PosFrom,dsPixRange.PosTo);
    if (ZoomRange.Down) then ZoomRangeClick(Sender);
    DoDSPixRangeChange(sender); //it contains CreateImageHistogram; and  PaintHistWindow;
  end
    else
  if (BitCount = 8) then begin
    CreateImageHistogram;
    PaintHistWindow;
  end;
End;

procedure TfrmImageControl.tlPixRangeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 34;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.tlPixRangeMouseEnter(Sender: TObject);
begin
   tlPixRange.Color := clAqua;
end;

procedure TfrmImageControl.tlPixRangeMouseLeave(Sender: TObject);
begin
      tlPixRange.Color := clMedGray;
end;

// -------------------------- ROI tracking ------------------------------------//
procedure TfrmImageControl.enROItrackXtolReturnPressed(Sender: TObject);
begin
  if (sbSetROItracking.Down) then begin
    sbSetROItracking.Down := false;
    sbSetROItrackingClick(Sender);
  end;
end;

procedure TfrmImageControl.enROItrackYtolReturnPressed(Sender: TObject);
begin
  if (sbSetROItracking.Down) then begin
    sbSetROItracking.Down := false;
    sbSetROItrackingClick(Sender);
  end;
end;

procedure TfrmImageControl.sbSetROItrackingClick(Sender: TObject);
begin
  DoSetROItracking(True);
end;

procedure TfrmImageControl.DoSetROItracking(const Update : Boolean);
//uses procedure TrackROI;  defined in unGlobalUnit
var CntX,CntY : Integer;

    Procedure CopyROIdata;
      //for Free hand ROI
      var Xbeg,CntX,CntY,PixCount,CntPix,Xpos,Ypos : Integer;

     Begin
        // 1st Finds PixCount = Nr Pixels in Frehand ROI #1
         PixCount := 0;
      For CntY := 0 to High(FhTbl[1]) Do Begin
        If (High(FhTbl[1,CntY]) > 0) Then Begin  {more then one Pixel}
          CntX       := 0;
          While CntX < High(FhTbl[1,CntY]) Do Begin
            Inc(PixCount,(FhTbl[1,CntY,CntX + 1].X - FhTbl[1,CntY,CntX].X) + 1);
            Inc(CntX,2);
          End; {while}
        End Else {If (High(FhTbl[i,CntY]) > 0) Then Begin}
        If (High(FhTbl[1,CntY]) = 0) Then Begin
          Inc(PixCount);
        End; {(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel}
      End; {For CntY := 0 to High(TabFh) do begin}

      SetLength(TrackROIdata,PixCount);

      //2nd: copies pixels values to TrackROIdata (memory of FhROI) and Finds XtolBeg and XtolEnd
      XtolBeg := imXSize;
      XtolEnd := 0;
      Xbeg    := 0;  PixCount := 0;
      For CntY := 0 to High(FhTbl[1]) Do Begin
        If (High(FhTbl[1,CntY]) > 0) Then Begin  //more then one Pixel
          CntX       := 0;
          while CntX < High(FhTbl[1,CntY]) do begin
            for CntPix := FhTbl[1,CntY,CntX].X to FhTbl[1,CntY,CntX + 1].X do
              TrackROIdata[Xbeg+(CntPix-FhTbl[1,CntY,CntX].X)] := Im16bitDataTR[CntPix + imXsize*FhTbl[1,CntY,CntX].Y];

            //finds the X min and x max of the Free han ROI
            if (XtolBeg > FhTbl[1,CntY,CntX].X) then XtolBeg := FhTbl[1,CntY,CntX].X;
            if (XtolEnd < FhTbl[1,CntY,CntX + 1].X) then XtolEnd := FhTbl[1,CntY,CntX + 1].X;

            Inc(Xbeg,(FhTbl[1,CntY,CntX + 1].X - FhTbl[1,CntY,CntX].X) + 1);
            Inc(CntX,2);
          end; //while
        End //If (High(FhTbl[i,CntY]) > 0) Then Begin
          Else
        If (High(FhTbl[1,CntY]) = 0) Then Begin  //Single Pixel
          TrackROIdata[Xbeg] := Im16bitDataTR[FhTbl[1,CntY,0].X + imXsize*FhTbl[1,CntY,0].Y];
          //finds the X min and x max of the Free han ROI
          if (XtolBeg > FhTbl[1,CntY,0].X) then XtolBeg := FhTbl[1,CntY,0].X;
          if (XtolEnd < FhTbl[1,CntY,0].X) then XtolEnd := FhTbl[1,CntY,0].X;
          Inc(Xbeg);
        End; //(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel
      End; //For CntY := 0 to High(TabFh) do begin
     // End of Copying Pixels

     //3rd: Sets the final limits for tracking inm X and Y direction
     //XtolBeg and XtolEnd store the minimum and maximum X of Free Hand ROI and
     //now they will be set to Safe limits

     YtolBeg := FhTbl[1,0,0].Y;
     YtolEnd := FhTbl[1,High(FhTbl[1]),0].Y;

     //sets the TrackRect params to the Most left and Right and Top and Bottom of Free Hand ROI
     TrackRect.Left   := XtolBeg;
     TrackRect.Right  := XtolEnd;
     TrackRect.Top    := YtolBeg;
     TrackRect.Bottom := YtolEnd;

      if (XtolBeg - enROItrackXtol.NumberOne >= 0) then           XtolBeg := enROItrackXtol.NumberOne; //else it remains = to itself i.e. < enROItrackXtol.NumberOne
      if (XtolEnd + enROItrackXtol.NumberOne <= (imXSize-1)) then XtolEnd := enROItrackXtol.NumberOne
        else
          XtolEnd := (imXSize-1) - XtolEnd;

       //Sets the final Y limits for tracking
      if (YtolBeg - enROItrackYtol.NumberOne >= 0) then YtolBeg := enROItrackYtol.NumberOne; //else it remains = to itself
      if (YtolEnd + enROItrackYtol.NumberOne <= (imYSize-1)) then YtolEnd := enROItrackYtol.NumberOne
        else
          YtolEnd := (imYSize-1) - YtolEnd;

      //Finally sets the TrackRect params  to include the Limits Movement of Free Hand ROI
      TrackRect.Left   := TrackRect.Left   - XtolBeg;
      TrackRect.Right  := TrackRect.Right  + XtolEnd;
      TrackRect.Top    := TrackRect.Top    - YtolBeg;
      TrackRect.Bottom := TrackRect.Bottom + YtolEnd;

      //4th: Constructs BinaryImage. Only pixels that are in Track Area = 1, rest = 0
      //Crude Force approach is used here.  Just dragging ROI trough the image and setting to 1
      //Serves as mold form (matrix)
      SetLength(BinaryImage,imXsize*imYsize);
      for CntPix := 0 to High(BinaryImage) do BinaryImage[CntPix] := 0; //zeroes array
      For Xpos := -XtolBeg to XtolEnd Do Begin
      For Ypos := -YtolBeg to YtolEnd Do Begin
        Xbeg    := 0;
        For CntY := 0 to High(FhTblTr) Do Begin
          If ( High(FhTblTr[CntY]) > 0) Then Begin // more then one Pixel
            CntX := 0;
            While CntX < High(FhTblTr[CntY]) Do Begin
              for CntPix := FhTblTr[CntY, CntX].x to FhTblTr[CntY, CntX + 1].x Do
              BinaryImage[(CntPix + Xpos) + imXsize * (FhTblTr[CntY,CntX].y + Ypos)] := 1;
              Inc(Xbeg, (FhTblTr[CntY, CntX + 1].x - FhTblTr[CntY, CntX].x) + 1);
              Inc(CntX, 2);
            End; // while
          End //If ( High(FhTblTr[CntY]) > 0) Then Begin // more then one Pixel
            Else
          If ( High(FhTblTr[CntY]) = 0) Then Begin
             BinaryImage[(FhTblTr[CntY,0].X+Xpos)+imXsize*(FhTblTr[CntY,0].Y+Ypos)] := 1;
             Inc(Xbeg);
          End; // If(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel
        End; // For CntY := 0 to High(TabFh) do begin
      End;
      End;
    End; //Procedure CopyROIdata;

    Procedure CreateTrackAreaTableOne;
    var CntX,CntY,Xbeg,Xend,GenCnt,PixCount,CntPix : Integer; //GenCnt = General Counter
    Begin
    //1st: Finds the the number Raws (here PixCount) for TrackAreaTableOne array

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

      //2nd: Fills TrackAreaTableOne
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

      //3rd: Finds the the number pixels for TrackAreaOne array
      GenCnt := 0;
      for CntX := 0 to High(TrackAreaTableOne) do begin
        Inc(GenCnt,TrackAreaTableOne[CntX].Xe - TrackAreaTableOne[CntX].Xb + 1);
      end;
      SetLength(TrackAreaOne,GenCnt);

      //4th Fill TrackAreaOne
      PixCount := 0;
      for CntY := 0 to High(TrackAreaTableOne) do begin
        for CntX := TrackAreaTableOne[CntY].Xb to TrackAreaTableOne[CntY].Xe do begin
         TrackAreaOne[PixCount] := Im16bitDataTR[CntX + imXsize*(CntY+YtopOff[0])];
         Inc(PixCount);
        end;
      end;

     // with frmMainWin.winMainImage.Canvas do Pixels[CntX,CntY] := clRed;
     GetMeanStdDevLimits(TrackAreaOne,TrackAreaMeans.First,1,3,2);
         //old way
  {    //5th: Finds the the number pixels for TrackArea array
      PixCount := 0;
      for CntPix := 0 to High(BinaryImage) do begin
        if (BinaryImage[CntPix] > 0) then Inc(PixCount);
      end;
      SetLength(TrackAreaOne,PixCount);

      //6th: Fills in TrackArea
      PixCount := 0;
      for CntPix := 0 to High(BinaryImage) do begin
        if (BinaryImage[CntPix] > 0) then begin
          TrackAreaOne[PixCount] := Im16bitDataTR[CntPix];
          Inc(PixCount);
        end;
      end; }

    End; //Procedure CreateTrackAreaTableOne
  //-----end of Vars and Procedures ------------//

Begin

 If (sbSetROItracking.Down) then begin

  If (ROIvar.ROIAdr[1] = 3) and (ROIvar.ROIAdr[2] = 1) then Begin

    sbSetROItracking.Caption := 'im ' + IntToStr(CurIm+1);

      {Assigns  Y-X table to FhTblTr}
    SetLength(FhTblTr,Length(FhTbl[1]));
    For CntY := 0 to High(FhTbl[1]) do begin
      SetLength(FhTblTr[CntY],Length(FhTbl[1,CntY]));
      For CntX := 0 to High(FhTbl[1,CntY]) do Begin
        FhTblTr[CntY,CntX].X := FhTbl[1,CntY,CntX].X;
        FhTblTr[CntY,CntX].Y := FhTbl[1,CntY,CntX].Y;
      End;
    End; //For CntY := 0 to High(FhTbl[CurROIadr])
      //assigns Polygon to FhPolTr
      FhPolTr := nil;
      SetLength(FhPolTr,Length(FhPol[1]));
    For CntX := 0 to High(FhPol[1]) do Begin
      FhPolTr[CntX].X := FhPol[1,CntX].X;
      FhPolTr[CntX].Y := FhPol[1,CntX].Y;
    End;


     //Memorizes Rectangle ROI
    ROICoorMem[1] := ROIvar.ROICoor[1,2];
    ROICoorMem[2] := ROIvar.ROICoor[2,2];
    ROICoorMem[3] := ROIvar.ROICoor[3,2];
    ROICoorMem[4] := ROIvar.ROICoor[4,2];

    If (SmoothMode <> NO_SMOOTH) And (SmoothNonRatio = SMOOTH_Ch_ONE) then begin
      SetLength(Im16bitDataTR,Length(Im16bitDataSM_Last));
      for CntX := 0 to High(Im16bitDataSM_Last) do Im16bitDataTR[CntX] := Im16bitDataSM_Last[CntX];
    End
      Else
    If (SmoothMode = NO_SMOOTH) Or (SmoothNonRatio = NO_SMOOTH_NON_RATIO) then Begin
    if (BitCount = 8) then begin
      SetLength(Im16bitDataTR,Length(Im8bitData));
      for CntX := 0 to High(Im8bitData) do Im16bitDataTR[CntX] := Im8bitData[CntX];
    end
      else
    if (BitCount = 16) then begin
      SetLength(Im16bitDataTR,Length(Im16bitData));
      for CntX := 0 to High(Im16bitData) do Im16bitDataTR[CntX] := Im16bitData[CntX];
    end;
    End; //If (SmoothMode = NO_SMOOTH) Or (SmoothNonRatio = NO_SMOOTH_NON_RATIO) then Begin

    CopyROIdata;
    CreateTrackAreaTableOne;
    ROItracking := True;
  End
    Else
  Begin
    sbSetROItracking.Down := False;
    ShowMessage('ROI 1 (red) should be Free hand and ROI 2 should be Rectangle');
  End;
 End //If (sbSetROItracking.Down) then begin

  Else

 If not(sbSetROItracking.Down) then begin
    sbSetROItracking.Caption := 'UnLck';
    If (ROItracking) then begin
        {Recovers  Y-X table }
      For CntY := 0 to High(FhTbl[1]) do begin
        For CntX := 0 to High(FhTbl[1,CntY]) do Begin
          FhTbl[1,CntY,CntX].X := FhTblTr[CntY,CntX].X;
          FhTbl[1,CntY,CntX].Y := FhTblTr[CntY,CntX].Y;
        End;
      End; //For CntY := 0 to High(FhTbl[CurROIadr])
      //Recovers Polygon
      For CntX := 0 to High(FhPol[1]) do Begin
        FhPol[1,CntX].X := FhPolTr[CntX].X;
        FhPol[1,CntX].Y := FhPolTr[CntX].Y;
      End;
      {Recovers ROI addr = 2 (blue}
      ROIvar.ROICoor[1,2] := ROICoorMem[1];
      ROIvar.ROICoor[2,2] := ROICoorMem[2];
      ROIvar.ROICoor[3,2] := ROICoorMem[3];
      ROIvar.ROICoor[4,2] := ROICoorMem[4];

      ROItracking := False;

     if (Update) then  UpdateMainImage(True);

    End; //If (ROItracking) then begin
 End; //If not(sbSetROItracking.Down) then begin

End;

{****************************************************************************}

procedure TfrmImageControl.sbSmoothNonRatioChOneClick(Sender: TObject);
begin
  if (sbSmoothNonRatioChOne.Down) then Inc(SmoothNonRatio)
    else
  if not(sbSmoothNonRatioChOne.Down) then Dec(SmoothNonRatio);
  DoSmoothNonRatio(Sender);
  if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(True,False);
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

  {----------------   3D Image  ------------------------}
    if (Win3DOn) and not(RatioOn) and not(ChannelsRatioOn) then frm3DImageWin.Update3DImage(True);
   {---------------- end 3D Image -----------------------}

end;

procedure TfrmImageControl.sbSmoothNonRatioChTwoClick(Sender: TObject);
begin
  if (sbSmoothNonRatioChTwo.Down) then Inc(SmoothNonRatio,2)
    else
  if not(sbSmoothNonRatioChTwo.Down) then Dec(SmoothNonRatio,2);
  DoSmoothNonRatio(Sender);
  if (OrthogonalSectioningOn) then with frmOrthogonalSectioning do begin
      UpdateSectionsAndDrawMainWin(True,False);
  end;
  {----------------   3D Image  ------------------------}
    if (Win3DOn) and not(RatioOn) and not(ChannelsRatioOn) And
    ((SourceFor3D = MERGE_IMAGE_FOR_3D) Or
    ((frmImageControl.cbDoLineScanOfMergeImage.Checked) and (SourceFor3D = LSCAN_IMAGE_FOR_3D))) Or
    ((SourceFor3D = LSCAN_IMAGE_FOR_3D) and (ChannelOrder = DESCENDING))
    then frm3DImageWin.Update3DImage(True);
   {---------------- end 3D Image -----------------------}

end;

procedure TfrmImageControl.DoSmoothNonRatio(Sender : TObject);
begin
  if (MainImLoaded) then if not(RatioOn) then begin
    frmPlayback.PlaybackScrollBarChange(Sender);
    {----------------  Line Scan  ------------------------}
    if (LineScanExist) then begin
      frmLineScan.UpdateLSwindows(RELOAD_DISPL);
    end;
    {---------------- end Line Scan -----------------------}
  end;
end;


{****************************************************************************}

// Diameter Tracking Buttons//
procedure TfrmImageControl.DiamMesClick(Sender: TObject);
begin

   If (DiamMes.Down) Then Begin
    if (MesLine.OpCode = DO_EXIST) then begin
      DiamMesRect.OpCode := TO_RESET; //allows Drawing by DrawMesLine procedure
      UpdateMainImage(True);
    end else
    begin
      DiamMes.Down := False;
    end;
   End
    Else
   Begin
    ubSetDiamMes.Selected := False;
    ubSetDiamMesClick(Sender);
    DiamMesRect.OpCode := NOT_EXIST;
    UpdateMainImage(True);
    if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);
   End;

    ubSetDiamMes.Visible         := DiamMes.Down;
    lbDiamMesRectWidth.Visible   := DiamMes.Down;
    enDiamMesRectWidth.Visible   := DiamMes.Down;
End;

procedure TfrmImageControl.enDiamMesRectWidthReturnPressed(Sender: TObject);
begin

  if (enDiamMesRectWidth.NumberOne mod 2 = 0) then
    enDiamMesRectWidth.NumberOne := enDiamMesRectWidth.NumberOne + 1;
  enDiamMesRectWidth.Tag := enDiamMesRectWidth.NumberOne;
  DiamMesRect.OpCode :=  SET_WIDTH;
  UpdateMainImage(True);
  if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);

end;

procedure TfrmImageControl.ubSetDiamMesClick(Sender: TObject);
var Addr,CntX : Integer;

begin

 If (ubSetDiamMes.Selected) Then Begin

  frmTimeSerPlot.TimeSerAnalOpCode := DIAM_TRACKING;
  //disable buttons
  MeasureDistance.Down := True; //push this one down first
  MeasureDistanceClick(sender);
  Select.Enabled := False;
  SelectLocked.Enabled := False;
  PutBox.Enabled := False;
  Freehand.Enabled := False;
  DeleteAll.Enabled := False;
  btZeroOutsideROI_AvIm.Enabled := False;
  btZeroOutsideROI_All_Images.Enabled := False;
  enDiamMesRectWidth.Enabled := False;
 End
  else
 If Not(ubSetDiamMes.Selected) then Begin
  if (DiamMesRect.OpCode = IN_TRACKING) then begin
    DiamMesRect.OpCode    := DO_EXIST;
    frmTimeSerPlot.TimeSerAnalOpCode := CONVENTIONAL;

    for Addr := 1 to 2 do begin
      if (ROIvar.ROIAdr[Addr] = 3) then begin
        //updates Free Hand Polygon
        for CntX := 0 to High(FhPol[Addr]) do begin
          FhPol[Addr,CntX].X := FhPol[Addr+2,CntX].X;
          FhPol[Addr,CntX].Y := FhPol[Addr+2,CntX].Y;
        end; //for bXs := 0 to High(FhPol[CurROIadr])

        FhTbl[Addr+2] := nil;
        FhPol[Addr+2] := nil;
      end else //if (ROIvar.ROIAdr[Addr] = 3) then begin
      if (ROIvar.ROIAdr[Addr] = 1) then begin
        ROIvar.ROICoor[1,Addr] := ROIvar.ROICoor[1,Addr+2];
        ROIvar.ROICoor[2,Addr] := ROIvar.ROICoor[2,Addr+2];
        ROIvar.ROICoor[3,Addr] := ROIvar.ROICoor[3,Addr+2];
        ROIvar.ROICoor[4,Addr] := ROIvar.ROICoor[4,Addr+2];
      end;
    end; // for Addr := 1 to 2 do begin

    with MesLine do Begin with DiamMesRect do Begin
      LineBeg.X := LineBegOrig.X;
      LineBeg.Y := LineBegOrig.Y;
      LineEnd.X := LineEndOrig.X;
      LineEnd.Y := LineEndOrig.Y;
    end; end;
    TrackPath     := nil;
    TrackData     := nil;

    if (Sender = ubSetDiamMes) then begin //DiamMesClick Also Updates Image
      UpdateMainImage(True);
      if (frmAverIm <> nil) and (AvImExists > 0) then UpdateAverImage(True);
    end;

    //enable buttons
    Select.Enabled := True;
    SelectLocked.Enabled := True;
    PutBox.Enabled := True;
    Freehand.Enabled := True;
    DeleteAll.Enabled := True;
    btZeroOutsideROI_AvIm.Enabled := True;
    btZeroOutsideROI_All_Images.Enabled := True;
    enDiamMesRectWidth.Enabled := True;

  end; //if (DiamMesRect.OpCode = IN_TRACKING) then begin
 End; //if Not(ubSetDiamMes.Selected)


End;

procedure TfrmImageControl.ubSetDiamMesSelect(Sender: TObject);
begin
  ubSetDiamMes.CaptionSel := 'im ' + IntToStr(CurIm+1);
  SetLength(Im16bitDataTR,Length(Im16bitData));
  PrepareForTrackDiameter;  //checks & prapares
  if (DiamMesRect.OpCode =  IN_TRACKING) then TrackDiameter;
  if (DiamMesRect.OpCode <> IN_TRACKING) then ubSetDiamMes.Selected := False;
end;


procedure TfrmImageControl.ubSizeBarClick(Sender: TObject);
begin
  SizeBarVisible := ubSizeBar.Selected;

  if (MainImLoaded) then begin
    SizeBar.XL := SizeBar.XR - round(ExportDial.SizeBarLenghtINµm/PixSize);
    UpdateMainImage(True);
    if (AvImExists > 0) and (frmAverIm <> nil) then UpdateAverImage(True);
    if (NrChannels > 1) then begin
      if (frm2ndWin <> nil) then Display2ndChannel;
      if (frmMergeWin <> nil) then DisplayMergeImage;
    end;
  end;
end;

//end of Diameter Tracking Buttons//

procedure TfrmImageControl.TransferLStoPlotClick(Sender: TObject);
begin
  if (LineScanExist) then begin
   if (frmLineScan.LStraceExist) then
    frmLineScan.TransferLSTraceToTimeSerAnalPlot(Sender);
  end;
end;

procedure TfrmImageControl.DeleteMesLineClick(Sender: TObject);
begin
  //Measuring Line CANNOT be deleted in Diameter Measuring Mode - Simplifies Program Flow
  If Not(DiamMes.Down) Then Begin
   MesLine.OpCode := NOT_EXIST;
   if (MainImLoaded) then UpdateMainImage(True);
   if (frmAverIm <> nil) then UpdateAverImage(True);
   if (NrChannels > 1) and (frmMergeWin <> nil) then DisplayMergeImage;
  End;
end;

procedure TfrmImageControl.SelectMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 35;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.SelectLockedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 36;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.PlaceMarkMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 37;
  GetHelp(HelpCode);
 end;
end;


procedure TfrmImageControl.PutBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 38;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.FreehandMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 39;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.SelectionFrameChangeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 40;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.MeasureBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 41;
  GetHelp(HelpCode);
 end;
end;

procedure TfrmImageControl.btZeroOutsideROI_AvImMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 42;
  GetHelp(HelpCode);
 end;
end;



procedure TfrmImageControl.btZeroOutsideROI_All_ImagesMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var HelpCode : integer;

begin
 if (Button = mbRight) then begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 43;
  GetHelp(HelpCode);
 end;
end;

END. {end Unit}

