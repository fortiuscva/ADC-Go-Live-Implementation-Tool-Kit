page 77284 "ADC Test Case Lines"
{
    ApplicationArea = All;
    Caption = 'Test Case Lines';
    PageType = List;
    SourceTable = "ADC Test Case Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Case ID field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        TCHeader: Record "ADC Test Case Header";
                    begin
                        TCHeader.Reset();
                        TCHeader.Get(Rec."Document No.");
                        Page.Run(Page::"ADC Test Case", TCHeader);
                    end;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Training Session Code"; Rec."Training Session Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Session Code field.', Comment = '%';
                }
                field("Step ID"; Rec."Step ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Steps field.', Comment = '%';
                }
                field("Test Case Description"; Rec."Test Case Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Test Step Description"; Rec."Test Step Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("No. of Tasks"; Rec."No. of Tasks")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Tasks field.', Comment = '%';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned To field.', Comment = '%';
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned Date field.', Comment = '%';
                }
                field("Target Completion Date"; Rec."Target Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Completion Date field.', Comment = '%';
                }
                field("Executed By"; Rec."Executed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Executed By field.', Comment = '%';
                }
                field("Executed Date Time"; Rec."Executed Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Executed Date Time field.', Comment = '%';
                }
            }
        }
        area(FactBoxes)
        {
            part(TestSteps; "ADC Teststeps Factbox")
            {
                ApplicationArea = All;
                Caption = 'Steps';
                SubPageLink = "Document No." = field("Step ID");
            }
            part(TestCaseLines; "ADC Test Case Line Factbox")
            {
                ApplicationArea = All;
                Caption = 'Data Points & Results';
                SubPageLink = "Document No." = field("Document No."), "Line No." = field("Line No.");
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"ADC Test Case Header"), "No." = field("Document No.");
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
}
