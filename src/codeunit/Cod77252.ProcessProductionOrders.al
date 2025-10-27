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
        ProcessProdOrderLineCU: Codeunit "ADC Process Prod. Order Line";
        ProcessProdOrderComponents: Codeunit "Process Prod. Order Components";
        ProcessProdOrderRoutingLines: Codeunit "Process Prod.  OrderRtng Lines";
    begin
        ItemGbl.Get(Rec."Source No.");
        ItemGbl.TestField("Routing No.");
        ItemGbl.TestField("Production BOM No.");

        if not ProdOrderRecLcl.Get(Rec."Prod. Order No.") then begin
            ProdOrderRecLcl.Init();
            ProdOrderRecLcl.Validate("No.", Rec."Prod. Order No.");
            ProdOrderRecLcl.Validate(Status, Rec.Status::Released);
            ProdOrderRecLcl.Insert(true);

            ProdOrderRecLcl.Validate("Source Type", Rec."Source Type"::Item);
            ProdOrderRecLcl.Validate("Source No.", Rec."Source No.");
            ProdOrderRecLcl.Validate(Quantity, Rec.Quantity);
            ProdOrderRecLcl.Validate("Location Code", Rec."Location Code");
            ProdOrderRecLcl.Validate("Bin Code", Rec."Bin Code");
            ProdOrderRecLcl.Validate("Variant Code", Rec."Variant Code");
            ProdOrderRecLcl.Modify(true);
        end;

        //Process Prod order Line
        ProdOrderLineStageRecLcl.Reset();
        ProdOrderLineStageRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLineStageRecLcl.SetRange(Processed, false);
        if ProdOrderLineStageRecLcl.FindSet() then begin
            repeat
                ProcessProdOrderLineCU.Run(ProdOrderLineStageRecLcl);
            until ProdOrderLineStageRecLcl.Next() = 0;
        end;

        //Process Prod Order Components
        ProdOrderCompStageRecLcl.Reset();
        ProdOrderCompStageRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderCompStageRecLcl.SetRange(Processed, false);
        if ProdOrderCompStageRecLcl.FindSet() then begin
            repeat
                ProcessProdOrderComponents.Run(ProdOrderCompStageRecLcl);
            until ProdOrderCompStageRecLcl.Next() = 0;
        end;

        //Process Prod Order Routing Lines
        ProdOrderRoutingStageRecLcl.Reset();
        ProdOrderRoutingStageRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderRoutingStageRecLcl.SetRange(Processed, false);
        if ProdOrderRoutingStageRecLcl.FindSet() then begin
            repeat
                ProcessProdOrderRoutingLines.Run(ProdOrderRoutingStageRecLcl);
            until ProdOrderRoutingStageRecLcl.Next() = 0;
        end;
    end;
}
