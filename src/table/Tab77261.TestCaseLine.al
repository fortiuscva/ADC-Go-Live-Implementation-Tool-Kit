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
            trigger OnValidate()
            var
                TestStepHeader: Record "ADC Test Step Header";
            begin
                Commit();
                if ((Rec."Step ID" <> xRec."Step ID") and (Rec."Step ID" <> '')) then begin
                    TestStepHeader.Reset();
                    TestStepHeader.Get(Rec."Step ID");
                    Rec."Expected Result" := TestStepHeader."Expected Result";
                    Rec."Data Points" := TestStepHeader."Data Points";
                end
                else begin
                    Rec."Expected Result" := '';
                    Rec."Data Points" := '';
                end;
            end;
        }
        field(5; "Expected Result"; Text[2048])
        {
            Caption = 'Expected Result';
            DataClassification = CustomerContent;
        }
        field(6; "Actual Result"; Text[2048])
        {
            Caption = 'Actual Result';
            DataClassification = CustomerContent;
        }
        field(8; "Executed By"; Code[50])
        {
            Caption = 'Executed By';
            TableRelation = "ADC User Setup";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Executed By" <> '' then
                    TestField("Tested in Company");
            end;
        }
        field(9; "Executed Date Time"; DateTime)
        {
            Caption = 'Executed Date Time';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Executed Date Time" <> 0DT then
                    TestField("Tested in Company");
            end;
        }
        field(10; "No. of Tasks"; Integer)
        {
            Caption = 'No. of Tasks';
            FieldClass = FlowField;
            CalcFormula = count("ADC Task" where("Test Case No." = field("Document No."), "Test Case Line No." = field("Line No.")));
            Editable = false;
        }
        field(11; "Test Case Description"; Text[2048])
        {
            Caption = 'Test Case Description';
            FieldClass = FlowField;
            CalcFormula = lookup("ADC Test Case Header".Description where("No." = field("Document No.")));
            Editable = false;
        }
        field(12; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = "ADC User Setup";
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
        field(15; "Target Completion Date"; Date)
        {
            Caption = 'Target Completion Date';
            DataClassification = CustomerContent;
        }
        field(16; "Test Step Description"; Text[2048])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup("ADC Test Step Header".Description where("No." = field("Step ID")));
            Editable = false;
        }
        field(20; "Tested in Company"; Text[30])
        {
            Caption = 'Tested in Company';
            DataClassification = CustomerContent;
            TableRelation = Company.Name;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    local procedure CheckWhetherTasksExistOrNot()
    var
        TaskRecLcl: Record "ADC Task";
        CannotDeleteTestCaseLineErr: Label 'Test case line with document no. %1 and line no. %2 cannot be deleted as it is associated with one or more tasks.';
    begin
        TaskRecLcl.Reset();
        TaskRecLcl.SetRange("Test Case No.", "Document No.");
        TaskRecLcl.SetRange("Test Case Line No.", "Line No.");
        if not TaskRecLcl.IsEmpty() then
            Error(StrSubstNo(CannotDeleteTestCaseLineErr, "Document No.", "Line No."));
    end;

    // procedure SetExpectedResult(NewExpectedResult: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear("Expected Result");
    //     "Expected Result".CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(NewExpectedResult);
    // end;

    // procedure GetExpectedResult() ExpectedResult: Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     CalcFields("Expected Result");
    //     "Expected Result".CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Expected Result")));
    // end;

    // procedure SetActualResult(NewActualResult: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear("Actual Result");
    //     "Actual Result".CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(NewActualResult);
    //     Modify();
    // end;

    // procedure GetActualResult() ActualResult: Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     CalcFields("Actual Result");
    //     "Actual Result".CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Actual Result")));
    // end;

    // procedure SetTestData(NewTestData: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear("Data Points");
    //     "Data Points".CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(NewTestData);
    //     Modify();
    // end;

    // procedure GetTestData() TestData: Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     CalcFields("Data Points");
    //     "Data Points".CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Data Points")));
    // end;

}
