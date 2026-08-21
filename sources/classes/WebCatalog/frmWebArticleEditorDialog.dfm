object frmWebArticleEditorDlg: TfrmWebArticleEditorDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Articol editare'
  ClientHeight = 730
  ClientWidth = 1233
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object cxLabel1: TcxLabel
    Left = 12
    Top = 9
    Caption = 'Titlu'
  end
  object cxLabel2: TcxLabel
    Left = 620
    Top = 9
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
  end
  object cxPageControl1: TcxPageControl
    Left = 8
    Top = 88
    Width = 1201
    Height = 601
    TabOrder = 4
    Properties.ActivePage = cxTabSheet1
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 597
    ClientRectLeft = 4
    ClientRectRight = 1197
    ClientRectTop = 26
    object cxTabSheet1: TcxTabSheet
      Caption = 'Articol'
      ImageIndex = 0
      object synEditRo: TDBSynEdit
        Left = 0
        Top = 0
        Width = 1193
        Height = 571
        Cursor = crIBeam
        DataField = 'ARTICLE_BODY_RO'
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
      Caption = #1057#1090#1072#1090#1100#1103
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 704
      ExplicitHeight = 453
      object synEditRu: TDBSynEdit
        Left = 0
        Top = 0
        Width = 1193
        Height = 571
        Cursor = crIBeam
        DataField = 'ARTICLE_BODY_RU'
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
        ExplicitWidth = 704
        ExplicitHeight = 453
      end
    end
  end
  object btnOK: TcxButton
    Left = 984
    Top = 695
    Width = 90
    Height = 29
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object btnCancel: TcxButton
    Left = 1088
    Top = 695
    Width = 90
    Height = 29
    Cancel = True
    Caption = 'Renunta'
    ModalResult = 2
    TabOrder = 6
  end
  object teTitleRo: TcxDBMemo
    Left = 45
    Top = 8
    DataBinding.DataField = 'title_ro'
    TabOrder = 0
    Height = 74
    Width = 556
  end
  object teTitleRu: TcxDBMemo
    Left = 688
    Top = 8
    DataBinding.DataField = 'title_ru'
    TabOrder = 1
    Height = 74
    Width = 517
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 272
    Top = 112
  end
end
