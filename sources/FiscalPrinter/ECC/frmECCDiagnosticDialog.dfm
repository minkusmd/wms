object frmECCDiagnosticDlg: TfrmECCDiagnosticDlg
  Left = 0
  Top = 0
  Caption = 'Casa ECC Fiscal Partner - diagnostic'
  ClientHeight = 680
  ClientWidth = 920
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 537
    Top = 224
    Height = 412
    Align = alRight
  end
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 224
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      920
      224)
    object lblApiCode: TLabel
      Left = 12
      Top = 15
      Width = 60
      Height = 16
      Caption = 'Casa ECC:'
    end
    object lblConfig: TLabel
      Left = 12
      Top = 44
      Width = 896
      Height = 54
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      WordWrap = True
    end
    object lblSum: TLabel
      Left = 12
      Top = 149
      Width = 38
      Height = 16
      Caption = 'Suma:'
    end
    object lblDocId: TLabel
      Left = 12
      Top = 187
      Width = 57
      Height = 16
      Caption = 'Id / fisier:'
    end
    object cmbApiCode: TComboBox
      Left = 110
      Top = 11
      Width = 220
      Height = 24
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbApiCodeChange
    end
    object btnReload: TButton
      Left = 340
      Top = 9
      Width = 110
      Height = 28
      Caption = 'Reciteste'
      TabOrder = 1
      OnClick = btnReloadClick
    end
    object btnStatus: TButton
      Left = 12
      Top = 104
      Width = 130
      Height = 30
      Caption = 'Stare server'
      TabOrder = 2
      OnClick = btnStatusClick
    end
    object btnXReport: TButton
      Left = 150
      Top = 104
      Width = 130
      Height = 30
      Caption = 'Raport X'
      TabOrder = 3
      OnClick = btnXReportClick
    end
    object btnZReport: TButton
      Left = 288
      Top = 104
      Width = 130
      Height = 30
      Caption = 'Raport Z'
      TabOrder = 4
      OnClick = btnZReportClick
    end
    object btnListReceipts: TButton
      Left = 426
      Top = 104
      Width = 130
      Height = 30
      Caption = 'Bonuri azi'
      TabOrder = 5
      OnClick = btnListReceiptsClick
    end
    object btnListZ: TButton
      Left = 564
      Top = 104
      Width = 160
      Height = 30
      Caption = 'Rapoarte Z (7 zile)'
      TabOrder = 6
      OnClick = btnListZClick
    end
    object btnJournal: TButton
      Left = 732
      Top = 104
      Width = 80
      Height = 30
      Hint = 'Ultimele 30 de rinduri din TFP_ECC_TRANSACTION'
      Caption = 'Jurnal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 17
      OnClick = btnJournalClick
    end
    object btnPending: TButton
      Left = 820
      Top = 104
      Width = 90
      Height = 30
      Hint = 'Bonurile ramase trimise fara rezultat: se cauta in ECC dupa id'
      Caption = 'In asteptare'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      OnClick = btnPendingClick
    end
    object edSum: TEdit
      Left = 60
      Top = 145
      Width = 80
      Height = 24
      TabOrder = 7
      Text = '1.00'
    end
    object cmbPayType: TComboBox
      Left = 148
      Top = 145
      Width = 130
      Height = 24
      Style = csDropDownList
      TabOrder = 8
      Items.Strings = (
        'Numerar'
        'Card'
        'Online / MIA')
    end
    object btnTestReceipt: TButton
      Left = 286
      Top = 142
      Width = 130
      Height = 30
      Caption = 'Bon de test'
      TabOrder = 9
      OnClick = btnTestReceiptClick
    end
    object btnOrderExt: TButton
      Left = 424
      Top = 142
      Width = 180
      Height = 30
      Caption = 'Comanda pe terminal'
      TabOrder = 10
      OnClick = btnOrderExtClick
    end
    object btnCashIn: TButton
      Left = 612
      Top = 142
      Width = 110
      Height = 30
      Caption = 'Depunere'
      TabOrder = 11
      OnClick = btnCashInClick
    end
    object btnCashOut: TButton
      Left = 730
      Top = 142
      Width = 110
      Height = 30
      Caption = 'Retragere'
      TabOrder = 12
      OnClick = btnCashOutClick
    end
    object edDocId: TEdit
      Left = 100
      Top = 183
      Width = 330
      Height = 24
      TabOrder = 13
    end
    object btnGetReceipt: TButton
      Left = 438
      Top = 180
      Width = 130
      Height = 30
      Caption = 'Citeste bonul'
      TabOrder = 14
      OnClick = btnGetReceiptClick
    end
    object btnShowDoc: TButton
      Left = 576
      Top = 180
      Width = 110
      Height = 30
      Caption = 'Arata PNG'
      TabOrder = 15
      OnClick = btnShowDocClick
    end
    object btnPrintDoc: TButton
      Left = 694
      Top = 180
      Width = 130
      Height = 30
      Caption = 'Tipareste PNG'
      TabOrder = 16
      OnClick = btnPrintDocClick
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 636
    Width = 920
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      920
      44)
    object btnStopWait: TButton
      Left = 12
      Top = 7
      Width = 180
      Height = 30
      Caption = 'Opreste asteptarea'
      Enabled = False
      TabOrder = 0
      OnClick = btnStopWaitClick
    end
    object btnReconcile: TButton
      Left = 204
      Top = 7
      Width = 150
      Height = 30
      Caption = 'Reconciliere...'
      TabOrder = 2
      OnClick = btnReconcileClick
    end
    object btnCouriers: TButton
      Left = 362
      Top = 7
      Width = 150
      Height = 30
      Caption = 'Curieri ECC...'
      TabOrder = 3
      OnClick = btnCouriersClick
    end
    object btnClose: TButton
      Left = 798
      Top = 7
      Width = 110
      Height = 30
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object memLog: TMemo
    Left = 0
    Top = 224
    Width = 537
    Height = 412
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
  end
  object sbDoc: TScrollBox
    Left = 540
    Top = 224
    Width = 380
    Height = 412
    Align = alRight
    Color = clWhite
    ParentColor = False
    TabOrder = 2
    object imgDoc: TcxImage
      Left = 0
      Top = 0
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 140
      ExplicitHeight = 100
      Height = 408
      Width = 376
    end
  end
end
