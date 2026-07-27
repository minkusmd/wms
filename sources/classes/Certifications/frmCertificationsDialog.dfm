object frmCertificationsDlg: TfrmCertificationsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridCert
  BorderIcons = [biSystemMenu]
  Caption = 'Certificate'
  ClientHeight = 639
  ClientWidth = 916
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
    Width = 916
    Height = 64
    Title = 'Certificate'
    Text = 'Alegerea si administrarea certificatelor'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 900
    Height = 510
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    TabOrder = 1
    object dxBarDockControl: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 900
      Height = 30
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
    object cxGridCert: TcxGrid
      Left = 0
      Top = 30
      Width = 900
      Height = 372
      Align = alClient
      TabOrder = 1
      object cxGridCertTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridCertTableCellDblClick
        OnFocusedRecordChanged = cxGridCertTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceCertif
        DataController.KeyFieldNames = 'CERTIFICATID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridCert_CERTIFICATID: TcxGridDBColumn
          AlternateCaption = #1050#1086#1076' '#1089#1077#1088#1090#1080#1092#1080#1082#1072#1090#1072
          Caption = 'Cod'
          DataBinding.FieldName = 'CERTIFICATID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.Filtering = False
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridCert_NUMAR_INREG: TcxGridDBColumn
          Caption = 'Numar de inregistrare'
          DataBinding.FieldName = 'NUMAR_INREG'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Vert = taVCenter
          MinWidth = 40
          Options.Filtering = False
          VisibleForCustomization = False
          Width = 140
        end
        object cxGridCert_DENUMIREA: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'DENUMIREA'
          MinWidth = 40
          Options.Filtering = False
          VisibleForCustomization = False
          Width = 130
        end
        object cxGridCert_SOLICITANT_ID: TcxGridDBColumn
          Caption = 'Furnizor'
          DataBinding.FieldName = 'SOLICITANT_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Vert = taVCenter
          MinWidth = 40
          VisibleForCustomization = False
          Width = 120
        end
        object cxGridCert_PERIOADA_START: TcxGridDBColumn
          Caption = 'Inceput perioada'
          DataBinding.FieldName = 'PERIOADA_START'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          MinWidth = 80
          Options.Filtering = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 80
        end
        object cxGridCert_PERIOADA_END: TcxGridDBColumn
          Caption = 'Sfirsit perioada'
          DataBinding.FieldName = 'PERIOADA_END'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          MinWidth = 80
          Options.Filtering = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 80
        end
        object cxGridCert_IMAGE_COUNT: TcxGridDBColumn
          Caption = 'Nr. Imagini'
          DataBinding.FieldName = 'IMAGE_COUNT'
          HeaderAlignmentHorz = taCenter
          Options.Filtering = False
          Width = 40
        end
        object cxGridCert_CREATED_BY_NAME: TcxGridDBColumn
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          Width = 60
        end
      end
      object cxGridCertLevel: TcxGridLevel
        GridView = cxGridCertTable
      end
    end
    object cxSplitter1: TcxSplitter
      Left = 0
      Top = 402
      Width = 900
      Height = 8
      HotZoneClassName = 'TcxMediaPlayer9Style'
      AlignSplitter = salBottom
      PositionAfterOpen = 100
      MinSize = 50
      Control = pnInfo
    end
    object pnInfo: TPanel
      Left = 0
      Top = 410
      Width = 900
      Height = 100
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnInfo'
      TabOrder = 3
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 900
        Height = 15
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Align = alTop
        Caption = 'Informatie suplimentare'
        ExplicitWidth = 127
      end
      object cxDBMemo1: TcxDBMemo
        Left = 0
        Top = 15
        TabStop = False
        Align = alClient
        DataBinding.DataField = 'INFO_SUPLIMENTAR'
        DataBinding.DataSource = IBCDataSourceCertif
        ParentFont = False
        Properties.ReadOnly = True
        Properties.ScrollBars = ssVertical
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Height = 85
        Width = 900
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 590
    Width = 916
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 4
    Padding.Right = 16
    Padding.Bottom = 4
    ShowCaption = False
    TabOrder = 2
    object btnCancel: TcxButton
      AlignWithMargins = True
      Left = 794
      Top = 4
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 16
      Margins.Bottom = 12
      Align = alRight
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
    end
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 392
    Top = 140
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'CRT'
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 729
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewCertificat'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyCertificat'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveCertificat'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoods'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbSearch'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewCertificat: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbNewCertificatClick
    end
    object bbModifyCertificat: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = bbModifyCertificatClick
    end
    object bbRemoveCertificat: TdxBarButton
      Caption = 'Elimina'
      Category = 0
      Hint = 'Elimina'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveCertificatClick
    end
    object bbGoods: TdxBarButton
      Caption = 'Produsele certificate'
      Category = 0
      Hint = 'Produsele certificate'
      Visible = ivAlways
      ImageIndex = 12
      ShortCut = 116
      OnClick = bbGoodsClick
    end
    object bbSearch: TdxBarButton
      Caption = 'Cauta'
      Category = 0
      Hint = 'Cauta'
      Visible = ivAlways
      ImageIndex = 4
      ShortCut = 114
      OnClick = bbSearchClick
    end
  end
  object IBCDataSourceCertif: TIBCDataSource
    DataSet = IBCQueryCertif
    Left = 80
    Top = 224
  end
  object IBCTrUpdateCertif: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 80
    Top = 328
  end
  object IBCQueryCertif: TIBCQuery
    KeyFields = 'CERTIFICATID'
    KeyGenerator = 'SQ_TS_CERTIFICATES_ID'
    GeneratorMode = gmInsert
    SQLInsert.Strings = (
      'INSERT INTO VW_TS_CERTIFICATES'
      
        '  (CERTIFICATID, NUMAR_INREG, DENUMIREA, SOLICITANT_ID, PERIOADA' +
        '_START, PERIOADA_END, INFO_SUPLIMENTAR, CREATED_DATE, CREATED_BY' +
        ')'
      'VALUES'
      
        '  (:CERTIFICATID, :NUMAR_INREG, :DENUMIREA, :SOLICITANT_ID, :PER' +
        'IOADA_START, :PERIOADA_END, :INFO_SUPLIMENTAR, :CREATED_DATE, :C' +
        'REATED_BY)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TS_CERTIFICATES'
      'WHERE'
      '  CERTIFICATID = :Old_CERTIFICATID')
    SQLUpdate.Strings = (
      'UPDATE VW_TS_CERTIFICATES'
      'SET'
      
        '  CERTIFICATID = :CERTIFICATID, NUMAR_INREG = :NUMAR_INREG, DENU' +
        'MIREA = :DENUMIREA, SOLICITANT_ID = :SOLICITANT_ID, '
      
        '  PERIOADA_START = :PERIOADA_START, PERIOADA_END = :PERIOADA_END' +
        ', INFO_SUPLIMENTAR = :INFO_SUPLIMENTAR, CREATED_DATE = :CREATED_' +
        'DATE, CREATED_BY = :CREATED_BY'
      'WHERE'
      '  CERTIFICATID = :Old_CERTIFICATID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CERTIFICATID, '
      ' NUMAR_INREG, '
      ' DENUMIREA, '
      ' SOLICITANT_ID, '
      ' PERIOADA_START, '
      ' PERIOADA_END, '
      ' INFO_SUPLIMENTAR, '
      ' CREATED_DATE, '
      ' CREATED_BY,'
      ' SOLICITANT_NAME,'
      ' IMAGE_COUNT'
      'FROM '
      ' VW_TS_CERTIFICATES'
      'WHERE'
      ' CERTIFICATID = :CERTIFICATID')
    SQLLock.Strings = (
      'SELECT '
      ' NULL '
      'FROM '
      ' TS_CERTIFICATES'
      'WHERE'
      ' CERTIFICATID = :Old_CERTIFICATID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTrUpdateCertif
    SQL.Strings = (
      'SELECT'
      ' CERTIFICATID, '
      ' NUMAR_INREG, '
      ' DENUMIREA, '
      ' SOLICITANT_ID, '
      ' PERIOADA_START, '
      ' PERIOADA_END, '
      ' INFO_SUPLIMENTAR, '
      ' CREATED_DATE, '
      ' CREATED_BY,'
      ' SOLICITANT_NAME,'
      ' IMAGE_COUNT,'
      ' CREATED_BY_NAME'
      'FROM'
      ' VW_TS_CERTIFICATES')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 80
    Top = 276
  end
end
