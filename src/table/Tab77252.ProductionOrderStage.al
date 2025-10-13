table 77252 "ADC Production Order Stage"
{
    Caption = 'Production Order Stage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(4; "Source Type"; Enum "Prod. Order Source Type")
        {
            Caption = 'Source Type';
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(11; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
        }
        field(20; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
        }
        field(21; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
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
        ProdOrderStageRecLcl: Record "ADC Production Order Stage";
    begin
        if ProdOrderStageRecLcl.FindLast() then
            "Entry No." := ProdOrderStageRecLcl."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}
