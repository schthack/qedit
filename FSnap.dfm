object FSnapOptions: TFSnapOptions
  Left = 0
  Top = 0
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'Snap Options'
  ClientHeight = 234
  ClientWidth = 177
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Label8: TLabel
    Left = 12
    Top = 136
    Width = 106
    Height = 13
    Caption = 'Snap tolerance (units):'
  end
  object btnSave: TButton
    Left = 50
    Top = 165
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object chkDistancelimit: TCheckBox
    Left = 12
    Top = 104
    Width = 118
    Height = 17
    Caption = 'Anchor limit (units):'
    TabOrder = 3
    OnClick = chkDistancelimitClick
  end
  object seDistanceLimit: TSpinEdit
    Left = 124
    Top = 102
    Width = 41
    Height = 22
    Enabled = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 0
  end
  object chkSnapDistance: TCheckBox
    Left = 12
    Top = 42
    Width = 98
    Height = 17
    Caption = 'Match distance'
    TabOrder = 1
  end
  object chkSnapRotate: TCheckBox
    Left = 12
    Top = 73
    Width = 98
    Height = 17
    Caption = 'Match rotation'
    TabOrder = 2
  end
  object btnReset: TButton
    Left = 50
    Top = 196
    Width = 75
    Height = 25
    Caption = 'Defaults'
    TabOrder = 7
    OnClick = btnResetClick
  end
  object seSnapTolerance: TSpinEdit
    Left = 124
    Top = 133
    Width = 41
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object chkSnap: TCheckBox
    Left = 12
    Top = 11
    Width = 118
    Height = 17
    Caption = 'Snap alignment'
    TabOrder = 0
    OnClick = chkSnapClick
  end
end
