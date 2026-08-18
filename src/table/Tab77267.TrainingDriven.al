table 77267 "ADC Training Driven"
{
    Caption = 'Training Driven';
    LookupPageId = "ADC Training Driven Options";
    DrillDownPageId = "ADC Training Driven Options";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Text[30])
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
