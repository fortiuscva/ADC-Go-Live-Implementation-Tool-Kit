codeunit 77254 "Process Prod.  OrderRtng Lines"
{
    TableNo = "Prod. Order Routing Line Stage";

    trigger OnRun()
    var
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        ProdOrderRoutingLineStagingRecGbl.Reset();
        ProdOrderRoutingLineStagingRecGbl.CopyFilters(Rec);
        if ProdOrderRoutingLineStagingRecGbl.FindSet() then
            repeat
                ProdOrderLineRecLcl.Reset();
                ProdOrderLineRecLcl.SetRange("Prod. Order No.", ProdOrderRoutingLineStagingRecGbl."Prod. Order No.");
                if ProdOrderLineRecLcl.FindFirst() then;
                if not ProdOrderRoutingLineRecGbl.Get(ProdOrderLineRecLcl.Status::Released, ProdOrderLineRecLcl."Prod. Order No.", ProdOrderLineRecLcl."Routing Reference No.", ProdOrderLineRecLcl."Routing No.", ProdOrderRoutingLineStagingRecGbl."Operation No.") then begin
                    ProdOrderRoutingLineRecGbl.Init();
                    ProdOrderRoutingLineRecGbl.Validate(Status, ProdOrderRoutingLineStagingRecGbl.Status::Released);
                    ProdOrderRoutingLineRecGbl.Validate("Prod. Order No.", ProdOrderRoutingLineStagingRecGbl."Prod. Order No.");
                    ProdOrderRoutingLineRecGbl.Validate("Routing Reference No.", ProdOrderLineRecLcl."Routing Reference No.");
                    ProdOrderRoutingLineRecGbl.Validate("Routing No.", ProdOrderLineRecLcl."Routing No.");
                    ProdOrderRoutingLineRecGbl.Validate("Operation No.", ProdOrderRoutingLineStagingRecGbl."Operation No.");
                    ProdOrderRoutingLineRecGbl.Insert(true);

                    ProdOrderRoutingLineRecGbl.Validate(Type, ProdOrderRoutingLineStagingRecGbl.Type::"Work Center");
                    ProdOrderRoutingLineRecGbl.Validate("No.", ProdOrderRoutingLineStagingRecGbl."No.");
                    ProdOrderRoutingLineRecGbl.Validate(Description, ProdOrderRoutingLineStagingRecGbl.Description);
                    //  ProdOrderRoutingLineRecGbl.Validate("Routing Link Code", ProdOrderRoutingLineStagingRecGbl."Routing Link Code");
                    ProdOrderRoutingLineRecGbl.Validate("Flushing Method", ProdOrderRoutingLineStagingRecGbl."Flushing Method");
                    ProdOrderRoutingLineRecGbl.Modify(true);
                end;
            until ProdOrderRoutingLineStagingRecGbl.Next() = 0;
    end;

    [TryFunction]
    procedure ProcessProdOrderRoutingLines(var ProdOrderRoutingLineStage: Record "Prod. Order Routing Line Stage")
    var
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        ProdOrderRoutingLineStagingRecGbl.Reset();
        ProdOrderRoutingLineStagingRecGbl.CopyFilters(ProdOrderRoutingLineStage);
        if ProdOrderRoutingLineStagingRecGbl.FindSet() then
            repeat
                ProdOrderLineRecLcl.Reset();
                ProdOrderLineRecLcl.SetRange("Prod. Order No.", ProdOrderRoutingLineStagingRecGbl."Prod. Order No.");
                if ProdOrderLineRecLcl.FindFirst() then;
                if not ProdOrderRoutingLineRecGbl.Get(ProdOrderLineRecLcl.Status::Released, ProdOrderLineRecLcl."Prod. Order No.", ProdOrderLineRecLcl."Routing Reference No.", ProdOrderLineRecLcl."Routing No.", ProdOrderRoutingLineStagingRecGbl."Operation No.") then begin
                    ProdOrderRoutingLineRecGbl.Init();
                    ProdOrderRoutingLineRecGbl.Validate(Status, ProdOrderRoutingLineStagingRecGbl.Status::Released);
                    ProdOrderRoutingLineRecGbl.Validate("Prod. Order No.", ProdOrderRoutingLineStagingRecGbl."Prod. Order No.");
                    ProdOrderRoutingLineRecGbl.Validate("Routing Reference No.", ProdOrderLineRecLcl."Routing Reference No.");
                    ProdOrderRoutingLineRecGbl.Validate("Routing No.", ProdOrderLineRecLcl."Routing No.");
                    ProdOrderRoutingLineRecGbl.Validate("Operation No.", ProdOrderRoutingLineStagingRecGbl."Operation No.");
                    ProdOrderRoutingLineRecGbl.Insert(true);

                    ProdOrderRoutingLineRecGbl.Validate(Type, ProdOrderRoutingLineStagingRecGbl.Type::"Work Center");
                    ProdOrderRoutingLineRecGbl.Validate("No.", ProdOrderRoutingLineStagingRecGbl."No.");
                    ProdOrderRoutingLineRecGbl.Validate(Description, ProdOrderRoutingLineStagingRecGbl.Description);
                    //  ProdOrderRoutingLineRecGbl.Validate("Routing Link Code", ProdOrderRoutingLineStagingRecGbl."Routing Link Code");
                    ProdOrderRoutingLineRecGbl.Validate("Flushing Method", ProdOrderRoutingLineStagingRecGbl."Flushing Method");
                    ProdOrderRoutingLineRecGbl.Modify(true);
                end;
            until ProdOrderRoutingLineStagingRecGbl.Next() = 0;
    end;

    var
        ProdOrderRoutingLineStagingRecGbl: Record "Prod. Order Routing Line Stage";
        ProdOrderRoutingLineRecGbl: Record "Prod. Order Routing Line";
}
