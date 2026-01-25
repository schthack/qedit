object Form31: TForm31
  Left = 0
  Top = 0
  Caption = 'Monster and box details'
  ClientHeight = 487
  ClientWidth = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    516
    487)
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 516
    Height = 429
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 425
    Top = 446
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Copy: TButton
    Left = 344
    Top = 446
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Copy'
    TabOrder = 2
    OnClick = CopyClick
  end
  object Button2: TButton
    Left = 263
    Top = 446
    Width = 75
    Height = 25
    Caption = 'Export'
    TabOrder = 3
    Visible = False
    OnClick = Button2Click
  end
  object cbShow: TComboBox
    Left = 17
    Top = 448
    Width = 121
    Height = 22
    Style = csOwnerDrawFixed
    Anchors = [akLeft, akBottom]
    ItemIndex = 0
    TabOrder = 4
    Text = 'Monsters and boxes'
    OnChange = cbShowChange
    Items.Strings = (
      'Monsters and boxes'
      'Monsters only'
      'Boxes only')
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 'Text files|*.txt'
    Left = 248
    Top = 200
  end
end
