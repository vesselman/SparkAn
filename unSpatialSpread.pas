{$D-,L-,O+,Q-,R-,Y-,S-}
unit unSpatialSpread;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.Grids, Vcl.Menus,
   Vcl.StdCtrls, EditNumerical,unGlobUnit, UniButton;


type
  TfrmSpatialSpread = class(TForm)
    StrGdrSpatialSpread: TStringGrid;
    PopupMenuSpatialSpread: TPopupMenu;
    DeleteRow: TMenuItem;
    Cleartable: TMenuItem;
    Cancel: TMenuItem;
    enAmplMeasRect: TEditNumerical;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    enBaseline: TEditNumerical;
    enNrImagesToCalculate: TEditNumerical;
    Label5: TLabel;
    Label6: TLabel;
    unSpatialSpreadHelp: TUniButton;
    procedure enAmplMeasRectReturnPressed(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CleartableClick(Sender: TObject);
    procedure DeleteRowClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure enNrImagesToCalculateReturnPressed(Sender: TObject);
    procedure enBaselineReturnPressed(Sender: TObject);
    procedure unSpatialSpreadHelpClick(Sender: TObject);
  private
    { Private declarations }
    pDArr  : TDynDoubleArray;
  public
    { Public declarations }
    TableEmpty : Boolean;
    procedure FillSpreadTable;
    procedure GetSpatialSpread;
  end;

var
  frmSpatialSpread : TfrmSpatialSpread;

implementation

  uses Main,unMainWindow,unFunctions, unPlayBack;

{$R *.dfm}

procedure TfrmSpatialSpread.ClearTableClick(Sender: TObject);
begin
  If Not(TableEmpty) then with StrGdrSpatialSpread do begin

    RowCount := 2;
    if (ColCount > 6) then ColCount := 6;
    Cells[0,1] := '';  {This Goes on Fixed (Gray Cell}
    Cells[1,1] := ''; {Image Number}
    Cells[2,1] := ''; {X coordinate}
    Cells[3,1] := ''; {Y coord}
    Cells[4,1] := ''; {Amplitude F/Fo}
    Cells[5,1] := ''; {Spread = square microns}

    TableEmpty := True;
  end;

end;

procedure TfrmSpatialSpread.DeleteRowClick(Sender: TObject);

  var R,CntCol : Integer;

begin
   If Not(TableEmpty) then Begin
     if (StrGdrSpatialSpread.ColCount > 6) then begin
      //set cells to '' empty because if row is restored and not overwritten the old numbers might appear
      R := StrGdrSpatialSpread.Row;
      for CntCol := 6 to StrGdrSpatialSpread.ColCount-1 do
        StrGdrSpatialSpread.Cells[CntCol,R] := '';
     end;
     TStringGridHack(StrGdrSpatialSpread).DeleteRow(StrGdrSpatialSpread.Row);
    If StrGdrSpatialSpread.Cells[0,1] = '' then begin
       TableEmpty := True;
       StrGdrSpatialSpread.Row := 1;
    end;

    If Not(TableEmpty) Then Begin
      With StrGdrSpatialSpread Do Begin
        for R := Row to RowCount - 1 do Cells[0,R] := IntToStr(R);
      End;
    End;
   End; //If Not(TableEmpty) then Begin
end;

procedure TfrmSpatialSpread.enAmplMeasRectReturnPressed(Sender: TObject);
begin
   SpreadMesRect.X := enAmplMeasRect.NumberOne;
   SpreadMesRect.Y := enAmplMeasRect.NumberTwo;
end;

procedure TfrmSpatialSpread.enBaselineReturnPressed(Sender: TObject);
begin
   SpatialSpread_Baseline := enBaseline.NumberOne;  //Baseline of non ratioed images
end;

procedure TfrmSpatialSpread.enNrImagesToCalculateReturnPressed(Sender: TObject);
begin
   SpatialSpread_NrImagesToCalculate := enNrImagesToCalculate.NumberOne;
end;

procedure TfrmSpatialSpread.FormClose(Sender: TObject; var Action: TCloseAction);
Var  NrRows,NrColls,i,c : Integer;
begin

  If Not(TableEmpty) then Begin
     NrRows   := StrGdrSpatialSpread.RowCount - 1; //Fixed (Gray Rows Are Excluded
     NrColls  := StrGdrSpatialSpread.ColCount - 5; //Fixed (Gray Columns Are Excluded

     SetLength(SpreadImNr,NrRows);
     SetLength(SpreadCoor,NrRows);
     SetLength(SpreadAmpl,NrRows);
     SetLength(SpreadSurface,NrRows,NrColls);
     
     With StrGdrSpatialSpread do begin

      for i := 1 to NrRows do begin
        SpreadImNr[i-1]   := StrToInt  (Cells[1,i]);
      end;

      for i := 1 to NrRows do begin
        SpreadCoor[i-1].X := StrToInt  (Cells[2,i]);
      end;

      for i := 1 to NrRows do begin
        SpreadCoor[i-1].Y := StrToInt  (Cells[3,i]);
      end;

      for i := 1 to NrRows do begin
        SpreadAmpl[i-1]   := StrToFloat(Cells[4,i]);
      end;

      for i := 1 to NrRows do begin
        for c := 1 to NrColls do begin
          if (Cells[c+4,i] <> '') then
            SpreadSurface[i-1,c-1]:= StrToFloat(Cells[c+4,i])
          else
            SpreadSurface[i-1,c-1]:= -1;
        end;
      end;

     End; //With StrGdrSpatialSpread
  End; //If Not(TableEmpty)

  Action           := caFree;
  frmSpatialSpread := nil;
End;

procedure TfrmSpatialSpread.FillSpreadTable;
  Var i,c,NrColls,NrRows : Integer;
Begin

  With StrGdrSpatialSpread Do Begin

    StrGdrSpatialSpread.RowCount := Length(SpreadImNr) + 1;
    StrGdrSpatialSpread.ColCount := Length(SpreadSurface[0]) + 5;
    NrColls := Length(SpreadSurface[0]);
    NrRows  := Length(SpreadImNr);

    if (ColCount > 6) then for c := 2 to NrColls do begin
      ColWidths[c+4] := 70;
      Cells[c+4,0] := 'Next Im ' + Chr(181) + 'm ' + Chr(178);
    end;

    for i := 1 to NrRows do begin
      Cells[0,i] := IntToStr(i);
    end;

    for i := 1 to NrRows do begin
      Cells[1,i] := IntToStr(SpreadImNr[i-1]);
    end;

    for i := 1 to NrRows do begin
      Cells[2,i] := IntToStr(SpreadCoor[i-1].X);
    end;

    for i := 1 to NrRows do begin
      Cells[3,i] := IntToStr(SpreadCoor[i-1].Y);
    end;

    for i := 1 to NrRows do begin
      Cells[4,i] := FloatToStrF(SpreadAmpl[i-1],ffFixed,5,3);
    end;

    for i := 1 to NrRows do begin
      for c := 1 to NrColls do begin
        if (SpreadSurface[i-1,c-1] <> -1) then
         Cells[c+4,i] := FloatToStrF(SpreadSurface[i-1,c-1],ffFixed,6,3) else
         Cells[c+4,i] := '';
      end;
    end;

    TableEmpty := False;

    //finally frees the arrays
    SetLength(SpreadImNr,0);
    SetLength(SpreadCoor,0);
    SetLength(SpreadAmpl,0);
    SetLength(SpreadSurface,0);

  End; //With StrGdrSpatialSpread Do Begin
End;

procedure TfrmSpatialSpread.FormCreate(Sender: TObject);
begin
  //frmSparkTable.Position := poScreenCenter;

   with StrGdrSpatialSpread do begin
    Cells[0,0] := 'Row';  {This Goes on Fixed (Gray Cell}
    Cells[1,0] := 'Image'; {Image Number}
    Cells[2,0] := 'X';
    Cells[3,0] := 'Y';
    Cells[4,0] := 'Ampl';
    ColWidths[5] := 70;
    Cells[5,0] := 'Spread (' + Chr(181) + 'm ' + Chr(178) + ')';
   end; {With StringGridSparks ....}

   if SpreadImNr  = nil then TableEmpty := True else
   if SpreadImNr <> nil then FillSpreadTable; //it sets TableEmpty = false there

   frmSpatialSpread.ClientHeight := StrGdrSpatialSpread.Height + 55;

   enAmplMeasRect.SetNumbersOneTwo(SpreadMesRect.X,SpreadMesRect.Y);
   enNrImagesToCalculate.NumberOne := SpatialSpread_NrImagesToCalculate;
   enBaseline.NumberOne := SpatialSpread_Baseline;

end;

procedure TfrmSpatialSpread.FormResize(Sender: TObject);
begin
  StrGdrSpatialSpread.Height := frmSpatialSpread.ClientHeight - 55;
  StrGdrSpatialSpread.Width  := frmSpatialSpread.ClientWidth - 5;
end;

procedure  TfrmSpatialSpread.GetSpatialSpread;


 Var CntX, CntY,NrCol : Integer;
     XL_Loc,Xr_Loc,Yup_Loc,Yd_Loc : Integer;
     MaxVal           : Double;
     HalfAmpl         : Double;
     Spread           : Double;
     Xmax,Ymax        : Integer; //X,Y of Maximum found
     mrValue          : Integer;

     Procedure GetHalfAmpl;
     Var CntX,CntY,XLL,Xrr,Yupp,Ydd, XLmax,XrMax,YupMax,YdMax : Integer;
     JunkMax            : Double;
    // Xmax,Ymax = X,Y of Maximum found
     Begin
        {1st: Finds Maximum}
      MaxVal  := -1;  // MaxVal is MaxVal
      For CntY := Yup_Loc to (Yd_Loc - SpreadMesRect.Y + 1) Do Begin
        For CntX := XL_Loc to (Xr_Loc - SpreadMesRect.X + 1) Do Begin
          XLL   :=  CntX;
          Xrr   :=  CntX + SpreadMesRect.X - 1; //Gives The Included Pixel Size
          Yupp  :=  CntY;
          Ydd   :=  CntY + SpreadMesRect.Y - 1; //Gives The Included Pixel Size
          {JunkMax := GetMeanROIforMark(XLL,Xrr,Yupp,Ydd);
          this one has 2D filter Controlled by Time Series Plot
          this one below uses whatever the current 2D filter settings are for the Image Window}
          JunkMax := GetMeanROI(XLL,Xrr,Yupp,Ydd,1);  //Const 1 is KindROI = Box
          if (MaxVal < JunkMax) then Begin
            MaxVal := JunkMax;
            XlMax  := XLL;
            XrMax  := Xrr;
            YupMax := Yupp;
            YdMax  := Ydd;
          end;
        End; //CntX
      End; //CntY

      Xmax := XLMax  + (XrMax - XLMax)  shr 1 + (1 - SpreadMesRect.X mod 2);
      Ymax := YupMax +(YdMax - YupMax)  shr 1 + (1 - SpreadMesRect.Y mod 2);

      {2nd: Sets Half Amplitude}

      If not(RatioOn) then Begin
        HalfAmpl := (MaxVal - StrToInt(enBaseline.Text))/2 + StrToInt(enBaseline.Text);
      End
        else
      If (RatioOn) then Begin
        HalfAmpl := (MaxVal - 1.0)/2 + 1.0;
        HalfAmpl := HalfAmpl*DispFact; //ImDataRat is multiplied by DispFact
      End;
     End; // Procedure GetHalfAmpl;

     Procedure SetpDArr;
     Var pWarr : TDynWordArray; //used here as pointer
         CntX, CntY : Integer;
     Begin

     If not(RatioOn) then Begin
      if (Length(pDArr) <> imXsize*imYsize) then SetLength(pDArr,imXsize*imYsize);
        If (BitCount = 16) or
          ((BitCount = 8) and (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH))
        Then Begin
          if not(SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH)
          then pWarr := Im16bitData
            else
          if (SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) and (SmoothMode > NO_SMOOTH)
          then pWarr := Im16bitDataSM_Last;
          //copy only the ROI to pSArr; the rest is not needed
          for CntY := Yup_Loc to Yd_Loc do
            for CntX := XL_Loc to Xr_Loc do
              pDArr[CntX + imXsize * CntY] := pWarr[CntX + imXsize * CntY];
        End { End 16 bit or ((BitCount = 8) and Smooth}
          Else
        If (BitCount = 8) and (not(SmoothNonRatio in[SMOOTH_Ch_ONE,SMOOTH_Ch_BOTH]) or (SmoothMode = NO_SMOOTH))
        Then Begin
      //copy only the ROI to pSArr; the rest is not needed
          for CntY := Yup_Loc to Yd_Loc do
            for CntX := XL_Loc to Xr_Loc do
              pDArr[CntX + imXsize * CntY] := Im8bitData[CntX + imXsize * CntY];
        End; { 8 bit }
      End  //If not(RatioOn) then Begin
        Else
      If (RatioOn) then  pDArr := ImDataRat;
     End;  //Procedure SetpDArr;

     Procedure DoGetSpatialSpread;
     Var  PixAboveHalfAmpl,CntX,CntY : Integer;
     Begin
      PixAboveHalfAmpl := 0;

      For CntY := Yup_Loc to Yd_Loc Do Begin
        For CntX := XL_Loc to Xr_Loc Do Begin
        //here it counts the Pixels Above 1/2 Amplitude//
          If (pDArr[CntX + imXsize*CntY] > HalfAmpl) then Inc(PixAboveHalfAmpl)
            Else
          Begin
          //Makes the Pixels < 1/2 amplitude Black for Visualization
            if (Zoom = 1) then begin
              memBMP.Canvas.Pixels[CntX,CntY] := clBlack;
            end else
            if (Zoom = 2) then begin
              memBMP.Canvas.Pixels[CntX shl Zm,  CntY shl Zm]   := clBlack;
              memBMP.Canvas.Pixels[CntX shl Zm+1,CntY shl Zm]   := clBlack;
              memBMP.Canvas.Pixels[CntX shl Zm  ,CntY shl Zm+1] := clBlack;
              memBMP.Canvas.Pixels[CntX shl Zm+1,CntY shl Zm+1] := clBlack;
            end;
            if (Zoom = -2) then begin
              memBMP.Canvas.Pixels[CntX shr Zm,  CntY shr Zm]   := clBlack;
            end;
          End; // else
        End; //For CntX := XL to Xr
      End; //For CntY := Yup to Yd

      Spread :=  PixSize*PixSize*PixAboveHalfAmpl; //PixSize*PixSize - to get square microns
     End; //DoGetSpatialSpread;

Begin

  XL_Loc  := Xl;
  Xr_Loc  := Xr;
  Yup_Loc := Yup;
  Yd_Loc  := Yd;

 If ((Xr_Loc - Xl_Loc + 1) > SpreadMesRect.X) and ((Yd_Loc - Yup_Loc + 1) > SpreadMesRect.Y) then Begin

    memBMP.Assign(frmMainWin.winMainImage.Picture.Bitmap);
    GetHalfAmpl;
    SetpDArr;
    DoGetSpatialSpread;

    {Fills Spread Table}
    with frmSpatialSpread do begin
    If Not(TableEmpty) then Begin
      If (CurIm >= StrToInt(StrGdrSpatialSpread.Cells[1,StrGdrSpatialSpread.RowCount-1]) - 1)
        Then Begin
          StrGdrSpatialSpread.RowCount := StrGdrSpatialSpread.RowCount + 1;
          StrGdrSpatialSpread.Row := StrGdrSpatialSpread.RowCount - 1;
        End
          Else
        Begin
          CntY := 1;
          While CntY < StrGdrSpatialSpread.RowCount  Do Begin
            if (CurIm < StrToInt(StrGdrSpatialSpread.Cells[1,CntY]) - 1) Then Begin
            StrGdrSpatialSpread.Row :=  CntY;
            StrGdrSpatialSpread.Invalidate;
            TStringGridHack(StrGdrSpatialSpread).InsertRow(CntY);
            for CntX := CntY + 1 to StrGdrSpatialSpread.RowCount - 1 do
              StrGdrSpatialSpread.Cells[0,CntX] := IntToStr(CntX);
              Break;
            End;
            Inc(CntY);
          End; //While
        End; //Else
    End
      Else
    If (TableEmpty) then Begin
      StrGdrSpatialSpread.Row := 1;
      TableEmpty := False;
    end;

    with StrGdrSpatialSpread do begin
      Cells[0,Row] := IntToStr(Row);
      Cells[1,Row] := IntToStr(CurIm+1); //Image #
      Cells[2,Row] := IntToStr(Xmax);
      Cells[3,Row] := IntToStr(Ymax);
      Cells[4,Row] := FloatToStrF(MaxVal,ffFixed,5,3);
      Cells[5,Row] := FloatToStrF(Spread,ffFixed,5,3);
    end; // with StrGdrSpatialSpread

    end; //with frmSpatialSpread  }


    with frmMainWin.winMainImage.Canvas do CopyRect(ClipRect, memBMP.Canvas,ClipRect);
    Application.ProcessMessages;// keep

    If (enNrImagesToCalculate.NumberOne > 1) Then Begin
      NrCol := 6;
      mrValue := MessageDlg('Proceed One by One, Cancel or Process All?', mtConfirmation, [mbYes,mbCancel,mbAll], 0, mbYes);
      //mrYes 	= 6, mrCancel 	= 2, mrAll 	= 8
      If (mrValue = mrYes) or (mrValue = mrAll)
      then For CntX := 2 to enNrImagesToCalculate.NumberOne Do Begin //start from 2 - one is already done
        frmPlayback.PlaybackScrollBar.Position := frmPlayback.PlaybackScrollBar.Position + 1;
        memBMP.Assign(frmMainWin.winMainImage.Picture.Bitmap);
        SetpDArr;
        DoGetSpatialSpread;
        with frmMainWin.winMainImage.Canvas do CopyRect(ClipRect,memBMP.Canvas,ClipRect);
        Application.ProcessMessages;// keep

        with StrGdrSpatialSpread do begin
          if (ColCount = NrCol) then ColCount := ColCount + 1;
          ColWidths[NrCol] := 70;
          Cells[NrCol,0] := 'Next Im ' + Chr(181) + 'm ' + Chr(178);
          Cells[NrCol,Row] := FloatToStrF(Spread,ffFixed,5,3);
        end;

        Inc(NrCol);
        if (mrValue = mrYes) and (CntX < enNrImagesToCalculate.NumberOne) then
        mrValue := MessageDlg('Proceed One by One, Cancel or Process All?', mtConfirmation, [mbYes,mbCancel,mbAll], 0, mbYes);
        if (mrValue = mrCancel) or (CurIm = NrIm-1) then Break;

      End;
    End;
 End  //If ((Xr - Xl + 1) > SpreadMesRect.X) and ((Yd - Yup + 1) > SpreadMesRect.Y) then Begin

  Else

 MessageDlg('Increase the Size of the Measuring Rectangle',mtWarning,[mbOK],0);

End;

procedure TfrmSpatialSpread.unSpatialSpreadHelpClick(Sender: TObject);
var HelpCode : integer;
begin
  HELP_Point := Mouse.CursorPos;
  HelpCode    := 56;
  GetHelp(HelpCode);
end;


END.
