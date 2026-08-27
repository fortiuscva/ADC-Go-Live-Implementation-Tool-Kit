table 77261 "ADC Test Case Line"
{
    Caption = 'Test Case Line';
    DataClassification = CustomerContent;
    DataPerCompany = false;

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
        field(4; "Step ID"; Code[20])
        {
            Caption = 'Step ID';
            TableRelation = "ADC Test Step Header";
            DataClassification = CustomerContent;
        }
        field(5; "Expected Result"; BLOB)
        {
            Caption = 'Expected Result';
            DataClassification = CustomerContent;
        }
        field(6; "Actual Result"; BLOB)
        {
            Caption = 'Actual Result';
            DataClassification = CustomerContent;
        }
        field(7; "Defect ID"; Code[20])
        {
            Caption = 'Defect ID/Link';
            DataClassification = CustomerContent;
        }
        field(8; "Executed By"; Code[50])
        {
            Caption = 'Executed By';
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(9; "Executed Date Time"; DateTime)
        {
            Caption = 'Executed Date Time';
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
    procedure SetExpectedResult(NewExpectedResult: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Expected Result");
        "Expected Result".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewExpectedResult);
        Modify();
    end;

    procedure GetExpectedResult() ExpectedResult: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Expected Result");
        "Expected Result".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Expected Result")));
    end;

    procedure SetActualResult(NewActualResult: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Actual Result");
        "Actual Result".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewActualResult);
        Modify();
    end;

    procedure GetActualResult() ActualResult: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Actual Result");
        "Actual Result".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Actual Result")));
    end;
}
