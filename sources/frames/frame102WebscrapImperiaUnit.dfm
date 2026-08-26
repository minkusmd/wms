inherited frame102WebScrapImperia: Tframe102WebScrapImperia
  Width = 1245
  Height = 662
  Font.Height = -15
  ExplicitWidth = 1245
  ExplicitHeight = 662
  PixelsPerInch = 120
  object Memo1: TMemo
    Left = 416
    Top = 122
    Width = 826
    Height = 526
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 410
    Height = 662
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 1
    object cxGridMuncitorulGoods: TcxGrid
      Left = 1
      Top = 1
      Width = 408
      Height = 660
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridMuncitorulGoodsDBTableView1: TcxGridDBTableView
        OnKeyDown = cxGridMuncitorulGoodsDBTableView1KeyDown
        DataController.DataSource = IBCDataSource1
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            FieldName = 'GOODS_CODE'
            Column = cxGridMuncitorulGoodsDBTableView1GOODS_CODE
          end>
        FilterRow.SeparatorWidth = 8
        FixedDataRows.SeparatorWidth = 8
        NewItemRow.SeparatorWidth = 8
        OptionsView.NavigatorOffset = 63
        OptionsView.FixedColumnSeparatorWidth = 3
        OptionsView.Footer = True
        OptionsView.Indicator = True
        Preview.LeftIndent = 25
        Preview.RightIndent = 6
        RowLayout.MinValueWidth = 100
        object cxGridMuncitorulGoodsDBTableView1GOODSID: TcxGridDBColumn
          Caption = 'cod'
          DataBinding.FieldName = 'GOODSID'
        end
        object cxGridMuncitorulGoodsDBTableView1GOODS_CODE: TcxGridDBColumn
          Caption = 'cpf'
          DataBinding.FieldName = 'GOODS_CODE'
          Width = 93
        end
        object cxGridMuncitorulGoodsDBTableView1GOODSNAME: TcxGridDBColumn
          Caption = 'produs'
          DataBinding.FieldName = 'GOODS_TITLE'
          Width = 232
        end
      end
      object cxGridMuncitorulGoodsLevel1: TcxGridLevel
        GridView = cxGridMuncitorulGoodsDBTableView1
      end
    end
  end
  object Panel2: TPanel
    Left = 416
    Top = 3
    Width = 826
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object btnStart: TcxButton
      Left = 138
      Top = 54
      Width = 135
      Height = 29
      Caption = 'Start'
      Default = True
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnStartClick
    end
    object cbFlgNoImage: TCheckBox
      Left = 16
      Top = 12
      Width = 161
      Height = 17
      Caption = 'Produsele fara imagini'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cbFlgInPRICE: TCheckBox
      Left = 216
      Top = 12
      Width = 97
      Height = 17
      Caption = 'In pricelist'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cbUpdateAllImages: TCheckBox
      Left = 319
      Top = 12
      Width = 178
      Height = 17
      Caption = 'Sincronizeaza toate imaginile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object cxButton3: TcxButton
      Left = 16
      Top = 54
      Width = 116
      Height = 29
      Caption = 'Open / Refresh'
      TabOrder = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = cxButton3Click
    end
    object ProgressBar1: TProgressBar
      AlignWithMargins = True
      Left = 3
      Top = 85
      Width = 816
      Height = 21
      Align = alBottom
      TabOrder = 5
      ExplicitTop = 89
    end
    object btnStop: TcxButton
      Left = 288
      Top = 58
      Width = 75
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 6
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnStopClick
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
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
    Left = 64
    Top = 68
    PixelsPerInch = 120
    object bbProvesti: TdxBarButton
      Caption = 'Valideaza transactia'
      Category = 0
      Hint = 'Valideaza transactia'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
    end
    object bbCancelProvodca: TdxBarButton
      Caption = 'Anuleaza validarea'
      Category = 0
      Hint = 'Anuleaza validarea'
      Visible = ivAlways
    end
    object bbDocComments: TdxBarButton
      Caption = 'Mentiuni'
      Category = 0
      Hint = 'Mentiuni'
      Visible = ivAlways
    end
    object bbCustomerDebts: TdxBarButton
      Caption = 'Creante si datorii'
      Category = 0
      Hint = 'Creante si datorii'
      Visible = ivAlways
      ShortCut = 16452
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Treci la documentul parinte'
      Category = 0
      Hint = 'Treci la documentul parinte'
      Visible = ivAlways
      ShortCut = 32805
    end
  end
  object cxGridPopupMenu: TcxGridPopupMenu
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = pmPopupMenuDoc
      end>
    UseBuiltInPopupMenus = False
    AlwaysFireOnPopup = True
    Left = 12
    Top = 148
  end
  object pmPopupMenuDoc: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbProvesti'
      end
      item
        Visible = True
        ItemName = 'bbCancelProvodca'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbCustomerDebts'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbDocComments'
      end
      item
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 124
    Top = 156
    PixelsPerInch = 120
  end
  object IBCQueryGoods: TIBCQuery
    SQL.Strings = (
      'select GF.GOODSID, GF.GOODS_CODE, gf.goods_title,'
      'get_flg_in_price(gf.goodsid) FLG_IN_PRICE'
      'from TS_GOODS_FOREIGN GF'
      'where GF.CUSTOMERID = :supplierid'
      '&FlgNoImage'
      '&FlgInPrice')
    Left = 528
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'supplierid'
        Value = nil
      end>
    MacroData = <
      item
        Name = 'FlgNoImage'
      end
      item
        Name = 'FlgInPrice'
      end>
  end
  object IBCDataSource1: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 528
    Top = 264
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 888
    Top = 72
  end
  object IBCSQL1: TIBCSQL
    Connection = dmDB.IBCConnection
    Transaction = IBCtrLocalUpdate
    SQL.Strings = (
      'insert into ts_goods_image (goodsid, image)'
      'values(:goodsid, :image)')
    Left = 760
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'image'
        Value = nil
      end>
  end
  object IBCtrLocalUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 760
    Top = 208
  end
end
