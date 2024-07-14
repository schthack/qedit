object Form23: TForm23
  Left = 399
  Top = 293
  BorderStyle = bsToolWindow
  Caption = 'Select the monster'
  ClientHeight = 81
  ClientWidth = 184
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
  object Button1: TButton
    Left = 100
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 14
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 14
    Top = 14
    Width = 159
    Height = 21
    TabOrder = 2
    Text = 'ComboBox1'
  end
end
