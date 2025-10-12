unit FEnemyAttack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, EnemyStat;

type
  TForm25 = class(TForm)
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow2(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form25: TForm25;
  EnemyAttackData:TEnemySection3;

implementation

uses Unit22, main;

{$R *.dfm}

procedure TForm25.Button2Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm25.Button1Click(Sender: TObject);
begin
    if form22.showmodal = 1 then begin
         move(SelDBAtt,EnemyAttackData,sizeof(EnemyAttackData));
         FormShow2(form25);
    end;
end;

procedure TForm25.Button3Click(Sender: TObject);
begin
     EnemyAttackData.v1:=strtoint(stringgrid1.Cells[1,0]);
     EnemyAttackData.v2:=strtoint(stringgrid1.Cells[1,1]);
     EnemyAttackData.v3:=strtoint(stringgrid1.Cells[1,2]);
     EnemyAttackData.v4:=strtoint(stringgrid1.Cells[1,3]);
     EnemyAttackData.f1:=strtofloat(stringgrid2.Cells[1,0]);
     EnemyAttackData.v5:=strtoint(stringgrid2.Cells[1,1]);
     EnemyAttackData.v6:=strtoint(stringgrid2.Cells[1,2]);
     EnemyAttackData.f2:=strtofloat(stringgrid2.Cells[1,2]);
     isedited:=true;
     modalresult:=1;
end;

procedure TForm25.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if form22.lblAttack.Visible then
    begin
      form22.lblAttack.Top := form22.Label2.Top - 32;
      form22.cbAttack.Top := form22.ComboBox3.Top - 32;
      form22.Button1.Top := form22.Button1.Top - 32;
      form22.Button2.Top := form22.Button2.Top - 32;
      form22.ClientHeight := form22.ClientHeight - 32;

      form22.lblAttack.Visible := false;
      form22.cbAttack.Visible := false;
    end;
end;

procedure TForm25.FormShow2(Sender: TObject);
begin
    stringgrid1.Cells[1,0]:=inttostr(EnemyAttackData.v1);
    stringgrid1.Cells[1,1]:=inttostr(EnemyAttackData.v2);
    stringgrid1.Cells[1,2]:=inttostr(EnemyAttackData.v3);
    stringgrid1.Cells[1,3]:=inttostr(EnemyAttackData.v4);
    stringgrid2.Cells[1,0]:=floattostr(EnemyAttackData.f1);
    stringgrid2.Cells[1,1]:=inttostr(EnemyAttackData.v5);
    stringgrid2.Cells[1,2]:=inttostr(EnemyAttackData.v6);
    stringgrid2.Cells[1,3]:=floattostr(EnemyAttackData.f2);
    stringgrid1.Cells[0,0]:='Bonus ATP';
    stringgrid1.Cells[0,1]:='Max +ATP';
    stringgrid1.Cells[0,2]:='Bonus ATA';
    stringgrid1.Cells[0,3]:='Max +ATA';
    stringgrid2.Cells[0,0]:='Range X';
    stringgrid2.Cells[0,1]:='Angle';
    stringgrid2.Cells[0,2]:='Unknown';
    stringgrid2.Cells[0,3]:='Range Y';
end;

end.
