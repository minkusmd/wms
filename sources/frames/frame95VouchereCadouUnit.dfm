inherited frame95VouchereCadou: Tframe95VouchereCadou
  Width = 1181
  Height = 667
  Font.Height = -15
  ExplicitWidth = 1181
  ExplicitHeight = 667
  PixelsPerInch = 120
  object cxGridPromoTickets: TcxGrid
    Left = 0
    Top = 71
    Width = 1181
    Height = 596
    Align = alClient
    TabOrder = 1
    LookAndFeel.NativeStyle = True
    LookAndFeel.SkinName = ''
    object cxGridPromoTicketsTable: TcxGridDBTableView
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
      OnFocusedRecordChanged = cxGridPromoTicketsTableFocusedRecordChanged
      DataController.DataSource = IBCDataSourceVouchereCadou
      DataController.KeyFieldNames = 'VOUCHERID'
      FilterRow.SeparatorWidth = 8
      FixedDataRows.SeparatorWidth = 8
      NewItemRow.SeparatorWidth = 8
      OptionsBehavior.IncSearch = True
      OptionsBehavior.ImmediateEditor = False
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.InvertSelect = False
      OptionsView.NavigatorOffset = 63
      OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
      OptionsView.ColumnAutoWidth = True
      OptionsView.FixedColumnSeparatorWidth = 3
      OptionsView.GridLineColor = 13750737
      OptionsView.GroupByBox = False
      OptionsView.GroupRowStyle = grsOffice11
      Preview.LeftIndent = 25
      Preview.RightIndent = 6
      RowLayout.MinValueWidth = 100
      Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
      Styles.Header = dmAdditions.cxStyle_GridHeader
      Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
      object cxGridPromoTicketsTableTICKETID: TcxGridDBColumn
        Caption = 'ID'
        DataBinding.FieldName = 'VOUCHERID'
        HeaderAlignmentHorz = taCenter
        MinWidth = 78
        Options.HorzSizing = False
        Width = 78
      end
      object cxGridPromoTicketsTableTICKET_CODE: TcxGridDBColumn
        Caption = 'Promo Code'
        DataBinding.FieldName = 'CODE'
        HeaderAlignmentHorz = taCenter
        Width = 328
      end
      object cxGridPromoTicketsTableDATA1: TcxGridDBColumn
        Caption = 'Data inceput'
        DataBinding.FieldName = 'DATA1'
        HeaderAlignmentHorz = taCenter
        Width = 260
      end
      object cxGridPromoTicketsTableDATA2: TcxGridDBColumn
        Caption = 'Data sfirsit'
        DataBinding.FieldName = 'DATA2'
        HeaderAlignmentHorz = taCenter
        Width = 248
      end
      object cxGridPromoTicketsTableDISCOUNT_VALUE: TcxGridDBColumn
        Caption = 'Valoarea reducerii'
        DataBinding.FieldName = 'AMOUNT'
        HeaderAlignmentHorz = taCenter
        Width = 253
      end
      object cxGridPromoTicketsTable_FLG_USED: TcxGridDBColumn
        Caption = 'Utilizat'
        DataBinding.FieldName = 'FLG_USED'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
        MinWidth = 48
        Options.HorzSizing = False
        Width = 48
      end
      object cxGridPromoTicketsTable_FLG_ACTIVE: TcxGridDBColumn
        Caption = 'Activ'
        DataBinding.FieldName = 'FLG_ACTIVE'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        HeaderAlignmentHorz = taCenter
      end
    end
    object cxGridPromoTicketsLevel: TcxGridLevel
      GridView = cxGridPromoTicketsTable
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1181
    Height = 39
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    Color = clGray
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 1165
      Height = 23
      Align = alTop
      Caption = 'Vouchere cadou'
      Color = clGray
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlightText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      ExplicitWidth = 126
    end
  end
  object IBCDataSourceVouchereCadou: TIBCDataSource
    DataSet = IBCQueryVouchereCadou
    Left = 80
    Top = 140
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 864
    Top = 80
    PixelsPerInch = 120
    DockControlHeights = (
      0
      0
      32
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Items'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 1406
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbGenerateGiftVouchers'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbGenerateGiftVouchers: TdxBarButton
      Caption = 'Genereaza "Vouchere Cadou"'
      Category = 0
      Hint = 'Genereaza "Vouchere Cadou"'
      Visible = ivAlways
    end
  end
  object IBCQueryVouchereCadou: TIBCQuery
    KeyFields = 'VOUCHERID'
    KeyGenerator = 'gen_mk_vouchere_cadou_id'
    SQLInsert.Strings = (
      'INSERT INTO MK_VOUCHERE_CADOU'
      
        '  (VOUCHERID, CODE, DATA1, DATA2, AMOUNT, FLG_USED, USED_IN_WEBD' +
        'OCID, USED_IN_DOCID, BALANCE_DOCID)'
      'VALUES'
      
        '  (:VOUCHERID, :CODE, :DATA1, :DATA2, :AMOUNT, :FLG_USED, :USED_' +
        'IN_WEBDOCID, :USED_IN_DOCID, :BALANCE_DOCID)')
    SQLDelete.Strings = (
      'DELETE FROM MK_VOUCHERE_CADOU'
      'WHERE'
      '  VOUCHERID = :Old_VOUCHERID')
    SQLUpdate.Strings = (
      'UPDATE MK_VOUCHERE_CADOU'
      'SET'
      
        '  VOUCHERID = :VOUCHERID, CODE = :CODE, DATA1 = :DATA1, DATA2 = ' +
        ':DATA2, AMOUNT = :AMOUNT, FLG_USED = :FLG_USED, USED_IN_WEBDOCID' +
        ' = :USED_IN_WEBDOCID, USED_IN_DOCID = :USED_IN_DOCID, BALANCE_DO' +
        'CID = :BALANCE_DOCID'
      'WHERE'
      '  VOUCHERID = :Old_VOUCHERID')
    SQLRefresh.Strings = (
      
        'SELECT VOUCHERID, CODE, DATA1, DATA2, AMOUNT, FLG_USED, USED_IN_' +
        'WEBDOCID, USED_IN_DOCID, BALANCE_DOCID FROM MK_VOUCHERE_CADOU'
      'WHERE'
      '  VOUCHERID = :VOUCHERID')
    SQLLock.Strings = (
      'SELECT NULL FROM MK_VOUCHERE_CADOU'
      'WHERE'
      'VOUCHERID = :Old_VOUCHERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM MK_VOUCHERE_CADOU'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from mk_vouchere_cadou'
      'order by voucherid desc')
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 232
    Top = 136
  end
end
