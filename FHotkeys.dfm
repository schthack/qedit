object fmHotkeys: TfmHotkeys
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Placement Modifiers'
  ClientHeight = 211
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 38
    Height = 16
    Caption = '[Ctrl]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 30
    Width = 33
    Height = 16
    Caption = '[Alt]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 52
    Width = 45
    Height = 16
    Caption = '[Shift]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 74
    Width = 26
    Height = 16
    Caption = '[D]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 96
    Width = 24
    Height = 16
    Caption = '[F]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 16
    Top = 118
    Width = 25
    Height = 16
    Caption = '[S]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 83
    Top = 11
    Width = 24
    Height = 13
    Caption = 'Copy'
  end
  object Label8: TLabel
    Left = 83
    Top = 121
    Width = 50
    Height = 13
    Caption = 'Snap align'
  end
  object Label9: TLabel
    Left = 83
    Top = 99
    Width = 141
    Height = 13
    Caption = 'Set at offset selection position'
  end
  object Label10: TLabel
    Left = 83
    Top = 77
    Width = 102
    Height = 13
    Caption = 'Set at default position'
  end
  object Label11: TLabel
    Left = 83
    Top = 33
    Width = 146
    Height = 13
    Caption = 'Disable automatic Y placement'
  end
  object Label12: TLabel
    Left = 83
    Top = 55
    Width = 173
    Height = 13
    Caption = 'Disable automatic section placement'
  end
  object Label13: TLabel
    Left = 16
    Top = 140
    Width = 41
    Height = 16
    Caption = '[Esc]:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label14: TLabel
    Left = 83
    Top = 143
    Width = 85
    Height = 13
    Caption = 'Cancel placement'
  end
  object btnClose: TButton
    Left = 106
    Top = 171
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = btnCloseClick
  end
end
