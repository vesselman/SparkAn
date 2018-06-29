unit unProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.Variants,System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms,Vcl.Dialogs,Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, ThdTimer;

type
  TfrmProgress = class(TForm)
    lbReading: TLabel;
    ImageProgressBar: TProgressBar;
    lbProgress: TLabel;
    lbAction: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProgress: TfrmProgress;

implementation

{$R *.dfm}

procedure TfrmProgress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      ImageProgressBar.Position := 0;
      Action       := caFree;
      frmProgress  := nil;
end;

procedure TfrmProgress.FormCreate(Sender: TObject);
begin
  ImageProgressBar.BarColor := clBlue;
End;
END.
