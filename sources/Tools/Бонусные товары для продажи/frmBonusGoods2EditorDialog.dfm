object frmBonusGoods2EditorDlg: TfrmBonusGoods2EditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Grupa de bonusuri'
  ClientHeight = 403
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    486
    403)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 486
    Height = 64
    Title = 'Bonusuri'
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
    ImageIndex = 1
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 470
    Height = 278
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
      Left = 20
      Top = 24
      Width = 52
      Height = 15
      Caption = 'Denumire'
    end
    object Label2: TLabel
      Left = 20
      Top = 80
      Width = 46
      Height = 15
      Caption = 'Perioada'
    end
    object Label4: TLabel
      Left = 160
      Top = 138
      Width = 205
      Height = 15
      Caption = 'Cant. minima de produse in document'
    end
    object Label5: TLabel
      Left = 20
      Top = 138
      Width = 89
      Height = 15
      Caption = 'Puncte de bonus'
    end
    object Label3: TLabel
      Left = 20
      Top = 194
      Width = 91
      Height = 15
      Caption = 'Prioritatea grupei'
    end
    object edTITLE: TcxDBTextEdit
      Left = 20
      Top = 41
      DataBinding.DataField = 'TITLE'
      TabOrder = 0
      Width = 425
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 20
      Top = 97
      DataBinding.DataField = 'START_DATE'
      TabOrder = 1
      Width = 121
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 160
      Top = 97
      DataBinding.DataField = 'END_DATE'
      TabOrder = 2
      Width = 121
    end
    object edREQ_QTY: TcxDBMaskEdit
      Left = 160
      Top = 155
      DataBinding.DataField = 'REQ_QTY'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 4
      Width = 121
    end
    object edBONUS_POINTS: TcxDBMaskEdit
      Left = 20
      Top = 155
      DataBinding.DataField = 'BONUS_POINTS'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 3
      Width = 121
    end
    object edORDERNO: TcxDBMaskEdit
      Left = 20
      Top = 211
      DataBinding.DataField = 'ORDERNO'
      Properties.Alignment.Horz = taLeftJustify
      Properties.MaskKind = emkRegExprEx
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 5
      Width = 121
    end
  end
  object btnOk: TButton
    Left = 268
    Top = 361
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 365
    Top = 361
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
