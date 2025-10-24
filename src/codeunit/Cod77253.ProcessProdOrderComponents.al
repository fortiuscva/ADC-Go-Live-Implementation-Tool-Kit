codeunit 77253 "Process Prod. Order Components"
{
    TableNo = "ADC Prod. Order Comp. Stage";

    [TryFunction]
    procedure ProcessOrderComponents(var ProdOrderCompStage: Record "ADC Prod. Order Comp. Stage")
    var
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        ProdOrderCompStagingRecGbl.Reset();
        ProdOrderCompStagingRecGbl.CopyFilters(ProdOrderCompStage);
        if ProdOrderCompStagingRecGbl.FindSet() then
            repeat
                LineNoGbl := 10000;
                ProdOrderComponentRecGbl.Reset();
                ProdOrderComponentRecGbl.SetRange("Prod. Order No.", ProdOrderCompStagingRecGbl."Prod. Order No.");
                if ProdOrderComponentRecGbl.FindLast() then
                    LineNoGbl := ProdOrderComponentRecGbl."Line No." + 10000;


                ProdOrderComponentRecGbl.Init();
                ProdOrderComponentRecGbl.Validate(Status, ProdOrderCompStagingRecGbl.Status::Released);
                ProdOrderComponentRecGbl.Validate("Prod. Order No.", ProdOrderCompStagingRecGbl."Prod. Order No.");
                ProdOrderLineRecLcl.Reset();
                ProdOrderLineRecLcl.SetRange("Prod. Order No.", ProdOrderCompStagingRecGbl."Prod. Order No.");
                if ProdOrderLineRecLcl.FindFirst() then
                    ProdOrderComponentRecGbl.Validate("Prod. Order Line No.", ProdOrderLineRecLcl."Line No.");
                ProdOrderComponentRecGbl.Validate("Line No.", LineNoGbl);
                ProdOrderComponentRecGbl.Insert(true);

                ProdOrderComponentRecGbl.Validate("Item No.", ProdOrderCompStagingRecGbl."Comp. Item No.");
                ProdOrderComponentRecGbl.Validate("Quantity per", ProdOrderCompStagingRecGbl."Quantity Per");
                ProdOrderComponentRecGbl.Validate("Expected Quantity", ProdOrderCompStagingRecGbl."Expected Quantity");
                ProdOrderComponentRecGbl.Validate("Unit of Measure Code", ProdOrderCompStagingRecGbl."Unit of Measure Code");
                ProdOrderComponentRecGbl.Validate("Flushing Method", ProdOrderCompStagingRecGbl."Flushing Method");
                ProdOrderComponentRecGbl.Validate("Routing Link Code", ProdOrderCompStagingRecGbl."Routing Link Code");
                ProdOrderComponentRecGbl.Validate("Location Code", ProdOrderCompStagingRecGbl."Location Code");
                ProdOrderComponentRecGbl.Validate("Bin Code", ProdOrderCompStagingRecGbl."Bin Code");
                ProdOrderComponentRecGbl.Modify(true);

                LineNoGbl += 10000;
            until ProdOrderCompStagingRecGbl.Next() = 0;
    end;

    var
        LineNoGbl: Integer;
        ProdOrderCompStagingRecGbl: Record "ADC Prod. Order Comp. Stage";
        ProdOrderComponentRecGbl: Record "Prod. Order Component";
        ItemRecGbl: Record Item;
}
