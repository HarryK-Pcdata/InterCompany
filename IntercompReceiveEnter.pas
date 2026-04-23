unit IntercompReceiveEnter;
{======================== D O C U M E N T A T I O N ==========================

File name     IntercompReceiveEnter.PAS

Purpose

Version       0.0

Date          ??

Dev. env.     Delphi 6 professional

Run env.      MS-Windows

Developed by  ??

Part of

Comments

Modification history

06-06-2007 HK Fixed columns
16-08-2007 HK Changed to shipment based reception of the goodies

 =============================================================================}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseDespatch, ExtCtrls, Menus, ActnList, DB, StdCtrls,
  Grids,desplist, Container, Node, DispNode, BackGround, Print, DespCol,
  Buttons, StackProgress, unitTypes, Generics.Collections
  , DespatchOrders, unitLogError, SDisplay, Math, uDespMethodPartStackFit, hashlist, DespFlt
  , dlgEditItemAttributes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, System.Actions,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;


type
  TfInterCompReceiveEnter = class(TfDespatch)
    aMod: TAction;
    aPrintLabel: TAction;
    eSearch: TEdit;
    lbSearch: TLabel;
    aCreateStack: TAction;
    N8Despatchorder1: TMenuItem;
    N0DDFullstreetstreetremainders1: TMenuItem;
    N1DDStreetremaindersFullstreet1: TMenuItem;
    N2FullstreetDDStreetremainders1: TMenuItem;
    N3FullstreetStreetremaindersDD1: TMenuItem;
    N4StreetremaindersFullstreetDD1: TMenuItem;
    N5StreetremaindersFullstreetDD1: TMenuItem;
    aMenuDespatchOrder: TAction;
    aDo_DD_Full_Part: TAction;
    aDo_DD_Part_Full: TAction;
    aDo_Full_DD_Part: TAction;
    aDo_Full_Part_DD: TAction;
    aDo_Part_DD_Full: TAction;
    aDo_Part_Full_DD: TAction;
    aSelectStockDest: TAction;
    Selectstocklocation1: TMenuItem;
    Createstack1: TMenuItem;
    aAddProduct: TAction;
    aEditStack: TAction;
    Edittag1: TMenuItem;
    Addproduct1: TMenuItem;
    aPredespatchRemainder: TAction;
    Predespatchremainder1: TMenuItem;
    tmrCheckScans: TTimer;
    Action2: TAction;
    aAlternative: TAction;
    Alternative1: TMenuItem;
    aSearchArticles: TAction;
    Searcharticles1: TMenuItem;
    Label5: TLabel;
    lblTotalLeft: TLabel;
    lblDirect: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lblSendToEd: TLabel;
    Label10: TLabel;
    lblSchedNeededAmount: TLabel;
    aMenuFilter: TAction;
    aFltCustGroup: TAction;
    N2Filter1: TMenuItem;
    N1Customergroup1: TMenuItem;
    lFltCustGroup: TLabel;
    aEditStackAttributes: TAction;
    aItemAttributes: TAction;
    EditItemAttributes1: TMenuItem;
    Label13: TLabel;
    lblASNRemaining: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    lblBalance: TLabel;
    aFltWave: TAction;
    lFltWave: TLabel;
    N2Wavefilter1: TMenuItem;
    lblHighestWave: TLabel;
    aFltStreet: TAction;
    N4Street1: TMenuItem;
    lFltStreet: TLabel;
    aShortAmount: TAction;
    aShortAmount1: TMenuItem;
    actEnableIMPrint: TAction;
    EnableIMstackprint1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure DrawGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure aExtraSetColumnsExecute(Sender: TObject);
    procedure aModExecute(Sender: TObject);
    procedure DrawGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure eUserIdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure aPrintLabelExecute(Sender: TObject);
    procedure aAdjustReclacExecute(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aCreateStackExecute(Sender: TObject);
    procedure DespOrderChanged(Sender: TObject);
    procedure aDummyExec(Sender: TObject);
    procedure aSelectStockDestExecute(Sender: TObject);
    procedure AddComponentProductsToContainer(AArtno: string; AContainer: TSNodeContainer);
    function IsMaterialDespatchable(AMaterial: rMaterialRequired): boolean;
    procedure aAddProductExecute(Sender: TObject);
    procedure aEditStackExecute(Sender: TObject);
    procedure aCratesPcsExecute(Sender: TObject);
    procedure aPredespatchRemainderExecute(Sender: TObject);
    procedure tmrCheckScansTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aAlternativeExecute(Sender: TObject);
    procedure aSearchArticlesExecute(Sender: TObject);
    procedure eSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure aMenuFilterExecute(Sender: TObject);
    procedure aFltCustGroupExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure aEditStackAttributesExecute(Sender: TObject);
    procedure aItemAttributesExecute(Sender: TObject);
    procedure aFltWaveExecute(Sender: TObject);
    procedure aFltStreetExecute(Sender: TObject);
    procedure aShortAmountExecute(Sender: TObject);
    procedure actEnableIMPrintExecute(Sender: TObject);
  private
    HighestWaveNumber : integer;
    ScreenLabel : string;
    fStackDespatchOrder: StackDespOrder;
    bCratesPcs : boolean;
    SelectAllCustomers : boolean;
    Priority : TPriority;
    inboundScan : boolean;
    inboundScanCounter : integer;
    disableInboundScanMessages : boolean;
    oldRow: integer;
    lastRowIndex: integer;

    AskStockDestination: boolean;
    DestinationCompany,
    DestinationGloc: integer;
    DestinationDescription: string;
    DestinationIsControlled: boolean;

    FilterCustGroup : boolean;
    lSystemWaveFilter : TList;
    lSystemStreetFilter : TList;
    UseSystemFilters : boolean;
    FCreatingStack: Boolean;

    maContainer: TSNodeContainer;


    function CalculateNeeded(ANode: TSNode):integer;
    function OneAndOnlyOneWave: boolean;
    function WaveFilter(cwa: rCustwaveart): boolean;
    procedure BuildFilterString( fType : TDespFilter); virtual;
    function UpdateInboundStacks(shipmentid : string; stackid : string; status : string) : integer;
    function CreateSSCC : string;
    function CreateLabelID:string;
    function CheckAllReceived : boolean;
    procedure ProcessInboundStacks;
    function PredespatchShipment: boolean;
    procedure PDDDReadDespatchData(var AContainer : TSNodeContainer); overload;
    procedure CorrectForDPStreets(Container : TSNodeContainer);
    function DetermineGoodsSent(ccodeto:integer; glocidto:integer; artno:string):integer;
    procedure ManualAddToShipment(node : TSNode);
    procedure ManualUpdateShipment(node : TSNode; addedQuant : integer);
    function AllowedToClose(shipment : string): boolean;
    procedure UpdateInfo;
    procedure RetrieveStacksCreated(shipmentid : string);
    procedure CheckOrigin(ccodefrom : integer; glocidfrom : integer);
    procedure CalculateStackDest(ANode: TSNode);
    function FindProductInShipment(artno : string) : integer;
    function RetrievePurchaseOrders(shipmentId : string; artno : string; var foundForProduct : boolean) : TStringList;
    procedure RefreshGrid(AIndex: integer);
    procedure GetStockChanges(Sender: TObject);
    procedure RegisterTransaction(transaction: TTransType);
  protected
    lSystemCustGroupFilter : TList;
    procedure ReadDespatchData;
    procedure PDDDReadDespatchData(Artno:string;Container:TSNodeContainer); overload;

    procedure CreateList(art: rArt; Selected_Needed: integer);
    procedure ShortageAmount(AManualAdjustment: boolean; artno: string; needed: integer);
    function ForwardShortedAmount(ACompany: integer; AShipdate: string; AContainer: TSNodeContainer): TForwardShortedAmountResult;

    procedure SetDefaultColumns; override;
    function FindLike(searchString : string; searchArticle : boolean = false) : integer;
    function FindProduct(artno : string) : integer;
    procedure ReadSettings; override;
    procedure ExecuteModificationState; override;
    function GetColumnValue( ARow, ACol : integer; Columns: TDespColList; var ARight : boolean; var isNewStack : boolean;
                              var isAlternative : boolean; var isMixedStack : boolean; var isLastStack : boolean;
                              var isInCustomerGroup:boolean):string; reintroduce;
    procedure Execute_EnterKey; override;
    procedure DoEscape; override;
    Procedure Fillcolumns; override;
    procedure GetSelectableColumnCode(var ColList : TStringList); override;
    procedure DetermineRows; reintroduce;
    procedure EditStack(isFirst : boolean = false);
    function theCurrentLineIsIMProduct: boolean;
    procedure UndoStack;
    procedure FreeList(var List:TList); virtual;
    function InIntegerFilter(const list:TList; value:integer): boolean;
    function InStreetFilter(const list:TList; const Street:rStreet):boolean;
    function CustGroupFilter(cwa:rCustwaveart; Cust:rCust): boolean;
    procedure ApplyCustGroupFilterToNodes;
    procedure scanAll;
  public
    lCustGroupFilter : TList;
    FilterWave : boolean;
    lWaveFilter : TList;
    lStreetFilter : TList;
    FilterStreet : boolean;
    property StackDespatchOrder: StackDespOrder read fStackDespatchOrder;
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  fInterCompReceiveEnter: TfInterCompReceiveEnter;

implementation

uses
  DM, Globals, BaseVerwerk, GlobSettings, Main, Utils, GlobalStrings, Reason,
  subscribe, shipment, Waste, barcode, MixedStackControl,
  AddProdShipment, displayLocation, GlocList, RDPCustomer, DespMethod,
  SelecteCompany, DUD, DateUtils, Transno, BlockProductList, DESPSelAlternative,
  IntercompController, Contnrs, BarcodeProducts, BaseVerwerkSelect,
  IntercompReceive, ArticleWave, Block, Calculator, MancoAmount,
  ChangeContainer, ConsumedGoods, Shipdate, Future, DespMethodTraysUnits;

const
  IC_COLUMN_STACKID            =  0;
  IC_COLUMN_ARTNO              =  1;
  IC_COLUMN_DESCRIPTION        =  2;
  IC_COLUMN_EXPECTED           =  3;
  IC_COLUMN_ARRIVED            =  4;
  IC_COLUMN_ADJUST             =  5;
  IC_COLUMN_LEGACY             =  6;
  IC_COLUMN_REASON             =  7;
  IC_COLUMN_DAMAGE             =  8;
  IC_COLUMN_AVAILABLE          =  9;
  IC_COLUMN_CCODE              =  10;
  IC_COLUMN_SHIPMENTID         =  11;
  IC_COLUMN_ORGSTACKID         =  12;
  IC_COLUMN_ODDCRATES          =  13;
  IC_COLUMN_ALTARTNO           =  14;
  IC_COLUMN_ALTDESCRIPTION     =  15;
  IC_COLUMN_DESTINATION        =  16;
  IC_COLUMN_DAILY_VOLUME       =  17;
  IC_COLUMN_JULIANDATE         =  18;
{$R *.dfm}


{ TfInterCompReceiveEnter }
constructor TfInterCompReceiveEnter.Create(Aowner: TComponent);
begin
   inherited;
   lWaveFilter := TList.Create;
   lStreetFilter := TList.Create;
   lSystemWaveFilter := TList.Create;
   // TODO: Should this be a setting for the screen?
   UseSystemFilters := false;
   self.ShipDate := GlobalShipdate;
   //Container := TSNodeContainer.Create;
   N2Sort1.Visible:=FALSE;
   // Initialise the additions
   SelectAllCustomers := false;
   Priority := PRIORITY_1;
   ScrType := SCRTYPE_INTERCOMPANYREC;
   inboundScan := false;
   disableInboundScanMessages := false;
   AskStockDestination := true;
end;

destructor TfInterCompReceiveEnter.Destroy;
begin
  fDespList.ClearList(lStreetfilter);
  lStreetfilter.Free;

  fDespList.Clear(lWaveFilter);
  lWavefilter.Free;

  fDespList.Clear(lSystemWaveFilter);
  lSystemWaveFilter.Free;

  tmrCheckScans.Enabled := false;
  Timer1.Enabled := false;
  inherited;
end;

procedure TfInterCompReceiveEnter.RetrieveStacksCreated(shipmentid : string);
var
  qSelect : TFDQuery;
  node : TSNode;
begin
  if not Assigned(Container) then
    exit;

  //First make sure all the old "new stack" nodes are cleared, otherwise
  //we might get double the stack lines in the screen.
  Container.ClearNewStackNodes;

  qSelect := TFDQuery.Create(nil);
  if not Assigned(qSelect) then
    raise Exception.Create('TfInterCompReceiveEnter.RetrieveStacksCreated: Could not allocate memory');
  qSelect.ConnectionName := fDm.dB.ConnectionName;
  with qSelect.SQL do
  begin
    Clear;
    Add('select g.*, t.artno as art, t.altart, m.description, m.defapcsperbasket as mppb, c.defapcsperbasket as cppb, c.stackheight,');
    Add('ma.description as altdesc, ma.defapcsperbasket as altmppb, ca.defapcsperbasket as altcppb, ca.stackheight as altstackheight,');
    Add('gl.description as destination, mc.dispname as custname, t.ttype, gts.streetno');
    Add('from gloc_atp_res g');
    Add('join transnos t on t.ccode = g.ccodeto and t.transno = g.transno');
    Add('join mart m on m.artno = t.artno');
    Add('join cart c on c.ccode = t.ccode and c.artno = t.artno');
    Add('join gloc gl on g.ccodeto=gl.ccode and g.glocidto=gl.glocid');
    Add('left outer join mart ma on ma.artno = t.altart');
    Add('left outer join cart ca on ca.ccode = t.ccode and ca.artno = t.altart');
    Add('left outer join mcust mc on t.custno=mc.custno');
    Add('left outer join gloc_tostreet gts on gts.ccode=gl.ccode and gts.glocid=gl.glocid');
    Add('where g.createdfromshipment = :shipmentid');
    Add('and g.ccodeto = :ccode');
    Add('and g.storno = ''N''');
    Add('order by g.stackid, g.artno');
  end;
  qSelect.ParamByName('shipmentid').AsString := shipmentid;
  qSelect.ParamByName('ccode').AsInteger := self.Company;
  qSelect.Open;
  while not qSelect.Eof do
  begin
    node := TSNode.Create;
    if (NOT Assigned(node)) then
      raise Exception.Create('TfInterCompReceiveEnter.RetrieveStacksCreated: Could not allocate memory');

    node.isNewStack := true;
    node.ShipmentId := shipmentid;
    node.User1 := IntToStr(GlobalCompany);
    node.Company := qSelect.FieldByName('ccodeto').AsInteger;
    node.GLocId := qSelect.FieldByName('glocidto').AsInteger;
    node.ArtNo := qSelect.FieldByName('art').AsString;
    node.Name := qSelect.FieldByName('description').AsString;
    node.lpn := qSelect.FieldByName('stackid').AsString;
    node.orgLPN := qSelect.FieldByName('createdfromstackid').AsString;
    node.orgTransno := qSelect.FieldByName('orgtransno').AsInteger;
    node.ToDeliverBackup := qSelect.FieldByName('quantarr').AsInteger;
    node.todeliver := qSelect.FieldByName('quantarr').AsInteger;
    node.Ordered := qSelect.FieldByName('quantshipped').AsInteger;
    node.Damage := qSelect.FieldByName('damage').AsInteger;
    node.Reserved := qSelect.FieldByName('quantres').AsInteger;
    node.Transno := qSelect.FieldByName('transno').AsInteger;
    node.StackHeight := qSelect.FieldByName('stackheight').AsInteger;
    node.DestinationName := qSelect.FieldByName('destination').AsString;
    if qSelect.FieldByName('ttype').AsInteger = integer(TRANS_DIRECT) then
    begin
      node.DestinationName := qSelect.FieldByName('custname').AsString;
    end;
    if qSelect.FieldByName('ttype').AsInteger = integer(TRANS_PREDESPATCH) then
    begin
      node.DestinationName := 'Street '+qSelect.FieldByName('streetno').AsString;
    end;


    // GLOC_ATP_RES STATUS 'M' indicates that this node has been created from a mixed stack
    if (qSelect.FieldByName('STATUS').IsNull) then
      node.isMixedStack := false
    else
      node.isMixedStack := (Uppercase(Trim(qSelect.FieldByName('STATUS').AsString)) = 'M');

    //Alternative product info
    node.AltArtno := qSelect.FieldByName('altart').AsString;
    node.AltDescription := qSelect.FieldByName('altdesc').AsString;
    node.AltStackHeight := qSelect.FieldByName('altstackheight').AsInteger;
    node.IsStockNode := (qSelect.FieldByName('tostock').AsString = 'Y');

    if (GlobalDespatchOptions.SomeFieldsFromCART) then
    begin
      node.PcsPerBasket := qSelect.FieldByName('cppb').AsInteger;
      node.AltPPB := qSelect.FieldByName('altcppb').AsInteger;
    end else
    begin
      node.PcsPerBasket := qSelect.FieldByName('mppb').AsInteger;
      node.AltPPB := qSelect.FieldByName('altmppb').AsInteger;
    end;

    //Flowers, damage correction
    //Also a sneaky trick to not take the movements from a wastegloc into
    //account. As in case of a full stack damage, the waste movements will
    //be checked to know the amount.
    if (node.GLocId <> GlobalDespatchOptions.WasteGlocId) then
    begin
      node.ToDeliverBackup := node.ToDeliverBackup + node.Damage;
      node.ToDeliver := node.ToDeliver + node.Damage;
      node.Ordered := node.Ordered + node.Damage;
    end else
    begin
      node.LPN := '-1';
    end;

    Container.Nodes.Add(node);

    qSelect.Next;
  end;  // while not qSelect.Eof do

  qSelect.Close;
  qSelect.Free;

  if Container.Nodes.Count = 0 then
  begin
    DrawGrid1.RowCount := 2;
  end else
    Drawgrid1.RowCount := Container.Nodes.Count + 1;

  Drawgrid1.Refresh;

end;
(*

throw all barcodes of non finished stacks in the inbounstacks table
W(aiting) to be processed, R(ejected) scanned by Dockmanager but not ok, A(rrived) received by intercompany screens
*)
procedure TfInterCompReceiveEnter.scanAll;
var Q: TFDQuery;
    node: TSNode;
    i: integer;
begin
  Q := TFDQuery.Create(nil);
  Q.ConnectionName := fDM.dB.ConnectionName;
  for i := 0 to container.Nodes.Count - 1 do
  begin
    node := container.Nodes[i];
    if not node.isNewStack  then
    begin

    end;
  end;
  Q.Free;
end;

// Process the inbound stacks scanned by Dockmanager
// Inbound stacks may have the following status flags:
// W(aiting) to be processed, R(ejected) scanned by Dockmanager but not ok, A(rrived) received by intercompany screens
procedure TfInterCompReceiveEnter.ProcessInboundStacks;
begin
  if not Assigned(Container) then
    exit;

  disableInboundScanMessages := true;

  ICController.ProcessInboundStacks;

  disableInboundScanMessages := false;

  eSearch.Clear;
  if (GlobalIntercompanyOptions.DockManagerScanning) then
    eUserId.SetFocus
  else
    eSearch.SetFocus;

  //After creating a stack:
  DrawGrid1.RowCount := Container.Nodes.Count + 1;

  DrawGrid1.Refresh;
end;

function TfInterCompReceiveEnter.UpdateInboundStacks(shipmentid : string; stackid : string; status : string) : integer;
var
  qStacks : TFDQuery;
  nrUpdated : integer;
begin
  nrUpdated := 0;
  qStacks := TFDQuery.Create(nil);
  if Assigned(qStacks) then
  begin
    try
      qStacks.ConnectionName := fDm.dB.ConnectionName;
      qStacks.SQL.Clear;
      qStacks.SQL.Add('update INBOUNDSTACKS');
      qStacks.SQL.Add('set status = :status');
      qStacks.SQL.Add('where shipmentid = :shipmentid and lpn = :lpn');
      qStacks.ParamByName('shipmentid').AsString := shipmentid;
      qStacks.ParamByName('lpn').AsString := stackid;
      qStacks.ParamByName('status').AsString := Uppercase(status);
      fDm.dB.StartTransaction;
      qStacks.ExecSQL;
      nrUpdated := qStacks.RowsAffected;
      fDm.dB.Commit;
    finally
      qStacks.Free;
    end;
  end; // if Assigned(qStacks) then
  Result := nrUpdated;
end;

procedure TfInterCompReceiveEnter.SetDefaultColumns;
begin
  inherited;
  AddColumn(IC_COLUMN_CCODE);
  AddColumn(IC_COLUMN_SHIPMENTID);
  AddColumn(IC_COLUMN_STACKID);
  AddColumn(IC_COLUMN_ARTNO);
  AddColumn(IC_COLUMN_DESCRIPTION);
  AddColumn(IC_COLUMN_EXPECTED);
  AddColumn(IC_COLUMN_ARRIVED);
  AddColumn(IC_COLUMN_DAMAGE);
end;

procedure TfInterCompReceiveEnter.ShortageAmount(AManualAdjustment: boolean; artno: string; needed: integer);
var
//  Tmp   : TSDisplay;
  i, Amount, Manco : integer;
  Blocked, blkfnd, proceed : boolean;
  mrResult : integer;
  reason : string;
  perc, dManco : double;
  localUser: integer;
  transno : integer;
  editOK, canceled: boolean;
  block : TBlock;
  fsa : TForwardShortedAmountResult;
  EmployeeNumber: integer;
  art: rArt;
begin
  localUser := EmployeeNumber;
  art := fDespList.FindArticle(artno);

//  blockUpdate := true;
  try
    if (fDM.AuthenticateUser(EmployeeNumber)) then
    begin
      mrResult := mrCancel;

      proceed:=false;
      Manco := 0;


        fMancoAmount := TfMancoAmount.Create(nil);

        if (fMancoAmount <> nil) then
        begin
          fMancoAmount.CratesPcs := Container.CratesPcs;
          fMancoAmount.Artno := Artno;
          fMancoAmount.lblArticle.Caption := Artno + ' ' + art.DESCRIPTION;
          fMancoAmount.lblCurrAmnt.Caption := IntToStr(Needed);
          fMancoAmount.Amount := Needed;

          if GlobalDespatchOptions.ShowReason then
          begin
            fMancoAmount.EditReason.Visible := true;
            fMancoAmount.LabelReason.Visible := true;
          end; //if GlobalDespatchOptions.ShowReason

          mrResult := fMancoAmount.ShowModal;

          if (mrResult = mrOk) or (mrResult = mrYes) then
          begin


            if fMancoAmount.PercentageEntered then
            begin
              Perc := fMancoAmount.EnteredAmount;
              Perc := Perc / 100;
              dManco := Needed; //Ordered;
              dManco := dManco * Perc;
              Manco := Round(dManco);
            end else //if fMancoAmount.PercentageEntered
            begin
              Manco := fMancoAmount.EnteredAmount;
            end; //if fMancoAmount.PercentageEntered

            reason := fMancoAmount.EditReason.Text;
            proceed := true;
          end; //if (mrResult = mrOk) or

          freeandnil(fMancoAmount);
        end; //if (fMancoAmount <> nil)


      if proceed then
      try
        if (Manco = 0) then
        begin
          exit;
        end;

        if (Manco > Needed) then
        begin
          Manco := Needed;
        end;

        if (ScrType = SCRTYPE_ED) then
        begin
          exit;
        end;

        i := 0;
        Amount := Needed - Manco;

        // Block product
        Blocked := false;
        blkfnd := false;


          // Create despatch list
        fDespList.UpdateCustWaveart;


        CreateList(art, needed);

        if (maContainer <> nil) then
        begin
          //Before assigning the amount to the container, and when using
          //Delivery Units, make sure the amount is a multiple of the delivery unit
          if (maContainer.MethodUnits) then
          begin
            Amount := maContainer.MakeMultipleOf(Amount, Amount, maContainer.Artno);
          end; //if (MethodUnits)

          maContainer.UserId:=EmployeeNumber;
          maContainer.AmntNd:=Amount;
          maContainer.Amount:=maContainer.AmntNd;
          maContainer.IsTakeBack:=false;
          maContainer.AmountChanged:=true;
          maContainer.Starttime:=Now;
          maContainer.ScreenCCode:=GlobalCompany;
          maContainer.ScreenWS:=GlobalStation;
          maContainer.ScreenNo:=ScreenNumber;
          maContainer.Reason:=reason;
          maContainer.StackDespatch:=false;


          // Get despatch data
          ReadDespatchData;

          // Do the despatch thing
          maContainer.OrgAmount := maContainer.Amount;
          maContainer.CratesPcs := Container.CratesPcs;
          maContainer.Shipdate := Shipdate;
          maContainer.Method := TDespatchMethod(GlobalDespatchOptions.MancoAmountMethod);

          //Filter out all the orders which are not final!
          maContainer.FilterPrognosisOrders(fDM.dB, manco);

          DespatchList(maContainer);
          maContainer.SendToNextWave := (mrResult = mrYes);
          maContainer.InvertList;
          // Show result to user for adjustments

          editOK := false;

          if (GlobalDespatchOptions.MancoAmountEdit) then
          begin
            fChangecontainer := TfChangecontainer.Create(nil, maContainer, fDM.dB);
            canceled := false;

            while (not editOK) and (not canceled) do
            begin
              if (fChangecontainer.ShowModal = mrOk) then
              begin
                editOK := true;
                maContainer.FPhase := PHASE_MANCO;

                if (AManualAdjustment) then
                begin
                  maContainer.TransType := TRANS_PRODUCT_REQUIRED;
                end else //if (AManualAdjustment)
                begin
                  maContainer.TransType := TRANS_MANCO;

                  fsa := ForwardShortedAmount(Company, Shipdate, maContainer);
                  case fsa of
                    FSA_YES: ;
                    FSA_NO: ;
                    FSA_NOSHIPDATE: begin canceled := false; editOk := false; end;
                    FSA_BLOCKED: begin canceled := true; editOk := false; end;
                  end;
                end; //if (AManualAdjustment)
              end else //if (fChangecontainer.ShowModal = mrOk)
              begin
                canceled := true;
              end; //if (fChangecontainer.ShowModal = mrOk)
            end; //while (not editOK)

            fChangecontainer.Free;
          end else //if (GlobalDespatchOptions.MancoAmountEdit)
          begin
            maContainer.FPhase := PHASE_MANCO;

            if (AManualAdjustment) then
            begin
              maContainer.TransType := TRANS_PRODUCT_REQUIRED;
            end else //if (AManualAdjustment)
            begin
              maContainer.TransType := TRANS_MANCO;
            end; //if (AManualAdjustment)
          end; //if (GlobalDespatchOptions.MancoAmountEdit)

          if (not GlobalDespatchOptions.MancoAmountEdit) or (editOK) then
          begin
            // validate quantities
            if maContainer.ValidateQuantitiesAgainstDatabase then
            begin
              if true then //(AManualAdjustment) or Container.CheckFinalFlag then
                Background.BackGroundTask.Put(maContainer)
              else begin
                ShowMessage('Some or alle customer/route had their final flag set');
      //          block := TBlock.Create(fDM.dB);
                //block.DeblockProduct(Company, Shipdate, maContainer.ArtNo);
                //block.Free;
              end;
            end else begin
              ShowMessage('Data was not changed during this procedure. Please try again.');
              //block := TBlock.Create(fDM.dB);
              //block.DeblockProduct(Company, Shipdate, maContainer.ArtNo);
              //block.Free;
            end;
          end else //if (not GlobalDespatchOptions.MancoAmountEdit) or ...
          begin
            //block := TBlock.Create(fDM.dB);
            //block.DeblockProduct(Company, Shipdate, maContainer.ArtNo);
            //block.Free;
            ShowMessage('Data was not changed during this procedure. Please try again.');
          end; //if (not GlobalDespatchOptions.MancoAmountEdit) or ...

        end else // if Container<>nil then
        begin
          LogError('TfDespatchSelect.DoDespatch','Could not allocate memory for Container');
        end; // esle

      finally
//        EdMulti.Clear;
      end; //end of try at if proceed then
    end; //if (fDM.AuthenticateUser(EmployeeNumber))
  finally
    // reset employeenumber
    EmployeeNumber := localUser;
//    blockUpdate := false;
  end;
end;

procedure TfInterCompReceiveEnter.Fillcolumns;
var
  Tmp:TDespCol;
begin
  Tmp := TDespCol.Create(IC_COLUMN_STACKID,GlobalDespatchOptions.DefaultSmallColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_STACKID));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ORGSTACKID,GlobalDespatchOptions.DefaultSmallColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ORGSTACKID));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ARTNO,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ARTNO));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_DESCRIPTION,GlobalDespatchOptions.DefaultWideColumnWidth,
                          vGlobalStrings.GetString(GLOBSTR_COLUMN_DESCRIPTION));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_EXPECTED,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_EXPECTED));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ARRIVED,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ARRIVED));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ADJUST,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ADJUSTED));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_LEGACY,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_LEGACY));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_REASON,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_REASON));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_DAMAGE,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_DAMAGE));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_AVAILABLE,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_AVAILABLE));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_CCODE,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_CCODE));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_SHIPMENTID,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_SHIPMENT));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ODDCRATES,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ODDCRATES));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ALTARTNO,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ALTARTNO));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_ALTDESCRIPTION,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_ALTDESCRIPTION));
  Columns.Add(Tmp);


// Todo: This column has been intentionally marked out, do leave the code in though.
  Tmp := TDespCol.Create(IC_COLUMN_DESTINATION,GlobalDespatchOptions.DefaultWideColumnWidth,
                         vGlobalStrings.GetString(GLOBSTR_COLUMN_DESTINATION));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_DAILY_VOLUME, GlobalDespatchOptions.DefaultWideColumnWidth,
                          vGlobalStrings.GetString(GLOBSTR_BS_COLUMN_DAYVOLUME));
  Columns.Add(Tmp);

  Tmp := TDespCol.Create(IC_COLUMN_JULIANDATE, GlobalDespatchOptions.DefaultWideColumnWidth,
                          'Julian date');
  Columns.Add(Tmp);
end;

procedure TfInterCompReceiveEnter.FormShow(Sender: TObject);
begin
  inherited;
  if not Assigned(Container) then
    exit;

  // to be certain we disable the action if the setting is off
  if not GlobalIntercompanyOptions.AutoPredespatchIntracompany then
  begin
    self.aPredespatchRemainder.Enabled := false;
  end;

  if Assigned(Container) then
  begin
    // Update the shipment table to indicate we are receive the current shipment
    fDm.UpdateShipmentReceiveStatus(Container.ShipmentID, GlobalStation, true);
  end;

  fStackDespatchOrder := Container.StackDespatchOrder;
  if Container.supportRouting then
  begin
    if (fStackDespatchOrder <> do_Full_DD_Part) and
       (fStackDespatchOrder <> do_DD_Full_Part) then
       fStackDespatchOrder := do_Full_DD_Part;
    aDo_DD_Part_Full.Enabled := false;
    aDo_Full_Part_DD.Enabled := false;
    aDo_Part_DD_Full.Enabled := false;
    aDo_Part_Full_DD.Enabled := false;
    aDo_Full_DD_Part.Enabled := true;
    aDo_DD_Full_Part.Enabled := true;
  end;
  case fStackDespatchOrder of
    do_DD_Full_Part: aDo_DD_Full_Part.Checked := true;
    do_DD_Part_Full: aDo_DD_Part_Full.Checked := true;
    do_Full_DD_Part: aDo_Full_DD_Part.Checked := true;
    do_Full_Part_DD: aDo_Full_Part_DD.Checked := true;
    do_Part_DD_Full: aDo_Part_DD_Full.Checked := true;
    do_Part_Full_DD: aDo_Part_Full_DD.Checked := true;
  else
    begin
      aDo_DD_Full_Part.Checked := true;
      fStackDespatchOrder := do_DD_Full_Part;
    end;
  end;


  //It's imperative that this is done before the first show is triggered
  if Assigned(Container) then
  begin
    //MSO-ASN:
    ICController.SetRefreshEvent(ScreenNumber, RefreshGrid);
    ICController.SetStockChangeEvent(ScreenNumber, GetStockChanges);

    //We need to use this dirty trick so the controller knows this information
    //Which is only currently stored in the screen, since the controller classes
    //get cleaned up every time the 2nd despatch screen is canceled or confirmed
    Container.AskStockDestination := AskStockDestination;
    Container.DestinationCompany := DestinationCompany;
    Container.DestinationGloc := DestinationGloc;
    Container.DestinationDescription := DestinationDescription;
    Container.DestinationIsControlled := DestinationIsControlled;
  end;

  if DespFirstShow then
  begin
    lastRowIndex := 1;
    DespFirstShow := false;
    bCratesPcs := false;
    SetColumnsForGrid;

    // Ask a stock location beforehand if Dockmanager scanning is used
    if GlobalIntercompanyOptions.DockManagerScanning then
    begin
      //MSO-ASN:
      ICController.AskStockLocation(ScreenNumber);
    end;

    oldRow := -1;
  end;
  DetermineRows;
  //DrawGrid1.Row := 1;
  DrawGrid1.Row := lastRowIndex;

  Label1.Caption := ScreenLabel;
  Activecontrol:=eUserId;
  DrawGrid1.RowCount := Container.Nodes.Count + 1;
  if Container.Nodes.Count = 0 then DrawGrid1.RowCount := 2;
  DrawGrid1.FixedRows := 1;
  if Assigned(Container) then
  begin
    RetrieveStacksCreated(Container.ShipmentID);
    Container.Sort(CS_STACKID);
    Label1.Caption := 'Shipment: ' + container.ShipmentID;
    self.ShipDate := Container.Shipdate;
  end;

  DrawGrid1.Options := DrawGrid1.Options + [goRowSelect];
  DrawGrid1.Invalidate;
  eSearch.SetFocus;
end;

function TfInterCompReceiveEnter.ForwardShortedAmount(ACompany: integer;
  AShipdate: string; AContainer: TSNodeContainer): TForwardShortedAmountResult;
var
  sh: TShipdate;
  st: TShipdateState;
  nextShipdate: string;
  Future: TFuture;
begin
  Result := FSA_NO;

  if (GlobalDespatchOptions.ForwardShortedProduct) then
  begin
    sh := TShipdate.Create(fDM.dB);
    st := sh.GetState(ACompany, AShipdate);

    if (st in [SHIPDATE_STATE_FINAL]) then
    begin
      if (MessageDlg(vGlobalStrings.GetString(GLOBSTR_APPLY_CUTS_TO_NEXTDAY), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      begin
        // check if nothing has been changed in terms of required and predispatched quantities during the shortage function (Ctrl-F8)
        if (not AContainer.OrderOrPDHasBeenChanged(fDM.dB, AShipdate, AContainer.ArtNo)) then
        begin
          nextShipdate := sh.FindNextFinalSalesDay(AContainer, 7);

          if (nextShipdate = EmptyStr) then
          begin
            MessageDlg(vGlobalStrings.GetString(GLOBSTR_CANNOT_FIND_VALID_NEXTDAY), mtWarning, [mbOk], 0);
            Result := FSA_NOSHIPDATE;
          end else //if (nextShipdate = EmptyStr)
          begin
            //apply minused quantities as extra order on nextday
            Future := TFuture.Create;
            Future.ForwardContainer(AContainer, nextShipdate);
            Future.Free;
            Result := FSA_YES;
          end; //if (nextShipdate = EmptyStr)
        end
        else
          // order or PD has been changed during shortage function (Ctrl-F8)
          Result := FSA_BLOCKED;
      end  //if (MessageDlg(vGlobalStrings.GetString(GLOBSTR_APPLY_CUTS_TO_NEXTDAY), mtConfirmation, [mbYes, mbNo], 0) = mrYes)
      else if ( AContainer.OrderOrPDHasBeenChanged(fDM.dB, AShipdate, AContainer.ArtNo)) then
          Result := FSA_BLOCKED;
    end; //if (st in [SHIPDATE_STATE_FINAL])
    sh.Free;
  end; //if (GlobalDespatchOptions.ForwardShortedProduct)
end;

procedure TfInterCompReceiveEnter.FreeList(var List: TList);
var i : integer;
begin
  for i:=0 to List.Count-1 do
  begin
    if List.Items[i]<>nil then
    begin
      dispose(List.Items[i]);
      List.Items[i]:=nil;
    end;
  end;
  List.Pack;
end;

procedure TfInterCompReceiveEnter.DrawGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var s : string;
    right:boolean;
    isNewStack : boolean;
    isAlternative : boolean;
    isMixedStack : boolean;
    isLastStack : boolean;
    isInCustomerGroup : boolean;
begin
  inherited;
  if not Assigned(Container) then
    exit;
  isNewStack := false;
  isMixedStack := false;
  isLastStack := false;
  if VisibleColumns.Count=0 then exit;
  right:=false;
  if gdFixed in State then
  begin // Paint header
    s := GetColumnValue(ARow, ACol, VisibleColumns, Right, isNewStack, isAlternative, isMixedStack, isLastStack, isInCustomerGroup);
    pcdDrawText (DrawGrid1.Canvas.Handle, s, Rect, False);
  end else
  begin
    if (ARow<=Container.Nodes.Count) and (ARow>0) then
    begin
      s := GetColumnValue(ARow, ACol, Visiblecolumns, Right, isNewStack,
           isAlternative, isMixedStack, isLastStack, isInCustomerGroup);
      if GlobalDespatchOptions.SuppressZeros and (s='0') then s:='';
      if gdSelected in State then
      begin
        // Highlight selected row
        if isNewStack then
        begin
          if isMixedStack then
          begin
            DrawGrid1.Canvas.Font.Color := clSkyBlue;
          end else
          begin
            DrawGrid1.Canvas.Font.Color := clYellow;
          end;

          // Highlight the last stack created to indicate it can be edited
          if isLastStack then
          begin
            DrawGrid1.Canvas.Font.Color := clWhite;
          end;

        end else
          if isAlternative then
            DrawGrid1.Canvas.Font.Color := clAqua
          else
            DrawGrid1.Canvas.Font.Color:=clWhite;
        DrawGrid1.Canvas.Brush.Color:=self.HighLightColor; //clHighlight;
        DrawGrid1.Canvas.Rectangle(Rect);
      end else
      begin
        // Set colour for newly created stacks
        if isNewStack then
        begin
          // Highlight the last stack created
          if isLastStack then
          begin
            DrawGrid1.Canvas.Font.Color := clBlack;
            //DrawGrid1.Canvas.Brush.Color := clSilver;
            DrawGrid1.Canvas.Brush.Color := 8911062;    // A shade of green
            DrawGrid1.Canvas.FillRect(Rect);
          end
          else
          begin
            // Mixed stack
            if isMixedStack then
            begin
              DrawGrid1.Canvas.Font.Color := clBlack;
              DrawGrid1.Canvas.Brush.Color := clSkyBlue;
              DrawGrid1.Canvas.FillRect(Rect);
            end
            else
            begin
              DrawGrid1.Canvas.Font.Color := clBlack;
              DrawGrid1.Canvas.Brush.Color := clYellow;
              DrawGrid1.Canvas.FillRect(Rect);
            end;
          end;
        end else
        begin
          // Set colour for line with alternative selected
          if isInCustomerGroup then
          begin
            DrawGrid1.Canvas.Font.Color:=clBlack;
            DrawGrid1.Canvas.Brush.Color:=clLime;
            DrawGrid1.Canvas.FillRect(Rect);
          end else begin
            if isAlternative then
            begin
              DrawGrid1.Canvas.Font.Color := clBlack;
              DrawGrid1.Canvas.Brush.Color := clAqua;
              DrawGrid1.Canvas.FillRect(Rect);
            end
            else
            begin
              DrawGrid1.Canvas.Font.Color:=clBlack;
              DrawGrid1.Canvas.Brush.Color:=clWhite;
            end;
          end;
        end;
        // Set special colour for alternate rows
        if GlobalDespatchOptions.AlternateCol then
        begin
          if (ARow mod 2)=0 then
          begin
            DrawGrid1.Canvas.Brush.Color:=GlobalDespatchOptions.AltColCol;
            DrawGrid1.Canvas.FillRect(Rect);
          end;
        end;

      end;
      pcdDrawText (DrawGrid1.Canvas.Handle, s, Rect, GlobalDespatchOptions.AlignRight and right);
    end;
  end;

  //MSO: Update the labels at the bottom of the screen, but only if the row number changed
  //If we don't check the row number the performance will drop drastically due
  //to the addition of the "stack count" at the bottom right.
  if (oldRow <> DrawGrid1.Row) then
  begin
    oldRow := DrawGrid1.Row;
    UpdateInfo;
  end; //if (oldRow <> ARow)
end;

procedure TfInterCompReceiveEnter.aExtraSetColumnsExecute(Sender: TObject);
begin
  inherited;
  SetColumnsForGrid;
  DrawGrid1.Invalidate;
end;

procedure TfInterCompReceiveEnter.aFltCustGroupExecute(Sender: TObject);
begin
  inherited;
  // Customer group
  fDespFilter:= TfDespFilter.Create( Application, FILTER_CUSTGROUP, lCustgroupFilter, lSystemCustGroupFilter, Company, Glocid, Shipdate, false);
  case fDespFilter.ShowModal of
    mrOk:
      begin
        FilterCustGroup := lCustGroupFilter.Count > 0;
        aFltCustGroup.Checked := lCustGroupFilter.Count > 0;
        TIntercompanyReceiver(fDespatchSelect[ScreenNumber]).RegisterTransaction(TRANS_FILTER_CUSTOMERGROUP);
      end;
    mrNo:
      begin
        FilterCustGroup := false;
        aFltCustGroup.Checked := false;
        fDESPList.Clear(lCustGroupFilter);
      end;
  end;
  FreeAndNil( fDespFilter);
  BuildFilterString(FILTER_CUSTGROUP);
  ApplyCustGroupFilterToNodes;
  DrawGrid1.Invalidate;
end;

procedure TfInterCompReceiveEnter.aFltStreetExecute(Sender: TObject);
begin
  inherited;
    // Street
  fDespFilter := TfDespFilter.Create( Application, FILTER_STREET, lStreetFilter, lSystemStreetFilter, Company, Glocid, Shipdate, UseSystemFilters);
  case fDespFilter.ShowModal of
    mrOk:
      begin
        FilterStreet := lStreetFilter.count>0;
        aFltStreet.Checked := lStreetFilter.count>0;
        RegisterTransaction(TRANS_FILTER_STREET);
      end;
    mrNo:
      begin
        FilterStreet := false;
        aFltStreet.Checked := false;
        fDESPList.ClearList(lStreetFilter);
      end;
  end;
  FreeAndNil( fDespFilter);
  BuildFilterString( FILTER_STREET);
end;

procedure TfInterCompReceiveEnter.aFltWaveExecute(Sender: TObject);
begin
  inherited;
  fDespFilter:= TfDespFilter.Create( Application, FILTER_WAVE, lWaveFilter, lSystemWaveFilter, Company, Glocid, Shipdate, UseSystemFilters);

  case fDespFilter.ShowModal of
    mrOk:
      begin
        FilterWave := lWaveFilter.Count>0;
        aFltWave.Checked := lWaveFilter.Count>0;
        // TODO: Should this be implemented here?
        // RegisterTransaction(TRANS_FILTER_WAVE);
      end;
    mrNo:
      begin
        FilterWave := false;
        aFltWave.Checked := false;
        fDESPList.Clear(lWaveFilter);
      end;
  end;

  FreeAndNil( fDespFilter);
  BuildFilterString( FILTER_WAVE);
  UpdateInfo;
end;

procedure TfInterCompReceiveEnter.aItemAttributesExecute(Sender: TObject);
var
  fEdit : TfEditItemAttributes;
  artInfo : TArtPPB;
  index : integer;
  selected : TSNode;
  artNo : string;
  tmpArt, art : Desplist.rArt;
  tmp : TArtPPB;
  transaction : TTransno;
  logTransAction : boolean;
  masterPPB : integer;
  masterStackType : integer;
  masterStackHeight : integer;
  asnPPB : integer;
  asnStackType : integer;
  asnStackHeight : integer;
begin
  inherited;
  logTransAction := false;

  // No messing if the setting is off
  if not GlobalInterCompanyOptions.AllowAttributeChange then
    exit;

  index := DrawGrid1.Row-1;
  selected := Container.Nodes[index];
  artno := selected.ArtNo;

  tmpArt := fDespList.FindArticle(artno);
  if not assigned(tmpArt) then
    exit;

  // Copy the object: do not edit the original!
  art := rArt.Create;
  art.ARTNO := tmpArt.ARTNO;
  art.DESCRIPTION := tmpArt.DESCRIPTION;
  art.StackType := tmpArt.StackType;
  art.StackHeight := tmpArt.StackHeight;
  art.DefaPcsPerBasket := tmpArt.DefaPcsPerBasket;

  // Get the master data before the article is changed
  masterStackType := art.StackType;
  masterStackHeight := art.StackHeight;
  masterPPB := art.DefaPcsPerBasket;
  asnStackType := art.StackType;
  asnStackHeight := art.StackHeight;
  asnPPB := art.DefaPcsPerBasket;

  // We send a message to Dockmanager to block the shipment
  NetClient.Send(Format('%s(%s)', [GlobalConstEventDMBlock, Container.ShipmentID]));

  // Already in the dictionary?
  tmp := ICController.GetItemAttributes(artNo, ScreenNumber);
  if Assigned(tmp) then
  begin
    asnStackType := tmp.StackType;
    asnStackHeight := tmp.StackHeight;
    asnPPB := tmp.UnitsPerTray;
  end;

  fEdit := TfEditItemAttributes.Create(nil);
  if Assigned(selected) and selected.HasAsnData then
  begin
    fEdit.hasAsnData := true;
    fEdit.lblAsnStackheight.Caption := Format('%d', [Selected.StackHeight]);
    fEdit.lblAsnPPB.Caption := Format('%d', [Selected.PcsPerBasket]);
    case selected.StackType of
      1 : fEdit.lblAsnStackType.Caption := 'tray';
      2 : fEdit.lblAsnStackType.Caption := 'box'
      else
        fEdit.lblAsnStackType.Caption := 'tray';
    end;
  end;

  fEdit.lblArtno.Caption := Format('Item: %s %s', [art.ARTNO, art.DESCRIPTION]);
  fEdit.lblMasterStackheight.Caption := Format('%d', [masterStackHeight]);

  // In the interface Carriertype 4 (Case) is set to stacktype 2, the others to 1
  case masterStackType of
    1 : fEdit.lblMasterStackType.Caption := 'tray';
    2 : fEdit.lblMasterStackType.Caption := 'box'
    else
      fEdit.lblMasterStackType.Caption := 'tray';
  end;

  fEdit.lblMasterPPB.Caption := Format('%d', [masterPPB]);
  fEdit.edtStackHeight.Text := IntToStr(asnStackHeight);
  fEdit.edtPPB.Text := IntToStr(asnPPB);
  fEdit.cbStackType.ItemIndex := asnStackType-1;
  if fEdit.ShowModal = mrOk then
  begin
    // The user may or may not have changed the settings
    // For now, we always add the item to the dict if the dialog has been confirmed
    artInfo := TArtPPB.Create;
    artInfo.Artno := art.ARTNO;
    artInfo.StackType := fEdit.cbStackType.ItemIndex + 1;
    artInfo.UnitsPerTray := StrToInt(Trim(fEdit.edtPPB.Text));
    artInfo.StackHeight := StrToInt(Trim(fEdit.edtStackHeight.Text));

//    if (artInfo.StackType <> art.StackType) or
//       (artInfo.UnitsPerTray <> art.DefaPcsPerBasket)
//       (artInfo.StackHeight <> art.StackHeight) then

    begin
      ICController.EditItemAttributes( artInfo, ScreenNumber);
      Drawgrid1.Refresh;
      lblPPC.Caption := IntToStr(artInfo.UnitsPerTray);
      self.lblStackheight.Caption := IntToStr(artInfo.StackHeight);
      Selected.StackHeight := artInfo.StackHeight;
      Selected.PcsPerBasket := artInfo.UnitsPerTray;
      Selected.StackType := artInfo.StackType;
      logTransAction := true;
    end;
    (*
    else
    begin
       logTransAction := false;
    end;
    *)
    if Assigned(artInfo) then
      FreeAndNil(artInfo);

    if logTransaction then
    begin
      fDM.dB.StartTransaction;
      try
        transaction := fDM.NewTransaction;
        if (transaction <> nil) then
        begin
          transaction.EMPLOYEENO := Container.UserId;
          transaction.TTYPE := TRANS_MANUALADJUSTITEMATTRIBUTES;
          transaction.SUBTTYPE := SUBTTYPE_ITEM_ATTRIBUTECHANGE;
          transaction.SHIPDATE := ShipDate;
          transaction.SCREENNO := ScreenNumber;
          transaction.CCODEGLOC := Company;
          transaction.GLOCID := GLocId;
          transaction.Artno := selected.Artno;
          transaction.AMOUNT := Selected.StackHeight * Selected.PcsPerBasket;

          transaction.Update;
          FreeAndNil(transaction);
        end;
        fDM.dB.Commit;
      except
        fDM.dB.Rollback;
      end;
    end;

  end;

  if Assigned(art) then
    art.free;

  fEdit.Free;
  // Tell Dockmanager to unblock the shipment again
  NetClient.Send(Format('%s(%s)', [GlobalConstEventDMUnBlock, Container.ShipmentID]));
end;

procedure TfIntercompReceiveEnter.EditStack(isFirst : boolean);
var
  index : integer;
  node : TSNode;
begin
  if not Assigned(Container) then
    exit;
  // Non-Flowers handling
  if GlobalDespatchOptions.AllowDamageReceived then
  begin
    index := DrawGrid1.Row-1;
    node := Container.Nodes[index];
    if Assigned(node) then
    begin
      if not node.isNewStack then
      begin
        if not EditMode and (not node.isNewStack) then
        begin
          EditMode := True;
          //DrawGrid1.Col := findToDesp(IC_COLUMN_ARRIVED);
          DrawGrid1.Col := findToDesp(IC_COLUMN_DAMAGE);
          DrawGrid1.Options := DrawGrid1.Options - [goRowSelect];
        end else //if not EditMode and ...
        begin
          EditMode := false;
          DrawGrid1.Options := DrawGrid1.Options + [goRowSelect];
        end; //if not EditMode and ...
      end; //if not node.isNewStack
    end; //if Assigned(node)
  end else //if GlobalDespatchOptions.AllowDamageReceived
  begin
    // Flowers handling
    if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes then
    begin
      ICController.EditStack((DrawGrid1.Row - 1), isFirst, ScreenNumber);

      DrawGrid1.RowCount := Container.Nodes.Count + 1;     // Fix to see the yellow lines again

      // If Dockmanager is scanning, locate the last new stack created
      if disableInboundScanMessages then
      begin
        index := ICController.FindLastCreatedStack(ScreenNumber);

        if index <> -1 then
        begin
          Drawgrid1.Row := index + 1;
          lastRowIndex := index + 1;
        end;
      end;

      DrawGrid1.Refresh;
    end; //if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes
  end; //if GlobalDespatchOptions.AllowDamageReceived
end;

function TfInterCompReceiveEnter.theCurrentLineIsIMProduct: boolean;
var
  index : integer;
  node : TSNode;
  art: rArt;
begin
  result := false;
  index := DrawGrid1.Row-1;
  node := Container.Nodes[index];
  if assigned(node) then
  begin
    art := fDespList.FindArticle(node.ArtNo);
    result := art.IsIMProduct and node.isNewStack and ICController.IsEditableStack(LowerCase(node.LPN), ScreenNumber);
  end;
end;

procedure TfInterCompReceiveEnter.UndoStack;
var
  index : integer;
  node : TSNode;
  undo: TfDUD;
  originalLPN: string;
  Q: TFDQuery;
  stackid: string;

  function FindOriginalNode(stackid: string): integer;
  var i : integer;
      n : TSNode;
  begin
    result := -1;
    for i := 0 to container.Nodes.Count - 1 do
    begin
      n := container.Nodes[i];
      if (not n.isNewStack) and (n.LPN = stackid) then
      begin
        result := i;
        break;
      end;
    end;
  end;

begin
  index := DrawGrid1.Row - 1;
  node := Container.Nodes[index];
  if (Application.MessageBox(PChar(vGlobalStrings.GetString(GLOBSTR_ASK_UNDO_STACK)),
                            PChar(vGlobalStrings.GetString(GLOBSTR_UNDO_STACK)),
                            MB_YESNO or MB_DEFBUTTON2) = IDYES) then
  begin
    originalLPN := node.orgLPN;
    undo := TfDUD.Create(nil);
    undo.Undo(node.Transno, GlobalUserId);
    undo.Free;
    Q := TFDQuery.Create(nil);
    Q.ConnectionName := fDM.dB.ConnectionName;
    Q.SQL.Text := 'update gloc_atp_res set quantarr=0, arr=''N'' where stackid=:stackid and '+
                  'transno=(select createdfromtransno from gloc_atp_res where transno=(select createdfromtransno from gloc_atp_res where transno=:transno))';
    Q.ParamByName('stackid').AsString := node.orgLPN;
    Q.ParamByName('transno').AsInteger := node.Transno;
    stackid := node.orgLPN;
    Q.ExecSQL;

    // Log
    Utils.DebugLogFormatGM('TfInterCompReceiveEnter.UndoStack(transno %d, stackid %s, quantarr %d)',
                         [node.transno, node.orgLPN, 0]);

    Q.Free;
    Container.NodesBackup.Remove(node);
    node.Free;
    Container.Nodes[index] := nil;
    container.Nodes.Pack;

    index := FindOriginalNode(stackid);
    if (index > -1) then
    begin
      node := container.Nodes[index];
      node.Ordered := node.Ordered + node.ToDeliver;
      node.ToDeliver := 0;
    end;

    if Container.Nodes.Count = 0 then
    begin
      DrawGrid1.RowCount := 2;
    end else
      Drawgrid1.RowCount := Container.Nodes.Count + 1;
    DrawGrid1.Row := Drawgrid1.RowCount - 1;
    Drawgrid1.Refresh;
  end;
end;

// Key handler
procedure TfInterCompReceiveEnter.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  searchString : string;
  index, i : integer;
  node : TSNode;
  parser : TBarcodeParser;
  art : rart;
  arts : TArray<rArt>;
  list: TObjectList;
begin
  inherited;

  case key of

    VK_F8 :
        if theCurrentLineIsIMProduct then
        begin
          UndoStack;
        end else begin
          EditStack;
        end;

    VK_F9 :
      begin
        if not Assigned(container) then exit;

        index := DrawGrid1.Row-1;
        node := Container.Nodes[index];
        if Assigned(node) then
        begin
          if not EditMode and (not node.isNewStack) then
          begin
            EditMode := True;
            DrawGrid1.Col := findToDesp(IC_COLUMN_ARRIVED);
            DrawGrid1.Options := DrawGrid1.Options - [goRowSelect];
          end else
          begin
            EditMode := false;
            DrawGrid1.Options := DrawGrid1.Options + [goRowSelect];
          end; //if not EditMode then
        end; //if Assigned(node)
      end;

    VK_RETURN :
      begin
        index := -1;

        if not Assigned(container) then
          exit;

        if NOT eSearch.Focused then
          exit;

        if aSearchArticles.Checked then
          SearchString := Trim(eSearch.Text)
        else
        begin
          if GlobalBarcodeOptions.useExtendedBarcode then
          begin
            try
              parser := TBarcodeParser.Create(GlobalBarcodeOptions.extendedBarcodeMask);
              if parser.IsBarcodeValidForMask(Trim(eSearch.Text)) then
              begin
                parser.Barcode := Trim(eSearch.Text);
                searchString := parser.StackId
              end
              else
                searchString := Trim(eSearch.Text);
              parser.Free;
            except
              searchString := Trim(eSearch.Text);
            end;
          end else
            searchString := barcode.BarcodeToStackId(Trim(eSearch.Text));
        end;
        art := nil;

        searchString := Trim(searchString);
        if (Length(searchString) = 0) then
          Exit;

        if (searchString <> '-1') then
        begin
          arts := fDESPList.FindArticlesByBarcode(searchString);
          list := TObjectList.Create(False);

          try
            // Only use the articles which are in this truck
            for i := 0 to Length(arts) -1 do
               if (FindProduct((arts[i] as rArt).ARTNO) >= 0) then
                  list.Add(arts[i]);

            if (list.Count > 0) then
              if (list.Count = 1) then
              begin
                // There's only one article found with this barcode
                art := list[0] as rArt;
              end else
              begin
                // Multiple articles found. User chooses
                art := TdlgBarcodeProducts.SelectArticle(list);
              end;
          finally
            list.Clear;
            FreeAndNil(list);
          end;

          if art <> nil then
            index := FindProduct(art.ARTNO);

          if (index < 0) then
            index := FindLike(searchString, aSearchArticles.Checked);
        end;

        key := 0;

        if (index < 0) OR (index >= Container.Nodes.Count) then
        begin
          eSearch.SelectAll;
          eSearch.SetFocus;
          Exit;
        end;

        if (GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes and not aSearchArticles.Checked) then
        begin
          node := Container.Nodes[index];
          drawgrid1.Row := index + 1;

          self.aCreateStackExecute(self);
          eSearch.Clear;
          eSearch.SetFocus;

          if Assigned(node) then
            FindLike(node.LPN);
        end;

        if (GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes and aSearchArticles.Checked) then
          DrawGrid1.Row := index + 1;
      end;
    VK_SPACE :
      begin
        eSearch.Clear;
        self.NextScreen;
      end;

    VK_F6 :
      begin
        if not Assigned(container) then exit;
        self.aCreateStackExecute(nil);
      end;

    VK_DOWN:
      begin
        // Textbox for user id is already handled in base form
        if DrawGrid1.Row<(DrawGrid1.RowCount-drawgrid1.FixedRows) then
        begin
          DrawGrid1.Row := DrawGrid1.Row + 1;
          lastRowIndex := DrawGrid1.Row;
          Key:=0;
        end;
        if NOT eSearch.Focused then
          eSearch.SetFocus;
      end;

    VK_UP:
      begin
        // textbox for user id is already handled in base form
        if DrawGrid1.Row>DrawGrid1.FixedRows then
        begin
          DrawGrid1.Row := DrawGrid1.Row - 1;
          lastRowIndex := DrawGrid1.Row;
          Key:=0;
        end;
        if NOT eSearch.Focused then
          eSearch.SetFocus;
      end;
  end; //case key of
end;

// Update the info labels at the bottom of the screen
procedure TfInterCompReceiveEnter.UpdateInfo;
var
  node : TSNode;
  i : integer;
begin
  if not Assigned(container) then exit;

  // Try except added because for some reason the Row property can
  // not be read occasionally
  try
    i := DrawGrid1.Row-1;
  except
    exit; // i is undefined so exit might be the wiser course of action
          // although i==-1 means exit a little further on
  end;

  if not Assigned(Container.Nodes) then
    exit;

  // Bail out if we detect an invalid index
  if (i < 0) or (i >= Container.Nodes.Count) then
    exit;

  node := nil;
  try
    node := Container.Nodes[i];
  except
    ;
  end;

  if Assigned(node) then
  begin
    if Length(node.AltArtno) > 0 then
    begin
      lblPPC.Caption := IntToStr(node.AltPPB);
      lblStackheight.Caption := IntToStr(node.AltStackHeight);
    end
    else
    begin
      lblPPC.Caption := IntToStr(node.PcsPerBasket);
      lblStackheight.Caption := IntToStr(node.StackHeight);
    end;

    //MSO: Calling this might need a setting when it is incorporated in the
    //regular release version!!!
    CalculateStackDest(node);
  end;

  lblPPC.Refresh;
  lblStackheight.Refresh;

  if HighestWaveNumber > 1 then
  begin
    lblHighestWave.Caption := Format('Highest wave available is %d', [HighestWaveNumber]);
    lblHighestWave.Visible := true;
  end else begin
    lblHighestWave.Visible := false;
  end;
end;

function TfInterCompReceiveEnter.WaveFilter(cwa: rCustwaveart): boolean;
var j: integer;
    Selected: boolean;
    pInt: pinteger;
begin
  j := 0;
  Selected := false;

  while (j < lWaveFilter.Count) and not Selected do
  begin
    pInt := lWaveFilter.Items[j];

    if cwa.Waveno=pInt^ then
      Selected := true;

    inc(j);
  end;

  Result := Selected;
end;

// Handler for edit mode
procedure TfInterCompReceiveEnter.aMenuFilterExecute(Sender: TObject);
begin
  inherited;
  ;
end;

procedure TfInterCompReceiveEnter.aModExecute(Sender: TObject);
var
  index : integer;
  node : TSNode;
begin
  inherited;
  if not Assigned(container) then exit;
  if (not GlobalDespatchOptions.AllowChange) or (not GlobalDespatchOptions.AllowDamageReceived) then
    Exit;
  F9Counter := F9Counter + 1;

  if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes and false then
  begin
    index := DrawGrid1.Row - 1;
    node := Container.Nodes[index];
    if Assigned(node) then
    begin
      if node.isNewStack then
      begin
        EditMode := True;
        DrawGrid1.Col := findToDesp(IC_COLUMN_ARRIVED);
        DrawGrid1.Options := DrawGrid1.Options - [goRowSelect];
      end else
        exit;
    end;
  end else
  begin
    if not EditMode then
    begin
      EditMode := True;
      DrawGrid1.Col := findToDesp(IC_COLUMN_ARRIVED);
      DrawGrid1.Options := DrawGrid1.Options - [goRowSelect];
      Exit;
    end;
  end;
  DetermineModificationState;
  ActiveControl := DrawGrid1;
  ExecuteModificationState;
  ModificationState := msNone;
end;

procedure TfInterCompReceiveEnter.ApplyCustGroupFilterToNodes;
var list : TList;
    i : integer;
    node : TSNode;
    j: Integer;
    cwa : rCustWaveArt;
begin
  if lCustGroupFilter.Count > 0 then
  begin
    list := TList.Create;
    fDespList.GetCWAForCustomerGroups(company,shipdate,lCustGroupFilter,list);
    for i := 0 to container.Nodes.Count - 1 do
    begin
      node := container.Nodes[i];
      if not node.isNewStack then
      begin
        node.isIncustomerGroup := false;
        for j := 0 to list.Count - 1 do
        begin
          cwa := list[j];
          if (cwa.Artno = node.ArtNo) then
          begin
            node.isIncustomerGroup := true;
            break;
          end;
        end;
      end;
    end;
    list.Free;
  end else begin
    for i := 0 to container.Nodes.Count - 1 do
    begin
      node := container.Nodes[i];
      if not node.isNewStack then
        node.isIncustomerGroup := false;
    end;
  end;
end;

// Retrieves the value from the list if the grid is in edit mode
procedure TfInterCompReceiveEnter.DrawGrid1SetEditText(Sender: TObject;
  ACol, ARow: Integer; const Value: String);
var
  List: TList;
  Temp: TSNode;
  test: integer;
  cTmp: TDespCol;
begin
  inherited;
  if not Assigned(container) then exit;
  cTmp := VisibleColumns.Items[drawgrid1.col];
  test := cTmp.Item;

  List := Container.Nodes;
  if (List.Count>0) and (ARow<=(List.Count)) and (ARow>=1) then
  begin
    case test of
      IC_COLUMN_ARRIVED :
      begin
        Temp := List.Items[ARow-1];
        if not Despatch_StrToInt (Value,Container,Temp,test) then
          exit;
        Temp.ToDeliver := test;
        Temp.Damage := Max(Temp.Damage, Temp.ToDeliver);
        Container.Phase := PHASE_MANCO;
      end;

      IC_COLUMN_DAMAGE :
      begin
        Temp := List.Items[ARow-1];
        if not Despatch_StrToInt (Value,Container,Temp,test) then
          exit;
        // We cannot have more damage than what has arrived
        Temp.Damage := Min(Temp.todeliver, test);
      end;
    end; // Case

  end; // if (List.Count>0) and (ARow<=(List.Count)) and (ARow>=1) then
end;

procedure TfInterCompReceiveEnter.eUserIdKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
//var List:TList;
begin
  inherited;
  if Container<>nil then
  begin
    if Key in [VK_UP, VK_SUBTRACT,VK_DOWN, VK_ADD] then
    begin
      if GlobalDespatchOptions.ShopInitAllZero then DDFlag:=true
      else DDFlag:=false;
      Key:=0;
      PostKeyEx32( VK_F9, [], false );
    end;
  end;
end;

procedure TfInterCompReceiveEnter.ReadDespatchData;
var
    Artno        : string;
begin
  if maContainer=nil then
  begin
    LogError('TfDespatchSelect.ReadDespatchData','Container=nil');
    exit;
  end;

  maContainer.FromInterCompany := 0;
  Artno:=maContainer.ArtNo;
  PDDDReadDespatchData(Artno,maContainer);
  //if maContainer.supportRouting then
  //  DespMethodRouting(maContainer, true, true);
  maContainer.SynchronizePpb;
  maContainer.Log('c:\End ReadDespatchData.txt');
end;

procedure TfInterCompReceiveEnter.ReadSettings;
var Q:TFDQuery;
    SortOrder:TSortOrder2;
    tmp : string;
begin
  // inherited
  if not GlobalDespatchOptions.AllowChange then DrawGrid1.Options:=DrawGrid1.Options+[goRowSelect];
  Q:=TFDQuery.Create(nil);
  if Q<>nil then
  begin
    try
      Q.ConnectionName:=fDM.dB.ConnectionName;
      Q.SQL.Clear;
      Q.SQL.Add('SELECT ');
      Q.SQL.Add('  WSSCREEN.CCODE	,');
      Q.SQL.Add('  WSSCREEN.WS	,');
      Q.SQL.Add('  WSSCREEN.SCREENNO	,');
      Q.SQL.Add('  WSSCREEN.DESCRIPTION	,');
      Q.SQL.Add('  WSSCREEN.CCODEGLOC	,');
      Q.SQL.Add('  WSSCREEN.GLOCID	,');
      Q.SQL.Add('  WSSCREEN.COLOR	,');
      Q.SQL.Add('  WSSCREEN.SCRTYPE	,');
    //MSO: Field became obsolete since it is not filled in, and it's not possible to fill it in
    //  Q.SQL.Add('  WSSCREEN.LANG	,');
      Q.SQL.Add('  WSSCREEN.TARGET	,');
      Q.SQL.Add('  WSSCREEN.SHOWPROGRESS	,');
      Q.SQL.Add('  WSSCREEN.MINWAVE	,');
      Q.SQL.Add('  WSSCREEN.MAXWAVE	,');
      Q.SQL.Add('  WSSCREEN.MINROUTE	,');
      Q.SQL.Add('  WSSCREEN.MAXROUTE	,');
      Q.SQL.Add('  WSSCREEN.MINSTREET	,');
      Q.SQL.Add('  WSSCREEN.MAXSTREET	,');
      Q.SQL.Add('  WSSCREEN.PRODGROUP	,');
      Q.SQL.Add('  WSSCREEN.ALLART,');
      Q.SQL.Add('  WSSCREEN.COLUMNS1	,     ');
      Q.SQL.Add('  WSSCREEN.COLUMNS2	,');
      Q.SQL.Add('  WSSCREEN.METHOD	,');
      Q.SQL.Add('  WSSCREEN.STACKDESPORDER	,');
      Q.SQL.Add('  WSSCREEN.ARTNOTRDY	,');
      Q.SQL.Add('  WSSCREEN.PRIORITY	,');
      Q.SQL.Add('  WSSCREEN.BUFFERFILTER	,');
      Q.SQL.Add('  WSSCREEN.ARTNOTED	,');
      Q.SQL.Add('  WSSCREEN.SORTORDER	,');
      Q.SQL.Add('  WSSCREEN.READONLY	,');
      Q.SQL.Add('  WSSCREEN.SCRFILTER	,');
      Q.SQL.Add('  WSSCREEN.SORTORDER2	,');
      Q.SQL.Add('  WSSCREEN.ISVISIBLE	,');
      Q.SQL.Add('  WSSCREEN.DESPUNITS	,');
      Q.SQL.Add('  WSSCREEN.confirmamount, WSSCREEN.useuidconfirm,');
      Q.SQL.Add('  GLOC.CCODE as ccode1,');
      Q.SQL.Add('  GLOC.GLOCID as glocid1,');
      Q.SQL.Add('  GLOC.DESCRIPTION,');
      Q.SQL.Add('  GLOC.DEEPLVL,');
      Q.SQL.Add('  GLOC.GLTYPE,');
      Q.SQL.Add('  GLOC.ICONTYPE,');
      Q.SQL.Add('  GLOC.ICONNO,');
      Q.SQL.Add('  GLOC.ICONPOSX,');
      Q.SQL.Add('  GLOC.ICONPOSY, GLOC.PRINTER');

      Q.SQL.Add('FROM WSSCREEN, GLOC WHERE WSSCREEN.CCODE=:CCODE AND WS=:STATION');

      Q.SQL.Add('AND WSSCREEN.SCREENNO=:SCREEN AND WSSCREEN.CCODEGLOC=GLOC.CCODE AND WSSCREEN.GLOCID=GLOC.GLOCID');
      Q.ParamByName('CCODE').AsInteger:=GlobalCompany;
      Q.ParamByName('STATION').AsInteger:=GlobalStation;
      Q.ParamByName('SCREEN').AsInteger:=ScreenNumber;

      Q.Open;
      if not Q.Eof then
      begin
        GlocId:=Q.FieldByName('GLOCID').AsInteger;
        Company:=Q.FieldByName('CCODEGLOC').AsInteger;
        LocalPrinter := Q.FieldByName('PRINTER').AsString;
        pColour.ParentBackground := false;
        pColour.Color:=Q.FieldByName('COLOR').AsInteger;
        if GlobalDespatchOptions.HideUserId then eUserId.PasswordChar:='*';
        SortOrder:=TSortOrder2(Q.FieldByName('SORTORDER2').AsInteger);
        ReadOnly:=Q.FieldByName('READONLY').AsString='Y';
        Container.AllArticles := Q.FieldByName('ALLART').AsString = 'Y';

        case SortOrder of
          SORT2_CUSTNO: aSortCustno.Checked:=true;
          SORT2_POS: aSortPosition.Checked:=true;
          SORT2_LOGADD: aSortLogAdd.Checked:=true;
          SORT2_PRODUCED: aSortProducedDt.Checked:=true;
          SORT2_ARTNO: aSortArtno.Checked := true;
          SORT2_NAME: aSortArtName.Checked := true;
        end;

        tmp := Q.SQL.Text;

        fStackDespatchOrder:=StackDespOrder(TDespatchMethod(Q.FieldByName('STACKDESPORDER').AsInteger));
        try
          ConfirmAmount := StrToIntDef(Q.FieldByName('confirmamount').AsString,0);
        except
          ConfirmAmount := 0;
        end;
        UseUIDConfirm := Q.FieldByName('useuidconfirm').AsString = 'Y';
      end;
      Q.Close;
    finally
      FreeAndNil( Q);
    end;
  end;
  DrawGrid1.Options:=DrawGrid1.Options-[goRowSelect];
end;

procedure TfInterCompReceiveEnter.GetSelectableColumnCode(var ColList : TStringList);
begin
  if ColList <> nil then
  begin
    ColList.Add(IntToStr(IC_COLUMN_ARRIVED));
    ColList.Add(IntToStr(IC_COLUMN_DAMAGE));
  end;
end;

procedure TfInterCompReceiveEnter.ExecuteModificationState;
var
  List  : TList;
  Tmp   : TSNode;
  i     : integer;
begin
  Tmp := nil;

  case (ModificationState) of
    msReset:
      begin
        if Container <> nil then
        begin
          if DrawGrid1.Row = 1 then
          begin
            List := Container.Nodes;
            for i := 0  to (List.Count-1) do
            begin
              Tmp := List.Items[(DrawGrid1.Row - 1) + i];
              if Tmp<>nil then
              begin
                Tmp.ToDeliver := 0;
                DrawGrid1.Refresh;
              end;
            end;
          end else exit;
          DrawGrid1.Row := 1;
        end;
      end;
    msRestore:
      begin
         if Container<>nil then
         begin
           List := Container.Nodes;
           // Check if on correct record
           if (List.Count > 0) and (DrawGrid1.Row <= (List.Count + 1))
                and (DrawGrid1.Row >= 1)
           then Tmp := List.Items[DrawGrid1.Row - 1];

           Tmp.ToDeliver := Tmp.ToDeliverBackup;

           DrawGrid1.Refresh;
           // refresh data on displays
           if (DrawGrid1.Row > (List.Count-1)) then
           DrawGrid1.Row := 1 else
           NextRow;
         end;
      end;
    msKeep:
      begin
         if Container<>nil then
         begin
           List := Container.Nodes;
           DrawGrid1.Refresh;
           if (DrawGrid1.Row > (List.Count-1)) then
           DrawGrid1.Row := 1 else
           NextRow;
         end;
      end;
  end;
end;

procedure TfInterCompReceiveEnter.FormCreate(Sender: TObject);
begin
  inherited;
  MaintenanceName := 'Intracompany Enter Despatch';
  tmrCheckScans.Enabled := false;
  tmrCheckScans.Interval := 100;
  lCustGroupFilter := TList.Create;
  lSystemCustGroupFilter := TList.Create;
end;

procedure TfInterCompReceiveEnter.FormDestroy(Sender: TObject);
begin
  inherited;
  if (Assigned(lCustGroupFilter)) then
  begin
    FreeList(lCustGroupFilter);
    FreeAndNil( lCustGroupFilter);
  end;
  if (Assigned(lSystemCustGroupFilter)) then
  begin
    FreeList(lSystemCustGroupFilter);
    FreeAndNil( lSystemCustGroupFilter);
  end;
end;

function TfInterCompReceiveEnter.CreateSSCC:string;
var sscc:string;
begin
  sscc:=inttostr(fDM.GetSSCC);
  if length(sscc) > globalprintoptions.SSCCVarlength
  then sscc := copy(sscc,(length(sscc)-globalprintoptions.SSCCVarlength),length(sscc))
  else sscc := stringofchar('0',globalprintoptions.ssccVarLength - length(sscc)) + sscc;
  sscc:= globalprintoptions.SSSCCPrefix+sscc;
  result:=sscc;
end;

function TfInterCompReceiveEnter.CustGroupFilter(cwa: rCustwaveart; Cust: rCust): boolean;
var i,j:integer;
    Selected:boolean;
    pInt:pinteger;
    pInt2:pinteger;
    found:boolean;
begin
  Selected := false;
  found := false;

  for i := 0 to lCustGroupFilter.Count - 1 do
  begin
    pInt := lCustGroupFilter.Items[i];
    for j := 0 to Cust.Groups.Count - 1 do
    begin
      pInt2 := Cust.Groups.Items[j];
      if (pInt2^ = pInt^) then
      begin
        found := true;
        break;
      end;
    end;
    if found then
    begin
      Selected := true;
      break;
    end;
  end;

  Result := Selected;
end;

// Retrieve a new label ID
function TfInterCompReceiveEnter.CreateLabelID:string;
var Q:TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  Q.ConnectionName := fDM.dB.ConnectionName;
  Q.SQL.Text := 'SELECT GENERATORLABELID.NextVal as labelid from dual';
  Q.Open;
  result := Q.FieldByName('labelid').AsString;
  Q.Close;
  Q.Free;
end;

procedure TfInterCompReceiveEnter.CreateList(art: rArt; Selected_Needed: integer);
var i        : integer;
    Tmp      : TDispNode;
    TmpO     : TDispNode;
    pArticle : rArt;
    sh       : TShipdate;
begin
  maContainer:=TSNodeContainer.Create;
  maContainer.twoColorMixed := false;
  maContainer.Warehouse := 1;
  maContainer.printASNorPO := false;
  sh := TShipdate.Create(fDM.dB);
  maContainer.State := sh.GetState(Company, Shipdate);
  sh.Free;

  maContainer.StackDespatch := true;
  maContainer.supportRouting := Container.SupportRouting;
  maContainer.Cancel := false;
  maContainer.Parent := self;
  maContainer.MethodUnits:=GlobalDespatchOptions.UseDelUnit;
  maContainer.DespRestFirst := false; //WalkDespNFFirst;
  maContainer.ArtNo:=art.Artno;
  maContainer.Description:=art.Description;
  maContainer.PcsPerBasket:=art.DefaPcsPerBasket;
  maContainer.DelUnit:=art.DelUnit;
  maContainer.TotalNeeded := Selected_Needed;

  maContainer.ScrType:=SCRTYPE_PDCOUNT;
  maContainer.Method:=Container.Method;
  maContainer.GlocId:=GLocId;
  maContainer.TransType:=TRANS_PREDESPATCH;
  maContainer.AllArticles := Container.AllArticles;
  maContainer.PDCountRoundUp := Container.PDCountRoundUp;
  pArticle:=art;

  if pArticle<>nil then
  begin
    maContainer.stacktype := pArticle.StackType;
    if pArticle.StackHeight=0 then maContainer.StackHeight := GlobalDespatchOptions.StackHeight
    else maContainer.StackHeight := pArticle.StackHeight;
    if particle.MinStackSize=0 then maContainer.MinStackSize := GlobalDespatchOptions.MinStackSize
    else maContainer.MinstackSize := pArticle.Minstacksize;
    maContainer.PcsPerBasket:=pArticle.DEFAPCSPERBASKET;
    maContainer.DelUnit:=pArticle.DelUnit;
    maContainer.Description:=pArticle.Description;
  end;
  maContainer.Company:=Company;
  maContainer.Color:=Target;
end;


procedure TfInterCompReceiveEnter.aPrintLabelExecute(Sender: TObject);
var
  AContainer : TSNodeContainer;
  tmp : TSNode;
  List : TList;
  qArt : TFDQuery;
  barcode, sscc, fname, labelid : string;
  visibility : integer;
  f: textfile;
  Art:rArt;
begin
  inherited;
  List := Container.Nodes;
  Tmp := List.Items[(DrawGrid1.Row - 1)];
  if Tmp<>nil then
  begin
    AContainer:=TSNodeContainer.Create;
    if AContainer<>nil then
    begin
      Acontainer.EnteredAmount := Container.EnteredAmount;
      AContainer.supportRouting := Container.supportRouting;
      AContainer.Shipdate:= Container.Shipdate;
      AContainer.Company:=Company;
      AContainer.Starttime:=Now;
      AContainer.TransType:=TRANS_ICOMPREC;
      AContainer.Phase := PHASE_LABEL;
      AContainer.Crates := Container.Crates;
      AContainer.ArtNo:=Tmp.ArtNo;
      AContainer.Description := Tmp.Name;
      AContainer.GlocId:=GLocId;
      AContainer.ScrType:=ScrType;
      AContainer.AltDesc := tmp.Lot;
      AContainer.AsnOrPO := container.AsnOrPO;
      ACOntainer.printASNorPO := container.printASNorPO;
      AContainer.PDCountRoundUp := Container.PDCountRoundUp;

      qArt := TFDQuery.Create(nil);
      qArt.ConnectionName := fdm.dB.ConnectionName;
      qArt.SQL.Add('select * from mart where artno = :artno');
      qArt.ParamByName('artno').AsString := tmp.ArtNo;
      qArt.Open;

      if not qArt.Eof then
      begin
        barcode := qArt.FieldByName('barcode').AsString;
        Art := fDespLIst.FindArticle(tmp.ArtNo);
        if Art <> nil then
        begin
          AContainer.PcsPerBasket := Art.DEFAPCSPERBASKET;
          AContainer.StackType := Art.StackType;
        end else
          AContainer.PcsPerBasket := qArt.FieldByName('defapcsperbasket').AsInteger;
      end else
      begin
        AContainer.Description := '';
        AContainer.PcsPerBasket := 1;
      end; //if not qArt.Eof) then

      qArt.Close;
      if GlobalDespatchOptions.UseLot then
      begin
        qArt.SQL.Clear;
        qArt.SQL.Add('select * from GLOC_ATP_RES_LOT where lot = :lot and artno = :artno');
        qArt.ParamByName('lot').AsString := tmp.Lot;
        qArt.ParamByName('artno').AsString:= tmp.ArtNo;
        qArt.Open;

        if not qArt.Eof then
        begin
          sscc := qArt.fieldByname('sscc').AsString;
        end; // if not qArt.Eof then
        if sscc = '' then sscc := createsscc;
        AContainer.GroupNum := sscc;
        qArt.Close;
      end;

      if Tmp.PcsPerBasket > 0 then AContainer.PcsPerBasket:= Tmp.PcsPerBasket
      else AContainer.PcsPerBasket := 1;
      AContainer.DelUnit:=1;
      AContainer.Method:=METHOD_WALK;
    end;
    labelid := createLabelID;
    fName:= globalprintoptions.IntrCompLabelPath + labelid +'.prn';
    Assignfile(f,fname);
    Rewrite(f);
    WriteLN(f,Format('P%9s  %32s %16s                  %4d',[
                  tmp.artno,             // 1,9
                  tmp.Name,       // 13,32
                  barcode,           // 46,16
                  Acontainer.pcsPerBasket  // 80,4
                  ]));

    qArt.SQL.Clear;
    qArt.SQL.Add('select * from mcust where custno = (select  max(custno) from mcust)');
    qArt.Open;

    WriteLN(f,Format('C%8s   %30s',[
          qArt.FieldByName('Custno').asstring,     //   1  8
          qArt.FieldByName('custname').asstring   //   9 30
          ]));
    qArt.Close;
    WriteLN(f,Format('O%9s  %32s %16s %4d %5d %20s',[
                  tmp.artno,             // 1,9
                  barcode,
                  tmp.lot,       // 13,32
                  Acontainer.pcsPerBasket,  // 80,4
                  tmp.Ordered,
                  sscc
                  ])) ;

    //send repo command
    CloseFile(f);
    if GlobalPrintOptions.ShowDosWin then Visibility := SW_SHOW
                                     else Visibility := SW_HIDE;
    if GlobalPrintOptions.IntrCompLabelBatch <> '' then
    begin
      winExecandWait32(GlobalPrintOptions.IntrCompLabelBatch+' '+fName,visibility,TRUE);
    end;
    freeandnil(qart);
    AContainer.Free;
  end;
end;

procedure TfInterCompReceiveEnter.DetermineRows;
var List:TList;
begin
  inherited;
  List:=Container.Nodes;
  Drawgrid1.RowCount:=List.Count+1;
  if DrawGrid1.RowCount<2 then DrawGrid1.RowCount:=2;
end;

procedure TfInterCompReceiveEnter.aAdjustReclacExecute(Sender: TObject);
begin
//do nothing!!! Else we get an access violation!
//  inherited;
  ;
end;

function TfInterCompReceiveEnter.GetColumnValue(ARow, ACol: integer;
  Columns: TDespColList; var ARight: boolean; var isNewStack : boolean;
  var isAlternative : boolean; var isMixedStack : boolean; var isLastStack : boolean;
  var isInCustomerGroup:boolean): string;
var
  Tmp : TSNode;
  cTmp: TDespCol;
  oddCrates, maxInStack,
  pcsPerBasket, stheight: integer;
  tmpArt : TArtPPB;
  art: rArt;
  fullStack : boolean;
begin
  if Columns.Count=0 then exit;

  ARight:=false;
  if ARow = 0 then
  begin // Paint header
    cTmp:=Columns.Items[ACol];
    Result := cTmp.Caption;
  end else
  begin
    if (ARow<=Container.Nodes.Count) and (ARow>0) then
    begin
      cTmp:=Columns.Items[ACol];
      Tmp:=Container.Nodes.Items[ARow-1];
      if Tmp<>nil then
      begin

        // Set article attributes
        tmpArt := ICController.GetItemAttributes(Tmp.ArtNo, ScreenNumber);
        if not tmp.isNewStack and Assigned(tmpArt) then
        begin
          tmp.StackType := tmpArt.StackType;
          tmp.StackHeight := tmpArt.StackHeight;
          tmp.PcsPerBasket := tmpArt.UnitsPerTray;
        end;

        isNewStack := Tmp.isNewStack;
        isAlternative := (Length(tmp.AltArtno) > 0);
        isMixedStack := Tmp.isMixedStack;
        isInCustomerGroup := Tmp.isIncustomerGroup;

        isLastStack := ICController.IsEditableStack(LowerCase(tmp.LPN), ScreenNumber);

        if (isAlternative) then
        begin
          pcsPerBasket := Tmp.AltPPB;
          stheight := Tmp.AltStackHeight;
        end else
        begin
          pcsPerBasket := Tmp.PcsPerBasket;
          stheight := Tmp.StackHeight;
        end;

        Result:='';
        case cTmp.Item of
          IC_COLUMN_CCODE       : Result := Tmp.User1;
          IC_COLUMN_SHIPMENTID  : Result := Tmp.ShipmentId;
          IC_COLUMN_STACKID     : begin
                                    art := fDespList.FindArticle(tmp.ArtNo);
                                    fullStack := tmp.toDeliver = (art.StackHeight * art.DefaPcsPerBasket);
                                    if (Tmp.LPN <> '-1') and (Tmp.orgLPN <> '-1') and (Tmp.orgLPN <> EmptyStr) and (Tmp.LPN <> Tmp.orgLPN) and fullStack then
                                      Result := Tmp.orgLPN
                                    else
                                      Result := Tmp.LPN;
                                  end;
          IC_COLUMN_ORGSTACKID  : Result := Tmp.orgLPN;
          IC_COLUMN_ARTNO       : begin
                                    Result:=Tmp.ARTNO;
                                    ARight:=GlobalDespatchOptions.AlignRight2;
                                  end;
          IC_COLUMN_DESCRIPTION : Result := Tmp.Name;
          IC_COLUMN_EXPECTED    : begin
                                    Result := Container.GetDisplayString(Tmp.Ordered, pcsPerBasket);
                                  end;
          IC_COLUMN_ARRIVED     : begin
                                    Result := Container.GetDisplayString(Tmp.ToDeliver, pcsPerBasket);
                                  end;
          IC_COLUMN_ADJUST      : begin
                                    Result := Container.GetDisplayString(Tmp.ToDeliver - Tmp.Ordered, pcsPerBasket);
                                  end;
          IC_COLUMN_LEGACY      : Result := Tmp.LegacyNumber;
          IC_COLUMN_REASON      : Result := Tmp.Reason;
          IC_COLUMN_DAMAGE      : begin
                                    Result := Container.GetDisplayString(Tmp.Damage, pcsPerBasket);
                                  end;
          IC_COLUMN_AVAILABLE   : begin
                                    Result := Container.GetDisplayString(Tmp.ToDeliver - Tmp.Damage, pcsPerBasket);
                                  end;
          IC_COLUMN_ODDCRATES   : begin
                                    maxInStack := pcsPerBasket * stheight;

                                    if (maxInStack < 1) then
                                    begin
                                      maxInStack := 1;
                                    end;

                                    oddCrates := Tmp.Ordered mod maxInStack;
                                    Result := Container.GetDisplayString(oddCrates, pcsPerBasket);
                                  end;
          IC_COLUMN_ALTARTNO    : begin
                                    Result := Tmp.AltArtno;
                                    ARight := GlobalDespatchOptions.AlignRight2;
                                  end;

          IC_COLUMN_ALTDESCRIPTION : begin
                                       Result := Tmp.AltDescription;
                                     end;

          IC_COLUMN_DESTINATION : begin
                                    Result := tmp.DestinationName;
                                  end;

          IC_COLUMN_DAILY_VOLUME: begin
                                    art := fDespList.FindArticle(tmp.ArtNo);
                                    if (art <> nil) then Result := art.volumePerDay
                                    else Result := '';
                                  end;
          IC_COLUMN_JULIANDATE : begin
                                    Result := Tmp.JulianDate;
                                  end;

        end;
        Result := SuppressZero(Result);
      end;
    end;
  end;
end;

procedure TfInterCompReceiveEnter.eSearchChange(Sender: TObject);
var
  search : string;
begin
  inherited;
  search := Trim(eSearch.Text);
  if Length(search) > 0 then
    FindLike(search);
end;

procedure TfInterCompReceiveEnter.eSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //
end;

function TfInterCompReceiveEnter.FindProduct(artno : string) : integer;
var
  index : integer;
  current : TSNode;
begin
  Result := -1;
  index := 0;
  while (index < Container.Nodes.Count) do
  begin
    current := Container.Nodes[index];
    if (current.ArtNo = artno) and not (current.isNewStack) and (current.ordered > 0) then
    begin
      Result := index;
      break;
    end;
    inc(index);
  end;
end;

// Find article on artno or article description
function TfInterCompReceiveEnter.FindLike(searchString : string; searchArticle : boolean) : integer;
var
  index : integer;
  found : boolean;
  current : TSNode;
begin
  index := -1;
  result := -1;

  if NOT Assigned(Container.Nodes) then
    Exit;

  try
    index := 0;
    found := false;
    // Search the node list for artnos or description that meets the search string
    while (index < Container.Nodes.Count) and (NOT found) do
    begin
      current := Container.Nodes[index];

      if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes and not searchArticle then
      begin
        if ((Pos( UpperCase(searchString), UpperCase(current.LPN)) = 1) and
           (current.Ordered > 0))
        then
          found := true
        else
        begin
          if (Pos( UpperCase(searchString), UpperCase(current.orgLPN)) = 1)
          then  // Stack was already processed, but not flagged for some reason
          begin
            UpdateInboundStacks(current.ShipmentId, current.orgLPN, 'A');
            Break; // no need to look further
          end
          else
            Inc( index);
        end;
      end else
      begin
        if (Pos( UpperCase(searchString), UpperCase(current.artno)) = 1) or
         (Pos( UpperCase(searchString), UpperCase(current.Name)) = 1)  or
         (Pos( UpperCase(searchString), UpperCase(current.LPN)) = 1)
      then
        found := true
      else
        Inc( index);
      end;
    end; // while

    if not found then
    begin
      index := 0;
      while (index < Container.Nodes.Count) and (NOT found) do
      begin
        current := Container.Nodes[index];
        if (Pos( UpperCase(searchString), UpperCase(current.artno)) > 0) or
           (Pos( UpperCase(searchString), UpperCase(current.Name)) > 0)  or
           (Pos( UpperCase(searchString), UpperCase(current.LPN)) > 0)
        then
          found := true
        else
          Inc( index);
      end; // while
    end;
    // Found, now locate the item in the grid
    if found then
    begin
      Drawgrid1.Row := index + 1;
      lastRowIndex := DrawGrid1.Row;
      Drawgrid1.Options := Drawgrid1.Options + [goRowSelect];
    end;
  except
    found := false;
  end;

  if found then
    Result := index
  else
    Result := -1;
end;

// Checks if all records have been processed
function TfInterCompReceiveEnter.CheckAllReceived : boolean;
var
  i : integer;
  done : boolean;
  tmp : TSNode;
begin
  done := true;

  if not Assigned(Container.Nodes) then
  begin
    Result := true;
    exit;
  end;

  i := 0;
  while (i < Container.Nodes.Count) and done do
  begin
    tmp := Container.Nodes[i];
    if Assigned(tmp) then
    begin
      // We are not done if there is no new stack ID and the quantity to receive > 0
      if (not tmp.isNewStack) and (tmp.Ordered > 0) then
        done := false;
    end;
    Inc(i);
  end;
  Result := done;
end;

function TfInterCompReceiveEnter.AllowedToClose(shipment : string): boolean;
var
  res : boolean;
  qSel : TFDQuery;
begin
  res := false;
  qSel := TFDQuery.Create(nil);
  if Assigned(qSel) then
  begin
    try
      qSel.ConnectionName := fDm.dB.ConnectionName;
      qSel.SQL.Clear;
      qSel.SQL.Add('select dmscanning from SHIPMENT');
      qSel.SQL.Add('where shipmentid = :shipmentid');
      qSel.ParamByName('shipmentid').AsString := shipment;
      qSel.Open;
      res := not (Uppercase(Trim(qSel.FieldByName('dmscanning').AsString)) = 'Y');
      qSel.Close;
    finally
      qSel.Free;
    end;
  end;
  Result := res;
end;

procedure TfInterCompReceiveEnter.DoEscape;
begin
  if not AllowedToClose(Container.ShipmentID) then
  begin
    // Ask confirmation to close, Dockmanager is still unloading this shipment
    if (MessageDlg(vGlobalStrings.GetString(GLOBSTR_DMISSCANNING), mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
      Exit;
  end;

  // Update the shipment table to indicate we are receive the current shipment
  fDm.UpdateShipmentReceiveStatus(Container.ShipmentID, GlobalStation, false);

  inherited;
  lastRowIndex := 1;

  if (ClosingScreen) then
  begin
    // clear the customer group filter
    FilterCustGroup := false;
    aFltCustGroup.Checked := false;
    fDESPList.Clear(lCustGroupFilter);
    BuildFilterString(FILTER_CUSTGROUP);
  end;
end;

procedure TfInterCompReceiveEnter.Execute_EnterKey;
var
  transaction: TTransno;
begin
  if FCreatingStack then
    Exit;

  // If we are using a Dockmanager scanner, check the flag in the SHIPMENT table
  // to find out if we are allowed to close
  if GlobalIntercompanyOptions.DockManagerScanning then
  begin
    if not AllowedToClose(Container.ShipmentID) then
    begin
      Showmessage(vGlobalStrings.GetString(GLOBSTR_DMISSCANNING));
      exit;
    end;
  end;

  if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes then
  begin
    if not CheckAllReceived then
    begin
      // Allow the user to despatch the remaining stacks
      if GlobalIntercompanyOptions.AutoPredespatchIntracompany then
      begin

        if Application.MessageBox(
          PChar(vGlobalStrings.GetString(GLOBSTR_PREDESPATCH_REMAINING_SHIPMENT)),
          PChar(vGlobalStrings.GetString(GLOBSTR_QUESTION)),
          MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2 or MB_SETFOREGROUND or MB_TOPMOST) = mrYes then
        begin
          // This will print tags for the entire shipment and confirm it
          if (NOT PredespatchShipment) then
            Exit;
          // Something went wrong (products might have been blocked)
          // Bail out. Don;t call the inherited functionality

          // Done: we need to call the base class' Execute_enterkey()
          // to update the received quantities and set the ARR flag to Y

          inherited;
        end; // if Application.MessageBox = mrYes

      end // if GlobalIntercompanyOptions.AutoPredespatchIntracompany then
      else
      begin
        // Not everything is received yet
        if Application.MessageBox(
          PChar(vGlobalStrings.GetString(GLOBSTR_CONFIRM_CLOSESHIPMENT)),
           PChar(vGlobalStrings.GetString(GLOBSTR_QUESTION)),
           MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2 or MB_SETFOREGROUND or MB_TOPMOST) = mrYes then
        begin
          // Set shipment to booked in
          if not Shipment.SetShipmentReceived(container.ShipmentID, ShipDate) then
            LogError('TfInterCompReceiveEnter.Execute_EnterKey',
              Format('Could not set shipment %s to received.', [container.shipmentID]))
          else
          begin
            // shipment booked in, log the transaction
            fDM.dB.StartTransaction;
            try
              transaction := fDM.NewTransaction;
              if (transaction <> nil) then
              begin
                transaction.EMPLOYEENO := Container.UserId;
                transaction.TTYPE := TRANS_CONFIRM_ASN;
                transaction.SHIPDATE := ShipDate;
                transaction.SCREENNO := ScreenNumber;
                transaction.SHIPMENTID := Container.ShipmentID;
                transaction.Update;
                FreeAndNil(transaction);
              end;
              fDM.dB.Commit;
            except
              fDM.dB.Rollback;
            end;
          end;

          ModalResult := mrOk;
          First := true;
          Container.Cancel := true;
          self.DoEscape;
        end
        else
        begin
          eUserID.Clear;
          eSearch.SetFocus;
          exit;
        end
      end;

    end
    else
    begin
      // Set shipment to booked in
      if not Shipment.SetShipmentReceived(container.ShipmentID, ShipDate) then
        LogError('TfInterCompReceiveEnter.Execute_EnterKey',
          Format('Could not set shipment %s to received.', [container.shipmentID]))
      else
      begin
        // shipment booked in, log the transaction
        fDM.dB.StartTransaction;
        try
          transaction := fDM.NewTransaction;
          if (transaction <> nil) then
          begin
            transaction.EMPLOYEENO := Container.UserId;
            transaction.TTYPE := TRANS_CONFIRM_ASN;
            transaction.SHIPDATE := ShipDate;
            transaction.SCREENNO := ScreenNumber;
            transaction.SHIPMENTID := Container.ShipmentID;
            transaction.Update;
            FreeAndNil(transaction);
          end;
          fDM.dB.Commit;
        except
          fDM.dB.Rollback;
        end;

        ModalResult := mrOk;
        First := true;
        Container.Cancel := true;
        self.DoEscape;
      end; // else if not Shipment.SetShipmentReceived(container.ShipmentID) then

    end;

  end // if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes
  else
  begin
    if GlobalIntercompanyOptions.AutoPredespatchIntracompany then
    begin
      if Application.MessageBox(
        PChar(vGlobalStrings.GetString(GLOBSTR_PREDESPATCH_REMAINING_SHIPMENT)),
        PChar(vGlobalStrings.GetString(GLOBSTR_QUESTION)),
        MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2 or MB_SETFOREGROUND or MB_TOPMOST) = mrYes then
      begin
        // This will print tags for the entire shipment and confirm it
          if (NOT PredespatchShipment) then
            Exit;

          // Something went wrong (products might have been blocked)
          // Bail out. Don;t call the inherited functionality
        // Done: we need to call the base class' Execute_enterkey()
        // to update the received quantities and set the ARR flag to Y
        inherited;
      end;
    end;
  end; // else if GlobalIntercompanyOptions.ReceiveOnMultipleASNtypes

  lastRowIndex := 1;
end;

procedure TfInterCompReceiveEnter.PDDDReadDespatchData(artno: string;
  Container: TSNodeContainer);
var
  i: Integer;
  Selectd: boolean;
  cwa: rCustwaveart;
  DLoc: rDisplayLoc;
  Article: rArt;
  Customer: rCust;
  Tmp: TSNode;
  Nodes: TList;
  GlocId_: Integer;
  Warehouse: Integer;
  Reservationless: boolean;
  GLoc: rGLoc;
  detourGLocid: Integer;
  detourGLoc: rGLoc;
  orgWarehouse: Integer;
  shortlist: THashSublist;
  cwaTmp: rCustwaveart;
  opLocation: TArticleWave;
  opLocCount: Integer;
  locations: TNodeLocations;
begin
  opLocCount := 0;
  Container.Shipdate := Shipdate;
  GLoc := lGloc.Find(Company, self.GLocId);
  if (GLoc = nil) then
    raise Exception.Create
      (Format('TfDespatchSelect.PDDDReadDespatchData(): Could not find Gloc(%d,%d)',
      [Company, GLocId]));
  Container.Warehouse := GLoc.FindWarehouse;

  GlocId_ := 0;
  Nodes := Container.Nodes;
  Article := fDespList.FindArticle(artno);

  if Article = nil then
  begin
    fDespList.ReadProd;
    fDespList.ReadProdGroup;
    fDespList.ReadProdInGroup;
    Article := fDespList.FindArticle(artno);
  end;

  orgWarehouse := Article.WHOUSE;
  if self.Container.AllArticles then
    Warehouse := 0
  else
    Warehouse := Article.WHOUSE;
  cwaTmp := rCustwaveart.Create;
  cwaTmp.artno := artno;
  shortlist := lCustwaveart.HashFindSubList('ART', cwaTmp);
  cwaTmp.Free;
  for i := 0 to shortlist.Count - 1 do
  begin
    cwa := shortlist.Items[i];
    if cwa <> nil then
    begin
      if (cwa.CCode = Company) and (cwa.artno = artno) and
        (cwa.Shipdate = Shipdate) then
      // and not (cwa.CLOSED and GlobalPrintOptions.AutoClose) then
      begin
        Customer := fDespList.FindCustomer(cwa.custno);
        // Find position item
        DLoc := nil;
        opLocation := nil;
        locations := nil;

        try
          if Container.supportRouting then
          begin
            locations := TNodeLocations.Create;
            if (GlobalDespatchOptions.SingleWaveLayout) then
              DLoc := GLoc.FindPositions(cwa.Shipdate, cwa.custno, Warehouse,
                GlocId_, lStreetFilter, locations)
            else
              DLoc := GLoc.FindPositions(cwa.Shipdate, cwa.custno, cwa.Waveno,
                Warehouse, GlocId_, lStreetFilter, locations);
            opLocation := GLoc.FindOpLocations(cwa.Waveno, cwa.artno,
              locations);
            if DLoc <> nil then
              opLocation := nil;
          end
          else
          begin
            if self.Container.AllArticles then
            begin
              if (GlobalDespatchOptions.SingleWaveLayout) then
                DLoc := GLoc.FindPosition(cwa.Shipdate, cwa.custno,
                  orgWarehouse, GlocId_, lStreetFilter)
              else
                DLoc := GLoc.FindPosition(cwa.Shipdate, cwa.custno, cwa.Waveno,
                  orgWarehouse, GlocId_, lStreetFilter);
            end;
            if DLoc = nil then
            begin
              if (GlobalDespatchOptions.SingleWaveLayout) then
                DLoc := GLoc.FindPosition(cwa.Shipdate, cwa.custno, Warehouse,
                  GlocId_, lStreetFilter)
              else
                DLoc := GLoc.FindPosition(cwa.Shipdate, cwa.custno, cwa.Waveno,
                  Warehouse, GlocId_, lStreetFilter);

              if (DLoc = nil) and (Warehouse <> 0) then
              begin
                if (GlobalDespatchOptions.SingleWaveLayout) then
                  DLoc := GLoc.FindPosition(cwa.Shipdate, cwa.custno, 0,
                    GlocId_, lStreetFilter)
                else
                  DLoc := GLoc.FindPosition(cwa.Shipdate, cwa.custno,
                    cwa.Waveno, 0, GlocId_, lStreetFilter);
              end;
            end;

            if (NOT cwa.IsBulk) or (DLoc = nil) then
            begin
              if (DLoc = nil) or GlobalDespatchOptions.PreferOrderpickLocationAtPD
              then
              begin
                opLocation := GLoc.FindOp(cwa.Waveno, cwa.artno);
              end;
            end;
          end;

          if opLocation <> nil then
            GlocId_ := opLocation.GLocId;
          if (DLoc = nil) and (opLocation = nil) and
            ((cwa.CCode <> Company) or not SelectAllCustomers) then
            Continue; // Customer without location is ignored
          if (DLoc <> nil) and (cwa.CCode <> Company) then
            Continue;
          // Test for gloc_to_street selection
          Selectd := true;
          if (DLoc <> nil) and (opLocation = nil) then
            Reservationless := DLoc.IsInReservationLessStreet
          else
            Reservationless := true; // this is a shop or order pick rack
          // Test for street filter
          if FilterStreet and Selectd and
            not Container.supportRouting then
          begin
            // Selectd:=StreetFilter(DLoc);
          end;
          // end;

          if FilterWave and Selectd then
          begin
            Selectd := WaveFilter(cwa);
          end;
          // Test for product group filter
          { TODO -oMV : Is this useful? Product is in prodct group! }
          // Test for customer group filter
          if FilterCustGroup and Selectd then
          begin
            if Customer <> nil then
            begin
              Selectd := CustGroupFilter(cwa, Customer);
            end;
          end;
          if Selectd then
          begin
            Tmp := TSNode.Create(Container);
            if Tmp <> nil then
            begin
              { ORDERED, RESERVED, PREDESPATCHED, SHIPPED'); }
              Tmp.GLocId := GlocId_;
              Tmp.DisplayFail := false;
              Tmp.custno := cwa.custno;
              Tmp.artno := cwa.artno;
              Tmp.Shipdate := cwa.Shipdate;
              Tmp.Wave := cwa.Waveno;
              Tmp.ReservationLessPD := Reservationless;
              Tmp.StackType := Container.StackType;
              Tmp.StackHeight := Container.StackHeight;
              Tmp.User1 := cwa.User1;
              Tmp.User2 := cwa.User2;
              Tmp.User3 := cwa.User3;
              Tmp.User4 := cwa.User4;
              Tmp.User5 := cwa.User5;
              Tmp.Price := cwa.Price;
              Tmp.OrdrNr := cwa.OrdrNr;
              Tmp.Closed := cwa.Closed;

              if (GlobalDespatchOptions.UseOrdernrAsBonnr) then
              begin
                Tmp.BonNr := cwa.OrdrNr;
              end
              else // if (GlobalDespatchOptions.UseOrdernrAsBonnr)
              begin
                Tmp.BonNr := cwa.BonNr;
              end; // if (GlobalDespatchOptions.UseOrdernrAsBonnr)

              if Customer = nil then
              begin
                Tmp.Priority := 9;
                Tmp.PrioMore := 0;
              end
              else
              begin
                Container.usedPriority := Priority;
                case Priority of
                  PRIORITY_1:
                    Tmp.Priority := Customer.PRIO1;
                  PRIORITY_2:
                    Tmp.Priority := Customer.PRIO2;
                  PRIORITY_3:
                    Tmp.Priority := Customer.PRIO3;
                  PRIORITY_DEF:
                    Tmp.Priority := Customer.DEFAPRIO;
                  PRIORITY_TOGGLE:
                    Tmp.Priority := Customer.PRIO1;
                  end;
                  Tmp.PrioMore := Customer.PrioMore;
                  Tmp.PickOrder := Customer.PickOrder;
                  end;

                  Tmp.Ordered := cwa.REQQUANT;
                  Tmp.OrderedLI := cwa.REQQUANTIMPORT;
                  Tmp.OrderAdjustManual := cwa.REQQUANTMANUAL;
                  Tmp.Predespatched := cwa.Predespatched;
                  Tmp.Shipped := cwa.SHIPPINGQUANT;
                  // Tmp.Parked:=cwa.PARKED;
                  Tmp.Route := cwa.Route;
                  Tmp.PDToDeliver := 0;
                  Tmp.todeliver := 0;
                  Tmp.More := 0;

                  Tmp.PcsPerBasket := Article.DefaPcsPerBasket;

                  Tmp.needed :=
                  Tmp.Ordered - Tmp.Predespatched;
                  Tmp.Reserved := cwa.RESQUANT;
                  Tmp.OrgNeeded := Tmp.needed;

                  if Container.supportRouting
                  then
                  begin
                    Tmp.locations.AddCopy(locations, orgWarehouse);
                  end;
                  if not SelectAllCustomers and (DLoc <> nil) and
                    (opLocation = nil) then begin
                  // Position
                  Tmp.Company := DLoc.CCode;
                  Tmp.Warehouse := DLoc.WHOUSE;
                  Tmp.Street := DLoc.StreetNo;
                  Tmp.Row := DLoc.STRROW;
                  Tmp.Pos := DLoc.STRPOS;
                  end else Tmp.Company := cwa.CCode;

                  if (opLocation <> nil) then
                  begin
                    Tmp.Warehouse := 0;
                    Tmp.Street := 0;
                    Tmp.Row := 0;
                    Tmp.Pos := opLocCount;
                    Tmp.isOPNode := true;
                    if not Container.supportRouting then inc(opLocCount);
                  end;
                  if Container.supportRouting then
                  begin
                    Tmp.locations.SetOPLocationsTo(opLocCount);
                    inc(opLocCount);
                  end;

                  if Customer <> nil then begin if GlobalDespatchOptions.ShowDispName
                  then Tmp.Name := Customer.DISPNAME else Tmp.Name :=
                    Customer.CUSTNAME;

                  if (Tmp.Name = '') and (GlobalGeneralOptions.CustomerDisplay)
                    and (GlobalDespatchOptions.ShowDispName) then Tmp.Name :=
                    Customer.CUSTNAME else if (Tmp.Name = '') and
                    (GlobalGeneralOptions.CustomerDisplay) and
                    (GlobalDespatchOptions.ShowDispName = false) then Tmp.Name
                    := Customer.DISPNAME;
                  end else Tmp.Name := '???';
                  if not SelectAllCustomers then begin Tmp.LogDisplay :=
                    DLoc.LogDisplay;
                  end;

                  if (GlobalDespatchOptions.DisablePDToDD)
                  then begin Tmp.DirectDespatchNode :=
                    IsDirectDespatchStreet(DLoc.CCode, DLoc.WHOUSE,
                    DLoc.StreetNo);
                  end;

                  Tmp.selected := true;
                  Nodes.Add(Tmp);
             end;
           end;
         finally
           if Container.supportRouting then locations.Free;
         end;
       end;
     end;
  end;
end;

function TfInterCompReceiveEnter.PredespatchShipment: boolean;
begin
  result := false;
  // Auto predespatch if the setting is on
  if (NOT GlobalIntercompanyOptions.AutoPredespatchIntracompany) then
    Exit;

  //MSO-ASN:
  if (not ICController.PredespatchReceivedProduct(ScreenNumber)) then
  begin
    Exit;
  end;

  result := true;

  fDespList.UpdateCustWaveart;
  fDespList.UpdateMaterialsRequired;

  if Assigned (fDespatchSelect[ScreenNumber]) then
  begin
    fDespatchSelect[ScreenNumber].Status := STATUS_SELECT;
    fDespatchSelect[ScreenNumber].UpdateNeeded := true;
  end;
end;

// Add the customer nodes to the container and set todeliver to 0
procedure TfInterCompReceiveEnter.PDDDReadDespatchData(var AContainer:TSNodeContainer);
var i            : integer;
    Selectd      : boolean;
    cwa          : rCustwaveart;
    altcwaResult : rCustwaveart; // For searching orders of alternative products
    altcwa       : rCustwaveart; // For searching orders of alternative products
    DLoc         : rDisplayLoc;
    Article      : rArt;
    Customer     : rCust;
    Tmp          : TSNode;
    Nodes        : TList;
    GlocId_      : integer;
    Warehouse    : integer;
    Reservationless : boolean;
    GLoc         : rGLoc;
    ATransno     : integer;
    detourGLocid : integer;
    orgWarehouse : integer;
    shortlist    : THashSublist;
    cwaTmp       : rCustwaveart;
    Datum        : TDateTime;
    PrioToggleEvenDay : integer;
    opLocation: TArticleWave;
    opLocCount: integer;
    locations: TNodeLocations;
begin
  opLocCount := 0;
  HighestWaveNumber := 0;
  fDesplist.UpdateCustWaveart;
  fDespList.UpdateMaterialsRequired;

  Datum := utils.ShipdateToDateTime(Shipdate);
  PrioToggleEvenDay := _DayOfTheWeek(Datum) mod 3;

  AContainer.Shipdate := Shipdate;
  GLoc := lGloc.Find(Company, self.Glocid);
  if (Gloc = nil) then
    raise Exception.Create(Format('TfInterCompReceiveEnter.PDDDReadDespatchData(): Could not find Gloc(%d,%d)',[Company, Glocid]));
  AContainer.Warehouse := Gloc.FindWarehouse;
  ATransno := AContainer.TransNo;

  GLocId_ := 0;
  Nodes := AContainer.Nodes;
  Article := fDespList.FindArticle(AContainer.ArtNo);
  orgWarehouse := Article.WHOUSE;
//  if true {or Container.AllArticles} then
    Warehouse := 0;
//  else
//    Warehouse := Article.WHOUSE;
  cwaTmp := rCustwaveart.Create;
  cwaTmp.Artno := AContainer.Artno;
  shortlist := lCustwaveart.HashFindSubList('ART',cwaTmp);
  for i:=0 to shortlist.Count-1 do
  begin
    cwa:=shortlist.Items[i];
    if cwa<>nil then
    begin
      if (cwa.CCode=company) and (cwa.Artno=AContainer.Artno) and (cwa.Shipdate=Shipdate) then //and not (cwa.CLOSED and GlobalPrintOptions.AutoClose) then
      begin
        HighestWaveNumber := Max(HighestWaveNumber, cwa.Waveno);
        Customer := fDespList.FindCustomer(cwa.custno);

        // The list may have changed, so we reread if the search fails
        if Customer = nil then
        begin
          fDespList.ReadCust;
          fDespList.ReadCustGroup;
          fDespList.ReadCustInGroup;
          Customer := fDespList.FindCustomer(cwa.CUSTNO);
        end;

        // Find position item
        DLoc := nil;
        opLocation := nil;
        locations := nil;
        try
          if AContainer.supportRouting then
          begin
            locations := TNodeLocations.Create;
            if (GlobalDespatchOptions.SingleWaveLayout) then
              DLoc := gloc.FindPositions(cwa.Shipdate, cwa.CustNo, Warehouse,
                GlocId_, LStreetFilter, locations)
            else
              gloc.FindPositions(cwa.Shipdate, cwa.CustNo, cwa.waveno,
                Warehouse, GlocId_, LStreetFilter, locations);
            opLocation := gloc.FindOpLocations(cwa.waveno, cwa.Artno,
              locations);
            if DLoc <> nil then
              opLocation := nil;
          end else begin
        if true {Container.AllArticles} then
        begin
          if (GlobalDespatchOptions.SingleWaveLayout) then
            DLoc := Gloc.FindPosition(cwa.Shipdate,cwa.Custno, orgWarehouse, glocid_, (*lStreetfilter*) Gloc.Streets)
            else DLoc := Gloc.FindPosition(cwa.Shipdate,cwa.Custno,cwa.waveno, orgWarehouse, glocid_, (*lStreetfilter*) gloc.Streets);
        end;
        if DLoc=nil then
        begin
          if (GlobalDespatchOptions.SingleWaveLayout) then
            DLoc := Gloc.FindPosition(cwa.Shipdate,cwa.Custno, Warehouse, glocid_, (*lStreetfilter*) Gloc.streets)
          else DLoc := Gloc.FindPosition(cwa.Shipdate,cwa.Custno,cwa.waveno, Warehouse, glocid_, (*lStreetfilter*) Gloc.Streets);

          if (DLoc=nil) and (Warehouse<>0) then
          begin
            if (GlobalDespatchOptions.SingleWaveLayout) then
              DLoc := Gloc.FindPosition(cwa.Shipdate,cwa.Custno, 0, glocid_, (*lStreetfilter*) Gloc.Streets)
            else DLoc := Gloc.FindPosition(cwa.Shipdate,cwa.Custno,cwa.waveno, 0, glocid_, (*lStreetfilter*) Gloc.Streets);
          end;
        end;
            if (NOT cwa.IsBulk) or (DLoc = nil) then
            begin
              if (DLoc = nil) or GlobalDespatchOptions.PreferOrderpickLocationAtPD
              then
              begin
                opLocation := gloc.FindOp(cwa.waveno, cwa.Artno);
              end;
            end;
          end;
          if opLocation <> nil then
          GlocId_ := opLocation.GLocid;

          if (DLoc = nil) and (opLocation = nil) and
            ((cwa.CCode <> Company) or not SelectAllCustomers) then
            Continue; // Customer without location is ignored
        if (DLoc<>nil) and (cwa.ccode<>Company) then continue;
        // Test for gloc_to_street selection
        Selectd := true;
//        Reservationless := DLoc.IsInReservationLessStreet;
          if (DLoc <> nil) and (opLocation = nil) then
            Reservationless := DLoc.IsInReservationLessStreet
          else
            Reservationless := true; // this is a shop or order pick rack
        // Test for customer group filter
        if FilterCustGroup then
        begin
          if (Customer <> nil) then
          begin
            Selectd := CustGroupFilter(cwa, Customer);
          end;
        end;

        if FilterWave and Selectd then
        begin
          Selectd := WaveFilter(cwa);
        end;

        if Selectd and GlobalDespatchOptions.RouteProducts then
        begin
          detourGLocId := lRouteProductList.Match(cwa.Shipdate, cwa.Custno, cwa.Artno);
          Selectd := Selectd and (detourGLocid = 0);
        end;

        if Selectd then
        begin
          Tmp:=TSNode.Create (AContainer);
          if Tmp<>nil then
          begin
            { ORDERED, RESERVED, PREDESPATCHED, SHIPPED');}
            Tmp.GLocId:=GLocid_;
            Tmp.DisplayFail:=false;
            Tmp.CustNo:=cwa.Custno;
            Tmp.ArtNo:=cwa.Artno;
            Tmp.ShipDate:=cwa.Shipdate;
            Tmp.Wave:=cwa.Waveno;
            Tmp.ReservationLessPD := Reservationless;
            Tmp.StackType := Article.StackType;

            // Done -oHK: with alternative despatch, copy the fields if the customer
            // also has an order for the alternative product.
            // If not, do not copy the fields of the original product but reset them.
            if (AContainer.AltArtno <> '') then
            begin
              altcwa := rCustwaveart.Create(cwa);
              altcwa.Artno := AContainer.AltArtno;
              altcwaResult := lCustwaveart.HashFind('PKEY', altcwa);
              altcwa.Free;
              if altcwaResult <> nil then
              begin
                Tmp.User1 := altcwaResult.User1;
                Tmp.User2 := altcwaResult.User2;
                Tmp.User3 := altcwaResult.User3;
                Tmp.User4 := altcwaResult.User4;
                  //MSO, 26-02-2010: Added USER5 field
                  Tmp.User5 := altcwaResult.User5;
                Tmp.Price := altcwaResult.Price;
                Tmp.ordrnr := altcwaResult.ordrnr;
                Tmp.bonnr := altcwaResult.bonnr;
              end else
              begin
                Tmp.User1 := '';
                Tmp.User2 := '';
                Tmp.User3 := '';
                Tmp.User4 := '';
                  //MSO, 26-02-2010: Added USER5 field
                  Tmp.User5 := '';
                Tmp.Price := '';
                Tmp.ordrnr := '';
                Tmp.bonnr := '';
              end;
            end else
            begin
              Tmp.User1:=cwa.User1;
              Tmp.User2:=cwa.User2;
              Tmp.User3:=cwa.User3;
              Tmp.User4:=cwa.User4;
              //MSO, 26-02-2010: Added USER5 field
              Tmp.User5 := cwa.User5;
              Tmp.Price:=cwa.Price;
              Tmp.OrdrNr:=cwa.OrdrNr;
              Tmp.Closed := cwa.Closed;

              if (GlobalDespatchOptions.UseOrdernrAsBonnr) then
                   Tmp.BonNr := cwa.OrdrNr
              else Tmp.BonNr := cwa.bonnr;
            end;
            if Customer=nil then
            begin
              Tmp.Priority:=9;
              Tmp.PrioMore:=0;
            end else begin
              // Copy from the original container
              AContainer.usedPriority := (* Priority*) Container.usedPriority;
              AContainer.usedPrioToggle := PrioToggleEvenDay;
              case AContainer.usedPriority of
                PRIORITY_1   : Tmp.Priority := Customer.PRIO1;
                PRIORITY_2   : Tmp.Priority := Customer.PRIO2;
                PRIORITY_3   : Tmp.Priority := Customer.PRIO3;
                PRIORITY_DEF : Tmp.Priority := Customer.DEFAPRIO;
                PRIORITY_TOGGLE :
                  begin
                    case AContainer.usedPrioToggle of
                      0: Tmp.Priority := Customer.PRIO1;
                      1: Tmp.Priority := Customer.PRIO2;
                      2: Tmp.Priority := Customer.PRIO3;
                    end;
                  end;
              end;
              Tmp.PrioMore := Customer.PRIOMORE;
              Tmp.PickOrder := Customer.PickOrder;
            end;

            Tmp.Ordered:=cwa.REQQUANT;
            Tmp.OrderedLI:=cwa.REQQUANTIMPORT;
            Tmp.OrderAdjustManual:=cwa.REQQUANTMANUAL;
            Tmp.Predespatched:=cwa.PREDESPATCHED;
            Tmp.Shipped:=cwa.SHIPPINGQUANT;
            Tmp.Route:=cwa.ROUTE;
            //Tmp.Needed := Tmp.Ordered - Tmp.Predespatched;
            Tmp.PDToDeliver:=0;
            Tmp.ToDeliver:=0;
            Tmp.More:=0;
            Tmp.Transno:=ATransno;
            Tmp.PcsPerBasket := Article.DEFAPCSPERBASKET;
            Tmp.Needed:=Tmp.Ordered-Tmp.PreDespatched;
            Tmp.Reserved:=cwa.RESQUANT;
            Tmp.OrgNeeded:=Tmp.Needed;
            if AContainer.supportRouting then
            begin
              Tmp.locations.AddCopy(locations, orgWarehouse);
            end;
            // Position
            if not SelectAllCustomers then
            begin
              Tmp.Company:=DLoc.CCODE;
              Tmp.Warehouse:=DLoc.WHOUSE;
              Tmp.Street:=DLoc.STREETNO;
              Tmp.Row:=DLoc.STRROW;
              Tmp.Pos:=DLoc.STRPOS;
            end else Tmp.Company := cwa.CCode;

            if (Customer<>nil) and (DLoc <> nil) and (opLocation = nil) then
            begin
              if GlobalDespatchOptions.ShowDispName then Tmp.Name:=Customer.DISPNAME
              else Tmp.Name:=Customer.CUSTNAME;

              if (Tmp.Name = '') and
                 (GlobalGeneralOptions.CustomerDisplay) and
                 (GlobalDespatchOptions.ShowDispName) then
              Tmp.Name := Customer.CUSTNAME else
              if (Tmp.Name = '') and
                 (GlobalGeneralOptions.CustomerDisplay) and
                 (GlobalDespatchOptions.ShowDispName = false) then
              Tmp.Name := Customer.DISPNAME;
            end else Tmp.Name:='???';

            if (opLocation <> nil) then
            begin
              Tmp.Warehouse := 0;
              Tmp.Street := 0;
              Tmp.Row := 0;
              Tmp.Pos := opLocCount;
              Tmp.isOPNode := true;
              if not AContainer.supportRouting then inc(opLocCount);
            end;
              if AContainer.supportRouting then
              begin
                Tmp.locations.SetOPLocationsTo(opLocCount);
                inc(opLocCount);
              end;
            if not SelectAllCustomers and not(DLoc = nil) then
            begin
              Tmp.LogDisplay:=DLoc.LOGDISPLAY;
            end;

            if (GlobalDespatchOptions.DisablePDToDD) then
            begin
              Tmp.DirectDespatchNode := IsDirectDespatchStreet(DLoc.CCODE, DLoc.WHOUSE, DLoc.STREETNO);
            end;

            Tmp.Selected:=true;
            Nodes.Add(Tmp);
          end;
        end;
        finally
          if AContainer.supportRouting then
            locations.Free;
        end;
      end;
    end;
  end;
  if GlobalDespatchOptions.UseResLessPD (* and GlobalIntercompanyOptions.AutoPredespatchIntracompany done : intentially marked out *) then
  begin
    CorrectForDPStreets(AContainer);
  end;
  //MSO 18-02-2010, Added for PD Kitting
  // Add kitting component products to the container.
  AddComponentProductsToContainer(Article.ARTNO, AContainer);

  cwaTmp.Free;
end;

////////////////////////////////////////////////////////////////////////////////////////////
//    PD functionality
//    The code below was added for PD functionality in the Intracompany screen
///////////////////////////////////////////////////////////////////////////////////////////

type
  TArticles = class
    public
      artno : string;
      amounts : TList;
      procedure Add(ccode, glocid, amount : integer);
      constructor Create;
      destructor Destroy; override;
  end;
  TArticleAmount = class
    public
      quantity : integer;
      ccode: integer;
      glocid:integer;
  end;

procedure TArticles.Add(ccode, glocid, amount : integer);
var a:TArticleAmount;
begin
  a := TArticleAmount.Create;
  a.ccode := ccode;
  a.glocid := glocid;
  a.quantity := amount;
  amounts.Add(a);
end;

constructor TArticles.Create;
begin
  amounts := TList.Create;
end;

destructor TArticles.Destroy;
var i:integer;
begin
  for i := 0 to amounts.Count - 1 do TObject(amounts[i]).Free;
  amounts.Free;
end;

procedure TfInterCompReceiveEnter.CorrectForDPStreets(Container : TSNodeContainer);
var i, j, idxGloc, idxLoc : integer;
    node : TSNode;
    localSent : integer;
    rdp : TRdpController;
    Article : rArt;
    stackHeight : integer;
    DaResult : TRdpGLoc;
    needed : integer;
    giveNow : integer;
    customer : TRdpCustomer;
begin
  rdp := TRdpController.Create(Container.Company, Container.Shipdate, Container.ArtNo, lGLoc, lCustwaveart);
  if Container.AltArtno = '' then Article := fDespList.FindArticle(Container.Artno)
  else Article := fDespList.FindArticle(Container.AltArtno);
  stackHeight := Article.StackHeight;
  if stackHeight = 0 then stackHeight := GlobalDespatchOptions.StackHeight;

  for i := 0 to lgloc.Count - 1 do
  begin
    if (lGLoc[i].CCODE=self.Company) and (lGLoc[i].ReservationLessPD) then
    begin
      localSent := DetermineGoodsSent(lgloc[i].CCode, lgloc[i].GLocId, Container.Artno);
      rdp.AddPredespatchedAmount(lgloc[i],localSent,Article.DefaPcsPerBasket,stackHeight,container.stackDespatchOrder, nil, nil, false, Article, container.Method);
    end;
  end;

  for idxGloc := 0 to rdp.generalLocations.Count -1 do
  begin
    daResult := rdp.generalLocations[idxGloc];
    if (NOT assigned(daResult)) OR (NOT assigned(daResult.List)) then
      Continue;

    for idxLoc := 0 to daResult.Count -1 do
    begin
      if daResult[idxLoc].virtualPD > 0 then
      begin
        for j := 0 to Container.Nodes.Count - 1 do
        begin
          Node := Container.Nodes[j];
          if daResult[idxLoc].IsLoc(node.Company,node.Warehouse,node.Street,node.Row,node.pos) then
          begin
            customer := daResult[idxLoc].Find(node.CustNo,node.wave);
            if (customer <> nil ) then
            begin
              needed := node.Ordered - node.Predespatched;
              giveNow := min(needed, customer.virtualPD);
              node.Predespatched := node.Predespatched + customer.virtualPD; // ritten?
              node.Needed := node.Needed - customer.virtualPD; // ritten?
              customer.virtualPD := customer.virtualPD - giveNow;
              if daResult[idxLoc].virtualPD = 0 then break;
            end;
          end; // if
        end; // for
        if daResult[idxLoc].virtualPD > 0 then Exception.Create(Format('Could not despatch all (%d,%d,%d,%d,%d) left %d',[
                                                                   daResult[idxLoc].ccode, daResult[idxLoc].whouse, daResult[idxLoc].street,
                                                                   daResult[idxLoc].row, daResult[idxLoc].pos,daResult[idxLoc].VirtualPD]));
      end;
    end; // if
  end; // for
end; // procedure

function TfInterCompReceiveEnter.DetermineGoodsSent(ccodeto:integer; glocidto:integer; artno:string):integer;
var Query:TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  Query.ConnectionName := fDM.dB.ConnectionName;
  Query.SQL.Clear;
  Query.SQL.Add('SELECT SUM(QUANTARR) AS QUANTARR');
  Query.SQL.Add('FROM GLOC_ATP_RES');
  Query.SQL.Add('WHERE');
  Query.SQL.Add('ARTNO=:artno AND');             // For the requested article
  Query.SQL.Add('CCODETO=:ccodeto AND');         // To the street
  Query.SQL.Add('GLOCIDTO=:glocidto AND');
  Query.SQL.Add('STORNO=''N'' AND');             // Not canceled
  Query.SQL.Add('CWSHIPDATE=:shipdate AND');     // for the correct shipping date
  Query.SQL.Add('ARR=''N''');                    // not arrived (ie not end despatched)
  Query.SQL.Add('GROUP BY ARTNO');
  Query.ParamByName('ccodeto').AsInteger := ccodeto;
  Query.ParamByName('glocidto').AsInteger := glocidto;
  Query.ParamByName('artno').AsString := artno;
  Query.ParamByName('shipdate').AsString := Shipdate;
  Query.Open;
  if not Query.Eof then Result := Query.fieldByName('QUANTARR').AsInteger
  else Result := 0;
  Query.Close;
  FreeAndNil(Query);
end;

procedure TfInterCompReceiveEnter.aCreateStackExecute(Sender: TObject);
var
  index: integer;
begin
  if FCreatingStack then
    Exit;
  FCreatingStack := True;
  try
    inherited;
    if (ReadOnly) then
    begin
      if not disableInboundScanMessages then
        ShowMessage('Can''t create stacks on a read-only screen');
      Exit;
    end;

    if not OneAndOnlyOneWave and (HighestWaveNumber>1) then
    begin
      ShowMessage(vGlobalStrings.GetString(GLOBSTR_MSG_MUST_SELECT_WAVE){ 'You must select one wave (wave-filter)'});
      exit;
    end;

    index := DrawGrid1.Row;

    Container.enableIMPrint := actEnableIMPrint.Checked;
    ICController.CreateStack((DrawGrid1.Row - 1), ScreenNumber);

    DrawGrid1.RowCount := Container.Nodes.Count + 1;
    DrawGrid1.Row := index;
    lastRowIndex := index;
    DrawGrid1.Refresh;
  finally
    FCreatingStack := False;
  end;
end;

procedure TfInterCompReceiveEnter.actEnableIMPrintExecute(Sender: TObject);
begin
  inherited;
  ;
end;

procedure TfInterCompReceiveEnter.aDummyExec(Sender: TObject);
begin
  inherited;
  // Just to make sure the menuitem is enabled
end;

procedure TfInterCompReceiveEnter.DespOrderChanged(Sender: TObject);
begin
  inherited;
  TAction(Sender).Checked := true;
  fStackDespatchOrder := StackDespOrder(TAction(Sender).Tag);
  if Assigned(Container) then
    Container.StackDespatchOrder := fStackDespatchOrder;
end;

procedure TfInterCompReceiveEnter.aSelectStockDestExecute(Sender: TObject);
var transaction: TTransno;
begin
  inherited;

  //MSO-ASN:
  ICController.AskStockLocation(ScreenNumber);

  fDM.dB.StartTransaction;
  try
    transaction := fDM.NewTransaction;
    if (transaction <> nil) then
    begin
      transaction.EMPLOYEENO := -1;
      transaction.TTYPE := TRANS_SELECT_STOCK;
      transaction.SHIPDATE := ShipDate;
      transaction.SCREENNO := ScreenNumber;
      transaction.Update;
      FreeAndNil(transaction);
    end;
    fDM.dB.Commit;
  except
    fDM.dB.Rollback;
  end;
end;

procedure TfInterCompReceiveEnter.aShortAmountExecute(Sender: TObject);
var
  node: TSNode;
  needed: integer;
begin
  inherited;
  node := Container.Nodes[DrawGrid1.Row-1];
  needed := CalculateNeeded(node);
  ShortageAmount(false, node.Artno, needed);
  CalculateStackDest(node);
end;

procedure TfInterCompReceiveEnter.BuildFilterString(fType: TDespFilter);
var
  sFlt, sTmp : string;
  i, max : integer;
  pInt : pinteger;
  Str : rStreet;
  star : string;
begin
  // Despatch filters
  case fType of
    FILTER_CUSTGROUP :
      begin
        sFlt := vGlobalStrings.GetString(GLOBSTR_FILTER_CUSTOMERGROUP); // + ': ';
        if lCustGroupFilter.Count > 10 then max := 10 else max := lCustGroupFilter.Count-1;
        for i := 0 to max do
        begin
          if lCustGroupFilter.Items[i] <> nil then
          begin
            pInt := lCustGroupFilter.Items[i];
            sTmp := Format( '%d ', [pInt^]);
            sFlt := sFlt + sTmp;
          end;
        end;
        if max < lCustGroupFilter.Count-1 then sFlt := sFlt + '...';
        lFltCustGroup.Caption := sFlt;
      end;
    FILTER_WAVE :
      begin
        sFlt := vGlobalStrings.GetString(GLOBSTR_FILTER_WAVE); //FixedStrings[fDespatchSelect_FltWave] + ': ';
        if lWaveFilter.Count > 10 then max := 10 else max := lWaveFilter.Count-1;
        for i := 0 to max do
        begin
          if lWaveFilter.Items[i] <> nil then
          begin
            pInt := lWaveFilter.Items[i];
            // TODO: If system filter will be used then some change is needed here
            //if UseSystemFilters and InIntegerFilter(lSystemWaveFilter, pInt^) then star:='*'
            //else star := '';
            sTmp := Format( '%d%s ', [pInt^, ''{star}]);
            sFlt := sFlt + sTmp;
          end;
        end;
        if max < lWaveFilter.Count-1 then sFlt := sFlt + '...';
        lFltWave.Caption := sFlt;
      end;
    FILTER_STREET:
      begin
        sFlt := vGlobalStrings.GetString(GLOBSTR_FILTER_STREET); // + ': ';
        if lStreetFilter.Count > 3 then max := 3 else max := lStreetFilter.Count-1;
        for i := 0 to max do
        begin
          if lStreetFilter.Items[i] <> nil then
          begin
            Str := lStreetFilter.Items[i];
            if UseSystemFilters and InStreetFilter(lSystemStreetFilter, Str) then star := '*'
            else star := '';
            if GlobalGeneralOptions.CCODESTRFLT then
            sTmp := Format( '|%d %d %d|%s ', [Str.CCode, Str.WHOUSE, Str.STREETNO, star]) else
            sTmp := Format( '|%d %d|%s ', [Str.WHOUSE, Str.STREETNO, star]);
            sFlt := sFlt + sTmp;
          end;
        end;
        if max < lStreetFilter.Count-1 then sFlt := sFlt + '...';
        lFltStreet.Caption := sFlt;
      end;
  end;

  // Enable the labels
  lFltCustGroup.Enabled := aFltCustGroup.Checked;
end;

//MSO 17-02-2010, Added for PD Kitting
procedure TfInterCompReceiveEnter.AddComponentProductsToContainer(AArtno: string;
  AContainer: TSNodeContainer);
var
  i: integer;
  currMaterial: rMaterialRequired;
  newNode: TSNode;
  gloc, orgGLoc, desGLoc : rGLoc;
  isAllArts: boolean;
  Article: rArt;
  inWarehouse: boolean;
  inAllowedGlocs: boolean;

  function GetCustno : string;
  var c : rCust;
      ii : integer;
      jj : integer;
      nn : TsNode;
      ff : boolean;
  begin
    for ii := 0 to lCust.Count - 1 do
    begin
      c := lCust[ii];
      ff := false;
      for jj := 0 to Container.Nodes.Count - 1 do
      begin
        nn := Container.Nodes[jj];
        if nn.Custno=c.custno then
        begin
          ff := true;
          break;
        end;
      end;
      if not ff then
      begin
        result := c.custno;
        break;
      end;
    end;
  end;

begin
  gloc := lGloc.Find(Company, glocid);

  for i := 0 to lMaterialsRequired.Count - 1 do
  begin
    currMaterial := lMaterialsRequired[i];
    orgGLoc := lGLoc.Find(Company, currMaterial.GLocid);
    desGLoc := lGLoc.Find(Company, currMaterial.GLocidTo);
    if (lRouteProductList.Match(shipdate, currMaterial.ComponentArtno) = 0) and (desGLoc.GLTYPE <> GLOCTYPE_PRODUCTION) then continue; // If route is disabled continue

    inAllowedGlocs := ((orgGLoc.GLTYPE = gloc.GLTYPE) or (gloc.GLTYPE = GLOCTYPE_ICOMP_REC_LOADMANAGER)) and
                      ((orgGloc.GLTYPE <> GLOCTYPE_PRODUCTION) or (gloc.SubType = GLOC_SUBTYPE_ADJUSTSCHEDULE));
    isAllArts := Container.AllArticles and inAllowedGlocs;

    Article := fDESPList.FindArticle(currMaterial.ComponentArtno);

    if (Article = nil) then
    begin
      fDespList.ReadProd;
      Article := fDESPList.FindArticle(currMaterial.ComponentArtno);

      if (Article = nil) then
      begin
        //error !!
        Exit;
      end; //if (Article = nil)
    end; //if (Article = nil)

    inWarehouse := isAllArts or (Article.WHOUSE = gloc.FindWarehouse);

    (* IMPORTANT NOTE: When editing the conditions of this IF statement, be aware
     * that this also needs to be changed in the following other units/functions:
     * Unit DESPSELECTPD, TfDespatchSelectPD.AddComponentProductsToDespatchList
     * Unit BaseSelect, TfDespatchSelect.AddComponentProductsToContainer
     * Unit Container, TSNodeContainer.UpdateAmountsFromDespList
     * Unit IntercompReceiveEnter, TfInterCompReceiveEnter.AddComponentProductsToContainer
     *)
    if ((inAllowedGlocs) or (isAllArts)) and
       (currMaterial.Shipdate = ShipDate) and
       (currMaterial.ComponentArtno = AArtno) and
       (currMaterial.MaterialType = 1) and
       (inWarehouse) then
    begin
      newNode := TSNode.Create(AContainer);
      if (newNode <> nil) then
      begin
        { TODO 1 -oMSO -cKitting : Check all the values with comments for correct values }
        newNode.DisplayFail := false;
        newNode.CustNo := GetCustno; // rCust(lCust[0]).CUSTNO; //Get the first customer so it isn't 0
        newNode.Artno := currMaterial.ComponentArtno;
        newNode.ShipDate := currMaterial.Shipdate;
        newNode.Wave := 1; //is this correct?
        newNode.ReservationLessPD := true;

        newNode.Closed := false;
        newNode.Priority := 9;
        newNode.PrioMore := 0;

        newNode.Ordered := currMaterial.Quantity;
        newNode.OrderedLI := currMaterial.Quantity;
        newNode.Predespatched := currMaterial.QuantityArrived;

        newNode.Needed := newNode.Ordered - newNode.Predespatched;
        newNode.OrgNeeded := newNode.Needed;

        newNode.PcsPerBasket := Container.PcsPerBasket;
        newNode.Company := Company;
        //newNode.GLocId := glocid;
        newNode.Name := '???';
        newNode.Selected := true;

        //Set the values required for a Component Product Node
        newNode.IsComponentProductNode := true;
        newNode.SegmentId := currMaterial.SegmentId;
        //newNode.GlocId := currMaterial.GlocId;
        newNode.Company {CcodeTo} := Company; // production only in the same company
        newNode.GlocId := currMaterial.GlocIdTo;
        newNode.GoodMovement := true;
        AContainer.ContainsComponentProducts := true;

        AContainer.Nodes.Add(newNode);
      end; //if (newNode <> nil)
    end; //if (IsMaterialDespatchable(currMaterial)) and ...
  end; //for i := 0 to lMaterialsRequired.Count - 1
end;

//MSO 17-02-2010, Added for PD Kitting
function TfInterCompReceiveEnter.InIntegerFilter(const list: TList; value: integer): boolean;
var i : integer;
    pi : ^Integer;
begin
  Result := false;
  for i := 0 to list.count - 1 do
  begin
    pi := list[i];
    if pi^ = value then
    begin
      Result := true;
      break;
    end;
  end;
end;

function TfInterCompReceiveEnter.InStreetFilter(const list: TList;
  const Street: rStreet): boolean;
var i : integer;
    tmp : rStreet;
begin
  Result := false;
  for i := 0 to list.count - 1 do
  begin
    tmp := list[i];
    if tmp.Compare(Street) then
    begin
      Result := true;
      break;
    end;
  end;
end;

function TfInterCompReceiveEnter.IsMaterialDespatchable(
  AMaterial: rMaterialRequired): boolean;
var
  i: integer;
  isFound: boolean;
  Gloc: rGloc;
begin
  GLoc := lGLoc.Find(Company, GLocid);
  i := 0;
  isFound := false;

  while (i < Gloc.Children.Count) and (not isFound) do
  begin
    begin
      if (GLoc.Children[i].destination.CCODE = AMaterial.CompanyCode) and
         ((GLoc.Children[i].destination.GLOCID = AMaterial.GlocId) or (Container.AllArticles)) then
      begin
        isFound := true;
      end; //if (currGlocPTP.CCODEFROM = Company) and ...
    end; //if (currGlocPTP <> nil)

    Inc(i);
  end; //while (i < lGlocPTP.Count) and (not isFound)

  Result := isFound;
end;

// Tries to find a product in the shipment nodes, return the index if found or -1 if not.
function TfInterCompReceiveEnter.FindProductInShipment(artno : string) : integer;
var
  i : integer;
  tmpNode : TSNode;
  found : boolean;
  retVal : integer;
begin
  retVal := -1;
  found := false;
  i := 0;
  while (i < Container.Nodes.Count) and (not found) do
  begin
    tmpNode := Container.Nodes[i];
    // Ignore new stacks created
    if (tmpNode.ArtNo = artno) and (not tmpNode.isNewStack) then
    begin
      found := true;
      retVal := i;
    end else
      Inc(i);
  end;
  Result := retVal;
end;

// Retrieves a purchase order number for the shipment/artno combination or
// for the shipment from the asndetail interface table
function TfInterCompReceiveEnter.RetrievePurchaseOrders(shipmentId : string; artno : string;
                                                var foundForProduct : boolean) : TStringList;
var
  qSelect : TFDQuery;
  poNumbers : TStringList;
begin
  poNumbers := TStringList.Create;
  poNumbers.Clear;
  qSelect := TFDQuery.Create(nil);
  qSelect.ConnectionName := fDm.dB.ConnectionName;

  // Todo: decouple by creating a view for this join?
  with qSelect.SQL do
  begin
    Clear;
    Add('select ponumber');
    Add('from shipment s join distribintf.asndetail d');
    Add('on s.shipmentid = d.receiptid');
    Add('where s.shipmentid = :shipment');
    Add('and s.hasbeencopied = ''N''');
    Add('and d.materialnumber = :artno');
    Add('order by ponumber');
  end;
  qSelect.ParamByName('shipment').AsString := shipmentid;
  qSelect.ParamByName('artno').AsString := artno;
  qSelect.Open;
  while not qSelect.Eof do
  begin
    if (not qSelect.FieldByName('ponumber').IsNull) and
       (Length(Trim(qSelect.FieldByName('ponumber').AsString)) > 0) then
    begin
      poNumbers.Add(Trim(qSelect.FieldByName('ponumber').AsString));
    end;
    qSelect.Next;
  end;
  qSelect.Close;

  // So the calling procedure knows that PONumbers were found for this product
  // and can give a proper warning to the user
  foundForProduct := poNumbers.Count > 0;

  // No PONumbers found for this product, we search again without the artno parameter
  if poNumbers.Count = 0 then
  begin
    with qSelect.SQL do
    begin
      Clear;
      Add('select ponumber');
      Add('from shipment s join distribintf.asndetail d');
      Add('on s.shipmentid = d.receiptid');
      Add('where s.shipmentid = :shipment');
      Add('and s.hasbeencopied = ''N''');
      Add('order by ponumber');
    end;
    qSelect.ParamByName('shipment').AsString := shipmentid;
    qSelect.Open;
    while not qSelect.Eof do
    begin
      if (not qSelect.FieldByName('ponumber').IsNull) and
          (Length(Trim(qSelect.FieldByName('ponumber').AsString)) > 0) then
      begin
        poNumbers.Add(Trim(qSelect.FieldByName('ponumber').AsString));
      end;
      qSelect.Next;
    end;
    qSelect.Close;
  end;

  FreeAndNil(qSelect);
  Result := poNumbers;
end;

procedure TfInterCompReceiveEnter.aAddProductExecute(Sender: TObject);
var
  fAddProductShipment : TfAddProdShipment;
  i : integer;
  artno : string;
  quant : string;
  units : integer;
  stacks : integer;
  trays : integer;
  totalInUnits : integer;
  article : rArt;
  newNode : TSNode;
  orgNode : TSNode;
  description : string;
  addNode : boolean;
  orgIndex : integer;
  onlyAddExistingProducts : boolean;
  checkPONumbers : boolean;
  poNumbers : TStringList;
  selectedPONumber : string;
  foundForProduct : boolean;
begin
  inherited;
  if (ReadOnly) then
  begin
    if not disableInboundScanMessages then
      ShowMessage('Can''t add products on a read-only screen');
    Exit;
  end;

  stacks := 0;
  trays := 0;
  units := 0;
  totalInUnits := 0;
  description := EmptyStr;
  orgIndex := -1;
  // Introduced in case we ever need a global setting to prevent
  // adding new products
  onlyAddExistingProducts := false;

  // In case we need a global setting
  checkPONumbers := true;

  fAddProductShipment := TfAddProdShipment.Create(Container.ShipmentID);
  if fAddProductShipment.ShowModal = mrOk then
  begin
    // Ensure the product list is up to date
    fDespList.ReadProd;

    for i := 1 to fAddProductShipment.sgProducts.RowCount - 1 do
    begin
      artno := fAddProductShipment.sgProducts.Cells[0,i];
      description := fAddProductShipment.sgProducts.Cells[1,i];
      quant := fAddProductShipment.sgProducts.Cells[2,i];

      article := fDespList.FindArticle(artno);
      if Assigned(article) then
      begin

        if (Pos(',', quant) > 0) or (Pos('.', quant) > 0) then
        begin
          GetRacksCratesPieces(quant, stacks, trays, units);
          totalInUnits := 0;
          Inc(totalInUnits, stacks * article.StackHeight * article.DefaPcsPerBasket);
          Inc(totalInUnits, trays * article.DefaPcsPerBasket);
          Inc(totalInUnits, units);
        end else
        begin
          try
            totalInUnits  := StrToInt(quant);
          except
            totalInUnits := 0;
          end;
        end;

        orgIndex := FindProductInShipment(artno);
        if onlyAddExistingProducts then
        begin
          // Only process if we have a valid quantity and the product exists in the shipment
          if (totalInUnits > 0) and (orgIndex <> -1) then
            addNode := true
          else
          begin
            addNode := false;
            ShowMessage( 'Only existing product can be added, skipped item: ' +  artno);
          end;
        end else
        begin
          // Only process if we have a valid quantity
          if totalInUnits > 0 then
            addNode := true
          else
            addNode := false;
        end;

      end else
      begin
        LogErrorNoMessage('TfInterCompReceiveEnter.aAddProductExecute', 'Product not found');
        addNode := false;
      end;

      // Check if we have purchase orders for this product
      if checkPONumbers then
      begin
        poNumbers := nil;
        selectedPONumber := EmptyStr;
        foundForProduct := false;

        poNumbers := self.RetrievePurchaseOrders(Container.ShipmentID, artno, foundForProduct);
        if Assigned(poNumbers) and (poNumbers.Count > 0) then
        begin
          selectedPONumber := poNumbers[0];
          poNumbers.Clear;
          FreeAndNil(poNumbers);
        end;
      end;

      if orgIndex <> -1 then
      begin
        // Product already present in the container
        orgNode := Container.Nodes[orgIndex];
        if Assigned(orgNode) then
        begin
          // Original node has a stackid (not bulk), force a new node and treat
          // the new product as bulk
          if orgNode.LPN <> '-1' then
          begin
            newNode := TSNode.Create(Container);
            if Assigned(newNode) then
            begin
              // Store the sending company in the user1 field for the 2nd screen for now
              newNode.ShipmentId := Container.ShipmentID;
              newNode.LPN := '-1';
              newNode.orgLPN := EmptyStr;
              newNode.ArtNo := artno;
              newNode.Name := description;
              newNode.PcsPerBasket := article.DefaPcsPerBasket;
              newNode.StackHeight := article.StackHeight;
              newNode.Ordered := totalInUnits;
              newNode.QuantArrived := totalInUnits;
              newNode.Damage := 0;
              newNode.ToDeliver := 0;
              newNode.ToDeliverBackup := 0;
              newNode.PONumber := selectedPONumber;

              // Todo: create GLOC_ATP_RES and TRANSNOS records
              ManualAddToShipment(newNode);

              // Now add the product to the container nodes
              Container.Nodes.Add(newNode);
              Drawgrid1.RowCount := Drawgrid1.RowCount + 1;
            end else
            begin
              LogError('TfInterCompReceiveEnter.aAddProductExecute', 'Error adding product node to container');
            end;

          end else
          begin
            // Add the amount to the original amount
            orgNode.Ordered := orgNode.Ordered + totalInUnits;
            // Need to write changes to GLOC_ATP_RES
            ManualUpdateShipment(orgNode, totalInUnits);
          end;
        end else
          LogError('TfInterCompReceiveEnter.aAddProductExecute', 'Error locating original product node');

      end else
      begin

        // No PONumber found, block addition of new product
        if (selectedPONumber = EmptyStr) then
        begin
          Application.MessageBox(
          PChar(vGlobalStrings.GetString(GLOBSTR_ASN_ADDERROR)),
          PChar(vGlobalStrings.GetString(GLOBSTR_WARNING)),
          MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2 or MB_SETFOREGROUND or MB_TOPMOST);
          addNode := false;
        end else
        begin
          // We can on an existing PO number for this product without warning
          if not foundForProduct then
          begin
            // Show a message the user is about to add a new product to a PO number
            if Application.MessageBox(
              PChar(Format(vGlobalStrings.GetString(GLOBSTR_ASN_ADDWARNING), [selectedPONumber])),
              PChar(vGlobalStrings.GetString(GLOBSTR_WARNING)),
              MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2 or MB_SETFOREGROUND or MB_TOPMOST) <> mrYes then
            begin
              addNode := false;
            end;
          end;
        end;

        // Add a new product node if we are allowed to
        if addNode and (not onlyAddExistingProducts) then
        begin
          newNode := TSNode.Create(Container);
          if Assigned(newNode) then
          begin
            // Store the sending company in the user1 field for the 2nd screen for now
            newNode.ShipmentId := Container.ShipmentID;
            newNode.LPN := '-1';
            newNode.orgLPN := EmptyStr;
            newNode.ArtNo := artno;
            newNode.Name := description;
            newNode.PcsPerBasket := article.DefaPcsPerBasket;
            newNode.StackHeight := article.StackHeight;
            newNode.Ordered := totalInUnits;
            newNode.QuantArrived := totalInUnits;
            newNode.Damage := 0;
            newNode.ToDeliver := 0;
            newNode.ToDeliverBackup := 0;
            //Store the selectedPO in the user2 for processing...
            newNode.PONumber := selectedPONumber;

            // Todo: create GLOC_ATP_RES and TRANSNOS records
            ManualAddToShipment(newNode);

            // Now add the product to the container nodes
            Container.Nodes.Add(newNode);
            Drawgrid1.RowCount := Drawgrid1.RowCount + 1;
          end else
          begin
            LogError('TfInterCompReceiveEnter.aAddProductExecute', 'Error adding product node to container');
          end;
        end; // if addNode then
      end; // else if orgIndex <> -1
    end;  // for

    // Resort and refresh the screen
    Container.Sort(CS_STACKID);
    DrawGrid1.Refresh;

  end;
  fAddProductShipment.Free;
end;

procedure TfInterCompReceiveEnter.CheckOrigin(ccodefrom : integer; glocidfrom : integer);
var
  gloc : rGloc;
  qComp, qGloc : TFDQuery;
begin
  gloc := lgloc.Find(ccodefrom, glocidfrom);
  if gloc = nil then
  begin

    // Need to add it
    qComp := TFDQuery.Create(nil);
    qGloc := TFDQuery.Create(nil);
    if Assigned(qComp) and Assigned(qGloc) then
    begin
      qComp.ConnectionName := fDm.dB.ConnectionName;
      qGloc.ConnectionName := fDm.dB.ConnectionName;
      with qComp.SQL do
      begin
        Clear;
        Add('insert into comp');
        Add('(ccode, description) values (:ccode, :description)');
      end;
      qComp.ParamByName('ccode').AsInteger := ccodefrom;
      qComp.ParamByName('description').AsString := 'auto generated by IC';

      with qGloc.SQL do
      begin
        Clear;
        Add('insert into gloc');
        Add('(ccode, glocid, description, gltype, area) values (:ccode, :glocid, :description, :gltype, :area)');
      end;
      qGloc.ParamByName('ccode').AsInteger := ccodefrom;
      qGloc.ParamByName('glocid').AsInteger := glocidfrom;
      qGloc.ParamByName('description').AsString := 'auto generated by IC';
      qGloc.ParamByName('gltype').AsInteger := integer(GLOCTYPE_INTRACOMPANY);
      qGloc.ParamByName('area').AsString := 'A';

      fDm.dB.StartTransaction;
      try
        qComp.ExecSql;
      except
        ;
      end;

      try
        qGloc.ExecSql;
        fDm.dB.Commit;
      except
        fDm.db.Rollback;
      end;
    end;

    if Assigned(qComp) then
    begin
      qComp.Free;
    end;

    if Assigned(qGloc) then
    begin
      qGloc.Free;
    end;
  end;
end;

procedure TfInterCompReceiveEnter.ManualUpdateShipment(node : TSNode; addedQuant : integer);
var
  qGar : TFDQuery;
  moment : TDateTime;
  transaction: TTransno;
begin
  moment := RecodeMilliSecond(Now, 0);

  qGar := TFDQuery.Create(nil);
  if Assigned(qGar) then
  begin
    qGar.ConnectionName := fDm.dB.ConnectionName;
    with qGar.SQL do
    begin
      Clear;
      Add('update GLOC_ATP_RES');
      Add('set quantres = :quantres, quantshipped = :quantshipped');
      Add('where artno = :artno and transno = :transno');
    end;

    qGar.ParamByName('artno').AsString := node.ArtNo;
    qGar.ParamByName('transno').AsInteger := node.Transno;
    qGar.ParamByName('quantres').AsInteger := node.Ordered;
    qGar.ParamByName('quantshipped').AsInteger := node.Ordered;

    transaction := fDM.NewTransaction;
    if (transaction <> nil) then
    begin
      transaction.TSTART := moment;
      transaction.TEND := moment;
      transaction.CCODE := self.Company;
      transaction.WS := GlobalStation;
      transaction.EMPLOYEENO := GlobalUserId; // shouldn't this be: self.CurrentUserId?
      transaction.TTYPE := TRANS_DM_ADDSTACKSMANUALLY;
      transaction.SHIPDATE := Shipdate;
      transaction.SHIPMENTID := node.ShipmentId;
      transaction.REASONCODE := GlobalGeneralOptions.ReasonCodeManualASNAdd;
      transaction.STACKID := node.LPN;
      transaction.SCREENNO := self.ScreenNumber;
      transaction.ARTNO := node.ArtNo;
      transaction.CCODEGLOC := self.Company;
      transaction.GLOCID := self.GLocId;
      transaction.AMOUNT := addedQuant;
      transaction.Update;
      fDm.dB.StartTransaction;
      try
        qGar.ExecSQL;

        if qGar.RowsAffected <> 1 then
          LogError('TfInterCompReceiveEnter.ManualUpdateShipment', 'Nr of GLOC_ATP_RES records updated : ' + IntToStr(qGar.RowsAffected));

        fDm.dB.Commit;
      except
        fDm.dB.Rollback;
        LogError('TfInterCompReceiveEnter.ManualUpdateShipment', 'Error creating TRANSNOS and GLOC_ATP_RES records');
      end;

      FreeAndNil(transaction);
    end; //if (transaction <> nil)

    qGar.Free;
  end;
end;

function TfInterCompReceiveEnter.OneAndOnlyOneWave: boolean;
begin
  Result := FilterWave;
  if lWaveFilter.Count <> 1 then Result := false;
end;

procedure TfInterCompReceiveEnter.ManualAddToShipment(node : TSNode);
var
  qSelAtp : TFDQuery;
  qAtp : TFDQuery;
  qGar : TFDQuery;
  moment : TDateTime;
  atpExists : boolean;
  transaction: TTransno;
begin
  qSelAtp := TFDQuery.Create(nil);
  qAtp := TFDQuery.Create(nil);
  qGar := TFDQuery.Create(nil);
  moment := RecodeMilliSecond(Now, 0);

  // Check if the origin exists in the database
  CheckOrigin(Container.CcodeFrom, Container.GLocIdFrom);

  if Assigned(qSelAtp) and Assigned(qAtp) and Assigned(qGar) then
  begin
    qGar.ConnectionName := fDm.dB.ConnectionName;
    with qGar.SQL do
    begin
      Clear;
      Add('insert into GLOC_ATP_RES');
      Add('(ccodefrom, glocidfrom, datetimestart, artno, ccodeto, glocidto, transno,');
      Add('quantres, quantshipped, shipped, datetimeshipped, exparr, arr, quantarr, storno,');
      Add('direction, cwshipdate, cwshipped, blocked, stackid, sticker, stickprint, groupnum, multi, tostock, ponumber)');
      Add('values');
      Add('(:ccodefrom, :glocidfrom, :datetimestart, :artno, :ccodeto, :glocidto, :transno,');
      Add(':quant, :quant, ''Y'', :datetimestart, :exparr, ''N'', :quantarr, ''N'',');
      Add('''T'', :shipdate, ''Y'', ''N'', :stackid, ''N'', ''N'', 0, ''N'', ''N'', :ponumber)');
    end;

    qAtp.ConnectionName := fDm.dB.ConnectionName;
    with qAtp.SQL do
    begin
      Clear;
      Add('insert into gloc_atp');
      Add('(ccode, glocid, datetimestart, artno, quant)');
      Add('values');
      Add('(:ccode, :glocid, :datetimestart, :artno, 0)');
    end;

    qSelAtp.ConnectionName := fDm.dB.ConnectionName;
    with qSelAtp.SQL do
    begin
      Clear;
      Add('select count(*) as nr from gloc_atp');
      Add('where ccode = :ccode and glocid = :glocid and datetimestart = :datetimestart and artno = :artno');
    end;

    transaction := fDM.NewTransaction;

    if (transaction <> nil) then
    begin
      transaction.TSTART := moment;
      transaction.TEND := moment;
      transaction.CCODE := self.Company;
      transaction.WS := GlobalStation;
      transaction.EMPLOYEENO := GlobalUserId; // shouldn't this be: self.CurrentUserId?
      transaction.TTYPE := TRANS_DM_ADDSTACKSMANUALLY;
      transaction.SHIPDATE := Shipdate;
      transaction.SHIPMENTID := node.ShipmentId;
      transaction.REASONCODE := GlobalGeneralOptions.ReasonCodeManualASNAdd;
      transaction.STACKID := node.LPN;
      transaction.SCREENNO := self.ScreenNumber;
      transaction.ARTNO := node.ArtNo;
      transaction.CCODEGLOC := self.Company;
      transaction.GLOCID := self.GLocId;
      transaction.AMOUNT := node.Ordered;

      transaction.Update;

      qSelAtp.ParamByName('ccode').AsInteger := Container.CcodeFrom;
      qSelAtp.ParamByName('glocid').AsInteger := Container.GLocIdFrom;
      qSelAtp.ParamByName('datetimestart').AsDateTime := moment;
      qSelAtp.ParamByName('artno').AsString := node.ArtNo;

      qAtp.ParamByName('ccode').AsInteger := Container.CcodeFrom;
      qAtp.ParamByName('glocid').AsInteger := Container.GLocIdFrom;
      qAtp.ParamByName('datetimestart').AsDateTime := moment;
      qAtp.ParamByName('artno').AsString := node.ArtNo;

      qGar.ParamByName('ccodefrom').AsInteger := Container.CcodeFrom;
      qGar.ParamByName('glocidfrom').AsInteger := Container.GLocIdFrom;
      qGar.ParamByName('datetimestart').AsDateTime := moment;
      qGar.ParamByName('exparr').AsDateTime := moment;
      qGar.ParamByName('artno').AsString := node.ArtNo;
      qGar.ParamByName('ccodeto').AsInteger := self.Company;
      qGar.ParamByName('glocidto').AsInteger := self.GLocId;
      qGar.ParamByName('transno').AsInteger := transaction.TRANSNO;
      qGar.ParamByName('quant').AsInteger := node.Ordered;
      qGar.ParamByName('quantarr').AsInteger := 0;
      qGar.ParamByName('shipdate').AsString := Container.Shipdate;
      qGar.ParamByName('stackid').AsString := node.LPN;
      qGar.ParamByName('ponumber').AsString := node.PONumber;

      qSelAtp.Open;
      atpExists := (qSelAtp.FieldByName('nr').AsInteger > 0);
      qSelAtp.Close;

      fDm.dB.StartTransaction;
      try
        if not atpExists then
          qAtp.ExecSQL;
        qGar.ExecSQL;

        // Log
        Utils.DebugLogFormatGM('TfInterCompReceiveEnter.ManualAddToShipment(transno %d, artno %s, quantarr %d)',
                         [Transaction.transno, Node.ArtNo, 0]);

        fDm.dB.Commit;

        //Make sure the new node's Transno is set correctly.
        node.Transno := transaction.TRANSNO;
        node.orgTransno := transaction.TRANSNO;
        node.Company := Container.Company;
        node.GLocId := Container.GlocId;
      except
        fDm.dB.Rollback;
        LogError('TfInterCompReceiveEnter.ManualAddToShipment', 'Error creating TRANSNOS and GLOC_ATP_RES records');
      end;

      FreeAndNil(transaction);
    end; //if (transaction <> nil)

    FreeAndNil(qSelAtp);
    FreeAndNil(qAtp);
    FreeAndNil(qGar);
  end;

end;

procedure TfInterCompReceiveEnter.aEditStackAttributesExecute(Sender: TObject);
begin
  inherited;
  if (ReadOnly) then
  begin
    if not disableInboundScanMessages then
      ShowMessage('Can''t edit item attributes on a read-only screen');
    Exit;
  end;

  // Temporarily change item attributes
  MixedStackControl.EditStackAttributes(Company, GlocId, Shipdate, bCratesPcs, True, LocalPrinter);

end;

procedure TfInterCompReceiveEnter.aEditStackExecute(Sender: TObject);
begin
  inherited;
  if (ReadOnly) then
  begin
    if not disableInboundScanMessages then
      ShowMessage('Can''t edit stacks on a read-only screen');
    Exit;
  end;

  // Done: call the edit stack function (5th parameter is MethodUnits)
  MixedStackControl.EditStack(Company, GlocId, Shipdate, bCratesPcs, True, LocalPrinter);
end;

procedure TfInterCompReceiveEnter.aCratesPcsExecute(Sender: TObject);
begin
  inherited;
  bCratesPcs := aCratesPcs.Checked;
end;

procedure TfInterCompReceiveEnter.aPredespatchRemainderExecute(Sender: TObject);
begin
  if Application.MessageBox(
    PChar(vGlobalStrings.GetString(GLOBSTR_PREDESPATCH_REMAINING_SHIPMENT)),
    PChar(vGlobalStrings.GetString(GLOBSTR_QUESTION)),
    MB_YESNO Or MB_ICONQUESTION Or MB_DEFBUTTON2 or MB_SETFOREGROUND or MB_TOPMOST) = mrYes then
  begin

    // Predespatch the remainder
    if (NOT (GlobalIntercompanyOptions.AutoPredespatchIntracompany AND PredespatchShipment)) then
        Exit;
    // Something went wrong (products might have been blocked)
    // Bail out. Do not call the inherited functionality

    // Now call the base class' Execute_Enterkey() to handle the rest
    inherited Execute_Enterkey;
  end;
end;

procedure TfInterCompReceiveEnter.tmrCheckScansTimer(Sender: TObject);
begin
  inherited;
  // Check the INBOUNDSTACKS table, process any remaining stacks for
  // the currently selected shipment
  tmrCheckScans.Enabled := false;
  Inc(inboundScanCounter);
  if (inboundScanCounter >= 40) or inboundScan then
  begin
    ProcessInboundStacks;
    inboundScanCounter := 0;
    inboundScan := false;
  end;
  tmrCheckScans.Enabled := true;
end;

procedure TfInterCompReceiveEnter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tmrCheckScans.Enabled := false;
end;

procedure TfInterCompReceiveEnter.aAlternativeExecute(Sender: TObject);
var
  index : integer;
  node : TSNode;
  fSelectAlternative : TfSelectAlternative;
  article : rArt;
begin
  inherited;
  // Select alternative product and set it for the currently selected node
  if Container.Nodes.Count = 0 then
    exit;
  if DrawGrid1.Row <= 0 then
    exit;

  index := DrawGrid1.Row - 1;
  node := Container.Nodes[index];

  // Cannot set alternatives on an already created stack
  if node.isNewStack then
    exit;

  // If the current node already has an alternative set, reset it if the user want to
  if Length(node.AltArtno) > 0 then
  begin
     if (MessageDlg(vGlobalStrings.GetString(GLOBSTR_CONFIRMRESETALT), mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
     begin
      // Reset the field for the alternative product
      node.AltArtno := EmptyStr;
      node.AltDescription := EmptyStr;

      // Done: Look up stackheight and units per tray for the original product
      article := fDespList.FindArticle(node.Artno);
      if article <> nil then
      begin
        node.PcsPerBasket := article.DefaPcsPerBasket;
        node.StackHeight := article.StackHeight;
      end;

      Drawgrid1.Refresh;
    end;
  end else
  begin
    // Display the alternative selection screen
    fSelectAlternative := TfSelectAlternative.Create(nil);
    fSelectAlternative.OrgArtno := node.ArtNo;
    fSelectAlternative.Shipdate := ShipDate;
    fSelectAlternative.GlocID := GlocId;
    if fSelectAlternative.ShowModal=mrOk then
    begin
      node.AltArtno := fSelectAlternative.Artno;
      node.AltDescription := fSelectAlternative.Desc;
      // Look up stackheight and units per tray for the alternative
      article := fDespList.FindArticle(node.AltArtno);
      if article <> nil then
      begin
        node.AltPPB := article.DefaPcsPerBasket;
        node.AltStackHeight := article.StackHeight;
      end;

      Drawgrid1.Refresh;
    end; //if fSelectAlternative.ShowModal=mrOk then
    FreeAndNil(fSelectAlternative);
  end;
  UpdateInfo;
end;

procedure TfInterCompReceiveEnter.aSearchArticlesExecute(Sender: TObject);
begin
  inherited;
  // Dummy handler for authorisations
  ;
end;

function TfInterCompReceiveEnter.CalculateNeeded(ANode: TSNode): integer;
var
  i, totalOrdered, totalPD, totalRemaining, totalBalance: integer;
  newContainer: TSNodeContainer;
  currNode: TSNode;
  art: rArt;
begin
  Result := 0;
  if not Assigned(Container) or not Assigned(Container.Nodes) or (Container.Nodes.Count = 0) or (not assigned(ANode)) or (ANode.isNewStack) then
  begin
    Exit;
  end;

  newContainer := TSNodeContainer.Create;
  if (NOT Assigned(newContainer)) then
    Exit;
  newContainer.EnteredAmount := Container.EnteredAmount;
  newContainer.supportRouting := Container.supportRouting;
  newContainer.Company := GlobalCompany;
  newContainer.GlocId := Container.GlocId;
  newContainer.PcsPerBasket := ANode.PcsPerBasket;
  newContainer.TotalNeeded := ANode.Ordered;
  newContainer.TotalDamage := ANode.Damage;
  newContainer.AltArtno := ANode.AltArtno;
  newContainer.ArtNo := ANode.ArtNo;
  newContainer.OrgAmount := ANode.Ordered;

  newContainer.Transno := Container.Transno;
  newContainer.TransType := TRANS_PREDESPATCH;
  newContainer.ScrType := SCRTYPE_PD;
  newContainer.Starttime := Now;
  newContainer.Phase := PHASE_DESPATCH;
  newContainer.ScreenCCode := Container.ScreenCCode;
  newContainer.ScreenWS := Container.ScreenWS;
  newContainer.ScreenNo := Container.ScreenNo;
  newContainer.MethodUnits := Container.MethodUnits;
  newContainer.CratesPcs := Container.CratesPcs;
  newContainer.AsnOrPO := Container.AsnOrPO;
  newContainer.printASNorPO := Container.printASNorPO;

  // Todo: set this correctly
  newContainer.Method := Container.Method;
  // Take over the current stack despatch order
  newContainer.StackDespatchOrder := Self.StackDespatchOrder;

  // Add the customer orders for the despatch algorithm
  PDDDReadDespatchData(newContainer);

  // Done handle alternatives
  if Length(ANode.AltArtno) > 0 then
    Art := fDespList.FindArticle(newContainer.AltArtno)
  else
    Art := fDespList.FindArticle(newContainer.ArtNo);

  if Assigned(Art) and (Art.StackHeight > 0) then
  begin
    newContainer.maxInStack := Art.StackHeight * Art.DefaPcsPerBasket;
    newContainer.PcsPerBasket := Art.DefaPcsPerBasket;
    newContainer.StackHeight := Art.StackHeight;
    newContainer.SetStackTypeForProduct(Art.ARTNO, Art.StackType);
  end; //if Assigned(Art) and ...

  totalOrdered := 0;
  totalPD := 0;
  for i := 0 to newContainer.Nodes.Count - 1 do
  begin
    currNode := newContainer.Nodes[i];

    totalOrdered := totalOrdered + currNode.Ordered;
    totalPD := totalPD + currNode.Predespatched
  end; //for i := 0 to newContainer.Nodes.Count - 1

  newContainer.Amount := totalOrdered - totalPD; // + ANode.Damage;

  Result := TotalOrdered - TotalPD;

  if Assigned(newContainer) then
    FreeAndNil(newContainer);
end;

procedure TfInterCompReceiveEnter.CalculateStackDest(ANode: TSNode);
var
  i, totalOrdered, totalPD, totalRemaining, totalBalance: integer;
  newContainer: TSNodeContainer;
  currNode: TSNode;
  art: rArt;
begin
  // Just bail out on an empty container
  if not Assigned(Container) or not Assigned(Container.Nodes) or (Container.Nodes.Count = 0) or (not assigned(ANode)) or (ANode.isNewStack) then
  begin
    //Make sure to clear the labels, in case we have selected a new stack node
    //since those shouldn't display any info.
    lblTotalLeft.Caption := EmptyStr;
    lblASNRemaining.Caption := EmptyStr;
    lblDirect.Caption := EmptyStr;
    lblSendToEd.Caption := EmptyStr;
    lblBalance.Caption := EmptyStr;
    Exit;
  end;

  newContainer := TSNodeContainer.Create;
  if (NOT Assigned(newContainer)) then
    Exit;

  newContainer.EnteredAmount := Container.EnteredAmount;
  newContainer.supportRouting := Container.supportRouting;
  newContainer.Company := GlobalCompany;
  newContainer.GlocId := Container.GlocId;
  newContainer.PcsPerBasket := ANode.PcsPerBasket;
  newContainer.TotalNeeded := ANode.Ordered;
  newContainer.TotalDamage := ANode.Damage;
  newContainer.AltArtno := ANode.AltArtno;
  newContainer.ArtNo := ANode.ArtNo;
  newContainer.OrgAmount := ANode.Ordered;

  newContainer.Transno := Container.Transno;
  newContainer.TransType := TRANS_PREDESPATCH;
  newContainer.ScrType := SCRTYPE_PD;
  newContainer.Starttime := Now;
  newContainer.Phase := PHASE_DESPATCH;
  newContainer.ScreenCCode := Container.ScreenCCode;
  newContainer.ScreenWS := Container.ScreenWS;
  newContainer.ScreenNo := Container.ScreenNo;
  newContainer.MethodUnits := Container.MethodUnits;
  newContainer.CratesPcs := Container.CratesPcs;
  newContainer.AsnOrPO := Container.AsnOrPO;
  newContainer.printASNorPO := Container.printASNorPO;

  // Todo: set this correctly
  newContainer.Method := Container.Method;
  // Take over the current stack despatch order
  newContainer.StackDespatchOrder := Self.StackDespatchOrder;

  // Add the customer orders for the despatch algorithm
  PDDDReadDespatchData(newContainer);
//  if GlobalDespatchOptions.supportRouting then
//    DespMethodRouting(newContainer, true);

  // Done handle alternatives
  if Length(ANode.AltArtno) > 0 then
    Art := fDespList.FindArticle(newContainer.AltArtno)
  else
    Art := fDespList.FindArticle(newContainer.ArtNo);

  if Assigned(Art) and (Art.StackHeight > 0) then
  begin
    newContainer.maxInStack := Art.StackHeight * Art.DefaPcsPerBasket;
    newContainer.PcsPerBasket := Art.DefaPcsPerBasket;
    newContainer.StackHeight := Art.StackHeight;
    newContainer.SetStackTypeForProduct(Art.ARTNO, Art.StackType);
  end; //if Assigned(Art) and ...

  //MSO: We need to recalculate the total amount of the newContainer here.
  //This is required to take into account PDed amounts from other terminals.
  //The amounts are calculated based on the amounts from the PDDDReadDespatchData
  totalOrdered := 0;
  totalPD := 0;

  for i := 0 to newContainer.Nodes.Count - 1 do
  begin
    currNode := newContainer.Nodes[i];

    totalOrdered := totalOrdered + currNode.Ordered;
    totalPD := totalPD + currNode.Predespatched
  end; //for i := 0 to newContainer.Nodes.Count - 1

  newContainer.Amount := totalOrdered - totalPD; // + ANode.Damage;

  totalRemaining := 0;
  totalBalance := 0;
  // calculate remaining amount still to be received for the node product, and the ASN total for the node product
  for i := 0 to Container.Nodes.Count - 1 do
  begin
    currNode := Container.Nodes[i];
  	if (currNode.ArtNo = ANode.ArtNo) then
    begin
    	if (not currNode.isNewStack) then
				totalRemaining := totalRemaining + (currNode.Ordered - currNode.Predespatched);
    end;
  end;	//for i := 0 to Container.Nodes.Count - 1 do
  totalBalance := totalRemaining;

  lblTotalLeft.Caption := CratesPieces(newContainer.Amount,newContainer.StackHeight,newContainer.PcsPerBasket,GlobalDespatchOptions.ShowStack>2,newContainer.CratesPcs);
  lblASNRemaining.Caption := CratesPieces(totalRemaining,newContainer.StackHeight,newContainer.PcsPerBasket,GlobalDespatchOptions.ShowStack>2,newContainer.CratesPcs);
  lblDirect.Caption := CratesPieces(newContainer.GetFullStacksToDeliver(false),newContainer.StackHeight,newContainer.PcsPerBasket,GlobalDespatchOptions.ShowStack>2,newContainer.CratesPcs);
  lblSendToEd.Caption := CratesPieces(newContainer.Amount - newContainer.GetFullStacksToDeliver(false),newContainer.StackHeight,newContainer.PcsPerBasket,GlobalDespatchOptions.ShowStack>2,newContainer.CratesPcs);
  lblSchedNeededAmount.Caption := CratesPieces(newContainer.GetScheduledNeeded,newContainer.StackHeight,newContainer.PcsPerBasket,GlobalDespatchOptions.ShowStack>2,newContainer.CratesPcs);
  lblBalance.Caption := CratesPieces(totalBalance,newContainer.StackHeight,newContainer.PcsPerBasket,GlobalDespatchOptions.ShowStack>2,newContainer.CratesPcs);

  if Assigned(newContainer) then
    FreeAndNil(newContainer);
end;

procedure TfInterCompReceiveEnter.RefreshGrid(AIndex: integer);
begin
  DrawGrid1.RowCount := Container.Nodes.Count + 1;
  DrawGrid1.Row := AIndex;
  lastRowIndex := AIndex;
  DrawGrid1.Refresh;
end;

procedure TfInterCompReceiveEnter.RegisterTransaction(transaction: TTransType);
var trans : TTransno;
begin
  fDM.dB.StartTransaction;
  try
    // add a transaction record
    trans := fDM.NewTransaction;
    if (trans <> nil) then
    begin
        if (GLobalUserId > 0) then
          trans.EMPLOYEENO := GLobalUserId
        else
          trans.EMPLOYEENO := GLobalUserId;

      trans.screenno := ScreenNumber;
      trans.TTYPE := transaction;

      trans.Update;
      FreeAndNil(trans);
    end;

    fDM.dB.Commit;
  except
    fDM.dB.Rollback;
  end;
end;

procedure TfInterCompReceiveEnter.GetStockChanges(Sender: TObject);
begin
  AskStockDestination := Container.AskStockDestination;
  DestinationCompany := Container.DestinationCompany;
  DestinationGloc := Container.DestinationGloc;
  DestinationDescription := Container.DestinationDescription;
  DestinationIsControlled := Container.DestinationIsControlled;
end;

end.
