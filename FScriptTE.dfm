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
      object Setargumentformat1: TMenuItem
        Caption = 'Argument format'
        object Hex1: TMenuItem
          Caption = 'Hex'
          OnClick = Hex1Click
        end
        object Decimal1: TMenuItem
          Caption = 'Decimal'
          OnClick = Decimal1Click
        end
      end
      object Zoom1: TMenuItem
        Caption = 'Zoom'
        object Z100: TMenuItem
          Caption = '100 %'
          Checked = True
          OnClick = Z100Click
        end
        object Z125: TMenuItem
          Caption = '125 %'
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
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 80
    Top = 24
  end
end
