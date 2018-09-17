program Widok3D;

uses
  Forms,
  Okno3D in 'Okno3D.pas' {OknoGL},
  Oprogziefrm in 'Oprogziefrm.pas' {Oprogzie};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Widok 3D';
  Application.CreateForm(TOpenGL, OpenGL);
  Application.CreateForm(TOprogzie, Oprogzie);
  Application.Run;
end.
