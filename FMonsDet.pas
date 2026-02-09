unit FMonsDet;

interface

uses
  Winapi.Windows, Winapi.Messages, Registry, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm31 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Copy: TButton;
    Button2: TButton;
    SaveDialog1: TSaveDialog;
    cbShow: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CopyClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure cbShowChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  TBoxListEntry = record
    name:ansistring;
    cnt:integer;
  end;
  TBoxList = record
    entrys:array[0..255] of TBoxListEntry;
    count:integer;
  end;

var
  Form31: TForm31;
  monsterList: array[0..40] of TMonstList;
  boxList: array[0..40] of TBoxList;

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

procedure addbox(name:ansistring; floor:integer);
var i:integer;
begin
    for i:=0 to boxList[floor].count-1 do
      if boxList[floor].entrys[i].name = name then begin
        inc(boxList[floor].entrys[i].cnt);
        exit;
      end;

    i:=boxList[floor].count;
    inc(boxList[floor].count);
    boxList[floor].entrys[i].name := name;
    boxList[floor].entrys[i].cnt:=1;
end;

procedure LoadCounts;
var x,sfloor:integer;
begin
  with form31 do
  begin
    for x:=0 to 40 do monsterList[x].count:=0;
    if (cbShow.ItemIndex = 0) or (cbShow.ItemIndex = 1) then
     begin
    for sfloor:=1 to 39 do
        for x:=0 to Floor[sfloor].MonsterCount-1 do begin
            addmonster(GenerateMonsterName( Floor[sfloor].Monster[x],x,0),sfloor);
            addmonster(GenerateMonsterName( Floor[sfloor].Monster[x],x,0),40);
        end;
     end;

    for x:=0 to 40 do boxList[x].count:=0;
    if (cbShow.ItemIndex = 0) or (cbShow.ItemIndex = 2) then
    begin
    for sfloor:=1 to 39 do
        for x:=0 to Floor[sfloor].ObjCount-1 do begin
          if (Floor[sfloor].Obj[x].Skin = 136) or (Floor[sfloor].Obj[x].Skin = 145)
          or (Floor[sfloor].Obj[x].Skin = 146) or (Floor[sfloor].Obj[x].Skin = 147)
          or (Floor[sfloor].Obj[x].Skin = 149) or (Floor[sfloor].Obj[x].Skin = 353)
          or (Floor[sfloor].Obj[x].Skin = 354) or (Floor[sfloor].Obj[x].Skin = 355)
          or (Floor[sfloor].Obj[x].Skin = 356) or (Floor[sfloor].Obj[x].Skin = 357)
          or (Floor[sfloor].Obj[x].Skin = 512) or (Floor[sfloor].Obj[x].Skin = 515)
          or (Floor[sfloor].Obj[x].Skin = 909) then
          begin
              addBox(GetObjName(Floor[sFloor].Obj[x].Skin),sfloor);
              addBox(GetObjName(Floor[sFloor].Obj[x].Skin),40);
          end;
        end;
    end;

    memo1.Clear;

    for sfloor:=1 to 29 do begin
      if (Floor[sfloor].MonsterCount > 0) or (boxList[sfloor].count > 0) then
        Memo1.Lines.Add(form1.checklistbox1.Items[sfloor]+':');
      if Floor[sfloor].MonsterCount > 0 then begin
          for x:=0 to monsterList[sfloor].count-1 do begin
            Memo1.Lines.Add(#9+inttostr(monsterList[sfloor].entrys[x].cnt)+#9+monsterList[sfloor].entrys[x].name);
          end;
      end;
      if (Floor[sfloor].MonsterCount > 0) and (boxList[sfloor].count > 0)  and (cbshow.itemindex <> 2) then Memo1.Lines.Add('');
      if boxList[sfloor].count > 0 then begin
          for x:=0 to boxList[sfloor].count-1 do begin
            Memo1.Lines.Add(#9+inttostr(boxList[sfloor].entrys[x].cnt)+#9+boxList[sfloor].entrys[x].name);
          end;
      end;
      if (Floor[sfloor].MonsterCount > 0) or (boxList[sfloor].count > 0) then
        Memo1.Lines.Add('');
    end;

    sfloor:=40;
    if (monsterList[sfloor].count > 0) or (boxList[sfloor].count > 0) then
      Memo1.Lines.Add('');
    if monsterList[sfloor].count > 0 then begin
        Memo1.Lines.Add('Total monsters:');
        for x:=0 to monsterList[sfloor].count-1 do begin
          Memo1.Lines.Add(#9+inttostr(monsterList[sfloor].entrys[x].cnt)+#9+monsterList[sfloor].entrys[x].name);
        end;
        Memo1.Lines.Add('');
    end;

    if boxList[sfloor].count > 0 then begin
        Memo1.Lines.Add('Total boxes:');
        for x:=0 to boxList[sfloor].count-1 do begin
          Memo1.Lines.Add(#9+inttostr(boxList[sfloor].entrys[x].cnt)+#9+boxList[sfloor].entrys[x].name);
        end;
    end;

    if (monsterList[sFloor].count <= 0) and (boxList[sFloor].count <= 0) then
        Memo1.Lines.Add(GetLanguageString(326));
  end;
end;

procedure TForm31.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm31.Button2Click(Sender: TObject);
begin
  if savedialog1.Execute then
  begin
    memo1.Lines.SaveToFile(savedialog1.FileName);
  end;
end;

procedure TForm31.cbShowChange(Sender: TObject);
var
  Reg: TRegistry;
begin
  LoadCounts;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('CountFilter', cbShow.ItemIndex);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TForm31.CopyClick(Sender: TObject);
begin
  memo1.SelStart:=0;
  memo1.SelLength:=length(memo1.Text);
  memo1.CopyToClipboard;
end;

procedure TForm31.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

procedure TForm31.FormShow(Sender: TObject);
begin
   LoadCounts;
end;

end.
