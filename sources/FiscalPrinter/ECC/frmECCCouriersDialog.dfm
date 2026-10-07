object frmECCCouriersDlg: TfrmECCCouriersDlg
  Left = 0
  Top = 0
  Caption = 'Curieri ECC'
  ClientHeight = 480
  ClientWidth = 1020
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 16
  object pnTop: TPanel
    Left = 0
    Top = 0
    Width = 1020
    Height = 76
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      1020
      76)
    object lblApiCode: TLabel
      Left = 12
      Top = 15
      Width = 58
      Height = 16
      Caption = 'Casa ECC:'
    end
    object lblHint: TLabel
      Left = 12
      Top = 48
      Width = 996
      Height = 20
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
    end
    object cmbApiCode: TComboBox
      Left = 84
      Top = 11
      Width = 200
      Height = 24
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbApiCodeChange
    end
    object btnAdd: TButton
      Left = 300
      Top = 8
      Width = 100
      Height = 30
      Caption = 'Adauga'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 406
      Top = 8
      Width = 100
      Height = 30
      Caption = 'Modifica'
      TabOrder = 2
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 512
      Top = 8
      Width = 100
      Height = 30
      Caption = 'Sterge'
      TabOrder = 3
      OnClick = btnDeleteClick
    end
    object btnEccCashiers: TButton
      Left = 630
      Top = 8
      Width = 160
      Height = 30
      Caption = 'Casieri din ECC...'
      TabOrder = 4
      OnClick = btnEccCashiersClick
    end
  end
  object lvCouriers: TListView
    Left = 0
    Top = 76
    Width = 1020
    Height = 360
    Align = alClient
    Columns = <>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = lvCouriersDblClick
  end
  object pnBottom: TPanel
    Left = 0
    Top = 436
    Width = 1020
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      1020
      44)
    object btnClose: TButton
      Left = 898
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
