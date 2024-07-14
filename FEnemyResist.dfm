object Form24: TForm24
  Left = 253
  Top = 151
  BorderStyle = bsToolWindow
  Caption = 'Enemy resistance'
  ClientHeight = 182
  ClientWidth = 205
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 14
    Top = 12
    Width = 176
    Height = 90
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    ColWidths = (
      64
      110)
  end
  object Button1: TButton
    Left = 14
    Top = 110
    Width = 177
    Height = 25
    Caption = 'Load template'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 14
    Top = 150
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 116
    Top = 150
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 3
    OnClick = Button3Click
  end
end
