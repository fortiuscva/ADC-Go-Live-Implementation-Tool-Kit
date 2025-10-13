table 77253 "ADC Prod. Order Line Stage"
{
    Caption = 'Prod. Order Line Stage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(3; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
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
        field(9; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(10; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(11; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
        }
        field(12; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(13; "Error Text"; Text[250])
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
