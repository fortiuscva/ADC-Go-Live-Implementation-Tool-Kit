page 77286 "ADC Task"
{
    ApplicationArea = All;
    Caption = 'ADC Task';
    PageType = Card;
    SourceTable = "ADC Task";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    // trigger OnAssistEdit()
                    // begin
                    //     if Rec.AssistEdit(xRec) then
                    //         CurrPage.Update();
                    // end;
                }
                field("No.Series"; Rec."No.Series")
                {
                    ToolTip = 'Specifies the value of the No.Series field.', Comment = '%';
                }
            }
        }
    }
}
