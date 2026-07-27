object frmWebPromoBannerDlg: TfrmWebPromoBannerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Baner pentru actiune'
  ClientHeight = 770
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    709
    770)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 709
    Height = 64
    Title = 'Baner pentru actiune'
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
    ImageIndex = 30
  end
  object btnOk: TButton
    Left = 494
    Top = 733
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 590
    Top = 733
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 70
    Width = 692
    Height = 642
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Properties.ActivePage = cxTabSheet3
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 638
    ClientRectLeft = 4
    ClientRectRight = 688
    ClientRectTop = 26
    object cxTabSheet1: TcxTabSheet
      Caption = 'Generale'
      ImageIndex = 0
      object Label1: TLabel
        Left = 20
        Top = 17
        Width = 57
        Height = 15
        Caption = 'In Romana'
      end
      object Label7: TLabel
        Left = 81
        Top = 17
        Width = 78
        Height = 15
        Caption = '(1475 x 433 px)'
      end
      object Label2: TLabel
        Left = 22
        Top = 177
        Width = 92
        Height = 15
        Caption = #1056#1091#1089#1089#1082#1080#1081' '#1074#1072#1088#1080#1072#1085#1090
      end
      object Label3: TLabel
        Left = 22
        Top = 524
        Width = 139
        Height = 15
        Caption = 'trece la urmatoarea adresa'
      end
      object Label4: TLabel
        Left = 350
        Top = 522
        Width = 167
        Height = 15
        Caption = #1087#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1089#1083#1077#1076#1091#1102#1097#1080#1081' '#1072#1076#1088#1077#1089':'
      end
      object lbl_RuSize: TLabel
        Left = 613
        Top = 179
        Width = 20
        Height = 15
        Alignment = taRightJustify
        Caption = '0KB'
      end
      object lbl_RoSize: TLabel
        Left = 613
        Top = 16
        Width = 20
        Height = 15
        Alignment = taRightJustify
        Caption = '0KB'
      end
      object Label15: TLabel
        Left = 22
        Top = 357
        Width = 57
        Height = 15
        Caption = 'In Romana'
      end
      object Label16: TLabel
        Left = 348
        Top = 357
        Width = 92
        Height = 15
        Caption = #1056#1091#1089#1089#1082#1080#1081' '#1074#1072#1088#1080#1072#1085#1090
      end
      object Label17: TLabel
        Left = 22
        Top = 339
        Width = 156
        Height = 15
        Caption = 'Versiunea mobila (428x428px)'
      end
      object cxDBImage2: TcxDBImage
        Left = 22
        Top = 197
        DataBinding.DataField = 'IMAGE_RUS'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        Properties.OnChange = cxDBImage1PropertiesChange
        TabOrder = 1
        Height = 132
        Width = 643
      end
      object cxDBImage1: TcxDBImage
        Left = 20
        Top = 37
        DataBinding.DataField = 'IMAGE_ROM'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        Properties.OnChange = cxDBImage1PropertiesChange
        TabOrder = 0
        Height = 132
        Width = 645
      end
      object cbFLG_GOTO_BRICKS: TcxDBCheckBox
        Left = 22
        Top = 495
        Caption = 'Treci la pagina de blocuri de reclama, sau'
        DataBinding.DataField = 'FLG_GOTO_BRICKS'
        DataBinding.DataSource = IBCDataSourceBanner
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 4
      end
      object edNAV_URL: TcxDBTextEdit
        Left = 22
        Top = 541
        DataBinding.DataField = 'NAV_URL'
        DataBinding.DataSource = IBCDataSourceBanner
        ParentFont = False
        TabOrder = 5
        Width = 317
      end
      object edNAV_URL_RU: TcxDBTextEdit
        Left = 350
        Top = 541
        DataBinding.DataField = 'NAV_URL_RU'
        DataBinding.DataSource = IBCDataSourceBanner
        ParentFont = False
        TabOrder = 6
        Width = 317
      end
      object cxDBImage8: TcxDBImage
        Left = 22
        Top = 375
        DataBinding.DataField = 'MOBILE_IMAGE_RO'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        Properties.OnChange = cxDBImage1PropertiesChange
        TabOrder = 2
        Height = 98
        Width = 315
      end
      object cxDBImage9: TcxDBImage
        Left = 348
        Top = 375
        DataBinding.DataField = 'MOBILE_IMAGE_Ru'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        Properties.OnChange = cxDBImage1PropertiesChange
        TabOrder = 3
        Height = 98
        Width = 317
      end
      object Button1: TButton
        Left = 496
        Top = 570
        Width = 172
        Height = 25
        Action = actGenerateURL
        TabOrder = 7
      end
    end
    object cxTabSheet3: TcxTabSheet
      Caption = 'Baner intern'
      ImageIndex = 2
      object Label13: TLabel
        Left = 17
        Top = 8
        Width = 145
        Height = 15
        Caption = 'Baner intern  RO (1000x160)'
      end
      object Label14: TLabel
        Left = 17
        Top = 163
        Width = 144
        Height = 15
        Caption = 'Baner intern  RU (1000x160)'
      end
      object Label6: TLabel
        Left = 17
        Top = 315
        Width = 58
        Height = 15
        Caption = 'Watermark'
      end
      object cxDBImage6: TcxDBImage
        Left = 17
        Top = 29
        DataBinding.DataField = 'BANNER_INT_RO'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiDelete, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        TabOrder = 0
        Height = 124
        Width = 656
      end
      object cxDBImage7: TcxDBImage
        Left = 17
        Top = 181
        DataBinding.DataField = 'BANNER_INT_RU'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiDelete, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        TabOrder = 1
        Height = 124
        Width = 656
      end
      object cxDBImage3: TcxDBImage
        Left = 17
        Top = 333
        DataBinding.DataField = 'WATERMARK'
        DataBinding.DataSource = IBCDataSourceBanner
        Properties.CustomFilter = 
          #1042#1089#1077' '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg;*.png;*.gif|JPEG '#1082#1072#1088#1090#1080#1085#1082#1080'|*.jpg|PNG '#1082#1072#1088#1090#1080#1085#1082#1080'|' +
          '*.png|GIF '#1072#1085#1080#1084#1072#1094#1080#1103'|*.gif'
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiDelete, pmiLoad, pmiSave]
        Properties.ShowFocusRect = False
        TabOrder = 2
        Height = 220
        Width = 264
      end
    end
    object cxTabSheet4: TcxTabSheet
      Caption = 'Promo content'
      ImageIndex = 3
      OnShow = cxTabSheet4Show
      object Label18: TLabel
        Left = 3
        Top = 6
        Width = 28
        Height = 15
        Caption = 'ROM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 0
        Top = 304
        Width = 24
        Height = 15
        Caption = 'RUS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 634
        Top = 6
        Width = 28
        Height = 15
        Caption = 'Paste'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label5Click
      end
      object SynEdit1: TSynEdit
        Left = 3
        Top = 24
        Width = 659
        Height = 274
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 0
        CodeFolding.ShowCollapsedLine = True
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.Font.Quality = fqClearTypeNatural
        Gutter.Bands = <
          item
            Kind = gbkMarks
            Width = 13
          end
          item
            Kind = gbkLineNumbers
          end
          item
            Kind = gbkFold
          end
          item
            Kind = gbkTrackChanges
          end
          item
            Kind = gbkMargin
            Width = 3
          end>
        Highlighter = SynHTMLSyn1
        SelectedColor.Alpha = 0.400000005960464500
      end
      object SynEdit2: TSynEdit
        Left = 3
        Top = 322
        Width = 659
        Height = 279
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Consolas'
        Font.Pitch = fpFixed
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 1
        CodeFolding.ShowCollapsedLine = True
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Gutter.Font.Quality = fqClearTypeNatural
        Gutter.Bands = <
          item
            Kind = gbkMarks
            Width = 13
          end
          item
            Kind = gbkLineNumbers
          end
          item
            Kind = gbkFold
          end
          item
            Kind = gbkTrackChanges
          end
          item
            Kind = gbkMargin
            Width = 3
          end>
        Highlighter = SynHTMLSyn1
        SelectedColor.Alpha = 0.400000005960464500
      end
    end
  end
  object IBCQueryBanner: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_PA_BANNER'
      
        '  (PROMOACTIONID, IMAGE_RUS, IMAGE_ROM, MOBILE_IMAGE_RO, MOBILE_' +
        'IMAGE_RU, NAV_URL, NAV_URL_RU, FLG_DOUBLE_SIZE, FLG_GOTO_BRICKS,' +
        ' FLG_SHOW_PRICE, CATALOG_IMAGE_ROM, CATALOG_IMAGE_RUS, PRICE_IMA' +
        'GE_BACKGROUND, BANNER_INT_RO, BANNER_INT_RU, description_ro, des' +
        'cription_ru, watermark)'
      'VALUES'
      
        '  (:PROMOACTIONID, :IMAGE_RUS, :IMAGE_ROM, :MOBILE_IMAGE_RO, :MO' +
        'BILE_IMAGE_RU, :NAV_URL, :NAV_URL_RU, :FLG_DOUBLE_SIZE, :FLG_GOT' +
        'O_BRICKS, :FLG_SHOW_PRICE, :CATALOG_IMAGE_ROM, :CATALOG_IMAGE_RU' +
        'S, :PRICE_IMAGE_BACKGROUND, :BANNER_INT_RO, :BANNER_INT_RU, :des' +
        'cription_ro, :description_ru, :watermark)')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_PA_BANNER'
      'SET'
      ' IMAGE_RUS = :IMAGE_RUS, '
      ' IMAGE_ROM = :IMAGE_ROM, '
      ' MOBILE_IMAGE_RO = :MOBILE_IMAGE_RO, '
      ' MOBILE_IMAGE_RU = :MOBILE_IMAGE_RU, '
      ' NAV_URL = :NAV_URL, '
      ' NAV_URL_RU = :NAV_URL_RU,'
      ' FLG_DOUBLE_SIZE = :FLG_DOUBLE_SIZE, '
      ' FLG_GOTO_BRICKS = :FLG_GOTO_BRICKS,'
      ' CATALOG_IMAGE_ROM = :CATALOG_IMAGE_ROM,'
      ' CATALOG_IMAGE_RUS = :CATALOG_IMAGE_RUS,'
      ' PRICE_IMAGE_BACKGROUND = :PRICE_IMAGE_BACKGROUND,'
      ' BANNER_INT_RO = :BANNER_INT_RO, '
      ' BANNER_INT_RU = :BANNER_INT_RU,'
      ' description_ro = :description_ro, '
      ' description_ru = :description_ru,'
      ' watermark = :watermark'
      'WHERE'
      ' PROMOACTIONID = :Old_PROMOACTIONID')
    SQLRefresh.Strings = (
      'SELECT *'
      'FROM'
      ' VW_TWEB_PA_BANNER'
      'WHERE '
      ' PROMOACTIONID = :ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_PA_BANNER'
      'WHERE'
      'PROMOACTIONID = :Old_PROMOACTIONID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_PA_BANNER'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' PROMOACTIONID,'
      ' IMAGE_RUS,'
      ' IMAGE_ROM,'
      ' MOBILE_IMAGE_RO,'
      ' MOBILE_IMAGE_RU,'
      ' CATALOG_IMAGE_ROM,'
      ' CATALOG_IMAGE_RUS,'
      ' NAV_URL,'
      ' NAV_URL_RU,'
      ' FLG_DOUBLE_SIZE,'
      ' FLG_GOTO_BRICKS,'
      ' FLG_SHOW_PRICE, '
      ' price_image_background,'
      ' BANNER_INT_RO,'
      ' BANNER_INT_RU,'
      ' description_ro,'
      ' description_ru,'
      'watermark'
      'FROM'
      ' VW_TWEB_PA_BANNER'
      'WHERE '
      ' PROMOACTIONID = :ID')
    AutoCommit = False
    LockMode = lmLockImmediate
    AfterPost = IBCQueryBannerAfterPost
    Left = 200
    Top = 12
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        Value = nil
      end>
  end
  object IBCDataSourceBanner: TIBCDataSource
    DataSet = IBCQueryBanner
    Left = 321
    Top = 11
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 344
    Top = 296
  end
  object ActionList1: TActionList
    Left = 352
    Top = 392
    object actGenerateURL: TAction
      Caption = 'Genereaza URL'
      ShortCut = 32839
      OnExecute = actGenerateURLExecute
    end
  end
end
