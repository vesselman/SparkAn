unit About;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
     Vcl.Forms, Vcl.Graphics,Vcl.Controls, Vcl.StdCtrls,Vcl.ExtCtrls, Vcl.Buttons;


type
  TAboutBox = class(TForm)
    OKButton: TButton;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Authors: TLabel;
    lbProgramName: TLabel;
    Bevel1: TBevel;
    lbDate: TLabel;
    BlueShapeRect: TShape;
    lb32or64bit: TLabel;
    mFFmpeg: TMemo;
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CMMouseEnter(var AMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMsg: TMessage); message CM_MOUSELEAVE;
    procedure WmNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    {this enables User to Grab and Move Form without Form Caption}
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

  uses unGlobUnit,unFunctions;

{$R *.dfm}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
     AboutBox.Close;
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
       Action := caFree;
       AboutBox := nil;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
 var TempStr : AnsiString; var b : byte;
begin


   TempStr := 'P';
   TempStr := TempStr + 'r' + 'o' + 'g' + 'r' + 'a' + 'm' + ' ' + 'N' + 'a' + 'm' + 'e' + ':';
   ProductName.Caption := TempStr; //Program Name:

   TempStr := 'S';
   TempStr := TempStr + 'p' + 'a' + 'r' + 'k' + 'A' + 'n';
   lbProgramName.Caption := TempStr;  //SparkAn


   TempStr := 'V';
   TempStr := TempStr + 'e' + 'r' + 's' + 'i' + 'o' + 'n' + ':' +
               ' ' + '5' + '.' + '5' + '.' + '3' + '.' + '0.e';     //version

   Version.Caption := TempStr;

   TempStr := 'June'  + ' '  +  '27' +  ', ' +  '2' + '0' + '1' + '8';     //date
   lbDate.Caption := TempStr;

   lb32or64bit.Caption := GetDllMachineType(SparkAnDir + 'SparkAn.exe');

   TempStr := 'A';
   TempStr := TempStr + 'd' + 'r' + 'i' + 'a' + 'n' + ' ' + 'D' + '.' + ' ' + 'B' + 'o' +
              'n' + 'e' + 'v' + ' ' + '&&' + ' '  + 'M' + 'a' + 'r' + 'k' + ' ' + 'T' + '.' +
              ' ' + 'N' + 'e' + 'l' + 's' + 'o' + 'n';
   Authors.Caption := TempStr; //Adrian D. Bonev & Mark T. Nelson

   AboutBox.ShowModal;


end;

procedure TAboutBox.WmNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
  if Msg.Result = HTCLIENT then Msg.Result := HTCAPTION;
end;

procedure TAboutBox.CMMouseLeave(var AMsg: TMessage);
begin
  Screen.Cursor := crDefault;
end;

procedure TAboutBox.CMMouseEnter(var AMsg: TMessage);
begin
  Screen.Cursor := crHandPoint;

end;




End.
 
