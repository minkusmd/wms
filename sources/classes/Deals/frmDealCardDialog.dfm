object frmDealCardDlg: TfrmDealCardDlg
  Left = 0
  Top = 0
  Caption = 'Deal'
  ClientHeight = 700
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  DesignSize = (
    980
    700)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 980
    Height = 64
    Title = 'Deal'
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
  object pnHeader: TPanel
    Left = 0
    Top = 64
    Width = 980
    Height = 176
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      980
      176)
    object lbInfo: TLabel
      Left = 12
      Top = 8
      Width = 520
      Height = 64
      AutoSize = False
      Caption = 'Client'
      WordWrap = True
    end
    object lbTotals: TLabel
      Left = 12
      Top = 84
      Width = 520
      Height = 40
      AutoSize = False
      Caption = 'Sume'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object lbPipe: TLabel
      Left = 560
      Top = 12
      Width = 150
      Height = 15
      AutoSize = False
      Caption = 'Etapa (PIPE)'
    end
    object lbPay: TLabel
      Left = 560
      Top = 42
      Width = 150
      Height = 15
      AutoSize = False
      Caption = 'Plata (PAY)'
    end
    object lbFin: TLabel
      Left = 560
      Top = 72
      Width = 150
      Height = 15
      AutoSize = False
      Caption = 'Finantare (FIN)'
    end
    object lbDlv: TLabel
      Left = 560
      Top = 102
      Width = 150
      Height = 15
      AutoSize = False
      Caption = 'Livrare (DLV)'
    end
    object cbPipe: TComboBox
      Left = 716
      Top = 8
      Width = 252
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object cbPay: TComboBox
      Left = 716
      Top = 38
      Width = 252
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
    object cbFin: TComboBox
      Left = 716
      Top = 68
      Width = 252
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object cbDlv: TComboBox
      Left = 716
      Top = 98
      Width = 252
      Height = 23
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object chkLock: TCheckBox
      Left = 560
      Top = 138
      Width = 150
      Height = 17
      Hint = 'Axele schimbate nu mai sunt recalculate automat din documente'
      Caption = 'Blocheaza recalcularea'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object btnApplyStates: TcxButton
      Left = 716
      Top = 132
      Width = 130
      Height = 29
      Caption = 'Aplica starile'
      TabOrder = 5
      OnClick = btnApplyStatesClick
    end
    object btnUnlock: TcxButton
      Left = 852
      Top = 132
      Width = 116
      Height = 29
      Caption = 'Deblocheaza'
      TabOrder = 6
      OnClick = btnUnlockClick
    end
  end
  object lbDocs: TLabel
    Left = 12
    Top = 244
    Width = 200
    Height = 15
    Caption = 'Documentele deal-ului'
  end
  object cxGridDocs: TcxGrid
    Left = 8
    Top = 262
    Width = 964
    Height = 190
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxGridDocsTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDocs
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
    end
    object cxGridDocsLevel: TcxGridLevel
      GridView = cxGridDocsTable
    end
  end
  object lbHistory: TLabel
    Left = 12
    Top = 458
    Width = 200
    Height = 15
    Anchors = [akLeft, akBottom]
    Caption = 'Istoricul starilor'
  end
  object cxGridHistory: TcxGrid
    Left = 8
    Top = 476
    Width = 560
    Height = 172
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    object cxGridHistoryTable: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsHistory
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.GroupByBox = False
    end
    object cxGridHistoryLevel: TcxGridLevel
      GridView = cxGridHistoryTable
    end
  end
  object lbNote: TLabel
    Left = 580
    Top = 458
    Width = 100
    Height = 15
    Anchors = [akRight, akBottom]
    Caption = 'Nota'
  end
  object memNote: TMemo
    Left = 576
    Top = 476
    Width = 396
    Height = 136
    Anchors = [akRight, akBottom]
    MaxLength = 1000
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object btnSaveNote: TcxButton
    Left = 852
    Top = 618
    Width = 120
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Salveaza nota'
    TabOrder = 4
    OnClick = btnSaveNoteClick
  end
  object btnBindDoc: TcxButton
    Left = 8
    Top = 660
    Width = 140
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Leaga document...'
    TabOrder = 5
    OnClick = btnBindDocClick
  end
  object btnUnbindDoc: TcxButton
    Left = 154
    Top = 660
    Width = 140
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Scoate documentul'
    TabOrder = 6
    OnClick = btnUnbindDocClick
  end
  object btnMerge: TcxButton
    Left = 300
    Top = 660
    Width = 140
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Uneste cu alt deal...'
    TabOrder = 7
    OnClick = btnMergeClick
  end
  object btnRecalc: TcxButton
    Left = 446
    Top = 660
    Width = 122
    Height = 31
    Anchors = [akLeft, akBottom]
    Caption = 'Recalculeaza'
    TabOrder = 8
    OnClick = btnRecalcClick
  end
  object btnClose: TcxButton
    Left = 862
    Top = 660
    Width = 110
    Height = 31
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 9
  end
  object trRead: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 48
    Top = 300
  end
  object qDeal: TIBCQuery
    Transaction = trRead
    SQL.Strings = (
      'SELECT b.* FROM VW_DEALS_BROWSER b WHERE b.DEAL_ID = :dealid')
    Left = 112
    Top = 300
  end
  object qDocs: TIBCQuery
    Transaction = trRead
    SQL.Strings = (
      'SELECT dd.DOCID, d.DATA, t.TITLE AS DOC_TYPE, d.SUMA, dd.LINK_SUM,'
      '       dd.LINK_TYPE,'
      '       IIF(d.DELETED_DATE IS NULL, 0, 1) AS IS_DELETED,'
      '       d.PARENTDOCID'
      '  FROM TDB_DEAL_DOCS dd'
      '  JOIN TDB_DOCS d ON d.DOCID = dd.DOCID'
      '  LEFT JOIN TS_DOCTYPES t ON t.DOCTYPEID = d.DOCTYPEID'
      ' WHERE dd.DEAL_ID = :dealid'
      ' ORDER BY dd.DOCID')
    Left = 176
    Top = 300
  end
  object dsDocs: TIBCDataSource
    DataSet = qDocs
    Left = 240
    Top = 300
  end
  object qHistory: TIBCQuery
    Transaction = trRead
    SQL.Strings = (
      'SELECT h.CHANGED_AT, h.GROUP_CODE, so.TITLE_RO AS OLD_STATE,'
      '       sn.TITLE_RO AS NEW_STATE, h.SOURCE, h.CHANGED_BY'
      '  FROM TDB_DEAL_HISTORY h'
      '  LEFT JOIN TS_DEAL_STATES so ON so.STATE_ID = h.OLD_STATE_ID'
      '  LEFT JOIN TS_DEAL_STATES sn ON sn.STATE_ID = h.NEW_STATE_ID'
      ' WHERE h.DEAL_ID = :dealid'
      ' ORDER BY h.HIST_ID DESC')
    Left = 112
    Top = 520
  end
  object dsHistory: TIBCDataSource
    DataSet = qHistory
    Left = 240
    Top = 520
  end
end
