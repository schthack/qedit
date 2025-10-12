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
    cbIndexType: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
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

procedure TForm23.ComboBox1Change(Sender: TObject);
var
  i: integer;
  attacktables: TStringList;
begin
  cbIndexType.Clear;
  attacktables := GetAttackTables(ComboBox1.Text);
  cbIndexType.items.Add('Physical');
  cbIndexType.items.Add('Resist');
  if attacktables.Count > 0 then
  begin
    for i := 0 to attacktables.Count - 1 do
      cbIndexType.items.Add(attacktables[i]);
  end;
  cbIndexType.items.Add('Movement');
  cbIndexType.Text := 'Physical';
  attacktables.Free;
end;

procedure TForm23.FormShow(Sender: TObject);
var x:integer;
begin
    if tag =0 then begin
        combobox1.Clear;
        for x:=0 to 58 do
            combobox1.Items.Add(Ep1Name[x]);
        combobox1.ItemIndex:=0;
    end else if tag = 1 then begin
        combobox1.Clear;
        for x:=0 to 60 do
            combobox1.Items.Add(Ep2Name[x]);
        combobox1.ItemIndex:=0;
    end else begin
        combobox1.Clear;
        for x:=0 to 35 do
            combobox1.Items.Add(Ep4Name[x]);
        combobox1.ItemIndex:=0;
    end;
    ComboBox1Change(nil);
end;

procedure TForm23.Button1Click(Sender: TObject);
var z, idx:integer;
begin
    // Find specific attack index
    idx := GetAttackIndex(combobox1.Text, cbIndexType.Text);
    if idx <> -1 then
    begin
      myresult:=idx;
      modalresult:=1;
      exit;
    end;

    for z:=0 to 60 do begin
        if (tag = 0) and (z <= 58)
        and (Ep1Name[z] = combobox1.Text) then break;
        if (tag = 1)
        and (Ep2Name[z] = combobox1.Text) then break;
        if (tag = 2) and (z <= 35)
        and (Ep4Name[z] = combobox1.Text) then break;
    end;

    // Load index type based on selection
    if cbIndexType.ItemIndex = 2 then
    begin
      if tag = 0 then
          myresult:=Ep1ResistID[z]
      else if tag = 1 then myresult:=Ep2ResistID[z]
      else myresult:=Ep4ResistID[z];
    end
    else if cbIndexType.ItemIndex = 3 then
    begin
      if tag = 0 then
          myresult:=Ep1AttackID[z]
      else if tag = 1 then myresult:=Ep2AttackID[z]
      else myresult:=Ep4AttackID[z];
    end
    else if cbIndexType.ItemIndex = 4 then
    begin
      if tag = 0 then
          myresult:=Ep1MovementID[z]
      else if tag = 1 then myresult:=Ep2MovementID[z]
      else myresult:=Ep4MovementID[z];
    end
    else
    begin
      if tag = 0 then
          myresult:=Ep1PhysID[z]
      else if tag = 1 then myresult:=Ep2PhysID[z]
      else myresult:=Ep4PhysID[z];
    end;

    modalresult:=1;
end;

end.
