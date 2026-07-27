object frmDocTypeStatesEditorDlg: TfrmDocTypeStatesEditorDlg
  Left = 0
  Top = 0
  ActiveControl = teTitle
  BorderStyle = bsDialog
  Caption = 'Gestiune statut document'
  ClientHeight = 197
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 152
    Top = 157
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 256
    Top = 157
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 489
    Height = 137
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object teTitle: TcxDBTextEdit
      Left = 64
      Top = 16
      TabOrder = 0
      Width = 409
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 17
      Caption = 'Denumire'
    end
    object lbP1: TcxLabel
      Left = 8
      Top = 52
      Caption = 'P1'
    end
    object teIntVal: TcxDBTextEdit
      Left = 64
      Top = 48
      TabOrder = 2
      Width = 49
    end
    object cxLabel2: TcxLabel
      Left = 8
      Top = 76
      Caption = 'P2'
    end
    object teStrVal: TcxDBTextEdit
      Left = 64
      Top = 72
      TabOrder = 4
      Width = 409
    end
    object teOrderNO: TcxDBTextEdit
      Left = 64
      Top = 104
      TabOrder = 6
      Width = 49
    end
    object cxLabel3: TcxLabel
      Left = 8
      Top = 108
      Caption = 'Nr. ordine'
    end
  end
end
