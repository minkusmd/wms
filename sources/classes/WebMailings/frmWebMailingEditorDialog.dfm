object frmWebMailingEditorDlg: TfrmWebMailingEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTITLE
  BorderStyle = bsDialog
  Caption = 'E-mail '#1088#1072#1089#1089#1099#1083#1082#1072
  ClientHeight = 571
  ClientWidth = 1114
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1114
    571)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1114
    Height = 80
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Title = 'E-mail '#1088#1072#1089#1089#1099#1083#1082#1072
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
  object btnOk: TButton
    Left = 853
    Top = 533
    Width = 112
    Height = 29
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 983
    Top = 533
    Width = 112
    Height = 29
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 90
    Width = 1094
    Height = 431
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 25
      Top = 9
      Width = 133
      Height = 15
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' ('#1090#1077#1084#1072' '#1087#1080#1089#1100#1084#1072')'
    end
    object edTITLE: TcxDBTextEdit
      Left = 25
      Top = 30
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 1041
    end
    object pcPages: TPageControl
      Left = 25
      Top = 61
      Width = 1041
      Height = 356
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = tbsHeader
      TabOrder = 1
      object tbsHeader: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
        object Label2: TLabel
          Left = 18
          Top = -1
          Width = 29
          Height = 15
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Caption = #1058#1077#1082#1089#1090
        end
        object Label3: TLabel
          Left = 18
          Top = 51
          Width = 51
          Height = 15
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Caption = #1050#1072#1088#1090#1080#1085#1082#1072
        end
        object Label6: TLabel
          Left = 18
          Top = 271
          Width = 59
          Height = 15
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Caption = 'Google Tag'
        end
        object edHEADER_TEXT: TcxDBTextEdit
          Left = 18
          Top = 20
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          DataBinding.DataField = 'HEADER_TEXT'
          TabOrder = 0
          Width = 951
        end
        object imgHEADER_IMAGE: TcxDBImage
          Left = 18
          Top = 72
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          DataBinding.DataField = 'HEADER_IMAGE'
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.ShowFocusRect = False
          Style.Color = clBtnFace
          TabOrder = 1
          Height = 193
          Width = 951
        end
        object edGoogleTag: TcxDBTextEdit
          Left = 18
          Top = 295
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          DataBinding.DataField = 'GOOGLETAG'
          TabOrder = 2
          Width = 951
        end
      end
      object tbsBanners: TTabSheet
        AlignWithMargins = True
        Margins.Left = 10
        Margins.Top = 15
        Margins.Right = 10
        Margins.Bottom = 10
        Caption = #1041#1072#1085#1085#1077#1088#1099
        ImageIndex = 1
        object cxGridContent: TcxGrid
          Left = 0
          Top = 30
          Width = 1013
          Height = 271
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          TabOrder = 0
          object cxGridContentTable: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            OnFocusedRecordChanged = cxGridContentTableFocusedRecordChanged
            DataController.DataSource = IBCDataSourceImages
            DataController.KeyFieldNames = 'MAILINGID;PAIMAGEBRICKID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsCustomize.ColumnFiltering = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsSelection.InvertSelect = False
            OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1073#1072#1085#1085#1077#1088#1086#1074'>'
            OptionsView.ScrollBars = ssVertical
            OptionsView.CellAutoHeight = True
            OptionsView.ColumnAutoWidth = True
            OptionsView.GridLineColor = 13750737
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.Header = dmAdditions.cxStyle_GridHeader
            object cxGridContentTableColumn1: TcxGridDBColumn
              Caption = #1041#1072#1085#1085#1077#1088
              DataBinding.FieldName = 'IMAGE'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxImageProperties'
              Properties.GraphicClassName = 'TdxSmartImage'
              Properties.ReadOnly = True
              Properties.ShowFocusRect = False
              Width = 700
            end
            object cxGridContentTableColumn2: TcxGridDBColumn
              Caption = #1057#1089#1099#1083#1086#1082
              DataBinding.FieldName = 'LINK_COUNT'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxLabelProperties'
              Properties.Alignment.Horz = taCenter
              HeaderAlignmentHorz = taCenter
              MinWidth = 50
              Options.HorzSizing = False
              Width = 50
            end
          end
          object cxGridContentLevel: TcxGridLevel
            GridView = cxGridContentTable
          end
        end
        object dxBarDockControl1: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 1013
          Height = 30
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = dalTop
          BarManager = dxBarManager1
          SunkenBorder = True
          UseOwnSunkenBorder = True
        end
      end
      object tbsFooter: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = #1055#1086#1076#1074#1072#1083
        ImageIndex = 2
        object Label5: TLabel
          Left = 10
          Top = 20
          Width = 51
          Height = 15
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Caption = #1050#1072#1088#1090#1080#1085#1082#1072
        end
        object Label4: TLabel
          Left = 10
          Top = 270
          Width = 29
          Height = 15
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Caption = #1058#1077#1082#1089#1090
        end
        object imgFOOTER_IMAGE: TcxDBImage
          Left = 10
          Top = 41
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          DataBinding.DataField = 'FOOTER_IMAGE'
          Properties.GraphicClassName = 'TdxPNGImage'
          Properties.ImmediatePost = True
          Properties.ShowFocusRect = False
          Style.Color = clBtnFace
          TabOrder = 0
          Height = 210
          Width = 951
        end
        object edFOOTER_TEXT: TcxDBTextEdit
          Left = 10
          Top = 291
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          DataBinding.DataField = 'FOOTER_TEXT'
          TabOrder = 1
          Width = 951
        end
      end
    end
  end
  object dxBarManager1: TdxBarManager
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
    Left = 236
    Top = 12
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
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
      FloatLeft = 880
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddBanner'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveBanner'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddBanner: TdxBarButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddBannerClick
    end
    object bbRemoveBanner: TdxBarButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveBannerClick
    end
  end
  object IBCQueryImages: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TWEB_MAILING_IMAGEBRICKS'
      '  (MAILINGID, PAIMAGEBRICKID)'
      'VALUES'
      '  (:MAILINGID, :PAIMAGEBRICKID)')
    SQLDelete.Strings = (
      'DELETE FROM TWEB_MAILING_IMAGEBRICKS'
      'WHERE'
      
        '  MAILINGID = :Old_MAILINGID AND PAIMAGEBRICKID = :Old_PAIMAGEBR' +
        'ICKID')
    SQLUpdate.Strings = (
      'UPDATE TWEB_MAILING_IMAGEBRICKS'
      'SET'
      '  MAILINGID = :MAILINGID, PAIMAGEBRICKID = :PAIMAGEBRICKID'
      'WHERE'
      
        '  MAILINGID = :Old_MAILINGID AND PAIMAGEBRICKID = :Old_PAIMAGEBR' +
        'ICKID')
    SQLRefresh.Strings = (
      'SELECT MAILINGID, MA.PAIMAGEBRICKID, IMG.IMAGE,'
      
        ' (SELECT COUNT(NAV_URL) FROM TWEB_PA_IB_LINKS L WHERE L.PAIMAGEB' +
        'RICKID = IMG.PAIMAGEBRICKID) AS LINK_COUNT'
      'FROM TWEB_MAILING_IMAGEBRICKS MA'
      
        'INNER JOIN TWEB_PA_IMAGEBRICKS IMG ON IMG.PAIMAGEBRICKID = MA.PA' +
        'IMAGEBRICKID'
      'WHERE'
      
        '  MA.MAILINGID = :MAILINGID AND MA.PAIMAGEBRICKID = :PAIMAGEBRIC' +
        'KID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_MAILING_IMAGEBRICKS'
      'WHERE'
      
        'MAILINGID = :Old_MAILINGID AND PAIMAGEBRICKID = :Old_PAIMAGEBRIC' +
        'KID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT MAILINGID, MA.PAIMAGEBRICKID, IMG.IMAGE,'
      
        ' (SELECT COUNT(NAV_URL) FROM TWEB_PA_IB_LINKS L WHERE L.PAIMAGEB' +
        'RICKID = IMG.PAIMAGEBRICKID) AS LINK_COUNT'
      'FROM TWEB_MAILING_IMAGEBRICKS MA'
      
        'INNER JOIN TWEB_PA_IMAGEBRICKS IMG ON IMG.PAIMAGEBRICKID = MA.PA' +
        'IMAGEBRICKID'
      'ORDER BY MA.ORDERNO')
    MasterFields = 'MAILINGID'
    DetailFields = 'MAILINGID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    LocalConstraints = False
    Left = 488
    Top = 8
  end
  object IBCDataSourceImages: TIBCDataSource
    DataSet = IBCQueryImages
    Left = 360
    Top = 12
  end
end
