object frmCerereDePlataDBDlg: TfrmCerereDePlataDBDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cerere de plata'
  ClientHeight = 422
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 70
    Width = 545
    Height = 281
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 285
      Top = 27
      Width = 32
      Height = 15
      Alignment = taRightJustify
      Caption = 'Valuta'
      Transparent = True
    end
    object Label2: TLabel
      Left = 379
      Top = 27
      Width = 90
      Height = 15
      Caption = 'Rata Doc / Rata $'
      Transparent = True
    end
    object Label3: TLabel
      Left = 453
      Top = 50
      Width = 10
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = '/'
      Transparent = True
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 24
      Caption = 'Data planificata a platii'
      TabOrder = 0
    end
    object cxLabel2: TcxLabel
      Left = 144
      Top = 24
      Caption = 'Suma'
      TabOrder = 1
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 142
      Caption = 'Beneficiar'
      TabOrder = 4
    end
    object beCT: TcxButtonEdit
      Left = 8
      Top = 167
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ClickKey = 115
      Properties.OnButtonClick = beCustomerPropertiesButtonClick
      TabOrder = 5
      Width = 521
    end
    object cxLabel4: TcxLabel
      Left = 8
      Top = 194
      Caption = 'Mentiuni'
      TabOrder = 6
    end
    object dePaymentDate: TcxDBDateEdit
      Left = 8
      Top = 50
      DataBinding.DataField = 'DATA'
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 2
      Width = 121
    end
    object ceSuma: TcxDBCalcEdit
      Left = 146
      Top = 50
      DataBinding.DataField = 'SUMA'
      TabOrder = 7
      Width = 121
    end
    object cxDBMemo1: TcxDBMemo
      Left = 11
      Top = 219
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceDocProps
      TabOrder = 12
      Height = 46
      Width = 518
    end
    object beDT: TcxButtonEdit
      Left = 9
      Top = 113
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = beDTPropertiesButtonClick
      TabOrder = 3
      Width = 520
    end
    object cxLabel5: TcxLabel
      Left = 9
      Top = 88
      Caption = 'Platitor'
      TabOrder = 11
    end
    object ceRATE: TcxDBCalcEdit
      Left = 380
      Top = 50
      DataBinding.DataField = 'RATE'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 9
      Width = 69
    end
    object ceRATEUSD: TcxDBCalcEdit
      Left = 472
      Top = 50
      DataBinding.DataField = 'RATEUSD'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.ImmediatePost = True
      TabOrder = 10
      Width = 54
    end
    object lcbCURRENCY: TcxDBLookupComboBox
      Left = 293
      Top = 50
      DataBinding.DataField = 'CURRENCYID'
      DataBinding.DataSource = dmDB.IBCDataSourceDocs
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CURRENCYID'
      Properties.ListColumns = <
        item
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077
          Width = 150
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceCurrency
      TabOrder = 8
      Width = 73
    end
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 551
    Height = 64
    Title = 'Cerere de plata'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -15
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 92
  end
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 386
    Width = 551
    TabOrder = 2
  end
  object IBCQueryDocProps: TIBCQuery
    UpdatingTable = 'TDB_DOCS_PROPS'
    KeyFields = 'DOCID'
    SQLInsert.Strings = (
      'INSERT INTO TDB_DOCS_PROPS'
      '  (DOCID, INBAZA, COMMENTS)'
      'VALUES'
      '  (:DOCID, :INBAZA, :COMMENTS)')
    SQLUpdate.Strings = (
      'UPDATE TDB_DOCS_PROPS'
      'SET'
      '  INBAZA = :INBAZA, COMMENTS = :COMMENTS'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      'SELECT '
      ' INBAZA, '
      ' COMMENTS '
      'FROM '
      ' TDB_DOCS_PROPS'
      'WHERE'
      '  DOCID = :DOCID')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      '    DOCID,'
      '    INBAZA,'
      '    COMMENTS'
      'FROM'
      '    TDB_DOCS_PROPS')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    AutoCommit = False
    Left = 284
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDocProps: TIBCDataSource
    DataSet = IBCQueryDocProps
    Left = 284
    Top = 160
  end
end
