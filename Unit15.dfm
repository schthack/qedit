object Form15: TForm15
  Left = 220
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Monster randomness '
  ClientHeight = 335
  ClientWidth = 597
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 597
    Height = 335
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Monster position'
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 36
        Height = 13
        Caption = 'Rooms:'
      end
      object Label2: TLabel
        Left = 150
        Top = 8
        Width = 59
        Height = 13
        Caption = 'Spawn point'
      end
      object ListBox1: TListBox
        Left = 8
        Top = 26
        Width = 129
        Height = 265
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox1Click
      end
      object StringGrid3: TStringGrid
        Left = 148
        Top = 26
        Width = 423
        Height = 267
        ColCount = 9
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
        OnDrawCell = StringGrid3DrawCell
        ColWidths = (
          29
          70
          70
          70
          64
          64
          64
          64
          64)
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Enemy configuration'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = 166
        Width = 77
        Height = 13
        Caption = 'Monsters setting'
      end
      object Label4: TLabel
        Left = 6
        Top = 4
        Width = 53
        Height = 13
        Caption = 'Config pool'
      end
      object StringGrid1: TStringGrid
        Left = 4
        Top = 20
        Width = 579
        Height = 139
        ColCount = 10
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        OnSetEditText = StringGrid1SetEditText
        ColWidths = (
          31
          51
          52
          51
          51
          52
          51
          52
          51
          50)
      end
      object StringGrid2: TStringGrid
        Left = 4
        Top = 182
        Width = 333
        Height = 116
        ColCount = 4
        DefaultColWidth = 100
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
        OnDrawCell = StringGrid2DrawCell
        OnSetEditText = StringGrid2SetEditText
        ColWidths = (
          40
          92
          82
          100)
      end
    end
  end
end
