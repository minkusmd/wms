object frmIncidentDescriptionDlg: TfrmIncidentDescriptionDlg
  Left = 0
  Top = 0
  ActiveControl = edGOODS_MODEL
  BorderStyle = bsDialog
  Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
  ClientHeight = 462
  ClientWidth = 668
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
    Width = 668
    Height = 64
    Title = #1054#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
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
  object btnOk: TButton
    Left = 455
    Top = 416
    Width = 90
    Height = 29
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 559
    Top = 416
    Width = 90
    Height = 29
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object pcPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 652
    Height = 329
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsGeneral
    Align = alTop
    TabOrder = 1
    object tbsGeneral: TTabSheet
      Caption = #1054#1073#1097#1080#1077
      object Label1: TLabel
        Left = 12
        Top = 76
        Width = 33
        Height = 15
        Caption = #1058#1086#1074#1072#1088
      end
      object Label2: TLabel
        Left = 484
        Top = 76
        Width = 97
        Height = 15
        Caption = #1057#1077#1088#1080#1081#1085#1099#1081' '#1085#1086#1084#1077#1088
      end
      object Label3: TLabel
        Left = 12
        Top = 152
        Width = 43
        Height = 15
        Caption = #1052#1086#1076#1077#1083#1100
      end
      object Label6: TLabel
        Left = 12
        Top = 212
        Width = 132
        Height = 15
        Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
      end
      object Label8: TLabel
        Left = 12
        Top = 12
        Width = 82
        Height = 15
        Caption = #1058#1080#1087' '#1080#1085#1094#1080#1076#1077#1085#1090#1072
      end
      object Label9: TLabel
        Left = 268
        Top = 212
        Width = 245
        Height = 15
        Caption = #1044#1072#1090#1072' '#1087#1088#1080#1073#1083#1080#1079#1080#1090#1077#1083#1100#1085#1086#1075#1086' '#1086#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1077#1084#1086#1085#1090#1072
      end
      object mmGOODS_NAME: TcxDBMemo
        Left = 12
        Top = 93
        TabStop = False
        DataBinding.DataField = 'GOODS_NAME'
        Properties.ReadOnly = True
        Properties.VisibleLineCount = 2
        TabOrder = 1
        Width = 453
      end
      object edSN: TcxDBTextEdit
        Left = 484
        Top = 93
        TabStop = False
        DataBinding.DataField = 'SN'
        Properties.ReadOnly = True
        TabOrder = 2
        Width = 133
      end
      object edGOODS_MODEL: TcxDBTextEdit
        Left = 12
        Top = 168
        DataBinding.DataField = 'GOODS_MODEL'
        ParentFont = False
        Properties.CharCase = ecUpperCase
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 3
        Width = 605
      end
      object cmbPriority: TComboBox
        Left = 12
        Top = 229
        Width = 201
        Height = 23
        Style = csDropDownList
        TabOrder = 4
      end
      object edTYPE_TITLE: TcxDBTextEdit
        Left = 12
        Top = 29
        TabStop = False
        DataBinding.DataField = 'TYPE_TITLE'
        Properties.ReadOnly = True
        TabOrder = 0
        Width = 453
      end
      object deDATA_ESTIMATED_FINISH: TcxDBDateEdit
        Left = 268
        Top = 229
        DataBinding.DataField = 'DATA_ESTIMATED_FINISH'
        TabOrder = 5
        Width = 197
      end
    end
    object tbsDescriptions: TTabSheet
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label4: TLabel
        Left = 12
        Top = 12
        Width = 102
        Height = 15
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1076#1077#1092#1077#1082#1090#1072
      end
      object Label5: TLabel
        Left = 12
        Top = 155
        Width = 141
        Height = 15
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1074#1085#1077#1096#1085#1077#1075#1086' '#1074#1080#1076#1072
      end
      object Label7: TLabel
        Left = 392
        Top = 12
        Width = 80
        Height = 15
        Caption = #1050#1086#1084#1087#1083#1077#1082#1090#1072#1094#1080#1103
      end
      object mmDEFECT_DSC: TcxDBMemo
        Left = 12
        Top = 28
        DataBinding.DataField = 'DEFECT_DSC'
        ParentFont = False
        Properties.ScrollBars = ssVertical
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Height = 109
        Width = 357
      end
      object mmEXTERNAL_DSC: TcxDBMemo
        Left = 12
        Top = 172
        DataBinding.DataField = 'EXTERNAL_DSC'
        ParentFont = False
        Properties.ScrollBars = ssVertical
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 1
        Height = 101
        Width = 357
      end
      object clbFLAGS_COMPLECT: TcxDBCheckListBox
        Left = 392
        Top = 28
        Width = 233
        Height = 244
        DataBinding.DataField = 'FLAGS_COMPLECT'
        IntegralHeight = True
        Items = <
          item
            Text = #1055#1086#1083#1085#1099#1081' '#1082#1086#1084#1087#1083#1077#1082#1090
          end
          item
            Text = #1059#1087#1072#1082#1086#1074#1082#1072
          end
          item
            Text = #1056#1091#1082#1086#1074#1086#1076#1089#1090#1074#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          end
          item
            Text = #1052#1072#1085#1091#1072#1083
          end
          item
            Text = #1050#1086#1084#1087#1072#1082#1090' '#1076#1080#1089#1082' '#1089' '#1076#1088#1072#1081#1074#1077#1088#1072#1084#1080
          end
          item
            Text = #1050#1072#1073#1077#1083#1100' '#1087#1080#1090#1072#1085#1080#1103
          end
          item
            Text = #1050#1072#1073#1077#1083#1100' USB'
          end
          item
            Text = #1050#1072#1073#1077#1083#1080' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103
          end
          item
            Text = #1041#1083#1086#1082' '#1087#1080#1090#1072#1085#1080#1103
          end
          item
            Text = #1057#1091#1084#1082#1072
          end
          item
            Text = #1057#1087#1083#1080#1090#1090#1077#1088
          end
          item
            Text = #1053#1072#1091#1096#1085#1080#1082#1080
          end>
        ParentColor = False
        TabOrder = 2
      end
    end
    object tbsComments: TTabSheet
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label10: TLabel
        Left = 12
        Top = 12
        Width = 68
        Height = 15
        Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1080
      end
      object mmIID_COMMENTS: TcxDBMemo
        Left = 12
        Top = 28
        DataBinding.DataField = 'COMMENTS'
        DataBinding.DataSource = IBCDataSourceICOMMENTS
        ParentFont = False
        Properties.ScrollBars = ssVertical
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -13
        Style.Font.Name = 'Courier New'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        Height = 109
        Width = 613
      end
    end
  end
  object IBCQueryICOMMENTS: TIBCQuery
    SQLInsert.Strings = (
      'INSERT INTO TDB_SC_INCIDENT_COMMENT'
      '  (IID, COMMENTS)'
      'VALUES'
      '  (:IID, :COMMENTS)')
    SQLDelete.Strings = (
      'DELETE FROM TDB_SC_INCIDENT_COMMENT'
      'WHERE'
      '  IID = :Old_IID')
    SQLUpdate.Strings = (
      'UPDATE TDB_SC_INCIDENT_COMMENT'
      'SET'
      '  IID = :IID, COMMENTS = :COMMENTS'
      'WHERE'
      '  IID = :Old_IID')
    SQLRefresh.Strings = (
      'SELECT '
      ' IID, '
      ' COMMENTS '
      'FROM '
      ' TDB_SC_INCIDENT_COMMENT'
      'WHERE'
      '  IID = :IID')
    SQLLock.Strings = (
      'SELECT NULL FROM TDB_SC_INCIDENT_COMMENT'
      'WHERE'
      'IID = :Old_IID'
      'FOR UPDATE WITH LOCK')
    Connection = dmDB.IBCConnection
    Transaction = dmDB.IBCTrDefaultSelect
    SQL.Strings = (
      'SELECT '
      ' IID, '
      ' COMMENTS'
      'FROM'
      ' TDB_SC_INCIDENT_COMMENT')
    MasterFields = 'IID'
    DetailFields = 'IID'
    AutoCommit = False
    RefreshOptions = [roBeforeEdit]
    Constraints = <>
    Left = 508
    Top = 12
  end
  object IBCDataSourceICOMMENTS: TIBCDataSource
    DataSet = IBCQueryICOMMENTS
    Left = 368
    Top = 12
  end
end
