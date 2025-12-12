object fmRotation: TfmRotation
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set rotation'
  ClientHeight = 79
  ClientWidth = 151
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object btnOK: TButton
    Left = 37
    Top = 41
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object SpinEdit1: TSpinEdit
    Left = 8
    Top = 8
    Width = 135
    Height = 22
    Increment = 4096
    MaxValue = 65536
    MinValue = -65536
    TabOrder = 0
    Value = 0
  end
  object btnCancel: TButton
    Left = 312
    Top = 41
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
