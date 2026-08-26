object frmPricePolicyFolderDlg: TfrmPricePolicyFolderDlg
  Left = 0
  Top = 0
  ActiveControl = DBLabeledEdit1
  Caption = 'frmPricePolicyFolderDlg'
  ClientHeight = 129
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object DBLabeledEdit1: TDBLabeledEdit
    Left = 8
    Top = 40
    Width = 329
    Height = 23
    TabOrder = 0
    EditLabel.Width = 52
    EditLabel.Height = 15
    EditLabel.Caption = 'Denumire'
    LabelSpacing = 6
  end
  object cxButton1: TcxButton
    Left = 72
    Top = 96
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 168
    Top = 96
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
