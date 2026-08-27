table 77258 "ADC Category"
{
    Caption = 'Category';
    LookupPageId = "ADC Categories";
    DrillDownPageId = "ADC Categories";
    DataClassification = CustomerContent;
    fields
    {
        field(1; Category; text[100])
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
        key(PK; "Category")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Category, Description)
        {
        }
        fieldgroup(Brick; Category, Description)
        {
        }
    }
}
