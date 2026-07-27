object frmPrintEngine: TfrmPrintEngine
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1055#1077#1095#1072#1090#1100' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 230
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object dtDialogTitle: TDialogTitle
    Left = 0
    Top = 0
    Width = 594
    Height = 64
    BottomBorder = bbSolid
    ImageAlignment = iaLeft
    Text = #1048#1076#1077#1090' '#1087#1086#1076#1075#1086#1090#1086#1074#1082#1072' '#1086#1090#1095#1077#1090#1072'...'
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
    ImageIndex = 8
  end
  object frxReport: TfrxReport
    Version = '2023.2'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbNoFullScreen]
    PreviewOptions.OutlineVisible = True
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39778.543130914400000000
    ReportOptions.LastChange = 43926.016237314800000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnAfterPrint = frxReportAfterPrint
    OnBeforePrint = frxReportBeforePrint
    OnBeginDoc = frxReportBeginDoc
    OnEndDoc = frxReportEndDoc
    OnPreview = frxReportPreview
    OnPrintReport = frxReportPrintReport
    Left = 32
    Top = 68
  end
  object frxDialogControls1: TfrxDialogControls
    Left = 248
    Top = 120
  end
  object frxCheckBoxObject1: TfrxCheckBoxObject
    Left = 40
    Top = 176
  end
  object frxRichObject1: TfrxRichObject
    Left = 88
    Top = 176
  end
  object frxCrossObject1: TfrxCrossObject
    Left = 136
    Top = 120
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 32
    Top = 120
  end
  object IBCTrUpdate: TIBCTransaction
    DefaultConnection = dmDB.IBCConnection
    Left = 344
    Top = 68
  end
  object frxGradientObject1: TfrxGradientObject
    Left = 88
    Top = 120
  end
  object frxGZipCompressor1: TfrxGZipCompressor
    Left = 328
    Top = 120
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 88
    Top = 72
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = False
    OverwritePrompt = False
    CreationTime = 43252.653759259260000000
    DataOnly = False
    EmbeddedFonts = True
    EmbedFontsIfProtected = False
    InteractiveFormsFontSubset = 'A-Z,a-z,0-9,#43-#47 '
    OpenAfterExport = False
    PrintOptimized = False
    Outline = True
    Background = False
    HTMLTags = True
    Quality = 20
    Transparency = False
    Author = 'Fantastic.md'
    Subject = 'Proforma Fantastic.MD'
    Creator = 'FastReport'
    ProtectionFlags = [ePrint, eCopy]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = True
    PrintScaling = False
    PdfA = False
    PDFStandard = psNone
    PDFVersion = pv14
    Left = 424
    Top = 120
  end
  object frxMailExport1: TfrxMailExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Lines.Strings = (
      'Buna ziua')
    ShowExportDialog = False
    FromName = 'Sergiu Minchevici'
    FromCompany = 'Fantastic.MD'
    SmtpHost = '192.168.100.253'
    SmtpPort = 25
    Password = 'Minkus!23'
    UseIniFile = True
    TimeOut = 60
    ConfurmReading = False
    OnSendMail = frxMailExport1SendMail
    UseMAPI = SMTP
    MAPISendFlag = 0
    Left = 424
    Top = 72
  end
  object IdSMTP1: TIdSMTP
    Host = 'mail.fantastic.md'
    SASLMechanisms = <>
    Username = 'noreply@fantastic.md'
    Left = 400
    Top = 8
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 526
    Top = 8
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CharSet = 'UTF-8'
    CCList = <>
    ContentType = 'plain/html'
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 456
    Top = 8
  end
  object frxBIFFExport1: TfrxBIFFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OpenAfterExport = False
    RowHeightScale = 1.000000000000000000
    ChunkSize = 0
    Inaccuracy = 10.000000000000000000
    FitPages = False
    Pictures = True
    ParallelPages = 0
    Left = 512
    Top = 72
  end
  object frxXLSExport1: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = False
    Left = 512
    Top = 120
  end
  object frxXLSXExport1: TfrxXLSXExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ChunkSize = 0
    OpenAfterExport = False
    PictureType = gpPNG
    Left = 512
    Top = 168
  end
  object frxReportTableObject1: TfrxReportTableObject
    Left = 352
    Top = 176
  end
  object frxMapObject1: TfrxMapObject
    Left = 144
    Top = 176
  end
  object frxReportCellularTextObject1: TfrxReportCellularTextObject
    Left = 232
    Top = 176
  end
  object SSLHandler: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 144
    Top = 72
  end
  object frxIBDACComponents1: TfrxIBDACComponents
    DefaultDatabase = dmDB.IBCConnection
    Left = 240
    Top = 72
  end
end
