table 77278 "ADC User Setup"
{
    Caption = 'User Setup (BC Support)';
    DrillDownPageID = "ADC User Setup";
    LookupPageID = "ADC User Setup";
    DataPerCompany = false;
    DataClassification = CustomerContent;
    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
    }
    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User ID")
        {
        }
    }
}
