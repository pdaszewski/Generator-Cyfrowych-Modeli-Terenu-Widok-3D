unit Statystykifrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TStatystyki = class(TForm)
    Label1: TLabel;
    Lpowierzchnia: TLabel;
    Label2: TLabel;
    LDlugosc: TLabel;
    Label4: TLabel;
    LSzerokosc: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    LDepresji: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LNizin: TLabel;
    Label6: TLabel;
    LWyzyn: TLabel;
    Label11: TLabel;
    LGor: TLabel;
    Label9: TLabel;
    LGlegokosc: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    LSzczyt: TLabel;
    Label15: TLabel;
    Lwys: TLabel;
    Label17: TLabel;
    Lwyslad: TLabel;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Statystyki: TStatystyki;

implementation

{$R *.dfm}

end.
