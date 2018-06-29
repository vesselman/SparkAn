{$D-,L-,O+,Q-,R-,Y-,S-}
unit unQueueFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.Grids, Vcl.Buttons,
  Vcl.StdCtrls;

type
  TfrmQueueFiles = class(TForm)
    StrGrFileTable: TStringGrid;
    AddFile: TSpeedButton;
    RemoveFile: TSpeedButton;
    ClearAll: TSpeedButton;
    Run: TSpeedButton;
    StopQFanal: TSpeedButton;
    QuestionInfo: TSpeedButton;
    procedure QuestionInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddFileClick(Sender: TObject);
    procedure StrGrFileTableMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RemoveFileClick(Sender: TObject);
    procedure StrGrFileTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrFileTableMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StrGrFileTableColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ClearAllClick(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure StopQFanalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    CellNr : TRect;
    QFColSel     : integer;
    QFtabEmpty   : Boolean;
    Procedure LoadOneQFileinTable(FlistNr : Integer);
    procedure SetImageControl(const i : Integer);

  public
    { Public declarations }
     Procedure LoadQFileTable;

  end;

var
  frmQueueFiles: TfrmQueueFiles;


implementation

uses Main, unGlobUnit, ImageFilesOpeningRoutines,unSPautoSearch, unImageControl,unTimeSerAnal;

{$R *.dfm}

 {*******************************************************}

Procedure TfrmQueueFiles.FormCreate(Sender: TObject);
begin

        frmQueueFiles.Position := poScreenCenter;

      with frmQueueFiles.StrGrFileTable do begin
        Cells[0,1]  := 'File';
        Cells[0,2]  := 'Images to Search';
        Cells[0,3]  := 'Aver Image from'; {Image Number, or File Name or Create}
        Cells[0,4]  := 'Background';
        Cells[0,5]  := 'Cutoff';
        Cells[0,6]  := 'Smoothing';
        Cells[0,7]  := 'Smooth before F/Fo';
        Cells[0,8]  := 'Selection';
        Cells[0,9]  := 'Threshold';
        Cells[0,10] := 'Tolerance';
        Cells[0,11] := 'Scan Box';
        Cells[0,12] := 'Small/Big Cutoff';
        Cells[0,13] := 'Running Average';  // Nr of Images or No
        Cells[0,14] := 'Ignore Big Events';
        Cells[0,15] := 'Small Events Test'; //Yes or No
        Cells[0,16] := 'Search Left'; // Nr Images & ms
        Cells[0,17] := 'Search Right'; // Nr Images & ms
        Cells[0,18] := 'Nr Points Left'; // Nr Images & ms
        Cells[0,19] := 'Nr Points Right'; // Nr Images & ms
        Cells[0,20] := 'Update F/Fo'; // Nr Images & mss
      End;

      QFtabEmpty := True;
      QFColSel   := 1;
      if High(QFileList) >= 0 then frmQueueFiles.LoadQFileTable;
      frmQueueFiles.Run.Enabled := Not(QFtabEmpty);
End;
{*******************************************************}
Procedure TfrmQueueFiles.LoadQFileTable;
Var i,ColDone : Integer;
Begin

          ColDone := 1;
    While ColDone <= High(QFileList) + 1 Do Begin
         {-----------------------------}
      For i := 0 to High(QFileList) Do Begin
        If QFileList[i].ColNr = ColDone Then Begin
            {------------------}
           With StrGrFileTable do Begin
            if QFtabEmpty = True then begin
              QFtabEmpty := False;
              frmQueueFiles.Run.Enabled := Not(QFtabEmpty);
            end else Begin
              QFColSel := ColCount;
              ColCount := ColCount + 1;
            end;
           End; {With StrGrFileTable do Begin}
           LoadOneQFileinTable(i);
        End; {QFileList[i].ColNr > ColDone}
         if QFileList[i].ColNr = ColDone then Break; {Stops Unnecessary Search}
      End; {For i := 0 to High(QFileList)}
        {--------------------------}
       Inc(ColDone);
    End; {While}
       QFColSel := 1;
       StrGrFileTable.Row := QFColSel;


End; {Procedure TfrmQueueFiles.LoadQFileTable;}
{*******************************************************}

procedure TfrmQueueFiles.QuestionInfoClick(Sender: TObject);
  var  HelpCode : integer;
begin
    HELP_Point := Mouse.CursorPos;
    HelpCode    := 21;
    GetHelp(HelpCode);
end;

{*******************************************************}
procedure TfrmQueueFiles.AddFileClick(Sender: TObject);
Var  Cnt, i : Integer;
     SaveFname : AnsiString;
Begin

If (MainImLoaded = True) and (NrIm > 1) Then Begin

   If (frmSPautoSearch = nil) then Application.CreateForm(TfrmSPautoSearch, frmSPautoSearch);
     
{-----------------------------------------------------------------------------}

if (frmSPautoSearch.EventsAutoSearchSettingsOK(True)) Then Begin

           {1nd: Stores Variables in QFileList}
        SetLength(QFileList,High(QFileList)+ 2 );
        If (ImageFileType = FILE_COLLECTION) and (ImTypeIndex = SINGLE_TIFF_INDEX) then Begin
          {Joined Files but not Saved as Collection}
          MainForm.SaveCollectionOfMultiImageTiffsClick(Sender);
          SaveFname := MainForm.SaveFileDialog.FileName;
          QFileList[High(QFileList)].FIndex := COLLECTION_INDEX;
          QFileList[High(QFileList)].QFName := SaveFname;
        End
        Else Begin
          QFileList[High(QFileList)].FIndex := ImTypeIndex; {Global}
          QFileList[High(QFileList)].QFName := imFName;
        End;

        QFileList[High(QFileList)].AutoSrchPar := AutoSearchPar; //copies the whole AutoSearchPar

        QFileList[High(QFileList)].ImToBeg := frmSPautoSearch.dsSerchFromTo.PosFrom;
        QFileList[High(QFileList)].ImToEnd := frmSPautoSearch.dsSerchFromTo.PosTo;

      {--- Set Ways of Creation of Average Image---}
        If not(AutoSearchPar.AutoAverImage) Then Begin
          If (AvImExists = AVER_ON_LINE) then Begin
            QFileList[High(QFileList)].AverImKind := AVER_ON_LINE;
            QFileList[High(QFileList)].NrImInList := ImSel;
            SetLength(QFileList[High(QFileList)].ListOfIm,ImSel);
            Cnt := 0;
            For i := 0 to NrIm -1 do Begin
              if AvImList[i] > 0 then begin
                QFileList[High(QFileList)].ListOfIm[Cnt] := i;
                Inc(Cnt);
              end;
            End;
              QFileList[High(QFileList)].AvFName := 'No Average from File'
          End Else {If AvImExists = AVER_ON_LINE}
          If (AvImExists = AVER_FROM_FILE) then Begin
            QFileList[High(QFileList)].AverImKind := AVER_FROM_FILE;
            QFileList[High(QFileList)].NrImInList := 0;
            QFileList[High(QFileList)].AvFName    := AvImFPath;
          End;
        End Else
        If (AutoSearchPar.AutoAverImage) Then Begin
            if (AutoSearchPar.StartAutoAverFirstIm) then
              QFileList[High(QFileList)].AverImKind := 5
            else
              QFileList[High(QFileList)].AverImKind := 4;
        End;
        
         {Image and Other SettingSettings}
        with frmImageControl do begin
        QFileList[High(QFileList)].BackGr         := Bkg;
        QFileList[High(QFileList)].ImCutoff       := CutOff;
        QFileList[High(QFileList)].SmoothMode     := SmoothMode;
        QFileList[High(QFileList)].SmoothOrder    := SmoothOrder;
        QFileList[High(QFileList)].BoxCarF        := BoxSmSize;
        QFileList[High(QFileList)].MedianF        := MedSmSize;
        QFileList[High(QFileList)].GaussF         := GaussSmSize;
        QFileList[High(QFileList)].ImageContrVar  := ImageContrVar;

        QFileList[High(QFileList)].ApplyFrame := ubApplyFrame.Selected;
        if (frmImageControl.ubApplyFrame.Selected) then begin
          QFileList[High(QFileList)].SelFrame.Left   := SelFrame.Left;
          QFileList[High(QFileList)].SelFrame.Right  := SelFrame.Right;
          QFileList[High(QFileList)].SelFrame.Top    := SelFrame.Top;
          QFileList[High(QFileList)].SelFrame.Bottom := SelFrame.Bottom;
        end;
        end; { with frmImageControl}

         {----------------------------}
       With StrGrFileTable do Begin
           {1st: Sets Columns}
        if QFtabEmpty = True then begin
         QFColSel := 1;
         QFtabEmpty := False;
        end else Begin
         QFColSel := ColCount;
         ColCount := ColCount + 1;
        end;
        QFileList[High(QFileList)].ColNr := QFColSel; {Corresponding Cloumn}
        LoadOneQFileinTable(High(QFileList));
       End; {With StrGrFileTable do Begin}
         {------------------------}
        frmQueueFiles.Run.Enabled := Not(QFtabEmpty);
     End; {All Conditions Met}
    End; {If (MainImLoaded = True) and (NrIm > 1) Then Begin}
End;
{**************************************************************************}
{**************************************************************************}
Procedure TfrmQueueFiles.LoadOneQFileinTable(FlistNr : Integer);
Var  i : Integer;
     TemStr : AnsiString;
Begin

  With StrGrFileTable do Begin

        Cells[QFColSel,0] := IntToStr(ColCount-1); {minus Fixed One}
        Cells[QFColSel,1] := ExtractFileName(QFileList[FlistNr].QFName);
        Cells[QFColSel,2] := IntToStr(QFileList[FlistNr].ImToBeg + 1) + ' - ' +
                             IntToStr(QFileList[FlistNr].ImToEnd + 1);

        If not(QFileList[FlistNr].AutoSrchPar.AutoAverImage) Then Begin
          If (QFileList[FlistNr].AverImKind = AVER_ON_LINE) then Begin
             TemStr := '';
           for i := 0 to High(QFileList[FlistNr].ListOfIm) Do Begin
             if i < High(QFileList[FlistNr].ListOfIm) then
             TemStr := TemStr + IntToStr(QFileList[FlistNr].ListOfIm[i]+1) + ', ' else
             TemStr := TemStr + IntToStr(QFileList[FlistNr].ListOfIm[i]+1);
           end;
             Cells[QFColSel,3] := TemStr;
          End Else
          If (QFileList[FlistNr].AverImKind = AVER_FROM_FILE) then Begin
            Cells[QFColSel,3] := ExtractFileName(QFileList[FlistNr].AvFName);
          end;
        End Else
        If (QFileList[FlistNr].AutoSrchPar.AutoAverImage) Then Begin
           if (QFileList[FlistNr].AutoSrchPar.StartAutoAverFirstIm) then
            TemStr := ';Start 1st im' else TemStr := ';No Start 1st im';
           if (QFileList[FlistNr].AutoSrchPar.SaveAutoAver) then
            TemStr := TemStr + ';Save to Files' else TemStr := TemStr + ';No Save';
           Cells[QFColSel,3] := 'Gen Aver ' +
           IntToStr(QFileList[FlistNr].AutoSrchPar.AutoAverImRange)+ '/' +
           IntToStr(QFileList[FlistNr].AutoSrchPar.NrImForCreateAvIm) + ' im ' +
           ' every ' + IntToStr(QFileList[FlistNr].AutoSrchPar.AutoAverNrImInc) + ' im' + TemStr;
        End;


        Cells[QFColSel,4] := IntToStr(QFileList[FlistNr].BackGr);
        Cells[QFColSel,5] := IntToStr(QFileList[FlistNr].ImCutoff);
        if (QFileList[FlistNr].SmoothMode = SMOOTH_BOX_MED) then
          TemStr := 'B = '  + IntToStr(QFileList[FlistNr].BoxCarF) +
                    ' -> M = ' + IntToStr(QFileList[FlistNr].MedianF) else

        if (QFileList[FlistNr].SmoothMode = SMOOTH_MED_BOX) then
          TemStr := 'M = '  + IntToStr(QFileList[FlistNr].MedianF) +
                    ' -> B = ' + IntToStr(QFileList[FlistNr].BoxCarF) else

        if (QFileList[FlistNr].SmoothMode in[SMOOTH_MED_GAUSS,SMOOTH_GAUSS_MED])
        then begin
          if (GaussSmSize = GAUSS_3x3_LITE)   then TemStr := 'G = 3L' else
          if (GaussSmSize = GAUSS_3x3_MEDIUM) then TemStr := 'G = 3M' else
          if (GaussSmSize = GAUSS_3x3_HEAVY)  then TemStr := 'G = 3H' else
          if (GaussSmSize = GAUSS_5x5 )       then TemStr := 'G = 5'  else
          if (GaussSmSize = GAUSS_7x7 )       then TemStr := 'G = 7';

          if (QFileList[FlistNr].SmoothMode = SMOOTH_MED_GAUSS) then
            TemStr := 'M = '  + IntToStr(QFileList[FlistNr].MedianF) +
                      ' -> ' + TemStr else

          if (QFileList[FlistNr].SmoothMode = SMOOTH_GAUSS_MED) then
            TemStr := TemStr +
                      ' -> M = ' + IntToStr(QFileList[FlistNr].MedianF);

         end;

        Cells[QFColSel,6] := TemStr;

        if (QFileList[FlistNr].AutoSrchPar.SmoothBeforeDoRatio) then
          Cells[QFColSel,7] := 'Yes' else
        if not(QFileList[FlistNr].AutoSrchPar.SmoothBeforeDoRatio) then
          Cells[QFColSel,7] := 'No';

        if (QFileList[FlistNr].ApplyFrame) then begin
        Cells[QFColSel,8] := 'X = ' + IntToStr(QFileList[FlistNr].SelFrame.Left) +
                             '-' + IntToStr(QFileList[FlistNr].SelFrame.Right) +
                             '; Y = ' + IntToStr(QFileList[FlistNr].SelFrame.Top) +
                             '-' + IntToStr(QFileList[FlistNr].SelFrame.Bottom);
        end else Cells[QFColSel,8] := 'No Selection';

             {AutoSearch Settings}
        with QFileList[FlistNr].AutoSrchPar do begin
        Cells[QFColSel,9] := FloatToStrF(Thresh/100,ffFixed,3,2);
        Cells[QFColSel,10] := IntToStr(100-Tolerance) + '%';
        Cells[QFColSel,11] := IntToStr(ScanBoxSize ) + 'x' +
                              IntToStr(ScanBoxSize);

        Cells[QFColSel,12] := IntToStr(MaxArea) + ' pix';
        if (UseRunAver) then
        Cells[QFColSel,13] := 'from ' + IntToStr(NrImRunAver) + ' im' else
        Cells[QFColSel,13] := 'No';

        if (IgnoreBigEv)  then Cells[QFColSel,14] := 'Yes' else Cells[QFColSel,14] := 'No';

        if (TestSmallEv)  then begin
          if (UseCustomROIforSmEvTest) then
            TemStr := 'Yes, Use ROI = ' + IntToStr(ROISizeForSmEvTest) + 'x'+ IntToStr(ROISizeForSmEvTest)
              else
            TemStr := 'Yes, Use Scan Box';

          if (GetSmEvDur) then TemStr := TemStr + ',Get Time Params' else
                               TemStr := TemStr + ',No Time Params';

          Cells[QFColSel,15] := TemStr;

          TemStr := IntToStr(NrImGetMinLeft) + ' im within ' + IntToStr(SearchLms) + ' ms';
          if (SDuse) then TemStr := TemStr + '; Peak > ' + IntToStr(SDfold) + ' x SD';

          Cells[QFColSel,16] := IntToStr(NrImGetMinLeft) + ' im within ' +
                                IntToStr(SearchLms) + ' ms';

          Cells[QFColSel,17] := TemStr;

          Cells[QFColSel,18] := IntToStr(NrImToLeftOfEv) + ' im > ' +
                                IntToStr(PLval) + ' %';

          Cells[QFColSel,19] := IntToStr(NrImToRightOfEv) + ' im > ' +
                                IntToStr(PRval) + ' %';

          if (UpdateRatio)  then Cells[QFColSel,20] := 'Yes' else Cells[QFColSel,20] := 'No';

        end else
        begin
          Cells[QFColSel,15] := 'No';
          Cells[QFColSel,16] := '-';
          Cells[QFColSel,17] := '-';
          Cells[QFColSel,18] := '-';
          Cells[QFColSel,19] := '-';
          Cells[QFColSel,20] := '-';
        end;
        end; // with QFileList[FlistNr].AutoSrchPar do begin

        StrGrFileTable.Col := QFColSel;
        if StrGrFileTable.Width < 720 then StrGrFileTable.Width := StrGrFileTable.ColCount*205;
        frmQueueFiles.Width := StrGrFileTable.Width + 20;
        StrGrFileTable.Invalidate;

  End; {with StrGrFileTable do Begin}
End;
{**************************************************************************}

procedure TfrmQueueFiles.StrGrFileTableMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var  i,aCol,aRow : integer;
Begin

  With StrGrFileTable do Begin

      MouseToCell(x, y, aCol, aRow);
    If (arow = 0) and (button = mbleft) then If (acol > 0)  then begin

      If (QFColSel >= LeftCol) and (QFColSel <= LeftCol + VisibleColCount) then Begin
        For i := 1 to RowCount - 1 Do Begin
          Canvas.Brush.Color := clWhite;
          Canvas.FillRect(CellRect(QFColSel,i));
          Canvas.Font.Color := RGB(0,0,0);
          Canvas.TextOut(CellRect(QFColSel,i).Left+2,CellRect(QFColSel,i).Top+2,
          StrGrFileTable.Cells[QFColSel,i]);
        End;
      End; {If (QFColSel >= LeftCol) and (QFColSel <= LeftCol + VisibleColCount)}

      QFColSel := aCol;
      CellNr := CellRect(aCol, aRow);
      DrawEdge(Canvas.Handle, CellNr, EDGE_SUNKEN, BF_RECT or BF_SOFT);

      For i := 1 to RowCount - 1 Do Begin
          Canvas.Brush.Color := clTeal;
          Canvas.FillRect(CellRect(QFColSel,i));
          Canvas.Font.Color := RGB(255,255,255);
          Canvas.TextOut(CellRect(QFColSel,i).Left+2,CellRect(QFColSel,i).Top+2,
          StrGrFileTable.Cells[QFColSel,i]);
      End; 

    End; {If (arow = 0) and (button = mbleft) then If (acol > 0) }
  End; {With}
End;  {procedure TfrmQueueFiles.StrGrFileTableMouseDown}
 {*************************************************************************}


{*************************************************************************}
procedure TfrmQueueFiles.RemoveFileClick(Sender: TObject);
Var C,R,T,ColSelMem : integer;
     TemQFList     : array of TQFileDat;
     EventColMov   :  TMovedEvent;
     EventOnDrCell : TDrawCellEvent;
Begin

        {A:  StrGrFileTable}
  If High(QFileList) >= 0 Then Begin

  //memorizes Events and disbles because if not this could trigger unwanted events;
    EventColMov := frmQueueFiles.StrGrFileTable.OnColumnMoved;
    frmQueueFiles.StrGrFileTable.OnColumnMoved := nil; //disabled
    EventOnDrCell := frmQueueFiles.StrGrFileTable.OnDrawCell;
    frmQueueFiles.StrGrFileTable.OnDrawCell := nil;
   //-----------------------------------------------------
    If High(QFileList) > 0 Then With StrGrFileTable Do Begin
        ColSelMem := QFColSel;
      For C := QFColSel to ColCount - 1 Do Begin
        For R := 1 to 16 Do Begin
          Cells[C,R] := Cells[C + 1,R];
        End;
      End; {for}
      For C := QFColSel to ColCount - 1 Do Begin
          Cells[C,0] := IntToStr(C);
      End; {for}

        if QFColSel > ColCount - 2 then QFColSel := ColCount - 2;
        Col      := QFColSel;
        ColCount := ColCount - 1;
    End Else {with StrGrFileTable}

    If High(QFileList) = 0 Then With StrGrFileTable Do Begin
       StrGrFileTable.Cols[QFColSel].Clear;
       QFtabEmpty := True;
    End;
  End; {High(QFileList) >= 0}

     {B: QFileList}

      {1st; Copies to temp Array}
  If High(QFileList) = 0 then Begin
     QFileList := nil; {nills the Array}
     frmQueueFiles.Run.Enabled := False;
  End Else

  If (High(QFileList) > 0) Then Begin

    SetLength(TemQFList,High(QFileList)); {sets it with One element Less}

         T := 0; {Counter for TemQFList}
  For C := 0 to High(QFileList) do begin
    If QFileList[C].ColNr <> ColSelMem Then Begin
        if QFileList[C].ColNr < ColSelMem then
          TemQFList[T].ColNr       := QFileList[C].ColNr
        else
          TemQFList[T].ColNr       := QFileList[C].ColNr - 1;

        TemQFList[T].QFName      := QFileList[C].QFName;
        TemQFList[T].FIndex      := QFileList[C].FIndex;
        TemQFList[T].ImToBeg     := QFileList[C].ImToBeg;
        TemQFList[T].ImToEnd     := QFileList[C].ImToEnd;
        TemQFList[T].NrImInList  := QFileList[C].NrImInList;
        if (TemQFList[T].NrImInList > 0) then begin
          SetLength(TemQFList[T].ListOfIm,Length(QFileList[C].ListOfIm));
          for R := 0 to High(QFileList[C].ListOfIm) do
              TemQFList[T].ListOfIm[R] := QFileList[C].ListOfIm[R];
        end;
        TemQFList[T].AvFName     := QFileList[C].AvFName;
        TemQFList[C].BackGr      := QFileList[C].BackGr;
        TemQFList[T].ImCutoff    := QFileList[C].ImCutoff;
        TemQFList[T].BoxCarF     := QFileList[C].BoxCarF;
        TemQFList[T].MedianF     := QFileList[C].MedianF;
        TemQFList[T].ApplyFrame  := QFileList[C].ApplyFrame;
        TemQFList[T].SelFrame    := QFileList[C].SelFrame;
        Inc(T);
    End  {If QFileList[C].ColNr <> QFColSel}
  End; {For C := 0 to High(QFileList)}

        {2nd: Copies Back to QFileList}
        SetLength(QFileList,Length(TemQFList));
  For C := 0 to High(QFileList) do Begin
          QFileList[C].ColNr        := TemQFList[C].ColNr;
          QFileList[C].QFName       := TemQFList[C].QFName;
          QFileList[C].FIndex       := TemQFList[C].FIndex;
          QFileList[C].ImToBeg      := TemQFList[C].ImToBeg;
          QFileList[C].ImToEnd      := TemQFList[C].ImToEnd;
          QFileList[C].NrImInList     := TemQFList[C].NrImInList;
          if QFileList[C].NrImInList > 0 then
          for R := 0 to High(TemQFList[C].ListOfIm) do
          QFileList[C].ListOfIm[R]  := TemQFList[C].ListOfIm[R];
          QFileList[C].AvFName      := TemQFList[C].AvFName;
          QFileList[C].BackGr       := TemQFList[C].BackGr;
          QFileList[C].ImCutoff     := TemQFList[C].ImCutoff ;
          QFileList[C].BoxCarF      := TemQFList[C].BoxCarF;
          QFileList[C].MedianF      := TemQFList[C].MedianF;
          QFileList[C].ApplyFrame   := TemQFList[C].ApplyFrame;
          QFileList[C].SelFrame     := TemQFList[C].SelFrame;
  End; {For}
 End; {If Initial Array Has at least 2 elements}
    //Restores (Enables) Event Handlers
    frmQueueFiles.StrGrFileTable.OnColumnMoved := EventColMov;
    frmQueueFiles.StrGrFileTable.OnDrawCell    := EventOnDrCell;
End;  {procedure TfrmQueueFiles.RemoveFileClick}
 {*************************************************************************}

procedure TfrmQueueFiles.StrGrFileTableDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);

begin

  With StrGrFileTable do Begin
    If (gdselected in State) and (aCol <> QFColSel) Then Begin
       {removes Blue Highligt intrinsic to StringGrid}
       Canvas.Brush.Color := clWhite;
       Canvas.FillRect(Rect);
       Canvas.Font.Color := RGB(0,0,0);
       Canvas.TextOut(Rect.Left+2,Rect.Top+2, StrGrFileTable.Cells[ACol,ARow]);
    End Else
    If  (aCol = QFColSel) and (aRow > 0) Then  Begin
       Canvas.Brush.Color := clTeal;
       Canvas.FillRect(Rect);
       Canvas.Font.Color := RGB(255,255,255);
       Canvas.TextOut(Rect.Left+2,Rect.Top+2, StrGrFileTable.Cells[ACol,ARow]);
    End;

  End;
End; {Procedure TfrmQueueFiles.StrGrFileTableDrawCell}

{***************************************************************}
procedure TfrmQueueFiles.StrGrFileTableMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     StrGrFileTable.Invalidate;
End;
{***************************************************************}

procedure TfrmQueueFiles.StrGrFileTableColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
var i, AbsAddr : Integer;
Begin
       QFColSel := ToIndex;

       for i := 0 to High(QFileList) do begin
        if QFileList[i].ColNr = FromIndex then AbsAddr := i;
       end;


       If  ToIndex < FromIndex Then Begin {Column Moved Left}
        for i := 0 to High(QFileList) do begin
          if (QFileList[i].ColNr >= ToIndex) and (QFileList[i].ColNr <= FromIndex) then
             QFileList[i].ColNr := QFileList[i].ColNr + 1;
        end;
       End Else
       If  ToIndex > FromIndex Then Begin {Column Moved Right}
        for i := 0 to High(QFileList) do begin
          if (QFileList[i].ColNr <= ToIndex) and (QFileList[i].ColNr >= FromIndex) then
             QFileList[i].ColNr := QFileList[i].ColNr - 1;
        end;
       End;

       QFileList[AbsAddr].ColNr := ToIndex;

       for i := 1 to StrGrFileTable.ColCount do StrGrFileTable.Cells[i,0] := IntToStr(i);

End;    {procedure TfrmQueueFiles.StrGrFileTableColumnMoved}
{***************************************************************}
procedure TfrmQueueFiles.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action        := caFree;
     frmQueueFiles := nil;
end;


procedure TfrmQueueFiles.ClearAllClick(Sender: TObject);
Begin
      If QFtabEmpty = False Then Begin
         With StrGrFileTable Do Begin
            QFColSel := 1;
            Col      := QFColSel;
            ColCount := 2;
            Cols[QFColSel].Clear;
            Width := ColCount*150;
            frmQueueFiles.Width := StrGrFileTable.Width + 10;
            QFtabEmpty := True;
         End;  {with}

          if (Sender = ClearAll) then QFileList   := nil;

          frmQueueFiles.Run.Enabled := Not(QFtabEmpty);
      End; {if QFtabEmpty = False}
End;  {TfrmQueueFiles.ClearAllClick}

{******************************************************************}
procedure TfrmQueueFiles.SetImageControl(const i : Integer);
var NotEvent : TNotifyEvent;
Begin

  With frmImageControl Do Begin

    Bkg           := QFileList[i].BackGr;
    CutOff        := QFileList[i].ImCutoff;
    SmoothMode    := QFileList[i].SmoothMode;
    SmoothOrder   := QFileList[i].SmoothOrder;
    BoxSmSize     := QFileList[i].BoxCarF;
    MedSmSize     := QFileList[i].MedianF;
    GaussSmSize   := QFileList[i].GaussF;
    ImageContrVar := QFileList[i].ImageContrVar;

    cbSmoothBeforeDoRatio.Checked := AutoSearchPar.SmoothBeforeDoRatio;

    If (SmoothMode in [SMOOTH_BOX_MED,SMOOTH_MED_BOX]) then Begin
      if (BoxSmSize = 3) and  not(ubBoxSmooth3x3.Selected) then begin
        ubBoxSmooth3x3.Selected := True;
        ubBoxSmooth5x5.Selected := False;
        ubBoxSmooth7x7.Selected := False;
      end;
      if (BoxSmSize = 5) and  not(ubBoxSmooth5x5.Selected) then begin
        ubBoxSmooth5x5.Selected := True;
        ubBoxSmooth3x3.Selected := False;
        ubBoxSmooth7x7.Selected := False;
      end;
      if (BoxSmSize = 7) and  not(ubBoxSmooth7x7.Selected) then begin
        ubBoxSmooth7x7.Selected := True;
        ubBoxSmooth5x5.Selected := False;
        ubBoxSmooth3x3.Selected := False;
      end;

      if (chbGauss.Checked) then begin
        NotEvent := chbGauss.OnClick;
        chbGauss.OnClick := nil;
        chbGauss.Checked := False;
        chbGauss.OnClick := NotEvent;
        GaussOn := False;
      end;
      if not(chbBox.Checked) then begin
        NotEvent := chbBox.OnClick;
        chbBox.OnClick := nil;
        chbBox.Checked := True;
        chbBox.OnClick := NotEvent;
        BoxcarOn := True;
      end;
    End;

    If (SmoothMode in [SMOOTH_GAUSS_MED,SMOOTH_MED_GAUSS]) then Begin
      if (GaussSmSize = GAUSS_3x3_LITE) and  not(unGaussSmooth3x3L.Selected) then begin
        unGaussSmooth3x3L.Selected := True;
        unGaussSmooth3x3M.Selected := False;
        unGaussSmooth3x3H.Selected := False;
        unGaussSmooth5x5.Selected  := False;
        unGaussSmooth7x7.Selected  := False;
      end;
      if (GaussSmSize = GAUSS_3x3_MEDIUM) and  not(unGaussSmooth3x3M.Selected) then begin
        unGaussSmooth3x3L.Selected := False;
        unGaussSmooth3x3M.Selected := True;
        unGaussSmooth3x3H.Selected := False;
        unGaussSmooth5x5.Selected  := False;
        unGaussSmooth7x7.Selected  := False;
      end;
      if (GaussSmSize = GAUSS_3x3_HEAVY) and  not(unGaussSmooth3x3H.Selected) then begin
        unGaussSmooth3x3L.Selected := False;
        unGaussSmooth3x3M.Selected := False;
        unGaussSmooth3x3H.Selected := True;
        unGaussSmooth5x5.Selected  := False;
        unGaussSmooth7x7.Selected  := False;
      end;
      if (GaussSmSize = GAUSS_5x5) and  not(unGaussSmooth5x5.Selected) then begin
        unGaussSmooth3x3L.Selected := False;
        unGaussSmooth3x3M.Selected := False;
        unGaussSmooth3x3H.Selected := False;
        unGaussSmooth5x5.Selected  := True;
        unGaussSmooth7x7.Selected  := False;
      end;
      if (GaussSmSize = GAUSS_7x7) and  not(unGaussSmooth7x7.Selected) then begin
        unGaussSmooth3x3L.Selected := False;
        unGaussSmooth3x3M.Selected := False;
        unGaussSmooth3x3H.Selected := False;
        unGaussSmooth5x5.Selected  := False;
        unGaussSmooth7x7.Selected  := True;
      end;

      if(chbBox.Checked) then begin
        NotEvent := chbBox.OnClick;
        chbBox.OnClick := nil;
        chbBox.Checked := False;
        chbBox.OnClick := NotEvent;
        BoxcarOn := False;
      end;
      if not(chbGauss.Checked) then begin
        NotEvent := chbGauss.OnClick;
        chbGauss.OnClick := nil;
        chbGauss.Checked := True;
        chbGauss.OnClick := NotEvent;
        GaussOn := True;
      end;
    End;


    if (MedSmSize = 3) and  not(ubMedSmooth3x3.Selected) then begin
        ubMedSmooth3x3.Selected := True;
        ubMedSmooth5x5.Selected := False;
        ubMedSmooth7x7.Selected := False;
    end;
    if (MedSmSize = 5) and  not(ubMedSmooth5x5.Selected) then begin
        ubMedSmooth5x5.Selected := True;
        ubMedSmooth3x3.Selected := False;
        ubMedSmooth7x7.Selected := False;
    end;
    if (MedSmSize = 7) and  not(ubMedSmooth7x7.Selected) then begin
        ubMedSmooth7x7.Selected := True;
        ubMedSmooth5x5.Selected := False;
        ubBoxSmooth3x3.Selected := False;
    end;

    NotEvent := chbMedian.OnClick;
    chbMedian.OnClick := nil;
    chbMedian.Checked := True; //always
    chbMedian.OnClick := NotEvent;
    MedianOn := True;

    if (SmoothOrder = FIRST_BOX_OR_GAUSS) then rbBoxOrGaussSm2DFirst.Checked := True else
    if (SmoothOrder = FIRST_MEDIAN)       then rbMedSm2DFirst.Checked := True;

    SetBackSubAndOtherSliders;

          {Deals with Frame}
    if QFileList[i].ApplyFrame = true then begin
      SelFrame.Left   := QFileList[i].SelFrame.Left;
      SelFrame.Right  := QFileList[i].SelFrame.Right;
      SelFrame.Top    := QFileList[i].SelFrame.Top;
      SelFrame.Bottom := QFileList[i].SelFrame.Bottom;
      ubApplyFrame.Selected := True;
      ubApplyFrame.Click;
    End;  {end with frame}


    If not(RatioOn) and not(AutoSearchPar.AutoAverImage) and
                 not(AutoSearchPar.StartAutoAverFirstIm) then
    Begin
      {if AutoAverImage and StartAutoAverFirstIm the
       AutoSearch procedure turns On the F/Fo button by itself }
      ubRatioOn.Selected := True;
      ubRatioOn.Click; ///keep it otherwise does work after that when is clicked 1st time
    End;

  End;//with
End;

{******************************************************************}
Procedure TfrmQueueFiles.RunClick(Sender: TObject);

var i,ColDone,n  : Integer;
    FileType         : Integer;
    First            : Boolean;
    ValidFile        : Boolean;
    EventType        : AnsiString;
    WriteEvents      : Boolean;
    FinalFName       : AnsiString;
    FinFreqFName     : AnsiString;
    RootFName        : AnsiString;
    RootFreqFName    : AnsiString;
    Comment          : AnsiString;
    FinalComment     : AnsiString;
Begin
          StopSearch := False;
          frmQueueFiles.BorderIcons := frmQueueFiles.BorderIcons - [biSystemMenu];

          MainForm.PwrSaveSparkAn.AllowSuspend    := False;
          MainForm.PwrSaveSparkAn.AllowStandby    := False;
          MainForm.PwrSaveSparkAn.AllowEndSession := False;
   {------------------------------------------}
          ColDone    := 1;
  While ColDone <= High(QFileList) + 1 Do Begin

          Application.ProcessMessages;
          If (StopSearch = True) Then Break;

         {-----------------------------}
    For i := 0 to High(QFileList) Do Begin
      If (QFileList[i].ColNr = ColDone) Then Begin

          Application.ProcessMessages;
          If StopSearch = True Then Break;
            {------ Starts Analysis ------------}

       {A: Open Image File}
      If (FileExists(QFileList[i].QFName)) then Begin
          ImTypeIndex := QFileList[i].FIndex; //sets the global ImTypeIndex
          OpenImageFile(QFileList[i].QFName,ImTypeIndex,False,True);

          {Highlight Columns}
          QFColSel           := ColDone;
          StrGrFileTable.Col := QFColSel;
          StrGrFileTable.Invalidate;
          {B: Sets All Conditions}
          {1st: Sets frmSPautoSearch Panel}

        With frmSPautoSearch Do Begin
          If (frmSPautoSearch = nil) then Application.CreateForm(TfrmSPautoSearch, frmSPautoSearch);
          AutoSearchPar := QFileList[i].AutoSrchPar;
          SetSPautoSearch(AutoSearchPar);
          dsSerchFromTo.SetSliderPos(QFileList[i].ImToBeg,QFileList[i].ImToEnd);
          EdnSearchFromTo.SetNumbersOneTwo(QFileList[i].ImToBeg+1,QFileList[i].ImToEnd+1);
        End; {With frmSPautoSearch Do Begin}
           {end with 1st}

         {B : Deals with Average Image}
         {1st: List of Images}
        for n := 0 to NrIm - 1 do AvImList[n] := 0;
        If (QFileList[i].AverImKind = AVER_ON_LINE) then Begin
           SetLength(QFileList[i].ListOfIm,QFileList[i].NrImInList);
           ImSel := QFileList[i].NrImInList;
           for n := 0 to High(QFileList[i].ListOfIm) do
           AvImList[QFileList[i].ListOfIm[n]] := 1;
           AvImExists := AVER_ON_LINE; {means On line Average}
           MakeAverIm;
        End Else
        If (QFileList[i].AverImKind in [AVER_FROM_FILE,AVER_WIIL_BE_GEN_FROM_1stIMAGE]) then Begin
           if (QFileList[i].AverImKind = AVER_FROM_FILE) then begin
            if FileExists(QFileList[i].AvFName) then
            AvImFPath := QFileList[i].AvFName;
            OpenAvImFile(AvImFPath,True)
            {this procedure set AvImExists := AVER_FROM_FILE ; = from File}
           end else
           if (QFileList[i].AverImKind = AVER_WIIL_BE_GEN_FROM_1stIMAGE) then begin
              {for now don't do anything - frmSpAutoSearch takes care}

              //Reconfirms Again Prevention of Widnows Suspend Mode
              //Because AutoSeach at the end Turns It Off
              MainForm.PwrSaveSparkAn.AllowSuspend    := False;
              MainForm.PwrSaveSparkAn.AllowStandby    := False;
              MainForm.PwrSaveSparkAn.AllowEndSession := False;
           end;
        End; {of Dealig with 3 types of Aver Images}

        If (AvImExists = AVER_ON_LINE) Then Begin
          if MovFType = QED_MOV {Solamere} then
             RootFName := Copy(ImFname,1,Length(ImFname)-7) else  {Full Path + FName}
          if MovFType in [ANDOR_MOV,STACK_BW_TIFF,BIORAD_PIC,NORAN_PRARIE_MOV,ZEISS_CZI_LSM_MOV,NORAN_SGI_MOV]
             then  RootFName := ImFname + '_Av';
             FinalFName := RootFName + '.ave';
            If (FileExists(FinalFName) = True) then Begin
              n := 1;
              While (FileExists(FinalFName) = True) Do Begin
                FinalFName := RootFName + '_' + IntToStr(n) + '.ave';
                Inc(n);
              End; {While}
            End; {If (FileExists(FinalFName) = True)}
              AvImFPath := FinalFName;
              SaveAverImageAsSpnOwnFile(AvImFPath);
              {this procedure sets AvImExists = 2 = From File}
        End; {of Saving AverIm File}
         {end of B}

         {C: Sets Image Control Settings}
        SetImageControl(i);

      {--------------------------------------------------------------------}
       frmSPautoSearch.StartSearchClick(Sender);  {Searches}
       //Reconfirms Again Prevention of Widnows Suspend Mode
       //Because AutoSeach at the end Turns It Off
       MainForm.PwrSaveSparkAn.AllowSuspend    := False;
       MainForm.PwrSaveSparkAn.AllowStandby    := False;
       MainForm.PwrSaveSparkAn.AllowEndSession := False;

            {Records Small Events if any}
            WriteEvents := False;
          For n := 0 to NrIm - 1 Do Begin
            If High(MarkSmEvCoor[n]) >= 0 Then Begin
              WriteEvents := True;
              Break;
            End;
          End;

            {Defines Mark File Name}
          if MovFType = QED_MOV {Solamere} then
          RootFName := Copy(ImFname,1,Length(ImFname)-7) + '_MarkSmEvCoor' else   //Full Path + FName//
          if MovFType in [ANDOR_MOV,STACK_BW_TIFF,BIORAD_PIC,NORAN_PRARIE_MOV,ZEISS_CZI_LSM_MOV,NORAN_SGI_MOV] then
          RootFName := ImFname + '_MarkSmEvCoor';   //Full Path + FName//

          FinalFName := RootFName + '.txt';

          If (FileExists(FinalFName) = True) then Begin
               n := 1;
            While (FileExists(FinalFName) = True) Do Begin
              FinalFName := RootFName + '_' + IntToStr(n) + '.txt';
              Inc(n);
            End; {While}
          End; {If (FileExists(MarkFName) = True)}

          EventType := 'SparkAn Mark File Small Events v.2';

          {Defines Custom Comment}
          Comment := CreateMarkComment(True,True);

        {end of defining comment}
       if (WriteEvents) then FinalComment := Comment else FinalComment := 'EMPTY ' + Comment;
       MainForm.WriteMarkFile(FinalFName,  EventType, MarkSmEvCoor,MarkSmAmpl,MarkSmBase,MarkSmEvDur,MarkSmEvRise,FinalComment,WriteEvents);

               {Records Big Events if any}
       If not(AutoSearchPar.IgnoreBigEv) then Begin

          WriteEvents := False;
          For n := 0 to NrIm - 1 Do Begin
            If High(MarkBigEvCoor[n]) >= 0 Then Begin
              WriteEvents := True;
              Break;
            End;
          End;


          if (MovFType =  QED_MOV) {Solamere} then
          RootFName := Copy(ImFname,1,Length(ImFname)-7) + '_MarkBigEvCoor' else   {Full Path + FName}
          if MovFType in [ANDOR_MOV,STACK_BW_TIFF,BIORAD_PIC,NORAN_PRARIE_MOV,ZEISS_CZI_LSM_MOV,NORAN_SGI_MOV] then
          RootFName := ImFname + '_MarkBigEvCoor';   {Full Path + FName}
          FinalFName := RootFName + '.txt';
          If (FileExists(FinalFName) = True) then Begin
               n := 1;
            While (FileExists(FinalFName) = True) Do Begin
              FinalFName := RootFName + '_' + IntToStr(n) + '.txt';
              Inc(n);
            End; {While}
          End; {If (FileExists(MarkFName) = True)}

          EventType := 'SparkAn Mark File Big Events v.2';

          if (WriteEvents) then FinalComment := Comment else FinalComment := 'EMPTY ' + Comment;
          MainForm.WriteMarkFile(FinalFName,  EventType, MarkBigEvCoor,MarkBigAmpl,MarkBigBase,MarkBigEvDur,MarkBigEvRise,FinalComment,WriteEvents);

         // WriteFreqFile(FinFreqFName,EventType, MarkBigEvCoor,QFileList[i].ImToBeg,
                //        QFileList[i].ImToEnd,FinalComment,WriteEvents);
       End; //If not(AutoSearchPar.IgnoreBigEv) then Begin
      {---------------------------------------------------------------------}

      End; {If (FileExists(QFileList[i].QFName)) then Begin}
            {----- End of Analysis of One File --}
      End; {If QFileList[i].ColNr = ColDone}

      if QFileList[i].ColNr = ColDone then Break; {Stops Unnecessary Search}

    End; {For i := 0 to High(QFileList)}
       Inc(ColDone);
  End; {While}

      frmQueueFiles.BorderIcons := frmQueueFiles.BorderIcons + [biSystemMenu];
      
      MainForm.PwrSaveSparkAn.AllowSuspend    := True;
      MainForm.PwrSaveSparkAn.AllowStandby    := True;
      MainForm.PwrSaveSparkAn.AllowEndSession := True;

End; {Procedure TfrmQueueFiles.RunClick(Sender: TObject);}
{******************************************************************}

procedure TfrmQueueFiles.StopQFanalClick(Sender: TObject);
begin
        StopSearch := True; {StopSearch is Common for SPautoSearch and QFiles Units}
end;
  {******************************************************************}
procedure TfrmQueueFiles.FormShow(Sender: TObject);
begin
       frmQueueFiles.ClientHeight  := StrGrFileTable.DefaultRowHeight*21 + 70;
     // StrGrFileTable.Height := StrGrFileTable//;
       if (StrGrFileTable.ColCount > 2) and (StrGrFileTable.Width < 720)
          then StrGrFileTable.Width := StrGrFileTable.ColCount*180;
          frmQueueFiles.Width := StrGrFileTable.Width + 20;
end;

procedure TfrmQueueFiles.FormResize(Sender: TObject);
begin
     if StrGrFileTable.ColCount > 3 then begin
         StrGrFileTable.Width := frmQueueFiles.ClientWidth - 20;
     end;
end;

End.
