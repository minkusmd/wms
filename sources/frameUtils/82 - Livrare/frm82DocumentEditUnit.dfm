object frm82DocumentEditDlg: Tfrm82DocumentEditDlg
  Left = 0
  Top = 0
  Caption = 'Livrari'
  ClientHeight = 285
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    405
    285)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 405
    Height = 64
    Title = 'Livrari'
    Text = 'Gestionarea livrarilor'
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
    ImageIndex = 35
  end
  object Button1: TButton
    Left = 104
    Top = 248
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 209
    Top = 248
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 8
    Top = 70
    Width = 385
    Height = 153
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    ExplicitHeight = 155
    object Label1: TLabel
      Left = 8
      Top = 64
      Width = 32
      Height = 15
      Caption = 'Curier'
    end
    object Label2: TLabel
      Left = 8
      Top = 27
      Width = 59
      Height = 15
      Caption = 'Data livrarii'
    end
    object Label3: TLabel
      Left = 8
      Top = 104
      Width = 49
      Height = 15
      Caption = 'Transport'
    end
    object beCustomer: TcxButtonEdit
      Left = 84
      Top = 61
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = cxButtonEdit1PropertiesButtonClick
      TabOrder = 1
      Width = 281
    end
    object deData: TcxDBDateEdit
      Left = 84
      Top = 24
      DataBinding.DataField = 'DATA'
      TabOrder = 0
      Width = 121
    end
    object lcbTransport: TcxDBLookupComboBox
      Left = 84
      Top = 98
      DataBinding.DataField = 'TRANSPORTID'
      Properties.KeyFieldNames = 'TRANSPORTID'
      Properties.ListColumns = <
        item
          FieldName = 'NAME'
        end
        item
          FieldName = 'driver_name'
        end>
      Properties.ListSource = IBCDataSourceTransport
      TabOrder = 2
      Width = 281
    end
  end
  object IBCQueryTransport: TIBCQuery
    SQL.Strings = (
      'select * from VW_TS_TRANSPORT')
    Left = 192
    Top = 152
  end
  object IBCDataSourceTransport: TIBCDataSource
    DataSet = IBCQueryTransport
    Left = 128
    Top = 152
  end
end
