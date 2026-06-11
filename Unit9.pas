unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, ShellApi;

type
  TForm9 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

uses Unit1, main, PikaPackage;

{$R *.dfm}

procedure TForm9.Button1Click(Sender: TObject);
var
  idx: integer;
begin
    idx := form1.PartialSearch(ComboBox1.items, ComboBox1.Text);
    ComboBox1.ItemIndex := idx;
    ComboBox1.Text := ComboBox1.Items[ComboBox1.Items.IndexOf(ComboBox1.Text)];
    if combobox1.ItemIndex > -1 then begin
        tag:=1;
        close;
    end;
end;

procedure TForm9.ComboBox1Change(Sender: TObject);
var
  hs:tmemorystream;
  s: string;
  idx: integer;
begin
    hs:=tmemorystream.Create;
    idx := form1.PartialSearch(ComboBox1.items, ComboBox1.Text);
    s := ComboBox1.Items[idx];
    if fileexists(path+'img\msel\'+ s+'.bmp') then
        image1.Picture.LoadFromFile(path+'img\msel\'+ s +'.bmp')
    else if PikaGetFile(hs,'msel\'+s+'.bmp',path+'images.ppk','Build By Schthack') = 0 then image1.Picture.Bitmap.LoadFromStream(hs)
    else image1.Canvas.FillRect(image1.Canvas.ClipRect);
    hs.free;
end;

procedure TForm9.ComboBox1KeyUp(Sender: TObject; var Key: Word;
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

procedure TForm9.Button2Click(Sender: TObject);
begin
close;
end;

end.
