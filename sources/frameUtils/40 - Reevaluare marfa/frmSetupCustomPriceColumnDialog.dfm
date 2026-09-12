object frmSetupCustomPriceColumnDlg: TfrmSetupCustomPriceColumnDlg
  Left = 0
  Top = 0
  ActiveControl = cmbSourceColumn
  BorderStyle = bsDialog
  Caption = 'Setari grile de preturi'
  ClientHeight = 281
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  DesignSize = (
    571
    281)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 571
    Height = 64
    Title = 'Setari grile de preturi'
    Text = 'Setare grila de preturi pentru toate produsele'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 555
    Height = 153
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 24
      Width = 62
      Height = 15
      Caption = 'Grila initiala'
    end
    object Label2: TLabel
      Left = 376
      Top = 24
      Width = 56
      Height = 15
      Caption = 'Grila finala'
    end
    object Label3: TLabel
      Left = 209
      Top = 4
      Width = 40
      Height = 15
      Caption = 'Magine'
    end
    object Label4: TLabel
      Left = 347
      Top = 38
      Width = 12
      Height = 23
      Caption = '='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 183
      Top = 38
      Width = 12
      Height = 23
      Caption = #177
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 209
      Top = 44
      Width = 38
      Height = 15
      Caption = 'Valoare'
    end
    object cmbSourceColumn: TComboBox
      Left = 24
      Top = 41
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 1
    end
    object cmbTargetColumn: TComboBox
      Left = 376
      Top = 41
      Width = 145
      Height = 23
      Style = csDropDownList
      TabOrder = 2
    end
    object edPercent: TEdit
      Left = 209
      Top = 21
      Width = 121
      Height = 23
      TabOrder = 0
      Text = '0'
    end
    object edValue: TEdit
      Left = 209
      Top = 61
      Width = 121
      Height = 23
      TabOrder = 3
      Text = '0'
    end
  end
  object btnOk: TcxButton
    Left = 357
    Top = 236
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 461
    Top = 236
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
