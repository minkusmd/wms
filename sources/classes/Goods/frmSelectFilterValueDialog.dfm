object frmSelectFilterValueDlg: TfrmSelectFilterValueDlg
  Left = 0
  Top = 0
  Caption = 'Alegeti valoarea'
  ClientHeight = 500
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 620
    Height = 64
    Title = 'Alegeti valoarea'
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
    ImageIndex = 16
  end
  object cxGridVal: TcxGrid
    Left = 0
    Top = 64
    Width = 620
    Height = 388
    Align = alClient
    TabOrder = 0
    object cxGridValTable: TcxGridDBTableView
      OnDblClick = cxGridValTableDblClick
      DataController.DataSource = IBCDataSourceValues
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
      object cxGridVal_PARAM_VALUE: TcxGridDBColumn
        Caption = 'Valoare RO'
        DataBinding.FieldName = 'PARAM_VALUE'
        Width = 300
      end
      object cxGridVal_PARAM_VALUE_RUS: TcxGridDBColumn
        Caption = 'Valoare RU'
        DataBinding.FieldName = 'PARAM_VALUE_RUS'
        Width = 280
      end
    end
    object cxGridValLevel: TcxGridLevel
      GridView = cxGridValTable
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 452
    Width = 620
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      620
      48)
    object btnNewValue: TcxButton
      Left = 8
      Top = 9
      Width = 120
      Height = 29
      Caption = 'Valoare noua'
      TabOrder = 0
      OnClick = btnNewValueClick
    end
    object btnOk: TcxButton
      Left = 406
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TcxButton
      Left = 502
      Top = 9
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 2
    end
  end
  object IBCTransactionSelect: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 40
    Top = 120
  end
  object IBCQueryValues: TIBCQuery
    KeyFields = 'FILTERPARAMID'
    KeyGenerator = 'SQ_TS_FILTER_PARAMS_ID'
    Connection = dmDB.IBCConnection
    Transaction = IBCTransactionSelect
    SQL.Strings = (
      'SELECT FILTERPARAMID, FILTERID, PARAM_VALUE, PARAM_VALUE_RUS, ORDERNO'
      '  FROM TS_FILTER_PARAMS'
      ' WHERE FILTERID = :fid'
      ' ORDER BY ORDERNO, PARAM_VALUE')
    Left = 120
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fid'
        Value = nil
      end>
  end
  object IBCDataSourceValues: TIBCDataSource
    DataSet = IBCQueryValues
    Left = 200
    Top = 120
  end
end
