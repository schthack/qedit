unit FVector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, D3DEngin, D3DX9;

type
  TVectorListEntry = record
    x,y,z:single;
    frame:single;
  end;
  TForm32 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    vectors: array[0..1000] of TVectorListEntry;
    vectorCount: integer;
    mapItem: T3DItem;
    inEditMode: boolean;
  end;

var
  Form32: TForm32;

implementation

{$R *.dfm}

uses  main;

procedure refreshDps();
var x:integer;
    rx,ry,distance: single;
begin
    form32.StringGrid1.Cells[0,0] := 'X';
    form32.StringGrid1.Cells[1,0] := 'Y';
    form32.StringGrid1.Cells[2,0] := 'Z';
    form32.StringGrid1.Cells[3,0] := 'Duration';
    form32.StringGrid1.Cells[4,0] := 'distance';
    for x:=1 to form32.vectorCount-1 do begin
      // calculate distance
      rx := abs(form32.vectors[x-1].x - form32.vectors[x].x);
      ry := abs(form32.vectors[x-1].y - form32.vectors[x].y);
      rx := sqrt((rx*rx)+(ry*ry));
      ry := abs(form32.vectors[x-1].z - form32.vectors[x].z);
      distance := sqrt((rx*rx)+(ry*ry));

      form32.StringGrid1.Cells[4,x] := format('%.2f',[distance]);
      if form32.vectors[x].frame = 0 then distance := 0 else
      distance := distance / form32.vectors[x-1].frame;
      form32.StringGrid1.Cells[5,x] := format('%.2f Units/Frame',[distance]);
      if form32.vectorCount-1 = x then form32.StringGrid1.Cells[4,x+1] := 'End';
    end;
end;

procedure refreshTable();
var i:integer;
begin
  form32.StringGrid1.RowCount := form32.vectorCount + 1;
    for i:=0 to form32.vectorCount-1 do begin
        form32.StringGrid1.Cells[0,i+1]:=format('%.3f',[form32.vectors[i].x]);
        form32.StringGrid1.Cells[1,i+1]:=format('%.3f',[form32.vectors[i].y]);
        form32.StringGrid1.Cells[2,i+1]:=format('%.3f',[form32.vectors[i].z]);
        form32.StringGrid1.Cells[3,i+1]:=format('%.3f',[form32.vectors[i].frame]);
    end;
end;

procedure TForm32.Button1Click(Sender: TObject);
var i:integer;
  t: TVectorListEntry;
  g : tgridrect;
begin
    if stringgrid1.Selection.Top > 1 then begin
        i:=stringgrid1.Selection.Top-1;
        t := vectors[i];
         vectors[i] := vectors[i-1];
         vectors[i-1] := t;
         refreshTable();
        refreshDps();
        g.Left := stringgrid1.Selection.Left;
        g.right := stringgrid1.Selection.right;
        g.top := stringgrid1.Selection.top-1;
        g.bottom := stringgrid1.Selection.bottom-1;
        stringgrid1.Selection := g;
    end;
end;

procedure TForm32.Button2Click(Sender: TObject);
var i:integer;
  t: TVectorListEntry;
  g : tgridrect;
begin
  if stringgrid1.Selection.Top < vectorCount then
    if stringgrid1.Selection.Top > 0 then begin
        i:=stringgrid1.Selection.Top-1;
        t := vectors[i];
         vectors[i] := vectors[i+1];
         vectors[i+1] := t;
         refreshTable();
        refreshDps();
        g.Left := stringgrid1.Selection.Left;
        g.right := stringgrid1.Selection.right;
        g.top := stringgrid1.Selection.top+1;
        g.bottom := stringgrid1.Selection.bottom+1;
        stringgrid1.Selection := g;
    end;
end;

procedure TForm32.Button3Click(Sender: TObject);
var i:integer;
begin
    if stringgrid1.Selection.Top > -1 then begin
        for i:=stringgrid1.Selection.Top-1 to vectorCount-1 do begin
         vectors[i] := vectors[i+1];
        end;
        dec(vectorCount);
        refreshTable();
        refreshDps();
    end;
end;

procedure TForm32.Button4Click(Sender: TObject);
var i:integer;
begin

    // add to end
    vectors[vectorCount].x := 0;
    vectors[vectorCount].y := 0;
    vectors[vectorCount].z := 0;
    vectors[vectorCount].frame := 0;
    inc(vectorCount);

  refreshTable();
  refreshDps();
end;

procedure TForm32.Button5Click(Sender: TObject);
begin
  modalresult:=1;
end;

procedure TForm32.Button6Click(Sender: TObject);
begin
  modalresult:=0;
    close;
end;

procedure TForm32.FormShow(Sender: TObject);
var x:integer;
    vertexs: array of T3DVertex;
begin
    refreshTable();
    refreshDps();
    inEditMode := false;

    if have3d then begin
      setlength(vertexs,vectorCount*2);
      for x:=0 to vectorCount-1 do begin
          vertexs[(x*2)].px:=vectors[x].x-10;
          vertexs[(x*2)].py:=vectors[x].y;
          vertexs[(x*2)].pz:=-vectors[x].z;
          vertexs[(x*2)].color := $FFFFFFFF;
          vertexs[(x*2)].tu := 0.1;
          vertexs[(x*2)].tv := 0.1;

          vertexs[(x*2)+1].px:=vectors[x].x+10;
          vertexs[(x*2)+1].py:=vectors[x].y+10;
          vertexs[(x*2)+1].pz:=-vectors[x].z;
          vertexs[(x*2)+1].color := $FFFFFFFF;
          vertexs[(x*2)+1].tu := 0.2;
          vertexs[(x*2)+1].tv := 0.2;
      end;

      mapItem := T3DItem.Create(myscreen);
      mapItem.SetVertexList(vertexs);
      mapItem.Visible := true;
      ppx := vectors[0].x;
      ppy := vectors[0].y;
      ppz := -vectors[0].z;
    end;
end;

procedure TForm32.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then begin
        refreshTable();
        refreshDps();
        inEditMode := true;
    end;
end;

procedure TForm32.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if inEditMode then begin
      refreshTable();
    refreshDps();
    inEditMode := true;
  end;
  CanSelect := true;
  if aCol >= 4 then CanSelect := false;
end;

procedure TForm32.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  // edit cell
  inEditMode := true;
  if value = '' then exit;
  if value = '-' then exit;
  if acol = 0 then vectors[arow-1].x := strtofloat(value);
  if acol = 1 then vectors[arow-1].y := strtofloat(value);
  if acol = 2 then vectors[arow-1].z := strtofloat(value);
  if acol = 3 then vectors[arow-1].frame := strtofloat(value);
end;

end.
