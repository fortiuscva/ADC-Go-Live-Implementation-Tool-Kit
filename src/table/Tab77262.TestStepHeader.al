table 77262 "ADC Test Step Header"
{
    Caption = 'Test Step Header';
    LookupPageId = "ADC Test Steps";
    DrillDownPageId = "ADC Test Steps";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
