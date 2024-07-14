unit D3DEngin;

interface

uses
  windows, Types, SysUtils, Variants, Classes, Graphics, Direct3D9, D3DX9, dialogs, jpeg,math, SyncObjs;

type

    T3dIndexListA = Record                                                
        IndexCount,SurfaceCount:dword;
        TextureID,AlphaFlag:integer;
        AlphaSrc,AlphaDst:dword;
        tus,tvs:dword;
        SType:_D3DPRIMITIVETYPE;
        g_pIB: IDirect3DIndexBuffer9;
    end;

    TPikaVector = Record
        x,y,z:single;
    end;

    Tpikaang = record
        id:dword;
        ang:array[0..2] of dword;
    end;
    Tpikapos = record
        id:dword;
        pos:array[0..2] of single;
    end;

    T3DGroupeA = Record
        VertexCount:dword;
        VertexType:dword;
        VertexSize:dword;
        SurfaceType:_D3DPRIMITIVETYPE;
        IndexListCount:dword;
        g_pVB: IDirect3DVertexBuffer9;
        Indexs: array of T3dIndexListA;
        motionpos:array of tpikapos;
        motionang:array of tpikaang;
        motionsca:array of tpikapos;
        motionposcount,motionangcount,motionscalecount:integer;
        motiontime:dword;
        motionframe:integer;
        usemotion:boolean;
        defaultpos:array[0..2] of single;
        defaultrot:array[0..2] of dword;
        defaultscale:array[0..2] of single;
        textslideid,textswapid:integer;
    end;
    TItemBuf = record
        next:dword;
        dist:single;
        id:dword;
    end;

    T3dIndexListB = Record
        IndexCount,SurfaceCount:dword;
        TextureID,AlphaFlag:integer;
        RefX,RefZ:single;
        tus,tvs:dword;
        AlphaSource:dword;
        AlphaSrc,AlphaDst:dword;
        material:TD3DMaterial9;
        g_pIB: IDirect3DIndexBuffer9;
        SType:_D3DPRIMITIVETYPE;
    end;

    T3DGroupeB = Record
        VertexCount:dword;
        VertexType:dword;
        VertexSize:dword;
        SurfaceType:_D3DPRIMITIVETYPE;
        IndexListCount:dword;
        g_pVB: IDirect3DVertexBuffer9;
        Indexs: array of T3dIndexListB;
        motionpos:array of tpikapos;
        motionang:array of tpikaang;
        motionsca:array of tpikapos;
        motionposcount,motionangcount,motionscalecount:integer;
        motiontime:dword;
        motionframe:integer;
        usemotion:boolean;
        defaultpos:array[0..2] of single;
        defaultrot:array[0..2] of dword;
        defaultscale:array[0..2] of single;
        textslideid,textswapid:integer;
    end;

    T3DMapSection = Record
        BaseX,BaseZ:single;   //base de la section, utiliser pour trier les section a dessiner pour les grande map
        GroupeA_Count:dword;        //nombre de groupe pour les surface opaque
        GroupeB_Count:dword;        //nombre de groupe pour les surface transparent
        AmbientColor:dword;         //couleur d'ambiance a donner au surface
        GroupeA:array of T3DGroupeA;
        GroupeB:array of T3DGroupeB;
        Matrix:Td3dmatrix;
    end;

    T3dScene = class;
    T3dItem = class;
    TPikaEngine = Class;


    Tparticle = Record
        Used:boolean;
        x,y,z:single;
        sx,sy:single;
    end;

    T3DParticleGenerator = class
    private
        Texture:IDirect3DTexture9;
        Parent:T3dItem;
        Count:integer;
        Particles:array of TParticle;
        Procedure SetCount(x:integer);
    public
        PosX,posY,posZ:single;
        SizeX,SizeY:single;
        Tu1,Tv1,Tu2,Tv2:single;
        MixMode:integer;
        Color:dword;
        Property ParticleCount:integer read count write SetCount;
        Constructor Create(Item:T3dItem);
        Procedure LoadTexture(FileName:ansistring);
        Procedure Render;
    end;

    TTextureSwapEntry = record
        frame:word;
        newid:word;
    end;
    TTextureSwap = record
        id:integer;
        count:integer;
        maxframe:integer;
        Entry:array of TTextureSwapEntry;
    end;
    TTextureSlide = record
        frame,id:word;
        un1,un2:single;
        tu,tv:single;
    end;

    TPikaMap =  class
    private
        Header:dword;
        AreaCount:dword;
        TextureCount:dword;
        Area:array of T3DMapSection;
        Texture:array of IDirect3DTexture9;
        TexFlag:array of dword;
        scene:T3dScene;
        g_pd3dDevice: IDirect3DDevice9;
        usealpha,UseTextureSetting,UseGCSetting:boolean;
        DomeTop,DomeBottom:T3dItem;
        linkedengine:TPikaEngine;
        usematris:boolean;
        TextureSwap:array of TTextureSwap;
        TextureSwapCount:integer;
        TextureSlide:array of TTextureSlide;
        TextureSlideCount:integer;
        //cs:tcriticalsection;
    public
        visible:boolean;
        Constructor Create(Engin:TPikaEngine);
        Destructor Free;
        Function LoadPSOMap(Filename,TextureFileName:ansistring):boolean;
        Function LoadPangyaMap(Filename:ansistring):boolean;
        Function LoadPSOGCMap(Filename,TextureFileName:ansistring):boolean;
        Function LoadQ3Files(FileName:ansistring):boolean;
        Procedure LoadTopDome(TextureName:ansistring);
        Procedure LoadBottomDome(TextureName:ansistring);
        Procedure LoadPSOTam(filename:ansistring);
        Procedure Select;
    end;


    T3DVertex = record
        px,py,pz:single;
        color:dword;
        tu,tv:single;
    end;
    T3DVertex2 = record
        px,py,pz,nx,ny,nz:single;
        color:dword;
        tu,tv:single;
    end;

    T3dItemIndexList = Record
        IndexCount,SurfaceCount:dword;
        TextureID,AlphaFlag:integer;
        tus,tvs:dword;
        AlphaSource:dword;
        AlphaSrc,AlphaDst:dword;
        material:TD3DMaterial9;
        g_pIB: IDirect3DIndexBuffer9;
        SType:_D3DPRIMITIVETYPE;
        LODICount,LODSCount:array[0..1] of dword;
        LODIB: IDirect3DIndexBuffer9;
    end;

    T3DItemSection = Record
        VertexCount,VertexOff:dword;
        SurfaceType:_D3DPRIMITIVETYPE;
        VertexOrg:array of T3DVertex;
        VertexFlag:array of dword;
        //VertexList:array of T3DVertex2;
        IndexListCount:dword;
        Indexs: array of T3dItemIndexList;
    end;

    TFrame = Record
        SectionCount:integer;
        Section:Array of T3DItemSection;
    end;

    T3DItem = Class
    Private
        g_pd3dDevice: IDirect3DDevice9;
        g_3DScene:T3dScene;
        g_pVB: IDirect3DVertexBuffer9;
        FrameCount:integer;
        Frame:array of tframe;
        TextureCount,selframe:integer;
        Texture:array of IDirect3DTexture9;
        TextureName:TstringList;
        ProX:single;
        ProY:single;
        ProZ:single;
        maxx,maxy,maxz,minx,miny,minz:single;
        usealpha,maped,usematerial,rdy:boolean;                                         
        COL:dword;
        LOD:dword;
        VBCount:integer;
        fogcolor:dword;
        baserx,basery,baserz,usx,usy,usz,dsx,dsy,dsz:integer;
        RH,RV1,RV2:single;
        PosX,PosY,PosZ:Single;
        Alpha,srcalpha,destalpha:byte;
        isclone:boolean;
        textswap:array of dword;
         cs:tcriticalsection;
        textswapcount:integer;
        BinFile:TMemoryStream;
        alwaysDraw: boolean;
        Procedure SetFrame(f:integer);
        Procedure SetPosX(x:single);
        Procedure SetPosY(x:single);
        Procedure SetPosZ(x:single);
        Procedure RemapVertex;
        Procedure SetAlpha(a:byte);
        Procedure Setdestalpha(a:byte);
        Procedure setsrcalpha(a:byte);
        Procedure SetColor(a:dword);
        Procedure Render(lod:integer;fogged:integer);
        function getrdy:boolean;
    public
        Visible,zwrite,isOnTop:boolean;
        PollyCount,rotationseq:integer;
        Particles:T3DParticleGenerator;
        Property isready:boolean read getrdy;
        Property SizeDownX:integer read dsx;
        Property SizeDownY:integer read dsy;
        Property SizeDownZ:integer read dsz;
        Property SizeUpX:integer read usx;
        Property SizeUpY:integer read usy;
        Property SizeUPZ:integer read usz;
        property NumberOfFrame:integer read framecount;
        Property AlphaLevel:byte read alpha write SetAlpha;
        Property AlphaSource:byte read srcalpha write setsrcalpha;
        Property AlphaDest:byte read destalpha write Setdestalpha;
        Property Color:dword read COL write SetColor;
        property PositionX:single read posx write SetPosX;
        property PositionY:single read posy write SetPosY;
        property PositionZ:single read posz write SetPosZ;
        property SelectedFrame:integer read selframe write SetFrame;
        constructor Create(Engine:TPikaEngine);
        Destructor Free;
        Procedure SetBaseRotation(Bx,By,Bz:integer);
        Procedure SetProportion(Prox,ProY,ProZ:single);
        Procedure SetRotation(rh,rv1,rv2:single);
        Procedure SetCoordinate(x,y,z:single);
        //Procedure GenerateLOD;
        Function LoadPangyaMap(FileName:ansistring):boolean;
        Function LoadQ3Files(FileName:ansistring):boolean;
        Function LoadQ3Stream(data:pansichar;dsize:integer):boolean;
        Function LoadFromNJ(FileName,texname,aniname:ansistring):boolean;
        Function LoadFromXJ(FileName,texname,anifile:ansistring):boolean;
        Function CloneFromItem(it:T3DItem):boolean;
        Function GetLargessVertex:single;
        Function SetTexture(ID:integer;Tex:TMemoryStream):boolean;
        Procedure SetTextureSwap(id,newid:word);
        Function LoadFromRel(filename,TexName:ansistring):boolean;
        Function LoadFromObj(filename:ansistring):boolean;
        Function SetVertexList(vertex: array of T3DVertex): boolean;
    end;

    TPikaSurface = Class//(tthread)
    private
        g_pd3dDevice: IDirect3DDevice9;
        g_3DScene:T3dScene;
        VertexList,VertexOrg:array[0..4] of T3DVertex;
        Texture,Texture2:IDirect3DTexture9;
        ProX:single;
        ProY:single;
        ProZ:single;
        RH,RV1,RV2:single;
        PosX,PosY,PosZ:Single;
    public
        Color:DWORD;
        Visible:boolean;
        Locked,overall,tail:boolean;
        AlphaSrc,AlphaDest:integer;
        tailpos:TPikaVector;
        constructor Create(Engine:TPikaEngine);
        Destructor Free;
        Procedure Render;
        Procedure SetProportion(Prox,ProY,ProZ:single);
        Procedure SetRotation(rh,rv1,rv2:single);
        Procedure SetCoordinate(x,y,z:single);
        Procedure LoadFromFile(Filename:ansistring;TransColor:DWORD);
        Procedure TailLoadFromFile(Filename:ansistring;TransColor:DWORD);
        Procedure LoadFromBitmap(bmp:TBITMAP);
        Procedure SetUV(u1,v1,u2,v2:single);
    end;

    


    T3dScene = class
    public
        Map:TPikaMap;
        ItemsCount:dword;
        Items:array of T3DItem;
        SurfaceCount:dword;
        surface:array of TPikaSurface;
        TmpSur:IDirect3DVertexBuffer9;
        EyeRH,EyeRV:single;
        EyeX,EyeZ,EyeY:single;
        cs:tcriticalsection;
    end;
    TTextData = Record
        Text:ansistring;
        color,over:dword;
        rect:trect;
    end;

    TPikaEngine = Class //(tthread)
    Private
        g_pD3D: IDirect3D9; // Used to create the D3DDevice
        g_pd3dDevice: IDirect3DDevice9; // render device
        g_3DScene:T3dScene;
        g_shader:IDirect3DVertexShader9;
        BGColor,AmbColor:dword;
        ViewDist:integer;
        EyeX,EyeZ,EyeY:single;
        EyeLX,EyeLZ,EyeLY:single;
        ITZ:array of TItemBuf;
        AlphaEnabledStatus:boolean;
        isAntialising:boolean;
        LightEnabledStatus:boolean;
        isMirrored:Boolean;
        AlphaSrcMode:integer;
        AlphaDstMode:integer;
        tp:Id3dxfont;
        ZBuf:array[-1..12000,0..4] of dword;
        fogend:single;
        TextData:array[0..1000] of TTextData;
        TextCount:integer;
        currentclipping:single;
        FogPos,Fogtick:single;
        FogImg:IDirect3DTexture9;
        fogcolor:dword;
        FogV1,FogV2:TpikaVector;
        pcode:ID3DXBUFFER;
        WireFramed:boolean;
        Procedure EnableAlpha(status:boolean);
        Procedure EnableLight(status:boolean);
        Procedure SetAlphaTest(min:integer);
        Procedure SetAlphaSource(src:integer);
        Procedure SetAlphaDest(dst:integer);
        Procedure SetAmbiantLight(color:dword);
        Procedure SetAntialising(status:boolean);
        Procedure SetMirroredTexture(status:boolean);
        Procedure SetViewDistance(Dist:integer);
        Function GetViewMatrix:TD3DXMATRIX;
        function InitD3D(hWnd: HWND; sx,sy,fps:integer): boolean;
        Procedure DrawFog;
        procedure setwireframe(x:boolean);
        Function SupportBumpMap:boolean;
    protected
    public
        Enable:boolean;
        ItemDistance:integer;
        Property DoesBumpMapping:boolean read SupportBumpMap;
        property matview:TD3DXMATRIX read GetViewMatrix;
        property Wireframe:boolean read wireframed write SetWireframe;
        constructor Create(hWnd: HWND; sx,sy,fps:integer);
        property AlphaEnabled: Boolean read AlphaEnabledStatus write EnableAlpha;
        property Antializing: Boolean read isAntialising write SetAntialising;
        property LightEnabled: Boolean read LightEnabledStatus write EnableLight;
        property TextureMirrored: Boolean read isMirrored write SetMirroredTexture;
        property AlphaSourceMode: integer read AlphaSrcMode write SetAlphaSource;
        property AlphaTestValue: integer write SetAlphaTest;
        property AlphaDestMode: integer read AlphaDstMode write SetAlphaDest;
        property ViewDistance: integer read ViewDist write SetViewDistance;
        property BackGroundColor: dword read BGColor write BGColor;
        property AmbientLightColor: dword read AmbColor write SetAmbiantLight;
        Destructor Free3d;
        Procedure RenderSurface;
        Procedure SetTextureAlphaSource(Stage,src:dword);
        Procedure SetView(eyeptx,eyepty,eyeptz,vr,vz:single);
        Procedure LookAt(eyeptx,eyepty,eyeptz,LookX,LookY,LookZ:single);
        Procedure SetDirectionalLight(id:integer;COLOR:Dword;dx,dy,dz:single);
        Procedure SetPointLight(id:integer;COLOR:Dword;dx,dy,dz,range,ate:single);
        procedure SetFog(Color:dword;fstart,fend:single);
        procedure SetProjection(ProX,ProY,ScaleX,ScaleY,ScaleZ:single);
        Procedure TextOut(text:ansistring;pos:trect;color,overall:dword);
        Procedure DisableFog;
        Procedure GetBitmap(var bm:tbitmap);
        Procedure SetClipping(fend:single);
        procedure SetAdvancedFog(Vertex1,Vertex2:TpikaVector;color:dword;filename:ansistring);
    end;



Const skydome: array[0..1299] of byte = (
	$49, $44, $50, $33, $0F, $00, $00, $00, $46, $3A, $5C, $67, $6D, $61, $78, $5C, 
	$6D, $65, $73, $68, $65, $73, $5C, $64, $6F, $6D, $65, $2E, $6D, $64, $33, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, 
	$00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $6C, $00, $00, $00, 
	$A4, $00, $00, $00, $A4, $00, $00, $00, $14, $05, $00, $00, $00, $00, $80, $BF, 
	$00, $00, $80, $BF, $00, $00, $80, $BF, $00, $00, $80, $3F, $00, $00, $80, $3F, 
	$00, $00, $80, $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $80, $3F, $28, $66, $72, $6F, $6D, $20, $33, $44, $53, $4D, $61, $78, 
	$29, $00, $00, $00, $49, $44, $50, $33, $47, $65, $6F, $53, $70, $68, $65, $72, 
	$65, $30, $31, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, 
	$01, $00, $00, $00, $1E, $00, $00, $00, $28, $00, $00, $00, $B0, $00, $00, $00, 
	$6C, $00, $00, $00, $90, $02, $00, $00, $80, $03, $00, $00, $70, $04, $00, $00, 
	$44, $3A, $5C, $50, $72, $6F, $67, $72, $61, $6D, $20, $46, $69, $6C, $65, $73, 
	$5C, $42, $6F, $72, $6C, $61, $6E, $64, $5C, $44, $65, $6C, $70, $68, $69, $36, 
	$5C, $50, $72, $6F, $6A, $65, $63, $74, $73, $5C, $70, $73, $6F, $20, $73, $65, 
	$72, $76, $65, $72, $5C, $71, $75, $65, $73, $74, $20, $65, $64, $69, $74, $6F, 
	$72, $5C, $6D, $00, $0B, $00, $00, $00, $14, $00, $00, $00, $04, $00, $00, $00, 
	$0B, $00, $00, $00, $06, $00, $00, $00, $14, $00, $00, $00, $06, $00, $00, $00, 
	$00, $00, $00, $00, $14, $00, $00, $00, $0C, $00, $00, $00, $10, $00, $00, $00, 
	$00, $00, $00, $00, $0C, $00, $00, $00, $07, $00, $00, $00, $10, $00, $00, $00, 
	$1A, $00, $00, $00, $01, $00, $00, $00, $1B, $00, $00, $00, $0D, $00, $00, $00, 
	$11, $00, $00, $00, $01, $00, $00, $00, $0D, $00, $00, $00, $08, $00, $00, $00, 
	$11, $00, $00, $00, $08, $00, $00, $00, $02, $00, $00, $00, $11, $00, $00, $00, 
	$0E, $00, $00, $00, $12, $00, $00, $00, $02, $00, $00, $00, $0E, $00, $00, $00, 
	$09, $00, $00, $00, $12, $00, $00, $00, $09, $00, $00, $00, $03, $00, $00, $00, 
	$12, $00, $00, $00, $0F, $00, $00, $00, $13, $00, $00, $00, $03, $00, $00, $00, 
	$0F, $00, $00, $00, $0A, $00, $00, $00, $13, $00, $00, $00, $0A, $00, $00, $00, 
	$04, $00, $00, $00, $13, $00, $00, $00, $00, $00, $00, $00, $06, $00, $00, $00, 
	$0C, $00, $00, $00, $01, $00, $00, $00, $1A, $00, $00, $00, $0D, $00, $00, $00, 
	$02, $00, $00, $00, $08, $00, $00, $00, $0E, $00, $00, $00, $03, $00, $00, $00, 
	$09, $00, $00, $00, $0F, $00, $00, $00, $04, $00, $00, $00, $0A, $00, $00, $00, 
	$0B, $00, $00, $00, $05, $00, $00, $00, $15, $00, $00, $00, $16, $00, $00, $00, 
	$16, $00, $00, $00, $1B, $00, $00, $00, $01, $00, $00, $00, $16, $00, $00, $00, 
	$15, $00, $00, $00, $1B, $00, $00, $00, $1C, $00, $00, $00, $00, $00, $00, $00,
	$10, $00, $00, $00, $05, $00, $00, $00, $16, $00, $00, $00, $17, $00, $00, $00, 
	$17, $00, $00, $00, $11, $00, $00, $00, $02, $00, $00, $00, $17, $00, $00, $00, 
	$16, $00, $00, $00, $11, $00, $00, $00, $16, $00, $00, $00, $01, $00, $00, $00, 
	$11, $00, $00, $00, $1D, $00, $00, $00, $17, $00, $00, $00, $18, $00, $00, $00, 
	$18, $00, $00, $00, $12, $00, $00, $00, $03, $00, $00, $00, $18, $00, $00, $00, 
	$17, $00, $00, $00, $12, $00, $00, $00, $17, $00, $00, $00, $02, $00, $00, $00, 
	$12, $00, $00, $00, $1D, $00, $00, $00, $18, $00, $00, $00, $19, $00, $00, $00, 
	$19, $00, $00, $00, $13, $00, $00, $00, $04, $00, $00, $00, $19, $00, $00, $00, 
	$18, $00, $00, $00, $13, $00, $00, $00, $18, $00, $00, $00, $03, $00, $00, $00, 
	$13, $00, $00, $00, $1D, $00, $00, $00, $19, $00, $00, $00, $1C, $00, $00, $00, 
	$1C, $00, $00, $00, $14, $00, $00, $00, $00, $00, $00, $00, $1C, $00, $00, $00, 
	$19, $00, $00, $00, $14, $00, $00, $00, $19, $00, $00, $00, $04, $00, $00, $00, 
	$14, $00, $00, $00, $68, $87, $D9, $3F, $18, $A4, $0D, $3F, $4D, $F4, $CA, $3D, 
	$18, $A4, $0D, $3F, $FF, $FF, $FF, $3E, $18, $A4, $0D, $3F, $74, $A1, $66, $3F, 
	$18, $A4, $0D, $3F, $97, $78, $A6, $3F, $18, $A4, $0D, $3F, $02, $00, $00, $BF, 
	$00, $BC, $02, $3A, $3F, $C4, $CC, $3F, $58, $10, $80, $3F, $40, $E4, $FF, $3F, 
	$58, $10, $80, $3F, $6A, $AA, $CC, $3E, $58, $10, $80, $3F, $C3, $F9, $4C, $3F, 
	$58, $10, $80, $3F, $03, $B0, $99, $3F, $58, $10, $80, $3F, $C0, $3B, $B3, $3F, 
	$58, $10, $80, $3F, $FC, $4F, $E6, $3F, $58, $10, $80, $3F, $F1, $18, $4C, $3E, 
	$58, $10, $80, $3F, $CA, $AA, $19, $3F, $58, $10, $80, $3F, $BF, $1B, $80, $3F, 
	$58, $10, $80, $3F, $34, $14, $F3, $3F, $BC, $14, $F3, $3E, $B7, $4C, $99, $3E, 
	$BC, $14, $F3, $3E, $A3, $59, $33, $3F, $BE, $14, $F3, $3E, $CA, $EB, $8C, $3F, 
	$BC, $14, $F3, $3E, $00, $00, $C0, $3F, $BE, $14, $F3, $3E, $34, $15, $9A, $BE, 
	$B4, $71, $19, $3E, $6E, $A8, $C9, $3D, $B4, $71, $19, $3E, $FF, $FF, $FF, $3E, 
	$B4, $71, $19, $3E, $F0, $CA, $66, $3F, $B4, $71, $19, $3E, $4C, $85, $A6, $3F, 
	$B4, $71, $19, $3E, $00, $00, $5E, $BA, $58, $10, $80, $3F, $C0, $BC, $CE, $BD, 
	$BC, $14, $F3, $3E, $B3, $7A, $D9, $3F, $B4, $71, $19, $3E, $FF, $FF, $BF, $3F, 
	$00, $BC, $02, $3A, $CF, $01, $1E, $01, $50, $01, $29, $16, $50, $FF, $1E, $01, 
	$20, $02, $16, $56, $C4, $FD, $1E, $01, $00, $00, $3F, $6C, $50, $FF, $1E, $01, 
	$E0, $FD, $69, $56, $CF, $01, $1E, $01, $B0, $FE, $56, $16, $00, $00, $80, $02, 
	$00, $00, $3F, $3F, $60, $02, $00, $00, $C5, $00, $34, $09, $00, $00, $00, $00, 
	$80, $02, $09, $3B, $A0, $FD, $00, $00, $C5, $00, $32, $75, $88, $FE, $00, $00, 
	$FB, $FD, $63, $71, $78, $01, $00, $00, $FB, $FD, $65, $0F, $60, $02, $00, $00, 
	$3B, $FF, $4B, $09, $78, $01, $00, $00, $05, $02, $19, $0F, $88, $FE, $00, $00, 
	$05, $02, $1B, $71, $A0, $FD, $00, $00, $3B, $FF, $4D, $75, $00, $00, $00, $00, 
	$80, $FD, $76, $3B, $A8, $00, $50, $01, $05, $02, $19, $2C, $48, $FE, $50, $01, 
	$3F, $01, $2A, $65, $48, $FE, $50, $01, $C0, $FE, $55, $65, $A8, $00, $50, $01, 
	$FB, $FD, $65, $2C, $20, $02, $50, $01, $00, $00, $3F, $16, $10, $01, $20, $02, 
	$C5, $00, $32, $2C, $99, $FF, $20, $02, $40, $01, $2A, $47, $B0, $FE, $20, $02, 
	$00, $00, $3F, $56, $99, $FF, $20, $02, $C0, $FE, $54, $47, $10, $01, $20, $02, 
	$3B, $FF, $4C, $2C, $00, $00, $00, $00, $80, $02, $09, $3B, $A8, $00, $50, $01, 
	$05, $02, $19, $2C, $10, $01, $20, $02, $C5, $00, $32, $2C, $00, $00, $80, $02, 
	$00, $00, $3F, $3F
);

    skydome2: array[0..1299] of byte = (
	$49, $44, $50, $33, $0F, $00, $00, $00, $46, $3A, $5C, $67, $6D, $61, $78, $5C, 
	$6D, $65, $73, $68, $65, $73, $5C, $64, $6F, $6D, $65, $2E, $6D, $64, $33, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, 
	$00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $6C, $00, $00, $00, 
	$A4, $00, $00, $00, $A4, $00, $00, $00, $14, $05, $00, $00, $00, $00, $80, $BF, 
	$00, $00, $80, $BF, $00, $00, $80, $BF, $00, $00, $80, $3F, $00, $00, $80, $3F, 
	$00, $00, $80, $3F, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $80, $3F, $28, $66, $72, $6F, $6D, $20, $33, $44, $53, $4D, $61, $78, 
	$29, $00, $00, $00, $49, $44, $50, $33, $47, $65, $6F, $53, $70, $68, $65, $72, 
	$65, $30, $31, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, 
	$00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, 
	$01, $00, $00, $00, $1E, $00, $00, $00, $28, $00, $00, $00, $B0, $00, $00, $00, 
	$6C, $00, $00, $00, $90, $02, $00, $00, $80, $03, $00, $00, $70, $04, $00, $00, 
	$44, $3A, $5C, $50, $72, $6F, $67, $72, $61, $6D, $20, $46, $69, $6C, $65, $73, 
	$5C, $42, $6F, $72, $6C, $61, $6E, $64, $5C, $44, $65, $6C, $70, $68, $69, $36, 
	$5C, $50, $72, $6F, $6A, $65, $63, $74, $73, $5C, $70, $73, $6F, $20, $73, $65, 
	$72, $76, $65, $72, $5C, $71, $75, $65, $73, $74, $20, $65, $64, $69, $74, $6F, 
	$72, $5C, $6D, $00, $0B, $00, $00, $00, $14, $00, $00, $00, $04, $00, $00, $00, 
	$0B, $00, $00, $00, $06, $00, $00, $00, $14, $00, $00, $00, $06, $00, $00, $00, 
	$00, $00, $00, $00, $14, $00, $00, $00, $0C, $00, $00, $00, $10, $00, $00, $00, 
	$00, $00, $00, $00, $0C, $00, $00, $00, $07, $00, $00, $00, $10, $00, $00, $00, 
	$1A, $00, $00, $00, $01, $00, $00, $00, $1B, $00, $00, $00, $0D, $00, $00, $00, 
	$11, $00, $00, $00, $01, $00, $00, $00, $0D, $00, $00, $00, $08, $00, $00, $00, 
	$11, $00, $00, $00, $08, $00, $00, $00, $02, $00, $00, $00, $11, $00, $00, $00, 
	$0E, $00, $00, $00, $12, $00, $00, $00, $02, $00, $00, $00, $0E, $00, $00, $00, 
	$09, $00, $00, $00, $12, $00, $00, $00, $09, $00, $00, $00, $03, $00, $00, $00, 
	$12, $00, $00, $00, $0F, $00, $00, $00, $13, $00, $00, $00, $03, $00, $00, $00, 
	$0F, $00, $00, $00, $0A, $00, $00, $00, $13, $00, $00, $00, $0A, $00, $00, $00, 
	$04, $00, $00, $00, $13, $00, $00, $00, $00, $00, $00, $00, $06, $00, $00, $00, 
	$0C, $00, $00, $00, $01, $00, $00, $00, $1A, $00, $00, $00, $0D, $00, $00, $00, 
	$02, $00, $00, $00, $08, $00, $00, $00, $0E, $00, $00, $00, $03, $00, $00, $00, 
	$09, $00, $00, $00, $0F, $00, $00, $00, $04, $00, $00, $00, $0A, $00, $00, $00, 
	$0B, $00, $00, $00, $05, $00, $00, $00, $15, $00, $00, $00, $16, $00, $00, $00, 
	$16, $00, $00, $00, $1B, $00, $00, $00, $01, $00, $00, $00, $16, $00, $00, $00,
	$15, $00, $00, $00, $1B, $00, $00, $00, $1C, $00, $00, $00, $00, $00, $00, $00, 
	$10, $00, $00, $00, $05, $00, $00, $00, $16, $00, $00, $00, $17, $00, $00, $00, 
	$17, $00, $00, $00, $11, $00, $00, $00, $02, $00, $00, $00, $17, $00, $00, $00, 
	$16, $00, $00, $00, $11, $00, $00, $00, $16, $00, $00, $00, $01, $00, $00, $00, 
	$11, $00, $00, $00, $1D, $00, $00, $00, $17, $00, $00, $00, $18, $00, $00, $00, 
	$18, $00, $00, $00, $12, $00, $00, $00, $03, $00, $00, $00, $18, $00, $00, $00, 
	$17, $00, $00, $00, $12, $00, $00, $00, $17, $00, $00, $00, $02, $00, $00, $00, 
	$12, $00, $00, $00, $1D, $00, $00, $00, $18, $00, $00, $00, $19, $00, $00, $00, 
	$19, $00, $00, $00, $13, $00, $00, $00, $04, $00, $00, $00, $19, $00, $00, $00, 
	$18, $00, $00, $00, $13, $00, $00, $00, $18, $00, $00, $00, $03, $00, $00, $00, 
	$13, $00, $00, $00, $1D, $00, $00, $00, $19, $00, $00, $00, $1C, $00, $00, $00, 
	$1C, $00, $00, $00, $14, $00, $00, $00, $00, $00, $00, $00, $1C, $00, $00, $00, 
	$19, $00, $00, $00, $14, $00, $00, $00, $19, $00, $00, $00, $04, $00, $00, $00, 
	$14, $00, $00, $00, $68, $87, $D9, $3F, $D0, $B7, $E4, $3E, $4D, $F4, $CA, $3D, 
	$D0, $B7, $E4, $3E, $FF, $FF, $FF, $3E, $D0, $B7, $E4, $3E, $74, $A1, $66, $3F, 
	$D0, $B7, $E4, $3E, $97, $78, $A6, $3F, $D0, $B7, $E4, $3E, $02, $00, $00, $BF, 
	$51, $DF, $7F, $3F, $3F, $C4, $CC, $3F, $00, $C0, $02, $BA, $40, $E4, $FF, $3F, 
	$00, $C0, $02, $BA, $6A, $AA, $CC, $3E, $00, $C0, $02, $BA, $C3, $F9, $4C, $3F, 
	$00, $C0, $02, $BA, $03, $B0, $99, $3F, $00, $C0, $02, $BA, $C0, $3B, $B3, $3F, 
	$00, $C0, $02, $BA, $FC, $4F, $E6, $3F, $00, $C0, $02, $BA, $F1, $18, $4C, $3E, 
	$00, $C0, $02, $BA, $CA, $AA, $19, $3F, $00, $C0, $02, $BA, $BF, $1B, $80, $3F, 
	$00, $C0, $02, $BA, $34, $14, $F3, $3F, $A2, $75, $06, $3F, $B7, $4C, $99, $3E, 
	$A2, $75, $06, $3F, $A3, $59, $33, $3F, $A1, $75, $06, $3F, $CA, $EB, $8C, $3F, 
	$A2, $75, $06, $3F, $00, $00, $C0, $3F, $A1, $75, $06, $3F, $34, $15, $9A, $BE, 
	$93, $A3, $59, $3F, $6E, $A8, $C9, $3D, $93, $A3, $59, $3F, $FF, $FF, $FF, $3E, 
	$93, $A3, $59, $3F, $F0, $CA, $66, $3F, $93, $A3, $59, $3F, $4C, $85, $A6, $3F, 
	$93, $A3, $59, $3F, $00, $00, $5E, $BA, $00, $C0, $02, $BA, $C0, $BC, $CE, $BD, 
	$A2, $75, $06, $3F, $B3, $7A, $D9, $3F, $93, $A3, $59, $3F, $FF, $FF, $BF, $3F, 
	$51, $DF, $7F, $3F, $CF, $01, $1E, $01, $50, $01, $29, $16, $50, $FF, $1E, $01, 
	$20, $02, $16, $56, $C4, $FD, $1E, $01, $00, $00, $3F, $6C, $50, $FF, $1E, $01, 
	$E0, $FD, $69, $56, $CF, $01, $1E, $01, $B0, $FE, $56, $16, $00, $00, $80, $02, 
	$00, $00, $3F, $3F, $60, $02, $00, $00, $C5, $00, $34, $09, $00, $00, $00, $00, 
	$80, $02, $09, $3B, $A0, $FD, $00, $00, $C5, $00, $32, $75, $88, $FE, $00, $00, 
	$FB, $FD, $63, $71, $78, $01, $00, $00, $FB, $FD, $65, $0F, $60, $02, $00, $00, 
	$3B, $FF, $4B, $09, $78, $01, $00, $00, $05, $02, $19, $0F, $88, $FE, $00, $00, 
	$05, $02, $1B, $71, $A0, $FD, $00, $00, $3B, $FF, $4D, $75, $00, $00, $00, $00, 
	$80, $FD, $76, $3B, $A8, $00, $50, $01, $05, $02, $19, $2C, $48, $FE, $50, $01, 
	$3F, $01, $2A, $65, $48, $FE, $50, $01, $C0, $FE, $55, $65, $A8, $00, $50, $01, 
	$FB, $FD, $65, $2C, $20, $02, $50, $01, $00, $00, $3F, $16, $10, $01, $20, $02, 
	$C5, $00, $32, $2C, $99, $FF, $20, $02, $40, $01, $2A, $47, $B0, $FE, $20, $02, 
	$00, $00, $3F, $56, $99, $FF, $20, $02, $C0, $FE, $54, $47, $10, $01, $20, $02, 
	$3B, $FF, $4C, $2C, $00, $00, $00, $00, $80, $02, $09, $3B, $A8, $00, $50, $01, 
	$05, $02, $19, $2C, $10, $01, $20, $02, $C5, $00, $32, $2C, $00, $00, $80, $02, 
	$00, $00, $3F, $3F
);



Function PikaVector(x,y,z:single):tPikaVector;
Function GetYposition(vP,vA,vB,vC:TPikaVector;var Y:single):boolean;
Function F2DW(F:single):dword;



implementation

uses PikaPackage;


Constructor T3DParticleGenerator.Create(Item:T3Ditem);
begin
    inherited Create;
    if self <> nil then begin
    self.Texture:=nil;
    self.Parent:=item;
    item.AlphaLevel:=254;
    self.PosX:=0;
    self.posY:=0;
    self.posZ:=0;
    self.SizeX:=1;
    self.SizeY:=1;
    self.Color:=$FFFFFF;
    self.Tu1:=0;
    self.Tv1:=0;
    self.Tu2:=1;
    self.Tv2:=1;
    self.MixMode:=0;
    self.SetCount(1);
    end;
end;

Procedure T3DParticleGenerator.SetCount(x:integer);
var i:integer;
begin
    count:=x;
    setlength(particles,x);
    for i:=0 to x-1 do
        particles[i].Used:=false;
end;

function t3ditem.getrdy:boolean;
begin
    cs.Enter;
    result:=rdy;
    cs.Leave;
end;


Procedure T3DParticleGenerator.Render;
var ver:array[0..3] of T3DVertex;
    v1,v2:_D3DVECTOR;
    ma,ma2:_D3DMatrix;
    x,y:single;
    rt:dword;
    i,z:integer;
    p:pointer;
begin
    //find the rotation of eatch point
    {x:=parent.g_3DScene.EyeX-parent.PosX;
    y:=parent.g_3DScene.Eyez-parent.Posz;
    if (x<>0) and (y<>0) then begin
    if (x>0) and (y>0) then begin
        if x>y then rt:=$4000-round(y/(sqrt(sqr(x)+sqr(y)) )*10430.37835)
        else rt:=round(x/(sqrt(sqr(x)+sqr(y)) )*10430.37835);
    end;

    if (x>0) and (y<0) then begin
        if abs(x)>abs(y) then rt:=$4000-round(y/(sqrt(sqr(x)+sqr(y)) )*10430.37835)
        else rt:=$8000-round(x/(sqrt(sqr(x)+sqr(y)) )*10430.37835);
    end;

    if (x<0) and (y<0) then begin
        if abs(x)>abs(y) then rt:=$C000+round(y/(sqrt(sqr(x)+sqr(y)) )*10430.37835)
        else rt:=$8000-round(x/(sqrt(sqr(x)+sqr(y)) )*10430.37835);
    end;

    if (x<0) and (y>0) then begin
        if abs(x)>abs(y) then rt:=$C000+round(y/(sqrt(sqr(x)+sqr(y)) )*10430.37835)
        else rt:=$10000+round(x/(sqrt(sqr(x)+sqr(y)) )*10430.37835);
    end;
    end else begin
    if x = 0 then begin
        if y>0 then rt:=0
        else rt:=$8000;
    end;

    if y = 0 then begin
        if x>0 then rt:=$4000
        else rt:=$C000;
    end;
    end;     }
    //rt:=round(parent.g_3DScene.EyeRH);

    for z:=0 to count-1 do begin
    if self.particles[z].Used = false then begin
        self.particles[z].x:=self.PosX;
        self.particles[z].y:=posy;
        self.particles[z].z:=posz;
        self.particles[z].sx:=sizex;
        self.particles[z].sy:=sizey;
        self.particles[z].Used:=true;
    end;

    v1.x:=-(self.particles[z].sx/2);
    v1.y:=(self.particles[z].sY/2);
    v1.z:=0;
    D3DXMatrixRotationY(ma,-parent.g_3DScene.EyeRH+1.57079632); //rt/ 10430.37835);
    D3DXVec3TransformCoord(v2,v1,ma);
    move(v2,ver[0],12);
    ver[0].color:=color;
    ver[0].tu:=tu1;
    ver[0].tv:=tv1;

    v1.x:=(self.particles[z].sX/2);
    v1.y:=(self.particles[z].sY/2);
    D3DXVec3TransformCoord(v2,v1,ma);
    move(v2,ver[1],12);
    ver[1].color:=color;
    ver[1].tu:=tu2;
    ver[1].tv:=tv1;

    v1.x:=-(self.particles[z].sX/2);
    v1.y:=-(self.particles[z].sY/2);
    D3DXVec3TransformCoord(v2,v1,ma);
    move(v2,ver[2],12);
    ver[2].color:=color;
    ver[2].tu:=tu1;
    ver[2].tv:=tv2;

    v1.x:=(self.particles[z].sX/2);
    v1.y:=-(self.particles[z].sY/2);
    D3DXVec3TransformCoord(v2,v1,ma);
    move(v2,ver[3],12);
    ver[3].color:=color;
    ver[3].tu:=tu2;
    ver[3].tv:=tv2;


    for i:=0 to 3 do begin
    ver[i].px:=ver[i].px+parent.PosX+self.particles[z].x;
    ver[i].py:=ver[i].py+parent.PosY+self.particles[z].y;
    ver[i].pz:=ver[i].pz+parent.PosZ+self.particles[z].z;
   end;

    //draw it nao
    parent.g_3DScene.TmpSur.Lock(0,24*4,p,0);
    move(ver[0],pansichar(p)[0],24*4);
    parent.g_3DScene.TmpSur.Unlock;

    parent.g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,3);//source blend factor
    parent.g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,2);//destination blend factor
    parent.g_pd3dDevice.SetStreamSource(0,parent.g_3DScene.TmpSur,0,24);
    parent.g_pd3dDevice.SetFVF(D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1);
    parent.g_pd3dDevice.SetTexture(0,self.Texture);
    //set transparency on texture
    parent.g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
    parent.g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
    parent.g_pd3dDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP,0,2);
    end;
   
end;

Procedure T3DParticleGenerator.LoadTexture(Filename:ansistring);
var s:ansistring;
begin
    s:=filename+#0#0#0;
    D3DXCreateTextureFromFile(parent.g_pd3dDevice,@s[1],self.texture);
end;

Procedure T3dItem.SetTextureSwap(id,newid:word);
begin
    inc(textswapcount);
    setlength(textswap,textswapcount);
    textswap[textswapcount-1]:=id+(newid*$10000);
end;

Procedure Tpikamap.LoadTopDome(TextureName:ansistring);
var newtex:tmemorystream;
begin
    newtex:=tmemorystream.Create;
    newtex.LoadFromFile(TextureName);
    newtex.Position:=0;
    if DomeTop = nil then begin
    DomeTop:=T3ditem.Create(linkedengine);
    DomeTop.LoadQ3Stream(@skydome[0],1300);
    DomeTop.SetProportion(1000,1000,1000);
    //if self.linkedengine.fogend > 0 then DomeTop.SetProportion(self.linkedengine.fogend/10.1,self.linkedengine.fogend/10.1,self.linkedengine.fogend/10.1);
    //DomeTop.Visible:=true;
    end;
    DomeTop.SetTexture(0,newtex);
    newtex.Free;
end;

Procedure Tpikamap.LoadBottomDome(TextureName:ansistring);
var newtex:tmemorystream;
begin
    newtex:=tmemorystream.Create;
    newtex.LoadFromFile(TextureName);
    newtex.Position:=0;
    if DomeBottom = nil then begin
    DomeBottom:=T3ditem.Create(linkedengine);
    DomeBottom.LoadQ3Stream(@SkyDome2[0],1300);
    DomeBottom.SetProportion(1000,1000,1000);
    //if self.linkedengine.fogend > 0 then DomeBottom.SetProportion(self.linkedengine.fogend/10.1,self.linkedengine.fogend/10.1,self.linkedengine.fogend/10.1);
    DomeBottom.SetRotation(0,180,0);
    //DomeBottom.Visible:=true;
    end;
    DomeBottom.SetTexture(0,newtex);
    newtex.Free;
end;

Function GetFile(FileName:ansistring;f:TMemoryStream):boolean;
begin
    result:=false;
    //f:=TMemoryStream.Create;
    if fileexists(Filename) then begin
        f.LoadFromFile(Filename);
        result:=true;
    end
    else begin
        if PikaGetFile(f,Filename,'data.ppk','Polar Battle'#0'ASDASDasdacdasjc')=0 then result:=true;
    end;
    f.Position:=0;
end;

Function TPikaEngine.GetViewMatrix:TD3DXMATRIX;
begin
    self.g_pd3dDevice.GetTransform(D3DTS_VIEW,result);
end;

Constructor T3DItem.Create(Engine:TPikaEngine);
begin
    inherited Create;//(true);
    cs:=tcriticalsection.Create;
    cs.Enter;
    if self <> nil then begin
    self.FrameCount:=0;
    self.rdy:=false;
    self.usealpha:=false;
    self.TextureCount:=0;
    self.Visible:=false;
    self.ProX:=1;
    self.ProY:=1;
    self.ProZ:=1;
    self.PosX:=0;
    rotationseq:=0;
    self.PosY:=0;
    textswapcount:=0;
    self.PosZ:=0;
    self.RH:=0;
    self.RV1:=0;
    Particles:=nil;
    isontop:=false;
    usematerial:=false;
    self.RV2:=0;
    self.srcalpha:=D3DBLEND_SRCALPHA;
    self.destalpha:=D3DBLEND_INVSRCALPHA;
    self.zwrite:=true;
    LOD:=0;
    self.COl:=$FFFFFF;
    self.isclone:=false;
    self.Alpha:=255;
    alwaysDraw := false;
    self.selframe:=0;
    self.texturename:=Tstringlist.create;
    self.g_3DScene:=Engine.g_3DScene;
    self.g_pd3dDevice:=engine.g_pd3dDevice;
    if g_3DScene <> nil then begin
    engine.g_3DScene.cs.enter;
    inc(Engine.g_3DScene.ItemsCount);
    setlength(Engine.ITZ,Engine.g_3DScene.ItemsCount);
    setlength(Engine.g_3DScene.items,Engine.g_3DScene.ItemsCount);
    Engine.g_3DScene.items[Engine.g_3DScene.ItemsCount-1]:=self;
    engine.g_3DScene.cs.leave;
    end;
    end;
    cs.Leave;
end;


Constructor TPikaSurface.Create(Engine:TPikaEngine);
begin
    inherited Create;//(true);
    if self <> nil then begin
    self.ProX:=1;
    self.ProY:=1;
    self.ProZ:=1;
    self.Texture:=nil;
    self.PosX:=0;
    self.PosY:=0;
    self.PosZ:=0;
    self.RH:=0;
    self.RV1:=0;
    self.tail:=false;
    AlphaSrc:=D3DBLEND_SRCALPHA;
    AlphaDest:=D3DBLEND_INVSRCALPHA;
    self.RV2:=0;
    self.Visible:=false;
    self.Locked:=true;
    self.VertexList[0].px:=-1;
    self.VertexList[0].pz:=0;
    self.VertexList[0].py:=1;
    self.VertexList[1].px:=1;
    self.VertexList[1].pz:=0;
    self.VertexList[1].py:=1;
    self.VertexList[2].px:=-1;
    self.VertexList[2].pz:=0;
    self.VertexList[2].py:=-1;
    self.VertexList[3].px:=1;
    self.VertexList[3].pz:=0;
    self.VertexList[3].py:=-1;
    self.VertexList[0].tu:=0;
    self.VertexList[1].tu:=1;
    self.VertexList[2].tu:=0;
    self.VertexList[3].tu:=1;
    self.VertexList[0].tv:=0;
    self.VertexList[1].tv:=0;
    self.VertexList[2].tv:=1;
    self.VertexList[3].tv:=1;

    self.Color:=$FFFFFFFF;
    self.g_3DScene:=Engine.g_3DScene;
    self.g_pd3dDevice:=engine.g_pd3dDevice;
    if g_3DScene <> nil then begin
    g_3DScene.cs.Enter;
    inc(Engine.g_3DScene.SurfaceCount);
    setlength(Engine.g_3DScene.Surface,Engine.g_3DScene.SurfaceCount);
    Engine.g_3DScene.Surface[Engine.g_3DScene.SurfaceCount-1]:=self;
    g_3DScene.cs.Leave;
    end;
    end;
end;

Destructor TPikaSurface.Free;
var x:integer;
begin
    if self.g_3DScene <> nil then begin
        for x:=0 to self.g_3DScene.SurfaceCount-1 do
            if self.g_3DScene.Surface[x] = self then break;
        if x < self.g_3DScene.SurfaceCount-1 then begin
            self.g_3DScene.Surface[x]:=self.g_3DScene.Surface[self.g_3DScene.SurfaceCount-1];
        end;
        dec(self.g_3DScene.SurfaceCount);
    end;
    inherited destroy;
end;

Destructor T3DItem.Free;
var x,y,z:integer;
begin
    if self.g_3DScene <> nil then begin
        g_3dscene.cs.enter;
        for x:=0 to self.g_3DScene.ItemsCount-1 do
            if self.g_3DScene.Items[x] = self then break;
        if x < self.g_3DScene.ItemsCount-1 then begin
            self.g_3DScene.Items[x]:=self.g_3DScene.Items[self.g_3DScene.ItemsCount-1];
        end;
        dec(self.g_3DScene.ItemsCount);
        g_3dscene.cs.leave;
    end;
    {if not self.isclone then begin
        if self.g_pVB <> nil then
        self.g_pVB._Release;
        try
        for x:=0 to texturecount-1 do
            self.Texture[x]._Release;
        except
        end;
        self.TextureName.Free;
        for x:=0 to self.FrameCount-1 do
        for y:=0 to self.frame[x].SectionCount-1 do begin
            for z:=0 to self.Frame[x].Section[y].IndexListCount-1 do
                self.Frame[x].Section[y].Indexs[z].g_pIB._Release;
        end;

    end;  }
    if isclone then begin
        self.g_pVB:=nil;
        self.Texture:=nil;
        self.TextureName:=nil;
        for x:=0 to self.FrameCount-1 do
        for y:=0 to self.frame[x].SectionCount-1 do begin
            if isclone then begin
            self.Frame[x].Section[y].VertexOrg:=nil;
            self.Frame[x].Section[y].Indexs:=nil;
            end else for z:=0 to self.Frame[x].Section[y].IndexListCount-1 do
                self.Frame[x].Section[y].Indexs[z].g_pIB:=nil;
        end;
    end;

    if Particles <> nil then begin
        Particles.Free;
        Particles:=nil;
    end;
    cs.Free;
    inherited destroy;
end;

Constructor TPikaMap.Create(Engin:TPikaEngine);
begin
    inherited Create;//(true);
    if self <> nil then begin
    //cs:=tcriticalsection.Create;
    //cs.Enter;
    self.scene:=Engin.g_3DScene;
    linkedengine:=engin;
    self.usealpha:=false;
    UseTextureSetting:=false;
    TextureSlideCount:=0;
    textureswapcount:=0;
    useGCsetting:=false;
    usematris:=false;
    self.g_pd3dDevice:=engin.g_pd3dDevice;
    self.DomeTop:=nil;
    self.DomeBottom:=nil;
    //cs.Leave;
    end;
end;

Destructor TPikaMap.Free;
var x:integer;
begin
    if self.scene <> nil then begin
        scene.cs.Enter;
        if self.scene.Map = self then self.scene.Map:=nil;
        scene.cs.Leave;
        if self.DomeTop<>nil then DomeTop.Free;
        if self.DomeBottom<>nil then DomeBottom.Free;
        DomeTop:=nil;
        DomeBottom:=nil;
        linkedengine:=nil;
    end;
    //cs.Free;
    inherited destroy;
end;

constructor TPikaEngine.Create(hWnd: HWND; sx,sy,fps:integer);
begin
    inherited Create;//(true);
    self.g_pD3D:=nil;
    self.g_pd3dDevice:=nil;
    self.g_3DScene:=T3DScene.Create;
    g_3DScene.cs:=tcriticalsection.Create;
    self.g_3DScene.Map:=nil;
    self.g_3DScene.ItemsCount:=0;
    self.g_3DScene.SurfaceCount:=0;
    currentclipping:=0;
    self.BGColor:=0;
    self.ViewDist:=0;
    fogimg:=nil;
    itemdistance:=0;
    fogend:=0;
    self.EyeX:=0;
    self.EyeZ:=0;
    Fogtick:=0;
    self.AlphaEnabledStatus:=false;
    self.isAntialising:=false;
    self.LightEnabledStatus:=false;
    TextCount:=0;
    self.isMirrored:=false;
    self.enable:=InitD3D(hWnd,sx,sy,fps);
end;

Procedure TPikaEngine.SetProjection(ProX,ProY,ScaleX,ScaleY,ScaleZ:single);
var matProj: TD3DMatrix;
begin
    FilLChar(matProj, SizeOf(matProj), 0);
  matProj._11 :=  prox;
  matProj._22 :=  proy;
  matProj._33 :=  scalex;
  matProj._34 :=  scaley;
  matProj._43 :=  scalez;
  g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
end;

function TPikaEngine.InitD3D(hWnd: HWND; sx,sy,fps:integer): boolean;
var
  d3dpp: TD3DPresentParameters;
  vp: TD3DViewport9;
  mtrl: TD3DMaterial9;
  matProj,matview: TD3DMatrix;
  tm:tmemorystream;
  hh:td3dximageinfo;
begin
  Result:= false;//set to fail 1st

  //create D3D object
  g_pD3D := Direct3DCreate9(D3D_SDK_VERSION);
  if (g_pD3D = nil) then Exit;
  ViewDist:=0;
  // Set up the structure used to create the D3DDevice
  FillChar(d3dpp, SizeOf(d3dpp), 0);
  d3dpp.Windowed := true;
  d3dpp.SwapEffect := D3DSWAPEFFECT_DISCARD;
  d3dpp.BackBufferFormat := D3DFMT_UNKNOWN;
  if fps = 0 then d3dpp.PresentationInterval:=D3DPRESENT_INTERVAL_IMMEDIATE;
  if fps = 1 then d3dpp.PresentationInterval:=D3DPRESENT_INTERVAL_ONE;
  if fps = 2 then d3dpp.PresentationInterval:=D3DPRESENT_INTERVAL_TWO;
  if fps = 3 then d3dpp.PresentationInterval:=D3DPRESENT_INTERVAL_ThREE;

  //used for back buffer
  d3dpp.EnableAutoDepthStencil:=true;
  d3dpp.AutoDepthStencilFormat := D3DFMT_D16;
  // Create the D3DDevice
  if FAILED(g_pD3D.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd,
                               D3DCREATE_HARDWARE_VERTEXPROCESSING,
                               @d3dpp, g_pd3dDevice)) then
    if FAILED(g_pD3D.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd,
                               D3DCREATE_MiXED_VERTEXPROCESSING,
                               @d3dpp, g_pd3dDevice)) then  
     if FAILED(g_pD3D.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd,
                               D3DCREATE_SOFTWARE_VERTEXPROCESSING,
                               @d3dpp, g_pd3dDevice)) then exit;


  if failed(self.g_pd3dDevice.CreateVertexBuffer(4*24
                        ,0,D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1,D3DPOOL_DEFAULT
                        ,self.g_3DScene.tmpsur ,0)) then exit;

  FillChar(vp, SizeOf(vp), 0);
  vp.X := 0;
  vp.Y := 0;
  vp.Width := sx;
  vp.Height := sy;
  vp.MinZ := 0.0;
  vp.MaxZ := 1.0;
  g_pd3dDevice.SetViewport(vp);


  FillChar(mtrl, SizeOf(mtrl), 0);
  mtrl.ambient.r := 1.0;
  mtrl.ambient.g := 1.0;
  mtrl.ambient.b := 1.0;
  mtrl.diffuse.r := 1.0;
  mtrl.diffuse.g := 1.0;
  mtrl.diffuse.b := 1.0;
  mtrl.diffuse.a := 1.0;
  g_pd3dDevice.SetMaterial( mtrl );

  FilLChar(matProj, SizeOf(matProj), 0);
  matProj._11 :=  2.0;
  matProj._22 :=  2.0;
  matProj._33 :=  1.0;
  matProj._34 :=  1.0;
  matProj._43 :=  -1.0;
  g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );

  FilLChar(matView, SizeOf(matView), 0);
  matView._11 := 1;
  matView._22 := 1;
  matView._23 := 0.15;
  matView._32 := 0.2;
  matView._33 := 0.2;
  matView._43 := 19.0;
  matView._44 := 1.0;
  g_pd3dDevice.SetTransform( D3DTS_VIEW, matView);

  g_pd3dDevice.SetRenderState(D3DRS_LIGHTING, iFalse);
  g_pd3dDevice.SetRenderState( D3DRS_AMBIENT, $FFFFFFFF);
  g_pd3dDevice.SetRenderState(D3DRS_ZENABLE,D3DZB_TRUE);
  g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);

  //g_pd3dDevice.SetRenderState(D3DRS_Zfunc,D3DCMP_LESS );

  // double sided!
  g_pd3dDevice.SetRenderState(D3DRS_CULLMODE, D3DCULL_NONE);

  D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,100000);
  g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
  itemdistance:=0;

    {//MakeShader(void) {
	if D3DXAssembleShaderFromFile('c:\toon.vsh',nil,nil,0,@pcode,nil) =  D3D_ok then
	g_pd3dDevice.CreateVertexShader(pCode.GetBufferPointer,
	      g_shader );
	g_pd3dDevice.SetVertexShader( g_shader );      }


//}

  Result:= true;
end;

Procedure TPikaEngine.SetPointLight(id:integer;COLOR:Dword;dx,dy,dz,range,ate:single);
var Light:d3dlight9;
begin
    g_pd3dDevice.SetRenderState(D3DRS_LIGHTING, itrue);
    fillchar(light,sizeof(light),0);
    light._Type:=D3DLIGHT_POINT;
    light.Diffuse.r:=(color and 255)/255;
    light.Diffuse.g:=((color div 256) and 255)/255;
    light.Diffuse.b:=((color div $10000) and 255)/255;
    light.Diffuse.a:=((color div $1000000) and 255)/255;
    light.Ambient.r:=0.5;
    light.Ambient.g:=0.5;
    light.Ambient.b:=0.5;
    light.Position.x:=dx;
    light.Position.y:=dy;
    light.Position.z:=dz;
    light.Range:=range;
    light.Attenuation0:=ate;
    light.Attenuation2:=0;
    light.Attenuation1:=0;

    self.g_pd3dDevice.SetLight(id,light);
    self.g_pd3dDevice.LightEnable(id,true);
end;

Function getmappos(mot:array of Tpikapos;count,maxframe:integer;speed:dword):tpikavector;
var x,p1,p2,i:integer;
    frame:dword;
    r:word;
    c:integer;
begin
    p1:=-1;
    p2:=count;
    frame:=gettickcount mod speed;
    frame:=frame div (speed div maxframe);
    for x:=0 to count-1 do begin
        if (mot[x].id <= frame) and (x>p1) then p1:=x;
        if (mot[x].id >=frame) and (x<p2) then
            p2:=x;
    end;

    if (mot[p1].id < frame) and (p2 < count) then begin
        i:=mot[p2].id-mot[p1].id;
        result.x:=mot[p1].pos[0]+(((mot[p2].pos[0]-mot[p1].pos[0])/i)*(frame-mot[p1].id));
        result.y:=mot[p1].pos[1]+(((mot[p2].pos[1]-mot[p1].pos[1])/i)*(frame-mot[p1].id));
        result.z:=mot[p1].pos[2]+(((mot[p2].pos[2]-mot[p1].pos[2])/i)*(frame-mot[p1].id));
    end else begin
        move(mot[p1].pos[0],result,12);
    end;
end;

Function getmaprotation(mot:array of Tpikaang;count,maxframe:integer;speed:dword):tpikavector;
var x,p1,p2,i:integer;
    frame:dword;
    r:word;
    c:integer;
begin
    p1:=-1;
    p2:=count;
    frame:=gettickcount mod speed;
    frame:=frame div (speed div maxframe);
    for x:=0 to count-1 do begin
        if (mot[x].id <= frame) and (x>p1) then p1:=x;
        if (mot[x].id >=frame) and (x<p2) then
            p2:=x;
    end;

    if (mot[p1].id < frame) and (p2 < count) then begin
        i:=mot[p2].id-mot[p1].id;
        r:=word(mot[p2].ang[0])-word(mot[p1].ang[0]);
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(frame-mot[p1].id)) div i;
            result.x:=word(word(mot[p1].ang[0])+c)/10430.378350;
        end else begin
            c:=(integer(r)*(frame-mot[p1].id)) div i;
            result.x:=word(word(mot[p1].ang[0])+c)/10430.378350;
        end;

        r:=word(mot[p2].ang[1])-word(mot[p1].ang[1]);
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(frame-mot[p1].id)) div i;
            result.y:=word(word(mot[p1].ang[1])+c)/10430.378350;
        end else begin
            c:=(integer(r)*(frame-mot[p1].id)) div i;
            result.y:=word(word(mot[p1].ang[1])+c)/10430.378350;
        end;

        r:=word(mot[p2].ang[2])-word(mot[p1].ang[2]);
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(frame-mot[p1].id)) div i;
            result.z:=word(word(mot[p1].ang[2])+c)/10430.378350;
        end else begin
            c:=(integer(r)*(frame-mot[p1].id)) div i;
            result.z:=word(word(mot[p1].ang[2])+c)/10430.378350;
        end;


    end else begin
        result.x:=(word(mot[p1].ang[0]))/10430.378350;
        result.y:=(word(mot[p1].ang[1]))/10430.378350;
        result.z:=(word(mot[p1].ang[2]))/10430.378350;
    end;

end;

Procedure TPikaEngine.SetDirectionalLight(id:integer;COLOR:Dword;dx,dy,dz:single);
var Light:d3dlight9;
    vec:TD3DXVECTOR3;
begin
    g_pd3dDevice.SetRenderState(D3DRS_LIGHTING, itrue);
    fillchar(light,sizeof(light),0);
    light._Type:=D3DLIGHT_DIRECTIONAL;
    light.Diffuse.r:=(color and 255)/255;
    light.Diffuse.g:=((color div 256) and 255)/255;
    light.Diffuse.b:=((color div $10000) and 255)/255;
    light.Diffuse.a:=((color div $1000000) and 255)/255;
    {light.Ambient.r:=0.5;
    light.Ambient.g:=0.5;
    light.Ambient.b:=0.5;  }
    D3DXVec3Normalize(vec,D3DXVECTOR3(dx,dy,dz));
    light.Direction.x:=vec.x;
    light.Direction.y:=vec.y;
    light.Direction.z:=vec.z;

    self.g_pd3dDevice.SetLight(id,light);
    self.g_pd3dDevice.LightEnable(id,true);
end;

Procedure TPikaEngine.RenderSurface;
var l,x,y,i,p,c,sp,z,lt,itzc,itzp,pp,y2:integer;
    //ZBuf:array[-1..12000,0..4] of dword;
    //ITZ:array of TItemBuf;
    le:boolean;
    amb:dword;
    matProj:td3dmatrix;
    matworld,matRotX,matRoty,matRotz,ma,matTrans,matscale:td3dmatrix;
    d:single;
    tmpmat:td3dmaterial9;
    tmp:tpikavector;
    mt:integer;
    doesmove:boolean;
begin
    //clear the image
    g_3DScene.cs.Enter;
    try
      g_pd3dDevice.Clear(0, nil, D3DCLEAR_TARGET or D3DCLEAR_ZBUFFER , BGColor, 1.0, 0);
      asm FINIT end;
      if SUCCEEDED(g_pd3dDevice.BeginScene) then begin

        g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
        g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,D3DBLEND_SRCALPHA);//source blend factor
        g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,D3DBLEND_INVSRCALPHA);//destination blend factor
        g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);//enable zwrite


        //draw all the opaque area
        if g_3DScene.Map <> nil then
        if g_3DScene.Map.visible then begin
        //skydome      asdasd
          if fogend>0 then begin
              g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,ifalse);
              D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,100000);
              g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
          end;
          if g_3DScene.Map.DomeTop <> nil then g_3DScene.Map.DomeTop.Render(0,0);
          if g_3DScene.Map.DomeBottom <> nil then g_3DScene.Map.DomeBottom.Render(0,0);
          if fogend>0 then begin
            g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,itrue);
            if currentclipping > 0 then begin
              D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,currentclipping);
              g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
            end;
          end;
          for l:=0 to g_3DScene.Map.AreaCount-1 do begin
              //get the distance
              if ViewDist > 0 then
                  d:=round(sqrt(sqr(g_3DScene.Map.Area[l].BaseX-EyeX)+
                      sqr(g_3DScene.Map.Area[l].BaseZ-EyeZ)))
              else d:=0;
              if d <= ViewDist then begin
                  if g_3DScene.Map.usematris then
                      g_pd3dDevice.setTransform(D3DTS_WORLD,g_3DScene.Map.Area[l].Matrix);
                  for x:=0 to g_3DScene.Map.Area[l].GroupeA_Count-1 do begin
                      //set the buffer and information
                      g_pd3dDevice.SetStreamSource(0, g_3DScene.Map.Area[l].GroupeA[x].g_pVB, 0, g_3DScene.Map.Area[l].GroupeA[x].VertexSize);
                      g_pd3dDevice.SetFVF(g_3DScene.Map.Area[l].GroupeA[x].VertexType);

                      doesmove:=false;
                      if g_3DScene.Map.Area[l].GroupeA[x].textslideid = -1 then
                          g_pd3dDevice.SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS,D3DTTFF_DISABLE )
                      else begin
                          for p:=0 to g_3DScene.Map.TextureSlideCount-1 do begin
                              if g_3DScene.Map.Area[l].GroupeA[x].textslideid = g_3DScene.Map.TextureSlide[p].id then begin
                                  D3DXMatrixIdentity(mattrans);
                                  //fillchar(mattrans,sizeof(mattrans),0);
                                  mattrans._31:=g_3DScene.Map.TextureSlide[p].tu*(gettickcount / 6000);
                                  mattrans._32:=g_3DScene.Map.TextureSlide[p].tv*(gettickcount / 6000);
                                  doesmove:=true;

                                  g_pd3dDevice.SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS,D3DTTFF_COUNT2 );
                                  g_pd3dDevice.SetTransform( D3DTS_TEXTURE0, matTrans );

                              end;
                          end;
                      end;


                      for y:=0 to g_3DScene.Map.Area[l].GroupeA[x].IndexListCount-1 do
                          if g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].IndexCount>2 then begin
                          if g_3DScene.Map.usematris then
                              g_pd3dDevice.setTransform(D3DTS_WORLD,g_3DScene.Map.Area[l].Matrix);
                          if g_3DScene.Map.Area[l].GroupeA[x].usemotion then begin

                          //apply the matrix
                          if g_3DScene.Map.Area[l].Groupea[x].motionangcount > 0 then
                              tmp:=getmaprotation(g_3DScene.Map.Area[l].Groupea[x].motionang,g_3DScene.Map.Area[l].Groupea[x].motionangcount,
                                  g_3DScene.Map.Area[l].Groupea[x].motionframe,g_3DScene.Map.Area[l].Groupea[x].motiontime)
                          else tmp:=pikavector(g_3DScene.Map.Area[l].Groupea[x].defaultrot[0] /10430.378350,
                              g_3DScene.Map.Area[l].Groupea[x].defaultrot[1] /10430.378350,
                              g_3DScene.Map.Area[l].Groupea[x].defaultrot[2] /10430.378350);
                          D3DXMatrixRotationX( matRotX, tmp.x );        // Pitch
                          D3DXMatrixRotationY( matRotY, tmp.y);        // Yaw
                          D3DXMatrixRotationZ( matRotZ, tmp.z);        // Roll

                          // Calculate a translation matrix
                          if g_3DScene.Map.Area[l].Groupea[x].motionposcount > 0 then
                              tmp:=getmappos(g_3DScene.Map.Area[l].Groupea[x].motionpos,g_3DScene.Map.Area[l].Groupea[x].motionposcount,
                                  g_3DScene.Map.Area[l].Groupea[x].motionframe,g_3DScene.Map.Area[l].Groupea[x].motiontime)
                          else tmp:=pikavector(g_3DScene.Map.Area[l].GroupeA[x].defaultpos[0]
                              ,g_3DScene.Map.Area[l].GroupeA[x].defaultpos[1],g_3DScene.Map.Area[l].GroupeA[x].defaultpos[2]);
                          D3DXMatrixTranslation(matTrans,tmp.x,tmp.y,tmp.z);

                          if g_3DScene.Map.Area[l].Groupea[x].motionscalecount > 0 then
                              tmp:=getmappos(g_3DScene.Map.Area[l].Groupea[x].motionsca,g_3DScene.Map.Area[l].Groupea[x].motionscalecount,
                                  g_3DScene.Map.Area[l].Groupea[x].motionframe,g_3DScene.Map.Area[l].Groupea[x].motiontime)
                          else tmp:=pikavector(g_3DScene.Map.Area[l].GroupeA[x].defaultscale[0]
                              ,g_3DScene.Map.Area[l].GroupeA[x].defaultscale[1],g_3DScene.Map.Area[l].GroupeA[x].defaultscale[2]);
                          D3DXMatrixScaling(matScale,tmp.x,tmp.y,tmp.z);
                                              

                          //ma:=(matRotX*matRotY*matRotZ)*matTrans;
                          D3DXMatrixMultiply(ma,matscale,matRotX);
                          D3DXMatrixMultiply(ma,ma,matRotY);
                          D3DXMatrixMultiply(ma,ma,matRotz);
                          D3DXMatrixMultiply(ma,ma,matTrans);
                          D3DXMatrixMultiply(ma,ma,g_3DScene.Map.Area[l].Matrix);

                          g_pd3dDevice.setTransform(D3DTS_WORLD,ma);
                          end;


                          //set the index list
                          g_pd3dDevice.SetIndices(g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].g_pIB);
                          //set the texture
                          if (g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].TextureID < g_3DScene.Map.TextureCount) and (g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].TextureID>-1) then
                              begin
                                  mt:=g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].TextureID;

                                  for p:=0 to g_3DScene.Map.TextureSwapCount-1 do
                                      if g_3DScene.Map.TextureSwap[p].id = g_3DScene.Map.Area[l].Groupea[x].textswapid then begin
                                          i:=(gettickcount div 60) mod g_3DScene.Map.TextureSwap[p].maxframe;
                                          mt:=-1;
                                          while i >= 0 do begin
                                              inc(mt);
                                              dec(i,g_3DScene.Map.TextureSwap[p].entry[mt].frame);
                                          end;
                                          mt:=g_3DScene.Map.TextureSwap[p].entry[mt].newid;
                                      end;
                                  g_pd3dDevice.SetTexture( 0, g_3DScene.map.Texture[mt] );
                              end
                          else g_pd3dDevice.SetTexture( 0, nil );
                          if self.g_3DScene.Map.UseTextureSetting then begin
                              g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSU,g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].tus);
                              g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSV,g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].tvs);
                              if doesmove then begin
                                  g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSU,1);
                                  g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSV,1);
                              end;
                          end;
                          if self.g_3DScene.Map.UseGCSetting then begin
                              g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,g_3DScene.Map.Area[l].Groupea[x].Indexs[y].Alphasrc+1);//source blend factor
                              g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,g_3DScene.Map.Area[l].Groupea[x].Indexs[y].Alphadst+1);//destination blend factor
                              g_pd3dDevice.DrawIndexedPrimitive(g_3DScene.map.Area[l].GroupeA[x].Indexs[y].SType,0,0,
                              g_3DScene.Map.Area[l].GroupeA[x].VertexCount,0,g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].SurfaceCount)
                          end else
                          g_pd3dDevice.DrawIndexedPrimitive(g_3DScene.map.Area[l].GroupeA[x].SurfaceType,0,0,
                              g_3DScene.Map.Area[l].GroupeA[x].VertexCount,0,g_3DScene.Map.Area[l].GroupeA[x].Indexs[y].SurfaceCount);
                      end;
                  end;
              end;
          end;
        end;

        SetMirroredTexture(ismirrored);
        g_pd3dDevice.SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS,D3DTTFF_DISABLE );


        itzc:=0;
        itzp:=0;
        for l:=0 to self.g_3DScene.ItemsCount-1 do
          if self.g_3DScene.Items[l].isready then
          if self.g_3DScene.Items[l].Visible then
          if self.g_3DScene.Items[l].zwrite and (self.g_3DScene.Items[l].Alpha = 255) then begin
              if itemdistance > 0 then
              d:=sqrt(sqr(self.g_3DScene.Items[l].posx-EyeX)+
                  sqr(self.g_3DScene.Items[l].posz-EyeZ))
              else d:=0;
              if (d <= itemdistance) or self.g_3DScene.Items[l].alwaysDraw then begin
                  self.g_3DScene.Items[l].Render(0,round(fogend));
              end;
          end else begin
              if g_3DScene.Items[l].isOnTop then begin
                  d:=-1;
              end else
              d:=sqrt(sqr(self.g_3DScene.Items[l].posx-EyeX)+
                  sqr(self.g_3DScene.Items[l].posz-EyeZ));

              //sort by distance
              y:=0;
              for i:=0 to itzc-1 do
                  if itz[y].dist < d then break
                  else if i < itzc-1 then
                      y:=itz[y].next;

              if (itzc = 0) or (i = itzc) then begin
                  itz[itzc].id:=l;
                  itz[itzc].dist:=d;
                  itz[y].next:=itzc;
              end else begin
                  itz[itzc].id:=itz[y].id;
                  itz[itzc].dist:=itz[y].dist;
                  itz[itzc].next:=itz[y].next;
                  itz[y].id:=l;
                  itz[y].dist:=d;
                  itz[y].next:=itzc;
              end;

              inc(itzc);
          end;
        amb:=self.AmbientLightColor;
        AmbientLightColor:=$FFFFFFFF;
        le:=LightEnabled;
        if le then
            LightEnabled:=false;
        for l:=0 to self.g_3DScene.SurfaceCount-1 do
            if self.g_3DScene.Surface[l].Visible then
            if not self.g_3DScene.Surface[l].overall then
            self.g_3DScene.Surface[l].Render;
        if le then LightEnabled:=true;
        AmbientLightColor:=amb;



        if g_3DScene.Map <> nil then
          if g_3DScene.Map.visible then begin
          //draw all the transparent area
          //sort the transparent surface by distance
          p:=0;
          zbuf[p,4]:=0;
          sp:=0;
          lt:=0;
          for l:=0 to g_3DScene.Map.AreaCount-1 do begin
              //get the distance
              if ViewDist > 0 then
                  d:=round(sqrt(sqr(g_3DScene.Map.Area[l].BaseX-EyeX)+
                      sqr(g_3DScene.Map.Area[l].BaseZ-EyeZ)))
              else d:=0;
              if d <= ViewDist then
              for x:=0 to g_3DScene.Map.Area[l].GroupeB_Count-1 do begin
                  if g_3DScene.Map.Area[l].GroupeB[x].IndexListCount>0 then begin
                  //for y:=0 to g_3DScene.Map.Area[l].GroupeB[x].IndexListCount-1 do
                  //if g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].IndexCount>2 then begin
                      d:=round(sqrt(sqr(g_3DScene.Map.Area[l].GroupeB[x].Indexs[0].RefX-EyeX)+
                          sqr(g_3DScene.Map.Area[l].GroupeB[x].Indexs[0].RefZ-EyeZ)))*100;
                     y:=0;

                     i:=0;
                      //if (d <=viewdist) or (viewdist = 0) then
                      if p < 12000 then begin
                      c:=sp;
                      z:=sp;
                      for i:=0 to p-1 do begin
                          if zbuf[c,3] < d then begin
                              if c = sp then sp:=p;
                              zbuf[p,0]:=l;
                              zbuf[p,1]:=x;
                              zbuf[p,2]:=y;
                              zbuf[p,3]:=round(d);
                              zbuf[p,4]:=c;
                              if sp <> p then
                                  zbuf[z,4]:=p;
                              break;
                          end;
                          z:=c;
                          c:=zbuf[c,4];
                      end;
                      if (i = p) or (p = 0) then begin
                          zbuf[p,0]:=l;
                          zbuf[p,1]:=x;
                          zbuf[p,2]:=y;
                          zbuf[p,3]:=round(d);
                          zbuf[p,4]:=0;
                          zbuf[z,4]:=p;
                      end;
                      inc(p);
                      zbuf[p,4]:=0;


                      end;
                  end;
              end;
          end;
          c:=sp;
          i:=-1;
          //g_pd3dDevice.GetMaterial(tmpmat);

            for z:=0 to p-1 do begin

                l:=ZBuf[c,0];
                x:=ZBuf[c,1];
                //y:=ZBuf[c,2];
                if g_3DScene.Map.usematris then
                        g_pd3dDevice.setTransform(D3DTS_WORLD,g_3DScene.Map.Area[l].Matrix);
                doesmove:=false;
                g_pd3dDevice.SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS,D3DTTFF_DISABLE );
                if g_3DScene.Map.Area[l].Groupeb[x].textslideid > -1 then begin
                            for pp:=0 to g_3DScene.Map.TextureSlideCount-1 do begin
                                if g_3DScene.Map.Area[l].Groupeb[x].textslideid = g_3DScene.Map.TextureSlide[pp].id then begin
                                    D3DXMatrixIdentity(mattrans);
                                    mattrans._31:=g_3DScene.Map.TextureSlide[pp].tu*(gettickcount / 6000);
                                    mattrans._32:=g_3DScene.Map.TextureSlide[pp].tv*(gettickcount / 6000);
                                    doesmove:=true;
                                    g_pd3dDevice.SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS,D3DTTFF_COUNT2 );
                                    g_pd3dDevice.SetTransform( D3DTS_TEXTURE0, matTrans );

                                end;
                            end;
                        end;

                if g_3DScene.Map.Area[l].Groupeb[x].usemotion then begin

                    //apply the matrix
                    if g_3DScene.Map.Area[l].Groupeb[x].motionangcount > 0 then
                    tmp:=getmaprotation(g_3DScene.Map.Area[l].Groupeb[x].motionang,g_3DScene.Map.Area[l].Groupeb[x].motionangcount,
                        g_3DScene.Map.Area[l].Groupeb[x].motionframe,g_3DScene.Map.Area[l].Groupeb[x].motiontime)
                    else tmp:=pikavector(g_3DScene.Map.Area[l].Groupeb[x].defaultrot[0] /10430.378350,
                        g_3DScene.Map.Area[l].Groupeb[x].defaultrot[1] /10430.378350,
                        g_3DScene.Map.Area[l].Groupeb[x].defaultrot[2] /10430.378350);
                    D3DXMatrixRotationX( matRotX, tmp.x );        // Pitch
                    D3DXMatrixRotationY( matRotY, tmp.y);        // Yaw
                    D3DXMatrixRotationZ( matRotZ, tmp.z);        // Roll

            
                    // Calculate a translation matrix            adad
                    if g_3DScene.Map.Area[l].Groupeb[x].motionposcount > 0 then
                                tmp:=getmappos(g_3DScene.Map.Area[l].Groupeb[x].motionpos,g_3DScene.Map.Area[l].Groupeb[x].motionposcount,
                                    g_3DScene.Map.Area[l].Groupeb[x].motionframe,g_3DScene.Map.Area[l].Groupeb[x].motiontime)
                    else tmp:=pikavector(g_3DScene.Map.Area[l].Groupeb[x].defaultpos[0]
                                ,g_3DScene.Map.Area[l].Groupeb[x].defaultpos[1],g_3DScene.Map.Area[l].Groupeb[x].defaultpos[2]);
                    D3DXMatrixTranslation(matTrans,tmp.x,tmp.y,tmp.z);

                    if g_3DScene.Map.Area[l].Groupeb[x].motionscalecount > 0 then
                                tmp:=getmappos(g_3DScene.Map.Area[l].Groupeb[x].motionsca,g_3DScene.Map.Area[l].Groupeb[x].motionscalecount,
                                    g_3DScene.Map.Area[l].Groupeb[x].motionframe,g_3DScene.Map.Area[l].Groupeb[x].motiontime)
                    else tmp:=pikavector(g_3DScene.Map.Area[l].Groupeb[x].defaultscale[0]
                                ,g_3DScene.Map.Area[l].Groupeb[x].defaultscale[1],g_3DScene.Map.Area[l].Groupeb[x].defaultscale[2]);
                    D3DXMatrixScaling(matScale,tmp.x,tmp.y,tmp.z);


                    //ma:=(matRotX*matRotY*matRotZ)*matTrans;
                    D3DXMatrixMultiply(ma,matscale,matRotX);
                    D3DXMatrixMultiply(ma,ma,matRotY);
                    D3DXMatrixMultiply(ma,ma,matRotz);
                    D3DXMatrixMultiply(ma,ma,matTrans);
                    D3DXMatrixMultiply(ma,ma,g_3DScene.Map.Area[l].Matrix);
                    g_pd3dDevice.setTransform(D3DTS_WORLD,ma);
                end;

              for y:=0 to g_3DScene.Map.Area[l].GroupeB[x].IndexListCount-1 do begin
                //set the vertex list
                if (i=-1) or (l <> ZBuf[i,0]) or (x <> ZBuf[i,1])  then begin
                    g_pd3dDevice.SetStreamSource(0, g_3DScene.Map.Area[l].GroupeB[x].g_pVB, 0, g_3DScene.Map.Area[l].GroupeB[x].VertexSize);
                    g_pd3dDevice.SetFVF(g_3DScene.Map.Area[l].GroupeB[x].VertexType);
                end;
                //set the index list
                g_pd3dDevice.SetIndices(g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].g_pIB);
                //set the texture
                if (g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].TextureID < g_3DScene.Map.TextureCount) and (g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].TextureID>-1) then begin

                    mt:=g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].TextureID;
                    for pp:=0 to g_3DScene.Map.TextureSwapCount-1 do
                        if g_3DScene.Map.TextureSwap[pp].id = g_3DScene.Map.Area[l].GroupeB[x].textswapid then begin
                        y2 := 0;
                        if g_3DScene.Map.TextureSwap[pp].maxframe > 0 then y2:=(gettickcount div 60) mod g_3DScene.Map.TextureSwap[pp].maxframe;
                        mt:=-1;
                        while y2 >= 0 do begin
                            inc(mt);
                            dec(y2,g_3DScene.Map.TextureSwap[pp].entry[mt].frame);
                        end;
                        mt:=g_3DScene.Map.TextureSwap[pp].entry[mt].newid;
                        end;
                    g_pd3dDevice.SetTexture( 0, g_3DScene.map.Texture[mt] );


                end else g_pd3dDevice.SetTexture( 0, nil );
                //set transparency
                SetTextureAlphaSource(0,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].AlphaSource);
                if (g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].AlphaDst <> 1) and (g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].AlphaDst <> 3) then begin
                        g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);
                        if fogend>0 then g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,itrue);
                end else begin g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,iFalse);
                    if fogend>0 then g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,ifalse);
                end;


               // if g_3DScene.Map.usematerial then g_pd3dDevice.SetMaterial(g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].material);
                if self.g_3DScene.Map.UseTextureSetting then begin
                    g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSU,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].tus);
                    g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSV,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].tvs);
                    if doesmove then begin
                        g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSU,1);
                        g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSV,1);
                    end;
                end;


                g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].AlphaSrc+1);//source blend factor
                g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].AlphaDst+1);//destination blend factor

                if self.g_3DScene.Map.UseGCSetting then
                g_pd3dDevice.DrawIndexedPrimitive(g_3DScene.map.Area[l].GroupeB[x].indexs[y].SType,0,0,
                                g_3DScene.Map.Area[l].GroupeB[x].VertexCount,0,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].SurfaceCount)
                else
                g_pd3dDevice.DrawIndexedPrimitive(g_3DScene.map.Area[l].GroupeB[x].SurfaceType,0,0,
                                g_3DScene.Map.Area[l].GroupeB[x].VertexCount,0,g_3DScene.Map.Area[l].GroupeB[x].Indexs[y].SurfaceCount);


              end;
              i:=c;
              c:=ZBuf[c,4];
          end;

        end;

        SetMirroredTexture(ismirrored);
        g_pd3dDevice.SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS,D3DTTFF_DISABLE );
        //g_pd3dDevice.SetMaterial(tmpmat);

        l:=0;
        for y:=0 to itzc-1 do begin
          if self.g_3DScene.Items[itz[l].id].isready then
            if self.g_3DScene.Items[itz[l].id].Visible then begin
                g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);
                if (itz[l].dist <= itemdistance) or (itemdistance = 0) then
                    self.g_3DScene.Items[itz[l].id].Render(0,round(fogend));
            end;
            l:=itz[l].next;
        end;


        g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);
        //g_pd3dDevice.SetRenderState(D3DRS_ZENABLE,D3DZB_TRUE );


        //fog draw
        if fogtick > 0 then DrawFog;


        for l:=0 to textcount-1 do
          if textdata[l].over = 0 then
          self.tp.DrawTextA(nil,@textdata[l].text[1],length(textdata[l].text),@textdata[l].rect,DT_LEFT,textdata[l].color);


        amb:=self.AmbientLightColor;
        AmbientLightColor:=$FFFFFFFF;
        le:=LightEnabled;
        if le then
            LightEnabled:=false;
        for l:=0 to self.g_3DScene.SurfaceCount-1 do
            if self.g_3DScene.Surface[l].Visible then
            if self.g_3DScene.Surface[l].overall then
            self.g_3DScene.Surface[l].Render;
        if le then LightEnabled:=true;
        AmbientLightColor:=amb;

        for l:=0 to textcount-1 do
            if textdata[l].over = 1 then
            if length(textdata[l].text) > 0 then
            self.tp.DrawTextA(nil,@textdata[l].text[1],length(textdata[l].text),@textdata[l].rect,DT_LEFT,textdata[l].color);

        g_pd3dDevice.EndScene;
        textcount:=0;
        asm FINIT end;
        //flip the screen
        g_pd3dDevice.Present(nil, nil, 0, nil);
      end;
    finally
      g_3DScene.cs.Leave;
    end;
end;

Procedure TPikaEngine.EnableAlpha(status:boolean);
begin
    if g_pd3dDevice <> nil then begin
        AlphaEnabledStatus:=status;
        g_pd3dDevice.SetRenderState(D3DRS_ALPHABLENDENABLE, ord(status));
        g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,D3DBLEND_SRCALPHA);//source blend factor
        g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,D3DBLEND_INVSRCALPHA);//destination blend factor
    end;
end;

Procedure TPikaEngine.EnableLight(status:boolean);
begin
    if g_pd3dDevice <> nil then begin
        g_pd3dDevice.SetRenderState(D3DRS_LIGHTING, ord(status));
        LightEnabledStatus:=status;
    end;
end;

Procedure TPikaEngine.SetViewDistance(Dist:integer);
begin
    if g_pd3dDevice <> nil then begin
        ViewDist:=Dist;
    end;
end;

Procedure TPikaEngine.SetAlphaTest(min:integer);
begin
    if g_pd3dDevice <> nil then begin
        g_pd3dDevice.SetRenderState(D3DRS_ALPHAFUNC, D3DCMP_GREATEREQUAL);
        g_pd3dDevice.SetRenderState(D3DRS_ALPHAREF, min);
        g_pd3dDevice.SetRenderState(D3DRS_ALPHATESTENABLE, iTRUE);
    end;
end;

{
    D3DBLEND_ZERO = 1,
    D3DBLEND_ONE = 2,
    D3DBLEND_SRCCOLOR = 3,
    D3DBLEND_INVSRCCOLOR = 4,
    D3DBLEND_SRCALPHA = 5,
    D3DBLEND_INVSRCALPHA = 6,
    D3DBLEND_DESTALPHA = 7,
    D3DBLEND_INVDESTALPHA = 8,
    D3DBLEND_DESTCOLOR = 9,
    D3DBLEND_INVDESTCOLOR = 10,
    D3DBLEND_SRCALPHASAT = 11,
    D3DBLEND_BOTHSRCALPHA = 12,
    D3DBLEND_BOTHINVSRCALPHA = 13,
    D3DBLEND_BLENDFACTOR = 14,
    D3DBLEND_INVBLENDFACTOR = 15,
    D3DBLEND_SRCCOLOR2 = 16,
    D3DBLEND_INVSRCCOLOR2 = 17,
    D3DBLEND_FORCE_DWORD = 0x7fffffff,
}

Procedure TPikaEngine.SetAlphaSource(src:integer);
begin
    if g_pd3dDevice <> nil then begin
        AlphaSrcMode:=src;
        g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,src);//source blend factor
    end;
end;

Procedure TPikaEngine.SetAlphaDest(dst:integer);
begin
    if g_pd3dDevice <> nil then begin
        AlphaDstMode:=dst;
        g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,dst);//destination blend factor
    end;
end;

Procedure TPikaEngine.SetAmbiantLight(color:dword);
begin
    if g_pd3dDevice <> nil then begin
        AmbColor:=color;
        g_pd3dDevice.SetRenderState( D3DRS_AMBIENT, color);
    end;
end;

{
    stage = the curent texture
    source are:
    D3DTA_TEXTURE
    D3DTA_DIFFUSE
}
Procedure TPikaEngine.SetTextureAlphaSource(Stage,src:dword);
begin
    if g_pd3dDevice <> nil then begin
        g_pd3dDevice.SetTextureStageState(Stage, D3DTSS_ALPHAARG1,src);
        g_pd3dDevice.SetTextureStageState(Stage, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
    end;
end;


Procedure TPikaEngine.SetAntialising(status:boolean);
begin
    if g_pd3dDevice <> nil then begin
        isAntialising:=status;
        if status then begin
            g_pd3dDevice.SetSamplerState(0, D3DSAMP_MINFILTER,D3DTEXF_LINEAR );
            g_pd3dDevice.SetSamplerState(0, D3DSAMP_MAGFILTER,D3DTEXF_LINEAR );
            g_pd3dDevice.SetSamplerState(0, D3DSAMP_MIPFILTER,D3DTEXF_ANISOTROPIC );
        end else begin
            g_pd3dDevice.SetSamplerState(0, D3DSAMP_MINFILTER,D3DTEXF_POINT );
            g_pd3dDevice.SetSamplerState(0, D3DSAMP_MAGFILTER,D3DTEXF_POINT );
            g_pd3dDevice.SetSamplerState(0, D3DSAMP_MIPFILTER,D3DTEXF_NONE );
        end;
    end;
end;

Procedure TPikaEngine.SetMirroredTexture(status:boolean);
begin
    if g_pd3dDevice <> nil then begin
        isMirrored:=status;
        if status then begin
            g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSU,D3DTADDRESS_MIRROR);
            g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSV,D3DTADDRESS_MIRROR);
        end else begin
            g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSU,D3DTADDRESS_WRAP);
            g_pd3dDevice.SetSamplerState(0,D3DSAMP_ADDRESSV,D3DTADDRESS_WRAP);
        end;
    end;
end;


Destructor TPikaEngine.Free3d;
var x,y,z:integer;
begin

    try
    //process map
    if self.g_3DScene.Map <> nil then begin
    self.g_3DScene.Map.Free;
    end;
    //all object
    while self.g_3DScene.ItemsCount>0 do
        self.g_3DScene.Items[0].Free;
    //all image
     while self.g_3DScene.SurfaceCount>0 do
        self.g_3DScene.Surface[0].Free;
    //main frame
    //if g_pd3dDevice <> nil then g_pd3dDevice._Release;
    g_pd3dDevice:=nil;
    finally
    end;
    inherited destroy;
end;

{
 SetView - use it to select the view point
    eyept* = the x,y,z position
    vr = the rotation based on Pi for a 360 turn
    vz = the up down rotation based on -90 to 90 degre ( -1.5 to 1.5)
}

Procedure TPikaEngine.SetView(eyeptx,eyepty,eyeptz,vr,vz:single);
var vEyePt, vLookatPt, vUpVec: TD3DVector;
  matView: TD3DMatrix;
  matProj: TD3DMatrix;
  px,py,pz:single;
begin
    if g_pd3dDevice <> nil then begin
        EyeX:=eyeptx;
        Eyey:=eyepty;
        EyeZ:=eyeptZ;
        self.g_3DScene.EyeX:=eyeptx;
        self.g_3DScene.Eyey:=eyepty;
        self.g_3DScene.EyeZ:=eyeptZ;
        self.g_3DScene.EyeRH:=vr;
        self.g_3DScene.EyeRV:=vz;
        px:=cos(vr)*3;
        py:=sin(vz)*3;
        pz:=(cos(vz)*sin(vr))*3;

        vEyePt:= D3DXVector3(eyeptx, eyepty,eyeptz);
        vLookatPt:= D3DXVector3(eyeptx+px, eyepty+py, eyeptz+pz);
        vUpVec:= D3DXVector3(0.0, 1.0, 0.0);
        D3DXMatrixLookAtLH(matView, vEyePt, vLookatPt, vUpVec);
        g_pd3dDevice.SetTransform(D3DTS_VIEW, matView);
    end;
end;

Procedure TPikaEngine.DisableFog;
var dw:dword;
    matProj: TD3DMatrix;
begin
   g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,ifalse);
   g_pd3dDevice.SetRenderState(D3DRS_RANGEFOGENABLE,ifalse);
   D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,30000);
   self.fogend:=0;
    g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
end;

Procedure TPikaEngine.SetClipping(fend:single);
var matProj: TD3DMatrix;
begin
    currentclipping:=fend;
    if fend = 0 then D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,20000) else
    D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,fend);
    g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
end;

Procedure TPikaEngine.SetFog(Color:dword;fstart,fend:single);
var dw:dword;
    t:single;
    matProj: TD3DMatrix;
begin
    g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,itrue);
    g_pd3dDevice.SetRenderState(D3DRS_RANGEFOGENABLE,itrue);
    g_pd3dDevice.SetRenderState(D3DRS_FOGCOLOR,color);
    g_pd3dDevice.SetRenderState(D3DRS_FOGVERTEXMODE,D3DFOG_LINEAR);
    move(fStart,dw,4);
    g_pd3dDevice.SetRenderState(D3DRS_FOGSTART,dw);
    move(fEnd,dw,4);
    g_pd3dDevice.SetRenderState(D3DRS_FOGEND,dw);

    self.fogend:=fEnd;
    {
    D3DXMatrixPerspectiveFovLH (matProj,PI/4,1.33333333,1,fend+20);
    g_pd3dDevice.SetTransform( D3DTS_PROJECTION, matProj );
    }
end;

Procedure TPikaEngine.LookAt(eyeptx,eyepty,eyeptz,LookX,LookY,LookZ:single);
var vEyePt, vLookatPt, vUpVec: TD3DVector;
  matView: TD3DMatrix;
  matProj: TD3DMatrix;
  i,o:single;
begin
    if g_pd3dDevice <> nil then begin

        EyeX:=eyeptx;
        EyeY:=eyeptY;
        EyeZ:=eyeptZ;
        self.g_3DScene.EyeX:=eyeptx;
        self.g_3DScene.Eyey:=eyepty;
        self.g_3DScene.EyeZ:=eyeptZ;
        EyeLX:=LookX;
        EyeLY:=LookY;
        EyeLZ:=LookZ;
        i:=EyelX-EyeX;
        o:=EyelZ-EyeZ;
        if o <> 0 then
            self.g_3DScene.eyerh:=arctan(i/o)
        else self.g_3DScene.eyerh:=0;
        i:=Eyey-Eyely;
        if o <> 0 then
            self.g_3DScene.eyerv:=arctan(i/o)
        else self.g_3DScene.eyerv:=0;
        vEyePt:= D3DXVector3(eyeptx, eyepty,eyeptz);
        vLookatPt:= D3DXVector3(lookx, looky, lookz);
        vUpVec:= D3DXVector3(0.0, 1.0, 0.0);
        D3DXMatrixLookAtLH(matView, vEyePt, vLookatPt, vUpVec);
        g_pd3dDevice.SetTransform(D3DTS_VIEW, matView);
    end;
end;

Function TPikaMap.LoadPSOGCMap(Filename,TextureFileName:ansistring):boolean;
const  D3DFVF_CUSTOMVERTEX = D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE  or D3DFVF_TEX1;
       DXT1_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$40#$00#$00#$00#$40#$00#$00#$00#$00#$08
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$31
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;

type
TMapSection = Record
        ID:dword;
        dx,dz,dy:single;
        unknow1:dword;
        Rotation:dword;
        unknow3:dword;
        unknow4:single;
        VertexA_Off:dword;
        VertexB_Off:dword;
        VertexA_Count:dword;
        VertexB_Count:dword;
        unknow8:dword;
    end;
    TBlockVertex = record
        Offset:dword;
        unknow1:dword;
        unknow2:dword;
        Flag:dword;
    end;
    TExtendedBlockVertex = record
        Offset:dword;
        anioff:dword;
        unknow2:dword;
        unknow3:dword;
        unknow4:dword;
        unknow5:dword;
        unknow6:dword;
        Flag:dword;
    end;
    Tani = record
        offset:dword;
        Frame:dword;
        count:word;
        flag:word;
    end;
    TAniInfo = record
        data:array[0..8] of dword;
    end;
TXVMHeader = record
        Flag:dword;
        Size:dword;
        unknown:word;
        count:word;
        unused:dword;
    end;
    TXVRHeader = record
        Flag:dword;
        Size:dword;
        PixelFormat:dword;
        sx,sy:word;
    end;
    TDataBlock = Record
        flg:dword;
        off:dword;
        pos:array[0..2] of single;
        ang:array[0..2] of dword;
        scale:array[0..2] of single;
        child,sibling:dword;
    end;
Function MakeRVB(t:integer):integer;
var c:integer;
begin
    c:=((t div $400) and $1F) *8;
    c:=c+((((t div $20) and $1f) *8)*256);
    c:=c+((((t div $1) and $1f) *8)*65536);
    if t and $7fff = 0 then c:=$10101;
    if t and $8000 <> $8000 then c:=$0;
    result:=c;
end;
Function ConvertDword(v:dword):dword;
var x:dword;
begin
    pansichar(@x)[0]:=pansichar(@v)[3];
    pansichar(@x)[1]:=pansichar(@v)[2];
    pansichar(@x)[2]:=pansichar(@v)[1];
    pansichar(@x)[3]:=pansichar(@v)[0];
    result:=x;
end;
Function ConvertWord(v:word):word;
var x:word;
begin
    pansichar(@x)[0]:=pansichar(@v)[1];
    pansichar(@x)[1]:=pansichar(@v)[0];
    result:=x;
end;
Procedure BatchConvert(p:pansichar;si:integer);
var n:integer;
    ch:ansichar;
begin
    for n:=0 to (si div 4)-1 do begin
            ch:=p[(n*4)];
            p[(n*4)]:=p[(n*4)+3];
            p[(n*4)+3]:=ch;
            ch:=p[(n*4)+1];
            p[(n*4)+1]:=p[(n*4)+2];
            p[(n*4)+2]:=ch;
    end;
end;

Procedure ColorConvert(p:pansichar;si:integer);
var n:integer;
    ch:ansichar;
begin
    for n:=0 to (si div 4)-1 do begin
            ch:=p[(n*4)];
            p[(n*4)]:=p[(n*4)+2];
            p[(n*4)+2]:=ch;
    end;
end;

Procedure BatchWordConvert(p:pansichar;si:integer);
var n:integer;
    ch:ansichar;
begin
    for n:=0 to (si div 2)-1 do begin
            ch:=p[(n*2)];
            p[(n*2)]:=p[(n*2)+1];
            p[(n*2)+1]:=ch;
    end;
end;
Function ReversePixel(p:byte):ansichar;
begin
    result:=ansichar(((p and 3)*64)+(((p div 4) and 3)*16)+(((p div 16) and 3)*4)+(((p div 64) and 3)));
end;

Function twiddled_ME(sx,fs,ts:integer;d:pansichar):integer;
var x,y,px,py,mx,my,c:integer;
    p:pansichar;
begin
    p:=allocmem(fs);
    for y:=0 to (sx div 4)-1 do
    for x:=0 to (sx div 8)-1 do
    begin
        c:=(x*2) + (y and 1) + ((y div 2)*(sx div 4));
        my:=c div (sx div 8);
        mx:=c - (my * (sx div 8));
        for px:=0 to 1 do begin
            py:=px*ts;
            if ts = 8 then begin
                //color
                p[(x*ts*2)+(y*(sx div 4)*ts)+py]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+1];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+1]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+0];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+2]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+3];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+3]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+2];
                //pixel
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+4]:=ReversePixel(byte(d[(mx*ts*2)+(my*(sx div 4)*ts)+py+4]));
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+5]:=ReversePixel(byte(d[(mx*ts*2)+(my*(sx div 4)*ts)+py+5]));
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+6]:=ReversePixel(byte(d[(mx*ts*2)+(my*(sx div 4)*ts)+py+6]));
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+7]:=ReversePixel(byte(d[(mx*ts*2)+(my*(sx div 4)*ts)+py+7]));

            end;
            if ts = 16 then begin
                //color
                p[(x*ts*2)+(y*(sx div 4)*ts)+py]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+1];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+1]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+2]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+3];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+3]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+2];
                //alpha
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+4]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+5];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+5]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+4];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+6]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+7];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+7]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+6];

                p[(x*ts*2)+(y*(sx div 4)*ts)+py+8]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+8];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+9]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+9];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+10]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+10];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+11]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+11];
                //pixel
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+12]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+12];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+13]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+13];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+14]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+14];
                p[(x*ts*2)+(y*(sx div 4)*ts)+py+15]:=d[(mx*ts*2)+(my*(sx div 4)*ts)+py+15];

            end;
        end;
                //tmpimg[(x*8)+px,(y*4)+py]:=tmpimg2[(mx*8)+px,(my*4)+py];
    end;
    move(p[0],d[0],fs);
    freemem(p);
    result:=1;
end;
Procedure Decode16BitGC(bin,bout:pansichar;sx:integer);
var x,y,i,c,mx,my,x2,y2:integer;
    //pal:array[0..255] of word;
    TT:array[0..1023] of integer;
    header:ansistring;
begin
    header:=#$42#$4D#$DA#$1F#$00#$00#$00#$00#$00#$00#$36#$00#$00#$00#$28#$00#$00#$00#$2D#$00#$00#$00#$2D#$00#$00#$00#$01#$00
            +#$20#$00#$00#$00#$00#$00#$A4#$1F#$00#$00#$13#$0B#$00#$00#$13#$0B#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
    c:=sx*sx*4;
    move(c,header[$23],4);
    inc(c,$36);
    move(c,header[$3],4);
    move(sx,header[$13],2);
    move(sx,header[$17],2);
    //getmem(ms,c);
    move(header[1],bout[0],$36);
    c:=$36;

    i:=0;
    {for x:=0 to 1023 do
    tt[x] := (x and 1)or((x and 2)*2)or((x and 4)*4)or((x and 8)*8)or((x and 16)*16)or
      ((x and 32)*32)or((x and 64)*64)or((x and 128)*128)or((x and 256)*256)or((x and 512)*512);
                                 }
    for y:=0 to (sx div 4)-1 do
        for x:=0 to (sx div 4)-1 do begin
            //i:=(tt[y] or (tt[x]*2))*2;
            for y2:=0 to 3 do
            for x2:=0 to 3 do begin
            c:=byte(bin[i+1])+(byte(bin[i])*256);
            if c and $8000 = $8000 then begin
                c:=((c and 31)*$8)+(((c div 32) and 31)*$800)+(((c div $400) and 31)*$80000)+((c div $8000)*$ff000000);
            end else begin
                c:=((c and 15)*$10)+(((c div 16) and 15)*$1000)+(((c div $100) and 15)*$100000)+((c div $1000)*$20000000);
            end;
            //tmpimg[(x*4)+x2,(y*4)+y2]:=c;
            //c:=ConvertDword(c);
            
            move(c,bout[$36+ (((x*4)+x2)*4) + ((sx-((y*4)+y2))*sx*4)],4);
            inc(i,2);
            end;
        end;
end;

Function PSOLoadTexture(s:ansistring):boolean;
var h:TXVMHeader;
    b:TXVRHeader;
    f,f2,i,x,tx,ty,ts:integer;
    p,p2:pansichar;
    c:ansichar;
begin
    f:=fileopen(s,$40); //open xvm file
    fileread(f,h,14);  //read the header
    setlength( self.texture ,Convertword(h.count)); //set texture memory
    setlength(self.texFlag,Convertword(h.count)); //set texture flag memory
    self.TextureCount:=Convertword(h.count);
    fileseek(f,h.Size+8,0);
    for i:=0 to Convertword(h.count)-1 do begin
        fileread(f,b,$10); //read the xvr header
        p:=allocmem(b.Size+120); //reserve memory for data+DDS header
        fileread(f,p[128],b.Size-$8); //read the data
        texFlag[i]:=(ConvertDword(b.PixelFormat) div $100);
        if ConvertDword(b.PixelFormat) and $ff = 5 then begin
            //old format, convert to bmp first
            self.texFlag[i]:=0;
            x:=(Convertword(b.sx)*Convertword(b.sx)*4)+$36;
            getmem(p2,x);
            Decode16BitGC(@p[128],p2,Convertword(b.sx));
            D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p2,x,self.texture[i]);
            freemem(p2);
        end else begin
        ts:=8;
        move(DXT1_Header[1],p[0],128);
        Twiddled_ME(convertword(b.sx),b.Size-8,ts,@p[128]);

        p[12]:=pansichar(@b.sx)[1];
        p[13]:=pansichar(@b.sx)[0];
        p[16]:=pansichar(@b.sy)[1];
        p[17]:=pansichar(@b.sy)[0];
        x:=b.size-8;
        move(x,p[20],4); //set the data size

        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p,b.Size+120,self.texture[i]);
        end;
        freemem(p);
    end;
    fileclose(f);
end;
Function MatrixVertex(ve:T3DVertex;rx,ry,rz:integer):T3DVertex;
var re:T3DVertex;
    r,sx,cx,sy,cy,sz,cz,xy,xz,yz,yx,zx,zy:single;
    i:integer;
begin
    re:=ve;
        sx := sin(rx/ 10430.378350);
        cx := cos(rx/ 10430.378350);
        sy := sin(ry/ 10430.378350);
        cy := cos(ry/ 10430.378350);
        sz := sin(rz/ 10430.378350);
        cz := cos(rz/ 10430.378350);;


        xy := cx*(re.py) - sx*(re.pz);
        xz := sx*(re.py) + cx*(re.pz);
        // rotation around y
        yz := cy*xz - sy*(re.px);
        yx := sy*xz + cy*(re.px);
        // rotation around z
        zx := cz*yx - sz*xy;
        zy := sz*yx + cz*xy;

        re.px:=zx;
        re.py:=zy;
        re.pz:=yz;
    result:=re;
end;
var y,r,m,ll,MapSectionCount,c,c2,ic,ic2,q,o,e,k,f,n:integer;
    mapsection:array of TMapSection;
    vblock:array of TBlockVertex;
    evblock:array of TExtendedBlockVertex;
    pp,pv:pointer;
    re:Single;
    ver:array[0..20] of single;
    yyy:array of T3DVertex;
    ch:ansichar;
    idl:array[0..$FFFF] of byte;
    buf:array[0..5] of pansichar;
    d1,d2,d3,d4,tex:integer;
    sh:array[0..1] of short;
    bbb:array[0..5] of byte;
    pdta:array[0..9] of byte;
    als,ald,lr,flg:dword;
    CSB:array[0..1000]of TDataBlock;
    CSBP:dword;
    ani:TAni;
    aniinfo:TAniInfo;
    ma1:td3dmatrix;
    mo1,mo2:integer;
    ssid,slid:integer;

Procedure ProcedeChuck(off:integer);
var f,d1,d2,d3,d4,fff,l:integer;
begin
    l:=self.Area[m].GroupeA_Count;
    inc(self.Area[m].GroupeA_Count);
    inc(self.Area[m].GroupeB_Count);
    setlength( self.Area[m].GroupeA, self.Area[m].GroupeA_Count);
    setlength( self.Area[m].GroupeB, self.Area[m].GroupeB_Count);
    self.Area[m].GroupeA[l].textslideid:=slid;
    self.Area[m].GroupeA[l].textswapid:=ssid;
    self.Area[m].Groupeb[l].textslideid:=slid;
    self.Area[m].Groupeb[l].textswapid:=ssid;

    inc(csbp);
    fileseek(y,off,0);
    fileread(y,csb[csbp],$38);
    batchconvert(@csb[csbp],$38);
    flg:=csb[csbp].flg;
    self.Area[m].Groupeb[l].usemotion:=false;

    if ll >= MapSection[m].VertexA_Count then begin
                    //read the motion
                    self.Area[m].GroupeA[l].motionframe:=ani.Frame*2;
                    self.Area[m].GroupeA[l].motiontime:=ani.Frame*66;
                    self.Area[m].GroupeA[l].usemotion:=true;
                    o:=0;
                    if ani.flag and 1 = 1 then begin
                    if aniinfo.data[o] <> 0 then begin
                        self.Area[m].GroupeA[l].motionposcount:=aniinfo.data[ani.count+o];
                        setlength(self.Area[m].GroupeA[l].motionpos,aniinfo.data[ani.count+o]);
                        fileseek(y,aniinfo.data[o],0);
                        fileread(y,self.Area[m].GroupeA[l].motionpos[0],aniinfo.data[ani.count+o]*16);
                        batchconvert(@self.Area[m].GroupeA[l].motionpos[0],aniinfo.data[ani.count+o]*16);
                        for f:=0 to aniinfo.data[ani.count+o]-1 do
                            self.Area[m].GroupeA[l].motionpos[f].id:=self.Area[m].GroupeA[l].motionpos[f].id*2;
                    end;
                    inc(o);
                    end;
                    if ani.flag and 2 = 2 then begin
                    if aniinfo.data[o] <> 0 then begin
                        fileseek(y,aniinfo.data[o],0);
                        self.Area[m].GroupeA[l].motionangcount:=aniinfo.data[ani.count+o];
                        setlength(self.Area[m].GroupeA[l].motionang,aniinfo.data[ani.count+o]);
                        fileread(y,self.Area[m].GroupeA[l].motionang[0],aniinfo.data[ani.count+o]*16);
                        batchconvert(@self.Area[m].GroupeA[l].motionang[0],aniinfo.data[ani.count+o]*16);
                        for f:=0 to aniinfo.data[ani.count+o]-1 do
                            self.Area[m].GroupeA[l].motionang[f].id:=self.Area[m].GroupeA[l].motionang[f].id*2;

                    end;
                    inc(o);
                    end;

                    if ani.flag and 4 = 4 then begin
                    if aniinfo.data[o] <> 0 then begin
                        fileseek(y,aniinfo.data[o],0);
                        self.Area[m].GroupeA[l].motionscalecount:=aniinfo.data[ani.count+o];
                        setlength(self.Area[m].GroupeA[l].motionsca,aniinfo.data[ani.count+o]);
                        fileread(y,self.Area[m].GroupeA[l].motionsca[0],aniinfo.data[ani.count+o]*16);
                        batchconvert(@self.Area[m].GroupeA[l].motionsca[0],aniinfo.data[ani.count+o]*16);
                        for f:=0 to aniinfo.data[ani.count+o]-1 do
                            self.Area[m].GroupeA[l].motionsca[f].id:=self.Area[m].GroupeA[l].motionsca[f].id*2;

                    end;
                    inc(o);
                    end;



                    move(csb[1].pos[0],self.Area[m].GroupeA[l].defaultpos,12);
                    move(csb[1].ang[0],self.Area[m].GroupeA[l].defaultrot,12);
                    move(csb[1].scale[0],self.Area[m].Groupea[l].defaultscale,12);
               

                    self.Area[m].Groupeb[l].motionframe:=ani.Frame*2;
                    self.Area[m].Groupeb[l].motionposcount:=self.Area[m].Groupea[l].motionposcount;
                    self.Area[m].Groupeb[l].motionangcount:=self.Area[m].Groupea[l].motionangcount;
                    self.Area[m].Groupeb[l].motionscalecount:=self.Area[m].Groupea[l].motionscalecount;
                    self.Area[m].Groupeb[l].motiontime:=ani.Frame*66;
                    setlength(self.Area[m].Groupeb[l].motionpos,self.Area[m].Groupea[l].motionposcount);
                    setlength(self.Area[m].Groupeb[l].motionang,self.Area[m].Groupea[l].motionangcount);
                    setlength(self.Area[m].Groupeb[l].motionsca,self.Area[m].Groupea[l].motionscalecount);
                    if self.Area[m].Groupea[l].motionposcount <> 0 then begin
                        move(self.Area[m].GroupeA[l].motionpos[0],self.Area[m].GroupeB[l].motionpos[0],self.Area[m].Groupea[l].motionposcount*16);
                    end;
                    if self.Area[m].Groupea[l].motionangcount <> 0 then begin
                        move(self.Area[m].GroupeA[l].motionang[0],self.Area[m].GroupeB[l].motionang[0],self.Area[m].Groupea[l].motionangcount*16);
                    end;
                    if self.Area[m].Groupea[l].motionscalecount <> 0 then begin
                        move(self.Area[m].GroupeA[l].motionsca[0],self.Area[m].GroupeB[l].motionsca[0],self.Area[m].Groupea[l].motionscalecount*16);
                    end;
                    move(csb[1].pos[0],self.Area[m].Groupeb[l].defaultpos,12);
                    move(csb[1].ang[0],self.Area[m].Groupeb[l].defaultrot,12);
                    move(csb[1].scale[0],self.Area[m].Groupeb[l].defaultscale,12);
                    self.Area[m].Groupeb[l].usemotion:=true;
                    end;






                //get the block pointer
                r:=csb[csbp].off;
                if r <> 0 then begin
                    fileseek(y,r,0);
                    fileread(y,r,4);    //pointer to information of the vertex list
                    r:=convertdword(r);
                    //the indice list
                    fileread(y,c,4);
                    fileread(y,c,4);    //go read teh first indice list
                    c:=convertdword(c);
                    fileread(y,c2,4);
                    c2:=convertdword(c2);
                    ic:=0;
                    fileread(y,ic,2);   //number of list
                    ic:=convertword(ic);
                    fileread(y,ic2,2);   //number of list
                    ic2:=convertword(ic2);
                    self.Area[m].GroupeA[l].IndexListCount:=0;
                    setlength(self.Area[m].GroupeA[l].indexs,0);

                    //load the 3 chunk of data
                    //01 = vertex
                    //02 = normal
                    //03 = diffuse
                    //05 = 16bit UV
                    d1:=0;
                    fillchar(pdta[0],9,0);
                    fillchar(bbb[0],5,0);
                    while d1 <> $ff do begin
                        fileseek(y,r,0);  //final pointer to the header, seek to it
                        d1:=0;
                        d2:=0;
                        n:=0;
                        fileread(y,d1,1); //data offset
                        fileread(y,d2,1); //size of 1 vertex
                        fileread(y,n,2); //amount of vertex
                        //self.Area[m].GroupeA[l].VertexCount:=convertword(n);
                        fileread(y,d3,4); //data offset
                        fileread(y,d3,4); //data offset
                        fileread(y,d4,4); //data offset
                        d3:=convertdword(d3);
                        d4:=convertdword(d4);
                        r:=fileseek(y,0,1);
                        n:=3;
                        pdta[d1]:=1;
                        if d1 = 1 then n:=0;
                        if d1 = 3 then n:=1;
                        if d1 = 5 then n:=2;
                        buf[n]:=allocmem(d4);
                        fileseek(y,d3,0);
                        fileread(y,buf[n][0],d4);
                        if n<>1 then 
                        BatchConvert(@buf[n][0],d4)
                        else ColorConvert(@buf[n][0],d4)
                    end;




                    bbb[0]:=$c;
                    bbb[1]:=$c;
                    bbb[2]:=$c;
                    als:=1;
                    ald:=0;
                    n:=0;
                    setlength(yyy,n);
                    for f:=0 to ic-1 do begin  //load eatch of them (eatch one make an item or object)
                        fileseek(y,c,0);  //seek to the entry
                        inc(c,16);        //prepare for next entry
                        fileread(y,q,4);
                        q:=convertdword(q);
                        fileread(y,o,4);
                        o:=convertdword(o);
                        fileread(y,e,4);  //get the offset
                        e:=convertdword(e);
                        fileread(y,k,4);  //get the amount of index
                        k:=convertdword(k);
                        fileseek(y,e,0);  //seek to it
                        fileread(y,idl[0],k); //read them all


                        fileseek(y,q,0);
                        if f>0 then tex:=self.Area[m].GroupeA[l].Indexs[f-1].TextureID //last used texture
                        else tex:=0;
                        ald:=5;
                        als:=4;
                        for d1:=0 to o-1 do begin
                            fileread(y,q,4);
                            //1 = vertice format
                            //8 = texture
                            //5 = light
                            //9 = copy mode
                            if q = 2 then begin
                                fileread(y,q,2);
                                fileread(y,q,2);
                                //showmessage(inttohex(q,2));
                                {mo1:=q and 3;
                                mo2:=(q div 4) and 3;  }

                            end else
                            if q = 4 then begin
                                fileread(y,q,2);
                                //ald:=convertword(q);
                                fileread(y,q,2);
                                //als:=convertword(q);


                            end else
                            if q = 8 then begin
                                fileread(y,q,2);
                                q:=swap(q);
                                mo2:=3-(q and 3);
                                mo1:=3-((q div 4) and 3);
                                fileread(y,q,2);
                                tex:=convertword(q);
                            end else if q = 1 then begin
                                fileread(y,q,4);
                                q:=convertdword(q);
                                bbb[0]:=(q and 15);
                                bbb[1]:=((q div 16) and 15);
                                bbb[2]:=((q div 256) and 15);
                                bbb[3]:=((q div 4096) and 15);
                            end else fileread(y,q,4);
                        end;

                        d1:=0;
                        o:=0;
                        e:=0;

                        while d1 < k do begin
                            if o <= 0 then begin
                                if idl[d1] = 0 then
                                    break;
                                d2:=0;
                                if idl[d1] = $90 then d2:= 1;
                                o:=idl[d1+2]+(idl[d1+1]*256);
                                if d1 > 0 then begin
                                    self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].g_pIB.Unlock;
                                end;
                                inc(d1,3);
                                e:=0;
                                inc(self.Area[m].GroupeA[l].IndexListCount);
                                setlength(self.Area[m].GroupeA[l].indexs,self.Area[m].GroupeA[l].IndexListCount);
                                if Failed( self.g_pd3dDevice.CreateIndexBuffer(
                                o*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT
                                ,self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].g_pIB,nil)) then exit;
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].g_pIB.Lock(0,o*2,pp,0);
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].TextureID:=tex;
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].IndexCount:=o;
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].SurfaceCount:=o-2;
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].AlphaSrc:=als;
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].Alphadst:=ald;
                                self.Area[m].Groupea[l].Indexs[self.Area[m].Groupea[l].IndexListCount-1].tus:=3-mo1;
                                self.Area[m].Groupea[l].Indexs[self.Area[m].Groupea[l].IndexListCount-1].tvs:=3-mo2;
                                if d2 = 1 then self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].SurfaceCount:=o div 3;
                                if d2=0 then self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].stype:=D3DPT_TRIANGLESTRIP
                                else
                                self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].stype:=D3DPT_TRIANGLElist;

                            end;
                            d3:=0;
                            setlength(yyy,n+1);
                            yyy[n].color:=$FFFFFFFF;
                            yyy[n].tu:=0;
                            yyy[n].tv:=0;
                            for d2:=1 to 8 do
                            if pdta[d2] = 1 then begin
                                if d2 < 4 then d3:=0;
                                if d2 = 4 then d3:=1;
                                if d2 = 5 then d3:=2;
                                if bbb[d3] > 0 then
                                if bbb[d3] <= 10 then begin
                                  d4:=idl[d1];
                                  inc(d1);
                                end else begin
                                    d4:=idl[d1+1]+(idl[d1]*256);
                                    inc(d1,2);
                                end;

                                if d2 = 1 then move(buf[0][d4*12], yyy[n].px, 12);
                                if d2 = 3 then move(buf[1][d4*4], yyy[n].color, 4);
                                if d2 = 5 then begin
                                    move(buf[2][d4*4], sh[0], 4);
                                    yyy[n].tu:=sh[1] / 256;
                                    yyy[n].tv:=sh[0] / 256;
                                end;

                            end;

                            for fff:=csbp downto 1 do begin
                            if (fff > 1) or (ll < MapSection[m].VertexA_Count) then begin
                            if csb[fff].flg and 4 = 0 then begin
                                yyy[n].px:=yyy[n].px*csb[fff].scale[0];
                                yyy[n].pz:=yyy[n].pz*csb[fff].scale[2];
                                yyy[n].py:=yyy[n].py*csb[fff].scale[1];
                            end;

                            if csb[fff].flg and 2 = 0 then
                                yyy[n]:=MatrixVertex(yyy[n],csb[fff].ang[0],csb[fff].ang[1],csb[fff].ang[2])
                            else yyy[n]:=MatrixVertex(yyy[n],0,0,0);

                            if csb[fff].flg and 1 = 0 then begin
                            yyy[n].px:=yyy[n].px+csb[fff].pos[0];
                            yyy[n].pz:=yyy[n].pz+csb[fff].pos[2];
                            yyy[n].py:=yyy[n].py+csb[fff].pos[1];
                            end;
                            end;
                            // rotation around x


                            end;


                            {yyy[n]:=MatrixVertex(yyy[n],MapSection[m].Rotation);
                            yyy[n].px:=yyy[n].px+MapSection[m].dx;
                            yyy[n].pz:=-(yyy[n].pz+MapSection[m].dy);
                            yyy[n].py:=yyy[n].py+MapSection[m].dz; }


                            move(n, pansichar(pp)[e*2],2);
                            inc(e);
                            inc(n);
                            dec(o);
                        end;
                         self.Area[m].GroupeA[l].Indexs[self.Area[m].GroupeA[l].IndexListCount-1].g_pIB.Unlock;
                        //read the texture number

                    end;

                    self.Area[m].GroupeA[l].VertexCount:=n;
                    if n>0 then begin
                    //self.Area[m].GroupeA[l].IndexListCount:=0;

                    self.Area[m].GroupeA[l].VertexSize:=24;
                    self.Area[m].GroupeA[l].VertexType:=
                        D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1;

                    if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Area[m].GroupeA[l].VertexCount*24
                        ,0,self.Area[m].GroupeA[l].VertexType,D3DPOOL_DEFAULT
                        ,self.Area[m].GroupeA[l].g_pVB ,0)) then exit;
                    self.Area[m].GroupeA[l].g_pVB.Lock(0,self.Area[m].GroupeA[l].VertexCount*24,pp,0);

                    move(yyy[0],pansichar(pp)[0],self.Area[m].GroupeA[l].VertexCount*24);

                    self.Area[m].GroupeA[l].SurfaceType:=D3DPT_TRIANGLEstrip;
                    self.Area[m].GroupeA[l].g_pVB.Unlock;
                    end;

                    n:=0;
                    setlength(yyy,n);
                    //ic2

                    for f:=0 to ic2-1 do begin  //load eatch of them (eatch one make an item or object)
                        fileseek(y,c2,0);  //seek to the entry
                        inc(c2,16);        //prepare for next entry
                        fileread(y,q,4);
                        q:=convertdword(q);
                        fileread(y,o,4);
                        o:=convertdword(o);
                        fileread(y,e,4);  //get the offset
                        e:=convertdword(e);
                        fileread(y,k,4);  //get the amount of index
                        k:=convertdword(k);
                        fileseek(y,e,0);  //seek to it
                        fileread(y,idl[0],k); //read them all


                        fileseek(y,q,0);
                        {if f>0 then tex:=self.Area[m].Groupeb[l].Indexs[f-1].TextureID //last used texture
                        else tex:=0;   }

                        for d1:=0 to o-1 do begin
                            fileread(y,q,4);
                            //1 = vertice format
                            //2 = mirror or not
                            //8 = texture
                            //5 = light
                            //9 = copy mode
                            if q = 2 then begin
                                fileread(y,q,2);
                                fileread(y,q,2);
                                //showmessage(inttohex(q,2));
                                {mo1:=q and 3;
                                mo2:=(q div 4) and 3;    }
                            end else
                            if q = 4 then begin
                                fileread(y,q,2);
                                //ald:=convertword(q);
                                fileread(y,q,2);

                                als:=(q and 15);
                                //showmessage(inttohex(q,2));
                                if als = 5 then begin
                                    als:=4;
                                    ald:=5;
                                end else if als = 1 then begin
                                    als:=2;
                                    ald:=1;
                                end else begin
                                    ald:=1;
                                    als:=3;
                                end;

                            end else
                            if q = 8 then begin
                                fileread(y,q,2);
                                q:=swap(q);
                                mo1:=3-(q and 3);
                                mo2:=3-((q div 4) and 3);
                                fileread(y,q,2);
                                tex:=convertword(q);
                                if pos('map_city01_00',lowercase(filename))>0 then begin
                                    if tex = 39 then begin    
                                    als:=3;
                                    ald:=1;
                                end ;
                                end;
                                if pos('map_city00_00',lowercase(filename))>0 then begin
                                    if tex = 40 then begin    
                                    als:=3;
                                    ald:=1;
                                end;
                                end;

                            end else if q = 1 then begin
                                fileread(y,q,4);
                                q:=convertdword(q);
                                bbb[0]:=(q and 15);
                                bbb[1]:=((q div 16) and 15);
                                bbb[2]:=((q div 256) and 15);
                                bbb[3]:=((q div 4096) and 15);
                            end else fileread(y,q,4);
                        end;

                        d1:=0;
                        o:=0;
                        e:=0;

                        while d1 < k do begin
                            if o <= 0 then begin
                                if idl[d1] = 0 then break;
                                d2:=0;
                                if idl[d1] = $90 then d2:= 1;
                                o:=idl[d1+2]+(idl[d1+1]*256);
                                if d1 > 0 then begin
                                    self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].g_pIB.Unlock;
                                end;
                                inc(d1,3);
                                e:=0;
                                inc(self.Area[m].Groupeb[l].IndexListCount);
                                setlength(self.Area[m].Groupeb[l].indexs,self.Area[m].Groupeb[l].IndexListCount);
                                if Failed( self.g_pd3dDevice.CreateIndexBuffer(
                                o*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT
                                ,self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].g_pIB,nil)) then exit;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].g_pIB.Lock(0,o*2,pp,0);
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].TextureID:=tex;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].IndexCount:=o;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].SurfaceCount:=o-2;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].AlphaSource:=D3DTA_TEXTURE;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].tus:=3-mo1;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].tvs:=3-mo2;

                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].AlphaSrc:=als;
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].Alphadst:=ald;
                                if d2 = 1 then self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].SurfaceCount:=o div 3;
                                if d2=0 then self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].stype:=D3DPT_TRIANGLESTRIP
                                else
                                self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].stype:=D3DPT_TRIANGLElist;

                            end;
                            d3:=0;
                            setlength(yyy,n+1);
                            yyy[n].color:=$ffFFFFFF;
                            yyy[n].tu:=0;
                            yyy[n].tv:=0;
                            for d2:=1 to 8 do
                            if pdta[d2] = 1 then begin
                                if d2 < 4 then d3:=0;
                                if d2 = 4 then d3:=1;
                                if d2 = 5 then d3:=2;
                                if bbb[d3] > 0 then
                                if bbb[d3] <= 10 then begin
                                  d4:=idl[d1];
                                  inc(d1);
                                end else begin
                                    d4:=idl[d1+1]+(idl[d1]*256);
                                    inc(d1,2);
                                end;

                                if d2 = 1 then move(buf[0][d4*12], yyy[n].px, 12);
                                if d2 = 3 then
                                    move(buf[1][d4*4], yyy[n].color, 4);
                                if d2 = 5 then begin
                                    move(buf[2][d4*4], sh[0], 4);
                                    yyy[n].tu:=sh[1] / 256;
                                    yyy[n].tv:=sh[0] / 256;
                                end;

                            end;
                            
                            for fff:=csbp downto 1 do begin
                            if (fff > 1) or (ll < MapSection[m].VertexA_Count) then begin
                            if csb[fff].flg and 4 = 0 then begin
                                yyy[n].px:=yyy[n].px*csb[fff].scale[0];
                                yyy[n].pz:=yyy[n].pz*csb[fff].scale[2];
                                yyy[n].py:=yyy[n].py*csb[fff].scale[1];
                            end;
                            if csb[fff].flg and 2 = 0 then
                                yyy[n]:=MatrixVertex(yyy[n],csb[fff].ang[0],csb[fff].ang[1],csb[fff].ang[2])
                            else yyy[n]:=MatrixVertex(yyy[n],0,0,0);

                            if csb[fff].flg and 1 = 0 then begin
                            yyy[n].px:=yyy[n].px+csb[fff].pos[0];
                            yyy[n].pz:=yyy[n].pz+csb[fff].pos[2];
                            yyy[n].py:=yyy[n].py+csb[fff].pos[1];
                            end;
                            end;

                            // rotation around x


                            end;

                            {yyy[n]:=MatrixVertex(yyy[n],MapSection[m].Rotation);
                            yyy[n].px:=yyy[n].px+MapSection[m].dx;
                            yyy[n].pz:=-(yyy[n].pz+MapSection[m].dy);
                            yyy[n].py:=yyy[n].py+MapSection[m].dz;    }

                            //self.Area[m].Groupeb[l].Indexs[0].

                            move(n, pansichar(pp)[e*2],2);
                            inc(e);
                            inc(n);
                            dec(o);
                        end;
                         self.Area[m].Groupeb[l].Indexs[self.Area[m].Groupeb[l].IndexListCount-1].g_pIB.Unlock;
                        //read the texture number

                    end;

                    self.Area[m].Groupeb[l].VertexCount:=n;

                    if n > 0 then begin
                    self.Area[m].Groupeb[l].VertexSize:=24;
                    self.Area[m].Groupeb[l].VertexType:=
                        D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1;
                    if buf[0] <> nil then
                        freemem(buf[0]);
                    if buf[1] <> nil then
                        freemem(buf[1]);
                    if buf[2] <> nil then
                        freemem(buf[2]);
                    buf[0]:=nil;
                    buf[1]:=nil;
                    buf[2]:=nil;


                    //reserve memory
                    if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Area[m].Groupeb[l].VertexCount*24
                        ,0,self.Area[m].Groupeb[l].VertexType,D3DPOOL_DEFAULT
                        ,self.Area[m].Groupeb[l].g_pVB ,0)) then exit;
                    self.Area[m].Groupeb[l].g_pVB.Lock(0,self.Area[m].Groupeb[l].VertexCount*24,pp,0);

                    move(yyy[0],pansichar(pp)[0],self.Area[m].Groupeb[l].VertexCount*24);

                    self.Area[m].Groupeb[l].SurfaceType:=D3DPT_TRIANGLEstrip;
                    self.Area[m].Groupeb[l].g_pVB.Unlock;
                    end;

                end;


     if csb[csbp].child <> 0 then
        ProcedeChuck(csb[csbp].child);
     dec(csbp);
     if csb[csbp+1].sibling <> 0 then
        ProcedeChuck(csb[csbp+1].sibling);

end;

begin
    result:=false;
    self.usematris:=true;
    UseTextureSetting:=true;
    //load texture
    if self.g_pd3dDevice = nil then exit;
    try
    PSOLoadtexture(TextureFileName);
    except
    end;
    self.UseGcsetting:=true;
    y:=fileopen(Filename,$40);  // open the file
    if y > 0 then begin
        FileSeek(y,-16,2);   //get the pointer to the header area
        fileread(y,r,4);
        fileseek(y,convertdword(r)+8,0);   //seek to the position
        m:=0;
        fileread(y,m,2);     //number of area to read
        m:=convertword(m);
        fileread(y,r,2);
        fileread(y,r,4);
        fileread(y,r,4);     //pointer to first area data
        r:=convertdword(r);
        fileseek(y,r,0);
        MapSectionCount:=m;
        setlength(MapSection,m);        //prepare the memory to receive the data
        fileread(y,MapSection[0],m*$34);  //real all the area in 1 block
        setlength(self.Area,m);
        self.AreaCount:=m;
        //convert the data
        BatchConvert(@MapSection[0],m*$34);


        //now load eatch block vertex header
        for m:=0 to MapSectionCount-1 do begin
            self.Area[m].BaseX:=Mapsection[m].dx;
            self.Area[m].Basez:=Mapsection[m].dy;

            D3DXMatrixRotationY( self.Area[m].matrix, MapSection[m].Rotation /10430.378350 );        // Pitch

            // Calculate a translation matrix
            D3DXMatrixTranslation(ma1,MapSection[m].dx,MapSection[m].dz,MapSection[m].dy);
            D3DXMatrixMultiply(self.Area[m].matrix,self.Area[m].matrix,ma1);
            //scale
            D3DXMatrixScaling(ma1,1,1,-1);
            D3DXMatrixMultiply(self.Area[m].matrix,self.Area[m].matrix,ma1);


            self.Area[m].GroupeA_Count:=0;//mapsection[m].VertexA_Count+mapsection[m].VertexB_Count;
            self.Area[m].GroupeB_Count:=0;//mapsection[m].VertexA_Count+mapsection[m].VertexB_Count;
            self.Area[m].AmbientColor:=0;
            setlength( self.Area[m].GroupeA, self.Area[m].GroupeA_Count);
            setlength( self.Area[m].GroupeB, self.Area[m].GroupeB_Count);
            {fillchar(self.Area[m].GroupeA[0],self.Area[m].GroupeA_Count*sizeof(T3DGroupeA),0);
            fillchar(self.Area[m].GroupeB[0],self.Area[m].GroupeB_Count*sizeof(T3DGroupeB),0);   }
            //seek to first 3d chunk of data and read them all
            fileseek(y,MapSection[m].VertexA_Off,0);
            setlength(VBlock,MapSection[m].VertexA_Count);
            fileread(y,VBlock[0],MapSection[m].VertexA_Count*16);
            BatchConvert(@VBlock[0],MapSection[m].VertexA_Count*16);
            fileseek(y,MapSection[m].VertexB_Off,0);
            setlength(eVBlock,MapSection[m].VertexB_Count);
            fileread(y,EvBlock[0],MapSection[m].VertexB_Count*32);
            BatchConvert(@eVBlock[0],MapSection[m].VertexB_Count*32);


             //45 = light
             //40 and 39 = wall

            for ll:=0 to (MapSection[m].VertexA_Count+MapSection[m].VertexB_Count)-1 do begin
                if ll < MapSection[m].VertexA_Count then begin
                if VBlock[ll].Flag and $200 = $200 then begin
                    //the entry is a reference to an existing block data load it
                    fileseek(y,VBlock[ll].Offset,0);
                    fileread(y,VBlock[ll],4);   //get the block pointer
                    BatchConvert(@VBlock[ll],4);
                end;
                if VBlock[ll].Flag and $20 = $20 then begin
                    fileseek(y,VBlock[ll].unknow1,0);
                    fileread(y,slid,4);   //get the block pointer
                    slid:=ConvertWord(slid);
                end else slid:=-1;
                if VBlock[ll].Flag and $40 = $40 then begin
                    fileseek(y,VBlock[ll].unknow2,0);
                    fileread(y,ssid,4);   //get the block pointer
                    ssid:=ConvertWord(ssid);
                end else ssid:=-1;

                csbp:=0;
                ProcedeChuck(VBlock[ll].Offset);
                end else begin
                    if eVBlock[ll-MapSection[m].VertexA_Count].Flag and $200 = $200 then begin
                        //the entry is a reference to an existing block data load it
                        fileseek(y,eVBlock[ll-MapSection[m].VertexA_Count].Offset,0);
                        fileread(y,eVBlock[ll-MapSection[m].VertexA_Count],4);   //get the block pointer
                        BatchConvert(@eVBlock[ll-MapSection[m].VertexA_Count],4);
                    end;
                    if eVBlock[ll-MapSection[m].VertexA_Count].Flag and $20 = $20 then begin
                    fileseek(y,eVBlock[ll-MapSection[m].VertexA_Count].unknow5,0);
                    fileread(y,slid,4);   //get the block pointer
                    slid:=ConvertWord(slid);
                end else slid:=-1;
                if eVBlock[ll-MapSection[m].VertexA_Count].Flag and $40 = $40 then begin
                    fileseek(y,eVBlock[ll-MapSection[m].VertexA_Count].unknow6,0);
                    fileread(y,ssid,4);   //get the block pointer
                    ssid:=ConvertWord(ssid);
                end else ssid:=-1;
                    csbp:=0;
                    if eVBlock[ll-MapSection[m].VertexA_Count].anioff <> 0 then begin
                    fileseek(y,eVBlock[ll-MapSection[m].VertexA_Count].anioff,0);
                    fileread(y,ani,12);
                    BatchConvert(@ani,12);
                    fileseek(y,ani.offset,0);
                    ani.count:=(ani.count and 15);
                    fileread(y,aniinfo,ani.count*8);
                    BatchConvert(@aniinfo,ani.count*8);
                    end else begin
                        fillchar(ani,sizeof(ani),0);
                    end;
                    
                    ProcedeChuck(eVBlock[ll-MapSection[m].VertexA_Count].Offset);
                end;

            end;


        end;
    Fileclose(y);
    result:=true;
    end;

end;

Function TPikaMap.LoadPSOMap(Filename,TextureFileName:ansistring):boolean;
const  D3DFVF_CUSTOMVERTEX = D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE  or D3DFVF_TEX1;
       DXT5_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$00#$01#$00#$00#$00#$01#$00#$00#$00#$00
        +#$01#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$33
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
       DXT1_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$40#$00#$00#$00#$40#$00#$00#$00#$00#$08
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$31
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;

type
TMapSection = Record
        ID:dword;
        dx,dz,dy:single;
        unknow1:dword;
        Rotation:dword;
        unknow3:dword;
        unknow4:single;
        VertexA_Off:dword;
        VertexB_Off:dword;
        VertexA_Count:dword;
        VertexB_Count:dword;
        unknow8:dword;
    end;
    TBlockVertex = record
        Offset:dword;
        unknow1:dword;
        unknow2:dword;
        Flag:dword;
    end;
    TExtendedBlockVertex = record
        Offset:dword;
        anioff:dword;
        unknow2:dword;
        unknow3:dword;
        speed:single;
        unknow5:dword;
        unknow6:dword;
        Flag:dword;
    end;
    Tani = record
        offset:dword;
        Frame:dword;
        flag:word;
        count:word;
    end;
    TAniInfo = record
        data:array[0..8] of dword;
    end;

    TpsoMapChange = record
        flag:array[0..1] of dword;
        pos:array[0..2] of single;
        rot:array[0..2] of dword;
        scale:array[0..2] of single;
        child:dword;
        sibling:dword;
        stat:dword;
    end;
TXVMHeader = record
        Flag:dword;
        Size:dword;
        count:dword;
        unused:array[0..12] of dword;
    end;
    TXVRHeader = record
        Flag:dword;
        Size:dword;
        PixelFormat:dword;
        DXTFormat:dword;
        ID:Dword;
        sx,sy:word;
        DataSize:dword;
        unused:array[0..8] of dword;
    end;
Function MakeRVB(t:integer):integer;
var c:integer;
begin
    c:=((t div $400) and $1F) *8;
    c:=c+((((t div $20) and $1f) *8)*256);
    c:=c+((((t div $1) and $1f) *8)*65536);
    if t and $7fff = 0 then c:=$10101;
    if t and $8000 <> $8000 then c:=$0;
    result:=c;
end;
Function twiddled_vq(sx:integer;p,p2:pansichar):integer;
var x,y,ptr:integer;
    vqtable:array[0..4*256] of dword;
    c:word;
    TT:array[0..1023] of integer;
    m:pansichar;
    b:Tbitmap;
    ts:Tstream;
begin
    b:=TBitmap.Create;
    b.Width:=sx;
    b.Height:=sx;
    b.TransparentColor:=0;
    b.Transparent:=true;
    ptr:=0;
    for x:=0 to 1023 do
    tt[x] := (x and 1)or((x and 2)*2)or((x and 4)*4)or((x and 8)*8)or((x and 16)*16)or
      ((x and 32)*32)or((x and 64)*64)or((x and 128)*128)or((x and 256)*256)or((x and 512)*512);
    for x:=0 to 1023 do
    begin
       vqtable[x]:=MakeRVB(byte(p[ptr])+(byte(p[ptr+1])*256));
       ptr:=ptr+2;
    end;
    m:=@p[ptr];
    for y:=0 to (sx div 2)-1 do
        for x:=0 to (sx div 2)-1 do begin
            c:=byte(m[tt[y] or (tt[x]*2)]);
            //vq:=@vqtable[c*4];
            b.Canvas.Pixels[x*2,y*2]:=vqtable[(c*4)];
            b.Canvas.Pixels[(x*2)+1,y*2]:=vqtable[(c*4)+2];
            b.Canvas.Pixels[x*2,(y*2)+1]:=vqtable[(c*4)+1];
            b.Canvas.Pixels[(x*2)+1,(y*2)+1]:=vqtable[(c*4)+3];
        end;
    ts:=TMemoryStream.Create;
    b.SaveToStream(ts);
    result:=ts.Size;
    ts.Position:=0;
    ts.ReadBuffer(p2[0],result);
    ts.Free;
end;
Function PSOLoadTexture(s:ansistring):boolean;
var h:TXVMHeader;
    b:TXVRHeader;
    f,f2,i,x:integer;
    p,p2:pansichar;
begin
    f:=fileopen(s,$40); //open xvm file
    fileread(f,h,$40);  //read the header
    setlength( self.texture ,h.count); //set texture memory
    setlength(self.texFlag,h.count); //set texture flag memory
    self.TextureCount:=h.count;
    for i:=0 to h.count-1 do begin
        fileread(f,b,$40); //read the xvr header
        p:=allocmem(b.Size+128); //reserve memory for data+DDS header
        fileread(f,p[128],b.Size-$38); //read the data
        texFlag[i]:=b.PixelFormat;
        if b.DXTFormat = 3 then begin
            //old format, convert to bmp first
            self.texFlag[i]:=0;
            p2:=allocmem(3000000);
            x:=twiddled_vq(b.sx,@p[128],p2);
            D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p2,x,self.texture[i]);
            freemem(p2);
        end else begin
        if b.DXTFormat = 6 then move(DXT1_Header[1],p[0],128) //DXT1 header
        else move(DXT5_Header[1],p[0],128); //DXT3 header
        move(b.sx,p[12],2); //set the X size
        move(b.sy,p[16],2); //set the Y size
        move(b.datasize,p[20],4); //set the data size

        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p,b.DataSize+128,self.texture[i]);
        end;
        freemem(p);
    end;
    fileclose(f);
end;
Function MatrixVertex(ve:T3DVertex;njo,v1,v2:integer):T3DVertex;
var re:T3DVertex;
    r,sx,cx,sy,cy,sz,cz,xy,xz,yz,yx,zx,zy:single;
    i:integer;
begin
    re:=ve;
        sx := sin((v1 and $ffff)/ 10430.378350);
        cx := cos((v1 and $ffff)/ 10430.378350);
        sy := sin((njo and $ffff)/ 10430.378350);
        cy := cos((njo and $ffff)/ 10430.378350);
        sz := sin((v2 and $ffff)/ 10430.378350);
        cz := cos((v2 and $ffff)/ 10430.378350);
       

        xy := cx*(re.py) - sx*(re.pz);
        xz := sx*(re.py) + cx*(re.pz);
        // rotation around y
        yz := cy*xz - sy*(re.px);
        yx := sy*xz + cy*(re.px);
        // rotation around z
        zx := cz*yx - sz*xy;
        zy := sz*yx + cz*xy;

        re.px:=zx;
        re.py:=zy;
        re.pz:=yz;
    result:=re;
end;
var y,r,m,l,MapSectionCount,c,c2,ic,ic2,q,o,e,k,f,lv,ll:integer;
    mapsection:array of TMapSection;
    vblock:array of TBlockVertex;
    evblock:array of TExtendedBlockVertex;
    Basept:array[0..50] of TpsoMapChange;
    pp,pv:pointer;
    re:Single;
    ver:array[0..20] of single;
    yyy:T3DVertex;
    curmat:td3dmaterial9;
    CurTrans:dword;
    mo1,mo2,als:dword;
    aniinfo:TAniInfo;
    ani:TAni;
    ma1:td3dmatrix;
    tex:integer;
    tre:array[0..4] of dword;
    slid,ssid:integer;
    //a:ansistring;
    //ts:tansistringlist;
begin
    result:=false;
    mo1:=0;
    mo2:=0;
    self.UseTextureSetting:=true;
    //ts:=Tansistringlist.Create;
    //load texture
    if self.g_pd3dDevice = nil then exit;
    try
    if fileexists(TextureFileName) then
        PSOLoadtexture(TextureFileName);
    except
    end;
    usealpha:=true;
    usematris:=true;
    y:=fileopen(Filename,$40);  // open the file
    if y > 0 then begin
        FileSeek(y,-16,2);   //get the pointer to the header area
        fileread(y,r,4);
        fileseek(y,r+8,0);   //seek to the position
        fileread(y,m,4);     //number of area to read
        fileread(y,r,4);
        fileread(y,r,4);     //pointer to first area data
        fileseek(y,r,0);
        //read all the map data amount of M at pointer R
        MapSectionCount:=m;
        setlength(MapSection,m);        //prepare the memory to receive the data
        fileread(y,MapSection[0],m*$34);  //real all the area in 1 block
        setlength(self.Area,m);
        self.AreaCount:=m;
        //now load eatch block vertex header
        for m:=0 to MapSectionCount-1 do begin
            self.Area[m].BaseX:=Mapsection[m].dx;
            self.Area[m].Basez:=-Mapsection[m].dy;
            self.Area[m].AmbientColor:=0;
              D3DxMatrixidentity(self.Area[m].matrix);
            D3DXMatrixRotationY( self.Area[m].matrix, ((MapSection[m].Rotation/$8003) * pi) );        // Pitch
            //
            // Calculate a translation matrix
            D3DXMatrixTranslation(ma1,MapSection[m].dx,MapSection[m].dz,MapSection[m].dy);
            D3DXMatrixMultiply(self.Area[m].matrix,self.Area[m].matrix,ma1);
            //self.Area[m].matrix:=ma1;
            //scale
            D3DXMatrixScaling(ma1,1,1,-1);
            D3DXMatrixMultiply(self.Area[m].matrix,self.Area[m].matrix,ma1);

            //seek to first 3d chunk of data and read them all
            fileseek(y,MapSection[m].VertexA_Off,0);
            setlength(VBlock,MapSection[m].VertexA_Count);
            fileread(y,VBlock[0],MapSection[m].VertexA_Count*16);

            fileseek(y,MapSection[m].VertexB_Off,0);
            setlength(EVBlock,MapSection[m].VertexB_Count);
            fileread(y,EVBlock[0],MapSection[m].VertexB_Count*32);

            for l:=0 to MapSection[m].VertexA_Count+MapSection[m].VertexB_Count-1 do begin
                if l < MapSection[m].VertexA_Count then begin
                if VBlock[l].Flag and $4 = $4 then begin
                    //the entry is a reference to an existing block data load it
                    fileseek(y,VBlock[l].Offset,0);
                    fileread(y,VBlock[l],4);   //get the block pointer
                end;
                if VBlock[l].Flag and $20 = $20 then begin
                    fileseek(y,VBlock[l].unknow1,0);
                    fileread(y,slid,4);
                end else slid:=-1;
                if VBlock[l].Flag and $40 = $40 then begin
                    fileseek(y,VBlock[l].unknow2,0);
                    fileread(y,ssid,4);
                end else ssid:=-1;

                fileseek(y,VBlock[l].Offset,0);
                end else begin
                    if eVBlock[l-MapSection[m].VertexA_Count].Flag and $4 = $4 then begin
                        //the entry is a reference to an existing block data load it
                        fileseek(y,eVBlock[l-MapSection[m].VertexA_Count].Offset,0);
                        fileread(y,eVBlock[l-MapSection[m].VertexA_Count],4);   //get the block pointer
                    end;
                    if eVBlock[l-MapSection[m].VertexA_Count].Flag and $20 = $20 then begin
                        fileseek(y,eVBlock[l-MapSection[m].VertexA_Count].unknow5,0);
                        fileread(y,slid,4);
                    end else slid:=-1;
                    if eVBlock[l-MapSection[m].VertexA_Count].Flag and $40 = $40 then begin
                        fileseek(y,eVBlock[l-MapSection[m].VertexA_Count].unknow6,0);
                        fileread(y,ssid,4);
                    end else ssid:=-1;


                    //load the motion info
                    fileseek(y,eVBlock[l-MapSection[m].VertexA_Count].anioff,0);
                    fileread(y,ani,12);
                    fileseek(y,ani.offset,0);
                    ani.count:=(ani.count and 15);
                    fileread(y,aniinfo,ani.count*8);


                    fileseek(y,eVBlock[l-MapSection[m].VertexA_Count].Offset,0);

                end;
                lv:=0;
                while lv > -1 do begin
                fileread(y,BasePt[lv],52);
                BasePt[lv].stat:=0;
                r:=basept[lv].flag[1];   //get the block pointer
                if r <> 0 then begin
                    inc(self.Area[m].GroupeA_Count);
                    inc(self.Area[m].GroupeB_Count);
                    ll:=self.Area[m].GroupeA_Count-1;
                    setlength( self.Area[m].GroupeA, self.Area[m].GroupeA_Count);
                    setlength( self.Area[m].GroupeB, self.Area[m].GroupeB_Count);
                    //if slid = 0 then slid := -1;
                    self.Area[m].GroupeA[ll].textslideid:=slid;
                    self.Area[m].Groupeb[ll].textslideid:=slid;
                    self.Area[m].Groupea[ll].textswapid:=ssid;
                    self.Area[m].Groupeb[ll].textswapid:=ssid;

                    if l >= MapSection[m].VertexA_Count then begin
                    //read the motion
                    self.Area[m].GroupeA[ll].motionframe:=ani.Frame*2;
                    self.Area[m].GroupeA[ll].motiontime:=ani.Frame*66;
                    self.Area[m].GroupeA[ll].usemotion:=true;
                    o:=0;
                    if ani.flag and 1 = 1 then begin
                    if aniinfo.data[o] <> 0 then begin
                        self.Area[m].GroupeA[ll].motionposcount:=aniinfo.data[ani.count+o];
                        setlength(self.Area[m].GroupeA[ll].motionpos,aniinfo.data[ani.count+o]);
                        fileseek(y,aniinfo.data[o],0);
                        fileread(y,self.Area[m].GroupeA[ll].motionpos[0],aniinfo.data[ani.count+o]*16);
                        for f:=0 to aniinfo.data[ani.count+o]-1 do
                            self.Area[m].GroupeA[ll].motionpos[f].id:=self.Area[m].GroupeA[ll].motionpos[f].id*2;
                    end;
                    inc(o);
                    end;
                    if ani.flag and 2 = 2 then begin
                    if aniinfo.data[o] <> 0 then begin
                        fileseek(y,aniinfo.data[o],0);
                        self.Area[m].GroupeA[ll].motionangcount:=aniinfo.data[ani.count+o];
                        setlength(self.Area[m].GroupeA[ll].motionang,aniinfo.data[ani.count+o]);
                        fileread(y,self.Area[m].GroupeA[ll].motionang[0],aniinfo.data[ani.count+o]*16);
                        for f:=0 to aniinfo.data[ani.count+o]-1 do
                            self.Area[m].GroupeA[ll].motionang[f].id:=self.Area[m].GroupeA[ll].motionang[f].id*2;

                    end;
                    inc(o);
                    end;

                    if ani.flag and 4 = 4 then begin
                    if aniinfo.data[o] <> 0 then begin
                        fileseek(y,aniinfo.data[o],0);
                        self.Area[m].GroupeA[ll].motionscalecount:=aniinfo.data[ani.count+o];
                        setlength(self.Area[m].GroupeA[ll].motionsca,aniinfo.data[ani.count+o]);
                        fileread(y,self.Area[m].GroupeA[ll].motionsca[0],aniinfo.data[ani.count+o]*16);
                        for f:=0 to aniinfo.data[ani.count+o]-1 do
                            self.Area[m].GroupeA[ll].motionsca[f].id:=self.Area[m].GroupeA[ll].motionsca[f].id*2;

                    end;
                    inc(o);
                    end;



                    move(BasePt[0].pos[0],self.Area[m].GroupeA[ll].defaultpos,12);
                    move(BasePt[0].rot[0],self.Area[m].GroupeA[ll].defaultrot,12);
                    move(BasePt[0].scale[0],self.Area[m].Groupea[ll].defaultscale,12);
               

                    self.Area[m].Groupeb[ll].motionframe:=ani.Frame*2;
                    self.Area[m].Groupeb[ll].motionposcount:=self.Area[m].Groupea[ll].motionposcount;
                    self.Area[m].Groupeb[ll].motionangcount:=self.Area[m].Groupea[ll].motionangcount;
                    self.Area[m].Groupeb[ll].motionscalecount:=self.Area[m].Groupea[ll].motionscalecount;
                    self.Area[m].Groupeb[ll].motiontime:=ani.Frame*66;
                    setlength(self.Area[m].Groupeb[ll].motionpos,self.Area[m].Groupea[ll].motionposcount);
                    setlength(self.Area[m].Groupeb[ll].motionang,self.Area[m].Groupea[ll].motionangcount);
                    setlength(self.Area[m].Groupeb[ll].motionsca,self.Area[m].Groupea[ll].motionscalecount);
                    if self.Area[m].Groupea[ll].motionposcount <> 0 then begin
                        move(self.Area[m].GroupeA[ll].motionpos[0],self.Area[m].GroupeB[ll].motionpos[0],self.Area[m].Groupea[ll].motionposcount*16);
                    end;
                    if self.Area[m].Groupea[ll].motionangcount <> 0 then begin
                        move(self.Area[m].GroupeA[ll].motionang[0],self.Area[m].GroupeB[ll].motionang[0],self.Area[m].Groupea[ll].motionangcount*16);
                    end;
                    if self.Area[m].Groupea[ll].motionscalecount <> 0 then begin
                        move(self.Area[m].GroupeA[ll].motionsca[0],self.Area[m].GroupeB[ll].motionsca[0],self.Area[m].Groupea[ll].motionscalecount*16);
                    end;
                    move(BasePt[0].pos[0],self.Area[m].Groupeb[ll].defaultpos,12);
                    move(BasePt[0].rot[0],self.Area[m].Groupeb[ll].defaultrot,12);
                    move(BasePt[0].scale[0],self.Area[m].Groupeb[ll].defaultscale,12);
                    self.Area[m].Groupeb[ll].usemotion:=true;
                    end;


                    tex:=-1;
                    fileseek(y,r+4,0);
                    fileread(y,r,4);    //pointer to information of the vertex list
                    //the indice list
                    fileread(y,c,4);
                    fileread(y,c,4);    //go read teh first indice list
                    fileread(y,ic,4);   //number of list
                    fileread(y,c2,4);    //go read teh next indice list
                    fileread(y,ic2,4);   //number of list
                    self.Area[m].GroupeA[ll].IndexListCount:=ic;
                    self.Area[m].GroupeB[ll].IndexListCount:=ic2;
                    setlength(self.Area[m].GroupeA[ll].indexs,ic);
                    setlength(self.Area[m].GroupeB[ll].indexs,ic2);
            
                    for f:=0 to ic-1 do begin  //load eatch of them (eatch one make an item or object)
                        fileseek(y,c,0);  //seek to the entry
                        inc(c,20);        //prepare for next entry
                        fileread(y,q,4);
                        fileread(y,o,4);
                        fileread(y,e,4);  //get the offset
                        fileread(y,k,4);  //get the amount of index

                        fileseek(y,e,0);  //seek to it
                        self.Area[m].GroupeA[ll].Indexs[f].IndexCount:=k;
                        self.Area[m].GroupeA[ll].Indexs[f].SurfaceCount:=k-2;
                        if Failed( self.g_pd3dDevice.CreateIndexBuffer(k*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT,self.Area[m].GroupeA[ll].Indexs[f].g_pIB,nil)) then
                            begin
                            showmessage('erreur');
                            exit;
                            end;
                        self.Area[m].GroupeA[ll].Indexs[f].g_pIB.Lock(0,k*2,pp,0);
                        fileread(y,pansichar(pp)[0],k*2); //read them all
                        self.Area[m].GroupeA[ll].Indexs[f].g_pIB.Unlock;
                        //read the texture number
                        if f>0 then begin
                            self.Area[m].GroupeA[ll].Indexs[f].alphasrc:=self.Area[m].GroupeA[ll].Indexs[f-1].alphasrc;
                            self.Area[m].GroupeA[ll].Indexs[f].alphadst:=self.Area[m].GroupeA[ll].Indexs[f-1].alphadst;
                        end;
                        if o <> 0 then begin
                            while o > 0 do begin


                                {fileseek(y,q,0);
                                fileread(y,tre[0],16);
                                //showmessage(inttohex(tre[0],8)+' '+inttohex(tre[1],8)+' '+inttohex(tre[2],8)+' '+inttohex(tre[3],8));
                                form2.Memo1.Lines.Add(inttohex(tre[0],8)+' '+inttohex(tre[1],8)+' '+inttohex(tre[2],8)+' '+inttohex(tre[3],8));
                                  }
                                fileseek(y,q,0);
                                fileread(y,k,4);
                                //if m = 22 then

                                if k = 4 then begin
                                   fileread(y,mo1,4);
                                   fileread(y,mo2,4);
                                   mo1:=3-mo1;
                                   mo2:=3-mo2;
                                end;

                                //6 = use material?

                                if k = 7 then begin  //no texture
                                   fileread(y,als,4);
                                   if als <> 0 then
                                    tex:=-1;//self.Area[m].GroupeA[ll].Indexs[f].TextureID:=-1;
                                end;


                                if k = 3 then begin
                                    fileread(y,tex,4);//self.Area[m].GroupeA[ll].Indexs[f].TextureID,4);
                                    if extractfilename(filename)='map_darkfalz00n.rel' then
                                    if tex = 18 then begin
                                        self.Area[m].GroupeA[ll].Indexs[f].alphasrc:=3;
                                        self.Area[m].GroupeA[ll].Indexs[f].alphadst:=1;
                                    end;
                                end;
                                if k = 2 then begin
                                    fileread(y,self.Area[m].GroupeA[ll].Indexs[f].alphasrc,4);
                                    fileread(y,self.Area[m].GroupeA[ll].Indexs[f].alphadst,4);
                                    if (self.Area[m].GroupeA[ll].Indexs[f].alphadst = 1) and
                                        (self.Area[m].GroupeA[ll].Indexs[f].alphasrc = 3) then
                                        self.Area[m].GroupeA[ll].Indexs[f].alphasrc:=2;

                                    end;

                                dec(o);
                                inc(q,16);
                            end;
                        end;{ else if f>0 then self.Area[m].GroupeA[ll].Indexs[f].TextureID:=self.Area[m].GroupeA[ll].Indexs[f-1].TextureID //last used texture
                        else self.Area[m].GroupeA[ll].Indexs[f].TextureID:=0; //if no texture then set 0 in case     }
                        self.Area[m].GroupeA[ll].Indexs[f].TextureID:=tex;
                        //form2.Memo1.Lines.Add(' ');
                        self.Area[m].GroupeA[ll].Indexs[f].tus:=mo1;
                        self.Area[m].GroupeA[ll].Indexs[f].tvs:=mo2;
                    end;
                    for f:=0 to ic2-1 do begin  //load eatch of them (eatch one make an item or object)
                        fileseek(y,c2,0);  //seek to the entry
                        inc(c2,20);        //prepare for next entry
                        fileread(y,q,4);
                        fileread(y,o,4);
                        fileread(y,e,4);  //get the offset
                        fileread(y,k,4);  //get the amount of index
                        fileseek(y,e,0);  //seek to it
                        self.Area[m].GroupeB[ll].Indexs[f].IndexCount:=k;
                        self.Area[m].GroupeB[ll].Indexs[f].SurfaceCount:=k-2;
                        if Failed( self.g_pd3dDevice.CreateIndexBuffer(
                                k*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT
                                ,self.Area[m].GroupeB[ll].Indexs[f].g_pIB,nil)) then begin
                                 showmessage('erreur');
                                 exit;
                                 end;
                        self.Area[m].GroupeB[ll].Indexs[f].g_pIB.Lock(0,k*2,pp,0);
                        fileread(y,pansichar(pp)[0],k*2); //read them all
                        move(pansichar(pp)[0],self.Area[m].GroupeB[ll].Indexs[f].RefX,2);
                        self.Area[m].GroupeB[ll].Indexs[f].g_pIB.Unlock;
                        //read the texture number
                        if f>0 then begin
                            self.Area[m].GroupeB[ll].Indexs[f].alphasrc:=self.Area[m].GroupeB[ll].Indexs[f-1].alphasrc;
                            self.Area[m].GroupeB[ll].Indexs[f].alphadst:=self.Area[m].GroupeB[ll].Indexs[f-1].alphadst;
                        end;
                        if o <> 0 then begin
                            while o > 0 do begin
                                {fileseek(y,q,0);
                                fileread(y,tre[0],16);
                                //showmessage(inttohex(tre[0],8)+' '+inttohex(tre[1],8)+' '+inttohex(tre[2],8)+' '+inttohex(tre[3],8));
                                form2.Memo1.Lines.Add(inttohex(tre[0],8)+' '+inttohex(tre[1],8)+' '+inttohex(tre[2],8)+' '+inttohex(tre[3],8));
                                       }
                                fileseek(y,q,0);
                                fileread(y,k,4);
                                if k = 3 then begin
                                    fileread(y,tex,4);//self.Area[m].Groupeb[ll].Indexs[f].TextureID,4);
                                    if extractfilename(filename)='map_darkfalz00n.rel' then
                                    if tex = 18 then begin
                                        self.Area[m].Groupeb[ll].Indexs[f].alphasrc:=3;
                                        self.Area[m].Groupeb[ll].Indexs[f].alphadst:=1;
                                    end;
                                    end;
                                if k = 2 then begin
                                    fileread(y,self.Area[m].Groupeb[ll].Indexs[f].alphasrc,4);
                                    fileread(y,self.Area[m].Groupeb[ll].Indexs[f].alphadst,4);
                                    if (self.Area[m].Groupeb[ll].Indexs[f].alphadst = 1) and
                                        (self.Area[m].Groupeb[ll].Indexs[f].alphasrc = 3) then begin
                                        self.Area[m].Groupeb[ll].Indexs[f].alphasrc:=2;
                                        //self.Area[m].Groupeb[ll].Indexs[f].alphadst:=3;
                                        end;
                                
                                    end;
                                if k = 4 then begin
                                   fileread(y,mo1,4);
                                   fileread(y,mo2,4);
                                   mo1:=3-mo1;
                                   mo2:=3-mo2;
                                end;
                                if k = 6 then begin //use material?
                                   fileread(y,als,4);
                                   if als = 0 then als:=D3DTA_DIFFUSE
                                   else als:=D3DTA_TEXTURE;
                                end;

                                if k = 7 then begin  //no texture
                                   fileread(y,als,4);
                                   if als <> 0 then tex:=-1;//self.Area[m].Groupeb[ll].Indexs[f].TextureID:=-1;
                                end;

                                dec(o);
                                inc(q,16);
                            end;

                        end; {else if f>0 then begin
                            self.Area[m].GroupeB[ll].Indexs[f].TextureID:=self.Area[m].GroupeB[ll].Indexs[f-1].TextureID; //last used texture
                        end
                        else begin
                            self.Area[m].GroupeB[ll].Indexs[f].TextureID:=0; //if no texture then set 0 in case
                            self.Area[m].GroupeB[ll].Indexs[f].alphasrc:=4;
                            self.Area[m].GroupeB[ll].Indexs[f].alphadst:=5;
                        end;  }
                        self.Area[m].GroupeB[ll].Indexs[f].TextureID:=tex;
                        //form2.Memo1.Lines.Add(' ');

                        //self.Area[m].GroupeB[ll].Indexs[f].material:=curmat;
                        self.Area[m].GroupeB[ll].Indexs[f].tus:=mo1;
                        self.Area[m].GroupeB[ll].Indexs[f].tvs:=mo2;

                        if self.TextureCount> self.Area[m].GroupeB[ll].Indexs[f].TextureID then
                        if self.TexFlag[ self.Area[m].GroupeB[ll].Indexs[f].TextureID ] > 1 then
                            self.Area[m].GroupeB[ll].Indexs[f].AlphaSource:=D3DTA_TEXTURE
                        else self.Area[m].GroupeB[ll].Indexs[f].AlphaSource:=D3DTA_DIFFUSE;

                        //self.Area[m].GroupeB[ll].Indexs[f].AlphaSource:=als;

                        //self.Area[m].GroupeB[ll].Indexs[f].AlphaSource:=als;
                        {if curtrans < 1 then self.Area[m].GroupeB[ll].Indexs[f].AlphaSource:=D3DTA_DIFFUSE;
                        if curtrans >= 1 then self.Area[m].GroupeB[ll].Indexs[f].AlphaSource:=D3DTA_TEXTURE; }
                    end;

                    fileseek(y,r,0);  //final pointer to the header, seek to it
                    fileread(y,r,4);
                    //a:=inttohex(r,2);
                    fileread(y,r,4); //data offset
                    fileread(y,c,4); //size of 1 vertex
                    //a:=a+' '+ inttohex(c,2);
                    //if ts.IndexOf(a) = -1 then ts.Add(a);
                    fileread(y,self.Area[m].GroupeA[ll].VertexCount,4); //amount of vertex
                    self.Area[m].GroupeA[ll].VertexSize:=c;                          
                    if c = $24 then self.Area[m].GroupeA[ll].VertexType:=
                        D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE  or D3DFVF_TEX1
                    else if c = $1c then self.Area[m].GroupeA[ll].VertexType:=
                        D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE
                    else if c = $18 then self.Area[m].GroupeA[ll].VertexType:=
                        D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1
                    else if c = $10 then self.Area[m].GroupeA[ll].VertexType:=
                        D3DFVF_XYZ or D3DFVF_DIFFUSE
                    else if c = $20 then self.Area[m].GroupeA[ll].VertexType:=
                        D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_TEX1;
                    //else showmessage('Unknow vertex format');
                    r:=fileseek(y,r,0);  //load the vertex list
                    //reserve memory
                    if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Area[m].GroupeA[ll].VertexCount*c
                        ,0,self.Area[m].GroupeA[ll].VertexType,D3DPOOL_DEFAULT
                        ,self.Area[m].GroupeA[ll].g_pVB ,0)) then
                            begin
                            showmessage(format('%d %d %d %d %d',[m,ll,self.Area[m].GroupeA[ll].VertexCount,c,self.Area[m].GroupeA[ll].VertexType]));
                            exit;
                            end;
                    self.Area[m].GroupeA[ll].g_pVB.Lock(0,self.Area[m].GroupeA[ll].VertexCount*c,pp,0);
                    for o:=0 to self.Area[m].GroupeA[ll].VertexCount-1 do begin
                        //load the vertex
                        fileread(y,ver[0],c);
                        re:=0;
                        //if MapSection[m].Rotation <> 0 then begin




                        yyy.px:=ver[0];
                        yyy.py:=ver[1];
                        yyy.pz:=ver[2];
                        for r:=lv downto 0 do begin
                        if (r > 0) or (l < MapSection[m].VertexA_Count) then begin
                        if basept[r].flag[0] and 4 = 0 then begin
                        yyy.px:=yyy.px*Basept[r].scale[0];
                        yyy.py:=yyy.py*Basept[r].scale[1];
                        yyy.pz:=yyy.pz*BasePt[r].scale[2];
                        end;

                        if basept[r].flag[0] and 2 = 0 then
                            yyy:=MatrixVertex(yyy,basept[r].rot[1],basept[r].rot[0],basept[r].rot[2]);

                        if basept[r].flag[0] and 1 = 0 then begin
                        yyy.px:=yyy.px+Basept[r].pos[0];
                        yyy.py:=yyy.py+Basept[r].pos[1];
                        yyy.pz:=yyy.pz+BasePt[r].pos[2];
                        end;
                        end;

                        end;


                        {yyy:=MatrixVertex(yyy,MapSection[m].Rotation,0,0);
                        ver[0]:=yyy.px;
                        ver[1]:=yyy.py;
                        ver[2]:=yyy.pz;

                        ver[0]:=ver[0]+MapSection[m].dx;
                        ver[2]:=-(ver[2]+MapSection[m].dy);
                        ver[1]:=ver[1]+MapSection[m].dz;  }


                        ver[0]:=yyy.px;
                        ver[1]:=yyy.py;
                        ver[2]:=yyy.pz;

                        
                        move(ver[0],pansichar(pp)[o*c],c);
                    end;
                    //set base xz for eatch indice
                    for o:=0 to self.Area[m].GroupeB[ll].IndexListCount-1 do begin
                        move(pansichar(pp)[round(self.Area[m].GroupeB[ll].indexs[o].refx)*c+8],
                            self.Area[m].GroupeB[ll].indexs[o].refZ , 4);
                        move(pansichar(pp)[round(self.Area[m].GroupeB[ll].indexs[o].refx)*c],
                            self.Area[m].GroupeB[ll].indexs[o].refX , 4);
                    end;
                    self.Area[m].GroupeA[ll].SurfaceType:=D3DPT_TRIANGLESTRIP;
                    self.Area[m].GroupeB[ll].SurfaceType:=D3DPT_TRIANGLESTRIP;
                    self.Area[m].GroupeA[ll].g_pVB.Unlock;
                    self.Area[m].GroupeB[ll].VertexCount:=self.Area[m].GroupeA[ll].VertexCount;
                    self.Area[m].GroupeB[ll].VertexType:=self.Area[m].GroupeA[ll].VertexType;
                    self.Area[m].GroupeB[ll].VertexSize:=self.Area[m].GroupeA[ll].VertexSize;
                    self.Area[m].GroupeB[ll].g_pVB:=self.Area[m].GroupeA[ll].g_pVB;
                end;

                    if (basept[lv].child = 0) and (basept[lv].sibling = 0) then begin
                        fillchar(basept[lv],sizeof(basept[lv]),0);
                        dec(lv);
                    end;

                    o:=0;
                    if lv < 0 then o:=1;
                    while o = 0 do begin
                    inc (basept[lv].stat);
                    if basept[lv].stat = 1 then begin
                        if basept[lv].child = 0 then basept[lv].stat:=2
                        else begin
                            fileseek(y,basept[lv].child,0);
                            o:=1;
                            inc(lv);
                            basept[lv].stat:=0;
                        end;
                    end;
                    if basept[lv].stat = 2 then begin
                        if basept[lv].sibling = 0 then basept[lv].stat:=3
                        else begin
                            fileseek(y,basept[lv].sibling,0);
                            o:=1;
                            //basept[lv].stat:=0;
                        end;
                    end;
                    if basept[lv].stat = 3 then begin
                        fillchar(basept[lv],sizeof(basept[lv]),0);
                        dec(lv);
                    end;
                    if lv < 0 then o:=1;
                    end;

                end;

            end;
        end;
    Fileclose(y);
   // ts.SaveToFile('D:\Program Files\Borland\Delphi6\Projects\pso server\quest editor\debug.txt');
    //ts.Free;
    result:=true;
    end;

end;

Procedure TPikaMap.Select;
begin
    scene.cs.Enter;
    if self.scene <> nil then
        self.scene.Map:=self;
    scene.cs.Leave;
end;

Function TPikaMap.LoadPangyaMap(FileName:ansistring):boolean;
Type
TPangyaVertex = Record
    X,Y,Z:single;
end;
TMyVertex = Record
    X,Y,Z:single;
    Color:Dword;
    Tu,Tv:single;
end;
TPangyaIndex = Record
    Ver:dword;
    R,G,B:dword;
    Tu,Tv:single;
end;
TMapItem = Record
    name:array[0..31] of ansichar;
    MapedPoint:array[0..3] of TPangyaVertex;
    ScaleX,unused1,RotX,unused2,Scaley,unused3,RotY,unused4,ScalZ:single;
    Pos:TPangyaVertex;
end;
TBoneData = Record
    ScaleX,unused1,RotX,unused2,Scaley,unused3,RotY,unused4,ScalZ:single;
    Pos:TPangyaVertex;
    boneid:byte;
end;
Var Vertex:array of TPangyaVertex;
    Index:array of TPangyaIndex;
    MyVertex:array of TMyVertex;
    tex:array of byte;
    boneData:array of TBoneData;
    head,size:dword;
    y,fpos,x,i,vc,sc,c,gbin,itc,l,tc,ctc,v:integer;
    texname:array[0..$2b] of ansichar;
    idx:array of dword;
    s:ansistring;
    pp:pointer;
    MapItem:TMapItem;
Function LoadTexture(Filename:ansistring;i:integer):integer;
var b1,b2:tbitmap;
    j1:tjpegimage;
    x,y,c:integer;
    ms:pansichar;
    header:ansistring;
    p:dword;
begin
    if (lowercase(ExtractFileExt(filename)) = '.jpg') and
        (fileexists(changefileext(filename,'_mask.jpg'))) then begin
        j1:=tjpegimage.Create;
        j1.LoadFromFile(filename);
        b1:=tbitmap.Create;
        b1.PixelFormat:=pf32bit;
        b1.Width:=j1.Width;
        b1.Height:=j1.Height;
        b1.Canvas.Draw(0,0,j1);
        b2:=tbitmap.Create;
        b2.PixelFormat:=pf32bit;
        j1.LoadFromFile(changefileext(filename,'_mask.jpg'));
        b2.Width:=j1.Width;
        b2.Height:=j1.Height;
        b2.Canvas.Draw(0,0,j1);
        j1.Free;
        header:=#$42#$4D#$DA#$1F#$00#$00#$00#$00#$00#$00#$36#$00#$00#$00#$28#$00#$00#$00#$2D#$00#$00#$00#$2D#$00#$00#$00#$01#$00
            +#$20#$00#$00#$00#$00#$00#$A4#$1F#$00#$00#$13#$0B#$00#$00#$13#$0B#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
        c:=b1.Width*b1.height*4;
        move(c,header[$23],4);
        inc(c,$36);
        move(c,header[$3],4);
        p:=b1.Width;
        move(p,header[$13],2);
        p:=b1.height;
        move(p,header[$17],2);
        getmem(ms,c);
        move(header[1],ms[0],$36);
        c:=$36;
        for y:=b1.Height-1 downto 0 do
        for x:=0 to b1.Width-1 do
         begin
            p:=((b1.Canvas.Pixels[x,y] and $ff)*$10000) +
                (b1.Canvas.Pixels[x,y] and $ff00) +
                ((b1.Canvas.Pixels[x,y] and $ff0000) div $10000) +
                ((b2.Canvas.Pixels[x,y] and 255)*$1000000);
            move(p,ms[c],4);
            inc(c,4);
        end;
        b2.Free;
        b1.Free;
        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,ms,c,self.texture[i]);
        //changefileext
    end else D3DXCreateTextureFromFileA(g_pd3dDevice,pansichar(Filename),self.texture[i]);
end;
begin
    result:=false;
    if self.g_pd3dDevice = nil then exit;
    if extractfileext(filename) <> '.gbin' then exit;
    y:=fileopen(changefileext(filename,'.pet'),$40);
    if y <1 then exit;
    fpos:=0;
    while fileread(y,head,4) = 4 do begin
        fileread(y,size,4);
        if head = $54584554 then begin //Texture info
            fileread(y,x,4); //texture count
            self.TextureCount:=x;
            setlength(self.Texture,x);
            for i:=0 to x-1 do begin
                fileread(y,texname[0],$2c);
                s:=extractfilepath(filename)+pansichar(@texname[0]);//+#0#0;
                //D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[i]);
                LoadTexture(s,i);
            end;
        end;
        if head = $4853454d then begin //Mesh info
            fileread(y,vc,4); //vertex count
            setlength(vertex,vc);
            x:=0;
            for i:=0 to vc-1 do begin
                fileread(y,vertex[i],12);
                fileread(y,x,2);
                fileread(y,c,2);
                c:=(c and 255)+(x and 255);
                while c < 255 do begin
                    fileread(y,x,2);
                    inc(c,x and 255);
                end;
            end;
            fileread(y,sc,4); //surface count
            setlength(index,sc*3);
            setlength(tex,sc);
            fileread(y,index[0],sc*72);
            fileread(y,tex[0],sc); //texture id
        end;
        inc(fpos,size+8);
        fileseek(y,fpos,0);
    end;
    Fileclose(y);
    //set all var
    setlength(MyVertex,sc*3);
    setlength(idx,sc*3);
    self.AreaCount:=1;
    setlength(self.area,1);
    self.Area[0].GroupeA_Count:=1;
    self.Area[0].GroupeB_Count:=0;
    self.Area[0].BaseX:=0;
    self.Area[0].BaseZ:=0;
    self.Area[0].AmbientColor:=0;
    setlength(self.area[0].GroupeA,1);
    self.area[0].GroupeA[0].IndexListCount:=self.TextureCount;
    setlength(self.area[0].GroupeA[0].Indexs,self.TextureCount);
    self.area[0].GroupeA[0].VertexType:=D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1;
    self.area[0].GroupeA[0].SurfaceType:=D3DPT_TRIANGLELIST;
    self.area[0].GroupeA[0].VertexSize:=24;
    //realing all the data
    x:=0;
    for i:=0 to self.TextureCount-1 do begin
        self.area[0].GroupeA[0].Indexs[i].TextureID:=i;
        c:=0;
        for y:=0 to sc-1 do
            if tex[y] =  i then begin
                MyVertex[x].X:=vertex[Index[y*3].Ver].x;
                MyVertex[x].y:=vertex[Index[y*3].Ver].y;
                MyVertex[x].z:=vertex[Index[y*3].Ver].z;
                MyVertex[x].Color:=$FFFFFFFF;//(Index[y*3].R div $10000)+(Index[y*3].G div $100)+Index[y*3].B;
                MyVertex[x].Tu:=Index[y*3].Tu;
                MyVertex[x].Tv:=Index[y*3].Tv;

                MyVertex[x+1].X:=vertex[Index[(y*3)+1].Ver].x;
                MyVertex[x+1].y:=vertex[Index[(y*3)+1].Ver].y;
                MyVertex[x+1].z:=vertex[Index[(y*3)+1].Ver].z;
                MyVertex[x+1].Color:=$FFFFFFFF;//(Index[(y*3)+1].R div $10000)+(Index[(y*3)+1].G div $100)+Index[(y*3)+1].B;
                MyVertex[x+1].Tu:=Index[(y*3)+1].Tu;
                MyVertex[x+1].Tv:=Index[(y*3)+1].Tv;

                MyVertex[x+2].X:=vertex[Index[(y*3)+2].Ver].x;
                MyVertex[x+2].y:=vertex[Index[(y*3)+2].Ver].y;
                MyVertex[x+2].z:=vertex[Index[(y*3)+2].Ver].z;
                MyVertex[x+2].Color:=$FFFFFFFF;//(Index[(y*3)+2].R div $10000)+(Index[(y*3)+2].G div $100)+Index[(y*3)+2].B;
                MyVertex[x+2].Tu:=Index[(y*3)+2].Tu;
                MyVertex[x+2].Tv:=Index[(y*3)+2].Tv;

                idx[c]:=x;
                idx[c+1]:=x+1;
                idx[c+2]:=x+2;
                inc(c,3);
                inc(x,3);
            end;
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(c*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.Area[0].GroupeA[0].Indexs[i].g_pIB,nil)) then exit;
        self.Area[0].GroupeA[0].Indexs[i].g_pIB.Lock(0,c*4,pp,0);
        move(idx[0],pansichar(pp)[0],c*4);
        self.Area[0].GroupeA[0].Indexs[i].g_pIB.Unlock;
        self.Area[0].GroupeA[0].Indexs[i].IndexCount:=c;
        self.Area[0].GroupeA[0].Indexs[i].surfacecount:=c div 3;
    end;
    self.Area[0].GroupeA[0].VertexCount:=x;
    if failed(self.g_pd3dDevice.CreateVertexBuffer(x*24,0,
        self.Area[0].GroupeA[0].VertexType,D3DPOOL_DEFAULT
                ,self.Area[0].GroupeA[0].g_pVB ,0)) then exit;
    self.Area[0].GroupeA[0].g_pVB.lock(0,x*24,pp,0);
    move(myvertex[0],pansichar(pp)[0],x*24);
    self.Area[0].GroupeA[0].g_pVB.unlock;

    //load all the fucking items piko
    gbin:=fileopen(filename,$40);
    fileseek(gbin,8,0);
    fileread(gbin,itc,4);

    self.AreaCount:=1;
    setlength(self.area,1);
    self.Area[0].GroupeB_Count:=itc;
    self.Area[0].BaseX:=0;
    self.Area[0].BaseZ:=0;
    self.Area[0].AmbientColor:=0;
    setlength(self.area[0].GroupeB,itc);

    for l:=0 to itc-1 do begin
    fileseek(gbin,-((l*$ac)+$39),2);
    fileread(gbin,MapItem,sizeof(MapItem));
    s:=extractfilepath(filename)+pansichar(@MapItem.name[0]);
    y:=fileopen(s,$40);
    if y >0 then begin
    fpos:=0;
    while fileread(y,head,4) = 4 do begin
        fileread(y,size,4);
        if head = $54584554 then begin //Texture info
            fileread(y,x,4); //texture count
            ctc:=x;
            tc:=self.TextureCount;
            self.TextureCount:=x+tc;
            setlength(self.Texture,x+tc);
            for i:=0 to x-1 do begin
                fileread(y,texname[0],$2c);
                s:=extractfilepath(filename)+pansichar(@texname[0]);//+#0#0;
                //D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[i]);
                LoadTexture(s,i+tc);
            end;
        end;
        if head = $454e4f42 then begin
            x:=0;
            fileread(y,x,1);
            setlength(boneData,x);
            for i:=0 to x-1 do begin
                c:=1;
                while c <> 0 do fileread(y,c,1);
                fileread(y,boneData[i].boneid,1);
                fileread(y,boneData[i],$30);
            end;
        end;
        if head = $4853454d then begin //Mesh info
            fileread(y,vc,4); //vertex count
            setlength(vertex,vc);
            x:=0;
            for i:=0 to vc-1 do begin
                fileread(y,vertex[i],12);
                fileread(y,x,2);
                fileread(y,c,2);
                //apply the bone here
                v:=x div 256;
                while v <> 255 do begin

                vertex[i].X:=(vertex[i].X*bonedata[v].ScaleX)+bonedata[v].Pos.x;
                vertex[i].y:=(vertex[i].y*bonedata[v].Scaley)+bonedata[v].Pos.y;
                vertex[i].z:=(vertex[i].z*bonedata[v].Scalz)+bonedata[v].Pos.z;
                v:=bonedata[v].boneid;
                end;

                c:=(c and 255)+(x and 255);
                while c < 255 do begin
                    fileread(y,x,2);
                    inc(c,x and 255);
                end;
            end;
            fileread(y,sc,4); //surface count
            setlength(index,sc*3);
            setlength(tex,sc);
            fileread(y,index[0],sc*72);
            fileread(y,tex[0],sc); //texture id
            for i:=0 to sc-1 do
                inc(tex[i],tc);
        end;
        inc(fpos,size+8);
        fileseek(y,fpos,0);
    end;
    Fileclose(y);
    //set all var
    setlength(MyVertex,sc*3);
    setlength(idx,sc*3);


    self.area[0].Groupeb[l].IndexListCount:=ctc;
    setlength(self.area[0].Groupeb[l].Indexs,ctc);
    self.area[0].Groupeb[l].VertexType:=D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1;
    self.area[0].Groupeb[l].SurfaceType:=D3DPT_TRIANGLELIST;
    self.area[0].Groupeb[l].VertexSize:=24;
    //realing all the data
    x:=0;
    for i:=0 to ctc-1 do begin
        self.area[0].Groupeb[l].Indexs[i].TextureID:=i+tc;
        c:=0;
        for y:=0 to sc-1 do
            if tex[y] =  i+tc then begin
                MyVertex[x].X:=(vertex[Index[y*3].Ver].x*mapitem.ScaleX)+mapitem.Pos.X;
                MyVertex[x].y:=(vertex[Index[y*3].Ver].y*mapitem.ScaleY)+mapitem.Pos.y;
                MyVertex[x].z:=(vertex[Index[y*3].Ver].z*mapitem.ScalZ)+mapitem.Pos.z;
                MyVertex[x].Color:=$FFFFFFFF;//(Index[y*3].R div $10000)+(Index[y*3].G div $100)+Index[y*3].B;
                MyVertex[x].Tu:=Index[y*3].Tu;
                MyVertex[x].Tv:=Index[y*3].Tv;

                MyVertex[x+1].X:=(vertex[Index[(y*3)+1].Ver].x*mapitem.ScaleX)+mapitem.Pos.X;
                MyVertex[x+1].y:=(vertex[Index[(y*3)+1].Ver].y*mapitem.ScaleY)+mapitem.Pos.y;
                MyVertex[x+1].z:=(vertex[Index[(y*3)+1].Ver].z*mapitem.ScalZ)+mapitem.Pos.z;
                MyVertex[x+1].Color:=$FFFFFFFF;//(Index[(y*3)+1].R div $10000)+(Index[(y*3)+1].G div $100)+Index[(y*3)+1].B;
                MyVertex[x+1].Tu:=Index[(y*3)+1].Tu;
                MyVertex[x+1].Tv:=Index[(y*3)+1].Tv;

                MyVertex[x+2].X:=(vertex[Index[(y*3)+2].Ver].x*mapitem.ScaleX)+mapitem.Pos.X;
                MyVertex[x+2].y:=(vertex[Index[(y*3)+2].Ver].y*mapitem.ScaleY)+mapitem.Pos.y;
                MyVertex[x+2].z:=(vertex[Index[(y*3)+2].Ver].z*mapitem.ScalZ)+mapitem.Pos.z;
                MyVertex[x+2].Color:=$FFFFFFFF;//(Index[(y*3)+2].R div $10000)+(Index[(y*3)+2].G div $100)+Index[(y*3)+2].B;
                MyVertex[x+2].Tu:=Index[(y*3)+2].Tu;
                MyVertex[x+2].Tv:=Index[(y*3)+2].Tv;

                idx[c]:=x;
                idx[c+1]:=x+1;
                idx[c+2]:=x+2;
                inc(c,3);
                inc(x,3);
            end;
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(c*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.Area[0].Groupeb[l].Indexs[i].g_pIB,nil)) then exit;
        self.Area[0].Groupeb[l].Indexs[i].g_pIB.Lock(0,c*4,pp,0);
        move(idx[0],pansichar(pp)[0],c*4);
        self.Area[0].Groupeb[l].Indexs[i].g_pIB.Unlock;
        self.Area[0].Groupeb[l].Indexs[i].IndexCount:=c;
        self.Area[0].Groupeb[l].Indexs[i].RefX:=mapitem.Pos.X;
        self.Area[0].Groupeb[l].Indexs[i].Refz:=mapitem.Pos.z;
        self.Area[0].Groupeb[l].Indexs[i].AlphaSource:=D3DTA_TEXTURE;
        self.Area[0].Groupeb[l].Indexs[i].AlphaSrc:=4;
        self.Area[0].Groupeb[l].Indexs[i].AlphaDst:=5;
        self.Area[0].Groupeb[l].Indexs[i].surfacecount:=c div 3;
    end;
    self.Area[0].Groupeb[l].VertexCount:=x;
    if failed(self.g_pd3dDevice.CreateVertexBuffer(x*24,0,
        self.Area[0].Groupeb[l].VertexType,D3DPOOL_DEFAULT
                ,self.Area[0].Groupeb[l].g_pVB ,0)) then exit;
    self.Area[0].Groupeb[l].g_pVB.lock(0,x*24,pp,0);
    move(myvertex[0],pansichar(pp)[0],x*24);
    self.Area[0].Groupeb[l].g_pVB.unlock;
    end else begin
        self.Area[0].Groupeb[l].VertexCount:=0;
        self.Area[0].Groupeb[l].IndexListCount:=0;
    end;
    end;

    result:=true;
end;


Function TPikaMap.LoadQ3Files(FileName:ansistring):boolean;
type
    TMain_Info = Record
        NUM_FRAMES:dword;
        NUM_TAGS:dword;
        NUM_SURFACES:dword;
        NUM_SKINS:dword;
        OFS_FRAMES:dword;
        OFS_TAGS:dword;
        OFS_SURFACES:dword;
    end;
    TSurface_Info = Record
        NUM_SHADERS:dword;
        NUM_VERTS:dword;
        NUM_TRIANGLES:dword;
        OFS_TRIANGLES:dword;
        OFS_SHADERS:dword;
        OFS_ST:dword;
        OFS_XYZNORMAL:dword;
        OFS_END:dword;
    end;
    TvertexList = Record
        x,y,z,nx,ny,nz:single;
        c:dword;
        u,v:single;
    end;
var f,x,ver,y,tid:integer;
    MainInfo:TMain_Info;
    Surface:TSurface_Info;
    off:dword;
    i:short;
    Vertex:array of TvertexList;
    pp:pointer;
    tex:TstringList;
    texname:array[0..64] of ansichar;
    s:ansistring;
    vec:TD3DXVECTOR3;
    dta:tmemorystream;
begin
    result:=false;
    if self.g_pd3dDevice = nil then exit;
    {f:=fileopen(filename,$40);
    if f <1 then exit;  }
    dta:=tmemorystream.Create;
    if not GetFile(filename,dta) then exit;
    dta.Read(x,4);
    dta.Read(ver,4);
    if x <> $33504449 then exit; //not a valide file
    dta.Seek($4C,0); //seek to the data
    dta.Read(MainInfo,sizeof(MainInfo));
    dta.Seek(MainInfo.OFS_SURFACES+$4C,0); //seek to the surfaces data
    off:=MainInfo.OFS_SURFACES;
    //set map data
    tex:=TstringList.Create;
    self.AreaCount:=1;
    setlength(self.Area,1);
    self.Area[0].BaseX:=0;
    self.Area[0].BaseZ:=0;
    self.Area[0].GroupeA_Count:=MainInfo.NUM_SURFACES;
    self.Area[0].GroupeB_Count:=0;
    self.Area[0].AmbientColor:=0;
    setlength(self.Area[0].GroupeA,MainInfo.NUM_SURFACES);
    for x:= 0 to MainInfo.NUM_SURFACES-1 do begin
        dta.Read(Surface,sizeof(Surface));
        self.Area[0].GroupeA[x].VertexCount:=surface.NUM_VERTS;
        self.area[0].GroupeA[x].VertexType:=D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE or D3DFVF_TEX1;
        self.area[0].GroupeA[x].SurfaceType:=D3DPT_TRIANGLELIST;
        self.area[0].GroupeA[x].VertexSize:=36;
        self.area[0].GroupeA[x].IndexListCount:=1;
        setlength(self.area[0].GroupeA[x].indexs,1);
        self.area[0].GroupeA[x].Indexs[0].SurfaceCount:=surface.NUM_TRIANGLES;
        self.area[0].GroupeA[x].Indexs[0].IndexCount:=surface.NUM_TRIANGLES*3;
        self.area[0].GroupeA[x].Indexs[0].TextureID:=0;
        //skip the texture for now but the shader contain it
        dta.Seek(surface.OFS_SHADERS+off,0);
        dta.Read(texname[0],64);
        tid:=tex.IndexOf(extractfilename(pansichar(@texname[0])));
        if tid = -1 then tid:=tex.add(extractfilename(pansichar(@texname[0])));
        //process all the vertex
        setlength(Vertex,self.Area[0].GroupeA[x].VertexCount);
        dta.Seek(surface.OFS_XYZNORMAL+off,0);
        for y:=0 to self.Area[0].GroupeA[x].VertexCount-1 do begin
            dta.Read(i,2);
            Vertex[y].x:=i*(1/64);
            dta.Read(i,2);
            Vertex[y].y:=i*(1/64);
            dta.Read(i,2);
            Vertex[y].z:=i*(1/64);
            dta.Read(i,2);
            D3DXVec3Normalize(vec,D3DXVECTOR3(Vertex[y].x,Vertex[y].y,Vertex[y].z));
            Vertex[y].nx:=1;
            Vertex[y].ny:=vec.y;
            Vertex[y].nz:=1;
            Vertex[y].c:=$FFFFFFFF;
        end;
        //assign all the texture coordinate
        dta.Seek(surface.OFS_ST+off,0);
        for y:=0 to self.Area[0].GroupeA[x].VertexCount-1 do begin
            dta.Read(Vertex[y].u,8);
        end;
        if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Area[0].GroupeA[x].VertexCount*36,0,
            self.Area[0].GroupeA[x].VertexType,D3DPOOL_DEFAULT
                ,self.Area[0].GroupeA[x].g_pVB ,0)) then exit;

        self.Area[0].GroupeA[x].g_pVB.Lock(0,self.Area[0].GroupeA[x].VertexCount*36,pp,0);
        move(Vertex[0],pansichar(pp)[0],self.Area[0].GroupeA[x].VertexCount*36);
        self.Area[0].GroupeA[x].g_pVB.UnLock;
        //load the index
        dta.Seek(surface.OFS_TRIANGLES+off,0);
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(surface.NUM_TRIANGLES*12,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.Area[0].GroupeA[x].Indexs[0].g_pIB,nil)) then exit;
        self.Area[0].GroupeA[x].Indexs[0].g_pIB.lock(0,surface.NUM_TRIANGLES*12,pp,0);
        dta.Read(pansichar(pp)[0],surface.NUM_TRIANGLES*12);
        self.Area[0].GroupeA[x].Indexs[0].g_pIB.Unlock;
        self.Area[0].GroupeA[x].Indexs[0].TextureID:=tid;

        inc(off,Surface.OFS_END);
        dta.Seek(off+$4c,0);
    end;
    //load texture
    dta.Free;
    self.TextureCount:=tex.Count;
    setlength(self.Texture,tex.Count);
    for x:=0 to tex.Count-1 do begin
        s:=extractfilepath(filename)+tex.strings[x];
        dta:=tmemorystream.Create;
        GetFile(s,dta);
        //D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[x]);
        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,dta.Memory,dta.Size,self.texture[x]);
        dta.Free;
    end;
    result:=true;
    tex.Free;
end;

Procedure T3DItem.SetProportion(Prox,ProY,ProZ:single);
begin
    self.ProX:=Prox;
    self.ProY:=Proy;
    self.ProZ:=Proz;
    //self.RemapVertex;
end;


Procedure T3DItem.Render(lod:integer;fogged:integer);
var x,y,t,i:integer;
    pp:pointer;
    d1,d2:dword;
    tmpmat,mymat:td3dmaterial9;
    matRotX,matRotY,matRotZ,matTrans,matScale,ma,ma2:td3dmatrix;
begin
    //treat the vertex for the size and position
    cs.Enter;
    if not rdy then begin
        cs.Leave;
        exit;
    end;
    cs.Leave;
    g_pd3dDevice.GetTransform(D3DTS_WORLD,ma2);

    //apply the matrix
    D3DXMatrixRotationX( matRotX, self.RV1 /57.2957795 );        // Pitch
    D3DXMatrixRotationY( matRotY, self.rh /57.2957795);        // Yaw
    D3DXMatrixRotationZ( matRotZ, self.rv2 /57.2957795);        // Roll

    // Calculate a translation matrix
    D3DXMatrixTranslation(matTrans,self.PosX,self.PosY,self.PosZ);

    //scale
    D3DXMatrixScaling(matScale,self.ProX,self.Proy,self.Proz);

    //ma:=(matRotX*matRotY*matRotZ)*matTrans;

    if rotationseq = 0 then begin
    D3DXMatrixMultiply(ma,matScale,matRotX);
    D3DXMatrixMultiply(ma,ma,matRotY);
    D3DXMatrixMultiply(ma,ma,matRotz);
    end;
    if rotationseq = 1 then begin
    D3DXMatrixMultiply(ma,matScale,matRoty);
    D3DXMatrixMultiply(ma,ma,matRotx);
    D3DXMatrixMultiply(ma,ma,matRotz);
    end;
    D3DXMatrixMultiply(ma,ma,matTrans);

    g_pd3dDevice.setTransform(D3DTS_WORLD,ma);



    g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,self.srcalpha);//source blend factor
    g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,self.destalpha);//source blend factor
    g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,ord(self.zwrite)) ;

    {g_pd3dDevice.GetMaterial(tmpmat);
    mymat.Diffuse.a:=(1/255)*alpha;
    mymat.Diffuse.r:=(1/255)*(col and 255);
    mymat.Diffuse.g:=(1/255)*((col div 256) and 255);
    mymat.Diffuse.b:=(1/255)*((col div $10000) and 255);
    mymat.Ambient:=mymat.Diffuse;
    mymat.Specular:=mymat.Diffuse;
    mymat.Emissive:=mymat.Diffuse;

    //g_pd3dDevice.SetRenderState(D3DRS_LIGHTING,iTrue);
    g_pd3dDevice.SetMaterial(mymat);    }

    g_pd3dDevice.GetRenderState(D3DRS_LIGHTING,d1);
    g_pd3dDevice.GetRenderState(D3DRS_AMBIENT,d2);
    if col <> $ffffff then begin
    g_pd3dDevice.SetRenderState(D3DRS_LIGHTING,iTrue);
    g_pd3dDevice.SetRenderState(D3DRS_AMBIENT,col+(alpha*$1000000));
    end;
    
    if alpha < 254 then
     g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_DIFFUSE )
        else g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
     
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
    if self.FrameCount>0 then
    for x:=0 to self.Frame[self.selframe].SectionCount-1 do begin
        //render it now
        {G_pVB.Lock(0,self.Frame[self.selframe].Section[x].VertexCount*36,pp,0);
        move(self.Frame[self.selframe].Section[x].VertexList[0],pansichar(pp)[0],self.Frame[self.selframe].Section[x].VertexCount*36);
        G_pVB.Unlock; }
        self.g_pd3dDevice.SetStreamSource(0,G_pVB,self.Frame[self.selframe].Section[x].VertexOff*36,36);
        //self.g_pd3dDevice.SetStreamSource(0,self.Frame[self.selframe].Section[x].VertexList,0,36);
        self.g_pd3dDevice.SetFVF(D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_TEX1 or D3DFVF_DIFFUSE);

        for y:=0 to self.Frame[self.selframe].Section[x].IndexListCount-1 do begin
            if lod <= 0 then
            self.g_pd3dDevice.SetIndices(self.Frame[self.selframe].Section[x].Indexs[y].g_pIB)
            else self.g_pd3dDevice.SetIndices(self.Frame[self.selframe].Section[x].Indexs[y].LODIB);
            if self.Frame[self.selframe].Section[x].Indexs[y].textureid >= 0 then
            if self.Frame[self.selframe].Section[x].Indexs[y].textureid < self.texturecount then begin
                t:=self.Frame[self.selframe].Section[x].Indexs[y].textureid;
                for i:=0 to textswapcount-1 do
                    if t = textswap[i] and $ffff then t:=textswap[i] div $10000;
                if t < texturecount then self.g_pd3dDevice.SetTexture(0,self.texture[t])
                else
                  self.g_pd3dDevice.SetTexture(0,nil)
            end else  self.g_pd3dDevice.SetTexture(0,nil);


            if self.usematerial then begin
                //g_pd3dDevice.SetMaterial(self.Frame[self.selframe].section[x].Indexs[y].material);
                if (Frame[self.selframe].Section[x].Indexs[y].material.Diffuse.a < 0.9) or (alpha <= 200) then
                    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_DIFFUSE )
                else g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
            end;
            if self.AlphaLevel > 200 then
            if self.usealpha then begin
                g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,self.Frame[self.selframe].Section[x].Indexs[y].AlphaSrc+1);//source blend factor
                g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,self.Frame[self.selframe].Section[x].Indexs[y].AlphaDst+1);//source blend factor
            end;
            if self.zwrite then
            if self.Frame[self.selframe].Section[x].Indexs[y].AlphaDst <> 1 then begin
                g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);
                if fogged>0 then g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,itrue);
            end else begin
                g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,iFalse);
                if fogged >0 then g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,ifalse);
            end;
            if lod <= 0 then
            self.g_pd3dDevice.DrawIndexedPrimitive(self.Frame[self.selframe].Section[x].SurfaceType,
                0,0,self.Frame[self.selframe].Section[x].VertexCount,0,self.Frame[self.selframe].Section[x].indexs[y].SurfaceCount)
            else if lod = 1 then self.g_pd3dDevice.DrawIndexedPrimitive(self.Frame[self.selframe].Section[x].SurfaceType,
                0,0,self.Frame[self.selframe].Section[x].VertexCount,0,self.Frame[self.selframe].Section[x].indexs[y].lodscount[0])
            else self.g_pd3dDevice.DrawIndexedPrimitive(self.Frame[self.selframe].Section[x].SurfaceType,
                0,0,self.Frame[self.selframe].Section[x].VertexCount,self.Frame[self.selframe].Section[x].indexs[y].lodicount[0],self.Frame[self.selframe].Section[x].indexs[y].lodscount[1]);
        end;

    end;
    if self.Particles <> nil then self.Particles.Render;
    //g_pd3dDevice.setMaterial(tmpmat);
    g_pd3dDevice.setTransform(D3DTS_WORLD,ma2);
    g_pd3dDevice.setRenderState(D3DRS_LIGHTING,d1);
    g_pd3dDevice.setRenderState(D3DRS_AMBIENT,d2);

end;


Procedure T3DItem.RemapVertex;
function MatToRGB(m:td3dmaterial9;col,alpha:dword):dword;
var al:integer;
begin
    al:=round(m.Diffuse.a*255)-(255-alpha);
    if al < 0 then al:=0;
    if col and $ffffff <> $ffffff then result:=(col and $ffffff) +(al*$1000000) else
    result:=round(m.Diffuse.r*255)
    +(round(m.Diffuse.g*255)*256)
    +(round(m.Diffuse.b*255)*$10000)
        +(al*$1000000);
end;
var x,y,f:integer;
    //r,sx,cx,sy,cy,sz,cz,xy,xz,yz,yx,zx,zy:single;
    vec,vec2:TD3DXVECTOR3;
    //ma:td3dmatrix;
    tmpv:T3DVertex2;
    pp:pointer;
    tmpoff:dword;
begin
    f:=0;
    for x:=0 to self.Frame[0].SectionCount-1 do begin
        inc(f,self.Frame[0].Section[x].VertexCount);
    end;
    VBCount:=f;

    if failed(self.g_pd3dDevice.CreateVertexBuffer(self.FrameCount*f*36,0,
            D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE
            or D3DFVF_TEX1,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then begin           
                    self.FrameCount:=0;
                    exit;
                end;
    self.g_pVB.Lock(0,(self.FrameCount*f*36),pp,0);
    self.usx:=2;
    self.usy:=2;
    self.usz:=2;
    self.dsx:=-2;
    self.dsy:=-2;
    self.dsz:=-2;

    VBCount:=0;
    tmpoff:=0;
    for f:=0 to self.FrameCount-1 do begin
        for x:=0 to self.frame[f].SectionCount-1 do begin
            self.frame[f].Section[x].VertexOff:=vbcount;
            inc(vbcount,self.frame[f].Section[x].VertexCount);
            for y:=0 to self.frame[f].Section[x].VertexCount-1 do begin
                move(self.frame[f].Section[x].Vertexorg[y],tmpv,12); //xyz
                move(self.frame[f].Section[x].Vertexorg[y].color,tmpv.color,12);
                D3DXVec3Normalize(vec,D3DXVECTOR3(tmpv.px,tmpv.py,tmpv.pz));
                tmpv.color:=(self.COL and $ffffff)+ (alpha*$1000000);
                if self.usematerial then
                    tmpv.color:=MatToRGB(Frame[self.selframe].Section[x].Indexs[0].material,COL,alpha);
                tmpv.nx:=vec.x;
                tmpv.ny:=vec.y;
                tmpv.nz:=vec.z;
                move(tmpv,pansichar(pp)[tmpoff],36);
                inc(tmpoff,36);
                if self.usx < round(tmpv.px) then self.usx:=round(tmpv.px);
                if self.usy < round(tmpv.py) then self.usy:=round(tmpv.py);
                if self.usz < round(tmpv.pz) then self.usz:=round(tmpv.pz);
                if self.dsx > round(tmpv.px) then self.dsx:=round(tmpv.px);
                if self.dsy > round(tmpv.py) then self.dsy:=round(tmpv.py);
                if self.dsz > round(tmpv.pz) then self.dsz:=round(tmpv.pz);
            end;
        end;
    end;

    self.g_pVB.Unlock;

    {    //old code
    sx := sin(rv1/ 57.2957795);
    cx := cos(rv1/ 57.2957795);
    sy := sin(rh/ 57.2957795);
    cy := cos(rh/ 57.2957795);
    sz := sin(rv2/ 57.2957795);
    cz := cos(rv2/ 57.2957795);

    self.usx:=2;
    self.usy:=2;
    self.usz:=2;
    self.dsx:=-2;
    self.dsy:=-2;
    self.dsz:=-2;
    if self.FrameCount>0 then
    for x:=0 to self.Frame[self.selframe].SectionCount-1 do begin
        //if self.Frame[self.selframe].Section[x].VertexList <> nil then begin
        //self.Frame[self.selframe].Section[x].VertexList.Lock(0,self.Frame[self.selframe].Section[x].VertexCount*36,pp,0);
        for y:=0 to self.Frame[self.selframe].Section[x].VertexCount-1 do begin
            tmpv.px:=(self.Frame[self.selframe].Section[x].VertexOrg[y].px*prox);
            tmpv.py:=(self.Frame[self.selframe].Section[x].VertexOrg[y].py*proy);
            tmpv.pz:=(self.Frame[self.selframe].Section[x].VertexOrg[y].pz*proz);
            tmpv.color:=(self.COL and $ffffff)+ (alpha*$1000000);
            if self.usematerial then
                tmpv.color:=MatToRGB(Frame[self.selframe].Section[x].Indexs[0].material,COL,alpha);
            tmpv.tu:=self.Frame[self.selframe].Section[x].VertexOrg[y].tu;
            tmpv.tv:=self.Frame[self.selframe].Section[x].VertexOrg[y].tv;
            //rotation
            if (rh<>0) or (rv1<>0) or (rv2 <> 0) then begin
            // rotation around x


            //D3DXMatrixRotationYawPitchRoll( ma,rh/ 57.2957795,rv1/ 57.2957795,rv2/ 57.2957795) ;
            if rotationseq = 0 then begin
            D3DXMatrixRotationX(ma,rv1/ 57.2957795);
            D3DXVec3TransformCoord(vec2,D3DXVECTOR3(tmpv.px,tmpv.py,tmpv.pz),ma);
            D3DXMatrixRotationy(ma,rh/ 57.2957795);
            D3DXVec3TransformCoord(vec2,vec2,ma);
            D3DXMatrixRotationz(ma,rv2/ 57.2957795);
            D3DXVec3TransformCoord(vec2,vec2,ma);
            end;
            if rotationseq = 1 then begin
            D3DXMatrixRotationy(ma,rh/ 57.2957795);
            D3DXVec3TransformCoord(vec2,D3DXVECTOR3(tmpv.px,tmpv.py,tmpv.pz),ma);
            D3DXMatrixRotationX(ma,rv1/ 57.2957795);
            D3DXVec3TransformCoord(vec2,vec2,ma);
            D3DXMatrixRotationz(ma,rv2/ 57.2957795);
            D3DXVec3TransformCoord(vec2,vec2,ma);
            end;



            //D3DXVec3Normalize(vec,D3DXVECTOR3(zx,zy,yz));
            D3DXVec3Normalize(vec,vec2);
            tmpv.nx:=vec.x;
            tmpv.ny:=vec.y;
            tmpv.nz:=vec.z;

            if self.usx < round(vec2.x) then self.usx:=round(vec2.x);
            if self.usy < round(vec2.y) then self.usy:=round(vec2.y);
            if self.usz < round(vec2.z) then self.usz:=round(vec2.z);
            if self.dsx > round(vec2.x) then self.dsx:=round(vec2.x);
            if self.dsy > round(vec2.y) then self.dsy:=round(vec2.y);
            if self.dsz > round(vec2.z) then self.dsz:=round(vec2.z);

            tmpv.px:=vec2.x+posx;
            tmpv.py:=vec2.y+posy;
            tmpv.pz:=vec2.z+posz;



            end else begin
                D3DXVec3Normalize(vec,D3DXVECTOR3(tmpv.px,
                    tmpv.py
                    ,tmpv.pz));
                tmpv.nx:=vec.x;
                tmpv.ny:=vec.y;
                tmpv.nz:=vec.z;

                if self.usx < round(tmpv.px) then self.usx:=round(tmpv.px);
                if self.usy < round(tmpv.py) then self.usy:=round(tmpv.py);
                if self.usz < round(tmpv.pz) then self.usz:=round(tmpv.pz);
                if self.dsx > round(tmpv.px) then self.dsx:=round(tmpv.px);
                if self.dsy > round(tmpv.py) then self.dsy:=round(tmpv.py);
                if self.dsz > round(tmpv.pz) then self.dsz:=round(tmpv.pz);

                tmpv.px:=tmpv.px+posx;
                tmpv.py:=tmpv.py+posy;
                tmpv.pz:=tmpv.pz+posz;
            end;

            //move(tmpv, pansichar(pp)[y*36],36);

            self.Frame[self.selframe].Section[x].VertexList[y]:=tmpv;

        end;
        //self.Frame[self.selframe].Section[x].VertexList.Unlock;
    end;
    }

    

end;


Function T3DItem.LoadPangyaMap(FileName:ansistring):boolean;
Type
TPangyaVertex = Record
    X,Y,Z:single;
end;
TMyVertex = Record
    X,Y,Z:single;
    Color:Dword;
    Tu,Tv:single;
end;
TBoneData = Record
    ScaleX,unused1,RotX,unused2,Scaley,unused3,RotY,unused4,ScalZ:single;
    Pos:TPangyaVertex;
    boneid:byte;
end;
TPangyaIndex = Record
    Ver:dword;
    R,G,B:dword;
    Tu,Tv:single;
end;
Var Vertex:array of TPangyaVertex;
    Index:array of TPangyaIndex;
    MyVertex:array of TMyVertex;
    tex:array of byte;
    head,size:dword;
    y,fpos,x,i,vc,sc,c,maxv,l:integer;
    texname:array[0..$2b] of ansichar;
    idx:array of dword;
    s:ansistring;
    pp:pointer;
    bonedata:array of TBoneData;
Function LoadTexture(Filename:ansistring;i:integer):integer;
var b1,b2:tbitmap;
    j1:tjpegimage;
    x,y,c:integer;
    ms:pansichar;
    header:ansistring;
    p:dword;
begin
    if (lowercase(ExtractFileExt(filename)) = '.jpg') and
        (fileexists(changefileext(filename,'_mask.jpg'))) then begin
        j1:=tjpegimage.Create;
        j1.LoadFromFile(filename);
        b1:=tbitmap.Create;
        b1.PixelFormat:=pf32bit;
        b1.Width:=j1.Width;
        b1.Height:=j1.Height;
        b1.Canvas.Draw(0,0,j1);
        b2:=tbitmap.Create;
        b2.PixelFormat:=pf32bit;
        j1.LoadFromFile(changefileext(filename,'_mask.jpg'));
        b2.Width:=j1.Width;
        b2.Height:=j1.Height;
        b2.Canvas.Draw(0,0,j1);
        j1.Free;
        header:=#$42#$4D#$DA#$1F#$00#$00#$00#$00#$00#$00#$36#$00#$00#$00#$28#$00#$00#$00#$2D#$00#$00#$00#$2D#$00#$00#$00#$01#$00
            +#$20#$00#$00#$00#$00#$00#$A4#$1F#$00#$00#$13#$0B#$00#$00#$13#$0B#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
        c:=b1.Width*b1.height*4;
        move(c,header[$23],4);
        inc(c,$36);
        move(c,header[$3],4);
        p:=b1.Width;
        move(p,header[$13],2);
        p:=b1.height;
        move(p,header[$17],2);
        getmem(ms,c);
        move(header[1],ms[0],$36);
        c:=$36;
        for y:=b1.Height-1 downto 0 do
        for x:=0 to b1.Width-1 do
         begin
            p:=((b1.Canvas.Pixels[x,y] and $ff)*$10000) +
                (b1.Canvas.Pixels[x,y] and $ff00) +
                ((b1.Canvas.Pixels[x,y] and $ff0000) div $10000) +
                ((b2.Canvas.Pixels[x,y] and 255)*$1000000);
            move(p,ms[c],4);
            inc(c,4);
        end;
        b2.Free;
        b1.Free;
        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,ms,c,self.texture[i]);
        //changefileext
    end else D3DXCreateTextureFromFileA(g_pd3dDevice,pansichar(Filename),self.texture[i]);
end;
begin

    result:=false;
    maxv:=0;
    if self.g_pd3dDevice = nil then exit;
    if extractfileext(filename) <> '.pet' then exit;
    y:=fileopen(filename,$40);
    if y <1 then exit;
    fpos:=0;
    while fileread(y,head,4) = 4 do begin
        fileread(y,size,4);
        if head = $54584554 then begin //Texture info
            fileread(y,x,4); //texture count
            self.TextureCount:=x;
            setlength(self.Texture,x);
            for i:=0 to x-1 do begin
                fileread(y,texname[0],$2c);
                s:=extractfilepath(filename)+pansichar(@texname[0]);//+#0#0;
                LoadTexture(s,i);
                //D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[i]);
            end;
        end;
        if head = $454e4f42 then begin
            x:=0;
            fileread(y,x,1);
            setlength(boneData,x);
            for i:=0 to x-1 do begin
                c:=1;
                while c <> 0 do fileread(y,c,1);
                fileread(y,boneData[i].boneid,1);
                fileread(y,boneData[i],$30);
            end;
        end;
        if head = $4853454d then begin //Mesh info
            fileread(y,vc,4); //vertex count
            setlength(vertex,vc);
            x:=0;
            for i:=0 to vc-1 do begin
                fileread(y,vertex[i],12);
                fileread(y,x,2);
                l:=x div 256;
                fileread(y,c,2);
                while l <> 255 do begin
                    if bonedata[l].boneid = 25566 then begin
                    vertex[i].X:=(vertex[i].X*bonedata[l].ScaleX)
                        +bonedata[l].Pos.x;
                    vertex[i].y:=(vertex[i].y*bonedata[l].Scaley)
                        +bonedata[l].Pos.y;
                    vertex[i].z:=(vertex[i].z*bonedata[l].Scalz)
                        +bonedata[l].Pos.z;
                    end else begin
                        vertex[i].X:=vertex[i].X+bonedata[l].Pos.x;
                        vertex[i].y:=vertex[i].y+bonedata[l].Pos.y;
                        vertex[i].z:=vertex[i].z+bonedata[l].Pos.z;
                    end;
                    l:=bonedata[l].boneid;
                end;
                c:=(c and 255)+(x and 255);
                while c < 255 do begin
                    fileread(y,x,2);
                    inc(c,x and 255);
                end;
            end;
            fileread(y,sc,4); //surface count
            setlength(index,sc*3);
            setlength(tex,sc);
            fileread(y,index[0],sc*72);
            fileread(y,tex[0],sc); //texture id
        end;
        inc(fpos,size+8);
        fileseek(y,fpos,0);
    end;
    Fileclose(y);
    //set all var
    setlength(MyVertex,sc*3);
    setlength(idx,sc*3);
    self.FrameCount:=1;
    setlength(self.Frame,1);
    self.Frame[0].SectionCount:=1;
    setlength(self.Frame[0].Section,1);
    self.Frame[0].Section[0].IndexListCount:=self.TextureCount;
    setlength(self.Frame[0].Section[0].Indexs,self.TextureCount);
    self.Frame[0].Section[0].SurfaceType:=D3DPT_TRIANGLELIST;
    //realing all the data
    x:=0;
    for i:=0 to self.TextureCount-1 do begin
        self.Frame[0].Section[0].Indexs[i].TextureID:=i;
        c:=0;
        for y:=0 to sc-1 do
            if tex[y] =  i then begin
                MyVertex[x].X:=vertex[Index[y*3].Ver].x;
                MyVertex[x].y:=vertex[Index[y*3].Ver].y;
                MyVertex[x].z:=vertex[Index[y*3].Ver].z;
                MyVertex[x].Color:=$FFFFFFFF;//(Index[y*3].R div $10000)+(Index[y*3].G div $100)+Index[y*3].B;
                MyVertex[x].Tu:=Index[y*3].Tu;
                MyVertex[x].Tv:=Index[y*3].Tv;

                MyVertex[x+1].X:=vertex[Index[(y*3)+1].Ver].x;
                MyVertex[x+1].y:=vertex[Index[(y*3)+1].Ver].y;
                MyVertex[x+1].z:=vertex[Index[(y*3)+1].Ver].z;
                MyVertex[x+1].Color:=$FFFFFFFF;//(Index[(y*3)+1].R div $10000)+(Index[(y*3)+1].G div $100)+Index[(y*3)+1].B;
                MyVertex[x+1].Tu:=Index[(y*3)+1].Tu;
                MyVertex[x+1].Tv:=Index[(y*3)+1].Tv;

                MyVertex[x+2].X:=vertex[Index[(y*3)+2].Ver].x;
                MyVertex[x+2].y:=vertex[Index[(y*3)+2].Ver].y;
                MyVertex[x+2].z:=vertex[Index[(y*3)+2].Ver].z;
                MyVertex[x+2].Color:=$FFFFFFFF;//(Index[(y*3)+2].R div $10000)+(Index[(y*3)+2].G div $100)+Index[(y*3)+2].B;
                MyVertex[x+2].Tu:=Index[(y*3)+2].Tu;
                MyVertex[x+2].Tv:=Index[(y*3)+2].Tv;

                idx[c]:=x;
                idx[c+1]:=x+1;
                idx[c+2]:=x+2;
                inc(c,3);
                inc(x,3);
            end;
        if c > 0 then begin
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(c*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.Frame[0].Section[0].Indexs[i].g_pIB,nil)) then exit;
        self.Frame[0].Section[0].Indexs[i].g_pIB.Lock(0,c*4,pp,0);
        move(idx[0],pansichar(pp)[0],c*4);
        self.Frame[0].Section[0].Indexs[i].g_pIB.Unlock;
        end;
        self.Frame[0].Section[0].Indexs[i].IndexCount:=c;
        self.Frame[0].Section[0].Indexs[i].surfacecount:=c div 3;
    end;
    self.Frame[0].Section[0].VertexCount:=x;
    if x>maxv then maxv:=x;
    {if failed(self.g_pd3dDevice.CreateVertexBuffer(x*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.Frame[0].Section[0].VertexList ,0)) then exit;  }
    //setlength(self.Frame[0].Section[0].Vertexlist,x);
    setlength(self.Frame[0].Section[0].VertexORG,x);
    //move(myvertex[0],self.Frame[0].Section[0].VertexList[0] ,x*24);
    move(myvertex[0],self.Frame[0].Section[0].VertexOrg[0] ,x*24);
    if failed(self.g_pd3dDevice.CreateVertexBuffer(maxv*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then exit;
    self.RemapVertex;
    result:=true;
    cs.Enter;
    rdy:=true;
    cs.Leave;
end;

Procedure T3DItem.SetRotation(rh,rv1,rv2:single);
begin
    self.RH:=rh+self.baseRx;
    self.rv1:=rv1+self.baseRy;
    self.rv2:=rv2+self.baseRz;
    //self.RemapVertex;
end;

Procedure T3DItem.SetBaseRotation(bx,by,bz:integer);
begin
    self.baseRx:=bx;
    self.baseRy:=by;
    self.baseRz:=bz;
end;

Procedure T3DItem.SetFrame(f:integer);
begin
    if f > self.FrameCount-1 then self.selframe:=self.FrameCount-1
    else self.selframe:=f;
    //self.RemapVertex;
end;

Function T3DItem.LoadQ3Files(FileName:ansistring):boolean;
type
    TMain_Info = Record
        NUM_FRAMES:dword;
        NUM_TAGS:dword;
        NUM_SURFACES:dword;
        NUM_SKINS:dword;
        OFS_FRAMES:dword;
        OFS_TAGS:dword;
        OFS_SURFACES:dword;
    end;
    TSurface_Info = Record
        NUM_SHADERS:dword;
        NUM_VERTS:dword;
        NUM_TRIANGLES:dword;
        OFS_TRIANGLES:dword;
        OFS_SHADERS:dword;
        OFS_ST:dword;
        OFS_XYZNORMAL:dword;
        OFS_END:dword;
    end;
    TvertexList = Record
        x,y,z:single;
        c:dword;
        u,v:single;
    end;
var f,x,ver,y,tid,maxv,l:integer;
    MainInfo:TMain_Info;
    Surface:TSurface_Info;
    off:dword;
    i:short;
    Vertex:array of TvertexList;
    pp:pointer;
    tex:TstringList;
    texname:array[0..64] of ansichar;
    s:ansistring;
    dta:tmemorystream;
begin
    result:=false;
    maxv:=0;
    PollyCount:=0;
    self.TextureName.Clear;
    if self.g_pd3dDevice = nil then exit;
    dta:=tmemorystream.Create;
    if not GetFile(filename,dta) then exit;
    dta.read(x,4);
    dta.read(ver,4);
    if x <> $33504449 then exit; //not a valide file
    dta.seek($4C,0); //seek to the data
    dta.read(MainInfo,sizeof(MainInfo));
    dta.seek(MainInfo.OFS_SURFACES+$4C,0); //seek to the surfaces data
    off:=MainInfo.OFS_SURFACES;
    //set map data
    tex:=TstringList.Create;
    self.FrameCount:=Maininfo.NUM_FRAMES;
    setlength(self.Frame,Maininfo.NUM_FRAMES);
    for l:=0 to Maininfo.NUM_FRAMES-1 do begin
        self.Frame[l].SectionCount:=MainInfo.NUM_SURFACES;
        setlength(self.Frame[l].Section,MainInfo.NUM_SURFACES);
    end;

    for x:= 0 to MainInfo.NUM_SURFACES-1 do begin
        dta.read(Surface,sizeof(Surface));
        //skip the texture for now but the shader contain it
        dta.seek(surface.OFS_SHADERS+off,0);
        dta.read(texname[0],64);
        tid:=tex.IndexOf(extractfilename(pansichar(@texname[0])));
        if tid = -1 then tid:=tex.add(extractfilename(pansichar(@texname[0])));
        //process all the vertex
        for l:=0 to maininfo.NUM_FRAMES-1 do begin
        dta.seek(surface.OFS_XYZNORMAL+off+(l*surface.NUM_VERTS*8),0);
        self.Frame[l].Section[x].SurfaceType:=D3DPT_TRIANGLELIST;
        self.Frame[l].Section[x].IndexListCount:=1;
        setlength(self.Frame[l].Section[x].indexs,1);
        self.Frame[l].Section[x].Indexs[0].SurfaceCount:=surface.NUM_TRIANGLES;
        inc(PollyCount,surface.NUM_TRIANGLES);
        self.Frame[l].Section[x].Indexs[0].IndexCount:=surface.NUM_TRIANGLES*3;
        self.Frame[l].Section[x].Indexs[0].TextureID:=0;
        self.Frame[l].Section[x].VertexCount:=surface.NUM_VERTS;
        setlength(Vertex,self.Frame[l].Section[x].VertexCount);
        for y:=0 to self.Frame[l].Section[x].VertexCount-1 do begin
            dta.read(i,2);
            Vertex[y].x:=i*(1/64);
            dta.read(i,2);
            Vertex[y].y:=i*(1/64);
            dta.read(i,2);
            Vertex[y].z:=i*(1/64);
            dta.read(i,2);
            Vertex[y].c:=$ffffffff;
        end;
        //assign all the texture coordinate
        dta.seek(surface.OFS_ST+off,0);
        for y:=0 to self.Frame[l].Section[x].VertexCount-1 do begin
            dta.read(Vertex[y].u,8);
        end;
        //setlength(self.frame[l].section[x].VertexList,self.Frame[l].Section[x].VertexCount);
        {if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Frame[l].Section[x].VertexCount*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.Frame[l].Section[x].VertexList ,0)) then exit; }
        //move(Vertex[0],self.frame[l].section[x].VertexList[0],self.Frame[l].Section[x].VertexCount*24);
        setlength(self.frame[l].section[x].VertexOrg,self.Frame[l].Section[x].VertexCount);
        move(Vertex[0],self.frame[l].section[x].VertexOrg[0],self.Frame[l].Section[x].VertexCount*24);
        if self.Frame[l].Section[x].VertexCount>maxv then maxv:=self.Frame[l].Section[x].VertexCount;
        end;

        //load the index
        dta.seek(surface.OFS_TRIANGLES+off,0);
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(surface.NUM_TRIANGLES*12,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.Frame[0].Section[x].Indexs[0].g_pIB,nil)) then exit;
        self.Frame[0].Section[x].Indexs[0].g_pIB.lock(0,surface.NUM_TRIANGLES*12,pp,0);
        dta.read(pansichar(pp)[0],surface.NUM_TRIANGLES*12);
        self.Frame[0].Section[x].Indexs[0].g_pIB.Unlock;
        self.Frame[0].Section[x].Indexs[0].TextureID:=tid;

        for l:=1 to maininfo.NUM_FRAMES-1 do begin
            self.Frame[l].Section[x].Indexs[0].g_pIB:=self.Frame[0].Section[x].Indexs[0].g_pIB;
            self.Frame[l].Section[x].Indexs[0].TextureID:=
                self.Frame[0].Section[x].Indexs[0].TextureID;
        end;

        inc(off,Surface.OFS_END);
        dta.seek(off+$4c,0);
    end;
    //load texture
    dta.Free;
    self.TextureCount:=tex.Count;
    setlength(self.Texture,tex.Count);
    for x:=0 to tex.Count-1 do begin
        s:=extractfilepath(filename)+tex.strings[x];
        dta:=tmemorystream.Create;
        GetFile(s,dta);
        //D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[x]);
        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,dta.Memory,dta.Size,self.texture[x]);
        dta.Free;
    end;
    if failed(self.g_pd3dDevice.CreateVertexBuffer(maxv*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then exit;
    result:=true;
    self.TextureName.Addstrings(tex);
    tex.Free;
    self.RemapVertex;
    cs.Enter;
    rdy:=true;
    cs.Leave;
end;


Function T3DItem.LoadQ3Stream(data:pansichar;dsize:integer):boolean;
type
    TMain_Info = Record
        NUM_FRAMES:dword;
        NUM_TAGS:dword;
        NUM_SURFACES:dword;
        NUM_SKINS:dword;
        OFS_FRAMES:dword;
        OFS_TAGS:dword;
        OFS_SURFACES:dword;
    end;
    TSurface_Info = Record
        NUM_SHADERS:dword;
        NUM_VERTS:dword;
        NUM_TRIANGLES:dword;
        OFS_TRIANGLES:dword;
        OFS_SHADERS:dword;
        OFS_ST:dword;
        OFS_XYZNORMAL:dword;
        OFS_END:dword;
    end;
    TvertexList = Record
        x,y,z:single;
        c:dword;
        u,v:single;
    end;
var f,x,ver,y,tid,maxv,l:integer;
    MainInfo:TMain_Info;
    Surface:TSurface_Info;
    off:dword;
    i:short;
    Vertex:array of TvertexList;
    pp:pointer;
    tex:TstringList;
    texname:array[0..64] of ansichar;
    s:ansistring;
    dta:tmemorystream;
begin
    result:=false;
    maxv:=0;
    PollyCount:=0;
    self.TextureName.Clear;
    if self.g_pd3dDevice = nil then exit;
    dta:=tmemorystream.Create;
    dta.Write(data[0],dsize);
    dta.Position:=0;
    dta.read(x,4);
    dta.read(ver,4);
    if x <> $33504449 then exit; //not a valide file
    dta.seek($4C,0); //seek to the data
    dta.read(MainInfo,sizeof(MainInfo));
    dta.seek(MainInfo.OFS_SURFACES+$4C,0); //seek to the surfaces data
    off:=MainInfo.OFS_SURFACES;
    //set map data
    tex:=TstringList.Create;
    self.FrameCount:=Maininfo.NUM_FRAMES;
    setlength(self.Frame,Maininfo.NUM_FRAMES);
    for l:=0 to Maininfo.NUM_FRAMES-1 do begin
        self.Frame[l].SectionCount:=MainInfo.NUM_SURFACES;
        setlength(self.Frame[l].Section,MainInfo.NUM_SURFACES);
    end;

    for x:= 0 to MainInfo.NUM_SURFACES-1 do begin
        dta.read(Surface,sizeof(Surface));
        //skip the texture for now but the shader contain it
        dta.seek(surface.OFS_SHADERS+off,0);
        dta.read(texname[0],64);
        tid:=tex.IndexOf(extractfilename(pansichar(@texname[0])));
        if tid = -1 then tid:=tex.add(extractfilename(pansichar(@texname[0])));
        //process all the vertex
        for l:=0 to maininfo.NUM_FRAMES-1 do begin
        dta.seek(surface.OFS_XYZNORMAL+off+(l*surface.NUM_VERTS*8),0);
        self.Frame[l].Section[x].SurfaceType:=D3DPT_TRIANGLELIST;
        self.Frame[l].Section[x].IndexListCount:=1;
        setlength(self.Frame[l].Section[x].indexs,1);
        self.Frame[l].Section[x].Indexs[0].SurfaceCount:=surface.NUM_TRIANGLES;
        inc(PollyCount,surface.NUM_TRIANGLES);
        self.Frame[l].Section[x].Indexs[0].IndexCount:=surface.NUM_TRIANGLES*3;
        self.Frame[l].Section[x].Indexs[0].TextureID:=0;
        self.Frame[l].Section[x].VertexCount:=surface.NUM_VERTS;
        setlength(Vertex,self.Frame[l].Section[x].VertexCount);
        for y:=0 to self.Frame[l].Section[x].VertexCount-1 do begin
            dta.read(i,2);
            Vertex[y].x:=i*(1/64);
            dta.read(i,2);
            Vertex[y].y:=i*(1/64);
            dta.read(i,2);
            Vertex[y].z:=i*(1/64);
            dta.read(i,2);
            Vertex[y].c:=$ffffffff;
        end;
        //assign all the texture coordinate
        dta.seek(surface.OFS_ST+off,0);
        for y:=0 to self.Frame[l].Section[x].VertexCount-1 do begin
            dta.read(Vertex[y].u,8);
        end;
        //setlength(self.frame[l].section[x].VertexList,self.Frame[l].Section[x].VertexCount);
        {if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Frame[l].Section[x].VertexCount*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.Frame[l].Section[x].VertexList ,0)) then exit;    }
        //move(Vertex[0],self.frame[l].section[x].VertexList[0],self.Frame[l].Section[x].VertexCount*24);
        setlength(self.frame[l].section[x].VertexOrg,self.Frame[l].Section[x].VertexCount);
        move(Vertex[0],self.frame[l].section[x].VertexOrg[0],self.Frame[l].Section[x].VertexCount*24);
        if self.Frame[l].Section[x].VertexCount>maxv then maxv:=self.Frame[l].Section[x].VertexCount;
        end;

        //load the index
        dta.seek(surface.OFS_TRIANGLES+off,0);
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(surface.NUM_TRIANGLES*12,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.Frame[0].Section[x].Indexs[0].g_pIB,nil)) then exit;
        self.Frame[0].Section[x].Indexs[0].g_pIB.lock(0,surface.NUM_TRIANGLES*12,pp,0);
        dta.read(pansichar(pp)[0],surface.NUM_TRIANGLES*12);
        self.Frame[0].Section[x].Indexs[0].g_pIB.Unlock;
        self.Frame[0].Section[x].Indexs[0].TextureID:=tid;

        for l:=1 to maininfo.NUM_FRAMES-1 do begin
            self.Frame[l].Section[x].Indexs[0].g_pIB:=self.Frame[0].Section[x].Indexs[0].g_pIB;
            self.Frame[l].Section[x].Indexs[0].TextureID:=
                self.Frame[0].Section[x].Indexs[0].TextureID;
        end;

        inc(off,Surface.OFS_END);
        dta.seek(off+$4c,0);
    end;
    //load texture
    dta.Free;
    self.TextureCount:=tex.Count;
    setlength(self.Texture,tex.Count);
    for x:=0 to tex.Count-1 do begin
        s:=tex.strings[x];
        dta:=tmemorystream.Create;
        GetFile(s,dta);
        //D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[x]);
        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,dta.Memory,dta.Size,self.texture[x]);
        dta.Free;
    end;
    if failed(self.g_pd3dDevice.CreateVertexBuffer(maxv*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then exit;   
    result:=true;
    self.TextureName.Addstrings(tex);
    tex.Free;
    self.RemapVertex;
    cs.Enter;
    rdy:=true;
    cs.Leave;
end;


Procedure T3Ditem.SetPosX(x:single);
begin
    self.posx:=x;
    //self.RemapVertex;
end;
Procedure T3Ditem.SetPosY(x:single);
begin
    self.posy:=x;
    //self.RemapVertex;
end;
Procedure T3Ditem.SetPosZ(x:single);
begin
    self.posz:=x;
    //self.RemapVertex;
end;

Procedure T3Ditem.SetCoordinate(x,y,z:single);
begin
    self.posx:=x;
    self.posy:=y;
    self.posz:=z;
    //self.RemapVertex;
end;

Procedure T3Ditem.SetAlpha(a:byte);
begin
    self.alpha:=a;
    if a < 254 then self.RemapVertex;
end;

Procedure T3Ditem.Setdestalpha(a:byte);
begin
    self.destalpha:=a;

    //self.RemapVertex;
end;

Procedure T3Ditem.setsrcalpha(a:byte);
begin
    self.srcalpha:=a;

end;

Procedure T3Ditem.SetColor(a:dword);
begin
    self.col:=a;
    //self.RemapVertex;
end;

Procedure tPikaSurface.SetUV(u1,v1,u2,v2:single);
begin
    VertexList[0].tu:=u1;
    VertexList[1].tu:=u2;
    VertexList[2].tu:=u1;
    VertexList[3].tu:=u2;
    VertexList[0].tv:=v1;
    VertexList[1].tv:=v1;
    VertexList[2].tv:=v2;
    VertexList[3].tv:=v2;
end;

Procedure tPikaSurface.Render;
var ver:array[0..4] of T3DVertex;
    x:integer;
    sx,cx,sy,cy,sz,cz,xz,xy,yx,yz,zy,zx:single;
    pp:pointer;
    matView,matView2:Td3dmatrix;
    matRotX,matRotY,matRotZ,matTrans,matScale,ma,ma2:td3dmatrix;
begin
    {sx := sin(rv1/ 57.2957795);
    cx := cos(rv1/ 57.2957795);
    sy := sin(rh/ 57.2957795);
    cy := cos(rh/ 57.2957795);
    sz := sin(rv2/ 57.2957795);
    cz := cos(rv2/ 57.2957795);    }
    {
    g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,AlphaSrc);//source blend factor
    g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,AlphaDest);//destination blend factor

    sx := sin(self.g_3DScene.EyeRV);
    cx := cos(self.g_3DScene.EyeRV);
    sy := sin(self.g_3DScene.EyeRh);
    cy := cos(self.g_3DScene.EyeRh);
    sz := 0;
    cz := 1;

    //edit the vertex
    for x:=0 to 3 do begin
        ver[x].px:=VertexList[x].px*self.ProX;
        ver[x].py:=VertexList[x].py*self.Proy;
        ver[x].pz:=VertexList[x].pz;

        xy := cos(self.RV1/ 57.2957795)*ver[x].py - sin(self.RV1/ 57.2957795)*ver[x].pz;
        xz := sin(self.RV1/ 57.2957795)*ver[x].py + cos(self.RV1/ 57.2957795)*ver[x].pz;
        // rotation around y
        yz := cos(self.Rh/ 57.2957795)*xz - sin(self.Rh/ 57.2957795)*ver[x].px;
        yx := sin(self.Rh/ 57.2957795)*xz + cos(self.Rh/ 57.2957795)*ver[x].px;
        // rotation around z
        zx := cos(self.RV2/ 57.2957795)*yx - sin(self.RV2/ 57.2957795)*xy;
        zy := sin(self.RV2/ 57.2957795)*yx + cos(self.RV2/ 57.2957795)*xy;



        ver[x].px:=posx+zx;//(VertexList[x].px*self.ProX);
        ver[x].py:=posy+zy;//(VertexList[x].py*self.Proy);
        ver[x].pz:=posz+yz;//VertexList[x].pz;

        if locked then begin
        xy := cx*ver[x].py - sx*ver[x].pz;
        xz := sx*ver[x].py + cx*ver[x].pz;
        // rotation around y
        yz := cy*xz - sy*ver[x].px;
        yx := sy*xz + cy*ver[x].px;
        // rotation around z
        zx := cz*yx - sz*xy;
        zy := sz*yx + cz*xy;

        ver[x].px:=zx+self.g_3DScene.EyeX;
        ver[x].py:=zy+self.g_3DScene.EyeY;
        ver[x].pz:=yz+self.g_3DScene.EyeZ;
        end;

        
        ver[x].color:=self.Color;
        ver[x].tu:=self.VertexList[x].tu;
        ver[x].tv:=self.VertexList[x].tv;
    end;
    //render it as a Triangle strip
    self.g_3DScene.TmpSur.Lock(0,4*24,pp,0);
    move(ver[0],pansichar(pp)[0],4*24);
    self.g_3DScene.TmpSur.Unlock;
    self.g_pd3dDevice.SetStreamSource(0,self.g_3DScene.TmpSur,0,24);
    self.g_pd3dDevice.SetFVF(D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1);
    self.g_pd3dDevice.SetTexture(0,self.Texture);
    //set transparency on texture
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
    self.g_pd3dDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP,0,2);   }

    g_pd3dDevice.GetTransform(D3DTS_VIEW, matView);
    if locked then begin
    D3DXMatrixLookAtLH(matView2, D3DXVector3(0,0,-30), D3DXVector3(0,0,1), D3DXVector3(0.0, 1.0, 0.0));
    g_pd3dDevice.SetTransform(D3DTS_VIEW, matView2);


    g_pd3dDevice.SetRenderState(D3DRS_ZFUNC, D3DCMP_ALWAYS);
    end;
    g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,AlphaSrc);//source blend factor
    g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,AlphaDest);//destination blend factor

    if tail then begin
        if self.PosY > self.tailpos.y then begin
        ver[0].px:=-0.2*self.ProX;
        ver[0].py:=-1*self.Proy;
        ver[0].pz:=0.2;
        ver[0].px:=posx+ver[0].px;
        ver[0].py:=posy+ver[0].py;
        ver[0].pz:=posz+ver[0].pz;
        ver[0].color:=self.Color;
        ver[0].tu:=0;
        ver[0].tv:=0;

        ver[1].px:=0.2*self.ProX;
        ver[1].py:=-1*self.Proy;
        ver[1].pz:=0.2;
        ver[1].px:=posx+ver[1].px;
        ver[1].py:=posy+ver[1].py;
        ver[1].pz:=posz+ver[1].pz;
        ver[1].color:=self.Color;
        ver[1].tu:=1;
        ver[1].tv:=0;

        ver[2].px:=self.tailpos.x;
        ver[2].py:=self.tailpos.y;
        ver[2].pz:=0.2;
        ver[2].color:=self.Color;
        ver[2].tu:=0;
        ver[2].tv:=1;

        end else begin
        ver[0].px:=-0.2*self.ProX;
        ver[0].py:=1*self.Proy;
        ver[0].pz:=0.2;
        ver[0].px:=posx+ver[0].px;
        ver[0].py:=posy+ver[0].py;
        ver[0].pz:=posz+ver[0].pz;
        ver[0].color:=self.Color;
        ver[0].tu:=0;
        ver[0].tv:=0;

        ver[1].px:=0.2*self.ProX;
        ver[1].py:=1*self.Proy;
        ver[1].pz:=0.2;
        ver[1].px:=posx+ver[1].px;
        ver[1].py:=posy+ver[1].py;
        ver[1].pz:=posz+ver[1].pz;
        ver[1].color:=self.Color;
        ver[1].tu:=1;
        ver[1].tv:=0;

        ver[2].px:=self.tailpos.x;
        ver[2].py:=self.tailpos.y;
        ver[2].pz:=0.2;
        ver[2].color:=self.Color;
        ver[2].tu:=0;
        ver[2].tv:=1;
        end;

        self.g_3DScene.TmpSur.Lock(0,3*24,pp,0);
        move(ver[0],pansichar(pp)[0],3*24);
        self.g_3DScene.TmpSur.Unlock;
        self.g_pd3dDevice.SetStreamSource(0,self.g_3DScene.TmpSur,0,24);
        self.g_pd3dDevice.SetFVF(D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1);
        self.g_pd3dDevice.SetTexture(0,self.Texture2);
        //set transparency on texture
        g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
        g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
        g_pd3dDevice.SetRenderState(D3DRS_ZFUNC, D3DCMP_LESSEQUAL);
        self.g_pd3dDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP,0,1);
        g_pd3dDevice.SetRenderState(D3DRS_ZFUNC, D3DCMP_ALWAYS);
    end;

    //rotation
    g_pd3dDevice.GetTransform(D3DTS_WORLD,ma2);           

    //apply the matrix
    D3DXMatrixRotationX( matRotX, self.RV1 /57.2957795 );        // Pitch
    D3DXMatrixRotationY( matRotY, self.rh /57.2957795);        // Yaw
    D3DXMatrixRotationZ( matRotZ, self.rv2 /57.2957795);        // Roll
    // Calculate a translation matrix
    D3DXMatrixTranslation(matTrans,self.PosX,self.PosY,self.PosZ);

    //scale
    //D3DXMatrixScaling(matScale,self.ProX,self.Proy,self.Proz);

    //ma:=(matRotX*matRotY*matRotZ)*matTrans;

    D3DXMatrixMultiply(ma,matRotx,matRoty);
    //D3DXMatrixMultiply(ma,ma,matRotY);
    D3DXMatrixMultiply(ma,ma,matRotz);
    D3DXMatrixMultiply(ma,ma,matTrans);

    g_pd3dDevice.setTransform(D3DTS_WORLD,ma);

    //edit the vertex
    for x:=0 to 3 do begin
        {ver[x].px:=VertexList[x].px*self.ProX;
        ver[x].py:=VertexList[x].py*self.Proy;
        ver[x].pz:=VertexList[x].pz;

        ver[x].px:=posx+ver[x].px;
        ver[x].py:=posy+ver[x].py;
        ver[x].pz:=posz+ver[x].pz;    }
        ver[x].px:=VertexList[x].px*self.ProX;
        ver[x].py:=VertexList[x].py*self.Proy;
        ver[x].pz:=VertexList[x].pz;

        ver[x].color:=self.Color;
        ver[x].tu:=self.VertexList[x].tu;
        ver[x].tv:=self.VertexList[x].tv;
    end;
    //render it as a Triangle strip
    self.g_3DScene.TmpSur.Lock(0,4*24,pp,0);
    move(ver[0],pansichar(pp)[0],4*24);
    self.g_3DScene.TmpSur.Unlock;
    self.g_pd3dDevice.SetStreamSource(0,self.g_3DScene.TmpSur,0,24);
    self.g_pd3dDevice.SetFVF(D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1);
    self.g_pd3dDevice.SetTexture(0,self.Texture);
    //set transparency on texture
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
    self.g_pd3dDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP,0,2);

    g_pd3dDevice.setTransform(D3DTS_WORLD,ma2);



    g_pd3dDevice.SetRenderState(D3DRS_ZFUNC, D3DCMP_LESSEQUAL);
    g_pd3dDevice.SetTransform(D3DTS_VIEW, matView);

end;

Procedure tPikaSurface.SetProportion(Prox,ProY,ProZ:single);
begin
    self.ProX:=prox;
    self.Proy:=proy;
    self.Proz:=proz;
end;

Procedure tPikaSurface.SetRotation(rh,rv1,rv2:single);
begin
    self.rh:=rh;
    self.rv1:=rv1;
    self.rv2:=rv2;
end;

Procedure tPikaSurface.SetCoordinate(x,y,z:single);
var i,o:single;
begin
    //calculate the rotation
    self.posx:=x;
    self.posy:=y;
    self.posz:=z;
end;

Procedure tPikaSurface.LoadFromFile(Filename:ansistring;TransColor:DWORD);
var s:ansistring;
    dta:tmemorystream;
begin
   { s:=filename+#0#0;
    //if self.texture <> nil then self.texture._Release;
    D3DXCreateTextureFromFileEx(self.g_pd3dDevice,@s[1],0,0,0,0, D3DFMT_UNKNOWN
        ,D3DPOOL_DEFAULT,D3DX_DEFAULT,D3DX_DEFAULT ,TransColor,nil,nil,self.texture);   }
    dta:=tmemorystream.Create;
    self.g_3DScene.cs.enter;
    GetFile(filename,dta);
    D3DXCreateTextureFromFileInMemoryEx(self.g_pd3dDevice,dta.Memory,dta.Size,0,0,0,0, D3DFMT_UNKNOWN
        ,D3DPOOL_DEFAULT,D3DX_DEFAULT,D3DX_DEFAULT ,TransColor,nil,nil,self.texture);
    dta.Free;
    self.g_3DScene.cs.leave;
end;

Procedure tPikaSurface.TailLoadFromFile(Filename:ansistring;TransColor:DWORD);
var s:ansistring;
    dta:tmemorystream;
begin
   { s:=filename+#0#0;
    //if self.texture <> nil then self.texture._Release;
    D3DXCreateTextureFromFileEx(self.g_pd3dDevice,@s[1],0,0,0,0, D3DFMT_UNKNOWN
        ,D3DPOOL_DEFAULT,D3DX_DEFAULT,D3DX_DEFAULT ,TransColor,nil,nil,self.texture);   }
    dta:=tmemorystream.Create;
    self.g_3DScene.cs.enter;
    if GetFile(filename,dta) then begin
    D3DXCreateTextureFromFileInMemoryEx(self.g_pd3dDevice,dta.Memory,dta.Size,0,0,0,0, D3DFMT_UNKNOWN
        ,D3DPOOL_DEFAULT,D3DX_DEFAULT,D3DX_DEFAULT ,TransColor,nil,nil,self.texture2);
    dta.Free;
    end;
    g_3DScene.cs.Leave;
end;

Procedure tPikaSurface.LoadFromBitmap(bmp:TBITMAP);
var ts:TMemoryStream;
    C:dword;
    p:pansichar;
    l:HRESULT;
begin
    ts:=TMemoryStream.Create;
    c:=0;
    if bmp.Transparent then c:=$FF000000+(bmp.TransparentColor and $FFFFFF);
    bmp.SaveToStream(ts);
    //p:=allocmem(ts.Size);
    //ts.Position:=0;
    //ts.ReadBuffer(p[0],ts.size);
    //if self.texture <> nil then self.texture._Release;

    l:=D3DXCreateTextureFromFileInMemoryEx(self.g_pd3dDevice,ts.memory,ts.Size,0,0,0,0, D3DFMT_UNKNOWN
        ,D3DPOOL_DEFAULT,D3DX_DEFAULT,D3DX_DEFAULT ,c,nil,nil,self.texture);
    ts.Free;
    if l <> D3D_OK then begin
        if l = D3D_OK then
            raise ERangeError.CreateFmt('%d:D3D_OK error loading memory bitmap',[l]);
        if l = D3DERR_NOTAVAILABLE then
            raise ERangeError.CreateFmt('%d:D3DERR_NOTAVAILABLE error loading memory bitmap',[l]);
        if l = D3DERR_OUTOFVIDEOMEMORY then
            raise ERangeError.CreateFmt('%d:D3DERR_OUTOFVIDEOMEMORY error loading memory bitmap',[l]);
        if l = D3DERR_INVALIDCALL then
            raise ERangeError.CreateFmt('%d:D3DERR_INVALIDCALL error loading memory bitmap',[l]);
        if l = D3DXERR_INVALIDDATA then
            raise ERangeError.CreateFmt('%d:D3DXERR_INVALIDDATA error loading memory bitmap',[l]);
        if l = E_OUTOFMEMORY then
            raise ERangeError.CreateFmt('%d:E_OUTOFMEMORY error loading memory bitmap',[l]);
    end;
    //freemem(p);
end;

Function T3DItem.GetLargessVertex:single ;
var x,y,i:integer;
    fa:single;
begin
    fa:=0;
    for x:=0 to self.FrameCount-1 do begin
        for y:=0 to self.Frame[x].SectionCount-1 do begin
            for i:=0 to self.Frame[x].Section[y].VertexCount-1 do begin
                if self.Frame[x].Section[y].Vertexorg[i].px > fa then
                    fa:=self.Frame[x].Section[y].Vertexorg[i].px;
                if self.Frame[x].Section[y].Vertexorg[i].py > fa then
                    fa:=self.Frame[x].Section[y].Vertexorg[i].py;
                if self.Frame[x].Section[y].Vertexorg[i].pz > fa then
                    fa:=self.Frame[x].Section[y].Vertexorg[i].pz;
            end;
        end;
    end;
    result:=fa;
end;

Function T3DItem.CloneFromItem(it:T3DItem):boolean;
var x,y,i:integer;
begin
    result:=false;
    self.g_pVB:=it.g_pVB;
    self.FrameCount:=it.FrameCount;
    self.TextureCount:=it.TextureCount;
    self.selframe:=it.selframe;
    self.Texture:=it.Texture;
    self.TextureName:=it.TextureName;
    self.ProX:=it.ProX;
    self.Proy:=it.Proy;
    self.Proz:=it.Proz;
    self.PosX:=it.PosX;
    self.rotationseq:=it.rotationseq;
    self.Posy:=it.Posy;
    self.Posz:=it.Posz;
    self.usematerial:=it.usematerial;
    self.baserx:=it.baserx;
    self.basery:=it.basery;
    self.baserz:=it.baserz;
    self.RH:=it.RH;
    self.RV1:=it.RV1;
    self.RV2:=it.RV2;
    self.Alpha:=it.Alpha;
    self.Visible:=false;
    self.PollyCount:=it.PollyCount;
    self.isclone:=true;
    self.maxx:=it.maxx;
    self.maxy:=it.maxy;
    self.maxz:=it.maxz;
    self.minx:=it.minx;
    self.miny:=it.miny;
    self.minz:=it.minz;
    self.usealpha:=it.usealpha;
    self.maped:=it.maped;
    self.COL:=it.COL;
    self.destalpha:=it.destalpha;
    self.srcalpha:=it.srcalpha;
    self.zwrite:=it.zwrite;

    self.usx:=it.usx;
    self.usy:=it.usy;
    self.usz:=it.usz;
    self.dsx:=it.dsx;
    self.dsy:=it.dsy;
    self.dsz:=it.dsz;

    setlength(self.frame,self.FrameCount);
    for x:=0 to self.FrameCount-1 do begin
        self.Frame[x].SectionCount:=it.Frame[x].SectionCount;
        setlength (self.Frame[x].Section,self.Frame[x].Sectioncount);
        for y:=0 to self.Frame[x].SectionCount-1 do begin
            self.Frame[x].Section[y].VertexCount:=it.Frame[x].Section[y].VertexCount;
            self.Frame[x].Section[y].SurfaceType:=it.Frame[x].Section[y].SurfaceType;
            self.Frame[x].Section[y].VertexOrg:=it.Frame[x].Section[y].VertexOrg;
            self.Frame[x].Section[y].IndexListCount:=it.Frame[x].Section[y].IndexListCount;
            self.Frame[x].Section[y].Indexs:=it.Frame[x].Section[y].Indexs;
            self.Frame[x].Section[y].VertexOff:=it.Frame[x].Section[y].VertexOff;
            //self.Frame[x].Section[y].VertexOrg:=it.Frame[x].Section[y].VertexOrg;
            //setlength(self.Frame[x].Section[y].VertexList,self.Frame[x].Section[y].VertexCount);
            {if failed(self.g_pd3dDevice.CreateVertexBuffer(self.Frame[x].Section[y].VertexCount*36,0,
            D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.Frame[x].Section[y].VertexList ,0)) then exit;  }
            {move(it.Frame[x].Section[y].VertexList[0],self.Frame[x].Section[y].VertexList[0]
                ,it.Frame[x].Section[y].VertexCount*24);  }
        end;
    end;
    result:=true;
    cs.Enter;
    rdy:=true;
    cs.Leave;
end;

Function T3DItem.LoadFromNJ(filename,TexName,aniname:ansistring):boolean;
Const //verflag :array[0..18] of Byte = (3, 15, 1, 3, 3, 3, 3, 3, 3, 5, 13, 13, 13, 13, 13, 13, 3, 11, 11);
    verflag :array[0..18] of Byte = (3, 15, 1, 3, $11, $21, 3, 3, 3, 5, 13, $15, $25, 13, 13, 13, 3, 11, $13);
      sfmt: array[0..$b] of Byte = (1, 3, 3, 9, 11, 11, 5, 7, 7, 1, 19, 19);
      uvc:array[0..2] of Integer = (1, 255, 1023);
      DXT5_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$00#$01#$00#$00#$00#$01#$00#$00#$00#$00
        +#$01#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$33
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
       DXT1_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$40#$00#$00#$00#$40#$00#$00#$00#$00#$08
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$31
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
Type
    T3DNJVertex = record
        px,py,pz,nx,ny,nz:single;
        bone:integer;
    end;
    TNJM_Header = Record
        Off:dword;
        count:dword;
        flag:word;
        number:word;
    end;
    TNJS_OBJECT = Record
        Flag:dword;
        PMODEL:DWORD;
        pos:array[0..2] of single;
        ang:array[0..2] of dword;
        scale:array[0..2] of single;
        PChild,PSibl:integer;
    end;
    TNJS_CNK_MODEL= record
        PVertex:dword;
        PPPoly:dword;
        Center:array[0..2] of single;
        radius:single;
    end;
    Tnjheader = record
        name:dword;
        size:dword;
    end;
    TXVMHeader = record
        Flag:dword;
        Size:dword;
        count:dword;
        unused:array[0..12] of dword;
    end;
    TXVRHeader = record
        Flag:dword;
        Size:dword;
        PixelFormat:dword;
        DXTFormat:dword;
        ID:Dword;
        sx,sy:word;
        DataSize:dword;
        unused:array[0..8] of dword;
    end;
    T3single =record
        s1,s2,s3:single;
    end;
    T3angle =record
        s1,s2,s3:word;
    end;
var f,i,p,o,tid,mat,maxv,fra,fani,basep,basetex,tstee,hightex:integer;
    head:Tnjheader;
    b:ansistring;
    data:pansichar;
    chunkptr:array[0..255] of integer;
    Ver:array of T3DNJVertex;
    njj:TNJS_OBJECT;
    njop:array[0..1000] of TNJS_OBJECT;
    vvv: T3DNJVertex;
    ani:TNJM_Header;
    curmat:TD3DMaterial9;
    ObjMap:array[0..4000] of TNJS_OBJECT;
    ObjMapC:integer;
    lastnjo:integer;
    ishead:boolean;
Function MakeRVB(t:integer):integer;
var c:integer;
begin
    c:=((t div $400) and $1F) *8;
    c:=c+((((t div $20) and $1f) *8)*256);
    c:=c+((((t div $1) and $1f) *8)*65536);
    if t and $7fff = 0 then c:=$10101;
    if t and $8000 <> $8000 then c:=$0;
    result:=c;
end;
Function twiddled_vq(sx:integer;p,p2:pansichar):integer;
var x,y,ptr:integer;
    vqtable:array[0..4*256] of dword;
    c:word;
    TT:array[0..1023] of integer;
    m:pansichar;
    b:Tbitmap;
    ts:Tstream;
begin
    b:=TBitmap.Create;
    b.Width:=sx;
    b.Height:=sx;
    b.TransparentColor:=0;
    b.Transparent:=true;
    ptr:=0;
    for x:=0 to 1023 do
    tt[x] := (x and 1)or((x and 2)*2)or((x and 4)*4)or((x and 8)*8)or((x and 16)*16)or
      ((x and 32)*32)or((x and 64)*64)or((x and 128)*128)or((x and 256)*256)or((x and 512)*512);
    for x:=0 to 1023 do
    begin
       vqtable[x]:=MakeRVB(byte(p[ptr])+(byte(p[ptr+1])*256));
       ptr:=ptr+2;
    end;
    m:=@p[ptr];
    for y:=0 to (sx div 2)-1 do
        for x:=0 to (sx div 2)-1 do begin
            c:=byte(m[tt[y] or (tt[x]*2)]);
            //vq:=@vqtable[c*4];
            b.Canvas.Pixels[x*2,y*2]:=vqtable[(c*4)];
            b.Canvas.Pixels[(x*2)+1,y*2]:=vqtable[(c*4)+2];
            b.Canvas.Pixels[x*2,(y*2)+1]:=vqtable[(c*4)+1];
            b.Canvas.Pixels[(x*2)+1,(y*2)+1]:=vqtable[(c*4)+3];
        end;
    ts:=TMemoryStream.Create;
    b.SaveToStream(ts);
    result:=ts.Size;
    ts.Position:=0;
    ts.ReadBuffer(p2[0],result);
    ts.Free;
end;
Function PSOLoadTexture(s:ansistring):boolean;
var h:TXVMHeader;
    b:TXVRHeader;
    f,f2,i,x:integer;
    p,p2:pansichar;
begin
    f:=fileopen(s,$40); //open xvm file
    fileread(f,h,$40);  //read the header
    self.TextureCount:=self.TextureCount+h.count;
    setlength( self.texture ,self.TextureCount); //set texture memory
    for i:=0 to h.count-1 do begin
        fileread(f,b,$40); //read the xvr header
        p:=allocmem(b.Size+128); //reserve memory for data+DDS header
        fileread(f,p[128],b.Size-$38); //read the data
        //texFlag[i]:=b.PixelFormat;
        if b.DXTFormat = 3 then begin
            //old format, convert to bmp first
            //self.texFlag[i]:=0;
            p2:=allocmem(3000000);
            x:=twiddled_vq(b.sx,@p[128],p2);
            D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p2,x,self.texture[i]);
            freemem(p2);
        end else begin
        if b.DXTFormat = 6 then move(DXT1_Header[1],p[0],128) //DXT1 header
        else move(DXT5_Header[1],p[0],128); //DXT3 header
        move(b.sx,p[12],2); //set the X size
        move(b.sy,p[16],2); //set the Y size
        move(b.datasize,p[20],4); //set the data size

        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p,b.DataSize+128,self.texture[i]);
        end;
        freemem(p);
    end;
    fileclose(f);
end;
Function MatrixVertex(ve:T3DNJVertex;njo:integer;njm:TNJS_CNK_MODEL;pctu:byte):T3DNJVertex;
var re:T3DNJVertex;
    r,sx,cx,sy,cy,sz,cz,xy,xz,yz,yx,zx,zy:single;
    i,jjj,k:integer;
begin
    re:=ve;
    //do rotation scale and other if needed

    jjj:=njo;

    for i:=jjj downto 0 do begin

    if njop[i].Flag and 4 = 0 then begin  //scale
        re.px:=re.px*njop[i].scale[0];
        re.py:=re.py*njop[i].scale[1];
        re.pz:=re.pz*njop[i].scale[2];
        //end;

    end;


    if njop[i].Flag and 2 = 0 then begin  //rotation
        sx := sin((njop[i].ang[0] and $FFFF)/ 10430.378350);
        cx := cos((njop[i].ang[0] and $FFFF)/ 10430.378350);
        sy := sin((njop[i].ang[1] and $FFFF)/ 10430.378350);
        cy := cos((njop[i].ang[1] and $FFFF)/ 10430.378350);
        sz := sin((njop[i].ang[2] and $FFFF)/ 10430.378350);
        cz := cos((njop[i].ang[2] and $FFFF)/ 10430.378350);

        xy := cx*(re.py) - sx*(re.pz);
        xz := sx*(re.py) + cx*(re.pz);
        // rotation around y
        yz := cy*xz - sy*(re.px);
        yx := sy*xz + cy*(re.px);
        // rotation around z
        zx := cz*yx - sz*xy;
        zy := sz*yx + cz*xy;

        re.px:=zx;
        re.py:=zy;
        re.pz:=yz;
    end;

    if njop[i].Flag and 1 = 0 then begin  //position
        re.px:=re.px+njop[i].pos[0];
        re.py:=re.py+njop[i].pos[1];
        re.pz:=re.pz+njop[i].pos[2];
        //end;
    end;
    end;
    re.pz:=-re.pz;
    result:=re;
end;
Procedure ProcedeChunk(f,p:integer;njo:integer;njm:TNJS_CNK_MODEL);
var o,i,l,v,x,y,z,sn,q,ll,e:integer;
    ChkHead:array[0..3] of byte;
    pp:pointer;
    tmv:T3DNJVertex;
    test:array[0..12] of byte;
    dbg:ansistring;
begin

    o:=1;
    while o = 1 do begin
        if fileread(f,ChkHead,2) = 0 then begin
            ChkHead[0]:=0;
            o:=0;
        end;
        if ChkHead[0] = 0 then begin
            //null chunk
        end else if (ChkHead[0] > 0) and (ChkHead[0] <= 7) then begin
            //tiny chunk
            if ChkHead[0] = 1 then begin
                mat:=ChkHead[1] and $3f;
            end;
            if ChkHead[0] = 4 then begin
                i:=fileseek(f,0,1);
                chunkptr[ChkHead[1]]:=i;
                o:=0;
            end;
            if ChkHead[0] = 5 then begin
                i:=fileseek(f,0,1);
                fileseek(f,chunkptr[ChkHead[1]],0);
                ProcedeChunk(f,p,njo,njm);
                fileseek(f,i,0);
            end;
            {if ChkHead[0] = 7 then begin
                //DW cmd7 / DW offset / DW size / DW

            end; }
        end else if ChkHead[0] = 8 then begin
            //texture id 1 chunk
            fileread(f,ChkHead[2],2);
            tid:=ChkHead[2]+((ChkHead[3]and $3f)*256);
        end else if ChkHead[0] = 9 then begin
            //texture id 2 chunk
            fileread(f,ChkHead[2],2);
        end else if ChkHead[0] and 128 = 128 then begin
            //end chunk
            fileread(f,ChkHead[2],2);
            o:=0;
        end else if (ChkHead[0] >= $10) and (ChkHead[0] <= $17) then begin
            //material 1
            fileread(f,ChkHead[2],2);
            if (ChkHead[0]-$10) and 1 = 1 then begin
                fileread(f,test[0],4);
                curmat.Diffuse.r:=test[0]/255;
                curmat.Diffuse.g:=test[1]/255;
                curmat.Diffuse.b:=test[2]/255;
                curmat.Diffuse.a:=test[3]/255;
            end;
            if (ChkHead[0]-$10) and 2 = 2 then begin
                fileread(f,test[0],4);
                curmat.Ambient.r:=test[0]/255;
                curmat.Ambient.g:=test[1]/255;
                curmat.Ambient.b:=test[2]/255;
                curmat.Ambient.a:=test[3]/255;
            end;
            if (ChkHead[0]-$10) and 4 = 4 then begin
                fileread(f,test[0],4);
                curmat.Specular.r:=test[0]/255;
                curmat.Specular.g:=test[1]/255;
                curmat.Specular.b:=test[2]/255;
                curmat.Specular.a:=test[3]/255;
            end;
             //TD3DMaterial9
            //fileseek(f,(ChkHead[2]+(ChkHead[3]*256))*2,1);
            mat:=ChkHead[1] and $3f;
        end else if (ChkHead[0] >= $18) and (ChkHead[0] <= $1f) then begin
            fileread(f,ChkHead[2],2);
            fileseek(f,(ChkHead[2]+(ChkHead[3]*256))*2,1);
        end else if (ChkHead[0] >= $20) and (ChkHead[0] <= $37) then begin;
            i:=fileseek(f,0,1)-2;
            //size *4 : dword
            //index buffer start
            //number of vertex
            fileread(f,ChkHead[2],2);
            if ChkHead[1] and 3 = 0 then begin
            v:=0;
            l:=0;
            fileread(f,v,2); //first index
            fileread(f,l,2); //count

            for x:=0 to l-1 do begin
                dbg:='';
                fillchar(tmv,24,0);
                if verflag[ChkHead[0]-$20] and 1 = 1 then begin
                    fileread(f,tmv.px,12);   //xyz
                    if fra = 0 then dbg:=dbg+format('X: %f ,Y: %f ,Z: %f ',[tmv.px,tmv.py,tmv.pz]);
                end;
                if verflag[ChkHead[0]-$20] and 2 = 2 then begin        //extra 1.0f
                    fileread(f,e,4);
                    if fra = 0 then dbg:=dbg+format('Extra: %.8x ',[e]);
                end;
                e:=0;
                if verflag[ChkHead[0]-$20] and 4 = 4 then begin
                    fileread(f,tmv.nx,12);   //nxnynz
                    if fra = 0 then dbg:=dbg+format('NX: %f ,NY: %f ,NZ: %f ',[tmv.nx,tmv.ny,tmv.nz]);
                end;
                if verflag[ChkHead[0]-$20] and 8 = 8 then begin     //extra 0.0f
                    fileread(f,e,4);
                    if fra = 0 then dbg:=dbg+format('Extra2: %.8x ',[e]);
                end;
                if verflag[ChkHead[0]-$20] and 16 = 16 then begin     //userflag32
                    fileread(f,e,4);
                    if fra = 0 then dbg:=dbg+format('uFlag: %.8x ',[e]);
                end;
                if verflag[ChkHead[0]-$20] and 32 = 32 then begin  //ninja flag 32
                    fileread(f,e,4);
                    ver[v+(e and $ffff)]:=MatrixVertex(tmv,njo,njm,(e div $10000));
                    if fra = 0 then dbg:=inttohex(v+(e and $ffff),2)+' : '+dbg+format('nFlag: %.8x ',[e]);
                    ver[v+(e and $ffff)].bone:=objmapc-1;
                    if (e div $10000) < $33 then ver[v+(e and $ffff)].bone:=objmapc;
                    if ishead then ver[v+(e and $ffff)].bone:=55;
                    //if (e div $10000) > $cc then ver[v+(e and $ffff)].bone:=objmapc-2;//objmap[objmapc-1].PChild;
                end
                else begin
                    ver[v]:=MatrixVertex(tmv,njo,njm,0);
                    ver[v].bone:=objmapc-1;
                    if ishead then ver[v+(e and $ffff)].bone:=55;
                    if fra = 0 then dbg:=inttohex(v+(e and $ffff),2)+' : '+dbg;
                     inc(v);
                end;

               // if fra = 0 then form2.Memo1.Lines.Add(dbg);
            end;
            //ver[$d7].px:=652;    //the broken one
            end else
                fileseek(f,((ChkHead[2]+(ChkHead[3]*256))*4),1);
        end else if (ChkHead[0] >= $38) and (ChkHead[0] <= $3a) then begin
            fileread(f,ChkHead[2],2);
            fileseek(f,(ChkHead[2]+(ChkHead[3]*256))*2,1);
        end else if (ChkHead[0] >= $40) and (ChkHead[0] <= $4b) then begin;
            i:=fileseek(f,0,1)+2;
            //size *4 : dword
            //index buffer start
            //number of vertex
            fileread(f,ChkHead[2],2);

            v:=0;
            l:=0;
            y:=ChkHead[2]+(ChkHead[3]*256);
            fileread(f,l,2); //count
            v:=l div 16384;
            l:=l and $3FFF;
            //new section
            sn:=self.frame[fra].SectionCount;
            inc(self.frame[fra].SectionCount);
            setlength(self.frame[fra].section,self.frame[fra].SectionCount);
            self.frame[fra].section[sn].VertexCount:=0;
            self.frame[fra].section[sn].IndexListCount:=l;
            self.frame[fra].section[sn].SurfaceType:=D3DPT_TRIANGLESTRIP;
            setlength(self.frame[fra].section[sn].Indexs,l);
            for z:=0 to l-1 do begin
            y:=0;
            fileread(f,y,2);
            ll:=0;
            if y and $8000 = $8000 then begin
                y:=$10000-y;
                ll:=1;
            end;
            self.frame[fra].section[sn].Indexs[z].IndexCount:=y;
            self.frame[fra].section[sn].Indexs[z].SurfaceCount:=y-2;
            if tid > hightex then hightex:=tid;
            self.frame[fra].section[sn].Indexs[z].TextureID:=tid+basetex;
            self.frame[fra].section[sn].Indexs[z].material:=curmat;
            self.frame[fra].section[sn].Indexs[z].AlphaSrc:=mat div 8;
            self.frame[fra].section[sn].Indexs[z].AlphaDst:=mat and 7;
            //if fra = 0 then form2.Memo1.Lines.Add('Index draw');
            if mat and 7 = 1 then self.AlphaLevel:=254;
            if Failed( self.g_pd3dDevice.CreateIndexBuffer(y*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT
            ,self.frame[fra].section[sn].Indexs[z].g_pIB,nil)) then exit;
            self.frame[fra].section[sn].Indexs[z].g_pIB.lock(0,y*2,pp,0);
            for x:=0 to y-1 do begin
                setlength(self.frame[fra].section[sn].VertexOrg,self.frame[fra].section[sn].VertexCount+1);
                //setlength(self.frame[fra].section[sn].VertexList,self.frame[fra].section[sn].VertexCount+1);
                setlength(self.frame[fra].section[sn].VertexFlag,self.frame[fra].section[sn].VertexCount+1);

                //make the vertex
                if sfmt[ChkHead[0]-$40] and 1 = 1 then begin
                    //copy the vertex
                    q:=0;
                    fileread(f,q,2);
                    self.frame[fra].section[sn].VertexFlag[self.frame[fra].section[sn].VertexCount]:=ver[q].bone;
                    move(ver[q],self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount],12);
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].color:=$FFFFFFFF;
                end;
                if sfmt[ChkHead[0]-$40] and 2 = 2 then begin
                    //generate the UV
                    fileread(f,q,4);
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tu:=(q and $FFFF) / uvc[(ChkHead[0]-$40) mod 3];
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tv:=(q div $10000) / uvc[(ChkHead[0]-$40) mod 3];
                end else begin
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tu:=0;
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tv:=0;
                end;
                if sfmt[ChkHead[0]-$40] and 4 = 4 then
                    fileseek(f,4,1);
                if sfmt[ChkHead[0]-$40] and 8 = 8 then
                    fileseek(f,6,1);
                if sfmt[ChkHead[0]-$40] and 16 = 16 then
                    fileseek(f,4,1);
                if v >0 then
                    fileseek(f,v*2,1);
                //save the index
                move(self.frame[fra].section[sn].VertexCount,pansichar(pp)[x*2],2);
                inc(self.frame[fra].section[sn].VertexCount);
            end;
            self.frame[fra].section[sn].Indexs[z].g_pIB.unlock;
            if self.frame[fra].section[sn].VertexCount > maxv then
                    maxv:=self.frame[fra].section[sn].VertexCount;
            end;
            fileseek(f,i+((ChkHead[2]+(ChkHead[3]*256))*2),0);
        end else
        begin
            o:=0;
        end;
    end;
end;
Function GetSingleAni(off,count,f:integer):T3single;
var x,i,d:integer;
    s1,s2:T3single;
    f1,f2:integer;
begin
    fileseek(fani,off+8,0);
    //look if any match the frame
    f1:=-1;
    f2:=65535;
    for x:=0 to count-1 do begin
        fileread(fani,i,4);
        if (i > f1) and (i <= f) then begin
            fileread(fani,s1,12);
            f1:=i;
        end else if (i < f2) and (i >= f) then begin
            fileread(fani,s2,12);
            f2:=i;
        end else
            fileseek(fani,12,1);
    end;

    if f1 < f then begin
        i:=f2-f1;
        s1.s1:=s1.s1+(((s2.s1-s1.s1)/i)*(f-f1));
        s1.s2:=s1.s2+(((s2.s2-s1.s2)/i)*(f-f1));
        s1.s3:=s1.s3+(((s2.s3-s1.s3)/i)*(f-f1));

    end;
    result:=s1;
end;
Function GetAngleAni(off,count,f:integer):T3Angle;
var x,i,c:integer;
    s1,s2:T3angle;
    f1,f2:integer;
    r:word;
begin
    fileseek(fani,off+8,0);
    f1:=-1;
    f2:=65535;
    i:=0;
    for x:=0 to count-1 do begin
        fileread(fani,i,2);
        {if (i > f1) and (i <= f) then begin
                f1:=i;
                fileread(fani,s1,6);
        end else
        fileseek(fani,6,1);  }
        if (i > f1) and (i <= f) then begin
            fileread(fani,s1,6);
            f1:=i;
        end else if (i < f2) and (i >= f) then begin
            fileread(fani,s2,6);
            f2:=i;
        end else
            fileseek(fani,6,1);
    end;
    if f1 < f then begin
        i:=f2-f1;
        r:=s2.s1-s1.s1;
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(f-f1)) div i;
            s1.s1:=s1.s1+c;
        end else begin
            c:=(r*(f-f1)) div i;
            s1.s1:=s1.s1+c;
        end;

        r:=s2.s2-s1.s2;
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(f-f1)) div i;
            s1.s2:=s1.s2+c;
        end else begin
            c:=(r*(f-f1)) div i;
            s1.s2:=s1.s2+c;
        end;

        r:=s2.s3-s1.s3;
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(f-f1)) div i;
            s1.s3:=s1.s3+c;
        end else begin
            c:=(r*(f-f1)) div i;
            s1.s3:=s1.s3+c;
        end;


    end;

    result:=s1;
end;

procedure QuatToAngle(qx,qy,qz,qw:single; var ex,ey,ez:single);
var matrix:array[0..2,0..2] of single;
    cx,sx,x:single;
    cy,sy,y,yr:single;
    cz,sz,z:single;
    sqw,sqz,sqy,sqx:single;
begin

    matrix[0][0] := 1.0 - (2.0 * qy * qy) - (2.0 * qz * qz);
    matrix[1][0] := (2.0 * qx * qy) + (2.0 * qw * qz);
    matrix[2][0] := (2.0 * qx * qz) - (2.0 * qw * qy);
    matrix[2][1] := (2.0 * qy * qz) + (2.0 * qw * qx);
    matrix[2][2] := 1.0 - (2.0 * qx * qx) - (2.0 * qy * qy);
    sy := -matrix[2][0];
    if sy < -1 then sy:=-1;
    if sy > 1 then sy:=1;
    cy := sqrt(1 - (sy * sy));
    if IsNan(cy) then
        cy:=1;    
    yr := arctan2(sy,cy);
    ey := yr;
    if (sy <> 1.0) and ( sy <> -1.0) then begin
        cx := matrix[2][2] / cy;
        sx := matrix[2][1] / cy;
        ex := arctan2(sx,cx) ;
        cz := matrix[0][0] / cy;
        sz := matrix[1][0] / cy;
        ez := arctan2(sz,cz);
    end
    else
    begin
        matrix[1][1] := 1.0 - (2.0 * qx * qx) - (2.0 * qz * qz);
        matrix[1][2] := (2.0 * qy * qz) - (2.0 * qw * qx);
        cx := matrix[1][1];
        sx := -matrix[1][2];
        ex := arctan2(sx,cx) ;
        cz := 1.0;
        sz := 0.0;
        ez := arctan2(sz,cz) ;
    end;
end;

Function GetAngleAni2(off,count,f:integer):T3Angle;
var x,i:integer;
    s1:T3angle;
    f1:integer;
    s2:array[0..3] of single;
    angle,s,cx,cy,cz,cw,rx,ry,rz:single;
begin
    fileseek(fani,off+8,0);
    f1:=-1;
    i:=0;
    for x:=0 to count-1 do begin
        fileread(fani,i,4);
        if (i > f1) and (i <= f) then begin
                f1:=i;
                fileread(fani,s2[0],16);
        end else
        fileseek(fani,16,1);
    end;

    QuatToAngle(s2[1],s2[2],s2[3],s2[0],rx,ry,rz);


   s1.s1:=round(rx*10430.378350);
   s1.s2:=round(ry*10430.378350);
   s1.s3:=round(rz*10430.378350);//57.2957795);


    result:=s1;
end;

Procedure ProcedeChild(f,p:integer;njo:integer);
var i,o:integer;
    b:ansistring;
    data:pansichar;
    njm:TNJS_CNK_MODEL;
    tmpa:array[0..20] of dword;
    tmpp:integer;
    a3:T3angle;
    s3:T3single;
    dada:integer;
begin
    fileread(f,njop[njo],sizeof(njop[0]));
    move(njop[njo].flag,ObjMap[ObjMapC].flag,sizeof(njop[0])-8);
    inc(ObjMapC);
    dada:=ObjMap[ObjMapC-1].PChild;

     if not ishead then lastnjo:=njo;
    //njo.pos[0]:=self.frame[0].sectioncount*100;
    if njop[njo].PMODEL <> 0 then begin
        fileseek(f,p+njop[njo].PMODEL,0);
        fileread(f,njm,sizeof(njm));
        //procede chunk
        if njm.PVertex<>0 then begin
            fileseek(f,p+njm.PVertex,0);
            ProcedeChunk(f,p,njo,njm);
        end;
        if njm.PPPoly<>0 then begin
            fileseek(f,p+njm.PPPoly,0);
            ProcedeChunk(f,p,njo,njm);
        end;

    end;

    if njop[njo].PChild<>0 then begin
        fileseek(f,p+njop[njo].PChild,0);
        ObjMap[ObjMapC].PChild:=ObjMapC-1;
        ProcedeChild(f,p,njo+1);
    end;

    if njop[njo].PSibl<>0 then begin
        fileseek(f,p+njop[njo].PSibl,0);
        ObjMap[ObjMapC].PChild:=dada;
        ProcedeChild(f,p,njo);
    end;

end;
var tv:t3dvertex;
    mbones:array[0..200] of integer;
    lp:integer;
    ma:TD3DMATRIX;
    vec2:TD3DXVECTOR3;
    tnjs:tnjs_object;
    tmpa:array[0..20] of dword;
    tmpp:integer;
    a3:T3angle;
    s3:T3single;
    fn2:ansistring;
    njotouse:integer;
begin
    result:=false;
        setlength(Ver,$7FFF);              // sdfsd gardé en indice le bone#
        ObjMapC:=0;
        usematerial:=true;
        maxv:=0;
        ishead:=false;
        fra:=0;
        basetex:=0;
        basep:=0;
        fillchar(njop[0],sizeof(njop[0]),0);
        fillchar(ver[0],sizeof(ver),0);
        ani.count:=1;
        fani:=-1;
        if aniname <> '' then begin
            fani:=fileopen(aniname,$40);
            fileseek(fani,8,0);
            fileread(fani,ani,12);
            //if ani.count > 400 then ani.count:=400;
        end;
        self.FrameCount:=ani.count;
        self.usealpha:=true;
        setlength(self.frame,ani.count);
        tstee:=0;
        ObjMap[ObjMapC].PChild:=-1;

        fn2:=filename;
        if pos(';',filename) > 0 then begin
            fn2:=copy(filename,1,pos(';',filename)-1);
        end;
        delete(filename,1,length(fn2)+1);
        f:=fileopen(fn2,$40);
        if f >0 then begin
        if fileexists(texname) then
            PSOLoadTexture(texname);
        i:=fileread(f,head,8);
        p:=8;
        for fra:=0 to ani.count-1 do begin
                    self.frame[fra].SectionCount:=0;
        end;

        fra:=0;
        basetex:=0;
        lastnjo:=0;
        njotouse:=0;
        fillchar(njop[0],sizeof(njop[0]),0);

        while i = 8 do begin
            b:='    ';               
            move(head.name,b[1],4);
            if head.name = $4d434a4e then begin //njcm
                //for fra:=0 to ani.count-1 do begin
                    //self.frame[fra].SectionCount:=0;
                    fra:=0;
                    //basetex:=0;
                    fileseek(f,p,0);
                    basep:=0;
                    hightex:=0;
                    ProcedeChild(f,p,njotouse);
                    if ishead then dec(objmapc);
                //end;
            end;
            if head.name = $4c444d4e then begin //njcm
                b:='                ';
                fileread(f,b[1],16);
                fileclose(f);
                if fileexists(changefileext(extractfilepath(FileName)+pansichar(@b[1]),'.xvm')) then begin
                    basetex:=self.TextureCount;
                    PSOLoadTexture(changefileext(extractfilepath(FileName)+pansichar(@b[1]),'.xvm'));
                end else basetex:=0;
                f:=fileopen(extractfilepath(FileName)+pansichar(@b[1]),$40);
                p:=0;
                head.size:=0;
            end;
            inc(p,head.size);
            fileseek(f,p,0);
            i:=fileread(f,head,8);

            if i = 0 then begin
                fn2:=filename;
                if pos(';',filename) > 0 then begin
                    fn2:=copy(filename,1,pos(';',filename)-1);
                end;
                delete(filename,1,length(fn2)+1);
                if fn2 <> '' then begin
                    fileclose(f);
                    f:=fileopen(fn2,$40);
                    p:=0;
                    head.size:=0;
                    i:=fileread(f,head,8);
                    njotouse:=6;
                    move(ObjMap[55],njop[5],sizeof(Tnjs_object));
                    move(ObjMap[25],njop[4],sizeof(Tnjs_object));
                    move(ObjMap[24],njop[3],sizeof(Tnjs_object));
                    move(ObjMap[2],njop[2],sizeof(Tnjs_object));
                    move(ObjMap[1],njop[1],sizeof(Tnjs_object));
                    move(ObjMap[0],njop[0],sizeof(Tnjs_object));
                    ishead:=true;
                    inc(basetex,hightex+1);
                    //ObjMap[ObjMapC].PChild:=ObjMapC-1;
                end;
            end;
            inc(p,8);
        end;
        fileclose(f);

        //if fani > -1 then begin
        //redo all the frame
        //demap eatch vertex
        for i:=0 to self.frame[0].SectionCount-1 do
        for p:=0 to self.frame[0].Section[i].VertexCount-1 do begin
            tv:=self.frame[0].Section[i].Vertexorg[p];
            tv.pz:=-tv.pz;
            //go down the bones and map them
            f:=0;
            mbones[0]:=self.frame[0].Section[i].VertexFlag[p];
            while objmap[mbones[f]].PChild <> -1 do begin
                mbones[f+1]:=objmap[mbones[f]].PChild;
                inc(f);
            end;
            for lp:=f downto 0 do begin
                if objmap[mbones[lp]].Flag and 1 = 0 then begin
                    tv.px:=tv.px-objmap[mbones[lp]].pos[0];
                    tv.py:=tv.py-objmap[mbones[lp]].pos[1];
                    tv.pz:=tv.pz-objmap[mbones[lp]].pos[2];
                end;
                if objmap[mbones[lp]].Flag and 4 = 0 then begin
                    tv.px:=tv.px/objmap[mbones[lp]].scale[0];
                    tv.py:=tv.py/objmap[mbones[lp]].scale[1];
                    tv.pz:=tv.pz/objmap[mbones[lp]].scale[2];
                end;
                if objmap[mbones[lp]].Flag and 2 = 0 then begin  //rotate
                    D3DXMatrixRotationz(ma,($0-(objmap[mbones[lp]].ang[2] and $ffff))/ 10430.378350);
                    D3DXVec3TransformCoord(vec2,D3DXVECTOR3(tv.px,tv.py,tv.pz),ma);
                    D3DXMatrixRotationy(ma,($0-(objmap[mbones[lp]].ang[1] and $ffff))/ 10430.378350);
                    D3DXVec3TransformCoord(vec2,vec2,ma);
                    D3DXMatrixRotationx(ma,($0-(objmap[mbones[lp]].ang[0] and $ffff))/ 10430.378350);
                    D3DXVec3TransformCoord(vec2,vec2,ma);
                    move(vec2,tv,12);
                end;
            end;

            self.frame[0].Section[i].Vertexorg[p]:=tv;
        end;

        //remap all of them by frame
        for fra:=ani.count-1 downto 0 do begin
            self.frame[fra].SectionCount:=self.frame[0].SectionCount;
            setlength(self.frame[fra].Section,self.frame[fra].SectionCount);
            if fani > -1 then begin
            for i:=0 to objmapc-1 do begin
                //add motion

                fileseek(fani,8+ani.Off+((ani.number*8)*i),0);
                fileread(fani,tmpa[0],(ani.number*8));
                tmpp:=0;

                    if ani.flag and 1 = 1 then begin //pos
                        if tmpa[tmpp] <> 0 then begin
                            s3:=GetSingleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].pos[0]:=s3.s1;
                            objmap[i].pos[1]:=s3.s2;
                            objmap[i].pos[2]:=s3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fe;
                        end;
                        inc(tmpp);
                    end;
                    if ani.flag and 2 = 2 then begin //rotation
                        if tmpa[tmpp] <> 0 then begin
                            a3:=GetAngleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].ang[0]:=a3.s1;
                            objmap[i].ang[1]:=a3.s2;
                            objmap[i].ang[2]:=a3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fd;
                        end;
                        inc(tmpp);
                    end;
                    if ani.flag and $2000 = $2000 then begin //rotation
                        if tmpa[tmpp] <> 0 then begin
                            a3:=GetAngleAni2(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].ang[0]:=a3.s1;
                            objmap[i].ang[1]:=a3.s2;
                            objmap[i].ang[2]:=a3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fd;
                        end;
                        inc(tmpp);
                    end;
                    if ani.flag and 4 = 4 then begin //scale
                        if tmpa[tmpp] <> 0 then begin
                            s3:=GetSingleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].scale[0]:=s3.s1;
                            objmap[i].scale[1]:=s3.s2;
                            objmap[i].scale[2]:=s3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fb;
                        end;
                        inc(tmpp);
                    end;

                end;
            end;


            for i:=0 to self.frame[0].SectionCount-1 do begin
                self.frame[fra].Section[i].VertexCount:=self.frame[0].Section[i].VertexCount;
                self.frame[fra].Section[i].SurfaceType:=self.frame[0].Section[i].SurfaceType;
                self.frame[fra].Section[i].IndexListCount:=self.frame[0].Section[i].IndexListCount;
                self.frame[fra].Section[i].Indexs:=self.frame[0].Section[i].Indexs;
                self.frame[fra].Section[i].VertexFlag:=self.frame[0].Section[i].VertexFlag;
                //setlength(self.frame[fra].Section[i].VertexList,self.frame[0].Section[i].VertexCount);
                setlength(self.frame[fra].Section[i].VertexOrg,self.frame[0].Section[i].VertexCount);

                //remap them all
                //move(self.frame[0].Section[i].Vertexorg[0],self.frame[fra].Section[i].Vertexorg[0],sizeof(t3dvertex)*self.frame[0].Section[i].VertexCount);

                for p:=0 to self.frame[0].Section[i].VertexCount-1 do begin
                    f:=self.frame[0].Section[i].VertexFlag[p];
                    tv:=self.frame[0].Section[i].Vertexorg[p];
                    while f > -1 do begin
                         tnjs:=objmap[f];

                        if tnjs.Flag and 4 = 0 then begin
                            tv.px:=tv.px*tnjs.scale[0];
                            tv.py:=tv.py*tnjs.scale[1];
                            tv.pz:=tv.pz*tnjs.scale[2];
                        end;
                        if tnjs.Flag and 2 = 0 then begin  //rotate
                            D3DXMatrixRotationX(ma,tnjs.ang[0]/ 10430.378350);
                            D3DXVec3TransformCoord(vec2,D3DXVECTOR3(tv.px,tv.py,tv.pz),ma);
                            D3DXMatrixRotationy(ma,tnjs.ang[1]/ 10430.378350);
                            D3DXVec3TransformCoord(vec2,vec2,ma);
                            D3DXMatrixRotationz(ma,tnjs.ang[2]/ 10430.378350);
                            D3DXVec3TransformCoord(vec2,vec2,ma);
                            move(vec2,tv,12);
                        end;

                        if tnjs.Flag and 1 = 0 then begin
                            tv.px:=tv.px+tnjs.pos[0];
                            tv.py:=tv.py+tnjs.pos[1];
                            tv.pz:=tv.pz+tnjs.pos[2];
                        end;

                        f:=objmap[f].PChild;
                        //f:=-1;
                    end;
                    tv.pz:=-tv.pz;
                    self.frame[fra].Section[i].Vertexorg[p]:=tv;
                end;

            end;
        end;

        //end;
        if fani > -1 then fileclose(fani);

        if failed(self.g_pd3dDevice.CreateVertexBuffer(maxv*36,0,
            D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then exit;
        self.RemapVertex;
        end else exit;


        setlength(Ver,0);
        result:=true;
        cs.Enter;
    rdy:=true;
    cs.Leave;
end;




Function T3DItem.LoadFromXJ(filename,TexName,anifile:ansistring):boolean;
Const verflag :array[0..18] of Byte = (3, 15, 1, 3, 3, 3, 3, 3, 3, 5, 13, 13, 13, 13, 13, 13, 3, 11, 11);
      sfmt: array[0..$b] of Byte = (1, 3, 3, 9, 11, 11, 5, 7, 7, 1, 19, 19);
      uvc:array[0..2] of Integer = (1, 255, 1023);
      DXT5_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$00#$01#$00#$00#$00#$01#$00#$00#$00#$00
        +#$01#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$33
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
       DXT1_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$40#$00#$00#$00#$40#$00#$00#$00#$00#$08
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$31
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
Type
    T3DNJVertex = record
        px,py,pz,nx,ny,nz:single;
    end;
    TNJS_OBJECT = Record
        Flag:dword;
        PMODEL:DWORD;
        pos:array[0..2] of single;
        ang:array[0..2] of dword;
        scale:array[0..2] of single;
        PChild,PSibl:integer;
    end;
    TXJM_Entry = record
        off,size:dword;
    end;
    TNJX_CNK_MODEL= record
        flag:dword;
        Entry:array[0..2] of TXJM_Entry;
        Center:array[0..2] of single;
    end;
    Tnjheader = record
        name:dword;
        size:dword;
    end;
    TXVMHeader = record
        Flag:dword;
        Size:dword;
        count:dword;
        unused:array[0..12] of dword;
    end;
    TXVRHeader = record
        Flag:dword;
        Size:dword;
        PixelFormat:dword;
        DXTFormat:dword;
        ID:Dword;
        sx,sy:word;
        DataSize:dword;
        unused:array[0..8] of dword;
    end;
    T3single =record
        s1,s2,s3:single;
    end;
    T3angle =record
        s1,s2,s3:word;
    end;
    TNJM_Header = Record
        Off:dword;
        count:dword;
        flag:word;
        number:word;
    end;
var f,i,p,o,tid,mat,basetex:integer;
    head:Tnjheader;
    b:ansistring;
    data:pansichar;
    chunkptr:array[0..255] of integer;
    Ver:array of T3DNJVertex;
    njj:TNJS_OBJECT;
    njop:array[0..1000] of TNJS_OBJECT;
    vvv: T3DNJVertex;
    curmat:td3dmaterial9;
    maxv:integer;
    ObjMap:array[0..4000] of TNJS_OBJECT;
    ObjMapC:integer;
    ani:TNJM_Header;
    fani:integer;
Function MakeRVB(t:integer):integer;
var c:integer;
begin
    c:=((t div $400) and $1F) *8;
    c:=c+((((t div $20) and $1f) *8)*256);
    c:=c+((((t div $1) and $1f) *8)*65536);
    if t and $7fff = 0 then c:=$10101;
    if t and $8000 <> $8000 then c:=$0;
    result:=c;
end;
Function twiddled_vq(sx:integer;p,p2:pansichar):integer;
var x,y,ptr:integer;
    vqtable:array[0..4*256] of dword;
    c:word;
    TT:array[0..1023] of integer;
    m:pansichar;
    b:Tbitmap;
    ts:Tstream;
begin
    b:=TBitmap.Create;
    b.Width:=sx;
    b.Height:=sx;
    b.TransparentColor:=0;
    b.Transparent:=true;
    ptr:=0;
    for x:=0 to 1023 do
    tt[x] := (x and 1)or((x and 2)*2)or((x and 4)*4)or((x and 8)*8)or((x and 16)*16)or
      ((x and 32)*32)or((x and 64)*64)or((x and 128)*128)or((x and 256)*256)or((x and 512)*512);
    for x:=0 to 1023 do
    begin
       vqtable[x]:=MakeRVB(byte(p[ptr])+(byte(p[ptr+1])*256));
       ptr:=ptr+2;
    end;
    m:=@p[ptr];
    for y:=0 to (sx div 2)-1 do
        for x:=0 to (sx div 2)-1 do begin
            c:=byte(m[tt[y] or (tt[x]*2)]);
            //vq:=@vqtable[c*4];
            b.Canvas.Pixels[x*2,y*2]:=vqtable[(c*4)];
            b.Canvas.Pixels[(x*2)+1,y*2]:=vqtable[(c*4)+2];
            b.Canvas.Pixels[x*2,(y*2)+1]:=vqtable[(c*4)+1];
            b.Canvas.Pixels[(x*2)+1,(y*2)+1]:=vqtable[(c*4)+3];
        end;
    ts:=TMemoryStream.Create;
    b.SaveToStream(ts);
    result:=ts.Size;
    ts.Position:=0;
    ts.ReadBuffer(p2[0],result);
    ts.Free;
end;
Function PSOLoadTexture(s:ansistring):boolean;
var h:TXVMHeader;
    b:TXVRHeader;
    f,f2,i,x,bt:integer;
    p,p2:pansichar;
begin
    f:=fileopen(s,$40); //open xvm file
    fileread(f,h,$40);  //read the header
    bt:=self.TextureCount;
    self.TextureCount:=self.TextureCount+h.count;
    setlength( self.texture ,self.TextureCount); //set texture memory
    //setlength(self.texFlag,h.count); //set texture flag memory

    for i:=0 to h.count-1 do begin
        fileread(f,b,$40); //read the xvr header
        p:=allocmem(b.Size+128); //reserve memory for data+DDS header
        fileread(f,p[128],b.Size-$38); //read the data
        //texFlag[i]:=b.PixelFormat;
        if b.DXTFormat = 3 then begin
            //old format, convert to bmp first
            //self.texFlag[i]:=0;
            p2:=allocmem(3000000);
            x:=twiddled_vq(b.sx,@p[128],p2);
            D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p2,x,self.texture[i+bt]);
            freemem(p2);
        end else begin
        if b.DXTFormat = 6 then move(DXT1_Header[1],p[0],128) //DXT1 header
        else move(DXT5_Header[1],p[0],128); //DXT3 header
        move(b.sx,p[12],2); //set the X size
        move(b.sy,p[16],2); //set the Y size
        move(b.datasize,p[20],4); //set the data size

        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p,b.DataSize+128,self.texture[i+bt]);
        end;
        freemem(p);
    end;
    fileclose(f);
end;
Function MatrixVertex(ve:T3DNJVertex;njo:integer):T3DNJVertex;
var re:T3DNJVertex;
    r,sx,cx,sy,cy,sz,cz,xy,xz,yz,yx,zx,zy:single;
    i:integer;
begin
    {move(ve,re,12);
    re.color:=$FFFFFFFF;  }
    re:=ve;
    //do rotation scale and other if needed
    for i:=njo downto 0 do begin
    if njop[i].Flag and 2 = 0 then begin  //rotation
        sx := sin((njop[i].ang[0] and $FFFF)/ 10430.378350);
        cx := cos((njop[i].ang[0] and $FFFF)/ 10430.378350);
        sy := sin((njop[i].ang[1] and $FFFF)/ 10430.378350);
        cy := cos((njop[i].ang[1] and $FFFF)/ 10430.378350);
        sz := sin((njop[i].ang[2] and $FFFF)/ 10430.378350);
        cz := cos((njop[i].ang[2] and $FFFF)/ 10430.378350);


        xy := cx*(re.py) - sx*(re.pz);
        xz := sx*(re.py) + cx*(re.pz);
        // rotation around y
        yz := cy*xz - sy*(re.px);
        yx := sy*xz + cy*(re.px);
        // rotation around z
        zx := cz*yx - sz*xy;
        zy := sz*yx + cz*xy;

        re.px:=zx;
        re.py:=zy;
        re.pz:=yz;
    end;
    if njop[i].Flag and 1 = 0 then begin  //position
        re.px:=re.px+njop[i].pos[0];
        re.py:=re.py+njop[i].pos[1];
        re.pz:=re.pz+njop[i].pos[2];
    end;
    if njop[i].Flag and 4 = 0 then begin  //scale
        re.px:=re.px*njop[i].scale[0];
        re.py:=re.py*njop[i].scale[1];
        re.pz:=re.pz*njop[i].scale[2];
    end;
    end;
    re.pz:=-re.pz;
    result:=re;
end;

procedure ProcedeVertex(f,p,njo:integer);
var vvv:T3DNJVertex;
    h:array[0..3] of dword;
    i:integer;
begin
    fileread(f,h,16);
    self.Frame[0].Section[self.Frame[0].Sectioncount-1].VertexCount:=h[3];
    if maxv < h[3] then maxv:=h[3];
    self.Frame[0].Section[self.Frame[0].Sectioncount-1].SurfaceType:=D3DPT_TRIANGLESTRIP;
    setlength(self.Frame[0].Section[self.Frame[0].Sectioncount-1].VertexOrg,h[3]);
    //setlength(self.Frame[0].Section[self.Frame[0].Sectioncount-1].VertexList,h[3]);
    setlength(self.Frame[0].Section[self.Frame[0].Sectioncount-1].Vertexflag,h[3]);
    self.Frame[0].Section[self.Frame[0].Sectioncount-1].IndexListCount:=0;
    fileseek(f,p+h[1],0);
    for i:=0 to h[3]-1 do begin
        fillchar(vvv,24,0);
        fileread(f,vvv,12);
        vvv:=matrixvertex(vvv,njo);
        move(vvv.px,self.Frame[0].Section[self.Frame[0].Sectioncount-1].VertexOrg[i].px,12);
        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Vertexflag[i]:=ObjMapC-1;
        if (h[2] = $1c) or (h[2] = $20) or (h[2] = $24) then
            fileread(f,vvv.nx,12);
        if (h[2] = $10) or (h[2] = $18) or (h[2] = $1c) or (h[2] = $24) then
            fileread(f,self.Frame[0].Section[self.Frame[0].Sectioncount-1].VertexOrg[i].color,4);
        if (h[2] = $18) or (h[2] = $20) or (h[2] = $24) then
            fileread(f,self.Frame[0].Section[self.Frame[0].Sectioncount-1].VertexOrg[i].tu,8);
    end;

end;
Function GetSingleAni(off,count,f:integer):T3single;
var x,i,d:integer;
    s1,s2:T3single;
    f1,f2:integer;
begin
    fileseek(fani,off+8,0);
    //look if any match the frame
    f1:=-1;
    f2:=65535;
    for x:=0 to count-1 do begin
        fileread(fani,i,4);
        if (i > f1) and (i <= f) then begin
            fileread(fani,s1,12);
            f1:=i;
        end else if (i < f2) and (i >= f) then begin
            fileread(fani,s2,12);
            f2:=i;
        end else
            fileseek(fani,12,1);
    end;

    if f1 < f then begin
        i:=f2-f1;
        s1.s1:=s1.s1+(((s2.s1-s1.s1)/i)*(f-f1));
        s1.s2:=s1.s2+(((s2.s2-s1.s2)/i)*(f-f1));
        s1.s3:=s1.s3+(((s2.s3-s1.s3)/i)*(f-f1));

    end;
    result:=s1;
end;
Function GetAngleAni(off,count,f:integer):T3Angle;
var x,i,c:integer;
    s1,s2:T3angle;
    f1,f2:integer;
    r:word;
begin
    fileseek(fani,off+8,0);
    f1:=-1;
    f2:=65535;
    i:=0;
    for x:=0 to count-1 do begin
        fileread(fani,i,2);
        {if (i > f1) and (i <= f) then begin
                f1:=i;
                fileread(fani,s1,6);
        end else
        fileseek(fani,6,1);  }
        if (i > f1) and (i <= f) then begin
            fileread(fani,s1,6);
            f1:=i;
        end else if (i < f2) and (i >= f) then begin
            fileread(fani,s2,6);
            f2:=i;
        end else
            fileseek(fani,6,1);
    end;
    if f1 < f then begin
        i:=f2-f1;
        r:=s2.s1-s1.s1;
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(f-f1)) div i;
            s1.s1:=s1.s1+c;
        end else begin
            c:=(r*(f-f1)) div i;
            s1.s1:=s1.s1+c;
        end;

        r:=s2.s2-s1.s2;
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(f-f1)) div i;
            s1.s2:=s1.s2+c;
        end else begin
            c:=(r*(f-f1)) div i;
            s1.s2:=s1.s2+c;
        end;

        r:=s2.s3-s1.s3;
        c:=r-$10000;
        if r > $8000 then begin
            c:=(c*(f-f1)) div i;
            s1.s3:=s1.s3+c;
        end else begin
            c:=(r*(f-f1)) div i;
            s1.s3:=s1.s3+c;
        end;


    end;

    result:=s1;
end;

procedure QuatToAngle(qx,qy,qz,qw:single; var ex,ey,ez:single);
var matrix:array[0..2,0..2] of single;
    cx,sx,x:single;
    cy,sy,y,yr:single;
    cz,sz,z:single;
    sqw,sqz,sqy,sqx:single;
begin

    matrix[0][0] := 1.0 - (2.0 * qy * qy) - (2.0 * qz * qz);
    matrix[1][0] := (2.0 * qx * qy) + (2.0 * qw * qz);
    matrix[2][0] := (2.0 * qx * qz) - (2.0 * qw * qy);
    matrix[2][1] := (2.0 * qy * qz) + (2.0 * qw * qx);
    matrix[2][2] := 1.0 - (2.0 * qx * qx) - (2.0 * qy * qy);
    sy := -matrix[2][0];
    if sy < -1 then sy:=-1;
    if sy > 1 then sy:=1;
    cy := sqrt(1 - (sy * sy));
    if IsNan(cy) then
        cy:=1;    
    yr := arctan2(sy,cy);
    ey := yr;
    if (sy <> 1.0) and ( sy <> -1.0) then begin
        cx := matrix[2][2] / cy;
        sx := matrix[2][1] / cy;
        ex := arctan2(sx,cx) ;
        cz := matrix[0][0] / cy;
        sz := matrix[1][0] / cy;
        ez := arctan2(sz,cz);
    end
    else
    begin
        matrix[1][1] := 1.0 - (2.0 * qx * qx) - (2.0 * qz * qz);
        matrix[1][2] := (2.0 * qy * qz) - (2.0 * qw * qx);
        cx := matrix[1][1];
        sx := -matrix[1][2];
        ex := arctan2(sx,cx) ;
        cz := 1.0;
        sz := 0.0;
        ez := arctan2(sz,cz) ;
    end;
end;

Function GetAngleAni2(off,count,f:integer):T3Angle;
var x,i:integer;
    s1:T3angle;
    f1:integer;
    s2:array[0..3] of single;
    angle,s,cx,cy,cz,cw,rx,ry,rz:single;
begin
    fileseek(fani,off+8,0);
    f1:=-1;
    i:=0;
    for x:=0 to count-1 do begin
        fileread(fani,i,4);
        if (i > f1) and (i <= f) then begin
                f1:=i;
                fileread(fani,s2[0],16);
        end else
        fileseek(fani,16,1);
    end;

    QuatToAngle(s2[1],s2[2],s2[3],s2[0],rx,ry,rz);


   s1.s1:=round(rx*10430.378350);
   s1.s2:=round(ry*10430.378350);
   s1.s3:=round(rz*10430.378350);//57.2957795);


    result:=s1;
end;

procedure ProcedeIndice(f,p,njo,si:integer);
var i,z,o,c:integer;
    d:array[0..3] of dword;
    h:array[0..4] of dword;
    pp:pointer;
begin
    {fileread(f,h,8); //first header
    o:=fileseek(f,0,1); //take pos
    fileseek(f,p+h[0],0);
    for i:=0 to h[1]-1 do begin
        fileread(f,d,16);
        if d[0] = 3 then tid:=d[1]; //texture
        if d[0] = 2 then mat:=d[2] + (d[1]*$10000);
        //5 = difuse and specular
        //other must be transparency
    end;
    fileseek(f,o,0); }
    z:=self.Frame[0].Section[self.Frame[0].Sectioncount-1].IndexListCount;
    self.Frame[0].Section[self.Frame[0].Sectioncount-1].IndexListCount:=si+z;
    setlength(self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs,si+z);
    for i:=0 to si-1 do begin
        fileread(f,h,8);

        o:=fileseek(f,0,1); //take pos
        fileseek(f,p+h[0],0);
        for c:=0 to h[1]-1 do begin
            fileread(f,d,16);
            if d[0] = 3 then tid:=d[1]; //texture
            if d[0] = 2 then mat:=d[2] + (d[1]*$10000);
            if d[0] = 5 then begin
                curmat.Diffuse.r:=(d[1] and 255)/255;
                curmat.Diffuse.g:=((d[1] div $100) and 255)/255;
                curmat.Diffuse.b:=((d[1] div $10000) and 255)/255;
                curmat.Diffuse.a:=((d[1] div $1000000) and 255)/255;
            end;
            //5 = difuse and specular
            //other must be transparency
        end;
        fileseek(f,o,0);

        fileread(f,h,12);
        o:=fileseek(f,0,1);
        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].TextureID:=tid+basetex;
        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].material:= curmat;
        self.frame[0].section[self.Frame[0].Sectioncount-1].Indexs[i+z].AlphaSrc:=mat div $10000;
        self.frame[0].section[self.Frame[0].Sectioncount-1].Indexs[i+z].AlphaDst:=mat and $ffff;
        if mat and $ffff = 1 then
            self.AlphaLevel:=254;
        if mat div $10000 = 1 then
            self.AlphaLevel:=254;

        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].IndexCount:=h[1];
        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].SurfaceCount:=h[1]-2;
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(h[1]*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT
            ,self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].g_pIB,nil)) then exit;
        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].g_pIB.Lock(0,h[1]*2,pp,0);
        fileseek(f,h[0]+p,0);
        fileread(f,pansichar(pp)[0],h[1]*2);
        self.Frame[0].Section[self.Frame[0].Sectioncount-1].Indexs[i+z].g_pIB.unLock;
        fileseek(f,o,0);
    end;
end;

Procedure ProcedeChild(f,p:integer;njo:integer);
var i,o:integer;
    b:ansistring;
    data:pansichar;
    njxm:TNJX_CNK_MODEL;
    dada:integer;
begin                                            
    fileread(f,njop[njo],sizeof(njop[0]));
    move(njop[njo],ObjMap[ObjMapC],sizeof(njop[0])-8);
    dada:=ObjMap[ObjMapC].PChild;
    inc(ObjMapC);

    //njo.pos[0]:=self.frame[0].sectioncount*100;
    if njop[njo].PMODEL <> 0 then begin
        fileseek(f,p+njop[njo].PMODEL,0);
        fileread(f,njxm,sizeof(njxm));
        //make a new section
        inc(self.Frame[0].SectionCount);
        setlength(self.Frame[0].Section,self.Frame[0].SectionCount);
        if njxm.Entry[0].off <> 0 then begin
            //vertex buffer
            fileseek(f,njxm.Entry[0].off+p,0);
            ProcedeVertex(f,p,njo);
        end;

        if njxm.Entry[1].off <> 0 then begin
            //vertex buffer
            fileseek(f,njxm.Entry[1].off+p,0);
            ProcedeIndice(f,p,njo,njxm.Entry[1].size);
        end;
        if njxm.Entry[2].off <> 0 then begin
            //vertex buffer
            fileseek(f,njxm.Entry[2].off+p,0);
            ProcedeIndice(f,p,njo,njxm.Entry[2].size);
        end;


    end;

    if njop[njo].PChild<>0 then begin
        fileseek(f,p+njop[njo].PChild,0);
        ObjMap[ObjMapC].PChild:=ObjMapC-1;
        ProcedeChild(f,p,njo+1);
    end;

    if njop[njo].PSibl<>0 then begin
        fileseek(f,p+njop[njo].PSibl,0);
        ObjMap[ObjMapC].PChild:=dada;
        ProcedeChild(f,p,njo);
    end;
end;
var tv:t3dvertex;
    mbones:array[0..500] of integer;
    lp:integer;
    ma:TD3DMATRIX;
    vec2:TD3DXVECTOR3;
    tnjs:tnjs_object;
    tmpa:array[0..20] of dword;
    tmpp:integer;
    a3:T3angle;
    s3:T3single;
    fra:integer;
begin
    result:=false;
        maxv:=0;
        fillchar(curmat,sizeof(curmat),0);
        curmat.Diffuse.r:=1;
        curmat.Diffuse.g:=1;
        curmat.Diffuse.b:=1;
        curmat.Diffuse.a:=1;
        ObjMap[0].PChild:=-1;
        ObjMapC:=0;
        self.usematerial:=true;
        if fileexists(texname) then
            PSOLoadTexture(texname);

        setlength(Ver,65536);

        fani:=fileopen(anifile,$40);
        if fani > -1 then begin
            fileseek(fani,8,0);
            fileread(fani,ani,12);
            self.FrameCount:=ani.count;
            self.usealpha:=true;
            setlength(self.frame,ani.count);
        end else begin
            self.FrameCount:=1;
            self.usealpha:=true;
            setlength(self.frame,1);
            ani.count:=1;
        end;

        self.frame[0].SectionCount:=0;
        f:=fileopen(FileName,$40);
        if f >0 then begin
        i:=fileread(f,head,8);
        p:=8;
        basetex:=0;
        while i = 8 do begin
            b:='    ';
            move(head.name,b[1],4);
            if head.name = $4d434a4e then begin //njcm
                fillchar(njop[0],sizeof(njop[0]),0);
                ProcedeChild(f,p,0);
            end;
            if head.name = $4c444d4e then begin //njcm
                b:='                ';
                fileread(f,b[1],16);
                fileclose(f);
                if fileexists(changefileext(extractfilepath(FileName)+pansichar(@b[1]),'.xvm')) then begin
                    basetex:=self.TextureCount;
                    PSOLoadTexture(changefileext(extractfilepath(FileName)+pansichar(@b[1]),'.xvm'));
                end else basetex:=0;
                f:=fileopen(extractfilepath(FileName)+pansichar(@b[1]),$40);
                p:=0;
                head.size:=0;
            end;
            inc(p,head.size);
            fileseek(f,p,0);
            i:=fileread(f,head,8);
            inc(p,8);
        end;
        fileclose(f);



         
        if fani > -1 then begin
        //redo all the frame
        //demap eatch vertex
        for i:=0 to self.frame[0].SectionCount-1 do
        for p:=0 to self.frame[0].Section[i].VertexCount-1 do begin
            tv:=self.frame[0].Section[i].Vertexorg[p];
            tv.pz:=-tv.pz;
            //go down the bones and map them
            f:=0;
            mbones[0]:=self.frame[0].Section[i].VertexFlag[p];
            while (objmap[mbones[f]].PChild > -1) do begin
                mbones[f+1]:=objmap[mbones[f]].PChild;
                inc(f);
                //if f > 490 then showmessage('XJ Error');
            end;
            for lp:=f downto 0 do begin
                if objmap[mbones[lp]].Flag and 1 = 0 then begin
                    tv.px:=tv.px-objmap[mbones[lp]].pos[0];
                    tv.py:=tv.py-objmap[mbones[lp]].pos[1];
                    tv.pz:=tv.pz-objmap[mbones[lp]].pos[2];
                end;
                if objmap[mbones[lp]].Flag and 4 = 0 then begin
                    tv.px:=tv.px/objmap[mbones[lp]].scale[0];
                    tv.py:=tv.py/objmap[mbones[lp]].scale[1];
                    tv.pz:=tv.pz/objmap[mbones[lp]].scale[2];
                end;
                if objmap[mbones[lp]].Flag and 2 = 0 then begin  //rotate
                    D3DXMatrixRotationz(ma,($0-(objmap[mbones[lp]].ang[2] and $ffff))/ 10430.378350);
                    D3DXVec3TransformCoord(vec2,D3DXVECTOR3(tv.px,tv.py,tv.pz),ma);
                    D3DXMatrixRotationy(ma,($0-(objmap[mbones[lp]].ang[1] and $ffff))/ 10430.378350);
                    D3DXVec3TransformCoord(vec2,vec2,ma);
                    D3DXMatrixRotationx(ma,($0-(objmap[mbones[lp]].ang[0] and $ffff))/ 10430.378350);
                    D3DXVec3TransformCoord(vec2,vec2,ma);
                    move(vec2,tv,12);
                end;
            end;

            self.frame[0].Section[i].Vertexorg[p]:=tv;
        end;

        //remap all of them by frame
        for fra:=ani.count-1 downto 0 do begin
            self.frame[fra].SectionCount:=self.frame[0].SectionCount;
            setlength(self.frame[fra].Section,self.frame[fra].SectionCount);
            if fani > -1 then begin
            for i:=0 to objmapc-1 do begin
                //add motion

                fileseek(fani,8+ani.Off+((ani.number*8)*i),0);
                fileread(fani,tmpa[0],(ani.number*8));
                tmpp:=0;

                    if ani.flag and 1 = 1 then begin //pos
                        if tmpa[tmpp] <> 0 then begin
                            s3:=GetSingleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].pos[0]:=s3.s1;
                            objmap[i].pos[1]:=s3.s2;
                            objmap[i].pos[2]:=s3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fe;
                        end;
                        inc(tmpp);
                    end;
                    if ani.flag and 2 = 2 then begin //rotation
                        if tmpa[tmpp] <> 0 then begin
                            a3:=GetAngleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].ang[0]:=a3.s1;
                            objmap[i].ang[1]:=a3.s2;
                            objmap[i].ang[2]:=a3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fd;
                        end;
                        inc(tmpp);
                    end;
                    if ani.flag and $2000 = $2000 then begin //rotation
                        if tmpa[tmpp] <> 0 then begin
                            a3:=GetAngleAni2(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].ang[0]:=a3.s1;
                            objmap[i].ang[1]:=a3.s2;
                            objmap[i].ang[2]:=a3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fd;
                        end;
                        inc(tmpp);
                    end;
                    if ani.flag and 4 = 4 then begin //scale
                        if tmpa[tmpp] <> 0 then begin
                            s3:=GetSingleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                            objmap[i].scale[0]:=s3.s1;
                            objmap[i].scale[1]:=s3.s2;
                            objmap[i].scale[2]:=s3.s3;
                            objmap[i].Flag:=objmap[i].Flag and $fb;
                        end;
                        inc(tmpp);
                    end;

                end;
            end;


            for i:=0 to self.frame[0].SectionCount-1 do begin
                self.frame[fra].Section[i].VertexCount:=self.frame[0].Section[i].VertexCount;
                self.frame[fra].Section[i].SurfaceType:=self.frame[0].Section[i].SurfaceType;
                self.frame[fra].Section[i].IndexListCount:=self.frame[0].Section[i].IndexListCount;
                self.frame[fra].Section[i].Indexs:=self.frame[0].Section[i].Indexs;
                self.frame[fra].Section[i].VertexFlag:=self.frame[0].Section[i].VertexFlag;
                //setlength(self.frame[fra].Section[i].VertexList,self.frame[0].Section[i].VertexCount);
                setlength(self.frame[fra].Section[i].VertexOrg,self.frame[0].Section[i].VertexCount);

                //remap them all
                //move(self.frame[0].Section[i].Vertexorg[0],self.frame[fra].Section[i].Vertexorg[0],sizeof(t3dvertex)*self.frame[0].Section[i].VertexCount);

                for p:=0 to self.frame[0].Section[i].VertexCount-1 do begin
                    f:=self.frame[0].Section[i].VertexFlag[p];
                    tv:=self.frame[0].Section[i].Vertexorg[p];
                    while f > -1 do begin
                         tnjs:=objmap[f];

                        if tnjs.Flag and 4 = 0 then begin
                            tv.px:=tv.px*tnjs.scale[0];
                            tv.py:=tv.py*tnjs.scale[1];
                            tv.pz:=tv.pz*tnjs.scale[2];
                        end;
                        if tnjs.Flag and 2 = 0 then begin  //rotate
                            D3DXMatrixRotationX(ma,tnjs.ang[0]/ 10430.378350);
                            D3DXVec3TransformCoord(vec2,D3DXVECTOR3(tv.px,tv.py,tv.pz),ma);
                            D3DXMatrixRotationy(ma,tnjs.ang[1]/ 10430.378350);
                            D3DXVec3TransformCoord(vec2,vec2,ma);
                            D3DXMatrixRotationz(ma,tnjs.ang[2]/ 10430.378350);
                            D3DXVec3TransformCoord(vec2,vec2,ma);
                            move(vec2,tv,12);
                        end;

                        if tnjs.Flag and 1 = 0 then begin
                            tv.px:=tv.px+tnjs.pos[0];
                            tv.py:=tv.py+tnjs.pos[1];
                            tv.pz:=tv.pz+tnjs.pos[2];
                        end;

                        f:=objmap[f].PChild;
                        //f:=-1;
                    end;
                    tv.pz:=-tv.pz;
                    self.frame[fra].Section[i].Vertexorg[p]:=tv;
                end;

            end;
        end;
        end;

        if fani > -1 then fileclose(fani);

        if failed(self.g_pd3dDevice.CreateVertexBuffer(maxv*36,0,
            D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then exit;

        self.RemapVertex;

        end else exit;

        setlength(Ver,0);
        result:=true;
        cs.Enter;
    rdy:=true;
    cs.Leave;
end;

Function T3DItem.SetTexture(ID:integer;Tex:TMemoryStream):boolean;
var x,i:integer;
begin
    if id >= self.TextureCount then begin
        i:=self.TextureCount;
        self.TextureCount:=id+1;
        setlength(self.texture,id+1);
        for x:=i to self.TextureCount-1 do
            self.texture[i]:=nil;
    end;
    result:=true;
    if FAILED(D3DXCreateTextureFromFileInMemory(g_pd3dDevice,tex.Memory,tex.Size,self.texture[id])) then result:=false;

end;

Procedure tpikaengine.TextOut(text:ansistring;pos:trect;color,overall:dword);
begin
    self.g_3DScene.cs.Enter;
    if tp = nil then
        D3DXCreateFont(g_pd3dDevice,16,0,600,1,false,DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,DEFAULT_QUALITY,DEFAULT_PITCH,'System',tp);

    TextData[textcount].Text:=text;
    TextData[textcount].over:=overall;
    TextData[textcount].rect:=pos;
    TextData[textcount].color:=color;
    inc(textcount);
    self.g_3DScene.cs.Leave;

end;

Procedure tpikaengine.GetBitmap(var bm:tbitmap);
var psurface:IDirect3DSurface9;
    buf:ID3DXBuffer;
    tmp:tmemorystream;
    p:pointer;
    DisplayMode:D3DDISPLAYMODE ;
begin

    self.g_pd3dDevice.GetBackBuffer(0,0, D3DBACKBUFFER_TYPE_MONO,psurface);
    self.g_pd3dDevice.GetFrontBufferData(0, pSurface);
    D3DXSaveSurfaceToFileInMemory(buf,D3DXIFF_BMP,psurface,nil,nil);
    tmp:=tmemorystream.Create;
    tmp.SetSize(buf.GetBufferSize);
    p:=buf.GetBufferPointer;
    move(pansichar(p)[0],pansichar(tmp.Memory)[0],tmp.Size);
    bm:=tbitmap.Create;
    tmp.Position:=0;
    bm.LoadFromStream(tmp);
end;


Function T3DItem.LoadFromRel(filename,TexName:ansistring):boolean;
Const verflag :array[0..18] of Byte = (3, 15, 1, 3, 3, 3, 3, 3, 3, 5, 13, 13, 13, 13, 13, 13, 3, 11, 11);
      sfmt: array[0..$b] of Byte = (1, 3, 3, 9, 11, 11, 5, 7, 7, 1, 19, 19);
      uvc:array[0..2] of Integer = (1, 255, 1023);
      DXT5_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$00#$01#$00#$00#$00#$01#$00#$00#$00#$00
        +#$01#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$33
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
       DXT1_Header: ansistring =
        #$44#$44#$53#$20#$7C#$00#$00#$00#$07#$10#$08#$00#$40#$00#$00#$00#$40#$00#$00#$00#$00#$08
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$20#$00#$00#$00#$04#$00#$00#$00#$44#$58#$54#$31
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$10
        +#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00#$00;
Type
    T3DNJVertex = record
        px,py,pz,nx,ny,nz:single;
    end;
    TNJM_Header = Record
        Off:dword;
        count:dword;
        flag:word;
        number:word;
    end;
    TNJS_OBJECT = Record
        Flag:dword;
        PMODEL:DWORD;
        pos:array[0..2] of single;
        ang:array[0..2] of dword;
        scale:array[0..2] of single;
        PChild,PSibl:dword;
    end;
    TNJS_CNK_MODEL= record
        PVertex:dword;
        PPPoly:dword;
        Center:array[0..2] of single;
        radius:single;
    end;
    Tnjheader = record
        name:dword;
        size:dword;
    end;
    TXVMHeader = record
        Flag:dword;
        Size:dword;
        count:dword;
        unused:array[0..12] of dword;
    end;
    TXVRHeader = record
        Flag:dword;
        Size:dword;
        PixelFormat:dword;
        DXTFormat:dword;
        ID:Dword;
        sx,sy:word;
        DataSize:dword;
        unused:array[0..8] of dword;
    end;
    T3single =record
        s1,s2,s3:single;
    end;
    T3angle =record
        s1,s2,s3:word;
    end;
var f,i,p,o,tid,mat,maxv,fra,fani,basep,basetex:integer;
    head:Tnjheader;
    b:ansistring;
    data:pansichar;
    chunkptr:array[0..255] of integer;
    Ver:array of T3DNJVertex;
    njj:TNJS_OBJECT;
    njop:array[0..1000] of TNJS_OBJECT;
    vvv: T3DNJVertex;
    ani:TNJM_Header;
    curmat:TD3DMaterial9;
Function MakeRVB(t:integer):integer;
var c:integer;
begin
    c:=((t div $400) and $1F) *8;
    c:=c+((((t div $20) and $1f) *8)*256);
    c:=c+((((t div $1) and $1f) *8)*65536);
    if t and $7fff = 0 then c:=$10101;
    if t and $8000 <> $8000 then c:=$0;
    result:=c;
end;
Function twiddled_vq(sx:integer;p,p2:pansichar):integer;
var x,y,ptr:integer;
    vqtable:array[0..4*256] of dword;
    c:word;
    TT:array[0..1023] of integer;
    m:pansichar;
    b:Tbitmap;
    ts:Tstream;
begin
    b:=TBitmap.Create;
    b.Width:=sx;
    b.Height:=sx;
    b.TransparentColor:=0;
    b.Transparent:=true;
    ptr:=0;
    for x:=0 to 1023 do
    tt[x] := (x and 1)or((x and 2)*2)or((x and 4)*4)or((x and 8)*8)or((x and 16)*16)or
      ((x and 32)*32)or((x and 64)*64)or((x and 128)*128)or((x and 256)*256)or((x and 512)*512);
    for x:=0 to 1023 do
    begin
       vqtable[x]:=MakeRVB(byte(p[ptr])+(byte(p[ptr+1])*256));
       ptr:=ptr+2;
    end;
    m:=@p[ptr];
    for y:=0 to (sx div 2)-1 do
        for x:=0 to (sx div 2)-1 do begin
            c:=byte(m[tt[y] or (tt[x]*2)]);
            //vq:=@vqtable[c*4];
            b.Canvas.Pixels[x*2,y*2]:=vqtable[(c*4)];
            b.Canvas.Pixels[(x*2)+1,y*2]:=vqtable[(c*4)+2];
            b.Canvas.Pixels[x*2,(y*2)+1]:=vqtable[(c*4)+1];
            b.Canvas.Pixels[(x*2)+1,(y*2)+1]:=vqtable[(c*4)+3];
        end;
    ts:=TMemoryStream.Create;
    b.SaveToStream(ts);
    result:=ts.Size;
    ts.Position:=0;
    ts.ReadBuffer(p2[0],result);
    ts.Free;
end;
Function PSOLoadTexture(s:ansistring):boolean;
var h:TXVMHeader;
    b:TXVRHeader;
    f,f2,i,x:integer;
    p,p2:pansichar;
begin
    f:=fileopen(s,$40); //open xvm file
    fileread(f,h,$40);  //read the header
    self.TextureCount:=self.TextureCount+h.count;
    setlength( self.texture ,self.TextureCount); //set texture memory
    for i:=0 to h.count-1 do begin
        fileread(f,b,$40); //read the xvr header
        p:=allocmem(b.Size+128); //reserve memory for data+DDS header
        fileread(f,p[128],b.Size-$38); //read the data
        //texFlag[i]:=b.PixelFormat;
        if b.DXTFormat = 3 then begin
            //old format, convert to bmp first
            //self.texFlag[i]:=0;
            p2:=allocmem(3000000);
            x:=twiddled_vq(b.sx,@p[128],p2);
            D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p2,x,self.texture[i]);
            freemem(p2);
        end else begin
        if b.DXTFormat = 6 then move(DXT1_Header[1],p[0],128) //DXT1 header
        else move(DXT5_Header[1],p[0],128); //DXT3 header
        move(b.sx,p[12],2); //set the X size
        move(b.sy,p[16],2); //set the Y size
        move(b.datasize,p[20],4); //set the data size

        D3DXCreateTextureFromFileInMemory(g_pd3dDevice,p,b.DataSize+128,self.texture[i]);
        end;
        freemem(p);
    end;
    fileclose(f);
end;
Function MatrixVertex(ve:T3DNJVertex;njo:integer;njm:TNJS_CNK_MODEL):T3DNJVertex;
var re:T3DNJVertex;
    r,sx,cx,sy,cy,sz,cz,xy,xz,yz,yx,zx,zy:single;
    i:integer;
begin
    {move(ve,re,12);
    re.color:=$FFFFFFFF;  }
    re:=ve;
    //do rotation scale and other if needed
    for i:=njo downto 0 do begin
    if njop[i].Flag and 2 = 0 then begin  //rotation
        sx := sin((njop[i].ang[0] and $FFFF)/ 10430.378350);
        cx := cos((njop[i].ang[0] and $FFFF)/ 10430.378350);
        sy := sin((njop[i].ang[1] and $FFFF)/ 10430.378350);
        cy := cos((njop[i].ang[1] and $FFFF)/ 10430.378350);
        sz := sin((njop[i].ang[2] and $FFFF)/ 10430.378350);
        cz := cos((njop[i].ang[2] and $FFFF)/ 10430.378350);


        xy := cx*(re.py) - sx*(re.pz);
        xz := sx*(re.py) + cx*(re.pz);
        // rotation around y
        yz := cy*xz - sy*(re.px);
        yx := sy*xz + cy*(re.px);
        // rotation around z
        zx := cz*yx - sz*xy;
        zy := sz*yx + cz*xy;

        re.px:=zx;
        re.py:=zy;
        re.pz:=yz;
    end;
    if njop[i].Flag and 1 = 0 then begin  //position
        re.px:=re.px+njop[i].pos[0];
        re.py:=re.py+njop[i].pos[1];
        re.pz:=re.pz+njop[i].pos[2];
    end;
    if njop[i].Flag and 4 = 0 then begin  //scale
        re.px:=re.px*njop[i].scale[0];
        re.py:=re.py*njop[i].scale[1];
        re.pz:=re.pz*njop[i].scale[2];
    end;
    end;
    re.pz:=-re.pz;
    result:=re;
end;
Procedure ProcedeChunk(f,p:integer;njo:integer;njm:TNJS_CNK_MODEL);
var o,i,l,v,x,y,z,sn,q,ll,e:integer;
    ChkHead:array[0..3] of byte;
    pp:pointer;
    tmv:T3DNJVertex;
    test:array[0..12] of byte;
begin

    o:=1;
    while o = 1 do begin
        if fileread(f,ChkHead,2) = 0 then begin
            ChkHead[0]:=0;
            o:=0;
        end;
        if ChkHead[0] = 0 then begin
            //null chunk
        end else if (ChkHead[0] > 0) and (ChkHead[0] <= 5) then begin
            //tiny chunk
            if ChkHead[0] = 1 then begin
                mat:=ChkHead[1] and $3f;
            end;
            if ChkHead[0] = 4 then begin
                i:=fileseek(f,0,1);
                chunkptr[ChkHead[1]]:=i;
                o:=0;
            end;
            if ChkHead[0] = 5 then begin
                i:=fileseek(f,0,1);
                fileseek(f,chunkptr[ChkHead[1]],0);
                ProcedeChunk(f,p,njo,njm);
                fileseek(f,i,0);
            end;
        end else if ChkHead[0] = 8 then begin
            //texture id 1 chunk
            fileread(f,ChkHead[2],2);
            tid:=ChkHead[2]+((ChkHead[3]and $3f)*256);
        end else if ChkHead[0] = 9 then begin
            //texture id 2 chunk
            fileread(f,ChkHead[2],2);
        end else if ChkHead[0] and 128 = 128 then begin
            //end chunk
            fileread(f,ChkHead[2],2);
            o:=0;
        end else if (ChkHead[0] >= $10) and (ChkHead[0] <= $17) then begin
            //material 1
            fileread(f,ChkHead[2],2);
            if (ChkHead[0]-$10) and 1 = 1 then begin
                fileread(f,test[0],4);
                curmat.Diffuse.r:=test[0]/255;
                curmat.Diffuse.g:=test[1]/255;
                curmat.Diffuse.b:=test[2]/255;
                curmat.Diffuse.a:=test[3]/255;
            end;
            if (ChkHead[0]-$10) and 2 = 2 then begin
                fileread(f,test[0],4);
                curmat.Ambient.r:=test[0]/255;
                curmat.Ambient.g:=test[1]/255;
                curmat.Ambient.b:=test[2]/255;
                curmat.Ambient.a:=test[3]/255;
            end;
            if (ChkHead[0]-$10) and 4 = 4 then begin
                fileread(f,test[0],4);
                curmat.Specular.r:=test[0]/255;
                curmat.Specular.g:=test[1]/255;
                curmat.Specular.b:=test[2]/255;
                curmat.Specular.a:=test[3]/255;
            end;
             //TD3DMaterial9
            //fileseek(f,(ChkHead[2]+(ChkHead[3]*256))*2,1);
            mat:=ChkHead[1] and $3f;
        end else if (ChkHead[0] >= $18) and (ChkHead[0] <= $1f) then begin
            fileread(f,ChkHead[2],2);
            fileseek(f,(ChkHead[2]+(ChkHead[3]*256))*2,1);
        end else if (ChkHead[0] >= $20) and (ChkHead[0] <= $37) then begin;
            i:=fileseek(f,0,1)-2;
            //size *4 : dword
            //index buffer start
            //number of vertex
            fileread(f,ChkHead[2],2);
            if ChkHead[1] and 3 = 0 then begin
            v:=0;
            l:=0;
            fileread(f,v,2); //first index
            fileread(f,l,2); //count
            for x:=0 to l-1 do begin
                if v >= 625 then
                fillchar(tmv,24,0);
                if verflag[ChkHead[0]-$20] and 1 = 1 then fileread(f,tmv.px,12);
                if verflag[ChkHead[0]-$20] and 2 = 2 then begin
                    fileread(f,e,4);
                end;
                e:=0;
                if verflag[ChkHead[0]-$20] and 4 = 4 then fileread(f,tmv.nx,12);
                if verflag[ChkHead[0]-$20] and 8 = 8 then begin
                    fileread(f,e,4);
                //if e div $10000 = $7F then
                    ver[v+(e and $7fff)]:=MatrixVertex(tmv,njo,njm)
                end
                else begin
                    ver[v]:=MatrixVertex(tmv,njo,njm);
                    inc(v);
                end;
            end;
            end else
                fileseek(f,((ChkHead[2]+(ChkHead[3]*256))*4),1);
        end else if (ChkHead[0] >= $38) and (ChkHead[0] <= $3a) then begin
            fileread(f,ChkHead[2],2);
            fileseek(f,(ChkHead[2]+(ChkHead[3]*256))*2,1);
        end else if (ChkHead[0] >= $40) and (ChkHead[0] <= $4b) then begin;
            i:=fileseek(f,0,1)+2;
            //size *4 : dword
            //index buffer start
            //number of vertex
            fileread(f,ChkHead[2],2);

            v:=0;
            l:=0;
            y:=ChkHead[2]+(ChkHead[3]*256);
            fileread(f,l,2); //count
            v:=l div 16384;
            l:=l and $3FFF;
            //new section
            sn:=self.frame[fra].SectionCount;
            inc(self.frame[fra].SectionCount);
            setlength(self.frame[fra].section,self.frame[fra].SectionCount);
            self.frame[fra].section[sn].VertexCount:=0;
            self.frame[fra].section[sn].IndexListCount:=l;
            self.frame[fra].section[sn].SurfaceType:=D3DPT_TRIANGLESTRIP;
            setlength(self.frame[fra].section[sn].Indexs,l);
            for z:=0 to l-1 do begin
            y:=0;
            fileread(f,y,2);
            ll:=0;
            if y and $8000 = $8000 then begin
                y:=$10000-y;
                ll:=1;
            end;
            self.frame[fra].section[sn].Indexs[z].IndexCount:=y;
            self.frame[fra].section[sn].Indexs[z].SurfaceCount:=y-2;
            self.frame[fra].section[sn].Indexs[z].TextureID:=tid+basetex;
            self.frame[fra].section[sn].Indexs[z].material:=curmat;
            self.frame[fra].section[sn].Indexs[z].AlphaSrc:=mat div 8;
            self.frame[fra].section[sn].Indexs[z].AlphaDst:=mat and 7;
            if mat and 7 = 1 then self.AlphaLevel:=254;
            if Failed( self.g_pd3dDevice.CreateIndexBuffer(y*2,0,D3DFMT_INDEX16,D3DPOOL_DEFAULT
            ,self.frame[fra].section[sn].Indexs[z].g_pIB,nil)) then exit;
            self.frame[fra].section[sn].Indexs[z].g_pIB.lock(0,y*2,pp,0);
            for x:=0 to y-1 do begin
                setlength(self.frame[fra].section[sn].VertexOrg,self.frame[fra].section[sn].VertexCount+1);
                //setlength(self.frame[fra].section[sn].VertexList,self.frame[fra].section[sn].VertexCount+1);
                //make the vertex
                if sfmt[ChkHead[0]-$40] and 1 = 1 then begin
                    //copy the vertex
                    q:=0;
                    fileread(f,q,2);
                    move(ver[q],self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount],12);
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].color:=$FFFFFFFF;
                end;
                if sfmt[ChkHead[0]-$40] and 2 = 2 then begin
                    //generate the UV
                    fileread(f,q,4);
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tu:=(q and $FFFF) / uvc[(ChkHead[0]-$40) mod 3];
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tv:=(q div $10000) / uvc[(ChkHead[0]-$40) mod 3];
                end else begin
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tu:=0;
                    self.frame[fra].section[sn].VertexOrg[self.frame[fra].section[sn].VertexCount].tv:=0;
                end;
                if sfmt[ChkHead[0]-$40] and 4 = 4 then fileseek(f,4,1);
                if sfmt[ChkHead[0]-$40] and 8 = 8 then fileseek(f,6,1);
                if sfmt[ChkHead[0]-$40] and 16 = 16 then fileseek(f,4,1);
                if x >1 then
                    fileseek(f,v*2,1);
                //save the index
                move(self.frame[fra].section[sn].VertexCount,pansichar(pp)[x*2],2);
                inc(self.frame[fra].section[sn].VertexCount);
            end;
            self.frame[fra].section[sn].Indexs[z].g_pIB.unlock;
            if self.frame[fra].section[sn].VertexCount > maxv then
                    maxv:=self.frame[fra].section[sn].VertexCount;
            end;
            fileseek(f,i+((ChkHead[2]+(ChkHead[3]*256))*2),0);
        end else
        begin
            o:=0;
        end;
    end;
end;
Function GetSingleAni(off,count,f:integer):T3single;
var x,i:integer;
    s1:T3single;
    f1:integer;
begin
    fileseek(fani,off+8,0);
    //look if any match the frame
    f1:=-1;
    for x:=0 to count-1 do begin
        fileread(fani,i,4);
        if (i > f1) and (i < f) then begin
            f1:=i;
            fileread(fani,s1,12);
        end else
            fileseek(fani,12,1);
    end;
    result:=s1;
end;
Function GetAngleAni(off,count,f:integer):T3Angle;
var x,i:integer;
    s1:T3angle;
    f1:integer;
begin
    fileseek(fani,off+8,0);
    f1:=-1;
    i:=0;
    for x:=0 to count-1 do begin
        fileread(fani,i,2);
        if (i > f1) and (i <= f) then begin
                f1:=i;
                fileread(fani,s1,6);
        end else
        fileseek(fani,6,1);
    end;
    result:=s1;
end;

Procedure ProcedeChild(f,p:integer;njo:integer);
var i,o:integer;
    b:ansistring;
    data:pansichar;
    njm:TNJS_CNK_MODEL;
    tmpa:array[0..20] of dword;
    tmpp:integer;
    a3:T3angle;
    s3:T3single;
begin
    fileread(f,njop[njo],sizeof(njop[0]));
    if fani <> -1 then begin
        fileseek(fani,8+ani.Off+((ani.number*8)*basep),0);
        fileread(fani,tmpa[0],(ani.number*8));
        tmpp:=0;
        if ani.flag and 1 = 1 then begin //pos
            if tmpa[tmpp] <> 0 then begin
                s3:=GetSingleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                njop[njo].pos[0]:=s3.s1;
                njop[njo].pos[1]:=s3.s2;
                njop[njo].pos[2]:=s3.s3;
            end;
            inc(tmpp);
        end;
        if ani.flag and 2 = 2 then begin //rotation
            if tmpa[tmpp] <> 0 then begin
                a3:=GetAngleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                njop[njo].ang[0]:=a3.s1;//(njop[njo].ang[0]+a3.s1) and $ffff;
                njop[njo].ang[1]:=a3.s2;//(njop[njo].ang[1]+a3.s2) and $ffff;
                njop[njo].ang[2]:=a3.s3;//(njop[njo].ang[2]+a3.s3) and $ffff;
            end;
            inc(tmpp);
        end;
        if ani.flag and 4 = 4 then begin //scale
             if tmpa[tmpp] <> 0 then begin
                s3:=GetSingleAni(tmpa[tmpp],tmpa[tmpp+ani.number],fra);
                njop[njo].scale[0]:=s3.s1;
                njop[njo].scale[1]:=s3.s2;
                njop[njo].scale[2]:=s3.s3;
            end;
            inc(tmpp);
        end;

    end;
    inc(basep);
    //njo.pos[0]:=self.frame[0].sectioncount*100;
    if njop[njo].PMODEL <> 0 then begin
        fileseek(f,p+njop[njo].PMODEL,0);
        fileread(f,njm,sizeof(njm));
        //procede chunk
        if njm.PVertex<>0 then begin
            fileseek(f,p+njm.PVertex,0);
            ProcedeChunk(f,p,njo,njm);
        end;
        if njm.PPPoly<>0 then begin
            fileseek(f,p+njm.PPPoly,0);
            ProcedeChunk(f,p,njo,njm);
        end;
    end;

    if njop[njo].PChild<>0 then begin
        fileseek(f,p+njop[njo].PChild,0);
        ProcedeChild(f,p,njo+1);
    end;

    if njop[njo].PSibl<>0 then begin
        fileseek(f,p+njop[njo].PSibl,0);
        ProcedeChild(f,p,njo);
    end;

end;
begin
    result:=false;
        setlength(Ver,$7FFF);
        usematerial:=true;
        maxv:=0;
        fra:=0;
        fillchar(ver[0],sizeof(ver),0);
        ani.count:=1;
        fani:=-1;
        self.FrameCount:=ani.count;
        self.usealpha:=true;
        setlength(self.frame,ani.count);

        f:=fileopen(FileName,$40);
        if f >0 then begin
        if fileexists(texname) then
            PSOLoadTexture(texname);
        i:=fileread(f,head,8);
        p:=0;
        for fra:=0 to ani.count-1 do begin
                    self.frame[fra].SectionCount:=0;
        end;
        fra:=0;
        fileseek(f,-16,2);
        fileread(f,i,4);
        fileseek(f,i,0);
        fileread(f,i,4);
        fileseek(f,i,0);
        basetex:=0;
        basep:=0;
        fillchar(njop[0],sizeof(njop[0]),0);
        ProcedeChild(f,p,0);

       { while i = 8 do begin
            b:='    ';               
            move(head.name,b[1],4);
            if head.name = $4d434a4e then begin //njcm
                for fra:=0 to ani.count-1 do begin
                    //self.frame[fra].SectionCount:=0;
                    basetex:=0;
                    fileseek(f,p,0);
                    basep:=0;
                    fillchar(njop[0],sizeof(njop[0]),0);
                    ProcedeChild(f,p,0);
                end;
            end;
            if head.name = $4c444d4e then begin //njcm
                b:='                ';
                fileread(f,b[1],16);
                fileclose(f);
                if fileexists(changefileext(extractfilepath(FileName)+pansichar(@b[1]),'.xvm')) then begin
                    basetex:=self.TextureCount;
                    PSOLoadTexture(changefileext(extractfilepath(FileName)+pansichar(@b[1]),'.xvm'));
                end else basetex:=0;
                f:=fileopen(extractfilepath(FileName)+pansichar(@b[1]),$40);
                p:=0;
                head.size:=0;
            end;
            inc(p,head.size);
            fileseek(f,p,0);
            i:=fileread(f,head,8);
            inc(p,8);
        end; }
        fileclose(f);
//        maxv:=$fffff;
        if failed(self.g_pd3dDevice.CreateVertexBuffer(maxv*36,0,
            D3DFVF_XYZ or D3DFVF_NORMAL or D3DFVF_DIFFUSE  or D3DFVF_TEX1 ,D3DPOOL_DEFAULT
                ,self.g_pVB ,0)) then exit;

        self.RemapVertex;

        end else exit;


        setlength(Ver,0);
        result:=true;
end;

Function F2DW(F:single):dword;
begin
    move(f,result,4);
end;

Function PikaVector(x,y,z: single):tPikaVector;
begin
    result.x:=x;
    result.y:=y;
    result.z:=z;
end;

Function GetYposition(vP,vA,vB,vC:TPikaVector;var Y:single):boolean;
var v0,v1,v2,a,b,c,p:TD3DXVECTOR2;
    dot00,dot01,dot02,dot11,dot12,u,v,invDenom:single;
begin
    a.x:=va.x;
    a.y:=va.z;
    b.x:=vb.x;
    b.y:=vb.z;
    c.x:=vc.x;
    c.y:=vc.z;
    p.x:=vp.x;
    p.y:=vp.z;
    // Compute vectors
    v0 := D3DXVec2Subtract(C , A );
    v1 := D3DXVec2Subtract(B , A );
    v2 := D3DXVec2Subtract(P , A );

    // Compute dot products
    dot00 := D3DXVec2Dot(v0, v0);
    dot01 := D3DXVec2Dot(v0, v1);
    dot02 := D3DXVec2Dot(v0, v2);
    dot11 := D3DXVec2Dot(v1, v1);
    dot12 := D3DXVec2Dot(v1, v2);

    // Compute barycentric coordinates
    if (dot00 * dot11 - dot01 * dot01) <> 0 then begin
    invDenom := 1 / (dot00 * dot11 - dot01 * dot01);
    u := ((dot11 * dot02) - (dot01 * dot12)) * invDenom;
    v := ((dot00 * dot12) - (dot01 * dot02)) * invDenom;

    // Check if point is in triangle
    result:=false;
    if (u >= 0) and (v >= 0) and (u + v <= 1) then result:=true;
    //if inside get the Y
    if result then begin
        y:=va.y + ((vc.y-va.y)*u) + ((vb.y-va.y)*v);
    end;
    end else result:=false;

end;




procedure Tpikaengine.SetAdvancedFog(Vertex1,Vertex2:TpikaVector;color:dword;filename:ansistring);
var s:ansistring;
    height,tickness:single;
begin
    tickness:=vertex2.y-vertex1.y;
    height:=vertex1.y;
    if tickness < 0 then begin
        height:=vertex2.y;
        tickness:=-tickness;
    end;
    Fogtick:=tickness;
    fogpos:=height;
    fogcolor:=color;
    fogv1:=vertex1;
    fogv2:=vertex2;
    s:=filename+#0#0;
    D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],fogimg);

end;


Procedure Tpikaengine.setwireframe(x:boolean);
begin
    if x then g_pd3dDevice.SetRenderState(D3DRS_FILLMODE,D3DFILL_WIREFRAME)
    else g_pd3dDevice.SetRenderState(D3DRS_FILLMODE,D3DFILL_SOLID);
end;

Procedure Tpikaengine.DrawFog;
var ver:array[0..3] of T3DVertex;
    p:pointer;
    z:integer;
    i,y,v:single;
    color:dword;
begin
    g_pd3dDevice.SetRenderState(D3DRS_SRCBLEND,3);//source blend factor
    g_pd3dDevice.SetRenderState(D3DRS_DESTBLEND,2);//destination blend factor
    g_pd3dDevice.SetFVF(D3DFVF_XYZ or D3DFVF_DIFFUSE  or D3DFVF_TEX1);
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1,D3DTA_TEXTURE);
    g_pd3dDevice.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1  );
    g_pd3dDevice.SetTexture(0,fogimg);
    g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,ifalse);
    if fogend>0 then
        g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,ifalse);
    g_pd3dDevice.SetStreamSource(0,g_3DScene.TmpSur,0,24);
    ver[0].px:=FogV1.x;
    ver[1].px:=FogV2.x;
    ver[2].px:=FogV1.x;
    ver[3].px:=FogV2.x;
    ver[0].pz:=FogV1.z;
    ver[1].pz:=FogV1.z;
    ver[2].pz:=FogV2.z;
    ver[3].pz:=FogV2.z;
    ver[0].color:=fogcolor;
    ver[1].color:=fogcolor;
    ver[2].color:=fogcolor;
    ver[3].color:=fogcolor;
    i:=gettickcount and $fffff;
    i:=0-(i/$100000);

    for z:=0 to round(fogtick)*4 do begin
        ver[0].py:=fogpos+(z/4)+1;
        ver[1].py:=fogpos+(z/4)+1;
        ver[2].py:=fogpos+(z/4);
        ver[3].py:=fogpos+(z/4);
        y:=(z) /40;
        if z and 1 = 1 then v:=0.5
        else v:=0;
        ver[0].tu:=i+y;
        ver[0].tv:=0-v;
        ver[1].tu:=i+1+y;
        ver[1].tv:=0-v;
        ver[2].tu:=i+y;
        ver[2].tv:=0.5+v;
        ver[3].tu:=i+1+y;
        ver[3].tv:=0.5+v;

        //draw it nao
        g_3DScene.TmpSur.Lock(0,24*4,p,0);
        move(ver[0],pansichar(p)[0],24*4);
        g_3DScene.TmpSur.Unlock;
        //set transparency on texture
        g_pd3dDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP,0,2);
    end;


    g_pd3dDevice.SetRenderState(D3DRS_ZWRITEENABLE,itrue);
    //g_pd3dDevice.SetRenderState(D3DRS_FOGCOLOR,color);
    if fogend>0 then
        g_pd3dDevice.SetRenderState(D3DRS_FOGENABLE,itrue);
end;

Function TpikaEngine.SupportBumpMap:boolean;
var d3dCaps:D3DCAPS9;
begin
    self.g_pd3dDevice.GetDeviceCaps( d3dCaps );
    result:=true;
    // Does this device support the two bump mapping blend operations?
    if ( 0 = d3dCaps.TextureOpCaps and ( D3DTEXOPCAPS_BUMPENVMAP or	D3DTEXOPCAPS_BUMPENVMAPLUMINANCE )) then result:=false;
    // Does this device support up to three blending stages?
    if( d3dCaps.MaxTextureBlendStages < 3 ) then result:=false;

end;

Procedure tpikamap.LoadPSOTam(filename:ansistring);
type
    TTamHeader = record
        size,flag:word; //swaped cause i do mass swaping
    end;
    TTamTexSwapHeader = record
        count,NumOfSec:word;
    end;
    TTamTexEntry = record
        NomOfFrame,ID:word;
    end;
var f,i,o:integer;
    tamh:TTamHeader;
    texh:TTamTexSwapHeader;
Procedure BatchConvert(p:pansichar;si:integer);
var n:integer;
    ch:ansichar;
begin
    for n:=0 to (si div 4)-1 do begin
            ch:=p[(n*4)];
            p[(n*4)]:=p[(n*4)+3];
            p[(n*4)+3]:=ch;
            ch:=p[(n*4)+1];
            p[(n*4)+1]:=p[(n*4)+2];
            p[(n*4)+2]:=ch;
    end;
end;
begin
    f:=fileopen(filename,$40);
    if f > 0 then begin
    fileread(f,tamh,4);
    BatchConvert(@tamh,4);
    while tamh.flag <> $FFFF do begin
        if tamh.flag = 1 then begin//fileseek(f,tamh.size,1)    asd
            fileread(f,tamh,4);
            BatchConvert(@tamh,4);
            setlength(self.textureslide ,tamh.flag);
            textureslidecount:=tamh.flag;
            fileread(f,textureslide[0],tamh.flag*20);
            BatchConvert(@textureslide[0],tamh.flag*20);
            //fillchar(textureslide[0],tamh.flag*20,255);
            if pos('map_cave02',lowercase(filename)) > 0 then textureslide[3].id:=444;
        end else if tamh.flag = 2 then begin
            fileread(f,texh,4);
            BatchConvert(@texh,4);
            inc(self.TextureSwapCount);
            setlength(TextureSwap,TextureSwapCount);
            i:=TextureSwapCount-1;
            TextureSwap[i].count:=texh.count;
            TextureSwap[i].maxframe:=0;
            setlength(TextureSwap[i].Entry,texh.count);
            fileread(f,TextureSwap[i].Entry[0],texh.count*4);
            BatchConvert(@TextureSwap[i].Entry[0],texh.count*4);
            TextureSwap[i].id:=texh.NumOfSec;
            for o:=0 to texh.count-1 do
                inc(TextureSwap[i].Entry[o].frame);// = 0 then TextureSwap[i].Entry[o].frame:=1;
            for o:=0 to texh.count-1 do
                inc(TextureSwap[i].maxframe,TextureSwap[i].Entry[o].frame);

            {if TextureSwap[i].maxframe = 0 then begin
                TextureSwap[i].count:=0;
                TextureSwap[i].id:=$ffff;
            end;    }
        end;
        fileread(f,tamh,4);
        BatchConvert(@tamh,4);
    end;
    fileclose(f);
    end;
end;


Function t3ditem.LoadFromObj(filename:ansistring):boolean;
type
    textcoord = record
        tu,tv:single;
    end;
    vertexentry = record
        x,y,z:single;
    end;
var textbuf:array of textcoord;
    vertexbuf:array of vertexentry;
    tbc,vbc:integer;
    obj:tstringlist;
    x,g,tex,c,k,c1,c2,id:integer;
    s,b:ansistring;
    pp:pointer;
procedure getnextword;
var i,l:integer;
begin
    //b:='';
    for i:=1 to length(s) do
        if s[i] = ' ' then //b:=b+s[i]
             break;
    b:=copy(s,1,i-1);
    delete(s,1,length(b));
    for i:=1 to length(s) do
        if s[i] <> ' ' then break;
    delete(s,1,i-1);
end;
procedure getnextfacedata;
var i,l:integer;
begin
    //b:='';
    for i:=1 to length(s) do
        if (s[i] = ' ') or (s[i] = '/') then //b:=b+s[i]
            break;
    b:=copy(s,1,i-1);
    delete(s,1,length(b));
    if s <> '' then
    if s[1]<>' ' then
    delete(s,1,1);
end;
begin
    obj:=tstringlist.Create;
    obj.LoadFromFile(filename);
    self.FrameCount:=1;
    FormatSettings.DecimalSeparator:='.';
    setlength(self.frame,1);
    self.TextureCount:=0;
    self.Frame[0].SectionCount:=0;
    tex:=-1;
    tbc:=0;
    vbc:=0;
    id:=0;
    g:=-1;
    setlength(vertexbuf,0);
    setlength(textbuf,0);
    for x:=0 to obj.Count-1 do begin
        s:=obj.strings[x];
        getnextword;
        if b = 'v' then begin
            setlength(vertexbuf,vbc+1);
            getnextword;
            vertexbuf[vbc].x:=strtofloat(b);
            getnextword;
            vertexbuf[vbc].y:=strtofloat(b);
            getnextword;
            vertexbuf[vbc].z:=strtofloat(b);
            inc(vbc);
        end else if b = 'vt' then begin
            setlength(textbuf,tbc+1);
            getnextword;
            textbuf[tbc].tu:=strtofloat(b);
            getnextword;
            textbuf[tbc].tv:=strtofloat(b);
            inc(tbc);
        end else if b ='g' then begin
            inc(g);
            id:=0;
            setlength(self.frame[0].section,g+1);
            self.frame[0].SectionCount:=g+1;
            self.frame[0].section[g].VertexCount:=0;
            self.frame[0].section[g].SurfaceType:=D3DPT_TRIANGLELIST;
            self.frame[0].section[g].IndexListCount:=1;
            setlength(self.frame[0].section[g].Indexs,1);
            self.frame[0].section[g].Indexs[0].TextureID:=tex;
            self.frame[0].section[g].Indexs[0].AlphaSrc:=4;
            self.frame[0].section[g].Indexs[0].AlphaDst:=5;
            self.frame[0].section[g].Indexs[0].SurfaceCount:=0;
            if g > 0 then begin
                self.frame[0].section[g-1].Indexs[0].IndexCount:=self.frame[0].section[g-1].Indexs[0].SurfaceCount*3;
                if Failed( self.g_pd3dDevice.CreateIndexBuffer(self.frame[0].section[g-1].Indexs[0].IndexCount*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
                    ,self.frame[0].section[g-1].Indexs[0].g_pIB,nil)) then exit;
                self.frame[0].section[g-1].Indexs[0].g_pIB.lock(0,self.frame[0].section[g-1].Indexs[0].IndexCount*4,pp,0);
                for c:=0 to self.frame[0].section[g-1].Indexs[0].IndexCount-1 do
                    move(c,pansichar(pp)[c*4],4);
                self.frame[0].section[g-1].Indexs[0].g_pIB.unlock;
            end;
        end else if b = 'f' then begin
            if g = -1 then begin
                inc(g);
            id:=0;
            setlength(self.frame[0].section,g+1);
            self.frame[0].SectionCount:=g+1;
            self.frame[0].section[g].VertexCount:=0;
            self.frame[0].section[g].SurfaceType:=D3DPT_TRIANGLELIST;
            self.frame[0].section[g].IndexListCount:=1;
            setlength(self.frame[0].section[g].Indexs,1);
            self.frame[0].section[g].Indexs[0].TextureID:=tex;
            self.frame[0].section[g].Indexs[0].AlphaSrc:=4;
            self.frame[0].section[g].Indexs[0].AlphaDst:=5;
            self.frame[0].section[g].Indexs[0].SurfaceCount:=0;
            end;
            c:=self.frame[0].section[g].VertexCount;
            c1:=c;
            inc(self.frame[0].section[g].Indexs[0].SurfaceCount);
            inc(self.frame[0].section[g].VertexCount);
            setlength(self.frame[0].section[g].Vertexorg,self.frame[0].section[g].VertexCount+2);
            fillchar(self.frame[0].section[g].Vertexorg[c],24*3,0);
            self.frame[0].section[g].Vertexorg[c].color:=$FFFFFFFF;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].px:=vertexbuf[k].x;
            self.frame[0].section[g].Vertexorg[c].py:=vertexbuf[k].y;
            self.frame[0].section[g].Vertexorg[c].pz:=vertexbuf[k].z;
            end;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].tu:=textbuf[k].tu;
            self.frame[0].section[g].Vertexorg[c].tv:=textbuf[k].tv;
            end;
            getnextword;
            //normal data

            c:=self.frame[0].section[g].VertexCount;
            inc(self.frame[0].section[g].VertexCount);
            self.frame[0].section[g].Vertexorg[c].color:=$FFFFFFFF;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].px:=vertexbuf[k].x;
            self.frame[0].section[g].Vertexorg[c].py:=vertexbuf[k].y;
            self.frame[0].section[g].Vertexorg[c].pz:=vertexbuf[k].z;
            end;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].tu:=textbuf[k].tu;
            self.frame[0].section[g].Vertexorg[c].tv:=textbuf[k].tv;
            end;
            getnextword;
            //normal data

            c:=self.frame[0].section[g].VertexCount;
            c2:=c;
            inc(self.frame[0].section[g].VertexCount);
            self.frame[0].section[g].Vertexorg[c].color:=$FFFFFFFF;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].px:=vertexbuf[k].x;
            self.frame[0].section[g].Vertexorg[c].py:=vertexbuf[k].y;
            self.frame[0].section[g].Vertexorg[c].pz:=vertexbuf[k].z;
            end;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].tu:=textbuf[k].tu;
            self.frame[0].section[g].Vertexorg[c].tv:=textbuf[k].tv;
            end;
            getnextword;
            //normal data


            while s <> '' do begin
            c:=self.frame[0].section[g].VertexCount;
            inc(self.frame[0].section[g].Indexs[0].SurfaceCount);
            inc(self.frame[0].section[g].VertexCount);
            setlength(self.frame[0].section[g].Vertexorg,self.frame[0].section[g].VertexCount+2);
            move(self.frame[0].section[g].Vertexorg[c1],self.frame[0].section[g].Vertexorg[c],24);

            c:=self.frame[0].section[g].VertexCount;
            inc(self.frame[0].section[g].VertexCount);
            move(self.frame[0].section[g].Vertexorg[c2],self.frame[0].section[g].Vertexorg[c],24);


            c:=self.frame[0].section[g].VertexCount;
            inc(self.frame[0].section[g].VertexCount);
            fillchar(self.frame[0].section[g].Vertexorg[c],24,0);
            self.frame[0].section[g].Vertexorg[c].color:=$FFFFFFFF;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].px:=vertexbuf[k].x;
            self.frame[0].section[g].Vertexorg[c].py:=vertexbuf[k].y;
            self.frame[0].section[g].Vertexorg[c].pz:=vertexbuf[k].z;
            end;
            getnextfacedata;
            if b <> '' then begin
            k:=strtoint(b)-1;
            self.frame[0].section[g].Vertexorg[c].tu:=textbuf[k].tu;
            self.frame[0].section[g].Vertexorg[c].tv:=textbuf[k].tv;
            end;
            getnextword;
            //normal data
            end;

        end else if b = 'usemap' then begin
            if g = -1 then begin
                inc(g);
            id:=0;
            setlength(self.frame[0].section,g+1);
            self.frame[0].SectionCount:=g+1;
            self.frame[0].section[g].VertexCount:=0;
            self.frame[0].section[g].SurfaceType:=D3DPT_TRIANGLELIST;
            self.frame[0].section[g].IndexListCount:=1;
            setlength(self.frame[0].section[g].Indexs,1);
            self.frame[0].section[g].Indexs[0].TextureID:=tex;
            self.frame[0].section[g].Indexs[0].AlphaSrc:=4;
            self.frame[0].section[g].Indexs[0].AlphaDst:=5;
            self.frame[0].section[g].Indexs[0].SurfaceCount:=0;
            end;
            getnextword;
            tex := TextureName.indexof(b);
            if tex = -1 then
                tex:=self.TextureName.Add(b);
            if self.frame[0].section[g].Indexs[id].SurfaceCount > 0 then begin
                self.frame[0].section[g].Indexs[id].IndexCount:=self.frame[0].section[g].Indexs[id].SurfaceCount*3;
                if Failed( self.g_pd3dDevice.CreateIndexBuffer(self.frame[0].section[g].Indexs[id].IndexCount*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
                    ,self.frame[0].section[g].Indexs[id].g_pIB,nil)) then exit;
                self.frame[0].section[g].Indexs[0].g_pIB.lock(0,self.frame[0].section[g].Indexs[id].IndexCount*4,pp,0);
                for c:=0 to self.frame[0].section[g].Indexs[id].IndexCount-1 do
                    move(c,pansichar(pp)[c*4],4);
                self.frame[0].section[g].Indexs[id].g_pIB.unlock;
                inc(id);
                setlength(self.frame[0].section[g].Indexs,id+1);
                self.frame[0].section[g].Indexs[id].AlphaSrc:=4;
                self.frame[0].section[g].Indexs[id].AlphaDst:=5;
                self.frame[0].section[g].Indexs[id].SurfaceCount:=0;
            end;
            self.frame[0].section[g].Indexs[id].TextureID:=tex;
        end;
    end;
    inc(g);
    if g > 0 then begin
        self.frame[0].section[g-1].Indexs[id].IndexCount:=self.frame[0].section[g-1].Indexs[id].SurfaceCount*3;
        if Failed( self.g_pd3dDevice.CreateIndexBuffer(self.frame[0].section[g-1].Indexs[id].IndexCount*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
            ,self.frame[0].section[g-1].Indexs[id].g_pIB,nil)) then exit;
        self.frame[0].section[g-1].Indexs[0].g_pIB.lock(0,self.frame[0].section[g-1].Indexs[id].IndexCount*4,pp,0);
        for c:=0 to self.frame[0].section[g-1].Indexs[id].IndexCount-1 do
            move(c,pansichar(pp)[c*4],4);
        self.frame[0].section[g-1].Indexs[id].g_pIB.unlock;
    end;
    self.Texturecount:=self.TextureName.Count;
    setlength(self.Texture ,self.Texturecount);
    for x:=0 to self.TextureCount-1 do begin
        s:=extractfilepath(filename)+ self.texturename.strings[x]+#0#0;
        D3DXCreateTextureFromFile(g_pd3dDevice,@s[1],self.texture[x]);
    end;
    self.RemapVertex;
    obj.Free;
    result:=true;
end;

Function t3ditem.SetVertexList(vertex: array of T3DVertex): boolean;
var i,c: integer;
  pp: pointer;
begin
    c:=length(vertex);
    self.FrameCount:=1;
    setlength(self.frame,1);
    self.TextureCount:=0;
    self.Frame[0].SectionCount:=1;
    setlength(self.Frame[0].Section,1);
    self.Frame[0].Section[0].VertexCount := c;
    self.Frame[0].Section[0].VertexOff :=0;
    self.Frame[0].Section[0].SurfaceType := D3DPT_TRIANGLESTRIP;
    setlength(self.Frame[0].Section[0].VertexOrg,c);
    for i:=0 to c-1 do self.Frame[0].Section[0].VertexOrg[i] := vertex[i];
    self.Frame[0].Section[0].IndexListCount := 1;
    setlength(self.Frame[0].Section[0].Indexs,1);
    self.Frame[0].Section[0].Indexs[0].IndexCount := c;
    self.Frame[0].Section[0].Indexs[0].SurfaceCount := c-2;
    self.Frame[0].Section[0].Indexs[0].TextureID := 10;
    self.Frame[0].Section[0].Indexs[0].SType := D3DPT_TRIANGLESTRIP;
    self.frame[0].section[0].Indexs[0].AlphaSrc:=4;
    self.frame[0].section[0].Indexs[0].AlphaDst:=5;

    if Failed( self.g_pd3dDevice.CreateIndexBuffer(self.frame[0].section[0].Indexs[0].IndexCount*4,0,D3DFMT_INDEX32,D3DPOOL_DEFAULT
        ,self.frame[0].section[0].Indexs[0].g_pIB,nil)) then exit;
    self.frame[0].section[0].Indexs[0].g_pIB.lock(0,self.frame[0].section[0].Indexs[0].IndexCount*4,pp,0);
    for c:=0 to self.frame[0].section[0].Indexs[0].IndexCount-1 do
        move(c,pansichar(pp)[c*4],4);
    self.frame[0].section[0].Indexs[0].g_pIB.unlock;

    alwaysDraw := true;
    self.RemapVertex;
    self.rdy := true;
end;




end.
