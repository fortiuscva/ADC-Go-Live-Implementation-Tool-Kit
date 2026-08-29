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
                    ShowMandatory = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ShowMandatory = true;
                }
                field("No. Of Attached Test Steps"; Rec."No. Of Attached Test Steps")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the No. Of Attached Test Steps field.', Comment = '%';
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
                group(Categories)
                {
                    caption = 'Categories';
                    field(Category; Rec.Category)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                        ShowMandatory = true;
                    }
                    field("Sub Category"; Rec."Sub Category")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Sub Category field.', Comment = '%';
                        ShowMandatory = true;
                    }
                    field("Business Process"; Rec."Business Process")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Business Process field.', Comment = '%';
                        ShowMandatory = true;
                    }
                }
                group(Testing)
                {
                    caption = 'Testing';
                    field("Testing Type"; Rec."Testing Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Testing Type field.', Comment = '%';
                        ShowMandatory = true;
                    }
                    field("UAT Owner"; Rec."UAT Owner SignOff")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the UAT Owner field.', Comment = '%';
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

                }
                group(Training)
                {
                    caption = 'Training';
                    field("Training Category"; Rec."Training Category Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Training Category field.', Comment = '%';
                        Editable = false;
                    }
                    field("Training Session Code"; Rec."Training Session Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Training Session Code field.', Comment = '%';
                    }
                    field("Training Driven"; Rec."Training Driven")
                    {
                        ApplicationArea = All;
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
    actions
    {
        area(Processing)
        {
            action(CreateTestStep)
            {
                ApplicationArea = All;
                Caption = 'Create Test Step';
                Ellipsis = true;
                Image = Create;
                ToolTip = 'Creates a test step for this test case.';
                trigger OnAction()
                var
                    TestStepHeader: Record "ADC Test Step Header";
                begin
                    if not Confirm('Do you want to create a test step?') then
                        exit;
                    TestStepHeader.Init();
                    TestStepHeader."No." := GetNextTestStepNo();
                    TestStepHeader.Insert(true);
                    TestStepHeader.Validate("Default Test Case No.", Rec."No.");
                    TestStepHeader.Validate(Description, Rec.Description);
                    TestStepHeader.Modify(true);
                    Page.Run(page::"ADC Test Step", TestStepHeader);
                end;
            }
            action(OpenAttachedTestSteps)
            {
                ApplicationArea = All;
                Caption = 'Open Attached Test Steps';
                Ellipsis = true;
                Image = Open;
                ToolTip = 'Opens all test steps associated with this test case.';
                trigger OnAction()
                begin
                    TestStepHeaderRecGbl.Reset();
                    TestStepHeaderRecGbl.SetRange("Default Test Case No.", Rec."No.");
                    Page.Run(Page::"ADC Test Steps", TestStepHeaderRecGbl);
                end;
            }
            action(OpenRelatedTestSteps)
            {
                ApplicationArea = All;
                Caption = 'Open Related Test Steps';
                Ellipsis = true;
                Image = Open;
                ToolTip = 'Opens all related test steps associated with this test case description';
                trigger OnAction()
                begin
                    TestStepHeaderRecGbl.Reset();
                    TestStepHeaderRecGbl.SetRange(Description, Rec.Description);
                    Page.Run(Page::"ADC Test Steps", TestStepHeaderRecGbl);
                end;
            }
        }
        area(Promoted)
        {
            actionref(CreateTestStep_Promoted; CreateTestStep)
            {
            }
            actionref(OpenAttachedTestSteps_Promoted; OpenAttachedTestSteps)
            {
            }
            actionref(OpenRelativeTestSteps_Promoted; OpenRelatedTestSteps)
            {
            }

        }
    }
    var
        TestCaseDescription: Text;
        TestScenario: Text;
        TestCaseReferenceID: Text;
        TestStepHeaderRecGbl: Record "ADC Test Step Header";

    trigger OnAfterGetRecord()
    begin
        TestCaseDescription := Rec.GetTestCaseDescription();
        TestScenario := Rec.GetTestScenario();
    end;

    local procedure GetNextTestStepNo(): Code[20]
    begin
        TestStepHeaderRecGbl.Reset();
        TestStepHeaderRecGbl.SetRange("No.", Rec."No.");
        if not TestStepHeaderRecGbl.FindLast() then
            exit(Rec."No.")
        else
            exit(IncStr(TestStepHeaderRecGbl."No."));
    end;
}
