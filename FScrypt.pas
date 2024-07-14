unit FScrypt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  ImgList, Menus, shellapi, WSDLIntf, Registry, System.ImageList;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    FontDialog1: TFontDialog;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Panel2: TPanel;
    edit1: TEdit;
    Button6: TButton;
    Panel3: TPanel;
    Panel4: TPanel;
    TreeView1: TTreeView;
    Splitter1: TSplitter;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Data1: TMenuItem;
    NPCEdit1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Past1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Image1: TMenuItem;
    Saveimage1: TMenuItem;
    Editenemyphysicaldata1: TMenuItem;
    SaveDialog1: TSaveDialog;
    EditEnemyresistancedata1: TMenuItem;
    EditEnemyattackdata1: TMenuItem;
    EditEnemymovementdata1: TMenuItem;
    Section1: TMenuItem;
    Ascode1: TMenuItem;
    AsHex1: TMenuItem;
    AsStrdata1: TMenuItem;
    SaveDialog2: TSaveDialog;
    OpenDialog2: TOpenDialog;
    StatusBar1: TStatusBar;
    N2: TMenuItem;
    Delete2: TMenuItem;
    EditFloatdata1: TMenuItem;
    ListBox1: TListBox;
    EditVectordata1: TMenuItem;
    Editsymbolechat1: TMenuItem;
    Addsymbolechat1: TMenuItem;
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure TreeView1DblClick(Sender: TObject);
    Function Button11Click(Sender: TObject):integer;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Past1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure EnemyStatEdit(Sender: TObject);
    procedure Saveimage1Click(Sender: TObject);
    procedure EnemyResistEdit(Sender: TObject);
    procedure EnemyAttackEdit(Sender: TObject);
    procedure EnemyMovementEdit(Sender: TObject);
    procedure Ascode1Click(Sender: TObject);
    procedure TreeView1Compare(Sender: TObject; Node1, Node2: TTreeNode;
      Data: Integer; var Compare: Integer);
    procedure Splitter1Moved(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Delete2Click(Sender: TObject);
    procedure ListBox1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditFloatdata1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    Procedure SaveToBackupFile(f:integer);
    Procedure LoadFromBackupFile(f:integer);
    procedure ListBox1DblClick(Sender: TObject);
    procedure EditVectordata1Click(Sender: TObject);
    procedure Editsymbolechat1Click(Sender: TObject);
    procedure Addsymbolechat1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Function GetReferenceType(x:integer):integer;
  Function GetEpisode:integer;
  Procedure AddLabel(l:integer);
  Procedure AddFunctionUsed (s:ansistring);
  Procedure AddRegister(l:integer);
  Procedure AddDataRef(l:integer);
  Procedure AddStrRef(l:integer);
  Procedure RemoveRef(s:ansistring);
  Function GetOpcodeName(id:dword):ansistring;
  function CompareReg(List: TStringList; Index1, Index2: Integer): Integer;
    function CompareLabel(List: TStringList; Index1, Index2: Integer): Integer;
    function CompareStr(List: TStringList; Index1, Index2: Integer): Integer;
    Procedure ScanForMap;


var
  Form4: TForm4;
  CopyedData:widestring = '';
  ScriptTest:tstrings=nil;
  refname:array[0..9] of ansistring = ('unused','NPC data','Code','Image data','String data','Enemy physical data','Enemy Resist data','Enemy attack data','Enemy movement data','Float data');


implementation

uses TCom, main, Unit1, NPCBuild, PikaPackage, EnemyStat, Unit22,
  FEnemyResist, FEnemyAttack, FEnemyMov, FFloatEdit, FVector, FSymbolChat;

{$R *.dfm}

{Procedure TWideStringList.Clear;
begin
    count:=0;
    setlength(strings,count);
    form4.ListBox11.Clear;
end;

Procedure TWideStringList.Insert(x:integer;s:widestring);
var y:integer;
begin
    inc(count);
    setlength(strings,count);
    form4.ListBox11.Items.Add('');
    for y:=count-1 downto x+1 do strings[y]:=strings[y-1];
    strings[x]:=s;
end;

Function TWideStringList.add(s:widestring):integer;
begin
    result:=count;
    inc(count);
    form4.ListBox11.Items.Add('');
    setlength(strings,count);
    strings[result]:=s;
end;

Procedure TWideStringList.delete(x:integer);
var y:integer;
begin
    form4.ListBox11.Items.Delete(0);
    for y:=x to count-2 do strings[y]:=strings[y+1];
    dec(count);
    setlength(strings,count);
end;

Procedure TWideStringList.SaveToFile(fn:string);
var x,f,r:integer;
begin
    f:=filecreate(fn);
    if f = -1 then begin
        raise ERangeError.Create(getlanguagestring(175)+' '+fn);
        exit;
    end;
    x:=$feff;
    filewrite(f,x,2); //unicode
    r:=$0a000d;
    for x:=0 to count-1 do begin
        filewrite(f,strings[x][1],length(strings[x])*2);
        filewrite(f,r,4);
    end;
    fileclose(f);
end;

Procedure TWideStringList.SaveToBackupFile(f:integer);
var x,r:integer;
begin
    r:=$0a000d;
    filewrite(f,count,4);
    for x:=0 to count-1 do begin
        filewrite(f,strings[x][1],length(strings[x])*2);
        filewrite(f,r,4);
    end;
end;

Procedure TWideStringList.LoadFromBackupFile(f:integer);
var x,i:integer;
    s:widestring;
    c:widechar;
begin
    x:=0;
    clear;
    s:='';
    fileread(f,i,4);
    while (fileread(f,c,2) = 2) and (count< i) do begin
        if c = #$a then begin
            add(s);
            s:='';
        end else
        if c <> #$d then s:=s+c;
    end;
    if s <> '' then add(s);
    fileseek(f,-2,1);
end;


Procedure TWideStringList.LoadFromFile(fn:string);
var x,f:integer;
    s:widestring;
    c:widechar;
begin
    x:=0;
    f:=fileopen(fn,$40);
    if f = -1 then begin
        raise ERangeError.Create(getlanguagestring(175)+' '+fn);
        exit;
    end;
    fileread(f,x,2);
    if x <> $feff then begin
        raise ERangeError.Create(getlanguagestring(176));
        exit;
    end;
    clear;
    s:='';
    while fileread(f,c,2) = 2 do begin
        if c = #$a then begin
            add(s);
            s:='';
        end else
        if c <> #$d then s:=s+c;
    end;
    if s <> '' then add(s);
    fileclose(f);
end;

Function TMyNewUnicode.GetIndex:integer;
begin
    result:=form4.ListBox11.ItemIndex;
end;

procedure TMyNewUnicode.Setindex(x:integer);
begin
    form4.ListBox11.ItemIndex:=x;
end;

constructor TMyNewUnicode.create;
begin
    inherited create;
    wideitems:=TWideStringList.Create;
    wideitems.count:=0;
    setlength(wideitems.strings,0);
end;                  }



Procedure TForm4.SaveToBackupFile(f:integer);
var x,r:integer;
begin
    r:=$0a000d;
    x:=listbox1.count;
    filewrite(f,x,4);
    for x:=0 to listbox1.count-1 do begin
        filewrite(f,listbox1.items[x][1],length(listbox1.items[x])*2);
        filewrite(f,r,4);
    end;
end;

Procedure TForm4.LoadFromBackupFile(f:integer);
var x,i:integer;
    s:widestring;
    c:widechar;
begin
    x:=0;
    listbox1.clear;
    s:='';
    fileread(f,i,4);
    while (fileread(f,c,2) = 2) and (listbox1.count< i) do begin
        if c = #$a then begin
            listbox1.items.add(s);
            s:='';
        end else
        if c <> #$d then s:=s+c;
    end;
    if s <> '' then listbox1.items.add(s);
    fileseek(f,-2,1);
end;


Procedure DelLabel(l:integer);
var x:integer;
begin
    x:=tsfnc.IndexOf('F_'+inttostr(l));
    {for x:=0 to TrFnc.Count -1 do
        if TrFnc.Item[x].Text = 'F_'+inttostr(l) then break;  }
    if (x > -1) and (TrFnc.Count > 0) then begin
        TrFnc.Item[x].Delete;
        tsfnc.Delete(x);
    end;
    {for x:=0 to TrData.Count -1 do
        if (TrData.Item[x].Text = 'D_'+inttostr(l)) or (TrData.Item[x].Text = 'S_'+inttostr(l)) then break; }
    x:=tsdata.IndexOf('D_'+inttostr(l));
    if x = -1 then x:=tsdata.IndexOf('S_'+inttostr(l));
    if (x > -1) and (TrData.Count > 0) then begin
        TrData.Item[x].Delete;
        tsdata.Delete(x);
    end;
end;

Procedure DelOpcode (s:ansistring);
var x:integer;
begin
    {for x:=0 to TrOpc.Count -1 do
        if lowercase(TrOpc.Item[x].Text) = lowercase(s) then break;    }
    if s[length(s)] = ' ' then s:=copy(s,1,length(s)-1);
    x:=tsopc.IndexOf(s);
    if (x >-1) and (TrOpc.Count <> 0) then begin
        TrOpc.Item[x].Delete;
        TsOpc.Delete(x);
    end;
end;

Procedure DelReg (s:ansistring);
var x:integer;
begin
    delete(s,1,1);
    x:=tsreg.IndexOf(s);
    if (x >-1) and (Trreg.Count <> 0) then begin
        Trreg.Item[x].Delete;
        Tsreg.Delete(x);
    end;
end;

Procedure RemoveRef(s:ansistring);
var x,y,labn,i:integer;
    lab,fnc,b:ansistring;
    flab,ffnc:integer;
    lreg:tstringlist;
begin
    flab:=1;
    ffnc:=0;
    lreg:=tstringlist.Create;
    if s[1] <> ' ' then begin
        //test the label
        lab:=copy(s,1,8);
        x:=pos(':',lab);
        labn:=strtoint(copy(lab,1,x-1));
        flab:=0;
    end;
    fnc:=s;
    delete(fnc,1,8);
    x:=pos(' ',fnc);
    b:=fnc;
    if x > 0 then fnc:=copy(fnc,1,x);
    delete(b,1,length(fnc));
    if b <> '' then
    if b[1] <> ' ' then b:=' '+b;
    if fnc = 'HEX:' then ffnc:=1;
    if fnc = 'STR:' then ffnc:=1;
    if ffnc = 0 then begin
        //look for any reg
        x:=pos(' R',b);
        while x > 0 do begin
            delete(b,1,x-1);
            x:=pos(', ',b);
            if x = 0 then x:=length(b)+1;
            lreg.Add(copy(b,1,x-1));
            delete(b,1,x);
            x:=pos(' R',b);
        end;
    end;


    for x:=0 to form4.ListBox1.Items.Count-1 do begin
            if flab = 0 then
                if copy(form4.ListBox1.Items.Strings[x],1,8) = lab then flab:=1;
            if ffnc = 0 then
                if copy(form4.ListBox1.Items.Strings[x],9,length(fnc)) = fnc then ffnc:=1;
            y:=0;
            while y<lreg.Count do begin
                i:=pos(lreg.Strings[y],form4.ListBox1.Items.Strings[x]);
                if i > 0 then begin
                if length(form4.ListBox1.Items.Strings[x]) < i+length(lreg.Strings[y]) then lreg.Delete(y)
                else if form4.ListBox1.Items.Strings[x][i+length(lreg.Strings[y])] = ',' then lreg.Delete(y)
                else inc(y);
                end else inc(y);
            end;
    end;

    if flab = 0 then dellabel(labn);
    if ffnc = 0 then DelOpcode(fnc);
    for y:=0 to lreg.Count-1 do DelReg(lreg.Strings[y]);
    lreg.Free;
end;

Procedure AddFunctionUsed (s:ansistring);
var x:integer;
begin
    {for x:=0 to TrOpc.Count -1 do
        if lowercase(TrOpc.Item[x].Text) = lowercase(s) then break;}
    x:=tsopc.IndexOf(s);
    if (x =-1) or (TrOpc.Count = 0) then begin
        with form4.TreeView1.Items.AddChild(TrOpc,s) do begin
            ImageIndex:=5;
            SelectedIndex:=5;
        end;
        tsopc.Add(s);
        tsopc.CustomSort(Comparestr);
        TrOpc.AlphaSort(false);
    end;
end;

Procedure AddLabel(l:integer);
var x:integer;
    s:ansistring;
begin
    s:='F_'+inttostr(l);
    {for x:=0 to TrFnc.Count -1 do
        if TrFnc.Item[x].Text = s then break; }
    x:=tsfnc.IndexOf(s);
    if (x = -1) or (TrFnc.Count = 0) then begin
        with form4.TreeView1.Items.AddChild(TrFnc,'F_'+inttostr(l)) do begin
            ImageIndex:=1;
            SelectedIndex:=1;
        end;
        tsFnc.Add(s);
        tsFnc.CustomSort(CompareLabel);
        TrFnc.AlphaSort(false);
    end;
end;

Procedure AddDataRef(l:integer);
var x:integer;
begin
    {for x:=0 to TrData.Count -1 do
        if TrData.Item[x].Text = 'D_'+inttostr(l) then break;   }
    x:=tsdata.IndexOf('D_'+inttostr(l));
    if (x = -1) or (TrData.Count = 0) then begin
        with form4.TreeView1.Items.AddChild(TrData,'D_'+inttostr(l)) do begin
            ImageIndex:=4;
            SelectedIndex:=4;
        end;
        tsdata.add('D_'+inttostr(l));
        tsdata.CustomSort(CompareLabel);
        TrData.AlphaSort(false);
    end;
end;

Procedure AddStrRef(l:integer);
var x:integer;
begin
    {for x:=0 to TrData.Count -1 do
        if TrData.Item[x].Text = 'S_'+inttostr(l) then break;  }
    x:=tsdata.IndexOf('S_'+inttostr(l));
    if (x = -1) or (TrData.Count = 0) then begin
        with form4.TreeView1.Items.AddChild(TrData,'S_'+inttostr(l)) do begin
            ImageIndex:=4;
            SelectedIndex:=4;
        end;
        tsdata.add('S_'+inttostr(l));
        tsdata.CustomSort(CompareLabel);
        TrData.AlphaSort(false);
    end;
end;

Procedure AddRegister(l:integer);
var x:integer;
begin
    {for x:=0 to TrReg.Count -1 do
        if TrReg.Item[x].Text = 'R'+inttostr(l) then break;}
    x:=tsreg.IndexOf('R'+inttostr(l));
    if (x = -1) or (TrReg.Count = 0) then begin
        with form4.TreeView1.Items.AddChild(TrReg,'R'+inttostr(l)) do begin
            ImageIndex:=0;
            SelectedIndex:=0;
        end;
        tsreg.Add('R'+inttostr(l));
        tsreg.CustomSort(CompareReg);
        TrReg.AlphaSort(false);
    end;
end;


procedure TForm4.Button4Click(Sender: TObject);
var x:integer;
    s:ansistring;
begin
    if listbox1.ItemIndex > -1 then begin
    isedited:=true;
        x:=listbox1.ItemIndex;
        s:=Listbox1.Items.Strings[x];
        Listbox1.Items.Delete(listbox1.ItemIndex);
        RemoveRef(s);
        if x < listbox1.Items.Count then begin
        listbox1.ItemIndex:=x;
        //listbox1.Selected[x]:=true;
        end;
    end;
end;

Procedure ScanForMap;
var x,i,y:integer;
    mappc,mapgc,mapbb,s:ansistring;
    tmpreg:array[0..256] of dword;
begin
    mappc:=GetOpcodeName($c4)+' ';
    mapgc:=GetOpcodeName($f80d)+' ';
    //mapbb:=GetOpcodeName($f951);
    for x:=0 to form4.ListBox1.Items.Count-1 do begin
        if copy(form4.ListBox1.Items.Strings[x],9,6) = 'leti R' then begin
            s:=copy(form4.ListBox1.Items.Strings[x],15,15);
            i:=pos(',',s);
            y:=strtoint(copy(s,1,i-1));
            delete(s,1,i+1);
            tmpreg[y]:=hextoint(s);
        end;
        if copy(form4.ListBox1.Items.Strings[x],9,length(mapgc)) = mapgc then begin
            s:=copy(form4.ListBox1.Items.Strings[x],10+length(mapgc),3);  //the reg
            i:=strtoint(s);
            if (tmpreg[i] < 30) and (tmpreg[i+1] < 46) then
            if mapid[tmpreg[i+1]]+tmpreg[i+3] < 123 then begin
            mapxvmfile[tmpreg[i]]:=path+'map\xvm\'+mapxvmname[mapid[tmpreg[i+1]]+tmpreg[i+3] ];
            mapfile[tmpreg[i]]:=path+'map\'+mapfilename[mapid[tmpreg[i+1]]+tmpreg[i+3] ];
            floor[tmpreg[i]].floorid:=MapArea[mapid[tmpreg[i+1]]+tmpreg[i+3] ];
            Form1.CheckListBox1.Items.Strings[tmpreg[i]]:=mapname[mapid[tmpreg[i+1]]+tmpreg[i+3] ];
            end;
        end;
        if copy(form4.ListBox1.Items.Strings[x],9,length(mappc)) = mappc then begin
            s:=copy(form4.ListBox1.Items.Strings[x],10+length(mappc),3);  //the reg
            i:=strtoint(s);
            if (tmpreg[i] < 30) then
            if mapid[tmpreg[i]]+tmpreg[i+2] < 123 then begin
            mapxvmfile[tmpreg[i]]:=path+'map\xvm\'+mapxvmname[mapid[tmpreg[i]]+tmpreg[i+2] ];
            mapfile[tmpreg[i]]:=path+'map\'+mapfilename[mapid[tmpreg[i]]+tmpreg[i+2] ];
            floor[tmpreg[i]].floorid:=MapArea[mapid[tmpreg[i]]+tmpreg[i+2] ];
            Form1.CheckListBox1.Items.Strings[tmpreg[i]]:=mapname[mapid[tmpreg[i]]+tmpreg[i+2] ];
            end;
        end;


    end;

end;

procedure TForm4.Button3Click(Sender: TObject);
begin
    form5.Tag:=0;
    form5.Edit5.Text:='';
    lastmode:=0;
    form5.TabControl1Change(form5);
    Form5.ShowModal;
end;

procedure TForm4.Button5Click(Sender: TObject);
var s,b:widestring;
    x,y,i:integer;
begin
    if listbox1.ItemIndex > -1 then begin
        form5.Edit5.Text:='';
        form5.UnicodeStringGrid1.RowCount:=0;
        Form5.Tag:=1;
        //extract the function #
        b:='';
        b:=b+listbox1.Items.Strings[listbox1.ItemIndex];
        s:=copy(b,1,8);
        b:=copy(b,9,length(b)-8);
        x:=pos(':',s);
        s:=copy(s,1,x-1);
        if x > 0 then
        Form5.edit5.Text:=s;

        //function name
        x:=pos(' ',b);
        s:=copy(b,1,x-1);
        b:=copy(b,x+1,length(b)-x);
        form5.ComboBox1.ItemIndex:=form5.ComboBox1.Items.IndexOf(s);
        Form5.ComboBox1Change(form5);

        //insert the param
        x:=0;
        //check the data to be sure it compilent
        while AsmCode[form5.ComboBox1.ItemIndex].arg[x] <> 0 do begin
            if (AsmCode[form5.ComboBox1.ItemIndex].arg[x] = T_STR) then begin
                y:=pos(WideString(''', '),b);
                if y <> 0 then inc(y);
                if y = 0 then y:=length(b)+2;
                s:=copy(b,2,y-4);
                delete(b,1,length(s)+4);
            end else begin
                y:=pos(WideString(', '),b);
                if y = 0 then y:=length(b)+1;
                s:=copy(b,1,y-1);
                delete(b,1,length(s)+2);
            end;
        form5.UnicodeStringGrid1.Cells[1,x]:=s;
        inc(x);
        end;
        lastmode:=0;
        form5.TabControl1Change(form5);
        Form5.ShowModal;
    end;
end;

procedure TForm4.Button1Click(Sender: TObject);
var s:widestring;
begin
    if listbox1.ItemIndex > 0 then begin
    isedited:=true;
        s:=listbox1.Items.Strings[listbox1.ItemIndex];
        listbox1.Items.Strings[listbox1.ItemIndex]:=
            listbox1.Items.Strings[listbox1.ItemIndex-1];
        listbox1.Items.Strings[listbox1.ItemIndex-1]:=s;
        Listbox1.ItemIndex:=ListBox1.ItemIndex-1;
    end;
end;

procedure TForm4.Button2Click(Sender: TObject);
var s:widestring;
begin
    if listbox1.ItemIndex < listbox1.Items.Count-1 then begin
    isedited:=true;
        s:=listbox1.Items.Strings[listbox1.ItemIndex];
        listbox1.Items.Strings[listbox1.ItemIndex]:=
            listbox1.Items.Strings[listbox1.ItemIndex+1];
        listbox1.Items.Strings[listbox1.ItemIndex+1]:=s;
        Listbox1.ItemIndex:=ListBox1.ItemIndex+1;
    end;
end;

procedure TForm4.Button6Click(Sender: TObject);
var x,y,i:integer;
begin
    if listbox1.Items.count > 0 then begin
    x:=listbox1.ItemIndex;
    y:=listbox1.ItemIndex;
    if x = -1 then begin x:=0; y:=0; end;
    i:=0;
    while i = 0 do begin
        inc(x);
        if x = listbox1.Items.count then x:=0;
        if pos(lowercase(edit1.Text),lowercase(listbox1.Items.Strings[x]))>0 then begin
            i:=1;
            break;
        end;
        if x = y then break;
    end;
    if i=1 then listbox1.ItemIndex:=x
    else MessageDlg(getlanguagestring(177), mtInformation,
      [mbOk], 0);

   end else MessageDlg(getlanguagestring(177), mtInformation,
      [mbOk], 0);
end;

procedure TForm4.Button7Click(Sender: TObject);
var Reg: TRegistry;
begin
    if fontdialog1.Execute then begin
        ListBox1.Font:=fontdialog1.Font;
        listbox1.Font.Pitch:=fpFixed;
        Reg := TRegistry.Create;
        try
            Reg.RootKey := HKEY_CURRENT_USER;
            if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
        begin
            Reg.WriteInteger('FontSize',fontdialog1.Font.Size);
            Reg.WriteString('FontName',fontdialog1.Font.Name);
            Reg.WriteInteger('FontStyle',byte(fontdialog1.Font.Style));
            Reg.CloseKey;
            end;
        finally
            Reg.Free;
            inherited;
        end;
    end;
end;

procedure TForm4.Button8Click(Sender: TObject);
begin
    if savedialog1.Execute then begin
        //listbox1.WideItems.SaveUnicode:=true;
         listbox1.Items.SaveToFile(savedialog1.FileName);
        end;
end;

procedure TForm4.Button9Click(Sender: TObject);
begin
    if opendialog1.Execute then begin
    listbox1.Items.LoadFromFile(opendialog1.FileName);
        isedited:=true;
    end;
end;

procedure TForm4.ListBox1DblClick(Sender: TObject);
begin
  form4.Button5Click(nil);
end;

procedure TForm4.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var id,cmd,s:ansistring;
    x,y,i,c,l:integer;
begin
    listbox1.Canvas.Brush.Color:=$FFFFFF;
    if odSelected in state then listbox1.Canvas.Brush.Color:=$D4B7B6;
    listbox1.Canvas.FillRect(rect);
    //get the id
    s:=listbox1.Items.strings[index];
    //showmessage(s);
    id:=copy(s,1,8);
    //get the command
    delete(s,1,8);
    x:=pos(' ',s);
    if x > 0 then cmd:=copy(s,1,x-1)
    else cmd:=s;
    delete(s,1,length(cmd)+1);
    for i:=0 to asmcount-1 do
        if lowercase(cmd) = lowercase(AsmCode[i].name) then break;

    x:=8+length(cmd);
    listbox1.Canvas.Font.Color:=clBlue;
    listbox1.Canvas.TextOut(rect.Left+2,rect.Top,id);
    y:=listbox1.Canvas.TextWidth(id);
    listbox1.Canvas.Font.Color:=clgreen;
    if i < asmcount then begin
        if asmcode[i].ver=1 then listbox1.Canvas.Font.Color:=clnavy;
        if asmcode[i].ver=2 then listbox1.Canvas.Font.Color:=clmaroon;
        if asmcode[i].ver=3 then listbox1.Canvas.Font.Color:=clpurple;
    end;

    //must get his color
    if (asmcode[i].ver < 2) and (asmcode[i].order = T_ARGS) then begin
    //look trought all the param
    c:=0;
    while (asmcode[i].arg[c] <> T_NONE) and (asmcode[i].arg[c] <> T_STR)
        and (asmcode[i].arg[c] <> T_HEX) and (asmcode[i].arg[c] <> T_STRDATA) and (s<>'') do begin
        if ((asmcode[i].arg[c] = T_REG) and (s[1] <> 'R'))
        or ((asmcode[i].arg[c] = T_DWORD) and (s[1] = 'R'))
         then
            listbox1.Canvas.Font.Color:=clmaroon;
        l:=pos(' ',s);
        if l > 0 then delete(s,1,l)
        else s:='';
        inc(c);
    end;
    end;
    

    listbox1.Canvas.TextOut(rect.Left+2+y,rect.Top,cmd);
    y:=y+listbox1.Canvas.TextWidth(cmd);
    listbox1.Canvas.Font.Color:=clBlack;
    TextOutW(listbox1.Canvas.Handle, rect.Left+2+y, rect.Top, pwidechar(@listbox1.Items.strings[index][x+1]), Length(listbox1.Items.strings[index])-x);
end;

procedure TForm4.TreeView1DblClick(Sender: TObject);
var s:ansistring;
begin
    s:=treeview1.Selected.Text;
    if (s <> getlanguagestring(132)) and (s <> getlanguagestring(133)) and (s <> getlanguagestring(134)) and (s <> getlanguagestring(135)) then begin
    if copy(treeview1.Selected.Text,1,2) = 'D_' then begin s:=copy(treeview1.Selected.Text,3,length(treeview1.Selected.Text)-2)+':'+copy('        ',1,9-length(treeview1.Selected.Text)); listbox1.ItemIndex:=0; end;
    if copy(treeview1.Selected.Text,1,2) = 'F_' then begin s:=copy(treeview1.Selected.Text,3,length(treeview1.Selected.Text)-2)+':'+copy('        ',1,9-length(treeview1.Selected.Text)); listbox1.ItemIndex:=0; end;
    if copy(treeview1.Selected.Text,1,2) = 'S_' then begin s:=copy(treeview1.Selected.Text,3,length(treeview1.Selected.Text)-2)+':'+copy('        ',1,9-length(treeview1.Selected.Text)); listbox1.ItemIndex:=0; end;
    edit1.Text:=s;
    button6click(self);
    end;
end;

procedure TForm4.Button10Click(Sender: TObject);
var b,f:ansistring;
    s:widestring;
    inedit:boolean;
    x,y,z:integer;
begin
    fillchar(form20.NPCDATA,sizeof(TNPCData),0);
    form20.NPCDATA.name_color:=$FFFFFFFF;
    form20.NPCDATA.proportion_x:=0.333;
    form20.NPCDATA.proportion_y:=0.5;
    form20.Edit1.Text:='';
    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = NPCEdit1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form20.SpinEdit1.Value:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form20.SpinEdit1.Value);
        if x > 1 then if messagedlg(getlanguagestring(178), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < sizeof(form20.NPCDATA)-36 do begin
            pansichar(@form20.NPCDATA)[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then begin x:=100; b:=''; end
                else delete(b,1,13);
                end else x:=100;
            end;
            inc(x);
        end;
        form20.Edit1.Text:=pansichar(@form20.NPCDATA.char_name[0]);
        if b = '' then begin
            inc(y);
            if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then b:='';
                if pos('HEX',b) = 0 then b:='';
            end;
        end;
        f:='';
        if b <> '' then begin //extra name
            while length(f) < 32 do begin
            f:=f+ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then f:=f+#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0
                else delete(b,1,13);
                end else f:=f+#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0;
            end;
            end;
            if f[1] = #9 then delete(f,1,4);
            if f[1] <> #0 then
                form20.Edit1.Text:=pwidechar(@f[1]);
        end;

    end;
    form20.TrackBar1.Position:=round(form20.NPCDATA.proportion_x * 100);
    form20.TrackBar2.Position:=round(form20.NPCDATA.proportion_y * 100);
    SetControl;
    if form20.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        inc(y);
        if y < 0 then y:=0;
        s:=inttostr(form20.SpinEdit1.Value)+':';
        AddDataRef(form20.SpinEdit1.Value);
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        for x:=0 to 15 do begin
            s:=s+inttohex(byte(pansichar(@form20.NPCDATA)[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        while x < sizeof(form20.NPCDATA) do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@form20.NPCDATA)[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        if GetReferenceType(form20.SpinEdit1.Value) = 0 then showmessage(getlanguagestring(179));
    end;
end;

Function GetOpcodeName(id:dword):ansistring;
var x:integer;
begin
    for x:=0 to asmcount-1 do
        if AsmCode[x].fnc = id then break;
    result:=AsmCode[x].name;
end;

Function GetReferenceType(x:integer):integer;
var s,b:widestring;
    y:integer;
begin
    result:=0;

    s:=inttostr(x)+':';
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],1,length(s)) = s then begin
            if copy(form4.ListBox1.Items.Strings[y],9,4) <> 'HEX:' then result:=2;
            if copy(form4.ListBox1.Items.Strings[y],9,4) = 'STR:' then result:=4;
        end;
    //s:='get_npc_data '+inttostr(x);
    s:=GetOpcodeName($f841)+' '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s then result:=1;
    //s:='get_physical_data '+inttostr(x);
    s:=GetOpcodeName($f892)+' '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s then result:=5;

    //s:='get_movement_data '+inttostr(x);
    s:=GetOpcodeName($f895)+' '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s then result:=8;

    //s:='get_resist_data '+inttostr(x);
    s:=GetOpcodeName($f894)+' '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s then result:=6;

    //s:='get_attack_data '+inttostr(x);
    s:=GetOpcodeName($f893)+' '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s then result:=7;

    //s:='call_image_data';
    s:=GetOpcodeName($f8ee);
    b:=', '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if (copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s)
        and (copy(form4.ListBox1.Items.Strings[y],length(form4.ListBox1.Items.Strings[y])-length(b)+1,length(b)) = b) then result:=3;


    s:=GetOpcodeName($f8f2);
    b:=', '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if (copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s)
        and (copy(form4.ListBox1.Items.Strings[y],length(form4.ListBox1.Items.Strings[y])-length(b)+1,length(b)) = b) then result:=10;

    // get vector position
    s:=GetOpcodeName($f8db);
    b:=', '+inttostr(x);
    if result = 0 then
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if (copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s)
        and (copy(form4.ListBox1.Items.Strings[y],length(form4.ListBox1.Items.Strings[y])-length(b)+1,length(b)) = b) then result:=10;


end;

Function GetEpisode:integer;
var s:widestring;
    y:integer;
begin
    result:=0;
    s:=GetOpcodeName($f8bc);
    for y:=0 to form4.ListBox1.Items.Count-1 do
        if copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s then begin
            if copy(form4.ListBox1.Items.Strings[y],9,length(s)+9) = s+' 00000000' then result:=0;
            if copy(form4.ListBox1.Items.Strings[y],9,length(s)+9) = s+' 00000001' then result:=1;
            if copy(form4.ListBox1.Items.Strings[y],9,length(s)+9) = s+' 00000002' then result:=2;
        end;
end;

Function TForm4.Button11Click(Sender: TObject):integer;
var p,p2:pansichar;
    f,y,i,c,z,la:integer;
    a,s,b:widestring;
begin
    result:=0;
    if listbox1.ItemIndex > -1 then
    if opendialog2.Execute then begin
        la:=tform5(sender).Tag;
        if la = 0 then begin
            while (listbox1.Items.Strings[listbox1.itemindex][1] = ' ') and (listbox1.ItemIndex>0) do
                listbox1.ItemIndex:=listbox1.ItemIndex-1;
            f:=pos(':',listbox1.Items.Strings[listbox1.itemindex]);
            la:=strtoint(copy(listbox1.Items.Strings[listbox1.itemindex],1,f-1));
            y:=listbox1.itemindex;
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        f:=fileopen(opendialog2.FileName,$40);
        y:=fileseek(f,0,2);
        fileseek(f,0,0);
        p:=allocmem(y);
        fileread(f,p[0],y);
        fileclose(f);
        i:=0;
        if (copy(p,0,3) = 'PVR') or (copy(p,0,3) = 'GVR') or
        (copy(p,0,3) = 'GBI') or (copy(p,0,3) = 'XVR') then
        if MessageDlg(getlanguagestring(180),
            mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
            p2:=allocmem(y*2);
            i:=y;
            y:=pikacompress(p,p2,y);
            freemem(p);
            p:=p2;
        end;
        c:=listbox1.ItemIndex+1;
        if c < 0 then c:=0;
        f:=0;
        AddDataRef(la);
        a:=inttostr(la)+':';
        while length(a) < 8 do a:=a+' ';
        a:=a+'HEX: ';
        for z:=0 to y-1 do begin
            if f = 16 then begin
                f:=0;
                listbox1.Items.Insert(c,a);
                inc(c);
                a:='        HEX: ';
            end;
            a:=a+inttohex(byte(p[z]),2)+' ';
            inc(f);
        end;
        if length(a) > 13 then listbox1.Items.Insert(c,a);

        if i <> 0 then MessageDlg(getlanguagestring(181)+' '+inttostr(i)
            +getlanguagestring(182)+' '+inttostr(y), mtInformation,[mbOk], 0)
        else MessageDlg(getlanguagestring(183)+' '+inttostr(y), mtInformation,[mbOk], 0);
        result:=i;
        if i > 0 then begin
        s:=GetOpcodeName($f8ee);
        b:=inttostr(la);
        for y:=0 to form4.ListBox1.Items.Count-1 do
            if (copy(form4.ListBox1.Items.Strings[y],9,length(s)) = s)
            and (copy(form4.ListBox1.Items.Strings[y],length(form4.ListBox1.Items.Strings[y])-length(b)+1,length(b)) = b) then
        form4.ListBox1.Items.Strings[y]:=copy(form4.ListBox1.Items.Strings[y],1,24)+inttohex(i,8)+', '+inttostr(la);
        end;
    end;
end;

procedure TForm4.PopupMenu1Popup(Sender: TObject);
var y,x:integer;
begin
    //scan for what i can use
    past1.Enabled:=false;
    if CopyedData <> '' then past1.Enabled:=true;
    NPCEdit1.Enabled:=false;
    Saveimage1.Enabled:=false;
    Image1.Enabled:=false;
    Editenemyphysicaldata1.Enabled:=false;
    EditEnemyresistancedata1.enabled:=false;
    EditEnemyattackdata1.Enabled:=false;
    EditEnemymovementdata1.Enabled:=false;
    Delete2.Enabled:=false;
    EditFloatdata1.Enabled:=false;
    EditVectorData1.Enabled:=false;
    Editsymbolechat1.Enabled:=false;
    y:=listbox1.ItemIndex;
    if y > -1 then begin
        while (listbox1.Items.Strings[y][1] = ' ') and (y>0) do dec(y);
        if (listbox1.Items.Strings[y][1] <> ' ') and (copy(listbox1.Items.Strings[y],9,4) = 'HEX:') then begin
            x:=pos(':',listbox1.Items.Strings[y]);
            x:=strtoint(copy(listbox1.Items.Strings[y],1,x-1));
            x:=GetReferenceType(x);
            if x = 0 then begin
                NPCEdit1.Enabled:=True;
                Saveimage1.Enabled:=True;
                Image1.Enabled:=True;
                Editenemyphysicaldata1.Enabled:=True;
                EditEnemyresistancedata1.enabled:=True;
                EditEnemyattackdata1.Enabled:=True;
                EditEnemymovementdata1.Enabled:=true;
                EditFloatdata1.Enabled:=true;
                EditVectorData1.Enabled:=true;
                Editsymbolechat1.Enabled:=true;
            end;
            if x = 1 then NPCEdit1.Enabled:=True;
            if x = 5 then Editenemyphysicaldata1.Enabled:=True;
            if x = 6 then EditEnemyresistancedata1.Enabled:=True;
            if x = 7 then EditEnemyattackdata1.Enabled:=True;
            if x = 8 then EditEnemymovementdata1.Enabled:=true;
            if x = 9 then EditFloatdata1.Enabled:=true;
            if x = 10 then EditVectorData1.Enabled:=true;
            if x = 3 then begin
                Saveimage1.Enabled:=True;
                Image1.Enabled:=True;
            end;
            if (x <> 2) and (x <> 4) then begin
                Delete2.Enabled:=true;
            end;
        end;
    end;


    Section1.Enabled:=false;
    y:=listbox1.ItemIndex;
    if y > -1 then begin
        if listbox1.Items.Strings[y][1] <> ' ' then begin
            x:=pos(':',listbox1.Items.Strings[y]);
            x:=strtoint(copy(listbox1.Items.Strings[y],1,x-1));
            Section1.Tag:=x;
            x:=GetReferenceType(x);
            Section1.Enabled:=true;
            Ascode1.Enabled:=true;
            AsHex1.Enabled:=true;
            AsStrdata1.Enabled:=true;
            if x = 2 then Ascode1.Enabled:=false
            else if x = 4 then AsStrdata1.Enabled:=false
            else AsHex1.Enabled:=false;
        end;
    end;

end;

procedure TForm4.Image1Click(Sender: TObject);
begin
    form5.Tag:=0;
    form4.Button11Click(form5);
    isedited:=true;
end;

procedure TForm4.Copy1Click(Sender: TObject);
begin
    if listbox1.itemindex > -1 then
    CopyedData:=listbox1.Items.Strings[listbox1.itemindex];
end;

procedure TForm4.Cut1Click(Sender: TObject);
begin
    if listbox1.itemindex > -1 then begin
        CopyedData:=listbox1.Items.Strings[listbox1.itemindex];
        listbox1.Items.Delete(listbox1.itemindex);
    end;
end;

procedure TForm4.Delete1Click(Sender: TObject);
begin
    if listbox1.itemindex > -1 then begin
        listbox1.Items.Delete(listbox1.itemindex);
    end;
    isedited:=true;
end;

procedure TForm4.Past1Click(Sender: TObject);
begin
    if listbox1.itemindex > -1 then begin
        listbox1.Items.Insert(listbox1.itemindex+1,CopyedData);
    end else listbox1.Items.add(CopyedData);
    isedited:=true;
end;

procedure TForm4.EnemyStatEdit(Sender: TObject);
var b,f:ansistring;
    s:widestring;
    inedit:boolean;
    x,y,z:integer;
begin
    fillchar(EnemyStatDATA,sizeof(EnemyStatDATA),0);

    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = Editenemyphysicaldata1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form21.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form21.tag);
        if (x <> 0) and (x <> 5) then if messagedlg(getlanguagestring(184), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < sizeof(enemystatdata)-1 do begin
            pansichar(@enemystatdata)[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then begin x:=100; b:=''; end
                else delete(b,1,13);
                end else x:=100;
            end;
            inc(x);
        end;

    end;
    form21.FormShow2(form21);
    if form21.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        inc(y);
        AddDataRef(form21.tag);
        if y < 0 then y:=0;
        s:=inttostr(form21.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        for x:=0 to 15 do begin
            s:=s+inttohex(byte(pansichar(@enemystatdata)[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        while x < sizeof(enemystatdata) do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@enemystatdata)[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        if GetReferenceType(form21.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;


procedure TForm4.EnemyResistEdit(Sender: TObject);
var b,f:ansistring;
    s:widestring;
    inedit:boolean;
    x,y,z:integer;
begin
    fillchar(EnemyResData,sizeof(EnemyResData),0);

    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = EditEnemyresistancedata1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form24.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form24.tag);
        if (x <> 0) and (x <> 6) then if messagedlg(getlanguagestring(185), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < sizeof(EnemyResData)-1 do begin
            pansichar(@EnemyResData)[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then begin x:=100; b:=''; end
                else delete(b,1,13);
                end else x:=100;
            end;
            inc(x);
        end;

    end;
    form24.FormShow2(form24);
    if form24.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        inc(y);
        AddDataRef(form24.tag);
        if y < 0 then y:=0;
        s:=inttostr(form24.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        for x:=0 to 15 do begin
            s:=s+inttohex(byte(pansichar(@EnemyResData)[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        while x < sizeof(EnemyResData) do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@EnemyResData)[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        x:=0;
        while x < 4 do begin
            if z = 17 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+'00 ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        if GetReferenceType(form24.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;

procedure TForm4.Saveimage1Click(Sender: TObject);
var y,x:integer;
    b:widestring;
    s:ansistring;
begin
    if savedialog2.Execute then begin
        while (listbox1.Items.Strings[listbox1.ItemIndex][1] = ' ') and (listbox1.ItemIndex>0) do
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
        s:='';
        x:=listbox1.ItemIndex;
        b:=listbox1.Items.Strings[x];
        delete(b,1,13);
        while ((listbox1.Items.Strings[x][1] = ' ') or (x = listbox1.ItemIndex)) and (x < listbox1.Items.Count-1)  do begin
            s:=s+chr(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(x);
                b:=listbox1.Items.Strings[x];
                delete(b,1,13);
            end;
        end;
        y:=filecreate(savedialog2.FileName);
        filewrite(y,s[1],length(s));
        fileclose(y);
    end;
end;



procedure TForm4.EnemyAttackEdit(Sender: TObject);
var b,f:ansistring;
    s:widestring;
    inedit:boolean;
    x,y,z:integer;
begin
    fillchar(EnemyAttackData,sizeof(EnemyAttackData),0);

    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = EditEnemyattackdata1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form25.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form25.tag);
        if (x <> 0) and (x <> 7) then if messagedlg(getlanguagestring(186), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < sizeof(EnemyAttackData)-1 do begin
            pansichar(@EnemyAttackData)[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then begin x:=100; b:=''; end
                else delete(b,1,13);
                end else x:=100;
            end;
            inc(x);
        end;

    end;
    form25.FormShow2(form25);
    if form25.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        AddDataRef(form25.tag);
        inc(y);
        if y < 0 then y:=0;
        s:=inttostr(form25.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        for x:=0 to 15 do begin
            s:=s+inttohex(byte(pansichar(@EnemyAttackData)[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        while x < sizeof(EnemyAttackData) do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@EnemyAttackData)[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        x:=0;
        while x < 4 do begin
            if z = 17 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+'00 ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        if GetReferenceType(form25.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;

procedure TForm4.EnemyMovementEdit(Sender: TObject);
var b,f:ansistring;
    s:widestring;
    inedit:boolean;
    x,y,z:integer;
begin
    fillchar(EnemyMovData,sizeof(EnemyMovData),0);

    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = EditEnemymovementdata1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form26.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form26.tag);
        if (x <> 0) and (x <> 8) then if messagedlg(getlanguagestring(187), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < sizeof(EnemyMovData)-1 do begin
            pansichar(@EnemyMovData)[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then begin x:=100; b:=''; end
                else delete(b,1,13);
                end else x:=100;
            end;
            inc(x);
        end;

    end;
    form26.FormShow2(form26);
    if form26.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        AddDataRef(form26.tag);
        inc(y);
        if y < 0 then y:=0;
        s:=inttostr(form26.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        for x:=0 to 15 do begin
            s:=s+inttohex(byte(pansichar(@EnemyMovData)[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        while x < sizeof(EnemyMovData) do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@EnemyMovData)[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        x:=0;
        while x < 4 do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+'00 ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        if GetReferenceType(form26.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;

procedure TForm4.Addsymbolechat1Click(Sender: TObject);
begin
    form33.tag := 0;
    Editsymbolechat1Click(nil);
end;

procedure TForm4.Ascode1Click(Sender: TObject);
var x,i:integer;
begin
    if MessageDlg(getlanguagestring(188),
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then  begin

    x:=tmenuitem(sender).Tag;
    if x = 0 then begin
        for i:=0 to 1000 do if datablock[i]=section1.Tag then datablock[i]:=-1;
    end else begin
        for i:=0 to 1000 do if (datablock[i]=section1.Tag) or (datablock[i]=-1) then break;
        datablock[i]:=section1.Tag;
        datablockt[i]:=x;
    end;
    try
    QuestDisam(@asmdata,AsmRef,asmdatas,asmrefs);
    except
        Showmessage(getlanguagestring(189));
    end;
    end;
end;

procedure TForm4.TreeView1Compare(Sender: TObject; Node1, Node2: TTreeNode;
  Data: Integer; var Compare: Integer);
var
    v1,v2:ansistring;
begin
    if node1.Parent = Tropc then Compare := strcomp(pchar(lowercase(node1.Text)),pchar(lowercase(node2.Text)))
    else begin
        v1:=node1.Text;
        v2:=node2.Text;
        if lowercase(v1[1]) = 'r' then delete(v1,1,1)
        else delete(v1,1,2);
        if lowercase(v2[1]) = 'r' then delete(v2,1,1)
        else delete(v2,1,2);
        Compare:=strtoint(v1)-strtoint(v2);
    end;
end;

function CompareReg(List: TStringList; Index1, Index2: Integer): Integer;
var v1,v2:ansistring;
begin
    v1:=list[index1];
    v2:=list[index2];
    delete(v1,1,1);
    delete(v2,1,1);
    result:=strtoint(v1)-strtoint(v2);

end;

function CompareLabel(List: TStringList; Index1, Index2: Integer): Integer;
var v1,v2:ansistring;
begin
    v1:=list[index1];
    v2:=list[index2];
    delete(v1,1,2);
    delete(v2,1,2);
    result:=strtoint(v1)-strtoint(v2);

end;

function CompareStr(List: TStringList; Index1, Index2: Integer): Integer;
begin
    result:=strcomp(pchar(lowercase(list[index1])),pchar(lowercase(list[index2])));

end;


procedure TForm4.Splitter1Moved(Sender: TObject);
begin
    form4.StatusBar1.Panels.Items[0].Width:=form4.TreeView1.Width+4;
end;

procedure TForm4.ListBox1Click(Sender: TObject);
begin
    form4.StatusBar1.Panels.Items[1].Text:=inttostr(listbox1.ItemIndex);
end;

procedure TForm4.Delete2Click(Sender: TObject);
var f,y,la:integer;
begin
    while (listbox1.Items.Strings[listbox1.itemindex][1] = ' ') and (listbox1.ItemIndex>0) do
        listbox1.ItemIndex:=listbox1.ItemIndex-1;
    f:=pos(':',listbox1.Items.Strings[listbox1.itemindex]);
    la:=strtoint(copy(listbox1.Items.Strings[listbox1.itemindex],1,f-1));
    DelLabel(la);
    y:=listbox1.itemindex;
    listbox1.Items.Delete(y);
    while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
    else break;
    dec(y);
    listbox1.ItemIndex:=y;
    isedited:=true;
end;

procedure TForm4.ListBox1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s:string;
    x:integer;
begin
    if key = VK_F1 then begin
        if (listbox1.Items.Count > 0) and (listbox1.itemindex>-1) then begin
            s:= listbox1.Items.Strings[listbox1.itemindex];
            delete(s,1,8);
            x:=pos(' ',s);
            if x > 0 then s:=copy(s,1,x-1);
            shellexecute(0,'open',pchar('http://qedit.schtserv.com/index.php?title='+s),'','',0);
        end;
    end;
end;

procedure TForm4.EditFloatdata1Click(Sender: TObject);
var b,f:string;
    s:widestring;
    inedit:boolean;
    x,y,z,i:integer;
begin
    //fillchar(MyFload,sizeof(EnemyMovData),0);
    FloatCount:=0;
    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = EditFloatdata1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form28.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form28.tag);
        if (x <> 0) and (x <> 9) then if messagedlg(getlanguagestring(190), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < 3000 do begin
            pansichar(@MyFload[0])[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            inc(x);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                if b[1] <> ' ' then begin FloatCount:= x div 4; x:=3000; b:=''; end
                else delete(b,1,13);
                end else begin FloatCount:= x div 4; x:=3000; end;
            end;

        end;

    end;

    for i:=0 to 499 do begin
        form28.StringGrid1.Cells[0,i]:='F'+inttostr(i+1);
        if i < FloatCount then form28.StringGrid1.Cells[1,i]:= floattostr(MyFload[i])
        else form28.StringGrid1.Cells[1,i]:='';
    end;

    if form28.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        AddDataRef(form28.tag);
        inc(y);
        if y < 0 then y:=0;
        s:=inttostr(form28.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        i:=floatcount*4;
        if i > 15 then i:=15;
        for x:=0 to i do begin
            s:=s+inttohex(byte(pansichar(@MyFload[0])[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        i:=floatcount*4;
        while x < i do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@MyFload[0])[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        if GetReferenceType(form28.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;

procedure TForm4.Editsymbolechat1Click(Sender: TObject);
var b,f:string;
    s:widestring;
    inedit:boolean;
    x,y,z,i:integer;
begin
    //fillchar(MyFload,sizeof(EnemyMovData),0);
    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = Editsymbolechat1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form33.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form33.tag);
        if (x <> 0) then if messagedlg(getlanguagestring(190), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < sizeof(TSymbolData) do begin
            pansichar(@form33.symbolData.face)[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            inc(x);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                  b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                  if b[1] <> ' ' then begin x:=3000; b:=''; end
                  else delete(b,1,13);
                end else begin x:=3000; end;
            end;

        end;

    end;



    if form33.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        AddDataRef(form32.tag);
        inc(y);
        if y < 0 then y:=0;
        s:=inttostr(form33.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        i:=sizeof(TSymbolData);
        if i > 15 then i:=15;
        for x:=0 to i do begin
            s:=s+inttohex(byte(pansichar(@form33.symbolData.face)[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        i:=sizeof(TSymbolData);
        while x < i do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@form33.symbolData.face)[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s + '00 00 00 00');

        if GetReferenceType(form33.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;

procedure TForm4.EditVectordata1Click(Sender: TObject);
var b,f:string;
    s:widestring;
    inedit:boolean;
    x,y,z,i:integer;
begin
    //fillchar(MyFload,sizeof(EnemyMovData),0);
    form32.vectorCount:=0;
    if listbox1.ItemIndex <> -1 then
    b:=listbox1.Items.Strings[listbox1.ItemIndex];
    inedit:=false;
    if (listbox1.ItemIndex < listbox1.Items.Count-1) or (sender = EditFloatdata1) then
    //if listbox1.wideItems.Strings[listbox1.ItemIndex+1][1] = ' ' then
    if copy(b,9,4) = 'HEX:' then begin
        inedit:=true;
        while (b[1] = ' ') and (listbox1.ItemIndex>0) do begin
            listbox1.ItemIndex:=listbox1.ItemIndex-1;
            b:=listbox1.Items.Strings[listbox1.ItemIndex];
        end;
        y:=pos(':',b)-1;
        form32.tag:=strtoint(copy(b,1,y));
        x:=GetReferenceType(form32.tag);
        if (x <> 0) and (x <> 10) then if messagedlg(getlanguagestring(190), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then exit;
        delete(b,1,13);
        x:=0;
        y:=0;
        while x < 3000 do begin
            pansichar(@form32.vectors[0])[x]:=ansichar(hextoint(copy(b,1,2)));
            delete(b,1,3);
            inc(x);
            if b = '' then begin
                inc(y);
                if listbox1.ItemIndex+y < listbox1.Items.Count then begin
                  b:=listbox1.Items.Strings[listbox1.ItemIndex+y];
                  if b[1] <> ' ' then begin form32.vectorCount:= x div 16; x:=3000; b:=''; end
                  else delete(b,1,13);
                end else begin form32.vectorCount:= x div 16; x:=3000; end;
            end;

        end;

    end;

    

    if form32.ShowModal = 1 then begin
        //edit or add here
        y:=listbox1.ItemIndex;
        if inedit then begin
            listbox1.Items.Delete(y);
            while (y < listbox1.Items.Count) do if (listbox1.Items.Strings[y][1] = ' ') then listbox1.Items.Delete(y)
            else break;
            dec(y);
            listbox1.ItemIndex:=y;
        end;
        AddDataRef(form32.tag);
        inc(y);
        if y < 0 then y:=0;
        s:=inttostr(form32.tag)+':';
        while length(s) < 8 do s:=s+' ';
        s:=s+'HEX: ';
        i:=form32.vectorCount*16;
        if i > 15 then i:=15;
        for x:=0 to i do begin
            s:=s+inttohex(byte(pansichar(@form32.vectors[0])[x]),2)+' ';
        end;
        listbox1.Items.Insert(y,s);
        inc(y);
        s:='        HEX: ';
        z:=0;
        i:=form32.vectorCount*16;
        while x < i do begin
            if z = 16 then begin
                listbox1.Items.Insert(y,s);
                inc(y);
                s:='        HEX: ';
                z:=0;
            end;
            s:=s+inttohex(byte(pansichar(@form32.vectors[0])[x]),2)+' ';
            inc(x);
            inc(z);
        end;
        if length(s) > 13 then listbox1.Items.Insert(y,s);

        s:='        HEX: 00 00 00 00';
        inc(y);
        listbox1.Items.Insert(y,s);

        if GetReferenceType(form32.tag) = 0 then showmessage(getlanguagestring(179));
    end;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
   // listbox1:=TMyNewUnicode.create;
end;

end.
