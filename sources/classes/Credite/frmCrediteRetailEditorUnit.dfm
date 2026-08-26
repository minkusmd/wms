object frmCrediteRetailEditorDlg: TfrmCrediteRetailEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Credite editor'
  ClientHeight = 201
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 160
    Width = 472
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object btnOK: TcxButton
      Left = 136
      Top = 7
      Width = 90
      Height = 29
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TcxButton
      Left = 256
      Top = 7
      Width = 90
      Height = 29
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 466
    Height = 154
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitLeft = 8
    ExplicitTop = 0
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 71
      Height = 15
      Caption = 'Denumire RO'
    end
    object Label2: TLabel
      Left = 25
      Top = 64
      Width = 70
      Height = 15
      Caption = 'Denumire RU'
    end
    object Label3: TLabel
      Left = 25
      Top = 104
      Width = 40
      Height = 15
      Caption = 'Cost, %'
    end
    object edTitleRo: TcxDBTextEdit
      Left = 112
      Top = 21
      ParentFont = False
      TabOrder = 0
      Width = 329
    end
    object edTitleRu: TcxDBTextEdit
      Left = 112
      Top = 61
      ParentFont = False
      TabOrder = 1
      Width = 329
    end
    object ceCost: TcxDBCalcEdit
      Left = 112
      Top = 101
      ParentFont = False
      TabOrder = 2
      Width = 73
    end
  end
end
