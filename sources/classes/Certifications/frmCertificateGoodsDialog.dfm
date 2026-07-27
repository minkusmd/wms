object frmCertificateGoodsDlg: TfrmCertificateGoodsDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridGoods
  BorderStyle = bsDialog
  Caption = 'Produse cu certificate'
  ClientHeight = 665
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    834
    665)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 834
    Height = 64
    Title = 'Produse cu certificate'
    Text = 'Indicati toate produse pentru certificat'
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
    Width = 818
    Height = 533
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
    DesignSize = (
      814
      529)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 814
      Height = 46
      Align = alTop
      Shape = bsSpacer
    end
    object cxLabel1: TLabel
      Left = 8
      Top = 15
      Width = 48
      Height = 15
      Caption = 'Certificat'
      Transparent = True
    end
    object lbCertfCount: TLabel
      Left = 12
      Top = 281
      Width = 3
      Height = 15
      Transparent = True
    end
    object edDENUMIREA: TcxDBTextEdit
      Left = 84
      Top = 12
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      DataBinding.DataField = 'DENUMIREA'
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 693
    end
    object cxGridGoods: TcxGrid
      AlignWithMargins = True
      Left = 2
      Top = 77
      Width = 810
      Height = 450
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      TabOrder = 2
      object cxGridGoodsTable: TcxGridDBTableView
        PopupMenu = pmPopupMenu
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
        OnCellDblClick = cxGridGoodsTableCellDblClick
        OnFocusedRecordChanged = cxGridGoodsTableFocusedRecordChanged
        DataController.DataSource = IBCDataSourceGoods
        DataController.KeyFieldNames = 'CERTIFICATID;GOODSID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skCount
            Column = cxGridGoods_GOODSID
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridGoods_GOODSID: TcxGridDBColumn
          Caption = 'Cod'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridGoods_TITLE: TcxGridDBColumn
          Caption = 'Denumire'
          DataBinding.FieldName = 'GOODS_TITLE'
        end
      end
      object cxGridGoodsLevel: TcxGridLevel
        GridView = cxGridGoodsTable
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      AlignWithMargins = True
      Left = 2
      Top = 46
      Width = 810
      Height = 30
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 1
      Align = dalTop
      BarManager = dxBarManager
      SunkenBorder = True
      UseOwnSunkenBorder = True
    end
  end
  object btnOk: TcxButton
    AlignWithMargins = True
    Left = 617
    Top = 619
    Width = 90
    Height = 29
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 16
    Margins.Bottom = 12
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    AlignWithMargins = True
    Left = 723
    Top = 619
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 380
    Top = 192
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'CG'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 595
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbAddGoods'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbReplace'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbRemoveGoods'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object bbAddGoods: TdxBarButton
      Caption = 'Adauga'
      Category = 0
      Hint = 'Adauga'
      Visible = ivAlways
      ImageIndex = 40
      ShortCut = 45
      OnClick = bbAddGoodsClick
    end
    object bbRemoveGoods: TdxBarButton
      Caption = 'Elimina'
      Category = 0
      Hint = 'Elimina'
      Visible = ivAlways
      ImageIndex = 42
      ShortCut = 46
      OnClick = bbRemoveGoodsClick
    end
    object bbReplace: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 113
      OnClick = bbReplaceClick
    end
  end
  object pmPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbAddGoods'
      end
      item
        Visible = True
        ItemName = 'bbReplace'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'bbRemoveGoods'
      end>
    UseOwnFont = False
    Left = 256
    Top = 204
    PixelsPerInch = 96
  end
  object IBCQueryGoods: TIBCQuery
    UpdatingTable = 'TS_GOODS_CERTIFICATES'
    KeyFields = 'CERTIFICATID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_CERTIFICATES'
      '  (CERTIFICATID, GOODSID)'
      'VALUES'
      '  (:CERTIFICATID, :GOODSID)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_CERTIFICATES'
      'WHERE'
      '  CERTIFICATID = :Old_CERTIFICATID AND GOODSID = :Old_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_CERTIFICATES'
      'SET'
      '  CERTIFICATID = :CERTIFICATID, GOODSID = :GOODSID'
      'WHERE'
      '  CERTIFICATID = :Old_CERTIFICATID AND GOODSID = :Old_GOODSID')
    SQLRefresh.Strings = (
      'SELECT '
      ' CERTIFICATID, '
      ' GOODSID,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TS_GOODS_CER' +
        'TIFICATES.GOODSID) AS GOODS_TITLE'
      'FROM '
      ' TS_GOODS_CERTIFICATES'
      'WHERE'
      ' CERTIFICATID = :CERTIFICATID '
      ' AND '
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_CERTIFICATES'
      'WHERE'
      'CERTIFICATID = :Old_CERTIFICATID AND GOODSID = :Old_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' CERTIFICATID,'
      ' GOODSID,'
      
        ' (SELECT TITLE FROM TS_GOODS WHERE TS_GOODS.GOODSID=TS_GOODS_CER' +
        'TIFICATES.GOODSID) AS GOODS_TITLE'
      'FROM'
      ' TS_GOODS_CERTIFICATES')
    MasterFields = 'CERTIFICATID'
    DetailFields = 'CERTIFICATID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 80
    Top = 288
  end
  object IBCDataSourceGoods: TIBCDataSource
    DataSet = IBCQueryGoods
    Left = 80
    Top = 232
  end
end
