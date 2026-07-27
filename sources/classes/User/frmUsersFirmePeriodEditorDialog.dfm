object frmUsersFirmePeriodEditorDlg: TfrmUsersFirmePeriodEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1077#1088#1080#1086#1076' '#1088#1072#1073#1086#1090#1099' '#1074' '#1092#1080#1088#1084#1077
  ClientHeight = 287
  ClientWidth = 393
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 393
    Height = 64
    Title = #1055#1077#1088#1080#1086#1076' '#1088#1072#1073#1086#1090#1099' '#1074' '#1092#1080#1088#1084#1077
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
    ImageIndex = 2
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 377
    Height = 161
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
      Width = 42
      Height = 15
      Caption = #1055#1077#1088#1080#1086#1076
    end
    object Label2: TLabel
      Left = 20
      Top = 76
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 20
      Top = 37
      DataBinding.DataField = 'START_DATE'
      TabOrder = 0
      Width = 121
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 156
      Top = 37
      DataBinding.DataField = 'END_DATE'
      TabOrder = 1
      Width = 121
    end
    object lcbFIRMAID: TcxDBLookupComboBox
      Left = 20
      Top = 93
      DataBinding.DataField = 'FIRMAID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dmDB.IBCDataSourceFirms
      TabOrder = 2
      Width = 257
    end
  end
  object btnOk: TButton
    Left = 172
    Top = 244
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 280
    Top = 244
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end
