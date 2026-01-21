table 77255 "ADC Prod. Order Import Stage"
{
    Caption = 'Prod. Order Import Stage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(6; "Line Item No."; Code[20])
        {
            Caption = 'Line Item No.';
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(9; "Component Item No."; Code[20])
        {
            Caption = 'Component Item No.';
        }
        field(10; "Component Line No."; Integer)
        {
            Caption = 'Component Line No.';
        }
        field(11; "Component Quantity"; Decimal)
        {
            Caption = 'Component Quantity';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
