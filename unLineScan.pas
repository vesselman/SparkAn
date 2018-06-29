unit unLineScan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Math,System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, unGlobUnit;

type TMesLineUsed = Record  {stores Measure Line Parameters (Xbeg,Ybeg,Xend,Yend)}
      LineBeg     : TPoint; //TImage Coordinates  non scalled
      LineEnd     : TPoint; //TImage Coordinates  non scalled
     end;

type
  TfrmLineScan = class(TForm)
    imLineScan: TImage;
    imLSplot: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imLineScanMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imLineScanMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imLineScanMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    XmousMem,YmousMem : Integer;
    HintRect      : TRect; //sets HintWnd size
    HintWnd       : THintWindow; // used to display coordinates & value of the line scan
    LSROIdone     : Integer; //stores the last used LSROI
    LSplotHeight  : Integer;
    LSarrRAW      : TDynWordArray;  //Array Containig the RAW data of 1st Channel Image of Line Scan
    LSarrRAW2nd   : TDynWordArray;  //Array Containig the RAW data of 2nd Channel Image of Line Scan
    LSarrW2nd     : TDynWordArray;  //Array Containig the Working data of 2nd channel Image of Line Scan
    LSDisplArr2nd : TDynByteArray;
    LSarrD        : TDynDoubleArray; //Array Containig the Ratio data of Image of Line Scan
    LSplotData    : TDynDoubleArray;
    LSplotTrace   : array of TPoint;


  public
    { Public declarations }
    LStraceExist : Boolean;
    Xline,Yline  : Integer; //last position of Cursor on LS image window
    ScanWidth    : Integer;
    ScanHeight   : Integer;
    LSImBeg      : LongInt; //Beg image
    LSImEnd      : LongInt; //End image
    LineArr      : TDynLongWordArray; // Contains the Coordinates for the Line used for Scan
    LSpadding    : Byte;
    LSdisplArr   : TDynByteArray;  //Array that Displays Image of Line Scan
    LSdisplMerge : TDynByteArray; // used for Displaying  Merge Image
    LSarrW       : TDynWordArray;  //Array Containig the Working data of 1st channel Image of Line Scan
    MesLineUsed : TMesLineUsed;
    Procedure Copy8bitToDisplArr;
    Procedure Copy16bitToDisplArr;
    Procedure CopyRatToDisplArr;
    Procedure DoLineScan;
    Procedure DisplayLS;
    Procedure DoLSratio; //Smooths and Does the Ratio
    Procedure DoChannel_LSratio; //Smooths and Does the Ch/Ch Ratio
    Procedure DrawLSTraceAndLines(Const X,Y : Integer);
    Procedure ExtractLStrace(Const Ycoor : Integer);
    Procedure GetDataAsStr(Const ImPos,Y : Integer; Var ValStr : AnsiString);
    Procedure SetTimeBar;
    Procedure SmoothLineScanRatio;
    Procedure DoSmoothLineScanNonRatio;
    Procedure TransferLSTraceToTimeSerAnalPlot(Sender : TObject);
    Procedure UpdateLSwindows(Const ActionCode : Byte); //updates LS image in responce to External Inputs (commands)
  end;

var
  frmLineScan: TfrmLineScan;

implementation

Uses  Main,unPlayBack, unImageControl, unPeaks, unTimeSerAnal, unSlaveTSPlot,
  un3DImageContr, un3DImageWin,DigiFilters, un2ndWin;

{$R *.dfm}


Procedure TfrmLineScan.SetTimeBar;
   {initializes Time Bar}
Begin


  //Bottom Right = Anchor Point

  {prevents the Bar of Comming out of the Image}
  if (LSTimeBarPar.Xright + Round(LSTimeBarPar.Duration/MeanImTime) + 3 >= ScanWidth)  then
    LSTimeBarPar.Xright  := ScanWidth - Round(LSTimeBarPar.Duration/MeanImTime) - 3;

  if (LSTimeBarPar.Ybottom + LSTimeBarPar.Thickness + 3 >= ScanHeight) then
      LSTimeBarPar.Ybottom := ScanHeight - LSTimeBarPar.Thickness - 3;
  {prevents at extreme situations: very short Image or very narrow image}

  if (LSTimeBarPar.Xright < 3)  then LSTimeBarPar.Xright  := 3;
  if (LSTimeBarPar.Ybottom < 3) then LSTimeBarPar.Ybottom := 3;

  
  LSTimeBar.XR := ScanWidth  - LSTimeBarPar.Xright;
  LSTimeBar.YB := ScanHeight - LSTimeBarPar.Ybottom;
  LSTimeBar.XL := LSTimeBar.XR - Round(LSTimeBarPar.Duration/MeanImTime);
  LSTimeBar.YT := LSTimeBar.YB - LSTimeBarPar.Thickness;

End;

Procedure TfrmLineScan.DisplayLS;
var ClrTblNr : Integer;
    pD : Pointer;
Begin

   if not(RatioOn) and not(ChannelsRatioOn) then begin
    if (ChannelOrder = ASCENDING)   or (NrChannels = 1) then ClrTblNr := 0
      else
    if (ChannelOrder = DESCENDING) and (NrChannels = 2) then ClrTblNr := 2;
   end
    else
   if (RatioOn) or (ChannelsRatioOn) then ClrTblNr := 1;

   with frmLineScan.imLineScan do begin
   if not(frmImageControl.cbDoLineScanOfMergeImage.Checked) or (RatioOn) or (ChannelsRatioOn)
   then begin
  {ASCENDING  = 0;
  DESCENDING = 1;    }
    //do not use InitBitmapHeaderXY since the procedure takes the current Color Table
    lpBitmapInfo[ClrTblNr].bmiHeader.biWidth  :=  ScanWidth;
    lpBitmapInfo[ClrTblNr].bmiHeader.biHeight := -ScanHeight;
    pD := @LSdisplArr[0];
    StretchDIBits(Canvas.Handle,0,0,ScanWidth, ScanHeight, 0, 0,
                  ScanWidth, ScanHeight,pD,lpBitmapInfo[ClrTblNr]^, DIB_RGB_COLORS, SRCCOPY);
    lpBitmapInfo[ClrTblNr].bmiHeader.biWidth  :=  imXsize;
    lpBitmapInfo[ClrTblNr].bmiHeader.biHeight := -imYsize;
   end

    else

   if (NrChannels = 2) and (frmImageControl.cbDoLineScanOfMergeImage.Checked) and
       not(RatioOn) or not(ChannelsRatioOn)
   then begin
    pMergeBMPInfo.bmiHeader.biWidth  :=  ScanWidth;
    pMergeBMPInfo.bmiHeader.biHeight := -ScanHeight;
    pD := @LSdisplMerge[0];
    StretchDIBits(Canvas.Handle,0,0,ScanWidth, ScanHeight, 0, 0,
                  ScanWidth, ScanHeight,pD,pMergeBMPInfo^, DIB_RGB_COLORS, SRCCOPY);
    pMergeBMPInfo.bmiHeader.biWidth  :=  imXsize;
    pMergeBMPInfo.bmiHeader.biHeight := -imYsize;
   end;

   Repaint;
   end;//with

End;


Procedure TfrmLineScan.Copy8bitToDisplArr;
//with one call this procedure Copies Ch1 and Ch2 to their respective Display Arrays
var Cnt,J,ImLen : Integer;
Begin

  If (LSpadding = 0) then Begin
    //always does the 1st channel
      for Cnt := 0 to High(LSarrW) do LSdisplArr[Cnt] := LSarrW[Cnt];

    if (NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked)
    then
      for Cnt := 0 to High(LSarrW2nd) do LSDisplArr2nd[Cnt] := LSarrW2nd[Cnt];
  End

    Else

  Begin
    //always does the 1st channel
    Cnt := 0;
    J   := 0;
    ImLen := ScanWidth - 1;
    While Cnt < High(LSdisplArr) do begin
      LSdisplArr[J] := LSarrW[Cnt];
      if (Cnt Mod ScanWidth <> ImLen) then Inc(J,1) else Inc(J,LSpadding);
      Inc(Cnt);
    End; //while

    If (NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked) then
    Begin
      Cnt := 0;
      J   := 0;
      ImLen := ScanWidth - 1;
      While Cnt < High(LSdisplArr2nd) do begin
        LSdisplArr2nd[J] := LSarrW2nd[Cnt];
        if (Cnt Mod ScanWidth <> ImLen) then Inc(J,1) else Inc(J,LSpadding);
        Inc(Cnt);
      End; //while
    End; //If (NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked)
  End; //else begin
End; //Procedure TfrmLineScan.Copy8bitToDisplArr;


Procedure TfrmLineScan.Copy16bitToDisplArr;
var
    ScaleFactor    : Double;
    Cnt,PixVal     : Integer;
    PixMin,imLen,J : Integer;
    FullRange      : Boolean;
    Ch1DispArr,Ch2DispArr : TDynByteArray;
    Ch1RawArr,Ch2RawArr   : TDynWordArray;

Begin


     if (ChannelOrder = ASCENDING) then begin
      Ch1DispArr := LSdisplArr;
      Ch1RawArr  := LSarrW;
      Ch2DispArr := LSdisplArr2nd;
      Ch2RawArr  := LSarrW2nd;
     end
       else
     if (ChannelOrder = DESCENDING) then begin
      Ch1DispArr := LSdisplArr2nd;
      Ch1RawArr  := LSarrW2nd;
      Ch2DispArr := LSdisplArr;
      Ch2RawArr  := LSarrW;
     end;

If (LSpadding = 0) then Begin

    //always does the 1st channel
  if (PixRange[0].DSPixRange_PosFrom <> 0) or (PixRange[0].DSPixRange_PosTo <> MaxPixVal) then
  begin
    FullRange := False;
    PixMin := PixRange[0].DSPixRange_PosFrom;
    ScaleFactor := (PixRange[0].DSPixRange_PosTo - PixMin) / 255;
  end
    else
  begin
    FullRange := True;
  end;

    If Not(FullRange) then Begin
      {  Another way published is
      ScaledPixData[Cnt] := ((PixData[Cnt] - PixMin)/(PixMax-PixMin)) * 253 + 1;
        this gives for 0 always 1; and for max always 244
    }
      for Cnt := 0 to High(LSarrW) do begin
        if Ch1RawArr[Cnt] > PixMin then
          PixVal := round((Ch1RawArr[Cnt] - PixMin)/ScaleFactor)
        else PixVal := 0;
        if PixVal > 255 then PixVal := 255;
         Ch1DispArr[Cnt] := PixVal;
      end; //for Cnt := 0 to High(Im16bitData)
    End // If (NotFullRange) then Begin
        else
    for Cnt := 0 to High(LSarrW) do Ch1DispArr[Cnt] := Ch1RawArr[Cnt] shr shrFact;

    If (NrChannels = 2) And ((ChannelOrder = DESCENDING) or (frmImageControl.cbDoLineScanOfMergeImage.Checked)) then
    Begin
      if (PixRange[1].DSPixRange_PosFrom <> 0) or (PixRange[1].DSPixRange_PosTo <> MaxPixVal) then
      begin
        FullRange := False;
        PixMin := PixRange[1].DSPixRange_PosFrom;
        ScaleFactor := (PixRange[1].DSPixRange_PosTo - PixMin) / 255;
      end
        else
      begin
        FullRange := True;
      end;

      If Not(FullRange) then Begin
        for Cnt := 0 to High(LSarrW2nd) do begin
          if Ch2RawArr[Cnt] > PixMin then
            PixVal := round((Ch2RawArr[Cnt] - PixMin)/ScaleFactor)
          else PixVal := 0;
          if PixVal > 255 then PixVal := 255;
          Ch2DispArr[Cnt] := PixVal;
        end; //for Cnt := 0 to High(Im16bitData)
      End
        else
      for Cnt := 0 to High(LSarrW2nd) do Ch2DispArr[Cnt] := Ch2RawArr[Cnt] shr shrFact;
    End; //If (NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked)
 End  //If (LSpadding = 0) then Begin

  Else
  //-------------- if Padding is required -----------------
 If (LSpadding <> 0) then Begin
  Cnt := 0;
  J   := 0;
  imLen := ScanWidth - 1;

    //always does the 1st channel
    if (PixRange[0].DSPixRange_PosFrom <> 0) or (PixRange[0].DSPixRange_PosTo <> MaxPixVal) then
    begin
      FullRange := False;
      PixMin := PixRange[0].DSPixRange_PosFrom;
      ScaleFactor := (PixRange[0].DSPixRange_PosTo - PixMin) / 255;
    end
      else
    begin
      FullRange := True;
    end;

  If Not(FullRange) then Begin
    While Cnt < High(LSarrW) do begin
      if Ch1RawArr[Cnt] > PixMin then
        PixVal := round((Ch1RawArr[Cnt] - PixMin)/ScaleFactor)
      else PixVal := 0;
      if PixVal > 255 then PixVal := 255;
      Ch1DispArr[J]:= PixVal;
      if (Cnt Mod ScanWidth <> imLen) then Inc(J,1) else Inc(J,LSpadding);
      Inc(Cnt);
    End; //While
  End
    else
  Begin
    While Cnt < High(LSarrW) do begin
      Ch1DispArr[J] := Ch1RawArr[Cnt] shr shrFact;
      if Cnt Mod ScanWidth <> imLen then Inc(j,1) else Inc(J,LSpadding);
      Inc(Cnt);
    End; //While
  End;

   //2nd channel
  If (NrChannels = 2) And ((ChannelOrder = DESCENDING) or (frmImageControl.cbDoLineScanOfMergeImage.Checked)) then
  Begin

    Cnt := 0;
    J   := 0;
    imLen := ScanWidth - 1;

    if (PixRange[1].DSPixRange_PosFrom <> 0) or (PixRange[1].DSPixRange_PosTo <> MaxPixVal) then
    begin
        FullRange := False;
        PixMin := PixRange[1].DSPixRange_PosFrom;
        ScaleFactor := (PixRange[1].DSPixRange_PosTo - PixMin) / 255;
    end
        else
    begin
        FullRange := True;
    end;

    If Not(FullRange) then begin
      While Cnt < High(LSarrW2nd) do begin
        if Ch2RawArr[Cnt] > PixMin then
          PixVal := round((Ch2RawArr[Cnt] - PixMin)/ScaleFactor)
        else PixVal := 0;
        if PixVal > 255 then PixVal := 255;
        Ch2DispArr[J]:= PixVal;
        if (Cnt Mod ScanWidth <> imLen) then Inc(J,1) else Inc(J,LSpadding);
        Inc(Cnt);
      End; //While
    End
      else
    Begin
      While Cnt < High(LSarrW2nd) do begin
        Ch2DispArr[J] := Ch2RawArr[Cnt] shr shrFact;
        if Cnt Mod ScanWidth <> imLen then Inc(j,1) else Inc(J,LSpadding);
        Inc(Cnt);
      End; //While
    End; //FullRange)
  End; //If (NrChannels > 1) and (frmImageControl.cbDoLineScanOfMergeImage.Checked)
 End; //If (BMPPadding <> 0)

End;  //Procedure TfrmLineScan.Copy16bitToDisplArr;

Procedure TfrmLineScan.CopyRatToDisplArr;

var Cnt,imLen,J   : Integer;
    S             : Double;

Begin

If (LSpadding = 0) then For Cnt := 0 to High(LSarrD) do Begin
  S := LSarrD[Cnt]*DispFact;
  if S < 255 then LSdisplArr[Cnt] := round(S)
             else LSdisplArr[Cnt] := 255;
End Else

If (LSpadding <> 0) then Begin
  Cnt := 0;
  J   := 0;
  imLen := ScanWidth - 1;
  While Cnt < High(LSarrD) do begin
    S := LSarrD[Cnt]*DispFact;
    if S < 255 then LSdisplArr[j] := round(S)
    else LSdisplArr[j] := 255;
    if Cnt Mod ScanWidth <> imLen then Inc(j,1) else Inc(j,LSpadding);
    Inc(Cnt);
  End; {while}
End; {If BMPPadding <> 0}

End;

Procedure TfrmLineScan.UpdateLSwindows (Const ActionCode : Byte);
//updates LS image in responce to External Inputs (commands)
var Cnt : Integer;
Begin

 If (ActionCode = REDO_RATIO) then DoLSratio //does ratio and smooths
  else
 If (ActionCode = REDO_ChdivCh_RATIO) then DoChannel_LSratio;

 If (ActionCode >= RELOAD_DISPL) Then Begin
  If Not(RatioOn) and Not(ChannelsRatioOn) then Begin
    if (Length(LSarrW) <> Length(LSarrRAW)) then SetLength(LSarrW,Length(LSarrRAW));
    for Cnt := 0 to High(LSarrRAW) do LSarrW[Cnt] := LSarrRAW[Cnt];
    if (NrChannels = 2) then begin
      if (Length(LSarrW2nd) <> Length(LSarrW)) then SetLength(LSarrW2nd,Length(LSarrW));
      for Cnt := 0 to High(LSarrRAW2nd) do LSarrW2nd[Cnt] := LSarrRAW2nd[Cnt];
    end;
    if (SmoothMode > NO_SMOOTH) and (SmoothNonRatio > NO_SMOOTH_NON_RATIO)
    then DoSmoothLineScanNonRatio;

    if (BitCount = 16) then Copy16bitToDisplArr else
    if (BitCount = 8)  then Copy8bitToDisplArr;

    if (NrChannels = 2) and (frmImageControl.cbDoLineScanOfMergeImage.Checked) then begin
      if (ChannelOrder = ASCENDING) then
      MergeImagesTo32bit(LSdisplArr,LSDisplArr2nd,LSdisplMerge,ScanWidth,ScanHeight) else
      if (ChannelOrder = DESCENDING) then
      MergeImagesTo32bit(LSDisplArr2nd,LSdisplArr,LSdisplMerge,ScanWidth,ScanHeight)
    end;

  End  //If Not(RatioOn) and Not(ChannelsRatioOn) then Begin

    else

  If (RatioOn) or (ChannelsRatioOn) then CopyRatToDisplArr;  //ratio is smoothed in DoLSratio
 End;  //If (ActionCode >= RELOAD_DISPL) Then Begin

If (ActionCode >= REFRESH_ONLY) then Begin

  DisplayLS;

  if (LStraceExist) then DrawLSTraceAndLines(Xline,Yline) else
  with frmLineScan.imLSplot do begin
    Canvas.Brush.Color := clBlack;
    Canvas.FillRect(Canvas.ClipRect);
  end;

  if (LSTimeBarPar.Visible) then DrawScaleBar(1,LSTimeBar,imLineScan.Canvas);

End;

If (ActionCode = ERASE_SCREEN) then Begin
  with frmLineScan.imLSplot do begin
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(Canvas.ClipRect);
  end;
  with frmLineScan.imLineScan do begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := clBlack;
  Canvas.FillRect(Canvas.ClipRect);
  end;

  LineScanExist := False;
  LStraceExist  := False;
End;

  
End; //Procedure TfrmLineScan.UpdateLineScan

{****************************************************************************}

Procedure TfrmLineScan.DoLSratio;
var CntX,CntY  : integer;
    AvImScanLine    : TDynDoubleArray;
Begin

{1st; Creates a Average Image Scan Line always from the Raw Average Image}

SetLength(AvImScanLine,ScanHeight);
for CntY := 0 to High(LineArr) do begin
     AvImScanLine[CntY] := AvImRaw[LineArr[CntY]] - Bkg;
  if AvImScanLine[CntY] < 1       then AvImScanLine[CntY] := 0;
  if AvImScanLine[CntY] <= CutOff then AvImScanLine[CntY] := 0;
     {it is not Worth do use Values below 1
     any noise would produce F/F0 = 1 or more}
end;

{2nd: Does the ratio}

if (Length(LSarrD) <> ScanWidth*ScanHeight) then SetLength(LSarrD,ScanWidth*Length(LineArr));

For CntX := 0 to ScanWidth-1 Do Begin
  For CntY := 0 to High(AvImScanLine) do Begin
    if (AvImScanLine[CntY] > 0)  then begin
      LSarrD[CntX + ScanWidth*CntY] := (LSarrRAW[CntX + ScanWidth*CntY]-Bkg)/AvImScanLine[CntY];
      if (LSarrD[CntX + ScanWidth*CntY] < 0) then LSarrD[CntX + ScanWidth*CntY] := 0;
    end
    else LSarrD[CntX + ScanWidth*CntY] := 0;
  End;
End;

{3rd: Smooths ratio}
if (SmoothMode > NO_SMOOTH) then SmoothLineScanRatio;

End;  //Procedure TfrmLineScan.DoLSratio;
{*******************************************************************}
Procedure TfrmLineScan.DoChannel_LSratio;
var CntX,CntY  : integer;
Begin

if (Length(LSarrD) <> ScanWidth*ScanHeight) then SetLength(LSarrD,ScanWidth*Length(LineArr));

For CntX := 0 to ScanWidth-1 Do Begin
  For CntY := 0 to ScanHeight-1 do Begin
    if (LSarrRAW2nd [CntX + ScanWidth*CntY] > Bkg2nd)  then begin
      LSarrD[CntX + ScanWidth*CntY] := (LSarrRAW[CntX + ScanWidth*CntY]-Bkg)/(LSarrRAW2nd[CntX + ScanWidth*CntY]-Bkg2nd);
      if (LSarrD[CntX + ScanWidth*CntY] < 0) then LSarrD[CntX + ScanWidth*CntY] := 0;
    end
    else LSarrD[CntX + ScanWidth*CntY] := 0;
  End;
End;

 {3rd: Smooths ratio}
  if (SmoothMode > NO_SMOOTH) then SmoothLineScanRatio;

End; //Procedure DoChannel_LSratio;

{*******************************************************************}

Procedure TfrmLineScan.SmoothLineScanRatio;
var  DarrOne,DarrTwo : TDynDoubleArray;
     Cnt : Integer;
begin

  if (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
    SetLength(DarrOne,Length(LSarrRAW));
    SetLength(DarrTwo,Length(LSarrRAW));
    if (SmoothMode = SMOOTH_BOX_MED) then begin
    BoxCarFilt(LSarrD, DarrTwo,ScanWidth,ScanHeight,BoxSmSize,True);
    MedianFilt(DarrTwo,DarrOne,ScanWidth,ScanHeight,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_BOX) then begin
    MedianFilt(LSarrD, DarrTwo,ScanWidth,ScanHeight,MedSmSize,True);
    BoxCarFilt(DarrTwo,DarrOne,ScanWidth,ScanHeight,BoxSmSize,True);
    end else
     if (SmoothMode = SMOOTH_GAUSS_MED) then begin
    Gauss2DFilt(LSarrD, DarrTwo,ScanWidth,ScanHeight,GaussSmSize,True);
    MedianFilt(DarrTwo,DarrOne,ScanWidth,ScanHeight,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_GAUSS) then begin
    MedianFilt(LSarrD, DarrTwo,ScanWidth,ScanHeight,MedSmSize,True);
    Gauss2DFilt(DarrTwo,DarrOne,ScanWidth,ScanHeight,GaussSmSize,True);
    end;
  end else
  if (SmoothMode = SMOOTH_BOX) then begin
    SetLength(DarrOne,Length(LSarrRAW));
    BoxCarFilt(LSarrD,DarrOne,ScanWidth,ScanHeight,BoxSmSize,True)
  end else
  if (SmoothMode = SMOOTH_MED) then begin
    SetLength(DarrOne,Length(LSarrRAW));
    MedianFilt(LSarrD,DarrOne,ScanWidth,ScanHeight,MedSmSize,True);
  end else
  if (SmoothMode = SMOOTH_GAUSS) then begin
    SetLength(DarrOne,Length(LSarrRAW));
    Gauss2DFilt(LSarrD,DarrOne,ScanWidth,ScanHeight,GaussSmSize,True);
  end;

  for Cnt := 0 to High(LSarrD) do LSarrD[Cnt] := DarrOne[Cnt];

End; //Procedure SmoothRatio;

{****************************************************************************}

Procedure TfrmLineScan.DoSmoothLineScanNonRatio;
var  WarrOne,WarrTwo : TDynWordArray;
     Cnt : Integer;
begin

If ((SmoothNonRatio in [SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (ChannelOrder = ASCENDING)) Or
   ((SmoothNonRatio in [SMOOTH_Ch_TWO,SMOOTH_Ch_BOTH]) and (ChannelOrder = DESCENDING) and (NrChannels = 2))
then Begin

  if (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
    SetLength(WarrOne,Length(LSarrRAW));
    SetLength(WarrTwo,Length(LSarrRAW));
    if (SmoothMode = SMOOTH_BOX_MED) then begin
    BoxCarFilt(LSarrW, WarrTwo,ScanWidth,ScanHeight,BoxSmSize,True);
    MedianFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_BOX) then begin
    MedianFilt(LSarrW, WarrTwo,ScanWidth,ScanHeight,MedSmSize,True);
    BoxCarFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,BoxSmSize,True);
    end else
    if (SmoothMode = SMOOTH_GAUSS_MED) then begin
    Gauss2DFilt(LSarrW, WarrTwo,ScanWidth,ScanHeight,GaussSmSize,True);
    MedianFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_GAUSS) then begin
    MedianFilt(LSarrW, WarrTwo,ScanWidth,ScanHeight,MedSmSize,True);
    Gauss2DFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,GaussSmSize,True);
    end;
  end else
  if (SmoothMode = SMOOTH_BOX) then begin
    SetLength(WarrOne,Length(LSarrRAW));
    BoxCarFilt(LSarrW,WarrOne,ScanWidth,ScanHeight,BoxSmSize,True)
  end else
  if (SmoothMode = SMOOTH_MED) then begin
    SetLength(WarrOne,Length(LSarrRAW));
    MedianFilt(LSarrW,WarrOne,ScanWidth,ScanHeight,MedSmSize,True);
  end else
  if (SmoothMode = SMOOTH_GAUSS) then begin
    SetLength(WarrOne,Length(LSarrRAW));
    Gauss2DFilt(LSarrW,WarrOne,ScanWidth,ScanHeight,GaussSmSize,True);
  end;

  for Cnt := 0 to High(LSarrW) do LSarrW[Cnt] := WarrOne[Cnt];

End;


If (NrChannels = 2) Then Begin
 If ((SmoothNonRatio in [SMOOTH_Ch_TWO,SMOOTH_Ch_BOTH]) and (ChannelOrder = ASCENDING)) Or
    ((SmoothNonRatio in [SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (ChannelOrder = DESCENDING))
 Then Begin
 if (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX,SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then begin
    SetLength(WarrOne,Length(LSarrRAW2nd));
    SetLength(WarrTwo,Length(LSarrRAW2nd));
    if (SmoothMode = SMOOTH_BOX_MED) then begin
    BoxCarFilt(LSarrW2nd, WarrTwo,ScanWidth,ScanHeight,BoxSmSize,True);
    MedianFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_BOX) then begin
    MedianFilt(LSarrW2nd, WarrTwo,ScanWidth,ScanHeight,MedSmSize,True);
    BoxCarFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,BoxSmSize,True);
    end else
    if (SmoothMode = SMOOTH_GAUSS_MED) then begin
    Gauss2DFilt(LSarrW2nd, WarrTwo,ScanWidth,ScanHeight,GaussSmSize,True);
    MedianFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,MedSmSize,True);
    end else
    if (SmoothMode = SMOOTH_MED_GAUSS) then begin
    MedianFilt(LSarrW2nd, WarrTwo,ScanWidth,ScanHeight,MedSmSize,True);
    Gauss2DFilt(WarrTwo,WarrOne,ScanWidth,ScanHeight,GaussSmSize,True);
    end;
  end else
  if (SmoothMode = SMOOTH_BOX) then begin
    SetLength(WarrOne,Length(LSarrRAW2nd));
    BoxCarFilt(LSarrW2nd,WarrOne,ScanWidth,ScanHeight,BoxSmSize,True)
  end else
  if (SmoothMode = SMOOTH_MED) then begin
    SetLength(WarrOne,Length(LSarrRAW2nd));
    MedianFilt(LSarrW2nd,WarrOne,ScanWidth,ScanHeight,MedSmSize,True);
  end else
  if (SmoothMode = SMOOTH_GAUSS) then begin
    SetLength(WarrOne,Length(LSarrRAW2nd));
    Gauss2DFilt(LSarrW2nd,WarrOne,ScanWidth,ScanHeight,GaussSmSize,True);
  end;

  for Cnt := 0 to High(LSarrW2nd) do LSarrW2nd[Cnt] := WarrOne[Cnt];

 End;
End; //If (NrChannels = 2) Then Begin

End; //Procedure SmoothRatio;   


Procedure TfrmLineScan.DoLineScan; //construct fake line scan
var
    X,Y,Pad32bit   : Integer;
    DisplArrLen    : Integer;
    Xd,Yd          : Double;


    procedure GetLineScan;
    var CntIm,Cnt  : integer;
        p8bitArr  : TDynByteArray;
        p16bitArr : TDynWordArray;
    begin

      If (BitCount = 8) Then
      For CntIm := LSImBeg to LSImEnd do Begin

        ReadImage(CntIm,0,pImData);
        If (NrChannels = 2) and Not(MovFType = NIKON_ND2_MOV) then Begin
          if not(MovFType = BIORAD_PIC) then ReadImage(CntIm,1,p2ndImData)
            else
          if (MovFType = BIORAD_PIC) then begin
            ImFile := CollFileHandles[1];
            ReadImage(CntIm,0,p2ndImData);
            ImFile := CollFileHandles[0];
          end;
        End;

        frmLineScan.Caption := 'Progress: ' + IntToStr((CntIm-LSImBeg)*100 div (LSImEnd-LSImBeg)) + '%';
        Application.ProcessMessages;

        p8bitArr := Im8bitData;
        for Cnt := 0 to High(LineArr) do begin
          LSarrRAW[(CntIm-LSImBeg) + ScanWidth*Cnt] := p8bitArr[LineArr[Cnt]];
        end;
        if (NrChannels = 2) then begin //always read
          p8bitArr := Im2nd8bit;
          for Cnt := 0 to High(LineArr) do begin
            LSarrRAW2nd[(CntIm-LSImBeg) + ScanWidth*Cnt] := p8bitArr[LineArr[Cnt]];
          end;
        end;
      End

        Else

      If (BitCount = 16) Then
      For CntIm := LSImBeg to LSImEnd do Begin

        ReadImage(CntIm,0,pImData);
        If (NrChannels = 2) and Not(MovFType = NIKON_ND2_MOV) then Begin
          if not(MovFType = BIORAD_PIC) then ReadImage(CntIm,1,p2ndImData)
            else
          if (MovFType = BIORAD_PIC) then begin
            ImFile := CollFileHandles[1];
            ReadImage(CntIm,0,p2ndImData);
            ImFile := CollFileHandles[0];
          end;
        End;

        frmLineScan.Caption := 'Progress: ' + IntToStr((CntIm-LSImBeg)*100 div (LSImEnd-LSImBeg)) + '%';
        Application.ProcessMessages;

        p16bitArr := Im16bitData;
        for Cnt := 0 to High(LineArr) do begin
          LSarrRAW[(CntIm-LSImBeg) + ScanWidth*Cnt] := p16bitArr[LineArr[Cnt]];
        end;
        if (NrChannels = 2) then begin
          p16bitArr := Im2nd16bit;
          for Cnt := 0 to High(LineArr) do begin
            LSarrRAW2nd[(CntIm-LSImBeg) + ScanWidth*Cnt] := p16bitArr[LineArr[Cnt]];
          end;
        end;
      End; // If (BitCount = 16) Then
   End; //procedure GetLineScan;

Begin

  //Store the Mes Line Used Beg and End coordinates - Used by WriteLogFile

    MesLineUsed.LineBeg := MesLine.LineBeg;
    MesLineUsed.LineEnd := MesLine.LineEnd;

  {1st Creates an array of Pixel Coordinates Closest to the Line
   using Line Equation: Y := Slope*X + B; }
    
    {Y := Slope*X + B;  -> Y = Round(Y) - Round(Y) = Floor(0.5+Y);
     Simplified: Y(i+1) = slope*X(i+1) + B = Slope(Xi + DeltaX) + B = Yi + Slope*DeltaX;
     if DeltaX = 1 (as it is)
     then Y(i+1) = Yi + Slope;  where Yi is the first Y (Ybeg)
     Slope must be between 0 and 1; if not we must reverse the roles of X and Y
     by assigning a unit step to Y and inctementing X by DeltaX =  DeltaY/Slope = 1/Slope}

    //any Y = [CntX + imXsize*CntY]

  If (MesLine.Orientation = MORE_HORIZONTAL) then Begin
    SetLength(LineArr,MesLine.LineEnd.X-MesLine.LineBeg.X + 1);
    LineArr[0] := MesLine.LineBeg.X + imXsize*MesLine.LineBeg.Y;
    LineArr[High(LineArr)] := MesLine.LineEnd.X + imXsize*MesLine.LineEnd.Y;
    Yd := MesLine.LineBeg.Y;
    if (MesLine.LineBeg.Y > MesLine.LineEnd.Y) then
      for X := MesLine.LineBeg.X+1 to MesLine.LineEnd.X-1 do begin
        Yd := Yd + MesLine.Slope;
        LineArr[High(LineArr)- (X-MesLine.LineBeg.X)] := X + imXsize*Round(Yd);
      end else
      if (MesLine.LineBeg.Y <= MesLine.LineEnd.Y) then
      for X := MesLine.LineBeg.X+1 to MesLine.LineEnd.X-1 do begin
        Yd := Yd + MesLine.Slope;
        LineArr[X-MesLine.LineBeg.X] := X + imXsize*Round(Yd);
      end;
  End Else
  If (MesLine.Orientation = MORE_VERTICAL) then Begin
    SetLength(LineArr,MesLine.LineEnd.Y-MesLine.LineBeg.Y+1);
    LineArr[0] := MesLine.LineBeg.X + imXsize*MesLine.LineBeg.Y;
    LineArr[High(LineArr)] := MesLine.LineEnd.X + imXsize*MesLine.LineEnd.Y;
    Xd := MesLine.LineBeg.X;
    for Y := MesLine.LineBeg.Y+1 to MesLine.LineEnd.Y-1 do begin
      Xd := Xd + MesLine.Slope;
      LineArr[Y-MesLine.LineBeg.Y] := Round(Xd) + imXsize*Y;
    end;
  End;

  ScanHeight := Length(LineArr);

   {2nd; Does Line Scan}

  LSImBeg := frmTimeSerPlot.enAnalFromTo.NumberOne - 1;
  LSImEnd := frmTimeSerPlot.enAnalFromTo.NumberTwo - 1;

  ScanWidth := LSImEnd - LSImBeg + 1;
   //calculates Padding for Imaging and Display Buffer Size
  if (ScanWidth mod 4 = 0) then LSpadding := 0 else
                                LSpadding := 4 - (ScanWidth Mod 4);

  DisplArrLen := (ScanWidth + LSpadding)*ScanHeight;
  if (LSpadding <> 0) then LSpadding  := LSpadding + 1;
  if (Length(LSdisplArr) <> DisplArrLen) then SetLength(LSdisplArr,DisplArrLen);
  if (Length(LSarrRAW) <> ScanWidth*ScanHeight) then SetLength(LSarrRAW,ScanWidth*ScanHeight);
  if (NrChannels > 1) then begin  //always innitialize iven if LS from merge image is not chosen
    if (Length(LSarrRAW2nd)   <> Length(LSarrRAW))   then SetLength(LSarrRAW2nd,Length(LSarrRAW));
    if (Length(LSDisplArr2nd) <> Length(LSdisplArr)) then SetLength(LSDisplArr2nd,Length(LSdisplArr));
    if (ScanWidth mod 4 = 0) then Pad32bit := 0 else
                                  Pad32bit := 4 - (ScanWidth*4 Mod 4);
    if (Length(LSdisplMerge)  <> (ScanWidth*4 + Pad32bit)*ScanHeight)
    then SetLength(LSdisplMerge, (ScanWidth*4 + Pad32bit)*ScanHeight);
  end;

  GetLineScan;

   {3rd: Does ratio}
  if (RatioOn) then DoLSratio else
  if (ChannelsRatioOn) then DoChannel_LSratio;

   {4th: Restores Image Buffers}
  ReadImage(CurIm,0,pImData);
  if (RatioOn) then begin
    if (SmoothMode > 0) then ApplySmoothing;
    DoRatio(NO_COPY);
  end
    else
  if (ChannelsRatioOn) then
    DoChannelRatio(NO_COPY);

    frmLineScan.Caption := 'Line Scan'; //restores Caption

   {5th: Displays }
   with frmLineScan do begin
   AutoScroll := False;
   with imLSplot do begin
    Width := ScanWidth;
    Picture.Bitmap.Width := ScanWidth;
   end;
   with imLineScan do begin
   Top := LSplotHeight + 5;
   Width := ScanWidth;
   Height := Length(LineArr);
   Picture.Bitmap.Width  := ScanWidth;
   Picture.Bitmap.Height := ScanHeight;
   end;

   frmLineScan.Constraints.MaxWidth  := 0;
   frmLineScan.Constraints.MaxHeight := 0;
   ClientWidth  := ScanWidth;
   if (ClientWidth < ScanWidth) then
    ClientHeight := ScanHeight + LSplotHeight + 5 + GetSystemMetrics(SM_CYHSCROLL) else
    ClientHeight := ScanHeight + LSplotHeight + 5;
    frmLineScan.Constraints.MaxWidth  := frmLineScan.Width  + 5;
    frmLineScan.Constraints.MaxHeight := frmLineScan.Height + 5;
    AutoScroll := True;
   end;

   if (Length(LSplotdata) <> ScanWidth) then Begin
    SetLength(LSplotData,  ScanWidth);
    SetLength(LSplotTrace, ScanWidth);
   end;

   for X := 0 to High(LSplotTrace) do LSplotTrace[X].X := X; //temp

   LineScanExist := True;
   LStraceExist  := False;

   if (MesLineVar.LSROI >  ScanHeight-2) then
       MesLineVar.LSROI := ScanHeight-2;

   if (frmImageControl.LineScanPlotRange.Down) then
        frmImageControl.scrBoxYSize.Max := ScanHeight-2;


   UpdateLSwindows(RELOAD_DISPL);

End;  //Procedure TfrmLineScan.DoLineScan;


procedure TfrmLineScan.FormClose(Sender: TObject; var Action: TCloseAction);
begin

     LineScanExist := False;
     LStraceExist  := False;
     if (Win3DOn) and (SourceFor3D = LSCAN_IMAGE_FOR_3D) then begin
      SourceFor3D := MAIN_IMAGE_FOR_3D;
      frm3DImageContr.Update3DSource;
     end;
     Action    := caFree;
     frmLineScan  := nil;
end;

procedure TfrmLineScan.FormCreate(Sender: TObject);
begin
  LSplotHeight := 200;
  if (MainImLoaded) then ScanHeight := imXsize -2 else
                         ScanHeight := 256;
   //Set some Maximum to set Y size max (on ImageControls)
  frmLineScan.DoubleBuffered := True;

  UpdateLSwindows(ERASE_SCREEN);
  

end;

{*****************************************************************************}
Procedure TfrmLineScan.GetDataAsStr(Const ImPos,Y : Integer; Var ValStr : AnsiString);
var DigAftZero : Integer;
begin

  if (RatioOn) then
    ValStr := FloatToStrF(LSplotData[ImPos]/LSROIdone,ffFixed,5,2) + ' F/Fo' else
  if (ChannelsRatioOn) then begin
    if (ChannelOrder = ASCENDING) then
    ValStr := FloatToStrF(LSplotData[ImPos]/LSROIdone,ffFixed,5,2) + ' Ch1/Ch2' else
    if (ChannelOrder = DESCENDING) then
    ValStr := FloatToStrF(LSplotData[ImPos]/LSROIdone,ffFixed,5,2) + ' Ch2/Ch1';
  end
    else
  if Not(RatioOn) and Not(ChannelsRatioOn) then
    ValStr := FloatToStrF(LSplotData[ImPos]/LSROIdone,ffFixed,5,1) + ' int';

    DigAftZero := 6 - Length(IntToStr(trunc(MeanImTime*1000)));  {ms}

    ValStr := IntToStr(ImPos+LSImBeg + 1) + ' im, ' + '(Yc = ' +
        IntToStr(Y) + '), ' +
        FloatToStrF(TimeSt[ImPos+LSImBeg],ffFixed,9,DigAftZero) + ' s, ' + ValStr;

End;

procedure TfrmLineScan.DrawLSTraceAndLines(Const X,Y : Integer);
{X & Y are the position of the Cursor on LS image Window}

var ValStr : AnsiString;
    TWidth : Integer;
    YLStop,YLSbot : Integer;

begin


  with frmLineScan.imLineScan.Canvas do begin
  //prevents from going beyond the image
  YLStop := (LSROIdone shr 1) + 1;
  YLSbot := (LSROIdone shr 1) + (LSROIdone mod 2);

  if (Y - YLStop >= 0) and (Y + YLSbot < ScanHeight) then Yline := Y else
  if (Y - YLStop < 0) then Yline := YLStop else
  if (Y + YLSbot > ScanHeight) then Yline := ScanHeight - YLSbot - 1;


   //X line
  Pen.Color := clRed; //has to be here
  MoveTo(0,Yline - YLStop);
  LineTo(Width,Yline - YLStop);
  MoveTo(0,Yline + YLSbot);
  LineTo(Width,Yline + YLSbot);
  //Y line
  MoveTo(X,0);
  LineTo(X,Height);

  end;

  ExtractLStrace(Yline);

  with frmLineScan.imLSplot.Canvas do begin
  Brush.Color := clBlack; //has to be here
  Brush.Style := bsSolid;
  FillRect(ClipRect);
  Pen.Color   := clRed; //has to be here
  Polyline(LSplotTrace);
  MoveTo(X,0);
  LineTo(X,Height);
  Brush.Color := clSkyBlue;; //has to be here
  Font.Size  := 8;
  GetDataAsStr(X,Yline,ValStr);
  TWidth := TextWidth(ValStr);

  if (TWidth <= ClipRect.Right) then begin
    if (X < ClipRect.Right - TWidth) then
      TextOut(X,187,ValStr)
        else
      TextOut(ClipRect.Right - TWidth,187,ValStr);
  end else
  begin
    TextOut(0,187,'Yc = ' + IntToStr(Yline));
  end;
  end; //with

  if (HintWnd <> nil) then HintWnd.ActivateHint(HintRect,ValStr);


end;

procedure TfrmLineScan.imLineScanMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

var CursorClipArea : TRect;
    p              : TPoint;
    H,W            : Integer;
    ValStr         : AnsiString;

begin

If (LineScanExist) Then Begin

  If (button = mbLeft) then Begin
    // -- Clips Cursor to the Image Window -- //
    with frmLineScan do begin
    with CursorClipArea do begin
    p := ClientToScreen(Point(imLineScan.Left,imLineScan.Top));
    Left := p.x ;
    Top  := p.y ;
    Right  := p.x + imLineScan.Width;
    Bottom := p.y + imLineScan.Height;
    end ; { with}
    end; { with}
    Winapi.Windows.ClipCursor(@CursorClipArea);
    // -End of Clips Cursor to the Image Window -- //

    //Checks if in Time Bar
    CheckIfInScaleBar(X,Y,LSTimeBar,LSTimeBarPar.Visible);

    { Decides if to use Hint Window}
    LSROIdone := MesLineVar.LSROI;
    GetDataAsStr(imLineScan.Width-1,Y,ValStr);
    if not(RatioOn) and not(ChannelsRatioOn) then W := imLineScan.Canvas.TextWidth(ValStr+'55')
                                             else W := imLineScan.Canvas.TextWidth(ValStr);

    If (W > imLineScan.Width) then Begin
      {at the beginning it gives NAN vaule for the number. Increasing the Text by 4 ('55') gives enogh length}

      //the HintRect for Hint Window Position
      HintWnd := THintWindow.Create(self);
      HintWnd.Color := $00C4FFFF;

      if not(RatioOn) and not(ChannelsRatioOn) then H := HintWnd.Canvas.TextWidth(ValStr+'55')
                                               else H := HintWnd.Canvas.TextWidth(ValStr);

      H := HintWnd.Canvas.TextHeight('H');

      {version 1}
      with HintRect do begin
      p := ClientToScreen(Point(frmLineScan.BoundsRect.Left,frmLineScan.BoundsRect.Bottom));
      Left := p.X - frmLineScan.BoundsRect.Left - GetSystemMetrics(SM_CXFRAME);
      Top  := p.Y - frmLineScan.BoundsRect.Top  - GetSystemMetrics(SM_CYFRAME) - GetSystemMetrics(SM_CYSIZE);

      Right  := Left + W + 6;
      Bottom := Top  + H + 4;
      end; //with

    End; //If (TextWidth(ValStr) > imLineScan.Width) then Begin


    If Not(InScaleBar) Then begin
      DisplayLS;
      memBMP.Assign(frmLineScan.imLineScan.Picture.Bitmap);
      DrawLSTraceAndLines(X,Y);
      if (LSTimeBarPar.Visible) then DrawScaleBar(1,LSTimeBar,imLineScan.Canvas);
      LStraceExist  := True;
    End
      Else
    If (InScaleBar) Then begin
      DisplayLS;
      if (LStraceExist) then DrawLSTraceAndLines(Xline,Yline);
      memBMP.Assign(frmLineScan.imLineScan.Picture.Bitmap);
      XmousMem := X;
      YmousMem := Y;
      DrawScaleBar(1,LSTimeBar,imLineScan.Canvas);
    End;

  End; //If (button = mbLeft) then With frmLineScan.imLineScan do Begin
End;

End; //imLineScanMouseDown(Sender: TObject


procedure TfrmLineScan.imLineScanMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
Begin     

If (LineScanExist) Then Begin

  If (Shift = []) and (LSTimeBarPar.Visible) then begin
     //Shift = [] means nothing has been pressed
    if (X > LSTimeBar.XL) and (X < LSTimeBar.XR) and
       (Y > LSTimeBar.YT) and (Y < LSTimeBar.YB) then
       imLineScan.Cursor := crArrow else
       imLineScan.Cursor := crCross;
  End Else

  If (ssLeft in Shift) then Begin

    with frmLineScan.imLineScan.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);

    If Not(InScaleBar) Then begin
      DrawLSTraceAndLines(X,Y);
      if (LSTimeBarPar.Visible) then DrawScaleBar(1,LSTimeBar,imLineScan.Canvas);
    End
      Else
    If (InScaleBar) Then begin
      LSTimeBar.XL := LSTimeBar.XL + (X - XmousMem);
      LSTimeBar.YT := LSTimeBar.YT + (Y - YmousMem);
      LSTimeBar.XR := LSTimeBar.XR + (X - XmousMem);
      LSTimeBar.YB := LSTimeBar.YB + (Y - YmousMem);
      DrawScaleBar(1,LSTimeBar,imLineScan.Canvas);
      XmousMem := X;
      YmousMem := Y;
    End;
  End; //If (ssLeft in Shift) then With frmLineScan.imLineScan do Begin
End;

End; // MouseMove


procedure TfrmLineScan.imLineScanMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 
begin
If (LineScanExist) Then Begin
  If (button = mbLeft) then Begin
   Winapi.Windows.ClipCursor(NIL);  {Removes Cursor Restrictions}
   if Not(InScaleBar) then Xline := X
    else
   If (InScaleBar) Then begin
      LSTimeBarPar.Xright  := ScanWidth  - LSTimeBar.XR;
      LSTimeBarPar.Ybottom := ScanHeight - LSTimeBar.YB;
    End;
  End;
  //kill Hint Window 
  if (HintWnd <> nil) then begin
    HintWnd.ReleaseHandle;
    HintWnd := nil;
  end;
  
End;
End;


Procedure TfrmLineScan.ExtractLStrace(Const Ycoor : Integer);
Const ZeroLevel = 190;
      TopLevel  =  10;
var Xcnt,Ycnt : Integer;
    Ybeg,Yend : Integer;
    SF        : Double; //Temp Scale Factor
    DivFact   : Integer;
Begin

  with frmLineScan.imLSplot do begin
  DivFact := Height - TopLevel - (Height - ZeroLevel);
  if Not(RatioOn) and Not(ChannelsRatioOn) then begin
    if (BitCount = 8) then
    SF := (ColTableSetings.Contrast[0]*LSROIdone) / DivFact else
    if (BitCount = 16) then with frmImageControl.DSPixRange do
    SF := ((PosTo - PosFrom)*LSROIdone) / DivFact;
  end else
  if (RatioOn) or (ChannelsRatioOn) then SF := (MaxRatio*LSROIdone) / DivFact;
  end;

  Ybeg := Ycoor - (LSROIdone shr 1);
  Yend := Ycoor + (LSROIdone shr 1) - 1 + (LSROIdone mod 2);
  
If Not(RatioOn) and Not(ChannelsRatioOn) then Begin
  For Xcnt := 0 to ScanWidth-1 Do Begin
    LSplotdata[Xcnt] := 0;
    For Ycnt := Ybeg to Yend Do begin
      LSplotdata[Xcnt] := LSplotdata[Xcnt] + LSarrW[Xcnt + ScanWidth*Ycnt];
    End;
  End;
End Else

If (RatioOn) or (ChannelsRatioOn) then Begin
  For Xcnt := 0 to ScanWidth-1 Do Begin
    LSplotdata[Xcnt] := 0;
    For Ycnt := Ybeg to Yend Do begin
      LSplotdata[Xcnt] := LSplotdata[Xcnt] + LSarrD[Xcnt + ScanWidth*Ycnt];
    End;
  End;
End;


for Xcnt := 0 to High(LSplotTrace) do LSplotTrace[Xcnt].Y := ZeroLevel - Round(LSplotData[Xcnt]/SF);


End; //Procedure TfrmLineScan.ExtractLStrace

{*****************************************************************************}
Procedure TfrmLineScan.TransferLSTraceToTimeSerAnalPlot(Sender : TObject);

var Cnt : Integer;

Begin
 if (PLOTvar.NrROI > 0) then
 for Cnt := 1 to High(PLOTvar.AdrUsed) do PLOTvar.AdrUsed[Cnt] := 0;
 frmTimeSerPlot.DisableAndReleaseTraceButtons;
 PLOTvar.NrROI := 1;  // PLOTvar.NrROI <> ROIvar.NrROI
 PLOTvar.AdrUsed[0] := 1;
 PLOTvar.ImBeg := LSImBeg;
 PLOTvar.ImEnd := LSImBeg + High(LSplotdata);
 PLOTvar.shrFact := shrFact;
 ROIvar.TickLine := 0;
 PLOTvar.ROIkind[0] := ROI_LINESCAN;
 PLOTvar.ROIsizeXY[0,0] := 0;
 PLOTvar.ROIsizeXY[1,0] := LSROIdone;
 PLOTvar.ROIcentXY[0,0] := Xline;  //doesn't matter
 PLOTvar.ROIcentXY[1,0] := Yline;
 if (not(RatioOn) and not(ChannelsRatioOn)) then PLOTvar.AnalType := INTENSITY_TIME else
 if (RatioOn) then PLOTvar.AnalType := RATIO_TIME else
 if (ChannelsRatioOn) then PLOTvar.AnalType := Ch_div_Ch_RATIO_TIME;
 //PLOTvar.NrROI stores ONLY ROIs, ROIvar.NrROI stores Selection Frame if Active
 SetLength(TSPlotData_BaseNotSubtr,PLOTvar.NrROI,Length(LSplotdata));
 SetLength(TSPlotData_BaseSubtr,PLOTvar.NrROI,Length(LSplotdata));
 SetLength(TSPlotData_BackUp,PLOTvar.NrROI,Length(LSplotdata));
 SetLength(TSPlotData_BaseLine,PLOTvar.NrROI,Length(LSplotdata));
 SetLength(CopyOfTimeSt,Length(LSplotTrace));
 if Not(RatioOn) and Not(ChannelsRatioOn) then
 SetLength(TSPlotData_Area,PLOTvar.NrROI,Length(LSplotdata))
 else TSPlotData_Area := nil;

 for Cnt := 0 to High(CopyOfTimeSt) do CopyOfTimeSt[Cnt] := TimeSt[Cnt+LSImBeg];

 If Not(RatioOn) and Not(ChannelsRatioOn) then Begin
  for Cnt := 0 to High(LSplotdata)   do TSPlotData_BaseNotSubtr[0,Cnt]  := LSplotData[Cnt]/LSROIdone;
  for Cnt := 0 to High(LSplotdata)   do TSPlotData_BackUp[0,Cnt]        := TSPlotData_BaseNotSubtr[0,Cnt]; //Same as BaseNotSubtr
  for Cnt := 0 to High(LSplotdata)   do TSPlotData_Area[0,Cnt]          := TSPlotData_BaseNotSubtr[0,Cnt]; //Same as BaseNotSubtr
 End else
 If (RatioOn) or (ChannelsRatioOn) then Begin
  for Cnt := 0 to High(LSplotdata)   do TSPlotData_BaseNotSubtr[0,Cnt]  := (ScaleRat*LSplotData[Cnt])/LSROIdone; //Same as BaseNotSubtr
  for Cnt := 0 to High(LSplotdata)   do TSPlotData_BackUp[0,Cnt]        := TSPlotData_BaseNotSubtr[0,Cnt];       //Same as BaseNotSubtr
 end;

 TimeSerAnalDone := True;  //fakes it

 with frmTimeSerPlot do begin
      SetYAxes(TimPltSlid.TraceDivMin,0,0,0,0);
      dsXaxes.Enabled   := dsAnalRange.Enabled;
      enXaxes.HideText  := False;
      enXaxes.Enabled   := dsXaxes.Enabled;
      enXaxes.MaxLength := Length(IntToStr(Length(LSplotdata)))*2 + 1;
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
 
   // For Intensity vs. Time or Intensity/min versus Time}
   If Not(RatioOn) and Not(ChannelsRatioOn) then begin
    PLOTvar.TraceDivMinUsed := True;
    if Not(FreezeMean.Down) and (TimPltSlid.TraceDivMin) then CheckAreaMinPoints(Sender);
    GetAreaDivMinOrArea(Sender);
        //GetAreaDivMinOrArea copies Data to TSPlotData_BackUp at the End//
   End
    Else
   If (RatioOn) or (ChannelsRatioOn) then Begin
    PLOTvar.TraceDivMinUsed := False;
   End; //If (RatioOn) or (ChannelsRatioOn)

   {Does the Smoothing in Time if selected}
   if cbSmTraceFltSize.ItemIndex > 0 then SmoothTrace(TSPlotData_BackUp,TSPlotData_BaseNotSubtr) else {this also stores smothing to Tag}
   PLOTvar.SmTraceKind := cbSmTraceKind.ItemIndex;
   if (PLOTvar.SmTraceKind = BOXCART1D) then
    PLOTvar.SmTrBoxcarIndex := cbSmTraceFltSize.ItemIndex else
   if (PLOTvar.SmTraceKind = GAUSS1D) then
    PLOTvar.SmTrGaussIndex := cbSmTraceFltSize.ItemIndex;

   //Create a Baseline if Selected//
   If (TimPltSlid.BaseLineOption in [GET_BASELINE,SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) Then Begin
      if (TimPltSlid.BaseLineOption in [GET_BASELINE,SUBTRACT_BASELINE]) then begin
        GetBaseLine(TSPlotData_BaseNotSubtr,TSPlotData_BaseLine);
        if (TimPltSlid.BaseLineOption = SUBTRACT_BASELINE) then SubtractBaseLine;
      end else
      if (TimPltSlid.BaseLineOption = DIVIDE_BY_BASELINE) then begin
        DivideByBaseline;
      end;
   End;
   //memorizes what has been done in PLOTvar.BaseLineStatus

   PLOTvar.BaseLineStatus := TimPltSlid.BaseLineOption;
   PLOTvar.BaseLinePoints := TimPltSlid.BaseLinePoints;
   PLOTvar.LSD := enLSD.NumberFloat;
   PLOTvar.RSD := enRSD.NumberFloat;

    //Gest Peeks if Checked//
   if (cbGetPeaks.Checked) and (PLOTvar.AnalType = RATIO_TIME) then begin
       if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
       GetPeaks(TSPlotData_BaseSubtr) else
       GetPeaks(TSPlotData_BaseNotSubtr);
   end
   else begin
      PeakPosArr      := nil;
      PeakValArr      := nil;
      PeakTimArr      := nil;
      if (Sender = StartAnal) then begin
       //Sender could  be SparkTables and then PeakFakeImNrArr used to Plot Should Not be Nilled !!! //
        PeakFakeImNrArr := nil;
       if (frmPeaks <> nil) then frmPeaks.ClearPeakTable;
      end; //if (Sender = StartAnal)
   end; // End of Get Peeks//

   SetPlotTitle;
   frmTimeSerPlot.Caption := 'Time Series Plot' + ' from file: ' + PLOTvar.Title;///PLOT_FTitle;
   frmTimeSerPlot.ShowAllTracesClick(Sender);
   if (sbSlavePlot.Down) then frmSlaveTSPlot.DrawPlot(Sender);
    {it activates also DrawTimeSerPlotTraces; and Draw Cursor}

  end;
End; //Procedure TransferLSTraceToTimeSerAnalPlot;


END.
