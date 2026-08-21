object frmMergeFiltersDlg: TfrmMergeFiltersDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Merge filters'
  ClientHeight = 124
  ClientWidth = 323
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 88
    Width = 323
    CaptionCancel = 'Renunta'
    TabOrder = 4
  end
  object teOldFilterID: TcxTextEdit
    Left = 97
    Top = 9
    TabOrder = 0
    Width = 81
  end
  object cxLabel1: TcxLabel
    Left = 18
    Top = 10
    Caption = 'Cod vechi'
    TabOrder = 2
  end
  object teNewFilterID: TcxTextEdit
    Left = 97
    Top = 38
    TabOrder = 1
    Width = 81
  end
  object cxLabel2: TcxLabel
    Left = 18
    Top = 39
    Caption = 'Cod nou'
    TabOrder = 3
  end
  object IBCTrLocal: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 208
    Top = 8
  end
end
