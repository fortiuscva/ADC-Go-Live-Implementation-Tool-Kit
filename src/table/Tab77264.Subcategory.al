table 77264 "ADC Subcategory"
{
    Caption = 'Subcategory';
    LookupPageId = Subcategories;
    DrillDownPageId = Subcategories;
    DataClassification = CustomerContent;


    fields
    {
        field(1; Subcategory; Text[100])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[256])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Subcategory")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Subcategory, Description)
        {
        }
        fieldgroup(Brick; Subcategory, Description)
        {
        }
    }
}
