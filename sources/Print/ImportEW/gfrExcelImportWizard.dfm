object gfrExcelImportForm: TgfrExcelImportForm
  Left = 358
  Top = 118
  Caption = 'gfrExcelImportForm'
  ClientHeight = 346
  ClientWidth = 442
  Color = clBtnFace
  Constraints.MinHeight = 380
  Constraints.MinWidth = 450
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    442
    346)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 3
    Width = 70
    Height = 13
    Caption = #1055#1091#1090#1100' '#1082' '#1092#1072#1081#1083#1091':'
  end
  object edFileName: TEdit
    Left = 8
    Top = 20
    Width = 331
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Ctl3D = True
    Enabled = False
    ParentCtl3D = False
    TabOrder = 0
    Text = #1048#1084#1103' '#1092#1072#1081#1083#1072
  end
  object btnOpen: TButton
    Left = 351
    Top = 19
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1090#1082#1088#1099#1090#1100'...'
    TabOrder = 1
    OnClick = btnOpenClick
  end
  object btnImport: TButton
    Left = 258
    Top = 296
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1048#1084#1087#1086#1088#1090
    TabOrder = 2
    OnClick = btnImportClick
  end
  object gbPages: TGroupBox
    Left = 8
    Top = 45
    Width = 235
    Height = 276
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1057#1090#1088#1072#1085#1080#1094#1099
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 3
    DesignSize = (
      235
      276)
    object sheetsList: TCheckListBox
      Left = 8
      Top = 16
      Width = 219
      Height = 217
      OnClickCheck = sheetsListClickCheck
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = True
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      OnClick = sheetsListClick
    end
    object btnCheckAll: TBitBtn
      Left = 10
      Top = 240
      Width = 106
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077
      TabOrder = 1
      OnClick = btnCheckAllClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
    object btnUncheckAll: TBitBtn
      Left = 122
      Top = 240
      Width = 106
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1085#1103#1090#1100' '#1087#1086#1084#1077#1090#1082#1091
      TabOrder = 2
      OnClick = btnUncheckAllClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 258
    Top = 45
    Width = 177
    Height = 244
    Anchors = [akTop, akRight, akBottom]
    Caption = #1043#1088#1072#1085#1080#1094#1099' '#1089#1090#1088#1072#1085#1080#1094
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 4
    object Label6: TLabel
      Left = 8
      Top = 192
      Width = 49
      Height = 13
      Caption = #1052#1072#1089#1096#1090#1072#1073':'
    end
    object rbPrintArea: TRadioButton
      Left = 8
      Top = 16
      Width = 161
      Height = 17
      Caption = #1054#1073#1083#1072#1089#1090#1100' '#1087#1077#1095#1072#1090#1080
      Ctl3D = True
      Enabled = False
      ParentCtl3D = False
      TabOrder = 0
      OnClick = rbPrintAreaClick
    end
    object rbUsedRange: TRadioButton
      Left = 8
      Top = 52
      Width = 161
      Height = 17
      Hint = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1079#1085#1072#1095#1077#1085#1080#1077' UsedRange'
      Caption = #1042#1077#1089#1100' '#1083#1080#1089#1090
      Checked = True
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      TabStop = True
      OnClick = rbUsedRangeClick
    end
    object rbManual: TRadioButton
      Left = 8
      Top = 70
      Width = 161
      Height = 17
      Caption = #1047#1072#1076#1072#1085#1085#1072#1103' '#1086#1073#1083#1072#1089#1090#1100
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      OnClick = rbManualClick
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 96
      Width = 161
      Height = 41
      Caption = #1053#1072#1095#1072#1083#1100#1085#1072#1103' '#1103#1095#1077#1081#1082#1072
      TabOrder = 3
      object Label2: TLabel
        Left = 8
        Top = 16
        Width = 46
        Height = 13
        Caption = #1050#1086#1083#1086#1085#1082#1072':'
      end
      object Label3: TLabel
        Left = 88
        Top = 16
        Width = 39
        Height = 13
        Caption = #1057#1090#1088#1086#1082#1072':'
      end
      object edColStart: TEdit
        Left = 56
        Top = 14
        Width = 25
        Height = 21
        CharCase = ecUpperCase
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        OnExit = manualRange
      end
      object edRowStart: TEdit
        Left = 128
        Top = 14
        Width = 25
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        OnExit = manualRange
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 144
      Width = 161
      Height = 41
      Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1103#1095#1077#1081#1082#1072
      TabOrder = 4
      object Label4: TLabel
        Left = 8
        Top = 16
        Width = 46
        Height = 13
        Caption = #1050#1086#1083#1086#1085#1082#1072':'
      end
      object Label5: TLabel
        Left = 88
        Top = 16
        Width = 39
        Height = 13
        Caption = #1057#1090#1088#1086#1082#1072':'
      end
      object edColEnd: TEdit
        Left = 56
        Top = 14
        Width = 25
        Height = 21
        CharCase = ecUpperCase
        Enabled = False
        ReadOnly = True
        TabOrder = 0
        OnExit = manualRange
      end
      object edRowEnd: TEdit
        Left = 128
        Top = 14
        Width = 25
        Height = 21
        Enabled = False
        ReadOnly = True
        TabOrder = 1
        OnExit = manualRange
      end
    end
    object cbMaxAccuracy: TCheckBox
      Left = 72
      Top = 216
      Width = 97
      Height = 17
      Caption = 'cbMaxAccuracy'
      TabOrder = 5
      Visible = False
    end
    object edKoef: TEdit
      Left = 64
      Top = 191
      Width = 105
      Height = 21
      TabOrder = 6
      Text = '1.3'
    end
    object cbDivByPages: TCheckBox
      Left = 24
      Top = 34
      Width = 145
      Height = 17
      Caption = #1056#1072#1079#1073#1080#1074#1082#1072' '#1087#1086' '#1089#1090#1088#1072#1085#1080#1094#1072#1084
      TabOrder = 7
    end
    object cbFitWidth: TCheckBox
      Left = 8
      Top = 216
      Width = 57
      Height = 17
      Caption = 'FitWidth'
      Checked = True
      State = cbChecked
      TabOrder = 8
      Visible = False
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 328
    Width = 442
    Height = 18
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object btnCancel: TButton
    Left = 350
    Top = 296
    Width = 85
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = btnCancelClick
  end
  object OpenDialog: TOpenDialog
    Ctl3D = False
    DefaultExt = 'xls'
    Filter = 
      #1060#1072#1081#1083#1099' Excel|*.xl*; *.xls; *.xla; *.xlt; *.xlm; *.xlc; *.xlw|'#1042#1089#1077' ' +
      #1092#1072#1081#1083#1099'|*.*'
    Left = 32
    Top = 101
  end
  object XPManifest1: TXPManifest
    Left = 32
    Top = 64
  end
end
