unit Unit23;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm23 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    myresult:dword;
  end;

var
  Form23: TForm23;

implementation

uses Unit22;

{$R *.dfm}

procedure TForm23.Button2Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm23.FormShow(Sender: TObject);
var x:integer;
begin
    if tag =0 then begin
        combobox1.Clear;
        for x:=0 to 58 do
            combobox1.Items.Add(Ep1Name[x]);
        combobox1.ItemIndex:=0;
    end else begin
        combobox1.Clear;
        for x:=0 to 58 do
            combobox1.Items.Add(Ep2Name[x]);
        combobox1.ItemIndex:=0;
    end;
end;

procedure TForm23.Button1Click(Sender: TObject);
var z:integer;
begin
    for z:=0 to 58 do begin
        if (tag = 0)
        and (Ep1Name[z] = combobox1.Text) then break;
        if (tag = 1)
        and (Ep2Name[z] = combobox1.Text) then break;
    end;
    if tag = 0 then
        myresult:=Ep1PhysID[z]
    else myresult:=Ep2PhysID[z];
    modalresult:=1;
end;

end.
