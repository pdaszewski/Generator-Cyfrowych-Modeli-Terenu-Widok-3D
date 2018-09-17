unit MapaCfrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls;


type
  punkt = record
    x, y : integer;
    end;


type
  TMapaCyfr = class(TForm)
    Image1: TImage;
    StatusBar1: TStatusBar;
    PaintBox1: TPaintBox;
    procedure pobierz(minniep, maxziep, maxzolp, maxczep : integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure wwodl(czy : boolean);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure Nowe;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MapaCyfr: TMapaCyfr;
  maxnie, minnie : integer;
  maxzie, minzie : integer;
  maxzol, minzol : integer;
  maxcze, mincze : integer;
  czy_load : boolean;
  ktory, xm, ym : integer;
  czy_odl : boolean;
  tab : array[1..50] of punkt;

implementation

uses OknoGl, Odlegloscfrm;

{$R *.dfm}

procedure TMapaCyfr.Nowe;
Var
 i : integer;
Begin
ktory:=1;
for i:=1 to 50 do
 Begin
  tab[i].x:=-10;
  tab[i].y:=-10;
 end;
end;

procedure TMapaCyfr.wwodl(czy : boolean);
Begin
 czy_odl:=czy;
end;

procedure TMapaCyfr.pobierz(minniep, maxziep, maxzolp, maxczep : integer);
Begin
 minnie:=minniep; maxnie:=0;
 minzie:=0; maxzie:=maxziep;
 minzol:=maxziep; maxzol:=maxzolp;
 mincze:=maxzol; maxcze:=maxczep;
end;

procedure TMapaCyfr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
AGlowne.Oknomapycyfrowej1.Checked:=False;
end;

procedure TMapaCyfr.FormShow(Sender: TObject);
begin
PaintBox1.Height:=Image1.Height;
PaintBox1.Width:=Image1.Width;
end;

procedure TMapaCyfr.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
Var
 i : integer;
begin
 StatusBar1.Panels[0].Text:='('+IntToSTr(x)+';'+IntToStr(y)+')';
 StatusBar1.Panels[1].Text:='Wysokoœæ: '+IntToStr(AGlowne.Wysokosc(x,y));

 if (AGlowne.Wysokosc(x,y)>=minnie) and (AGlowne.Wysokosc(x,y)<=maxnie) then
 StatusBar1.Panels[2].Text:='Depresje';
 if (AGlowne.Wysokosc(x,y)>=minzie) and (AGlowne.Wysokosc(x,y)<=maxzie) then
 StatusBar1.Panels[2].Text:='Niziny';
 if (AGlowne.Wysokosc(x,y)>=minzol) and (AGlowne.Wysokosc(x,y)<=maxzol) then
 StatusBar1.Panels[2].Text:='Wy¿yny';
 if (AGlowne.Wysokosc(x,y)>=mincze) and (AGlowne.Wysokosc(x,y)<=maxcze) then
 StatusBar1.Panels[2].Text:='Góry';
 xm:=X; ym:=Y;
 if czy_odl then
  Begin
   PaintBox1.Refresh;
   PaintBox1.Canvas.Pen.Color:=clRed;
   PaintBox1.Canvas.MoveTo(X,Y-10);
   PaintBox1.Canvas.LineTo(X,Y+10);
   PaintBox1.Canvas.MoveTo(X-10,Y);
   PaintBox1.Canvas.LineTo(X+10,Y);

   for i:=1 to ktory-1 do
    Begin
     PaintBox1.Canvas.Rectangle(tab[i].x-2, tab[i].y-2, tab[i].x+2, tab[i].y+2);
    end;
  end;
 //==================================
end;

procedure TMapaCyfr.FormCreate(Sender: TObject);
begin
czy_odl:=False;
ktory:=1;
end;

procedure TMapaCyfr.PaintBox1Click(Sender: TObject);
begin
if ktory=51 then ktory:=50;
Odleglosc.Ustaw(xm,ym);
tab[ktory].x:=xm;
tab[ktory].y:=ym;
ktory:=ktory+1;
end;

end.
