// ezBOO - TSuperSubLabel version 1.20
//
// http://www.ezboo.com
// info@ezboo.com

unit SuperSubLabel;

interface

uses

   Windows, Classes, Controls, Graphics, StdCtrls;

type

  TSuperSubLabel = class(TLabel)
  private
    { Private declarations }
    procedure DoDrawSuperSubLabel(var Rect: TRect; Flags: Word);
  protected
    { Protected declarations }
    procedure Paint;override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

 procedure SuperSubLabelOut(Canvas:TCanvas; const aRect:TRect; X, Y:integer; text:String);
 procedure Register;
 
implementation

///////////////////////////////////////////////////////////////////////////////
procedure Register;
begin
  RegisterComponents('Standard',[TSuperSubLabel]);
end;
///////////////////////////////////////////////////////////////////////////////
function extractCaption(str: String) : string;
var i:byte;
    outstring: string;
begin
  outstring :='';
  for i:=1 to length(str) do
  begin
   if (str[i] <> '_') and (str[i] <> '^') then outstring := outstring + str[i];
  end;
  extractCaption := outstring;
end;
///////////////////////////////////////////////////////////////////////////////
procedure TSuperSubLabel.DoDrawSuperSubLabel(var Rect: TRect; Flags: Word);
begin
  Canvas.Font := Font;
  if not Enabled then Canvas.Font.Color := clGrayText;
  if Alignment = taCenter then SuperSubLabelOut(Canvas,  Rect, trunc( (Rect.Right-Canvas.TextWidth(extractCaption(caption)))/2), Rect.Top, Caption);
  if Alignment = taLeftJustify then SuperSubLabelOut(Canvas,  Rect, Rect.Left, Rect.Top, Caption);
  if Alignment = taRightJustify then SuperSubLabelOut(Canvas,  Rect, Rect.Right-Canvas.TextWidth(extractCaption(caption)), Rect.Top, Caption);
end;
///////////////////////////////////////////////////////////////////////////////
procedure TSuperSubLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
begin
  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    DoDrawSuperSubLabel(Rect, (DT_EXPANDTABS or DT_WORDBREAK) or Alignments[Alignment]);
  end;
end;
///////////////////////////////////////////////////////////////////////////////
procedure SuperSubLabelOut(Canvas:TCanvas; const aRect:TRect; X, Y:integer; text:String);
var i,xx,DefTextHeight:integer;
    subScript, superScript, Symbol : boolean;
    DefFont:TFont;
begin
 Canvas.FillRect(aRect);
 DefFont:=TFont.Create;
 DefFont.Assign(Canvas.Font);
 with Canvas do begin
  xx:=X;

  for i:=1 to length(text) do
  begin
   if text[i-1] = '_' then subScript:=true
                      else subScript:=false;
   if text[i-1] = '^' then superScript:=true
                      else superScript:=false;
   if text[i-1] = '|' then Symbol := true
                      else Symbol := false;


   if  (text[i] <> '_' ) and (text[i] <> '^' ) and (text[i] <> '|') then
   begin

      if ( subScript ) then
      begin
        Canvas.Font.Style := Canvas.Font.Style - [fsUnderline];
        Canvas.Font.Height:=Canvas.Font.Height*8 div 10;
        TextRect(Rect(xx,aRect.Top,xx+TextWidth(text[i]),aRect.Bottom),xx, Y+abs(8*Canvas.Font.Height-10*DefFont.Height) div 10, text[i]);
        inc(xx,TextWidth(text[i]));
      end;

      if ( not subScript) and ( not superScript ) then
      begin
        Canvas.Font := DefFont;
        if (Symbol) then begin
        DefTextHeight := TextHeight(text[i]);
        Canvas.Font.Name := 'Symbol';
        TextRect(Rect(xx,aRect.Top,xx+TextWidth(text[i]),aRect.Bottom),xx,Y-(TextHeight(text[i])-DefTextHeight),text[i]);
        end;
        if Not(Symbol) then
        TextRect(Rect(xx,aRect.Top,xx+TextWidth(text[i]),aRect.Bottom),xx, Y, text[i]);
        inc(xx,TextWidth(text[i]));
      end;

      if ( superScript ) then
      begin
        Canvas.Font.Style := Canvas.Font.Style - [fsUnderline];
        Canvas.Font.Height:=Canvas.Font.Height*9 div 10;
        TextRect(Rect(xx,aRect.Top,xx+TextWidth(text[i]),aRect.Bottom),xx, Y-abs(8*Canvas.Font.Height-10*DefFont.Height) div 20, text[i]);
        inc(xx,TextWidth(text[i]));
      end;
      Canvas.Font:=DefFont;
   end;

  end; //for loop
 end;   // with
 DefFont.Free;
end;
///////////////////////////////////////////////////////////////////////////////


end.
