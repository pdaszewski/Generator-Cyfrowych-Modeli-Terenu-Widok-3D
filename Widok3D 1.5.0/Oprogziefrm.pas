unit Oprogziefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, Okno3d;

type
  TOprogzie = class(TForm)
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Oprogzie: TOprogzie;

implementation

{$R *.dfm}

procedure TOprogzie.FormShow(Sender: TObject);
begin
 Label4.Caption:='Wersja oprogramowania: '+Okno3d.wersja;
end;

procedure TOprogzie.SpeedButton1Click(Sender: TObject);
begin
Close;
end;

end.
