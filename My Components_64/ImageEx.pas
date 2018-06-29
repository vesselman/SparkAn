{
 The following unit is a visual component inherited of TImage, which has the 
 2 additional events OnMouseEnter and OnMouseLeave. 
}

unit  ImageEx;

interface

uses 
  Classes, Controls, ExtCtrls, Messages,Graphics;

type 
  TImageEx = class (TImage) 
  private 
    { Private declarations } 
    FOnMouseLeave: TNotifyEvent; 
    FOnMouseEnter: TNotifyEvent; 
    procedure CMMouseEnter(var msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var msg: TMessage); message CM_MOUSELEAVE; 
  protected 
    { Protected declarations } 
    procedure DoMouseEnter; {dynamic;}
    procedure DoMouseLeave; {dynamic;}
  public 
    { Public declarations } 
  published 
    { Published declarations } 
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter; 
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave; 
  end; 

procedure Register; 

implementation 

procedure Register; 
begin 
  RegisterComponents('Standard', [TImageEx]); 
end; 

{ TImageEx } 

procedure TImageEx.CMMouseEnter(var msg: TMessage); 
begin
  DoMouseEnter;
end; 

procedure TImageEx.CMMouseLeave(var msg: TMessage); 
begin 
  DoMouseLeave; 
end; 

procedure TImageEx.DoMouseEnter; 
begin 
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self); 
end; 

procedure TImageEx.DoMouseLeave; 
begin 
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self); 
end; 

end. 

 