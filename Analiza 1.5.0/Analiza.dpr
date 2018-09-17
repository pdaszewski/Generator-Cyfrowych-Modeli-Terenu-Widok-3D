program Analiza;

uses
  Forms,
  OknoGl in 'OknoGl.pas' {AGlowne},
  MapaCfrm in 'MapaCfrm.pas' {MapaCyfr},
  Postepfrm in 'Postepfrm.pas' {Postep},
  Statystykifrm in 'Statystykifrm.pas' {Statystyki},
  Zaznaczeniefrm in 'Zaznaczeniefrm.pas' {Zaznaczenie},
  Oprogziefrm in 'Oprogziefrm.pas' {Oprogzie},
  Odlegloscfrm in 'Odlegloscfrm.pas' {Odleglosc};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Analiza';
  Application.CreateForm(TAGlowne, AGlowne);
  Application.CreateForm(TMapaCyfr, MapaCyfr);
  Application.CreateForm(TPostep, Postep);
  Application.CreateForm(TStatystyki, Statystyki);
  Application.CreateForm(TZaznaczenie, Zaznaczenie);
  Application.CreateForm(TOprogzie, Oprogzie);
  Application.CreateForm(TOdleglosc, Odleglosc);
  Application.Run;
end.
