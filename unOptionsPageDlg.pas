{$D-,L-,O+,Q-,R-,Y-,S-}
unit unOptionsPageDlg;

interface

uses  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
      Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls,
      Vcl.Dialogs, Vcl.ActnMan, Vcl.ActnColorMaps, Vcl.ToolWin,Vcl.Menus,
      Vcl.ImgList, Vcl.Mask, unGlobUnit, EditNumerical, SuperSubLabel;

type
  TOptionsPagesDlg = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    ShapeROIMonoColor: TShape;
    ColorDialogROI: TColorDialog;
    CheckBoxUseSameColForROI: TCheckBox;
    TitleSetROIColor: TLabel;
    BevelSetColor: TBevel;
    TitleROIthickness: TLabel;
    TitleROIthickFactor: TLabel;
    trbThickerROI: TTrackBar;
    trbROIthickness: TTrackBar;
    BevelThickness: TBevel;
    ShapeROI: TShape;
    ShapeROIthicker: TShape;
    trbFreeHandThickness: TTrackBar;
    ShapeFreeHand: TShape;
    TitleFreeHand: TLabel;
    ShapeFontColor: TShape;
    TitleSetFontColor: TLabel;
    CheckBoxUseSameFontCol: TCheckBox;
    BevelFontColor: TBevel;
    CheckBoxEnableROINumbers: TCheckBox;
    BevelROINr: TBevel;
    trbMarkWith: TTrackBar;
    trbMarkSize: TTrackBar;
    TitleSetMarkTable1Color: TLabel;
    imgMarkBkg: TImage;
    BevelMark: TBevel;
    Label1: TLabel;
    TitMarkThick: TLabel;
    shSmEvent: TShape;
    shBigEvent: TShape;
    TitTable2MarkColor: TLabel;
    DisplayBigMarks: TCheckBox;
    DisplaySmallMarks: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    titMainWindow: TLabel;
    titAvWindow: TLabel;
    Bevel3: TBevel;
    EnableROIonAverWin: TCheckBox;
    ShowSmMarksOnAverWin: TCheckBox;
    ShowBigMarksOnAverWin: TCheckBox;
    trbSymbSize: TTrackBar;
    shSymbSize: TShape;
    lblSymbSize: TLabel;
    Bevel5: TBevel;
    Label2: TLabel;
    AlwaysUseSymb: TCheckBox;
    GenGenSetComm: TCheckBox;
    GenAutoSearchComm: TCheckBox;
    PromptForComment: TCheckBox;
    Bevel6: TBevel;
    Bevel7: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    trbMesLineThickness: TTrackBar;
    Label5: TLabel;
    MesLineColor: TShape;
    Label6: TLabel;
    Bevel8: TBevel;
    MesLineThickness: TShape;
    ckbKeepOldROI: TCheckBox;
    Bevel9: TBevel;
    MaxRatio: TTrackBar;
    lbMaxRatio: TLabel;
    Label7: TLabel;
    Bevel10: TBevel;
    btCorrectTime: TButton;
    Bevel11: TBevel;
    Label8: TLabel;
    Im1: TImage;
    Im15: TImage;
    Im3: TImage;
    Im19: TImage;
    Im5: TImage;
    Im2: TImage;
    Im7: TImage;
    Im17: TImage;
    Im9: TImage;
    Im11: TImage;
    Im13: TImage;
    Bevel13: TBevel;
    Im4: TImage;
    Im6: TImage;
    Im8: TImage;
    Im10: TImage;
    Im12: TImage;
    Im14: TImage;
    Im16: TImage;
    Im18: TImage;
    Im20: TImage;
    ShapeSelFrame: TShape;
    Label9: TLabel;
    ListBoxColor: TListBox;
    UndueColors: TToolBar;
    ColUnDo: TToolButton;
    ColReDo: TToolButton;
    ResToOriginal: TButton;
    Label10: TLabel;
    ResetToInitial: TButton;
    PopupMenuYesNo: TPopupMenu;
    Yes: TMenuItem;
    Cancel: TMenuItem;
    Bevel14: TBevel;
    AllowFullPathOfLastFile: TCheckBox;
    Bevel15: TBevel;
    MaxGamma: TTrackBar;
    lbMaxGamma: TLabel;
    tlGamma: TLabel;
    Gam: TLabel;
    ImageListArrowsEnabled: TImageList;
    ImageListArrowsDisabl: TImageList;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    OKBtn: TButton;
    tlMajorPixSetTitle: TLabel;
    Bevel17: TBevel;
    tl100micr: TLabel;
    lbMicronsPix: TLabel;
    Bevel18: TBevel;
    ChBoxNikonND2orTiff: TCheckBox;
    ChBoxNoranPrairie: TCheckBox;
    ChBoxTiffStack: TCheckBox;
    CbAndorTiffs: TCheckBox;
    ChBoxTIFF: TCheckBox;
    tlCheckToOverride: TLabel;
    lbPixPer100Microns: TLabel;
    lbCurFileInfo: TLabel;
    lbBinning: TLabel;
    Bevel19: TBevel;
    cbUseMoviFilePath: TCheckBox;
    Bevel20: TBevel;
    cbAlignXofImagePlayback: TCheckBox;
    TtlTimeSerPlot: TLabel;
    tlFrmSec: TLabel;
    Bevel21: TBevel;
    ChbCheckAllFilesExist: TCheckBox;
    ChBLoadTimeStamps: TCheckBox;
    Bevel22: TBevel;
    CbStreamPix: TCheckBox;
    NoranPrairieEdPix: TEditNumerical;
    StreamPixEdPix: TEditNumerical;
    AndorEdPix: TEditNumerical;
    NikonEdPix: TEditNumerical;
    StackGenTiffEdPix: TEditNumerical;
    SingleGenTiffEdPix: TEditNumerical;
    StackTiffFrmSec: TEditNumerical;
    SingleGenTiffFrmSec: TEditNumerical;
    Bevel4: TBevel;
    Label11: TLabel;
    Label12: TLabel;
    LSTimeBarColor: TShape;
    Label13: TLabel;
    trbLSTimeBarThickness: TTrackBar;
    LSTimeBarThickness: TShape;
    Label14: TLabel;
    Label15: TLabel;
    enLSTimeBarDuration: TEditNumerical;
    cbLSTimeBarVisible: TCheckBox;
    ChBoxBioRad: TCheckBox;
    BioRadEdPix: TEditNumerical;
    enLineCapsWidth: TEditNumerical;
    Label16: TLabel;
    ChBoxZeiss: TCheckBox;
    ZeissLSMEdPix: TEditNumerical;
    Label17: TLabel;
    Label18: TLabel;
    enSizeBarLenghtINµm: TEditNumerical;
    Label19: TLabel;
    Label20: TLabel;
    enGridDensity: TEditNumerical;
    Label21: TLabel;
    procedure SingleGenTiffFrmSecReturnPressed(Sender: TObject);
    procedure StackTiffFrmSecReturnPressed(Sender: TObject);
    procedure NikonEdPixReturnPressed(Sender: TObject);
    procedure SingleGenTiffEdPixReturnPressed(Sender: TObject);
    procedure StackGenTiffEdPixReturnPressed(Sender: TObject);
    procedure AndorEdPixReturnPressed(Sender: TObject);
    procedure StreamPixEdPixReturnPressed(Sender: TObject);
    procedure NoranPrairieEdPixReturnPressed(Sender: TObject);
    procedure ShapeROIMonoColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CheckBoxUseSameColForROIClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure trbROIthicknessChange(Sender: TObject);
    procedure trbThickerROIChange(Sender: TObject);
    procedure trbFreeHandThicknessChange(Sender: TObject);
    procedure CheckBoxUseSameFontColClick(Sender: TObject);
    procedure ShapeFontColorMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CheckBoxEnableROINumbersClick(Sender: TObject);
    procedure trbMarkWithChange(Sender: TObject);
    procedure trbMarkSizeChange(Sender: TObject);
    procedure shSmEventMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shBigEventMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DisplaySmallMarksClick(Sender: TObject);
    procedure DisplayBigMarksClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowSmMarksOnAverWinClick(Sender: TObject);
    procedure ShowBigMarksOnAverWinClick(Sender: TObject);
    procedure EnableROIonAverWinClick(Sender: TObject);
    procedure trbSymbSizeChange(Sender: TObject);
    procedure shSymbSizeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AlwaysUseSymbClick(Sender: TObject);
    procedure PromptForCommentClick(Sender: TObject);
    procedure GenGenSetCommClick(Sender: TObject);
    procedure GenAutoSearchCommClick(Sender: TObject);
    procedure trbMesLineThicknessChange(Sender: TObject);
    procedure MesLineColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ckbKeepOldROIClick(Sender: TObject);
    procedure MaxRatioChange(Sender: TObject);
    procedure btCorrectTimeClick(Sender: TObject);
    procedure Im1Click(Sender: TObject);
    procedure Im2Click(Sender: TObject);
    procedure Im3Click(Sender: TObject);
    procedure Im4Click(Sender: TObject);
    procedure Im5Click(Sender: TObject);
    procedure Im6Click(Sender: TObject);
    procedure Im7Click(Sender: TObject);
    procedure Im8Click(Sender: TObject);
    procedure Im9Click(Sender: TObject);
    procedure Im10Click(Sender: TObject);
    procedure Im11Click(Sender: TObject);
    procedure Im12Click(Sender: TObject);
    procedure Im13Click(Sender: TObject);
    procedure Im14Click(Sender: TObject);
    procedure Im15Click(Sender: TObject);
    procedure Im16Click(Sender: TObject);
    procedure Im17Click(Sender: TObject);
    procedure Im18Click(Sender: TObject);
    procedure Im19Click(Sender: TObject);
    procedure Im20Click(Sender: TObject);
    procedure ShapeSelFrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ColUnDoClick(Sender: TObject);
    procedure ColReDoClick(Sender: TObject);
    procedure ResToOriginalClick(Sender: TObject);
    procedure ResetToInitialClick(Sender: TObject);
    procedure YesClick(Sender: TObject);
    procedure AllowFullPathOfLastFileClick(Sender: TObject);
    procedure MaxGammaChange(Sender: TObject);
    procedure ChBoxNikonND2orTiffClick(Sender: TObject);
    procedure ChBoxNoranPrairieClick(Sender: TObject);
    procedure ChBoxTiffStackClick(Sender: TObject);
    procedure CbAndorTiffsClick(Sender: TObject);
    procedure ChBoxTIFFClick(Sender: TObject);
    procedure cbUseMoviFilePathClick(Sender: TObject);
    procedure cbAlignXofImagePlaybackClick(Sender: TObject);
    procedure ChbCheckAllFilesExistClick(Sender: TObject);
    procedure ChBLoadTimeStampsClick(Sender: TObject);
    procedure CbStreamPixClick(Sender: TObject);
    procedure LSTimeBarColorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trbLSTimeBarThicknessChange(Sender: TObject);
    procedure enLSTimeBarDurationReturnPressed(Sender: TObject);
    procedure cbLSTimeBarVisibleClick(Sender: TObject);
    procedure BioRadEdPixReturnPressed(Sender: TObject);
    procedure ChBoxBioRadClick(Sender: TObject);
    procedure enLineCapsWidthReturnPressed(Sender: TObject);
    procedure ChBoxZeissClick(Sender: TObject);
    procedure ZeissLSMEdPixReturnPressed(Sender: TObject);
    procedure enSizeBarLenghtINµmReturnPressed(Sender: TObject);
    procedure enGridDensityReturnPressed(Sender: TObject);


  private
    { Private declarations }
     ResetCode         : Byte;
     ChangeInMarks     : Boolean;
     ChangePlotSet     : Boolean;
     AvImSmoothChange  : Boolean;
     ROIcolChange      : Boolean;
     PixSetChange      : Boolean;
     LSSettingChange   : Boolean;
     MesLineChange     : Boolean;
     ButCol            : TROIColArr; {20 ROI }
     FntCol            : TFontColArr;
     ButColBack        : TROIColArr; {20 ROI }
     FntColBack        : TFontColArr;
     SelFrameColorBack : TColor;

     {last Color [ROI or Font}
     LastCol           : Byte;
     {Last Type changed - ROI [= 1]; or Font[=2]; or Frame[=3]}
     LastType          : Byte;
     {Last State: 1 = Use ButCol or FntCol; 2 = Use BackUp array}
     LastState         : Byte;

     Procedure DrawMark;
     procedure ReplotAverImage;
     Procedure ChangeButCol(const Img : TImage);
     Procedure RestoreColSettings(const Img : TImage);
     Procedure GetImNrAndDoReset;
     Procedure SetButImages;
     Procedure SetFinalColorSettings;
     Procedure ResToBuildIn;
     procedure ResetToBeg;
  public
    { Public declarations }
  end;



Var
  OptionsPagesDlg : TOptionsPagesDlg;



implementation

  Uses unMainWindow, unAverIm, unTimeSerAnal,unImageControl,
  unPlayBack, unLineScan, unMergeWindow, un2ndWin;


{$R *.dfm}

procedure TOptionsPagesDlg.ShapeROIMonoColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If ColorDialogROI.Execute Then Begin
           ShapeROIMonoColor.Brush.Color := ColorDialogROI.Color;
           ROIvar.MonoCol := ColorDialogROI.Color;

     End;
end;

procedure TOptionsPagesDlg.CheckBoxUseSameColForROIClick(Sender: TObject);
begin
          ROIvar.UseMonoCol := CheckBoxUseSameColForROI.Checked;
end;




procedure TOptionsPagesDlg.FormCreate(Sender: TObject);
        var i : integer;
            TemFTitle : AnsiString;

begin
         AllowFullPathOfLastFile.Checked  := AllowFullPath;
         ChbCheckAllFilesExist.Checked    := CheckAllFilesExist;
         ChBLoadTimeStamps.Checked        := LoadStreamPixAndND2TimeSt;
         ShapeROIMonoColor.Brush.Color    := ROIvar.MonoCol;
         trbThickerROI.Position           := ROIvar.Ticker div ROIvar.TckNess;
         trbThickerROI.Tag                := trbThickerROI.Position;
         trbROIthickness.Position         := ROIvar.TckNess;
         trbROIthickness.Tag              := trbROIthickness.Position;
         trbFreeHandThickness.Position    := ROIvar.FhTickness;
         trbFreeHandThickness.Tag         := trbFreeHandThickness.Position;
         CheckBoxUseSameColForROI.Checked := ROIvar.UseMonoCol;
         CheckBoxUseSameFontCol.Checked   := ROIvar.UseMonoFontCol;
         ShapeFontColor.Brush.Color       := ROIvar.MonoFontCol;
         CheckBoxEnableROINumbers.Checked := ROIvar.UseROINr;
         trbMarkSize.Position             := MarkPar.Size;
         trbMarkSize.Tag                  := trbMarkSize.Position;
         trbMarkWith.Position             := Markpar.Thick;
         trbMarkWith.Tag                  := trbMarkWith.Position;
         DrawMark;
         shSmEvent .Brush.Color           := MarkPar.SmallEventColor;
         shBigEvent.Brush.Color           := MarkPar.BigEventColor;
         DisplaySmallMarks.Checked        := MarkPar.DisplaySmEvents;
         DisplayBigMarks.Checked          := MarkPar.DisplayBigEvents;
         ChangeInMarks                    := False;
         EnableROIonAverWin.Checked       := ROIvar.ROIonAverWin;
         ShowSmMarksOnAverWin.Checked     := MarkPar.ShowSmEvOnAverWin;
         ShowBigMarksOnAverWin.Checked    := MarkPar.ShowBigEvOnAverWin;
         AvImSmoothChange                 := False;
         ChangePlotSet                    := False;
         trbSymbSize.Position             := TimPltSlid.SymbSize;
         trbSymbSize.Tag                  := trbSymbSize.Position;
         shSymbSize.Brush.Color           := TimPltSlid.SymbFromTableCol;
         shSymbSize.Pen.Color             := TimPltSlid.SymbFromTableCol;
         AlwaysUseSymb.Checked            := TimPltSlid.AlwaysUseSymb;
         PromptForComment.Checked         := MarkPar.PromptForComment;
         GenAutoSearchComm.Checked        := MarkPar.GenAutoSearchComm;
         GenGenSetComm.Checked            := MarkPar.GenGenSetComm;
         ckbKeepOldROI.Checked            := ROIvar.KeepOldROI;
         //Measuring Line
         trbMesLineThickness.Position     := MesLineVar.Thickness;
         MesLineColor.Brush.Color         := MesLineVar.Color;
         MesLineThickness.Brush.Color     := MesLineVar.Color;
         MesLineThickness.Pen.Color       := MesLineVar.Color;
         if (MesLineVar.CapsWitdh <> 0) then
         enLineCapsWidth.NumberOne        := MesLineVar.CapsWitdh*2 + 1 else
         enLineCapsWidth.NumberOne        := 0;
         MesLineChange                    := False;
         // Line Scan Time Bar
         cbLSTimeBarVisible.Checked       := LSTimeBarPar.Visible; 
         LSTimeBarColor.Brush.Color       := LSTimeBarPar.Color;
         LSTimeBarThickness.Brush.Color   := LSTimeBarPar.Color;
         LSTimeBarThickness.Pen.Color     := LSTimeBarPar.Color;
         trbLSTimeBarThickness.Position   := LSTimeBarPar.Thickness;
         enLSTimeBarDuration.NumberFloat  := LSTimeBarPar.Duration;
         LSSettingChange                  := False;

         //2D Windows Size Bar (µm)
         enSizeBarLenghtINµm.NumberOne := ExportDial.SizeBarLenghtINµm;

         if (TimPltSlid.YmaxRatOn = 10) then MaxRatio.Position := -1 else
         if (TimPltSlid.YmaxRatOn = 30) then MaxRatio.Position := 0 else
         if (TimPltSlid.YmaxRatOn > 30) then MaxRatio.Position := TimPltSlid.YmaxRatOn div 50;
         lbMaxRatio.Caption := IntToStr(TimPltSlid.YmaxRatOn div 10);
         MaxRatio.Tag := MaxRatio.Position;

         ImageContrVar.MaxGamma := frmImageControl.trbGamma.Max;
         MaxGamma.Position      := ImageContrVar.MaxGamma div 50;
         lbMaxGamma.Caption     := IntToStr(5*MaxGamma.Position);
         if (MainImLoaded = True) and (MovFType =  NORAN_SGI_MOV{Noran}) then btCorrectTime.Enabled := True
         else btCorrectTime.Enabled := False;
         {copies color to Temp Arrays}
         for i := 1 to 21 do ButCol[i]     := ROIvar.ROICol[i];
         for i := 1 to 20 do FntCol[i]     := ROIvar.FontCol[i];
         for i := 1 to 21 do ButColBack[i] := ROIvar.ROICol[i];
         for i := 1 to 20 do FntColBack[i] := ROIvar.FontCol[i];

         {---------- Initializes Pixel/Micron Setting Page --- }
      If MainImLoaded = True then Begin

          if MovFType = NIKON_ND2_MOV   then TemFTitle := 'Nikon NIS-Elements Multi-Image ND2 File' else
          if MovFType = NIKON_TIFF_MOV   then TemFTitle := 'Nikon Multi-Image Tiff' else
          if MovFType = NORAN_PRARIE_MOV then TemFTitle := 'Noran Prarie' else
          if MovFType = StreamPix_Mov    then TemFTitle := 'StreamPix'    else
          if MovFType = ANDOR_MOV        then begin
            if (ImageFileType > SINGLE_IMAGE) then TemFTitle := 'Andor Multi-Image Tiff';
            if (NrIm > 1) and (ImageFileType = SINGLE_IMAGE) then
                                   TemFTitle := 'Stack of Andor Tiff';
            if (NrIm = 1) then     TemFTitle := 'Andor Single Image Tiff';
          end else
          if MovFType = STACK_BW_TIFF    then begin
            if TIFFfileType = TIFF_GENERIC then
             TemFTitle := 'Stack of Generic Tiffs' else
            if TIFFfileType = TIFF_QED then
             TemFTitle := 'Stack of QED Tiffs Open as Generic ' else
            if TIFFfileType = TIFF_NORAN_PRARIE then
             TemFTitle := 'Stack of Noran (Prarie) Tiffs Open as Generic';
          end else
          if MovFType = SINGLE_BW_TIFF   then begin
            if TIFFfileType = TIFF_GENERIC then
             TemFTitle := 'Generic Grayscale Tiff' else
            if TIFFfileType = TIFF_QED then
             TemFTitle := 'QED Tiff Open as Generic ' else
            if TIFFfileType = TIFF_NORAN_PRARIE then
             TemFTitle := 'Noran (Prarie) Tiff Open as Generic' else
            if TIFFfileType = TIFF_ImageJ then
             TemFTitle := 'ImageJ Tiff Open as Generic';
          end else
          if MovFType = BIORAD_PIC    then TemFTitle := 'BioRad' else
          if MovFType = ZEISS_CZI_LSM_MOV then Begin
            if (ExtractFileExt(ImFname) = '.lsm') then TemFTitle := 'Zeiss "LSM"'
              else
            if (ExtractFileExt(ImFname) = '.czi') then TemFTitle := 'Zeiss "CZI"';
          end
            else
          if MovFType = NORAN_SGI_MOV    then TemFTitle := 'Noran SGI';

          lbCurFileInfo.Caption := TemFTitle + ' / ' +
          IntToStr(imXsize) + ' x ' + IntToStr(imYsize) + ' pixels';

          {Initializes Windows for PixSettings}
        If (MovFType <> NORAN_SGI_MOV) and ((MovFType <> QED_MOV)) then Begin  //NORAN_SGI_MOV does Not Have Entry in PixSettings Record

          if (MovFType in [ANDOR_MOV, NIKON_ND2_MOV,NIKON_TIFF_MOV]) then begin
           if (PixSettings.ImageBinning > 0) then
           lbBinning.Caption := 'Binning (as recorded in file) = ' +
                IntToStr(PixSettings.ImageBinning) +'x' + IntToStr(PixSettings.ImageBinning)
           else
           lbBinning.Caption := 'Binning not recorded in file';
          end else
          if Not(MovFType in [ANDOR_MOV, NIKON_ND2_MOV,NIKON_TIFF_MOV])  then lbBinning.Caption := '';

          if (PixSettings.FileHasOwnPixSize = True) then begin
          if Not(PixSettings.UseOptionPixSize[MovFType]) then begin
            lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / not adjusted'
          end
            else
          If(PixSettings.UseOptionPixSize[MovFType]) then Begin
           if (MovFType = ANDOR_MOV) then begin
                if (PixSettings.ImageBinning > 0) then
                lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF((100*PixSettings.ImageBinning)/PixSettings.PixPer100Micr[ANDOR_MOV],ffFixed,6,6) + ' µm'
                else
                lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(100/PixSettings.PixPer100Micr[ANDOR_MOV],ffFixed,6,6) + ' µm'
            end
              else
            if (MovFType in[NIKON_ND2_MOV,NIKON_TIFF_MOV]) then begin
                if (PixSettings.ImageBinning > 0) then
                lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF((100*PixSettings.ImageBinning)/PixSettings.PixPer100Micr[NIKON_ND2_MOV],ffFixed,6,6) + ' µm'
                else
                lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(100/PixSettings.PixPer100Micr[NIKON_ND2_MOV],ffFixed,6,6) + ' µm'
            end
              else
            if (MovFType = SINGLE_BW_TIFF) and (TIFFfileType = TIFF_ImageJ) and (ChBoxTIFF.Checked)  then begin
              lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
            end;

          End; //if(PixSettings.UseOptionPixSize[MovFType]) then begin


            lbPixPer100Microns.Caption := '100 µm = ' + IntToStr(Round(100/PixSettings.FilePixSize)) + ' pixels';

          end
            else
          begin
            lbMicronsPix.Caption := 'File Has No Information on Pixel Size';
            lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
            FloatToStrF(100/PixSettings.PixPer100Micr[MovFType],ffFixed,6,6) + ' µm/pixel';
          end;


          End Else

          If (MovFType = NORAN_SGI_MOV) then Begin   //NORAN_SGI_MOV does Not Have Entry in PixSettings Record
           lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm';
           lbBinning.Caption := 'Noran SGI type file does not have adjustment option';
           lbPixPer100Microns.Caption := '';
          End;

          if MovFType = ANDOR_MOV         then CbAndorTiffs.Color := $00FFFFBB else
          if MovFType = SINGLE_BW_TIFF    then ChBoxTIFF.Color := $00FFFFBB else
          if MovFType = STACK_BW_TIFF     then ChBoxTiffStack.Color := $00FFFFBB else
          if MovFType = BIORAD_PIC        then ChBoxBioRad.Color := $00FFFFBB else
          if MovFType = NORAN_PRARIE_MOV  then ChBoxNoranPrairie.Color:= $00FFFFBB else
          if MovFType = StreamPix_Mov     then CbStreamPix.Color := $00FFFFBB else
          if MovFType in[NIKON_ND2_MOV,NIKON_TIFF_MOV] then ChBoxNikonND2orTiff.Color := $00FFFFBB else
          if MovFType = ZEISS_CZI_LSM_MOV then ChBoxZeiss.Color := $00FFFFBB;

         End else Begin
         lbCurFileInfo.Caption := '';
         lbBinning.Caption := '';
         lbMicronsPix.Caption := ' No File Open';
         lbPixPer100Microns.Caption := '';
         End;



         // Nikon ND2 Movies . Nikon TIFF Movies take the values of Nikon ND2 Movies
         ChBoxNikonND2orTiff.Checked    := PixSettings.UseOptionPixSize[NIKON_ND2_MOV];
         NikonEdPix.NumberOne      := PixSettings.PixPer100Micr[NIKON_ND2_MOV];

         //Noran Prarie
         //The paragraph below will be enabled when Noran Prarie inroduces Pixes Size in Files
        {ChBoxNoranPrairie.Checked := PixSettings.UseOptionPixSize[NORAN_PRARIE_MOV]; }
         NoranPrairieEdPix.NumberOne := PixSettings.PixPer100Micr[NORAN_PRARIE_MOV];

         //StreamPix
         //The paragraph below will be enabled when StreamPix inroduces Pixes Size in Files
         {CbStreamPix.Checked := PixSettings.UseOptionPixSize[StreamPix_MOV];}
         StreamPixEdPix.NumberOne := PixSettings.PixPer100Micr[StreamPix_MOV];
         
        //ANDOR_MOV
        
        //The paragraph below will be enabled when Andor inroduces Pixes Size in Files
         CbAndorTiffs.Checked := PixSettings.UseOptionPixSize[ANDOR_MOV];
         AndorEdPix.NumberOne := PixSettings.PixPer100Micr[ANDOR_MOV];


         //Tiff Stack of Generic Tiffs
         ChBoxTiffStack.Checked := PixSettings.UseOptionPixSize[STACK_BW_TIFF];
         StackGenTiffEdPix.NumberOne := PixSettings.PixPer100Micr[STACK_BW_TIFF];
         StackTiffFrmSec.NumberFloat := PixSettings.FramesPerSec[0];


         //Any Single TIFF
         ChBoxTIFF.Checked := PixSettings.UseOptionPixSize[SINGLE_BW_TIFF];
         SingleGenTiffEdPix.NumberOne := PixSettings.PixPer100Micr[SINGLE_BW_TIFF];
         SingleGenTiffFrmSec.NumberFloat := PixSettings.FramesPerSec[1];

         //BioRad
         ChBoxBioRad.Checked   := PixSettings.UseOptionPixSize[BIORAD_PIC];
         BioRadEdPix.NumberOne := PixSettings.PixPer100Micr[BIORAD_PIC];

         //Zeiss LSM
         ChBoxZeiss.Checked   := PixSettings.UseOptionPixSize[ZEISS_CZI_LSM_MOV];
         ZeissLSMEdPix.NumberOne := PixSettings.PixPer100Micr[ZEISS_CZI_LSM_MOV];

         {if MovFType = NORAN_SGI_MOV    des not have checkbox}
         {--------End - Initializes Pixel/Micron Setting Page --- }

         enGridDensity.NumberOne := WindowGrid.NrNodes;
         cbUseMoviFilePath.Checked := UseMoviFilePath;
         cbAlignXofImagePlayback.Checked := AlignfrmPlayback;
         {fills Bitmaps for Button Color Change}
         SetButImages;
         ROIcolChange := False;
         PixSetChange := False;
         OptionsPagesDlg.ShowModal;
         {for this to Work OptionsPagesDlg Visible sold be Set to False at Design Time}
End;

procedure TOptionsPagesDlg.OKBtnClick(Sender: TObject);
Begin
      {0 = No Smoothing, 1 = Boxcar; 2 = Median, 3 = Box & Median;}
      {first Set Button and Font Settings}

  If (MainImLoaded = True) and (NrIm > 1) then Begin

    If ROIcolChange = True then Begin
      If (LastState = 2) Then Begin  {if Somethin in BackUp}
        if LastType in[1,3] then ButCol[LastCol] := ButColBack[LastCol] else
        if LastType = 2     then FntCol[LastCol] := FntColBack[LastCol];
      End;
        SetFinalColorSettings;
    End;

    If (AvImSmoothChange) and (RatioOn = True) and (SmoothMode in [1,3]) Then Begin
      Screen.Cursor := crHourGlass;
      if (AutoSearchPar.SmoothBeforeDoRatio) then SmoothAverIm(AvImRaw,AvIm);
      DoBkgonAvIm; {Subtracts Bkg from AvIm Only}
      DoRatio(DO_COPY);
      UpdateMainImage(True);
      Screen.Cursor := crDefault;                       ShowMessage('here 2');
    end; {(AvImSmoothChange) and (RatioOn = True) and (SmoothMode in [1,3])}
    If (ROIvar.NrROI > 0) or (High(MarkSmEvCoor[CurIm]) >= 0) or
         (High(MarkBigEvCoor[CurIm]) >= 0) or (ChangeInMarks) or
         (ROIcolChange) or (MesLineChange) then Begin
         {Main Window}
        if (AvImSmoothChange = False) then UpdateMainImage(True);
        {now Average Image}
        if (frmAverIm <> nil) and (AvImExists > 0) Then Begin
          UpdateAverImage(True);
        end;  { if (frmAverIm <> nil) and (AvImExists > 0) Then Begin}
        {end with Average Image}
        if (LSSettingChange) then if (LineScanExist) then begin
          frmLineScan.SetTimeBar;
          frmLineScan.UpdateLSwindows(REFRESH_ONLY);
        end;
    End;

    if (NrChannels > 1) and (frmMergeWin <> nil) then DisplayMergeImage;
    if (NrChannels > 1) and (frm2ndWin <> nil)   then Display2ndChannel;


    If ROIcolChange = True then ChangePlotSet := True;
    If (ChangePlotSet = True) and (TimeSerAnalDone = True) Then Begin
       frmTimeSerPlot.RePlot(Sender);
    End; {If (ChangePlotSet = True) and (TimeSerAnalDone = True)}
  End; {If (MainImLoaded = True) and (NrIm > 1)then Begin}
  If (PixSetChange) Then Begin
    frmImageControl.Select.Down := True;
    frmImageControl.Select.Click;
  End;
    OptionsPagesDlg.Close;
End;
{*************************************************************}
procedure TOptionsPagesDlg.trbROIthicknessChange(Sender: TObject);
begin
  If trbROIthickness.Tag <> trbROIthickness.Position Then Begin
       trbROIthickness.Tag := trbROIthickness.Position;
       ShapeROI.Pen.Width        := trbROIthickness.Position;
       ROIvar.TckNess            := trbROIthickness.Position;
       ROIvar.Ticker             := trbThickerROI.Position*ROIvar.TckNess;
       ShapeROIthicker.Pen.Width := ROIvar.Ticker;
       ROIrct.LT := (ROIvar.TckNess div 2) + (ROIvar.TckNess mod 2);
       ROIrct.RB := (ROIvar.TckNess div 2) + 1 + 1;
     {the formula to draw a rectangle with different thickness
     and keeping interior the same is:
    L := Xl - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
    R := Xr + canvas.Pen.Width div 2 + 1 + 1;
    T := Yup - canvas.Pen.Width div 2 - canvas.Pen.Width mod 2;
    B := Yd + canvas.Pen.Width div 2 + 1 + 1; }
  End;
End;

procedure TOptionsPagesDlg.trbThickerROIChange(Sender: TObject);
begin
   If trbThickerROI.Tag <> trbThickerROI.Position Then Begin
       trbThickerROI.Tag := trbThickerROI.Position;
       ROIvar.Ticker             := trbThickerROI.Position*ROIvar.TckNess;
       ShapeROIthicker.Pen.Width := ROIvar.Ticker;
       ROIrct.tLT := (ROIvar.Ticker div 2) + (ROIvar.Ticker mod 2);
       ROIrct.tRB := (ROIvar.Ticker div 2) + 1 + 1;
   End;
End;

procedure TOptionsPagesDlg.trbFreeHandThicknessChange(Sender: TObject);
begin
  If trbFreeHandThickness.Tag <> trbFreeHandThickness.Position Then Begin
        trbFreeHandThickness.Tag := trbFreeHandThickness.Position;
        ShapeFreeHand.Pen.Width := trbFreeHandThickness.Position;
        ROIvar.FhTickness       := trbFreeHandThickness.Position;
  End;

End;



procedure TOptionsPagesDlg.CheckBoxUseSameFontColClick(Sender: TObject);
begin
      ROIvar.UseMonoFontCol := CheckBoxUseSameFontCol.Checked;
end;

procedure TOptionsPagesDlg.ShapeFontColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If ColorDialogROI.Execute Then Begin
           ShapeFontColor.Brush.Color := ColorDialogROI.Color;
           ROIvar.MonoFontCol := ColorDialogROI.Color;
     End;
end;

procedure TOptionsPagesDlg.CheckBoxEnableROINumbersClick(Sender: TObject);
begin
          ROIvar.UseROINr := CheckBoxEnableROINumbers.Checked;
end;

procedure TOptionsPagesDlg.trbMarkWithChange(Sender: TObject);

begin
  If trbMarkWith.Tag <> trbMarkWith.Position Then Begin
     trbMarkWith.Tag := trbMarkWith.Position;
     MarkPar.Thick := trbMarkWith.Position;
     DrawMark;
  End;

end;

procedure TOptionsPagesDlg.trbMarkSizeChange(Sender: TObject);
begin
  If trbMarkSize.Tag <> trbMarkSize.Position Then Begin
       trbMarkSize.Tag := trbMarkSize.Position;
       MarkPar.Size := trbMarkSize.Position;
       DrawMark;
  End;
end;

Procedure TOptionsPagesDlg.DrawMark;
   Var Xb,Xe,Yb,Ye : integer;

Begin
        With OptionsPagesDlg Do Begin

         imgMarkBkg.Canvas.Brush.Color := RGB(255,255,255);
         imgMarkBkg.Canvas.FillRect(Rect(0,0,40,40));
         imgMarkBkg.Canvas.Pen.Color := RGB(0,0,0);
         imgMarkBkg.Canvas.Pen.Width := trbMarkWith.Position;
         Xb := 20 - trbMarkSize.Position;
         Yb := Xb;
         Xe := 20 + trbMarkSize.Position;
         Ye := Xe;
         
         {Horiz}
         imgMarkBkg.Canvas.MoveTo(Xb,20);
         imgMarkBkg.Canvas.LineTo(Xe,20);
         {Vert}
         imgMarkBkg.Canvas.MoveTo(20,Yb);
         imgMarkBkg.Canvas.LineTo(20,Ye)
        End;
         {----}
End;



procedure TOptionsPagesDlg.shSmEventMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     if ColorDialogROI.Execute then Begin
         MarkPar.SmallEventColor := ColorDialogROI.Color;
         shSmEvent.Brush.Color   := MarkPar.SmallEventColor;
     End;
End;

procedure TOptionsPagesDlg.shBigEventMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     if ColorDialogROI.Execute then Begin
         MarkPar.BigEventColor := ColorDialogROI.Color;
         shBigEvent.Brush.Color  := MarkPar.BigEventColor;
     End;
end;

procedure TOptionsPagesDlg.DisplaySmallMarksClick(Sender: TObject);
begin
        MarkPar.DisplaySmEvents := DisplaySmallMarks.Checked;
        ChangeInMarks            := True;
end;

procedure TOptionsPagesDlg.DisplayBigMarksClick(Sender: TObject);
begin
        MarkPar.DisplayBigEvents := DisplayBigMarks.Checked;
        ChangeInMarks            := True;
end;

procedure TOptionsPagesDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin       
     Action := caFree;
     OptionsPagesDlg := nil;
end;

procedure TOptionsPagesDlg.ShowSmMarksOnAverWinClick(Sender: TObject);
begin
     MarkPar.ShowSmEvOnAverWin  := ShowSmMarksOnAverWin.Checked;
     ChangeInMarks            := True;
end;

procedure TOptionsPagesDlg.ShowBigMarksOnAverWinClick(Sender: TObject);
begin
       MarkPar.ShowBigEvOnAverWin := ShowBigMarksOnAverWin.Checked;
       ChangeInMarks            := True;
end;

procedure TOptionsPagesDlg.enGridDensityReturnPressed(Sender: TObject);
begin
   WindowGrid.NrNodes := enGridDensity.NumberOne;
end;

procedure TOptionsPagesDlg.EnableROIonAverWinClick(Sender: TObject);
begin
         ROIvar.ROIonAverWin := EnableROIonAverWin.Checked;
         ChangeInMarks       := True;
end;



procedure TOptionsPagesDlg.ReplotAverImage;
begin
  CopyAvImToDisplBuffer;
  If frmAverIm <> nil then Begin
    UpdateAverImage(True);
  End;
End;


procedure TOptionsPagesDlg.trbSymbSizeChange(Sender: TObject);
begin
  If trbSymbSize.Tag <> trbSymbSize.Position Then Begin
      trbSymbSize.Tag := trbSymbSize.Position;
      lblSymbSize.Caption := IntToStr(2*trbSymbSize.Position + 1) + ' pix';;
      shSymbSize.Width  := 2*trbSymbSize.Position + 1;
      shSymbSize.Height := 2*trbSymbSize.Position + 1;
      shSymbSize.Top    := 69 + 2 - trbSymbSize.Position;
      shSymbSize.Left   := 260 + 2 - trbSymbSize.Position;
      TimPltSlid.SymbSize  := trbSymbSize.Position;
      ChangePlotSet := True;
  End;
end;

procedure TOptionsPagesDlg.shSymbSizeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    If ColorDialogROI.Execute Then Begin
           shSymbSize.Pen.Color     := ColorDialogROI.Color;
           shSymbSize.Brush.Color   := ColorDialogROI.Color;
           TimPltSlid.SymbFromTableCol := ColorDialogROI.Color;
           ChangePlotSet := True;
     End;
end;



procedure TOptionsPagesDlg.AlwaysUseSymbClick(Sender: TObject);
begin
      TimPltSlid.AlwaysUseSymb := AlwaysUseSymb.Checked;
      ChangePlotSet := True;
end;


procedure TOptionsPagesDlg.PromptForCommentClick(Sender: TObject);
begin
       MarkPar.PromptForComment := PromptForComment.Checked;
end;


procedure TOptionsPagesDlg.GenGenSetCommClick(Sender: TObject);
begin
       MarkPar.GenGenSetComm := GenGenSetComm.Checked;
end;

procedure TOptionsPagesDlg.GenAutoSearchCommClick(Sender: TObject);
begin
       MarkPar.GenAutoSearchComm := GenAutoSearchComm.Checked;
end;

procedure TOptionsPagesDlg.trbMesLineThicknessChange(Sender: TObject);
begin
 If trbMesLineThickness.Tag <> trbMesLineThickness.Position Then Begin
    trbMesLineThickness.Tag := trbMesLineThickness.Position;
    MesLineVar.Thickness     :=  trbMesLineThickness.Position;
    if (MesLineVar.Thickness = 1) then
      MesLine.SelTol := 3 else
      MesLine.SelTol := MesLineVar.Thickness + 1;

    MesLineThickness.Height := MesLineVar.Thickness;
    MesLineThickness.Top    := 54 - MesLineVar.Thickness div 2;
    MesLineChange := True;
 End;

End;


procedure TOptionsPagesDlg.enLineCapsWidthReturnPressed(Sender: TObject);
begin
    if (enLineCapsWidth.NumberOne mod 2 = 0) and (enLineCapsWidth.NumberOne <> 0) then
      enLineCapsWidth.NumberOne := enLineCapsWidth.NumberOne + 1;
    if (enLineCapsWidth.NumberOne = 1) then enLineCapsWidth.NumberOne := 0;
    MesLineVar.CapsWitdh := enLineCapsWidth.NumberOne div 2;
end;

procedure TOptionsPagesDlg.MesLineColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     If (ColorDialogROI.Execute)  Then Begin
      if (MesLineVar.Color <> ColorDialogROI.Color) then begin
      MesLineVar.Color             := ColorDialogROI.Color;
      MesLineColor.Brush.Color     := ColorDialogROI.Color;
      MesLineThickness.Brush.Color := ColorDialogROI.Color;
      MesLineThickness.Pen.Color   := ColorDialogROI.Color;
      MesLineChange := True;
      end;
     End;
End;

procedure TOptionsPagesDlg.trbLSTimeBarThicknessChange(Sender: TObject);
begin

  If trbLSTimeBarThickness.Tag <> trbLSTimeBarThickness.Position Then Begin
    trbLSTimeBarThickness.Tag := trbLSTimeBarThickness.Position;
    LSTimeBarPar.Thickness :=  trbLSTimeBarThickness.Position;
    LSTimeBarThickness.Height := LSTimeBarPar.Thickness;
    LSTimeBarThickness.Top    := 157 - LSTimeBarPar.Thickness div 2;
    LSSettingChange := True;

    SizeBar.YT := SizeBar.YB - LSTimeBarPar.Thickness;
 End;
end;


procedure TOptionsPagesDlg.LSTimeBarColorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   If (ColorDialogROI.Execute) Then Begin
    if (LSTimeBarPar.Color <> ColorDialogROI.Color) then begin
      LSTimeBarPar.Color             := ColorDialogROI.Color;
      LSTimeBarColor.Brush.Color     := ColorDialogROI.Color;
      LSTimeBarThickness.Brush.Color := ColorDialogROI.Color;
      LSTimeBarThickness.Pen.Color   := ColorDialogROI.Color;
      LSSettingChange                := True;
    end;
   End;
end;

procedure TOptionsPagesDlg.cbLSTimeBarVisibleClick(Sender: TObject);
begin
     LSTimeBarPar.Visible := cbLSTimeBarVisible.Checked;
     LSSettingChange := True;
end;

procedure TOptionsPagesDlg.enLSTimeBarDurationReturnPressed(Sender: TObject);
begin
    LSTimeBarPar.Duration := enLSTimeBarDuration.NumberFloat;
    LSSettingChange := True;
end;

procedure TOptionsPagesDlg.enSizeBarLenghtINµmReturnPressed(Sender: TObject);
begin
   ExportDial.SizeBarLenghtINµm := enSizeBarLenghtINµm.NumberOne;
   if (MainImLoaded) then SizeBar.XL := SizeBar.XR - round(ExportDial.SizeBarLenghtINµm/PixSize);
end;

procedure TOptionsPagesDlg.ckbKeepOldROIClick(Sender: TObject);
begin
   ROIvar.KeepOldROI := ckbKeepOldROI.Checked;
end;

procedure TOptionsPagesDlg.MaxGammaChange(Sender: TObject);
begin
  If ImageContrVar.MaxGamma <> 50*MaxGamma.Position Then Begin
     frmImageControl.trbGamma.Max := 50*MaxGamma.Position;
     frmImageControl.enGamma.Max  := 5*MaxGamma.Position;
     ImageContrVar.MaxGamma := frmImageControl.trbGamma.Max;
     lbMaxGamma.Caption := IntToStr(5*MaxGamma.Position);
  End;
End;

procedure TOptionsPagesDlg.MaxRatioChange(Sender: TObject);
 var DrawY : Boolean;
begin

If MaxRatio.Tag <> MaxRatio.Position Then Begin
   MaxRatio.Tag := MaxRatio.Position;
if MaxRatio.Position = -1 then TimPltSlid.YmaxRatOn := 10 else
if MaxRatio.Position = 0  then TimPltSlid.YmaxRatOn := 30 else
                               TimPltSlid.YmaxRatOn := MaxRatio.Position*50;
  lbMaxRatio.Caption   := IntToStr(TimPltSlid.YmaxRatOn div 10);
  frmImageControl.trbMaxRatio.Max := TimPltSlid.YmaxRatOn*10;

  If (PLOTvar.AnalType in[RATIO_TIME,Ch_div_Ch_RATIO_TIME,Ca_CONC_TIME]) Then Begin
    with frmTimeSerPlot do begin
      if dsYaxes.PosTo > TimPltSlid.YmaxRatOn then begin
        DrawY := True;
        dsYaxes.PosTo := TimPltSlid.YmaxRatOn;
      end else DrawY := False;

        enYtop.Max  := TimPltSlid.YmaxRatOn/10;
        dsYaxes.Max := TimPltSlid.YmaxRatOn;
        dsYaxesChange(sender);

        if (DrawY = True) then frmTimeSerPlot.RePlot(Sender);

    end; { with frmTimeSerPlot}
  End; {PLOTvar.RatOn = True}
End; {If MaxRatio.Tag <> MaxRatio.Position Then Begin}

End;



procedure TOptionsPagesDlg.btCorrectTimeClick(Sender: TObject);

   Var  Cnt : Integer;
        MinDelt,MaxDelt,TemExt : Extended;
begin
{Checks if Time is O.K. if not corrects it}
    {I verified that the precision of Time in sec is the Same as in NanoSec}
    MinDelt := 1.18E4932;  {Extended ranges from 3.37 x 10-4932 to 1.18 x 104932}
    MaxDelt := 0;
  For Cnt := 0 to High(TimeSt) - 1  do begin
      TemExt := TimeSt[Cnt+1] - TimeSt[Cnt];
      if TemExt > 0 then Begin
        if MinDelt > TemExt then MinDelt := TemExt;
        if MaxDelt < TemExt then MaxDelt := TemExt;
      end;
  End;

  If (MaxDelt - MinDelt) > MinDelt/10 then Begin
  MessageDlg('Time will be Replaced by the Minimum Image Time Offset of: '
  + FloatToStrF(MinDelt,ffFixed,20,12) + ' s',mtInformation,[mbOK],0);
       TemExt := 0;
   For Cnt := 0 to High(TimeSt) do begin
       TimeSt[Cnt] := TemExt;
       TemExt := TemExt + MinDelt;
   End;
  End;
  frmPlayback.lbImageNr.Caption := 'im ' + IntToStr(CurIm + 1) +
                    ' / ' + (FloatToStrF(TimeSt[CurIm],ffFixed,5,3) + ' s');
  {----------- End of Check and Correction}
End;  {procedure TOptionsPagesDlg.btCorrectTimeClick}



 {*************** From Here Button Color Change ********************}

Procedure TOptionsPagesDlg.ChangeButCol(const Img : TImage);
  var  ButNr : AnsiString;
       Xt,Yt : integer;
 Begin
  If ListBoxColor.ItemIndex = 0 Then Begin {Button or Frame Color}
     ColorDialogROI.Color := ButCol[Img.Tag];
     If ColorDialogROI.Execute then Begin
        ButCol[Img.Tag] := ColorDialogROI.Color;
        ColUnDo.Enabled := True;
        ColReDo.Enabled := False;
        ROIcolChange := True;
         {Makes Working and BackUp Arrays the Same for the Previous Item}
        If (LastType > 0) then Begin     
          If LastType in[1,3] then Begin
            if LastState = 1 Then ButColBack[LastCol] := ButCol[LastCol] else
            if LastState = 2 Then ButCol[LastCol] := ButColBack[LastCol];
          End Else
          If LastType = 2 then Begin
            if LastState = 1 Then FntColBack[LastCol] := FntCol[LastCol] else
            if LastState = 2 Then FntCol[LastCol] := FntCol[LastCol];
          End;
        End;
        LastCol         := Img.Tag; {last Color [ROI or Font}
        LastType        := 1;
        LastState       := 1;
        With Img  Do Begin
          Canvas.Font.Name   := 'Arial Narrow';
          Canvas.Font.Pitch  := fpVariable;
          Canvas.Font.Size   := 9;
          Canvas.Brush.Color := ButCol[Img.Tag];
          Canvas.Pen.Color   := Canvas.Brush.Color;
          Canvas.FillRect(Canvas.ClipRect);
          Canvas.Brush.Style := bsClear; {to make transparent text}
          ButNr := IntToStr(Img.Tag);
          Xt := Width div 2  - Canvas.TextWidth(ButNr) div 2;
          Yt := Height div 2 - Canvas.TextHeight(ButNr) div 2;
          Canvas.Font.Color  := FntCol[Img.Tag];
          Canvas.TextOut(Xt,Yt,ButNr);
        End; {with}
     End;
  End Else
  If ListBoxColor.ItemIndex = 1 Then Begin {Button Font Color}
     ColorDialogROI.Color :=  FntCol[Img.Tag];
     If ColorDialogROI.Execute then Begin
        FntCol[Img.Tag] := ColorDialogROI.Color;
        ColUnDo.Enabled := True;
        ColReDo.Enabled := False;
         {Makes Working and BackUp Arrays the Same for the Previous Item}
        If (LastType > 0) then Begin
          If LastType in[1,3] then Begin
            if LastState = 1 Then ButColBack[LastCol] := ButCol[LastCol] else
            if LastState = 2 Then ButCol[LastCol] := ButColBack[LastCol];
          End Else
          If LastType = 2 then Begin
            if LastState = 1 Then FntColBack[LastCol] := FntCol[LastCol] else
            if LastState = 2 Then FntCol[LastCol] := FntCol[LastCol];
          End;
        End;
        LastCol         := Img.Tag; {last Color [ROI or Font}
        LastType        := 2;
        LastState       := 1;
        With Img  Do Begin
          Canvas.Font.Name   := 'Arial Narrow';
          Canvas.Font.Pitch  := fpVariable;
          Canvas.Font.Size   := 9;
          Canvas.Brush.Style := bsClear; {to make transparent text}
          ButNr := IntToStr(Img.Tag);
          Xt := Width div 2  - Canvas.TextWidth(ButNr) div 2;
          Yt := Height div 2 - Canvas.TextHeight(ButNr) div 2;
          Canvas.Font.Color  := FntCol[Img.Tag];
          Canvas.TextOut(Xt,Yt,ButNr);
        End;
     End;
  End;
End;

procedure TOptionsPagesDlg.Im1Click(Sender: TObject);
begin
     ChangeButCol(Im1);
end;

procedure TOptionsPagesDlg.Im2Click(Sender: TObject);
begin
     ChangeButCol(Im2);
end;


procedure TOptionsPagesDlg.Im3Click(Sender: TObject);
begin
     ChangeButCol(Im3);
end;

procedure TOptionsPagesDlg.Im4Click(Sender: TObject);
begin
    ChangeButCol(Im4);
end;

procedure TOptionsPagesDlg.Im5Click(Sender: TObject);
begin
     ChangeButCol(Im5);
end;

procedure TOptionsPagesDlg.Im6Click(Sender: TObject);
begin
    ChangeButCol(Im6);
end;

procedure TOptionsPagesDlg.Im7Click(Sender: TObject);
begin
    ChangeButCol(Im7);
end;

procedure TOptionsPagesDlg.Im8Click(Sender: TObject);
begin
   ChangeButCol(Im8);
end;

procedure TOptionsPagesDlg.Im9Click(Sender: TObject);
begin
     ChangeButCol(Im9);
end;
   

procedure TOptionsPagesDlg.Im10Click(Sender: TObject);
begin
      ChangeButCol(Im10);
end;

procedure TOptionsPagesDlg.Im11Click(Sender: TObject);
begin
       ChangeButCol(Im11);
end;

procedure TOptionsPagesDlg.Im12Click(Sender: TObject);
begin
        ChangeButCol(Im12);
end;

procedure TOptionsPagesDlg.Im13Click(Sender: TObject);
begin
        ChangeButCol(Im13);
end;

procedure TOptionsPagesDlg.Im14Click(Sender: TObject);
begin
        ChangeButCol(Im14);
end;

procedure TOptionsPagesDlg.Im15Click(Sender: TObject);
begin
        ChangeButCol(Im15);
end;

procedure TOptionsPagesDlg.Im16Click(Sender: TObject);
begin
        ChangeButCol(Im16);
end;

procedure TOptionsPagesDlg.Im17Click(Sender: TObject);
begin
        ChangeButCol(Im17);
end;

procedure TOptionsPagesDlg.Im18Click(Sender: TObject);
begin
       ChangeButCol(Im18);
end;

procedure TOptionsPagesDlg.Im19Click(Sender: TObject);
begin
       ChangeButCol(Im19);
end;

procedure TOptionsPagesDlg.Im20Click(Sender: TObject);
begin
        ChangeButCol(Im20);
end;



procedure TOptionsPagesDlg.ShapeSelFrameMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     ColorDialogROI.Color := SelFrameColor;
     If ColorDialogROI.Execute then Begin
        SelFrameColor := ColorDialogROI.Color;
        ShapeSelFrame.Pen.Color := SelFrameColor;
     End;
end;

Procedure TOptionsPagesDlg.RestoreColSettings(const Img : TImage);
  var Xt,Yt : integer;
      ButNr : AnsiString;
 Begin
    With Img  Do Begin
        Canvas.Font.Name   := 'Arial Narrow';
        Canvas.Font.Pitch  := fpVariable;
        Canvas.Font.Size   := 9;
      If LastType = 1 Then Begin
        if LastState = 1 then
        Canvas.Brush.Color := ButCol[Img.Tag] else
        if LastState = 2 then
        Canvas.Brush.Color := ButColBack[Img.Tag];
        Canvas.Pen.Color   := Canvas.Brush.Color;
        Canvas.FillRect(Canvas.ClipRect);
        Canvas.Brush.Style := bsClear; {to make transparent text}
        ButNr := IntToStr(Img.Tag);
        Xt := Width div 2  - Canvas.TextWidth(ButNr) div 2;
        Yt := Height div 2 - Canvas.TextHeight(ButNr) div 2;
        Canvas.Font.Color  := FntCol[Img.Tag];
        Canvas.TextOut(Xt,Yt,ButNr);
      End Else
      If LastType = 2 Then Begin
        Canvas.Brush.Style := bsClear; {to make transparent text}
        ButNr := IntToStr(Img.Tag);
        Xt := Width div 2  - Canvas.TextWidth(ButNr) div 2;
        Yt := Height div 2 - Canvas.TextHeight(ButNr) div 2;
        if LastState = 1 then
        Canvas.Font.Color  := FntCol[Img.Tag] else
        if LastState = 2 then
        Canvas.Font.Color  := FntColBack[Img.Tag];
        Canvas.TextOut(Xt,Yt,ButNr);
      End;

    End; {with}

End;
Procedure TOptionsPagesDlg.GetImNrAndDoReset;
  Begin
    if LastCol = 1 then RestoreColSettings(Im1) else
    if LastCol = 2 then RestoreColSettings(Im2) else
    if LastCol = 3 then RestoreColSettings(Im3) else
    if LastCol = 4 then RestoreColSettings(Im4) else
    if LastCol = 5 then RestoreColSettings(Im5) else
    if LastCol = 6 then RestoreColSettings(Im6) else
    if LastCol = 7 then RestoreColSettings(Im7) else
    if LastCol = 8 then RestoreColSettings(Im8) else
    if LastCol = 9 then RestoreColSettings(Im9) else
    if LastCol = 10 then RestoreColSettings(Im10) else
    if LastCol = 11 then RestoreColSettings(Im11) else
    if LastCol = 12 then RestoreColSettings(Im12) else
    if LastCol = 13 then RestoreColSettings(Im13) else
    if LastCol = 14 then RestoreColSettings(Im14) else
    if LastCol = 15 then RestoreColSettings(Im15) else
    if LastCol = 16 then RestoreColSettings(Im16) else
    if LastCol = 17 then RestoreColSettings(Im17) else
    if LastCol = 18 then RestoreColSettings(Im18) else
    if LastCol = 19 then RestoreColSettings(Im19) else
    if LastCol = 20 then RestoreColSettings(Im20);

End;

Procedure TOptionsPagesDlg.ColUnDoClick(Sender: TObject);

begin
   ColReDo.Enabled := ColUnDo.Enabled;
   ColUnDo.Enabled := False;
   ROIcolChange := True;
   LastState       := 2;
   If LastType = 3 then Begin
      ShapeSelFrame.Pen.Color := SelFrameColorBack;
      LastType        := 3;
   End Else
   If (LastType in [1,2]) then GetImNrAndDoReset;
End;

procedure TOptionsPagesDlg.ColReDoClick(Sender: TObject);
begin
   ColUnDo.Enabled := ColReDo.Enabled;
   ColReDo.Enabled := False;
   ROIcolChange := True;
   LastState       := 1;
   If LastType = 3 then Begin
        ShapeSelFrame.Pen.Color := SelFrameColor;
        LastType        := 3;
   End Else
   If (LastType in [1,2]) then GetImNrAndDoReset;
End;

Procedure TOptionsPagesDlg.SetButImages;
  var i,Xt,Yt : integer;
      ButBMP : TBitmap;
      ButNr : AnsiString;
 Begin
         ButBMP := TBitmap.Create;
         ButBMP.Width  := 16;
         ButBMP.Height := 16;
         ButBMP.PixelFormat := pf24bit;
         ButBMP.Canvas.Font.Name   := 'Arial Narrow';
         ButBMP.Canvas.Font.Pitch  := fpVariable;
         ButBMP.Canvas.Font.Size   := 9;
         For i := 1 to 20 Do Begin
         ButBMP.Canvas.Brush.Color := ButCol[i];
         ButBMP.Canvas.Pen.Color := ButBMP.Canvas.Brush.Color;
         ButBMP.Canvas.FillRect(ButBMP.Canvas.ClipRect);
         ButBMP.Canvas.Brush.Style := bsClear; {to make transparent text}
         ButNr := IntToStr(i);
         Xt := ButBMP.Width div 2  - ButBMP.Canvas.TextWidth(ButNr) div 2;
         Yt := ButBMP.Height div 2 - ButBMP.Canvas.TextHeight(ButNr) div 2;
         ButBMP.Canvas.Font.Color  := FntCol[i];
         ButBMP.Canvas.TextOut(Xt,Yt,ButNr);
         if i = 1 then Im1.Picture.Bitmap.Assign(ButBMP) else
         if i = 2 then Im2.Picture.Bitmap.Assign(ButBMP) else
         if i = 3 then Im3.Picture.Bitmap.Assign(ButBMP) else
         if i = 4 then Im4.Picture.Bitmap.Assign(ButBMP) else
         if i = 5 then Im5.Picture.Bitmap.Assign(ButBMP) else
         if i = 6 then Im6.Picture.Bitmap.Assign(ButBMP) else
         if i = 7 then Im7.Picture.Bitmap.Assign(ButBMP) else
         if i = 8 then Im8.Picture.Bitmap.Assign(ButBMP) else
         if i = 9 then Im9.Picture.Bitmap.Assign(ButBMP) else
         if i = 10 then Im10.Picture.Bitmap.Assign(ButBMP) else
         if i = 11 then Im11.Picture.Bitmap.Assign(ButBMP) else
         if i = 12 then Im12.Picture.Bitmap.Assign(ButBMP) else
         if i = 13 then Im13.Picture.Bitmap.Assign(ButBMP) else
         if i = 14 then Im14.Picture.Bitmap.Assign(ButBMP) else
         if i = 15 then Im15.Picture.Bitmap.Assign(ButBMP) else
         if i = 16 then Im16.Picture.Bitmap.Assign(ButBMP) else
         if i = 17 then Im17.Picture.Bitmap.Assign(ButBMP) else
         if i = 18 then Im18.Picture.Bitmap.Assign(ButBMP) else
         if i = 19 then Im19.Picture.Bitmap.Assign(ButBMP) else
         if i = 20 then Im20.Picture.Bitmap.Assign(ButBMP);
         End;
         FreeAndNil(ButBMP);
         ShapeSelFrame.Pen.Color := SelFrameColor;
         LastCol   := 0;
         LastType  := 0;
         LastState := 0;
         ListBoxColor.ItemIndex := 0; {sets Highlight to First Choice}

End;

procedure TOptionsPagesDlg.ResToOriginalClick(Sender: TObject);
begin
    ResetCode := 1;
    Yes.Caption := 'Reset to Original (Build In) Colors';
    PopUpMenuYesNo.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

end;

procedure TOptionsPagesDlg.YesClick(Sender: TObject);
begin
     if ResetCode = 1 then ResToBuildIn else
     if ResetCode = 2 then ResetToBeg;
end;

Procedure TOptionsPagesDlg.ResToBuildIn;
  Begin
  {Resets to Build In Colors}
  ROIcolChange := True;
  SetBuildInROIcolors(ButCol,FntCol);
  SetBuildInROIcolors(ButColBack,FntColBack);
  SetButImages;
  ColReDo.Enabled := False;
  ColUnDo.Enabled := False;

End;

procedure TOptionsPagesDlg.ResetToBeg;
 var i : integer;
Begin
 {resets to Current = before Cahnge Settings}
    for i := 1 to 21 do ButCol[i]     := ROIvar.ROICol[i];
    for i := 1 to 20 do FntCol[i]     := ROIvar.FontCol[i];
    for i := 1 to 21 do ButColBack[i] := ROIvar.ROICol[i];
    for i := 1 to 20 do FntColBack[i] := ROIvar.FontCol[i];
    SetButImages;
    ColReDo.Enabled := False;
    ColUnDo.Enabled := False;
    ROIcolChange := False;

End;

procedure TOptionsPagesDlg.ResetToInitialClick(Sender: TObject);

begin
  ResetCode := 2;
  Yes.Caption := 'Reset All to the Initial Colors';
  PopUpMenuYesNo.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);

end;

Procedure TOptionsPagesDlg.SetFinalColorSettings;
  var i : integer;
      FirstTime : Boolean;
 Begin
    for i := 1 to 21 do ROIvar.ROICol[i]  := ButCol[i];
    for i := 1 to 20 do ROIvar.FontCol[i] := FntCol[i];
    FirstTime := False;
    frmTimeSerPlot.SetButtons(FirstTime);
End;



procedure TOptionsPagesDlg.AllowFullPathOfLastFileClick(Sender: TObject);
begin
     AllowFullPath := AllowFullPathOfLastFile.Checked;
end;

{----------- Microns per Pixel Setting Start from Here ------------------------}

procedure TOptionsPagesDlg.ChBoxNikonND2orTiffClick(Sender: TObject);
begin

  PixSettings.UseOptionPixSize[NIKON_ND2_MOV] := ChBoxNikonND2orTiff.Checked;

  If MovFType in [NIKON_ND2_MOV,NIKON_TIFF_MOV] Then Begin
  PixSetChange := True;
   if (PixSettings.UseOptionPixSize[NIKON_ND2_MOV] = True) then begin
      if PixSettings.ImageBinning > 0 then
      PixSize := (100*PixSettings.ImageBinning)/PixSettings.PixPer100Micr[NIKON_ND2_MOV] else
      PixSize :=  100/PixSettings.PixPer100Micr[NIKON_ND2_MOV];
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
   end else
   if (PixSettings.UseOptionPixSize[NIKON_ND2_MOV] = False) then begin
      PixSize := PixSettings.FilePixSize;
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm / not adjusted';
   end;
  End;

End;


procedure TOptionsPagesDlg.ChBoxNoranPrairieClick(Sender: TObject);
begin
       {Keeps it Always Checked}
      ChBoxNoranPrairie.Checked := True;
  {Since  NoranPrairie Files do Not Have Written Own Pixel Sizes This
 paragraph is Disabled}
End;

procedure TOptionsPagesDlg.CbStreamPixClick(Sender: TObject);
begin
       {Keeps it Always Checked}
       CbStreamPix.Checked := True;
{Since  StreamPix Files do Not Have Written Own Pixel Sizes This
 paragraph is Disabled}

end;


procedure TOptionsPagesDlg.CbAndorTiffsClick(Sender: TObject);
begin

  PixSettings.UseOptionPixSize[ANDOR_MOV] := CbAndorTiffs.Checked;

  If MovFType =  ANDOR_MOV Then Begin
  PixSetChange := True;
   if (PixSettings.UseOptionPixSize[ANDOR_MOV] = True) then begin
      if PixSettings.ImageBinning > 0 then
      PixSize := (100*PixSettings.ImageBinning)/PixSettings.PixPer100Micr[ANDOR_MOV] else
      PixSize :=  100/PixSettings.PixPer100Micr[ANDOR_MOV];
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
   end else
   if (PixSettings.UseOptionPixSize[ANDOR_MOV] = False) then begin
      PixSize := PixSettings.FilePixSize;
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm / not adjusted';
   end;
  End;

end;


procedure TOptionsPagesDlg.ChBoxTiffStackClick(Sender: TObject);
begin

  if MovFType = STACK_BW_TIFF then if Not(PixSettings.FileHasOwnPixSize)
     then ChBoxTiffStack.Checked := True;

  PixSettings.UseOptionPixSize[STACK_BW_TIFF] := ChBoxTiffStack.Checked;

  If MovFType = STACK_BW_TIFF Then Begin
      PixSetChange := True;
   if (PixSettings.UseOptionPixSize[STACK_BW_TIFF] = True) then
      PixSize := 100/(PixSettings.PixPer100Micr[STACK_BW_TIFF]) else
   if (PixSettings.UseOptionPixSize[STACK_BW_TIFF] = False) then
      PixSize := PixSettings.FilePixSize;
    if (MainImLoaded) then begin
        if (PixSettings.FileHasOwnPixSize) then begin
         if (PixSettings.UseOptionPixSize[STACK_BW_TIFF]) then
         lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm' else
         if Not(PixSettings.UseOptionPixSize[STACK_BW_TIFF]) then
         lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm / not adjusted';
        end else
        if Not(PixSettings.FileHasOwnPixSize) then
        lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(PixSize,ffFixed,6,6) + ' µm/pixel';
    end;
  End;
end;

procedure TOptionsPagesDlg.ChBoxZeissClick(Sender: TObject);
begin

  PixSettings.UseOptionPixSize[ZEISS_CZI_LSM_MOV] := ChBoxZeiss.Checked;

  If (MovFType = ZEISS_CZI_LSM_MOV) Then Begin
  PixSetChange := True;
   if (PixSettings.UseOptionPixSize[ZEISS_CZI_LSM_MOV] = True) then begin
      PixSize :=  100/PixSettings.PixPer100Micr[ZEISS_CZI_LSM_MOV];
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
   end else
   if (PixSettings.UseOptionPixSize[ZEISS_CZI_LSM_MOV] = False) then begin
      PixSize := PixSettings.FilePixSize;
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm / not adjusted';
   end;
  End;

end;

procedure TOptionsPagesDlg.ChBoxTIFFClick(Sender: TObject);
begin

  if (MovFType = SINGLE_BW_TIFF) then if Not(PixSettings.FileHasOwnPixSize)
     then ChBoxTIFF.Checked := True;

  PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] := ChBoxTIFF.Checked;

  If MovFType = SINGLE_BW_TIFF Then Begin
   PixSetChange := True;
   if (PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] = True) then
      PixSize := 100/(PixSettings.PixPer100Micr[SINGLE_BW_TIFF]) else
   if (PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] = False) then
      PixSize := PixSettings.FilePixSize;
   if (MainImLoaded) then begin
        if (PixSettings.FileHasOwnPixSize) then begin
         if (PixSettings.UseOptionPixSize[SINGLE_BW_TIFF]) then
         lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm' else
         if Not(PixSettings.UseOptionPixSize[SINGLE_BW_TIFF]) then
         lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm / not adjusted';
        end else
        if Not(PixSettings.FileHasOwnPixSize) then
        lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm/pixel';
   end;
  End;
end;

procedure TOptionsPagesDlg.ChBoxBioRadClick(Sender: TObject);
begin

  PixSettings.UseOptionPixSize[BIORAD_PIC] := ChBoxBioRad.Checked;

  If MovFType =  BIORAD_PIC Then Begin
  PixSetChange := True;
   if (PixSettings.UseOptionPixSize[BIORAD_PIC] = True) then begin
      PixSize :=  100/PixSettings.PixPer100Micr[BIORAD_PIC];
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
   end else
   if (PixSettings.UseOptionPixSize[BIORAD_PIC] = False) then begin
      PixSize := PixSettings.FilePixSize;
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' + FloatToStrF(PixSize,ffFixed,6,6) + ' µm / not adjusted';
   end;
  End;

End;


procedure TOptionsPagesDlg.NikonEdPixReturnPressed(Sender: TObject);
begin

   PixSettings.PixPer100Micr[NIKON_ND2_MOV] := NikonEdPix.NumberOne;
   if (MovFType in[NIKON_ND2_MOV,NIKON_TIFF_MOV]) and (PixSettings.UseOptionPixSize[NIKON_ND2_MOV] = True) then begin
      PixSetChange := True;
      if PixSettings.ImageBinning > 0 then
      PixSize := (100*PixSettings.ImageBinning)/PixSettings.PixPer100Micr[NIKON_ND2_MOV] else
      PixSize :=  100/PixSettings.PixPer100Micr[NIKON_ND2_MOV];
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
   end;
end;

 //------ end with QED cameras

procedure TOptionsPagesDlg.NoranPrairieEdPixReturnPressed(Sender: TObject);
begin

   PixSettings.PixPer100Micr[NORAN_PRARIE_MOV] := NoranPrairieEdPix.NumberOne;
   if (MovFType = NORAN_PRARIE_MOV) and (PixSettings.UseOptionPixSize[NORAN_PRARIE_MOV] = True) then begin
      PixSetChange := True;
      PixSize := 100/PixSettings.PixPer100Micr[NORAN_PRARIE_MOV];
      if (MainImLoaded) then
      lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(PixSize,ffFixed,6,6) + ' µm/pixel';
   end;
end;



procedure TOptionsPagesDlg.StreamPixEdPixReturnPressed(Sender: TObject);
begin
   PixSettings.PixPer100Micr[StreamPix_Mov] := StreamPixEdPix.NumberOne;
   if (MovFType = StreamPix_Mov) and (PixSettings.UseOptionPixSize[StreamPix_Mov] = True) then begin
      PixSetChange := True;
      PixSize := 100/PixSettings.PixPer100Micr[StreamPix_Mov];
      if (MainImLoaded) then
      lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(PixSize,ffFixed,6,6) + ' µm/pixel';
   end;
end;

procedure TOptionsPagesDlg.AndorEdPixReturnPressed(Sender: TObject);
begin
   PixSettings.PixPer100Micr[ANDOR_MOV] := AndorEdPix.NumberOne;
   if (MovFType = ANDOR_MOV) and (PixSettings.UseOptionPixSize[ANDOR_MOV] = True) then begin
      PixSetChange := True;
      if PixSettings.ImageBinning > 0 then
      PixSize := (100*PixSettings.ImageBinning)/PixSettings.PixPer100Micr[ANDOR_MOV] else
      PixSize :=  100/PixSettings.PixPer100Micr[ANDOR_MOV];
      if (MainImLoaded) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm'
   end;
end;


procedure TOptionsPagesDlg.StackGenTiffEdPixReturnPressed(Sender: TObject);
begin

   PixSettings.PixPer100Micr[STACK_BW_TIFF] := StackGenTiffEdPix.NumberOne;
   if (MovFType =  STACK_BW_TIFF)and(PixSettings.UseOptionPixSize[STACK_BW_TIFF] = True) then begin
      PixSetChange := True;
      PixSize := 100/PixSettings.PixPer100Micr[STACK_BW_TIFF];
      if (MainImLoaded) then begin
      if (PixSettings.FileHasOwnPixSize) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm' else
      if Not(PixSettings.FileHasOwnPixSize) then
       lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(100/PixSettings.PixPer100Micr[MovFType],ffFixed,6,6) + ' µm/pixel';
      end;
   end;
end;


procedure TOptionsPagesDlg.SingleGenTiffEdPixReturnPressed(Sender: TObject);
begin

     PixSettings.PixPer100Micr[SINGLE_BW_TIFF] := SingleGenTiffEdPix.NumberOne;
  if (MovFType =  SINGLE_BW_TIFF) and (PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] = True) then begin
      PixSetChange := True;
      PixSize := 100/PixSettings.PixPer100Micr[SINGLE_BW_TIFF];
    if (MainImLoaded) then begin
      if (PixSettings.FileHasOwnPixSize) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm' else
      if Not(PixSettings.FileHasOwnPixSize) then
       lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(100/PixSettings.PixPer100Micr[MovFType],ffFixed,6,6) + ' µm/pixel';
    end;
   end;

end;

procedure TOptionsPagesDlg.BioRadEdPixReturnPressed(Sender: TObject);
begin

   PixSettings.PixPer100Micr[BIORAD_PIC] := BioRadEdPix.NumberOne;
  if (MovFType =  BIORAD_PIC) and (PixSettings.UseOptionPixSize[BIORAD_PIC] = True) then begin
      PixSetChange := True;
      PixSize := 100/PixSettings.PixPer100Micr[BIORAD_PIC];
    if (MainImLoaded) then begin
      if (PixSettings.FileHasOwnPixSize) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm' else
      if Not(PixSettings.FileHasOwnPixSize) then
       lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(100/PixSettings.PixPer100Micr[MovFType],ffFixed,6,6) + ' µm/pixel';
    end;
   end;

end;

procedure TOptionsPagesDlg.ZeissLSMEdPixReturnPressed(Sender: TObject);
begin

  PixSettings.PixPer100Micr[ZEISS_CZI_LSM_MOV] := ZeissLSMEdPix.NumberOne;
  if (MovFType =  ZEISS_CZI_LSM_MOV) and (PixSettings.UseOptionPixSize[ZEISS_CZI_LSM_MOV] = True) then begin
      PixSetChange := True;
      PixSize := 100/PixSettings.PixPer100Micr[ZEISS_CZI_LSM_MOV];
    if (MainImLoaded) then begin
      if (PixSettings.FileHasOwnPixSize) then
      lbMicronsPix.Caption := 'File Info: 1 pixel = ' +
                FloatToStrF(PixSettings.FilePixSize,ffFixed,6,6) + ' µm / adjusted to: ' +
                FloatToStrF(PixSize,ffFixed,6,6) + ' µm' else
      if Not(PixSettings.FileHasOwnPixSize) then
       lbPixPer100Microns.Caption := 'Pixel Size adjusted to: ' +
          FloatToStrF(100/PixSettings.PixPer100Micr[ZEISS_CZI_LSM_MOV],ffFixed,6,6) + ' µm/pixel';
    end;
   end;
end;

procedure TOptionsPagesDlg.StackTiffFrmSecReturnPressed(Sender: TObject);
{var Cnt : Integer;
    TemDouble,ImageTime : Double;}
begin
    PixSettings.FramesPerSec[0] := StackTiffFrmSec.NumberFloat;
End;

procedure TOptionsPagesDlg.SingleGenTiffFrmSecReturnPressed(Sender: TObject);
begin
   PixSettings.FramesPerSec[1] := SingleGenTiffFrmSec.NumberFloat;
end;

{--------------- End of Pixel Settings -----------------}

procedure TOptionsPagesDlg.cbUseMoviFilePathClick(Sender: TObject);
begin
   UseMoviFilePath := cbUseMoviFilePath.Checked;
end;

procedure TOptionsPagesDlg.cbAlignXofImagePlaybackClick(Sender: TObject);
begin
   AlignfrmPlayback := cbAlignXofImagePlayback.Checked;
end;

procedure TOptionsPagesDlg.ChbCheckAllFilesExistClick(Sender: TObject);
begin
    CheckAllFilesExist := ChbCheckAllFilesExist.Checked;
    {for QED & Stack of TIFF files}
end;

procedure TOptionsPagesDlg.ChBLoadTimeStampsClick(Sender: TObject);
begin
   LoadStreamPixAndND2TimeSt := ChBLoadTimeStamps.Checked;
end;

END.

