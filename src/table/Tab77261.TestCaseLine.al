table 77261 "ADC Test Case Line"
{
    Caption = 'Test Case Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Data Points"; Text[2048])
        {
            Caption = 'Data Points/Test Data';
            DataClassification = CustomerContent;
        }
        field(17; "Step ID"; Code[20])
        {
            Caption = 'Step ID';
            TableRelation = "ADC Test Step Header";
            DataClassification = CustomerContent;
        }
        field(18; "Expected Result"; Text[2048])
        {
            Caption = 'Expected Result';
            DataClassification = CustomerContent;
        }
        field(19; "Actual Result"; Text[2048])
        {
            Caption = 'Actual Result';
            DataClassification = CustomerContent;
        }
        field(20; "Defect ID"; Code[20])
        {
            Caption = 'Defect ID/Link';
            DataClassification = CustomerContent;
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
