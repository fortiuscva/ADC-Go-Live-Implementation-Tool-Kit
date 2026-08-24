page 77285 "ADC BC SupportTasks"
{
    ApplicationArea = All;
    Caption = 'BC SupportTasks';
    PageType = List;
    SourceTable = "ADC Task";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Test Case No."; Rec."Test Case No.")
                {
                    ToolTip = 'Specifies the value of the Test Case No. field.', Comment = '%';
                }
                field("Test Case Line No."; Rec."Test Case Line No.")
                {
                    ToolTip = 'Specifies the value of the Test Case Line No. field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ToolTip = 'Specifies the value of the Assigned To field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
