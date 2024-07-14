unit FEnemyResist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EnemyStat, StdCtrls, Grids;

type
  TForm24 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow2(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form24: TForm24;
  EnemyResData:TEnemyELD;

implementation

uses Unit22, main;


{$R *.dfm}

procedure TForm24.Button2Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm24.Button3Click(Sender: TObject);
begin
    EnemyResData.EFR:=strtoint(stringgrid1.Cells[1,0]);
    EnemyResData.EIC:=strtoint(stringgrid1.Cells[1,1]);
    EnemyResData.ETH:=strtoint(stringgrid1.Cells[1,2]);
    EnemyResData.ELT:=strtoint(stringgrid1.Cells[1,3]);
    EnemyResData.EDK:=strtoint(stringgrid1.Cells[1,4]);
    isedited:=true;
    modalresult:=1;
end;

procedure TForm24.Button1Click(Sender: TObject);
begin
    if form22.showmodal = 1 then begin
         move(SelDBRes,EnemyResData,sizeof(EnemyResData));
         form24.FormShow2(form24);
    end;
end;


procedure TForm24.FormShow2(Sender: TObject);
begin
    stringgrid1.Cells[1,0]:=inttostr(EnemyResData.EFR);
    stringgrid1.Cells[1,1]:=inttostr(EnemyResData.EIC);
    stringgrid1.Cells[1,2]:=inttostr(EnemyResData.ETH);
    stringgrid1.Cells[1,3]:=inttostr(EnemyResData.ELT);
    stringgrid1.Cells[1,4]:=inttostr(EnemyResData.EDK);
    stringgrid1.Cells[0,0]:='EFR';
    stringgrid1.Cells[0,1]:='EIC';
    stringgrid1.Cells[0,2]:='ETH';
    stringgrid1.Cells[0,3]:='ELT';
    stringgrid1.Cells[0,4]:='EDK';
end;

end.
