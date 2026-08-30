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
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Assigned By"; Rec."Assigned By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned By.', Comment = '%';
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned Date.', Comment = '%';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assigned To field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
