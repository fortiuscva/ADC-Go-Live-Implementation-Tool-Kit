table 77264 "ADC Subcategory"
{
    Caption = 'Subcategory';
    DataClassification = CustomerContent;
    LookupPageId = Subcategories;
    DrillDownPageId = Subcategories;

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
    }

}
