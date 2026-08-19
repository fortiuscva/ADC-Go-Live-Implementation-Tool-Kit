table 77272 "ADC Go Live Impl. Setup"
{
    Caption = 'Go-Live Implementation Setup';
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Test Case Nos."; Code[20])
        {
            Caption = 'Test Case Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(3; "Test Step Nos."; Code[20])
        {
            Caption = 'Test Step Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
