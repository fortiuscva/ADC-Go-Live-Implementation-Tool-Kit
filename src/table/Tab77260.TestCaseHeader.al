table 77260 "ADC Test Case Header"
{
    Caption = 'Testcase Header';
    DataCaptionFields = "No.", Description;
    LookupPageId = "ADC Test Cases";
    DrillDownPageId = "ADC Test Cases";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GoLiveImplementationSetup: Record "ADC Go Live Impl. Setup";
                NoSeries: Codeunit "No. Series";
            begin
                // if "No." <> xRec."No." then begin
                //     GoLiveImplementationSetup.Get();
                //     NoSeries.TestManual(GoLiveImplementationSetup."Test Case Nos.");
                //     "No. Series" := '';
                // end;
            end;
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
            trigger OnLookup()
            var
                DetailedTrainingPlan: Record "ADC Detailed Traning Plan";
            begin
                DetailedTrainingPlan.Reset();
                DetailedTrainingPlan.SetFilter("Training Session Code", '<>%1', '');
                if Page.RunModal(Page::"ADC Detailed Training Plan", DetailedTrainingPlan) = Action::LookupOK then
                    Rec."Training Session Code" := DetailedTrainingPlan."Training Session Code";
                CalcFields("Training Category Code");
            end;

            trigger OnValidate()
            begin
                CalcFields("Training Category Code");
            end;
        }
        field(6; "UAT Owner SignOff"; code[50])
        {
            Caption = 'UAT Owner Sign Off';
            TableRelation = "ADC User Setup";
            DataClassification = CustomerContent;
        }
        field(7; "Business Owner SignOff"; Code[50])
        {
            Caption = 'Business Owner Sign Off';
            TableRelation = "ADC User Setup";
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
            Caption = 'Sign Off Status';
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
        field(16; Description; Text[2048])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(20; "Test Case Reference ID"; BLOB)
        {
            Caption = 'Test Case Reference ID';
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(30; "Task No"; Code[20])
        {
            Caption = 'Task No.';
            DataClassification = CustomerContent;
            TableRelation = "ADC Task";
        }
        field(31; "Training Category Code"; Code[20])
        {
            Caption = 'Training Category Code';
            FieldClass = FlowField;
            CalcFormula = lookup("ADC Detailed Traning Plan".Category where("Training Session Code" = field("Training Session Code")));
            Editable = false;
        }
        field(32; "No. Of Attached Test Steps"; Integer)
        {
            Caption = 'No. Of Attached Test Steps';
            CalcFormula = count("ADC Test Step Header" where("Default Test Case No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description)
        {
        }
        fieldgroup(Brick; "No.", Description)
        {
        }
    }
    trigger OnInsert()
    var
        GoLiveImplementationSetup: Record "ADC Go Live Impl. Setup";
        NoSeries: Codeunit "No. Series";
        TestCaseHeader: Record "ADC Test Case Header";
        NewTestCaseNo: Code[20];
    begin
        // if "No." = '' then begin
        //     GoLiveImplementationSetup.Get();
        //     if not GoLiveImplementationSetup."Use Manual Nos." then begin
        //         GoLiveImplementationSetup.TestField("Test Case Nos.");

        //         "No. Series" := GoLiveImplementationSetup."Test Case Nos.";

        //         if NoSeries.AreRelated("No. Series", xRec."No. Series") then
        //             "No. Series" := xRec."No. Series";

        //         "No." := NoSeries.GetNextNo("No. Series");
        //     end;
        // end;
        GoLiveImplementationSetup.Get();
        GoLiveImplementationSetup.TestField("Last Test Case No.");
        NewTestCaseNo := IncStr(GoLiveImplementationSetup."Last Test Case No.");
        GoLiveImplementationSetup."Last Test Case No." := NewTestCaseNo;
        GoLiveImplementationSetup.Modify();
        "No." := NewTestCaseNo;
        TestField("No.");
    end;

    trigger OnDelete()
    var
        TestCaseLine: Record "ADC Test Case Line";
    begin
        CheckWhetherTasksExistOrNot();
        TestCaseLine.Reset();
        TestCaseLine.SetRange("Document No.", "No.");
        TestCaseLine.DeleteAll(true);
    end;

    procedure AssistEdit(OldTestCaseHeader: Record "ADC Test Case Header"): Boolean
    var
        GoLiveImplementationSetup: Record "ADC Go Live Impl. Setup";
        NoSeries: Codeunit "No. Series";
    begin
        GoLiveImplementationSetup.Get();

        if NoSeries.LookupRelatedNoSeries(
            GoLiveImplementationSetup."Test Case Nos.",
            OldTestCaseHeader."No. Series",
            "No. Series")
        then begin
            "No." := NoSeries.GetNextNo("No. Series");
            exit(true);
        end;
    end;

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

    local procedure CheckWhetherTasksExistOrNot()
    var
        TaskRecLcl: Record "ADC Task";
        CannotDeleteTestCaseErr: Label 'Test Case %1 cannot be deleted as it is associated with one or more tasks.';
    begin
        TaskRecLcl.Reset();
        TaskRecLcl.SetRange("Test Case No.", "No.");
        if not TaskRecLcl.IsEmpty() then
            Error(StrSubstNo(CannotDeleteTestCaseErr, "No."));
    end;

}
