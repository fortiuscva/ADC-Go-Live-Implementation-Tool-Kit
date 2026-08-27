table 77270 "ADC Priority"
{
    Caption = 'Priority';
    LookupPageId = "ADC Priority Options";
    DrillDownPageId = "ADC Priority Options";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; Code; Code[100])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
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
