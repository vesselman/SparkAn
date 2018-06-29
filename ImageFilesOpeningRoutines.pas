{$D-,L-,O+,Q-,R-,Y-,S-}

{these decrease the Size and Optimize Code
D- will prevent placing Debug info to your code.
L- will prevent placing local symbols to your code.
O+ will optimize your code, remove unnecessary variables etc.
Q- removes code for Integer overflow-checking.
R- removes code for range checking of strings, arrays etc.
S- removes code for stack-checking. USE ONLY AFTER HEAVY TESTING !
Y- will prevent placing symbol information to your code.}
/////////////////////////////////////////////////////////////////////////

unit ImageFilesOpeningRoutines;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.AnsiStrings,System.StrUtils, System.Math,Vcl.Forms, Vcl.Graphics, Vcl.Controls,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ComCtrls,Vcl.ExtCtrls, Vcl.Dialogs, Vcl.Menus, Vcl.Grids,
  Vcl.Clipbrd, Winapi.OpenGL,EditNumerical, SuperSubLabel,
  UniButton,unGlobUnit,unRealLineScan; // these 3 are for MPE & AVI they must be here  not down


{*************** Declaration Of Procedures and Functions **********************}
{-------------- Andor Tiff File Specific Procedures ---------------------------}
Procedure GetAndorTIFFBasicInfo(Const FName: AnsiString; var ImageWidth, ImageHeight: Word;
                                var NrDimensions: LongInt;var NrPages: LongWord;
                                var BitsPerPixel: Word; var TIFF_Type: Byte;
                                var NrChannelsInFile : Integer; Var ValidFile: Boolean);

Procedure GetAndorTIFFBinningAndPixSize(Const FName: AnsiString; var Binning: Byte;
                                        var PixSize: Double);

Procedure GetAndorTIFFNrPagesOrImageDescr(Const FName: AnsiString; Var DescrStr: AnsiString;
                                          Var CreatTimeInSec: Longint; Var NrPages: LongWord;
                                          Var NrDimensions: Longint; Const ActionMode: Byte);

Function GetAndorTiffFirstImageTime(Const FName: AnsiString): Double;
{ used to Correct a mistake in OpenCollection File v.1 & 2 used till August 2007}

Procedure IntelieveImageOffsetsAndTimeStamps(const ActionMode : Integer);

Procedure OpenCollectionFile(const CollFileName: AnsiString);

Procedure OpenAndorTIFFsAsCollection;

Procedure SaveCollectionFile(const CollFileName: AnsiString; var TiffCollFileNames : TDynAnsiStrArray);

{-------------- End of Andor Tiff File Specific Procedures --------------------}
{-------------- Biorad Files Specific Procedures ------------------------------}
Procedure GetBioRadPicFileInfo(Const FName: AnsiString; var LUTpos : Int64; Const SilentMode: Boolean);

Procedure GetBioRadPicFile_Preview(Const FName: AnsiString;var ImageWidth, ImageHeight: Word;
                                   var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                                   var DynWarr: TDynWordArray; Var ValidFile: Boolean);
{----------------- End of Biorad Files Specific Procedures --------------------}
{---------------------TIFF Files Specific Procedures --------------------------}
Procedure GetTIFFfileInfo(Var NrPages: LongWord;  Const FName: AnsiString; Const StartPage: Longint;
                          Const ActionMode: Byte; Const ColFileNr : Integer;  Const SilentMode: Boolean);

Procedure GetBigTIFFfileInfo(Var NrPages: LongWord;  Const FName: AnsiString; Const StartPage: Longint;
                              Const ActionMode: Byte; Const SilentMode: Boolean);

Procedure GetTIFFfileInfoFromRAM(Const pRawData : pByteArr; Var NrPages: LongWord;
                                 Const FName: AnsiString; Const StartPage: Longint;
                                 Const ActionMode: Byte; Const ColFileNr : Integer;
                                 Const SilentMode: Boolean);

Procedure GetBigTIFFfileInfoFromRAM(const pRawData : pByteArr; Var NrPages: LongWord;
                                 Const FName: AnsiString; Const StartPage: Longint;
                                 Const ActionMode: Byte; Const SilentMode: Boolean);

Procedure GetTIFFfile_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                              var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                              var DynWarr: TDynWordArray; var NeedSwap: Boolean;
                              Var ValidFile,MultiImage : Boolean);

{--------------------End of TIFF Files Specific Procedures --------------------}
{--------------------- LSM Zeiss File pecific Procedures ----------------------}
Procedure GetLSMfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);

Procedure GetLSMfileInfoFromRAM(const pRawData : pByteArr; Const SilentMode: Boolean);

Procedure GetLSMfile_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                             var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                             var DynWarr: TDynWordArray; Var ValidFile: Boolean);
{-------------------- End of LSM Zeiss File Specific Procedures ---------------}
{--------------------- CZI Zeiss File pecific Procedures ----------------------}
Procedure GetCZIfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);

Procedure GetCZIfileInfoFromRAM(const pRawData : pByteArr; Const SilentMode: Boolean);

Procedure GetCZIfile_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                             var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                             var DynWarr: TDynWordArray; Var ValidFile: Boolean);

{-------------------- End of CZI Zeiss File Specific Procedures ---------------}
{--------------------- ND2 Files Specific Procedures --------------------------}
Procedure GetND2fileInfo(Const FName: AnsiString; Const SilentMode: Boolean);
Procedure GetND2fileInfoFromRAM(const pRawData : pByteArr; Const SilentMode: Boolean);
Procedure GetND2fileInfo_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                             var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                             var DynWarr: TDynWordArray; Var ValidFile: Boolean);




{--------------------- End of ND2 Files Specific Procedures --------------------------}

{----------------------- QED File Specific Procedures -------------------------}
function IsImgMgrFile(const Fname : String) : Boolean;

Procedure GetImgMgrfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);
// This gets the QED Image menager File Info
{----------------------- End of QED File Specific Procedures ------------------}
{--------------------- OLD SGI Noran File Specific Procedures -----------------}
Procedure GetSGIfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);

Procedure GetSGIfile_Preview(Const FName: AnsiString;var DynBarr: TDynByteArray;
                             var ImageWidth, ImageHeight: Word;var ValidFile: Boolean);
{------------------ End of OLD SGI Noran File Specific Procedures --------------}
{---------------------Noran Prarie File Specific Procedures -----------------}
Procedure GetNoranPrairiePCFinfo(Const FName: AnsiString;Const SilentMode: Boolean);
Procedure GetNoranPrairieXMLinfo(Const FName: AnsiString; Const SilentMode: Boolean);
{------------------ End of Noran Prarie File Specific Procedures --------------}
{------------------ StreamPix Software File Specific Procedures --------------}
Procedure GetStreamPixInfo(Const FName: AnsiString; Const SilentMode: Boolean);

Procedure GetStreamPixFile_Preview(Const FName: AnsiString;var ImageWidth,
                                   ImageHeight: Word; var BitsPerPixel: Word;
                                   var DynBarr: TDynByteArray; var DynWarr: TDynWordArray;
                                   Var ValidFile: Boolean);
{------------------ End of StreamPix Software File Specific Procedures ---------}

procedure LoadBMPinUniButton(const Ch1_Color, Ch2_Color : TColor; aUniButton : TUniButton);

procedure LoadFileInRAM(Const FileCount : Integer; Const FName: AnsiString);
//for Single MultiImage Tiff File

Procedure OpenImageFile(Const FName: AnsiString; Const OpenDialogIndex : Byte;
                        Const OpenAsFileCollection: Boolean; Const SilentMode: Boolean);
{ FileType Correspond to Index in File Dialog: 1 = Solamere; 2= Noran; 3=QED Tiff File }

Procedure RefillTimStArray;

Procedure SwapImageOffsets;

Procedure OpenAvImFile(const AvFileName: AnsiString; const SilentMode: Boolean);

Procedure SaveAverImageAsSpnOwnFile(Const AvImFileName: AnsiString);

Procedure WriteImageFromFileLoadedInRAM(Const FileCount : Integer; Const FNameToWrite : AnsiString);

{*****************************************************************************}

implementation

uses unMainWindow, unImageControl, unAverIm, un2ndWin, unTimeSerAnal, unOKDlgNrImToExp,
  unSparkTable, unWaveTable, unSPautoSearch, unPeaks, unHelp, unPlayBack, Main,
  MovieLabels, unProgress, unSpatialSpread, un3DImageWin, unLineScan,unMergeWindow,
  DigiFilters, un3DImageContr, Convert, unEventSites, unCorrectForBleaching,
  unKalmanStackFilter,unFunctions,OrthogonalSectioning,unXYprofile,unIntegrate;


{***************** Procedures Descripitons Start From Here ********************}


Procedure GetAndorTIFFBasicInfo(Const FName: AnsiString; var ImageWidth, ImageHeight: Word;
                                var NrDimensions: LongInt;var NrPages: LongWord;
                                var BitsPerPixel: Word; var TIFF_Type: Byte;
                                var NrChannelsInFile : Integer; Var ValidFile: Boolean);

{ Gets X & Y dimention, BitsPerPixel, Number of Pages (Images) }

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile: THandle;
  FPos: Int64;
  BegRead: Int64;
  Cnt: Longint; { 'Counter }
  SamplesPerPixel: Word; // This is Tag 277; Not Required for Grayscale or Palleted Color
  // it is 3 for 245 bit Color
  TempLongWord: LongWord;
  { ------------------------------------------------------------------------- }
  sType: array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset: Longint; { 'Byte 8-11;  Value or Offset of the  Value. }
  PosCnt : Integer;
  MM_HEAD : TMM_HEAD;
  DimTimeLoc, DimNotTimeLoc : Longint;
  TimeDimName : AnsiString;

BEGIN

  { Initializations }
  TIFF_Type := TIFF_GENERIC; // initializes to this
  SamplesPerPixel := 1; // some files do not have Tag 277 where the value comes from
  NrPages := 1; // Number of Pages (Images) in Single TIFF
  TimeDimName := 'Unknown';
  { end with Initializations }

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  FPos := 0;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, sType, 2);
  FPos := 2;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, IfThisIsTIFF, 2);
  { ---------------------------------------------------------------- }

  If (IfThisIsTIFF = 42) and (sType = 'II') Then
  BEGIN { This is  Tiff File }

    FPos := 4;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, OffsIFD, 4);
    { finds the FPos for the first IFD (Counted From "0" }
    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
    BegRead := OffsIFD + 2;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To CntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
      Tag := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

      { -------------- Reads TAGs ------------------------------ }

      If (Tag = 256) Then
      Begin { could be SHORT or LONG }
        if (TypeF = 3) then
          ImageWidth := IFD[4]
        else { Short = Word(Pascal) 2 byte,  {bytes 8-9 }
        if (TypeF = 4) then
        begin { LongWord = 4 byte unsigned int }
          TempLongWord := IFD[5];
          ImageWidth := TempLongWord shl 16 + IFD[4];
        end;
      End { of Tag = 256 }
      Else If (Tag = 257) Then
      Begin { could be SHORT or LONG }
        if (TypeF = 3) then
          ImageHeight := IFD[4]
        else { Short = Word(Pascal) 2 byte,  {bytes 8-9 }
        if (TypeF = 4) then
        begin { LongWord = 4 byte unsigned int }
          TempLongWord := IFD[5];
          ImageHeight := TempLongWord shl 16 + IFD[4];
        end;
      End { of Tag = 257 }

      Else If (Tag = 258) Then
        { SHORT C++ } BitsPerPixel := IFD[4]

      Else If (Tag = 277) { SHORT } Then
      Begin
        SamplesPerPixel := IFD[4]; // if = 1 this is Grayscale or Palleted Color
        if (SamplesPerPixel <> 1) then
          Break;
      End { of Tag = 277 }


      Else
       { ------------- Private Andor Tags ---------------------- }
      If (Tag = 34361) then Begin
        { This Tag Appear Only in the First Image }

        TIFF_Type := TIFF_ANDOR_iQ;
        CountOfType := IFD[3];
        CountOfType := CountOfType shl 16 + IFD[2]; // CountOfType = 1454
        ValOffset := IFD[5];
        ValOffset := ValOffset shl 16 + IFD[4];

        FPos := ValOffset;
        FileSeek(TiffFile, FPos, 0);
        FileRead(TiffFile, MM_HEAD, SizeOf(MM_HEAD));

        { finds in which dimension the Time is }

        DimNotTimeLoc := -1;
        NrDimensions  := 1; // sets it initially to 1 = Only Time Dimension

        For PosCnt := 2 to High(MM_HEAD.DimInfo) do Begin // Start Counting from dimension 2, Dim 0 = x, 1 = y
           // Andor files have Zero terminated 'Time'; Olympus files have zero terminated 'T ' (T plus space (ASCII = 32))

          if (MM_HEAD.DimInfo[PosCnt].Name = 'Wavelength') then
          begin //it might or might not appear in MM_HEAD.DimInfo
            if (MM_HEAD.DimInfo[PosCnt].Size = 2) then
              NrPages := MM_HEAD.DimInfo[PosCnt].Size;
              //we do not store Wavelength dimension because we display the two channels simultaneously
              //One has to know though which channel was first
          end;

          if (MM_HEAD.DimInfo[PosCnt].Name = 'Z') then
          begin
            DimNotTimeLoc := PosCnt; // here  stores Z Dimension
            NrDimensions := 2; //we disregard all the dimensions but Time and Z
          end;

          if ((MM_HEAD.DimInfo[PosCnt].Name = 'Time1') or //this is the case in Swapnil Uncaging file; added June 3, 2016
            (MM_HEAD.DimInfo[PosCnt].Name = 'Time') or
            (MM_HEAD.DimInfo[PosCnt].Name = 'T ')) and (TimeDimName = 'Unknown')
          then
          begin
            TimeDimName := MM_HEAD.DimInfo[PosCnt].Name;
            if (DimNotTimeLoc = -1) then //no Z stack, Z does not appear in MM_HEAD.DimInfo
              NrPages := NrPages*MM_HEAD.DimInfo[PosCnt].Size;
              DimTimeLoc := PosCnt; // here  stores Time Dimension
              Break; //Time is always the Last
            end;
          End; //For PosCnt := 0 to High(MM_HEAD.DimInfo) do Begin

          if (DimNotTimeLoc <> -1) then
            NrPages := NrPages*MM_HEAD.DimInfo[DimNotTimeLoc].Size;

      End // Tag = 34361   Andor Specific

        Else

      If (Tag = 34363) then Begin  { This Tag Appear Only in the First Image.  Not everything is known }
       //so far I found (Apr 2013) that the Fisrt 4 bytes give the Number of Channels
       //TypeF = 1 meaning = Byte
        CountOfType := pLongWord(@IFD[2])^; //CountOfType = 92  for One Channel and 180 for two channels
        ValOffset   := pLongWord(@IFD[4])^;
        FileSeek(TiffFile, ValOffset, 0);
        FileRead(TiffFile, NrChannelsInFile, 4);
      End;

      { ------------- End of Private Andor Tags ---------------------- }

    End; { For Cnt := 0 To CntDE - 1  Do Begin }

    {--------------------------- End of Reading TAGs --------------------------}

    If (SamplesPerPixel = 1) then
    Begin
      ValidFile := True;
    End
    Else // If (SamplesPerPixel = 1)
    Begin
      ValidFile := False;
      MessageDlg('This is Not a Grayscale Tiff file', mtError, [mbOK], 0);
    End; // Else
    { -------------------------------------------------- }
  End
  Else { IfThisIsTIFF = 42 (this is a Tiff File }
  { -------------------------------------------------- }

  If (IfThisIsTIFF <> 42) or (sType = 'MM') Then Begin
    ValidFile := False;
    if (IfThisIsTIFF <> 42) then
      MessageDlg('This is Not a Tiff file', mtError, [mbOK], 0);
    if (sType = 'MM') then
      MessageDlg('This is Not a Intel Tiff file', mtInformation, [mbOK], 0);
  End;
  { -------------------------------------------------- }
  FileClose(TiffFile);

End; // Procedure GetAndorTIFFBasicInfo

{ *********************************************************************** }

Procedure GetAndorTIFFBinningAndPixSize(Const FName: AnsiString;
                                        var Binning: Byte; var PixSize: Double);
{ Gets Binning and PixSize }
{Used only by if (VersionNr = 1 Open Collectuion Files}

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile : THandle;
  FPos: Int64;
  BegRead: Int64;
  Cnt: Integer; { 'Counter }
  { ------------------------------------------------------------------------- }

  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset: Longint; { 'Byte 8-11;  Value or Offset of the  Value. }
  Pt : Pointer;
  PosCnt: Integer;
  MM_HEAD: TMM_HEAD;
  DescrStr: AnsiString;

BEGIN

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);

  FPos := 4;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, OffsIFD, 4);
  { finds the FPos for the first IFD (Counted From "0" }
  FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }
  BegRead := OffsIFD + 2;
  { ------- Checks All Tags in CntDE -------- }
  For Cnt := 0 To CntDE - 1 Do
  Begin
    FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
    Tag := IFD[0]; { bytes 0-1 }
    TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

    { -------------- Reads TAGs ------------------------------ }

    If (Tag = 270) Then Begin
      { ******** Important for Andor - gives All Descriptions****** }
      { Looks for the Creation Time Only in this Procedure }
      CountOfType := IFD[3];
      CountOfType := CountOfType shl 16 + IFD[2];
      ValOffset := IFD[5];
      ValOffset := ValOffset shl 16 + IFD[4];
      SetLength(DescrStr, CountOfType);
      Pt := @DescrStr[1]; // sets Pter to 1st position
      FPos := ValOffset;
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, Pt^, CountOfType);
      { Gets Binning }
      PosCnt := PosEx('Binning=', DescrStr);
      If (PosCnt > 0) then Begin // if this exist
        { it coud be just Binning or in the new version 1.4
          is binningX and binningY; and then comes the "old" "Binning=". I'll just deal for now with X binning
          assuming that is the same for Y }
        PixSettings.ImageBinning := StrToInt((Copy(DescrStr, PosCnt + 8, 1)));
      End
        Else
      If (PosCnt = 0) then PixSettings.ImageBinning := 0;

    End // If  'Tag = 270
    { -------------------------- Andor Private Tags -----------------------}

    Else If (Tag = 34361) then
    begin
      { This Tag Appear Only in the First Image }

      CountOfType := IFD[3];
      CountOfType := CountOfType shl 16 + IFD[2]; // CountOfType = 1454
      ValOffset := IFD[5];
      ValOffset := ValOffset shl 16 + IFD[4];

      FPos := ValOffset;
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, MM_HEAD, SizeOf(MM_HEAD));

      PixSettings.FilePixSize := MM_HEAD.DimInfo[0].Resolution + MM_HEAD.DimInfo
        [0].Origin; // Origin is a offset; here is always EQ 0

    End; // Tag = 34361
    { ------------- End of Private Andor Tags ---------------------- }

  End; { For Cnt := 0 To CntDE - 1  Do Begin }

  {--------------------------- End of Reading TAGs ---------------------------}

  FileClose(TiffFile);

End; // GetAndorTIFFBinningAndPixSize;

{ ***************************************************************************** }

Procedure GetAndorTIFFNrPagesOrImageDescr(Const FName: AnsiString;
                                          Var DescrStr: AnsiString; Var CreatTimeInSec: Longint;
                                          Var NrPages: LongWord; Var NrDimensions: Longint;
                                          Const ActionMode: Byte);
{ Gets Number of Pages (Images) or General Info }

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile : THandle;
  FPos: Int64;
  BegRead: Int64;
  Cnt: Integer; { 'Counter }
  { ------------------------------------------------------------------------- }

  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset: Longint; { 'Byte 8-11;  Value or Offset of the  Value. }
  Pt : Pointer;
  PosCnt: Integer;
  PosBeg: Integer;
  PosEnd: Integer;
  MM_HEAD: TMM_HEAD;
  DimTimeLoc, DimNotTimeLoc : Longint; // Loc means Local
  CreationTime: TTime;
  h, M, s, ms: Word;
  TimeDimName : AnsiString;

BEGIN

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  TimeDimName := 'Unknown';

  FPos := 4;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, OffsIFD, 4);
  { finds the FPos for the first IFD (Counted From "0" }
  FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }

  { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
  BegRead := OffsIFD + 2;
  { ------- Checks All Tags in CntDE -------- }
  For Cnt := 0 To CntDE - 1 Do
  Begin
    FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
    Tag := IFD[0]; { bytes 0-1 }
    TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

    { -------------- Reads TAGs ------------------------------ }

    If (Tag = 270) and (ActionMode in [GET_ANDOR_FILE_CREATION,GET_ANDOR_IMAGE_DESCR]) Then
    Begin
      { ******** Important for Andor - gives All Descriptions****** }
      { Looks for the Creation Time Only in this Procedure }
      CountOfType := IFD[3];
      CountOfType := CountOfType shl 16 + IFD[2];
      ValOffset := IFD[5];
      ValOffset := ValOffset shl 16 + IFD[4];
      SetLength(DescrStr, CountOfType);
      Pt := @DescrStr[1]; // sets Pter to 1st position
      FPos := ValOffset;
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, Pt^, CountOfType);
      If (ActionMode = GET_ANDOR_FILE_CREATION) Then
      Begin
        PosBeg := PosEx('[Created]', DescrStr);
        If PosBeg > 0 then Begin
          PosEnd := PosEx('[Created End]', DescrStr);
          {it used to be PosEnd := PosEx('[Grab', DescrStr); it does not exists in newer Andor software}
          DescrStr := Copy(DescrStr, PosBeg + 11, (PosEnd - 2) - (PosBeg + 11));

          PosBeg := PosEx('Time=', DescrStr);
          PosEnd := LastDelimiter(':', DescrStr);
          CreationTime := StrToTime(Copy(DescrStr, PosBeg + 5,(PosEnd + 3) - (PosBeg + 5)));
          DecodeTime(CreationTime, h, M, s, ms);
          // in this way AM/PM and 24 hour standard are read with the same function//
          if AnsiContainsStr(DescrStr, 'PM') then if h < 12 then h := h + 12;
          CreatTimeInSec := h * 3600 + M * 60 + s;
        End
        Else If PosBeg = 0 then
          CreatTimeInSec := -1;
      End; // If (ActionMode = GET_ANDOR_FILE_CREATION)

    End // If  'Tag = 270
    { -------------------------- Andor Private Tags -----------------------}

      Else

    If (Tag = 34361) and (ActionMode = GET_ANDOR_NR_PAGES) then Begin
      { This Tag Appear Only in the First Image }

      CountOfType := IFD[3];
      CountOfType := CountOfType shl 16 + IFD[2]; // CountOfType = 1454
      ValOffset := IFD[5];
      ValOffset := ValOffset shl 16 + IFD[4];

      FPos := ValOffset;
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, MM_HEAD, SizeOf(MM_HEAD));

      { finds in which dimension the Time is }
      NrPages := 1; // sets it initially to 1
      DimNotTimeLoc := -1; // sets it initially to -1
      NrDimensions := 1; // sets it initially to 1 = Only Time Dimension

      For PosCnt := 2 to High(MM_HEAD.DimInfo) do Begin // Start Counting from dimension 2, Dim 0 = x, 1 = y
      // Andor files have Zero terminated 'Time'; Olympus files have zero terminated 'T ' (T plus space (ASCII = 32))

        if (MM_HEAD.DimInfo[PosCnt].Name = 'Wavelength') then
        begin //it might or might not appear in MM_HEAD.DimInfo
          if (MM_HEAD.DimInfo[PosCnt].Size = 2) then
          NrPages := MM_HEAD.DimInfo[PosCnt].Size;
          //we do not store Wavelength dimension because we display the two channels simultaneously
          //One has to know though which channel was first
        end;

        if (MM_HEAD.DimInfo[PosCnt].Name = 'Z') then
        begin
          DimNotTimeLoc := PosCnt; // here  stores Z Dimension
          NrDimensions := 2; //we disregard all the dimensions but Time and Z
        end;

        if ((MM_HEAD.DimInfo[PosCnt].Name = 'Time1') or //this is the case in Swapnil Uncaging file; added June 3, 2016
            (MM_HEAD.DimInfo[PosCnt].Name = 'Time') or
            (MM_HEAD.DimInfo[PosCnt].Name = 'T ')) and (TimeDimName = 'Unknown')
        then
        begin
           TimeDimName := MM_HEAD.DimInfo[PosCnt].Name;
          if (DimNotTimeLoc = -1) then //no Z stack, Z does not appear in MM_HEAD.DimInfo
            NrPages := NrPages*MM_HEAD.DimInfo[PosCnt].Size;
          DimTimeLoc := PosCnt; // here  stores Time Dimension
          Break; //Time is always the Last
        end;
      End; //For PosCnt := 0 to High(MM_HEAD.DimInfo) do Begin

      if (DimNotTimeLoc <> -1) then
        NrPages := NrPages*MM_HEAD.DimInfo[DimNotTimeLoc].Size;

    End; // Tag = 34361   Andor Specific


    { ------------- End of Private Andor Tags ---------------------- }

  End; { For Cnt := 0 To CntDE - 1  Do Begin }

  /// ////////////////// End of Reading TAGs ////////////////////////////////////////

  FileClose(TiffFile);

End; // GetAndorTIFFNrPagesOrImageDescr

{ ***************************************************************************** }

Function GetAndorTiffFirstImageTime(Const FName: AnsiString): Double;
Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile : THandle;
  FPos: Int64;
  BegRead: Int64;
  Cnt: Integer; { 'Counter }
  { ------------------------------------------------------------------------- }

  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset : Longint; { 'Byte 8-11;  Value or Offset of the  Value. }
  MM_HEAD   : TMM_HEAD;
  pDArray   : Pointer;


BEGIN

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);

  FPos := 4;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, OffsIFD, 4);
  { finds the FPos for the first IFD (Counted From "0" }
  FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }

  { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
  BegRead := OffsIFD + 2;
  { ------- Checks All Tags in CntDE -------- }
  For Cnt := 0 To CntDE - 1 Do
  Begin
    FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
    Tag := IFD[0]; { bytes 0-1 }
    TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

    { -------------- Reads TAGs ------------------------------ }

    If (Tag = 34361) then Begin { This Tag Appear Only in the First Image }
      CountOfType := IFD[3];
      CountOfType := CountOfType shl 16 + IFD[2]; // CountOfType = 1454
      ValOffset := IFD[5];
      ValOffset := ValOffset shl 16 + IFD[4];

      FPos := ValOffset;
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, MM_HEAD, SizeOf(MM_HEAD));

      { dimension of the Time has already been recorded in Collection Type of File
        but has been decremented by 2; So we have to add 2 here }

      SetLength(DArray, (DimTime + 2) - 1);
      pDArray := @DArray[0];

    End // Tag = 34361   Andor Specific

      Else

    If (Tag = 34362) then Begin // Andor Specific
      { This is Time for Each Image in ms in the first 8 bytes }
      // TypeF = 1 meaning = Byte; in Fact these are 8 Doubles = 8*8 = 64 bytes

      ValOffset := IFD[5] shl 16 + IFD[4];

      FileSeek(TiffFile, ValOffset, 0);
      FileRead(TiffFile, pDArray^, Length(DArray) shl 3); // EQ Multiply by 8

      Result := DArray[DimTime]; // Stores 1st TimeSt  should be [DimTime-2+2] = [DimTime]
      if (MM_HEAD.DimInfo[DimTime + 2].Resolution <> 1) then
        Result := Result * MM_HEAD.DimInfo[DimTime + 2].Resolution;
      if (MM_HEAD.DimInfo[DimTime + 2].Origin <> 0) then
        Result := Result + MM_HEAD.DimInfo[DimTime + 2].Origin;

      if MM_HEAD.DimInfo[DimTime + 2].Units = 'ms' then
        Result := Result / 1000
      else if MM_HEAD.DimInfo[DimTime + 2].Units = 'µs' then
        Result := Result / 1000000;

    End; // Tag = 34362 (Andor Specific)
    { ------------- End of Private Andor Tags ---------------------- }

  End; { For Cnt := 0 To CntDE - 1  Do Begin }
  { ------------------ End of QED private TAG with Semi-Known Function ---------------------- }

  /// ////////////////// End of Reading TAGs ////////////////////////////////////////

  FileClose(TiffFile);

End; // Function GetAndorTIFFFistImageTime(Const FName : AnsiString) : Double;
{ ***************************************************************************** }


 Procedure OpenAndorTIFFsAsCollection;
 Var
          Cnt: Integer;
          PageMem: LongWord;
          DescrStr: AnsiString; // not used here
          CreatTimeInSec: Longint; // gives Time for Creation of Andor Tiff
          CreatFirstFile: Longint; // gives Time for Creation of the First Andor Tiff in the List
          CreatPrevFile: Longint; // gives Time for Creation of the Previous Andor Tiff in the List
          FileNr: Word;
          NrDimentions: Longint;
          NrPages: LongWord;
          ValidFile: Boolean;
          FromNr: LongWord; // Im Nr GetTIFFfileInfo should start filling ImOf and TimeSt Arrays
          NrOfColFiles: Integer;
          TimeStMem: Longint;
          LastTimeSt: Longint;
          FileSizes : TDynUInt64Array; //used to Load in RAM
          pRawData  : pByteArr; //used to Load in RAM

          { values of NrDimensions
            1 or 2 dimensions so far
            1 = Just Time Dimension;
            2 = Time and Other Dimension
            -1 = One Non-Time dimension
            }

          procedure GetPrevFileTimeStPos(Const PrevFileNr: Longint);
          var
            CntFiles: Integer;
          begin
            TimeStMem := 0;
            for CntFiles := 0 to PrevFileNr do begin
              TimeStMem := TimeStMem + CollFileImNr[CntFiles];
            end;
            Dec(TimeStMem);
          end;

 Begin

          { 2nd. Sets some arrays }
          SetLength(CollFileImNr, Length(CollFileNames));
          /// / Number of Images for Each File

          NrIm := 0;
          For Cnt := 0 to High(CollFileNames) do begin
            GetAndorTIFFNrPagesOrImageDescr(CollFileNames[Cnt], DescrStr,
              CreatTimeInSec, NrPages, NrDimentions, GET_ANDOR_NR_PAGES);
            CollFileImNr[Cnt] := NrPages;
            NrIm := NrIm + NrPages;
          End; // For Cnt := 0 to High(CollFileNames)

          SetLength(ImOff,1,NrIm);

          if (NrDimentions = 1) then
          begin
            SetLength(TimeSt, NrIm);
            ZstackArr := nil
          end
            else
          if (NrDimentions = 2) then begin
            SetLength(TimeSt, NrIm);
            SetLength(ZstackArr, NrIm);
          end
            else
          if (NrDimentions = -1) then begin
            TimeSt := nil;
            SetLength(ZstackArr, NrIm);
          end;

           { 3rd. Reads Each File and Gets Time Stamps and Image Data Offsets }
            //Tries to Allocate memory in RAM
          If (RAM_Usage.LoadFilesInRAM) then Begin
            if (frmProgress = nil) then begin
              Application.CreateForm(TfrmProgress, frmProgress);
              frmProgress.lbAction.Caption := 'Attempting to Allocate Memory in RAM';
              frmProgress.Show;
              Application.ProcessMessages;
            end;
            SetLength(FileSizes,Length(CollFileNames));
            for Cnt := 0 to High(CollFileNames) do begin
              FileSizes[Cnt] := GetBigFileSize(CollFileNames[Cnt]);
            end;
            FileInRAM := SetByteArray(RawDataInRAM,Length(CollFileNames),FileSizes);

          End;

           FromNr := 0;

          If (FileInRAM) then begin
            for Cnt := 0 to High(CollFileNames) do begin
              if (frmProgress = nil) then begin
                Application.CreateForm(TfrmProgress, frmProgress);
                frmProgress.Show;
              end;
               frmProgress.lbAction.Caption := 'Memory Allocated. Loading File ' + IntToStr(Cnt+1) + ' ('+IntToStr(Length(CollFileNames))+ ')' + ' in RAM.';
               Application.ProcessMessages;
               LoadFileInRAM(Cnt,CollFileNames[Cnt]);
               frmProgress.lbAction.Caption := 'File ' + IntToStr(Cnt+1) + ' Loaded in RAM.  Getting Info.';
               Application.ProcessMessages;
               pRawData := @RawDataInRAM[Cnt,0];
               GetTIFFfileInfoFromRAM(pRawData, NrPages, CollFileNames[Cnt], FromNr,READ_AS_COLLECTION, Cnt, False);
               FromNr := FromNr + CollFileImNr[Cnt];
            end; // For Cnt := 0 to High(CollFileNames)
          End

            Else

          Begin
            if (frmProgress = nil) then begin
              Application.CreateForm(TfrmProgress, frmProgress);
              frmProgress.Show;
            end;
            RawDataInRAM := nil; //frees the Array in Case it was loaded
            if (MultiImageTIFF) and (RAM_Usage.LoadFilesInRAM) then
              frmProgress.lbAction.Caption := 'Cannot be Loaded in RAM. Getting Info.'
            else
            if not(RAM_Usage.LoadFilesInRAM) then
              frmProgress.lbAction.Caption := 'Getting Info.';
              Application.ProcessMessages;
            For Cnt := 0 to High(CollFileNames) do begin
              GetTIFFfileInfo(NrPages, CollFileNames[Cnt], FromNr,READ_AS_COLLECTION, Cnt,False);
              FromNr := FromNr + CollFileImNr[Cnt];
            End; // For Cnt := 0 to High(CollFileNames)
          End;

          { 4th. Opens All the Files and Sets Files Handles arrays }
          // for each file//
          SetLength(CollFileHandlesList, Length(CollFileNames));
           // File Handle (Win32) for Each Image;
          SetLength(CollFileHandles, NrIm);
          if (FileInRAM) then SetLength(CollFileNrInRAM, NrIm)
          else                          CollFileNrInRAM := nil;

          For Cnt := 0 to High(CollFileHandlesList) do Begin
            CollFileHandlesList[Cnt] := FileOpen(CollFileNames[Cnt], fmOpenRead or fmShareDenyNone);
          End;
          // for each image//
          FileNr := 0; // Here is used as a Simple Counter
          PageMem := CollFileImNr[0] div NrChannels;
          For Cnt := 0 to High(CollFileHandles) Do Begin
            if (Cnt > PageMem - 1) then begin
              Inc(FileNr); // goes to the next file counter
              PageMem := PageMem + (CollFileImNr[FileNr] div NrChannels);
            end;
            CollFileHandles[Cnt] := CollFileHandlesList[FileNr];
            if (FileInRAM) then CollFileNrInRAM[Cnt] := FileNr;
          End;

          { 5th. Sets the Time. Adds Time between Files and subtracts TimeSt[0] }
          If (NrDimentions in [1, 2]) Then Begin
            FileNr := 0;
            PageMem := CollFileImNr[FileNr];
            GetAndorTIFFNrPagesOrImageDescr(CollFileNames[FileNr], DescrStr,
              CreatTimeInSec, NrPages, NrDimentions, GET_ANDOR_FILE_CREATION);
            FirstAndorTime := CreatTimeInSec; // here FirstAndorTime is used just to memorize 1ts CreatTimeInSec
            CreatFirstFile := CreatTimeInSec;
            CreatPrevFile := CreatTimeInSec;
            TimeStMem := CollFileImNr[0] - 1;
            LastTimeSt := High(TimeSt);

            For Cnt := CollFileImNr[FileNr] to High(TimeSt) Do Begin // starts from the 2nd file images
              if (Cnt > PageMem - 1) then
              begin
                Inc(FileNr); // goes to the next file counter
                GetAndorTIFFNrPagesOrImageDescr(CollFileNames[FileNr],
                  DescrStr, CreatTimeInSec, NrPages, NrDimentions,
                  GET_ANDOR_FILE_CREATION);
                PageMem := PageMem + CollFileImNr[FileNr];
              end;

              if (CreatFirstFile <> CreatTimeInSec) then
              begin
                if (CreatPrevFile <> CreatTimeInSec) then
                begin
                  GetPrevFileTimeStPos(FileNr - 1);
                  if (LastTimeSt = High(TimeSt)) then
                    LastTimeSt := TimeStMem;
                end;
                TimeSt[Cnt] := TimeSt[Cnt] + TimeSt[TimeStMem] +
                  (CreatTimeInSec - CreatFirstFile);
              end;

              CreatPrevFile := CreatTimeInSec;
            End; //For Cnt := CollFileImNr[FileNr] to High(TimeSt) Do Begin

            for Cnt := 1 to LastTimeSt do
              TimeSt[Cnt] := TimeSt[Cnt] - TimeSt[0];
            TimeSt[0] := 0;

          End; // If (NrDimentions in [1,2])

 End; // Procedure OpenAndorTIFFsAsCollection;

{ **************************************************************************** }

Procedure IntelieveImageOffsetsAndTimeStamps(const ActionMode : Integer);
const DO_ALL             = 0;  // ActionMode values
      DO_FILE_ORDER_ONLY = 1; // ActionMode values
Var CntFiles, CntImages,NumberImages, NrImFile : Integer;
    NumberImagesDone,Cnt,CntOffs,CntTimeSt,CntFHandles,CntZStack : Integer;
    ImOff_Ch1,ImOff_Ch2 : TDynUInt64Array;
    TimeSt_Ch1,TimeSt_Ch2,ZstackArrTemp : TDynDoubleArray;
    CollFileHandles_Ch1,CollFileHandles_Ch2 : Array of THandle;

Begin

 If (ActionMode = DO_ALL) Then Begin

    SetLength(ImOff_Ch1,Length(ImOff[0]) div 2);
    SetLength(ImOff_Ch2,Length(ImOff[0]) div 2);

    SetLength(TimeStStore,Length(TimeSt));
    Move(TimeSt[0],TimeStStore[0],Length(TimeStStore)*SizeOf(Double));

    SetLength(TimeSt_Ch1,Length(TimeStStore) div 2);
    SetLength(TimeSt_Ch2,Length(TimeStStore) div 2);

    if Not(FileInRAM) then begin
      SetLength(CollFileHandles_Ch1,Length(CollFileHandles) div 2);
      SetLength(CollFileHandles_Ch2,Length(CollFileHandles) div 2);
    end;

    If (DimNotTime >-1) Then Begin //if this is a Zstack
      SetLength(ZstackArrTemp,Length(ZstackArr));
      Move(ZstackArr[0],ZstackArrTemp[0],Length(ZstackArr)*SizeOf(Double));
      SetLength(ZstackArr,Length(ZstackArrTemp) div 2);
    End;

  {It has to Intelieve 1 and 2, 3 and 4, 5 and 6 and so on.}

   CntFiles := 0;
   NumberImages := 0;
   CntOffs := 0;
   CntTimeSt := 0;
   CntFHandles := 0;
   CntZStack := 0;
   While CntFiles <= High(CollFileImNr) Do Begin
    NumberImagesDone := NumberImages;
    NrImFile := CollFileImNr[CntFiles];
    NumberImages := NumberImages + CollFileImNr[CntFiles]*2;

    If (FileInRAM) Then
    For CntImages := NumberImagesDone to NumberImages-1 Do Begin
      if Odd(CntImages) then begin //Channel 2
        CollFileNrInRAM[CntImages] := CntFiles+1;
      end
        else
      begin  //Channel 1
        CollFileNrInRAM[CntImages] := CntFiles;
      end;
    End
     Else
    If Not(FileInRAM)Then
    For CntImages := NumberImagesDone to NumberImagesDone + NrImFile-1 Do Begin
      CollFileHandles_Ch1[CntFHandles] := CollFileHandles[CntImages]; //Channel 1
      CollFileHandles_Ch2[CntFHandles] := CollFileHandles[CntImages+NrImFile]; //Channel 2
      Inc(CntFHandles);
    End; //For CntImages := NumberImagesDone to NumberImages-1 Do Begin

    For CntImages := NumberImagesDone to NumberImagesDone + NrImFile-1 Do Begin
      ImOff_Ch1[CntOffs] := ImOff[0,CntImages]; //Channel 1
      ImOff_Ch2[CntOffs] := ImOff[0,CntImages+NrImFile]; //Channel 2
      Inc(CntOffs);
    End;

    For CntImages := NumberImagesDone to NumberImagesDone + NrImFile-1 Do Begin
      TimeSt_Ch1[CntTimeSt] := TimeStStore[CntImages]; //Channel 1
      TimeSt_Ch2[CntTimeSt] := TimeStStore[CntImages+NrImFile]; //Channel 2
      Inc(CntTimeSt);
    End;

    If (DimNotTime >-1) Then
    For CntImages := NumberImagesDone to NumberImagesDone + NrImFile-1 Do Begin
      ZstackArr[CntZStack] := ZstackArrTemp[CntImages]; //Channel 1 Only
      Inc(CntZStack);
    End;

   Inc(CntFiles,2);

  End;  //While CntFiles <= High(CollFileImNr) Do Begin

  NrIm := NrIm div 2;
  SetLength(ImOff,2,NrIm);
  NrChannels := 2;

  if Not(FileInRAM) then
  for CntImages := 0 to High(CollFileHandles_Ch1) do begin
    CollFileHandles[CntImages*2]   := CollFileHandles_Ch1[CntImages];
    CollFileHandles[CntImages*2+1] := CollFileHandles_Ch2[CntImages];
  End; //For

  for CntImages := 0 to High(ImOff[0]) do begin
    ImOff[0,CntImages] := ImOff_Ch1[CntImages];
    ImOff[1,CntImages] := ImOff_Ch2[CntImages];
  end;

  for CntImages := 0 to High(TimeSt_Ch1) do begin
    TimeStStore[CntImages*2]   := TimeSt_Ch1[CntImages];
    TimeStStore[CntImages*2+1] := TimeSt_Ch2[CntImages] - TimeSt_Ch2[0];
  end;

  SetLength(TimeSt,NrIm);
  RefillTimStArray;

 End  // If (ActionMode = DO_ALL) Then Begin

   Else

 If (ActionMode = DO_FILE_ORDER_ONLY) Then Begin

   if Not(FileInRAM) then begin
      SetLength(CollFileHandles_Ch1,Length(CollFileHandles) div 2);
      SetLength(CollFileHandles_Ch2,Length(CollFileHandles) div 2);
   end;

  {It has to Intelieve 1 and 2, 3 and 4, 5 and 6 and so on.}

   CntFiles := 0;
   NumberImages := 0;
   CntFHandles := 0;

   While CntFiles <= High(CollFileImNr) Do Begin
    NumberImagesDone := NumberImages;
    NrImFile := CollFileImNr[CntFiles];
    NumberImages := NumberImages + CollFileImNr[CntFiles]*2;

    If (FileInRAM) Then
    For CntImages := NumberImagesDone to NumberImages-1 Do Begin
      if Odd(CntImages) then begin //Channel 2
        CollFileNrInRAM[CntImages] := CntFiles+1;
      end
        else
      begin  //Channel 1
        CollFileNrInRAM[CntImages] := CntFiles;
      end;
    End
     Else
    If Not(FileInRAM)Then
    For CntImages := NumberImagesDone to NumberImagesDone + NrImFile-1 Do Begin
      CollFileHandles_Ch1[CntFHandles] := CollFileHandles[CntImages]; //Channel 1
      CollFileHandles_Ch2[CntFHandles] := CollFileHandles[CntImages+NrImFile]; //Channel 2
      Inc(CntFHandles);
    End; //For CntImages := NumberImagesDone to NumberImages-1 Do Begin

   Inc(CntFiles,2);

  End;  //While CntFiles <= High(CollFileImNr) Do Begin

  if Not(FileInRAM) then
  for CntImages := 0 to High(CollFileHandles_Ch1) do begin
    CollFileHandles[CntImages*2]   := CollFileHandles_Ch1[CntImages];
    CollFileHandles[CntImages*2+1] := CollFileHandles_Ch2[CntImages];
  End; //For

  RefillTimStArray;

  End;

End;  // Procedure IntelieveImageOffsetsAndTimeStamps

{****************************************************************************}

Procedure GetBioRadPicFileInfo(Const FName: AnsiString; var LUTpos : Int64; Const SilentMode: Boolean);

Var

  BioradPicHeader: TBioradPicHeader; // 76 bytes
  BioradPicNote: TBioradPicNote; // 96 bytes
  BioRadPicFile: THandle;
  FPos: Int64;
  P: Pointer;
  Cnt: Integer;
  StartChar, Count: Integer;
  CntSpace: Integer;

  XMLfile: TextFile;
  ReadStr: AnsiString;
  BioradZstep : Double; //Z step in Zstack files

  Procedure GetNoteInfo;
  Begin

    // Gets Pixel Size for X , no need to look for Y
    //AnsiStrings.AnsiStartsStr//
    If (AnsiStartsStr('AXIS_2', BioradPicNote.Info)) then
    {AXIS_2 = Horizontal axis information; AXIS_3 = Vertical axis information}
    Begin
      StartChar := 0;
      Count := 0;
      CntSpace := 0;
      Cnt := Length('AXIS_2');
      while (CntSpace < 4) do
      begin
        if (BioradPicNote.Info[Cnt] = AnsiChar(32)) then
        begin
          Inc(CntSpace);
        end;

        if (CntSpace = 3) and (StartChar = 0) then
        begin
          StartChar := Cnt + 1;
        end;

        if (CntSpace = 4) and (Count = 0) then
        begin
          Count := Cnt - StartChar + 1;
        end;
        Inc(Cnt);
      end; // while

      PixSettings.FilePixSize := StrToFloat(string(Copy(BioradPicNote.Info,StartChar, Count)));
      PixSettings.FileHasOwnPixSize := True;

    End

      Else

    If (AnsiStartsStr('AXIS_4', BioradPicNote.Info)) then
    {AXIS_4 gives Z step in Zstack files}
    Begin
      StartChar := 0;
      Count := 0;
      CntSpace := 0;
      Cnt := Length('AXIS_4');
      while (CntSpace < 4) do
      begin
        if (BioradPicNote.Info[Cnt] = AnsiChar(32)) then
        begin
          Inc(CntSpace);
        end;

        if (CntSpace = 3) and (StartChar = 0) then
        begin
          StartChar := Cnt + 1;
        end;

        if (CntSpace = 4) and (Count = 0) then
        begin
          Count := Cnt - StartChar + 1;
        end;
        Inc(Cnt);
      end; // while

      if (AnsiString(Copy(BioradPicNote.Info,StartChar+Count+1, 7)) = 'Microns') then
      begin
        MovieSeriesType := Z_Stack;
        ZstackUnits := 'µm';
        BioradZstep := StrToFloat(string(Copy(BioradPicNote.Info,StartChar, Count)));
      end
      else
        MovieSeriesType := TimeSeries;
    End //If (AnsiStartsStr('AXIS_4', BioradPicNote.Info))

      Else // If (AnsiStartsStr('AXIS_2',BioradPicNote.Info)) then Begin

    // Gets Zoom
    If (AnsiStartsStr('INFO_OBJECTIVE_ZOOM', BioradPicNote.Info))then
    Begin
      StartChar := Length('INFO_OBJECTIVE_ZOOM = ');
      Count := 0;
      Cnt := StartChar;
      while (Count = 0) do
      begin
        if (Byte(BioradPicNote.Info[Cnt]) = 0) then
        begin
          Count := Cnt - StartChar;
        end;
        Inc(Cnt);
      end; // while
      Inc(StartChar);
      ScopeSystemParams.Optical_Zoom := StrToFloat(string(Copy(BioradPicNote.Info, StartChar,Count)));
    End
      Else // If (AnsiStartsStr('INFO_OBJECTIVE_ZOOM',BioradPicNote.Info)) then Begin

    // Gets Objective Magnification
    If (AnsiStartsStr('INFO_OBJECTIVE_MAGNIFICATION',BioradPicNote.Info)) then
    Begin
      StartChar := Length('INFO_OBJECTIVE_MAGNIFICATION = ');
      Count := 0;
      Cnt := StartChar;
      while (Count = 0) do
      begin
        if (Byte(BioradPicNote.Info[Cnt]) = 0) then
        begin
          Count := Cnt - StartChar;
        end;
        Inc(Cnt);
      end; // while
      Inc(StartChar);
      ScopeSystemParams.Objective_Mag := StrToInt(string(Copy(BioradPicNote.Info,StartChar,Count)));
    End
      Else
    If (AnsiStartsStr('PIXEL_BIT_DEPTH', BioradPicNote.Info)) then Begin
      StartChar := Length('PIXEL_BIT_DEPTH = ');
      Count := 0;
      Cnt := StartChar;
      while (Count = 0) do
      begin
        if (Byte(BioradPicNote.Info[Cnt]) = 0) then
        begin
          Count := Cnt - StartChar;
        end;
        Inc(Cnt);

      end; // while
      Inc(StartChar);
      BitCount := StrToInt(string(Copy(BioradPicNote.Info, StartChar, Count)));
      shrFact := BitCount - 8;
    End  // (AnsiStartsStr('PIXEL_BIT_DEPTH', BioradPicNote.Info))
      Else
    If (AnsiStartsStr('INFO_FRAME_RATE', BioradPicNote.Info)) then Begin
      StartChar := Length('INFO_FRAME_RATE = ');
      Count := 0;
      Cnt := StartChar;
      while (Count = 0) do begin
        if (Byte(BioradPicNote.Info[Cnt]) = 0) then
        begin
          Count := Cnt - StartChar;
        end;
        Inc(Cnt);
       end; // while
      Inc(StartChar);
      MeanImTime := 1 / (StrToFloat(string(Copy(BioradPicNote.Info, StartChar,Count))));
      { the Real image Time is Recorded Only in 'lse.xml' file.

        the Frame Rate recorded in BioradPicNote.Info is nearly the same as the one
        recorded in 'lse.xml' file unless the experiment is Uncaging in ROI.
        In "Uncaging in ROI" experiment is  the Actual Framerate is much slower
        then the one recorded in BioradPicNote.Info:
        one example ~2 im/s recored in BioradPicNote.Info versus 0.7 calculated from
        real time for each image recorded in 'lse.xml' file.
        }

    End
      Else // If (AnsiStartsStr('INFO_OBJECTIVE_MAGNIFICATION',BioradPicNote.Info)) then Begin

    If (AnsiStartsStr('INFO_PIXEL_DWELL', BioradPicNote.Info)) then Begin
      StartChar := Length('INFO_PIXEL_DWELL = ');
      Count := 0;
      Cnt := StartChar;
      while (Count = 0) do
      begin
        if (Byte(BioradPicNote.Info[Cnt]) = 0) then
        begin
          Count := Cnt - StartChar;
        end;
        Inc(Cnt);
      end; // while
      Inc(StartChar);
      ScopeSystemParams.PixDwell := Round((StrToFloat(string(Copy(BioradPicNote.Info, StartChar,Count)))*1E9));
       //convert sec to ns
      ScopeSystemParams.PixDwell_Units := 'ns';

    End; //If (AnsiStartsStr('PIXEL_DWELL', BioradPicNote.Info))then
    //
  End; // Procedure GetNoteInfo;

Begin
  { unlike GetBioRadPicFile_Preview here we use Win32 File I/O to ensure opening files > 2 GB }

  { 1st: the BioRad Header }
  BioRadPicFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  FPos := 0;
  FileSeek(BioRadPicFile, FPos, 0);
  FileRead(BioRadPicFile, BioradPicHeader, SizeOf(BioradPicHeader));

  If (BioradPicHeader.file_id = 12345) then Begin

    imXsize := BioradPicHeader.nx;
    imYsize := BioradPicHeader.ny;
    NrIm := BioradPicHeader.npic;
    ImagePix := imXsize * imYsize;
    if (BioradPicHeader.byte_format = 1) then
      BitCount := 1
    else
      BitCount := 2;
    // the actual Bit-Deph is recorded in Notes
    ImageBytes := imXsize * imYsize * BitCount;
    { number of blocks (each one byte to read }

    // in Notes the Exact Bit-Depth is found

    SetLength(TimeSt, NrIm);
    SetLength(ImOff,1, NrIm);
    for Cnt := 0 to High(ImOff[0]) do
      ImOff[0,Cnt] := Cnt * ImagePix * BitCount + 76;

    // Get NOTES if they Exist//
    If (BioradPicHeader.notes) Then Begin // Notes Exist
      FPos := NrIm * ImagePix * BitCount + 76; // 1st Note position
      FileSeek(BioRadPicFile, FPos, 0);
      FileRead(BioRadPicFile, BioradPicNote, SizeOf(BioradPicNote));
      GetNoteInfo;

      If (BioradPicNote.next) then begin
        While (BioradPicNote.next) do begin // the rest of the Notes are 96 bytes apart
          FPos := FPos + 96;
          FileSeek(BioRadPicFile, FPos, 0);
          FileRead(BioRadPicFile, BioradPicNote, SizeOf(BioradPicNote));
          GetNoteInfo;
        End; // While (BioradPicNote.next) do begin
      End; // If (BioradPicNote.next) then begin

      // Find if there is LUT (colr table )
      // RGB lookup tables, each of which is 768 bytes
        LUTpos := -1; //no own Colr Table LUT
      If (GetFileSize(BioRadPicFile, nil) - (FPos + 96)) = 768 then Begin
        if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
        P := @FileColorTBL_Ch1[0];
        frmImageControl.ubFileColTable.Tag := 3; //this is temporary later is replaced by NrChannels
        FPos := FPos + 96;
        LUTpos := FPos;
        FileSeek(BioRadPicFile, FPos, 0);
        FileRead(BioRadPicFile, P^, 768);
      End;

    End
      Else // If (BioradPicHeader.notes) Then begin   }
    Begin
      // This could be very Old Biorad files which did not have Notes
      // Just Set the Time to the Image Number
      for Cnt := 0 to High(TimeSt) do
        TimeSt[Cnt] := Cnt + 1;
      MeanImTime := 1;
      BitCount := BitCount * 8; // set it to used in Program BitCount
      shrFact := BitCount - 8;
    End; // If (BioradPicHeader.notes) Then begin

    // --------------------------------------------------------------------------//
    { 2nd: Get exact time recorded in lse.xml }

    If FileExists(ExtractFilePath(FName) + 'lse.xml') then Begin
      { There are 3 lines: 1st = <?xml version="1.0"?>
        2nd = <!--LaserSharp Microscopy Experiment.-->
        3rd = all th rest
        }
      AssignFile(XMLfile, ExtractFilePath(FName) + 'lse.xml');
      FileMode := fmOpenRead;
      Reset(XMLfile);
      Readln(XMLfile);
      Readln(XMLfile, ReadStr);
      if AnsiContainsStr(ReadStr, 'LaserSharp Microscopy Experiment') then
      begin
        Readln(XMLfile, ReadStr);
        Cnt := 0;
        For StartChar := 1 to Length(ReadStr) - 13 Do
        Begin
          if (ReadStr[StartChar] = AnsiChar(32)) then
          begin

            if Copy(ReadStr, StartChar + 1, 13) = 'TimeCompleted' then
            begin
              Count := StartChar + 16;
              while (ReadStr[Count] <> '"') do
                Inc(Count);
              TimeSt[Cnt] := StrToFloat
                (string(AnsiMidStr(ReadStr, StartChar + 16,
                    Count - (StartChar + 16))));
              Inc(Cnt);
            end; // if Copy(ReadStr,StartChar+1,13) = 'TimeCompleted' then begin

          end; // if (ReadStr[StartChar] = AnsiChar(32)) then begin
        End; // For StartChar := 1 to Length(ReadStr)-13 Do Begin
      end; // if AnsiContainsStr(ReadStr,'LaserSharp Microscopy Experiment') then begin
      CloseFile(XMLfile);

      for Cnt := 1 to High(TimeSt) do
        TimeSt[Cnt] := TimeSt[Cnt] - TimeSt[0];
      TimeSt[0] := 0;
      MeanImTime := TimeSt[High(TimeSt)] / (NrIm - 1);
    End
      Else
    Begin
      // If lse.xml does not exist then we fill TimeSt based on
      // MeanImTime calculated form INFO_FRAME_RATE Note
      TimeSt[0] := 0;
      for Cnt := 1 to High(TimeSt) do
        TimeSt[Cnt] := TimeSt[Cnt - 1] + MeanImTime;
    End;

    If (MovieSeriesType = Z_Stack) then Begin
      SetLength(ZstackArr,NrIm);
      for Cnt := 0 to High(ZstackArr) do
        ZstackArr[Cnt] := Cnt*BioradZstep;
    End;
  End;

  FileClose(BioRadPicFile);

End; //End of Procedure GetBioRadPicFileInfo

{ **************************************************************************** }

Procedure GetBioRadPicFile_Preview(Const FName: AnsiString;var ImageWidth, ImageHeight: Word;
                                   var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                                   var DynWarr: TDynWordArray; Var ValidFile: Boolean);

var

  BioradPicHeader: TBioradPicHeader;
  BioRadPicFile: File;
  FPos: Longint;
  P: Pointer;

Begin

  AssignFile(BioRadPicFile, FName);
  FileMode := fmOpenRead;
  Reset(BioRadPicFile, 1);
  FPos := 0;
  Seek(BioRadPicFile, FPos);
  BlockRead(BioRadPicFile, BioradPicHeader, SizeOf(BioradPicHeader));

  If (BioradPicHeader.file_id = 12345) then
  Begin
    ValidFile := True;
    ImageWidth := BioradPicHeader.nx;
    ImageHeight := BioradPicHeader.ny;
    FPos := 76; // 1st image always starts at offset 76 (after Header = BioradPicHeader)
    Seek(BioRadPicFile, FPos);
    if (BioradPicHeader.byte_format = 1) then
    Begin
      BitsPerPixel := 8;
      SetLength(DynBarr, ImageWidth * ImageHeight);
      P := @DynBarr[0];
      BlockRead(BioRadPicFile, P^, Length(DynBarr));
    end
    else
    begin
      BitsPerPixel := 16;
      SetLength(DynWarr, ImageWidth * ImageHeight);
      P := @DynWarr[0];
      BlockRead(BioRadPicFile, P^, Length(DynWarr) * 2);
    end;
    
  End
  Else
    ValidFile := False;

  CloseFile(BioRadPicFile);

End;  //Procedure GetBioRadPicFile_Preview


{******************************************************************************}

Procedure GetLSMfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);

{ Open Zeiss LSM Files. So far works with Time series & Zstack up to Two Channels.
  LSM files are actually Tiff Files with some restrictions }


Type

   TTag34412 = Packed Record // Private Zeiss LSM Tag - this is the only one they have
    MagicNumber         : LongWord;
    StructureSize       : LongWord;
    DimensionX          : LongWord;
    DimensionY          : LongWord;
    DimensionZ          : LongWord;
    DimensionChannels   : LongWord;
    DimensionTime       : LongWord;
    IntensityDataType   : LongWord; // Gives Bit= Dept; Value of 1 = 8 bit, 2 = 12 bit, 3 = 16 bit, 5 = 32 bit
    ThumbnailX          : LongWord;
    ThumbnailY          : LongWord;
    VoxelSizeX          : Double;
    VoxelSizeY          : Double;
    VoxelSizeZ          : Double;
    OriginX             : Double;
    OriginY             : Double;
    OriginZ             : Double;
    ScanType            : Word;
    SpectralScan        : Word;
    DataType            : LongWord;
    OffsetVectorOverlay : LongWord;
    OffsetInputLut      : LongWord;
    OffsetOutputLut     : LongWord;
    OffsetChannelColors : LongWord;
    TimeInterval        : Double;
    OffsetChannelDataTypes: LongWord;
    OffsetScanInformation : LongWord;
    OffsetKsData        : LongWord;
    OffsetTimeStamps    : LongWord;
    OffsetEventList     : LongWord;
    OffsetRoi           : LongWord;
    OffsetBleachRoi     : LongWord;
    OffsetNextRecording : LongWord;
  end;

Label ReadAgain;

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile : THandle;
  FPos: Int64;
  BegRead: Int64;
  Cnt : Longint; { 'Counter }
  TemCnt : Integer;
  SamplesPerPixel: Word; //  // in Zeiss LSM SamplesPerPixel is EQ Number of Channels
  // it is 3 for 245 bit Color
  PalettedColor: Boolean;

  { ----------- Variables For the Final Output  ---------------- }
  XimSize : LongWord; { Tag = 256; TypeF = 3 }
  YimSize : LongWord; { Tag = 257  TypeF = 3 }
  BitsPerPixel : Word; { Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology" }
  StripOffsLoc  : array of LongWord; // LocalL; Tag = 273  TypeF = 4 'Strip Offset
  TemWarr : array of Word; // used in case this is array of SHORT(C++)= Word(Pascal

  { ------------------------------------------------------------------------- }
  sType: array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }

  { TypeF = '1 = BYTE (8-bit unsigned integer)
    '2 = ASCII (8-bit ASCII code , last one = NULL[binary 0])
    '3 = SHORT (16-bit [2 byte] unsigned integer = Word [Pascal])
    '4 = LONG  (32 bit [4 byte] unsigned integer = LongWord [Pascal])
    '5 = RATIONAL (2 LONGs, 1st nominator of a fraction, second denominator
    fraction = nominator/denominator) }

  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset: LongWord; { 'Byte 8-11;  Value or Offset of the  Value. E.g. we need offset for
    'String QED Camera Plugin, but not for the other Variables }
  Pt : Pointer;

  Tag34412: TTag34412; // Zeiss LSM files private TAG
  ts: Integer;

PttructureSize: Longint;
  NumberTimeStamps : Longint;

  TYPE_SUBBLOCK: LongWord;
  NewSubfileType: LongWord;
  LW : LongWord;
  BitDepth : LongWord;
  PageCnt  : Integer;
Ptender   : TObject;
  //added Oct 2016 to find colors and make color tables
  R,G,B : Byte;
  ColDec : Double;

BEGIN

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);

  FPos := 0;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, sType, 2);

  If (sType = 'II') then
  Begin
    FPos := 2;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, IfThisIsTIFF, 2);
  End
  Else
  Begin
    MessageDlg('This is Not a Intel Zeiss LSM file', mtError, [mbOK], 0);
  End;

  If (IfThisIsTIFF <> 42) Then
  Begin
    MessageDlg('This is Not a Zeiss LSM file', mtError, [mbOK], 0);
  End;

  { ------------------------------------------------------------------ }

  If (IfThisIsTIFF = 42) and (sType = 'II') Then
  BEGIN { LSM is always Intel Tiff File }

    { Initializations }

    PageCnt := -1; // Counts Pages
    PalettedColor := False;
    { end with Initializations }

    FPos := 4;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, OffsIFD, 4);

    { finds the FPos for the first IFD (Counted From "0" }

  ReadAgain :

    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }

    BegRead := OffsIFD + 2;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To CntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
      Tag := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

      { ------- Only I N T E L  Byte Order is used by LSM files  ------- }

      If (Tag = 254) Then
      Begin
        NewSubfileType := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
        { NewSubfileType (LongWord) is  = 0 for Images and 	= 1 for thumbnails }
        if (NewSubfileType = 0) then Inc(PageCnt);
      End
        else
      If (Tag = 256) and (PageCnt = 0) and (NewSubfileType = 0) Then
      Begin { LSM is always LONG }
        XimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
      End { of Tag = 256 }
        else
      If (Tag = 257) and (PageCnt = 0) and (NewSubfileType = 0) Then
      Begin { LSM is always LONG }
        YimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
      End { of Tag = 257 }
        Else
      If (Tag = 258) and (PageCnt = 0) and (NewSubfileType = 0) Then Begin
        CountOfType := pLongWord(@IFD[2])^;
        if (CountOfType = 1) then BitsPerPixel := IFD[4]
          else
        Begin
          ValOffset := pLongWord(@IFD[4])^;
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile,BitsPerPixel,2);
          //Reads just the 1st value for Channel 1, for 2nd Channel it should be the same
        End;
      End
        Else
      If (Tag = 273) and (NewSubfileType = 0) Then Begin
        { for LSM StripOffsets means the offset for Each Channel
          Not the offset to each Streap if Image is broken in Streaps }
        { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }

        if (PageCnt = 0) then begin
          CountOfType := pLongWord(@IFD[2])^;
        SetLength(StripOffsLoc,CountOfType);
        end;

        If (Length(StripOffsLoc) = 1) Then StripOffsLoc[0] := pLongWord(@IFD[4])^
          else
        If (Length(StripOffsLoc) > 1) Then Begin
          ValOffset := pLongWord(@IFD[4])^;
          FileSeek(TiffFile, ValOffset, 0);
          Pt := @StripOffsLoc[0];
          FileRead(TiffFile, Pt^,Length(StripOffsLoc)*4);
        End;

      End
          Else
      If (Tag = 277) and (PageCnt = 0) and (NewSubfileType = 0) Then Begin { Word (ShortInt)}
        SamplesPerPixel := IFD[4]; // for LSM this is EQ Number of Channels
      End { of Tag = 277 }


      { -------------End of --- TIFF Public  Tags -------------------- }

      { -------------Beg of --- Zeiss LSM Only Private Tags (so far only One ---------------- }
        Else

      If (Tag = 34412) then Begin // LSM Files Private tag May be missing from older files
        CountOfType := pLongWord(@IFD[2])^;
        ValOffset := pLongWord(@IFD[4])^;
        FileSeek(TiffFile, ValOffset, 0);
        FileRead(TiffFile, Tag34412, SizeOf(Tag34412));

        With Tag34412 do Begin

         if (DimensionChannels > 2) or not(Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y,Line_Scan])
         then  Break;

          //Line-Scan gives DimensionX = ImXsize, DimensionY = 1;

          // pixel sizes are stored in meters, we need them in microns
          PixSettings.FilePixSize := VoxelSizeX * 1000000;
          if (Tag34412.ScanType = Time_Series_X_Y) then begin
            NrIm := DimensionTime;
            MovieSeriesType := TimeSeries; //sets it to more common variable
          end
            else
          if (Tag34412.ScanType = X_Y_Z_Scan)   then begin
            NrIm := DimensionZ;
            MovieSeriesType := Z_Stack;  //sets it to more common variable
          end
            else
          if (Tag34412.ScanType = Line_Scan) then  begin
            NrIm := 1;
            MovieSeriesType := LineScan; //sets it to more common variable
          end;

           //Get Channels Names and Colors
          If (OffsetChannelColors > 0) Then Begin

          frmImageControl.ubFileColTable.Tag := DimensionChannels;

          FileSeek(TiffFile, OffsetChannelColors + 12, 0);
          FileRead(TiffFile, ValOffset, SizeOf(ValOffset));

          FileSeek(TiffFile, OffsetChannelColors+ValOffset, 0);
          FileRead(TiffFile, R, 1);

          FileSeek(TiffFile, OffsetChannelColors+ValOffset+1, 0);
          FileRead(TiffFile, G, 1);

          FileSeek(TiffFile, OffsetChannelColors+ValOffset+2, 0);
          FileRead(TiffFile, B, 1);

           //generate color table from the Colors.Ptee my note below why I do not try to load a "Real Color Table".
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch1[TemCnt] := round(ColDec*TemCnt);
          end
            else
          for TemCnt := 0 to 255 do FileColorTBL_Ch1[TemCnt] := 0;
          {Proc RemoveFileColorTable no longer sets FileColorTBL_Ch1 and Ch2 to nill
         Pto it has to be zeroed}

          if (G > 0) then begin
            ColDec := G/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch1[256+TemCnt] := round(ColDec*TemCnt);
          end
            else
          for TemCnt := 0 to 255 do FileColorTBL_Ch1[256+TemCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch1[512+TemCnt] := round(ColDec*TemCnt);
          end
            else
          for TemCnt := 0 to 255 do FileColorTBL_Ch1[512+TemCnt] := 0;

          If (DimensionChannels = 2) then Begin

          FileSeek(TiffFile, OffsetChannelColors + ValOffset+4, 0);
          FileRead(TiffFile, R, 1);

          FileSeek(TiffFile, OffsetChannelColors + ValOffset+4+1, 0);
          FileRead(TiffFile, G, 1);

          FileSeek(TiffFile, OffsetChannelColors + ValOffset+4+2, 0);
          FileRead(TiffFile, B, 1);

          if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch2[TemCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[256+TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch2[256+TemCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[512+TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch2[512+TemCnt] := 0;
          end; //getting color and generating ColorTables

          //Get Channel Names
          ScopeSystemParams.Ch1_Name := '';
          ScopeSystemParams.Ch2_Name := '';
          FileSeek(TiffFile, OffsetChannelColors+16, 0);
          FileRead(TiffFile, ValOffset, SizeOf(ValOffset));
          ValOffset := ValOffset + 4;
          TemCnt := 0;
          B := 1; //here B is used as generic Byte; Just set to 1 to start the loop
          while (B <> 0) do begin

            FileSeek(TiffFile, OffsetChannelColors+ValOffset+TemCnt, 0);
            FileRead(TiffFile, B, 1);

            if (B = 0) then Break;
          ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(B);
            Inc(TemCnt);
          end;
          if (DimensionChannels = 2) then begin
            ValOffset := ValOffset + 11;
            TemCnt := 0;
            B := 1; //here B is used as generic Byte; Just set to 1 to start the loop
            while (B <> 0) do begin
              FileSeek(TiffFile, OffsetChannelColors+ValOffset+TemCnt, 0);
              FileRead(TiffFile, B, 1);
              if (B = 0) then Break;
            ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(B);
              Inc(TemCnt);
            end;
          end;
          End;  //getting Channel Names

        SetLength(ImOff,DimensionChannels,NrIm);

          if (ScanType = X_Y_Z_Scan) then
        SetLength(TimeSt,DimensionZ)
            else
        SetLength(TimeSt,DimensionTime);  //use DimensionTime not NrIm because Line Scan has one image but  TimeSt times DimensionTime

          Pt := @TimeSt[0]; // sets Pter to 1st position

          if (DimensionTime > 1) then begin

            FileSeek(TiffFile, OffsetTimeStamps, 0);
            FileRead(TiffFile, StructureSize, SizeOf(Longint)); // Structure size = SizeOf(StructureSize) + SizeOf(NumberTimeStamps) + Sizeof(All Time Stamps);

            FileSeek(TiffFile, OffsetTimeStamps + 1 * SizeOf(Longint), 0);
            FileRead(TiffFile, NumberTimeStamps, SizeOf(Longint));

            FileSeek(TiffFile, OffsetTimeStamps + 2 * SizeOf(Longint), 0);
            FileRead(TiffFile, Pt^, NumberTimeStamps * SizeOf(Double));

             //time stamps are in seconds one time stamp per image or one per line if LineScan
            for ts := 1 to High(TimeSt) do
              TimeSt[ts] := TimeSt[ts] - TimeSt[0];   // time stamps are in seconds
            TimeSt[0] := 0;
          end
            else
          if (DimensionZ > 1) then begin
          //Sets Z sections in microns//
          //Z sections are stored in meters, we need them in microns
            for ts := 0 to High(TimeSt) do  TimeSt[ts] := ts*VoxelSizeZ * 1000000;
            MovieSeriesType := Z_Stack;
        end;
        End; // With Tag34412 do Begin

      End; //  If (Tag = 34412) then Begin //this is the Lst tag

    End; { For Cnt := 0 To CntDE - 1  Do Begin }

    /// ////////////////// End of Reading TAGs ////////////////////////////////////////

  If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2) then Begin

      // in LSM SamplesPerPixel means Number of Channels

      If (PageCnt = 0) then Begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
        frmProgress.ImageProgressBar.Max := NrIm - 1;
        frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1) + ' (' + IntToStr(NrIm) + ')';
        Application.ProcessMessages;
      End; // If (GetAllPages) and (PageCnt = 0)

      if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.Show;
        frmProgress.ImageProgressBar.Max := NrIm - 1;
      end;

      if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.Show;
        frmProgress.ImageProgressBar.Max := NrIm - 1;
      end;
      frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1) + ' (' + IntToStr(NrIm) + ')';
      frmProgress.ImageProgressBar.Position := PageCnt;
      Application.ProcessMessages;

      // Get the Offset of next IFD = (Offset to 1st IDF Number) + 2 + 12*(Directory Entries)
      FPos := FPos + 12;
      FileSeek(TiffFile, FPos, 0); // looks for next image
      FileRead(TiffFile, ValOffset, 4);

      if (NewSubfileType = 0) then
      for TemCnt  := 0 to High(StripOffsLoc) do begin
        ImOff[TemCnt,PageCnt] := StripOffsLoc[TemCnt]; //load Offset for each channel
      end;

      If (ValOffset <> 0) then
      Begin // more then One image
        OffsIFD := ValOffset;
        GoTo ReadAgain;
      End;
      // !!!!!!!!!!!!!!!!!!!!!!!!!!! End of LOOP  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

      if (frmProgress <> nil) then frmProgress.Close;

      { at the End }
    End; // If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2)

    { ------------------------------------------------------------------------------ }

    { Sets Global Variables }
    If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2) and
      (Tag34412.ScanType in [X_Y_Z_Scan,Line_Scan,Time_Series_X_Y]) and (BitsPerPixel in [8,16])  Then
    Begin // Grayscale and Color Palleted have 1 per Pixel

      imXsize := XimSize;
      imYsize := YimSize;
      ImagePix := imXsize * imYsize;
      BitCount := BitsPerPixel;

      ToSwap := False;

      NrChannels := Tag34412.DimensionChannels;
      ScanType   := Tag34412.ScanType;

      if (Tag34412.IntensityDataType in [1,2,3]) then BitDepth := Tag34412.IntensityDataType
        else
      if (Tag34412.IntensityDataType = 0) and (Tag34412.OffsetChannelDataTypes > 0) then begin
         //IntensityDataType = 0 and OffsetChannelDataTypes > 0 if we have more then One channel
         // reads just the BitDepth for the 1st channel
        FileSeek(TiffFile, Tag34412.OffsetChannelDataTypes, 0);
        FileRead(TiffFile, BitDepth, SizeOf(LongWord));
      end;

      if (BitDepth = 1) then BitDepth := 8 else
      if (BitDepth = 2) then BitDepth := 12 else
      if (BitDepth = 3) then BitDepth := 16;

      // According to the newest infoo LSM file Images can be 8, 12, 16 32 bit dept

      if (BitDepth = 8)  then shrFact := 0 else
      if (BitDepth = 12) then shrFact := 4 else
      if (BitDepth = 16) then shrFact := 8;

      PixSettings.FileHasOwnPixSize := True;

      SetLength(StripOffs,Length(StripOffsLoc));
      for TemCnt  := 0 to High(StripOffsLoc) do begin
      StripOffs[TemCnt] := StripOffsLoc[TemCnt]; //load Offset for each channel
      end;

    End  //if (SamplesPerPixel <= 2)

      Else

    Begin
     If not(SilentMode) Then Begin
      if (SamplesPerPixel > 2) or (Tag34412.DimensionChannels > 2) then
        MessageDlg('This File has ' + IntToStr(SamplesPerPixel) +
              ' Channels. SparkAn so far Works with One or Two Channel Files. ',
            mtError, [mbOK], 0)
      else if not(Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y]) then
        MessageDlg('This is Not a "Time Series X-Y or X_Y_Z_Scan.', mtError, [mbOK], 0)
      else if (BitsPerPixel = 32) then
        MessageDlg('This File has 32 bit images.' +
              'SparkAn so far opens 8, 12, or 16 bit-dept files. ', mtError, [mbOK], 0);
      End; // SilentMode = False

    End; // Else Begin

  End; // If (IfThisIsTIFF = 42) and (sType = 'II') Then

  { --------------------------------------------------- }
  FileClose(TiffFile);

  {Andor & Biorad Zstack Files Have always Time Stamps.  That's why Z data
    is saved to ZstackArr.  Zeiss Zstack files have Only (µm).
    To avoid Compications with the Plot Routines That always expect Time Stamps
    the Z data are saved in the TimeSt array}


End; // Procedure GetLSMfileInfo


{******************************************************************************}

Procedure GetLSMfileInfoFromRAM(const pRawData : pByteArr; Const SilentMode: Boolean);

{ Open Zeiss LSM Files. So far works with Time series & Zstack up to Two Channels.
  LSM files are actually Tiff Files with some restrictions }

Type

   TTag34412 = Packed Record // Private Zeiss LSM Tag - this is the only one they have
    MagicNumber         : LongWord;
    StructureSize       : LongWord;
    DimensionX          : LongWord;
    DimensionY          : LongWord;
    DimensionZ          : LongWord;
    DimensionChannels   : LongWord;
    DimensionTime       : LongWord;
    IntensityDataType   : LongWord; // Gives Bit= Depth; Value of 1 = 8 bit, 2 = 12 bit, 3 = 16 bit, 5 = 32 bit
    ThumbnailX          : LongWord;
    ThumbnailY          : LongWord;
    VoxelSizeX          : Double;
    VoxelSizeY          : Double;
    VoxelSizeZ          : Double;
    OriginX             : Double;
    OriginY             : Double;
    OriginZ             : Double;
    ScanType            : Word;
    SpectralScan        : Word;
    DataType            : LongWord;
    OffsetVectorOverlay : LongWord;
    OffsetInputLut      : LongWord;
    OffsetOutputLut     : LongWord;
    OffsetChannelColors : LongWord;
    TimeInterval        : Double;
    OffsetChannelDataTypes: LongWord;
    OffsetScanInformation : LongWord;
    OffsetKsData        : LongWord;
    OffsetTimeStamps    : LongWord;
    OffsetEventList     : LongWord;
    OffsetRoi           : LongWord;
    OffsetBleachRoi     : LongWord;
    OffsetNextRecording : LongWord;
  end;

Label ReadAgain;

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }

  FPos: Int64;
  BegRead: Int64;
  Cnt: Longint; { 'Counter }
  TemCnt : Integer;
  SamplesPerPixel: Word; //  // in Zeiss LSM SamplesPerPixel is EQ Number of Channels
  // it is 3 for 245 bit Color
  PalettedColor: Boolean;

  { ----------- Variables For the Final Output  ---------------- }
  XimSize : LongWord; { Tag = 256; TypeF = 3 }
  YimSize : LongWord; { Tag = 257  TypeF = 3 }
  BitsPerPixel : Word; { Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology" }
  StripOffsLoc  : array of LongWord; //Local (global is StripOffs) Tag = 273  TypeF = 4 'Strip Offset
  TemWarr : array of Word; // used in case this is array of SHORT(C++)= Word(Pascal

  { ------------------------------------------------------------------------- }
  sType: array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }

  { TypeF = '1 = BYTE (8-bit unsigned integer)
    '2 = ASCII (8-bit ASCII code , last one = NULL[binary 0])
    '3 = SHORT (16-bit [2 byte] unsigned integer = Word [Pascal])
    '4 = LONG  (32 bit [4 byte] unsigned integer = LongWord [Pascal])
    '5 = RATIONAL (2 LONGs, 1st nominator of a fraction, second denominator
    fraction = nominator/denominator) }

  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset: LongWord; { 'Byte 8-11;  Value or Offset of the  Value. E.g. we need offset for
    'String QED Camera Plugin, but not for the other Variables }
  Point: Pointer;

  Tag34412 : TTag34412; // Zeiss LSM files private TAG
  ts: Integer;

  StructureSize: Longint;
  NumberTimeStamps: Longint;

  TYPE_SUBBLOCK: LongWord;
  NewSubfileType: LongWord;
  LW : LongWord;
  BitDepth : LongWord;
  PageCnt  : Integer;
  Sender   : TObject;
  //added Oct 2016 to find colors and make color tables
  R,G,B : Byte;
  ColDec : Double;

BEGIN

  FPos := 0;
  Move(pRawData[FPos],sType[0], 2);

  If (sType = 'II') then
  Begin
    FPos := 2;
    IfThisIsTIFF := pWord(@pRawData[FPos])^;
  End
    Else
  Begin
    MessageDlg('This is Not a Intel Zeiss LSM file', mtError, [mbOK], 0);
  End;

  If (IfThisIsTIFF <> 42) Then
  Begin
    MessageDlg('This is Not a Zeiss LSM file', mtError, [mbOK], 0);
  End;

  { ------------------------------------------------------------------ }

  If (IfThisIsTIFF = 42) and (sType = 'II') Then
  BEGIN { LSM is always Intel Tiff File }

    { Initializations }

    PageCnt := -1; // Counts Pages
    PalettedColor := False;
    { end with Initializations }

    FPos := 4;
    OffsIFD := pLongWord(@pRawData[FPos])^;

    { finds the FPos for the first IFD (Counted From "0" }

    // This Label Makes the Loop for multiimage TIFFs//
  ReadAgain :

    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    CntDE := pWord(@pRawData[FPos])^; { 'Gets Number of Entrees in IDF }

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }

    BegRead := OffsIFD + 2;

    { ------- Checks All Tags in CntDE -------- }

    For Cnt := 0 To CntDE - 1 Do
    Begin

      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      Move(pRawData[FPos],IFD[0], 12); { Gets each CntDE each 12 byte Entries }

      Tag   := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

      { ------- Only I N T E L  Byte Order is used by LSM files  ------- }

      If (Tag = 254) Then
      Begin
        NewSubfileType := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
        { NewSubfileType (LongWord) is  = 0 for Images and 	= 1 for thumbnails }
        if (NewSubfileType = 0) then Inc(PageCnt);
      End
        else
      If (Tag = 256) and (PageCnt = 0) and (NewSubfileType = 0) Then
      Begin { LSM is always LONG }
        XimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
      End { of Tag = 256 }
        else
      If (Tag = 257) and (PageCnt = 0) and (NewSubfileType = 0) Then
      Begin { LSM is always LONG }
        YimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
      End { of Tag = 257 }
        Else
      If (Tag = 258) and (PageCnt = 0) and (NewSubfileType = 0) Then Begin
        CountOfType := pLongWord(@IFD[2])^;
        if (CountOfType = 1) then BitsPerPixel := IFD[4]
          else
        Begin  //if there is more than one channel
          ValOffset := pLongWord(@IFD[4])^;
          BitsPerPixel := pWord(@pRawData[ValOffset])^;
          //Reads just the 1st value for Channel 1, for 2nd Channel it should be the same
        End;
      End
        Else
      If (Tag = 273) and (NewSubfileType = 0) Then Begin
        { for LSM StripOffsets means the offset for Each Channel
          Not that the offset to each Streap if Image is broken in Streaps }
        { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }

        if (PageCnt = 0) then begin
          CountOfType := pLongWord(@IFD[2])^;
          SetLength(StripOffsLoc,CountOfType);
        end;

        If (Length(StripOffsLoc) = 1) Then StripOffsLoc[0] := pLongWord(@IFD[4])^
          else
        If (Length(StripOffsLoc) > 1) Then Begin
          ValOffset := pLongWord(@IFD[4])^;
          Move(pRawData[ValOffset],StripOffsLoc[0],Length(StripOffsLoc)*4);
        End;

      End
          Else
      If (Tag = 277) and (PageCnt = 0) and (NewSubfileType = 0) Then Begin { Word (ShortInt)}
        SamplesPerPixel := IFD[4]; // for LSM this is EQ Number of Channels
      End { of Tag = 277 }

      { -------------End of --- TIFF Public  Tags -------------------- }

      { -------------Beg of --- Zeiss LSM Only Private Tags (so far only One ---------------- }
        Else

      If (Tag = 34412) then Begin // LSM Files Private tag May be missing from older files
        CountOfType := pLongWord(@IFD[2])^;
        ValOffset := pLongWord(@IFD[4])^;
        Move(pRawData[ValOffset],Tag34412,SizeOf(Tag34412));

        With Tag34412 do Begin

         if (DimensionChannels > 2) or not(Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y,Line_Scan])
         then  Break;

          //Line-Scan gives DimensionX = ImXsize, DimensionY = 1;
          // pixel sizes are stored in meters, we need them in microns
          PixSettings.FilePixSize := VoxelSizeX * 1000000;
          if (Tag34412.ScanType = Time_Series_X_Y) then begin
            NrIm := DimensionTime;
            MovieSeriesType := TimeSeries; //sets it to more common variable
          end
            else
          if (Tag34412.ScanType = X_Y_Z_Scan)   then begin
            NrIm := DimensionZ;
            MovieSeriesType := Z_Stack;  //sets it to more common variable
          end
            else
          if (Tag34412.ScanType = Line_Scan) then  begin
            NrIm := 1;
            MovieSeriesType := LineScan; //sets it to more common variable
          end;

          //Get Channels Names and Colors
          If (OffsetChannelColors > 0) Then Begin

          frmImageControl.ubFileColTable.Tag := DimensionChannels;

          ValOffset := pLongWord(@pRawData[OffsetChannelColors + 12])^;

      {   alternative way of getting RGB by using ChannelColor : TColor
          ChannelColor := 	pLongInt(@pRawData[OffsetChannelColors + ValOffset])^;
          R := GetRValue(ChannelColor);
          G := GetGValue(ChannelColor);
          B := GetBValue(ChannelColor);   }

          R := pRawData[OffsetChannelColors + ValOffset];
          G := pRawData[OffsetChannelColors + ValOffset+1];
          B := pRawData[OffsetChannelColors + ValOffset+2];

           //generate color table from the Colors.  See my note below why I do not try to load a "Real Color Table".
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
          if (R > 0) then begin
            ColDec := R/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch1[TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch1[TemCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch1[256+TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch1[256+TemCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch1[512+TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch1[512+TemCnt] := 0;

          If (DimensionChannels = 2) then Begin

          R := pRawData[OffsetChannelColors + ValOffset+4];
          G := pRawData[OffsetChannelColors + ValOffset+4+1];
          B := pRawData[OffsetChannelColors + ValOffset+4+2];

          if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch2[TemCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[256+TemCnt] := round(ColDec*TemCnt);
          end
           else
          for TemCnt := 0 to 255 do FileColorTBL_Ch2[256+TemCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[512+TemCnt] := round(ColDec*TemCnt);
          end
           else
            for TemCnt := 0 to 255 do FileColorTBL_Ch2[512+TemCnt] := 0;
          end;

          //Get Channel Names
          ScopeSystemParams.Ch1_Name := '';
          ScopeSystemParams.Ch2_Name := '';
          ValOffset := pLongWord(@pRawData[OffsetChannelColors + 16])^ + 4;
          TemCnt := 0;
          while (pRawData[OffsetChannelColors + ValOffset + TemCnt] <> 0) do begin
            if (pRawData[OffsetChannelColors + ValOffset + TemCnt] = 0) then Break;
            ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(pRawData[OffsetChannelColors + ValOffset + TemCnt]);
            Inc(TemCnt);
          end;
          if (DimensionChannels = 2) then begin
            ValOffset := ValOffset + 11;
            TemCnt := 0;
            while (pRawData[OffsetChannelColors + ValOffset + TemCnt] <> 0) do begin
              if (pRawData[OffsetChannelColors + ValOffset + TemCnt] = 0) then Break;
              ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(pRawData[OffsetChannelColors + ValOffset + TemCnt]);
              Inc(TemCnt);
            end;
          end;
          End;

           // End of Get Channels Names and Colors


          SetLength(ImOff,DimensionChannels,NrIm);

          if (ScanType = X_Y_Z_Scan) then
          SetLength(TimeSt,DimensionZ)
            else
          SetLength(TimeSt,DimensionTime);  //use DimensionTime not NrIm because Line Scan has one image but  TimeSt times DimensionTime

          if (DimensionTime > 1) then begin

            // Structure size = SizeOf(StructureSize) + SizeOf(NumberTimeStamps) + Sizeof(All Time Stamps);
            Move(pRawData[OffsetTimeStamps],StructureSize, SizeOf(Longint));
            Move(pRawData[OffsetTimeStamps + 1 * SizeOf(Longint)],NumberTimeStamps, SizeOf(Longint));
            Move(pRawData[OffsetTimeStamps + 2 * SizeOf(Longint)],TimeSt[0], NumberTimeStamps * SizeOf(Double));

             //time stamps are in seconds one time stamp per image or one per line if LineScan
            for ts := 1 to High(TimeSt) do
              TimeSt[ts] := TimeSt[ts] - TimeSt[0];
            TimeSt[0] := 0;
          end
            else
          if (DimensionZ > 1) then begin
            //Sets Z sections in microns//
            //Z sections are stored in meters, we need them in microns
            for ts := 0 to High(TimeSt) do  TimeSt[ts] := ts*VoxelSizeZ * 1000000;
            MovieSeriesType := Z_Stack;
          end;

        End; // With Tag34412 do Begin

      End; //  If (Tag = 34412) then Begin //this is the Lst tag

    End; { For Cnt := 0 To CntDE - 1  Do Begin }

    /// ////////////////// End of Reading TAGs ////////////////////////////////////////

  If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2) then Begin

      // in LSM SamplesPerPixel means Number of Channels

      If (PageCnt = 0) then Begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
        frmProgress.ImageProgressBar.Max := NrIm - 1;
        frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1) + ' (' + IntToStr(NrIm) + ')';
        Application.ProcessMessages;
      End; // If (GetAllPages) and (PageCnt = 0)

      if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.Show;
        frmProgress.ImageProgressBar.Max := NrIm - 1;
      end;

      frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1) + ' (' + IntToStr(NrIm) + ')';
      frmProgress.ImageProgressBar.Position := PageCnt;
      Application.ProcessMessages;

      // Get the Offset of next IFD = (Offset to 1st IDF Number) + 2 + 12*(Directory Entries)
      FPos := FPos + 12;
      ValOffset := pLongWord(@pRawData[FPos])^; // looks for next image

      if (NewSubfileType = 0) then
      for TemCnt  := 0 to High(StripOffsLoc) do begin
        ImOff[TemCnt,PageCnt] := StripOffsLoc[TemCnt]; //load Offset for each channel
      end;

      If (ValOffset <> 0) then
      Begin // more then One image
        OffsIFD := ValOffset;
        GoTo ReadAgain;
      End;
      // !!!!!!!!!!!!!!!!!!!!!!!!!!! End of LOOP  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

      if (frmProgress <> nil) then frmProgress.Close;

      { at the End }
    End; // If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2)

    { ------------------------------------------------------------------------------ }

    { Sets Global Variables }
    If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2) and
      (Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y,Line_Scan]) and (BitsPerPixel in [8,16])  Then
    Begin // Grayscale and Color Palleted have 1 per Pixel

      imXsize := XimSize;
      imYsize := YimSize;
      ImagePix := imXsize * imYsize;
      BitCount := BitsPerPixel;

      ToSwap := False;

      NrChannels := Tag34412.DimensionChannels;
      ScanType   := Tag34412.ScanType;

      if (Tag34412.IntensityDataType in [1,2,3]) then BitDepth := Tag34412.IntensityDataType
        else
      if (Tag34412.IntensityDataType = 0) and (Tag34412.OffsetChannelDataTypes > 0) then begin
         //IntensityDataType = 0 and OffsetChannelDataTypes > 0 if we have more then One channel
         // reads just the BitDepth for the 1st channel
        Move(pRawData[Tag34412.OffsetChannelDataTypes],BitDepth, SizeOf(Longint));
      end;

      if (BitDepth = 1) then BitDepth := 8 else
      if (BitDepth = 2) then BitDepth := 12 else
      if (BitDepth = 3) then BitDepth := 16;

      // According to the newest infoo LSM file Images can be 8, 12, 16 32 bit dept

      if (BitDepth = 8)  then shrFact := 0 else
      if (BitDepth = 12) then shrFact := 4 else
      if (BitDepth = 16) then shrFact := 8;

      PixSettings.FileHasOwnPixSize := True;

      SetLength(StripOffs,Length(StripOffsLoc));
      for TemCnt  := 0 to High(StripOffsLoc) do begin
        StripOffs[TemCnt] := StripOffsLoc[TemCnt]; //load Offset for each channel
      end;

    End  //If (SamplesPerPixel <= 2)

      Else

    Begin
     If not(SilentMode) Then Begin
      if (SamplesPerPixel > 2) or (Tag34412.DimensionChannels > 2) then
        MessageDlg('This File has ' + IntToStr(SamplesPerPixel) +
              ' Channels. SparkAn so far Works with One or Two Channel Files. ',
            mtError, [mbOK], 0)
      else if not(Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y,Line_Scan]) then
        MessageDlg('This is Not a "Time Series X-Y or X_Y_Z_Scan or Line Scan.', mtError, [mbOK], 0)
      else if (BitsPerPixel = 32) then
        MessageDlg('This File has 32 bit images.' +
              '  SparkAn so far opens 8, 12, or 16 bit-dept files. ', mtError, [mbOK], 0);
      End; // SilentMode = False
    End; // Else Begin

  End; // If (IfThisIsTIFF = 42) and (sType = 'II') Then

  {Andor & Biorad Zstack Files Have always Time Stamps.  That's why Z data
    is saved to ZstackArr.  Zeiss Zstack files have Only (µm).
    To avoid Compications with the Plot Routines That always expect Time Stamps
    the Z data are saved in the TimeSt array}

End; // Procedure GetLSMfileInfoFromRAM //

{******************************************************************************}

Procedure GetLSMfile_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                             var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                             var DynWarr: TDynWordArray; Var ValidFile: Boolean);

Type

  TTag34412 = Packed Record // Private Zeiss LSM Tag - this is the only one they have
    MagicNumber         : LongWord;
    StructureSize       : LongWord;
    DimensionX          : LongWord;
    DimensionY          : LongWord;
    DimensionZ          : LongWord;
    DimensionChannels   : LongWord;
    DimensionTime       : LongWord;
    IntensityDataType   : LongWord; // Gives Bit= Dept; Value of 1 = 8 bit, 2 = 12 bit, 3 = 16 bit, 5 = 32 bit
    ThumbnailX          : LongWord;
    ThumbnailY          : LongWord;
    VoxelSizeX          : Double;
    VoxelSizeY          : Double;
    VoxelSizeZ          : Double;
    OriginX             : Double;
    OriginY             : Double;
    OriginZ             : Double;
    ScanType            : Word;
    SpectralScan        : Word;
    DataType            : LongWord;
    OffsetVectorOverlay : LongWord;
    OffsetInputLut      : LongWord;
    OffsetOutputLut     : LongWord;
    OffsetChannelColors : LongWord;
    TimeInterval        : Double;
    OffsetChannelDataTypes: LongWord;
    OffsetScanInformation : LongWord;
    OffsetKsData        : LongWord;
    OffsetTimeStamps    : LongWord;
    OffsetEventList     : LongWord;
    OffsetRoi           : LongWord;
    OffsetBleachRoi     : LongWord;
    OffsetNextRecording : LongWord;
  end;

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile : THandle;
  FPos: Int64;
  BegRead: Int64;
  SearchRec: TSearchRec;
  Cnt: Longint; { 'Counter }
  TemCnt: Integer;
  SamplesPerPixel: Word; // This is Tag 277; Not Required for Grayscale or Palleted Color
  // it is 3 for 245 bit Color
  { ----------- Variables For the Final Output  ---------------- }
  // BitsPerPixel     : Word;    {Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology"}
  TemWarr: array of Word; // used in case this is array of SHORT(C++)= Word(Pascal
  RowsPerStrip: LongWord; // Tag = 278  TypeF = 3 or 4; Rows per Strip
  ReadStr : AnsiString; { Tag = 305, EQ String with 3 lenght }
  { ------------------------------------------------------------------------- }
  sType: array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE: Word; { Number of Directory Entrees (DE) in IDF }
  IFD: array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag   : Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF : Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType: LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset : Longint; { 'Byte 8-11;  Value or Offset of the  Value. }
  Pt     : Pointer;
  { for Andor multipage tiff }
  PosCnt    : Integer;
  ImageDesc : AnsiString; // Image Description - used by Andor to store a lot of Info
  DimTimeLoc: Longint;
  DimNotTimeLoc: Longint;
  AndorNrDIMLoc: Longint;
  { For Time Stamps of Generic Multipage Tiffs }
  TemDouble, ImageTime: Double;

  { Specific for this procedure }
  StripOffsLoc: array of LongWord; //Loc = Local variable
  {Tag = 273  TypeF = 4 'Strip Offset; FPos offset Where the Image Data Start; }

  ImageByteCount : Integer; // Size of Image in Bytes
  ReadArrPos: LongWord;

  Tag34412: TTag34412; // Zeiss LSM files private TAG

  BitDepth : LongWord;

BEGIN

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);

  FPos := 0;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, sType, 2);

  If (sType = 'II') then
  Begin
    FPos := 2;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, IfThisIsTIFF, 2);
  End
  Else
  Begin
    ValidFile := False;
    MessageDlg('This is Not a Intel Zeiss LSM file', mtError, [mbOK], 0);
  End;

  If (IfThisIsTIFF <> 42) Then
  Begin
    ValidFile := False;
    MessageDlg('This is Not a Zeiss LSM file', mtError, [mbOK], 0);
  End;

  { ---------------------------------------------------------------- }

  If (IfThisIsTIFF = 42) and (sType = 'II') Then
  BEGIN { LSM is always Intel  Type }

    FPos := 4;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, OffsIFD, 4);

    { finds the FPos for the first IFD (Counted From "0" }

    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
    BegRead := OffsIFD + 2;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To CntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
      Tag   := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }

      If (Tag = 256) Then Begin { Always  LongWord}
        ImageWidth := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
      End { of Tag = 256 }
        Else
      If (Tag = 257) Then Begin { Always  LongWord }
        ImageHeight := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
      End { of Tag = 257 }
        Else
      If (Tag = 258) Then Begin
        CountOfType := pLongWord(@IFD[2])^;
        if (CountOfType = 1) then BitsPerPixel := IFD[4]
          else
        Begin
          ValOffset := pLongWord(@IFD[4])^;
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile,BitsPerPixel,2);
          //Reads just the 1st value for Channel 1, for 2nd Channel it should be the same
        End;
      End
        Else
      If (Tag = 273) Then Begin
        // for LSM StripOffsets means the offset for Each Channel Not the offset to each Streap if Image is broken in Streaps
        { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }
        CountOfType := pLongWord(@IFD[2])^;
        SetLength(StripOffsLoc,CountOfType);
        If (CountOfType = 1) Then StripOffsLoc[0] := pLongWord(@IFD[4])^
          else
        If (CountOfType > 1) Then Begin
          ValOffset := pLongWord(@IFD[4])^;
          FileSeek(TiffFile, ValOffset, 0);
          Pt := @StripOffsLoc[0];
          FileRead(TiffFile, Pt^,CountOfType*4);
        End;
      End { of Tag = 273 }
        Else
      If (Tag = 277) { SHORT } Then Begin
          SamplesPerPixel := IFD[4]; // in Zeiss LSM SamplesPerPixel is EQ Number of Channels
      End { of Tag = 277 }
        Else
      If (Tag = 279) Then Begin
        { Size of Image Data in Bytes in one Strip officialy in TIFF terminology called = StripByteCounts
          Don't need this because Image in LSM file always has one strip with size XxYxBytes per pixel }
      End // of Tag = 279, 'last tag value

          Else

      If (Tag = 34412) then begin
         // LSM Files Private tag May be missing from older files
        CountOfType := pLongWord(@IFD[2])^;
        ValOffset := pLongWord(@IFD[4])^;
        FileSeek(TiffFile, ValOffset, 0);
        FileRead(TiffFile, Tag34412, SizeOf(Tag34412));

      End; // Last Tag = 34412

    End; { For Cnt := 0 To CntDE - 1  Do Begin }
    { ------------------ End of Reading TAGs ---------------------- }

     // Check if Another Image Follows- Offset of next IFD = (Offset to 1st IDF Number) + 2 + 12*(Directory Entries)

        FPos := FPos + 12;
        FileSeek(TiffFile, FPos, 0); // looks for next image
        FileRead(TiffFile, ValOffset, 4);


    If (SamplesPerPixel <= 2) and (Tag34412.DimensionChannels <= 2) and
        (Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y,Line_Scan]) and (BitsPerPixel in [8,16]) then Begin

      ValidFile := True;

      If (BitsPerPixel = 16) Then
      Begin
        ImageByteCount := ImageWidth * ImageHeight*2;
        SetLength(DynWarr, ImageWidth * ImageHeight);
        Pt := @DynWarr[0];
      End
      Else If (BitsPerPixel = 8) Then
      Begin
        ImageByteCount := ImageWidth * ImageHeight;
        SetLength(DynBarr, ImageWidth * ImageHeight);
        Pt := @DynBarr[0];
      End;

      FileSeek(TiffFile, StripOffsLoc[0], 0);
      FileRead(TiffFile, Pt^, ImageByteCount);
    End

      Else

    Begin
      ValidFile := False;
      if (SamplesPerPixel > 2) then
        MessageDlg('This File has ' + IntToStr(SamplesPerPixel) +
              ' Channels. SparkAn so far Works with One or Two Channel Files. ',
            mtError, [mbOK], 0)
      else if not(Tag34412.ScanType in [X_Y_Z_Scan,Time_Series_X_Y,Line_Scan])
      then
        MessageDlg('This is Not a "Time Series X-Y or X_Y_Z_Scan or Line Scan.', mtError, [mbOK], 0)
      else if (Tag34412.IntensityDataType = 5) or (BitsPerPixel = 32)
      then
        MessageDlg('This File has 32 bit images.' +
              '  SparkAn so far opens 8, 12, or 16 bit-dept files. ', mtError, [mbOK], 0);

    End; // Else

  End; //If (IfThisIsTIFF = 42) and (sType = 'II') Then
  { -------------------------------------------------- }
  FileClose(TiffFile);

End; // Procedure GetLSMfile_Preview

{**************************************************************************** }

Procedure GetCZIfileInfoFromRAM(const pRawData : pByteArr; Const SilentMode: Boolean);
Type
TAttachmentEntrySchemaA1 = Packed Record //size 128 bytes
  SchemaType      : Array[0..1] of AnsiChar; //Offset = 0;  = "A1";
  Reserved 	      : Array[0..9] of Byte; 	//Offset = 2
  FilePosition    :	Int64; // Offset =  12; Seek offset relative to the first byte of the file;
  FilePart 	      : Integer; // / Offset =  20
  ContentGuid     : TGUID; //Offset = 24, Size =	16; 	Unique Id to be used in strong, fully qualified references
  ContentFileType : Array[0..7] of AnsiChar;	//Offset = 40 	//Unique file type Identifier (see table below), for Example: "CZTIMS" meaning Time stamp list.
  Name 	          : Array[0..79] of AnsiChar; //Offset = 48; Size = 80; for Example "TimeStamps"
end;

Const SegmentHeaderSize     = 32;  //bytes
      SizeOfSegmentHeaderID = 16; //bytes

var  Ach                              : AnsiChar;
     BitsPerPixelStr                  : AnsiString;
     pT                               : Pointer;
     i,StrPosCnt,NrOffs,ChNr         : Integer;
     BitDepth                         : LongWord;
     NextZISRAWSUBBLOCKpos            : Int64;
     pAnsiChr                         : pAnsiChar;
     R,G,B                            : Byte;
     ColDec                           : Double;
     AnsiCharArr                      : Array[0..2] of AnsiChar;
     TemStr                           : AnsiString;
     Sender                           : TObject;
     // ------------- Zeiss Variables --------------------//
     MetadataSize                     : Integer;
     FPos                             : Int64;
     AttachmentDirectoryPosition      : Int64;
     XmlSize,AttachmentSize           : Integer;
     SizeZ                            : Integer; //number of images in Zstack. If > 0 then SizeT Number of timepoints (imageas) = 1
     SizeT                            : Integer; // Number of timepoints. (images in Time Series)
     Zstep                            : Double; //the Z step in meters (I convert to µm)
     AttachmentEntrySchemaA1          : TAttachmentEntrySchemaA1; // size 128 bytes
     XMLstr                           : AnsiString;
     DistanceId_Z                     : Double;
     AllocatedSize,UsedSize           : Int64;
     ZISRAWATTACH_DataSize            : Integer;
     ZISRAWATTDIR_EntryCount          : Integer;
     OffsetTo_ZISRAWFILE_Data         : Int64;
     OffsetTo_ZISRAWATTDIR_Data       : Int64;
     OffsetTo_ZISRAWSUBBLOCK          : Int64;
     OffsetTo_ZISRAWSUBBLOCK_Data     : Int64;
     OffsetTo_Previous_ZISRAWSUBBLOCK : Int64;
     OffsetTo_ZISRAWMETADATA          : Int64;
     OffsetTo_ZISRAWMETADATA_Data     : Int64;
     OffsetTo_ZISRAWMETADATA_XmlStr   : Int64;
     OffsetTo_TimeStamps              : Int64;
     OffsetTo_LookupTables            : Int64; //Not in Use

Begin


  FPos := SizeOfSegmentHeaderID;
  Move(pRawData[FPos],AllocatedSize, SizeOf(Int64));

  OffsetTo_ZISRAWSUBBLOCK := SegmentHeaderSize + AllocatedSize;
  {Offset to the 1st ZISRAWSUBBLOCK is always the same = 512 + 32 = 544}

  //Read Segment Data//
  OffsetTo_ZISRAWFILE_Data := SegmentHeaderSize;

  FPos := OffsetTo_ZISRAWFILE_Data + 60;
  Move(pRawData[FPos],OffsetTo_ZISRAWMETADATA, SizeOf(OffsetTo_ZISRAWMETADATA));

  FPos := OffsetTo_ZISRAWFILE_Data + 72;
  Move(pRawData[FPos],AttachmentDirectoryPosition, SizeOf(AttachmentDirectoryPosition));
  {AttachmentDirectoryPosition varies.  It is counted from the Beginnig of File}

  //Read Directly ZISRAWATTDIR Segment Data//
  OffsetTo_ZISRAWATTDIR_Data := AttachmentDirectoryPosition + SegmentHeaderSize;
  {Reads ZISRAWATTACH with the TimeStamps After ZISRAWMETADATA Reading.
  Only if the Movie is Time Series. Zstack does not have TimeStamps}

  OffsetTo_ZISRAWMETADATA_Data := OffsetTo_ZISRAWMETADATA + SegmentHeaderSize;

  FPos := OffsetTo_ZISRAWMETADATA_Data;
  Move(pRawData[FPos],XmlSize, SizeOf(XmlSize));

  OffsetTo_ZISRAWMETADATA_XmlStr := OffsetTo_ZISRAWMETADATA_Data + 256;

  SetLength(XMLstr,XmlSize);
  FPos := OffsetTo_ZISRAWMETADATA_XmlStr;
  pT := @XMLstr[1];
  Move(pRawData[FPos],pT^, XmlSize);

    StrPosCnt := AnsiPos('SizeX>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('SizeX>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    imXsize := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeX>'), i-(StrPosCnt + Length('SizeX>'))));

    StrPosCnt := AnsiPos('SizeY>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('SizeY>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    imYsize := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeY>'), i-(StrPosCnt + Length('SizeY>'))));

    StrPosCnt := AnsiPos('SizeC>', XMLstr);
    if (StrPosCnt <> 0) then begin // if 'SizeC' was found
    Ach := #0;
    i := StrPosCnt + Length('SizeC>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    NrChannels := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeC>'), i-(StrPosCnt + Length('SizeC>'))));
    end
    else NrChannels := 1; //force to if not found; so far it is present in all files

    StrPosCnt := AnsiPos('SizeZ>', XMLstr);
    if (StrPosCnt <> 0) then begin // if 'SizeZ' was found
      {in Time Series SizeZ = 0, or SizeZ is Missing !!!
       if SizeZ is found then is EQ Zero and 'Distance Id="Z"' = 1
       if SizeZ is Not found then 'Distance Id="Z"' = 0 }
      Ach := #0;
      i := StrPosCnt + Length('SizeZ>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;
      SizeZ := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeZ>'), i-(StrPosCnt + Length('SizeZ>'))));
    end
    else SizeZ := 1; //force SizeZ = 1 if not found

    If (SizeZ = 1) then Begin
      // in Z stack SizeT is missing
      StrPosCnt := AnsiPos('SizeT>', XMLstr);
      Ach := #0;
      i := StrPosCnt + Length('SizeT>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;
      SizeT := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeT>'), i-(StrPosCnt + Length('SizeT>'))));
      if (imYsize = 1) then begin
        MovieSeriesType := LineScan;
        imYsize := SizeT;
        NrIm := 1;
      end
        else
      begin
        MovieSeriesType := TimeSeries;
        NrIm := SizeT;
      end;
      SetLength(ImOff,NrChannels,NrIm);
    End

        else

    If (SizeZ > 1) then Begin
      NrIm := SizeZ;
      SetLength(ImOff,NrChannels,NrIm);
      MovieSeriesType := Z_Stack;
    End;

    StrPosCnt := AnsiPos('BitsPerSample>', XMLstr);
    //ComponentBitCount gives the same info
    Ach := #0;
    i := StrPosCnt + Length('BitsPerSample>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    BitDepth := StrToInt(Copy(XMLstr, StrPosCnt + Length('BitsPerSample>'), i-(StrPosCnt + Length('BitsPerSample>'))));

    shrFact := BitDepth - 8;
    {if image is 8 bit BitDepth  it is EQ to 8
    if image is 16 bit then BitDepth can be EQ 12}

    StrPosCnt := AnsiPos('PixelType>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('PixelType>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    BitsPerPixelStr := Copy(XMLstr, StrPosCnt + Length('PixelType>'), i-(StrPosCnt + Length('PixelType>')));
    if (BitsPerPixelStr = 'Gray8')  then BitCount := 8  // Gray8 = 8 bit unsigned.
      else
    if (BitsPerPixelStr = 'Gray16')  then BitCount := 16;  // Gray16 = 16 bit unsigned.
    {Values: Gray8, Gray16, Bgr24, Bgra32, Gray32Float, Bgr48, Bgr96Float,
             Gray64ComplexFloat, Gray32Float, Bgr192ComplexFloat. }

    StrPosCnt := AnsiPos('ZoomX>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('ZoomX>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.Optical_Zoom := StrToFloat((Copy(XMLstr, StrPosCnt + Length('ZoomX>'), i-(StrPosCnt + Length('ZoomX>')))));

    StrPosCnt := AnsiPos('Distance Id="X"', XMLstr); //this is Pixel Size in meters
    {Distance between Distance Id="X">. and the Value Varies.  That's why we 1st find
    Pos of Distance Id="X", then the pos of <Value> and then the Value.
    Position of "<Value>" and numerical value is constant: "<Value>1.8450351646662112e-007</Value"}
    Ach := #0;
    i := StrPosCnt + 17; //Distance Id="X">. = 17 letters
    while (Ach <> 'V') do begin
      Ach := XMLstr[i];
      if (Ach = 'V') then begin
        StrPosCnt := i;
        Break;
      end;
      Inc(i);
    end;
    i := StrPosCnt + 6;  //Value> = 6 letters
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    PixSettings.FilePixSize := (StrToFloat(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6))))*1E6;  //convert meters to microns
    PixSettings.FileHasOwnPixSize := True;

    If (MovieSeriesType = Z_Stack) Then Begin
    StrPosCnt := AnsiPos('Distance Id="Z"', XMLstr); //this is Z step in meters
      // Zstep : Double; //the Z step in µm
      // in Time Series Distance Id="Z">0<Value> EQ 0}
      {Distance between Distance Id="X">. and the Value Varies.  That's why we 1st find
      Pos of Distance Id="X", then the pos of <Value> and then the Value.
      Position of "<Value>" and numerical value is constant: "<Value>1.8450351646662112e-007</Value"}
    Ach := #0;
    i := StrPosCnt + 17; //Distance Id="Z">. = 17 letters
    while (Ach <> 'V') do begin
      Ach := XMLstr[i];
      if (Ach = 'V') then begin
        StrPosCnt := i;
        Break;
      end;
      Inc(i);
    end;
    i := StrPosCnt + 6;  //Value> = 6 letters
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
      Zstep := (StrToFloat(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6))))*1E6;  //convert meters to microns
    End; //If (AndorBioradZeissSeriesType = Z_Stack)

    StrPosCnt := AnsiPos('PixelPeriod>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('PixelPeriod>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.PixDwell :=
    Round((StrToFloat(Copy(XMLstr, StrPosCnt + Length('PixelPeriod>'), i-(StrPosCnt + Length('PixelPeriod>')))))*1E9); //convert sec to µs
    ScopeSystemParams.PixDwell_Units := 'ns';

    StrPosCnt := AnsiPos('<Color>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('<Color>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    TemStr := Copy(XMLstr, StrPosCnt + Length('<Color>')+1, i-(StrPosCnt + Length('<Color>'))-1);
    //start +1 and length -1 to avoid getting '#' in the string like #FF0000 = red color.
    //With this correction it will be: FF0000
    AnsiCharArr[0] := '$';
    //get Red Color value = convert HEX Text String to decimal Byte Value
    AnsiCharArr[1] := TemStr[1];
    AnsiCharArr[2] := TemStr[2];
    R := StrToInt(AnsiCharArr);

     //get Green Color value
    AnsiCharArr[1] := TemStr[3];
    AnsiCharArr[2] := TemStr[4];
    G := StrToInt(AnsiCharArr);

     //get Blue Color value
    AnsiCharArr[1] := TemStr[5];
    AnsiCharArr[2] := TemStr[6];
    B := StrToInt(AnsiCharArr);

    //Enable FileColTable
    frmImageControl.ubFileColTable.Tag := NrChannels;

      if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
      if (R > 0) then begin
        ColDec := R/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch1[i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch1[i] := 0;

      if (G > 0) then begin
        ColDec := G/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch1[256+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch1[256+i] := 0;

      if (B > 0) then begin
        ColDec := B/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch1[512+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
        FileColorTBL_Ch1[512+i] := 0;

    If (NrChannels = 2) then Begin
    //Get Channel Color and Generate Color tables

      i := StrPosCnt + Length('<Color>');  //get the 2nd position of <Color>
      while (TemStr <> '<Color>') and (i < High(XMLstr)) do begin
        if (Length(TemStr) <> 7) then SetLength(TemStr,7);
        TemStr := copy (XMLstr, i, 7 );
        if (TemStr = '<Color>') then begin
          StrPosCnt := i;
          Break;
        end;
        Inc(i);
      end;

      Ach := #0;
      i := StrPosCnt + Length('<Color>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;

      TemStr := Copy(XMLstr, StrPosCnt + Length('<Color>')+1, i-(StrPosCnt + Length('<Color>'))-1);

      AnsiCharArr[0] := '$';
      //get Red Color value = convert HEX Text String to decimal Byte Value
      AnsiCharArr[1] := TemStr[1];
      AnsiCharArr[2] := TemStr[2];
      R := StrToInt(AnsiCharArr);

       //get Green Color value
      AnsiCharArr[1] := TemStr[3];
      AnsiCharArr[2] := TemStr[4];
      G := StrToInt(AnsiCharArr);

       //get Blue Color value
      AnsiCharArr[1] := TemStr[5];
      AnsiCharArr[2] := TemStr[6];
      B := StrToInt(AnsiCharArr);

      if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
      if (R > 0) then begin
        ColDec := R/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch2[i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch2[i] := 0;

      if (G > 0) then begin
        ColDec := G/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch2[256+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch2[256+i] := 0;

      if (B > 0) then begin
        ColDec := B/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch2[512+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
        FileColorTBL_Ch2[512+i] := 0;

    End;  //If (NrChannels = 2) then Begin
    //-- End of Getting Channel Colors and Generating Color Tables -------------//

    //get channel names
    StrPosCnt := AnsiPos('Name=', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('Name=');
    while (Ach <> '>') do begin
      Ach := XMLstr[i];
      if (Ach = '>') then Break;
      Inc(i);
    end;
    ScopeSystemParams.Ch1_Name := Copy(XMLstr, StrPosCnt + Length('Name=')+1,  i-(StrPosCnt + Length('Name='))-2);

    If (NrChannels = 2) then Begin
    //Get Channel Color and Generate Color tables

      i := StrPosCnt + Length('Name=');  //get the 2nd position of Name
      while (TemStr <> 'Name=') and (i < High(XMLstr)) do begin
        if (Length(TemStr) <> 5) then SetLength(TemStr,5);
        TemStr := copy (XMLstr, i, 5 );
        if (TemStr = 'Name=') then begin
          StrPosCnt := i;
          Break;
        end;
        Inc(i);
      end;

      Ach := #0;
      i := StrPosCnt + Length('Name=');
      while (Ach <> '>') do begin
        Ach := XMLstr[i];
        if (Ach = '>') then Break;
        Inc(i);
      end;

      ScopeSystemParams.Ch2_Name := Copy(XMLstr, StrPosCnt + Length('Name=')+1,  i-(StrPosCnt + Length('Name='))-2);
    End; //Getting Channel names

    StrPosCnt := AnsiPos('<Objective>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('<Objective>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.ObjectiveName := Copy(XMLstr, StrPosCnt + Length('<Objective>'), i-(StrPosCnt + Length('<Objective>')));

    StrPosCnt := AnsiPos('NominalMagnification>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('NominalMagnification>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.Objective_Mag :=
    (StrToInt(Copy(XMLstr, StrPosCnt + Length('NominalMagnification>'), i-(StrPosCnt + Length('NominalMagnification>'))))); //convert sec to µs

    StrPosCnt := PosEx('<DigitalOffset>', XMLstr,1);
    if (StrPosCnt > 0) then begin
      Ach := #0;
      i := StrPosCnt + Length('<DigitalOffset>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;
      ScopeSystemParams.DigitalOffsetCh1 :=
      (StrToFloat(Copy(XMLstr, StrPosCnt + Length('<DigitalOffset>'), i-(StrPosCnt + Length('<DigitalOffset>')))));

      if (NrChannels = 2) then begin
        StrPosCnt := PosEx('<DigitalOffset>', XMLstr, StrPosCnt + Length('<DigitalOffset>'));
        if (StrPosCnt > 0) then begin
          Ach := #0;
          i := StrPosCnt + Length('<DigitalOffset>');
          while (Ach <> '<') do begin
            Ach := XMLstr[i];
            if (Ach = '<') then Break;
            Inc(i);
          end;
          ScopeSystemParams.DigitalOffsetCh2 :=
          (StrToFloat(Copy(XMLstr, StrPosCnt + Length('<DigitalOffset>'), i-(StrPosCnt + Length('<DigitalOffset>')))));
        end;//if (StrPosCnt > 0)
      end; //if (NrChannels = 2) then begin
    end; //if (StrPosCnt > 0) then begin


 //---------------------------------------------//

  NrOffs := NrChannels*NrIm - 1;
  if (NrChannels = 1) then ChNr := 0;

  For i  := 0 to NrOffs do Begin

    //----------------------- Progress Barr -------------------------------//
    If (i = 0) then Begin
    if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.Show;
     end;
     frmProgress.ImageProgressBar.Max := NrIm;
     if (NrChannels = 1) then
      frmProgress.lbProgress.Caption := IntToStr(i) + ' (' + IntToStr(NrIm) + ')'
      else
     if (NrChannels > 1) then
      frmProgress.lbProgress.Caption := IntToStr(i shr 1 + 1) + ' (' + IntToStr(NrIm) + ')';
      Application.ProcessMessages;
    End; // If (GetAllPages) and (PageCnt = 0)

    if (frmProgress = nil) then begin
      Application.CreateForm(TfrmProgress, frmProgress);
      frmProgress.Show;
      frmProgress.ImageProgressBar.Max := NrIm;
    end;
    if (NrChannels = 1) then begin
      frmProgress.lbProgress.Caption := IntToStr(i) + ' (' + IntToStr(NrIm) + ')';
      frmProgress.ImageProgressBar.Position := i;
    end
      else
    if (NrChannels > 1) then begin
      frmProgress.lbProgress.Caption := IntToStr(i shr 1 + 1) + ' (' + IntToStr(NrIm) + ')';
      frmProgress.ImageProgressBar.Position := i shr 1;
    end;
    Application.ProcessMessages;

    //---------------------------- End of Progress Barr ----------------------//

    OffsetTo_Previous_ZISRAWSUBBLOCK := OffsetTo_ZISRAWSUBBLOCK;
    FPos := OffsetTo_ZISRAWSUBBLOCK + SizeOfSegmentHeaderID;
    Move(pRawData[FPos],AllocatedSize, SizeOf(Int64));
    OffsetTo_ZISRAWSUBBLOCK_Data := OffsetTo_ZISRAWSUBBLOCK + SegmentHeaderSize;
  //Starts Reading the SubBlockSegment
    FPos := OffsetTo_ZISRAWSUBBLOCK_Data;
    Move(pRawData[FPos],MetadataSize, SizeOf(MetadataSize));
    if (NrChannels = 1) then begin
      ImOff[ChNr,i] := OffsetTo_ZISRAWSUBBLOCK_Data + 256 + MetadataSize;
    end
      else
    if (NrChannels > 1) then begin
      ChNr := i mod 2;
      ImOff[ChNr,i shr 1] := OffsetTo_ZISRAWSUBBLOCK_Data + 256 + MetadataSize;
    end;
    OffsetTo_ZISRAWSUBBLOCK := OffsetTo_Previous_ZISRAWSUBBLOCK + AllocatedSize + SegmentHeaderSize;
  End; //For ImCnt  := 0 to NrIm-1 do Begin

  if (frmProgress <> nil) then frmProgress.Close;

  If (SizeZ = 1) then Begin //Time Series
    FPos := OffsetTo_ZISRAWATTDIR_Data;
    ZISRAWATTDIR_EntryCount := pRawData[FPos];
    For i := 0 to ZISRAWATTDIR_EntryCount-1 Do begin
      FPos := OffsetTo_ZISRAWATTDIR_Data + 256 + i*128;
      Move(pRawData[FPos],AttachmentEntrySchemaA1, SizeOf(AttachmentEntrySchemaA1));
      pAnsiChr := @AttachmentEntrySchemaA1.Name[0];

      if (AnsiString(pAnsiChr) = 'TimeStamps') then begin
        //AttachmentEntrySchemaA1.Name also does the job. I did these castings just to be sure
        FPos := AttachmentEntrySchemaA1.FilePosition;  //gives the beginnig of  ZISRAWATTACH
        OffsetTo_TimeStamps := AttachmentEntrySchemaA1.FilePosition + 296;
        Break;
      end;

    End; //For Cnt := 0 to ZISRAWATTDIR_EntryCount-1 Do begin

  End; //If (SizeZ = 1) then Begin //Time Series

   if (MovieSeriesType = LineScan) then
    SetLength(TimeSt,imYsize) else
    SetLength(TimeSt,NrIm);
   {Since all the Channels are Aquired Simultaneously Time Stamps are EQ Number of Images div NrChannels}
   If (SizeZ = 1) then Begin
    FPos := OffsetTo_TimeStamps;
    Pt := @TimeSt[0];
    if (MovieSeriesType = LineScan) then
      Move(pRawData[FPos],Pt^, imYSize*SizeOf(Double)) else
      Move(pRawData[FPos],Pt^, NrIm*SizeOf(Double));

    for i := 1 to High(TimeSt) do TimeSt[i] := TimeSt[i] - TimeSt[0];
    TimeSt[0] := 0;
   End
    Else
   If (SizeZ > 1) then Begin
    for i := 0 to High(TimeSt) do  TimeSt[i] := i*Zstep;
   End;

   ImagePix := imXsize * imYsize;
   ToSwap   := False;

   {Andor & Biorad Zstack Files Have always Time Stamps.  That's why Z data
    is saved to ZstackArr.  Zeiss Zstack files have Only (µm).
    To avoid Compications with the Plot Routines That always expect Time Stamps
    the Z data are saved in the TimeSt array}

End; //Procedure GetCZIfileInfoFromRAM

{**************************************************************************** }

Procedure GetCZIfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);

Type
TAttachmentEntrySchemaA1 = Packed Record //size 128 bytes
  SchemaType   : Array[0..1] of AnsiChar; //Offset = 0;  = "A1";
  Reserved 	   : Array[0..9] of Byte; 	//Offset = 2
  FilePosition :	Int64; // Offset =  12; Seek offset relative to the first byte of the file;
  FilePart 	   : Integer; // / Offset =  20
  ContentGuid  : TGUID; //Offset = 24, Size =	16; 	Unique Id to be used in strong, fully qualified references
  ContentFileType : Array[0..7] of AnsiChar;	//Offset = 40 	//Unique file type Identifier (see table below)
  Name 	       : Array[0..79] of AnsiChar; //Offset = 48; Size = 80;
end;

Const SegmentHeaderSize     = 32;  //bytes
      SizeOfSegmentHeaderID = 16; //bytes

var  CZIFile                          : THandle;
     Ach                              : AnsiChar;
     BitsPerPixelStr                  : AnsiString;
     pT                               : Pointer;
     i, StrPosCnt,NrOffs,ChNr         : Integer;
     BitDepth                         : LongWord;
     NextZISRAWSUBBLOCKpos            : Int64;
     pAnsiChr                         : pAnsiChar;
     R,G,B                            : Byte;
     ColDec                           : Double;
     AnsiCharArr                      : Array[0..2] of AnsiChar;
     TemStr                           : AnsiString;
     Sender                           : TObject;
     // Zeiss Variables
     MetadataSize                     : Integer;
     FPos                             : Int64;
     AttachmentDirectoryPosition      : Int64;
     XmlSize,AttachmentSize           : Integer;
     SizeZ                            : Integer; //number of images in Zstack. If > 0 then SizeT Number of timepoints (imageas) = 1
     SizeT                            : Integer; // Number of timepoints. (images in Time Series)
     Zstep                            : Double; //the Z step in meters (I convert to µm)
     AttachmentEntrySchemaA1          : TAttachmentEntrySchemaA1; // size 128 bytes
     XMLstr                           : AnsiString;
     DistanceId_Z                     : Double;
     AllocatedSize,UsedSize           : Int64;
     ZISRAWATTACH_DataSize            : Integer;
     ZISRAWATTDIR_EntryCount          : Integer;
     OffsetTo_ZISRAWFILE_Data         : Int64;
     OffsetTo_ZISRAWATTDIR_Data       : Int64;
     OffsetTo_ZISRAWSUBBLOCK          : Int64;
     OffsetTo_ZISRAWSUBBLOCK_Data     : Int64;
     OffsetTo_Previous_ZISRAWSUBBLOCK : Int64;
     OffsetTo_ZISRAWMETADATA          : Int64;
     OffsetTo_ZISRAWMETADATA_Data     : Int64;
     OffsetTo_ZISRAWMETADATA_XmlStr   : Int64;
     OffsetTo_TimeStamps              : Int64;

Begin



  CZIFile := FileOpen(FName,fmOpenRead or fmShareDenyNone);

  FPos := SizeOfSegmentHeaderID;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, AllocatedSize, SizeOf(Int64));

  OffsetTo_ZISRAWSUBBLOCK := SegmentHeaderSize + AllocatedSize;
  {Offset to the 1st ZISRAWSUBBLOCK is always the same = 512 + 32 = 544}

  //Read Segment Data//
  OffsetTo_ZISRAWFILE_Data := SegmentHeaderSize;

  FPos := OffsetTo_ZISRAWFILE_Data + 60;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, OffsetTo_ZISRAWMETADATA, SizeOf(OffsetTo_ZISRAWMETADATA));

  FPos := OffsetTo_ZISRAWFILE_Data + 72;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, AttachmentDirectoryPosition, SizeOf(AttachmentDirectoryPosition));

  //Read Directly ZISRAWATTDIR Segment Data//
  OffsetTo_ZISRAWATTDIR_Data := AttachmentDirectoryPosition + SegmentHeaderSize;
  OffsetTo_ZISRAWMETADATA_Data := OffsetTo_ZISRAWMETADATA + SegmentHeaderSize;

  FPos := OffsetTo_ZISRAWMETADATA_Data;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, XmlSize, SizeOf(XmlSize));

  OffsetTo_ZISRAWMETADATA_XmlStr := OffsetTo_ZISRAWMETADATA_Data + 256;

  SetLength(XMLstr,XmlSize);
  FPos := OffsetTo_ZISRAWMETADATA_XmlStr;
  FileSeek(CZIFile, FPos, 0);
  pT := @XMLstr[1];
  FileRead(CZIFile, pT^, XmlSize);

    StrPosCnt := AnsiPos('SizeX>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('SizeX>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    imXsize := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeX>'), i-(StrPosCnt + Length('SizeX>'))));

    StrPosCnt := AnsiPos('SizeY>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('SizeY>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    imYsize := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeY>'), i-(StrPosCnt + Length('SizeY>'))));

    StrPosCnt := AnsiPos('SizeC>', XMLstr);
    if (StrPosCnt <> 0) then begin // if 'SizeC' was found
    Ach := #0;
    i := StrPosCnt + Length('SizeC>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    NrChannels := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeC>'), i-(StrPosCnt + Length('SizeC>'))));
    end
    else NrChannels := 1; //force to if not found; so far it is present in all files

    StrPosCnt := AnsiPos('SizeZ>', XMLstr);
    if (StrPosCnt <> 0) then begin // if 'SizeZ' was found
      {in Time Series SizeZ = 0, or SizeZ is Missing !!!
       if SizeZ is found then is EQ Zero and 'Distance Id="Z"' = 1
       if SizeZ is Not found then 'Distance Id="Z"' = 0 }
      Ach := #0;
      i := StrPosCnt + Length('SizeZ>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;
      SizeZ := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeZ>'), i-(StrPosCnt + Length('SizeZ>'))));
    end
    else SizeZ := 1; //force SizeZ = 1 if not found

    If (SizeZ = 1) then Begin
      // in Z stack SizeT is missing
      StrPosCnt := AnsiPos('SizeT>', XMLstr);
      Ach := #0;
      i := StrPosCnt + Length('SizeT>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;
      SizeT := StrToInt(Copy(XMLstr, StrPosCnt + Length('SizeT>'), i-(StrPosCnt + Length('SizeT>'))));
      if (imYsize = 1) then begin
        MovieSeriesType := LineScan;
        imYsize := SizeT;
        NrIm := 1;
      end
        else
      begin
        MovieSeriesType := TimeSeries;
        NrIm := SizeT;
      end;
      SetLength(ImOff,NrChannels,NrIm);
    End

      else

    If (SizeZ > 1) then Begin
      NrIm := SizeZ;
      SetLength(ImOff,NrChannels,NrIm);
      MovieSeriesType := Z_Stack;
    End;

    StrPosCnt := AnsiPos('BitsPerSample>', XMLstr);
    //ComponentBitCount gives the same info
    Ach := #0;
    i := StrPosCnt + Length('BitsPerSample>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    BitDepth := StrToInt(Copy(XMLstr, StrPosCnt + Length('BitsPerSample>'), i-(StrPosCnt + Length('BitsPerSample>'))));
    shrFact := BitDepth - 8;
    {if image is 8 bit BitDepth  it is EQ to 8
    if image is 16 bit then BitDepth can be EQ 12}

    StrPosCnt := AnsiPos('PixelType>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('PixelType>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    BitsPerPixelStr := Copy(XMLstr, StrPosCnt + Length('PixelType>'), i-(StrPosCnt + Length('PixelType>')));
    if (BitsPerPixelStr = 'Gray8')  then BitCount := 8  // Gray8 = 8 bit unsigned.
      else
    if (BitsPerPixelStr = 'Gray16')  then BitCount := 16;  // Gray16 = 16 bit unsigned.
    {Values: Gray8, Gray16, Bgr24, Bgra32, Gray32Float, Bgr48, Bgr96Float,
             Gray64ComplexFloat, Gray32Float, Bgr192ComplexFloat. }

    StrPosCnt := AnsiPos('ZoomX>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('ZoomX>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.Optical_Zoom := StrToFloat((Copy(XMLstr, StrPosCnt + Length('ZoomX>'), i-(StrPosCnt + Length('ZoomX>')))));

    StrPosCnt := AnsiPos('Distance Id="X"', XMLstr); //this is Pixel Size in meters
    {Distance between Distance Id="X">. and the Value Varies.  That's why we 1st find
    Pos of Distance Id="X", then the pos of <Value> and then the Value.
    Position of "<Value>" and numerical value is constant: "<Value>1.8450351646662112e-007</Value"}
    Ach := #0;
    i := StrPosCnt + 17; //Distance Id="X">. = 17 letters
    while (Ach <> 'V') do begin
      Ach := XMLstr[i];
      if (Ach = 'V') then begin
        StrPosCnt := i;
        Break;
      end;
      Inc(i);
    end;
    i := StrPosCnt + 6;  //Value> = 6 letters
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    PixSettings.FilePixSize := (StrToFloat(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6))))*1E6;  //convert meters to microns
    PixSettings.FileHasOwnPixSize := True;

    If (MovieSeriesType = Z_Stack) Then Begin
    StrPosCnt := AnsiPos('Distance Id="Z"', XMLstr); //this is Z step in meters
      // Zstep : Double; //the Z step in µm
      // in Time Series Distance Id="Z">0<Value> EQ 0}
      {Distance between Distance Id="X">. and the Value Varies.  That's why we 1st find
      Pos of Distance Id="X", then the pos of <Value> and then the Value.
      Position of "<Value>" and numerical value is constant: "<Value>1.8450351646662112e-007</Value"}
    Ach := #0;
    i := StrPosCnt + 17; //Distance Id="Z">. = 17 letters
    while (Ach <> 'V') do begin
      Ach := XMLstr[i];
      if (Ach = 'V') then begin
        StrPosCnt := i;
        Break;
      end;
      Inc(i);
    end;
    i := StrPosCnt + 6;  //Value> = 6 letters
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
      Zstep := (StrToFloat(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6))))*1E6;  //convert meters to microns
    End; //If (AndorBioradZeissSeriesType = Z_Stack)

    StrPosCnt := AnsiPos('PixelPeriod>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('PixelPeriod>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.PixDwell :=
    Round((StrToFloat(Copy(XMLstr, StrPosCnt + Length('PixelPeriod>'), i-(StrPosCnt + Length('PixelPeriod>')))))*1E9); //convert sec to µs
    ScopeSystemParams.PixDwell_Units := 'ns';

    StrPosCnt := AnsiPos('<Color>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('<Color>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    TemStr := Copy(XMLstr, StrPosCnt + Length('<Color>')+1, i-(StrPosCnt + Length('<Color>'))-1);
    //start +1 and length -1 to avoid getting '#' in the string like #FF0000 = red color.
    //With this correction it will be: FF0000
    AnsiCharArr[0] := '$';
    //get Red Color value = convert HEX Text String to decimal Byte Value
    AnsiCharArr[1] := TemStr[1];
    AnsiCharArr[2] := TemStr[2];
    R := StrToInt(AnsiCharArr);

     //get Green Color value
    AnsiCharArr[1] := TemStr[3];
    AnsiCharArr[2] := TemStr[4];
    G := StrToInt(AnsiCharArr);

     //get Blue Color value
    AnsiCharArr[1] := TemStr[5];
    AnsiCharArr[2] := TemStr[6];
    B := StrToInt(AnsiCharArr);

    //Enable FileColTable
    frmImageControl.ubFileColTable.Tag := NrChannels;

      if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
      if (R > 0) then begin
        ColDec := R/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch1[i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch1[i] := 0;

      if (G > 0) then begin
        ColDec := G/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch1[256+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch1[256+i] := 0;

      if (B > 0) then begin
        ColDec := B/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch1[512+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
        FileColorTBL_Ch1[512+i] := 0;

    If (NrChannels = 2) then Begin
    //Get Channel Color and Generate Color tables

      i := StrPosCnt + Length('<Color>');  //get the 2nd position of <Color>
      while (TemStr <> '<Color>') and (i < High(XMLstr)) do begin
        if (Length(TemStr) <> 7) then SetLength(TemStr,7);
        TemStr := copy (XMLstr, i, 7 );
        if (TemStr = '<Color>') then begin
          StrPosCnt := i;
          Break;
        end;
        Inc(i);
      end;

      Ach := #0;
      i := StrPosCnt + Length('<Color>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;

      TemStr := Copy(XMLstr, StrPosCnt + Length('<Color>')+1, i-(StrPosCnt + Length('<Color>'))-1);

      AnsiCharArr[0] := '$';
      //get Red Color value = convert HEX Text String to decimal Byte Value
      AnsiCharArr[1] := TemStr[1];
      AnsiCharArr[2] := TemStr[2];
      R := StrToInt(AnsiCharArr);

       //get Green Color value
      AnsiCharArr[1] := TemStr[3];
      AnsiCharArr[2] := TemStr[4];
      G := StrToInt(AnsiCharArr);

       //get Blue Color value
      AnsiCharArr[1] := TemStr[5];
      AnsiCharArr[2] := TemStr[6];
      B := StrToInt(AnsiCharArr);

      if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
      if (R > 0) then begin
        ColDec := R/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch2[i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch2[i] := 0;

      if (G > 0) then begin
        ColDec := G/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch2[256+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
          FileColorTBL_Ch2[256+i] := 0;

      if (B > 0) then begin
        ColDec := B/255;
        for i := 0 to 255 do begin
          FileColorTBL_Ch2[512+i] := round(ColDec*i);
        end;
      end
        else
      for i := 0 to 255 do
        FileColorTBL_Ch2[512+i] := 0;

    End;  //If (NrChannels = 2) then Begin
    //-- End of Getting Channel Colors and Generating Color Tables -------------//

    //get channel names
    StrPosCnt := AnsiPos('Name=', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('Name=');
    while (Ach <> '>') do begin
      Ach := XMLstr[i];
      if (Ach = '>') then Break;
      Inc(i);
    end;
    ScopeSystemParams.Ch1_Name := Copy(XMLstr, StrPosCnt + Length('Name=')+1,  i-(StrPosCnt + Length('Name='))-2);

    If (NrChannels = 2) then Begin
    //Get Channel Color and Generate Color tables

      i := StrPosCnt + Length('Name=');  //get the 2nd position of Name
      while (TemStr <> 'Name=') and (i < High(XMLstr)) do begin
        if (Length(TemStr) <> 5) then SetLength(TemStr,5);
        TemStr := copy (XMLstr, i, 5 );
        if (TemStr = 'Name=') then begin
          StrPosCnt := i;
          Break;
        end;
        Inc(i);
      end;

      Ach := #0;
      i := StrPosCnt + Length('Name=');
      while (Ach <> '>') do begin
        Ach := XMLstr[i];
        if (Ach = '>') then Break;
        Inc(i);
      end;
      ScopeSystemParams.Ch2_Name := Copy(XMLstr, StrPosCnt + Length('Name=')+1,  i-(StrPosCnt + Length('Name='))-2);
    End; //Get Channel Names

    StrPosCnt := AnsiPos('<Objective>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('<Objective>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.ObjectiveName := Copy(XMLstr, StrPosCnt + Length('<Objective>'), i-(StrPosCnt + Length('<Objective>')));

    StrPosCnt := AnsiPos('NominalMagnification>', XMLstr);
    Ach := #0;
    i := StrPosCnt + Length('NominalMagnification>');
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    ScopeSystemParams.Objective_Mag :=
    (StrToInt(Copy(XMLstr, StrPosCnt + Length('NominalMagnification>'), i-(StrPosCnt + Length('NominalMagnification>'))))); //convert sec to µs

    StrPosCnt := PosEx('<DigitalOffset>', XMLstr,1);
    if (StrPosCnt > 0) then begin
      Ach := #0;
      i := StrPosCnt + Length('<DigitalOffset>');
      while (Ach <> '<') do begin
        Ach := XMLstr[i];
        if (Ach = '<') then Break;
        Inc(i);
      end;
      ScopeSystemParams.DigitalOffsetCh1 :=
      (StrToFloat(Copy(XMLstr, StrPosCnt + Length('<DigitalOffset>'), i-(StrPosCnt + Length('<DigitalOffset>')))));

      if (NrChannels = 2) then begin
        StrPosCnt := PosEx('<DigitalOffset>', XMLstr, StrPosCnt + Length('<DigitalOffset>'));
        if (StrPosCnt > 0) then begin
          Ach := #0;
          i := StrPosCnt + Length('<DigitalOffset>');
          while (Ach <> '<') do begin
            Ach := XMLstr[i];
            if (Ach = '<') then Break;
            Inc(i);
          end;
          ScopeSystemParams.DigitalOffsetCh2 :=
          (StrToFloat(Copy(XMLstr, StrPosCnt + Length('<DigitalOffset>'), i-(StrPosCnt + Length('<DigitalOffset>')))));
        end;//if (StrPosCnt > 0)
      end; //if (NrChannels = 2) then begin
    end; //if (StrPosCnt > 0) then begin

  NrOffs := NrChannels*NrIm - 1;
  if (NrChannels = 1) then ChNr := 0;

  For i  := 0 to NrOffs do Begin

    //----------------------- Progress Barr -------------------------------//
    If (i = 0) then Begin
    if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.Show;
     end;
     frmProgress.ImageProgressBar.Max := NrIm;
     if (NrChannels = 1) then
      frmProgress.lbProgress.Caption := IntToStr(i) + ' (' + IntToStr(NrIm) + ')'
      else
     if (NrChannels > 1) then
      frmProgress.lbProgress.Caption := IntToStr(i shr 1 + 1) + ' (' + IntToStr(NrIm) + ')';
      Application.ProcessMessages;
    End; // If (GetAllPages) and (PageCnt = 0)

    if (frmProgress = nil) then begin
      Application.CreateForm(TfrmProgress, frmProgress);
      frmProgress.Show;
      frmProgress.ImageProgressBar.Max := NrIm;
    end;
    if (NrChannels = 1) then begin
      frmProgress.lbProgress.Caption := IntToStr(i) + ' (' + IntToStr(NrIm) + ')';
      frmProgress.ImageProgressBar.Position := i;
    end
      else
    if (NrChannels > 1) then begin
      frmProgress.lbProgress.Caption := IntToStr(i shr 1 + 1) + ' (' + IntToStr(NrIm) + ')';
      frmProgress.ImageProgressBar.Position := i shr 1;
    end;
    Application.ProcessMessages;

    //---------------------------- End of Progress Barr ----------------------//

    OffsetTo_Previous_ZISRAWSUBBLOCK := OffsetTo_ZISRAWSUBBLOCK;
    FPos := OffsetTo_ZISRAWSUBBLOCK + SizeOfSegmentHeaderID;
    FileSeek(CZIFile, FPos, 0);
    FileRead(CZIFile, AllocatedSize, SizeOf(Int64));
    OffsetTo_ZISRAWSUBBLOCK_Data := OffsetTo_ZISRAWSUBBLOCK + SegmentHeaderSize;
  //Starts Reading the SubBlockSegment
    FPos := OffsetTo_ZISRAWSUBBLOCK_Data;
    FileSeek(CZIFile, FPos, 0);
    FileRead(CZIFile, MetadataSize, SizeOf(MetadataSize));
    if (NrChannels = 1) then begin
      ImOff[ChNr,i] := OffsetTo_ZISRAWSUBBLOCK_Data + 256 + MetadataSize;
    end
      else
    if (NrChannels > 1) then begin
      ChNr := i mod 2;
      ImOff[ChNr,i shr 1] := OffsetTo_ZISRAWSUBBLOCK_Data + 256 + MetadataSize;
    end;
    OffsetTo_ZISRAWSUBBLOCK := OffsetTo_Previous_ZISRAWSUBBLOCK + AllocatedSize + SegmentHeaderSize;
  End; //For ImCnt  := 0 to NrIm-1 do Begin

  if (frmProgress <> nil) then frmProgress.Close;

  If (SizeZ = 1) then Begin //Time Series
    FPos := OffsetTo_ZISRAWATTDIR_Data;
    FileSeek(CZIFile, FPos, 0);
    FileRead(CZIFile, ZISRAWATTDIR_EntryCount, SizeOf(ZISRAWATTDIR_EntryCount));

    For i := 0 to ZISRAWATTDIR_EntryCount-1 Do begin
      FPos := OffsetTo_ZISRAWATTDIR_Data + 256 + i*128;
      FileSeek(CZIFile, FPos, 0);
      FileRead(CZIFile, AttachmentEntrySchemaA1, SizeOf(AttachmentEntrySchemaA1));
      pAnsiChr := @AttachmentEntrySchemaA1.Name[0];
      if (AnsiString(pAnsiChr) = 'TimeStamps') then begin
        //AttachmentEntrySchemaA1.Name also does the job. I did these castings just to be sure
        FPos := AttachmentEntrySchemaA1.FilePosition;  //gives the beginnig of  ZISRAWATTACH
        OffsetTo_TimeStamps := AttachmentEntrySchemaA1.FilePosition + 296;
        Break;
      end;
    End; //For Cnt := 0 to ZISRAWATTDIR_EntryCount-1 Do begin

  End; //If (SizeZ = 1) then Begin //Time Series

   if (MovieSeriesType = LineScan) then
    SetLength(TimeSt,imYsize) else
    SetLength(TimeSt,NrIm);
   {Since all the Channels are Aquired Simultaneously Time Stamps are EQ Number of Images div NrChannels}
   If (SizeZ = 1) then Begin
    FPos := OffsetTo_TimeStamps;
    Pt := @TimeSt[0];
    FileSeek(CZIFile, FPos, 0);
    if (MovieSeriesType = LineScan) then
      FileRead(CZIFile, Pt^, imYSize*SizeOf(Double)) else
      FileRead(CZIFile, Pt^,    NrIm*SizeOf(Double));

    for i := 1 to High(TimeSt) do TimeSt[i] := TimeSt[i] - TimeSt[0];
    TimeSt[0] := 0;
   End
    Else
   If (SizeZ > 1) then Begin
    for i := 0 to High(TimeSt) do  TimeSt[i] := i*Zstep;
   End;

   ImagePix := imXsize * imYsize;
   ToSwap   := False;

   FileClose(CZIFile);

   {Andor & Biorad Zstack Files Have always Time Stamps.  That's why Z data
    is saved to ZstackArr.  Zeiss Zstack files have Only (µm).
    To avoid Compications with the Plot Routines That always expect Time Stamps
    the Z data are saved in the TimeSt array}

End; //Procedure GetCZIfileInfo

{**************************************************************************** }

Procedure GetCZIfile_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                             var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                             var DynWarr: TDynWordArray; Var ValidFile: Boolean);

Const SegmentHeaderSize     = 32;  //bytes
      SizeOfSegmentHeaderID = 16; //bytes

var  CZIFile                          : THandle;
     Ach                              : AnsiChar;
     pT                               : Pointer;
     i, StrPosCnt, ImageByteCount     : Integer;
     NumberOfChannels                 : Integer;
     imXsize,imYsize                  : Integer;
     FPos                             : Int64;
     BitsPerPixelStr                  : AnsiString;
     // Zeiss Variables
     MetadataSize                     : Integer;
     AttachmentDirectoryPosition      : Int64;
     XmlSize                          : Integer;
     XMLstr                           : AnsiString;
     AllocatedSize                    : Int64;
     OffsetTo_ZISRAWFILE_Data         : Int64;
     OffsetTo_ZISRAWSUBBLOCK          : Int64;
     OffsetTo_ZISRAWSUBBLOCK_Data     : Int64;
     OffsetTo_ZISRAWMETADATA          : Int64;
     OffsetTo_ZISRAWMETADATA_Data     : Int64;
     OffsetTo_ZISRAWMETADATA_XmlStr   : Int64;

Begin

  ValidFile := False;

  CZIFile := FileOpen(FName,fmOpenRead or fmShareDenyNone);

  FPos := SizeOfSegmentHeaderID;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, AllocatedSize, SizeOf(Int64));

  OffsetTo_ZISRAWSUBBLOCK := SegmentHeaderSize + AllocatedSize;
  {Offset to the 1st ZISRAWSUBBLOCK is always the same = 512 + 32 = 544}

  //Read Segment Data//
  OffsetTo_ZISRAWFILE_Data := SegmentHeaderSize;

  FPos := OffsetTo_ZISRAWFILE_Data + 60;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, OffsetTo_ZISRAWMETADATA, SizeOf(OffsetTo_ZISRAWMETADATA));

  FPos := OffsetTo_ZISRAWFILE_Data + 72;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, AttachmentDirectoryPosition, SizeOf(AttachmentDirectoryPosition));
  {AttachmentDirectoryPosition varies.  It is counted from the Beginnig of File}

  OffsetTo_ZISRAWMETADATA_Data := OffsetTo_ZISRAWMETADATA + SegmentHeaderSize;

  FPos := OffsetTo_ZISRAWMETADATA_Data;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, XmlSize, SizeOf(XmlSize));

  OffsetTo_ZISRAWMETADATA_XmlStr := OffsetTo_ZISRAWMETADATA_Data + 256;

  SetLength(XMLstr,XmlSize);
  FPos := OffsetTo_ZISRAWMETADATA_XmlStr;
  FileSeek(CZIFile, FPos, 0);
  pT := @XMLstr[1];
  FileRead(CZIFile, pT^, XmlSize);

  StrPosCnt := AnsiPos('SizeX', XMLstr);
  Ach := #0;
  i := StrPosCnt + 6;
  while (Ach <> '<') do begin
    Ach := XMLstr[i];
    if (Ach = '<') then Break;
    Inc(i);
  end;
  ImageWidth := StrToInt(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6)));

  StrPosCnt := AnsiPos('SizeY', XMLstr);
  Ach := #0;
  i := StrPosCnt + 6;
  while (Ach <> '<') do begin
    Ach := XMLstr[i];
    if (Ach = '<') then Break;
    Inc(i);
  end;
  ImageHeight := StrToInt(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6)));

  StrPosCnt := AnsiPos('SizeC', XMLstr);
  if (StrPosCnt <> 0) then begin // if 'SizeC' was found
    Ach := #0;
    i := StrPosCnt + 6;
    while (Ach <> '<') do begin
      Ach := XMLstr[i];
      if (Ach = '<') then Break;
      Inc(i);
    end;
    NrChannels := StrToInt(Copy(XMLstr, StrPosCnt + 6, i-(StrPosCnt + 6)));
  end
    else NrChannels := 1; //force to if not found; so far it is present in all files
  if (NumberOfChannels <= 2) then begin
    ValidFile := True;
  end;

  StrPosCnt := AnsiPos('PixelType', XMLstr);
  Ach := #0;
  i := StrPosCnt + 10;
  while (Ach <> '<') do begin
    Ach := XMLstr[i];
    if (Ach = '<') then Break;
    Inc(i);
  end;
  BitsPerPixelStr := Copy(XMLstr, StrPosCnt + 10, i-(StrPosCnt + 10));
  if (BitsPerPixelStr = 'Gray8')  then BitsPerPixel := 8
    else
  if (BitsPerPixelStr = 'Gray16')  then BitsPerPixel := 16;
  if (BitsPerPixel in [8,16]) then ValidFile := True;


    {Values: Gray8, Gray16, Bgr24, Bgra32, Gray32Float, Bgr48, Bgr96Float,
             Gray64ComplexFloat, Gray32Float, Bgr192ComplexFloat.      }
 If (ValidFile) Then Begin

  If (BitsPerPixel = 16) Then Begin
    ImageByteCount := ImageWidth * ImageHeight*2;
    SetLength(DynWarr, ImageWidth * ImageHeight);
    pT := @DynWarr[0];
  End
    Else
  If (BitsPerPixel = 8) Then Begin
    ImageByteCount := ImageWidth * ImageHeight;
    SetLength(DynBarr, ImageWidth * ImageHeight);
    pT := @DynBarr[0];
  End;

  OffsetTo_ZISRAWSUBBLOCK_Data := OffsetTo_ZISRAWSUBBLOCK + SegmentHeaderSize;

  //Starts Reading the SubBlockSegment
  FPos := OffsetTo_ZISRAWSUBBLOCK_Data;
  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, MetadataSize, SizeOf(MetadataSize));

  FPos := OffsetTo_ZISRAWSUBBLOCK_Data + 256 + MetadataSize;

  FileSeek(CZIFile, FPos, 0);
  FileRead(CZIFile, pT^, ImageByteCount);

 End //If (ValidFile)

  Else

 Begin

      if (NumberOfChannels > 2) then
        MessageDlg('This File has ' + IntToStr(NumberOfChannels) +
              ' Channels. SparkAn so far Works with One or Two Channel Files. ',
            mtError, [mbOK], 0)
      else if (BitsPerPixelStr <> 'Gray8') and (BitsPerPixelStr <> 'Gray16')
      then
        MessageDlg(' SparkAn so far opens 8 and 16 bit files. ', mtError, [mbOK], 0);


 End; // Else

  FileClose(CZIFile);

End; //Procedure GetCZIfile_Preview

{**************************************************************************** }

function IsImgMgrFile(const Fname : String) : Boolean;  //Check if this is ImgMgr File
var ImgMgrFile: File;
    FPos : LongInt;
    ImgMgrHead : array [0 .. 3] of AnsiChar;
    ImgMgrCh: AnsiString;
begin
 if (GetBigFileSize(Fname) > 10) then

  AssignFile(ImgMgrFile, FName);
  FileMode := fmOpenRead;
  Reset(ImgMgrFile, 1);
  FPos := 0;
  Seek(ImgMgrFile, FPos);
  BlockRead(ImgMgrFile, ImgMgrHead, 4);
  ImgMgrCh := Copy(ExtractFileName(FName), 1, 1);

  { 2nd: Check if this is ImgMgr File }
  If (ImgMgrHead = 'imgm' { current } ) or (ImgMgrHead = 'mgmi'
    { very old } )
  Then
    Result := True
  Else
    Result := False;

End; //function IsImgMgrFile

{******************************************************************************}

Procedure GetImgMgrfileInfo(Const FName: AnsiString; Const SilentMode: Boolean);
{ Deals with QED Files }
Type
  TCharSet = set of AnsiChar;

VAR
  CharSet: TCharSet;
  ImgMgrFile: File;
  FPos: Longint;
  ActNrIm: Longint;
  BegFstFile: Longint;
  EndFstFile: Longint;
  BegSecFile: Longint;
  Cnt: Longint;
  EndImgMgrFile: Longint;
  TifFlen: Integer;
  TFoffset: Longint;
  ImgMgrHead: array [0 .. 3] of AnsiChar;
  tif: array [0 .. 2] of AnsiChar;
  TifFname: array [0 .. 255] of AnsiChar;
  DummyHEAD: array [0 .. 7999] of AnsiChar; { speeds up the search }
  PosArr: array of Longint;
  AChar: AnsiChar;
  TemFname: AnsiString;
  FPath: AnsiString;
  FirstFfound: Boolean;
  ImgMgrCh: AnsiString;
  { First Character of  ImgMgr File; AnsiChar Does Not Work }
  SecTifFname: array [0 .. 255] of AnsiChar;
  { name of the Second Fname; Do not Use Dynamic Array }
  I1, I2, I3, Ifin, Ifirst: Int64;
  Warr: array [1 .. 4] of Word;
  MoreThen9999im: Boolean;
  LocalCheckAllFiles: Boolean; // used to control FileExists Fuction
  LastCheckFileNr: LongWord; // used to control FileExists Fuction
  SearchRec: TSearchRec;
  CntIm: Integer;
  Delta: Double;
  NrPages: LongWord; // not used here
  { --------------------------------------------------------------------- }
BEGIN
  { 1st Initialize Variables }
  tif[0] := '0';
  tif[1] := '0';
  tif[2] := '0';
  CharSet := ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '!' .. ')', '+' .. '.',
    ';', '@', '^', '_', ''''];
  FirstFfound := False;
  AssignFile(ImgMgrFile, FName);
  FileMode := fmOpenRead;
  Reset(ImgMgrFile, 1);

  FPos := 0;
  Seek(ImgMgrFile, FPos);
  BlockRead(ImgMgrFile, ImgMgrHead, 4);
  EndImgMgrFile := FileSize(ImgMgrFile) - 1;
  ImgMgrCh := Copy(ExtractFileName(FName), 1, 1);

    { 3rd: Check if there are any Tiff Files }
    FPath := ExtractFilePath(FName);
    ActNrIm := FindFirst(FPath + '*.tif', faAnyFile, SearchRec);
    // ActNrIm here is used as Fake Boolean
    if (ActNrIm = 0) then
      TemFname := SearchRec.Name;
    FindClose(SearchRec);

    If (ActNrIm = 0) Then
    Begin { Means that at least One tiff was found }
      { 4th: Check # of First File and Gies Messsages }
      LastCheckFileNr := StrToInt(Copy(TemFname, Length(TemFname) - 4, 1));
      LocalCheckAllFiles := CheckAllFilesExist;
      if LastCheckFileNr <> 1 then
      begin
        LocalCheckAllFiles := True;
        if LastCheckFileNr = 2 then
          MessageDlg(
            'First File is Missing, Loading will Start from the Second File',
            mtWarning, [mbOK], 0)
        else if LastCheckFileNr > 2 then
          MessageDlg('First Files from 1 to ' + IntToStr(LastCheckFileNr - 1)
              + '  are Missing', mtWarning, [mbOK], 0);
      end;
      Dec(LastCheckFileNr); // Dec Needed because it should start from Zero

      { 5th: Gets Wher the first and second Tiff Files are written and other stuff }

      FPos := 100;
      While (FirstFfound = False) and (FPos < EndImgMgrFile) Do
      Begin
        Inc(FPos);
        Seek(ImgMgrFile, FPos);
        BlockRead(ImgMgrFile, AChar, 1);
        If (AChar in CharSet) and (AChar = ImgMgrCh) Then
        Begin
          BegFstFile := FPos;
          FirstFfound := True;
        End; { (AChar in CharSet) }
      End; { While (FirstFfound = False) and (FPos < EndImgMgrFile) }

      FPos := BegFstFile;
      While (tif <> 'tif') Do
      Begin
        Inc(FPos);
        Seek(ImgMgrFile, FPos);
        BlockRead(ImgMgrFile, tif, 3);
        If tif = 'tif' then
        begin
          EndFstFile := FPos + 2;
          TifFlen := EndFstFile - BegFstFile + 1;
        end; { tif = 'tif' }
      End; { While (tif <> 'tif') }

      FPos := 0; { to be shure we are away from the end }
      Seek(ImgMgrFile, FPos);
      BlockRead(ImgMgrFile, DummyHEAD, 8000);
      FPos := EndFstFile + 2; { to be shure we are away from the end }
      tif[0] := '0';
      tif[1] := '0';
      tif[2] := '0';
      While (tif <> 'tif') and (FPos < 7999) Do
      Begin
        Inc(FPos);
        AChar := DummyHEAD[FPos];
        If AChar = 't' Then
        Begin
          For Cnt := FPos to (FPos + 2) do
            tif[Cnt - FPos] := DummyHEAD[Cnt];
          If tif = 'tif' then
          begin
            BegSecFile := FPos + 2 - TifFlen + 1;
            TFoffset := BegSecFile - BegFstFile;
          end; { tif = 'tif' }
        end; { If AChar = 't' }
      End; { While (tif <> 'tif') }

      { Makes a second Check to see if the Fname was duplicated - happens in some files,
        Then TFoffset sould be from the second name }

      for Cnt := 0 to 255 do
        SecTifFname[Cnt] := AnsiChar(0);

      { Gets Second File Name }
      for Cnt := 0 to TifFlen - 1 do
        SecTifFname[Cnt] := DummyHEAD[Cnt + BegSecFile];

      FPos := BegSecFile + TifFlen + 1;

      { 6th Verifies that The Tiff found with FindFirst Function and the First in
        ImgMgrFile have the Same Root Name }
      { use  function AnsiContainsStr(const AText, ASubText: string): Boolean; }

      { 6th io To Be done In the Future }

      { 7th: Finds Number of Images }
      While FPos < 7999 Do
      Begin { DummyHEAD buffer is [0..7999] } { Here FPos is use as a counter }
        FillChar(TifFname, 256, 0);
        For Cnt := 0 to TifFlen - 1 Do
        Begin
          TifFname[Cnt] := DummyHEAD[Cnt + FPos];
        End;
        if SecTifFname = TifFname then
        Begin
          BegSecFile := FPos;
          TFoffset := BegSecFile - BegFstFile;
          Break;
        End;
        Inc(FPos);
      End; // While FPos < 7999

      NrIm := (EndImgMgrFile - BegFstFile) div TFoffset + 1;
      ActNrIm := NrIm - LastCheckFileNr; // If First Files are missing we still Need Total NrIm
      SetLength(PosArr, ActNrIm);
      SetLength(TiffFileList, ActNrIm);
      MoreThen9999im := False;

      { 8th: Fills Arrays with Filenames }

      CntIm := LastCheckFileNr - 1;
      Cnt := -1;

      While CntIm < NrIm - 1 Do
      Begin
        Inc(CntIm);
        FPos := BegFstFile + TFoffset * CntIm;
        Seek(ImgMgrFile, FPos);
        FillChar(TifFname, 256, 0);

        if (CntIm > 9998) and (Not(MoreThen9999im)) then
        begin
          // Corrects for Bug in QED -> FileName---1,FileName--10; FileName-1000 but -> FileName-10000 !!!
          MoreThen9999im := True;
          TifFlen := TifFlen + 1;
        end;

        BlockRead(ImgMgrFile, TifFname, TifFlen);
        TemFname := FPath + TifFname;

        If (Not(LocalCheckAllFiles)) and (CntIm mod 10 <> 0) then
        Begin
          Inc(Cnt);
          PosArr[Cnt] := FPos;
          TiffFileList[Cnt] := TemFname;
        End
        else If (LocalCheckAllFiles) or (CntIm mod 10 = 0) or
          (CntIm = NrIm - 1) then
        begin
          If FileExists(TemFname) = True Then
          Begin
            Inc(Cnt);
            PosArr[Cnt] := FPos;
            TiffFileList[Cnt] := TemFname;
          End // FileExists(TemFname) = True
          Else
          Begin
            if (LocalCheckAllFiles) then
            begin
              if CntIm = NrIm - 1 then
                MessageDlg('Last File Numbered ' + IntToStr(CntIm + 1) +
                    ' is Missing and will not be Loaded', mtWarning, [mbOK], 0)
              else if CntIm < NrIm then
                MessageDlg('Files Numbered > ' + IntToStr(CntIm) +
                    ' are Missing and will not be Loaded', mtWarning, [mbOK],
                  0);
              ActNrIm := Cnt + 1;
              SetLength(TiffFileList, ActNrIm);
              SetLength(PosArr, ActNrIm);
              Break;
            end
            else if Not(LocalCheckAllFiles) then
            begin
              Dec(Cnt, (CntIm - LastCheckFileNr) - 1);
              CntIm := LastCheckFileNr;
              LocalCheckAllFiles := True;
            end; // if (Not(LocalCheckAllFiles)
          End; // Else Begin
        End; // If (LocalCheckAllFiles) or (CntIm mod 10 = 0) or (CntIm = NrIm)
      End; // While CntIm < High(TiffFileList)

      { -------Read s TIFF file Info -------------------------- }

      GetTIFFfileInfo(NrPages, TiffFileList[0], 0, READ_AS_STACK, 0,SilentMode);

      { 8th: Fills TimeStamps }
      NrIm := ActNrIm;
      SetLength(TimeSt, NrIm);

      If (ToSwap = True) Then
      Begin // Not Intel Files
        For Cnt := 0 to High(PosArr) do
        begin
          if (PosArr[Cnt] > 0) then
          begin
            Seek(ImgMgrFile, PosArr[Cnt] + 5172);
            BlockRead(ImgMgrFile, Warr, 8); // reads as microseconds
            I1 := Swap(Warr[1]);
            I2 := Swap(Warr[2]);
            I3 := Swap(Warr[3]);
            Ifin := I1 shl 48 + I2 shl 32 + I3 shl 16 + Swap(Warr[4]);
            if Cnt > 0 then
              TimeSt[Cnt] := (Ifin - Ifirst) / 1000000
            else
              Ifirst := Ifin;
          end; // if (PosArr[Cnt] > 0)
        End; // For Cnt := 0 to High(PosArr)
      End
      Else If (ToSwap = False) Then
      Begin // Intel Files
        For Cnt := 0 to High(PosArr) do
        begin
          if (PosArr[Cnt] > 0) then
          begin
            Seek(ImgMgrFile, PosArr[Cnt] + 5172);
            BlockRead(ImgMgrFile, Ifin, 8); // reads as microseconds
            if Cnt > 0 then
              TimeSt[Cnt] := (Ifin - Ifirst) / 1000000
            else
              Ifirst := Ifin;
          end;
        End;
      End;
      TimeSt[0] := 0;


      { Check if Pause exists and sets Cycle buffers }

      If NrIm > 1 then
      Begin

        if NrIm >= 3 then
          Delta := (TimeSt[2] - TimeSt[1]) * 10
        else if NrIm = 2 then
          Delta := (TimeSt[1] - TimeSt[0]) * 10;

        if MovieCycleList <> nil then
          SetLength(MovieCycleList, 0); // resets

        for Cnt := 1 to High(TimeSt) do
        begin
          if (TimeSt[Cnt] - TimeSt[Cnt - 1]) > Delta then
          begin
            SetLength(MovieCycleList, High(MovieCycleList) + 2);
            MovieCycleList[ High(MovieCycleList)] := Cnt;
            Delta := (TimeSt[Cnt + 1] - TimeSt[Cnt]) * 10; // resets Delta
          end;
        end; // For Cnt := 1 to High(TimeSt) do begin

        If ( High(MovieCycleList) > -1) then
        begin
          SetLength(MovieCycleList, High(MovieCycleList) + 2);
          MovieCycleList[ High(MovieCycleList)] := NrIm; // puts the last one
        End;
        FillMovieFrRateListAndCalcMeanImTime;

      End; // If NrIm > 1 then Begin

    End; // If ActNrIm = 0 Used as Result of the Function FindFirst

    Close(ImgMgrFile);

End;


{*******************************************************************************}

Procedure GetSGIfileInfo(Const FName: AnsiString;  Const SilentMode: Boolean);
var
  TemPointer: Pointer;
  TempStr: AnsiString;

  FPos: Longint;
  HEAD: array of Byte;
  pHEAD: Pointer; { pointer to Head, used to read File with HEAD }
  HeadSize: Longint; { Size of Head to Get Time Stamps & Image Offsets }
  SGIinfo: array [1 .. 3, 1 .. 9] of AnsiString;
  NAME: array [0 .. 11] of AnsiChar; { length = longest word in Info array }
  VALUE: array [0 .. 7] of AnsiChar; { length = longest Number in Info array }
  Cnt: Integer;
  Vcnt: Longint;
  Vpos: Longint;
  Vlen: Longint;
  TempImFile: File;
  { ------------- }
  Base: Longint;
  Pow: Longint; { Power }
  TempImOffset: array of Longint;
  ImOffsetHex: array [0 .. 3] of Longint;
  RealTimeBegSec: Currency;
  RealTimeBegNanoSec: Currency;
  TempNanoSec: Currency;
  TimStSec: array [0 .. 7] of Extended;
  { converts ASCII hexa Seconds  to decimal }
  TimStNanoS: array [0 .. 7] of Extended;
  { converts ASCII hexa Nanosecons to decimal }
  MinDelt, MaxDelt, TemExt: Extended; { used Only if Time is Corrupteted }

  { -------------------------------------------------------- }

BEGIN

  SetLength(TempStr, 4);
  TemPointer := @TempStr[1]; // sets pointer to 1st position
  AssignFile(TempImFile, FName);
  FileMode := fmOpenRead;
  Reset(TempImFile, 1);
  FPos := 0;
  Seek(TempImFile, FPos);
  BlockRead(TempImFile, TemPointer^, 4);

    SetLength(HEAD, 5000);
    pHEAD := HEAD;
    FPos := 0;
    Seek(TempImFile, FPos);
    BlockRead(TempImFile, pHEAD^, 5000);

    SGIinfo[1, 1] := 'WIDTH';
    SGIinfo[1, 2] := 'Xdimension'; { X size of one pixel in microns (X=Y) }
    SGIinfo[1, 3] := 'HEIGHT';
    SGIinfo[1, 4] := 'Ydimension'; { Y size of one pixel in microns (X=Y) }
    SGIinfo[1, 5] := 'DIR_COUNT'; { Nr of images in file }
    SGIinfo[1, 6] := 'PixelDwell'; { nonoseconds per pixel }
    SGIinfo[1, 7] := 'NI_cntrstf1'; { Contrast }
    SGIinfo[1, 8] := 'NI_brghtf1'; { Brighness }
    SGIinfo[1, 9] := 'I_LaserPower'; { Laser Power % }
    { Brighness & Contrast are not written in some (older) type of SGI }
    { the were found close to FPos (byte) ~ 4000 }

    SGIinfo[2, 1] := '20';
    SGIinfo[2, 2] := '17'; { 1st column (1) = name of variable }
    SGIinfo[2, 3] := '20'; { 2nd column (2) = offset of the value }
    SGIinfo[2, 4] := '17'; { 3nd column (3) = value of variable searched }
    SGIinfo[2, 5] := '18';
    SGIinfo[2, 6] := '17'; { SGIinfo(3, *) }
    SGIinfo[2, 7] := '20';
    SGIinfo[2, 8] := '20';
    SGIinfo[2, 9] := '19';

    SGIinfo[3, 7] := 'NA'; { means Not Available (in some older SGI files) }
    SGIinfo[3, 8] := 'NA'; { means Not Available (in some older SGI files) }
    SGIinfo[3, 9] := 'NA'; { means Not Available (in some older SGI files) }
    { ************ starts Getting SGIinformation on SGIinfo Array ****** }

    For Cnt := 1 To 9 Do
    Begin { Nr of Columns in SGIinfo Array }
      Vpos := 0;
      Vlen := Length(SGIinfo[1, Cnt]);
      While (NAME <> SGIinfo[1, Cnt]) And (Vpos < 5000 - 20) Do
      Begin { 20 prevents overflow }
        FillChar(NAME, 12, 0); { resets the Array, do not remove }
        For Vcnt := Vpos To (Vpos + Vlen - 1) do
          NAME[Vcnt - Vpos] := AnsiChar(HEAD[Vcnt]);
        If (NAME) = SGIinfo[1, Cnt] Then
        Begin
          Vpos := Vpos + StrToInt(SGIinfo[2, Cnt]);
          { sets to the actual offset }
          FillChar(VALUE, 8, 0); { resets the Array, do not remove }
          For Vcnt := Vpos To (Vpos + 7) do
          Begin
            if HEAD[Vcnt] <> 0 then
              VALUE[Vcnt - Vpos] := AnsiChar(HEAD[Vcnt])
            else if HEAD[Vcnt] = 0 then
              Break;
          End; { For }
          SGIinfo[3, Cnt] := VALUE;
        End; { If NAME = SGIinfo(0, Cnt) }
        Inc(Vpos);
      end; { While(Found = False) And (Vpos < 2599) }
    end; { For Cnt := 1 To 9 }

    { *********** End of Getting Data for SGIinfo Array ********** }
    { Resets & Initializes Some Global Variables }

    imXsize := StrToInt(SGIinfo[3, 1]); { of the image in pixels }
    imYsize := StrToInt(SGIinfo[3, 3]); { of the image in pixels }
    if DecSep <> '.' then
      SGIinfo[3, 2] := AnsiReplaceStr(SGIinfo[3, 2], '.', DecSep);
    { assumes that this is US DecSep = dot }
    PixSize := StrToFloat(SGIinfo[3, 2]);
    { the size of one pixel in X dim in microns = Ypix }
    { Ypix = Xpix := StrToFloat(SGIinfo[3,4]);  'the size of one pixel in Y dim in microns - NOT USED }
    ImagePix := imXsize * imYsize; { gets the number of pixels in one image }
    NrIm := StrToInt(SGIinfo[3, 5]); { number of images in file }
    ScopeSystemParams.PixDwell := StrToInt(SGIinfo[3, 6]);
    ScopeSystemParams.PixDwell_Units := 'ns';
    { time between two pixels-Only in Noran }
    if SGIinfo[3, 7] <> 'NA' then
      ScopeSystemParams.PMT_Gain := StrToInt(SGIinfo[3, 7])
      { NORAN Files Only = Contrast [PMT amplification }
    else
      ScopeSystemParams.PMT_Gain := -1;
    if SGIinfo[3, 8] <> 'NA' then
      ScopeSystemParams.PMT_Offset := StrToInt(SGIinfo[3, 8])
      { NORAN Files Only = Offset [Brightness) }
    else
      ScopeSystemParams.PMT_Offset := -1;
    if SGIinfo[3, 9] <> 'NA' then
      ScopeSystemParams.AOD_Power := StrToInt(SGIinfo[3, 9]) { NORAN Files Only = Laser Power % }
    else
      ScopeSystemParams.AOD_Power := -1;
    BitCount := 8; { Sets it to 8 (8 bit image) }
    ToSwap := False; { do not swap bytes }
    ImageBytes := ImagePix; { number of blocks (each one byte to read }

    { ******** Declaring Variables for Image offset & Timestamps *********** }

    HeadSize := FileSize(TempImFile) - ImagePix * NrIm;
    SetLength(HEAD, HeadSize);
    pHEAD := HEAD;
    FPos := 0;
    Seek(TempImFile, FPos);
    BlockRead(TempImFile, pHEAD^, HeadSize);

    { ------------------- begins to search for the Images offset --------------- }

    SetLength(ImOff,1,NrIm); { global: stores the offset for each image }
    SetLength(TimeSt, NrIm); { global: stores timestamp in seconds }
    SetLength(TempImOffset, NrIm); { Find all position of "N" }
    { -------- till here works-- }

    { TempImOffset =  where(HEAD EQ 78)  ' ASCII value for "N" }
    { looks for ASCII values between"&" = 38 and "-" = 45 }
    Vpos := 0;
    Cnt := 8;
    While (Cnt < High(HEAD)) And (Vpos < NrIm) Do
    Begin { no need to start from beginning }
      Inc(Cnt);
      If (HEAD[Cnt] = 78) Then
      Begin { ASCII value for "N" }
        If ((HEAD[Cnt - 5] >= 38) And (HEAD[Cnt - 5] <= 45)) And
          ((HEAD[Cnt - 1] = 0) And (HEAD[Cnt - 2] = 0) And (HEAD[Cnt - 3] = 0)
            and (HEAD[Cnt - 4] = 0) And (HEAD[Cnt - 6] = 0) And
            (HEAD[Cnt - 7] = 0) And (HEAD[Cnt - 8] = 0)) Then
        Begin
          TempImOffset[Vpos] := Cnt - 16;
          Inc(Vpos);

          { finds the offset to the beginnig of binary HEX Image offset values }
        End; { if - complex conditions }
      End; { if Head(Cnt) = 78 }
    End; { Cnt = 8 To High(Head) }

    { ------- converts binary HEX to Decimal }
    Base := 16;
    Pow := 7;
    For Cnt := 0 To NrIm - 1 Do
    Begin
      For Vpos := 0 To 3 do
      begin { fills ImOffsetHex buffer }
        ImOffsetHex[Vpos] := HEAD[TempImOffset[Cnt] + Vpos];
      End; { Vpos = 0 To 3 }
      For Vcnt := 0 To 3 do
      begin
        ImOffsetHex[Vcnt] := (ImOffsetHex[Vcnt] div 16) *
          (round(exp((Pow - Vcnt * 2) * ln(Base)))) +
          (ImOffsetHex[Vcnt] Mod 16) *
          (round(exp((Pow - Vcnt * 2 - 1) * Ln(Base))));
        { Base^Power := exp(Power * ln(Base)); } { e.g. 8^3 = 512 }
      End; { Vcnt = 0 To 3 }
      ImOff[0,Cnt] := 0;
      For Vcnt := 0 To 3 do
      begin
        ImOff[0,Cnt] := ImOff[0,Cnt] + ImOffsetHex[Vcnt];
      end; { Vpos = 0 To 3 }
    End; { Cnt := 0 To NrIm-1 }
    { -------End of Finding Images Offset ------------ }
    { --- Finds Beginning of Time Stamps ASCII HEX numbers ------ }

    Vpos := 0;
    Cnt := 0;
    While (Cnt < High(HEAD) - 13) And (Vpos < NrIm) Do
    Begin
      { starts searching for "NI_Timestamp }
      Inc(Cnt);
      If (HEAD[Cnt] = 78) Then
      Begin { ASCII value for "N" }
        FillChar(NAME, 12, 0); { resets the Array, do not remove }
        For Vcnt := Cnt To (Cnt + 11) Do
        Begin { "12 = lenght of "NI_Timestamp" - 1 }
          NAME[Vcnt - Cnt] := AnsiChar(HEAD[Vcnt]);
        end;
        If NAME = 'NI_Timestamp' Then
        begin
          TempImOffset[Vpos] := Cnt + 20; { Beginning of 16 Letter Timestamp }
          Inc(Vpos);
        End; { If 'NAME = "NI_Timestamp" }
      End; { If Head(Cnt) = 78 Then     ' ASCII value for "N" }

    End; { (Cnt < High(Head) - 13) And (Vpos < NrIm) }
    { --- End of Finds Beginning of Time Stamps ASCII HEX numbers ------ }
    { -----Stsrts converting ASCII HEX to Decimal Numbers -------- }
    RealTimeBegSec := 0;
    RealTimeBegNanoSec := 0;

    For Cnt := 0 To NrIm - 1 Do
    Begin
      For Vcnt := 0 To 7 Do
      begin { copies the left  8 ASCII hexa }
        TimStSec[Vcnt] := HEAD[TempImOffset[Cnt] + Vcnt];
        TimStNanoS[Vcnt] := HEAD[TempImOffset[Cnt] + 8 + Vcnt];
      End; { Vcnt = 0 To 7 }

      For Vcnt := 0 To 7 Do
      Begin { Convets ASCII HEX numbrs to Decimal }
        If TimStSec[Vcnt] <= 57 Then
          TimStSec[Vcnt] := TimStSec[Vcnt] - 48
        Else If TimStSec[Vcnt] > 57 Then
          TimStSec[Vcnt] := TimStSec[Vcnt] - 55;

        If TimStNanoS[Vcnt] <= 57 Then
          TimStNanoS[Vcnt] := TimStNanoS[Vcnt] - 48
        Else If TimStNanoS[Vcnt] > 57 Then
          TimStNanoS[Vcnt] := TimStNanoS[Vcnt] - 55;
        { exp(Pow * ln(Base)); }
        TimStSec[Vcnt] := TimStSec[Vcnt] * (exp((Pow - Vcnt) * ln(Base)));
        TimStNanoS[Vcnt] := TimStNanoS[Vcnt] * (exp((Pow - Vcnt) * ln(Base)));
        { TimStNanoS[Vcnt] := TimStNanoS(Vcnt) * Base ^ (Power - Vcnt): }
      End; { Vcnt = 0 To 7 }
      TempNanoSec := 0;
      TimeSt[Cnt] := 0;
      For Vcnt := 0 To 7 Do
      Begin { finishes the conversion and puts the Time St in TimeSt array }
        If Cnt = 0 Then
        Begin
          RealTimeBegSec := RealTimeBegSec + TimStSec[Vcnt];
          RealTimeBegNanoSec := RealTimeBegNanoSec + TimStNanoS[Vcnt];
        End
        Else If Cnt > 0 Then
        Begin
          TimeSt[Cnt] := TimeSt[Cnt] + TimStSec[Vcnt];
        End;
        TempNanoSec := TempNanoSec + TimStNanoS[Vcnt];
      End; { Vcnt = 0 To 7 }

      If Cnt = 0 Then
        TimeSt[Cnt] := 0
      Else If Cnt > 0 Then
      Begin
        TimeSt[Cnt] := (TimeSt[Cnt] - RealTimeBegSec) * 1000000000;
        { converts sec to mili sec }
        TimeSt[Cnt] := (TimeSt[Cnt] + TempNanoSec) - RealTimeBegNanoSec;
        TimeSt[Cnt] := TimeSt[Cnt] / 1000000000;
        { converts nanosec. to seconds }
      End; { If Cnt > 0 }

    End; { 'Cnt = 1 To NrIm }

    { Checks if Time is O.K. if not corrects it }
    { I verified that the precision of Time in sec is the Same as in NanoSec }

    MinDelt := 1.18E49; // Extended ranges from 3.37 x 10-4932 to 1.18 x 10+4932
    MaxDelt := 0;
    For Cnt := 0 to High(TimeSt) - 1 do
    begin
      TemExt := TimeSt[Cnt + 1] - TimeSt[Cnt];
      if TemExt > 0 then
      Begin
        if MinDelt > TemExt then
          MinDelt := TemExt;
        if MaxDelt < TemExt then
          MaxDelt := TemExt;
      end;
    End;
    PixSettings.FileHasOwnPixSize := True;
    If (MaxDelt - MinDelt) > MinDelt / 10 then
      MessageDlg('Time is Corrupted! To Correct Time go to "Options".',
        mtWarning, [mbOK], 0);
    { ----------- End of CheckUp ---------- }

  CloseFile(TempImFile);

End; { Procedure GetSGIfileInfo }

{ **************************************************************************** }

Procedure GetSGIfile_Preview(Const FName: AnsiString; var DynBarr: TDynByteArray;
                             var ImageWidth, ImageHeight: Word;var ValidFile: Boolean);

{ this is simplified version of Procedure  GetSGIfileInfo }
var

  TempImFile: File;
  FPos: Longint;
  HEAD: array of Byte;
  pHEAD: Pointer; { pointer to Head, used to read File with HEAD }
  SGIinfo: array [1 .. 3, 1 .. 5] of AnsiString;
  NAME: array [0 .. 11] of AnsiChar; { length = longest word in Info array }
  VALUE: array [0 .. 7] of AnsiChar; { length = longest Number in Info array }
  Cnt: Integer;
  Vcnt: Longint;
  Vpos: Longint;
  Vlen: Longint;
  TemPointer: Pointer;
  TempStr: AnsiString;
  Base: Longint;
  Pow: Longint; { Power }
  TempImOffset: Longint;
  ImOffsetHex: array [0 .. 3] of Longint;
  { -------------------------------------------------------- }

BEGIN

  SetLength(TempStr, 4);
  TemPointer := @TempStr[1]; // sets pointer to 1st position
  AssignFile(TempImFile, FName);
  FileMode := fmOpenRead;
  Reset(TempImFile, 1);
  FPos := 0;
  Seek(TempImFile, FPos);
  BlockRead(TempImFile, TemPointer^, 4);

  If TempStr <> 'MOVI' Then
  Begin
    ValidFile := False;
    MessageDlg('This is Not a SGI file', mtError, [mbOK], 0);
  End
  Else

    If TempStr = 'MOVI' Then
  Begin

    ValidFile := True;

    SetLength(HEAD, 5000);
    pHEAD := @HEAD[0];
    FPos := 0;
    Seek(TempImFile, FPos);
    BlockRead(TempImFile, pHEAD^, 5000);

    SGIinfo[1, 1] := 'WIDTH';
    SGIinfo[1, 2] := 'Xdimension'; { X size of one pixel in microns (X=Y) }
    SGIinfo[1, 3] := 'HEIGHT';
    SGIinfo[1, 4] := 'Ydimension'; { Y size of one pixel in microns (X=Y) }
    SGIinfo[1, 5] := 'DIR_COUNT'; { Nr of images in file }

    SGIinfo[2, 1] := '20';
    SGIinfo[2, 2] := '17'; { 1st column (1) = name of variable }
    SGIinfo[2, 3] := '20'; { 2nd column (2) = offset of the value }
    SGIinfo[2, 4] := '17'; { 3nd column (3) = value of variable searched }
    SGIinfo[2, 5] := '18';

    { ************ starts Getting SGIinformation on SGIinfo Array ****** }

    For Cnt := 1 To 5 Do
    Begin { Nr of Columns in SGIinfo Array }
      Vpos := 0;
      Vlen := Length(SGIinfo[1, Cnt]);
      While (NAME <> SGIinfo[1, Cnt]) And (Vpos < 5000 - 20) Do
      Begin { 20 prevents overflow }
        FillChar(NAME, 12, 0); { resets the Array, do not remove }
        For Vcnt := Vpos To (Vpos + Vlen - 1) do
          NAME[Vcnt - Vpos] := AnsiChar(HEAD[Vcnt]);
        If (NAME) = SGIinfo[1, Cnt] Then
        Begin
          Vpos := Vpos + StrToInt(SGIinfo[2, Cnt]);
          { sets to the actual offset }
          FillChar(VALUE, 8, 0); { resets the Array, do not remove }
          For Vcnt := Vpos To (Vpos + 7) do
          Begin
            if HEAD[Vcnt] <> 0 then
              VALUE[Vcnt - Vpos] := AnsiChar(HEAD[Vcnt])
            else if HEAD[Vcnt] = 0 then
              Break;
          End; { For }
          SGIinfo[3, Cnt] := VALUE;
        End; { If NAME = SGIinfo(0, Cnt) }
        Inc(Vpos);
      end; { While(Found = False) And (Vpos < 2599) }
    end; { For Cnt := 1 To 9 }

    ImageWidth := StrToInt(SGIinfo[3, 1]); { of the image in pixels }
    ImageHeight := StrToInt(SGIinfo[3, 3]); { of the image in pixels }
    // NrImages    := StrToInt(SGIinfo[3,5]);    {number of images in file}

    { ------------------- begins to search for the 1 st Image offset --------------- }

    { TempImOffset =  where(HEAD EQ 78)  ' ASCII value for "N" }
    { looks for ASCII values between"&" = 38 and "-" = 45 }
    Vpos := 0;
    Cnt := 8;

    While (Cnt < High(HEAD)) And (Vpos < 1) Do
    Begin { no need to start from beginning }
      Inc(Cnt);
      If (HEAD[Cnt] = 78) Then
      Begin { ASCII value for "N" }
        If ((HEAD[Cnt - 5] >= 38) And (HEAD[Cnt - 5] <= 45)) And
          ((HEAD[Cnt - 1] = 0) And (HEAD[Cnt - 2] = 0) And (HEAD[Cnt - 3] = 0)
            and (HEAD[Cnt - 4] = 0) And (HEAD[Cnt - 6] = 0) And
            (HEAD[Cnt - 7] = 0) And (HEAD[Cnt - 8] = 0)) Then
        Begin
          TempImOffset := Cnt - 16;
          Inc(Vpos);
          { finds the offset to the beginnig of binary HEX Image offset values }
        End; { if - complex conditions }
      End; { if Head(Cnt) = 78 }
    End; { Cnt = 8 To High(Head) }

    Base := 16;
    Pow := 7;
    For Vpos := 0 To 3 do
    begin { fills ImOffsetHex buffer }
      ImOffsetHex[Vpos] := HEAD[TempImOffset + Vpos];
    End; { Vpos = 0 To 3 }
    For Vcnt := 0 To 3 do
    begin
      ImOffsetHex[Vcnt] := (ImOffsetHex[Vcnt] div 16) *
        (round(exp((Pow - Vcnt * 2) * ln(Base)))) + (ImOffsetHex[Vcnt] Mod 16)
        * (round(exp((Pow - Vcnt * 2 - 1) * ln(Base))));
      { Base^Power := exp(Power * ln(Base)); } { e.g. 8^3 = 512 }
    End; { Vcnt = 0 To 3 }
    FPos := 0;
    For Vcnt := 0 To 3 do
    begin
      FPos := FPos + ImOffsetHex[Vcnt];
    end; { Vpos = 0 To 3 }

    { Reads the Image Data to DynBarr }
    SetLength(DynBarr, ImageWidth * ImageHeight);
    pHEAD := @DynBarr[0];
    Seek(TempImFile, FPos);
    BlockRead(TempImFile, pHEAD^, Length(DynBarr));
    { -------End of Finding Images Offset ------------ }

  End; // If TempStr = 'MOVI' Then Begin

  CloseFile(TempImFile);
END; // Procedure GetSGIfile_Preview


{*****************************************************************************}

Procedure GetNoranPrairiePCFinfo(Const FName: AnsiString;Const SilentMode: Boolean);

        var
          RootFName: AnsiString;
          FilePath: AnsiString;
          TempStr: AnsiString;
          SearchRec: TSearchRec;
          PosCnt: Integer;
          CntCONT, CntWAIT: Integer;
          CntIm, Cnt, CyclCnt: Integer;
          LogFile: TextFile; // "pcf" file
          FileFound: Integer;
          TotalCycles: Word;
          NoranCycleModeList: array of ShortInt; // -128..127
          LeadingZeroes: Boolean;
          CycleFileListNames: array of AnsiString;
          // stores temporarily File Names if
          // They Have Leading Zeroes - like in the New Version of Noran SoftWare
          NrPages: LongWord; // not used here
          ValidFile : Boolean; //before it was an argument; Now
          //Procedure TMainForm.OpenImageDialogSelectionChange(Sender: TObject);
          //Checks Files
          //I left it because was easier and these files are generated anymore

        Begin

          { 1st: Opens Log File = Main.pcf }

          AssignFile(LogFile, FName); // Gets Only the number of Cycles
          FileMode := fmOpenRead;
          Reset(LogFile);

          for PosCnt := 1 to 30 do
            Readln(LogFile);

          Readln(LogFile, TempStr);
          TotalCycles := StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 13));

          SetLength(NoranCycleModeList, TotalCycles);

          for PosCnt := 1 to 5 do
            Readln(LogFile); // positions to read First Cycle Info

          For Cnt := 1 to TotalCycles do
          Begin
            Readln(LogFile);
            Readln(LogFile, TempStr);
            if (TempStr = 'Acquisition mode=CONTINUOUS') or
              (TempStr = 'Acquisition mode=SINGULAR') then
            begin
              NoranCycleModeList[Cnt - 1] := Cnt;
              Readln(LogFile);
              Readln(LogFile);
              Readln(LogFile);
              Readln(LogFile);
              Readln(LogFile);
              Readln(LogFile);
            end
            else if TempStr = 'Acquisition mode=WAIT' then
            begin
              NoranCycleModeList[Cnt - 1] := -Cnt;
              Readln(LogFile);
              Readln(LogFile);
              Readln(LogFile);
            end;
          End; // For Cnt := 1 to TotalCycles do Begin

          CloseFile(LogFile);

          FilePath := ExtractFilePath(FName); // FindNext(SearchResult) <> 0;

          { 2nd: checks for existance of Tiff files; Only One Found is enough }
          For Cnt := 0 to High(NoranCycleModeList) Do
          Begin
            If NoranCycleModeList[Cnt] > 0 then
            Begin
              RootFName := FilePath + '*Cycle' + IntToStr
                (NoranCycleModeList[Cnt]) + '_*.tif';
              FileFound := FindFirst(RootFName, faAnyFile, SearchRec);
              if (FileFound = 0) then
              begin
                GetTIFFfileInfo(NrPages, FilePath + SearchRec.Name,
                  0, READ_AS_STACK, 0,SilentMode);
                if (ValidFile) then Break;
              end; // if (FileFound = 0)
              FindClose(SearchRec); // free resourses
            End; // If NoranCycleModeList[Cnt] > 0
          End; // For Cnt := 0 to High(NoranCycleModeList[Cnt-1]) Do Begin

          { 2nd: checks for existance of Raw files if No Tiff Files Found; At Least One FileList & One Image Raw Block is Enough }
          If (FileFound <> 0) or Not(ValidFile) Then
          Begin

            For Cnt := 0 to High(NoranCycleModeList) Do
            Begin
              If NoranCycleModeList[Cnt] > 0 then
              Begin
                RootFName := FilePath + 'Cycle' + '*' + '_Filelist.txt';
                FileFound := FindFirst(RootFName, faAnyFile, SearchRec);
                if SearchRec.Name[6] = '0' then
                  LeadingZeroes := True
                else
                  LeadingZeroes := False;
                FindClose(SearchRec); // free resourses
                If (FileFound = 0) then
                Begin
                  RootFName := FilePath + 'Cycle' + IntToStr
                    (NoranCycleModeList[Cnt]) + '_Image_Block_*';
                  FileFound := FindFirst(RootFName, faAnyFile, SearchRec);
                  FindClose(SearchRec); // free resourses
                  if (FileFound = 0) then  Break; // Stops Searching
                End; // If FileFound = 0 then Begin
              End; // If NoranCycleModeList[Cnt] > 0
            End; // For Cnt := 0 to High(NoranCycleModeList[Cnt-1]) Do Begin

          End; // If FileFound <> 0 Then Begin

          { ---------------------------------------------------------------- }
          { Gives a Message if No files are found }
          If (FileFound <> 0) then
          begin
            ValidFile := False;
            MessageDlg('No Tiff or RAW Files Found', mtError, [mbOK], 0);
          End
          Else
          { ------------------------------------------------------------------ }
          { 3rd: Fills Array with Tiff or Raws }
          If (FileFound = 0) then
          Begin

            ValidFile := True;
            PixSettings.FileHasOwnPixSize := False;

            { sets buffers }
            If TotalCycles > 1 then
            Begin
              CntCONT := 0; // used here to count Image containing cycles;
              for Cnt := 0 to High(NoranCycleModeList) do
              begin
                if NoranCycleModeList[Cnt] > 0 then
                  Inc(CntCONT);
              end;
              SetLength(MovieCycleList, CntCONT);
            End
            Else If TotalCycles = 1 then
            Begin
              MovieCycleList := nil;
            End;

            { Opens Log File = Main.pcf  and Gets Parameters }
            AssignFile(LogFile, FName);
            FileMode := fmOpenRead;
            Reset(LogFile);

            for PosCnt := 1 to 2 do
              Readln(LogFile);
            Readln(LogFile, TempStr);
            ScopeSystemParams.AOD_Power := StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 14));

            Readln(LogFile);

            Readln(LogFile, TempStr);
            shrFact := StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 10))
              - 8; // Bit Dept - 8
            // NOW IS  12 bit actually multiple of 2 11 bit

            Readln(LogFile);

            Readln(LogFile, TempStr);
            ScopeSystemParams.PMT_Gain := StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 15));
            Readln(LogFile, TempStr);
            ScopeSystemParams.PMT_Offset := StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 17));

            for PosCnt := 1 to 9 do Readln(LogFile);
            Readln(LogFile, TempStr);
            ScopeSystemParams.PixDwell := round(1000 * (StrToFloat(AnsiRightStr(TempStr,Length(TempStr) - 16))));
            ScopeSystemParams.PixDwell_Units := 'ns';

            Readln(LogFile);
            Readln(LogFile, TempStr); // reads Frame period (us)
            MeanImTime := (StrToFloat(AnsiRightStr(TempStr,Length(TempStr) - 18))) / 1000000;
            // example: Frame period (us)=17817.6

            ExportDial.OrigFrameRate := 1 / MeanImTime;

            for PosCnt := 1 to 10 do
              Readln(LogFile);

            Readln(LogFile, TempStr); // Reads: Number of images=
            TotalCycles := StrToInt(AnsiRightStr(TempStr,
                Length(TempStr) - 13));

            SetLength(NoranCycleModeList, TotalCycles);

            Readln(LogFile, TempStr); // Reads: Total Number of images
            NrIm := StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 13));
            SetLength(TimeSt, NrIm);
            SetLength(TiffFileList, NrIm);

            for PosCnt := 1 to 4 do
              Readln(LogFile); // positions to read First Cycle Info

            CntCONT := 0;
            CntWAIT := 0;
            For Cnt := 1 to TotalCycles do
            Begin
              Readln(LogFile);
              Readln(LogFile, TempStr);
              if (TempStr = 'Acquisition mode=CONTINUOUS') or
                (TempStr = 'Acquisition mode=SINGULAR') then
              begin
                NoranCycleModeList[Cnt - 1] := Cnt; // this was done in the previous LogFile reading but I live it
                Readln(LogFile);
                Readln(LogFile);
                Readln(LogFile, TempStr); // number of images for this cycle
                if MovieCycleList <> nil then
                begin
                  if CntCONT = 0 then
                    MovieCycleList[CntCONT] := StrToInt(AnsiRightStr(TempStr,
                        Length(TempStr) - 17))
                  else if CntCONT > 0 then
                    MovieCycleList[CntCONT] := MovieCycleList[CntCONT - 1]
                      + StrToInt(AnsiRightStr(TempStr, Length(TempStr) - 17));
                end;
                Inc(CntCONT);
                Readln(LogFile);
                Readln(LogFile);
                Readln(LogFile);
              end
              else if TempStr = 'Acquisition mode=WAIT' then
              begin
                NoranCycleModeList[Cnt - 1] := -Cnt; // this was done in the previous LogFile reading but I live it
                Readln(LogFile);
                Readln(LogFile, TempStr); // reads waiting time in microseconds
                Inc(CntWAIT);
                Readln(LogFile);
              end;
            End; // For Cnt := 1 to TotalCycles do Begin

            While TempStr <> '[Image TimeStamp (us)]' do
            begin
              Readln(LogFile, TempStr);
            End;

            CntIm := 0;
            While (Not(Eof(LogFile))) and (CntIm <= High(TimeSt)) Do
            Begin
              Readln(LogFile, TempStr);
              PosCnt := PosEx('=', TempStr);
              TimeSt[CntIm] := (StrToFloat(AnsiRightStr(TempStr,
                    Length(TempStr) - PosCnt))) / 1000000;
              Inc(CntIm);
            End;

            CloseFile(LogFile);
            { end of reading of the Log file }


              CntIm := 0;
              For Cnt := 0 to High(NoranCycleModeList) Do
              Begin
                If NoranCycleModeList[Cnt] > 0 then
                Begin
                  RootFName := FilePath + '*Cycle' + IntToStr
                    (NoranCycleModeList[Cnt]) + '_*.tif';
                  FileFound := FindFirst(RootFName, faAnyFile, SearchRec);
                  if (FileFound = 0) then
                  begin
                    if (CntIm > 0) then
                      Inc(CntIm);
                    TiffFileList[CntIm] := FilePath + SearchRec.Name;
                    while FindNext(SearchRec) = 0 do
                    begin
                      Inc(CntIm);
                      TiffFileList[CntIm] := FilePath + SearchRec.Name;
                    end;
                  end;
                  FindClose(SearchRec); // free resourses
                End; // If NoranCycleModeList[Cnt] > 0
              End; // For Cnt := 0 to High(NoranCycleModeList[Cnt-1]) Do Begin

              If (CntIm < NrIm - 1) then
              begin
                MessageDlg(IntToStr(NrIm - CntIm - 1)
                    + ' Out of Total ' + IntToStr(NrIm)
                    + ' Tiff Files are Missing', mtWarning, [mbOK], 0);
                NrIm := CntIm + 1;
                SetLength(TimeSt, NrIm);
                SetLength(TiffFileList, NrIm);
              End;


        End;
 End; //Procedure GetNoranPrairiePCFinfo

 { ****************************************************************************** }

Procedure GetNoranPrairieXMLinfo(Const FName: AnsiString;Const SilentMode: Boolean);

var
          XMLfile: TextFile;
          ReadStr: AnsiString;
          FilePath: AnsiString;
          SearchRec: TSearchRec;
          PosCnt, Cnt: Integer;
          NrChar: Integer;
          AbsTime: Double;
          NrPages: LongWord; // not used here
          CntFiles: Integer;

Begin
          AssignFile(XMLfile, FName); // Gets Only the number of Cycles
          FileMode := fmOpenRead;
          Reset(XMLfile);

          // Skips first 2 lines
          Readln(XMLfile);
          Readln(XMLfile);

          { Finds the General Parameters }
          Readln(XMLfile, ReadStr);

          PosCnt := AnsiPos('pmt_offset_0="', ReadStr) + Length
            ('pmt_offset_0="');
          for Cnt := PosCnt to Length(ReadStr) do
          begin
            if (ReadStr[Cnt] = '"') then
            begin
              NrChar := Cnt - PosCnt;
              Break;
            end;
          end;
          ScopeSystemParams.PMT_Offset := StrToInt((AnsiMidStr(ReadStr, PosCnt, NrChar)));

          PosCnt := AnsiPos('aod_power="', ReadStr) + Length('aod_power="');
          for Cnt := PosCnt to Length(ReadStr) do
          begin
            if (ReadStr[Cnt] = '"') then
            begin
              NrChar := Cnt - PosCnt;
              Break;
            end;
          end;
          ScopeSystemParams.AOD_Power := StrToInt((AnsiMidStr(ReadStr, PosCnt, NrChar)));

          PosCnt := AnsiPos('pmt_gain_0="', ReadStr) + Length('pmt_gain_0="');
          for Cnt := PosCnt to Length(ReadStr) do
          begin
            if (ReadStr[Cnt] = '"') then
            begin
              NrChar := Cnt - PosCnt;
              Break;
            end;
          end;
          ScopeSystemParams.PMT_Gain := round(StrToFloat((AnsiMidStr(ReadStr, PosCnt, NrChar))));

          PosCnt := AnsiPos('dwell_time="', ReadStr) + Length('dwell_time="');
          for Cnt := PosCnt to Length(ReadStr) do
          begin
            if (ReadStr[Cnt] = '"') then
            begin
              NrChar := Cnt - PosCnt;
              Break;
            end;
          end;
          ScopeSystemParams.PixDwell := round(1000 * (StrToFloat((AnsiMidStr(ReadStr, PosCnt,NrChar)))));
          ScopeSystemParams.PixDwell_Units := 'ns';
          // --- end of getting general information//

          FilePath := ExtractFilePath(FName);
          ReadStr := FilePath + '*.tif';

          // finds Number of tiff Files in Directory

          If (FindFirst(ReadStr, faAnyFile, SearchRec) = 0) then
          Begin

            GetTIFFfileInfo(NrPages, FilePath + SearchRec.Name, 0,
              READ_AS_STACK, 0,SilentMode);
            Cnt := 1;
            while (FindNext(SearchRec) = 0) do
            begin
              Inc(Cnt);
            end;

            // initializing some variables
            NrIm := Cnt;
            SetLength(TimeSt, NrIm);
            SetLength(TiffFileList, NrIm);
            shrFact := 12 - 8; // Bit Dept - 8
            PixSettings.FileHasOwnPixSize := False;
            MovieCycleList := nil;

            CntFiles := 0;

            While Not(Eof(XMLfile)) Do
            Begin
              Readln(XMLfile, ReadStr);

              if AnsiContainsStr(ReadStr, 'Sequence absolute_time') then
              begin
                if AnsiContainsStr(ReadStr,
                  'type="TSeries Brightness Over Time') then
                begin
                  PosCnt := AnsiPos('Sequence absolute_time="', ReadStr)
                    + Length('Sequence absolute_time="');
                  for Cnt := PosCnt to Length(ReadStr) do
                  begin
                    if (ReadStr[Cnt] = '"') then
                    begin
                      NrChar := Cnt - PosCnt;
                      Break;
                    end;
                  end;
                  AbsTime := StrToFloat((AnsiMidStr(ReadStr, PosCnt, NrChar)));
                end;
                if AnsiContainsStr(ReadStr, 'type="Wait"') then
                begin
                  SetLength(MovieCycleList, High(MovieCycleList) + 2);
                  MovieCycleList[ High(MovieCycleList)] := CntFiles;
                end;
              end;

              if AnsiContainsStr(ReadStr, 'Frame relative_time="') then
              begin
                PosCnt := AnsiPos('Frame relative_time="', ReadStr) + Length
                  ('Frame relative_time="');
                for Cnt := PosCnt to Length(ReadStr) do
                begin
                  if (ReadStr[Cnt] = '"') then
                  begin
                    NrChar := Cnt - PosCnt;
                    Break;
                  end;
                end;
                TimeSt[CntFiles] := StrToFloat
                  ((AnsiMidStr(ReadStr, PosCnt, NrChar))) + AbsTime;
              end;

              if AnsiContainsStr(ReadStr, 'filename') then
              begin
                PosCnt := AnsiPos('filename="', ReadStr) + Length('filename="');
                NrChar := LastDelimiter('"', ReadStr) - PosCnt;
                TiffFileList[CntFiles] := FilePath +
                  (AnsiMidStr(ReadStr, PosCnt, NrChar));
                Inc(CntFiles);
              end;
            End; // While Not(Eof(XMLfile)) Do Begin

            AbsTime := TimeSt[0];
            for Cnt := 0 to High(TimeSt) do
              TimeSt[Cnt] := TimeSt[Cnt] - AbsTime;

            If ( High(MovieCycleList) > -1) then
            begin
              SetLength(MovieCycleList, High(MovieCycleList) + 2);
              MovieCycleList[ High(MovieCycleList)] := NrIm;
              // puts the last one
            End;
            FillMovieFrRateListAndCalcMeanImTime;

          End
          Else // If FindFirst(ReadStr,faAnyFile, SearchRec) = 0 then Begin

          Begin
            MessageDlg('No Tiff Files Have Been Found', mtError, [mbOK], 0);
          End;

          FindClose(SearchRec); // free resourses
          CloseFile(XMLfile);

End; // Procedure GetNoranPrairieXMLinfo

 {****************************************************************************}

Procedure GetND2fileInfo_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                             var BitsPerPixel: Word; var DynBarr: TDynByteArray;
                             var DynWarr: TDynWordArray; Var ValidFile: Boolean);
const
 {these are the Sizes of Blocks containing Relevant Parameters}
 SLxImageAttributes_Size   = 700;   //Size = 594 fixed for all except for Fernando is 670

var
  Cnt,CntNrIm  : Integer; // @- Cool magic number (always 0xFEED = 65261)
  hFile           : THandle;
  FPos            : UInt64; //File Pos
  StartPos        : Integer; //Position to Start Search in a Block
  ThisFileSize    : UInt64;
  ND2_FILEMAP_Pos   : UInt64; //ND2 FILEMAP SIGNATURE NAME 0001
  PosOfByteArr    : Integer;
  PartOfFile      : TDynByteArray;  //Buffer that Contains one of the Blocks Described below with Size Set by Const
  Param           : TDynByteArray;  //Parameter to search in the AttrBlockArr
  TwoChByteArr    : TDynByteArray;
  TwoChWordArr    : TDynWordArray;
  ImOffLoc        : TDynUInt64Array;
  ImageLW         : LongWord;
  pT              : Pointer;
  ReadStr         : AnsiString;
  //Local Image Parameters used for Preview to Avoid Changing Global Variables

  NrChannelsLoc      : LongWord;  //UInt32
  NrImLoc            : LongWord;  //UInt32

Begin

   ThisFileSize := GetBigFileSize(FName); // this below works with files > 4 GB in size !!!
   hFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);

   SetLength(ReadStr,31);
   pT := @ReadStr[1];
   FPos := 16;
   FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
   FileRead(hFile, pT^, 31);

   If (ReadStr = 'ND2 FILE SIGNATURE CHUNK NAME01') Then Begin

      //I Go to end and Get the offset to ND2 CHUNK MAP SIGNATURE
      FPos := ThisFileSize - 8; // One UInt64
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, ND2_FILEMAP_Pos, 8);

      //II Start Reading Paremeters
      SetLength(PartOfFile,SLxImageAttributes_Size);
      pT := @PartOfFile[0];
      FPos := ND2_FILEMAP_Pos - Length(PartOfFile);
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, pT^, Length(PartOfFile));


      StartPos := 0;
      SetLength(Param,13);
      Param[0]  := $75;
      Param[1]  := 0;
      Param[2]  := $69;
      Param[3]  := 0;
      Param[4]  := $57;
      Param[5]  := 0;
      Param[6]  := $69;
      Param[7]  := 0;
      Param[8]  := $64;
      Param[9]  := 0;
      Param[10] := $74;
      Param[11] := 0;
      Param[12] := $68;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      If (PosOfByteArr > -1) then Begin
          //All Setups Ecept Fernando which is in XTML format
          ImageWidth := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.H.e.i.g.h.t 75 00 69 00 48 00 65 00 69 00 67 00 68 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,15);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $48;
        Param[5]  := 0;
        Param[6]  := $65;
        Param[7]  := 0;
        Param[8]  := $69;
        Param[9]  := 0;
        Param[10] := $67;
        Param[11] := 0;
        Param[12] := $68;
        Param[13] := 0;
        Param[14] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then ImageHeight := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.C.o.m.p (Nr Channels) 75 00 69 00 43 00 6F 00 6D 00 70
       // RGB 14 bit file gives 2451312816 ???
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,11);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $43;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $6D;
        Param[9]  := 0;
        Param[10] := $70;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then NrChannelsLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.B.p.c.I.n.M.e.m.o.r.y  75006900  42 00 70 00 63 00 49 00 6E 00 4D    00 65 00 6D 00 6F 00 72 00 79
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,25);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $42;
        Param[5]  := 0;
        Param[6]  := $70;
        Param[7]  := 0;
        Param[8]  := $63;
        Param[9]  := 0;
        Param[10] := $49;
        Param[11] := 0;
        Param[12] := $6E;
        Param[13] := 0;
        Param[14] := $4D;
        Param[15] := 0;
        Param[16] := $65;
        Param[17] := 0;
        Param[18] := $6D;
        Param[19] := 0;
        Param[20] := $6F;
        Param[21] := 0;
        Param[22] := $72;
        Param[23] := 0;
        Param[24] := $79;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then BitsPerPixel := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.S.e.q.u.e.n.c.e.C.o.u.n.t (Nr Images)
        //75006900 53 00 65 00 71 00 75 00 65 00 6E 00 63 00 65 00 43 00 6F 00 75 00 6E 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,29);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $53;
        Param[5]  := 0;
        Param[6]  := $65;
        Param[7]  := 0;
        Param[8]  := $71;
        Param[9]  := 0;
        Param[10] := $75;
        Param[11] := 0;
        Param[12] := $65;
        Param[13] := 0;
        Param[14] := $6E;
        Param[15] := 0;
        Param[16] := $63;
        Param[17] := 0;
        Param[18] := $65;
        Param[19] := 0;
        Param[20] := $43;
        Param[21] := 0;
        Param[22] := $6F;
        Param[23] := 0;
        Param[24] := $75;
        Param[25] := 0;
        Param[26] := $6E;
        Param[27] := 0;
        Param[28] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then NrImLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
      End  //all setups ecept for Fernando Seattle v. 2.1 files
        Else
      If (PosOfByteArr = -1) then Begin //Fernando Files
        //search for uiWidth
        //Search for uiWidth 75 69 57 69 64 74 68
        StartPos := 0;
        SetLength(Param,7);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $57;
        Param[3] := $69;
        Param[4] := $64;
        Param[5] := $74;
        Param[6] := $68;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          ImageWidth := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiHeight 75  69  48  65  69  67  68  74
        SetLength(Param,8);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $48;
        Param[3] := $65;
        Param[4] := $69;
        Param[5] := $67;
        Param[6] := $68;
        Param[7] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          ImageHeight := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiComp (Nr Channels) 75 69 43 6F 6D 70
        SetLength(Param,6);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $43;
        Param[3] := $6F;
        Param[4] := $6D;
        Param[5] := $70;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          NrChannelsLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiBpcInMemory  7569  42 70 63 49 6E 4D    65 6D 6F 72 79
        SetLength(Param,13);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $42;
        Param[3]  := $70;
        Param[4]  := $63;
        Param[5] := $49;
        Param[6] := $6E;
        Param[7] := $4D;
        Param[8] := $65;
        Param[9] := $6D;
        Param[10] := $6F;
        Param[11] := $72;
        Param[12] := $79;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          BitsPerPixel := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiBpcSignificant =  //7569 42 70 63 53 69 67 6E 69 66 69 63 61 6E 74
        SetLength(Param,16);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $42;
        Param[3]  := $70;
        Param[4]  := $63;
        Param[5] := $53;
        Param[6] := $69;
        Param[7] := $67;
        Param[8] := $6E;
        Param[9] := $69;
        Param[10] := $66;
        Param[11] := $69;
        Param[12] := $63;
        Param[13] := $61;
        Param[14] := $6E;
        Param[15] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          BitsPerPixel := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiSequenceCount (Nr Images)
      //7569 53 65 71 75 65 6E 63 65 43 6F 75 6E 74

        SetLength(Param,15);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $53;
        Param[3]  := $65;
        Param[4]  := $71;
        Param[5] := $75;
        Param[6] := $65;
        Param[7] := $6E;
        Param[8] := $63;
        Param[9] := $65;
        Param[10] := $43;
        Param[11] := $6F;
        Param[12] := $75;
        Param[13] := $6E;
        Param[14] := $74;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          NrImLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

      End; //(PosOfByteArr = -1) then Begin

      SetLength(PartOfFile,ThisFileSize - ND2_FILEMAP_Pos); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ND2_FILEMAP_Pos;
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, pT^, Length(PartOfFile));

      SetLength(ImOffLoc,NrImLoc);
      StartPos := 0;
      SetLength(Param,13);
      //ImageDataSeq| = 49 6D 61 67 65 44 61 74 61 53 65 71 7C
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $44;
      Param[6]  := $61;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $53;
      Param[10] := $65;
      Param[11] := $71;
      Param[12] := $7C;

      For CntNrIm := 0 to NrImLoc Do Begin
      {one file had one more image then in u.i.S.e.q.u.e.n.c.e.C.o.u.n.t
      So I search one more image (has to be NrImLoc-1)}
        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param);
          Cnt := StartPos;
            while (PartOfFile[StartPos] <> 33) do begin //33 = '!'
              ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
              Inc(StartPos);
              SetLength(ReadStr,Length(ReadStr)+1);
            end;
              Inc(StartPos);
          FPos := pUInt64(@PartOfFile[StartPos])^ + 4096;
         end; //if (PosOfByteArr > -1) then begin
         ImOffLoc[StrToInt(ReadStr)] := FPos;
      End;//For CntNrIm := 1 to NrImLoc Do Begin

      //Lastly Display Image
      If (NrChannelsLoc = 1) Then Begin
        ValidFile := True;
        If (BitsPerPixel = 8) then Begin
          SetLength(DynBarr, ImageWidth*ImageHeight);
          FPos := ImOffLoc[0];
          pT := @DynBarr[0];
          FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
          FileRead(hFile, pT^, Length(DynBarr));
        End
          Else
        If (BitsPerPixel = 16) then Begin
          SetLength(DynWarr, ImageWidth*ImageHeight);
          FPos := ImOffLoc[0];
          pT := @DynWarr[0];
          FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
          FileRead(hFile, pT^, Length(DynWarr)*2);
        End

      End

        Else

      If (NrChannelsLoc = 2) Then Begin
        ValidFile := True;
        If (BitsPerPixel = 8) then Begin
          SetLength(TwoChByteArr, ImageWidth*ImageHeight*NrChannelsLoc);
          FPos := ImOffLoc[0];
          pT := @TwoChByteArr[0];
          FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
          FileRead(hFile, pT^, Length(TwoChByteArr));
          SetLength(DynBarr, ImageWidth*ImageHeight);
          for Cnt  := 0 to High(TwoChByteArr) do begin
            if Odd(Cnt) then DynBarr[Cnt shr 1] := TwoChByteArr[Cnt];
          end;
        End
          Else
        If (BitsPerPixel = 16) then Begin
          SetLength(TwoChWordArr, ImageWidth*ImageHeight*NrChannelsLoc);
          FPos := ImOffLoc[0];
          pT := @TwoChWordArr[0];
          FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
          FileRead(hFile, pT^, Length(TwoChWordArr)*2);
          //Extract One Channel
          SetLength(DynWarr, ImageWidth*ImageHeight);
          for Cnt  := 0 to High(TwoChWordArr) do begin
            if not(Odd(Cnt)) then DynWarr[Cnt shr 1] := TwoChWordArr[Cnt];
          end;
        End;
      End

        Else

      If (NrChannelsLoc > 2) Then Begin
        ValidFile := False;
        MessageDlg('SparkAn opens up to 2 channels movie files.  This has ' + IntToStr(NrChannelsLoc) + ' channels',mtError,[mbOK],0);
      End;



  End; // If (ReadStr = 'ND2 FILE SIGNATURE CHUNK NAME01!') then Begin


  FileClose(hFile);

End; //Procedure GetND2fileInfo_Preview


 {****************************************************************************}
Procedure GetND2fileInfo(Const FName: AnsiString; Const SilentMode: Boolean);
const
 {these are the Sizes of Blocks containing Relevant Parameters}
 ImageEventsLV_Size        = 50000;
 CustomDataVar_LUTDataV1_Size = 10000;
 ImageMetadataSeqLV_0Size  = 300;
 SLxImageAttributes_Size   = 700;
 ImageAttributesLV_Size    = 50000;
 ImageDataSeqZeroSize      = 8000;

var
  Cnt,i,CntNrIm   : Integer; // @- Cool magic number (always 0xFEED = 65261)
  hFile           : THandle;
  FPos            : UInt64; //File Pos
  StartPos        : Integer; //Position to Start Search in a Block
  ThisFileSize    : UInt64;
  ND2_FILEMAP_Pos   : UInt64; //ND2 FILEMAP SIGNATURE NAME 0001
  ImageEventsLV_Pos : UInt64;
  ImageMetadataSeqLV_Pos : UInt64;
  ImageMetadataSeq_Pos   : UInt64;
  CustomDataVarLUTDataV1_Pos : UInt64;
  ImageDataSeqZeroPos : UInt64; //used for loading colors, channel names and pix size for Fernando Seattle setup, uses XTML format
  PosOfByteArr    : Integer;
  ImageBinning    : Byte;
  PartOfFile      : TDynByteArray;  //Buffer that Contains one of the Blocks Described below with Size Set by Const
  Param           : TDynByteArray;  //Parameter to search in the AttrBlockArr
  ImOffLoc        : TDynUInt64Array;
  pT              : Pointer;
  ReadStr         : AnsiString;
  Found           : Integer; //introduced to track if Channel Color and Name was not found;  if not it loads
  ChannelColor    : TColor;

  //Local Image Parameters used for Preview to Avoid Changing Global Variables

  WidthLoc,HeightLoc : LongWord;  //UInt32
  NrChannelsLoc      : LongWord;  //UInt32
  BitCountLoc        : LongWord;  //UInt32
  BitDepthLoc        : LongWord;  //UInt32
  NrImLoc            : LongWord;  //UInt32
  ZStepLoc           : Double;
  ZHomeLoc           : Double;
  ZPosLoc            : Double;
  PixSizeLoc         : Double;
  R,G,B              : Byte;
  ColDec             : Double;

Begin

   Found := 0;

   ThisFileSize := GetBigFileSize(FName); // this below works with files > 4 GB in size !!!
   hFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);

   SetLength(ReadStr,31);
   pT := @ReadStr[1];
   FPos := 16;
   FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
   FileRead(hFile, pT^, 31);

   If (ReadStr = 'ND2 FILE SIGNATURE CHUNK NAME01') Then Begin

      //I Go to end and Get the offset to ND2 CHUNK MAP SIGNATURE
      FPos := ThisFileSize - 8; // One UInt64
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, ND2_FILEMAP_Pos, 8);

      //II Start Reading Paremeters

      SetLength(PartOfFile,SLxImageAttributes_Size);
      pT := @PartOfFile[0];
      FPos := ND2_FILEMAP_Pos - Length(PartOfFile);
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, pT^, Length(PartOfFile));

      //Search for u.i.W.i.d.t.h 75 00 69 00 57 00 69 00 64 00 74 00 68
      StartPos := 0;
      SetLength(Param,13);
      Param[0]  := $75;
      Param[1]  := 0;
      Param[2]  := $69;
      Param[3]  := 0;
      Param[4]  := $57;
      Param[5]  := 0;
      Param[6]  := $69;
      Param[7]  := 0;
      Param[8]  := $64;
      Param[9]  := 0;
      Param[10] := $74;
      Param[11] := 0;
      Param[12] := $68;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      If (PosOfByteArr > -1) then Begin
        //All Setups Ecept Fernando which is in XTML format
        WidthLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.H.e.i.g.h.t 75 00 69 00 48 00 65 00 69 00 67 00 68 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,15);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $48;
        Param[5]  := 0;
        Param[6]  := $65;
        Param[7]  := 0;
        Param[8]  := $69;
        Param[9]  := 0;
        Param[10] := $67;
        Param[11] := 0;
        Param[12] := $68;
        Param[13] := 0;
        Param[14] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then HeightLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.C.o.m.p (Nr Channels) 75 00 69 00 43 00 6F 00 6D 00 70
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,11);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $43;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $6D;
        Param[9]  := 0;
        Param[10] := $70;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then NrChannelsLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.B.p.c.I.n.M.e.m.o.r.y  75006900  42 00 70 00 63 00 49 00 6E 00 4D    00 65 00 6D 00 6F 00 72 00 79
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,25);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $42;
        Param[5]  := 0;
        Param[6]  := $70;
        Param[7]  := 0;
        Param[8]  := $63;
        Param[9]  := 0;
        Param[10] := $49;
        Param[11] := 0;
        Param[12] := $6E;
        Param[13] := 0;
        Param[14] := $4D;
        Param[15] := 0;
        Param[16] := $65;
        Param[17] := 0;
        Param[18] := $6D;
        Param[19] := 0;
        Param[20] := $6F;
        Param[21] := 0;
        Param[22] := $72;
        Param[23] := 0;
        Param[24] := $79;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then BitCountLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.B.p.c.S.i.g.n.i.f.i.c.a.n.t
        //75006900 42 00 70 00 63 00 53 00 69 00 67 00 6E 00 69 00 66 00 69 00 63 00   61 00 6E 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,31);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $42;
        Param[5]  := 0;
        Param[6]  := $70;
        Param[7]  := 0;
        Param[8]  := $63;
        Param[9]  := 0;
        Param[10] := $53;
        Param[11] := 0;
        Param[12] := $69;
        Param[13] := 0;
        Param[14] := $67;
        Param[15] := 0;
        Param[16] := $6E;
        Param[17] := 0;
        Param[18] := $69;
        Param[19] := 0;
        Param[20] := $66;
        Param[21] := 0;
        Param[22] := $69;
        Param[23] := 0;
        Param[24] := $63;
        Param[25] := 0;
        Param[26] := $61;
        Param[27] := 0;
        Param[28] := $6E;
        Param[29] := 0;
        Param[30] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then BitDepthLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.S.e.q.u.e.n.c.e.C.o.u.n.t (Nr Images)
        //75006900 53 00 65 00 71 00 75 00 65 00 6E 00 63 00 65 00 43 00 6F 00 75 00 6E 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,29);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $53;
        Param[5]  := 0;
        Param[6]  := $65;
        Param[7]  := 0;
        Param[8]  := $71;
        Param[9]  := 0;
        Param[10] := $75;
        Param[11] := 0;
        Param[12] := $65;
        Param[13] := 0;
        Param[14] := $6E;
        Param[15] := 0;
        Param[16] := $63;
        Param[17] := 0;
        Param[18] := $65;
        Param[19] := 0;
        Param[20] := $43;
        Param[21] := 0;
        Param[22] := $6F;
        Param[23] := 0;
        Param[24] := $75;
        Param[25] := 0;
        Param[26] := $6E;
        Param[27] := 0;
        Param[28] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then NrImLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
      End   //All setups except Fernando Seattle v.2.1 files; Our COBRE and Gerorge Wellman sysytems makepix v.3.0
        Else
      If (PosOfByteArr = -1) then Begin //Fernando Files
        //search for uiWidth
        //Search for uiWidth 75 69 57 69 64 74 68
        StartPos := 0;
        SetLength(Param,7);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $57;
        Param[3] := $69;
        Param[4] := $64;
        Param[5] := $74;
        Param[6] := $68;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          WidthLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiHeight 75  69  48  65  69  67  68  74
        SetLength(Param,8);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $48;
        Param[3] := $65;
        Param[4] := $69;
        Param[5] := $67;
        Param[6] := $68;
        Param[7] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          HeightLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiComp (Nr Channels) 75 69 43 6F 6D 70
        SetLength(Param,6);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $43;
        Param[3] := $6F;
        Param[4] := $6D;
        Param[5] := $70;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          NrChannelsLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiBpcInMemory  7569  42 70 63 49 6E 4D    65 6D 6F 72 79
        SetLength(Param,13);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $42;
        Param[3]  := $70;
        Param[4]  := $63;
        Param[5] := $49;
        Param[6] := $6E;
        Param[7] := $4D;
        Param[8] := $65;
        Param[9] := $6D;
        Param[10] := $6F;
        Param[11] := $72;
        Param[12] := $79;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          BitCountLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiBpcSignificant =  //7569 42 70 63 53 69 67 6E 69 66 69 63 61 6E 74
        SetLength(Param,16);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $42;
        Param[3]  := $70;
        Param[4]  := $63;
        Param[5] := $53;
        Param[6] := $69;
        Param[7] := $67;
        Param[8] := $6E;
        Param[9] := $69;
        Param[10] := $66;
        Param[11] := $69;
        Param[12] := $63;
        Param[13] := $61;
        Param[14] := $6E;
        Param[15] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          BitDepthLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiSequenceCount (Nr Images)
      //7569 53 65 71 75 65 6E 63 65 43 6F 75 6E 74

        SetLength(Param,15);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $53;
        Param[3]  := $65;
        Param[4]  := $71;
        Param[5] := $75;
        Param[6] := $65;
        Param[7] := $6E;
        Param[8] := $63;
        Param[9] := $65;
        Param[10] := $43;
        Param[11] := $6F;
        Param[12] := $75;
        Param[13] := $6E;
        Param[14] := $74;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          NrImLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

      End; //(PosOfByteArr = -1) then Begin

      //--- End with Read Parameters in S.L.x.I.m.a.g.e.A.t.t.r.i.b.u.t.e.s above ND2 FILEMAP SIGNATURE NAME Block

      //2nd.  Getting Image Data Offsets --ImageDataSeq| ----------------//
      //since the empty bytes before the end of file are from zero to ~ 3000 we read everything till the end of file minus one byte
      SetLength(PartOfFile,ThisFileSize - ND2_FILEMAP_Pos); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ND2_FILEMAP_Pos;
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, pT^, Length(PartOfFile));

       // 1st Search for ImageMetadataSeq|0! = 49 6D 61 67 65 4D 65 74 61 64 61 74 61 53 65 71 7C 30 21
      SetLength(Param,19);
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $4D;
      Param[6]  := $65;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $64;
      Param[10] := $61;
      Param[11] := $74;
      Param[12] := $61;
      Param[13] := $53;
      Param[14] := $65;
      Param[15] := $71;
      Param[16] := $7C;
      Param[17] := $30;
      Param[18] := $21;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      If (PosOfByteArr > -1) then begin ImageMetadataSeq_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^;
        ImageMetadataSeqLV_Pos := 0;// means that ImageMetadataSeq|0! was found
      End;
  
      If (PosOfByteArr = -1) then begin
    // Search for ImageMetadataSeqLV|0! = 49 6D 61 67 65 4D 65 74 61 64 61 74 61 53 65 71 4C 56 7C 30 21
    //if ImageMetadataSeq|0! was not found

      ImageMetadataSeq_Pos := 0;  //means that ImageMetadataSeq|0! was not found

      SetLength(Param,21);
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $4D;
      Param[6]  := $65;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $64;
      Param[10] := $61;
      Param[11] := $74;
      Param[12] := $61;
      Param[13] := $53;
      Param[14] := $65;
      Param[15] := $71;
      Param[16] := $4C;
      Param[17] := $56;
      Param[18] := $7C;
      Param[19] := $30;
      Param[20] := $21;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then ImageMetadataSeqLV_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^;
      End;

      {Before getting Image Offsets Prepare for Check for Zstep existance - it exist Only in Z stack files
      Find the position of ImageEventsLV! and memorize for later}
      SetLength(Param,14);
      //ImageEventsLV! = 49 6D 61 67 65     45 76 65 6E 74 73 4C 56 21
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $45;
      Param[6]  := $76;
      Param[7]  := $65;
      Param[8]  := $6E;
      Param[9]  := $74;
      Param[10] := $73;
      Param[11] := $4C;
      Param[12] := $56;
      Param[13] := $21;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then ImageEventsLV_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^
      else ImageEventsLV_Pos := 0;

      //----- Now start with image offsets ------------//

      SetLength(ImOffLoc,NrImLoc);

      StartPos := 0;
      SetLength(Param,13);
      //ImageDataSeq| = 49 6D 61 67 65 44 61 74 61 53 65 71 7C
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $44;
      Param[6]  := $61;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $53;
      Param[10] := $65;
      Param[11] := $71;
      Param[12] := $7C;

      ImageDataSeqZeroPos := 0;
      For CntNrIm := 0 to NrImLoc Do Begin
      {one file had one more image then in u.i.S.e.q.u.e.n.c.e.C.o.u.n.t
      So I search one more image (has to be NrImLoc-1)}
        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param);
          if (ImageDataSeqZeroPos < PosOfByteArr) then ImageDataSeqZeroPos := PosOfByteArr; //to get the ImageDataSeq|0! position
          Cnt := StartPos;
            while (PartOfFile[StartPos] <> 33) do begin //33 = '!'
              ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
              Inc(StartPos);
              SetLength(ReadStr,Length(ReadStr)+1);
            end;
              Inc(StartPos);
          FPos := pUInt64(@PartOfFile[StartPos])^ + 4096;
         end; //if (PosOfByteArr > -1) then begin
         ImOffLoc[StrToInt(ReadStr)] := FPos;
      End;//For CntNrIm := 1 to NrImLoc Do Begin

      ImageDataSeqZeroPos := ImageDataSeqZeroPos + ND2_FILEMAP_Pos;

      SetLength(Param,26);
      //CustomDataVar|LUTDataV1_0! = 43 75 73 74 6F 6D 44    61 74 61 56 61 72   7C 4C 55 54 44 61   74 61 56 31 5F 30 21

      Param[0]  := $43;
      Param[1]  := $75;
      Param[2]  := $73;
      Param[3]  := $74;
      Param[4]  := $6F;
      Param[5]  := $6D;
      Param[6]  := $44;

      Param[7]  := $61;
      Param[8]  := $74;
      Param[9]  := $61;
      Param[10] := $56;
      Param[11] := $61;
      Param[12] := $72;

      Param[13] := $7C;
      Param[14] := $4C;
      Param[15] := $55;
      Param[16] := $54;
      Param[17] := $44;
      Param[18] := $61;

      Param[19] := $74;
      Param[20] := $61;
      Param[21] := $56;
      Param[22] := $31;
      Param[23] := $5F;
      Param[24] := $30;
      Param[25] := $21;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then CustomDataVarLUTDataV1_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^
      else CustomDataVarLUTDataV1_Pos := 0;

      //---------- Get All Time Stamps ----------------------//

       SetLength(TimeSt,NrImLoc);
       If not(LoadStreamPixAndND2TimeSt) then Begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
        //Get 1st Time Stamp
        pT := @TimeSt[0];
        FPos := ImOffLoc[0] - 8;
        FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
        FileRead(hFile, pT^, 8);
        FirstTimeStND2 := TimeSt[0];
        //Get Last Time Stamp - needed to calculte imagetime and framerate
        pT := @TimeSt[High(TimeSt)];
        FPos := ImOffLoc[High(ImOffLoc)] - 8;
        FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
        FileRead(hFile, pT^, 8);

        TimeSt[0] := 0;
        TimeSt[High(TimeSt)] := (TimeSt[High(TimeSt)] - FirstTimeStND2)/1000; //convert ms into sec
        //Set the Time Stamps from 2nd to one before the last to -1
        for Cnt := 1 to High(TimeSt) - 1 do TimeSt[Cnt] := -1;
      End
        Else
      Begin
        For Cnt := 0 to High(ImOffLoc) do Begin
          if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
          end;
          if (frmProgress.ImageProgressBar.Max <> High(ImOffLoc)) then
              frmProgress.ImageProgressBar.Max := High(ImOffLoc);

          frmProgress.lbProgress.Caption := IntToStr(High(ImOffLoc) + 1) + ' (' + IntToStr(Cnt) + ')';
          frmProgress.ImageProgressBar.Position := Cnt;
          Application.ProcessMessages;

          FPos := ImOffLoc[Cnt] - 8;
          pT := @TimeSt[Cnt];
          FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
          FileRead(hFile, pT^, 8);
        End;
        for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := (TimeSt[Cnt] - TimeSt[0])/1000;   //convert ms into sec
        TimeSt[0] := 0;
      End; //Else Begin

      BitCount := BitCountLoc; //needed for Preview
      imXSize   := WidthLoc;    //needed for Preview
      imYSize  := HeightLoc;   //needed for Preview

      MovieSeriesType := TimeSeries;

      {3rd.  Check if this is a Zstack}
   If (ImageEventsLV_Pos > 0) Then Begin
      {the Fernando Setup might produce ASCII values but I don't have a zstack and this setup does not have a Z motor}
      SetLength(PartOfFile,ImageEventsLV_Size); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ImageEventsLV_Pos - ImageEventsLV_Size;
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, pT^, Length(PartOfFile));

      SetLength(Param,11);
      //d.Z.S.t.e.p =  64 00 5A 00 53 00 74 00 65 00 70
      Param[0]  := $64;
      Param[1]  := 0;
      Param[2]  := $5A;
      Param[3]  := 0;
      Param[4]  := $53;
      Param[5]  := 0;
      Param[6]  := $74;
      Param[7]  := 0;
      Param[8]  := $65;
      Param[9]  := 0;
      Param[10] := $70;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      If (PosOfByteArr > -1) then Begin
        MovieSeriesType := Z_Stack;
        {this is Zstack file: find d.Z.H.o.m.e and d.Z.P.o.s.i.t.i.o.n.0}
        ZStepLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        SetLength(Param,11);
        //d.Z.H.o.m.e = 64 00 5A 00 48 00 6F 00 6D 00 65
       // d.Z.H.o.m.e is 68 bytes before beg of d.Z.S.t.e.p
        Param[0]  := $64;
        Param[1]  := 0;
        Param[2]  := $5A;
        Param[3]  := 0;
        Param[4]  := $48;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $6D;
        Param[9]  := 0;
        Param[10] := $65;

        StartPos := PosOfByteArr - 100;
        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          ZHomeLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
        end;
       End; // MovieSeriesType := Z_Stack;  If (PosOfByteArr > -1) then Begin
     End; //  If (ImageEventsLV_Pos > 0) Then Begin
        {d.Z.P.o.s.i.t.i.o.n.0 is Contained in  S.L.x.P.i.c.t.u.r.e.M.e.t.a.d.a.t.a-ImageAttributesLV!
         located 4062 bytes before the end of ImageDataSeq|0!  pointed by ND2 FILEMAP SIGNATURE NAME}

        SetLength(PartOfFile,ImageAttributesLV_Size); //reads till the end of file minus one byte
        pT := @PartOfFile[0];
        if (ImOffLoc[0] >=ImageAttributesLV_Size) then
          FPos := ImOffLoc[0] - ImageAttributesLV_Size else
          FPos := 0;
        FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
        FileRead(hFile, pT^, Length(PartOfFile));

         //find Color of channels
        SetLength(Param,14);
        //  C.o.l.o.r...      = 03 06 43 00 6F 00 6C 00 6F 00 72 00 00 00

        Param[0]  := $03;
        Param[1]  := $06;
        Param[2]  := $43;
        Param[3]  := 0;
        Param[4]  := $6F;
        Param[5]  := 0;
        Param[6]  := $6C;
        Param[7]  := 0;
        Param[8]  := $6F;
        Param[9]  := 0;
        Param[10] := $72;
        Param[11] := 0;
        Param[12] := 0;
        Param[13] := 0;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin
          Found := Found + 3; //Ch Color + Name found
          //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
          i := 0;
          R := 1;
          ScopeSystemParams.Ch1_Name := '';
          while (R <> 6)  do begin
            R := PartOfFile[PosOfByteArr+Length(Param)+16+i];
            if not(R in[0,6]) then ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(R);
            Inc(i);
          end;

          //Get Color of Channes
          R := PartOfFile[PosOfByteArr+Length(Param)];
          G := PartOfFile[PosOfByteArr+Length(Param)+1];
          B := PartOfFile[PosOfByteArr+Length(Param)+2];

          frmImageControl.ubFileColTable.Tag := NrChannelsLoc;
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch1[i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch1[i] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch1[256+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch1[256+i] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch1[512+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
            FileColorTBL_Ch1[512+i] := 0;


        If (NrChannelsLoc = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr+Length(Param),Param,PartOfFile); //Gives Position of Param in the PartOfFile
         If (PosOfByteArr > -1) then Begin
             //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
            i := 0;
            R := 1;
            ScopeSystemParams.Ch2_Name := '';
            while (R <> 6)  do begin
              R := PartOfFile[PosOfByteArr+Length(Param)+16+i];
              if not(R in[0,6]) then ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(R);
              Inc(i);
            end;
            //get channel colors
              R := PartOfFile[PosOfByteArr+Length(Param)];
              G := PartOfFile[PosOfByteArr+Length(Param)+1];
              B := PartOfFile[PosOfByteArr+Length(Param)+2];
              if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
          if (R > 0) then begin
            ColDec := R/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch2[i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch2[i] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch2[256+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch2[256+i] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch2[512+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
            FileColorTBL_Ch2[512+i] := 0;
          End;  ////if (PosOfByteArr > -1) then begin = String Found
        End; // If (NrChannelsLoc = 2) then Begin
       End;  // Searching for 1st Color (if (PosOfByteArr > -1) then begin = String Found )
         //--- End of Getting Colors & tables ----------//


      If (MovieSeriesType = Z_Stack) then Begin
        SetLength(Param,21);
        //d.Z.P.o.s.i.t.i.o.n.0 = 64 00 5A    00 50 00 6F 00 73 00 69 00 74 00 69 00 6F 00 6E 00 30

        Param[0]  := $64;
        Param[1]  := 0;
        Param[2]  := $5A;
        Param[3]  := 0;
        Param[4]  := $50;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $73;
        Param[9]  := 0;
        Param[10] := $69;
        Param[11] := 0;
        Param[12] := $74;
        Param[13] := 0;
        Param[14] := $69;
        Param[15] := 0;
        Param[16] := $6F;
        Param[17] := 0;
        Param[18] := $6E;
        Param[19] := 0;
        Param[20] := $30;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then ZPosLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

      End; // If (MovieSeriesType = Z_Stack) then Begin  = This is Z stack movie

      SetLength(PartOfFile,ImageMetadataSeqLV_0Size);
      pT := @PartOfFile[0];
      if (ImageMetadataSeq_Pos = 0) then
         {case with COBRE Andor setup Files (v.3.0)}
        FPos := ImageMetadataSeqLV_Pos - ImageMetadataSeqLV_0Size
          else
      if (ImageMetadataSeqLV_Pos = 0) then
         {case with Rachael TIRF setup Files (v.3.0)}
        FPos := ImageMetadataSeq_Pos - ImageMetadataSeqLV_0Size;
      FileSeek(hFile, FPos,0);
      FileRead(hFile, pT^, Length(PartOfFile));

      SetLength(Param,23);
      //find d.C.a.l.i.b.r.a.t.i.o.n = 64 00 43 00 61 00 6C 00 69 00 62 00 72 00 61 00 74 00 69 00 6F 00 6E
      Param[0]  := $64;
      Param[1]  := 0;
      Param[2]  := $43;
      Param[3]  := 0;
      Param[4]  := $61;
      Param[5]  := 0;
      Param[6]  := $6C;
      Param[7]  := 0;
      Param[8]  := $69;
      Param[9]  := 0;
      Param[10] := $62;
      Param[11] := 0;
      Param[12] := $72;
      Param[13] := 0;
      Param[14] := $61;
      Param[15] := 0;
      Param[16] := $74;
      Param[17] := 0;
      Param[18] := $69;
      Param[19] := 0;
      Param[20] := $6F;
      Param[21] := 0;
      Param[22] := $6E;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then begin
        PixSizeLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
      end
        else
      begin
      {case with Fernando Seattle Files (v.2.1)}
       SetLength(Param,12);
      {find dCalibration runtype="double" value=" number in ASCII follows It is enogh to search for dCalibration
      dCalibration = 64 43 61 6C 69     62 72 61 74 69     6F 6E}
      Param[0]  := $64;
      Param[1]  := $43;
      Param[2]  := $61;
      Param[3]  := $6C;
      Param[4]  := $69;
      Param[5]  := $62;
      Param[6]  := $72;
      Param[7]  := $61;
      Param[8]  := $74;
      Param[9]  := $69;
      Param[10] := $6F;
      Param[11] := $6E;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      if (PosOfByteArr > -1) then begin
        ReadStr := '';
        StartPos := PosOfByteArr + Length(Param) + 25;
        while (AnsiChar(PartOfFile[StartPos]) in DigitsFlt) do begin
          ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
          Inc(StartPos);
        end;
          PixSizeLoc := StrToFloat(ReadStr);
        end;
      end;

      //CustomDataVar_LUTDataV1_Size
     If (CustomDataVarLUTDataV1_Pos > 0) Then Begin

      SetLength(PartOfFile,CustomDataVar_LUTDataV1_Size); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := CustomDataVarLUTDataV1_Pos - CustomDataVar_LUTDataV1_Size;
      FileSeek(hFile, FPos,0);
      FileRead(hFile, pT^, Length(PartOfFile));

      SetLength(Param,18);

      PixSettings.ImageBinning := 0; //if remains 0 then Binning was no recorded in file

      Param[0]  := $42;
      Param[1]  := 0;
      Param[2]  := $69;
      Param[3]  := 0;
      Param[4]  := $6E;
      Param[5]  := 0;
      Param[6]  := $6E;
      Param[7]  := 0;
      Param[8]  := $69;
      Param[9]  := 0;
      Param[10] := $6E;
      Param[11] := 0;
      Param[12] := $67;
      Param[13] := 0;
      Param[14] := $3A;
      Param[15] := 0;
      Param[16] := $20;
      Param[17] := 0;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then begin
        PixSettings.ImageBinning := StrToInt(AnsiChar(PartOfFile[PosOfByteArr+Length(Param)]));
      end
        else
      begin

        SetLength(Param,9);
        // Binning:  = 42 69 6E 6E 69 6E 67 3A 20
        Param[0] := $42;
        Param[1] := $69;
        Param[2] := $6E;
        Param[3] := $6E;
        Param[4] := $69;
        Param[5] := $6E;
        Param[6] := $67;
        Param[7] := $3A;
        Param[8] := $20;
        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          PixSettings.ImageBinning := StrToInt(AnsiChar(PartOfFile[PosOfByteArr+Length(Param)]));
        end
          else
        begin
          SetLength(PartOfFile,11000); //reads till the end of file minus one byte
          pT := @PartOfFile[0];
          FPos := ImOffLoc[0] - 4096 - Length(PartOfFile);
          FileSeek(hFile, FPos,0);
          FileRead(hFile, pT^, Length(PartOfFile));
          PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
          if (PosOfByteArr > -1) then begin
            PixSettings.ImageBinning := StrToInt(AnsiChar(PartOfFile[PosOfByteArr+Length(Param)]));
          end
            else
          PixSettings.ImageBinning := 1;
        end;
      end; //else begin for Fernando  files
    End; // If (CustomDataVarLUTDataV1_Pos > 0) Then Begin

      imXsize    := WidthLoc;
      imYsize    := HeightLoc;
      NrChannels := NrChannelsLoc;
      NrIm       := NrImLoc;
      ImagePix   := imXsize * imYsize; { Number of Pixels in Bitmap }
      ImageBytes := ImagePix * (BitCount div 8)*NrChannels; { in bytes }

      SetLength(ImOff,1,NrIm); //always because the channels are interlaced
      for Cnt := 0 to High(ImOffLoc) do ImOff[0,Cnt] := ImOffLoc[Cnt];

      if (MovieSeriesType = Z_Stack) then begin
        ZstackUnits := ' µm';
        if (Length(ZstackArr) <> NrIm) then SetLength(ZstackArr,NrIm);
        for Cnt := 0 to High(ZstackArr) do  ZstackArr[Cnt] := 0;
        if (ZPosLoc < ZHomeLoc) then begin
          for Cnt := 1 to High(ZstackArr) do begin
            ZstackArr[Cnt] := ZstackArr[Cnt-1] + ZStepLoc;
          end;
        end
          else
        if (ZPosLoc > ZHomeLoc) then begin
          for Cnt := 1 to High(ZstackArr) do begin
            ZstackArr[Cnt] := ZstackArr[Cnt-1] - ZStepLoc;
          end;
        end;
      end;

      if (NrIm > 1) then begin
       MeanImTime := TimeSt[High(TimeSt)] / (NrIm - 1);
      // used for Table , Export MPEG etc
       ExportDial.OrigFrameRate := (NrIm - 1) / TimeSt[High(TimeSt)];
      end;

      if (PixSizeLoc = 0) then begin
        PixSettings.FileHasOwnPixSize := False;
      end
        else                             //ImageBinning
      begin
        PixSettings.FileHasOwnPixSize := True;
        PixSettings.FilePixSize := PixSizeLoc;
      end;

      ToSwap := False;
      shrFact := BitDepthLoc - 8;

    If (Found < 3) Then Begin

      FPos := ImageDataSeqZeroPos + 15;
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, ImageDataSeqZeroPos, 8);

      SetLength(PartOfFile,ImageDataSeqZeroSize); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ImageDataSeqZeroPos - ImageDataSeqZeroSize;
      FileSeek(hFile, FPos,0); // 0 = Origin = Begining of File
      FileRead(hFile, pT^, Length(PartOfFile));

        SetLength(Param,36);
        //3C 75 69 43 6F
        Param[0]  := $3C;
        Param[1]  := $75;
        Param[2]  := $69;
        Param[3]  := $43;
        Param[4]  := $6F;

        //6C 6F 72 20 72
        Param[5]  := $6C;
        Param[6]  := $6F;
        Param[7]  := $72;
        Param[8]  := $20;
        Param[9]  := $72;

        //75 6E 74 79 70
        Param[10] := $75;
        Param[11] := $6E;
        Param[12] := $74;
        Param[13] := $79;
        Param[14] := $70;

        //65 3D 22 6C 78
        Param[15] := $65;
        Param[16] := $3D;
        Param[17] := $22;
        Param[18] := $6C;
        Param[19] := $78;

        //5F 75 69 6E 74
        Param[20] := $5F;
        Param[21] := $75;
        Param[22] := $69;
        Param[23] := $6E;
        Param[24] := $74;

        //33 32 22 20 76
        Param[25] := $33;
        Param[26] := $32;
        Param[27] := $22;
        Param[28] := $20;
        Param[29] := $76;

        //61 6C 75 65 3D 22
        Param[30] := $61;
        Param[31] := $6C;
        Param[32] := $75;
        Param[33] := $65;
        Param[34] := $3D;
        Param[35] := $22;


        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin
          ReadStr := '';
          StartPos := PosOfByteArr + Length(Param);//
          while (AnsiChar(PartOfFile[StartPos]) in DigitsFlt) do begin
            ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
          end;

            ChannelColor := StrToInt(ReadStr);
            R := GetRValue(ChannelColor);
            G := GetGValue(ChannelColor);
            B := GetBValue(ChannelColor);

          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch1[i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch1[i] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch1[256+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch1[256+i] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch1[512+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
            FileColorTBL_Ch1[512+i] := 0;

          //find Channel Name

          //Find Color for the 2nd Channel
          If (NrChannels = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr + Length(Param),Param,PartOfFile); //Gives Position of Param in the PartOfFile
            If (PosOfByteArr > -1) then Begin
              ReadStr := '';
              StartPos := PosOfByteArr + Length(Param);//
              while (AnsiChar(PartOfFile[StartPos]) in DigitsFlt) do begin
                ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
                Inc(StartPos);
              end;

              ChannelColor := StrToInt(ReadStr);
              R := GetRValue(ChannelColor);
              G := GetGValue(ChannelColor);
              B := GetBValue(ChannelColor);

              if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
          if (R > 0) then begin
            ColDec := R/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch2[i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch2[i] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch2[256+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL_Ch2[256+i] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for i := 0 to 255 do begin
              FileColorTBL_Ch2[512+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
            FileColorTBL_Ch2[512+i] := 0;

            End; // 2nd Channel; If (PosOfByteArr > -1) then Begin

          End;  //If (NrChannels = 2) then Begin

          frmImageControl.ubFileColTable.Tag := NrChannels;
        End; // Ch1 Color = End of Colors; If (PosOfByteArr > -1) then Begin

         //Channel Name

        SetLength(Param,41);

        //73 44 65 73 63
        Param[0]  := $73;
        Param[1]  := $44;
        Param[2]  := $65;
        Param[3]  := $73;
        Param[4]  := $63;

        //72 69 70 74 69
        Param[5]  := $72;
        Param[6]  := $69;
        Param[7]  := $70;
        Param[8]  := $74;
        Param[9]  := $69;

        //6F 6E 20 72 75
        Param[10] := $6F;
        Param[11] := $6E;
        Param[12] := $20;
        Param[13] := $72;
        Param[14] := $75;

        //6E 74 79 70 65
        Param[15] := $6E;
        Param[16] := $74;
        Param[17] := $79;
        Param[18] := $70;
        Param[19] := $65;

        //3D 22 43 4C 78
        Param[20] := $3D;
        Param[21] := $22;
        Param[22] := $43;
        Param[23] := $4C;
        Param[24] := $78;

        //53 74 72 69 6E
        Param[25] := $53;
        Param[26] := $74;
        Param[27] := $72;
        Param[28] := $69;
        Param[29] := $6E;

        //67 57 22 20 76
        Param[30] := $67;
        Param[31] := $57;
        Param[32] := $22;
        Param[33] := $20;
        Param[34] := $76;

        //61 6C 75 65 3D 22
        Param[35] := $61;
        Param[36] := $6C;
        Param[37] := $75;
        Param[38] := $65;
        Param[39] := $3D;
        Param[40] := $22;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin
          ReadStr := '';
          StartPos := PosOfByteArr + Length(Param);//
          while (PartOfFile[StartPos] <> 34) do begin
            ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
          end;
          ScopeSystemParams.Ch1_Name := ReadStr;

          If (NrChannels = 2) then Begin  //was never tested I don't have 2 channel mobies
            PosOfByteArr := BytePos(PosOfByteArr + Length(Param),Param,PartOfFile); //
            If (PosOfByteArr > -1) then Begin
              ReadStr := '';
              StartPos := PosOfByteArr + Length(Param);//
              while (PartOfFile[StartPos] <> 34) do begin
                ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
                Inc(StartPos);
              end;
              ScopeSystemParams.Ch2_Name := ReadStr;
            End;
          End; //2nd channel
        End; //1st channel; If (PosOfByteArr > -1) then Begin

    End; //If (Found < 3) Then Begin

    //---End of - Now if Channel Color or Name were no found (Fernando Seattle files) -----//

      if (frmProgress <> nil) then frmProgress.Close;

  End; // If (ReadStr = 'ND2 FILE SIGNATURE CHUNK NAME01!') then Begin


  FileClose(hFile);

End; //Procedure GetND2fileInfo(Const FName: AnsiString; Const SilentMode: Boolean);
{****************************************************************************}

Procedure GetND2fileInfoFromRAM(const pRawData : pByteArr; Const SilentMode: Boolean);
const
 {these are the Sizes of Blocks containing Relevant Parameters}
 ImageEventsLV_Size        = 50000;
 CustomDataVar_LUTDataV1_Size = 10000;
 ImageMetadataSeqLV_0Size  = 300;
 SLxImageAttributes_Size   = 700;
 ImageAttributesLV_Size    = 50000;
 ImageDataSeqZeroSize      = 8000;

var
  Cnt,i,CntNrIm     : Integer; // @- Cool magic number (always 0xFEED = 65261)
  FPos            : UInt64; //File Pos
  StartPos        : Integer; //Position to Start Search in a Block
  ND2_FILEMAP_Pos   : UInt64; //ND2 FILEMAP SIGNATURE NAME 0001
  ImageEventsLV_Pos : UInt64;
  ImageMetadataSeqLV_Pos : UInt64;
  ImageMetadataSeq_Pos   : UInt64;
  CustomDataVarLUTDataV1_Pos : UInt64;
  ImageDataSeqZeroPos : UInt64; //used for loading colors, channel names and pix size for Fernando Seattle setup, uses XTML format
  ImageCalibrationLV_Pos : UInt64;  // //v. 3.0 uses it for loading colors, channel names (of ImageCalibrationLV|0! )
  PosOfByteArr    : Integer;
  ImageBinning    : Byte;
  PartOfFile      : TDynByteArray;  //Buffer that Contains one of the Blocks Described below with Size Set by Const
  Param           : TDynByteArray;  //Parameter to search in the AttrBlockArr
  ImOffLoc        : TDynUInt64Array;
  pT              : Pointer;
  ReadStr         : AnsiString;
  Found           : Integer; //introduced to track if Channel Color and Name was not found;  if not it loads
  ChannelColor    : TColor;

  //Local Image Parameters used for Preview to Avoid Changing Global Variables
  WidthLoc,HeightLoc : LongWord;  //UInt32
  NrChannelsLoc      : LongWord;  //UInt32
  BitCountLoc        : LongWord;  //UInt32
  BitDepthLoc        : LongWord;  //UInt32
  NrImLoc            : LongWord;  //UInt32
  ZStepLoc           : Double;
  ZHomeLoc           : Double;
  ZPosLoc            : Double;
  PixSizeLoc         : Double;
  R,G,B              : Byte;


      procedure FillColorTables(const FileColorTBL : TDynByteArray);
      var i     : integer;
          ColDec: Double;
      begin
          if (R > 0) then begin
            ColDec := R/255;
            for i := 0 to 255 do begin
              FileColorTBL[i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL[i] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for i := 0 to 255 do begin
              FileColorTBL[256+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
              FileColorTBL[256+i] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for i := 0 to 255 do begin
              FileColorTBL[512+i] := round(ColDec*i);
            end;
          end
            else
          for i := 0 to 255 do
            FileColorTBL[512+i] := 0;
      end; //procedure FillColorTables(const FileColorTBL : TDynByteArray);

Begin

   Found := 0;

   SetLength(ReadStr,31);
   pT := @ReadStr[1];
   FPos := 16;
   Move(pRawData[FPos],pT^, 31);


   If (ReadStr = 'ND2 FILE SIGNATURE CHUNK NAME01') Then Begin

      FPos := Length(RawDataInRAM[0]) - 8;
      ND2_FILEMAP_Pos := pUInt64(@pRawData[FPos])^;

      //II Start Reading Paremeters

      SetLength(PartOfFile,SLxImageAttributes_Size);
      pT := @PartOfFile[0];
      FPos := ND2_FILEMAP_Pos - Length(PartOfFile);
      Move(pRawData[FPos],pT^, Length(PartOfFile));

      //Search for u.i.W.i.d.t.h 75 00 69 00 57 00 69 00 64 00 74 00 68
      StartPos := 0;
      SetLength(Param,13);
      Param[0]  := $75;
      Param[1]  := 0;
      Param[2]  := $69;
      Param[3]  := 0;
      Param[4]  := $57;
      Param[5]  := 0;
      Param[6]  := $69;
      Param[7]  := 0;
      Param[8]  := $64;
      Param[9]  := 0;
      Param[10] := $74;
      Param[11] := 0;
      Param[12] := $68;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      If (PosOfByteArr > -1) then Begin

        WidthLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.H.e.i.g.h.t 75 00 69 00 48 00 65 00 69 00 67 00 68 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,15);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $48;
        Param[5]  := 0;
        Param[6]  := $65;
        Param[7]  := 0;
        Param[8]  := $69;
        Param[9]  := 0;
        Param[10] := $67;
        Param[11] := 0;
        Param[12] := $68;
        Param[13] := 0;
        Param[14] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then HeightLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.C.o.m.p (Nr Channels) 75 00 69 00 43 00 6F 00 6D 00 70  7500690043006F006D0070
       // RGB 14 bit file gives 2451312816 ???
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,11);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $43;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $6D;
        Param[9]  := 0;
        Param[10] := $70;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then NrChannelsLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.B.p.c.I.n.M.e.m.o.r.y  75006900  42 00 70 00 63 00 49 00 6E 00 4D    00 65 00 6D 00 6F 00 72 00 79
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,25);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $42;
        Param[5]  := 0;
        Param[6]  := $70;
        Param[7]  := 0;
        Param[8]  := $63;
        Param[9]  := 0;
        Param[10] := $49;
        Param[11] := 0;
        Param[12] := $6E;
        Param[13] := 0;
        Param[14] := $4D;
        Param[15] := 0;
        Param[16] := $65;
        Param[17] := 0;
        Param[18] := $6D;
        Param[19] := 0;
        Param[20] := $6F;
        Param[21] := 0;
        Param[22] := $72;
        Param[23] := 0;
        Param[24] := $79;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then BitCountLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.B.p.c.S.i.g.n.i.f.i.c.a.n.t
        //75006900 42 00 70 00 63 00 53 00 69 00 67 00 6E 00 69 00 66 00 69 00 63 00   61 00 6E 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,31);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $42;
        Param[5]  := 0;
        Param[6]  := $70;
        Param[7]  := 0;
        Param[8]  := $63;
        Param[9]  := 0;
        Param[10] := $53;
        Param[11] := 0;
        Param[12] := $69;
        Param[13] := 0;
        Param[14] := $67;
        Param[15] := 0;
        Param[16] := $6E;
        Param[17] := 0;
        Param[18] := $69;
        Param[19] := 0;
        Param[20] := $66;
        Param[21] := 0;
        Param[22] := $69;
        Param[23] := 0;
        Param[24] := $63;
        Param[25] := 0;
        Param[26] := $61;
        Param[27] := 0;
        Param[28] := $6E;
        Param[29] := 0;
        Param[30] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then BitDepthLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        //Search for u.i.S.e.q.u.e.n.c.e.C.o.u.n.t (Nr Images)
        //75006900 53 00 65 00 71 00 75 00 65 00 6E 00 63 00 65 00 43 00 6F 00 75 00 6E 00 74
        Inc(StartPos,Length(Param)+3);
        SetLength(Param,29);
        Param[0]  := $75;
        Param[1]  := 0;
        Param[2]  := $69;
        Param[3]  := 0;
        Param[4]  := $53;
        Param[5]  := 0;
        Param[6]  := $65;
        Param[7]  := 0;
        Param[8]  := $71;
        Param[9]  := 0;
        Param[10] := $75;
        Param[11] := 0;
        Param[12] := $65;
        Param[13] := 0;
        Param[14] := $6E;
        Param[15] := 0;
        Param[16] := $63;
        Param[17] := 0;
        Param[18] := $65;
        Param[19] := 0;
        Param[20] := $43;
        Param[21] := 0;
        Param[22] := $6F;
        Param[23] := 0;
        Param[24] := $75;
        Param[25] := 0;
        Param[26] := $6E;
        Param[27] := 0;
        Param[28] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then NrImLoc := pLongWord(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
      End
        Else
      If (PosOfByteArr = -1) then Begin
        //search for uiWidth
        //Search for uiWidth 75 69 57 69 64 74 68
        StartPos := 0;
        SetLength(Param,7);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $57;
        Param[3] := $69;
        Param[4] := $64;
        Param[5] := $74;
        Param[6] := $68;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          WidthLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiHeight 75  69  48  65  69  67  68  74
        SetLength(Param,8);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $48;
        Param[3] := $65;
        Param[4] := $69;
        Param[5] := $67;
        Param[6] := $68;
        Param[7] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          HeightLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiComp (Nr Channels) 75 69 43 6F 6D 70
        SetLength(Param,6);
        Param[0] := $75;
        Param[1] := $69;
        Param[2] := $43;
        Param[3] := $6F;
        Param[4] := $6D;
        Param[5] := $70;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          NrChannelsLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiBpcInMemory  7569  42 70 63 49 6E 4D    65 6D 6F 72 79
        SetLength(Param,13);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $42;
        Param[3]  := $70;
        Param[4]  := $63;
        Param[5] := $49;
        Param[6] := $6E;
        Param[7] := $4D;
        Param[8] := $65;
        Param[9] := $6D;
        Param[10] := $6F;
        Param[11] := $72;
        Param[12] := $79;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          BitCountLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiBpcSignificant =  //7569 42 70 63 53 69 67 6E 69 66 69 63 61 6E 74
        SetLength(Param,16);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $42;
        Param[3]  := $70;
        Param[4]  := $63;
        Param[5] := $53;
        Param[6] := $69;
        Param[7] := $67;
        Param[8] := $6E;
        Param[9] := $69;
        Param[10] := $66;
        Param[11] := $69;
        Param[12] := $63;
        Param[13] := $61;
        Param[14] := $6E;
        Param[15] := $74;

        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          BitDepthLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

        //Search for uiSequenceCount (Nr Images)
      //7569 53 65 71 75 65 6E 63 65 43 6F 75 6E 74

        SetLength(Param,15);
        Param[0]  := $75;
        Param[1]  := $69;
        Param[2]  := $53;
        Param[3]  := $65;
        Param[4]  := $71;
        Param[5] := $75;
        Param[6] := $65;
        Param[7] := $6E;
        Param[8] := $63;
        Param[9] := $65;
        Param[10] := $43;
        Param[11] := $6F;
        Param[12] := $75;
        Param[13] := $6E;
        Param[14] := $74;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param) + 28;
          Cnt := StartPos;
          while (PartOfFile[StartPos] <> 34) do begin  //34 = '"'
            ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
            SetLength(ReadStr,Length(ReadStr)+1);
          end;
          NrImLoc := StrToInt(ReadStr);
        end; //if (PosOfByteArr > -1) then begin

      End; //(PosOfByteArr = -1) then Begin

      SetLength(PartOfFile,Length(RawDataInRAM[0]) - ND2_FILEMAP_Pos); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ND2_FILEMAP_Pos;
      Move(pRawData[FPos],pT^, Length(PartOfFile));

       // 1st Search for ImageMetadataSeq|0! = 49 6D 61 67 65 4D 65 74 61 64 61 74 61 53 65 71 7C 30 21
      SetLength(Param,19);
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $4D;
      Param[6]  := $65;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $64;
      Param[10] := $61;
      Param[11] := $74;
      Param[12] := $61;
      Param[13] := $53;
      Param[14] := $65;
      Param[15] := $71;
      Param[16] := $7C;
      Param[17] := $30;
      Param[18] := $21;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      If (PosOfByteArr > -1) then begin ImageMetadataSeq_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^;
        ImageMetadataSeqLV_Pos := 0;// means that ImageMetadataSeq|0! was found
      End;

      If (PosOfByteArr = -1) then begin
    // Search for ImageMetadataSeqLV|0! = 49 6D 61 67 65 4D 65 74 61 64 61 74 61 53 65 71 4C 56 7C 30 21
    //if ImageMetadataSeq|0! was not found

      ImageMetadataSeq_Pos := 0;  //means that ImageMetadataSeq|0! was not found

      SetLength(Param,21);
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $4D;
      Param[6]  := $65;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $64;
      Param[10] := $61;
      Param[11] := $74;
      Param[12] := $61;
      Param[13] := $53;
      Param[14] := $65;
      Param[15] := $71;
      Param[16] := $4C;
      Param[17] := $56;
      Param[18] := $7C;
      Param[19] := $30;
      Param[20] := $21;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then ImageMetadataSeqLV_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^;
      End; // If (PosOfByteArr = -1) then begin

      {Before getting Image Offsets Prepare for Check for Zstep existance - it exist Only in Z stack files
      Find the position of ImageEventsLV! and memorize for later}
      SetLength(Param,14);
      //ImageEventsLV! = 49 6D 61 67 65     45 76 65 6E 74 73 4C 56 21
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $45;
      Param[6]  := $76;
      Param[7]  := $65;
      Param[8]  := $6E;
      Param[9]  := $74;
      Param[10] := $73;
      Param[11] := $4C;
      Param[12] := $56;
      Param[13] := $21;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then ImageEventsLV_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^
      else ImageEventsLV_Pos := 0;

      //----- Now start with image offsets ------------//

      SetLength(ImOffLoc,NrImLoc);

      StartPos := 0;
      SetLength(Param,13);
      //ImageDataSeq| = 49 6D 61 67 65 44 61 74 61 53 65 71 7C
      Param[0]  := $49;
      Param[1]  := $6D;
      Param[2]  := $61;
      Param[3]  := $67;
      Param[4]  := $65;
      Param[5]  := $44;
      Param[6]  := $61;
      Param[7]  := $74;
      Param[8]  := $61;
      Param[9]  := $53;
      Param[10] := $65;
      Param[11] := $71;
      Param[12] := $7C;

      ImageDataSeqZeroPos := 0;
      For CntNrIm := 0 to NrImLoc Do Begin
      {one file had one more image then in u.i.S.e.q.u.e.n.c.e.C.o.u.n.t
      So I search one more image (has to be NrImLoc-1)}
        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          SetLength(ReadStr,1);
          StartPos := PosOfByteArr + Length(Param);
          if (ImageDataSeqZeroPos < PosOfByteArr) then ImageDataSeqZeroPos := PosOfByteArr; //to get the ImageDataSeq|0! position
          Cnt := StartPos;
            while (PartOfFile[StartPos] <> 33) do begin //33 = '!'
              ReadStr[StartPos-Cnt+1] := AnsiChar(PartOfFile[StartPos]);
              Inc(StartPos);
              SetLength(ReadStr,Length(ReadStr)+1);
            end;
              Inc(StartPos);
          FPos := pUInt64(@PartOfFile[StartPos])^ + 4096;
         end; //if (PosOfByteArr > -1) then begin
         ImOffLoc[StrToInt(ReadStr)] := FPos;
      End;//For CntNrIm := 1 to NrImLoc Do Begin

      ImageDataSeqZeroPos := ImageDataSeqZeroPos + ND2_FILEMAP_Pos;

      SetLength(Param,26);
      //CustomDataVar|LUTDataV1_0! = 43 75 73 74 6F 6D 44    61 74 61 56 61 72   7C 4C 55 54 44 61   74 61 56 31 5F 30 21
      Param[0]  := $43;
      Param[1]  := $75;
      Param[2]  := $73;
      Param[3]  := $74;
      Param[4]  := $6F;
      Param[5]  := $6D;
      Param[6]  := $44;
      Param[7]  := $61;
      Param[8]  := $74;
      Param[9]  := $61;
      Param[10] := $56;
      Param[11] := $61;
      Param[12] := $72;
      Param[13] := $7C;
      Param[14] := $4C;
      Param[15] := $55;
      Param[16] := $54;
      Param[17] := $44;
      Param[18] := $61;
      Param[19] := $74;
      Param[20] := $61;
      Param[21] := $56;
      Param[22] := $31;
      Param[23] := $5F;
      Param[24] := $30;
      Param[25] := $21;

      PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then CustomDataVarLUTDataV1_Pos := pUInt64(@PartOfFile[PosOfByteArr+Length(Param)])^
      else CustomDataVarLUTDataV1_Pos := 0;

      //---------- Get All Time Stamps ----------------------//

      SetLength(TimeSt,NrImLoc);
      For Cnt := 0 to High(ImOffLoc) do Begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
        if (frmProgress.ImageProgressBar.Max <> High(ImOffLoc)) then
            frmProgress.ImageProgressBar.Max := High(ImOffLoc);

        frmProgress.lbProgress.Caption := IntToStr(High(ImOffLoc) + 1) + ' (' + IntToStr(Cnt) + ')';
        frmProgress.ImageProgressBar.Position := Cnt;
        Application.ProcessMessages;

        FPos := ImOffLoc[Cnt] - 8;
        TimeSt[Cnt] := pDouble(@pRawData[FPos])^;

      End; //For Cnt := 0 to High(ImOffLoc) do Begin

      for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := (TimeSt[Cnt] - TimeSt[0])/1000;   //convert ms into sec
      TimeSt[0] := 0;

      BitCount := BitCountLoc; //needed for Preview
      imXSize   := WidthLoc;    //needed for Preview
      imYSize  := HeightLoc;   //needed for Preview

      {3rd.  Check if this is a Zstack}
      MovieSeriesType := TimeSeries;
  If (ImageEventsLV_Pos > 0) Then Begin

      SetLength(PartOfFile,ImageEventsLV_Size); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ImageEventsLV_Pos - ImageEventsLV_Size;
      Move(pRawData[FPos],pT^, Length(PartOfFile));

      SetLength(Param,11);
      //d.Z.S.t.e.p =  64 00 5A 00 53 00 74 00 65 00 70
      Param[0]  := $64;
      Param[1]  := 0;
      Param[2]  := $5A;
      Param[3]  := 0;
      Param[4]  := $53;
      Param[5]  := 0;
      Param[6]  := $74;
      Param[7]  := 0;
      Param[8]  := $65;
      Param[9]  := 0;
      Param[10] := $70;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      If (PosOfByteArr > -1) then Begin
        MovieSeriesType := Z_Stack;
        {this is Zstack file: find d.Z.H.o.m.e and d.Z.P.o.s.i.t.i.o.n.0}
        ZStepLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

        SetLength(Param,11);
        //d.Z.H.o.m.e = 64 00 5A 00 48 00 6F 00 6D 00 65
       // d.Z.H.o.m.e is 68 bytes before beg of d.Z.S.t.e.p
        Param[0]  := $64;
        Param[1]  := 0;
        Param[2]  := $5A;
        Param[3]  := 0;
        Param[4]  := $48;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $6D;
        Param[9]  := 0;
        Param[10] := $65;

        StartPos := PosOfByteArr - 100;
        PosOfByteArr := BytePos(StartPos,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then begin
          ZHomeLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
        end;
      End; // MovieSeriesType := Z_Stack;  If (PosOfByteArr > -1) then Begin
    End; //If (ImageEventsLV_Pos > 0) Then Begin

       SetLength(PartOfFile,ImageAttributesLV_Size); //reads till the end of file minus one byte
       pT := @PartOfFile[0];
      if    ImOffLoc[0] >= ImageAttributesLV_Size then
      FPos := ImOffLoc[0] - ImageAttributesLV_Size else
         FPos := 0;
        Move(pRawData[FPos],pT^, Length(PartOfFile));

        //find Color of channels
        SetLength(Param,14);
        //  C.o.l.o.r...      = 03 06 43 00 6F 00 6C 00 6F 00 72 00 00 00

        Param[0]  := $03;
        Param[1]  := $06;
        Param[2]  := $43;
        Param[3]  := 0;
        Param[4]  := $6F;
        Param[5]  := 0;
        Param[6]  := $6C;
        Param[7]  := 0;
        Param[8]  := $6F;
        Param[9]  := 0;
        Param[10] := $72;
        Param[11] := 0;
        Param[12] := 0;
        Param[13] := 0;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin
          Found := Found + 3; //Ch Color + Name found
          //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
          i := 0;
          R := 1;
          ScopeSystemParams.Ch1_Name := '';
          while (R <> 6)  do begin
            R := PartOfFile[PosOfByteArr+Length(Param)+16+i];
            if not(R in[0,6]) then ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(R);
            Inc(i);
          end;

          //Get Color of Channes
          R := PartOfFile[PosOfByteArr+Length(Param)];
          G := PartOfFile[PosOfByteArr+Length(Param)+1];
          B := PartOfFile[PosOfByteArr+Length(Param)+2];

          frmImageControl.ubFileColTable.Tag := NrChannelsLoc;
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
          FillColorTables(FileColorTBL_Ch1);
        If (NrChannelsLoc = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr+Length(Param),Param,PartOfFile); //Gives Position of Param in the PartOfFile
         If (PosOfByteArr > -1) then Begin
             //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
            i := 0;
            R := 1;
            ScopeSystemParams.Ch2_Name := '';
            while (R <> 6)  do begin
              R := PartOfFile[PosOfByteArr+Length(Param)+16+i];
              if not(R in[0,6]) then ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(R);
              Inc(i);
            end;
            //get channel colors
              R := PartOfFile[PosOfByteArr+Length(Param)];
              G := PartOfFile[PosOfByteArr+Length(Param)+1];
              B := PartOfFile[PosOfByteArr+Length(Param)+2];
              if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
              FillColorTables(FileColorTBL_Ch2);
          End;  ////if (PosOfByteArr > -1) then begin = String Found
        End; // If (NrChannelsLoc = 2) then Begin
       End;  // Searching for 1st Color (if (PosOfByteArr > -1) then begin = String Found )
         //--- End of Getting Colors & tables ----------//

      If (MovieSeriesType = Z_Stack) then Begin
        SetLength(Param,21);
        //d.Z.P.o.s.i.t.i.o.n.0 = 64 00 5A    00 50 00 6F 00 73 00 69 00 74 00 69 00 6F 00 6E 00 30

        Param[0]  := $64;
        Param[1]  := 0;
        Param[2]  := $5A;
        Param[3]  := 0;
        Param[4]  := $50;
        Param[5]  := 0;
        Param[6]  := $6F;
        Param[7]  := 0;
        Param[8]  := $73;
        Param[9]  := 0;
        Param[10] := $69;
        Param[11] := 0;
        Param[12] := $74;
        Param[13] := 0;
        Param[14] := $69;
        Param[15] := 0;
        Param[16] := $6F;
        Param[17] := 0;
        Param[18] := $6E;
        Param[19] := 0;
        Param[20] := $30;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
        if (PosOfByteArr > -1) then ZPosLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;

      End; //If (MovieSeriesType = Z_Stack) then Begin  = This is Z stack movie

      SetLength(PartOfFile,ImageMetadataSeqLV_0Size);
      pT := @PartOfFile[0];
      if (ImageMetadataSeq_Pos = 0) then
         {case with COBRE Andor setup Files (v.3.0)}
        FPos := ImageMetadataSeqLV_Pos - ImageMetadataSeqLV_0Size
          else
      if (ImageMetadataSeqLV_Pos = 0) then
         {case with Rachael TIRF setup Files (v.3.0)}
        FPos := ImageMetadataSeq_Pos - ImageMetadataSeqLV_0Size;

      Move(pRawData[FPos],pT^, Length(PartOfFile));

      SetLength(Param,23);
      //find d.C.a.l.i.b.r.a.t.i.o.n = 64 00 43 00 61 00 6C 00 69 00 62 00 72 00 61 00 74 00 69 00 6F 00 6E
      Param[0]  := $64;
      Param[1]  := 0;
      Param[2]  := $43;
      Param[3]  := 0;
      Param[4]  := $61;
      Param[5]  := 0;
      Param[6]  := $6C;
      Param[7]  := 0;
      Param[8]  := $69;
      Param[9]  := 0;
      Param[10] := $62;
      Param[11] := 0;
      Param[12] := $72;
      Param[13] := 0;
      Param[14] := $61;
      Param[15] := 0;
      Param[16] := $74;
      Param[17] := 0;
      Param[18] := $69;
      Param[19] := 0;
      Param[20] := $6F;
      Param[21] := 0;
      Param[22] := $6E;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      if (PosOfByteArr > -1) then begin
        PixSizeLoc := pDouble(@PartOfFile[PosOfByteArr+Length(Param)+3])^;
      end
        else
      begin

       SetLength(Param,12);
      {find dCalibration runtype="double" value=" number in ASCII follows It is enogh to search for dCalibration
      dCalibration = 64 43 61 6C 69     62 72 61 74 69     6F 6E}
      Param[0]  := $64;
      Param[1]  := $43;
      Param[2]  := $61;
      Param[3]  := $6C;
      Param[4]  := $69;
      Param[5]  := $62;
      Param[6]  := $72;
      Param[7]  := $61;
      Param[8]  := $74;
      Param[9]  := $69;
      Param[10] := $6F;
      Param[11] := $6E;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

      if (PosOfByteArr > -1) then begin
        ReadStr := '';
        StartPos := PosOfByteArr + Length(Param) + 25;
        while (AnsiChar(PartOfFile[StartPos]) in DigitsFlt) do begin
          ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
          Inc(StartPos);
        end;
          PixSizeLoc := StrToFloat(ReadStr);
        end;
      end;
  
      //CustomDataVar_LUTDataV1_Size
   If (CustomDataVarLUTDataV1_Pos > 0) Then Begin
      SetLength(PartOfFile,CustomDataVar_LUTDataV1_Size); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := CustomDataVarLUTDataV1_Pos - CustomDataVar_LUTDataV1_Size;
      Move(pRawData[FPos],pT^, Length(PartOfFile));

      SetLength(Param,18);
      PixSettings.ImageBinning := 0; //if remains 0 then Binning was no recorded in file

      Param[0]  := $42;
      Param[1]  := 0;
      Param[2]  := $69;
      Param[3]  := 0;
      Param[4]  := $6E;
      Param[5]  := 0;
      Param[6]  := $6E;
      Param[7]  := 0;
      Param[8]  := $69;
      Param[9]  := 0;
      Param[10] := $6E;
      Param[11] := 0;
      Param[12] := $67;
      Param[13] := 0;
      Param[14] := $3A;
      Param[15] := 0;
      Param[16] := $20;
      Param[17] := 0;

      PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
      if (PosOfByteArr > -1) then begin
        PixSettings.ImageBinning := StrToInt(AnsiChar(PartOfFile[PosOfByteArr+Length(Param)]));
      end
        else
      begin
        SetLength(Param,9);
        Param[0] := $42;
        Param[1] := $69;
        Param[2] := $6E;
        Param[3] := $6E;
        Param[4] := $69;
        Param[5] := $6E;
        Param[6] := $67;
        Param[7] := $3A;
        Param[8] := $20;
        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        if (PosOfByteArr > -1) then begin
          PixSettings.ImageBinning := StrToInt(AnsiChar(PartOfFile[PosOfByteArr+Length(Param)]));
        end
          else
        begin
          SetLength(PartOfFile,11000); //reads till the end of file minus one byte
          pT := @PartOfFile[0];
          FPos := ImOffLoc[0] - 4096 - Length(PartOfFile);
          Move(pRawData[FPos],pT^, Length(PartOfFile));
          PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile
          if (PosOfByteArr > -1) then begin
            PixSettings.ImageBinning := StrToInt(AnsiChar(PartOfFile[PosOfByteArr+Length(Param)]));
          end
            else
          PixSettings.ImageBinning := 1;
        end;
      end; //else begin for Fernando  files
    End; // If (CustomDataVarLUTDataV1_Pos > 0) Then Begin

      imXsize    := WidthLoc;
      imYsize    := HeightLoc;
      NrChannels := NrChannelsLoc;
      NrIm       := NrImLoc;
      ImagePix   := imXsize * imYsize; { Number of Pixels in Bitmap }
      ImageBytes := ImagePix * (BitCount div 8)*NrChannels; { in bytes }

      SetLength(ImOff,1,NrIm); //always because the channels are interlaced
      for Cnt := 0 to High(ImOffLoc) do ImOff[0,Cnt] := ImOffLoc[Cnt];

      if (MovieSeriesType = Z_Stack) then begin
        ZstackUnits := ' µm';
        if (Length(ZstackArr) <> NrIm) then SetLength(ZstackArr,NrIm);
        for Cnt := 0 to High(ZstackArr) do  ZstackArr[Cnt] := 0;
        if (ZPosLoc < ZHomeLoc) then begin
          for Cnt := 1 to High(ZstackArr) do begin
            ZstackArr[Cnt] := ZstackArr[Cnt-1] + ZStepLoc;
          end;
        end
          else
        if (ZPosLoc > ZHomeLoc) then begin
          for Cnt := 1 to High(ZstackArr) do begin
            ZstackArr[Cnt] := ZstackArr[Cnt-1] - ZStepLoc;
          end;
        end;
      end;

      if (NrIm > 1) then begin
        MeanImTime := TimeSt[High(TimeSt)] / (NrIm - 1);
        // used for Table , Export MPEG etc
        ExportDial.OrigFrameRate := (NrIm - 1) / TimeSt[High(TimeSt)];
      end;

      if (PixSizeLoc = 0) then begin
        PixSettings.FileHasOwnPixSize := False;
      end
        else                             //ImageBinning
      begin
        PixSettings.FileHasOwnPixSize := True;
        PixSettings.FilePixSize := PixSizeLoc;
      end;

      ToSwap := False;
      shrFact := BitDepthLoc - 8;

   If (Found < 3) Then Begin

      FPos := ImageDataSeqZeroPos + 15;
      ImageDataSeqZeroPos := pUInt64(@pRawData[FPos])^;
      SetLength(PartOfFile,ImageDataSeqZeroSize); //reads till the end of file minus one byte
      pT := @PartOfFile[0];
      FPos := ImageDataSeqZeroPos - ImageDataSeqZeroSize;
      Move(pRawData[FPos],pT^, Length(PartOfFile));

        SetLength(Param,36);
        //3C 75 69 43 6F
        Param[0]  := $3C;
        Param[1]  := $75;
        Param[2]  := $69;
        Param[3]  := $43;
        Param[4]  := $6F;

        //6C 6F 72 20 72
        Param[5]  := $6C;
        Param[6]  := $6F;
        Param[7]  := $72;
        Param[8]  := $20;
        Param[9]  := $72;

        //75 6E 74 79 70
        Param[10] := $75;
        Param[11] := $6E;
        Param[12] := $74;
        Param[13] := $79;
        Param[14] := $70;

        //65 3D 22 6C 78
        Param[15] := $65;
        Param[16] := $3D;
        Param[17] := $22;
        Param[18] := $6C;
        Param[19] := $78;

        //5F 75 69 6E 74
        Param[20] := $5F;
        Param[21] := $75;
        Param[22] := $69;
        Param[23] := $6E;
        Param[24] := $74;

        //33 32 22 20 76
        Param[25] := $33;
        Param[26] := $32;
        Param[27] := $22;
        Param[28] := $20;
        Param[29] := $76;

        //61 6C 75 65 3D 22
        Param[30] := $61;
        Param[31] := $6C;
        Param[32] := $75;
        Param[33] := $65;
        Param[34] := $3D;
        Param[35] := $22;


        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin
          ReadStr := '';
          StartPos := PosOfByteArr + Length(Param);//
          while (AnsiChar(PartOfFile[StartPos]) in DigitsFlt) do begin
            ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
          end;

            ChannelColor := StrToInt(ReadStr);
            R := GetRValue(ChannelColor);
            G := GetGValue(ChannelColor);
            B := GetBValue(ChannelColor);

          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
          FillColorTables(FileColorTBL_Ch1);

          //Find Color for the 2nd Channel
          If (NrChannels = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr + Length(Param),Param,PartOfFile); //Gives Position of Param in the PartOfFile
            If (PosOfByteArr > -1) then Begin
              ReadStr := '';
              StartPos := PosOfByteArr + Length(Param);//
              while (AnsiChar(PartOfFile[StartPos]) in DigitsFlt) do begin
                ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
                Inc(StartPos);
              end;

              ChannelColor := StrToInt(ReadStr);
              R := GetRValue(ChannelColor);
              G := GetGValue(ChannelColor);
              B := GetBValue(ChannelColor);

              if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
              FillColorTables(FileColorTBL_Ch2);
            End; // 2nd Channel; If (PosOfByteArr > -1) then Begin

          End;  //If (NrChannels = 2) then Begin


          frmImageControl.ubFileColTable.Tag := NrChannels;
        End; // Ch1 Color = End of Colors; If (PosOfByteArr > -1) then Begin

         //Channel Name

        SetLength(Param,41);

        //73 44 65 73 63
        Param[0]  := $73;
        Param[1]  := $44;
        Param[2]  := $65;
        Param[3]  := $73;
        Param[4]  := $63;

        //72 69 70 74 69
        Param[5]  := $72;
        Param[6]  := $69;
        Param[7]  := $70;
        Param[8]  := $74;
        Param[9]  := $69;

        //6F 6E 20 72 75
        Param[10] := $6F;
        Param[11] := $6E;
        Param[12] := $20;
        Param[13] := $72;
        Param[14] := $75;

        //6E 74 79 70 65
        Param[15] := $6E;
        Param[16] := $74;
        Param[17] := $79;
        Param[18] := $70;
        Param[19] := $65;

        //3D 22 43 4C 78
        Param[20] := $3D;
        Param[21] := $22;
        Param[22] := $43;
        Param[23] := $4C;
        Param[24] := $78;

        //53 74 72 69 6E
        Param[25] := $53;
        Param[26] := $74;
        Param[27] := $72;
        Param[28] := $69;
        Param[29] := $6E;

        //67 57 22 20 76
        Param[30] := $67;
        Param[31] := $57;
        Param[32] := $22;
        Param[33] := $20;
        Param[34] := $76;

        //61 6C 75 65 3D 22
        Param[35] := $61;
        Param[36] := $6C;
        Param[37] := $75;
        Param[38] := $65;
        Param[39] := $3D;
        Param[40] := $22;

        PosOfByteArr := BytePos(0,Param,PartOfFile); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin
          ReadStr := '';
          StartPos := PosOfByteArr + Length(Param);//
          while (PartOfFile[StartPos] <> 34) do begin
            ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
            Inc(StartPos);
          end;
          ScopeSystemParams.Ch1_Name := ReadStr;

          If (NrChannels = 2) then Begin  //was never tested I don't have 2 channel mobies
            PosOfByteArr := BytePos(PosOfByteArr + Length(Param),Param,PartOfFile); //
            If (PosOfByteArr > -1) then Begin
              ReadStr := '';
              StartPos := PosOfByteArr + Length(Param);//
              while (PartOfFile[StartPos] <> 34) do begin
                ReadStr := ReadStr + AnsiChar(PartOfFile[StartPos]);
                Inc(StartPos);
              end;
              ScopeSystemParams.Ch2_Name := ReadStr;
            End;
          End; //2nd channel
        End; //1st channel; If (PosOfByteArr > -1) then Begin

    End; //If (Found < 3) Then Begin

      if (frmProgress <> nil) then frmProgress.Close;

  End; // If (ReadStr = 'ND2 FILE SIGNATURE CHUNK NAME01!') then Begin



End; //Procedure GetND2fileInfoFromRAM(Const FName: AnsiString; Const SilentMode: Boolean);
{****************************************************************************}

Procedure GetStreamPixInfo(Const FName: AnsiString; Const SilentMode: Boolean);
{StreamPix movies, NorPix Inc, Canada, Montreal}

Const MagicNumber = $FEED;

Var
  Cnt: Integer; // @- Cool magic number (always 0xFEED = 65261)
  Temp_hFile: THandle;
  FPos: UInt64;
  ThisFileSize: UInt64;
  Delta: Double;
  Wst: WideString;
  pRead: Pointer;
  ReadArr: Array of LongWord; { DWORD = unsigned 32-bit = 4 bytes }

Begin

          { Sequence header format ( struct CSequenceHeader):


            Variable                                         Offset       Size

            MagicNumber = 0xFEED (Delphi = $FEED)           0 -   3      4 bytes
            _tcscpy(Name, _T("Norpix seq\n"));              4 -  27     24 bytes
            Version = 3;                                   28 -  31      4 bytes
            HeaderSize = sizeof(CSequenceHeader);          32 -  35      4 bytes
            _tcscpy(Description, _T("No Description\n"));  36 - 547    512 bytes
            ImageInfo.DefaultIni();                       548 - 571      6 members * 4 bytes = 24 bytes
            AllocatedFrame = 0; This is Number of Images  572 - 575      4 bytes
            Origin = 0;                                   576 - 579      4 bytes
            TrueImageSize (also named "Physical image size") = Number of bytes between the
            first pixel and first of next image           580   583      4 bytes
            FrameRate = 30.0;                             584 - 591      8 bytes (Watch out for the alignment)
            592 -1023   432 BMPPadding bytes = 1024 bytes Total

            Note: Cool magic number (always 0xFEED = 65261) used to verify if this is StreamPix seq file

            //Those members can exist or not depending of the header version
            CImageInfo ImageInfo;               //@- Image information
            unsigned long AllocatedFrame;       //@- Number of frames allocated
            unsigned long Origin;               //@- First frame to use for playback
            unsigned long TrueImageSize;        //@- Number of bytes between the first pixel and first of next image
            double FrameRate;                   //@- Suggested Frame rate for playback
            BYTE BMPPadding[432];                  //@- BMPPadding


            struct CImageInfo (starts from offset = 548)

            unsigned long ImageWidth;          Image width in pixel
            unsigned long ImageHeight;         Image height in pixel
            unsigned long ImageBitDepth;       Image depth in bits (8,16,24,32)
            unsigned long ImageBitDepthReal;   Precise Image depth (x bits)
            unsigned long ImageSizeBytes;      Size used to store one image.
            eIMAGEFORMAT ImageFormat;          Planar, Packed, color or mono

            Supported Image Formats:

            FORMAT_UNKNOWN=0,
            FORMAT_MONO=100,
            FORMAT_MONO_BAYER=101,
            FORMAT_BGR_PACKED=200,
            FORMAT_BGR_PLANAR=300,		// Actually RGB plannar
            FORMAT_RGB_PACKED=400,
            FORMAT_BGRx_PACKED=500,
            FORMAT_YUV422_PACKED=600,
            FORMAT_UVY422_PACKED=700,
            FORMAT_UVY411_PACKED=800,
            FORMAT_UVY444_PACKED=900,
            FORMAT_BASLER_VENDOR_SPECIFIC=1000

            Example:
            Read 640 x 480 or 307200 bytes (+1024 Header) to get all the image pixels
            Then read the next 32 bit ( 4 bytes) to get the time stamp in second,
            formated according the C standard time_t data structure.

            !!!!!!! SteamPix uses ONLY int tm_sec;        seconds after the minute (from 0) = One LongInt !!!!!!!!
            From StramPix HEPL : "Usually, pixel in the images are stored for top left to bottom right corner.
            Immediately following the image data, comes 8 bytes, containing the absolute time stamp
            at which the image has been grabbed. First 4 bytes is date and time; last 4 bytes is the milliseconds".


            time_t
            typedef a-type time_t;

            The type is the arithmetic type a-type of an object that you declare to hold the value returned by time.
            The value represents calendar time.

            tm
            struct tm {
            int tm_sec;        seconds after the minute (from 0)
            int tm_min;        minutes after the hour (from 0)
            int tm_hour;       hour of the day (from 0)
            int tm_mday;       day of the month (from 1)
            int tm_mon;        month of the year (from 0)
            int tm_year;       years since 1900 (from 0)
            int tm_wday;       days since Sunday (from 0)
            int tm_yday;       day of the year (from 0)
            int tm_isdst;      Daylight Saving Time flag

            int in C = 32 bits = LongInt Pascal;
            int    4      32   -2,147,483,648 -> +2,147,483,647   ( 2Gb)


            struct tm contains members that describe various properties of the calendar time. The members shown above can occur in any order, interspersed with additional members. The comment following each member briefly describes its meaning.

            The member tm_isdst contains:

            a positive value if Daylight Saving Time is in effect
            zero if Daylight Saving Time is not in effect
            a negative value if the status of Daylight Saving Time is not known (so the target environment should attempt to determine its status)
            }

          { 1st: Check if FileSize }

          ThisFileSize := GetBigFileSize(FName); // this below works with files > 4 GB in size !!!

          If ThisFileSize < 1024 Then
          Begin
           // ValidFile := False;
            if SilentMode = False then
            begin
              if Cnt = 0 then
                MessageDlg('File is Empty', mtError, [mbOK], 0)
              else if Cnt <> 0 then
                MessageDlg('Cannot Allocate File Handle', mtError, [mbOK], 0);
            end;
          End
          Else

            If ThisFileSize > 1024 Then
          Begin
            { 1st: Check if this is a StreamPix "seq" file }
            Temp_hFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
            FPos := 0;
            FileSeek(Temp_hFile, FPos, 0); // 0 = Origin = Begining of File
            FileRead(Temp_hFile, Cnt, 4);
            If Cnt = MagicNumber Then
            Begin
              SetLength(Wst, 10);
              pRead := @Wst[1];
              FPos := 4;
              FileSeek(Temp_hFile, FPos, 0);
              FileRead(Temp_hFile, pRead^, 20);
            End;

            If (Cnt <> MagicNumber) or (Wst <> 'Norpix seq') then
            Begin
              //ValidFile := False;
              if SilentMode = False then
                MessageDlg('This is Not StreamPix "seq" File', mtError, [mbOK],
                  0);
            End
            Else If (Cnt = MagicNumber) and (Wst = 'Norpix seq') then
            Begin
              //ValidFile := True;
            End;

              PixSettings.FileHasOwnPixSize := False;

              { 1st: Gets All Parameters Except for Framerate and TimeStamps }
              SetLength(ReadArr, 9);
              pRead := @ReadArr[0];
              FPos := 548;
              FileSeek(Temp_hFile, FPos, 0);
              FileRead(Temp_hFile, pRead^, 36);
              imXsize := ReadArr[0];
              imYsize := ReadArr[1];
              BitCount := ReadArr[2]; // ImageBitDepth
              shrFact := ReadArr[3] - 8; // ImageBitDepthReal
              { Origin (ReadArr[7]) is = 0 it anmd is not Used;
                The first image in the sequence file is at an offset of 1024 bytes. }
              { Also I don't use ImageFormat= ' + IntToStr(ReadArr[5]) and 'ImageSizeBytes= ' + IntToStr(ReadArr[4]) }
              NrIm := ReadArr[6];

              SetLength(ImOff,1, NrIm);
              SetLength(TimeSt, NrIm);

              // Reads FrameRate
              FPos := 584;
              FileSeek(Temp_hFile, FPos, 0);
              FileRead(Temp_hFile, ExportDial.OrigFrameRate, 8);
              MeanImTime := 1 / ExportDial.OrigFrameRate;

              For Cnt := 0 to High(ImOff[0]) do
              Begin
                ImOff[0,Cnt] := 1024 + ReadArr[8] * Cnt;
                { ReadArr[8] = 'Number of bytes between the first pixel and first of next image
                  The first image in the sequence file is at an offset of 1024 bytes }
              End;

              ImagePix := imXsize * imYsize; { Number of Pixels in Bitmap }
              ImageBytes := ImagePix * (BitCount div 8); { in bytes }

              If NrIm > 1 then
              Begin

                // Reads TimeStamps

                If High(SecMS) = -1 then
                Begin
                  SetLength(SecMS, 2);
                  SetLength(MemSecMS, 2);
                End;

                pRead := @MemSecMS[0];

                FPos := 1024 + ImageBytes;
                FileSeek(Temp_hFile, FPos, 0);
                FileRead(Temp_hFile, pRead^, 8);

                TimeSt[0] := 0;

                { Too slow to be used if images are many e.q. 1000 im load for 3 sec; 10000 for 60 sec }
                If (LoadStreamPixAndND2TimeSt) Then
                Begin // Loads All TimeStamps (see Options)

                  pRead := @SecMS[0];

                  For Cnt := 1 to High(TimeSt) Do
                  Begin
                    FPos := ImOff[0,Cnt] + ImageBytes;
                    FileSeek(Temp_hFile, FPos, 0);
                    FileRead(Temp_hFile, pRead^, 8);
                    TimeSt[Cnt] := (SecMS[0] - MemSecMS[0]) +
                      (SecMS[1] - MemSecMS[1]) / 1000;
                  End;

                  { Check if Pause exists and sets Cycle buffers (if there were Stops and Pauses }
                  // The Same Paragraph is used in QED get Info

                  if NrIm >= 3 then
                    Delta := (TimeSt[2] - TimeSt[1]) * 10
                  else if NrIm = 2 then
                    Delta := (TimeSt[1] - TimeSt[0]) * 10;

                  if MovieCycleList <> nil then
                    SetLength(MovieCycleList, 0); // resets

                  for Cnt := 1 to High(TimeSt) do
                  begin
                    if (TimeSt[Cnt] - TimeSt[Cnt - 1]) > Delta then
                    begin
                      SetLength(MovieCycleList, High(MovieCycleList) + 2);
                      MovieCycleList[ High(MovieCycleList)] := Cnt;
                      Delta := (TimeSt[Cnt + 1] - TimeSt[Cnt]) * 10;
                      // resets Delta
                    end;
                  end; // For Cnt := 1 to High(TimeSt) do begin

                  If ( High(MovieCycleList) > -1) then
                  begin
                    SetLength(MovieCycleList, High(MovieCycleList) + 2);
                    MovieCycleList[ High(MovieCycleList)] := NrIm;
                    // puts the last one
                  End;
                  FillMovieFrRateListAndCalcMeanImTime;

                End
                { If LoadStreamPixTimeSt } Else

                  If Not(LoadStreamPixAndND2TimeSt) Then Begin // Does Not Load TimeStamps (see Options)
                  // Sets TimeSt to -1; used in ReadImage & ReadImageForAnal to see if Time Was Loaded for Ceartain Frame
                  for Cnt := 1 to High(TimeSt) do
                    TimeSt[Cnt] := -1;
                  MovieFrRateList := nil;
                  MovieCycleList := nil;

                End; // If Not(LoadStreamPixTimeSt)

              End; // If NrIm > 1 then Begin

         //   End; // If ValidFile

            FileClose(Temp_hFile);

  End; // If FileSize(TempFile) > 1024

 End; // Procedure GetStreamPixInfo

{**************************************************************************** }

Procedure GetStreamPixFile_Preview(Const FName: AnsiString;
          var ImageWidth, ImageHeight: Word; var BitsPerPixel: Word;
          var DynBarr: TDynByteArray; var DynWarr: TDynWordArray;
          Var ValidFile: Boolean);

Const MagicNumber = $FEED;

Var
  Cnt: Integer; // @- Cool magic number (always 0xFEED = 65261)
  Temp_hFile: THandle;
  FPos: Int64;
  Wst: WideString;
  pRead: Pointer;
  ReadArr: Array of LongWord; { DWORD = unsigned 32-bit = 4 bytes }

Begin

          { 1st: Check if this is a StreamPix "seq" file }
          Temp_hFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
          FPos := 0;
          FileSeek(Temp_hFile, FPos, 0); // 0 = Origin = Begining of File
          FileRead(Temp_hFile, Cnt, 4);
          If Cnt = MagicNumber Then
          Begin
            SetLength(Wst, 10);
            pRead := @Wst[1];
            FPos := 4;
            FileSeek(Temp_hFile, FPos, 0);
            FileRead(Temp_hFile, pRead^, 20);
          End;

          ValidFile := False;
          if (Cnt = MagicNumber) and (Wst = 'Norpix seq') then
            ValidFile := True;

          If (ValidFile) Then
          Begin

            { 1st: Gets  Parameters }
            SetLength(ReadArr, 9);
            pRead := @ReadArr[0];
            FPos := 548;
            FileSeek(Temp_hFile, FPos, 0);
            FileRead(Temp_hFile, pRead^, 36);
            ImageWidth := ReadArr[0];
            ImageHeight := ReadArr[1];
            BitsPerPixel := ReadArr[2];

            // The first image in the sequence file is at an offset of 1024 bytes.}
            if (BitsPerPixel = 8) then
            begin
              SetLength(DynBarr, ImageWidth * ImageHeight);
              pRead := @DynBarr[0];
            end
            else if (BitsPerPixel = 16) then
            begin
              SetLength(DynWarr, ImageWidth * ImageHeight);
              pRead := @DynWarr[0];
            end;

            FPos := 1024;
            FileSeek(Temp_hFile, FPos, 0);
            if (BitsPerPixel = 8) then
              FileRead(Temp_hFile, pRead^, ImageWidth * ImageHeight)
            else if (BitsPerPixel = 16) then
              FileRead(Temp_hFile, pRead^, ImageWidth * ImageHeight * 2);

          End; // If ValidFile

          FileClose(Temp_hFile);

 End; // Procedure GetStreamPixFile_Preview

 { ****************************************************************************** }

Procedure GetTIFFfileInfo(Var NrPages: LongWord;  Const FName: AnsiString; Const StartPage: Longint;
                          Const ActionMode: Byte; Const ColFileNr : Integer;  Const SilentMode: Boolean);

{ StartPage is used for Collection of Andor Files Only to place Time Stamps and Image offsets at
  the approprate place }

Label ReadAgain;

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }
  TiffFile   : THandle;
  FPos       : UInt64;
  BegRead    : UInt64;
  SearchRec  : TSearchRec;
  Cnt        : Integer; { 'Counter }
  TemCnt     : Integer;
  SamplesPerPixel: Word; // This is Tag 277; Not Required for Grayscale or Palleted Color
  // it is 3 for 245 bit Color
  PalettedColor: Boolean;
  { ToSwap := True if Motorola Type ('MM')  GLOBAL }

  { ----------- Variables For the Final Output  ---------------- }
  XimSize: LongWord; { Tag = 256; TypeF = 3 }
  YimSize: LongWord; { Tag = 257  TypeF = 3 }
  BitsPix: Word; { Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology" }
  StripOffsLoc  : array of LongWord; //Local (Global is StripOffs); Tag = 273  TypeF = 4 'Strip Offset
  TempBarr  : TDynByteArray;
  TemWarr   : TDynWordArray; // used in case this is array of SHORT(C++)= Word(Pascal
  TempLWarr : TDynLongWordArray;
  RowsPerStrip: LongWord; // Tag = 278  TypeF = 3 or 4; Rows per Strip
  // StripSizes : array of Longword; GLOBAL; Tag = 279  TypeF = 4 or 3'Size of each strip (QED has just 1) in bytes
  ReadStr: AnsiString; { Tag = 305, EQ String with 3 lenght }
  TemStr : AnsiString;
  { QEDtif : Boolean; }    { = True If sIfQED = "QED" }
  B        : Byte;
  TempWord : Word; { Tem. Values; Used To Swap LongIng or LongWord (4 bytes }
  Singl    : Single;
  { ------------------------------------------------------------------------- }
  sType: array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE : Word; { Number of Directory Entrees (DE) in IDF }
  IFD : array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag   : Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF : Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }

  { TypeF = '1 = BYTE (8-bit unsigned integer)
    '2 = ASCII (8-bit ASCII code , last one = NULL[binary 0])
    '3 = SHORT (16-bit [2 byte] unsigned integer = Word [Pascal])
    '4 = LONG  (32 bit [4 byte] unsigned integer = LongWord [Pascal])
    '5 = RATIONAL (2 LONGs, 1st nominator of a fraction, second denominator
    fraction = nominator/denominator)
    New Type added in TIFF version 6.0 year 1992
    6 = SBYTE An 8-bit signed (twos-complement) integer.
    7 = UNDEFINED An 8-bit byte that may contain anything, depending on
    the definition of the field.
    8 = SSHORT A 16-bit (2-byte) signed (twos-complement) integer.
    9 = SLONG A 32-bit (4-byte) signed (twos-complement) integer.
    10 = SRATIONAL Two SLONG’s: the first represents the numerator of a
    fraction, the second the denominator.
    11 = FLOAT Single precision (4-byte) IEEE format.
    12 = DOUBLE Double precision (8-byte) IEEE format.


    'I think if we know the Tag Values we dont need to Check and Use the Type !!!!!!! }
  CountOfType : LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset : LongWord; { 'Byte 8-11;  Value or Offset of the  Value. E.g. we need offset for
    'String QED Camera Plugin, but not for the other Variables }

  Pt    : Pointer;
  // new for Andor multipage tiff
  PageCnt   : Integer;
  PosCnt    : Integer;
  PosTab    : Integer;
  ImageDesc : AnsiString; // Image Description - used by Andor to store a lot of Info
  MM_HEAD   : TMM_HEAD;
  Sender    : TObject;
  // For Time Stamps of Generic Multipage Tiffs
  TemDouble, ImageTime : Double;
      //NERW NIKON TIFF VARs
   Tag65330_31  : TDynByteArray;
   Param        : TDynByteArray;
   PosOfByteArr : integer;
   ZStepLoc,ZHomeLoc,ZPosLoc : Double;
   R,G          : Byte;
   ColDec       : Double;
   TimeDimName : AnsiString;
   SumOfEntries : Integer;

BEGIN

  { Initializations }
  TIFFfileType := TIFF_GENERIC; // initializes to this
  SamplesPerPixel := 1; // some files do not have Tag 277 where the value comes from
  PageCnt := 0; // Counts Pages
  NrPages := 1; // Number of Pages (Images) in Single TIFF

  PalettedColor := False;

  TimeDimName := 'Unknown';
  { end with Initializations }

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  FPos := 0;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, sType, 2);
  If sType = 'MM' Then
    ToSwap := True
  Else If sType = 'II' Then
    ToSwap := False;
  FPos := 2;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, IfThisIsTIFF, 2);
  if (ToSwap) then
    IfThisIsTIFF := Swap(IfThisIsTIFF);

  { ---------------------------------------------------- }

  If IfThisIsTIFF = 42 Then
  BEGIN { This is  Tiff File }

    FPos := 4;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, OffsIFD, 4);
    if (ToSwap) { MM } then OffsIFD := SwapLongWord(OffsIFD);
    { finds the FPos for the first IFD (Counted From "0" }

    // This Label Makes the Loop for multiimage TIFFs//
  ReadAgain :

    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }
    if (ToSwap) Then CntDE := Swap(CntDE);

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }

    BegRead := OffsIFD + 2;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To CntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
      Tag   := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }
      If ToSwap = True Then
      Begin { 'Motorola }
        Tag   := Swap(Tag);
        TypeF := Swap(TypeF);
      End; { If ToSwap = True }

      If not(ToSwap) Then Begin

        { ------- I N T E L     Type  ------- }

        If (Tag = 256) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then XimSize := IFD[4] {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
            else
          if (TypeF = 4) then XimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
        End { of Tag = 256 }
        Else If (Tag = 257) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then YimSize := IFD[4] {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
          else
          if (TypeF = 4) then YimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
        End { of Tag = 257 }

        Else If (Tag = 258) and (PageCnt = 0) Then
          { SHORT C++ } BitsPix := IFD[4]

        Else If (Tag = 270) and (PageCnt = 0) { Image Description }
        { ******** Important for Andor - gives All Descriptions****** }
        {Also Olympus FLUOVIEW Exported Files have similar description}

        Then Begin
          { ASCII type }
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          SetLength(ImageDesc, CountOfType);
          Pt := @ImageDesc[1]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);
          // ImageDescr will be used later in 1st private Andor  Tag

          if (AnsiStartsStr('ImageJ',ImageDesc)) then begin
            TIFFfileType := TIFF_ImageJ;
            PixSettings.FileHasOwnPixSize := False;
            PosCnt := PosEx('channels=', ImageDesc);
            if (PosCnt > 0) then NrChannels := StrToInt((Copy(ImageDesc, PosCnt + 9, 1))) else NrChannels := 1;
          end;

        End // If  'Tag = 270

        Else If (Tag = 273) Then
        Begin { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }

          { If more then One Image and Non-Overlapping StripOffsLoc
            subtracts the 1st offset from all and zeroies 1st offset at the end
            }

          if (PageCnt = 1) then begin
            if (Length(StripOffsLoc) > 1) then
              for TemCnt := 1 to High(StripOffsLoc) do StripOffsLoc[TemCnt] := StripOffsLoc[TemCnt] - StripOffsLoc[0];
          end;

          CountOfType := pLongWord(@IFD[2])^;

          If (CountOfType > 1) Then
          Begin
            ValOffset := pLongWord(@IFD[4])^;
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (PageCnt = 0) then
          Begin
            SetLength(StripOffsLoc, CountOfType);
            // Assuming that all image have the same number of StripOffsLoc
          End;

          If (TypeF = 3) Then Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := IFD[4];
            End
              Else
            If (CountOfType > 1) Then Begin
              if (PageCnt > 0) then
              begin
                FileRead(TiffFile, TempWord, 2);
                StripOffsLoc[0] := TempWord;
              end
                else
              begin
                SetLength(TemWarr, CountOfType);
                Pt := @TemWarr[0];
                FileRead(TiffFile, Pt^, CountOfType * 2);
                for TemCnt := 0 to High(TemWarr) do
                  StripOffsLoc[TemCnt] := TemWarr[TemCnt];
              end;
            End;
          End
            Else
          If (TypeF = 4) Then Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := pLongWord(@IFD[4])^;
            End
              Else
            If (CountOfType > 1) Then
            Begin
              Pt := @StripOffsLoc[0];
              if (PageCnt > 0) then
                FileRead(TiffFile, Pt^, 4)
              else
                FileRead(TiffFile, Pt^, CountOfType*4);
            End;
          End; { of TypeF = 4 }
        End { of Tag = 273 }

        Else If (Tag = 277) and (PageCnt = 0) { SHORT } Then
        Begin
          SamplesPerPixel := IFD[4]; // if = 1 this is Grayscale or Palleted Color
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
        Else If (Tag = 278) and (PageCnt = 0) Then
        Begin
          if (TypeF = 3) then RowsPerStrip := IFD[4] {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
            else
          if (TypeF = 4) then RowsPerStrip := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int}
        End { of Tag = 278 }
        Else If (Tag = 279) and (PageCnt = 0) Then
        Begin { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }
          { Size of Image Data in Bytes in one Strip officialy in TIFF terminology called = StripByteCounts }
          CountOfType := pLongWord(@IFD[2])^;
          SetLength(StripSizes, CountOfType);

          If (CountOfType > 1) Then
          Begin
            ValOffset := pLongWord(@IFD[4])^;
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If (CountOfType = 1) Then
            Begin
              StripSizes[0] := IFD[4];
            End
            Else If (CountOfType > 1) Then
            Begin
              SetLength(TemWarr, CountOfType);
              Pt := @TemWarr[0];
              FileRead(TiffFile, Pt^, Length(TemWarr) * 2);
              for TemCnt := 0 to High(TemWarr) do
                StripSizes[TemCnt] := TemWarr[TemCnt];
            End;
          End
          Else If (TypeF = 4) Then
          Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              StripSizes[0] := pLongWord(@IFD[4])^;
            End
            Else If (CountOfType > 1) Then
            Begin
              Pt := @StripSizes[0];
              FileRead(TiffFile, Pt^, CountOfType * 4);
            End;
          End;
        End { of Tag = 279 }

        Else If (Tag = 281) and (PageCnt = 0) then Begin //MaxSampleValue  Type 3 = Word
        //Used by Nikon NIS Tiff to write bit depth: 8 bit gives 255; 14 bit gives 16383, 16 bit gives  -1
          if (pWord(@IFD[4])^ > 0) then
          shrFact := round(Log2(pWord(@IFD[4])^ + 1)) - 8 else
          shrFact := 8; //sets it to 16 bit
          //Explanation for shrFact := 8; For some reason unknown 16 tiff pShort(@IFD[4])^ is EQ to Zero instead of 65536
          //8 bit gives 255, 14 bit gives 32767 but 16 bit 0 ???
        End

          Else

        If (Tag = 282) and (TIFFfileType = TIFF_ImageJ) and (PageCnt = 0) Then Begin    //Tags 282 = Xresolution and 283 = Yresolution.  We need Only Xresolution since Xres = Yres
          ValOffset := pLongWord(@IFD[4])^;
          SetLength(TempLWarr,2);
          Pt := @TempLWarr[0]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, 8);
          PixSettings.PixPer100Micr[SINGLE_BW_TIFF] := Round(100*(TempLWarr[0]/TempLWarr[1]));
          PixSettings.FilePixSize := 1/(TempLWarr[0]/TempLWarr[1]);
          PixSettings.FileHasOwnPixSize := True;
          PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] := True;
        End

          Else

        If (Tag = 320) and (PageCnt in[0,1]) Then Begin
          { This field defines a Red-Green-Blue color map (often called a lookup table) for
            palette-color images. }
          If (TIFFfileType <> TIFF_ImageJ) Or ((TIFFfileType = TIFF_ImageJ) and (NrChannels = 1)) Then Begin
          If ((PageCnt = 0) and (ColFileNr = 0)) Then Begin  //always load the file color table
            PalettedColor := True; // TypeF = 3 = SHORT (always SHORT)(16-bit [2 byte] unsigned integer = Word [Pascal])
            CountOfType := pLongWord(@IFD[2])^;
            ValOffset := pLongWord(@IFD[4])^;
            SetLength(TemWarr, CountOfType);
            Pt := @TemWarr[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset, 0);
            FileRead(TiffFile, Pt^, CountOfType * SizeOf(Word));
            //for Andor Tiff it is always One Color Table = CountOfType = 768  of Words
            //  even if the Number of Channels is > 1//
            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            for PosCnt := 0 to 767 do FileColorTBL_Ch1[PosCnt] := TemWarr[PosCnt] shr 8;
            frmImageControl.ubFileColTable.Tag := 1;
          End
            Else
          If ((PageCnt = 1) and (NrChannels = 2) and (ColFileNr = 0) and Not(LoadChAsIndivFiles)) Or
             ((PageCnt = 0) and (ColFileNr = 1) and (LoadChAsIndivFiles)) Then Begin
             //Andor tiffs with 2 channels
            PalettedColor := True; // TypeF = 3 = SHORT (always SHORT)(16-bit [2 byte] unsigned integer = Word [Pascal])
            CountOfType := pLongWord(@IFD[2])^;
            ValOffset := pLongWord(@IFD[4])^;
            SetLength(TemWarr, CountOfType);
            Pt := @TemWarr[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset, 0);
            FileRead(TiffFile, Pt^, CountOfType * SizeOf(Word));
            //for Andor Tiff it is always One Color Table = CountOfType = 768  of Words
            //  even if the Number of Channels is > 1//
            if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
            for PosCnt := 0 to 767 do FileColorTBL_Ch2[PosCnt] := TemWarr[PosCnt] shr 8;
            frmImageControl.ubFileColTable.Tag := 2;
          End;
          End;
        End { of Tag 320;  If 'last tag value }

        { -------------End of --- Windows Public  Tags -------------------- }
        { -------------Beg of --- Windows Only Private Tags -------------------- }

        Else If (Tag = 34361) then
        begin
          { This Tag Appear Only in the First Image }

          TIFFfileType := TIFF_ANDOR_iQ;

          CountOfType := pLongWord(@IFD[2])^; // CountOfType = 1454
          ValOffset   := pLongWord(@IFD[4])^;

          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, MM_HEAD, SizeOf(MM_HEAD));

          { Gets Binning }
          PosCnt := PosEx('Binning=', ImageDesc);
          If (PosCnt > 0) then
          Begin // if this exist
            { it coud be just Binning or in the new version 1.4
              is binningX and binningY; and then comes the "old" "Binning=". I'll just deal for now with X binning
              assuming that is the same for Y }
            PixSettings.ImageBinning := StrToInt((Copy(ImageDesc, PosCnt + 8, 1)));
          End
          Else If PosCnt = 0 then
            PixSettings.ImageBinning := 0;

          { X and Y are always 1st and 2nd dimention even if the don't exist as name }
          PixSettings.FilePixSize := MM_HEAD.DimInfo[0].Resolution + MM_HEAD.DimInfo[0].Origin;
          // Origin is a offset; here is always EQ 0

          { check if this is 14 bit Data=TRUE; [Image Bits] 14 Bit Data=TRUE [Image Bits End] }
          PosCnt := PosEx('[Image Bits]', ImageDesc);
          If PosCnt > 0 then
            shrFact := StrToInt((Copy(ImageDesc, PosCnt + 14, 2)))
          else
          Begin
            if MM_HEAD.ImageType < 4 then
              shrFact := 8
            else if MM_HEAD.ImageType = 4 then
              shrFact := 12
            else if MM_HEAD.ImageType = 5 then
              shrFact := 16;
          End;
          shrFact := shrFact - 8;

          { finds in which dimension the Time is }

          DimNotTime := -1;
          AndorNrDIM := 1; // sets it initially to 1

          For PosCnt := 2 to High(MM_HEAD.DimInfo) do Begin // Start Counting from dimension 2, Dim 0 = x, 1 = y

            if (MM_HEAD.DimInfo[PosCnt].Name = 'Wavelength') then
            begin //it might or might not appear in MM_HEAD.DimInfo
              if (MM_HEAD.DimInfo[PosCnt].Size = 2) then
              NrPages := MM_HEAD.DimInfo[PosCnt].Size;
              //we do not store Wavelength dimension because we display the two channels simultaneously
              //One has to know though which channel was first
            end;

            if (MM_HEAD.DimInfo[PosCnt].Name = 'Z') then
            begin
              DimNotTime := PosCnt; // here  stores Z Dimension
              AndorNrDIM := 2; //we disregard all the dimensions but Time and Z
              ZstackUnits := ' µm';
            end;

            if ((MM_HEAD.DimInfo[PosCnt].Name = 'Time1') or //this is the case in Swapnil Uncaging file; added June 3, 2016
               (MM_HEAD.DimInfo[PosCnt].Name = 'Time') or
               (MM_HEAD.DimInfo[PosCnt].Name = 'T ')) and (TimeDimName = 'Unknown')
            then
            begin
                TimeDimName := MM_HEAD.DimInfo[PosCnt].Name;
                if (DimNotTime = -1) then //no Z stack, Z does not appear in MM_HEAD.DimInfo
                NrPages := NrPages*MM_HEAD.DimInfo[PosCnt].Size;
                DimTime := PosCnt; // here  stores Time Dimension
                Break; //Time is always the Last
            end;
            {typically it is:
             dimension 2 = Wavelength - number of channels
                       3 = Time - this is number of images
             with uncaging it is
             dimension 2 = Wavelength
                       3 = Time1 - now this is number of images!!!
                       4 = Time - gives number of frames where uncaging was done
             }
          End; //For PosCnt := 0 to High(MM_HEAD.DimInfo) do Begin

          if (DimNotTime <> -1) then NrPages := NrPages*MM_HEAD.DimInfo[DimNotTime].Size;

          if (DimNotTime = -1) then MovieSeriesType := TimeSeries
            else
          if (DimNotTime <> -1) then MovieSeriesType := Z_Stack;

          {if Time is 3rd dimension (array 2) then offset = 0, if 4th the move next by one double = 8 bytes
           if Time is in 3rd Dimension offset = 0; else Increment by one Double per Dimension}

          if (DimTime > DimNotTime) then
            SetLength(DArray, DimTime - 1)
          else if (DimTime < DimNotTime) then
            SetLength(DArray, DimNotTime - 1);

          if (NrPages > 1) and (ActionMode = READ_AS_SINGLE) then
          Begin
            { Option Open Single TIFF and Have Multipage (MultiImage) TIFF }
            SetLength(TimeSt, NrPages);
            if (DimNotTime > -1) then SetLength(ZstackArr, NrPages);
            SetLength(ImOff,1, NrPages);
          end; // if (NrPages > 1) and (ActionMode = READ_AS_SINGLE)

          { Single Tiff which is a part of TIFF Stack }
          if (NrPages = 1) and (ActionMode = READ_AS_STACK) then
          begin
            SetLength(Andor_DIM_INFO, AndorNrDIM);
            if (DimNotTime <> -1) then
            begin
              if (DimTime > DimNotTime) then
              begin // typical case
                Andor_DIM_INFO[0] := MM_HEAD.DimInfo[DimNotTime];
                Andor_DIM_INFO[1] := MM_HEAD.DimInfo[DimTime];
              end;
              if (DimTime < DimNotTime) then
              begin
                Andor_DIM_INFO[0] := MM_HEAD.DimInfo[DimTime];
                Andor_DIM_INFO[1] := MM_HEAD.DimInfo[DimNotTime];
              end;
            end
              else
            if (DimNotTime = -1) then
            begin
              Andor_DIM_INFO[0] := MM_HEAD.DimInfo[DimTime];
            end;
          end;
          { End of Single Tiff which is a part of TIFF Stack }
        End // Tag = 34361   Andor Specific

          Else

        If (Tag = 34362) then Begin // Andor Specific
          ValOffset := pLongWord(@IFD[4])^;
          Pt := @DArray[0];
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, Length(DArray) shl 3);

          if (NrPages > 1) and ((ActionMode = READ_AS_SINGLE) or
              (ActionMode = READ_AS_COLLECTION)) then
          begin
            if (DimTime > -1) then
              TimeSt[PageCnt + StartPage] := DArray[DimTime - 2];
            if (DimNotTime > -1) then
              ZstackArr[PageCnt + StartPage] := DArray[DimNotTime - 2];
          end
          else if (NrPages = 1) and (ActionMode = READ_AS_STACK) then
          begin // Single Tiff which is a part of TIFF Stack
            AndorDimValOffs := ValOffset;
            if (DimTime > -1) then
            begin
              FirstAndorTime := DArray[DimTime - 2]; // Stores 1st TimeSt
              if (MM_HEAD.DimInfo[DimTime].Resolution <> 1) then
                FirstAndorTime := FirstAndorTime * MM_HEAD.DimInfo[DimTime]
                  .Resolution;
              if (MM_HEAD.DimInfo[DimTime].Origin <> 0) then
                FirstAndorTime := FirstAndorTime + MM_HEAD.DimInfo[DimTime]
                  .Origin;
            end;
          end;

        End // Tag = 34362 (Andor Specific)

          Else

        If (Tag = 34363) then Begin { This Tag Appear Only in the First Image.  Not everything is known }
         If (ColFileNr = 0) or ((ColFileNr = 1) and (LoadChAsIndivFiles)) Then Begin
            CountOfType := pLongWord(@IFD[2])^; //CountOfType = 92  for One Channel and 180 for two channels
            ValOffset   := pLongWord(@IFD[4])^;
            FileSeek(TiffFile, ValOffset, 0);
            FileRead(TiffFile, NrChannels, 4);
            {pos ValOffset + 60 gives the ASCI name for the 1st channel
             pos ValOffset + 148 gives the ASCI name for the 2nd channel}
            If (ColFileNr = 0) Then Begin
              ScopeSystemParams.Ch1_Name := '';
              PosCnt := ValOffset + 60;
              B := 1;
              while (B <> 0) do begin
                FileSeek(TiffFile, PosCnt, 0);
                FileRead(TiffFile, B, 1);
                ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(B);
                Inc(PosCnt);
              end;
            End
              Else
            If ((ColFileNr = 1) and (LoadChAsIndivFiles)) Then Begin
              ScopeSystemParams.Ch2_Name := '';
              PosCnt := ValOffset + 60;
              B := 1;
              while (B <> 0) do begin
                FileSeek(TiffFile, PosCnt, 0);
                FileRead(TiffFile, B, 1);
                ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(B);
                Inc(PosCnt);
              end;
            End;
          End;

          If (NrChannels >= 2) then Begin
              //prevent from error of opening 2 channel files as Open Chennels as Individual Files
            LoadChAsIndivFiles := False;
            ScopeSystemParams.Ch2_Name := '';
            PosCnt := ValOffset + 148;
            B := 1;
            while (B <> 0) do begin
              FileSeek(TiffFile, PosCnt, 0);
              FileRead(TiffFile, B, 1);
              ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(B);
              Inc(PosCnt);
            end;
          End; //if (NrChannels >= 2) then begin
        End; { Tag = 34363 }

        { ------------- End of Private Andor Tags ---------------------- }
    {------------------------ Nikon NIS Elements Private Tags -----------------------------------}

      if (ActionMode = READ_AS_SINGLE) then Begin
        // for now Private NIKON NIS Elements and ImageJ Tiifs are open only as Single Tiff NOT as Stack of Tiffs

       // ----------------- ImageJ private Tags -------------------------//

        If (Tag = 50838) Then Begin  //ImageJ Metadata tag
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;

          SetLength(TempLWarr,CountOfType);
          Pt := @TempLWarr[0]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType*4);
        End //of Tag 50839
          Else
        If (Tag = 50839) Then Begin  //ImageJ Metadata tag
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;

          SetLength(TempBarr,TempLWarr[0]); //read the block with the Metadata types
          Pt := @TempBarr[0]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^,Length(TempBarr));
          // Check what Matadata it contains:
          SumOfEntries := 0;  //Always there is One  this is the block describing the Entries
          SetLength(Param,4);
          //"ofni" which is reverse of "info": 69 6e 66 6f
          Param[3]  := $69;
          Param[2]  := $6e;
          Param[1]  := $66;
          Param[0]  := $6f;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SumOfEntries := SumOfEntries + pLongWord(@TempBarr[PosOfByteArr+4])^;
          End;
         //"lbal" which is reverse of "labl" = 6c 61 62 6c  (slice labels)
          Param[3]  := $6c;
          Param[2]  := $61;
          Param[1]  := $62;
          Param[0]  := $6c;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SetLength(Param,TempLWarr[SumOfEntries+1]);
            Pt := @Param[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset+TempLWarr[SumOfEntries], 0);
            FileRead(TiffFile, Pt^, Length(Param));
            TimeDimName := ''; //here used to get the Channel Name
            for PosCnt := 0 to High(Param) do begin
              if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
            end;
             ScopeSystemParams.Ch1_Name := TimeDimName;

            if (NrChannels = 2) then begin
              SetLength(Param,TempLWarr[SumOfEntries+2]);
              Pt := @Param[0]; // sets Pter to 1st position
              FileSeek(TiffFile, ValOffset+TempLWarr[SumOfEntries]+TempLWarr[SumOfEntries+1], 0);
              FileRead(TiffFile, Pt^, Length(Param));
              TimeDimName := ''; //here used to get the Channel Name
              for PosCnt := 0 to High(Param) do begin
                if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
              end;
              ScopeSystemParams.Ch2_Name := TimeDimName;
            end;
            SumOfEntries := SumOfEntries + pLongWord(@TempBarr[PosOfByteArr+4])^;

          End;

         //"gnar" which is reverse of "rang"  = 72 61 6e 67  = Display Range.
          SetLength(Param,4); //restore Length = 4
          Param[3]  := $72;
          Param[2]  := $61;
          Param[1]  := $6e;
          Param[0]  := $67;
          PosOfByteArr := BytePos(0,Param,TempBarr);
          If (PosOfByteArr > -1) then Begin
            SumOfEntries := SumOfEntries + pLongWord(@TempBarr[PosOfByteArr+4])^;
          End;

         //"stul" which is reverse of "luts"  = 6c 75 74 73;  =  (channel LUTs)
          Param[3]  := $6c;
          Param[2]  := $75;
          Param[1]  := $74;
          Param[0]  := $73;
          PosOfByteArr := BytePos(0,Param,TempBarr);
          If (PosOfByteArr > -1) and (NrChannels = 2) then Begin //Luts found
            PosOfByteArr := 0;
            for PosCnt := 0 to SumOfEntries do PosOfByteArr := PosOfByteArr + TempLWarr[PosCnt];

            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

            Pt := @FileColorTBL_Ch1[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset+PosOfByteArr, 0);
            FileRead(TiffFile, Pt^, 768);

            Pt := @FileColorTBL_Ch2[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset+PosOfByteArr+768, 0);
            FileRead(TiffFile, Pt^, 768);
            frmImageControl.ubFileColTable.Tag := 2;
          End;
        End //of Tag 50839 and ens of ImageJ private tags

          Else

        // -------------  Private NIKON NIS Elements Tags ----------------//
        If (tag = 65325)  then Begin  //time in ms
         // CountOfType := pLongWord(@IFD[2])^; // Always =  1
          ValOffset   := pLongWord(@IFD[4])^;
          If (PageCnt = 0) then begin
            TIFFfileType := TIFF_NIKON;
            SetLength(TimeSt, 1);
          end;
          Pt := @TimeSt[PageCnt]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, 8);
          //Time stamps are always the Same for both channels even though the images are recorded in different times
        End
          Else
        If (tag = 65326) and (PageCnt = 0) then begin //Pixel Size
         // CountOfType := pLongWord(@IFD[2])^; // Always =  1
          ValOffset  := pLongWord(@IFD[4])^;
          Pt := @PixSettings.FilePixSize;
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, 8);   //Returns microns/pixel
          PixSettings.FileHasOwnPixSize := True;
          //PixSize is set later in UpdatePixelSizeSettings
        End
          Else
        If (tag = 65328) and (PageCnt = 0) then begin //NrChannels
          CountOfType := pLongWord(@IFD[2])^;  //// Always =  1
          ValOffset   := pLongWord(@IFD[4])^;
          Pt := @TemDouble;
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, 8);   //Returns microns/pixel
          NrChannels  := Trunc(TemDouble); //returns the Integer part as Integer
        End

          Else

        If (tag = 65330) then begin  //the last image has it
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;

          SetLength(Tag65330_31,CountOfType);
          Pt := @Tag65330_31[0];
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);

          SetLength(Param,11);
          //d.Z.S.t.e.p =  64 00 5A 00 53 00 74 00 65 00 70
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $53;
          Param[5]  := 0;
          Param[6]  := $74;
          Param[7]  := 0;
          Param[8]  := $65;
          Param[9]  := 0;
          Param[10] := $70;

          PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in in the Value of the tag
         If (PosOfByteArr > -1) then Begin //pos found
           MovieSeriesType := Z_Stack;
            ZStepLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;

            SetLength(Param,11); //find Home position
            //d.Z.H.o.m.e = 64 00 5A 00 48 00 6F 00 6D 00 65
           // d.Z.H.o.m.e is 68 bytes before beg of d.Z.S.t.e.p
            Param[0]  := $64;
            Param[1]  := 0;
            Param[2]  := $5A;
            Param[3]  := 0;
            Param[4]  := $48;
            Param[5]  := 0;
            Param[6]  := $6F;
            Param[7]  := 0;
            Param[8]  := $6D;
            Param[9]  := 0;
            Param[10] := $65;

            PosOfByteArr := BytePos(PosOfByteArr - 100,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
            if (PosOfByteArr > -1) then begin
              ZHomeLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
            end;
         End
          Else
         If (PosOfByteArr = -1) then Begin //was not found in the byte array
          MovieSeriesType := TimeSeries;
         End;

         //search for B.i.n.n.i.n.g.:. . = 420069006E006E0069006E0067    00 3A 00 20 00
          SetLength(Param,18);
          Param[0]  := $42;
          Param[1]  := 0;
          Param[2]  := $69;
          Param[3]  := 0;
          Param[4]  := $6E;
          Param[5]  := 0;
          Param[6]  := $6E;
          Param[7]  := 0;
          Param[8]  := $69;
          Param[9]  := 0;
          Param[10] := $6E;
          Param[11] := 0;
          Param[12] := $67;
          Param[13]  := 0;
          Param[14] := $3A;
          Param[15] := 0;
          Param[16] := $20;
          Param[17] := 0;

          PosOfByteArr := BytePos(0,Param,Tag65330_31);  //searches for position of Param in the Value of the tag

          If (PosOfByteArr > -1) then Begin //pos found
          //the format is :1x1.  Here it gets the number before x
            PosOfByteArr := PosOfByteArr + 18;
            PixSettings.ImageBinning := StrToInt(AnsiChar(Tag65330_31[PosOfByteArr]));
          End
            else
          PixSettings.ImageBinning := 0;

        End //If (tag = 65330) then begin

          Else

        If (tag = 65331) then begin  //the last image has it
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;

          SetLength(Tag65330_31,CountOfType);
          Pt := @Tag65330_31[0];
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);

         If (MovieSeriesType = Z_Stack) then Begin
          SetLength(Param,21);
          //d.Z.P.o.s.i.t.i.o.n.0 = 64 00 5A    00 50 00 6F 00 73 00 69 00 74 00 69 00 6F 00 6E 00 30
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $50;
          Param[5]  := 0;
          Param[6]  := $6F;
          Param[7]  := 0;
          Param[8]  := $73;
          Param[9]  := 0;
          Param[10] := $69;
          Param[11] := 0;
          Param[12] := $74;
          Param[13] := 0;
          Param[14] := $69;
          Param[15] := 0;
          Param[16] := $6F;
          Param[17] := 0;
          Param[18] := $6E;
          Param[19] := 0;
          Param[20] := $30;

          PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
          if (PosOfByteArr > -1) then begin
            ZPosLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
          end;
        End; // If (MovieSeriesType = Z_Stack) then begin

        //find Channels Colors

        SetLength(Param,14);  //  C.o.l.o.r...      = 03 06 43 00 6F 00 6C 00 6F 00 72 00 00 00

        Param[0]  := $03;
        Param[1]  := $06;
        Param[2]  := $43;
        Param[3]  := 0;
        Param[4]  := $6F;
        Param[5]  := 0;
        Param[6]  := $6C;
        Param[7]  := 0;
        Param[8]  := $6F;
        Param[9]  := 0;
        Param[10] := $72;
        Param[11] := 0;
        Param[12] := 0;
        Param[13] := 0;

        PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile

        If (PosOfByteArr > -1) then Begin // Found C.o.l.o.r...

          //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
          TemCnt := 0;
          R := 1;
          ScopeSystemParams.Ch1_Name := '';
          while (R <> 6)  do begin
            R := Tag65330_31[PosOfByteArr+Length(Param)+16+TemCnt];
            if not(R in[0,6]) then ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(R);
            Inc(TemCnt);
          end;

          //Get Color of Channes
          R := Tag65330_31[PosOfByteArr+Length(Param)];
          G := Tag65330_31[PosOfByteArr+Length(Param)+1];
          B := Tag65330_31[PosOfByteArr+Length(Param)+2];

          frmImageControl.ubFileColTable.Tag := NrChannels;
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for TemCnt := 0 to 255 do begin
              FileColorTBL_Ch1[TemCnt] := round(ColDec*TemCnt);
            end;
          end
            else
          for TemCnt := 0 to 255 do
              FileColorTBL_Ch1[TemCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for TemCnt := 0 to 255 do begin
              FileColorTBL_Ch1[256+TemCnt] := round(ColDec*TemCnt);
            end;
          end
            else
          for TemCnt := 0 to 255 do
              FileColorTBL_Ch1[256+TemCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for TemCnt := 0 to 255 do begin
              FileColorTBL_Ch1[512+TemCnt] := round(ColDec*TemCnt);
            end;
          end
            else
          for TemCnt := 0 to 255 do
            FileColorTBL_Ch1[512+TemCnt] := 0;

          //check for 2nd channel
         If (NrChannels = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr+Length(Param),Param,Tag65330_31); //Gives Position of Param in the PartOfFile
          If (PosOfByteArr > -1) then Begin
             //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
            TemCnt := 0;
            R := 1;
            ScopeSystemParams.Ch2_Name := '';
            while (R <> 6)  do begin
              R := Tag65330_31[PosOfByteArr+Length(Param)+16+TemCnt];
              if not(R in[0,6]) then ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(R);
              Inc(TemCnt);
            end;
            //get channel colors
              R := Tag65330_31[PosOfByteArr+Length(Param)];
              G := Tag65330_31[PosOfByteArr+Length(Param)+1];
              B := Tag65330_31[PosOfByteArr+Length(Param)+2];
               if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
          if (R > 0) then begin
            ColDec := R/255;
            for TemCnt := 0 to 255 do begin
              FileColorTBL_Ch2[TemCnt] := round(ColDec*TemCnt);
            end;
          end
            else
          for TemCnt := 0 to 255 do
              FileColorTBL_Ch2[TemCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for TemCnt := 0 to 255 do begin
              FileColorTBL_Ch2[256+TemCnt] := round(ColDec*TemCnt);
            end;
          end
            else
          for TemCnt := 0 to 255 do
              FileColorTBL_Ch2[256+TemCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for TemCnt := 0 to 255 do begin
              FileColorTBL_Ch2[512+TemCnt] := round(ColDec*TemCnt);
            end;
          end
            else
          for TemCnt := 0 to 255 do
            FileColorTBL_Ch2[512+TemCnt] := 0;
          End;  ////if (PosOfByteArr > -1) then begin = String Found
         End; // If (NrChannelsLoc = 2) then Begin

       End; // If (PosOfByteArr > -1) then Begin // Found C.o.l.o.r...
         //--- End of Getting Colors & tables ----------//
       End; //If (tag = 65331) then begin  //the last image has it

      End;  //----------End of Nikon NIS Elements Private Tags -----------------//


      End //ActionMode = READ_AS_SINGLE
    {------------------------ End of Nikon NIS Elements Private Tags ---------------------------}

       Else { If 'ToSwap = false }

      { ------- End of Intel Files --------------------------------------- }

      { ------  Motorola Type of Files      --------------------------- }

      If (ToSwap) Then
      Begin

        If (Tag = 256) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then XimSize := Swap(IFD[4]) {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
            else
          if (TypeF = 4) then XimSize := SwapLongWord(pLongWord(@IFD[4])^); {LongWord = 4 byte unsigned int }
        End { of Tag = 256 }
        Else If (Tag = 257) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then YimSize := Swap(IFD[4]) {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
          else
          if (TypeF = 4) then YimSize := SwapLongWord(pLongWord(@IFD[4])^); {LongWord = 4 byte unsigned int }
        End { of Tag = 257 }

        Else If (Tag = 258) and (PageCnt = 0) { SHORT } Then
          BitsPix := Swap(IFD[4])

        Else If (Tag = 270) and (PageCnt = 0) { Image Description }
        { ******** October 4, 2017 introduced for MM files}

        Then Begin
          { ASCII type }
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(ImageDesc, CountOfType);
          Pt := @ImageDesc[1]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);
          if (AnsiStartsStr('ImageJ',ImageDesc)) then begin
            TIFFfileType := TIFF_ImageJ;
            PixSettings.FileHasOwnPixSize := False;
            PosCnt := PosEx('channels=', ImageDesc);
            if (PosCnt > 0) then NrChannels := StrToInt((Copy(ImageDesc, PosCnt + 9, 1))) else NrChannels := 1;
          end;
        End // If  'Tag = 270

        Else If (Tag = 273) Then
        Begin { could be SHORT or LONG [LONG in QED and Prarie] }
          { If more then One Image and Non-Overlapping StripOffsLoc
            subtracts the 1st offset from all and zeroies 1st offset at the end
            }
          if (PageCnt = 1) then begin
            if (Length(StripOffsLoc) > 1) then
              for TemCnt := 1 to High(StripOffsLoc) do StripOffsLoc[TemCnt] := StripOffsLoc[TemCnt] - StripOffsLoc[0];
          end;

          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);

          If (CountOfType > 1) Then
          Begin
            ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (PageCnt = 0) then
          Begin
            SetLength(StripOffsLoc, CountOfType);
            // Assuming that all images have the same number of StripOffsLoc
          End;

          If (TypeF = 3) Then
          Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := Swap(IFD[4]);
            End
            Else If (CountOfType > 1) Then
            Begin
              if (PageCnt > 0) then
              begin
                FileRead(TiffFile, TempWord, 2);
                StripOffsLoc[0] := Swap(TempWord);
              end
              else
              begin
                SetLength(TemWarr, CountOfType);
                Pt := @TemWarr[0];
                FileRead(TiffFile, Pt^, Length(TemWarr) * 2);
                for TemCnt := 0 to High(TemWarr) do
                  StripOffsLoc[TemCnt] := Swap(TemWarr[TemCnt]);
              end;
            End;
          End
          Else If (TypeF = 4) Then
          Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := SwapLongWord(pLongWord(@IFD[4])^);
            End
            Else If (CountOfType > 1) Then
            Begin
              if (PageCnt > 0) then
              begin
                Pt := @StripOffsLoc[0];
                FileRead(TiffFile, Pt^,4); // 2*2 = 4
                StripOffsLoc[0] := SwapLongWord(StripOffsLoc[0]);
              end
              else
              begin
                Pt := @StripOffsLoc[0];
                FileRead(TiffFile, Pt^,CountOfType*4);
                for TemCnt := 0 to High(StripOffsLoc) do
                  StripOffsLoc[TemCnt] := SwapLongWord(StripOffsLoc[TemCnt]);
              end;
            End;
          End; { of TypeF = 4 }
        End { of Tag = 273 }

        Else If (Tag = 277) and (PageCnt = 0) { SHORT } Then
        Begin
          SamplesPerPixel := Swap(IFD[4]); // if = 1 this is Grayscale or Palleted Color
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
        Else If (Tag = 278) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG; short in QED; LONG in Prarie }
          if (TypeF = 3) then RowsPerStrip := Swap(IFD[4]) {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
            else
          if (TypeF = 4) then RowsPerStrip := SwapLongWord(pLongWord(@IFD[4])^); {LongWord = 4 byte unsigned int}
        End { of Tag = 278 }
        Else If (Tag = 279) and (PageCnt = 0) Then
        Begin { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }
          { Size of Image Data in Bytes in one Strip officialy in TIFF terminology called = StripByteCounts }
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          SetLength(StripSizes,CountOfType);

          If (CountOfType > 1) Then
          Begin
            ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If CountOfType = 1 Then
            Begin
              StripSizes[0] := Swap(IFD[4]);
            End
            Else If CountOfType > 1 Then
            Begin
              SetLength(TemWarr, CountOfType);
              Pt := @TemWarr[0];
              FileRead(TiffFile, Pt^,CountOfType*2);
              for TemCnt := 0 to High(TemWarr) do
                StripSizes[TemCnt] := Swap(TemWarr[TemCnt]);
            End;
          End
          Else If (TypeF = 4) Then
          Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              StripSizes[0] := SwapLongWord(pLongWord(@IFD[4])^);
            End
            Else If (CountOfType > 1) Then
            Begin
              Pt := @StripSizes[0];
              FileRead(TiffFile, Pt^,CountOfType*4);
              for TemCnt := 0 to High(StripSizes) do
                StripSizes[TemCnt] := SwapLongWord(StripSizes[TemCnt]);
            End;
          End;
        End { of Tag = 279 }

          Else

        If (Tag = 282) and (TIFFfileType = TIFF_ImageJ) and (PageCnt = 0) Then Begin    //Tags 282 = Xresolution and 283 = Yresolution.  We need Only Xresolution since Xres = Yres
          //TypeF Always = 5 = RATIONAL (2 x Uint32, 1st nominator of a fraction, 2nd denominator; fraction = nominator/denominator)
          //CountOfType := SwapLongWord(pLongWord(@IFD[2])^);   Always = 1
          ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(TempLWarr,2);
          Pt := @TempLWarr[0]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, 8);
          for PosCnt := 0 to High(TempLWarr) do TempLWarr[PosCnt] := SwapLongWord(TempLWarr[PosCnt]);
          PixSettings.PixPer100Micr[SINGLE_BW_TIFF] := Round(100*(TempLWarr[0]/TempLWarr[1]));
          PixSettings.FilePixSize := 1/(TempLWarr[0]/TempLWarr[1]);
          PixSettings.FileHasOwnPixSize := True;
          PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] := True;
        End

          Else

        If (Tag = 320) and (PageCnt = 0) Then Begin    //this does not appear in QED Tiffs (MAC or PC type)
          if (TIFFfileType <> TIFF_ImageJ) Or ((TIFFfileType = TIFF_ImageJ) and (NrChannels = 1)) then begin

            { This field defines a Red-Green-Blue color map (often called a lookup table) for
              palette-color images. }

            PalettedColor := True;
            // TypeF = 3 = SHORT (always SHORT)(16-bit [2 byte] unsigned integer = Word [Pascal])
            CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
            {for Andor Tiff it is always One Color Table = CountOfType = 768  of Words
            even if the Number of Channels is > 1
            CountOfType = 768 of Words = 3 x 0 ..255 for each Color (Red, Green, Blue)}

            ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
            SetLength(TemWarr, CountOfType);
            Pt := @TemWarr[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset, 0);
            FileRead(TiffFile, Pt^, CountOfType * SizeOf(Word));

            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            for PosCnt := 0 to 767 do FileColorTBL_Ch1[PosCnt] := Swap(TemWarr[PosCnt]) shr 8;
            frmImageControl.ubFileColTable.Tag := 1;
          end;

        End { of Tag 320;  If 'last tag value }

           Else

        If (Tag = 50838) Then Begin  //ImageJ Metadata tag
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(TempLWarr,CountOfType);
          Pt := @TempLWarr[0]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType*4);
          for PosCnt := 0 to High(TempLWarr) do TempLWarr[PosCnt] := SwapLongWord(TempLWarr[PosCnt]);
        End //of Tag 50839
          Else
        If (Tag = 50839) Then Begin  //ImageJ Metadata tag
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);

          SetLength(TempBarr,TempLWarr[0]); //read the block with the Metadata types
          Pt := @TempBarr[0]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^,Length(TempBarr));

          // Check what Matadata it contains:

          SumOfEntries := 0;  //Always there is One  this is the block describing the Entries
          SetLength(Param,4);
          //"info": 69 6e 66 6f
          Param[0]  := $69;
          Param[1]  := $6e;
          Param[2]  := $66;
          Param[3]  := $6f;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SumOfEntries := SumOfEntries + SwapLongWord(pLongWord(@TempBarr[PosOfByteArr+4])^);
          End;

         //"labl" = 6c 61 62 6c  (slice labels)
          Param[0]  := $6c;
          Param[1]  := $61;
          Param[2]  := $62;
          Param[3]  := $6c;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found

          //MicroManagerMetadata (Tag = 51123 = 0xc7b3)
          //he value of the MicroManagerMetadata tag: image metadata (UTF-8 JSON)
            SetLength(Param,TempLWarr[SumOfEntries+1]);
            Pt := @Param[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset+TempLWarr[SumOfEntries], 0);
            FileRead(TiffFile, Pt^, Length(Param));
            TimeDimName := ''; //here used to get the Channel Name
            for PosCnt := 0 to High(Param) do begin
              if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
            end;
             ScopeSystemParams.Ch1_Name := TimeDimName;

            if (NrChannels = 2) then begin
              SetLength(Param,TempLWarr[SumOfEntries+2]);
              Pt := @Param[0]; // sets Pter to 1st position
              FileSeek(TiffFile, ValOffset+TempLWarr[SumOfEntries]+TempLWarr[SumOfEntries+1], 0);
              FileRead(TiffFile, Pt^, Length(Param));
              TimeDimName := ''; //here used to get the Channel Name
              for PosCnt := 0 to High(Param) do begin
                if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
              end;
              ScopeSystemParams.Ch2_Name := TimeDimName;
            end;
            SumOfEntries := SumOfEntries + SwapLongWord(pLongWord(@TempBarr[PosOfByteArr+4])^);

          End;

         //"rang"  = 72 61 6e 67  = Display Range. This is NOT the Bit Depth.  ImageJ tiff DOES NOT have the Actual Bit Depth
          SetLength(Param,4); //restore Length = 4
          Param[0]  := $72;
          Param[1]  := $61;
          Param[2]  := $6e;
          Param[3]  := $67;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SumOfEntries := SumOfEntries + SwapLongWord(pLongWord(@TempBarr[PosOfByteArr+4])^);
          End;

         //"luts"  = 6c 75 74 73;  =  (channel LUTs)
          Param[0]  := $6c;
          Param[1]  := $75;
          Param[2]  := $74;
          Param[3]  := $73;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) and (NrChannels = 2) then Begin //Luts found
            PosOfByteArr := 0;
            for PosCnt := 0 to SumOfEntries do PosOfByteArr := PosOfByteArr + TempLWarr[PosCnt];

            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

            Pt := @FileColorTBL_Ch1[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset+PosOfByteArr, 0);
            FileRead(TiffFile, Pt^, 768);

            Pt := @FileColorTBL_Ch2[0]; // sets Pter to 1st position
            FileSeek(TiffFile, ValOffset+PosOfByteArr+768, 0);
            FileRead(TiffFile, Pt^, 768);
            frmImageControl.ubFileColTable.Tag := 2;
          End;
        End; //of Tag 50839

      End; { of ToSwap = True }

      /// /////////////// End of Swap and NoSwap ///////////////////////////////

      { HERE we have Swap and No Swap files = MM and II type for easyness }

      If (Tag = 305) and (PageCnt = 0) Then
      Begin { Public Tag ASCII = Software Used }
        { 'this Tag is used by QED to put comment: "QED Camera Plugin" or "Prairie Deep View" }

        If not(ToSwap) Then
        Begin
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
        End
        Else { ToSwap = True }
        If (ToSwap) Then
        Begin
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
        End; { ToSwap = False }


        SetLength(ReadStr, CountOfType);
        Pt := @ReadStr[1]; // sets Pter to 1st position
        FileSeek(TiffFile, ValOffset, 0);
        FileRead(TiffFile, Pt^, CountOfType);
        TemStr := Copy(ReadStr, 1, 6);
        { Copy ( Source : string; StartChar, Count : Integer ) : string; }

        If (TemStr = 'QED In') or (TemStr = 'InVivo') Then
        Begin
          TIFFfileType := TIFF_QED;
          NrChannels := 1;
          // the Latest versions QED say "InVivo", the earliest - "QED InVivo"
        End
          Else
        Begin
          TemStr := Copy(ReadStr, 1, 7);
          if TemStr = 'Prairie' then begin
            TIFFfileType := TIFF_NORAN_PRARIE;
            NrChannels := 1;
          end;
        End;
        { Noran gives 22 char long string : "Prairie Deep View 1.0" }

      End; { If  'Tag = 305 }

      { ------------------- QED private TAG with Semi-Known Function -------- }

      { it can be read as Motorolla or Intel; Put them togheter for Easyness }
      If (Tag = 34988) then
      begin
        // This is QED private Tag Pts to a byte array  }
        // So far discovered bit-dept and  microns per pixel value
        If not(ToSwap) Then
        Begin
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
        End
          Else { ToSwap = True }
        If (ToSwap) Then
        Begin
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
        End; { ToSwap = False }

        FileSeek(TiffFile, ValOffset + 46, 0);
        // here is the bit-dept !!! (as Word)
        FileRead(TiffFile, TempWord, 2);
        if ToSwap = True then
          shrFact := Swap(TempWord) - 8
        else if ToSwap = False then
          shrFact := TempWord - 8;
        { shrFactMax = bit-dept - 8 }

        FileSeek(TiffFile, ValOffset + 298, 0); // here is microns per pixel value (as Single)
        FileRead(TiffFile, Singl, 4); { Gives Microns per pixel!! }
        if (ToSwap) then Singl := SwapSingle(Singl);

        PixSettings.FilePixSize := Singl;
      End; // of Tag = 34988

    End; { For Cnt := 0 To CntDE - 1  Do Begin }
    { ------------------ End of QED private TAG with Semi-Known Function ---------------------- }


   { *********************************  End of Reading TAGs ***************************}

    If (SamplesPerPixel = 1) AND
      (((ActionMode = READ_AS_SINGLE) or
          (ActionMode = READ_AS_COLLECTION)) Or
        ((NrPages = 1) and (ActionMode = READ_AS_STACK))) then
    Begin

      // Grayscale and Color Palleted have 1 per Pixel
      { if Strips are contiguous then reduces them //
         with this Time for 500 im (512x512) was shorten from 14 to 13 sec }

      If (PageCnt = 0) and ( High(StripOffsLoc) > 0) then
      Begin
        TemCnt := 0; // counts How Many Times The Overlap
        ValOffset := 0; // Counts How Many Time They Did Not Overlap (= 0 if They Always Overlap)
        For PosCnt := 0 to High(StripOffsLoc) - 1 do
        Begin
          if StripSizes[PosCnt] + StripOffsLoc[PosCnt] = StripOffsLoc[PosCnt + 1] then
          begin
            Inc(TemCnt);
            StripSizes[ValOffset] := StripSizes[ValOffset] + StripSizes[PosCnt + 1];
          end
          else if StripSizes[PosCnt] + StripOffsLoc[PosCnt] <> StripOffsLoc[PosCnt + 1] then
          begin
            Inc(ValOffset);
          end;
        End;

        SetLength(StripOffsLoc,  Length(StripOffsLoc)  - TemCnt);
        SetLength(StripSizes, Length(StripSizes) - TemCnt);

      End; // If High(StripOffsLoc) > 0

      { end of reducing number of StripOffs & StripSizes }

      { *** Here Decides if this a Multipage File
        Should it Load All Images -
        Yes if Single TIFF file was chosen
        No if Stack of TIFFs was chosen
        }

      If (PageCnt = 0) then
      Begin
        { Does this Only For the First Page }
        If (TIFFfileType <> TIFF_ANDOR_iQ) then
        Begin
          FindFirst(FName, faAnyFile, SearchRec);
          NrPages := SearchRec.Size div (XimSize * YimSize * (BitsPix div 8));
          FindClose(SearchRec); // free resourses
          SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType = TIFF_NIKON) then  SetLength(ZstackArr, NrPages);
        End;

        if ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
          and (NrPages > 1) then
        begin
          if frmProgress = nil then
          begin
            Application.CreateForm(TfrmProgress, frmProgress);
            frmProgress.Show;
          end;
          frmProgress.ImageProgressBar.Max := NrPages - 1;
          frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
            + ' (' + IntToStr(NrPages) + ' frames)';
          Application.ProcessMessages;
        end;
      End; // If (GetAllPages) and (PageCnt = 0)

      If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
        and (NrPages > 1) then
      Begin

        if frmProgress = nil then
        begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
          frmProgress.ImageProgressBar.Max := NrPages - 1;
        end;
        frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
          + ' (' + IntToStr(NrPages) + ' frames)';
        frmProgress.ImageProgressBar.Position := PageCnt;
        Application.ProcessMessages;

        FPos := FPos + 12;

        FileSeek(TiffFile, FPos, 0); // looks for next image
        FileRead(TiffFile, ValOffset, 4);

        if (ToSwap) { Motorola } then ValOffset := SwapLongWord(ValOffset);

        ImOff[0,PageCnt + StartPage] := StripOffsLoc[0]; //StripOffs are Contiguous for All Movies So far

        If (ValOffset <> 0) then
        Begin // more then One image
          OffsIFD := ValOffset;
          Inc(PageCnt);

          GoTo ReadAgain;

        End;
        // !!!!!!!!!!!!!!!!!!!!!!!!!!! End of LOOP  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

        { zeroies 1st StripOffs if more then one image }
        if (PageCnt > 0) and (Length(StripOffsLoc) > 1) then
          StripOffsLoc[0] := 0;

        if frmProgress <> nil then
          frmProgress.Close;

        If (TIFFfileType <> TIFF_ANDOR_iQ) then
        Begin
          { finalizes Nr of Pages and trims arrays }
          NrPages := PageCnt + 1;
          if (TIFFfileType = TIFF_ImageJ) then SetLength(TimeSt, NrPages div NrChannels) else SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType <> TIFF_NIKON) then begin
            ImageTime := 1 / PixSettings.FramesPerSec[1]; // [0] for Stack
            TimeSt[0] := 0;
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := TimeSt[Cnt-1] + ImageTime;
            if (TIFFfileType <> TIFF_ImageJ) then NrChannels := 1; //for all Generic tiff and QED tiff
          end
            else
          if (TIFFfileType = TIFF_NIKON) then begin
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := (TimeSt[Cnt] - TimeSt[0])/1000; //convert ms to sec
            TimeSt[0] := 0;
            if (MovieSeriesType = Z_Stack) then begin
              ZstackUnits := ' µm';
              if (Length(ZstackArr) <> NrPages div NrChannels) then SetLength(ZstackArr,NrPages div NrChannels);
              for Cnt := 0 to High(ZstackArr) do  ZstackArr[Cnt] := 0;
              if (ZPosLoc < ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] + ZStepLoc;
                end;
              end
                else
              if (ZPosLoc > ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] - ZStepLoc;
                end;
              end;
            end else
              SetLength(ZstackArr,0);
          end; //if (TIFFfileType = TIFF_NIKON) then begin
        End; // If (TIFFfileType <> TIFF_ANDOR)

      End; // If (GetAllPages) and (NrPages > 1)

      { at the End }
    End; // If SamplesPerPixel = 1

    { ------------------------------------------------------------------------------ }
    { Sets Global Variables }
    If (SamplesPerPixel = 1) AND (((ActionMode in [READ_AS_SINGLE,
          READ_AS_COLLECTION])) OR ((NrPages = 1) and
          (ActionMode = READ_AS_STACK)))

      Then
    Begin // Grayscale and Color Palleted have 1 per Pixel

      imXsize := XimSize;
      imYsize := YimSize;
      ImagePix := imXsize * imYsize;
      BitCount := BitsPix;

        //Transfer to Global StripOffs
      SetLength(StripOffs,Length(StripOffsLoc));
      for Cnt  := 0 to High(StripOffsLoc) do begin
        StripOffs[Cnt] := StripOffsLoc[Cnt]; //load Offset for each channel
      end;

      If (TIFFfileType in [TIFF_GENERIC,TIFF_ImageJ]) then Begin
        if (TIFFfileType <> TIFF_ImageJ) then NrChannels := 1;
        if (TIFFfileType = TIFF_GENERIC) then PixSettings.FileHasOwnPixSize := False;
        if BitsPix = 16  then shrFact := 8
          else // 16 bit - 8 bit [image buffer] = 8
        if BitsPix = 8 then shrFact := 0;
      End

        Else

      If (TIFFfileType = TIFF_QED) then Begin
        PixSettings.FileHasOwnPixSize := True;
      End

        Else

      If (TIFFfileType = TIFF_NORAN_PRARIE) then Begin
        PixSettings.FileHasOwnPixSize := False; // so far
        shrFact := 4; { 12 bit Dept }  // 12 bit - 8 bit [image buffer] = 4
      End

        Else

      If (TIFFfileType = TIFF_ANDOR_iQ) then
      Begin
        PixSettings.FileHasOwnPixSize := True;

        If (NrPages > 1) Then
        Begin
          { First Do the Time }
          If (DimTime > -1) Then
          Begin
            if (MM_HEAD.DimInfo[DimTime].Resolution <> 1) then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] * MM_HEAD.DimInfo[DimTime]
                  .Resolution;
            if (MM_HEAD.DimInfo[DimTime].Origin <> 0) then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] + MM_HEAD.DimInfo[DimTime].Origin;

            { always subtract the 1st image time }
            if (ActionMode = READ_AS_SINGLE) then begin
                for PosCnt := 1 to High(TimeSt) do
                  TimeSt[PosCnt] := TimeSt[PosCnt] - TimeSt[0];
                TimeSt[0] := 0;

              if (DimNotTime <> -1) then begin
                if (ZstackArr[High(ZstackArr)] > ZstackArr[0]) then begin
                  for PosCnt := 1 to High(ZstackArr) do
                  ZstackArr[PosCnt] := ZstackArr[PosCnt] - ZstackArr[0];
                  ZstackArr[0] := 0;
                end
                  else
                if (ZstackArr[High(ZstackArr)] < ZstackArr[0]) then begin
                  for PosCnt := 0 to High(ZstackArr)-1 do
                  ZstackArr[PosCnt] := ZstackArr[PosCnt] - ZstackArr[High(ZstackArr)];
                  ZstackArr[High(ZstackArr)] := 0;
                end
              end; //if (DimNotTime <> -1)
            end; //if (ActionMode = READ_AS_SINGLE) then begin

            if MM_HEAD.DimInfo[DimTime].Units = 'ms' then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] / 1000
              else if MM_HEAD.DimInfo[DimTime].Units = 'µs' then
                for PosCnt := StartPage to (StartPage + NrPages - 1) do
                  TimeSt[PosCnt] := TimeSt[PosCnt] / 1000000;
          End; // If (DimTime > 0

          { Next Do the Other Dimension, if Any }
          If (DimNotTime > -1) Then
          Begin
            if (MM_HEAD.DimInfo[DimNotTime].Resolution <> 1) then
              for PosCnt := 0 to High(ZstackArr) do
                ZstackArr[PosCnt] := ZstackArr[PosCnt]
                  * MM_HEAD.DimInfo[DimNotTime].Resolution;
            if (MM_HEAD.DimInfo[DimNotTime].Origin <> 0) then
              for PosCnt := 0 to High(ZstackArr) do
                ZstackArr[PosCnt] := ZstackArr[PosCnt]
                  + MM_HEAD.DimInfo[DimNotTime].Origin;

          End; // If (DimNotTime > 0
        End; // If (NrPages > 1)
        { Finally Decrease Values so to start from Zero }
        if (DimTime > -1) then Dec(DimTime, 2);
        if (DimNotTime > -1) then Dec(DimNotTime, 2);



      End; // If TIFFfileType = ANDOR_TIFF
    End; {If (SamplesPerPixel = 1) AND (((ActionMode in [READ_AS_SINGLE,
          READ_AS_COLLECTION])) OR ((NrPages = 1) and
          (ActionMode = READ_AS_STACK))) }

  End;

  { --------------------------------------------------- }
  FileClose(TiffFile);

End; // Procedure GetTIFFfileInfo

{ **************************************************************************** }

Procedure GetBigTIFFfileInfo(Var NrPages: LongWord;  Const FName: AnsiString; Const StartPage: Longint;
                              Const ActionMode: Byte; Const SilentMode: Boolean);

{ StartPage is used for Collection of Andor Files Only to place Time Stamps and Image offsets at
  the approprate place }

Label ReadAgain;

Var
  TiffFile  : THandle;
  FPos      : UInt64; // this actually not File Position but position of the File in RAM
  BegRead   : UInt64;
  SearchRec : TSearchRec;
  Cnt       : LongInt; { 'Counter }
  LocCnt    : Integer; {Local Counter}
  PosCnt    : Integer; {Local Counter}
  SamplesPerPixel: Word; // This is Tag 277; Not Required for Grayscale or Palleted Color
  // it is 3 for 245 bit Color
  PalettedColor: Boolean;
  Pt     : Pointer;

  { ----------- Variables For the Final Output  ---------------- }
  XimSize       : LongWord; { Tag = 256; TypeF = 3 }
  YimSize       : LongWord; { Tag = 257  TypeF = 3 }
  BitsPix       : Word; { Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology" }
  RowsPerStrip  : LongWord; // Tag = 278  TypeF = 3 or 4; Rows per Strip
  BigStripSizesLoc : array of UInt64; //it will be transfered to Global StripSizes : array of Longword
  // Global is StripOffs); Tag = 273  TypeF = 4 'Strip Offset
  // StripSizes : array of Longword; GLOBAL; Tag = 279  TypeF = 4 or 3'Size of each strip (QED has just 1) in bytes
  TemWarr       : array of Word;     //2 bytes Unsigned Int
  TemLWarr      : array of LongWord;  //4 bytes Unsigned Int

  { ------------------------------------------------------------------------- }
  sType         : array [0 .. 1] of AnsiChar;
  IfThisIsTIFF  : Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  BigOffsIFD    :  UInt64;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  BigCntDE      : UInt64;
  BigIFD        : array [0 .. 19] of Byte;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag           : Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF         : Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }

  CountOfType  : LongWord; // 'Byte 4-7; number of the indicated Type (Always LongWord)
  BigValOffset : UInt64; // 'Byte 8-11;  Value or Offset of the  Value. E.g. we need offset for
  PageCnt      : Integer;
  ImageTime    : Double; // For Time Stamps of Generic Multipage Tiffs
  //NERW NIKON TIFF VARs
  Tag65330_31  : TDynByteArray;
  Param : TDynByteArray;
  PosOfByteArr : integer;
  ZStepLoc,ZHomeLoc,ZPosLoc : Double;
  R,G,B        : Byte;
  ColDec       : Double;


BEGIN

  { Initializations }
  TIFFfileType := TIFF_GENERIC; // initializes to this
  SamplesPerPixel := 1;
  PageCnt := 0;
  NrPages := 1;
  PalettedColor := False;
  { end with Initializations }

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  FPos := 0;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, sType, 2);

  FPos := 2;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, IfThisIsTIFF, 2);

  { ---------------------------------------------------- }

  If (IfThisIsTIFF = 43) and (sType = 'II') Then
  BEGIN { This is  Tiff File }
    ToSwap := False;

    FPos := 8;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, BigOffsIFD, 8);

    { FPos := BigOffsIFD + 8; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
    BegRead := BigOffsIFD + 8;

    // This Label Makes the Loop for multiimage TIFFs//
  ReadAgain :

    FPos := BigOffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, BigCntDE, 8); { 'Gets Number of Entrees in IDF }

    { FPos := BigOffsIFD + 8; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
    BegRead := BigOffsIFD + 8;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To BigCntDE - 1 Do
    Begin

      FPos := BegRead + Cnt * 20; {  20 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, BigIFD, 20); { Gets each CntDE each 12 byte Entries }
      Tag   := pWord(@BigIFD[0])^; { bytes 0-1 }
      TypeF := pWord(@BigIFD[2])^; { bytes 2-3 } { Type of data ; short, long etc. }


       { ------- I N T E L     Type  ------- }

       If (Tag = 256) Then Begin { could be SHORT or LONG }      //  4 or 12
          if (TypeF = 3) then XimSize := pWord(@BigIFD[12])^ {Short = Word(Pascal) 2 byte,  {bytes 12-13 }
            else
          if (TypeF = 4) then XimSize := pLongWord(@BigIFD[12])^; {LongWord = 4 byte unsigned int }
       End { of Tag = 256 }
         Else
       If (Tag = 257) Then Begin { could be SHORT or LONG }
          if (TypeF = 3) then YimSize := pWord(@BigIFD[12])^ {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
          else
          if (TypeF = 4) then YimSize := pLongWord(@BigIFD[12])^; {LongWord = 4 byte unsigned int }
       End { of Tag = 257 }
          Else
       If (Tag = 258) Then
          { SHORT C++ } BitsPix := pWord(@BigIFD[12])^
          Else
       If (Tag = 273) Then Begin { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }
          CountOfType := pLongWord(@BigIFD[4])^;
          SetLength(StripOffs,CountOfType);
          {regular tiff Andor gives TypeF = 4, CountOfType = 64
           BigTiff Andor gives      TypeF =16, CountOfType = 64  }
          If (CountOfType > 1) Then Begin
            BigValOffset := pUInt64(@BigIFD[12])^;
            FileSeek(TiffFile, BigValOffset, 0);
          End;

          If (TypeF = 3) Then Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If (CountOfType = 1) Then Begin
              StripOffs[0] := pWord(@BigIFD[12])^;
            End
              Else
            If (CountOfType > 1) Then Begin
              //since StripOffsLoc is LongWord 1st data is read to Word Array
              //and then transfered to StripOffsLoc
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile,Pt^,CountOfType*2);
              for LocCnt := 0 to High(StripOffs) do
                StripOffs[LocCnt] := TemWArr[LocCnt];
            End;
          End
            Else
          If (TypeF = 4) Then Begin // LONG = LongWord  (4 bytes)
            If (CountOfType = 1) Then Begin
              StripOffs[0] := pLongWord(@BigIFD[12])^
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemLWArr,CountOfType);
              Pt := @TemLWArr[0];
              FileRead(TiffFile,Pt^,CountOfType*4);
              for LocCnt := 0 to High(StripOffs) do
                StripOffs[LocCnt] := TemLWArr[LocCnt];
            End;
          End { of TypeF = 4 }
            Else
          If (TypeF = 16) Then Begin // UInt64 (8 bytes)
            If (CountOfType = 1) Then
            Begin
              StripOffs[0] := pUInt64(@BigIFD[12])^
            End
              Else
            If (CountOfType > 1) Then
            Begin
              Pt := @StripOffs[0];
              FileRead(TiffFile, Pt^,CountOfType*8);
            End;
          End; { of TypeF = 16 }
        End { of Tag = 273 }

          Else

        If (Tag = 277) { Word, Count = 1 } Then Begin
          SamplesPerPixel := pWord(@BigIFD[12])^; // if = 1 this is Grayscale or Palleted Color
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
          Else
        If (Tag = 278) Then Begin
          if (TypeF = 3) then RowsPerStrip := pWord(@BigIFD[12])^ {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
            else
          if (TypeF = 4) then RowsPerStrip := pLongWord(@BigIFD[12])^; {LongWord = 4 byte unsigned int}
        End { of Tag = 278 }

          Else

        If (Tag = 279) Then Begin { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }
          { Size of Image Data in Bytes in one Strip officialy in TIFF terminology called = StripByteCounts }
          CountOfType := pLongWord(@BigIFD[4])^;  //Gives TypeF = 16 (UInt64), CountOfType =64
          SetLength(BigStripSizesLoc, CountOfType);

          If (CountOfType > 1) Then Begin
            BigValOffset := pUInt64(@BigIFD[12])^;
            FileSeek(TiffFile, BigValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If (CountOfType = 1) Then Begin
              BigStripSizesLoc[0] := pWord(@BigIFD[12])^;
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile, Pt^, CountOfType * 2);
              for LocCnt := 0 to High(BigStripSizesLoc) do
                BigStripSizesLoc[LocCnt] := TemWArr[LocCnt];
            End;
          End
            Else
          If (TypeF = 4) Then Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              BigStripSizesLoc[0] := pLongWord(@BigIFD[12])^;
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemLWArr[0];
              FileRead(TiffFile, Pt^, CountOfType * 4);
              for LocCnt := 0 to High(BigStripSizesLoc) do
                BigStripSizesLoc[LocCnt] := TemLWArr[LocCnt];
            End;
          End
            Else
          If (TypeF = 16) Then Begin // = UInt64 (8bytes)
            If (CountOfType = 1) Then
            Begin
              BigStripSizesLoc[0] := pUInt64(@BigIFD[12])^
            End
            Else If (CountOfType > 1) Then
            Begin
              Pt := @BigStripSizesLoc[0];
              FileRead(TiffFile, Pt^, CountOfType* 8);
            End;
          End;
        End { of Tag = 279 }

          Else

        If (Tag = 281) and (PageCnt = 0) then Begin //MaxSampleValue //Type 3 Word
        //Used by Nikon NIS Tiff to write bit depth: 8 bit gives 255; 14 bit gives 16383, 16 bit gives  -1
          if (pWord(@BigIFD[12])^ > 0) then
          shrFact := round(Log2(pWord(@BigIFD[12])^ + 1)) - 8 else
          shrFact := 8; //sets it to 16 bit

        End //of (Tag =

          Else

        If (Tag = 320) Then Begin
           {Nikon Does Not Use this Tag if needed copy the paragraph from 2 channels from "regular" GetTIFFInfo}
          { This field defines a Red-Green-Blue color map (often called a lookup table) for
            palette-color images. }

        End; { of Tag 320;  If 'last tag value }

       {----------------End of --- Windows Public  Tags ------------------------}

      if (ActionMode = READ_AS_SINGLE) then Begin
        // for now Private NIKON NIS Elements Tiifs are open only as Single Tiff NOT as Stack of Tiffs

        If (tag = 65325)  then Begin  //time in ms
        // CountOfType := pLongWord(@BigIFD[4])^;  // Always =  1
          If (PageCnt = 0) then begin
            TIFFfileType := TIFF_NIKON;
            SetLength(TimeSt, 1);
          end;
          TimeSt[PageCnt] := pDouble(@BigIFD[12])^;
           //Time stamps are always the Same for both channels even though the images are recorded in different times
        End
          Else
        If (tag = 65326) and (PageCnt = 0) then begin //Pixel Size
         //CountOfType := pLongWord(@BigIFD[4])^;  // Always =  1
          PixSettings.FilePixSize := pDouble(@BigIFD[12])^;//Returns microns/pixel
          PixSettings.FileHasOwnPixSize := True;
          //PixSize is set later in UpdatePixelSizeSettings
        End
          Else
        If (tag = 65328) and (PageCnt = 0) then begin //NrChannels
            // CountOfType := pLongWord(@BigIFD[4])^;  //// Always =  1
          NrChannels  := Trunc(pDouble(@BigIFD[12])^); //returns the Integer part as Integer
        End

          Else

        If (tag = 65330) then begin  //Only the Last image has it
          CountOfType  := pLongWord(@BigIFD[4])^;
          BigValOffset := pUInt64(@BigIFD[12])^;

          SetLength(Tag65330_31,CountOfType);
          Pt := @Tag65330_31[0];
          FileSeek(TiffFile, BigValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);

          // Check if this is a Z stack movie.  If d.Z.S.t.e.p exists then this is Z stack movie
          SetLength(Param,11);
          //d.Z.S.t.e.p =  64 00 5A 00 53 00 74 00 65 00 70
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $53;
          Param[5]  := 0;
          Param[6]  := $74;
          Param[7]  := 0;
          Param[8]  := $65;
          Param[9]  := 0;
          Param[10] := $70;

          //ASCII code for Digits are in  48-57 decimal value
          PosOfByteArr := BytePos(0,Param,Tag65330_31);  //searches for position of Param in the Value of the tag

         If (PosOfByteArr > -1) then Begin ////this is Z stack movie
           MovieSeriesType := Z_Stack;
           ZStepLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;

           SetLength(Param,11); //find Home position
            //d.Z.H.o.m.e = 64 00 5A 00 48 00 6F 00 6D 00 65
           // d.Z.H.o.m.e is 68 bytes before beg of d.Z.S.t.e.p
           Param[0]  := $64;
           Param[1]  := 0;
           Param[2]  := $5A;
           Param[3]  := 0;
           Param[4]  := $48;
           Param[5]  := 0;
           Param[6]  := $6F;
           Param[7]  := 0;
           Param[8]  := $6D;
           Param[9]  := 0;
           Param[10] := $65;

           PosOfByteArr := BytePos(PosOfByteArr - 100,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
           if (PosOfByteArr > -1) then begin
            ZHomeLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
           end;
         End
          Else
         If (PosOfByteArr = -1) then Begin //was not found in the byte array
          MovieSeriesType := TimeSeries;
         End;

         //search for B.i.n.n.i.n.g.:. . = 420069006E006E0069006E0067    00 3A 00 20 00
          SetLength(Param,18);
          Param[0]  := $42;
          Param[1]  := 0;
          Param[2]  := $69;
          Param[3]  := 0;
          Param[4]  := $6E;
          Param[5]  := 0;
          Param[6]  := $6E;
          Param[7]  := 0;
          Param[8]  := $69;
          Param[9]  := 0;
          Param[10] := $6E;
          Param[11] := 0;
          Param[12] := $67;
          Param[13]  := 0;
          Param[14] := $3A;
          Param[15] := 0;
          Param[16] := $20;
          Param[17] := 0;

          PosOfByteArr := BytePos(0,Param,Tag65330_31);  //searches for position of Param in the Value of the tag

          If (PosOfByteArr > -1) then Begin //pos found
          //the format is :1x1.  Here it gets the number before x
            PosOfByteArr := PosOfByteArr + 18;
            PixSettings.ImageBinning := StrToInt(AnsiChar(Tag65330_31[PosOfByteArr]));
          End
            else
          PixSettings.ImageBinning := 0;

        End //If (tag = 65330) then begin

          Else

        If (tag = 65331) then begin  //the last image has it
          CountOfType  := pLongWord(@BigIFD[4])^;
          BigValOffset := pUInt64(@BigIFD[12])^;

          SetLength(Tag65330_31,CountOfType);
          Pt := @Tag65330_31[0];
          FileSeek(TiffFile, BigValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);

         If (MovieSeriesType = Z_Stack) then Begin
          SetLength(Param,21);
          //d.Z.P.o.s.i.t.i.o.n.0 = 64 00 5A    00 50 00 6F 00 73 00 69 00 74 00 69 00 6F 00 6E 00 30
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $50;
          Param[5]  := 0;
          Param[6]  := $6F;
          Param[7]  := 0;
          Param[8]  := $73;
          Param[9]  := 0;
          Param[10] := $69;
          Param[11] := 0;
          Param[12] := $74;
          Param[13] := 0;
          Param[14] := $69;
          Param[15] := 0;
          Param[16] := $6F;
          Param[17] := 0;
          Param[18] := $6E;
          Param[19] := 0;
          Param[20] := $30;

          PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
          if (PosOfByteArr > -1) then begin
            ZPosLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
          end;
        End; // If (tag = 65331) then begin

        SetLength(Param,14);
        //  C.o.l.o.r...      = 03 06 43 00 6F 00 6C 00 6F 00 72 00 00 00

        Param[0]  := $03;
        Param[1]  := $06;
        Param[2]  := $43;
        Param[3]  := 0;
        Param[4]  := $6F;
        Param[5]  := 0;
        Param[6]  := $6C;
        Param[7]  := 0;
        Param[8]  := $6F;
        Param[9]  := 0;
        Param[10] := $72;
        Param[11] := 0;
        Param[12] := 0;
        Param[13] := 0;

        PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile

         If (PosOfByteArr > -1) then Begin

          //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
          LocCnt := 0;
          R := 1;
          ScopeSystemParams.Ch1_Name := '';
          while (R <> 6)  do begin
            R := Tag65330_31[PosOfByteArr+Length(Param)+16+LocCnt];
            if not(R in[0,6]) then ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(R);
            Inc(LocCnt);
          end;

          //Get Color of Channes
          R := Tag65330_31[PosOfByteArr+Length(Param)];
          G := Tag65330_31[PosOfByteArr+Length(Param)+1];
          B := Tag65330_31[PosOfByteArr+Length(Param)+2];

          frmImageControl.ubFileColTable.Tag := NrChannels;
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[LocCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[256+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[256+LocCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[512+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[512+LocCnt] := 0;
          frmImageControl.ubFileColTable.Tag := 1;
        End;  //if (PosOfByteArr > -1) then begin = String Found

        If (NrChannels = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr+Length(Param),Param,Tag65330_31); //Gives Position of Param in the PartOfFile
         If (PosOfByteArr > -1) then Begin
             //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
            LocCnt := 0;
            R := 1;
            ScopeSystemParams.Ch2_Name := '';
            while (R <> 6)  do begin
              R := Tag65330_31[PosOfByteArr+Length(Param)+16+LocCnt];
              if not(R in[0,6]) then ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(R);
              Inc(LocCnt);
            end;
            //get channel colors
              R := Tag65330_31[PosOfByteArr+Length(Param)];
              G := Tag65330_31[PosOfByteArr+Length(Param)+1];
              B := Tag65330_31[PosOfByteArr+Length(Param)+2];
               if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[LocCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[256+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[256+LocCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[512+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[512+LocCnt] := 0;
          frmImageControl.ubFileColTable.Tag := 2;
          End;  ////if (PosOfByteArr > -1) then begin = String Found
        End; // If (NrChannelsLoc = 2) then Begin
         //--- End of Getting Colors & tables ----------//

      End;  //----------End of Nikon NIS Elements Private Tags -----------------//


      End; //ActionMode = READ_AS_SINGLE
    {------------------------ End of Nikon NIS Elements Private Tags ---------------------------}

    End; { For Cnt := 0 To CntDE - 1  Do Begin }

    /// ////////////////// End of Reading TAGs ////////////////////////////////////////

    If (SamplesPerPixel = 1) AND
      (((ActionMode = READ_AS_SINGLE) or
          (ActionMode = READ_AS_COLLECTION)) Or
        ((NrPages = 1) and (ActionMode = READ_AS_STACK))) then
    Begin

      // Grayscale and Color Palleted have 1 per Pixel
      { if Strips are contiguous then reduces them // with this Time for 500 im (512x512) was shorten from 14 to 13 sec }

      If (PageCnt = 0) and (High(StripOffs) > 0) then Begin
        LocCnt := 0; // counts How Many Times The Overlap
        BigValOffset := 0; // Counts How Many Time They Did Not Overlap (= 0 if They Always Overlap)

        For PosCnt := 0 to High(StripOffs) - 1 do Begin
          if (BigStripSizesLoc[PosCnt] + StripOffs[PosCnt] = StripOffs[PosCnt + 1]) then
          begin
            Inc(LocCnt);
            BigStripSizesLoc[BigValOffset] := BigStripSizesLoc[BigValOffset] + BigStripSizesLoc[PosCnt + 1];
          end
          else if BigStripSizesLoc[PosCnt] + StripOffs[PosCnt] <> StripOffs[PosCnt + 1] then
          begin
            Inc(BigValOffset);
          end;
        End;

        SetLength(StripOffs,  Length(StripOffs)  - LocCnt);
        SetLength(BigStripSizesLoc, Length(BigStripSizesLoc) - LocCnt);

      End; // If High(StripOffs) > 0


      { end of reducing number of StripOffs & StripSizes }

      { *** Here Decides if this a Multipage File
        Should it Load All Images -
        Yes if Single TIFF file was chosen
        No if Stack of TIFFs was chosen
        }

      If (PageCnt = 0) then Begin
        { Does this Only For the First Page }
        If (TIFFfileType <> TIFF_ANDOR_iQ) then
        Begin
          FindFirst(FName, faAnyFile, SearchRec);
          NrPages := SearchRec.Size div (XimSize * YimSize * (BitsPix div 8));
          FindClose(SearchRec); // free resourses
          SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType = TIFF_NIKON) then  SetLength(ZstackArr, NrPages);
        End;

        If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
          and (NrPages > 1) then
        Begin
          if (frmProgress = nil) then
          begin
            Application.CreateForm(TfrmProgress, frmProgress);
            frmProgress.lbAction.Caption :=  'Loaded in RAM.  Getting Info.';
            frmProgress.Show;
          end;
          frmProgress.ImageProgressBar.Max := NrPages - 1;
          frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
            + ' (' + IntToStr(NrPages) + ' frames)';
          Application.ProcessMessages;
        End;
      End; // If (GetAllPages) and (PageCnt = 0)

      If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
        and (NrPages > 1) then
      Begin

        if frmProgress = nil then
        begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
          frmProgress.ImageProgressBar.Max := NrPages - 1;
        end;
        frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
          + ' (' + IntToStr(NrPages) + ' frames)';
        frmProgress.ImageProgressBar.Position := PageCnt;
        Application.ProcessMessages;


        // Offset of next IFD = (Offset to 1st IDF Number) + 2 + 12*(Directory Entries)

        FPos := FPos + 20;

        FileSeek(TiffFile, FPos, 0); // looks for next image
        FileRead(TiffFile, BigValOffset, 8);

        ImOff[0,PageCnt + StartPage] := StripOffs[0]; //StripOffs are Contiguous for All Movies So far

        If (BigValOffset <> 0) then
        Begin // more then One image
          BigOffsIFD := BigValOffset;
          Inc(PageCnt);

          GoTo ReadAgain;

        End;
        // !!!!!!!!!!!!!!!!!!!!!!!!!!! End of LOOP  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

        { zeroies 1st StripOffs if more then one image }
        if (PageCnt > 0) and (Length(StripOffs) > 1) then
          StripOffs := 0;

        if frmProgress <> nil then
          frmProgress.Close;

        If (TIFFfileType <> TIFF_ANDOR_iQ) then
        Begin
          { finalizes Nr of Pages and trims arrays }
          NrPages := PageCnt + 1;
          SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType <> TIFF_NIKON) then begin
            ImageTime := 1 / PixSettings.FramesPerSec[1]; // [0] for Stack
            TimeSt[0] := 0;
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := TimeSt[Cnt-1] + ImageTime;
            NrChannels := 1;
          end
            else
          if (TIFFfileType = TIFF_NIKON) then begin
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := (TimeSt[Cnt] - TimeSt[0])/1000; //convert ms to sec
            TimeSt[0] := 0;
            if (MovieSeriesType = Z_Stack) then begin
              ZstackUnits := ' µm';
              if (Length(ZstackArr) <> NrPages div NrChannels) then SetLength(ZstackArr,NrPages div NrChannels);
              for Cnt := 0 to High(ZstackArr) do  ZstackArr[Cnt] := 0;
              if (ZPosLoc < ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] + ZStepLoc;
                end;
              end
                else
              if (ZPosLoc > ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] - ZStepLoc;
                end;
              end;
            end else
              SetLength(ZstackArr,0);
          end; //if (TIFFfileType = TIFF_NIKON) then begin
        End; // If (TIFFfileType <> TIFF_ANDOR)

      End; // If (GetAllPages) and (NrPages > 1)

      { at the End }
    End; // If SamplesPerPixel = 1

    { ------------------------------------------------------------------------------ }
    { Sets Global Variables }
    If (SamplesPerPixel = 1) AND (((ActionMode in [READ_AS_SINGLE,READ_AS_COLLECTION])) OR ((NrPages = 1) and
          (ActionMode = READ_AS_STACK)))

      Then
    Begin // Grayscale and Color Palleted have 1 per Pixel

      { TIFFfileType : Byte; {1 = Generic FrayScale TIFF, 2 = QED,
        3 = Prarie Technology, 4 = Andor }
      imXsize := XimSize;
      imYsize := YimSize;
      ImagePix := imXsize * imYsize;
      BitCount := BitsPix;

       // NIKON_TIFF was set with Tag 281

       //Transfer to Global StripOffs
      SetLength(StripSizes,Length(BigStripSizesLoc));
      for LocCnt  := 0 to High(BigStripSizesLoc) do begin
        StripSizes[LocCnt] := BigStripSizesLoc[LocCnt]; //load Offset for each channel
      end;

      If (TIFFfileType = TIFF_GENERIC) then Begin
        NrChannels := 1; // if NrIm is = 1 then NrChannels has not been set
        PixSettings.FileHasOwnPixSize := False;
        if BitsPix = 16 then
          shrFact := 8
        else // 16 bit - 8 bit [image buffer] = 8
          if BitsPix = 8 then
          shrFact := 0;
      End;

    End;

  End;

  { --------------------------------------------------- }
  FileClose(TiffFile);

End; // Procedure GetBigTIFFfileInfo

{ **************************************************************************** }

Procedure GetBigTIFFfileInfoFromRAM(const pRawData : pByteArr; Var NrPages: LongWord;
  Const FName: AnsiString; Const StartPage: Longint;
  Const ActionMode: Byte; Const SilentMode: Boolean);

{ StartPage is used for Collection of Andor Files Only to place Time Stamps and Image offsets at
  the approprate place }

Label ReadAgain;

Var
  { many var will be local; if Tiff = QED tiff; QEDtif is used by GetImgMgrfileInfo only
    then their Values will be transfered to Globals }

  FPos      : UInt64; // this actually not File Position but position of the File in RAM
  BegRead   : UInt64;
  SearchRec : TSearchRec;
  Cnt       : LongInt; { 'Counter }
  LocCnt    : Integer; {Local Counter}
  SamplesPerPixel: Word; // This is Tag 277; Not Required for Grayscale or Palleted Color
  // it is 3 for 245 bit Color
  PalettedColor: Boolean;
  { ToSwap := True if Motorola Type ('MM')  GLOBAL }

  { ----------- Variables For the Final Output  ---------------- }
  XimSize       : LongWord; { Tag = 256; TypeF = 3 }
  YimSize       : LongWord; { Tag = 257  TypeF = 3 }
  BitsPix       : Word; { Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology" }
  RowsPerStrip  : LongWord; // Tag = 278  TypeF = 3 or 4; Rows per Strip
  BigStripSizesLoc : array of UInt64; //it will be transfered to Global StripSizes : array of Longword
  TemWarr       : array of Word;     //2 bytes Unsigned Int
  TemLWarr      : array of LongWord;  //4 bytes Unsigned Int

  { ------------------------------------------------------------------------- }
  sType         : array [0 .. 1] of AnsiChar;
  IfThisIsTIFF  : Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  BigOffsIFD    :  UInt64;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  BigCntDE      : UInt64;
  BigIFD        : array [0 .. 19] of Byte;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag           : Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF         : Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }

  CountOfType : LongWord; // 'Byte 4-7; number of the indicated Type (Always LongWord)
  BigValOffset : UInt64; { 'Byte 8-11;  Value or Offset of the  Value. E.g. we need offset for
    'String QED Camera Plugin, but not for the other Variables }
  PageCnt: Integer;
  PosCnt : Integer;
  ImageTime: Double; // For Time Stamps of Generic Multipage Tiffs

   //NIKON TIFF VARs
   Tag65330_31    : TDynByteArray;
   Param          : TDynByteArray;
   PosOfByteArr   : integer;
   ZStepLoc,ZHomeLoc,ZPosLoc : Double;
   R,G,B        : Byte;
   ColDec       : Double;

BEGIN

  { Initializations }
  TIFFfileType    := TIFF_GENERIC; // initializes to this
  SamplesPerPixel := 1; // some files do not have Tag 277 where the value comes from
  PageCnt         := 0; // Counts Pages
  NrPages         := 1; // Number of Pages (Images) in Single TIFF
  PalettedColor   := False;
  { end with Initializations }

  FPos := 0;
  Move(pRawData[FPos],sType[0], 2);
  //we dont check here for Intel Type 'II' or Motorola 'MM' type.  All the code is for Intel type

  FPos := 2;
  IfThisIsTIFF := pWord(@pRawData[FPos])^;

  { ---------------------------------------------------- }

  If (IfThisIsTIFF = 43) and (sType = 'II') Then
  BEGIN { This is  Big Tiff File }

    ToSwap := False; // for now Only Intel kind of Files

    FPos := 8;
    BigOffsIFD := pUInt64(@pRawData[FPos])^; // finds the FPos for the first IFD (Counted From "0"

    { This Label Makes the Loop for multiimage TIFFs}
  ReadAgain :

    FPos     := BigOffsIFD; { 'Goes to the Byte of IDF }
    BigCntDE := pUInt64(@pRawData[FPos])^; { 'Gets Number of Entrees in IDF (64 bit, regular Tiff = 16 bit}

    { FPos := BigOffsIFD + 8; }{ goes to Pos 8 (counted from ) byte in IDF) }

    BegRead := BigOffsIFD + 8;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To BigCntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 20; { 20 bytes offset for each DE }
      Move(pRawData[FPos],BigIFD[0], 20); { Gets each CntDE each 12 byte Entries }
      Tag   := pWord(@BigIFD[0])^; { bytes 0-1 }
      TypeF := pWord(@BigIFD[2])^; { bytes 2-3 } { Type of data ; short, long etc. }

        // ---------------------------------------------------

      If (Tag = 256) and (PageCnt = 0) Then Begin
        if (TypeF = 3) then XimSize  := pWord(@BigIFD[12])^
          else
        if (TypeF = 4) then XimSize  := pLongWord(@BigIFD[12])^;
      End { of Tag = 256 }

        Else

      If (Tag = 257)  and (PageCnt = 0) Then Begin
        if (TypeF = 3) then YimSize  := pWord(@BigIFD[12])^
          else
        if (TypeF = 4) then YimSize  := pLongWord(@BigIFD[12])^;
      End { of Tag = 257 }

        Else

      If (Tag = 258)  and (PageCnt = 0) Then
        BitsPix  := pWord(@BigIFD[12])^

        Else

      If (Tag = 273) Then Begin
        if (PageCnt = 1) then begin
          if (Length(StripOffs) > 1) then
            for LocCnt := 1 to High(StripOffs) do StripOffs[LocCnt] := StripOffs[LocCnt] - StripOffs[0];
        end;

        CountOfType := pLongWord(@BigIFD[4])^;
        If (CountOfType > 1) Then BigValOffset := pUInt64(@BigIFD[12])^;

        If (PageCnt = 0) then SetLength(StripOffs, CountOfType);
            // Assuming that all image have the same number of StripOffsLoc

        If (TypeF = 3) Then Begin
          If (CountOfType = 1) Then Begin
            StripOffs[0] := pWord(@BigIFD[12])^
          End
            else
          If (CountOfType > 1) Then Begin
            if (PageCnt > 0) then
            StripOffs[0] := pWord(@pRawData[BigValOffset])^
            else begin
            SetLength(TemWarr,CountOfType);
            Move(pRawData[BigValOffset],TemWarr[0],CountOfType*2);
            for LocCnt := 0 to High(StripOffs) do
              StripOffs[LocCnt] := TemWarr[LocCnt];
            end;
          End;
        End
          Else
        If (TypeF = 4) Then Begin // LONG = LongWord
          If (CountOfType = 1) Then Begin
            StripOffs[0] := pLongWord(@BigIFD[12])^
          End
            else
          If (CountOfType > 1) Then Begin
            if (PageCnt > 0) then
              StripOffs[0] := pLongWord(@pRawData[BigValOffset])^
            else begin
              SetLength(TemLWarr,CountOfType);
              Move(pRawData[BigValOffset],TemLWarr[0],CountOfType*4);
              for LocCnt := 0 to High(StripOffs) do
              StripOffs[LocCnt] := TemLWarr[LocCnt];
            end;
          End;
        End { of TypeF = 4 }
          Else
        If (TypeF = 16) Then Begin
          If (CountOfType = 1) Then Begin
            StripOffs[0] := pUInt64(@BigIFD[12])^
          End
            Else
          If (CountOfType > 1) Then Begin
            if (PageCnt > 0) then
            StripOffs[0] := pUInt64(@pRawData[BigValOffset])^
            else
            Move(pRawData[BigValOffset],StripOffs[0],CountOfType*8);
          End;
        End; { of TypeF = 16 }
      End { of Tag = 273 }

        Else

      If (Tag = 277) and (PageCnt = 0)  Then Begin
          SamplesPerPixel := pWord(@BigIFD[12])^;
          if (SamplesPerPixel <> 1) then
            Break;
      End { of Tag = 277 }

        Else

      If (Tag = 278) and (PageCnt = 0) Then Begin
          if (TypeF = 3) then RowsPerStrip := pWord(@BigIFD[12])^
            else
          if (TypeF = 4) then RowsPerStrip := pLongWord(@BigIFD[12])^;
      End { of Tag = 278 }

        Else

      If (Tag = 279) and (PageCnt = 0) Then Begin
        CountOfType := pLongWord(@BigIFD[4])^;
        SetLength(BigStripSizesLoc, CountOfType);
        if (CountOfType > 1) then BigValOffset := pUInt64(@BigIFD[12])^;

        If (TypeF = 3) Then Begin
          if (CountOfType = 1) then begin
            BigStripSizesLoc[0] := pWord(@BigIFD[12])^;
          end
            else
          if (CountOfType > 1) then begin
            SetLength(TemWarr,CountOfType);
            Move(pRawData[BigValOffset],TemWarr[0],CountOfType*2);
            for LocCnt := 0 to High(BigStripSizesLoc) do
            BigStripSizesLoc[LocCnt] := TemWarr[LocCnt];
          end;
        End
          Else
        If (TypeF = 4) Then Begin
          if (CountOfType = 1) then begin
            BigStripSizesLoc[0] := pLongWord(@BigIFD[12])^;
          end
            else
          if (CountOfType > 1) then begin
            SetLength(TemLWarr,CountOfType);
            Move(pRawData[BigValOffset],TemLWarr[0],CountOfType*4);
            for LocCnt := 0 to High(BigStripSizesLoc) do
            BigStripSizesLoc[LocCnt] := TemLWarr[LocCnt];
          end;
        End  //If (TypeF = 4)
          Else
        If (TypeF = 16) Then Begin
          if (CountOfType = 1) then BigStripSizesLoc[0] := pUInt64(@BigIFD[12])^
            else
           if (CountOfType > 1) then Move(pRawData[BigValOffset],BigStripSizesLoc[0],CountOfType*8);
        End;
      End { of Tag = 279 }

        Else

      If (Tag = 281) and (PageCnt = 0) then Begin
        if (pWord(@BigIFD[12])^ > 0) then
        shrFact := round(Log2(pWord(@BigIFD[12])^ + 1)) - 8 else
        shrFact := 8; //sets it to 16 bit
      End //of (Tag = 281)

          Else

      If (Tag = 320) and (PageCnt = 0) Then Begin

        BigValOffset := pUInt64(@BigIFD[12])^;
        SetLength(TemWarr, CountOfType);
        Move(pRawData[BigValOffset],TemWarr[0], CountOfType * SizeOf(Word));
        if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
        for PosCnt := 0 to 767 do FileColorTBL_Ch1[PosCnt] := TemWarr[PosCnt] shr 8;
        frmImageControl.ubFileColTable.Tag := 1;

      End; { of Tag 320;   }

        { -------------End of --- Windows Public  Tags -------------------- }

      If (ActionMode = READ_AS_SINGLE) then Begin
        If (tag = 65325)  then Begin
          If (PageCnt = 0) then begin
            TIFFfileType := TIFF_NIKON;
            SetLength(TimeSt, 1);
          end;
          TimeSt[PageCnt] := pDouble(@BigIFD[12])^;
        End
          Else
        If (tag = 65326) and (PageCnt = 0) then begin
          PixSettings.FilePixSize := pDouble(@BigIFD[12])^;
          PixSettings.FileHasOwnPixSize := True;
        End
          Else
        If (tag = 65328) and (PageCnt = 0) then begin
          NrChannels  := Trunc(pDouble(@BigIFD[12])^);
        End
          Else
        If (tag = 65330) then begin
          CountOfType  := pLongWord(@BigIFD[4])^;
          BigValOffset := pUInt64(@BigIFD[12])^;

          SetLength(Tag65330_31,CountOfType);
          Move(pRawData[BigValOffset], Tag65330_31[0], CountOfType);

          SetLength(Param,11);
          //d.Z.S.t.e.p =  64 00 5A 00 53 00 74 00 65 00 70
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $53;
          Param[5]  := 0;
          Param[6]  := $74;
          Param[7]  := 0;
          Param[8]  := $65;
          Param[9]  := 0;
          Param[10] := $70;

         PosOfByteArr := BytePos(0,Param,Tag65330_31);

         If (PosOfByteArr > -1) then Begin //pos found
            MovieSeriesType := Z_Stack;
            ZStepLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;

            SetLength(Param,11); //find Home position
            //d.Z.H.o.m.e = 64 00 5A 00 48 00 6F 00 6D 00 65
           // d.Z.H.o.m.e is 68 bytes before beg of d.Z.S.t.e.p
            Param[0]  := $64;
            Param[1]  := 0;
            Param[2]  := $5A;
            Param[3]  := 0;
            Param[4]  := $48;
            Param[5]  := 0;
            Param[6]  := $6F;
            Param[7]  := 0;
            Param[8]  := $6D;
            Param[9]  := 0;
            Param[10] := $65;

            PosOfByteArr := BytePos(PosOfByteArr - 100,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
            if (PosOfByteArr > -1) then begin
              ZHomeLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
            end;
         End
          Else
         If (PosOfByteArr = -1) then Begin //was not found in the byte array
          MovieSeriesType := TimeSeries;
         End;

         //search for B.i.n.n.i.n.g.:. . = 420069006E006E0069006E0067    00 3A 00 20 00
          SetLength(Param,18);
          Param[0]  := $42;
          Param[1]  := 0;
          Param[2]  := $69;
          Param[3]  := 0;
          Param[4]  := $6E;
          Param[5]  := 0;
          Param[6]  := $6E;
          Param[7]  := 0;
          Param[8]  := $69;
          Param[9]  := 0;
          Param[10] := $6E;
          Param[11] := 0;
          Param[12] := $67;
          Param[13]  := 0;
          Param[14] := $3A;
          Param[15] := 0;
          Param[16] := $20;
          Param[17] := 0;

          PosOfByteArr := BytePos(0,Param,Tag65330_31);  //searches for position of Param in the Value of the tag

          If (PosOfByteArr > -1) then Begin
            PosOfByteArr := PosOfByteArr + 18;
            PixSettings.ImageBinning := StrToInt(AnsiChar(Tag65330_31[PosOfByteArr]));
          End
            else
          PixSettings.ImageBinning := 0;
        End   // If (tag = 65330) then begin

         Else

        If (tag = 65331) then begin
          CountOfType  := pLongWord(@BigIFD[4])^;
          BigValOffset := pUInt64(@BigIFD[12])^;

          SetLength(Tag65330_31,CountOfType);
          Move(pRawData[BigValOffset], Tag65330_31[0], CountOfType);

         If (MovieSeriesType = Z_Stack) then Begin
          SetLength(Param,21);
          //d.Z.P.o.s.i.t.i.o.n.0 = 64 00 5A    00 50 00 6F 00 73 00 69 00 74 00 69 00 6F 00 6E 00 30
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $50;
          Param[5]  := 0;
          Param[6]  := $6F;
          Param[7]  := 0;
          Param[8]  := $73;
          Param[9]  := 0;
          Param[10] := $69;
          Param[11] := 0;
          Param[12] := $74;
          Param[13] := 0;
          Param[14] := $69;
          Param[15] := 0;
          Param[16] := $6F;
          Param[17] := 0;
          Param[18] := $6E;
          Param[19] := 0;
          Param[20] := $30;

          PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
          if (PosOfByteArr > -1) then begin
          ZPosLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
          end;
        End;

           SetLength(Param,14);
        //  C.o.l.o.r...      = 03 06 43 00 6F 00 6C 00 6F 00 72 00 00 00

        Param[0]  := $03;
        Param[1]  := $06;
        Param[2]  := $43;
        Param[3]  := 0;
        Param[4]  := $6F;
        Param[5]  := 0;
        Param[6]  := $6C;
        Param[7]  := 0;
        Param[8]  := $6F;
        Param[9]  := 0;
        Param[10] := $72;
        Param[11] := 0;
        Param[12] := 0;
        Param[13] := 0;

        PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile

         If (PosOfByteArr > -1) then Begin

          //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
          LocCnt := 0;
          R := 1;
          ScopeSystemParams.Ch1_Name := '';
          while (R <> 6)  do begin
            R := Tag65330_31[PosOfByteArr+Length(Param)+16+LocCnt];
            if not(R in[0,6]) then ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(R);
            Inc(LocCnt);
          end;

          //Get Color of Channes
          R := Tag65330_31[PosOfByteArr+Length(Param)];
          G := Tag65330_31[PosOfByteArr+Length(Param)+1];
          B := Tag65330_31[PosOfByteArr+Length(Param)+2];

          frmImageControl.ubFileColTable.Tag := NrChannels;
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[LocCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[256+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[256+LocCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[512+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[512+LocCnt] := 0;
          frmImageControl.ubFileColTable.Tag := 1;
        End;  //if (PosOfByteArr > -1) then begin = String Found

        If (NrChannels = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr+Length(Param),Param,Tag65330_31);
         If (PosOfByteArr > -1) then Begin
             //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
            LocCnt := 0;
            R := 1;
            ScopeSystemParams.Ch2_Name := '';
            while (R <> 6)  do begin
              R := Tag65330_31[PosOfByteArr+Length(Param)+16+LocCnt];
              if not(R in[0,6]) then ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(R);
              Inc(LocCnt);
            end;
            //get channel colors
              R := Tag65330_31[PosOfByteArr+Length(Param)];
              G := Tag65330_31[PosOfByteArr+Length(Param)+1];
              B := Tag65330_31[PosOfByteArr+Length(Param)+2];
               if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[LocCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[256+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[256+LocCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[512+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[512+LocCnt] := 0;
          frmImageControl.ubFileColTable.Tag := 2;
          End;  ////if (PosOfByteArr > -1) then begin = String Found
        End; // If (NrChannelsLoc = 2) then Begin
      
      End;

      End; //If (ActionMode = READ_AS_SINGLE) then Begin

    End; { For Cnt := 0 To CntDE - 1  Do Begin }

    ////////////////////// End of Reading TAGs ////////////////////////////////////////

    If (SamplesPerPixel = 1) AND
      (((ActionMode = READ_AS_SINGLE) or
          (ActionMode = READ_AS_COLLECTION)) Or
        ((NrPages = 1) and (ActionMode = READ_AS_STACK))) then
    Begin

      If (PageCnt = 0) and (High(StripOffs) > 0) then Begin
        LocCnt := 0; // counts How Many Times The Overlap
        BigValOffset := 0; // Counts How Many Time They Did Not Overlap (= 0 if They Always Overlap)

        For PosCnt := 0 to High(StripOffs) - 1 do Begin
          if (BigStripSizesLoc[PosCnt] + StripOffs[PosCnt] = StripOffs[PosCnt + 1]) then
          begin
            Inc(LocCnt);
            BigStripSizesLoc[BigValOffset] := BigStripSizesLoc[BigValOffset] + BigStripSizesLoc[PosCnt + 1];
          end
          else if BigStripSizesLoc[PosCnt] + StripOffs[PosCnt] <> StripOffs[PosCnt + 1] then
          begin
            Inc(BigValOffset);
          end;
        End;

        SetLength(StripOffs,  Length(StripOffs)  - LocCnt);
        SetLength(BigStripSizesLoc, Length(BigStripSizesLoc) - LocCnt);

      End; // If High(StripOffs) > 0

      If (PageCnt = 0) then Begin
        { Does this Only For the First Page }
        If (TIFFfileType <> TIFF_ANDOR_iQ) then
        Begin
          FindFirst(FName, faAnyFile, SearchRec);
          NrPages := SearchRec.Size div (XimSize * YimSize * (BitsPix div 8));
          FindClose(SearchRec); // free resourses
          SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType = TIFF_NIKON) then  SetLength(ZstackArr, NrPages);
        End;

        If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
          and (NrPages > 1) then
        Begin
          if (frmProgress = nil) then
          begin
            Application.CreateForm(TfrmProgress, frmProgress);
            frmProgress.lbAction.Caption :=  'Loaded in RAM.  Getting Info.';
            frmProgress.Show;
          end;
          frmProgress.ImageProgressBar.Max := NrPages - 1;
          frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
            + ' (' + IntToStr(NrPages) + ' frames)';
          Application.ProcessMessages;
        End;
      End; // If (GetAllPages) and (PageCnt = 0)

      If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
        and (NrPages > 1) then
      Begin

        frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
          + ' (' + IntToStr(NrPages) + ' frames)';
        frmProgress.ImageProgressBar.Position := PageCnt;
        Application.ProcessMessages;

        FPos := FPos + 20;

        BigValOffset := pUInt64(@pRawData[FPos])^; // looks for next image

        ImOff[0,PageCnt + StartPage] := StripOffs[0];

        If (BigValOffset <> 0) then
        Begin // more then One image
          BigOffsIFD := BigValOffset;
          Inc(PageCnt);

          GoTo ReadAgain;

        End;

  // !!!!!!!!!!!!!!!!!!!!!!!!!!! End of LOOP  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

        { zeroies 1st StripOffs if more then one image }
        if (PageCnt > 0) and (Length(StripOffs) > 1) then
          StripOffs[0] := 0;

        if frmProgress <> nil then
          frmProgress.Close;

          { finalizes Nr of Pages and trims arrays }
          NrPages := PageCnt + 1;
          SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType <> TIFF_NIKON) then begin
            ImageTime := 1 / PixSettings.FramesPerSec[1]; // [0] for Stack
            TimeSt[0] := 0;
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := TimeSt[Cnt-1] + ImageTime;
            NrChannels := 1;
          end
            else
          if (TIFFfileType = TIFF_NIKON) then begin
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := (TimeSt[Cnt] - TimeSt[0])/1000; //convert ms to sec
            TimeSt[0] := 0;
            if (MovieSeriesType = Z_Stack) then begin
              ZstackUnits := ' µm';
              if (Length(ZstackArr) <> NrPages div NrChannels) then SetLength(ZstackArr,NrPages div NrChannels);
              for Cnt := 0 to High(ZstackArr) do  ZstackArr[Cnt] := 0;
              if (ZPosLoc < ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] + ZStepLoc;
                end;
              end
                else
              if (ZPosLoc > ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] - ZStepLoc;
                end;
              end;
            end else
              SetLength(ZstackArr,0);
          end; //if (TIFFfileType = TIFF_NIKON) then begin

      End; // If (GetAllPages) and (NrPages > 1)

      { at the End }
    End; // If SamplesPerPixel = 1

    { ------------------------------------------------------------------------------ }
    { Sets Global Variables }
    If (SamplesPerPixel = 1) AND (((ActionMode in [READ_AS_SINGLE,READ_AS_COLLECTION])) OR ((NrPages = 1) and
       (ActionMode = READ_AS_STACK)))

      Then
    Begin // Grayscale and Color Palleted have 1 per Pixel

      { TIFFfileType : Byte; {1 = Generic FrayScale TIFF, 2 = QED,
        3 = Prarie Technology, 4 = Andor }
      imXsize := XimSize;
      imYsize := YimSize;
      ImagePix := imXsize * imYsize;
      BitCount := BitsPix;
      //Transfer to Global StripOffs
      SetLength(StripSizes,Length(BigStripSizesLoc));
      for LocCnt  := 0 to High(BigStripSizesLoc) do begin
        StripSizes[LocCnt] := BigStripSizesLoc[LocCnt]; //load Offset for each channel
      end;

      If (TIFFfileType = TIFF_GENERIC) then Begin
        NrChannels := 1; //if NrIm = 1 then NrChannels has not been set
        PixSettings.FileHasOwnPixSize := False;
        if BitsPix = 16 then
          shrFact := 8
        else // 16 bit - 8 bit [image buffer] = 8
          if BitsPix = 8 then
          shrFact := 0;
      End;
    End;

  End;

End; // Procedure GetBigTIFFfileInfoFromRAM }

{******************************************************************************}

Procedure GetTIFFfileInfoFromRAM(Const pRawData : pByteArr; Var NrPages: LongWord;
                                 Const FName: AnsiString; Const StartPage: Longint;
                                 Const ActionMode: Byte; Const ColFileNr : Integer;
                                 Const SilentMode: Boolean);

Label ReadAgain;

Var

  FPos      : UInt64;
  BegRead   : UInt64;
  SearchRec : TSearchRec;
  Cnt       : Longint;
  LocCnt    : Integer;
  SamplesPerPixel: Word;
  PalettedColor: Boolean;
  { ToSwap := True if Motorola Type ('MM')  GLOBAL }

  { ----------- Variables For the Final Output  ---------------- }
  XimSize: LongWord; { Tag = 256; TypeF = 3 }
  YimSize: LongWord; { Tag = 257  TypeF = 3 }
  BitsPix: Word; { Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology" }
  StripOffsLoc  : array of LongWord; // Local (Global is StripOffs); Tag = 273  TypeF = 4 'Strip Offset
  TemWarr: array of Word; // used in case this is array of SHORT(C++)= Word(Pascal
  RowsPerStrip: LongWord; // Tag = 278  TypeF = 3 or 4; Rows per Strip
  // StripSizes : array of Longword; GLOBAL; Tag = 279  TypeF = 4 or 3'Size of each strip (QED has just 1) in bytes
  ReadStr: AnsiString; { Tag = 305, EQ String with 3 lenght }
  TemStr : AnsiString;
  Singl: Single;
  { ------------------------------------------------------------------------- }
  sType: array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD: LongWord;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE : Word; { Number of Directory Entrees (DE) in IDF }
  IFD : array [0 .. 5] of Word;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag: Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF: Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType : LongWord; { 'Byte 4-7; number of the indicated Type (Always LongWord)
    'e.g. Count for Tag 305, "QED Camera Plugin" = 18, [18 Chr]
    'Dont need to Use it For Our types it is always = 1, except for SGIinfo Strings
    'e.g. 1 strip, 1 offset for theat strip, etc. }
  ValOffset : LongWord;
  PageCnt: Integer;
  PosCnt : Integer;
  ImageDesc : AnsiString; // Image Description - used by Andor to store a lot of Info
  MM_HEAD: TMM_HEAD;
  Sender: TObject;
  ImageTime: Double;

   Tag65330_31  : TDynByteArray;
   Param : TDynByteArray;
   PosOfByteArr : Integer;
   ZStepLoc     : Double;
   ZHomeLoc     : Double;
   ZPosLoc      : Double;
   R,G,B        : Byte;
   ColDec       : Double;
   TimeDimName : AnsiString; // added June 3 for Swapnil uncaging file
   SumOfEntries : Integer; //for ImageJ private tags (Metadata)
   TempBarr     : TDynByteArray;//for ImageJread the block with the Metadata types
   TempLWarr    : TDynLongWordArray;//for ImageJread the block with the Metadata types

BEGIN    //uses RAW_Data

  { Initializations }
  TIFFfileType := TIFF_GENERIC; // initializes to this
  SamplesPerPixel := 1; // some files do not have Tag 277 where the value comes from
  PageCnt := 0; // Counts Pages
  NrPages := 1; // Number of Pages (Images) in Single TIFF

  PalettedColor := False;

  TimeDimName := 'Unknown';
  { end with Initializations }

  FPos := 0;
  Move(pRawData[FPos],sType[0], 2);
  If sType = 'MM' Then
    ToSwap := True
  Else If sType = 'II' Then
    ToSwap := False;
  FPos := 2;
  {
  version 1 - using move
  Move(ByteBuf[FPos], IfThisIsTIFF, 2);
  version 2 - use pointer
  pW := @ByteBuf[FPos];
  IfThisIsTIFF := pW[0];
  version 3 - use casting to pointer type
  }
  IfThisIsTIFF := pWord(@pRawData[FPos])^;
  if ToSwap = True then IfThisIsTIFF := Swap(IfThisIsTIFF);

  { ---------------------------------------------------- }

  If (IfThisIsTIFF = 42) Then
  BEGIN { This is  Tiff File }

    FPos := 4;
    OffsIFD := pLongWord(@pRawData[FPos])^;
    if (ToSwap) then OffsIFD := SwapLongWord(OffsIFD);

  ReadAgain :

    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    CntDE := pWord(@pRawData[FPos])^; { 'Gets Number of Entrees in IDF }
    if (ToSwap) Then CntDE := Swap(CntDE);

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }

    BegRead := OffsIFD + 2;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To CntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      Move(pRawData[FPos],IFD[0], 12); { Gets each CntDE each 12 byte Entries }
      Tag   := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }
      If ToSwap = True Then
      Begin { 'Motorola }
        Tag   := Swap(Tag);
        TypeF := Swap(TypeF);
      End; { If ToSwap = True }

      If (ToSwap = False) Then
      Begin

        { ------- I N T E L     Type  ------- }

        If (Tag = 256) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then XimSize := IFD[4] {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
            else
          if (TypeF = 4) then XimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
        End { of Tag = 256 }
        Else If (Tag = 257) and (PageCnt = 0) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then YimSize := IFD[4] {Short = Word(Pascal) 2 byte,  {bytes 8-9 }
          else
          if (TypeF = 4) then YimSize := pLongWord(@IFD[4])^; {LongWord = 4 byte unsigned int }
        End { of Tag = 257 }

        Else If (Tag = 258) and (PageCnt = 0) Then BitsPix := IFD[4] { SHORT C++ }

        Else If (Tag = 270) and (PageCnt = 0) { Image Description }

        Then Begin
          { ASCII type }
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          SetLength(ImageDesc, CountOfType);
          Move(pRawData[ValOffset], ImageDesc[1], CountOfType);
          if (AnsiStartsStr('ImageJ',ImageDesc)) then begin
            TIFFfileType := TIFF_ImageJ;
            PixSettings.FileHasOwnPixSize := False;
            PosCnt := PosEx('channels=', ImageDesc);
            if (PosCnt > 0) then NrChannels := StrToInt((Copy(ImageDesc, PosCnt + 9, 1))) else NrChannels := 1;
          end;
        End // If  'Tag = 270

        Else If (Tag = 273) Then
        Begin
          if (PageCnt = 1) then begin
            if (Length(StripOffsLoc) > 1) then
              for LocCnt := 1 to High(StripOffsLoc) do StripOffsLoc[LocCnt] := StripOffsLoc[LocCnt] - StripOffsLoc[0];
          end;

          CountOfType := pLongWord(@IFD[2])^;
          If (CountOfType > 1) Then ValOffset := pLongWord(@IFD[4])^;

          If (PageCnt = 0) then SetLength(StripOffsLoc, CountOfType);

          If (TypeF = 3) Then Begin
            If (CountOfType = 1) Then StripOffsLoc[0] := IFD[4]
              else
            If (CountOfType > 1) Then Begin
              if (PageCnt > 0) then
                StripOffsLoc[0] := pWord(@pRawData[ValOffset])^
              else begin
                SetLength(TemWarr,CountOfType);
                Move(pRawData[ValOffset],TemWarr[0],CountOfType*2);
                for LocCnt := 0 to High(StripOffsLoc) do
                  StripOffsLoc[LocCnt] := TemWarr[LocCnt];
              end;
            End;
          End
          Else If (TypeF = 4) Then Begin // LONG = LongWord
            If (CountOfType = 1) Then StripOffsLoc[0] := pLongWord(@IFD[4])^
              else
            If (CountOfType > 1) Then Begin
              if (PageCnt > 0) then
                StripOffsLoc[0] := pLongWord(@pRawData[ValOffset])^
              else
                Move(pRawData[ValOffset],StripOffsLoc[0],CountOfType*4)
            End;
          End; { of TypeF = 4 }
        End { of Tag = 273 }

        Else If (Tag = 277) and (PageCnt = 0)  Then
        Begin
          SamplesPerPixel := IFD[4];
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
        Else If (Tag = 278) and (PageCnt = 0) Then
        Begin
          if (TypeF = 3) then RowsPerStrip := IFD[4]
            else
          if (TypeF = 4) then RowsPerStrip := pLongWord(@IFD[4])^;
        End { of Tag = 278 }
        Else If (Tag = 279) and (PageCnt = 0) Then
        Begin
          CountOfType := pLongWord(@IFD[2])^;
          if (CountOfType > 1) then ValOffset := pLongWord(@IFD[4])^;
          SetLength(StripSizes, CountOfType);
          If (TypeF = 3) Then Begin
            if (CountOfType = 1) then StripSizes[0] := IFD[4]
              else
            if (CountOfType > 1) then begin
              SetLength(TemWarr,CountOfType);
              Move(pRawData[ValOffset],TemWarr[0],CountOfType*2);
              for LocCnt := 0 to High(StripSizes) do
              StripSizes[LocCnt] := TemWarr[LocCnt];
            end;
          End
          Else If (TypeF = 4) Then Begin
            if (CountOfType = 1) then StripSizes[0] := pLongWord(@IFD[4])^
              else
            if (CountOfType > 1) then Move(pRawData[ValOffset],StripSizes[0],CountOfType*4);
          End;
        End { of Tag = 279 }

        Else If (Tag = 281) and (PageCnt = 0) then Begin //MaxSampleValue  Type 3 = Word
        //Used by Nikon NIS Tiff to write bit depth: 8 bit gives 255; 14 bit gives 16383, 16 bit gives  -1
          if (pWord(@IFD[4])^ > 0) then
          shrFact := round(Log2(pWord(@IFD[4])^ + 1)) - 8 else
          shrFact := 8;
        End

          Else

        If (Tag = 282) and (TIFFfileType = TIFF_ImageJ) and (PageCnt = 0) Then Begin
          ValOffset := pLongWord(@IFD[4])^;
          SetLength(TempLWarr,2);
          Move(pRawData[ValOffset],TempLWarr[0],8);
          PixSettings.PixPer100Micr[SINGLE_BW_TIFF] := Round(100*(TempLWarr[0]/TempLWarr[1]));
          PixSettings.FilePixSize := 1/(TempLWarr[0]/TempLWarr[1]);
          PixSettings.FileHasOwnPixSize := True;
          PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] := True;
        End

          Else

        If (Tag = 320) and (PageCnt in[0,1]) Then Begin

         If (TIFFfileType <> TIFF_ImageJ) Or ((TIFFfileType = TIFF_ImageJ) and (NrChannels = 1)) Then Begin
          If ((PageCnt = 0) and (ColFileNr = 0)) Then Begin
            PalettedColor := True;
            CountOfType := pLongWord(@IFD[2])^;
            ValOffset := pLongWord(@IFD[4])^;
            SetLength(TemWarr, CountOfType);
            Move(pRawData[ValOffset],TemWarr[0], CountOfType * SizeOf(Word));
            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            for PosCnt := 0 to 767 do FileColorTBL_Ch1[PosCnt] := TemWarr[PosCnt] shr 8;
            frmImageControl.ubFileColTable.Tag := 1;
          End
            Else
          If ((PageCnt = 1) and (NrChannels = 2) and (ColFileNr = 0) and Not(LoadChAsIndivFiles)) Or
             ((PageCnt = 0) and (ColFileNr = 1) and (LoadChAsIndivFiles)) Then Begin
            PalettedColor := True;
            CountOfType := pLongWord(@IFD[2])^;
            ValOffset := pLongWord(@IFD[4])^;
            SetLength(TemWarr, CountOfType);
            Move(pRawData[ValOffset],TemWarr[0], CountOfType * SizeOf(Word));
            if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
            for PosCnt := 0 to 767 do FileColorTBL_Ch2[PosCnt] := TemWarr[PosCnt] shr 8;
            frmImageControl.ubFileColTable.Tag := 2;
          End;
         End;
        End { of Tag 320;  If 'last tag value }

        { -------------End of --- Windows Public  Tags -------------------- }

          Else

        If (Tag = 34361) Then Begin
          { This Tag Appear Only in the First Image }

          TIFFfileType := TIFF_ANDOR_iQ;

          // TypeF = 1 meaning = Byte
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          Move(pRawData[ValOffset],MM_HEAD, SizeOf(MM_HEAD));

          { Gets Binning }
          PosCnt := PosEx('Binning=', ImageDesc);
          If (PosCnt > 0) then Begin
            PixSettings.ImageBinning := StrToInt((Copy(ImageDesc, PosCnt + 8, 1)));
          End
            Else
          If PosCnt = 0 then PixSettings.ImageBinning := 0;
          PixSettings.FilePixSize := MM_HEAD.DimInfo[0].Resolution + MM_HEAD.DimInfo[0].Origin;
          PosCnt := PosEx('[Image Bits]', ImageDesc);
          If PosCnt > 0 then
            shrFact := StrToInt((Copy(ImageDesc, PosCnt + 14, 2)))
          else
          Begin
            if MM_HEAD.ImageType < 4 then
              shrFact := 8
            else if MM_HEAD.ImageType = 4 then
              shrFact := 12
            else if MM_HEAD.ImageType = 5 then
              shrFact := 16;
          End;
          shrFact := shrFact - 8;

          DimNotTime := -1;
          AndorNrDIM :=  1;

          For PosCnt := 2 to High(MM_HEAD.DimInfo) do Begin

            if (MM_HEAD.DimInfo[PosCnt].Name = 'Wavelength') then
            begin
              if (MM_HEAD.DimInfo[PosCnt].Size = 2) then
              NrPages := MM_HEAD.DimInfo[PosCnt].Size;
            end;

            if (MM_HEAD.DimInfo[PosCnt].Name = 'Z') then
            begin
              DimNotTime := PosCnt;
              AndorNrDIM := 2;
              ZstackUnits := ' µm';
            end;

            if ((MM_HEAD.DimInfo[PosCnt].Name = 'Time1') or
               (MM_HEAD.DimInfo[PosCnt].Name = 'Time') or
               (MM_HEAD.DimInfo[PosCnt].Name = 'T ')) and (TimeDimName = 'Unknown')
            then
            begin
              TimeDimName := MM_HEAD.DimInfo[PosCnt].Name;
              if (DimNotTime = -1) then
              NrPages := NrPages*MM_HEAD.DimInfo[PosCnt].Size;
              DimTime := PosCnt;
              Break;
            end;
          End; //For PosCnt := 0 to High(MM_HEAD.DimInfo) do Begin

          if (DimNotTime <> -1) then NrPages := NrPages*MM_HEAD.DimInfo[DimNotTime].Size;

          if (DimNotTime = -1) then MovieSeriesType := TimeSeries
             else
          if (DimNotTime <> -1) then MovieSeriesType := Z_Stack;

          if (DimTime > DimNotTime) then
            SetLength(DArray, DimTime - 1)
          else if (DimTime < DimNotTime) then
            SetLength(DArray, DimNotTime - 1);

          if (NrPages > 1) and (ActionMode = READ_AS_SINGLE) then
          Begin
            { Option Open Single TIFF and Have Multipage (MultiImage) TIFF }
            SetLength(TimeSt, NrPages);
            if (DimNotTime > -1) then SetLength(ZstackArr, NrPages);
            SetLength(ImOff,1, NrPages);
          end; // if (NrPages > 1) and (ActionMode = READ_AS_SINGLE)

          { Single Tiff which is a part of TIFF Stack }
          if (NrPages = 1) and (ActionMode = READ_AS_STACK) then
          begin
            SetLength(Andor_DIM_INFO, AndorNrDIM);
            if (DimNotTime <> -1) then
            begin
              if (DimTime > DimNotTime) then
              begin // typical case
                Andor_DIM_INFO[0] := MM_HEAD.DimInfo[DimNotTime];
                Andor_DIM_INFO[1] := MM_HEAD.DimInfo[DimTime];
              end;
              if (DimTime < DimNotTime) then
              begin
                Andor_DIM_INFO[0] := MM_HEAD.DimInfo[DimTime];
                Andor_DIM_INFO[1] := MM_HEAD.DimInfo[DimNotTime];
              end;
            end
              else
            if (DimNotTime = -1) then
            begin
              Andor_DIM_INFO[0] := MM_HEAD.DimInfo[DimTime];
            end;
          end;
          { End of Single Tiff which is a part of TIFF Stack }
        End // Tag = 34361   Andor Specific

          Else

        If (Tag = 34362) then begin
          ValOffset := IFD[5] shl 16 + IFD[4];
          Move(pRawData[ValOffset],DArray[0], Length(DArray) shl 3);
          // shl 3 EQ Multiply by 8

          if (NrPages > 1) and ((ActionMode = READ_AS_SINGLE) or
              (ActionMode = READ_AS_COLLECTION)) then
          begin

            if (DimTime > -1) then
              TimeSt[PageCnt + StartPage] := DArray[DimTime - 2];

            if (DimNotTime > -1) then
              ZstackArr[PageCnt + StartPage] := DArray[DimNotTime - 2];
          end
          else if (NrPages = 1) and (ActionMode = READ_AS_STACK) then
          begin // Single Tiff which is a part of TIFF Stack
            AndorDimValOffs := ValOffset;
            if (DimTime > -1) then
            begin
              FirstAndorTime := DArray[DimTime - 2]; // Stores 1st TimeSt
              if (MM_HEAD.DimInfo[DimTime].Resolution <> 1) then
                FirstAndorTime := FirstAndorTime * MM_HEAD.DimInfo[DimTime].Resolution;
              if (MM_HEAD.DimInfo[DimTime].Origin <> 0) then
                FirstAndorTime := FirstAndorTime + MM_HEAD.DimInfo[DimTime].Origin;
            end;
          end;

        End // Tag = 34362 (Andor Specific)

          Else

        If (Tag = 34363) then Begin { This Tag Appear Only in the First Image.  Not everything is known }
        //so far I found (Apr 2013) that the Fisrt 4 bytes give the Number of Channels
            //TypeF = 1 meaning = Byte
          If (ColFileNr = 0) or ((ColFileNr = 1) and (LoadChAsIndivFiles)) Then Begin
            CountOfType := pLongWord(@IFD[2])^; //CountOfType = 92  for One Channel and 180 for two channels
            ValOffset   := pLongWord(@IFD[4])^;
            Move(pRawData[ValOffset], NrChannels, 4);
             If (ColFileNr = 0) Then Begin
              ScopeSystemParams.Ch1_Name := '';
              PosCnt := ValOffset + 60;
             while (pRawData[PosCnt] <> 0) do begin
              ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(pRawData[PosCnt]);
              Inc(PosCnt);
             end;
             End
              Else
             If ((ColFileNr = 1) and (LoadChAsIndivFiles)) Then Begin
              ScopeSystemParams.Ch2_Name := '';
              PosCnt := ValOffset + 60;
              while (pRawData[PosCnt] <> 0) do begin
                ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(pRawData[PosCnt]);
                Inc(PosCnt);
              end;
             End;
          End;

          If (NrChannels >= 2) Then Begin
            LoadChAsIndivFiles := False;
            ScopeSystemParams.Ch2_Name := '';
            PosCnt := ValOffset + 148;
            while (pRawData[PosCnt] <> 0) do begin
              ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(pRawData[PosCnt]);
              Inc(PosCnt);
            end;
          End; //if (NrChannels >= 2) then begin
        End; { Tag = 34363 }

      If (ActionMode = READ_AS_SINGLE) then Begin

         // ----------------- ImageJ private Tags -------------------------//

        If (Tag = 50838) Then Begin  //ImageJ Metadata tag
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          SetLength(TempLWarr,CountOfType);
          Move(pRawData[ValOffset],TempLWarr[0], CountOfType*4);
        End //of Tag 50839
          Else
        If (Tag = 50839)  Then Begin  //ImageJ Metadata tag
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;

          SetLength(TempBarr,TempLWarr[0]); //read the block with the Metadata types
          Move(pRawData[ValOffset],TempBarr[0], Length(TempBarr));

          SumOfEntries := 0;  //Always there is One  this is the block describing the Entries
          SetLength(Param,4);
          //"ofni" which is reverse of "info": 69 6e 66 6f
          Param[3]  := $69;
          Param[2]  := $6e;
          Param[1]  := $66;
          Param[0]  := $6f;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SumOfEntries := SumOfEntries + pLongWord(@TempBarr[PosOfByteArr+4])^
          End;

         //"lbal" which is reverse of "labl" = 6c 61 62 6c  (slice labels)
          Param[3]  := $6c;
          Param[2]  := $61;
          Param[1]  := $62;
          Param[0]  := $6c;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found

            SetLength(Param,TempLWarr[SumOfEntries+1]);
            Move(pRawData[ValOffset+TempLWarr[SumOfEntries]],Param[0], Length(Param));
            TimeDimName := ''; //here used to get the Channel Name
            for PosCnt := 0 to High(Param) do begin
              if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
            end;
             ScopeSystemParams.Ch1_Name := TimeDimName;

            if (NrChannels = 2) then begin
              SetLength(Param,TempLWarr[SumOfEntries+2]);
              Move(pRawData[ValOffset+TempLWarr[SumOfEntries]+TempLWarr[SumOfEntries+1]],Param[0], Length(Param));
              TimeDimName := ''; //here used to get the Channel Name
              for PosCnt := 0 to High(Param) do begin
                if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
              end;
              ScopeSystemParams.Ch2_Name := TimeDimName;
            end;
            SumOfEntries := SumOfEntries + pLongWord(@TempBarr[PosOfByteArr+4])^;

          End;

         //"gnar" which is reverse of "rang"  = 72 61 6e 67  = Display Range. This is NOT the Bit Depth.  ImageJ tiff DOES NOT have the Actual Bit Depth
          SetLength(Param,4); //restore Length = 4
          Param[3]  := $72;
          Param[2]  := $61;
          Param[1]  := $6e;
          Param[0]  := $67;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SumOfEntries := SumOfEntries + pLongWord(@TempBarr[PosOfByteArr+4])^;
          End;

         ///"stul" which is reverse of "luts"  = 6c 75 74 73;  =  (channel LUTs)
          Param[3]  := $6c;
          Param[2]  := $75;
          Param[1]  := $74;
          Param[0]  := $73;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) and (NrChannels = 2) then Begin //Luts found
            PosOfByteArr := 0;
            for PosCnt := 0 to SumOfEntries do PosOfByteArr := PosOfByteArr + TempLWarr[PosCnt];

            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

            Move(pRawData[ValOffset+PosOfByteArr],FileColorTBL_Ch1[0], 768);
            Move(pRawData[ValOffset+PosOfByteArr+768],FileColorTBL_Ch2[0], 768);
            frmImageControl.ubFileColTable.Tag := 2;
          End;

        End //of Tag 50839

          Else

        If (tag = 65325)  then Begin
          ValOffset   := pLongWord(@IFD[4])^;
          If (PageCnt = 0) then begin
            TIFFfileType := TIFF_NIKON;
            SetLength(TimeSt, 1);
          end;
          TimeSt[PageCnt] := pDouble(@pRawData[ValOffset])^;
        End
          Else
        If (tag = 65326) and (PageCnt = 0) then begin
          ValOffset  := pLongWord(@IFD[4])^;
          PixSettings.FilePixSize := pDouble(@pRawData[ValOffset])^;
          PixSettings.FileHasOwnPixSize := True;
        End
          Else
        If (tag = 65328) and (PageCnt = 0) then begin
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          NrChannels  := Trunc(pDouble(@pRawData[ValOffset])^);
        End
          Else
        If (tag = 65330) then begin  //the Last image has it
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;

          SetLength(Tag65330_31,CountOfType);
          Move(pRawData[ValOffset], Tag65330_31[0], CountOfType);

          // Check if this is a Z stack movie.  If d.Z.S.t.e.p exists then this is Z stack movie
          SetLength(Param,11);
          //d.Z.S.t.e.p =  64 00 5A 00 53 00 74 00 65 00 70
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $53;
          Param[5]  := 0;
          Param[6]  := $74;
          Param[7]  := 0;
          Param[8]  := $65;
          Param[9]  := 0;
          Param[10] := $70;

          PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
          If (PosOfByteArr > -1) then Begin  //this is Z stack movie
            MovieSeriesType := Z_Stack;
            ZStepLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;

            SetLength(Param,11); //find Home position
            //d.Z.H.o.m.e = 64 00 5A 00 48 00 6F 00 6D 00 65
           // d.Z.H.o.m.e is 68 bytes before beg of d.Z.S.t.e.p
            Param[0]  := $64;
            Param[1]  := 0;
            Param[2]  := $5A;
            Param[3]  := 0;
            Param[4]  := $48;
            Param[5]  := 0;
            Param[6]  := $6F;
            Param[7]  := 0;
            Param[8]  := $6D;
            Param[9]  := 0;
            Param[10] := $65;

            PosOfByteArr := BytePos(PosOfByteArr - 100,Param,Tag65330_31);
            if (PosOfByteArr > -1) then begin
              ZHomeLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
            end;

          End  // If (PosOfByteArr > -1) then Begin  //this is Z stack movie
            Else
          Begin
            MovieSeriesType := TimeSeries;
          End;

         //search for B.i.n.n.i.n.g.:. . = 420069006E006E0069006E0067    00 3A 00 20 00
          SetLength(Param,18);
          Param[0]  := $42;
          Param[1]  := 0;
          Param[2]  := $69;
          Param[3]  := 0;
          Param[4]  := $6E;
          Param[5]  := 0;
          Param[6]  := $6E;
          Param[7]  := 0;
          Param[8]  := $69;
          Param[9]  := 0;
          Param[10] := $6E;
          Param[11] := 0;
          Param[12] := $67;
          Param[13]  := 0;
          Param[14] := $3A;
          Param[15] := 0;
          Param[16] := $20;
          Param[17] := 0;

          PosOfByteArr := BytePos(0,Param,Tag65330_31);  //searches for position of Param in the Value of the tag

          If (PosOfByteArr > -1) then Begin //pos found
          //the format is :1x1.  Here it gets the number before x
            PosOfByteArr := PosOfByteArr + 18;
            PixSettings.ImageBinning := StrToInt(AnsiChar(Tag65330_31[PosOfByteArr]));
          End
            else
          PixSettings.ImageBinning := 0;

        End  // If (tag = 65330) then begin

          Else

        If (tag = 65331) then begin  //the last image has it
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          SetLength(Tag65330_31,CountOfType);
          Move(pRawData[ValOffset], Tag65330_31[0], CountOfType);

         If (MovieSeriesType = Z_Stack) then Begin
          SetLength(Param,21);
          //d.Z.P.o.s.i.t.i.o.n.0 = 64 00 5A    00 50 00 6F 00 73 00 69 00 74 00 69 00 6F 00 6E 00 30
          Param[0]  := $64;
          Param[1]  := 0;
          Param[2]  := $5A;
          Param[3]  := 0;
          Param[4]  := $50;
          Param[5]  := 0;
          Param[6]  := $6F;
          Param[7]  := 0;
          Param[8]  := $73;
          Param[9]  := 0;
          Param[10] := $69;
          Param[11] := 0;
          Param[12] := $74;
          Param[13] := 0;
          Param[14] := $69;
          Param[15] := 0;
          Param[16] := $6F;
          Param[17] := 0;
          Param[18] := $6E;
          Param[19] := 0;
          Param[20] := $30;

          PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile
          if (PosOfByteArr > -1) then begin
            ZPosLoc := pDouble(@Tag65330_31[PosOfByteArr+Length(Param)+3])^;
          end;
         End; //If (MovieSeriesType = Z_Stack) then Begin

           SetLength(Param,14);
        //  C.o.l.o.r...      = 03 06 43 00 6F 00 6C 00 6F 00 72 00 00 00

        Param[0]  := $03;
        Param[1]  := $06;
        Param[2]  := $43;
        Param[3]  := 0;
        Param[4]  := $6F;
        Param[5]  := 0;
        Param[6]  := $6C;
        Param[7]  := 0;
        Param[8]  := $6F;
        Param[9]  := 0;
        Param[10] := $72;
        Param[11] := 0;
        Param[12] := 0;
        Param[13] := 0;

        PosOfByteArr := BytePos(0,Param,Tag65330_31); //Gives Position of Param in the PartOfFile

         If (PosOfByteArr > -1) then Begin

          //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
          LocCnt := 0;
          R := 1;
          ScopeSystemParams.Ch1_Name := '';
          while (R <> 6)  do begin
            R := Tag65330_31[PosOfByteArr+Length(Param)+16+LocCnt];
            if not(R in[0,6]) then ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiChar(R);
            Inc(LocCnt);
          end;

          //Get Color of Channes
          R := Tag65330_31[PosOfByteArr+Length(Param)];
          G := Tag65330_31[PosOfByteArr+Length(Param)+1];
          B := Tag65330_31[PosOfByteArr+Length(Param)+2];

          frmImageControl.ubFileColTable.Tag := NrChannels;
          if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[LocCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[256+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[256+LocCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch1[512+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch1[512+LocCnt] := 0;
          frmImageControl.ubFileColTable.Tag := 1;
        End;  //if (PosOfByteArr > -1) then begin = String Found

        If (NrChannels = 2) then Begin
            PosOfByteArr := BytePos(PosOfByteArr+Length(Param),Param,Tag65330_31); //Gives Position of Param in the PartOfFile
         If (PosOfByteArr > -1) then Begin
             //Name of the channel follows 16 bytes after the end of the Param (C.o.l.o.r...)
            LocCnt := 0;
            R := 1;
            ScopeSystemParams.Ch2_Name := '';
            while (R <> 6)  do begin
              R := Tag65330_31[PosOfByteArr+Length(Param)+16+LocCnt];
              if not(R in[0,6]) then ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiChar(R);
              Inc(LocCnt);
            end;
            //get channel colors
              R := Tag65330_31[PosOfByteArr+Length(Param)];
              G := Tag65330_31[PosOfByteArr+Length(Param)+1];
              B := Tag65330_31[PosOfByteArr+Length(Param)+2];
               if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

          if (R > 0) then begin
            ColDec := R/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[LocCnt] := 0;

          if (G > 0) then begin
            ColDec := G/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[256+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[256+LocCnt] := 0;

          if (B > 0) then begin
            ColDec := B/255;
            for LocCnt := 0 to 255 do FileColorTBL_Ch2[512+LocCnt] := round(ColDec*LocCnt);
          end
            else
          for LocCnt := 0 to 255 do FileColorTBL_Ch2[512+LocCnt] := 0;
            frmImageControl.ubFileColTable.Tag := 2;
         End;  ////if (PosOfByteArr > -1) then begin = String Found

        End; // If (NrChannelsLoc = 2) then Begin

       End;
      End;

      End //If (ActionMode = READ_AS_SINGLE) then Begin

        Else { If 'ToSwap = false }

      { ------- End of Intel Files --------------------------------------- }

      { ------  Motorola Type of Files      --------------------------- }

      If (ToSwap) Then
      Begin

        If (Tag = 256) and (PageCnt = 0) Then
        Begin
          if (TypeF = 3) then XimSize := Swap(IFD[4])
            else
          if (TypeF = 4) then XimSize := SwapLongWord(pLongWord(@IFD[4])^);
        End { of Tag = 256 }
        Else If (Tag = 257) and (PageCnt = 0) Then
        Begin
          if (TypeF = 3) then YimSize := Swap(IFD[4])
            else
          if (TypeF = 4) then YimSize := SwapLongWord(pLongWord(@IFD[4])^);
        End { of Tag = 257 }
        Else If (Tag = 258) and (PageCnt = 0) { SHORT } Then
          BitsPix := Swap(IFD[4])
        Else If (Tag = 270) and (PageCnt = 0) { Image Description }
        Then Begin
          { ASCII type }
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(ImageDesc, CountOfType);
          Move(pRawData[ValOffset], ImageDesc[1], CountOfType);
          if (AnsiStartsStr('ImageJ',ImageDesc)) then begin
            TIFFfileType := TIFF_ImageJ;
            PixSettings.FileHasOwnPixSize := False;
            PosCnt := PosEx('channels=', ImageDesc);
            if (PosCnt > 0) then NrChannels := StrToInt((Copy(ImageDesc, PosCnt + 9, 1))) else NrChannels := 1;
          end;
        End // If  'Tag = 270

        Else If (Tag = 273) Then
        Begin 
          if (PageCnt = 1) then begin
            if (Length(StripOffsLoc) > 1) then
              for LocCnt := 1 to High(StripOffsLoc) do StripOffsLoc[LocCnt] := StripOffsLoc[LocCnt] - StripOffsLoc[0];
          end;

          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          if (CountOfType > 1) then ValOffset := SwapLongWord(pLongWord(@IFD[4])^);

          If (PageCnt = 0) then SetLength(StripOffsLoc,CountOfType);

          If (TypeF = 3) Then Begin
            If (CountOfType = 1) Then StripOffsLoc[0] := Swap(IFD[4])
              else
            If (CountOfType > 1) Then Begin
              if (PageCnt > 0) then
                StripOffsLoc[0] := Swap(pWord(@pRawData[ValOffset])^)
              else
              begin
                SetLength(TemWarr,CountOfType);
                Move(pRawData[ValOffset],TemWarr[0],CountOfType*2);
                for LocCnt := 0 to High(StripOffsLoc) do StripOffsLoc[LocCnt] := Swap(TemWarr[LocCnt]);
              end;
            End;
          End
          Else If (TypeF = 4) Then Begin // LONG = LongWord
            If (CountOfType = 1) Then
              StripOffsLoc[0] := SwapLongWord(pLongWord(@IFD[4])^)
            else
            If (CountOfType > 1) Then Begin
              if (PageCnt > 0) then StripOffsLoc[0] := SwapLongWord(pLongWord(@IFD[4])^)
              else begin
                Move(pRawData[ValOffset],StripOffsLoc[0],CountOfType*4);
                for LocCnt := 0 to  High(StripOffsLoc) do StripOffsLoc[LocCnt] := SwapLongWord(StripOffsLoc[LocCnt]);
              end;
            End;
          End; { of TypeF = 4 }
        End { of Tag = 273 }

        Else If (Tag = 277) and (PageCnt = 0) { SHORT } Then
        Begin
          SamplesPerPixel := Swap(IFD[4]);
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
        Else If (Tag = 278) and (PageCnt = 0) Then
        Begin
          if (TypeF = 3) then
            RowsPerStrip := Swap(IFD[4])
            else
          if (TypeF = 4) then
            RowsPerStrip := SwapLongWord(pLongWord(@IFD[4])^);
        End { of Tag = 278 }
        Else If (Tag = 279) and (PageCnt = 0) Then
        Begin { LONG (C++) = LongWord (Pascal) 4 bytes unsigned integer }
          { Size of Image Data in Bytes in one Strip officialy in TIFF terminology called = StripByteCounts }
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          if (CountOfType > 1) then ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(StripSizes, CountOfType);
          If (TypeF = 3) Then Begin // SHORT = Word  Usually is LongWord = LONG(C++)
            If (CountOfType = 1) Then StripSizes[0] := Swap(IFD[4])
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemWarr,CountOfType);
              Move(pRawData[ValOffset],TemWarr[0],CountOfType*2);
              for LocCnt := 0 to High(StripSizes) do StripSizes[LocCnt] := Swap(TemWarr[LocCnt]);
            End;
          End
          Else If (TypeF = 4) Then Begin // LONG = LongWord
            If (CountOfType = 1) Then StripSizes[0] := SwapLongWord(pLongWord(@IFD[4])^)
              else
            If (CountOfType > 1) Then Begin
              Move(pRawData[ValOffset],StripSizes[0],CountOfType*4);
              for LocCnt := 0 to High(StripSizes) do StripSizes[LocCnt] := SwapLongWord(StripSizes[LocCnt]);
            End;
          End;
        End { of Tag = 279 }

          Else

        If (Tag = 282) and (TIFFfileType = TIFF_ImageJ) and (PageCnt = 0) Then Begin    
          ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(TempLWarr,2);
          Move(pRawData[ValOffset],TempLWarr[0],8);
          for PosCnt := 0 to High(TempLWarr) do TempLWarr[PosCnt] := SwapLongWord(TempLWarr[PosCnt]);
          PixSettings.PixPer100Micr[SINGLE_BW_TIFF] := Round(100*(TempLWarr[0]/TempLWarr[1]));
          PixSettings.FilePixSize := 1/(TempLWarr[0]/TempLWarr[1]);
          PixSettings.FileHasOwnPixSize := True;
          PixSettings.UseOptionPixSize[SINGLE_BW_TIFF] := True;
        End

          Else

        If (Tag = 320) and (PageCnt = 0) Then Begin
          if (TIFFfileType <> TIFF_ImageJ) Or ((TIFFfileType = TIFF_ImageJ) and (NrChannels = 1)) then begin
          PalettedColor := True;
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(TemWarr, CountOfType);
          Move(pRawData[ValOffset],TemWarr[0], CountOfType * SizeOf(Word));
          if FileColorTBL_Ch1 = nil then SetLength(FileColorTBL_Ch1, 768);
          for PosCnt := 0 to 767 do FileColorTBL_Ch1[PosCnt] := Swap(TemWarr[PosCnt]) shr 8;
          frmImageControl.ubFileColTable.Tag := 1;
          end;
        End { of Tag 320;  If 'last tag value }

          Else
        If (Tag = 50838) Then Begin  //ImageJ Metadata tag
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(TempLWarr,CountOfType);
          Move(pRawData[ValOffset],TempLWarr[0], CountOfType*4);
          for PosCnt := 0 to High(TempLWarr) do TempLWarr[PosCnt] := SwapLongWord(TempLWarr[PosCnt]);
        End //of Tag 50839
          Else
        If (Tag = 50839)  Then Begin  //ImageJ Metadata tag
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(TempBarr,TempLWarr[0]);
          Move(pRawData[ValOffset],TempBarr[0], Length(TempBarr));
          SumOfEntries := 0;
          SetLength(Param,4);
          //"info": 69 6e 66 6f
          Param[0]  := $69;
          Param[1]  := $6e;
          Param[2]  := $66;
          Param[3]  := $6f;
          PosOfByteArr := BytePos(0,Param,TempBarr);
          If (PosOfByteArr > -1) then Begin
            SumOfEntries := SumOfEntries + SwapLongWord(pLongWord(@TempBarr[PosOfByteArr+4])^);
          End;

         //"labl" = 6c 61 62 6c  (slice labels)
          Param[0]  := $6c;
          Param[1]  := $61;
          Param[2]  := $62;
          Param[3]  := $6c;
          PosOfByteArr := BytePos(0,Param,TempBarr);
          If (PosOfByteArr > -1) then Begin

            SetLength(Param,TempLWarr[SumOfEntries+1]);
            Move(pRawData[ValOffset+TempLWarr[SumOfEntries]],Param[0], Length(Param));
            TimeDimName := '';
            for PosCnt := 0 to High(Param) do begin
              if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
            end;
             ScopeSystemParams.Ch1_Name := TimeDimName;

            if (NrChannels = 2) then begin
              SetLength(Param,TempLWarr[SumOfEntries+2]);
              Move(pRawData[ValOffset+TempLWarr[SumOfEntries]+TempLWarr[SumOfEntries+1]],Param[0], Length(Param));
              TimeDimName := '';
              for PosCnt := 0 to High(Param) do begin
                if (Param[PosCnt] > 0) then TimeDimName := TimeDimName + AnsiChar(Param[PosCnt]);
              end;
              ScopeSystemParams.Ch2_Name := TimeDimName;
            end;
            SumOfEntries := SumOfEntries + SwapLongWord(pLongWord(@TempBarr[PosOfByteArr+4])^);

          End;

         //"rang"  = 72 61 6e 67  = Display Range. This is NOT the Bit Depth.  ImageJ tiff DOES NOT have the Actual Bit Depth
          SetLength(Param,4); //restore Length = 4
          Param[0]  := $72;
          Param[1]  := $61;
          Param[2]  := $6e;
          Param[3]  := $67;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) then Begin //pos found
            SumOfEntries := SumOfEntries + SwapLongWord(pLongWord(@TempBarr[PosOfByteArr+4])^);
          End;

         //"luts"  = 6c 75 74 73;  =  (channel LUTs)
          Param[0]  := $6c;
          Param[1]  := $75;
          Param[2]  := $74;
          Param[3]  := $73;
          PosOfByteArr := BytePos(0,Param,TempBarr); //Gives Position of Param in in the Value of the tag
          If (PosOfByteArr > -1) and (NrChannels = 2) then Begin //Luts found
            PosOfByteArr := 0;
            for PosCnt := 0 to SumOfEntries do PosOfByteArr := PosOfByteArr + TempLWarr[PosCnt];

            if (FileColorTBL_Ch1 = nil) then SetLength(FileColorTBL_Ch1, 768);
            if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);

            Move(pRawData[ValOffset+PosOfByteArr],FileColorTBL_Ch1[0], 768);
            Move(pRawData[ValOffset+PosOfByteArr+768],FileColorTBL_Ch2[0], 768);
            frmImageControl.ubFileColTable.Tag := 2;
          End;

        End; //of Tag 50839

      End; { of ToSwap = True }

      /// /////////////// End of Swap and NoSwap ///////////////////////////////

      { HERE we have Swap and No Swap files = MM and II type for easyness }

      If (Tag = 305) and (PageCnt = 0) Then
      Begin { Public Tag ASCII = Software Used }
        { 'this Tag is used by QED to put comment: "QED Camera Plugin" or "Prairie Deep View" }

        If not(ToSwap) Then Begin
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
        End
        Else { ToSwap = True }
        If (ToSwap) Then Begin
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
        End; { ToSwap = False }
        SetLength(ReadStr, CountOfType);
        Move(pRawData[ValOffset],ReadStr[1],CountOfType);
        TemStr := Copy(ReadStr, 1, 6);
        { Copy ( Source : string; StartChar, Count : Integer ) : string; }

        If (TemStr = 'QED In') or (TemStr = 'InVivo') Then
        Begin
          TIFFfileType := TIFF_QED;
          NrChannels := 1;
          // the Latest versions QED say "InVivo", the earliest - "QED InVivo"
        End Else
        Begin
          TemStr := Copy(ReadStr, 1, 7);
          if (TemStr = 'Prairie') then begin
            TIFFfileType := TIFF_NORAN_PRARIE;
            NrChannels := 1;
          end;
        End;
        { Noran gives 22 char long string : "Prairie Deep View 1.0" }

      End; { If  'Tag = 305 }

      { ------------------- QED private TAG with Semi-Known Function -------- }

      { it can be read as Motorolla or Intel; Put them togheter for Easyness }
      If (Tag = 34988) then
      begin
        // This is QED private Tag points to a byte array  }
        // So far discovered bit-dept and  microns per pixel value
        If not(ToSwap) Then Begin
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
        End
        Else { ToSwap = True }
        If (ToSwap) Then Begin
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset   := SwapLongWord(pLongWord(@IFD[4])^);
        End; { ToSwap = False }

        // here is the bit-dept !!! (as Word)
        shrFact := pWord(@pRawData[ValOffset + 46])^;
        if not(ToSwap) then shrFact := shrFact - 8
          else
        if    (ToSwap) then shrFact := Swap(shrFact) - 8;
        { shrFactMax = bit-dept - 8 }
        Move(pRawData[ValOffset + 298],Singl, 4); // here is microns per pixel value (as Single)
        if (ToSwap) then Singl := SwapSingle(Singl); { Gives Microns per pixel!! }
        PixSettings.FilePixSize := Singl;
      End; // of Tag = 34988

    End; { For Cnt := 0 To CntDE - 1  Do Begin }
    { ------------------ End of QED private TAG with Semi-Known Function ---------------------- }

    ////////////////////// End of Reading TAGs ////////////////////////////////////////

    If (SamplesPerPixel = 1) AND
      (((ActionMode = READ_AS_SINGLE) or
          (ActionMode = READ_AS_COLLECTION)) Or
        ((NrPages = 1) and (ActionMode = READ_AS_STACK))) then
    Begin

      // Grayscale and Color Palleted have 1 per Pixel
      { if Strips are contiguous then reduces them // with this Time for 500 im (512x512) was shorten from 14 to 13 sec }

      If (PageCnt = 0) and ( High(StripOffsLoc) > 0) then
      Begin
        LocCnt := 0; // counts How Many Times The Overlap
        ValOffset := 0; // Counts How Many Time They Did Not Overlap (= 0 if They Always Overlap)
        For PosCnt := 0 to High(StripOffsLoc) - 1 do
        Begin
          if StripSizes[PosCnt] + StripOffsLoc[PosCnt] = StripOffsLoc[PosCnt + 1] then
          begin
            Inc(LocCnt);
            StripSizes[ValOffset] := StripSizes[ValOffset] + StripSizes
              [PosCnt + 1];
          end
          else if StripSizes[PosCnt] + StripOffsLoc[PosCnt] <> StripOffsLoc[PosCnt + 1] then
          begin
            Inc(ValOffset);
          end;
        End;

        SetLength(StripOffsLoc,  Length(StripOffsLoc)  - LocCnt);
        SetLength(StripSizes, Length(StripSizes) - LocCnt);

      End; // If High(StripOffs) > 0

      { end of reducing number of StripOffs & StripSizes }

      { *** Here Decides if this a Multipage File
        Should it Load All Images -
        Yes if Single TIFF file was chosen
        No if Stack of TIFFs was chosen
        }

      If (PageCnt = 0) then Begin
        { Does this Only For the First Page }
        If (TIFFfileType <> TIFF_ANDOR_iQ) then
        Begin
          FindFirst(FName, faAnyFile, SearchRec);
          NrPages := SearchRec.Size div (XimSize * YimSize * (BitsPix div 8));
          FindClose(SearchRec); // free resourses
          SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
        End;

        If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
          and (NrPages > 1) then
        Begin
          if (frmProgress = nil) then
          begin
            Application.CreateForm(TfrmProgress, frmProgress);
            frmProgress.lbAction.Caption :=  'Loaded in RAM.  Getting Info.';
            frmProgress.Show;
          end;
          frmProgress.ImageProgressBar.Max := NrPages - 1;
          frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1)
            + ' (' + IntToStr(NrPages) + ' frames)';
          Application.ProcessMessages;
        End;
      End; // If (GetAllPages) and (PageCnt = 0)

      If ((ActionMode = READ_AS_SINGLE) or (ActionMode = READ_AS_COLLECTION))
        and (NrPages > 1) then
      Begin

        frmProgress.lbProgress.Caption := IntToStr(PageCnt + 1) + ' (' + IntToStr(NrPages) + ' frames)';
        frmProgress.ImageProgressBar.Position := PageCnt;
        Application.ProcessMessages;

        // Offset of next IFD = (Offset to 1st IDF Number) + 2 + 12*(Directory Entries)

        FPos := FPos + 12;

        ValOffset := pLongWord(@pRawData[FPos])^; // looks for next image

        if (ToSwap) then ValOffset := SwapLongWord(ValOffset);

        ImOff[0,PageCnt + StartPage] := StripOffsLoc[0];

        If (ValOffset <> 0) then
        Begin // more then One image
          OffsIFD := ValOffset;
          Inc(PageCnt);

          GoTo ReadAgain;

        End;

  // !!!!!!!!!!!!!!!!!!!!!!!!!!! End of LOOP  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!//

        { zeroies 1st StripOffs if more then one image }
        if (PageCnt > 0) and (Length(StripOffsLoc) > 1) then
          StripOffsLoc[0] := 0;

        if frmProgress <> nil then
          frmProgress.Close;

        If (TIFFfileType <> TIFF_ANDOR_iQ) then Begin
          { finalizes Nr of Pages and trims arrays }
          NrPages := PageCnt + 1;
          if (TIFFfileType = TIFF_ImageJ) then SetLength(TimeSt, NrPages div NrChannels) else SetLength(TimeSt, NrPages);
          SetLength(ImOff,1, NrPages);
          if (TIFFfileType <> TIFF_NIKON) then begin
            ImageTime := 1 / PixSettings.FramesPerSec[1]; // [0] for Stack
            TimeSt[0] := 0;
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := TimeSt[Cnt-1] + ImageTime;
            if (TIFFfileType <> TIFF_ImageJ) then NrChannels := 1; //for all Generic tiff and QED tiff
          end
            else
          if (TIFFfileType = TIFF_NIKON) then begin
            for Cnt := 1 to High(TimeSt) do TimeSt[Cnt] := (TimeSt[Cnt] - TimeSt[0])/1000; //convert ms to sec
            TimeSt[0] := 0;
            if (MovieSeriesType = Z_Stack) then begin
              ZstackUnits := ' µm';
              if (Length(ZstackArr) <> NrPages) then SetLength(ZstackArr,NrPages div NrChannels);
              for Cnt := 0 to High(ZstackArr) do  ZstackArr[Cnt] := 0;
              if (ZPosLoc < ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] + ZStepLoc;
                end;
              end
                else
              if (ZPosLoc > ZHomeLoc) then begin
                for Cnt := 1 to High(ZstackArr) do begin
                  ZstackArr[Cnt] := ZstackArr[Cnt-1] - ZStepLoc;
                end;
              end;
            end else
              SetLength(ZstackArr,0);
          end;
        End;

      End; // If (GetAllPages) and (NrPages > 1)

      { at the End }
    End; // If SamplesPerPixel = 1

    { ------------------------------------------------------------------------------ }
    { Sets Global Variables }
    If (SamplesPerPixel = 1) AND (((ActionMode in [READ_AS_SINGLE,
          READ_AS_COLLECTION])) OR ((NrPages = 1) and
          (ActionMode = READ_AS_STACK)))

      Then
    Begin
      imXsize := XimSize;
      imYsize := YimSize;
      ImagePix := imXsize * imYsize;
      BitCount := BitsPix;
      //Transfer to Global StripOffs
      SetLength(StripOffs,Length(StripOffsLoc));
      for LocCnt  := 0 to High(StripOffsLoc) do begin
        StripOffs[LocCnt] := StripOffsLoc[LocCnt]; //load Offset for each channel
      end;

      If (TIFFfileType in [TIFF_GENERIC,TIFF_ImageJ]) then Begin
        if (TIFFfileType <> TIFF_ImageJ) then NrChannels := 1;
        if (TIFFfileType = TIFF_GENERIC) then PixSettings.FileHasOwnPixSize := False;
        if BitsPix = 16  then shrFact := 8
          else // 16 bit - 8 bit [image buffer] = 8
        if BitsPix = 8 then shrFact := 0;
      End

         Else

      If (TIFFfileType = TIFF_NORAN_PRARIE) then Begin
        PixSettings.FileHasOwnPixSize := False;
        shrFact := 4;
      End
        Else
      If (TIFFfileType = TIFF_ANDOR_iQ) then  Begin
        PixSettings.FileHasOwnPixSize := True;

        If (NrPages > 1) Then
        Begin
          { First Do the Time }
          If (DimTime > -1) Then
          Begin
            if (MM_HEAD.DimInfo[DimTime].Resolution <> 1) then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] * MM_HEAD.DimInfo[DimTime].Resolution;
            if (MM_HEAD.DimInfo[DimTime].Origin <> 0) then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] + MM_HEAD.DimInfo[DimTime].Origin;

           { always subtract the 1st image time }
            if (ActionMode = READ_AS_SINGLE) then begin
                for PosCnt := 1 to High(TimeSt) do
                  TimeSt[PosCnt] := TimeSt[PosCnt] - TimeSt[0];
                TimeSt[0] := 0;

              if (DimNotTime <> -1) then begin
                if (ZstackArr[High(ZstackArr)] > ZstackArr[0]) then begin
                  for PosCnt := 1 to High(ZstackArr) do
                  ZstackArr[PosCnt] := ZstackArr[PosCnt] - ZstackArr[0];
                  ZstackArr[0] := 0;
                end
                  else
                if (ZstackArr[High(ZstackArr)] < ZstackArr[0]) then begin
                  for PosCnt := 0 to High(ZstackArr)-1 do
                  ZstackArr[PosCnt] := ZstackArr[PosCnt] - ZstackArr[High(ZstackArr)];
                  ZstackArr[High(ZstackArr)] := 0;
                end
              end;
            end; //if (ActionMode = READ_AS_SINGLE) then begin

            if MM_HEAD.DimInfo[DimTime].Units = 'ms' then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] / 1000
            else if MM_HEAD.DimInfo[DimTime].Units = 'µs' then
              for PosCnt := StartPage to (StartPage + NrPages - 1) do
                TimeSt[PosCnt] := TimeSt[PosCnt] / 1000000;
          End; // If (DimTime > 0

          If (DimNotTime > -1) Then
          Begin
            if (MM_HEAD.DimInfo[DimNotTime].Resolution <> 1) then
              for PosCnt := 0 to High(ZstackArr) do
                ZstackArr[PosCnt] := ZstackArr[PosCnt]
                  * MM_HEAD.DimInfo[DimNotTime].Resolution;
            if (MM_HEAD.DimInfo[DimNotTime].Origin <> 0) then
              for PosCnt := 0 to High(ZstackArr) do
                ZstackArr[PosCnt] := ZstackArr[PosCnt]
                  + MM_HEAD.DimInfo[DimNotTime].Origin;

          End; // If (DimNotTime > 0
        End; // If (NrPages > 1)
        if (DimTime > -1) then
          Dec(DimTime, 2);
        if (DimNotTime > -1) then
          Dec(DimNotTime, 2);
      End; // If TIFFfileType = ANDOR_TIFF

    End;

  End;

End; // Procedure GetTIFFfileInfoFromRAM }

{***************************************************************************** }

Procedure GetTIFFfile_Preview(Const FName: AnsiString; var ImageWidth,ImageHeight: Word;
                              var BitsPerPixel: Word; var DynBarr: TDynByteArray;var DynWarr: TDynWordArray;
                              var NeedSwap,ValidFile,MultiImage : Boolean);
Var

  TiffFile    : THandle;
  FPos        : UInt64;
  BegRead     : UInt64;
  Cnt         : LongInt; { 'Counter }
  TemCnt      : Integer;
  SamplesPerPixel: Word;
  { ----------- Variables For the Final Output  ---------------- }
  // BitsPerPixel     : Word;    {Tag = 258  TypeF = 3 'BitsPerPixel - TIFF terminology"}
  TemWarr     : array of Word; // used for Regular Tiff in case this is array of SHORT(C++)= Word(Pascal
  TemLWarr    : array of LongWord; // used for Big Tiff in case this is array of LongWord
  RowsPerStrip: LongWord; // Tag = 278  TypeF = 3 or 4; Rows per Strip
    { ------------------------------------------------------------------------- }
  sType       : array [0 .. 1] of AnsiChar;
  IfThisIsTIFF: Word; { shoud be = 42 (arbitrary Number) if is TIFF }
  OffsIFD     : LongWord;
  BigOffsIFD  : UInt64;
  { Offset to the First IFD or next IDF in MultiPage TIFF = 4 bytes }
  CntDE       : Word; { Number of Directory Entrees (DE) in IDF }
  BigCntDE    : UInt64;
  IFD         : array [0.. 5] of Word;
  BigIFD      : array [0..19] of Byte;
  { Array for IFD (Image File Directory) One per Image }
  { '--------------- DE Variables------------- }
  Tag         : Word; { 'Byte 0-1;  1st member of Directory Entry DE }
  TypeF       : Word; { 'Byte 2-3;  2nd member =  Field Type = Type of DATA }
  CountOfType : LongWord;
  ValOffset     : LongWord; { 'Byte 8-11;  Value or Offset of the  Value. }
  BigValOffset  : UInt64;
  Pt            : Pointer;
  PosCnt        : LongWord;
  { Specific for this procedure }
  StripOffsLoc     : array of LongWord;
  BigStripOffsLoc  : array of UInt64;
  { FPos offset Where the Image Data Start; Tag = 279  TypeF = 4 or 3'Size of each strip (QED has just 1) in bytes }
  StripSizesLoc    : array of LongWord;
  BigStripSizesLoc : array of UInt64;
  ToSwapLoc     : Boolean; // True if Motorola Type ('MM')
  ReadArrPos    : LongWord;
  Uns64Bit      : UInt64;
  NrChannelsInFile : Integer;
  TemDouble : Double;
  ImageDesc : AnsiString;

BEGIN

  { Initializations }

  SamplesPerPixel := 1; // some files do not have Tag 277 where the value comes from
  { end with Initializations }

  TiffFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  FPos := 0;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, sType, 2);
  If sType = 'II' Then
    ToSwapLoc := False
  Else If sType = 'MM' Then
    ToSwapLoc := True;
  FPos := 2;
  FileSeek(TiffFile, FPos, 0);
  FileRead(TiffFile, IfThisIsTIFF, 2);
  If (ToSwapLoc) Then
    IfThisIsTIFF := Swap(IfThisIsTIFF);
  { ---------------------------------------------------------------- }

  If IfThisIsTIFF = 42 Then
  BEGIN { This is  Tiff File }

    BigTiff := False;
    NrChannelsInFile := 1;

    FPos := 4;
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, OffsIFD, 4);
    if (ToSwapLoc) { MM } then OffsIFD := SwapLongWord(OffsIFD);

    { finds the FPos for the first IFD (Counted From "0" }

    FPos := OffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, CntDE, 2); { 'Gets Number of Entrees in IDF }
    if (ToSwapLoc) then CntDE := Swap(CntDE);

    { FPos := OffsIFD + 2; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
    BegRead := OffsIFD + 2;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To CntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 12; { *6 = 12 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, IFD, 12); { Gets each CntDE each 12 byte Entries }
      Tag   := IFD[0]; { bytes 0-1 }
      TypeF := IFD[1]; { bytes 2-3 } { Type of data ; short, long etc. }
      If (ToSwapLoc) Then
      Begin { 'Motorola }
        Tag := Swap(Tag);
        TypeF := Swap(TypeF);
      End; { If ToSwap = True }

      If not(ToSwapLoc) Then Begin

        { ------- I N T E L     Type  ------- }

        If (Tag = 256) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then ImageWidth := IFD[4]
            else
          if (TypeF = 4) then ImageWidth := pLongWord(@IFD[4])^;
        End { of Tag = 256 }
        Else If (Tag = 257) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then ImageHeight := IFD[4]
          else
          if (TypeF = 4) then ImageHeight := pLongWord(@IFD[4])^;
        End { of Tag = 257 }

        Else If (Tag = 258) Then
           BitsPerPixel := IFD[4]

       Else If (Tag = 270)
        Then Begin
          { ASCII type }
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          SetLength(ImageDesc, CountOfType);
          Pt := @ImageDesc[1];
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);
          if (AnsiStartsStr('ImageJ',ImageDesc)) then begin
            TIFFfileType := TIFF_ImageJ;
            PixSettings.FileHasOwnPixSize := False;
            PosCnt := PosEx('channels=', ImageDesc);
            if (PosCnt > 0) then NrChannelsInFile := StrToInt((Copy(ImageDesc, PosCnt + 9, 1))) else NrChannels := 1;
          end;
        End // If  'Tag = 270

        Else If (Tag = 273) Then
        Begin
          CountOfType := pLongWord(@IFD[2])^;
          SetLength(StripOffsLoc,CountOfType);

          If (CountOfType > 1) Then
          Begin
            ValOffset := pLongWord(@IFD[4])^;
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := IFD[4];
            End
            Else If (CountOfType > 1) Then
            Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile,Pt^,CountOfType*2);
              for TemCnt := 0 to High(StripOffsLoc) do
                StripOffsLoc[TemCnt] := TemWArr[TemCnt];
            End;
          End
          Else If (TypeF = 4) Then
          Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := pLongWord(@IFD[4])^
            End
            Else If CountOfType > 1 Then
            Begin
              Pt := @StripOffsLoc[0];
              FileRead(TiffFile, Pt^,CountOfType*4);
            End;
          End; { of TypeF = 4 }
        End { of Tag = 273 }
        Else If (Tag = 277) { SHORT } Then
        Begin
          SamplesPerPixel := IFD[4];
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
        Else If (Tag = 278) Then
        Begin
          if (TypeF = 3) then RowsPerStrip := IFD[4]
            else
          if (TypeF = 4) then RowsPerStrip := pLongWord(@IFD[4])^;
        End { of Tag = 278 }
        Else If (Tag = 279) Then
        Begin
          CountOfType := pLongWord(@IFD[2])^;
          SetLength(StripSizesLoc, CountOfType);

          If (CountOfType > 1) Then
          Begin
            ValOffset := pLongWord(@IFD[4])^;
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin
            If (CountOfType = 1) Then
            Begin
              StripSizesLoc[0] := IFD[4];
            End
            Else If (CountOfType > 1) Then
            Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile, Pt^, CountOfType * 2);
              for TemCnt := 0 to High(StripSizesLoc) do
                StripSizesLoc[TemCnt] := TemWArr[TemCnt];
            End;
          End
            Else If (TypeF = 4) Then
          Begin // LONG = LongWord
            If (CountOfType = 1) Then
            Begin
              StripSizesLoc[0] := pLongWord(@IFD[4])^;
            End
            Else If (CountOfType > 1) Then
            Begin
              Pt := @StripSizesLoc[0];
              FileRead(TiffFile, Pt^, CountOfType* 4);
            End;
          End;
        End { of Tag = 279 }
          Else
        If (Tag = 320) Then Begin
        End { of Tag 320;  If 'last tag value }

         Else

         If (Tag = 34363) then Begin
          CountOfType := pLongWord(@IFD[2])^;
          ValOffset   := pLongWord(@IFD[4])^;
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, NrChannelsInFile, 4);
        End
          Else
        If (tag = 65328) then begin
          ValOffset   := pLongWord(@IFD[4])^;
          Pt := @TemDouble;
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, 8);
          NrChannelsInFile  := Trunc(TemDouble);
        End;

      End    { ----------------End of INTEL Type of Files -------------------- }


        Else { If 'ToSwapLoc = false }


      { ---------------  Motorola Type of Files ----------------------- }

      If (ToSwapLoc) Then
      Begin

        If (Tag = 256) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then ImageWidth := Swap(IFD[4])
            else
          if (TypeF = 4) then ImageWidth := SwapLongWord(pLongWord(@IFD[4])^);
        End { of Tag = 256 }
        Else If (Tag = 257) Then
        Begin { could be SHORT or LONG }
          if (TypeF = 3) then ImageHeight := Swap(IFD[4])
          else
          if (TypeF = 4) then ImageHeight := SwapLongWord(pLongWord(@IFD[4])^);
        End { of Tag = 257 }

        Else If (Tag = 258)  Then
          BitsPerPixel := Swap(IFD[4])

        Else If (Tag = 270)
        Then Begin
          { ASCII type }
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
          SetLength(ImageDesc, CountOfType);
          Pt := @ImageDesc[1]; // sets Pter to 1st position
          FileSeek(TiffFile, ValOffset, 0);
          FileRead(TiffFile, Pt^, CountOfType);
          if (AnsiStartsStr('ImageJ',ImageDesc)) then begin
            TIFFfileType := TIFF_ImageJ;
            PixSettings.FileHasOwnPixSize := False;
            PosCnt := PosEx('channels=', ImageDesc);
            if (PosCnt > 0) then NrChannelsInFile := StrToInt((Copy(ImageDesc, PosCnt + 9, 1))) else NrChannels := 1;
          end;
        End // If  'Tag = 270

        Else If (Tag = 273) Then
        Begin
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          SetLength(StripOffsLoc, CountOfType);

          If (CountOfType > 1) Then Begin
            ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
            FileSeek(TiffFile, ValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := Swap(IFD[4]);
            End
            Else If (CountOfType > 1) Then
            Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile,Pt^,CountOfType*2);
              for TemCnt := 0 to High(StripOffsLoc) do
                StripOffsLoc[TemCnt] := Swap(TemWArr[TemCnt]);
            End;
          End
          Else If (TypeF = 4) Then
          Begin
            If (CountOfType = 1) Then
            Begin
              StripOffsLoc[0] := SwapLongWord(pLongWord(@IFD[4])^);
            End
            Else If (CountOfType > 1) Then
            Begin
              Pt := @StripOffsLoc[0];
              FileRead(TiffFile, Pt^, CountOfType*4);
              for TemCnt := 0 to High(StripOffsLoc) do
               StripOffsLoc[TemCnt] := SwapLongWord(StripOffsLoc[TemCnt]);
            End;
          End; { of TypeF = 4 }
        End { of Tag = 273 }
        Else If (Tag = 277) { SHORT } Then
        Begin
          SamplesPerPixel := Swap(IFD[4]);
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
        Else If (Tag = 278) Then
        Begin
          if (TypeF = 3) then RowsPerStrip := Swap(IFD[4])
            else
          if (TypeF = 4) then RowsPerStrip := SwapLongWord(pLongWord(@IFD[4])^);
        End { of Tag = 278 }
        Else If (Tag = 279) Then
        Begin 
          CountOfType := SwapLongWord(pLongWord(@IFD[2])^);
          SetLength(StripSizesLoc, CountOfType);

          If (CountOfType > 1) Then
          Begin
            ValOffset := SwapLongWord(pLongWord(@IFD[4])^);
            FileSeek(TiffFile, ValOffset, 0);
          End;
          If (TypeF = 3) Then
          Begin
            If (CountOfType = 1) Then
            Begin
              StripSizesLoc[0] := Swap(IFD[4]);
            End
            Else If (CountOfType > 1) Then
            Begin
              SetLength(TemWarr, CountOfType);
              Pt := @TemWarr[0];
              FileRead(TiffFile, Pt^, CountOfType*2);
              for TemCnt := 0 to High(TemWarr) do
                StripSizesLoc[TemCnt] := Swap(TemWarr[TemCnt]);
            End;
          End
          Else If (TypeF = 4) Then
          Begin
            If CountOfType = 1 Then
            Begin
              StripSizesLoc[0] := SwapLongWord(pLongWord(@IFD[4])^);
            End
            Else If CountOfType > 1 Then
            Begin
              Pt := @StripSizesLoc[0];
              FileRead(TiffFile, Pt^, CountOfType*4);
              for TemCnt := 0 to High(StripSizesLoc) do
                StripSizesLoc[TemCnt] := SwapLongWord(StripSizesLoc[TemCnt]);
            End;
          End;
        End { of Tag = 279 }

      End; { of ToSwap = True }

      /// /////////////// End of Swap and NoSwap ///////////////////////////////

    End; { For Cnt := 0 To CntDE - 1  Do Begin }

    ///////////////////// End of Reading TAGs /////////////////////////////////

        FPos := FPos + 12;
        FileSeek(TiffFile, FPos, 0); // looks for next image
        FileRead(TiffFile, ValOffset, 4);

        if (ToSwapLoc) { Motorola } then ValOffset := SwapLongWord(ValOffset);
        if (ValOffset > 0) then MultiImage := True else MultiImage := False;

    If (SamplesPerPixel = 1) and (NrChannelsInFile <= 2) then begin

      ValidFile := True;
      NeedSwap := ToSwapLoc;

      If High(StripOffsLoc) > 0 then Begin
        TemCnt := 0;
        ValOffset := 0;
        For PosCnt := 0 to High(StripOffsLoc) - 1 do
        Begin
          if StripSizesLoc[PosCnt] + StripOffsLoc[PosCnt] = StripOffsLoc
            [PosCnt + 1] then
          begin
            Inc(TemCnt);
            StripSizesLoc[ValOffset] := StripSizesLoc[ValOffset] + StripSizesLoc
              [PosCnt + 1];
          end
          else if StripSizesLoc[PosCnt] + StripOffsLoc[PosCnt] <> StripOffsLoc
            [PosCnt + 1] then
          begin
            Inc(ValOffset);
          end;
        End; // for
        SetLength(StripSizesLoc, Length(StripSizesLoc) - TemCnt);
        SetLength(StripOffsLoc, Length(StripOffsLoc) - TemCnt);
      End;

      If (BitsPerPixel = 16) Then
      Begin
        SetLength(DynWarr, ImageWidth * ImageHeight);
        Pt := @DynWarr[0];
      End
      Else If (BitsPerPixel = 8) Then
      Begin
        SetLength(DynBarr, ImageWidth * ImageHeight);
        Pt := @DynBarr[0];
      End;

      If High(StripOffsLoc) = 0 Then
      Begin
        FileSeek(TiffFile, StripOffsLoc[0], 0);
        FileRead(TiffFile, Pt^, StripSizesLoc[0]);
      End
      Else If High(StripOffsLoc) > 0 Then
      Begin
        ReadArrPos := 0;
        If BitsPerPixel = 16 Then
          For Cnt := 0 to High(StripOffsLoc) Do
          Begin
            FileSeek(TiffFile, StripOffsLoc[Cnt], 0);
            Pt := @Im16bitData[ReadArrPos];
            Inc(ReadArrPos, StripSizesLoc[Cnt] shr 1);
            FileRead(TiffFile, Pt^, StripSizesLoc[Cnt]);
          End
          Else If BitsPerPixel = 8 Then
            For Cnt := 0 to High(StripOffsLoc) Do
            Begin
              FileSeek(TiffFile, StripOffsLoc[Cnt], 0);
              Pt := @Im8bitData[ReadArrPos];
              Inc(ReadArrPos, StripSizesLoc[Cnt]);
              FileRead(TiffFile, Pt^, StripSizesLoc[Cnt]);
            End;
      End; // High(StripOffsLoc) > 0

    End

      Else // If (SamplesPerPixel = 1)

    Begin

      ValidFile := False;
      if (SamplesPerPixel > 1) then
            MessageDlg('This is Not a Grayscale Tiff file.  It is ' + IntToStr
            (SamplesPerPixel * 8) + ' bit file', mtError, [mbOK], 0) else
      if (NrChannelsInFile > 2) then
            MessageDlg('This File has ' + IntToStr(NrChannelsInFile) +
                        ' Channels. SparkAn so far Works with One or Two Channel Files. ',
                        mtError, [mbOK], 0);
    End; // Else

  End

    Else { IfThisIsTIFF = 42 (this is a Tiff File }
  { -------------------------------------------------- }
  If (IfThisIsTIFF = 43) Then Begin

    BigTiff := True;

    FPos := 8;  //offset to 1st IFD
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, BigOffsIFD, 8);

    { finds the FPos for the first IFD (Counted From "0" }

    FPos := BigOffsIFD; { 'Goes to the First 2 bytes of IDF (Pos 0-1) }
    FileSeek(TiffFile, FPos, 0);
    FileRead(TiffFile, BigCntDE, 8); { 'Gets Number of Entrees in IDF }

    { FPos := BigOffsIFD + 8; }{ goes to Pos 2 (2)(counted from ) byte in IDF) }
    BegRead := BigOffsIFD + 8;
    { ------- Checks All Tags in CntDE -------- }
    For Cnt := 0 To BigCntDE - 1 Do
    Begin
      FPos := BegRead + Cnt * 20; {  20 bytes offset for each DE }
      FileSeek(TiffFile, FPos, 0);
      FileRead(TiffFile, BigIFD, 20); { Gets each CntDE each 12 byte Entries }
      Tag   := pWord(@BigIFD[0])^; { bytes 0-1 }
      TypeF := pWord(@BigIFD[2])^; { bytes 2-3 } { Type of data ; short, long etc. }
     // CntDE := pWord(@pRawData[FPos])^;
        { ------- I N T E L     Type  ------- }

        If (Tag = 256) Then Begin
          if (TypeF = 3) then ImageWidth := pWord(@BigIFD[12])^
            else
          if (TypeF = 4) then ImageWidth := pLongWord(@BigIFD[12])^;
        End { of Tag = 256 }
         Else
        If (Tag = 257) Then Begin
          if (TypeF = 3) then ImageHeight := pWord(@BigIFD[12])^
          else
          if (TypeF = 4) then ImageHeight := pLongWord(@BigIFD[12])^;
        End { of Tag = 257 }
          Else
        If (Tag = 258) Then
          { SHORT C++ } BitsPerPixel := pWord(@BigIFD[12])^
          Else
        If (Tag = 273) Then Begin
          CountOfType := pLongWord(@BigIFD[4])^;
          SetLength(BigStripOffsLoc,CountOfType);
          If (CountOfType > 1) Then Begin
            BigValOffset := pUInt64(@BigIFD[12])^;
            FileSeek(TiffFile, BigValOffset, 0);
          End;

          If (TypeF = 3) Then Begin
            If (CountOfType = 1) Then Begin
              BigStripOffsLoc[0] := pWord(@BigIFD[12])^;
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile,Pt^,CountOfType*2);
              for TemCnt := 0 to High(BigStripOffsLoc) do
                BigStripOffsLoc[TemCnt] := TemWArr[TemCnt];
            End;
          End
            Else
          If (TypeF = 4) Then Begin
            If (CountOfType = 1) Then Begin
              BigStripOffsLoc[0] := pLongWord(@BigIFD[12])^
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemLWArr,CountOfType);
              Pt := @TemLWArr[0];
              FileRead(TiffFile,Pt^,CountOfType*4);
              for TemCnt := 0 to High(BigStripOffsLoc) do
                BigStripOffsLoc[TemCnt] := TemLWArr[TemCnt];
            End;
          End { of TypeF = 4 }
            Else
          If (TypeF = 16) Then Begin
            If (CountOfType = 1) Then
            Begin
              BigStripOffsLoc[0] := pUInt64(@BigIFD[12])^
            End
              Else
            If (CountOfType > 1) Then
            Begin
              Pt := @BigStripOffsLoc[0];
              FileRead(TiffFile, Pt^,CountOfType*8);
            End;
          End; { of TypeF = 16 }
        End { of Tag = 273 }
          Else
        If (Tag = 277) { Word, Count = 1 } Then Begin
          SamplesPerPixel := pWord(@BigIFD[12])^;
          if (SamplesPerPixel <> 1) then
            Break;
        End { of Tag = 277 }
          Else
        If (Tag = 278) Then Begin
          if (TypeF = 3) then RowsPerStrip := pWord(@BigIFD[12])^
            else
          if (TypeF = 4) then RowsPerStrip := pLongWord(@BigIFD[12])^; {LongWord = 4 byte unsigned int}
        End { of Tag = 278 }
          Else
        If (Tag = 279) Then Begin
          CountOfType := pLongWord(@BigIFD[4])^;
          SetLength(BigStripSizesLoc, CountOfType);

          If (CountOfType > 1) Then Begin
            BigValOffset := pUInt64(@BigIFD[12])^;
            FileSeek(TiffFile, BigValOffset, 0);
          End;

          If (TypeF = 3) Then
          Begin
            If (CountOfType = 1) Then Begin
              BigStripSizesLoc[0] := pWord(@BigIFD[12])^;
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemWArr[0];
              FileRead(TiffFile, Pt^, CountOfType * 2);
              for TemCnt := 0 to High(BigStripSizesLoc) do
                BigStripSizesLoc[TemCnt] := TemWArr[TemCnt];
            End;
          End
            Else
          If (TypeF = 4) Then Begin
            If (CountOfType = 1) Then
            Begin
              BigStripSizesLoc[0] := pLongWord(@BigIFD[12])^;
            End
              Else
            If (CountOfType > 1) Then Begin
              SetLength(TemWArr,CountOfType);
              Pt := @TemLWArr[0];
              FileRead(TiffFile, Pt^, CountOfType * 4);
              for TemCnt := 0 to High(BigStripSizesLoc) do
                BigStripSizesLoc[TemCnt] := TemLWArr[TemCnt];
            End;
          End
            Else
          If (TypeF = 16) Then Begin // = UInt64 (8bytes)
            If (CountOfType = 1) Then
            Begin
              BigStripSizesLoc[0] := pUInt64(@BigIFD[12])^
            End
            Else If (CountOfType > 1) Then
            Begin
              Pt := @BigStripSizesLoc[0];
              FileRead(TiffFile, Pt^, CountOfType* 8);
            End;
          End;
        End { of Tag = 279 }
          Else
        If (Tag = 320) Then Begin
        End;  { of Tag 320;  If 'last tag value }
    End;  //For Cnt := 0 To BigCntDE - 1 Do

     ///////////////////// End of Reading TAGs /////////////////////////////////

        FPos := FPos + 20;
        FileSeek(TiffFile, FPos, 0); // looks for next image
        FileRead(TiffFile, BigValOffset, 8);

        if (BigValOffset > 0) then MultiImage := True else MultiImage := False;

     If (SamplesPerPixel = 1) then Begin

      ValidFile := True;

      If High(BigStripOffsLoc) > 0 then Begin
        TemCnt := 0;
        ValOffset := 0;
        For PosCnt := 0 to High(BigStripOffsLoc) - 1 do Begin
          if (BigStripSizesLoc[PosCnt] + BigStripOffsLoc[PosCnt] = BigStripOffsLoc[PosCnt + 1]) then
          begin
            Inc(TemCnt);
            BigStripSizesLoc[ValOffset] := BigStripSizesLoc[ValOffset] + BigStripSizesLoc[PosCnt + 1];
          end
            else
          if (BigStripSizesLoc[PosCnt] + BigStripOffsLoc[PosCnt] <> BigStripOffsLoc[PosCnt + 1]) then
          begin
            Inc(ValOffset);
          end;
        End;
        SetLength(BigStripSizesLoc, Length(BigStripSizesLoc) - TemCnt);
        SetLength(BigStripOffsLoc,  Length(BigStripOffsLoc)  - TemCnt);
      End; // If High(StripOffs) > 0

      If (BitsPerPixel = 16) Then
      Begin
        SetLength(DynWarr, ImageWidth * ImageHeight);
        Pt := @DynWarr[0];
      End
        Else
      If (BitsPerPixel = 8) Then Begin
        SetLength(DynBarr, ImageWidth * ImageHeight);
        Pt := @DynBarr[0];
      End;

      If High(BigStripOffsLoc) = 0 Then Begin
        FileSeek(TiffFile, BigStripOffsLoc[0], 0);
        FileRead(TiffFile, Pt^, BigStripSizesLoc[0]);
      End
        Else
      If High(BigStripOffsLoc) > 0 Then Begin
        ReadArrPos := 0;
        If BitsPerPixel = 16 Then
          For Cnt := 0 to High(BigStripOffsLoc) Do Begin
            FileSeek(TiffFile, BigStripOffsLoc[Cnt], 0);
            Pt := @Im16bitData[ReadArrPos];
            { Sets Pter at Appropriate Position in Array }
            Inc(ReadArrPos, BigStripSizesLoc[Cnt] shr 1);
            FileRead(TiffFile, Pt^, BigStripSizesLoc[Cnt]);
          End
            Else
          If BitsPerPixel = 8 Then
            For Cnt := 0 to High(StripOffsLoc) Do Begin
              FileSeek(TiffFile, BigStripOffsLoc[Cnt], 0);
              Pt := @Im8bitData[ReadArrPos];
              Inc(ReadArrPos, BigStripSizesLoc[Cnt]);
              FileRead(TiffFile, Pt^, BigStripSizesLoc[Cnt]);
            End;
      End; // High(StripOffsLoc) > 0
    End // If (SamplesPerPixel = 1)
      Else
    Begin
      ValidFile := False;
      MessageDlg('This is Not a Grayscale Tiff file.  It is ' + IntToStr
            (SamplesPerPixel * 8) + ' bit file', mtError, [mbOK], 0);
    End; // Else Begin

  End //If IfThisIsTIFF = 43

  { ------------------ End of Big Tiff ------------------ }

    Else

  If (IfThisIsTIFF <> 42) and (IfThisIsTIFF <> 43) Then
  Begin
    ValidFile := False;
    MessageDlg('This is Not a Tiff file', mtError, [mbOK], 0);
  End;
  { -------------------------------------------------- }
  FileClose(TiffFile);

End; // Procedure GetTIFFfile_Preview

{ ************************************************************************** }



Procedure OpenCollectionFile(const CollFileName: AnsiString);
{ Global Variables
  CollFileNames     : Array of AnsiString;
  CollFileHandles   : Array of Integer;//File Handle (Win32) for Each File; Length of Array = Nr of All Image
  }

Var
  CollFileHandle: THandle;
  FPos, FPosMem: Int64;
  pRead: Pointer;
  ReadStr: AnsiString;
  FilePath: AnsiString;
  NrOfColFiles: Word;
  OffsetToSect: Longint;
  OffsetToVar: Longint;
  StrLen: Longint;
  Cnt : Integer;
  TempCollFileNames: Array of AnsiString;
  VersionNr: Integer;
  VersOffset: Integer;
  AnsiArr : Packed Array[0..30] of AnsiChar;

Begin

   CollFileHandle := FileOpen(CollFileName, fmOpenRead or fmShareDenyNone);

  { Check if this is a SparkAn Collection File & Version }
  SetLength(ReadStr, 28);
  pRead := @ReadStr[1];
  FPos := 0;
  FileSeek(CollFileHandle, FPos, 0);
  FileRead(CollFileHandle, pRead^, Length(ReadStr));

  If (ReadStr = 'SparkAn Collection File v.1 ') or
     (ReadStr = 'SparkAn Collection File v.2 ') or
     (ReadStr = 'SparkAn Collection File v.3 ') or
     (ReadStr = 'SparkAn Collection File v.4 ') Then
  Begin

    if (ReadStr = 'SparkAn Collection File v.1 ') then
    begin
      VersionNr := 1;
      VersOffset := 0;
    end
    else if (ReadStr = 'SparkAn Collection File v.2 ') then
    begin
      VersionNr := 2;
      VersOffset := 40;
    end;
    if (ReadStr = 'SparkAn Collection File v.3 ') then
    begin
      VersionNr := 3;
      VersOffset := 40;
    end;
    if (ReadStr = 'SparkAn Collection File v.4 ') then
    begin
      VersionNr := 4;
      VersOffset := 100;
    end;

    { 1st. Get Number of Files }
    FPos := 28; // Length(FileHeader) = 28 but I leave 2 more bytes
    FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
    FileRead(CollFileHandle, NrOfColFiles, SizeOf(Word));

    { 2nd. Get File Names (with full path) }
    // Gets Offset to FileNames Section and checks if they exist//
    SetLength(TempCollFileNames, NrOfColFiles);
    FPos := 60 + VersOffset;
    FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
    FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));

    FPos := OffsetToSect;
    for Cnt := 0 to High(TempCollFileNames) do
    begin
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, OffsetToVar, SizeOf(Longint));

      FPos := FPos + SizeOf(OffsetToVar);
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, StrLen, SizeOf(StrLen));
      FPos := FPos + SizeOf(StrLen);

      FPosMem := FPos;

      SetLength(TempCollFileNames[Cnt], StrLen);
      pRead := @TempCollFileNames[Cnt, 1];
      FPos := OffsetToVar;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, pRead^, Length(TempCollFileNames[Cnt]));
      FPos := FPosMem;
    end;

    // add File Path//
    FilePath := ExtractFilePath(CollFileName);
    for Cnt := 0 to High(TempCollFileNames) do begin
      TempCollFileNames[Cnt] := FilePath + TempCollFileNames[Cnt];
    end;

      { copy FileNames to Global CollFileNames }
      SetLength(CollFileNames, NrOfColFiles);
      for Cnt := 0 to High(TempCollFileNames) do begin
        CollFileNames[Cnt] := TempCollFileNames[Cnt];
      end;

      { reads some single variables with fixed offset }
      FPos := 30;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, AndorNrDIM, SizeOf(AndorNrDIM));

      FPos := 34;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, DimTime, SizeOf(DimTime));

      FPos := 38;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, DimNotTime, SizeOf(DimNotTime));

      FPos := 42;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, imXsize, SizeOf(imXsize));

      FPos := 46;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, imYsize, SizeOf(imYsize));

      FPos := 50;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, BitCount, SizeOf(BitCount));

      FPos := 52;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, shrFact, SizeOf(shrFact));

      if (VersionNr in [2, 3]) then begin
        FPos := 56;
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, PixSettings.FilePixSize,
          SizeOf(PixSettings.FilePixSize)); // Do Not use PixSize directly here

        FPos := 64;
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, PixSettings.ImageBinning,SizeOf(PixSettings.ImageBinning));
      end;
      {from here - new variables in troduced by v.4, Oct 2016}
  {reference to Delphi XE5 Data Types:  http://docwiki.embarcadero.com/RADStudio/XE5/en/Simple_Types}

      { Reads NrChannels = Integer = 4 bytes}
      FPos := 65;
      FileSeek(CollFileHandle, FPos,0);
      FileRead(CollFileHandle, NrChannels,SizeOf(NrChannels));

      { Reads LoadChAsIndivFiles = Boolean = 1 byte}
      FPos := 69;
      FileSeek(CollFileHandle, FPos,0);
      FileRead(CollFileHandle, LoadChAsIndivFiles,SizeOf(LoadChAsIndivFiles));

      { Reads MovieSeriesType (TimeSeries or Z_Stack) = Byte = 1 byte}
      FPos := 70;
      FileSeek(CollFileHandle, FPos,0);
      FileRead(CollFileHandle, MovieSeriesType,SizeOf(MovieSeriesType));

      { Reads ScopeSystemParams.Ch1_Name = String = Lenght(WriteAnsiArr)}
      FPos := 71;
      FillChar(AnsiArr,SizeOf(AnsiArr),#0);
      pRead := @AnsiArr[0];
      FileSeek(CollFileHandle, FPos,0);
      FileRead(CollFileHandle, pRead^, SizeOf(AnsiArr));
      ScopeSystemParams.Ch1_Name := '';
      for Cnt := 0 to High(AnsiArr) do begin
        if (AnsiArr[Cnt] > #0) then
          ScopeSystemParams.Ch1_Name := ScopeSystemParams.Ch1_Name + AnsiArr[Cnt]
          else
        if AnsiArr[Cnt] = #0 then Break;
      end;

      { Reads ScopeSystemParams.Ch1_Name = String = Lenght(WriteAnsiArr)}
      if (NrChannels = 2) then begin
      FPos := 101;
      FillChar(AnsiArr,SizeOf(AnsiArr),#0);
      pRead := @AnsiArr[0];
      FileSeek(CollFileHandle, FPos,0);
      FileRead(CollFileHandle, pRead^, SizeOf(AnsiArr));
      ScopeSystemParams.Ch2_Name := '';
      for Cnt := 0 to High(AnsiArr) do begin
        if AnsiArr[Cnt] > #0 then
          ScopeSystemParams.Ch2_Name := ScopeSystemParams.Ch2_Name + AnsiArr[Cnt]
        else
        if AnsiArr[Cnt] = #0 then Break;
      end;
      end;
      { starts reading the Rest of the Sections }

      { Nr Images Per File Section }
      FPos := 64 + VersOffset;
      FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
      FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
      SetLength(CollFileImNr, NrOfColFiles);
      pRead := @CollFileImNr[0];
      FPos := OffsetToSect;
      FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
      FileRead(CollFileHandle, pRead^, NrOfColFiles * SizeOf(LongWord));

      NrIm := 0;
      for Cnt := 0 to High(CollFileImNr) do begin
        NrIm := NrIm + CollFileImNr[Cnt];
      end;

      NrIm := NrIm div NrChannels;

      { Image Offset Section }
      SetLength(ImOff, NrChannels, NrIm);
      FPos := 68 + VersOffset;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
      FPos := OffsetToSect;
      pRead := @ImOff[0,0];
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, pRead^, NrIm * SizeOf(Int64));
      If (NrChannels = 2) then Begin
        FPos := OffsetToSect + NrIm * SizeOf(Int64);
        pRead := @ImOff[1,0];
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, pRead^, NrIm * SizeOf(Int64));
      End;

      { Time Stamps Section }
      If DimTime > -1 then Begin
        FPos := 72 + VersOffset;
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
        SetLength(TimeSt, NrIm);
        If (NrChannels = 1) Then Begin
          pRead := @TimeSt[0];
          FPos := OffsetToSect;
          FileSeek(CollFileHandle, FPos, 0);
          FileRead(CollFileHandle, pRead^, NrIm * SizeOf(Double));
        End
          Else
        If (NrChannels = 2) Then Begin
          SetLength(TimeStStore, NrIm * 2);
          pRead := @TimeStStore[0];
          FPos := OffsetToSect;
          FileSeek(CollFileHandle, FPos, 0);
          FileRead(CollFileHandle, pRead^, 2 * NrIm * SizeOf(Double));
          RefillTimStArray;
        End;

        if (VersionNr in [1, 2]) then begin
          // corrects for the mistake for subtracting TimeSt[0] only from the first Image
          // here MeanImTime is temporarily used to store first Image Time
          MeanImTime := GetAndorTiffFirstImageTime(CollFileNames[0]);
          for Cnt := 1 to High(TimeSt) do
            TimeSt[Cnt] := TimeSt[Cnt] - MeanImTime;
        end;

        MeanImTime := TimeSt[High(TimeSt)] / (NrIm - 1);
        ExportDial.OrigFrameRate := 1 / (TimeSt[High(TimeSt)] / (NrIm - 1));
      End; // if DimTime > -1 then begin

      { Andor Not Time Array Section }
      if (DimNotTime > -1) then begin
        FPos := 76 + VersOffset;
        FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
        FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
        SetLength(ZstackArr, NrIm);
        pRead := @ZstackArr[0];
        FPos := OffsetToSect;
        FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
        FileRead(CollFileHandle, pRead^, NrIm * SizeOf(Double));

        { Reads Units }
        FPos := 80 + VersOffset;
        FileSeek(CollFileHandle, FPos, 0); { 0 = Origin = Begining of File }
        FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
        FPos := OffsetToSect;
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, StrLen, SizeOf(Longint));
        SetLength(ReadStr, StrLen);
        pRead := @ReadStr[1];
        FPos := FPos + SizeOf(Longint);
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, pRead^, StrLen);
      end;

      {Color Tables}
      FPos := 84 + VersOffset;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
      If (OffsetToSect > -1) then Begin
        SetLength(FileColorTBL_Ch1,768);
        pRead := @FileColorTBL_Ch1[0];
        FPos := OffsetToSect;
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, pRead^, Length(FileColorTBL_Ch1));
        frmImageControl.ubFileColTable.Tag := NrChannels;
      End;

      FPos := 88 + VersOffset;
      FileSeek(CollFileHandle, FPos, 0);
      FileRead(CollFileHandle, OffsetToSect, SizeOf(Longint));
      If (OffsetToSect > -1) then Begin
        SetLength(FileColorTBL_Ch2,768);
        pRead := @FileColorTBL_Ch2[0];
        FPos := OffsetToSect;
        FileSeek(CollFileHandle, FPos, 0);
        FileRead(CollFileHandle, pRead^, Length(FileColorTBL_Ch2));
      End;

      if (VersionNr = 1) then
        GetAndorTIFFBinningAndPixSize(CollFileNames[0], PixSettings.ImageBinning, PixSettings.FilePixSize);

      PixSettings.FileHasOwnPixSize := True;


  End;   // If (ReadStr = 'SparkAn Collection File v.4 ') Then Begin

  FileClose(CollFileHandle);


End;

{********************* End of Procedure OpenCollectionFile  ******************}

Procedure SaveCollectionFile(const CollFileName: AnsiString; var TiffCollFileNames : TDynAnsiStrArray);
{ Global Variables
  CollFileNames     : Array of AnsiString;
  CollFileHandles   : Array of Integer;//File Handle (Win32) for Each File; Length of Array = Nr of All Image
  }

Const
  OffsetToFileNamesSect = 200; //140 + 60 = 200;

Var
  CollFileHandle: File; // Pascal handle
  FPos, FPosMem: Longint; {FPos in 64 bit is still LongInt}
  pWrite: Pointer;
  WriteStr: AnsiString;
  NrOfColFiles: Word;
  Offset, StrLen,VersOffset : Longint;
  Cnt: Integer;
  //Len here means Number of Bytes to be written
  FileNamesSectLen    : LongWord; // Lenght of FileNames Section
  NrImPerFileSectLen  : LongWord;
  ImOffsetsSectLen    : LongWord;
  TimeStSectLen       : LongWord;
  AndorNotTimeSectLen : LongWord;
  ZstackUnitsSectLen  : LongWord;
  ColorTableLen       : LongWord;
  AnsiArr : Packed Array[0..30] of AnsiChar;

Begin

  If (ImageFileType <> FILE_COLLECTION) then
  begin
    { this is when Only One Single Andor Multi-Image Tiff was not Open as a Collection
      but in regular way.  Then we have to fill in the Collection Arrays
      }
    SetLength(TiffCollFileNames, 1);
    SetLength(CollFileImNr, 1);
    TiffCollFileNames[0] := ImFname;
    CollFileImNr[0] := NrIm;  // Global var; Number of Images for Each File; for Easy Loading the Files from the Table
  End;

  { version 3 implemented September 5, 2007; SparkAn 4.7.0.0 beta 4 to
    correct for subtraction Time of the 1st Image only from the 1st Image }
  {version 4 introduced Oct 2016 to reflect Number of Channels, Channel Name, Color Tables,
   LoadChAsIndivFiles, MovieSeriesType = TimeSeries or = Z_Stack}

  AssignFile(CollFileHandle, CollFileName);
  ReWrite(CollFileHandle, 1); // 1 byte blocks

  { 1st. Writes Header }
  WriteStr := 'SparkAn Collection File v.4 '; // Length(FileHeader) = 28 but I leave 2 more bytes
  pWrite := @WriteStr[1];
  FPos := 0;
  Seek(CollFileHandle, FPos); { 0 = Origin = Begining of File }
  BlockWrite(CollFileHandle, pWrite^, Length(WriteStr));

  { 2nd. Writes Number of Files }
  NrOfColFiles := Length(TiffCollFileNames);
  FPos := 28;
  Seek(CollFileHandle, FPos); { 0 = Origin = Begining of File }
  BlockWrite(CollFileHandle, NrOfColFiles, SizeOf(Word));

  { 3rd. Writes AndorNrDIM }
  FPos := 30;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, AndorNrDIM, SizeOf(Longint));

  { 4th. Writes DimTime }
  FPos := 34;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, DimTime, SizeOf(Longint));

  { 5th. Writes DimNotTime }
  FPos := 38;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, DimNotTime, SizeOf(Longint));

  { Writes imXsize }
  FPos := 42;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, imXsize, SizeOf(imXsize));

  { Writes imYsize }
  FPos := 46;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, imYsize, SizeOf(imYsize));

  { Writes BitCount }
  FPos := 50;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, BitCount, SizeOf(BitCount));

  { Writes shrFact = BitDept - 8 }
  FPos := 52;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, shrFact, SizeOf(shrFact));

  { Writes PixSize = size of one pixel in microns }
  FPos := 56;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, PixSize, SizeOf(PixSize));
  // use PixSize, Not PixSettings.FilePixSize

  { Writes Binning = Byte = 1 Bytes }
  FPos := 64;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, PixSettings.ImageBinning,SizeOf(PixSettings.ImageBinning));

  {from here - new variables in troduced by v.4, Oct 2016}
  {reference to Delphi XE5 Data Types:  http://docwiki.embarcadero.com/RADStudio/XE5/en/Simple_Types}

  { Writes NrChannels = Integer = 4 bytes}
  FPos := 65;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, NrChannels,SizeOf(NrChannels));

   { Writes LoadChAsIndivFiles = Boolean = 1 byte}
  FPos := 69;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, LoadChAsIndivFiles,SizeOf(LoadChAsIndivFiles));

  { Writes MovieSeriesType (TimeSeries or Z_Stack) = Byte = 1 byte}
  FPos := 70;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, MovieSeriesType,SizeOf(MovieSeriesType));

  { Writes ScopeSystemParams.Ch1_Name = String = Lenght(WriteAnsiArr)}
  FPos := 71;
  Seek(CollFileHandle, FPos);
  WriteStr := ScopeSystemParams.Ch1_Name;
  FillChar(AnsiArr,SizeOf(AnsiArr),#0);
  //or FillChar(WriteAnsiArr,SizeOf(WriteAnsiArr),Byte(0));
  for Cnt  := 1 to Length(WriteStr) do begin
    if (Cnt <= High(AnsiArr))  then
      AnsiArr[Cnt-1] := WriteStr[Cnt];
  end;
  pWrite := @AnsiArr[0];
  BlockWrite(CollFileHandle, pWrite^, SizeOf(AnsiArr));

  { Writes ScopeSystemParams.Ch2_Name = String = Lenght(WriteAnsiArr)}
   if (NrChannels = 2)  then begin
  FPos := 101;
  Seek(CollFileHandle, FPos);
  WriteStr := ScopeSystemParams.Ch2_Name;
  FillChar(AnsiArr,SizeOf(AnsiArr),#0);
  //or FillChar(WriteAnsiArr,SizeOf(WriteAnsiArr),Byte(0));
  for Cnt  := 1 to Length(WriteStr) do begin
    if (Cnt <= High(AnsiArr))  then
      AnsiArr[Cnt-1] := WriteStr[Cnt];
  end;
  pWrite := @AnsiArr[0];
  BlockWrite(CollFileHandle, pWrite^, SizeOf(AnsiArr));
  end;

  { -------------- Writing Sections --------------------------- }
  //VersOffset := 40; //for v.3
  VersOffset := 100; //for v.4

  { 6th. FileNames Section } // Starts Immediatelly after Offsets
  // Offset to FileNames Section//
  Offset := OffsetToFileNamesSect;
  FPos := 60 + VersOffset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, Offset, SizeOf(Longint));
  // Writes FileNames Section}

  FileNamesSectLen := 0;
  FPos := OffsetToFileNamesSect;
  Offset := OffsetToFileNamesSect + NrOfColFiles * 2 * SizeOf(Offset);
  // to the First Fliename (we have 2 * LongInt)

  For Cnt := 0 to High(TiffCollFileNames) Do Begin
    // writes offset to filename//
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, Offset, SizeOf(Longint));

    // writes File Name Length//
    WriteStr := ExtractFileName(TiffCollFileNames[Cnt]);
    StrLen := Length(WriteStr); // File Name AnsiStrings Length
    FPos := FPos + SizeOf(Offset);
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, StrLen, SizeOf(Longint));
    FPos := FPos + SizeOf(Longint);

    // writes FileName//
    pWrite := @WriteStr[1];
    FPosMem := FPos;
    FPos := Offset;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, pWrite^, Length(WriteStr));
    // restores FPos//
    FPos := FPosMem;
    // increments for the next one//
    Offset := Offset + StrLen; // Offsets to each FileName
    // accumulates Total Length//
    FileNamesSectLen := FileNamesSectLen + StrLen;
  End;
  FileNamesSectLen := FileNamesSectLen + NrOfColFiles * 2 * SizeOf(Longint);

  { 7th.Number of Images of Each File Section }
  // Offset to Number (LongInt) of Images of Each File Section//
  Offset := OffsetToFileNamesSect + FileNamesSectLen;
  FPos := 64 + VersOffset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, Offset, SizeOf(Longint));
  // Writes Number of Images of Each File//
  pWrite := @CollFileImNr[0];  //CollFileImNr contains the "Real" Number of Images for each File.  NrIm = RealNrIm div NrChannels
  NrImPerFileSectLen := Length(CollFileImNr) * SizeOf(LongWord);
  FPos := Offset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, pWrite^, NrImPerFileSectLen);

  { 8th. ImOffsets Section }
  // Offset to ImOffsets Section//
  Offset := OffsetToFileNamesSect + FileNamesSectLen + NrImPerFileSectLen;
  FPos := 68 + VersOffset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, Offset, SizeOf(Longint));
  // Writes Image Offsets//
  pWrite := @ImOff[0,0];
  ImOffsetsSectLen := Length(ImOff[0]) * SizeOf(Int64);
  FPos := Offset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, pWrite^, ImOffsetsSectLen);
  If (NrChannels = 2) then Begin
    pWrite := @ImOff[1,0];
   // ImOffsetsSectLen := Length(ImOff[1]) * SizeOf(Int64);  not needed as Length(ImOff[0] = Length(ImOff[1]
    FPos := Offset + ImOffsetsSectLen;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, pWrite^, ImOffsetsSectLen);
    ImOffsetsSectLen := ImOffsetsSectLen*2;
  End;

  { 9th. TimeStamps Section }
  // Writes the Offset to TimeStamps Section//
  if (DimTime > -1) then begin
    Offset := OffsetToFileNamesSect + FileNamesSectLen +
              NrImPerFileSectLen + ImOffsetsSectLen;
    TimeStSectLen := Length(TimeSt) * NrChannels * SizeOf(Double);
  end
    else
  if (DimTime = -1) then begin
    Offset := -1; // tells that there are not Time Stamps
    TimeStSectLen := 0;
  end;
  FPos := 72 + VersOffset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, Offset, SizeOf(Longint));
  // Writes Time Stamps//
  If (DimTime > -1) Then Begin
    if (NrChannels = 1) then pWrite := @TimeSt[0] else
                             pWrite := @TimeStStore[0];

    FPos := Offset;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, pWrite^, TimeStSectLen);
  End;

  { 10th. ZstackArr Section }
  // Offset to ZstackArr Section//
  if (DimNotTime > -1) then
  begin
    Offset := OffsetToFileNamesSect + FileNamesSectLen + NrImPerFileSectLen +
      ImOffsetsSectLen + TimeStSectLen;
    AndorNotTimeSectLen := Length(ZstackArr) * SizeOf(Double);
  end
    else
  if (DimNotTime = -1) then begin
    Offset := -1; // tells that there are not Time Stamps
    AndorNotTimeSectLen := 0;
  end;
  FPos := 76 + VersOffset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, Offset, SizeOf(Longint));
  // Writes Time Stamps//
  If DimNotTime > -1 Then  Begin
    pWrite := @ZstackArr[0];
    FPos := Offset;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, pWrite^, AndorNotTimeSectLen);
  End;

  { 11th. ZstackUnits Setion }
  // Offset To//
  if (DimNotTime > -1) then
  begin
    Offset := OffsetToFileNamesSect + FileNamesSectLen + NrImPerFileSectLen +
      ImOffsetsSectLen + TimeStSectLen + AndorNotTimeSectLen;
    ZstackUnitsSectLen := SizeOf(Longint) + Length(ZstackUnits);
  end
    else
  if DimNotTime = -1 then
  begin
    Offset := -1; // tells that there are not Time Stamps
    ZstackUnitsSectLen := 0;
  end;
  FPos := 80 + VersOffset;
  Seek(CollFileHandle, FPos);
  BlockWrite(CollFileHandle, Offset, SizeOf(Longint));
  // Writes Length and Name of ZstackUnits//
  If DimNotTime > -1 Then Begin
    StrLen := Length(ZstackUnits);
    FPos := Offset;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, StrLen, SizeOf(Longint));

    pWrite := @ZstackUnits[1];
    FPos := FPos + SizeOf(Longint);
    BlockWrite(CollFileHandle, pWrite^, StrLen);
  End;

  { 12th. First Color Table Section }
  // Offset to Color Table Section//
  If (frmImageControl.ubFileColTable.Tag in[1,2]) then Begin
    Offset := OffsetToFileNamesSect + FileNamesSectLen + NrImPerFileSectLen +
      ImOffsetsSectLen + TimeStSectLen + AndorNotTimeSectLen + ZstackUnitsSectLen;
    FPos := 84 + VersOffset;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, Offset, SizeOf(Longint));

    pWrite := @FileColorTBL_Ch1[0];
    FPos := Offset;
    Seek(CollFileHandle, FPos);
    BlockWrite(CollFileHandle, pWrite^, Length(FileColorTBL_Ch1));

    If (NrChannels = 2) then Begin
      Offset := OffsetToFileNamesSect + FileNamesSectLen + NrImPerFileSectLen +
                ImOffsetsSectLen + TimeStSectLen + AndorNotTimeSectLen +
                ZstackUnitsSectLen + Length(FileColorTBL_Ch1);
      FPos := 88 + VersOffset;
      Seek(CollFileHandle, FPos);
      BlockWrite(CollFileHandle, Offset, SizeOf(Longint));

      pWrite := @FileColorTBL_Ch2[0];
      FPos := Offset;
      Seek(CollFileHandle, FPos);
      BlockWrite(CollFileHandle, pWrite^, Length(FileColorTBL_Ch2));
    End;

  End;

  { ------------------- End of Writing -------------------- }

  CloseFile(CollFileHandle);

  If (ImageFileType <> FILE_COLLECTION) then begin
    { this is when Andor Multi-Image Tiff was not Open as a Collection
      but in regular way.  Then we have to nil the Collection Arrays which
      were set in the begining of this procedure }
    TiffCollFileNames := nil;
    CollFileImNr := nil;
  End;

End; //Procedure SaveCollectionFile

{******************************************************************************}

procedure LoadBMPinUniButton(const Ch1_Color, Ch2_Color : TColor; aUniButton : TUniButton);
  {Action  0 = Disabled
           1 = 1 channel
           2 = 2 channels
  }
var BMP : TBitmap;
    TextW, TextH, Action : Integer;
    BMPRect : TRect;
Begin



  Action := aUniButton.Tag;

  If (Action = 0) Then Begin
    aUniButton.Enabled := False;
    aUniButton.Margin := 5;
    aUniButton.SetImageNotSel(aUniButton.ImageHot);
    aUniButton.Caption := 'CTF';
  End
    Else
  If (Action in[1,2]) Then Begin    //One Channel
     aUniButton.Caption := '';
     aUniButton.Margin := 4;
     aUniButton.Caption := '';
     aUniButton.Enabled := True;

     BMP := TBitmap.Create;
     BMP.SetSize(aUniButton.Width-7,aUniButton.Height-7);

     BMPrect := BMP.Canvas.ClipRect;

     If (Action = 1) Then Begin
      BMP.Canvas.Pen.Color   := Ch1_Color;
      BMP.Canvas.Brush.Style := bsSolid;
      BMP.Canvas.Brush.Color := Ch1_Color;
      BMP.Canvas.Rectangle(0,0,BMPrect.Width,BMPrect.Height);
     End;

     If (Action = 2) Then Begin
        BMP.Canvas.Pen.Color   := clBtnFace;
        BMP.Canvas.Brush.Style := bsSolid;
        BMP.Canvas.Brush.Color := clBtnFace;

        BMP.Canvas.Rectangle(BMPrect.Width div 2 - 2,0,BMPrect.Width div 2 + 2,BMPrect.Height); //separator

        BMP.Canvas.Pen.Color   := Ch1_Color;
        BMP.Canvas.Brush.Color := Ch1_Color;
        BMP.Canvas.Rectangle(0,0,BMPrect.Width div 2 - 2,BMPrect.Height); ///left side

        BMP.Canvas.Pen.Color := Ch2_Color;
        BMP.Canvas.Brush.Color := Ch2_Color;
        BMP.Canvas.Rectangle(BMPrect.Width div 2 + 2,0,BMPrect.Width,BMPrect.Height); //right side
     End;


     aUniButton.SetImageSel(BMP);
     aUniButton.SetImageNotSel(BMP);

    BMP.Free;
 End;  //If (Action in[1,2]) Then Begin    /


End;  //procedure LoadBMPinUniButton(const Ch1_Color, Ch2_Color : TColor; aUniButton : TUniButton);


 {******************************************************************************}

Procedure LoadFileInRAM(Const FileCount : Integer; Const FName: AnsiString);
//for Single MultiImage Tiff File
 var Fh : THandle;
     pB : pByte;
     FPos,ChunkSize,FSize,Rem : Int64;
     Cnt   : LongInt;
     NrOfChuncks : Integer;

 begin

   NrOfChuncks  := 8; //for now this seems good. Increasing more increases time
                      //from 2 - 8 - it takes similar (same) time

  //Always loads in 8 chuncks

  FSize := GetBigFileSize(FName);
  ChunkSize := FSize div NrOfChuncks;
  //-------- Progress barr ----------//

  frmProgress.ImageProgressBar.Max := NrOfChuncks;
  Rem := FSize mod NrOfChuncks;
  Fh := FileOpen(FName, fmOpenRead or fmShareDenyNone);
  FPos := 0;
  for Cnt  := 0 to NrOfChuncks-1 do begin
    pB := @RawDataInRAM[FileCount,FPos];
    FileSeek(Fh, FPos, 0);
    if (Cnt < NrOfChuncks-1) then begin
      FileRead(Fh, pB^, ChunkSize);
      frmProgress.lbProgress.Caption := IntToStr(Round(((FPos+ChunkSize)/FSize)*100))+ '%';
    end else
    begin
      FileRead(Fh, pB^, ChunkSize + Rem);
      frmProgress.lbProgress.Caption := IntToStr(Round(((Rem+FPos+ChunkSize)/FSize)*100)) + '%';
    end;
    Inc(FPos,ChunkSize);
    frmProgress.ImageProgressBar.Position := Cnt+1;
    Application.ProcessMessages;
   end;

   FileClose(Fh);

End; //Procedure LoadFileInRAM

 {**********************************************************************}

Procedure OpenImageFile(Const FName: AnsiString;Const OpenDialogIndex : Byte;
          Const OpenAsFileCollection: Boolean; Const SilentMode: Boolean);

Var
 Sender             : TObject;
 Ftitle, imFileType : AnsiString;
 Cnt                : Integer;
 NrBytes            : DWORD;
 DisplayMainImage   : Boolean;
 DoSetRange         : Boolean;
 NrPages            : LongWord; // Used in this Procedure Only
 ImNrMem            : Integer;
 FileNr             : Integer;
 Ch1_Color          : TColor;
 Ch2_Color          : TColor;
 BIORAD_LUTpos      : Int64;
 OnChangeMem        : TNotifyEvent;
 pRawData           : pByteArr;
 FileSizes          : TDynUInt64Array; //used to Load in RAM


  procedure AllocateMemoryInRAMforSingleImageFiles;
  begin

      if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.ImageProgressBar.Max := NrIm;
          frmProgress.Show;
      end;
      frmProgress.lbAction.Caption := 'Attempting to Allocate Memory in RAM';
      Application.ProcessMessages;

      ImageBytes := ImagePix * (BitCount div 8); // in bytes
      SizeOfFile := GetBigFileSize(TiffFileList[0]);
      SetLength(FileSizes,1);
      FileSizes[0] := NrIm*SizeOfFile;
      FileInRAM := SetByteArray(RawDataInRAM,1,FileSizes);
      frmProgress.Close;
  end;


 procedure LoadMultipleFilesInRAM; //Stack of Single Image Tiffs
 var CntF  : LongInt;
     Fh    : THandle;
     pB    : pByte;

 begin

  if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.ImageProgressBar.Max := NrIm;
        frmProgress.lbAction.Caption := 'Memory Allocated. Loading in RAM.';
        frmProgress.Show;
        Application.ProcessMessages;
  end;

  For CntF := 0 to NrIm-1 do Begin
    Fh := FileOpen(TiffFileList[CntF], fmOpenRead or fmShareDenyNone);
    FileSeek(Fh,0, 0);
    pB := @RawDataInRAM[0,SizeOfFile*CntF];
    FileRead(Fh, pB^, SizeOfFile);
    FileClose(Fh);
    frmProgress.ImageProgressBar.Position := CntF+1;
    frmProgress.lbProgress.Caption := IntToStr(CntF + 1) + ' (' + IntToStr(NrIm) + ')';
    Application.ProcessMessages;
  End;

    frmProgress.lbAction.Caption := 'Loaded in RAM.';
    frmProgress.Close;
 End;

 procedure CloseOpenImageFile;
 var Fh: Integer;
  Begin

  If (ImFileOpen) then Begin  //for security reason one more check

    If (ImageFileType = MULTI_IMAGE) Then
      Begin
        FileClose(ImFile);
        ImFileOpen := False;
    End
    Else If (ImageFileType = FILE_COLLECTION) Then
    Begin
      for Fh := 0 to High(CollFileHandlesList) do
      begin
        FileClose(CollFileHandlesList[Fh]);
      end;
      ImFileOpen := False;
    End;
  End;
  End; // procedure CloseOpenImageFile;


  procedure NilCollectionArrays;
  begin
    CollFileNames       := nil;
    CollFileHandles     := nil;
    CollFileHandlesList := nil;
    CollFileImNr        := nil;
  end;

  procedure SplitImageOffsets(Ch1st : Integer);
  var i,Cnt,CntCh : Integer;
      ImageOffsets : TDynUInt64Array;
  begin
    SetLength(ImageOffsets,Length(ImOff[0]));
    Move(ImOff[0,0],ImageOffsets[0],Length(ImageOffsets)*SizeOf(Int64));

    SetLength(ImOff,NrChannels,Length(ImageOffsets) div NrChannels);

    For CntCh := 0 to NrChannels-1 Do Begin
      i   := CntCh;
      Cnt := 0;
      while i <= High(ImageOffsets) do begin
        ImOff[Ch1st,Cnt] := ImageOffsets[i];
        Inc(i,NrChannels);
        Inc(Cnt,1);
      end;
      if (Ch1st = 0) then Inc(Ch1st,1)
        else
      if (Ch1st > 0) then Dec(Ch1st,1);

    End;

  end; //procedure SplitImageOffsets;


  procedure GetLUTof2ndBioradFile(const FileTwoHandle : THandle);
  var P : Pointer;
      FPos : Int64;
  begin
      if (FileColorTBL_Ch2 = nil) then SetLength(FileColorTBL_Ch2, 768);
      P := @FileColorTBL_Ch2[0];
       FileSeek(FileTwoHandle, BIORAD_LUTpos, 0);
       FileRead(FileTwoHandle, P^, 768)
  end;

  procedure LoadBioradProject;
  var SearchRec         : TSearchRec;
      Success           :  Integer;
      FilePathOpen      : AnsiString;
      FNameOne,FNameTwo : Ansistring;
      FilesFound        : Integer;
  begin
        FilesFound := 0;
        FilePathOpen := ExtractFilePath(FName);
        Success := FindFirst(FilePathOpen + '*.pic', faAnyFile, SearchRec);
        if (Success = 0) then begin
          FilesFound := 1;
          FNameOne := FilePathOpen + SearchRec.Name;
          Success := FindNext(SearchRec);
          if (Success = 0) then begin
            FilesFound := 2;
            FNameTwo := FilePathOpen + SearchRec.Name;
          end;
        end;
        FindClose(SearchRec);

        NrChannels := FilesFound;
        ImFile := FileOpen(FNameOne, fmOpenRead or fmShareDenyNone);
        if (NrChannels = 2) then begin
          SetLength(CollFileHandles,2); //uses them to store the File Handles for the 2 Biorad files
          CollFileHandles[0] := ImFile;
          CollFileHandles[1] := FileOpen(FNameTwo, fmOpenRead or fmShareDenyNone);
          if (BIORAD_LUTpos > -1) then GetLUTof2ndBioradFile(CollFileHandles[1]);
        end;

   end; //procedure LoadBioradProject;

   Procedure ReduceZstackArr;
    var i,Cnt : Integer;
       ZstackArrStore : TDynDoubleArray;
    begin
      SetLength(ZstackArrStore,Length(ZstackArr));
      Move(ZstackArr[0],ZstackArrStore[0],Length(ZstackArrStore)*SizeOf(Double));
      SetLength(ZstackArr,NrIm);

      i   := 0;
      Cnt := 0;

      while i <= High(ZstackArrStore) do begin
        ZstackArr[Cnt] := ZstackArrStore[i];
        Inc(i,NrChannels);
        Inc(Cnt,1);
      end;
    end; //procedure ReduceAndorZstackArr;


BEGIN

          MainImLoaded := False;

          DisableFileColorTable; //shut off File Own Color Table if On

          If (frmImageControl.ubRatioOn.Selected) then with frmImageControl Do
          Begin
            ubRatioOn.Selected := False;
            ubRatioOn.Click;
          End;

          if (frmImageControl.unChDivCh.Selected) then with frmImageControl Do
          begin
            unChDivCh.Selected := False;
            unChDivCh.Click;
          End;

          if (frmImageControl.ubApplyFrame.Selected) then with frmImageControl do
          begin
            ubApplyFrame.Selected := False;
            ubApplyFrame.Click;
          end;

          if (frmImageControl.ubSizeBar.Selected) then with frmImageControl do
          begin
            ubSizeBar.Selected := False;
            ubSizeBar.Click;
          end;

          Screen.Cursor := crHourGlass;
          Application.ProcessMessages;

          ImSel := 0;
          if Not((OpenAsFileCollection) and
              (OpenDialogIndex = SINGLE_TIFF_INDEX)) then
            Ftitle := ExtractFileName(FName);
         
          FileInRAM := False; //Resets this the False in Case it is Open File

          // ------------------- Starts with Different Types ----------------------------//

  If (OpenDialogIndex = QED_INDEX)
          { Solamere Original File Menager } then
  Begin
            RawDataInRAM := nil; //frees the Array in Case it was loaded

            GetImgMgrfileInfo(FName, SilentMode);

            If (ImFileOpen) then begin
                CloseOpenImageFile;
                ImOff := nil;
                NilCollectionArrays;
            end; { IfimFileOpen = True }

            ImageFileType := SINGLE_IMAGE;
            ImFname := FName;
            MovFType := QED_MOV;
            NrChannels := 1;
  End

    Else

  If (OpenDialogIndex = NORAN_PRARIE_INDEX)
          { Noran (Prairie Technologies) } then
  Begin

    if (ExtractFileExt(FName) = '.pcf') then
      GetNoranPrairiePCFinfo(FName,SilentMode)
      else
    if (ExtractFileExt(FName) = '.xml') then
      GetNoranPrairieXMLinfo(FName,SilentMode);

    If (ImFileOpen) then Begin
      CloseOpenImageFile;
      NilCollectionArrays;
      ImOff := nil;
    End; { IfimFileOpen = True }

    ImageFileType := SINGLE_IMAGE;
    ImFname := FName;
    ToSwap := False;
    MovFType := NORAN_PRARIE_MOV;

    If (RAM_Usage.LoadFilesInRAM) Then Begin
      if (High(StripOffs) = 0) Then
        AllocateMemoryInRAMforSingleImageFiles
      else
      MessageDlg('Image data are not contiguous. Will not be loaded in RAM',mtError,[mbOK],0);
      if (FileInRAM) then begin
        LoadMultipleFilesInRAM;
      end else
      MessageDlg('Cannot be loaded in RAM',mtError,[mbOK],0);
    End;
    if not(FileInRAM) then RawDataInRAM := nil;
    NrChannels := 1;

  End

    Else

  If (OpenDialogIndex = StreamPix_INDEX) then
  Begin

    RawDataInRAM := nil; //frees the Array in Case it was loaded
    GetStreamPixInfo(FName, SilentMode);

    If (ImFileOpen) then Begin
      CloseOpenImageFile;
      NilCollectionArrays;
    End;

    TiffFileList := nil;
    ImFname := FName;
    ImFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
    ImFileOpen := True;
    ImageFileType := MULTI_IMAGE;
    ToSwap := False;
    MovFType := StreamPix_MOV;
    NrChannels := 1;
  End

    Else

  If (OpenDialogIndex = BIORAD_PIC_INDEX) { BioRad PIC files } then
  Begin

    RawDataInRAM := nil;
    GetBioRadPicFileInfo(FName, BIORAD_LUTpos, SilentMode);
    If (ImFileOpen) then Begin
      CloseOpenImageFile;
      NilCollectionArrays;
    End;
    TiffFileList := nil;

    ImFname := FName;
    LoadBioradProject;
    if (frmImageControl.ubFileColTable.Tag = 3) then
      frmImageControl.ubFileColTable.Tag := NrChannels;
    ImFileOpen := True;
    ImageFileType := MULTI_IMAGE;
    ToSwap := False;
    MovFType := BIORAD_PIC;

  End

    Else

  If (OpenDialogIndex = NORAN_SGI_INDEX) { Noran SGI files } then
  Begin

    RawDataInRAM := nil;

    GetSGIfileInfo(FName, SilentMode);

    If (ImFileOpen) then Begin
      CloseOpenImageFile;
      NilCollectionArrays;
    End;
    TiffFileList := nil;
    ImFname := FName;
    ImFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
    ImFileOpen := True;
    ImageFileType := MULTI_IMAGE;
    MovFType := NORAN_SGI_MOV;
    shrFact := 0;
    ToSwap := False;
    NrChannels := 1;
  End

    Else { Noran SGI files }
          { ----------------- End SGI Files------------- }

  If (OpenDialogIndex = NIKON_ND2_INDEX)  then
  Begin

      ImFname := FName;
      if (ImFileOpen) then begin
        CloseOpenImageFile;
        NilCollectionArrays;
      end; { IfimFileOpen = True }
      TiffFileList := nil;

      if (RAM_Usage.LoadFilesInRAM) then begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
        frmProgress.lbAction.Caption := 'Attempting to Allocate Memory in RAM';
        Application.ProcessMessages;
        SetLength(FileSizes,1);
        FileSizes[0] := GetBigFileSize(FName);
        FileInRAM := SetByteArray(RawDataInRAM,1,FileSizes);
      end;

      If (FileInRAM) then begin
        frmProgress.lbAction.Caption := 'Memory Allocated. Loading in RAM.';
        Application.ProcessMessages;
        LoadFileInRAM(0,FName);
        frmProgress.lbAction.Caption := 'Loaded in RAM.  Getting Info.';
        pRawData := @RawDataInRAM[0,0];
        GetND2fileInfoFromRAM(pRawData, SilentMode); { Global Proc }
      End
        Else
      Begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
          RawDataInRAM := nil;
        if (RAM_Usage.LoadFilesInRAM) then
          frmProgress.lbAction.Caption := 'Cannot be Loaded in RAM.  Getting Info.'
          else
        if not(RAM_Usage.LoadFilesInRAM) then
          frmProgress.lbAction.Caption := 'Getting Info.';

          Application.ProcessMessages;
          GetND2fileInfo(FName, SilentMode); { Global Proc }

      End; //Else Begin

      ImFname       := FName;
      if not(FileInRAM) then begin
        ImFile        := FileOpen(FName, fmOpenRead or fmShareDenyNone);
        ImFileOpen    := True;
      end;
      ImageFileType := MULTI_IMAGE;
      MovFType      := NIKON_ND2_MOV;


  End   { ----------------- End of  Nikon NIS-Elements ND2  files ------------- }

    Else

  If (OpenDialogIndex = STACK_TIFF_INDEX) { Grayscale Tiff } then
  Begin


    SetTIFfilesStack(FName, SilentMode);
    if (ToSwap) and (BitCount = 8) then ToSwap := False;

    If (ImFileOpen) then Begin
      CloseOpenImageFile;
      NilCollectionArrays;
      ImOff := nil;
    End; { IfimFileOpen = True }

    ImageFileType := SINGLE_IMAGE;
    ImFname := FName;
    if (TIFFfileType <> TIFF_ANDOR_iQ) then MovFType := STACK_BW_TIFF
      else
    if (TIFFfileType  = TIFF_ANDOR_iQ) then MovFType := ANDOR_MOV;

    If (RAM_Usage.LoadFilesInRAM) Then Begin
      if (High(StripOffs) = 0) Then
        AllocateMemoryInRAMforSingleImageFiles
      else
      MessageDlg('Image data are not contiguous. Will not be loaded in RAM',mtError,[mbOK],0);
      if (FileInRAM) then begin
        LoadMultipleFilesInRAM;
      end else
        MessageDlg('Cannot be loaded in RAM',mtError,[mbOK],0);
    End; //If (RAM_Usage.LoadFilesInRAM) Then Begin

    if not(FileInRAM) then RawDataInRAM := nil;

    NrChannels := 1;

  End  // end with STACK_BW_TIFF

    Else

  If (OpenDialogIndex = SINGLE_TIFF_INDEX) { Grayscale Tiff } then begin

            // -----------------------------------------//
    If Not(OpenAsFileCollection) Then Begin

      ImFname := FName;
      if (ImFileOpen) then begin
        CloseOpenImageFile;
        NilCollectionArrays;
      end; { IfimFileOpen = True }

      if (MultiImageTIFF) and (RAM_Usage.LoadFilesInRAM) then begin
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
        frmProgress.lbAction.Caption := 'Attempting to Allocate Memory in RAM';
        Application.ProcessMessages;
        SetLength(FileSizes,1);
        FileSizes[0] := GetBigFileSize(FName);
        FileInRAM := SetByteArray(RawDataInRAM,1,FileSizes);
      end;

      If (FileInRAM) then begin
        frmProgress.lbAction.Caption := 'Memory Allocated. Loading in RAM.';
        Application.ProcessMessages;
        LoadFileInRAM(0,FName);
        frmProgress.lbAction.Caption := 'Loaded in RAM.  Getting Info.';
        pRawData := @RawDataInRAM[0,0];
        if not(BigTiff) then GetTIFFfileInfoFromRAM(pRawData, NrPages, FName, 0, READ_AS_SINGLE,0,SilentMode)
          else
        if (BigTiff)    then GetBigTIFFfileInfoFromRAM(pRawData, NrPages, FName, 0, READ_AS_SINGLE,SilentMode);

      End
        else
      Begin
        if (frmProgress = nil) and (MultiImageTIFF) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
          RawDataInRAM := nil;
        if (MultiImageTIFF) and (RAM_Usage.LoadFilesInRAM) then
          frmProgress.lbAction.Caption := 'Cannot be Loaded in RAM.  Getting Info.'
          else
        if (MultiImageTIFF) and not(RAM_Usage.LoadFilesInRAM) then
          frmProgress.lbAction.Caption := 'Getting Info.';

          Application.ProcessMessages;
          if not(BigTiff) then GetTIFFfileInfo(NrPages, FName, 0, READ_AS_SINGLE,0,SilentMode)
            else
          if    (BigTiff) then GetBigTIFFfileInfo(NrPages, FName, 0, READ_AS_SINGLE,SilentMode);
      End;

      NrIm := NrPages;

      if (TIFFfileType = TIFF_ANDOR_iQ)  then MovFType := ANDOR_MOV
        else
      if (TIFFfileType = TIFF_NIKON)     then MovFType := NIKON_TIFF_MOV
        else
      if not (TIFFfileType in [TIFF_ANDOR_iQ,TIFF_NIKON]) then MovFType := SINGLE_BW_TIFF;

      if (NrIm > 1) then begin
        ImageBytes := ImagePix * (BitCount div 8); // in bytes
        TiffFileList := nil;
        if not(FileInRAM) then begin
          ImFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
          ImFileOpen := True;
        end;
        ImageFileType := MULTI_IMAGE;
        if (MovFType = ANDOR_MOV) and (DimTime = -1) then TimeSt := nil;
      end else
      if (NrIm = 1) then begin
        ImageFileType := SINGLE_IMAGE;
        SetLength(TiffFileList, 1);
        TiffFileList[0] := FName;
        CurIm := 0;
        SetLength(TimeSt, 1);
        TimeSt[0] := 0;
        ImOff := nil;
      end;

  End    //If Not(OpenAsFileCollection) Then begin

    Else
            // -----------------------------------------//
  If (OpenAsFileCollection) Then Begin
              { 1st. Closes all open files }
      If (ImFileOpen) then begin
        CloseOpenImageFile;

      end; // IfimFileOpen = True//
      TiffFileList := nil;
      ImFname := CollFileNames[0]; // First in ListFileName

      OpenAndorTIFFsAsCollection;

      Ftitle := ExtractFileName(CollFileNames[ High(CollFileNames)]);
         // Last in List Filename
      ImageBytes := ImagePix * (BitCount div 8);
      ImFileOpen := True;
      ImageFileType := FILE_COLLECTION;
      if (FileInRAM) then CloseOpenImageFile;
      MovFType := ANDOR_MOV;
    End; // If (OpenAsFileCollection)

    if (ToSwap) and (BitCount = 8) then ToSwap := False;
    if (LoadChAsIndivFiles) then IntelieveImageOffsetsAndTimeStamps(0);
    if (LoadChAsIndivFiles) and (NrChannels = 2) and (frmImageControl.ubFileColTable.Tag = 1) then
    frmImageControl.ubFileColTable.Tag := 2;

  End // If (OpenDialogIndex = SINGLE_TIFF_INDEX)

    Else

  If (OpenDialogIndex = COLLECTION_INDEX) { Collection File } then Begin
    OpenCollectionFile(FName);
    If (ImFileOpen) then begin
      CloseOpenImageFile;
    End; // IfimFileOpen = True//

    ImFname := FName;
    TiffFileList := nil;

     { Opens All the Files and Sets Files Handles arrays }
      // for each file//
    if not(LoadChAsIndivFiles) then SetLength(CollFileHandles, NrIm)
      else
    if    (LoadChAsIndivFiles) then SetLength(CollFileHandles, NrIm*2);
     // File Handle (Win32 & Win64) for Each Image;
    SetLength(CollFileHandlesList, Length(CollFileNames));
    for Cnt := 0 to High(CollFileHandlesList) do begin
      CollFileHandlesList[Cnt] := FileOpen(CollFileNames[Cnt],
      fmOpenRead or fmShareDenyNone);
    end;
              // for each image//
    if (RAM_Usage.LoadFilesInRAM) then begin
      if not(LoadChAsIndivFiles) then SetLength(CollFileNrInRAM, NrIm)
        else
      if    (LoadChAsIndivFiles) then SetLength(CollFileNrInRAM, NrIm*2);
    end
      else
    CollFileNrInRAM := nil;

    FileNr := 0; // Here is used as a Simple Counter
    ImNrMem := CollFileImNr[0] div NrChannels;
    for Cnt := 0 to High(CollFileHandles) do begin
      if (Cnt > ImNrMem - 1) then begin
        Inc(FileNr); // goes to the next file counter
        ImNrMem := ImNrMem + (CollFileImNr[FileNr] div NrChannels);
      end;
      CollFileHandles[Cnt] := CollFileHandlesList[FileNr];
      if (RAM_Usage.LoadFilesInRAM) then CollFileNrInRAM[Cnt] := FileNr;
    end;

    ToSwap := False;
    ImagePix := imXsize * imYsize;
    ImageBytes := ImagePix * (BitCount div 8); // in bytes
    ImFileOpen := True;
    ImageFileType := FILE_COLLECTION;
    MovFType := ANDOR_MOV;

    //Tries to Allocate memory in RAM
    If Not(RAM_Usage.LoadFilesInRAM) then RawDataInRAM := nil
      Else
    If (RAM_Usage.LoadFilesInRAM) then Begin
      if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.lbAction.Caption := 'Attempting to Allocate Memory in RAM';
        frmProgress.Show;
        Application.ProcessMessages;
      end;
      SetLength(FileSizes,Length(CollFileNames));
      for Cnt := 0 to High(CollFileNames) do begin
        FileSizes[Cnt] := GetBigFileSize(CollFileNames[Cnt]);
      end;

      FileInRAM := SetByteArray(RawDataInRAM,Length(CollFileNames),FileSizes);
      if not(FileInRAM) then CollFileNrInRAM := nil;

    If (FileInRAM) then begin
        ImNrMem := 0;
        if (frmProgress = nil) then begin
          Application.CreateForm(TfrmProgress, frmProgress);
          frmProgress.Show;
        end;
      for Cnt := 0 to High(CollFileNames) do begin
        frmProgress.lbAction.Caption := 'Memory Allocated. Loading File ' + IntToStr(Cnt+1) + ' ('+IntToStr(Length(CollFileNames))+ ')' + ' in RAM.';
        Application.ProcessMessages;
        LoadFileInRAM(Cnt,CollFileNames[Cnt]);
        frmProgress.lbAction.Caption := 'File ' + IntToStr(Cnt+1) + ' Loaded in RAM.  Getting Info.';
        Application.ProcessMessages;
      end; // For Cnt := 0 to High(CollFileNames)
         frmProgress.Close;
    End
      Else
    Begin
      RawDataInRAM := nil;
      frmProgress.lbAction.Caption := 'Cannot be Loaded in RAM.';
      frmProgress.lbReading.Caption := '';
      Application.ProcessMessages;
      Sleep(500);
      frmProgress.Close;
    End;
    End; //If (RAM_Usage.LoadFilesInRAM) then Begin

    if (FileInRAM) then CloseOpenImageFile;

    if (LoadChAsIndivFiles) then IntelieveImageOffsetsAndTimeStamps(1);

  End

    Else

  If (OpenDialogIndex = ZEISS_CZI_LSM_INDEX) then
  Begin

    ImFname := FName;
    If (ImFileOpen) then Begin
      CloseOpenImageFile;
      NilCollectionArrays;
    End; // IfimFileOpen = True//

    If (RAM_Usage.LoadFilesInRAM) then Begin
      if (frmProgress = nil) then begin
        Application.CreateForm(TfrmProgress, frmProgress);
        frmProgress.Show;
      end;
      frmProgress.lbAction.Caption := 'Attempting to Allocate Memory in RAM';
      Application.ProcessMessages;
      SetLength(FileSizes,1);
      FileSizes[0] := GetBigFileSize(FName);
      FileInRAM := SetByteArray(RawDataInRAM,1,FileSizes);
    End;

    If (FileInRAM) then begin
      frmProgress.lbAction.Caption := 'Memory Allocated. Loading in RAM.';
      Application.ProcessMessages;
      LoadFileInRAM(0,FName);
      frmProgress.lbAction.Caption := 'Loaded in RAM.  Getting Info.';
      pRawData := @RawDataInRAM[0,0];
      if (ExtractFileExt(FName) = '.lsm') then GetLSMfileInfoFromRAM(pRawData,SilentMode)
        else
      if (ExtractFileExt(FName) = '.czi') then GetCZIfileInfoFromRAM(pRawData,SilentMode);
    End
      else
    Begin
      Application.CreateForm(TfrmProgress, frmProgress);
      frmProgress.Show;

      RawDataInRAM := nil;
      if (RAM_Usage.LoadFilesInRAM) then
          frmProgress.lbAction.Caption := 'Cannot be Loaded in RAM.  Getting Info.'
        else
      if not(RAM_Usage.LoadFilesInRAM) then
        frmProgress.lbAction.Caption := 'Getting Info.';

        Application.ProcessMessages;

       if (ExtractFileExt(FName) = '.lsm') then GetLSMfileInfo(FName, SilentMode)
        else
       if (ExtractFileExt(FName) = '.czi') then GetCZIfileInfo(Fname,SilentMode);
    End;

    MovFType := ZEISS_CZI_LSM_MOV;
    ImageBytes := ImagePix * (BitCount div 8); // in bytes
    TiffFileList := nil;
    if not(FileInRAM) then begin
      ImFile := FileOpen(FName, fmOpenRead or fmShareDenyNone);
      ImFileOpen := True;
    end;

    ImageFileType := MULTI_IMAGE;

  End; //If (OpenDialogIndex = ZEISS_CZI_LSM_INDEX)

  { ----------- ---------------End All Movie Files -------------------------- }

  if (NrChannels = 1) then ChannelOrder := ASCENDING;
  
  if (RealLineScanOn) then begin
    frmRealLineScan.ubOn.Selected := False;
    frmRealLineScan.ubOn.Click;
  end;

  //shut off frmOrthogonalSectioning if it was on
  if (OrthogonalSectioningOn) then begin
    frmOrthogonalSectioning.ubOnOff.Selected := False;
    frmOrthogonalSectioning.ubOnOff.Click;
  end;

  //shut off frmXYprofile if it was on
  if (XYprofileRectVisible) then begin //EQ XYprofile is ON
    frmXYprofile.ubOnOff.Selected := False;
    frmXYprofile.ubOnOff.Click;
  end;

  with MainForm do begin
    if (FileInRAM) then begin
      lbFileLoadedInRAMsign.Font.Color := clRed;
      lbFileLoadedInRAMsign.Caption := 'File Loaded in RAM'
    end else
    begin
      lbFileLoadedInRAMsign.Font.Color := clBlue;
      lbFileLoadedInRAMsign.Caption := 'File Not Loaded in RAM';
    end;
  end;

  RAM_Usage.KindOfModMovie := NOT_MODIFIED;

  { resizes Window abd updates pixes size }

            if not(MovFType in[NORAN_SGI_MOV,QED_MOV]) then
              UpdatePixelSizeSettings; // NORAN_SGI_MOV and QED_MOV do Not Have Entry in PixSettings Record

            With frmTimeSerPlot Do begin
              FreezeMean.Down := False;
              PLOTvar.AllowFreezeMin := False;
              FreezeMeanClick(Sender);
               //Set enThreshForArea.Max to Bit Depth -1
              if (BitCount = 8) and (enThreshForArea.Max <> 254) then begin
                enThreshForArea.NumberOne := 0;
                enThreshForArea.Max := 254;
              end
                else
              if ((BitCount = 16) ) and (enThreshForArea.Max <> round(exp((shrFact + 8) * ln(2)))-2) then begin
                enThreshForArea.NumberOne := 0;
                enThreshForArea.Max := round(exp((shrFact + 8) * ln(2)))-2;
              end;
            End;//With frmTimeSerPlot Do begin

            JumpOrRunAvArr := nil; { TDynWordArray }
            JumpAv := 1;
            RunAv  := 1;
            CurrClrTablInd := 0;
            InitBitmapHeaderXY(imXsize, imYsize);
            If (NrIm > 1) Then begin
              CurrClrTablInd := 1;
              InitBitmapHeaderXY(imXsize, imYsize);
              CurrClrTablInd := 0;
            End;
            if (NrChannels > 1) then begin
              CurrClrTablInd := 2;
              InitBitmapHeaderXY(imXsize, imYsize);
              CurrClrTablInd := 0;
            end;

            If Not(OpenDialogIndex in [NORAN_PRARIE_INDEX, STACK_TIFF_INDEX])
              then
            Begin

              ImFtitle := Ftitle;

              if (OpenDialogIndex = QED_INDEX) then
              begin
                ImFtitle := AnsiLeftStr(ImFtitle,PosEx('_ImgMgr', ImFtitle, 1) - 1);
              end
              else if (OpenDialogIndex = StreamPix_INDEX) then
              begin
                ImFtitle := AnsiLeftStr(ImFtitle,PosEx('.seq', ImFtitle, 1) - 1);
              end
              else if (OpenDialogIndex = SINGLE_TIFF_INDEX) then
              begin
                ImFtitle := AnsiLeftStr(ImFtitle,PosEx('.tif', ImFtitle, 1) - 1);
              end
              else if (OpenDialogIndex = COLLECTION_INDEX) then
              begin
                ImFtitle := AnsiLeftStr(ImFtitle,PosEx('.col', ImFtitle, 1) - 1);
              end;
            End
            else If (OpenDialogIndex in [NORAN_PRARIE_INDEX, STACK_TIFF_INDEX])
              then
            Begin
              ImFtitle := ExtractFileDir(FName);
              ImFtitle := AnsiRightStr(ImFtitle,
                Length(ImFtitle) - LastDelimiter('\', ImFtitle));
            End;

  { ------------------ Sets Array Needed --------------------------------- }

            // for Reading and Displaying Images

            if (MovFType <> StreamPix_MOV) then
            begin
              SecMS := nil;
              MemSecMS := nil;
            end;

            if (imXsize Mod 4 = 0) then
              BMPPadding := 0
            else
              BMPPadding := 4 - (imXsize Mod 4);

            NrBytes := (imXsize + BMPPadding) * imYsize;

            if (BMPPadding <> 0) then BMPPadding := BMPPadding + 1;

            { ----------- BitCount 16 bit ------------------- }
            If (BitCount = 16) Then
            Begin
              Im8bitData := nil;
              if Length(Im16bitData) <> ImagePix then SetLength(Im16bitData, ImagePix);
              pImData := @Im16bitData[0];
            End
              Else { used to point to any of  Im8bitData or Im16bitData }
            If (BitCount = 8) Then Begin
              Im16bitData := nil; // used with 16 bit unly
              if Length(Im8bitData) <> ImagePix then SetLength(Im8bitData, ImagePix);
              pImData := @Im8bitData[0]; // pointer to read from file
            End;

            if Length(ImDispl) <> NrBytes then SetLength(ImDispl, NrBytes);
            pImDispl := @ImDispl[0];

            If (NrIm > 1) Then Begin
              if Length(AvIm8bit) <> NrBytes then
                SetLength(AvIm8bit, NrBytes);
            End
              Else
            If NrIm = 1 Then Begin
              AvIm8bit := nil;
            End;

            //--- For More Than One Channel ---//
            If (NrChannels > 1) Then Begin

               If (BitCount = 8) Then Begin
                Im2nd16bit := nil;
                if Length(Im2nd8bit) <> imXsize * imYsize then
                  SetLength(Im2nd8bit, imXsize * imYsize);
                  if not(MovFType = NIKON_ND2_MOV) then p2ndImData := @Im2nd8bit[0];
                  if (MovFType = NIKON_ND2_MOV) then begin
                    if (Length(TwoChByteArr) <> ImagePix*2) then SetLength(TwoChByteArr, ImagePix*2);
                    pImData := @TwoChByteArr[0]; // pointer to read from file
                  end;
               End
                Else
               If (BitCount = 16) Then Begin
                Im2nd8bit := nil;
                if Length(Im2nd16bit) <> imXsize * imYsize then
                  SetLength(Im2nd16bit, imXsize * imYsize);
                  if not(MovFType = NIKON_ND2_MOV) then p2ndImData := @Im2nd16bit[0];
                  if (MovFType = NIKON_ND2_MOV) then begin
                    if (Length(TwoChWordArr) <> ImagePix*2) then SetLength(TwoChWordArr, ImagePix*2);
                    pImData := @TwoChWordArr[0];
                  end;
               End;

               if Length(Im2ndDispl) <> NrBytes then begin
                  SetLength(Im2ndDispl, NrBytes);
                  p2ndImDispl := @Im2ndDispl[0];
               end;

               NrBytes := imXsize* imYsize*4;
               if (Length(MergeImDispl) <> NrBytes) then SetLength(MergeImDispl,NrBytes);

               pMergeBMPInfo.bmiHeader.biWidth  := imXsize;
               pMergeBMPInfo.bmiHeader.biHeight := -imYsize;

              If ((MovFType in [ANDOR_MOV,NIKON_TIFF_MOV]) or (TIFFfileType = TIFF_ImageJ)) And (NrChannels > 1) And
                 (OpenDialogIndex <> COLLECTION_INDEX)
              Then Begin
                 If Not(LoadChAsIndivFiles) then Begin
                  if (TIFFfileType <> TIFF_ImageJ) then begin
                    SetLength(TimeSt, NrPages);
                    SetLength(TimeStStore,Length(TimeSt));
                    Move(TimeSt[0],TimeStStore[0],Length(TimeStStore)*SizeOf(Double));
                  end;
                  SplitImageOffsets(0);
                  NrIm := NrIm div NrChannels;
                  if (TIFFfileType <> TIFF_ImageJ) then begin
                    SetLength(TimeSt,NrIm);
                    RefillTimStArray; //filles 1st Channel TimeSt
                  end;
                  if (TIFFfileType = TIFF_ANDOR_iQ) and (DimNotTime >-1)
                  then ReduceZstackArr; //Zstack
                End;
              End
                Else
              If Not(MovFType in [ANDOR_MOV,NIKON_TIFF_MOV]) or (NrChannels = 1) Then Begin
                TimeStStore := nil;
              End;
            End
              Else
            Begin
              Im2nd8bit         := nil;
              Im2nd16bit        := nil;
              Im2nd16bitSM_Last := nil;
              Im2ndDispl        := nil;
              MergeImDispl      := nil;
            End;

            IntBMP.SetSize(imXsize,imYsize);

            //--- End of For More Than One Channel ---//

            { ----------End of Setting Arrays -------------------------------------- }

            { ------------- Sets Sizes- of Main Window ----------------------------- }

            DisplayMainImage := False;
            SetFormSize(frmMainWin, frmMainWin.winMainImage);

            if (NrChannels > 1) then begin
              if (frm2ndWin <> nil) then SetFormSize(frm2ndWin,frm2ndWin.win2ndImage);
              if (frmMergeWin <> nil) then SetFormSize(frmMergeWin,frmMergeWin.MergeImage);
            end;

            if (frmImageControl.ubSetDiamMes.Selected) then
            begin
              frmImageControl.ubSetDiamMes.Selected := False;
              frmImageControl.ubSetDiamMesClick(Sender);
            end;

            if (frmImageControl.sbSetROItracking.Down) then begin
              //release Track button if depressed
              frmImageControl.sbSetROItracking.Down := False;
              frmImageControl.DoSetROItracking(False); //False = Do not update image
            end;

            if (LineScanExist) then frmLineScan.UpdateLSwindows(ERASE_SCREEN);
            LineScanExist := False;
            MesLine.OpCode := NOT_EXIST;

            // nills Mark Buffers
            MarkSmEvCoor := nil;
            MarkBigEvCoor := nil;

            MarkSmAmpl := nil;
            MarkBigAmpl := nil;

            MarkSmEvRise := nil;
            MarkBigEvRise := nil;

            MarkSmEvDur := nil;
            MarkBigEvDur := nil;

            MarkSmBase := nil;
            MarkBigBase := nil;

            If (NrIm > 1) then Begin

              With frmPlayback Do Begin

                ubRatioOn_PlayBack.Enabled := True;

                GoToInput.HideText := False;
                GoToInput.NumberOne := 1;
                GoToInput.MaxLength := Length(IntToStr(NrIm));
                GoToInput.Min := 1;
                GoToInput.Max := NrIm;
                GoToInput.Tag := 1;

                LoopFrom.HideText := False;
                LoopFrom.NumberOne := 1;
                LoopFrom.MaxLength := Length(IntToStr(NrIm));
                LoopFrom.Min := 1;
                LoopFrom.Max := NrIm - 4;
                LoopFrom.Tag := 1; // stores Value for Position in Normal Playback Mode

                LoopTo.Enabled := True;
                LoopTo.HideText := False;
                LoopTo.MaxLength := Length(IntToStr(NrIm));
                LoopTo.Min := 4;
                LoopTo.Max := NrIm;
                LoopTo.Tag := NrIm;
                LoopTo.NumberOne := NrIm;

                if NrIm > 4 then
                begin
                  GoToInput.Enabled := True;
                  GoToImage.Enabled := True;
                  LoopFrom.Enabled := True;
                  LoopTo.Enabled := True;
                  LockImagesToLoop.Enabled := True;
                end
                else if NrIm <= 4 then
                begin
                  GoToInput.Enabled := False;
                  GoToImage.Enabled := False;
                  LoopFrom.Enabled := False;
                  LoopTo.Enabled := False;
                  LockImagesToLoop.Enabled := False;
                end;

                PlaybackToolBar.Enabled := True;
                OnChangeMem := PlaybackScrollBar.OnChange;
                PlaybackScrollBar.OnChange := nil;
                PlaybackScrollBar.Position := 0;
                PlaybackScrollBar.Min := 0;
                PlaybackScrollBar.Max := NrIm - 1;

                GoToBeg.Enabled := True;
                BackWards.Enabled := True;
                stop.Enabled := True;
                ForWards.Enabled := True;
                GoToEnd.Enabled := True;
                DoLoop.Enabled := True;
                SelectOne.Enabled := True;
                DeselectOne.Enabled := True;
                Select10.Enabled := True;
                Deselect10.Enabled := True;
                DeselectAll.Enabled := True;
                cmbPlayMode.ItemIndex := 0;
                cmbPlayMode.Enabled := True;
                cmbPlayModeChange(Sender); // has to be forced
              End; // With frmPlayback

              if Not((MovFType = ANDOR_MOV) and (DimTime = -1)) then
                with frmTimeSerPlot do begin

                  enTraceMinPoints.MaxLength := Length(IntToStr(NrIm));
                  enTraceMinPoints.Max := NrIm - 2;
                  enRangeFromTo.MaxLength := Length(IntToStr(NrIm)) * 2 + 1;

                  StartAnal.Enabled := True;
                  enRangeFromTo.Enabled := sbSetRange.Down;
                  btGetPeeks.Enabled := False;
                  { Get Peaks should work with Original Ful TimeSt array }
                  enAnalFromTo.HideText := False;
                  if NrIm - 1 > dsAnalRange.Delta then
                  begin
                    dsAnalRange.Enabled := True;
                    enAnalFromTo.Enabled := True;
                    enAnalFromTo.MaxLength := Length(IntToStr(NrIm)) * 2 + 1;
                    dsAnalRange.SetSlider(0, NrIm - 1, 0, NrIm - 1);
                    enAnalFromTo.Min := 1;
                    enAnalFromTo.Max := NrIm;
                    dsAnalRangeChange(Sender);
                  end
                  else if NrIm - 1 <= dsAnalRange.Delta then
                  begin
                    dsAnalRange.SetSliderPos(dsAnalRange.Min, dsAnalRange.Max);
                    dsAnalRange.Enabled := False;
                    enAnalFromTo.Enabled := False;
                    enAnalFromTo.SetNumbersOneTwo(1, NrIm);
                    if FreezeMean.Down = False then
                      enRangeFromTo.SetNumbersOneTwo(1, NrIm);
                  end;
                  enBaseLinePoints.Max := NrIm div 6;
                  if enBaseLinePoints.NumberOne > enBaseLinePoints.Max then
                    enBaseLinePoints.NumberOne := round(enBaseLinePoints.Max);
                  enBaseLinePoints.Enabled := True;
                end; // with frmTimeSerPlot

              if (frmSPautoSearch <> nil) and Not
                ((MovFType = ANDOR_MOV) and (DimTime = -1)) then
                with frmSPautoSearch Do Begin
                  dsSerchFromTo.Enabled := True;
                  dsSerchFromTo.SetSlider(0, NrIm - 1, 0, NrIm - 1);
                  EdnSearchFromTo.MaxLength := Length(IntToStr(NrIm)) * 2 + 1;
                  EdnSearchFromTo.Enabled := True;
                  EdnSearchFromTo.HideText := False;
                  EdnSearchFromTo.Min := 1;
                  EdnSearchFromTo.Max := NrIm;
                  EdnSearchFromTo.SetNumbersOneTwo(1, NrIm);
                  StartSearch.Enabled := True;
                end
                else // end with if Not((MovFType = ANDOR_MOV) and (DimTime = -1))

                  if (MovFType = ANDOR_MOV) and (DimTime = -1) then begin
                  with frmTimeSerPlot do begin
                    dsAnalRange.SetSliderPos(dsAnalRange.Min, dsAnalRange.Max);
                    dsAnalRange.Enabled := False;
                    enAnalFromTo.Enabled := False;
                    enAnalFromTo.HideText := True;
                    StartAnal.Enabled := False;
                    sbSetRange.Down := False;
                    enRangeFromTo.Enabled := False;
                  end;
                  if frmSPautoSearch <> nil then
                    with frmSPautoSearch Do
                    Begin
                      dsSerchFromTo.Enabled := False;
                      EdnSearchFromTo.Enabled := False;
                      EdnSearchFromTo.HideText := True;
                    end;
                end; // if (MovFType = ANDOR_MOV) and (DimTime = -1)

              if Not(MovFType in [NORAN_PRARIE_MOV, QED_MOV, StreamPix_MOV])
                and (OpenDialogIndex <> COLLECTION_INDEX) then
              begin
                // NORAN_PRARIE_MOV, QED_MOV, StreamPix_Mov write those in their GetInfo procedures
                if Not((MovFType = ANDOR_MOV) and (DimTime = -1)) then begin
                  MeanImTime := TimeSt[High(TimeSt)] / (NrIm - 1);
                  // used for Table , Export MPEG etc
                  ExportDial.OrigFrameRate := (NrIm - 1) / TimeSt[High(TimeSt)];
                  MovieCycleList := nil;
                end;
              end;

              if Not(MovFType in [QED_MOV, StreamPix_MOV, NORAN_PRARIE_MOV])
                then MovieFrRateList := nil; // not used by other types

              { these arrays are always in use for all types of image files }
              SetLength(AvIm, ImagePix);
              SetLength(AvImRaw, ImagePix);
              SetLength(AvImList, NrIm);
              SetLength(ImDataRat, ImagePix);
              SetLength(ImDataRatForSmooth, ImagePix);

              SetLength(Im16bitDataSM_First, ImagePix);
              SetLength(Im16bitDataSM_Last, ImagePix);
              if (NrChannels > 1) then SetLength(Im2nd16bitSM_Last,ImagePix);

              for Cnt := 0 to NrIm - 1 do AvImList[Cnt] := 0;
              ImSel := 0;
              AvImExists := 0;
              If frmAverIm <> nil then SetFormSize(frmAverIm, frmAverIm.winAverImage);

              // Sets Mark Buffers//

              SetLength(MarkSmEvCoor, NrIm);
              SetLength(MarkBigEvCoor, NrIm);

              SetLength(MarkSmAmpl, NrIm);
              SetLength(MarkBigAmpl, NrIm);

              SetLength(MarkSmBase, NrIm);
              SetLength(MarkBigBase, NrIm);

              SetLength(MarkSmEvRise, NrIm);
              SetLength(MarkBigEvRise, NrIm);

              SetLength(MarkSmEvDur, NrIm);
              SetLength(MarkBigEvDur, NrIm);

            End

              Else

            If (NrIm = 1) then Begin

              with frmPlayback do begin
                ubRatioOn_PlayBack.Enabled := False;

                GoToInput.Text := '';
                LoopFrom.Text := '';
                LoopTo.Text := '';
                LoopFrom.Enabled := False;
                LoopTo.Enabled := False;
                GoToInput.Enabled := False;
                GoToImage.Enabled := False;
                LockImagesToLoop.Down := False;
                LockImagesToLoop.Enabled := False;
                OnChangeMem := PlaybackScrollBar.OnChange;
                PlaybackScrollBar.OnChange := nil;
                PlaybackScrollBar.Position := 0;
                PlaybackScrollBar.Min := 0;
                PlaybackScrollBar.Max := 0;
                PlaybackScrollBar.Enabled := False;
                PlaybackToolBar.Enabled := False;
                GoToBeg.Enabled := False;
                BackWards.Enabled := False;
                stop.Enabled := False;
                ForWards.Enabled := False;
                GoToEnd.Enabled := False;
                DoLoop.Enabled := False;
                SelectOne.Enabled := False;
                DeselectOne.Enabled := False;
                Select10.Enabled := False;
                Deselect10.Enabled := False;
                DeselectAll.Enabled := False;
                cmbPlayMode.ItemIndex := 0;
                cmbPlayMode.Enabled := False;
              end; { with }

              with frmTimeSerPlot do begin

                dsAnalRange.SetSliderPos(dsAnalRange.Min, dsAnalRange.Max);
                dsAnalRange.Enabled := False;
                enAnalFromTo.Enabled := False;
                enAnalFromTo.HideText := True;
                StartAnal.Enabled := False;
                sbSetRange.Down := False;
                enRangeFromTo.Enabled := False;
                enBaseLinePoints.Enabled := False;
              end;

              if frmSPautoSearch <> nil then with frmSPautoSearch Do Begin
                  EdnSearchFromTo.HideText := True;
                  dsSerchFromTo.Enabled := False;
                  EdnSearchFromTo.Enabled := False;
              end;

              if (frmAverIm <> nil) then
              begin
                frmAverIm.Release;
                frmAverIm := nil;
              end;

              AvImList  := nil;
              AvIm      := nil;
              AvImRaw   := nil;
              AvIm8bit  := nil;
              ImDataRat := nil;

              SetLength(Im16bitDataSM_First, ImagePix);
              SetLength(Im16bitDataSM_Last, ImagePix);
              if (NrChannels > 1) then SetLength(Im2nd16bitSM_Last,ImagePix);

            End; // If NrIm = 1

            { -------- Sets Sliders & Labels --------- }
            frmPlayback.lblSelIm.Caption := '';
            if (NrChannels = 2) then frmPlayback.pnFakeBar.Caption := 'Playback Control (Ch. Order = Ascending, Ch1 on Main Window)'
            else                     frmPlayback.pnFakeBar.Caption := 'Playback Control';

            if ROIvar.MesBoxXsize > imXsize - 2 then
              ROIvar.MesBoxXsize := imXsize - 2;
            if ROIvar.MesBoxYsize > imYsize - 2 then
              ROIvar.MesBoxYsize := imYsize - 2;

            CheckIfSelFrameFits;

            if ROIvar.BoxXsize > imXsize - 2 then
              ROIvar.BoxXsize := imXsize - 2;
            if ROIvar.BoxYsize > imYsize - 2 then
              ROIvar.BoxYsize := imYsize - 2;
            if ROIvar.CirXsize > imXsize - 2 then
              ROIvar.CirXsize := imXsize - 2;
            if ROIvar.CirYsize > imYsize - 2 then
              ROIvar.CirYsize := imYsize - 2;

            SetBkgAndCutOffSliders;

            frmMainWin.Caption := 'Main Window:  ' + ImFtitle;

            With frmImageControl Do Begin
              ubRatioOn.Enabled    := True;
              if (NrChannels > 1) then begin
                unChDivCh.Enabled := True;
                unChDivCh.Caption    := 'Ch1/Ch2';
                unChDivCh.CaptionHot := 'Ch1/Ch2';
                unChDivCh.CaptionSel := 'Ch1/Ch2';
                if (frm2ndWin <> nil) then frm2ndWin.Caption := 'Secondary Window: Channel Two';
              end
                else
              begin
                unChDivCh.Enabled := False;
                frmPlayback.pnFakeBar.Caption := 'Playback Control';
              end;

              ubApplyFrame.Enabled := True;
              ubSizeBar.Enabled    := True;
              ubGrid.Enabled       := True;
              ToolsToolBar.Enabled := True;
              MeasureBox.Down := False;
              scrBoxXsize.Enabled := True; { in order to change maximum }
              scrBoxYsize.Enabled := True; { and to be able to disable }
              scrBoxXsize.Max := imXsize - 2;
              scrBoxYsize.Max := imYsize - 2;
              scrBoxXsize.Enabled := False;
              scrBoxYsize.Enabled := False;
              Select.Down := True;
              Select.Click;
              lblBoxXsize.Caption := '';
              lblXmicrons.Caption := '';
              lblBoxYsize.Caption := '';
              lblYmicrons.Caption := '';
              // new Scale Double Slider
              DoSetRange := False;
              enPixRange.HideText := False;

              if (BitCount = 16) then begin
                SetRange.Enabled := True;
                DSPixRange.Enabled := True;
                enPixRange.Enabled := True;
                if (AutoSetRange.Down) or
                  (DSPixRange.Max <> round(exp((shrFact + 8) * ln(2)))-1) then
                begin
                  DoSetRange := True;
                  DSPixRange.SetSlider(0,
                    round(exp((shrFact + 8) * ln(2))) - 1, // = 2^bit-dept
                   0, round(exp((shrFact + 8) * ln(2))) - 1);
                  DSPixRange.Delta := 255;
                  enPixRange.Min := 0;
                  enPixRange.Max := round(exp((shrFact + 8) * ln(2))) - 1;
                end;

              end
                else
              if (BitCount = 8) then begin
                { DoSetRange remains False }
                SetRange.Enabled := False;
                DSPixRange.Enabled := False;
                enPixRange.Enabled := False;
                DSPixRange.Delta := 1;
                DSPixRange.SetSlider(0, 255, 0, 255);
              end;

            End; // With frmImageControl Do Begin

            { ----------------------------------------- }

            If (PrevFilePar.Xsize <> imXsize) or
              (PrevFilePar.Ysize <> imYsize) or
              (ROIvar.KeepOldROI = False) Then
            Begin

              ROIvar.NrROI := 0;
              For Cnt := 1 to 20 Do
              Begin
                FhPol[Cnt] := nil;
                FhTbl[Cnt] := nil;
                ROIvar.ROIAdr[Cnt] := 0;
              End;
              If frmImageControl.btZeroOutsideROI_All_Images.Down then
              begin
                frmImageControl.btZeroOutsideROI_All_Images.Down := False;
                frmImageControl.btZeroOutsideROI_All_Images.Click;
              End;
            End; { If (ROIvar.KeepOldROI = False) }

            PrevFilePar.Xsize := imXsize;
            PrevFilePar.Ysize := imYsize;

            { ------------------------------------------------------------------- }

            // Zeroes Spatial Spread table and related buffers
            if (frmSpatialSpread <> nil) then
              frmSpatialSpread.ClearTableClick(Sender)
            else
            begin
              SpreadImNr := nil;
              SpreadCoor := nil;
              SpreadAmpl := nil;
              SpreadSurface := nil;
            end;

            if BitCount > 8 then
              SetLength(OneBinImHist, round(exp((shrFact + 8) * ln(2))))
            else if BitCount = 8 then
              SetLength(OneBinImHist, 256);

            {----------- sets Size Bar parameters ------------------}
            if (SizeBar.YB > imYsize - 2) then begin // if the Bar is below the bottom of image
              SizeBar.YB := imYsize - 2; //1 pixel above bottom
              SizeBar.YT := SizeBar.YB - LSTimeBarPar.Thickness;
            end;
            if (SizeBar.XR > imXsize - 2) then begin // if the Bar is beyond the right of image
              SizeBar.XR := imXsize - 2; //1 pixel left from right side
              SizeBar.XL := SizeBar.XR - round(ExportDial.SizeBarLenghtINµm/PixSize);
            end;
            { ------------- finally Display Image -------------------------- }

            frmPlayback.PlaybackScrollBar.OnChange := OnChangeMem;
            // restores the pointer to OnChange procedure
            MainImLoaded := True;

            If (NrChannels = 1) then Begin
              if (frm2ndWin <> nil) then
              with frm2ndWin.win2ndImage do begin
                Canvas.Brush.Color := clBlack;
                Canvas.FillRect(Canvas.ClipRect);
                Canvas.Brush.Style := bsClear;
                frm2ndWin.Caption := '';
              end;
              if (frmMergeWin <> nil) then
              with frmMergeWin.MergeImage do begin
                Canvas.Brush.Color := clBlack;
                Canvas.FillRect(Canvas.ClipRect);
                Canvas.Brush.Style := bsClear;
                frm2ndWin.Caption := '';
              end;
            End;

            with frmImageControl do begin
               // paint FileColTable here;
              if (ubFileColTable.Tag in[1,2]) then  begin
                Ch1_Color := RGB(FileColorTBL_Ch1[255], FileColorTBL_Ch1[511], FileColorTBL_Ch1[767]);
                //Ch1_Color := RGB(r, g, b) ;
                if (NrChannels = 2)  then
                  Ch2_Color := RGB(FileColorTBL_Ch2[255], FileColorTBL_Ch2[511], FileColorTBL_Ch2[767]);
              end; // if (ubFileColTable.Tag = 1) then  begin

              LoadBMPinUniButton(Ch1_Color,Ch2_Color,ubFileColTable);

              if (NrChannels = 1) then ub2ndChannel.Enabled := False
              else                     ub2ndChannel.Enabled := True;

              if (ub2ndChannel.Selected) and (ChannelOrder = ASCENDING) then begin
                ub2ndChannel.Selected := False;
                ub1stChannel.Selected := True;
              end;

              if (NrChannels = 2) and (ChannelOrder = DESCENDING) then begin
                if (ub1stChannel.Selected) and not(FileOwnColorTableWasDown) then ub1stChannelSelect(Sender);
                if (ub2ndChannel.Selected) then begin
                  ub2ndChannel.Selected := False;
                  if not(FileOwnColorTableWasDown) then ub1stChannel.Selected := True
                    else
                  if (FileOwnColorTableWasDown) then begin
                  //avoid triggering event since it is done later by FileColTableClick(sender);
                    OnChangeMem := ub1stChannel.OnSelect;
                    ub1stChannel.OnSelect := nil;
                    ub1stChannel.Selected := True;
                    ub1stChannel.OnSelect := OnChangeMem;
                  end;
                end;
                ChannelOrder := ASCENDING;
              end; //if (NrChannels = 2) and (ChannelOrder = DESCENDING) then begin

              if (FileOwnColorTableWasDown) then begin
                ubFileColTable.Selected := True;
                ubFileColTableClick(Sender);
              end;
            end;

            If (DoSetRange) then Begin   //in case with 16 bit files
              CurIm := 0;
              ReadImage(CurIm,0,pImData);
              if (NrChannels > 1) and Not(MovFType = NIKON_ND2_MOV) then ReadImage(CurIm,1,p2ndImData);

              Sender := nil;
              frmImageControl.SetRangeClick(Sender);

              If (NrIm > 1) then Begin
                If (MovieSeriesType = TimeSeries) then
                    frmPlayback.lbImageNr.Caption := 'im 1 / ' + '0.000' + ' s'
                  Else
                If (MovieSeriesType = Z_Stack) then Begin
                  if (MovFType in[ANDOR_MOV,BIORAD_PIC,NIKON_ND2_MOV,NIKON_TIFF_MOV]) then begin
                      frmPlayback.lbImageNr.Caption := 'im 1 / ' +
                      (FloatToStrF(ZstackArr[CurIm],ffFixed,8,2) + ZstackUnits) + ' / ' + '0.000' + ' s';
                  end
                    else
                  if (MovFType = ZEISS_CZI_LSM_MOV) then begin
                      frmPlayback.lbImageNr.Caption := 'im 1 / ' + '0.00' + ' µm';
                  end;
                end; //else begin
              End Else // If NrIm > 1 then Begin
              frmPlayback.lbImageNr.Caption := '';

            End // If (DoSetRange) then

              Else

            Begin
              if (NrChannels > 1) and (PixRange[1].DSPixRange_PosTo = 0) then begin
                PixRange[1].DSPixRange_PosFrom := PixRange[0].DSPixRange_PosFrom;
                PixRange[1].DSPixRange_PosTo   := PixRange[0].DSPixRange_PosTo;
              end;

              frmPlayback.PlaybackScrollBar.OnChange(Sender);
              CreateOneBinImHist;
              with frmImageControl do begin
                CreateImageHistogram;
                PaintHistWindow;
                enPixRange.SetNumbersOneTwo(DSPixRange.PosFrom, DSPixRange.PosTo);
              end;
            End;

            Application.ProcessMessages;

            If (frmMovieLabels <> nil) and
              ((frmMovieLabels.cbCounterType1.ItemIndex = 1) or
               (frmMovieLabels.cbCounterType2.ItemIndex = 1))
            then Begin
              if not(MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) Or
                   ((MovFType in[ANDOR_MOV,BIORAD_PIC,ZEISS_CZI_LSM_MOV]) and
                    (MovieSeriesType = TimeSeries)) then begin
                if (frmMovieLabels.cbCounterType1.ItemIndex = 1) then begin
                   frmMovieLabels.cbCounterType1.ItemIndex := 0;
                   frmMovieLabels.cbCounterType1Change(Sender);
                end;
                if (frmMovieLabels.cbCounterType2.ItemIndex = 1) then begin
                   frmMovieLabels.cbCounterType2.ItemIndex := 0;
                   frmMovieLabels.cbCounterType2Change(Sender);
                end;
              end;
            End;

            with frmMainWin do
            begin
              for Cnt := 0 to ComponentCount - 1 do
              begin
                if (Components[Cnt] is TSuperSubLabel) then
                  with (Components[Cnt] as TSuperSubLabel) do
                  begin
                    if (Left + Width) > imXsize then
                    begin
                      if (imXsize - Width - 1) >= 0 then
                        Left := imXsize - Width - 1
                      else
                        Left := 0;
                    end;
                    if (Top + Height) > imYsize then
                    begin
                      if (imYsize - Height - 1) >= 0 then
                        Top := imYsize - Height - 1
                      else
                        Top := 0;
                    end;
                  end;
              end;
            end;

            { end of repositioning comments }

            if (frmCorrectForBleaching <> nil) then begin
              frmCorrectForBleaching.SetImageRange;
              frmCorrectForBleaching.SetLabels;
            end;

            if (frmKalmanStackFilter <> nil) then begin
              frmKalmanStackFilter.SetImageRange;
              frmKalmanStackFilter.SetLabels;
            end;

            if (frmEventSites <> nil) then
              frmEventSites.SetImageRange;

            if (frmIntegrate <> nil) then frmIntegrate.sbResetTraceTimeClick(Sender);



          frmPlayback.edROI_Xpos.MaxLength := Length(IntToStr(imXsize));
          frmPlayback.edROI_Ypos.MaxLength := Length(IntToStr(imYsize));

          Screen.Cursor := crDefault;


End; { Procedure OpenImageFile }

{*****************************************************************************}

Procedure RefillTimStArray;
var i,Cnt : Integer;
Begin

  i := ChannelOrder;
  Cnt := 0;

  while i <= High(TimeStStore) do begin
    TimeSt[Cnt] := TimeStStore[i];
    Inc(i,NrChannels);
    Inc(Cnt,1);
  end;
End; //Procedure RefillTimStArray

{**********************************************************************}

Procedure SwapImageOffsets;
  var i,Cnt,CntCh : Integer;
      ImageOffsets : TDynUInt64Array;
      fH : THandle;
Begin

  If not(MovFType = BIORAD_PIC) then Begin

    SetLength(ImageOffsets,Length(ImOff[0]));
    Move(ImOff[1,0],ImageOffsets[0],Length(ImageOffsets)*SizeOf(Int64));

    Move(ImOff[0,0],ImOff[1,0],Length(ImOff[0])*SizeOf(Int64));
    Move(ImageOffsets[0],ImOff[0,0],Length(ImageOffsets)*SizeOf(Int64));

  End
    else
  If (MovFType = BIORAD_PIC) then Begin
    CollFileHandles[0] := CollFileHandles[1];
    CollFileHandles[1] := ImFile;
    ImFile := CollFileHandles[0];
  End;

End; //Procedure SwapImageOffsets;

{**********************************************************************}

Procedure OpenAvImFile(const AvFileName: AnsiString; const SilentMode: Boolean);

Var
          Cnt         : Integer;
          FPos        : Longint;
          BinAvImFile : File;
          ReadStr     : AnsiString;
          ReadW       : Word;
          ReadWW      : Word;
          CntBytes    : Integer;
          pReadPtr    : Pointer;
          TempAverImage : TDynSingleArray;
          OldFormat   : Boolean;

Begin

          AssignFile(BinAvImFile, AvFileName);
          FileMode := fmOpenRead;
          Reset(BinAvImFile, 1);

          { 1st: Check if this is a AvIm File }
          SetLength(ReadStr, 11);
          pReadPtr := @ReadStr[1]; { Sets Pointer at Fist character in String }
          FPos := 0; { Fixed }
          Seek(BinAvImFile, FPos);
          BlockRead(BinAvImFile, pReadPtr^, 11); { Don't miss " ^ " }
          If (ReadStr <> 'SparkAnAver') and (ReadStr <> 'SparkAnAveD') then Begin
            if (SilentMode = False) then
              MessageDlg('This is Not SparkAn Average File', mtError, [mbOK],0);
          End
            Else
          If (ReadStr = 'SparkAnAver') or (ReadStr = 'SparkAnAveD') then Begin
            if (ReadStr = 'SparkAnAveD') then begin
              CntBytes := 8; //after March 6, 2016 Aver Image become Double
              OldFormat := False;
            end
              else
            if (ReadStr = 'SparkAnAver') then begin
              CntBytes := 4; // Average Image use to be Single
              OldFormat := True;
            end;

            { ------- This is Average Image Type of File }
            { 2nd: Check for X & Y dimentions }
            FPos := 11; { fixed }    { X dimention }
            Seek(BinAvImFile, FPos);
            BlockRead(BinAvImFile, ReadW, 2);
            FPos := 13; { fixed }     { Y dimention }
            Seek(BinAvImFile, FPos);
            BlockRead(BinAvImFile, ReadWW, 2);
            If (ReadW <> imXsize) or (ReadWW <> imYsize) Then Begin
              if (SilentMode = False) then
                MessageDlg('Will Not Open File: X or/and Y Dimentions Differ from Current File'
                    , mtWarning, [mbOK], 0);
            End
              Else
            If (ReadW = imXsize) and (ReadWW = imYsize) Then Begin
              { pos 15 Read as Word is the BitCount Info, So far there is no need to Read it }

              { 3nd: Read Image Data }
              if not(OldFormat) then
                pReadPtr := @AvImRaw[0] { Sets Pointer }
                  else
              if (OldFormat) then begin
                SetLength(TempAverImage,imXsize*imYsize);
                pReadPtr := @TempAverImage[0];
              end;

              FPos := 17; { Fixed }
              Seek(BinAvImFile, FPos);
              BlockRead(BinAvImFile, pReadPtr^, ImagePix * CntBytes);
              if (OldFormat) then begin
                for Cnt := 0 to High(TempAverImage) do
                  AvImRaw[Cnt] := TempAverImage[Cnt];
              end;

              { 4th: Reads Info Section }
              FPos := 17 + ImagePix * CntBytes; { Fixed - depends on ImagePix }
              SetLength(ReadStr, FileSize(BinAvImFile) - FPos);
              pReadPtr := @ReadStr[1];
              { Sets Pointer at Fist character in String }
              BlockRead(BinAvImFile, pReadPtr^, Length(ReadStr));
              AvImInfoStr := ReadStr;

              { ------ End with Reading }
              AvImExists := 2; { from File }
              AvImChOrig := 1;  //added March 3, 2017 means originates from Channel 1;
              //When from file it is always set to 1 to avoid problems if file is 2 channle or 2 channels in individual files
              CopyAvImToDisplBuffer;
              if frmAverIm = nil then
                Application.CreateForm(TfrmAverIm, frmAverIm)
              else If frmAverIm <> nil then Begin
                frmAverIm.Caption := 'Average from File:  ' + ExtractFileName(AvFileName);
                UpdateAverImage(True);
              End; { if  frmAverIm <> nil }
              for Cnt := 0 to NrIm - 1 do
                AvImList[Cnt] := 0;
              ImSel := 0;
              frmPlayback.SelectOne.Enabled := False;
              frmPlayback.DeselectOne.Enabled := False;
              frmPlayback.Select10.Enabled := False;
              frmPlayback.Deselect10.Enabled := False;
              frmPlayback.lblSelIm.Caption := 'F';
              { ------------------------------------ }
              If (RatioOn = True) then
              Begin
                Application.ProcessMessages; { to refresh }
                Screen.Cursor := crHourGlass;
                if (SmoothMode > NO_SMOOTH) then
                Begin
                  SmoothAverIm(AvImRaw, AvIm);
                end; { SmoothMode > 0 }
                DoBkgonAvIm; { Subtracts Bkg from AvIm Only }
                DoRatio(DO_COPY);
                UpdateMainImage(True);
                Screen.Cursor := crDefault;
              End; { (RatioOn = True) }
              { --------------------------------------- }
            End { If (ReadW = imXsize) and (ReadWW = imYsize) }
          End; { Else If ReadStr = 'SparkAnAver' }
          { -------------------- }
          CloseFile(BinAvImFile);

End; // Procedure OpenAverImFile(AvFileName : AnsiString, SilentMode : Boolean);

{ ***************************************************************************** }

Procedure SaveAverImageAsSpnOwnFile(Const AvImFileName: AnsiString);

Var
          FPos      : LongInt;  //needed for Pascal  Own writing routines
          WriteStr  : AnsiString;
          pWriteStr : Pointer; { Have To Use it for Writing }
          pAvImArr  : Pointer;
          BinFile   : File; //= binary file
          WrWord    : Word;
          i, Cnt    : Integer;
Begin
          AssignFile(BinFile, AvImFileName);
          ReWrite(BinFile, 1); { 1 byte blocks }

          { 1st: write the Type of the File }
          WriteStr := 'SparkAnAveD';
          FPos := 0; { Fixed }
          Seek(BinFile, FPos);
          pWriteStr := @WriteStr[1];
          { Sets Pointer at Fist character in String }
          BlockWrite(BinFile, pWriteStr^, Length(WriteStr));
          { Don't miss " ^ " }

          { 2nd: With of Image: Word = 2 Bytes }
          WrWord := imXsize;
          FPos := 11; { Fixed }
          Seek(BinFile, FPos);
          BlockWrite(BinFile, WrWord, 2);

          { 3rd: write Height of Image }
          WrWord := imYsize;
          FPos := 13; { Fixed }
          Seek(BinFile, FPos);
          BlockWrite(BinFile, WrWord, 2);
          { 4th: BitCount (not nedeed for opening but lets have it }
          FPos := 15; { Fixed }
          Seek(BinFile, FPos);
          BlockWrite(BinFile, BitCount, 2);

          { 5th: write Data (Image) Portion }
          FPos := 17; { Fixed }
          Seek(BinFile, FPos);
          pAvImArr := AvImRaw; { Sets Pointer }
          BlockWrite(BinFile, pAvImArr^, ImagePix * 8); //8 bytes for Double Floating Point

          { 6th: Write Info Section } { last one }
          FPos := 17 + ImagePix * 8; { Fixed - depends on ImagePix }
          Seek(BinFile, FPos);
          WriteStr := 'Originates from "' + ImFtitle + '"'; { File Name }

          If (AvImExists = 1) then
          Begin // On Line average
            WriteStr := WriteStr + ';  Images Selected = ';
            i := 0;
            Cnt := 0;
            While (Cnt < NrIm) and (i <= ImSel) Do Begin
              if AvImList[Cnt] = 1 then begin
                if (i = ImSel - 1) then
                  WriteStr := WriteStr + IntToStr(Cnt + 1)
                else
                  WriteStr := WriteStr + IntToStr(Cnt + 1) + ', ';
                Inc(i);
              end;
              Inc(Cnt);
            End; { While }
          End
          Else { If (AvImExists = 1) }
          If (AvImExists = 2) then
          Begin
            WriteStr := AvImInfoStr;
          End
          Else If (AvImExists = 3) then
          Begin // Generated Average
            WriteStr := WriteStr + AvImInfoStr;
            { in this Case holds Info on AvIm generated from Min }
          End;
          { Actual Writing of Comment }
          pWriteStr := @WriteStr[1];
          BlockWrite(BinFile, pWriteStr^, Length(WriteStr));

          CloseFile(BinFile);
          { ----- Automatically Updates Status and Info as from File -------------------- }
          if AvImExists = 1 then begin
            for i := 0 to NrIm - 1 do
              AvImList[i] := 0;
            ImSel := 0;
          end;
          AvImExists := 2; { means from File }
          frmPlayback.lblSelIm.Caption := 'F';
          AvImInfoStr := WriteStr;
          { Updates Title of AvIm ----------- }
          if frmAverIm <> nil then
            frmAverIm.Caption := 'Average from File:  ' + ExtractFileName(AvImFileName);
          AvImFPath := AvImFileName;

End; //Procedure SaveAverImageAsSpnOwnFile(Const AvImFileName : AnsiString);

{******************************************************************************}

Procedure WriteImageFromFileLoadedInRAM(Const FileCount : Integer; Const FNameToWrite : AnsiString);
//for Single MultiImage Tiff File

var  Fh : THandle; { WIN32&64API handle }
     pB : pByte;
     FPos,ChunkSize,FSize,Rem : Int64;
     Cnt   : LongInt;
     NrOfChuncks : Integer;
Begin

 NrOfChuncks  := 8;

  FSize := Length(RawDataInRAM[FileCount]);
  ChunkSize := FSize div NrOfChuncks;
  //-------- Progress barr ----------//

  frmProgress.ImageProgressBar.Max := NrOfChuncks;
  Rem := FSize mod NrOfChuncks;

  Fh  := FileCreate(string(FNameToWrite)); // this also OverWrites an Existing File

  FPos := 0;
  for Cnt  := 0 to NrOfChuncks-1 do begin
    pB := @RawDataInRAM[FileCount,FPos];
    FileSeek(Fh, FPos, 0);
    if (Cnt < NrOfChuncks-1) then begin
      FileWrite(Fh, pB^, ChunkSize);
      frmProgress.lbProgress.Caption := IntToStr(Round(((FPos+ChunkSize)/FSize)*100))+ '%';
    end else
    begin
      FileWrite(Fh, pB^, ChunkSize + Rem);
      frmProgress.lbProgress.Caption := IntToStr(Round(((Rem+FPos+ChunkSize)/FSize)*100)) + '%';
    end;
    Inc(FPos,ChunkSize);
    frmProgress.ImageProgressBar.Position := Cnt+1;
    Application.ProcessMessages;
   end;

   frmProgress.Close;

   FileClose(Fh);

End; //Procedure WriteImageFromFileLoadedInRAM
{*******************************************************************************}

END.
