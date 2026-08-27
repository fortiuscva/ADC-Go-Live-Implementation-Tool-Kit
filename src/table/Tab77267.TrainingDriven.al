table 77267 "ADC Training Driven"
{
    Caption = 'Training Driven';
    LookupPageId = "ADC Training Driven Options";
    DrillDownPageId = "ADC Training Driven Options";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; Code; Code[100])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[2048])
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
