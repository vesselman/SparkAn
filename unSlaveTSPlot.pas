unit unSlaveTSPlot;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.ExtCtrls,unGlobUnit;

type
  TfrmSlaveTSPlot = class(TForm)
    imTSPlot: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DrawPlot(Sender : TObject);
    Procedure DrawTSPlotTraces(Sender : TObject; Const PlotData   : TDyn2DDoubleArr; Const PlotCanvas : TCanvas; Const DrawBaseLine : Boolean);
    Procedure DrawTSPlotXaxes(Const PlotCanvas : TCanvas);
    Procedure DrawTSPlotYaxes(Const PlotCanvas : TCanvas);    {Draws Y axes & Labels for Bothe X & Y axes}
    Procedure DrawTTSPlotXticks(Const PlotCanvas : TCanvas);
    Procedure DrawTSPlotYticks(Const PlotCanvas : TCanvas);
    Procedure DrawTSPlotCursor(Const PlotCanvas : TCanvas);
  end;

var
  frmSlaveTSPlot: TfrmSlaveTSPlot;

implementation

Uses unTimeSerAnal;     //Xscale := (TimPltSlid.WinXSize - PlXbeg)/Xrange;

{$R *.dfm}

procedure TfrmSlaveTSPlot.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   frmTimeSerPlot.sbSlavePlot.Down := False;
   Action         := caFree;
   frmSlaveTSPlot := nil;
end;

procedure TfrmSlaveTSPlot.FormCreate(Sender: TObject);
begin

  frmSlaveTSPlot.DoubleBuffered := True;

  ClientWidth  := frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Width;
  ClientHeight := frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Height;

  with frmSlaveTSPlot.imTSPlot do begin
    Width := frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Width;
    Picture.Bitmap.SetSize(Width,Height);
    Canvas.Brush.Color := clBlack;
    Canvas.FloodFill(0,0,clblack,fsBorder);
  end;

  frmSlaveTSPlot.AutoSize := True;
                                                      
end;


Procedure TfrmSlaveTSPlot.DrawPlot(Sender : TObject);
var DrawBaseline : Boolean;
Begin

  if    (frmTimeSerPlot.sbTraceToDisplay.Down) then begin
    if (TimPltSlid.BaseLineOption in[SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
      DrawTSPlotTraces(Sender,TSPlotData_BaseSubtr,imTSPlot.Canvas,False) else
    if (TimPltSlid.BaseLineOption = GET_BASELINE) then
      DrawTSPlotTraces(Sender,TSPlotData_BaseNotSubtr,imTSPlot.Canvas,True) else
      DrawTSPlotTraces(Sender,TSPlotData_BaseNotSubtr,imTSPlot.Canvas,False);
  end else
  if not(frmTimeSerPlot.sbTraceToDisplay.Down) and
    (TimPltSlid.BaseLineOption in[GET_BASELINE,SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
    DrawTSPlotTraces(Sender,TSPlotData_BaseNotSubtr,imTSPlot.Canvas,True)
  else
    DrawTSPlotTraces(Sender,TSPlotData_BaseNotSubtr,imTSPlot.Canvas,False);

  DrawTSPlotXaxes(imTSPlot.Canvas);
  DrawTSPlotYaxes(imTSPlot.Canvas);    {Draws Y axes & Labels for Bothe X & Y axes}
  DrawTTSPlotXticks(imTSPlot.Canvas);
  DrawTSPlotYticks(imTSPlot.Canvas);
  if (PLOTvar.AnalType = RATIO_TIME) and (TimPltSlid.CursorOn) then DrawTSPlotCursor(imTSPlot.Canvas);

End;

{---------------------------------------------------------------------}
 {**************************************************************************}
 Procedure TfrmSlaveTSPlot.DrawTSPlotTraces(Sender : TObject; Const PlotData   : TDyn2DDoubleArr;
                                            Const PlotCanvas : TCanvas; Const DrawBaseLine : Boolean);
  Var

    CntROI        : integer;
    ImNr,CntPeak  : integer;
    BegIm,EndIm   : integer;
    Ypeak         : integer; {calculates Once for speed and clarity, Peaks Only}

    MemPos,CntPix : Integer;
    MinVal,MaxVal : Double;
    Compress      : Boolean;

  Begin


  PlotCanvas.Brush.Color := clblack;
  PlotCanvas.FillRect(Rect(PlXbeg,PlYend,TimPltSlid.WinXSize,PlYbeg+1));

 //////////////////////////////////////////////////////////////////
 {------------ Starts Plotting ------------------------}

      BegIm := frmTimeSerPlot.dsXaxes.PosFrom;
      EndIm := frmTimeSerPlot.dsXaxes.PosTo;

 {-----------------------------------------------------}

 {------------ 1st: Draws Traces ------------------------}

  //Checks if To Compress or Not //
  If ((EndIm - BegIm + 1)  > 2*(TimPltSlid.WinXSize - PlXbeg)) and
      Not(frmTimeSerPlot.CheckBoxSymbolOn.Checked) then Begin
    if (Sender <> frmTimeSerPlot.DSYaxes) or (High(TraceArr) + 1 <> 2*(TimPltSlid.WinXSize - PlXbeg)) then 
    SetLength(TraceArr,2*(TimPltSlid.WinXSize - PlXbeg));
    Compress := True;
  End Else
  Begin
    if (Sender <> frmTimeSerPlot.DSYaxes) then  SetLength(TraceArr,EndIm - BegIm + 1);
    Compress := False;
  End;
  


 If Compress Then Begin  // Writes X plot values for all ROIs
    MemPos := 0;
    CntPix := 0;
  for ImNr := BegIm to EndIm do begin
    if MemPos <> round((ImNr-BegIm)*Xscale) then begin
      TraceArr[CntPix].X     := PlXBeg + MemPos;
      TraceArr[CntPix + 1].X := TraceArr[CntPix].X;
      Inc(CntPix,2);
      Inc(MemPos);
    end;
  end; //for ImNr := BegIm to EndIm
 End; //If Compress

{----- starts going through ROIs ---------}

For CntROI := 0 to (PLOTvar.NrROI - 1) Do Begin
 //---------------------------------------------------//

 If PLOTvar.AdrUsed[CntROI] > 0 then Begin
     PlotCanvas.Pen.Color   := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
  //---------------------------------------------------//

 if ROIvar.TickLine <> PLOTvar.AdrUsed[CntROI] then
    PlotCanvas.Pen.Width := 1 else
    PlotCanvas.Pen.Width := 3;

  // --- Writes Y pixes values for Baseline ---//
  If (DrawBaseLine) Then Begin

 If Compress Then Begin
    MemPos := 0;
    CntPix := 0;
    MinVal := High(Word);
    MaxVal := 0;
  For ImNr := BegIm to EndIm do Begin
    if MemPos = round((ImNr-BegIm)*Xscale)  then begin
      if MinVal > TSPlotData_BaseLine[CntROI,(ImNr-PLOTvar.ImBeg)] then
              MinVal := TSPlotData_BaseLine[CntROI,(ImNr-PLOTvar.ImBeg)];

        if MaxVal < TSPlotData_BaseLine[CntROI,(ImNr-PLOTvar.ImBeg)] then
              MaxVal := TSPlotData_BaseLine[CntROI,(ImNr-PLOTvar.ImBeg)];
    end else
    if MemPos <> round((ImNr-BegIm)*Xscale) then begin
      TraceArr[CntPix    ].Y := PlYbeg-round(Yscale*MinVal - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);
      TraceArr[CntPix + 1].Y := PlYbeg-round(Yscale*MaxVal - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);
      Inc(CntPix,2);
      Inc(MemPos);
      MinVal := High(Word);
      MaxVal := 0;
    end;
  End; //for ImNr := BegIm to EndIm
 End Else //If Compress

 /// Writes Y pix values in Concentional way
 If Not(Compress) then For ImNr := BegIm to EndIm Do Begin

    TraceArr[ImNr-BegIm].X := PlXBeg+round((ImNr-BegIm)*Xscale);
    TraceArr[ImNr-BegIm].Y := PlYbeg-round(Yscale*TSPlotData_BaseLine[CntROI,(ImNr-PLOTvar.ImBeg)]
                              - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);

 End; //for ImNr := Beg to  ToEnd - 1 Do Begin//

  PlotCanvas.Pen.Style := psDot;
  PlotCanvas.Brush.Color := clNone; //Has to be set to None in Order to Get Dotted  Line; or set it to : Canvas.Brush.Style := bsClear;
  PlotCanvas.Polyline(TraceArr);  //Plots the Trace
  PlotCanvas.Pen.Style := psSolid;

 End; //If (TimPltSlid.BaseLineOption = GET_BASELINE)
//----- End with the baseline //

  // Writes Y pixes values for Data Trace
  If Compress Then Begin
    MemPos := 0;
    CntPix := 0;
    MinVal := High(Word);
    MaxVal := 0;
  For ImNr := BegIm to EndIm do Begin
    if MemPos = round((ImNr-BegIm)*Xscale)  then begin
      if MinVal > PlotData[CntROI,(ImNr-PLOTvar.ImBeg)] then
              MinVal := PlotData[CntROI,(ImNr-PLOTvar.ImBeg)];

        if MaxVal < PlotData[CntROI,(ImNr-PLOTvar.ImBeg)] then
              MaxVal := PlotData[CntROI,(ImNr-PLOTvar.ImBeg)];
    end else
    if MemPos <> round((ImNr-BegIm)*Xscale) then begin
      TraceArr[CntPix    ].Y := PlYbeg-round(Yscale*MinVal - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);
      TraceArr[CntPix + 1].Y := PlYbeg-round(Yscale*MaxVal - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);
      Inc(CntPix,2);
      Inc(MemPos);
      MinVal := High(Word);
      MaxVal := 0;
    end;
  End; //for ImNr := BegIm to EndIm
 End Else //If Compress

 /// Writes Y pix values in Concentional way
 If Not(Compress) then For ImNr := BegIm to EndIm Do Begin

    TraceArr[ImNr-BegIm].X := PlXBeg+round((ImNr-BegIm)*Xscale);
    TraceArr[ImNr-BegIm].Y := PlYbeg-round(Yscale*PlotData[CntROI,(ImNr-PLOTvar.ImBeg)]
                              - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);

  End; { For ImNr := Beg to  ToEnd - 1 Do Begin}

  PlotCanvas.Polyline(TraceArr);  //Plots the Trace



///////////////////////////////////////////////////////////////////////
  { -------------- 2nd: Draws Symbols -----------------------------}
  if (TimPltSlid.SymbOn) or (PLOTvar.HasPeaks) then
     PlotCanvas.Brush.Color :=  ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];

  {if symbol was chosen or Im Nr from Tables Clicked}

  If (TimPltSlid.SymbOn) then Begin


    If PLOTvar.ImNrFromTable = -1 then Begin
        //Draws "Regular" Symbols for Each Image//
      For ImNr := BegIm to EndIm Do Begin
        PlotCanvas.Ellipse(TraceArr[ImNr-BegIm].X-TimPltSlid.SymbSize,
                       TraceArr[ImNr-BegIm].Y-TimPltSlid.SymbSize,
                       TraceArr[ImNr-BegIm].X+TimPltSlid.SymbSize,
                       TraceArr[ImNr-BegIm].Y+TimPltSlid.SymbSize);
      End; //For ImNr := Beg to  ToEnd - 1 Do Begin//
    End Else
    If PLOTvar.ImNrFromTable > -1 then Begin
          //Draws the Symbol For The Image Number as Clicked on table//
      For ImNr := BegIm to EndIm Do Begin
        If PLOTvar.AdrUsed[CntROI] = 20 Then Begin  //Last Trace # 20, White Color//
          if ImNr = PLOTvar.ImNrFromTable then Begin
            PlotCanvas.Brush.Color := TimPltSlid.SymbFromTableCol;
            PlotCanvas.Pen.Color   := TimPltSlid.SymbFromTableCol;
          end else begin
            PlotCanvas.Pen.Color   := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
            PlotCanvas.Brush.Color := ROIvar.ROICol[PLOTvar.AdrUsed[CntROI]];
          end;
        End; //If CntROI = 19 Then Begin = Last Trace # 20, White Color//

        //In this Option [CheckBoxSymbolOn.Checked = True) Cmpress is Always = false

        PlotCanvas.Ellipse(TraceArr[ImNr-BegIm].X-TimPltSlid.SymbSize,
                       TraceArr[ImNr-BegIm].Y-TimPltSlid.SymbSize,
                       TraceArr[ImNr-BegIm].X+TimPltSlid.SymbSize,
                       TraceArr[ImNr-BegIm].Y+TimPltSlid.SymbSize);

      End; // For ImNr := Beg to  ToEnd - 1 Do Begin //
    End; //If PLOTvar.ImNrFromTable > -1 then Begin//
  End; //If frmTimeSerPlot.CheckBoxSymbolOn.Checked = True//


  If (TimPltSlid.AlwaysUseSymb) Then Begin
    If PLOTvar.ImNrFromTable > -1 then Begin
      If PLOTvar.AdrUsed[CntROI] = 20 Then Begin
       PlotCanvas.Brush.Color := TimPltSlid.SymbFromTableCol;
       PlotCanvas.Pen.Color   := TimPltSlid.SymbFromTableCol;
        if Compress then
        PlotCanvas.Ellipse(
        TraceArr[2*(round((PLOTvar.ImNrFromTable-BegIm)*Xscale))].X - TimPltSlid.SymbSize,
        TraceArr[2*(round((PLOTvar.ImNrFromTable-BegIm)*Xscale))].Y - TimPltSlid.SymbSize,
        TraceArr[2*(round((PLOTvar.ImNrFromTable-BegIm)*Xscale))].X + TimPltSlid.SymbSize,
        TraceArr[2*(round((PLOTvar.ImNrFromTable-BegIm)*Xscale))].Y + TimPltSlid.SymbSize) else

        if Not(Compress) then
        PlotCanvas.Ellipse(TraceArr[PLOTvar.ImNrFromTable-BegIm].X - TimPltSlid.SymbSize,
                       TraceArr[PLOTvar.ImNrFromTable-BegIm].Y - TimPltSlid.SymbSize,
                       TraceArr[PLOTvar.ImNrFromTable-BegIm].X + TimPltSlid.SymbSize,
                       TraceArr[PLOTvar.ImNrFromTable-BegIm].Y + TimPltSlid.SymbSize);
       End; //PLOTvar.AdrUsed[CntROI] = 20//
    End; //If PLOTvar.ImNrFromTable > -1//
  End;  //If (PLOTvar.AlwaysUseSymb = True)//
          // Ellipse(X1, Y1, X2, Y2)//

    { -------------- 3rd -  Peaks Part -----------------------------------}
   {Puts Symbols for Peaks: so far circles for peaks found}

  If (PLOTvar.HasPeaks) and (PLOTvar.AnalType = RATIO_TIME) Then Begin
        //-------------------------------------------------------//

    If PeakFakeImNrArr <> nil Then   //PeakPosArr is not used here on purpose, see below
      if High(PeakFakeImNrArr[CntROI]) > -1 then
        For CntPeak := 0 to High(PeakFakeImNrArr[CntROI]) Do Begin
         if TimPltSlid.GetPeaks then ImNr := PeakPosArr[CntROI,CntPeak] + PLOTvar.ImBeg  //done here for clarity//
         else ImNr := PLOTvar.ImNrFromTable;

          if (ImNr >= BegIm) and (ImNr <= EndIm) Then Begin
             //Puts Symbol on Peak//

             if Compress then
              PlotCanvas.Ellipse(
                TraceArr[2*(round((ImNr-BegIm)*Xscale))].X - TimPltSlid.SymbSize,
                TraceArr[2*(round((ImNr-BegIm)*Xscale))].Y - TimPltSlid.SymbSize,
                TraceArr[2*(round((ImNr-BegIm)*Xscale))].X + TimPltSlid.SymbSize,
                TraceArr[2*(round((ImNr-BegIm)*Xscale))].Y + TimPltSlid.SymbSize) else

            if Not(Compress) then
              PlotCanvas.Ellipse(TraceArr[ImNr-BegIm].X-TimPltSlid.SymbSize,
                TraceArr[ImNr-BegIm].Y-TimPltSlid.SymbSize,
                TraceArr[ImNr-BegIm].X+TimPltSlid.SymbSize,
                TraceArr[ImNr-BegIm].Y+TimPltSlid.SymbSize);

       if (PeakFakeImNrArr[CntROI,CntPeak].Lim > CANNOT_BE_DONE ) and
          (PeakFakeImNrArr[CntROI,CntPeak].Rim > CANNOT_BE_DONE ) Then Begin

 //Calculates Y at 1/2 amplitude//
 Ypeak := PlYbeg - round(Yscale*((PlotData[CntROI,(ImNr-PLOTvar.ImBeg)]-10)/2+10)
                              - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);

              //Draws 1/2 amplitude Line using Fake ImNr = Time/Time for One Image//

 PlotCanvas.MoveTo(PlXBeg + round((PeakFakeImNrArr[CntROI,CntPeak].Lim-BegIm)*Xscale), Ypeak);
 PlotCanvas.LineTo(PlXBeg + round((PeakFakeImNrArr[CntROI,CntPeak].Rim-BegIm)*Xscale), Ypeak);

              //Draws Verical Line to 1/2 Amplitude//
 if Compress then begin
  PlotCanvas.MoveTo(TraceArr[2*(round((ImNr-BegIm)*Xscale))].X,TraceArr[2*(round((ImNr-BegIm)*Xscale))].Y);
  PlotCanvas.LineTo(TraceArr[2*(round((ImNr-BegIm)*Xscale))].X, Ypeak);
 end else
 if Not(Compress) then begin
  PlotCanvas.MoveTo(TraceArr[ImNr-BegIm].X,TraceArr[ImNr-BegIm].Y);
  PlotCanvas.LineTo(TraceArr[ImNr-BegIm].X, Ypeak);
 end;


       end else //if Both PeakTimArr[CntROI,CntPeak,0] and [1]> 0//
           //if only right side found//
   if (PeakFakeImNrArr[CntROI,CntPeak].Lim < TIME_DONE) and
      (PeakFakeImNrArr[CntROI,CntPeak].Rim > CANNOT_BE_DONE ) Then Begin
 //Calculates Y at 1/2 amplitude//
 Ypeak := PlYbeg - round(Yscale*((PlotData[CntROI,(ImNr-PLOTvar.ImBeg)]-10)/2+10)
                              - frmTimeSerPlot.dsYaxes.PosFrom*Yscale);
              //Draws Only t1/2 Decay Line usin Fake ImNr = Time/Time for One Image//
 if Compress then begin
  PlotCanvas.MoveTo(TraceArr[2*(round((ImNr-BegIm)*Xscale))].X,Ypeak);
  PlotCanvas.LineTo(PlXBeg + round((PeakFakeImNrArr[CntROI,CntPeak].Rim-BegIm)*Xscale), Ypeak);
 end else
 if Not(Compress) then begin
  PlotCanvas.MoveTo(TraceArr[ImNr-BegIm].X,Ypeak);
  PlotCanvas.LineTo(PlXBeg + round((PeakFakeImNrArr[CntROI,CntPeak].Rim-BegIm)*Xscale), Ypeak);
 end;
              //Draws Verical Line to 1/2 Amplitude//
 if Compress then begin
  PlotCanvas.MoveTo(TraceArr[2*(round((ImNr-BegIm)*Xscale))].X,TraceArr[2*(round((ImNr-BegIm)*Xscale))].Y);
  PlotCanvas.LineTo(TraceArr[2*(round((ImNr-BegIm)*Xscale))].X,Ypeak);
 end else
 if Not(Compress) then begin
  PlotCanvas.MoveTo(TraceArr[ImNr-BegIm].X,TraceArr[ImNr-BegIm].Y);
  PlotCanvas.LineTo(TraceArr[ImNr-BegIm].X,Ypeak);
 end;
              end; //if Right Side only PeakTimArr[CntROI,CntPeak,0]=0  and [1]> 0//
            end; // if (ImNr >= BegIm) and (ImNr <= EndIm)//
        End;//For ImNr := 0 to High(PlotData[CntROI])//
        //-------------------------------------------------------//
  End; //If (TimPltSlid.HasPeaks = True) and (PLOTvar.RatOn)//
  //------------- End with Peaks -----------------------------------//
         

{---------------------------------------------------------------------------}
End; {If PLOTvar.AdrUsed[CntROI] > 0}
End; {For CntROI := 0 to (BoxPar.NrB - 1)}


   PlotCanvas.Pen.Width := 1; {do not remove - resets }
End; { Procedure DrawTSPlotTraces;}

{**************************************************************************}
Procedure TfrmSlaveTSPlot.DrawTSPlotXaxes(Const PlotCanvas : TCanvas);   {Draws just X axes}

  Begin

    With  PlotCanvas Do Begin
    {Draws X and Y Axes}
      Pen.Color := clWhite;
      MoveTo(PlXaxBeg,PlYaxBeg);
      LineTo(TimPltSlid.WinXSize,PlYaxBeg);
      MoveTo(PlXaxBeg,PlYaxEnd);
      LineTo(TimPltSlid.WinXSize,PlYaxEnd);
    End;


 End; { Procedure DrawTimeSerPlotXaxes;}

 {**************************************************************************}
 Procedure TfrmSlaveTSPlot.DrawTSPlotYaxes(Const PlotCanvas : TCanvas);    {Draws Y axes & Labels for Bothe X & Y axes}
  Var
         LogRec: TLogFont;  {Win GDI Structure:  LOGFONT structure }
          OldFontHandle, NewFontHandle: hFont;
  Begin

    with PlotCanvas Do Begin
    {Draws X and Y Axes}
      {Done in Form.Create}
     {Font.Name := 'Arial';}
     {Font.Size := 8;}
      Font.Color  := clWhite;
      Pen.Color   := clWhite;
      MoveTo(PlXaxBeg,PlYaxBeg);
      LineTo(PlXaxBeg,PlYaxEnd);
      MoveTo(TimPltSlid.WinXSize-1,PlYaxBeg);
      LineTo(TimPltSlid.WinXSize-1,PlYaxEnd);


      Brush.Style := bsSolid;
      Brush.Color := clBlack;
      FillRect(Rect(0,0,20,300));

      GetObject(Font.Handle, SizeOf(LogRec), Addr(LogRec));
      LogRec.lfEscapement  := 90*10;
      LogRec.lfOrientation := 90*10;
      NewFontHandle := CreateFontIndirect(LogRec);
      OldFontHandle := SelectObject(Handle, NewFontHandle);
      If (PLOTvar.AnalType = INTENSITY_TIME) then TextOut(1, 180, 'Intensity') else
      If (PLOTvar.AnalType = RATIO_TIME)     then TextOut(1, 160, 'F/Fo') else
      If (PLOTvar.AnalType = DISTANCE_TIME)  then TextOut(1, 180, 'Distance (' +  Char(181) + 'm)');
      NewFontHandle := SelectObject(Handle, OldFontHandle);
      DeleteObject(NewFontHandle);
    end; //with
 End; { Procedure DrawTSPlotYaxes;}
{**************************************************************************}

 Procedure TfrmSlaveTSPlot.DrawTTSPlotXticks(Const PlotCanvas : TCanvas);
  Var
        BigXTick,NrBigXTick,NrSmXTick, i, j : integer;
        BigXTickBeg : integer;
        Lab  : AnsiString;
        LabOff, Xoff, XoffUse: integer;
        XSleft, XLmin : integer; {position of Left & Right Slider}
        SmXTick : Single;
        BigTickTime  : Extended;
        DigAftZero    : integer;
        {BigXTick = Number of Images whitin Tick}
  Begin

   With PlotCanvas do begin
      {sets Color & Font}
      Pen.Color := clWhite;
      {Done in Form.Create}
     {Font.Name := 'Arial';}
     {Font.Size := 8;}
      Font.Color := clWhite;


     XLmin  := frmTimeSerPlot.dsXaxes.Min;
     XSleft := frmTimeSerPlot.dsXaxes.PosFrom;


     if (Xrange >= 50) then BigXTick := (Xrange div 5) else BigXTick := (Xrange div 2);

     if  BigXTick >= 10 then BigXTick := (BigXTick div 10)*10 else
     if  BigXTick <= 2  then BigXTick := (BigXTick div 2)*2 else
         BigXTick := (BigXTick div 5)*5;  {BigTick = Size in Units}

     If (BigXTick = 0) Then  BigXTick := 1;

     if BigXTick >= 10 then NrSmXTick := 10 else
        NrSmXTick := BigXTick;
        SmXTick := BigXTick/NrSmXTick;

     BigTickTime := BigXTick*MeanImTime; {temporarily holds this value}
     if trunc(BigTickTime) >= 1 then DigAftZero := 1 else
     DigAftZero := 7 - Length(IntToStr(trunc(frac(BigTickTime)*100000)));

{--------------------------------------------------------------------------------------------}

Brush.Color := clblack;
{First deletes Ticks, then deletes Labes without Deleting Yax labels}
{Deletes Bottom Ticks }
FillRect(Rect(PlXaxBeg,PlYaxBeg+1,TimPltSlid.WinXSize,frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Height));
FillRect(Rect(PlXaxBeg-20,PlYaxBeg+5,TimPltSlid.WinXSize,frmTimeSerPlot.FrameTimSerPlot.imgTimeSerPlot.Height));
{Deletes Top Ticks}
FillRect(Rect(PlXaxBeg,0,TimPltSlid.WinXSize,PlYaxEnd));
FillRect(Rect(PlXaxBeg-20,0,TimPltSlid.WinXSize,PlYaxEnd-5));
TextOut(PlXbeg + 200,2,PLOTvar.Title);
TextOut(PlXbeg,2,'Seconds');
TextOut(PlXbeg,PlYbeg+30,'Number of Images');

{--------------------------------------------------------------------------------------------}

        Xoff := 0;
     While Xoff < XSleft Do Begin
        if Xoff < XSLeft then Inc(Xoff,BigXTick);
     End;
        Dec(Xoff); {shifts Xoff to the left by one; Because Images are numbered From 1}
        NrBigXTick :=  Xrange div BigXTick;
        j := 1;

     For i := 0 to NrBigXTick Do Begin   {Draws Ticks}


    if (XSleft = 0) and (i = 0) then XoffUse := Xoff + 1 Else XoffUse := Xoff;
      If BigXTick*i+(XoffUse-XSleft) >= 0 Then Begin
            {Bottom Images }
        MoveTo(PlXBeg + round((BigXTick*i+(XoffUse-XSleft))*Xscale),PlYaxBeg);
        LineTo(PlXBeg + round((BigXTick*i+(XoffUse-XSleft))*Xscale),PlYaxBeg+5);
            {Top - Seconds}
        MoveTo(PlXBeg + round((BigXTick*i+(XoffUse-XSleft))*Xscale),PlYaxEnd);
        LineTo(PlXBeg + round((BigXTick*i+(XoffUse-XSleft))*Xscale),PlYaxEnd-5);

        {PlXbeg is used in order to get 0 alligned with Traces}
          {Bottom Tick Labels}
        Lab := IntToStr((BigXTick*i+ XoffUse) + 1 );   {1st image = 1}
        LabOff := (Length(Lab)*6) div 2;
        TextOut(PlXaxBeg + round((BigXTick*i+(XoffUse-XSleft))*Xscale)-LabOff,PlYaxBeg+6,Lab);
           {Top Tick Labels}
        if (BigXTick*i+ XoffUse - XLmin <= High(CopyOfTimeSt)) then
        BigTickTime := CopyOfTimeSt[BigXTick*i + Xoff - XLmin];
        if BigTickTime > 0.000001 then
        Lab := FloatToStrF(BigTickTime,ffFixed,5,DigAftZero) else Lab := '0';
        LabOff := (Length(Lab)*5) div 2;
        TextOut(PlXaxBeg + round((BigXTick*i+(XoffUse-XSleft))*Xscale)-LabOff,PlYaxEnd-20,Lab);
        if i = 0 then
        while (Xoff-XSleft)-(SmXTick*j) >= 0 do begin
           {Bottom - Images}
          MoveTo(PlXBeg + round(((Xoff-XSleft)-(SmXTick*j))*Xscale),PlYaxBeg);
          LineTo(PlXBeg + round(((Xoff-XSleft)-(SmXTick*j))*Xscale),PlYaxBeg+3);
           {Top - Seconds}
          MoveTo(PlXBeg + round(((Xoff-XSleft)-(SmXTick*j))*Xscale),PlYaxEnd);
          LineTo(PlXBeg + round(((Xoff-XSleft)-(SmXTick*j))*Xscale),PlYaxEnd-3);
          Inc(j);
        end;
        for j := 1 to NrSmXTick-1 do begin
          if PlXBeg + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft) )*Xscale) <= TimPltSlid.WinXSize Then Begin
            {Bottom - Images}
          MoveTo(PlXBeg + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft) )*Xscale),PlYaxBeg);
          LineTo(PlXBeg + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft))*Xscale),PlYaxBeg+3);
            {Top - Seconds}
          MoveTo(PlXBeg + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft) )*Xscale),PlYaxEnd);
          LineTo(PlXBeg + round((BigXTick*i+ (SmXTick*j)+(Xoff-XSleft))*Xscale),PlYaxEnd-3);
          end;
        end;
      end;


 End; {For i := BigXTickBeg to NrBigYTick}
 End; //with PlotCanvas

 End; { Procedure DrawTSPlotXticks;}
 {**************************************************************************}
 {**************************************************************************}
Procedure TfrmSlaveTSPlot.DrawTSPlotYticks(Const PlotCanvas : TCanvas);
   Var
       BigYTick, i, j : Integer;  {size in pix}
       NrBigYTick,NrSmYTick : Integer;
       Lab : AnsiString;
       SmYTick : Single;

Begin


With PlotCanvas do begin
      {sets Color & Font}

   {Done in Form.Create}
   {Font.Name := 'Arial';}
   {Font.Size := 8;}

    Font.Color := clWhite;
    Pen.Color := clWhite;


    BigYTick := (Yrange div 5);   

  If (BigYTick = 0) Then  BigYTick := 1 else
  If (BigYTick >= 5) and (BigYTick <10) Then  BigYTick := (BigYTick div 5)*5 else
  If (BigYTick >= 10)  Then  BigYTick := (BigYTick div 10)*10;

  If (PLOTvar.AnalType = RATIO_TIME) Then NrBigYTick := 200 div BigYTick else
                                          NrBigYTick := frmTimeSerPlot.dsYaxes.Max div BigYTick;

  If (PLOTvar.AnalType = RATIO_TIME)  then begin
    if NrBigYTick <= 5 then  NrSmYTick := 10 else NrSmYTick := 5;
  End else
  Begin
    if (BigYTick >= 10) and (NrBigYTick <= 5) then NrSmYTick := 10 else
    if (BigYTick >= 10) and (NrBigYTick >  5) then NrSmYTick :=  5 else
    if (BigYTick  < 10) then NrSmYTick := BigYTick;
  End;
       SmYTick := BigYTick/NrSmYTick;
 

 Brush.Color := clblack;
 FillRect(Rect(14,45,PlXaxBeg,260));
 Brush.Style := bsClear;

 For i := 0 to NrBigYTick  Do Begin   {Draws Ticks}
   if (i*BigYTick >= frmTimeSerPlot.dsYaxes.PosFrom) and
      (i*BigYTick <= frmTimeSerPlot.dsYaxes.PosTo) then begin


        MoveTo(PlXaxBeg-5,PlYbeg - round((BigYTick*i -
                        frmTimeSerPlot.dsYaxes.PosFrom)*Yscale));
        LineTo(PlXaxBeg,  PlYbeg - round((BigYTick*i -
                        frmTimeSerPlot.dsYaxes.PosFrom)*Yscale));

   If  (PLOTvar.AnalType = RATIO_TIME)  then Lab := FloatToStrF((BigYTick*i)/10,ffFixed,2,1) else
                                             Lab := IntToStr   (BigYTick*i);
        TextOut(PlXbeg-(Length(Lab)*7 +8),PlYbeg - round((BigYTick*i -
                              frmTimeSerPlot.dsYaxes.PosFrom)*Yscale)-8,Lab);
        for j := 1 to NrSmYTick - 1 do begin
           if PlYbeg - round((BigYTick*i+SmYTick*j -
                        frmTimeSerPlot.dsYaxes.PosFrom)*Yscale) >= PlYend then begin
           MoveTo(PlXaxBeg-3,PlYbeg - round((BigYTick*i+SmYTick*j -
                        frmTimeSerPlot.dsYaxes.PosFrom)*Yscale));
           LineTo(PlXaxBeg,  PlYbeg - round((BigYTick*i+SmYTick*j -
                        frmTimeSerPlot.dsYaxes.PosFrom)*Yscale));
           end;
        end;


   end;
 End; {For i := BigYTickBeg to NrBigYTick}

 End; //With PlotCanvas

End;  {DrawTimeSerPlotYticks}
{**************************************************************************}

{**************************************************************************}
 Procedure TfrmSlaveTSPlot.DrawTSPlotCursor(Const PlotCanvas : TCanvas);
   Var YcurPos : integer;
  Begin

  With  PlotCanvas Do Begin

    YcurPos := PlYbeg - round(Yscale*TimPltSlid.CurVal -
                              frmTimeSerPlot.dsYaxes.PosFrom*Yscale);

    if (YcurPos > PlYend) and (YcurPos < PlYbeg) then begin
     Pen.Color := RGB(150,150,150);
     Pen.Mode  := pmXOR;
     Pen.Width := 1;
     MoveTo(PlXbeg,YcurPos);
     LineTo(TimPltSlid.WinXSize,YcurPos);
     Pen.Mode  := pmCopy;
    end;
  End; // PLOTvar.CurPix := YcurPos;

 End;

End.
