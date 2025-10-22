codeunit 77254 "Process Prod.  OrderRtng Lines"
{
    TableNo = "Prod. Order Routing Line Stage";

    trigger OnRun()
    begin
        ProdOrderRoutingLineStagingRecGbl.Reset();
        ProdOrderRoutingLineStagingRecGbl.CopyFilters(Rec);
        if ProdOrderRoutingLineStagingRecGbl.FindSet() then
            repeat
                ProdOrderRoutingLineRecGbl.Init();
                ProdOrderRoutingLineRecGbl.Validate(Status, ProdOrderRoutingLineStagingRecGbl.Status::Released);
                ProdOrderRoutingLineRecGbl.Validate("Prod. Order No.", ProdOrderRoutingLineStagingRecGbl."Prod. Order No.");
                ProdOrderRoutingLineRecGbl.Validate("Operation No.", ProdOrderRoutingLineStagingRecGbl."Operation No.");
                ProdOrderRoutingLineRecGbl.Validate("Routing Reference No.", ProdOrderRoutingLineStagingRecGbl."Routing Reference No.");
                ProdOrderRoutingLineRecGbl.Validate("Routing No.", ProdOrderRoutingLineStagingRecGbl."Routing No.");
                ProdOrderRoutingLineRecGbl.Insert(true);

                ProdOrderRoutingLineRecGbl.Validate(Type, ProdOrderRoutingLineStagingRecGbl.Type::"Work Center");
                ProdOrderRoutingLineRecGbl.Validate("No.", ProdOrderRoutingLineStagingRecGbl."No.");
                ProdOrderRoutingLineRecGbl.Validate(Description, ProdOrderRoutingLineStagingRecGbl.Description);
                ProdOrderRoutingLineRecGbl.Validate("Routing Link Code", ProdOrderRoutingLineStagingRecGbl."Routing Link Code");
                ProdOrderRoutingLineRecGbl.Validate("Flushing Method", ProdOrderRoutingLineStagingRecGbl."Flushing Method");
                ProdOrderRoutingLineRecGbl.Modify(true);
            until ProdOrderRoutingLineStagingRecGbl.Next() = 0;
    end;

    var
        ProdOrderRoutingLineStagingRecGbl: Record "Prod. Order Routing Line Stage";
        ProdOrderRoutingLineRecGbl: Record "Prod. Order Routing Line";
}
