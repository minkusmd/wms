object frmDocumentImportBrowserDlg: TfrmDocumentImportBrowserDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridNPN
  BorderIcons = [biSystemMenu]
  Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  ClientHeight = 812
  ClientWidth = 1090
  Color = clBtnFace
  Constraints.MinHeight = 670
  Constraints.MinWidth = 840
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1090
    Height = 64
    Title = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1086#1082#1091#1084#1077#1085#1090' '#1080#1079' '#1082#1086#1090#1086#1088#1086#1075#1086' '#1073#1091#1076#1091#1090' '#1080#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1085#1085#1099' '#1090#1086#1074#1072#1088#1099
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
    Width = 1074
    Height = 679
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxGridNPN: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 73
      Width = 1054
      Height = 338
      Margins.Left = 8
      Margins.Top = 0
      Margins.Right = 8
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 1
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridNPNTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
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
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCustomDrawCell = cxGridNPNTableCustomDrawCell
        DataController.DataSource = IBCDataSourceDocsLocal
        DataController.KeyFieldNames = 'DOCID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.GroupRowStyle = grsOffice11
        OptionsView.Indicator = True
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridNPNTableDocID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'DOCID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Filtering = False
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridNPNTableData: TcxGridDBColumn
          Caption = #1044#1072#1090#1072
          DataBinding.FieldName = 'DATA'
          DataBinding.IsNullValueType = True
          OnGetDisplayText = cxGridNPNTableDataGetDisplayText
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridNPNTableWarehouse: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 100
        end
        object cxGridNPNTable_DT_NAME: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'DT_NAME'
          DataBinding.IsNullValueType = True
          Width = 140
        end
        object cxGridNPNCol_CT_NAME: TcxGridDBColumn
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          DataBinding.FieldName = 'CT_NAME'
          DataBinding.IsNullValueType = True
          Styles.Content = dmAdditions.cxStyle_GridColumnBOLD
          Width = 200
        end
        object cxGridNPNTableSuma: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.FieldName = 'SUMA'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Grouping = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 70
        end
        object cxGridNPNTableCurrencyName: TcxGridDBColumn
          Caption = #1042#1072#1083#1102#1090#1072
          DataBinding.FieldName = 'CURRENCY_NAME'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridNPNTableVAT: TcxGridDBColumn
          Caption = #1053#1044#1057
          DataBinding.FieldName = 'VAT'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Filtering = False
          Options.Grouping = False
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 70
        end
        object cxGridNPNTableRate: TcxGridDBColumn
          Caption = #1050#1091#1088#1089' '#1044#1086#1082'.'
          DataBinding.FieldName = 'RATE'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridNPNTableParentDocID: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1088#1086#1076'.'
          DataBinding.FieldName = 'PARENTDOCID'
          DataBinding.IsNullValueType = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridNPN_FLG_ACNT: TcxGridDBColumn
          Caption = #1041#1091#1093#1075
          DataBinding.FieldName = 'FLG_ACNT'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridNPNTable_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridNPN_FLG_SHIP: TcxGridDBColumn
          Caption = #1047#1072#1082#1088#1099#1090
          DataBinding.FieldName = 'FLG_SHIP'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
      end
      object cxGridNPNLevel: TcxGridLevel
        GridView = cxGridNPNTable
      end
    end
    object cxGridComponents: TcxGrid
      AlignWithMargins = True
      Left = 8
      Top = 413
      Width = 1054
      Height = 254
      Margins.Left = 8
      Margins.Top = 2
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alBottom
      TabOrder = 2
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridGoodsTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
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
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceJurnalLocal
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridDBCol_QTY
          end
          item
            Kind = skSum
            FieldName = 'SUMA'
          end
          item
            Kind = skSum
            FieldName = 'SUMAVAT'
          end
          item
            Kind = skCount
            Column = cxGridDBCol_GOODSID
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_GridHeader
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = #1057#1082#1083#1072#1076
          DataBinding.FieldName = 'DTDEP_NAME'
          DataBinding.IsNullValueType = True
          MinWidth = 140
          Options.HorzSizing = False
          Width = 140
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076
          DataBinding.FieldName = 'GOODSID'
          DataBinding.IsNullValueType = True
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 12
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <
            item
              ImageIndex = 44
              Value = 4203
            end>
          MinWidth = 26
          Options.Editing = False
          Options.Filtering = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 26
          IsCaptionAssigned = True
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DataBinding.FieldName = 'GOODS_NAME'
          DataBinding.IsNullValueType = True
          Width = 200
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.FieldName = 'QTY'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.Filtering = False
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          Caption = #1045#1048
          DataBinding.FieldName = 'UM_NAME'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.Filtering = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 60
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
    object pnSettings: TPanel
      Left = 0
      Top = 0
      Width = 1070
      Height = 73
      Align = alTop
      BevelOuter = bvNone
      Color = clWindow
      TabOrder = 0
      object cxLabel2: TLabel
        Left = 280
        Top = 16
        Width = 25
        Height = 15
        Caption = #1044#1072#1090#1072
        Transparent = True
      end
      object Label1: TLabel
        Left = 8
        Top = 16
        Width = 81
        Height = 15
        Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      end
      object lcbDocType: TcxLookupComboBox
        Left = 8
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
        Width = 253
      end
      object cmbDate: TcxComboBox
        Left = 280
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.ImmediatePost = True
        TabOrder = 1
        Width = 125
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 759
    Width = 1090
    Height = 53
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1090
      53)
    object btnOk: TcxButton
      Left = 878
      Top = 8
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = '&Ok'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 979
      Top = 8
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Toolbar')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 548
    Top = 8
    PixelsPerInch = 96
    object bbRefresh: TdxBarButton
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Category = 0
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 36
    end
    object beDateStart: TcxBarEditItem
      Caption = #1055#1077#1088#1080#1086#1076
      Category = 0
      Hint = #1055#1077#1088#1080#1086#1076
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      InternalEditValue = 0d
    end
    object beDateEnd: TcxBarEditItem
      Caption = #1087#1086
      Category = 0
      Hint = #1087#1086
      Visible = ivAlways
      ShowCaption = True
      PropertiesClassName = 'TcxDateEditProperties'
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      InternalEditValue = 0d
    end
  end
  object IBCQueryDocsLocal: TIBCQuery
    KeyFields = 'DOCID'
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_DOCS'
      'ORDER BY DOCTYPEID,DOCID')
    ReadOnly = True
    Left = 132
    Top = 208
  end
  object IBCDataSourceDocsLocal: TIBCDataSource
    DataSet = IBCQueryDocsLocal
    Left = 132
    Top = 160
  end
  object IBCQueryJurnalLocal: TIBCQuery
    DMLRefresh = True
    SQL.Strings = (
      'SELECT'
      ' *'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceDocsLocal
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Options.DetailDelay = 500
    Left = 272
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalLocal: TIBCDataSource
    DataSet = IBCQueryJurnalLocal
    Left = 272
    Top = 160
  end
  object IBCDataSourceDocTypes: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryDocTypes
    Left = 28
    Top = 168
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
    Left = 28
    Top = 216
  end
end
