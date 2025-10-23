codeunit 77252 "ADC Process Production Orders"
{
    TableNo = "ADC Production Order Stage";

    trigger OnRun()
    var
        ItemGbl: Record Item;
        ProdOrderRecLcl: Record "Production Order";
        ProdOrderStageRecLcl: Record "ADC Production Order Stage";
        ProdOrderLineStageRecLcl: Record "ADC Prod. Order Line Stage";
        ProdOrderCompStageRecLcl: Record "ADC Prod. Order Comp. Stage";
        ProdOrderRoutingStageRecLcl: Record "Prod. Order Routing Line Stage";
    begin
        ProdOrderStageRecLcl.Reset();
        ProdOrderStageRecLcl.CopyFilters(Rec);

        ItemGbl.Get(ProdOrderStageRecLcl."Source No.");
        ItemGbl.TestField("Routing No.");
        ItemGbl.TestField("Production BOM No.");

        if ProdOrderStageRecLcl.FindSet() then
            repeat
                ProdOrderRecLcl.Init();
                ProdOrderRecLcl.Validate("No.", ProdOrderStageRecLcl."Prod. Order No.");
                ProdOrderRecLcl.Validate(Status, ProdOrderStageRecLcl.Status::Released);
                ProdOrderRecLcl.Insert(true);

                ProdOrderRecLcl.Validate("Source Type", ProdOrderStageRecLcl."Source Type"::Item);
                ProdOrderRecLcl.Validate("Source No.", ProdOrderStageRecLcl."Source No.");
                ProdOrderRecLcl.Validate(Quantity, ProdOrderStageRecLcl.Quantity);
                ProdOrderRecLcl.Validate("Location Code", ProdOrderStageRecLcl."Location Code");
                ProdOrderRecLcl.Validate("Bin Code", ProdOrderStageRecLcl."Bin Code");
                ProdOrderRecLcl.Validate("Variant Code", ProdOrderStageRecLcl."Variant Code");
                ProdOrderRecLcl.Modify(true);

                //Process Prod order Line
                ProdOrderLineStageRecLcl.Reset();
                ProdOrderLineStageRecLcl.SetRange("Prod. Order No.", ProdOrderStageRecLcl."Prod. Order No.");
                if ProdOrderLineStageRecLcl.FindFirst() then begin
                    CreateProdOrderLines.SetProdOrderNoFilter(ProdOrderLineStageRecLcl);
                    Report.RunModal(Report::"Create Production Order Lines", false, false);
                end;

                //Process Prod Order Components
                ProdOrderCompStageRecLcl.Reset();
                ProdOrderCompStageRecLcl.SetRange("Prod. Order No.", ProdOrderStageRecLcl."Prod. Order No.");
                if ProdOrderCompStageRecLcl.FindFirst() then begin
                    CreateProdOrderComponents.SetProdOrderNoFilter(ProdOrderCompStageRecLcl);
                    Report.RunModal(Report::"Create Prod. Order Components", false, false);
                end;
                //Process Prod Order Routing Lines
                ProdOrderRoutingStageRecLcl.Reset();
                ProdOrderRoutingStageRecLcl.SetRange("Prod. Order No.", ProdOrderStageRecLcl."Prod. Order No.");
                ProdOrderRoutingStageRecLcl.SetRange(Processed, false);
                if ProdOrderRoutingStageRecLcl.FindFirst() then begin
                    CreateProdOrderRoutingLines.SetProdOrderNoFilter(ProdOrderRoutingStageRecLcl);
                    Report.RunModal(Report::"Create Prod. Order Rtng Lines", false, false);
                end;
            until ProdOrderStageRecLcl.Next() = 0;

    end;

    var
        CreateProdOrderComponents: Report "Create Prod. Order Components";
        CreateProdOrderRoutingLines: Report "Create Prod. Order Rtng Lines";
        CreateProdOrderLines: Report "Create Production Order Lines";
}
