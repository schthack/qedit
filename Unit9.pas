unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin;

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
begin
    if combobox1.ItemIndex > -1 then begin
        tag:=1;
        close;
    end;
end;

procedure TForm9.ComboBox1Change(Sender: TObject);
var hs:tmemorystream;
begin
    hs:=tmemorystream.Create;
    if fileexists(path+'img\msel\'+ ComboBox1.Text+'.bmp') then
        image1.Picture.LoadFromFile(path+'img\msel\'+ ComboBox1.Text+'.bmp')
    else if PikaGetFile(hs,'msel\'+ComboBox1.Text+'.bmp',path+'images.ppk','Build By Schthack') = 0 then image1.Picture.Bitmap.LoadFromStream(hs)
    else image1.Canvas.FillRect(image1.Canvas.ClipRect);
    hs.free;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
close;
end;

end.
