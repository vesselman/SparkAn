{$D-,L-,O+,Q-,R-,Y-,S-}
unit unRealLineScan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrameRealLineScan, Vcl.Buttons,Vcl.Direct2D, Winapi.D2D1,Winapi.DxgiFormat,
  Vcl.StdCtrls, Vcl.ComCtrls, System.Math, DSlider,unGlobUnit, EditNumerical, UniButton,
  SuperSubLabel, Vcl.ExtCtrls, Vcl.Grids, Vcl.Menus;


const  //CORR_mode
      INACTIVE   = 0;
      CREATING   = 1;
      MOVE_TOP   = 2;
      MOVE_BOT   = 3;
      MOVE_WHOLE = 4;
      DELETE_SEL = 5;
      DELETE_ALL = 6;

type
     TYtopYbot = record
      Ytop : Integer;
      Ybot : Integer;
     end;

     TYtopYbotArray = Array of TYtopYbot;

type
  TfrmRealLineScan = class(TForm)
    lbXperc: TLabel;
    trPercOfOrig_X: TTrackBar;
    trPercOfOrig_Y: TTrackBar;
    lbYperc: TLabel;
    dsSectionInUse: TDSlider;
    dsMinAndMax: TDSlider;
    enPixYPos: TEditNumerical;
    enMinAndMax: TEditNumerical;
    enSectionInUse: TEditNumerical;
    lbTotalStrips: TLabel;
    sbApplySmoothing: TSpeedButton;
    sbCorrectSlope: TSpeedButton;
    ubOn: TUniButton;
    enTimePos: TEditNumerical;
    lb_ms: TLabel;
    lb_pix: TLabel;
    trAngle: TTrackBar;
    slAngle: TSuperSubLabel;
    cbShowCorrectionLine: TCheckBox;
    tbImagePos: TTrackBar;
    pbRealLineScan: TPaintBox;
    rgChannelView: TRadioGroup;
    rbViewChOne: TRadioButton;
    rbViewChTwo: TRadioButton;
    rbViewBothChannels: TRadioButton;
    pnChToAnalyze: TPanel;
    rbAnalChannelOne: TRadioButton;
    rbAnalChannelTwo: TRadioButton;
    rgChannelToAnal: TRadioGroup;
    rbViewAnalysed: TRadioButton;
    lbMousePos: TLabel;
    enBinWidth: TEditNumerical;
    sbBinValues: TSpeedButton;
    StringGridBins: TStringGrid;
    lbGoTo: TLabel;
    Label2: TLabel;
    cbImageSmoothingKind: TComboBox;
    sbReloadImage: TSpeedButton;
    sbSaveStrips: TSpeedButton;
    spSaveTable: TSpeedButton;
    SaveDialog_RealLineScan: TSaveDialog;
    Label3: TLabel;
    Label4: TLabel;
    UpDownPage: TUpDown;
    enPageNr: TEditNumerical;
    cbDisregard: TCheckBox;
    enDisregard: TEditNumerical;
    lbDisregard: TLabel;
    unKalmanFltInfo: TUniButton;
    sbCorrectBaseline: TSpeedButton;
    cbShow50percent: TCheckBox;
    cbKeepYcenter: TCheckBox;
    procedure trPercOfOrig_XChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trPercOfOrig_YChange(Sender: TObject);
    procedure dsSectionInUseChange(Sender: TObject);
    procedure dsMinAndMaxChange(Sender: TObject);
    procedure enPixYPosReturnPressed(Sender: TObject);
    procedure enMinAndMaxReturnPressed(Sender: TObject);
    procedure enSectionInUseReturnPressed(Sender: TObject);
    procedure enTimePosReturnPressed(Sender: TObject);
    procedure trAngleChange(Sender: TObject);
    procedure sbCorrectSlopeClick(Sender: TObject);
    procedure sbApplySmoothingClick(Sender: TObject);
    procedure tbImagePosChange(Sender: TObject);
    procedure rbViewChOneClick(Sender: TObject);
    procedure rbViewChTwoClick(Sender: TObject);
    procedure rbViewBothChannelsClick(Sender: TObject);
    procedure pbRealLineScanPaint(Sender: TObject);
    procedure rbViewAnalysedClick(Sender: TObject);
    procedure cbShowCorrectionLineClick(Sender: TObject);
    procedure pbRealLineScanMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sbBinValuesClick(Sender: TObject);
    procedure rbAnalChannelOneClick(Sender: TObject);
    procedure rbAnalChannelTwoClick(Sender: TObject);
    procedure sbReloadImageClick(Sender: TObject);
    procedure ubOnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure spSaveTableClick(Sender: TObject);
    procedure sbSaveStripsClick(Sender: TObject);
    procedure UpDownPageClick(Sender: TObject; Button: TUDBtnType);
    procedure enPageNrReturnPressed(Sender: TObject);
    procedure pbRealLineScanMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbRealLineScanMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure enDisregardReturnPressed(Sender: TObject);
    procedure cbDisregardClick(Sender: TObject);
    procedure unKalmanFltInfoClick(Sender: TObject);
    procedure sbCorrectBaselineClick(Sender: TObject);
    procedure cbShow50percentClick(Sender: TObject);
    procedure StringGridBinsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    BINTableEmpty : Boolean;
    Dest_RS_Xsize, Dest_RS_Ysize, Source_RS_Ysize : Integer;
    YFactor         : Double;
    XpixFactor      : Double;
    XscrFactor      : Double;
    LineSlope       : Double;
    CurrentYPos     : Integer;
    CurrentYcent    : Integer;
    HorizOffset     : Integer;
    NrHorizPos      : Integer;
    IdTraceMin      : Integer;
    IdTraceMax      : Integer;
    Xdelta          : Integer;
    dsMinAndMaxLeft : Integer;
    enMinAndMaxLeft : Integer;
    BinMin,BinMax   : Integer; //in ms
    RealScanTrace, IdealScanTrace, BaselineTrace : TDynIntArray;
    PlotTrace : TDynTPointArray;
    StripsYCenter : TDynIntArray;
    ImageArrRaw,ImageArrCor,ImageArrSm : TDynByteArray; //holds Raw, Smoothed and Corrected Images
    Ytop,Ybot,YtopMem,Yinit : Integer;
    CORR_mode : Byte;
    YtopYbotArray : TYtopYbotArray;
    RejectionSpace : TBitmap;
    RejectRect : TRect;
    CurrIndex, Ydelt : Integer;
    Procedure ApplySmoothingOnLineScan;
    Procedure BinValues;
    Procedure GenerateRealScanTrace;
    Procedure GenerateIdealScanTrace;
    procedure GetRealTraceBaseLine(const Source : TDynIntArray; var Baseline : TDynIntArray);
    Procedure StraightenStrips;
    procedure SmoothKalman(const Gain : Double);
    Procedure UpdateRealLineScan(const All : Boolean);

  public
    { Public declarations }

    BinArray : TDynWordArray;
    Procedure DoUpdateRealLineScan;

  end;


var

  frmRealLineScan : TfrmRealLineScan;

  //PainBox widht = 512 + 10 (space between image and trace) + 128 (1 byte/2 = 256/2) + 10 (space) = 660

implementation

 Uses unMainWindow, unImageControl, unTimeSerAnal,DigiFilters,
      unSparkTable, unWaveTable, unPlayBack, unFrameTimSerPlot, un3DImageWin,
      unMergeWindow, unXYprofile, un2ndWin,Main,unFunctions, unHistogram;

{$R *.dfm}


procedure TfrmRealLineScan.cbShow50percentClick(Sender: TObject);
begin
  UpdateRealLineScan(False);
end;

procedure TfrmRealLineScan.cbShowCorrectionLineClick(Sender: TObject);
begin
  UpdateRealLineScan(True);
end;

procedure TfrmRealLineScan.enMinAndMaxReturnPressed(Sender: TObject);
begin
  dsMinAndMax.SetSliderPos(enMinAndMax.NumberOne,enMinAndMax.NumberTwo);
  if (RealLineScanOn) then begin
     GenerateIdealScanTrace;
     UpdateRealLineScan(False);
   end;
end;

procedure TfrmRealLineScan.dsMinAndMaxChange(Sender: TObject);
begin
    enMinAndMax.SetNumbersOneTwo(dsMinAndMax.PosFrom,dsMinAndMax.PosTo);

   if (RealLineScanOn) then begin
     GenerateIdealScanTrace;
     UpdateRealLineScan(False);
   end;
end;

procedure TfrmRealLineScan.cbDisregardClick(Sender: TObject);
begin
   if (RealLineScanOn) then enDisregardReturnPressed(Sender);
end;

procedure TfrmRealLineScan.enDisregardReturnPressed(Sender: TObject);
begin
  if (RealLineScanOn) then begin
    lbDisregard.Caption := 'pix = ' + FloatToStrF(TimeSt[enDisregard.NumberOne]*1000,ffFixed,10,3) + ' ms';
    GenerateIdealScanTrace;
    UpdateRealLineScan(False);
  end;
end;

procedure TfrmRealLineScan.dsSectionInUseChange(Sender: TObject);
begin
   enSectionInUse.SetNumbersOneTwo(dsSectionInUse.PosFrom,dsSectionInUse.PosTo);
   if (RealLineScanOn) then begin
     GenerateRealScanTrace;
     GenerateIdealScanTrace;
     UpdateRealLineScan(True);
   end;
end;

procedure TfrmRealLineScan.enSectionInUseReturnPressed(Sender: TObject);
begin
  dsSectionInUse.SetSliderPos(enSectionInUse.NumberOne,
                              enSectionInUse.NumberTwo);

  if (RealLineScanOn) then begin
     GenerateRealScanTrace;
     GenerateIdealScanTrace;
     UpdateRealLineScan(True);
   end;
end;

procedure TfrmRealLineScan.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     RealLineScanOn := False;
     RejectionSpace.Free;
     Action    := caFree;
     frmRealLineScan  := nil;
end;

procedure TfrmRealLineScan.FormCreate(Sender: TObject);
begin
  Dest_RS_Xsize  := 0;
  LineSlope := 0;
  Dest_RS_Ysize := pbRealLineScan.Height;
  frmRealLineScan.DoubleBuffered := True;  //hepls to avoid flickering when Y zoom is changed
  HorizOffset := 562;
  NrHorizPos  := 520;
  IdTraceMin  := -5;
  IdTraceMax  := 127 + 5;
  Xdelta      := 0;
  CurrentYcent := Dest_RS_Ysize div 2;
  CurrentYpos  := 0;
  enDisregard.NumberOne := 0;
  dsMinAndMaxLeft := dsMinAndMax.Left;
  enMinAndMaxLeft := enMinAndMax.Left;
  CORR_mode := INACTIVE;
  RejectionSpace := TBitmap.Create;
  RejectionSpace.SetSize(7,pbRealLineScan.Height);
  RejectRect.Left := pbRealLineScan.Width-7;;
  RejectRect.Right := pbRealLineScan.Width;
  RejectRect.Top := 0;
  RejectRect.Bottom := pbRealLineScan.Height;

  BINTableEmpty := True;
  With StringGridBins Do Begin
    StringGridBins.ColWidths[2] := 120;
    Cells[0,0] := 'Bin #';  {This Goes on Fixed (Gray Cell}
    Cells[1,0] := 'Counts'; {Strips per bin}
    Cells[2,0] := 'Range'; {from - to ms}
  End; {With StringGridSparks ....}
end;


procedure TfrmRealLineScan.sbReloadImageClick(Sender: TObject);
begin
 If (RealLineScanOn) then begin
    if(rbAnalChannelOne.Checked) then Move(ImDispl[0],   ImageArrRaw[0],ImagePix) else
    if(rbAnalChannelTwo.Checked) then Move(Im2ndDispl[0],ImageArrRaw[0],ImagePix);
    Move(ImageArrRaw[0],ImageArrCor[0],ImagePix);  //if you don't do it the contens from previous file will remeain in this Buffer
    Move(ImageArrRaw[0], ImageArrSm[0],ImagePix);
    GenerateRealScanTrace;
    GenerateIdealScanTrace;
    UpdateRealLineScan(True);
  End;
end;

procedure TfrmRealLineScan.ubOnClick(Sender: TObject);
var OnChangeMem : TNotifyEvent;
    Cnt : Integer;
begin
     //have a var to verify that this is a line scan image
If (NrIm = 1) then begin // always reset X and Y positions
    trPercOfOrig_Y.Position := 100;
    trPercOfOrig_X.Position := 100;
End;

If (MainImLoaded) and (NrIm = 1) then begin
    RealLineScanOn := ubOn.Selected;
  if (RealLineScanOn) then begin
    AllowWindowsUpdate := False;   //Allows Update of the Windows from Image Control panel
    Source_RS_Ysize := Dest_RS_Ysize;
    SetLength(RealScanTrace,imYSize);
    SetLength(IdealScanTrace,imYSize);
    SetLength(BaselineTrace,imYSize);
    SetLength(PlotTrace,Dest_RS_Ysize);
    YFactor := 1.0;
    for Cnt := 0 to High(PlotTrace) do PlotTrace[Cnt].Y := Round(Cnt/YFactor);
    OnChangeMem := tbImagePos.OnChange;
    tbImagePos.OnChange := nil;
    tbImagePos.Position := 0;
    tbImagePos.Max := imYsize - pbRealLineScan.Height - 1;
    tbImagePos.OnChange := OnChangeMem;

    enTimePos.NumberFloat := 0;
    enPixYPos.NumberOne   := 0;

    enPageNr.NumberOne := 0;
    enPageNr.Max := tbImagePos.Max div Source_RS_Ysize;
    UpDownPage.Position := 0;
    UpDownPage.Max := tbImagePos.Max div Source_RS_Ysize;

    if (NrChannels = 1) and (rbAnalChannelTwo.Checked) then begin
      OnChangeMem := rbAnalChannelOne.OnClick;
      rbAnalChannelOne.OnClick := nil;
      rbAnalChannelOne.Checked := True;
      rbAnalChannelOne.OnClick := OnChangeMem;

      OnChangeMem := rbAnalChannelTwo.OnClick;
      rbAnalChannelTwo.OnClick := nil;
      rbAnalChannelTwo.Checked := False;
      rbAnalChannelTwo.OnClick := OnChangeMem;
      rbAnalChannelTwo.Enabled := False;
    end;
    if (MovFType  = SINGLE_BW_TIFF) and (TIFFfileType = TIFF_GENERIC) then begin
      //create fake time stamps
      SetLength(TimeSt,imYsize);
      for Cnt := 0 to High(TimeSt) do TimeSt[Cnt] := Cnt;
    end;
    Dest_RS_Xsize := Round((512*trPercOfOrig_X.Position)/100); //Maximum Width of the PainBox for Image = 512 pixels  for all imXsize's
    XpixFactor := imXsize/Dest_RS_Xsize;  // = 1 if imXsize = 512; = 2 if imXsize = 1025
    XscrFactor := imXsize/512;  // = 1 if imXsize = 512; = 2 if imXsize = 1025
    enSectionInUse.Min := 0;
    enSectionInUse.Max := imXsize-1;
    enSectionInUse.SetNumbersOneTwo(0,imXsize-1);
    dsSectionInUse.Min := 0;
    dsSectionInUse.Max := imXsize-1;
    dsSectionInUse.SetSlider(0,imXsize-1,0,imXsize-1);

    BinMin := round(TimeSt[1]);
    BinMax := round(TimeSt[High(TimeSt)]/10);
    enBinWidth.NumberOne := 1000; //ms
    SetLength(ImageArrRaw,ImagePix);
    SetLength(ImageArrCor,ImagePix);
    SetLength(ImageArrSm,ImagePix);
    if(rbAnalChannelOne.Checked) then Move(ImDispl[0],ImageArrRaw[0],ImagePix) else
    if(rbAnalChannelTwo.Checked) then Move(Im2ndDispl[0],ImageArrRaw[0],ImagePix);
    Move(ImageArrRaw[0],ImageArrCor[0],ImagePix);  //if you don't do it the contens from previous file will remeain in this Buffer
    Move(ImageArrRaw[0], ImageArrSm[0],ImagePix);
    GenerateRealScanTrace;
    GenerateIdealScanTrace;
    end;
  end
    else
  begin
    ubOn.Selected := False;
    RealLineScanOn := ubOn.Selected; //needed when file closes or another is open
  end;

   UpdateRealLineScan(True);

   If not(RealLineScanOn) and (MainImLoaded) then Begin
    SetLength(YtopYbotArray,0);
    BINTableEmpty := True;
    with StringGridBins do begin
    RowCount := 14;
    For Cnt := 1 to 13 do Begin
      Cells[0,Cnt] := '';
      Cells[1,Cnt] := '';
      Cells[2,Cnt] := '';
    End;
    //these 3 lines introduced 4-12-2017
    AllowWindowsUpdate := True;
    frmImageControl.DSPixRangeChange(Sender);
    frmImageControl.UpdateAllWindows(Sender); // update windows since they were not updating when Line Scan ON
   End;

  End;

End;

procedure TfrmRealLineScan.unKalmanFltInfoClick(Sender: TObject);
var HelpCode : integer;
begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 55;
  GetHelp(HelpCode);
end;

{************************************************************************}

procedure TfrmRealLineScan.GenerateRealScanTrace;
var Xbeg,Xend, Xcnt,Ycnt, Yend,RowLen : Integer;
    EndOfArray : LongInt;
    SD : Double;
Begin

  Xbeg := enSectionInUse.NumberOne;
  Xend := enSectionInUse.NumberTwo;

  Yend := imYsize-1;
  RowLen := (Xend - Xbeg + 1)*2; // *2 to divide by 2 to fit the Max data = 256 into 128 pixels

  For Ycnt := 0 to Yend do Begin
    RealScanTrace[Ycnt] := 0; //Zero the array
    For Xcnt := Xbeg to Xend do Begin
      RealScanTrace[Ycnt] := RealScanTrace[Ycnt] + ImageArrSm[Xcnt + Ycnt*imXsize];
    End;
    RealScanTrace[Ycnt] := round(RealScanTrace[Ycnt]/RowLen);
  End;

  for Xcnt := 0 to High(BaseLineTrace) do BaselineTrace[Xcnt] := 0;

End;


procedure TfrmRealLineScan.sbCorrectBaselineClick(Sender: TObject);
begin
  if (RealLineScanOn) then begin
     GetRealTraceBaseLine(RealScanTrace,BaselineTrace);
     UpdateRealLineScan(False);
  end;
end;

procedure TfrmRealLineScan.GetRealTraceBaseLine(const Source : TDynIntArray; var Baseline : TDynIntArray); // Continuous  Baseline
 
Var
  ToInc           : Boolean;
  Cnt             : Integer;
  CntScan         : Integer;
  CntPt           : Integer;
  j               : Integer;
  EndCount        : Integer;
  HalfEventWidth  : Integer;
  EventWidth      : Integer;
  NrScanes        : Integer;
  EventWindow     : TDynIntArray;
  MultiBase       : TDyn2DIntArray;
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

    LSD := 1.5; //Left Standard Deviation
    RSD := 1.5; //Right SD

    EventWidth := round(11/((TimeSt[High(TimeSt)]/imYsize)*1000)); // set initial EventWidth to 11 ms = 45 pix usually
    if (EventWidth mod 2 = 0) then Inc(EventWidth);

    NrScanes := 7; // and initial EventWidth = 45 gives: 45,67,101,151,225,337 ,505,757 pixels

    SetLength(MultiBase,NrScanes + 1,Length(BaseLine));

    for Cnt := 0 to High(BaseLine) do Baseline[Cnt] := 0;

    ToInc := True;

    For CntScan := 0 to NrScanes do Begin

      SetLength(EventWindow,EventWidth);
      EndCount := Length(BaseLine) - EventWidth;
      HalfEventWidth := EventWidth shr 1;

      For Cnt := 0 to EndCount Do Begin   // [0] is always full so there is no need to use CntROI
        for CntPt := 0 to High(EventWindow) do EventWindow[CntPt] := Source[Cnt+CntPt];
        GetMeanStdDevLimits(EventWindow,Mean,LSD,RSD,2);

        if (Cnt > 0) and (Cnt < EndCount) then
        MultiBase[CntScan,Cnt + HalfEventWidth] := Round(Mean) else

        if (Cnt = 0) then
        for j := 0 to HalfEventWidth do begin
          MultiBase[CntScan,j] := Round(Mean);
        end else
        if (Cnt = EndCount) then
        for j := EndCount to High(BaseLine) do begin
          MultiBase[CntScan,j] := round(Mean);
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

      If EventWidth > imYsize div 2 then begin
        NrScanes := CntScan;
        Break;
      End;

    End; //For CntScan := 0 to NrPasses /

    {Gets the Minimum from all MultiBase passes and assigns it to Baseline}
    For Cnt := 0 to High(BaseLine) do Begin
      For CntScan := 0 to NrScanes do Begin
        if  Baseline[Cnt] <  MultiBase[CntScan,Cnt] then  //was if  Baseline[Cnt] >  MultiBase[CntScan,Cnt]
            Baseline[Cnt] := MultiBase[CntScan,Cnt];
      End; // For CntPass := 0 to (NrPasses - 1)
    End; //For Cnt := 0 to High(BaseLine)

    //subtract baseline
    for Cnt := 0 to High(RealScanTrace) do begin
      RealScanTrace[Cnt] := RealScanTrace[Cnt] - BaselineTrace[Cnt] + dsMinAndMax.PosTo;
    end;

End; //procedure GetRealTraceBaseLine;

{******************************************************************************}

Procedure TfrmRealLineScan.GenerateIdealScanTrace;
var Cnt, MinPosBeg, MinPosEnd, CntNr, HalfVal : Integer;
Begin

  HalfVal := round((dsMinAndMax.PosTo - dsMinAndMax.PosFrom)/2) + dsMinAndMax.PosFrom;

  For Cnt := 0 to High(RealScanTrace) do Begin
    if (RealScanTrace[Cnt] > HalfVal) then
      IdealScanTrace[Cnt] := IdTraceMax
        else
      IdealScanTrace[Cnt] := IdTraceMin; // like = 0
  End;

   //apply the disregard selections
  If (High(YtopYbotArray) >= 0) then Begin
    for CntNr := 0 to High(YtopYbotArray) do begin
      for Cnt := YtopYbotArray[CntNr].Ytop to YtopYbotArray[CntNr].Ybot do begin
        IdealScanTrace[Cnt] := IdTraceMax;
      end;
    end;
  End;

  //apply the disregard if > 0
  If (enDisregard.NumberOne > 0) and (cbDisregard.Checked) then Begin
     MinPosBeg := -1;
    For Cnt := 0 to High(IdealScanTrace) do Begin
      if (IdealScanTrace[Cnt] = IdTraceMin) then begin
        if (MinPosBeg = -1) then begin
          MinPosBeg := Cnt;
          if (Cnt < High(IdealScanTrace)) then begin
            if (IdealScanTrace[Cnt+1] = IdTraceMax) then MinPosEnd := Cnt;
          end else MinPosEnd := Cnt;
        end
          else
        MinPosEnd := Cnt;
      end
        else
      if (IdealScanTrace[Cnt] > IdTraceMin) and (MinPosBeg > 1) // end of Min Value
      then begin
        if (MinPosEnd - MinPosBeg <= enDisregard.NumberOne) then
        for CntNr :=  MinPosBeg to MinPosEnd do begin
          IdealScanTrace[CntNr] := IdTraceMax; //convert to Max Val
         // MainForm.Memo1.Lines.Add(' CntNr = ' + IntToStr(CntNr) +' NrPoints = ' +IntToStr(MinPosEnd - MinPosBeg));
        end;
        MinPosBeg := Cnt;
        MinPosEnd := Cnt-1;
      end;
    End; //For Cnt := 0 to High(IdealScanTrace) do Begin
  End;

  //Get Centers of the Dark Stripes
  MinPosBeg := -1;
  SetLength(StripsYCenter,0);
  For Cnt := 0 to High(IdealScanTrace) do Begin
    if (IdealScanTrace[Cnt] = IdTraceMin) then begin
      if (MinPosBeg = -1) then begin
        MinPosBeg := Cnt;
        if (Cnt < High(IdealScanTrace)) then begin
            if (IdealScanTrace[Cnt+1] = IdTraceMax) then MinPosEnd := Cnt;
        end else MinPosEnd := Cnt;
      end
        else
        MinPosEnd := Cnt;
    end
      else
    if (IdealScanTrace[Cnt] > IdTraceMin) and (MinPosBeg > -1)  //end of a Minimum
    then begin
      SetLength(StripsYCenter, Length(StripsYCenter) + 1);
      StripsYCenter[High(StripsYCenter)] := MinPosBeg + (MinPosEnd - MinPosBeg + 1) div 2;
      MinPosBeg := -1;
    end;
  End;
  // if trace ends with low level get the last one
  if (MinPosBeg < MinPosEnd)
  then begin
      SetLength(StripsYCenter, Length(StripsYCenter) + 1);
      StripsYCenter[High(StripsYCenter)] := MinPosBeg + (MinPosEnd - MinPosBeg + 1) div 2;
  end;

  lbTotalStrips.Caption := 'Total Stripes = ' + IntToStr(Length(StripsYCenter));

End;

 {**************************** Mouse and Popup menu****************************}


procedure TfrmRealLineScan.pbRealLineScanMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var Cnt, Ypos,VertScrBarPosReal,YtopR,YbotR : Integer;


begin

  If (X >= pbRealLineScan.Width-7-Xdelta) and (X < pbRealLineScan.Width-Xdelta)and (RealLineScanOn) then Begin
    //search if in already selected reagens
    If (High(YtopYbotArray) >= 0) Then Begin

      Ypos := Round(tbImagePos.Position*YFactor + Y*YFactor);
      VertScrBarPosReal := Round(tbImagePos.Position*YFactor);

      For Cnt := 0 to High(YtopYbotArray) do Begin
       If (Ypos > YtopYbotArray[Cnt].Ytop) and (Ypos < YtopYbotArray[Cnt].Ybot) Then Begin

         If (Button = mbLeft) and (Ypos > YtopYbotArray[Cnt].Ytop-5) and (Ypos < YtopYbotArray[Cnt].Ytop+5) Then Begin
          Ytop := Y;
          Ybot := round((YtopYbotArray[Cnt].Ybot - VertScrBarPosReal)/Yfactor);
          CORR_mode := MOVE_TOP;
         End
          Else
         If (Button = mbLeft) and (Ypos > YtopYbotArray[Cnt].Ybot-5) and (Ypos < YtopYbotArray[Cnt].Ybot+5) Then Begin
          Ybot := Y;
          Ytop := round((YtopYbotArray[Cnt].Ytop - VertScrBarPosReal)/Yfactor);
          CORR_mode := MOVE_BOT;
         End
          Else
         Begin
          if (Button = mbLeft) then begin
            YtopMem := round((YtopYbotArray[Cnt].Ytop - VertScrBarPosReal)/Yfactor);
            Ydelt   := round((YtopYbotArray[Cnt].Ybot - YtopYbotArray[Cnt].Ytop)/Yfactor);
            Yinit := Y;
            CORR_mode := MOVE_WHOLE;
          end
            else
          if (Button = mbRight) then begin
            CORR_mode := DELETE_SEL;
            CurrIndex := Cnt;
          end;
         End;
         CurrIndex := Cnt;
         Break;
       End //Ypo many conditions
        Else
       Begin
        if (Button = mbLeft) then CORR_mode := CREATING else
        if (Button = mbRight) then begin
            CORR_mode := DELETE_ALL;
        end;
       End;
       
      End; //For Cnt := 0 to High(YtopYbotArray) do Begin
    End   //If (High(YtopYbotArray) >= 0) Then Begin

      Else

    Begin
      if (Button = mbLeft) then CORR_mode := CREATING;
    End;

    if (CORR_mode = CREATING) then Ytop := Y;

    If (CORR_mode in[MOVE_TOP,MOVE_BOT,MOVE_WHOLE]) then with pbRealLineScan do Begin
     // redraw without the active selection

     Canvas.Brush.Color := clBlack;
     Canvas.Pen.Color   := clBlack;
     Canvas.Rectangle(Width-7-Xdelta,0,Width-1-Xdelta,Height);
      //Range to disregard Image

      Canvas.Brush.Color := clLime;
      Canvas.Pen.Color   := clLime;
      For Cnt := 0 to High(YtopYbotArray) do Begin
       If (Cnt <> CurrIndex) then Begin

        If ((YtopYbotArray[Cnt].Ytop < VertScrBarPosReal) and
            (YtopYbotArray[Cnt].Ybot > VertScrBarPosReal+Height)) Or
          ((YtopYbotArray[Cnt].Ytop >= VertScrBarPosReal) and
            (YtopYbotArray[Cnt].Ytop < VertScrBarPosReal+Height)) Or
           ((YtopYbotArray[Cnt].Ybot >= VertScrBarPosReal) and
            (YtopYbotArray[Cnt].Ybot < VertScrBarPosReal+Height))
        Then Begin
          if (YtopYbotArray[Cnt].Ytop >= VertScrBarPosReal) then
            YtopR := round((YtopYbotArray[Cnt].Ytop - VertScrBarPosReal)/YFactor) else
            YtopR := 0;

          if (YtopYbotArray[Cnt].Ybot <= VertScrBarPosReal+Height) then
            YbotR := round((YtopYbotArray[Cnt].Ybot - VertScrBarPosReal)/YFactor) else
            YbotR := Height;

            Canvas.Rectangle(Width-7-Xdelta,YtopR,Width-1-Xdelta,YbotR);
        End;
      End;  //If (Cnt <> CurrIndex) then Begin
    End;  //For Cnt := 0 to High(YtopYbotArray) do Begin

    End; //If (CORR_mode in[MOVE_TOP,MOVE_BOT,MOVE_WHOLE]) then with pbRealLineScan do Begin

    RejectionSpace.Canvas.CopyRect(RejectionSpace.Canvas.ClipRect,pbRealLineScan.Canvas,RejectRect);

    If (CORR_mode in[MOVE_TOP,MOVE_BOT,MOVE_WHOLE]) then with pbRealLineScan do Begin
      YtopR := round((YtopYbotArray[CurrIndex].Ytop - VertScrBarPosReal)/YFactor);
      YbotR := round((YtopYbotArray[CurrIndex].Ybot - VertScrBarPosReal)/YFactor) ;
      Canvas.Rectangle(Width-7-Xdelta,YtopR,Width-1-Xdelta,YbotR);
    End;

  End; //If (Button = mbLeft) and (X > pbRealLineScan.Width-10) and (RealLineScanOn) then Begin
End;


procedure TfrmRealLineScan.pbRealLineScanMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var  Ypos, Xpos, Cnt : Integer;
begin

 If (RealLineScanOn) then Begin
    Ypos := Round(tbImagePos.Position*YFactor + Y*YFactor);
    Xpos := Round(X*XpixFactor);
    if (Xpos > imXsize-1) then Xpos := imXsize-1;

    lbMousePos.Caption := ' X = ' + IntToStr(Xpos) + ' pix, Y = ' + IntToStr(Ypos) +
    ' pix, ' + FloatToStrF(TimeSt[Ypos]*1000,ffFixed,10,3) + ' ms';


   If (X >= pbRealLineScan.Width-7-Xdelta) and (X <= pbRealLineScan.Width-Xdelta) and
      (High(YtopYbotArray) >= 0) and (CORR_mode = INACTIVE) Then Begin

      For Cnt := 0 to High(YtopYbotArray) do Begin
       If (Ypos > YtopYbotArray[Cnt].Ytop) and (Ypos < YtopYbotArray[Cnt].Ybot) Then Begin
         If (Ypos > YtopYbotArray[Cnt].Ytop-5) and (Ypos < YtopYbotArray[Cnt].Ytop+5) Then Begin
          pbRealLineScan.Cursor := crSizeNS;
         End
          Else
         If (Ypos > YtopYbotArray[Cnt].Ybot-5) and (Ypos < YtopYbotArray[Cnt].Ybot+5) Then Begin
          pbRealLineScan.Cursor := crSizeNS;
         End
          Else
         Begin
          pbRealLineScan.Cursor := crHandPoint;
         End;
         Break;
       End //Ypo many conditions
        Else
        pbRealLineScan.Cursor := crDefault;
      End; //For Cnt := 0 to High(YtopYbotArray) do Begin

   End   //(X >= pbRealLineScan.Width-7-Xdelta) and (X <= pbRealLineScan.Width-Xdelta) and (High(YtopYbotArray) >= 0) and ....

    Else

  If (CORR_mode <> INACTIVE) Then With pbRealLineScan Do Begin

    Canvas.CopyRect(RejectRect,RejectionSpace.Canvas,RejectionSpace.Canvas.ClipRect);
    Canvas.Brush.Color := clLime;
    Canvas.Pen.Color   := clLime;

   If (CORR_mode = CREATING) Then Begin
      Ybot := Y;
      Canvas.Rectangle(Width-7-Xdelta,Ytop,Width-1-Xdelta,Ybot);
   End
    Else
   If (CORR_mode = MOVE_TOP) Then Begin
      Ytop := Y;
      Canvas.Rectangle(Width-7-Xdelta,Ytop,Width-1-Xdelta,Ybot);
   End
    Else
   If (CORR_mode = MOVE_BOT) Then Begin
      Ybot := Y;
      Canvas.Rectangle(Width-7-Xdelta,Ytop,Width-1-Xdelta,Ybot);
   End
    Else
   If (CORR_mode = MOVE_WHOLE) Then Begin
      Ytop := YtopMem - (Yinit-Y);
      Ybot := Ytop + Ydelt;
      Canvas.Rectangle(Width-7-Xdelta,Ytop,Width-1-Xdelta,Ybot);
   End;


  End // If (CORR_mode <> INACTIVE) Then With pbRealLineScan Do Begin

    Else

  If (X < pbRealLineScan.Width-7-Xdelta) and (CORR_mode = INACTIVE) and (pbRealLineScan.Cursor <> crDefault)
    then pbRealLineScan.Cursor := crDefault;

 End; //If (RealLineScanOn) then Begin

End;

procedure TfrmRealLineScan.pbRealLineScanMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var Cnt,YtopR,YbotR,ButtonSelected : Integer;
    Inserted : Boolean;
    YtopYbotArrayTemp : TYtopYbotArray;
begin

  If (CORR_mode <> INACTIVE) and (RealLineScanOn) then Begin

    If (CORR_mode = CREATING) Then Begin
      if (Ytop > Ybot) then begin
        YtopR  := Ybot;
        Ybot := Ytop;
        Ytop := YtopR;
      end;

      YtopR := Round(Ytop*YFactor + tbImagePos.Position*YFactor);
      YbotR := Round(Ybot*YFactor + tbImagePos.Position*YFactor);

      If (High(YtopYbotArray) >= 0)then Begin
        SetLength(YtopYbotArrayTemp,Length(YtopYbotArray)+1);
        Inserted := False;
        Cnt := 0;

        While Cnt <= High(YtopYbotArrayTemp) do begin
          If (Cnt <= High(YtopYbotArray)) then Begin

          if (YtopR > YtopYbotArrayTemp[Cnt].Ybot)  then begin
            YtopYbotArrayTemp[Cnt] := YtopYbotArray[Cnt];
          end
            else
          if (YtopR < YtopYbotArrayTemp[Cnt].Ybot) and not(Inserted) then begin
            Inserted := True;
            YtopYbotArrayTemp[Cnt].Ytop := YtopR;
            YtopYbotArrayTemp[Cnt].Ybot := YbotR;
            YtopYbotArrayTemp[Cnt+1] := YtopYbotArray[Cnt];
          end
            else
          begin
            YtopYbotArrayTemp[Cnt+1] := YtopYbotArray[Cnt];
          end;
          End
            Else
          Begin
            YtopYbotArrayTemp[Cnt].Ytop := YtopR;
            YtopYbotArrayTemp[Cnt].Ybot := YbotR;
          End;

          Inc(Cnt);

        End; //For Cnt := 0 to High(YtopYbotArrayTemp)

        SetLength(YtopYbotArray,High(YtopYbotArray)+2);
        For Cnt := 0 to High(YtopYbotArray) do begin
          YtopYbotArray[Cnt] := YtopYbotArrayTemp[Cnt];
        End;
      End //If (High(YtopYbotArray) >= 0)then Begin
        else
      Begin
        SetLength(YtopYbotArray,High(YtopYbotArray)+2);
        YtopYbotArray[High(YtopYbotArray)].Ytop := YtopR;
        YtopYbotArray[High(YtopYbotArray)].Ybot := YbotR;
      End;
    End //If (CORR_mode = CREATING) Then Begin

      Else

    If (CORR_mode = MOVE_TOP) Then Begin
      YtopYbotArray[CurrIndex].Ytop := Round(Ytop*YFactor + tbImagePos.Position*YFactor);
    End
      Else
    If (CORR_mode = MOVE_BOT) Then Begin
      YtopYbotArray[CurrIndex].Ybot := Round(Ybot*YFactor + tbImagePos.Position*YFactor);
    End
     Else
    If (CORR_mode = MOVE_WHOLE) Then Begin
      YtopYbotArray[CurrIndex].Ytop := Round(Ytop*YFactor + tbImagePos.Position*YFactor);
      YtopYbotArray[CurrIndex].Ybot := Round(Ybot*YFactor + tbImagePos.Position*YFactor);
    End;

    //swap if Ytop > Ybot
    If (CORR_mode in [CREATING,MOVE_TOP, MOVE_BOT,MOVE_WHOLE]) then begin
      if (YtopYbotArray[CurrIndex].Ytop > YtopYbotArray[CurrIndex].Ybot) then begin
        Ytop  := YtopYbotArray[CurrIndex].Ybot;
        YtopYbotArray[CurrIndex].Ybot := YtopYbotArray[CurrIndex].Ytop;
        YtopYbotArray[CurrIndex].Ytop := Ytop;
      end;
    End;

    If (CORR_mode = DELETE_ALL) Then Begin
      ButtonSelected := MessageDlg('Delete All Selections?',mtInformation, mbOKCancel, 0);
      if (ButtonSelected  = mrOK) then SetLength(YtopYbotArray,0);
    End
      Else
    If (CORR_mode = DELETE_SEL) Then Begin
     ButtonSelected := MessageDlg('Delete This Selection?',mtInformation, mbOKCancel, 0);
     If (ButtonSelected  = mrOK) then Begin

      if (Length(YtopYbotArray) = 1) then SetLength(YtopYbotArray,0) else
      begin
        SetLength(YtopYbotArrayTemp,Length(YtopYbotArray) - 1);
        YtopR := 0;
        for Cnt  := 0 to High(YtopYbotArray) do begin
          if (Cnt <> CurrIndex) then begin
            YtopYbotArrayTemp[YtopR] := YtopYbotArray[Cnt];
            Inc(YtopR);
          end;
        end;  //for Cnt  := 0 to High(YtopYbotArray) do begin
        SetLength(YtopYbotArray,Length(YtopYbotArrayTemp));
        for Cnt  := 0 to High(YtopYbotArray) do begin
          YtopYbotArray[Cnt] := YtopYbotArrayTemp[Cnt];
        end;
      end;
     End; //If (ButtonSelected  = mrOK) then Begin
    End; //If (CORR_mode = DELETE_SEL) Then Begin

    GenerateIdealScanTrace;
    CORR_mode := INACTIVE;
    pbRealLineScan.Cursor := crDefault;

    UpdateRealLineScan(False);


  End;  // If (CORR_mode <> INACTIVE) and (RealLineScanOn) then Begin

End;

{**************************** End Mouse ********************************}

procedure TfrmRealLineScan.pbRealLineScanPaint(Sender: TObject);
begin
   UpdateRealLineScan(True);
end;

procedure TfrmRealLineScan.rbAnalChannelOneClick(Sender: TObject);
begin
  if (RealLineScanOn) then begin
    if(rbAnalChannelOne.Checked) then Move(ImDispl[0],ImageArrRaw[0],ImagePix) else
    if(rbAnalChannelTwo.Checked) then Move(Im2ndDispl[0],ImageArrRaw[0],ImagePix);
    Move(ImageArrRaw[0],ImageArrCor[0],ImagePix);  //if you don't do it the contens from previous file will remeain in this Buffer
    Move(ImageArrRaw[0], ImageArrSm[0],ImagePix);
    GenerateRealScanTrace;
    GenerateIdealScanTrace;
    UpdateRealLineScan(True);
  end;
end;

procedure TfrmRealLineScan.rbAnalChannelTwoClick(Sender: TObject);
begin
  if (RealLineScanOn) then begin
    if(rbAnalChannelOne.Checked) then Move(ImDispl[0],ImageArrRaw[0],ImagePix) else
    if(rbAnalChannelTwo.Checked) then Move(Im2ndDispl[0],ImageArrRaw[0],ImagePix);
    Move(ImageArrRaw[0],ImageArrCor[0],ImagePix);  //if you don't do it the contens from previous file will remeain in this Buffer
    Move(ImageArrRaw[0], ImageArrSm[0],ImagePix);
    GenerateRealScanTrace;
    GenerateIdealScanTrace;
    UpdateRealLineScan(True);
  end;
end;

procedure TfrmRealLineScan.rbViewAnalysedClick(Sender: TObject);
begin
  if (RealLineScanOn) then UpdateRealLineScan(True);
end;

procedure TfrmRealLineScan.rbViewBothChannelsClick(Sender: TObject);
begin
  if (RealLineScanOn) then UpdateRealLineScan(True);
end;

procedure TfrmRealLineScan.rbViewChOneClick(Sender: TObject);
begin
  if (RealLineScanOn) then UpdateRealLineScan(True);
end;

procedure TfrmRealLineScan.rbViewChTwoClick(Sender: TObject);
begin
  if (RealLineScanOn) then UpdateRealLineScan(True);
end;

{******************************************************************************}

procedure TfrmRealLineScan.sbCorrectSlopeClick(Sender: TObject);
Begin
  If (RealLineScanOn) then Begin
    StraightenStrips;
    GenerateRealScanTrace;
    GenerateIdealScanTrace;

    UpdateRealLineScan(True);
  End;

end;

{******************************************************************************}
Procedure TfrmRealLineScan.StraightenStrips;
var CntY,CntX, Xend, Yend, Yshift, YHight : Integer;
Begin

  Xend := ImXsize - 1;    //to leave them out of loop
  Yend := ImYSize - 1;    //to leave them out of loop

  If (LineSlope < 0) Then Begin
    YHight := Round(-LineSlope*(imXsize-1));

  //fill ImageArrCor with max = 255
    For CntY := Yend-YHight to Yend do Begin
      For CntX := 0 to Xend do Begin
        ImageArrCor[CntX + imXsize*CntY] := 255;
      End;
    End;

    For CntX := 0 to  Xend do Begin
      Yshift := Round(-LineSlope*CntX);
      For CntY := 0 to Yend do Begin
        if (CntY + Yshift < ImYsize) then
        ImageArrCor[CntX + imXsize*CntY] := ImageArrRaw[CntX + imXsize*(CntY + Yshift)];
      End;
    End;
    Move(ImageArrCor[0], ImageArrSm[0],ImagePix);
    Move(ImageArrCor[0],ImageArrRaw[0],ImagePix);
  End //If (LineSlope < 0) Then Begin

    Else

  If (LineSlope > 0) Then Begin
    YHight := Round(LineSlope*(imXsize-1));
  //fill ImageArrCor with max = 255
    For CntY := Yend-YHight to Yend do Begin
      For CntX := 0 to Xend do Begin
        ImageArrCor[CntX + imXsize*CntY] := 255;
      End;
    End;

    For CntX := 0 to  Xend do Begin
      Yshift := Round(LineSlope*(ImXSize-CntX));
      For CntY := 0 to Yend do Begin
        if (CntY + Yshift < ImYsize) then
        ImageArrCor[CntX + imXsize*CntY] := ImageArrRaw[CntX + imXsize*(CntY + Yshift)];
      End;
    End;
    Move(ImageArrCor[0],ImageArrSm[0],ImagePix);
  End; //If (LineSlope < 0) Then Begin

End; procedure TfrmRealLineScan.StringGridBinsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var aCol, aRow, P,BinBeg,CurrentBinWidthMS : Integer;
    CurrentBinWidthPIX : Double;
begin

If (RealLineScanOn) and Not(BINTableEmpty) Then begin
  With StringGridBins do begin
      MouseToCell(x, y, aCol, aRow);
    If (aRow > 0) and (aCol > 1) Then Begin
      P := Pos('-',(Cells[2, aRow]));
      BinBeg := StrToInt(AnsiString(Copy(Cells[2, aRow],1,P-1)));
      P := Pos('-',(Cells[2, 2]));
      CurrentBinWidthMS  := StrToInt(AnsiString(Copy(Cells[2, 2],1,P-1)));
      CurrentBinWidthPIX := imYsize/((TimeSt[1]*1000*imYsize)/CurrentBinWidthMS);
      if (trPercOfOrig_Y.Position <> round(100/(CurrentBinWidthPIX/pbRealLineScan.Height))) then
      trPercOfOrig_Y.Position := round(100/(CurrentBinWidthPIX/pbRealLineScan.Height));
      enTimePos.NumberFloat := BinBeg;
      enTimePosReturnPressed(Sender);
    End;
  End;
End;
End;

//Procedure StraightenStrips
{*************************************************************************}


procedure TfrmRealLineScan.sbBinValuesClick(Sender: TObject);
begin
  BinValues;
end;
 //StripsYCenters are mesured in line number (pixels Y direction)
Procedure TfrmRealLineScan.BinValues;
var BinWidth,Cnt, BinNr : Integer;
    TimSt : Double;
Begin
  BinWidth := enBinWidth.NumberOne;
  SetLength(BinArray,Trunc((TimeSt[High(TimeSt)]*1000) / BinWidth));
  {Zero the BinArray.  Otherwize if it is reused it will compound the Strip Number}
  for BinNr := 0 to High(BinArray) do BinArray[BinNr] := 0; //introduced 9-26-2016
  StringGridBins.RowCount := Length(BinArray) + 1;
  For Cnt := 0 to High(StripsYCenter) do Begin
    BinNr := Trunc((TimeSt[StripsYCenter[Cnt]]*1000)/BinWidth);
    Inc(BinArray[BinNr]);
  End;

  with StringGridBins do begin
  For Cnt := 0 to High(BinArray) do Begin
    Cells[0,Cnt+1] := IntToStr(Cnt+1);  {This Goes on Fixed (Gray Cell}
    Cells[1,Cnt+1] := IntToStr(BinArray[Cnt]);
    Cells[2,Cnt+1] := IntToStr(BinWidth*Cnt) + '-' + IntToStr(BinWidth*Cnt+BinWidth);
  End;
  end;

  BINTableEmpty := False;

  if (frmTimeHistograms <> nil) then begin
    if (frmTimeHistograms.rbLineScan.Checked) then
    with frmTimeHistograms do begin
    GetMessageFromRealLineScan;
    enBinWidth.Enabled       := False;
    enStartBinningAt.Enabled := False;
    enRangeFrom.Enabled      := False;
    enRangeTo.Enabled        := False;
    end;
  end;

End;

{************************************************************************}

procedure TfrmRealLineScan.sbApplySmoothingClick(Sender: TObject);
begin
  If (RealLineScanOn) then Begin
    if (cbImageSmoothingKind.ItemIndex = 0)  then SmoothKalman(0.8) else
    if (cbImageSmoothingKind.ItemIndex = 1)  then SmoothKalman(0.9) else
    if (cbImageSmoothingKind.ItemIndex = 2)  then ApplySmoothingOnLineScan;

    Move(ImageArrSm[0],ImageArrCor[0],ImagePix);

    GenerateRealScanTrace;
    GenerateIdealScanTrace;
    UpdateRealLineScan(True);
  End;
end;

procedure TfrmRealLineScan.SmoothKalman(const Gain : Double);
var  CntY,CntX,EndOfArray : Integer;
     SourceArr,OutArr : TDynByteArray;
Begin

  EndOfArray := imYsize;
  SetLength(SourceArr,imYsize);
  SetLength(OutArr,imYsize);

  For CntX := 0 to imXsize-1 Do Begin
    For CntY := 0 to imYsize-1 Do Begin
      SourceArr[CntY] := ImageArrCor[CntX + imXsize*CntY];
    End;
    Kalman1DFilt(SourceArr,OutArr,Gain,EndOfArray);
    For CntY := 0 to imYsize-1 Do Begin
      ImageArrSm[CntX + imXsize*CntY] := OutArr[CntY];
    End;
  End;

End;

procedure TfrmRealLineScan.sbSaveStripsClick(Sender: TObject);
var SaveFname : String;
    TxtFile   : TextFile;
    WriteStr  : AnsiString;
    GaussSm   : AnsiString;
    Cnt : Integer;
begin

 If (RealLineScanOn) then Begin

  SaveDialog_RealLineScan.Title := 'Stripes vs Time as Text File';
  SaveDialog_RealLineScan.Filter := 'Stripes vs Time Text (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveDialog_RealLineScan.InitialDir := FilePaths.MarkFilePath;
  SaveDialog_RealLineScan.FileName := FilePaths.MarkFilePath + imFtitle + 'Stripes vs Time';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveDialog_RealLineScan.InitialDir := ExtractFilePath(ImFname);
  SaveDialog_RealLineScan.FileName := imFtitle + 'Stripes vs Time';
  end;
  //So far it will use FilePaths.MarkFilePath

 If (SaveDialog_RealLineScan.Execute) then Begin

  FilePaths.MarkFilePath := ExtractFilePath(SaveDialog_RealLineScan.FileName);
  SaveFname              := SaveDialog_RealLineScan.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If (IsFileInUse(SaveFname) = False) then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn Stripes vs Time Text File extracted from: ' + imFtitle;
    Writeln(TxTFile, WriteStr);
    {2nd: writes type and source of data}
    if ((rbAnalChannelOne.Checked) and (ChannelOrder = ASCENDING)) or
       ((rbAnalChannelTwo.Checked) and (ChannelOrder = DESCENDING))
    then WriteStr := 'from Channel One'
      else
    if ((rbAnalChannelTwo.Checked) and (ChannelOrder = ASCENDING)) or
       ((rbAnalChannelOne.Checked) and (ChannelOrder = DESCENDING))
    then WriteStr := 'from Channel Two';

    Writeln(TxTFile, WriteStr);

    {4th: wtites explanation of order of data}
    WriteStr := 'Follow Data for: Strip Number, Strip Center Location at: Y Pix Value and Y time (ms)';
    Writeln(TxTFile, WriteStr);

    {5th: writes data}
    with StringGridBins do begin
    For Cnt := 0 to High(StripsYCenter) do Begin
      WriteStr := IntToStr(Cnt+1) + Char(9) + IntToStr(StripsYCenter[Cnt]) + Char(9) + FloatToStr(TimeSt[StripsYCenter[Cnt]]);
      Writeln(TxTFile, WriteStr);
    End;
    end;

    CloseFile(TxtFile);

  End;
 End; //If (SaveDialog_RealLineScan) then Begin
 End;

End;

procedure TfrmRealLineScan.spSaveTableClick(Sender: TObject);
var SaveFname : String;
    TxtFile   : TextFile;
    WriteStr  : AnsiString;
    GaussSm   : AnsiString;
    Cnt : Integer;
begin

If (RealLineScanOn) then Begin
If not(BINTableEmpty) then Begin

  SaveDialog_RealLineScan.Title := 'Stripes Bin Table as Text File';
  SaveDialog_RealLineScan.Filter := 'Stripes Bin Table as Text (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.MarkFilePath <> '') then begin
  SaveDialog_RealLineScan.InitialDir := FilePaths.MarkFilePath;
  SaveDialog_RealLineScan.FileName := FilePaths.MarkFilePath + imFtitle + 'Stripes Bin Table';
  end else
  if (UseMoviFilePath = True) or (FilePaths.MarkFilePath = '') then begin
  SaveDialog_RealLineScan.InitialDir := ExtractFilePath(ImFname);
  SaveDialog_RealLineScan.FileName := imFtitle + 'Stripes Bin Table';
  end;
  //So far it will use FilePaths.MarkFilePath

 If (SaveDialog_RealLineScan.Execute) then Begin

  FilePaths.MarkFilePath := ExtractFilePath(SaveDialog_RealLineScan.FileName);
  SaveFname              := SaveDialog_RealLineScan.FileName;
  if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

  If (IsFileInUse(SaveFname) = False) then Begin
    AssignFile(TxtFile, SaveFname);
    ReWrite(TxtFile);
    {1st line: writes File name type}
    WriteStr := 'SparkAn Stripes Bin Table Text File extracted from: ' + imFtitle;
    Writeln(TxTFile, WriteStr);
    {2nd: writes type and source of data}
    if ((rbAnalChannelOne.Checked) and (ChannelOrder = ASCENDING)) or
       ((rbAnalChannelTwo.Checked) and (ChannelOrder = DESCENDING))
    then WriteStr := 'from Channel One'
      else
    if ((rbAnalChannelTwo.Checked) and (ChannelOrder = ASCENDING)) or
       ((rbAnalChannelOne.Checked) and (ChannelOrder = DESCENDING))
    then WriteStr := 'from Channel Two';

    Writeln(TxTFile, WriteStr);

    {4th: wtites explanation of order of data}
    WriteStr := 'Follow Data for: BIN Number, BIN Value, BIN Range (ms)';
    Writeln(TxTFile, WriteStr);

    {5th: writes data}
    with StringGridBins do begin
    For Cnt := 1 to StringGridBins.RowCount-1 do Begin
      WriteStr := Cells[0,Cnt] + Char(9) + Cells[1,Cnt] + Char(9) + Cells[2,Cnt];
      Writeln(TxTFile, WriteStr);
    End;
    end;

    CloseFile(TxtFile);

  End;
 End; //If (SaveDialog_RealLineScan.Execute) then Begin
 End
  Else
  MessageDlg('BIN Table is Empty.',mtInformation,[mbOK],0);
End;
End;

Procedure TfrmRealLineScan.ApplySmoothingOnLineScan; { used to apply any Smoothing on ApplySmoothingOnLineScan }
//works with Byte Arrays only
var TempByteArray : TDynByteArray;
Begin

  If (SmoothMode = SMOOTH_BOX_MED) then Begin
    SetLength(TempByteArray,ImagePix);
    BoxCarFilt(ImageArrCor, TempByteArray, imXsize, imYsize,BoxSmSize, True);
    MedianFilt(TempByteArray, ImageArrSm, imXsize,imYsize, MedSmSize, True);
  End

    Else

  If (SmoothMode = SMOOTH_GAUSS_MED) then Begin
    SetLength(TempByteArray,ImagePix);
    Gauss2DFilt(ImageArrCor, TempByteArray, imXsize, imYsize,GaussSmSize, True);
    MedianFilt(TempByteArray, ImageArrSm, imXsize,imYsize, MedSmSize, True);
  End

    Else

  If (SmoothMode = SMOOTH_MED_BOX) then Begin
    SetLength(TempByteArray,ImagePix);
    MedianFilt(ImageArrCor, TempByteArray, imXsize, imYsize, MedSmSize, True);
    BoxCarFilt(TempByteArray, ImageArrSm, imXsize,imYsize, BoxSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_MED_GAUSS) then Begin
    SetLength(TempByteArray,ImagePix);
    MedianFilt(ImageArrCor, TempByteArray, imXsize, imYsize,MedSmSize, True);
    Gauss2DFilt(TempByteArray, ImageArrSm, imXsize,imYsize, GaussSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_BOX) then Begin
    BoxCarFilt(ImageArrCor, ImageArrSm, imXsize, imYsize,BoxSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_GAUSS) then Begin
    Gauss2DFilt(ImageArrCor, ImageArrSm, imXsize, imYsize,GaussSmSize, True);
  End

    else

  If (SmoothMode = SMOOTH_MED) then Begin
     MedianFilt(ImageArrCor, ImageArrSm, imXsize, imYsize,MedSmSize, True);
  End;

End; { Procedure ApplySmoothing; }

{********************Scrolling Up and down***********************************}

procedure TfrmRealLineScan.tbImagePosChange(Sender: TObject);
begin
 if (RealLineScanOn) then begin
  enPixYPos.NumberOne    := Round(tbImagePos.Position*YFactor);
  CurrentYPos            := Round(tbImagePos.Position*YFactor);
  CurrentYcent           := Round(tbImagePos.Position*YFactor + (Source_RS_Ysize)/2);
  enTimePos.NumberFloat  := TimeSt[enPixYPos.NumberOne]*1000;
  UpDownPage.Position    := tbImagePos.Position div Source_RS_Ysize;  //this does not cause 'Click' events
  UpdateRealLineScan(True);
 end;
end;

procedure TfrmRealLineScan.UpDownPageClick(Sender: TObject; Button: TUDBtnType);
begin
  if (RealLineScanOn) then begin
    enPixYPos.NumberOne := round(StrToInt(enPageNr.Text)*Source_RS_Ysize);
    tbImagePos.Position := enPixYPos.NumberOne;
  end;
end;

procedure TfrmRealLineScan.enPageNrReturnPressed(Sender: TObject);
var Button: TUDBtnType;
begin
  if (RealLineScanOn) then begin
   UpDownPage.Position := enPageNr.NumberOne;
   UpDownPageClick(Sender,Button);
  end;
end;

procedure TfrmRealLineScan.enTimePosReturnPressed(Sender: TObject);
var PixPos,i : Integer;
    OneLineTime : Double;
begin
   if (RealLineScanOn) then begin
   OneLineTime := imYsize/(TimeSt[High(TimeSt)]*1000); //gives time per One Line (one pixel0
   PixPos := round(OneLineTime*enTimePos.NumberFloat);

   {often (always) Zeiss Time Stamps are irregular:
     example: 0.23636
              0.23636
              0.23636
              4.96364  !!!
              0.23636
              0.23636
              1.18182   !!!
              0.23636
              0.23636

     which results in longer total time and it is impossible to precisely predict & calculate
     the line (Y pixel) for a Given Time.  That's why seach is used in the next paragraph}

   if (TimeSt[PixPos]*1000 > enTimePos.NumberFloat) then
   for i := PixPos downto 1 do begin
    if (TimeSt[i]*1000 <= enTimePos.NumberFloat) then begin
      PixPos := i;
      Break;
    end;
   end

    else
   //typically this paragraph is used
   if (TimeSt[PixPos]*1000 < enTimePos.NumberFloat) then
   for i := PixPos to High(TimeSt) do begin
    if (TimeSt[i]*1000 >= enTimePos.NumberFloat) then begin
      PixPos := i;
      Break;
    end;
   end;

   tbImagePos.Position := round(PixPos/Yfactor);
  //OnPaint refreshes  lbTimePos.Caption
  end;

end;

procedure TfrmRealLineScan.enPixYPosReturnPressed(Sender: TObject);
begin
if (RealLineScanOn) then tbImagePos.Position := round(enPixYPos.NumberOne/Yfactor);
 //OnPaint refreshes  lbTimePos.Caption
end;


{********************** End Scrolling Up and down ****************************}

procedure TfrmRealLineScan.trAngleChange(Sender: TObject);
var Angle,AngleRad : Double;
begin
  Angle := trAngle.Position/2;
  slAngle.Caption := FloatToStrF(Angle,ffFixed,3,1) + '^o';
  AngleRad := DegToRad(Angle);
  //tan works with radians 1st convert degree in radians
  //one radian is equal to 180/π degrees. Thus, to convert from radians to degrees, multiply by 180/π.
  LineSlope := Tan(AngleRad);
  UpdateRealLineScan(True);

end;

procedure TfrmRealLineScan.trPercOfOrig_XChange(Sender: TObject);
begin
 If (RealLineScanOn) then Begin
  lbXperc.Caption := IntToStr(trPercOfOrig_X.Position) + ' %';; //Maximum Width = 512 pixels
  Dest_RS_Xsize := Round((512*trPercOfOrig_X.Position)/100);  //always 512 width
  XpixFactor := imXsize/Dest_RS_Xsize;
  Xdelta      := 512-Dest_RS_Xsize;
  dsSectionInUse.Width := Dest_RS_Xsize + 47;
  HorizOffset := 562 - Xdelta;
  NrHorizPos  := 520 - Xdelta;
  IdTraceMin  := - 5;
  IdTraceMax  := 127 + 5;
  dsMinAndMax.Left := dsMinAndMaxLeft - Xdelta;
  enMinAndMax.Left := enMinAndMaxLeft - Xdelta;

  if (RealLineScanOn) then begin
    with pbRealLineScan do begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := clBlack;
      Canvas.Pen.Color   := clBlack;
      Canvas.Rectangle(Dest_RS_Xsize,0,Width,Height);
    end;
    UpdateRealLineScan(True);
  end;
 End;

end;

procedure TfrmRealLineScan.trPercOfOrig_YChange(Sender: TObject);
var OnChangeMem : TNotifyEvent;
    Cnt : Integer;
begin

 If (RealLineScanOn) then Begin
  YFactor := 100/trPercOfOrig_Y.Position;
  Source_RS_Ysize := Round(Dest_RS_Ysize*YFactor);  // Dest_RS_Ysize = pbRealLineScan.Height;
  lbYperc.Caption := FloatToStrF(100/trPercOfOrig_Y.Position,ffFixed,2,1) + ' x';

  SetLength(PlotTrace,Source_RS_Ysize);
  for Cnt := 0 to High(PlotTrace) do PlotTrace[Cnt].Y := Round(Cnt/YFactor);

  OnChangeMem := tbImagePos.OnChange;
  tbImagePos.OnChange := nil;


  if not(cbKeepYcenter.Checked) then
    tbImagePos.Position := round(CurrentYPos/YFactor) else
    tbImagePos.Position := round(CurrentYcent/YFactor) - round((Source_RS_Ysize div 2)/YFactor);

  if (tbImagePos.Position > round(imYsize*Yfactor) - pbRealLineScan.Height-1) then
  tbImagePos.Position := round(imYsize/Yfactor) - pbRealLineScan.Height-1;
  tbImagePos.Max := round(imYsize/Yfactor) - pbRealLineScan.Height-1;
  tbImagePos.OnChange := OnChangeMem;

  enPageNr.Max   := tbImagePos.Max div Source_RS_Ysize;
  UpDownPage.Max := tbImagePos.Max div Source_RS_Ysize;

  UpdateRealLineScan(True);

  enPixYPos.NumberOne    := Round(tbImagePos.Position*YFactor);  //pixels
  enTimePos.NumberFloat  := TimeSt[enPixYPos.NumberOne]*1000;    //time
  if (trPercOfOrig_Y.Position = 100) then sbCorrectSlope.Enabled := True else
                                          sbCorrectSlope.Enabled := False;
 End;

End;

Procedure TfrmRealLineScan.DoUpdateRealLineScan;
begin
  UpdateRealLineScan(True);
end;

Procedure TfrmRealLineScan.UpdateRealLineScan(const All : Boolean);
var HeightMem,VertScrBarPos,VertScrBarPosReal, VertPageOffsetReal, VetrFontOffset : Integer;
    YtopR,YbotR,Cnt  : Integer;
    pRealLineScanImage : Pointer;
    pBMPInfo           : pBitmapInfo;
Begin

If (RealLineScanOn) Then Begin

  VertScrBarPos     := tbImagePos.Position;
  VertScrBarPosReal := Round(VertScrBarPos*YFactor);

 If (All) Then Begin

  If (rbViewChOne.Checked) or ((rbViewAnalysed.Checked) and (rbAnalChannelOne.Checked)) then
  with lpBitmapInfo[0]^.bmiHeader do Begin
    HeightMem := biHeight;
    biHeight := -Source_RS_Ysize;
    pBMPInfo := lpBitmapInfo[0];
  End { with header.bmiHeader }
    else
  If (rbViewChTwo.Checked) or ((rbViewAnalysed.Checked) and (rbAnalChannelTwo.Checked))  then
  with lpBitmapInfo[2]^.bmiHeader do Begin
    HeightMem := biHeight;
    biHeight := -Source_RS_Ysize;
    pBMPInfo := lpBitmapInfo[2];
  End { with header.bmiHeader }
    else
  If (rbViewBothChannels.Checked)then
  with pMergeBMPInfo^.bmiHeader do Begin
    HeightMem := biHeight;
    biHeight := -Source_RS_Ysize;
    pBMPInfo := pMergeBMPInfo;
  End; { with header.bmiHeader }

  if (rbViewChOne.Checked) then begin
      pRealLineScanImage := @ImDispl[VertScrBarPosReal*imXsize];
  end
     else
  if (rbViewChTwo.Checked) then begin
      pRealLineScanImage := @Im2ndDispl[VertScrBarPosReal*imXsize];
  end
    else
  if (rbViewAnalysed.Checked) then begin
      pRealLineScanImage := @ImageArrSm[VertScrBarPosReal*imXsize];
  end
    else
  if (rbViewBothChannels.Checked) then
    pRealLineScanImage := @MergeImDispl[VertScrBarPosReal*imXsize*4];

 End;

  With pbRealLineScan Do Begin

  If (All) Then Begin
    SetStretchBltMode(Canvas.Handle, STRETCH_HALFTONE);
    StretchDIBits(Canvas.Handle, 0, 0, Dest_RS_Xsize, Dest_RS_Ysize, 0, 0, imXsize,
          Source_RS_Ysize, pRealLineScanImage, pBMPInfo^, DIB_RGB_COLORS, SRCCOPY);

    Canvas.Pen.Color := clWhite;
    Canvas.Pen.Mode := pmXor;
    //selection range of Image always based on 0-511 range; RealTrace converts this to real position
    Canvas.MoveTo(round((dsSectionInUse.PosFrom*trPercOfOrig_X.Position)/(100*XscrFactor)),0);
    Canvas.LineTo(round((dsSectionInUse.PosFrom*trPercOfOrig_X.Position)/(100*XscrFactor)),Height);
    Canvas.MoveTo(round((dsSectionInUse.PosTo*trPercOfOrig_X.Position)/(100*XscrFactor)),0);
    Canvas.LineTo(round((dsSectionInUse.PosTo*trPercOfOrig_X.Position)/(100*XscrFactor)),Height);
    Canvas.Pen.Mode := pmCopy;

     //Plot Corection Line
    If (cbShowCorrectionLine.Checked) Then Begin
      Canvas.Pen.Width := 3;
      Canvas.Pen.Color := clWhite;
      Canvas.Pen.Mode := pmXor;
      if (LineSlope = 0) then begin
        Canvas.MoveTo(0,10);
        Canvas.LineTo(Dest_RS_Xsize-1,10);
      end
        else
      if (LineSlope < 0) then begin
        Canvas.MoveTo(0,10);
        Canvas.LineTo(Dest_RS_Xsize-1,Round(-LineSlope*(Dest_RS_Xsize-1))+10);
      end
        else
      if (LineSlope > 0) then begin
        Canvas.MoveTo(Dest_RS_Xsize-1,10);
        Canvas.LineTo(0,Round(LineSlope*(Dest_RS_Xsize-1))+10);
      end;
      Canvas.Pen.Mode := pmCopy;
      Canvas.Pen.Width := 1;
    End;

  End;  //If (All) Then Begin

     //clear the black space for traces
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color   := clBlack;
    Canvas.Rectangle(Dest_RS_Xsize,0,Width,Height);

    //plot real trace
    for Cnt := 0 to High(PlotTrace) do
      PlotTrace[Cnt].X := RealScanTrace[Cnt + VertScrBarPosReal] + HorizOffset;
   // for Cnt := 0 to High(PlotTrace) do PlotTrace[Cnt].Y := Round(Cnt/YFactor);
    Canvas.Pen.Color := clYellow;
    Canvas.Polyline(PlotTrace);

    //Plot Ideal Trace
    for Cnt := 0 to High(PlotTrace) do
      PlotTrace[Cnt].X := IdealScanTrace[Cnt + VertScrBarPosReal] + HorizOffset;
    Canvas.Pen.Color := clAqua;
    Canvas.Polyline(PlotTrace);

    //Plot Min and Max Trace selection
    Canvas.Pen.Color := clRed;
    Canvas.MoveTo(dsMinAndMax.PosFrom+HorizOffset,0);
    Canvas.LineTo(dsMinAndMax.PosFrom+HorizOffset,Height);
    Canvas.MoveTo(dsMinAndMax.PosTo+HorizOffset,0);
    Canvas.LineTo(dsMinAndMax.PosTo+HorizOffset,Height);
    if (cbShow50percent.Checked) then begin
      Canvas.Pen.Style := psDash;
      Canvas.MoveTo((dsMinAndMax.PosFrom+dsMinAndMax.PosTo) div 2 + HorizOffset,0);
      Canvas.LineTo((dsMinAndMax.PosFrom+dsMinAndMax.PosTo) div 2 + HorizOffset,Height);
      Canvas.Pen.Style := psSolid;
    end;

    //print  left line for marking the disregarding part of image
      //border line
    Canvas.Pen.Color := clBlue;
    Canvas.MoveTo(pbRealLineScan.Width-8-Xdelta,0);
    Canvas.LineTo(pbRealLineScan.Width-8-Xdelta,Height);
    Canvas.MoveTo(pbRealLineScan.Width-1-Xdelta,0);
    Canvas.LineTo(pbRealLineScan.Width-1-Xdelta,Height);
      //Range to disregard Image
    If (High(YtopYbotArray) >= 0) Then Begin
      Canvas.Brush.Color := clLime;
      Canvas.Pen.Color   := clLime;
      VertPageOffsetReal := round(tbImagePos.Position*YFactor + Height*YFactor);

      For Cnt := 0 to High(YtopYbotArray) do Begin
        If ((YtopYbotArray[Cnt].Ytop >= VertScrBarPosReal) and
            (YtopYbotArray[Cnt].Ytop <= VertPageOffsetReal)) Or
           ((YtopYbotArray[Cnt].Ytop <  VertScrBarPosReal) and
            (YtopYbotArray[Cnt].Ybot <= VertPageOffsetReal))
        Then Begin
          YtopR := round((YtopYbotArray[Cnt].Ytop - VertScrBarPosReal)/YFactor);
          YbotR := round((YtopYbotArray[Cnt].Ybot - VertScrBarPosReal)/YFactor) ;
          if YtopR < 0 then  YtopR := 0;
          if YbotR > Height then  YbotR := Height;
          Canvas.Rectangle(Width-7-Xdelta,YtopR,Width-1-Xdelta,YbotR);
        End;
      End;
    End;

    //print numbers
    Canvas.Brush.Style := bsClear;
    Canvas.Font.Color := $00FFAEFF;
    Canvas.Font.Size := 12;
    VetrFontOffset := Canvas.Font.Height div 2 - 2;

    Cnt := 0;
    while  (Cnt <= High(StripsYCenter))  do begin
       if (StripsYCenter[Cnt] > VertScrBarPosReal) and
          (StripsYCenter[Cnt] < Source_RS_Ysize + VertScrBarPosReal)
       then
          Canvas.TextOut(NrHorizPos,Round(StripsYCenter[Cnt]/YFactor)-VertScrBarPos+VetrFontOffset,IntToStr(Cnt+1));
      Inc(Cnt);
    end;

  End;

  If (All) Then Begin
  If (rbViewChOne.Checked) or ((rbViewAnalysed.Checked) and (rbAnalChannelOne.Checked)) then
  with lpBitmapInfo[0]^.bmiHeader do Begin
   biHeight := HeightMem;
  End { with header.bmiHeader }
    else
  If (rbViewChTwo.Checked) or ((rbViewAnalysed.Checked) and (rbAnalChannelTwo.Checked))  then
  with lpBitmapInfo[2]^.bmiHeader do Begin
    biHeight := HeightMem;
  End { with header.bmiHeader }
    else
  If (rbViewBothChannels.Checked)then
  with pMergeBMPInfo^.bmiHeader do Begin
    biHeight := HeightMem;
  End { with header.bmiHeader }
  End; //If (All) Then Begin

 End Else
 Begin
  With pbRealLineScan Do Begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color   := clBlack;
    Canvas.Rectangle(0,0,Width,Height);
  End;
 End;
End;



END.
