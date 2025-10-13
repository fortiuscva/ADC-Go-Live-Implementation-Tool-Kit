page 77255 "ADC Prod. Order Comp. Stage"
{
    ApplicationArea = All;
    Caption = 'ADC Prod. Order Comp. Stage';
    PageType = List;
    SourceTable = "ADC Prod. Order Comp. Stage";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Quantity Per"; Rec."Quantity Per")
                {
                    ToolTip = 'Specifies the value of the Quantity Per field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the value of the Bin Code field.', Comment = '%';
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
