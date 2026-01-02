unit NPCBuild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,D3DEngin, StdCtrls, Spin, ComCtrls;

type
    TNPCDATA = Record
        char_name:array[0..15] of ansichar;		   		// 370
	    unused1:DWORD;								// 380
	    unused2:DWORD;								// 384
	    name_color:DWORD;							// 388
	    extra_model:BYTE;							// 38C
	    unused:array[0..14] of BYTE;				// 38D
	    name_color_checksum:DWORD;					// 39C
	    section_id:BYTE;							// 3A0
	    char_class:BYTE;							// 3A1
	    v2_flags:BYTE;								// 3A2
	    version:BYTE;								// 3A3
	    v1_flags:DWORD;								// 3A4
	    costume:WORD;								// 3A8
	    skin:WORD;									// 3AA
	    face:WORD;									// 3AC
	    head:WORD;									// 3AE
	    hair:WORD;									// 3B0
	    hair_red:WORD;								// 3B2
	    hair_green:WORD;							// 3B4
	    hair_blue:WORD;								// 3B6
	    proportion_x:single;						// 3B8
	    proportion_y:single;						// 3BC
        UNINAME:array[0..35] of ansichar;
    end;
  TForm20 = class(TForm)
    Panel1: TPanel;
    Timer1: TTimer;
    ColorDialog1: TColorDialog;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Label9: TLabel;
    SpinEdit1: TSpinEdit;
    Label10: TLabel;
    Button17: TButton;
    Button18: TButton;
    Panel3: TPanel;
    TrackBar1: TTrackBar;
    Label11: TLabel;
    TrackBar2: TTrackBar;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NPCDATA:TNPCDATA;
  end;
  Procedure SetControl;


const robotflag: array[0..11] of byte = (0,0,1,0,1,1,0,0,0,1,0,0);
      skincount: array[0..11] of byte = (4,4,25,4,25,25,4,4,4,25,4,4);
      facecount: array[0..11] of byte = (5,5,0,5,0,0,5,5,5,0,5,5);
      costumecount: array[0..11] of byte = (18,18,0,18,0,0,18,18,18,0,18,18);
      haircount: array[0..11] of byte = (10,10,0,10,0,0,10,10,10,0,10,10);
      headcount: array[0..11] of byte = (1,1,5,1,5,5,1,1,1,5,1,1);
      NPC4hat:array[0..9] of byte = (0,2,0,1,1,1,0,1,1,1);
      NPC7hat:array[0..9] of word = (3,5,7,313,8,10,11,13,10,15);
                                                       //5
      NPC8hat:array[0..9] of word = (6,8,10,12,13,14,336,14,6,8);
      NPC9hat:array[0..9] of word = (12,14,16,18,20,21,23,13,15,25);
                                                           //24
                                     //330        //335
      NPC10hat:array[0..9] of word = (4,5,6,7,8,9,10,305,10,309);
      NPC11hat:array[0..9] of word = (6,6,311,9,9,10,10,11,13,13);

      NBofCostTex: array[0..11] of byte = (3,13,5,7,5,5,16,17,26,5,15,16);
      CosthaveSkin: array[0..11] of byte = (0,3,0,0,0,0,0,1,3,0,1,2);
      OffofCostTex: array[0..11] of word = (0,1,0,0,0,0,0,0,0,0,0,0);
      SectionIDOff: array[0..11] of word = (126,299,275,197,300,375,326,344,505,375,310,322);

      FaceOff:array[0..11] of word = (54,235,125,126,125,125,288,306,468,125,270,288);
      Faceway:array[0..11] of byte = (0,1,7,0,7,6,2,1,5,4,5,2);
      HeadPos:array[0..11] of single = (16.5,14.9,19,17.3,18.5,15,15.2,16.3,14,16.5,18,14.5);
      handpos:array[0..11] of word = (108,277,0,0,0,0,0,0,0,0,0,0);
      HairOff:array[0..11,0..9] of word = (
      (94,96,97,99,100,101,103,104,105,107),
      (259,261,263,265,267,268 ,269,271,273,275),
      (0,0,0,0,0,0,0,0,0,0),
      (166,167,168,169,170,170,172,174,166,166),
      (0,0,0,0,0,0,0,0,0,0),
      (0,0,0,0,0,0,0,0,0,0),
      (308,309,310,312,313,315,316,318,318,320),
      (331,330,331,332,333,334,336,337,337,337),
      (492,493,494,494,495,496,498,492,492,492),
      (0,0,0,0,0,0,0,0,0,0),
      (294,298,300,301,302,303,306,305,306,307),
      (308,310,312,313,315,317,318,319,319,321));

      TexOrder:array[0..11,1..20] of byte =
        ((1,2,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (1,2,3,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (1,2,3,4,5,6,7,8,9,10,0,0,0,0,0,0,0,0,0,0),
        (7,3,4,5,6,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (1,2,3,4,5,6,7,8,9,10,0,0,0,0,0,0,0,0,0,0),
        (2,3,4,1,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (1,16,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,0,0,0),
        (3,1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (1,2,3,4,5,6,7,8,9,10,12,13,14,0,0,0,0,0,0,0),
        (1,2,3,4,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
        (4,10,5,6,7,8,9,11,12,1,2,3,0,0,0,0,0,0,0,0),
        (3,2,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0));

      Class_name:array[0..11] of string =('HUmar','HUnewearl','HUcast','RAmar','RAcast','RAcaseal',
        'FOmarl','FOnewm','FOnewearl','HUcaseal','FOmar','RAmarl');
      NPC_Name: array[0..6] of string = ('GM','Rico','Sonic','Knux','Tails','Flowen','Elly');

      CharHeight:array[0..11] of single = (0.5,0.5,0,0,0,0.5,0,0.5,0.5,0.5,0,0.5);

var
  Form20: TForm20;
  NPCScreen:TPikaengine = nil;
  part1:T3dItem =nil;
  part2:T3dItem =nil;
  part3:T3dItem =nil;
  part4:T3dItem =nil;

  DXT1_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$40#$00#$00#$00#$40#$00#$00#$00#$00#$08
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$31
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
  DXT5_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$00#$01#$00#$00#$00#$01#$00#$00#$00#$00
        +#$01#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$35
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;

implementation

uses main;



{$R *.dfm}

Procedure SetControl;
begin
    form20.label7.Caption:=getlanguagestring(196)+' '+inttostr(form20.npcdata.section_id+1)+'/10';
    if form20.npcdata.v2_flags = 0 then form20.label10.Caption:=getlanguagestring(197)
    else form20.label10.Caption:=getlanguagestring(198)+' '+NPC_Name[form20.npcdata.extra_model];
    form20.label2.Caption:=Class_name[form20.npcdata.char_class];
    form20.Label11.Caption:=FloatToStrF(form20.NPCDATA.proportion_x,ffGeneral,3,0);
    form20.Label12.Caption:=FloatToStrF(form20.NPCDATA.proportion_y,ffGeneral,3,0);
    form20.Panel3.Color:=(form20.NPCDATA.name_color and $00ff00) + ((form20.NPCDATA.name_color and $ff0000) div $10000)+
        ((form20.NPCDATA.name_color and $ff)*$10000);
    if form20.NPCDATA.v2_flags = 0 then begin
    form20.label4.Caption:=getlanguagestring(199)+' '+inttostr(form20.npcdata.skin+1)+'/'+inttostr(Skincount[form20.npcdata.char_class]);
    form20.button3.Enabled:=true;
    form20.button4.Enabled:=true;
    form20.Label3.Font.Color:=clblack;
    form20.Label4.Font.Color:=clblack;
    if robotflag[form20.NPCDATA.char_class] = 1 then begin
        form20.Label8.Font.Color:=clblack; //clsilver
        form20.button13.Enabled:=true;
        form20.button14.Enabled:=true;
        form20.label8.Caption:=getlanguagestring(200)+' '+inttostr(form20.npcdata.head+1)+'/'+inttostr(headcount[form20.npcdata.char_class]);

        form20.Label3.Font.Color:=clsilver;
        form20.Label5.Font.Color:=clsilver;
        form20.Label6.Font.Color:=clsilver;
        form20.Label3.caption:=getlanguagestring(201);
        form20.Label5.caption:=getlanguagestring(201);
        form20.Label6.caption:=getlanguagestring(201);
        form20.npcdata.costume:=0;
        form20.npcdata.face:=0;
        form20.npcdata.hair:=0;
        form20.button1.Enabled:=false;
        form20.button2.Enabled:=false;
        form20.button7.Enabled:=false;
        form20.button8.Enabled:=false;
        form20.button5.Enabled:=false;
        form20.button6.Enabled:=false;
    end else begin
        form20.Label8.Font.Color:=clsilver;
        form20.button13.Enabled:=false;
        form20.button14.Enabled:=false;
        form20.label8.Caption:=getlanguagestring(201);
        form20.npcdata.head:=0;
        if form20.npcdata.skin> 3 then form20.npcdata.skin:=0;
        form20.Label3.Font.Color:=clblack;
        form20.Label5.Font.Color:=clblack;
        form20.Label6.Font.Color:=clblack;
        form20.label5.Caption:=getlanguagestring(202)+' '+inttostr(form20.npcdata.face+1)+'/'+inttostr(Skincount[form20.npcdata.char_class]);
        form20.label6.Caption:=getlanguagestring(203)+' '+inttostr(form20.npcdata.hair+1)+'/'+inttostr(haircount[form20.npcdata.char_class]);
        form20.label3.Caption:=getlanguagestring(204)+' '+inttostr(form20.npcdata.costume+1)+'/'+inttostr(costumecount[form20.npcdata.char_class]);
        form20.Button7.Enabled:=true;
        form20.Button8.Enabled:=true;
        form20.button1.Enabled:=true;
        form20.button2.Enabled:=true;
        form20.button5.Enabled:=true;
        form20.button6.Enabled:=true;
    end;
    end else begin
        form20.Label8.Font.Color:=clsilver;
        form20.button13.Enabled:=false;
        form20.button14.Enabled:=false;
        form20.label8.Caption:=getlanguagestring(201);
        form20.npcdata.head:=0;
        form20.npcdata.costume:=0;
        form20.npcdata.face:=0;
        form20.npcdata.hair:=0;
        form20.Label4.Font.Color:=clsilver;
        form20.Label5.Font.Color:=clsilver;
        form20.Label6.Font.Color:=clsilver;
        form20.Label3.Font.Color:=clsilver;
        form20.Label4.caption:=getlanguagestring(201);
        form20.Label5.caption:=getlanguagestring(201);
        form20.Label6.caption:=getlanguagestring(201);
        form20.label3.Caption:=getlanguagestring(201);
        form20.Button7.Enabled:=false;
        form20.Button8.Enabled:=false;
        form20.npcdata.skin:=0;
        form20.npcdata.face:=0;
        form20.npcdata.hair:=0;
        form20.npcdata.costume:=0;
        form20.button1.Enabled:=false;
        form20.button2.Enabled:=false;
        form20.button3.Enabled:=false;
        form20.button4.Enabled:=false;
        form20.button5.Enabled:=false;
        form20.button6.Enabled:=false;
    end;
end;

Function GetFromAFS(filename:string;entry:integer):TMemoryStream;
var x,f,i:integer;
    buf:array[0..$3f] of byte;
begin
    result:=tmemorystream.Create;
    f:=fileopen(filename,$40);
    fileread(f,x,4);
    if x = $534641 then begin
        fileread(f,x,4);
        if x>entry then begin
            fileseek(f,8+(entry*8),0);
            fileread(f,x,4);
            fileread(f,i,4);
            dec(i,64);
            result.SetSize(i+128);
            fileseek(f,x,0);
            fileread(f,buf[0],64);
            fileread(f,pansichar(result.memory)[128],i);
            move(DXT1_Header[1],pansichar(result.memory)[0],128);
            if buf[12] = 7 then
            move(DXT5_Header[1],pansichar(result.memory)[0],128);
            move(buf[4],pansichar(result.memory)[20],4);
            move(buf[20],pansichar(result.memory)[12],2);
            move(buf[22],pansichar(result.memory)[16],2);
        end;
    end;
    fileclose(f);
end;


Procedure BuildNPC;
var s,b:ansistring;
    x,i,y,c:integer;
    sx,sy:single;
    skinid:integer;
begin
    if part1 <> nil then part1.Free;
    if part2 <> nil then part2.Free;
    if part3 <> nil then part3.Free;
    if part4 <> nil then part4.Free;
    part1:=nil; part2:=nil; part3:=nil; part4:=nil;
    if form20.NPCDATA.v2_flags and 2 = 2 then begin
        part1:=T3ditem.Create(npcscreen);
        b:=path+'charmodel\pl'+chr(ord('Y')-form20.npcdata.extra_model)+'bdy00.nj';
        part1.LoadFromNJ(b,'','');
        s:=path+'charmodel\pl'+chr(ord('Y')-form20.npcdata.extra_model)+'tex.afs';
        if form20.npcdata.extra_model < 5 then
            part1.SetTexture(0,GetFromAFS(s,3+form20.npcdata.section_id )); //section id
        if form20.npcdata.extra_model = 5 then part1.SetTexture(0,GetFromAFS(s,6+form20.npcdata.section_id )); //section id
        if form20.npcdata.extra_model = 6 then part1.SetTexture(0,GetFromAFS(s,5+form20.npcdata.section_id ));
        part1.SetTexture(1,GetFromAFS(s,0));
        part1.SetTexture(2,GetFromAFS(s,1));
        if form20.npcdata.extra_model = 5 then begin
            part1.SetTexture(3,GetFromAFS(s,0));
            part1.SetTexture(1,GetFromAFS(s,1));
            part1.SetTexture(2,GetFromAFS(s,2));
            part1.SetTexture(4,GetFromAFS(s,3));
        end;
        if form20.npcdata.extra_model = 6 then begin
            part1.SetTexture(3,GetFromAFS(s,0));
            part1.SetTexture(2,GetFromAFS(s,2));
            part1.SetTexture(1,GetFromAFS(s,1));
        end;
        part1.Visible:=true;
        part2:=T3ditem.Create(npcscreen);
        b:=path+'charmodel\pl'+chr(ord('Y')-form20.npcdata.extra_model)+'hed00.nj';
        part2.LoadFromNJ(b,'','');
        part2.SetTexture(0,GetFromAFS(s,1));
        part2.SetTexture(1,GetFromAFS(s,2));
        if form20.npcdata.extra_model = 0 then begin
            part2.SetTexture(1,GetFromAFS(s,1));
            part2.SetTexture(0,GetFromAFS(s,2));
        end;
        if form20.npcdata.extra_model = 5 then begin
            part2.SetTexture(1,GetFromAFS(s,4));
            part2.SetTexture(0,GetFromAFS(s,5));
        end;
        if form20.npcdata.extra_model = 6 then part2.SetTexture(0,GetFromAFS(s,3));
        part2.PositionY:=15.7;
        if form20.npcdata.extra_model = 1 then part2.PositionY:=14.5;
        if form20.npcdata.extra_model = 2 then part2.PositionY:=7.3;
        if form20.npcdata.extra_model = 3 then part2.PositionY:=7.9;
        if form20.npcdata.extra_model = 4 then part2.PositionY:=5;
        if form20.npcdata.extra_model = 5 then part2.PositionY:=17;
        if form20.npcdata.extra_model = 6 then part2.PositionY:=14.5;
        part2.Visible:=true;

        if form20.npcdata.extra_model > 4 then begin
            part3:=T3ditem.Create(npcscreen);
            b:=path+'charmodel\pl'+chr(ord('Y')-form20.npcdata.extra_model)+'hai00.nj';
            part3.LoadFromNJ(b,'','');
            part3.SetTexture(3,GetFromAFS(s,5)); //hair
            if form20.npcdata.extra_model = 6 then part3.SetTexture(3,GetFromAFS(s,4)); //hair
            if form20.npcdata.extra_model = 5 then part3.PositionY:=17;
            if form20.npcdata.extra_model = 6 then part3.PositionY:=14.5;

            //part3.Color:=form20.npcdata.hair_Blue+(form20.npcdata.hair_green*256)+(form20.npcdata.hair_red*$10000);
            part3.Visible:=true;
        end;

    end else begin
    skinid:=form20.npcdata.costume;
    if robotflag[form20.NPCDATA.char_class] = 1 then skinid:=form20.npcdata.skin;
    part1:=T3ditem.Create(npcscreen);
    b:=path+'charmodel\pl'+chr(form20.npcdata.char_class+ord('A'))+'bdy00.nj';
    part1.LoadFromNJ(b,'','');
    s:=path+'charmodel\pl'+chr(form20.npcdata.char_class+ord('A'))+'tex.afs';
    part1.SetTexture(0,GetFromAFS(s,SectionIDOff[form20.npcdata.char_class]+form20.npcdata.section_id )); //section id

    i:=1;
    //load the skin texture
    y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
    c:=(CosthaveSkin[form20.npcdata.char_class] * form20.npcdata.skin);
    for x:=0 to CosthaveSkin[form20.npcdata.char_class]-1 do begin
        if TexOrder[form20.npcdata.char_class,i] <> 0 then
        part1.SetTexture(TexOrder[form20.npcdata.char_class,i],GetFromAFS(s,y+c+x));
        inc(i);
    end;
    //load static costume texture
    c:=(CosthaveSkin[form20.npcdata.char_class] * 4);
    y:=y+c;
    c:=NBofCostTex[form20.npcdata.char_class]-c;
    for x:=0 to c-1 do begin
        if TexOrder[form20.npcdata.char_class,i] <> 0 then
        part1.SetTexture(TexOrder[form20.npcdata.char_class,i],GetFromAFS(s,y+x));
        inc(i);
    end;
    if handpos[form20.npcdata.char_class] <> 0 then begin
        part1.SetTexture(i,GetFromAFS(s,handpos[form20.npcdata.char_class]+skinid ));   //hand? o_O
        if form20.npcdata.char_class = 1 then begin
            part1.SetTexture(i+1,GetFromAFS(s,handpos[form20.npcdata.char_class]+skinid+4 ));
            part1.SetTexture(i+2,GetFromAFS(s,handpos[form20.npcdata.char_class]+skinid+4 ));
            part1.SetTexture(i,GetFromAFS(s,handpos[form20.npcdata.char_class]+form20.npcdata.skin ));
        end;
    end;


    part1.Visible:=true;

    part2:=T3ditem.Create(npcscreen);
    b:=path+'charmodel\pl'+chr(form20.npcdata.char_class+ord('A'))+'hed'+inttohex(form20.npcdata.head,2)+'.nj';
    part2.LoadFromNJ(b,'','');

    if Faceway[form20.npcdata.char_class] = 0 then begin
    part2.SetTexture(0,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+(form20.npcdata.face*8)+(form20.npcdata.skin*2) )); //face
    part2.SetTexture(1,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+(form20.npcdata.face*8)+(form20.npcdata.skin*2)+1)); //ears
    end;
    if Faceway[form20.npcdata.char_class] = 1 then begin
    part2.SetTexture(1,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+(form20.npcdata.face*4)+form20.npcdata.skin+4)); //face
    part2.SetTexture(0,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+form20.npcdata.skin)); //ears
    end;
    if Faceway[form20.npcdata.char_class] = 5 then begin
    part2.SetTexture(0,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+(form20.npcdata.face*4)+form20.npcdata.skin+4)); //face
    part2.SetTexture(1,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+form20.npcdata.skin)); //ears
    end;
    if Faceway[form20.npcdata.char_class] = 2 then begin
    part2.SetTexture(0,GetFromAFS(s,FaceOff[form20.npcdata.char_class]+(form20.npcdata.face*4)+form20.npcdata.skin)); //face
    end;
    if Faceway[form20.npcdata.char_class] = 4 then begin
    y:=FaceOff[form20.npcdata.char_class]+(skinid*2)+(form20.npcdata.head*50);
    if form20.npcdata.head > 0 then y:=y-50;
    if form20.npcdata.head = 3 then y:=y+skinid
    else if form20.npcdata.head > 3 then inc(y,25);
    if form20.npcdata.head = 4 then y:=y+skinid;
    part2.SetTexture(0,GetFromAFS(s,y)); //face
    part2.SetTexture(1,GetFromAFS(s,y+1)); //face
    part2.SetTexture(2,GetFromAFS(s,y+2)); //face

    end;

    if Faceway[form20.npcdata.char_class] = 6 then begin
    y:=FaceOff[form20.npcdata.char_class]+(skinid*2)+(form20.npcdata.head*50);
    if form20.npcdata.head = 0 then y:=y+skinid
    else inc(y,25);
    if form20.npcdata.head = 4 then y:=y-skinid;
    if (form20.npcdata.head = 2) and (form20.npcdata.char_class = 5) then begin
        part2.SetTexture(0,GetFromAFS(s,y+1)); //face
        part2.SetTexture(1,GetFromAFS(s,y)); //face
        part2.SetTexture(2,GetFromAFS(s,y+2)); //face
    end else begin
    part2.SetTexture(0,GetFromAFS(s,y)); //face
    part2.SetTexture(1,GetFromAFS(s,y+1)); //face
    part2.SetTexture(2,GetFromAFS(s,y+2)); //face
    end;
    end;

    if Faceway[form20.npcdata.char_class] = 7 then begin
        if form20.npcdata.char_class = 2 then begin
            y:=FaceOff[form20.npcdata.char_class]+skinid+(form20.npcdata.head*25);
            if form20.npcdata.head = 0 then y:=y+skinid
            else y:=y+25;
        end;
        if form20.npcdata.char_class = 4 then begin
            y:=FaceOff[form20.npcdata.char_class]+skinid+(form20.npcdata.head*25);
            if form20.npcdata.head = 0 then y:=y+skinid
            else y:=y+25;
            if form20.npcdata.head = 2 then y:=y+skinid
            else if form20.npcdata.head>2 then y:=y+25;  
        end;
        part2.SetTexture(0,GetFromAFS(s,y)); //face
        if form20.npcdata.char_class = 2 then part2.SetTexture(1,GetFromAFS(s,164)); //face
    end;

    part2.PositionY:=HeadPos[form20.npcdata.char_class];

    part2.Visible:=true;




    if robotflag[form20.npcdata.char_class] = 0 then begin
    part3:=T3ditem.Create(npcscreen);
    b:=path+'charmodel\pl'+chr(form20.npcdata.char_class+ord('A'))+'hai'+inttohex(form20.npcdata.hair,2)+'.nj';
    part3.LoadFromNJ(b,'','');
    part3.SetTexture(0,GetFromAFS(s,HairOff[form20.npcdata.char_class,form20.npcdata.hair])); //hair
    part3.SetTexture(1,GetFromAFS(s,HairOff[form20.npcdata.char_class,form20.npcdata.hair]+1));
    part3.SetTexture(2,GetFromAFS(s,HairOff[form20.npcdata.char_class,form20.npcdata.hair]+2));
    part3.SetTexture(3,GetFromAFS(s,HairOff[form20.npcdata.char_class,form20.npcdata.hair]+3));
    part3.PositionY:=HeadPos[form20.npcdata.char_class]+0.1;

    part3.Color:=form20.npcdata.hair_Blue+(form20.npcdata.hair_green*256)+(form20.npcdata.hair_red*$10000);
    part3.Visible:=true;

    b:=path+'charmodel\pl'+chr(form20.npcdata.char_class+ord('A'))+'cap'+inttohex(form20.npcdata.hair,2)+'.nj';
    if fileexists(b) then begin
        part4:=T3ditem.Create(npcscreen);
        part4.LoadFromNJ(b,'','');
        if form20.npcdata.char_class = 0 then
            part4.SetTexture(0,GetFromAFS(s,103))
        else if form20.NPCDATA.char_class = 3 then begin
            y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
            part4.SetTexture(0,GetFromAFS(s,y+npc4hat[form20.npcdata.hair]));
            part4.SetTexture(1,GetFromAFS(s,y+npc4hat[form20.npcdata.hair]+1));
            part4.SetTexture(2,GetFromAFS(s,y+npc4hat[form20.npcdata.hair]+2));
            part4.SetTexture(3,GetFromAFS(s,y+npc4hat[form20.npcdata.hair]+3));
        end else if form20.NPCDATA.char_class = 6 then begin
            y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
            part4.SetTexture(0,GetFromAFS(s,y+npc7hat[form20.npcdata.hair]));
            part4.SetTexture(1,GetFromAFS(s,y+npc7hat[form20.npcdata.hair]+1));
            part4.SetTexture(2,GetFromAFS(s,y+npc7hat[form20.npcdata.hair]+2));
            part4.SetTexture(3,GetFromAFS(s,y+npc7hat[form20.npcdata.hair]+3));
            if form20.npcdata.hair = 7 then part4.SetTexture(1,GetFromAFS(s,y+5));
            if npc7hat[form20.npcdata.hair] > 30 then part4.SetTexture(0,GetFromAFS(s,npc7hat[form20.npcdata.hair]));
        end else if form20.NPCDATA.char_class = 7 then begin
            y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
            part4.SetTexture(0,GetFromAFS(s,y+npc8hat[form20.npcdata.hair]));
            part4.SetTexture(1,GetFromAFS(s,y+npc8hat[form20.npcdata.hair]+1));
            part4.SetTexture(2,GetFromAFS(s,y+npc8hat[form20.npcdata.hair]+2));
            part4.SetTexture(3,GetFromAFS(s,y+npc8hat[form20.npcdata.hair]+3));
            if form20.npcdata.hair = 0 then part4.SetTexture(2,GetFromAFS(s,330));
            if form20.npcdata.hair = 5 then part4.SetTexture(1,GetFromAFS(s,335));
            if form20.npcdata.hair = 9 then part4.SetTexture(1,GetFromAFS(s,y+16));
            if npc8hat[form20.npcdata.hair] > 30 then part4.SetTexture(0,GetFromAFS(s,npc8hat[form20.npcdata.hair]));
        end else if form20.NPCDATA.char_class = 10 then begin
            y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
            part4.SetTexture(0,GetFromAFS(s,y+NPC10hat[form20.npcdata.hair]));
            part4.SetTexture(1,GetFromAFS(s,y+NPC10hat[form20.npcdata.hair]+1));
            part4.SetTexture(2,GetFromAFS(s,y+NPC10hat[form20.npcdata.hair]+2));
            part4.SetTexture(3,GetFromAFS(s,y+NPC10hat[form20.npcdata.hair]+3));
            if form20.npcdata.hair = 1 then part4.SetTexture(2,GetFromAFS(s,299));
            if form20.npcdata.hair = 6 then part4.SetTexture(2,GetFromAFS(s,y+NPC10hat[form20.npcdata.hair]+1));
            if NPC10hat[form20.npcdata.hair] > 30 then part4.SetTexture(0,GetFromAFS(s,NPC10hat[form20.npcdata.hair]));
        end else if form20.NPCDATA.char_class = 11 then begin
            y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
            part4.SetTexture(0,GetFromAFS(s,y+NPC11hat[form20.npcdata.hair]));
            part4.SetTexture(1,GetFromAFS(s,y+NPC11hat[form20.npcdata.hair]+1));
            part4.SetTexture(2,GetFromAFS(s,y+NPC11hat[form20.npcdata.hair]+2));
            part4.SetTexture(3,GetFromAFS(s,y+NPC11hat[form20.npcdata.hair]+3));
            if NPC11hat[form20.npcdata.hair] > 30 then part4.SetTexture(0,GetFromAFS(s,NPC11hat[form20.npcdata.hair]));
        end else if form20.NPCDATA.char_class = 8 then begin
            y:=(NBofCostTex[form20.npcdata.char_class]*skinid) + OffofCostTex[form20.npcdata.char_class];
            part4.SetTexture(0,GetFromAFS(s,y+NPC9hat[form20.npcdata.hair]));
            part4.SetTexture(1,GetFromAFS(s,y+NPC9hat[form20.npcdata.hair]+1));
            part4.SetTexture(2,GetFromAFS(s,y+NPC9hat[form20.npcdata.hair]+2));
            part4.SetTexture(3,GetFromAFS(s,y+NPC9hat[form20.npcdata.hair]+3));
            if form20.npcdata.hair = 8 then part4.SetTexture(1,GetFromAFS(s,y+24));
            if form20.npcdata.hair = 7 then part4.SetTexture(1,GetFromAFS(s,493));
        end;
        part4.PositionY:=HeadPos[form20.npcdata.char_class]+0.1;
        part4.Visible:=true;
    end;

    end;
    sx:=1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3);
    sy:=form20.npcdata.proportion_x-0.5;
    if sy < 0 then sy:=-sy;
    sy:=(sy-0.16666)*1.2;
    sy:=sy+sx;
    part1.SetProportion(sy,sx,sy);
    //x 0.5 = slim 0 and 1 = fat
    part2.SetProportion(sy,1*sx,sy);
    part2.Positiony:=part2.Positiony*sx;
    if part3 <> nil then begin
    part3.SetProportion(sy,1*sx,sy);
    part3.Positiony:=part3.Positiony*sx;
    end;
    if part4 <> nil then begin
    part4.SetProportion(sy,1*sx,sy);
    part4.Positiony:=part4.Positiony*sx;
    end;

    end;

    NPCScreen.RenderSurface;

    {
     //textur pos and amount of choice et nombre dimage
     //head, body,hair,cap pos
     //robot or not

    }
end;

procedure TForm20.FormShow(Sender: TObject);
begin
    if NPCScreen = nil then begin
        NPCScreen:=TPikaEngine.Create(panel1.Handle,183,275,1);
        if NPCScreen.Enable then begin
        NPCScreen.AlphaEnabled:=true;
        NPCScreen.AlphaTestValue:=16;
        NPCScreen.Antializing:=true;
        NPCScreen.ViewDistance:=0;
        NPCScreen.TextureMirrored:=true;
        NPCScreen.BackGroundColor:=$FF303030;
        NPCScreen.LookAt(0,15,-25,0,10,0);
        NPCScreen.SetProjection(3.6,2,1,1,-1);
        //NPCScreen.LookAt(0,17,7,-1,16,0);
        end;
    end;
    panel2.Color:=form20.npcdata.hair_red+(form20.npcdata.hair_green*256)+(form20.npcdata.hair_blue*$10000);
    if npcscreen.Enable then
        BuildNPC;
end;

procedure TForm20.Timer1Timer(Sender: TObject);
begin
    if NPCScreen <> nil then
    if NPCScreen.Enable then
    NPCScreen.RenderSurface;
end;

procedure TForm20.Panel2Click(Sender: TObject);
begin
    if ColorDialog1.Execute then begin
        if ColorDialog1.Color = 0 then ColorDialog1.Color:=$010101;
        if ColorDialog1.Color = $ffffff then ColorDialog1.Color:=$FEFEFE;
        form20.npcdata.hair_red:=ColorDialog1.Color and 255;
        form20.npcdata.hair_Green:=(ColorDialog1.Color div 256) and 255;
        form20.npcdata.hair_Blue:=(ColorDialog1.Color div $10000) and 255;
    end;
    if form20.npcdata.v2_flags = 0 then
    panel2.Color:=form20.npcdata.hair_red+(form20.npcdata.hair_green*256)+(form20.npcdata.hair_blue*$10000);
    if npcscreen.Enable then
        part3.Color:=form20.npcdata.hair_Blue+(form20.npcdata.hair_green*256)+(form20.npcdata.hair_red*$10000);
end;

procedure TForm20.Button2Click(Sender: TObject);
begin
    dec(npcdata.hair);
    if npcdata.hair >= haircount[npcdata.char_class] then npcdata.hair:=haircount[npcdata.char_class]-1;
    label6.Caption:=getlanguagestring(203)+' '+inttostr(npcdata.hair+1)+'/'+inttostr(haircount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button1Click(Sender: TObject);
begin
    inc(npcdata.hair);
    if npcdata.hair >= haircount[npcdata.char_class] then npcdata.hair:=0;
    label6.Caption:=getlanguagestring(203)+' '+inttostr(npcdata.hair+1)+'/'+inttostr(haircount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button3Click(Sender: TObject);
begin
    dec(npcdata.skin);
    if npcdata.skin >= Skincount[npcdata.char_class] then npcdata.skin:=Skincount[npcdata.char_class]-1;
    label4.Caption:=getlanguagestring(199)+' '+inttostr(npcdata.skin+1)+'/'+inttostr(Skincount[npcdata.char_class]);
    if npcscreen.Enable then begin
        if robotflag[form20.NPCDATA.char_class] = 1 then NPCScreen.LookAt(0,15,-25,0,10,0)
        else NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button4Click(Sender: TObject);
begin
    inc(npcdata.skin);
    if npcdata.skin >= Skincount[npcdata.char_class] then npcdata.skin:=0;
    label4.Caption:=getlanguagestring(199)+' '+inttostr(npcdata.skin+1)+'/'+inttostr(Skincount[npcdata.char_class]);
    if npcscreen.Enable then begin
        if robotflag[form20.NPCDATA.char_class] = 1 then NPCScreen.LookAt(0,15,-25,0,10,0)
        else NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button5Click(Sender: TObject);
begin
   dec(npcdata.face);
    if npcdata.face >= facecount[npcdata.char_class] then npcdata.face:=facecount[npcdata.char_class]-1;
    label5.Caption:=getlanguagestring(202)+' '+inttostr(npcdata.face+1)+'/'+inttostr(Skincount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button6Click(Sender: TObject);
begin
    inc(npcdata.face);
    if npcdata.face >= facecount[npcdata.char_class] then npcdata.face:=0;
    label5.Caption:=getlanguagestring(202)+' '+inttostr(npcdata.face+1)+'/'+inttostr(Skincount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button7Click(Sender: TObject);
begin
    dec(npcdata.costume);
    if npcdata.costume >= costumecount[npcdata.char_class] then npcdata.costume:=costumecount[npcdata.char_class]-1;
    label3.Caption:=getlanguagestring(204)+' '+inttostr(npcdata.costume+1)+'/'+inttostr(costumecount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
end;

procedure TForm20.Button8Click(Sender: TObject);
begin
    inc(npcdata.costume);
    if npcdata.costume >= costumecount[npcdata.char_class] then npcdata.costume:=0;
    label3.Caption:=getlanguagestring(204)+' '+inttostr(npcdata.costume+1)+'/'+inttostr(costumecount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
end;

procedure TForm20.Button10Click(Sender: TObject);
begin
    dec(npcdata.char_class);
    if npcdata.char_class >11 then npcdata.char_class:=11;
    label2.Caption:=Class_name[npcdata.char_class];
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
    SetControl;
end;

procedure TForm20.Button9Click(Sender: TObject);
begin
    inc(npcdata.char_class);
    if npcdata.char_class >11 then npcdata.char_class:=0;
    label2.Caption:=Class_name[npcdata.char_class];
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
    SetControl;
end;

procedure TForm20.Button11Click(Sender: TObject);
begin
    dec(npcdata.section_id);
    if npcdata.section_id > 9 then npcdata.section_id:=9;
    label7.Caption:=getlanguagestring(205)+' '+inttostr(npcdata.section_id+1)+'/10';
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
end;

procedure TForm20.Button12Click(Sender: TObject);
begin
    inc(npcdata.section_id);
    if npcdata.section_id > 9 then npcdata.section_id:=0;
    label7.Caption:=getlanguagestring(205)+' '+inttostr(npcdata.section_id+1)+'/10';
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
end;

procedure TForm20.Button13Click(Sender: TObject);
begin
    dec(npcdata.head);
    if npcdata.head >= headcount[npcdata.char_class] then npcdata.head:=headcount[npcdata.char_class]-1;
    label8.Caption:=getlanguagestring(200)+' '+inttostr(npcdata.head+1)+'/'+inttostr(headcount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button14Click(Sender: TObject);
begin
    inc(npcdata.head);
    if npcdata.head >= headcount[npcdata.char_class] then npcdata.head:=0;
    label8.Caption:=getlanguagestring(200)+' '+inttostr(npcdata.head+1)+'/'+inttostr(headcount[npcdata.char_class]);
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3))
        ,-9,0,headpos[npcdata.char_class]*(1+((CharHeight[form20.npcdata.char_class]-form20.npcdata.proportion_y)/3)),0);
        BuildNPC;
    end;
end;

procedure TForm20.Button16Click(Sender: TObject);
begin
    form20.ModalResult:=0;
    close;
end;

procedure TForm20.Button15Click(Sender: TObject);
begin
isedited:=true;
    form20.ModalResult:=1;
end;

procedure TForm20.Edit1Change(Sender: TObject);
var x:integer;
  s:ansistring;
begin
    fillchar(npcdata.char_name[0],16,0);
    s:=edit1.text;
    move(s[1],npcdata.char_name[0],length(s));
    fillchar(npcdata.UNINAME[0],32,0);
    npcdata.UNINAME[0]:=#9;
    npcdata.UNINAME[2]:='J';
    for x:=0 to 12 do
        npcdata.UNINAME[4+(x*2)]:=npcdata.char_name[x];
end;

procedure TForm20.Button18Click(Sender: TObject);
begin
    if npcdata.v2_flags = 0 then begin
        npcdata.v2_flags := 11;
        npcdata.extra_model:=0;
    end else begin
        inc(npcdata.extra_model);
        if npcdata.extra_model = 7 then begin
            npcdata.v2_flags := 0;
            npcdata.extra_model:=0;
        end;
    end;

    if npcdata.v2_flags = 0 then label10.Caption:=getlanguagestring(197)
    else label10.Caption:=getlanguagestring(198)+' '+NPC_Name[npcdata.extra_model];
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
    SetControl;
end;

procedure TForm20.Button17Click(Sender: TObject);
begin
    if npcdata.v2_flags = 0 then begin
        npcdata.v2_flags := 2;
        npcdata.extra_model:=6;
    end else begin
        dec(npcdata.extra_model);
        if npcdata.extra_model = 255 then begin
            npcdata.v2_flags := 0;
            npcdata.extra_model:=0;
        end;
    end;

    if npcdata.v2_flags = 0 then label10.Caption:=getlanguagestring(197)
    else label10.Caption:=getlanguagestring(198)+' '+NPC_Name[npcdata.extra_model];
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
    SetControl;
end;

procedure TForm20.Panel3Click(Sender: TObject);
begin
    if ColorDialog1.Execute then begin
        form20.npcdata.name_color:=(ColorDialog1.Color div $10000)+(ColorDialog1.Color and $ff00)
            +((ColorDialog1.Color and $ff)*$10000) + $ff000000;
        panel3.Color:=ColorDialog1.Color;
    end;
end;

procedure TForm20.TrackBar1Change(Sender: TObject);
begin
    form20.NPCDATA.proportion_x:=TrackBar1.Position / 100;
    form20.Label11.Caption:=FloatToStrF(form20.NPCDATA.proportion_x,ffGeneral,3,0);
    if npcscreen <> nil then
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
end;

procedure TForm20.TrackBar2Change(Sender: TObject);
begin
    form20.NPCDATA.proportion_y:=TrackBar2.Position / 100;
    form20.Label12.Caption:=FloatToStrF(form20.NPCDATA.proportion_y,ffGeneral,3,0);
    if npcscreen <> nil then
    if npcscreen.Enable then begin
        NPCScreen.LookAt(0,15,-25,0,10,0);
        BuildNPC;
    end;
end;

end.
