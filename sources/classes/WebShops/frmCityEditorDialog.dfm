object frmCityEditorDlg: TfrmCityEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1043#1086#1088#1086#1076' '#1087#1088#1086#1076#1072#1078
  ClientHeight = 251
  ClientWidth = 374
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
    Width = 374
    Height = 64
    Title = #1043#1086#1088#1086#1076' '#1087#1088#1086#1076#1072#1078
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
    ImageIndex = 15
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 358
    Height = 125
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
      Width = 33
      Height = 15
      Caption = #1043#1086#1088#1086#1076
    end
    object Label2: TLabel
      Left = 20
      Top = 48
      Width = 57
      Height = 15
      Caption = #1058#1077#1083#1077#1092#1086#1085#1099
    end
    object Label3: TLabel
      Left = 20
      Top = 77
      Width = 40
      Height = 15
      Caption = #1045'-'#1084#1101#1081#1083
    end
    object lcbCITYID: TcxDBLookupComboBox
      Left = 84
      Top = 16
      DataBinding.DataField = 'CITYID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'SYSSID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceCity
      TabOrder = 0
      Width = 249
    end
    object edTELEFOANE: TcxDBTextEdit
      Left = 84
      Top = 45
      DataBinding.DataField = 'TELEFOANE'
      TabOrder = 1
      Width = 249
    end
    object edEMAIL: TcxDBTextEdit
      Left = 84
      Top = 74
      DataBinding.DataField = 'EMAIL'
      TabOrder = 2
      Width = 249
    end
  end
  object btnOk: TcxButton
    Left = 156
    Top = 208
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 260
    Top = 208
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryCity: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' VW_CITIES.SYSSID,'
      ' VW_CITIES.TITLE || '#39' ('#39' || TS_SYSS.TITLE || '#39')'#39' TITLE'
      'FROM '
      ' VW_CITIES'
      'INNER JOIN TS_SYSS ON (TS_SYSS.SYSSID = DISTRICTID)'
      'ORDER BY VW_CITIES.TITLE')
    Left = 284
    Top = 148
  end
  object IBCDataSourceCity: TIBCDataSource
    DataSet = IBCQueryCity
    Left = 284
    Top = 100
  end
end
