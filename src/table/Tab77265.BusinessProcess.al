table 77265 "ADC Business Process"
{
    Caption = 'Business Process';
    DataClassification = CustomerContent;
    LookupPageId = "ADC Business Processes";
    DrillDownPageId = "ADC Business Processes";
    fields
    {
        field(1; "Code"; Text[100])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[250])
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
    }
}