object frmGoodsPricesDlg: TfrmGoodsPricesDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Modificare preturi'
  ClientHeight = 560
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    450
    560)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 450
    Height = 64
    Title = 'Modificarea preturilor la produse'
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
    ImageIndex = 4
  end
  object Notebook: TNotebook
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 434
    Height = 429
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    TabOrder = 1
    object TPage
      Left = 0
      Top = 0
      Caption = 'Prices'
      object pnPrices: TPanel
        Left = 0
        Top = 0
        Width = 434
        Height = 429
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object Label1: TLabel
          Left = 28
          Top = 23
          Width = 37
          Height = 15
          Caption = 'Produs'
        end
        object lbPrice0: TLabel
          Left = 7
          Top = 123
          Width = 58
          Height = 15
          Caption = 'Pret Intrare'
          Visible = False
        end
        object lbPrice1: TLabel
          Left = 28
          Top = 174
          Width = 30
          Height = 15
          Caption = 'Pret 1'
          Visible = False
        end
        object lbPrice2: TLabel
          Left = 28
          Top = 203
          Width = 30
          Height = 15
          Caption = 'Pret 2'
          Visible = False
        end
        object lbPrice3: TLabel
          Left = 28
          Top = 232
          Width = 30
          Height = 15
          Caption = 'Pret 3'
          Visible = False
        end
        object lbPrice4: TLabel
          Left = 28
          Top = 261
          Width = 30
          Height = 15
          Caption = 'Pret 4'
          Visible = False
        end
        object lbPrice5: TLabel
          Left = 28
          Top = 290
          Width = 30
          Height = 15
          Caption = 'Pret 5'
          Visible = False
        end
        object lbPrice6: TLabel
          Left = 28
          Top = 319
          Width = 30
          Height = 15
          Caption = 'Pret 6'
          Visible = False
        end
        object lbPrice7: TLabel
          Left = 28
          Top = 348
          Width = 30
          Height = 15
          Caption = 'Pret 7'
          Visible = False
        end
        object lbMargin1: TLabel
          Left = 256
          Top = 174
          Width = 53
          Height = 15
          Caption = 'Margine 1'
          Visible = False
        end
        object lbMargin2: TLabel
          Left = 256
          Top = 203
          Width = 53
          Height = 15
          Caption = 'Margine 2'
          Visible = False
        end
        object lbMargin3: TLabel
          Left = 256
          Top = 232
          Width = 53
          Height = 15
          Caption = 'Margine 3'
          Visible = False
        end
        object lbMargin4: TLabel
          Left = 256
          Top = 261
          Width = 53
          Height = 15
          Caption = 'Margine 4'
          Visible = False
        end
        object lbMargin5: TLabel
          Left = 256
          Top = 290
          Width = 53
          Height = 15
          Caption = 'Margine 5'
          Visible = False
        end
        object lbMargin6: TLabel
          Left = 256
          Top = 319
          Width = 53
          Height = 15
          Caption = 'Margine 6'
          Visible = False
        end
        object lbMargin7: TLabel
          Left = 256
          Top = 348
          Width = 53
          Height = 15
          Caption = 'Margine 7'
          Visible = False
        end
        object lbCurrencyTitle: TLabel
          Left = 71
          Top = 155
          Width = 80
          Height = 15
          Caption = 'lbCurrencyTitle'
          Visible = False
        end
        object Label21: TLabel
          Left = 323
          Top = 155
          Width = 10
          Height = 15
          Alignment = taRightJustify
          Caption = '%'
          Visible = False
        end
        object Label2: TLabel
          Left = 166
          Top = 155
          Width = 67
          Height = 15
          Alignment = taCenter
          AutoSize = False
          Caption = #1051#1077#1080
          Visible = False
        end
        object sbPopupMenu: TSpeedButton
          Left = 152
          Top = 200
          Width = 14
          Height = 23
          Caption = #8595
          Visible = False
          OnClick = sbPopupMenuClick
        end
        object mmGoods: TMemo
          Left = 71
          Top = 20
          Width = 334
          Height = 77
          TabStop = False
          ReadOnly = True
          TabOrder = 0
        end
        object edPrice0: TEdit
          Left = 71
          Top = 120
          Width = 81
          Height = 23
          TabOrder = 1
          Visible = False
          OnExit = edPrice0Exit
        end
        object edPrice1: TEdit
          Left = 71
          Top = 171
          Width = 81
          Height = 23
          TabOrder = 3
          Visible = False
          OnExit = edPrice1Exit
        end
        object edPrice2: TEdit
          Left = 71
          Top = 200
          Width = 81
          Height = 23
          TabOrder = 7
          Visible = False
          OnExit = edPrice2Exit
        end
        object edPrice3: TEdit
          Left = 71
          Top = 229
          Width = 81
          Height = 23
          TabOrder = 9
          Visible = False
          OnExit = edPrice3Exit
        end
        object edPrice4: TEdit
          Left = 71
          Top = 258
          Width = 81
          Height = 23
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
          Visible = False
          OnExit = edPrice4Exit
        end
        object edPrice5: TEdit
          Left = 71
          Top = 287
          Width = 81
          Height = 23
          TabOrder = 15
          Visible = False
          OnExit = edPrice5Exit
        end
        object edPrice6: TEdit
          Left = 71
          Top = 316
          Width = 81
          Height = 23
          TabOrder = 18
          Visible = False
          OnExit = edPrice6Exit
        end
        object edPrice7: TEdit
          Left = 71
          Top = 345
          Width = 81
          Height = 23
          TabOrder = 21
          Visible = False
          OnExit = edPrice7Exit
        end
        object edMargin1: TEdit
          Left = 323
          Top = 171
          Width = 82
          Height = 23
          Enabled = False
          TabOrder = 5
          Visible = False
          OnExit = edMargin1Exit
        end
        object edMargin2: TEdit
          Left = 323
          Top = 200
          Width = 82
          Height = 23
          Enabled = False
          TabOrder = 8
          Visible = False
          OnExit = edMargin2Exit
        end
        object edMargin3: TEdit
          Left = 323
          Top = 229
          Width = 82
          Height = 23
          Enabled = False
          TabOrder = 11
          Visible = False
          OnExit = edMargin3Exit
        end
        object edMargin4: TEdit
          Left = 323
          Top = 258
          Width = 82
          Height = 23
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 14
          Visible = False
          OnExit = edMargin4Exit
        end
        object edMargin5: TEdit
          Left = 323
          Top = 287
          Width = 82
          Height = 23
          Enabled = False
          TabOrder = 17
          Visible = False
          OnExit = edMargin5Exit
        end
        object edMargin6: TEdit
          Left = 323
          Top = 316
          Width = 82
          Height = 23
          Enabled = False
          TabOrder = 20
          Visible = False
          OnExit = edMargin6Exit
        end
        object edMargin7: TEdit
          Left = 323
          Top = 345
          Width = 82
          Height = 23
          Enabled = False
          TabOrder = 23
          Visible = False
          OnExit = edMargin7Exit
        end
        object edPrice1_LEI: TEdit
          Left = 166
          Top = 171
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 4
          Visible = False
        end
        object edPrice2_LEI: TEdit
          Left = 166
          Top = 199
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 6
          Visible = False
        end
        object edPrice3_LEI: TEdit
          Left = 166
          Top = 229
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 10
          Visible = False
        end
        object edPrice4_LEI: TEdit
          Left = 166
          Top = 258
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI Semibold'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          Visible = False
        end
        object edPrice5_LEI: TEdit
          Left = 166
          Top = 287
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 16
          Visible = False
        end
        object edPrice6_LEI: TEdit
          Left = 166
          Top = 316
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 19
          Visible = False
        end
        object edPrice7_LEI: TEdit
          Left = 166
          Top = 345
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 22
          Visible = False
        end
        object edPrice0_LEI: TEdit
          Left = 166
          Top = 120
          Width = 67
          Height = 23
          TabStop = False
          Alignment = taRightJustify
          BorderStyle = bsNone
          ReadOnly = True
          TabOrder = 2
          Visible = False
        end
        object btnNext: TcxButton
          Left = 315
          Top = 382
          Width = 90
          Height = 29
          Caption = 'Inainte   >>'
          TabOrder = 24
          Visible = False
          OnClick = btnNextClick
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Save'
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnSave: TPanel
        Left = 0
        Top = 0
        Width = 434
        Height = 429
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clWindow
        ParentBackground = False
        TabOrder = 0
        object lbFinish: TLabel
          Left = 20
          Top = 300
          Width = 209
          Height = 15
          Caption = 'Click "OK" pentru salvarea modificarilor'
        end
        object Label20: TLabel
          Left = 20
          Top = 24
          Width = 153
          Height = 15
          Caption = 'Motivul modificarii preturilor'
          WordWrap = True
        end
        object Label3: TLabel
          Left = 20
          Top = 115
          Width = 43
          Height = 15
          Caption = 'Furnizor'
        end
        object rbNewDocument: TRadioButton
          Left = 20
          Top = 190
          Width = 193
          Height = 17
          Caption = 'Creaza document nou'
          TabOrder = 2
          OnClick = rbSelectDocumentClick
        end
        object rbSelectDocument: TRadioButton
          Left = 20
          Top = 221
          Width = 305
          Height = 17
          Caption = 'Adauga in document existent'
          TabOrder = 3
          OnClick = rbSelectDocumentClick
        end
        object beDocument: TcxButtonEdit
          Left = 36
          Top = 244
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
          Properties.OnButtonClick = beDocumentPropertiesButtonClick
          TabOrder = 4
          Width = 373
        end
        object mmComments: TMemo
          Left = 20
          Top = 41
          Width = 389
          Height = 60
          Enabled = False
          TabOrder = 0
        end
        object lcbSupplier: TcxLookupComboBox
          Left = 20
          Top = 136
          Properties.IncrementalFilteringOptions = [ifoHighlightSearchText, ifoUseContainsOperator]
          Properties.KeyFieldNames = 'CUSTOMERID'
          Properties.ListColumns = <
            item
              Width = 120
              FieldName = 'CUSTOMERID'
            end
            item
              Width = 250
              FieldName = 'NAME'
            end>
          Properties.ListFieldIndex = 1
          Properties.ListSource = IBCDataSourceSuppliers
          TabOrder = 1
          Width = 389
        end
        object btnPrevious: TcxButton
          Left = 20
          Top = 384
          Width = 90
          Height = 29
          Caption = '<< Inapoi'
          TabOrder = 5
          OnClick = btnPreviousClick
        end
      end
    end
  end
  object btnOk: TcxButton
    Left = 238
    Top = 515
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 340
    Top = 515
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object pmPrices: TPopupMenu
    Left = 376
    Top = 180
    object miPriceCalcPreset1: TMenuItem
      Caption = '-3%, -5%'
      OnClick = miPriceCalcPreset1Click
    end
  end
  object IBCQuerySuppliers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'select distinct c.customerid, c.name from ts_goods_foreign f'
      'inner join ts_customer c on c.customerid=f.customerid'
      'where goodsid=:goodsid')
    Left = 376
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'goodsid'
        Value = nil
      end>
  end
  object IBCDataSourceSuppliers: TIBCDataSource
    DataSet = IBCQuerySuppliers
    Top = 40
  end
end
