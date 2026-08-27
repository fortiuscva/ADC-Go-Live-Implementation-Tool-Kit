table 77271 "ADC Go Live Critical"
{
    Caption = 'Go Live Critical';
    LookupPageId = "ADC Go Live Critical Options";
    DrillDownPageId = "ADC Go Live Critical Options";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Text[30])
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
