table 77260 "ADC Test Case"
{
    Caption = 'Testcase Header';
    LookupPageId = "ADC Test Cases";
    DrillDownPageId = "ADC Test Cases";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Test Case ID"; Code[20])
        {
            Caption = 'Test Case ID';
        }
        field(2; Category; Text[100])
        {
            Caption = 'Category';
        }
        field(3; "Sub Category"; Text[100])
        {
            Caption = 'Sub Category';
        }
        field(4; "Business Process"; Text[100])
        {
            Caption = 'Business Process';
        }
        field(5; "Training Session Code"; Text[100])
        {
            Caption = 'Training Session Code';
        }
        field(6; "UAT Owner"; Text[100])
        {
            Caption = 'UAT Owner';
        }
        field(7; "Business SignOff Owner"; Text[100])
        {
            Caption = 'Business SignOff Owner';
        }
        field(8; "Go-Live Critical"; Text[30])
        {
            Caption = 'Go-Live Critical';
        }
        field(9; "UAT Execution Status"; Text[30])
        {
            Caption = 'UAT Execution Status';
        }
        field(10; "Signoff Status"; Text[100])
        {
            Caption = 'Signoff Status';
        }
        field(11; "Testing Type"; Text[30])
        {
            Caption = 'Testing Type';
        }
        field(12; "Training Driven"; Text[30])
        {
            Caption = 'Training Driven';
        }
        field(13; Priority; Text[30])
        {
            Caption = 'Priority';
        }
        field(14; "Test Scenario"; Text[256])
        {
            Caption = 'Test Scenario';
        }
        field(15; "Test Case Description"; Text[2048])
        {
            Caption = 'Test Case Description';
        }
        field(20; "Test Case Reference ID"; Text[2048])
        {
            Caption = 'Test Case Reference ID';
        }
    }
    keys
    {
        key(PK; "Test Case ID")
        {
            Clustered = true;
        }
    }
}
