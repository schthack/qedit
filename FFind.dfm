object fmFind: TfmFind
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Find Text'
  ClientHeight = 118
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 16
    Width = 185
    Height = 21
    TabOrder = 0
  end
  object btnOK: TButton
    Left = 23
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object chkMatchCase: TCheckBox
    Left = 8
    Top = 51
    Width = 97
    Height = 17
    Caption = 'Match case'
    TabOrder = 1
  end
  object btnClose: TButton
    Left = 104
    Top = 80
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 3
    OnClick = btnCloseClick
  end
end
