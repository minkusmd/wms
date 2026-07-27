object frmLocationEditorDlg: TfrmLocationEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1072#1081#1086#1085' '#1080' '#1085#1072#1089#1077#1083#1077#1085#1085#1099#1081' '#1087#1091#1085#1082#1090' '#1076#1083#1103' '#1076#1086#1089#1090#1072#1074#1082#1080
  ClientHeight = 518
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    570
    518)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 570
    Height = 64
    Title = #1056#1072#1081#1086#1085' '#1080' '#1085#1072#1089#1077#1083#1077#1085#1085#1099#1081' '#1087#1091#1085#1082#1090' '#1076#1083#1103' '#1076#1086#1089#1090#1072#1074#1082#1080
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 554
    Height = 391
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 34
      Height = 15
      Caption = #1056#1072#1081#1086#1085
    end
    object Label2: TLabel
      Left = 20
      Top = 53
      Width = 33
      Height = 15
      Caption = #1043#1086#1088#1086#1076
    end
    object Label3: TLabel
      Left = 20
      Top = 108
      Width = 37
      Height = 15
      Caption = #1059#1089#1083#1091#1075#1072
    end
    object Label4: TLabel
      Left = 20
      Top = 157
      Width = 97
      Height = 15
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1074#1088#1077#1084#1077#1085#1080
    end
    object Label5: TLabel
      Left = 288
      Top = 157
      Width = 64
      Height = 15
      Caption = #1042#1088#1077#1084#1103', '#1084#1080#1085
    end
    object Label6: TLabel
      Left = 288
      Top = 186
      Width = 68
      Height = 15
      Caption = #1042#1088#1077#1084#1103', '#1084#1072#1082#1089
    end
    object Label7: TLabel
      Left = 20
      Top = 293
      Width = 88
      Height = 15
      Caption = 'Timpul de livrare'
    end
    object Label8: TLabel
      Left = 288
      Top = 293
      Width = 87
      Height = 15
      Caption = #1042#1088#1077#1084#1103' '#1076#1086#1089#1090#1072#1074#1082#1080
    end
    object SpeedButton1: TSpeedButton
      Left = 333
      Top = 49
      Width = 136
      Height = 23
      Caption = #1042#1089#1077' '#1075#1086#1088#1086#1076#1072' '#1080#1079' '#1088#1072#1081#1086#1085#1072
      OnClick = SpeedButton1Click
    end
    object Label9: TLabel
      Left = 20
      Top = 225
      Width = 58
      Height = 15
      Caption = 'Denumirea'
    end
    object Label10: TLabel
      Left = 288
      Top = 225
      Width = 52
      Height = 15
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    end
    object mmCOMMENTS_ROM: TcxDBMemo
      Left = 20
      Top = 310
      DataBinding.DataField = 'COMMENTS_ROM'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 8
      Width = 241
    end
    object mmCOMMENTS_RUS: TcxDBMemo
      Left = 288
      Top = 310
      DataBinding.DataField = 'COMMENTS_RUS'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 3
      TabOrder = 9
      Width = 241
    end
    object lcbDISTRICTID: TcxDBLookupComboBox
      Left = 68
      Top = 17
      DataBinding.DataField = 'DISTRICTID'
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceDistrict
      Properties.OnEditValueChanged = lcbDISTRICTIDPropertiesEditValueChanged
      TabOrder = 0
      Width = 257
    end
    object lcbCITYID: TcxDBLookupComboBox
      Left = 68
      Top = 49
      DataBinding.DataField = 'CITYID'
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceCity
      TabOrder = 1
      Width = 257
    end
    object cmbTimeUnit: TcxComboBox
      Left = 123
      Top = 153
      Properties.DropDownListStyle = lsFixedList
      Properties.Items.Strings = (
        #1063#1072#1089#1099
        #1044#1085#1080)
      TabOrder = 3
      Text = #1044#1085#1080
      Width = 90
    end
    object seTIME_MIN: TcxDBSpinEdit
      Left = 362
      Top = 154
      DataBinding.DataField = 'TIME_MIN'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 4
      Width = 80
    end
    object seTIME_MAX: TcxDBSpinEdit
      Left = 362
      Top = 183
      DataBinding.DataField = 'TIME_MAX'
      Properties.MaxValue = 99.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 5
      Width = 80
    end
    object beGOODS: TcxButtonEdit
      Left = 68
      Top = 105
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beGOODSPropertiesButtonClick
      TabOrder = 2
      Width = 461
    end
    object edTITLE_ROM: TcxDBTextEdit
      Left = 20
      Top = 242
      DataBinding.DataField = 'TITLE_ROM'
      TabOrder = 6
      Width = 241
    end
    object edTITLE_RUS: TcxDBTextEdit
      Left = 288
      Top = 242
      DataBinding.DataField = 'TITLE_RUS'
      TabOrder = 7
      Width = 241
    end
  end
  object btnOk: TcxButton
    Left = 358
    Top = 474
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 462
    Top = 474
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDistrict: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' TITLE'
      'FROM'
      ' TS_SYSS'
      'WHERE '
      ' PARENTID=3')
    Left = 384
    Top = 112
  end
  object IBCQueryCity: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' TITLE,'
      ' VALUE_INT'
      'FROM'
      ' TS_SYSS'
      'WHERE '
      ' (PARENTID=2)'
      'ORDER BY'
      ' TITLE')
    Left = 500
    Top = 112
  end
  object IBCDataSourceDistrict: TIBCDataSource
    DataSet = IBCQueryDistrict
    Left = 388
    Top = 60
  end
  object IBCDataSourceCity: TIBCDataSource
    DataSet = IBCQueryCity
    Left = 500
    Top = 60
  end
end
