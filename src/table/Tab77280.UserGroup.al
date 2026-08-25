table 77280 "ADC User Group"
{
    Caption = 'User Group';
    LookupPageId = "ADC User Groups";
    DrillDownPageId = "ADC User Groups";
    DataPerCompany = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[250])
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
    fieldgroups
    {
        fieldgroup(DropDown; Code, Description)
        {
        }
        fieldgroup(Brick; Code, Description)
        {
        }
    }
}
