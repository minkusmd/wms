object frmECCReconcileDlg: TfrmECCReconcileDlg
  Left = 0
  Top = 0
  Caption = 'Reconciliere ECC Fiscal Partner'
  ClientHeight = 600
  ClientWidth = 1100
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  TextHeight = 16
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1100
    Height = 96
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1100
      96)
    object lblApiCode: TLabel
      Left = 12
      Top = 15
      Width = 58
      Height = 16
      Caption = 'Casa ECC:'
    end
    object lblFrom: TLabel
      Left = 300
      Top = 15
      Width = 29
      Height = 16
      Caption = 'De la'
    end
    object lblTo: TLabel
      Left = 480
      Top = 15
      Width = 38
      Height = 16
      Caption = 'Pina la'
    end
    object lblSummary: TLabel
      Left = 12
      Top = 56
      Width = 1076
      Height = 32
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      WordWrap = True
    end
    object cmbApiCode: TComboBox
      Left = 84
      Top = 11
      Width = 200
      Height = 24
      Style = csDropDownList
      TabOrder = 0
    end
    object dtFrom: TDateTimePicker
      Left = 340
      Top = 11
      Width = 125
      Height = 24
      Date = 46289.000000000000000000
      Time = 46289.000000000000000000
      TabOrder = 1
    end
    object dtTo: TDateTimePicker
      Left = 528
      Top = 11
      Width = 125
      Height = 24
      Date = 46289.000000000000000000
      Time = 46289.000000000000000000
      TabOrder = 2
    end
    object chkAutoFix: TCheckBox
      Left = 672
      Top = 14
      Width = 170
      Height = 20
      Hint =
        'Tranzactiile ramase "trimis" in jurnal, dar gasite in ECC, trec ' +
        'in "emis"'
      Caption = 'Repara automat'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 3
    end
    object btnRun: TButton
      Left = 852
      Top = 8
      Width = 120
      Height = 30
      Caption = 'Reconciliaza'
      Default = True
      TabOrder = 4
      OnClick = btnRunClick
    end
    object btnExport: TButton
      Left = 980
      Top = 8
      Width = 108
      Height = 30
      Caption = 'Export CSV'
      TabOrder = 5
      OnClick = btnExportClick
    end
  end
  object lvRows: TListView
    Left = 0
    Top = 96
    Width = 1100
    Height = 460
    Align = alClient
    Columns = <>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnCustomDrawItem = lvRowsCustomDrawItem
  end
  object pnBottom: TPanel
    Left = 0
    Top = 556
    Width = 1100
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1100
      44)
    object btnClose: TButton
      Left = 978
      Top = 7
      Width = 110
      Height = 30
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Inchide'
      ModalResult = 2
      TabOrder = 0
    end
  end
end
