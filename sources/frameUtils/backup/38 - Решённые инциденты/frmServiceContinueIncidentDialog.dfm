object frmServiceContinueIncidentDlg: TfrmServiceContinueIncidentDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
  ClientHeight = 587
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    680
    587)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 680
    Height = 64
    Title = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1080#1085#1094#1080#1076#1077#1085#1090
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
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 664
    Height = 453
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
    object cgIncident: TControlGroup
      Left = 12
      Top = 16
      Width = 633
      Height = 205
      Title = #1048#1085#1094#1080#1076#1077#1085#1090
      FontTitle.Charset = DEFAULT_CHARSET
      FontTitle.Color = 10040064
      FontTitle.Height = -15
      FontTitle.Name = 'Segoe UI'
      FontTitle.Style = []
      GroupType = cgtWarning
      object Label2: TLabel
        Left = 16
        Top = 48
        Width = 82
        Height = 15
        Caption = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      end
      object Label3: TLabel
        Left = 16
        Top = 77
        Width = 33
        Height = 15
        Caption = #1058#1086#1074#1072#1088
      end
      object Label4: TLabel
        Left = 16
        Top = 135
        Width = 97
        Height = 15
        Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      end
      object Label5: TLabel
        Left = 16
        Top = 106
        Width = 43
        Height = 15
        Caption = #1052#1086#1076#1077#1083#1100
      end
      object Label6: TLabel
        Left = 16
        Top = 164
        Width = 62
        Height = 15
        Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
      end
      object edTYPE_TITLE: TcxDBTextEdit
        Left = 119
        Top = 45
        TabStop = False
        DataBinding.DataField = 'TYPE_TITLE'
        DataBinding.DataSource = IBCDataSourceIncidents
        TabOrder = 0
        Width = 494
      end
      object edGOODS_NAME: TcxDBTextEdit
        Left = 119
        Top = 74
        TabStop = False
        DataBinding.DataField = 'GOODS_NAME'
        DataBinding.DataSource = IBCDataSourceIncidents
        TabOrder = 1
        Width = 494
      end
      object edSN: TcxDBTextEdit
        Left = 119
        Top = 132
        TabStop = False
        DataBinding.DataField = 'SN'
        DataBinding.DataSource = IBCDataSourceIncidents
        TabOrder = 2
        Width = 182
      end
      object edGOODS_MODEL: TcxDBTextEdit
        Left = 119
        Top = 103
        TabStop = False
        DataBinding.DataField = 'GOODS_MODEL'
        DataBinding.DataSource = IBCDataSourceIncidents
        TabOrder = 3
        Width = 494
      end
      object edCUSTOMER_FULLNAME: TcxDBTextEdit
        Left = 119
        Top = 161
        TabStop = False
        DataBinding.DataField = 'CUSTOMER_FULLNAME'
        DataBinding.DataSource = IBCDataSourceIncidents
        TabOrder = 4
        Width = 274
      end
    end
    object cgDescription: TControlGroup
      Left = 12
      Top = 232
      Width = 633
      Height = 200
      Title = #1055#1088#1080#1095#1080#1085#1072' '#1087#1088#1086#1076#1086#1083#1078#1077#1085#1080#1103' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      FontTitle.Charset = DEFAULT_CHARSET
      FontTitle.Color = 10040064
      FontTitle.Height = -15
      FontTitle.Name = 'Segoe UI'
      FontTitle.Style = []
      GroupType = cgtError
      object Label1: TLabel
        Left = 16
        Top = 44
        Width = 184
        Height = 15
        Caption = #1055#1086#1083#1085#1086#1077' '#1086#1087#1080#1089#1072#1085#1080#1077' '#1086#1090#1082#1072#1079#1072' '#1082#1083#1080#1077#1085#1090#1072
      end
      object mmText: TMemo
        Left = 16
        Top = 61
        Width = 597
        Height = 124
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object btnCancel: TButton
    Left = 570
    Top = 541
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object btnFinish: TButton
    Left = 474
    Top = 541
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&Ok'
    Default = True
    ModalResult = 2
    TabOrder = 2
    OnClick = btnFinishClick
  end
  object IBCQueryIncidents: TIBCQuery
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT'
      ' VW_TDB_SC_INCIDENTE.*,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE (TS_CUSTOMER.CuSTOME' +
        'RID=VW_TDB_SC_INCIDENTE.CUSTOMERID)) CUSTOMER_FULLNAME'
      'FROM'
      ' VW_TDB_SC_INCIDENTE'
      'WHERE'
      ' IID=:IID')
    ReadOnly = True
    RefreshOptions = [roAfterUpdate]
    Constraints = <>
    Left = 444
    Top = 52
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IID'
        Value = nil
      end>
  end
  object IBCDataSourceIncidents: TIBCDataSource
    AutoEdit = False
    DataSet = IBCQueryIncidents
    Left = 444
    Top = 4
  end
end
