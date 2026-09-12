object frmServiceNewIncidentEditorDlg: TfrmServiceNewIncidentEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Descrierea incidentului'
  ClientHeight = 657
  ClientWidth = 1018
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  DesignSize = (
    1018
    657)
  TextHeight = 15
  object btnOK: TButton
    Left = 798
    Top = 618
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 901
    Top = 618
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 1002
    Height = 113
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 4
      Width = 45
      Height = 15
      Caption = 'Produs *'
    end
    object Label2: TLabel
      Left = 290
      Top = 4
      Width = 88
      Height = 15
      Caption = 'Numar de serie *'
    end
    object Label3: TLabel
      Left = 583
      Top = 4
      Width = 31
      Height = 15
      Caption = 'odel *'
    end
    object Label4: TLabel
      Left = 433
      Top = 4
      Width = 90
      Height = 15
      Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1080#1090#1077#1083#1100'*'
    end
    object Label13: TLabel
      Left = 20
      Top = 50
      Width = 31
      Height = 15
      Caption = 'Client'
    end
    object Label14: TLabel
      Left = 290
      Top = 50
      Width = 38
      Height = 15
      Caption = 'Platitor'
    end
    object Label15: TLabel
      Left = 583
      Top = 50
      Width = 63
      Height = 15
      Caption = 'Responsabil'
    end
    object Label16: TLabel
      Left = 855
      Top = 4
      Width = 92
      Height = 15
      Caption = 'doc vinzare client'
    end
    object Label17: TLabel
      Left = 855
      Top = 50
      Width = 101
      Height = 15
      Caption = 'doc vinzare platitor'
    end
    object edGOODS_SN: TcxDBTextEdit
      Left = 290
      Top = 21
      TabStop = False
      DataBinding.DataField = 'GOODS_SN'
      ParentFont = False
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 127
    end
    object edGOODS_MODEL: TcxDBTextEdit
      Left = 583
      Top = 21
      DataBinding.DataField = 'GOODS_MODEL'
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 250
    end
    object lcbVENDOR_ID: TcxDBLookupComboBox
      Left = 433
      Top = 20
      DataBinding.DataField = 'VENDOR_ID'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceVendors
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 135
    end
    object mmGOODS_TITLE: TcxDBTextEdit
      Left = 20
      Top = 21
      DataBinding.DataField = 'GOODS_TITLE'
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 253
    end
    object edClient: TcxTextEdit
      Left = 20
      Top = 67
      Properties.ReadOnly = True
      TabOrder = 7
      Text = 'edClient'
      Width = 253
    end
    object clbSolvedBy: TcxDBLookupComboBox
      Left = 583
      Top = 66
      DataBinding.DataField = 'SOLVED_BY'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'FULL_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListOptions.SyncMode = True
      Properties.ListSource = IBCDS_USERS
      Properties.OnCloseUp = clbSolvedByPropertiesCloseUp
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 6
      Width = 250
    end
    object beCTSC_NAME: TcxButtonEdit
      Left = 287
      Top = 66
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
      Properties.HideSelection = False
      Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCTSC_NAMEPropertiesButtonClick
      Properties.OnValidate = beCTSC_NAMEPropertiesValidate
      TabOrder = 5
      Width = 281
    end
    object cxDBTextEdit1: TcxDBTextEdit
      Left = 855
      Top = 21
      DataBinding.DataField = 'RASHOD_DOCID'
      ParentFont = False
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 4
      Width = 125
    end
    object cxDBTextEdit2: TcxDBTextEdit
      Left = 855
      Top = 71
      DataBinding.DataField = 'PAYER_RASHOD_DOCID'
      ParentFont = False
      Properties.ReadOnly = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 8
      Width = 125
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 127
    Width = 1002
    Height = 473
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object Label9: TLabel
      Left = 15
      Top = 99
      Width = 96
      Height = 15
      Caption = 'Scopul reparatiei *'
    end
    object lbDefectPresets: TLabel
      Left = 16
      Top = 265
      Width = 169
      Height = 15
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'Descrierea presupusului defect *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16744448
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbDefectPresetsClick
    end
    object Label7: TLabel
      Left = 302
      Top = 99
      Width = 79
      Height = 15
      Caption = 'Complectatia *'
    end
    object lbAspect: TLabel
      Left = 588
      Top = 95
      Width = 169
      Height = 15
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'Aspectul exterior al produsului *'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16744448
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lbAspectClick
    end
    object Label10: TLabel
      Left = 16
      Top = 53
      Width = 132
      Height = 15
      Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
    end
    object Label8: TLabel
      Left = 589
      Top = 290
      Width = 48
      Height = 15
      Caption = 'Descriere'
    end
    object Label5: TLabel
      Left = 666
      Top = 5
      Width = 23
      Height = 15
      Caption = 'data'
    end
    object Label6: TLabel
      Left = 226
      Top = 54
      Width = 115
      Height = 15
      Caption = 'in baza documentului'
    end
    object Label11: TLabel
      Left = 532
      Top = 5
      Width = 58
      Height = 15
      Caption = 'numar doc'
    end
    object Label12: TLabel
      Left = 16
      Top = 5
      Width = 100
      Height = 15
      Caption = 'Tipul incidentului *'
    end
    object Label18: TLabel
      Left = 226
      Top = 3
      Width = 116
      Height = 15
      Caption = 'Categoria de reparatie'
    end
    object mmDEFECTE_DSC: TcxDBMemo
      AlignWithMargins = True
      Left = 15
      Top = 285
      Margins.Left = 0
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 0
      DataBinding.DataField = 'DEFECTE_DSC'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 9
      Height = 172
      Width = 281
    end
    object CheckTreeAIMs: TRzCheckTree
      Left = 15
      Top = 116
      Width = 281
      Height = 141
      Images = dmAdditions.cxImageList_SWN
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HideSelection = False
      Indent = 21
      ParentFont = False
      SelectionPen.Color = clBtnShadow
      ShowRoot = False
      StateImages = CheckTreeAIMs.CheckImages
      TabOrder = 6
      OnChange = CheckTreeAIMsChange
    end
    object mmASPECT_VISUAL_DSC: TcxDBMemo
      Left = 589
      Top = 116
      DataBinding.DataField = 'ASPECT_VISUAL_DSC'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 8
      Height = 168
      Width = 392
    end
    object cxGridGarn: TcxGrid
      Left = 302
      Top = 116
      Width = 281
      Height = 341
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object cxGridGarnTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnRecordChanged = cxGridGarnTableDataControllerRecordChanged
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GridLines = glHorizontal
        OptionsView.GroupByBox = False
        OptionsView.Header = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridGarnID: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridGarnSELECTION: TcxGridColumn
          DataBinding.ValueType = 'Boolean'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGridGarnTITLE: TcxGridColumn
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Options.Editing = False
          Options.Focusing = False
        end
      end
      object cxGridGarnLevel: TcxGridLevel
        GridView = cxGridGarnTable
      end
    end
    object lcbPRIORITY_LEVEL_ID: TcxDBLookupComboBox
      Left = 16
      Top = 70
      DataBinding.DataField = 'PRIORITY_LEVEL_ID'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourcePriority
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 4
      Width = 173
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 589
      Top = 336
      DataBinding.DataField = 'COMMENTS'
      ParentFont = False
      Properties.ReadOnly = True
      Properties.ScrollBars = ssVertical
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 12
      Height = 121
      Width = 392
    end
    object lcbINBAZA_DOC_NAME: TcxDBComboBox
      Left = 226
      Top = 71
      DataBinding.DataField = 'inbaza_doc_name'
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items.Strings = (
        'Certificatului de garantie eliberat de vinzator'
        'Certificatului de garantie eliberat de producator'
        'Factura fiscala')
      TabOrder = 5
      Width = 266
    end
    object edINBAZA_DOCNO: TcxDBTextEdit
      Left = 532
      Top = 22
      DataBinding.DataField = 'INBAZA_DOCNO'
      ParentFont = False
      Properties.ReadOnly = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 116
    end
    object edINBAZA_DATE: TcxDBDateEdit
      Left = 666
      Top = 22
      DataBinding.DataField = 'INBAZA_DATE'
      Properties.PostPopupValueOnTab = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 3
      Width = 116
    end
    object lbcTypeID: TcxDBLookupComboBox
      Left = 16
      Top = 22
      DataBinding.DataField = 'Type_ID'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourcePriority
      Properties.ValidationOptions = [evoRaiseException, evoShowErrorIcon]
      Properties.OnValidate = lbcTypeIDPropertiesValidate
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 173
    end
    object teComments: TcxTextEdit
      Left = 589
      Top = 307
      TabOrder = 11
      Width = 310
    end
    object btnAddComments: TcxButton
      Left = 905
      Top = 306
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 10
      OnClick = btnAddCommentsClick
    end
    object lcbEXEC_PERSONAL_GROUP: TcxDBLookupComboBox
      Left = 226
      Top = 21
      DataBinding.DataField = 'EXEC_PERSONAL_GROUP_ID'
      ParentFont = False
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'GROUPID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDS_EXEC_PERSONAL_GROUP
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 266
    end
  end
  object IBCQueryVendors: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' TITLE'
      'FROM TS_SYSS'
      'WHERE PARENTID=1'
      'ORDER BY TITLE')
    Left = 160
    Top = 247
  end
  object IBCDataSourceVendors: TIBCDataSource
    DataSet = IBCQueryVendors
    Left = 72
    Top = 248
  end
  object IBCQueryPriority: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' SYSSID,'
      ' TITLE'
      'FROM TS_SYSS'
      'WHERE PARENTID=33')
    Left = 176
    Top = 300
  end
  object IBCDataSourcePriority: TIBCDataSource
    DataSet = IBCQueryPriority
    Left = 268
    Top = 204
  end
  object IBC_SYSS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select * from ts_syss where parentid=20'
      'order by syssid')
    Left = 160
    Top = 200
  end
  object IBCDS_SYSS: TIBCDataSource
    DataSet = IBC_SYSS
    Left = 72
    Top = 200
  end
  object IBC_USERS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        '--select * from vw_ts_users where usertype_id IN (7009, 7010, 70' +
        '11) and flg_active=1'
      'select u.* from vw_ts_users u'
      
        'join ts_user_group_links ug on ug.userid=u.userid and ug.groupid' +
        ' in (25, 26, 27, 28, 29)'
      ''
      '')
    Left = 832
    Top = 192
  end
  object IBCDS_USERS: TIBCDataSource
    DataSet = IBC_USERS
    Left = 832
    Top = 144
  end
  object IBCDS_EXEC_PERSONAL_GROUP: TIBCDataSource
    DataSet = IBC_EXEC_PERSONAL_GROUP
    Left = 448
    Top = 312
  end
  object IBC_EXEC_PERSONAL_GROUP: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT *'
      'FROM TS_USER_GROUPS'
      'WHERE GET_FLG_VALUE(FLAGS, 1) = 1'
      'order by groupid')
    Left = 496
    Top = 312
  end
end
