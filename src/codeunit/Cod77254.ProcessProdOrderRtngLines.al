codeunit 77254 "Process Prod.  OrderRtng Lines"
{
    TableNo = "Prod. Order Routing Line Stage";

    [TryFunction]
    procedure ProcessProdOrderRoutingLines(var ProdOrderRoutingLineStage: Record "Prod. Order Routing Line Stage")
    var
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        ProdOrderRoutingLineStagingRecGbl.Reset();
        ProdOrderRoutingLineStagingRecGbl.CopyFilters(ProdOrderRoutingLineStage);
        if ProdOrderRoutingLineStagingRecGbl.FindSet() then
            repeat
                ProdOrderRoutingLineRecGbl.Init();
                ProdOrderRoutingLineRecGbl.Validate(Status, ProdOrderRoutingLineStagingRecGbl.Status::Released);
                ProdOrderRoutingLineRecGbl.Validate("Prod. Order No.", ProdOrderRoutingLineStagingRecGbl."Prod. Order No.");
                ProdOrderLineRecLcl.Reset();
                ProdOrderLineRecLcl.SetRange("Prod. Order No.", ProdOrderRoutingLineRecGbl."Prod. Order No.");
                if ProdOrderLineRecLcl.FindFirst() then begin
                    ProdOrderRoutingLineRecGbl.Validate("Routing Reference No.", ProdOrderLineRecLcl."Routing Reference No.");
                    ProdOrderRoutingLineRecGbl.Validate("Routing No.", ProdOrderLineRecLcl."Routing No.");
                end;
                ProdOrderRoutingLineRecGbl.Validate("Operation No.", ProdOrderRoutingLineStagingRecGbl."Operation No.");
                ProdOrderRoutingLineRecGbl.Insert(true);

                ProdOrderRoutingLineRecGbl.Validate(Type, ProdOrderRoutingLineStagingRecGbl.Type::"Work Center");
                ProdOrderRoutingLineRecGbl.Validate("No.", ProdOrderRoutingLineStagingRecGbl."No.");
                ProdOrderRoutingLineRecGbl.Validate(Description, ProdOrderRoutingLineStagingRecGbl.Description);
                //  ProdOrderRoutingLineRecGbl.Validate("Routing Link Code", ProdOrderRoutingLineStagingRecGbl."Routing Link Code");
                ProdOrderRoutingLineRecGbl.Validate("Flushing Method", ProdOrderRoutingLineStagingRecGbl."Flushing Method");
                ProdOrderRoutingLineRecGbl.Modify(true);
            until ProdOrderRoutingLineStagingRecGbl.Next() = 0;
    end;

    var
        ProdOrderRoutingLineStagingRecGbl: Record "Prod. Order Routing Line Stage";
        ProdOrderRoutingLineRecGbl: Record "Prod. Order Routing Line";
}
