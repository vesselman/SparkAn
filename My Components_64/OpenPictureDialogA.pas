
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2004 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit OpenPictureDialogA;
//modified by Adrian D. Bonev

{$R-,H+,X+}        //$R- Turn off range checking;
                   //$X directive is provided for backward compatibility
                   //$X directive enables or disables Delphi's extended syntax
                   //$H+ Delphi defines the generic string type to be the long AnsiString
                   //The generic type string can represent either a long,
                   //dynamically-allocated string (the fundamental type AnsiString)
                   //or a short, statically allocated string (the fundamental type ShortString).
interface

uses Messages, Windows, SysUtils, Classes, Controls, StdCtrls, Graphics,
     ExtCtrls, Buttons, Dialogs, Consts, JPeg, Grids,Menus;
    {all Sxxxxxxxx Const (for example: SPreviewLabel, SPictureDesc) are declared in Const}
/////////////////////////////////////////////////////////////////////////
     {SPictureDesc = ' (%dx%d)'}
Type
 {Used to Delete and Insert Row im Any StringGrid}
  TStringGridHack = class(TStringGrid)
  procedure DeleteRow(ARow: Longint); reintroduce;
End;

type
   TTableFileSelectEvent = procedure(Sender: TObject; ColIndex : Integer) of object;

////////////////////////////////////////////////////////////////////////


Type

{ TOpenPictureDialog }

//main means added by me (Adrian)//

  TOpenPictureDialogA = class(TOpenDialog)
  private
    FPicturePanel            : TPanel;
    FPictureLabel            : TLabel;
    FPreviewButton           : TSpeedButton;
    FPaintPanel              : TPanel;
    FImagePreview            : TImage;
    FSavedFilename           : string; {prevents double displaying}
    FAllowPreviewButton      : TSpeedButton;  //main
    FAllowPreview            : Boolean;       //main
    FLoadChAsIndivFiles      : Boolean;
    FFileListGrid            : TStringGrid;   //main
    FPopupMenuYesNo          : TPopupMenu;    //main TStandardMenuPopup
    FRemove                  : TMenuItem;     //main
    FClear                   : TMenuItem;     //main
    FGetInfo                 : TMenuItem;     //main
    FCancel                  : TMenuItem;     //main
    FValidFile               : Boolean;       //main - After SparkAn check File it sets this to display Image X & Y
    FTableVisibleAtFiltIntex : Integer;       //main ; at which Index FileListGrid is visible
    FTablePreviewAtFiltIntex : Integer;       //main ; at which Index FileListGrid is visible for Preview Only
    FOnFileAddToTable        : TNotifyEvent;  //main
    FOnClick                 : TNotifyEvent;  //main
    FOnSelectTableFile       : TTableFileSelectEvent;  //main
    FOnGetInfo               : TTableFileSelectEvent;  //main
    FMaxNrFilesInTable       : Word;          //main; Maximal Number of Files in File Table
    FCheckBox                : TCheckBox; //Open Channels as Individual Files = Each Files is Channel. Added Oct 3, 2016
    FCheckBoxClick           : TNotifyEvent;


    procedure FileAddToTableClick;                  //main
    procedure DoSelectTableFile(ColIndex : Integer);  //main
    procedure SelectTableFile  (ColIndex : Integer);  //main
    procedure DoGetInfo(ColIndex : Integer);     //main
    procedure GetInfo  (ColIndex : Integer);      //main

    procedure PreviewKeyPress(Sender: TObject; var Key: Char);

    {main procedures}
    procedure SetAllowPreview (Value: Boolean);                           //main
    procedure FileListGridRowMoved(Sender: TObject; FromIndex,            //main
              ToIndex: Integer);
    procedure FileListGridMouseDown(Sender: TObject; Button: TMouseButton;//main
                                Shift: TShiftState; X, Y: Integer);
    procedure FileListGridMouseUp(Sender: TObject; Button: TMouseButton;  //main
                              Shift: TShiftState; X, Y: Integer);
    procedure FileListGridDrawCell(Sender: TObject; ACol, ARow: Integer;  //main
                                Rect: TRect; State: TGridDrawState);
    procedure PopUpClick(Sender : TObject);                               //main
    procedure SetTableVisibleAtFiltIntex(Value : Integer);                //main
    procedure SetTablePreviewAtFiltIntex(Value : Integer);                //main
    procedure SetValidFile(Value : Boolean);                              //main
    procedure SetMaxNrFilesInTable(Value : Word);                         //main
    procedure SetFileTableTitle(Value : String);                      //main
    function  IsFileValid(const FileName: string): Boolean;                //was local in DoSelectionChange

  protected

    property PictureLabel: TLabel read FPictureLabel;
    procedure PreviewClick(Sender: TObject); virtual;
    procedure DoClose; override;
    procedure DoSelectionChange; override;  {modified}
    procedure DoShow; override;
    procedure AllowPreviewClick(Sender: TObject); virtual; //main
    procedure DoTypeChange; override; //main
    procedure ChangeFileLoading(Sender: TObject); virtual;
    procedure SetLoadChAsIndivFiles(Value: Boolean);

  public


    TableFileList : TStringList; //main
  //  property CheckBox : TCheckBox;
    property ValidFile : Boolean read FValidFile write SetValidFile; //main
    property ImagePreview: TImage read FImagePreview;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override; //main
    function Execute(ParentWnd: HWND): Boolean; override;
    procedure LoadFileTable;
    procedure ResetFileTable;
    property LoadChAsIndivFiles : Boolean read FLoadChAsIndivFiles write SetLoadChAsIndivFiles; //main;
    property CheckBox : TCheckBox read FCheckBox  write FCheckBox;

  published
    property  CheckBoxClick  : TNotifyEvent  read FCheckBoxClick  write FCheckBoxClick;
    property  TableVisibleAtFiltIntex : Integer read FTableVisibleAtFiltIntex write SetTableVisibleAtFiltIntex;
    property  TablePreviewAtFiltIntex : Integer read FTablePreviewAtFiltIntex write SetTablePreviewAtFiltIntex;
    property  AllowPreview : Boolean read FAllowPreview write SetAllowPreview default True;    //main
    property  OnFileAddToTable  : TNotifyEvent read FOnFileAddToTable write FOnFileAddToTable;  //main
    property  OnSelectTableFile : TTableFileSelectEvent read FOnSelectTableFile write FOnSelectTableFile;  //main
    property  OnGetInfo         : TTableFileSelectEvent read FOnGetInfo write FOnGetInfo;  //main
    property  MaxNrFilesInTable : Word read FMaxNrFilesInTable write SetMaxNrFilesInTable default 10; //main
    property  FileTableTitle : String write SetFileTableTitle; //main
  end;



  procedure Register;

/////////////////////// Original Procedures //////////////////////////////////

implementation

uses Math, Forms;

type
  TSilentPaintPanel = class(TPanel)
  protected
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
  end;

procedure TSilentPaintPanel.WMPaint(var Msg: TWMPaint);
begin
  try
    inherited;
  except
    Caption := SInvalidImage;
  end;
end;

{$R OpenPictureDialogA.res}



constructor TOpenPictureDialogA.Create(AOwner: TComponent); {modified}

begin
  inherited Create(AOwner);
  FAllowPreview := True;
  Tag           := 1; {Tag is used to Store FAllowPreview if it is turned off by Program but was on}
  FTableVisibleAtFiltIntex := 1;
  FTablePreviewAtFiltIntex := 1;
  FValidFile := False;
  FMaxNrFilesInTable := 10;
  TableFileList := TStringList.Create;

  FPicturePanel := TPanel.Create(Self);
  //this fiils up the whore right side and all extra things are positioned there
  with FPicturePanel do begin
    Name := 'PicturePanel'; 
    Caption := '';
    SetBounds(204, 5, 169, 200); {with is the max- cannot be more}
    BevelOuter := bvNone;
    BorderWidth := 6;
    TabOrder := 1;
    FPictureLabel := TLabel.Create(Self);
    with FPictureLabel do begin
      Name := 'PictureLabel';
      Caption := '';
      SetBounds(6, 6, 72, 23);
     // Align := alTop;  {if yes the length cannot be controlled - it fill the panel}
      AutoSize := False;
      Parent := FPicturePanel; {parent is needed for Windowed Controls Only}
    end;

    FPreviewButton := TSpeedButton.Create(Self);
    with FPreviewButton do begin
      Name := 'PreviewButton';
      SetBounds(77, 1, 23, 22);
      Enabled := False;
      Glyph.LoadFromResourceName(HInstance, 'PREVIEWBUTGLYPH');
      Hint := SPreviewLabel;
      ParentShowHint := False;
      ShowHint := True;
      OnClick := PreviewClick;
      Parent := FPicturePanel;
    end;

    FAllowPreviewButton := TSpeedButton.Create(Self);
    with FAllowPreviewButton do begin
      Name := 'AllowPreview';
      SetBounds(120, 1, 55, 22);
      Enabled := True;
      AllowAllUp := True;
      GroupIndex := 1;
      Layout := blGlyphRight;
      Caption := 'Allow';
      Glyph.LoadFromResourceName(HInstance, 'PREVIEWBUTGLYPH');
      Hint := 'Allow ' + SPreviewLabel;
      ParentShowHint := False;
      ShowHint := True;
      OnClick := AllowPreviewClick;
      Parent := FPicturePanel;
    end;

    FCheckBox := TCheckBox.Create(Self);
    with FCheckBox do begin
      Name := 'cbLoadAs2Channels';
      SetBounds(3, 392, 225, 22);
      Enabled := True;
      Checked := False;
      FLoadChAsIndivFiles := False;
      Caption := 'Open Channels as Individual Files';
      ParentShowHint := False;
      ShowHint := False;
      OnClick := ChangeFileLoading;
      Parent := FPicturePanel;
    end;


    FPaintPanel := TSilentPaintPanel.Create(Self);
    //this is where the image is displayed using FImagePreview (TImage)
    with FPaintPanel do begin
      Name := 'PaintPanel';
      Caption := '';
      SetBounds(3, 29, 203, 203);
    //  Align := alClient; streches TImage over the whole Panel
      BevelInner := bvRaised;
      BevelOuter := bvLowered;
      TabOrder := 0;
      FImagePreview := TImage.Create(Self);
      Parent := FPicturePanel;    
      with FImagePreview do begin
        Name := 'PaintBox';
        Align := alClient;
        OnDblClick := PreviewClick;
        Parent := FPaintPanel;
        Proportional := True;
        Stretch := True;
        Center := True;
        IncrementalDisplay := True;
      end;

     FPopupMenuYesNo:= TPopupMenu.Create(self);
     with FPopupMenuYesNo do begin
      FRemove := TMenuItem.Create(self);
      with FRemove do begin
        FRemove.Caption := 'Remove File from List';
        OnClick := PopUpClick;
      end;
      Items.Add(FRemove);
      FClear := TMenuItem.Create(self);
      with FClear do begin
        FClear.Caption := 'Clear All Files';
        OnClick := PopUpClick;
      end;
      Items.Add(FClear);

      FGetInfo :=  TMenuItem.Create(self);
      with FGetInfo do begin
        FGetInfo.Caption := 'Get Info';
        OnClick := PopUpClick;
      end;
      Items.Add(FGetInfo);

      FCancel :=  TMenuItem.Create(self);
      with FCancel do begin
        FCancel.Caption := 'Cancel';
        OnClick := PopUpClick;
      end;
      Items.Add(FCancel);
     end; //with FPopupMenuYesNo


      FFileListGrid := TStringGrid.Create(self);
      with FFileListGrid do begin
        Name := 'FileList';
        SetBounds(3, 238, 203, 155);
        ColCount := 2;
        RowCount := 2;
        FixedCols := 1;
        FixedRows := 1;
        Font.Name := 'Ariel';
        Font.Size := 8;
        DefaultRowHeight := 15;
        if (FilterIndex = FTableVisibleAtFiltIntex) then
        Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,
                    goDrawFocusSelected,goRowMoving,goThumbTracking] else
        if (FilterIndex = FTablePreviewAtFiltIntex) then
        Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,
                    goDrawFocusSelected,goThumbTracking];

        OnMouseDown := FileListGridMouseDown;
        OnMouseUp   := FileListGridMouseUp;
        OnDrawCell  := FileListGridDrawCell;
        OnRowMoved  := FileListGridRowMoved;

       {FFileListGrid.ParentWindow and  FFileListGrid.Parent should be done in DoShow}
      end; //with FFileListGrid
    end; //with FPaintPanel
  end; //with FPicturePanel
End; //End Create procedure

function TOpenPictureDialogA.IsFileValid(const FileName: string): Boolean;
    begin
      Result := GetFileAttributes(PChar(FileName)) <> $FFFFFFFF;
end;

procedure TOpenPictureDialogA.DoSelectionChange;
  {modified by me}

var
  FullName : string;

Begin
  {ValidFile has double meaning:
   initially it means that File exists and the FileName is right
   for Preview the Main Program does the check and returns the value of
   ValidFile to OpenPictureDialog. If True then the Program Displays the image
   on the Exposed ImagePreview (TImage); the OpenPictureDialog just prints the Size
   and takes care of Larger Preview. ValidFile also should be True to
   allow File Table to take a File}

    FullName   := FileName;     

  If FullName <> FSavedFilename then Begin

    FSavedFilename := FullName;
    FValidFile := FileExists(FullName) and IsFileValid(FullName);

    if (FValidFile) then begin

      {after checking if File is Valid then triggers DoSelectionChange}
      inherited DoSelectionChange;
      
      {here the Program should return the value of FValidFile and
      Display the Image on magePreview (TImage)}
      
      if (FValidFile) and (FAllowPreview) then begin
        FPictureLabel.Caption := Format(SPictureDesc,
        [FImagePreview.Picture.Width, FImagePreview.Picture.Height]);
        FPreviewButton.Enabled := True;
        FPaintPanel.Caption := '';
      end;
    end; //if (FValidFile)

    if not FValidFile then begin
      FPictureLabel.Caption := SPictureLabel;
      FPreviewButton.Enabled := False;
      FImagePreview.Picture := nil;
      FPaintPanel.Caption := srNone;
    end;
  End; //If FullName <> FSavedFilename


End; {DoSelectionChange}

procedure TOpenPictureDialogA.DoClose;
begin
  
  inherited DoClose;
  { Hide any hint windows left behind }
  Application.HideHint;
end;

procedure TOpenPictureDialogA.DoShow;
var
  PreviewRect, StaticRect, CellNr : TRect;
  i : Integer;


begin
  { Set preview area to entire dialog }
  GetClientRect(Handle, PreviewRect);
  StaticRect := GetStaticRect;
  { Move preview area to right of static area }
  PreviewRect.Left := StaticRect.Left + (StaticRect.Right - StaticRect.Left);
  Inc(PreviewRect.Top, 4);
  FPicturePanel.BoundsRect := PreviewRect;
  FPreviewButton.Left := FPaintPanel.BoundsRect.Right - FPreviewButton.Width - 2;
  FImagePreview.Picture := nil;
  FSavedFilename := '';
  FPaintPanel.Caption := srNone;
  FPicturePanel.ParentWindow := Handle;
  {added by me; should be done in this order}
  FFileListGrid.ParentWindow := FPicturePanel.Handle;
  FFileListGrid.Parent := FPicturePanel;

  FAllowPreviewButton.Down := FAllowPreview; //has to be here

  With FFileListGrid do Begin
   {FFileListGrid and FFileList should be always emptied
   because the keep thier contens even if file dialog was closed}
   if (FilterIndex = FTableVisibleAtFiltIntex) or
      (FilterIndex = FTablePreviewAtFiltIntex) then begin
    FFileListGrid.Visible := True;
    if (FilterIndex = FTableVisibleAtFiltIntex) then begin
        Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,
                    goDrawFocusSelected,goRowMoving,goThumbTracking];
        FRemove.Visible := True;
        FClear.Visible  := True;
    end else
    if (FilterIndex = FTablePreviewAtFiltIntex) then begin
        Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,
                    goDrawFocusSelected,goThumbTracking];
        FRemove.Visible := False;
        FClear.Visible  := False;
    end;
   end else
   FFileListGrid.Visible := False;

   TableFileList.Clear;
   ResetFileTable;

   for i := 0 to ColCount - 1 do begin
    if i = 0 then ColWidths[i] := 15 else
    if i = 1 then ColWidths[i] := ClientWidth - 16 else
    if i = 2 then ColWidths[i] := 1;
   end;
    Cells[0,0] := '#';
    if (FilterIndex = FTableVisibleAtFiltIntex) then FileTableTitle := 'Click to Add File' else
    if (FilterIndex = FTablePreviewAtFiltIntex) then FileTableTitle := ' ';
  
    {alligment should be done in FlistDrawCell procedure, does not work here}
     CellNr := CellRect(1, 0); {CellRect(aCol, aRow) cannot be passed to DrawEdge}
    {this should be last}
     DrawEdge(Canvas.Handle, CellNr, EDGE_RAISED, BF_RECT or BF_SOFT);
  End; //with FFileListGrid

  inherited DoShow;



end;

function TOpenPictureDialogA.Execute(ParentWnd: HWND): Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'PICDLGTEMPLATE' else
    Template := nil;
  Result := inherited Execute(ParentWnd);
end;


procedure TOpenPictureDialogA.PreviewClick(Sender: TObject);
var
  PreviewForm: TForm;
  Panel: TPanel;
begin

  PreviewForm := TForm.Create(Self);
  with PreviewForm do
  try
    Name := 'PreviewForm';
    Visible := False;
    Caption := SPreviewLabel;
    BorderStyle := bsSizeToolWin;
    KeyPreview := True;
    Position := poScreenCenter;
    OnKeyPress := PreviewKeyPress;
    Panel := TPanel.Create(PreviewForm);
    with Panel do
    begin
      Name := 'Panel';
      Caption := '';
      Align := alClient;
      BevelOuter := bvNone;
      BorderStyle := bsSingle;
      BorderWidth := 5;
      Color := clWindow;
      Parent := PreviewForm;
      DoubleBuffered := True;
      with TImage.Create(PreviewForm) do
      begin
        Name := 'Image';
        Align := alClient;
        Stretch := True;
        Proportional := True;
        Center := True;
        Picture.Assign(FImagePreview.Picture);
        Parent := Panel;
      end;
    end;
    if FImagePreview.Picture.Width > 0 then
    begin
      ClientWidth := Min(Monitor.Width * 3 div 4,
        FImagePreview.Picture.Width + (ClientWidth - Panel.ClientWidth)+ 10);
      ClientHeight := Min(Monitor.Height * 3 div 4,
        FImagePreview.Picture.Height + (ClientHeight - Panel.ClientHeight) + 10);
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TOpenPictureDialogA.PreviewKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then TForm(Sender).Close;
end;


////////////// My Procedures /////////////////////////


destructor TOpenPictureDialogA.Destroy; {implemened by me}
begin

  FreeAndNil(TableFileList);
  inherited Destroy; { always call the inherited destructor }

end;

procedure TOpenPictureDialogA.DoTypeChange;
begin

    if (FilterIndex = FTableVisibleAtFiltIntex) or
       (FilterIndex = FTablePreviewAtFiltIntex) then begin

      FFileListGrid.Visible := True;

      if (FilterIndex = FTableVisibleAtFiltIntex) then begin
        FileTableTitle := 'Click to Add File';
        FFileListGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,
                    goDrawFocusSelected,goRowMoving,goThumbTracking];
        FRemove.Visible := True;
        FClear.Visible  := True;
      end else
      if (FilterIndex = FTablePreviewAtFiltIntex) then begin
        FileTableTitle := ' ';
        FFileListGrid.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,
                    goDrawFocusSelected,goThumbTracking];
        FRemove.Visible := False;
        FClear.Visible  := False;
      end;

    end else
    FFileListGrid.Visible := False;
    
    inherited;
end;

procedure TOpenPictureDialogA.FileAddToTableClick;
begin
 if Assigned(FOnFileAddToTable) then
  if (FilterIndex = FTableVisibleAtFiltIntex) then FOnFileAddToTable(Self);
 {sends a message to Main Program that a File is About to be Included in Table}
end;

procedure TOpenPictureDialogA.DoSelectTableFile(ColIndex : Integer);
begin
 if Assigned(FOnSelectTableFile) then
  if (TableFileList.Count > 0) then begin
    FOnSelectTableFile(Self,ColIndex);
    SelectTableFile(ColIndex);
  end;
 {sends a message to Main Program that a File is About to be Included in Table}
end;

procedure TOpenPictureDialogA.SelectTableFile(ColIndex : Integer);
begin
    //do nothing -  sends message to Program//
end;

procedure TOpenPictureDialogA.DoGetInfo(ColIndex : Integer);
begin
 if Assigned(FOnGetInfo) then
  if (TableFileList.Count > 0) then begin
    FOnGetInfo(Self,ColIndex);
    GetInfo(ColIndex);
  end;
 {sends a message to Main Program For a File Table Index}
end;

procedure TOpenPictureDialogA.GetInfo(ColIndex : Integer);
begin
  {sends a message to Main Program For a File Table Index}
end;

procedure TOpenPictureDialogA.SetMaxNrFilesInTable(Value : Word);
begin
  if (Value <> FMaxNrFilesInTable) then FMaxNrFilesInTable := Value;
end;

  ///////////// StringGrid procedures /////////////

procedure TOpenPictureDialogA.SetFileTableTitle(Value : String);
begin
   if (Value <> FFileListGrid.Cells[1,0]) then FFileListGrid.Cells[1,0] := Value;
end;

procedure TOpenPictureDialogA.ResetFileTable;
var i : integer;
begin
  for i := 1 to FFileListGrid.RowCount-1 do FFileListGrid.Rows[i].Clear;
  FFileListGrid.RowCount := 2;
end;

procedure TOpenPictureDialogA.LoadFileTable;
  var i : integer;
begin

 if (TableFileList.Count > 0) then begin;
  for i := 1 to FFileListGrid.RowCount-1 do FFileListGrid.Rows[i].Clear;
  FFileListGrid.RowCount := TableFileList.Count+1;
  for i := 0 to TableFileList.Count-1 do begin
    FFileListGrid.Cells[1,i+1] := ExtractFileName(TableFileList.Strings[i]);
  end;
  FFileListGrid.Row := 1;
 end;
end;

Procedure TStringGridHack.DeleteRow(ARow: Longint);
var
  GemRow: Integer;
begin
  GemRow := Row;
  if RowCount > FixedRows + 1 then
    inherited DeleteRow(ARow)
  else
    Rows[ARow].Clear;
  if GemRow < RowCount then Row := GemRow;
end;

procedure TOpenPictureDialogA.PopUpClick(Sender : TObject);
  var R,NrRows : Integer;
      EventMem : TMovedEvent;

Begin

If (FilterIndex = FTableVisibleAtFiltIntex) Then Begin

  case TMenuItem(Sender).MenuIndex of
    0 : begin    {Remove [delete] File from List}
          EventMem := FFileListGrid.OnRowMoved;
          FFileListGrid.OnRowMoved := nil; //prevents OnRowMoved generation
          TableFileList.Delete(FFileListGrid.Row-1);
          { Index gives the position of the string, where 0 is the first string in TStrings}
          FFileListGrid.Rows[FFileListGrid.Row].Clear;
          TStringGridHack(FFileListGrid).DeleteRow(FFileListGrid.Row);
          NrRows := FFileListGrid.RowCount-1;
          for R := 1 to NrRows do FFileListGrid.Cells[0,R] := IntToStr(R);
          FFileListGrid.OnRowMoved := EventMem;
        end;
    1 : begin  {Clear All Files}
          TableFileList.Clear;
          NrRows := FFileListGrid.RowCount-1;
          for R := 1 to NrRows do FFileListGrid.Rows[R].Clear;
          FFileListGrid.RowCount := 2;
        end;
    2 : begin
          DoGetInfo(FFileListGrid.Row); //sends message to program with tableindex
        end;

    3 : begin {Cancel}
         {do nothing}
        end;
  end; //case
  if TMenuItem(Sender).MenuIndex in[0,1] then with FFileListGrid do begin
    if Not(RowCount > FMaxNrFilesInTable) then FileTableTitle := 'Click to Add File' else
                                               FileTableTitle := 'File List is Full';
  end;
 End; //(FilterIndex = FTableVisibleAtFiltIntex)
 If (FilterIndex = FTablePreviewAtFiltIntex) Then Begin
  case TMenuItem(Sender).MenuIndex of
    2 : begin
          DoGetInfo(FFileListGrid.Row); //sends message to program with tableindex
        end;

    3 : begin {Cancel}
         {do nothing}
        end;

  end; //case
 End; //If (FilterIndex = FTablePreviewAtFiltIntex)

End;

procedure TOpenPictureDialogA.FileListGridRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);

  var i  : integer;

begin
  //renumbers
  for i := 1 to FFileListGrid.RowCount -1 do FFileListGrid.Cells[0,i] := IntToStr(i);
  TableFileList.Move(FromIndex-1,ToIndex-1);
   
End;

procedure TOpenPictureDialogA.FileListGridMouseDown(Sender: TObject;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  var aCol,aRow : integer;
      CellNr : TRect;
 Begin

 With FFileListGrid Do Begin
  MouseToCell(x, y, aCol, aRow);

  {adding Files to table}

    If (aCol = 1) and (aRow = 0) and Not(FFileListGrid.RowCount > FMaxNrFilesInTable) then Begin
      //makes it to go down//
      if (FilterIndex = FTableVisibleAtFiltIntex) then begin
        {if Clicked on "Click to Add File" cell}
        CellNr := CellRect(aCol, aRow);
        DrawEdge(Canvas.Handle, CellNr, EDGE_SUNKEN, BF_RECT or BF_SOFT);
        {all the Job is done in MouseUp in order 1st to DrawEdge}
      end;
    End Else
    If (button = mbRight) then Begin
      if (aCol = 1) and (aRow > 0) then begin 
        FFileListGrid.Row := aRow;
        FFileListGrid.SetFocus;
        if (TableFileList.Count > 0) then begin
          FRemove.Enabled := True;
          FClear.Enabled := True;
          FGetInfo.Enabled := True;
        end else
        begin
          FRemove.Enabled := False;
          FClear.Enabled := False;
          FGetInfo.Enabled := False;
        end;
        FPopUpMenuYesNo.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
      end;
    End; //If (button = mbRight)  


   {Preview from table}
 If (button = mbLeft)  then  Begin {adds file to table}
  if (aCol = 1) and (aRow > 0) {and (ContainsCollection)} then
    if (TableFileList.Count > 0) then DoSelectTableFile(aRow); //sends event Only if Table Contains Something
 End; //If (button = mbLeft)

 End; // With FFileListGrid

End;  //procedure TOpenPictureDialogA.FileListGridMouseDown


Procedure TOpenPictureDialogA.FileListGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  
  var aRow, aCol : Integer;
      CellNr     : TRect;
begin

 If (FilterIndex = FTableVisibleAtFiltIntex) then begin

  If (button = mbLeft) then With FFileListGrid Do Begin
    FFileListGrid.MouseToCell(x, y, aCol, aRow);
    If (aCol = 1) and (aRow = 0) then begin
      CellNr := FFileListGrid.CellRect(aCol, aRow);
      CellNr := FFileListGrid.CellRect(1, 0);
      DrawEdge(FFileListGrid.Canvas.Handle, CellNr, EDGE_RAISED, BF_RECT or BF_SOFT);

      {check if File is Valid - i.e if has been selected}

        FValidFile := FileExists(FileName) and IsFileValid(FileName);
      If (FValidFile) then begin

          FileAddToTableClick;  {Sends Message to Main Program to check if File is Valid}

        If (FValidFile) then Begin //returned from Program//
          If (RowCount <= FMaxNrFilesInTable) then Begin

            if FFileListGrid.Cells[1,FFileListGrid.RowCount-1] <> '' then
               FFileListGrid.RowCount := FFileListGrid.RowCount + 1;

              FFileListGrid.Cells[0,FFileListGrid.RowCount-1] := IntToStr(FFileListGrid.RowCount-1);
              FFileListGrid.Cells[1,FFileListGrid.RowCount-1] := ExtractFileName(FileName);    //ExtractFileName

              TableFileList.Add(FileName);
                { Index gives the position of the string, where 0 is the first string}
              if (RowCount > FMaxNrFilesInTable) then  FileTableTitle := 'File List is Full';
            End Else
            If (RowCount > FMaxNrFilesInTable) then  FileTableTitle := 'File List is Full';
        End;//If (FValidFile) returned from Program then Begin
      End; //If (FValidFile) From OpenDialog


    End; //if (aCol = 1) and (aRow = 0)

  End; //If (button = mbLeft)
 End; //if (FilterIndex = FTableVisibleAtFiltIntex)


End; {Procedure FileListMouseUp}

procedure TOpenPictureDialogA.FileListGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  {alligment should be done here}
  Var  s   :  string;

  function XCenter (rect:  TRect; canvas:  TCanvas; s:  STRING):  INTEGER;
    begin
    RESULT := ((rect.Left + rect.Right) - canvas.TextWidth(s)) DIV 2
  end {XCenter};

  function YCenter (rect:  TRect; canvas:  TCanvas; s:  STRING):  INTEGER;
    begin
    RESULT := ((rect.Top + rect.Bottom) - canvas.TextHeight(s)) DIV 2
  end; {YCenter}

 Begin

  If (ACol = 1) and (ARow = 0) then with FFileListGrid do Begin
      {do not use    FFileListGrid.Font but FFileListGrid.Canvas.Font !!!}
    if Not(RowCount > FMaxNrFilesInTable) then Canvas.Font.Color := clBlack
                          else Canvas.Font.Color := clRed;
    s := Cells[aCol, aRow];
    Canvas.TextRect(Rect,XCenter(Rect, FFileListGrid.Canvas, s),
                   YCenter(Rect, FFileListGrid.Canvas, s),  s);

  End;
End;  //procedure

///////////// End of StringGrid procedures //////////////////////


procedure TOpenPictureDialogA. SetValidFile(Value: Boolean);
begin
   if (Value <> FValidFile) then FValidFile := Value;

end;

procedure TOpenPictureDialogA.SetTableVisibleAtFiltIntex(Value : Integer);
 begin
   if (Value <> FTableVisibleAtFiltIntex) then
      FTableVisibleAtFiltIntex := Value;
end;

procedure TOpenPictureDialogA.SetTablePreviewAtFiltIntex(Value : Integer);
 begin
   if (Value <> FTablePreviewAtFiltIntex) then
      FTablePreviewAtFiltIntex := Value;
end;

procedure TOpenPictureDialogA.SetAllowPreview(Value: Boolean);
begin

    if (Value <> FAllowPreview) then begin
      FAllowPreview := value;
      FAllowPreviewButton.Down := FAllowPreview;
    end; 

end;

procedure TOpenPictureDialogA.AllowPreviewClick(Sender: TObject);  //my proc
  begin
  FPreviewButton.Enabled := FAllowPreviewButton.Down;
  FAllowPreview          := FAllowPreviewButton.Down;
End;

procedure TOpenPictureDialogA.ChangeFileLoading(Sender: TObject);  //my proc
begin
  FLoadChAsIndivFiles := FCheckBox.Checked;
  if FCheckBox.Checked then FCheckBoxClick(self);
End;

procedure TOpenPictureDialogA.SetLoadChAsIndivFiles(Value : Boolean);  //my proc
begin
  if (Value <> FCheckBox.Checked) then FCheckBox.Checked := Value;
End;


///////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Dialogs',[TOpenPictureDialogA]);
end;

///////////////////////////////////////////////////////////////////////////////







end.
