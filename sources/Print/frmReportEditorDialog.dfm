object frmReportEditorDlg: TfrmReportEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Raport'
  ClientHeight = 637
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  DesignSize = (
    538
    637)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 538
    Height = 64
    Title = 'Modificare sursa raport'
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
    ImageIndex = 16
  end
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 522
    Height = 509
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsGeneral
    Align = alTop
    TabOrder = 1
    object tbsGeneral: TTabSheet
      Caption = 'Informatii generale'
      object cxLabel1: TLabel
        Left = 16
        Top = 43
        Width = 87
        Height = 15
        Caption = 'Denumire raport'
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 16
        Top = 92
        Width = 48
        Height = 15
        Caption = 'Descriere'
        Transparent = True
      end
      object lbReportGroup: TLabel
        Left = 16
        Top = 368
        Width = 93
        Height = 15
        Caption = 'Grupa rapoartelor'
        Transparent = True
      end
      object lbTabSheetIndex: TLabel
        Left = 16
        Top = 423
        Width = 156
        Height = 15
        Caption = 'Numarul paginii cu parametri'
        Transparent = True
      end
      object cxLabel3: TLabel
        Left = 16
        Top = 314
        Width = 74
        Height = 15
        Caption = 'Tip document'
        Transparent = True
      end
      object lbReportChanged: TLabel
        Left = 16
        Top = 182
        Width = 131
        Height = 15
        Caption = 'Raportul a fost modificat'
        Color = clRed
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object sbCustomReportGroup: TSpeedButton
        Left = 465
        Top = 384
        Width = 23
        Height = 25
        Glyph.Data = {
          32020000424D3202000000000000320100002800000010000000100000000100
          08000000000000010000120B0000120B00003F0000003F00000000000000FFFF
          FF00FF00FF00B78E6B00AB7F56009E6E3E009D703F009C724000A8855900B296
          6F00C1AC8C00C5B39500A58D5E00B09A7000967D4600B9A88200A4957300AA98
          6A00BCB18D0092844900ADA1740091884A009F985F00ABA57600B6B18800948F
          55009A977700B1AE8A00979357008F8C4D00BAB99100A9AA78009A9D7B008C93
          4F00A6AB7600757C4300A6AE7A00B8BE9400B8C09500979E7A008A9A52007180
          430089A05400B8C6980098A57D00B6C59600A4B97D00B1C58D0087A7550099B5
          6D009EB97500A4BD7E0096A67C00B6C9970088AA560090B0630092B2660098AA
          7F00A4C17E00B5CD980086B057008DB4610086B55800020202022B2419020202
          020202020202023E3D3831321529231D130C02020202023E33333A3A1534393B
          3B2F08020202023E2E3333331334393B3B3B07020202023E2E242E331334393B
          3B3B07020202023E1F2E242E13342C3B3B3B06020202023E1F1F242E0E342C2D
          2D3B06020202023E171F1F2E0E272C2D2D3506020202023E14171F180E272C2D
          2D2D06020202023C1414171E0E27202D2D2D06020202023C090D141E07272025
          262D06020202023C09090D0B0E1A2025252606020202023C0309090B07202025
          252506020202023C03030A0F07201B1E252505020202023C16221C111012121E
          1E120402020202373736302A28211513070802020202}
        OnClick = sbCustomReportGroupClick
      end
      object Label5: TLabel
        Left = 440
        Top = 39
        Width = 39
        Height = 15
        Caption = 'Nr. Ord'
        Transparent = True
      end
      object edTITLE: TcxDBTextEdit
        Left = 16
        Top = 60
        DataBinding.DataField = 'TITLE'
        TabOrder = 0
        Width = 418
      end
      object mmDESCRIPTION: TcxDBMemo
        Left = 16
        Top = 109
        DataBinding.DataField = 'DESCRIPTION'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 3
        TabOrder = 2
        Width = 472
      end
      object lcbREPORTGROUP: TcxDBLookupComboBox
        Left = 16
        Top = 385
        DataBinding.DataField = 'REPORTGROUP'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'REPORTGROUPID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceReportGroup
        TabOrder = 5
        Width = 445
      end
      object lcbTabSheetIndex: TcxDBLookupComboBox
        Left = 16
        Top = 440
        DataBinding.DataField = 'TABSHEETINDEX'
        Properties.DropDownListStyle = lsFixedList
        Properties.KeyFieldNames = 'TABSHEETINDEX'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceTabSheetIndex
        TabOrder = 7
        Width = 445
      end
      object beDocType: TcxButtonEdit
        Left = 16
        Top = 331
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
        Properties.OnButtonClick = beDocTypePropertiesButtonClick
        TabOrder = 4
        Text = 'beDocType'
        Width = 472
      end
      object gbFlags: TGroupBox
        Left = 16
        Top = 196
        Width = 472
        Height = 89
        Caption = 'Starile raportului'
        TabOrder = 3
        object cbFLG_DISABLED: TcxDBCheckBox
          Left = 12
          Top = 26
          Caption = 'Raport blocat'
          DataBinding.DataField = 'FLG_DISABLED'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 0
        end
        object cbFLG_NO_DIRECT_PRINT: TcxDBCheckBox
          Left = 12
          Top = 55
          Caption = 'Tipar raport din doar din codul programei'
          DataBinding.DataField = 'FLG_NO_DIRECT_PRINT'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 2
        end
        object cbFLG_QUICK_ACCESS: TcxDBCheckBox
          Left = 247
          Top = 26
          Caption = 'Raportul este disponibil din meniu'
          DataBinding.DataField = 'FLG_QUICK_ACCESS'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 1
        end
      end
      object dxBarDockControl1: TdxBarDockControl
        Left = 0
        Top = 0
        Width = 514
        Height = 30
        Align = dalTop
        BarManager = dxBarManager
        SunkenBorder = True
        UseOwnSunkenBorder = True
      end
      object teOrderno: TcxDBTextEdit
        Left = 440
        Top = 60
        DataBinding.DataField = 'ORDERNO'
        TabOrder = 1
        Width = 48
      end
    end
    object tbsAccess: TTabSheet
      Caption = 'Grupe acces utilizatori'
      ImageIndex = 1
      object cxLabel14: TLabel
        Left = 15
        Top = 3
        Width = 214
        Height = 29
        AutoSize = False
        Caption = 'Raportul este disponibil pentru urmatoarele grupe'
        Transparent = True
        WordWrap = True
      end
      object cxLabel15: TLabel
        Left = 284
        Top = 17
        Width = 100
        Height = 15
        Caption = 'Grupe de utilizatori'
        Transparent = True
      end
      object cxGridUserGroups: TcxGrid
        Left = 12
        Top = 38
        Width = 217
        Height = 395
        TabOrder = 0
        object cxGridUserGroupsTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridUserGroupsTableCellDblClick
          OnSelectionChanged = cxGridUserGroupsTableSelectionChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridUserGroups_IMAGE: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 15
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridUserGroups_TITLE: TcxGridColumn
          end
          object cxGridUserGroups_GROUPID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
          end
        end
        object cxGridUserGroupsLevel: TcxGridLevel
          GridView = cxGridUserGroupsTable
        end
      end
      object cxGridAvailableUserGroups: TcxGrid
        Left = 284
        Top = 38
        Width = 217
        Height = 395
        TabOrder = 1
        object cxGridAUGTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridAUGTableCellDblClick
          OnSelectionChanged = cxGridAUGTableSelectionChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridAUG_IMAGE: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 15
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridAUG_TITLE: TcxGridColumn
          end
          object cxGridAUG_GROUPID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
            SortIndex = 0
            SortOrder = soAscending
          end
        end
        object cxGridAUGLevel: TcxGridLevel
          GridView = cxGridAUGTable
        end
      end
      object btnAddUserGroup: TcxButton
        Left = 241
        Top = 160
        Width = 33
        Height = 29
        Caption = '<'
        TabOrder = 2
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnAddUserGroupClick
      end
      object btnRemoveUserGroup: TcxButton
        Left = 241
        Top = 195
        Width = 33
        Height = 29
        Caption = '>'
        TabOrder = 3
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnRemoveUserGroupClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Acces la subdiviziuni'
      ImageIndex = 2
      object Label3: TLabel
        Left = 12
        Top = 3
        Width = 217
        Height = 30
        AutoSize = False
        Caption = 'Raportul este dispobil pentru urmatoarele subdiviziuni'
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 284
        Top = 18
        Width = 125
        Height = 15
        Caption = 'Subdiviziuni disponibile'
        Transparent = True
      end
      object cxGridSelFirms: TcxGrid
        Left = 12
        Top = 39
        Width = 217
        Height = 394
        TabOrder = 0
        object cxGridSelFirmsTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridSelFirmsTableCellDblClick
          OnSelectionChanged = cxGridAvFirmsTableSelectionChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridSelFirms_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridSelFirms_TITLE: TcxGridColumn
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxGridSelFirms_ID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
          end
        end
        object cxGridSelFirmsLevel: TcxGridLevel
          GridView = cxGridSelFirmsTable
        end
      end
      object cxGridAvFirms: TcxGrid
        Left = 284
        Top = 39
        Width = 217
        Height = 394
        TabOrder = 1
        object cxGridAvFirmsTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridAvFirmsTableCellDblClick
          OnSelectionChanged = cxGridAvFirmsTableSelectionChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GridLines = glNone
          OptionsView.GroupByBox = False
          OptionsView.Header = False
          Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
          object cxGridAvFirms_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridAvFirms_TITLE: TcxGridColumn
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxGridAvFirms_ID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
          end
        end
        object cxGridAvFirmsLevel: TcxGridLevel
          GridView = cxGridAvFirmsTable
        end
      end
      object btnAddFirms: TcxButton
        Left = 240
        Top = 160
        Width = 33
        Height = 29
        Caption = '<'
        TabOrder = 2
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnAddFirmsClick
      end
      object btnRemoveFirms: TcxButton
        Left = 240
        Top = 195
        Width = 33
        Height = 29
        Caption = '>'
        TabOrder = 3
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnRemoveFirmsClick
      end
    end
  end
  object btnOk: TcxButton
    Left = 323
    Top = 591
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnClose: TcxButton
    Left = 427
    Top = 591
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Anuleaza'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryReportGroup: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' REPORTGROUPID,'
      ' TITLE'
      'FROM'
      ' TS_REPORT_GROUPS'
      'ORDER BY ORDERNO')
    Left = 64
    Top = 592
  end
  object IBCDataSourceReportGroup: TIBCDataSource
    DataSet = IBCQueryReportGroup
    Left = 68
    Top = 544
  end
  object IBCDataSourceTabSheetIndex: TIBCDataSource
    DataSet = IBCQueryTabSheetIndex
    Left = 228
    Top = 544
  end
  object IBCQueryTabSheetIndex: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      
        'select 0 AS TABSHEETINDEX, '#39#1041#1077#1079' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074#39' AS TITLE from rdb$da' +
        'tabase'
      'union all'
      'select 1 AS TABSHEETINDEX, '#39#1062#1077#1085#1085#1080#1082#1080#39' AS TITLE from rdb$database'
      'union all'
      'select 2 AS TABSHEETINDEX, '#39#1055#1077#1088#1089#1086#1085#1072#1083#39' AS TITLE from rdb$database')
    Left = 228
    Top = 592
  end
  object frxDesigner: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    OnSaveReport = frxDesignerSaveReport
    Left = 32
    Top = 240
  end
  object frxReport: TfrxReport
    Version = '2023.2'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick, pbNoFullScreen, pbNoEmail]
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39778.543130914360000000
    ReportOptions.LastChange = 39778.543130914360000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    Left = 32
    Top = 136
  end
  object frxRichObject1: TfrxRichObject
    Left = 32
    Top = 292
  end
  object frxCheckBoxObject1: TfrxCheckBoxObject
    Left = 32
    Top = 352
  end
  object frxDialogControls1: TfrxDialogControls
    Left = 224
    Top = 304
  end
  object fsPascal: TfsPascal
    Left = 212
    Top = 248
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
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 164
    Top = 8
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 562
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Modifica raportul (F4)'
      Category = 0
      Hint = 'Modifica raportul (F4)'
      Visible = ivAlways
      ImageIndex = 41
      ShortCut = 115
      OnClick = dxBarButton1Click
    end
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 140
    Top = 188
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 144
    Top = 132
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 32
    Top = 408
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EmbeddedFonts = True
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = True
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 80
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = True
    CenterWindow = True
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv17
    Left = 144
    Top = 232
  end
  object frxMailExport1: TfrxMailExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ShowExportDialog = True
    FromCompany = 'Fantastic.MD'
    SmtpHost = 'mail.fantastic.md'
    SmtpPort = 25
    UseIniFile = True
    TimeOut = 60
    ConfurmReading = False
    UseMAPI = SMTP
    MAPISendFlag = 0
    Left = 152
    Top = 296
  end
  object frxReportTableObject1: TfrxReportTableObject
    Left = 140
    Top = 354
  end
  object frxReportCellularTextObject1: TfrxReportCellularTextObject
    Left = 140
    Top = 418
  end
  object frxGaugeObject1: TfrxGaugeObject
    Left = 212
    Top = 186
  end
  object frxXMLExport1: TfrxXMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Background = True
    Creator = 'FastReport'
    EmptyLines = True
    SuppressPageHeadersFooters = False
    RowsCount = 0
    Split = ssNotSplit
    Left = 396
    Top = 234
  end
  object frxBIFFExport1: TfrxBIFFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    RowHeightScale = 1.000000000000000000
    ChunkSize = 0
    Inaccuracy = 10.000000000000000000
    FitPages = False
    Pictures = True
    ParallelPages = 0
    Left = 508
    Top = 258
  end
  object frxHTML5DivExport1: TfrxHTML5DivExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    MultiPage = False
    Formatted = False
    PictureFormat = pfPNG
    UnifiedPictures = True
    Navigation = True
    EmbeddedPictures = True
    EmbeddedCSS = True
    Outline = False
    HTML5 = True
    AllPictures = False
    ExportAnchors = True
    PictureTag = 0
    Left = 508
    Top = 322
  end
  object frxDOCXExport1: TfrxDOCXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    PictureType = gpPNG
    ExportType = dxTable
    Left = 484
    Top = 402
  end
  object frxSimpleTextExport1: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    UTF8 = False
    OpenAfterExport = False
    DeleteEmptyColumns = True
    Left = 500
    Top = 474
  end
  object frxIBDACComponents1: TfrxIBDACComponents
    DefaultDatabase = dmDB.IBCConnection
    Left = 312
    Top = 128
  end
end
