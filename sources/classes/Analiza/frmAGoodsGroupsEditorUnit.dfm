object frmAGoodsGroupsEditorDlg: TfrmAGoodsGroupsEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Grupele de produse pentru analiza'
  ClientHeight = 150
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 444
    Height = 89
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 8
      Top = 16
      Caption = 'Denumire'
    end
    object teTITLE: TcxDBTextEdit
      Left = 8
      Top = 40
      DataBinding.DataField = 'TITLE'
      ParentFont = False
      Style.Font.Charset = RUSSIAN_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -12
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 417
    end
  end
  object cxButton1: TcxButton
    Left = 144
    Top = 112
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 240
    Top = 112
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 2
  end
end
