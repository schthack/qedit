object Form22: TForm22
  Left = 263
  Top = 158
  BorderStyle = bsToolWindow
  Caption = 'Load template'
  ClientHeight = 141
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 12
    Width = 49
    Height = 13
    Caption = 'Database:'
  end
  object Label2: TLabel
    Left = 10
    Top = 76
    Width = 38
    Height = 13
    Caption = 'Monster'
  end
  object Label3: TLabel
    Left = 10
    Top = 44
    Width = 40
    Height = 13
    Caption = 'Dificulty:'
  end
  object ComboBox1: TComboBox
    Left = 70
    Top = 8
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 0
    Text = 'V2 Offline'
    OnChange = ComboBox1Change
    Items.Strings = (
      'V2 Offline'
      'V2 Online'
      'V3 Ep1 Offline '
      'V3 Ep1 Online '
      'V3 Ep2 Offline '
      'V3 Ep2 Online ')
  end
  object ComboBox2: TComboBox
    Left = 70
    Top = 40
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 1
    Text = 'Normal'
    Items.Strings = (
      'Normal'
      'Hard'
      'V-Hard'
      'Ult')
  end
  object ComboBox3: TComboBox
    Left = 70
    Top = 72
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    Sorted = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 60
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 140
    Top = 108
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = Button2Click
  end
end
