object frmDocTypeDefaultsDlg: TfrmDocTypeDefaultsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
  ClientHeight = 612
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    728
    612)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 728
    Height = 64
    Title = #1047#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    Text = #1059#1082#1072#1078#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '#1076#1083#1103' '#1076#1072#1085#1085#1086#1075#1086' '#1090#1080#1087#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
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
    ImageIndex = 11
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 712
    Height = 480
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
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 81
      Height = 15
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object Label10: TLabel
      Left = 360
      Top = 16
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object edDocType: TEdit
      Left = 16
      Top = 33
      Width = 329
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 0
    end
    object gbDT: TGroupBox
      Left = 16
      Top = 252
      Width = 329
      Height = 205
      Caption = ' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '
      TabOrder = 3
      object Label4: TLabel
        Left = 12
        Top = 28
        Width = 72
        Height = 15
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      end
      object Label6: TLabel
        Left = 12
        Top = 84
        Width = 33
        Height = 15
        Caption = #1057#1082#1083#1072#1076
      end
      object Label7: TLabel
        Left = 12
        Top = 140
        Width = 59
        Height = 15
        Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072
      end
      object sbClearDT: TSpeedButton
        Left = 299
        Top = 44
        Width = 25
        Height = 25
        Glyph.Data = {
          CE010000424DCE01000000000000CE0000002800000010000000100000000100
          08000000000000010000120B0000120B0000260000002600000000000000FFFF
          FF002900DF002B05D6002C06D7002E07D8002F08D900300ADB00350EDF00360F
          E0003610E1003312C700411DE0003D1CD200431FE2004D2CE100472BC4003F28
          A6005F40E700593DD6005137C3005238C3005A46B600795FEA007A60EB006250
          B200534E6A003917CC003A18CD004A28DD004629C3006A628C0053505E00FF00
          FF006E6E6E0065656500646464005F5F5F002121212121212121212121212121
          2121212122222121212121212121212121212117021123212121212121211905
          2121211702071A2321212121211E02162121212117020D25212121211C051621
          21212121211802152421211C05162121212121212121180214200B0416212121
          21212121212121170204031F2121212121212121212121210602101F21212121
          212121212121211C051609131F2121212121212121211C021621210E1D1F2121
          21212121211B02162121212112081F21212121211B0216212121212121120221
          2121210C021E212121212121212121212121210A0F2121212121212121212121
          212121212121212121212121212121212121}
        OnClick = sbClearDTClick
      end
      object beDT_NAME: TcxButtonEdit
        Left = 12
        Top = 45
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
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = beDT_NAMEPropertiesButtonClick
        TabOrder = 0
        Text = 'beDT_NAME'
        Width = 285
      end
      object lcbDTDEP: TcxDBLookupComboBox
        Left = 12
        Top = 101
        DataBinding.DataField = 'DTDEP'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.ClearKey = 46
        Properties.DropDownAutoSize = True
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
        TabOrder = 1
        Width = 285
      end
      object lcbDTSC: TcxDBLookupComboBox
        Left = 12
        Top = 157
        DataBinding.DataField = 'DTSC'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.ClearKey = 46
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceAnalitica
        TabOrder = 2
        Width = 205
      end
    end
    object gbCT: TGroupBox
      Left = 360
      Top = 252
      Width = 329
      Height = 205
      Caption = ' '#1055#1086#1089#1090#1072#1074#1097#1080#1082' '
      TabOrder = 4
      object Label5: TLabel
        Left = 12
        Top = 28
        Width = 63
        Height = 15
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      end
      object Label8: TLabel
        Left = 12
        Top = 84
        Width = 33
        Height = 15
        Caption = #1057#1082#1083#1072#1076
      end
      object sbClearCT: TSpeedButton
        Left = 299
        Top = 44
        Width = 25
        Height = 25
        Glyph.Data = {
          CE010000424DCE01000000000000CE0000002800000010000000100000000100
          08000000000000010000120B0000120B0000260000002600000000000000FFFF
          FF002900DF002B05D6002C06D7002E07D8002F08D900300ADB00350EDF00360F
          E0003610E1003312C700411DE0003D1CD200431FE2004D2CE100472BC4003F28
          A6005F40E700593DD6005137C3005238C3005A46B600795FEA007A60EB006250
          B200534E6A003917CC003A18CD004A28DD004629C3006A628C0053505E00FF00
          FF006E6E6E0065656500646464005F5F5F002121212121212121212121212121
          2121212122222121212121212121212121212117021123212121212121211905
          2121211702071A2321212121211E02162121212117020D25212121211C051621
          21212121211802152421211C05162121212121212121180214200B0416212121
          21212121212121170204031F2121212121212121212121210602101F21212121
          212121212121211C051609131F2121212121212121211C021621210E1D1F2121
          21212121211B02162121212112081F21212121211B0216212121212121120221
          2121210C021E212121212121212121212121210A0F2121212121212121212121
          212121212121212121212121212121212121}
        OnClick = sbClearCTClick
      end
      object beCT_NAME: TcxButtonEdit
        Left = 12
        Top = 45
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
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = beCT_NAMEPropertiesButtonClick
        TabOrder = 0
        Text = 'beDT_NAME'
        Width = 285
      end
      object lcbCTDEP: TcxDBLookupComboBox
        Left = 12
        Top = 101
        DataBinding.DataField = 'CTDEP'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.ClearKey = 46
        Properties.DropDownAutoSize = True
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
        TabOrder = 1
        Width = 285
      end
    end
    object gbGeneral: TGroupBox
      Left = 16
      Top = 84
      Width = 673
      Height = 145
      Caption = #1054#1073#1097#1080#1077
      TabOrder = 2
      object Label2: TLabel
        Left = 12
        Top = 24
        Width = 120
        Height = 15
        Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      end
      object Label3: TLabel
        Left = 344
        Top = 24
        Width = 41
        Height = 15
        Caption = #1042#1072#1083#1102#1090#1072
      end
      object lcbSC: TcxDBLookupComboBox
        Left = 12
        Top = 41
        DataBinding.DataField = 'SC'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.ClearKey = 46
        Properties.DropDownAutoSize = True
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'ANALITICAID'
        Properties.ListColumns = <
          item
            Fixed = True
            Width = 180
            FieldName = 'TITLE'
          end
          item
            Fixed = True
            Width = 180
            FieldName = 'PARENT_TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceAnalytics
        TabOrder = 0
        Width = 285
      end
      object lcbCURRENCYID: TcxDBLookupComboBox
        Left = 344
        Top = 41
        DataBinding.DataField = 'CURRENCYID'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.ClearKey = 46
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceCurrency
        TabOrder = 1
        Width = 161
      end
      object cxDBCheckBox1: TcxDBCheckBox
        Left = 12
        Top = 88
        Caption = #1041#1091#1093#1075#1072#1083#1090#1077#1088#1080#1103
        DataBinding.DataField = 'FLG_ACNT'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 2
      end
      object cxDBCheckBox2: TcxDBCheckBox
        Left = 123
        Top = 88
        Caption = #1047#1072#1087#1088#1077#1090#1080#1090#1100' '#1080#1079#1084#1077#1085#1103#1090#1100' '#1041#1091#1093#1075#1072#1083#1090#1077#1088#1080#1102
        DataBinding.DataField = 'FLG_ACNT_DISABLED'
        DataBinding.DataSource = IBCDataSourceDefaults
        Properties.Alignment = taLeftJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 3
      end
    end
    object edFirma: TEdit
      Left = 360
      Top = 33
      Width = 329
      Height = 23
      TabStop = False
      ReadOnly = True
      TabOrder = 1
    end
  end
  object btnOk: TcxButton
    Left = 517
    Top = 568
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 621
    Top = 568
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDefaults: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_DOCTYPES_DEFVALUES'
      
        '  (DOCTYPEID, FIRMA, DT, DTDEP, DTSC, CT, CTDEP, SC, CURRENCYID,' +
        ' FIRMA_PREFIX, FLG_ACNT, FLG_ACNT_DISABLED)'
      'VALUES'
      
        '  (:DOCTYPEID, :FIRMA, :DT, :DTDEP, :DTSC, :CT, :CTDEP, :SC, :CU' +
        'RRENCYID, :FIRMA_PREFIX, :FLG_ACNT, :FLG_ACNT_DISABLED)')
    SQLUpdate.Strings = (
      'UPDATE TS_DOCTYPES_DEFVALUES'
      'SET'
      
        '  DT = :DT, DTDEP = :DTDEP, DTSC = :DTSC, CT = :CT, CTDEP = :CTD' +
        'EP, '
      
        '  SC = :SC, CURRENCYID = :CURRENCYID, FIRMA_PREFIX = :FIRMA_PREF' +
        'IX,'
      '  FLG_ACNT = :FLG_ACNT,'
      '  FLG_ACNT_DISABLED = :FLG_ACNT_DISABLED'
      'WHERE'
      '  DOCTYPEID = :Old_DOCTYPEID AND FIRMA = :Old_FIRMA')
    SQLRefresh.Strings = (
      'SELECT '
      
        ' DOCTYPEID, FIRMA, DT, DTDEP, DTSC, CT, CTDEP, SC, CURRENCYID, F' +
        'IRMA_PREFIX,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=DT) DT_NA' +
        'ME,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=CT) CT_NA' +
        'ME'
      'FROM '
      ' TS_DOCTYPES_DEFVALUES'
      'WHERE'
      ' DOCTYPEID = :DOCTYPEID '
      ' AND '
      ' FIRMA = :FIRMA')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_DOCTYPES_DEFVALUES'
      'WHERE'
      'DOCTYPEID = :Old_DOCTYPEID AND FIRMA = :Old_FIRMA'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT'
      
        ' DOCTYPEID, FIRMA, DT, DTDEP, DTSC, CT, CTDEP, SC, CURRENCYID, F' +
        'IRMA_PREFIX, '
      ' FLG_ACNT, FLG_ACNT_DISABLED,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=DT) DT_NA' +
        'ME,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE CUSTOMERID=CT) CT_NA' +
        'ME'
      'FROM'
      ' TS_DOCTYPES_DEFVALUES'
      'WHERE '
      ' DOCTYPEID = :doctype '
      ' AND '
      ' FIRMA = :firma')
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Left = 560
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'doctype'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'firma'
        Value = nil
      end>
  end
  object IBCDataSourceDefaults: TIBCDataSource
    DataSet = IBCQueryDefaults
    Left = 560
    Top = 20
  end
end
