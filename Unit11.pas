unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm11 = class(TForm)
    Button1: TButton;
    UnicodeMemo1: TMemo;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

uses main;

{$R *.dfm}

procedure TForm11.Button1Click(Sender: TObject);
begin
    desc:=UnicodeMemo1.text;
    close;
end;

end.
