object frmLoanDlg: TfrmLoanDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Credite'
  ClientHeight = 451
  ClientWidth = 801
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 8
    Top = 32
    Width = 786
    Height = 411
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Visible = True
      DataController.DataSource = IBCDataSourceLoan
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1LOANID: TcxGridDBColumn
        DataBinding.FieldName = 'LOANID'
      end
      object cxGrid1DBTableView1TITLE: TcxGridDBColumn
        DataBinding.FieldName = 'TITLE'
        Width = 209
      end
      object cxGrid1DBTableView1MONTHS: TcxGridDBColumn
        DataBinding.FieldName = 'MONTHS'
      end
      object cxGrid1DBTableView1CUST_PAY_M_AMOUNT: TcxGridDBColumn
        DataBinding.FieldName = 'CUST_PAY_M_AMOUNT'
      end
      object cxGrid1DBTableView1OUR_PAY_PERCENT: TcxGridDBColumn
        DataBinding.FieldName = 'OUR_PAY_PERCENT'
      end
      object cxGrid1DBTableView1CUST_PREPAY_AMOUNT: TcxGridDBColumn
        DataBinding.FieldName = 'CUST_PREPAY_AMOUNT'
      end
      object cxGrid1DBTableView1CUST_PREPAY_PERCENT: TcxGridDBColumn
        DataBinding.FieldName = 'CUST_PREPAY_PERCENT'
      end
      object cxGrid1DBTableView1CUST_MONTHLY_COMISION: TcxGridDBColumn
        DataBinding.FieldName = 'CUST_MONTHLY_COMISION'
      end
      object cxGrid1DBTableView1LOAN_IMAGE: TcxGridDBColumn
        DataBinding.FieldName = 'LOAN_IMAGE'
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object IBCQueryLoan: TIBCQuery
    KeyFields = 'LOANID'
    KeyGenerator = 'gen_ts_loans_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_LOANS'
      
        '  (LOANID, TITLE, MONTHS, CUST_PAY_M_AMOUNT, OUR_PAY_PERCENT, CU' +
        'ST_PREPAY_AMOUNT, CUST_PREPAY_PERCENT, CUST_MONTHLY_COMISION)'
      'VALUES'
      
        '  (:LOANID, :TITLE, :MONTHS, :CUST_PAY_M_AMOUNT, :OUR_PAY_PERCEN' +
        'T, :CUST_PREPAY_AMOUNT, :CUST_PREPAY_PERCENT, :CUST_MONTHLY_COMI' +
        'SION)')
    SQLDelete.Strings = (
      'DELETE FROM TS_LOANS'
      'WHERE'
      '  LOANID = :Old_LOANID')
    SQLUpdate.Strings = (
      'UPDATE TS_LOANS'
      'SET'
      
        '  LOANID = :LOANID, TITLE = :TITLE, MONTHS = :MONTHS, CUST_PAY_M' +
        '_AMOUNT = :CUST_PAY_M_AMOUNT, OUR_PAY_PERCENT = :OUR_PAY_PERCENT' +
        ', CUST_PREPAY_AMOUNT = :CUST_PREPAY_AMOUNT, CUST_PREPAY_PERCENT ' +
        '= :CUST_PREPAY_PERCENT, CUST_MONTHLY_COMISION = :CUST_MONTHLY_CO' +
        'MISION'
      'WHERE'
      '  LOANID = :Old_LOANID')
    SQLRefresh.Strings = (
      
        'SELECT LOANID, TITLE, MONTHS, CUST_PAY_M_AMOUNT, OUR_PAY_PERCENT' +
        ', CUST_PREPAY_AMOUNT, CUST_PREPAY_PERCENT, CUST_MONTHLY_COMISION' +
        ' FROM TS_LOANS'
      'WHERE'
      '  LOANID = :LOANID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_LOANS'
      'WHERE'
      'LOANID = :Old_LOANID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_LOANS'
      ''
      ') q')
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      'select * From ts_loans'
      'order by loanid')
    Options.RequiredFields = False
    LocalConstraints = False
    Constraints = <>
    Left = 336
    Top = 168
  end
  object IBCDataSourceLoan: TIBCDataSource
    DataSet = IBCQueryLoan
    Left = 216
    Top = 160
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 392
    Top = 224
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 836
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbNew'
        end
        item
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          Visible = True
          ItemName = 'bbDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbNew: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 0
      OnClick = bbNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 1
      OnClick = bbEditClick
    end
    object bbDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 2
      PaintStyle = psCaptionGlyph
      OnClick = bbDeleteClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Salveaza si inchide'
      Category = 0
      Hint = 'Salveaza si inchide'
      Visible = ivAlways
      ImageIndex = 76
      PaintStyle = psCaptionGlyph
      OnClick = dxBarButton1Click
    end
  end
  object IBCTrUpdate: TIBCTransaction
    Left = 472
    Top = 176
  end
end
