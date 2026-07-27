object frmSerialNumberEditorDlg: TfrmSerialNumberEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Numar de serie'
  ClientHeight = 460
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    361
    460)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 361
    Height = 64
    Title = 'Numar de serie'
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
  object pnInputs: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 345
    Height = 335
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
      Left = 12
      Top = 18
      Width = 80
      Height = 15
      Caption = 'Numar de serie'
      Transparent = True
    end
    object cxLabel2: TLabel
      Left = 12
      Top = 76
      Width = 126
      Height = 15
      Caption = 'Garantia producatorului'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 12
      Top = 105
      Width = 109
      Height = 15
      Caption = 'Garantia vinzatorului'
      Transparent = True
    end
    object cxLabel4: TLabel
      Left = 12
      Top = 215
      Width = 63
      Height = 15
      Caption = 'Comentariu'
      Transparent = True
    end
    object cxLabel5: TLabel
      Left = 12
      Top = 47
      Width = 81
      Height = 15
      Caption = 'Suma pe accize'
      Transparent = True
    end
    object cxLabel6: TLabel
      Left = 252
      Top = 47
      Width = 12
      Height = 15
      Caption = 'lei'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 135
      Width = 95
      Height = 15
      Caption = 'Tara producatoare'
      Transparent = True
    end
    object Label2: TLabel
      Left = 12
      Top = 165
      Width = 59
      Height = 15
      Caption = 'Producator'
      Transparent = True
    end
    object mmCOMMENTS: TcxDBMemo
      Left = 12
      Top = 232
      DataBinding.DataField = 'COMMENTS'
      DataBinding.DataSource = IBCDataSourceSN_Comments
      Properties.ScrollBars = ssVertical
      Properties.VisibleLineCount = 5
      TabOrder = 6
      Width = 315
    end
    object edVENDORWARRANTY: TcxDBMaskEdit
      Left = 158
      Top = 73
      DataBinding.DataField = 'VENDORWARRANTY'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 2
      Width = 91
    end
    object edOWNWARRANTY: TcxDBMaskEdit
      Left = 158
      Top = 102
      DataBinding.DataField = 'OWNWARRANTY'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 3
      Width = 91
    end
    object edSN: TcxDBMaskEdit
      Left = 158
      Top = 15
      DataBinding.DataField = 'SN'
      Properties.CharCase = ecUpperCase
      TabOrder = 0
      Width = 169
    end
    object edSUMA_ACCIZE: TcxDBCurrencyEdit
      Left = 158
      Top = 44
      DataBinding.DataField = 'SUMA_ACCIZE'
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      TabOrder = 1
      Width = 91
    end
    object beCountryID: TcxButtonEdit
      Left = 158
      Top = 131
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
      TabOrder = 4
      Width = 169
    end
    object beVendorID: TcxButtonEdit
      Left = 158
      Top = 161
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
      TabOrder = 5
      Width = 169
    end
  end
  object btnOk: TcxButton
    Left = 154
    Top = 418
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 258
    Top = 418
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQuerySN_Comments: TIBCQuery
    UpdatingTable = 'TDB_SN_COMMENTS'
    SQLInsert.Strings = (
      'INSERT INTO TDB_SN_COMMENTS'
      
        '  (DOCID, DTDEP, CTDEP, GOODSCOMPLECT_ID, GOODSID, SN, COMMENTS,' +
        ' CREATED_BY)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :CTDEP, :GOODSCOMPLECT_ID, :GOODSID, :SN, :CO' +
        'MMENTS, :CREATED_BY)')
    SQLUpdate.Strings = (
      'UPDATE TDB_SN_COMMENTS'
      'SET'
      
        '  DOCID = :DOCID, DTDEP = :DTDEP, CTDEP = :CTDEP, GOODSCOMPLECT_' +
        'ID = :GOODSCOMPLECT_ID, GOODSID = :GOODSID, SN = :SN, COMMENTS =' +
        ' :COMMENTS, CREATED_BY = :CREATED_BY'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID AND SN = :Old_SN')
    SQLRefresh.Strings = (
      'SELECT '
      ' DOCID, '
      ' DTDEP, '
      ' CTDEP, '
      ' GOODSCOMPLECT_ID, '
      ' GOODSID, '
      ' SN, '
      ' COMMENTS, '
      ' CREATED_BY '
      'FROM '
      ' TDB_SN_COMMENTS'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND '
      ' CTDEP = :CTDEP AND '
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND '
      ' GOODSID = :GOODSID AND '
      ' SN = :SN')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SN_COMMENTS'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID AND SN = :Old_SN'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT '
      ' DOCID, '
      ' DTDEP, '
      ' CTDEP, '
      ' GOODSCOMPLECT_ID, '
      ' GOODSID, '
      ' SN, '
      ' COMMENTS, '
      ' CREATED_BY '
      'FROM '
      ' TDB_SN_COMMENTS')
    MasterFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN'
    DetailFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID;SN'
    AutoCommit = False
    Left = 84
    Top = 312
  end
  object IBCDataSourceSN_Comments: TIBCDataSource
    DataSet = IBCQuerySN_Comments
    Left = 228
    Top = 312
  end
end
