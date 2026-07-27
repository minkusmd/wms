object frmMergeGoodsDlg: TfrmMergeGoodsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1073#1100#1077#1076#1080#1085#1077#1085#1080#1077' 2-'#1093' '#1090#1086#1074#1072#1088#1086#1074
  ClientHeight = 307
  ClientWidth = 857
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 857
    Height = 64
    Title = #1054#1073#1100#1077#1076#1080#1085#1077#1085#1080#1077' 2-'#1093' '#1090#1086#1074#1072#1088#1086#1074
    Text = #1048#1079' '#1076#1074#1091#1093' '#1090#1086#1074#1072#1088#1086#1074' '#1086#1089#1090#1072#1085#1077#1090#1089#1103' '#1090#1086#1083#1100#1082#1086' '#1086#1076#1080#1085
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
    ExplicitWidth = 557
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 841
    Height = 185
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 156
      Top = 100
      Width = 97
      Height = 15
      Caption = #1050#1091#1076#1072' '#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 156
      Top = 16
      Width = 92
      Height = 15
      Caption = #1063#1090#1086' '#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 288
      Top = 16
      Width = 130
      Height = 15
      Caption = 'Acest produs va fi sters!!!'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object imgSource_IMAGE: TcxDBImage
      Left = 20
      Top = 16
      DataBinding.DataField = 'IMAGE'
      DataBinding.DataSource = IBCDataSourceSource
      Enabled = False
      Properties.GraphicClassName = 'TdxPNGImage'
      TabOrder = 0
      Height = 65
      Width = 85
    end
    object imgTarget_IMAGE: TcxDBImage
      Left = 20
      Top = 100
      DataBinding.DataField = 'IMAGE'
      DataBinding.DataSource = IBCDataSourceTarget
      Enabled = False
      Properties.GraphicClassName = 'TdxPNGImage'
      TabOrder = 1
      Height = 77
      Width = 85
    end
    object beTargetGoodsID: TcxButtonEdit
      Left = 156
      Top = 121
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
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
          Kind = bkGlyph
        end
        item
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000002B744558745469746C65004F70656E3B466F6C6465723B426172733B
            526962626F6E3B5374616E646172643B4C6F6164F1C3C4630000022249444154
            785EA593BD6B545110C57F6FF3242AA9B412144B3FB1500CA20663FC032C6C44
            B0B010041194147616366295805A88A058898D8D106C444D6C44123426120959
            36B8316FD9F8F2B15F6FDFBD7746B9EFAD82019B1CB81C6698397366E006AACA
            461000859CC959F327FC079DC1E1C4C381D785807EB21815A827E642DF8DB1E7
            E30F4E8BA2A0CA1F12A5F7FA281D8488F61FBAFC940C8A6DD5987A76F3DE9D4B
            FB468F5C7D53653D0470B94B426704DC2AA4DF517184380E9EBBB6DD99E1F2A9
            03DB4072BB0AA2608C1B1BB8F5E10C6032012BA00E5C422016D4D2250D0E5F1C
            24E8DE0104A00208AA8ED1BB57FA80AEBF02A9CB046C82DA26625BE00CD4CBA8
            CF1B54F21A1556AB75809E20080A800BDEDD3EA67D8343C8CA272AD3E3C40B15
            54404510C92EA7A28888E7A5F92AEAD38A38AD862675B4E28864A1C872D460FF
            F961BC786E1B71A85A108B3A8B8A0149894BDF78FB6868DEAFB05A2E11CFCCD2
            B3AB174D221AB32F51DF90DD47457C8C737E1D114769B2CCCA9A19094DDBB154
            9A632D5A66E7F1BDB42BD3D85ADC29CC9A54C04F17C40B0951B1C29772FD4598
            B62D4B73737477F7B0796B487D6602DB58F6D63B2E347391E71CB59536F1CFC6
            D7FBEFA362D86AA4B018B1E7C44992C529926AD14F50BF7BA749BD082A5EA8BA
            9010D7CD0860C24633FD88AB1D9D1C79C5647E5D72560001505401554421B55A
            FEFCA3F9184803600BB00928B01EC13FB10206489E9CDDED0036FC9D7F01FAB6
            A14B22EE620A0000000049454E44AE426082}
          Kind = bkGlyph
        end>
      Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
      TabOrder = 2
      Width = 669
    end
    object beSourceGoodsID: TcxButtonEdit
      Left = 156
      Top = 37
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
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
          Kind = bkGlyph
        end>
      Properties.OnButtonClick = beSourceGoodsIDPropertiesButtonClick
      TabOrder = 3
      Width = 669
    end
  end
  object btnOk: TcxButton
    Left = 649
    Top = 268
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 745
    Top = 268
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQuerySource: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_GOODS.*,'
      
        ' (SELECT FIRST 1 IMAGE FROM TS_GOODS_IMAGE WHERE TS_GOODS_IMAGE.' +
        'GOODSID=TS_GOODS.GOODSID ORDER BY TS_GOODS_IMAGE.ORDERNO)'
      'FROM'
      ' TS_GOODS'
      'WHERE'
      ' GOODSID=:id')
    ReadOnly = True
    Left = 80
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceSource: TIBCDataSource
    DataSet = IBCQuerySource
    Left = 80
    Top = 104
  end
  object IBCQueryTarget: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_GOODS.*,'
      
        ' (SELECT FIRST 1 IMAGE FROM TS_GOODS_IMAGE WHERE TS_GOODS_IMAGE.' +
        'GOODSID=TS_GOODS.GOODSID ORDER BY TS_GOODS_IMAGE.ORDERNO)'
      'FROM'
      ' TS_GOODS'
      'WHERE'
      ' GOODSID=:id')
    ReadOnly = True
    Left = 716
    Top = 168
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        Value = nil
      end>
  end
  object IBCDataSourceTarget: TIBCDataSource
    DataSet = IBCQueryTarget
    Left = 716
    Top = 120
  end
end
