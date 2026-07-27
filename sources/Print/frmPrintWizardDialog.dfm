object frmPrintWizardDlg: TfrmPrintWizardDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tipar'
  ClientHeight = 465
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 677
    Height = 59
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Title = 'Tipar'
    Text = 'Tipar si managementul rapoartelor'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontTitle.Quality = fqClearType
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    FontText.Quality = fqClearType
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 8
  end
  object btnBack: TcxButton
    Left = 236
    Top = 427
    Width = 90
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '<< Inapoi'
    LookAndFeel.NativeStyle = True
    TabOrder = 5
    OnClick = btnBackClick
  end
  object btnNext: TcxButton
    Left = 338
    Top = 427
    Width = 90
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Inainte >>'
    TabOrder = 2
    OnClick = btnNextClick
  end
  object btnPrint: TcxButton
    Left = 459
    Top = 427
    Width = 90
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Tipar'
    Default = True
    LookAndFeel.NativeStyle = True
    TabOrder = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = btnPrintClick
  end
  object btnClose: TcxButton
    Left = 561
    Top = 427
    Width = 90
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Cancel = True
    Caption = 'Inchide'
    LookAndFeel.NativeStyle = True
    ModalResult = 2
    TabOrder = 4
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 6
    Top = 65
    Width = 665
    Height = 347
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cxPageControl: TcxPageControl
      AlignWithMargins = True
      Left = 2
      Top = 28
      Width = 663
      Height = 319
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Focusable = False
      TabOrder = 1
      Properties.ActivePage = tbsReports
      Properties.CustomButtons.Buttons = <>
      Properties.TabPosition = tpBottom
      OnChange = cxPageControlChange
      ClientRectBottom = 293
      ClientRectLeft = 4
      ClientRectRight = 659
      ClientRectTop = 4
      object tbsReports: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Rapoarte'
        ImageIndex = 0
        object cxGridReports: TcxGrid
          Left = 0
          Top = 0
          Width = 655
          Height = 289
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 0
          LookAndFeel.Kind = lfOffice11
          LookAndFeel.NativeStyle = True
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxGridReportsTable: TcxGridDBTableView
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
            OnCellDblClick = cxGridReportsTableCellDblClick
            OnFocusedRecordChanged = cxGridReportsTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceReports
            DataController.KeyFieldNames = 'REPORTID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            DataController.OnDataChanged = cxGridReportsTableDataControllerDataChanged
            OptionsBehavior.IncSearch = True
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1086#1090#1095#1077#1090#1086#1074'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.ShowEditButtons = gsebForFocusedRecord
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            Styles.OnGetContentStyle = cxGridReportsTableStylesGetContentStyle
            Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
            Styles.GroupSummary = dmAdditions.cxStyle_ChatUnread
            Styles.Header = dmAdditions.cxStyle_GridHeader
            Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
            Styles.OnGetGroupStyle = cxGridReportsTableStylesGetGroupStyle
            object cxGridReports_DT: TcxGridDBColumn
              Caption = #1060#1080#1088#1084#1072
              DataBinding.FieldName = 'DT'
              DataBinding.IsNullValueType = True
              Visible = False
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
            object cxGridReports_REPORTID: TcxGridDBColumn
              AlternateCaption = #1050#1086#1076' '#1086#1090#1095#1077#1090#1072
              Caption = 'Cod'
              DataBinding.FieldName = 'REPORTID'
              DataBinding.IsNullValueType = True
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.Filtering = False
              Options.HorzSizing = False
              Options.Moving = False
              Width = 50
            end
            object cxGridReports_IMG: TcxGridDBColumn
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxImageComboBoxProperties'
              Properties.DefaultImageIndex = 28
              Properties.Images = dmAdditions.cxImageList_SWN
              Properties.Items = <>
              MinWidth = 24
              Options.Editing = False
              Options.Filtering = False
              Options.Focusing = False
              Options.ShowEditButtons = isebNever
              Options.HorzSizing = False
              Options.ShowCaption = False
              Options.Sorting = False
              VisibleForCustomization = False
              Width = 24
            end
            object cxGridReports_TITLE: TcxGridDBColumn
              Caption = 'Denumire raport'
              DataBinding.FieldName = 'TITLE'
              DataBinding.IsNullValueType = True
              Options.Moving = False
              VisibleForCustomization = False
            end
            object cxGridReports_TABSHEETINDEX: TcxGridDBColumn
              Caption = 'Suplimentar'
              DataBinding.FieldName = 'TABSHEETINDEX'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              OnGetDisplayText = cxGridReports_TABSHEETINDEXGetDisplayText
              HeaderAlignmentHorz = taCenter
              MinWidth = 100
              Options.HorzSizing = False
              Width = 100
            end
            object cxGridReports_DOCTYPEID: TcxGridDBColumn
              DataBinding.FieldName = 'DOCTYPE_TITLE'
              DataBinding.IsNullValueType = True
              Visible = False
              MinWidth = 100
              Options.HorzSizing = False
              Options.ShowCaption = False
              VisibleForCustomization = False
              Width = 100
              IsCaptionAssigned = True
            end
            object cxGridReports_FLG_DISABLED: TcxGridDBColumn
              AlternateCaption = #1054#1090#1082#1083#1102#1095#1077#1085
              Caption = 'Deconectat'
              DataBinding.FieldName = 'FLG_DISABLED'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 40
              Options.HorzSizing = False
              Width = 40
            end
            object cxGridReports_FLG_NO_DIRECT_PRINT: TcxGridDBColumn
              AlternateCaption = #1053#1077#1090' '#1087#1088#1103#1084#1086#1081' '#1087#1077#1095#1072#1090#1080
              Caption = 'Tipar indirect'
              DataBinding.FieldName = 'FLG_NO_DIRECT_PRINT'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridReports_FLG_QUICK_ACCESS: TcxGridDBColumn
              AlternateCaption = #1041#1099#1089#1090#1088#1099#1081' '#1076#1086#1089#1090#1091#1087
              Caption = 'In Meniu'
              DataBinding.FieldName = 'FLG_QUICK_ACCESS'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = 1
              Properties.ValueUnchecked = 0
              HeaderAlignmentHorz = taCenter
              MinWidth = 30
              Options.HorzSizing = False
              Width = 30
            end
            object cxGridReports_REPORTGROUP_ORDERNO: TcxGridDBColumn
              DataBinding.FieldName = 'REPORTGROUP_ORDERNO'
              DataBinding.IsNullValueType = True
              Visible = False
              OnGetDataText = cxGridReports_REPORTGROUP_ORDERNOGetDataText
              Options.ShowCaption = False
              Options.SortByDisplayText = isbtOff
              VisibleForCustomization = False
              IsCaptionAssigned = True
            end
            object cxGridReports_REPORTGROUP_TITLE: TcxGridDBColumn
              DataBinding.FieldName = 'REPORTGROUP_TITLE'
              DataBinding.IsNullValueType = True
              Visible = False
              VisibleForCustomization = False
              Width = 50
              IsCaptionAssigned = True
            end
          end
          object cxGridReportsLevel: TcxGridLevel
            GridView = cxGridReportsTable
          end
        end
      end
      object tbsParams: TcxTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Paramentri'
        ImageIndex = 1
        object cxLabel2: TLabel
          Left = 2
          Top = 4
          Width = 35
          Height = 15
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Caption = #1054#1090#1095#1077#1090':'
          Transparent = True
        end
        object lbReportTitle: TLabel
          Left = 41
          Top = 4
          Width = 600
          Height = 16
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          AutoSize = False
          Caption = 'Report title'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object cxLabel1: TLabel
          Left = 2
          Top = 22
          Width = 93
          Height = 15
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Caption = 'Paramentri raport'
          Transparent = True
        end
        object cxPageControlParams: TcxPageControl
          AlignWithMargins = True
          Left = 0
          Top = 40
          Width = 655
          Height = 249
          Margins.Left = 0
          Margins.Top = 40
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 0
          Properties.ActivePage = tbsParam_UserGroups
          Properties.CustomButtons.Buttons = <>
          Properties.TabPosition = tpBottom
          OnChange = cxPageControlParamsChange
          ClientRectBottom = 223
          ClientRectLeft = 4
          ClientRectRight = 651
          ClientRectTop = 4
          object tbsSampleTab: TcxTabSheet
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Exemplu'
            ImageIndex = 0
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label1: TLabel
              Left = 16
              Top = 19
              Width = 222
              Height = 13
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Caption = 'Add report customisation params on next tabs'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 16
              Top = 42
              Width = 160
              Height = 13
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Caption = 'Starting index for params tab is 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
          end
          object tbsParam_PriceLabel: TcxTabSheet
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Etichete preturi'
            ImageIndex = 1
            object dxBarDockControlPriceLabels: TdxBarDockControl
              Left = 0
              Top = 0
              Width = 647
              Height = 30
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = dalTop
              BarManager = dxBarManager
              SunkenBorder = True
              UseOwnSunkenBorder = True
            end
            object cxGridPriceLabels: TcxGrid
              Left = 0
              Top = 30
              Width = 647
              Height = 189
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              TabOrder = 1
              object cxGridPriceLabelsTable: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                OnCellDblClick = cxGridPriceLabelsTableCellDblClick
                OnFocusedRecordChanged = cxGridPriceLabelsTableFocusedRecordChanged
                DataController.DataSource = IBCDataSource_TMP_GOODS
                DataController.KeyFieldNames = 'GOODSID'
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <
                  item
                    Kind = skCount
                    Column = cxGridPriceLabelsTable_GOODSID
                  end>
                DataController.Summary.SummaryGroups = <>
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnHorzSizing = False
                OptionsCustomize.ColumnMoving = False
                OptionsCustomize.ColumnSorting = False
                OptionsData.Deleting = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.CellSelect = False
                OptionsSelection.MultiSelect = True
                OptionsView.CellEndEllipsis = True
                OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1090#1086#1074#1072#1088#1086#1074' '#1076#1083#1103' '#1094#1077#1085#1085#1080#1082#1086#1074'>'
                OptionsView.ScrollBars = ssVertical
                OptionsView.ColumnAutoWidth = True
                OptionsView.Footer = True
                OptionsView.GridLineColor = 13750737
                OptionsView.GroupByBox = False
                Styles.Group = dmAdditions.cxStyle_Bold
                Styles.Header = dmAdditions.cxStyle_GridHeader
                object cxGridPriceLabelsTable_GOODSID: TcxGridDBColumn
                  Caption = 'Cod'
                  DataBinding.FieldName = 'GOODSID'
                  DataBinding.IsNullValueType = True
                  FooterAlignmentHorz = taRightJustify
                  MinWidth = 60
                  Options.HorzSizing = False
                  Width = 60
                end
                object cxGridPriceLabelsTable_IMG: TcxGridDBColumn
                  DataBinding.FieldName = 'GOODS_TYPE_ID'
                  DataBinding.IsNullValueType = True
                  PropertiesClassName = 'TcxImageComboBoxProperties'
                  Properties.Images = dmAdditions.cxImageList_SWN
                  Properties.Items = <>
                  MinWidth = 24
                  Options.HorzSizing = False
                  SortIndex = 0
                  SortOrder = soAscending
                  Width = 24
                  IsCaptionAssigned = True
                end
                object cxGridPriceLabelsTable_TITLE: TcxGridDBColumn
                  Caption = 'Denumirea produsului'
                  DataBinding.FieldName = 'TITLE'
                  DataBinding.IsNullValueType = True
                end
                object cxGridPriceLabelsTable_PARENT_TITLE: TcxGridDBColumn
                  DataBinding.FieldName = 'PARENT_TITLE'
                  DataBinding.IsNullValueType = True
                  Visible = False
                  IsCaptionAssigned = True
                end
                object cxGridPriceLabelsTable_DISCOUNT: TcxGridDBColumn
                  Caption = 'REducerea, %'
                  DataBinding.FieldName = 'DISCOUNT'
                  DataBinding.IsNullValueType = True
                  HeaderAlignmentHorz = taCenter
                  MinWidth = 70
                  Options.HorzSizing = False
                  Width = 70
                end
              end
              object cxGridPriceLabelsLevel: TcxGridLevel
                GridView = cxGridPriceLabelsTable
              end
            end
          end
          object tbsParam_UserGroups: TcxTabSheet
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Angajati'
            ImageIndex = 2
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object Label3: TLabel
              Left = 10
              Top = 3
              Width = 38
              Height = 15
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Caption = #1060#1080#1088#1084#1072
              Transparent = True
            end
            object Label4: TLabel
              Left = 294
              Top = 6
              Width = 127
              Height = 15
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Caption = #1043#1088#1091#1087#1087#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
              Transparent = True
            end
            object cxGridPersonel: TcxGrid
              Left = 10
              Top = 23
              Width = 266
              Height = 183
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              TabOrder = 0
              object cxGridPersonelTable: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.DataSource = IBCDataSource_TMP_FIRMS
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsData.Deleting = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.CellSelect = False
                OptionsView.ScrollBars = ssVertical
                OptionsView.ColumnAutoWidth = True
                OptionsView.GridLineColor = 13750737
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                Styles.Header = dmAdditions.cxStyle_GridHeader
                object cxGridPersonel_CUSTOMERID: TcxGridDBColumn
                  Caption = 'Cod'
                  DataBinding.FieldName = 'CUSTOMERID'
                  DataBinding.IsNullValueType = True
                  MinWidth = 50
                  Options.HorzSizing = False
                  Width = 50
                end
                object cxGridPersonel_DISPLAYNAME: TcxGridDBColumn
                  Caption = 'Organizatia'
                  DataBinding.FieldName = 'DISPLAYNAME'
                  DataBinding.IsNullValueType = True
                end
              end
              object cxGridPersonelLevel: TcxGridLevel
                GridView = cxGridPersonelTable
              end
            end
            object cxGridUserGroups: TcxGrid
              Left = 294
              Top = 23
              Width = 267
              Height = 159
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              TabOrder = 1
              object cxGridUserGroupsTable: TcxGridDBTableView
                Navigator.Buttons.CustomButtons = <>
                ScrollbarAnnotations.CustomAnnotations = <>
                DataController.DataSource = IBCDataSource_TMP_USERGROUPS
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsCustomize.ColumnFiltering = False
                OptionsCustomize.ColumnGrouping = False
                OptionsData.Deleting = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.CellSelect = False
                OptionsSelection.MultiSelect = True
                OptionsView.ScrollBars = ssVertical
                OptionsView.ColumnAutoWidth = True
                OptionsView.GridLineColor = 13750737
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                Styles.Header = dmAdditions.cxStyle_GridHeader
                object cxGridUserGroupsTable_GROUPID: TcxGridDBColumn
                  Caption = 'Cod'
                  DataBinding.FieldName = 'GROUPID'
                  DataBinding.IsNullValueType = True
                  MinWidth = 50
                  Options.HorzSizing = False
                  Width = 50
                end
                object cxGridUserGroupsTable_GROUP_NAME: TcxGridDBColumn
                  Caption = 'Grupe de utilizatori'
                  DataBinding.FieldName = 'GROUP_NAME'
                  DataBinding.IsNullValueType = True
                end
              end
              object cxGridUserGroupsLevel: TcxGridLevel
                GridView = cxGridUserGroupsTable
              end
            end
            object cbParam_UserGroups_HideAdmins: TcxCheckBox
              Left = 294
              Top = 187
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              TabStop = False
              Caption = 'Nu arata administratorii'
              Properties.Alignment = taLeftJustify
              TabOrder = 2
            end
          end
        end
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 665
      Height = 26
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 2
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object IBCDataSourceReports: TIBCDataSource
    DataSet = IBCQueryReports
    Left = 284
    Top = 8
  end
  object IBCQueryReports: TIBCQuery
    KeyFields = 'REPORTID'
    KeyGenerator = 'SQ_TS_REPORTS_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_REPORTS2'
      
        '  (REPORTID, DOCTYPEID, REPORTGROUP, ORDERNO, TITLE, DESCRIPTION' +
        ', TABSHEETINDEX, ACC$MASK, '
      '   FLG_DISABLED, FLG_NO_DIRECT_PRINT, FLG_QUICK_ACCESS)'
      'VALUES'
      
        '  (:REPORTID, :DOCTYPEID, :REPORTGROUP, :ORDERNO, :TITLE, :DESCR' +
        'IPTION, :TABSHEETINDEX, :"ACC$MASK", '
      '   :FLG_DISABLED, :FLG_NO_DIRECT_PRINT, :FLG_QUICK_ACCESS)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_REPORTS2'
      'WHERE'
      '  REPORTID = :Old_REPORTID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_REPORTS2'
      'SET'
      ' REPORTID = :REPORTID, '
      ' DOCTYPEID = :DOCTYPEID, '
      ' REPORTGROUP = :REPORTGROUP, '
      ' ORDERNO = :ORDERNO, '
      ' TITLE = :TITLE, '
      ' DESCRIPTION = :DESCRIPTION, '
      ' TABSHEETINDEX = :TABSHEETINDEX, '
      ' ACC$MASK = :"ACC$MASK",'
      ' FLG_DISABLED = :FLG_DISABLED, '
      ' FLG_NO_DIRECT_PRINT = :FLG_NO_DIRECT_PRINT,'
      ' FLG_QUICK_ACCESS = :FLG_QUICK_ACCESS'
      'WHERE'
      '  (REPORTID = :Old_REPORTID)')
    SQLRefresh.Strings = (
      'SELECT '
      ' REPORTID, '
      ' DOCTYPEID, '
      ' REPORTGROUP, '
      ' REPORTGROUP_TITLE,'
      ' REPORTGROUP_ORDERNO,'
      ' ORDERNO, '
      ' TITLE, '
      ' DESCRIPTION, '
      ' TABSHEETINDEX,'
      ' DOCTYPE_TITLE,'
      ' ACC$MASK,'
      ' FLG_DISABLED,'
      ' FLG_NO_DIRECT_PRINT,'
      ' FLG_QUICK_ACCESS'
      'FROM '
      ' VW_TS_REPORTS2'
      'WHERE'
      ' (REPORTID = :REPORTID)')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_REPORTS2'
      'WHERE'
      'REPORTID = :Old_REPORTID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrReportUpdate
    SQL.Strings = (
      '-- SQL este in cod')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 396
    Top = 8
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    LookAndFeel.Kind = lfUltraFlat
    LookAndFeel.SkinName = ''
    PopupMenuLinks = <>
    Style = bmsXP
    UseSystemFont = False
    Left = 432
    Top = 156
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Print'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1280
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewReport'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEditReport'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeleteReport'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbTools'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSearchReport'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbCancelSearch'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManagerBar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockControl = dxBarDockControlPriceLabels
      DockedDockControl = dxBarDockControlPriceLabels
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 887
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPriceLabel_Add'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPriceLabel_Remove'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPriceLabel_ImportFromDoc'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPriceLabel_ImportFromStock'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object bbEditReport: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbEditReportClick
    end
    object bbTools: TdxBarSubItem
      Caption = 'Aditional'
      Category = 0
      Visible = ivAlways
      ImageIndex = 244
      Images = dmAdditions.cxImageList_SWN
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbCopyReport'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbShowByDocType'
        end
        item
          Visible = True
          ItemName = 'bbShowGroupedReports'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbChangeOrder'
        end>
    end
    object bbNewReport: TdxBarButton
      Caption = 'Raport nou...'
      Category = 0
      Hint = 'Raport nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewReportClick
    end
    object bbDeleteReport: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeleteReportClick
    end
    object bbCopyReport: TdxBarButton
      Caption = 'Clonare raport...'
      Category = 0
      Hint = 'Clonare raport'
      Visible = ivAlways
      OnClick = bbCopyReportClick
    end
    object bbChangeOrder: TdxBarButton
      Caption = 'Sortarea rapoarte'
      Category = 0
      Hint = 'Sortarea rapoarte'
      Visible = ivNever
      ImageIndex = 38
      OnClick = bbChangeOrderClick
    end
    object bbShowByDocType: TdxBarButton
      Caption = 'Arata dupa tipul documentului'
      Category = 0
      Hint = 'Arata dupa tipul documentului'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      OnClick = bbShowByDocTypeClick
    end
    object bbPriceLabel_Add: TdxBarButton
      Caption = 'Produs nou...'
      Category = 0
      Hint = 'Produs nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 16429
      OnClick = bbPriceLabel_AddClick
    end
    object bbPriceLabel_Remove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbPriceLabel_RemoveClick
    end
    object bbPriceLabel_ImportFromDoc: TdxBarButton
      Caption = 'Import din document'
      Category = 0
      Hint = 'Import din document'
      Visible = ivAlways
      ImageIndex = 14
      ShortCut = 116
      OnClick = bbPriceLabel_ImportFromDocClick
    end
    object bbShowGroupedReports: TdxBarButton
      Caption = 'Grupare rapoarte'
      Category = 0
      Hint = 'Grupare rapoarte'
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      OnClick = bbShowGroupedReportsClick
    end
    object bbPriceLabel_ImportFromStock: TdxBarButton
      Caption = 'Import din depozit'
      Category = 0
      Hint = 'Import din depozit'
      Visible = ivAlways
      ImageIndex = 27
      OnClick = bbPriceLabel_ImportFromStockClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Optiuni...'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPriceLabel_Menu_GroupByFolder'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbSetupDiscount'
        end>
    end
    object bbPriceLabel_Menu_GroupByFolder: TdxBarButton
      Caption = 'Grupare produse'
      Category = 0
      Hint = 'Grupare produse'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = bbPriceLabel_Menu_GroupByFolderClick
    end
    object bbReportCollapseAllGroups: TdxBarButton
      Caption = 'Collapse all'
      Category = 0
      Hint = 'Collapse all'
      Visible = ivAlways
      OnClick = bbReportCollapseAllGroupsClick
    end
    object bbReportExpandAllGroups: TdxBarButton
      Caption = 'Expand all'
      Category = 0
      Hint = 'Expand all'
      Visible = ivAlways
      OnClick = bbReportExpandAllGroupsClick
    end
    object bbSetupDiscount: TdxBarButton
      Caption = 'Seteaza reducerea'
      Category = 0
      Hint = 'Seteaza reducerea'
      Visible = ivAlways
      ImageIndex = 48
      OnClick = bbSetupDiscountClick
    end
    object bbSearchReport: TdxBarButton
      Caption = 'Cauta'
      Category = 0
      Hint = 'c'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 16454
      OnClick = bbSearchReportClick
    end
    object bbCancelSearch: TdxBarButton
      Caption = 'Anuleaza cautarea'
      Category = 0
      Hint = 'Anuleaza cautarea'
      Visible = ivAlways
      ImageIndex = 35
      ShortCut = 24646
      OnClick = bbCancelSearchClick
    end
  end
  object IBCTrReportUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 500
    Top = 8
  end
  object IBCQuery_TMP_GOODS: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TMP_GOODS'
      '  (GOODSID)'
      'VALUES'
      '  (:GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TMP_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TMP_GOODS'
      'SET'
      '  GOODSID = :GOODSID'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' TMP_GOODS.GOODSID,'
      ' TS_GOODS.TITLE,'
      ' TS_GOODS.GOODS_TYPE_ID,'
      
        ' (SELECT TITLE FROM TS_GOODS B WHERE B.GOODSID=TS_GOODS.PARENTID' +
        ') PARENT_TITLE'
      'FROM'
      ' TMP_GOODS'
      ' INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TMP_GOODS.GOODSID)'
      'WHERE'
      ' TMP_GOODS.GOODSID = :GOODSID')
    Connection = dmDB.IBCConnection
    Transaction = IBCTrReportUpdate
    UpdateTransaction = IBCTrReportUpdate
    SQL.Strings = (
      'SELECT'
      ' TMP_GOODS.GOODSID,'
      ' TS_GOODS.TITLE,'
      ' TS_GOODS.GOODS_TYPE_ID,'
      
        ' (SELECT TITLE FROM TS_GOODS B WHERE B.GOODSID=TS_GOODS.PARENTID' +
        ') PARENT_TITLE,'
      ' TMP_GOODS.DISCOUNT'
      'FROM TMP_GOODS'
      'INNER JOIN TS_GOODS ON (TS_GOODS.GOODSID=TMP_GOODS.GOODSID)')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 100
    Top = 158
  end
  object IBCDataSource_TMP_GOODS: TIBCDataSource
    DataSet = IBCQuery_TMP_GOODS
    Left = 156
    Top = 206
  end
  object IBCQuery_TMP_FIRMS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT * FROM GET_FIRMS_BY_USER2 ORDER BY ORDERNO')
    Left = 216
    Top = 190
  end
  object IBCDataSource_TMP_FIRMS: TIBCDataSource
    DataSet = IBCQuery_TMP_FIRMS
    Left = 216
    Top = 114
  end
  object IBCQuery_TMP_USERGROUPS: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT * FROM GET_GROUPS_BY_USER(:userID)')
    Left = 308
    Top = 186
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'userID'
        Value = nil
      end>
  end
  object IBCDataSource_TMP_USERGROUPS: TIBCDataSource
    DataSet = IBCQuery_TMP_USERGROUPS
    Left = 308
    Top = 134
  end
  object cxGridPopupMenuReports: TcxGridPopupMenu
    Grid = cxGridReports
    PopupMenus = <
      item
        GridView = cxGridReportsTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuReports
      end>
    Left = 308
    Top = 256
  end
  object dxBarPopupMenuReports: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbReportCollapseAllGroups'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbReportExpandAllGroups'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuReportsPopup
    Left = 536
    Top = 232
    PixelsPerInch = 96
  end
end
