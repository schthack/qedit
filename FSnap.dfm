object FSnapOptions: TFSnapOptions
  Left = 0
  Top = 0
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'Snap Options'
  ClientHeight = 226
  ClientWidth = 185
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
  object Label8: TLabel
    Left = 12
    Top = 130
    Width = 106
    Height = 13
    Caption = 'Snap tolerance (units):'
  end
  object btnSave: TButton
    Left = 50
    Top = 158
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 7
    OnClick = btnSaveClick
  end
  object chkDistancelimit: TCheckBox
    Left = 12
    Top = 104
    Width = 118
    Height = 17
    Caption = 'Anchor limit (units):'
    TabOrder = 4
    OnClick = chkDistancelimitClick
  end
  object seDistanceLimit: TSpinEdit
    Left = 128
    Top = 102
    Width = 41
    Height = 22
    Enabled = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object chkSnapDistance: TCheckBox
    Left = 12
    Top = 35
    Width = 173
    Height = 17
    Caption = 'Match distance'
    TabOrder = 1
  end
  object chkSnapRotate: TCheckBox
    Left = 12
    Top = 58
    Width = 165
    Height = 17
    Caption = 'Match rotation'
    TabOrder = 2
  end
  object btnReset: TButton
    Left = 50
    Top = 189
    Width = 75
    Height = 25
    Caption = 'Defaults'
    TabOrder = 8
    OnClick = btnResetClick
  end
  object seSnapTolerance: TSpinEdit
    Left = 128
    Top = 127
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 6
    Value = 0
  end
  object chkSnap: TCheckBox
    Left = 12
    Top = 12
    Width = 177
    Height = 17
    Caption = 'Snap alignment'
    TabOrder = 0
    OnClick = chkSnapClick
  end
  object chkSnapYValue: TCheckBox
    Left = 12
    Top = 81
    Width = 165
    Height = 17
    Caption = 'Match Y value'
    TabOrder = 3
  end
end
