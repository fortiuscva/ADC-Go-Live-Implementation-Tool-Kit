page 77286 "ADC Task"
{
    ApplicationArea = All;
    Caption = 'Task (BC Support)';
    PageType = Card;
    SourceTable = "ADC Task";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ShowMandatory = true;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Type; Rec."Type")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
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
                group(TestCase)
                {
                    Caption = 'Test Case';
                    field("Test Case No."; Rec."Test Case No.")
                    {
                        ToolTip = 'Specifies the value of the Test Case No. field.', Comment = '%';
                    }
                    field("Test Case Line No."; Rec."Test Case Line No.")
                    {
                        ToolTip = 'Specifies the value of the Test Case Line No. field.', Comment = '%';
                    }
                }
            }
        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"ADC Task"), "No." = field("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
}
