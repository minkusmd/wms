object frmDealPaymentsDlg: TfrmDealPaymentsDlg
  Left = 0
  Top = 0
  Caption = 'Incasari si deal-uri'
  ClientHeight = 640
  ClientWidth = 1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    1100
    640)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1100
    Height = 64
    Title = 'Incasari nelegate de deal-uri'
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
    Width = 1100
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lbFrom: TLabel
      Left = 12
      Top = 12
      Width = 60
      Height = 15
      Caption = 'De la data'
    end
    object lbSearch: TLabel
      Left = 420
      Top = 12
      Width = 50
      Height = 15
      Caption = 'Platitor'
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
    object chkOnlyRemaining: TCheckBox
      Left = 212
      Top = 11
      Width = 190
      Height = 17
      Caption = 'Doar cu suma neatribuita'
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object edSearch: TEdit
      Left = 476
      Top = 8
      Width = 220
      Height = 23
      TabOrder = 2
      OnKeyPress = edSearchKeyPress
    end
    object btnRefresh: TcxButton
      Left = 708
      Top = 5
      Width = 110
      Height = 29
      Caption = 'Reincarca'
      TabOrder = 3
      OnClick = btnRefreshClick
    end
  end
  object cxGridPay: TcxGrid
    Left = 8
    Top = 110
    Width = 1084
    Height = 476
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridPayTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsPay
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
    end
    object cxGridPayLevel: TcxGridLevel
      GridView = cxGridPayTable
    end
  end
  object btnAutoMatch: TcxButton
    Left = 8
    Top = 598
    Width = 160
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Potriveste automat'
    TabOrder = 2
    OnClick = btnAutoMatchClick
  end
  object btnAddDeal: TcxButton
    Left = 174
    Top = 598
    Width = 140
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Adauga deal...'
    TabOrder = 3
    OnClick = btnAddDealClick
  end
  object btnOpenDeal: TcxButton
    Left = 320
    Top = 598
    Width = 140
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Fisa deal-ului'
    TabOrder = 4
    OnClick = btnOpenDealClick
  end
  object btnClose: TcxButton
    Left = 982
    Top = 598
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 5
  end
  object trRead: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 48
    Top = 160
  end
  object qPay: TIBCQuery
    Transaction = trRead
    Left = 112
    Top = 160
  end
  object dsPay: TIBCDataSource
    DataSet = qPay
    Left = 176
    Top = 160
  end
end
