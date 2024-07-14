unit FSymbolChat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TCornerData = packed record
    icon: byte;
    param: byte;
  end;
  TSymbolPart = packed record
    partId, posX, posY, mirror: byte;
  end;
  TSymbolData = packed record
      face: dword;
      corners: array[0..3] of TCornerData;
      parts: array[0..11] of TSymbolPart;
  end;
  TForm33 = class(TForm)
    Image1: TImage;
    ComboBox1: TComboBox;
    ImageList1: TImageList;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox4: TComboBox;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    BitBtn1: TBitBtn;
    ImageList2: TImageList;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    ListBox1: TListBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    ComboBox5: TComboBox;
    Button1: TButton;
    Button2: TButton;
    ComboBox6: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox2DrawItem(Control: TWinControl; Index: Integer; cRect: TRect; State: TOwnerDrawState);
    procedure ComboBox3DrawItem(Control: TWinControl; Index: Integer; cRect: TRect; State: TOwnerDrawState);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox4DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure RadioButton1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ComboBox5DrawItem(Control: TWinControl; Index: Integer; cRect: TRect; State: TOwnerDrawState);
    procedure ComboBox5Change(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    symbolData: TSymbolData;
  end;

var
  Form33: TForm33;
  segaPics: array[0..3] of TBitmap;

const segaColors : array[0..8] of integer = ($CFCFCF, $3C50F3, $2FA3FF, $04FDDF, $79FD79, $FAAC87, $F68BD5, $787878, $FFFFFF);

implementation

{$R *.dfm}

procedure DrawSega(src: integer; srcPos: TRect; dst: TCanvas; dstPos: TRect; color: integer; wMirror,hMirror: byte);
var x,y,w,h,px,py:integer;
    c : dword;
begin
    w := srcPos.Right - srcPos.Left;
    h := srcPos.Bottom - srcPos.Top;
    for y := 0 to h-1 do begin
      for x:=0 to w-1 do begin
          c := pdword(pointer(dword(segaPics[src].ScanLine[y + srcPos.Top]) + ((x+srcPos.Left) * 4)))^;
          if c > $7fffffff then begin
            if c and $ffffff > $c0c0c0 then c:=segaColors[color];
            if wMirror > 0 then px := (w-1-x)+dstPos.Left
            else px := x+dstPos.Left;
            if hMirror > 0 then py := (h-1-y)+dstPos.top
            else py := y+dstPos.top;
            dst.Pixels[px, py] := c and $FFFFFF;
          end;
      end;
    end;
end;

procedure DrawSymbolChat();
var bmp : tbitmap;
  x,y,i,w,h,c:integer;
const facemap: array[0..3] of byte = (2,0,1,3);
begin
    bmp := tbitmap.Create;
    bmp.Width := 144;
    bmp.Height := 80;
    with form33 do begin
        bmp.Canvas.Brush.Style := bssolid;
        bmp.Canvas.Brush.Color := clwhite;
        bmp.Canvas.FillRect(rect(0,0,144, 80));

        // face
        i := symbolData.face and 3;
        i := facemap[i];
        y := ((i div 2)*64) + 128;
        x := (i and 1) * 64;
        DrawSega(3,rect(x,y,x+64,y+64),bmp.Canvas, rect(40,8,0,0), (symbolData.face shr 2) and 7, 0,0);

        // corners
        if symbolData.corners[0].icon <> $FF then begin
            i := symbolData.corners[0].icon;
            y:=((i and 63) div 8) * 32;
            x := (i and 7) * 32;

            if i < 19 then DrawSega(3,rect(181,168,181+42,168+40),bmp.Canvas, rect(4,6,0,0),8, 0,0 );
            i := i div 64;
            DrawSega(i,rect(x,y,x+32,y+32),bmp.Canvas, rect(8,6,0,0),
                symbolData.corners[0].param and 7, (symbolData.corners[0].param shr 3) and 1,
                (symbolData.corners[0].param shr 4) and 1 );
        end;
        if symbolData.corners[1].icon <> $FF then begin
            i := symbolData.corners[1].icon;
            y:=((i and 63) div 8) * 32;
            x := (i and 7) * 32;

            if i < 19 then DrawSega(3,rect(128,168,128+42,168+40),bmp.Canvas, rect(99,6,0,0), 8, 0,0 );
            i := i div 64;
            DrawSega(i,rect(x,y,x+32,y+32),bmp.Canvas, rect(104,6,0,0),
                symbolData.corners[1].param and 7, (symbolData.corners[1].param shr 3) and 1,
                (symbolData.corners[1].param shr 4) and 1 );
        end;

        if symbolData.corners[2].icon <> $FF then begin
            i := symbolData.corners[2].icon;
            y:=((i and 63) div 8) * 32;
            x := (i and 7) * 32;

            if i < 19 then DrawSega(3,rect(181,128,181+42,128+40),bmp.Canvas, rect(4,46,0,0),8, 0,0 );
            i := i div 64;
            DrawSega(i,rect(x,y,x+32,y+32),bmp.Canvas, rect(8,48,0,0),
                symbolData.corners[2].param and 7, (symbolData.corners[2].param shr 3) and 1,
                (symbolData.corners[2].param shr 4) and 1 );
        end;
        if symbolData.corners[3].icon <> $FF then begin
            i := symbolData.corners[3].icon;
            y:=((i and 63) div 8) * 32;
            x := (i and 7) * 32;

            if i < 19 then DrawSega(3,rect(128,128,128+42,128+40),bmp.Canvas, rect(99,46,0,0), 8, 0,0 );
            i := i div 64;
            DrawSega(i,rect(x,y,x+32,y+32),bmp.Canvas, rect(104,48,0,0),
                symbolData.corners[3].param and 7, (symbolData.corners[3].param shr 3) and 1,
                (symbolData.corners[3].param shr 4) and 1 );
        end;

        for c:=0 to 11 do
          if symboldata.parts[c].partId <> 255 then begin
              i:=symboldata.parts[c].partId;
              if i < 48 then begin
                  y := (i div 8) * 16;
                  x := (i mod 8) * 16;
                  w:=16;
                  h:=16;
              end else if i < 60 then begin
                  y := (((i-48) div 3) * 20);
                  x := (((i-48) mod 3) * 40)+128;
                  w:=40;
                  h:=20;
              end else begin
                  y:=96;
                  x := (i-60) * 32;
                  w:=32;
                  h:=32;
              end;
              DrawSega(
                3, rect(x, y, x+w, y+h),
                bmp.Canvas,
                rect(symboldata.parts[c].posX + 40 - (w div 2),trunc(symboldata.parts[c].posY * 0.92),0,0)
                ,8,symboldata.parts[c].mirror and 1,symboldata.parts[c].mirror shr 1);
          end;

        image1.Picture.Assign(bmp);
    end;

    bmp.Free;
end;

procedure TForm33.BitBtn1Click(Sender: TObject);
var i: integer;
begin
    i := 0;
    if radiobutton2.Checked then i:= 1;
    if radiobutton3.Checked then i:= 2;
    if radiobutton4.Checked then i:= 3;

    symbolData.corners[i].param := symbolData.corners[i].param xor $8;
    DrawSymbolChat();
end;

procedure TForm33.BitBtn2Click(Sender: TObject);
var i: integer;
begin
    i := 0;
    if radiobutton2.Checked then i:= 1;
    if radiobutton3.Checked then i:= 2;
    if radiobutton4.Checked then i:= 3;

    symbolData.corners[i].param := symbolData.corners[i].param xor $10;
    DrawSymbolChat();
end;

procedure TForm33.BitBtn3Click(Sender: TObject);
var i: integer;
begin
    i := listbox1.ItemIndex;

    symbolData.parts[i].mirror := symbolData.parts[i].mirror xor $2;
    DrawSymbolChat();
end;

procedure TForm33.BitBtn4Click(Sender: TObject);
var i: integer;
begin
    i := listbox1.ItemIndex;

    symbolData.parts[i].mirror := symbolData.parts[i].mirror xor $1;
    DrawSymbolChat();
end;

procedure TForm33.Button1Click(Sender: TObject);
begin
    modalresult := 1;
end;

procedure TForm33.Button2Click(Sender: TObject);
begin
  modalresult := 0;
  close;
end;

procedure TForm33.ComboBox1Change(Sender: TObject);
begin
  symbolData.face := (symbolData.face and $FFFC) + combobox1.ItemIndex;
  DrawSymbolChat();
end;

procedure TForm33.ComboBox2Change(Sender: TObject);
var i: integer;
begin
    i := 0;
    if radiobutton2.Checked then i:= 1;
    if radiobutton3.Checked then i:= 2;
    if radiobutton4.Checked then i:= 3;

    symbolData.corners[i].icon := combobox2.ItemIndex -1;
    DrawSymbolChat();
end;

procedure TForm33.ComboBox2DrawItem(Control: TWinControl; Index: Integer; cRect: TRect; State: TOwnerDrawState);
var x,y,i:integer;
    bmp : tbitmap;
begin
  combobox2.Canvas.Brush.Style := bssolid;
  combobox2.Canvas.Brush.Color := clwhite;
  if odSelected in State then combobox2.Canvas.Brush.Color := clblue;

  combobox2.Canvas.FillRect(cRect);
  i:= index-1;
  if i >= 0 then begin
    y := (i mod 64) div 8;
    x := i mod 8;
    i := i div 64;

    DrawSega(
      i, rect(x*32, y*32, (x*32) + 32, (y*32) + 32),
      combobox2.Canvas,
      rect(cRect.left,cRect.Top,cRect.Left+32,cRect.Top+32)
      ,8,0,0);

  end;
end;

procedure TForm33.ComboBox3Change(Sender: TObject);
var i: integer;
begin
    i := 0;
    if radiobutton2.Checked then i:= 1;
    if radiobutton3.Checked then i:= 2;
    if radiobutton4.Checked then i:= 3;

    symbolData.corners[i].param := (symbolData.corners[i].param and $f8) + combobox3.ItemIndex;
    DrawSymbolChat();
end;

procedure TForm33.ComboBox3DrawItem(Control: TWinControl; Index: Integer; cRect: TRect; State: TOwnerDrawState);
begin
   combobox3.Canvas.Brush.Style := bssolid;
   combobox3.Canvas.Brush.Color := segaColors[Index];
   combobox3.Canvas.FillRect(cRect);
end;

procedure TForm33.ComboBox4Change(Sender: TObject);
begin
    symbolData.face := (symbolData.face and $FFE3) + (combobox4.ItemIndex * 4);
    DrawSymbolChat();
end;

procedure TForm33.ComboBox4DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
    combobox4.Canvas.Brush.Style := bssolid;
   combobox4.Canvas.Brush.Color := segaColors[Index];
   combobox4.Canvas.FillRect(Rect);
end;

procedure TForm33.ComboBox5Change(Sender: TObject);
var i:integer;
begin
    i := listbox1.ItemIndex;
    symbolData.parts[i].partId := combobox5.ItemIndex-1;
    DrawSymbolChat();
end;

procedure TForm33.ComboBox5DrawItem(Control: TWinControl; Index: Integer; cRect: TRect; State: TOwnerDrawState);
var x,y,i,w,h:integer;
begin
  combobox5.Canvas.Brush.Style := bssolid;
  combobox5.Canvas.Brush.Color := clwhite;
  if odSelected in State then combobox5.Canvas.Brush.Color := clblue;

  combobox5.Canvas.FillRect(cRect);
  i:= index-1;
  if i >= 0 then begin
    if i < 48 then begin
        y := (i div 8) * 16;
        x := (i mod 8) * 16;
        w:=16;
        h:=16;
    end else if i < 60 then begin
        y := (((i-48) div 3) * 20);
        x := (((i-48) mod 3) * 40)+128;
        w:=40;
        h:=20;
    end else begin
        y:=96;
        x := (i-60) * 32;
        w:=32;
        h:=32;
    end;


    DrawSega(
      3, rect(x, y, x+w, y+h),
      combobox5.Canvas,
      rect(cRect.left,cRect.Top,cRect.Left+32,cRect.Top+32)
      ,8,0,0);

  end;
end;

procedure TForm33.ComboBox6Change(Sender: TObject);
begin
    symbolData.face := (symbolData.face and $1f) + (combobox6.ItemIndex shl 5);
    DrawSymbolChat();
end;

procedure TForm33.FormCreate(Sender: TObject);
var x:integer;
  s: ansistring;
begin
    combobox2.Items.Clear;
    for x:=0 to 191 do combobox2.Items.Add(inttostr(x));
    for x:=0 to 67 do combobox5.Items.Add(inttostr(x));

    if segaPics[0] = nil then begin
      for x:= 0 to 3 do begin
        segaPics[x] := tbitmap.Create;
        segaPics[x].PixelFormat := pf32bit;
        segaPics[x].Width := 256;
        segaPics[x].Height := 256;
        fillchar(pansichar(segaPics[x].ScanLine[255])[0],256*256*4,0);  // clear transparent
        imagelist1.draw(segaPics[x].Canvas,0,0,x);
      end;
    end;
    s :=#$0#$0#$00#$00#$ff#$00#$FF#$00#$FF#$00#$FF#$00#$ff#$00#$00#$00#$ff#$00#$00#$00
    +#$ff#$00#$00#$00#$ff#$00#$00#$00#$ff#$00#$00#$00#$ff#$00#$00#$00
    +#$ff#$00#$00#$00#$ff#$00#$00#$00#$ff#$00#$00#$00#$ff#$00#$00#$00
    +#$ff#$00#$00#$00#$ff#$00#$00#$00;
    move(s[1],symbolData.face,length(s));

end;

procedure TForm33.FormShow(Sender: TObject);
begin
  listbox1.ItemIndex := 0;
    RadioButton1Click(nil);
    combobox1.ItemIndex := symbolData.face and 3;
    combobox4.ItemIndex := (symbolData.face shr 2) and 7;
    ListBox1Click(nil);
    combobox6.ItemIndex := (symbolData.face shr 5) and 15;
    DrawSymbolChat();
end;

procedure TForm33.ListBox1Click(Sender: TObject);
var i: integer;
begin
    i := listbox1.ItemIndex;
    combobox5.ItemIndex := byte(symbolData.parts[i].partId+1);
    scrollbar1.Position := symbolData.parts[i].posX;
    scrollbar2.Position := symbolData.parts[i].posY;

end;

procedure TForm33.RadioButton1Click(Sender: TObject);
var i: integer;
begin
    i := 0;
    if radiobutton2.Checked then i:= 1;
    if radiobutton3.Checked then i:= 2;
    if radiobutton4.Checked then i:= 3;

    combobox2.ItemIndex := byte(symbolData.corners[i].icon + 1);
    combobox3.ItemIndex := symbolData.corners[i].param and 7;
end;

procedure TForm33.ScrollBar1Change(Sender: TObject);
var i: integer;
begin
    i := listbox1.ItemIndex;
    symbolData.parts[i].posX := scrollbar1.Position;
    DrawSymbolChat();
end;

procedure TForm33.ScrollBar2Change(Sender: TObject);
var i: integer;
begin
    i := listbox1.ItemIndex;
    symbolData.parts[i].posY := scrollbar2.Position;
    DrawSymbolChat();
end;

end.
