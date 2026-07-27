object frmPromoGoodsAddGoodsDlg: TfrmPromoGoodsAddGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1058#1086#1074#1072#1088' '#1076#1083#1103' '#1087#1088#1086#1084#1086' '#1072#1082#1094#1080#1080
  ClientHeight = 328
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 663
    Height = 64
    Title = #1058#1086#1074#1072#1088' '#1076#1083#1103' '#1087#1088#1086#1084#1086' '#1072#1082#1094#1080#1080
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1086#1074#1072#1088' '#1080' '#1077#1075#1086' '#1087#1077#1088#1080#1086#1076' '#1087#1088#1086#1084#1086' '#1072#1082#1094#1080#1080' '#1076#1083#1103' '#1085#1077#1075#1086
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 647
    Height = 197
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 32
      Height = 15
      Caption = #1058#1086#1074#1072#1088
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 88
      Width = 151
      Height = 15
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1076#1083#1103' '#1087#1088#1086#1084#1086' '#1072#1082#1094#1080#1080
    end
    object imgGoodsImage: TcxDBImage
      AlignWithMargins = True
      Left = 444
      Top = 64
      Margins.Left = 12
      Margins.Top = 12
      Margins.Right = 12
      Margins.Bottom = 12
      TabStop = False
      DataBinding.DataField = 'IMAGE'
      DataBinding.DataSource = IBCDataSourceImage
      Properties.Caption = '<'#1053#1077#1090' '#1082#1072#1088#1090#1080#1085#1082#1080'>'
      Properties.GraphicClassName = 'TdxSmartImage'
      Properties.PopupMenuLayout.MenuItems = []
      Properties.ReadOnly = True
      Properties.ShowFocusRect = False
      Style.TextColor = clGray
      TabOrder = 2
      Height = 109
      Width = 187
    end
    object edGOODSID: TcxDBTextEdit
      Left = 12
      Top = 33
      TabStop = False
      DataBinding.DataField = 'GOODSID'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 49
    end
    object deDATA_START: TcxDBDateEdit
      Left = 12
      Top = 105
      DataBinding.DataField = 'DATA_START'
      TabOrder = 3
      Width = 121
    end
    object deDATA_END: TcxDBDateEdit
      Left = 143
      Top = 105
      DataBinding.DataField = 'DATA_END'
      TabOrder = 4
      Width = 121
    end
    object beGOODS_NAME: TcxButtonEdit
      Left = 67
      Top = 33
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
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1090#1086#1074#1072#1088' '#1080#1079' '#1089#1087#1080#1089#1082#1072
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = deGOODS_NAMEPropertiesButtonClick
      TabOrder = 1
      Width = 564
    end
    object cbMakeDefault: TCheckBox
      Left = 12
      Top = 156
      Width = 161
      Height = 17
      Hint = #1057#1076#1077#1083#1072#1090#1100' '#1076#1072#1090#1099' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
  object btnOk: TcxButton
    Left = 445
    Top = 284
    Width = 90
    Height = 29
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 549
    Top = 284
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryImage: TIBCQuery
    SQL.Strings = (
      'SELECT FIRST 1 IMAGE'
      'FROM TS_GOODS_IMAGE'
      'WHERE (DATA_START is NULL) AND (DATA_END is NULL)'
      'ORDER BY ORDERNO')
    MasterFields = 'GOODSID'
    DetailFields = 'GOODSID'
    Left = 560
    Top = 124
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 560
    Top = 72
  end
end
