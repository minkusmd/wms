object frmWebGoodsGroupsEditorDlg: TfrmWebGoodsGroupsEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produse pe prima pagina a site-ului'
  ClientHeight = 553
  ClientWidth = 941
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    941
    553)
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 941
    Height = 64
    Title = 'Produse in grupa'
    Text = 'Lista de produse in categorie pentru pagina principala'
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
    ImageIndex = 21
  end
  object Button1: TButton
    Left = 719
    Top = 524
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ImageAlignment = iaRight
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 576
  end
  object Button2: TButton
    Left = 815
    Top = 524
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 576
  end
  object cxPageControl1: TcxPageControl
    Left = 9
    Top = 70
    Width = 924
    Height = 447
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Properties.ActivePage = tsGroupInfo
    Properties.CustomButtons.Buttons = <>
    ExplicitHeight = 499
    ClientRectBottom = 443
    ClientRectLeft = 4
    ClientRectRight = 920
    ClientRectTop = 26
    object tsGroupInfo: TcxTabSheet
      Caption = 'Definirea grupei'
      ImageIndex = 0
      ExplicitHeight = 452
      object Label1: TLabel
        Left = 11
        Top = 3
        Width = 46
        Height = 15
        Caption = 'Perioada'
      end
      object Label2: TLabel
        Left = 11
        Top = 51
        Width = 86
        Height = 15
        Caption = 'Denumire grupa'
      end
      object Label3: TLabel
        Left = 12
        Top = 99
        Width = 96
        Height = 15
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1087#1087#1099
      end
      object Label4: TLabel
        Left = 251
        Top = 51
        Width = 72
        Height = 15
        Caption = 'URL mai mult'
      end
      object Label5: TLabel
        Left = 252
        Top = 99
        Width = 57
        Height = 15
        Caption = 'URL '#1044#1072#1083#1077#1077
      end
      object deStart: TcxDBDateEdit
        Left = 11
        Top = 22
        DataBinding.DataField = 'DATA1'
        ParentFont = False
        TabOrder = 0
        Width = 110
      end
      object deEnd: TcxDBDateEdit
        Left = 131
        Top = 22
        DataBinding.DataField = 'DATA2'
        ParentFont = False
        TabOrder = 1
        Width = 110
      end
      object teTITLE_RO: TcxDBTextEdit
        Left = 11
        Top = 70
        DataBinding.DataField = 'TITLE_RO'
        ParentFont = False
        TabOrder = 2
        Width = 230
      end
      object teTITLE_RU: TcxDBTextEdit
        Left = 12
        Top = 118
        DataBinding.DataField = 'TITLE_RU'
        ParentFont = False
        TabOrder = 3
        Width = 229
      end
      object Panel1: TPanel
        Left = 0
        Top = 165
        Width = 916
        Height = 252
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel1'
        TabOrder = 4
        ExplicitTop = 173
        object dxBarDockControl2: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 916
          Height = 24
          Align = dalTop
          BarManager = dxBarManager1
        end
        object cxGrid1: TcxGrid
          AlignWithMargins = True
          Left = 3
          Top = 27
          Width = 910
          Height = 222
          Align = alClient
          TabOrder = 1
          ExplicitHeight = 325
          object cxGrid1DBTableView1: TcxGridDBTableView
            OnKeyDown = cxGrid1DBTableView1KeyDown
            Navigator.Buttons.CustomButtons = <>
            ScrollbarAnnotations.CustomAnnotations = <>
            DataController.DataSource = IBCDataSourceGroupGoods
            DataController.KeyFieldNames = 'GOODSID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                Column = cxGrid1DBTableView1_GOODSID
              end
              item
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.IncSearch = True
            OptionsBehavior.ImmediateEditor = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.ColumnAutoWidth = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Styles.OnGetContentStyle = cxGrid1DBTableView1StylesGetContentStyle
            object cxGrid1DBTableView1_GOODSID: TcxGridDBColumn
              Caption = 'Cod'
              DataBinding.FieldName = 'GOODSID'
              DataBinding.IsNullValueType = True
              Width = 47
            end
            object cxGrid1DBTableView1_GOODS_NAME: TcxGridDBColumn
              Caption = 'Produs'
              DataBinding.FieldName = 'GOODSNAME'
              DataBinding.IsNullValueType = True
              Width = 301
            end
            object cxGrid1DBTableView1_PRICE4: TcxGridDBColumn
              Caption = 'P4'
              DataBinding.FieldName = 'PRICE4_LEI'
              DataBinding.IsNullValueType = True
              HeaderAlignmentHorz = taCenter
              Width = 67
            end
            object cxGrid1DBTableView_FLG_FORCED: TcxGridDBColumn
              Caption = 'F'
              DataBinding.FieldName = 'FLG_FORCED'
              DataBinding.IsNullValueType = True
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              HeaderAlignmentHorz = taCenter
              Width = 30
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object cxDBTextEdit1: TcxDBTextEdit
        Left = 251
        Top = 70
        DataBinding.DataField = 'URL_MORE_RO'
        ParentFont = False
        TabOrder = 5
        Width = 300
      end
      object cxDBTextEdit2: TcxDBTextEdit
        Left = 252
        Top = 118
        DataBinding.DataField = 'URL_MORE_RU'
        ParentFont = False
        TabOrder = 6
        Width = 300
      end
      object cxDBRadioGroup1: TcxDBRadioGroup
        Left = 576
        Top = 40
        Caption = 'cxDBRadioGroup1'
        Properties.Items = <
          item
            Caption = 'Categorie produse'
            Value = 1
          end
          item
            Caption = 'Lista de produse'
            Value = 0
          end>
        TabOrder = 7
        Height = 105
        Width = 185
      end
      object cxDBCheckGroup1: TcxDBCheckGroup
        Left = 744
        Top = 40
        Caption = 'cxDBCheckGroup1'
        Properties.Items = <
          item
            Caption = 'Categorie produse'
          end
          item
            Caption = 'Lista de produse'
          end>
        TabOrder = 8
        Height = 105
        Width = 185
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 432
    Top = 304
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Toolbar'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 906
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbEdit'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbGoodsDelete'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbGoodsNew: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbGoodsNewClick
    end
    object bbEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbEditClick
    end
    object bbGoodsDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 16430
      OnClick = bbGoodsDeleteClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Sterge toate inactive'
      Category = 0
      Hint = 'Sterge toate inactive'
      Visible = ivAlways
      ImageIndex = 35
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'Importa din actiuni'
      Category = 0
      Hint = 'Importa din actiuni'
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C00000011744558745469746C6500446F776E3B4172726F773BBD
        FC82580000021E49444154785E6591316814411885BF99DDBD530435510B0BC3
        555E95144A8C46F48AEBA2A43016F65A182CB4104CAF9D8D6550B4B2B4508895
        0A625288A26050E4AC0425C110C9C588DEEDEECCEFF90FC31679ECEE3FF398FF
        EDFBE799B987CB2F8DB52D2F20FA0A4E40BCE009A4F75AF08272225016F9E2FD
        2B13EDF47F73FBD821D0C328C4104E0736D05E79A50B272C2C7E3D0524A90079
        E1F8F0FD37C1016050886EA23691A4797057DC9B543C7CFAB2C6FAAF1C412058
        0551ABCA89AE4DA840BFBB151549F76EAC327BAEC5DFBE0BA43188F794AED406
        630C6992626CB405F52CE1F6FCB3E0C0791F6C63102318449BEF2C7488B83AD5
        24AB6720AA1FEEC27B6DB2DEABADF0B79884F3ACAC6C70E6EC513A9D55BC4477
        5552DE4910709A110A2F425114F4F2FEA03ADEAD09CE09BD5E9FBC9F23311901
        ED03AC739A2C106C3D78FA911BF7DE52964ED3C952CBF5F937DC7DB23CE04A84
        00EF258EE0ABAC314C4F8ED0FDB1CEE1F649F24268B627D95AFFC9F956036B6D
        8CB7BA03E784A860AC65FFF01E2E4D8FF2FAF10B7AA51FD4E7CCCE8C313CB41B
        6393102FA61A411D082132046B138E1F69307AC0F079E93DE32375C6C71A2469
        169A0540AA1182928041950D50ABD5B97CE10443DD6F5C9C99A056DF01860815
        F11204527141354BACE61B3E967D83516E5D9B22491275054284203111493737
        375FCDDD7C745A88EA02FA5491C5855021EFFF59020A03EC0432C0B21DC1F876
        085000BD7F8CA0608FE53C7C9B0000000049454E44AE426082}
      ImageIndex = 109
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Sortare'
      Category = 0
      Hint = 'Sortare'
      Visible = ivAlways
      ImageIndex = 38
      OnClick = dxBarButton3Click
    end
  end
  object IBCQueryGroupGoods: TIBCQuery
    KeyFields = 'ggid;goodsid'
    SQLInsert.Strings = (
      'INSERT INTO VW_TWEB_FP_GROUPS_GOODS'
      
        '  (GGID, GOODSID, GOODSNAME, CREATED_BY, CREATED_BY_NAME, ORDERN' +
        'O)'
      'VALUES'
      
        '  (:GGID, :GOODSID, :GOODSNAME, :CREATED_BY, :CREATED_BY_NAME, :' +
        'ORDERNO)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TWEB_FP_GROUPS_GOODS'
      'WHERE'
      '  GGID = :Old_GGID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TWEB_FP_GROUPS_GOODS'
      'SET'
      
        '  GGID = :GGID, GOODSID = :GOODSID, GOODSNAME = :GOODSNAME, CREA' +
        'TED_BY = :CREATED_BY, CREATED_BY_NAME = :CREATED_BY_NAME, ORDERN' +
        'O = :ORDERNO'
      'WHERE'
      '  GGID = :Old_GGID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      
        'SELECT GGID, GOODSID, GOODSNAME, CREATED_BY, CREATED_BY_NAME, OR' +
        'DERNO FROM VW_TWEB_FP_GROUPS_GOODS'
      'WHERE'
      '  GGID = :GGID AND GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TWEB_FP_GROUPS_GOODS'
      'WHERE'
      'GGID = :Old_GGID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TWEB_FP_GROUPS_GOODS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = IBCTransaction1
    SQL.Strings = (
      
        'select gg.GGID, gg.GOODSID, gg.GOODSNAME, gg.CREATED_BY, gg.CREA' +
        'TED_BY_NAME, gg.orderno, mi.price4_lei,'
      'iif(exists(select GOODSID'
      ' from TDB_GOODS_FLAGS'
      ' where GOODSID = GG.GOODSID and'
      '       FLAGTYPEID in (3, 5) and'
      '       DT = 5213), 1, 0) FLG_FORCED'
      'from VW_TWEB_FP_GROUPS_GOODS GG'
      'inner join WEB_GET_GOODS_MIN_INFO(gg.goodsid) mi on 1=1'
      '--where GG.GGID = :GGID'
      'order by orderno'
      ''
      '  ')
    Left = 208
    Top = 392
  end
  object IBCDataSourceGroupGoods: TIBCDataSource
    DataSet = IBCQueryGroupGoods
    Left = 80
    Top = 392
  end
  object IBCTransaction1: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 240
    Top = 304
  end
end
