unit FRotation;

interface

uses
  Registry, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ExtCtrls, Vcl.Styles, Vcl.Themes;

type
  TfmRotation = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    Image1: TImage;
    chkAutoAxis: TCheckBox;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure chkAutoAxisMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Procedure DrawRotation(Rot:word);

var
  fmRotation: TfmRotation;

implementation

uses main;

{$R *.dfm}

Procedure DrawRotation(Rot:word);
var rt:word;
    px2,px3,py2,py3:single;
begin
    fmRotation.image1.Canvas.Brush.Color:=TStyleManager.ActiveStyle.GetSystemColor(clBtnFace);
    fmRotation.image1.Canvas.FillRect(fmRotation.image1.Canvas.ClipRect);

    fmRotation.image1.Canvas.Brush.Color:=$008000;
    fmRotation.image1.Canvas.Chord(7,5,97,90,90,5,90,5);

    fmRotation.image1.Canvas.Brush.Color:=$01D2FF;
    fmRotation.image1.Canvas.Chord(45,41,60,55,0,0,0,0);

    rt:=rot;
    px2:=0;
    py2:=41;
    px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
    py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
    fmRotation.image1.Canvas.PenPos:=point(52+round(px3),48+round(py3));
    px2:=5;
    py2:=20;
    px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
    py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
    fmRotation.image1.Canvas.lineto(52+round(px3),48+round(py3));
    px2:=-5;
    py2:=20;
    px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
    py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
    fmRotation.image1.Canvas.lineto(52+round(px3),48+round(py3));
    px2:=0;
    py2:=41;
    px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
    py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
    fmRotation.image1.Canvas.lineto(52+round(px3),48+round(py3));

    px2:=0;
    py2:=31;
    px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
    py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
    fmRotation.image1.Canvas.FloodFill(52+round(px3),48+round(py3),$008000,fsSurface);
end;

procedure TfmRotation.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmRotation.btnOKClick(Sender: TObject);
begin
  modalresult := 1;
end;

procedure TfmRotation.chkAutoAxisMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteBool('AutoAxis', chkAutoAxis.Checked);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

procedure TfmRotation.FormShow(Sender: TObject);
begin
  DrawRotation(placerotation);
end;

procedure TfmRotation.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,diff,diffmin,closest,sx,sy,rt,xx,yy:integer;
    t:tstringlist;
    rtvalues: Array of integer;
begin
    // Static values for precise rotation
    rtvalues := [0, 4096, 8192, 12288, 16384, 20480, 24576, 28672,
                32768, 36864, 40960, 45056, 49152, 53248, 57344, 65536];
    sx:=x-52;
    sy:=y-48;
    if (sx<>0) and (sy<>0) then begin
    if (sx>0) and (sy>0) then begin
        if sx>sy then rt:=$4000-round(sy/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835)
        else rt:=round(sx/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835);
    end;

    if (sx>0) and (sy<0) then begin
        if abs(sx)>abs(sy) then rt:=$4000-round(sy/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835)
        else rt:=$8000-round(sx/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835);
    end;

    if (sx<0) and (sy<0) then begin
        if abs(sx)>abs(sy) then rt:=$C000+round(sy/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835)
        else rt:=$8000-round(sx/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835);
    end;

    if (sx<0) and (sy>0) then begin
        if abs(sx)>abs(sy) then rt:=$C000+round(sy/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835)
        else rt:=$10000+round(sx/(sqrt(sqr(sx)+sqr(sy)) )*10430.37835);
    end;
    end else begin
    if sx = 0 then begin
        if sy>0 then rt:=0
        else rt:=$8000;
    end;


    if sy = 0 then begin
        if sx>0 then rt:=$4000
        else rt:=$C000;
    end;
    end;


    if chkAutoAxis.Checked then
    begin
      // Find the closest rotation value to the user's selection
      closest := rtvalues[0];
      diffmin := abs(rtvalues[0] - rt);
      for i := 0 to High(rtvalues) do
      begin
        diff := abs(rt - rtvalues[i]);
        if diff < diffmin then
        begin
          diffmin := diff;
          closest := i;
        end;
      end;
      // Set the new value
      rt := rtvalues[closest];
    end;

    DrawRotation(-rt);//-()*10430.37835));

    // Save the base rotation
    placerotation := -rt;

    //52,48
end;

end.
