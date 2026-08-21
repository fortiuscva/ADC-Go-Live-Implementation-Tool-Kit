page 77281 "ADC Tasks"
{
    ApplicationArea = All;
    Caption = 'Tasks (BC Support)';
    PageType = List;
    SourceTable = "ADC Task";
    DelayedInsert = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Test Case No."; Rec."Test Case No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Test Case No. field.', Comment = '%';
                }
                field("Test Case Line No."; Rec."Test Case Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Test Case Line No. field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ToolTip = 'Specifies the value of the Assigned To field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"ADC Task"), "No." = field("Test Case No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        TestCaseLine: Record "ADC Test Case Line";
    begin
        TestCaseNo := Rec.GetFilter("Test Case No.");
        TestCaseLineNo := Rec.GetFilter("Test Case Line No.");
        if (TestCaseNo <> '') and (TestCaseLineNo <> '') then begin
            Rec.Validate("Test Case No.", TestCaseNo);
            Evaluate(Rec."Test Case Line No.", TestCaseLineNo);
        end;


    end;

    var
        TestCaseNo: Code[20];
        TestCaseLineNo: Text;
}