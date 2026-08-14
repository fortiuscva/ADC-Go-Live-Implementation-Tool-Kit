table 77266 "ADC Testing Type"
{
    Caption = 'Testing Type';
    DataClassification = CustomerContent;
    LookupPageId = "ADC Testing Types";
    DrillDownPageId = "ADC Testing Types";
    fields
    {
        field(1; "Code"; Text[100])
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
    }
}