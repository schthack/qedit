unit Unit15;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, StdCtrls;

type
  TForm15 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label1: TLabel;
    ListBox1: TListBox;
    StringGrid3: TStringGrid;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure ListBox1Click(Sender: TObject);
    procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

uses main;

{$R *.dfm}

procedure TForm15.ListBox1Click(Sender: TObject);
var x,y,z,i:integer;
    flt:single;
begin
    move(Floor[sfloor].d04[0],y,4);  //base pos
    move(Floor[sfloor].d04[4],z,4);  //data pos
    inc(y,(listbox1.itemindex*8));
    x:=0;
    move(Floor[sfloor].d04[y+2],x,2); //count
    move(Floor[sfloor].d04[y+4],i,4); //offset
    inc(z,i);
    stringgrid3.RowCount:=x+1;
    stringgrid3.Cells[0,0]:='#';
    stringgrid3.Cells[1,0]:='Pos X';
    stringgrid3.Cells[2,0]:='Pos Y';
    stringgrid3.Cells[3,0]:='Pos Z';
    stringgrid3.Cells[4,0]:='Rot. X';
    stringgrid3.Cells[5,0]:='Rot. Y';
    stringgrid3.Cells[6,0]:='Rot. Z';
    stringgrid3.Cells[7,0]:='Room ID';
    stringgrid3.Cells[8,0]:='Entry #';
    for y:=1 to x do begin
        stringgrid3.Cells[0,y]:=inttostr(y);
        move(Floor[sfloor].d04[z+0],flt,4); //flt1
        stringgrid3.Cells[1,y]:=floattostrf(flt,ffGeneral,6,2);
        move(Floor[sfloor].d04[z+4],flt,4); //flt2
        stringgrid3.Cells[2,y]:=floattostrf(flt,ffGeneral,6,2);
        move(Floor[sfloor].d04[z+8],flt,4); //flt3
        stringgrid3.Cells[3,y]:=floattostrf(flt,ffGeneral,6,2);
        move(Floor[sfloor].d04[z+12],i,4);
        stringgrid3.Cells[4,y]:=inttostr(i);
        move(Floor[sfloor].d04[z+16],i,4);
        stringgrid3.Cells[5,y]:=inttostr(i);
        move(Floor[sfloor].d04[z+20],i,4);
        stringgrid3.Cells[6,y]:=inttostr(i);
        move(Floor[sfloor].d04[z+24],i,4);
        stringgrid3.Cells[7,y]:=inttostr(i and $ffff);
        stringgrid3.Cells[8,y]:=inttostr(i div $10000);
        inc(z,28);
    end;
end;

procedure TForm15.StringGrid2SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var x,y:integer;
begin
   try
    move(Floor[sfloor].d05[4],x,4);
    inc(x,(arow-1)*4);
    if acol = 1 then begin
        y:=strtoint(value);
        y:=y;
        move(y,Floor[sfloor].d05[x],1);
    end;
    if acol = 2 then begin
        y:=strtoint(value);
        y:=y;
        move(y,Floor[sfloor].d05[x+1],1);
    end;
    if acol = 3 then begin
        y:=strtointdef(value,0);
        move(y,Floor[sfloor].d05[x+2],2);
    end;
   except
   end;
end;

procedure TForm15.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var x,y:integer;
    fl:single;
begin
   try
    move(Floor[sfloor].d05[0],x,4);
    inc(x,(arow-1)*32);
    if acol = 1 then begin
        fl:=strtofloat(value);
        move(fl,Floor[sfloor].d05[x],4);
    end;
    if acol = 2 then begin
        fl:=strtofloat(value);
        move(fl,Floor[sfloor].d05[x+4],4);
    end;
    if acol = 3 then begin
        fl:=strtofloat(value);
        move(fl,Floor[sfloor].d05[x+8],4);
    end;
    if acol = 4 then begin
        fl:=strtofloat(value);
        move(fl,Floor[sfloor].d05[x+12],4);
    end;
    if acol = 5 then begin
        y:=strtoint(value);
        move(y,Floor[sfloor].d05[x+16],4);
    end;
    if acol = 6 then begin
        y:=strtoint(value);
        move(y,Floor[sfloor].d05[x+20],2);
    end;
    if acol = 7 then begin
        y:=strtoint(value);
        move(y,Floor[sfloor].d05[x+22],2);
    end;

    if acol = 8 then begin
        y:=strtoint(value);
        move(y,Floor[sfloor].d05[x+24],4);
    end;
    if acol = 9 then begin
        y:=strtoint(value);
        move(y,Floor[sfloor].d05[x+28],2);
    end;
    if acol = 10 then begin
        y:=strtoint(value);
        move(y,Floor[sfloor].d05[x+30],2);
    end;
   except
   end;
end;

procedure TForm15.StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
    if odd(ARow) then
        StringGrid3.Canvas.Brush.Color := rgb (250,250,255) else
    StringGrid3.Canvas.brush.Color := rgb (230,230,255);
     if arow = 0 then
    StringGrid3.Canvas.Brush.Color := clbtnface;
    if acol = 0 then
    StringGrid3.Canvas.Brush.Color := clbtnface;
     if gdSelected in State then
      StringGrid3.Canvas.Brush.Color := cl3dlight; // except the selected cell.
    StringGrid3.Canvas.Font := StringGrid1.Font;
    StringGrid3.Canvas.FillRect(Rect); // Fill the background
    StringGrid3.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, StringGrid3.Cells[ACol, ARow]);
end;

procedure TForm15.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if odd(ARow) then
        StringGrid1.Canvas.Brush.Color := rgb (250,250,255) else
    StringGrid1.Canvas.brush.Color := rgb (230,230,255);
     if arow = 0 then
    StringGrid1.Canvas.Brush.Color := clbtnface;
    if acol = 0 then
    StringGrid1.Canvas.Brush.Color := clbtnface;
     if gdSelected in State then
      StringGrid1.Canvas.Brush.Color := cl3dlight; // except the selected cell.
    StringGrid1.Canvas.Font := StringGrid1.Font;
    StringGrid1.Canvas.FillRect(Rect); // Fill the background
    StringGrid1.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, StringGrid1.Cells[ACol, ARow]);
end;

procedure TForm15.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
    if odd(ARow) then
        StringGrid2.Canvas.Brush.Color := rgb (250,250,255) else
    StringGrid2.Canvas.brush.Color := rgb (230,230,255);
     if arow = 0 then
    StringGrid2.Canvas.Brush.Color := clbtnface;
    if acol = 0 then
    StringGrid2.Canvas.Brush.Color := clbtnface;
     if gdSelected in State then
      StringGrid2.Canvas.Brush.Color := cl3dlight; // except the selected cell.
    StringGrid2.Canvas.Font := StringGrid1.Font;
    StringGrid2.Canvas.FillRect(Rect); // Fill the background
    StringGrid2.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, StringGrid2.Cells[ACol, ARow]);
end;

end.
