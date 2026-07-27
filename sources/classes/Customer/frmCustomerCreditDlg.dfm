object frmCustomerCreditDialog: TfrmCustomerCreditDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 416
  ClientWidth = 890
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    890
    416)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 890
    Height = 64
    Title = #1050#1088#1077#1076#1080#1090#1086#1074#1072#1085#1080#1077' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
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
    ImageIndex = 2
    ExplicitLeft = -8
    ExplicitTop = 8
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 874
    Height = 285
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridCredits: TcxGrid
      Left = 0
      Top = 31
      Width = 874
      Height = 254
      Align = alClient
      TabOrder = 1
      object cxGridCreditsTable: TcxGridDBTableView
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
        OnCellDblClick = cxGridCreditsTableCellDblClick
        OnFocusedRecordChanged = cxGridCreditsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCredits
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridCreditsTableDATA: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
          DataBinding.FieldName = 'DATA'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridCreditsTableDATE_END: TcxGridDBColumn
          Caption = #1050#1086#1085#1077#1094' '#1087#1077#1088#1080#1086#1076#1072
          DataBinding.FieldName = 'DATE_END'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 100
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridCreditsTable_SUMA_CASH: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072' '#1085#1072#1083#1080#1095#1085#1099#1077', $'
          DataBinding.FieldName = 'SUMA_CASH'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridCredits_SUMA_TRANSFER: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072' '#1073#1077#1079#1085#1072#1083#1080#1095#1085#1099#1077', '#1051#1077#1080
          DataBinding.FieldName = 'SUMA_TRANSFER'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 140
          Options.HorzSizing = False
          Width = 140
        end
        object cxGridCreditsTableCONCATENATION: TcxGridDBColumn
          Caption = #1042#1099#1076#1072#1083
          DataBinding.FieldName = 'USER_FULLNAME'
          DataBinding.IsNullValueType = True
          MinWidth = 120
          Options.HorzSizing = False
          Width = 120
        end
        object cxGridCreditsTableDESCRIPTION: TcxGridDBColumn
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          DataBinding.FieldName = 'DESCRIPTION'
          DataBinding.IsNullValueType = True
          Width = 200
        end
      end
      object cxGridCreditsLevel: TcxGridLevel
        GridView = cxGridCreditsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 874
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      AllowDocking = False
      BarManager = dxBarManager
    end
  end
  object btnCancel: TcxButton
    Left = 784
    Top = 371
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 680
    Top = 371
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    ShowFullMenusAfterDelay = False
    ShowShortCutInHint = True
    SunkenBorder = True
    UseSystemFont = True
    Left = 596
    Top = 24
    PixelsPerInch = 96
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 99
      FloatTop = 271
      FloatClientWidth = 115
      FloatClientHeight = 77
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemove'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = #1053#1086#1074#1099#1081' '#1082#1088#1077#1076#1080#1090
      Category = 0
      Hint = #1053#1086#1074#1099#1081' '#1082#1088#1077#1076#1080#1090
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 0
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbRemove: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 115
      OnClick = bbRemoveClick
    end
  end
  object IBCQueryCredits: TIBCQuery
    UpdatingTable = 'TS_CUST_CREDIT'
    KeyFields = 'CUSTOMERID'
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_CREDIT'
      
        '  (CUSTOMERID, DATA, SUMA_CASH, SUMA_TRANSFER, DATE_END, DESCRIP' +
        'TION, USERID)'
      'VALUES'
      
        '  (:CUSTOMERID, :DATA, :SUMA_CASH, :SUMA_TRANSFER, :DATE_END, :D' +
        'ESCRIPTION, :USERID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_CREDIT'
      'WHERE'
      ' (CUSTOMERID = :Old_CUSTOMERID) AND (DATA = :Old_DATA)')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_CREDIT'
      'SET'
      ' CUSTOMERID = :CUSTOMERID, DATA = :DATA, '
      ' SUMA_CASH = :SUMA_CASH, '
      ' SUMA_TRANSFER = :SUMA_TRANSFER, '
      ' DATE_END = :DATE_END, '
      ' DESCRIPTION = :DESCRIPTION, '
      ' USERID = :USERID'
      'WHERE'
      '  CUSTOMERID = :Old_CUSTOMERID AND DATA = :Old_DATA')
    SQLRefresh.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' DATA,'
      ' SUMA_CASH,'
      ' SUMA_TRANSFER,'
      ' DATE_END,'
      ' DESCRIPTION,'
      ' USERID,'
      
        ' (SELECT FIRST_NAME || '#39' '#39' || LAST_NAME FROM TS_USERS WHERE USER' +
        'ID=TS_CUST_CREDIT.USERID) AS USER_FULLNAME'
      'FROM'
      ' TS_CUST_CREDIT'
      'WHERE'
      ' CUSTOMERID = :CUSTOMERID AND DATA = :DATA')
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID,'
      ' DATA,'
      ' SUMA_CASH,'
      ' SUMA_TRANSFER,'
      ' DATE_END,'
      ' DESCRIPTION,'
      ' USERID,'
      
        ' (SELECT FULL_NAME FROM TS_USERS WHERE USERID=TS_CUST_CREDIT.USE' +
        'RID) AS USER_FULLNAME'
      'FROM'
      ' TS_CUST_CREDIT')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Left = 64
    Top = 200
  end
  object IBCDataSourceCredits: TIBCDataSource
    DataSet = IBCQueryCredits
    Left = 64
    Top = 152
  end
end
