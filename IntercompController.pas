
unit IntercompController;

interface

uses
  Container, Contnrs, ICompData, DM, SysUtils, DB, Classes, unitTypes,FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.Actions, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TIntercompController = class
  private
    dataList: TObjectList;

    function GetMatchingICData(AScreenIndex : integer): TICompData;
  public
    //lCustGroupFilter : TList;

    function IsEditableStack(ALPN: string;AScreenIndex : integer): boolean;
    function PredespatchReceivedProduct(AScreenIndex : integer): boolean;
    function FindLastCreatedStack(AScreenIndex : integer): integer;

    procedure CreateStack(AIndex: integer; AScreenIndex : integer);
    procedure ProcessInboundStacks;
    procedure Add(AScreenIndex : integer);
    procedure Remove(AScreenIndex : integer);
    procedure AskStockLocation(AScreenIndex : integer);
    procedure EditStack(AIndex: integer; AIsFirst: boolean; AScreenIndex : integer);
    procedure EditItemAttributes(item : TArtPPB; AScreenIndex: integer);
    function GetItemAttributes(artno : string; AScreenIndex : integer) : TArtPPB;
    procedure SetRefreshEvent(AScreenIndex : integer; RefreshEvent: TICRefreshEvent);
    procedure SetStockChangeEvent(AScreenIndex : integer; StockChangeEvent: TICStockChangeEvent);

    constructor Create;
    destructor Destroy; override;
  end;                   

var  ICController: TIntercompController;

implementation

{ TIntercompController }

//procedure TIntercompController.Add(AContainer: TSNodeContainer);
procedure TIntercompController.Add(AScreenIndex: integer);
var
  newICScreen: TICompData;
begin
  newICScreen := TICompData.Create(AScreenIndex);
//  newICScreen.Container := AContainer;

  dataList.Add(newICScreen);
end;

procedure TIntercompController.AskStockLocation(AScreenIndex: integer);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenIndex);

  if (Assigned(icScreen)) then
  begin
    icScreen.AskStockLocation;
  end;
end;

constructor TIntercompController.Create;
begin
  inherited Create;

  dataList := TObjectList.Create(true);
end;

procedure TIntercompController.CreateStack(AIndex: integer; AScreenindex : integer);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenindex);

  if (Assigned(icScreen)) then
  begin
    //icScreen.lCustGroupFilter := lCustGroupFilter;
    icScreen.DoCreateStack(AIndex);
  end;
end;

destructor TIntercompController.Destroy;
begin
  FreeAndNil(dataList);
  inherited;
end;

procedure TIntercompController.EditStack(AIndex: integer; AIsFirst: boolean;
  AScreenIndex: integer);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenindex);

  if (Assigned(icScreen)) then
  begin
    icScreen.EditStack(AIndex, AIsFirst);
  end;
end;


procedure TIntercompController.EditItemAttributes(item : TArtPPB; AScreenIndex: integer);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenindex);

  if (Assigned(icScreen)) then
  begin
    icScreen.EditItemAttributes(item);
  end;
end;

function TIntercompController.GetItemAttributes(artno : string; AScreenIndex : integer) : TArtPPB;
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenindex);

  if (Assigned(icScreen)) then
  begin
    Result := icScreen.GetItemAttributes(artno);
  end else
    Result := nil;
end;


function TIntercompController.FindLastCreatedStack(
  AScreenIndex: integer): integer;
var
  index: integer;
  icScreen: TICompData;
begin
  index := -1;
  icScreen := GetMatchingICData(AScreenindex);

  if (Assigned(icScreen)) then
  begin
    index := icScreen.FindLastCreatedStack;
  end;

  Result := index;
end;

function TIntercompController.GetMatchingICData(
  AScreenIndex: integer): TICompData;
var
  i: integer;
  isFound: boolean;
  icScreen: TICompData;
begin
  i := 0;
  icScreen := nil;
  isFound := false;

  while (i < dataList.Count) and (not isFound) do
  begin
    icScreen := TICompData(dataList[i]);

    if (icScreen.ScreenIndex = AScreenIndex) then
    begin
      isFound := true;
    end;

    Inc(i);
  end;

  if (not isFound) then
  begin
    icScreen := nil;
  end;

  Result := icScreen;
end;

function TIntercompController.IsEditableStack(ALPN: string;
  AScreenIndex: integer): boolean;
var
  isEditable: boolean;
  icScreen: TICompData;
begin
  isEditable := false;
  icScreen := GetMatchingICData(AScreenIndex);

  if (Assigned(icScreen)) then
  begin
    isEditable := icScreen.IsEditableStack(ALPN);
  end;

  Result := isEditable;
end;

function TIntercompController.PredespatchReceivedProduct(
  AScreenIndex: integer): boolean;
var
  receivedOK: boolean;
  icScreen: TICompData;
begin
  receivedOK := false;
  icScreen := GetMatchingICData(AScreenIndex);

  if (Assigned(icScreen)) then
  begin
    receivedOK := icScreen.PredespatchReceivedProduct;
  end;

  Result := receivedOK;
end;

procedure TIntercompController.ProcessInboundStacks;
var
  qStacks: TFDQuery;
  index: integer;
  icScreen: TICompData;
begin
  // Query the database for any remaining stacks
  qStacks := TFDQuery.Create(nil);

  if (not Assigned(qStacks)) then
  begin
    Exit;
  end;

  try
    // Retrieve al stacks waiting to be processed (status W)
    qStacks.ConnectionName := fDM.dB.ConnectionName;

    qStacks.SQL.Clear;
    qStacks.SQL.Add('select *');
    qStacks.SQL.Add('from INBOUNDSTACKS');
    qStacks.SQL.Add('where status = ''W''');
    qStacks.SQL.Add('order by lpn');
    qStacks.Open;

    while (not qStacks.Eof) do
    begin
      index := 0;

      while (index < dataList.Count) do
      begin
        icScreen := TICompData(dataList[index]);

        if (icScreen.ActiveShipment = qStacks.FieldByName('shipmentid').AsString) then
        begin
          icScreen.ProcessInboundStack(qStacks.FieldByName('lpn').AsString);
        end;

        Inc(index);
      end;

      qStacks.Next;
    end;
    qStacks.Close;

  finally
    FreeAndNil(qStacks);
  end;
end;

procedure TIntercompController.Remove(AScreenIndex : integer);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenIndex);

  if (Assigned(icScreen)) then
  begin
    dataList.Remove(icScreen);
  end else raise Exception.Create('TIntercompController.Remove: Could not find container');
end;

procedure TIntercompController.SetRefreshEvent(AScreenIndex : integer;
  RefreshEvent: TICRefreshEvent);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenIndex);

  if (Assigned(icScreen)) then
  begin
    if (not (Assigned(icScreen.OnICRefresh))) then
    begin
      icScreen.OnICRefresh := RefreshEvent;
    end;
  end;
end;

procedure TIntercompController.SetStockChangeEvent(
  AScreenIndex : integer; StockChangeEvent: TICStockChangeEvent);
var
  icScreen: TICompData;
begin
  icScreen := GetMatchingICData(AScreenIndex);

  if (Assigned(icScreen)) then
  begin
    if (not (Assigned(icScreen.OnStockChange))) then
    begin
      icScreen.OnStockChange := StockChangeEvent;
    end;
  end;
end;

end.
