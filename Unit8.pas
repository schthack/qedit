unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Grids;

type
  TForm8 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ListBox1: TListBox;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Button1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Memo2KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Function RedrawRaw:boolean;
  Function RebuildData:boolean;

var
  Form8: TForm8;
  wordlist:tstringlist;

implementation

uses main;

{$R *.dfm}


procedure TForm8.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
var x,i:integer;
begin
    if ACol < 6 then begin
    try
    x:=strtoint(value);
    i:=(ARow-1) * 20;
    i:=i+16;
    if ACol = 0 then begin
        floor[form1.checklistbox1.ItemIndex].Unknow[i]:=x;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+1]:=x div 256;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+2]:=x div 65536;
    end;
    if ACol = 1 then begin
        floor[form1.checklistbox1.ItemIndex].Unknow[i+4]:=x;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+5]:=x div 256;
    end;
    if ACol = 2 then begin
        floor[form1.checklistbox1.ItemIndex].Unknow[i+6]:=x;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+7]:=x div 256;
    end;
    if ACol = 3 then begin
        floor[form1.checklistbox1.ItemIndex].Unknow[i+8]:=x;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+9]:=x div 256;
    end;
    if ACol = 4 then begin
        floor[form1.checklistbox1.ItemIndex].Unknow[i+10]:=x;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+11]:=x div 256;
    end;
    if ACol = 5 then begin
        floor[form1.checklistbox1.ItemIndex].Unknow[i+12]:=x;
        floor[form1.checklistbox1.ItemIndex].Unknow[i+13]:=x div 256;
    end;
    //action #6
    RedrawRAW;
    except
    end;
    end else RebuildData;
end;


Function RedrawRaw:boolean;
var a,b:ansistring;
    x,v,y:integer;
begin
    {form8.memo1.Clear;
        a:='';
        b:='';
        y:=0;
        v:=0;
        for x:=0 to floor[form1.checklistbox1.ItemIndex].UnknowCount-1 do begin
            a:=a+inttohex(floor[form1.checklistbox1.ItemIndex].Unknow[x],2)+' ';
            if floor[form1.checklistbox1.ItemIndex].Unknow[x] > 31 then
                b:=b+chr(floor[form1.checklistbox1.ItemIndex].Unknow[x]) else
            b:=b+'.';
            inc(y);
            if y = 16 then begin
                form8.Memo1.Lines.Add(inttohex(v,4)+': '+a+'   '+b);
                y:=0;
                a:='';
                b:='';
                v:=x+1;
            end;
        end;
        form8.Memo1.Lines.Add(inttohex(v,4)+': '+a+'   '+b);  }
    result:=true;
end;

Function GetWord(s:ansistring):ansistring;
var x,y:integer;
    re:string;
begin
    re:='';
    result:='';
    if s = '' then exit;
    for x:=1 to length(s) do if (s[x] <> #9) and (s[x] <> ' ') then break;
    for y:=x to length(s) do if (s[y] = #9) or (s[y] = ' ') then break
        else re:=re+s[y];
    result:=lowercase(re);
end;

Function GetAfterWord(s:ansistring):ansistring;
var x,y:integer;
begin
    result:='';
    if s = '' then exit;
    for x:=1 to length(s) do if (s[x] <> #9) and (s[x] <> ' ') then break;
    for y:=x to length(s) do if (s[y] = #9) or (s[y] = ' ') then break;
    result:=copy(s,y,length(s)-(y-1));
end;


Function RebuildData:boolean;
var a,b,s,r:ansistring;
    x,y,i:integer;
    evtv:integer;
begin
    result:=true;
    a:='';
    b:='';
    evtv:=20;
    for x:=0 to form8.Memo2.Lines.Count-1 do
        if GetWord(form8.Memo2.Lines.Strings[x]) = 'wave_choice:' then evtv:=24;
    //if floor[form1.checklistbox1.ItemIndex].Unknow[15] = $32 then evtv:=24;
    y:=0;
    try
    for x:=0 to form8.Memo2.Lines.Count-1 do begin
        r:=GetWord(form8.Memo2.Lines.Strings[x]);
        s:=GetAfterWord(form8.Memo2.Lines.Strings[x]);
        if r<> '' then begin
            if r[1] = '#' then begin
                if a <> '' then begin
                    move(a[1],floor[form1.checklistbox1.ItemIndex].Unknow[16+(y*evtv)],evtv);
                    b:=b+#1;
                    inc(y);
                end;
                a:=#0#0#0#0+#0#0+#1#0+#0#0+#0#0+#30#0#0#0+#0#0#0#0;
                i:=strtoint(copy(r,2,length(r)-1));
                move(i,a[1],4);
                i:=length(b);
                if evtv = 24 then begin
                    a:=a+#0#0#0#0;
                    move(i,a[21],4);
                end else begin
                    move(i,a[17],4);
                end;
            end;
            if r = 'section:' then begin
                i:=strtoint(GetWord(s));
                move(i,a[9],2);
            end;
            if r = 'wave:' then begin
                i:=strtoint(GetWord(s));
                move(i,a[11],2);
            end;
            if r = 'delay:' then begin
                i:=strtoint(GetWord(s));
                move(i,a[13],4);
            end;

            if r = 'wavesetting:' then begin
                i:=strtoint(GetWord(s));
                s:=GetAfterWord(s);
                move(i,a[17],1);
                i:=strtoint(GetWord(s));
                s:=GetAfterWord(s);
                move(i,a[18],1);
                i:=strtoint(GetWord(s));
                s:=GetAfterWord(s);
                move(i,a[19],1);
                i:=strtoint(GetWord(s));
                s:=GetAfterWord(s);
                move(i,a[20],1);
            end;

            //command
            if r = 'call' then begin
                i:=strtoint(GetWord(s));
                b:=b+#$c+pansichar(@i)[0]+pansichar(@i)[1]+pansichar(@i)[2]+pansichar(@i)[3];
            end;
            if r = 'unlock' then begin
                i:=strtoint(GetWord(s));
                b:=b+#$a+pansichar(@i)[0]+pansichar(@i)[1];
            end;
            if r = 'lock' then begin
                i:=strtoint(GetWord(s));
                b:=b+#$b+pansichar(@i)[0]+pansichar(@i)[1];
            end;
            if r = 'unhide' then begin
                i:=strtoint(GetWord(s));
                s:=GetAfterWord(s);
                b:=b+#$8+pansichar(@i)[0]+pansichar(@i)[1];
                i:=strtoint(GetWord(s));
                b:=b+pansichar(@i)[0]+pansichar(@i)[1];
            end;

        end;
    end;
    if a <> '' then begin
        move(a[1],floor[form1.checklistbox1.ItemIndex].Unknow[16+(y*evtv)],evtv);
        b:=b+#1;
        inc(y);
    end;
    while length(b) <> (length(b) div 4)*4 do b:=b+#$ff;

    i:=16;
    move(i,floor[form1.checklistbox1.ItemIndex].Unknow[4],4);
    move(y,floor[form1.checklistbox1.ItemIndex].Unknow[8],4);
    i:=0;
    if evtv = 24 then i:=$32747665;
    move(i,floor[form1.checklistbox1.ItemIndex].Unknow[12],4);
    i:=16+(y*evtv);
    move(i,floor[form1.checklistbox1.ItemIndex].Unknow[0],4);
    move(b[1],floor[form1.checklistbox1.ItemIndex].Unknow[i],length(b));
    floor[form1.checklistbox1.ItemIndex].UnknowCount:=i+length(b);
    RedrawRAW;
    except
        on E: Exception do begin
            form8.memo2.CaretPos:=point(0,x);
        form8.memo2.SelLength:= length(form8.Memo2.Lines.Strings[x]);
            MessageDlg(getlanguagestring(248) +e.Message, mtInformation,
            [mbOk], 0);
        result:=false;
    end;
    end;

    {a:='';
    for x:=0 to floor[form1.checklistbox1.ItemIndex].Unknow[8]-1 do begin
        y:=length(a);
        floor[form1.checklistbox1.ItemIndex].Unknow[32+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[33+(x*20)]:=y div 256;
        floor[form1.checklistbox1.ItemIndex].Unknow[34+(x*20)]:=0;
        floor[form1.checklistbox1.ItemIndex].Unknow[35+(x*20)]:=0;
        y:=strtoint(form8.StringGrid1.Cells[0,x+1]);
        floor[form1.checklistbox1.ItemIndex].Unknow[16+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[17+(x*20)]:=y div 256;
        floor[form1.checklistbox1.ItemIndex].Unknow[18+(x*20)]:=y div 65536;
        floor[form1.checklistbox1.ItemIndex].Unknow[19+(x*20)]:=0;
        y:=strtoint(form8.StringGrid1.Cells[1,x+1]);
        floor[form1.checklistbox1.ItemIndex].Unknow[20+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[21+(x*20)]:=y div 256;
        y:=strtoint(form8.StringGrid1.Cells[2,x+1]);
        floor[form1.checklistbox1.ItemIndex].Unknow[22+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[23+(x*20)]:=y div 256;
        y:=strtoint(form8.StringGrid1.Cells[3,x+1]);
        floor[form1.checklistbox1.ItemIndex].Unknow[24+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[25+(x*20)]:=y div 256;
        y:=strtoint(form8.StringGrid1.Cells[4,x+1]);
        floor[form1.checklistbox1.ItemIndex].Unknow[26+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[27+(x*20)]:=y div 256;
        y:=strtoint(form8.StringGrid1.Cells[5,x+1]);
        floor[form1.checklistbox1.ItemIndex].Unknow[28+(x*20)]:=y;
        floor[form1.checklistbox1.ItemIndex].Unknow[29+(x*20)]:=y div 256;
        floor[form1.checklistbox1.ItemIndex].Unknow[30+(x*20)]:=0;
        floor[form1.checklistbox1.ItemIndex].Unknow[31+(x*20)]:=0;

        b:=form8.StringGrid1.Cells[6,x+1];
        for y:=0 to (length(b) div 3)-1 do
            a:=a+chr(hextoint(copy(b,1+(y*3),2)));
    end;
    while ((length(a) div 4) * 4) <> length(a) do a:=a+#$ff;
    y:=floor[form1.checklistbox1.ItemIndex].Unknow[0]+(floor[form1.checklistbox1.ItemIndex].Unknow[1]*256);
    floor[form1.checklistbox1.ItemIndex].UnknowCount:=y+length(a);
    for x:=0 to length(a)-1 do
        floor[form1.checklistbox1.ItemIndex].Unknow[y+x]:=byte(a[x+1]);      }
    //RedrawRAW;
    //result:=true;
end;



procedure TForm8.Button1Click(Sender: TObject);
var x:integer;
begin
 RebuildData;
end;



procedure TForm8.ListBox1DblClick(Sender: TObject);
var x:integer;
begin
    for x:=0 to memo2.Lines.Count-1 do
        if listbox1.Items.Strings[listbox1.Itemindex] = getword(memo2.Lines.Strings[x]) then break;
    memo2.CaretPos:=point(0,x);
    memo2.SelLength:= length(listbox1.Items.Strings[listbox1.Itemindex]);

end;

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    //action:=caNone;
end;

procedure TForm8.Memo2KeyPress(Sender: TObject; var Key: Char);
var x,y,i:integer;
    s:string;
begin
    if wordlist = nil then begin
        wordlist:=tstringlist.Create;
        wordlist.Add('section:');
        wordlist.Add('wave:');
        wordlist.Add('delay:');
        wordlist.Add('wavesetting:');
        wordlist.Add('call');
        wordlist.Add('lock');
        wordlist.Add('unlock');
        wordlist.Add('unhide');
    end;

    {if key = '' then begin
        memo2.CutToClipboard;
    end else if key = '' then memo2.CopyToClipboard
    else if key = '' then memo2.PasteFromClipboard else     }
    if (key <> '') and (key <> '') and (key <> '') then
    if key <> #8 then begin
    if key = #32 then begin
        if memo2.SelLength > 0 then begin
            memo2.SelStart:=memo2.SelStart+memo2.SelLength;
            memo2.SelLength:=0;
        end;
    end;
    if key = #13 then begin
        if memo2.SelLength > 0 then begin
            memo2.SelStart:=memo2.SelStart+memo2.SelLength;
            memo2.SelLength:=0;
        end;
        memo2.SelText:=#13#10;
    end else memo2.SelText:=key;
    x:=memo2.CaretPos.x;
    s:=memo2.Lines.Strings[memo2.CaretPos.y];
    y:=1;
    if x < length(s) then if s[x+1] <> ' ' then y:=0;
    if s <> '' then
    if y = 1 then begin
        for y:=x downto 1 do if (s[y] = ' ') or (s[y] = #9) then break;
        if y < 1 then y:=1;
        s:=copy(s,y,x-y+1);
        for y:=0 to wordlist.Count-1 do
            if lowercase(s) = copy(wordlist.Strings[y],1,length(s)) then break;
        if y < wordlist.Count then begin
            i:=length(s)+1;
            x:=memo2.SelStart;
            memo2.SelText:=copy(wordlist.Strings[y],i,length(wordlist.Strings[y])-length(s));
            memo2.SelStart:=x;
            memo2.SelLength := length(wordlist.Strings[y])-length(s);
        end;
    end;
    key:=#0;
    end;
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
    if RebuildData then
        Close;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
    close;
end;

end.
