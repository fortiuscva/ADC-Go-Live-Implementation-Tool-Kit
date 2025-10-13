table 77254 "ADC Prod. Order Comp. Stage"
{
    Caption = 'Prod. Order Component Stage';
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
        field(4; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Quantity Per"; Decimal)
        {
            Caption = 'Quantity Per';
        }
        field(9; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
        }
        field(11; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
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
        ProdOrderCompStageRecLcl: Record "ADC Prod. Order Comp. Stage";
    begin
        if ProdOrderCompStageRecLcl.FindLast() then
            "Entry No." := ProdOrderCompStageRecLcl."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}
