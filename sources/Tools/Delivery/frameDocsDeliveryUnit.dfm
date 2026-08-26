object frameDocsDelivery: TframeDocsDelivery
  Left = 0
  Top = 0
  Width = 476
  Height = 280
  TabOrder = 0
  object lbEmptyHint: TLabel
    Left = 0
    Top = 0
    Width = 476
    Height = 60
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption =
      'Documentul nu are date de livrare.'#13#10'Apasati "Adauga" pentru a l' +
      'e completa.'
    Layout = tlCenter
    WordWrap = True
    ExplicitWidth = 470
  end
  object cxDBVerticalGrid1: TcxDBVerticalGrid
    Left = 0
    Top = 60
    Width = 476
    Height = 183
    Align = alClient
    LookAndFeel.NativeStyle = True
    OptionsView.RowHeaderWidth = 130
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
      Properties.EditProperties.ViewStyle = vsHideCursor
      Properties.EditProperties.OnButtonClick = cxDBVerticalGrid1COURIER_NAMEEditPropertiesButtonClick
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
          EditProperties.Alignment = taLeftJustify
          EditProperties.NullStyle = nssUnchecked
          EditProperties.ValueChecked = '1'
          EditProperties.ValueUnchecked = '0'
          Width = 70
          DataBinding.FieldName = 'FLG_INVOICE_ONDELIVERY'
        end
        item
          Caption = 'Numerar'
          EditPropertiesClassName = 'TcxCheckBoxProperties'
          EditProperties.Alignment = taLeftJustify
          EditProperties.NullStyle = nssUnchecked
          EditProperties.ValueChecked = '1'
          EditProperties.ValueUnchecked = '0'
          Width = 70
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
      Properties.EditProperties.SaveTime = False
      Properties.EditProperties.ShowTime = False
      Properties.DataBinding.FieldName = 'DELIVERY_DATE'
      ID = 7
      ParentID = 6
      Index = 0
      Version = 1
    end
    object cxDBVerticalGrid1DELIVERY_TIME: TcxDBEditorRow
      Properties.Caption = 'Ora'
      Properties.EditPropertiesClassName = 'TcxTextEditProperties'
      Properties.DataBinding.FieldName = 'DELIVERY_TIME'
      ID = 8
      ParentID = 6
      Index = 1
      Version = 1
    end
    object cxDBVerticalGrid1DELIVERY_ADDRESS: TcxDBEditorRow
      Properties.Caption = 'Adresa'
      Properties.EditPropertiesClassName = 'TcxMemoProperties'
      Properties.EditProperties.ScrollBars = ssVertical
      Properties.EditProperties.VisibleLineCount = 3
      Properties.DataBinding.FieldName = 'DELIVERY_ADDRESS'
      ID = 9
      ParentID = 6
      Index = 2
      Version = 1
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 243
    Width = 476
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object btnAddDelivery: TcxButton
      Left = 0
      Top = 6
      Width = 100
      Height = 27
      Caption = 'Adauga'
      TabOrder = 0
      OnClick = btnAddDeliveryClick
    end
    object btnDeleteDelivery: TcxButton
      Left = 106
      Top = 6
      Width = 100
      Height = 27
      Caption = 'Sterge'
      TabOrder = 1
      OnClick = btnDeleteDeliveryClick
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
    Left = 336
    Top = 100
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDSDelivery: TIBCDataSource
    DataSet = IBCQueryDelivery
    OnStateChange = IBCDSDeliveryStateChange
    OnDataChange = IBCDSDeliveryDataChange
    Left = 336
    Top = 156
  end
end
