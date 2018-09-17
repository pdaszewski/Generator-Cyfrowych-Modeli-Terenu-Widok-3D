unit OknoGl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, JPEG,ExtCtrls, ShellAPI, ComCtrls;

type
  TAGlowne = class(TForm)
    OpenCyfr: TOpenDialog;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    N1: TMenuItem;
    Zamknij1: TMenuItem;
    Otwrzplikmapycyfrowej1: TMenuItem;
    Image1: TImage;
    Widok1: TMenuItem;
    Oknomapycyfrowej1: TMenuItem;
    Operacje1: TMenuItem;
    Statystykimapy1: TMenuItem;
    N2: TMenuItem;
    Zaznaczdepresje1: TMenuItem;
    Mapawaciwa1: TMenuItem;
    Zaznaczniziny1: TMenuItem;
    Zaznaczwyyny1: TMenuItem;
    Zaznaczgry1: TMenuItem;
    N3: TMenuItem;
    Zaznaczwybrane1: TMenuItem;
    N4: TMenuItem;
    Wizualizacja3D1: TMenuItem;
    Pomoc1: TMenuItem;
    Oprogramie1: TMenuItem;
    Zaznacznajwyszyszczyt1: TMenuItem;
    Zaznacznajwikszgbin1: TMenuItem;
    Zapiszmapcyfrow1: TMenuItem;
    SaveCyfr: TSaveDialog;
    StatusBar1: TStatusBar;
    Exportmapykompresja1: TMenuItem;
    N5: TMenuItem;
    SaveCyfK: TSaveDialog;
    Importskompresowanejmapy1: TMenuItem;
    OpenCyfrk: TOpenDialog;
    N6: TMenuItem;
    Obliczodlegoci1: TMenuItem;
    AutoRun: TTimer;
    procedure Zamknij1Click(Sender: TObject);
    procedure Otwrzplikmapycyfrowej1Click(Sender: TObject);
    function Wysokosc(x,y : integer):integer;
    procedure WyswietlCyfr;
    procedure FormCreate(Sender: TObject);
    procedure Oknomapycyfrowej1Click(Sender: TObject);
    procedure Statystykimapy1Click(Sender: TObject);
    procedure Zaznaczdepresje1Click(Sender: TObject);
    procedure Mapawaciwa1Click(Sender: TObject);
    procedure Zaznaczniziny1Click(Sender: TObject);
    procedure Zaznaczwyyny1Click(Sender: TObject);
    procedure Zaznaczgry1Click(Sender: TObject);
    procedure Zaznaczwybrane1Click(Sender: TObject);
    procedure ZaznaczOdDo(odi, doi : integer);
    procedure ZaznaczOdDo2(odi1, doi1, odi2, doi2, odi3, doi3 : integer);
    procedure Wizualizacja3D1Click(Sender: TObject);
    procedure Oprogramie1Click(Sender: TObject);
    procedure Zaznacznajwyszyszczyt1Click(Sender: TObject);
    procedure Zaznacznajwikszgbin1Click(Sender: TObject);
    procedure Zapiszmapcyfrow1Click(Sender: TObject);
    procedure Exportmapykompresja1Click(Sender: TObject);
    procedure Importskompresowanejmapy1Click(Sender: TObject);
    procedure Obliczodlegoci1Click(Sender: TObject);
    procedure AutoRunTimer(Sender: TObject);
  private
    { Private declarations }
  public
   const
    wersja = '1.5.0';
  end;

var
  AGlowne: TAGlowne;
  tabcyf : array of array of integer;
  wmapy, hmapy : integer;

  maxnie, minnie : integer;
  maxzie, minzie : integer;
  maxzol, minzol : integer;
  maxcze, mincze : integer;
  skala : real;
  plik : string;

implementation

uses MapaCfrm, Postepfrm, Statystykifrm, Zaznaczeniefrm, Oprogziefrm,
  Odlegloscfrm;

{$R *.dfm}

procedure TAGlowne.ZaznaczOdDo2(odi1, doi1, odi2, doi2, odi3, doi3 : integer);
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
 czy : boolean;
begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     czy:=False;
     //----------------------------
     if (wys>=odi1) and (wys<=doi1) then czy:=True;
     if (wys>=odi2) and (wys<=doi2) then czy:=True;
     if (wys>=odi3) and (wys<=doi3) then czy:=True;
     //----------------------------
     if czy=True then
     Begin
     if wys<0 then
      Begin
       pomR:=((255/minnie)*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       B:=pomV;
      end;
     if (wys>=minzie) and (wys<maxzie) then
      Begin
       pomR:=(255/(maxzie-minzie))*wys;
       pomV:=pomR;
       G:=pomV;
      end;
     if (wys>=minzol) and (wys<maxzol) then
      Begin
       pomR:=(255/(minzol+(maxzol-minzol)))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
      end;
     if (wys>=mincze) and (wys<maxcze) then
      Begin
       pomR:=((255/(mincze+(maxcze-mincze)))*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       R:=pomV;
      end;
     end
     else
      Begin
       pomR:=(255/(maxcze))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
       B:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
end;
procedure TAGlowne.ZaznaczOdDo(odi, doi : integer);
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     if (wys>odi) and (wys<doi) then
     Begin
     if wys<0 then
      Begin
       pomR:=((255/minnie)*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       B:=pomV;
      end;
     if (wys>=minzie) and (wys<maxzie) then
      Begin
       pomR:=(255/(maxzie-minzie))*wys;
       pomV:=pomR;
       G:=pomV;
      end;
     if (wys>=minzol) and (wys<maxzol) then
      Begin
       pomR:=(255/(minzol+(maxzol-minzol)))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
      end;
     if (wys>=mincze) and (wys<maxcze) then
      Begin
       pomR:=((255/(mincze+(maxcze-mincze)))*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       R:=pomV;
      end;
     end
     else
      Begin
       pomR:=(255/(maxcze))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
       B:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
end;

function TAGlowne.Wysokosc(x,y : integer):integer;
Begin
 Wysokosc:=tabcyf[x,y];
end;

procedure TAGlowne.WyswietlCyfr;
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     if wys<0 then
      Begin
       pomR:=((255/minnie)*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       B:=pomV;
      end;
     if (wys>=minzie) and (wys<maxzie) then
      Begin
       pomR:=(255/(maxzie-minzie))*wys;
       pomV:=pomR;
       G:=pomV;
      end;
     if (wys>=minzol) and (wys<maxzol) then
      Begin
       pomR:=(255/(minzol+(maxzol-minzol)))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
      end;
     if (wys>=mincze) and (wys<maxcze) then
      Begin
       pomR:=((255/(mincze+(maxcze-mincze)))*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       R:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
end;

procedure TAGlowne.Zamknij1Click(Sender: TObject);
begin
Close;
end;

procedure TAGlowne.Otwrzplikmapycyfrowej1Click(Sender: TObject);
Var
 plikcyf : TextFile;
 x, y, wys, w, h : integer;
begin
if OpenCyfr.Execute then
 Begin
  //------------------------------------
  plik:=OpenCyfr.FileName;
  AssignFile(plikcyf,plik);
  Reset(plikcyf);
   Readln(plikcyf,h);
   Readln(plikcyf,w);
   Readln(plikcyf,skala);
   Readln(plikcyf,Minnie);
   Readln(plikcyf,Maxnie);
   Readln(plikcyf,Minzie);
   Readln(plikcyf,Maxzie);
   Readln(plikcyf,Minzol);
   Readln(plikcyf,Maxzol);
   Readln(plikcyf,Mincze);
   Readln(plikcyf,Maxcze);
   wmapy:=w;
   hmapy:=h;
   SetLength(tabcyf,w+1,h+1);
  Repeat
  for y:=0 to h-1 do
   Begin
    for x:=0 to w-1 do
     Begin
      Readln(plikcyf,wys);
      tabcyf[x,y]:=wys;
     end;
   end;
   Until eof(plikcyf);
  //-----------------------
  CloseFile(plikcyf);
  StatusBar1.Panels[0].Text:=OpenCyfr.FileName;
 //-------------------------------
 MapaCyfr.pobierz(minnie, maxzie, maxzol, maxcze);

 WyswietlCyfr;
 MapaCyfr.Top:=AGlowne.Top+70;
 MapaCyfr.Left:=AGlowne.Left+20;

 Oknomapycyfrowej1.Checked:=True;
 Mapawaciwa1.Checked:=True;
 Zaznaczdepresje1.Checked:=False;
 Zaznaczniziny1.Checked:=False;
 Zaznaczwyyny1.Checked:=False;
 Zaznaczgry1.Checked:=False;

 czy_load:=True;
 Wizualizacja3D1.Enabled:=True;
 end;
end;

procedure TAGlowne.FormCreate(Sender: TObject);
var
 kolor, R, G, B : integer;
begin
Caption:='FX Systems - Analiza Cyfrowych Map - wersja: '+wersja;
czy_load:=False;
Wizualizacja3D1.Enabled:=False;
Image1.Picture.LoadFromFile(Extractfilepath(application.ExeName)+'Dane\Tlov2.jpg');
R:=224;
G:=223;
B:=227;
kolor:=RGB(R,G,B);
AGlowne.Color:=kolor;
end;

procedure TAGlowne.Oknomapycyfrowej1Click(Sender: TObject);
begin
if czy_load then
Begin
//-------------------------------------------
if MapaCyfr.Showing then
 Begin
  Oknomapycyfrowej1.Checked:=False;
  MapaCyfr.Hide;
 end
else
 Begin
  Oknomapycyfrowej1.Checked:=True;
  MapaCyfr.Show;
 end;
//-----------------------------------------
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Statystykimapy1Click(Sender: TObject);
Var
 pom, dl, sz, pow : real;
 pomV : Variant;
 pomS : String;
 wys, w, h, x, y, Pozycja : Integer;
 ile, dep, niz, wyz, gor : Integer;
 pdep, pniz, pwyz, pgor : integer;
 glebokosc, szczyt, srednia, srednialad : integer;
begin
if czy_load then
Begin
w:=wmapy;
h:=hmapy;

sz:=(hmapy*skala)/1000;
dl:=(wmapy*skala)/1000;
pow:=sz*dl;

pomV:=sz;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km';
Statystyki.LSzerokosc.Caption:=pomS;

pomV:=dl;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km';
Statystyki.LDlugosc.Caption:=pomS;

pomV:=pow;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km2';
Statystyki.Lpowierzchnia.Caption:=pomS;
//----------------------------------------------------------
//Zroznicowanie powierzchni
//----------------------------------------------------------
ile:=0; dep:=0;
niz:=0; wyz:=0;
gor:=0;
for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     ile:=ile+1;
     wys:=wysokosc(x+1,y+1);
     if wys<0 then dep:=dep+1;
     if (wys>minzie) and (wys<maxzie) then niz:=niz+1;
     if (wys>minzol) and (wys<maxzol) then wyz:=wyz+1;
     if (wys>mincze) and (wys<maxcze) then gor:=gor+1;
    end;
  end;

pdep := (100*dep) div ile;
pom:=(pow*pdep)/100;
pomV:=pom;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km2   '+'('+IntToStr(pdep)+'%)';
Statystyki.LDepresji.Caption:= pomS;

pniz := (100*niz) div ile;
pom:=(pow*pniz)/100;
pomV:=pom;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km2   '+'('+IntToStr(pniz)+'%)';
Statystyki.LNizin.Caption:= pomS;

pwyz := (100*wyz) div ile;
pom:=(pow*pwyz)/100;
pomV:=pom;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km2   '+'('+IntToStr(pwyz)+'%)';
Statystyki.LWyzyn.Caption:= pomS;

pgor := (100*gor) div ile;
pom:=(pow*pgor)/100;
pomV:=pom;
pomS:=pomV;
Pozycja:=Pos(',',pomS)+3;
Delete(pomS,Pozycja,Length(pomS)-Pozycja);
pomS:=pomS+' km2   '+'('+IntToStr(pgor)+'%)';
Statystyki.LGor.Caption:= pomS;
//----------------------------------------------------------
//Zroznicowanie wysokosci
//----------------------------------------------------------
glebokosc:=0;
szczyt:=0;
srednia:=0;
srednialad:=0;
for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     if wys<glebokosc then glebokosc:=wys;
     if wys>szczyt then szczyt:=wys;
     if wys>0 then
      Begin
       srednialad:=srednialad+wys;
      end;
     srednia:=srednia+wys;
    end;
  end;
 srednia:=srednia div ile;
 srednialad:=srednialad div ile;
 Statystyki.LGlegokosc.Caption:=IntToStr(glebokosc)+' m';
 Statystyki.LSzczyt.Caption:=IntToStr(szczyt)+' m';
 Statystyki.Lwys.Caption:=IntToStr(srednia)+' m';
 Statystyki.Lwyslad.Caption:=IntToStr(srednialad)+' m'; 
//----------------------------------------------------------
Statystyki.Show;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zaznaczdepresje1Click(Sender: TObject);
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
begin
if czy_load then
Begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     if wys<=0 then
      Begin
       pomR:=((255/minnie)*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       B:=pomV;
      end;
     if (wys>0) then
      Begin
       pomR:=(255/(maxcze))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
       B:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
Oknomapycyfrowej1.Checked:=True;
Mapawaciwa1.Checked:=False;
Zaznaczdepresje1.Checked:=True;
Zaznaczniziny1.Checked:=False;
Zaznaczwyyny1.Checked:=False;
Zaznaczgry1.Checked:=False;
Zaznaczwybrane1.Checked:=False;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Mapawaciwa1Click(Sender: TObject);
begin
if czy_load then
Begin
wyswietlCyfr;
Oknomapycyfrowej1.Checked:=True;
Mapawaciwa1.Checked:=True;
Zaznaczdepresje1.Checked:=False;
Zaznaczniziny1.Checked:=False;
Zaznaczwyyny1.Checked:=False;
Zaznaczgry1.Checked:=False;
Zaznaczwybrane1.Checked:=False;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zaznaczniziny1Click(Sender: TObject);
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
begin
if czy_load then
Begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     if (wys>=minzie) and (wys<maxzie) then
      Begin
       pomR:=(255/(maxzie-minzie))*wys;
       pomV:=pomR;
       G:=pomV;
      end
     else
      Begin
       pomR:=(255/(maxcze))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
       B:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
Oknomapycyfrowej1.Checked:=True;

Mapawaciwa1.Checked:=False;
Zaznaczdepresje1.Checked:=False;
Zaznaczniziny1.Checked:=True;
Zaznaczwyyny1.Checked:=False;
Zaznaczgry1.Checked:=False;
Zaznaczwybrane1.Checked:=False;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zaznaczwyyny1Click(Sender: TObject);
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
begin
if czy_load then
Begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     if (wys>=minzol) and (wys<maxzol) then
      Begin
       pomR:=(255/(minzol+(maxzol-minzol)))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
      end
     else
      Begin
       pomR:=(255/(maxcze))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
       B:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
Oknomapycyfrowej1.Checked:=True;

Mapawaciwa1.Checked:=False;
Zaznaczdepresje1.Checked:=False;
Zaznaczniziny1.Checked:=False;
Zaznaczwyyny1.Checked:=True;
Zaznaczgry1.Checked:=False;
Zaznaczwybrane1.Checked:=False;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zaznaczgry1Click(Sender: TObject);
Var
 x, y, w, h, wys : integer;
 kolor : TColor;
 pomR : Real;
 pomV : Variant;
 R, G, B : integer;
begin
if czy_load then
Begin
 //------------------------------------
 Postep.Show;
 w:=wmapy;
 h:=hmapy;
 MapaCyfr.Image1.Width:=w;
 MapaCyfr.Image1.Height:=h;
 MapaCyfr.Image1.Canvas.Refresh;
 Postep.Gauge1.MaxValue:=(w-1)*(h-1);
 Postep.Gauge1.Progress:=1;
 for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     R:=0;
     G:=0;
     B:=0;
     if (wys>=mincze) and (wys<maxcze) then
      Begin
       pomR:=((255/(mincze+(maxcze-mincze)))*wys);
       pomR:=255-(pomR*(155/255));
       pomV:=pomR;
       R:=pomV;
      end
     else
      Begin
       pomR:=(255/(maxcze))*wys;
       pomV:=pomR;
       G:=pomV;
       R:=pomV;
       B:=pomV;
      end;
     kolor:=RGB(R,G,B);
     MapaCyfr.Image1.Canvas.Pixels[x,y]:=kolor;
     Postep.Gauge1.Progress:=Postep.Gauge1.Progress+1;
    end;
  end;

Postep.Hide;
MapaCyfr.Show;
MapaCyfr.StatusBar1.Visible:=False;
MapaCyfr.StatusBar1.Visible:=True;
Oknomapycyfrowej1.Checked:=True;

Mapawaciwa1.Checked:=False;
Zaznaczdepresje1.Checked:=False;
Zaznaczniziny1.Checked:=False;
Zaznaczwyyny1.Checked:=False;
Zaznaczgry1.Checked:=True;
Zaznaczwybrane1.Checked:=False;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zaznaczwybrane1Click(Sender: TObject);
begin
if czy_load then
 Begin
  Mapawaciwa1.Checked:=False;
  Zaznaczdepresje1.Checked:=False;
  Zaznaczniziny1.Checked:=False;
  Zaznaczwyyny1.Checked:=False;
  Zaznaczgry1.Checked:=False;
  Zaznaczwybrane1.Checked:=True;

  Zaznaczenie.zakresy(minnie,maxcze);
  Zaznaczenie.Show;
 end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Wizualizacja3D1Click(Sender: TObject);
Var
 sciezka : String;
begin
if czy_load then
 Begin
  sciezka:=Extractfilepath(application.ExeName)+'Widok3D.exe';
  ShellExecute(Handle,'open',PWideChar(sciezka),PWideChar(''''+plik+''''),nil,sw_showNormal);
 end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Oprogramie1Click(Sender: TObject);
begin
OProgzie.Show;
end;

procedure TAGlowne.Zaznacznajwyszyszczyt1Click(Sender: TObject);
Var
 sx, sy, naj, wys, x,y,w,h : integer;
begin
if czy_load then
Begin
w:=wmapy;
h:=hmapy;
naj:=0; wys:=0;
sx:=0; sy:=0;
for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     if wys>naj then
      Begin
       naj:=wys;
       sx:=x+1; sy:=y+1;
      end;
    end;
  end;
//=======================================================
MapaCyfr.Image1.Canvas.Ellipse(sx-5,sy-5,sx+5,sy+5);
MapaCyfr.Image1.Canvas.TextOut(sx+6,sy-6,'Wysokoœæ: '+IntToSTr(naj));
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zaznacznajwikszgbin1Click(Sender: TObject);
Var
 sx, sy, naj, wys, x,y,w,h : integer;
begin
if czy_load then
Begin
w:=wmapy;
h:=hmapy;
naj:=0; wys:=0;
sx:=0; sy:=0;
for y:=0 to h-1 do
  Begin
   for x:=0 to w-1 do
    Begin
     wys:=wysokosc(x+1,y+1);
     if wys<naj then
      Begin
       naj:=wys;
       sx:=x+1; sy:=y+1;
      end;
    end;
  end;
//=======================================================
MapaCyfr.Image1.Canvas.Ellipse(sx-5,sy-5,sx+5,sy+5);
MapaCyfr.Image1.Canvas.TextOut(sx+6,sy-6,'G³êbokoœæ: '+IntToSTr(naj));
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

procedure TAGlowne.Zapiszmapcyfrow1Click(Sender: TObject);
Var
 x, y, th, tw : integer;
 plikcyf : TextFile;

begin
if SaveCyfr.Execute then
 Begin
  plik:=SaveCyfr.FileName;
  tw:=wmapy;
  th:=hmapy;
  AssignFile(plikcyf,plik);
  Rewrite(plikcyf);
   //-------------------------------
   Writeln(plikcyf,th);
   Writeln(plikcyf,tw);
   Writeln(plikcyf,skala);
   Writeln(plikcyf,Minnie);
   Writeln(plikcyf,Maxnie);
   Writeln(plikcyf,Minzie);
   Writeln(plikcyf,Maxzie);
   Writeln(plikcyf,Minzol);
   Writeln(plikcyf,Maxzol);
   Writeln(plikcyf,Mincze);
   Writeln(plikcyf,Maxcze);
   //-------------------------------
   for y:=0 to th-1 do
    Begin
     for x:=0 to tw-1 do
      Begin
       Writeln(plikcyf,tabcyf[x,y]);
      end;
    end;
   //-------------------------------
  CloseFile(plikcyf);
  StatusBar1.Panels[0].Text:=SaveCyfr.FileName;
  Wizualizacja3D1.Enabled:=True;
 end;

end;

procedure TAGlowne.AutoRunTimer(Sender: TObject);
begin
 AutoRun.Enabled:=False;
 AGlowne.WindowState:=wsMaximized;
end;

procedure TAGlowne.Exportmapykompresja1Click(Sender: TObject);
Var
 ile, wys, wysp, x, y, th, tw : integer;
 linia, nazwa : string;
 plikck : TextFile;
begin
if SaveCyfK.Execute then
 Begin
  nazwa:=SaveCyfK.FileName;
  tw:=wmapy;
  th:=hmapy;
  AssignFile(plikck,nazwa);
  Rewrite(plikck);
   //-------------------------------
   Writeln(plikck,th);
   Writeln(plikck,tw);
   Writeln(plikck,skala);
   Writeln(plikck,Minnie);
   Writeln(plikck,Maxnie);
   Writeln(plikck,Minzie);
   Writeln(plikck,Maxzie);
   Writeln(plikck,Minzol);
   Writeln(plikck,Maxzol);
   Writeln(plikck,Mincze);
   Writeln(plikck,Maxcze);
   wysp:=tabcyf[0,0];
   ile:=0;
   //-------------------------------
   for y:=0 to th-1 do
    Begin
     for x:=0 to tw-1 do
      Begin
       wys:=tabcyf[x,y];
       if wys<>wysp then
        Begin
         linia:=IntToStr(wysp)+'^'+IntToStr(ile);
         Writeln(plikck,linia);
         wysp:=wys;
         ile:=1;
        end
       else ile:=ile+1;
      end;
    end;
   //-------------------------------
   CloseFile(plikck);
   ShowMessage('Kompresja prawid³owa! Plik wynikowy: '+nazwa);
 end;
end;

procedure TAGlowne.Importskompresowanejmapy1Click(Sender: TObject);
Var
 linia, nazwa : string;
 plikck : TextFile;
 poz, x, y, w, h : integer;
 i, wys, ile : integer;
begin
if OpenCyfrk.Execute then
 Begin
  nazwa:=OpenCyfrk.FileName;
  AssignFile(plikck, nazwa);
  Reset(plikck);
   Readln(plikck,h);
   Readln(plikck,w);
   Readln(plikck,skala);
   Readln(plikck,Minnie);
   Readln(plikck,Maxnie);
   Readln(plikck,Minzie);
   Readln(plikck,Maxzie);
   Readln(plikck,Minzol);
   Readln(plikck,Maxzol);
   Readln(plikck,Mincze);
   Readln(plikck,Maxcze);
   wmapy:=w;
   hmapy:=h;
   SetLength(tabcyf,w+1,h+1);
   //-------------------------------
   x:=0; y:=0;
   Repeat
    Readln(plikck,linia);
    poz:=Pos('^',linia);
    wys:=StrToInt(Copy(linia,1,poz-1));
    ile:=StrToInt(Copy(linia,Poz+1,Length(linia)-poz));
    for i:=1 to ile do
     Begin
      tabcyf[x,y]:=wys;
      x:=x+1;
      if x>w-1 then
       Begin
        x:=0; y:=y+1;
       end;
     end;
   Until eof(plikck);
   //-------------------------------
  CloseFile(plikck);
  //-------------------------------
 MapaCyfr.pobierz(minnie, maxzie, maxzol, maxcze);

 WyswietlCyfr;
 MapaCyfr.Top:=AGlowne.Top+70;
 MapaCyfr.Left:=AGlowne.Left+20;

 Oknomapycyfrowej1.Checked:=True;
 Mapawaciwa1.Checked:=True;
 Zaznaczdepresje1.Checked:=False;
 Zaznaczniziny1.Checked:=False;
 Zaznaczwyyny1.Checked:=False;
 Zaznaczgry1.Checked:=False;

 czy_load:=True;
 Wizualizacja3D1.Enabled:=False;
 end;
end;

procedure TAGlowne.Obliczodlegoci1Click(Sender: TObject);
begin
if czy_load then
Begin
Odleglosc.JakaSkala(skala);
if Obliczodlegoci1.Checked then
 Begin
  MapaCyfr.PaintBox1.Refresh;
  wyswietlCyfr;
  Obliczodlegoci1.Checked:=False;
  MapaCyfr.wwodl(False);
  Odleglosc.Hide;
 end
else
 Begin
  Obliczodlegoci1.Checked:=True;
  MapaCyfr.wwodl(True);
  Odleglosc.Show;
 end;
end
else ShowMessage('Musisz wczytaæ plik mapy cyfrowej!');
end;

end.
