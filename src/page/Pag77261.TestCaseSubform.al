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
                    ToolTip = 'Specifies the value of the Test Case ID field.', Comment = '%';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field("Step ID"; Rec."Step ID")
                {
                    ToolTip = 'Specifies the value of the Test Steps field.', Comment = '%';
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("No. of Tasks"; Rec."No. of Tasks")
                {
                    ToolTip = 'Specifies the value of the No. of Tasks field.', Comment = '%';
                }
                field("Executed By"; Rec."Executed By")
                {
                    ToolTip = 'Specifies the value of the Executed By field.', Comment = '%';
                }
                field("Executed Date Time"; Rec."Executed Date Time")
                {
                    ToolTip = 'Specifies the value of the Executed Date Time field.', Comment = '%';
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
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
            action(OpenTasks)
            {
                ApplicationArea = All;
                Caption = 'Open Tasks';
                Ellipsis = true;
                Image = Open;
                trigger OnAction()
                var
                    Task: Record "ADC Task";
                begin
                    Task.Reset();
                    Task.FilterGroup := 8;
                    Task.SetRange("Test Case No.", Rec."Document No.");
                    Task.SetRange("Test Case Line No.", Rec."Line No.");
                    Page.Run(Page::"ADC Tasks", Task);
                end;
            }
        }
    }
}
