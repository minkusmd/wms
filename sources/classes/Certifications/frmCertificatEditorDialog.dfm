object frmCertificatEditorDlg: TfrmCertificatEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edNUMAR_INREG
  BorderStyle = bsDialog
  Caption = 'Certificate'
  ClientHeight = 563
  ClientWidth = 1106
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    1106
    563)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1106
    Height = 64
    Title = 'Certificate'
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
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1090
    Height = 433
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
    object cxLabel1: TLabel
      Left = 12
      Top = 16
      Width = 115
      Height = 15
      Caption = 'Numar de inregistrare'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 72
      Width = 52
      Height = 15
      Caption = 'Denumire'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 224
      Width = 43
      Height = 15
      Caption = 'Furnizor'
      Transparent = True
    end
    object cxLabel4: TLabel
      Left = 12
      Top = 284
      Width = 129
      Height = 15
      Caption = 'Perioada valabilitatii, din'
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 185
      Top = 284
      Width = 35
      Height = 15
      Caption = 'pina la'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 376
      Top = 16
      Width = 127
      Height = 15
      Caption = 'Informatie suplimentara'
      Transparent = True
    end
    object Label1: TLabel
      Left = 744
      Top = 16
      Width = 95
      Height = 15
      Caption = 'Imagini certificate'
      Transparent = True
    end
    object edNUMAR_INREG: TcxDBTextEdit
      Left = 12
      Top = 33
      DataBinding.DataField = 'NUMAR_INREG'
      TabOrder = 0
      Width = 333
    end
    object mmDENUMIREA: TcxDBMemo
      Left = 12
      Top = 89
      DataBinding.DataField = 'DENUMIREA'
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 7
      TabOrder = 3
      Width = 333
    end
    object dePERIOADA_START: TcxDBDateEdit
      Left = 12
      Top = 301
      DataBinding.DataField = 'PERIOADA_START'
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 5
      Width = 160
    end
    object dePERIOADA_END: TcxDBDateEdit
      Left = 185
      Top = 301
      DataBinding.DataField = 'PERIOADA_END'
      Properties.DateButtons = [btnClear, btnNow, btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 6
      Width = 160
    end
    object mmINFO_SUPLIMENTAR: TcxDBMemo
      Left = 376
      Top = 33
      DataBinding.DataField = 'INFO_SUPLIMENTAR'
      ParentFont = False
      Properties.ScrollBars = ssVertical
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Courier New'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Height = 376
      Width = 333
    end
    object beSolicitant: TcxButtonEdit
      Left = 12
      Top = 241
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            424D360400000000000036000000280000001000000010000000010020000000
            000000000000C40E0000C40E00000000000000000000FF00FF00FF00FF00FF00
            FF00FF00FF00B8C698FFA6AE7AFF948F55FFFF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FF8DB4
            61FF92B266FF99B56DFF9EB975FF91884AFF718043FF757C43FF8F8C4DFF9284
            49FFA58D5EFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4BD
            7EFFA4BD7EFFA4C17EFFA4C17EFF91884AFF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB1C58DFFA88559FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA4BD7EFFA4BD7EFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA4B9
            7DFFA6AE7AFFA4B97DFFA4BD7EFF928449FF96A67CFF98AA7FFFB5CD98FFB5CD
            98FFB5CD98FF9C7240FFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA4B97DFFA6AE7AFFA4B97DFF928449FF96A67CFF98A57DFFB5CD98FFB5CD
            98FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFA9AA
            78FFA9AA78FFA6AE7AFFA4B97DFF967D46FF96A67CFF98A57DFFB6C596FFB6C5
            96FFB5CD98FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFABA5
            76FFA9AA78FFA9AA78FFA4B97DFF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C997FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B558FFADA1
            74FFABA576FFA9AA78FFB6B188FF967D46FF979E7AFF98A57DFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFADA1
            74FFADA174FFABA576FFBAB991FF967D46FF979E7AFF9A9D7BFFB6C596FFB6C5
            96FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB09A70FFADA174FFBAB991FF9C7240FF979E7AFF9A9D7BFFB8BE94FFB8C0
            95FFB6C596FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB296
            6FFFB2966FFFB09A70FFC5B395FF967D46FF9A9777FF9A9D7BFFB8BE94FFB8BE
            94FFB8C095FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB2966FFFB2966FFFC5B395FF9C7240FF9A9D7BFF9A9D7BFFB8BE94FFB8BE
            94FFB8BE94FF9D703FFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FFB78E
            6BFFB78E6BFFC1AC8CFFB9A882FF9C7240FF9A9D7BFFB1AE8AFFBAB991FFB8BE
            94FFB8BE94FF9E6E3EFFFF00FF00FF00FF00FF00FF00FF00FF0086B057FF9F98
            5FFFA6AB76FF979357FFAA986AFFA49573FFBCB18DFFBCB18DFFBAB991FFBAB9
            91FFBCB18DFFAB7F56FFFF00FF00FF00FF00FF00FF00FF00FF0090B063FF90B0
            63FF88AA56FF87A755FF89A054FF8A9A52FF8C934FFF91884AFF928449FF9C72
            40FFA88559FFFF00FF00FF00FF00FF00FF00FF00FF00}
          Kind = bkGlyph
        end>
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beSolicitantPropertiesButtonClick
      TabOrder = 4
      Width = 333
    end
    object pnPhotos: TPanel
      Left = 744
      Top = 33
      Width = 321
      Height = 377
      BevelOuter = bvNone
      TabOrder = 2
      object cxGrid: TcxGrid
        Left = 0
        Top = 30
        Width = 321
        Height = 347
        Align = alClient
        TabOrder = 1
        object cxGridDBTable: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridDBTableCellDblClick
          OnFocusedRecordChanged = cxGridDBTableFocusedRecordChanged
          DataController.DataSource = IBCDataSourceImages
          DataController.KeyFieldNames = 'CERTIFICATID;IMAGEID'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsSelection.CellSelect = False
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.DataRowHeight = 100
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGridDBTable_IMAGEID: TcxGridDBColumn
            Caption = 'Imagine'
            DataBinding.FieldName = 'IMAGE_THUMB'
            PropertiesClassName = 'TcxImageProperties'
            Properties.GraphicClassName = 'TdxSmartImage'
            Properties.ReadOnly = True
            Properties.ShowFocusRect = False
            Width = 120
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBTable
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 321
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
    end
  end
  object btnOk: TcxButton
    AlignWithMargins = True
    Left = 891
    Top = 517
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Caption = 'O&K'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    AlignWithMargins = True
    Left = 997
    Top = 517
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 388
    Top = 16
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 683
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbNewPhoto'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbModifyPhoto'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbDeletePhoto'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPrintPhoto'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbNewPhoto: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbNewPhotoClick
    end
    object bbModifyPhoto: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbModifyPhotoClick
    end
    object bbDeletePhoto: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbDeletePhotoClick
    end
    object bbPrintPhoto: TdxBarButton
      Caption = 'Tipar'
      Category = 0
      Hint = 'Tipar'
      Visible = ivAlways
      ImageIndex = 28
      OnClick = bbPrintPhotoClick
    end
  end
  object IBCQueryImages: TIBCQuery
    SQLDelete.Strings = (
      'DELETE FROM TS_CERTIFICAT_IMAGES'
      'WHERE'
      '  CERTIFICATID = :Old_CERTIFICATID AND IMAGEID = :Old_IMAGEID')
    SQLRefresh.Strings = (
      
        'SELECT CERTIFICATID, IMAGEID, IMAGE_THUMB FROM TS_CERTIFICAT_IMA' +
        'GES'
      'WHERE'
      '  CERTIFICATID = :CERTIFICATID AND IMAGEID = :IMAGEID')
    SQL.Strings = (
      'SELECT '
      ' CERTIFICATID, IMAGEID, IMAGE_THUMB'
      'FROM'
      ' TS_CERTIFICAT_IMAGES')
    MasterFields = 'CERTIFICATID'
    DetailFields = 'CERTIFICATID'
    AutoCommit = False
    Left = 808
    Top = 296
  end
  object IBCDataSourceImages: TIBCDataSource
    DataSet = IBCQueryImages
    Left = 808
    Top = 240
  end
  object frxReportImage: TfrxReport
    Version = '6.7.9'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.OutlineExpand = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmWholePage
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 40452.538895879600000000
    ReportOptions.LastChange = 40452.547272187500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = frxReportImageGetValue
    Left = 912
    Top = 192
    Datasets = <
      item
        DataSetName = 'IBDACQuery1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      MirrorMode = []
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 1028.032160000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        DataSetName = 'IBDACQuery1'
        RowCount = 0
        object Picture1: TfrxPictureView
          AllowVectorExport = True
          Width = 718.110700000000000000
          Height = 1028.032160000000000000
          DataField = 'IMAGE'
          DataSetName = 'IBDACQuery1'
          Frame.Typ = []
          HightQuality = True
          Transparent = False
          TransparentColor = clWhite
        end
      end
    end
  end
end
