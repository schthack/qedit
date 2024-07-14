object Form21: TForm21
  Left = 211
  Top = 179
  BorderStyle = bsToolWindow
  Caption = 'Enemy stat'
  ClientHeight = 187
  ClientWidth = 359
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
    Height = 90
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
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
      17)
  end
  object StringGrid2: TStringGrid
    Left = 186
    Top = 12
    Width = 166
    Height = 90
    BorderStyle = bsNone
    ColCount = 2
    DefaultRowHeight = 17
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 1
    ColWidths = (
      64
      100)
  end
  object StringGrid3: TStringGrid
    Left = 6
    Top = 108
    Width = 346
    Height = 40
    BorderStyle = bsNone
    ColCount = 3
    DefaultRowHeight = 19
    FixedCols = 0
    RowCount = 2
    Options = [goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 2
    ColWidths = (
      121
      128
      94)
  end
  object ComboBox1: TComboBox
    Left = 256
    Top = 127
    Width = 96
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvRaised
    TabOrder = 3
    Text = 'None'
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20'
      '21'
      '22'
      '23'
      '24'
      '25'
      '26'
      '27'
      '28'
      '29')
  end
  object Button1: TButton
    Left = 6
    Top = 156
    Width = 75
    Height = 25
    Caption = 'Load template'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 156
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 192
    Top = 156
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
    OnClick = Button3Click
  end
end
