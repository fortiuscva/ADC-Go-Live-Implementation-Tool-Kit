page 77259 "ADC Test Cases"
{
    ApplicationArea = All;
    Caption = 'Test Cases';
    PageType = List;
    SourceTable = "ADC Test Case Header";
    CardPageId = "ADC Test Case";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Test Case ID"; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Case ID field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("No. Of Test Steps"; Rec."No. Of Attached Test Steps")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Of Test Steps field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field("Sub Category"; Rec."Sub Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub Category field.', Comment = '%';
                }
                field("Business Process"; Rec."Business Process")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Process field.', Comment = '%';
                }
                field("Training Category Code"; Rec."Training Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Category field.', Comment = '%';
                }
                field("Training Session Code"; Rec."Training Session Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Session Code field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        DetailedTrainingPlanRecLcl: Record "ADC Detailed Traning Plan";
                    begin
                        DetailedTrainingPlanRecLcl.Reset();
                        DetailedTrainingPlanRecLcl.SetRange("Training Session Code", Rec."Training Session Code");
                        Page.Run(Page::"ADC Detailed Training Plan", DetailedTrainingPlanRecLcl);
                    end;
                }
                field("UAT Owner"; Rec."UAT Owner SignOff")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UAT Owner field.', Comment = '%';
                }
                field("Business SignOff Owner"; Rec."Business Owner SignOff")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business SignOff Owner field.', Comment = '%';
                }
                field("Go-Live Critical"; Rec."Go-Live Critical")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Go-Live Critical field.', Comment = '%';
                }
                field("UAT Execution Status"; Rec."UAT Execution Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UAT Execution Status field.', Comment = '%';
                }
                field("Signoff Status"; Rec."Signoff Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signoff Status field.', Comment = '%';
                }
                field("Testing Type"; Rec."Testing Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Testing Type field.', Comment = '%';
                }
                field("Training Driven"; Rec."Training Driven")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Driven field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }
                field("Task No"; Rec."Task No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task No. field.', Comment = '%';
                }
                field("Test Scenario"; Rec."Test Scenario")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Scenario field.', Comment = '%';
                    Visible = false;
                }
                field("Test Case Description"; Rec."Test Case Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Case Description field.', Comment = '%';
                    Visible = false;
                }
                field("Test Case Reference ID"; Rec."Test Case Reference ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Case Reference ID field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }
}
