unit FMonsDet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm31 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Copy: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CopyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TMonstListEntry = record
    name:ansistring;
    cnt:integer;
  end;
  TMonstList = record
    entrys:array[0..255] of TMonstListEntry;
    count:integer;
  end;

var
  Form31: TForm31;
  monsterList: array[0..40] of TMonstList;

implementation

{$R *.dfm}

uses main, Unit1;

procedure addmonster(name:ansistring; floor:integer);
var i:integer;
begin
    for i:=0 to monsterList[floor].count-1 do
      if monsterList[floor].entrys[i].name = name then begin
        inc(monsterList[floor].entrys[i].cnt);
        exit;
      end;

    i:=monsterList[floor].count;
    inc(monsterList[floor].count);
    monsterList[floor].entrys[i].name := name;
    monsterList[floor].entrys[i].cnt:=1;
end;

procedure TForm31.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm31.CopyClick(Sender: TObject);
begin
  memo1.SelStart:=0;
  memo1.SelLength:=length(memo1.Text);
  memo1.CopyToClipboard;
end;

procedure TForm31.FormShow(Sender: TObject);
var x,sfloor:integer;
begin
    for x:=0 to 40 do monsterList[x].count:=0;
    for sfloor:=1 to 39 do
        for x:=0 to Floor[sfloor].MonsterCount-1 do begin
            addmonster(GenerateMonsterName( Floor[sfloor].Monster[x],x,0),sfloor);
            addmonster(GenerateMonsterName( Floor[sfloor].Monster[x],x,0),40);
        end;

    memo1.Clear;
    for sfloor:=1 to 29 do begin
      if Floor[sfloor].MonsterCount > 0 then begin
          Memo1.Lines.Add(form1.checklistbox1.Items[sfloor]+':');
          for x:=0 to monsterList[sfloor].count-1 do begin
            Memo1.Lines.Add(#9+inttostr(monsterList[sfloor].entrys[x].cnt)+#9+monsterList[sfloor].entrys[x].name);
          end;
          Memo1.Lines.Add('');
          Memo1.Lines.Add('');
      end;
    end;

    sfloor:=40;
    if monsterList[sfloor].count > 0 then begin
        Memo1.Lines.Add('Total:');
        for x:=0 to monsterList[sfloor].count-1 do begin
          Memo1.Lines.Add(#9+inttostr(monsterList[sfloor].entrys[x].cnt)+#9+monsterList[sfloor].entrys[x].name);
        end;
        Memo1.Lines.Add('');
        Memo1.Lines.Add('');
    end else begin
        Memo1.Lines.Add('This quest is so epic that it doesnt need monsters!');
    end;
end;

end.
