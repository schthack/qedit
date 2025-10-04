unit Unit22;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Enemystat;

type

  TForm22 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Const Ep1Name:array[0..58] of string = ('Mothmant',
    'Monest',
    'Savage Wolf',
    'Barbarous Wolf',
    'Poison Lily',
    'Nar Lily',
    'Sinow Beat',
    'Canadine (Solo)',
    'Canadine (Ring)',
    'Canane',
    'Chaos Sorcerer',
    'Bee R',
    'Bee L',
    'Chaos Bringer',
    'Dark Belra',
    'De Rol Le (Body)',
    'De Rol Le (Shell)',
    'De Rol Le (Tail Mine)',
    'Dragon',
    'Sinow Gold',
    'Rag Rappy',
    'Al Rappy',
    'Nano Dragon',
    'Dubchic',
    'Gillchic',
    'Garanz',
    'Dark Gunner',
    'Bulclaw',
    'Claw',
    'Vol Opt (Phase 1 Core)',
    'Vol Opt (Phase 1 Pillar)',
    'Vol Opt (Phase 1 Monitor)',
    'Vol Opt (Phase 1 Spire)',
    'Vol Opt (Phase 2 Core)',
    'Vol Opt (Phase 2 Prison)',
    'Pofuilly Slime',
    'Pan Arms',
    'Hidoom',
    'Migium',
    'Pouilly Slime',
    'Darvant (Mine Field)',
    'Dark Falz (Phase 1)',
    'Dark Falz (Phase 2)',
    'Dark Falz (Phase 3)',
    'Darvant (Phase 2 Ult)',
    'Dubwitch',
    'Hildebear',
    'Hildeblue',
    'Booma',
    'Gobooma',
    'Gigobooma',
    'Grass Assasin',
    'Evil Shark',
    'Pal Shark',
    'Guil Shark',
    'Delsaber',
    'Dimenian',
    'La Dimenian',
    'So Dimenian'
    );

    Ep2Name:array[0..60] of string = (    'Mothmant',
    'Monest',
    'Savage Wolf',
    'Barbarous Wolf',
    'Poison Lily',
    'Nar Lily',
    'Sinow Berill',
    'Gee',
    'Pig Ray',
    'Ul Ray',
    'Chaos Sorceror',
    'Bee R',
    'Bee L',
    'Delbiter',
    'Dark Belra',
    'Barba Ray',
    'Barba Ray Part',
    'Gol Dragon',
    'Sinow Spigell',
    'Rag Rappy',
    'Love Rappy',
    'Gi Gue',
    'Dubchic',
    'Gillchic',
    'Garanz',
    'Gal Gryphon',
    'Epsilon',
    'Epsigard',
    'Del Lily',
    'Ill Gill',
    'Olga Flow (Phase 1)',
    'Olga Flow (Phase 2)',
    'Gael',
    'Giel',
    'Deldepth',
    'Pan Arms',
    'Hidoom',
    'Migium',
    'Mericarol',
    'Ul Gibbon',
    'Zol Gibbon ',
    'Gibbles',
    'Morfos',
    'Recobox',
    'Recon',
    'Sinow Zoa',
    'Sinow Zele',
    'Merikle',
    'Mericus',
    'Dubwitch',
    'Hildebear',
    'Hildeblue',
    'Merillia',
    'Meriltas',
    'Grass Assassin',
    'Dolmolm',
    'Dolmdarl',
    'Delsaber',
    'Dimenian',
    'La Dimenian',
    'So Dimenian'
    );

    Ep4Name:array[0..35] of string = ('Boota',
    'Ze Boota',
    'Ba Boota',
    'Sand Rappy (Crater)',
    'Del Rappy (Crater)',
    'Zu (Crater)',
    'Pazuzu (Crater)',
    'Astark',
    'Satellite Lizard (Crater)',
    'Yowie (Crater)',
    'Dorphon',
    'Dorphon Eclair',
    'Goran',
    'Pyro Goran',
    'Goran Detonator',
    'Sand Rappy (Desert)',
    'Del Rappy (Desert)',
    'Merissa A',
    'Merissa AA',
    'Zu (Desert)',
    'Pazuzu (Desert)',
    'Satellite Lizard (Desert)',
    'Yowie (Desert)',
    'Girtablulu',
    'Saint-Milion (Phase 1)',
    'Spinner (Saint-Milion 1)',
    'Saint-Milion (Phase 2)',
    'Spinner (Saint-Milion 2)',
    'Shambertin (Phase 1)',
    'Spinner (Shambertin 1)',
    'Shambertin (Phase 2)',
    'Spinner (Shambertin 2)',
    'Kondrieu (Phase 1)',
    'Spinner (Kondrieu 1)',
    'Kondrieu (Phase 2)',
    'Spinner (Kondrieu 2)'
    );

  Ep1PhysID: array[0..58] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09,
    $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13,
    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21,
    $22, $23, $24, $25, $26, $30, $31, $32, $33, $34,
    $35, $36, $37, $38, $39, $48, $49, $4A, $4B, $4C,
    $4D, $4E, $4F, $50, $51, $52, $53, $54, $55
  );

  Ep2PhysID: array[0..60] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09,
    $0A, $0B, $0C, $0D, $0E, $0F, $10, $12, $13, $18,
    $19, $1A, $1B, $1C, $1D, $1E, $23, $24, $25, $26,
    $2B, $2C, $2D, $2E, $30, $31, $32, $33, $3A, $3B,
    $3C, $3D, $40, $41, $42, $43, $44, $45, $46, $48,
    $49, $4A, $4B, $4C, $4E, $4F, $50, $52, $53, $54,
    $55
  );

  Ep4PhysID: array[0..35] of Byte = (
    $00, $01, $03, $05, $06, $07, $08, $09, $0D, $0E,
    $0F, $10, $11, $12, $13, $17, $18, $19, $1A, $1B,
    $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25,
    $26, $27, $28, $29, $2A, $2B
  );

  Ep1ResistID: array[0..58] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09,
    $0A, $0B, $0C, $0D, $0E, $0F, $10, $11, $12, $13,
    $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21,
    $22, $23, $24, $25, $26, $30, $31, $32, $33, $34,
    $35, $36, $37, $38, $39, $FF, $48, $49, $4A, $4B,
    $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
  );

  Ep2ResistID: array[0..60] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09,
    $0A, $0B, $0C, $0D, $0E, $0F, $10, $12, $13, $18,
    $19, $1A, $1B, $1C, $1D, $1E, $23, $24, $25, $26,
    $2B, $2C, $2D, $2E, $30, $31, $32, $33, $3A, $3B,
    $3C, $3D, $40, $41, $42, $43, $44, $45, $46, $FF,
    $48, $49, $4A, $4B, $4D, $4E, $4F, $51, $52, $53,
    $54
  );

  Ep4ResistID: array[0..35] of Byte = (
    $00, $01, $03, $05, $06, $07, $08, $09, $0D, $0E,
    $0F, $10, $11, $12, $13, $17, $18, $19, $1A, $1B,
    $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25,
    $26, $27, $28, $29, $2A, $2B
  );

  Ep1AttackID: array[0..58] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E,
    $0F, $10, $11, $12, $47, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21,
    $22, $23, $24, $25, $26, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39,
    $FF, $48, $4B, $4E, $4F, $50, $51, $54, $55, $56, $57, $5A, $5B, $5C
  );

  Ep2AttackID: array[0..60] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E,
    $0F, $10, $12, $47, $18, $19, $1A, $1B, $1C, $1D, $1E, $23, $24, $25, $26,
    $2B, $2C, $2D, $2E, $30, $31, $32, $33, $3A, $3B, $3C, $3D, $40, $41, $42,
    $43, $44, $45, $46, $FF, $48, $4B, $4E, $4F, $51, $54, $55, $57, $5A, $5B,
    $5C
  );

  Ep4AttackID: array[0..35] of Byte = (
    $00, $01, $03, $05, $06, $07, $08, $0A, $0D, $0E, $0F, $10, $11, $12, $13,
    $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25,
    $26, $27, $28, $29, $2A, $2B
  );

  const
  Ep1MovementID: array[0..58] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E,
    $0F, $FF, $11, $12, $10, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21,
    $22, $23, $24, $25, $26, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39,
    $FF, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51, $52, $53, $54
  );

  Ep2MovementID: array[0..60] of Byte = (
    $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E,
    $0F, $FF, $12, $10, $18, $19, $1A, $1B, $1C, $1D, $1E, $23, $24, $25, $26,
    $2B, $2C, $2D, $2E, $30, $31, $32, $33, $3A, $3B, $3C, $3D, $40, $41, $42,
    $43, $44, $45, $46, $FF, $48, $49, $4A, $4B, $4D, $4E, $4F, $51, $52, $53,
    $54
  );

  Ep4MovementID: array[0..35] of Byte = (
    $00, $01, $03, $05, $06, $07, $08, $09, $0D, $0E, $0F, $10, $11, $12, $13,
    $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25,
    $26, $27, $28, $29, $2A, $2B
  );

var
  Form22: TForm22;
  SelDBSTAT:TEnemyStat;
  SelDBRes:TEnemyELD;
  SelDBAtt:TEnemySection3;
  SelDBMov:TEnemySection4;
  DBSTAT:array[0..7,0..3,0..95] of TEnemyStat;
  DBs3:array[0..7,0..3,0..95] of TEnemySection3;
  DBs4:array[0..7,0..3,0..95] of TEnemySection4;
  DBs2:array[0..7,0..3,0..95] of TEnemyELD;
  DBinit:byte=0;
implementation

uses main;


{$R *.dfm}


{
 Physical stats
0000 Normal
0D80 Hard
1B00 Vhard
2880 Ult

Attack Section
3600 Normal
4800 Hard
5A00 Vhard
6C00 Ult

Resist Stats
7E00 Normal
8A00 Hard
9600 Vhard
A200 Ult

SPEED/DIRECTION/MOVEMENT SECTION
AE00 NORMAL
C000 HARD
D200 VHARD
E400 ULT
}
procedure TForm22.FormShow(Sender: TObject);
var x:integer;
begin
    if DBinit = 0 then begin
        DBinit:=1;
        x:=fileopen(path+'pc_off.dat',$40);
        fileread(x,DBSTAT[0],$d80*4);
        fileread(x,dbs3[0],sizeof(dbs3[0]));
        fileread(x,dbs2[0],sizeof(dbs2[0]));
        fileread(x,dbs4[0],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'pc_on.dat',$40);
        fileread(x,DBSTAT[1],$d80*4);
        fileread(x,dbs3[1],sizeof(dbs3[0]));
        fileread(x,dbs2[1],sizeof(dbs2[0]));
        fileread(x,dbs4[1],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'1_off.dat',$40);
        fileread(x,DBSTAT[2],$d80*4);
        fileread(x,dbs3[2],sizeof(dbs3[0]));
        fileread(x,dbs2[2],sizeof(dbs2[0]));
        fileread(x,dbs4[2],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'1_on.dat',$40);
        fileread(x,DBSTAT[3],$d80*4);
        fileread(x,dbs3[3],sizeof(dbs3[0]));
        fileread(x,dbs2[3],sizeof(dbs2[0]));
        fileread(x,dbs4[3],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'2_off.dat',$40);
        fileread(x,DBSTAT[4],$d80*4);
        fileread(x,dbs3[4],sizeof(dbs3[0]));
        fileread(x,dbs2[4],sizeof(dbs2[0]));
        fileread(x,dbs4[4],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'2_on.dat',$40);
        fileread(x,DBSTAT[5],$d80*4);
        fileread(x,dbs3[5],sizeof(dbs3[0]));
        fileread(x,dbs2[5],sizeof(dbs2[0]));
        fileread(x,dbs4[5],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'4_off.dat',$40);
        fileread(x,DBSTAT[6],$d80*4);
        fileread(x,dbs3[6],sizeof(dbs3[0]));
        fileread(x,dbs2[6],sizeof(dbs2[0]));
        fileread(x,dbs4[6],sizeof(dbs4[0]));
        fileclose(x);
        x:=fileopen(path+'4_on.dat',$40);
        fileread(x,DBSTAT[7],$d80*4);
        fileread(x,dbs3[7],sizeof(dbs3[0]));
        fileread(x,dbs2[7],sizeof(dbs2[0]));
        fileread(x,dbs4[7],sizeof(dbs4[0]));
        fileclose(x);
        ComboBox1Change(self);
    end;

end;

procedure TForm22.ComboBox1Change(Sender: TObject);
var x:integer;
begin
    if combobox1.ItemIndex < 4 then begin
        combobox3.Clear;
        for x:=0 to 58 do
            combobox3.Items.Add(Ep1Name[x]);
        combobox3.ItemIndex:=0;
    end else if (combobox1.ItemIndex >= 4)
    and (combobox1.ItemIndex < 6) then begin
        combobox3.Clear;
        for x:=0 to 60 do
            combobox3.Items.Add(Ep2Name[x]);
        combobox3.ItemIndex:=0;
    end else begin
      combobox3.Clear;
      for x:=0 to 35 do
          combobox3.Items.Add(Ep4Name[x]);
          combobox3.ItemIndex:=0;
    end
end;

procedure TForm22.Button1Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm22.Button2Click(Sender: TObject);
var z:integer;
begin
    for z:=0 to 60 do begin
        if z <= 58 then
        begin
          if (combobox1.ItemIndex < 4)
          and (Ep1Name[z] = combobox3.Text) then break;
        end;
        if (combobox1.ItemIndex >= 4)
        and (combobox1.ItemIndex < 6)
        and (Ep2Name[z] = combobox3.Text) then break;
        if z <= 35 then
        begin
          if (combobox1.ItemIndex >= 6)
          and (Ep4Name[z] = combobox3.Text) then break;
        end;
    end;
    if combobox1.ItemIndex < 4 then begin
        move(DBSTAT[combobox1.Itemindex,combobox2.Itemindex,Ep1PhysID[z]],SelDBSTAT,36);
        move(DBs2[combobox1.Itemindex,combobox2.Itemindex,Ep1ResistID[z]], SelDBRes,sizeof(SelDBRes));
        move(DBs3[combobox1.Itemindex,combobox2.Itemindex,Ep1AttackID[z]], SelDBAtt,sizeof(SelDBAtt));
        move(DBs4[combobox1.Itemindex,combobox2.Itemindex,Ep1MovementID[z]], SelDBMov,sizeof(SelDBMov));
    end else if (combobox1.ItemIndex >= 4)
    and (combobox1.ItemIndex < 6) then
    begin
        move(DBSTAT[combobox1.Itemindex,combobox2.Itemindex,Ep2PhysID[z]],SelDBSTAT,36);
        move(DBs2[combobox1.Itemindex,combobox2.Itemindex,Ep2ResistID[z]], SelDBRes,sizeof(SelDBRes));
        move(DBs3[combobox1.Itemindex,combobox2.Itemindex,Ep2AttackID[z]], SelDBAtt,sizeof(SelDBAtt));
        move(DBs4[combobox1.Itemindex,combobox2.Itemindex,Ep2MovementID[z]], SelDBMov,sizeof(SelDBMov));
    end
    else
    begin
        move(DBSTAT[combobox1.Itemindex,combobox2.Itemindex,Ep4PhysID[z]],SelDBSTAT,36);
        move(DBs2[combobox1.Itemindex,combobox2.Itemindex,Ep4ResistID[z]], SelDBRes,sizeof(SelDBRes));
        move(DBs3[combobox1.Itemindex,combobox2.Itemindex,Ep4AttackID[z]], SelDBAtt,sizeof(SelDBAtt));
        move(DBs4[combobox1.Itemindex,combobox2.Itemindex,Ep4MovementID[z]], SelDBMov,sizeof(SelDBMov));
    end;
    modalresult:=1;
end;

end.
