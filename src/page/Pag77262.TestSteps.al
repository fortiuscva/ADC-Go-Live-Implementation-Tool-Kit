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
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
