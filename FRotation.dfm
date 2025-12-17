object fmRotation: TfmRotation
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set rotation'
  ClientHeight = 176
  ClientWidth = 151
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 13
  object Image1: TImage
    Left = 24
    Top = 8
    Width = 105
    Height = 93
    OnMouseDown = Image1MouseDown
  end
  object btnOK: TButton
    Left = 40
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 312
    Top = 41
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object chkAutoAxis: TCheckBox
    Left = 44
    Top = 108
    Width = 75
    Height = 17
    Caption = 'Auto-axis'
    TabOrder = 2
    OnMouseUp = chkAutoAxisMouseUp
  end
end
