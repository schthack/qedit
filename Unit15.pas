unit Unit15;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, Math, StdCtrls, Vcl.Menus, Vcl.ExtCtrls;

type
  TRoomData = record
    roomnum: integer;
    numentries: integer;
    data: TBytes;
end;

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
    PopupMenu1: TPopupMenu;
    Addroom1: TMenuItem;
    Editroom1: TMenuItem;
    Deleteroom1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Addrow1: TMenuItem;
    Deleterow1: TMenuItem;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    Addrow2: TMenuItem;
    Deleterow2: TMenuItem;
    Addrow3: TMenuItem;
    Deleterow3: TMenuItem;
    btnAddRoom: TButton;
    btnEditRoom: TButton;
    btnDeleteRoom: TButton;
    btnAddEntry: TButton;
    btnDeleteEntry: TButton;
    btnSave1: TButton;
    btnClose1: TButton;
    Timer1: TTimer;
    btnClose2: TButton;
    btnSave2: TButton;
    Button1: TButton;
    Button2: TButton;
    btnDeleteRow3: TButton;
    btnDeleteRow2: TButton;
    Bevel1: TBevel;
    procedure ListBox1Click(Sender: TObject);
    procedure StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Addroom1Click(Sender: TObject);
    procedure Editroom1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Deleteroom1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure StringGrid3SetEditText(Sender: TObject; ACol, ARow: LongInt;
      const Value: string);
    procedure Addrow1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure Deleterow1Click(Sender: TObject);
    procedure Addrow2Click(Sender: TObject);
    procedure Deleterow2Click(Sender: TObject);
    procedure Addrow3Click(Sender: TObject);
    procedure Deleterow3Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure PopupMenu4Popup(Sender: TObject);
    procedure btnAddRoomClick(Sender: TObject);
    procedure btnEditRoomClick(Sender: TObject);
    procedure btnDeleteRoomClick(Sender: TObject);
    procedure btnClose1Click(Sender: TObject);
    procedure btnSave1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnAddEntryClick(Sender: TObject);
    procedure btnDeleteEntryClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnDeleteRow2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnDeleteRow3Click(Sender: TObject);
    procedure StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGrid3SelectCell(Sender: TObject; ACol, ARow: LongInt;
      var CanSelect: Boolean);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: LongInt;
      var CanSelect: Boolean);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: LongInt;
      var CanSelect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SaveD04;
    procedure SaveD05;
  end;

var
  Form15: TForm15;
  roomdata: array of TRoomData;
  btnpos: tpoint;

implementation

uses main, FAddRoom, TCom, FMonsType;

{$R *.dfm}

procedure AddRowAfter(Grid: TStringGrid);
var
  r, c: Integer;
begin
   // If no data rows exist, insert as first row after header
  if Grid.RowCount <= 1 then
  begin
    Grid.RowCount := 2;
    for c := 1 to Grid.ColCount - 1 do
      Grid.Cells[c, 1] := '0';
    Grid.Cells[0, 1] := '1';
    Grid.Row := 1;
    Exit;
  end;

  r := Grid.Row;

  // Prevent inserting above header
  if r < 1 then
    Exit;

  // Expand grid
  Grid.RowCount := Grid.RowCount + 1;
  Grid.FixedRows := 1;

  // Shift rows down from bottom
  for c := Grid.RowCount - 1 downto r + 2 do
    Grid.Rows[c].Assign(Grid.Rows[c - 1]);

  // Zero the new row
  for c := 1 to Grid.ColCount - 1 do
    Grid.Cells[c, r + 1] := '0';

  // Renumber column 0
  for c := 1 to Grid.RowCount - 1 do
    Grid.Cells[0, c] := IntToStr(c);

  // Select the new row
  Grid.Row := r + 1;
end;

procedure DeleteRow(Grid: TStringGrid);
var
  r, i: Integer;
begin
  r := Grid.Row;
  if (r < 1) or (Grid.RowCount <= 1) then
    Exit;

  // Shift rows up
  for i := r to Grid.RowCount - 2 do
    Grid.Rows[i].Assign(Grid.Rows[i + 1]);

  // Shrink row count
  Grid.RowCount := Grid.RowCount - 1;

  // Renumber column 0
  for i := 1 to Grid.RowCount - 1 do
    Grid.Cells[0, i] := IntToStr(i);

  // Adjust selected row
  if r >= Grid.RowCount then
    Grid.Row := Grid.RowCount - 1;
end;

procedure TForm15.SaveD04;
var
  roomCount: Integer;
  headerBase: Integer;
  dataStart: Integer;
  headerPos: Integer;
  writePos: Integer;
  dataOffsetRel: Integer;
  r: Integer;
  tmpInt: Integer;
begin
  // Base header is always 12
  headerBase := 12;

  // Number of rooms
  roomCount := Length(roomdata) - 1;
  if roomCount < 0 then roomCount := 0;

  dataStart := headerBase + (roomCount * 8);

  // Write full header
  tmpInt := headerBase;
  Move(tmpInt, Floor[sfloor].d04[0], 4);

  tmpInt := dataStart;
  Move(tmpInt, Floor[sfloor].d04[4], 4);

  tmpInt := roomCount;
  Move(tmpInt, Floor[sfloor].d04[8], 4);

  headerPos := headerBase;
  writePos := dataStart;
  dataOffsetRel := 0;

  for r := 1 to roomCount do
  begin
    // low 16 bits = roomnum, high 16 bits = numentries
    tmpInt := (roomdata[r].numentries shl 16) or (roomdata[r].roomnum and $FFFF);
    Move(tmpInt, Floor[sfloor].d04[headerPos], 4);

    // Write relative offset from dataStart
    tmpInt := dataOffsetRel;
    Move(tmpInt, Floor[sfloor].d04[headerPos + 4], 4);

    // Write entries if any
    if roomdata[r].numentries > 0 then
    begin
      Move(roomdata[r].data[0], Floor[sfloor].d04[writePos], roomdata[r].numentries * 28);
      Inc(writePos, roomdata[r].numentries * 28);
      Inc(dataOffsetRel, roomdata[r].numentries * 28);
    end;

    // Next room header
    Inc(headerPos, 8);
  end;

  // Final total size
  Floor[sfloor].d04count := writePos;
  if Floor[sfloor].d04count <= 12 then Floor[sfloor].d04count := 0;
end;

procedure TForm15.SaveD05;
var
  x, int, y, z, offset: integer;
  flt: Single;
  totalsize: integer;
begin
  // Get the row counts
  z := form15.StringGrid1.RowCount - 1; // Subtract header row

  // Store count at offset 8
  move(z, Floor[sfloor].d05[8], 4);

  // Calculate starting offset for data (after header)
  y := 16;

  // Store starting offset at position 0
  move(y, Floor[sfloor].d05[0], 4);

  // Write Grid1 data
  for x := 1 to z do
  begin
    // Column 1-5: floats
    flt := StrToFloatDef(form15.StringGrid1.Cells[1, x], 0);
    move(flt, Floor[sfloor].d05[y], 4);
    flt := StrToFloatDef(form15.StringGrid1.Cells[2, x], 0);
    move(flt, Floor[sfloor].d05[y + 4], 4);
    flt := StrToFloatDef(form15.StringGrid1.Cells[3, x], 0);
    move(flt, Floor[sfloor].d05[y + 8], 4);
    flt := StrToFloatDef(form15.StringGrid1.Cells[4, x], 0);
    move(flt, Floor[sfloor].d05[y + 12], 4);
    flt := StrToFloatDef(form15.StringGrid1.Cells[5, x], 0);
    move(flt, Floor[sfloor].d05[y + 16], 4);

    // Columns 6-11: integers
    int := StrToIntDef(form15.StringGrid1.Cells[6, x], 0);
    move(int, Floor[sfloor].d05[y + 20], 2);
    int := StrToIntDef(form15.StringGrid1.Cells[7, x], 0);
    move(int, Floor[sfloor].d05[y + 22], 2);
    int := StrToIntDef(form15.StringGrid1.Cells[8, x], 0);
    move(int, Floor[sfloor].d05[y + 24], 4);
    int := StrToIntDef(form15.StringGrid1.Cells[9, x], 0);
    move(int, Floor[sfloor].d05[y + 28], 2);
    int := StrToIntDef(form15.StringGrid1.Cells[10, x], 0);
    move(int, Floor[sfloor].d05[y + 30], 2);

    inc(y, $20);
  end;

  // Store Grid2 starting offset at position 4
  move(y, Floor[sfloor].d05[4], 4);

  // Get Grid2 row count
  z := form15.StringGrid2.RowCount - 1;

  // Store count at offset 12
  move(z, Floor[sfloor].d05[12], 4);

  // Write Grid2 data
  for x := 1 to z do
  begin
    // Combine columns 1 and 2 into a single word
    int := StrToIntDef(form15.StringGrid2.Cells[1, x], 0) +
           (StrToIntDef(form15.StringGrid2.Cells[2, x], 0) * 256);
    move(int, Floor[sfloor].d05[y], 2);

    // Column 3: word
    int := StrToIntDef(form15.StringGrid2.Cells[3, x], 0);
    move(int, Floor[sfloor].d05[y + 2], 2);

    inc(y, 4);
  end;

  // Set total size
  Floor[sfloor].d05count := y;
  if Floor[sfloor].d05count <= 16 then Floor[sfloor].d05count := 0;
end;

procedure TForm15.Addroom1Click(Sender: TObject);
begin
  fmRoom.Caption := 'Add room';
  fmRoom.SpinEdit1.Value := 0;
  fmRoom.ShowModal;
end;

procedure TForm15.Addrow1Click(Sender: TObject);
var
  i, j, roomIndex, insertRow, insertPos, oldSize: Integer;
  found: Boolean;
begin
  roomIndex := Listbox1.ItemIndex + 1;

  // Number of existing entries in this room
  oldSize := Length(roomdata[roomIndex].data);

  if roomdata[roomIndex].numentries = 0 then
  begin
    // Create first entry
    SetLength(roomdata[roomIndex].data, 28);
    FillChar(roomdata[roomIndex].data[0], 28, 0);

    // Set room ID cell
    move(roomdata[roomIndex].roomnum, roomdata[roomIndex].data[24], 2);

    // Update count
    roomdata[roomIndex].numentries := 1;

    // Update display name
    ListBox1.Items[roomIndex - 1] :=
      Format('%d (%d entries)', [roomdata[roomIndex].roomnum, 1]);

    // Refresh grid
    Listbox1Click(form15.ListBox1);
    StringGrid3.FixedRows := 1;

    // Select the new row
    StringGrid3.Row := 1;
    Exit;
  end;

  insertRow := StringGrid3.Row;

  if insertRow < 1 then
    insertRow := 1;

  // Insert after this row
  insertPos := insertRow * 28;

  // Expand data for one more entry
  SetLength(roomdata[roomIndex].data, oldSize + 28);

  // Shift existing entries down if needed
  if insertPos < oldSize then
    Move(roomdata[roomIndex].data[insertPos],
         roomdata[roomIndex].data[insertPos + 28],
         oldSize - insertPos);

  // Zero the new block
  FillChar(roomdata[roomIndex].data[insertPos], 28, 0);

  // Set room ID cell
  move(roomdata[roomIndex].roomnum, roomdata[roomIndex].data[insertPos + 24], 2);

  // Set entry # cell
  for i := 0 to 65535 do
  begin
    found := false;
    for j := 1 to StringGrid3.RowCount - 1 do
    begin
      if StrToIntDef(StringGrid3.Cells[8,j], -1) = i then
      begin
        found := true;
        break;
      end;
    end;
    if not found then
      break;
  end;
  move(i, roomdata[roomIndex].data[insertPos + 26], 2);

  // Increase total
  Inc(roomdata[roomIndex].numentries);

  // Update listbox
  ListBox1.Items[roomIndex - 1] :=
    Format('%d (%d entries)', [roomdata[roomIndex].roomnum, roomdata[roomIndex].numentries]);

  // Refresh grid
  Listbox1Click(form15.ListBox1);

  // Reselect the new row
  StringGrid3.Row := insertRow + 1;
end;

procedure TForm15.Addrow2Click(Sender: TObject);
begin
  AddRowAfter(Stringgrid1);
end;

procedure TForm15.Addrow3Click(Sender: TObject);
begin
  AddRowAfter(Stringgrid2);
end;

procedure TForm15.btnEditRoomClick(Sender: TObject);
begin
  Editroom1CLick(nil);
end;

procedure TForm15.btnSave1Click(Sender: TObject);
begin
  SaveD04;
  SaveD05;
  if (Floor[sFloor].d04count > 0) or (Floor[sFloor].d05count > 0) then
    Form1.Button12.Enabled := true
  else Form1.Button12.Enabled := false;
  Form1.DrawMap;
  isedited := true;
  Close;
end;

procedure TForm15.Button1Click(Sender: TObject);
begin
  Addrow2Click(nil);
end;

procedure TForm15.Button2Click(Sender: TObject);
begin
  AddRow3Click(nil);
end;

procedure TForm15.btnDeleteRow3Click(Sender: TObject);
begin
  DeleteRow3Click(nil);
end;

procedure TForm15.btnDeleteRow2Click(Sender: TObject);
begin
  Deleterow2Click(nil);
end;

procedure TForm15.btnAddEntryClick(Sender: TObject);
begin
  Addrow1Click(nil);
end;

procedure TForm15.btnAddRoomClick(Sender: TObject);
begin
  AddRoom1Click(nil);
end;

procedure TForm15.btnClose1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm15.btnDeleteEntryClick(Sender: TObject);
begin
  Deleterow1Click(nil);
end;

procedure TForm15.btnDeleteRoomClick(Sender: TObject);
begin
  Deleteroom1Click(nil);
end;

procedure TForm15.Deleteroom1Click(Sender: TObject);
var
  i, ItemIndex, choice: Integer;
begin
  ItemIndex := form15.ListBox1.ItemIndex;
  if ItemIndex >= form15.ListBox1.Count then Exit;

   choice := MessageDlg('Delete room ' +
   inttostr(roomdata[ItemIndex + 1].roomnum) +
   ' and all of its entries?', mtConfirmation, [mbYes, mbNo], 0);

  if choice = mrYes then
  begin
    // Delete ListBox item first
    form15.ListBox1.Items.Delete(ItemIndex);

    // Shift remaining roomdata down
    for i := ItemIndex + 2 to High(roomdata) do
      roomdata[i - 1] := roomdata[i];

    // Shrink array
    if Length(roomdata) > 0 then
      SetLength(roomdata, Length(roomdata) - 1);

    // Adjust ListBox selection
    if form15.ListBox1.Count = 0 then
    begin
      form15.ListBox1.ItemIndex := -1;
      form15.StringGrid3.RowCount := 1;
    end
    else
    begin
      if ItemIndex >= form15.ListBox1.Count then
        ItemIndex := form15.ListBox1.Count - 1;

      form15.ListBox1.ItemIndex := ItemIndex;
      form15.ListBox1Click(form15.ListBox1);
    end;
  end;
end;

procedure TForm15.Deleterow1Click(Sender: TObject);
var
  startOffset, endOffset, totalSize, roomIndex, entryIndex: Integer;
begin
  roomIndex := Listbox1.ItemIndex + 1;
  entryIndex := stringgrid3.Row;
  totalSize := Length(roomdata[roomIndex].data);

  startOffset := (entryIndex - 1) * 28;
  endOffset := startOffset + 28;

  if endOffset < totalSize then
    Move(roomdata[roomIndex].data[endOffset],
         roomdata[roomIndex].data[startOffset],
         totalSize - endOffset);

  // Shrink array
  SetLength(roomdata[roomIndex].data, totalSize - 28);

  // Reduce entry count
  Dec(roomdata[roomIndex].numentries);

   // Update listbox
  form15.ListBox1.Items[roomIndex - 1] :=
  Format('%d (%d entries)', [roomdata[roomIndex].roomnum, roomdata[roomIndex].numentries]);

  // Refresh grid
  Listbox1Click(form15.ListBox1);
end;

procedure TForm15.Deleterow2Click(Sender: TObject);
begin
  DeleteRow(Stringgrid1);
end;

procedure TForm15.Deleterow3Click(Sender: TObject);
begin
  DeleteRow(Stringgrid2);
end;

procedure TForm15.Editroom1Click(Sender: TObject);
begin
   fmRoom.Caption := 'Edit room';
   fmRoom.SpinEdit1.Value := roomdata[form15.ListBox1.ItemIndex + 1].roomnum;
   fmRoom.ShowModal;
end;

procedure TForm15.ListBox1Click(Sender: TObject);
var
  listIdx, entryIdx, count, offset, tempInt: Integer;
  flt: Single;
  room: TRoomData;
begin
  listIdx := ListBox1.ItemIndex;
  if listIdx < 0 then Exit;

  // Select the room
  room := roomdata[listIdx + 1];
  count := room.numentries;

  // Prepare grid
  StringGrid3.RowCount := count + 1;
  StringGrid3.Cells[0,0] := '#';
  StringGrid3.Cells[1,0] := 'Pos X';
  StringGrid3.Cells[2,0] := 'Pos Y';
  StringGrid3.Cells[3,0] := 'Pos Z';
  StringGrid3.Cells[4,0] := 'Rot. X';
  StringGrid3.Cells[5,0] := 'Rot. Y';
  StringGrid3.Cells[6,0] := 'Rot. Z';
  StringGrid3.Cells[7,0] := 'Room ID';
  StringGrid3.Cells[8,0] := 'Entry #';

  for entryIdx := 1 to count do
  begin
    offset := (entryIdx - 1) * 28;
    StringGrid3.Cells[0,entryIdx] := IntToStr(entryIdx);

    // Pos X/Y/Z
    move(room.data[offset + 0], flt, 4);
    StringGrid3.Cells[1,entryIdx] := FloatToStrF(flt, ffGeneral, 6, 2);

    move(room.data[offset + 4], flt, 4);
    StringGrid3.Cells[2,entryIdx] := FloatToStrF(flt, ffGeneral, 6, 2);

    move(room.data[offset + 8], flt, 4);
    StringGrid3.Cells[3,entryIdx] := FloatToStrF(flt, ffGeneral, 6, 2);

    // Rot X/Y/Z
    move(room.data[offset + 12], tempInt, 4);
    StringGrid3.Cells[4,entryIdx] := IntToStr(tempInt);

    move(room.data[offset + 16], tempInt, 4);
    StringGrid3.Cells[5,entryIdx] := IntToStr(tempInt);

    move(room.data[offset + 20], tempInt, 4);
    StringGrid3.Cells[6,entryIdx] := IntToStr(tempInt);

    // Room ID / Entry #
    Move(room.data[offset + 24], tempInt, 4);
    StringGrid3.Cells[7,entryIdx] := IntToStr(tempInt and $FFFF);
    StringGrid3.Cells[8,entryIdx] := IntToStr(tempInt div $10000);
  end;
end;

procedure TForm15.ListBox1DblClick(Sender: TObject);
begin
  form15.Editroom1Click(nil);
end;

procedure TForm15.PopupMenu1Popup(Sender: TObject);
begin
  if Listbox1.ItemIndex > -1 then
  begin
    form15.Editroom1.Enabled := true;
    form15.Deleteroom1.Enabled := true
  end
  else
  begin
    form15.Editroom1.Enabled := false;
    form15.Deleteroom1.Enabled := false;
  end;
end;

procedure TForm15.PopupMenu2Popup(Sender: TObject);
begin
  if (Stringgrid3.Row > 0) and (Listbox1.ItemIndex > -1) then
    form15.Deleterow1.Enabled := true
  else form15.Deleterow1.Enabled := false;

  if Listbox1.ItemIndex > -1 then
    form15.AddRow1.Enabled := true
  else form15.AddRow1.Enabled := false;
end;

procedure TForm15.PopupMenu3Popup(Sender: TObject);
begin
  if Stringgrid1.Row > 0 then
    Deleterow2.Enabled := true
  else Deleterow2.Enabled := false;
end;

procedure TForm15.PopupMenu4Popup(Sender: TObject);
begin
  if Stringgrid2.Row > 0 then
    Deleterow3.Enabled := true
  else Deleterow3.Enabled := false;
end;

procedure TForm15.StringGrid2SelectCell(Sender: TObject; ACol, ARow: LongInt;
  var CanSelect: Boolean);
begin
  StringGrid2.Invalidate;
  if ARow = 0 then
    CanSelect := false;
end;

procedure TForm15.StringGrid1SelectCell(Sender: TObject; ACol, ARow: LongInt;
  var CanSelect: Boolean);
begin
  StringGrid1.Invalidate;
  if ARow = 0 then
    CanSelect := false;
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
    if StringGrid3.Row = ARow then
      StringGrid3.Canvas.Brush.Color := cl3dlight; // except the selected cell.
    StringGrid3.Canvas.Font := StringGrid1.Font;
    StringGrid3.Canvas.FillRect(Rect); // Fill the background
    StringGrid3.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, StringGrid3.Cells[ACol, ARow]);
end;

procedure TForm15.StringGrid3SelectCell(Sender: TObject; ACol, ARow: LongInt;
  var CanSelect: Boolean);
begin
  StringGrid3.Invalidate;
  if ARow = 0 then
    CanSelect := false;
end;

procedure TForm15.StringGrid3SetEditText(Sender: TObject; ACol, ARow: LongInt;
  const Value: string);
var x,y,z:integer;
    fl:single;
begin
   try
    x := form15.Listbox1.ItemIndex + 1;
    z := (arow-1) * 28;
    if acol = 1 then begin
        fl:=strtofloat(value);
        move(fl,roomdata[x].data[z],4);
    end;
    if acol = 2 then begin
        fl:=strtofloat(value);
        move(fl,roomdata[x].data[z+4],4);
    end;
    if acol = 3 then begin
        fl:=strtofloat(value);
        move(fl,roomdata[x].data[z+8],4);
    end;
    if acol = 4 then begin
        y:=strtoint(value);
        move(y,roomdata[x].data[z+12],4);
    end;
    if acol = 5 then begin
        y:=strtoint(value);
        move(y,roomdata[x].data[z+16],4);
    end;
    if acol = 6 then begin
        y:=strtoint(value);
        move(y,roomdata[x].data[z+20],4);
    end;
    if acol = 7 then begin
        y:=strtoint(value);
        move(y,roomdata[x].data[z+24],2);
    end;
    if acol = 8 then begin
        y:=strtoint(value);
        move(y,roomdata[x].data[z+26],2);
    end;
   except
   end;
end;

procedure TForm15.Timer1Timer(Sender: TObject);
begin
  if not form15.Visible then exit;

  // Edit / Delete room
  if Listbox1.ItemIndex > -1 then
  begin
    btnEditRoom.Enabled := true;
    btnDeleteRoom.Enabled := true
  end
  else
  begin
    btnEditRoom.Enabled := false;
    btnDeleteRoom.Enabled := false;
  end;

   // Add entry
  if (Listbox1.ItemIndex > -1) and (StringGrid3.RowCount < 33) then
  begin
    btnAddEntry.Enabled := true;
    AddRow1.Enabled := true
  end
  else
  begin
    btnAddEntry.Enabled := false;
    AddRow1.Enabled := false;
  end;
  // Delete entry
  if (Stringgrid3.Row > 0) and (Stringgrid3.RowCount > 1)
  and (Listbox1.ItemIndex > -1) then
  begin
    btnDeleteEntry.Enabled := true;
    DeleteRow1.Enabled := true
  end
  else
  begin
    btnDeleteEntry.Enabled := false;
    DeleteRow1.Enabled := false;
  end;

  // Delete row
  if Stringgrid1.Row > 0 then
    btnDeleterow2.Enabled := true
  else btnDeleterow2.Enabled := false;
  if Stringgrid2.Row > 0 then
    btnDeleterow3.Enabled := true
  else btnDeleterow3.Enabled := false;
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
    if StringGrid1.Row = ARow then
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
    if StringGrid2.Row = ARow then
      StringGrid2.Canvas.Brush.Color := cl3dlight; // except the selected cell.
    StringGrid2.Canvas.Font := StringGrid1.Font;
    StringGrid2.Canvas.FillRect(Rect); // Fill the background
    StringGrid2.Canvas.TextRect(Rect, Rect.Left+1, Rect.Top+1, StringGrid2.Cells[ACol, ARow]);
    if (acol = 1) and (arow > 0) then
    begin
      btnPos.X := rect.left+16;
      form5.imagelist2.Draw(StringGrid2.Canvas,rect.left+16,rect.top+2,0,true);
    end;
end;

procedure TForm15.StringGrid2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  if ((x >= btnPos.X) and (x <= btnpos.X+15))
  and (Button = mbLeft) and (stringgrid2.Col = 1) then
  begin
    if trystrtoint(stringgrid2.cells[1,stringgrid2.row],i) then
      fmMonsterType.ComboBox1.ItemIndex := strtoint(stringgrid2.cells[1,stringgrid2.row]);
    if fmMonsterType.Showmodal = 1 then
      stringgrid2.cells[1,stringgrid2.row] := inttostr(fmMonsterType.ComboBox1.ItemIndex);
  end;
end;

end.
