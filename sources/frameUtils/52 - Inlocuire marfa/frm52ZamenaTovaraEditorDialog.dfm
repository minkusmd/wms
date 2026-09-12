object frm52ZamenaTovaraEditorDlg: Tfrm52ZamenaTovaraEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Inventariere'
  ClientHeight = 524
  ClientWidth = 1071
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1071
    Height = 64
    Title = 'Inventarierea produselor'
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
    ImageIndex = 22
  end
  object Panel1: TPanel
    Left = 0
    Top = 465
    Width = 1071
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    Padding.Top = 12
    Padding.Right = 24
    Padding.Bottom = 18
    TabOrder = 2
    object btnOk: TButton
      AlignWithMargins = True
      Left = 855
      Top = 12
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 957
      Top = 12
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = 'Anuleaza'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1055
    Height = 385
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnClient'
    ShowCaption = False
    TabOrder = 1
    object cxPageControl2: TcxPageControl
      Left = 0
      Top = 0
      Width = 525
      Height = 385
      Align = alLeft
      TabOrder = 0
      Properties.ActivePage = pnSource
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 381
      ClientRectLeft = 4
      ClientRectRight = 521
      ClientRectTop = 26
      object pnSource: TcxTabSheet
        Caption = 'PRODUSE SPRE CASARE'
        ImageIndex = 0
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label3: TLabel
          Left = 11
          Top = 3
          Width = 40
          Height = 15
          Caption = 'Depozit'
        end
        object Label4: TLabel
          Left = 11
          Top = 52
          Width = 37
          Height = 15
          Caption = 'Produs'
        end
        object lbIDEN_DT: TLabel
          Left = 11
          Top = 100
          Width = 141
          Height = 15
          Caption = 'Numar de serie sau partida'
        end
        object Label5: TLabel
          Left = 371
          Top = 100
          Width = 21
          Height = 15
          Caption = 'Pret'
        end
        object Label1: TLabel
          Left = 11
          Top = 148
          Width = 83
          Height = 15
          Caption = 'Tara producator'
          Transparent = True
        end
        object Label2: TLabel
          Left = 239
          Top = 148
          Width = 59
          Height = 15
          Caption = 'Producator'
          Transparent = True
        end
        object Label11: TLabel
          Left = 11
          Top = 288
          Width = 194
          Height = 15
          Caption = 'Numarul actului de primire - predare'
          Transparent = True
        end
        object Label12: TLabel
          Left = 11
          Top = 317
          Width = 196
          Height = 15
          Caption = 'Numarul actului de achitari reciproce'
          Transparent = True
        end
        object beGOODS_DT: TcxButtonEdit
          Left = 11
          Top = 69
          Properties.Buttons = <
            item
              Caption = 'Alege'
              Default = True
              Hint = 'F4'
              Kind = bkText
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beGOODS_DTPropertiesButtonClick
          TabOrder = 2
          Width = 485
        end
        object beIDEN_DT: TcxButtonEdit
          Left = 11
          Top = 119
          Properties.Buttons = <
            item
              Caption = 'Alege'
              Default = True
              Hint = 'F6'
              Kind = bkText
            end>
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beIDEN_DTPropertiesButtonClick
          TabOrder = 4
          Width = 333
        end
        object lcbDT_DEP: TcxDBLookupComboBox
          Left = 11
          Top = 20
          DataBinding.DataField = 'DT_DEP'
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.KeyFieldNames = 'STOCKID'
          Properties.ListColumns = <
            item
              Fixed = True
              Width = 180
              FieldName = 'TITLE'
            end
            item
              Fixed = True
              Width = 120
              FieldName = 'PARENT_TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dmDB.IBCDataSourceStocks
          TabOrder = 0
          Width = 333
        end
        object ceDT_PRICE: TcxDBCalcEdit
          Left = 371
          Top = 117
          DataBinding.DataField = 'DT_PRICE'
          TabOrder = 3
          Width = 125
        end
        object edCOUNTRY_DT: TcxTextEdit
          Left = 11
          Top = 165
          TabStop = False
          Properties.ReadOnly = True
          TabOrder = 5
          Width = 197
        end
        object edVENDOR_DT: TcxTextEdit
          Left = 239
          Top = 165
          TabStop = False
          Properties.ReadOnly = True
          TabOrder = 6
          Width = 257
        end
        object cbDT_FLG_BALANCE: TcxCheckBox
          Left = 384
          Top = 20
          Caption = 'Trece in cont'
          TabOrder = 1
          OnClick = rbDT_FLG_BALANCE1Click
        end
        object mmDT_DESCRIPTION: TcxDBMemo
          Left = 11
          Top = 197
          DataBinding.DataField = 'DT_DESCRIPTION'
          DataBinding.DataSource = IBCDS_IDENT
          TabOrder = 7
          Height = 75
          Width = 485
        end
        object edNR_ACT_PRIMIRE: TcxDBTextEdit
          Left = 348
          Top = 285
          DataBinding.DataField = 'NR_ACT_PRIMIRE'
          TabOrder = 8
          Width = 148
        end
        object edNR_ACT_ZACEOT: TcxDBTextEdit
          Left = 348
          Top = 314
          DataBinding.DataField = 'NR_ACT_ZACEOT'
          TabOrder = 9
          Width = 148
        end
      end
    end
    object cxPageControl3: TcxPageControl
      Left = 531
      Top = 0
      Width = 524
      Height = 385
      Align = alRight
      TabOrder = 1
      Properties.ActivePage = pnTarget
      Properties.ActivateFocusedTab = False
      Properties.CustomButtons.Buttons = <>
      Properties.NavigatorPosition = npLeftBottom
      Properties.TabsScroll = False
      ClientRectBottom = 381
      ClientRectLeft = 4
      ClientRectRight = 520
      ClientRectTop = 26
      object pnTarget: TcxTabSheet
        Caption = 'PRODUSE LA PRIMIRE'
        ImageIndex = 0
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label6: TLabel
          Left = 16
          Top = 3
          Width = 40
          Height = 15
          Caption = 'Depozit'
        end
        object Label7: TLabel
          Left = 16
          Top = 52
          Width = 37
          Height = 15
          Caption = 'Produs'
        end
        object lbIDEN_CT: TLabel
          Left = 16
          Top = 100
          Width = 141
          Height = 15
          Caption = 'Numar de serie sau partida'
        end
        object Label8: TLabel
          Left = 363
          Top = 100
          Width = 21
          Height = 15
          Caption = 'Pret'
        end
        object Label9: TLabel
          Left = 16
          Top = 148
          Width = 83
          Height = 15
          Caption = 'Tara producator'
          Transparent = True
        end
        object Label10: TLabel
          Left = 236
          Top = 148
          Width = 59
          Height = 15
          Caption = 'Producator'
          Transparent = True
        end
        object mmCT_DESCRIPTION: TcxDBMemo
          Left = 16
          Top = 206
          DataBinding.DataField = 'CT_DESCRIPTION'
          DataBinding.DataSource = IBCDS_IDENT
          TabOrder = 8
          Height = 66
          Width = 478
        end
        object beGOODS_CT: TcxButtonEdit
          Left = 16
          Top = 69
          Properties.Buttons = <
            item
              Caption = 'Alege'
              Default = True
              Kind = bkText
            end
            item
              Caption = 'Acelas produs'
              Kind = bkText
            end>
          Properties.ClickKey = 115
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beGOODS_CTPropertiesButtonClick
          TabOrder = 2
          Width = 478
        end
        object lcbCT_DEP: TcxDBLookupComboBox
          Left = 16
          Top = 20
          DataBinding.DataField = 'CT_DEP'
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 16
          Properties.KeyFieldNames = 'STOCKID'
          Properties.ListColumns = <
            item
              Fixed = True
              Width = 180
              FieldName = 'TITLE'
            end
            item
              Fixed = True
              Width = 120
              FieldName = 'PARENT_TITLE'
            end>
          Properties.ListOptions.ShowHeader = False
          Properties.ListSource = dmDB.IBCDataSourceStocks
          TabOrder = 0
          Width = 333
        end
        object edCT_IDENT: TcxDBTextEdit
          Left = 16
          Top = 117
          DataBinding.DataField = 'CT_IDENT'
          TabOrder = 3
          Width = 261
        end
        object ceCT_PRICE: TcxDBCalcEdit
          Left = 363
          Top = 117
          DataBinding.DataField = 'CT_PRICE'
          TabOrder = 5
          Width = 131
        end
        object beCountryID_CT: TcxButtonEdit
          Left = 16
          Top = 165
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
          Properties.ClickKey = 115
          Properties.ReadOnly = True
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beCountryID_CTPropertiesButtonClick
          TabOrder = 6
          Width = 197
        end
        object beVendorID_CT: TcxButtonEdit
          Left = 237
          Top = 165
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
          Properties.ClickKey = 115
          Properties.ReadOnly = True
          Properties.ViewStyle = vsHideCursor
          Properties.OnButtonClick = beVendorID_CTPropertiesButtonClick
          TabOrder = 7
          Width = 257
        end
        object cbCT_FLG_BALANCE: TcxCheckBox
          Left = 386
          Top = 20
          Caption = 'Trece in cont'
          TabOrder = 1
          OnClick = rbCT_FLG_BALANCE1Click
        end
        object cxButton1: TcxButton
          Left = 283
          Top = 117
          Width = 70
          Height = 23
          Caption = 'Genereaza'
          TabOrder = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = cxButton1Click
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 488
    Top = 8
    object ActionF6: TAction
      Caption = 'ActionF6'
      ShortCut = 117
      OnExecute = ActionF6Execute
    end
    object ActionF4: TAction
      Caption = 'ActionF4'
      ShortCut = 115
      OnExecute = ActionF4Execute
    end
  end
  object IBC_IDENT: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_JURNAL_SP_DESCRIPTIONS'
      '  (ROWID, DT_DESCRIPTION, CT_DESCRIPTION)'
      'VALUES'
      '  (:ROWID, :DT_DESCRIPTION, :CT_DESCRIPTION)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_JURNAL_SP_DESCRIPTIONS'
      'WHERE'
      '  ROWID = :Old_ROWID')
    SQLUpdate.Strings = (
      'UPDATE TDB_JURNAL_SP_DESCRIPTIONS'
      'SET'
      
        '  ROWID = :ROWID, DT_DESCRIPTION = :DT_DESCRIPTION, CT_DESCRIPTI' +
        'ON = :CT_DESCRIPTION'
      'WHERE'
      '  ROWID = :Old_ROWID')
    SQLRefresh.Strings = (
      
        'SELECT ROWID, DT_DESCRIPTION, CT_DESCRIPTION FROM TDB_JURNAL_SP_' +
        'DESCRIPTIONS'
      'WHERE'
      '  ROWID = :ROWID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL_SP_DESCRIPTIONS'
      'WHERE'
      'ROWID = :Old_ROWID'
      'FOR UPDATE WITH LOCK')
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select * from TDB_JURNAL_SP_DESCRIPTIONS')
    MasterFields = 'ROWID'
    DetailFields = 'ROWID'
    AutoCommit = False
    Left = 376
    Top = 296
  end
  object IBCDS_IDENT: TIBCDataSource
    DataSet = IBC_IDENT
    Left = 312
    Top = 296
  end
end
