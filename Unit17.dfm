object Form17: TForm17
  Left = 772
  Top = 196
  BorderStyle = bsDialog
  Caption = '3D Settings'
  ClientHeight = 244
  ClientWidth = 180
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
    Left = 16
    Top = 16
    Width = 58
    Height = 13
    Caption = 'Screen size:'
  end
  object Label2: TLabel
    Left = 16
    Top = 62
    Width = 57
    Height = 13
    Caption = 'Frame skip :'
  end
  object Label4: TLabel
    Left = 16
    Top = 110
    Width = 51
    Height = 13
    Caption = 'Distance : '
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 32
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = '320x240'
    Items.Strings = (
      '320x240'
      '640x480'
      '800x600'
      '1024x768')
  end
  object ComboBox2: TComboBox
    Left = 16
    Top = 80
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = '0'
    Items.Strings = (
      '0'
      '1'
      '2 (not all card)'
      '3 (not all card)')
  end
  object Button1: TButton
    Left = 54
    Top = 212
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ComboBox4: TComboBox
    Left = 16
    Top = 128
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = 'Close'
    Items.Strings = (
      'Close'
      'Medium'
      'Far'
      'Full')
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 160
    Width = 145
    Height = 17
    Caption = 'Use anti-alising'
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 16
    Top = 184
    Width = 147
    Height = 17
    Caption = 'Use Skydome'
    TabOrder = 5
  end
end