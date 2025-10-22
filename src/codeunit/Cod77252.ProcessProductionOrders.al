codeunit 77252 "ADC Process Production Orders"
{
    TableNo = "ADC Production Order Stage";

    trigger OnRun()
    var
        ItemGbl: Record Item;
        ProdOrderRecLcl: Record "Production Order";
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
    end;

}
