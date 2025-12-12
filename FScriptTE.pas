unit FScriptTE;

interface

uses
  Winapi.Windows, Winapi.Messages, ShellApi, System.Generics.Collections, System.StrUtils,
  System.Generics.Defaults, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, TextEditor, TextEditor.Types, Registry,
  Vcl.ExtCtrls, main, Vcl.ComCtrls, Vcl.StdCtrls;

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
    StatusBar1: TStatusBar;
    Edit2: TEdit;
    btnSearch: TButton;
    Changetheme1: TMenuItem;
    Blue1: TMenuItem;
    Classic1: TMenuItem;
    Darcula1: TMenuItem;
    DarkIcon1: TMenuItem;
    Dark1: TMenuItem;
    Darker1: TMenuItem;
    Default1: TMenuItem;
    Dracula1: TMenuItem;
    FluentNight1: TMenuItem;
    GitHubDark1: TMenuItem;
    MonokaiDistilled1: TMenuItem;
    Monokai1: TMenuItem;
    Oblivion1: TMenuItem;
    Obsid1: TMenuItem;
    Ocean1: TMenuItem;
    Oceanic1: TMenuItem;
    Okaidia1: TMenuItem;
    Purple1: TMenuItem;
    Twilight1: TMenuItem;
    VisualStudioDark1: TMenuItem;
    VisualStudio1: TMenuItem;
    Windows11Dark1: TMenuItem;
    N4: TMenuItem;
    Addeditdata1: TMenuItem;
    NPC1: TMenuItem;
    SaveImage1: TMenuItem;
    Enemy1: TMenuItem;
    Float1: TMenuItem;
    Symbolchat1: TMenuItem;
    Vector1: TMenuItem;
    Enemystat1: TMenuItem;
    EnemyResist1: TMenuItem;
    EnemyAttack1: TMenuItem;
    EnemyMovement1: TMenuItem;
    Image1: TMenuItem;
    Changeimage1: TMenuItem;
    Wholewords1: TMenuItem;
    AddArgs1: TMenuItem;
    Searchreplacesettings1: TMenuItem;
    Matchcase1: TMenuItem;
    N5: TMenuItem;
    Engine1: TMenuItem;
    Extended1: TMenuItem;
    Normal1: TMenuItem;
    RegularExpression1: TMenuItem;
    Wildcard1: TMenuItem;
    Resetsettings1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Help1: TMenuItem;
    Opcodes2: TMenuItem;
    ReservedRegisters1: TMenuItem;
    Functions1: TMenuItem;
    GotoLine1: TMenuItem;
    N11: TMenuItem;
    AddSTRcomment1: TMenuItem;
    NotesPanel: TPanel;
    Panel2: TPanel;
    txtNotes: TMemo;
    Splitter1: TSplitter;
    Notes1: TMenuItem;
    Switcheditor1: TMenuItem;
    Label1: TMenuItem;
    StringSTR1: TMenuItem;
    StringArgument1: TMenuItem;
    PopupMenu2: TPopupMenu;
    NotesFont1: TMenuItem;
    NotesReset1: TMenuItem;
    NotesBackground1: TMenuItem;
    NotesText1: TMenuItem;
    N6: TMenuItem;
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
    procedure TextEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSearchClick(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure ChangeTheme(Sender: TObject);
    procedure AddEditData(Sender: TObject);
    procedure Wholewords1Click(Sender: TObject);
    procedure AddArgs1Click(Sender: TObject);
    procedure Normal1Click(Sender: TObject);
    procedure Extended1Click(Sender: TObject);
    procedure RegularExpression1Click(Sender: TObject);
    procedure Wildcard1Click(Sender: TObject);
    procedure Matchcase1Click(Sender: TObject);
    procedure Resetsettings1Click(Sender: TObject);
    procedure Opcodes2Click(Sender: TObject);
    procedure ReservedRegisters1Click(Sender: TObject);
    procedure Functions1Click(Sender: TObject);
    procedure GotoLine1Click(Sender: TObject);
    procedure AddSTRcomment1Click(Sender: TObject);
    procedure Notes1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure txtNotesChange(Sender: TObject);
    procedure Switcheditor1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure StringSTR1Click(Sender: TObject);
    procedure StringArgument1Click(Sender: TObject);
    procedure TextEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure TextEditMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure NotesFont1Click(Sender: TObject);
    procedure NotesText1Click(Sender: TObject);
    procedure NotesBackground1Click(Sender: TObject);
    procedure NotesReset1Click(Sender: TObject);

  private
    { Private declarations }
    FNoteLookup: TDictionary<string, string>;
    procedure BuildNoteLookup;
  public
    { Public declarations }
  end;

procedure UpdateTextRefs();
procedure SetTextZoom(zoomvalue: integer);
procedure SetSearchEngine(engine: integer);
procedure SetTextColor(colortype: string);
function IsWordInString(aString: PWideChar; aSearchString: string; aSearchOptions: TStringSearchOptions): Boolean;
procedure UncheckThemes;
procedure FormatCurrentLine;

var
  fmScriptTE: TfmScriptTE;
  textEdited: Boolean = false;
  linechanged: Boolean = false;
  autoformat: Boolean = false;
  formatmap: Boolean = false;
  strlabel: Boolean = false;
  changeline: integer = 0;
  currentline: integer = 0;
  editline: integer = -1;
  nextline: integer = 0;
  nextlabel: integer = 0;
  opcodelist: array [0 .. 1000] of TAsmFnc;

implementation

uses TCom, unit1, unit14, FScrypt, FFind, FReplace, FGoto, TextEditor.CompletionProposal.Snippets,
  NPCBuild, EnemyStat, FEnemyResist, FEnemyMov, FEnemyAttack, FVector;

{$R *.dfm}

procedure TfmScriptTE.BuildNoteLookup;
var
  i, sep: Integer;
  s, left, right: string;
begin
  if Assigned(FNoteLookup) then
    FNoteLookup.Free;

  FNoteLookup := TDictionary<string, string>.Create;

  for i := 0 to txtNotes.Lines.Count - 1 do
  begin
    s := txtNotes.Lines[i];
    sep := Pos(':=', s);
    if sep > 0 then
    begin
      left  := Trim(Copy(s, 1, sep - 1));
      right := Trim(Copy(s, sep + 2, MaxInt));

      // Make lookup case-insensitive
      FNoteLookup.AddOrSetValue(UpperCase(left), right);
    end;
  end;
end;

procedure UncheckThemes;
begin
  with fmScriptTE do
  begin
    Default1.Checked := false;
    Blue1.Checked := false;
    Classic1.Checked := false;
    Darcula1.Checked := false;
    DarkIcon1.Checked := false;
    Dark1.Checked := false;
    Darker1.Checked := false;
    Dracula1.Checked := false;
    FluentNight1.Checked := false;
    GitHubDark1.Checked := false;
    MonoKaiDistilled1.Checked := false;
    Monokai1.Checked := false;
    Oblivion1.Checked := false;
    Obsid1.Checked := false;
    Ocean1.Checked := false;
    Oceanic1.Checked := false;
    Okaidia1.Checked := false;
    Purple1.Checked := false;
    Twilight1.Checked := false;
    VisualStudioDark1.Checked := false;
    VisualStudio1.Checked := false;
    Windows11Dark1.Checked := false;
  end;
end;

procedure FormatCurrentLine;
begin
  linechanged := true;
  autoformat := true;
  changeline := fmScriptTE.TextEdit.TextPosition.Line;
  editline := changeline;
  fmScriptTE.TextEditCaretChanged(nil, 0, 0, 0);
  autoformat := false;
end;

procedure UpdateTextRefs();
var
  i,j,x,labelnum: integer;
  reftype,currentline,labelstr: widestring;
  opcodestr: string;
begin
  // Remove empty lines
  fmScriptTE.TextEdit.DeleteEmptyLines;

  form14.Caption := 'Adding References';
  form14.Label1.Hide;
  form14.Show;
  form14.ProgressBar1.max := fmScriptTE.TextEdit.Lines.Count - 1;

  // Clear data references
  for i := 0 to 1000 do datablock[i]:=-1;

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

  for i := 0 to fmScriptTE.TextEdit.Lines.Count - 1 do
  begin
    form14.ProgressBar1.Position := i;
    form14.Repaint;

    // Format the line
    linechanged := true;
    autoformat := true;
    changeline := i;
    editline := changeline;
    fmScriptTE.TextEditCaretChanged(nil, 0, 0, 0);
    autoformat := false;

    currentline := fmScriptTE.TextEdit.Lines[i];
    if currentline <> '' then
    begin
      // Update all label flag data references
      x := pos(':',fmScriptTE.TextEdit.Lines[i]);
      if (x <= 6) and (x <> 0) then
      begin
        labelstr := copy(currentline, 1, x-1);
        currentline := copy(currentline, x+1, length(currentline));
        currentline := TrimLeft(currentline);
        reftype := copy(currentline, 1, 4);
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
          if IsWordInString(PChar(fmScriptTE.TextEdit.Lines[i]),
          'R'+inttostr(j),[soDown, soWholeWord, soMatchCase]) then
            AddRegister(j);
      end;

      // Update functions used
      opcodestr := '';
      opcodestr := copy(fmScriptTE.TextEdit.Lines[i], 9, fmScriptTE.TextEdit.Lines[i].Length);
      for j := 0 to length(opcodelist) - 1 do
      begin
        if (opcodelist[j].name <> '') and (opcodestr.StartsWith(opcodelist[j].name)) then
        begin
          AddFunctionUsed(AnsiString(opcodelist[j].name));
          break;
        end;
      end;
    end;
  end;
  form14.Hide;
  form14.Caption := '3D Processing';
  form14.ProgressBar1.Position := 1;
  form14.Label1.Show;
  TextEdited := false;
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

procedure SetSearchEngine(engine: integer);
var
  Reg: TRegistry;
begin
  with fmScriptTE do
  begin
    Normal1.Checked := false;
    Extended1.Checked := false;
    RegularExpression1.Checked := false;
    Wildcard1.Checked := false;

    if engine = 0 then
    begin
      Normal1.Checked := true;
      TextEdit.Search.Engine := seNormal;
      TextEdit.Replace.Engine := seNormal
    end
    else if engine = 1 then
    begin
      Extended1.Checked := true;
      TextEdit.Search.Engine := seExtended;
      TextEdit.Replace.Engine := seExtended
    end
    else if engine = 2 then
    begin
      RegularExpression1.Checked := true;
      TextEdit.Search.Engine := seRegularExpression;
      TextEdit.Replace.Engine := seRegularExpression
    end
    else if engine = 3 then
    begin
      Wildcard1.Checked := true;
      TextEdit.Search.Engine := seWildcard;
      TextEdit.Replace.Engine := seWildcard
    end
    else
    begin
      Normal1.Checked := true;
      TextEdit.Search.Engine := seNormal;
      TextEdit.Replace.Engine := seNormal;
    end;
  end;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('SearchEngine', engine);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure SetTextColor(colortype: string);
var
  Reg: TRegistry;
  lastcaret,lastline: integer;
begin
    with fmScriptTE do
    begin
      // Save text position
      lastcaret := TextEdit.CaretIndex;
      lastline := TextEdit.TopLine;

      // Set default color
      if colortype = 'TELabelColor' then
        colordialog1.Color := TextEdit.Colors.EditorMethodNameForeground
      else if colortype = 'TEOpcodeColor' then
        colordialog1.Color := TextEdit.Colors.EditorReservedWordForeground
      else if colortype = 'TERegisterColor' then
        colordialog1.Color := TextEdit.Colors.EditorSymbolForeground
      else if colortype = 'TEValueColor' then
        colordialog1.Color := TextEdit.Colors.EditorNumberForeground
      else if colortype = 'TESTRColor' then
        colordialog1.Color := TextEdit.Colors.EditorCommentForeground
      else if colortype = 'TEStringColor' then
        colordialog1.Color := TextEdit.Colors.EditorStringForeground;

      if colordialog1.Execute then begin
          UncheckThemes;
          if colortype = 'TELabelColor' then
            TextEdit.Colors.EditorMethodNameForeground:=colordialog1.Color
          else if colortype = 'TEOpcodeColor' then
            TextEdit.Colors.EditorReservedWordForeground:=colordialog1.Color
          else if colortype = 'TERegisterColor' then
            TextEdit.Colors.EditorSymbolForeground:=colordialog1.Color
          else if colortype = 'TEValueColor' then
          begin
            TextEdit.Colors.EditorNumberForeground:=colordialog1.Color;
            TextEdit.Colors.EditorHexNumberForeground:=colordialog1.Color;
          end
          else if colortype = 'TESTRColor' then
            TextEdit.Colors.EditorCommentForeground:=colordialog1.Color
          else if colortype = 'TEStringColor' then
            TextEdit.Colors.EditorStringForeground:=colordialog1.Color;

          Reg := TRegistry.Create;
          try
          Reg.RootKey := HKEY_CURRENT_USER;
          if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
          begin
              Reg.WriteInteger('TEFontSize',TextEdit.Fonts.Text.Size);
              Reg.WriteString('TEFontName',TextEdit.Fonts.Text.Name);
              Reg.WriteInteger('TEFontStyle',byte(TextEdit.Fonts.Text.Style));
              Reg.WriteInteger('TELabelColor',TextEdit.Colors.EditorMethodNameForeground);
              Reg.WriteInteger('TEOpcodeColor',TextEdit.Colors.EditorReservedWordForeground);
              Reg.WriteInteger('TERegisterColor',TextEdit.Colors.EditorSymbolForeground);
              Reg.WriteInteger('TEValueColor',TextEdit.Colors.EditorNumberForeground);
              Reg.WriteInteger('TESTRColor',TextEdit.Colors.EditorCommentForeground);
              Reg.WriteInteger('TEStringColor',TextEdit.Colors.EditorStringForeground);
              Reg.WriteBool('ThemeModified',true);
              Reg.CloseKey;
          end;
          finally
              Reg.Free;
          end;

        Close;
        Show;
        // Reset to last caret position
        TextEdit.CaretIndex := lastcaret - 1;
        TextEdit.TopLine := lastline;
      end;
    end;
end;

function IsWordInString(aString: PWideChar; aSearchString: string; aSearchOptions: TStringSearchOptions): Boolean;
var
  size: Integer;
begin
  size := strLen(aString);
  result := SearchBuf(aString, size, 0, 0, aSearchString, aSearchOptions) <> nil;
end;

procedure TfmScriptTE.Addlabel1Click(Sender: TObject);
begin
  Newlabel1Click(nil);
end;

procedure TfmScriptTE.Addregister1Click(Sender: TObject);
begin
  Newregister1Click(nil);
end;

procedure TfmScriptTE.AddSTRcomment1Click(Sender: TObject);
begin
  TextEdit.BeginUndoBlock;
  strlabel := true;
  NewLabel1Click(nil);
  strlabel := false;
  TextEdit.InsertText('STR: ');
  TextEdit.EndUndoBlock;
end;

procedure TfmScriptTE.ChangeTheme(Sender: TObject);
var
  lastcaret,lastline: integer;
  selection: TMenuItem;
  themename: string;
  Reg: TRegistry;
begin
  lastcaret := TextEdit.CaretIndex;
  lastline := TextEdit.TopLine;
  UncheckThemes;

  selection := TMenuItem(Sender);
  themename := StringReplace(selection.Caption, '&', '', [rfReplaceAll]);
  TextEdit.Highlighter.LoadFromFile('Text editor\Themes\' + themename + '.json');
  TextEdit.Highlighter.Colors.LoadFromFile('Text editor\Themes\' + themename + '.json');
  tmenuitem(sender).Checked := true;
  Reg := TRegistry.Create;
  try
  Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
  begin
    Reg.WriteInteger('TETheme',selection.Tag);
    Reg.WriteBool('ThemeModified',false);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;

  if fmScriptTE.Visible then
  begin
    fmScriptTE.Close;
    fmScriptTE.Show;
    TextEdit.CaretIndex := lastcaret - 1;
    TextEdit.TopLine := lastline;
  end;
end;

procedure TfmScriptTE.btnSearchClick(Sender: TObject);
begin
  with fmScriptTE.TextEdit.Search do
  begin
     if Wholewords1.Checked then
      SetOption(TTextEditorSearchOption.soWholeWordsOnly,true)
     else
      SetOption(TTextEditorSearchOption.soWholeWordsOnly,false);
     if Matchcase1.Checked then
      SetOption(TTextEditorSearchOption.soCaseSensitive,true)
     else
      SetOption(TTextEditorSearchOption.soCaseSensitive,false);
    SearchText := Edit2.Text;
    Execute;
    TextEditClick(nil);
  end;

  if TextEdit.SelectedText = '' then
    // Could not find the search text - indicate with a system beep noise
    Beep;
end;

procedure TfmScriptTE.Changefont1Click(Sender: TObject);
var
  Reg: TRegistry;
  lastcaret,lastline: integer;
begin
    // Save text position
    lastcaret := TextEdit.CaretIndex;
    lastline := TextEdit.TopLine;

    // Set default font
    fontdialog1.font := TextEdit.Fonts.Text;

    if fontdialog1.Execute then begin
        UncheckThemes;
        TextEdit.Fonts.Text:=fontdialog1.Font;
        Textedit.Fonts.Text.Pitch:=fpFixed;
        Reg := TRegistry.Create;
        try
            Reg.RootKey := HKEY_CURRENT_USER;
            if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
        begin
            Reg.WriteInteger('TEFontSize',TextEdit.Fonts.Text.Size);
            Reg.WriteString('TEFontName',TextEdit.Fonts.Text.Name);
            Reg.WriteInteger('TEFontStyle',byte(TextEdit.Fonts.Text.Style));
            Reg.WriteInteger('TELabelColor',TextEdit.Colors.EditorMethodNameForeground);
            Reg.WriteInteger('TEOpcodeColor',TextEdit.Colors.EditorReservedWordForeground);
            Reg.WriteInteger('TERegisterColor',TextEdit.Colors.EditorSymbolForeground);
            Reg.WriteInteger('TEValueColor',TextEdit.Colors.EditorNumberForeground);
            Reg.WriteInteger('TESTRColor',TextEdit.Colors.EditorCommentForeground);
            Reg.WriteInteger('TEStringColor',TextEdit.Colors.EditorStringForeground);
            Reg.WriteBool('ThemeModified',true);
            Reg.CloseKey;
            end;
        finally
            Reg.Free;
        end;
        // Set zoom down to 100 if a non-default font was chosen, in case it's a bigger font
        if fontdialog1.Font.Name <> 'Courier New' then
          SetTextZoom(100);

        fmScriptTE.Close;
        fmScriptTE.Show;
        // Reset to last caret position
        TextEdit.CaretIndex := lastcaret - 1;
        TextEdit.TopLine := lastline;
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
  if fmScriptTE.txtNotes.Focused then
    fmScriptTE.txtNotes.SelText := ''
  else fmScriptTE.TextEdit.DeleteSelection;
end;

procedure TfmScriptTE.Edit2Exit(Sender: TObject);
begin
  Edit2.Hide;
  TextEdit.Search.SearchText := '';
end;

procedure TfmScriptTE.Exit1Click(Sender: TObject);
begin
  fmScriptTE.Close;
end;

procedure TfmScriptTE.Extended1Click(Sender: TObject);
begin
  SetSearchEngine(1);
end;

procedure TfmScriptTE.Find1Click(Sender: TObject);
begin
  Edit2.Show;
  Edit2.SetFocus;
  Edit2.SelectAll;
end;

procedure TfmScriptTE.Wholewords1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Wholewords1.Checked := not Wholewords1.Checked;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteBool('SearchWholeWords', Wholewords1.Checked);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.Wildcard1Click(Sender: TObject);
begin
  SetSearchEngine(3);
end;

procedure TfmScriptTE.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i,lastcaret: integer;
  s: string;
begin
  scriptline := fmScriptTE.TextEdit.TextPosition.Line;
  scriptindex := fmScriptTE.TextEdit.TopLine - 1;
  if textEdited then
  begin
    lastcaret := fmScriptTE.TextEdit.CaretIndex;
    fmScriptTE.TextEdit.MoveCaretToBeginning;
    fmScriptTE.TextEdit.CaretIndex := lastcaret - 1;
    fmScriptTE.TextEdit.TopLine := scriptindex;
    fmScriptTE.Hide;
    UpdateTextRefs();
    form4.listbox1.Clear;
    form14.Caption := 'Saving Script';
    form14.Label1.Hide;
    form14.Show;
    form14.ProgressBar1.max := TextEdit.Lines.Count - 1;
    for i := 0 to TextEdit.Lines.Count - 1 do
    begin
      if TextEdit.Lines[i] <> '' then
      begin
        form14.ProgressBar1.Position := i;
        form14.Repaint;
        s := replacetabs(TextEdit.Lines[i]);
        form4.ListBox1.items.add(s);
      end;
    end;
    form14.Hide;
    form14.Caption := '3D Processing';
    form14.ProgressBar1.Position := 1;
    form14.Label1.Show;
  end;
end;

procedure TfmScriptTE.FormDeactivate(Sender: TObject);
begin
  // Format the current line when leaving the window
  formatmap := true;
  FormatCurrentLine;
  formatmap := false;
end;

procedure TfmScriptTE.FormDestroy(Sender: TObject);
begin
  FNoteLookup.Free;
end;

procedure TfmScriptTE.FormHide(Sender: TObject);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
    begin
      Reg.WriteInteger('TEHeight', Height);
      Reg.WriteInteger('TEWidth', Width);
      Reg.WriteInteger('NotesWidth', NotesPanel.Width);
      Reg.WriteBool('NotesVisible', Notes1.Checked);
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.FormShow(Sender: TObject);
var
  i: integer;
  JSONOpcodeList, JSONRegisterList: String;
  JSONStrings: TStringList;
begin
    if not AddArgs1.Enabled then
      AddArgs1.Checked := false;
    textEdited := false;
    TextEdit.CompletionProposal.Snippets.Items.Clear;

    // Sort opcode list by name string length (highest to lowest)
    for i := 0 to Length(asmcode) - 1 do
      opcodelist[i] := asmcode[i];
    TArray.Sort<TAsmFnc>(opcodelist,TDelegatedComparer<TAsmFnc>.Construct(
    function(const Right, Left: TAsmFnc): Integer
    begin
      Result := Length(Left.name) - Length(Right.name);
    end
    ));

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
                "Open": "'"
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
    if scriptline > -1 then
      TextEdit.GoToLineAndSetPosition(scriptline, length(TextEdit.Lines[scriptline])+1);
    TextEdit.TopLine := scriptindex + 1;
    form14.Hide;
    form14.Caption := '3D Processing';
    form14.ProgressBar1.Position := 1;
    form14.Label1.Show;
end;

procedure TfmScriptTE.Functions1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://qedit.info/index.php?title=Common_functions', '', '', 0);
end;

procedure TfmScriptTE.GoToLabel1Click(Sender: TObject);
begin
  fmGoTo.Caption := 'Go To Label';
  fmGoto.ShowModal;
end;

procedure TfmScriptTE.GotoLine1Click(Sender: TObject);
begin
  fmGoTo.Caption := 'Go To Line';
  fmGoTo.ShowModal;
end;

procedure TfmScriptTE.Hex1Click(Sender: TObject);
begin
  form4.Hex1Click(nil);
end;

procedure TfmScriptTE.HideNOPs1Click(Sender: TObject);
begin
  form4.HideNOPs1Click(nil);
end;

procedure TfmScriptTE.Label1Click(Sender: TObject);
begin
  SetTextColor('TELabelColor');
end;

procedure TfmScriptTE.Matchcase1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  Matchcase1.Checked := not Matchcase1.Checked;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteBool('SearchMatchCase', MatchCase1.Checked);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.Newlabel1Click(Sender: TObject);
var
  i, j, lastline, prevline, lastcaret, labellength: integer;
  found: Boolean;
  whitespace, s: string;
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
      for j := 0 to Lines.Count - 1 do
      begin
        if Lines[j].StartsWith(inttostr(i) + ':') then
        begin
          found := true;
          break;
        end;
      end;
      if not found then
      begin
        labellength := 6 - length(inttostr(i));
        for j := 0 to labellength do
          whitespace := whitespace + ' ';
        if Trim(Lines[lastline]) = '' then
        begin
          prevline := TextEdit.TopLine;
          GoToLineAndSetPosition(lastline,0);
          InsertText(inttostr(i) + ':' + whitespace);
          TextEdit.TopLine := prevline;
        end
        else if Lines[lastline].StartsWith('        ') and not strlabel then
        begin
          s := inttostr(i) + ':' + whitespace + TrimLeft(Lines[lastline]);
          ReplaceLine(lastline+1, s , []);
        end
        else
        begin
          InsertLine(lastline + 2, inttostr(i) + ':' + whitespace);
          GoToLineAndSetPosition(lastline + 1,length(Lines[lastline + 1]) + 1);
        end;
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
      for j := 0 to Lines.Count - 1 do
      begin
        if Lines[j].Contains('R' + inttostr(i)) then
        begin
          found := true;
          break;
        end;
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

procedure TfmScriptTE.Normal1Click(Sender: TObject);
begin
  SetSearchEngine(0);
end;

procedure TfmScriptTE.Notes1Click(Sender: TObject);
begin
  Notes1.Checked := not Notes1.Checked;
  NotesPanel.Visible := not NotesPanel.Visible;
  Splitter1.Visible := not Splitter1.Visible;
  if fmScriptTE.Visible and NotesPanel.Visible then
    txtNotes.SetFocus;
end;

procedure TfmScriptTE.NotesBackground1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
    // Set default background color
    colordialog1.Color := txtNotes.Color;

    if colordialog1.Execute then begin
      txtNotes.Color := colordialog1.Color;
      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteInteger('TENoteBackgroundColor',txtNotes.Color);
          Reg.CloseKey;
          end;
      finally
          Reg.Free;
      end;
    end;
end;

procedure TfmScriptTE.NotesFont1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
    // Set default font
    fontdialog1.Font := txtNotes.Font;

    if fontdialog1.Execute then begin
      txtNotes.Font := fontdialog1.Font;
      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteInteger('TENoteFontSize',txtNotes.Font.Size);
          Reg.WriteString('TENoteFontName',txtNotes.Font.Name);
          Reg.WriteInteger('TENoteFontStyle',byte(txtNotes.Font.Style));
          Reg.CloseKey;
          end;
      finally
          Reg.Free;
      end;
    end;
end;

procedure TfmScriptTE.NotesReset1Click(Sender: TObject);
var
  choice: integer;
  Reg: TRegistry;
begin
    choice := MessageDlg('Font and color options for notes will be reset back to their defaults, continue?',
      mtConfirmation, [mbYes, mbNo], 0);

    if choice = mrYes then
    begin
      // Reset font
      txtNotes.Font.Size := 12;
      txtNotes.Font.Name := 'MS Sans Serif';
      txtNotes.Font.Style := [];

      // Reset colors
      txtNotes.Font.Color := clWindowText;
      txtNotes.Color := $00FFF8F8; // clGhostWhite

      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteInteger('TENoteFontSize',12);
          Reg.WriteString('TENoteFontName','MS Sans Serif');
          Reg.WriteInteger('TENoteFontStyle',0);
          Reg.WriteInteger('TENoteColor',clWindowText);
          Reg.WriteInteger('TENoteBackgroundColor',$00FFF8F8);
          Reg.CloseKey;
      end;
      finally
        Reg.Free;
      end;
    end;
end;

procedure TfmScriptTE.NotesText1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
    // Set default text color
    colordialog1.Color := txtNotes.Font.Color;

    if colordialog1.Execute then begin
      txtNotes.font.Color := colordialog1.Color;
      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteInteger('TENoteColor',txtNotes.Font.Color);
          Reg.CloseKey;
          end;
      finally
          Reg.Free;
      end;
    end;
end;

procedure TfmScriptTE.Openfromfile1Click(Sender: TObject);
begin
  if opendialog1.Execute then
  begin
    Textedit.LoadFromFile(opendialog1.FileName);
    importscan := true;
    ScanForMap;
    importscan := false;
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

procedure TfmScriptTE.Opcodes2Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://qedit.info/index.php?title=OPCodes', '', '', 0);
end;

procedure TfmScriptTE.Registers1Click(Sender: TObject);
begin
  SetTextColor('TERegisterColor');
end;

procedure TfmScriptTE.RegularExpression1Click(Sender: TObject);
begin
  SetSearchEngine(2);
end;

procedure TfmScriptTE.Values1Click(Sender: TObject);
begin
  SetTextColor('TEValueColor');
end;

procedure TfmScriptTE.Replace1Click(Sender: TObject);
begin
  fmReplace.ShowModal;
end;

procedure TfmScriptTE.ReservedRegisters1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://qedit.info/index.php?title=Barebones_registers_lists', '', '', 0);
end;

procedure TfmScriptTE.Resetsettings1Click(Sender: TObject);
var
  choice: integer;
  Reg: TRegistry;
begin
    choice := MessageDlg('Search and replace settings will be reset back to their defaults, continue?',
      mtConfirmation, [mbYes, mbNo], 0);

    if choice = mrYes then
    begin
      Wholewords1.Checked := false;
      Matchcase1.Checked := false;
      SetSearchEngine(0);
      fmReplace.Selectiononly1.Checked := false;

      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteBool('SearchWholeWords',false);
          Reg.WriteBool('SearchMatchCase',false);
          Reg.WriteInteger('SearchEngine',0);
          Reg.WriteBool('ReplaceSelectionOnly',false);
          Reg.CloseKey;
      end;
      finally
        Reg.Free;
      end;
    end;
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
  choice, lastcaret, lastline: integer;
  Reg: TRegistry;
begin
    choice := MessageDlg('Font and color options will be reset back to their defaults, continue?',
      mtConfirmation, [mbYes, mbNo], 0);

    if choice = mrYes then
    begin
      // Save text position
      lastcaret := TextEdit.CaretIndex;
      lastline := TextEdit.TopLine;

      // Reset font
      TextEdit.Fonts.Text.Size := 9;
      TextEdit.Fonts.Text.Name := 'Courier New';
      TextEdit.Fonts.Text.Style := [];

      // Reset text colors
      TextEdit.Colors.EditorMethodNameForeground:=clBlack;
      TextEdit.Colors.EditorReservedWordForeground:=clNavy;
      TextEdit.Colors.EditorSymbolForeground:=clNavy;
      TextEdit.Colors.EditorNumberForeground:=clBlue;
      TextEdit.Colors.EditorHexNumberForeground:=clBlue;
      TextEdit.Colors.EditorCommentForeground:=clGreen;
      TextEdit.Colors.EditorStringForeground:=clBlue;

      // Reset theme
      if DirectoryExists('Text editor\themes') then
        ChangeTheme(Default1);

      // Reset zoom
      SetTextZoom(125);

      Reg := TRegistry.Create;
      try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\Microsoft\schthack\qedit', True) then
      begin
          Reg.WriteInteger('TEFontSize',9);
          Reg.WriteString('TEFontName','Courier New');
          Reg.WriteInteger('TEFontStyle',0);
          Reg.WriteInteger('TELabelColor',clBlack);
          Reg.WriteInteger('TEOpcodeColor',clNavy);
          Reg.WriteInteger('TERegisterColor',clNavy);
          Reg.WriteInteger('TEValueColor',clBlue);
          Reg.WriteInteger('TESTRColor',clGreen);
          Reg.WriteInteger('TEStringColor',clBlue);
          Reg.WriteBool('ThemeModified',false);
          Reg.CloseKey;
      end;
      finally
        Reg.Free;
      end;

      fmScriptTE.Close;
      fmScriptTE.Show;

      // Reset to last caret position
      TextEdit.CaretIndex := lastcaret - 1;
      TextEdit.TopLine := lastline;
    end;
end;

procedure TfmScriptTE.StringArgument1Click(Sender: TObject);
begin
  SetTextColor('TEStringColor');
end;

procedure TfmScriptTE.StringSTR1Click(Sender: TObject);
begin
  SetTextColor('TESTRColor');
end;

procedure TfmScriptTE.Switcheditor1Click(Sender: TObject);
begin
  form1.SwitchScriptEditor1Click(nil);
end;

procedure TfmScriptTE.AddArgs1Click(Sender: TObject);
var
  Reg: TRegistry;
begin
  AddArgs1.Checked := not AddArgs1.Checked;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
  if Reg.OpenKey('\Software\Microsoft\schthack\qedit', true) then
  begin
    Reg.WriteBool('AddArgs', AddArgs1.Checked);
    Reg.CloseKey;
  end;
  finally
    Reg.Free;
  end;
end;

procedure TfmScriptTE.AddEditData(Sender: TObject);
var
  i,j,lastcaret,lastline: integer;
  temp: array [0 .. 1000] of integer;
  found: Boolean;
begin
  // Save references
  move(datablock[0], temp[0], sizeof(datablock));

  lastcaret := TextEdit.CaretIndex;
  lastline := TextEdit.TopLine;
  TextEdit.DeleteEmptyLines;

  // Find and store the next unused label
  if tmenuitem(sender).Tag <> 0 then
  begin
    with TextEdit do
    begin
      for i := 0 to 65535 do
      begin
        found := false;
        for j := 0 to Lines.Count - 1 do
        begin
          if Lines[j].StartsWith(inttostr(i) + ':') then
          begin
            found := true;
            break;
          end;
        end;
        if not found then
        begin
          nextlabel := i;
          break;
        end;
      end;
    end;
  end;

  form4.ListBox1.Clear;
  for i := 0 to TextEdit.Lines.Count - 1 do
    form4.ListBox1.Items.Add(TextEdit.Lines[i]);

  form4.ListBox1.ItemIndex := TextEdit.TextPosition.Line;

  if tmenuitem(sender).Tag = 0 then
    form4.Button10Click(fmScriptTE)
  else if tmenuitem(sender).Tag = 1 then
    form4.SaveImage1Click(fmScriptTE)
  else if tmenuitem(sender).Tag = 2 then
    form4.Image1Click(fmScriptTE)
  else if tmenuitem(sender).Tag = 3 then
    form4.EnemyStatEdit(fmScriptTE)
  else if tmenuitem(sender).Tag = 4 then
    form4.EnemyResistEdit(fmScriptTE)
  else if tmenuitem(sender).Tag = 5 then
    form4.EnemyAttackEdit(fmScriptTE)
  else if tmenuitem(sender).Tag = 6 then
    form4.EnemyMovementEdit(fmScriptTE)
  else if tmenuitem(sender).Tag = 7 then
    form4.EditFloatdata1Click(fmScriptTE)
  else if tmenuitem(sender).Tag = 8 then
    form4.Editsymbolechat1Click(fmScriptTE)
  else if tmenuitem(sender).Tag = 9 then
    form4.EditVectordata1Click(fmScriptTE);

  // Clear manually to avoid losing undo stack
  TextEdit.BeginUpdate;
  TextEdit.BeginUndoBlock;
  TextEdit.SelectAll;
  TextEdit.DeleteSelection;
  for i := 0 to form4.ListBox1.Items.Count - 1 do
    TextEdit.InsertLine(i+1,form4.Listbox1.Items[i]);
  TextEdit.DeleteLines(i+1,1);
  TextEdit.EndUndoBlock;
  TextEdit.EndUpdate;

  TextEdit.CaretIndex := lastcaret - 1;
  TextEdit.TopLine := lastline;
  TextEdited := true;

  // Re-add references
  move(temp[0], datablock[0], sizeof(datablock));
end;

procedure TfmScriptTE.TextEditCaretChanged(const ASender: TObject; const X2, Y2,
  AOffset: Integer);
var
  i,j,j2,k,x,y,x3,y3,g,d,oldsize,newsize,prevline,labelnum,opcodepos,stringpos,argpos: integer;
  reftype,trimline,labelstr,opcodestr,whitespace,s,str,o,fullargs,constructline: widestring;
  argarray: TArray<string>;
  argstrings: TStringList;
  invalidswitch: Boolean;
  i2: double;
  f: single;
begin
  if not autoformat then
    TextEditClick(nil);
  nextline := TextEdit.TextPosition.Line;
  if (editline <> -1) and ((nextline <> editline) or linechanged) then
  begin
    argstrings := TStringList.Create;

    if linechanged then
      i := changeline
    else
      i := editline;

    oldsize := length(TextEdit.Lines[i]);

    editline := -1;
    linechanged := false;

    trimline := Trim(fmScriptTE.TextEdit.Lines[i]);
    if trimline <> '' then
    begin
      // Get label if it exists
      labelstr := '';
      labelnum := 0;
      x := pos(':',trimline);
      if (x <= 6) and (x <> 0) then
      begin
        labelstr := copy(trimline, 0, x-1);
        trimline := copy(trimline, x+1, length(trimline));
        reftype := copy(trimline, 0, 4);
        if not TryStrToInt(labelstr, labelnum) then
          labelstr := '';
      end;
      if labelnum < 0 then
        labelstr := '0'
      else if labelnum > 65535 then
        labelstr := '65535';

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

      // Get arguments
      if opcodestr <> '' then
      begin
        fullargs := copy(fmScriptTE.TextEdit.Lines[i], opcodepos +
        length(opcodestr),length(fmScriptTE.TextEdit.Lines[i]));

        stringpos := pos('''', fullargs);
        if (stringpos > 0) and (opcodestr <> 'STR:') then
        begin
          str := copy(fullargs, stringpos, Length(fullargs));
          delete(fullargs, stringpos, length(fullargs) - stringpos);
        end;
        if (opcodestr <> 'STR:') and (opcodestr <> 'HEX:') and (opcodestr <> 'Unknow_Opcode') then
        begin
              argarray := SplitString(fullargs, ',');
              for var arg in argarray do
                argstrings.add(trim(arg));
        end;
        if argstrings.Count = 0 then
        begin
          if opcodestr = 'STR:' then
            argstrings.add(fullargs)
          else argstrings.add(Trim(fullargs));
        end;
      end;


      // Check and adjust argument count
      k := 0;
      while opcodelist[j].arg[k] <> T_NONE do
        inc(k);
      for x := argstrings.Count - 1 downto k do
        argstrings.Delete(x);
      if (argstrings.Count > 0) and (argstrings.Count - 1 < k) then
      begin
        k := k - argstrings.Count;
        if argstrings.Strings[0] = '' then
        begin
          if opcodelist[j].arg[0] = T_STR then
            argstrings.Strings[0] := ' '
          else argstrings.Strings[0] := '0';
        end;
        for x := 0 to k - 1 do
        begin
          if opcodelist[j].arg[argstrings.Count] <> T_STR then
            argstrings.Add('0')
          else argstrings.Add('');
        end;
      end;
      if (opcodelist[j].arg[argstrings.Count - 1] = T_STR)
      and (argstrings.Strings[argstrings.Count - 1] = '') then
        argstrings.Strings[argstrings.Count - 1] := ' ';

      // Adjust argument formatting
      for x := 0 to argstrings.count - 1 do
      begin
        if (argstrings.Strings[x] <> '') and (opcodestr <> 'Unknow_Opcode') then
        begin
            y := 0;
            f := 0;
            g := 0;
            i2 := 0;
            s := argstrings.Strings[x];
            if (opcodelist[j].arg[x] <> T_STR) and
              (opcodelist[j].arg[x] <> T_STRHEX) then
            s:=uppercase(s);
            if (opcodelist[j].arg[x] = T_REG) or
            (opcodelist[j].arg[x] = T_BREG) or
            (opcodelist[j].arg[x] = T_DREG) or
           (opcodelist[j].arg[x] = T_RREG) then begin
           if (opcodelist[j].order = T_Args) and
            ((length(s) = 8) and (lowercase(copy(s,1,1))<> 'r')) then begin
           if not showdecimal then
            y:=hextoint(s)
           else
            trystrtoint(s,y);
           if (y = -1) and (uppercase(s) <> 'FFFFFFFF') and not showdecimal
           then y := 0;
           if y>$FFFFFFff then
                y := $FFFFFFFF;
           s:=GetDisplayValue(y,8);

           end else begin
           if s[1] = 'R' then s:=copy(s,2,length(s)-1);
           trystrtoint(s,y);
           if y>255 then
                y := 255;
           s:='R'+inttostr(y);
           end;
          end else
          if (opcodelist[j].arg[x] = T_STR) then begin
             if stringpos > 0 then s:=trim(str);
             if s[1] <> '''' then
              s:=''''+s;
             if s[length(s)] <> '''' then
             s:=s+'''';
          end else
          if (opcodelist[j].arg[x] = T_BYTE) then begin
             if not showdecimal then
              y:=hextoint(s)
             else
              trystrtoint(s,y);
             if (y = -1) and not showdecimal then
                  y := 0;
             if y>255 then
                  y := 255;
             s:=GetDisplayValue(y,2);
          end else
          if (opcodelist[j].arg[x] = T_WORD) then begin
             if not showdecimal then
              y:=hextoint(s)
             else
              trystrtoint(s,y);
             if (y = -1) and not showdecimal then
                  y := 0;
             if y>65535 then
                  y := 65535;
             s:=GetDisplayValue(y,4);
          end else
          if (opcodelist[j].arg[x] = T_PFLAG) then begin
             if not showdecimal then
              y:=hextoint(s)
             else
              trystrtoint(s,y);
             if (y = -1) and not showdecimal then
                  y := 0;
             if y>65535 then
                  y := 65535;
             s:=GetDisplayValue(y,4);
          end else
          if (opcodelist[j].arg[x] = T_FUNC) or
              (opcodelist[j].arg[x] = T_DATA) or
              (opcodelist[j].arg[x] = T_STRDATA) or
              (opcodelist[j].arg[x] = T_FUNC2) then begin
             trystrtoint(s,y);
             if y>65535 then
                  y := 65535;
             s:=inttostr(y);
           end else
          if (opcodelist[j].arg[x] = T_FLOAT) then begin
              if (opcodelist[j].order = T_Args) and
              (s[1] = 'R') then begin
              s:=copy(s,2,length(s)-1);
             trystrtoint(s,y);
             if y>255 then
                  y := 255;
             s:='R'+inttostr(y);
              end else begin
             trystrtofloat(s,i2);
             s:=floattostr(i2);
             end;
          end else

          if (opcodelist[j].arg[x] = T_SWITCH) then begin
             trystrtoint(copy(s,1,pos(':',s)-1),g);
             o:=copy(s,pos(':',s)+1,length(s)-pos(':',s));
             s:=inttostr(g);
             if g = 0 then
              s:='1:1';
             while g > 0 do begin
                  d:=pos(':',o);
                  if (g = 1) and (d > 0) then begin
                      invalidswitch := true;
                  end;
                  if d = 0 then begin
                      if g = 1 then d:=length(o)+1
                      else begin
                        invalidswitch := true;
                      end;
                  end;
                  trystrtoint(copy(o,1,d-1),j2);
                  o:=copy(o,d+1,length(o)-d);
                  dec(g);
                  s:=s+':'+inttostr(j2);
             end;
             if invalidswitch then
              s:='1:1';
          end else
          if (opcodelist[j].arg[x] = T_SWITCH2B) then begin
             trystrtoint(copy(s,1,pos(':',s)-1),g);
             o:=copy(s,pos(':',s)+1,length(s)-pos(':',s));
             s:=inttostr(g);
             if g = 0 then
              s:='1:1';
             while g > 0 do begin
                  d:=pos(':',o);
                  if (g = 1) and (d > 0) then begin
                    invalidswitch := true;
                  end;
                  if d = 0 then begin
                      if g = 1 then d:=length(o)+1
                      else begin
                        invalidswitch := true;
                      end;
                  end;
                  trystrtoint(copy(o,1,d-1),j2);
                  o:=copy(o,d+1,length(o)-d);
                  dec(g);
                  s:=s+':'+inttostr(j2);
             end;
             if invalidswitch then
              s:='1:1';
          end else
          if (opcodelist[j].arg[x] = T_STRHEX) then begin
             s:=s;
          end else
          if (opcodelist[j].arg[x] = T_HEX) then begin
             s:=s;
          end else
          begin
             if (opcodelist[j].order = T_Args) and
              (s[1] = 'R') then begin
              if s[1] = 'R' then s:=copy(s,2,length(s)-1);
             trystrtoint(s,y);
             if y>255 then
                  y := 255;
             s:='R'+inttostr(y);
             end else begin
             if not showdecimal then y:=hextoint(s);
             if showdecimal then
             begin
                trystrtoint(s,y);
                y := dword(y);
             end;
             if opcodelist[j].arg[x] = T_FLOAT then begin
                  y:=0;
                  trystrtofloat(s,f);
                  move(f,y,4);
             end;
             if (y = -1) and (uppercase(s) <> 'FFFFFFFF') and not showdecimal
             then begin
                  y := 0;
             end;
             if y>$FFFFFFff then
                  y := $FFFFFFFF;
             s:=GetDisplayValue(y,8);
             end;
          end;
          argstrings.Strings[x] := s;
        end;
      end;

      with fmScriptTE.TextEdit do
        begin
        // Reconstruct the line
        constructline := '';
        whitespace := '        ';

        // Label/whitespace
        if labelstr <> '' then
        begin
          constructline := labelstr + ':';
          for j := 1 to length(labelstr) + 1 do
          SetLength(whitespace,length(whitespace)-1);
        end;
        constructline := constructline + whitespace;

        // Opcode
        if (argstrings.Count > 0) and ((opcodestr = 'STR:') or (opcodestr = 'HEX:'))
        and (argstrings.Strings[0][1] = ' ') then
          constructline := constructline + opcodestr
        else constructline := constructline + opcodestr + ' ';

        // Arguments
        for j := 0 to argstrings.count - 1 do
        begin
          constructline := constructline + argstrings.Strings[j];
          if (j = 0) and (opcodestr = 'Unknow_Opcode') then
            break;
          if j <> argstrings.count - 1 then
            constructline := constructline + ', ';
        end;

        if Lines[i] <> constructline then ReplaceLine(i+1,constructline, []);

        // Add register arguments
        if (AddArgs1.Checked) and (AddArgs1.Enabled) and (argstrings.count > 0)
        and (opcodestr <> 'STR:') and (opcodestr <> 'HEX:')
        and (opcodestr <> 'Unknow_Opcode') and not autoformat then
        begin
          g := 0;
          for j := 0 to length(asmarg) - 1 do
          begin
            if GetOpcodeId(opcodestr) = asmarg[j].opcodeid then
            begin
              if (asmarg[j].argtype = 'leti') and
              ((Lines[i-1].Contains('  ' + GetOpcodeName($8) + ' ')) or
              (Lines[i-1].Contains('  ' + GetOpcodeName($9) + ' '))) then break;
              if (asmarg[j].argtype = 'fleti') and
              ((Lines[i-1].Contains('  ' + GetOpcodeName($f903) + ' ')) or
              (Lines[i-1].Contains('  ' + GetOpcodeName($f904) + ' '))) then break;
              // Find the last register argument
              for k := 0 to argstrings.count - 1 do
                if Uppercase(argstrings[k][1]) = 'R' then g:=k;
              s := copy(argstrings.Strings[g],2,Length(argstrings.Strings[g]) - 1);
              g := 0;
              trystrtoint(s,g);
              BeginUndoBlock;
              for k := 0 to asmarg[j].argnum - 1 do
              begin
                if g <= 255 then
                begin
                  if asmarg[j].argtype = 'leti' then
                    InsertLine(1 + i + k,'        ' + GetOpcodeName($9) + ' R' + inttostr(g) + ', 00000000')
                  else if asmarg[j].argtype = 'fleti' then
                    InsertLine(1 + i + k,'        ' + GetOpcodeName($f904)  + ' R' + inttostr(g) + ', 0');
                end;
                inc(g);
              end;
              // Clean up empty lines
              DeleteEmptyLines;
              BeginUpdate;
              GoToLineAndSetPosition(i, length(Lines[i]) + 1);
              EndUpdate;
              EndUndoBlock;
              break;
            end;
          end;
        end;

        // Move to end of line if autocomplete was invoked
        newsize := length(TextEdit.Lines[i]);
        if (newsize > oldsize) and (argstrings.Count > 0) then
        begin
          // Clean up empty lines
          DeleteEmptyLines;
          // Save old scroll position
          TextEdit.BeginUpdate;
          prevline := TextEdit.TopLine;
          GoToLineAndSetPosition(i, length(Lines[i]) + 1);
          TextEdit.TopLine := prevline;
          TextEdit.EndUpdate;
        end;

        // Leave and re-focus the text area to prevent issues with scrolling
        if TextEdit.Focused and not autoformat then
        begin
          Statusbar1.SetFocus;
          TextEdit.SetFocus;
        end;

        // Update maps
        try
        if (not autoformat) or formatmap then
        begin
           if (lowercase(opcodestr) = lowercase(GetOpcodeName($c4))) or
           (lowercase(opcodestr) = lowercase(GetOpcodeName($f80d))) or
           (lowercase(opcodestr) = lowercase(GetOpcodeName($9))) then
            ScanForMap;
           if (lowercase(opcodestr) = lowercase(GetOpcodeName($f951)))
           and (argstrings.Count = 4) then begin
           //bb map
           s:=Lines[i];
           delete(s,1,9+length(GetOpcodeName($f951)));
           if not showdecimal then
           begin
             x3:=hextoint(copy(s,1,2));
             g:=hextoint(copy(s,5,4));
             y3:=hextoint(copy(s,11,2));
           end
           else
           begin
             x3:=strtoint(copy(s,1,2));
             g:=strtoint(copy(s,5,4));
             y3:=strtoint(copy(s,11,2));
           end;
           if x3 < 30 then begin
           mapxvmfile[x3]:=path+'map\xvm\'+mapxvmname[mapid[g]+y3];
           mapfile[x3]:=path+'map\'+mapfilename[mapid[g]+y3];
           floor[x3].floorid:=MapArea[mapid[g]+y3];
           Form1.CheckListBox1.Items.Strings[x3]:=mapname[mapid[g]+y3];
         end;
         end;
        end;
        except end; // Catch invalid argument exception
      end;
    end;
  end;
   // Free the argument list
   argstrings.Free;
end;

procedure TfmScriptTE.TextEditChange(Sender: TObject);
var
  i: integer;
begin
  isEdited := true;
  textEdited := true;
  editline := TextEdit.TextPosition.Line;
  TextEdit.Lines[editline] := replacetabs(TextEdit.Lines[editline]);
  // Update autocomplete invoke status
  if fmScriptTE.Visible then
  begin
    for i := 0 to Length(opcodelist) - 1 do
    begin
      if  (opcodelist[i].name <> '') and (TextEdit.Lines[editline].Contains(opcodelist[i].name)) then
      begin
        TextEdit.CompletionProposal.SetOption(TTextEditorCompletionProposalOption.cpoAutoInvoke,false);
        break
      end
      else
        TextEdit.CompletionProposal.SetOption(TTextEditorCompletionProposalOption.cpoAutoInvoke,true);
      end;
    end;
end;

procedure TfmScriptTE.TextEditClick(Sender: TObject);
var
  opcode, argstring: string;
  i, v: integer;
begin
  argstring := '';
  opcode := '';
  currentline := TextEdit.TextPosition.Line;
  opcode := copy(TextEdit.Lines[currentline], 9, TextEdit.Lines[currentline].Length);

  TextEdit.CompletionProposal.SetOption(TTextEditorCompletionProposalOption.cpoAutoInvoke,true);

  for i := 0 to Length(opcodelist) - 1 do
  begin
    if  (opcodelist[i].name <> '') and (opcode.StartsWith(opcodelist[i].name)) then
    begin
      TextEdit.CompletionProposal.SetOption(TTextEditorCompletionProposalOption.cpoAutoInvoke,false);
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
    argstring := opcode + ' <' + argstring + '>';
  Statusbar1.Panels.Items[1].Text := inttostr(currentline);
  Statusbar1.Panels.Items[2].Text := argstring;
end;

procedure TfmScriptTE.TextEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
  begin
    linechanged := true;
    changeline := TextEdit.TextPosition.Line;
  end;
end;

procedure TfmScriptTE.TextEditKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s:string;
    x:integer;
begin
    if key = VK_F1 then begin
        if (TextEdit.Lines.Count > 0) and (TextEdit.TextPosition.Line>-1) then begin
            s:= TextEdit.Lines[TextEdit.TextPosition.Line];
            delete(s,1,8);
            x:=pos(' ',s);
            if x > 0 then s:=copy(s,1,x-1);
            shellexecute(0,'open',pchar('http://qedit.info/index.php?title='+s),'','',0);
        end;
    end;
end;

procedure TfmScriptTE.TextEditMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbRight then
    PopupMenu1.Popup(mouse.CursorPos.X, mouse.CursorPos.Y);
end;

procedure TfmScriptTE.TextEditMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  mouseword, hintText, oldHint: string;
begin
  if not Assigned(FNoteLookup) then
    Exit;

  mouseword := TextEdit.WordAtMouse;
  oldHint := TextEdit.Hint;

  if (mouseword <> '') and
     FNoteLookup.TryGetValue(UpperCase(mouseword), hintText) then
    TextEdit.Hint := hintText
  else
    TextEdit.Hint := '';

  // Only refresh hint if changed
  if TextEdit.Hint <> oldHint then
    Application.ActivateHint(TextEdit.ClientToScreen(Point(X, Y)));
end;

procedure TfmScriptTE.txtNotesChange(Sender: TObject);
begin
  isedited := true;
  BuildNoteLookup;
end;

procedure TfmScriptTE.Undo1Click(Sender: TObject);
begin
  TextEdit.DoUndo;
  editline := -1;
  linechanged := false;
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
