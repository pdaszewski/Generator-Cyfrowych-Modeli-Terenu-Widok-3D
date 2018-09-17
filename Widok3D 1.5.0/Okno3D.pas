unit Okno3d;

interface

uses
  opengl,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Menus, ExtCtrls,math,dialogs, StdCtrls, ImgList, Buttons, ComCtrls, Spin;


Type

  TOpenGL = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    Plik1: TMenuItem;
    Otwrzmapcyfrow1: TMenuItem;
    N1: TMenuItem;
    Zamknij1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Pomoc1: TMenuItem;
    Oprogramie1: TMenuItem;
    Obiekty1: TMenuItem;
    Teren1: TMenuItem;
    Poziomzerowy1: TMenuItem;
    Ustawowietlenie1: TMenuItem;
    Ustawienia1: TMenuItem;
    Siatka1: TMenuItem;
    Wypenienie1: TMenuItem;
    N2: TMenuItem;
    Poziomprecyzji1: TMenuItem;
    Panel1: TPanel;
    SpinEdit1: TSpinEdit;
    SpeedButton1: TSpeedButton;
    Kolorujteren1: TMenuItem;
    Obrot: TTimer;
    Animacja1: TMenuItem;
    Obrtpoziomy1: TMenuItem;
    Wyrnieniedepresji1: TMenuItem;
    Operacje1: TMenuItem;
    Wyrnieniedolin1: TMenuItem;
    Wyrnieniewyyn1: TMenuItem;
    Wyrnieniegr1: TMenuItem;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Sterowanie1: TMenuItem;
    N3: TMenuItem;
    AutoRun: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Start_spin(spx,spy : integer);
    procedure nazwa_pliku(nazwa : string);
    procedure Zamknij1Click(Sender: TObject);
    procedure Otwrzmapcyfrow1Click(Sender: TObject);
    procedure Oprogramie1Click(Sender: TObject);
    procedure Teren1Click(Sender: TObject);
    procedure Poziomzerowy1Click(Sender: TObject);
    procedure Ustawowietlenie1Click(Sender: TObject);
    procedure Siatka1Click(Sender: TObject);
    procedure Wypenienie1Click(Sender: TObject);
    procedure Poziomprecyzji1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Kolorujteren1Click(Sender: TObject);
    procedure ObrotTimer(Sender: TObject);
    procedure Obrtpoziomy1Click(Sender: TObject);
    procedure Wyrnieniedepresji1Click(Sender: TObject);
    procedure Wyrnieniedolin1Click(Sender: TObject);
    procedure Wyrnieniewyyn1Click(Sender: TObject);
    procedure Wyrnieniegr1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Sterowanie1Click(Sender: TObject);
    procedure AutoRunTimer(Sender: TObject);
  private

    px,py,pz,interwalX,interwalY:double;
    spinx,spiny:double;
    Odleglosc,sx,sy,przes,przes2:integer;

    procedure Draw; //Rysowanie sceny
   public
        { Public declarations }
  end;
const
 wersja='1.5.0';
var
  OpenGL: TOpenGL;
  w,h:integer;
  tab : array of double;
  plik : string; //zmienna przechowuje nazwe pliku z danymi
  //----- zmienne do konfiguracji swiatla ----
  exponent,cutoff:single;
    
implementation

uses obiekty, Oprogziefrm;

{$R *.dfm}

procedure setupPixelFormat(DC:HDC);
const
   pfd:TPIXELFORMATDESCRIPTOR = (
        nSize:sizeof(TPIXELFORMATDESCRIPTOR);	// wielkoœæ
        nVersion:1;			// wersja
        dwFlags:PFD_SUPPORT_OPENGL or PFD_DRAW_TO_WINDOW or
                PFD_DOUBLEBUFFER;	// udostêpnienie podwójnego buforowania
        iPixelType:PFD_TYPE_RGBA;	// typ koloru
        cColorBits:24;			// ¿¹dana rozdzielczoœæ koloru
        cRedBits:0; cRedShift:0;	// bity koloru(ignorowane)
        cGreenBits:0;  cGreenShift:0;
        cBlueBits:0; cBlueShift:0;
        cAlphaBits:0;  cAlphaShift:0;   // y³¹czenie buforu alfa
        cAccumBits: 0;
        cAccumRedBits: 0;  		// wy³¹czenie akumulacji bufora
        cAccumGreenBits: 0;     	// akumulowanie bitów (ignorowane)
        cAccumBlueBits: 0;
        cAccumAlphaBits: 0;
        cDepthBits:16;			// wielkoœæ bufora
        cStencilBits:0;			// bez buforu szablonu
        cAuxBuffers:0;			// bez buforu pomocniczego
        iLayerType:PFD_MAIN_PLANE;  	// g³ówna pow³oka
   bReserved: 0;
   dwLayerMask: 0;
   dwVisibleMask: 0;
   dwDamageMask: 0;                    // brak widocznoœci pow³oki, zniszczenie maski
   );
var pixelFormat:integer;
begin
   pixelFormat := ChoosePixelFormat(DC, @pfd);
   if (pixelFormat = 0) then	
        exit;
   if (SetPixelFormat(DC, pixelFormat, @pfd) <> TRUE) then
        exit;
end;


procedure GLInit;
Begin
   glMatrixMode(GL_PROJECTION);
   glLoadIdentity();
   glFrustum(-20.8, +20.8, -20.8, 20.8, 100.0, 5000.0);  //ustawienia perspektywy

   glMatrixMode(GL_MODELVIEW);
   glEnable(GL_DEPTH_TEST);
   glShadeModel(GL_SMOOTH);

   glBlendFunc(GL_SRC_ALPHA ,GL_ONE_MINUS_DST_ALPHA );
   glEnable(GL_BLEND);
   glPolygonMode(GL_FRONT,GL_fill);
   glPolygonMode(GL_BACK,GL_fill);
   glClearColor(0.7,0.7,0.7,1);   // ustawienie koloru tla
   glEnable(GL_LIGHTING);
   glEnable(GL_NORMALIZE);
end;

procedure TOpenGL.nazwa_pliku(nazwa : String);
Begin
 plik:=nazwa;
 tablica(plik);
end;

procedure TOpenGL.FormCreate(Sender: TObject);
var DC:HDC;
    RC:HGLRC;
    nazwa : String;
begin
   DC:=GetDC(Handle);        //Tutaj mo¿na stosowaæ dowoln¹ kontrolê okna
   SetupPixelFormat(DC);
   RC:=wglCreateContext(DC); //tworzy OpenGL okno na zewn¹trz DC
   wglMakeCurrent(DC, RC);   //w³¹czenie OpenGL okna jako aktywnego
   GLInit;                   //inicjalizacja OpenGL

   px:=0;
   py:=0;
   pz:=0;
//   glLINEWIDTH(1);
   w:=ClientWidth;
   h:=ClientHeight;
   tryb('siatka');
   OpenGL.Caption:='FX Systems - Przestrzenny model terenu - wersja: '+wersja;
   if ParamCount > 0 Then
    Begin
     nazwa:=ParamStr(1);
     Delete(nazwa,1,1);
     Delete(nazwa,Length(nazwa),1);
     nazwa_pliku(nazwa);
     OpenGL.Caption:='FX Systems - Przestrzenny model terenu - wersja: '+wersja+' - '+nazwa;
     Teren1.Checked:=True;
    end;
  dec(Odleglosc,800);
  Poziom(2);
  Wyroznienie(0);
end;

procedure TOpenGL.AutoRunTimer(Sender: TObject);
begin
 AutoRun.Enabled:=False;
 OpenGL.WindowState:=wsMaximized;
end;

procedure TOpenGL.Draw;
begin

   glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
   glLoadIdentity;

    glTranslatef(0+przes,0+przes2,-100.0+odleglosc);
    glRotatef(spinx,1.0,0.0,0.0);
    glRotatef(spiny,0.0,1.0,0.0);
   //*********** Tutaj rysowanie *********************************

        glPushMatrix();
        glTranslatef(12,20,0);
         if Ustawowietlenie1.Checked then UstawOswietlenie(exponent,cutoff+140,1)
         else UstawOswietlenie(exponent,cutoff+140,0);
        glPopMatrix();
      if Teren1.Checked then teren;
      if Poziomzerowy1.Checked then poziom_zerowy;

   //**************************************************************
   SwapBuffers(wglGetCurrentDC);
end;

procedure TOpenGL.FormPaint(Sender: TObject);
begin
  Draw;
end;


procedure TOpenGL.Timer1Timer(Sender: TObject);
begin
 spinx:=spinx+interwalX;
 spiny:=spiny+interwalY;
 Draw;
end;

procedure TOpenGL.Start_spin(spx,spy : integer);
Begin
 spinx:=spx;
 spiny:=spy;
 sx:=0;
 sy:=0;
 Draw;
end;

procedure TOpenGL.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
if (ssLeft in shift) then
 begin
   spiny:=spiny+(sx-x)/2;
   spinx:=spinx+(sy-y)/2;
   if spinx<0 then spinx:=0;
   if spinx>90 then spinx:=90.5;
 end;
sx:=x;
sy:=y;
end;

procedure TOpenGL.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key='+' then inc(Odleglosc,10);
if Key='-' then dec(Odleglosc,10);

end;

procedure TOpenGL.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=37 then inc(Przes,1);
if Key=39 then dec(Przes,1);

if Key=40 then inc(Przes2,1);
if Key=38 then dec(Przes2,1);
end;

procedure TOpenGL.FormResize(Sender: TObject);
var DC:HDC;
    RC:HGLRC;
begin
   DC:=GetDC(Handle);        //przypisanie kontekstu okna formatki jako okna OpenGL

   SetupPixelFormat(DC);
   RC:=wglCreateContext(DC); //makes OpenGL window out of DC
   wglMakeCurrent(DC, RC);   //makes OpenGL window active
   GLInit;                   //initialize OpenGL
   px:=0;
   py:=0;
   pz:=0;
//   glLINEWIDTH(1);
   w:=ClientWidth;
   h:=ClientHeight;
end;

procedure TOpenGL.FormShow(Sender: TObject);
begin
   spiny:=0;
   spinx:=0;
end;

procedure TOpenGL.Zamknij1Click(Sender: TObject);
begin
Close;
end;

procedure TOpenGL.Otwrzmapcyfrow1Click(Sender: TObject);
begin
If OpenDialog1.Execute then
 Begin
  nazwa_pliku(OpenDialog1.FileName);
  OpenGL.Caption:='FX Systems - Przestrzenny model terenu - wersja: '+wersja+' - '+ExtractFileName(OpenDialog1.FileName);
  Teren1.Checked:=True;
 end;
end;

procedure TOpenGL.Oprogramie1Click(Sender: TObject);
begin
Oprogzie.Show;
end;

procedure TOpenGL.Teren1Click(Sender: TObject);
begin
if Teren1.Checked then Teren1.Checked:=False
else Teren1.Checked:=True;
end;

procedure TOpenGL.Poziomzerowy1Click(Sender: TObject);
begin
if Poziomzerowy1.Checked then Poziomzerowy1.Checked:=False
else Poziomzerowy1.Checked:=True;
end;

procedure TOpenGL.Ustawowietlenie1Click(Sender: TObject);
begin
if Ustawowietlenie1.Checked then Ustawowietlenie1.Checked:=False
else Ustawowietlenie1.Checked:=True;
end;

procedure TOpenGL.Siatka1Click(Sender: TObject);
begin
 Siatka1.Checked:=True;
 tryb('siatka');
 Wypenienie1.Checked:=False;
end;

procedure TOpenGL.Wypenienie1Click(Sender: TObject);
begin
 Siatka1.Checked:=False;
 tryb('wypelnienie');
 Wypenienie1.Checked:=True;
end;

procedure TOpenGL.Poziomprecyzji1Click(Sender: TObject);
begin
Panel1.Visible:=True;
end;

procedure TOpenGL.SpeedButton1Click(Sender: TObject);
begin
Poziom(SpinEdit1.Value);
Panel1.Visible:=False;
end;

procedure TOpenGL.Kolorujteren1Click(Sender: TObject);
begin
if Kolorujteren1.Checked then
 Begin
  Kolorujteren1.Checked:=False;
  Kolory(False);
 end
else
 Begin
  Kolorujteren1.Checked:=True;
  Kolory(True);
 end;
end;

procedure TOpenGL.ObrotTimer(Sender: TObject);
begin
Spiny:=SPiny+1;
end;

procedure TOpenGL.Obrtpoziomy1Click(Sender: TObject);
begin
if Obrtpoziomy1.Checked then
 begin
  Obrtpoziomy1.Checked:=False;
  Obrot.Enabled:=False;
 end
else
 begin
  Obrtpoziomy1.Checked:=True;
  Obrot.Enabled:=True;
 end;
end;

procedure TOpenGL.Wyrnieniedepresji1Click(Sender: TObject);
begin
if Wyrnieniedepresji1.Checked Then
 Begin
  Wyrnieniedepresji1.Checked:=False;
  Wyroznienie(0);
 end
else
 Begin
  Wyrnieniedepresji1.Checked:=True;
  Wyrnieniedolin1.Checked:=False;
  Wyrnieniewyyn1.Checked:=False;
  Wyrnieniegr1.Checked:=False;
  Wyroznienie(1);
 end;
end;

procedure TOpenGL.Wyrnieniedolin1Click(Sender: TObject);
begin
if Wyrnieniedolin1.Checked Then
 Begin
  Wyrnieniedolin1.Checked:=False;
  Wyroznienie(0);
 end
else
 Begin
  Wyrnieniedolin1.Checked:=True;
  Wyrnieniedepresji1.Checked:=False;
  Wyrnieniewyyn1.Checked:=False;
  Wyrnieniegr1.Checked:=False;
  Wyroznienie(2);
 end;
end;

procedure TOpenGL.Wyrnieniewyyn1Click(Sender: TObject);
begin
if Wyrnieniewyyn1.Checked Then
 Begin
  Wyrnieniewyyn1.Checked:=False;
  Wyroznienie(0);
 end
else
 Begin
  Wyrnieniewyyn1.Checked:=True;
  Wyrnieniedepresji1.Checked:=False;
  Wyrnieniedolin1.Checked:=False;
  Wyrnieniegr1.Checked:=False;
  Wyroznienie(3);
 end;
end;

procedure TOpenGL.Wyrnieniegr1Click(Sender: TObject);
begin
if Wyrnieniegr1.Checked Then
 Begin
  Wyrnieniegr1.Checked:=False;
  Wyroznienie(0);
 end
else
 Begin
  Wyrnieniegr1.Checked:=True;
  Wyrnieniedepresji1.Checked:=False;
  Wyrnieniedolin1.Checked:=False;
  Wyrnieniewyyn1.Checked:=False;
  Wyroznienie(4);
 end;
end;

procedure TOpenGL.SpeedButton2Click(Sender: TObject);
begin
Panel2.Visible:=False;
end;

procedure TOpenGL.Sterowanie1Click(Sender: TObject);
begin
Panel2.Visible:=True;
end;

end.
