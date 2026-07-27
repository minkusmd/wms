object frmUserSettingsDialog: TfrmUserSettingsDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  ClientHeight = 648
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    779
    648)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 779
    Height = 64
    Title = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
    Text = #1054#1087#1080#1096#1080#1090#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080' '#1077#1075#1086' '#1091#1088#1086#1074#1085#1080' '#1076#1086#1089#1090#1091#1087#1072
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
    ImageIndex = 13
  end
  object pcPageControl: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 100
    Width = 763
    Height = 500
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Properties.ActivePage = tbsGeneral
    Properties.CustomButtons.Buttons = <>
    OnChange = pcPageControlChange
    ClientRectBottom = 496
    ClientRectLeft = 4
    ClientRectRight = 759
    ClientRectTop = 26
    object tbsGeneral: TcxTabSheet
      Caption = 'Generale'
      ImageIndex = 0
      DesignSize = (
        755
        470)
      object cxLabel1: TLabel
        Left = 336
        Top = 17
        Width = 57
        Height = 15
        Caption = 'Prenumele'
        Transparent = True
      end
      object cxLabel2: TLabel
        Left = 196
        Top = 17
        Width = 42
        Height = 15
        Caption = 'Numele'
        Transparent = True
      end
      object cxLabel5: TLabel
        Left = 196
        Top = 130
        Width = 39
        Height = 15
        Caption = 'Telefon'
        Transparent = True
      end
      object cxLabel6: TLabel
        Left = 480
        Top = 17
        Width = 34
        Height = 15
        Caption = 'E-Mail'
        Transparent = True
      end
      object cxLabel9: TLabel
        Left = 336
        Top = 130
        Width = 65
        Height = 15
        Caption = 'Data nasterii'
        Transparent = True
      end
      object cxLabel8: TLabel
        Left = 196
        Top = 182
        Width = 24
        Height = 15
        Caption = 'Oras'
        Transparent = True
      end
      object cxLabel7: TLabel
        Left = 328
        Top = 177
        Width = 36
        Height = 15
        Caption = 'Adresa'
        Transparent = True
      end
      object Label4: TLabel
        Left = 28
        Top = 155
        Width = 88
        Height = 13
        Caption = 'JPEG, 3x4, 300dpi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 200
        Top = 74
        Width = 24
        Height = 15
        Caption = 'idno'
        Transparent = True
      end
      object Label8: TLabel
        Left = 352
        Top = 74
        Width = 53
        Height = 15
        Caption = 'Buletin Nr'
        Transparent = True
      end
      object Label9: TLabel
        Left = 472
        Top = 70
        Width = 51
        Height = 15
        Caption = 'Eliberat la'
        Transparent = True
      end
      object edUserFirstName: TcxDBTextEdit
        Left = 336
        Top = 34
        DataBinding.DataField = 'FIRST_NAME'
        Style.TextStyle = []
        TabOrder = 2
        Width = 125
      end
      object edUserLastName: TcxDBTextEdit
        Left = 196
        Top = 34
        DataBinding.DataField = 'LAST_NAME'
        Style.HotTrack = True
        Style.TextStyle = []
        TabOrder = 1
        Width = 125
      end
      object edUserTelefon: TcxDBTextEdit
        Left = 196
        Top = 147
        DataBinding.DataField = 'TELEFON'
        TabOrder = 4
        Width = 125
      end
      object edUserEMail: TcxDBTextEdit
        Left = 480
        Top = 34
        DataBinding.DataField = 'EMAIL'
        TabOrder = 3
        Width = 169
      end
      object deUserBirthDay: TcxDBDateEdit
        Left = 336
        Top = 147
        DataBinding.DataField = 'BIRTHDAY'
        Properties.ImmediatePost = True
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 5
        Width = 125
      end
      object mmUserAddress: TcxDBMemo
        Left = 328
        Top = 198
        DataBinding.DataField = 'ADDRESS'
        Properties.ScrollBars = ssVertical
        Properties.VisibleLineCount = 1
        TabOrder = 6
        Width = 269
      end
      object imgUserIMAGE: TcxDBImage
        Left = 10
        Top = 17
        DataBinding.DataField = 'IMAGE'
        DataBinding.DataSource = IBCDataSourceImage
        Properties.Caption = #1053#1077#1090' '#1092#1086#1090#1086
        Properties.FitMode = ifmProportionalStretch
        Properties.GraphicClassName = 'TdxSmartImage'
        Properties.ImmediatePost = True
        Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiDelete, pmiLoad, pmiWebCam, pmiSave]
        Properties.ShowFocusRect = False
        Style.TextColor = clGrayText
        TabOrder = 0
        Height = 132
        Width = 116
      end
      object cmbUserCity: TcxDBLookupComboBox
        Left = 196
        Top = 199
        DataBinding.DataField = 'CITY_ID'
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.GridMode = True
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CITYID'
        Properties.ListColumns = <
          item
            Caption = #1043#1086#1088#1086#1076
            Fixed = True
            Width = 100
            FieldName = 'TITLE'
          end
          item
            Caption = #1056#1072#1081#1086#1085
            Width = 100
            FieldName = 'DISTRICT_TITLE'
          end>
        Properties.ListSource = IBCDataSourceCities
        TabOrder = 7
        Width = 125
      end
      object cxPageControl1: TcxPageControl
        Left = 3
        Top = 232
        Width = 749
        Height = 235
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 8
        Properties.ActivePage = tsPersonalData
        Properties.CustomButtons.Buttons = <>
        ClientRectBottom = 231
        ClientRectLeft = 4
        ClientRectRight = 745
        ClientRectTop = 26
        object cxTabSheet1: TcxTabSheet
          Caption = 'Modalitati de comunicare'
          ImageIndex = 0
          object cxGridCom: TcxGrid
            AlignWithMargins = True
            Left = 3
            Top = 31
            Width = 735
            Height = 171
            Align = alClient
            TabOrder = 1
            ExplicitHeight = 168
            object cxGridComunications: TcxGridDBTableView
              OptionsView.GroupByBox = False
              object cxGridComunicationsColumn1: TcxGridDBColumn
                Caption = 'Angajat'
                HeaderAlignmentHorz = taCenter
                Width = 253
              end
              object cxGridComunicationsColumn2: TcxGridDBColumn
                Caption = 'Tip comunicare'
                HeaderAlignmentHorz = taCenter
                Width = 176
              end
              object cxGridComunicationsColumn3: TcxGridDBColumn
                Caption = 'Valoarea'
                HeaderAlignmentHorz = taCenter
                Width = 281
              end
            end
            object cxGridComLevel1: TcxGridLevel
              GridView = cxGridComunications
            end
          end
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 741
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object cxTabSheet3: TcxTabSheet
          Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1103' '#1085#1072' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
          ImageIndex = 1
          object Label5: TLabel
            Left = 3
            Top = 36
            Width = 220
            Height = 15
            Caption = 'Perioadele de lucru in diferite subdiviziuni'
          end
          object dxBarDockControl1: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 741
            Height = 30
            Align = dalTop
            BarManager = dxBarManager1
            SunkenBorder = True
            UseOwnSunkenBorder = True
          end
          object cxGridPlaces: TcxGrid
            Left = 0
            Top = 57
            Width = 649
            Height = 145
            TabOrder = 1
            object cxGridPlacesTable: TcxGridDBTableView
              OnFocusedRecordChanged = cxGridPlacesTableFocusedRecordChanged
              DataController.DataSource = IBCDataSourcePeriods
              OptionsCustomize.ColumnFiltering = False
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsSelection.CellSelect = False
              OptionsView.CellEndEllipsis = True
              OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
              OptionsView.ColumnAutoWidth = True
              OptionsView.GridLineColor = 13750737
              OptionsView.GroupByBox = False
              Styles.Header = dmAdditions.cxStyle_GridHeader
              Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
              object cxGridPlaces_START_DATE: TcxGridDBColumn
                Caption = 'Inceput'
                DataBinding.FieldName = 'START_DATE'
                MinWidth = 100
                Options.HorzSizing = False
                SortIndex = 1
                SortOrder = soDescending
                Width = 100
              end
              object cxGridPlaces_END_DATE: TcxGridDBColumn
                Caption = 'Sfirsit'
                DataBinding.FieldName = 'END_DATE'
                MinWidth = 100
                Options.HorzSizing = False
                SortIndex = 0
                SortOrder = soDescending
                Width = 100
              end
              object cxGridPlaces_DISPLAYNAME: TcxGridDBColumn
                Caption = 'Subdiviziune'
                DataBinding.FieldName = 'DISPLAYNAME'
              end
            end
            object cxGridPlacesLevel: TcxGridLevel
              GridView = cxGridPlacesTable
            end
          end
        end
        object tsPhones: TcxTabSheet
          Caption = #1058#1077#1083#1077#1092#1086#1085#1099' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
          ImageIndex = 2
          object dxBarDockControl3: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 741
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object tsPersonalData: TcxTabSheet
          Caption = 'Date personale'
          ImageIndex = 3
          object dxBarDockControl4: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 741
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
          object cxGrid2: TcxGrid
            AlignWithMargins = True
            Left = 3
            Top = 31
            Width = 735
            Height = 171
            Align = alClient
            TabOrder = 1
            object cxGridDP: TcxGridDBTableView
              OptionsView.GroupByBox = False
              object cxGridDP_TIPDOCUMENT: TcxGridDBColumn
                Caption = 'Tip document'
                Width = 200
              end
              object cxGridDP_NUMAR_DOCUMENT: TcxGridDBColumn
                Caption = 'Numar document'
                Width = 150
              end
              object cxGridDP_DATA_ELIBERARII: TcxGridDBColumn
                Caption = 'Data eliberarii'
                Width = 120
              end
              object cxGridDP_ELIBERAT_DE: TcxGridDBColumn
                Caption = 'Eliberat de'
                Width = 150
              end
              object cxGridDP_SCAN: TcxGridDBColumn
                Caption = 'Scan'
                Visible = False
              end
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridDP
            end
          end
        end
        object cxTabSheet4: TcxTabSheet
          Caption = 'Evenimente importante'
          ImageIndex = 4
          inline frameCustomerEvents1: TframeCustomerEvents
            Left = 0
            Top = 0
            Width = 741
            Height = 205
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ExplicitWidth = 741
            ExplicitHeight = 205
            inherited cxGrid3: TcxGrid
              Width = 741
              Height = 177
              ExplicitWidth = 741
              ExplicitHeight = 174
            end
            inherited dxBarManager1: TdxBarManager
              PixelsPerInch = 96
            end
          end
        end
      end
      object teIDNO: TcxDBTextEdit
        Left = 200
        Top = 88
        DataBinding.DataField = 'IDNO'
        TabOrder = 9
        Width = 137
      end
      object teBuletinNo: TcxDBTextEdit
        Left = 352
        Top = 88
        DataBinding.DataField = 'BuletinNo'
        TabOrder = 10
        Width = 105
      end
      object deBuletinDate: TcxDBDateEdit
        Left = 472
        Top = 87
        DataBinding.DataField = 'buletin_date'
        Properties.ImmediatePost = True
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 11
        Width = 125
      end
    end
    object tbsUserAccount: TcxTabSheet
      Caption = 'Account'
      ImageIndex = 2
      object cxLabel10: TLabel
        Left = 12
        Top = 17
        Width = 45
        Height = 15
        Caption = 'Account'
        Transparent = True
      end
      object cxLabel12: TLabel
        Left = 319
        Top = 17
        Width = 86
        Height = 15
        Caption = 'Optiuni account'
        Transparent = True
      end
      object lbUserWorkDaysInfo: TLabel
        Left = 351
        Top = 156
        Width = 3
        Height = 15
        Transparent = True
      end
      object Label6: TLabel
        Left = 501
        Top = 13
        Width = 57
        Height = 15
        Caption = 'Semnatura'
        Transparent = True
      end
      object edUserLoginName: TcxDBTextEdit
        Left = 12
        Top = 34
        DataBinding.DataField = 'LOGIN_NAME'
        Style.TextStyle = [fsBold]
        TabOrder = 0
        Width = 229
      end
      object cbFlgActive: TcxDBCheckBox
        Left = 332
        Top = 34
        Caption = 'Activ'
        DataBinding.DataField = 'FLG_ACTIVE'
        Properties.Alignment = taLeftJustify
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 1
      end
      object cbFlgChangePass: TcxDBCheckBox
        Left = 332
        Top = 63
        Caption = 'Modifica parola la 30 zile'
        DataBinding.DataField = 'FLG_CHANGE_PSWD'
        Properties.Alignment = taLeftJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        TabOrder = 4
      end
      object cbDefaultPassword: TcxCheckBox
        Left = 12
        Top = 90
        Caption = 'Parola implicita'
        TabOrder = 5
      end
      object cbFLG_ACTIVE_HOURS: TcxDBCheckBox
        Left = 332
        Top = 92
        Caption = 'Acces in aplicatie limitat'
        DataBinding.DataField = 'FLG_ACTIVE_HOURS'
        Properties.Alignment = taLeftJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Properties.OnEditValueChanged = cbFLG_ACTIVE_HOURSPropertiesEditValueChanged
        TabOrder = 6
      end
      object imgUserSignature: TcxDBImage
        Left = 501
        Top = 34
        DataBinding.DataField = 'USER_SIGNATURE'
        DataBinding.DataSource = IBCDataSourceImage
        Properties.Caption = 'Semnatura'
        Properties.ClearKey = 16430
        Properties.GraphicClassName = 'TdxSmartImage'
        TabOrder = 2
        Height = 71
        Width = 188
      end
      object btnUserPassword: TcxButton
        Left = 122
        Top = 63
        Width = 119
        Height = 29
        Caption = 'Seteaza parola'
        TabOrder = 3
        OnClick = btnUserPasswordClick
      end
      object btnUserWorkHours: TcxButton
        Left = 122
        Top = 129
        Width = 119
        Height = 29
        Caption = 'Orele de lucru'
        TabOrder = 8
        OnClick = btnUserWorkHoursClick
      end
      object cbFLG_MONEY: TcxDBCheckBox
        Left = 334
        Top = 121
        Caption = 'Incaseaza'
        DataBinding.DataField = 'flg_work_with_money'
        Properties.Alignment = taLeftJustify
        Properties.ImmediatePost = True
        Properties.NullStyle = nssUnchecked
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Properties.OnEditValueChanged = cbFLG_ACTIVE_HOURSPropertiesEditValueChanged
        Style.TransparentBorder = False
        TabOrder = 7
      end
    end
    object tbsUserGroups: TcxTabSheet
      Caption = 'Grupe de acces'
      ImageIndex = 3
      object cxLabel14: TLabel
        Left = 12
        Top = 17
        Width = 80
        Height = 15
        Caption = 'Grupe cu acces'
        Transparent = True
      end
      object cxLabel15: TLabel
        Left = 312
        Top = 17
        Width = 93
        Height = 15
        Caption = 'Grupe disponibile'
        Transparent = True
      end
      object cxGridUserGroups: TcxGrid
        Left = 12
        Top = 34
        Width = 245
        Height = 377
        TabOrder = 0
        object cxGridUserGroupsTable: TcxGridTableView
          OnCellDblClick = cxGridUserGroupsTableCellDblClick
          OnSelectionChanged = cxGridUserGroupsTableSelectionChanged
          OptionsData.Deleting = False
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
        Left = 312
        Top = 34
        Width = 245
        Height = 374
        TabOrder = 1
        object cxGridAUGTable: TcxGridTableView
          OnCellDblClick = cxGridAUGTableCellDblClick
          OnSelectionChanged = cxGridUserGroupsTableSelectionChanged
          OptionsData.Deleting = False
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
        Left = 268
        Top = 56
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
        Left = 263
        Top = 91
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
    object tbsFirms: TcxTabSheet
      Caption = 'Accesul la subdiviziuni'
      ImageIndex = 4
      object cxLabel11: TLabel
        Left = 12
        Top = 56
        Width = 112
        Height = 15
        Caption = 'Subdiviziuni cu acces'
        Transparent = True
      end
      object cxLabel16: TLabel
        Left = 312
        Top = 56
        Width = 119
        Height = 15
        Caption = 'Subdiviziuni fara acces'
        Transparent = True
      end
      object cxLabel19: TLabel
        Left = 12
        Top = 17
        Width = 116
        Height = 15
        Caption = 'Subdiviziune implicita'
        Transparent = True
      end
      object edDEFAULT_DT_NAME: TcxTextEdit
        Left = 146
        Top = 16
        TabStop = False
        Properties.ReadOnly = True
        Style.TextColor = clNavy
        TabOrder = 0
        Text = 'edDEFAULT_DT_NAME'
        OnDragDrop = edDEFAULT_DT_NAMEDragDrop
        OnDragOver = edDEFAULT_DT_NAMEDragOver
        Width = 410
      end
      object cxGridUserFirms: TcxGrid
        Left = 11
        Top = 73
        Width = 245
        Height = 341
        TabOrder = 1
        object cxGridUserFirmsTable: TcxGridTableView
          DragMode = dmAutomatic
          OnCellDblClick = cxGridUserFirmsTableCellDblClick
          OnSelectionChanged = cxGridUserFirmsTableSelectionChanged
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsData.Deleting = False
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
          object cxGridUserFirms_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridUserFirms_TITLE: TcxGridColumn
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxGridUserFirms_FIRMAID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
          end
        end
        object cxGridUserFirmsLevel: TcxGridLevel
          GridView = cxGridUserFirmsTable
        end
      end
      object cxGridAUF: TcxGrid
        Left = 312
        Top = 73
        Width = 245
        Height = 340
        TabOrder = 2
        object cxGridAUFTable: TcxGridTableView
          OnCellDblClick = cxGridAUFTableCellDblClick
          OnSelectionChanged = cxGridUserFirmsTableSelectionChanged
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsData.Deleting = False
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
          object cxGridAUF_IMG: TcxGridColumn
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.DefaultImageIndex = 11
            Properties.Images = dmAdditions.cxImageList_SWN
            Properties.Items = <>
            MinWidth = 26
            Options.ShowEditButtons = isebNever
            Options.HorzSizing = False
            Width = 26
          end
          object cxGridAUF_TITLE: TcxGridColumn
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxGridAUF_FIRMAID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
          end
        end
        object cxGridAUFLevel: TcxGridLevel
          GridView = cxGridAUFTable
        end
      end
      object btnAddFirm: TcxButton
        Left = 268
        Top = 84
        Width = 33
        Height = 29
        Caption = '<'
        TabOrder = 3
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnAddFirmClick
      end
      object btnRemoveFirm: TcxButton
        Left = 268
        Top = 119
        Width = 33
        Height = 29
        Caption = '>'
        TabOrder = 4
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        OnClick = btnRemoveFirmClick
      end
    end
    object tbsCustomer: TcxTabSheet
      Caption = 'Date despre angajat'
      ImageIndex = 4
      object cxLabel17: TLabel
        Left = 12
        Top = 64
        Width = 227
        Height = 15
        Caption = 'Legatura cu colaboratorul din nomenclator'
        Transparent = True
      end
      object Label2: TLabel
        Left = 12
        Top = 121
        Width = 93
        Height = 15
        Caption = 'Inceputul lucrului'
        Transparent = True
      end
      object Label3: TLabel
        Left = 12
        Top = 17
        Width = 66
        Height = 15
        Caption = 'Tip utilizator'
        Transparent = True
      end
      object Label1: TLabel
        Left = 212
        Top = 121
        Width = 85
        Height = 15
        Caption = 'Functia ocupata'
        Transparent = True
      end
      object cxLabel3: TLabel
        Left = 12
        Top = 167
        Width = 48
        Height = 15
        Caption = 'Descriere'
        Transparent = True
      end
      object beCUSTOMER_DISPLAYNAME: TcxButtonEdit
        Left = 12
        Top = 85
        Properties.Buttons = <
          item
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000001000000030000
              0006000000080000000B0000000D0000000E0000000F0000000F000000100000
              000F0000000E0000000C00000009000000050000000100000003081A1341143F
              2E921B543CBD1F5E43D3257553FF247353FF247251FF247151FF237051FF2370
              4FFF1C593FD6184E37C1123A29990717104900000006000000072A8260FF36A7
              80FF34B186FF33B589FF34C192FF33BF90FF31BD8DFF30BC8CFF2FBA8AFF2EB9
              89FF2CAA7DFF2AA378FF2A976FFF257353FF0000000D000000062A7E5FE973D9
              BDFF5AD4B0FF43CCA1FF40C99DFF3EC79AFF3BC598FF38C295FF36C092FF34BE
              90FF32BD8EFF3ABF93FF42BE95FF247153EE0000000C000000031845357B48A7
              87FF74CEB4FF83E5CBFF57CEABFF2F9773FF207D5DFF1B7859FF218966FF42BF
              98FF5AD1ADFF4BB996FF349674FF154030880000000600000000000000030C22
              1A3C256B53B345A987FF53AC90FF63A9B1FF71A7CCFF5D8CB7FF367489FF2C8E
              73FF3A9D7BFF22664DBA0B201946000000070000000100000000000000000000
              000100000003091B15322D7A61CC5588ABFF325994FF2C538FFF34608EFF2873
              5CCD091A14360000000700000003000000010000000000000000000000000000
              000000000000000000071221316B4572ACFF659FD7FF629CD6FF3968A5FF0C1B
              2C6F000000080000000000000000000000000000000000000000000000000000
              0000000000010000000E2B466EC379AFDAFF90CCF5FF77B4E8FF5991CBFF1D3A
              66CA0000000E0000000100000000000000000000000000000000000000000000
              00000101010315253F8A36598DF8BAE1F6FFBDE6FCFF8CC9F2FF69A5DBFF2144
              7AF70D1934950101010300000000000000000000000000000000000000000000
              0000010101052A4B7DE2385F95FFD5F0FBFFD1EDFBFF94CFF3FF6DA7DDFF2446
              7DFF172C59E20101010500000000000000000000000000000000000000000000
              00000101010538649EFA3C6CA8FFBAD7E9FF698EB7FF325A91FF2B5086FF2851
              8FFE1D3869FA0101010500000000000000000000000000000000000000000000
              000001010104386498DC539CE0FF497BB7FF5390CDFF4E8FD3FF3C76C1FF396C
              B1FF223F72FF0101010500000000000000000000000000000000000000000000
              0000010101021525374D4B84C2F17FB9E7FF86BDE9FF8DC4EEFF75A8DAFF5683
              B8FF1C3359BF0101010400000000000000000000000000000000000000000000
              000000000000010101020E16202B37618DB03D6B9FD24276B3FF305485D51C32
              5193030507120000000100000000000000000000000000000000000000000000
              0000000000000000000000000001010101030101010501010105010101040101
              01030000000100000000000000000000000000000000}
            Kind = bkGlyph
          end
          item
            Caption = #1053#1077#1090
            Glyph.SourceDPI = 96
            Glyph.Data = {
              424D360400000000000036000000280000001000000010000000010020000000
              000000000000C40E0000C40E0000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00020000000A0000001000000009000000020000000000000000000000020000
              000A000000120000000C00000003000000000000000000000000000000020000
              000F0F0742921D0F7EEF0603347A0000000E00000002000000020000000F0804
              347C1D0F7EF00F0841940000001200000002000000000000000000000008120B
              47923233AFFF3648CCFF1D1EA5FF0603357A0000000F0000000F0703357C1F20
              A5FF3747CCFF2D2FAEFF120B46950000000B00000000000000000000000C281C
              8DF1596CD8FF3B51D3FF3A4FD2FF1E22A6FF0602347D0502357E2022A6FF3A50
              D3FF3A50D3FF4C5FD4FF291D8CF100000010000000000000000000000006130F
              3C734D4FBAFF667EE0FF415AD6FF415AD7FF1F24A7FF2529A8FF415AD7FF415A
              D7FF5B72DEFF484AB8FF130F3C79000000090000000000000000000000010000
              000A16123F73585CC1FF758DE6FF4A64DBFF4A65DBFF4A65DBFF4A64DBFF6983
              E3FF5356C0FF16123F780000000C000000020000000000000000000000000000
              00010000000A191643755D63C7FF6783E5FF5774E2FF5774E2FF5774E2FF565C
              C6FF1916437A0000000D00000002000000000000000000000000000000000000
              000100000009100E3D734A50BEFF7492EBFF6383E7FF6483E7FF6383E7FF3840
              B6FF0B0839780000000C00000002000000000000000000000000000000010000
              00071413416E555CC5FF85A1EFFF7897EDFF9CB6F4FF9DB7F5FF7997EEFF7796
              EDFF414ABCFF0E0C3C730000000A000000010000000000000000000000041818
              456B636CCFFF93AFF3FF83A1F1FFA6BFF7FF676DCAFF7E87DDFFAFC7F8FF83A3
              F2FF83A1F1FF5058C4FF12104071000000060000000000000000000000065759
              C3EFAFC6F6FF8EADF4FFABC4F8FF6F76D0FF1817456F24244F70868EE1FFB5CC
              F9FF8DACF4FFA1B8F4FF5758C3EF000000090000000000000000000000033132
              6B8695A0EAFFC0D3F9FF7880D7FF1C1C496B00000006000000072527526C8B93
              E6FFC1D3F9FF949EE9FF30316887000000050000000000000000000000010000
              000431336B825E62CBEC1F204D68000000050000000100000001000000052728
              536B5E62CBEC3132688300000007000000010000000000000000000000000000
              0000000000020000000400000002000000010000000000000000000000010000
              0003000000050000000400000001000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              00000000000000000000000000000000000000000000}
            Kind = bkGlyph
          end>
        Properties.ClickKey = 0
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = beCUSTOMER_DISPLAYNAMEPropertiesButtonClick
        TabOrder = 1
        Text = 'beCUSTOMER_DISPLAYNAME'
        Width = 297
      end
      object deREGISTER_DATE: TcxDBDateEdit
        Left = 12
        Top = 138
        DataBinding.DataField = 'REGISTER_DATE'
        Properties.DateButtons = [btnClear, btnNow, btnToday]
        Properties.SaveTime = False
        Properties.ShowTime = False
        Properties.WeekNumbers = True
        TabOrder = 2
        Width = 149
      end
      object lcbUSERTYPE_ID: TcxDBLookupComboBox
        Left = 12
        Top = 34
        DataBinding.DataField = 'USERTYPE_ID'
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 16
        Properties.KeyFieldNames = 'SYSSID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = IBCDataSourceUserType
        TabOrder = 0
        Width = 285
      end
      object cmbFUNCTIA_DETINUTA: TcxDBComboBox
        Left = 212
        Top = 138
        DataBinding.DataField = 'FUNCTIA_DETINUTA'
        Properties.Items.Strings = (
          'V'#238'nz'#259'tor'
          'Manager magazin'
          'Depozitar'
          'Manager depozit')
        TabOrder = 3
        Width = 437
      end
      object mmUserDescription: TcxDBMemo
        Left = 12
        Top = 188
        DataBinding.DataField = 'DESCRIPTION'
        Properties.ScrollBars = ssVertical
        TabOrder = 4
        Height = 65
        Width = 637
      end
    end
    object tbsSIP: TcxTabSheet
      Caption = 'SIP'
      ImageIndex = 5
      object SpeedButton1: TSpeedButton
        Left = 282
        Top = 21
        Width = 23
        Height = 25
        Caption = '...'
        OnClick = SpeedButton1Click
      end
      object cxLabel13: TcxLabel
        Left = 3
        Top = 24
        Caption = 'Adresa serverului'
        TabOrder = 1
        Transparent = True
      end
      object cxLabel18: TcxLabel
        Left = 3
        Top = 72
        Caption = 'Sip Utilizator'
        TabOrder = 4
        Transparent = True
      end
      object cxLabel20: TcxLabel
        Left = 315
        Top = 72
        Caption = 'Parola'
        TabOrder = 5
        Transparent = True
      end
      object cxLabel21: TcxLabel
        Left = 3
        Top = 113
        Caption = 'STUN'
        TabOrder = 7
        Transparent = True
      end
      object cxLabel22: TcxLabel
        Left = 3
        Top = 153
        Caption = 'Proxy'
        TabOrder = 9
        Transparent = True
      end
      object teServerIP: TcxDBTextEdit
        Left = 103
        Top = 23
        DataBinding.DataField = 'SIP_SRV_ADRESS'
        TabOrder = 0
        Width = 178
      end
      object teUser: TcxDBTextEdit
        Left = 103
        Top = 67
        DataBinding.DataField = 'SIP_USERID'
        TabOrder = 2
        Width = 178
      end
      object tePassword: TcxDBTextEdit
        Left = 358
        Top = 67
        DataBinding.DataField = 'SIP_USER_PSWD'
        TabOrder = 3
        Width = 178
      end
      object teSTUN: TcxDBTextEdit
        Left = 103
        Top = 112
        DataBinding.DataField = 'SIP_STUN'
        TabOrder = 6
        Width = 178
      end
      object teProxy: TcxDBTextEdit
        Left = 103
        Top = 152
        DataBinding.DataField = 'SIP_PROXY'
        TabOrder = 8
        Width = 178
      end
    end
  end
  object btnCancel: TcxButton
    Left = 667
    Top = 611
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
  object btnOk: TcxButton
    Left = 563
    Top = 611
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'O&K'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object IBCQueryCities: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      '    CITYID,'
      '    TITLE,'
      '    DISTRICTID,'
      '    DISTRICT_TITLE'
      'FROM'
      '    GET_CITIES')
    Left = 612
    Top = 224
  end
  object IBCDataSourceCities: TIBCDataSource
    DataSet = IBCQueryCities
    Left = 612
    Top = 172
  end
  object IBCQueryImage: TIBCQuery
    KeyFields = 'USERID'
    SQLInsert.Strings = (
      'INSERT INTO TS_USER_IMAGE'
      '  (USERID, IMAGE, USER_SIGNATURE)'
      'VALUES'
      '  (:USERID, :IMAGE, :USER_SIGNATURE)')
    SQLDelete.Strings = (
      'DELETE FROM TS_USER_IMAGE'
      'WHERE'
      '  USERID = :Old_USERID')
    SQLUpdate.Strings = (
      'UPDATE TS_USER_IMAGE'
      'SET'
      
        '  USERID = :USERID, IMAGE = :IMAGE, USER_SIGNATURE = :USER_SIGNA' +
        'TURE'
      'WHERE'
      '  USERID = :Old_USERID')
    SQLRefresh.Strings = (
      'SELECT USERID, IMAGE, USER_SIGNATURE FROM TS_USER_IMAGE'
      'WHERE'
      '  USERID = :USERID')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_USER_IMAGE'
      'WHERE'
      'USERID = :Old_USERID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM TS_USER_IMAGE'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' USERID, '
      ' IMAGE, '
      ' USER_SIGNATURE '
      'FROM '
      ' TS_USER_IMAGE')
    MasterFields = 'USERID'
    DetailFields = 'USERID'
    AutoCommit = False
    Left = 104
    Top = 392
  end
  object IBCDataSourceImage: TIBCDataSource
    DataSet = IBCQueryImage
    Left = 172
    Top = 156
  end
  object IBCQueryUserType: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' SYSSID,'
      ' TITLE'
      'FROM '
      ' TS_SYSS'
      'WHERE '
      ' PARENTID=28')
    Left = 388
    Top = 392
  end
  object IBCDataSourceUserType: TIBCDataSource
    DataSet = IBCQueryUserType
    Left = 404
    Top = 316
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'Comunicare'
      #1058#1077#1083#1077#1092#1086#1085#1099' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      'Date Personale')
    Categories.ItemsVisibles = (
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True)
    ImageOptions.Images = dmAdditions.cxImageList_SWN
    ImageOptions.StretchGlyphs = False
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 428
    Top = 12
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
      0)
    object dxBarManager1Bar1: TdxBar
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
      FloatLeft = 711
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPeriodAdd'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPeriodEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPeriodDelete'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'comunicare'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 711
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbComNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbComEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbComDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = #1090#1077#1083#1077#1092#1086#1085#1099' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 711
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbNewPhone'
        end
        item
          Visible = True
          ItemName = 'bbEditPhone'
        end
        item
          Visible = True
          ItemName = 'bbDeletePhone'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar4: TdxBar
      Caption = 'Date personale'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 711
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPDNew'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPDEdit'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'bbPDDelete'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar5: TdxBar
      Caption = 'Evenimente importante'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 711
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbPeriodAdd: TdxBarButton
      Caption = 'Nou'
      Category = 0
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbPeriodAddClick
    end
    object bbPeriodEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
      OnClick = bbPeriodEditClick
    end
    object bbPeriodDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 0
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
      OnClick = bbPeriodDeleteClick
    end
    object bbComNew: TdxBarButton
      Caption = 'Nou'
      Category = 1
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbComEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 1
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbComDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 1
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbNewPhone: TdxBarButton
      Caption = 'Nou'
      Category = 2
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbEditPhone: TdxBarButton
      Caption = 'Modifica'
      Category = 2
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbDeletePhone: TdxBarButton
      Caption = 'Sterge'
      Category = 2
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
    object bbPDNew: TdxBarButton
      Caption = 'Nou'
      Category = 3
      Hint = 'Nou'
      Visible = ivAlways
      ImageIndex = 40
    end
    object bbPDEdit: TdxBarButton
      Caption = 'Modifica'
      Category = 3
      Hint = 'Modifica'
      Visible = ivAlways
      ImageIndex = 41
    end
    object bbPDDelete: TdxBarButton
      Caption = 'Sterge'
      Category = 3
      Hint = 'Sterge'
      Visible = ivAlways
      ImageIndex = 42
    end
  end
  object IBCQueryPeriods: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TS_USER_FIRME_PERIOD'
      '  (USERID, START_DATE, END_DATE, FIRMAID)'
      'VALUES'
      '  (:USERID, :START_DATE, :END_DATE, :FIRMAID)')
    SQLDelete.Strings = (
      'DELETE '
      'FROM TS_USER_FIRME_PERIOD'
      'WHERE'
      ' USERID = :Old_USERID '
      ' AND START_DATE = :Old_START_DATE '
      ' AND '
      ' END_DATE = :Old_END_DATE')
    SQLUpdate.Strings = (
      'UPDATE TS_USER_FIRME_PERIOD'
      'SET'
      ' USERID = :USERID, '
      ' START_DATE = :START_DATE, '
      ' END_DATE = :END_DATE, '
      ' FIRMAID = :FIRMAID'
      'WHERE'
      ' USERID = :Old_USERID '
      ' AND '
      ' START_DATE = :Old_START_DATE '
      ' AND '
      ' END_DATE = :Old_END_DATE')
    SQLRefresh.Strings = (
      'SELECT '
      ' USERID, '
      ' START_DATE, '
      ' END_DATE, '
      ' FIRMAID,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=FIRMAID)'
      'FROM '
      ' TS_USER_FIRME_PERIOD'
      'WHERE'
      ' USERID = :USERID '
      ' AND '
      ' START_DATE = :START_DATE '
      ' AND '
      ' END_DATE = :END_DATE')
    SQLLock.Strings = (
      'SELECT NULL FROM TS_USER_FIRME_PERIOD'
      'WHERE'
      
        'USERID = :Old_USERID AND START_DATE = :Old_START_DATE AND END_DA' +
        'TE = :Old_END_DATE'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT '
      ' USERID, '
      ' START_DATE, '
      ' END_DATE, '
      ' FIRMAID,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=FIRMAID)'
      'FROM '
      ' TS_USER_FIRME_PERIOD')
    MasterFields = 'USERID'
    DetailFields = 'USERID'
    AutoCommit = False
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.DetailDelay = 500
    Left = 292
    Top = 316
  end
  object IBCDataSourcePeriods: TIBCDataSource
    DataSet = IBCQueryPeriods
    Left = 460
    Top = 160
  end
end
