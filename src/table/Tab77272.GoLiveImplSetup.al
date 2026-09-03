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
        field(4; "Task Nos."; Code[20])
        {
            caption = 'Task Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(10; "Last Test Case No."; Code[20])
        {
            Caption = 'Last Test Case No.';
        }
        field(11; "Last Test Step No."; Code[20])
        {
            Caption = 'Last Test Step No.';
        }
        field(12; "Last Task No."; Code[20])
        {
            Caption = 'Last Task No.';
        }
        field(13; "Test Steps Line Separator"; Enum "ADC Test Steps Line Separator")
        {
            Caption = 'Test Steps Line Separator';
            DataClassification = CustomerContent;
        }
        field(14; "Specific Separator"; text[50])
        {
            Caption = 'Specific Separator';
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
