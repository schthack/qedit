object Form2: TForm2
  Left = 244
  Top = 199
  BorderStyle = bsDialog
  Caption = 'Quest propertie'
  ClientHeight = 307
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 65
    Height = 13
    Caption = 'Quest Name :'
  end
  object Label2: TLabel
    Left = 12
    Top = 62
    Width = 88
    Height = 13
    Caption = 'Quest description :'
  end
  object Label3: TLabel
    Left = 10
    Top = 164
    Width = 62
    Height = 13
    Caption = 'Quest detail :'
  end
  object Edit1: TEdit
    Left = 10
    Top = 28
    Width = 235
    Height = 21
    MaxLength = 32
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 10
    Top = 80
    Width = 235
    Height = 71
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 10
    Top = 182
    Width = 235
    Height = 89
    TabOrder = 2
  end
  object Button1: TButton
    Left = 172
    Top = 278
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 10
    Top = 278
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
  end
end
