object frmOtgruzkaDlg: TfrmOtgruzkaDlg
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Inchidere document'
  ClientHeight = 369
  ClientWidth = 467
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
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 467
    Height = 64
    Title = 'Inchidere document'
    Text = 'Eliberarea produselor '#537'i '#238'nchiderea documentului'
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
    ImageIndex = 21
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 451
    Height = 243
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    AutoSize = True
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    Padding.Bottom = 16
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 16
      Top = 16
      Width = 415
      Height = 21
      Margins.Left = 16
      Margins.Top = 16
      Margins.Right = 16
      Margins.Bottom = 16
      Align = alTop
      Caption = 'Livra'#539'i produsele '#537'i '#238'nchide'#539'i documentul?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 320
    end
    object pnActiuni: TPanel
      Left = 0
      Top = 53
      Width = 447
      Height = 170
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 16
      Padding.Right = 16
      ShowCaption = False
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 0
        Width = 415
        Height = 15
        Align = alTop
        Caption = 'Actiuni disponibile'
        ExplicitWidth = 99
      end
      object lbErrorInfo: TLabel
        Left = 16
        Top = 155
        Width = 415
        Height = 15
        Align = alBottom
        Caption = 'Face'#539'i dublu clic - pentru detalii.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4210816
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 170
      end
      object Label4: TLabel
        Left = 16
        Top = 140
        Width = 415
        Height = 15
        Align = alBottom
        Caption = 'Pentru a participa la promo'#539'ie, selecta'#539'i-o din list'#259'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 265
      end
      object cxGrid: TcxGrid
        Left = 16
        Top = 15
        Width = 415
        Height = 125
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object cxGridTable: TcxGridTableView
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxGridTableCellDblClick
          OnEditing = cxGridTableEditing
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.CopyCaptionsToClipboard = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsCustomize.ColumnHorzSizing = False
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.Deleting = False
          OptionsData.Inserting = False
          OptionsSelection.InvertSelect = False
          OptionsView.CellEndEllipsis = True
          OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1072#1082#1094#1080#1081' '#1085#1072' '#1090#1077#1082#1091#1097#1080#1081' '#1084#1086#1084#1077#1085#1090'>'
          OptionsView.ScrollBars = ssVertical
          OptionsView.ColumnAutoWidth = True
          OptionsView.GridLineColor = 13750737
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          Styles.Content = dmAdditions.cxStyle_TextColorRed
          Styles.OnGetContentStyle = cxGridTableStylesGetContentStyle
          Styles.Header = dmAdditions.cxStyle_GridHeader
          object cxGridTable_ID: TcxGridColumn
            DataBinding.ValueType = 'Integer'
            Visible = False
            VisibleForCustomization = False
          end
          object cxGridTable_CHECK: TcxGridColumn
            DataBinding.ValueType = 'Boolean'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            MinWidth = 30
            Options.HorzSizing = False
            Width = 30
          end
          object cxGridTable_TITLE: TcxGridColumn
            Caption = 'Actiune'
            Options.Editing = False
          end
          object cxGridTable_Errors: TcxGridColumn
            Caption = #1048#1085#1092#1086
            Visible = False
            HeaderAlignmentHorz = taCenter
            MinWidth = 80
            Options.Editing = False
            Options.HorzSizing = False
            VisibleForCustomization = False
            Width = 80
          end
          object cxGridTableHasError: TcxGridColumn
            DataBinding.ValueType = 'Boolean'
            Visible = False
            VisibleForCustomization = False
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridTable
        end
      end
    end
  end
  object pnButtons: TPanel
    Left = 0
    Top = 323
    Width = 467
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      467
      46)
    object btnYes: TButton
      Left = 260
      Top = 3
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Caption = 'Da'
      Default = True
      ModalResult = 6
      TabOrder = 0
    end
    object btnNo: TButton
      Left = 363
      Top = 3
      Width = 90
      Height = 29
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Nu'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
