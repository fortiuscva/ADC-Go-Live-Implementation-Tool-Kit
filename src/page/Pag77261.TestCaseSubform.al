page 77261 "ADC Test Case Subform"
{
    ApplicationArea = All;
    Caption = 'Test Case Subform';
    PageType = ListPart;
    SourceTable = "ADC Test Case Line";
    UsageCategory = None;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Test Case ID"; Rec."Test Case ID")
                {
                    ToolTip = 'Specifies the value of the Test Case ID field.', Comment = '%';
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                    Visible = false;
                }
                field("Data Points"; Rec."Data Points")
                {
                    ToolTip = 'Specifies the value of the Data Points/Test Data field.', Comment = '%';
                }
                field("Test Steps"; Rec."Test Steps")
                {
                    ToolTip = 'Specifies the value of the Test Steps field.', Comment = '%';
                }
                field("Expected Result"; Rec."Expected Result")
                {
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
                field("Actual Result"; Rec."Actual Result")
                {
                    ToolTip = 'Specifies the value of the Actual Result field.', Comment = '%';
                }
            }
        }
    }
}
