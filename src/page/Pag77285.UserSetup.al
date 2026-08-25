page 77285 "ADC User Setup"
{
    ApplicationArea = All;
    Caption = 'User Setup (BC Support)';
    PageType = List;
    SourceTable = "ADC User Setup";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("User Group"; Rec."User Group")
                {
                    ToolTip = 'Specifies the value of the User Group field.', Comment = '%';
                }
            }
        }
    }
}
