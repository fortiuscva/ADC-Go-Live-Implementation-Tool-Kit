page 77275 "ADC Go Live Impl. Setup"
{
    ApplicationArea = All;
    Caption = 'Go-Live Implementation Setup';
    PageType = Card;
    SourceTable = "ADC Go Live Impl. Setup";
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';

                field("Test Case Nos."; Rec."Test Case Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Case Nos. field.', Comment = '%';
                    Visible = false;
                }
                field("Test Step Nos."; Rec."Test Step Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test Step Nos. field.', Comment = '%';
                    Visible = false;
                }
                field("Task Nos."; Rec."Task Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task Nos. field.', Comment = '%';
                    Visible = false;
                }
                field("Last Test Case No."; Rec."Last Test Case No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Test Case No. field.', Comment = '%';
                }
                field("Last Step No."; Rec."Last Test Step No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Step No. field.', Comment = '%';
                }
                field("Last Task No."; Rec."Last Task No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Task No. field.', Comment = '%';
                }
                field("Test Steps Line Separator"; Rec."Test Steps Line Separator")
                {
                    ToolTip = 'Specifies the value of the Test Steps Line Separator field.', Comment = '%';
                }
                field("Specific Separator"; Rec."Specific Separator")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Specific Separator field.', Comment = '%';
                    Editable = ShowSpecificSeparator;
                    Visible = ShowSpecificSeparator;

                }
            }
        }
    }
    var
        ShowSpecificSeparator: Boolean;

    trigger OnAfterGetRecord()
    begin
        ShowSpecificSeparator := (Rec."Test Steps Line Separator" = Rec."Test Steps Line Separator"::Other);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ShowSpecificSeparator := (Rec."Test Steps Line Separator" = Rec."Test Steps Line Separator"::Other);
    end;
}
