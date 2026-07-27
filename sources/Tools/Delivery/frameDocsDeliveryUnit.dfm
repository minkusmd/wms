object frameDocsDelivery: TframeDocsDelivery
  Left = 0
  Top = 0
  Width = 581
  Height = 212
  TabOrder = 0
  DesignSize = (
    581
    212)
  object cxDBVerticalGrid1: TcxDBVerticalGrid
    Left = 0
    Top = 3
    Width = 578
    Height = 206
    Anchors = [akLeft, akTop, akRight, akBottom]
    LookAndFeel.NativeStyle = True
    OptionsView.RowHeaderWidth = 158
    Navigator.Buttons.CustomButtons = <>
    ScrollbarAnnotations.CustomAnnotations = <>
    TabOrder = 0
    DataController.DataSource = IBCDSDelivery
    Version = 1
    object cxDBVerticalGrid1DOCID: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'DOCID'
      Visible = False
      ID = 0
      ParentID = -1
      Index = 0
      Version = 1
    end
    object cxDBVerticalGrid1COURIERID: TcxDBEditorRow
      Properties.DataBinding.FieldName = 'COURIERID'
      Visible = False
      ID = 1
      ParentID = -1
      Index = 1
      Version = 1
    end
    object cxDBVerticalGrid1CategoryRow2: TcxCategoryRow
      Properties.Caption = 'Transportator'
      ID = 2
      ParentID = -1
      Index = 2
      Version = 1
    end
    object cxDBVerticalGrid1COURIER_NAME: TcxDBEditorRow
      Properties.Caption = 'Curier'
      Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
      Properties.EditProperties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.DataBinding.FieldName = 'COURIER_NAME'
      ID = 3
      ParentID = 2
      Index = 0
      Version = 1
    end
    object cxDBVerticalGrid1AWB: TcxDBEditorRow
      Properties.Caption = 'AWB #'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.DataBinding.FieldName = 'AWB'
      ID = 4
      ParentID = 2
      Index = 1
      Version = 1
    end
    object cxDBVerticalGrid1DBMultiEditorRow1: TcxDBMultiEditorRow
      Properties.Editors = <
        item
          Caption = 'Factura'
          EditPropertiesClassName = 'TcxCheckBoxProperties'
          EditProperties.ValueChecked = '1'
          EditProperties.ValueUnchecked = '0'
          Width = 40
          DataBinding.FieldName = 'FLG_INVOICE_ONDELIVERY'
        end
        item
          Caption = 'Numerar'
          EditPropertiesClassName = 'TcxCheckBoxProperties'
          EditProperties.ValueChecked = '1'
          EditProperties.ValueUnchecked = '0'
          Width = 60
          DataBinding.FieldName = 'FLG_CASHONDELIVERY'
        end>
      ID = 5
      ParentID = 2
      Index = 2
      Version = 1
    end
    object cxDBVerticalGrid1CategoryRow1: TcxCategoryRow
      Properties.Caption = 'Destinatar'
      ID = 6
      ParentID = -1
      Index = 3
      Version = 1
    end
    object cxDBVerticalGrid1DELIVERY_DATE: TcxDBEditorRow
      Properties.Caption = 'Data'
      Properties.EditPropertiesClassName = 'TcxDateEditProperties'
      Properties.DataBinding.FieldName = 'DELIVERY_DATE'
      ID = 7
      ParentID = 6
      Index = 0
      Version = 1
    end
    object cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow
      Properties.Caption = 'Ora'
      Properties.DataBinding.FieldName = 'DELIVERY_TIME'
      ID = 8
      ParentID = 6
      Index = 1
      Version = 1
    end
    object cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow
      Properties.Caption = 'Adresa'
      Properties.EditPropertiesClassName = 'TcxMemoProperties'
      Properties.EditProperties.VisibleLineCount = 2
      Properties.DataBinding.FieldName = 'DELIVERY_ADDRESS'
      ID = 9
      ParentID = 6
      Index = 2
      Version = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 171
    Width = 581
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object cxButton1: TcxButton
      Left = 496
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Sterge'
      TabOrder = 0
      OnClick = cxButton1Click
    end
  end
  object IBCQueryDelivery: TIBCQuery
    KeyFields = 'DOCID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_DOCS_DELIVERY'
      
        '  (DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVERY_TI' +
        'ME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVERY, T' +
        'RANSMIS_CURIER, AWB)'
      'VALUES'
      
        '  (:DOCID, :COURIERID, :COURIER_NAME, :DELIVERY_ADDRESS, :DELIVE' +
        'RY_TIME, :DELIVERY_DATE, :FLG_CASHONDELIVERY, :FLG_INVOICE_ONDEL' +
        'IVERY, :TRANSMIS_CURIER, :AWB)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_DOCS_DELIVERY'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_DOCS_DELIVERY'
      'SET'
      
        '  DOCID = :DOCID, COURIERID = :COURIERID, COURIER_NAME = :COURIE' +
        'R_NAME, '
      
        '  DELIVERY_ADDRESS = :DELIVERY_ADDRESS, DELIVERY_TIME = :DELIVER' +
        'Y_TIME, '
      
        '  DELIVERY_DATE = :DELIVERY_DATE, FLG_CASHONDELIVERY = :FLG_CASH' +
        'ONDELIVERY, '
      '  FLG_INVOICE_ONDELIVERY = :FLG_INVOICE_ONDELIVERY, '
      '  TRANSMIS_CURIER = :TRANSMIS_CURIER, AWB = :AWB'
      'WHERE'
      '  DOCID = :Old_DOCID')
    SQLRefresh.Strings = (
      
        'SELECT DOCID, COURIERID, COURIER_NAME, DELIVERY_ADDRESS, DELIVER' +
        'Y_TIME, DELIVERY_DATE, FLG_CASHONDELIVERY, FLG_INVOICE_ONDELIVER' +
        'Y, TRANSMIS_CURIER, AWB FROM VW_TDB_DOCS_DELIVERY'
      'WHERE'
      '  DOCID = :P_1_DOCID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_DOCS_DELIVERY'
      'WHERE'
      'DOCID = :Old_DOCID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_DOCS_DELIVERY'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select DOCID, COURIERID, COURIER_NAME, FLG_CASHONDELIVERY, '
      
        'DELIVERY_ADDRESS, DELIVERY_TIME, DELIVERY_DATE, FLG_INVOICE_ONDE' +
        'LIVERY,TRANSMIS_CURIER,'
      'AWB'
      'from VW_TDB_DOCS_DELIVERY DD  ')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = dmDB.IBCDataSourceDocs
    RefreshOptions = [roBeforeEdit]
    Left = 385
    Top = 97
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDSDelivery: TIBCDataSource
    DataSet = IBCQueryDelivery
    Left = 385
    Top = 53
  end
end
