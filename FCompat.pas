unit FCompat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, System.ImageList, Vcl.Themes, Vcl.Styles,
  Vcl.Menus;

type
  TForm27 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Clearunusedlabels1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Clearunusedlabels1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Er,wa:array[0..4] of tstringlist;
  end;

var
  Form27: TForm27;

implementation

{$R *.dfm}

uses main, TCom, FScrypt;

var
  btnpos: TPoint;

procedure TForm27.Button1Click(Sender: TObject);
begin
    close;
end;

procedure TForm27.Clearunusedlabels1Click(Sender: TObject);
var
  i, l, c, ep, x, y: integer;
const
  DefaultLabel: array [0 .. 21] of integer = (100, 90, 120, 130, 80, 70, 60, 140, 110, 30, 50, 1, 20, 850, 800, 830,
    820, 810, 860, 870, 840, 880);
  DefaultLabel2: array [0 .. 18] of integer = (720, 660, 620, 600, 501, 520, 560, 540, 580, 680, 950, 900, 930, 920,
  910, 960, 970, 940, 980);
begin
  if MessageDlg(GetLanguageString(513),
    mtWarning, [mbYes, mbNo], 0) = mrYes then begin
      // Search and remove any unused NPC functions
      ep := GetEpisode;
      for x := 0 to 20 do
      if Form1.CheckListBox1.Checked[x] then
      begin
        for y := 0 to Floor[x].MonsterCount - 1 do
        begin
          for i := 0 to 57 do
            if EnemyID[i] = Floor[x].Monster[y].Skin then
              break;
          if i = 58 then
          begin
              if round(Floor[x].Monster[y].Action) > 0 then
              begin
                c := 0;
                if ep = 1 then
                begin
                  for l := 0 to 9 do
                    if DefaultLabel2[l] = round(Floor[x].Monster[y].Action) then
                      c := 1;
                end
                else
                begin
                  for l := 0 to 12 do
                    if DefaultLabel[l] = round(Floor[x].Monster[y].Action) then
                      c := 1;
                end;
                if c = 0 then
                  if LookForLabel2(inttostr(round(Floor[x].Monster[y].Action))) = 0 then
                  begin
                    Floor[x].Monster[y].Action := 0;
                  end;
              end;
          end;
        end;
      end;
      // Refresh the list and clear the buttons
      form1.Compatibilitycheck1Click(form27);
      unusedlabel := false;
      Listbox1.Invalidate;
    end;
end;

procedure TForm27.ListBox1Click(Sender: TObject);
begin
    memo1.Clear;
    if (wa[listbox1.ItemIndex].Count = 0) and (er[listbox1.ItemIndex].Count = 0) then Memo1.Lines.Add('This quest should be fully compatible with this version.')
    else begin
        if er[listbox1.ItemIndex].Count > 0 then begin
            memo1.lines.Add('Errors:');
            memo1.lines.AddStrings(er[listbox1.ItemIndex]);
            memo1.lines.Add('');
        end;
        if wa[listbox1.ItemIndex].Count > 0 then begin
            memo1.lines.Add('Warnings:');
            memo1.lines.AddStrings(wa[listbox1.ItemIndex]);
        end;
    end;
end;

procedure TForm27.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  imgrect: TRect;
begin
    if darkmode then
    begin
      listbox1.Canvas.Brush.Color:=RGB(100,100,100);
      if odSelected in State then listbox1.Canvas.Brush.Color:=RGB(70,120,180);
      listbox1.Canvas.FillRect(rect);

      if er[index].Count > 0 then imagelist1.Draw(listbox1.Canvas,0,rect.top,0)
      else if wa[index].Count > 0 then imagelist1.Draw(listbox1.Canvas,0,rect.top,1)
      else imagelist1.Draw(listbox1.Canvas,0,rect.top,2);

      listbox1.Canvas.Font.Color := RGB(235,235,235);
      listbox1.Canvas.TextOut(24,rect.top+5,listbox1.Items.Strings[index]);
    end
    else
    begin
      listbox1.Canvas.Brush.Color:=$FFFFFF;
      if TStyleManager.IsCustomStyleActive then
      begin
        if odSelected in State then listbox1.Canvas.Brush.Color:=$D4B7B6;
      end
      else
      begin
        if state <> [] then listbox1.Canvas.Brush.Color:=$D4B7B6;
      end;
      listbox1.Canvas.FillRect(rect);

      if er[index].Count > 0 then imagelist1.Draw(listbox1.Canvas,0,rect.top,0)
      else if wa[index].Count > 0 then imagelist1.Draw(listbox1.Canvas,0,rect.top,1)
      else imagelist1.Draw(listbox1.Canvas,0,rect.top,2);

      listbox1.Canvas.TextOut(24,rect.top+5,listbox1.Items.Strings[index]);
    end;

    if (odSelected in State) and (listbox1.ItemIndex <> 4) and unusedlabel then
    begin
      imgrect := rect;
      Form5.ImageList2.Draw(listbox1.Canvas, imgrect.right-16, imgrect.top+4, 0);
      btnPos.X := imgrect.right-16;
    end;
    if not unusedlabel or (listbox1.ItemIndex = 4) then btnpos.X := 0;
end;

procedure TForm27.ListBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if ((x >= btnPos.X) and (x <= btnpos.X+15))
  and (Button = mbLeft) and unusedlabel then
  begin
    // Scroll to the end
    SendMessage(Memo1.Handle, EM_LINESCROLL, 0, Memo1.Lines.Count);
    PopupMenu1.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
  end;
end;

end.
