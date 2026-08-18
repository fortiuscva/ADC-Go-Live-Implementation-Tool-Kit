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
                group("Test Scenario")
                {
                    Caption = 'Test Scenario';
                    field(TestScenario; TestScenario)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the scenario of the test case.', Comment = '%';
                        trigger OnValidate()
                        begin
                            Rec.SetTestScenario(TestScenario);
                        end;
                    }
                }
                group("Test Case Description")
                {
                    Caption = 'Test Case Description';
                    field(TestCaseDescription; TestCaseDescription)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the description of the test case.';
                        trigger OnValidate()
                        begin
                            Rec.SetTestCaseDescription(TestCaseDescription);
                        end;
                    }
                }
                group("Test Case Reference ID")
                {
                    Caption = 'Test Case Reference ID';
                    field(TestCaseReferenceID; TestCaseReferenceID)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the Reference ID/JIRA ID of the test case.';
                        trigger OnValidate()
                        begin
                            Rec.SetTestCaseReferenceID(TestCaseReferenceID);
                        end;
                    }
                }
                part(Lines; "ADC Test Case Subform")
                {
                    Caption = 'Lines';
                    SubPageLink = "Document No." = field("Test Case ID");
                }
            }
        }
        area(FactBoxes)
        {
            part(TestSteps; "ADC Teststeps Factbox")
            {
                ApplicationArea = All;
                Caption = 'Steps';
                Provider = Lines;
                SubPageLink = "Document No." = field("Teststep ID");
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    var
        TestCaseDescription: Text;
        TestScenario: Text;
        TestCaseReferenceID: Text;

    trigger OnAfterGetRecord()
    begin
        TestCaseDescription := Rec.GetTestCaseDescription();
        TestScenario := Rec.GetTestScenario();
    end;
}
