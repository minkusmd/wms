object frmLockFirmsDlg: TfrmLockFirmsDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Blocarea accesului in subdiviziuni'
  ClientHeight = 526
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    686
    526)
  PixelsPerInch = 96
  TextHeight = 15
  object DialogTitle1: TDialogTitle
    Left = 0
    Top = 0
    Width = 686
    Height = 64
    Title = 'Blocarea accesului in subdiviziuni'
    Text = 'Blocarea accesului in subdiviziuni a utilizatorilor'
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
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 670
    Height = 393
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
      Left = 12
      Top = 12
      Width = 106
      Height = 15
      Caption = 'Subdiviziuni blocate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 360
      Top = 12
      Width = 112
      Height = 15
      Caption = 'Subdiviziuni deschise'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16384
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object sbUnlockItem: TSpeedButton
      Left = 316
      Top = 44
      Width = 33
      Height = 29
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbUnlockItemClick
    end
    object sbLockItem: TSpeedButton
      Left = 316
      Top = 79
      Width = 33
      Height = 29
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbLockItemClick
    end
    object sbLockAllItems: TSpeedButton
      Left = 316
      Top = 171
      Width = 33
      Height = 29
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbLockAllItemsClick
    end
    object sbUnlockAllItems: TSpeedButton
      Left = 316
      Top = 136
      Width = 33
      Height = 29
      Caption = '>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = sbUnlockAllItemsClick
    end
    object Label3: TLabel
      Left = 12
      Top = 320
      Width = 28
      Height = 15
      Caption = 'Total:'
    end
    object Label4: TLabel
      Left = 360
      Top = 320
      Width = 28
      Height = 15
      Caption = 'Total:'
    end
    object lbCounterLocked: TLabel
      Left = 52
      Top = 320
      Width = 6
      Height = 15
      Caption = '0'
    end
    object lbCounterOpen: TLabel
      Left = 400
      Top = 320
      Width = 6
      Height = 15
      Caption = '0'
    end
    object lvLockedFirms: TListView
      Left = 12
      Top = 33
      Width = 290
      Height = 285
      Columns = <
        item
          Caption = #1060#1080#1088#1084#1072
          Width = 266
        end>
      HideSelection = False
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      SmallImages = dmAdditions.cxImageList_SWN
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = lvLockedFirmsDblClick
      OnSelectItem = lvOpenFirmsSelectItem
    end
    object lvOpenFirms: TListView
      Left = 360
      Top = 33
      Width = 290
      Height = 285
      Columns = <
        item
          Caption = #1060#1080#1088#1084#1072
          Width = 266
        end>
      HideSelection = False
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      SmallImages = dmAdditions.cxImageList_SWN
      SortType = stText
      TabOrder = 1
      ViewStyle = vsReport
      OnDblClick = lvOpenFirmsDblClick
      OnSelectItem = lvOpenFirmsSelectItem
    end
    object cbPartialAccess: TCheckBox
      Left = 12
      Top = 352
      Width = 290
      Height = 17
      Caption = 'Blocheaza subdiviziunile cu acces redus'
      TabOrder = 2
    end
  end
  object btnOk: TcxButton
    Left = 475
    Top = 480
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TcxButton
    Left = 579
    Top = 480
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
end
