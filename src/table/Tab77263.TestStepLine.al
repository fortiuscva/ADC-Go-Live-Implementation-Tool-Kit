table 77263 "ADC Test Step Line"
{
    Caption = 'Test Step Line';
    DataClassification = CustomerContent;
    DataPerCompany = false;
    DrillDownPageId = "ADC Test Step Lines";
    LookupPageId = "ADC Test Step Lines";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Test Step Description"; Text[2048])
        {
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
