object frmDocTypesViewCodeDialog: TfrmDocTypesViewCodeDialog
  Left = 0
  Top = 0
  Caption = 'Codul generat...'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object fsSyntaxMemo1: TfsSyntaxMemo
    Left = 8
    Top = 8
    Width = 785
    Height = 521
    Cursor = crIBeam
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    TabStop = True
    BlockColor = clHighlight
    BlockFontColor = clHighlightText
    CommentAttr.Charset = DEFAULT_CHARSET
    CommentAttr.Color = clNavy
    CommentAttr.Height = -13
    CommentAttr.Name = 'Courier New'
    CommentAttr.Style = [fsItalic]
    KeywordAttr.Charset = DEFAULT_CHARSET
    KeywordAttr.Color = clWindowText
    KeywordAttr.Height = -13
    KeywordAttr.Name = 'Courier New'
    KeywordAttr.Style = [fsBold]
    StringAttr.Charset = DEFAULT_CHARSET
    StringAttr.Color = clNavy
    StringAttr.Height = -13
    StringAttr.Name = 'Courier New'
    StringAttr.Style = []
    TextAttr.Charset = DEFAULT_CHARSET
    TextAttr.Color = clWindowText
    TextAttr.Height = -13
    TextAttr.Name = 'Courier New'
    TextAttr.Style = []
    Lines.Strings = (
      '')
    ReadOnly = False
    SyntaxType = stPascal
    ShowFooter = True
    ShowGutter = True
  end
  object bbSaveToFile: TcxButton
    Left = 24
    Top = 564
    Width = 97
    Height = 28
    Caption = 'Salveaza'
    TabOrder = 1
    OnClick = bbSaveToFileClick
  end
  object bbClose: TcxButton
    Left = 344
    Top = 564
    Width = 73
    Height = 28
    Cancel = True
    Caption = 'Inchide'
    ModalResult = 8
    TabOrder = 2
  end
  object fsPascal1: TfsPascal
    Left = 600
    Top = 120
  end
end
