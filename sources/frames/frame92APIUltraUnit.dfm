inherited frame92APIUltra: Tframe92APIUltra
  Width = 794
  Height = 609
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 794
  ExplicitHeight = 609
  object lbTimer: TLabel
    Left = 6
    Top = 62
    Width = 21
    Height = 15
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '0:00'
  end
  object Label2: TLabel
    Left = 6
    Top = 10
    Width = 40
    Height = 15
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1057#1077#1088#1074#1080#1089
  end
  object Label1: TLabel
    Left = 421
    Top = 79
    Width = 63
    Height = 15
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Curs valutar'
  end
  object Button1: TButton
    Left = 204
    Top = 24
    Width = 78
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '1. Get data'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object edUUID: TEdit
    Left = 6
    Top = 79
    Width = 399
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 6
    Top = 23
    Width = 187
    Height = 23
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ExtendedUI = True
    ItemIndex = 0
    TabOrder = 0
    Text = 'NOMENCLATURE & PRICELIST'
    Items.Strings = (
      'NOMENCLATURE & PRICELIST'
      'NOMENCLATURE'
      'PROPERTIES'
      'NOMENCLATURETYPELIST'
      'BRAND'
      'PARENTLIST'
      'PRICELIST'
      'BALANCE'
      'RATES')
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 594
    Width = 794
    Height = 15
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Panels = <>
    SimplePanel = True
  end
  object ProgressBar1: TProgressBar
    Left = 6
    Top = 48
    Width = 782
    Height = 14
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object ListBox1: TListBox
    Left = 480
    Top = 77
    Width = 308
    Height = 20
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Columns = 2
    ItemHeight = 15
    TabOrder = 4
  end
  object cxGrid1: TcxGrid
    Left = 8
    Top = 102
    Width = 784
    Height = 488
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 6
    object cxGrid1DBTableView1: TcxGridDBTableView
      DataController.DataSource = IBCDataSource1
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.MultiSelect = True
      OptionsSelection.CellMultiSelect = True
      OptionsSelection.InvertSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1CODE: TcxGridDBColumn
        DataBinding.FieldName = 'CODE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 66
        Options.HorzSizing = False
        Width = 66
      end
      object cxGrid1DBTableView1FULLNAME: TcxGridDBColumn
        DataBinding.FieldName = 'FULLNAME'
        HeaderAlignmentHorz = taCenter
        MinWidth = 16
        Width = 376
      end
      object cxGrid1DBTableView1PRICE: TcxGridDBColumn
        Caption = 'Price S'
        DataBinding.FieldName = 'PRICE'
        HeaderAlignmentHorz = taCenter
        MinWidth = 94
        Options.HorzSizing = False
        Width = 94
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Button2: TButton
    Left = 287
    Top = 23
    Width = 60
    Height = 20
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '2. Parse'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 352
    Top = 23
    Width = 78
    Height = 20
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '3. Price "S"'
    TabOrder = 8
    OnClick = Button3Click
  end
  object lbOperation: TcxLabel
    Left = 287
    Top = 59
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'lbOperation'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -12
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 9
  end
  object HTTPRIO1: THTTPRIO
    WSDLLocation = 'https://web1c.it-ultra.com/b2b/ws/b2b.1cws?wsdl'
    Service = 'b2b'
    Port = 'b2bSoap'
    HTTPWebNode.UserName = 'SimionI'
    HTTPWebNode.Password = 'yYw3nv'
    HTTPWebNode.UseDefaultCredentials = False
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 408
    Top = 280
  end
  object IBCSQLNomenclature: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      
        'insert into TAPI_ULTRA_NOMENCLATURE (UUID, PARENT, CODE, NAME, N' +
        'OMENCLATURETYPE,'
      
        '                                     MAINIMAGE, ARTICLE, BRAND, ' +
        'FULLNAME,'
      '                                     ISACTIVE, WARRANTY)'
      
        'values (:UUID, :PARENT, :CODE, :NAME, :NOMENCLATURETYPE, :MAINIM' +
        'AGE, :ARTICLE,'
      '        :BRAND, :FULLNAME, :ISACTIVE, :WARRANTY)')
    AutoCommit = True
    Left = 88
    Top = 177
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'PARENT'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'CODE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'NAME'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'NOMENCLATURETYPE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'MAINIMAGE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ARTICLE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'BRAND'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'FULLNAME'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'ISACTIVE'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'WARRANTY'
        Value = nil
      end>
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 272
    Top = 176
  end
  object IBCTrSelect: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 360
    Top = 176
  end
  object IBCSQL1: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    AutoCommit = True
    Left = 184
    Top = 176
  end
  object IBCSQLImages: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      
        'insert into TAPI_ULTRA_IMAGES (GOODS_UUID, UUID, PATHGLOBAL, NAM' +
        'E)'
      'values (:GOODS_UUID, :UUID, :PATHGLOBAL, :NAME)')
    AutoCommit = True
    Left = 88
    Top = 233
    ParamData = <
      item
        DataType = ftString
        Name = 'GOODS_UUID'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'PATHGLOBAL'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'NAME'
        Value = nil
      end>
  end
  object IBCSQLDsc: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'insert into TAPI_ULTRA_DSC (UUID, DESCRIPTION)'
      'values (:UUID, :DESCRIPTION)')
    AutoCommit = True
    Left = 88
    Top = 289
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DESCRIPTION'
        Value = nil
      end>
  end
  object IBCSQLPRICELIST: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCTrUpdate
    SQL.Strings = (
      'insert into tapi_ultra_pricelist (uuid, pricetype, price)'
      'values (:uuid, :pricetype, :price)')
    AutoCommit = True
    Left = 184
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'UUID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'pricetype'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'price'
        Value = nil
      end>
  end
  object IBCQuery1: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select n.code, n.fullname, n.brand, n.article, p.price from tapi' +
        '_ultra_nomenclature n'
      
        'join tapi_ultra_pricelist p on p.uuid = n.uuid and p.pricetype='#39 +
        'S'#39)
    Left = 480
    Top = 232
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQuery1
    Left = 480
    Top = 176
  end
end
