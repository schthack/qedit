object FPlacementOptions: TFPlacementOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Placement Options'
  ClientHeight = 280
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 64
    Width = 41
    Height = 13
    Caption = 'Offset Z:'
  end
  object Label2: TLabel
    Left = 19
    Top = 37
    Width = 41
    Height = 13
    Caption = 'Offset Y:'
  end
  object Label3: TLabel
    Left = 19
    Top = 10
    Width = 41
    Height = 13
    Caption = 'Offset X:'
  end
  object Label4: TLabel
    Left = 19
    Top = 156
    Width = 47
    Height = 13
    Caption = 'Default Y:'
  end
  object Label5: TLabel
    Left = 19
    Top = 183
    Width = 47
    Height = 13
    Caption = 'Default Z:'
  end
  object Label6: TLabel
    Left = 19
    Top = 129
    Width = 47
    Height = 13
    Caption = 'Default X:'
  end
  object Label7: TLabel
    Left = 19
    Top = 101
    Width = 74
    Height = 13
    Caption = 'Default section:'
  end
  object Bevel1: TBevel
    Left = 19
    Top = 79
    Width = 163
    Height = 13
    Shape = bsBottomLine
  end
  object btnSave: TButton
    Left = 63
    Top = 211
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 7
    OnClick = btnSaveClick
  end
  object seDefaultSect: TSpinEdit
    Left = 109
    Top = 98
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object nbOffsetX: TNumberBox
    Left = 109
    Top = 7
    Width = 73
    Height = 21
    Decimal = 3
    Mode = nbmFloat
    TabOrder = 0
  end
  object nbOffsetY: TNumberBox
    Left = 109
    Top = 34
    Width = 73
    Height = 21
    Decimal = 3
    Mode = nbmFloat
    TabOrder = 1
  end
  object nbOffsetZ: TNumberBox
    Left = 109
    Top = 61
    Width = 73
    Height = 21
    Decimal = 3
    Mode = nbmFloat
    TabOrder = 2
  end
  object nbDefaultZ: TNumberBox
    Left = 109
    Top = 180
    Width = 73
    Height = 21
    Decimal = 3
    Mode = nbmFloat
    TabOrder = 6
  end
  object nbDefaultY: TNumberBox
    Left = 109
    Top = 153
    Width = 73
    Height = 21
    Decimal = 3
    Mode = nbmFloat
    TabOrder = 5
  end
  object nbDefaultX: TNumberBox
    Left = 109
    Top = 126
    Width = 73
    Height = 21
    Decimal = 3
    Mode = nbmFloat
    TabOrder = 4
  end
  object btnReset: TButton
    Left = 63
    Top = 242
    Width = 75
    Height = 25
    Caption = 'Defaults'
    TabOrder = 8
    OnClick = btnResetClick
  end
end
