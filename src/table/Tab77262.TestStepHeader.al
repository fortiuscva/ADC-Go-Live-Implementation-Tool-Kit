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
                if "No." <> xRec."No." then begin
                    GoLiveImplementationSetup.Get();
                    NoSeries.TestManual(GoLiveImplementationSetup."Test Step Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
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
    begin
        if "No." = '' then begin
            GoLiveImplementationSetup.Get();
            GoLiveImplementationSetup.TestField("Test Step Nos.");

            "No. Series" := GoLiveImplementationSetup."Test Step Nos.";

            if NoSeries.AreRelated("No. Series", xRec."No. Series") then
                "No. Series" := xRec."No. Series";

            "No." := NoSeries.GetNextNo("No. Series");
        end;
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

}
