object Form3: TForm3
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Quest Information'
  ClientHeight = 165
  ClientWidth = 154
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
    Left = 10
    Top = 6
    Width = 61
    Height = 13
    Caption = 'Information : '
  end
  object Button1: TButton
    Left = 36
    Top = 132
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object UnicodeMemo1: TMemo
    Left = 8
    Top = 26
    Width = 135
    Height = 97
    TabOrder = 1
  end
end
