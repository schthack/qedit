object Form12: TForm12
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Quest files manager'
  ClientHeight = 235
  ClientWidth = 422
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
    Width = 24
    Height = 13
    Caption = 'Files:'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 251
    Height = 203
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 280
    Top = 204
    Width = 131
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 24
    Width = 131
    Height = 25
    Caption = 'Export'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 280
    Top = 52
    Width = 131
    Height = 25
    Caption = 'Import'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 280
    Top = 80
    Width = 131
    Height = 25
    Caption = 'Add'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 280
    Top = 108
    Width = 131
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 280
    Top = 152
    Width = 131
    Height = 25
    Caption = 'Save to quest'
    TabOrder = 6
    OnClick = Button6Click
  end
  object SaveDialog1: TSaveDialog
    Left = 286
    Top = 142
  end
  object OpenDialog1: TOpenDialog
    Left = 328
    Top = 144
  end
end
