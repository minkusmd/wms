inherited frame82Livrari: Tframe82Livrari
  Width = 1017
  Height = 697
  Margins.Left = 4
  Margins.Top = 4
  Margins.Right = 4
  Margins.Bottom = 4
  Font.Height = -12
  ExplicitWidth = 1017
  ExplicitHeight = 697
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 366
    Height = 697
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alLeft
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxGridLivrari: TcxGrid
      Left = 0
      Top = 0
      Width = 362
      Height = 431
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      PopupMenu = dxBarPopupMenuLivrari
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = -4
      object cxGridLivrari_WAYBILL: TcxGridDBTableView
        OnCustomDrawCell = cxGridLivrari_WAYBILLCustomDrawCell
        DataController.DataModeController.GridMode = True
        DataController.DataSource = IBCDataSourceWaybill
        DataController.KeyFieldNames = 'WAYBILLID'
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.CopyRecordsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Indicator = True
        object cxGridLivrari_WAYBILLFLG_CLOSED: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 19
        end
        object cxGridLivrari_WAYBILLWAYBILLID: TcxGridDBColumn
          Caption = 'No'
          DataBinding.FieldName = 'WAYBILLID'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridLivrari_WAYBILLCURIERID: TcxGridDBColumn
          DataBinding.FieldName = 'CURIERID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridLivrari_WAYBILLCREATED_DATE: TcxGridDBColumn
          Caption = 'Creat la'
          DataBinding.FieldName = 'CREATED_DATE'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridLivrari_WAYBILLDATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 64
        end
        object cxGridLivrari_WAYBILLCOURIER_NAME: TcxGridDBColumn
          Caption = 'Curier'
          DataBinding.FieldName = 'CURIER_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 160
        end
        object cxGridLivrari_WAYBILLTRANSPORTID: TcxGridDBColumn
          DataBinding.FieldName = 'TRANSPORTID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridLivrari_WAYBILLTRANSPORT_NAME: TcxGridDBColumn
          Caption = 'Transport'
          DataBinding.FieldName = 'TRANSPORT_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 160
        end
        object cxGridLivrari_WAYBILLSC: TcxGridDBColumn
          DataBinding.FieldName = 'SC'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridLivrari_WAYBILLCREATED_BY: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_BY'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
        end
        object cxGridLivrari_WAYBILLCREATED_BY_NAME: TcxGridDBColumn
          Caption = 'Utilizator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 80
        end
      end
      object cxGridLivrariLevel1: TcxGridLevel
        GridView = cxGridLivrari_WAYBILL
      end
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 456
      Width = 362
      Height = 237
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      TabOrder = 2
      object cxGridDBTableView1: TcxGridDBTableView
        PopupMenu = dxBarPopupMenuWaybillItems
        OnDblClick = cxGridDBTableView1DblClick
        OnKeyDown = cxGridDBTableView1KeyDown
        Navigator.Buttons.First.Visible = False
        Navigator.Buttons.PriorPage.Visible = False
        Navigator.Buttons.Prior.Visible = False
        Navigator.Buttons.Next.Visible = False
        Navigator.Buttons.NextPage.Visible = False
        Navigator.Buttons.Last.Visible = False
        Navigator.Buttons.Insert.Visible = False
        Navigator.Buttons.Delete.Visible = False
        Navigator.Buttons.Edit.Visible = False
        Navigator.Buttons.Post.Visible = False
        Navigator.Buttons.Cancel.Visible = False
        Navigator.Buttons.SaveBookmark.Visible = False
        Navigator.Buttons.GotoBookmark.Visible = False
        Navigator.Buttons.Filter.Visible = False
        Navigator.InfoPanel.Visible = True
        Navigator.Visible = True
        OnEditKeyDown = cxGridDBTableView1EditKeyDown
        DataController.DataSource = IBCDataSourceWayBillItems
        DataController.KeyFieldNames = 'DOCID_RASHOD'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridDBTableView1SUMA_REZERAV
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridDBTableView1Column2
          end
          item
            Format = '0.00'
            Kind = skSum
            Column = cxGridDBTableView1Column1
          end>
        OptionsBehavior.CopyCaptionsToClipboard = False
        OptionsBehavior.CopyRecordsToClipboard = False
        OptionsBehavior.IncSearch = True
        OptionsBehavior.CopyPreviewToClipboard = False
        OptionsBehavior.ImmediateEditor = False
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBTableView1WAYBILLID: TcxGridDBColumn
          DataBinding.FieldName = 'WAYBILLID'
          Visible = False
          MinWidth = 16
        end
        object cxGridDBTableView1FLG_CLOSED: TcxGridDBColumn
          Caption = 'I'
          DataBinding.FieldName = 'FLG_CLOSED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.Editing = False
          Options.ExpressionEditing = False
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBTableView1DOCID_RASHOD: TcxGridDBColumn
          Caption = 'Nr. Rezerva'
          DataBinding.FieldName = 'DOCID_RASHOD'
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.Editing = False
          Options.ExpressionEditing = False
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridDBTableView1CUSTOMER_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CUSTOMER_NAME'
          HeaderAlignmentHorz = taCenter
          MinWidth = 128
          Options.Editing = False
          Options.ExpressionEditing = False
          Options.HorzSizing = False
          Width = 128
        end
        object cxGridDBTableView1SUMA_REZERAV: TcxGridDBColumn
          Caption = 'Suma V.'
          DataBinding.FieldName = 'SUMA_RASHOD_MDL'
          MinWidth = 51
          Options.Editing = False
          Options.ExpressionEditing = False
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridDBTableView1DOCID_RAMBURS: TcxGridDBColumn
          Caption = 'Nr. Incasare'
          DataBinding.FieldName = 'DOCID_RAMBURS'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 51
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridDBTableView1SUMA_RAMBURS: TcxGridDBColumn
          Caption = 'Suma R.'
          DataBinding.FieldName = 'SUMA_RAMBURS_MDL'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
          Width = 51
        end
        object cxGridDBTableView1CUSTOMERID: TcxGridDBColumn
          DataBinding.FieldName = 'CUSTOMERID'
          Visible = False
          MinWidth = 16
        end
        object cxGridDBTableView1CREATED_BY: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'CREATED_BY'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 106
          Options.HorzSizing = False
          Width = 106
        end
        object cxGridDBTableView1Column1: TcxGridDBColumn
          Caption = 'Ramburs'
          DataBinding.FieldName = 'SUMA_RAMBURS_MDL'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '0.00'
          MinWidth = 51
          Options.Editing = False
          Options.ExpressionEditing = False
          Options.HorzSizing = False
          Width = 51
        end
        object cxGridDBTableView1Column2: TcxGridDBColumn
          Caption = 'Pret Livr.'
          DataBinding.FieldName = 'SUMA_LIVRARE'
          PropertiesClassName = 'TcxCalcEditProperties'
          Properties.DisplayFormat = '0.00'
          MinWidth = 64
          Options.IncSearch = False
          Options.HorzSizing = False
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
    object dxBarDockControl1: TdxBarDockControl
      Left = 0
      Top = 431
      Width = 362
      Height = 25
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = dalBottom
      BarManager = dxBarManager
    end
  end
  object Panel2: TPanel
    Left = 366
    Top = 0
    Width = 651
    Height = 697
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      647
      693)
    object cxGrid2: TcxGrid
      Left = 29
      Top = -2
      Width = 617
      Height = 363
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      object cxGrid2DBTableView1: TcxGridDBTableView
        OnDblClick = cxGrid2DBTableView1DblClick
        OnKeyDown = cxGrid2DBTableView1KeyDown
        DataController.DataSource = IBCDataSourceOpenedWayBills
        OptionsBehavior.IncSearch = True
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        object cxGrid2DBTableView1DOCID: TcxGridDBColumn
          Caption = 'Cod doc'
          DataBinding.FieldName = 'DOCID'
          MinWidth = 16
          Width = 66
        end
        object cxGrid2DBTableView1DeliveryType: TcxGridDBColumn
          DataBinding.FieldName = 'FLG_WITH_DELIVERY'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageDocs
          Properties.Items = <
            item
              Description = 'Livrare mun. Chisinau'
              ImageIndex = 0
              Value = 1
            end
            item
              Description = 'Livrare RM'
              ImageIndex = 2
              Value = 2
            end>
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
          IsCaptionAssigned = True
        end
        object cxGrid2DBTableView1DOCTYPE_NAME: TcxGridDBColumn
          Caption = 'Tip document'
          DataBinding.FieldName = 'DOCTYPE_NAME'
          MinWidth = 16
          Width = 106
        end
        object cxGrid2DBTableView1DATA: TcxGridDBColumn
          Caption = 'Data'
          DataBinding.FieldName = 'DATA'
          MinWidth = 16
          Width = 54
        end
        object cxGrid2DBTableView1CREATED_DATE: TcxGridDBColumn
          Caption = 'Data crearii'
          DataBinding.FieldName = 'CREATED_DATE'
          MinWidth = 16
          Width = 56
        end
        object cxGrid2DBTableView1DISTRICTID: TcxGridDBColumn
          DataBinding.FieldName = 'DISTRICTID'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGrid2DBTableView1DISTRICT_NAME: TcxGridDBColumn
          Caption = 'Oras'
          DataBinding.FieldName = 'DISTRICT_NAME'
          MinWidth = 16
          Width = 102
        end
        object cxGrid2DBTableView1CITYID: TcxGridDBColumn
          DataBinding.FieldName = 'CITYID'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGrid2DBTableView1CITY_NAME: TcxGridDBColumn
          Caption = 'Raion'
          DataBinding.FieldName = 'CITY_NAME'
          MinWidth = 16
          Width = 116
        end
        object cxGrid2DBTableView1CT: TcxGridDBColumn
          DataBinding.FieldName = 'CT'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGrid2DBTableView1CT_NAME: TcxGridDBColumn
          Caption = 'Client'
          DataBinding.FieldName = 'CT_NAME'
          MinWidth = 16
          Width = 126
        end
        object cxGrid2DBTableView1CREATED_BY: TcxGridDBColumn
          DataBinding.FieldName = 'CREATED_BY'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGrid2DBTableView1CREATEDBY_NAME: TcxGridDBColumn
          Caption = 'Operator'
          DataBinding.FieldName = 'CREATEDBY_NAME'
          MinWidth = 16
          Width = 117
        end
        object cxGrid2DBTableView1SUMA: TcxGridDBColumn
          Caption = 'Suma'
          DataBinding.FieldName = 'SUMA'
          MinWidth = 16
          Width = 46
        end
        object cxGrid2DBTableView1DELIVERY_ADDRESS: TcxGridDBColumn
          Caption = 'Adresa'
          DataBinding.FieldName = 'DELIVERY_ADDRESS'
          MinWidth = 16
          Width = 179
        end
      end
      object cxGrid2Level1: TcxGridLevel
        GridView = cxGrid2DBTableView1
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 24
      Height = 693
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alLeft
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      TabOrder = 1
      object cxButton1: TcxButton
        Left = 2
        Top = 178
        Width = 22
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '<'
        OptionsImage.Spacing = 3
        TabOrder = 1
        OnClick = cxButton1Click
      end
      object cxButton2: TcxButton
        Left = 2
        Top = 146
        Width = 22
        Height = 20
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = '>'
        OptionsImage.Spacing = 3
        TabOrder = 0
        OnClick = cxButton2Click
      end
    end
    object cxGridComponents: TcxGrid
      Left = 29
      Top = 366
      Width = 620
      Height = 168
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akRight, akBottom]
      BorderWidth = 1
      TabOrder = 2
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridComponentsTable: TcxGridDBTableView
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
        DataController.DataSource = IBCDataSourceJurnal
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridDBCol_QTY
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMA'
            Column = cxGridDBCol_SUMA
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMAVAT'
            Column = cxGridDBCol_SUMAVAT
          end
          item
            Kind = skCount
            Column = cxGridDBCol_GOODSID
          end
          item
            Format = '-0.00'
            Kind = skSum
            Column = cxGridComponents_DISCOUNT_SUMA
          end
          item
            Format = '$0.00'
            Kind = skSum
            Column = cxGridComponents_SUMA_USD
          end>
        Images = dmAdditions.ilGoodsProperties
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBCol_DTDEP_NAME: TcxGridDBColumn
          Caption = 'depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 48
          Width = 80
        end
        object cxGridDBCol_GOODSID: TcxGridDBColumn
          Caption = 'id'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBCol_IMG: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList1
          Properties.Items = <>
          MinWidth = 19
          Options.Editing = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 19
          IsCaptionAssigned = True
        end
        object cxGridComponentsTable_FLG_FA: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'flg_forced_addon'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilFlags
          Properties.Items = <
            item
              ImageIndex = 1
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.Focusing = False
          Options.IncSearch = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 16
        end
        object cxGridComponents_FLG_SUPPLIER_PROMO: TcxGridDBColumn
          Caption = 'P'
          DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilGoodsProperties
          Properties.Items = <
            item
              Description = 'Promotie Furnizor'
              ImageIndex = 4
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 16
        end
        object cxGridComponents_FLG_PROMO: TcxGridDBColumn
          Caption = 'FP'
          DataBinding.FieldName = 'FLG_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilGoodsProperties
          Properties.Items = <
            item
              ImageIndex = 6
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBCol_GOODS_NAME: TcxGridDBColumn
          Caption = 'produs'
          DataBinding.FieldName = 'GOODS_NAME'
          MinWidth = 16
          Width = 240
        end
        object cxGridDBCol_QTY: TcxGridDBColumn
          AlternateCaption = 'cantitate'
          Caption = 'cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridComponents_UMID: TcxGridDBColumn
          DataBinding.FieldName = 'UMID'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGridComponents_FLG_FORCED: TcxGridDBColumn
          Caption = 'f'
          DataBinding.FieldName = 'FLG_FORCED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 16
        end
        object cxGridDBCol_UM_NAME: TcxGridDBColumn
          AlternateCaption = 'unitate metrica'
          Caption = 'um'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 26
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 26
        end
        object cxGridDBCol_PRICE: TcxGridDBColumn
          Caption = 'pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridComponents_PRICE_USD: TcxGridDBColumn
          Caption = #1062#1077#1085#1072' USD'
          DataBinding.FieldName = 'PRICE_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridComponents_DISCOUNT_P: TcxGridDBColumn
          AlternateCaption = #1057#1082#1080#1076#1082#1072', %'
          Caption = '-%'
          DataBinding.FieldName = 'DISCOUNT_P'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '-0%'
          Properties.Nullstring = ' '
          Properties.UseNullString = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
        object cxGridComponents_DISCOUNT_SUMA: TcxGridDBColumn
          Caption = #1057#1082#1080#1076#1082#1072
          DataBinding.FieldName = 'DISCOUNT_SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '-0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBCol_SUMA: TcxGridDBColumn
          Caption = 'suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 56
        end
        object cxGridComponents_SUMA_USD: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072' USD'
          DataBinding.FieldName = 'SUMA_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBCol_SUMAVAT: TcxGridDBColumn
          Caption = 'tva'
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBCol_GOODS_TYPE_ID: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGridDBCol_FLG_ACTIVE: TcxGridDBColumn
          AlternateCaption = 'activ'
          Caption = 'act'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBCol_FLG_READY: TcxGridDBColumn
          AlternateCaption = 'gata'
          Caption = 'g'
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBCol_STOCK_QTY: TcxGridDBColumn
          AlternateCaption = 'sold'
          Caption = 'sold'
          DataBinding.FieldName = 'STOCK_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
        object cxGridComponents_PRICE_COLUMN: TcxGridDBColumn
          AlternateCaption = 'grila de preturi'
          Caption = 'gp'
          DataBinding.FieldName = 'PRICE_COLUMN'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridComponents_CREATED_BY_NAME: TcxGridDBColumn
          AlternateCaption = 'utilizator'
          Caption = 'utilizator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          BestFitMaxWidth = 120
          MinWidth = 80
          Options.Editing = False
          Options.Focusing = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 80
        end
        object cxGridComponents_GOODS_ACNT_ID: TcxGridDBColumn
          AlternateCaption = 'id cntb'
          Caption = 'id cntb'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridComponents_GOODS_NAMEACNT: TcxGridDBColumn
          Caption = 'denumire cntb'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          Visible = False
          MinWidth = 40
          Width = 56
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridComponentsTable
      end
    end
    object cxGrid3: TcxGrid
      Left = 29
      Top = 539
      Width = 617
      Height = 148
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Anchors = [akLeft, akRight, akBottom]
      BorderWidth = 1
      TabOrder = 3
      LookAndFeel.NativeStyle = True
      LookAndFeel.SkinName = ''
      object cxGridDBTableView2: TcxGridDBTableView
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
        DataController.DataSource = IBCDataSourceJurnalLivrari
        DataController.KeyFieldNames = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            FieldName = 'QTY'
            Column = cxGridDBColumn8
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMA'
            Column = cxGridDBColumn16
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            FieldName = 'SUMAVAT'
            Column = cxGridDBColumn18
          end
          item
            Kind = skCount
            Column = cxGridDBColumn2
          end
          item
            Format = '-0.00'
            Kind = skSum
            Column = cxGridDBColumn15
          end
          item
            Format = '$0.00'
            Kind = skSum
            Column = cxGridDBColumn17
          end>
        Images = dmAdditions.ilGoodsProperties
        OptionsBehavior.IncSearch = True
        OptionsBehavior.ImmediateEditor = False
        OptionsCustomize.ColumnsQuickCustomization = True
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.InvertSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBColumn1: TcxGridDBColumn
          Caption = 'depozit'
          DataBinding.FieldName = 'DTDEP_NAME'
          MinWidth = 48
          Width = 80
        end
        object cxGridDBColumn2: TcxGridDBColumn
          Caption = 'id'
          DataBinding.FieldName = 'GOODSID'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBColumn3: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.cxImageList1
          Properties.Items = <>
          MinWidth = 19
          Options.Editing = False
          Options.Focusing = False
          Options.IncSearch = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.ShowCaption = False
          Options.Sorting = False
          VisibleForCustomization = False
          Width = 19
          IsCaptionAssigned = True
        end
        object cxGridDBColumn4: TcxGridDBColumn
          Caption = '...'
          DataBinding.FieldName = 'flg_forced_addon'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilFlags
          Properties.Items = <
            item
              ImageIndex = 1
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.Focusing = False
          Options.IncSearch = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 16
        end
        object cxGridDBColumn5: TcxGridDBColumn
          Caption = 'P'
          DataBinding.FieldName = 'FLG_SUPPLIER_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilGoodsProperties
          Properties.Items = <
            item
              Description = 'Promotie Furnizor'
              ImageIndex = 4
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 16
        end
        object cxGridDBColumn6: TcxGridDBColumn
          Caption = 'FP'
          DataBinding.FieldName = 'FLG_PROMO'
          PropertiesClassName = 'TcxImageComboBoxProperties'
          Properties.Images = dmAdditions.ilGoodsProperties
          Properties.Items = <
            item
              ImageIndex = 6
              Value = 1
            end>
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.Grouping = False
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBColumn7: TcxGridDBColumn
          Caption = 'produs'
          DataBinding.FieldName = 'GOODS_NAME'
          MinWidth = 16
          Width = 240
        end
        object cxGridDBColumn8: TcxGridDBColumn
          AlternateCaption = 'cantitate'
          Caption = 'cant'
          DataBinding.FieldName = 'QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBColumn9: TcxGridDBColumn
          DataBinding.FieldName = 'UMID'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGridDBColumn10: TcxGridDBColumn
          Caption = 'f'
          DataBinding.FieldName = 'FLG_FORCED'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 16
          Width = 16
        end
        object cxGridDBColumn11: TcxGridDBColumn
          AlternateCaption = 'unitate metrica'
          Caption = 'um'
          DataBinding.FieldName = 'UM_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 26
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 26
        end
        object cxGridDBColumn12: TcxGridDBColumn
          Caption = 'pret'
          DataBinding.FieldName = 'PRICE'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBColumn13: TcxGridDBColumn
          Caption = #1062#1077#1085#1072' USD'
          DataBinding.FieldName = 'PRICE_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBColumn14: TcxGridDBColumn
          AlternateCaption = #1057#1082#1080#1076#1082#1072', %'
          Caption = '-%'
          DataBinding.FieldName = 'DISCOUNT_P'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '-0%'
          Properties.Nullstring = ' '
          Properties.UseNullString = True
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
        object cxGridDBColumn15: TcxGridDBColumn
          Caption = #1057#1082#1080#1076#1082#1072
          DataBinding.FieldName = 'DISCOUNT_SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '-0.00'
          Visible = False
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBColumn16: TcxGridDBColumn
          Caption = 'suma'
          DataBinding.FieldName = 'SUMA'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_MoneyCounter_Total
          Width = 56
        end
        object cxGridDBColumn17: TcxGridDBColumn
          Caption = #1057#1091#1084#1084#1072' USD'
          DataBinding.FieldName = 'SUMA_USD'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 56
          Options.HorzSizing = False
          Width = 56
        end
        object cxGridDBColumn18: TcxGridDBColumn
          Caption = 'tva'
          DataBinding.FieldName = 'SUMAVAT'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBColumn19: TcxGridDBColumn
          DataBinding.FieldName = 'GOODS_TYPE_ID'
          Visible = False
          MinWidth = 16
          VisibleForCustomization = False
        end
        object cxGridDBColumn20: TcxGridDBColumn
          AlternateCaption = 'activ'
          Caption = 'act'
          DataBinding.FieldName = 'FLG_ACTIVE'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBColumn21: TcxGridDBColumn
          AlternateCaption = 'gata'
          Caption = 'g'
          DataBinding.FieldName = 'FLG_READY'
          PropertiesClassName = 'TcxCheckBoxProperties'
          Properties.ValueChecked = '1'
          Properties.ValueUnchecked = '0'
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBColumn22: TcxGridDBColumn
          AlternateCaption = 'sold'
          Caption = 'sold'
          DataBinding.FieldName = 'STOCK_QTY'
          PropertiesClassName = 'TcxCalcEditProperties'
          HeaderAlignmentHorz = taCenter
          MinWidth = 32
          Options.HorzSizing = False
          Width = 32
        end
        object cxGridDBColumn23: TcxGridDBColumn
          AlternateCaption = 'grila de preturi'
          Caption = 'gp'
          DataBinding.FieldName = 'PRICE_COLUMN'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 19
          Options.HorzSizing = False
          Width = 19
        end
        object cxGridDBColumn24: TcxGridDBColumn
          AlternateCaption = 'utilizator'
          Caption = 'utilizator'
          DataBinding.FieldName = 'CREATED_BY_NAME'
          BestFitMaxWidth = 120
          MinWidth = 80
          Options.Editing = False
          Options.Focusing = False
          Options.FilteringFilteredItemsList = False
          Options.FilteringMRUItemsList = False
          Options.FilteringPopup = False
          Options.FilteringPopupMultiSelect = False
          Options.GroupFooters = False
          Options.Grouping = False
          Options.HorzSizing = False
          Options.Sorting = False
          Width = 80
        end
        object cxGridDBColumn25: TcxGridDBColumn
          AlternateCaption = 'id cntb'
          Caption = 'id cntb'
          DataBinding.FieldName = 'GOODS_ACNT_ID'
          Visible = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridDBColumn26: TcxGridDBColumn
          Caption = 'denumire cntb'
          DataBinding.FieldName = 'GOODS_NAMEACNT'
          Visible = False
          MinWidth = 40
          Width = 56
        end
      end
      object cxGridLevel2: TcxGridLevel
        GridView = cxGridDBTableView2
      end
    end
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
    Left = 552
    Top = 92
    PixelsPerInch = 96
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 1
      DockedTop = 0
      FloatLeft = 1122
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbPrintReceipe: TdxBarButton
      Caption = 'Tipar "Bon fiscal"'
      Category = 0
      Hint = 'Tipar "Bon fiscal"'
      Visible = ivAlways
      ImageIndex = 47
    end
    object bbCloseDoc: TdxBarButton
      Caption = 'Inchide document'
      Category = 0
      Hint = 'Inchide document'
      Visible = ivAlways
      ImageIndex = 43
      ShortCut = 120
      OnClick = bbCloseDocClick
    end
    object bbOpenDoc: TdxBarButton
      Caption = 'Deschide document'
      Category = 0
      Hint = 'Deschide document'
      Visible = ivAlways
      ShortCut = 8312
      OnClick = bbOpenDocClick
    end
    object bbCloseDelivery: TdxBarButton
      Caption = 'Seteaza toate livrarile ca reusite ...'
      Category = 0
      Hint = 'Seteaza toate livrarile ca reusite '
      Visible = ivAlways
      OnClick = bbCloseDeliveryClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Livrare'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbCloseDelivery'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end>
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Livrare anulata'
      Category = 0
      Hint = 'Livrare anulata'
      Visible = ivAlways
      OnClick = dxBarButton1Click
    end
    object dxBarButton2: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
      OnClick = dxBarButton2Click
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Livrare noua'
      Category = 0
      Hint = 'Livrare noua'
      Visible = ivAlways
      OnClick = dxBarButton3Click
    end
  end
  object dxBarPopupMenuLivrari: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDoc'
      end
      item
        Visible = True
        ItemName = 'bbOpenDoc'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuLivrariPopup
    Left = 328
    Top = 152
    PixelsPerInch = 96
  end
  object IBCQueryWaybill: TIBCQuery
    KeyFields = 'WAYBILLID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_WAYBILL'
      
        '  (WAYBILLID, CURIERID, CURIER_NAME, TRANSPORTID, TRANSPORT_NAME' +
        ', DATA, SC, SC_NAME, FLG_CLOSED, CREATED_DATE, CREATED_BY, CREAT' +
        'ED_BY_NAME)'
      'VALUES'
      
        '  (:WAYBILLID, :CURIERID, :CURIER_NAME, :TRANSPORTID, :TRANSPORT' +
        '_NAME, :DATA, :SC, :SC_NAME, :FLG_CLOSED, :CREATED_DATE, :CREATE' +
        'D_BY, :CREATED_BY_NAME)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_WAYBILL'
      'WHERE'
      '  WAYBILLID = :Old_WAYBILLID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_WAYBILL'
      'SET'
      
        '  WAYBILLID = :WAYBILLID, CURIERID = :CURIERID, CURIER_NAME = :C' +
        'URIER_NAME, TRANSPORTID = :TRANSPORTID, TRANSPORT_NAME = :TRANSP' +
        'ORT_NAME, DATA = :DATA, SC = :SC, SC_NAME = :SC_NAME, FLG_CLOSED' +
        ' = :FLG_CLOSED, CREATED_DATE = :CREATED_DATE, CREATED_BY = :CREA' +
        'TED_BY, CREATED_BY_NAME = :CREATED_BY_NAME'
      'WHERE'
      '  WAYBILLID = :Old_WAYBILLID')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_WAYBILL'
      'WHERE'
      '  WAYBILLID = :WAYBILLID')
    SQLLock.Strings = (
      'SELECT NULL FROM VW_TDB_WAYBILL'
      'WHERE'
      'WAYBILLID = :Old_WAYBILLID'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_WAYBILL'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'select first 60 * from vw_tdb_waybill'
      'order by data desc')
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.StrictUpdate = False
    LocalConstraints = False
    Left = 184
    Top = 80
  end
  object IBCDataSourceWaybill: TIBCDataSource
    DataSet = IBCQueryWaybill
    Left = 48
    Top = 80
  end
  object IBCQueryWaybillItems: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_WAYBILL_ITEMS'
      
        '  (WAYBILLID, DOCID_RASHOD, DOCID_RAMBURS, FLG_CLOSED, CUSTOMERI' +
        'D, CUSTOMER_NAME, DELIVERY_ADRESSID, DELIVERY_ADDRESS, CREATED_B' +
        'Y, CREATED_BY_NAME, suma_livrare)'
      'VALUES'
      
        '  (:WAYBILLID, :DOCID_RASHOD, :DOCID_RAMBURS, :FLG_CLOSED, :CUST' +
        'OMERID, :CUSTOMER_NAME, :DELIVERY_ADRESSID, :DELIVERY_ADDRESS, :' +
        'CREATED_BY, :CREATED_BY_NAME, :suma_livrare)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_WAYBILL_ITEMS'
      'WHERE'
      
        '  WAYBILLID = :Old_WAYBILLID AND DOCID_RASHOD = :Old_DOCID_RASHO' +
        'D')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_WAYBILL_ITEMS'
      'SET'
      
        '  WAYBILLID = :WAYBILLID, DOCID_RASHOD = :DOCID_RASHOD, DOCID_RA' +
        'MBURS = :DOCID_RAMBURS, '
      
        '  FLG_CLOSED = :FLG_CLOSED, CUSTOMERID = :CUSTOMERID, CUSTOMER_N' +
        'AME = :CUSTOMER_NAME, '
      
        '  DELIVERY_ADRESSID = :DELIVERY_ADRESSID, DELIVERY_ADDRESS = :DE' +
        'LIVERY_ADDRESS, '
      
        '  CREATED_BY = :CREATED_BY, CREATED_BY_NAME = :CREATED_BY_NAME, ' +
        'suma_livrare = :suma_livrare'
      'WHERE'
      
        '  WAYBILLID = :Old_WAYBILLID AND DOCID_RASHOD = :Old_DOCID_RASHO' +
        'D')
    SQLRefresh.Strings = (
      'SELECT * FROM VW_TDB_WAYBILL_ITEMS'
      'WHERE'
      '  WAYBILLID = :WAYBILLID AND DOCID_RASHOD = :DOCID_RASHOD')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_WAYBILL_ITEMS'
      'WHERE'
      'WAYBILLID = :Old_WAYBILLID AND DOCID_RASHOD = :Old_DOCID_RASHOD'
      'FOR UPDATE WITH LOCK')
    SQLRecCount.Strings = (
      'SELECT COUNT(*) FROM ('
      'SELECT 1 AS C  FROM VW_TDB_WAYBILL_ITEMS'
      ''
      ') q')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultUpdate
    SQL.Strings = (
      'SELECT * FROM VW_TDB_WAYBILL_ITEMS')
    MasterFields = 'WAYBILLID'
    DetailFields = 'WAYBILLID'
    MasterSource = IBCDataSourceWaybill
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.StrictUpdate = False
    Left = 96
    Top = 464
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'WAYBILLID'
        Value = nil
      end>
  end
  object IBCDataSourceWayBillItems: TIBCDataSource
    DataSet = IBCQueryWaybillItems
    Left = 96
    Top = 408
  end
  object IBCQueryOpenedWaybills: TIBCQuery
    SQLRefresh.Strings = (
      'select * from get_opened_waybills')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    UpdateTransaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'select * from get_opened_waybills(:dt)')
    Left = 568
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'dt'
        Value = nil
      end>
  end
  object IBCDataSourceOpenedWayBills: TIBCDataSource
    DataSet = IBCQueryOpenedWaybills
    Left = 568
    Top = 272
  end
  object IBCQueryJurnal: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND'
      ' CTDEP = :CTDEP AND'
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND'
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceOpenedWayBills
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 744
    Top = 376
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID'
        Value = nil
      end>
  end
  object IBCDataSourceJurnal: TIBCDataSource
    DataSet = IBCQueryJurnal
    Left = 744
    Top = 328
  end
  object dxBarPopupMenuWaybillItems: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'bbCloseDelivery'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButton1'
      end>
    UseOwnFont = False
    Left = 256
    Top = 528
    PixelsPerInch = 96
  end
  object IBCQueryJurnalLivrari: TIBCQuery
    KeyFields = 'DOCID;DTDEP;CTDEP;GOODSCOMPLECT_ID;GOODSID'
    SQLInsert.Strings = (
      'INSERT INTO VW_TDB_JURNAL'
      
        '  (DOCID, DTDEP, DTDEP_NAME, CTDEP, CTDEP_NAME, GOODSCOMPLECT_ID' +
        ', GOODSCOMPLECT_NAME, '
      '   GOODSID, GOODS_NAME, GOODS_TYPE_ID, '
      
        '   UMID, UM_NAME, QTY, PRICE, SUMA, SUMAVAT, WARRANTY, STOCK_QTY' +
        ', COST, '
      '   FLG_ACTIVE, FLG_ACNT, FLG_READY, FLG_DELETE)'
      'VALUES'
      
        '  (:DOCID, :DTDEP, :DTDEP_NAME, :CTDEP, :CTDEP_NAME, :GOODSCOMPL' +
        'ECT_ID, :GOODSCOMPLECT_NAME, '
      '   :GOODSID, :GOODS_NAME, :GOODS_TYPE_ID, '
      
        '   :UMID, :UM_NAME, :QTY, :PRICE, :SUMA, :SUMAVAT, :WARRANTY, :S' +
        'TOCK_QTY, :COST, '
      '   :FLG_ACTIVE, :FLG_ACNT, :FLG_READY, :FLG_DELETE)')
    SQLDelete.Strings = (
      'DELETE FROM VW_TDB_JURNAL'
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLUpdate.Strings = (
      'UPDATE VW_TDB_JURNAL'
      'SET'
      
        ' DOCID = :DOCID, DTDEP = :DTDEP, DTDEP_NAME = :DTDEP_NAME, CTDEP' +
        ' = :CTDEP, CTDEP_NAME = :CTDEP_NAME, '
      
        ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID, GOODSCOMPLECT_NAME = :GOO' +
        'DSCOMPLECT_NAME, '
      ' GOODSID = :GOODSID, GOODS_NAME = :GOODS_NAME, '
      
        ' GOODS_TYPE_ID = :GOODS_TYPE_ID, UMID = :UMID, UM_NAME = :UM_NAM' +
        'E, QTY = :QTY, '
      
        ' PRICE = :PRICE, SUMA = :SUMA, SUMAVAT = :SUMAVAT, WARRANTY = :W' +
        'ARRANTY, STOCK_QTY = :STOCK_QTY, '
      ' COST = :COST, '
      ''
      ' FLG_ACTIVE = :FLG_ACTIVE, '
      ' FLG_ACNT = :FLG_ACNT, '
      ' FLG_READY = :FLG_READY, '
      ' FLG_DELETE = :FLG_DELETE'
      ''
      'WHERE'
      
        '  DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTD' +
        'EP AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :O' +
        'ld_GOODSID')
    SQLRefresh.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' DOCID = :DOCID AND '
      ' DTDEP = :DTDEP AND'
      ' CTDEP = :CTDEP AND'
      ' GOODSCOMPLECT_ID = :GOODSCOMPLECT_ID AND'
      ' GOODSID = :GOODSID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_JURNAL'
      'WHERE'
      
        'DOCID = :Old_DOCID AND DTDEP = :Old_DTDEP AND CTDEP = :Old_CTDEP' +
        ' AND GOODSCOMPLECT_ID = :Old_GOODSCOMPLECT_ID AND GOODSID = :Old' +
        '_GOODSID'
      'FOR UPDATE WITH LOCK')
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_JURNAL.*,'
      
        ' IIF(ACNT_PRICE<PRICE_ACNT_LOW_BOUND OR ACNT_PRICE>PRICE_ACNT_HI' +
        'GH_BOUND,1,0) FLG_ACNT_PRICE_OUT_OF_BOUNDS'
      'FROM'
      ' VW_TDB_JURNAL'
      'WHERE'
      ' GOODSCOMPLECT_ID=-1')
    MasterFields = 'DOCID_RASHOD'
    DetailFields = 'DOCID'
    MasterSource = IBCDataSourceWayBillItems
    AutoCommit = False
    LockMode = lmLockImmediate
    RefreshOptions = [roAfterInsert, roAfterUpdate]
    Options.RequiredFields = False
    Options.DetailDelay = 50
    LocalConstraints = False
    Left = 568
    Top = 624
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DOCID_RASHOD'
        Value = nil
      end>
  end
  object IBCDataSourceJurnalLivrari: TIBCDataSource
    DataSet = IBCQueryJurnalLivrari
    Left = 568
    Top = 576
  end
end
