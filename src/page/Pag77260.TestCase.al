page 77260 "ADC Test Case"
{
    ApplicationArea = All;
    Caption = 'Test Case';
    PageType = Document;
    SourceTable = "ADC Test Case";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Test Case ID"; Rec."Test Case ID")
                {
                    ToolTip = 'Specifies the value of the Test Case ID field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    ToolTip = 'Specifies the value of the Sub Category field.', Comment = '%';
                }
                field("Business Process"; Rec."Business Process")
                {
                    ToolTip = 'Specifies the value of the Business Process field.', Comment = '%';
                }
                field("Training Session Code"; Rec."Training Session Code")
                {
                    ToolTip = 'Specifies the value of the Training Session Code field.', Comment = '%';
                }
                field("UAT Owner"; Rec."UAT Owner")
                {
                    ToolTip = 'Specifies the value of the UAT Owner field.', Comment = '%';
                }
                field("Business SignOff Owner"; Rec."Business SignOff Owner")
                {
                    ToolTip = 'Specifies the value of the Business SignOff Owner field.', Comment = '%';
                }
                field("Go-Live Critical"; Rec."Go-Live Critical")
                {
                    ToolTip = 'Specifies the value of the Go-Live Critical field.', Comment = '%';
                }
                field("UAT Execution Status"; Rec."UAT Execution Status")
                {
                    ToolTip = 'Specifies the value of the UAT Execution Status field.', Comment = '%';
                }
                field("Signoff Status"; Rec."Signoff Status")
                {
                    ToolTip = 'Specifies the value of the Signoff Status field.', Comment = '%';
                }
                field("Testing Type"; Rec."Testing Type")
                {
                    ToolTip = 'Specifies the value of the Testing Type field.', Comment = '%';
                }
                field("Training Driven"; Rec."Training Driven")
                {
                    ToolTip = 'Specifies the value of the Training Driven field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }
                field("Test Scenario"; Rec."Test Scenario")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Test Scenario field.', Comment = '%';
                }
                field("Test Case Description"; Rec."Test Case Description")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Test Case Description field.', Comment = '%';
                }
                field("Test Case Reference ID"; Rec."Test Case Reference ID")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Test Case Reference ID field.', Comment = '%';
                }
            }
            part(Lines; "ADC Test Case Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Test Case ID" = field("Test Case ID");
            }
        }
    }
}
