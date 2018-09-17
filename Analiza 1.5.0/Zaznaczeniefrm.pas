unit Zaznaczeniefrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons;

type
  TZaznaczenie = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    od1: TEdit;
    Label6: TLabel;
    do1: TEdit;
    Label7: TLabel;
    od2: TEdit;
    Label8: TLabel;
    do2: TEdit;
    Label9: TLabel;
    od3: TEdit;
    Label10: TLabel;
    do3: TEdit;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure zakresy(mini, maxi : integer);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Zaznaczenie: TZaznaczenie;
  min, max : integer;

implementation

uses OknoGl;

{$R *.dfm}

procedure TZaznaczenie.zakresy(mini, maxi : integer);
Begin
 min := mini;
 max := maxi;
end;

procedure TZaznaczenie.SpeedButton1Click(Sender: TObject);
begin
if (StrToInt(Edit1.Text)>=min) and (StrToInt(Edit2.Text)<=max) then
 Begin
  AGlowne.ZaznaczOdDo(StrToInt(Edit1.Text),StrToInt(Edit2.Text));
 end
else ShowMessage('Podane zakresy wychodz¹ poza skale mapy!');
end;

procedure TZaznaczenie.SpeedButton2Click(Sender: TObject);
Var
 od1i, do1i, od2i, do2i, od3i, do3i : integer;
begin
 od1i:=StrToInt(od1.Text); do1i:=StrToInt(do1.Text);
 od2i:=StrToInt(od2.Text); do2i:=StrToInt(do2.Text);
 od3i:=StrToInt(od3.Text); do3i:=StrToInt(do3.Text);
 if (od1i>=min) and (do1i<=max) and (od2i>=min) and (do2i<=max) and
    (od3i>=min) and (do3i<=max) then
    Begin
     AGlowne.ZaznaczOdDo2(od1i,do1i,od2i,do2i,od3i,do3i);
    end
  else ShowMessage('Podane zakresy wychodz¹ poza skale mapy!');
end;

end.
