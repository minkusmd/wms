object frmCloseBusinessDayDlg: TfrmCloseBusinessDayDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1047#1072#1082#1088#1099#1090#1080#1077' business '#1076#1085#1103
  ClientHeight = 449
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    698
    449)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 698
    Height = 64
    Title = #1047#1072#1082#1088#1099#1090#1080#1077' business '#1076#1085#1103
    Text = #1055#1088#1086#1074#1077#1088#1082#1072' '#1073#1072#1079#1086#1074#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1080' '#1079#1072#1082#1088#1099#1090#1080#1077' '#1076#1085#1103
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
    ImageIndex = 2
  end
  object btnOk: TButton
    Left = 480
    Top = 404
    Width = 102
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1076#1077#1085#1100
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 588
    Top = 404
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pcPages: TcxPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 682
    Height = 321
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    Properties.ActivePage = tbsVerify
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ClientRectBottom = 317
    ClientRectLeft = 4
    ClientRectRight = 678
    ClientRectTop = 4
    object tbsVerify: TcxTabSheet
      Caption = 'Verify'
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 129
        Height = 15
        Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 45
        Width = 262
        Height = 15
        Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1076#1086#1083#1078#1085#1099' '#1073#1099#1090#1100' '#1079#1072#1082#1088#1099#1090#1099':'
      end
      object bbStartVerify: TButton
        Left = 16
        Top = 207
        Width = 110
        Height = 29
        Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' >>'
        Default = True
        TabOrder = 0
        OnClick = bbStartVerifyClick
      end
      object clbDocTypes: TcxCheckListBox
        Left = 16
        Top = 66
        Width = 262
        Height = 124
        IntegralHeight = True
        Items = <
          item
            Enabled = False
            State = cbsChecked
            Tag = 112
            Text = #1057#1095#1077#1090'-'#1092#1072#1082#1090#1091#1088#1099
          end
          item
            Enabled = False
            State = cbsChecked
            Tag = 2016
            Text = #1058#1086#1074#1072#1088#1086' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077
          end
          item
            Enabled = False
            State = cbsChecked
            Tag = 120
            Text = #1055#1088#1080#1093#1086#1076' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090
          end
          item
            Enabled = False
            State = cbsChecked
            Tag = 121
            Text = #1055#1088#1080#1093#1086#1076' '#1076#1077#1085#1077#1075' '#1085#1072' '#1089#1095#1077#1090' ('#1080#1079' '#1082#1072#1089#1089#1099')'
          end
          item
            Enabled = False
            State = cbsChecked
            Tag = 116
            Text = #1055#1088#1080#1093#1086#1076#1085#1099#1081' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088
          end
          item
            Enabled = False
            State = cbsChecked
            Tag = 117
            Text = #1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1082#1072#1089#1089#1086#1074#1099#1081' '#1086#1088#1076#1077#1088
          end>
        TabOrder = 1
      end
    end
    object tbsDocs: TcxTabSheet
      Caption = 'Docs'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 142
        Height = 15
        Align = alTop
        Caption = #1053#1077#1079#1072#1082#1088#1099#1090#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 0
        Top = 298
        Width = 262
        Height = 15
        Align = alBottom
        Caption = #1047#1072#1082#1088#1081#1090#1077' '#1074#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1080' '#1087#1086#1074#1090#1086#1088#1080#1090#1077' '#1086#1087#1077#1088#1072#1094#1080#1102'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object cxGrid: TcxGrid
        Left = 0
        Top = 15
        Width = 674
        Height = 283
        Align = alClient
        TabOrder = 0
        object cxGridTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          ScrollbarAnnotations.CustomAnnotations = <>
          OnCellDblClick = cxGridTableCellDblClick
          OnCustomDrawCell = cxGridTableCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.Indicator = True
          Styles.GroupByBox = dmAdditions.cxStyle_GridGroup
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridTable_DOCID: TcxGridColumn
            Caption = #1044#1086#1082#1091#1084#1077#1085#1090
            DataBinding.ValueType = 'Integer'
            HeaderAlignmentHorz = taCenter
            MinWidth = 60
            Options.HorzSizing = False
            Width = 60
          end
          object cxGridTable_DOCTYPE_TITLE: TcxGridColumn
            Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            Visible = False
            GroupIndex = 0
          end
          object cxGridTable_DT_NAME: TcxGridColumn
            Caption = #1060#1080#1088#1084#1072
            Width = 200
          end
          object cxGridTable_CT_NAME: TcxGridColumn
            Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
            Width = 200
          end
          object cxGridTable_SUMA: TcxGridColumn
            Caption = #1057#1091#1084#1084#1072
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taCenter
            MinWidth = 64
            Options.HorzSizing = False
          end
          object cxGridTable_CURRENCY_NAME: TcxGridColumn
            AlternateCaption = '40'
            Caption = #1042#1072#1083'.'
            PropertiesClassName = 'TcxLabelProperties'
            Properties.Alignment.Horz = taCenter
            HeaderAlignmentHorz = taCenter
            MinWidth = 40
            Options.HorzSizing = False
            Width = 40
          end
          object cxGridTable_FLG_ACNT: TcxGridColumn
            Caption = #1041#1091#1093#1075
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 1
            Properties.ValueUnchecked = 0
            HeaderAlignmentHorz = taCenter
            MinWidth = 34
            Options.HorzSizing = False
            Width = 34
          end
          object cxGridTable_CREATED_BY_NAME: TcxGridColumn
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
            Width = 100
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
    end
    object tbsOk: TcxTabSheet
      Caption = 'Ok'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label5: TLabel
        Left = 20
        Top = 20
        Width = 195
        Height = 15
        Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1079#1072#1074#1077#1088#1096#1077#1085#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 20
        Top = 49
        Width = 213
        Height = 30
        Caption = #1042#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099' '#1079#1072#1082#1088#1099#1090#1099'.'#13#1042#1099' '#1084#1086#1078#1077#1090#1077' '#1079#1072#1082#1088#1099#1090#1100' '#1101#1090#1086#1090' business '#1076#1077#1085#1100'.'
      end
    end
  end
end
