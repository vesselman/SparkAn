unit unSurfaceROI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs, Vcl.Grids;


type
  TfrmSurfaceROI = class(TForm)
    SurfaceStringGrid: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateSize;
    procedure FillSurfaceTable;
  end;

var
  frmSurfaceROI: TfrmSurfaceROI;

implementation

uses unGlobUnit;

{$R *.dfm}

procedure TfrmSurfaceROI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action         := caFree;
   frmSurfaceROI  := nil;
end;

procedure TfrmSurfaceROI.FormCreate(Sender: TObject);
begin

  with SurfaceStringGrid do begin
    RowCount := GetFreeHandROInumber + 1;
    Cells[0,0] := 'ROI #';  {This Goes on Fixed (Gray Cell}
    ColWidths[1] := 80;
    Cells[1,0] := 'Surface (' + Chr(181) + 'm ' + Chr(178) + ')';
   end; {With StringGridSparks ....}

   SurfaceStringGrid.Height   := SurfaceStringGrid.RowCount*22;
   frmSurfaceROI.ClientHeight := SurfaceStringGrid.Height + 5;
   frmSurfaceROI.ClientWidth  := SurfaceStringGrid.Width + 6;
   frmSurfaceROI.Constraints.MaxHeight := frmSurfaceROI.Height;
   frmSurfaceROI.Constraints.MaxWidth  := frmSurfaceROI.Width;
   frmSurfaceROI.Constraints.MinWidth  := frmSurfaceROI.Width;

   FillSurfaceTable;                                           

end;

procedure TfrmSurfaceROI.UpdateSize;
begin

  SurfaceStringGrid.Height   := SurfaceStringGrid.RowCount*22;
  frmSurfaceROI.Constraints.MaxHeight := 0;
  frmSurfaceROI.ClientHeight := SurfaceStringGrid.Height + 6;
  frmSurfaceROI.Constraints.MaxHeight := frmSurfaceROI.Height;
end;

procedure TfrmSurfaceROI.FillSurfaceTable;
var CntFreeHandROI,i,CntY,CntX, NrPix : Integer;
    Surface : Double;
Begin

  CntFreeHandROI := 0;

  For i := 1 to 20 Do Begin

    If (ROIvar.ROIAdr[i] = 3) Then Begin
      //Write the ROI number
      Inc(CntFreeHandROI);
      SurfaceStringGrid.Cells[0,CntFreeHandROI] := IntToStr(i);

      //Get Surface
        NrPix := 0;
      For CntY := 0 to High(FhTbl[i]) Do Begin
        {more then one Pixel -> High(FhTbl[i,CntY]) > 0}
        If (High(FhTbl[i,CntY]) > 0) Then Begin
          CntX       := 0;
          While CntX < High(FhTbl[i,CntY]) Do Begin
            Inc(NrPix,(FhTbl[i,CntY,CntX + 1].X - FhTbl[i,CntY,CntX].X + 1));
            Inc(CntX,2);
          End; {while}
        End Else {If (High(FhTbl[i,CntY]) > 0) Then Begin}
           {For One Pixel -> High(FhTbl[i,CntY]) = 0}
          If (High(FhTbl[i,CntY]) = 0) Then Begin
            Inc(NrPix);
          End; {(High(FhTbl[CurROIadr,CntY]) = 0)  Single Pixel}

          //Write Surface
          Surface := NrPix*PixSize*PixSize;
          SurfaceStringGrid.Cells[1,CntFreeHandROI] := IntToStr(Round(Surface));

      End; {For CntY := 0 to High(TabFh) do begin}  

      //-------------------------
    End; //If (ROIvar.ROIAdr[i] = 3
  End;
End; //FillSurfaceTable

END.
