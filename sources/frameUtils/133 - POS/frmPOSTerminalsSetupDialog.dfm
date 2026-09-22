object frmPOSTerminalsSetupDlg: TfrmPOSTerminalsSetupDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Case POS'
  ClientHeight = 440
  ClientWidth = 1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 17
  object lblInfo: TLabel
    Left = 16
    Top = 12
    Width = 1048
    Height = 17
    AutoSize = False
    Caption =
      'O casa = firma + calculatorul pe care ruleaza + aparatul fiscal' +
      ' + depozitul din care vinde. Interfata POS isi recunoaste casa d' +
      'upa firma curenta si numele calculatorului.'
  end
  object lvTerminals: TListView
    Left = 16
    Top = 38
    Width = 1048
    Height = 340
    Columns = <
      item
        Caption = 'Casa'
        Width = 150
      end
      item
        Caption = 'Firma'
        Width = 150
      end
      item
        Caption = 'Depozit'
        Width = 130
      end
      item
        Caption = 'Calculator'
        Width = 120
      end
      item
        Caption = 'Aparat fiscal'
        Width = 130
      end
      item
        Caption = 'Client implicit'
        Width = 150
      end
      item
        Alignment = taCenter
        Caption = 'Col. pret'
        Width = 60
      end
      item
        Alignment = taCenter
        Caption = 'Red. max'
        Width = 65
      end
      item
        Alignment = taCenter
        Caption = 'Activa'
        Width = 50
      end
      item
        Alignment = taCenter
        Caption = 'Tura'
        Width = 60
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvTerminalsDblClick
    OnSelectItem = lvTerminalsSelectItem
  end
  object btnNew: TButton
    Left = 16
    Top = 390
    Width = 130
    Height = 34
    Caption = 'Casa noua'
    TabOrder = 1
    OnClick = btnNewClick
  end
  object btnEdit: TButton
    Left = 154
    Top = 390
    Width = 130
    Height = 34
    Caption = 'Modifica'
    TabOrder = 2
    OnClick = btnEditClick
  end
  object btnDelete: TButton
    Left = 292
    Top = 390
    Width = 130
    Height = 34
    Caption = 'Sterge'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnClose: TButton
    Left = 934
    Top = 390
    Width = 130
    Height = 34
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 2
    TabOrder = 4
  end
end
