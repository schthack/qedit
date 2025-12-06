object Form31: TForm31
  Left = 0
  Top = 0
  Caption = 'Monster and box details'
  ClientHeight = 499
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
    499)
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 516
    Height = 441
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 433
    Top = 456
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Copy: TButton
    Left = 340
    Top = 456
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Copy'
    TabOrder = 2
    OnClick = CopyClick
  end
end
