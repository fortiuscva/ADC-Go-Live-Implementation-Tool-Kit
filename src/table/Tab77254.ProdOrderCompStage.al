table 77254 "ADC Prod. Order Comp. Stage"
{
    Caption = 'Prod. Order Component Stage';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
        }
        field(4; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
        }
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(10; "Prod. Order Line Item No."; Code[20])
        {
            Caption = 'Prod. Order Line Item No.';
        }
        field(11; "Comp. Item No."; Code[20])
        {
            Caption = 'Comp. Item No.';
        }
        field(12; "Quantity Per"; Decimal)
        {
            Caption = 'Quantity Per';
        }
        field(13; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(14; "Flushing Method"; Enum "Flushing Method")
        {
            Caption = 'Flushing Method';
        }
        field(15; "Expected Quantity"; Decimal)
        {
            Caption = 'Expected Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
        }
        field(17; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(18; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }
        field(19; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(20; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        ProdOrderCompStageRecLcl: Record "ADC Prod. Order Comp. Stage";
    begin
        if ProdOrderCompStageRecLcl.FindLast() then
            "Entry No." := ProdOrderCompStageRecLcl."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}
