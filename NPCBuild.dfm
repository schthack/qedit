object Form20: TForm20
  Left = 192
  Top = 114
  BorderStyle = bsDialog
  Caption = 'NPC Builder'
  ClientHeight = 319
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 46
    Width = 37
    Height = 13
    Caption = 'Name : '
  end
  object Label2: TLabel
    Left = 40
    Top = 78
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'HUmarl'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 150
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Costume 1/18'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label4: TLabel
    Left = 40
    Top = 198
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Skin 1/4'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label5: TLabel
    Left = 40
    Top = 222
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Face 1/5'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label6: TLabel
    Left = 40
    Top = 246
    Width = 113
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Hair 1/9'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label7: TLabel
    Left = 40
    Top = 102
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Section ID'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label8: TLabel
    Left = 40
    Top = 174
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Face'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label9: TLabel
    Left = 12
    Top = 18
    Width = 20
    Height = 13
    Caption = 'ID : '
  end
  object Label10: TLabel
    Left = 40
    Top = 126
    Width = 137
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'NPC: NONE'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label11: TLabel
    Left = 158
    Top = 270
    Width = 38
    Height = 13
    Caption = 'Label11'
  end
  object Label12: TLabel
    Left = 158
    Top = 292
    Width = 38
    Height = 13
    Caption = 'Label11'
  end
  object Panel1: TPanel
    Left = 226
    Top = 4
    Width = 183
    Height = 275
    Color = clBlack
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 58
    Top = 44
    Width = 119
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvSpace
    BorderStyle = bsNone
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxLength = 15
    ParentFont = False
    TabOrder = 1
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object Panel2: TPanel
    Left = 154
    Top = 244
    Width = 23
    Height = 19
    TabOrder = 2
    OnClick = Panel2Click
  end
  object Button1: TButton
    Left = 180
    Top = 244
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 10
    Top = 244
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 10
    Top = 196
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 180
    Top = 196
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 10
    Top = 220
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 7
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 180
    Top = 220
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 8
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 10
    Top = 148
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 9
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 180
    Top = 148
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 10
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 180
    Top = 76
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 11
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 10
    Top = 76
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 12
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 10
    Top = 100
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 13
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 180
    Top = 100
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 14
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 10
    Top = 172
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 15
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 180
    Top = 172
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 16
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 332
    Top = 286
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 17
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 228
    Top = 286
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 18
    OnClick = Button16Click
  end
  object SpinEdit1: TSpinEdit
    Left = 58
    Top = 14
    Width = 145
    Height = 22
    MaxValue = 65535
    MinValue = 1
    TabOrder = 19
    Value = 1
  end
  object Button17: TButton
    Left = 10
    Top = 124
    Width = 27
    Height = 19
    Caption = '<<'
    TabOrder = 20
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 180
    Top = 124
    Width = 27
    Height = 19
    Caption = '>>'
    TabOrder = 21
    OnClick = Button18Click
  end
  object Panel3: TPanel
    Left = 180
    Top = 44
    Width = 25
    Height = 23
    Color = clWhite
    ParentBackground = False
    TabOrder = 22
    OnClick = Panel3Click
  end
  object TrackBar1: TTrackBar
    Left = 9
    Top = 270
    Width = 144
    Height = 15
    Max = 100
    PageSize = 1
    TabOrder = 23
    ThumbLength = 12
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TrackBar1Change
  end
  object TrackBar2: TTrackBar
    Left = 9
    Top = 290
    Width = 144
    Height = 15
    Max = 100
    PageSize = 1
    TabOrder = 24
    ThumbLength = 12
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TrackBar2Change
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 378
    Top = 6
  end
  object ColorDialog1: TColorDialog
    Left = 378
    Top = 36
  end
end
