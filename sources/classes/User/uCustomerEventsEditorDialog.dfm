object frmCustomerEventsEditorDialog: TfrmCustomerEventsEditorDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Evenimente'
  ClientHeight = 312
  ClientWidth = 477
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 477
    Height = 64
    Title = 'Eventimente personalizate a clientului'
    Text = ''
    FontTitle.Charset = DEFAULT_CHARSET
    FontTitle.Color = clWindowText
    FontTitle.Height = -13
    FontTitle.Name = 'Segoe UI'
    FontTitle.Style = [fsBold]
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    ImageList = dmAdditions.cxImageList_DialogIcons
    ImageIndex = 2
  end
  object cxLabel1: TcxLabel
    Left = 62
    Top = 111
    Caption = 'Data'
  end
  object deData: TcxDBDateEdit
    Left = 96
    Top = 110
    DataBinding.DataField = 'DATA'
    TabOrder = 3
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 10
    Top = 71
    Caption = 'Tip eveniment'
  end
  object beCustomerEventType: TcxButtonEdit
    Left = 96
    Top = 70
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
    TabOrder = 1
    Text = 'beCustomerEventType'
    Width = 361
  end
  object cxLabel3: TcxLabel
    Left = 20
    Top = 150
    Caption = 'Periodicitate'
  end
  object cePeriodicitate: TcxDBCalcEdit
    Left = 96
    Top = 149
    DataBinding.DataField = 'PERIODICITATE'
    TabOrder = 7
    Width = 65
  end
  object cxLabel4: TcxLabel
    Left = 167
    Top = 150
    Caption = '(luni)'
  end
  object cxLabel5: TcxLabel
    Left = 60
    Top = 190
    Caption = 'Nota'
  end
  object meNotes: TcxDBMemo
    Left = 96
    Top = 189
    DataBinding.DataField = 'NOTES'
    TabOrder = 10
    Height = 52
    Width = 361
  end
  object cxButton1: TcxButton
    Left = 132
    Top = 275
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 12
  end
  object cxButton2: TcxButton
    Left = 236
    Top = 275
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 13
  end
  object deNextDate: TcxDBDateEdit
    Left = 336
    Top = 110
    DataBinding.DataField = 'NEXT_DATA'
    TabOrder = 4
    Width = 121
  end
  object cxLabel6: TcxLabel
    Left = 244
    Top = 111
    Caption = 'Data urmatoare'
  end
end
