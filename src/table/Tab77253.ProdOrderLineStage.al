table 77253 "ADC Prod. Order Line Stage"
{
    Caption = 'Prod. Order Line Stage';
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
        field(4; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(5; "Item No."; Code[20])
        {
            Caption = ' Item No.';
        }
        field(6; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(9; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(11; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
        }
        field(12; "Production BOM Version Code"; Code[20])
        {
            Caption = 'Production BOM Version Code';
        }

        field(13; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
        }
        field(15; "Routing Version Code"; Code[20])
        {
            Caption = 'Routing Version Code';
        }
        field(14; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(16; "Error Text"; Text[250])
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
        ProdOrderLineStageRecLcl: Record "ADC Prod. Order Line Stage";
    begin
        if ProdOrderLineStageRecLcl.FindLast() then
            "Entry No." := ProdOrderLineStageRecLcl."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}
