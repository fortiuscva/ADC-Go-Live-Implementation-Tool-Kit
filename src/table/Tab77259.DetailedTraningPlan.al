table 77259 "ADC Detailed Traning Plan"
{
    Caption = 'Detailed Traning Plan';
    LookupPageId = "ADC Detailed Training Plan";
    DrillDownPageId = "ADC Detailed Training Plan";
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; Category; Code[20])
        {
            Caption = 'Category';
            TableRelation = "ADC Category Code";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if ((Rec.Category <> xRec.Category) and (Rec.Category <> '')) then
                    "Training Session Code" := Category + '_' + Format(Sequence)
                else
                    "Training Session Code" := '';
            end;
        }
        field(3; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if Rec.Sequence <> xRec.Sequence then
                    "Training Session Code" := Category + '_' + Format(Sequence);
            end;
        }
        field(4; "Training Session Code"; Code[30])
        {
            Caption = 'Training Session Code';
            DataClassification = CustomerContent;
        }
        field(5; "Training Topic"; Text[2048])
        {
            Caption = 'Training Topic';
            DataClassification = CustomerContent;
        }
        field(6; Length; Integer)
        {
            Caption = 'Length';
            DataClassification = CustomerContent;
        }
        field(7; Running; Integer)
        {
            Caption = 'Running';
            DataClassification = CustomerContent;
        }
        field(8; "Company Applicability"; Text[30])
        {
            Caption = 'Company Applicability';
            DataClassification = CustomerContent;
        }
        field(9; "Business Scenario"; Text[2048])
        {
            Caption = 'Business Scenario';
            DataClassification = CustomerContent;
        }
        field(10; "Business User"; Code[50])
        {
            Caption = 'Business User';
            TableRelation = "ADC User Setup";
            DataClassification = CustomerContent;
        }
        field(11; "Training Completion Status"; Text[30])
        {
            Caption = 'Training Completion Status';
            TableRelation = "ADC Training Completion Status";
            DataClassification = CustomerContent;
        }
        field(12; "Training Completion Date"; Date)
        {
            Caption = 'Training Completion Date';
            DataClassification = CustomerContent;
        }
        field(13; "Learning Link"; Text[250])
        {
            Caption = 'Learning Link';
            DataClassification = CustomerContent;
        }
        field(14; "Learning Notes"; Text[2048])
        {
            Caption = 'Learning Notes';
            DataClassification = CustomerContent;
        }
        field(15; "Training Scheduled Date"; Date)
        {
            Caption = 'Training Scheduled Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    begin
        if (Rec."Training Session Code" <> xRec."Training Session Code") AND (xRec."Training Session Code" <> '') then
            CheckWhetherTestCaseExists(xRec."Training Session Code", false);
    end;

    trigger OnDelete()
    begin
        CheckWhetherTestCaseExists(xRec."Training Session Code", true);
    end;

    local procedure CheckWhetherTestCaseExists(TrainingSessionCodePar: Code[30]; OnDelete: Boolean): Boolean
    begin
        TestCaseHeaderRecGbl.Reset();
        TestCaseHeaderRecGbl.SetRange("Training Session Code", TrainingSessionCodePar);
        if not TestCaseHeaderRecGbl.IsEmpty() then
            if not OnDelete then
                Error(StrSubstNo(CannotChangeTrainingSessionCodeErr, TrainingSessionCodePar))
            else
                Error(StrSubstNo(CannotDeleteErr, TrainingSessionCodePar));
        exit(false);
    end;

    var
        TestCaseHeaderRecGbl: Record "ADC Test Case Header";
        CannotModifyErr: Label 'Detailed training plan with training session code %1 cannot be changed as it is associated with one or more test cases.';
        CannotChangeTrainingSessionCodeErr: Label 'Training session code %1 cannot be changed as it is associated with one or more test cases.';
        CannotDeleteErr: Label 'Detailed training plan with training session code %1 cannot be deleted as it is associated with one or more test cases.';
}
