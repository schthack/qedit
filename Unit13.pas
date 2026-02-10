unit Unit13;

interface

uses
  Windows, Registry, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, D3Dx9, StdCtrls, Vcl.DBGrids, Vcl.Menus;

type
  TForm13 = class(TForm)
    Timer1: TTimer;
    popupWave: TPopupMenu;
    popupGroup: TPopupMenu;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure popupWavePopup(Sender: TObject);
    procedure popupGroupPopup(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;
  lmx,lmy:integer;
  inclick:boolean = false;
  inclickz,inclickx,inclicky:single;
  rotx:integer;
  ini:integer=1024;
  dta:integer=0;
  fog:integer=1;
  rtx,rty,rtz:boolean;
  
  fogCol:dword;
  fogstart,fogtstart:single;
  fogend,fogtend:single;
  fogspeed:dword;
  fogtime:dword;
  fogtcol:dword;
  fogcurrent:dword;
  fogtype:integer=1;
  fogfl1,fogfl2:single;
  fogstep:single;
  Keys:array[0..256] of boolean;
  movespeed: integer = 3;
  autoadjustsect: Boolean = false;
  autoadjustY: Boolean = false;
  lastclick: integer = 0;

implementation

uses main, Unit1, MyConst, FSnap, Unit17;

{$R *.dfm}

function GoForward:boolean;
var px,py,pz:single;
begin
    px:=cos(vr);
    py:=sin(vz);
    pz:=(cos(vz))*sin(vr);
    ppx:=ppx+(px*movespeed);
    ppy:=ppy+(py*movespeed);
    ppz:=ppz+(pz*movespeed);
    myscreen.SetView(ppx,ppy,ppz,vr,vz);
end;

function GoBackward:boolean;
var px,py,pz:single;
begin
    px:=cos(vr);
    py:=sin(vz);
    pz:=(cos(vz))*sin(vr);
    ppx:=ppx-(px*movespeed);
    ppy:=ppy-(py*movespeed);
    ppz:=ppz-(pz*movespeed);
    myscreen.SetView(ppx,ppy,ppz,vr,vz);
end;

function ClosestRot(rt: dword): integer;
var
  rtvalues: array of integer;
  closest,diff,diffmin,i: integer;
begin
  // Static rotation values
  rtvalues := [0, 4096, 8192, 12288, 16384, 20480, 24576, 28672,
              32768, 36864, 40960, 45056, 49152, 53248, 57344, 61440, 65536,
              -4096, -8192, -12288, -16384, -20480, -24576, -28672, -32768,
              -36864, -40960, -45056, -49152, -53248, -57344, -61440, -65536];

    // Find the closest rotation value to the user's selection
    closest := rtvalues[0];
    diffmin := abs(rtvalues[0] - rt);
    for i := 0 to High(rtvalues) do
    begin
      diff := abs(rt - rtvalues[i]);
      if diff < diffmin then
      begin
        diffmin := diff;
        closest := i;
      end;
    end;
    // Return the new value
    result := rtvalues[closest];
end;

procedure AutoRotate(rtinc: integer);
begin
  form1.SetUndow;
  if sType = 1 then
  begin
    floor[sfloor].Monster[selected].Direction := rtinc;
    GenerateMonsterName(Floor[sfloor].Monster[selected],selected,2);
  end;
  if sType = 2 then
  begin
    floor[sfloor].Obj[selected].unknow6 := rtinc;
    myobj[selected].Free;
    Generateobj(floor[sfloor].obj[selected],selected);
  end;
  form1.DrawMap;
end;

procedure TForm13.Timer1Timer(Sender: TObject);
var d1,d2,d3:dword;
    f1,f2,f3:double;
    r,g,b,r1,b1,g1:integer;
    x,i,j:integer;
    s: string;
begin
    if have3d then
    if myscreen <> nil then begin

        //particle
        //particle.SetCoordinate(0,10,0);

        //fog change

       if fogspeed <> 0 then begin
           //get the nes distance
           f3:=integer(fogspeed-gettickcount);
           f1:=((fogstart - fogtstart) / fogtime) * f3;
           f2:=((fogend - fogtend) / fogtime) * f3;
           //the color now
           r:=fogcol and 255;
           g:=(fogcol div 256) and 255;
           b:=(fogcol div $10000) and 255;
           r1:=fogtcol and 255;
           g1:=(fogtcol div 256) and 255;
           b1:=(fogtcol div $10000) and 255;
           r:=r1+((((r - r1) * round(f3)) div fogtime) and 255);
           g:=g1+((((g - g1) * round(f3)) div fogtime) and 255);
           b:=b1+((((b - b1) * round(f3)) div fogtime) and 255);

           if f3>0 then
                myscreen.SetFog(r+(g*256)+(b*$10000),fogtstart+f1,fogtend+f2)
           else begin
               myscreen.SetFog(fogtcol,fogtstart,fogtend);
               fogspeed:=0;
               fogstart:=fogtstart;
               fogend:=fogtend;
               fogcol:=fogtcol;
               if fogtype = 2 then begin
                   fogtend:=fogfl2;
                   fogtime:=round(((abs(fogfl1-fogfl2) / fogstep)/60)*1000);
                   fogspeed:=gettickcount+fogtime;
                   fogtype:=3;
                   if fogtime = 0 then fogspeed:=0;
               end else if fogtype = 3 then begin
                   fogtend:=fogfl1;
                   fogtime:=round(((abs(fogfl1-fogfl2) / fogstep)/60)*1000);
                   fogspeed:=gettickcount+fogtime;
                   fogtype:=2;
                   if fogtime = 0 then fogspeed:=0;
               end
           end;
       end;

       //look if a fog array
       i:=0;
       if fog = 1 then
       for x:=0 to floor[sfloor].ObjCount-1 do begin
       if (floor[sfloor].Obj[x].Skin = 7) or (floor[sfloor].Obj[x].Skin = 24) or (floor[sfloor].Obj[x].Skin = 352) or (floor[sfloor].Obj[x].Skin = 913) then begin
           f1:=sqrt(sqr((MyObj[x].PositionX) - ppx)
                +sqr((MyObj[x].PositionZ-ppz)));
           f1:=sqrt(sqr(f1)+sqr(MyObj[x].PositionY-ppy));
           if f1 < floor[sfloor].Obj[x].unknow8 then begin
                i:=1;
                r:=floor[sfloor].Obj[x].obj_id and 255;
                if floor[sfloor].Obj[x].Skin = 352 then r:=floor[sfloor].Obj[x].action and 255;
                if r <> fogcurrent then begin
                    //in it.... runnnnnnnnnnnnnnnnnnnnn
                    fogtime:=round(fogentry[r].F13*10);
                    if fogspeed <> 0 then begin
                        fogspeed:=gettickcount+(fogtime-(fogspeed-gettickcount));
                        fogstart:=fogtstart;
                        fogend:=fogtend;
                        fogcol:=fogtcol;
                    end else fogspeed:=gettickcount+fogtime;
                   fogtstart:=fogentry[r].F4;
                    fogtend:=fogentry[r].F3;
                    fogtcol:=fogentry[r].F2;
                    fogcurrent:=r;
                    fogtype:=fogentry[r].F1;
                    fogfl1:=fogtend-fogentry[r].F9;
                    fogfl2:=fogtend-fogentry[r].F11;
                    fogstep:=fogentry[r].F7;
                    if fogtype = 2 then begin
                        fogtend:=fogfl1;
                    end;
                    if fogtime = 0 then fogspeed:=0;
                end;
           end;
       end;
       end;
       if i = 0 then begin
        r:=FloorFog[floor[sfloor].floorid];
           if r <> fogcurrent then begin
                    //in it.... runnnnnnnnnnnnnnnnnnnnn
                    fogtime:=round(fogentry[r].F13*10);
                    if fogspeed <> 0 then begin
                        fogspeed:=gettickcount+(fogtime-(fogspeed-gettickcount));
                        fogstart:=fogtstart;
                        fogend:=fogtend;
                        fogcol:=fogtcol;
                    end else fogspeed:=gettickcount+fogtime;
                    fogtstart:=fogentry[r].F4;
                    fogtend:=fogentry[r].F3;
                    fogtcol:=fogentry[r].F2;
                    fogtype:=fogentry[r].F1;
                    fogfl1:=fogtend-fogentry[r].F9;
                    fogfl2:=fogtend-fogentry[r].F11;
                    fogstep:=fogentry[r].F7;
                    if fogtype = 2 then begin
                        fogtend:=fogfl1;
                    end;
                    fogcurrent:=r;

                end;
       end;




        if dta = 0 then
        myscreen.TextOut('X: '+floattostrf(ppx,ffGeneral,6,2)+'  Y: '+floattostrf(ppy,ffGeneral,6,2)+
        '  Z: '+floattostrf(-ppz,ffGeneral,6,2)+'  Rotation: '+
        inttostr(round(vr*10430.37835047) and $ffff)+'/'+inttostr(round(vz*10430.37835047) and $ffff),rect(0,0,640,30),$FFFFFFFF,1)
        else if dta = 1 then begin
        move(ppx,d1,4);
        move(ppy,d2,4);
        move(ppz,d3,4);
        myscreen.TextOut('X: '+inttohex(d1,8)+'  Y: '+inttohex(d2,8)+
        '  Z: '+inttohex(d3,8)+'  Rotation: '+
        inttohex(round(vr*10430.37835047) and $ffff,8)+'/'+inttohex(round(vz*10430.37835047) and $ffff,8),rect(0,0,640,30),$FFFFFFFF,1);
        end
        else
        begin
          if selected > -1 then
          begin
            if sType = 1 then
              myscreen.TextOut(
              'Map section: ' +
              inttostr(Floor[sfloor].Monster[Selected].map_section) +
              ' | Wave: ' + inttostr(Floor[sfloor].Monster[Selected].Unknow5) +
              ' | X: ' + inttostr(round(Floor[sfloor].Monster[Selected].Pos_X)) +
              ' | Y: ' + inttostr(round(Floor[sfloor].Monster[Selected].Pos_Z)) +
              ' | Z: ' + inttostr(round(Floor[sfloor].Monster[Selected].Pos_Y)) +
              ' | Rotation: ' + inttostr((Floor[sfloor].Monster[Selected].Direction) and
              $FFFF div 182) + '°',rect(0,0,640,30),$FFFFFFFF,1)
            else if sType = 2 then
            begin
              for j := 0 to RotateCount - 1 do
                if Floor[sfloor].Obj[Selected].Skin = RotateItm[j] then break;
              if j < RotateCount then
                 myscreen.TextOut(
              'Map section: ' +
              inttostr(Floor[sfloor].Obj[Selected].map_section) +
              ' | Group: ' + inttostr(Floor[sfloor].Obj[Selected].grp) +
              ' | X: ' + inttostr(round(Floor[sfloor].Obj[Selected].Pos_X)) +
              ' | Y: ' + inttostr(round(Floor[sfloor].Obj[Selected].Pos_Z)) +
              ' | Z: ' + inttostr(round(Floor[sfloor].Obj[Selected].Pos_Y)) +
              ' | Rotation X: ' + inttostr((Floor[sfloor].Obj[Selected].unknow5) and
              $FFFF div 182) + '°' +
              ' | Rotation Y: ' + inttostr((Floor[sfloor].Obj[Selected].unknow6) and
              $FFFF div 182) + '°' +
              ' | Rotation Z: ' + inttostr((Floor[sfloor].Obj[Selected].unknow7) and
              $FFFF div 182) + '°'
              ,rect(0,0,1280,30),$FFFFFFFF,1)
              else
              myscreen.TextOut(
              'Map section: ' +
              inttostr(Floor[sfloor].Obj[Selected].map_section) +
              ' | Group: ' + inttostr(Floor[sfloor].Obj[Selected].grp) +
              ' | X: ' + inttostr(round(Floor[sfloor].Obj[Selected].Pos_X)) +
              ' | Y: ' + inttostr(round(Floor[sfloor].Obj[Selected].Pos_Z)) +
              ' | Z: ' + inttostr(round(Floor[sfloor].Obj[Selected].Pos_Y)) +
              ' | Rotation: ' + inttostr((Floor[sfloor].Obj[Selected].unknow6) and
              $FFFF div 182) + '°',rect(0,0,640,30),$FFFFFFFF,1)
            end
              else
                myscreen.TextOut('Map section: - Wave: - X: - Y: - Z: - Rotation: - ',rect(0,0,640,30),$FFFFFFFF,1);
          end
          else
            myscreen.TextOut('Map section: - Wave: - X: - Y: - Z: - Rotation: - ',rect(0,0,640,30),$FFFFFFFF,1);
        end;

        s := GetLanguageString(484) + inttostr(round(movespeed / 3)) + '00%, ';
        if autoadjustsect then
          s := s + GetLanguageString(485)
        else
          s := s + GetLanguageString(486);
        if autoadjustY then
          s := s + GetLanguageString(487)
        else
          s := s + GetLanguageString(488);
        myscreen.TextOut(s,rect(0,15,form13.Width,45),$FFFFFFFF,1);

        if previewstate > 0 then
        begin
          MyScreen.TextOut(previewstring +
          ' (' + inttostr(previewstate) + '/' +
          inttostr(Floor[form1.CheckListBox1.ItemIndex].Unknow[8]) + ')',
          rect(0,45,640,75),$FFFFFFFF,1);
          MyScreen.TextOut('Section: ' + inttostr(prevsection),rect(0,60,640,90),$FFFFFFFF,1);
          MyScreen.TextOut('Wave: ' + inttostr(mapwave),rect(0,75,640,105),$FFFFFFFF,1);
          MyScreen.TextOut((delaystring),rect(0,90,640,120),$FFFFFFFF,1);
          if Floor[form1.CheckListBox1.ItemIndex].Unknow[15] = $32 then
          begin
            MyScreen.TextOut((settingstring),rect(0,105,640,135),$FFFFFFFF,1);
            MyScreen.TextOut((actionstring),rect(0,120,form13.Width,150),$FFFFFFFF,1)
          end
          else MyScreen.TextOut((actionstring),rect(0,105,form13.Width,135),$FFFFFFFF,1);
          if previewpaused then
          begin
            if Floor[form1.CheckListBox1.ItemIndex].Unknow[15] = $32 then
              MyScreen.TextOut(GetLanguageString(482),rect(0,150,form13.Width,180),$FFFFFFFF,1)
            else
              MyScreen.TextOut(GetLanguageString(482),rect(0,135,form13.Width,165),$FFFFFFFF,1);
          end;
          myscreen.TextOut(GetLanguageString(489),rect(0,form13.Height-35,form13.Width,form13.Height-19),$FFFFFFFF,1);
        end;

        if ini > 0 then begin
            dec(ini);
            myscreen.TextOut(GetLanguageString(530),rect(0,form13.Height-95,form13.Width,form13.Height-79),$FFFFFFFF,1);
            myscreen.TextOut(GetLanguageString(490),rect(0,form13.Height-80,form13.Width,form13.Height-64),$FFFFFFFF,1);
            myscreen.TextOut(GetLanguageString(491),rect(0,form13.Height-65,form13.Width,form13.Height-49),$FFFFFFFF,1);
            myscreen.TextOut(GetLanguageString(492),rect(0,form13.Height-50,form13.Width,form13.Height-34),$FFFFFFFF,1);
            if (borderStyle = bsNone) and (previewstate = 0) then
              myscreen.TextOut(GetLanguageString(493),rect(0,form13.Height-35,form13.Width,form13.Height-19),$FFFFFFFF,1);
        end;
        myscreen.RenderSurface;
        if Keys[Ord('Q')] then GoForward;
        if Keys[Ord('A')] then GoBackward;

        rtx:=false;
        rty:=false;
        rtz:=false;
        if Keys[Ord('X')] then rtx:=true;
        if Keys[Ord('Y')] then rty:=true;
        if Keys[Ord('Z')] then rtz:=true;



    if selected > -1 then begin
    if stype = 1 then begin
        sel3d.SetCoordinate(mymonst[selected].PositionX ,
            floor[sfloor].Monster[selected].Pos_z+miz[Floor[sfloor].Monster[selected].map_section]+0.5,
            mymonst[selected].Positionz );

    end;
    if stype = 2 then begin
        sel3d.SetCoordinate(MyObj[selected].PositionX ,
            floor[sfloor].obj[selected].Pos_Z+miz[Floor[sfloor].obj[selected].Map_Section]+0.5,
            MyObj[selected].Positionz );

    end;
    sel3d2.SetCoordinate(sel3d.PositionX,sel3d.PositionY,sel3d.PositionZ);
    sel3d.SetRotation(gettickcount / 20,0,0);
    sel3d2.SetRotation(gettickcount / 40,0,0);
    sel3d.Visible:=true;
    sel3d2.Visible:=true;
    end else begin
        sel3d.Visible:=false;
        sel3d2.Visible:=false;
    end;
    end;
end;

procedure TForm13.FormShow(Sender: TObject);
var i:integer;
begin
    timer1.Enabled:=true;
    for i:=0 to 255 do Keys[i]:=false;
    if (selected > -1) and form17.chkFollow.Checked then
    begin
      if sType = 1 then
      begin
        ppx := midpz[Floor[sfloor].Monster[selected].map_section].x;
        ppy := Floor[sfloor].Monster[selected].Pos_Z + 15;
        ppz := -midpz[Floor[sfloor].Monster[selected].map_section].y;
        vr := 0;
        vz := 0;
        myscreen.SetView(ppx, ppy, ppz, vr, vz);
      end;
      if sType = 2 then
      begin
        ppx := midpz[Floor[sfloor].Obj[selected].map_section].x;
        ppy := Floor[sfloor].Obj[selected].Pos_Z + 15;
        ppz := -midpz[Floor[sfloor].Obj[selected].map_section].y;
        vr := 0;
        vz := 0;
        myscreen.SetView(ppx, ppy, ppz, vr, vz);
      end;
    end;
end;

procedure TForm13.popupWavePopup(Sender: TObject);
var
  tm: TMenuItem;
  x, y: integer;
begin
  popupWave.Items.Clear;
  if previewstate = 0 then
  begin
    tm := TMenuItem.Create(form1.EnemyWave1);
    tm.Caption := GetLanguageString(83);
    tm.RadioItem := true;
    if showwave = -1 then tm.Checked := true;
    tm.tag := -1;
    tm.OnClick := form1.EnemyWave1Click;
    popupWave.Items.Add(tm);
    y := CountNumberOfWave;
    for x := 0 to y do
    begin
      tm := TMenuItem.Create(form1.EnemyWave1);
      tm.Caption := GetLanguageString(84) + inttostr(x);
      tm.RadioItem := true;
      if x = showwave then tm.Checked := true;
      tm.tag := x;
      tm.OnClick := form1.EnemyWave1Click;
      if (x > 0) and (x mod 20 = 19) then
        tm.Break := mbBarBreak;
      popupWave.Items.Add(tm);
    end;
    tm := TMenuItem.Create(form1.EnemyWave1);
    tm.Caption := GetLanguageString(514);
    tm.RadioItem := true;
    if showwave = 65536 then tm.Checked := true;
    tm.tag := 65536;
    tm.OnClick := form1.EnemyWave1Click;
    if (x > 0) and (x mod 20 = 19) then
        tm.Break := mbBarBreak;
    popupWave.Items.Add(tm);
  end;
end;

procedure TForm13.popupGroupPopup(Sender: TObject);
var
  tm: TMenuItem;
  x, y: integer;
begin
  popupGroup.Items.Clear;
  tm := TMenuItem.Create(form1.Itemsgroupe1);
  tm.Caption := GetLanguageString(83);
  tm.RadioItem := true;
  if showgrp = -1 then tm.Checked := true;
  tm.tag := -1;
  tm.OnClick := form1.Itemsgroupe1Click;
  popupGroup.Items.Add(tm);
  y := CountNumberOfGrp;
  for x := 0 to y do
  begin
    tm := TMenuItem.Create(form1.Itemsgroupe1);
    tm.Caption := GetLanguageString(85) + inttostr(x);
    tm.RadioItem := true;
    if x = showgrp then tm.Checked := true;
    tm.tag := x;
    tm.OnClick := form1.Itemsgroupe1Click;
    if (x > 0) and (x mod 20 = 19) then
      tm.Break := mbBarBreak;
    popupGroup.Items.Add(tm);
  end;
  tm := TMenuItem.Create(form1.Itemsgroupe1);
  tm.Caption := GetLanguageString(514);
  tm.RadioItem := true;
  if showgrp = 65536 then tm.Checked := true;
  tm.tag := 65536;
  tm.OnClick := form1.Itemsgroupe1Click;
  if (x > 0) and (x mod 20 = 19) then
        tm.Break := mbBarBreak;
  popupGroup.Items.Add(tm);
end;

procedure TForm13.FormHide(Sender: TObject);
begin
   timer1.Enabled:=false;
   
end;

procedure TForm13.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);

var v,rayOrigin,rayDir:TD3DXVECTOR3;
    m,n:TD3DXMATRIX;
    i,z,c,d,j,k,closest:integer;
    rt:dword;
    px2,px3,py2,py3:single;
    di,diff,diffx,diffz,diffh,diffmin,ppx2,ppy2,pz2:double;
begin
    if (shift = [ssleft]) and (not rtx) and (not rty) and (not rtz) then begin
        vz:=vz+((lmy-y)/120);
        if vz > 1.5 then vz:=1.5;
        if vz < -1.5 then vz:=-1.5;
        vr:=vr+((lmx-x)/120);
        lmx:=x;
        lmy:=y;
        myscreen.SetView(ppx,ppy,ppz,vr,vz);
    end;


    //move the monster

    if inclick then
    if  shift = [ssCtrl,ssleft] then begin
        isedited:=true;
        if undocount = 0 then form1.SetUndow;
        v.x :=  ( ( ( 2.0 * X ) / Width ) - 1 ) / (2);
        v.y := -( ( ( 2.0 * Y ) / Height ) - 1) / (2);
        v.z :=  1.0;

        D3DXMatrixInverse( m, nil, myscreen.matview);
        // This is the direction of the ray from the mouse cursor into the scene...
        rayDir.x := v.x*m._11 + v.y*m._21 + v.z*m._31;
        rayDir.y := v.x*m._12 + v.y*m._22 + v.z*m._32;
        rayDir.z := (v.x*m._13 + v.y*m._23 + v.z*m._33);

        // This is the position of rayDir's head.
        rayOrigin.x := m._41;
        rayOrigin.y := m._42;
        rayOrigin.z := m._43;
        c:=0;
        while ((rayOrigin.y < inclickz-0.7) or (rayOrigin.y > inclickz+0.7)) and (c < 500) do begin
            rayOrigin.x := rayOrigin.x + rayDir.x;
            rayOrigin.y := rayOrigin.y + rayDir.y;
            rayOrigin.z := rayOrigin.z + rayDir.z;
            inc(c);
        end;

        // Find closest section
        if autoadjustsect or autoadjustY then
        begin
          d := -1;
          di := $FFFFFF;
          for z := 0 to 25566 do
          if MidPU[z] then
          begin
            // Find the distance
            ppx2 := rayOrigin.x - (MidP[z].x * zoom);
            ppy2 := -rayOrigin.z - (MidP[z].y * zoom);
            ppx2 := (ppx2 * ppx2) + (ppy2 * ppy2);
            // Save if nearest
            if di > ppx2 then
            begin
            di := ppx2;
            d := z;
            end;
          end;
        end;

        snapvalue := FSnapOptions.seSnapTolerance.Value;
        distancelimit := FSnapOptions.seDistanceLimit.Value;

        diffmin := Double.MaxValue;
        closest := -1;

        if (stype = 1) and (selected > -1) then begin
            mymonst[selected].PositionX:=rayOrigin.x;
            mymonst[selected].PositionZ:=rayOrigin.z;

            rt:=rev[Floor[sfloor].Monster[selected].map_section];
            px2:=rayOrigin.x-midpz[Floor[sfloor].Monster[selected].map_section].x;
            py2:=(-rayOrigin.z)-midpz[Floor[sfloor].Monster[selected].map_section].y;
            px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
            py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
            floor[sfloor].Monster[selected].Pos_X:=px3;
            floor[sfloor].Monster[selected].Pos_Y:=py3;

            if autoadjustsect then
              floor[sfloor].Monster[selected].map_section := d;
            if autoadjustY then
            begin
              pz2 := form1.YFromBBRELFile(rayOrigin.x, -rayOrigin.z);
              pz2 := pz2 - miz[d];
              floor[sfloor].Monster[selected].Pos_Z := pz2;
            end;
            if autoadjustsect or autoadjustY then
              GenerateMonsterName(Floor[sfloor].Monster[selected],selected,2);

            if (FSnapOptions.chkSnap.Checked) or (Keys[Ord('S')]) then
            begin
              // 3D X axis snap for monsters
              for j := 0 to Floor[sfloor].MonsterCount - 1 do
              begin
                for i := 0 to snapvalue do
                begin
                    if (Floor[sfloor].Monster[j].map_section = Floor[sfloor].Monster[selected].map_section) and
                    ((Floor[sfloor].Monster[j].Unknow5 = showwave) or (showwave = -1)) then
                    begin
                      if ((round(Floor[sfloor].Monster[j].Pos_X + i)) = round(px3))
                      or ((round(Floor[sfloor].Monster[j].Pos_X - i)) = round(px3)) then
                      begin
                        // Save closest snap target
                        diff := abs(Floor[sfloor].Monster[selected].Pos_Y - Floor[sfloor].Monster[j].Pos_Y);
                        if ((diff <= distancelimit) and (FSnapOptions.chkDistancelimit.Checked))
                        or (not FSnapOptions.chkDistancelimit.Checked) then
                        begin
                          floor[sfloor].Monster[selected].Pos_X := floor[sfloor].Monster[j].Pos_X;
                          mymonst[selected].PositionX := mymonst[j].PositionX;
                          // Match monster's rotations if enabled
                          if (FSnapOptions.chkSnapRotate.Checked) then
                            floor[sfloor].Monster[selected].Direction := floor[sfloor].Monster[j].Direction;
                          // Match monster's Y value if enabled
                          if (FSnapOptions.chkSnapYValue.Checked) then
                          begin
                            floor[sfloor].Monster[selected].Pos_Z := floor[sfloor].Monster[j].Pos_Z;
                            mymonst[selected].PositionY := mymonst[j].PositionY;
                          end;
                          if (diff < diffmin) and (j <> selected) then
                          begin
                            diffmin := diff;
                            if j <> selected then
                              closest := j;
                          end;
                        end;
                      end;
                    end;
                end;
              end;
              if closest > -1 then
                AdjustDistanceY(closest);

              diffmin := Double.MaxValue;
              closest := -1;

              // 3D Z axis snap for monsters
              for j := 0 to Floor[sfloor].MonsterCount - 1 do
              begin
                for i := 0 to snapvalue do
                begin
                    if (Floor[sfloor].Monster[j].map_section = Floor[sfloor].Monster[selected].map_section) and
                    ((Floor[sfloor].Monster[j].Unknow5 = showwave) or (showwave = -1)) then
                    begin
                      if ((round(Floor[sfloor].Monster[j].Pos_Y + i)) = round(py3))
                      or ((round(Floor[sfloor].Monster[j].Pos_Y - i)) = round(py3)) then
                      begin
                        // Save closest snap target
                        diff := abs(Floor[sfloor].Monster[selected].Pos_X - Floor[sfloor].Monster[j].Pos_X);
                        if ((diff <= distancelimit) and (FSnapOptions.chkDistancelimit.Checked))
                        or (not FSnapOptions.chkDistancelimit.Checked) then
                        begin
                          floor[sfloor].Monster[selected].Pos_Y := floor[sfloor].Monster[j].Pos_Y;
                          mymonst[selected].PositionZ := mymonst[j].PositionZ;
                          if (FSnapOptions.chkSnapRotate.Checked) then
                            floor[sfloor].Monster[selected].Direction := floor[sfloor].Monster[j].Direction;
                          if (FSnapOptions.chkSnapYValue.Checked) then
                          begin
                            floor[sfloor].Monster[selected].Pos_Z := floor[sfloor].Monster[j].Pos_Z;
                            mymonst[selected].PositionY := mymonst[j].PositionY;
                          end;
                          if (diff < diffmin) and (j <> selected) then
                          begin
                            diffmin := diff;
                            if j <> selected then
                              closest := j;
                          end;
                        end;
                      end;
                    end;
                end;
              end;
              if closest > -1 then
                AdjustDistanceX(closest);

              diffmin := Double.MaxValue;
              closest := -1;

              // 3D Y axis snap for monsters
              for j := 0 to Floor[sfloor].MonsterCount - 1 do
              begin
                if (Floor[sfloor].Monster[j].map_section = Floor[sfloor].Monster[selected].map_section) and
                ((Floor[sfloor].Monster[j].Unknow5 = showwave) or (showwave = -1)) then
                begin
                  diffx := Floor[sfloor].Monster[selected].Pos_X - Floor[sfloor].Monster[j].Pos_X;
                  diffz := Floor[sfloor].Monster[selected].Pos_Y - Floor[sfloor].Monster[j].Pos_Y;
                  diffh := sqrt(diffx * diffx + diffz * diffz);
                  if diffh <= snapvalue then
                  begin
                    // Save closest snap target
                    diff := abs(Floor[sfloor].Monster[selected].Pos_Z - Floor[sfloor].Monster[j].Pos_Z);
                    if ((diff <= distancelimit) and (FSnapOptions.chkDistancelimit.Checked))
                    or (not FSnapOptions.chkDistancelimit.Checked) then
                    begin
                      floor[sfloor].Monster[selected].Pos_X := floor[sfloor].Monster[j].Pos_X;
                      floor[sfloor].Monster[selected].Pos_Y := floor[sfloor].Monster[j].Pos_Y;
                      mymonst[selected].PositionX := mymonst[j].PositionX;
                      mymonst[selected].PositionZ := mymonst[j].PositionZ;
                      if (FSnapOptions.chkSnapRotate.Checked) then
                        floor[sfloor].Monster[selected].Direction := floor[sfloor].Monster[j].Direction;
                      if (diff < diffmin) and (j <> selected) then
                      begin
                        diffmin := diff;
                        if j <> selected then
                          closest := j;
                      end;
                    end;
                  end;
                end;
              end;
              if closest > -1 then
                AdjustDistanceZ(closest);
              GenerateMonsterName(Floor[sfloor].Monster[selected],selected,2);
            end;

            sel3d.SetCoordinate(mymonst[selected].PositionX ,
                floor[sfloor].Monster[selected].Pos_z+miz[Floor[sfloor].Monster[selected].map_section]+0.5,
                mymonst[selected].Positionz );
        end;
        if (stype = 2) and (selected > -1) then begin
            MyObj[selected].PositionX:=rayOrigin.x;
            MyObj[selected].PositionZ:=rayOrigin.z;
            
            rt:=rev[Floor[sfloor].obj[selected].map_section];
            px2:=rayOrigin.x-midpz[Floor[sfloor].Obj[selected].map_section].x;
            py2:=(-rayOrigin.z)-midpz[Floor[sfloor].Obj[selected].map_section].y;
            px3 := cos(rt/10430.37835)*px2 - sin(rt/10430.37835)*py2;
            py3 := sin(rt/10430.37835)*px2 + cos(rt/10430.37835)*py2;
            floor[sfloor].Obj[selected].Pos_X:=px3;
            floor[sfloor].Obj[selected].Pos_Y:=py3;

            if autoadjustsect then
              floor[sfloor].Obj[selected].map_section := d;
            if autoadjustY then
            begin
              pz2 := form1.YFromBBRELFile(rayOrigin.x, -rayOrigin.z);
              pz2 := pz2 - miz[d];
              floor[sfloor].Obj[selected].Pos_Z := pz2;
            end;
            if autoadjustsect or autoadjustY then
            begin
              myobj[selected].Free;
              Generateobj(floor[sfloor].obj[selected],selected);
            end;

            if (FSnapOptions.chkSnap.Checked) or (Keys[Ord('S')]) then
            begin
              // 3D X axis snap for objects
              for j := 0 to Floor[sfloor].ObjCount - 1 do
              begin
                for i := 0 to snapvalue do
                begin
                    if (Floor[sfloor].Obj[j].map_section = Floor[sfloor].Obj[selected].map_section) and
                    ((Floor[sfloor].Obj[j].grp = showgrp) or (showgrp = -1)) then
                    begin
                      if ((round(Floor[sfloor].Obj[j].Pos_X + i)) = round(px3))
                      or ((round(Floor[sfloor].Obj[j].Pos_X - i)) = round(px3)) then
                      begin
                        // Save closest snap target
                        diff := abs(Floor[sfloor].Obj[selected].Pos_Y - Floor[sfloor].Obj[j].Pos_Y);
                        if ((diff <= distancelimit) and (FSnapOptions.chkDistancelimit.Checked))
                        or (not FSnapOptions.chkDistancelimit.Checked) then
                        begin
                          floor[sfloor].Obj[selected].Pos_X := floor[sfloor].Obj[j].Pos_X;
                          myobj[selected].PositionX := myobj[j].PositionX;
                          // Match object's rotations if enabled
                          if (FSnapOptions.chkSnapRotate.Checked) then
                          begin
                            for k := 0 to RotateCount - 1 do
                              if floor[sfloor].Obj[selected].Skin = RotateItm[k] then
                                break;
                            if k >= RotateCount then
                              floor[sfloor].Obj[selected].unknow6 := floor[sfloor].Obj[j].unknow6;
                            if (k < RotateCount) and (floor[sfloor].Obj[selected].Skin = floor[sfloor].Obj[j].Skin) then
                            begin
                              floor[sfloor].Obj[selected].unknow5 := floor[sfloor].Obj[j].unknow5;
                              floor[sfloor].Obj[selected].unknow6 := floor[sfloor].Obj[j].unknow6;
                              floor[sfloor].Obj[selected].unknow7 := floor[sfloor].Obj[j].unknow7;
                            end;
                          end;
                          // Match object's Y value if enabled
                          if (FSnapOptions.chkSnapYValue.Checked) then
                          begin
                            floor[sfloor].Obj[selected].Pos_Z := floor[sfloor].Obj[j].Pos_Z;
                            myobj[selected].PositionY := myobj[j].PositionY;
                          end;
                          if (diff < diffmin) and (j <> selected) then
                          begin
                            diffmin := diff;
                            if j <> selected then
                              closest := j;
                          end;
                        end;
                      end;
                    end;
                end;
              end;
              if closest > -1 then
                AdjustDistanceY(closest);

              diffmin := Double.MaxValue;
              closest := -1;

              // 3D Z axis snap for objects
              for j := 0 to Floor[sfloor].ObjCount - 1 do
              begin
                for i := 0 to snapvalue do
                begin
                    if (Floor[sfloor].Obj[j].map_section = Floor[sfloor].Obj[selected].map_section) and
                    ((Floor[sfloor].Obj[j].grp = showgrp) or (showgrp = -1)) then
                    begin
                      if ((round(Floor[sfloor].Obj[j].Pos_Y + i)) = round(py3))
                      or ((round(Floor[sfloor].Obj[j].Pos_Y - i)) = round(py3)) then
                      begin
                        // Save closest snap target
                        diff := abs(Floor[sfloor].Obj[selected].Pos_X - Floor[sfloor].Obj[j].Pos_X);
                        if ((diff <= distancelimit) and (FSnapOptions.chkDistancelimit.Checked))
                        or (not FSnapOptions.chkDistancelimit.Checked) then
                        begin
                          floor[sfloor].Obj[selected].Pos_Y := floor[sfloor].Obj[j].Pos_Y;
                          myobj[selected].PositionZ := myobj[j].PositionZ;
                          if (FSnapOptions.chkSnapRotate.Checked) then
                          begin
                            for k := 0 to RotateCount - 1 do
                              if floor[sfloor].Obj[selected].Skin = RotateItm[k] then
                                break;
                            if k >= RotateCount then
                              floor[sfloor].Obj[selected].unknow6 := floor[sfloor].Obj[j].unknow6;
                            if (k < RotateCount) and (floor[sfloor].Obj[selected].Skin = floor[sfloor].Obj[j].Skin) then
                            begin
                              floor[sfloor].Obj[selected].unknow5 := floor[sfloor].Obj[j].unknow5;
                              floor[sfloor].Obj[selected].unknow6 := floor[sfloor].Obj[j].unknow6;
                              floor[sfloor].Obj[selected].unknow7 := floor[sfloor].Obj[j].unknow7;
                            end;
                          end;
                          if (FSnapOptions.chkSnapYValue.Checked) then
                          begin
                            floor[sfloor].Obj[selected].Pos_Z := floor[sfloor].Obj[j].Pos_Z;
                            myobj[selected].PositionY := myobj[j].PositionY;
                          end;
                          if (diff < diffmin) and (j <> selected) then
                          begin
                            diffmin := diff;
                            if j <> selected then
                              closest := j;
                          end;
                        end;
                      end;
                    end;
                end;
              end;
              if closest > -1 then
                AdjustDistanceX(closest);

              diffmin := Double.MaxValue;
              closest := -1;

              // 3D Y axis snap for objects
              for j := 0 to Floor[sfloor].ObjCount - 1 do
              begin
                if (Floor[sfloor].Obj[j].map_section = Floor[sfloor].Obj[selected].map_section) and
                ((Floor[sfloor].Obj[j].grp = showgrp) or (showgrp = -1)) then
                begin
                  diffx := Floor[sfloor].Obj[selected].Pos_X - Floor[sfloor].Obj[j].Pos_X;
                  diffz := Floor[sfloor].Obj[selected].Pos_Y - Floor[sfloor].Obj[j].Pos_Y;
                  diffh := sqrt(diffx * diffx + diffz * diffz);
                  if diffh <= snapvalue then
                  begin
                    // Save closest snap target
                    diff := abs(Floor[sfloor].Obj[selected].Pos_Z - Floor[sfloor].Obj[j].Pos_Z);
                    if ((diff <= distancelimit) and (FSnapOptions.chkDistancelimit.Checked))
                    or (not FSnapOptions.chkDistancelimit.Checked) then
                    begin
                      floor[sfloor].Obj[selected].Pos_X := floor[sfloor].Obj[j].Pos_X;
                      floor[sfloor].Obj[selected].Pos_Y := floor[sfloor].Obj[j].Pos_Y;
                      myobj[selected].PositionX := myobj[j].PositionX;
                      myobj[selected].PositionZ := myobj[j].PositionZ;
                      if (FSnapOptions.chkSnapRotate.Checked) then
                      begin
                        for k := 0 to RotateCount - 1 do
                          if floor[sfloor].Obj[selected].Skin = RotateItm[k] then
                            break;
                        if k >= RotateCount then
                          floor[sfloor].Obj[selected].unknow6 := floor[sfloor].Obj[j].unknow6;
                        if (k < RotateCount) and (floor[sfloor].Obj[selected].Skin = floor[sfloor].Obj[j].Skin) then
                        begin
                          floor[sfloor].Obj[selected].unknow5 := floor[sfloor].Obj[j].unknow5;
                          floor[sfloor].Obj[selected].unknow6 := floor[sfloor].Obj[j].unknow6;
                          floor[sfloor].Obj[selected].unknow7 := floor[sfloor].Obj[j].unknow7;
                        end;
                      end;
                      if (diff < diffmin) and (j <> selected) then
                      begin
                        diffmin := diff;
                        if j <> selected then
                          closest := j;
                      end;
                    end;
                  end;
                end;
              end;
              if closest > -1 then
                AdjustDistanceZ(closest);
              myobj[selected].Free;
              Generateobj(floor[sfloor].obj[selected],selected);
            end;

            sel3d.SetCoordinate(MyObj[selected].PositionX ,
                floor[sfloor].obj[selected].Pos_Z+miz[Floor[sfloor].obj[selected].Map_Section]+0.5,
                MyObj[selected].Positionz );
        end;
    end;

    //Z move the player
    
    if inclick then
    if  shift = [ssShift,ssleft] then begin
    isedited:=true;
    if undocount = 0 then form1.SetUndow;
        v.x :=  ( ( ( 2.0 * X ) / Width ) - 1 ) / (2);
        v.y := -( ( ( 2.0 * Y ) / Height ) - 1) / (2);
        v.z :=  1.0;

        D3DXMatrixInverse( m, nil, myscreen.matview);
        // This is the direction of the ray from the mouse cursor into the scene...
        rayDir.x := v.x*m._11 + v.y*m._21 + v.z*m._31;
        rayDir.y := v.x*m._12 + v.y*m._22 + v.z*m._32;
        rayDir.z := (v.x*m._13 + v.y*m._23 + v.z*m._33);

        // This is the position of rayDir's head.
        rayOrigin.x := m._41;
        rayOrigin.y := m._42;
        rayOrigin.z := m._43;

        c:=0;
        while ((rayOrigin.z < inclicky-0.7) or (rayOrigin.z > inclicky+0.7))
            and ((rayOrigin.x < inclickx-0.7) or (rayOrigin.x > inclickx+0.7)) and (c<500) do begin
            rayOrigin.x := rayOrigin.x + rayDir.x;
            rayOrigin.y := rayOrigin.y + rayDir.y;
            rayOrigin.z := rayOrigin.z + rayDir.z;
            inc(c);
        end;
        if stype = 1 then begin
            mymonst[selected].PositionY:=rayOrigin.Y-inclickz+mymonstz[selected];
            floor[sfloor].Monster[selected].Pos_Z:=(rayOrigin.Y-inclickz)-miz[Floor[sfloor].Monster[selected].map_section];


            sel3d.SetCoordinate(mymonst[selected].PositionX ,
                floor[sfloor].Monster[selected].Pos_z+miz[Floor[sfloor].Monster[selected].map_section]+0.5,
                mymonst[selected].Positionz );

        end;
        if stype = 2 then begin
            MyObj[selected].PositionY:=rayOrigin.y-inclickz;
            floor[sfloor].Obj[selected].Pos_Z:=(rayOrigin.Y-inclickz)-miz[Floor[sfloor].Obj[selected].map_section];

            sel3d.SetCoordinate(MyObj[selected].PositionX ,
                floor[sfloor].obj[selected].Pos_Z+miz[Floor[sfloor].obj[selected].Map_Section]+0.5,
                MyObj[selected].Positionz );
        end;

    end;

    if inclick then
    if  (shift = [ssright,ssleft]) or ((shift = [ssleft]) and rty) then begin
    isedited:=true;
    if undocount = 0 then form1.SetUndow;
         i:=(lmx-x)*200;
         if stype = 1 then begin
         dec(floor[sfloor].Monster[selected].Direction , i);
         GenerateMonsterName(Floor[sfloor].Monster[selected],selected,2);
         end;
         if stype = 2 then begin
             dec(floor[sfloor].obj[selected].unknow6 , i);
             myobj[selected].Free;
             Generateobj(floor[sfloor].obj[selected],selected);
         end;
    end;

    if inclick then
    if ((shift = [ssleft]) and rtx) then begin
    isedited:=true;
    if undocount = 0 then form1.SetUndow;
         i:=(lmx-x)*200;
         if stype = 2 then begin
             dec(floor[sfloor].obj[selected].unknow5 , i);
             myobj[selected].Free;
             Generateobj(floor[sfloor].obj[selected],selected);
         end;
    end;

    if inclick then
    if ((shift = [ssleft]) and rtz) then begin
    isedited:=true;
    if undocount = 0 then form1.SetUndow;
         i:=(lmx-x)*200;
         if stype = 2 then begin
             dec(floor[sfloor].obj[selected].unknow7 , i);
             myobj[selected].Free;
             Generateobj(floor[sfloor].obj[selected],selected);
         end;
    end;

    lmx:=x;
    lmy:=y;
end;

procedure TForm13.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var v,rayOrigin,rayDir:TD3DXVECTOR3;
    m,n:TD3DXMATRIX;
    i,c,u1,u2,d1,d2:integer;
begin
    inedit := false;
    lmx:=x;
    lmy:=y;

    v.x :=  (( ( ( 2.0 * X ) / clientWidth ) - 1 ) / (2))*1.1;
    v.y := (-( ( ( 2.0 * Y ) / clientHeight ) - 1) / (2))/1.4;
    v.z :=  1.0;

    D3DXMatrixInverse( m, nil, myscreen.matview);
    // This is the direction of the ray from the mouse cursor into the scene...
    rayDir.x := ((v.x*m._11) + (v.y*m._21) + (v.z*m._31));
    rayDir.y := ((v.x*m._12) + (v.y*m._22) + (v.z*m._32));
    rayDir.z := ((v.x*m._13) + (v.y*m._23) + (v.z*m._33));

    // This is the position of rayDir's head.
    rayOrigin.x := m._41;
    rayOrigin.y := m._42;
    rayOrigin.z := m._43;

    //here goes trought all the monster to select
    for c:=0 to 400 do begin
        rayOrigin.x := rayOrigin.x + (rayDir.x);
        rayOrigin.y := rayOrigin.y + (rayDir.y);
        rayOrigin.z := rayOrigin.z + (rayDir.z);
        for i:=0 to floor[sfloor].MonsterCount-1 do
            if mymonst[i].Visible then begin
            d1:=mymonst[i].SizeDownX;
            u1:=mymonst[i].SizeUpX;
            d2:=mymonst[i].SizeDownz;
            u2:=mymonst[i].SizeUpz;
            if d1 < -13 then d1:=-13 ;
            if d2 < -13 then d2:=-13 ;
            if u1 > 13 then u1:=13 ;
            if u2 > 13 then u2:=13 ;
            if (rayOrigin.x >= mymonst[i].PositionX+d1) and (rayOrigin.x<=mymonst[i].PositionX+u1)
                and (rayOrigin.y >= mymonst[i].Positiony+mymonst[i].SizeDownY)
                and (rayOrigin.y <= mymonst[i].Positiony+mymonst[i].SizeUpY)
                and (rayOrigin.z >= mymonst[i].PositionZ+d2) and (rayOrigin.z<=mymonst[i].PositionZ+u2) then begin
                    if placelookat then
                    begin
                      form1.LookAt2D(selected, sType, form1.SectionToMouseX(i,1), form1.SectionToMouseY(i,1));
                      exit;
                    end;
                    selected:=i;
                    if undocount > 0 then
                      form1.SetUndow;
                    inclickz:=rayOrigin.y;
                    inclickx:=rayOrigin.x;
                    inclicky:=rayOrigin.z;
                    inclick:=true;
                    stype:=1;
                    form1.ListBox1.ItemIndex:=i;
                    form1.DBGrid1.Options := form1.DBGrid1.Options - [dgIndicator];
                    form1.DBGrid2.Options := form1.DBGrid2.Options - [dgIndicator];
                    form1.PageControl1.ActivePage := form1.TabSheet1;
                    form1.LoadFloorGrids;
                    form1.drawmap;
                    if (gettickcount() - lastclick <= 300) and not (ssRight in Shift)
                    and not (ssCtrl in Shift) and not (ssShift in Shift)
                    and not rtx and not rty and not rtz then
                    begin
                      form1.Button2Click(nil);
                      inedit := true;
                    end;
                    break;
                end;
        end;
        if i < floor[sfloor].MonsterCount then break;

        for i:=0 to floor[sfloor].ObjCount-1 do
        if MyObj[i].visible then begin
            if (rayOrigin.x >= MyObj[i].PositionX+MyObj[i].SizeDownX) and (rayOrigin.x<=MyObj[i].PositionX+MyObj[i].SizeUpX)
                and (rayOrigin.y >= MyObj[i].Positiony+MyObj[i].SizeDownY)
                and (rayOrigin.y <= MyObj[i].Positiony+MyObj[i].SizeUpY)
                and (rayOrigin.z >= MyObj[i].PositionZ+MyObj[i].SizeDownZ) and (rayOrigin.z<=MyObj[i].PositionZ+MyObj[i].SizeUpZ) then begin
                    if placelookat then
                    begin
                      form1.LookAt2D(selected, sType, form1.SectionToMouseX(i,2), form1.SectionToMouseY(i,2));
                      exit;
                    end;
                    selected:=i;
                    if undocount > 0 then
                      form1.SetUndow;
                    inclickz:=rayOrigin.y;
                    inclickx:=rayOrigin.x;
                    inclicky:=rayOrigin.z;
                    inclick:=true;
                    stype:=2;
                    form1.ListBox2.ItemIndex:=i;
                    form1.DBGrid1.Options := form1.DBGrid1.Options - [dgIndicator];
                    form1.DBGrid2.Options := form1.DBGrid2.Options - [dgIndicator];
                    form1.PageControl1.ActivePage := form1.TabSheet2;
                    form1.LoadFloorGrids;
                    form1.drawmap;
                    if (gettickcount() - lastclick <= 300) and not (ssRight in Shift)
                    and not (ssCtrl in Shift) and not (ssShift in Shift)
                    and not rtx and not rty and not rtz then
                    begin
                      form1.Button2Click(nil);
                      inedit := true;
                    end;
                    break;
                end;
        end;
        if i < floor[sfloor].ObjCount then break;
        
    end;
    if not (ssRight in Shift) and not (ssCtrl in Shift) and not (ssShift in Shift)
    and not rtx and not rty and not rtz
    and not inedit then
      lastclick := gettickcount();
end;


{
// Map your mouse screen-coordinates to normalized coordinates in (-1,...,1). Save them in a 3-vector. Assign the Z-coordinate to 1.
D3DXVECTOR3 v;
v.x =  ( ( ( 2.0f * mouse_X ) / ScreenWidth ) - 1 ) / (2);
v.y = -( ( ( 2.0f * mouse_Y ) / ScreenHeight ) - 1) / (2);
v.z =  1.0f;

// Find the inverse of the view matrix and save it in 'm'. Also, define two new vectors to hold the ray origin and direction...
D3DXMATRIX m;
D3DXVECTOR3 rayOrigin,rayDir;
D3DXMatrixInverse( &m, NULL, &(ViewMatrix));

// This is the direction of the ray from the mouse cursor into the scene...
rayDir.x = v.x*m._11 + v.y*m._21 + v.z*m._31;
rayDir.y = v.x*m._12 + v.y*m._22 + v.z*m._32;
rayDir.z = v.x*m._13 + v.y*m._23 + v.z*m._33;

// This is the position of rayDir's head.
rayOrigin.x = m._41;
rayOrigin.y = m._42;
rayOrigin.z = m._43;
                        }

procedure TForm13.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if inclick then form1.DrawMap;
    inclick:=false;
end;

procedure TForm13.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  Reg: TRegistry;
begin
  if (WheelDelta > 0) and (movespeed < 30) then
    movespeed := movespeed + 3
  else if (WheelDelta < 0) and (movespeed > 3)  then
    movespeed := movespeed - 3;

  // Save movement value to the registry
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteInteger('3DMoveSpeed', movespeed);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

procedure TForm13.FormActivate(Sender: TObject);
begin
  form1.DBGrid1.Options := form1.DBGrid1.Options - [dgMultiSelect];
  form1.DBGrid2.Options := form1.DBGrid2.Options - [dgMultiSelect];
end;

procedure TForm13.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    timer1.Enabled:=false;
    have3d:=false;
    if form13.BorderStyle = bsNone then
    begin
      Form1.WindowState := wsNormal;
      Form1.BringToFront;
    end;
end;

procedure TForm13.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key < 256 then
    Keys[key]:=true;
  if (key = 37) and (previewstate > 0) then
  begin
    key := 0;
    previewpaused := true;
    if previewstate > 1 then
    begin
      Dec(previewstate);
      DrawPreviewState(previewstate);
    end;
  end;
  if (key = 39) and (previewstate > 0) then
  begin
    key := 0;
    previewpaused := true;
    if previewstate < Floor[form1.CheckListBox1.ItemIndex].Unknow[8] then
    begin
      Inc(previewstate);
      DrawPreviewState(previewstate);
    end;
  end;
  if (key = 32) and (previewstate > 0) then
  begin
    key := 0;
    previewpaused := not previewpaused;
    form1.DrawMap;
  end;
end;

procedure TForm13.FormKeyPress(Sender: TObject; var Key: Char);
var
  Reg: TRegistry;
  rtinc: integer;
begin
    // Change and save auto-adjust settings to the registry
    if key = 's' then
    begin
        autoadjustsect := not autoadjustsect;
        Reg := TRegistry.Create;
        try
          Reg.RootKey := HKEY_CURRENT_USER;
          if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
          begin
            Reg.WriteBool('3DAutoAdjustSect', autoadjustsect);
            Reg.CloseKey;
          end;
        finally
          Reg.Free;
        end;
    end;
    if key = 'y' then
    begin
        autoadjustY := not autoadjustY;
        Reg := TRegistry.Create;
        try
          Reg.RootKey := HKEY_CURRENT_USER;
          if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
          begin
            Reg.WriteBool('3DAutoAdjustY', autoadjustY);
            Reg.CloseKey;
          end;
        finally
          Reg.Free;
        end;
    end;

    if key = 'd' then
    begin
     dta:=dta + 1;
     if dta = 3 then dta := 0;
     // Save data format setting to the registry
     Reg := TRegistry.Create;
     try
         Reg.RootKey := HKEY_CURRENT_USER;
         if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
         begin
           Reg.WriteInteger('DataDisplay', dta);
           Reg.CloseKey;
         end;
     finally
       Reg.Free;
     end;
    end;

    if key = 'f' then fog:=fog xor 1;

    // Auto-rotate monster/object clockwise 22.5 degrees
    if (key = 'l') and (selected > -1) then
    begin
      if sType = 1 then
        rtinc := ClosestRot(Floor[sFloor].Monster[selected].Direction);
      if sType = 2 then
        rtinc := ClosestRot(Floor[sFloor].Obj[selected].unknow6);

      // Decrement for next rotation
      if rtinc > 0 then
        rtinc := rtinc - 4096
      else rtinc := 61440;
      AutoRotate(rtinc);
    end;

    // Auto-rotate monster/object counter-clockwise 22.5 degrees
    if (key = 'r') and (selected > -1) then
    begin
      if sType = 1 then
        rtinc := ClosestRot(Floor[sFloor].Monster[selected].Direction);
      if sType = 2 then
        rtinc := ClosestRot(Floor[sFloor].Obj[selected].unknow6);

      // Increment for next rotation
      if (rtinc >= -65536) and (rtinc <= 61440) then
        rtinc := rtinc + 4096
      else rtinc := 0;
      AutoRotate(rtinc);
    end;

    if key = 'w' then
    begin
      // Cancel movement before opening the menu
      Keys[Ord('Q')] := false;
      Keys[Ord('A')] := false;
      popupWave.Popup(mouse.CursorPos.x, mouse.CursorPos.y);
    end;
    if key = 'g' then
    begin
      Keys[Ord('Q')] := false;
      Keys[Ord('A')] := false;
      popupGroup.Popup(mouse.CursorPos.x, mouse.CursorPos.y);
    end;
end;

procedure TForm13.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key < 256 then
    Keys[key]:=false;
end;

end.
