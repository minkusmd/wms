object frmRegistruCashbackEditorDlg: TfrmRegistruCashbackEditorDlg
  Left = 0
  Top = 0
  Anchors = []
  BorderStyle = bsDialog
  Caption = 'Cashback'
  ClientHeight = 326
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    535
    326)
  PixelsPerInch = 96
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 535
    Height = 64
    Title = 'Cashback'
    Text = 'Gestiunea cashbacurilor manuale'
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
    ImageIndex = 28
  end
  object btnOk: TButton
    Left = 322
    Top = 278
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 426
    Top = 278
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 69
    Width = 525
    Height = 196
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 32
      Height = 15
      Caption = 'Client'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 78
      Width = 48
      Height = 15
      Caption = 'Perioada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 15
      Top = 132
      Width = 84
      Height = 15
      Caption = 'Suma cashback'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object deSTART_DATE: TcxDBDateEdit
      Left = 16
      Top = 99
      DataBinding.DataField = 'DATA_START'
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 1
      Width = 121
    end
    object deEND_DATE: TcxDBDateEdit
      Left = 152
      Top = 99
      DataBinding.DataField = 'DATA_END'
      Properties.DateButtons = [btnToday]
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      TabOrder = 2
      Width = 121
    end
    object beCustomer: TcxButtonEdit
      Left = 15
      Top = 41
      Properties.Buttons = <
        item
          Default = True
          ImageIndex = 13
          Kind = bkGlyph
        end
        item
          ImageIndex = 35
          Kind = bkGlyph
        end>
      Properties.ClickKey = 115
      Properties.Images = dmAdditions.cxImageList_SWN
      Properties.ViewStyle = vsHideCursor
      Properties.OnButtonClick = beCustomerPropertiesButtonClick
      Style.TextColor = clNavy
      TabOrder = 0
      Width = 489
    end
    object ceCashbackAmount: TcxDBCalcEdit
      Left = 16
      Top = 152
      DataBinding.DataField = 'AMOUNT'
      TabOrder = 3
      Width = 121
    end
  end
end
