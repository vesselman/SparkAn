unit unWaveTable;  {for Big Events = Ca waves & Oscilations}

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
   Vcl.Buttons, EditNumerical;

type
  TfrmWaveTable = class(TForm)
    StringGridBig: TStringGrid;
    DelAllMarks: TSpeedButton;
    DelRow: TSpeedButton;
    EnableMultSel: TSpeedButton;
    RecalculateBigEv: TSpeedButton;
    FilePortion: TComboBox;
    PutBoxes: TSpeedButton;
    cbGetBigEvBase: TCheckBox;
    edBigEvBaseRange: TEditNumerical;
    edBigEvBasePoints: TEditNumerical;
    Label3: TLabel;
    Label5: TLabel;
    sbSentBigEvToHistograms: TSpeedButton;
    procedure cbGetBigEvBaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGridBigMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DelRowClick(Sender: TObject);
    procedure DelAllMarksClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure EnableMultSelClick(Sender: TObject);
    procedure StringGridBigDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RecalculateBigEvClick(Sender: TObject);
    procedure StringGridBigMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PutBoxesClick(Sender: TObject);
    procedure FilePortionChange(Sender: TObject);
    procedure edBigEvBaseRangeReturnPressed(Sender: TObject);
    procedure edBigEvBasePointsReturnPressed(Sender: TObject);
    procedure sbSentBigEvToHistogramsClick(Sender: TObject);
  private
    { Private declarations }
    MultSelArrBigEv  : Array of Word;
    RowSelBigEv      : Word; {Selected Rows}
    BigSelMode       : Byte;  {0 = No Sel Mode; 1 = One Row Sel; 2 = Multiple Selections}
  public
    { Public declarations }
    RowBig           : Integer; {Means Row Small; The Row to Be Manipulated and Focused}

    Procedure LoadWaveTable(BegFill : Boolean);
  END;


var
  frmWaveTable     : TfrmWaveTable;
  

implementation

uses unMainWindow, unTimeSerAnal, unGlobUnit, unSparkTable, unAverIm,unHistogram;

{$R *.dfm}


procedure TfrmWaveTable.FormCreate(Sender: TObject);
var
   BegFill : Boolean;
Begin

    frmWaveTable.Position := Vcl.Forms.poScreenCenter;

  With StringGridBig Do Begin
    BigSelMode := 0;
    DelRow.Enabled := False;
    RowBig     := 1;
    Cells[0,0] := 'Row';  {This Goes on Fixed (Gray Cell}
    Cells[1,0] := 'Image'; {Image Number}
    Cells[2,0] := 'X';
    Cells[3,0] := 'Y';
    Cells[4,0] := 'Ampl';
    Cells[5,0] := 'Rise';
    Cells[6,0] := 'Dur';
    Cells[7,0] := 'Decay';
    Cells[8,0] := 'Base';

  End; {With StringGridBig ....}

    BegFill    := True;
    BigTabEmpty:= True;
    frmWaveTable.LoadWaveTable(BegFill);
    StringGridBig.Height := StringGridBig.RowCount*18 + 13;
    frmWaveTable.Height  := StringGridBig.Height + 100;
    StringGridBig.Row    := RowBig;
    cbGetBigEvBase.Checked := MarkTablesPar.GetBigEvBase;
    FilePortion.ItemIndex  := MarkTablesPar.BigEvTimeIndex;
    edBigEvBasePoints.NumberOne := MarkTablesPar.NrPointsBigEvBase;
    edBigEvBaseRange.NumberOne  := MarkTablesPar.BigEvBaseSearchRange;

End;

{***********************************************************************}
procedure TfrmWaveTable.FormResize(Sender: TObject);
begin
    StringGridBig.Height := frmWaveTable.Height - 100;
end;

{***********************************************************************}
Procedure TfrmWaveTable.LoadWaveTable(BegFill : Boolean);
 var  i,ImN   : integer;
Begin
With StringGridBig Do Begin
  For ImN := 0 to NrIm - 1 Do Begin
    If High(MarkBigEvCoor[ImN]) >= 0 Then For i := 0 to High(MarkBigEvCoor[ImN]) Do Begin
       if BegFill = False Then RowCount := RowCount + 1 else
       if BegFill = True  Then Begin
       BegFill     := False;
       BigTabEmpty := False;
       end;
       Cells[0,RowCount-1] := IntToStr(RowCount-1);
       Cells[1,RowCount-1] := IntToStr(ImN + 1); {Image #}
       Cells[2,RowCount-1] := IntToStr(MarkBigEvCoor[ImN,i].X);
       Cells[3,RowCount-1] := IntToStr(MarkBigEvCoor[ImN,i].Y);

       Cells[4,RowCount-1] := FloatToStrF(MarkBigAmpl[ImN,i],ffFixed,5,3);

       //RiseTime
       if (MarkBigEvRise[ImN,i] > CANNOT_BE_DONE) then
       Cells[5,RowCount-1] := FloatToStrF(MarkBigEvRise[ImN,i]*1000,ffFixed,5,3) else
       Cells[5,RowCount-1] := '';
  
       //Duration
       if (MarkBigEvDur[ImN,i].L > CANNOT_BE_DONE) and (MarkBigEvDur[ImN,i].R > CANNOT_BE_DONE) then  //Duration needs Left Time
       Cells[6,RowCount-1] := FloatToStrF((MarkBigEvDur[ImN,i].L+MarkBigEvDur[ImN,i].R)*1000,ffFixed,5,3) else
       if (MarkBigEvDur[ImN,i].L = CANNOT_BE_DONE) or (MarkBigEvDur[ImN,i].R = CANNOT_BE_DONE) then
       Cells[6,RowCount-1] := '-' else
       if (MarkBigEvDur[ImN,i].L = NOT_ANALYZED) or (MarkBigEvDur[ImN,i].R = NOT_ANALYZED) then
       Cells[6,RowCount-1] := '';

       //Decay
       if MarkBigEvDur[ImN,i].R > CANNOT_BE_DONE then  //Decay
       Cells[7,RowCount-1] := FloatToStrF(MarkBigEvDur[ImN,i].R*1000,ffFixed,5,3) else
       if MarkBigEvDur[ImN,i].R = CANNOT_BE_DONE then
       Cells[7,RowCount-1] := '-' else
       if (MarkBigEvDur[ImN,i].L = NOT_ANALYZED) or (MarkBigEvDur[ImN,i].R = NOT_ANALYZED) then
       Cells[7,RowCount-1] := '';

       Cells[8,RowCount-1] := FloatToStrF(MarkBigBase[ImN,i],ffFixed,3,3);
    End; {For Every Image}
  End; {For ImN := 1 to NrIm}
 End; {With StringGridBig ....}  

End; {Procedure LoadWaveTable(BegFill : Boolean);}
{***********************************************************************}
procedure TfrmWaveTable.FilePortionChange(Sender: TObject);
begin
    MarkTablesPar.BigEvTimeIndex := FilePortion.ItemIndex;
end;

procedure TfrmWaveTable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   
    Action          := caFree;
    frmWaveTable    := nil;
end;

{***********************************************************************}
procedure TfrmWaveTable.DelRowClick(Sender: TObject);

Var i, ImN, Xm, Ym, Mpos, R : Integer;
begin

  If (BigTabEmpty = False) then Begin
    ImN := StrToInt(StringGridBig.Cells[1,RowBig]) - 1;
    Xm  := StrToInt(StringGridBig.Cells[2,RowBig]);
    Ym  := StrToInt(StringGridBig.Cells[3,RowBig]);
    For i := 0 to High(MarkBigEvCoor[ImN]) Do Begin
      If (Xm = MarkBigEvCoor[ImN,i].X) then
      if (Ym = MarkBigEvCoor[ImN,i].Y) then Begin
        Mpos := i;
        DelAnyMarkFromMarkArr(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,Mpos,ImN);
        Break;
      End;
    End; {For i := 0 to High(MarkBigEvCoor[ImN])}
    TStringGridHack(StringGridBig).DeleteRow(RowBig);
    If StringGridBig.Cells[0,1] = '' then begin
       BigTabEmpty := True;
    end;

    If BigTabEmpty = False Then Begin
      With StringGridBig Do Begin
        for R := Row to RowCount - 1 do Cells[0,R] := IntToStr(R);
      End;
    End;

    If RowBig > StringGridBig.RowCount-1 then RowBig := StringGridBig.RowCount-1;

    If ImN = CurIm Then Begin
      UpdateMainImage(True);
    End;
    If (frmAverIm <> nil) and (AvImExists > 0) and (MarkPar.ShowBigEvOnAverWin) Then Begin
      UpdateAverImage(True);
    End; {many conditions with AverIm}
  End; {If (SelAnalOrPlay.Down = True) and (BigTabEmpty = False)}
End;

procedure TfrmWaveTable.edBigEvBasePointsReturnPressed(Sender: TObject);
begin
   MarkTablesPar.NrPointsBigEvBase := edBigEvBasePoints.NumberOne;

end;

procedure TfrmWaveTable.edBigEvBaseRangeReturnPressed(Sender: TObject);
begin
   MarkTablesPar.BigEvBaseSearchRange := edBigEvBaseRange.NumberOne;
end;

{***********************************************************************}

Procedure TfrmWaveTable.StringGridBigMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var aCol, aRow : integer;

begin

  If (button = mbLeft) then Begin
    StringGridBig.MouseToCell(x, y, aCol, aRow);
    if (BigSelMode  > 0) and (aRow > 0) and (aCol = 0) then StringGridBig.Invalidate;
  End;
End;

{***********************************************************************}
procedure TfrmWaveTable.EnableMultSelClick(Sender: TObject);
begin
      if EnableMultSel.Down = False then begin
        MultSelArrBigEv := nil;
        BigSelMode  := 0;
        PutBoxes.Enabled := False;
      end else
      if EnableMultSel.Down = True  then begin
        if (frmSparkTable <> nil) then
        if frmSparkTable.EnableMultSel.Down = True then begin
           frmSparkTable.EnableMultSel.Down := False;
           frmSparkTable.EnableMultSelClick(sender);
           frmSparkTable.StringGridSparks.Invalidate;
        end;
        SetLength(MultSelArrBigEv,StringGridBig.RowCount-1);
        RowSelBigEv := 0;
        BigSelMode  := 2; {Multiselect}
        if frmWaveTable.DelRow.Enabled = True then frmWaveTable.DelRow.Enabled := False;
        PutBoxes.Enabled := True;
      end;
      if (sender = frmWaveTable.EnableMultSel) then StringGridBig.Invalidate;

End;
{***********************************************************************}
procedure TfrmWaveTable.StringGridBigDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);

  Begin
  With StringGridBig Do Begin

  If (ACol > 0) and (ARow > 0) then  Begin
    If  (ARow = RowBig) and (BigSelMode < 2) Then  Begin
       if  (BigSelMode = 1) then Canvas.Brush.Color := clRed else
       if  (BigSelMode = 0) then Canvas.Brush.Color := clNavy;
       Canvas.FillRect(Rect);
       Canvas.Font.Color := RGB(255,255,255);
       Canvas.TextOut(Rect.Left+2,Rect.Top+2, Cells[ACol,ARow]);
    End else
    If BigSelMode in [2,3] then Begin
      if MultSelArrBigEv[ARow-1] > 0 then begin
        if (BigSelMode = 2) then begin
          Canvas.Brush.Color := clTeal;
          Canvas.Font.Color := RGB(255,255,255);
        end else
        if (BigSelMode = 3) then begin
          Canvas.Brush.Color := ROIvar.ROICol [MultSelArrBigEv[ARow-1]];
          Canvas.Font.Color  := ROIvar.FontCol[MultSelArrBigEv[ARow-1]];
        end;
        Canvas.FillRect(Rect);
        if Canvas.Brush.Color = clWhite then Begin
           Canvas.Pen.Color   := clBlack;
           Canvas.Pen.Width   := 2;
           Canvas.Rectangle(Rect);
        end;
      end else
      if MultSelArrBigEv[ARow-1] = 0 then begin
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(Rect);
        Canvas.Font.Color := RGB(0,0,0);
      end;
        Canvas.Brush.Style := bsClear;
        Canvas.TextOut(Rect.Left+2,Rect.Top+2, Cells[ACol,ARow]);
    End; {If (BigSelMode = 2) }
  End; {If (ACol > 0) and (ARow > 0) then  Begin}

  End; {with}
End;   {procedure TfrmWaveTable.StringGridBigDrawCell}
{***********************************************************************}

procedure TfrmWaveTable.cbGetBigEvBaseClick(Sender: TObject);
begin
     MarkTablesPar.GetBigEvBase := cbGetBigEvBase.Checked;
end;

procedure TfrmWaveTable.DelAllMarksClick(Sender: TObject);

  var ImN : Integer;
      DoRefreshImage : Boolean;
begin
      If BigTabEmpty = False Then Begin
         if High(MarkBigEvCoor[CurIm]) >= 0 then DoRefreshImage := True
         else DoRefreshImage := False;
         if EnableMultSel.Down = True then Begin
          EnableMultSel.Down := False;
          frmWaveTable.EnableMultSelClick(Sender);
         end;
          BigSelMode := 0;
         with StringGridBig do begin
          RowCount := 2;
          Cells[0,1] := '';  {This Goes on Fixed (Gray Cell}
          Cells[1,1] := ''; {Image Number}
          Cells[2,1] := '';
          Cells[3,1] := '';
          Cells[4,1] := '';
          Cells[5,1] := '';
          Cells[6,1] := '';
          Cells[7,1] := '';
          Cells[8,1] := '';
         end;
         For ImN := 0 to NrIm - 1 Do Begin
           If High(MarkBigEvCoor[ImN]) >= 0 Then Begin
              SetLength(MarkBigEvCoor  [ImN],0);
              SetLength(MarkBigAmpl[ImN],0);
              SetLength(MarkBigBase[ImN],0);
              SetLength(MarkBigEvDur[ImN],0);
           End;
         End;
         BigTabEmpty := True;
            {Refreshes Main Window}
         If DoRefreshImage = True Then Begin
          UpdateMainImage(True);
         End;
            {Refreshes Aver Window}
         If (frmAverIm <> nil) and (AvImExists > 0) and (MarkPar.ShowBigEvOnAverWin) Then Begin
            UpdateAverImage(True);
         End; {many conditions with AverIm}

      End; {If SpTabEmpty = False}
End;

{***********************************************************************}
procedure TfrmWaveTable.RecalculateBigEvClick(Sender: TObject);
var  CntIm,M       : Integer;
Begin

  If (MainImLoaded = True) and (NrIm > 1) Then Begin

    Screen.Cursor := crHourGlass;

    if (Not(MarkTablesPar.GetBigEvBase)) or Not(RatioOn) then begin
      if Not(RatioOn) then MessageDlg('It has to be in F/Fo mode to get F/Fo amplitude, Rise time, Duration and Decay', mtInformation, [mbOK], 0);
      RecalculateMeanforMark(MarkBigEvCoor,MarkBigAmpl);
    end;

    If (RatioOn) then Begin
      if (MarkTablesPar.GetBigEvBase) then
      GetMarksBaselines(MarkBigEvCoor,MarkBigAmpl, MarkBigBase,MarkTablesPar.NrPointsBigEvBase,MarkTablesPar.BigEvBaseSearchRange)
      else if Not(MarkTablesPar.GetBigEvBase) then begin
      for CntIm := 0 to High(MarkBigBase) do begin
        if High(MarkBigBase[CntIm]) >= 0 then
          for M := 0 to High(MarkBigBase[CntIm])do begin
            MarkBigBase[CntIm,M] := 1;
          end;
        end;
      end;
        GetDurForMark(MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,MarkTablesPar.NrPointsBigEvBase,MarkTablesPar.BigEvBaseSearchRange);
    End; //if (RatioOn) then begin

      RefillStringGridEvents(StringGridBig, MarkBigEvCoor,MarkBigAmpl,MarkBigEvDur,MarkBigEvRise,MarkBigBase);
      Screen.Cursor := crDefault;


     {refreshes All the Buffers with Current Image}
        ReadImage(CurIm,0,pImData);
      If (RatioOn = True) Then Begin
        if SmoothMode > NO_SMOOTH then ApplySmoothing;
      End; { (RatioOn = True)}

  End; { If (MainImLoaded = True) and (NrIm > 1) Then Begin}
End;

procedure TfrmWaveTable.sbSentBigEvToHistogramsClick(Sender: TObject);
begin
  if (frmTimeHistograms <> nil) then begin
    if (frmTimeHistograms.rbMarks.Checked) then
    frmTimeHistograms.GetEventsFromMarkTable(Sender);
  end;
end;  //procedure TfrmWaveTable.RecalculateBigEvClick//

 {*************************************************************************}
procedure TfrmWaveTable.StringGridBigMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var aCol,aRow : integer;
      CellNr : TRect;
      i    : integer;
      RowMem : integer;
      Contens : AnsiString;
      FRowSel : Integer;
      Fr,Er,R   : Integer;
Begin

  With StringGridBig Do Begin

     MouseToCell(x, y, aCol, aRow);
    If (aRow > 0) Then Begin
        RowMem  := RowBig;
        RowBig   := aRow;
        Row := RowBig;
      {-----------------------------------}
      If ((aCol = 0) and (button = mbLeft)) or (button = mbRight) then Begin
           if BigSelMode = 3 then BigSelMode := 2;
       If (BigSelMode = 2) Then Begin
          If (Not(ssShift in Shift) and Not(ssCtrl in Shift)) or (RowSelBigEv = 0) Then Begin
            if MultSelArrBigEv[RowBig-1] > 0 then begin
              MultSelArrBigEv[RowBig-1] := 0;
              Dec(RowSelBigEv);
            end else
            if MultSelArrBigEv[RowBig-1] = 0 then begin
              if RowSelBigEv < 20 then begin
                MultSelArrBigEv[RowBig-1] := 1;
                Inc(RowSelBigEv);
              end;
            end;
          End Else
          If (ssShift in Shift) and (RowSelBigEv > 0) Then Begin
            for i := 0 to High(MultSelArrBigEv) do begin
              if MultSelArrBigEv[i] > 0 then begin
                FRowSel := i;
                Break;
              end;
            end; {for}
            if FRowSel <= RowBig - 1 then begin
              Fr := FRowSel;
              Er := RowBig - 1;
              if Er - Fr + 1 > 20 Then Er := Fr + 20 - 1;
              RowSelBigEv := Er - Fr + 1;
            end else
            if FRowSel > RowBig -1 then begin
              Fr := RowBig -1;
              Er := FRowSel;
              if Er - Fr + 1 > 20 Then Fr := Er - 20 + 1;
              RowSelBigEv := Er - Fr + 1;
            end;
            for i := 0 to High(MultSelArrBigEv) do MultSelArrBigEv[i] := 0;  {Zeroes}
            for i := Fr to Er do MultSelArrBigEv[i] := 1;
          End Else {(ssShift in Shift) and (RowSelBigEv > 0) }
          If (ssCtrl in Shift) and (RowSelBigEv > 0) Then Begin
            Canvas.Brush.Color := clWhite;
            Canvas.Font.Color := RGB(0,0,0);
            For R := TopRow to TopRow + VisibleRowCount Do Begin
              If (MultSelArrBigEv[R-1] > 0) then
                for i := 1 to ColCount -1 Do Begin
                  Contens := Cells[i, R];
                  Canvas.FillRect(CellRect(i, R));
                  Canvas.TextOut(CellRect(i, R).Left+ 2,
                  CellRect(i, R).Top+ 2,Contens);
              End; {(MultSelArrBigEv[R-1] > 0) then For....}
            End; { For R := TopRow to TopRow + VisibleRowCount}
            for i := 0 to High(MultSelArrBigEv) do MultSelArrBigEv[i] := 0;
            MultSelArrBigEv[RowBig-1] := 1;
            RowSelBigEv := 1;
          End; {If (ssCtrl in Shift) and (RowSelBigEv > 0)}
       End; {If (BigSelMode = 2)}

            {Redrows in White Previous Row}
       If BigSelMode <> 2 Then Begin  {deletes Previous Highlight}
        If (RowMem >= TopRow) and
            (RowMem <= TopRow + VisibleRowCount) then Begin
        Canvas.Brush.Color := clWhite;
        Canvas.Font.Color := RGB(0,0,0);
          For i := 1 to ColCount -1 Do Begin
            Contens := Cells[i, RowMem];
            Canvas.FillRect(CellRect(i, RowMem));
            Canvas.TextOut(CellRect(i, RowMem).Left+ 2,
            CellRect(i, RowMem).Top+ 2,Contens);
          End;
        End; {if Row is Visible}
       End;
          { End of Redrows in White Previous Row}


        CellNr := CellRect(aCol, RowBig);
         {Make 3D effect}
        DrawEdge(Canvas.Handle, CellNr, EDGE_SUNKEN, BF_RECT or BF_SOFT);
        if BigSelMode <> 2 then Begin
          Canvas.Brush.Color := clRed;
          Canvas.Font.Color := RGB(255,255,255);
        end else
        if BigSelMode = 2 then Begin
          if MultSelArrBigEv[RowBig-1] > 0 then begin
            Canvas.Brush.Color := clTeal;
            Canvas.Font.Color := RGB(255,255,255);
          end else
          if MultSelArrBigEv[RowBig-1] = 0 then begin
            Canvas.Brush.Color := clWhite;
            Canvas.Font.Color := RGB(0,0,0);
          end;
        End;
        {If (BigSelMode <> 2) Then}
        For i := 1 to ColCount -1 Do Begin
         Contens := Cells[i, RowBig];
         Canvas.FillRect(CellRect(i, RowBig));
         Canvas.TextOut(CellRect(i, RowBig).Left+ 2,
         CellRect(i, RowBig).Top+ 2, Contens);
        End;

        If (BigSelMode = 2) and (ssShift in Shift) and (RowSelBigEv > 0) Then Begin
          For R := TopRow to TopRow + VisibleRowCount Do Begin
            For i := 1 to ColCount -1 Do Begin
             If (R >= Fr+1) and (R <= Er+1) then Begin
              Contens := Cells[i, R];
              Canvas.FillRect(CellRect(i, R));
              Canvas.TextOut(CellRect(i, R).Left+ 2,
              CellRect(i, R).Top+ 2, Contens);
            End; {Visible}
           End; {For i := 1 to StringGridSparks.ColCount -1}
          End; { For R := Fr+1 to Er+1 }
        End; { If (BigSelMode = 2) and (ssShift in Shift) and (RowSelBigEv > 0)}


        if BigSelMode < 2 then BigSelMode  := 1;  {One Row Sel}
        if BigSelMode  = 1 then DelRow.Enabled := True;
        
      End Else

      {Puts a Box and Analyses One Row}
      If (acol  > 0) and (BigSelMode  < 2) and (button = mbLeft) then Begin
        BigSelMode    := 0;
        Invalidate;
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;
        if DelRow.Enabled = True then DelRow.Enabled := False;
        Enabled := False;
        DoOneRowAnal(StringGridBig,MarkBigEvCoor,MarkBigEvDur,MarkBigBase,BigTabEmpty,RowBig,FilePortion.ItemIndex);
        Enabled := True;
        Screen.Cursor := crDefault;
      end; {if (acol  > 0)}
    End; {If (arow > 0)}
 End; {With StringGridSparks Do Begin}

End; {procedure TfrmWaveTable.StringGridBigMouseDown}


procedure TfrmWaveTable.PutBoxesClick(Sender: TObject);

Var i : Integer;

Begin

  If RowSelBigEv > 0 Then Begin
    {Deletes}
    If ROIvar.NrROI > 0 then
    For i := 1 to 20 Do Begin
      ROIvar.ROIAdr[i] := 0;  {Zeroes Out the Array=No Selections}
      FhPol[i] := nil;
      FhTbl[i] := nil;
    End;
    {End deletion}
    {Puts New}
    PutBoxesOnMarks(StringGridBig,MultSelArrBigEv,RowSelBigEv);
    {Main Image}
      UpdateMainImage(True);
    {Average Image}
     If (frmAverIm <> nil) and (AvImExists > 0) and
         (ROIvar.ROIonAverWin = True) Then Begin
         UpdateAverImage(True);
     End;

    BigSelMode := 3;
    StringGridBig.Invalidate;
  End;

End; {procedure TfrmWaveTable.PutBoxesClick}

END.