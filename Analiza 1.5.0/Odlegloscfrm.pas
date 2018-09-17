unit Odlegloscfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  punkt = record
    x, y : integer;
    end;

type
  TOdleglosc = class(TForm)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    CheckBox1: TCheckBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButton3: TSpeedButton;
    Label13: TLabel;
    Label17: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Ustaw(x, y : integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure JakaSkala(skal : Real);
    procedure Czysc;
    procedure SpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Odleglosc: TOdleglosc;
  tab : array[1..50] of punkt;
  ktory, x1, y1, x2, y2 : integer;
  skala : Real;


implementation

uses MapaCfrm, OknoGl;

{$R *.dfm}

procedure TOdleglosc.Czysc;
Var
 i : integer;
Begin
Label3.Caption:='(0;0)';
Label4.Caption:='(0;0)';
MapaCyfr.Nowe;
mapaCyfr.PaintBox1.Refresh;
for i:=1 to 50 do
 begin
  tab[i].x:=-10;
  tab[i].y:=-10;
 end;
ktory:=1;
Label17.Caption:=IntToStr(0);
end;

procedure TOdleglosc.JakaSkala(skal : Real);
Begin
 skala:=skal;
end;

procedure TOdleglosc.Ustaw(x, y : integer);
Begin
if ktory=51 then
 Begin
  ShowMessage('Pomiar mo¿e byæ dokonywana na maksymalnie 50 punktach!');
  ktory:=50;
 end;
tab[ktory].x:=x;
tab[ktory].y:=y;
ktory:=ktory+1;
Label17.Caption:=IntToStr(ktory-1);
end;

procedure TOdleglosc.FormCreate(Sender: TObject);
begin
Czysc;
end;

procedure TOdleglosc.SpeedButton1Click(Sender: TObject);
begin
Czysc;
AGlowne.wyswietlCyfr;
end;

procedure TOdleglosc.SpeedButton2Click(Sender: TObject);
Var
 pom : Variant;
 skxp, skyp, cp : real;
 j, w1, w2, ox, oy, i, a, b, c : integer;
 oxp, oyp, ap, odleg, rzut : real;
 linia : string;
begin
if ktory>2 then
Begin
ap:=skala;
odleg:=1;
rzut:=0;
Label3.Caption:='('+IntToStr(tab[1].x)+';'+IntToStr(tab[1].y)+')';
Label4.Caption:='('+IntToStr(tab[ktory-1].x)+';'+IntToStr(tab[ktory-1].y)+')';
 for j:=1 to ktory-2 do
 Begin
 x1:=tab[j].x; y1:=tab[j].y;
 x2:=tab[j+1].x; y2:=tab[j+1].y;

 if x2>x1 then a:=x2-x1 else a:=x1-x2;
 if y2>y1 then b:=y2-y1 else b:=y1-y2;

 cp:=sqrt((a*a)+(b*b)); pom:=cp;
 c:=pom;

 skxp:=a/c;
 skyp:=b/c;

 if (x2-x1)<0 then skxp:=-skxp;
 if (y2-y1)<0 then skyp:=-skyp;

 rzut:=rzut+((c*skala)/1000);

 w1:=AGlowne.Wysokosc(x1,y1);

 //=======================================
 for i:=1 to c do
  Begin
   oxp:=x1+(skxp*i); pom:=oxp;
   ox:=pom;
   oyp:=y1+(skyp*i); pom:=oyp;
   oy:=pom;

   w2:=AGlowne.Wysokosc(ox,oy);
   if w2<0 then
    Begin
     if CheckBox1.Checked then w2:=0;
    end;
   if w2>w1 then b:=w2-w1 else b:=w1-w2;
   cp:=sqrt((ap*ap)+(b*b));
   odleg:=odleg+cp;
   w1:=w2;
   MapaCyfr.Image1.Canvas.Pen.Color:=clRed;
   MapaCyfr.Image1.Canvas.Rectangle(ox-1,oy-1,ox+1,oy+1);
  end;
 //=======================================
 end;
 pom:=rzut; linia:=pom;
 Delete(linia,Pos(',',linia)+4,Length(linia)-Pos(',',linia)+4);
 linia:=linia+' km';
 Label6.Caption:=linia;
 
 odleg:=odleg/1000;
 pom:=odleg; linia:=pom;
 Delete(linia,Pos(',',linia)+4,Length(linia)-Pos(',',linia)+4);
 linia:=linia+' km';
 Label8.Caption:=linia;
//-----------------------------------------------------
AGlowne.Mapawaciwa1.Checked:=False;
end
else ShowMessage('Musisz zaznaczyæ przynajmniej 2 punkty!');
end;

procedure TOdleglosc.SpeedButton3Click(Sender: TObject);
begin
if Label9.Visible then
 Begin
  Label9.Visible:=False;
  Label10.Visible:=False;
  Label11.Visible:=False;
  Label12.Visible:=False;
  Label14.Visible:=False;
  Label15.Visible:=False;
  Label16.Visible:=False;
 end
else
 Begin
  Label9.Visible:=True;
  Label10.Visible:=True;
  Label11.Visible:=True;
  Label12.Visible:=True;
  Label14.Visible:=True;
  Label15.Visible:=True;
  Label16.Visible:=True;
 end;
end;

end.
