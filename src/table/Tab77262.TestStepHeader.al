table 77262 "ADC Test Step Header"
{
    Caption = 'Test Step Header';
    DataCaptionFields = "No.", Description;
    LookupPageId = "ADC Test Steps";
    DrillDownPageId = "ADC Test Steps";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            var
                GoLiveImplementationSetup: Record "ADC Go Live Impl. Setup";
                NoSeries: Codeunit "No. Series";
            begin
                // if "No." <> xRec."No." then begin
                //     GoLiveImplementationSetup.Get();
                //     NoSeries.TestManual(GoLiveImplementationSetup."Test Step Nos.");
                //     "No. Series" := '';
                // end;
            end;
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(3; "Expected Result"; Text[2048])
        {
            Caption = 'Expected Result';
            DataClassification = CustomerContent;
        }
        field(4; "Data Points"; Text[2048])
        {
            Caption = 'Data Points/Test Data';
            DataClassification = CustomerContent;
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(22; "Default Test Case No."; Code[20])
        {
            Caption = 'Default Test Case No.';
            DataClassification = CustomerContent;
            TableRelation = "ADC Test Case Header"."No.";
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
        NewTestStepNo: Code[20];
    begin
        // if "No." = '' then begin
        //     GoLiveImplementationSetup.Get();
        //     GoLiveImplementationSetup.TestField("Test Step Nos.");

        //     "No. Series" := GoLiveImplementationSetup."Test Step Nos.";

        //     if NoSeries.AreRelated("No. Series", xRec."No. Series") then
        //         "No. Series" := xRec."No. Series";

        //     "No." := NoSeries.GetNextNo("No. Series");
        // end;
        GoLiveImplementationSetup.Get();
        GoLiveImplementationSetup.TestField("Last Test Step No.");
        NewTestStepNo := IncStr(GoLiveImplementationSetup."Last Test Step No.");
        GoLiveImplementationSetup."Last Test Step No." := NewTestStepNo;
        GoLiveImplementationSetup.Modify();
        "No." := NewTestStepNo;
        TestField("No.");
    end;

    trigger OnDelete()
    var
        TestStepLine: Record "ADC Test Step Line";
    begin
        CheckWhetherTestCaseExists();
        TestStepLine.Reset();
        TestStepLine.SetRange("Document No.", "No.");
        TestStepLine.DeleteAll(true);
    end;

    procedure AssistEdit(OldTestStepHeader: Record "ADC Test Step Header"): Boolean
    var
        GoLiveImplementationSetup: Record "ADC Go Live Impl. Setup";
        NoSeries: Codeunit "No. Series";
    begin
        GoLiveImplementationSetup.Get();

        if NoSeries.LookupRelatedNoSeries(
            GoLiveImplementationSetup."Test Step Nos.",
            OldTestStepHeader."No. Series",
            "No. Series")
        then begin
            "No." := NoSeries.GetNextNo("No. Series");
            exit(true);
        end;
    end;

    local procedure CheckWhetherTestCaseExists()
    var
        TestCaseLineRecGbl: Record "ADC Test Case Line";
        CannotDeleteTestStepErr: Label 'Test Step %1 cannot be deleted as it is associated with one or more test cases';
    begin
        TestCaseLineRecGbl.Reset();
        TestCaseLineRecGbl.SetRange("Step ID", "No.");
        if not TestCaseLineRecGbl.IsEmpty() then
            Error(StrSubstNo(CannotDeleteTestStepErr, "No."));
    end;
}
