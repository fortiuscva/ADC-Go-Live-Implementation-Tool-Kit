page 77261 "ADC Test Case Subform"
{
    ApplicationArea = All;
    Caption = 'Test Case Subform';
    PageType = ListPart;
    SourceTable = "ADC Test Case Line";
    UsageCategory = None;
    AutoSplitKey = true;
    // DelayedInsert = true;

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
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field("Step ID"; Rec."Step ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Steps field.', Comment = '%';
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Assigned To field.', Comment = '%';
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Assigned Date field.', Comment = '%';
                }
                field("Target Completion Date"; Rec."Target Completion Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Training Completion Date field.', Comment = '%';
                }
                field("Tested in Company"; Rec."Tested in Company")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Tested in Company field.', Comment = '%';
                }
                field("Executed By"; Rec."Executed By")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Executed By field.', Comment = '%';
                }
                field("Executed Date Time"; Rec."Executed Date Time")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Executed Date Time field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AssignSteps)
            {
                ApplicationArea = All;
                Caption = 'Assign Test Steps to the Users';
                Ellipsis = true;
                Image = Process;
                trigger OnAction()
                var
                    TempSelectedUsers: Record "ADC Test Step User Selection" temporary;
                    AssignTestSteps: Page "ADC Assign Test Steps";
                    TestCaseAssignMgt: Codeunit "ADC Test Case Assignment Mgt.";
                    SelectedTestStepID: Code[20];
                    TargetCompletionDate: Date;
                begin
                    if not Confirm('Do you want to assign test steps to the users?') then
                        exit;

                    CurrPage.SaveRecord();

                    Clear(AssignTestSteps);
                    AssignTestSteps.LookupMode(true);

                    if AssignTestSteps.RunModal() = Action::LookupOK then begin
                        SelectedTestStepID := AssignTestSteps.GetTestStepID();

                        TargetCompletionDate := AssignTestSteps.GetTargetCompletionDate();

                        AssignTestSteps.GetSelectedUsers(TempSelectedUsers);

                        TestCaseAssignMgt.CreateLinesForSelectedUsers(Rec."Document No.", SelectedTestStepID, TargetCompletionDate, TempSelectedUsers);

                        CurrPage.Update(false);
                    end;
                end;
            }
            action(OpenResults)
            {
                ApplicationArea = All;
                Caption = 'Open Data Points & Results';
                Ellipsis = true;
                Image = Open;
                trigger OnAction()
                begin
                    Page.Run(Page::"ADC Test Case Results", Rec);
                end;
            }
            group("&Tasks")
            {
                Caption = 'Tasks';
                Image = Task;
                action(OpenTasks)
                {
                    ApplicationArea = All;
                    Caption = 'Open Tasks';
                    Ellipsis = true;
                    Image = TaskList;
                    trigger OnAction()
                    begin
                        TaskGbl.Reset();
                        TaskGbl.FilterGroup := 8;
                        TaskGbl.SetRange("Test Case No.", Rec."Document No.");
                        TaskGbl.SetRange("Test Case Line No.", Rec."Line No.");
                        Page.Run(Page::"ADC Tasks", TaskGbl);
                    end;
                }
                action(CreateTask)
                {
                    ApplicationArea = All;
                    Caption = 'Create Task';
                    Ellipsis = true;
                    Image = Task;
                    trigger OnAction()
                    var
                        Functions: Codeunit "ADC Go Live Functions";
                    begin
                        if not Confirm('Do you want to create a task?') then
                            exit;
                        Functions.CreateTaskForTestCaseLine(Rec, true);
                    end;
                }
                action(ShowAllTasks)
                {
                    ApplicationArea = All;
                    Caption = 'Show All Tasks';
                    Ellipsis = true;
                    Image = Task;
                    trigger OnAction()
                    begin
                        TaskGbl.Reset();
                        Page.Run(Page::"ADC Tasks", TaskGbl);
                    end;
                }
            }
            group("&Steps")
            {
                Caption = 'Steps';
                Image = StepInto;
                action(ShowAllTestSteps)
                {
                    ApplicationArea = All;
                    Caption = 'Show All Test Steps';
                    Ellipsis = true;
                    Image = ShowList;
                    trigger OnAction()
                    begin
                        Page.Run(Page::"ADC Test Steps");
                    end;
                }
                action(OpenTestStep)
                {
                    ApplicationArea = All;
                    Caption = 'Open Test Step';
                    Ellipsis = true;
                    Image = Open;
                    trigger OnAction()
                    var
                        TestStepHeader: Record "ADC Test Step Header";
                    begin
                        if not TestStepHeader.Get(Rec."Step ID") then
                            exit;
                        Page.Run(Page::"ADC Test Step", TestStepHeader)
                    end;
                }
            }
        }
    }
    var
        TaskGbl: Record "ADC Task";
}
