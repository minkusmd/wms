object frmShowWebGoodsProperties: TfrmShowWebGoodsProperties
  Left = 0
  Top = 0
  ActiveControl = teNameRO
  Caption = 'Web proprietati ale produselor'
  ClientHeight = 226
  ClientWidth = 985
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    985
    226)
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 985
    Height = 64
    Title = 'SEO rewrite pentru produse'
    Text = 'Meta tag-uri'
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
    ExplicitWidth = 852
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 969
    Height = 108
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 836
    ExplicitHeight = 327
    object cxLabel8: TcxLabel
      Left = 24
      Top = 43
      Caption = 'Name RU'
      Transparent = True
    end
    object teNameRU: TcxDBTextEdit
      Left = 80
      Top = 39
      DataBinding.DataField = 'NAME_RU'
      DataBinding.DataSource = IBCDataSourceWebGoods
      TabOrder = 1
      OnKeyDown = FormKeyDown
      Width = 873
    end
    object teNameRO: TcxDBTextEdit
      Left = 80
      Top = 12
      DataBinding.DataField = 'NAME_RO'
      DataBinding.DataSource = IBCDataSourceWebGoods
      TabOrder = 0
      OnKeyDown = FormKeyDown
      Width = 873
    end
    object cxLabel9: TcxLabel
      Left = 24
      Top = 16
      Caption = 'Name RO'
      Transparent = True
    end
    object cxButton1: TcxButton
      Left = 848
      Top = 68
      Width = 105
      Height = 25
      Caption = 'Completeaza'
      TabOrder = 2
      OnClick = cxButton1Click
    end
  end
  object btnOK: TcxButton
    Left = 445
    Top = 193
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitLeft = 312
    ExplicitTop = 412
  end
  object btnCancel: TcxButton
    Left = 550
    Top = 193
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitLeft = 417
    ExplicitTop = 412
  end
  object IBCQueryWebGoods: TIBCQuery
    KeyFields = 'GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_GOODS'
      '  (GOODSID, NAME_RO, NAME_RU)'
      'VALUES'
      '  (:GOODSID, :NAME_RO, :NAME_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_GOODS'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_GOODS'
      'SET'
      '  GOODSID = :GOODSID, NAME_RO = :NAME_RO, NAME_RU = :NAME_RU'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT GOODSID, NAME_RO, NAME_RU FROM TWEB_GOODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrLocalUpdate
    SQL.Strings = (
      'select * from tweb_goods where goodsid=:goodsid')
    AfterInsert = IBCQueryWebGoodsAfterInsert
    Left = 648
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceWebGoods: TIBCDataSource
    DataSet = IBCQueryWebGoods
    Left = 648
    Top = 16
  end
  object IBCTrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 512
    Top = 16
  end
end
