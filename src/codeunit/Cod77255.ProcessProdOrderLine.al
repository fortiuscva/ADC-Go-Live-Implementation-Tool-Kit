codeunit 77255 "ADC Process Prod. Order Line"
{
    TableNo = "ADC Prod. Order Line Stage";

    trigger OnRun()
    var
        ItemGbl: Record Item;
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        // ProcessProdOrderLines(Rec);
    end;

    [TryFunction]
    procedure ProcessProdOrderLines(var ADCProdOrderLineStage: Record "ADC Prod. Order Line Stage")
    var
        ItemGbl: Record Item;
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        ItemGbl.Get(ADCProdOrderLineStage."Item No.");
        ItemGbl.TestField("Routing No.");
        ItemGbl.TestField("Production BOM No.");
        LineNoGbl := 10000;

        ProdOrderLineRecLcl.Reset();
        ProdOrderLineRecLcl.SetRange("Prod. Order No.", ADCProdOrderLineStage."Prod. Order No.");
        if ProdOrderLineRecLcl.FindLast() then
            LineNoGbl := ProdOrderLineRecLcl."Line No." + 10000;

        ProdOrderLineRecLcl.Init();
        ProdOrderLineRecLcl.Validate(Status, ADCProdOrderLineStage.Status::Released);
        ProdOrderLineRecLcl.Validate("Prod. Order No.", ADCProdOrderLineStage."Prod. Order No.");
        ProdOrderLineRecLcl."Line No." := LineNoGbl;
        ProdOrderLineRecLcl.Insert(true);

        ProdOrderLineRecLcl.Validate("Item No.", ADCProdOrderLineStage."Item No.");
        ProdOrderLineRecLcl.Validate(Quantity, ADCProdOrderLineStage.Quantity);
        ProdOrderLineRecLcl.Validate("Location Code", ADCProdOrderLineStage."Location Code");
        ProdOrderLineRecLcl.Validate("Variant Code", ADCProdOrderLineStage."Variant Code");
        LineNoGbl += 10000;
        ProdOrderLineRecLcl.Modify(true);
    end;

    Var
        LineNoGbl: Integer;

}
