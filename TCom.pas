unit TCom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,  ImgList, ExtCtrls,
   shellapi, System.ImageList, Vcl.Grids;

type
  TForm5 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label6: TLabel;
    Edit5: TEdit;
    ImageList1: TImageList;
    ComboBox1: TComboBox;
    Image1: TImage;
    UnicodeStringGrid1: TStringGrid;
    TabControl1: TTabControl;
    ImageList2: TImageList;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure TabControl1Change(Sender: TObject);
    procedure UnicodeStringGrid1DrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure UnicodeStringGrid1MouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure UnicodeStringGrid1MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UnicodeStringGrid1SetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: string);
    procedure UnicodeStringGrid1Enter(Sender: TObject);
    procedure UnicodeStringGrid1Exit(Sender: TObject);
    procedure UnicodeStringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }

  end;
  Function LookForLabel(s:string):integer;
  procedure CellEdited(ACol, ARow: Integer; const Value: string);

var
  Form5: TForm5;
  lastmode:integer = 0;
  dwval:array[0..30] of dword;
  HaveBtn:boolean;
  btnpos:tpoint;
  editrow,editcol:integer;

const ArgName: array[0..24] of string = ('T_NONE',
	'T_IMED',
	'T_ARGS',
	'T_PUSH',
	'T_VASTART',
	'T_VAEND',
	'T_DC',

	'T_REG',
	'T_BYTE',
	'T_WORD',
	'T_DWORD',
	'T_FLOAT',
	'T_STR',

	'T_RREG',
	'T_FUNC',
	'T_FUNC2',
	'T_SWITCH',
	'T_SWITCH2B',
	'T_PFLAG',

	'T_STRDATA',
	'T_DATA',
    'T_BREG',
    'T_DREG',
    'HEX:',
    'STR:');

implementation

uses main, FScrypt, Unit1, NPCBuild, EnemyStat, Unit23, FEnemyResist,
  FEnemyAttack, FEnemyMov, FFloatEdit, FVector;

{$R *.dfm}

procedure TForm5.ComboBox1Change(Sender: TObject);
var x:integer;
begin
    //change the arg name and number
    UnicodeStringGrid1.Enabled:=true;
    HaveBtn:=false;
    if (ComboBox1.ItemIndex < ComboBox1.Items.Count) and (ComboBox1.ItemIndex>-1) then begin
    for x:=0 to 9 do if AsmCode[ComboBox1.ItemIndex].arg[x] = 0 then break;
    UnicodeStringGrid1.RowCount:=x;
    if x = 0 then begin
        UnicodeStringGrid1.Enabled:=false;
        UnicodeStringGrid1.Cells[0,0]:='';
        UnicodeStringGrid1.Cells[0,1]:='';
    end;

    for x:=0 to 9 do begin
        if AsmCode[ComboBox1.ItemIndex].arg[x] = 0 then break
        else
        UnicodeStringGrid1.Cells[0,x]:=ArgName[AsmCode[ComboBox1.ItemIndex].arg[x]];
    end;

    imagelist1.Draw(image1.Canvas,0,0,(AsmCode[ComboBox1.ItemIndex].ver*2)+1);
    UnicodeStringGrid1.Repaint;
    image1.Refresh;
    end else begin
        UnicodeStringGrid1.RowCount:=0;
        UnicodeStringGrid1.Enabled:=false;
        UnicodeStringGrid1.Cells[0,0]:='';
        UnicodeStringGrid1.Cells[0,1]:='';
    end;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
    close;
end;

Procedure GoToLabel(s:string);
var x:integer;
begin
    for x:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[x],1,length(s)+1) = s+':' then break;
    form4.ListBox1.itemindex:=x;
end;

Function LookForLabel(s:string):integer;
var x:integer;
begin
    result:=0;
    for x:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[x],1,length(s)+1) = s+':' then
        if copy(form4.ListBox1.Items.Strings[x],9,4) = 'HEX:' then result:=1;
end;

procedure TForm5.Button1Click(Sender: TObject);
var s,o:widestring;
    x,y,g,j,d:int64;
    i:double;
    f:single;
begin
    x:=0;
    if ComboBox1.ItemIndex = -1 then begin
        ShowMessage(getlanguagestring(207));
        exit;
    end;
    if edit5.Text <> '' then try
         g:=strtoint(edit5.Text);
         if dword(g) > 65535 then begin
             MessageDlg(getlanguagestring(208), mtInformation,[mbOk], 0);
            exit;
         end;
    except
    MessageDlg(getlanguagestring(209), mtInformation,[mbOk], 0);
    exit;
    end;
    //check the data to be sure it compilent

      isedited:=true;
    while AsmCode[ComboBox1.ItemIndex].arg[x] <> 0 do begin
        s:='';
        s:=UnicodeStringGrid1.Cells[1,x];
        if (AsmCode[ComboBox1.ItemIndex].arg[x] <> T_STR) and
            (AsmCode[ComboBox1.ItemIndex].arg[x] <> T_STRHEX) then
        s:=uppercase(s);
        if s = '' then begin
            MessageDlg(getlanguagestring(210), mtInformation,[mbOk], 0);
            exit;
            end;

        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_REG) or
            (AsmCode[ComboBox1.ItemIndex].arg[x] = T_BREG) or
            (AsmCode[ComboBox1.ItemIndex].arg[x] = T_DREG) or
           (AsmCode[ComboBox1.ItemIndex].arg[x] = T_RREG) then begin
           if (AsmCode[ComboBox1.ItemIndex].order = T_Args) and
            ((length(s) = 8) or (lowercase(copy(s,1,1))<> 'r')) then begin
           y:=hextoint(s);
           if y = -1 then begin
                MessageDlg(getlanguagestring(211), mtInformation,[mbOk], 0);
                exit;
           end;
           if y>$FFFFFFff then begin
                MessageDlg(getlanguagestring(212), mtInformation,[mbOk], 0);
                exit;
           end;
           s:=inttohex(y,8);

           end else begin
           if s[1] = 'R' then s:=copy(s,2,length(s)-1);
           y:=strtoint(s);
           AddRegister(y);
           if y>255 then begin
                MessageDlg(getlanguagestring(213), mtInformation,[mbOk], 0);
                exit;
           end;
           s:='R'+inttostr(y);
           end;
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_STR) then begin
           s:=''''+s+'''';
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_BYTE) then begin
           y:=hextoint(s);
           if y = -1 then begin
                MessageDlg(getlanguagestring(214), mtInformation,[mbOk], 0);
                exit;
           end;
           if y>255 then begin
                MessageDlg(getlanguagestring(215), mtInformation,[mbOk], 0);
                exit;
           end;
           s:=inttohex(y,2);
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_WORD) then begin
           y:=hextoint(s);
           if y = -1 then begin
                MessageDlg(getlanguagestring(216), mtInformation,[mbOk], 0);
                exit;
           end;
           if y>65535 then begin
                MessageDlg(getlanguagestring(217), mtInformation,[mbOk], 0);
                exit;
           end;
           s:=inttohex(y,4);
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_PFLAG) then begin
           y:=hextoint(s);
           if y = -1 then begin
                MessageDlg(getlanguagestring(218), mtInformation,[mbOk], 0);
                exit;
           end;
           if y>65535 then begin
                MessageDlg(getlanguagestring(219), mtInformation,[mbOk], 0);
                exit;
           end;
           s:=inttohex(y,4);
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_FUNC) or
            (AsmCode[ComboBox1.ItemIndex].arg[x] = T_DATA) or
            (AsmCode[ComboBox1.ItemIndex].arg[x] = T_STRDATA) or
            (AsmCode[ComboBox1.ItemIndex].arg[x] = T_FUNC2) then begin
           y:=strtoint(s);
           if y>65535 then begin
                MessageDlg(getlanguagestring(220), mtInformation,[mbOk], 0);
                exit;
           end;
           s:=inttostr(y);
        end else

        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_FLOAT) then begin
            if (AsmCode[ComboBox1.ItemIndex].order = T_Args) and
            (s[1] = 'R') then begin
            s:=copy(s,2,length(s)-1);
           y:=strtoint(s);
           if y>255 then begin
                MessageDlg(getlanguagestring(221), mtInformation,[mbOk], 0);
                exit;
           end;
           s:='R'+inttostr(y);
            end else begin
           i:=strtofloat(s);
           s:=floattostr(i);
           end;
        end else

        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_SWITCH) then begin
           g:=strtoint(copy(s,1,pos(':',s)-1));
           o:=copy(s,pos(':',s)+1,length(s)-pos(':',s));
           s:=inttostr(g);
           while g > 0 do begin
                d:=pos(':',o);
                if (g = 1) and (d > 0) then begin
                    MessageDlg(getlanguagestring(222), mtInformation,[mbOk], 0);
                        exit;
                end;
                if d = 0 then begin
                    if g = 1 then d:=length(o)+1
                    else begin
                        MessageDlg(getlanguagestring(222), mtInformation,[mbOk], 0);
                        exit;
                    end;
                end;
                j:=strtoint(copy(o,1,d-1));
                o:=copy(o,d+1,length(o)-d);
                dec(g);
                s:=s+':'+inttostr(j);
           end;
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_SWITCH2B) then begin
           g:=strtoint(copy(s,1,pos(':',s)-1));
           o:=copy(s,pos(':',s)+1,length(s)-pos(':',s));
           s:=inttostr(g);
           while g > 0 do begin
                d:=pos(':',o);
                if (g = 1) and (d > 0) then begin
                    MessageDlg(getlanguagestring(222), mtInformation,[mbOk], 0);
                        exit;
                end;
                if d = 0 then begin
                    if g = 1 then d:=length(o)+1
                    else begin
                        MessageDlg(getlanguagestring(222), mtInformation,[mbOk], 0);
                        exit;
                    end;
                end;
                j:=strtoint(copy(o,1,d-1));
                o:=copy(o,d+1,length(o)-d);
                dec(g);
                s:=s+':'+inttostr(j);
           end;
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_STRHEX) then begin
           s:=s;
        end else
        if (AsmCode[ComboBox1.ItemIndex].arg[x] = T_HEX) then begin
           s:=s;
        end else
        begin
           if (AsmCode[ComboBox1.ItemIndex].order = T_Args) and
            (s[1] = 'R') then begin
            if s[1] = 'R' then s:=copy(s,2,length(s)-1);
           y:=strtoint(s);
           if y>255 then begin
                MessageDlg(getlanguagestring(223), mtInformation,[mbOk], 0);
                exit;
           end;
           AddRegister(y);
           s:='R'+inttostr(y);
           end else begin
           if TabControl1.TabIndex = 0 then y:=hextoint(s);
           if TabControl1.TabIndex = 1 then y:=dword(strtoint(s));
           if TabControl1.TabIndex = 2 then begin
                y:=0;
                f:=strtofloat(s);
                move(f,y,4);
           end;
           if y = -1 then begin
                MessageDlg(getlanguagestring(211), mtInformation,[mbOk], 0);
                exit;
           end;
           if y>$FFFFFFff then begin
                MessageDlg(getlanguagestring(224), mtInformation,[mbOk], 0);
                exit;
           end;
           s:=inttohex(dword(y),8);
           end;
        end;

        UnicodeStringGrid1.Cells[1,x]:=s;

        inc(x);
    end;
    //add the line
    s:='';
    if edit5.Text <> '' then s:=edit5.Text+':';
    while length(s) < 8 do s:=s+' ';
    s:=s+AsmCode[ComboBox1.ItemIndex].name+' ';
    {if Edit1.Enabled then s:=s+edit1.wideText;
    if Edit2.Enabled then s:=s+', '+edit2.wideText;
    if Edit3.Enabled then s:=s+', '+edit3.wideText;
    if Edit4.Enabled then s:=s+', '+edit4.wideText;  }
    x:=0;
    while AsmCode[ComboBox1.ItemIndex].arg[x] <> 0 do begin
        if x > 0 then s:=s+', ';
        s:=s+UnicodeStringGrid1.Cells[1,x];
        inc(x);
    end;

    //s:='get_npc_data '
    if (lowercase(combobox1.Text) = GetOpcodeName($f841)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,0]));
        if (x > 1) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;
    //s:='call_image_data';
    if (lowercase(combobox1.Text) = GetOpcodeName($f8ee)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,1]));
        if (x <> 3) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;
    //'get_attack_data'
    if (lowercase(combobox1.Text) = GetOpcodeName($f893)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,0]));
        if (x <> 7) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;
    //'get_movement_data'
    if (lowercase(combobox1.Text) = GetOpcodeName($f895)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,0]));
        if (x <> 8) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;
    //'get_resist_data'
    if (lowercase(combobox1.Text) = GetOpcodeName($f894)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,0]));
        if (x <> 6) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;
    //'get_physical_data'
    if (lowercase(combobox1.Text) = GetOpcodeName($f892)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,0]));
        if (x <> 5) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;

    //'get_physical_data'
    if (lowercase(combobox1.Text) = GetOpcodeName($f8f2)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,5]));
        if (x <> 10) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;

    if (lowercase(combobox1.Text) = GetOpcodeName($f8db)) then begin
        x:=GetReferenceType(strtoint(UnicodeStringGrid1.Cells[1,5]));
        if (x <> 10) and (x <> 0) then begin
        Showmessage(getlanguagestring(225)+' '+REFNAME[x]+getlanguagestring(226));
        exit;
        end;
    end;

    if form5.Tag = 0 then begin
    if form4.ListBox1.ItemIndex > -1 then begin
        Form4.ListBox1.Items.Insert(form4.ListBox1.ItemIndex+1,s);
        form4.ListBox1.ItemIndex:=form4.ListBox1.ItemIndex+1;
    end
    else Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Add(s);
    end else begin
        o:=Form4.ListBox1.Items.Strings[form4.ListBox1.ItemIndex];
        Form4.ListBox1.Items.Strings[form4.ListBox1.ItemIndex]:=s;
        RemoveRef(o);
    end;

    if edit5.Text <> '' then try
         g:=strtoint(edit5.Text);
         if (AsmCode[ComboBox1.ItemIndex].name = 'STR:') then AddStrRef(g)
         else if (AsmCode[ComboBox1.ItemIndex].name = 'HEX:') then AddDataRef(g)
         else AddLabel(g);
    except
    end;
    //check the data to be sure it compilent
    if (AsmCode[ComboBox1.ItemIndex].name <> 'STR:') and (AsmCode[ComboBox1.ItemIndex].name <> 'HEX:') then
        AddFunctionUsed(AsmCode[ComboBox1.ItemIndex].name);



    y:= Form4.ListBox1.ItemIndex;

    //npc
    if lowercase(combobox1.Text) = GetOpcodeName($f841) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form20.SpinEdit1.Value:=strtoint(UnicodeStringGrid1.Cells[1,0]);
            form4.Button10Click(form4);
        end;

    end;
    //phys
    if lowercase(combobox1.Text) = GetOpcodeName($f892) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form21.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
            form4.EnemyStatEdit(form4);
        end;
    end;
    //resist
    if lowercase(combobox1.Text) = GetOpcodeName($f894) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form24.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
            form4.EnemyResistEdit(form4);       
        end;
    end;
    //movement
    if lowercase(combobox1.Text) = GetOpcodeName($f895) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form26.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
            form4.EnemyMovementEdit(form4);
        end;
    end;
    //attack
    if lowercase(combobox1.Text) = GetOpcodeName($f893) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form25.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
            form4.EnemyAttackEdit(form4);
        end;
    end;

    if lowercase(combobox1.Text) = GetOpcodeName($f8ee) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,1]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form5.Tag:=strtoint(UnicodeStringGrid1.Cells[1,1]);
            g:=form4.Button11Click(form5);
        end;
       // if g > 0 then Form4.ListBox1.wideItems.Strings[y]:=copy(s,1,24)+inttohex(g,8)+', '+UnicodeStringGrid1.Cells[1,1];
    end;


    if lowercase(combobox1.Text) = GetOpcodeName($f8f2) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,5]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form32.Tag:=strtoint(UnicodeStringGrid1.Cells[1,5]);
            form4.EditVectordata1Click(form5);
        end;
       // if g > 0 then Form4.ListBox1.wideItems.Strings[y]:=copy(s,1,24)+inttohex(g,8)+', '+UnicodeStringGrid1.Cells[1,1];
    end;

    // get vector position
    if lowercase(combobox1.Text) = GetOpcodeName($f8db) then begin
        x:=LookForLabel(UnicodeStringGrid1.Cells[1,5]);
        if x = 0 then begin
            Form4.ListBox1.ItemIndex:=Form4.ListBox1.Items.Count-1;
            form32.Tag:=strtoint(UnicodeStringGrid1.Cells[1,5]);
            form4.EditVectordata1Click(form5);
        end;
    end;


     Form4.ListBox1.ItemIndex:=y;

     if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($c4))) or
        (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f80d))) or
        (lowercase(combobox1.Text) = lowercase(GetOpcodeName($9))) then ScanForMap;

     if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f951))) then begin
         //bb map
         s:=Form4.ListBox1.Items.Strings[y];
         delete(s,1,9+length(GetOpcodeName($f951)));
         x:=hextoint(copy(s,1,2));
         g:=hextoint(copy(s,5,4));
         y:=hextoint(copy(s,11,2));
         if x < 30 then begin
         mapxvmfile[x]:=path+'map\xvm\'+mapxvmname[mapid[g]+y];
         mapfile[x]:=path+'map\'+mapfilename[mapid[g]+y];
         floor[x].floorid:=MapArea[mapid[g]+y];
         Form1.CheckListBox1.Items.Strings[x]:=mapname[mapid[g]+y];
         end;
     end;
    form4.ListBox1.Repaint;
    close;
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
    form5.ClientHeight:=190;
end;

procedure TForm5.Button4Click(Sender: TObject);
var s:widestring;
begin
    if edit5.Text <> '' then s:=edit5.Text+':';
    while length(s) < 8 do s:=s+' ';
    //s:=s+edit6.WideText;
    if form5.Tag = 0 then begin
    if form4.ListBox1.ItemIndex > -1 then Form4.ListBox1.Items.Insert(form4.ListBox1.ItemIndex+1,s)
    else Form4.ListBox1.Items.Add(s);
    end else Form4.ListBox1.Items.Strings[form4.ListBox1.ItemIndex]:=s;
    close;
end;

procedure TForm5.ComboBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
    TComboBox(Control).Canvas.Brush.Style := bsSolid;
    if state <> [] then begin
        TComboBox(Control).Canvas.Brush.Color:=$00DCCFC7;
        TComboBox(Control).Canvas.FillRect(rect);
        //draw the version
        imagelist1.Draw(TComboBox(Control).Canvas,rect.right-45,rect.top,(AsmCode[Index].ver*2)+1,true );
        TComboBox(Control).Canvas.Pen.color := clNavy;

        TComboBox(Control).Canvas.Brush.Style := bsClear;
        TComboBox(Control).Canvas.RoundRect(Rect.Left, Rect.top, Rect.Right, Rect.Bottom, 6, 6);
        TComboBox(Control).Canvas.TextOut(rect.Left+3,rect.Top,combobox1.Items.Strings[index]);
    end else begin
        TComboBox(Control).Canvas.Pen.color := 0;
        TComboBox(Control).Canvas.Brush.Color:=$FFFfFf;
        TComboBox(Control).Canvas.FillRect(rect);
        TComboBox(Control).Canvas.Brush.Style := bsClear;
        imagelist1.Draw(TComboBox(Control).Canvas,rect.right-45,rect.top,(AsmCode[Index].ver*2),true );
        TComboBox(Control).Canvas.TextOut(rect.Left+3,rect.Top,combobox1.Items.Strings[index]);
    end;
//    odSelected
end;

procedure TForm5.TabControl1Change(Sender: TObject);
var y:dword;
    f:single;
    s:widestring;
    i:integer;
begin
    for i:=0 to unicodestringgrid1.RowCount-1 do
    if (unicodestringgrid1.Cells[0,i] = 'T_DWORD') or (unicodestringgrid1.Cells[0,i] = 'T_REG') then
    if copy(unicodestringgrid1.Cells[1,i],1,1) <> 'R' then begin
    s:=unicodestringgrid1.Cells[1,i];
    if lastmode = 0 then y:=hextoint(s);
    if lastmode = 1 then y:=strtoint(s);
    if lastmode = 2 then begin
        y:=0;
        if s = 'NAN' then y:=dwval[i]
        else begin
        f:=strtofloat(s);
        move(f,y,4);
        end;
    end;
    if tabcontrol1.TabIndex = 0 then s:=inttohex(y,8);
    if tabcontrol1.TabIndex = 1 then s:=inttostr(integer(y));
    if tabcontrol1.TabIndex = 2 then begin
        move(y,f,4);
        s:=floattostr(f);
        if s = 'NAN' then dwval[i]:=y;
    end;

    unicodestringgrid1.Cells[1,i]:=s;
    end;
    lastmode:=tabcontrol1.TabIndex;
end;

procedure TForm5.UnicodeStringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
    if Acol = 1 then begin
        if ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f841))) and (arow=0)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f891))) and (arow=0)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f892))) and (arow=0)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f894))) and (arow=0)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f893))) and (arow=0)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f895))) and (arow=0)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f8f2))) and (arow=5)) or
        ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f8db))) and (arow=5)) or
         ((lowercase(combobox1.Text) = lowercase(GetOpcodeName($f8ee))) and (arow=1)) then begin
             HaveBtn:=true;
             BtnPos.X:=rect.right-16;
             BtnPos.Y:=rect.top+1;
            imagelist2.Draw(UnicodeStringGrid1.Canvas,rect.right-16,rect.top+1,0,true);
         end;
    end;
end;

procedure TForm5.UnicodeStringGrid1Enter(Sender: TObject);
begin
  editcol:=-1;
    editrow:=-1;
end;

procedure TForm5.UnicodeStringGrid1Exit(Sender: TObject);
begin
  if (EditCol <> -1) and (EditRow <> -1) then
    begin
      CellEdited(EditCol, EditRow, UnicodeStringGrid1.Cells[1,EditRow]);
      EditCol := -1;
      EditRow := -1;
    end;
end;

procedure TForm5.UnicodeStringGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i,c:integer;
begin
    if havebtn then
    if (x >= BtnPos.X) and (x <= BtnPos.X+15) and
            (y >= BtnPos.y) and (y <= BtnPos.y+15) then
    if button = mbLeft then begin
         //load the window if the cell isnt empty
         i:=form4.ListBox1.ItemIndex;
         if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f891))) then begin
            c:=getepisode;
            if c = 2 then begin
                Showmessage(getlanguagestring(227));
            end else begin
                form23.tag:=c;
                if form23.showmodal = 1 then UnicodeStringGrid1.Cells[1,0]:=inttohex(form23.myresult,8);
            end;
         end;

         if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f841))) then begin
            if UnicodeStringGrid1.Cells[1,0] = '' then begin
                Showmessage(getlanguagestring(228));
                exit;
            end;
             c:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
             if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,0]);
                form20.SpinEdit1.Value:=strtoint(UnicodeStringGrid1.Cells[1,0]);
                form4.Button10Click(form4);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(229));
            end;
         end;

         if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f892))) then begin
            if UnicodeStringGrid1.Cells[1,0] = '' then begin
                Showmessage(getlanguagestring(230));
                exit;
            end;
             c:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
             if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,0]);
                form21.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
                form4.EnemyStatEdit(form4);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(231));
            end;
         end;

         if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f894))) then begin
            if UnicodeStringGrid1.Cells[1,0] = '' then begin
                Showmessage(getlanguagestring(232));
                exit;
            end;
             c:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
             if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,0]);
                form24.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
                form4.EnemyResistEdit(form4);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(233));
            end;
         end;

          if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f895))) then begin
            if UnicodeStringGrid1.Cells[1,0] = '' then begin
                Showmessage(getlanguagestring(232));
                exit;
            end;
             c:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
             if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,0]);
                form26.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
                form4.EnemyMovementEdit(form4);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(234));
            end;
         end;

         if (lowercase(combobox1.Text) = lowercase(GetOpcodeName($f893))) then begin
            if UnicodeStringGrid1.Cells[1,0] = '' then begin
                Showmessage(getlanguagestring(232));
                exit;
            end;
             c:=LookForLabel(UnicodeStringGrid1.Cells[1,0]);
             if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,0]);
                form25.tag:=strtoint(UnicodeStringGrid1.Cells[1,0]);
                form4.EnemyattackEdit(form4);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(235));
            end;
         end;

         if lowercase(combobox1.Text) = lowercase(GetOpcodeName($f8ee)) then begin
            if UnicodeStringGrid1.Cells[1,1] = '' then begin
                Showmessage(getlanguagestring(232));
                exit;
            end;
            c:=LookForLabel(UnicodeStringGrid1.Cells[1,1]);
            if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,1]);
                form5.Tag:=0;
                form4.Button11Click(form5);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(236));
            end;
        end;

        if lowercase(combobox1.Text) = lowercase(GetOpcodeName($f8f2)) then begin
            if UnicodeStringGrid1.Cells[1,5] = '' then begin
                Showmessage(getlanguagestring(232));
                exit;
            end;
            c:=LookForLabel(UnicodeStringGrid1.Cells[1,5]);
            if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,5]);
                form32.Tag:=0;
                form4.EditVectordata1Click(form5);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(237));
            end;
        end;

        if lowercase(combobox1.Text) = lowercase(GetOpcodeName($f8db)) then begin
            if UnicodeStringGrid1.Cells[1,5] = '' then begin
                Showmessage(getlanguagestring(232));
                exit;
            end;
            c:=LookForLabel(UnicodeStringGrid1.Cells[1,5]);
            if c = 1 then begin//find it
                GoToLabel(UnicodeStringGrid1.Cells[1,5]);
                form32.Tag:=0;
                form4.EditVectordata1Click(form5);
            end;
            if c = 0 then begin
                Showmessage(getlanguagestring(237));
            end;
        end;

         form4.ListBox1.ItemIndex:=i;
    end;
end;

procedure TForm5.UnicodeStringGrid1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
    if havebtn then
    if Shift = [ssLeft] then begin
         if (x >= BtnPos.X) and (x <= BtnPos.X+15) and
            (y >= BtnPos.y) and (y <= BtnPos.y+15) then
             imagelist2.Draw(UnicodeStringGrid1.Canvas,BtnPos.X,BtnPos.y,1,true)
         else imagelist2.Draw(UnicodeStringGrid1.Canvas,BtnPos.X,BtnPos.y,0,true);
    end;
end;

procedure TForm5.UnicodeStringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    if (EditCol <> -1) and (EditRow <> -1) then
    begin
      CellEdited(EditCol, EditRow, UnicodeStringGrid1.Cells[1,EditRow]);
      EditCol := -1;
      EditRow := -1;
    end;
end;

procedure TForm5.UnicodeStringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
begin
  if (ACol <> EditCol) or (ARow <> EditRow) then
      begin
        if (EditCol <> -1) and (editrow <> -1) then
        CellEdited(EditCol, EditRow,UnicodeStringGrid1.Cells[1,EditRow]);
        EditCol := ACol;
        EditRow := ARow;
      end;
end;

procedure CellEdited(ACol, ARow: Integer; const Value: string);
var Ty:integer;
    v:widestring;
begin
  with form5 do begin
      v:=Value;
      while pos(#13,V) > 0 do delete(v,pos(#13,V),1);
      while pos(#10,V) > 0 do delete(v,pos(#10,V),1);
      UnicodeStringGrid1.Cells[1,aRow]:=v;
      if UnicodeStringGrid1.Cells[0,aRow] = 'T_DWORD' then begin
          if (lowercase(copy(UnicodeStringGrid1.Cells[1,aRow],1,1)) <> 'r') and (tabcontrol1.TabIndex=0) then
              UnicodeStringGrid1.Cells[1,aRow]:=inttohex(Hextoint(UnicodeStringGrid1.Cells[1,aRow]),8) else
          UnicodeStringGrid1.Cells[1,aRow]:=uppercase(UnicodeStringGrid1.Cells[1,aRow]);
      end;
      if UnicodeStringGrid1.Cells[0,aRow] = 'T_REG' then begin
          if (lowercase(copy(UnicodeStringGrid1.Cells[1,aRow],1,1)) <> 'r') then begin
              ty:=0;
              //if tabcontrol1.TabIndex = 2 then ty:=1;
              if length(UnicodeStringGrid1.Cells[1,aRow]) > 3 then ty:=1;
              if  tabcontrol1.TabIndex = 0 then begin
              if pos('a', lowercase(UnicodeStringGrid1.Cells[1,aRow])) > 0 then ty:=1;
              if pos('b', lowercase(UnicodeStringGrid1.Cells[1,aRow])) > 0 then ty:=1;
              if pos('c', lowercase(UnicodeStringGrid1.Cells[1,aRow])) > 0 then ty:=1;
              if pos('d', lowercase(UnicodeStringGrid1.Cells[1,aRow])) > 0 then ty:=1;
              if pos('e', lowercase(UnicodeStringGrid1.Cells[1,aRow])) > 0 then ty:=1;
              if pos('f', lowercase(UnicodeStringGrid1.Cells[1,aRow])) > 0 then ty:=1;
              end;
              try
              if strtoint(UnicodeStringGrid1.Cells[1,aRow]) > 255 then ty:=1;
              except
                  ty:=1;
              end;

              if (ty = 0) or (AsmCode[ComboBox1.ItemIndex].order <> T_Args) then UnicodeStringGrid1.Cells[1,aRow]:='R'+UnicodeStringGrid1.Cells[1,aRow]
              else if tabcontrol1.TabIndex=0 then UnicodeStringGrid1.Cells[1,aRow]:=inttohex(Hextoint(UnicodeStringGrid1.Cells[1,aRow]),8);
          end else UnicodeStringGrid1.Cells[1,aRow]:=uppercase(UnicodeStringGrid1.Cells[1,aRow]);
      end;
      if (UnicodeStringGrid1.Cells[0,aRow] = 'T_RREG') or (UnicodeStringGrid1.Cells[0,aRow] = 'T_DREG')
          or (UnicodeStringGrid1.Cells[0,aRow] = 'T_BREG') then
          if (lowercase(copy(UnicodeStringGrid1.Cells[1,aRow],1,1)) <> 'r') then UnicodeStringGrid1.Cells[1,aRow]:='R'+UnicodeStringGrid1.Cells[1,aRow];

  end;
end;

procedure TForm5.ComboBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s:string;
    x:integer;
begin
    if key = VK_F1 then begin
        if (combobox1.ItemIndex>-1) then begin
            s:= combobox1.Text;
            shellexecute(0,'open',pchar('https://qedit.info/index.php?title='+s),'','',0);
        end;
    end;
end;

end.
