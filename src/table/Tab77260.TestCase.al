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
            DataClassification = CustomerContent;
        }
        field(2; Category; Code[100])
        {
            Caption = 'Category';
            TableRelation = "ADC Category";
            DataClassification = CustomerContent;
        }
        field(3; "Sub Category"; Code[100])
        {
            Caption = 'Sub Category';
            TableRelation = "ADC Subcategory";
            DataClassification = CustomerContent;
        }
        field(4; "Business Process"; Code[100])
        {
            Caption = 'Business Process';
            TableRelation = "ADC Business Process";
            DataClassification = CustomerContent;
        }
        field(5; "Training Session Code"; code[20])
        {
            Caption = 'Training Session Code';
            DataClassification = CustomerContent;
        }
        field(6; "UAT Owner"; code[20])
        {
            Caption = 'UAT Owner';
            DataClassification = CustomerContent;
        }
        field(7; "Business SignOff Owner"; text[100])
        {
            Caption = 'Business SignOff Owner';
            DataClassification = CustomerContent;
        }
        field(8; "Go-Live Critical"; code[100])
        {
            Caption = 'Go-Live Critical';
            TableRelation = "ADC Go Live Critical";
            DataClassification = CustomerContent;
        }
        field(9; "UAT Execution Status"; code[100])
        {
            Caption = 'UAT Execution Status';
            TableRelation = "ADC UAT Execution Status";
            DataClassification = CustomerContent;
        }
        field(10; "Signoff Status"; Code[100])
        {
            Caption = 'Signoff Status';
            TableRelation = "ADC Signoff Status";
            DataClassification = CustomerContent;
        }
        field(11; "Testing Type"; code[100])
        {
            Caption = 'Testing Type';
            TableRelation = "ADC Testing Type";
            DataClassification = CustomerContent;
        }
        field(12; "Training Driven"; code[100])
        {
            Caption = 'Training Driven';
            TableRelation = "ADC Training Driven";
            DataClassification = CustomerContent;
        }
        field(13; Priority; code[100])
        {
            Caption = 'Priority';
            TableRelation = "ADC Priority";
            DataClassification = CustomerContent;
        }
        field(14; "Test Scenario"; BLOB)
        {
            Caption = 'Test Scenario';
        }
        field(15; "Test Case Description"; BLOB)
        {
            Caption = 'Test Case Description';
        }
        field(20; "Test Case Reference ID"; BLOB)
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
    procedure SetTestCaseDescription(NewTestCaseDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Test Case Description");
        "Test Case Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewTestCaseDescription);
        Modify();
    end;

    procedure GetTestCaseDescription() TestCaseDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Test Case Description");
        "Test Case Description".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Test Case Description")));
    end;

    procedure SetTestScenario(NewTestScenario: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Test Scenario");
        "Test Scenario".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewTestScenario);
        Modify();
    end;

    procedure GetTestScenario() TestScenario: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Test Scenario");
        "Test Scenario".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Test Scenario")));
    end;

    procedure SetTestCaseReferenceID(NewTestCaseReferenceID: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Test Case Reference ID");
        "Test Case Reference ID".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewTestCaseReferenceID);
        Modify();
    end;

    procedure GetTestCaseReferenceID() TestCaseReferenceID: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Test Case Reference ID");
        "Test Case Reference ID".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Test Case Reference ID")));
    end;

}
