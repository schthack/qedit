object Form23: TForm23
  Left = 399
  Top = 293
  BorderStyle = bsToolWindow
  Caption = 'Load enemy data'
  ClientHeight = 119
  ClientWidth = 186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 13
  object Button1: TButton
    Left = 100
    Top = 78
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 14
    Top = 78
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 14
    Top = 14
    Width = 159
    Height = 22
    Style = csOwnerDrawFixed
    Sorted = True
    TabOrder = 0
    OnChange = ComboBox1Change
  end
  object cbIndexType: TComboBox
    Left = 14
    Top = 44
    Width = 159
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 1
    Items.Strings = (
      'Physical'
      'Resist'
      'Attack'
      'Movement')
  end
end
