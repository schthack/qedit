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

  Const Ep1Name:array[0..58] of string = ('MonthMant',
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
    'DE RO LE (Body)',
    'DE RO LE (Shell)',
    'DE RO LE (Tail Mine)',
    'DRAGON',
    'Sinow Gold',
    'Rag Rappy',
    'AI Rappy',
    'Nano Dragon',
    'Dubchic',
    'Gillchic',
    'Garanz',
    'Dark Gunner',
    'Bul Claw',
    'Claw',
    'VOL OPT (1st Phase Core)',
    'VOL OPT (1st Phase Atack Pillar )',
    'VOL OPT (1st Phase L. Monitor)',
    'VOL OPT (1st Phase Celing Amp)',
    'VOL OPT (2nd Phase Core)',
    'VOL OPT (2nd Phase Floor Trap)',
    'Pofuilly Slime',
    'Pan Arms',
    'Hidoom',
    'Migium',
    'Pouilly Slime',
    'Darvant (Mine Field)',
    'DARK FALZ (Phase 1)',
    'DARK FALZ (Phase 2)',
    'DARK FALZ (Phase 3)',
    'Darvant (Phase 2 Ult)',
    'Dubswitch',
    'HildeBear',
    'HildeBlue',
    'Booma',
    'Go Booma',
    'Gigo Booma',
    'Grass Assasin',
    'Evil Shark',
    'Pal Shark',
    'Guil Shark',
    'Del Saber',
    'Dimenian',
    'La Dimenian',
    'So Dimenian'
    );

    Ep2Name:array[0..58] of string = (    'Mothmant',
    'Monest',
    'Savage Wolf',
    'Barbarous Wolf',
    'Poison Lily',
    'Nar Lily',
    'Sinow Berill',
    'Gee',
    'Chaos Sorceror',
    'Bee R',
    'Bee L',
    'Delbiter',
    'Dark Belra',
    'Barba Ray',
    'Pig Ray',
    'Ul Ray',
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
    'Olga Flow Phase 1',
    'Olga Flow Phase 2',
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

    Ep1PhysID:array[0..58] of byte = (0,1,2,3,4,5,6,7,8,9,$0a,$0b,$0c,$0d,$0e,$0f,$10,$11,$12,$13
        ,$18,$19,$1a,$1b,$1c,$1d,$1e,$1f,$20,$21,$22,$23,$24,$25,$26
        ,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39
        ,$48,$49,$4a,$4b,$4c,$4d,$4e,$4f,$50,$51,$52,$53,$54,$55);

    Ep2PhysID:array[0..58] of byte = (0,1,2,3,4,5,6,7,10,11,12,13,14,15,16,17,18,19,24,25,26,27,28,29,30,35,36,37,38,
    43,44,45,46,48,49,50,51,58,59,60,61,64,65,66,67,68,69,70,73,74,75,76,78,79,80,82,83,84,85
        );

var
  Form22: TForm22;
  SelDBSTAT:TEnemyStat;
  SelDBRes:TEnemyELD;
  SelDBAtt:TEnemySection3;
  SelDBMov:TEnemySection4;
  DBSTAT:array[0..5,0..3,0..95] of TEnemyStat;
  DBs3:array[0..5,0..3,0..95] of TEnemySection3;
  DBs4:array[0..5,0..3,0..95] of TEnemySection4;
  DBs2:array[0..5,0..3,0..95] of TEnemyELD;
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
    end else begin
        combobox3.Clear;
        for x:=0 to 58 do
            combobox3.Items.Add(Ep2Name[x]);
        combobox3.ItemIndex:=0;
    end;
end;

procedure TForm22.Button1Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm22.Button2Click(Sender: TObject);
var z:integer;
begin
    for z:=0 to 58 do begin
        if (combobox1.ItemIndex < 4)
        and (Ep1Name[z] = combobox3.Text) then break;
        if (combobox1.ItemIndex >= 4)
        and (Ep2Name[z] = combobox3.Text) then break;
    end;
    if combobox1.ItemIndex < 4 then begin
        move(DBSTAT[combobox1.Itemindex,combobox2.Itemindex,Ep1PhysID[z]],SelDBSTAT,36);
        move(DBs2[combobox1.Itemindex,combobox2.Itemindex,Ep1PhysID[z]], SelDBRes,sizeof(SelDBRes));
        move(DBs3[combobox1.Itemindex,combobox2.Itemindex,Ep1PhysID[z]], SelDBAtt,sizeof(SelDBAtt));
        move(DBs4[combobox1.Itemindex,combobox2.Itemindex,Ep1PhysID[z]], SelDBMov,sizeof(SelDBMov));
    end else begin
        move(DBSTAT[combobox1.Itemindex,combobox2.Itemindex,Ep2PhysID[z]],SelDBSTAT,36);
        move(DBs2[combobox1.Itemindex,combobox2.Itemindex,Ep2PhysID[z]], SelDBRes,sizeof(SelDBRes));
        move(DBs3[combobox1.Itemindex,combobox2.Itemindex,Ep2PhysID[z]], SelDBAtt,sizeof(SelDBAtt));
        move(DBs4[combobox1.Itemindex,combobox2.Itemindex,Ep2PhysID[z]], SelDBMov,sizeof(SelDBMov));
    end;
    modalresult:=1;
end;

end.
