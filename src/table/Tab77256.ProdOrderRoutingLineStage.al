table 77256 "Prod. Order Routing Line Stage"
{
    Caption = 'Prod. Order Routing Line Stage';
    DataClassification = ToBeClassified;

    fields
    {
        field(74; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
        }
        field(75; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(3; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
        }
        field(1; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
        }
        field(4; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
        }
        field(6; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(7; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No. ';
        }
        field(8; Type; Enum "Capacity Type")
        {
            Caption = 'Type';
        }
        field(9; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(11; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
        }
        field(12; "Flushing Method"; Enum "Flushing Method Routing")
        {
            Caption = 'Flushing Method';
        }

        field(13; "Previous Operation No."; Code[30])
        {
            Caption = 'Previous Operation No.';
        }
        field(14; "Next Operation No."; Code[30])
        {
            Caption = 'Next Operation No.';
        }
        field(15; Processed; Boolean)
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
        ProdOrderRoutingLineStageRecLcl: Record "Prod. Order Routing Line Stage";
    begin
        if ProdOrderRoutingLineStageRecLcl.FindLast() then
            "Entry No." := ProdOrderRoutingLineStageRecLcl."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}
