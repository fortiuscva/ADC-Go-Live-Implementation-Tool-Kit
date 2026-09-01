page 77289 "ADC Test Step Lines"
{
    ApplicationArea = All;
    Caption = 'Test Step Lines';
    PageType = List;
    SourceTable = "ADC Test Step Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.', Comment = '%';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field("Test Step Description"; Rec."Test Step Description")
                {
                    ToolTip = 'Specifies the value of the Test Step Description field.', Comment = '%';
                }
            }
        }
    }
}
