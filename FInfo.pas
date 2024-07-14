unit FInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    UnicodeMemo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses main;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
    info:=UnicodeMemo1.Text;
    isedited:=true;
    close;
end;

end.
