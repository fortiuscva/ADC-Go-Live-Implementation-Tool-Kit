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
        ItemGbl.Get(Rec."Source No.");
        ItemGbl.TestField("Routing No.");
        ItemGbl.TestField("Production BOM No.");


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

        //Process Prod order Line
        ProdOrderLineStageRecLcl.Reset();
        ProdOrderLineStageRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        if ProdOrderLineStageRecLcl.FindFirst() then begin
            Report.RunModal(Report::"Create Production Order Lines", false, false, ProdOrderLineStageRecLcl);
        end;

        //Process Prod Order Components
        ProdOrderCompStageRecLcl.Reset();
        ProdOrderCompStageRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        if ProdOrderCompStageRecLcl.FindFirst() then begin
            Report.RunModal(Report::"Create Prod. Order Components", false, false, ProdOrderCompStageRecLcl);
        end;
        //Process Prod Order Routing Lines
        ProdOrderRoutingStageRecLcl.Reset();
        ProdOrderRoutingStageRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        if ProdOrderRoutingStageRecLcl.FindFirst() then begin
            Report.RunModal(Report::"Create Prod. Order Rtng Lines", false, false, ProdOrderRoutingStageRecLcl);
        end;

    end;
}
