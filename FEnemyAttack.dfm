object Form25: TForm25
  Left = 306
  Top = 166
  Caption = 'Enemy Attack data'
  ClientHeight = 120
  ClientWidth = 343
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
    Left = 6
    Top = 12
    Width = 166
    Height = 72
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
    RowCount = 4
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    ColWidths = (
      64
      100)
    RowHeights = (
      17
      17
      17
      17)
  end
  object StringGrid2: TStringGrid
    Left = 177
    Top = 12
    Width = 166
    Height = 72
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
    RowCount = 4
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    ColWidths = (
      64
      100)
  end
  object Button1: TButton
    Left = 8
    Top = 94
    Width = 75
    Height = 25
    Caption = 'Load template'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 178
    Top = 94
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 268
    Top = 94
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 4
    OnClick = Button3Click
  end
end
