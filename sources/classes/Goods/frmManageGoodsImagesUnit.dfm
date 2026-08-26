object frmManageGoodsImages: TfrmManageGoodsImages
  Left = 0
  Top = 0
  Caption = 'Gestionare imagini produse...'
  ClientHeight = 555
  ClientWidth = 963
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 963
    Height = 514
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tbsResizeGoodsImages
    Properties.CustomButtons.Buttons = <>
    ExplicitHeight = 670
    ClientRectBottom = 510
    ClientRectLeft = 4
    ClientRectRight = 959
    ClientRectTop = 26
    object tbsResizeGoodsImages: TcxTabSheet
      Caption = 'Modifica marimile imaginilor'
      ImageIndex = 0
      ExplicitLeft = 5
      ExplicitTop = 24
      ExplicitHeight = 640
      object dxBevel1: TdxBevel
        Left = 456
        Top = 296
        Width = 50
        Height = 50
      end
      object Bevel1: TBevel
        Left = 464
        Top = 304
        Width = 50
        Height = 50
      end
      object dxBevel2: TdxBevel
        Left = 583
        Top = 363
        Width = 369
        Height = 66
      end
      object lbImageWeight: TLabel
        Left = 640
        Top = 403
        Width = 23
        Height = 15
        Caption = '0 px'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbImageHeight: TLabel
        Left = 782
        Top = 403
        Width = 23
        Height = 15
        Caption = '0 px'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbImageSize: TLabel
        Left = 640
        Top = 378
        Width = 24
        Height = 15
        Caption = '0 Kb'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cxLabel1: TcxLabel
        Left = 16
        Top = 24
        Caption = 'Produse cu imagini mai mari decit (Kb)'
      end
      object ceImageSize: TcxCalcEdit
        Left = 248
        Top = 23
        EditValue = 600.000000000000000000
        Properties.DisplayFormat = '0'
        TabOrder = 1
        Width = 57
      end
      object cxButton1: TcxButton
        Left = 328
        Top = 22
        Width = 89
        Height = 25
        Caption = 'Cauta'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          61000000097048597300000EC200000EC20115284A8000000012744558745469
          746C650046696E643B5365617263683BAD078F620000016A49444154785EA591
          CD4A02611486BD8A46A789F1278568DFD65DB408341A1DB5C69F748CB983C84D
          942EEC565A0981E6FC383FB60964EA0A0A6951B619086C33703A332048F6CDC6
          17DE8FB3799F73CE774200B096FD67A16DD14CC71B660FFD1EAB1B9E7BD19A99
          0EAD6A159014CD56B26941EA7C0C471D1BB2373624C43144AB06B015BD1504F0
          3B27450B326D1BA65F3FB090571F5E4D802D8F80A98C0E8800EC64ED4A8F7EE0
          AF5E3FE6906A18C008EA3D11106F584EF1F60548CA759E8139D1666440DD740A
          5D32806BDB0850C880E89961ED4816BC7DCEFF5D2151D7812E05ACE09D8AAD99
          AEF761D3D9D22762BD7FF9049B25052225B51D7846B632BAC07341ACAA43F67A
          0219342B6818D6BC30448AAA4BF3324F02F862CACADE96A0F79953CDA105348E
          4D17D52E861180531414974208014056981F4A1886302F4398935D8A93791280
          0CE18612951F009597813AEE7F1300C1DAC83D34A97CDFD9E00677CB8075BC3E
          E0171A811CE8F7E0E9CD0000000049454E44AE426082}
        OptionsImage.Spacing = 8
        TabOrder = 2
        OnClick = cxButton1Click
      end
      object cxGrid1: TcxGrid
        Left = 16
        Top = 66
        Width = 561
        Height = 361
        TabOrder = 3
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnFocusedRecordChanged = cxGrid1DBTableView1FocusedRecordChanged
          DataController.DataSource = IBCDataSourceGoodsImages
          DataController.KeyFieldNames = 'GOODSID;goods_image_id'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          object cxGrid1DBTableView1Column1: TcxGridDBColumn
            DataBinding.FieldName = 'GOODSID'
            DataBinding.IsNullValueType = True
            Width = 77
          end
          object cxGrid1DBTableView1Column2: TcxGridDBColumn
            DataBinding.FieldName = 'GOODS_IMAGE_ID'
            DataBinding.IsNullValueType = True
            Width = 83
          end
          object cxGrid1DBTableView1Column3: TcxGridDBColumn
            Caption = 'IMAGE_SIZE (Kb))'
            DataBinding.FieldName = 'IMAGE_SIZE'
            DataBinding.IsNullValueType = True
            Width = 137
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object cxDBImage1: TcxDBImage
        Left = 583
        Top = 66
        DataBinding.DataField = 'IMAGE'
        DataBinding.DataSource = IBCDataSourceImages
        Properties.GraphicClassName = 'TdxPNGImage'
        Properties.OnAssignPicture = cxDBImage1PropertiesAssignPicture
        TabOrder = 4
        Height = 289
        Width = 369
      end
      object cxLabel5: TcxLabel
        Left = 592
        Top = 376
        Caption = 'Size'
      end
      object cxLabel6: TcxLabel
        Left = 592
        Top = 401
        Caption = 'Weight'
      end
      object cxLabel7: TcxLabel
        Left = 736
        Top = 401
        Caption = 'Height'
      end
      object cxButton2: TcxButton
        Left = 16
        Top = 433
        Width = 89
        Height = 25
        Caption = 'Resize'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001C744558745469746C65004E6578743B506C61793B4172
          726F773B52696768743B52716C480000005149444154785EC5D3C109C0201005
          D13438ED58409A4809B660771B3CFD4308C81CF4F0F0362CAC7B55D507F760BE
          2BFE0295880F4CF840E003810F04AD3F3210F840706C028E6D81FD3FD1DF82BF
          46EF050E8BD3A832CB82150000000049454E44AE426082}
        OptionsImage.Spacing = 8
        TabOrder = 8
        OnClick = cxButton2Click
      end
      object cxButton3: TcxButton
        Left = 111
        Top = 433
        Width = 89
        Height = 25
        Caption = 'Resize All'
        OptionsImage.Glyph.SourceDPI = 96
        OptionsImage.Glyph.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000001C744558745469746C65004E6578743B506C61793B4172
          726F773B52696768743B52716C480000005149444154785EC5D3C109C0201005
          D13438ED58409A4809B660771B3CFD4308C81CF4F0F0362CAC7B55D507F760BE
          2BFE0295880F4CF840E003810F04AD3F3210F840706C028E6D81FD3FD1DF82BF
          46EF050E8BD3A832CB82150000000049454E44AE426082}
        OptionsImage.Spacing = 8
        TabOrder = 9
        OnClick = cxButton3Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 514
    Width = 963
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 672
    object cxButton4: TcxButton
      Left = 416
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Inchide'
      TabOrder = 0
    end
  end
  object IBCQueryGoodsImages: TIBCQuery
    SQL.Strings = (
      
        'select gi.goodsid, gi.goods_image_id, (octet_length(image) / 102' +
        '4) image_size from ts_goods_image gi'
      'where (octet_length(image) / 1024) >:max_image_size')
    Left = 160
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'max_image_size'
        Value = nil
      end>
  end
  object IBCDataSourceGoodsImages: TIBCDataSource
    DataSet = IBCQueryGoodsImages
    Left = 160
    Top = 176
  end
  object IBCTransaction1: TIBCTransaction
    Left = 344
    Top = 272
  end
  object IBCQueryImages: TIBCQuery
    KeyFields = 'goodsid;goods_image_id'
    SQLInsert.Strings = (
      'INSERT INTO TS_GOODS_IMAGE'
      '  (GOODSID, GOODS_IMAGE_ID, IMAGE)'
      'VALUES'
      '  (:GOODSID, :GOODS_IMAGE_ID, :IMAGE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_GOODS_IMAGE'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND GOODS_IMAGE_ID = :Old_GOODS_IMAGE_I' +
        'D')
    SQLUpdate.Strings = (
      'UPDATE TS_GOODS_IMAGE'
      'SET'
      
        '  GOODSID = :GOODSID, GOODS_IMAGE_ID = :GOODS_IMAGE_ID, IMAGE = ' +
        ':IMAGE'
      'WHERE'
      
        '  GOODSID = :Old_GOODSID AND GOODS_IMAGE_ID = :Old_GOODS_IMAGE_I' +
        'D')
    SQLRefresh.Strings = (
      'SELECT GOODSID, GOODS_IMAGE_ID, IMAGE FROM TS_GOODS_IMAGE'
      'WHERE'
      '  GOODSID = :GOODSID AND GOODS_IMAGE_ID = :GOODS_IMAGE_ID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_GOODS_IMAGE'
      'WHERE'
      'GOODSID = :Old_GOODSID AND GOODS_IMAGE_ID = :Old_GOODS_IMAGE_ID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_GOODS_IMAGE'
      ''
      ') q')
    UpdateTransaction = IBCTransaction1
    SQL.Strings = (
      'select goodsid, goods_image_id, image from ts_goods_image')
    MasterFields = 'GOODSID;GOODS_IMAGE_ID'
    DetailFields = 'GOODSID;GOODS_IMAGE_ID'
    MasterSource = IBCDataSourceGoodsImages
    Left = 760
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GOODSID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'GOODS_IMAGE_ID'
        Value = nil
      end>
  end
  object IBCDataSourceImages: TIBCDataSource
    DataSet = IBCQueryImages
    Left = 760
    Top = 160
  end
end
