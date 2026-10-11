page 77290 "ADC Item Journal Posting Log"
{
    ApplicationArea = All;
    Caption = 'Item Journal Posting Log';
    PageType = List;
    SourceTable = "ADC Item Jounral posting Log";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Batch Name"; Rec."Batch Name")
                {
                    ToolTip = 'Specifies the value of the Batch Name field.', Comment = '%';
                }
                field("Journal Name"; Rec."Journal Name")
                {
                    ToolTip = 'Specifies the value of the Journal Name field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Error Msg"; Rec."Error Msg")
                {
                    ToolTip = 'Specifies the value of the Error Message field.', Comment = '%';
                }
            }
        }
    }
}
