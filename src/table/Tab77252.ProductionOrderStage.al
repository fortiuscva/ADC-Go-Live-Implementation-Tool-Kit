table 77252 "ADC Production Order Stage"
{
    Caption = 'Production Order Stage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }

        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(5; "Source Type"; Enum "Prod. Order Source Type")
        {
            Caption = 'Source Type';
        }
        field(6; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(7; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(11; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
        }
        field(13; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(14; "Error Text"; Text[250])
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
        ProdOrderStageRecLcl: Record "ADC Production Order Stage";
    begin
        if ProdOrderStageRecLcl.FindLast() then
            "Entry No." := ProdOrderStageRecLcl."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}
