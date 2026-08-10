page 77264 "ADC Test Step Subform"
{
    ApplicationArea = All;
    Caption = 'Test Step Subform';
    PageType = ListPart;
    SourceTable = "ADC Test Step Line";
    UsageCategory = None;

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
