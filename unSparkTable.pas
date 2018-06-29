{$D-,L-,O+,Q-,R-,Y-,S-}
unit unSparkTable;  {Stores Small Events}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Buttons, EditNumerical, Vcl.Menus, unGlobUnit;


 function GetPeaksForArea(var PlotData : TDynDoubleArray) : Double; inline;

type

  TfrmSparkTable = class(TForm)
    StringGridSparks: TStringGrid;
    EnableMultSel: TSpeedButton;
    DelAllMarks: TSpeedButton;
    DelRaw: TSpeedButton;
    RecalculateSmallEv: TSpeedButton;
    FilePortion: TComboBox;
    PutBoxes: TSpeedButton;
    cbGetSmEvBase: TCheckBox;
    edSmEvBasePoints: TEditNumerical;
    edSmEvBaseRange: TEditNumerical;
    Label5: TLabel;
    Label3: TLabel;
    sbSentSmEvToHistograms: TSpeedButton;
    sbGetTracesFromAllMarks: TSpeedButton;
    SaveTracesFileDialog: TSaveDialog;
    cbGetAreas: TCheckBox;
    enThresholdForAreas: TEditNumerical;
    PopupMenuTag: TPopupMenu;
    Tag1: TMenuItem;
    Cancel: TMenuItem;
    tag2: TMenuItem;
    tag3: TMenuItem;
    ClearAll: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    ClearThisRow: TMenuItem;
    procedure cbGetSmEvBaseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGridSparksMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DelRawClick(Sender: TObject);
    procedure EnableMultSelClick(Sender: TObject);
    procedure StringGridSparksDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DelAllMarksClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure RecalculateSmallEvClick(Sender: TObject);
    procedure StringGridSparksMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PutBoxesClick(Sender: TObject);
    procedure FilePortionChange(Sender: TObject);
    procedure edSmEvBasePointsReturnPressed(Sender: TObject);
    procedure edSmEvBaseRangeReturnPressed(Sender: TObject);
    procedure sbSentSmEvToHistogramsClick(Sender: TObject);
    procedure sbGetTracesFromAllMarksClick(Sender: TObject);
    procedure Tag1Click(Sender: TObject);
    procedure tag2Click(Sender: TObject);
    procedure tag3Click(Sender: TObject);
    procedure ClearAllClick(Sender: TObject);
    procedure enThresholdForAreasReturnPressed(Sender: TObject);
    procedure ClearThisRowClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
  private
    { Private declarations }
    MultSelArrSmEv : Array of Word;
    RowSelSmEv     : Word; {Selected Rows}
    SmSelMode      : Byte;  {0 = No Sel Mode; 1 = One Row Sel; 2 = Multiple Selections}
                            {3 = Multple Selection & Draws Each cell in ROI color,
                             3 is activated by PutBoxes and Returned to 2 With Sel}

    procedure SetTagSelected(Sender: TObject);

  public
    { Public declarations }
    {variables announced here are Killed Automatically after the form is closed}
   RowSm    :  Integer; {Means Row Small; The Row to Be Manipulated and Focused}
   RowRMB   : Integer;  //means hit by the right mouse button

   Procedure LoadSparkTable(BegFill : Boolean);

  END;


var
  frmSparkTable : TfrmSparkTable;
  TagArray : Array of string;
  PeakThreshold : Double;

implementation

uses unMainWindow, unTimeSerAnal, unAverIm, unWaveTable, unHistogram,
  unImageControl, unFunctions, Main;

{$R *.dfm}

{****************************************************************************}
procedure TfrmSparkTable.FormCreate(Sender: TObject);
var
  BegFill : Boolean;
  i : Integer;
Begin

    frmSparkTable.Position := poScreenCenter;

  With StringGridSparks Do Begin
    SmSelMode  := 0;
    DelRaw.Enabled := False;
    enThresholdForAreas.NumberFloat := PeakThreshold;

    RowSm      := 1;
    Cells[0,0] := 'Row';  {This Goes on Fixed (Gray Cell}
    Cells[1,0] := 'Image'; {Image Number}
    Cells[2,0] := 'X';
    Cells[3,0] := 'Y';
    Cells[4,0] := 'Ampl';
    Cells[5,0] := 'Rise';
    Cells[6,0] := 'Dur';
    Cells[7,0] := 'Decay';
    Cells[8,0] := 'Base';
    Cells[9,0] := 'Tag';

    for i := 0 to High(TagArray) do begin
      StringGridSparks.Cells[9,i+1] := TagArray[i];
    end;

  End; {With StringGridSparks ....}

    BegFill    := True;
    SpTabEmpty := True;

    LoadSparkTable(BegFill);
    StringGridSparks.Height := StringGridSparks.RowCount*18 + 13;
    frmSparkTable.Height    := StringGridSparks.Height + 128;
    StringGridSparks.Row := RowSm;
    cbGetSmEvBase.Checked := MarkTablesPar.GetSmEvBase;
    FilePortion.ItemIndex := MarkTablesPar.SmEvTimeIndex;
    edSmEvBasePoints.NumberOne := MarkTablesPar.NrPointsSmEvBase;
    edSmEvBaseRange.NumberOne  := MarkTablesPar.SmEvBaseSearchRange;

End;

{****************************************************************************}
procedure TfrmSparkTable.FormResize(Sender: TObject);
begin

      StringGridSparks.Height := frmSparkTable.Height - 100;

end;
{****************************************************************************}

Procedure TfrmSparkTable.LoadSparkTable(BegFill : Boolean);
 var i,ImN   : integer;
Begin


 With StringGridSparks Do Begin
  For ImN := 0 to NrIm - 1 Do Begin
    If High(MarkSmEvCoor[ImN]) >= 0 Then For i := 0 to High(MarkSmEvCoor[ImN]) Do Begin
       if BegFill = False Then RowCount := RowCount + 1 else
       if BegFill = True  Then Begin
       BegFill    := False;
       SpTabEmpty := False;                          
       end;
       Cells[0,RowCount-1] := IntToStr(RowCount-1);
       Cells[1,RowCount-1] := IntToStr(ImN + 1); {Image #}
       Cells[2,RowCount-1] := IntToStr(MarkSmEvCoor[ImN,i].X);
       Cells[3,RowCount-1] := IntToStr(MarkSmEvCoor[ImN,i].Y);
       
       Cells[4,RowCount-1] := FloatToStrF(MarkSmAmpl[ImN,i],ffFixed,8,3);

       //RiseTime
       if (MarkSmEvRise[ImN,i] > CANNOT_BE_DONE) then
       Cells[5,RowCount-1] := FloatToStrF(MarkSmEvRise[ImN,i]*1000,ffFixed,8,3) else
       Cells[5,RowCount-1] := '';
    
       //Duration
       if (MarkSmEvDur[ImN,i].L > CANNOT_BE_DONE) and (MarkSmEvDur[ImN,i].R > CANNOT_BE_DONE) then  //Duration needs Left Time
       Cells[6,RowCount-1] := FloatToStrF((MarkSmEvDur[ImN,i].L+MarkSmEvDur[ImN,i].R)*1000,ffFixed,8,3) else
       if (MarkSmEvDur[ImN,i].L = CANNOT_BE_DONE) or (MarkSmEvDur[ImN,i].R = CANNOT_BE_DONE) then
       Cells[6,RowCount-1] := '-' else
       if (MarkSmEvDur[ImN,i].L = NOT_ANALYZED) or (MarkSmEvDur[ImN,i].R = NOT_ANALYZED) then
       Cells[6,RowCount-1] := '';

       //Decay
       if MarkSmEvDur[ImN,i].R > CANNOT_BE_DONE then  //Decay
       Cells[7,RowCount-1] := FloatToStrF(MarkSmEvDur[ImN,i].R*1000,ffFixed,8,3) else
       if MarkSmEvDur[ImN,i].R = CANNOT_BE_DONE then
       Cells[7,RowCount-1] := '-' else
       if (MarkSmEvDur[ImN,i].L = NOT_ANALYZED) or (MarkSmEvDur[ImN,i].R = NOT_ANALYZED) then
       Cells[7,RowCount-1] := '';

       if (RatioOn) or (ChannelsRatioOn) then
       Cells[8,RowCount-1] := FloatToStrF(MarkSmBase[ImN,i],ffFixed,8,3);

    End; {For Every Image}
  End; {For ImN := 1 to NrIm}

  for i := 0 to High(TagArray) do begin
    StringGridSparks.Cells[9,i+1] := TagArray[i];
  end;
 End; {With}


End; {Procedure LoadSparkTable(BegFill : Boolean);}
{****************************************************************************}

procedure TfrmSparkTable.FilePortionChange(Sender: TObject);
begin
    MarkTablesPar.SmEvTimeIndex := FilePortion.ItemIndex; 
end;

procedure TfrmSparkTable.FormClose(Sender: TObject; var Action: TCloseAction);
var i : Integer;
begin
     SetLength(TagArray,StringGridSparks.RowCount-1);
     for i := 0 to High(TagArray) do begin
      TagArray[i] := StringGridSparks.Cells[9,i+1];
     end;

     Action         := caFree;
     frmSparkTable  := nil;
end;
{****************************************************************************}
procedure TfrmSparkTable.DelRawClick(Sender: TObject);
Var i, Xm,Ym, ImN, Mpos, R : integer;
begin


  If (SpTabEmpty = False) then Begin
    ImN := StrToInt(StringGridSparks.Cells[1,RowSm]) - 1;
    Xm  := StrToInt(StringGridSparks.Cells[2,RowSm]);
    Ym  := StrToInt(StringGridSparks.Cells[3,RowSm]);
    For i := 0 to High(MarkSmEvCoor[ImN]) Do Begin
      If (Xm = MarkSmEvCoor[ImN,i].X) then
      if (Ym = MarkSmEvCoor[ImN,i].Y) then Begin
        Mpos := i;
        DelAnyMarkFromMarkArr(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,Mpos,ImN);
        Break;
      End;
    End; {For i := 0 to High(MarkSmEvCoorCoor[ImN])}

    TStringGridHack(StringGridSparks).DeleteRow(RowSm);
    If StringGridSparks.Cells[0,1] = '' then begin
       SpTabEmpty := True;
    end;

    If SpTabEmpty = False Then Begin
      With StringGridSparks Do Begin
        for R := Row to RowCount - 1 do Cells[0,R] := IntToStr(R);
      End;
    End;

    If RowSm > StringGridSparks.RowCount-1 then RowSm := StringGridSparks.RowCount-1;

    If ImN = CurIm Then Begin
      UpdateMainImage(True);
    End;
{Refreshes Aver Window}
    If (frmAverIm <> nil) and (AvImExists > 0) and (MarkPar.ShowSmEvOnAverWin) Then Begin
       UpdateAverImage(True);
    End; {many conditions with AverIm}
  End; {If SelAnalOrPlay.Down}
End;

procedure TfrmSparkTable.edSmEvBasePointsReturnPressed(Sender: TObject);
begin
   MarkTablesPar.NrPointsSmEvBase := edSmEvBasePoints.NumberOne;
end;

procedure TfrmSparkTable.edSmEvBaseRangeReturnPressed(Sender: TObject);
begin
   MarkTablesPar.SmEvBaseSearchRange := edSmEvBaseRange.NumberOne;
end;

{****************************************************************************}


Procedure TfrmSparkTable.StringGridSparksMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var aRow, aCol : Integer;
begin
  If (button = mbLeft) then Begin
    StringGridSparks.MouseToCell(x, y, aCol, aRow);
    if (SmSelMode  > 0) and (aRow > 0) and (aCol = 0) then StringGridSparks.Invalidate;
  End;
End;{Procedure TfrmSparkTable.StringGridSparksMouseUp}
 {****************************************************************************}

procedure TfrmSparkTable.Tag1Click(Sender: TObject);
begin
   if (RowSelSmEv = 0) and (SmSelMode <> 2) then
   StringGridSparks.Cells[9,RowRMB] := 'A' else
   if (RowSelSmEv > 0) and (SmSelMode = 2) then // (SmSelMode = 2 = Multiselect
   SetTagSelected(Sender);
   if (SmSelMode = 2) then RowRMB := 0;
   {SmSelMode: 0 = regular, 1 = delete, 2 = selection}
end;

procedure TfrmSparkTable.tag2Click(Sender: TObject);
begin
   if (RowSelSmEv = 0) and (SmSelMode <> 2) then
   StringGridSparks.Cells[9,RowRMB] := 'C' else
   if (RowSelSmEv > 0) and (SmSelMode = 2) then
   SetTagSelected(Sender);
   if (SmSelMode = 2) then RowRMB := 0;
end;

procedure TfrmSparkTable.tag3Click(Sender: TObject);
begin
   if (RowSelSmEv = 0) and (SmSelMode <> 2) then
   StringGridSparks.Cells[9,RowRMB] := 'V' else
   if (RowSelSmEv > 0) and (SmSelMode = 2) then
   SetTagSelected(Sender);
   if (SmSelMode = 2) then RowRMB := 0;
end;

procedure TfrmSparkTable.ClearThisRowClick(Sender: TObject);
begin
  StringGridSparks.Cells[9,RowRMB] := '';
  RowRMB := 0;
  StringGridSparks.Invalidate;
end;

procedure TfrmSparkTable.ClearAllClick(Sender: TObject);
var i : Integer;
begin
  RowRMB := 0;
  for i := 1 to StringGridSparks.RowCount-1 do
  StringGridSparks.Cells[9,i] := '';
  StringGridSparks.Invalidate;
end;

procedure TfrmSparkTable.CancelClick(Sender: TObject);
begin
  RowRMB := 0;
  StringGridSparks.Invalidate;
end;


procedure TfrmSparkTable.SetTagSelected(Sender: TObject);
var i,R : Integer;
    TagIt : Boolean;
begin

   TagIt := False;
   for i := 0 to High(MultSelArrSmEv) do begin
     if (MultSelArrSmEv[i] > 0) and (i = RowRMB-1) then begin
      TagIt := True;
      Break;
     end;
   end;

  If (TagIt) Then begin
    i := 0;
    For R := 1 to StringGridSparks.RowCount Do Begin
     { Creates And Positions a Box on Address 20 }
      If MultSelArrSmEv[R - 1] > 0 Then Begin
        MultSelArrSmEv[R - 1] := i + 1;
        if (Sender = Tag1) then StringGridSparks.Cells[9, R] := 'A' else
        if (Sender = Tag2) then StringGridSparks.Cells[9, R] := 'C' else
        if (Sender = Tag3) then StringGridSparks.Cells[9, R] := 'V';
        Inc(i);
      End; { If MarkSelArr[i-1] = 1 }
    End; // For R := 1 to StringGridSparks.RowCount Do Begin
  End;  // if (TagIt) Then begin

End;  //procedure TfrmSparkTable.SetTagSelected(Sender: TObject);

{******************************************************************************}

procedure TfrmSparkTable.EnableMultSelClick(Sender: TObject);
begin
      if (EnableMultSel.Down = False) then begin
        MultSelArrSmEv := nil;
        SmSelMode  := 0;
        RowSelSmEv := 0;
        PutBoxes.Enabled := False;
      end
        else
      if (EnableMultSel.Down = True)  then begin
        if (frmWaveTable <> nil) then
        if frmWaveTable.EnableMultSel.Down = True then begin
           frmWaveTable.EnableMultSel.Down := False;
           frmWaveTable.EnableMultSelClick(sender);
           frmWaveTable.StringGridBig.Invalidate;
        end;
        SetLength(MultSelArrSmEv,StringGridSparks.RowCount-1);
        RowSelSmEv := 0;
        SmSelMode  := 2; {Multiselect}
        if frmSparkTable.DelRaw.Enabled = True then frmSparkTable.DelRaw.Enabled := False;
        PutBoxes.Enabled := True;
      end;
      if (sender = frmSparkTable.EnableMultSel) then StringGridSparks.Invalidate;
End;
procedure TfrmSparkTable.enThresholdForAreasReturnPressed(Sender: TObject);
begin
  PeakThreshold := enThresholdForAreas.NumberFloat;
end;

{******************************************************************************}

procedure TfrmSparkTable.StringGridSparksDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);  {Changes Highlight Color}

 { Const  clPaleGreen = TColor($CCFFCC);
  clPaleRed =   TColor($CCCCFF);}
 
  Begin
 { if gdselected in State then  begin
   if gdFocused in State then  begin}

  With StringGridSparks Do Begin

  If (ACol > 0) and (ARow > 0) then  Begin

    If  (ARow = RowSm) and (SmSelMode < 2) Then  Begin
       if  (SmSelMode = 1) then Canvas.Brush.Color := clRed else
       if  (SmSelMode = 0) then Canvas.Brush.Color := clNavy;
       Canvas.FillRect(Rect);
       Canvas.Font.Color := RGB(255,255,255);
       Canvas.TextOut(Rect.Left+2,Rect.Top+2, Cells[ACol,ARow]);
    End
      Else
    If SmSelMode in [2,3] then Begin    
      if (MultSelArrSmEv[ARow-1] > 0) then begin
        if (SmSelMode = 2) then begin
          Canvas.Brush.Color := clTeal;
          Canvas.Font.Color := RGB(255,255,255);
        end else
        if (SmSelMode = 3) then begin
          Canvas.Brush.Color := ROIvar.ROICol[MultSelArrSmEv[ARow-1]];
          Canvas.Font.Color  := ROIvar.FontCol[MultSelArrSmEv[ARow-1]];
        end;
        Canvas.FillRect(Rect);
        if Canvas.Brush.Color = clWhite then Begin
           Canvas.Pen.Color   := clBlack;
           Canvas.Pen.Width   := 2;
           Canvas.Rectangle(Rect);
        end;
      end //if (MultSelArrSmEv[ARow-1] > 0) then begin
        else
      if MultSelArrSmEv[ARow-1] = 0 then begin
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(Rect);
        Canvas.Font.Color := RGB(0,0,0);
      end;
        Canvas.Brush.Style := bsClear;
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
    End; //If (SmSelMode = 2)

    If  (ARow = RowRMB) and (SmSelMode < 2) Then  Begin
     Canvas.Brush.Color := clYellow;
     Canvas.FillRect(Rect);
     Canvas.Font.Color := RGB(0,0,0);
     Canvas.TextOut(Rect.Left+2,Rect.Top+2, Cells[ACol,ARow]);
    End;

  End; //If (ACol > 0) and (ARow > 0) then  Begin//

 End; //With
End;  {procedure TfrmSparkTable.StringGridSparksDrawCell}
{*****************************************************************************}

Procedure TfrmSparkTable.StringGridSparksMouseDown(Sender: TObject;
                      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  var aCol,aRow : integer;
      CellNr : TRect;
      i    : integer;
      RowMem : integer;
      Contens : AnsiString;
      FRowSel : Integer;
      Fr,Er,R : Integer;
                                               {ssCtrl in Shift}
Begin


  With StringGridSparks Do Begin

        MouseToCell(x, y, aCol, aRow);

    If (aRow > 0) Then Begin
      If (button = mbRight) {and not(BlockRowRMBUpdate)} then Begin
        RowRMB := aRow;
        if  (SmSelMode in[0,1]) then begin
          RowSm := RowRMB;  //to make it yellow
          SmSelMode := 0;
          Invalidate;
          PopupMenuTag.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
        end
          else
        if  (SmSelMode = 2) and (MultSelArrSmEv[aRow - 1] > 0) then begin
          PopupMenuTag.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
        end
          else
        if  (SmSelMode = 2) and (MultSelArrSmEv[aRow - 1] = 0) then begin
          RowRMB := 0;
        end;
      End
        else
      If (button = mbLeft) then Begin
        RowMem := RowSm;
        RowSm  := aRow;
        Row    := RowSm;
        RowRMB := 0;
      End;

      If (button = mbLeft) then Begin

       {-----------------------------------}
        If (aCol = 0) then Begin

          if SmSelMode = 3 then SmSelMode := 2;
          If (SmSelMode = 2) Then Begin
            If (Not(ssShift in Shift) and Not(ssCtrl in Shift)) or (RowSelSmEv = 0) Then Begin
              if MultSelArrSmEv[RowSm-1] > 0 then begin
                MultSelArrSmEv[RowSm-1] := 0;
                Dec(RowSelSmEv);
              end else
            if MultSelArrSmEv[RowSm-1] = 0 then begin
              if RowSelSmEv < 20 then begin
                MultSelArrSmEv[RowSm-1] := 1;
                Inc(RowSelSmEv);
              end;
            end;
            End Else
            If (ssShift in Shift) and (RowSelSmEv > 0) Then Begin
              for i := 0 to High(MultSelArrSmEv) do begin
                if MultSelArrSmEv[i] > 0 then begin
                  FRowSel := i;
                  Break;
                end;
              end; {for}
              if FRowSel <= RowSm - 1 then begin
                Fr := FRowSel;
                Er := RowSm - 1;
                if Er - Fr + 1 > 20 Then Er := Fr + 20 - 1;
                RowSelSmEv := Er - Fr + 1;
              end else
              if FRowSel > RowSm -1 then begin
                Fr := RowSm -1;
                Er := FRowSel;
                if Er - Fr + 1 > 20 Then Fr := Er - 20 + 1;
                RowSelSmEv := Er - Fr + 1;
              end;
              for i := 0 to High(MultSelArrSmEv) do MultSelArrSmEv[i] := 0;  {Zeroes}
              for i := Fr to Er do MultSelArrSmEv[i] := 1;
            End Else {(ssShift in Shift) and (RowSelSmEv > 0) }
            If (ssCtrl in Shift) and (RowSelSmEv > 0) Then Begin
              Canvas.Brush.Color := clWhite;
              Canvas.Font.Color := RGB(0,0,0);
              For R := TopRow to TopRow + VisibleRowCount Do Begin
                If (MultSelArrSmEv[R-1] > 0) then
                  for i := 1 to ColCount -1 Do Begin
                    Contens := Cells[i, R];
                    Canvas.FillRect(CellRect(i, R));
                    Canvas.TextOut(CellRect(i, R).Left+ 2,
                    CellRect(i, R).Top+ 2,Contens);
                End; {(MultSelArrSmEv[R-1] > 0) then For....}
              End; { For R := TopRow to TopRow + VisibleRowCount}
              for i := 0 to High(MultSelArrSmEv) do MultSelArrSmEv[i] := 0;
              MultSelArrSmEv[RowSm-1] := 1;
              RowSelSmEv := 1;
            End; {If (ssCtrl in Shift) and (RowSelSmEv > 0)}
          End; {If (SmSelMode = 2)}

            {Redrows in White Previous Row}
          If (SmSelMode <> 2) Then Begin  {deletes Previous Highlight}
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

          CellNr := CellRect(aCol, RowSm);
          {Make 3D effect}
          DrawEdge(Canvas.Handle, CellNr, EDGE_SUNKEN, BF_RECT or BF_SOFT);
          if (SmSelMode <> 2) then Begin
            Canvas.Brush.Color := clRed;
            Canvas.Font.Color := RGB(255,255,255);
          end else
          if SmSelMode = 2 then Begin
            if MultSelArrSmEv[RowSm-1] > 0 then begin
              Canvas.Brush.Color := clTeal;
              Canvas.Font.Color := RGB(255,255,255);
            end else
          if MultSelArrSmEv[RowSm-1] = 0 then begin
            Canvas.Brush.Color := clWhite;
            Canvas.Font.Color := RGB(0,0,0);
          end;
        End;  {If (SmSelMode <> 2) Then}
        For i := 1 to ColCount -1 Do Begin
         Contens := Cells[i, RowSm];
         Canvas.FillRect(CellRect(i, RowSm));
         Canvas.TextOut(CellRect(i, RowSm).Left+ 2,
         CellRect(i, RowSm).Top+ 2, Contens);
        End;

        If (SmSelMode = 2) and (ssShift in Shift) and (RowSelSmEv > 0) Then Begin
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
        End; { If (SmSelMode = 2) and (ssShift in Shift) and (RowSelSmEv > 0)}

        if SmSelMode  < 2 then SmSelMode  := 1;  {One Row Sel}
        if SmSelMode  = 1 then DelRaw.Enabled := True;
        
      End  //If (aCol = 0)  then Begin

        Else

      {Puts a Box and Analyses One Row}
      If (acol  > 0) and (SmSelMode  < 2) then Begin
        SmSelMode    := 0;
        Invalidate;
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;
        if DelRaw.Enabled = True then DelRaw.Enabled := False;
        Enabled := False;
        DoOneRowAnal(StringGridSparks,MarkSmEvCoor,MarkSmEvDur,MarkSmBase,SpTabEmpty,RowSm,FilePortion.ItemIndex);
        Enabled := True;
        Screen.Cursor := crDefault;
      end; {if (acol  > 0)}


    End; //If (button = mbLeft) then Begin


    End; {If (arow > 0)}
 End; {With StringGridSparks Do Begin}


End;

{procedure TfrmSparkTable.StringGridSparksMouseDown}
 {********************************************************************************}

procedure TfrmSparkTable.cbGetSmEvBaseClick(Sender: TObject);
begin
  MarkTablesPar.GetSmEvBase := cbGetSmEvBase.Checked;
end;

procedure TfrmSparkTable.DelAllMarksClick(Sender: TObject);
  var ImN : Integer;
      DoRefreshImage : Boolean;
begin
      If (SpTabEmpty = False) Then Begin
         if High(MarkSmEvCoor[CurIm]) >= 0 then DoRefreshImage := True
         else DoRefreshImage := False;
         if EnableMultSel.Down = True then Begin
          EnableMultSel.Down := False;
          frmSparkTable.EnableMultSelClick(Sender);
         end;
         SmSelMode := 0;
         with StringGridSparks do begin
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
          Cells[9,1] := '';
         end;
         For ImN := 0 to NrIm - 1 Do Begin
           If High(MarkSmEvCoor[ImN]) >= 0 Then Begin
              SetLength(MarkSmEvCoor[ImN],0);
              SetLength(MarkSmAmpl[ImN],0);
              SetLength(MarkSmBase[ImN],0);
              SetLength(MarkSmEvDur[ImN],0);
           End;
         End;
         SpTabEmpty := True;
             {Refreshes Main Window}
         If DoRefreshImage = True Then Begin
            UpdateMainImage(True);
         End;
         {Refreshes Aver Window}
         If (frmAverIm <> nil) and (AvImExists > 0) and (MarkPar.ShowSmEvOnAverWin) Then Begin
            UpdateAverImage(True);
         End; {many conditions with AverIm}

      End; {If SpTabEmpty = False}
End;

{********************************************************************************}

procedure TfrmSparkTable.RecalculateSmallEvClick(Sender: TObject);
var
     CntIm,M       : Integer;
Begin

 If (MainImLoaded = True) and (NrIm > 1) Then Begin

      Screen.Cursor := crHourGlass;

     if Not(MarkTablesPar.GetSmEvBase) or Not(RatioOn) then begin
        if Not(RatioOn) then MessageDlg('It has to be in F/Fo mode to get F/Fo amplitude, Rise time, Duration and Decay', mtInformation, [mbOK], 0);
        RecalculateMeanforMark(MarkSmEvCoor,MarkSmAmpl);
     end;

     If (RatioOn) or (ChannelsRatioOn) then Begin
       if (MarkTablesPar.GetSmEvBase) then
       GetMarksBaselines(MarkSmEvCoor,MarkSmAmpl, MarkSmBase,MarkTablesPar.NrPointsSmEvBase,MarkTablesPar.SmEvBaseSearchRange)
        else
       If Not(MarkTablesPar.GetSmEvBase) then Begin
          for CntIm := 0 to High(MarkSmBase) do begin
            if High(MarkSmBase[CntIm]) >= 0 then
            for M := 0 to High(MarkSmBase[CntIm])do begin
              if (RatioOn) then
                MarkSmBase[CntIm,M] := 1.0 else
              if (ChannelsRatioOn) then
                MarkSmBase[CntIm,M] := HillEquationParams.MinRatio;
            end;
          end;
       End; //If Not(MarkTablesPar.GetSmEvBase)
        GetDurForMark(MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,MarkTablesPar.NrPointsSmEvBase,MarkTablesPar.SmEvBaseSearchRange);
      End; //if (RatioOn) then begin

      RefillStringGridEvents(StringGridSparks, MarkSmEvCoor,MarkSmAmpl,MarkSmEvDur,MarkSmEvRise,MarkSmBase);
      Screen.Cursor := crDefault;

     {refreshes All the Buffers with Current Image}
        ReadImage(CurIm,0,pImData);
      If (RatioOn = True) Then Begin
        if (SmoothMode > NO_SMOOTH) then ApplySmoothing;
      End; { (RatioOn = True)}

        { --------------------------------------------------------------- }

      {Restore the current Image}
      ReadImage(CurIm,0,pImData);
      {Restore ratio but do not copy it to Image Display since ImageDisplay was not changed}
      If (RatioOn) then Begin
        if (SmoothMode > NO_SMOOTH) and (frmImageControl.cbSmoothBeforeDoRatio.Checked) then Begin
          ApplySmoothing;
        end; {SmoothMode > 0}
        DoRatio(NO_COPY);
      End
        Else
      if (ChannelsRatioOn) then DoChannelRatio(NO_COPY);

 End; {If (MainImLoaded = True) and (NrIm > 1) Then Begin}
End;

procedure TfrmSparkTable.sbSentSmEvToHistogramsClick(Sender: TObject);
begin
  if (frmTimeHistograms <> nil) then begin
    if (frmTimeHistograms.rbMarks.Checked) then
    frmTimeHistograms.GetEventsFromMarkTable(Sender);
  end;
end;

{********************************************************************************}

Procedure TfrmSparkTable.PutBoxesClick(Sender: TObject);
Var i : Integer;
Begin

  If RowSelSmEv > 0 Then Begin
    {Deletes all Existing ROIs}
    If (ROIvar.NrROI > 0) then
    For i := 1 to 20 Do Begin
      ROIvar.ROIAdr[i] := 0;  {Zeroes Out the Array=No Selections}
      FhPol[i] := nil;
      FhTbl[i] := nil;
    End;
    {End deletion}
    {Puts New}
    PutBoxesOnMarks(StringGridSparks,MultSelArrSmEv,RowSelSmEv);
    {Main Image}
    UpdateMainImage(True);
    {Average Image}
     If (frmAverIm <> nil) and (AvImExists > 0) and (ROIvar.ROIonAverWin = True) Then Begin
        UpdateAverImage(True);
     End;
    SmSelMode := 3;
    StringGridSparks.Invalidate;
  End;
End; {Procedure TfrmSparkTable.PutBoxesClick}
{********************************************************************************}
function GetPeaksForArea(var PlotData : TDynDoubleArray) : Double; inline;
var Cnt,NrP : Integer;
    PeakPos,PeakBeg,PeakEnd : TDynIntArray;
    TimeBeg,TimeEnd : TDynDoubleArray;
    TimePeriods : TDyn2DDoubleArr;
    Locked : Boolean;
    Sl, PA : Double;
begin

  SetLength(PeakPos,0);
  SetLength(PeakBeg,0);
  SetLength(PeakEnd,0);
  Locked := False;

  //restore CopyOfTimeSt and Time Period
  with PLOTvar do for Cnt := ImBeg to ImEnd do CopyOfTimeSt[Cnt-ImBeg] := TimeSt[Cnt]; {copies Time Stamps}

  For Cnt := 0 to High(PlotData) Do Begin  //Finds Peaks and Position as Number in the array
    If (PlotData[Cnt] >= PeakThreshold) and Not(Locked) then Begin
      SetLength(PeakPos, High(PeakPos) + 2);
      PeakPos[High(PeakPos)] := Cnt;
      Locked := True;
    End
      Else
    If (PlotData[Cnt] >= PeakThreshold) and (Locked) then Begin
      if (PlotData[Cnt] > PlotData[PeakPos[High(PeakPos)]]) then begin
        PeakPos[High(PeakPos)] := Cnt;
      end;
    End;
    If (PlotData[Cnt] <= 0) and (Locked) then Begin  //less = baseline
      Locked := False;
    End;
  End;  // For Cnt := 0 to High(PlotData) Do Begin; End of Getting Peaks Positions

  SetLength(PeakBeg,Length(PeakPos));
  SetLength(PeakEnd,Length(PeakPos));
  SetLength(TimeBeg,Length(PeakPos));
  SetLength(TimeEnd,Length(PeakPos));

  {Find the Beg and End of Each Peak;
    Peak has to have at least 1 point > Threshold
    Peak Begins at any Point >= baseline  and Ends at Point <= Baseline}

  For Cnt := 0 to High(PeakPos) do Begin

    NrP := PeakPos[Cnt];
    If (NrP > 0) Then
    While (NrP >= 0) Do Begin  //0 is the baseline here
      if (PlotData[NrP] <= 0)  then begin
        PeakBeg[Cnt] := NrP;
        Break;
      end;
      Dec(NrP);
    End
      Else
    PeakBeg[Cnt] := 0;

    NrP := PeakPos[Cnt];
    If (NrP < High(PlotData)) Then
    While (NrP <= High(PlotData)) Do Begin
      if (PlotData[NrP] <= 0) or (NrP = High(PlotData)) then begin
        PeakEnd[Cnt] := NrP;
        Break;
      end;
      Inc(NrP);
    End
      Else
    PeakEnd[Cnt] := High(PlotData);
  End;

  //Find X intercepts;  {Slope =  m = (y2-y1)/(x2-X1)
   //Finds Zero Time at the Beg of Peak; Positive: X1 = -Y2/m + X2
  For NrP := 0 to High(PeakPos) do Begin
    If (PeakBeg[NrP] > 0) Then Begin
       if (PlotData[PeakBeg[NrP]] < 0) then begin
        Sl := (PlotData[PeakBeg[NrP]+1]-PlotData[PeakBeg[NrP]])/(CopyOfTimeSt[PeakBeg[NrP]+1]-CopyOfTimeSt[PeakBeg[NrP]]);
        TimeBeg[NrP] := -(PlotData[PeakBeg[NrP]+1])/(Sl) + CopyOfTimeSt[PeakBeg[NrP]+1];
      end
        else
      if (PlotData[PeakBeg[NrP]] = 0) then begin
        TimeBeg[NrP] := CopyOfTimeSt[PeakBeg[NrP]];
      end;
    End
      Else
    If (PeakBeg[NrP] = 0)Then Begin
      TimeBeg[NrP] := CopyOfTimeSt[PeakBeg[NrP]];
    End;
  End;

  //Finds Zero Time at the End of Peak; Negative X2 = -Y1/m + X1
  For NrP := 0 to High(PeakPos) do Begin
      if (PlotData[PeakEnd[NrP]] < 0) then begin
        Sl := (PlotData[PeakEnd[NrP]]-PlotData[PeakEnd[NrP]-1])/(CopyOfTimeSt[PeakEnd[NrP]]-CopyOfTimeSt[PeakEnd[NrP]-1]);
        TimeEnd[NrP] := -(PlotData[PeakEnd[NrP]-1])/(Sl) + CopyOfTimeSt[PeakEnd[NrP]-1];
      end
        else
      if (PeakEnd[NrP] = 0) or (PeakEnd[NrP] = High(PlotData)) then begin
        TimeEnd[NrP] := CopyOfTimeSt[PeakEnd[NrP]];
      end;
  End;

   //Sets TimePeriods Array Each for Each Peak
  SetLength(TimePeriods,Length(PeakPos));
  for NrP := 0 to High(PeakPos) do begin
    SetLength(TimePeriods[NrP],PeakEnd[NrP]-PeakBeg[NrP]); //one less
  end;

  For NrP := 0 to High(TimePeriods) Do Begin
   for Cnt := 0 to High(TimePeriods[NrP]) do begin
    if (Cnt <> 0) and (Cnt < High(TimePeriods[NrP])) then
      TimePeriods[NrP,Cnt] := CopyOfTimeSt[PeakBeg[NrP]+Cnt+1] - CopyOfTimeSt[PeakBeg[NrP]+Cnt] else
    if (Cnt = 0) then
      TimePeriods[NrP,Cnt] := CopyOfTimeSt[PeakBeg[NrP]+Cnt+1] - TimeBeg[NrP] else
    if (Cnt = High(TimePeriods[NrP])) then
      TimePeriods[NrP,Cnt] := TimeEnd[NrP] - CopyOfTimeSt[PeakBeg[NrP]+Cnt];
   end;
  End;

  //Integrate Peak by Peak
  Result := 0; //= PeakArea := 0;
  For NrP := 0 to High(TimePeriods) Do Begin
   PA := 0;
   for Cnt := 0 to High(TimePeriods[NrP]) do begin
    PA := PA + ((PlotData[PeakBeg[NrP]+Cnt+1] + PlotData[PeakBeg[NrP]+Cnt])/2)*TimePeriods[NrP,Cnt];
   end;
   Result := Result + PA;
  End;

End;  //procedure GetPeaksForArea(var PlotData, TimePeriodMod : TDynDoubleArray; const Thr : Double);
{*******************************************************************************}

procedure TfrmSparkTable.sbGetTracesFromAllMarksClick(Sender: TObject);
var Cnt, RowCnt,BegRow, EndRow,ImNr : Integer;
    PltTracesSet,FirstTime : Boolean;
    PltTraces : TDyn2DDoubleArr; //collects all the plot traces
    TxTFile   : TextFile;
    SaveFname,WriteStr,TimeStr, DataLocStr : AnsiString;
    //integration variables
    AreaInt : Double;
    PlotData, Area_Total,Area_Peaks  : TDynDoubleArray;
    TimePeriod : TDynDoubleArray;
    PeakPos,PeakBeg,PeakEnd : TDynDoubleArray;
Begin

 If (SpTabEmpty = False) Then Begin

  RowCnt := StringGridSparks.RowCount - 1;  //one less  Gives the Number of Traces
  SetLength(MultSelArrSmEv,RowCnt);
  PltTracesSet := False;

  BegRow  := 0;
  EndRow  := 0;

  While (EndRow < RowCnt) Do Begin
    if (RowCnt - BegRow >= 20) then begin
      EndRow := BegRow + 20;
      RowSelSmEv := 20;
    end
      else
    begin
      EndRow := RowCnt;
      RowSelSmEv := EndRow-BegRow;
    end;

    for Cnt := 0 to High(MultSelArrSmEv) do MultSelArrSmEv[Cnt] := 0;
    for Cnt :=  BegRow to EndRow-1 do MultSelArrSmEv[Cnt] := 1;

    PutBoxesClick(Sender);
    frmTimeSerPlot.StartAnalClick(Sender);

    if not(PltTracesSet) then begin
      SetLength(PltTraces,RowCnt,PLOTvar.ImEnd-PLOTvar.ImBeg+1);
      PltTracesSet := True;
    end;

   //Tranfer Plot Traces to the Local PltTraces
    For Cnt := 0 to (PLOTvar.NrROI - 1) Do Begin
    For ImNr := 0 to High(PltTraces[0]) Do Begin
      if  (PLOTvar.AnalType = RATIO_TIME) Then begin
        if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
          PltTraces[Cnt+BegRow,ImNr] := TSPlotData_BaseSubtr[Cnt,ImNr]/ScaleRat
            else
          PltTraces[Cnt+BegRow,ImNr] := TSPlotData_BaseNotSubtr[Cnt,ImNr]/ScaleRat;
      end
        else
      begin
        if (TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
          PltTraces[Cnt+BegRow,ImNr] := TSPlotData_BaseSubtr[Cnt,ImNr]
            else
          PltTraces[Cnt+BegRow,ImNr] := TSPlotData_BaseNotSubtr[Cnt,ImNr];
        end;
    End; //For ImNr := 0 to High(PltTraces[0]) Do Begin
    End; //For Cnt := 0 to (PLOTvar.NrROI - 1) Do Begin

    BegRow := EndRow;

  End; //While (EndRow < RowCnt) Do Begin

   // ---------- Intergration Section to Find the Area ----------------------//
    //Copy Data to Plot data array
 If (cbGetAreas.Checked) Then Begin

  SetLength(PlotData,  PLOTvar.ImEnd-PLOTvar.ImBeg+1);
  SetLength(TimePeriod,PLOTvar.ImEnd-PLOTvar.ImBeg); //by 1 point shorter since it's the period
  SetLength(Area_Total,Length(PltTraces));
  SetLength(Area_Peaks,Length(PltTraces));

  for ImNr := 0 to High(TimePeriod) do TimePeriod[ImNr] := CopyOfTimeSt[ImNr+1] - CopyOfTimeSt[ImNr];

  For Cnt := 0 to High(PltTraces) Do Begin
    If (PLOTvar.AnalType = RATIO_TIME) Then Begin
      //Rescale Array and Subtract 1.00 to get (F-Fo)/Fo i.e. set F/Fo of 1.0 to Zero
      for ImNr := 0 to High(PlotData) do PlotData[ImNr] := PltTraces[Cnt,ImNr] - 1;
    End
      Else
    Begin
      //subtract the Background if Baseline was not subtracted
      if Not(TimPltSlid.BaseLineOption in [SUBTRACT_BASELINE]) then
        for ImNr := 0 to High(PlotData) do PlotData[ImNr] := PltTraces[Cnt,ImNr] - Bkg;
    End;

    {Now Get Area Under the Curve the way GraphPad does it: trapezoidal integration of Peaks Areas Only
     Peak is anything that is >= Threshold and starts and end from values = Baseline
     Baseline is assumed to be 1.00 for F/Fo ratio and Background (offset) in non ratio files
     So far Areas from Channel/Channel ration is NOT considered}

    Area_Peaks[Cnt] := GetPeaksForArea(PlotData); //Get Area Under the Curve the way GraphPad does it

    //Get the Total Area = Positive + Negative Area: They subtract each other unlike GraphPad where they Summ
    AreaInt := 0;
    for ImNr := 0 to High(TimePeriod) do begin
      //trapezoidal integration
      AreaInt := AreaInt + ((PlotData[ImNr+1] + PlotData[ImNr])/2)*TimePeriod[ImNr];
    end;
    Area_Total[Cnt] := AreaInt;  //Transfer to Area_Total Array
  End;
 End; //If (cbGetAreas.Checked) Then Begin
  //------------  End of integration

  //------------- Save Traces to txt File ------------------------------------//

  SaveTracesFileDialog.Title := 'Save Time Series Plot from all Marks';
  SaveTracesFileDialog.Filter := 'Save Time Series Plot from all Marks (*.txt)|*.txt';
  if (UseMoviFilePath = False) and (FilePaths.PLOTFilePath <> '') then begin
    SaveTracesFileDialog.InitialDir := FilePaths.PLOTFilePath;
    SaveTracesFileDialog.FileName := imFtitle + '_Plots_All_Marks';
  end else
  if (UseMoviFilePath = True) or (FilePaths.PLOTFilePath = '') then begin
    SaveTracesFileDialog.InitialDir := ExtractFilePath(ImFname);
    SaveTracesFileDialog.FileName := imFtitle + '_Plots_All_Marks';
  end;

  If (SaveTracesFileDialog.Execute) Then Begin

    FilePaths.PLOTFilePath := ExtractFilePath(SaveTracesFileDialog.FileName);
    SaveFname              := SaveTracesFileDialog.FileName;
    if ExtractFileExt(SaveFname) <> '.txt' then SaveFname := SaveFname + '.txt';

    If (IsFileInUse(SaveFname) = False) then Begin
      AssignFile(TxtFile, SaveFname);
      ReWrite(TxtFile);

      with frmSparkTable.StringGridSparks do begin
      SetLength(TagArray,RowCount-1);
      for Cnt := 0 to High(TagArray) do begin
          TagArray[Cnt] := Cells[9,Cnt+1];
      end;
      end;

       {--- Writes Header -------------------------------------------------------}
      {1st: Writes File Name & Kind of Analysis}
      if (NrChannels = 1) then
      WriteStr := 'SparkAn "All Marks Traces File";  Extracted from: ' + PLOT_FTitle + ';  Analysis Type: ' + PLOTvar.Title else
      if (NrChannels = 2) then begin
        if (ChannelOrder = ASCENDING)  then
        WriteStr := 'SparkAn "All Marks Traces File";  Extracted from: ' + PLOT_FTitle + ', Channel One;  Analysis Type: ' + PLOTvar.Title else
        if (ChannelOrder = DESCENDING)  then
        WriteStr := 'SparkAn "All Marks Traces File";  Extracted from: ' + PLOT_FTitle + ', Channel Two;  Analysis Type: ' + PLOTvar.Title;
      end;

      if (PLOTvar.BaseLineStatus in [SUBTRACT_BASELINE,DIVIDE_BY_BASELINE]) then
        WriteStr := WriteStr + ' (' + IntToStr(PLOTvar.BaseLinePoints)+ '*'+ IntToStr(PLOTvar.NrScanes) + ' points' +
        ', LSD = ' + FloatToStrF(PLOTvar.LSD,ffFixed,1,1) +
        ', RSD = ' + FloatToStrF(PLOTvar.RSD,ffFixed,1,1) + ')'
      else WriteStr := WriteStr + ', Continuous Baseline Not used';

      WriteStr := WriteStr + '; ' + MainForm.GetFilterSize;

      if    (cbGetAreas.Checked) then begin
        WriteStr := WriteStr + ', Peak Threshold = ' + FloatToStrF(PeakThreshold,ffFixed,8,3);
        if (PLOTvar.AnalType = RATIO_TIME) then
          WriteStr := WriteStr + ', Peak Baseline = 1.000' else
          WriteStr := WriteStr + ', Peak Baseline = ' + IntToStr(Bkg);
      end
        else
      if not(cbGetAreas.Checked) then WriteStr := WriteStr + ', Areas not analyzed';

      Writeln(TxTFile,WriteStr);

      {2nd Writel What was done}
      if not(cbGetAreas.Checked) then DataLocStr := 'Below Mark X&Y: ' else DataLocStr := 'Below Total Area: ';

      if not(MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then
        WriteStr := DataLocStr + 'Image Nr, Time (s), & Trace Data from ' + IntToStr(RowCnt) + ' Marks'
          else
      if (MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) then begin
        if (MovFType in[ANDOR_MOV,BIORAD_PIC]) then begin
          if (MovieSeriesType = TimeSeries) then
            WriteStr := DataLocStr + 'Image Nr, Time (s), & Trace Data from ' + IntToStr(RowCnt) + ' Marks'
            else
          if (MovieSeriesType = Z_Stack) then
            WriteStr := DataLocStr + 'Image Nr, Time (s), Z distance (µm) & Trace Data from ' + IntToStr(RowCnt) + ' Marks';
      end
        else
      if (MovFType = ZEISS_CZI_LSM_MOV) then begin
        if (MovieSeriesType = TimeSeries) then
          WriteStr := DataLocStr + 'Image Nr, Time (s), & Trace Data from ' + IntToStr(RowCnt) + ' Marks'
            else
        if (MovieSeriesType = Z_Stack) then
          WriteStr := DataLocStr + 'Image Nr, Z distance (µm), & Trace Data from ' + IntToStr(RowCnt) + ' Marks';
      end;
      end; //if (MovFType in[ANDOR_MOV,ZEISS_CZI_LSM_MOV])

      WriteStr := WriteStr + ' (ROI X & Y size (pix): ' + IntToStr(PLOTvar.ROIsizeXY[0,0]) + 'x' + IntToStr(PLOTvar.ROIsizeXY[1,0])+')';

      Writeln(TxTFile,WriteStr);

      //-------------- Write Type, Mark Nr, Mar X&Y, Area -----------------------//
      WriteStr := Chr(9) + 'Tag:';
      For ImNr := 0 to High(PltTraces) Do Begin
        if (TagArray[ImNr] <> '') then
          WriteStr := WriteStr + Chr(9) + TagArray[ImNr] else
          WriteStr := WriteStr + Chr(9) + '-';
      End;
      Writeln(TxTFile,WriteStr);

      WriteStr := Chr(9) + 'Mark Nr:';
      For ImNr := 0 to High(PltTraces) Do Begin
        WriteStr := WriteStr + Chr(9) + IntToStr(ImNr+1);
      End;
      Writeln(TxTFile,WriteStr);

      WriteStr := Chr(9) + 'Mark Image Nr:';
      For ImNr := 1 to StringGridSparks.RowCount-1 Do Begin;
        WriteStr := WriteStr + Chr(9) + StringGridSparks.Cells[1, ImNr];
        //this is the order Cells[Column,Row] ; starts from Zero
      End;
      Writeln(TxTFile,WriteStr);

      WriteStr := Chr(9) + 'Mark X&Y:';
      For ImNr := 1 to StringGridSparks.RowCount-1 Do Begin;
        WriteStr := WriteStr + Chr(9) + StringGridSparks.Cells[2, ImNr] + 'x' + StringGridSparks.Cells[3, ImNr];
        //this is the order Cells[Column,Row] ; starts from Zero
      End;
      Writeln(TxTFile,WriteStr);

      If (cbGetAreas.Checked) Then Begin
        WriteStr := Chr(9) + 'Peak Area:';
        For ImNr := 0 to High(PltTraces) Do Begin
          WriteStr := WriteStr + Chr(9) + FloatToStrF(Area_Peaks[ImNr],ffFixed,12,3);
        End;
        Writeln(TxTFile,WriteStr);

        WriteStr := Chr(9) + 'Total Area:';
        For ImNr := 0 to High(PltTraces) Do Begin
          WriteStr := WriteStr + Chr(9) + FloatToStrF(Area_Total[ImNr],ffFixed,12,3);  //areas can be big !!!
        End;
        Writeln(TxTFile,WriteStr);
      End;

      {------------------------- End of Heather ------------------------------------}

      For ImNr := 0 to High(PltTraces[0]) Do Begin
         FirstTime := True;
         //------ Get Time ---------------------//
       With PLOTvar do begin
        if not(MovFType in[ANDOR_MOV,BIORAD_PIC]) then
          TimeStr := FloatToStr(CopyOfTimeSt[ImNr])
          else
        if (MovFType in[ANDOR_MOV,BIORAD_PIC]) then begin
          if (MovieSeriesType = TimeSeries) then
            TimeStr := FloatToStr(CopyOfTimeSt[ImNr])
            else
          if (MovieSeriesType = Z_Stack) then
            TimeStr := FloatToStr(CopyOfTimeSt[ImNr]) + Chr(9) +
                        FloatToStrF(ZstackArr[ImNr+PlotVAR.ImBeg],ffFixed,8,3)
          end; //if (MovFType = ANDOR_MOV)
        End; //with PLOTvar do begin
       //------ End of Get Time ---------------------//

      For Cnt := 0 to High(PltTraces) Do Begin
       if (FirstTime = True) then begin
        WriteStr := IntToStr(ImNr+1+PLOTvar.ImBeg) + Chr(9) + TimeStr + Chr(9) + FloatToStrF(PltTraces[Cnt,ImNr],ffFixed,8,3);
        FirstTime := False;
       end
        else
       begin
         WriteStr := WriteStr + Chr(9) + FloatToStrF(PltTraces[Cnt,ImNr],ffFixed,8,3)
       end;
      End; //For ImNr := 0 to High(PltTraces[0]) Do Begin

       Writeln(TxTFile,WriteStr);

    End; //For Cnt := 0 to (PLOTvar.NrROI - 1) Do Begin

      CloseFile(TxTFile);
     //Clears all selections and restores "regular" Select Mode  (SmSelMode)
      MultSelArrSmEv := nil;
      SmSelMode  := 0;
      RowSelSmEv := 0;
      StringGridSparks.Invalidate; //repaint table

    End //If (IsFileInUse(SaveFname) = False) then Begin

      Else

    If (IsFileInUse(SaveFname) = True) then
      MessageDlg('File is Used by Other Program: Close File or Create a New One',mtError,[mbOK],0);

  End; //If (SaveTracesFileDialog.Execute) Then Begin
 End; //If (SpTabEmpty = False) Then Begin

End; //procedure TfrmSparkTable.sbGetAllTracesClick(Sender: TObject);

END.
