object frmDealsBrowserDlg: TfrmDealsBrowserDlg
  Left = 0
  Top = 0
  Caption = 'Deal-uri'
  ClientHeight = 640
  ClientWidth = 1180
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1180
    640)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1180
    Height = 64
    Title = 'Deal-uri'
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
    Width = 1180
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbFrom: TLabel
      Left = 12
      Top = 12
      Width = 60
      Height = 15
      Caption = 'Create de la'
    end
    object lbSearch: TLabel
      Left = 520
      Top = 12
      Width = 80
      Height = 15
      Caption = 'Client / telefon'
    end
    object dtFrom: TDateTimePicker
      Left = 84
      Top = 8
      Width = 110
      Height = 23
      Date = 46000.000000000000000000
      Time = 46000.000000000000000000
      TabOrder = 0
    end
    object chkOnlyOpen: TCheckBox
      Left = 212
      Top = 11
      Width = 130
      Height = 17
      Caption = 'Doar deschise'
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object chkWithBalance: TCheckBox
      Left = 348
      Top = 11
      Width = 150
      Height = 17
      Caption = 'Cu rest de plata'
      TabOrder = 2
      OnClick = btnRefreshClick
    end
    object edSearch: TEdit
      Left = 612
      Top = 8
      Width = 220
      Height = 23
      TabOrder = 3
      OnKeyPress = edSearchKeyPress
    end
    object btnRefresh: TcxButton
      Left = 844
      Top = 5
      Width = 110
      Height = 29
      Caption = 'Reincarca'
      TabOrder = 4
      OnClick = btnRefreshClick
    end
  end
  object cxGridDeals: TcxGrid
    Left = 8
    Top = 110
    Width = 1164
    Height = 476
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridDealsTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      OnCellDblClick = cxGridDealsTableCellDblClick
      DataController.DataSource = dsDeals
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
    end
    object cxGridDealsLevel: TcxGridLevel
      GridView = cxGridDealsTable
    end
  end
  object btnOpen: TcxButton
    Left = 8
    Top = 598
    Width = 140
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Deschide fisa'
    TabOrder = 2
    OnClick = btnOpenClick
  end
  object btnSelect: TcxButton
    Left = 946
    Top = 598
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = 'Alege'
    TabOrder = 3
    OnClick = btnSelectClick
  end
  object btnClose: TcxButton
    Left = 1062
    Top = 598
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 4
  end
  object trRead: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 48
    Top = 160
  end
  object qDeals: TIBCQuery
    Transaction = trRead
    Left = 112
    Top = 160
  end
  object dsDeals: TIBCDataSource
    DataSet = qDeals
    Left = 176
    Top = 160
  end
end
