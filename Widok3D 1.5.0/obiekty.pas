unit obiekty;

interface
 uses opengl, math, SysUtils;

 procedure tablica(nazwa : string);
 procedure teren;
 procedure poziom_zerowy;
 procedure UstawOswietlenie(exp,cut:single; wy : integer);
 procedure Tryb(tr : string);
 procedure Poziom(val : integer);
 procedure Kolory(czy : boolean);
 procedure Ustaw_kolor(wysp : integer);
 procedure Wyroznienie(ktory : integer);

Var
 tabcyf : array of array of integer;
  maxnie, minnie : integer;
  maxzie, minzie : integer;
  maxzol, minzol : integer;
  maxcze, mincze : integer;

 s, w, h : integer;
 skala : real;
 trybw : string;
 czy_kolory : boolean;
 ktory_wyr : integer;

implementation
 uses Okno3d;

procedure Wyroznienie(ktory : integer);
Begin
 ktory_wyr:=ktory;
end;

procedure Ustaw_kolor(wysp : integer);
Var
 pomR : real;
Begin
  if ktory_wyr=0 then
   Begin
   if czy_kolory then
      Begin
       if wysp<minzie then
       Begin
        pomR:=((5/minnie)*wysp);
        pomR:=5-(pomR*(2.5/5));
        glColor3f(0.0, 0.0, pomR);
       end;
      if (wysp>minzie) and (wysp<maxzie) then
       Begin
        pomR:=(5/(maxzie-minzie))*wysp;
        glColor3f(0.0, pomR, 0.0);
       end;
      if (wysp>minzol) and (wysp<maxzol) then
       Begin
        pomR:=(5/(minzol+(maxzol-minzol)))*wysp;
        glColor3f(pomR, pomR, 0.0);
       end;
      if (wysp>mincze) and (wysp<maxcze) then
       Begin
        pomR:=((5/(mincze+(maxcze-mincze)))*wysp);
        pomR:=5-(pomR*(2.5/5));
        glColor3f(pomR, 0.0, 0.0);
       end;
      end
     else
      Begin
       glColor3f(0.0, 0.9, 0.9);
      end; 
   end
  else // Jesli nie wirozniam niczego
   Begin
    if ktory_wyr=1 then
     Begin
      if wysp>minzie then
       Begin
        pomR:=((5/maxcze)*wysp);
        glColor3f(pomR, pomR, pomR);
       end
      else
       Begin
        pomR:=((5/minnie)*wysp);
        pomR:=5-(pomR*(2.5/5));
        glColor3f(0.0, 0.0, pomR);
       end;
     end;
     if ktory_wyr=2 then
      Begin
       if (wysp>0) and (wysp<maxzie) then
        Begin
         pomR:=(5/(maxzie-minzie))*wysp;
         glColor3f(0.0, pomR, 0.0);
        end
       else
        Begin
         pomR:=((5/maxcze)*wysp);
         glColor3f(pomR, pomR, pomR);
        end;
      end;
     if ktory_wyr=3 then
      Begin
       if (wysp>minzol) and (wysp<maxzol) then
        Begin
         pomR:=(5/(minzol+(maxzol-minzol)))*wysp;
         glColor3f(pomR, pomR, 0.0);
        end
       else
        Begin
         pomR:=((5/maxcze)*wysp);
         pomR:=pomR+0.8;
         glColor3f(pomR, pomR, pomR);
        end;
      end;
     if ktory_wyr=4 then
      Begin
       if (wysp>mincze) and (wysp<maxcze) then
        Begin
         pomR:=((5/(mincze+(maxcze-mincze)))*wysp);
         pomR:=5-(pomR*(2.5/5));
         glColor3f(pomR, 0.0, 0.0);
        end
       else
        Begin
         pomR:=((5/maxcze)*wysp);
         pomR:=pomR+0.8;
         glColor3f(pomR, pomR, pomR);
        end;
      end;
     //========================================
   end;
end;

procedure Kolory(czy : boolean);
Begin
 czy_kolory:=czy;
end;

procedure Poziom(val : integer);
Begin
 s:=val;
end;

procedure UstawOswietlenie(exp,cut:single; wy : integer);
const
swiatlo_otoczenia: TGLArrayf4 = ( 0.1, 0.1, 0.1, 1.0);
swiatlo_rozproszone: TGLArrayf4 = ( 0.1, 0.1, 0.1, 1.0);
swiatlo_odbite: TGLArrayf4 = (1.0, 0.1, 0.1, 1.0);
swiatlo_pozycja: TGLArrayf4 = ( 0.0, 30.0, 0.0, 1.0);
begin

glLightModeli( GL_LIGHT_MODEL_TWO_SIDE, 0);
glEnable( GL_LIGHTING);
glLightfv( GL_LIGHT0, GL_AMBIENT, @swiatlo_otoczenia);    
glLightfv( GL_LIGHT0, GL_DIFFUSE, @swiatlo_rozproszone); 
glLightfv( GL_LIGHT0, GL_SPECULAR, @swiatlo_odbite);     
glLightfv( GL_LIGHT0, GL_POSITION, @swiatlo_pozycja);    
if wy=1 then glEnable( GL_LIGHT0)
else glDisable( GL_LIGHT0);
glEnable( GL_COLOR_MATERIAL);
//glColorMaterial( GL_FRONT_AND_BACK, GL_AMBIENT);   

//glColorMaterial( GL_FRONT_AND_BACK, GL_DIFFUSE);
//glColorMaterial( GL_FRONT, GL_SPECULAR);
//glMateriali( GL_FRONT, GL_SHININESS, 128);

if wy=1 then glClearColor( 0.0, 0.0, 0.5, 0.0)
else  glClearColor(0.7,0.7,0.7,1); 
end;

procedure tryb(tr : string);
Begin
 trybw:=tr;
end;

//===========================================================
//===========================================================
procedure tablica(nazwa : string);
var
 plikcyf : TextFile;
 wys, x, y : Integer;
Begin
 AssignFile(plikcyf,nazwa);
 Reset(plikcyf);
  Readln(plikcyf,h);
  Readln(plikcyf,w);
  Readln(plikcyf,skala);
  SetLength(tabcyf,w+1,h+1);
   Readln(plikcyf,Minnie);
   Readln(plikcyf,Maxnie);
   Readln(plikcyf,Minzie);
   Readln(plikcyf,Maxzie);
   Readln(plikcyf,Minzol);
   Readln(plikcyf,Maxzol);
   Readln(plikcyf,Mincze);
   Readln(plikcyf,Maxcze);
   x:=1; y:=1;
  Repeat
    Readln(plikcyf,wys);
    Tabcyf[x,y]:=wys;
    x:=x+1;
    if x=w+1 then
     Begin
      x:=1; y:=y+1;
     end;
  Until eof(plikcyf);
 CloseFile(plikcyf);
end;

//===========================================================
procedure poziom_zerowy;

begin
   glBegin(GL_QUADS);
    glColor3f(0.0, 0.0, 2.5);

    glVertex3f(-(w div 2), 0, -(h div 2));
    glVertex3f(-(w div 2), 0, (h div 2));

    glVertex3f((w div 2), 0, (h div 2));
    glVertex3f((w div 2), 0, -(h div 2));


   glEnd;
end;

//===========================================================
procedure teren;
var
  zerox, zeroy, x, y : integer;
  pom : variant;
  wysrz : integer;
  obl : real;
  px, py : integer;

Begin

 if s=1 then
  Begin
   px:=2; py:=2;
  end
 else
  Begin
   px:=1; py:=1;
  end;

 zerox:=-(w div 2);
 zeroy:=-(h div 2);

 for y:=py to ((h div s)-s) do
   Begin

    for x:=px to ((w div s)-s) do
     Begin
     if trybw='wypelnienie' then glBegin(GL_QUADS);
     //glBegin(GL_LINE_LOOP);  //siatka
     if trybw='siatka' then glBegin(GL_LINE_STRIP);   //siatka

 //====================================================================
      Ustaw_kolor(tabcyf[(x*s)+s,(y*s)]);
      obl:=tabcyf[(x*s)+s,(y*s)]/skala;
      pom:=obl; wysrz:=pom;
      glVertex3d(zerox+(x*s)+s, wysrz, zeroy+(y*s));
 //====================================================================
      Ustaw_kolor(tabcyf[(x*s),(y*s)]);
      obl:=tabcyf[(x*s),(y*s)]/skala;
      pom:=obl; wysrz:=pom;
      glVertex3d(zerox+(x*s), wysrz, zeroy+(y*s));
 //====================================================================
      Ustaw_kolor(tabcyf[(x*s),(y*s)+s]);
      obl:=tabcyf[(x*s),(y*s)+s]/skala;
      pom:=obl; wysrz:=pom;
      glVertex3d(zerox+(x*s), wysrz, zeroy+(y*s)+s);
 //====================================================================
      Ustaw_kolor(tabcyf[(x*s)+s,(y*s)+s]);
      obl:=tabcyf[(x*s)+s,(y*s)+s]/skala;
      pom:=obl; wysrz:=pom;
      glVertex3d(zerox+(x*s)+s, wysrz, zeroy+(y*s)+s);
 //====================================================================
      glEnd;
     end;

   end;

end;
//===========================================================

end.
