object frmBlockedIpDlg: TfrmBlockedIpDlg
  Left = 0
  Top = 0
  Caption = 'Gestiunea IP-urilor blocate'
  ClientHeight = 560
  ClientWidth = 1000
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1000
    560)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1000
    Height = 64
    Title = 'Gestiunea IP-urilor blocate'
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
  object pnTop: TPanel
    Left = 0
    Top = 64
    Width = 1000
    Height = 44
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbSearch: TLabel
      Left = 528
      Top = 14
      Width = 44
      Height = 15
      Caption = 'Cauta IP'
    end
    object rgFilter: TcxRadioGroup
      Left = 8
      Top = 2
      Caption = 'Filtru'
      Properties.Columns = 4
      Properties.Items = <
        item
          Caption = 'Blocate acum'
        end
        item
          Caption = 'Toate'
        end
        item
          Caption = 'Manuale'
        end
        item
          Caption = 'Lista alba'
        end>
      Properties.OnChange = rgFilterPropertiesChange
      ItemIndex = 0
      TabOrder = 0
      Height = 40
      Width = 500
    end
    object edSearch: TcxTextEdit
      Left = 584
      Top = 11
      Properties.OnChange = edSearchPropertiesChange
      TabOrder = 1
      Width = 200
    end
    object btnRefresh: TcxButton
      Left = 800
      Top = 9
      Width = 110
      Height = 27
      Caption = 'Actualizeaza'
      TabOrder = 2
      OnClick = btnRefreshClick
    end
  end
  object cxGridIps: TcxGrid
    Left = 8
    Top = 116
    Width = 984
    Height = 388
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridIpsTable: TcxGridDBTableView
      OnCellDblClick = cxGridIpsTableCellDblClick
      OnCustomDrawCell = cxGridIpsTableCustomDrawCell
      DataController.DataSource = IBCDataSourceIps
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.GroupByBox = False
      object cxGridIps_BLOCKID: TcxGridDBColumn
        DataBinding.FieldName = 'BLOCKID'
        Visible = False
      end
      object cxGridIps_STATE_CODE: TcxGridDBColumn
        DataBinding.FieldName = 'STATE_CODE'
        Visible = False
      end
      object cxGridIps_IP_ADDRESS: TcxGridDBColumn
        Caption = 'Adresa IP'
        DataBinding.FieldName = 'IP_ADDRESS'
        Width = 130
      end
      object cxGridIps_STATE_NAME: TcxGridDBColumn
        Caption = 'Stare'
        DataBinding.FieldName = 'STATE_NAME'
        Width = 110
      end
      object cxGridIps_SOURCE_NAME: TcxGridDBColumn
        Caption = 'Sursa'
        DataBinding.FieldName = 'SOURCE_NAME'
        Width = 70
      end
      object cxGridIps_REASON: TcxGridDBColumn
        Caption = 'Motiv'
        DataBinding.FieldName = 'REASON'
        Width = 190
      end
      object cxGridIps_BLOCKED_AT: TcxGridDBColumn
        Caption = 'Blocat la'
        DataBinding.FieldName = 'BLOCKED_AT'
        Width = 120
      end
      object cxGridIps_EXPIRES_AT: TcxGridDBColumn
        Caption = 'Expira la'
        DataBinding.FieldName = 'EXPIRES_AT'
        Width = 120
      end
      object cxGridIps_BLOCK_COUNT: TcxGridDBColumn
        Caption = 'Blocari'
        DataBinding.FieldName = 'BLOCK_COUNT'
        Width = 60
      end
      object cxGridIps_REQ_COUNT: TcxGridDBColumn
        Caption = 'Cereri'
        DataBinding.FieldName = 'REQ_COUNT'
        Width = 60
      end
      object cxGridIps_LAST_HIT_AT: TcxGridDBColumn
        Caption = 'Ultima cerere'
        DataBinding.FieldName = 'LAST_HIT_AT'
        Width = 120
      end
      object cxGridIps_CREATED_BY: TcxGridDBColumn
        Caption = 'Adaugat de'
        DataBinding.FieldName = 'CREATED_BY'
        Width = 110
      end
      object cxGridIps_NOTE: TcxGridDBColumn
        Caption = 'Nota'
        DataBinding.FieldName = 'NOTE'
        Width = 160
      end
    end
    object cxGridIpsLevel: TcxGridLevel
      GridView = cxGridIpsTable
    end
  end
  object btnAdd: TcxButton
    Left = 8
    Top = 516
    Width = 120
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Blocheaza IP'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btnEdit: TcxButton
    Left = 134
    Top = 516
    Width = 100
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Modifica'
    TabOrder = 3
    OnClick = btnEditClick
  end
  object btnUnblock: TcxButton
    Left = 240
    Top = 516
    Width = 120
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Deblocheaza'
    TabOrder = 4
    OnClick = btnUnblockClick
  end
  object btnDelete: TcxButton
    Left = 366
    Top = 516
    Width = 100
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Sterge'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object btnClose: TcxButton
    Left = 892
    Top = 516
    Width = 100
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
  object IBCQueryIps: TIBCQuery
    KeyFields = 'BLOCKID'
    SQL.Strings = (
      'SELECT * FROM TWEB_BLOCKED_IP')
    AutoCommit = False
    Left = 48
    Top = 152
  end
  object IBCDataSourceIps: TIBCDataSource
    DataSet = IBCQueryIps
    Left = 128
    Top = 152
  end
  object IBCTransactionUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 152
  end
end
