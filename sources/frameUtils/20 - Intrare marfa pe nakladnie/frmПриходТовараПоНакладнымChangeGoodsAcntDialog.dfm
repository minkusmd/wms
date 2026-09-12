object frmPrihodTovaraPoNakladnimChangeGoodsAcntDlg: TfrmPrihodTovaraPoNakladnimChangeGoodsAcntDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Modifica denumirea produselor pe ntru facturi fiscale'
  ClientHeight = 276
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 482
    Height = 64
    Title = 'Modifica denumirea produselor pe ntru facturi fiscale'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 466
    Height = 149
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 117
      Height = 15
      Caption = 'Denumirea de sistema'
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 111
      Height = 15
      Caption = 'Denumirea pe facturi'
    end
    object edTITLE: TcxDBTextEdit
      Left = 16
      Top = 33
      TabStop = False
      DataBinding.DataField = 'TITLE'
      DataBinding.DataSource = IBCDataSourceGoods
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 425
    end
    object beACNT: TcxButtonEdit
      Left = 16
      Top = 81
      ParentShowHint = False
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Hint = #1042#1099#1073#1088#1072#1090#1100' '#1080#1079' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
          Kind = bkGlyph
        end
        item
          ImageIndex = 35
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1085#1072#1082#1083#1072#1076#1085#1099#1084
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beACNTPropertiesButtonClick
      ShowHint = True
      TabOrder = 1
      Width = 425
    end
  end
  object btnOk: TButton
    Left = 268
    Top = 232
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 372
    Top = 232
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryGoods: TIBCQuery
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS'
      'SET'
      '  GOODS_ACNT_ID = :GOODS_ACNT_ID'
      'WHERE'
      '  GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT GOODS_ACNT_ID FROM VW_TS_GOODS'
      'WHERE'
      '  GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL TS_GOODS'
      'WHERE'
      'GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      ' GOODSID,'
      ' TITLE,'
      ' GOODS_ACNT_ID,'
      ' NAMEACNT'
      'FROM VW_TS_GOODS'
      'WHERE GOODSID=:ID')
    AutoCommit = False
    Left = 220
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 220
    Top = 144
  end
end
