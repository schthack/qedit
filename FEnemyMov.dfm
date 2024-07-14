object Form26: TForm26
  Left = 278
  Top = 194
  BorderStyle = bsDialog
  Caption = 'Enemy mouvement edit'
  ClientHeight = 164
  ClientWidth = 365
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
    Left = 10
    Top = 12
    Width = 166
    Height = 108
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
    RowCount = 6
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
      17
      17
      17)
  end
  object StringGrid2: TStringGrid
    Left = 188
    Top = 12
    Width = 166
    Height = 108
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
    RowCount = 6
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    ColWidths = (
      64
      100)
    RowHeights = (
      17
      17
      17
      17
      17
      17)
  end
  object Button1: TButton
    Left = 278
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 196
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 10
    Top = 130
    Width = 75
    Height = 25
    Caption = 'Load template'
    TabOrder = 4
    OnClick = Button3Click
  end
end
