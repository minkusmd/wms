object dmPrint: TdmPrint
  OldCreateOrder = False
  Height = 274
  Width = 455
  object frxReport: TfrxReport
    Version = '4.7.22'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39778.543130914350000000
    ReportOptions.LastChange = 39778.543130914350000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    Left = 60
    Top = 36
  end
  object frxIBDACComponents: TfrxIBDACComponents
    DefaultDatabase = dmDB.IBCConnection
    Left = 140
    Top = 36
  end
end
