object frmSearchDocumentById2Dlg: TfrmSearchDocumentById2Dlg
  Left = 0
  Top = 0
  ActiveControl = edSearchText
  BorderStyle = bsDialog
  Caption = 'Cauta documentul dupa cod'
  ClientHeight = 551
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    870
    551)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 870
    Height = 64
    Title = 'Cauta dupa codul documentului'
    Text = 'Cauta dupa codul documentului si trecerea la document...'
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
    ImageIndex = 9
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 854
    Height = 425
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnClient'
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 28
      Width = 80
      Height = 15
      Caption = 'Cod document'
    end
    object Label3: TLabel
      Left = 563
      Top = 59
      Width = 85
      Height = 15
      Caption = 'Istoria cautarilor'
    end
    object btnSearch: TButton
      Left = 215
      Top = 22
      Width = 75
      Height = 29
      Caption = 'Cauta'
      Default = True
      TabOrder = 0
      OnClick = btnSearchClick
    end
    object edSearchText: TEdit
      Left = 107
      Top = 25
      Width = 102
      Height = 23
      TabOrder = 1
      OnChange = edSearchTextChange
      OnEnter = edSearchTextEnter
    end
    object pcPageControl: TcxPageControl
      Left = 20
      Top = 80
      Width = 537
      Height = 313
      TabOrder = 2
      Properties.ActivePage = tbsAWB
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 309
      ClientRectLeft = 4
      ClientRectRight = 533
      ClientRectTop = 26
      object tbsDoc: TcxTabSheet
        Caption = 'Document'
        ImageIndex = 0
        object cxDBVerticalGrid: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 376
          Height = 283
          Align = alClient
          OptionsView.ScrollBars = ssNone
          OptionsView.CategoryExplorerStyle = True
          OptionsView.RowHeaderWidth = 140
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
          TabOrder = 0
          DataController.DataSource = IBCDataSourceDOCS
          Version = 1
          object rowDOCTYPE_NAME: TcxDBEditorRow
            Properties.Caption = 'Tip document'
            Properties.DataBinding.FieldName = 'DOCTYPE_NAME'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object rowDOCID: TcxDBEditorRow
            Properties.Caption = 'Cod document'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'DOCID'
            Properties.Options.Editing = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object rowPARENTDOCID: TcxDBEditorRow
            Properties.Caption = 'Document parinte'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Hint = #1048#1089#1082#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
                Kind = bkGlyph
                Stretchable = False
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.EditProperties.OnButtonClick = rowPARENTDOCIDEditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'PARENTDOCID'
            Properties.Options.ShowEditButtons = eisbAlways
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object rowDATA: TcxDBEditorRow
            Properties.Caption = 'Data'
            Properties.DataBinding.FieldName = 'DATA'
            Properties.Options.Editing = False
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object rowDT_NAME: TcxDBEditorRow
            Properties.Caption = 'Subdiviziunea'
            Properties.DataBinding.FieldName = 'DT_NAME'
            Properties.Options.Editing = False
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object rowCT_NAME: TcxDBEditorRow
            Properties.Caption = 'Client'
            Properties.DataBinding.FieldName = 'CT_NAME'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object rowCURRENCY_NAME: TcxDBEditorRow
            Properties.Caption = 'Valuta'
            Properties.DataBinding.FieldName = 'CURRENCY_NAME'
            Properties.Options.Editing = False
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object rowSUMA: TcxDBEditorRow
            Properties.Caption = 'Suma'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.DisplayFormat = '0.00'
            Properties.DataBinding.FieldName = 'SUMA'
            Properties.Options.Editing = False
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object rowRATE: TcxDBEditorRow
            Properties.Caption = 'Rata documentului'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'RATE'
            Properties.Options.Editing = False
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object rowRATEUSD: TcxDBEditorRow
            Properties.Caption = 'Rata USD'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'RATEUSD'
            Properties.Options.Editing = False
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object rowCREATED_BY_NAME: TcxDBEditorRow
            Properties.Caption = 'Utilizator'
            Properties.DataBinding.FieldName = 'CREATED_BY_NAME'
            Properties.Options.Editing = False
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
          object rowINCIDENTID: TcxDBEditorRow
            Properties.Caption = 'Incident in Dept Tehnic'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Kind = bkGlyph
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.EditProperties.OnButtonClick = rowINCIDENTIDEditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'INCIDENTID'
            Properties.Options.ShowEditButtons = eisbAlways
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 11
            ParentID = -1
            Index = 11
            Version = 1
          end
          object rowDeliveryInfo: TcxDBMultiEditorRow
            Properties.Editors = <
              item
                Caption = 'Cod livrare'
                DataBinding.FieldName = 'WAYBILLID'
              end
              item
                Caption = 'Curier'
                Width = 300
                DataBinding.FieldName = 'CURIER_NAME'
              end>
            ID = 12
            ParentID = -1
            Index = 12
            Version = 1
          end
        end
        object cxDBVerticalGridFlags: TcxDBVerticalGrid
          Left = 376
          Top = 0
          Width = 153
          Height = 283
          Align = alRight
          OptionsView.ScrollBars = ssNone
          OptionsView.RowHeaderWidth = 111
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
          TabOrder = 1
          DataController.DataSource = IBCDataSourceDOCS
          Version = 1
          object cxDBVerticalGridFlagsDBEditorRow1: TcxDBEditorRow
            Properties.Caption = 'FLG_Account'
            Properties.Hint = 'FLG_ACNT'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_ACNT'
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow2: TcxDBEditorRow
            Properties.Caption = 'FLG_Close'
            Properties.Hint = 'FLG_CLOSED'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_CLOSED'
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow3: TcxDBEditorRow
            Properties.Caption = 'FLG_Del'
            Properties.Hint = 'FLG_DEL'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_DEL'
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow4: TcxDBEditorRow
            Properties.Caption = 'FLG_Arrival'
            Properties.Hint = 'FLG_GOODS_ARRIVAL'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_GOODS_ARRIVAL'
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow5: TcxDBEditorRow
            Properties.Caption = 'FLG_Invoice'
            Properties.Hint = 'FLG_INVOICE'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_INVOICE'
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow6: TcxDBEditorRow
            Properties.Caption = 'FLG_Paid'
            Properties.Hint = 'FLG_PAID'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_PAID'
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow7: TcxDBEditorRow
            Properties.Caption = 'FLG_Protected'
            Properties.Hint = 'FLG_PROTECTED'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_PROTECTED'
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow8: TcxDBEditorRow
            Properties.Caption = 'FLG_Ready'
            Properties.Hint = 'FLG_READY'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_READY'
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow9: TcxDBEditorRow
            Properties.Caption = 'FLG_Receive'
            Properties.Hint = 'FLG_RECEIVE'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_RECEIVE'
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow10: TcxDBEditorRow
            Properties.Caption = 'FLG_Send'
            Properties.Hint = 'FLG_SEND'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_SEND'
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow11: TcxDBEditorRow
            Properties.Caption = 'FLG_Ship'
            Properties.Hint = 'FLG_SHIP'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_SHIP'
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
          object cxDBVerticalGridFlagsDBEditorRow12: TcxDBEditorRow
            Properties.Caption = 'FLG_Export'
            Properties.Hint = 'FLG_EXPORTED'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_EXPORTED'
            ID = 11
            ParentID = -1
            Index = 11
            Version = 1
          end
        end
      end
      object tbsInvoice: TcxTabSheet
        Caption = 'Factura fiscala'
        ImageIndex = 4
        object cxDBVerticalGrid3: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 529
          Height = 283
          Align = alClient
          OptionsView.ScrollBars = ssNone
          OptionsView.ShowEditButtons = ecsbAlways
          OptionsView.CategoryExplorerStyle = True
          OptionsView.RowHeaderWidth = 200
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
          TabOrder = 0
          DataController.DataSource = IBCDataSourceINVOICE
          Version = 1
          object cxDBEditorRow10: TcxDBEditorRow
            Properties.Caption = 'Numar factura fiscala'
            Properties.DataBinding.FieldName = 'FACTURANO'
            Properties.Options.Editing = False
            Properties.Options.ShowEditButtons = eisbAlways
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBEditorRow1: TcxDBEditorRow
            Properties.Caption = 'Cod factura fiscala'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'INVOICEID'
            Properties.Options.Editing = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBEditorRow9: TcxDBEditorRow
            Properties.Caption = 'Cod document'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Hint = #1053#1072#1081#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
                Kind = bkGlyph
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.EditProperties.OnButtonClick = cxDBEditorRow9EditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'DOCID'
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBEditorRow17: TcxDBEditorRow
            Properties.Caption = 'Data eliberarii'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'DATA_ELIBERARII'
            Properties.Options.Editing = False
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBEditorRowCustomerName: TcxDBEditorRow
            Properties.Caption = 'Client'
            Properties.DataBinding.FieldName = 'CT_NAME'
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBEditorRow18: TcxDBEditorRow
            Properties.Caption = 'Delegat'
            Properties.DataBinding.FieldName = 'DELEGAT'
            Properties.Options.Editing = False
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxDBEditorRow19: TcxDBEditorRow
            Properties.Caption = 'Transportator'
            Properties.DataBinding.FieldName = 'TRANSPORTATOR_NAME'
            Properties.Options.Editing = False
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxDBEditorRow20: TcxDBEditorRow
            Properties.Caption = 'Numarul de imnatriculare'
            Properties.DataBinding.FieldName = 'NRMATRICULARE'
            Properties.Options.Editing = False
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxDBEditorRow21: TcxDBEditorRow
            Properties.Caption = 'Numarul foii de parcurs'
            Properties.DataBinding.FieldName = 'NRFOAIEDEPARCURS'
            Properties.Options.Editing = False
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxDBEditorRow23: TcxDBEditorRow
            Properties.Caption = 'Documente anexate'
            Properties.DataBinding.FieldName = 'DOCUMENTE_ANEXATE'
            Properties.Options.Editing = False
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object cxDBVerticalGrid3DBEditorRow1: TcxDBEditorRow
            Properties.Caption = 'Utilizator'
            Properties.DataBinding.FieldName = 'USERID_NAME'
            Properties.Options.Editing = False
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
        end
      end
      object tbsContract: TcxTabSheet
        Caption = 'Contracte'
        ImageIndex = 2
        object cxDBVerticalGrid1: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 529
          Height = 283
          Align = alClient
          OptionsView.ScrollBars = ssNone
          OptionsView.CategoryExplorerStyle = True
          OptionsView.RowHeaderWidth = 191
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Editing = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
          TabOrder = 0
          DataController.DataSource = IBCDataSourceCONTRACT
          Version = 1
          object cxDBEditorRow3: TcxDBEditorRow
            Properties.Caption = 'Numar contract'
            Properties.DataBinding.FieldName = 'CODE'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBEditorRow2: TcxDBEditorRow
            Properties.Caption = 'Cod contract'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'CONTRACTID'
            Properties.Options.Editing = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBEditorRow4: TcxDBEditorRow
            Properties.Caption = 'Subdiviziunea'
            Properties.DataBinding.FieldName = 'DT_NAME'
            Properties.Options.Editing = False
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBEditorRow5: TcxDBEditorRow
            Properties.Caption = 'Client'
            Properties.DataBinding.FieldName = 'CT_NAME'
            Properties.Options.Editing = False
            Properties.Options.ShowEditButtons = eisbAlways
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBEditorRow6: TcxDBEditorRow
            Properties.Caption = 'Data semnarii'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'SIGN_DATE'
            Properties.Options.Editing = False
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBEditorRow7: TcxDBEditorRow
            Properties.Caption = 'Data terminarii'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'EXPIRE_DATE'
            Properties.Options.Editing = False
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxDBEditorRow8: TcxDBEditorRow
            Properties.Caption = 'Tip contract'
            Properties.DataBinding.FieldName = 'CONTRACT_TYPE_TITLE'
            Properties.Options.Editing = False
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxDBEditorRow11: TcxDBEditorRow
            Properties.Caption = 'Valuta'
            Properties.DataBinding.FieldName = 'CURRENCY_TITLE'
            Properties.Options.Editing = False
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxDBEditorRow12: TcxDBEditorRow
            Properties.Caption = 'Contabilitate'
            Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
            Properties.EditProperties.Alignment = taLeftJustify
            Properties.EditProperties.ValueChecked = 1
            Properties.EditProperties.ValueUnchecked = 0
            Properties.DataBinding.FieldName = 'FLG_ACNT'
            Properties.Options.Editing = False
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxDBEditorRow22: TcxDBEditorRow
            Properties.Caption = 'Utilizator'
            Properties.DataBinding.FieldName = 'CREATED_BY_NAME'
            Properties.Options.Editing = False
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object cxDBEditorRow121: TcxDBEditorRow
            Properties.Caption = 'Data crearii'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'CREATED_DATE'
            Properties.Options.Editing = False
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
        end
      end
      object tbsIncident: TcxTabSheet
        Caption = 'Incidente in Departamentul Tehnic'
        ImageIndex = 3
        object cxDBVerticalGrid2: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 529
          Height = 283
          Align = alClient
          OptionsView.ScrollBars = ssVertical
          OptionsView.ShowEditButtons = ecsbAlways
          OptionsView.CategoryExplorerStyle = True
          OptionsView.RowHeaderWidth = 216
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
          TabOrder = 0
          DataController.DataSource = IBCDataSourceINCIDENTE
          Version = 1
          object cxDBEditorRow13: TcxDBEditorRow
            Properties.Caption = 'Tip incident'
            Properties.DataBinding.FieldName = 'TYPE_TITLE'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBEditorRow14: TcxDBEditorRow
            Properties.Caption = 'Cod incident'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'INCIDENTID'
            Properties.Options.Editing = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBEditorRow15: TcxDBEditorRow
            Properties.Caption = 'Data'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'DATA'
            Properties.Options.Editing = False
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow7: TcxDBEditorRow
            Properties.Caption = 'Client'
            Properties.DataBinding.FieldName = 'DOC_CUSTOMER'
            Properties.Options.Editing = False
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBEditorRow16: TcxDBEditorRow
            Properties.Caption = 'Model produs'
            Properties.DataBinding.FieldName = 'GOODS_MODEL'
            Properties.Options.Editing = False
            Properties.Options.ShowEditButtons = eisbAlways
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow1: TcxDBEditorRow
            Properties.Caption = 'Numar de serie'
            Properties.DataBinding.FieldName = 'GOODS_SN'
            Properties.Options.Editing = False
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow4: TcxDBEditorRow
            Properties.Caption = 'Cererea in reparatii'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Hint = #1053#1072#1081#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
                Kind = bkGlyph
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.EditProperties.OnButtonClick = cxDBVerticalGrid2DBEditorRow4EditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'GOODS_DOCID'
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow2: TcxDBEditorRow
            Properties.Caption = 'Statut'
            Properties.DataBinding.FieldName = 'STATUS_TITLE'
            Properties.Options.Editing = False
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow3: TcxDBEditorRow
            Properties.Caption = 'Documentul de vinzare'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Hint = #1053#1072#1081#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
                Kind = bkGlyph
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.EditProperties.OnButtonClick = cxDBVerticalGrid2DBEditorRow3EditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'RASHOD_DOCID'
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow5: TcxDBEditorRow
            Properties.Caption = 'Utilizator'
            Properties.DataBinding.FieldName = 'CREATED_FULL_NAME'
            Properties.Options.Editing = False
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object cxDBVerticalGrid2DBEditorRow6: TcxDBEditorRow
            Properties.Caption = 'Data crearii'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'CREATED_DATE'
            Properties.Options.Editing = False
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
        end
      end
      object tbsNotFound: TcxTabSheet
        Caption = 'Nimic nu a fost gasit'
        ImageIndex = 3
        object Label2: TLabel
          Left = 16
          Top = 24
          Width = 179
          Height = 105
          Caption = 
            'Nu a fost gasit nici un document! '#13#10#13#10#13#10'Cauta document - dupa nu' +
            'mar.  '#13#10'Factura fiscala - dupa numar. '#13#10'Contracte - Dupa codul n' +
            'umeric. '#13#10'Incidente - Dupa cod.'
        end
      end
      object tbsAWB: TcxTabSheet
        Caption = 'AWB'
        ImageIndex = 5
        object cxDBVerticalGrid4: TcxDBVerticalGrid
          Left = 0
          Top = 0
          Width = 529
          Height = 283
          Align = alClient
          OptionsView.ScrollBars = ssNone
          OptionsView.CategoryExplorerStyle = True
          OptionsView.RowHeaderWidth = 170
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.BandSizing = False
          OptionsBehavior.HeaderSizing = False
          OptionsBehavior.AllowChangeRecord = False
          OptionsData.Appending = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          Styles.Header = dmAdditions.cxStyle_Goods_GeneralHeader
          TabOrder = 0
          DataController.DataSource = IBCDataSourceAWB
          Version = 1
          object cxDBEditorRow24: TcxDBEditorRow
            Properties.Caption = 'Tip document'
            Properties.DataBinding.FieldName = 'DOCTYPE_NAME'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 0
            ParentID = -1
            Index = 0
            Version = 1
          end
          object cxDBEditorRow25: TcxDBEditorRow
            Properties.Caption = 'Cod document'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'DOCID'
            Properties.Options.Editing = False
            ID = 1
            ParentID = -1
            Index = 1
            Version = 1
          end
          object cxDBEditorRow26: TcxDBEditorRow
            Properties.Caption = 'Document parinte'
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Hint = #1048#1089#1082#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
                Kind = bkGlyph
                Stretchable = False
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.EditProperties.OnButtonClick = rowPARENTDOCIDEditPropertiesButtonClick
            Properties.DataBinding.FieldName = 'PARENTDOCID'
            Properties.Options.ShowEditButtons = eisbAlways
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 2
            ParentID = -1
            Index = 2
            Version = 1
          end
          object cxDBEditorRow27: TcxDBEditorRow
            Properties.Caption = 'Data'
            Properties.DataBinding.FieldName = 'DATA'
            Properties.Options.Editing = False
            ID = 3
            ParentID = -1
            Index = 3
            Version = 1
          end
          object cxDBEditorRow28: TcxDBEditorRow
            Properties.Caption = 'Subdiviziunea'
            Properties.DataBinding.FieldName = 'DT_NAME'
            Properties.Options.Editing = False
            ID = 4
            ParentID = -1
            Index = 4
            Version = 1
          end
          object cxDBEditorRow29: TcxDBEditorRow
            Properties.Caption = 'Client'
            Properties.DataBinding.FieldName = 'CT_NAME'
            Properties.Options.Editing = False
            Styles.Content = dmAdditions.cxStyle_Bold
            ID = 5
            ParentID = -1
            Index = 5
            Version = 1
          end
          object cxDBEditorRow30: TcxDBEditorRow
            Properties.Caption = 'Valuta'
            Properties.DataBinding.FieldName = 'CURRENCY_NAME'
            Properties.Options.Editing = False
            ID = 6
            ParentID = -1
            Index = 6
            Version = 1
          end
          object cxDBEditorRow31: TcxDBEditorRow
            Properties.Caption = 'Suma'
            Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.DisplayFormat = '0.00'
            Properties.DataBinding.FieldName = 'SUMA'
            Properties.Options.Editing = False
            ID = 7
            ParentID = -1
            Index = 7
            Version = 1
          end
          object cxDBEditorRow32: TcxDBEditorRow
            Properties.Caption = 'Rata documentului'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'RATE'
            Properties.Options.Editing = False
            ID = 8
            ParentID = -1
            Index = 8
            Version = 1
          end
          object cxDBEditorRow33: TcxDBEditorRow
            Properties.Caption = 'Rata USD'
            Properties.EditPropertiesClassName = 'TcxLabelProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.DataBinding.FieldName = 'RATEUSD'
            Properties.Options.Editing = False
            ID = 9
            ParentID = -1
            Index = 9
            Version = 1
          end
          object cxDBEditorRow34: TcxDBEditorRow
            Properties.Caption = 'Utilizator'
            Properties.DataBinding.FieldName = 'CREATED_BY_NAME'
            Properties.Options.Editing = False
            ID = 10
            ParentID = -1
            Index = 10
            Version = 1
          end
          object cxDBEditorRow35: TcxDBEditorRow
            Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
            Properties.EditProperties.Alignment.Horz = taLeftJustify
            Properties.EditProperties.Buttons = <
              item
                Default = True
                ImageIndex = 4
                Kind = bkGlyph
              end>
            Properties.EditProperties.ClickKey = 0
            Properties.EditProperties.Images = dmAdditions.cxImageList_SWN
            Properties.EditProperties.ReadOnly = True
            Properties.EditProperties.ViewStyle = vsHideCursor
            Properties.DataBinding.FieldName = 'AWB'
            Properties.Options.ShowEditButtons = eisbAlways
            Styles.Content = dmAdditions.cxStyle_TextColorGreen
            ID = 11
            ParentID = -1
            Index = 11
            Version = 1
          end
        end
      end
    end
    object cxGridH: TcxGrid
      Left = 568
      Top = 80
      Width = 261
      Height = 289
      TabOrder = 3
      object cxGridHTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        OnCellDblClick = cxGridHTableCellDblClick
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.InvertSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridHTable_COD: TcxGridColumn
          Caption = 'Cod'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Width = 50
        end
        object cxGridHTable_TEXT: TcxGridColumn
          Caption = 'Tip document'
        end
        object cxGridHTable_DOCTYPE: TcxGridColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          MinWidth = 30
          Options.HorzSizing = False
          VisibleForCustomization = False
          Width = 30
        end
        object cxGridHTable_ISNEW: TcxGridColumn
          DataBinding.ValueType = 'Boolean'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridHLevel: TcxGridLevel
        GridView = cxGridHTable
      end
    end
  end
  object btnGotoDoc: TButton
    Left = 611
    Top = 508
    Width = 134
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Treci la document'
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 760
    Top = 508
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryDOCS: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '  VW_TDB_DOCS.*,'
      '  SC_INCIDENTE.INCIDENTID,'
      '  z.waybillid, '
      '  z.curier_name,'
      
        '  IIF(SC_INCIDENTE.INCIDENTID IS NOT NULL,(SELECT TITLE FROM TS_' +
        'SYSS WHERE SYSSID=SC_INCIDENTE.TYPE_ID),NULL) INCIDENT_TYPE'
      'FROM VW_TDB_DOCS'
      
        'LEFT OUTER JOIN SC_INCIDENTE ON SC_INCIDENTE.GOODS_DOCID=VW_TDB_' +
        'DOCS.DOCID'
      
        'left outer join (select w.waybillid, w.curier_name from vw_tdb_w' +
        'aybill w'
      
        'join tdb_waybill_items wi on  wi.waybillid=w.waybillid and wi.do' +
        'cid_rashod=:docid) z on 1=1'
      'WHERE DOCID=:DOCID')
    ReadOnly = True
    Left = 64
    Top = 428
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceDOCS: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryDOCS
    Left = 60
    Top = 484
  end
  object IBCQueryINVOICE: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_INVOICES'
      'WHERE INVOICEID=:INVOICEID')
    ReadOnly = True
    Left = 180
    Top = 428
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INVOICEID'
        Value = nil
      end>
  end
  object IBCDataSourceINVOICE: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryINVOICE
    Left = 180
    Top = 484
  end
  object IBCQueryCONTRACT: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_TDB_CONTRACTS'
      'WHERE CONTRACTID=:CONTRACTID')
    ReadOnly = True
    Left = 308
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CONTRACTID'
        Value = nil
      end>
  end
  object IBCDataSourceCONTRACT: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryCONTRACT
    Left = 308
    Top = 488
  end
  object IBCQueryINCIDENTE: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM VW_SC_INCIDENTE'
      'WHERE INCIDENTID=:INCIDENTID')
    ReadOnly = True
    Left = 436
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'INCIDENTID'
        Value = nil
      end>
  end
  object IBCDataSourceINCIDENTE: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryINCIDENTE
    Left = 436
    Top = 488
  end
  object dxBarManager1: TdxBarManager
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
    Left = 560
    Top = 8
    PixelsPerInch = 96
    object bbClearHistory: TdxBarButton
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1087#1086#1080#1089#1082#1086#1074'...'
      Category = 0
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1080#1089#1090#1086#1088#1080#1102' '#1087#1086#1080#1089#1082#1086#1074
      Visible = ivAlways
      ImageIndex = 35
      OnClick = bbClearHistoryClick
    end
  end
  object dxBarPopupMenuH: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbClearHistory'
      end>
    UseOwnFont = False
    Left = 704
    Top = 248
    PixelsPerInch = 96
  end
  object cxGridHPopupMenu: TcxGridPopupMenu
    Grid = cxGridH
    PopupMenus = <
      item
        GridView = cxGridHTable
        HitTypes = [gvhtCell, gvhtRecord]
        Index = 0
        PopupMenu = dxBarPopupMenuH
      end>
    Left = 704
    Top = 196
  end
  object IBCQueryAWB: TIBCQuery
    SQL.Strings = (
      'select d.* from vw_tdb_docs d where docid = ('
      'SELECT'
      '  dd.docid'
      'FROM TDB_DOCS d'
      'JOIN tdb_docs_delivery dd on d.docid = dd.docid and dd.awb=:awb)'
      ''
      '')
    Left = 552
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'awb'
        Value = nil
      end>
  end
  object IBCDataSourceAWB: TIBCDataSource
    DataSet = IBCQueryAWB
    Left = 552
    Top = 504
  end
end
