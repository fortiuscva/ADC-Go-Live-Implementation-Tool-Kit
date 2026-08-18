table 77266 "ADC Testing Type"
{
    Caption = 'Testing Type';
    LookupPageId = "ADC Testing Types";
    DrillDownPageId = "ADC Testing Types";
    DataClassification = CustomerContent;
    DataPerCompany = false;
    fields
    {
        field(1; Code; Code[100])
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