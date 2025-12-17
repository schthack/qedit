unit FMonsType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmMonsterType = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  MonsterTypes: array[0..40] of string = (
    'Booma',                        // 0
    'Savage Wolf',                  // 1
    'Rag Rappy',                    // 2
    'Monest',                       // 3
    'Hildebear',                    // 4
    'Grass Assassin',               // 5
    'Poison Lily / Del Lily',       // 6
    'Nano Dragon',                  // 7
    'Evil Shark',                   // 8
    'Pofuilly Slime',               // 9
    'Pan Arms',                     // 10
    'Gilchic',                      // 11
    'Garanz',                       // 12
    'Sinow Blue',                   // 13
    'Canadine',                     // 14
    'Canane',                       // 15
    'Dubswitch',                    // 16
    'Delsaber',                     // 17
    'Chaos Sorcerer',               // 18
    'Dark Gunner',                  // 19
    'Dark Gunner Activator',        // 20
    'Chaos Bringer',                // 21
    'Dark Belra',                   // 22
    'Dimenian',                     // 23
    'Bulclaw',                      // 24
    'Claw',                         // 25
    'Sinow Berill',                 // 26
    'Merillias',                    // 27
    'Mericarol',                    // 28
    'Ul Gibbon',                    // 29
    'Gibbles',                      // 30
    'Gee',                          // 31
    'Gi Gue',                       // 32
    'Deldepth',                     // 33
    'Delbiter',                     // 34
    'Dolmdarl',                     // 35
    'Morfos',                       // 36
    'Reconbox',                     // 37
    'Sinow Zoa',                    // 38
    'Epsilon',                      // 39
    'Ill Gill'                      // 40
  );

var
  fmMonsterType: TfmMonsterType;

implementation

{$R *.dfm}

uses main;

procedure TfmMonsterType.Button1Click(Sender: TObject);
begin
  modalresult := 1;
end;

procedure TfmMonsterType.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMonsterType.FormCreate(Sender: TObject);
var
  i: integer;
  filename: String;
begin
  filename := path + 'm_types.txt';
  // Load names from the file if it exists
  if FileExists(filename) then
  begin
    Combobox1.Items.LoadFromFile(filename);
    Combobox1.ItemIndex := 0;
  end
  else
  begin
    // Create file with default names
    for i := 0 to 40 do
      Combobox1.Items.Add(MonsterTypes[i]);
    Combobox1.Items.SaveToFile(filename);
    Combobox1.ItemIndex := 0;
  end;
end;

end.
