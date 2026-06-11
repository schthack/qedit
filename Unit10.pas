unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, ExtCtrls, Vcl.Grids;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Panel1: TPanel;
    UnicodeStringGrid1: TStringGrid;
    UnicodeStringGrid2: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

uses D3DEngin, Unit1, main;

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
var
  f: single;
  idx: integer;
begin
    idx := form1.PartialSearch(ComboBox1.items, ComboBox1.Text);
    ComboBox1.ItemIndex := idx;
    ComboBox1.Text := ComboBox1.Items[ComboBox1.Items.IndexOf(ComboBox1.Text)];
    if ComboBox1.ItemIndex > -1 then begin
        if UnicodeStringGrid1.Visible then begin
            f:=strtofloat(UnicodeStringGrid1.Cells[1,0]);
        end;
        if UnicodeStringGrid2.Visible then begin
            f:=strtofloat(UnicodeStringGrid2.Cells[1,0]);
            f:=strtofloat(UnicodeStringGrid2.Cells[1,1]);
            f:=strtofloat(UnicodeStringGrid2.Cells[1,2]);
        end;
        tag:=1;
        close;
    end;
end;

procedure TForm10.Timer1Timer(Sender: TObject);
begin
    if form10.Visible then
    if objscreen <> nil then
    if objscreen.Enable then begin
    objitm.SetRotation(gettickcount / 100,0,0);
    objscreen.RenderSurface;
    end;
end;

procedure TForm10.Button2Click(Sender: TObject);
begin
    close;
end;

procedure TForm10.ComboBox1Change(Sender: TObject);
var x,y,idx:integer;
    t:single;
begin
    idx := form1.PartialSearch(ComboBox1.items, ComboBox1.Text);
    for x:=0 to preseti-1 do
        if lowercase(ObjTemplate[x].name) = lowercase(ComboBox1.Items[idx])
        then break;
    UnicodeStringGrid1.Visible:=false;
    UnicodeStringGrid2.Visible:=false;
    for y:=0 to 11 do
        if ItemRange[y] = ObjTemplate[x].data.Skin then begin
            UnicodeStringGrid1.Visible:=true;
        end;
    for y:=0 to ScaleCount-1 do
        if ScaleItm[y] = ObjTemplate[x].data.Skin then begin
            UnicodeStringGrid2.Visible:=true;
        end;
    if objscreen.Enable then begin
    objitm.Free;
    objitm:=nil;
    objitm:=t3ditem.Create(objscreen);
    Generateobj(ObjTemplate[x].data,-2);
    t:=objitm.GetLargessVertex;
    objscreen.LookAt(0,t/1.4 ,-(t*2),0,t/2,0);
    end;
end;


procedure TForm10.ComboBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s: string;
begin
  if (key = VK_F1) and (ComboBox1.Items.Count > 0) and (ComboBox1.ItemIndex > -1)
  then
  begin
    s := ComboBox1.Items[ComboBox1.Items.IndexOf(ComboBox1.Text)];
    s := StringReplace(s, ' ', '_', [rfReplaceAll]);
    shellexecute(0,'open',pchar('http://qedit.info/index.php?title='+s),'','',0);
  end;
end;

end.
