unit FScriptTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, TextEditor, TextEditor.Types, Registry,
  Vcl.ExtCtrls;

type
    TfmScriptTE = class(TForm)
    TextEdit: TTextEditor;
    PopupMenu1: TPopupMenu;
    MainMenu1: TMainMenu;
    Edit1: TMenuItem;
    Find1: TMenuItem;
    Replace1: TMenuItem;
    GoToLabel1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Undo1: TMenuItem;
    File1: TMenuItem;
    Exit1: TMenuItem;
    View1: TMenuItem;
    Setargumentformat1: TMenuItem;
    Hex1: TMenuItem;
    Decimal1: TMenuItem;
    Deleteselection1: TMenuItem;
    Delete1: TMenuItem;
    Zoom1: TMenuItem;
    Z100: TMenuItem;
    Z125: TMenuItem;
    Z150: TMenuItem;
    Z200: TMenuItem;
    Z300: TMenuItem;
    N1: TMenuItem;
    Timer1: TTimer;
    Openfromfile1: TMenuItem;
    Savetofile1: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TextEditMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Replace1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure GoToLabel1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Deleteselection1Click(Sender: TObject);
    procedure Hex1Click(Sender: TObject);
    procedure Decimal1Click(Sender: TObject);
    procedure Z100Click(Sender: TObject);
    procedure Z125Click(Sender: TObject);
    procedure Z150Click(Sender: TObject);
    procedure Z200Click(Sender: TObject);
    procedure Z300Click(Sender: TObject);
    procedure TextEditChange(Sender: TObject);
    procedure TextEditClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Openfromfile1Click(Sender: TObject);
    procedure Savetofile1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure UpdateTextRefs();

var
  fmScriptTE: TfmScriptTE;
  firstsetup: Boolean = true;
  currentline: integer = 0;

implementation

uses main, unit1, unit14, FScrypt, FFind, FReplace, FGoto, TextEditor.CompletionProposal.Snippets;

{$R *.dfm}

procedure UpdateTextRefs();
var
  i,x,y, labelnum: integer;
  reftype,currentline,labelstr: widestring;
begin
  // Clear and update all label flag data references
  for i := 0 to 1000 do datablock[i]:=-1;
  for i := 0 to fmScriptTE.TextEdit.Lines.Count do
  begin
    currentline := fmScriptTE.TextEdit.Lines[i];
    if currentline <> '' then
    begin
      x := pos(':',fmScriptTE.TextEdit.Lines[i]);
      labelstr := copy(currentline, 0, x-1);
      currentline := copy(currentline, x+1, length(currentline));
      currentline := TrimLeft(currentline);
      reftype := copy(currentline, 0, 4);
      if TryStrToInt(labelstr, labelnum) then
      begin
        if reftype = 'STR:' then
          AddStrRef(labelnum)
        else if reftype = 'HEX:' then
          AddDataRef(labelnum)
        else AddLabel(labelnum);
      end;
    end;
  end;
end;

procedure TfmScriptTE.Copy1Click(Sender: TObject);
begin
  TextEdit.CopyToClipboard;
end;

procedure TfmScriptTE.Cut1Click(Sender: TObject);
begin
  TextEdit.CutToClipboard;
end;

procedure TfmScriptTE.Decimal1Click(Sender: TObject);
begin
  form4.Decimal1Click(nil);
end;

procedure TfmScriptTE.Delete1Click(Sender: TObject);
begin
  TextEdit.DeleteSelection;
end;

procedure TfmScriptTE.Deleteselection1Click(Sender: TObject);
begin
  fmScriptTE.TextEdit.DeleteSelection;
end;

procedure TfmScriptTE.Exit1Click(Sender: TObject);
begin
  fmScriptTE.Close;
end;

procedure TfmScriptTE.Find1Click(Sender: TObject);
begin
  fmFind.ShowModal;
end;

procedure TfmScriptTE.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  fmScriptTE.Hide;
  form4.listbox1.Clear;
  Form1.ViewScrypt1.Enabled := true;

  UpdateTextRefs();

  for i := 0 to TextEdit.LineNumbersCount do
  begin
    if TextEdit.Lines[i] <> '' then
    begin
      form4.ListBox1.items.add(TextEdit.Lines[i]);
    end;
  end;
end;

procedure TfmScriptTE.FormShow(Sender: TObject);
var
  i: integer;
  JSONOpcodeList, JSONRegisterList: String;
  JSONStrings: TStringList;
  LItem1: TTextEditorCompletionProposalSnippetItem;
begin
  if firstsetup then
  begin
    TextEdit.CompletionProposal.Snippets.Items.Clear;

    // JSON list for ASM opcodes
    JSONOpcodeList := '';
    JSONRegisterList := '';
    try
      for i := 0 to Length(asmcode) - 1 do
      begin
        if asmcode[i].name <> '' then
        begin
          JSONOpcodeList := JSONOpcodeList + '"' + asmcode[i].name + '"';
          JSONOpcodeList := JSONOpcodeList + ',' + sLineBreak;
        end;
      end;
      except MessageDlg('Could not generate JSON asm list', mtInformation, [mbOk], 0);
    end;

    SetLength(JSONOpcodeList,length(JSONOpcodeList)-3);

    // JSON list for registers
    try
    for i := 0 to 255  do
    begin
        JSONRegisterList := JSONRegisterList + '"' + 'R' + inttostr(i) + '"';
      if i < 255 then
        JSONRegisterList := JSONRegisterList + ',' + sLineBreak;
      end;
      except MessageDlg('Could not generate JSON register list', mtInformation, [mbOk], 0);
    end;

    JSONStrings := TStringList.Create;

    // Start of JSON code
    JSONStrings.Add (
      '''
    {
        "Highlighter": {
          "MainRules": {
        "Attributes": {
          "Element": "Editor"
        },
        "SubRules": {
          "Range": [
            {
              "Type": "LineComment",
              "Attributes": {
                "Element": "Comment"
              },
              "Properties": {
                "CloseOnEndOfLine": true
              },
              "TokenRange": {
                "Open": "STR:"
              }
            },
            {
              "Type": "String",
              "Attributes": {
                "Element": "String"
              },
              "Properties": {
                "CloseOnEndOfLine": true
              },
              "TokenRange": {
                "Open": "'",
                "Close": "'"
              }
            }
          ],
          "KeyList": [
            {
              "Type": "ReservedWord",
              "Words": [
    '''
    + sLineBreak + JSONOpcodeList +
    '''
                ],
              "Attributes": {
                "Element": "ReservedWord"
              }
            },
            {
              "Type": "Symbol",
              "Words": [
    '''
    +  sLineBreak + JSONRegisterList +
    '''
                          ],
              "Attributes": {
                "Element": "Symbol"
              }
            }
          ],
          "Set": [
            {
              "Type": "Numbers",
              "Symbols": ".0123456789ABCDEF",
              "Attributes": {
                "Element": "Number"
              }
            }
          ]
        }
      }
    },
    "MatchingPair": {
      "Pairs": [
        {
          "OpenToken": "'",
          "CloseToken": "'"
        }
      ]
    },
    "CompletionProposal": {
      "SkipRegion": [
        {
          "OpenToken": "STR:",
          "RegionType": "SingleLine"
        }
      ]
    }
    }
    ''');

    TextEdit.Highlighter.JSON := JSONStrings;
    TextEdit.Highlighter.LoadFromJSON;
    JSONStrings.Free;

    // End of JSON code

    // Add autocomplete for padded number opcode arguments
    LItem1 := TextEdit.CompletionProposal.Snippets.Items.Add;
    LItem1.Keyword := 'new value (00000000)';
    LItem1.Description := '';
    LItem1.Snippet.Add('00000000');
    firstsetup := false;
  end;
    Form4.Hide;
    Form1.ViewScrypt1.Enabled := false;
    TextEdit.Lines.Clear;
    form14.Caption := 'Loading Script';
    form14.Label1.Hide;
    form14.Show;
    form14.ProgressBar1.max := Form4.ListBox1.items.count - 1;
    for i := 0 to Form4.ListBox1.items.count - 1 do
    begin
      form14.ProgressBar1.Position := i;
      form14.Repaint;
      TextEdit.InsertText(Form4.ListBox1.items[i] + sLineBreak);
    end;
    TextEdit.MoveCaretToBeginning;
    form14.Hide;
    form14.Caption := '3D Processing';
    form14.ProgressBar1.Position := 1;
    form14.Label1.Show;
end;

procedure TfmScriptTE.GoToLabel1Click(Sender: TObject);
begin
  fmGoto.ShowModal;
end;

procedure TfmScriptTE.Hex1Click(Sender: TObject);
begin
  form4.Hex1Click(nil);
end;

procedure TfmScriptTE.Openfromfile1Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    Textedit.LoadFromFile(opendialog1.FileName);
    isedited:=true;
  end;
end;

procedure TfmScriptTE.Paste1Click(Sender: TObject);
begin
  TextEdit.PasteFromClipboard;
end;

procedure TfmScriptTE.Replace1Click(Sender: TObject);
begin
  fmReplace.ShowModal;
end;

procedure TfmScriptTE.Savetofile1Click(Sender: TObject);
begin
  if savedialog1.Execute then
  begin
    Textedit.SaveToFile(savedialog1.FileName);
    isedited:=true;
  end;
end;

procedure TfmScriptTE.TextEditChange(Sender: TObject);
begin
  isEdited := true;
end;

procedure TfmScriptTE.TextEditClick(Sender: TObject);
  var
  opcode, argstring: string;
  spacepos, i, v: integer;
begin
  argstring := '';
  if sender <> Timer1 then
    currentline := TextEdit.TextPosition.Line;
  opcode := copy(TextEdit.Lines.TextLines[currentline], 9, length(TextEdit.Lines.TextLines[currentline]));
  spacepos := pos(' ', opcode);
  opcode := copy(opcode, 0, spacepos - 1);
  for i := 0 to Length(asmcode) - 1 do
  begin
    if (opcode = asmcode[i].name) and (asmcode[i].name <> '') then
    begin
      // Create argument list
      v := 0;
      while asmcode[i].arg[v] <> T_NONE do
      begin
        if asmcode[i].arg[v] = T_REG then
          argstring := argstring + 'T_REG'
        else if asmcode[i].arg[v] = T_RREG then
          argstring := argstring + 'T_RREG'
        else if asmcode[i].arg[v] = T_BREG then
          argstring := argstring + 'T_BREG'
        else if asmcode[i].arg[v] = T_DREG then
          argstring := argstring + 'T_DREG'
        else if asmcode[i].arg[v] = T_SWITCH2B then
          argstring := argstring + 'T_SWITCH2B'
        else if asmcode[i].arg[v] = T_SWITCH then
          argstring := argstring + 'T_SWITCH'
        else if asmcode[i].arg[v] = T_SWITCHZ then
          argstring := argstring + 'T_SWITCHZ'
        else if asmcode[i].arg[v] = T_BYTE then
          argstring := argstring + 'T_BYTE'
        else if asmcode[i].arg[v] = T_WORD then
          argstring := argstring + 'T_WORD'
        else if asmcode[i].arg[v] = T_DWORD then
          argstring := argstring + 'T_DWORD'
        else if asmcode[i].arg[v] = T_DATA then
          argstring := argstring + 'T_DATA'
        else if asmcode[i].arg[v] = T_STRDATA then
          argstring := argstring + 'T_STRDATA'
        else if asmcode[i].arg[v] = T_PFLAG then
          argstring := argstring + 'T_PFLAG'
        else if asmcode[i].arg[v] = T_PFLAG then
          argstring := argstring + 'T_PFLAG'
        else if asmcode[i].arg[v] = T_FUNC then
          argstring := argstring + 'T_FUNC'
        else if asmcode[i].arg[v] = T_FUNC2 then
          argstring := argstring + 'T_FUNC2'
        else if asmcode[i].arg[v] = T_FLOAT then
          argstring := argstring + 'T_FLOAT'
        else if asmcode[i].arg[v] = T_STR then
          argstring := argstring + 'T_STR';
        argstring := argstring + ', ';
        inc(v);
      end;

      if argstring = '' then
        argstring := argstring + 'T_NONE';
    end;
  end;
  if (length(argstring) > 0) and (argstring <> 'T_NONE') then
    SetLength(argstring, length(argstring)-2);
  if argstring <> '' then
    argstring := ' (' + opcode + ' ' + argstring + ')';
  TextEdit.Hint := 'Line: ' + inttostr(TextEdit.TextPosition.Line) + argstring;
end;

procedure TfmScriptTE.TextEditMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PopupMenu1.Popup(mouse.CursorPos.X, mouse.CursorPos.Y);
end;

procedure TfmScriptTE.Timer1Timer(Sender: TObject);
var
  lineposition: TTextEditorTextPosition;
begin
  lineposition.Line := 0;
  if TextEdit.GetTextPositionOfMouse(lineposition) then
    currentline := lineposition.Line;
  TextEditClick(Timer1);
end;

procedure TfmScriptTE.Undo1Click(Sender: TObject);
begin
  TextEdit.DoUndo;
end;

procedure TfmScriptTE.Z100Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  TextEdit.Zoom(100);
  Z100.Checked := true;
  Z125.Checked := false;
  Z150.Checked := false;
  Z200.Checked := false;
  Z300.Checked := false;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TextEditZoom', 0);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.Z125Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  TextEdit.Zoom(125);
  Z100.Checked := false;
  Z125.Checked := true;
  Z150.Checked := false;
  Z200.Checked := false;
  Z300.Checked := false;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TextEditZoom', 1);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.Z150Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  TextEdit.Zoom(150);
  Z100.Checked := false;
  Z125.Checked := false;
  Z150.Checked := true;
  Z200.Checked := false;
  Z300.Checked := false;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TextEditZoom', 2);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.Z200Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  TextEdit.Zoom(200);
  Z100.Checked := false;
  Z125.Checked := false;
  Z150.Checked := false;
  Z200.Checked := true;
  Z300.Checked := false;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TextEditZoom', 3);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.Z300Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  TextEdit.Zoom(300);
  Z100.Checked := false;
  Z125.Checked := false;
  Z150.Checked := false;
  Z200.Checked := false;
  Z300.Checked := true;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TextEditZoom', 4);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

end.
