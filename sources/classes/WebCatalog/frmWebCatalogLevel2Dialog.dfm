object frmWebCatalogLevel2Dlg: TfrmWebCatalogLevel2Dlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Web Catalog - Nivelul 2'
  ClientHeight = 673
  ClientWidth = 1175
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  DesignSize = (
    1175
    673)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1175
    Height = 64
    Title = 'Web Catalog - Nivelul 2'
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
    ImageIndex = 23
  end
  object cxPageControl1: TcxPageControl
    Left = 6
    Top = 70
    Width = 1163
    Height = 539
    TabOrder = 1
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 535
    ClientRectLeft = 4
    ClientRectRight = 1159
    ClientRectTop = 26
    object cxTabSheet1: TcxTabSheet
      Caption = 'Generale'
      ImageIndex = 0
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 94
        Height = 15
        Caption = 'Denumirea mapei'
      end
      object Label2: TLabel
        Left = 439
        Top = 16
        Width = 88
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1072#1087#1082#1080
      end
      object Label5: TLabel
        Left = 16
        Top = 102
        Width = 75
        Height = 15
        Caption = 'SEO Url (Rom)'
      end
      object Label4: TLabel
        Left = 16
        Top = 134
        Width = 69
        Height = 15
        Caption = 'SEO Url (Rus)'
      end
      object Label6: TLabel
        Left = 16
        Top = 283
        Width = 67
        Height = 15
        Caption = 'Descriere RO'
      end
      object Label7: TLabel
        Left = 16
        Top = 329
        Width = 66
        Height = 15
        Caption = 'Descriere RU'
      end
      object Label8: TLabel
        Left = 16
        Top = 204
        Width = 42
        Height = 15
        Hint = #1057#1084#1072#1088#1090#1092#1086#1085#1099' '#1089' '#1076#1086#1089#1090#1072#1074#1082#1086#1081'. '#1050#1091#1087#1080#1090#1100', '#1094#1077#1085#1072', '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        Caption = 'Title RO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 16
        Top = 233
        Width = 41
        Height = 15
        Hint = #1057#1084#1072#1088#1090#1092#1086#1085#1099' '#1089' '#1076#1086#1089#1090#1072#1074#1082#1086#1081'. '#1050#1091#1087#1080#1090#1100', '#1094#1077#1085#1072', '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        Caption = 'Title RU'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 16
        Top = 387
        Width = 70
        Height = 15
        Caption = 'Keywords RO'
      end
      object Label11: TLabel
        Left = 15
        Top = 430
        Width = 69
        Height = 15
        Caption = 'Keywords RU'
      end
      object edTITLE: TcxDBTextEdit
        Left = 116
        Top = 13
        DataBinding.DataField = 'TITLE'
        ParentFont = False
        TabOrder = 0
        Width = 309
      end
      object edTITLE_RUS: TcxDBTextEdit
        Left = 540
        Top = 13
        DataBinding.DataField = 'TITLE_RUS'
        ParentFont = False
        TabOrder = 1
        Width = 307
      end
      object cbFLG_ENABLED: TcxDBCheckBox
        Left = 116
        Top = 483
        Caption = 'Grupa activa'
        DataBinding.DataField = 'FLG_ENABLED'
        ParentFont = False
        Properties.Alignment = taLeftJustify
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 13
      end
      object edREWRITE_URL_ROM: TcxDBButtonEdit
        Left = 116
        Top = 102
        DataBinding.DataField = 'REWRITE_URL_ROM'
        ParentFont = False
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.CharCase = ecLowerCase
        Properties.ClearKey = 46
        TabOrder = 3
        Width = 229
      end
      object edREWRITE_URL_RUS: TcxDBButtonEdit
        Left = 116
        Top = 131
        DataBinding.DataField = 'REWRITE_URL_RUS'
        ParentFont = False
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.CharCase = ecLowerCase
        Properties.ClearKey = 46
        TabOrder = 5
        Width = 229
      end
      object cxButton1: TcxButton
        Left = 116
        Top = 42
        Width = 157
        Height = 25
        Caption = 'Complecteaza'
        TabOrder = 2
        OnClick = cxButton1Click
      end
      object cxDBMemo1: TcxDBMemo
        Left = 116
        Top = 280
        DataBinding.DataField = 'META_DESCRIPTION_RO'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        Properties.ScrollBars = ssVertical
        TabOrder = 9
        Height = 40
        Width = 731
      end
      object cxDBMemo2: TcxDBMemo
        Left = 116
        Top = 326
        DataBinding.DataField = 'META_DESCRIPTION_RU'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        Properties.ScrollBars = ssVertical
        TabOrder = 10
        Height = 46
        Width = 731
      end
      object teTITLE_RO: TcxDBTextEdit
        Left = 116
        Top = 201
        DataBinding.DataField = 'META_TITLE_RO'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        TabOrder = 7
        Width = 731
      end
      object teTITLE_RU: TcxDBTextEdit
        Left = 116
        Top = 230
        DataBinding.DataField = 'META_TITLE_RU'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        TabOrder = 8
        Width = 731
      end
      object cxDBMemo3: TcxDBMemo
        Left = 116
        Top = 384
        DataBinding.DataField = 'META_KEYWORDS_RO'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        Properties.ScrollBars = ssVertical
        TabOrder = 11
        Height = 40
        Width = 731
      end
      object cxDBMemo4: TcxDBMemo
        Left = 116
        Top = 430
        DataBinding.DataField = 'META_KEYWORDS_RU'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        Properties.ScrollBars = ssVertical
        TabOrder = 12
        Height = 46
        Width = 731
      end
      object teURL_RO: TcxDBTextEdit
        Left = 351
        Top = 102
        DataBinding.DataField = 'URL_RO'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        TabOrder = 4
        Width = 274
      end
      object teURL_RU: TcxDBTextEdit
        Left = 351
        Top = 131
        DataBinding.DataField = 'URL_RU'
        DataBinding.DataSource = IBCDS_SeoDescription
        ParentFont = False
        TabOrder = 6
        Width = 274
      end
      object ScrollBox1: TScrollBox
        Left = 853
        Top = 13
        Width = 299
        Height = 300
        HorzScrollBar.Style = ssFlat
        VertScrollBar.Style = ssFlat
        BorderStyle = bsNone
        TabOrder = 14
        object Label3: TLabel
          Left = 16
          Top = 102
          Width = 201
          Height = 19
          AutoSize = False
          Caption = 'Baner nivelul 2 (180x160)'
          WordWrap = True
        end
        object Label12: TLabel
          Left = 16
          Top = 3
          Width = 177
          Height = 20
          AutoSize = False
          Caption = 'Iconita pentru nivelul 2 (28x28)'
          WordWrap = True
        end
        object ImgCatalog: TcxDBImage
          Left = 16
          Top = 118
          DataBinding.DataField = 'BIG_IMAGE'
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          TabOrder = 0
          Height = 137
          Width = 200
        end
        object cxDBImage1: TcxDBImage
          Left = 16
          Top = 20
          DataBinding.DataField = 'IMAGE'
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          TabOrder = 1
          Height = 60
          Width = 74
        end
      end
    end
  end
  object btnOk: TcxButton
    Left = 479
    Top = 636
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 579
    Top = 636
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCDS_SeoDescription: TIBCDataSource
    DataSet = IBCQuerySeoDescription
    Left = 792
    Top = 168
  end
  object IBCQuerySeoDescription: TIBCQuery
    KeyFields = 'CATALOGID'
    SQLInsert.Strings = (
      'INSERT INTO TWEB_CATALOG_SEO'
      
        '  (CATALOGID, META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION_RO,' +
        ' META_DESCRIPTION_RU, META_KEYWORDS_RO, META_KEYWORDS_RU, SEO_AR' +
        'TICLE_RO, SEO_ARTICLE_RU)'
      'VALUES'
      
        '  (:CATALOGID, :META_TITLE_RO, :META_TITLE_RU, :META_DESCRIPTION' +
        '_RO, :META_DESCRIPTION_RU, :META_KEYWORDS_RO, :META_KEYWORDS_RU,' +
        ' :SEO_ARTICLE_RO, :SEO_ARTICLE_RU)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_CATALOG_SEO'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_CATALOG_SEO'
      'SET'
      
        '  CATALOGID = :CATALOGID, META_TITLE_RO = :META_TITLE_RO, META_T' +
        'ITLE_RU = :META_TITLE_RU, META_DESCRIPTION_RO = :META_DESCRIPTIO' +
        'N_RO, META_DESCRIPTION_RU = :META_DESCRIPTION_RU, META_KEYWORDS_' +
        'RO = :META_KEYWORDS_RO, META_KEYWORDS_RU = :META_KEYWORDS_RU, SE' +
        'O_ARTICLE_RO = :SEO_ARTICLE_RO, SEO_ARTICLE_RU = :SEO_ARTICLE_RU'
      'WHERE'
      '  CATALOGID = :Old_CATALOGID')
    SQLRefresh.Strings = (
      
        'SELECT CATALOGID, META_TITLE_RO, META_TITLE_RU, META_DESCRIPTION' +
        '_RO, META_DESCRIPTION_RU, META_KEYWORDS_RO, META_KEYWORDS_RU, SE' +
        'O_ARTICLE_RO, SEO_ARTICLE_RU FROM TWEB_CATALOG_SEO'
      'WHERE'
      '  CATALOGID = :CATALOGID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_CATALOG_SEO'
      'WHERE'
      'CATALOGID = :Old_CATALOGID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TWEB_CATALOG_SEO'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from tweb_catalog_seo where catalogid=:catalogid')
    Left = 792
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'catalogid'
        Value = nil
      end>
  end
end
