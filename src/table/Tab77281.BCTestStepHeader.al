table 77281 "ADC BC Test Step Header"
{
    Caption = 'BC Test Step Header';
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(3; "Expected Result"; Text[2048])
        {
            Caption = 'Expected Result';
        }
        field(4; "Data Points"; Text[2048])
        {
            Caption = 'Data Points';
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
        key(PK; "No.", Description)
        {
            Clustered = true;
        }
    }
}
