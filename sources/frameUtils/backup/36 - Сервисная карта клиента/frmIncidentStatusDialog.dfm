object frmIncidentStatusDlg: TfrmIncidentStatusDlg
  Left = 0
  Top = 0
  ActiveControl = lcmbStatuses
  BorderStyle = bsDialog
  Caption = #1057#1090#1072#1090#1091#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
  ClientHeight = 240
  ClientWidth = 531
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 531
    Height = 64
    Title = #1057#1090#1072#1090#1091#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    Text = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1089#1090#1072#1090#1091#1089#1072' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
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
  end
  object btnOk: TButton
    Left = 316
    Top = 195
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 420
    Top = 195
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 515
    Height = 105
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 97
      Height = 15
      Caption = #1057#1090#1072#1090#1091#1089' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
    end
    object lcmbStatuses: TcxDBLookupComboBox
      Left = 16
      Top = 37
      DataBinding.DataField = 'STATUS_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 140
          FieldName = 'TITLE'
        end
        item
          FieldName = 'DESCRIPTION'
        end>
      Properties.ListOptions.ColumnSorting = False
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceIncidentStatus
      TabOrder = 0
      Width = 473
    end
  end
  object IBCQueryIncidentStatus: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT * FROM GET_INCIDENT_STATUSES')
    Constraints = <>
    Left = 388
    Top = 12
  end
  object IBCDataSourceIncidentStatus: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryIncidentStatus
    Left = 240
    Top = 12
  end
end
