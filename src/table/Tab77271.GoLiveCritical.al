table 77271 "ADC Go Live Critical"
{
    Caption = 'Go Live Critical';
    LookupPageId = "ADC Go Live Critical Options";
    DrillDownPageId = "ADC Go Live Critical Options";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Code)
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
