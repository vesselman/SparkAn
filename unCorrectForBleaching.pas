unit unCorrectForBleaching;

interface

uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.Dialogs, unGlobUnit, EditNumerical;


type
  TfrmCorrectForBleaching = class(TForm)
    btScaleFile: TButton;
    cbCorrectDuplicate: TCheckBox;
    ProgrBar: TProgressBar;
    lblMessage: TLabel;
    lblImageCnt: TLabel;
    pnScaleTo: TPanel;
    rbScaleToMinimum: TRadioButton;
    Label1: TLabel;
    pnWhatToUse: TPanel;
    Label2: TLabel;
    rbUsePlot: TRadioButton;
    rbUseFunction: TRadioButton;
    pnFunction: TPanel;
    Label3: TLabel;
    rbMultiply: TRadioButton;
    rbLinear: TRadioButton;
    rbExponential: TRadioButton;
    enMultiplyFactor: TEditNumerical;
    enApplyFunctionFromToIm: TEditNumerical;
    Label4: TLabel;
    enValueImBeg: TEditNumerical;
    enValueImEnd: TEditNumerical;
    enTau1stExp: TEditNumerical;
    enTau2ndExp: TEditNumerical;
    enPerc1stExp: TEditNumerical;
    enPerc2ndExp: TEditNumerical;
    Label7: TLabel;
    Label8: TLabel;
    pnExpOrder: TPanel;
    rb1stOrder: TRadioButton;
    rb2ndOrder: TRadioButton;
    rbScaleToMaximum: TRadioButton;
    rbScaleToImage: TRadioButton;
    rbScaleToValue: TRadioButton;
    enScaleToImNr: TEditNumerical;
    enScaleToValue: TEditNumerical;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    BevelProgBar: TBevel;
    Label10: TLabel;
    lbInfoWhenFileInRAM: TLabel;
    procedure btScaleFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure enPerc1stExpReturnPressed(Sender: TObject);
    procedure enPerc2ndExpReturnPressed(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetImageRange;
    procedure SetLabels;
  end;

var
  frmCorrectForBleaching: TfrmCorrectForBleaching;

implementation

Uses unTimeSerAnal,DigiFilters, unInputDialog, unPlayBack, Main;

{$R *.dfm}


procedure TfrmCorrectForBleaching.btScaleFileClick(Sender: TObject);
{scales (corrects0 image file for changes in brightness,e.g. bleaching}
var

  FhCor         : THandle;
  pFiltData     : Pointer;
  CntIm, CntROI, CntPix : Integer;
  ImToStart,ImToEnd : Integer;
  Slp, Offs     : Double; //Slope & Offset for Linear Fuction
  CorFileName   : AnsiString;
  im8bitBuffer  : TDynByteArray;
  im16bitBuffer : TDynWordArray;
  ScaleCoeff    : TDynDoubleArray;  //Scale Coefficients Array
  MinOrMaxVal   : Double;
  Perc1st,Perc2nd : Double;
  InitVal       : Double;
  Tau1,Tau2     : Extended;
  mrValue       : Byte;
  Proceed       : LongBool;
  DuplFname     : Boolean;


  procedure SetProgrBar(const MinLim,MaxLim,Pos : Integer);
  begin
    with ProgrBar do begin
      Min := 0;
      Max := High(Integer);
      Position := Pos;
      Min := MinLim;
      Max := MaxLim;
    end;
  end;


Begin

If (MainImLoaded) and
   (((rbUsePlot.Checked) and (TimeSerAnalDone) and not(RatioOn) and
    (PLOTvar.TraceDivMinUsed) and Not(PLOTvar.AnalType = RATIO_TIME)
    and (PLOTvar.BaseLineStatus = NO_BASELINE)) or (rbUseFunction.Checked))
Then
Begin


  Proceed := True;

  If (rbUsePlot.Checked) and (rbScaleToImage.Checked) and
    (enScaleToImNr.NumberOne-1 < frmTimeSerPlot.dsXaxes.PosFrom) or
    (enScaleToImNr.NumberOne-1 > frmTimeSerPlot.dsXaxes.PosTo) then
  Begin

    Proceed := False;
    MessageDlg('Scale To Image ' + IntToStr(enScaleToImNr.NumberOne) + ' is Out of Range.'
             ,mtError,[mbOK],0);

  End;

 If Not(FileInRAM) and (Proceed) then Begin
 //-------------- Copying File part ------------------------------------------//

 If (cbCorrectDuplicate.Checked) and (ImageFileType = MULTI_IMAGE) then Begin

  Suffix := '_BC';
  CorFileName := Copy(ImFname,1, Length(ImFname) - Length(ExtractFileExt(ImFname)));
  CorFileName := CorFileName + Suffix + ExtractFileExt(ImFname);

  //Check if File Exsist the if so change the Suffix
  DuplFname := FileExists(CorFileName);
  Proceed := not(DuplFname);
  btPressed := bEnter;

  If (DuplFname) Then While (btPressed = bEnter) and not(Proceed) do Begin
      if (frmInputDialog = nil)  then Application.CreateForm(TfrmInputDialog, frmInputDialog);
      Application.ProcessMessages;

      If (btPressed = bEnter) then Begin
        CorFileName := Copy(ImFname,1, Length(ImFname) - Length(ExtractFileExt(ImFname)));
        CorFileName := CorFileName + Suffix + ExtractFileExt(ImFname);
        DuplFname := FileExists(CorFileName);
        Proceed := not(DuplFname);
      End Else
      If (btPressed = bOverWrite) then
        Proceed := True
        else
      If (btPressed = bCancel) then
        Proceed := False;
  End; //If not(Proceed) Then While not(Proceed) do Begin

  If (Proceed) and (btPressed = bEnter) then Begin
    ProgrBar.Visible  := True;
    BevelProgBar.Visible := True;
    SetProgrBar(0,ImToEnd-ImToStart,0);
    lblMessage.Caption := 'Copying File';
    Application.ProcessMessages;

    Proceed := Boolean(CopyFileExA(pAnsiChar(ImFname),pAnsiChar(CorFileName),@CopyFileWithProgressBar,ProgrBar,pBool(False),0));
  End;

  if not(Proceed) and (btPressed <> bCancel) then begin //only if Copy did not Succeed
    BevelProgBar.Visible := False;
    ProgrBar.Visible  := False;
    MessageDlg('File Cannot be Copied',mtError,[mbOK],0);
    lblMessage.Caption := '';
  end;
  {---------- End of Copying the File ----------}
 End
  Else
 Begin

    mrValue := MessageDlg('File will be Overwritten and Impossible to Recover!', mtConfirmation, [mbCancel,mbOK], 0, mbCancel);
    if (mrValue = mrCancel) then Proceed := False else Proceed := True;

 End;

 End; // If Not(FileInRAM) and (Proceed) then Begin


 //---------------------- End of Copying File -----------------------------------//

 //------------- Choose from Plot or Function ----------------------------------//

If (Proceed) then Begin

If (rbUsePlot.Checked) then Begin //Using Plot Trace

  ImToStart := frmTimeSerPlot.dsXaxes.PosFrom; //zero based = 1st image index = 0
  ImToEnd   := frmTimeSerPlot.dsXaxes.PosTo;   //zero based

  SetLength(ScaleCoeff,ImToEnd-ImToStart+1);
  for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := 0;

  //summ the values from all the displayed traces
  For CntROI := 0 to PLOTvar.NrROI-1 Do Begin
    if (PLOTvar.AdrUsed[CntROI] > 0) then
    for CntIm := 0 to High(ScaleCoeff) do
      ScaleCoeff[CntIm] := ScaleCoeff[CntIm] + TSPlotData_BaseNotSubtr[CntROI,CntIm + (ImToStart-PLOTvar.ImBeg)] - Bkg;
  End;

  //find minimum or maximum value
  if (rbScaleToMaximum.Checked) then begin
    MinOrMaxVal := 0;
    for CntIm := 0 to High(ScaleCoeff) do begin
      if MinOrMaxVal < ScaleCoeff[CntIm] then MinOrMaxVal := ScaleCoeff[CntIm];
    end;
  end
    else
  if (rbScaleToMinimum.Checked) then begin
    MinOrMaxVal := High(LongInt);
    for CntIm := 0 to High(ScaleCoeff) do begin
      if MinOrMaxVal > ScaleCoeff[CntIm] then MinOrMaxVal := ScaleCoeff[CntIm];
    end;
  end
    else
  if (rbScaleToImage.Checked) then begin
    CntIm := (enScaleToImNr.NumberOne -1) - ImToStart;
    MinOrMaxVal := ScaleCoeff[CntIm];
  end
    else
  if (rbScaleToValue.Checked) then begin
    MinOrMaxVal := enScaleToValue.NumberFloat;
  end;

 End

  Else

 If (rbUseFunction.Checked) then Begin

  ImToStart := enApplyFunctionFromToIm.NumberOne - 1; //to be zero based = 1st image index = 0
  ImToEnd   := enApplyFunctionFromToIm.NumberTwo - 1;   //to be zero based

  SetLength(ScaleCoeff,ImToEnd-ImToStart+1);
  for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := 0;

  //-- different choises --//

  if (rbMultiply.Checked) then begin

    for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := enMultiplyFactor.NumberFloat;

  end

    else

  if (rbLinear.Checked) then begin
    Offs :=  enValueImBeg.NumberFloat - Bkg;
    Slp  := (enValueImEnd.NumberFloat - enValueImBeg.NumberFloat)/High(ScaleCoeff);
    for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := Offs + Slp*CntIm;
  end

    else

  if (rbExponential.Checked) then begin    //50*exp(-col(A)/10) + 50*exp(-col(A)/100)

    Offs    := enValueImEnd.NumberFloat - Bkg;
    InitVal := enValueImBeg.NumberFloat - Bkg;

    if (rb1stOrder.Checked) then begin
      tau1    := enTau1stExp.NumberFloat;
      Perc1st := InitVal - Offs;
      for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := Perc1st*exp(-(CntIm*MeanImTime)/tau1) + Offs;
    end else
    if (rb2ndOrder.Checked) then begin
      tau1    := enTau1stExp.NumberFloat;
      tau2    := enTau2ndExp.NumberFloat;
      Perc1st := ((InitVal-Offs)*enPerc1stExp.NumberOne)/100;
      Perc2nd := ((InitVal-Offs)*enPerc2ndExp.NumberOne)/100;
      for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := Perc1st*exp(-(CntIm*MeanImTime)/tau1) + Perc2nd*exp(-(CntIm*MeanImTime)/tau2)  + Offs;
    end;
  end; //if (rbExponential.Checked)


  If not(rbMultiply.Checked) then Begin
    if (rbScaleToMinimum.Checked) then begin
      if (ScaleCoeff[0] < ScaleCoeff[High(ScaleCoeff)]) then
        MinOrMaxVal := ScaleCoeff[0] else
        MinOrMaxVal := ScaleCoeff[High(ScaleCoeff)];
    end else
    if (rbScaleToMaximum.Checked) then begin
      if (ScaleCoeff[0] > ScaleCoeff[High(ScaleCoeff)]) then
        MinOrMaxVal := ScaleCoeff[0] else
        MinOrMaxVal := ScaleCoeff[High(ScaleCoeff)];
    end else
    if (rbScaleToImage.Checked) then begin
      CntIm := (enScaleToImNr.NumberOne -1) - ImToStart;
      MinOrMaxVal := ScaleCoeff[CntIm];
    end else
      if (rbScaleToValue.Checked) then begin
      MinOrMaxVal := enScaleToValue.NumberFloat;
    end;
  End;  //If not(rbMultiply.Checked)

 End;  //If (rbUseFunction.Checked) then Begin


 //generate coefficiens
   If not((rbMultiply.Checked) and (rbUseFunction.Checked)) then Begin
    for CntIm := 0 to High(ScaleCoeff) do ScaleCoeff[CntIm] := MinOrMaxVal/ScaleCoeff[CntIm];
   End;
  {Reads Every Image, Scales it and Writes it to the New "_COR" File}
 // ---------- From Here is the Actual -- Correction  --------------//
  //Set Progress bar
  BevelProgBar.Visible := True;
  ProgrBar.Visible := True;
  SetProgrBar(0,ImToEnd-ImToStart,0);
  lblMessage.Caption := 'Scaling File';
  Application.ProcessMessages;

  //Prepares Output Buffers//
  If (BitCount = 8) Then begin
    SetLength(im8bitBuffer,imXsize*imYsize);
  End Else
  If (BitCount = 16) Then begin
    SetLength(im16bitBuffer,imXsize*imYsize);
  End;

  If (FileInRAM) then Begin
    //since the file will be modified the 1st 5 cannot be used
    //this copies 1st 5 non filtered images for later
    //and prepares pointer for the Move procedure
    If (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then Begin
      if (BitCount = 8)  Then pFiltData := @TwoChByteArr[0]
        else
      if (BitCount = 16) Then pFiltData := @TwoChWordArr[0];
    End
      Else
    Begin
      if (BitCount = 8)  Then pFiltData := @im8bitBuffer[0]
        else
      if (BitCount = 16) Then pFiltData := @im16bitBuffer[0];
    End;
  End; //If (FileInRAM) then Begin

  //Prepares File Handles for Writing
  If not(FileInRAM) then Begin
    If (ImageFileType = MULTI_IMAGE) then begin
      if (cbCorrectDuplicate.Checked) then
        FhCor  := FileOpen(CorFileName,fmOpenWrite)
      else begin
        FileClose(ImFile);
        ImFile := FileOpen(ImFname,fmOpenReadWrite or fmShareDenyNone);
        FhCor := ImFile;
      end;
    End
      Else
    If (ImageFileType = FILE_COLLECTION) then
      SetAndPropagateFileHandles(fmOpenReadWrite);
  End; //If not(FileInRAM) then Begin

  //------------------------------- Starts Scalling ----------------------------//

  For CntIm := 0 to High(ScaleCoeff) do Begin

    ReadImage(CntIm + ImToStart,0,pImData);

    If (BitCount = 8) Then begin
      for CntPix := 0 to High(Im8bitBuffer) do begin
        Im8bitBuffer[CntPix] := Round((Im8bitData[CntPix]-Bkg)*ScaleCoeff[CntIm]) + Bkg;
      end
    End Else
    If (BitCount = 16) Then begin
      for CntPix := 0 to High(Im16bitBuffer) do begin
        Im16bitBuffer[CntPix] := Round((Im16bitData[CntPix]-Bkg)*ScaleCoeff[CntIm]) + Bkg;
      end;
    End;

    if (MovFType = NIKON_ND2_MOV) and (NrChannels = 2) then
            ReplaceCh1InND2File(im8bitBuffer,im16bitBuffer);

    If (FileInRAM) then Begin
        if (ImageFileType = MULTI_IMAGE) then
          Move(pFiltData^,RawDataInRAM[0,ImOff[0,CntIm+ImToStart]],ImageBytes)
          else
        if (ImageFileType = FILE_COLLECTION) then
          Move(pFiltData^,RawDataInRAM[CollFileNrInRAM[CntIm+ImToStart],ImOff[0,CntIm]],ImageBytes)
          else
        if (ImageFileType = SINGLE_IMAGE) then begin
          if (ToSwap) then begin
            for CntPix := 0 to High(im16bitBuffer) do
              im16bitBuffer[CntPix] := Swap(im16bitBuffer[CntPix]);
          end;
          Move(pFiltData^,RawDataInRAM[0,(CntIm+ImToStart)*SizeOfFile+StripOffs[0]],ImageBytes);
        end;
    End
    Else
      WriteImage(FhCor,CntIm + ImToStart,im8bitBuffer,im16bitBuffer);

    lblImageCnt.Caption := IntToStr(CntIm + 1 + ImToStart) + ' im';
    ProgrBar.Position := CntIm;
    Application.ProcessMessages;

  End; //For CntIm := 0 to High(PlData) do Begin

  //Reset Progress Bars and Labels
  lblImageCnt.Caption := '';
  lblMessage.Caption := '';
  BevelProgBar.Visible := False;
  ProgrBar.Visible := False;
  ProgrBar.Position := 0;
  Application.ProcessMessages;

  //------------------------------- End Scalling ----------------------------//

  //Restores File Handles to Read Only if Choise was to Overwrite Files
  If not(FileInRAM) then Begin
    If (ImageFileType = MULTI_IMAGE) then Begin
      if (cbCorrectDuplicate.Checked) then
        FileClose(FhCor)
     else begin
        FileClose(ImFile);
        ImFile := FileOpen(ImFname,fmOpenRead or fmShareDenyNone);
      end;
    End Else
    If (ImageFileType = FILE_COLLECTION) and not(FileInRAM)
      then SetAndPropagateFileHandles(fmOpenRead);
  End; //If not(FileInRAM) then Begin

  //refresh to current Image
  if not(FileInRAM) then ReadImage(CurIm,0,pImData)
    else
  if (FileInRAM) then frmPlayback.PlaybackScrollBarChange(Sender);

  if (FileInRAM) then RAM_Usage.KindOfModMovie := BLEACH_COR;

 End; //If (Proceed) then Begin

End Else //if Many of Conditions are fulfilled = Success = True

Begin
 if (MainImLoaded) then

  MessageDlg('Create up to 20 traces from ROI representing decay in fluorescence due to bleaching.' +
            'Use Area type analysis without Normalization (Off). F/Fo should be Off.'
            + 'Trace smoothing can be used.'
             ,mtInformation,[mbOK],0);
End;

End;


procedure TfrmCorrectForBleaching.enPerc1stExpReturnPressed(Sender: TObject);
begin
  enPerc2ndExp.NumberOne := 100 - enPerc1stExp.NumberOne;
end;

procedure TfrmCorrectForBleaching.enPerc2ndExpReturnPressed(Sender: TObject);
begin
  enPerc1stExp.NumberOne := 100 - enPerc2ndExp.NumberOne;
end;

procedure TfrmCorrectForBleaching.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action    := caFree;
      frmCorrectForBleaching := nil;
end;

procedure TfrmCorrectForBleaching.FormCreate(Sender: TObject);
begin

  if (MainImLoaded) then
    SetImageRange
      else
    enApplyFunctionFromToIm.SetNumbersOneTwo(1,2); //for all functions

  enMultiplyFactor.NumberFloat := 1.0;
  enValueImBeg.NumberFloat := 1.0; //Value at First Image - for Linear & Exponential
  enValueImEnd.NumberFloat := 1.0; //Value at Last Image  - for Linear & Exponential
  enTau1stExp.NumberFloat  := 10.0;  //tau1 sec
  enTau2ndExp.NumberFloat  := 100.0; //tau2 sec
  enPerc1stExp.NumberOne   := 50; //% contribution
  enPerc2ndExp.NumberOne   := 50; //% contribution

  enScaleToImNr.NumberOne     := 1;  //Selects Image Number to Scale To
  enScaleToValue.NumberFloat  := 100.0; //Selects Value to Scale To

  SetLabels;
end;

procedure TfrmCorrectForBleaching.SetImageRange;
begin
  enApplyFunctionFromToIm.SetNumbersOneTwo(1,NrIm);
  enApplyFunctionFromToIm.Max := NrIm;
end;

procedure TfrmCorrectForBleaching.SetLabels;
begin
  cbCorrectDuplicate.Visible := not(FileInRAM);
  lbInfoWhenFileInRAM.Visible := FileInRAM
end;

End.
