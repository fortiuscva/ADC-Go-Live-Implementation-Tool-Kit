page 77283 "ADC All Tasks"
{
    ApplicationArea = All;
    Caption = 'All Tasks';
    PageType = List;
    SourceTable = "ADC Task";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Assigned By"; Rec."Assigned By")
                {
                    ToolTip = 'Specifies the value of the Assigned By.', Comment = '%';
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ToolTip = 'Specifies the value of the Assigned Date.', Comment = '%';
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
