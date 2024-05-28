table 77250 "ADC Item Journal Line Stage"
{
    Caption = 'Item Journal Line Stage';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(3; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(4; UOM; Code[20])
        {
            Caption = 'UOM';
            DataClassification = CustomerContent;
        }
        field(5; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(6; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
        }
        field(7; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(8; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(9; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            DataClassification = CustomerContent;
        }
        field(100; Processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
        }
        field(110; "Error Text"; Text[250])
        {
            Caption = 'Error Text';
            DataClassification = CustomerContent;
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
