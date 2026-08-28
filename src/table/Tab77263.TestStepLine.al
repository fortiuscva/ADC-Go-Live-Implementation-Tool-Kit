table 77263 "ADC Test Step Line"
{
    Caption = 'Test Step Line';
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Test Step Description"; Text[2048])
        {
            Caption = 'Test Step Description';
        }
        field(4; Description; Text[2048])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("ADC Test Step Header".Description where("No." = field("Document No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
