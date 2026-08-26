unit frmPreviewPDFUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SWNBaseUnit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxX509Certificate, dxPDFCore,
  dxPDFBase, dxPDFText, dxPDFRecognizedObject, dxPDFForm, dxPDFFormData,
  dxPDFDocument, dxPrintUtils, dxBarBuiltInMenu, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, dxCustomPreview, dxPDFDocumentViewer, dxPDFViewer, Vcl.ExtCtrls;

type
  TfrmPreviewPDFDlg = class(TSWNBaseFormClass)
    Panel1: TPanel;
    dxPDFViewer1: TdxPDFViewer;
    cxButton1: TcxButton;
  private
    FPdfStream: TMemoryStream;
    procedure SetPdfStream(const Value: TMemoryStream);
    { Private declarations }
  protected
    procedure Prepare; override;
  public
    property PdfStream: TMemoryStream read FPdfStream write SetPdfStream;
    { Public declarations }
  end;

var
  frmPreviewPDFDlg: TfrmPreviewPDFDlg;

implementation

{$R *.dfm}

procedure TfrmPreviewPDFDlg.Prepare;
begin
  if fPDFStream.Size>0 then
    try
      dxPDFViewer1.LoadFromStream(fPDFStream);
    except
    end;
end;

procedure TfrmPreviewPDFDlg.SetPdfStream(const Value: TMemoryStream);
begin
  FPdfStream := Value;

end;

end.
