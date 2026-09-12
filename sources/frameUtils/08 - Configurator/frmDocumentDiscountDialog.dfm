object frmDocumentDiscountDlg: TfrmDocumentDiscountDlg
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1076#1086#1082#1091#1084#1077#1085#1090
  ClientHeight = 347
  ClientWidth = 410
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 410
    Height = 64
    Title = #1057#1082#1080#1076#1082#1072' '#1085#1072' '#1076#1086#1082#1091#1084#1077#1085#1090
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1082#1072#1082#1091#1102' '#1089#1082#1080#1076#1082#1091' '#1087#1088#1080#1084#1077#1085#1080#1090#1100' '#1076#1083#1103' '#1101#1090#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
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
    ImageIndex = 4
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 394
    Height = 221
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object pnTop: TPanel
      Left = 0
      Top = 0
      Width = 390
      Height = 217
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        Left = 20
        Top = 24
        Width = 99
        Height = 15
        Caption = #1057#1091#1084#1084#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      end
      object Label2: TLabel
        Left = 20
        Top = 176
        Width = 159
        Height = 15
        Caption = #1048#1090#1086#1075#1086#1074#1072#1103' '#1089#1091#1084#1084#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 342
        Top = 24
        Width = 25
        Height = 15
        Caption = #1083#1077#1077#1074
      end
      object Label4: TLabel
        Left = 342
        Top = 176
        Width = 25
        Height = 15
        Caption = #1083#1077#1077#1074
      end
      object Label5: TLabel
        Left = 342
        Top = 80
        Width = 25
        Height = 15
        Caption = #1083#1077#1077#1074
      end
      object Label8: TLabel
        Left = 342
        Top = 109
        Width = 10
        Height = 15
        Caption = '%'
      end
      object rbBySuma: TRadioButton
        Left = 20
        Top = 80
        Width = 193
        Height = 17
        Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1072#1103' '#1089#1091#1084#1084#1072
        TabOrder = 2
        OnClick = rbBySumaClick
      end
      object rbByPercent: TRadioButton
        Left = 20
        Top = 109
        Width = 193
        Height = 17
        Caption = #1055#1088#1086#1094#1077#1085#1090' '#1086#1090' '#1089#1091#1084#1084#1099' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        TabOrder = 4
        OnClick = rbBySumaClick
      end
      object edSUMA: TcxDBCurrencyEdit
        Left = 219
        Top = 21
        TabStop = False
        DataBinding.DataField = 'SUMA'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 117
      end
      object edSUMA_FINAL: TcxCurrencyEdit
        Left = 219
        Top = 173
        TabStop = False
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.ReadOnly = True
        TabOrder = 5
        Width = 117
      end
      object edDiscount_Suma: TcxCurrencyEdit
        Left = 219
        Top = 77
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.OnEditValueChanged = edDiscount_SumaPropertiesEditValueChanged
        TabOrder = 1
        Width = 117
      end
      object edDiscount_Percent: TcxCurrencyEdit
        Left = 219
        Top = 106
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '#,##0.00'
        Properties.OnEditValueChanged = edDiscount_SumaPropertiesEditValueChanged
        TabOrder = 3
        Width = 117
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 301
    Width = 410
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      410
      46)
    object btnOk: TcxButton
      Left = 198
      Top = 4
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 302
      Top = 4
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
  object IBCQueryDisc: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_ADDONS'
      '  (DOCID, DISCOUNT_SUM, DISCOUNT_PERCENT, DISCOUNT_FLG)'
      'VALUES'
      '  (:DOCID, :DISCOUNT_SUM, :DISCOUNT_PERCENT, :DISCOUNT_FLG)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_DOCS_ADDONS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_ADDONS'
      'SET'
      ' DOCID = :DOCID, '
      ' DISCOUNT_SUM = :DISCOUNT_SUM, '
      ' DISCOUNT_PERCENT = :DISCOUNT_PERCENT, '
      ' DISCOUNT_FLG = :DISCOUNT_FLG'
      'WHERE'
      ' DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT '
      ' DOCID, '
      ' DISCOUNT_SUM, '
      ' DISCOUNT_PERCENT, '
      ' DISCOUNT_FLG '
      'FROM '
      ' TDB_DOCS_ADDONS'
      'WHERE'
      ' DOCID = :DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_ADDONS'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM TDB_DOCS_ADDONS WHERE DOCID=:docID')
    AutoCommit = False
    LockMode = lmLockImmediate
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 252
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docID'
        Value = nil
      end>
  end
  object IBCDataSourceDisc: TIBCDataSource
    DataSet = IBCQueryDisc
    Left = 120
    Top = 388
  end
end
