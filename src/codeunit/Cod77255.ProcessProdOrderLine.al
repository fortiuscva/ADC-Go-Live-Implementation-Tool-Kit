codeunit 77255 "ADC Process Prod. Order Line"
{
    TableNo = "ADC Prod. Order Line Stage";

    trigger OnRun()
    var
        ItemGbl: Record Item;
        ProdOrderLineRecLcl: Record "Prod. Order Line";
    begin
        ItemGbl.Get(Rec."Item No.");
        ItemGbl.TestField("Routing No.");
        ItemGbl.TestField("Production BOM No.");
        LineNoGbl := 10000;

        ProdOrderLineRecLcl.Reset();
        ProdOrderLineRecLcl.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        if ProdOrderLineRecLcl.FindLast() then
            LineNoGbl := ProdOrderLineRecLcl."Line No." + 10000;

        ProdOrderLineRecLcl.Init();
        ProdOrderLineRecLcl.Validate(Status, Rec.Status::Released);
        ProdOrderLineRecLcl.Validate("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLineRecLcl."Line No." := LineNoGbl;
        ProdOrderLineRecLcl.Insert(true);

        ProdOrderLineRecLcl.Validate("Item No.", Rec."Item No.");
        ProdOrderLineRecLcl.Validate(Quantity, Rec.Quantity);
        ProdOrderLineRecLcl.Validate("Location Code", Rec."Location Code");
        ProdOrderLineRecLcl.Validate("Variant Code", Rec."Variant Code");
        LineNoGbl += 10000;
        ProdOrderLineRecLcl.Modify(true);

    end;

    Var
        LineNoGbl: Integer;

}
