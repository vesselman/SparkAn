unit unCopyWindow;

interface

uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Forms, Vcl.Graphics, Vcl.Controls, Vcl.StdCtrls;


type
  TfrmCopyWindow = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCopyWindow: TfrmCopyWindow;

implementation

{$R *.dfm}

procedure TfrmCopyWindow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action         := caFree;
  frmCopyWindow  := nil;
end;

END.
