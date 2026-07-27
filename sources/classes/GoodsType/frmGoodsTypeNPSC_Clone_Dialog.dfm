object frmGoodsTypeNPSC_Clone_Dlg: TfrmGoodsTypeNPSC_Clone_Dlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1080#1087#1080#1079#1072#1094#1080#1080
  ClientHeight = 284
  ClientWidth = 392
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
    Width = 392
    Height = 64
    Title = #1050#1086#1087#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1080#1087#1080#1079#1072#1094#1080#1080
    Text = #1048#1079' '#1086#1076#1085#1086#1075#1086' '#1090#1080#1087#1072' '#1090#1086#1074#1072#1088#1072' '#1074' '#1074' '#1076#1088#1091#1075#1086#1081
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
    ImageIndex = 16
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 376
    Height = 157
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
      Top = 16
      Width = 14
      Height = 15
      Caption = #1048#1079
    end
    object Label2: TLabel
      Left = 16
      Top = 68
      Width = 7
      Height = 15
      Caption = #1042
    end
    object lcbSource: TcxLookupComboBox
      Left = 16
      Top = 33
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'GOODSTYPEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end
        item
          FieldName = 'TITLE_RUS'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceGT
      EditValue = 0
      TabOrder = 0
      Width = 333
    end
    object lcbTarget: TcxLookupComboBox
      Left = 16
      Top = 85
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 16
      Properties.KeyFieldNames = 'GOODSTYPEID'
      Properties.ListColumns = <
        item
          FieldName = 'TITLE'
        end
        item
          FieldName = 'TITLE_RUS'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = IBCDataSourceGT
      EditValue = 0
      TabOrder = 1
      Width = 333
    end
  end
  object btnOk: TButton
    Left = 184
    Top = 240
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 280
    Top = 240
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryGT: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' GOODSTYPEID, '
      ' TITLE,'
      ' TITLE_RUS'
      'FROM '
      ' TS_GOODS_TYPE'
      'WHERE'
      ' (GOODSTYPEID<>-1)'
      'ORDER BY TITLE')
    Left = 52
    Top = 164
  end
  object IBCDataSourceGT: TIBCDataSource
    DataSet = IBCQueryGT
    Left = 132
    Top = 164
  end
end
