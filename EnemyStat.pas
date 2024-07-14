unit EnemyStat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TEnemyStat = Record
     ATP,MST,EVP,HP,DFP,ATA,LCK,ESP:word;
     R1,R2:single;
     Tech,EXP,TP:dword;
  end;
  TEnemySection4 = Record
      f1,f2,f3,f4,f5,f6:single;
      v1,v2,v3,v4,v5,v6:dword;
  end;
  TEnemySection3 = Record
      v1,v2,v3,v4:word;
      f1:single;
      v5,v6:word;
      f2:single;
      unused:array[0..6] of dword;
  end;
  TEnemyELD = Record
      zero:word;
      EFR,EIC,ETH,ELT,EDK:word;
      unused:array[0..4] of dword;
  end;
  TForm21 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure FormShow2(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form21: TForm21;
  EnemyStatData:TEnemyStat;

implementation

uses Unit22, main;

{$R *.dfm}

procedure TForm21.FormShow2(Sender: TObject);
begin
    StringGrid1.Cells[0,0]:='ATP';
    StringGrid1.Cells[0,1]:='MST';
    StringGrid1.Cells[0,2]:='ATA';
    StringGrid1.Cells[0,3]:='DFP';
    StringGrid1.Cells[0,4]:='HP';

    StringGrid2.Cells[0,0]:='EVP';
    StringGrid2.Cells[0,1]:='ESP';
    StringGrid2.Cells[0,2]:='LCK';
    StringGrid2.Cells[0,3]:='TP';
    StringGrid2.Cells[0,4]:='EXP';

    StringGrid3.Cells[0,0]:=getlanguagestring(114);
    StringGrid3.Cells[1,0]:=getlanguagestring(115);
    StringGrid3.Cells[2,0]:='Tech';
    Combobox1.ItemIndex:=EnemyStatData.Tech;

    StringGrid1.Cells[1,0]:=inttostr(EnemyStatData.ATP);
    StringGrid1.Cells[1,1]:=inttostr(EnemyStatData.MST);
    StringGrid1.Cells[1,2]:=inttostr(EnemyStatData.ATA);
    StringGrid1.Cells[1,3]:=inttostr(EnemyStatData.DFP);
    StringGrid1.Cells[1,4]:=inttostr(EnemyStatData.HP);

    StringGrid2.Cells[1,0]:=inttostr(EnemyStatData.EVP);
    StringGrid2.Cells[1,1]:=inttostr(EnemyStatData.ESP);
    StringGrid2.Cells[1,2]:=inttostr(EnemyStatData.LCK);
    StringGrid2.Cells[1,3]:=inttostr(EnemyStatData.TP);
    StringGrid2.Cells[1,4]:=inttostr(EnemyStatData.EXP);

    StringGrid3.Cells[0,1]:=Floattostr(EnemyStatData.R1);
    StringGrid3.Cells[1,1]:=Floattostr(EnemyStatData.R2);


end;

procedure TForm21.Button2Click(Sender: TObject);
begin
    EnemyStatData.Tech:=Combobox1.ItemIndex;

    EnemyStatData.ATP:=strtoint(StringGrid1.Cells[1,0]);
    EnemyStatData.MST:=strtoint(StringGrid1.Cells[1,1]);
    EnemyStatData.ATA:=strtoint(StringGrid1.Cells[1,2]);
    EnemyStatData.DFP:=strtoint(StringGrid1.Cells[1,3]);
    EnemyStatData.HP:=strtoint(StringGrid1.Cells[1,4]);

    EnemyStatData.EVP:=strtoint(StringGrid2.Cells[1,0]);
    EnemyStatData.ESP:=strtoint(StringGrid2.Cells[1,1]);
    EnemyStatData.LCK:=strtoint(StringGrid2.Cells[1,2]);
    EnemyStatData.TP:=strtoint(StringGrid2.Cells[1,3]);
    EnemyStatData.EXP:=strtoint(StringGrid2.Cells[1,4]);

    EnemyStatData.R1:=Strtofloat(StringGrid3.Cells[0,1]);
    EnemyStatData.R2:=Strtofloat(StringGrid3.Cells[1,1]);

    modalresult:=1;
end;

procedure TForm21.Button3Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm21.Button1Click(Sender: TObject);
begin
    if form22.showmodal = 1 then begin
         move(SelDBStat,EnemyStatData,36);
         FormShow2(form21);
    end;
end;

end.
