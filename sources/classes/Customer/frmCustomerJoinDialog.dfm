object frmCustomerJoinDlg: TfrmCustomerJoinDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1073#1100#1077#1076#1080#1085#1077#1085#1080#1077' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1086#1074
  ClientHeight = 535
  ClientWidth = 767
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 767
    Height = 64
    Title = #1054#1073#1100#1077#1076#1080#1085#1077#1085#1080#1077' 2-'#1093' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1086#1074
    Text = #1048#1079' '#1076#1074#1091#1093' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1086#1074', '#1086#1089#1090#1072#1085#1077#1090#1100#1089#1103' '#1090#1086#1083#1100#1082#1086' '#1086#1076#1080#1085
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 751
    Height = 405
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
    object Label2: TLabel
      Left = 24
      Top = 24
      Width = 127
      Height = 15
      Caption = #1048#1089#1093#1086#1076#1085#1099#1081' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 28
      Top = 40
      Width = 72
      Height = 15
      Caption = #1059#1076#1072#1083#1103#1077#1084#1099#1081'!!!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object sbSelectSource: TSpeedButton
      Left = 252
      Top = 22
      Width = 85
      Height = 25
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Glyph.Data = {
        32020000424D3202000000000000320100002800000010000000100000000100
        08000000000000010000120B0000120B00003F0000003F00000000000000FFFF
        FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
        6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
        6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
        55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
        4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
        430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
        6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
        7F00A4C17E00B5CD980086B057008DB4610086B55800020202022B2419020202
        020202020202023E3D3831321529231D130C02020202023E33333A3A1534393B
        3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E331334393B
        3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E0E342C2D
        2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F180E272C2D
        2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E07272025
        262D06020202023C09090D0B0E1A2025252606020202023C0309090B07202025
        252506020202023C03030A0F07201B1E252505020202023C16221C111012121E
        1E120402020202373736302A28211513070802020202}
      OnClick = sbSelectSourceClick
    end
    object Label1: TLabel
      Left = 403
      Top = 24
      Width = 124
      Height = 15
      Caption = #1048#1090#1086#1075#1086#1074#1099#1081' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sbSelectTarget: TSpeedButton
      Left = 639
      Top = 22
      Width = 85
      Height = 25
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Glyph.Data = {
        32020000424D3202000000000000320100002800000010000000100000000100
        08000000000000010000120B0000120B00003F0000003F00000000000000FFFF
        FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
        6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
        6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
        55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
        4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
        430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
        6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
        7F00A4C17E00B5CD980086B057008DB4610086B55800020202022B2419020202
        020202020202023E3D3831321529231D130C02020202023E33333A3A1534393B
        3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E331334393B
        3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E0E342C2D
        2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F180E272C2D
        2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E07272025
        262D06020202023C09090D0B0E1A2025252606020202023C0309090B07202025
        252506020202023C03030A0F07201B1E252505020202023C16221C111012121E
        1E120402020202373736302A28211513070802020202}
      OnClick = sbSelectTargetClick
    end
    object SpeedButton1: TSpeedButton
      Left = 347
      Top = 22
      Width = 46
      Height = 33
      Hint = #1055#1086#1084#1077#1085#1103#1090#1100' '#1084#1077#1089#1090#1072#1084#1080
      Caption = '<>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object cxDBVerticalGrid1: TcxDBVerticalGrid
      Left = 20
      Top = 61
      Width = 321
      Height = 300
      OptionsView.ScrollBars = ssNone
      OptionsView.GridLineColor = 13750737
      OptionsView.ShowButtons = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
      TabOrder = 2
      DataController.DataSource = IBCDataSourceSource
      Version = 1
      object cxDBVerticalGrid1DBEditorRow1: TcxDBEditorRow
        Properties.Caption = #1050#1086#1076
        Properties.DataBinding.FieldName = 'CUSTOMERID'
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow2: TcxDBEditorRow
        Properties.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Properties.DataBinding.FieldName = 'DISPLAYNAME'
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow3: TcxDBEditorRow
        Properties.Caption = #1058#1077#1083#1077#1092#1086#1085' 1'
        Properties.DataBinding.FieldName = 'TELEFON1'
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow5: TcxDBEditorRow
        Properties.Caption = #1052#1086#1073#1080#1083#1100#1085#1099#1081
        Properties.DataBinding.FieldName = 'MOBILE'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow6: TcxDBEditorRow
        Properties.Caption = #1045'-'#1052#1101#1081#1083
        Properties.DataBinding.FieldName = 'EMAIL'
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow7: TcxDBEditorRow
        Properties.Caption = #1043#1086#1088#1086#1076
        Properties.DataBinding.FieldName = 'CITY_TITLE'
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow8: TcxDBEditorRow
        Properties.Caption = #1040#1076#1088#1077#1089
        Properties.DataBinding.FieldName = 'ADDRESS'
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow9: TcxDBEditorRow
        Properties.Caption = 'IDEN'
        Properties.DataBinding.FieldName = 'IDEN_NUMBER'
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow10: TcxDBEditorRow
        Properties.Caption = 'VAT'
        Properties.DataBinding.FieldName = 'VAT_NUMBER'
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow11: TcxDBEditorRow
        Properties.Caption = #1040#1076#1088#1077#1089' 2'
        Properties.DataBinding.FieldName = 'ADDRESS2'
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow12: TcxDBEditorRow
        Properties.Caption = #1050#1072#1088#1090#1086#1095#1082#1072
        Properties.DataBinding.FieldName = 'SN'
        ID = 10
        ParentID = -1
        Index = 10
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow13: TcxDBEditorRow
        Properties.Caption = 'Web-'#1083#1086#1075#1080#1085
        Properties.DataBinding.FieldName = 'WEB_LOGIN'
        ID = 11
        ParentID = -1
        Index = 11
        Version = 1
      end
      object cxDBVerticalGrid1DBEditorRow14: TcxDBEditorRow
        Properties.Caption = #1057#1086#1079#1076#1072#1083
        Properties.DataBinding.FieldName = 'USER_NAME'
        Styles.Content = dmAdditions.cxStyle_Goods_GeneralHeader
        ID = 12
        ParentID = -1
        Index = 12
        Version = 1
      end
    end
    object cxDBVerticalGrid2: TcxDBVerticalGrid
      Left = 403
      Top = 61
      Width = 321
      Height = 300
      OptionsView.ScrollBars = ssNone
      OptionsView.GridLineColor = 13750737
      OptionsView.ShowButtons = False
      OptionsBehavior.AllowChangeRecord = False
      OptionsData.Editing = False
      OptionsData.Appending = False
      OptionsData.Deleting = False
      OptionsData.Inserting = False
      Navigator.Buttons.CustomButtons = <>
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
      TabOrder = 3
      DataController.DataSource = IBCDataSourceTarget
      Version = 1
      object cxDBEditorRow1: TcxDBEditorRow
        Properties.Caption = #1050#1086#1076
        Properties.DataBinding.FieldName = 'CUSTOMERID'
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxDBEditorRow2: TcxDBEditorRow
        Properties.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Properties.DataBinding.FieldName = 'DISPLAYNAME'
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxDBEditorRow3: TcxDBEditorRow
        Properties.Caption = #1058#1077#1083#1077#1092#1086#1085' 1'
        Properties.DataBinding.FieldName = 'TELEFON1'
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxDBEditorRow5: TcxDBEditorRow
        Properties.Caption = #1052#1086#1073#1080#1083#1100#1085#1099#1081
        Properties.DataBinding.FieldName = 'MOBILE'
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxDBEditorRow6: TcxDBEditorRow
        Properties.Caption = #1045'-'#1052#1101#1081#1083
        Properties.DataBinding.FieldName = 'EMAIL'
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
      object cxDBEditorRow7: TcxDBEditorRow
        Properties.Caption = #1043#1086#1088#1086#1076
        Properties.DataBinding.FieldName = 'CITY_TITLE'
        ID = 5
        ParentID = -1
        Index = 5
        Version = 1
      end
      object cxDBEditorRow8: TcxDBEditorRow
        Properties.Caption = #1040#1076#1088#1077#1089
        Properties.DataBinding.FieldName = 'ADDRESS'
        ID = 6
        ParentID = -1
        Index = 6
        Version = 1
      end
      object cxDBEditorRow9: TcxDBEditorRow
        Properties.Caption = 'IDEN'
        Properties.DataBinding.FieldName = 'IDEN_NUMBER'
        ID = 7
        ParentID = -1
        Index = 7
        Version = 1
      end
      object cxDBEditorRow10: TcxDBEditorRow
        Properties.Caption = 'VAT'
        Properties.DataBinding.FieldName = 'VAT_NUMBER'
        ID = 8
        ParentID = -1
        Index = 8
        Version = 1
      end
      object cxDBEditorRow11: TcxDBEditorRow
        Properties.Caption = #1040#1076#1088#1077#1089' 2'
        Properties.DataBinding.FieldName = 'ADDRESS2'
        ID = 9
        ParentID = -1
        Index = 9
        Version = 1
      end
      object cxDBEditorRow12: TcxDBEditorRow
        Properties.Caption = #1050#1072#1088#1090#1086#1095#1082#1072
        Properties.DataBinding.FieldName = 'SN'
        ID = 10
        ParentID = -1
        Index = 10
        Version = 1
      end
      object cxDBEditorRow13: TcxDBEditorRow
        Properties.Caption = 'Web-'#1083#1086#1075#1080#1085
        Properties.DataBinding.FieldName = 'WEB_LOGIN'
        ID = 11
        ParentID = -1
        Index = 11
        Version = 1
      end
      object cxDBEditorRow14: TcxDBEditorRow
        Properties.Caption = #1057#1086#1079#1076#1072#1083
        Properties.DataBinding.FieldName = 'USER_NAME'
        Styles.Content = dmAdditions.cxStyle_Goods_GeneralHeader
        ID = 12
        ParentID = -1
        Index = 12
        Version = 1
      end
    end
    object cbShowCreatedNew: TCheckBox
      Left = 403
      Top = 367
      Width = 226
      Height = 17
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072' '#1087#1086#1089#1083#1077' '#1089#1083#1080#1103#1085#1080#1103
      TabOrder = 14
    end
    object cbUpdateName: TCheckBox
      Left = 347
      Top = 84
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object cbUpdatePhone1: TCheckBox
      Left = 347
      Top = 104
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object cbUpdatePhone2: TCheckBox
      Left = 347
      Top = 124
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
    end
    object cbUpdateEMail: TCheckBox
      Left = 347
      Top = 165
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
    end
    object cbUpdateMobile: TCheckBox
      Left = 347
      Top = 144
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object cbUpdateCity: TCheckBox
      Left = 347
      Top = 186
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
    end
    object cbUpdateAddress: TCheckBox
      Left = 347
      Top = 206
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
    end
    object cbUpdateIDEN: TCheckBox
      Left = 347
      Top = 226
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
    end
    object cbUpdateAddress2: TCheckBox
      Left = 347
      Top = 267
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
    end
    object cbUpdateVAT: TCheckBox
      Left = 347
      Top = 246
      Width = 46
      Height = 17
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1101#1090#1086' '#1079#1085#1072#1095#1077#1085#1080#1077
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 12
    end
    object teSourceID: TcxTextEdit
      Left = 176
      Top = 24
      ParentFont = False
      TabOrder = 0
      OnExit = teSourceIDExit
      Width = 73
    end
    object teDestID: TcxTextEdit
      Left = 560
      Top = 24
      ParentFont = False
      TabOrder = 1
      OnExit = teDestIDExit
      Width = 73
    end
  end
  object btnCancel: TcxButton
    Left = 657
    Top = 488
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 553
    Top = 488
    Width = 90
    Height = 29
    Caption = 'Ok'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object IBCDataSourceSource: TIBCDataSource
    DataSet = IBCQuerySource
    Left = 320
    Top = 8
  end
  object IBCQuerySource: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' VW_TS_CUSTOMER.*,'
      
        ' (SELECT FIRST 1 SN FROM TS_CUST_DISCOUNT WHERE TS_CUST_DISCOUNT' +
        '.CUSTOMERID=VW_TS_CUSTOMER.CUSTOMERID AND TS_CUST_DISCOUNT.FLG_E' +
        'NABLED=1),'
      
        ' (SELECT LOGIN FROM TS_CUST_WEB WHERE TS_CUST_WEB.CUSTOMERID=VW_' +
        'TS_CUSTOMER.CUSTOMERID) WEB_LOGIN'
      'FROM VW_TS_CUSTOMER'
      'WHERE CUSTOMERID=:id')
    ReadOnly = True
    Left = 320
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCQueryTarget: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' VW_TS_CUSTOMER.*,'
      
        ' (SELECT FIRST 1 SN FROM TS_CUST_DISCOUNT WHERE TS_CUST_DISCOUNT' +
        '.CUSTOMERID=VW_TS_CUSTOMER.CUSTOMERID AND TS_CUST_DISCOUNT.FLG_E' +
        'NABLED=1),'
      
        ' (SELECT LOGIN FROM TS_CUST_WEB WHERE TS_CUST_WEB.CUSTOMERID=VW_' +
        'TS_CUSTOMER.CUSTOMERID) WEB_LOGIN'
      'FROM VW_TS_CUSTOMER'
      'WHERE CUSTOMERID=:id')
    ReadOnly = True
    Left = 452
    Top = 60
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceTarget: TIBCDataSource
    DataSet = IBCQueryTarget
    Left = 452
    Top = 12
  end
end
