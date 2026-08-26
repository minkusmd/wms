object frmFiscalPrinterServiceDlg: TfrmFiscalPrinterServiceDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MCC Mententanta'
  ClientHeight = 381
  ClientWidth = 638
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 638
    Height = 64
    Title = 'Imprimanta fiscala'
    Text = 'Mentenanta '
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
    ImageIndex = 26
  end
  object cxPageControl: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 622
    Height = 253
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    ActivePage = tbsInfo
    Align = alTop
    TabOrder = 1
    object tbsInfo: TTabSheet
      Caption = 'Informatie'
      ImageIndex = 5
      object lbInfo1: TLabel
        Left = 16
        Top = 50
        Width = 77
        Height = 15
        Caption = 'Numarul fiscal'
      end
      object lbInfo2: TLabel
        Left = 16
        Top = 76
        Width = 97
        Height = 15
        Caption = 'Numarul Fiscalizat'
      end
      object lbIDEN: TLabel
        Left = 145
        Top = 50
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbVAT: TLabel
        Left = 145
        Top = 76
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 16
        Top = 105
        Width = 73
        Height = 15
        Caption = 'Data si timpul'
      end
      object lbFP_DateTime: TLabel
        Left = 145
        Top = 105
        Width = 3
        Height = 15
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbFPDateTimeWarning: TLabel
        Left = 16
        Top = 126
        Width = 383
        Height = 75
        Caption = 
          #13#10'Timpul la imprimanta esential difera de cel de la calculator. ' +
          'Setati timpul curent la imprimanta pentru a evita problemele ult' +
          'erioare!'#13#10#13#10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label3: TLabel
        Left = 16
        Top = 20
        Width = 101
        Height = 15
        Caption = 'Imprimanta fiscala:'
      end
      object lbPrinterInfo: TLabel
        Left = 145
        Top = 20
        Width = 444
        Height = 15
        Margins.Left = 4
        Margins.Top = 2
        Margins.Right = 4
        Margins.Bottom = 2
        AutoSize = False
        Caption = 'Tipar la imprimanta fiscala'
      end
      object lbInvalidTVAGroup: TLabel
        Left = 16
        Top = 177
        Width = 354
        Height = 15
        Caption = 
          'Atentie! Valoare incorecta pentru grupa ! Imediat corectati valo' +
          'area!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnSetupFPDateTime: TcxButton
        Left = 452
        Top = 111
        Width = 137
        Height = 48
        Caption = 'Modificarea datei si timpului'
        TabOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = btnSetupFPDateTimeClick
      end
    end
    object tbsXReport: TTabSheet
      Caption = 'Rapoarte'
      ImageIndex = 1
      object Label4: TLabel
        AlignWithMargins = True
        Left = 28
        Top = 36
        Width = 432
        Height = 45
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Caption = 
          #1061'-'#1086#1090#1095#1077#1090' '#1085#1077' '#1103#1074#1083#1103#1077#1090#1089#1103' '#1092#1080#1089#1082#1072#1083#1100#1085#1099#1084' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1084' '#1080' '#1089#1084#1077#1085#1091' '#1085#1077' '#1086#1090#1082#1088#1099#1074#1072#1077#1090'. ' +
          #13#1069#1090#1086#1090' '#1086#1090#1095#1077#1090' '#1087#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085' '#1076#1083#1103' '#1082#1086#1085#1090#1088#1086#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1082#1072#1089#1089#1080#1088#1072' '#1080' '#1087#1086#1082#1072#1079#1099#1074#1072#1077 +
          #1090' '#1089#1082#1086#1083#1100#1082#1086' '#1086#1087#1077#1088#1072#1094#1080#1081' '#1080' '#1082#1072#1082#1080#1077' '#1089#1091#1084#1084#1099' '#1073#1099#1083#1080' '#1087#1088#1086#1074#1077#1076#1077#1085#1099' '#1074' '#1090#1077#1095#1077#1085#1080#1080' '#1089#1084#1077#1085#1099' ' +
          '('#1088#1072#1073#1086#1095#1077#1075#1086' '#1076#1085#1103').'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 28
        Top = 116
        Width = 430
        Height = 60
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Caption = 
          'Z-'#1086#1090#1095#1077#1090' '#1079#1072#1082#1088#1099#1074#1072#1077#1090' '#1089#1084#1077#1085#1091', '#1090'.'#1077'. '#1079#1072#1087#1080#1089#1099#1074#1072#1077#1090' '#1090#1077#1082#1091#1097#1091#1102' '#1089#1084#1077#1085#1085#1091#1102' '#1074#1099#1088#1091#1095#1082#1091 +
          ' '#1074' '#1092#1080#1089#1082#1072#1083#1100#1085#1091#1102' '#1087#1072#1084#1103#1090#1100' '#1082#1072#1089#1089#1086#1074#1086#1075#1086' '#1072#1087#1072#1088#1072#1090#1072' '#1080' '#1086#1095#1080#1097#1072#1077#1090' '#1089#1091#1084#1084#1080#1088#1091#1102#1097#1080#1081' '#1076#1077#1085 +
          #1077#1078#1085#1099#1081' '#1089#1095#1077#1090#1095#1080#1082' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1084#1077#1085#1099'.'#13#1055#1086#1082#1072#1079#1072#1085#1080#1103' '#1086#1090#1095#1077#1090#1072' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1079#1072#1087 +
          #1080#1089#1099#1074#1072#1090#1100' '#1074' '#1078#1091#1088#1085#1072#1083' '#1082#1072#1089#1089#1080#1088#1072'-'#1086#1087#1077#1088#1072#1094#1080#1086#1085#1080#1089#1090#1072'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label1: TLabel
        Left = 16
        Top = 20
        Width = 44
        Height = 15
        Caption = 'X '#1054#1090#1095#1077#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 16
        Top = 100
        Width = 43
        Height = 15
        Caption = 'Z '#1054#1090#1095#1077#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnPrint_X_Report: TcxButton
        Left = 488
        Top = 36
        Width = 109
        Height = 37
        Caption = 'Tipar X raport'
        TabOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = btnPrint_X_ReportClick
      end
      object btnPrint_Z_Report: TcxButton
        Left = 488
        Top = 116
        Width = 109
        Height = 37
        Caption = 'Tipar Z raport'
        TabOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = btnPrint_Z_ReportClick
      end
    end
    object tbsYearReport: TTabSheet
      Caption = 'Rapoarte anuale'
      ImageIndex = 4
      OnShow = tbsYearReportShow
      object Label6: TLabel
        Left = 16
        Top = 20
        Width = 70
        Height = 15
        Caption = 'Raport anual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        AlignWithMargins = True
        Left = 28
        Top = 46
        Width = 143
        Height = 30
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Caption = 'Z-raport pe perioada(scurt)'#13#10
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object cxGroupBox1: TcxGroupBox
        Left = 271
        Top = 75
        Caption = 'Perioada'
        TabOrder = 1
        Height = 126
        Width = 298
        object cxDateEdit1: TcxDateEdit
          Left = 16
          Top = 32
          TabOrder = 0
          Width = 121
        end
        object cxDateEdit2: TcxDateEdit
          Left = 160
          Top = 32
          TabOrder = 1
          Width = 121
        end
        object Button1: TcxButton
          Left = 160
          Top = 77
          Width = 121
          Height = 38
          Caption = 'Tipar perioada anual'
          TabOrder = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          OnClick = Button1Click
        end
      end
      object cxGroupBox2: TcxGroupBox
        Left = 3
        Top = 75
        Caption = 'Anual'
        TabOrder = 0
        Height = 126
        Width = 262
        object Label11: TLabel
          Left = 20
          Top = 27
          Width = 18
          Height = 15
          Caption = 'An:'
        end
        object cmbReportYear: TComboBox
          Left = 48
          Top = 24
          Width = 93
          Height = 23
          Style = csDropDownList
          TabOrder = 0
        end
        object btnPrintYearReport: TcxButton
          Left = 144
          Top = 79
          Width = 109
          Height = 38
          Caption = 'Tipar raport anual'
          TabOrder = 1
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          OnClick = btnPrintYearReportClick
        end
      end
    end
    object tbsTill: TTabSheet
      Caption = 'Lada cu bani'
      ImageIndex = 3
      object Label8: TLabel
        Left = 12
        Top = 20
        Width = 126
        Height = 30
        Caption = 'Deschiderea boxului cu bani'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object btnOpenTill: TcxButton
        Left = 444
        Top = 20
        Width = 161
        Height = 37
        Caption = 'Deschide'
        TabOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = btnOpenTillClick
      end
    end
    object tbsError: TTabSheet
      Caption = 'Eroare a imprimantei'
      ImageIndex = 4
      object Label9: TLabel
        AlignWithMargins = True
        Left = 16
        Top = 16
        Width = 562
        Height = 60
        Margins.Left = 16
        Margins.Top = 16
        Margins.Right = 16
        Margins.Bottom = 16
        Align = alTop
        Caption = 
          #1045#1089#1083#1080' '#1087#1088#1086#1080#1079#1086#1096#1077#1083' '#1089#1073#1086#1081' '#1087#1088#1080' '#1087#1077#1095#1072#1090#1080' '#1087#1088#1080#1085#1090#1077#1088#1072' '#1080' '#1086#1087#1077#1088#1072#1094#1080#1103' '#1087#1077#1095#1072#1090#1080' '#1095#1077#1082#1072' '#1085 +
          #1077' '#1073#1099#1083#1072' '#1079#1072#1082#1086#1085#1095#1077#1085#1072', '#1087#1086#1087#1088#1086#1073#1091#1081#1090#1077' '#1086#1090#1084#1077#1085#1080#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1080#1102' '#1086#1087#1077#1088#1072#1094#1080#1102'.'#13#1045#1089#1083#1080' '#1086 +
          #1090#1084#1077#1085#1072' '#1095#1077#1082#1072' '#1073#1099#1083#1072' '#1091#1089#1087#1077#1096#1085#1086#1081', '#1090#1086' '#1095#1077#1082' '#1089#1095#1080#1090#1072#1077#1090#1089#1103' '#1085#1077#1076#1077#1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1099#1081'. '#1044#1083#1103 +
          ' '#1087#1088#1086#1074#1077#1088#1082#1080' '#1092#1072#1082#1090#1072' '#1086#1090#1084#1077#1085#1099', '#1089#1084#1086#1090#1088#1080#1090#1077' '#1095#1077#1082' - '#1076#1086#1083#1078#1085#1072' '#1073#1099#1090#1100' '#1079#1072#1087#1080#1089#1100' '#1086' '#1085#1077#1076#1077 +
          #1081#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1080' '#1095#1077#1082#1072'.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object mmErrors: TMemo
        Left = 16
        Top = 87
        Width = 433
        Height = 118
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        WantReturns = False
      end
      object btnAbortReceipt: TcxButton
        Left = 472
        Top = 87
        Width = 121
        Height = 57
        Caption = 'Anuleaza ultimul cec'
        TabOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        OnClick = btnAbortReceiptClick
      end
    end
  end
  object btnClose: TcxButton
    Left = 527
    Top = 344
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Inchide'
    Default = True
    ModalResult = 2
    TabOrder = 2
  end
end
