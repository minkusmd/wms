object frmPartNumberEditorDlg: TfrmPartNumberEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Loturi'
  ClientHeight = 498
  ClientWidth = 461
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    461
    498)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 461
    Height = 64
    Title = 'Loturi'
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
    ImageIndex = 17
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 445
    Height = 370
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 20
      Top = 22
      Width = 77
      Height = 15
      Caption = 'Numar lot'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 20
      Top = 109
      Width = 106
      Height = 15
      Caption = 'Garantie producator'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 20
      Top = 138
      Width = 89
      Height = 15
      Caption = 'Garantie vanzator'
      Transparent = True
    end
    object cxLabel4: TLabel
      Left = 20
      Top = 288
      Width = 3
      Height = 15
      Caption = ' '
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 20
      Top = 80
      Width = 48
      Height = 15
      Caption = 'Cantitate'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 20
      Top = 51
      Width = 67
      Height = 15
      Caption = 'Suma accizelor'
      Transparent = True
    end
    object cxLabel7: TLabel
      Left = 256
      Top = 51
      Width = 20
      Height = 15
      Caption = 'lei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      Left = 20
      Top = 168
      Width = 78
      Height = 15
      Caption = 'Tara de origine'
      Transparent = True
    end
    object Label2: TLabel
      Left = 20
      Top = 198
      Width = 59
      Height = 15
      Caption = 'Producator'
      Transparent = True
    end
    object Label3: TLabel
      Left = 20
      Top = 227
      Width = 63
      Height = 15
      Caption = 'Valabil pina la'
      Transparent = True
    end
    object sbCreateValidUntilDate: TSpeedButton
      Left = 291
      Top = 224
      Width = 126
      Height = 23
      Caption = 'garantie vanzator'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbCreateValidUntilDateClick
    end
    object lbValidUntilInfo: TLabel
      Left = 162
      Top = 247
      Width = 3
      Height = 15
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 14
      Top = 268
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourcePARTS_Comments
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 8
      Width = 403
    end
    object edVENDORWARRANTY: TcxDBMaskEdit
      Left = 162
      Top = 106
      DataBinding.DataField = 'VENDORWARRANTY'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 3
      Width = 91
    end
    object edOWNWARRANTY: TcxDBMaskEdit
      Left = 162
      Top = 135
      DataBinding.DataField = 'OWNWARRANTY'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 4
      Width = 91
    end
    object edPARTNO: TcxDBMaskEdit
      Left = 162
      Top = 19
      DataBinding.DataField = 'PARTNO'
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 254
    end
    object edSUMA_ACCIZE: TcxDBCurrencyEdit
      Left = 162
      Top = 48
      DataBinding.DataField = 'SUMA_ACCIZE'
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      TabOrder = 1
      Width = 91
    end
    object beCountryID: TcxButtonEdit
      Left = 162
      Top = 164
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
      Properties.OnButtonClick = beCountryIDPropertiesButtonClick
      TabOrder = 5
      Width = 255
    end
    object beVendorID: TcxButtonEdit
      Left = 162
      Top = 194
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
      Properties.OnButtonClick = beVendorIDPropertiesButtonClick
      TabOrder = 6
      Width = 255
    end
    object deVALID_UNTIL_DATE: TcxDBDateEdit
      Left = 162
      Top = 224
      DataBinding.DataField = 'VALID_UNTIL_DATE'
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 7
      Width = 123
    end
    object edQTY: TcxDBCalcEdit
      Left = 162
      Top = 77
      DataBinding.DataField = 'QTY'
      Properties.Alignment.Horz = taLeftJustify
      TabOrder = 2
      Width = 91
    end
  end
  object btnOk: TcxButton
    Left = 240
    Top = 455
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object btnCancel: TcxButton
    Left = 336
    Top = 453
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 2
  end
  object IBCDataSourcePARTS_Comments: TIBCDataSource
    DataSet = IBCQueryPARTS_Comments
    Left = 352
    Top = 364
  end
  object IBCQueryPARTS_Comments: TIBCQuery
    UpdatingTable = 'TDB_PARTS_COMMENTS'
    SQLInsert.Strings = (
      'INSERT INTO TDB_PARTS_COMMENTS'
      '  (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, PARTNO, COMPL' +
      'ECT_SN, COMMENTS, CREATED_BY)'
      'VALUES'
      '  (:DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :PARTNO,' +
      ' :COMPLECT_SN, :COMMENTS, :CREATED_BY)')
    SQLUpdate.Strings = (
      'UPDATE TDB_PARTS_COMMENTS'
      'SET'
      '  DOCID = :DOCID, DTDEP = :DTDEP, CTDEP = :CTDEP, GOODSCOMPLECT_' +
      'ID = :GOODSCOMPLECT_ID, GOODSID = :GOODSID, PARTNO = :PARTNO, CO' +
      'MPLECT_SN = :COMPLECT_SN, COMMENTS = :COMMENTS, CREATED_BY = :CR' +
      'EATED_BY'
      'WHERE'
      '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
      'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
      'ld_GOODSID AND PARTNO = :Old_PARTNO AND COMPLECT_SN = :Old_COMPL' +
      'ECT_SN')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' DOCID, '
      ' DTDEP, '
      ' CTDEP, '
      ' GOODSCOMPLECT_ID, '
      ' GOODSID, '
      ' PARTNO, '
      ' COMPLECT_SN,'
      ' COMMENTS, '
      ' CREATED_BY '
      'FROM '
      ' TDB_PARTS_COMMENTS')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;PARTNO;COMPLECT_SN'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;PARTNO;COMPLECT_SN'
    AutoCommit = False
    Left = 352
    Top = 420
  end
end

