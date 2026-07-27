object frmReportSelectDocTypeDlg: TfrmReportSelectDocTypeDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 561
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    415
    561)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 415
    Height = 64
    Title = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1076#1083#1103' '#1086#1090#1095#1077#1090#1072
    Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1076#1083#1103' '#1086#1090#1095#1077#1090#1072
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
  object cxTreeList: TcxTreeList
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 399
    Height = 425
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Bands = <
      item
      end>
    Images = dmAdditions.cxImageList_SWN
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.ImmediateEditor = False
    OptionsBehavior.ChangeDelay = 1000
    OptionsData.CancelOnExit = False
    OptionsData.Editing = False
    OptionsData.Deleting = False
    OptionsSelection.CellSelect = False
    OptionsView.ScrollBars = ssVertical
    OptionsView.ColumnAutoWidth = True
    ScrollbarAnnotations.CustomAnnotations = <>
    Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
    Styles.OnGetContentStyle = cxTreeListStylesGetContentStyle
    Styles.ContentEven = dmAdditions.cxStyle_GridContentEven
    TabOrder = 1
    OnDblClick = cxTreeListDblClick
    OnDeletion = cxTreeListDeletion
    OnFocusedNodeChanged = cxTreeListFocusedNodeChanged
    object cxTreeList1cxTreeListColumn1: TcxTreeListColumn
      Caption.Text = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object cxTreeList1cxTreeListColumn2: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Properties.Alignment.Horz = taRightJustify
      Caption.AlignHorz = taCenter
      Caption.Text = #1050#1086#1076
      DataBinding.ValueType = 'Integer'
      Options.Sizing = False
      Width = 50
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object btnOk: TcxButton
    Left = 201
    Top = 513
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 305
    Top = 513
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
