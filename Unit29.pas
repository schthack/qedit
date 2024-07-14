unit Unit29;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ScktComp, shellapi;

type
  TForm29 = class(TForm)
    Memo1: TMemo;
    Image1: TImage;
    Memo2: TMemo;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    Button2: TButton;
    ClientSocket1: TClientSocket;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Function GetHttpFile(nom:string):boolean;

var
  Form29: TForm29;
  tmpfile:TMemoryStream;
  httpname,ltext,fcrc,fsource,fdest:string;
  httpstat,inerror:integer;
  httpsize,httprecv,picpos,mstat,lpc,updpos:integer;
  inupdate:boolean=false;
  tmplist:TStringList=nil;
  fileupd:tstringlist=nil;
  function Startonl:boolean;

implementation

uses crc32, main;

{$R *.dfm}

Function GetHttpFile(nom:string):boolean;
begin
    httpname:='GET '+nom+' HTTP/1.1'#13#10+'Host: qedit.schtserv.com'#13#10
        +'Connection: Keep-Alive'#13#10#13#10 ;
    httpstat:=0;
    httpsize:=0;
    tmpfile:=TMemoryStream.Create;
    form29.ClientSocket1.Open;
    inupdate:=true;
end;

function Startonline:boolean;
var di,da:pchar;
begin
    ClearShadow;
    di:=stralloc(1024);
    da:=stralloc(1024);
    strpcopy(da,'');
    strpcopy(di,ExtractFilePath(Application.ExeName));
    ShellExecute(0,'open','_qedit.exe',da,di,SW_SHOW);
    application.Terminate;
end;

function Startonl:boolean;
var di,da:pchar;
begin
    di:=stralloc(1024);
    da:=stralloc(1024);
    strpcopy(da,'');
    strpcopy(di,ExtractFilePath(Application.ExeName));
    ShellExecute(0,'open','qedit.exe',da,di,SW_SHOW);
    application.Terminate;
end;

Procedure LoadConfig;
var x,y:integer;
    b,cr,fi:string;
    s:tstringlist;
begin
    if fileupd = nil then fileupd:=tstringlist.Create;
    fileupd.Clear;
    form29.Memo1.Clear;
    form29.Memo1.Lines.Add('');
    s:=tstringlist.Create;
    updpos:=0;
    for x:=0 to tmplist.Count-1 do begin
        if copy(tmplist.Strings[x],1,5) = 'desc=' then begin
            s.Clear;
            s.Add(copy(tmplist.Strings[x],6,length(tmplist.Strings[x])-5));
        end;
        if copy(tmplist.Strings[x],1,5) = 'dsca=' then begin
            s.Add(copy(tmplist.Strings[x],6,length(tmplist.Strings[x])-5));
        end;
        if copy(tmplist.Strings[x],1,5) = 'file=' then begin
            b:=copy(tmplist.Strings[x],6,length(tmplist.Strings[x])-5);
            //extract file name and crc
            cr:=copy(b,1,8);
            fi:=copy(b,10,length(b)-9);
            y:=pos(' ',fi);
            fi:=copy(fi,1,y-1);
            //test it
            if inttohex(crc32offile(path+fi),8) <> cr then begin
                fileupd.Add(b);
                if s.Count > 0 then begin
                    form29.Memo1.Lines.AddStrings(s);
                    form29.Memo1.Lines.Add('');
                    s.Clear;
                end;
            end;
            
        end;
    end;
    form29.Label1.Caption:='0/'+inttostr(fileupd.Count);
    s.Free;
    if fileupd.Count = 0 then begin
        form29.Memo1.Lines.Add('');
        form29.Memo1.Lines.Add('');
        form29.Memo1.Lines.Add('');
        form29.Memo1.Lines.Add(getlanguagestring(285));
        form29.Button1.Caption:=getlanguagestring(113);
    end else form29.Button1.Caption:=getlanguagestring(286);
end;

procedure RequestNextFiles;
var x,y:integer;
    s,b,cr,fi:string;
begin
    if updpos < fileupd.Count then begin
    b:=fileupd.Strings[updpos];
    //extract file name and crc
    cr:=copy(b,1,8);
    fi:=copy(b,10,length(b)-9);
    y:=pos(' ',fi);
    fdest:=copy(fi,1,y-1);
    delete(fi,1,y);
    inc(updpos);
    form29.Label1.Caption:=inttostr(updpos)+'/'+inttostr(fileupd.Count)+' '+fdest;
    GetHttpFile(fi);
    end else begin
        fileupd.Clear;
        form29.Label1.Caption:=getlanguagestring(287);
        form29.Button1.Caption:=getlanguagestring(113);
        form29.Button1.Enabled:=true;
        showmessage(getlanguagestring(288));
    end;
end;

procedure FolderCheck(fdest:string);
var s,b:string;
    x:integer;
begin
    s:=extractfilepath(fdest);
    x:=pos('\',s);
    if x = 0 then x:=length(s);
    b:=copy(s,1,x-1);
    while s <> '' do begin
        delete(s,1,x);
        if not directoryexists(b) then createdir(b);
        x:=pos('\',s);
        if x = 0 then x:=length(s);
        b:=b+'\'+copy(s,1,x-1) ;
    end;
end;

Function HTTPFileGot:boolean;
begin
    tmpfile.Position:=0;
    if mstat = 0 then begin
        if tmplist = nil then tmplist:=TStringlist.Create;
        tmplist.Clear;
        tmplist.LoadFromStream(tmpfile);
        LoadConfig;
        tmpfile.Free;
        mstat:=1;
        lpc:=0;
        //form1.Memo1.Lines.LoadFromStream(tmpfile);
    end;
    if mstat = 2 then begin
        if fdest = 'qedit.exe' then begin
            if isedited then begin
            if MessageDlg(getlanguagestring(289),
                    mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
            tmpfile.SaveToFile(path+'_qedit.exe');
            tmpfile.Free;
            startonline;
            end;
            end else begin
                tmpfile.SaveToFile(path+'_qedit.exe');
                tmpfile.Free;
                startonline;
            end;
           // mstat:=1;
        end else begin
        FolderCheck(path+fdest);
        tmpfile.SaveToFile(path+fdest);
        tmpfile.Free;
        RequestNextFiles;
        end;
    end;
end;

procedure TForm29.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    socket.SendText(httpname);
    inerror:=0;
end;

procedure TForm29.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
    inerror:=1;
    socket.close;
    if mstat = 0 then begin
        memo1.Clear;
        memo1.Lines.Add('');
        memo1.Lines.Add('');
        memo1.Lines.Add('');
        memo1.Lines.Add(getlanguagestring(290));
    end;
end;

procedure TForm29.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
  var s,b:string;
    x:integer;
begin
    s:=socket.ReceiveText;
    if httpstat = 0 then begin
        httprecv:=0;

        x:=pos('Content-Length:',s);
        if x > 0 then begin
            b:=copy(s,x+16,10);
            x:=pos(#13,b);
            b:=copy(b,1,x-1);
            httpsize:=strtoint(b);
            x:=pos(#13#10#13#10,s);
            delete(s,1,x+3);
            httpstat:=1;
        end else begin
            socket.Close;

            MessageDlg(getlanguagestring(291), mtInformation,[mbOk], 0);

        end;
    end;
    if httpstat = 1 then begin
        tmpfile.WriteBuffer(s[1],length(s));
        inc(httprecv,length(s));
        form29.ProgressBar1.Max:=httpsize;
        form29.ProgressBar1.Position:=httprecv;
        if httprecv >= httpsize then begin
            socket.Close;
            //call the file got
            HttpFileGot;
        end;
    end;
end;

procedure TForm29.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var s:string;
begin
    if inerror = 0 then
    if socket.ReceiveLength > 0 then begin
    s:=socket.ReceiveText;
    while s <> '' do begin
    if httpstat = 1 then begin
        tmpfile.WriteBuffer(s[1],length(s));
        inc(httprecv,length(s));
        form29.ProgressBar1.Max:=httpsize;
        form29.ProgressBar1.Position:=httprecv;
        if httprecv >= httpsize then begin
            //socket.Close;
            //call the file got
            HttpFileGot;
        end;
    end;
    s:=socket.ReceiveText;
    end;
    if httprecv < httpsize then begin

            MessageDlg(getlanguagestring(291), mtInformation,[mbOk], 0);
            button1.Enabled:=true;
    end;
    end;
    inupdate:=false;
end;

procedure TForm29.Button2Click(Sender: TObject);
begin
    close;
end;

procedure TForm29.Button1Click(Sender: TObject);
begin
    if fileupd.Count = 0 then close
    else begin
        //start the updates
         mstat:=2;
         //get files
         button1.Enabled:=false;
         RequestNextFiles;
    end;
end;



end.


