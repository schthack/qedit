object fmMonsterType: TfmMonsterType
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Monster type'
  ClientHeight = 90
  ClientWidth = 173
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 156
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 0
  end
  object Button1: TButton
    Left = 89
    Top = 48
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
