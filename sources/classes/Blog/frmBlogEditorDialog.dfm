object frmBlogEditorDlg: TfrmBlogEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Blog editor'
  ClientHeight = 720
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 721
    Height = 679
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 24
      Top = 21
      Caption = 'Titlu'
      ParentFont = False
      TabOrder = 1
    end
    object edtTitleRo: TcxDBTextEdit
      Left = 82
      Top = 20
      DataBinding.DataField = 'TITLE_RO'
      ParentFont = False
      TabOrder = 0
      Width = 623
    end
    object cxLabel2: TcxLabel
      Left = 24
      Top = 64
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      ParentFont = False
      TabOrder = 3
    end
    object edtTitleRu: TcxDBTextEdit
      Left = 82
      Top = 60
      DataBinding.DataField = 'TITLE_RU'
      ParentFont = False
      TabOrder = 2
      Width = 623
    end
    object img_ro: TcxDBImage
      Left = 24
      Top = 121
      DataBinding.DataField = 'Image_RO'
      Properties.GraphicClassName = 'TdxPNGImage'
      TabOrder = 4
      Height = 145
      Width = 329
    end
    object img_ru: TcxDBImage
      Left = 376
      Top = 121
      DataBinding.DataField = 'IMAGE_RU'
      Properties.GraphicClassName = 'TdxPNGImage'
      TabOrder = 5
      Height = 145
      Width = 329
    end
    object cxPageControl1: TcxPageControl
      Left = 24
      Top = 272
      Width = 681
      Height = 399
      TabOrder = 7
      Properties.ActivePage = cxTabSheet1
      Properties.CustomButtons.Buttons = <>
      Properties.Style = 5
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      ClientRectBottom = 399
      ClientRectRight = 681
      ClientRectTop = 24
      object cxTabSheet1: TcxTabSheet
        Caption = 'Articol ro'
        ImageIndex = 0
        object edsArticleRo: TDBSynEdit
          Left = 0
          Top = 0
          Width = 681
          Height = 375
          Cursor = crIBeam
          DataField = 'Article_ro'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
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
          SelectedColor.Alpha = 0.400000005960464500
        end
      end
      object cxTabSheet2: TcxTabSheet
        Caption = 'Articol ru'
        ImageIndex = 1
        object edsArticleRu: TDBSynEdit
          Left = 0
          Top = 0
          Width = 681
          Height = 375
          Cursor = crIBeam
          DataField = 'Article_ro'
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
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
          SelectedColor.Alpha = 0.400000005960464500
        end
      end
    end
    object cxLabel3: TcxLabel
      Left = 28
      Top = 98
      Caption = 'Baner ro'
      ParentFont = False
      TabOrder = 6
      Transparent = True
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 679
    Width = 721
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 2
    object cxButton1: TcxButton
      Left = 496
      Top = 6
      Width = 90
      Height = 29
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 592
      Top = 6
      Width = 90
      Height = 29
      Cancel = True
      Caption = 'Renunta'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object cxLabel4: TcxLabel
    Left = 378
    Top = 100
    Caption = 'Baner ru'
    ParentFont = False
    TabOrder = 1
    Transparent = True
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 292
    Top = 376
  end
end
