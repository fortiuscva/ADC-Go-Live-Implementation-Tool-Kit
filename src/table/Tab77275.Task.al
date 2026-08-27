table 77275 "ADC Task"
{
    Caption = 'Task';
    LookupPageId = "ADC Tasks";
    DrillDownPageId = "ADC Tasks";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Test Case No."; Code[20])
        {
            Caption = 'Test Case No.';
            TableRelation = "ADC Test Case Header";
            DataClassification = CustomerContent;
        }
        field(3; "Test Case Line No."; Integer)
        {
            Caption = 'Test Case Line No.';
            TableRelation = "ADC Test Case Line"."Line No.";
            DataClassification = CustomerContent;
        }
        field(4; Type; Code[20])
        {
            Caption = 'Type';
            TableRelation = "ADC Defect Type";
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[2048])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; "Assigned To"; Code[50])
        {
            Caption = 'Assigned To';
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(7; Status; Code[20])
        {
            Caption = 'Status';
            TableRelation = "ADC Defect Status";
            DataClassification = CustomerContent;
        }
        field(9; Priority; Code[20])
        {
            Caption = 'Priority';
            TableRelation = "ADC Priority";
            DataClassification = CustomerContent;
        }
        field(10; "No."; code[20])
        {
            caption = 'No.';
            DataClassification = Customercontent;
            trigger OnValidate()
            var
                GoLiveImplementationSetup: record "ADC Go Live Impl. Setup";
                NoSeries: Codeunit "No. Series";
            begin
                If "No." <> xRec."No." then begin
                    GoLiveImplementationSetup.Get();
                    NoSeries.TestManual(GoLiveImplementationSetup."Task Nos.");
                    "No.Series" := '';
                end;
            end;
        }
        field(11; "No.Series"; Code[20])
        {
            caption = 'No.Series';
            TableRelation = "No. Series";
            DataClassification = Customercontent;
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
        fieldgroup(DropDown; "Entry No.", "Test Case No.", "Test Case Line No.", Type, Description, "Assigned To", Status)
        {
        }
        fieldgroup(Brick; "Entry No.", "Test Case No.", "Test Case Line No.", Type, Description, "Assigned To", Status)
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
            GoLiveImplementationSetup.TestField("Task Nos.");

            "No.Series" := GoLiveImplementationSetup."Task Nos.";

            if NoSeries.AreRelated("No.Series", xRec."No.Series") then
                "No.Series" := xRec."No.Series";

            "No." := NoSeries.GetNextNo("No.Series");
        end;
    end;

    //     procedure AssistEdit(OldTask: Reord "adc Task"): Boolean
    //     var
    //         GoLiveImplementationSetup: Record "ADC Go Live Impl. Setup";
    //         NoSeries: Codeunit "No. Series";
    //     begin
    //         GoLiveImplementationSetup.Get();

    //         if NoSeries.LookupRelatedNoSeries(
    //             GoLiveImplementationSetup."Task Nos.",
    //             OldTask."No.Series",
    //             "No.Series")
    //         then begin
    //             "No." := NoSeries.GetNextNo("No.Series");
    //             exit(true);
    //         end;
    //     end;
}
