object frmDescriptionLinkButtonEditorDlg: TfrmDescriptionLinkButtonEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1085#1086#1087#1082#1072' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1076#1083#1103' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
  ClientHeight = 302
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    455
    302)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 455
    Height = 64
    Title = #1050#1085#1086#1087#1082#1072' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1076#1083#1103' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
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
    ImageIndex = 7
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 439
    Height = 177
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 20
      Width = 40
      Height = 15
      Caption = #1050#1085#1086#1087#1082#1072
    end
    object cmbFILTER_BUTTON_ID: TcxDBLookupComboBox
      Left = 20
      Top = 37
      DataBinding.DataField = 'FILTER_BUTTON_ID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'FILTER_BUTTON_ID'
      Properties.ListColumns = <
        item
          FieldName = 'SYS_TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceButtons
      TabOrder = 0
      Width = 389
    end
  end
  object btnOk: TButton
    Left = 238
    Top = 260
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 346
    Top = 260
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryButtons: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' FILTER_BUTTON_ID,'
      ' SYS_TITLE'
      'FROM'
      ' TS_FILTER_BUTTON'
      'WHERE '
      ' GET_FLG_VALUE(FLAGS,0)=1')
    Left = 80
    Top = 192
  end
  object IBCDataSourceButtons: TIBCDataSource
    DataSet = IBCQueryButtons
    Left = 80
    Top = 144
  end
end
