page 77260 "ADC Test Case"
{
    ApplicationArea = All;
    Caption = 'Test Case';
    PageType = Document;
    SourceTable = "ADC Test Case Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Business SignOff Owner"; Rec."Business SignOff Owner")
                {
                    ToolTip = 'Specifies the value of the Business SignOff Owner field.', Comment = '%';
                }
                field("Go-Live Critical"; Rec."Go-Live Critical")
                {
                    ToolTip = 'Specifies the value of the Go-Live Critical field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }
                field(TestScenario; TestScenario)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the scenario of the test case.', Comment = '%';
                    visible = false;
                    trigger OnValidate()
                    begin
                        Rec.SetTestScenario(TestScenario);
                    end;
                }
                field(TestCaseDescription; TestCaseDescription)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the description of the test case.';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.SetTestCaseDescription(TestCaseDescription);
                    end;
                }
                field(TestCaseReferenceID; TestCaseReferenceID)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the Reference ID/JIRA ID of the test case.';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.SetTestCaseReferenceID(TestCaseReferenceID);
                    end;
                }
                group(Categories)
                {
                    caption = 'Categories';
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
                }
                group(Testing)
                {
                    caption = 'Testing';
                    field("Testing Type"; Rec."Testing Type")
                    {
                        ToolTip = 'Specifies the value of the Testing Type field.', Comment = '%';
                    }
                    field("UAT Owner"; Rec."UAT Owner")
                    {
                        ToolTip = 'Specifies the value of the UAT Owner field.', Comment = '%';
                    }
                    field("UAT Execution Status"; Rec."UAT Execution Status")
                    {
                        ToolTip = 'Specifies the value of the UAT Execution Status field.', Comment = '%';
                    }
                    field("Signoff Status"; Rec."Signoff Status")
                    {
                        ToolTip = 'Specifies the value of the Signoff Status field.', Comment = '%';
                    }

                }
                group(Training)
                {
                    caption = 'Training';
                    field("Training Session Code"; Rec."Training Session Code")
                    {
                        ToolTip = 'Specifies the value of the Training Session Code field.', Comment = '%';
                    }
                    field("Training Driven"; Rec."Training Driven")
                    {
                        ToolTip = 'Specifies the value of the Training Driven field.', Comment = '%';
                    }
                }
            }
            part(Lines; "ADC Test Case Subform")
            {
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(FactBoxes)
        {
            part(TestSteps; "ADC Teststeps Factbox")
            {
                ApplicationArea = All;
                Caption = 'Steps';
                Provider = Lines;
                SubPageLink = "Document No." = field("Step ID");
            }
            part(TestCaseLines; "ADC Test Case Line Factbox")
            {
                ApplicationArea = All;
                Caption = 'Data Points & Results';
                Provider = Lines;
                SubPageLink = "Document No." = field("Document No."), "Line No." = field("Line No.");
            }
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"ADC Test Case Header"), "No." = field("No.");
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
