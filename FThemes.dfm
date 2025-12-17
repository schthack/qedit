object fmThemes: TfmThemes
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set theme'
  ClientHeight = 76
  ClientWidth = 160
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object ComboBox1: TComboBox
    Left = 8
    Top = 8
    Width = 145
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    Sorted = True
    TabOrder = 0
    Text = 'Amakrits'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Amakrits'
      'Amethyst Kamri'
      'Aqua Graphite'
      'Auric'
      'Carbon'
      'Charcoal Dark Slate'
      'Cobalt XEMedia'
      'Cyan Dusk'
      'Cyan Night'
      'Emerald Light Slate'
      'Golden Graphite'
      'Light'
      'Luna'
      'Obsidian'
      'Onyx Blue'
      'Ruby Graphite'
      'Sapphire Kamri'
      'Silver'
      'Smokey Quartz Kamri'
      'Turquoise Gray'
      'Windows')
  end
  object btnCancel: TButton
    Left = 241
    Top = 64
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 1
    TabStop = False
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 41
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
end
