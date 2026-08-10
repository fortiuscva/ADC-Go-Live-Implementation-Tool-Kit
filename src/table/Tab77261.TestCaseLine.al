table 77261 "ADC Test Case Line"
{
    Caption = 'Test Case Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Test Case ID"; Code[20])
        {
            Caption = 'Test Case ID';
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
        field(17; "Test Steps"; Text[2048])
        {
            Caption = 'Test Steps';
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
    }
    keys
    {
        key(PK; "Test Case ID", "Line No.")
        {
            Clustered = true;
        }
    }
}
