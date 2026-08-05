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
                    ToolTip = 'Specifies the value of the Week field.', Comment = '%';
                }
                field(Details; Rec.Details)
                {
                    ToolTip = 'Specifies the value of the Details field.', Comment = '%';
                }
                field("Category Code"; Rec."Category Code")
                {
                    ToolTip = 'Specifies the value of the Category Code field.', Comment = '%';
                }
                field(Hours; Rec.Hours)
                {
                    ToolTip = 'Specifies the value of the Hours field.', Comment = '%';
                }
                field("Running Hours"; Rec."Running Hours")
                {
                    ToolTip = 'Specifies the value of the Running Hours field.', Comment = '%';
                }
                field("No. of Sessions"; Rec."No. of Sessions")
                {
                    ToolTip = 'Specifies the value of the No. of Sessions field.', Comment = '%';
                }
                field("Session Length"; Rec."Session Length")
                {
                    ToolTip = 'Specifies the value of the Session Length field.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Business Owner"; Rec."Business Owner")
                {
                    ToolTip = 'Specifies the value of the Business Owner field.', Comment = '%';
                }
                field("Business Technical Owner"; Rec."Business Technical Owner")
                {
                    ToolTip = 'Specifies the value of the Business Technical Owner field.', Comment = '%';
                }
                field(Trainer; Rec.Trainer)
                {
                    ToolTip = 'Specifies the value of the Trainer field.', Comment = '%';
                }
                field("Comments or Assumptions"; Rec."Comments or Assumptions")
                {
                    ToolTip = 'Specifies the value of the Comments or Assumptions field.', Comment = '%';
                }
                field("UAT Testcases"; Rec."UAT Testcases")
                {
                    ToolTip = 'Specifies the value of the UAT Testcases field.', Comment = '%';
                }
                field("Target Audience"; Rec."Target Audience")
                {
                    ToolTip = 'Specifies the value of the Target Audience field.', Comment = '%';
                }
            }
        }
    }
}
