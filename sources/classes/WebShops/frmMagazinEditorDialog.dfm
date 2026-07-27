object frmMagazinEditorDlg: TfrmMagazinEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1052#1072#1075#1072#1079#1080#1085
  ClientHeight = 382
  ClientWidth = 705
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    705
    382)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 705
    Height = 64
    Title = #1052#1072#1075#1072#1079#1080#1085
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
    Width = 689
    Height = 255
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
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 23
      Width = 38
      Height = 15
      Caption = #1060#1080#1088#1084#1072
    end
    object Label2: TLabel
      Left = 20
      Top = 52
      Width = 33
      Height = 15
      Caption = #1040#1076#1088#1077#1089
    end
    object Label3: TLabel
      Left = 20
      Top = 81
      Width = 57
      Height = 15
      Caption = #1058#1077#1083#1077#1092#1086#1085#1099
    end
    object Label4: TLabel
      Left = 20
      Top = 110
      Width = 27
      Height = 15
      Caption = #1060#1072#1082#1089
    end
    object Label5: TLabel
      Left = 20
      Top = 139
      Width = 40
      Height = 15
      Caption = #1045'-'#1084#1101#1081#1083
    end
    object sbBringDetails: TSpeedButton
      Left = 287
      Top = 136
      Width = 138
      Height = 23
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100' '#1072#1090#1088#1080#1073#1091#1090#1099
      OnClick = sbBringDetailsClick
    end
    object lbl1: TLabel
      Left = 20
      Top = 195
      Width = 58
      Height = 30
      AutoSize = False
      Caption = 'Google Map URL'
      WordWrap = True
    end
    object edADRESA: TcxDBTextEdit
      Left = 84
      Top = 49
      DataBinding.DataField = 'ADRESA'
      TabOrder = 2
      Width = 241
    end
    object edTELEFOANE: TcxDBTextEdit
      Left = 84
      Top = 78
      DataBinding.DataField = 'TELEFOANE'
      TabOrder = 3
      Width = 181
    end
    object edFAX: TcxDBTextEdit
      Left = 84
      Top = 107
      DataBinding.DataField = 'FAX'
      TabOrder = 4
      Width = 181
    end
    object edEMAIL: TcxDBTextEdit
      Left = 84
      Top = 136
      DataBinding.DataField = 'EMAIL'
      TabOrder = 5
      Width = 181
    end
    object lcbCUSTOMERID: TcxDBLookupComboBox
      Left = 84
      Top = 20
      DataBinding.DataField = 'CUSTOMERID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.ImmediatePost = True
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Fixed = True
          Width = 50
          FieldName = 'CUSTOMERID'
        end
        item
          FieldName = 'DISPLAYNAME'
        end>
      Properties.ListFieldIndex = 1
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceFirme
      TabOrder = 1
      Width = 341
    end
    object cmbFLG_SELF_PICKUP: TcxDBCheckBox
      Left = 89
      Top = 172
      Caption = #1057#1072#1084#1086#1074#1099#1074#1086#1079
      DataBinding.DataField = 'FLG_SELF_PICKUP'
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 6
    end
    object imgIMAGE: TcxDBImage
      Left = 464
      Top = 18
      DataBinding.DataField = 'IMAGE_MAP'
      Properties.FitMode = ifmProportionalStretch
      Properties.GraphicClassName = 'TdxPNGImage'
      Properties.PopupMenuLayout.MenuItems = [pmiCopy, pmiPaste, pmiLoad, pmiSave]
      TabOrder = 0
      Height = 177
      Width = 200
    end
    object edGMap_URL: TcxDBTextEdit
      Left = 84
      Top = 201
      DataBinding.DataField = 'GMAP_URL'
      TabOrder = 7
      Width = 580
    end
  end
  object btnOk: TcxButton
    Left = 490
    Top = 338
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 594
    Top = 338
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryFirme: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' CUSTOMERID, DISPLAYNAME'
      'FROM VW_GET_FIRME')
    Left = 332
    Top = 204
  end
  object IBCDataSourceFirme: TIBCDataSource
    DataSet = IBCQueryFirme
    Left = 332
    Top = 156
  end
end
