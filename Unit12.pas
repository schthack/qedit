unit Unit12;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm12 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

uses main, PikaPackage, Unit1;

{$R *.dfm}

procedure TForm12.Button1Click(Sender: TObject);
begin
    close;
end;

procedure TForm12.Button2Click(Sender: TObject);
var f:integer;
begin
    if listbox1.ItemIndex > -1 then begin
        savedialog1.FileName:=qstfile[listbox1.ItemIndex].name;
        SaveDialog1.Filter:='Any files|*.*';
        if savedialog1.Execute then begin
            f:=filecreate(savedialog1.FileName);
            filewrite(f,qstfile[listbox1.ItemIndex].data[0],qstfile[listbox1.ItemIndex].size);
            fileclose(f);
        end;
    end;
end;

procedure TForm12.Button3Click(Sender: TObject);
var f,i:integer;
begin
    if listbox1.ItemIndex > -1 then begin
        if opendialog1.Execute then begin
            f:=fileopen(opendialog1.FileName,$40);
            i:=fileseek(f,0,2);
            fileseek(f,0,0);
            freemem(qstfile[listbox1.ItemIndex].data);
            qstfile[listbox1.ItemIndex].data:=allocmem(i);
            qstfile[listbox1.ItemIndex].size:=i;
            fileread(f,qstfile[listbox1.ItemIndex].data[0],qstfile[listbox1.ItemIndex].size);
            fileclose(f);
        end;
    end;
end;

procedure TForm12.Button4Click(Sender: TObject);
var f,i,l:integer;
begin
        if opendialog1.Execute then begin
            f:=fileopen(opendialog1.FileName,$40);
            i:=fileseek(f,0,2);
            fileseek(f,0,0);
            l:=qstfilecount;
            qstfile[l].Name:=extractfilename(opendialog1.FileName);
            qstfile[l].from:=0;
            inc(qstfilecount);
            qstfile[l].data:=allocmem(i);
            qstfile[l].size:=i;
            fileread(f,qstfile[l].data[0],qstfile[l].size);
            fileclose(f);
            listbox1.Items.Add(qstfile[l].Name+' ('+inttostr(qstfile[l].size)+getlanguagestring(254));
        end;
end;

procedure TForm12.Button5Click(Sender: TObject);
var l:integer;
begin
    if listbox1.ItemIndex > -1 then
        if MessageDlg(getlanguagestring(255),
            mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
            freemem(qstfile[listbox1.ItemIndex].data);
            for l:=listbox1.ItemIndex to qstfilecount-2 do begin
                qstfile[l].Name:=qstfile[l+1].Name;
                qstfile[l].size:=qstfile[l+1].size;
                qstfile[l].from:=qstfile[l+1].from;
                qstfile[l].data:=qstfile[l+1].data;
            end;
            dec(qstfilecount);
            listbox1.DeleteSelected;
        end;

end;

procedure TForm12.Button6Click(Sender: TObject);
var x,y,f,o,j,f2,f1,s1,s2,z,bl,dl:integer;
    d:dword;
    txt:array[0..1] of ansichar;
    h:TNPCGroupeHeader;
    fn,b:ansistring;
    tmp:array[0..$3ff] of ansichar;
    di,da,db:pansichar;
    qtmp:array[0..99] of pansichar;
    qtmpsize,qtmppos:array[0..99] of integer;
begin
    SaveDialog1.Filter:='Quest file|*.bin|Server Quest file(PC)|*.qst|Server Quest file(DC)|*.qst|Server Quest file(GC)|*.qst|Server Quest file(BB)'
    +'|*.qst|Download Quest file(DC)|*.qst|Download Quest file(PC)|*.qst|Download Quest file(GC)|*.qst'
    +'|Kohle basic format(PC)|*.bin|Kohle basic format(DC)|*.bin|Kohle basic format(GC)|*.bin|Kohle basic format(BB)|*.bin';
    if savedialog1.Execute then begin
        //compress if needed
        if (SaveDialog1.FilterIndex = 2) or (SaveDialog1.FilterIndex = 4)
            or (SaveDialog1.FilterIndex = 3) or (SaveDialog1.FilterIndex = 5)
            or (SaveDialog1.FilterIndex = 6) or (SaveDialog1.FilterIndex = 7)
            or (SaveDialog1.FilterIndex = 8) then begin
            //prs compression

            for f:=0 to qstfilecount-1 do
            if (pos('.bin',lowercase(qstfile[f].Name))=0) and (pos('.dat',lowercase(qstfile[f].Name))=0) then begin
                //copy data only
                 qtmp[f]:=allocmem(qstfile[f].size+8);
                 qtmpsize[f]:=qstfile[f].size;
                 move(qstfile[f].data[0],qtmp[f][0],qstfile[f].size);
                 qtmppos[f]:=0;
            end else begin
                //compress
                qtmp[f]:=allocmem(qstfile[f].size*2);
                qtmpsize[f]:=pikacompress(qstfile[f].data,qtmp[f],qstfile[f].size);
                qtmppos[f]:=0;
            end;
            //file is compressed

            if (SaveDialog1.FilterIndex = 6) or (SaveDialog1.FilterIndex = 7)
                then begin
                //need to encrypt the file
                for f:=0 to qstfilecount-1 do
                if (pos('.bin',lowercase(qstfile[f].Name))>0) or (pos('.dat',lowercase(qstfile[f].Name))>0) then begin
                    setlength(b,qtmpsize[f]);
                    move(qtmp[f][0],b[1],qtmpsize[f]);
                    f1:=random($7fffffff);
                    CreateKey(f1,0);
                    b:=psoenc(b,0,0);
                    bl:=qstfile[f].size;
                    b:=chr(bl)+chr(bl div 256)+chr(bl div $10000)+#0
                        +pansichar(@f1)[0]+pansichar(@f1)[1]+pansichar(@f1)[2]+pansichar(@f1)[3]+b;
                    inc(qtmpsize[f],8);
                    move(b[1],qtmp[f][0],qtmpsize[f]);
                end;
                //done
            end;


            //save in the file
            f:=filecreate(savedialog1.FileName);
            //write all header
            for x:=0 to qstfilecount-1 do begin
                if SaveDialog1.FilterIndex = 5 then begin
                    setlength(b,$58);
                    fillchar(b[1],$58,0);
                    b[1]:=#$58;
                    b[3]:=#$44;
                    move(qnum,b[5],2);
                    move(qstfile[x].name[1],b[45],length(qstfile[x].name));
                    if qstfilecount > 2 then
                        b[43]:=ansichar(qstfilecount-2);
                    move(qtmpsize[x],b[61],4);
                    fn:=qstfile[x].name;
                    insert('_j',fn,pos('.',qstfile[x].name));
                    move(fn[1],b[65],length(fn));
                end;
                if (SaveDialog1.FilterIndex = 2) or (SaveDialog1.FilterIndex = 7) then begin
                    setlength(b,$3c);
                    fillchar(b[1],$3c,0);
                    b[1]:=#$3c;
                    b[3]:=#$44;
                    if SaveDialog1.FilterIndex = 7 then b[3] := #$a6;
                    move(qnum,b[2],1);
                    move(qstfile[x].name[1],b[41],length(qstfile[x].name));
                    if qstfilecount > 2 then
                        b[39]:=ansichar(qstfilecount-2);
                    move(qtmpsize[x],b[57],4);
                end;
                if (SaveDialog1.FilterIndex = 4) or (SaveDialog1.FilterIndex = 8)
                    or (SaveDialog1.FilterIndex = 3) or (SaveDialog1.FilterIndex = 6)then begin
                    setlength(b,$3c);
                    fillchar(b[1],$3c,0);
                    b[3]:=#$3c;
                    b[1]:=#$44;
                    if SaveDialog1.FilterIndex > 5 then b[1] := #$a6;
                    move(qnum,b[2],1);
                    if (SaveDialog1.FilterIndex = 6) or (SaveDialog1.FilterIndex = 8) then begin
                        move(qstfile[x].name[1],b[41],length(qstfile[x].name));
                        b[40] := ansichar(qnum);
                        b[39] := ansichar(qnum div 256);
                    end else
                        move(qstfile[x].name[1],b[40],length(qstfile[x].name));

                    if qstfilecount > 2 then
                        b[39]:=ansichar(qstfilecount-2);
                    move(qtmpsize[x],b[57],4);
                    fn:=unitochar('PSO/'+title,32);
                    if length(fn) > 32 then fn:=copy(fn,1,32);
                    move(fn[1],b[5],length(fn));
                end;

                filewrite(f,b[1],length(b));
            end;
            f2:=0;
            while f2 < qstfilecount do begin
                for x:=0 to qstfilecount-1 do
                if qtmppos[x]<qtmpsize[x] then begin
                    //make header
                    setlength(b,$1c);
                    fillchar(b[1],$1c,0);
                    if (SaveDialog1.FilterIndex = 4) or (SaveDialog1.FilterIndex = 8)
                    or (SaveDialog1.FilterIndex = 3) or (SaveDialog1.FilterIndex = 6)then begin
                        b[1]:=#$13;
                        if SaveDialog1.FilterIndex>5 then b[1]:=#$a7;
                        b[3]:=#$18;
                        b[4]:=#4;
                        b[2]:=ansichar(qtmppos[x] div 1024);
                    end;
                    if (SaveDialog1.FilterIndex = 2) or (SaveDialog1.FilterIndex = 7) then begin
                        b[3]:=#$13;
                        if SaveDialog1.FilterIndex>5 then b[3]:=#$a7;
                        b[1]:=#$18;
                        b[2]:=#4;
                        b[4]:=ansichar(qtmppos[x] div 1024);
                    end;
                    if (SaveDialog1.FilterIndex = 5) then begin
                        b[3]:=#$13;
                        b[1]:=#$1c;
                        b[2]:=#4;
                        b[5]:=ansichar(qtmppos[x] div 1024);
                        move(qstfile[x].Name[1],b[9],length(qstfile[x].Name));
                        filewrite(f,b[1],$18);
                    end else begin
                        move(qstfile[x].Name[1],b[5],length(qstfile[x].Name));
                        filewrite(f,b[1],$14);
                    end;
                    //write data
                    f1:=qtmpsize[x]-qtmppos[x];
                    if f1>1024 then f1:=1024;
                    setlength(b,1024);
                    fillchar(b[1],1024,0);
                    move(qtmp[x][qtmppos[x]],b[1],f1);
                    filewrite(f,b[1],1024);
                    inc(qtmppos[x],f1);
                    if qtmppos[x] >= qtmpsize[x] then inc (f2);
                    filewrite(f,f1,4);
                    if (SaveDialog1.FilterIndex = 5) then begin
                        f1:=0;
                        filewrite(f,f1,4);
                    end;
                end;
            end;
            fileclose(f);
            for x:=0 to qstfilecount-1 do freemem(qtmp[x]);
        end else if (SaveDialog1.FilterIndex = 9) or (SaveDialog1.FilterIndex = 10)
            or (SaveDialog1.FilterIndex = 11) or (SaveDialog1.FilterIndex = 12)then begin
            fn:=savedialog1.FileName;
            for x:=0 to qstfilecount-1 do begin
                fn:=changefileext(fn,extractfileext(qstfile[x].Name));
                if pos('.pvr',lowercase(qstfile[x].Name))>0 then begin
                //copy data only
                    f1:=qstfile[x].size;
                    move(qstfile[x].data[0],di[0],f1);
                end else begin
                    //compress
                    f1:=pikacompress(qstfile[x].data,di,qstfile[x].size);
                end;
                f:=filecreate(fn);
                filewrite(f,di[0],f1);
                fileclose(f);
            end;

        end else begin
            //normal uncompressed format
            fn:=savedialog1.FileName;
            for x:=0 to qstfilecount-1 do begin
                fn:=changefileext(fn,extractfileext(qstfile[x].Name));
                f:=filecreate(fn);
                filewrite(f,qstfile[x].data[0],qstfile[x].size);
                fileclose(f);
            end;
        end;

        freemem(di);
    end;
end;

end.
