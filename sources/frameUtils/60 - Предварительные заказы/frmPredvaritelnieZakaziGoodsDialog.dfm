object frmPredvaritelnieZakaziGoodsDlg: TfrmPredvaritelnieZakaziGoodsDlg
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
  ClientHeight = 430
  ClientWidth = 645
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
    Width = 645
    Height = 64
    Title = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 629
    Height = 297
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 0
    Align = alTop
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object pnApproveInfo: TPanel
      Left = 0
      Top = 169
      Width = 625
      Height = 124
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object Label5: TLabel
        Left = 16
        Top = 9
        Width = 63
        Height = 15
        Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
      end
      object Label6: TLabel
        Left = 16
        Top = 70
        Width = 28
        Height = 15
        Caption = #1062#1077#1085#1072
      end
      object Label7: TLabel
        Left = 268
        Top = 70
        Width = 41
        Height = 15
        Caption = #1042#1072#1083#1102#1090#1072
      end
      object Label8: TLabel
        Left = 16
        Top = 41
        Width = 65
        Height = 15
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      end
      object lbPriceTitleSupplierToPreorder: TLabel
        Left = 490
        Top = 50
        Width = 28
        Height = 15
        Caption = #1062#1077#1085#1072
      end
      object beSupplier: TcxButtonEdit
        Left = 112
        Top = 6
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 13
            Kind = bkGlyph
          end>
        Properties.ClickKey = 115
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.ReadOnly = True
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = beSupplierPropertiesButtonClick
        TabOrder = 0
        Width = 497
      end
      object ceSUPPLIER_PRICE: TcxDBCalcEdit
        Left = 112
        Top = 67
        DataBinding.DataField = 'SUPPLIER_PRICE'
        Properties.Alignment.Horz = taLeftJustify
        Properties.DisplayFormat = '0.00'
        Properties.OnEditValueChanged = lcbSELL_CURRENCY_IDPropertiesEditValueChanged
        TabOrder = 1
        Width = 121
      end
      object lcbSUPRLIER_CURRENCY_ID: TcxDBLookupComboBox
        Left = 315
        Top = 67
        DataBinding.DataField = 'SUPRLIER_CURRENCY_ID'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceCurrency
        Properties.OnEditValueChanged = lcbSELL_CURRENCY_IDPropertiesEditValueChanged
        TabOrder = 2
        Width = 150
      end
      object ceSUPPLIER_QTY: TcxDBCalcEdit
        Left = 112
        Top = 38
        DataBinding.DataField = 'SUPPLIER_QTY'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 3
        Width = 121
      end
      object edPriceSupplierToPreorder: TcxCalcEdit
        Left = 490
        Top = 67
        TabStop = False
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        TabOrder = 4
        Width = 119
      end
    end
    object pnBaseInfo: TPanel
      Left = 0
      Top = 0
      Width = 625
      Height = 169
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object Label1: TLabel
        Left = 16
        Top = 24
        Width = 83
        Height = 15
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      end
      object Label2: TLabel
        Left = 16
        Top = 56
        Width = 65
        Height = 15
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      end
      object Label3: TLabel
        Left = 16
        Top = 85
        Width = 80
        Height = 15
        Caption = #1062#1077#1085#1072' '#1087#1088#1086#1076#1072#1078#1080
      end
      object Label4: TLabel
        Left = 268
        Top = 85
        Width = 41
        Height = 15
        Caption = #1042#1072#1083#1102#1090#1072
      end
      object lbPriceTitlePreorderToSupplier: TLabel
        Left = 490
        Top = 65
        Width = 28
        Height = 15
        Caption = #1062#1077#1085#1072
      end
      object beGoods: TcxButtonEdit
        Left = 112
        Top = 21
        Properties.Buttons = <
          item
            Default = True
            ImageIndex = 13
            Kind = bkGlyph
          end>
        Properties.ClickKey = 115
        Properties.Images = dmAdditions.cxImageList_SWN
        Properties.ReadOnly = True
        Properties.ViewStyle = vsHideCursor
        Properties.OnButtonClick = beGoodsPropertiesButtonClick
        TabOrder = 0
        Width = 497
      end
      object ceQTY: TcxDBCalcEdit
        Left = 112
        Top = 53
        DataBinding.DataField = 'QTY'
        Properties.Alignment.Horz = taLeftJustify
        TabOrder = 1
        Width = 121
      end
      object ceSELL_PRICE: TcxDBCalcEdit
        Left = 112
        Top = 82
        DataBinding.DataField = 'SELL_PRICE'
        Properties.Alignment.Horz = taLeftJustify
        Properties.DisplayFormat = '0.00'
        Properties.OnEditValueChanged = lcbSELL_CURRENCY_IDPropertiesEditValueChanged
        TabOrder = 2
        Width = 121
      end
      object lcbSELL_CURRENCY_ID: TcxDBLookupComboBox
        Left = 315
        Top = 82
        DataBinding.DataField = 'SELL_CURRENCY_ID'
        Properties.DropDownListStyle = lsFixedList
        Properties.ImmediatePost = True
        Properties.KeyFieldNames = 'CURRENCYID'
        Properties.ListColumns = <
          item
            FieldName = 'TITLE'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = dmDB.IBCDataSourceCurrency
        Properties.OnEditValueChanged = lcbSELL_CURRENCY_IDPropertiesEditValueChanged
        TabOrder = 3
        Width = 150
      end
      object cbFLG_ACNT: TcxDBCheckBox
        Left = 16
        Top = 111
        Caption = #1055#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
        DataBinding.DataField = 'FLG_ACNT'
        Properties.Alignment = taRightJustify
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Properties.OnEditValueChanged = lcbSELL_CURRENCY_IDPropertiesEditValueChanged
        TabOrder = 4
      end
      object edPricePreorderToSupplier: TcxCalcEdit
        Left = 490
        Top = 82
        TabStop = False
        EditValue = 0.000000000000000000
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = '0.00'
        Properties.ReadOnly = True
        TabOrder = 5
        Width = 119
      end
    end
  end
  object pnButtons: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 377
    Width = 629
    Height = 45
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelOuter = bvNone
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 2
    object btnOK: TButton
      AlignWithMargins = True
      Left = 429
      Top = 8
      Width = 90
      Height = 29
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 12
      Margins.Bottom = 0
      Align = alRight
      Caption = 'Ok'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 531
      Top = 8
      Width = 90
      Height = 29
      Align = alRight
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
end
