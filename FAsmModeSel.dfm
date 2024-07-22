object Form34: TForm34
  Left = 0
  Top = 0
  Caption = 'AsmMode'
  ClientHeight = 112
  ClientWidth = 230
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 163
    Height = 13
    Caption = 'Please provide the ASM format by'
  end
  object Label2: TLabel
    Left = 16
    Top = 35
    Width = 132
    Height = 13
    Caption = 'selecting the target version'
  end
  object Button1: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'V2 PC / DC'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 64
    Width = 75
    Height = 25
    Caption = 'V3 GC / BB'
    TabOrder = 1
    OnClick = Button2Click
  end
end
