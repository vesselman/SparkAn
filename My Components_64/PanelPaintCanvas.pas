{  by Adrian D. Bonev
 The following unit is a visual component inherited of Tpanel, which has the
 OnPaint and Canvas exposed.
 Do not Draw Rectangles in response to OnPaint - result is not good -
 Use Polyline or LineTo instead 
}

unit  PanelPaintCanvas;

interface

uses 
  Classes,  Controls, ExtCtrls;

type 
  TPanelPaintCanvas = class (TPanel)
  private 
    { Private declarations }
    FOnPaint          : TNotifyEvent; //this Exposes OnPiant not exposed in TLabel;
  protected 
    { Protected declarations } 

  public
    { Public declarations }
    property Canvas;
    procedure Paint; override;
  published 
    { Published declarations } 

    property OnPaint : TNotifyEvent read FOnPaint  write FOnPaint; //exposes Onpaint not exposed in TPanel
  end; 

procedure Register; 

implementation 

procedure Register; 
begin
  RegisterComponents('Standard', [TPanelPaintCanvas]);
end; 

{ TPanelPaintCanvas }

procedure TPanelPaintCanvas.Paint;

begin
  inherited Paint;
  if assigned(FOnPaint) then FOnPaint(Self); {call Paint Event}
end;

end. 

 