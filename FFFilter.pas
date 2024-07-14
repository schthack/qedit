unit FFFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm30 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form30: TForm30;

implementation

uses main;

{$R *.dfm}

procedure TForm30.Button2Click(Sender: TObject);
begin
    close;
end;

procedure TForm30.Button1Click(Sender: TObject);
begin
    ffilter:=combobox1.itemindex;
    close;
end;

end.
