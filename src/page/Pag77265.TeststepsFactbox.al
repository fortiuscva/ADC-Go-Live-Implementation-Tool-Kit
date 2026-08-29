page 77265 "ADC Teststeps Factbox"
{
    ApplicationArea = All;
    Caption = 'Teststeps Factbox';
    PageType = ListPart;
    DeleteAllowed = false;
    SourceTable = "ADC Test Step Line";

    layout
    {
        area(Content)
        {
            repeater(Teststeps)
            {
                ShowCaption = false;
                field("Test Step Description"; Rec."Test Step Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ShowDocument)
            {
                ApplicationArea = all;
                Caption = 'Show Document';
                Image = EditLines;
                Ellipsis = true;
                RunObject = Page "ADC Test Step";
                RunPageLink = "No." = field("Document No.");
            }
        }
    }
}
