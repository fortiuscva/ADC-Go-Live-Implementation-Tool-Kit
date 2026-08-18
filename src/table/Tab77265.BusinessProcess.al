table 77265 "ADC Business Process"
{
    Caption = 'Business Process';
    LookupPageId = "ADC Business Processes";
    DrillDownPageId = "ADC Business Processes";
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