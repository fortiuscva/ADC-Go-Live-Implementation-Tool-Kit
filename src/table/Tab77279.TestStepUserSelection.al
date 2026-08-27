table 77279 "ADC Test Step User Selection"
{
    Caption = 'Test Step User Selection';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "ADC User Setup"."User ID";
            DataClassification = CustomerContent;
        }
        field(2; "User Group"; Code[50])
        {
            Caption = 'User Group';
            TableRelation = "ADC User Group".Code;
            DataClassification = CustomerContent;
        }
        field(3; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}
