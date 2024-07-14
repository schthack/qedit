unit Unit19;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm19 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form19: TForm19;

implementation

uses main;

{$R *.dfm}

procedure TForm19.Button1Click(Sender: TObject);
begin
close;
end;

procedure TForm19.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
    if StringGrid1.EditorMode then exit;
    bbdata[((ARow-1)*14)+ACol+36]:=hextoint(value);
    isedited:=true;
end;

procedure TForm19.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
    if odd(ARow) then
        StringGrid1.Canvas.Brush.Color := rgb (250,250,255) else
    StringGrid1.Canvas.brush.Color := rgb (230,230,255);
     if arow = 0 then
    StringGrid1.Canvas.Brush.Color := clbtnface;
     if gdSelected in State then
      StringGrid1.Canvas.Brush.Color := cl3dlight; // except the selected cell.
    StringGrid1.Canvas.Font := StringGrid1.Font;
    StringGrid1.Canvas.FillRect(Rect); // Fill the background
    StringGrid1.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, StringGrid1.Cells[ACol, ARow]);
end;

end.
