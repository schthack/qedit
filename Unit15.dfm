object Form15: TForm15
  Left = 220
  Top = 163
  BorderStyle = bsDialog
  Caption = 'Monster randomness '
  ClientHeight = 416
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 592
    Height = 416
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Monster position'
      object Label1: TLabel
        Left = 8
        Top = 7
        Width = 36
        Height = 13
        Caption = 'Rooms:'
      end
      object Label2: TLabel
        Left = 148
        Top = 7
        Width = 59
        Height = 13
        Caption = 'Spawn point'
      end
      object ListBox1: TListBox
        Left = 8
        Top = 26
        Width = 129
        Height = 265
        ItemHeight = 13
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnClick = ListBox1Click
        OnDblClick = ListBox1DblClick
      end
      object StringGrid3: TStringGrid
        Left = 148
        Top = 26
        Width = 423
        Height = 267
        ColCount = 9
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        PopupMenu = PopupMenu2
        TabOrder = 1
        OnDrawCell = StringGrid3DrawCell
        OnSelectCell = StringGrid3SelectCell
        OnSetEditText = StringGrid3SetEditText
        ColWidths = (
          29
          70
          70
          70
          64
          64
          64
          64
          111)
      end
      object btnAddRoom: TButton
        Left = 8
        Top = 297
        Width = 129
        Height = 25
        Caption = 'Add room'
        TabOrder = 2
        OnClick = btnAddRoomClick
      end
      object btnEditRoom: TButton
        Left = 8
        Top = 328
        Width = 129
        Height = 25
        Caption = 'Edit room'
        TabOrder = 3
        OnClick = btnEditRoomClick
      end
      object btnDeleteRoom: TButton
        Left = 8
        Top = 359
        Width = 129
        Height = 25
        Caption = 'Delete room'
        TabOrder = 4
        OnClick = btnDeleteRoomClick
      end
      object btnAddEntry: TButton
        Left = 148
        Top = 299
        Width = 75
        Height = 25
        Caption = 'Add entry'
        TabOrder = 5
        OnClick = btnAddEntryClick
      end
      object btnDeleteEntry: TButton
        Left = 229
        Top = 299
        Width = 75
        Height = 25
        Caption = 'Delete entry'
        TabOrder = 6
        OnClick = btnDeleteEntryClick
      end
      object btnSave1: TButton
        Left = 503
        Top = 360
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 7
        OnClick = btnSave1Click
      end
      object btnClose1: TButton
        Left = 422
        Top = 360
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        TabOrder = 8
        OnClick = btnClose1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Enemy configuration'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = 213
        Width = 77
        Height = 13
        Caption = 'Monsters setting'
      end
      object Label4: TLabel
        Left = 6
        Top = 4
        Width = 53
        Height = 13
        Caption = 'Config pool'
      end
      object Bevel1: TBevel
        Left = 6
        Top = 202
        Width = 578
        Height = 50
        Shape = bsTopLine
      end
      object StringGrid1: TStringGrid
        Left = 4
        Top = 20
        Width = 579
        Height = 139
        ColCount = 11
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
        PopupMenu = PopupMenu3
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
        OnSelectCell = StringGrid1SelectCell
        ColWidths = (
          31
          51
          52
          51
          51
          52
          51
          52
          51
          50
          56)
      end
      object StringGrid2: TStringGrid
        Left = 3
        Top = 228
        Width = 333
        Height = 116
        ColCount = 4
        DefaultColWidth = 100
        DefaultRowHeight = 18
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        PopupMenu = PopupMenu4
        TabOrder = 7
        OnDrawCell = StringGrid2DrawCell
        OnMouseUp = StringGrid2MouseUp
        OnSelectCell = StringGrid2SelectCell
        ColWidths = (
          40
          92
          82
          95)
      end
      object btnClose2: TButton
        Left = 422
        Top = 360
        Width = 75
        Height = 25
        Cancel = True
        Caption = 'Cancel'
        TabOrder = 6
        OnClick = btnClose1Click
      end
      object btnSave2: TButton
        Left = 503
        Top = 360
        Width = 75
        Height = 25
        Caption = 'Save'
        TabOrder = 5
        OnClick = btnSave1Click
      end
      object Button1: TButton
        Left = 3
        Top = 165
        Width = 75
        Height = 25
        Caption = 'Add row'
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 3
        Top = 350
        Width = 75
        Height = 25
        Caption = 'Add row'
        TabOrder = 3
        OnClick = Button2Click
      end
      object btnDeleteRow3: TButton
        Left = 84
        Top = 350
        Width = 75
        Height = 25
        Caption = 'Delete row'
        TabOrder = 4
        OnClick = btnDeleteRow3Click
      end
      object btnDeleteRow2: TButton
        Left = 84
        Top = 165
        Width = 75
        Height = 25
        Caption = 'Delete row'
        TabOrder = 2
        OnClick = btnDeleteRow2Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 228
    Top = 16
    object Addroom1: TMenuItem
      Caption = 'Add room...'
      OnClick = Addroom1Click
    end
    object Editroom1: TMenuItem
      Caption = 'Edit room...'
      OnClick = Editroom1Click
    end
    object Deleteroom1: TMenuItem
      Caption = 'Delete room...'
      Enabled = False
      OnClick = Deleteroom1Click
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 308
    Top = 16
    object Addrow1: TMenuItem
      Caption = 'Add entry'
      OnClick = Addrow1Click
    end
    object Deleterow1: TMenuItem
      Caption = 'Delete entry'
      OnClick = Deleterow1Click
    end
  end
  object PopupMenu3: TPopupMenu
    OnPopup = PopupMenu3Popup
    Left = 388
    Top = 16
    object Addrow2: TMenuItem
      Caption = 'Add row'
      OnClick = Addrow2Click
    end
    object Deleterow2: TMenuItem
      Caption = 'Delete row'
      OnClick = Deleterow2Click
    end
  end
  object PopupMenu4: TPopupMenu
    OnPopup = PopupMenu4Popup
    Left = 468
    Top = 16
    object Addrow3: TMenuItem
      Caption = 'Add row'
      OnClick = Addrow3Click
    end
    object Deleterow3: TMenuItem
      Caption = 'Delete row'
      OnClick = Deleterow3Click
    end
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = Timer1Timer
    Left = 356
    Top = 160
  end
end
