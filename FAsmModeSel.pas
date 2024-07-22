unit FAsmModeSel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm34 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form34: TForm34;

implementation

{$R *.dfm}

uses main;

procedure TForm34.Button1Click(Sender: TObject);
begin
  asmmode := 0;
  close;
end;

procedure TForm34.Button2Click(Sender: TObject);
begin
  asmmode := 2;
  close;
end;

end.
