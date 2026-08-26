object frmMergeSyssDlg: TfrmMergeSyssDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Uneste 2 elemente'
  ClientHeight = 203
  ClientWidth = 493
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object RzDialogButtons1: TRzDialogButtons
    Left = 0
    Top = 167
    Width = 493
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 167
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 26
      Top = 23
      Width = 130
      Height = 15
      Caption = 'Elementul care va fi sters'
    end
    object Label2: TLabel
      Left = 26
      Top = 82
      Width = 133
      Height = 15
      Caption = 'Elementul care va ramine'
    end
    object nbOldElement: TNumberBox
      Left = 26
      Top = 44
      Width = 55
      Height = 23
      TabOrder = 0
    end
    object nbNewElement: TNumberBox
      Left = 26
      Top = 103
      Width = 55
      Height = 23
      TabOrder = 2
    end
    object edOldElementTitle: TEdit
      Left = 87
      Top = 44
      Width = 393
      Height = 23
      TabOrder = 1
    end
    object edNewElementTitle: TEdit
      Left = 87
      Top = 103
      Width = 393
      Height = 23
      TabOrder = 3
    end
  end
end
