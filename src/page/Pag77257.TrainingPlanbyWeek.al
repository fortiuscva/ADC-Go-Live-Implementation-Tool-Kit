page 77257 "ADC Training Plan by Week"
{
    ApplicationArea = All;
    Caption = 'Training Plan by Week';
    PageType = List;
    SourceTable = "ADC Training Plan by Week";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Week field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.', Comment = '%';
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hours field.', Comment = '%';
                }
                field("Running Hours"; Rec."Running Hours")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Running Hours field.', Comment = '%';
                }
                field("No. of Sessions"; Rec."No. of Sessions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. of Sessions field.', Comment = '%';
                }
                field("Session Length"; Rec."Session Length")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Session Length field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Business Owner"; Rec."Business Owner")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Owner field.', Comment = '%';
                }
                field("Business Technical Owner"; Rec."Business Technical Owner")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Business Technical Owner field.', Comment = '%';
                }
                field(Trainer; Rec.Trainer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Trainer field.', Comment = '%';
                }
                field("Comments or Assumptions"; Rec."Comments or Assumptions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments or Assumptions field.', Comment = '%';
                }
                field("UAT Testcases"; Rec."UAT Testcases")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UAT Testcases field.', Comment = '%';
                }
                field("Target Audience"; Rec."Target Audience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Target Audience field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(DetailedTrainingPlan)
            {
                ApplicationArea = all;
                Caption = 'Detailed Training Plan';
                Ellipsis = true;
                Image = ViewDetails;
                trigger OnAction()
                begin
                    Page.Run(Page::"ADC Detailed Training Plan");
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(DetailedTrainingPlan_Promoted; DetailedTrainingPlan)
                {
                }
            }
        }
    }
}
