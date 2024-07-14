unit PikaPackage;

interface
    uses sysutils, types, Classes;

    const crc32tab:array[0..255] of longint=(
        $00000000, $77073096, $ee0e612c, $990951ba, $076dc419, $706af48f,
        $e963a535, $9e6495a3, $0edb8832, $79dcb8a4, $e0d5e91e, $97d2d988,
        $09b64c2b, $7eb17cbd, $e7b82d07, $90bf1d91, $1db71064, $6ab020f2,
        $f3b97148, $84be41de, $1adad47d, $6ddde4eb, $f4d4b551, $83d385c7,
        $136c9856, $646ba8c0, $fd62f97a, $8a65c9ec, $14015c4f, $63066cd9,
        $fa0f3d63, $8d080df5, $3b6e20c8, $4c69105e, $d56041e4, $a2677172,
        $3c03e4d1, $4b04d447, $d20d85fd, $a50ab56b, $35b5a8fa, $42b2986c,
        $dbbbc9d6, $acbcf940, $32d86ce3, $45df5c75, $dcd60dcf, $abd13d59,
        $26d930ac, $51de003a, $c8d75180, $bfd06116, $21b4f4b5, $56b3c423,
        $cfba9599, $b8bda50f, $2802b89e, $5f058808, $c60cd9b2, $b10be924,
        $2f6f7c87, $58684c11, $c1611dab, $b6662d3d, $76dc4190, $01db7106,
        $98d220bc, $efd5102a, $71b18589, $06b6b51f, $9fbfe4a5, $e8b8d433,
        $7807c9a2, $0f00f934, $9609a88e, $e10e9818, $7f6a0dbb, $086d3d2d,
        $91646c97, $e6635c01, $6b6b51f4, $1c6c6162, $856530d8, $f262004e,
        $6c0695ed, $1b01a57b, $8208f4c1, $f50fc457, $65b0d9c6, $12b7e950,
        $8bbeb8ea, $fcb9887c, $62dd1ddf, $15da2d49, $8cd37cf3, $fbd44c65,
        $4db26158, $3ab551ce, $a3bc0074, $d4bb30e2, $4adfa541, $3dd895d7,
        $a4d1c46d, $d3d6f4fb, $4369e96a, $346ed9fc, $ad678846, $da60b8d0,
        $44042d73, $33031de5, $aa0a4c5f, $dd0d7cc9, $5005713c, $270241aa,
        $be0b1010, $c90c2086, $5768b525, $206f85b3, $b966d409, $ce61e49f,
        $5edef90e, $29d9c998, $b0d09822, $c7d7a8b4, $59b33d17, $2eb40d81,
        $b7bd5c3b, $c0ba6cad, $edb88320, $9abfb3b6, $03b6e20c, $74b1d29a,
        $ead54739, $9dd277af, $04db2615, $73dc1683, $e3630b12, $94643b84,
        $0d6d6a3e, $7a6a5aa8, $e40ecf0b, $9309ff9d, $0a00ae27, $7d079eb1,
        $f00f9344, $8708a3d2, $1e01f268, $6906c2fe, $f762575d, $806567cb,
        $196c3671, $6e6b06e7, $fed41b76, $89d32be0, $10da7a5a, $67dd4acc,
        $f9b9df6f, $8ebeeff9, $17b7be43, $60b08ed5, $d6d6a3e8, $a1d1937e,
        $38d8c2c4, $4fdff252, $d1bb67f1, $a6bc5767, $3fb506dd, $48b2364b,
        $d80d2bda, $af0a1b4c, $36034af6, $41047a60, $df60efc3, $a867df55,
        $316e8eef, $4669be79, $cb61b38c, $bc66831a, $256fd2a0, $5268e236,
        $cc0c7795, $bb0b4703, $220216b9, $5505262f, $c5ba3bbe, $b2bd0b28,
        $2bb45a92, $5cb36a04, $c2d7ffa7, $b5d0cf31, $2cd99e8b, $5bdeae1d,
        $9b64c2b0, $ec63f226, $756aa39c, $026d930a, $9c0906a9, $eb0e363f,
        $72076785, $05005713, $95bf4a82, $e2b87a14, $7bb12bae, $0cb61b38,
        $92d28e9b, $e5d5be0d, $7cdcefb7, $0bdbdf21, $86d3d2d4, $f1d4e242,
        $68ddb3f8, $1fda836e, $81be16cd, $f6b9265b, $6fb077e1, $18b74777,
        $88085ae6, $ff0f6a70, $66063bca, $11010b5c, $8f659eff, $f862ae69,
        $616bffd3, $166ccf45, $a00ae278, $d70dd2ee, $4e048354, $3903b3c2,
        $a7672661, $d06016f7, $4969474d, $3e6e77db, $aed16a4a, $d9d65adc,
        $40df0b66, $37d83bf0, $a9bcae53, $debb9ec5, $47b2cf7f, $30b5ffe9,
        $bdbdf21c, $cabac28a, $53b39330, $24b4a3a6, $bad03605, $cdd70693,
        $54de5729, $23d967bf, $b3667a2e, $c4614ab8, $5d681b02, $2a6f2b94,
        $b40bbe37, $c30c8ea1, $5a05df1b, $2d02ef8d);
     verflg:ansistring = 'PP10';
type
    TPRSData = record
        offset:integer;
        count:integer;
    end;
    TPikaPakEntry = Record
        name:array[0..128] of ansichar;
        size:dword;
        psize:dword;
        crc:dword;
    end;


    Function PikaGetFile(fs:TMemoryStream;filename,packname,pass:ansistring):integer;
    Function PikaAddFile(root,filename,packname,pass:ansistring):boolean;
    Function PikaAddFromStream(st:tstream;filename,packname,pass:ansistring):boolean;

    Function PikaDecompress(bufin,bufout:pansichar;size:integer):integer;
    Function PikaCompress(bufin,bufout:pansichar;size:integer):integer;


var
   ptr,curbit,curbyte:integer;
   buf,buf2:pansichar;
   curbytes:ansistring;

implementation


Function GetCRC(buf:pansichar;size:integer):dword;
var re:dword;
    x:integer;
begin
    re:=$ffffffff;
    for x:=0 to size-1 do
        re:=crc32tab[byte(re xor longint(buf[x]))] xor ((re shr 8) and $00ffffff);
    result:=re xor $ffffffff;
end;


Function PikaCypher(buf:pansichar;Filename,pass:ansistring;size:integer):boolean;
var key:array[0..255] of byte;
    x,y:integer;
begin
    y:=1;
    for x:=0 to 255 do begin
        key[x]:=x xor byte(filename[y]);
        inc(y);
        if y > length(filename) then y:=1;
    end;
    for x:=1 to length(pass) do key[x]:=key[x] xor byte(pass[x]);
    for x:=0 to 251 do key[x+4]:=key[x+4] xor key[x];
    y:=0;
    for x:=0 to size-1 do begin
        buf[x]:=ansichar(key[y] xor byte(buf[x]));
        inc(y);
        if y>255 then y:=0;
    end;
end;

Function GetBit():byte;
begin
    if curbit = 0 then begin
        curbyte:=byte(buf[ptr]);
        curbit:=8;
        inc(ptr);
    end;
    result:=curbyte and 1;
    curbyte:=curbyte div 2;
    dec(curbit);
end;

Function GetByte():ansichar;
begin
    result:=buf[ptr];
    inc(ptr);
end;

Function memfwdcpy(dest,src,count:integer):boolean;
var x:integer;
begin
    for x:=0 to count-1 do
        buf2[dest+x]:=buf2[src+x];
    result:=false;
end;


Function PikaDecompress(bufin,bufout:pansichar;size:integer):integer;
var destptr,count,off:integer;
begin
    curbit:=0;
    ptr:=0;
    buf2:=bufout;
    buf:=bufin;
    destptr:=0;
    while ptr < size do begin
        if getbit() = 1 then begin
            buf2[destptr]:=getbyte();
            inc(destptr);
        end else if getbit=1 then begin
            off:=byte(getbyte)+(byte(getbyte)*256);
            if off > 0 then begin
            count:=off and 7;
            if count <> 0 then count := count+2
            else count:=byte(getbyte)+1;
            off:=off div 8;
            memfwdcpy(destptr,destptr+off - 8192,count);
            inc(destptr,count);
            end else
                ptr:=size;
        end else begin
            count:=(getbit*2)+getbit+2;
            off:=byte(getbyte);
            memfwdcpy(destptr,destptr+off - 256,count);
            inc(destptr,count);
        end;
    end;
    //freemem(buf);
    result:=destptr;
end;


Function GetDataCopy(pos,si:integer):TPRSData;
var x,y,lfp,lfc,c:integer;
    re:TPRSData;
begin
    re.offset:=-1;
    lfp:=0; //reset the find data , this will be used to optimize the compression
    lfc:=0;
    y:=pos-8191; //set starting pos for search
    if y < 0 then y:=0; //make sure it doesnt search outside the file
    for x:=pos-1 downto y do begin
        if buf[x] = buf[pos] then begin //corespondance found
                for c:=1 to 255 do
                    if x+c >= si then break else
                    if (buf[x+c] <> buf[pos+c]) then break;
                if lfc < c then begin //better reference found save it
                    lfc:=c;
                    lfp:=x;
                    if c = 256 then break;
                end;
        end;
    end;
    if pos-lfp > 255 then begin
        if lfc>2 then begin
            re.offset:=pos-lfp;  // only if more that 2 char else it wont compress
            re.count:=lfc;
        end;
    end else if lfc > 1 then begin
        re.offset:=pos-lfp; //only if more that 1 char else it wont compress
        re.count:=lfc;
    end;
    result:=re;
end;

Function PutBit(b:byte):boolean;
var x:integer;
begin
    if curbit=8 then begin
        curbit:=0;
        buf2[ptr]:=ansichar(curbyte);
        inc(ptr);
        curbyte:=0;
        for x:=1 to length(curbytes) do
        begin
            buf2[ptr]:=curbytes[x];
            inc(ptr);
        end;
        curbytes:='';
    end;
    curbyte:=(curbyte div 2)+(b*$80);
    inc(curbit);
    result:=true;
end;

Function PutByte(b:ansichar):boolean;
begin
    curbytes:=curbytes+b;
    result:=true;
end;

Function PikaCompress(bufin,bufout:pansichar;size:integer):integer;
var p,c,off:integer;
    x:TPRSData;
begin
    p:=0;
    ptr:=0;
    curbit:=0;
    curbyte:=0;
    curbytes:='';
    buf2:=bufout;
    buf:=bufin;
    while p<size do begin
        x:=GetDataCopy(p,size);
        if x.offset = -1 then begin //direct copy
            PutBit(1);
            PutByte(buf[p]);
            inc(p);
        end else begin //forward copy
             c:=x.count;
             if p+c > size then c:=size-p;
             if c < 3 then begin
                while c > 0 do begin
                    PutBit(1);
                    PutByte(buf[p]);
                    inc(p);
                    dec(c);
                end;
             end else begin
            if (x.offset>255) or (c>5) then begin //far copy
                if c < 10 then off:=((8192-x.offset)*8)+(c-2)
                else off:=((8192-x.offset)*8);
                putbit(0);
                putbit(1);
                putbyte(ansichar(off));
                putbyte(ansichar(off div 256));
                if c> 9 then
                putbyte(ansichar(c-1));
                p:=p+c;
            end else begin // near copy
                putbit(0);
                putbit(0);
                p:=p+c;
                c:=c-2;
                putbit(c div 2);
                putbit(c and 1);
                putByte(ansichar(256-x.offset));
            end;
            end;
        end;
    end;
    putbit(0);
    putbit(1);
    putbyte(#0);
    putbyte(#0);
    putbyte(#0);
    putbit(0);
    putbit(0);
    putbit(0);
    putbit(0);
    putbit(0);
    putbit(0);
    putbit(0);
    putbit(0);
    result:=ptr;
    //freemem(buf);
end;


Function PikaAddFile(root,filename,packname,pass:ansistring):boolean;
var f,x,y:integer;
    bin,bout:pansichar;
    tp:TPikaPakEntry;
begin
    f:=fileopen(root+'\'+filename,$40);
    tp.size:=fileseek(f,0,2);
    fileseek(f,0,0);
    bin:=allocmem(tp.size);
    bout:=allocmem(tp.size*2);
    fillchar(tp.name[0],128,0);
    move(filename[1],tp.name[0],length(filename));
    fileread(f,bin[0],tp.size);
    fileclose(f);
    tp.psize:=PikaCompress(bin,bout,tp.size);
    if tp.psize>=tp.size then begin
        tp.psize:=tp.size;
        move(bin[0],bout[0],tp.size);
    end;
    tp.crc:=GetCRC(bout,tp.psize);
    pikacypher(bout,lowercase(filename),pass,tp.psize);

    if fileexists(packname) then begin
        f:=fileopen(packname,$12);
        fileseek(f,0,2);
    end else begin
        f:=filecreate(packname);
        filewrite(f,verflg[1],4);
    end;
    x:=(tp.psize+sizeof(tp)) xor $12345678;
    filewrite(f,tp.name[0],sizeof(tp));
    filewrite(f,bout[0],tp.psize);
    filewrite(f,x,4);
    freemem(bin);
    freemem(bout);
    fileclose(f);
end;

Function PikaAddFromStream(st:tstream;filename,packname,pass:ansistring):boolean;
var f,x,y:integer;
    bin,bout:pansichar;
    tp:TPikaPakEntry;
begin
    tp.size:=st.Size;
    st.Position:=0;
    bin:=allocmem(tp.size);
    bout:=allocmem(tp.size*2);
    fillchar(tp.name[0],128,0);
    move(filename[1],tp.name[0],length(filename));
    st.read(bin[0],tp.size);
    tp.psize:=PikaCompress(bin,bout,tp.size);
    if tp.psize>=tp.size then begin
        tp.psize:=tp.size;
        move(bin[0],bout[0],tp.size);
    end;
    tp.crc:=GetCRC(bout,tp.psize);
    pikacypher(bout,lowercase(filename),pass,tp.psize);

    if fileexists(packname) then begin
        f:=fileopen(packname,$12);
        fileseek(f,0,2);
    end else begin
        f:=filecreate(packname);
        filewrite(f,verflg[1],4);
    end;
    x:=(tp.psize+sizeof(tp)) xor $12345678;
    filewrite(f,tp.name[0],sizeof(tp));
    filewrite(f,bout[0],tp.psize);
    filewrite(f,x,4);
    freemem(bin);
    freemem(bout);
    fileclose(f);
end;

Function PikaGetFile(fs:TMemoryStream;filename,packname,pass:ansistring):integer;
var x,f,y:integer;
    tp:TPikaPakEntry;
    bin,bout:pansichar;
    s:ansistring;
begin
    f:=fileopen(packname,$40);
    if f > 0 then begin

        s:='    ';
        fileread(f,s[1],4);
        x:=fileseek(f,-4,2);
        if (s = 'PP10') or (s = 'MZP'#0) then begin
        while lowercase(filename) <> lowercase(pansichar(@tp.name[0])) do begin
            fileread(f,y,4);
            y:=y xor $12345678;
            x:=x-y;
            fileseek(f,x,0);
            fileread(f,tp,sizeof(tp));
            if x < 4 then break;
            x:=x-4;
            fileseek(f,x,0);
        end;
        if x >=0 then begin
            if lowercase(filename) = lowercase(pansichar(@tp.name[0])) then begin
                bin:=allocmem(tp.psize);
                bout:=allocmem(tp.size*2);
                fileseek(f,x+4+sizeof(tp),0);
                fileread(f,bin[0],tp.psize);
                pikacypher(bin,lowercase(filename),pass,tp.psize);
                if getcrc(bin,tp.psize) = tp.crc then begin
                    if tp.psize < tp.size then
                        PikaDecompress(bin,bout,tp.psize)
                    else move(bin[0],bout[0],tp.psize);
                    fs.Clear;
                    fs.Position:=0;
                    fs.Write(bout[0],tp.size);
                    fs.Position:=0;
                    result:=0;
                end else result:=-5;
                freemem(bin,tp.psize*2);
                freemem(bout,tp.size*2);
            end else result:=-4;
        end else result:=-3;
        end else result:=-2;
        fileclose(f);
    end else result:=-1;
end;


end.
