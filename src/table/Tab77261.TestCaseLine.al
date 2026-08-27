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
        field(3; "Data Points"; BLOB)
        {
            Caption = 'Data Points/Test Data';
            DataClassification = CustomerContent;
        }
        field(4; "Step ID"; Code[20])
        {
            Caption = 'Step ID';
            TableRelation = "ADC Test Step Header";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TestStepHeader: Record "ADC Test Step Header";
            begin
                Commit();
                if ((Rec."Step ID" <> xRec."Step ID") and (Rec."Step ID" <> '')) then begin
                    TestStepHeader.Reset();
                    TestStepHeader.Get(Rec."Step ID");
                    Rec.SetExpectedResult(TestStepHeader."Expected Result");
                end
                else
                    Rec.SetExpectedResult('');
            end;
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
        field(10; "No. of Tasks"; Integer)
        {
            Caption = 'No. of Tasks';
            FieldClass = FlowField;
            CalcFormula = count("ADC Task" where("Test Case No." = field("Document No."), "Test Case Line No." = field("Line No.")));
            Editable = false;
        }
        field(11; "Header Description"; Text[2048])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("ADC Test Case Header".Description where("No." = field("Document No.")));
            Editable = false;
        }
        field(12; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(13; "Assigned Date"; Date)
        {
            Caption = 'Assigned Date';
            DataClassification = CustomerContent;
        }
        field(14; "Training Session Code"; Code[20])
        {
            Caption = 'Training Session Code';
            FieldClass = FlowField;
            CalcFormula = lookup("ADC Test Case Header"."Training Session Code" where("No." = field("Document No.")));
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
    procedure SetExpectedResult(NewExpectedResult: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Expected Result");
        "Expected Result".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewExpectedResult);
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

    procedure SetTestData(NewTestData: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Data Points");
        "Data Points".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewTestData);
        Modify();
    end;

    procedure GetTestData() TestData: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Data Points");
        "Data Points".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Data Points")));
    end;

}
