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
            TableRelation = "User Setup";
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
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
