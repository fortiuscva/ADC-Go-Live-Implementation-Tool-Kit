table 77266 "ADC Testing Type"
{
    Caption = 'Testing Type';
    LookupPageId = "ADC Testing Types";
    DrillDownPageId = "ADC Testing Types";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Text[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
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