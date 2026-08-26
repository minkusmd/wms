object frmReceiptPrintDlg: TfrmReceiptPrintDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1077#1095#1072#1090#1100' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1075#1086' '#1095#1077#1082#1072
  ClientHeight = 549
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 649
    Height = 418
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 12
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label3: TLabel
      Left = 16
      Top = 20
      Width = 81
      Height = 29
      AutoSize = False
      Caption = #1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1087#1088#1080#1085#1090#1077#1088
      WordWrap = True
    end
    object Label4: TLabel
      Left = 16
      Top = 120
      Width = 105
      Height = 15
      Caption = #1058#1086#1074#1072#1088#1099' '#1076#1083#1103' '#1087#1077#1095#1072#1090#1080
    end
    object lbBonNumber: TLabel
      Left = 48
      Top = 382
      Width = 36
      Height = 21
      Caption = '0000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10485760
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbLastSuma: TLabel
      Left = 180
      Top = 382
      Width = 97
      Height = 21
      Caption = '00 000.00 Lei'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 386
      Width = 23
      Height = 15
      Caption = #1063#1077#1082':'
    end
    object Label6: TLabel
      Left = 132
      Top = 386
      Width = 41
      Height = 15
      Caption = #1057#1091#1084#1084#1072':'
    end
    object Label1: TLabel
      Left = 16
      Top = 89
      Width = 39
      Height = 15
      Caption = #1050#1083#1080#1077#1085#1090
    end
    object cxGrid: TcxGrid
      Left = 16
      Top = 138
      Width = 493
      Height = 227
      TabOrder = 0
      object cxGridTable: TcxGridTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxGridTable_SUMA
          end
          item
            Format = '0'
            Kind = skSum
            Column = cxGridTable_QTY
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnGrouping = False
        OptionsCustomize.ColumnHidingOnGrouping = False
        OptionsCustomize.ColumnHorzSizing = False
        OptionsCustomize.ColumnMoving = False
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Styles.Header = dmAdditions.cxStyle_GridHeader
        object cxGridTable_NO: TcxGridColumn
          Caption = #8470
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 40
          Options.HorzSizing = False
          Width = 40
        end
        object cxGridTable_TITLE: TcxGridColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        end
        object cxGridTable_QTY: TcxGridColumn
          Caption = #1050#1086#1083'-'#1074#1086
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Horz = taCenter
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          MinWidth = 50
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_Bold
          Width = 50
        end
        object cxGridTable_RPICE: TcxGridColumn
          Caption = #1062#1077#1085#1072
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '#,##0.00'
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Width = 70
        end
        object cxGridTable_SUMA: TcxGridColumn
          Caption = #1057#1091#1084#1084#1072
          DataBinding.ValueType = 'Float'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.DisplayFormat = '#,##0.00'
          FooterAlignmentHorz = taRightJustify
          HeaderAlignmentHorz = taCenter
          MinWidth = 70
          Options.HorzSizing = False
          Styles.Footer = dmAdditions.cxStyle_Bold
          Width = 70
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object btnPrint: TButton
      Left = 535
      Top = 138
      Width = 90
      Height = 51
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      WordWrap = True
      OnClick = btnPrintClick
    end
    object btnOpenTill: TButton
      Left = 535
      Top = 204
      Width = 90
      Height = 49
      Caption = #1044#1077#1085#1077#1078#1085#1099#1081' '#1103#1097#1080#1082
      TabOrder = 2
      WordWrap = True
      OnClick = btnOpenTillClick
    end
    object rbPF: TRadioButton
      Left = 96
      Top = 89
      Width = 153
      Height = 18
      Caption = #1060#1080#1079#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086' (F1)'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = True
      OnClick = rbPFClick
    end
    object rbPJ: TRadioButton
      Left = 271
      Top = 89
      Width = 166
      Height = 18
      Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1086#1077' '#1083#1080#1094#1086' (F5)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = rbPFClick
    end
    object btnCancelReceipt: TButton
      Left = 535
      Top = 312
      Width = 90
      Height = 57
      Caption = #1040#1085#1085#1091#1083#1080#1088#1086#1074#1072#1090#1100' '#1095#1077#1082
      TabOrder = 5
      WordWrap = True
      OnClick = btnCancelReceiptClick
    end
    object pnPrinterInfo: TPanel
      Left = 96
      Top = 16
      Width = 529
      Height = 43
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 6
      object lbInfo1: TLabel
        Left = 4
        Top = 20
        Width = 112
        Height = 15
        Caption = #1060#1080#1089#1082#1072#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088':'
      end
      object lbInfo2: TLabel
        Left = 279
        Top = 20
        Width = 105
        Height = 15
        Caption = #1053#1072#1083#1086#1075#1086#1074#1099#1081' '#1085#1086#1084#1077#1088':'
      end
      object lbPrinterInfo: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 517
        Height = 15
        Margins.Left = 4
        Margins.Top = 2
        Margins.Right = 4
        Margins.Bottom = 2
        Align = alTop
        AutoSize = False
        ExplicitWidth = 66
      end
      object lbIDEN: TLabel
        Left = 122
        Top = 20
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbVAT: TLabel
        Left = 390
        Top = 20
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object btnClose: TButton
    Left = 543
    Top = 505
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 665
    Height = 64
    Title = #1055#1077#1095#1072#1090#1100' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1075#1086' '#1095#1077#1082#1072
    Text = #1055#1077#1095#1072#1090#1100' '#1092#1080#1089#1082#1072#1083#1100#1085#1086#1075#1086' '#1095#1077#1082#1072' '#1076#1083#1103' '#1088#1072#1089#1093#1086#1076#1085#1086#1081' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
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
    ImageIndex = 26
  end
end
