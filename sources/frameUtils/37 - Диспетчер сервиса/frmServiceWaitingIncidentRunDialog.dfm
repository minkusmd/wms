object frmServiceWaitingIncidentRunDlg: TfrmServiceWaitingIncidentRunDlg
  Left = 0
  Top = 0
  ActiveControl = cxGrid
  BorderStyle = bsDialog
  Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090' '#1074' '#1088#1072#1073#1086#1090#1091
  ClientHeight = 458
  ClientWidth = 779
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
    Width = 779
    Height = 64
    Title = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090' '#1074' '#1088#1072#1073#1086#1090#1091
    Text = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1080' '#1079#1072#1087#1091#1089#1090#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090' '#1074' '#1088#1072#1073#1086#1090#1091
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
    ImageIndex = 32
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 763
    Height = 333
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 54
      Height = 15
      Caption = #1048#1085#1094#1080#1076#1077#1085#1090
    end
    object Label2: TLabel
      Left = 404
      Top = 20
      Width = 126
      Height = 15
      Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1099#1081' '#1080#1085#1078#1077#1085#1077#1088'*'
    end
    object Label3: TLabel
      Left = 20
      Top = 264
      Width = 93
      Height = 15
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103'*'
    end
    object Label4: TLabel
      Left = 220
      Top = 264
      Width = 60
      Height = 15
      Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
    end
    object mmText: TMemo
      Left = 20
      Top = 37
      Width = 357
      Height = 204
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Lines.Strings = (
        'mmText')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object deFinishDate: TcxDateEdit
      Left = 20
      Top = 281
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 177
    end
    object cxGrid: TcxGrid
      Left = 404
      Top = 37
      Width = 333
      Height = 268
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object cxGridTable: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        ScrollbarAnnotations.CustomAnnotations = <>
        DataController.DataSource = IBCDataSourceUsers
        DataController.KeyFieldNames = 'USERID'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsCustomize.ColumnFiltering = False
        OptionsCustomize.ColumnMoving = False
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.CellEndEllipsis = True
        OptionsView.NoDataToDisplayInfoText = '<'#1053#1077#1090' '#1079#1072#1087#1080#1089#1077#1081'>'
        OptionsView.ScrollBars = ssVertical
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.GridLineColor = 13750737
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        Styles.Header = dmAdditions.cxStyle_GridHeader
        Styles.Inactive = dmAdditions.cxStyle_GirdContentInactive
        object cxGridTable_USERID: TcxGridDBColumn
          DataBinding.FieldName = 'USERID'
          Visible = False
          VisibleForCustomization = False
        end
        object cxGridTable_FULL_NAME: TcxGridDBColumn
          Caption = #1048#1085#1078#1077#1085#1077#1088
          DataBinding.FieldName = 'FULL_NAME'
          PropertiesClassName = 'TcxLabelProperties'
          Properties.Alignment.Vert = taVCenter
          OnGetDisplayText = cxGridTable_FULL_NAMEGetDisplayText
        end
        object cxGridTable_IMAGE: TcxGridDBColumn
          Caption = #1060#1086#1090#1086
          DataBinding.FieldName = 'IMAGE'
          PropertiesClassName = 'TcxImageProperties'
          Properties.GraphicClassName = 'TdxSmartImage'
          Properties.PopupMenuLayout.MenuItems = []
          Properties.ShowFocusRect = False
          HeaderAlignmentHorz = taCenter
          MinWidth = 48
          Options.Focusing = False
          Options.HorzSizing = False
          Width = 48
        end
        object cxGridTable_FUNCTIA_DETINUTA: TcxGridDBColumn
          DataBinding.FieldName = 'FUNCTIA_DETINUTA'
          Visible = False
          VisibleForCustomization = False
        end
      end
      object cxGridLevel: TcxGridLevel
        GridView = cxGridTable
      end
    end
    object edPriority: TEdit
      Left = 220
      Top = 281
      Width = 157
      Height = 23
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = 'edPriority'
    end
  end
  object btnOk: TButton
    Left = 560
    Top = 416
    Width = 90
    Height = 29
    Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 668
    Top = 416
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryUsers: TIBCQuery
    Connection = dmDB.IBCConnection
    SQL.Strings = (
      'SELECT'
      ' TS_USERS.USERID,'
      ' FULL_NAME,'
      
        ' (SELECT IMAGE FROM TS_USER_IMAGE WHERE TS_USER_IMAGE.USERID=TS_' +
        'USERS.USERID),'
      ' FUNCTIA_DETINUTA'
      'FROM TS_USERS'
      
        'INNER JOIN TS_USER_GROUP_LINKS ON (TS_USER_GROUP_LINKS.USERID=TS' +
        '_USERS.USERID AND TS_USER_GROUP_LINKS.GROUPID=20)'
      'WHERE GET_FLG_VALUE(FLAGS,0)=1'
      'ORDER BY FULL_NAME')
    Left = 464
    Top = 216
  end
  object IBCDataSourceUsers: TIBCDataSource
    DataSet = IBCQueryUsers
    Left = 464
    Top = 272
  end
end
