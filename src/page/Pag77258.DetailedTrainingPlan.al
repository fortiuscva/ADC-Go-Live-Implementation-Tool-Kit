page 77258 "ADC Detailed Training Plan"
{
    ApplicationArea = All;
    Caption = 'Detailed Training Plan';
    PageType = List;
    SourceTable = "ADC Detailed Traning Plan";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field(Sequence; Rec.Sequence)
                {
                    ToolTip = 'Specifies the value of the Sequence field.', Comment = '%';
                }
                field("Training Session Code"; Rec."Training Session Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Training Session Code field.', Comment = '%';
                }
                field("Training Topic"; Rec."Training Topic")
                {
                    ToolTip = 'Specifies the value of the Training Topic field.', Comment = '%';
                }
                field(Length; Rec.Length)
                {
                    ToolTip = 'Specifies the value of the Length field.', Comment = '%';
                }
                field(Running; Rec.Running)
                {
                    ToolTip = 'Specifies the value of the Running field.', Comment = '%';
                }
                field("Company Applicability"; Rec."Company Applicability")
                {
                    ToolTip = 'Specifies the value of the Company Applicability field.', Comment = '%';
                }
                field("Business Scenario"; Rec."Business Scenario")
                {
                    ToolTip = 'Specifies the value of the Business Scenario field.', Comment = '%';
                }
                field("Business User"; Rec."Business User")
                {
                    ToolTip = 'Specifies the value of the Business User field.', Comment = '%';
                }
                field("Training Completion Status"; Rec."Training Completion Status")
                {
                    ToolTip = 'Specifies the value of the Training Completion Status field.', Comment = '%';
                }
                field("Training Completion Date"; Rec."Training Completion Date")
                {
                    ToolTip = 'Specifies the value of the Training Completion Date field.', Comment = '%';
                }
                field("Learning Link"; Rec."Learning Link")
                {
                    ToolTip = 'Specifies the value of the Learning Link field.', Comment = '%';
                }
                field("Learning Notes"; Rec."Learning Notes")
                {
                    ToolTip = 'Specifies the value of the Learning Notes field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ShowAssociatedTestCases)
            {
                ApplicationArea = all;
                Caption = 'Show Associated Test Cases';
                Ellipsis = true;
                Image = EditLines;
                trigger OnAction()
                var
                    TestCaseHeader: Record "ADC Test Case Header";
                begin
                    TestCaseHeader.Reset();
                    TestCaseHeader.FilterGroup := 8;
                    TestCaseHeader.SetRange("Training Session Code", Rec."Training Session Code");
                    Page.Run(Page::"ADC Test Cases", TestCaseHeader);
                end;
            }
            action(ShowAllTestCases)
            {
                ApplicationArea = all;
                Caption = 'Show All Test Cases';
                Ellipsis = true;
                Image = EditLines;
                trigger OnAction()
                begin
                    Page.Run(Page::"ADC Test Cases");
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(ShowAssociatedTestCases_Promoted; ShowAssociatedTestCases)
                {
                }
                actionref(ShowAllTestCases_Promoted; ShowAllTestCases)
                {
                }
            }
        }
    }
}
