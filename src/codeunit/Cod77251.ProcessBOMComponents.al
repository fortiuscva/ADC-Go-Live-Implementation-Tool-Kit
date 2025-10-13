codeunit 77251 "ADC Process BOM Components"
{
    Tableno = "ADC Assembly BOM Import Stage";
    trigger OnRun()
    var
    begin
        BOMCompStatingRecGbl.Reset();
        BOMCompStatingRecGbl.CopyFilters(Rec);
        if BOMCompStatingRecGbl.FindSet() then
            repeat
                LineNoGbl := 10000;
                BOMComponentRecGbl.Reset();
                BOMComponentRecGbl.SetRange("Parent Item No.", BOMCompStatingRecGbl."Parent Item No.");
                if BOMComponentRecGbl.FindLast() then
                    LineNoGbl := BOMComponentRecGbl."Line No." + 10000;

                BOMComponentRecGbl.Init();
                BOMComponentRecGbl.Validate("Parent Item No.", BOMCompStatingRecGbl."Parent Item No.");
                BOMComponentRecGbl.Validate("Line No.", LineNoGbl);
                BOMComponentRecGbl.Insert(true);

                BOMComponentRecGbl.Validate(Type, BOMCompStatingRecGbl.Type);
                BOMComponentRecGbl.Validate("No.", BOMCompStatingRecGbl."No.");
                BOMComponentRecGbl.Validate(Description, BOMCompStatingRecGbl.Description);
                BOMComponentRecGbl.Validate("Quantity per", BOMCompStatingRecGbl."Quantity Per");
                if BOMCompStatingRecGbl."Unit of Measure Code" <> '' then
                    BOMComponentRecGbl.Validate("Unit of Measure Code", BOMCompStatingRecGbl."Unit of Measure Code");
                if BOMCompStatingRecGbl."Installed in Item No." <> '' then
                    BOMComponentRecGbl.Validate("Installed in Item No.", BOMCompStatingRecGbl."Installed in Item No.");
                BOMComponentRecGbl.Modify(true);
                LineNoGbl += 10000;
            until BOMComponentRecGbl.Next() = 0;
    end;

    var
        LineNoGbl: Integer;
        BOMCompStatingRecGbl: Record "ADC Assembly BOM Import Stage";
        BOMComponentRecGbl: Record "BOM Component";
        ItemGbl: Record Item;

}
