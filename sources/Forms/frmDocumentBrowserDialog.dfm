object frmDocumentBrowserDlg: TfrmDocumentBrowserDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridDocs
  BorderIcons = [biSystemMenu]
  Caption = 'Selectarea documentului'
  ClientHeight = 637
  ClientWidth = 844
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 860
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    844
    637)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 844
    Height = 64
    Title = 'Selectarea documentului'
    Text = 'Selectarea documentului. '
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
    ImageIndex = 16
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 828
    Height = 509
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
    TabOrder = 1
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 824
      Height = 121
      Align = alTop
      Shape = bsSpacer
    end
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 75
      Height = 15
      Caption = 'Tip document'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 240
      Top = 16
      Width = 24
      Height = 15
      Caption = 'Data'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 381
      Top = 16
      Width = 67
      Height = 15
      Caption = 'Subdiviziune'
      Transparent = True
    end
    object cxLabel4: TLabel
      Left = 604
      Top = 16
      Width = 44
      Height = 15
      Caption = 'Creat de'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 62
      Width = 31
      Height = 15
      Caption = 'Client'
      Transparent = True
    end
    object lcbDocType: TcxLookupComboBox
      Left = 12
      Top = 33
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'DOCTYPEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceDocTypes
      EditValue = 0
      TabOrder = 0
      Width = 213
    end
    object cmbDate: TcxComboBox
      Left = 240
      Top = 33
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      TabOrder = 1
      Width = 125
    end
    object lcbFirma: TcxLookupComboBox
      Left = 381
      Top = 33
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFirms
      EditValue = 0
      TabOrder = 2
      Width = 208
    end
    object lcbUser: TcxLookupComboBox
      Left = 604
      Top = 33
      Properties.ClearKey = 16430
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          FieldName = 'USER_FULLNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      EditValue = 0
      TabOrder = 3
      Width = 208
    end
    object cxGridDocs: TcxGrid
      AlignWithMargins = True
      Left = 12
      Top = 121
      Width = 800
      Height = 372
      Margins.Left = 12
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 12
      Align = alClient
      TabOrder = 5
      object cxGridDocsDB: TcxGridDBTableView
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        OnCustomDrawCell = cxGridDocsDBCustomDrawCell
        OnFocusedRecordChanged = cxGridDocsDBFocusedRecordChanged
        DataController.DataSource = IBCDataSourceDocs
        DataController.KeyFieldNames = 'DOCID'
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDocsDB_DOCID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 50
        end
        object cxGridDocs_FLG_CLOSED: TcxGridDBColumn
          Caption = #1047#1072#1082#1088#1099#1090
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 46
          Options.HorzSizing = False
          Width = 46
        end
        object cxGridDocsDB_DOCTYPE_NAME: TcxGridDBColumn
          AlternateCaption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Caption = #1058#1080#1087' '#1076#1086#1082
          DataBinding.FieldName = 'DOCTYPE_NAME'
          Visible = False
          Width = 70
        end
        object cxGridDocsDB_DATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          OnGetDisplayText = cxGridDocsDB_DATAGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          SortIndex = 0
          SortOrder = soAscending
          Width = 100
        end
        object cxGridDocsDB_CT_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CT_NAME'
          Styles.Content = dmAdditions.cxStyle_Bold
          VisibleForCustomization = False
          Width = 100
        end
        object cxGridDocsDB_DT_NAME: TcxGridDBColumn
          Caption = 'Subdiviziune'
          DataBinding.FieldName = 'DT_NAME'
          Width = 100
        end
        object cxGridDocsDB_DTDEP_NAME: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          Visible = False
          Width = 60
        end
        object cxGridDocsDB_SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDocsDB_CURRENCY_NAME: TcxGridDBColumn
          Caption = 'Valuta'
          DataBinding.FieldName = 'CURRENCY_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 46
          Options.HorzSizing = False
          Width = 46
        end
        object cxGridDocsDB_RATE: TcxGridDBColumn
          Caption = #1050#1091#1088#1089
          DataBinding.FieldName = 'RATE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.0000'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridDocsDB_FLG_ACNT: TcxGridDBColumn
          Caption = #1041#1091#1093
          DataBinding.FieldName = 'FLG_ACNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGridDocsDB_CREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Creat de...'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          MinWidth = 100
          Options.HorzSizing = False
          Width = 100
        end
      end
      object cxGridGoodsTable: TcxGridDBTableView
        DataController.DataSource = IBCDataSourceJurnal
        DataController.DetailKeyFieldNames = 'DOCID'
        DataController.MasterKeyFieldNames = 'DOCID'
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoods_IMG: TcxGridDBColumn
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.HorzSizing = False
          Width = 24
        end
        object cxGridGoods_DEP_NAME: TcxGridDBColumn
          Caption = 'Depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          Width = 100
        end
        object cxGridGoods_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoods_GOODS_NAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'GOODS_NAME'
        end
        object cxGridGoods_UM_NAME: TcxGridDBColumn
          Caption = #1045#1048
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          Properties.Alignment.Vert = taVCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridGoods_QTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
      end
      object cxGridDocsLevel: TcxGridLevel
        GridView = cxGridDocsDB
        object cxGridGoodsLevel: TcxGridLevel
          GridView = cxGridGoodsTable
        end
      end
    end
    object beCT: TcxButtonEdit
      Left = 12
      Top = 82
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF008C8C8CFF5757
            57FF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00ABABABFF737589FFAA87
            8EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0089B0CAFF4088DFFF7376
            A8FFAD898EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BDE3FFFF52B8FFFF4385
            D9FF7979A7FFAD898EFF5F5B5BFF777777FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A5D8FFFF53B9
            FFFF4385D9FF7979A7FFAD898EFF5F5B5BFF969696FFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008CCC
            FFFF53B8FEFF4483D6FF7979A7FF987D82FF818181FFA1A1A1FF6C6C6CFF5757
            57FF575757FF626262FF8C8C8CFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF008ECEFFFF53B8FEFF588CCFFF8B8B8EFF8B7575FFBC9A86FFCEB096FFE0C7
            AEFFD2B4A4FF8B7472FF575757FF8C8C8CFFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00A5D8FFFFC9D0D4FFAB8B88FFF1CFA9FFFFF5C5FFFFFDD1FFFFFF
            DBFFFFFFDCFFF5EFE0FF9F8581FF575757FF8C8C8CFFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00E2CECEFFEFC9A6FFFFF2C0FFFFF7C4FFFFFFD8FFFFFF
            E8FFFFFFF8FFFFFFFFFFF3EDDAFF7B6161FF6C6C6CFFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00E0BDB3FFFFF1C2FFFFE4B1FFFFF9C6FFFFFFDBFFFFFF
            ECFFFFFFFBFFFFFFF7FFFFFFDAFFB79E8CFF575757FFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00E5BDA3FFFFF5C9FFFFDDAAFFFFF5C2FFFFFFD6FFFFFF
            E5FFFFFFECFFFFFFE7FFFFFFD9FFCCB299FF575757FFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00E5BFA6FFFFF5C9FFFFE6B9FFFFEFBCFFFFFFCDFFFFFF
            D7FFFFFFDBFFFFFFD8FFFFFCD1FFCCAC93FF6C6C6CFFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00E0C0B6FFFFF6CDFFFFF2D7FFFFE3B9FFFFF1BFFFFFF5
            C2FFFFF9C7FFFFF7C4FFFFF6C6FFB79481FF8C8C8CFFFF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00DCC5C5FFEFDAC2FFFFFFFFFFFFF7EAFFFFECBFFFFFDF
            ACFFFFE3B0FFFFF0BDFFF3D2A8FF907676FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00D8BCBAFFF1E5DDFFFFFBE8FFFFF8CDFFFFEE
            BCFFFFF3C6FFF5CFA4FFB9938AFFFF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00DCC5C5FFD2B19EFFCEA88EFFE0B8
            9EFFDCB3A0FF8C8C8CFFFF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
          Stretchable = False
        end>
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCTPropertiesButtonClick
      TabOrder = 4
      Width = 353
    end
  end
  object btnCancel: TcxButton
    Left = 729
    Top = 592
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 627
    Top = 592
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object IBCDataSourceFirms: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryFirms
    Left = 512
    Top = 248
  end
  object IBCQueryFirms: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    CUSTOMERID,'
      '    DISPLAYNAME'
      'FROM'
      '    GET_FIRMS_BY_USER2 '
      'ORDER BY '
      '    DISPLAYNAME')
    ReadOnly = True
    Options.BooleanDomainFields = True
    Left = 416
    Top = 232
  end
  object IBCDataSourceDocTypes: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryDocTypes
    Left = 72
    Top = 188
  end
  object IBCQueryDocTypes: TIBCQuery
    SQL.Strings = (
      'SELECT'
      '    DOCTYPEID,'
      '    TITLE'
      'FROM'
      '    GET_DOCTYPES_BY_USER2')
    ReadOnly = True
    Options.BooleanDomainFields = True
    Left = 72
    Top = 236
  end
  object IBCQueryUsers: TIBCQuery
    SQL.Strings = (
      'SELECT'
      ' USERID,'
      ' USER_FULLNAME'
      'FROM'
      ' GET_USERS_BY_USER2(1)')
    ReadOnly = True
    Options.BooleanDomainFields = True
    Left = 616
    Top = 236
  end
  object IBCDataSourceUsers: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryUsers
    Left = 616
    Top = 188
  end
  object IBCQueryDocs: TIBCQuery
    UpdatingTable = 'VW_TDB_DOCS'
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_DOCS'
      'ORDER BY DATA')
    AutoCommit = False
    Options.BooleanDomainFields = True
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 188
    Top = 324
  end
  object IBCDataSourceDocs: TIBCDataSource
    DataSet = IBCQueryDocs
    Left = 188
    Top = 276
  end
  object IBCQueryJurnal: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT * FROM VW_TDB_JURNAL WHERE GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocs
    AutoCommit = False
    Options.DetailDelay = 50
    Left = 300
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 300
    Top = 296
  end
end
