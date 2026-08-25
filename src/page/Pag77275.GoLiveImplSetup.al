page 77275 "ADC Go Live Impl. Setup"
{
    ApplicationArea = All;
    Caption = 'Go-Live Implementation Setup';
    PageType = Card;
    SourceTable = "ADC Go Live Impl. Setup";
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Test Case Nos."; Rec."Test Case Nos.")
                {
                    ToolTip = 'Specifies the value of the Test Case Nos. field.', Comment = '%';
                    Visible = false;
                }
                field("Test Step Nos."; Rec."Test Step Nos.")
                {
                    ToolTip = 'Specifies the value of the Test Step Nos. field.', Comment = '%';
                    Visible = false;
                }
                field("Task Nos."; Rec."Task Nos.")
                {
                    ToolTip = 'Specifies the value of the Task Nos. field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }
}
