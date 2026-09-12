object frmCalcSalesBonusDlg: TfrmCalcSalesBonusDlg
  Left = 0
  Top = 0
  ActiveControl = deStart
  BorderStyle = bsDialog
  Caption = #1059#1079#1085#1072#1090#1100' '#1089#1074#1086#1081' '#1073#1086#1085#1091#1089' '#1089' '#1087#1088#1086#1076#1072#1078
  ClientHeight = 459
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 790
    Height = 64
    Title = #1059#1079#1085#1072#1090#1100' '#1089#1074#1086#1081' '#1073#1086#1085#1091#1089' '#1089' '#1087#1088#1086#1076#1072#1078
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
    ImageIndex = 28
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 774
    Height = 333
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
    object Label1: TLabel
      Left = 20
      Top = 24
      Width = 45
      Height = 15
      Caption = #1055#1077#1088#1080#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 20
      Top = 44
      Width = 14
      Height = 15
      Caption = #1054#1090
    end
    object Label3: TLabel
      Left = 204
      Top = 44
      Width = 15
      Height = 15
      Caption = #1044#1086
    end
    object Label4: TLabel
      Left = 20
      Top = 88
      Width = 44
      Height = 15
      Caption = #1041#1086#1085#1091#1089#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 392
      Top = 24
      Width = 82
      Height = 15
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object deStart: TcxDateEdit
      Left = 40
      Top = 41
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 137
    end
    object deEnd: TcxDateEdit
      Left = 225
      Top = 41
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 2
      Width = 137
    end
    object btnCalc: TButton
      Left = 652
      Top = 36
      Width = 97
      Height = 33
      Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
      Default = True
      TabOrder = 0
      OnClick = btnCalcClick
    end
    object cxGrid: TcxGrid
      Left = 20
      Top = 105
      Width = 729
      Height = 204
      TabOrder = 4
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceBonus
        DataController.KeyFieldNames = 'DOCID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = cxGridTable_BONUS
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Footer = dmAdditions.cxStyle_Bold
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_BONUS_TITLE: TcxGridDBColumn
          Caption = #1041#1086#1085#1091#1089#1085#1072#1103' '#1072#1082#1094#1080#1103
          DataBinding.FieldName = 'BONUS_TITLE'
          Width = 100
        end
        object cxGridTable_DOCID: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1076#1086#1082'.'
          DataBinding.FieldName = 'DOCID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_GOODSID: TcxGridDBColumn
          Caption = #1050#1086#1076' '#1090#1086#1074'.'
          DataBinding.FieldName = 'GOODSID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 60
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridTable_GOODS_TITLE: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
          DataBinding.FieldName = 'GOODS_TITLE'
          Width = 200
        end
        object cxGridTable_BONUS: TcxGridDBColumn
          Caption = #1041#1086#1085#1091#1089
          DataBinding.FieldName = 'BONUS'
          HeaderAlignmentHorz = taCenter
          MinWidth = 80
          Options.HorzSizing = False
          Width = 80
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object lcbUser: TcxLookupComboBox
      Left = 392
      Top = 41
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.DropDownWidth = 400
      Properties.KeyFieldNames = 'USERID'
      Properties.ListColumns = <
        item
          Width = 80
          FieldName = 'USER_FULLNAME'
        end
        item
          Width = 120
          FieldName = 'FIRMA_NAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceUsers
      EditValue = 0
      TabOrder = 3
      Width = 229
    end
  end
  object btnCancel: TButton
    Left = 680
    Top = 416
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object IBCQueryBonus: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' DOCID,'
      ' GOODSID,'
      ' GBONUSID,'
      ' BONUS,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=A.GOODSID) G' +
        'OODS_TITLE,'
      
        ' (SELECT TITLE FROM TDB_GOODS_BONUS2 WHERE TDB_GOODS_BONUS2.GBON' +
        'USID=A.GBONUSID) BONUS_TITLE'
      'FROM SP_CALC_SALE_BONUS3(:USERID,:DATE_START,:DATE_END) A')
    Left = 76
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'USERID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATE_START'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DATE_END'
        Value = nil
      end>
  end
  object IBCDataSourceBonus: TIBCDataSource
    DataSet = IBCQueryBonus
    Left = 76
    Top = 280
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT U.USERID, U.USER_FULLNAME, C.DISPLAYNAME FIRMA_NAME'
      'FROM GET_USERS_BY_USER2(1) U'
      'INNER JOIN TS_CUSTOMER C ON (C.CUSTOMERID=U.DEFAULT_DT)'
      'WHERE U.USERID>1'
      'ORDER BY U.DEFAULT_DT, 2')
    Left = 236
    Top = 224
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 236
    Top = 280
  end
end
