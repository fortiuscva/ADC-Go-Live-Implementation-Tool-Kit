page 77262 "ADC Test Steps"
{
    ApplicationArea = All;
    Caption = 'Test Steps';
    PageType = List;
    SourceTable = "ADC Test Step Header";
    CardPageId = "ADC Test Step";
    UsageCategory = Lists;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field("Default Test Case No."; Rec."Default Test Case No.")
                {
                    ToolTip = 'Specifies the value of the Default Test Case No. field.', Comment = '%';
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ToolTip = 'Specifies the value of the No. of Lines field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Data Points"; Rec."Data Points")
                {
                    ToolTip = 'Specifies the value of the Data Points/Test Data field.', Comment = '%';
                }
                field("Expected Result"; Rec."Expected Result")
                {
                    ToolTip = 'Specifies the value of the Expected Result field.', Comment = '%';
                }
            }
        }
    }
}
