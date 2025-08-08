object fmReplace: TfmReplace
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Replace Text'
  ClientHeight = 209
  ClientWidth = 219
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Replace text:'
  end
  object Label2: TLabel
    Left = 16
    Top = 60
    Width = 65
    Height = 13
    Caption = 'Replace with:'
  end
  object Edit1: TEdit
    Left = 16
    Top = 27
    Width = 185
    Height = 21
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 28
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object chkMatchCase: TCheckBox
    Left = 16
    Top = 113
    Width = 97
    Height = 17
    Caption = 'Match case'
    TabOrder = 2
  end
  object btnClose: TButton
    Left = 116
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 4
    OnClick = btnCloseClick
  end
  object Edit2: TEdit
    Left = 16
    Top = 79
    Width = 185
    Height = 21
    TabOrder = 1
  end
  object chkSelection: TCheckBox
    Left = 16
    Top = 136
    Width = 113
    Height = 17
    Caption = 'Selection only'
    TabOrder = 5
  end
end
