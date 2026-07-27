object frmSalaryInfoEditorDlg: TfrmSalaryInfoEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
  ClientHeight = 325
  ClientWidth = 418
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
    Width = 418
    Height = 64
    Title = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1079#1072#1088#1087#1083#1072#1090#1077
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
    ImageIndex = 23
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 402
    Height = 197
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
      Width = 36
      Height = 15
      Caption = #1052#1077#1089#1103#1094
    end
    object Label2: TLabel
      Left = 20
      Top = 48
      Width = 62
      Height = 15
      Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
    end
    object Label3: TLabel
      Left = 20
      Top = 76
      Width = 37
      Height = 15
      Caption = #1057#1090#1072#1074#1082#1072
    end
    object Label4: TLabel
      Left = 20
      Top = 105
      Width = 78
      Height = 15
      Caption = #1056#1072#1073#1086#1095#1080#1077' '#1095#1072#1089#1099
    end
    object Label5: TLabel
      Left = 30
      Top = 137
      Width = 68
      Height = 15
      Caption = #1050#1086#1101#1092#1080#1094#1080#1077#1085#1090
    end
    object cmbMonth: TcxComboBox
      Left = 104
      Top = 15
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 12
      TabOrder = 0
      Width = 121
    end
    object cmbYear: TcxComboBox
      Left = 231
      Top = 15
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 12
      TabOrder = 1
      Width = 91
    end
    object lcbCUSTOMERID: TcxDBLookupComboBox
      Left = 104
      Top = 44
      DataBinding.DataField = 'CUSTOMERID'
      Properties.DropDownListStyle = lsFixedList
      Properties.DropDownRows = 20
      Properties.DropDownWidth = 340
      Properties.KeyFieldNames = 'CUSTOMERID'
      Properties.ListColumns = <
        item
          Caption = #1050#1086#1085#1090#1088#1072#1075#1077#1085#1090
          FieldName = 'DISPLAYNAME'
        end
        item
          Caption = #1060#1080#1088#1084#1072
          FieldName = 'FIRMA'
        end>
      Properties.ListSource = IBCDataSourceCust
      TabOrder = 2
      Width = 218
    end
    object edBASE_SALARY: TcxDBMaskEdit
      Left = 104
      Top = 73
      DataBinding.DataField = 'BASE_SALARY'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 3
      Width = 121
    end
    object edQTY_WORK_HOURS: TcxDBMaskEdit
      Left = 104
      Top = 102
      DataBinding.DataField = 'QTY_WORK_HOURS'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 4
      Width = 121
    end
    object edK_Grad: TcxDBMaskEdit
      Left = 104
      Top = 131
      DataBinding.DataField = 'K_GRAD'
      Properties.Alignment.Horz = taLeftJustify
      Properties.LookupItems.Strings = (
        '0'
        '10'
        '15'
        '20'
        '25'
        '30'
        '40'
        '50')
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 5
      Width = 121
    end
  end
  object btnOk: TButton
    Left = 208
    Top = 280
    Width = 90
    Height = 29
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 312
    Top = 280
    Width = 90
    Height = 29
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object IBCQueryCust: TIBCQuery
    SQL.Strings = (
      'SELECT DISTINCT'
      ' CUSTOMERID,'
      ' DEFAULT_DT,'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TS_USERS.CUSTOMERID),'
      
        ' (SELECT DISPLAYNAME FROM TS_CUSTOMER WHERE TS_CUSTOMER.CUSTOMER' +
        'ID=TS_USERS.DEFAULT_DT) FIRMA'
      'FROM TS_USERS'
      'WHERE (CUSTOMERID<>-1) AND GET_FLG_VALUE(FLAGS,0)=1'
      'ORDER BY 2,4,3')
    Left = 348
    Top = 132
  end
  object IBCDataSourceCust: TIBCDataSource
    DataSet = IBCQueryCust
    Left = 348
    Top = 180
  end
end
