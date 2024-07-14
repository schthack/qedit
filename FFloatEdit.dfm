object Form28: TForm28
  Left = 281
  Top = 146
  BorderStyle = bsDialog
  Caption = 'Float data editor '
  ClientHeight = 298
  ClientWidth = 291
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
    Top = 8
    Width = 270
    Height = 247
    ColCount = 2
    DefaultRowHeight = 18
    RowCount = 500
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    ColWidths = (
      80
      163)
  end
  object Button1: TButton
    Left = 122
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 206
    Top = 264
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button2Click
  end
end
