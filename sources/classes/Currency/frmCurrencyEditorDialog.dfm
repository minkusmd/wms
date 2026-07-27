object frmCurrencyEditorDlg: TfrmCurrencyEditorDlg
  Left = 0
  Top = 0
  ActiveControl = edTRANSFER_RATE
  BorderStyle = bsDialog
  Caption = 'Modifica rata de schimb valutar'
  ClientHeight = 188
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    319
    188)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 319
    Height = 64
    Title = 'Modifica rata'
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
    ImageIndex = 4
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 303
    Height = 57
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
    ExplicitLeft = 3
    ExplicitTop = 75
    ExplicitHeight = 156
    object Label4: TLabel
      Left = 19
      Top = 17
      Width = 81
      Height = 15
      Caption = 'Rata de schimb'
    end
    object edTRANSFER_RATE: TcxDBCalcEdit
      Left = 167
      Top = 15
      DataBinding.DataField = 'TRANSFER_RATE'
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      TabOrder = 0
      Width = 93
    end
  end
  object btnOk: TcxButton
    Left = 104
    Top = 140
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    ExplicitTop = 239
  end
  object btnCancel: TcxButton
    Left = 210
    Top = 140
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
    ExplicitTop = 239
  end
  object NetHTTPClient1: TNetHTTPClient
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 201
    Top = 6
  end
end
