object fmScriptTE: TfmScriptTE
  Left = 0
  Top = 0
  Caption = 'Script Text Editor'
  ClientHeight = 517
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
  OnShow = FormShow
  TextHeight = 13
  object TextEdit: TTextEditor
    Left = 0
    Top = 0
    Width = 794
    Height = 517
    Align = alClient
    Colors.ActiveLineBackground = clBtnFace
    Colors.CodeFoldingActiveLineBackground = clBtnFace
    Colors.EditorStringBackground = clNone
    Colors.EditorStringForeground = clNone
    Colors.SearchHighlighterBackground = clBtnFace
    Colors.SearchMapForeground = clBtnFace
    CompletionProposal.Options = [cpoAutoInvoke, cpoAutoConstraints, cpoAddHighlighterKeywords, cpoFiltered]
    HighlightLine.Items = <
      item
      end>
    LeftMargin.Visible = False
    LeftMargin.Width = 0
    OnChange = TextEditChange
    OnClick = TextEditClick
    OnMouseDown = TextEditMouseDown
    ParentShowHint = False
    RightMargin.Visible = False
    ShowHint = True
    TabOrder = 0
    Tabs.Options = [toColumns, toSelectedBlockIndent, toTabsToSpaces]
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 232
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
    object N1: TMenuItem
      Caption = '-'
    end
    object Undo1: TMenuItem
      Caption = 'Undo'
      ShortCut = 16474
      OnClick = Undo1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 24
    object File1: TMenuItem
      Caption = 'File'
      object Openfromfile1: TMenuItem
        Caption = 'Import from file'
        ShortCut = 16457
        OnClick = Openfromfile1Click
      end
      object Savetofile1: TMenuItem
        Caption = 'Export to file'
        ShortCut = 16467
        OnClick = Savetofile1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Find1: TMenuItem
        Caption = 'Find'
        ShortCut = 16454
        OnClick = Find1Click
      end
      object Replace1: TMenuItem
        Caption = 'Replace'
        ShortCut = 16456
        OnClick = Replace1Click
      end
      object GoToLabel1: TMenuItem
        Caption = 'Go to label'
        ShortCut = 16455
        OnClick = GoToLabel1Click
      end
      object Deleteselection1: TMenuItem
        Caption = 'Delete selection'
        ShortCut = 46
        Visible = False
        OnClick = Deleteselection1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Zoom1: TMenuItem
        Caption = 'Zoom'
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
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 24
    Top = 192
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
end
