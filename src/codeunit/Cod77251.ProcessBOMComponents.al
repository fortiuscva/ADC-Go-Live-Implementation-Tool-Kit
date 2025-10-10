codeunit 77251 "ADC Process BOM Components"
{
    Tableno = "ADC BOM Component Stage";
    trigger OnRun()
    var
        BOMComponentRecLcl: Record "BOM Component";
        ItemGbl: Record Item;
    begin
        Rec.TestField("Quantity Per");
        // ItemGbl.Get(Rec."No.");
        BOMComponentRecLcl.Reset();
        BOMComponentRecLcl.SetRange("Parent Item No.", Rec."Parent Item No.");
        if BOMComponentRecLcl.FindLast() then
            LineNoGbl := BOMComponentRecLcl."Line No." + 10000
        else
            LineNoGbl := 10000;

        BOMComponentRecLcl.Init();
        BOMComponentRecLcl.Validate("Parent Item No.", Rec."Parent Item No.");
        BOMComponentRecLcl.Validate("Line No.", LineNoGbl);
        BOMComponentRecLcl.Insert(true);

        BOMComponentRecLcl.Validate(Type, Rec.Type);
        BOMComponentRecLcl.Validate("No.", Rec."No.");
        BOMComponentRecLcl.Validate(Description, Rec.Description);
        BOMComponentRecLcl.Validate("Quantity per", Rec."Quantity Per");

        if Rec."Unit of Measure Code" <> '' then
            BOMComponentRecLcl.Validate("Unit of Measure Code", Rec."Unit of Measure Code");
        if rec."Installed in Item No." <> '' then
            BOMComponentRecLcl.Validate("Installed in Item No.", Rec."Installed in Item No.");
        BOMComponentRecLcl.Modify(true);

    end;

    var
        LineNoGbl: Integer;
}
