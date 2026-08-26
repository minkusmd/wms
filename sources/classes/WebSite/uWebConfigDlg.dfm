object frmWebConfigDlg: TfrmWebConfigDlg
  Left = 0
  Top = 0
  Caption = 'Configuratie site'
  ClientHeight = 565
  ClientWidth = 1145
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  DesignSize = (
    1145
    565)
  TextHeight = 13
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1145
    Height = 64
    Title = 'Configuratie site'
    Text = 'Gestionarea elementelor statice pe site'
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -17
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -13
    FontText.Name = 'Segoe UI'
    FontText.Style = []
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 70
    Width = 417
    Height = 453
    Anchors = [akLeft, akTop, akBottom]
    TabOrder = 1
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      Navigator.Visible = True
      ScrollbarAnnotations.CustomAnnotations = <>
      DataController.DataSource = IBCDataSourceWebSite
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1DT: TcxGridDBColumn
        DataBinding.FieldName = 'DT'
      end
      object cxGrid1DBTableView1ID: TcxGridDBColumn
        DataBinding.FieldName = 'ID'
      end
      object cxGrid1DBTableView1ORDERNO: TcxGridDBColumn
        DataBinding.FieldName = 'ORDERNO'
      end
      object cxGrid1DBTableView1CATEGORY: TcxGridDBColumn
        DataBinding.FieldName = 'CATEGORY'
        Width = 150
      end
      object cxGrid1DBTableView1URL: TcxGridDBColumn
        DataBinding.FieldName = 'URL'
        Width = 163
      end
      object cxGrid1DBTableView1NAME_RO: TcxGridDBColumn
        DataBinding.FieldName = 'NAME_RO'
        Width = 100
      end
      object cxGrid1DBTableView1NAME_RU: TcxGridDBColumn
        DataBinding.FieldName = 'NAME_RU'
        Width = 100
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 524
    Width = 1145
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object cxButton1: TcxButton
      Left = 1042
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Inchide'
      ModalResult = 8
      TabOrder = 0
    end
  end
  object DBSynEdit1: TDBSynEdit
    Left = 431
    Top = 70
    Width = 707
    Height = 453
    Cursor = crIBeam
    DataField = 'JSONOBJECT'
    DataSource = IBCDataSourceWebSite
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Font.Quality = fqClearTypeNatural
    ParentColor = False
    ParentFont = False
    TabOrder = 2
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Consolas'
    Gutter.Font.Style = []
    Gutter.Bands = <
      item
        Kind = gbkMarks
        Width = 13
      end
      item
        Kind = gbkLineNumbers
      end
      item
        Kind = gbkFold
      end
      item
        Kind = gbkTrackChanges
      end
      item
        Kind = gbkMargin
        Width = 3
      end>
    Highlighter = SynJSONSyn1
    SearchEngine = SynEditSearch1
    SelectedColor.Alpha = 0.400000005960464500
  end
  object IBCQueryWebSite: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEBSITE'
      '  (ID, ORDERNO, CATEGORY, NAME_RO, NAME_RU, URL, JSONOBJECT, DT)'
      'VALUES'
      
        '  (:ID, :ORDERNO, :CATEGORY, :NAME_RO, :NAME_RU, :URL, :JSONOBJE' +
        'CT, :DT)')
    SQLDelete.Strings = (
      'DELETE FROM TWEBSITE'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE TWEBSITE'
      'SET'
      
        '  ID = :ID, ORDERNO = :ORDERNO, CATEGORY = :CATEGORY, NAME_RO = ' +
        ':NAME_RO, NAME_RU = :NAME_RU, URL = :URL, JSONOBJECT = :JSONOBJE' +
        'CT, DT = :DT'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT ID, ORDERNO, CATEGORY, NAME_RO, NAME_RU, URL, JSONOBJECT,' +
        ' DT FROM TWEBSITE'
      'WHERE'
      '  ID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEBSITE'
      'WHERE'
      'ID = :Old_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEBSITE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from twebsite order by category')
    Left = 352
    Top = 336
  end
  object IBCDataSourceWebSite: TIBCDataSource
    DataSet = IBCQueryWebSite
    Left = 256
    Top = 344
  end
  object SynJSONSyn1: TSynJSONSyn
    Left = 128
    Top = 336
  end
  object SynEditSearch1: TSynEditSearch
    Left = 128
    Top = 384
  end
end
