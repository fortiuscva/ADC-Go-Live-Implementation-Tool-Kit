table 77281 "ADC Item Jounral posting Log"
{
    Caption = 'Item Journal Posting Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }

        field(2; "Journal Name"; Code[10])
        {
            Caption = 'Journal Name';
        }

        field(3; "Batch Name"; Code[10])
        {
            Caption = 'Batch Name';
        }

        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }

        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }

        field(7; "Error Msg"; Text[2048])
        {
            Caption = 'Error Message';
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