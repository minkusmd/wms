object fmSelectIncidentStatus: TfmSelectIncidentStatus
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
  ClientHeight = 266
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TcxButton
    Left = 304
    Top = 229
    Width = 91
    Height = 29
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TcxButton
    Left = 401
    Top = 229
    Width = 96
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 6
  end
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 510
    Height = 64
    Title = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
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
    ImageIndex = 32
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 81
    Caption = #1053#1086#1074#1086#1077' '#1089#1086#1089#1090#1086#1103#1085#1080#1077
  end
  object cxLabel2: TcxLabel
    Left = 8
    Top = 116
    Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081
  end
  object memComments: TcxMemo
    Left = 120
    Top = 115
    TabOrder = 3
    Height = 81
    Width = 377
  end
  object lcbIncidentState: TcxLookupComboBox
    Left = 120
    Top = 80
    Properties.KeyFieldNames = 'SYSSID'
    Properties.ListColumns = <
      item
        FieldName = 'TITLE'
      end>
    Properties.ListSource = IBCDS_Status
    TabOrder = 1
    Width = 377
  end
  object IBC_Status: TIBCQuery
    SQL.Strings = (
      'select * from ts_syss where parentid=21')
    Left = 272
    Top = 136
  end
  object IBCDS_Status: TIBCDataSource
    DataSet = IBC_Status
    Left = 184
    Top = 136
  end
end
