unit FSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    SpinEdit1: TSpinEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

uses main;

{$R *.dfm}

procedure TForm6.Button1Click(Sender: TObject);
begin
    qnum:=SpinEdit1.Value;
    Language:=ComboBox1.ItemIndex;
    isedited:=true;
    close;
end;

end.
