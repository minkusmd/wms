object frmContentCommentDlg: TfrmContentCommentDlg
  Left = 0
  Top = 0
  ActiveControl = cxButtonEdit1
  BorderStyle = bsDialog
  Caption = 'Mentiuni'
  ClientHeight = 311
  ClientWidth = 621
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxButtonEdit1: TcxButtonEdit
    Left = 16
    Top = 16
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
    TabOrder = 0
    Width = 585
  end
  object cxMemo1: TcxMemo
    Left = 16
    Top = 48
    ParentFont = False
    Properties.ScrollBars = ssVertical
    Style.Font.Charset = RUSSIAN_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 1
    Height = 209
    Width = 585
  end
  object btnOK: TcxButton
    Left = 200
    Top = 272
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBnt: TcxButton
    Left = 304
    Top = 272
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryComments: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_PACKAGE_GOODS_COMMENTS'
      '  (PACKAGEID, GOODSID, COMMENTS)'
      'VALUES'
      '  (:PACKAGEID, :GOODSID, :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM TS_PACKAGE_GOODS_COMMENTS'
      'WHERE'
      '  PACKAGEID = :Old_PACKAGEID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_PACKAGE_GOODS_COMMENTS'
      'SET'
      
        '  PACKAGEID = :PACKAGEID, GOODSID = :GOODSID, COMMENTS = :COMMEN' +
        'TS'
      'WHERE'
      '  PACKAGEID = :Old_PACKAGEID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT PACKAGEID, GOODSID, COMMENTS FROM TS_PACKAGE_GOODS_COMMEN' +
        'TS'
      'WHERE'
      '  PACKAGEID = :PACKAGEID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_PACKAGE_GOODS_COMMENTS'
      'WHERE'
      'PACKAGEID = :Old_PACKAGEID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_PACKAGE_GOODS_COMMENTS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from ts_package_goods_COMMENTS'
      'where packageid = :packageid and goodsid = :goodsid')
    AutoCommit = False
    Left = 296
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'packageid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQueryComments
    Left = 200
    Top = 152
  end
end
