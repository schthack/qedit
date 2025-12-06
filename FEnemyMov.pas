unit FEnemyMov;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, EnemyStat;

type
  TForm26 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow2(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form26: TForm26;
  EnemyMovData:TEnemySection4;

implementation

uses Unit1, Unit22, main;


{$R *.dfm}

procedure TForm26.Button2Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm26.Button1Click(Sender: TObject);
begin
    EnemyMovData.f1:=strtofloat(stringgrid1.Cells[1,0]);
    EnemyMovData.f2:=strtofloat(stringgrid1.Cells[1,1]);
    EnemyMovData.f3:=strtofloat(stringgrid1.Cells[1,2]);
    EnemyMovData.f4:=strtofloat(stringgrid1.Cells[1,3]);
    EnemyMovData.f5:=strtofloat(stringgrid1.Cells[1,4]);
    EnemyMovData.f6:=strtofloat(stringgrid1.Cells[1,5]);
    EnemyMovData.v1:=strtoint(stringgrid2.Cells[1,0]);
    EnemyMovData.v2:=strtoint(stringgrid2.Cells[1,1]);
    EnemyMovData.v3:=strtoint(stringgrid2.Cells[1,2]);
    EnemyMovData.v4:=strtoint(stringgrid2.Cells[1,3]);
    EnemyMovData.v5:=strtoint(stringgrid2.Cells[1,4]);
    EnemyMovData.v6:=strtoint(stringgrid2.Cells[1,5]);
    isedited:=true;
    modalresult:=1;
end;

procedure TForm26.Button3Click(Sender: TObject);
begin
    if form22.showmodal = 1 then begin
         move(SelDBMov,EnemyMovData,sizeof(EnemyMovData));
         FormShow2(form26);
    end;
end;

procedure TForm26.FormShow2(Sender: TObject);
var
  s: ansistring;
begin
    stringgrid1.Cells[1,0]:=floattostr(EnemyMovData.f1);
    stringgrid1.Cells[1,1]:=floattostr(EnemyMovData.f2);
    stringgrid1.Cells[1,2]:=floattostr(EnemyMovData.f3);
    stringgrid1.Cells[1,3]:=floattostr(EnemyMovData.f4);
    stringgrid1.Cells[1,4]:=floattostr(EnemyMovData.f5);
    stringgrid1.Cells[1,5]:=floattostr(EnemyMovData.f6);

    s := inttohex(EnemyMovData.v1);
    stringgrid2.Cells[1,0]:=inttostr(hextosignedint(s,31));
    s := inttohex(EnemyMovData.v2);
    stringgrid2.Cells[1,1]:=inttostr(hextosignedint(s,31));
    s := inttohex(EnemyMovData.v3);
    stringgrid2.Cells[1,2]:=inttostr(hextosignedint(s,31));
    s := inttohex(EnemyMovData.v4);
    stringgrid2.Cells[1,3]:=inttostr(hextosignedint(s,31));
    s := inttohex(EnemyMovData.v5);
    stringgrid2.Cells[1,4]:=inttostr(hextosignedint(s,31));
    s := inttohex(EnemyMovData.v6);
    stringgrid2.Cells[1,5]:=inttostr(hextosignedint(s,31));

    stringgrid1.Cells[0,0]:='NNF1';
    stringgrid1.Cells[0,1]:='NNF2';
    stringgrid1.Cells[0,2]:='NNF3';
    stringgrid1.Cells[0,3]:='NNF4';
    stringgrid1.Cells[0,4]:='NNF5';
    stringgrid1.Cells[0,5]:='NNF6';
    stringgrid2.Cells[0,0]:='NNI1';
    stringgrid2.Cells[0,1]:='NNI2';
    stringgrid2.Cells[0,2]:='NNI3';
    stringgrid2.Cells[0,3]:='NNI4';
    stringgrid2.Cells[0,4]:='NNI5';
    stringgrid2.Cells[0,5]:='NNI6';
end;

end.
