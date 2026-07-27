object frmUserGroupDlg: TfrmUserGroupDlg
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Grup de utilizatori'
  ClientHeight = 667
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  DesignSize = (
    676
    667)
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 676
    Height = 64
    Title = 'Grup de utilizatori'
    Text = 'Numele grupului '#537'i ac'#539'iunile disponibile'
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
    ImageIndex = 12
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 660
    Height = 535
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'pnClient'
    Color = clWindow
    ParentBackground = False
    TabOrder = 1
    object cxLabel1: TLabel
      Left = 16
      Top = 12
      Width = 56
      Height = 15
      Caption = 'Cod grupa'
      Transparent = True
    end
    object cxLabel3: TLabel
      Left = 120
      Top = 12
      Width = 86
      Height = 15
      Caption = 'Denumire grupa'
      Transparent = True
    end
    object edDBGroupName: TcxDBTextEdit
      Left = 120
      Top = 29
      DataBinding.DataField = 'NAME'
      TabOrder = 1
      Width = 513
    end
    object edDBGroupID: TcxDBMaskEdit
      Left = 16
      Top = 29
      TabStop = False
      DataBinding.DataField = 'GROUPID'
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d+'
      Properties.MaxLength = 0
      TabOrder = 0
      Width = 85
    end
    object pcPageControl: TPageControl
      Left = 16
      Top = 81
      Width = 621
      Height = 428
      ActivePage = tbsActions
      TabOrder = 2
      object tbsActions: TTabSheet
        Caption = 'Actiunile utilizatorului'
        DesignSize = (
          613
          398)
        object cxLabel4: TLabel
          Left = 14
          Top = 2
          Width = 135
          Height = 15
          Caption = 'O c'#259'utare rapid'#259' '#238'n copac'
          Transparent = True
        end
        object Tree: TRzCheckTree
          AlignWithMargins = True
          Left = 246
          Top = 8
          Width = 359
          Height = 382
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Images = dmAdditions.cxImageList_SWN
          OnStateChange = TreeStateChange
          Align = alRight
          HideSelection = False
          Indent = 21
          PopupMenu = pmAccess
          SelectionPen.Color = clBtnShadow
          StateImages = Tree.CheckImages
          TabOrder = 0
        end
        object GroupBox1: TGroupBox
          Left = 14
          Top = 69
          Width = 221
          Height = 69
          Caption = 'Statistici'
          TabOrder = 2
          object Label1: TLabel
            Left = 12
            Top = 28
            Width = 127
            Height = 15
            Caption = 'Totalul drepturilor alese:'
          end
          object lbRightsCount: TLabel
            Left = 147
            Top = 28
            Width = 76
            Height = 15
            Caption = 'lbRightsCount'
          end
        end
        object GroupBoxTools: TGroupBox
          Left = 14
          Top = 160
          Width = 219
          Height = 229
          Anchors = [akLeft, akTop, akBottom]
          Caption = 'Instrumente'
          TabOrder = 3
          object Label2: TLabel
            Left = 12
            Top = 28
            Width = 181
            Height = 15
            Caption = 'Copierea drepturilor dintr-un grup'
          end
          object sbImportRights: TSpeedButton
            Left = 13
            Top = 49
            Width = 129
            Height = 28
            Caption = 'Selectare grup'
            Glyph.Data = {
              22020000424D220200000000000032010000280000000F0000000F0000000100
              080000000000F0000000120B0000120B00003F0000003F00000000000000FFFF
              FF00FF00FF00FFF8FF00FFF0F000F0C0B000C0A8A000D0B8B000E0C8C000F0D8
              D00090402000FFB09000A0482000B0583000F0987000E0A89000F0B8A0008040
              2000D0907000E0A08000F0B0900090706000D0B0A000E0C0B000F0D0C0009048
              2000C0785000D0886000E0987000F0A88000A0502000C0683000C0704000D080
              5000E0906000E0B8A000F0C8B000FFD8C000DEC8BA00F0C0A000FFD0B000E0A0
              7000D0987000F0B89000FFC8A000E2CCBA00EAD6C600DAD3CD0060483000E0B0
              8000A0806000C0A89000B0A09000C0B0A000D0C0B000E0D0C000F0E0D000D0C8
              C000E0D8D000F0E8E000FFF8F000D3CEC600F0F0F00002020202020202020202
              02020202020002020202020202020202020202020200020202020202200D0D1E
              1E19190A11000202020202021A3C1616163506330A000202020202021B012221
              212121061900343030303030120101043818053519003404383A370813011D1C
              222121160C00343C3129292A0F0101013C3B18161E0033013C3E3B3823010B0B
              09220D0D1E0006012C2B312927010101010E240D260035010103043B24010101
              011D1F2D02000701252838342405051014142E02020036010101013339153D02
              020202020200170101010135323D02020202020202001717363607162F020202
              020202020200}
            OnClick = sbImportRightsClick
          end
          object SpeedButton1: TSpeedButton
            Left = 13
            Top = 83
            Width = 196
            Height = 29
            Caption = 'In ce grupuri sunt utilizate'
            OnClick = SpeedButton1Click
          end
        end
        object SearchBox1: TSearchBox
          Left = 14
          Top = 24
          Width = 221
          Height = 23
          TabOrder = 1
          TextHint = 'ce cauti ?'
          OnInvokeSearch = SearchBox1InvokeSearch
        end
      end
      object tbsStructure: TTabSheet
        Caption = 'Structura catalogului de documente'
        ImageIndex = 1
        object clbStructure: TcxDBCheckListBox
          AlignWithMargins = True
          Left = 245
          Top = 8
          Width = 360
          Height = 382
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Align = alRight
          DataBinding.DataField = 'STRUCTURE_MASK'
          Items = <>
          ParentColor = False
          TabOrder = 0
        end
      end
      object tbsServicePlus: TTabSheet
        Caption = 'Suplimentar'
        ImageIndex = 2
        object cbFLG_SERVICE: TcxDBCheckBox
          Left = 24
          Top = 24
          Caption = 'Grupa Service+'
          DataBinding.DataField = 'FLG_SERVICE'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 0
        end
        object cbFLG_SERVICE_ENGINER: TcxDBCheckBox
          Left = 24
          Top = 53
          Caption = 'Grupul de ingineri Service+'
          DataBinding.DataField = 'FLG_SERVICE_ENGINER'
          Properties.Alignment = taLeftJustify
          Properties.ValueChecked = 1
          Properties.ValueUnchecked = 0
          TabOrder = 1
        end
      end
    end
  end
  object btnCancel: TcxButton
    Left = 566
    Top = 622
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TcxButton
    Left = 464
    Top = 622
    Width = 90
    Height = 29
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object pmAccess: TPopupMenu
    Images = dmAdditions.cxImageList_SWN
    OnPopup = pmAccessPopup
    Left = 524
    Top = 216
    object miSetSelected: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      OnClick = miSetSelectedClick
    end
    object miClearSelected: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      ImageIndex = 35
      OnClick = miClearSelectedClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miSelectAll: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 25
      OnClick = miSelectAllClick
    end
    object miClearAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 35
      OnClick = miSelectAllClick
    end
  end
  object pmUserGroups: TPopupMenu
    AutoHotkeys = maManual
    Left = 216
    Top = 328
  end
end
