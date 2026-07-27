object frmCustomerAccountDialog: TfrmCustomerAccountDialog
  Left = 0
  Top = 0
  ActiveControl = cxGridAccounts
  BorderStyle = bsDialog
  Caption = 'Rechizitele bancare ale clientului'
  ClientHeight = 414
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    707
    414)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 707
    Height = 64
    Title = 'Rechizitele bancare ale clientului'
    Text = 'Managementul rechizitelor bancare '
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
  object btnCancel: TcxButton
    Left = 594
    Top = 368
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 691
    Height = 282
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 1
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 691
      Height = 30
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = dalTop
      AllowDocking = False
      BarManager = dxBarManager
    end
    object cxGridAccounts: TcxGrid
      Left = 0
      Top = 31
      Width = 691
      Height = 251
      Align = alClient
      TabOrder = 1
      object cxGridAccountsDB: TcxGridDBTableView
        OnKeyDown = cxGridAccountsDBKeyDown
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
        OnCellDblClick = cxGridAccountsDBCellDblClick
        DataController.DataSource = IBCDataSourceAccounts
        DataController.KeyFieldNames = 'CUSTOMERID;ACCOUNTNUMBER'
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
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
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridAccountsDBACCOUNTNUMBER: TcxGridDBColumn
          Caption = 'Cont'
          DataBinding.FieldName = 'ACCOUNTNUMBER'
          PropertiesClassName = 'TcxMaskEditProperties'
          Width = 214
        end
        object cxGridAccountsDBACCOUNTNAME: TcxGridDBColumn
          Caption = 'Denumire cont'
          DataBinding.FieldName = 'ACCOUNTNAME'
          Width = 174
        end
        object cxGridAccountsDBBANKNAME: TcxGridDBColumn
          Caption = 'Banca'
          DataBinding.FieldName = 'BANKNAME'
          Width = 240
        end
        object cxGridAccountsDBDEFAULT_ACCOUNT: TcxGridDBColumn
          Caption = 'De baza'
          DataBinding.FieldName = 'DEFAULT_ACCOUNT'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.Filtering = False
          Options.ShowEditButtons = isebNever
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 48
        end
      end
      object cxGridAccountsLevel: TcxGridLevel
        GridView = cxGridAccountsDB
      end
    end
  end
  object btnOk: TcxButton
    Left = 489
    Top = 368
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
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
    Left = 420
    Top = 20
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
      FloatLeft = 38
      FloatTop = 185
      FloatClientWidth = 51
      FloatClientHeight = 24
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
      Caption = 'Cont nou'
      Category = 0
      Hint = 'Cont nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewClick
    end
    object bbModify: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyClick
    end
    object bbRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveClick
    end
  end
  object IBCQueryAccounts: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_CUST_ACCOUNTS'
      
        '  (CUSTOMERID, ACCOUNTNUMBER, ACCOUNTNAME, BANKACCOUNT, DEFAULT_' +
        'ACCOUNT, IBAN)'
      'VALUES'
      
        '  (:CUSTOMERID, :ACCOUNTNUMBER, :ACCOUNTNAME, :BANKACCOUNT, :DEF' +
        'AULT_ACCOUNT, :IBAN)')
    SQLDelete.Strings = (
      'DELETE FROM TS_CUST_ACCOUNTS'
      'WHERE'
      
        '  CUSTOMERID = :Old_CUSTOMERID AND ACCOUNTNUMBER = :Old_ACCOUNTN' +
        'UMBER')
    SQLUpdate.Strings = (
      'UPDATE TS_CUST_ACCOUNTS'
      'SET'
      ' CUSTOMERID = :CUSTOMERID, '
      ' ACCOUNTNUMBER = :ACCOUNTNUMBER, '
      ' ACCOUNTNAME = :ACCOUNTNAME, '
      ' BANKACCOUNT = :BANKACCOUNT, '
      ' DEFAULT_ACCOUNT = :DEFAULT_ACCOUNT,'
      ' IBAN = :IBAN'
      'WHERE'
      
        '  CUSTOMERID = :Old_CUSTOMERID AND ACCOUNTNUMBER = :Old_ACCOUNTN' +
        'UMBER')
    SQLRefresh.Strings = (
      'SELECT'
      '    CUSTOMERID,'
      '    ACCOUNTNUMBER,'
      '    ACCOUNTNAME,'
      '    DEFAULT_ACCOUNT,'
      '    TS_CUST_ACCOUNTS.BANKACCOUNT,'
      '    BANKNAME,'
      '    IBAN'
      'FROM'
      '    TS_CUST_ACCOUNTS '
      
        '    INNER JOIN TS_BANKS ON (TS_BANKS.BANKACCOUNT = TS_CUST_ACCOU' +
        'NTS.BANKACCOUNT)'
      'WHERE'
      '    CUSTOMERID = :CUSTOMERID AND ACCOUNTNUMBER = :ACCOUNTNUMBER')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_CUST_ACCOUNTS'
      'WHERE'
      
        'CUSTOMERID = :Old_CUSTOMERID AND ACCOUNTNUMBER = :Old_ACCOUNTNUM' +
        'BER'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      '    CUSTOMERID,'
      '    ACCOUNTNUMBER,'
      '    ACCOUNTNAME,'
      '    DEFAULT_ACCOUNT,'
      '    TS_CUST_ACCOUNTS.BANKACCOUNT,'
      '    BANKNAME,'
      '    IBAN'
      'FROM'
      '    TS_CUST_ACCOUNTS '
      
        '    INNER JOIN TS_BANKS ON (TS_BANKS.BANKACCOUNT = TS_CUST_ACCOU' +
        'NTS.BANKACCOUNT)')
    MasterFields = 'CUSTOMERID'
    DetailFields = 'CUSTOMERID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 68
    Top = 240
  end
  object IBCDataSourceAccounts: TIBCDataSource
    DataSet = IBCQueryAccounts
    OnDataChange = DataSourceAccountsDataChange
    Left = 68
    Top = 192
  end
end
