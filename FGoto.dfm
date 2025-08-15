object fmGoto: TfmGoto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Go To Label'
  ClientHeight = 79
  ClientWidth = 151
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesigned
  OnShow = FormShow
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
    MaxValue = 65535
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object Button1: TButton
    Left = 288
    Top = 24
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Button1'
    TabOrder = 2
    TabStop = False
    OnClick = Button1Click
  end
end
