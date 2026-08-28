table 77282 "ADC BC Test Step Line"
{
    Caption = 'BC Test Step Line';
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(4; "Test Step Description"; Text[2048])
        {
            Caption = 'Test Step Description';
        }
        field(5; "BC Test Case No."; Code[20])
        {
            Caption = 'BC Test Case No.';
        }
        field(6; "BC Test Step No."; Code[20])
        {
            Caption = 'BC Test Step No.';
        }
    }
    keys
    {
        key(PK; "No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}
