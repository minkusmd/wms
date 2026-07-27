object frmUsersDlg: TfrmUsersDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridUsers
  BorderIcons = [biSystemMenu]
  Caption = 'Utilizatori'
  ClientHeight = 603
  ClientWidth = 1160
  Color = clBtnFace
  Constraints.MinHeight = 590
  Constraints.MinWidth = 870
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
    Width = 1160
    Height = 64
    Title = 'Utilizatori'
    Text = 'Gestiune utilizatori'
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
    ImageIndex = 13
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1144
    Height = 474
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 1
    object cxGridUsers: TcxGrid
      Left = 0
      Top = 30
      Width = 1144
      Height = 444
      Align = alClient
      TabOrder = 1
      object cxGridUsersTable: TcxGridDBTableView
        OnKeyDown = cxGridUsersTableKeyDown
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
        OnCellDblClick = cxGridUsersTableCellDblClick
        OnFocusedRecordChanged = cxGridUsersTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceUsers
        DataController.KeyFieldNames = 'USERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
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
        OptionsView.Indicator = True
        Styles.OnGetContentStyle = cxGridUsersTableStylesGetContentStyle
        Styles.Group = dmAdditions.cxStyle_Bold
        Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridUsersTable_FLG_ACTIVE: TcxGridDBColumn
          AlternateCaption = #1040#1082#1090#1080#1074#1085#1099#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Caption = 'Act'
          DataBinding.FieldName = 'FLG_ACTIVE'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridUsersTableUSERID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Caption = 'Cod'
          DataBinding.FieldName = 'USERID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Editing = False
          Options.Filtering = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Moving = False
          Width = 50
        end
        object cxGridUsersTable_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'USERID'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.DefaultImageIndex = 20
          Properties.Images = dmAdditions.cxImageList_SWN
          Properties.Items = <>
          MinWidth = 24
          Options.Focusing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 24
          IsCaptionAssigned = True
        end
        object cxGridUsersTable_FULL_NAME: TcxGridDBColumn
          Caption = 'Nume'
          DataBinding.FieldName = 'FULL_NAME2'
          DataBinding.IsNullValueType = True
          MinWidth = 100
          Width = 140
        end
        object cxGridUsersTableLOGIN_NAME: TcxGridDBColumn
          Caption = 'Login'
          DataBinding.FieldName = 'LOGIN_NAME'
          DataBinding.IsNullValueType = True
          MinWidth = 140
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 140
        end
        object cxGridUsersTableTELEFON: TcxGridDBColumn
          Caption = 'Telefon'
          DataBinding.FieldName = 'TELEFON'
          DataBinding.IsNullValueType = True
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
        object cxGridUsersTableEMAIL: TcxGridDBColumn
          Caption = 'eMail'
          DataBinding.FieldName = 'EMAIL'
          DataBinding.IsNullValueType = True
          MinWidth = 100
          Width = 100
        end
        object cxGridUsersTableBIRTHDAY: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
          DataBinding.FieldName = 'BIRTHDAY'
          DataBinding.IsNullValueType = True
          Visible = False
          MinWidth = 100
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Width = 100
        end
        object cxGridUsers_DEFAULT_DT_NAME: TcxGridDBColumn
          Caption = #1060#1080#1088#1084#1072
          DataBinding.FieldName = 'DEFAULT_DT_NAME'
          DataBinding.IsNullValueType = True
          Visible = False
          Width = 120
        end
        object cxGridUsers_FLG_CHANGE_PSWD: TcxGridDBColumn
          AlternateCaption = #1048#1079#1084#1077#1085#1080#1090' '#1087#1072#1088#1086#1083#1100' '#1095#1077#1088#1077#1079' 30 '#1076#1085#1077#1081
          Caption = 'Psw'
          DataBinding.FieldName = 'FLG_CHANGE_PSWD'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 30
          Options.HorzSizing = False
          Width = 30
        end
        object cxGridUsers_FLG_HAS_USERGROUP: TcxGridDBColumn
          AlternateCaption = #1042' '#1075#1088#1091#1087#1087#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
          Caption = 'Grupa'
          DataBinding.FieldName = 'FLG_HAS_USERGROUP'
          DataBinding.IsNullValueType = True
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridUsers_FUNCTIA_DETINUTA: TcxGridDBColumn
          Caption = 'Functia'
          DataBinding.FieldName = 'FUNCTIA_DETINUTA'
          DataBinding.IsNullValueType = True
          Width = 80
        end
        object cxGridUsers_REGISTER_DATE: TcxGridDBColumn
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1073#1086#1090#1099
          DataBinding.FieldName = 'REGISTER_DATE'
          DataBinding.IsNullValueType = True
          Visible = False
          Options.ShowEditButtons = isebNever
          Width = 50
        end
        object cxGridUsers_USERTYPE_TITLE: TcxGridDBColumn
          Caption = 'Tip utilizator'
          DataBinding.FieldName = 'USERTYPE_TITLE'
          DataBinding.IsNullValueType = True
          Width = 100
        end
        object cxGridUsers_CUSTOMERID: TcxGridDBColumn
          DataBinding.FieldName = 'CUSTOMERID'
          DataBinding.IsNullValueType = True
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridUsers_CUSTOMER_DISPLAYNAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CUSTOMER_DISPLAYNAME'
          DataBinding.IsNullValueType = True
          OnGetDisplayText = cxGridUsers_CUSTOMER_DISPLAYNAMEGetDisplayText
          Width = 100
        end
        object cxGridUsersTable_SIP: TcxGridDBColumn
          Caption = 'Numer int.'
          DataBinding.FieldName = 'SIP_USERID'
          DataBinding.IsNullValueType = True
          HeaderAlignmentHorz = taCenter
          Width = 80
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridUsersTable
      end
    end
    object dxBarDockControl2: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1144
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 554
    Width = 1160
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1160
      49)
    object btnClose: TcxButton
      Left = 1047
      Top = 5
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
    end
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
      'Default'
      'Users')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    DockColor = clBtnFace
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    NotDocking = [dsNone]
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 260
    Top = 12
    PixelsPerInch = 96
    object dxBarUsers: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Users'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 563
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbUserNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbUserModify'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbUserRemove'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbUserTools'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrint'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbPrint: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      ShortCut = 16464
      OnClick = bbPrintClick
    end
    object bbUserNew: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbUserNewClick
    end
    object bbUserModify: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbUserModifyClick
    end
    object bbUserRemove: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbUserRemoveClick
    end
    object bbUserTools: TdxBarSubItem
      Caption = 'Suplimentar'
      Category = 1
      Visible = ivNever
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbUserMakeInactive'
        end
        item
          Visible = True
          ItemName = 'bbUserResetPassword'
        end>
    end
    object bbUserMakeInactive: TdxBarButton
      Caption = 'Deconectare acces'
      Category = 1
      Enabled = False
      Hint = 'Deconectare acces'
      Visible = ivAlways
    end
    object bbUserResetPassword: TdxBarButton
      Caption = 'Reset password'
      Category = 1
      Enabled = False
      Hint = 'Reset password'
      Visible = ivAlways
    end
  end
  object IBCQueryUsers: TIBCQuery
    KeyFields = 'USERID'
    KeyGenerator = 'SQ_TS_USERS_USERID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_USERS'
      
        '  (USERID, LOGIN_NAME, ACC$FIRM, FIRST_NAME, LAST_NAME, FULL_NAM' +
        'E, DESCRIPTION, TELEFON, EMAIL, ADDRESS, BIRTHDAY, PASSWORD_HASH' +
        ', CITY_ID, LAST_PASSWORD_CHANGE, CUSTOMERID, CUSTOMER_DISPLAYNAM' +
        'E, FLG_ACTIVE, FLG_CHANGE_PSWD, FLG_ACTIVE_HOURS, FLG_WORK_WITH_' +
        'MONEY, DEFAULT_DT, DEFAULT_DT_NAME, FUNCTIA_DETINUTA, REGISTER_D' +
        'ATE, USERTYPE_ID, USERTYPE_TITLE, SIP_SRV_ADRESS, SIP_USERID, SI' +
        'P_USER_PSWD, SIP_STUN, SIP_PROXY, IDNO, BULETINNO, BULETIN_DATE)'
      'VALUES'
      
        '  (:USERID, :LOGIN_NAME, :ACC$FIRM, :FIRST_NAME, :LAST_NAME, :FU' +
        'LL_NAME, :DESCRIPTION, :TELEFON, :EMAIL, :ADDRESS, :BIRTHDAY, :P' +
        'ASSWORD_HASH, :CITY_ID, :LAST_PASSWORD_CHANGE, :CUSTOMERID, :CUS' +
        'TOMER_DISPLAYNAME, :FLG_ACTIVE, :FLG_CHANGE_PSWD, :FLG_ACTIVE_HO' +
        'URS, :FLG_WORK_WITH_MONEY, :DEFAULT_DT, :DEFAULT_DT_NAME, :FUNCT' +
        'IA_DETINUTA, :REGISTER_DATE, :USERTYPE_ID, :USERTYPE_TITLE, :SIP' +
        '_SRV_ADRESS, :SIP_USERID, :SIP_USER_PSWD, :SIP_STUN, :SIP_PROXY,' +
        ' :IDNO, :BULETINNO, :BULETIN_DATE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_USERS'
      'WHERE'
      '  USERID = :Old_USERID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_USERS'
      'SET'
      
        '  USERID = :USERID, LOGIN_NAME = :LOGIN_NAME, ACC$FIRM = :ACC$FI' +
        'RM, FIRST_NAME = :FIRST_NAME, LAST_NAME = :LAST_NAME, FULL_NAME ' +
        '= :FULL_NAME, DESCRIPTION = :DESCRIPTION, TELEFON = :TELEFON, EM' +
        'AIL = :EMAIL, ADDRESS = :ADDRESS, BIRTHDAY = :BIRTHDAY, PASSWORD' +
        '_HASH = :PASSWORD_HASH, CITY_ID = :CITY_ID, LAST_PASSWORD_CHANGE' +
        ' = :LAST_PASSWORD_CHANGE, CUSTOMERID = :CUSTOMERID, CUSTOMER_DIS' +
        'PLAYNAME = :CUSTOMER_DISPLAYNAME, FLG_ACTIVE = :FLG_ACTIVE, FLG_' +
        'CHANGE_PSWD = :FLG_CHANGE_PSWD, FLG_ACTIVE_HOURS = :FLG_ACTIVE_H' +
        'OURS, FLG_WORK_WITH_MONEY = :FLG_WORK_WITH_MONEY, DEFAULT_DT = :' +
        'DEFAULT_DT, DEFAULT_DT_NAME = :DEFAULT_DT_NAME, FUNCTIA_DETINUTA' +
        ' = :FUNCTIA_DETINUTA, REGISTER_DATE = :REGISTER_DATE, USERTYPE_I' +
        'D = :USERTYPE_ID, USERTYPE_TITLE = :USERTYPE_TITLE, SIP_SRV_ADRE' +
        'SS = :SIP_SRV_ADRESS, SIP_USERID = :SIP_USERID, SIP_USER_PSWD = ' +
        ':SIP_USER_PSWD, SIP_STUN = :SIP_STUN, SIP_PROXY = :SIP_PROXY, ID' +
        'NO = :IDNO, BULETINNO = :BULETINNO, BULETIN_DATE = :BULETIN_DATE'
      'WHERE'
      '  USERID = :Old_USERID')
    SQLRefresh.Strings = (
      
        'SELECT USERID, LOGIN_NAME, ACC$FIRM, FIRST_NAME, LAST_NAME, FULL' +
        '_NAME, DESCRIPTION, TELEFON, EMAIL, ADDRESS, BIRTHDAY, PASSWORD_' +
        'HASH, CITY_ID, LAST_PASSWORD_CHANGE, CUSTOMERID, CUSTOMER_DISPLA' +
        'YNAME, FLG_ACTIVE, FLG_CHANGE_PSWD, FLG_ACTIVE_HOURS, FLG_WORK_W' +
        'ITH_MONEY, DEFAULT_DT, DEFAULT_DT_NAME, FUNCTIA_DETINUTA, REGIST' +
        'ER_DATE, USERTYPE_ID, USERTYPE_TITLE, SIP_SRV_ADRESS, SIP_USERID' +
        ', SIP_USER_PSWD, SIP_STUN, SIP_PROXY, IDNO, BULETINNO, BULETIN_D' +
        'ATE FROM VW_TS_USERS'
      'WHERE'
      '  USERID = :USERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_USERS'
      'WHERE'
      'USERID = :Old_USERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TS_USERS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateUsers
    SQL.Strings = (
      'SELECT'
      ' VW_TS_USERS.*,'
      
        ' IIF (EXISTS(SELECT GROUPID FROM TS_USER_GROUP_LINKS WHERE TS_US' +
        'ER_GROUP_LINKS.USERID=VW_TS_USERS.USERID),1,0) FLG_HAS_USERGROUP' +
        ','
      
        ' VW_TS_USERS.FIRST_NAME || '#39' '#39' || VW_TS_USERS.LAST_NAME FULL_NAM' +
        'E2'
      'FROM'
      ' VW_TS_USERS')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate, roBeforeEdit]
    Left = 60
    Top = 292
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 60
    Top = 244
  end
  object IBCTrUpdateUsers: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 60
    Top = 348
  end
end
