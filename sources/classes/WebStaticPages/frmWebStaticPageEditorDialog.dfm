object frmWebStaticPageEditorDlg: TfrmWebStaticPageEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Pagini statice pe web site'
  ClientHeight = 820
  ClientWidth = 1118
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 1118
    Height = 64
    Title = 'Pagini statite pe site'
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
    ImageIndex = 30
  end
  object pnClient: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 72
    Width = 1102
    Height = 700
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 3
    object Label5: TLabel
      Left = 156
      Top = 16
      Width = 119
      Height = 15
      Caption = 'Identificatorul paginii'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 23
      Top = 38
      Width = 127
      Height = 15
      Caption = 'www.website.md/page/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 439
      Top = 38
      Width = 24
      Height = 15
      Caption = '.php'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object edPAGEID: TcxDBTextEdit
      Left = 156
      Top = 34
      DataBinding.DataField = 'PAGEID'
      ParentFont = False
      Properties.CharCase = ecLowerCase
      Style.Color = 13041663
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Verdana'
      Style.Font.Style = []
      Style.TextColor = clMaroon
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 277
    end
    object cbFLG_ENABLED: TcxDBCheckBox
      Left = 961
      Top = 38
      Caption = 'Pagina este activa'
      DataBinding.DataField = 'FLG_ENABLED'
      ParentFont = False
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      TabOrder = 1
    end
    object cxPageControl1: TcxPageControl
      Left = 20
      Top = 67
      Width = 1061
      Height = 606
      TabOrder = 2
      Properties.ActivePage = cxTabSheet3
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 602
      ClientRectLeft = 4
      ClientRectRight = 1057
      ClientRectTop = 26
      object cxTabSheet3: TcxTabSheet
        Caption = 'Informatii generale'
        ImageIndex = 1
        object cxPageControl2: TcxPageControl
          Left = 0
          Top = 0
          Width = 1053
          Height = 576
          Align = alClient
          TabOrder = 0
          Properties.ActivePage = cxTabSheet4
          Properties.CustomButtons.Buttons = <>
          ClientRectBottom = 572
          ClientRectLeft = 4
          ClientRectRight = 1049
          ClientRectTop = 26
          object cxTabSheet5: TcxTabSheet
            Caption = 'RO'
            ImageIndex = 1
            DesignSize = (
              1045
              546)
            object Label2: TLabel
              Left = 3
              Top = 8
              Width = 100
              Height = 15
              Caption = 'Denumirea paginei'
            end
            object Label4: TLabel
              Left = 3
              Top = 55
              Width = 99
              Height = 15
              Caption = 'Con'#539'inutul paginei'
            end
            object edTITLE_ROM: TcxDBTextEdit
              Left = 3
              Top = 26
              DataBinding.DataField = 'TITLE_ROM'
              ParentFont = False
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -13
              Style.Font.Name = 'Courier New'
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 0
              Width = 1039
            end
            object mmBODY_ROM: TSynEdit
              Left = 2
              Top = 73
              Width = 1040
              Height = 474
              Anchors = [akLeft, akTop, akRight, akBottom]
              ActiveLineColor = clInfoBk
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Consolas'
              Font.Pitch = fpFixed
              Font.Style = []
              Font.Quality = fqClearTypeNatural
              TabOrder = 1
              CodeFolding.ShowCollapsedLine = True
              UseCodeFolding = False
              Gutter.Font.Charset = DEFAULT_CHARSET
              Gutter.Font.Color = clWindowText
              Gutter.Font.Height = -11
              Gutter.Font.Name = 'Courier New'
              Gutter.Font.Style = []
              Gutter.Font.Quality = fqClearTypeNatural
              Gutter.Bands = <
                item
                  Kind = gbkMarks
                  Width = 13
                end
                item
                  Kind = gbkLineNumbers
                end
                item
                  Kind = gbkFold
                end
                item
                  Kind = gbkTrackChanges
                end
                item
                  Kind = gbkMargin
                  Width = 3
                end>
              Highlighter = SynHTMLSyn1
              Lines.Strings = (
                'mmBODY_ROM')
              RightEdge = 120
              SelectedColor.Alpha = 0.400000005960464500
            end
          end
          object cxTabSheet4: TcxTabSheet
            Caption = 'RU'
            ImageIndex = 0
            DesignSize = (
              1045
              546)
            object Label1: TLabel
              Left = 3
              Top = 8
              Width = 109
              Height = 15
              Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1090#1088#1072#1085#1080#1094#1099
            end
            object Label3: TLabel
              Left = 3
              Top = 55
              Width = 126
              Height = 15
              Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1089#1090#1088#1072#1085#1080#1094#1099
            end
            object edTITLE_RUS: TcxDBTextEdit
              Left = 3
              Top = 26
              DataBinding.DataField = 'TITLE_RUS'
              ParentFont = False
              Style.Font.Charset = DEFAULT_CHARSET
              Style.Font.Color = clWindowText
              Style.Font.Height = -13
              Style.Font.Name = 'Courier New'
              Style.Font.Style = []
              Style.IsFontAssigned = True
              TabOrder = 0
              Width = 1039
            end
            object mmBODY_RUS: TSynEdit
              Left = 3
              Top = 76
              Width = 1040
              Height = 474
              Anchors = [akLeft, akTop, akRight, akBottom]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Consolas'
              Font.Pitch = fpFixed
              Font.Style = []
              Font.Quality = fqClearTypeNatural
              TabOrder = 1
              CodeFolding.ShowCollapsedLine = True
              UseCodeFolding = False
              Gutter.Font.Charset = DEFAULT_CHARSET
              Gutter.Font.Color = clWindowText
              Gutter.Font.Height = -11
              Gutter.Font.Name = 'Courier New'
              Gutter.Font.Style = []
              Gutter.Font.Quality = fqClearTypeNatural
              Gutter.Bands = <
                item
                  Kind = gbkMarks
                  Width = 13
                end
                item
                  Kind = gbkLineNumbers
                end
                item
                  Kind = gbkFold
                end
                item
                  Kind = gbkTrackChanges
                end
                item
                  Kind = gbkMargin
                  Width = 3
                end>
              Highlighter = SynHTMLSyn1
              Lines.Strings = (
                'mmBODY_RUS')
              RightEdge = 120
              SelectedColor.Alpha = 0.400000005960464500
            end
          end
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'META Tags'
        ImageIndex = 1
        object cxLabel1: TcxLabel
          Left = 16
          Top = 16
          Caption = 'Title RO'
          ParentFont = False
        end
        object teTitleRO: TcxDBTextEdit
          Left = 67
          Top = 15
          DataBinding.DataField = 'META_TITLE_RO'
          ParentFont = False
          TabOrder = 0
          Width = 973
        end
        object teTitleRU: TcxDBTextEdit
          Left = 68
          Top = 44
          DataBinding.DataField = 'META_TITLE_RU'
          ParentFont = False
          TabOrder = 3
          Width = 973
        end
        object cxLabel2: TcxLabel
          Left = 16
          Top = 44
          Caption = 'Title RU'
          ParentFont = False
        end
        object teDescRO: TcxDBTextEdit
          Left = 68
          Top = 87
          DataBinding.DataField = 'META_DESC_RO'
          ParentFont = False
          TabOrder = 4
          Width = 973
        end
        object cxLabel3: TcxLabel
          Left = 16
          Top = 88
          Caption = 'Desc RO'
          ParentFont = False
        end
        object teDescRU: TcxDBTextEdit
          Left = 68
          Top = 116
          DataBinding.DataField = 'META_DESC_RU'
          ParentFont = False
          TabOrder = 6
          Width = 973
        end
        object cxLabel4: TcxLabel
          Left = 16
          Top = 117
          Caption = 'Desc RU'
          ParentFont = False
        end
        object teKeysRO: TcxDBTextEdit
          Left = 69
          Top = 157
          DataBinding.DataField = 'META_KEY_RO'
          ParentFont = False
          TabOrder = 8
          Width = 973
        end
        object cxLabel5: TcxLabel
          Left = 16
          Top = 158
          Caption = 'Keys RO'
          ParentFont = False
        end
        object cxLabel6: TcxLabel
          Left = 16
          Top = 187
          Caption = 'Keys RU'
          ParentFont = False
        end
        object teKeysRU: TcxDBTextEdit
          Left = 68
          Top = 186
          DataBinding.DataField = 'META_KEY_RU'
          ParentFont = False
          TabOrder = 10
          Width = 973
        end
      end
    end
  end
  object btnOk: TButton
    Left = 893
    Top = 783
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 1001
    Top = 783
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 3
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 552
    Top = 408
  end
end
