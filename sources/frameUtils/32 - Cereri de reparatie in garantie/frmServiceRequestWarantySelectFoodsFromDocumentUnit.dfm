object frmServiceRequestWarantySelectFoodsFromDocumentDlg: TfrmServiceRequestWarantySelectFoodsFromDocumentDlg
  Left = 0
  Top = 0
  ActiveControl = beDOCID
  BorderStyle = bsDialog
  Caption = 'Selecteaza produsele din document vinzare'
  ClientHeight = 548
  ClientWidth = 1071
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1071
    548)
  PixelsPerInch = 96
  TextHeight = 15
  object cxLabel1: TcxLabel
    Left = 8
    Top = 70
    Caption = 'Certificat de garantie'
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 1071
    Height = 64
    Title = 'Alege produsele'
    Text = 'Selectarea produselor din documentul de vinzare'
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
    ImageIndex = 25
  end
  object Panel1: TPanel
    Left = 7
    Top = 138
    Width = 1060
    Height = 354
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 6
    DesignSize = (
      1056
      350)
    object btnToVinzari: TSpeedButton
      Left = 508
      Top = 168
      Width = 26
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '<'
      OnClick = btnToVinzariClick
      ExplicitLeft = 502
    end
    object btnToRetur: TSpeedButton
      Left = 508
      Top = 136
      Width = 26
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '>'
      OnClick = btnToReturClick
      ExplicitLeft = 502
    end
    object btnMoveAllToRetur: TSpeedButton
      Left = 508
      Top = 104
      Width = 26
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '>>'
      OnClick = btnMoveAllToReturClick
    end
    object cxGrid1: TcxGrid
      AlignWithMargins = True
      Left = 543
      Top = 56
      Width = 504
      Height = 288
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akTop, akRight, akBottom]
      TabOrder = 4
      object tvRetur: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = tvRetur_SUMA
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.ImmediateEditor = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object tvRetur_GOODSID: TcxGridColumn
          Caption = 'Cod'
          Width = 58
        end
        object tvRetur_GOODSNAME: TcxGridColumn
          Caption = 'Produs'
          Width = 253
        end
        object tvRetur_SN: TcxGridColumn
          Caption = 'Serie/Partida'
          Width = 124
        end
        object tvRetur_QTY: TcxGridColumn
          Caption = 'Cant'
        end
        object tvRetur_PRICE: TcxGridColumn
          Caption = 'Pret'
          Width = 80
        end
        object tvRetur_SUMA: TcxGridColumn
          Caption = 'Suma'
          DataBinding.Expression = #1'[Cant]*[Pret]'
        end
        object tvRetur_UM: TcxGridColumn
          Visible = False
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = tvRetur
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 0
      Width = 1056
      Height = 28
      Align = dalTop
      BarManager = dxBarManager1
    end
    object cxGrid2: TcxGrid
      AlignWithMargins = True
      Left = 4
      Top = 56
      Width = 499
      Height = 288
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 3
      object tvVinzari: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object tvVinzari_GOODSID: TcxGridColumn
          Caption = 'Cod'
          Width = 63
        end
        object tvVinzari_GOODSNAME: TcxGridColumn
          Caption = 'Produs'
          Width = 196
        end
        object tvVinzari_SN: TcxGridColumn
          Caption = 'Serie/Partida'
          Width = 118
        end
        object tvVinzari_QTY: TcxGridColumn
          Caption = 'Cant'
          Width = 63
        end
        object tvVinzari_PRICE: TcxGridColumn
          Caption = 'Pret'
          Width = 67
        end
        object tvVinzari_UM: TcxGridColumn
          Caption = 'UM'
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = tvVinzari
      end
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 32
      Caption = 'Lista produse in documentul de vinzare'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
    end
    object cxLabel4: TcxLabel
      Left = 542
      Top = 32
      Anchors = [akTop, akRight]
      Caption = 'Lista produse in documentul de retur'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
    end
  end
  object cxButton1: TcxButton
    Left = 858
    Top = 503
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object cxButton2: TcxButton
    Left = 954
    Top = 503
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 8
  end
  object beDOCID: TcxButtonEdit
    Left = 128
    Top = 70
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ClearKey = 16392
    Properties.OnButtonClick = beDOCIDPropertiesButtonClick
    TabOrder = 3
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 100
    Caption = 'Cumparator'
  end
  object beCustomer: TcxButtonEdit
    Left = 128
    Top = 99
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 4
    Width = 401
  end
  object Panel2: TPanel
    Left = 552
    Top = 64
    Width = 513
    Height = 73
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clInfoBk
    ParentBackground = False
    TabOrder = 1
    object cxLabel5: TcxLabel
      Left = 16
      Top = 8
      Caption = 'Suma documentului:'
    end
    object lbDocumentSum: TcxLabel
      Left = 147
      Top = 8
      Caption = '121 235.00'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
    end
    object cxLabel6: TcxLabel
      Left = 16
      Top = 24
      Caption = 'Document creat de:'
    end
    object lbCreatedBy: TcxLabel
      Left = 147
      Top = 24
      Caption = 'Minchevici Sergiu'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
    end
    object label1: TcxLabel
      Left = 16
      Top = 40
      Caption = 'Suma achitarii conform facturii:'
    end
    object cxLabel9: TcxLabel
      Left = 193
      Top = 40
      AutoSize = False
      Caption = 'NAN'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = [fsBold]
      Style.IsFontAssigned = True
      Height = 19
      Width = 59
    end
  end
  object IBCQueryRezerve: TIBCQuery
    SQL.Strings = (
      
        'select j.docid, d.ct, d.ct_name, j.goodsid, j.goods_name, s.sn, ' +
        '1 qty, j.price, j.umid  from vw_tdb_jurnal j'
      'inner join vw_tdb_docs d on d.docid=j.docid'
      
        'join tdb_sn s on s.docid=j.docid and s.dtdep=j.dtdep and s.ctdep' +
        ' = j.ctdep and s.goodsid = j.goodsid'
      
        ' where j.docid=:docid and j.flg_active = 1 and j.goodscomplect_i' +
        'd = -1'
      ' union all'
      
        'select j.docid, d.ct, d.ct_name, j.goodsid, j.goods_name, p.part' +
        'no, p.qty, j.price, j.umid  from vw_tdb_jurnal j'
      'inner join vw_tdb_docs d on d.docid=j.docid'
      
        ' join tdb_parts p on p.docid=j.docid and p.dtdep=j.dtdep and p.c' +
        'tdep = j.ctdep and p.goodsid = j.goodsid'
      
        ' where j.docid=:docid and j.flg_active = 1 and j.goodscomplect_i' +
        'd = -1')
    Left = 328
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
  object IBCDataSourceRezerve: TIBCDataSource
    DataSet = IBCQueryRezerve
    Left = 240
    Top = 216
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
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 328
    Top = 112
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbComplectatia'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbComplectatia: TdxBarButton
      Caption = 'Complectatia'
      Category = 0
      Hint = 'Complectatia'
      Visible = ivAlways
    end
  end
  object IBCQueryJurnalRetur: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select j.docid, d.ct, d.ct_name, j.goodsid, j.goods_name, s.sn, ' +
        '1 qty, j.price  from vw_tdb_jurnal j'
      'inner join vw_tdb_docs d on d.docid=j.docid'
      
        'join tdb_sn s on s.docid=j.docid and s.dtdep=j.dtdep and s.ctdep' +
        ' = j.ctdep and s.goodsid = j.goodsid'
      ' where j.docid=:docid and j.flg_active = 1'
      ' union all'
      
        'select j.docid, d.ct, d.ct_name, j.goodsid, j.goods_name, p.part' +
        'no, p.qty, j.price  from vw_tdb_jurnal j'
      'inner join vw_tdb_docs d on d.docid=j.docid'
      
        ' join tdb_parts p on p.docid=j.docid and p.dtdep=j.dtdep and p.c' +
        'tdep = j.ctdep and p.goodsid = j.goodsid'
      ' where j.docid=:docid and j.flg_active = 1')
    Left = 456
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'docid'
        Value = nil
      end>
  end
end
