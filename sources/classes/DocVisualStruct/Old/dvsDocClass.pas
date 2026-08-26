unit dvsDocClass;

interface
Uses Classes;

type

  TdvsDocItemClass = class
  private
    { Private declarations }
    fFLG_ACNT: Boolean;
    fSuma: Currency;
    fDocID: integer;
    fDocDateTime: TDateTime;
    fDocType: String;
    fParentDocItem: TdvsDocItemClass;
    procedure SetDocDateTime(const Value: TDateTime);
    procedure SetDocID(const Value: integer);
    procedure SetDocType(const Value: String);
    procedure SetFLG_ACNT(const Value: Boolean);
    procedure SetSuma(const Value: Currency);
    procedure SetParentDocItem(const Value: TdvsDocItemClass);
    function GetChild(Index: integer): TdvsDocItemClass;
    function GetChildrenCount: integer;

  protected
    { Protected declarations }
    fChildren:TList;
    procedure ClearChildren;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy;override;

    property ChildrenCount:integer read GetChildrenCount;
    property Child[Index:integer]:TdvsDocItemClass read GetChild;

    property ParentDocItem:TdvsDocItemClass read FParentDocItem write SetParentDocItem;

    property DocID:integer read FDocID write SetDocID;
    property DocType:String read FDocType write SetDocType;
    property DocDateTime:TDateTime read FDocDateTime write SetDocDateTime;
    property Suma:Currency read FSuma write SetSuma;
    property FLG_ACNT:Boolean read FFLG_ACNT write SetFLG_ACNT;

    function AddNewChild:TdvsDocItemClass;
    procedure AddExistingChild(const Child:TdvsDocItemClass);
  end;


implementation

{ TdvsDocItemClass }

function TdvsDocItemClass.AddNewChild: TdvsDocItemClass;
begin
     Result:=TdvsDocItemClass.Create;
     fChildren.Add(Result);
end;

procedure TdvsDocItemClass.AddExistingChild(const Child: TdvsDocItemClass);
begin
     fChildren.Add(Child);
end;

procedure TdvsDocItemClass.ClearChildren;
var i:integer;
begin
     for i := 0 to fChildren.Count - 1 do fChildren.Clear;
end;

constructor TdvsDocItemClass.Create;
begin
     fChildren:=TList.Create;
end;

destructor TdvsDocItemClass.Destroy;
begin
     ClearChildren;
     fChildren.Free;
     inherited;
end;

function TdvsDocItemClass.GetChild(Index: integer): TdvsDocItemClass;
begin
     Result:=TdvsDocItemClass(fChildren[Index]);
end;

function TdvsDocItemClass.GetChildrenCount: integer;
begin
     Result:=fChildren.Count;
end;

procedure TdvsDocItemClass.SetDocDateTime(const Value: TDateTime);
begin
     fDocDateTime := Value;
end;

procedure TdvsDocItemClass.SetDocID(const Value: integer);
begin
     fDocID := Value;
end;

procedure TdvsDocItemClass.SetDocType(const Value: String);
begin
     fDocType := Value;
end;

procedure TdvsDocItemClass.SetFLG_ACNT(const Value: Boolean);
begin
     fFLG_ACNT := Value;
end;

procedure TdvsDocItemClass.SetParentDocItem(const Value: TdvsDocItemClass);
begin
     fParentDocItem := Value;
end;

procedure TdvsDocItemClass.SetSuma(const Value: Currency);
begin
     fSuma := Value;
end;

end.
