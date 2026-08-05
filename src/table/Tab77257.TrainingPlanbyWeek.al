table 77257 "ADC Training Plan by Week"
{
    Caption = 'Training Plan by Week';
    LookupPageId = "ADC Training Plan by Week";
    DrillDownPageId = "ADC Training Plan by Week";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; Week; Integer)
        {
            Caption = 'Week';
            DataClassification = CustomerContent;
        }
        field(3; Details; Text[2048])
        {
            Caption = 'Details';
            DataClassification = CustomerContent;
        }
        field(4; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            // TableRelation = "ADC Category";
            DataClassification = CustomerContent;
        }
        field(5; Hours; Decimal)
        {
            Caption = 'Hours';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
        field(6; "Running Hours"; Decimal)
        {
            Caption = 'Running Hours';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
        field(7; "No. of Sessions"; Integer)
        {
            Caption = 'No. of Sessions';
            DataClassification = CustomerContent;
        }
        field(8; "Session Length"; Decimal)
        {
            Caption = 'Session Length';
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
        field(9; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(10; "Business Owner"; Text[50])
        {
            Caption = 'Business Owner';
            // TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(11; "Business Technical Owner"; Text[50])
        {
            Caption = 'Business Technical Owner';
            // TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(12; Trainer; Text[50])
        {
            Caption = 'Trainer';
            // TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(13; "Comments or Assumptions"; Text[2048])
        {
            Caption = 'Comments or Assumptions';
            DataClassification = CustomerContent;
        }
        field(14; "UAT Testcases"; Integer)
        {
            Caption = 'UAT Testcases';
            DataClassification = CustomerContent;
        }
        field(15; "Target Audience"; Text[250])
        {
            Caption = 'Target Audience';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
