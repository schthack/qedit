object Form30: TForm30
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Floor filter'
  ClientHeight = 105
  ClientWidth = 181
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Sort for:'
  end
  object ComboBox1: TComboBox
    Left = 14
    Top = 26
    Width = 159
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 0
    Text = 'V1 - Pso DC'
    Items.Strings = (
      'V1 - Pso DC'
      'V2 - Pso DC/PC'
      'V3 - Pso GC ep 1&2'
      'V4 - Pso BB')
  end
  object Button1: TButton
    Left = 98
    Top = 62
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 14
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
end
