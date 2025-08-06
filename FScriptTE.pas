unit FScriptTE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Generics.Collections, System.Generics.Defaults, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
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
    N2: TMenuItem;
    Argumentformat1: TMenuItem;
    Hex1: TMenuItem;
    Decimal1: TMenuItem;
    N3: TMenuItem;
    Newlabel1: TMenuItem;
    Newregister1: TMenuItem;
    Hotkeys1: TMenuItem;
    Addlabel1: TMenuItem;
    Addregister1: TMenuItem;
    Format1: TMenuItem;
    Changefont1: TMenuItem;
    FontDialog1: TFontDialog;
    Changetextcolor1: TMenuItem;
    Opcodes1: TMenuItem;
    Registers1: TMenuItem;
    Values1: TMenuItem;
    ColorDialog1: TColorDialog;
    HideNOPs1: TMenuItem;
    Setformattingdefaults1: TMenuItem;
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
    procedure Newlabel1Click(Sender: TObject);
    procedure Newregister1Click(Sender: TObject);
    procedure Addlabel1Click(Sender: TObject);
    procedure Addregister1Click(Sender: TObject);
    procedure Changefont1Click(Sender: TObject);
    procedure TextEditCaretChanged(const ASender: TObject; const X2, Y2,
      AOffset: Integer);
    procedure Opcodes1Click(Sender: TObject);
    procedure Registers1Click(Sender: TObject);
    procedure Values1Click(Sender: TObject);
    procedure HideNOPs1Click(Sender: TObject);
    procedure Setformattingdefaults1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure UpdateTextRefs();
procedure SetTextZoom(zoomvalue: integer);
procedure SetTextColor(colortype: string);

var
  fmScriptTE: TfmScriptTE;
  textEdited: Boolean = false;
  currentline: integer = 0;
  editline: integer = 0;
  nextline: integer = 0;

implementation

uses main, TCom, unit1, unit14, FScrypt, FFind, FReplace, FGoto, TextEditor.CompletionProposal.Snippets,
  NPCBuild, EnemyStat, FEnemyResist, FEnemyMov, FEnemyAttack, FVector;

{$R *.dfm}

procedure UpdateTextRefs();
var
  i,j,x,labelnum: integer;
  reftype,currentline,labelstr: widestring;
begin
  form14.Caption := 'Clearing References';
  form14.Label1.Hide;
  form14.Show;
  form14.ProgressBar1.max := fmScriptTE.TextEdit.Lines.Count;

  // Clear data references
  for i := 0 to 1000 do datablock[i]:=-1;
  for i := 0 to fmScriptTE.TextEdit.Lines.Count do
  begin
    try
      form14.ProgressBar1.Position := i;
      form14.Repaint;
      RemoveRef(AnsiString(fmScriptTE.TextEdit.Lines[i]));
    except // New or imported file with no references to delete, catch exception
    end;
  end;

   // Clear and re-initialize the treeview
  form4.TreeView1.Items.Clear;
  TrFnc := form4.TreeView1.Items.Add(form4.TreeView1.Items.GetFirstNode, 'Function');
  TrData := form4.TreeView1.Items.Add(form4.TreeView1.Items.GetFirstNode, 'Data/Str');
  TrReg := form4.TreeView1.Items.Add(form4.TreeView1.Items.GetFirstNode, 'Register');
  Tropc := form4.TreeView1.Items.Add(form4.TreeView1.Items.GetFirstNode, 'Opcode');
  TrData.Text := getlanguagestring(133);
  TrFnc.Text := getlanguagestring(132);
  TrReg.Text := getlanguagestring(134);
  Tropc.Text := getlanguagestring(135);
  TrFnc.ImageIndex := 2;
  TrFnc.SelectedIndex := 2;
  TrData.ImageIndex := 2;
  TrData.SelectedIndex := 2;
  TrReg.ImageIndex := 2;
  TrReg.SelectedIndex := 2;
  Tropc.ImageIndex := 2;
  Tropc.SelectedIndex := 2;
  TsData.Clear;
  TsFnc.Clear;
  TsReg.Clear;
  Tsopc.Clear;

  form14.Caption := 'Adding New References';
  for i := 0 to fmScriptTE.TextEdit.Lines.Count do
  begin
    form14.ProgressBar1.Position := i;
    form14.Repaint;
    currentline := fmScriptTE.TextEdit.Lines[i];
    if currentline <> '' then
    begin
      // Update all label flag data references
      x := pos(':',fmScriptTE.TextEdit.Lines[i]);
      if (x <= 6) and (x <> 0) then
      begin
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

      // Update registers
      for j := 0 to 255 do
      begin
        if fmScriptTE.TextEdit.Lines[i].Contains('R' + inttostr(j)) then
          AddRegister(j);
      end;

      // Update functions used
      for j := 0 to asmcount - 1 do
      begin
        if fmScriptTE.TextEdit.Lines[i].Contains(asmcode[j].name) then
          AddFunctionUsed(AnsiString(asmcode[j].name));
      end;
    end;
  end;
  form14.Hide;
  form14.Caption := '3D Processing';
  form14.ProgressBar1.Position := 1;
  form14.Label1.Show;
end;

procedure SetTextZoom(zoomvalue: integer);
var
  Reg: TRegistry;
begin
  with fmScriptTE do
  begin
    TextEdit.Zoom(zoomvalue);
    Z100.Checked := false;
    Z125.Checked := false;
    Z150.Checked := false;
    Z200.Checked := false;
    Z300.Checked := false;

    if zoomvalue = 100 then
      Z100.Checked := true
    else if zoomvalue = 125 then
      Z125.Checked := true
    else if zoomvalue = 150 then
      Z150.Checked := true
    else if zoomvalue = 200 then
      Z200.Checked := true
    else if zoomvalue = 300 then
      Z300.Checked := true
    else
      Z125.Checked := true;
  end;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TextEditZoom', zoomvalue);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure SetTextColor(colortype: string);
var
  Reg: TRegistry;
  lastcaret: integer;
begin
    with fmScriptTE do
    begin
      // Save text position
      lastcaret := TextEdit.CaretIndex;
      // Set default color
      if colortype = 'TEValueColor' then
        colordialog1.Color := clBlue
      else colordialog1.Color := clNavy;
      if colordialog1.Execute then begin
          if colortype = 'TEOpcodeColor' then
            TextEdit.Colors.EditorReservedWordForeground:=colordialog1.Color
          else if colortype = 'TERegisterColor' then
            TextEdit.Colors.EditorSymbolForeground:=colordialog1.Color
          else if colortype = 'TEValueColor' then
          begin
            TextEdit.Colors.EditorNumberForeground:=colordialog1.Color;
            TextEdit.Colors.EditorHexNumberForeground:=colordialog1.Color;
          end;

          Reg := TRegistry.Create;
          try
              Reg.RootKey := HKEY_CURRENT_USER;
              if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
          begin
              Reg.WriteInteger(colortype,colordialog1.Color);
              Reg.CloseKey;
              end;
          finally
              Reg.Free;
          end;
      end;
      Close;
      Show;
      // Reset to last caret position
      TextEdit.CaretIndex := lastcaret;
    end;
end;

procedure TfmScriptTE.Addlabel1Click(Sender: TObject);
begin
  Newlabel1Click(nil);
end;

procedure TfmScriptTE.Addregister1Click(Sender: TObject);
begin
  Newregister1Click(nil);
end;

procedure TfmScriptTE.Changefont1Click(Sender: TObject);
var
  Reg: TRegistry;
  lastcaret: integer;
begin
    // Save text position
    lastcaret := TextEdit.CaretIndex;
    if fontdialog1.Execute then begin
        TextEdit.Fonts.Text:=fontdialog1.Font;
        Textedit.Fonts.Text.Pitch:=fpFixed;
        Reg := TRegistry.Create;
        try
            Reg.RootKey := HKEY_CURRENT_USER;
            if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
        begin
            Reg.WriteInteger('TEFontSize',fontdialog1.Font.Size);
            Reg.WriteString('TEFontName',fontdialog1.Font.Name);
            Reg.WriteInteger('TEFontStyle',byte(fontdialog1.Font.Style));
            Reg.CloseKey;
            end;
        finally
            Reg.Free;
        end;
    end;

    // Set zoom down to 100 if a non-default font was chosen, in case it's a bigger font
    if fontdialog1.Font.Name <> 'Courier New' then
      SetTextZoom(100);

    fmScriptTE.Close;
    fmScriptTE.Show;
    // Reset to last caret position
    TextEdit.CaretIndex := lastcaret;
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
  if textEdited then
  begin
    fmScriptTE.Hide;
    UpdateTextRefs();
    form4.listbox1.Clear;
    form14.Caption := 'Saving Script';
    form14.Label1.Hide;
    form14.Show;
    form14.ProgressBar1.max := TextEdit.Lines.Count;
    for i := 0 to TextEdit.Lines.Count do
    begin
      if TextEdit.Lines[i] <> '' then
      begin
        form14.ProgressBar1.Position := i;
        form14.Repaint;
        form4.ListBox1.items.add(TextEdit.Lines[i]);
      end;
    end;
    form14.Hide;
    form14.Caption := '3D Processing';
    form14.ProgressBar1.Position := 1;
    form14.Label1.Show;
  end;
end;

procedure TfmScriptTE.FormShow(Sender: TObject);
var
  i: integer;
  JSONOpcodeList, JSONRegisterList: String;
  JSONStrings: TStringList;
  LItem1: TTextEditorCompletionProposalSnippetItem;
begin
    textEdited := false;
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
      JSONOpcodeList := JSONOpcodeList + '"' + 'Unknow_Opcode' + '"';
      except MessageDlg('Could not generate JSON asm list', mtInformation, [mbOk], 0);
    end;

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
              "Symbols": "0123456789ABCDEF",
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

    Form4.Hide;
    TextEdit.Lines.Clear;
    form14.Caption := 'Loading Script';
    form14.Label1.Hide;
    form14.Show;
    form14.ProgressBar1.max := Form4.ListBox1.items.count - 1;
    for i := 0 to Form4.ListBox1.items.count - 1 do
    begin
      form14.ProgressBar1.Position := i;
      form14.Repaint;
      TextEdit.Lines.Add(Form4.ListBox1.items[i]);
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

procedure TfmScriptTE.HideNOPs1Click(Sender: TObject);
begin
  form4.HideNOPs1Click(nil);
end;

procedure TfmScriptTE.Newlabel1Click(Sender: TObject);
var
  i, j, lastline, lastcaret, labellength: integer;
  found: Boolean;
  whitespace: string;
begin
  lastline := TextEdit.TextPosition.Line;
  lastcaret := TextEdit.CaretIndex;
  whitespace := '';
  // Add the next unused label
  with TextEdit do
  begin
    for i := 0 to 65535 do
    begin
      found := false;
      for j := 0 to Lines.Count do
      begin
        if Lines[j].StartsWith(inttostr(i) + ':') then
        found := true;
      end;
      if not found then
      begin
        labellength := 6 - length(inttostr(i));
        for j := 0 to labellength do
          whitespace := whitespace + ' ';
        InsertLine(lastline + 2, inttostr(i) + ':' + whitespace);
        GoToLine(lastline + 1);
        // Move caret to end of the new line
        CaretIndex := lastcaret + 1 + length(Lines[lastline + 1]);
        break;
      end;
    end;
  end;
end;

procedure TfmScriptTE.Newregister1Click(Sender: TObject);
var
  i, j: integer;
  found: Boolean;
begin
  // Add the next unused register
  with TextEdit do
  begin
    for i := 0 to 255 do
    begin
      found := false;
      for j := 0 to Lines.Count do
      begin
        if Lines[j].Contains('R' + inttostr(i)) then
          found := true;
      end;
      if not found
      // Exclude all reserved registers
      and (i <> 74) and (i <> 75)
      and (i <> 76) and (i <> 77)
      and (i <> 78) and (i <> 79)
      and (i <> 253) and (i <> 255)
      then
      begin
        InsertText('R' + inttostr(i));
        break;
      end;
    end;
  end;
end;

procedure TfmScriptTE.Openfromfile1Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    Textedit.LoadFromFile(opendialog1.FileName);
    textedited:=true;
    isedited:=true;
  end;
end;

procedure TfmScriptTE.Paste1Click(Sender: TObject);
begin
  TextEdit.PasteFromClipboard;
end;

procedure TfmScriptTE.Opcodes1Click(Sender: TObject);
begin
  SetTextColor('TEOpcodeColor');
end;

procedure TfmScriptTE.Registers1Click(Sender: TObject);
begin
  SetTextColor('TERegisterColor');
end;

procedure TfmScriptTE.Values1Click(Sender: TObject);
begin
  SetTextColor('TEValueColor');
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

procedure TfmScriptTE.Setformattingdefaults1Click(Sender: TObject);
var
  choice, lastcaret: integer;
  Reg: TRegistry;
begin
    choice := MessageDlg('Font and color options will be reset back to their defaults, continue?',
      mtConfirmation, [mbYes, mbNo], 0);

    if choice = mrYes then
    begin
      // Save text position
      lastcaret := TextEdit.CaretIndex;

      // Reset font
      TextEdit.Fonts.Text.Size := 9;
      TextEdit.Fonts.Text.Name := 'Courier New';
      TextEdit.Fonts.Text.Style := [];

      // Reset text colors
      TextEdit.Colors.EditorReservedWordForeground:=clNavy;
      TextEdit.Colors.EditorSymbolForeground:=clNavy;
      TextEdit.Colors.EditorNumberForeground:=clBlue;
      TextEdit.Colors.EditorHexNumberForeground:=clBlue;

      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteInteger('TEFontSize',9);
          Reg.WriteString('TEFontName','Courier New');
          Reg.WriteInteger('TEFontStyle',0);
          Reg.WriteInteger('TEOpcodeColor',clNavy);
          Reg.WriteInteger('TERegisterColor',clNavy);
          Reg.WriteInteger('TEValueColor',clBlue);
          Reg.CloseKey;
      end;
      finally
        Reg.Free;
      end;

      // Reset text zoom
      SetTextZoom(125);
      fmScriptTE.Close;
      fmScriptTE.Show;

      // Reset to last caret position
      TextEdit.CaretIndex := lastcaret;
    end;
end;

procedure TfmScriptTE.TextEditCaretChanged(const ASender: TObject; const X2, Y2,
  AOffset: Integer);
var
  i,j,k,x,y,x3,y3,g,labelnum,opcodepos,argpos: integer;
  reftype,trimline,currentarg,labelstr,opcodestr,whitespace,s: widestring;
  argstrings: TStringList;
  opcodelist: array [0 .. 1000] of TAsmFnc;
  stringarg,instring: Boolean;
begin
  nextline := TextEdit.TextPosition.Line;
  if nextline <> editline then
  begin
    argstrings := TStringList.Create;

    for i := 0 to Length(asmcode) - 1 do
      opcodelist[i] := asmcode[i];

    // Sort opcode list by name string length (highest to lowest)
    TArray.Sort<TAsmFnc>(opcodelist,TDelegatedComparer<TAsmFnc>.Construct(
    function(const Right, Left: TAsmFnc): Integer
    begin
      Result := Length(Left.name) - Length(Right.name);
    end
    ));

    i := editline;
    trimline := Trim(fmScriptTE.TextEdit.Lines[i]);
    if trimline <> '' then
    begin
      // Get label if it exists
      labelstr := '';
      x := pos(':',trimline);
      if (x <= 6) and (x <> 0) then
      begin
        labelstr := copy(trimline, 0, x-1);
        trimline := copy(trimline, x+1, length(trimline));
        reftype := copy(trimline, 0, 4);
        if not TryStrToInt(labelstr, labelnum) then
          labelstr := '';
      end;

      // Get opcode if it exists
      opcodestr := '';
      for j := 0 to Length(opcodelist) - 1 do
      begin
        if (opcodelist[j].name <> '') and (fmScriptTE.TextEdit.Lines[i].Contains(opcodelist[j].name)) then
        begin
          opcodestr := opcodelist[j].name;
          opcodepos := pos(opcodelist[j].name, fmScriptTE.TextEdit.Lines[i]);
          break;
        end
        else if fmScriptTE.TextEdit.Lines[i].Contains('Unknow_Opcode') then
        begin
          opcodestr := 'Unknow_Opcode';
          opcodepos := pos('Unknow_Opcode', fmScriptTE.TextEdit.Lines[i]);
          break;
        end;
      end;

      // Clean up empty or invalid opcode lines
      if opcodestr = '' then
      begin
        fmScriptTE.TextEdit.Lines[i] := '';
        TextEdit.DeleteEmptyLines;
        exit;
      end;

      // Get arguments
      stringarg := false;
      if opcodestr <> '' then
      begin
        argstrings.Add('');
        argstrings.Strings[0] := copy(fmScriptTE.TextEdit.Lines[i], opcodepos +
        length(opcodestr),length(fmScriptTE.TextEdit.Lines[i]));

        if (opcodestr <> 'STR:') and (opcodestr <> 'HEX:') and (opcodestr <> 'Unknow_Opcode')
        and not stringarg then
        begin
          instring := false;
          currentarg := '';
          // Ignore any arguments in strings
          for k := 1 to Length(argstrings.Strings[0]) do
          begin
            case argstrings[0][k] of
              '''':
              instring := not instring;
              ',':
            if not instring then
            begin
              argstrings.Add(Trim(currentarg));
              currentarg := '';
            end
            else
            begin
              currentarg := currentarg + argstrings[0][k];
            end;
            else
              currentarg := currentarg + argstrings[0][k];
            end;
          end;
          argstrings.add(Trim(currentarg));
          argstrings.Delete(0);
        end;
      end;

      // Check and adjust argument count
      k := 0;
      while opcodelist[j].arg[k] <> T_NONE do
        inc(k);
      for x := argstrings.Count - 1 downto k do
        argstrings.Delete(x);

      // Re-add quotes to string arguments
      for x := 0 to argstrings.count - 1 do
      begin
        if opcodelist[j].arg[x] = T_STR then
          argstrings.Strings[x] := '''' + argstrings.Strings[x] + '''';
      end;

      with fmScriptTE.TextEdit do
        begin
        // Reconstruct the line
        Lines[i] := '';
        whitespace := '        ';

        // Label/whitespace
        if labelstr <> '' then
        begin
          Lines[i] := labelstr + ':';
          for j := 1 to length(labelstr) + 1 do
          SetLength(whitespace,length(whitespace)-1);
        end;
        Lines[i] := Lines[i] + whitespace;

        // Opcode
        Lines[i] := Lines[i] + opcodestr + ' ';

        // Arguments
        for j := 0 to argstrings.count - 1 do
        begin
          Lines[i] := Lines[i] + argstrings.Strings[j];
          if j <> argstrings.count - 1 then
            Lines[i] := Lines[i] + ', ';
        end;

        // Update maps
        form4.ListBox1.items.Add(Lines[i]);
        if (lowercase(opcodestr) = lowercase(GetOpcodeName($c4))) or
        (lowercase(opcodestr) = lowercase(GetOpcodeName($f80d))) or
        (lowercase(opcodestr) = lowercase(GetOpcodeName($9))) then ScanForMap;
        if (lowercase(opcodestr)) = lowercase(GetOpcodeName($f951)) then begin
         //bb map
         s:=Lines[i];
         delete(s,1,9+length(GetOpcodeName($f951)));
         x3:=hextoint(copy(s,1,2));
         g:=hextoint(copy(s,5,4));
         y3:=hextoint(copy(s,11,2));
         if x < 30 then begin
         mapxvmfile[x3]:=path+'map\xvm\'+mapxvmname[mapid[g]+y3];
         mapfile[x3]:=path+'map\'+mapfilename[mapid[g]+y3];
         floor[x3].floorid:=MapArea[mapid[g]+y3];
         Form1.CheckListBox1.Items.Strings[x3]:=mapname[mapid[g]+y3];
         end;
        end;
      end;
    end;
  end;
   // Free the argument list
   argstrings.Free;
end;

procedure TfmScriptTE.TextEditChange(Sender: TObject);
begin
  isEdited := true;
  textEdited := true;
  editline := TextEdit.TextPosition.Line;
end;

procedure TfmScriptTE.TextEditClick(Sender: TObject);
var
  opcode, argstring: string;
  i, v: integer;
  opcodelist: array [0 .. 1000] of TAsmFnc;
begin
  for i := 0 to Length(asmcode) - 1 do
    opcodelist[i] := asmcode[i];

  // Sort opcode list by name string length (highest to lowest)
  TArray.Sort<TAsmFnc>(opcodelist,TDelegatedComparer<TAsmFnc>.Construct(
  function(const Right, Left: TAsmFnc): Integer
  begin
    Result := Length(Left.name) - Length(Right.name);
  end
  ));

  argstring := '';
  opcode := '';
  if sender <> Timer1 then
    currentline := TextEdit.TextPosition.Line;
  try
    opcode := copy(TextEdit.Lines.TextLines[currentline], 9, TextEdit.Lines.TextLines[currentline].Length);
  // The script is blank or end of line was reached; catch the exception
  except end;

  for i := 0 to Length(opcodelist) - 1 do
  begin
    if  (opcodelist[i].name <> '') and (opcode.StartsWith(opcodelist[i].name)) then
    begin
      // Create argument list
      v := 0;
      while opcodelist[i].arg[v] <> T_NONE do
      begin
        if opcodelist[i].arg[v] = T_REG then
          argstring := argstring + 'T_REG'
        else if opcodelist[i].arg[v] = T_RREG then
          argstring := argstring + 'T_RREG'
        else if opcodelist[i].arg[v] = T_BREG then
          argstring := argstring + 'T_BREG'
        else if opcodelist[i].arg[v] = T_DREG then
          argstring := argstring + 'T_DREG'
        else if opcodelist[i].arg[v] = T_SWITCH2B then
          argstring := argstring + 'T_SWITCH2B'
        else if opcodelist[i].arg[v] = T_SWITCH then
          argstring := argstring + 'T_SWITCH'
        else if opcodelist[i].arg[v] = T_SWITCHZ then
          argstring := argstring + 'T_SWITCHZ'
        else if opcodelist[i].arg[v] = T_BYTE then
          argstring := argstring + 'T_BYTE'
        else if opcodelist[i].arg[v] = T_WORD then
          argstring := argstring + 'T_WORD'
        else if opcodelist[i].arg[v] = T_DWORD then
          argstring := argstring + 'T_DWORD'
        else if opcodelist[i].arg[v] = T_DATA then
          argstring := argstring + 'T_DATA'
        else if opcodelist[i].arg[v] = T_STRDATA then
          argstring := argstring + 'T_STRDATA'
        else if opcodelist[i].arg[v] = T_PFLAG then
          argstring := argstring + 'T_PFLAG'
        else if opcodelist[i].arg[v] = T_FUNC then
          argstring := argstring + 'T_FUNC'
        else if opcodelist[i].arg[v] = T_FUNC2 then
          argstring := argstring + 'T_FUNC2'
        else if opcodelist[i].arg[v] = T_FLOAT then
          argstring := argstring + 'T_FLOAT'
        else if opcodelist[i].arg[v] = T_STR then
          argstring := argstring + 'T_STR';
        argstring := argstring + ', ';
        inc(v);
      end;

      if argstring = '' then
        argstring := argstring + 'T_NONE';
      opcode := opcodelist[i].name;
      break;
    end;
  end;
  if (length(argstring) > 0) and (argstring <> 'T_NONE') then
    SetLength(argstring, length(argstring)-2);
  if argstring <> '' then
    argstring := ' <' + opcode + '> ' + argstring;
  TextEdit.Hint := 'Line: ' + inttostr(currentline) + argstring;
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
begin
  SetTextZoom(100);
end;

procedure TfmScriptTE.Z125Click(Sender: TObject);
begin
  SetTextZoom(125);
end;

procedure TfmScriptTE.Z150Click(Sender: TObject);
begin
  SetTextZoom(150);
end;

procedure TfmScriptTE.Z200Click(Sender: TObject);
begin
  SetTextZoom(200);
end;

procedure TfmScriptTE.Z300Click(Sender: TObject);
begin
  SetTextZoom(300);
end;

end.
