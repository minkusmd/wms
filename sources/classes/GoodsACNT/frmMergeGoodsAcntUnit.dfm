object frmMergeGoodsAcntDlg: TfrmMergeGoodsAcntDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Unirea denumirilor de contabilitate'
  ClientHeight = 480
  ClientWidth = 820
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 820
    Height = 64
    Title = 'Alegeti denumirea care va ramine'
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
    ImageIndex = 0
  end
  object pnMain: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 804
    Height = 356
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object lbHint: TLabel
      Left = 0
      Top = 0
      Width = 804
      Height = 15
      Align = alTop
      Caption = 
        'Inregistrarea evidentiata in tabel va fi pastrata, celelalte vor' +
        ' fi unite in ea si sterse din nomenclator.'
    end
    object cxGridAcnt: TcxGrid
      Left = 0
      Top = 21
      Width = 804
      Height = 335
      Align = alClient
      TabOrder = 0
      object cxGridAcntTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridAcntTableCellDblClick
        DataController.DataSource = IBCDataSourceAcnt
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridAcnt_GOODS_ACNT_ID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 60
        end
        object cxGridAcnt_NAMEACNT: TcxGridDBColumn
          Caption = 'Denumire contabilitate'
          DataBinding.FieldName = 'NAMEACNT'
        end
        object cxGridAcnt_PRICE_ACNT: TcxGridDBColumn
          Caption = 'Pret evidenta'
          DataBinding.FieldName = 'PRICE_ACNT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridAcnt_QTY_ACCOUNT: TcxGridDBColumn
          Caption = 'Sold contabil'
          DataBinding.FieldName = 'QTY_ACCOUNT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '#,##0.000'
          HeaderAlignmentHorz = taCenter
          MinWidth = 90
          Options.HorzSizing = False
          Width = 90
        end
        object cxGridAcnt_GOODS_COUNT: TcxGridDBColumn
          Caption = 'Produse'
          DataBinding.FieldName = 'GOODS_COUNT'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridAcnt_GOODS_TYPE_TITLE: TcxGridDBColumn
          Caption = 'Categorie produs'
          DataBinding.FieldName = 'GOODS_TYPE_TITLE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Width = 150
        end
        object cxGridAcnt_PARENT_TITLE: TcxGridDBColumn
          Caption = 'Mapa'
          DataBinding.FieldName = 'PARENT_TITLE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 120
          Width = 150
        end
      end
      object cxGridAcntLevel: TcxGridLevel
        GridView = cxGridAcntTable
      end
    end
  end
  object pnBottom: TPanel
    Left = 0
    Top = 434
    Width = 820
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      820
      46)
    object btnOk: TcxButton
      Left = 519
      Top = 1
      Width = 190
      Height = 29
      Anchors = [akTop, akRight]
      Caption = 'Uneste in cea evidentiata'
      Default = True
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TcxButton
      Left = 715
      Top = 1
      Width = 90
      Height = 29
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object IBCDataSourceAcnt: TIBCDataSource
    DataSet = IBCQueryAcnt
    Left = 60
    Top = 200
  end
  object IBCQueryAcnt: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdate
    SQL.Strings = (
      '')
    AutoCommit = False
    Options.RequiredFields = False
    LocalConstraints = False
    ReadOnly = True
    Left = 60
    Top = 256
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 60
    Top = 312
  end
end
