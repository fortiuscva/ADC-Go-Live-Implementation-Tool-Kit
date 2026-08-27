table 77269 "ADC Signoff Status"
{
    Caption = 'Signoff Status';
    LookupPageId = "ADC Signoff Status";
    DrillDownPageId = "ADC Signoff Status";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Text[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
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
