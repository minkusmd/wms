unit ReportSelectorPanelUnit;

interface

Uses Classes, frxClass, frxDsgnIntf, cxButtonEdit, cxTextEdit, fs_iinterpreter, frxClassRTTI, cxEdit,
     Controls, ExtCtrls, Buttons, SWNValueStorageUnit;

type

  TOnSelectorPanelSaveToRepository = procedure(const Storage:TAppUserInternalDataStorage) of object;

  TfrxSelectorPanel = class(TPanel)
  private
    fNeedSaveData: Boolean;
    fReportControl: TfrxDialogControl;
    fOnSaveToRepository: TOnSelectorPanelSaveToRepository;
    fOnReadFromRepository: TOnSelectorPanelSaveToRepository;
    procedure SetNeedSaveData(const Value: Boolean);
    procedure SetOnSaveToRepository(const Value: TOnSelectorPanelSaveToRepository);
    procedure SetOnReadFromRepository(const Value: TOnSelectorPanelSaveToRepository);
  public
    { public declarations }
    procedure SaveToRepository(const Storage:TAppUserInternalDataStorage);
    procedure ReadFromRepository(const Storage:TAppUserInternalDataStorage);
    property OnSaveToRepository:TOnSelectorPanelSaveToRepository read FOnSaveToRepository write SetOnSaveToRepository;
    property OnReadFromRepository:TOnSelectorPanelSaveToRepository read FOnReadFromRepository write SetOnReadFromRepository;
    property NeedSaveData:Boolean read FNeedSaveData write SetNeedSaveData;
    property ReportControl:TfrxDialogControl read FReportControl;
  published
    { published declarations }
    constructor Create(AOwner: TComponent; const AReportControl:TfrxDialogControl);reintroduce;
  end;



implementation

{ TfrxSelectorPanel }

constructor TfrxSelectorPanel.Create(AOwner: TComponent; const AReportControl: TfrxDialogControl);
begin
     inherited Create(AOwner);
     fOnSaveToRepository := nil;
     fOnReadFromRepository := nil;
     fNeedSaveData := false;
     fReportControl:=AReportControl;
end;

procedure TfrxSelectorPanel.ReadFromRepository(const Storage: TAppUserInternalDataStorage);
begin
     if fNeedSaveData and Assigned(FOnReadFromRepository) then FOnReadFromRepository(Storage);
end;

procedure TfrxSelectorPanel.SaveToRepository(const Storage: TAppUserInternalDataStorage);
begin
     if fNeedSaveData and Assigned(fOnSaveToRepository) then fOnSaveToRepository(Storage);
end;

procedure TfrxSelectorPanel.SetNeedSaveData(const Value: Boolean);
begin
     fNeedSaveData := Value;
end;

procedure TfrxSelectorPanel.SetOnReadFromRepository(const Value: TOnSelectorPanelSaveToRepository);
begin
     fOnReadFromRepository := Value;
end;

procedure TfrxSelectorPanel.SetOnSaveToRepository(const Value: TOnSelectorPanelSaveToRepository);
begin
     fOnSaveToRepository := Value;
end;

end.
