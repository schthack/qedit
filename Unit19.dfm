object Form19: TForm19
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'Items list manager'
  ClientHeight = 278
  ClientWidth = 524
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
    Top = 24
    Width = 513
    Height = 211
    ColCount = 14
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 65
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
    OnSetEditText = StringGrid1SetEditText
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
  end
  object Button1: TButton
    Left = 440
    Top = 244
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
end
