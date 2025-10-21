page 77256 "Prod. Order Routing Line Stage"
{
    ApplicationArea = All;
    Caption = 'Prod. Order Routing Line Stage';
    PageType = List;
    SourceTable = "Prod. Order Routing Line Stage";
    UsageCategory = Lists;

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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order No. field.', Comment = '%';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ToolTip = 'Specifies the value of the Prod. Order Line No. field.', Comment = '%';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ToolTip = 'Specifies the value of the Routing No. field.', Comment = '%';
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    ToolTip = 'Specifies the value of the Routing Reference No. field.', Comment = '%';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ToolTip = 'Specifies the value of the Operation No. field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ToolTip = 'Specifies the value of the Routing Link Code field.', Comment = '%';
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ToolTip = 'Specifies the value of the Flushing Method field.', Comment = '%';
                }
                field("Previous Operation No."; Rec."Previous Operation No.")
                {
                    ToolTip = 'Specifies the value of the Previous Operation No. field.', Comment = '%';
                }
                field("Next Operation No."; Rec."Next Operation No.")
                {
                    ToolTip = 'Specifies the value of the Next Operation No. field.', Comment = '%';
                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
                field("Error Text"; Rec."Error Text")
                {
                    ToolTip = 'Specifies the value of the Error Text field.', Comment = '%';
                }
            }
        }
    }
}
