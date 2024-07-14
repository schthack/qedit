object Form8: TForm8
  Left = 307
  Top = 182
  BorderStyle = bsDialog
  Caption = 'Map event'
  ClientHeight = 349
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 137
    Height = 349
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 8
      Width = 31
      Height = 13
      Caption = 'Event:'
    end
    object ListBox1: TListBox
      Left = 6
      Top = 26
      Width = 121
      Height = 231
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = ListBox1DblClick
    end
    object Button1: TButton
      Left = 6
      Top = 260
      Width = 121
      Height = 25
      Caption = 'Test and save'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 6
      Top = 288
      Width = 121
      Height = 25
      Caption = 'Close'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 6
      Top = 316
      Width = 121
      Height = 25
      Caption = 'Cancel'
      TabOrder = 3
      OnClick = Button3Click
    end
  end
  object Memo2: TMemo
    Left = 140
    Top = 26
    Width = 485
    Height = 315
    ScrollBars = ssVertical
    TabOrder = 1
    OnKeyPress = Memo2KeyPress
  end
end
