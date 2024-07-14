unit FFloatEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm28 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form28: TForm28;
  MyFload:array[0..499] of single;
  FloatCount:integer;

implementation

uses main;

{$R *.dfm}

procedure TForm28.Button1Click(Sender: TObject);
begin
    modalresult:=0;
    close;
end;

procedure TForm28.Button2Click(Sender: TObject);
var x:integer;
begin
    FloatCount:=0;
    for x:=0 to 499 do begin
        if stringgrid1.Cells[1,x] <> '' then try
            MyFload[FloatCount]:=strtofloat(stringgrid1.Cells[1,x]);
            inc(FloatCount);
        except
            Showmessage(getlanguagestring(128)+inttostr(x+1));
            exit;
        end;
    end;
    isedited:=true;
    modalresult:=1;
end;

end.
