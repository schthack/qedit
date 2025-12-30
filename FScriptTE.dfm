object fmScriptTE: TfmScriptTE
  Left = 0
  Top = 0
  Caption = 'Script Text Editor'
  ClientHeight = 601
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  Position = poMainFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  OnShow = FormShow
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 606
    Top = 0
    Height = 561
    Align = alRight
    Visible = False
    ExplicitLeft = 448
    ExplicitTop = 320
    ExplicitHeight = 100
  end
  object TextEdit: TTextEditor
    Left = 0
    Top = 0
    Width = 606
    Height = 561
    Align = alClient
    CompletionProposal.Options = [cpoAutoInvoke, cpoAutoConstraints, cpoAddHighlighterKeywords, cpoFiltered]
    HighlightLine.Items = <
      item
      end>
    LeftMargin.Bookmarks.Visible = False
    LeftMargin.LineNumbers.Visible = False
    LeftMargin.LineState.Visible = False
    LeftMargin.Marks.Visible = False
    LeftMargin.MarksPanel.Visible = False
    LeftMargin.Width = 3
    OnCaretChanged = TextEditCaretChanged
    OnChange = TextEditChange
    OnClick = TextEditClick
    OnKeyDown = TextEditKeyDown
    OnKeyUp = TextEditKeyUp
    OnMouseDown = TextEditMouseDown
    OnMouseMove = TextEditMouseMove
    ParentShowHint = False
    RightMargin.Visible = False
    Scroll.Options = [soShowVerticalScrollHint, soWheelClickMove]
    Search.Options = [soBeepIfStringNotFound, soHighlightResults, soSearchOnTyping, soShowSearchMatchNotFound, soWrapAround]
    Selection.Options = [soTermsCaseSensitive]
    ShowHint = True
    SyncEdit.Active = False
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 582
    Width = 794
    Height = 19
    Panels = <
      item
        Text = 'Line'
        Width = 115
      end
      item
        Width = 100
      end
      item
        Width = 100
      end>
  end
  object Edit2: TEdit
    Left = 0
    Top = 561
    Width = 794
    Height = 21
    Align = alBottom
    TabOrder = 2
    Visible = False
    OnExit = Edit2Exit
  end
  object btnSearch: TButton
    Left = 655
    Top = 8
    Width = 0
    Height = 0
    Caption = 'Search'
    Default = True
    TabOrder = 3
    OnClick = btnSearchClick
  end
  object NotesPanel: TPanel
    Left = 609
    Top = 0
    Width = 185
    Height = 561
    Align = alRight
    ParentBackground = False
    TabOrder = 4
    Visible = False
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 18
      Align = alTop
      Caption = 'Notes'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      PopupMenu = PopupMenu2
      TabOrder = 0
    end
    object txtNotes: TMemo
      Left = 1
      Top = 19
      Width = 183
      Height = 541
      Align = alClient
      BorderStyle = bsNone
      Color = clGhostwhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      StyleElements = [seBorder]
      OnChange = txtNotesChange
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 232
    object Addeditdata1: TMenuItem
      Caption = 'Add or edit data'
      object NPC1: TMenuItem
        Caption = 'NPC'
        OnClick = AddEditData
      end
      object Image1: TMenuItem
        Caption = 'Image'
        object Changeimage1: TMenuItem
          Tag = 2
          Caption = 'Change...'
          OnClick = AddEditData
        end
        object SaveImage1: TMenuItem
          Tag = 1
          Caption = 'Save...'
          OnClick = AddEditData
        end
      end
      object Enemy1: TMenuItem
        Tag = 4
        Caption = 'Enemy'
        object Enemystat1: TMenuItem
          Tag = 3
          Caption = 'Physical'
          OnClick = AddEditData
        end
        object EnemyResist1: TMenuItem
          Tag = 4
          Caption = 'Resist'
          OnClick = AddEditData
        end
        object EnemyAttack1: TMenuItem
          Tag = 5
          Caption = 'Attack'
          OnClick = AddEditData
        end
        object EnemyMovement1: TMenuItem
          Tag = 6
          Caption = 'Movement'
          OnClick = AddEditData
        end
      end
      object Float1: TMenuItem
        Tag = 7
        Caption = 'Float'
        OnClick = AddEditData
      end
      object Symbolchat1: TMenuItem
        Tag = 8
        Caption = 'Symbol Chat'
        OnClick = AddEditData
      end
      object Vector1: TMenuItem
        Tag = 9
        Caption = 'Vector'
        OnClick = AddEditData
      end
    end
    object Newlabel1: TMenuItem
      Caption = 'Add new unused label'
      ShortCut = 16460
      OnClick = Newlabel1Click
    end
    object Newregister1: TMenuItem
      Caption = 'Add new unused register'
      ShortCut = 16466
      OnClick = Newregister1Click
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object AddArgs1: TMenuItem
      Caption = 'Prepend leti/fleti arguments'
      OnClick = AddArgs1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Argumentformat1: TMenuItem
      Caption = 'Set argument format'
      object Hex1: TMenuItem
        Caption = 'Hex'
        OnClick = Hex1Click
      end
      object Decimal1: TMenuItem
        Caption = 'Decimal'
        OnClick = Decimal1Click
      end
    end
    object HideNOPs1: TMenuItem
      Caption = 'Hide NOPs'
      OnClick = HideNOPs1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Cut1: TMenuItem
      Caption = 'Cut'
      ShortCut = 16472
      OnClick = Cut1Click
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      ShortCut = 16451
      OnClick = Copy1Click
    end
    object Paste1: TMenuItem
      Caption = 'Paste'
      ShortCut = 16470
      OnClick = Paste1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      ShortCut = 46
      OnClick = Delete1Click
    end
    object Undo1: TMenuItem
      Caption = 'Undo'
      ShortCut = 16474
      OnClick = Undo1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Switcheditor1: TMenuItem
      Caption = 'Switch editor'
      ShortCut = 32856
      OnClick = Switcheditor1Click
    end
  end
  object MainMenu1: TMainMenu
    Images = Form1.ImageList1
    Left = 24
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Openfromfile1: TMenuItem
        Caption = 'Open from file...'
        ImageIndex = 2
        ShortCut = 16463
        OnClick = Openfromfile1Click
      end
      object Savetofile1: TMenuItem
        Caption = 'Save to file...'
        ImageIndex = 3
        ShortCut = 16467
        OnClick = Savetofile1Click
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object AddSTRcomment1: TMenuItem
        Caption = 'Add STR comment'
        ImageIndex = 20
        ShortCut = 32851
        OnClick = AddSTRcomment1Click
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Caption = 'Search'
        ShortCut = 16454
        OnClick = Find1Click
      end
      object Replace1: TMenuItem
        Caption = 'Replace...'
        ShortCut = 16456
        OnClick = Replace1Click
      end
      object Searchreplacesettings1: TMenuItem
        Caption = 'Search and replace settings'
        object Wholewords1: TMenuItem
          Caption = 'Find whole words and registers only'
          OnClick = Wholewords1Click
        end
        object Matchcase1: TMenuItem
          Caption = 'Match case'
          OnClick = Matchcase1Click
        end
        object Engine1: TMenuItem
          Caption = 'Engine'
          object Normal1: TMenuItem
            Caption = 'Normal'
            OnClick = Normal1Click
          end
          object Extended1: TMenuItem
            Caption = 'Extended'
            OnClick = Extended1Click
          end
          object RegularExpression1: TMenuItem
            Caption = 'Regular Expression'
            OnClick = RegularExpression1Click
          end
          object Wildcard1: TMenuItem
            Caption = 'Wildcard'
            OnClick = Wildcard1Click
          end
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object Resetsettings1: TMenuItem
          Caption = 'Reset...'
          OnClick = Resetsettings1Click
        end
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object GoToLabel1: TMenuItem
        Caption = 'Go to label...'
        ImageIndex = 13
        ShortCut = 16455
        OnClick = GoToLabel1Click
      end
      object GotoLine1: TMenuItem
        Caption = 'Go to line...'
        ImageIndex = 13
        ShortCut = 32839
        OnClick = GotoLine1Click
      end
      object Deleteselection1: TMenuItem
        Caption = 'Delete selection'
        ShortCut = 46
        Visible = False
        OnClick = Deleteselection1Click
      end
    end
    object Format1: TMenuItem
      Caption = 'Format'
      object Changefont1: TMenuItem
        Caption = 'Change font...'
        ImageIndex = 22
        OnClick = Changefont1Click
      end
      object Changetextcolor1: TMenuItem
        Caption = 'Change text color'
        ImageIndex = 23
        object Label1: TMenuItem
          Caption = 'Label...'
          OnClick = Label1Click
        end
        object Opcodes1: TMenuItem
          Caption = 'Opcode...'
          OnClick = Opcodes1Click
        end
        object Registers1: TMenuItem
          Caption = 'Register...'
          OnClick = Registers1Click
        end
        object Values1: TMenuItem
          Caption = 'Value...'
          OnClick = Values1Click
        end
        object StringSTR1: TMenuItem
          Caption = 'String (STR)...'
          OnClick = StringSTR1Click
        end
        object StringArgument1: TMenuItem
          Caption = 'String (Argument)...'
          OnClick = StringArgument1Click
        end
      end
      object Changetheme1: TMenuItem
        Caption = 'Change theme'
        Enabled = False
        ImageIndex = 24
        object Default1: TMenuItem
          Tag = -1
          Caption = 'Default'
          OnClick = ChangeTheme
        end
        object N4: TMenuItem
          Caption = '-'
        end
        object Blue1: TMenuItem
          Caption = 'Blue'
          OnClick = ChangeTheme
        end
        object Classic1: TMenuItem
          Tag = 1
          Caption = 'Classic'
          OnClick = ChangeTheme
        end
        object Darcula1: TMenuItem
          Tag = 2
          Caption = 'Darcula'
          OnClick = ChangeTheme
        end
        object DarkIcon1: TMenuItem
          Tag = 3
          Caption = 'Dark Icon'
          OnClick = ChangeTheme
        end
        object Dark1: TMenuItem
          Tag = 4
          Caption = 'Dark'
          OnClick = ChangeTheme
        end
        object Darker1: TMenuItem
          Tag = 5
          Caption = 'Darker'
          OnClick = ChangeTheme
        end
        object Dracula1: TMenuItem
          Tag = 6
          Caption = 'Dracula'
          OnClick = ChangeTheme
        end
        object FluentNight1: TMenuItem
          Tag = 7
          Caption = 'Fluent Night'
          OnClick = ChangeTheme
        end
        object GitHubDark1: TMenuItem
          Tag = 8
          Caption = 'GitHub Dark'
          OnClick = ChangeTheme
        end
        object MonokaiDistilled1: TMenuItem
          Tag = 9
          Caption = 'Monokai Distilled'
          OnClick = ChangeTheme
        end
        object Monokai1: TMenuItem
          Tag = 10
          Caption = 'Monokai'
          OnClick = ChangeTheme
        end
        object Oblivion1: TMenuItem
          Tag = 11
          Caption = 'Oblivion'
          OnClick = ChangeTheme
        end
        object Obsid1: TMenuItem
          Tag = 12
          Caption = 'Obsidian'
          OnClick = ChangeTheme
        end
        object Ocean1: TMenuItem
          Tag = 13
          Caption = 'Ocean'
          OnClick = ChangeTheme
        end
        object Oceanic1: TMenuItem
          Tag = 14
          Caption = 'Oceanic'
          OnClick = ChangeTheme
        end
        object Okaidia1: TMenuItem
          Tag = 15
          Caption = 'Okaidia'
          OnClick = ChangeTheme
        end
        object Purple1: TMenuItem
          Tag = 16
          Caption = 'Purple'
          OnClick = ChangeTheme
        end
        object Twilight1: TMenuItem
          Tag = 17
          Caption = 'Twilight'
          OnClick = ChangeTheme
        end
        object VisualStudioDark1: TMenuItem
          Tag = 18
          Caption = 'Visual Studio Dark'
          OnClick = ChangeTheme
        end
        object VisualStudio1: TMenuItem
          Tag = 19
          Caption = 'Visual Studio'
          OnClick = ChangeTheme
        end
        object Windows11Dark1: TMenuItem
          Tag = 20
          Caption = 'Windows 11 Dark'
          OnClick = ChangeTheme
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Setformattingdefaults1: TMenuItem
        Caption = 'Reset formatting...'
        OnClick = Setformattingdefaults1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Notes1: TMenuItem
        Caption = 'Toggle notes'
        ImageIndex = 4
        ShortCut = 16462
        OnClick = Notes1Click
      end
      object Zoom1: TMenuItem
        Caption = 'Zoom'
        ImageIndex = 21
        object Z100: TMenuItem
          Caption = '100 %'
          OnClick = Z100Click
        end
        object Z125: TMenuItem
          Caption = '125 %'
          Checked = True
          OnClick = Z125Click
        end
        object Z150: TMenuItem
          Caption = '150 %'
          OnClick = Z150Click
        end
        object Z200: TMenuItem
          Caption = '200 %'
          OnClick = Z200Click
        end
        object Z300: TMenuItem
          Caption = '300 %'
          OnClick = Z300Click
        end
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object Opcodes2: TMenuItem
        Caption = 'Opcode list'
        ImageIndex = 1
        OnClick = Opcodes2Click
      end
      object ReservedRegisters1: TMenuItem
        Caption = 'Typical register uses'
        ImageIndex = 1
        OnClick = ReservedRegisters1Click
      end
      object Functions1: TMenuItem
        Caption = 'Common functions'
        ImageIndex = 1
        OnClick = Functions1Click
      end
    end
    object Hotkeys1: TMenuItem
      Caption = '[Hotkeys]'
      Visible = False
      object Addlabel1: TMenuItem
        Caption = 'Add label'
        ShortCut = 16460
        OnClick = Addlabel1Click
      end
      object Addregister1: TMenuItem
        Caption = 'Add register'
        ShortCut = 16466
        OnClick = Addregister1Click
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Pso quest Asm|*.pasm'
    Left = 24
    Top = 80
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.pasm'
    Filter = 'Pso quest Asm|*.pasm'
    Left = 24
    Top = 136
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    Left = 24
    Top = 192
  end
  object ColorDialog1: TColorDialog
    Left = 24
    Top = 248
  end
  object PopupMenu2: TPopupMenu
    Images = Form1.ImageList1
    Left = 344
    Top = 288
    object NotesFont1: TMenuItem
      Caption = 'Change font...'
      ImageIndex = 22
      OnClick = NotesFont1Click
    end
    object NotesText1: TMenuItem
      Caption = 'Change text color...'
      ImageIndex = 23
      OnClick = NotesText1Click
    end
    object NotesBackground1: TMenuItem
      Caption = 'Change background color...'
      ImageIndex = 24
      OnClick = NotesBackground1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object NotesReset1: TMenuItem
      Caption = 'Reset notes formatting...'
      OnClick = NotesReset1Click
    end
  end
end
