object frmSerialScannerDlg: TfrmSerialScannerDlg
  Left = 0
  Top = 0
  ActiveControl = cxGridSerials
  BorderStyle = bsDialog
  Caption = 'Scanarea seriilor'
  ClientHeight = 594
  ClientWidth = 842
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  DesignSize = (
    842
    594)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 842
    Height = 64
    Title = 'Scanarea seriilor'
    Text = 'Scanarea seriilor'
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
    ImageIndex = 19
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 826
    Height = 457
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object cxGridSerials: TcxGrid
      AlignWithMargins = True
      Left = 0
      Top = 0
      Width = 267
      Height = 457
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = -5
      object cxGridSerialsTable: TcxGridTableView
        PopupMenu = pm1
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
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        DataController.OnDataChanged = cxGridSerialsTableDataControllerDataChanged
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ShowEditButtons = gsebForFocusedRecord
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
        Styles.OnGetContentStyle = cxGridSerialsTableStylesGetContentStyle
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridSerialsTable_ENABLED: TcxGridColumn
          DataBinding.ValueType = 'Boolean'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ImmediatePost = True
          Properties.OnEditValueChanged = cxGridSerialsTable_ENABLEDPropertiesEditValueChanged
          MinWidth = 30
          Options.Filtering = False
          Options.IncSearch = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          Width = 30
        end
        object cxGridSerialsTable_NO: TcxGridColumn
          Caption = 'Nr'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.Editing = False
          Options.Filtering = False
          Options.ShowEditButtons = isebNever
          Options.HorzSizing = False
          Options.Moving = False
          Width = 40
        end
        object cxGridSerialsTable_SERIAL: TcxGridColumn
          Caption = 'Serie'
          Options.Editing = False
          Options.Filtering = False
          Options.Grouping = False
          Options.Moving = False
          Styles.Content = dmAdditions.cxStyle_Bold
          Width = 200
        end
      end
      object cxGridSerialsLevel: TcxGridLevel
        GridView = cxGridSerialsTable
      end
    end
    object pnGeneralInfo: TPanel
      AlignWithMargins = True
      Left = 269
      Top = 0
      Width = 291
      Height = 457
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 1
      object cxLabel1: TLabel
        Left = 12
        Top = 21
        Width = 106
        Height = 15
        Caption = 'Garantie producator'
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 12
        Top = 50
        Width = 89
        Height = 15
        Caption = 'Garantie vinzator'
        Transparent = True
      end
      object cxLabel3: TLabel
        Left = 12
        Top = 194
        Width = 84
        Height = 15
        Caption = 'din ele selectate'
        Transparent = True
      end
      object cxLabel4: TLabel
        Left = 12
        Top = 165
        Width = 103
        Height = 15
        Caption = 'Cantitatea necesara'
        Transparent = True
      end
      object lbActionInfo: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 296
        Width = 271
        Height = 97
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        AutoSize = False
        Caption = 'Incepeti scanarea numerilor de serie'
        Transparent = True
        ExplicitLeft = 10
      end
      object lbInfo: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 409
        Width = 271
        Height = 36
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Color = 28895
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        WordWrap = True
        ExplicitTop = 413
        ExplicitWidth = 218
      end
      object Label1: TLabel
        Left = 12
        Top = 83
        Width = 83
        Height = 15
        Caption = 'Tara producator'
        Transparent = True
      end
      object Label2: TLabel
        Left = 12
        Top = 115
        Width = 59
        Height = 15
        Caption = 'Producator'
        Transparent = True
      end
      object edVendorWarranty: TcxMaskEdit
        Left = 154
        Top = 18
        Properties.MaskKind = emkRegExprEx
        Properties.EditMask = '\d+'
        Properties.MaxLength = 0
        TabOrder = 0
        Text = '0'
        OnEnter = edVendorWarrantyEnter
        OnExit = edVendorWarrantyExit
        Width = 119
      end
      object edOwnWarranty: TcxMaskEdit
        Left = 154
        Top = 47
        Properties.MaskKind = emkRegExprEx
        Properties.EditMask = '\d+'
        Properties.MaxLength = 0
        TabOrder = 1
        Text = '0'
        OnEnter = edVendorWarrantyEnter
        OnExit = edVendorWarrantyExit
        Width = 119
      end
      object edSelectionCount: TcxTextEdit
        Left = 154
        Top = 191
        TabStop = False
        Properties.ReadOnly = True
        Style.TextColor = clBlue
        Style.TextStyle = [fsBold]
        TabOrder = 5
        Text = '0'
        Width = 119
      end
      object edRequiredCount: TcxTextEdit
        Left = 154
        Top = 162
        TabStop = False
        Properties.ReadOnly = True
        Style.TextStyle = [fsBold]
        TabOrder = 4
        Text = '0'
        Width = 119
      end
      object beCountryID: TcxButtonEdit
        Left = 154
        Top = 76
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
        TabOrder = 2
        Width = 119
      end
      object beVendorID: TcxButtonEdit
        Left = 154
        Top = 106
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
        TabOrder = 3
        Width = 119
      end
    end
    object pnGenerator: TPanel
      AlignWithMargins = True
      Left = 562
      Top = 0
      Width = 264
      Height = 457
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clWindow
      ParentBackground = False
      TabOrder = 2
      object cxLabel5: TLabel
        Left = 16
        Top = 21
        Width = 95
        Height = 15
        Caption = 'Prefix numar serie'
        Transparent = True
      end
      object cxLabel6: TLabel
        Left = 16
        Top = 71
        Width = 134
        Height = 15
        Caption = 'Numarul pentru generare'
        Transparent = True
      end
      object cxLabel7: TLabel
        Left = 16
        Top = 123
        Width = 91
        Height = 15
        Caption = 'Sufix numar serie'
        Transparent = True
      end
      object cxLabel8: TLabel
        Left = 16
        Top = 179
        Width = 152
        Height = 15
        Caption = 'Cantitatea numerilor de serie'
        Transparent = True
      end
      object edSerialPrefix: TcxMaskEdit
        Left = 16
        Top = 38
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 0
        TabOrder = 0
        OnEnter = edVendorWarrantyEnter
        OnExit = edVendorWarrantyExit
        Width = 196
      end
      object edSerialStartMask: TcxMaskEdit
        Left = 16
        Top = 88
        Properties.MaskKind = emkRegExprEx
        Properties.EditMask = '\d+'
        Properties.MaxLength = 0
        Style.TextStyle = [fsBold]
        TabOrder = 1
        Text = '00001'
        OnEnter = edVendorWarrantyEnter
        OnExit = edVendorWarrantyExit
        Width = 97
      end
      object edSearialSuffix: TcxMaskEdit
        Left = 16
        Top = 140
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 0
        TabOrder = 2
        OnEnter = edVendorWarrantyEnter
        OnExit = edVendorWarrantyExit
        Width = 196
      end
      object edSerialGenerateCount: TcxMaskEdit
        Left = 16
        Top = 196
        Properties.MaskKind = emkRegExprEx
        Properties.EditMask = '\d+'
        Properties.MaxLength = 0
        Style.TextColor = clMaroon
        Style.TextStyle = [fsBold]
        TabOrder = 3
        Text = '1'
        OnEnter = edVendorWarrantyEnter
        OnExit = edVendorWarrantyExit
        Width = 97
      end
      object cbClearList: TcxCheckBox
        Left = 15
        Top = 236
        TabStop = False
        Caption = 'Curata lista'
        TabOrder = 4
      end
      object btnGenerate: TcxButton
        Left = 37
        Top = 290
        Width = 202
        Height = 29
        Caption = 'Generarea numerilor'
        TabOrder = 5
        OnClick = btnGenerateClick
      end
    end
  end
  object btnOk: TcxButton
    Left = 636
    Top = 547
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 737
    Top = 547
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object pm1: TPopupMenu
    Left = 120
    Top = 168
    object N1: TMenuItem
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1088#1072' '#1086#1073#1084#1077#1085#1072
      OnClick = N1Click
    end
  end
end
