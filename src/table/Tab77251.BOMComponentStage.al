table 77251 "ADC BOM Component Stage"
{
    Caption = 'BOM Component Stage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Parent Item No."; Code[20])
        {
            Caption = 'Parent Item No.';
            TableRelation = Item."No.";
            ValidateTableRelation = false;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Type; Enum "BOM Component Type")
        {
            Caption = 'Type';
        }
        field(5; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(6; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(7; "Quantity Per"; Decimal)
        {
            Caption = 'Quantity Per';
        }
        field(8; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(9; "Installed in Item No."; Code[20])
        {
            Caption = 'Installed in Item No.';
        }
        field(10; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(11; "Error Text"; Text[250])
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
}
